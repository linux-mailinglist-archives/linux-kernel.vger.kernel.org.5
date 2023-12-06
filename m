Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D825807102
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378580AbjLFNiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378598AbjLFNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:38:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E85D45;
        Wed,  6 Dec 2023 05:38:26 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6D0CVR011334;
        Wed, 6 Dec 2023 13:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=GakJHKGu69ztNO4tMJWAvjGJM5Xzuv9z4sr0PjJwrwU=;
 b=ogblgeEQs6GFJ8rmAlLyWG50pzOvL2mPGttuAn3NtjqOXGuUskk6zrIGE7fUgM6p2O50
 jeRSSduAh5quPsDuA23K7Iepxy49y/n411XKavrrDWvc7Ks4b7Mx+m7ShcSKbTA9Vq9v
 +ld4xKTThlXfTxIUxloP7elEIE4E/mjrgD7baKH6McBWHW418f2HH7ps7Hp1+5UqsjbZ
 hoWW7L1lKgFjoR6yuC3p6gp9bNRUNzTzmBeIc0B3Fpv4axO+p/tKTXkKUka/huvMe8Tl
 Ovqr6igQ38p3S59ZxivDI3EvgyigbEwDF4fqF4LjHH9/YMFHj3thxHt/Ve+g9DRmYm8N 4A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdcasvgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 13:38:19 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B6DcFAb001824;
        Wed, 6 Dec 2023 13:38:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3uqwnm5d3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 06 Dec 2023 13:38:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6DcFwL001816;
        Wed, 6 Dec 2023 13:38:15 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3B6DcE6i001815;
        Wed, 06 Dec 2023 13:38:15 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id DD6B85000B1; Wed,  6 Dec 2023 19:08:13 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>,
        Manish Pandey <quic_mapa@quicinc.com>
Subject: [PATCH V4] scsi: ufs: core: store min and max clk freq from OPP table
Date:   Wed,  6 Dec 2023 19:08:12 +0530
Message-Id: <20231206133812.21488-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x399GgyCS9gp5JR1Ulrg6kvRt0L7stHk
X-Proofpoint-ORIG-GUID: x399GgyCS9gp5JR1Ulrg6kvRt0L7stHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_10,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060111
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OPP support added by commit 72208ebe181e ("scsi: ufs: core: Add support
for parsing OPP") doesn't update the min_freq and max_freq of each clocks
in 'struct ufs_clk_info'.

But these values are used by the host drivers internally for controller
configuration. When the OPP support is enabled in devicetree, these
values will be 0, causing boot issues on the respective platforms.

So add support to parse the min_freq and max_freq of all clocks while
parsing the OPP table.

Fixes: 72208ebe181e ("scsi: ufs: core: Add support for parsing OPP")
Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
Changes from v3:
- updated commit description and comment to address christoph's comment

Changes from v2:
- increment idx in dev_pm_opp_get_freq_indexed

Changes from v1:
As per Manivannan's comment:
- Updated commmit description
- Sort include file alphabetically
- Added missing dev_pm_opp_put
- updated function name and documention
- removed ret variable
---
 drivers/ufs/host/ufshcd-pltfrm.c | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index da2558e274b4..0983cee6355e 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -8,6 +8,7 @@
  *	Vinayak Holikatti <h.vinayak@samsung.com>
  */

+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
@@ -213,6 +214,54 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
 	}
 }

+/**
+ * ufshcd_parse_clock_min_max_freq  - Parse MIN and MAX clocks freq
+ * @hba: per adapter instance
+ *
+ * This function parses MIN and MAX frequencies of all clocks required
+ * by the host drivers.
+ *
+ * Returns 0 for success and non-zero for failure
+ */
+static int ufshcd_parse_clock_min_max_freq(struct ufs_hba *hba)
+{
+	struct list_head *head = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
+	struct dev_pm_opp *opp;
+	unsigned long freq;
+	u8 idx = 0;
+
+	list_for_each_entry(clki, head, list) {
+		if (!clki->name)
+			continue;
+
+		clki->clk = devm_clk_get(hba->dev, clki->name);
+		if (!IS_ERR(clki->clk)) {
+			/* Find Max Freq */
+			freq = ULONG_MAX;
+			opp = dev_pm_opp_find_freq_floor_indexed(hba->dev, &freq, idx);
+			if (IS_ERR(opp)) {
+				dev_err(hba->dev, "Failed to find OPP for MAX frequency\n");
+				return PTR_ERR(opp);
+			}
+			clki->max_freq = dev_pm_opp_get_freq_indexed(opp, idx);
+			dev_pm_opp_put(opp);
+
+			/* Find Min Freq */
+			freq = 0;
+			opp = dev_pm_opp_find_freq_ceil_indexed(hba->dev, &freq, idx);
+			if (IS_ERR(opp)) {
+				dev_err(hba->dev, "Failed to find OPP for MIN frequency\n");
+				return PTR_ERR(opp);
+			}
+			clki->min_freq = dev_pm_opp_get_freq_indexed(opp, idx++);
+			dev_pm_opp_put(opp);
+		}
+	}
+
+	return 0;
+}
+
 static int ufshcd_parse_operating_points(struct ufs_hba *hba)
 {
 	struct device *dev = hba->dev;
@@ -279,6 +328,10 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
 		return ret;
 	}

+	ret = ufshcd_parse_clock_min_max_freq(hba);
+	if (ret)
+		return ret;
+
 	hba->use_pm_opp = true;

 	return 0;
--
2.17.1

