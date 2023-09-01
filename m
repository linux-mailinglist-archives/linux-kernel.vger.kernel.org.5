Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A978FC7B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjIALon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjIALol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:44:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C089D10D2;
        Fri,  1 Sep 2023 04:44:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3815vaL5003525;
        Fri, 1 Sep 2023 11:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=O8sZ2FQUD6yKcJ5az9yIPexHXPlnR4H6esMtC6yX0y0=;
 b=kI9faYvhCLcf7pZYFgfL/vrwG0YnpfpWwdIUd80UWLWYPRZUj4vYlnMFgoOvI+dxOVh+
 iJSZht5U/IxWKErZjguuNQ7HfwuPZwBBV4wKJ0/pdBR8szNgc4cNkikxf/To+oMBgKjK
 SPDHX9m5lMRy4sRiWOfH3ZyEYImg7gudkMHCh/HoTfEGFMCEMngoVYBDwRrbp0it8s8U
 yozP4B2aZBRl+j+v8xVGIKfq307r5+PR1JxTsVmQ4ilXlM5tWqMkoWb2U8mNTGoOpj5s
 xqwQsKcCJaPUqM+0lLtgoBRqnwv9CZhbH+ejaaAsXrSaUyJjN8CBgswX2T0PaotrzQMs TA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stpy9bq1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 11:43:29 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 381BgoCk013964;
        Fri, 1 Sep 2023 11:43:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sqafmj06y-1;
        Fri, 01 Sep 2023 11:43:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381Bgmwu013924;
        Fri, 1 Sep 2023 11:43:25 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 381BhPL2014533;
        Fri, 01 Sep 2023 11:43:25 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id E56585006A6; Fri,  1 Sep 2023 17:13:24 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V6 6/6] scsi: ufs: qcom: Configure clk HW division based on scaling conditions.
Date:   Fri,  1 Sep 2023 17:12:42 +0530
Message-Id: <20230901114242.31219-7-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230901114242.31219-1-quic_nitirawa@quicinc.com>
References: <20230901114242.31219-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SYlh6frL2Vg0_uSm6skisQ5416HpPVID
X-Proofpoint-GUID: SYlh6frL2Vg0_uSm6skisQ5416HpPVID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=965 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010109
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a) Enable internal HW division of unipro core_clk for scale up condition.
b) Clear internal HW division of unipro core_clk for scale down condition.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 31 +++++++++++++++++--------------
 drivers/ufs/host/ufs-qcom.h |  2 +-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index c251c98a74f0..2ddda9356abc 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1389,18 +1389,21 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
 		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, cycles_in_1us);
 	}

-	/* Clear CORE_CLK_DIV_EN */
-	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
+	/* Enable CORE_CLK_DIV_EN for scale up condition */
+	if (is_max_freq)
+		core_clk_ctrl_reg |= CORE_CLK_DIV_EN_BIT;

 	ret = ufshcd_dme_set(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    core_clk_ctrl_reg);
+	if (ret)
+		return ret;
 	/*
 	 * UFS host controller V4.0.0 onwards needs to program
 	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
 	 * frequency of unipro core clk of UFS host controller.
 	 */
-	if (!ret && (host->hw_ver.major >= 4)) {
+	if (host->hw_ver.major >= 4) {
 		if (cycles_in_40ns > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
 			return -EINVAL;

@@ -1451,26 +1454,26 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	int err;
-	u32 core_clk_ctrl_reg;
+	int ret;
+	u32 reg;

 	if (!ufs_qcom_cap_qunipro(host))
 		return 0;

-	err = ufshcd_dme_get(hba,
+	ret = ufshcd_dme_get(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
-			    &core_clk_ctrl_reg);
+			    &reg);
+	if (ret)
+		return ret;

 	/* make sure CORE_CLK_DIV_EN is cleared */
-	if (!err &&
-	    (core_clk_ctrl_reg & DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT)) {
-		core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
-		err = ufshcd_dme_set(hba,
+	if (reg & CORE_CLK_DIV_EN_BIT) {
+		reg &= ~CORE_CLK_DIV_EN_BIT;
+		ret = ufshcd_dme_set(hba,
 				    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
-				    core_clk_ctrl_reg);
+				    reg);
 	}
-
-	return err;
+	return ret;
 }

 static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index bc176ef58e3e..bf0c370c79c7 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -141,7 +141,7 @@ enum {
 /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
 #define CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
 #define CLK_1US_CYCLES_MASK				GENMASK(7, 0)
-#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT	BIT(8)
+#define CORE_CLK_DIV_EN_BIT				BIT(8)
 #define PA_VS_CORE_CLK_40NS_CYCLES			0x9007
 #define PA_VS_CORE_CLK_40NS_CYCLES_MASK			GENMASK(6, 0)

--
2.17.1

