Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1A7B0E18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjI0Vbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjI0Vbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:31:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0C126;
        Wed, 27 Sep 2023 14:31:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32989660731A;
        Wed, 27 Sep 2023 22:31:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695850303;
        bh=y6K2Kxu+7xbA/SYhPSA1aQAKzrnxHm217qP6EJXy33k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuD2g74XuKA8eLOn8SB7wUNUHAdhShM14NlITc5I/jKUCTSd5JLE5D8tggnEg/Eh6
         uBwUEQeaj0YB1owIQXRaemgkBk871wZr9vzwNcUWphNlHLNFQDk82Wosg3umDK2C/R
         CvLbRrt/hJ1vtRXoDJ5aFUsaxvXujgoDj6ZpaWo4lAHZo8Qga0XiBEkCPqMV8fGBvl
         MZXo5g6TTB4IlphG5F1ofceeuRyfo3OvG2Xnveqa1ydrAm+N6B4xTowFBdz55SJdRj
         w5utSsaf1/4udLisIOs1Wd4BpSxoqc6LwAWGWGpU7B81uoAW/dN/q7MRNgLFo5clKI
         rD7WW6X/ROS1g==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     adrian.larumbe@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com, tvrtko.ursulin@linux.intel.com,
        boris.brezillon@collabora.com
Subject: [PATCH v7 4/5] drm/drm_file: Add DRM obj's RSS reporting function for fdinfo
Date:   Wed, 27 Sep 2023 22:29:58 +0100
Message-ID: <20230927213133.1651169-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
References: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some BO's might be mapped onto physical memory chunkwise and on demand,
like Panfrost's tiler heap. In this case, even though the
drm_gem_shmem_object page array might already be allocated, only a very
small fraction of the BO is currently backed by system memory, but
drm_show_memory_stats will then proceed to add its entire virtual size to
the file's total resident size regardless.

This led to very unrealistic RSS sizes being reckoned for Panfrost, where
said tiler heap buffer is initially allocated with a virtual size of 128
MiB, but only a small part of it will eventually be backed by system memory
after successive GPU page faults.

Provide a new DRM object generic function that would allow drivers to
return a more accurate RSS and purgeable sizes for their BOs.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/drm_file.c | 8 +++++---
 include/drm/drm_gem.h      | 9 +++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 883d83bc0e3d..9a1bd8d0d785 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -930,6 +930,8 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 	spin_lock(&file->table_lock);
 	idr_for_each_entry (&file->object_idr, obj, id) {
 		enum drm_gem_object_status s = 0;
+		size_t add_size = (obj->funcs && obj->funcs->rss) ?
+			obj->funcs->rss(obj) : obj->size;
 
 		if (obj->funcs && obj->funcs->status) {
 			s = obj->funcs->status(obj);
@@ -944,7 +946,7 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 		}
 
 		if (s & DRM_GEM_OBJECT_RESIDENT) {
-			status.resident += obj->size;
+			status.resident += add_size;
 		} else {
 			/* If already purged or not yet backed by pages, don't
 			 * count it as purgeable:
@@ -953,14 +955,14 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 		}
 
 		if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true))) {
-			status.active += obj->size;
+			status.active += add_size;
 
 			/* If still active, don't count as purgeable: */
 			s &= ~DRM_GEM_OBJECT_PURGEABLE;
 		}
 
 		if (s & DRM_GEM_OBJECT_PURGEABLE)
-			status.purgeable += obj->size;
+			status.purgeable += add_size;
 	}
 	spin_unlock(&file->table_lock);
 
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index bc9f6aa2f3fe..16364487fde9 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -208,6 +208,15 @@ struct drm_gem_object_funcs {
 	 */
 	enum drm_gem_object_status (*status)(struct drm_gem_object *obj);
 
+	/**
+	 * @rss:
+	 *
+	 * Return resident size of the object in physical memory.
+	 *
+	 * Called by drm_show_memory_stats().
+	 */
+	size_t (*rss)(struct drm_gem_object *obj);
+
 	/**
 	 * @vm_ops:
 	 *
-- 
2.42.0

