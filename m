Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE3F806F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377809AbjLFLvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377866AbjLFLvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:51:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871BCD50;
        Wed,  6 Dec 2023 03:51:04 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B65Qfq0008176;
        Wed, 6 Dec 2023 11:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=snB+DpGVYHYt5o/g5tggaObVxBLjRa5sA4skzlIREMY=;
 b=ouhQbk+oVxG9VYEFqSu6/lEKAhRQHzzgCRG5NSR6wDc1KMCvdOB6/h2JIy+vUHTWYa1B
 J7gBtIytuBagxuw8lybi8y4Cl3uOhq8Z/gYpLJ9HJUL87q2WUpV626+qKGOIZGPhTCUR
 caH0Qd+ZVxdaQqqXw26pNeVIRynFMNb9OTtWEyVnVSDuOiHjKMtje2X2EOM69QbnG7BD
 xkkgPYgZBiF4FECRhu8ScTVxzRuexZ0nT2PleOHq0RrPjqGbMU5/fBUW00A73JOsy+o8
 64k6wr/OCao2310BcqT2egxcdy33ggTKIr04p+t0bFd7YLN83qPrzRy4ckcFraQouAX6 mg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdadsgc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 11:47:07 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B6BjFbt016216;
        Wed, 6 Dec 2023 11:47:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3uqwnm4tny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 06 Dec 2023 11:47:02 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6Bl2g8018398;
        Wed, 6 Dec 2023 11:47:02 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3B6Bl22B018377;
        Wed, 06 Dec 2023 11:47:02 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 0D93B5000B1; Wed,  6 Dec 2023 17:17:01 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>,
        Manish Pandey <quic_mapa@quicinc.com>
Subject: [PATCH V2] scsi: ufs: core: store min and max clk freq from OPP table
Date:   Wed,  6 Dec 2023 17:16:59 +0530
Message-Id: <20231206114659.13009-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZJ9AZol17sQe52LRjs98Bha33N4sBAY_
X-Proofpoint-ORIG-GUID: ZJ9AZol17sQe52LRjs98Bha33N4sBAY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_09,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060098
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OPP support added by commit 72208ebe181e ("scsi: ufs: core: Add support
for parsing OPP") doesn't update the min_freq and max_freq of each clocks
in 'struct ufs_clk_info'.

But these values are used by the vendor host drivers internally for
controller configuration. When the OPP support is enabled in devicetree,
these values will be 0, causing boot issues on the respective platforms.

So add support to parse the min_freq and max_freq of all clocks while
parsing the OPP table.

Fixes: 72208ebe181e ("scsi: ufs: core: Add support for parsing OPP")
Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
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
index da2558e274b4..409efa0db8fa 100644
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
+ * by the vendor host drivers.
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
+			opp = dev_pm_opp_find_freq_ceil_indexed(hba->dev, &freq, idx++);
+			if (IS_ERR(opp)) {
+				dev_err(hba->dev, "Failed to find OPP for MIN frequency\n");
+				return PTR_ERR(opp);
+			}
+			clki->min_freq = dev_pm_opp_get_freq_indexed(opp, idx);
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

