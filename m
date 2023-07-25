Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD71776068C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGYD0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGYDZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:25:22 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8171702;
        Mon, 24 Jul 2023 20:25:14 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P0WRUQ017698;
        Mon, 24 Jul 2023 20:25:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=E+Tx6awuanJkJUgePT1Vdmkx0FhGOUYi/MYtGt1UDys=;
 b=V2smqVmbBJIXsLz8jHI6jT698N/mX8YLwZByoVcTS5AQSfniFRUXAfxbNIaFlTfPYzUe
 BpR5Fw9R9vIjfWk1UTeQy64O/d4msMEESfHW/qOAx2juvWDK3LUyBGDHy1NW8jfbeWk7
 gu/0rZx0JHAN80KJOG+rXKdhgDdZv5/ERsLiLyQpCUTMytOZPpIAHd7cYwAWcvvIG+WH
 nSq0K6kjb+yrCmXIUCqAbCSwUYw31XP4dWBWXww2US/KNEkW/4n2DtvLpOJrvkrt89BH
 Nfu2aqGyEidFRM35nQY9jruj6Va3Hxrl3tu4QJswPVWJahooRtO6jlsg4yQDwdwPoIfe UQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s18r24jhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 20:24:59 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 24 Jul
 2023 20:24:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 24 Jul 2023 20:24:57 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 6F1673F707B;
        Mon, 24 Jul 2023 20:24:54 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] flow_dissector: Add IPSEC dissectors
Date:   Tue, 25 Jul 2023 08:54:51 +0530
Message-ID: <20230725032451.505189-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N60Io2hGfnD2mEJCPRFQtfsdtg5L7dDe
X-Proofpoint-ORIG-GUID: N60Io2hGfnD2mEJCPRFQtfsdtg5L7dDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Support for dissecting IPSEC field SPI (which is
 32bits in size) for ESP and AH packets.

 This implementation does not support NAT-T
 (encapsulation of ESP packets over UDP).

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 include/net/flow_dissector.h |  9 ++++++
 include/net/flow_offload.h   |  6 ++++
 include/uapi/linux/pkt_cls.h |  3 ++
 net/core/flow_dissector.c    | 53 +++++++++++++++++++++++++++++++++++-
 net/core/flow_offload.c      |  7 +++++
 net/sched/cls_flower.c       | 18 ++++++++++++
 6 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 8664ed4fbbdf..ffec739f049a 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -301,6 +301,14 @@ struct flow_dissector_key_l2tpv3 {
 	__be32 session_id;
 };
 
+/**
+ * struct flow_dissector_key_ipsec:
+ * @spi: identifier for a ipsec connection
+ */
+struct flow_dissector_key_ipsec {
+	__be32 spi;
+};
+
 /**
  * struct flow_dissector_key_cfm
  * @mdl_ver: maintenance domain level (mdl) and cfm protocol version
@@ -353,6 +361,7 @@ enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_NUM_OF_VLANS, /* struct flow_dissector_key_num_of_vlans */
 	FLOW_DISSECTOR_KEY_PPPOE, /* struct flow_dissector_key_pppoe */
 	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
+	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
 	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
 
 	FLOW_DISSECTOR_KEY_MAX,
diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 118082eae48c..9efa9a59e81f 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -64,6 +64,10 @@ struct flow_match_tcp {
 	struct flow_dissector_key_tcp *key, *mask;
 };
 
+struct flow_match_ipsec {
+	struct flow_dissector_key_ipsec *key, *mask;
+};
+
 struct flow_match_mpls {
 	struct flow_dissector_key_mpls *key, *mask;
 };
@@ -116,6 +120,8 @@ void flow_rule_match_ports_range(const struct flow_rule *rule,
 				 struct flow_match_ports_range *out);
 void flow_rule_match_tcp(const struct flow_rule *rule,
 			 struct flow_match_tcp *out);
+void flow_rule_match_ipsec(const struct flow_rule *rule,
+			   struct flow_match_ipsec *out);
 void flow_rule_match_icmp(const struct flow_rule *rule,
 			  struct flow_match_icmp *out);
 void flow_rule_match_mpls(const struct flow_rule *rule,
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
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 85a2d0d9bd39..7162594d7940 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -205,6 +205,50 @@ static void __skb_flow_dissect_icmp(const struct sk_buff *skb,
 	skb_flow_get_icmp_tci(skb, key_icmp, data, thoff, hlen);
 }
 
+static void __skb_flow_dissect_ah(const struct sk_buff *skb,
+				  struct flow_dissector *flow_dissector,
+				  void *target_container, const void *data,
+				  int nhoff, int hlen)
+{
+	struct flow_dissector_key_ipsec *key_ah;
+	struct ip_auth_hdr _hdr, *hdr;
+
+	if (!dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_IPSEC))
+		return;
+
+	hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
+	if (!hdr)
+		return;
+
+	key_ah = skb_flow_dissector_target(flow_dissector,
+					   FLOW_DISSECTOR_KEY_IPSEC,
+					   target_container);
+
+	key_ah->spi = hdr->spi;
+}
+
+static void __skb_flow_dissect_esp(const struct sk_buff *skb,
+				   struct flow_dissector *flow_dissector,
+				   void *target_container, const void *data,
+				   int nhoff, int hlen)
+{
+	struct flow_dissector_key_ipsec *key_esp;
+	struct ip_esp_hdr _hdr, *hdr;
+
+	if (!dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_IPSEC))
+		return;
+
+	hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
+	if (!hdr)
+		return;
+
+	key_esp = skb_flow_dissector_target(flow_dissector,
+					    FLOW_DISSECTOR_KEY_IPSEC,
+					    target_container);
+
+	key_esp->spi = hdr->spi;
+}
+
 static void __skb_flow_dissect_l2tpv3(const struct sk_buff *skb,
 				      struct flow_dissector *flow_dissector,
 				      void *target_container, const void *data,
@@ -1571,7 +1615,14 @@ bool __skb_flow_dissect(const struct net *net,
 		__skb_flow_dissect_l2tpv3(skb, flow_dissector, target_container,
 					  data, nhoff, hlen);
 		break;
-
+	case IPPROTO_ESP:
+		__skb_flow_dissect_esp(skb, flow_dissector, target_container,
+				       data, nhoff, hlen);
+		break;
+	case IPPROTO_AH:
+		__skb_flow_dissect_ah(skb, flow_dissector, target_container,
+				      data, nhoff, hlen);
+		break;
 	default:
 		break;
 	}
diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index acfc1f88ea79..bc5169482710 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -146,6 +146,13 @@ void flow_rule_match_tcp(const struct flow_rule *rule,
 }
 EXPORT_SYMBOL(flow_rule_match_tcp);
 
+void flow_rule_match_ipsec(const struct flow_rule *rule,
+			   struct flow_match_ipsec *out)
+{
+	FLOW_DISSECTOR_MATCH(rule, FLOW_DISSECTOR_KEY_IPSEC, out);
+}
+EXPORT_SYMBOL(flow_rule_match_ipsec);
+
 void flow_rule_match_icmp(const struct flow_rule *rule,
 			  struct flow_match_icmp *out)
 {
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 8da9d039d964..7ba839057d3c 100644
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
@@ -1894,6 +1897,13 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
 			return ret;
 	}
 
+	if (tb[TCA_FLOWER_KEY_SPI]) {
+		fl_set_key_val(tb, &key->ipsec.spi,
+			       TCA_FLOWER_KEY_SPI,
+			       &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
+			       sizeof(key->ipsec.spi));
+	}
+
 	if (tb[TCA_FLOWER_KEY_ENC_IPV4_SRC] ||
 	    tb[TCA_FLOWER_KEY_ENC_IPV4_DST]) {
 		key->enc_control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
@@ -2066,6 +2076,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
 			     FLOW_DISSECTOR_KEY_PPPOE, pppoe);
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
 			     FLOW_DISSECTOR_KEY_L2TPV3, l2tpv3);
+	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
+			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
 			     FLOW_DISSECTOR_KEY_CFM, cfm);
 
@@ -3364,6 +3376,12 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
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

