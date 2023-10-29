Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3EB7DB176
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjJ2XgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjJ2XJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:09:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167ED559B
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:09 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 994336607398;
        Sun, 29 Oct 2023 23:02:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620564;
        bh=6JSrV8dvFR5m76/teSuwB8SoeYdLm77F2T3NdDv9SQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeN7dCvY7+whfuYqVPe+2Zkcivdg478TFFVcsWFNKyHjzKg+m7MoVZVSSKB1sNSFx
         F802eM4s0jQy3ZWMxkxCn3bN1LjkBrADWVn+D9sRF/e+jPFNvgKv/5sbpbTnxjg3Ar
         B/j2uTxhKr2Ki/kNM8LfvZMJ7vcyDhCWcDSAOqL73C0Lf93+eOG6gemcE/fWjkYE/R
         IrCOKoIanJJICwzN6we1X9m5qYIaoq39xRVeIHYHL/UUVLSTNcACsMEaPdziEdVeyr
         a2WuTlEKFZrkv6FFB50n1pZmrL1D/RXpEzwyQ1Nltw8IwG/4On6N0OaXdvJv07yitG
         iZFzaLI7XL2IA==
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
Subject: [PATCH v18 12/26] drm/shmem-helper: Make drm_gem_shmem_get_pages() public
Date:   Mon, 30 Oct 2023 02:01:51 +0300
Message-ID: <20231029230205.93277-13-dmitry.osipenko@collabora.com>
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

We're going to move away from having implicit get_pages() done by
get_pages_sgt() to ease simplify refcnt handling. Drivers will manage
get/put_pages() by themselves. Expose the drm_gem_shmem_get_pages()
in a public drm-shmem API.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 10 +++++++++-
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 24ff2b99e75b..ca6f422c0dfc 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -227,7 +227,14 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
 
-static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
+/*
+ * drm_gem_shmem_get_pages - Increase use count on the backing pages for a shmem GEM object
+ * @shmem: shmem GEM object
+ *
+ * This function Increases the use count and allocates the backing pages if
+ * use-count equals to zero.
+ */
+int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 {
 	int ret;
 
@@ -240,6 +247,7 @@ static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages);
 
 static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 {
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index e7b3f4c02bf5..45cd293e10a4 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -110,6 +110,7 @@ struct drm_gem_shmem_object {
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
 
+int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);
-- 
2.41.0

