Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E687753F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjHIHSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHIHSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:18:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178521BCF;
        Wed,  9 Aug 2023 00:18:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3794P8lg031848;
        Wed, 9 Aug 2023 07:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=VeqHu8sZLiFLMdgcIzTyJGviQjbnz6KSyK1BX8Dx/so=;
 b=axMTGxNbrEYaOA3AbIdPsi/HpthnEtTzF2oztQlq6bJcss9pVj+bz1rP/WwncE5bRMrj
 nE31YtIOal1OPFeYvvEN6ipgQ3N6dqo+QuYPxKYG5Lz1pZVHIlfels84KIuzIqtDrDKH
 ltHy+72o4EGoQzBwb2FFNR8kEf9dgeAVajkNLZJUYIRJ7H1s9+Xxr84yOXB+qNCDcpd4
 WwwQCzm5+NHtAhFoXId2hTxGeb/tPcmzO3Ps1hKRN6+vkQupOaviAdFlVVDlnGTd/c34
 mZcNs9Jl9+m+n6u/BVKpucAUpwYMHWvSRblNlFHUWRFmaNViLM11ac/p6i51XY3uMKdd 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbc8408-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 07:18:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3795jmFR021400;
        Wed, 9 Aug 2023 07:18:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvdn0pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 07:18:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3797Idt4039843;
        Wed, 9 Aug 2023 07:18:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3s9cvdn0nx-1;
        Wed, 09 Aug 2023 07:18:39 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, dan.carpenter@linaro.org
Cc:     arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, error27@gmail.com,
        harshit.m.mogalapalli@oracle.com, kernel-janitors@vger.kernel.org
Subject: [PATCH next v2 1/2] mmc: sunplus: Fix error handling in spmmc_drv_probe()
Date:   Wed,  9 Aug 2023 00:18:11 -0700
Message-ID: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_05,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090063
X-Proofpoint-ORIG-GUID: mfotAyxPi_3bhWNPosR6a7WJtMs5yKid
X-Proofpoint-GUID: mfotAyxPi_3bhWNPosR6a7WJtMs5yKid
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mmc allocation succeeds, the error paths are not freeing mmc.

Fix the above issue by changing mmc_alloc_host() to devm_mmc_alloc_host()
to simplify the error handling. Remove label 'probe_free_host' as devm_*
api takes care of freeing, also remove mmc_free_host() from remove
function as devm_* takes care of freeing.

Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.

v1->v2: Simplify code by using devm_mmc_alloc_host() instead of
mmc_alloc_host() (Ulf Hansson's suggestion)
---
 drivers/mmc/host/sunplus-mmc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index a55a87f64d2a..2bdebeb1f8e4 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -863,11 +863,9 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	struct spmmc_host *host;
 	int ret = 0;
 
-	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto probe_free_host;
-	}
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct spmmc_host));
+	if (!mmc)
+		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -938,11 +936,6 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 
 clk_disable:
 	clk_disable_unprepare(host->clk);
-
-probe_free_host:
-	if (mmc)
-		mmc_free_host(mmc);
-
 	return ret;
 }
 
@@ -956,7 +949,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
 	pm_runtime_put_noidle(&dev->dev);
 	pm_runtime_disable(&dev->dev);
 	platform_set_drvdata(dev, NULL);
-	mmc_free_host(host->mmc);
 
 	return 0;
 }
-- 
2.39.3

