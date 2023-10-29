Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EEF7DB0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjJ2XUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjJ2XUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:20:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381CE7692
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:21 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 546C36607396;
        Sun, 29 Oct 2023 23:02:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620579;
        bh=8rtXn19fvaBXhb48S1Y4vYdXdzNTfF4j95pl2pB4Jj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRGBZwF1NKhPQjB1XQlhRcOVPXHE84vqpNBhZrkK8krkrkiczEXKlHJqJFSt5Ww9A
         li5hV7sh/Zq/Gg8hOZjrbJ9jpEIg9QckJmNImb4IvRjWhWqpNpxAvikQCnNIelyYfe
         LBNNSlcea5YhZowelFyeGDaSya0NHk+bytBWQ1/1BxxYsUIgX7OHsQGKsMo+HFNH+s
         71KYOKFuX8jktieetnuG3bIEH/j5eJOHRWcuFXlSBi1nt+QhKLXN+XqfN3fV7kTL8d
         JIwe/KHanbZO0DjJ6j6zPyZTADs7al9+xga2M3r83xbeXc/8hUodG7MCY27isI+Edj
         xQFYRgY+PCaug==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v18 22/26] drm/shmem-helper: Don't free refcounted GEM
Date:   Mon, 30 Oct 2023 02:02:01 +0300
Message-ID: <20231029230205.93277-23-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't free refcounted shmem object to prevent use-after-free bug that
is worse than a memory leak.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 6dd087f19ea3..4253c367dc07 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -203,9 +203,10 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 	if (obj->import_attach)
 		drm_prime_gem_destroy(obj, shmem->sgt);
 
-	drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
-	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
-	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
+	if (drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count)) ||
+	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count)) ||
+	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count)))
+		return;
 
 	drm_gem_object_release(obj);
 	kfree(shmem);
-- 
2.41.0

