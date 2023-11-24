Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD37F6A02
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjKXBDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:03:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F91B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:03:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7454C433C8;
        Fri, 24 Nov 2023 01:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700787791;
        bh=MK5tjkjB52MplO5zrLGX/U/QKetESX/No8t7aMgG+PE=;
        h=From:To:Cc:Subject:Date:From;
        b=DuOxk/DRRLcNBbp2QjtM0XWSEBjeNGb3i/iSFwfdsRhmFFcZ4J/kMkEAlTVwMA5wc
         IWAg2Iux0WS3sJAnKFWuet3UQsfQt0/WxY3MXcSRqk2IIUnBY9/zKNVgj89K6mWPsy
         6TFrUBPY3bMsYNwqxySVEdx0OT1OGnBwQ9KLfGGuvc++4zjT84wGAf3Tx2PEa7HjIx
         eCjSJd0Ls67dDcSR8FhPlJ+6CLYNYClJCSmdjixCWA5gYEs1kGTScRoqWLncyYwKqO
         no//WB50pWt1jwcGPjIR3gd7dNKQMXE6GJZMrnYcm66XwlxHMbJky32mNDIlgcre3E
         DcM+dZO8WQYcw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [PATCH] rethook: Use __rcu pointer for rethook::handler
Date:   Fri, 24 Nov 2023 10:03:06 +0900
Message-Id: <170078778632.209874.7893551840863388753.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the rethook::handler is an RCU-maganged pointer so that it will
notice readers the rethook is stopped (unregistered) or not, it should
be an __rcu pointer and use appropriate functions to be accessed. This
will use appropriate memory barrier when accessing it. OTOH, rethook::data
is never changed, so we don't need to check it in get_kretprobe().

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    6 ++----
 include/linux/rethook.h |    2 +-
 kernel/trace/rethook.c  |   21 ++++++++++++---------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 64672bace560..0ff44d6633e3 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -197,10 +197,8 @@ extern int arch_trampoline_kprobe(struct kprobe *p);
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
-		"Kretprobe is accessed from instance under preemptive context");
-
-	return (struct kretprobe *)READ_ONCE(ri->node.rethook->data);
+	/* rethook::data is non-changed field, so that you can access it freely. */
+	return (struct kretprobe *)ri->node.rethook->data;
 }
 static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
 {
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index ce69b2b7bc35..164cd32c25cd 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -28,7 +28,7 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long,
  */
 struct rethook {
 	void			*data;
-	rethook_handler_t	handler;
+	rethook_handler_t __rcu handler;
 	struct objpool_head	pool;
 	struct rcu_head		rcu;
 };
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 6fd7d4ecbbc6..77f0e987bbff 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -48,7 +48,7 @@ static void rethook_free_rcu(struct rcu_head *head)
  */
 void rethook_stop(struct rethook *rh)
 {
-	WRITE_ONCE(rh->handler, NULL);
+	rcu_assign_pointer(rh->handler, NULL);
 }
 
 /**
@@ -63,7 +63,7 @@ void rethook_stop(struct rethook *rh)
  */
 void rethook_free(struct rethook *rh)
 {
-	WRITE_ONCE(rh->handler, NULL);
+	rcu_assign_pointer(rh->handler, NULL);
 
 	call_rcu(&rh->rcu, rethook_free_rcu);
 }
@@ -107,7 +107,7 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler,
 		return ERR_PTR(-ENOMEM);
 
 	rh->data = data;
-	rh->handler = handler;
+	rcu_assign_pointer(rh->handler, handler);
 
 	/* initialize the objpool for rethook nodes */
 	if (objpool_init(&rh->pool, num, size, GFP_KERNEL, rh,
@@ -135,9 +135,12 @@ static void free_rethook_node_rcu(struct rcu_head *head)
  */
 void rethook_recycle(struct rethook_node *node)
 {
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler;
+
+	handler = rcu_dereference_check(node->rethook->handler,
+					rcu_read_lock_any_held());
 
-	if (likely(READ_ONCE(node->rethook->handler)))
+	if (likely(handler))
 		objpool_push(node, &node->rethook->pool);
 	else
 		call_rcu(&node->rcu, free_rethook_node_rcu);
@@ -153,10 +156,9 @@ NOKPROBE_SYMBOL(rethook_recycle);
  */
 struct rethook_node *rethook_try_get(struct rethook *rh)
 {
-	rethook_handler_t handler = READ_ONCE(rh->handler);
-
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler;
 
+	handler = rcu_dereference_check(rh->handler, rcu_read_lock_any_held());
 	/* Check whether @rh is going to be freed. */
 	if (unlikely(!handler))
 		return NULL;
@@ -300,7 +302,8 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		rhn = container_of(first, struct rethook_node, llist);
 		if (WARN_ON_ONCE(rhn->frame != frame))
 			break;
-		handler = READ_ONCE(rhn->rethook->handler);
+		handler = rcu_dereference_check(rhn->rethook->handler,
+						rcu_read_lock_any_held());
 		if (handler)
 			handler(rhn, rhn->rethook->data,
 				correct_ret_addr, regs);

