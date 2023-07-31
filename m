Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12776913A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGaJOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjGaJO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:14:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCD123;
        Mon, 31 Jul 2023 02:14:25 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V6ZgpQ009122;
        Mon, 31 Jul 2023 09:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=+eP0sdLFFRFH1w+5ltT1uqBPynt5gUa0ydFr6fMznAI=;
 b=mYFA7GgD1OgO1Tv/4uC95TtELeoQAJWaw14pL5pwJdXa75d7dZXcVAGLqHg5IMSlGIPT
 NcnsvkBOLK+WQn9M8ty3vwqAniXtyg9i1EKEadVaUMHt31qotfIbHoMAWvEby/35+l5D
 iHfvxO0LJjxZsMU5CpWq6iPQkWnmUxHRzgDrRuSgu84pJ/b3obu5xUPtnBJz3XaL9FJv
 R7/hQqTkiyJht9yscD0OT3Qx3FgO09NtxelPBQqhXiw5V0lelTc5NA4mrcZZPC+yQbsi
 7Ah+Bvj82NPREZyD2zlsnCYK72Y9gRtw1cjIh7UEDWGiNSGAsyzaCpYDyvrby84eIUzM Hw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uat33rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:14:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V9EKOM028054
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:14:20 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 02:14:17 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_clew@quicinc.com>
Subject: [PATCH] soc: qcom: qmi_encdec: Restrict string length in decode
Date:   Mon, 31 Jul 2023 14:44:08 +0530
Message-ID: <20230731091408.2458199-1-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0dyGBnqj_p7AryjKd9MKOsQGQJLU3BF8
X-Proofpoint-GUID: 0dyGBnqj_p7AryjKd9MKOsQGQJLU3BF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_02,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMI TLV value for strings in a lot of qmi element info structures
account for null terminated strings with MAX_LEN + 1. If a string is
actually MAX_LEN + 1 length, this will cause an out of bounds access
when the NULL character is appended in decoding.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 drivers/soc/qcom/qmi_encdec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index b7158e3c3a0b..5c7161b18b72 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -534,8 +534,8 @@ static int qmi_decode_string_elem(const struct qmi_elem_info *ei_array,
 		decoded_bytes += rc;
 	}
 
-	if (string_len > temp_ei->elem_len) {
-		pr_err("%s: String len %d > Max Len %d\n",
+	if (string_len >= temp_ei->elem_len) {
+		pr_err("%s: String len %d >= Max Len %d\n",
 		       __func__, string_len, temp_ei->elem_len);
 		return -ETOOSMALL;
 	} else if (string_len > tlv_len) {
-- 
2.34.1

