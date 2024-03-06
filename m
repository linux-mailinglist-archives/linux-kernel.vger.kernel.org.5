Return-Path: <linux-kernel+bounces-94304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34285873CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C9C1F282B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468213DBA2;
	Wed,  6 Mar 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Im/Deftw"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE713B7A9;
	Wed,  6 Mar 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744340; cv=none; b=TOS/1EsJgtoWw897AqGKBwiRcfd2LH/gRq/rLZzWAyMXcxJjdV5ugShTF37IIaGG67FwPIXjIBgwR8xZoNiUToFkkBPmkATsLtvmYkDFto0aeT9w6Rao/XSMg7NLHazuQsWlLGm24gZrtoaflku4LZJE8fhlGcIad3iWWrdhFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744340; c=relaxed/simple;
	bh=t9n2dZYVeC1buZKVU4VXcqny92hIU4Tb9aHWrrBO6R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hG4itf50mHGgvU6c2JDggsVJ3ZD3f6GWwd+jjl9JQw7AA5Uchsrfrqt5kcaR0wsr8dcuGhpmXDEPuWRzZxEITVnKYX4/49EinxpNxt/yjep0mFYhzE3Sbjc2V+vLY2/eq5TfuvFV2LfU0wL61esWR3DO3tEtH1YKDhrurulVp/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Im/Deftw; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 316836030B;
	Wed,  6 Mar 2024 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1709744330;
	bh=t9n2dZYVeC1buZKVU4VXcqny92hIU4Tb9aHWrrBO6R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Im/DeftwSy+dyGb5tEa5pokpdScyNvk2ENKizWYVlK46jVvpAuHTnli6Xh+YoFVXb
	 FXFIYY9L0NX/eD65vFiN3S5MOGRwvy+qeqX+dLFuCAM57qKpqZQmPANHsZkbzj5MXF
	 UBKksSy6aYRroUKhh6w1nbV2pU46NQAjgXlaU1di8zALVCTKYWIE2lYxCn5NpmcIXf
	 QJI/cgJyDw3CwihywVaY0ezT7o2V3cFAg3PYWOpVemIKQ0E77R9CVhkPC72mbpxL3T
	 uDUdKJzVG3VKe2/v73xuxQLjMuu9Rir/dYgMjqEN5Y9FEMQuFVwNSesJ2Hp3KDVPv/
	 D3rgh0RC7wV+w==
Received: by x201s (Postfix, from userid 1000)
	id B10A9203A97; Wed,  6 Mar 2024 16:58:27 +0000 (UTC)
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
Subject: [PATCH net-next v3 3/3] net: sched: make skip_sw actually skip software
Date: Wed,  6 Mar 2024 16:58:11 +0000
Message-ID: <20240306165813.656931-4-ast@fiberby.net>
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

TC filters come in 3 variants:
- no flag (try to process in hardware, but fallback to software))
- skip_hw (do not process filter by hardware)
- skip_sw (do not process filter by software)

However skip_sw is implemented so that the skip_sw
flag can first be checked, after it has been matched.

IMHO it's common when using skip_sw, to use it on all rules.

So if all filters in a block is skip_sw filters, then
we can bail early, we can thus avoid having to match
the filters, just to check for the skip_sw flag.

This patch adds a bypass, for when only TC skip_sw rules
are used. The bypass is guarded by a static key, to avoid
harming other workloads.

There are 3 ways that a packet from a skip_sw ruleset, can
end up in the kernel path. Although the send packets to a
non-existent chain way is only improved a few percents, then
I believe it's worth optimizing the trap and fall-though
use-cases.

 +----------------------------+--------+--------+--------+
 | Test description           | Pre-   | Post-  | Rel.   |
 |                            | kpps   | kpps   | chg.   |
 +----------------------------+--------+--------+--------+
 | basic forwarding + notrack | 3589.3 | 3587.9 |  1.00x |
 | switch to eswitch mode     | 3081.8 | 3094.7 |  1.00x |
 | add ingress qdisc          | 3042.9 | 3063.6 |  1.01x |
 | tc forward in hw / skip_sw |37024.7 |37028.4 |  1.00x |
 | tc forward in sw / skip_hw | 3245.0 | 3245.3 |  1.00x |
 +----------------------------+--------+--------+--------+
 | tests with only skip_sw rules below:                  |
 +----------------------------+--------+--------+--------+
 | 1 non-matching rule        | 2694.7 | 3058.7 |  1.14x |
 | 1 n-m rule, match trap     | 2611.2 | 3323.1 |  1.27x |
 | 1 n-m rule, goto non-chain | 2886.8 | 2945.9 |  1.02x |
 | 5 non-matching rules       | 1958.2 | 3061.3 |  1.56x |
 | 5 n-m rules, match trap    | 1911.9 | 3327.0 |  1.74x |
 | 5 n-m rules, goto non-chain| 2883.1 | 2947.5 |  1.02x |
 | 10 non-matching rules      | 1466.3 | 3062.8 |  2.09x |
 | 10 n-m rules, match trap   | 1444.3 | 3317.9 |  2.30x |
 | 10 n-m rules,goto non-chain| 2883.1 | 2939.5 |  1.02x |
 | 25 non-matching rules      |  838.5 | 3058.9 |  3.65x |
 | 25 n-m rules, match trap   |  824.5 | 3323.0 |  4.03x |
 | 25 n-m rules,goto non-chain| 2875.8 | 2944.7 |  1.02x |
 | 50 non-matching rules      |  488.1 | 3054.7 |  6.26x |
 | 50 n-m rules, match trap   |  484.9 | 3318.5 |  6.84x |
 | 50 n-m rules,goto non-chain| 2884.1 | 2939.7 |  1.02x |
 +----------------------------+--------+--------+--------+

perf top (25 n-m skip_sw rules - pre patch):
  20.39%  [kernel]  [k] __skb_flow_dissect
  16.43%  [kernel]  [k] rhashtable_jhash2
  10.58%  [kernel]  [k] fl_classify
  10.23%  [kernel]  [k] fl_mask_lookup
   4.79%  [kernel]  [k] memset_orig
   2.58%  [kernel]  [k] tcf_classify
   1.47%  [kernel]  [k] __x86_indirect_thunk_rax
   1.42%  [kernel]  [k] __dev_queue_xmit
   1.36%  [kernel]  [k] nft_do_chain
   1.21%  [kernel]  [k] __rcu_read_lock

perf top (25 n-m skip_sw rules - post patch):
   5.12%  [kernel]  [k] __dev_queue_xmit
   4.77%  [kernel]  [k] nft_do_chain
   3.65%  [kernel]  [k] dev_gro_receive
   3.41%  [kernel]  [k] check_preemption_disabled
   3.14%  [kernel]  [k] mlx5e_skb_from_cqe_mpwrq_nonlinear
   2.88%  [kernel]  [k] __netif_receive_skb_core.constprop.0
   2.49%  [kernel]  [k] mlx5e_xmit
   2.15%  [kernel]  [k] ip_forward
   1.95%  [kernel]  [k] mlx5e_tc_restore_tunnel
   1.92%  [kernel]  [k] vlan_gro_receive

Test setup:
 DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x100G
 Data rate measured on switch (Extreme X690), and DUT connected as
 a router on a stick, with pktgen and pktsink as VLANs.
 Pktgen-dpdk was in range 36.6-37.7 Mpps across all tests.
 Full test data at https://files.fiberby.net/ast/2024/tc_skip_sw/v2_tests/

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/pkt_cls.h     |  9 +++++++++
 include/net/sch_generic.h |  1 +
 net/core/dev.c            | 10 ++++++++++
 net/sched/cls_api.c       | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a4ee43f493bb..41297bd38dff 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -74,6 +74,15 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
 	return block && block->index;
 }
 
+#ifdef CONFIG_NET_CLS_ACT
+DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
+
+static inline bool tcf_block_bypass_sw(struct tcf_block *block)
+{
+	return block && block->bypass_wanted;
+}
+#endif
+
 static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
 {
 	WARN_ON(tcf_block_shared(block));
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 7af0621db226..60b0fdf2b1ad 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -477,6 +477,7 @@ struct tcf_block {
 	struct flow_block flow_block;
 	struct list_head owner_list;
 	bool keep_dst;
+	bool bypass_wanted;
 	atomic_t filtercnt; /* Number of filters */
 	atomic_t skipswcnt; /* Number of skip_sw filters */
 	atomic_t offloadcnt; /* Number of oddloaded filters */
diff --git a/net/core/dev.c b/net/core/dev.c
index fe054cbd41e9..b7c583f98e82 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2057,6 +2057,11 @@ void net_dec_egress_queue(void)
 EXPORT_SYMBOL_GPL(net_dec_egress_queue);
 #endif
 
+#ifdef CONFIG_NET_CLS_ACT
+DEFINE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
+EXPORT_SYMBOL(tcf_bypass_check_needed_key);
+#endif
+
 DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
 EXPORT_SYMBOL(netstamp_needed_key);
 #ifdef CONFIG_JUMP_LABEL
@@ -3911,6 +3916,11 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 	if (!miniq)
 		return ret;
 
+	if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
+		if (tcf_block_bypass_sw(miniq->block))
+			return ret;
+	}
+
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
 	tcf_set_drop_reason(skb, *drop_reason);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 304a46ab0e0b..db0653993632 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -410,6 +410,23 @@ static void tcf_proto_get(struct tcf_proto *tp)
 	refcount_inc(&tp->refcnt);
 }
 
+static void tcf_maintain_bypass(struct tcf_block *block)
+{
+	int filtercnt = atomic_read(&block->filtercnt);
+	int skipswcnt = atomic_read(&block->skipswcnt);
+	bool bypass_wanted = filtercnt > 0 && filtercnt == skipswcnt;
+
+	if (bypass_wanted != block->bypass_wanted) {
+#ifdef CONFIG_NET_CLS_ACT
+		if (bypass_wanted)
+			static_branch_inc(&tcf_bypass_check_needed_key);
+		else
+			static_branch_dec(&tcf_bypass_check_needed_key);
+#endif
+		block->bypass_wanted = bypass_wanted;
+	}
+}
+
 static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)
 {
 	lockdep_assert_not_held(&block->cb_lock);
@@ -424,6 +441,7 @@ static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted,
 			*counted = false;
 		}
 	}
+	tcf_maintain_bypass(block);
 	up_write(&block->cb_lock);
 }
 
-- 
2.43.0


