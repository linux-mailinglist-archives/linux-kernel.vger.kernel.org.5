Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06009810F77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378814AbjLMLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378900AbjLMLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:08:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C410DA;
        Wed, 13 Dec 2023 03:08:10 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD9SrVn005079;
        Wed, 13 Dec 2023 11:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=mFa7+wZnRy8DezWqs2TWtFukUiLrknEYht2j11vwEQI=;
 b=OLfn1cUUaZvugeCxGCfUNANx67LReLoh222OPwAsmoPGjF6slgyZo8xyXFbhEXzviUdk
 lJfyFa+8AbN3cUmVzZdstlQyZQ9ETYunh9Lsh0q3LDEfigaXBkifuzIOLYeQS1Snn7rs
 A/U/ckE8tz5CFaK5JPzgmkUMDYS/PZWm+gUze28Wc6/whPQFyD9ffiIALBz1UXnqBG9P
 Jy7ZwqWXCKzS00/cVd3nZYkXkeHryMyXxOM4Jp1RLST3tOufbiHW5iXOh2LH/GTDL1UQ
 5tj0lvxyTVBMYzTnvpR1MPwwrPvLfwaEm1ea4j3kL/y5R0Dg3SatinV7jz7+/caSR10z hQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d81wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 11:08:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD9tffF012911;
        Wed, 13 Dec 2023 11:08:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep83quh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 11:08:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDB84jZ021286;
        Wed, 13 Dec 2023 11:08:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvep83qnv-1;
        Wed, 13 Dec 2023 11:08:04 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] iommu/sva: Fix memory leak in iommu_sva_bind_device()
Date:   Wed, 13 Dec 2023 03:07:25 -0800
Message-ID: <20231213110725.2486815-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_03,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130080
X-Proofpoint-GUID: QLpfW50ZWMtHc4F71hEPSqkn2dGhcpm7
X-Proofpoint-ORIG-GUID: QLpfW50ZWMtHc4F71hEPSqkn2dGhcpm7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the handle when the domain allocation fails before unlocking and
returning.

Fixes: 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.
---
 drivers/iommu/iommu-sva.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 5175e8d85247..c3fc9201d0be 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -101,7 +101,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	domain = iommu_sva_domain_alloc(dev, mm);
 	if (!domain) {
 		ret = -ENOMEM;
-		goto out_unlock;
+		goto out_free_handle;
 	}
 
 	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
@@ -118,6 +118,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 out_free_domain:
 	iommu_domain_free(domain);
+out_free_handle:
 	kfree(handle);
 out_unlock:
 	mutex_unlock(&iommu_sva_lock);
-- 
2.39.3

