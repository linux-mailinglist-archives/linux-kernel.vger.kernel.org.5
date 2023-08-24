Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757D37864AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbjHXBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbjHXBgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:36:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9E10F3;
        Wed, 23 Aug 2023 18:36:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DECAA6607258;
        Thu, 24 Aug 2023 02:36:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692840980;
        bh=+2KM1DEiC6BQLJ3HGtxuRCPGXZeQnpj0AJsnMTmVj50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7mT7sGWuJlkMiWornURZMB+E5G4mCRB9NjA2pjlHeF0kVVzDHEzbhIvAQeraJ6+4
         m0UiJDKuZZHnVYA6/V3gk6v3hCB7ArJC3Wro42v2QtaVstge0jvkpZBGN56z/ADiNO
         PuWy1JI/gnO+1/zfzYOgh8JOAL9nssIPogvIE2gdbcK/GVb29CGW3+EHFJnYUgSCwE
         oFZe48OzIEiAuUUvOIStY3WUC84JojZHcuETgE6YFugMqlyDqdEIlCIY/zQfmGDtPB
         YwK3htMttqYpliW6ePlWDmiXdy2Hf6F5zgD5s8pZ/zkeqJnM/QAc2GYgTy3A9lEHAZ
         701r595T/9iCw==
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
        kernel@collabora.com
Subject: [PATCH v2 3/6] drm/panfrost: Add fdinfo support for memory stats
Date:   Thu, 24 Aug 2023 02:34:46 +0100
Message-ID: <20230824013604.466224-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824013604.466224-1-adrian.larumbe@collabora.com>
References: <20230824013604.466224-1-adrian.larumbe@collabora.com>
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

A new DRM GEM object function is added so that drm_show_memory_stats can
provider more accurate memory usage numbers.

Ideally, in panfrost_gem_status, the BO's purgeable flag would be checked
after locking the driver's shrinker mutex, but drm_show_memory_stats takes
over the drm file's object handle database spinlock, so there's potential
for a race condition here.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c |  9 +++++++--
 drivers/gpu/drm/panfrost/panfrost_gem.c | 12 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 3fd372301019..93d5f5538c0b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -440,11 +440,14 @@ static int panfrost_ioctl_madvise(struct drm_device *dev, void *data,
 	args->retained = drm_gem_shmem_madvise(&bo->base, args->madv);
 
 	if (args->retained) {
-		if (args->madv == PANFROST_MADV_DONTNEED)
+		if (args->madv == PANFROST_MADV_DONTNEED) {
 			list_move_tail(&bo->base.madv_list,
 				       &pfdev->shrinker_list);
-		else if (args->madv == PANFROST_MADV_WILLNEED)
+			bo->is_purgable = true;
+		} else if (args->madv == PANFROST_MADV_WILLNEED) {
 			list_del_init(&bo->base.madv_list);
+			bo->is_purgable = false;
+		}
 	}
 
 out_unlock_mappings:
@@ -559,6 +562,8 @@ static void panfrost_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	struct panfrost_device *pfdev = dev->dev_private;
 
 	panfrost_gpu_show_fdinfo(pfdev, file->driver_priv, p);
+
+	drm_show_memory_stats(p, file);
 }
 
 static const struct file_operations panfrost_drm_driver_fops = {
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 3c812fbd126f..aea16b0e4dda 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -195,6 +195,17 @@ static int panfrost_gem_pin(struct drm_gem_object *obj)
 	return drm_gem_shmem_pin(&bo->base);
 }
 
+static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj)
+{
+	struct panfrost_gem_object *bo = to_panfrost_bo(obj);
+	enum drm_gem_object_status res = 0;
+
+	res |= (bo->is_purgable) ? DRM_GEM_OBJECT_PURGEABLE : 0;
+
+	res |= (bo->base.pages) ? DRM_GEM_OBJECT_RESIDENT : 0;
+
+	return res;
+}
 static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.free = panfrost_gem_free_object,
 	.open = panfrost_gem_open,
@@ -206,6 +217,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = drm_gem_shmem_object_mmap,
+	.status = panfrost_gem_status,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index ad2877eeeccd..e06f7ceb8f73 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -38,6 +38,7 @@ struct panfrost_gem_object {
 
 	bool noexec		:1;
 	bool is_heap		:1;
+	bool is_purgable	:1;
 };
 
 struct panfrost_gem_mapping {
-- 
2.42.0

