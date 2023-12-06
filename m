Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC78066A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376716AbjLFFlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjLFFk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:40:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81522D3;
        Tue,  5 Dec 2023 21:41:04 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B64lO5A014334;
        Wed, 6 Dec 2023 05:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=DSEsi6ha8d2Dap2LNtqekCrbHlg2RMsuNLxo/jOQbS4=;
 b=HUTmrx+ngT2R2pX+clnkwa8QshV9gvXuYR3aNBQeXdQF8XbjgpbyMIVpXZSYciofkhu/
 tbjpvN8TycYCUtxIMRF8sw+ZFz/JroVzsHq+dVRecwhknQez72X50IU3o+xDOic7eU8K
 e1eeKnf9Awujf1tH1C8q3RNlB3ZmqSGkX/+14qhWue7N2T/ST7zCD5DAH6xSJ/uHykEp
 acyik2seAgNu/w74BVxkeDDWqnSr7GTBgbPQDSeCNz+iPSkF7hE34DD1KmrLRn/70v1Y
 ec+XmyLWb6GVfHDnWJhz2eJwPDkr4hZBRyIWT6A8UtynTmXds2A6ujn7sBUi8yesNfz/ Ng== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd1n0p7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 05:36:40 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B65ablv009558;
        Wed, 6 Dec 2023 05:36:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3uqwnkryxu-1;
        Wed, 06 Dec 2023 05:36:37 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B65abDk009553;
        Wed, 6 Dec 2023 05:36:37 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3B65aaCt009552;
        Wed, 06 Dec 2023 05:36:37 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id C868D5000B1; Wed,  6 Dec 2023 11:06:35 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, quic_cang@quicinc.com,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Manish Pandey <quic_mapa@quicinc.com>
Subject: [PATCH V1] scsi: ufs: core: store min and max clk freq from OPP table
Date:   Wed,  6 Dec 2023 11:06:28 +0530
Message-Id: <20231206053628.32169-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JcWSzxgYC0qjNSj5G2k8Q-T0vKclwx2B
X-Proofpoint-GUID: JcWSzxgYC0qjNSj5G2k8Q-T0vKclwx2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_04,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312060045
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OPP support will make use of OPP table in device tree and removes
freq-table-hz property from device tree.

With OPP enabled in devicetree, clki->min_freq and clki->maxfreq
currently is not getting updated and the value is set to 0.

Soc vendors like qcom, mediatek uses clki->minfreq and clki->maxfreq
in vendor specific file. These frequencies values are used to update
vendor specific configurations. Since the value is 0, it is causing
functional issue.

Add code to store the min and max ufs clk frequency from OPP table.

Fixes: 72208ebe181e ("scsi: ufs: core: Add support for parsing OPP")
Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufshcd-pltfrm.c | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index da2558e274b4..12fa6f7d6a97 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -13,6 +13,7 @@
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/clk.h>

 #include <ufs/ufshcd.h>
 #include "ufshcd-pltfrm.h"
@@ -213,6 +214,55 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
 	}
 }

+/**
+ * ufshcd_config_min_max_clk_freq - update min and max freq
+ * @hba: per adapter instance
+ *
+ * This function store min and max freq for all the clocks.
+ *
+ * Returns 0 for success and non-zero for failure
+ */
+static int ufshcd_config_min_max_clk_freq(struct ufs_hba *hba)
+{
+	struct list_head *head = &hba->clk_list_head;
+	struct dev_pm_opp *opp;
+	struct ufs_clk_info *clki;
+	unsigned long freq;
+	u8 idx = 0;
+	int ret;
+
+	list_for_each_entry(clki, head, list) {
+		if (!clki->name)
+			continue;
+
+		clki->clk = devm_clk_get(hba->dev, clki->name);
+		if (!IS_ERR_OR_NULL(clki->clk)) {
+			/* Find Max Freq */
+			freq = ULONG_MAX;
+			opp = dev_pm_opp_find_freq_floor_indexed(hba->dev, &freq, idx);
+			if (IS_ERR(opp)) {
+				dev_err(hba->dev, "failed to find dev_pm_opp\n");
+				ret = PTR_ERR(opp);
+				return ret;
+			}
+			clki->max_freq = dev_pm_opp_get_freq_indexed(opp, idx);
+
+			/* Find Min Freq */
+			freq = 0;
+			opp = dev_pm_opp_find_freq_ceil_indexed(hba->dev, &freq, idx);
+			if (IS_ERR(opp)) {
+				dev_err(hba->dev, "failed to find dev_pm_opp\n");
+				ret = PTR_ERR(opp);
+				return ret;
+			}
+			clki->min_freq = dev_pm_opp_get_freq_indexed(opp, idx);
+			idx++;
+		}
+	}
+
+	return 0;
+}
+
 static int ufshcd_parse_operating_points(struct ufs_hba *hba)
 {
 	struct device *dev = hba->dev;
@@ -279,6 +329,12 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
 		return ret;
 	}

+	ret = ufshcd_config_min_max_clk_freq(hba);
+	if (ret) {
+		dev_err(dev, "Failed to get min max freq: %d\n", ret);
+		return ret;
+	}
+
 	hba->use_pm_opp = true;

 	return 0;
--
2.17.1

