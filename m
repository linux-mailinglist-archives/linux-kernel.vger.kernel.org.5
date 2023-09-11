Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD479A45C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjIKHUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIKHUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:20:44 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359FCD1;
        Mon, 11 Sep 2023 00:20:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VrnhdfX_1694416820;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VrnhdfX_1694416820)
          by smtp.aliyun-inc.com;
          Mon, 11 Sep 2023 15:20:34 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net/smc: Introduce SMC-related proc files
Date:   Mon, 11 Sep 2023 15:20:20 +0800
Message-Id: <1694416820-60340-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces /proc/net/smc4 and /proc/net/smc6 files to report
statistic information of SMC connections.

Compared with 'smcss' command in smc-tools, getting SMC connections via
proc files is not efficient. However, in some container scenarios, some
dependencies are lacked for compiling and using smc-tools. In this case,
using proc files to check SMC connections becomes a simple and fast way.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/net/smc.h  |   5 +-
 net/smc/Makefile   |   2 +-
 net/smc/af_smc.c   |  22 ++++-
 net/smc/smc_diag.c |  29 +++---
 net/smc/smc_proc.c | 283 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_proc.h |  35 +++++++
 6 files changed, 355 insertions(+), 21 deletions(-)
 create mode 100644 net/smc/smc_proc.c
 create mode 100644 net/smc/smc_proc.h

diff --git a/include/net/smc.h b/include/net/smc.h
index a002552..d29b332 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -20,10 +20,13 @@
 struct sock;
 
 #define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
+#define SMC_HTABLE_SHIFT	9
+#define SMC_HTABLE_SIZE	(1 << SMC_HTABLE_SHIFT) /* Size of SMC hashtable buckets */
 
 struct smc_hashinfo {
+	unsigned int bkt_idx;
 	rwlock_t lock;
-	struct hlist_head ht;
+	struct hlist_head ht[SMC_HTABLE_SIZE];
 };
 
 int smc_hash_sk(struct sock *sk);
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 875efcd..956810a 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -4,5 +4,5 @@ obj-$(CONFIG_SMC)	+= smc.o
 obj-$(CONFIG_SMC_DIAG)	+= smc_diag.o
 smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
 smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
-smc-y += smc_tracepoint.o
+smc-y += smc_tracepoint.o smc_proc.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd97..616f9a9 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -53,6 +53,7 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
+#include "smc_proc.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -182,9 +183,8 @@ int smc_hash_sk(struct sock *sk)
 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
 	struct hlist_head *head;
 
-	head = &h->ht;
-
 	write_lock_bh(&h->lock);
+	head = &h->ht[h->bkt_idx++ & (SMC_HTABLE_SIZE - 1)];
 	sk_add_node(sk, head);
 	write_unlock_bh(&h->lock);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -3448,7 +3448,7 @@ static void __net_exit smc_net_stat_exit(struct net *net)
 
 static int __init smc_init(void)
 {
-	int rc;
+	int rc, i;
 
 	rc = register_pernet_subsys(&smc_net_ops);
 	if (rc)
@@ -3520,8 +3520,11 @@ static int __init smc_init(void)
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
 		goto out_proto6;
 	}
-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
+
+	for (i = 0; i < SMC_HTABLE_SIZE; i++) {
+		INIT_HLIST_HEAD(&smc_v4_hashinfo.ht[i]);
+		INIT_HLIST_HEAD(&smc_v6_hashinfo.ht[i]);
+	}
 
 	rc = smc_ib_register_client();
 	if (rc) {
@@ -3535,9 +3538,17 @@ static int __init smc_init(void)
 		goto out_ib;
 	}
 
+	rc = smc_proc_init();
+	if (rc) {
+		pr_err("%s: smc_proc_init fails with %d\n", __func__, rc);
+		goto out_ulp;
+	}
+
 	static_branch_enable(&tcp_have_smc);
 	return 0;
 
+out_ulp:
+	tcp_unregister_ulp(&smc_ulp_ops);
 out_ib:
 	smc_ib_unregister_client();
 out_sock:
@@ -3572,6 +3583,7 @@ static int __init smc_init(void)
 static void __exit smc_exit(void)
 {
 	static_branch_disable(&tcp_have_smc);
+	smc_proc_exit();
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 7ff2152..8f2f8b8 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -197,24 +197,25 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 	int snum = cb_ctx->pos[p_type];
 	struct nlattr *bc = NULL;
 	struct hlist_head *head;
-	int rc = 0, num = 0;
+	int rc = 0, num = 0, slot;
 	struct sock *sk;
 
 	read_lock(&prot->h.smc_hash->lock);
-	head = &prot->h.smc_hash->ht;
-	if (hlist_empty(head))
-		goto out;
-
-	sk_for_each(sk, head) {
-		if (!net_eq(sock_net(sk), net))
-			continue;
-		if (num < snum)
-			goto next;
-		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
-		if (rc < 0)
-			goto out;
+
+	for (slot = 0; slot < SMC_HTABLE_SIZE; slot++) {
+		head = &prot->h.smc_hash->ht[slot];
+
+		sk_for_each(sk, head) {
+			if (!net_eq(sock_net(sk), net))
+				continue;
+			if (num < snum)
+				goto next;
+			rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
+			if (rc < 0)
+				goto out;
 next:
-		num++;
+			num++;
+		}
 	}
 
 out:
diff --git a/net/smc/smc_proc.c b/net/smc/smc_proc.c
new file mode 100644
index 0000000..6436b58
--- /dev/null
+++ b/net/smc/smc_proc.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include "smc.h"
+#include "smc_proc.h"
+#include "smc_core.h"
+
+static void *smc_proc_get_next(struct seq_file *seq, void *cur)
+{
+	struct smc_proc_private *sp = seq->private;
+	struct smc_hashinfo *smc_hash =
+		sp->protocol == SMCPROTO_SMC ?
+		smc_proto.h.smc_hash : smc_proto6.h.smc_hash;
+	struct net *net = seq_file_net(seq);
+	struct hlist_head *head;
+	struct sock *sk = cur;
+
+	if (!sk) {
+		read_lock(&smc_hash->lock);
+get_head:
+		head = &smc_hash->ht[sp->bucket];
+		sk = sk_head(head);
+		sp->offset = 0;
+		goto get_sk;
+	}
+	++sp->num;
+	++sp->offset;
+
+	sk = sk_next(sk);
+get_sk:
+	sk_for_each_from(sk) {
+		if (!net_eq(sock_net(sk), net))
+			continue;
+		return sk;
+	}
+	sp->offset = 0;
+	if (++sp->bucket < SMC_HTABLE_SIZE)
+		goto get_head;
+
+	read_unlock(&smc_hash->lock);
+	return NULL;
+}
+
+static void *smc_proc_seek_last_pos(struct seq_file *seq)
+{
+	struct smc_proc_private *sp = seq->private;
+	int offset = sp->offset;
+	int orig_num = sp->num;
+	void *rc = NULL;
+
+	if (sp->bucket >= SMC_HTABLE_SIZE)
+		goto out;
+
+	rc = smc_proc_get_next(seq, NULL);
+	while (offset-- && rc)
+		rc = smc_proc_get_next(seq, rc);
+
+	if (rc)
+		goto out;
+
+	sp->bucket = 0;
+out:
+	sp->num = orig_num;
+	return rc;
+}
+
+static void *smc_proc_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct smc_proc_private *sp = seq->private;
+	void *rc;
+
+	sp->bucket = 0;
+	rc = smc_proc_get_next(seq, NULL);
+
+	while (rc && pos) {
+		rc = smc_proc_get_next(seq, rc);
+		--pos;
+	}
+	return rc;
+}
+
+static void *__smc_proc_conn_start(struct seq_file *seq, loff_t *pos, int protocol)
+{
+	struct smc_proc_private *sp = seq->private;
+	void *rc;
+
+	if (*pos && *pos == sp->last_pos) {
+		rc = smc_proc_seek_last_pos(seq);
+		if (rc)
+			goto out;
+	}
+
+	sp->num = 0;
+	sp->bucket = 0;
+	sp->offset = 0;
+	sp->protocol = protocol;
+	rc = *pos ? smc_proc_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
+
+out:
+	sp->last_pos = *pos;
+	return rc;
+}
+
+static void *smc_proc_conn4_start(struct seq_file *seq, loff_t *pos)
+{
+	return __smc_proc_conn_start(seq, pos, SMCPROTO_SMC);
+}
+
+static void *smc_proc_conn6_start(struct seq_file *seq, loff_t *pos)
+{
+	return __smc_proc_conn_start(seq, pos, SMCPROTO_SMC6);
+}
+
+static void __smc_proc_conn_show(struct seq_file *seq, struct smc_sock *smc, int protocol)
+{
+	struct smc_proc_private *sp = seq->private;
+	const struct in6_addr *dest, *src;
+	struct smc_link_group *lgr;
+	struct socket *clcsock;
+	struct smc_link *lnk;
+	struct sock *sk;
+	bool fb = false;
+	int i;
+
+	fb = smc->use_fallback;
+	clcsock = smc->clcsock;
+	sk = &smc->sk;
+
+	if (protocol == SMCPROTO_SMC)
+		seq_printf(seq, CONN4_ADDR_FORMAT, sp->num,
+			   clcsock->sk->sk_rcv_saddr, clcsock->sk->sk_num,
+			   clcsock->sk->sk_daddr, ntohs(clcsock->sk->sk_dport));
+	else if (protocol == SMCPROTO_SMC6) {
+		dest	= &clcsock->sk->sk_v6_daddr;
+		src	= &clcsock->sk->sk_v6_rcv_saddr;
+		seq_printf(seq, CONN6_ADDR_FORMAT, sp->num,
+			   src->s6_addr32[0], src->s6_addr32[1],
+			   src->s6_addr32[2], src->s6_addr32[3], clcsock->sk->sk_num,
+			   dest->s6_addr32[0], dest->s6_addr32[1],
+			   dest->s6_addr32[2], dest->s6_addr32[3], ntohs(clcsock->sk->sk_dport));
+	}
+	seq_printf(seq, CONN_SK_FORMAT, fb ? 'Y' : 'N', fb ? smc->fallback_rsn : 0, sk,
+		   clcsock->sk, fb ? clcsock->sk->sk_state : sk->sk_state, sock_i_ino(sk));
+
+	lgr = smc->conn.lgr;
+	lnk = smc->conn.lnk;
+
+	if (!fb && sk->sk_state == SMC_ACTIVE && lgr) {
+		for (i = 0; i < SMC_LGR_ID_SIZE; i++)
+			seq_printf(seq, "%02X", lgr->id[i]);
+
+		seq_printf(seq, CONN_LGR_FORMAT, lgr->smc_version > SMC_V1 ? "v2" : "v1",
+			   lgr->is_smcd ? 'D' : 'R', lgr->role == SMC_CLNT ? 'C' : 'S');
+
+		if (!lgr->is_smcd && lnk)
+			seq_printf(seq, CONN_SMCR_EXT, lnk->ibname, lnk->ibport,
+				   lnk->roce_qp->qp_num, lnk->peer_qpn);
+	}
+	seq_puts(seq, "\n");
+}
+
+static int smc_proc_conn_show(struct seq_file *seq, void *v)
+{
+	struct smc_proc_private *sp = seq->private;
+	struct socket *clcsock;
+	struct smc_sock *smc;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_printf(seq, sp->protocol == SMCPROTO_SMC ? CONN4_HDR : CONN6_HDR,
+			   "sl", "laddr", "raddr", "fb", "fbrsn", "sock", "clcsock",
+			   "st", "inode", "lgr", "v", "t", "r");
+		goto out;
+	}
+
+	smc = smc_sk(v);
+	clcsock = smc->clcsock;
+	if (!clcsock)
+		goto out;
+
+	__smc_proc_conn_show(seq, smc, sp->protocol);
+out:
+	return 0;
+}
+
+static void *smc_proc_conn_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct smc_proc_private *sp = seq->private;
+	void *rc = NULL;
+
+	if (v == SEQ_START_TOKEN) {
+		rc = smc_proc_get_idx(seq, 0);
+		goto out;
+	}
+	rc = smc_proc_get_next(seq, v);
+out:
+	++*pos;
+	sp->last_pos = *pos;
+	return rc;
+}
+
+static void smc_proc_conn_stop(struct seq_file *seq, void *v)
+{
+	struct smc_proc_private *sp = seq->private;
+	struct smc_hashinfo *smc_hash =
+		sp->protocol == SMCPROTO_SMC ?
+		smc_proto.h.smc_hash : smc_proto6.h.smc_hash;
+
+	if (v && v != SEQ_START_TOKEN)
+		read_unlock(&smc_hash->lock);
+}
+
+static struct smc_proc_entry smc_proc[] = {
+	{
+		.name	= "smc4",
+		.ops = {
+			.show	= smc_proc_conn_show,
+			.start	= smc_proc_conn4_start,
+			.next	= smc_proc_conn_next,
+			.stop	= smc_proc_conn_stop,
+		},
+	},
+#if IS_ENABLED(CONFIG_IPV6)
+	{
+		.name	= "smc6",
+		.ops = {
+			.show	= smc_proc_conn_show,
+			.start	= smc_proc_conn6_start,
+			.next	= smc_proc_conn_next,
+			.stop	= smc_proc_conn_stop,
+		},
+	},
+#endif
+};
+
+static int __net_init smc_proc_dir_init(struct net *net)
+{
+#ifdef CONFIG_PROC_FS
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(smc_proc); i++) {
+		if (!proc_create_net(smc_proc[i].name, 0444,
+				     net->proc_net, &smc_proc[i].ops,
+				     sizeof(struct smc_proc_private)))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (i -= 1; i >= 0; i--)
+		remove_proc_entry(smc_proc[i].name, net->proc_net);
+	return -ENOMEM;
+#else
+	return 0;
+#endif
+}
+
+static void __net_exit smc_proc_dir_exit(struct net *net)
+{
+#ifdef CONFIG_PROC_FS
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(smc_proc); i++)
+		remove_proc_entry(smc_proc[i].name, net->proc_net);
+#endif
+}
+
+static struct pernet_operations smc_proc_ops = {
+	.init = smc_proc_dir_init,
+	.exit = smc_proc_dir_exit,
+};
+
+int __init smc_proc_init(void)
+{
+	return register_pernet_subsys(&smc_proc_ops);
+}
+
+void smc_proc_exit(void)
+{
+	unregister_pernet_subsys(&smc_proc_ops);
+}
diff --git a/net/smc/smc_proc.h b/net/smc/smc_proc.h
new file mode 100644
index 0000000..5f97023
--- /dev/null
+++ b/net/smc/smc_proc.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _SMC_PROC_H_
+#define _SMC_PROC_H_
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sysctl.h>
+#include <net/sock.h>
+#include <net/net_namespace.h>
+#include "smc.h"
+
+#define CONN4_HDR ("%4s: %-14s%-14s%-3s%-9s%-17s%-17s%-3s%-8s%-9s%-3s%-2s%-2s\n")
+#define CONN6_HDR ("%4s: %-38s%-38s%-3s%-9s%-17s%-17s%-3s%-8s%-9s%-3s%-2s%-2s\n")
+#define CONN4_ADDR_FORMAT ("%4d: %08X:%04X %08X:%04X")
+#define CONN6_ADDR_FORMAT ("%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X")
+#define CONN_SK_FORMAT (" %c  %08X %pK %pK %2d %-7lu ")
+#define CONN_LGR_FORMAT (" %-2s %c %c")
+#define CONN_SMCR_EXT (" %-8s %02d %-4X %-4X")
+
+struct smc_proc_private {
+	struct	seq_net_private p;
+	int num, bucket, offset;
+	int protocol;
+	loff_t last_pos;
+};
+
+struct smc_proc_entry {
+	const char *name;
+	const struct seq_operations ops;
+};
+
+int __init smc_proc_init(void);
+void smc_proc_exit(void);
+
+#endif
-- 
1.8.3.1

