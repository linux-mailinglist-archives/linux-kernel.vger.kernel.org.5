Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1F75AE97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGTMk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGTMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:40:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91A2137;
        Thu, 20 Jul 2023 05:40:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K94mAl032672;
        Thu, 20 Jul 2023 12:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=YysB9TeNdCNJSoyionbj0U3Aa3+Is2qgwJN5fXaFT7o=;
 b=0r4hERFa9JOeC0djA4o3L1MelHdpe10X7rgpfz2Cp/43wHD8UrvlZENaK+P7+V5IPC9m
 fVqPkwPRWUXN4FlVPwErwPYq+1pHIAfYUGNOGJpdGY1HrDgHG+gCJWmU0dK7xRYrAB/W
 fa2tvlA2Z5hme+FD5YmNL+/sAskl7id/yBwVgfNpfYMO4GwBNGDjICX3jQuw3n0gcMdl
 OTMOR8NU1A9/403yqBMLCuURLFDRy0tnUO63t+5ycWpI0oAUJqCo/u8TCGwv22S8RXNY
 LRNswW5MtDc53KlQToFhuNH0C/fgicP3qV4rWM5I+pEyrG07hYBzmU/Bs2wDNDMiqFW4 aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a9p00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 12:40:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KAf1ZC000777;
        Thu, 20 Jul 2023 12:40:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8mnhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 12:40:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36KCe8f8017919;
        Thu, 20 Jul 2023 12:40:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw8mngn-1;
        Thu, 20 Jul 2023 12:40:07 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH next] drm/loongson: Fix error handling in lsdc_pixel_pll_setup()
Date:   Thu, 20 Jul 2023 05:39:50 -0700
Message-ID: <20230720123950.543082-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200106
X-Proofpoint-ORIG-GUID: eG8Ucx40h9qnpY7ugnvGOs0VH_wx6f0Q
X-Proofpoint-GUID: eG8Ucx40h9qnpY7ugnvGOs0VH_wx6f0Q
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

There are two problems in lsdc_pixel_pll_setup()
1. If kzalloc() fails then call iounmap() to release the resources.
2. Both kzalloc and ioremap doesnot return error pointers on failure, so
   using IS_ERR_OR_NULL() checks is a bit confusing and not very right,
   fix this by changing those to NULL checks instead.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is found with static analysis with smacth and only compile tested.
---
 drivers/gpu/drm/loongson/lsdc_pixpll.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_pixpll.c b/drivers/gpu/drm/loongson/lsdc_pixpll.c
index 04c15b4697e2..2609a2256da4 100644
--- a/drivers/gpu/drm/loongson/lsdc_pixpll.c
+++ b/drivers/gpu/drm/loongson/lsdc_pixpll.c
@@ -120,12 +120,14 @@ static int lsdc_pixel_pll_setup(struct lsdc_pixpll * const this)
 	struct lsdc_pixpll_parms *pparms;
 
 	this->mmio = ioremap(this->reg_base, this->reg_size);
-	if (IS_ERR_OR_NULL(this->mmio))
+	if (!this->mmio)
 		return -ENOMEM;
 
 	pparms = kzalloc(sizeof(*pparms), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(pparms))
+	if (!pparms) {
+		iounmap(this->mmio);
 		return -ENOMEM;
+	}
 
 	pparms->ref_clock = LSDC_PLL_REF_CLK_KHZ;
 
-- 
2.39.3

