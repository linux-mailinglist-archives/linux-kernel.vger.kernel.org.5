Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE1E7AD5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjIYK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjIYK3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:29:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088B9B;
        Mon, 25 Sep 2023 03:28:58 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P8eEgU012494;
        Mon, 25 Sep 2023 10:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=vws1dp5OU+F2CqVIXLbul7wyURVu7p3uJsVpOZVrkwo=;
 b=V2qkHE9XgnNVKwvUSX/IK5gnGU8stqHCdFWyv2O2NZxGzJ1vOno7idTybDy/dLkw3GEU
 I6+WRd1KZFaT3bxxdIXW8QyeWpFGyswelgy4RxhTzMNB5nMUvvso02VBebLh/CgC7U65
 8hhoiIZivrMImWdV8NMLk7BB9LqeSQrUgTvzfeEXMDEgqfrkhSx4lbi/LFROl7cEaKqu
 j8yecKejxrIQs74jfRYIxYX9IEOiga2ZD+X2eP99UVWLEMO8b0hOi7YkzXPPjvkl6zY1
 hCE+ByQ8xbHQSK2dzpOJ3Ry30J+ti1nce+qw9qd2tlJsMi24/jBc9D2/3mIH5v1XPhki Mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9safbsrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:28:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PASiDu031432
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:28:44 GMT
Received: from hu-gokulsri-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 25 Sep 2023 03:28:39 -0700
From:   Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
To:     <dmitry.baryshkov@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <jassisinghbrar@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>
Subject: [PATCH V3 0/3] Add APSS clock driver support for IPQ5018
Date:   Mon, 25 Sep 2023 15:58:23 +0530
Message-ID: <20230925102826.405446-1-quic_gokulsri@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I0WKHb-HDuuba0GaV1oevpXrrllpqIS8
X-Proofpoint-GUID: I0WKHb-HDuuba0GaV1oevpXrrllpqIS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=643 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the APSS clock to bump the CPU frequency
above 800MHz. APSS PLL found in the IPQ5018 is of type Stromer. 

- The first patch in the series adds the required a53pll compatible.

- The second patch reuses Stormer Plus PLL offsets, adds configuration values
  for Stromer.

- The third patch adds dts nodes to enable the pll along with the cpu
  operating frequency table.

This series depends on below series
https://patchwork.kernel.org/project/linux-arm-msm/cover/20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com/

Changes in v3:
- Addressed review comment by Dmitry in patch 3.

Changes in v2:
- Addressed review comments
- Adds dependency on above mentioned patch series for dropping
  CLK_SET_RATE_PARENT flag from GPLL clocks, GPLL0 clock provider for
  mailbox
- Add CPU operating point at 800MHz based on the review comments.

Gokul Sriram Palanisamy (3):
  dt-bindings: clock: qcom,a53pll: add IPQ5018 compatible
  clk: qcom: apss-ipq-pll: add support for IPQ5018
  arm64: dts: qcom: ipq5018: enable the CPUFreq support

 .../bindings/clock/qcom,a53pll.yaml           |  1 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 40 +++++++++++++++++++
 drivers/clk/qcom/apss-ipq-pll.c               | 21 ++++++++++
 3 files changed, 62 insertions(+)

-- 
2.34.1

