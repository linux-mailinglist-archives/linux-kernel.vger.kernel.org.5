Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2AD7D9AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbjJ0OHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345517AbjJ0OHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:07:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBAED6;
        Fri, 27 Oct 2023 07:07:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUrNi003793;
        Fri, 27 Oct 2023 14:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=qegBKtGW+YBLRz6D1T17k35VpwmQBPQSk8faL/IL4fg=;
 b=JP8JwkR42KWSh5llMK3M7lEJxF2RZs9AHLFsI73E0gU1olZWnfGIlv6v9e8nBABsaVny
 +U4OBKrZdWWrLBTq6R37ax2NEuXaouMYQBLGdB+hro2WwdfZHgOuCQUUCnBjnyD6B6uc
 MBQTA+sTPijjwikOUlLZumjsOYE5qjj9B+wEi8Mxcw3Jbj6JpWVVY6oF47yAX3sdBQCL
 JJlRi7GmXlxz7c7LM7f/iYI1nLn0fEl3IZmnNBSAwYecHf+dRb/Vg7ZXeEUj4Zz1HYda
 mguQvQELTtFoUyVF4t+gpW/il1J24gtG4vgzm3UJNSQg5KjvL/bWr1RTws/G3eB32jch RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtb9na8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 14:07:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDU6Js009260;
        Fri, 27 Oct 2023 14:07:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjsvx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 14:07:34 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39RE7X5G024280;
        Fri, 27 Oct 2023 14:07:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tywqjsvwf-1;
        Fri, 27 Oct 2023 14:07:33 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] i915/perf: Fix NULL deref bugs with drm_dbg() calls
Date:   Fri, 27 Oct 2023 07:07:28 -0700
Message-ID: <20231027140729.2505993-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270122
X-Proofpoint-ORIG-GUID: 4GRjFS4CGswat8B1YuhYes0lrVZjnjI_
X-Proofpoint-GUID: 4GRjFS4CGswat8B1YuhYes0lrVZjnjI_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i915 perf interface is not available dereferencing it will lead to
NULL dereferences.

Fix this by using DRM_DEBUG() which the scenario before the commit in
the Fixes tag.

Fixes: 2fec539112e8 ("i915/perf: Replace DRM_DEBUG with driver specific drm_dbg call")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is found using smatch(static analysis tool), only compile tested.
---
 drivers/gpu/drm/i915/i915_perf.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 2f3ecd7d4804..bb48c96b7950 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4228,8 +4228,7 @@ int i915_perf_open_ioctl(struct drm_device *dev, void *data,
 	int ret;
 
 	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+		DRM_DEBUG("i915 perf interface not available for this system\n");
 		return -ENOTSUPP;
 	}
 
@@ -4608,8 +4607,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 	int err, id;
 
 	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+		DRM_DEBUG("i915 perf interface not available for this system\n");
 		return -ENOTSUPP;
 	}
 
@@ -4774,8 +4772,7 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
 	int ret;
 
 	if (!perf->i915) {
-		drm_dbg(&perf->i915->drm,
-			"i915 perf interface not available for this system\n");
+		DRM_DEBUG("i915 perf interface not available for this system\n");
 		return -ENOTSUPP;
 	}
 
-- 
2.39.3

