Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670827694FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjGaLfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGaLfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:35:06 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A31E57;
        Mon, 31 Jul 2023 04:35:02 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UNIc31012062;
        Mon, 31 Jul 2023 04:34:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=vgx8W1pEDySIT9JiCZ7nyjhqaZPBiW70I9WHZj6ZAG0=;
 b=ZMi/Wg0tPL0dsr7Vqsp8QYCuYHYJnF25p96ZvUEN7ZQswUrz6TUiOHFHlRWrkOQ7cz3w
 /m2tKPWkLacGzGlfhlvQ1TAs7vl8UAk+1+PirtdODm46w0b9fOrlHHxO5riqKQYbQIXj
 7HOg6qnYvMiffjdBbg37inJ8wiBMt4fVZrt3RkiGDU8aPbJJydKxgUiNGjqub9gTq8WO
 JD1GBThnkzdOYZKpOcD/2S9qZY2tDhHAUohkbvghH2PkoKZnRJD/GiHDT9GY5HzihLs8
 sYqneByWSlUSj3ILSu7dIAHrbJ1q3uHjfFPEmS5zj+xiArsPv1i1InnEof3TdvrSuExj 7Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529k4qh3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:34:55 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 04:34:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 04:34:46 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 8DCB83F70BC;
        Mon, 31 Jul 2023 04:34:41 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next 3/4] tc: flower: Enable offload support IPSEC SPI field.
Date:   Mon, 31 Jul 2023 17:04:07 +0530
Message-ID: <20230731113408.2586913-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731113408.2586913-1-rkannoth@marvell.com>
References: <20230731113408.2586913-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OUjm-omyBsg_PYkYg992KkVlqPgjoaGq
X-Proofpoint-ORIG-GUID: OUjm-omyBsg_PYkYg992KkVlqPgjoaGq
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

This patch enables offload for TC classifier
flower rules which matches against SPI field.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 include/net/flow_offload.h | 6 ++++++
 net/core/flow_offload.c    | 7 +++++++
 2 files changed, 13 insertions(+)

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
-- 
2.25.1

