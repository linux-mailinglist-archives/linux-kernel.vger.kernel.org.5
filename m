Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD8A76A838
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjHAFXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjHAFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:23:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C8E1FC0;
        Mon, 31 Jul 2023 22:23:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKfvWB001804;
        Tue, 1 Aug 2023 05:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=uDDsmX1jYKwRiKdRgTn6Do7DO7+Qpy1gQbAxQ7dwHxQ=;
 b=I9Da7zH7Ya1+vOOUrTX8LtrhtqV5dwlb9eOsYK1lt6XwjgtOvGglk3NdfgQFWJhWFSR4
 cMOoFBmHWkUd8qMdt8v0uvETY4xYlm/NrfvpVc2i3+r3p0H2dqccD/uv9TwBadm/ko2Z
 UDnvkEdKgVPfBEVs1pu+6ZB08h4udJGfls/pZSIHSlXGK+TX0G6GCKmCeQ5ooozXAU+D
 VWa7PjNqhwb/61KMZE8yPzVGCg7ebDXIOSW9p5Vhm/xh3eG7ZrDu0JSDBHRT/H87SFW4
 pB2tD7cWN7cqcR/Dlv9xfXQKRbsMj3TEZnN6eEyPt/cGVh/9RabsmGeMBgrbKmxrJdfm kA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc44qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 05:23:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3713IQeV008656;
        Tue, 1 Aug 2023 05:23:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7c7pt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 05:23:28 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3715NSb5017842;
        Tue, 1 Aug 2023 05:23:28 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s4s7c7pse-1;
        Tue, 01 Aug 2023 05:23:28 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH next] mmc: sunplus: Fix error handling in spmmc_drv_probe()
Date:   Mon, 31 Jul 2023 22:23:20 -0700
Message-ID: <20230801052321.1328225-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010050
X-Proofpoint-ORIG-GUID: KrYsyNLaPxCfYNeLm8pheAnWVsrY0hxP
X-Proofpoint-GUID: KrYsyNLaPxCfYNeLm8pheAnWVsrY0hxP
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few issues in spmmc_drv_probe():

1. When mmc allocation fails, goto is a no-op.
2. When mmc allocation succeeds, the error paths should use goto instead
   of direct return.
3. platform_get_irq() doesn't return zero, so '<' is sufficient.

Fix the above issues by adding goto instead of direct return, also
remove NULL check in 'probe_free_host' as we changed the goto to return
when mmc_alloc_host() fails.

Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with Smatch. Only compile tested.
---
 drivers/mmc/host/sunplus-mmc.c | 41 ++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index a55a87f64d2a..21cd49be08c0 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -864,10 +864,8 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	int ret = 0;
 
 	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto probe_free_host;
-	}
+	if (!mmc)
+		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -875,30 +873,40 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	host->dma_int_threshold = 1024;
 
 	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(host->base))
-		return PTR_ERR(host->base);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
+		goto probe_free_host;
+	}
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(host->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
+	if (IS_ERR(host->clk)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
+		goto probe_free_host;
+	}
 
 	host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(host->rstc))
-		return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
+	if (IS_ERR(host->rstc)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
+		goto probe_free_host;
+	}
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0)
-		return host->irq;
+	if (host->irq < 0) {
+		ret = host->irq;
+		goto probe_free_host;
+	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
 					spmmc_irq, spmmc_func_finish_req, IRQF_SHARED,
 			NULL, host);
 	if (ret)
-		return ret;
+		goto probe_free_host;
 
 	ret = clk_prepare_enable(host->clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
+	if (ret) {
+		ret = dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
+		goto probe_free_host;
+	}
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
@@ -940,8 +948,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	clk_disable_unprepare(host->clk);
 
 probe_free_host:
-	if (mmc)
-		mmc_free_host(mmc);
+	mmc_free_host(mmc);
 
 	return ret;
 }
-- 
2.39.3

