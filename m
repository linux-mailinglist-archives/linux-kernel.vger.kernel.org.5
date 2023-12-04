Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AB803269
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjLDMVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:21:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055AAC3;
        Mon,  4 Dec 2023 04:21:39 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4C9q80016735;
        Mon, 4 Dec 2023 12:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=jIS5wAnVSsNNvK1fqn1ZGEXn0mdtAdWPjrHPs/QHSv0=;
 b=ipJDJFSkkoQ8OSQPZhk5NGBF5GWZGXGxxoWTDFq3JcYkMP4DJvuuZu/eIYPnB/4q0Mrb
 l10CkBMRPOR0Vi120mKOdhXeJmoF2YR8NUbfL1LIQD0ZZvYmp0MGmmWbdbIZZcR+gwAI
 MjPpaT+niWJSaI2c7dmkvCF5OPyaNRvUL4kavB5aXNv4AG45M70K4ndvhTP4s019D2o8
 hXCm/qVQx7W2gcEw1lAA3Uuvay76uqF4WaREhS7p0HazCbuUx+1zj5k/NKoDp5t51uzB
 OB1HVK4NEblxEw6mQ4R+DarG/CuKMFyt8U7y3gVdkrI3YH6zkQC6kvO44SIbfQMdZ1SA uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usec201h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 12:21:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4BaSvE014380;
        Mon, 4 Dec 2023 12:21:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15p761-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 12:21:06 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B4CL692015651;
        Mon, 4 Dec 2023 12:21:06 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uqu15p74p-1;
        Mon, 04 Dec 2023 12:21:06 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH next] drm/v3d: Fix missing error code in v3d_submit_cpu_ioctl()
Date:   Mon,  4 Dec 2023 04:21:01 -0800
Message-ID: <20231204122102.181298-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040093
X-Proofpoint-GUID: FqbDJb9ICTqnlVj5k1F4_ZyMkZQBve0e
X-Proofpoint-ORIG-GUID: FqbDJb9ICTqnlVj5k1F4_ZyMkZQBve0e
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

Smatch warns:
	drivers/gpu/drm/v3d/v3d_submit.c:1222 v3d_submit_cpu_ioctl()
	warn: missing error code 'ret'

When there is no job type or job is submitted with wrong number of BOs
it is an error path, ret is zero at this point which is incorrect
return.

Fix this by changing it to -EINVAL.

Fixes: aafc1a2bea67 ("drm/v3d: Add a CPU job submission")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis and only compile tested.
---
 drivers/gpu/drm/v3d/v3d_submit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index d7a9da2484fd..fcff41dd2315 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1219,11 +1219,13 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	/* Every CPU job must have a CPU job user extension */
 	if (!cpu_job->job_type) {
 		DRM_DEBUG("CPU job must have a CPU job user extension.\n");
+		ret = -EINVAL;
 		goto fail;
 	}
 
 	if (args->bo_handle_count != cpu_job_bo_handle_count[cpu_job->job_type]) {
 		DRM_DEBUG("This CPU job was not submitted with the proper number of BOs.\n");
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.39.3

