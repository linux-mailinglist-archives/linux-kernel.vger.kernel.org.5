Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6091A7D0826
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376279AbjJTGMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345092AbjJTGMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:12:16 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ABBD46;
        Thu, 19 Oct 2023 23:12:13 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKtMDt007953;
        Thu, 19 Oct 2023 23:12:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=EQjAtqEaP066La5weIlGTbOUZJDIZWwln/W4BSKAO5k=;
 b=Fa6Ict4DSU1EY7tIs6g38ZFi9WN4SCo7mapKARh3OvsEZauC1sm2E7dmx/8PSFUhO9iU
 YmsaiWMNUncAmfyWkCp9V8364q9EJPqzUh+e2uPlIUpe8jU8MoVRwoZSGHbn8xiOw4WQ
 hXxIcY58lnWQ0IBAwfq6L5vVpakzDkuAJvRjtWDgr38XlU7qKemVg7ywZcajKbyfWQsg
 TW20s9huVb/1R4CWSUAEcUlT0fZH3Nd0YI6p7aR71HdJf8IlU7ditoX6K1ZtnrZTmYPg
 rpRJI1mJ0NieNEq2GWRoWn7KbxHfqCYM8L4Mb+A5LNrelye8y3TLsEWevPmfi/6O3S4J Aw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tubwr9d6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 23:12:04 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 19 Oct
 2023 23:12:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 19 Oct 2023 23:12:02 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 447DD5B6927;
        Thu, 19 Oct 2023 23:11:59 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.n>, <sgoutham@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <xiyou.wangcong@gmail.com>, <jhs@mojatatu.com>, <jiri@resnulli.us>
Subject: [net-next] net: sched: extend flow action with RSS
Date:   Fri, 20 Oct 2023 11:41:58 +0530
Message-ID: <20231020061158.6716-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: jc9XbweygQI-dFk6Bq06GP_wGXnU5ISw
X-Proofpoint-ORIG-GUID: jc9XbweygQI-dFk6Bq06GP_wGXnU5ISw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_04,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends current flow action with RSS, such that
the user can install flower offloads with action RSS followed
by a group id. Since this is done in hardware skip_sw flag
is enforced.

Example:
In a multi rss group supported NIC,

rss group #1 flow hash indirection table populated with rx queues 1 to 4
rss group #2 flow hash indirection table populated with rx queues 5 to 9

$tc filter add dev eth1 ingress protocol ip flower ip_proto tcp dst_port
443 action skbedit rss_group 1 skip_sw

Packets destined to tcp port 443 will be distributed among rx queues 1 to 4

$tc filter add dev eth1 ingress protocol ip flower ip_proto udp dst_port
8080 action skbedit rss_group 2 skip_sw

Packets destined to udp port 8080 will be distributed among rx queues
5 to 9

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 include/net/flow_offload.h             |  2 ++
 include/net/tc_act/tc_skbedit.h        | 18 ++++++++++++++++++
 include/uapi/linux/tc_act/tc_skbedit.h |  2 ++
 net/sched/act_skbedit.c                | 26 +++++++++++++++++++++++++-
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 314087a5e181..efa45ed87e69 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -168,6 +168,7 @@ enum flow_action_id {
 	FLOW_ACTION_PTYPE,
 	FLOW_ACTION_PRIORITY,
 	FLOW_ACTION_RX_QUEUE_MAPPING,
+	FLOW_ACTION_RSS,
 	FLOW_ACTION_WAKE,
 	FLOW_ACTION_QUEUE,
 	FLOW_ACTION_SAMPLE,
@@ -264,6 +265,7 @@ struct flow_action_entry {
 		u16                     ptype;          /* FLOW_ACTION_PTYPE */
 		u16			rx_queue;	/* FLOW_ACTION_RX_QUEUE_MAPPING */
 		u32			priority;	/* FLOW_ACTION_PRIORITY */
+		u16			rss_group_id;	/* FLOW_ACTION_RSS_GROUP_ID */
 		struct {				/* FLOW_ACTION_QUEUE */
 			u32		ctx;
 			u32		index;
diff --git a/include/net/tc_act/tc_skbedit.h b/include/net/tc_act/tc_skbedit.h
index 9649600fb3dc..c4a122b49e94 100644
--- a/include/net/tc_act/tc_skbedit.h
+++ b/include/net/tc_act/tc_skbedit.h
@@ -19,6 +19,7 @@ struct tcf_skbedit_params {
 	u16 queue_mapping;
 	u16 mapping_mod;
 	u16 ptype;
+	u16 rss_group_id;
 	struct rcu_head rcu;
 };
 
@@ -106,6 +107,17 @@ static inline u16 tcf_skbedit_rx_queue_mapping(const struct tc_action *a)
 	return rx_queue;
 }
 
+static inline u16 tcf_skbedit_rss_group_id(const struct tc_action *a)
+{
+	u16 rss_group_id;
+
+	rcu_read_lock();
+	rss_group_id = rcu_dereference(to_skbedit(a)->params)->rss_group_id;
+	rcu_read_unlock();
+
+	return rss_group_id;
+}
+
 /* Return true iff action is queue_mapping */
 static inline bool is_tcf_skbedit_queue_mapping(const struct tc_action *a)
 {
@@ -136,4 +148,10 @@ static inline bool is_tcf_skbedit_inheritdsfield(const struct tc_action *a)
 	return is_tcf_skbedit_with_flag(a, SKBEDIT_F_INHERITDSFIELD);
 }
 
+static inline bool is_tcf_skbedit_rss_group_id(const struct tc_action *a)
+{
+	return is_tcf_skbedit_ingress(a->tcfa_flags) &&
+	       is_tcf_skbedit_with_flag(a, SKBEDIT_F_RSS_GROUP_ID);
+}
+
 #endif /* __NET_TC_SKBEDIT_H */
diff --git a/include/uapi/linux/tc_act/tc_skbedit.h b/include/uapi/linux/tc_act/tc_skbedit.h
index 64032513cc4c..83f53550bb88 100644
--- a/include/uapi/linux/tc_act/tc_skbedit.h
+++ b/include/uapi/linux/tc_act/tc_skbedit.h
@@ -17,6 +17,7 @@
 #define SKBEDIT_F_MASK			0x10
 #define SKBEDIT_F_INHERITDSFIELD	0x20
 #define SKBEDIT_F_TXQ_SKBHASH		0x40
+#define SKBEDIT_F_RSS_GROUP_ID		0x80
 
 struct tc_skbedit {
 	tc_gen;
@@ -34,6 +35,7 @@ enum {
 	TCA_SKBEDIT_MASK,
 	TCA_SKBEDIT_FLAGS,
 	TCA_SKBEDIT_QUEUE_MAPPING_MAX,
+	TCA_SKBEDIT_RSS_GROUP_ID,
 	__TCA_SKBEDIT_MAX
 };
 #define TCA_SKBEDIT_MAX (__TCA_SKBEDIT_MAX - 1)
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index ce7008cf291c..127198239ac7 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -112,6 +112,7 @@ static const struct nla_policy skbedit_policy[TCA_SKBEDIT_MAX + 1] = {
 	[TCA_SKBEDIT_MASK]		= { .len = sizeof(u32) },
 	[TCA_SKBEDIT_FLAGS]		= { .len = sizeof(u64) },
 	[TCA_SKBEDIT_QUEUE_MAPPING_MAX]	= { .len = sizeof(u16) },
+	[TCA_SKBEDIT_RSS_GROUP_ID]	= { .len = sizeof(u16) },
 };
 
 static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
@@ -126,8 +127,8 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	struct tcf_chain *goto_ch = NULL;
 	struct tc_skbedit *parm;
 	struct tcf_skbedit *d;
+	u16 *queue_mapping = NULL, *ptype = NULL, *rss_group_id = NULL;
 	u32 flags = 0, *priority = NULL, *mark = NULL, *mask = NULL;
-	u16 *queue_mapping = NULL, *ptype = NULL;
 	u16 mapping_mod = 1;
 	bool exists = false;
 	int ret = 0, err;
@@ -176,6 +177,17 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 		mask = nla_data(tb[TCA_SKBEDIT_MASK]);
 	}
 
+	if (tb[TCA_SKBEDIT_RSS_GROUP_ID] != NULL) {
+		if (!is_tcf_skbedit_ingress(act_flags) ||
+		    !(act_flags & TCA_ACT_FLAGS_SKIP_SW)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "\"rss_group_id\" option allowed only on receive side with hardware only, use skip_sw");
+			return -EOPNOTSUPP;
+		}
+		flags |= SKBEDIT_F_RSS_GROUP_ID;
+		rss_group_id = nla_data(tb[TCA_SKBEDIT_RSS_GROUP_ID]);
+	}
+
 	if (tb[TCA_SKBEDIT_FLAGS] != NULL) {
 		u64 *pure_flags = nla_data(tb[TCA_SKBEDIT_FLAGS]);
 
@@ -262,6 +274,9 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	if (flags & SKBEDIT_F_MASK)
 		params_new->mask = *mask;
 
+	if (flags & SKBEDIT_F_RSS_GROUP_ID)
+		params_new->rss_group_id = *rss_group_id;
+
 	spin_lock_bh(&d->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params_new = rcu_replace_pointer(d->params, params_new,
@@ -326,6 +341,9 @@ static int tcf_skbedit_dump(struct sk_buff *skb, struct tc_action *a,
 
 		pure_flags |= SKBEDIT_F_TXQ_SKBHASH;
 	}
+	if ((params->flags & SKBEDIT_F_RSS_GROUP_ID) &&
+	    nla_put_u16(skb, TCA_SKBEDIT_RSS_GROUP_ID, params->rss_group_id))
+		goto nla_put_failure;
 	if (pure_flags != 0 &&
 	    nla_put(skb, TCA_SKBEDIT_FLAGS, sizeof(pure_flags), &pure_flags))
 		goto nla_put_failure;
@@ -362,6 +380,7 @@ static size_t tcf_skbedit_get_fill_size(const struct tc_action *act)
 		+ nla_total_size(sizeof(u32)) /* TCA_SKBEDIT_MARK */
 		+ nla_total_size(sizeof(u16)) /* TCA_SKBEDIT_PTYPE */
 		+ nla_total_size(sizeof(u32)) /* TCA_SKBEDIT_MASK */
+		+ nla_total_size(sizeof(u16)) /* TCA_SKBEDIT_RSS_GROUP_ID */
 		+ nla_total_size_64bit(sizeof(u64)); /* TCA_SKBEDIT_FLAGS */
 }
 
@@ -390,6 +409,9 @@ static int tcf_skbedit_offload_act_setup(struct tc_action *act, void *entry_data
 		} else if (is_tcf_skbedit_inheritdsfield(act)) {
 			NL_SET_ERR_MSG_MOD(extack, "Offload not supported when \"inheritdsfield\" option is used");
 			return -EOPNOTSUPP;
+		} else if (is_tcf_skbedit_rss_group_id(act)) {
+			entry->id = FLOW_ACTION_RSS;
+			entry->rss_group_id = tcf_skbedit_rss_group_id(act);
 		} else {
 			NL_SET_ERR_MSG_MOD(extack, "Unsupported skbedit option offload");
 			return -EOPNOTSUPP;
@@ -406,6 +428,8 @@ static int tcf_skbedit_offload_act_setup(struct tc_action *act, void *entry_data
 			fl_action->id = FLOW_ACTION_PRIORITY;
 		else if (is_tcf_skbedit_rx_queue_mapping(act))
 			fl_action->id = FLOW_ACTION_RX_QUEUE_MAPPING;
+		else if (is_tcf_skbedit_rss_group_id(act))
+			fl_action->id = FLOW_ACTION_RSS;
 		else
 			return -EOPNOTSUPP;
 	}
-- 
2.17.1

