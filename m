Return-Path: <linux-kernel+bounces-67283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7185692F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6EAB29197
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A73135A65;
	Thu, 15 Feb 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="rbUByrVn"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9E1350EF;
	Thu, 15 Feb 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013203; cv=none; b=gf9jPSVJv32Ub2NG/ctW5jlq4Z8isxm3PbQxbHuBpsg+6HdNmW9vvWcRJCmQ4F7pOt02Mc/G7/7qsC57fvKsw3y44s/oT7sEa4CF1XHnFAj7tPzCScjJsimwQFpfB4lUVERoloVDMtV+cwiMktaxogCzjSmaAEoUmRVfFIVlBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013203; c=relaxed/simple;
	bh=t0ya6U+qD8pjYYUmzKIRrk3nGKiLV2qy6SQI597Ey+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pM/nrEoXRHavbbcXMozXRI3JbM5LJelHahWDJ2VkwSGWdzajC5GF0sufzKWJzHlRm50O7GqxpkJXtNlngFxVDlZ5utFn589IijLEJ4c6ilM/0cB9aF2k3wv7tYy9ySFExBnnda2SojA1zIR20LcjwZZfI+8iGN736SOyneFYEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=rbUByrVn; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 16B146030D;
	Thu, 15 Feb 2024 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1708013196;
	bh=t0ya6U+qD8pjYYUmzKIRrk3nGKiLV2qy6SQI597Ey+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbUByrVnqY8YTE//qqwdPG4bnQFVSAdKCo8Traw3RFyTZECAbA7ctkxh7FwUIGfH0
	 S7hFBo6u4joMnyTssavePgnyQ2y8JycQpdJKNLMP8jsJry3zvBZllHuiU+H+nWQJuS
	 7y2IxzBvn3unD2g3rLOhAGh6Lx5Smk7CluembziXNRqtdV5Xio3vv/aP3zpinqjIIk
	 kHNziVXD5EQ7wwoC2Es3mH+olgafCJViHDUHHsOFm5dHr5gjon3P0PPSIc9opSd7ij
	 6V885E1IMH4lA264/ZFMkBv104wMYZNpk028gmx2rO21tI3l6HAErYWsmhM6U6WHHS
	 vyeWpxheLC5Ag==
Received: by x201s (Postfix, from userid 1000)
	id C8A24205B9D; Thu, 15 Feb 2024 16:05:50 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: [PATCH net-next 2/3] net: sched: cls_api: add filter counter
Date: Thu, 15 Feb 2024 16:04:43 +0000
Message-ID: <20240215160458.1727237-3-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215160458.1727237-1-ast@fiberby.net>
References: <20240215160458.1727237-1-ast@fiberby.net>
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
 net/sched/cls_api.c       | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

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
index 397c3d29659c..c750cb662142 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -411,11 +411,13 @@ static void tcf_proto_get(struct tcf_proto *tp)
 }
 
 static void tcf_chain_put(struct tcf_chain *chain);
+static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add);
 
 static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
 			      bool sig_destroy, struct netlink_ext_ack *extack)
 {
 	tp->ops->destroy(tp, rtnl_held, extack);
+	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
 	tcf_chain_put(tp->chain);
@@ -2364,6 +2366,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
+		tcf_block_filter_cnt_update(block, &tp->counted, true);
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
@@ -3478,6 +3481,23 @@ int tcf_exts_dump_stats(struct sk_buff *skb, struct tcf_exts *exts)
 }
 EXPORT_SYMBOL(tcf_exts_dump_stats);
 
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
 static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
 {
 	if (*flags & TCA_CLS_FLAGS_IN_HW)
-- 
2.43.0


