Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A097A6F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjISXgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjISXgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:36:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB93CE;
        Tue, 19 Sep 2023 16:36:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 34ADE6607083;
        Wed, 20 Sep 2023 00:36:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695166566;
        bh=WfmVqHp4HoJXfVeYE4CYy4eKkMUnawX/XEzu8rruf8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5CB5UvA5bECx5iHWKHHROxLc3ssUZ7NVNy2A6FCxMFv9Mw9/nfsItnoj7fMdcrnc
         QJ9p7so/hyytmlx+/JmFvlBUT5ncB7u9kuN8YHVPhcTJ9yFJnLm2/xY5a3VfuyDj9I
         m63jg2JFP6eCw6QqgPc995qVwseFtiO9NeXUs44r30NHe4Q1hzOly0hGG8fjWnm0ev
         VwpRGcASccjmvsPZKiSWeffEE2A868udfqBsiPRMSTfVoYqIhvSOTlni8Fzm4pO6Lo
         dmWxnP81ZOfxSuUJXbJyCsWc8FSzo7DK6m/xVV+/aM6Hyg4bm09M0sOWpGOVkaCYKR
         RcTwDmepl/6uA==
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
        kernel@collabora.com,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v6 4/6] drm/drm_file: Add DRM obj's RSS reporting function for fdinfo
Date:   Wed, 20 Sep 2023 00:34:52 +0100
Message-ID: <20230919233556.1458793-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
References: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
return a more accurate RSS size for their BOs.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/drm_file.c | 5 ++++-
 include/drm/drm_gem.h      | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 883d83bc0e3d..762965e3d503 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -944,7 +944,10 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 		}
 
 		if (s & DRM_GEM_OBJECT_RESIDENT) {
-			status.resident += obj->size;
+			if (obj->funcs && obj->funcs->rss)
+				status.resident += obj->funcs->rss(obj);
+			else
+				status.resident += obj->size;
 		} else {
 			/* If already purged or not yet backed by pages, don't
 			 * count it as purgeable:
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

