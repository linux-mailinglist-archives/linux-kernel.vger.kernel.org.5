Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96CF79FC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjINHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjINHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:01:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D172BE6E;
        Thu, 14 Sep 2023 00:01:18 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E237v6016462;
        Thu, 14 Sep 2023 07:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=LiD3LvDZ+UPBugMGzkY7XarM7OFaqZovwvV8zwDKJCM=;
 b=llfYURq/nkGEqP1JQS3pjafZdaUuZIh4SemFjmAjocVXqMCbnb68HubRLk0NykIUfQHL
 Um0hj7RIXW93LgjlUN7+EZXPGYwsEfqoede05wOgMQs94XTEa116ZtRV2qL6wv6IEsOY
 j0m+SB/LsTreApdQLTbLs5CwK/tS1qzE85hFNPqh5HjnSpRdPQMtR/zcHy1m31IhMP/c
 PPijBHv4rq/f6IHXl4vQGWlLJ6GKwZ200qiQXXXokHey4Vaphw3Q8HG94O5hMjMcvKKI
 qsVWmt34/KNGkgnEkV2/tFJ9bn9REUsSN+aNmxZOQkrI5NW4Qa7lz59AOOtCutZb3kmi IA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3dj8a6c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:01:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E70vrw020152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:00:57 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 00:00:51 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Thu, 14 Sep 2023 12:29:57 +0530
Subject: [PATCH v2 07/11] clk: qcom: apss-ipq6018: add the GPLL0 clock also
 as clock provider
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230913-gpll_cleanup-v2-7-c8ceb1a37680@quicinc.com>
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
In-Reply-To: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sricharan Ramabadhran" <quic_srichara@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>,
        Robert Marko <robimarko@gmail.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694674810; l=1271;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=0WLXM7UqBZpsd0pHbjXLnJu/oCGwNfmF+vKO/PV2u8k=;
 b=fycx2BXyEF2j8rwWSoyeowB/WDt1d7i0/e6F/ZzF6MjPiruezY08l5sje0mGps2MWjtNyCboh
 K/puEx6hiooAuC61b9fZdGKgTY0FQ+XqOTnJez5ZbGOiY8nQOxEolf2
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gywkCSXhlFJUEcY0CM-i6lZ8dJlbK2oO
X-Proofpoint-ORIG-GUID: gywkCSXhlFJUEcY0CM-i6lZ8dJlbK2oO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_04,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=975 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the kernel is booting up, APSS PLL will be running at 800MHz with
GPLL0 as source. Once the cpufreq driver is available, APSS PLL will be
configured and select the rate based on the opp table and the source will
be changed to APSS_PLL_EARLY.

Without this patch, CPU Freq driver reports that CPU is running at 24MHz
instead of the 800MHz.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Pick up te R-b and T-b tags. Thanks Robert!
---
 drivers/clk/qcom/apss-ipq6018.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index f2f502e2d5a4..4e13a085a857 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -20,16 +20,19 @@
 
 enum {
 	P_XO,
+	P_GPLL0,
 	P_APSS_PLL_EARLY,
 };
 
 static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
 	{ .fw_name = "xo" },
+	{ .fw_name = "gpll0" },
 	{ .fw_name = "pll" },
 };
 
 static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
 	{ P_XO, 0 },
+	{ P_GPLL0, 4 },
 	{ P_APSS_PLL_EARLY, 5 },
 };
 

-- 
2.34.1

