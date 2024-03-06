Return-Path: <linux-kernel+bounces-94303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75C873CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9961CB20988
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC313D2F5;
	Wed,  6 Mar 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="h9Vju3EQ"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2B13B7BD;
	Wed,  6 Mar 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744340; cv=none; b=RMGI7XqhA2nKcflWEM/JLTtssV6KePvcBcqzU7eMunQGd+9UCQ4R0M61+02Gnq0d1Mz4MxiLkkgzmeuKJ6qi2bRvTlmPfsmK9DxHW+seSTFcnBhdWskV1JZTMoESxxo3VDR6TpLq4VX5R+IulwwhhbHK55e8p92Io76ffp7sprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744340; c=relaxed/simple;
	bh=pULFdc99bT3kGEpnmoQAhimYHSPZ/ND5NNhVMP7CCsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6EAyTNSdVFMbHGe8VX69/FL8aOdeHvAokQJ0GvY4LJq8J2yeTSJmlKrCqXhlxnZUrRLI8YqVfdae6ATxfHQD1/uCXEOW7Z7WJIbK6WUxXEpHeQ7hnG/S2ywiVR7koFqxtlciSCt61P5NzebOpeJK0Az/fmH8+Gde5GNYLFKy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=h9Vju3EQ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3A0496030D;
	Wed,  6 Mar 2024 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1709744330;
	bh=pULFdc99bT3kGEpnmoQAhimYHSPZ/ND5NNhVMP7CCsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9Vju3EQfOt6JdPYLHlJJ3quowNMNibzAbJvtjjidydjEeajM06yFf26QThTbmuM7
	 k+eFkrKxae03FnTzCE/ahfF8hj4yZOq0fiLIW8ycDUc7Fjlh+aWWsjZ7bnQ2353Xx7
	 tdPIFZP8Um0lGyD/QzBSqzUCGuZa7x6/Kt+IAIahEPgHE+GQL3QhDzXvpBH0kEr2EJ
	 ANHf75Qd0j+hdd0ScFu8QBmIbth3OurMifQDFUbOeU6WczkLMRugfpNOwr1sPtACdf
	 DJ3ImdEW07vF8KF67b9rCywnKtVsruFWXwJNG/1LRV4POi4MoyLiGUTVruhEwmU3T5
	 2xBzAaLL6jmeQ==
Received: by x201s (Postfix, from userid 1000)
	id ACF7B20376D; Wed,  6 Mar 2024 16:58:26 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next v3 2/3] net: sched: cls_api: add filter counter
Date: Wed,  6 Mar 2024 16:58:10 +0000
Message-ID: <20240306165813.656931-3-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306165813.656931-1-ast@fiberby.net>
References: <20240306165813.656931-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Maintain a count of filters per block.

Counter updates are protected by cb_lock, which is
also used to protect the offload counters.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/sch_generic.h |  2 ++
 net/sched/cls_api.c       | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 46a63d1818a0..7af0621db226 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -427,6 +427,7 @@ struct tcf_proto {
 	 */
 	spinlock_t		lock;
 	bool			deleting;
+	bool			counted;
 	refcount_t		refcnt;
 	struct rcu_head		rcu;
 	struct hlist_node	destroy_ht_node;
@@ -476,6 +477,7 @@ struct tcf_block {
 	struct flow_block flow_block;
 	struct list_head owner_list;
 	bool keep_dst;
+	atomic_t filtercnt; /* Number of filters */
 	atomic_t skipswcnt; /* Number of skip_sw filters */
 	atomic_t offloadcnt; /* Number of oddloaded filters */
 	unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 397c3d29659c..304a46ab0e0b 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -410,12 +410,30 @@ static void tcf_proto_get(struct tcf_proto *tp)
 	refcount_inc(&tp->refcnt);
 }
 
+static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)
+{
+	lockdep_assert_not_held(&block->cb_lock);
+
+	down_write(&block->cb_lock);
+	if (*counted != add) {
+		if (add) {
+			atomic_inc(&block->filtercnt);
+			*counted = true;
+		} else {
+			atomic_dec(&block->filtercnt);
+			*counted = false;
+		}
+	}
+	up_write(&block->cb_lock);
+}
+
 static void tcf_chain_put(struct tcf_chain *chain);
 
 static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
 			      bool sig_destroy, struct netlink_ext_ack *extack)
 {
 	tp->ops->destroy(tp, rtnl_held, extack);
+	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
 	tcf_chain_put(tp->chain);
@@ -2364,6 +2382,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
+		tcf_block_filter_cnt_update(block, &tp->counted, true);
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
-- 
2.43.0


