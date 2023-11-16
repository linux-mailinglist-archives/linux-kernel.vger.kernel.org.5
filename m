Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA39F7EDDB6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjKPJgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjKPJfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:35:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38BA1AD;
        Thu, 16 Nov 2023 01:35:48 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG3iAcb012409;
        Thu, 16 Nov 2023 09:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=qe9t2JXFugy1z6LWQet+kjhPbz3PzaBU8GiYF4CBU3w=;
 b=nGMPahV1m8mK7zB5Xu8lrmZRK7INV3ZvOKHoAmqy27T6cYiInVFwpxsciqwyFVe3r/UG
 t10uY1o+DWEsGFQkbuFADX6Brnyvukp/wMNtwfXaw0TMMHe/C2/8K1kVbaQBorOOtyrz
 GHADWbo/g+nLZWT4yGPJ/IRXIxOfEXtNfWpKeZ5SPV+mUI1BsrWUNgJNDOZsxJ/Xuq6M
 XGCXk2IXcpkIbLS23XDpYEhG/V6aozL5eEWtrTBfxgG6vXcfYd/fsrgxNa4u6ud0NL8y
 +tgvKtQFGfnFrqjhUrbY+L+HhfUSldPV+kUYFJTwHKUYFqZygMi/5eKiq4Y0qzFgc9o6 dw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud41f9hfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:35:23 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AG9ZK2d029214;
        Thu, 16 Nov 2023 09:35:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ua2pmgd87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:35:20 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AG9ZJ38029196;
        Thu, 16 Nov 2023 09:35:19 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3AG9ZJvc029182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:35:19 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
        id A5C0B220C9; Thu, 16 Nov 2023 15:05:18 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 2/3] arm64: defconfig: Enable pinctrl for SDX75
Date:   Thu, 16 Nov 2023 15:05:12 +0530
Message-Id: <20231116093513.14259-3-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116093513.14259-1-quic_rohiagar@quicinc.com>
References: <20231116093513.14259-1-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h3NX73xKXLst2PtnUMeYr9j92kG37MCG
X-Proofpoint-ORIG-GUID: h3NX73xKXLst2PtnUMeYr9j92kG37MCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=411 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160076
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pinctrl framework support for Qualcomm's
SDX75 SoC which is required to boot to console
on sdx75-idp board.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d1be1efa8a23..eeb2ab3a7dec 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -599,6 +599,7 @@ CONFIG_PINCTRL_SC8280XP=y
 CONFIG_PINCTRL_SDM660=y
 CONFIG_PINCTRL_SDM670=y
 CONFIG_PINCTRL_SDM845=y
+CONFIG_PINCTRL_SDX75=y
 CONFIG_PINCTRL_SM6115=y
 CONFIG_PINCTRL_SM6115_LPASS_LPI=m
 CONFIG_PINCTRL_SM6125=y
-- 
2.25.1

