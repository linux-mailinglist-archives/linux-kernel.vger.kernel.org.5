Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0557753F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjHIHTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjHIHTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:19:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D101FD0;
        Wed,  9 Aug 2023 00:19:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3796qtmn027037;
        Wed, 9 Aug 2023 07:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=xyjIwviWQ1Y4Ul0E3eBRLFREfmmQQQHeusPVsYsC+rY=;
 b=EmABS84CdywCzOfltQJQv96L4iiUSlvwKYV9y7rXoYdpSotnFTr+hLpQCeSaXe04E7Jw
 KbMZamfR0FuJ6bQ/GM6sXIwv8TINi0wD/io46pVBWCNFs/emvGvlW80KX1J679L42vJk
 ywvEevL6AyR37bTRTnhRkN/sY81JfZo2nyV4RldbhAEziabGMyf5Ik9YX1PpIVSKt/T+
 JcmOWJ+TUZjF8N3T99ooQV9Kg6hwvtNxllbSdJcb0oG8+hS9NXzR+wqZIlvtHcmHrkGs
 /t12wdqJJ8uGFaBlVxYbG8c4MZsct//E5oonLvgEKIQS451UgpsyVBQI9pyIremOOcR1 IA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaar1er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 07:18:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3795wulp022167;
        Wed, 9 Aug 2023 07:18:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvdn12w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 07:18:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3797Idt6039843;
        Wed, 9 Aug 2023 07:18:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3s9cvdn0nx-2;
        Wed, 09 Aug 2023 07:18:53 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, dan.carpenter@linaro.org
Cc:     arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, error27@gmail.com,
        harshit.m.mogalapalli@oracle.com, kernel-janitors@vger.kernel.org
Subject: [PATCH next v2 2/2] mmc: sunplus: Fix platform_get_irq() error checking
Date:   Wed,  9 Aug 2023 00:18:12 -0700
Message-ID: <20230809071812.547229-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com>
References: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_05,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090063
X-Proofpoint-ORIG-GUID: QIuaasK0VBi-D7t0kNkI7SdqIIbhabU7
X-Proofpoint-GUID: QIuaasK0VBi-D7t0kNkI7SdqIIbhabU7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq() function returns negative error codes on failure.

Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v1->v2: Split into two patches as they are doing different things.

This is based on static analysis with smatch, only compile tested.
---
 drivers/mmc/host/sunplus-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index 2bdebeb1f8e4..e9cb1a57cb75 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -885,7 +885,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0)
+	if (host->irq < 0)
 		return host->irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
-- 
2.39.3

