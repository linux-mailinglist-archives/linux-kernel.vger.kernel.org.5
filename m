Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC5D76A678
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjHABl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjHABlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:41:24 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B59F1988;
        Mon, 31 Jul 2023 18:41:23 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VFuUS5023863;
        Mon, 31 Jul 2023 18:41:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=WEa+lw+Gy4FNFRcdfAAmYvVMJ35xdXuz+pII2/BOwPo=;
 b=C4hTyGHhCsci1hl1ooeBvHfDSQ5wLfS2bHw3jVyaouFZs8/GURlsDtPRQ+JMbY7jmoqU
 Hqv54k5yAjEziV94RlDEzouDeIohkJmAgynzeKXkw2k5rBmN1pIL63GBXzYELAj+YQPV
 V802jHW5NxT6yhkJEN+3He9buYVo1L217nq026mqqO/jZgA3kzbJ4sDYy4iPHQ+SzUiQ
 Qwpwf12lUkeftg9YYmLkjkhR5RKzaYhugxe5LNgvQbHsHv7ewWGancwbkMhvMhSbhA9q
 Ngvx5Q+OgP7Dm+DBE4fbRrWxtll7nMKQoW8KRCRVuY3s6kHIsSyAPnPx6b512NaAucqN PQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s6du0acjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:41:15 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 18:41:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 18:41:13 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id EE0EB3F7048;
        Mon, 31 Jul 2023 18:41:08 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v1 net-next 1/4] net: flow_dissector: Add IPSEC dissector
Date:   Tue, 1 Aug 2023 07:10:58 +0530
Message-ID: <20230801014101.2955887-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801014101.2955887-1-rkannoth@marvell.com>
References: <20230801014101.2955887-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WAEn8PTXjFPOO2SVQzJD_NQopdcqyK8C
X-Proofpoint-ORIG-GUID: WAEn8PTXjFPOO2SVQzJD_NQopdcqyK8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_18,2023-07-31_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for dissecting IPSEC field SPI (which is
32bits in size) for ESP and AH packets.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 include/net/flow_dissector.h |  9 ++++++
 net/core/flow_dissector.c    | 53 +++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 830f06b2f36d..1a7131d6cb0e 100644
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
@@ -354,6 +362,7 @@ enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_PPPOE, /* struct flow_dissector_key_pppoe */
 	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
 	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
+	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
 
 	FLOW_DISSECTOR_KEY_MAX,
 };
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index ed5dfa376024..89d15ceaf9af 100644
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
-- 
2.25.1

