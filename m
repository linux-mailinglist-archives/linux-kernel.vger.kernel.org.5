Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3DA7694F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGaLfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjGaLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:35:05 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0527DE5B;
        Mon, 31 Jul 2023 04:35:01 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UNIc2x012062;
        Mon, 31 Jul 2023 04:34:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=dyZuotwS16ZG56Yq3dCvtQ0Bfe8UVn59yG8l/Wtbrj8=;
 b=TXIayJJ3/20TUwiX1/Iz1aAKA0ulG/2w2XHJjfLPK8RWNuvTgo/DmAktXSHpSwpM6lUY
 vmBS/AsIbSlse0LBaX2lAjKThwAOq87KqjvpPs7sM5GqTBcPHJ7NTlJGMUIHgCHoVAWJ
 68w1UGfyGSf0fZ4o5z6amBnKvuY8fxLhB0y53fPpu8pLMCTlY9vLsT1jMkSDTQgBto9k
 stp/g18E4XuTcOhrsLqphJD+4JCHJ/XW8O7Kx/lS+2QOW5LhHEFurW4qV8+O64g5TnoI
 60NDaYkiO9bKe4t8TF7jGAowkHlKnQfPmDZ5bEp8mht9JoZGu2XfUMAU/hBM3Jk7WsS7 Kw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529k4qh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:34:54 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 04:34:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 04:34:40 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 1ABFF3F70B7;
        Mon, 31 Jul 2023 04:34:35 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next 2/4] tc: flower: support for SPI
Date:   Mon, 31 Jul 2023 17:04:06 +0530
Message-ID: <20230731113408.2586913-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731113408.2586913-1-rkannoth@marvell.com>
References: <20230731113408.2586913-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bDUP4_LcKtHP62aYrhNwrz1Iz6_oSNRZ
X-Proofpoint-ORIG-GUID: bDUP4_LcKtHP62aYrhNwrz1Iz6_oSNRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_05,2023-07-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tc flower rules support to classify ESP/AH
packets matching SPI field.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 include/uapi/linux/pkt_cls.h |  3 +++
 net/sched/cls_flower.c       | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 7865f5a9885b..a90b0e3d351f 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -594,6 +594,9 @@ enum {
 
 	TCA_FLOWER_KEY_L2TPV3_SID,	/* be32 */
 
+	TCA_FLOWER_KEY_SPI,		/* be32 */
+	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
+
 	TCA_FLOWER_L2_MISS,		/* u8 */
 
 	TCA_FLOWER_KEY_CFM,		/* nested */
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 8da9d039d964..eca260272845 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -72,6 +72,7 @@ struct fl_flow_key {
 	struct flow_dissector_key_num_of_vlans num_of_vlans;
 	struct flow_dissector_key_pppoe pppoe;
 	struct flow_dissector_key_l2tpv3 l2tpv3;
+	struct flow_dissector_key_ipsec ipsec;
 	struct flow_dissector_key_cfm cfm;
 } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
 
@@ -726,6 +727,8 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_PPPOE_SID]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_PPP_PROTO]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_L2TPV3_SID]	= { .type = NLA_U32 },
+	[TCA_FLOWER_KEY_SPI]		= { .type = NLA_U32 },
+	[TCA_FLOWER_KEY_SPI_MASK]	= { .type = NLA_U32 },
 	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
 };
@@ -795,6 +798,24 @@ static void fl_set_key_val(struct nlattr **tb,
 		nla_memcpy(mask, tb[mask_type], len);
 }
 
+static int fl_set_key_spi(struct nlattr **tb, struct fl_flow_key *key,
+			  struct fl_flow_key *mask,
+			  struct netlink_ext_ack *extack)
+{
+	if (key->basic.ip_proto != IPPROTO_ESP &&
+	    key->basic.ip_proto != IPPROTO_AH) {
+		NL_SET_ERR_MSG(extack,
+			       "Protocol must be either ESP or AH");
+		return -EINVAL;
+	}
+
+	fl_set_key_val(tb, &key->ipsec.spi,
+		       TCA_FLOWER_KEY_SPI,
+		       &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
+		       sizeof(key->ipsec.spi));
+	return 0;
+}
+
 static int fl_set_key_port_range(struct nlattr **tb, struct fl_flow_key *key,
 				 struct fl_flow_key *mask,
 				 struct netlink_ext_ack *extack)
@@ -1894,6 +1915,12 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
 			return ret;
 	}
 
+	if (tb[TCA_FLOWER_KEY_SPI]) {
+		ret = fl_set_key_spi(tb, key, mask, extack);
+		if (ret)
+			return ret;
+	}
+
 	if (tb[TCA_FLOWER_KEY_ENC_IPV4_SRC] ||
 	    tb[TCA_FLOWER_KEY_ENC_IPV4_DST]) {
 		key->enc_control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
@@ -2066,6 +2093,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
 			     FLOW_DISSECTOR_KEY_PPPOE, pppoe);
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
 			     FLOW_DISSECTOR_KEY_L2TPV3, l2tpv3);
+	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
+			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
 			     FLOW_DISSECTOR_KEY_CFM, cfm);
 
@@ -3364,6 +3393,12 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
 				 sizeof(key->l2tpv3.session_id)))
 		goto nla_put_failure;
 
+	if (key->ipsec.spi &&
+	    fl_dump_key_val(skb, &key->ipsec.spi, TCA_FLOWER_KEY_SPI,
+			    &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
+			    sizeof(key->ipsec.spi)))
+		goto nla_put_failure;
+
 	if ((key->basic.ip_proto == IPPROTO_TCP ||
 	     key->basic.ip_proto == IPPROTO_UDP ||
 	     key->basic.ip_proto == IPPROTO_SCTP) &&
-- 
2.25.1

