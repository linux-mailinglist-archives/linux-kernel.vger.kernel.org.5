Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1FA81106B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378126AbjLMLqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjLMLp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:45:59 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F2AF5;
        Wed, 13 Dec 2023 03:46:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyQzxuB_1702467960;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VyQzxuB_1702467960)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 19:46:02 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [RFC nf-next 1/2] netfilter: bpf: support prog update
Date:   Wed, 13 Dec 2023 19:45:44 +0800
Message-Id: <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

To support the prog update, we need to ensure that the prog seen
within the hook is always valid. Considering that hooks are always
protected by rcu_read_lock(), which provide us the ability to use a
new RCU-protected context to access the prog.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/netfilter/nf_bpf_link.c | 124 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index e502ec0..918c470 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -8,17 +8,11 @@
 #include <net/netfilter/nf_bpf_link.h>
 #include <uapi/linux/netfilter_ipv4.h>
 
-static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
-				    const struct nf_hook_state *s)
+struct bpf_nf_hook_ctx
 {
-	const struct bpf_prog *prog = bpf_prog;
-	struct bpf_nf_ctx ctx = {
-		.state = s,
-		.skb = skb,
-	};
-
-	return bpf_prog_run(prog, &ctx);
-}
+	struct bpf_prog *prog;
+	struct rcu_head rcu;
+};
 
 struct bpf_nf_link {
 	struct bpf_link link;
@@ -26,8 +20,59 @@ struct bpf_nf_link {
 	struct net *net;
 	u32 dead;
 	const struct nf_defrag_hook *defrag_hook;
+	/* protect link update in parallel */
+	struct mutex update_lock;
+	struct bpf_nf_hook_ctx __rcu *hook_ctx;
 };
 
+static struct bpf_nf_hook_ctx *
+bpf_nf_hook_ctx_from_prog(struct bpf_prog *prog, gfp_t flags)
+{
+	struct bpf_nf_hook_ctx *hook_ctx;
+
+	hook_ctx = kmalloc(sizeof(*hook_ctx), flags);
+	if (hook_ctx) {
+		hook_ctx->prog = prog;
+		bpf_prog_inc(prog);
+	}
+	return hook_ctx;
+}
+
+static void bpf_nf_hook_ctx_free(struct bpf_nf_hook_ctx *hook_ctx)
+{
+	if (!hook_ctx)
+		return;
+	if (hook_ctx->prog)
+		bpf_prog_put(hook_ctx->prog);
+	kfree(hook_ctx);
+}
+
+static void __bpf_nf_hook_ctx_free_rcu(struct rcu_head *head)
+{
+	struct bpf_nf_hook_ctx *hook_ctx = container_of(head, struct bpf_nf_hook_ctx, rcu);
+
+	bpf_nf_hook_ctx_free(hook_ctx);
+}
+
+static void bpf_nf_hook_ctx_free_rcu(struct bpf_nf_hook_ctx *hook_ctx)
+{
+	call_rcu(&hook_ctx->rcu, __bpf_nf_hook_ctx_free_rcu);
+}
+
+static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
+				    const struct nf_hook_state *s)
+{
+	const struct bpf_nf_link *link = bpf_link;
+	struct bpf_nf_hook_ctx *hook_ctx;
+	struct bpf_nf_ctx ctx = {
+		.state = s,
+		.skb = skb,
+	};
+
+	hook_ctx = rcu_dereference(link->hook_ctx);
+	return bpf_prog_run(hook_ctx->prog, &ctx);
+}
+
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 static const struct nf_defrag_hook *
 get_proto_defrag_hook(struct bpf_nf_link *link,
@@ -120,6 +165,10 @@ static void bpf_nf_link_release(struct bpf_link *link)
 	if (!cmpxchg(&nf_link->dead, 0, 1)) {
 		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
 		bpf_nf_disable_defrag(nf_link);
+		/* Wait for outstanding hook to complete before the
+		 * link gets released.
+		 */
+		synchronize_rcu();
 	}
 }
 
@@ -127,6 +176,7 @@ static void bpf_nf_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
 
+	bpf_nf_hook_ctx_free(nf_link->hook_ctx);
 	kfree(nf_link);
 }
 
@@ -162,7 +212,42 @@ static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
 static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 			      struct bpf_prog *old_prog)
 {
-	return -EOPNOTSUPP;
+	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
+	struct bpf_nf_hook_ctx *hook_ctx;
+	int err = 0;
+
+	mutex_lock(&nf_link->update_lock);
+
+	/* target old_prog mismatch */
+	if (old_prog && link->prog != old_prog) {
+		err = -EPERM;
+		goto out;
+	}
+
+	old_prog = link->prog;
+	if (old_prog == new_prog) {
+		/* don't need update */
+		bpf_prog_put(new_prog);
+		goto out;
+	}
+
+	hook_ctx = bpf_nf_hook_ctx_from_prog(new_prog, GFP_USER);
+	if (!hook_ctx) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* replace and get the old one */
+	hook_ctx = rcu_replace_pointer(nf_link->hook_ctx, hook_ctx,
+				       lockdep_is_held(&nf_link->update_lock));
+	/* free old hook_ctx */
+	bpf_nf_hook_ctx_free_rcu(hook_ctx);
+
+	old_prog = xchg(&link->prog, new_prog);
+	bpf_prog_put(old_prog);
+out:
+	mutex_unlock(&nf_link->update_lock);
+	return err;
 }
 
 static const struct bpf_link_ops bpf_nf_link_lops = {
@@ -222,11 +307,22 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!link)
 		return -ENOMEM;
 
+	link->hook_ctx = bpf_nf_hook_ctx_from_prog(prog, GFP_USER);
+	if (!link->hook_ctx) {
+		kfree(link);
+		return -ENOMEM;
+	}
+
 	bpf_link_init(&link->link, BPF_LINK_TYPE_NETFILTER, &bpf_nf_link_lops, prog);
 
 	link->hook_ops.hook = nf_hook_run_bpf;
 	link->hook_ops.hook_ops_type = NF_HOOK_OP_BPF;
-	link->hook_ops.priv = prog;
+
+	/* bpf_nf_link_release() ensures that after its execution, there will be
+	 * no ongoing or upcoming execution of nf_hook_run_bpf() within any context.
+	 * Therefore, within nf_hook_run_bpf(), the link remains valid at all times."
+	 */
+	link->hook_ops.priv = link;
 
 	link->hook_ops.pf = attr->link_create.netfilter.pf;
 	link->hook_ops.priority = attr->link_create.netfilter.priority;
@@ -236,9 +332,11 @@ int bpf_nf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	link->dead = false;
 	link->defrag_hook = NULL;
 
+	mutex_init(&link->update_lock);
+
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err) {
-		kfree(link);
+		bpf_nf_link_dealloc(&link->link);
 		return err;
 	}
 
-- 
1.8.3.1

