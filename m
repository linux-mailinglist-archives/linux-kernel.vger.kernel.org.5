Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DA176A67C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjHABlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjHABln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:41:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1461BD3;
        Mon, 31 Jul 2023 18:41:33 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VFuUS6023863;
        Mon, 31 Jul 2023 18:41:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=vgx8W1pEDySIT9JiCZ7nyjhqaZPBiW70I9WHZj6ZAG0=;
 b=RxCLdzwRHHVWk5V82Ve89r/vonV2lnuipa2RBC/YLcBJcjCnF2ALb+s8cAiTR/kIrWtS
 uCWKq0VLcCU6Z5OhPyq8BAm5/C2pR9ncOut2UPJ4tijeozzFaAcuvrSE+GzLYrzzDXRH
 r/Idm5H9ID4GVHKWhohbpXxylc+hpjFAtoJA2q5E+fIDOc3Z/0QME+jyXqYJ1yvDO/IR
 3Pq1xYTgebNW8JdK7tVmPZhtImye+YI1NG1TirYCWJ33SqFm0aORZU9BwrC5J7gVzI5H
 V9DtbhjhPZ8+I4tQrS0XNMfzL/1GLyPxywA2L9GDoVZ/IXCGB3yVETl83+wEUqn7hkXO hQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s6du0acjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:41:26 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 18:41:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 18:41:24 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id C8BDD3F7059;
        Mon, 31 Jul 2023 18:41:19 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v1 net-next 3/4] tc: flower: Enable offload support IPSEC SPI field.
Date:   Tue, 1 Aug 2023 07:11:00 +0530
Message-ID: <20230801014101.2955887-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801014101.2955887-1-rkannoth@marvell.com>
References: <20230801014101.2955887-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LOoid2ZK-h67B-i7AagBpyhcehNwETef
X-Proofpoint-ORIG-GUID: LOoid2ZK-h67B-i7AagBpyhcehNwETef
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

