Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DCB75DF6E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGVXyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGVXxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:53:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BE92699
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:53:22 -0700 (PDT)
Received: from workpc.. (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D0066607106;
        Sun, 23 Jul 2023 00:53:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690070000;
        bh=6qKB4njwK4pvtdiKlbD4ASfNH1pG62XLGXjGDD6zWg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLPvKTRmVWjb8eP4yVT7yKp4jWsOfcORj+1bLwVZ/+JaFFkJWwxRN2dx2zgAZE2ps
         treJE9dWXzxEVgBHhbrcUSDHAfUb9IjMELvZToBHk+rIR53PEPQ1VgmJXefxuRBnix
         OMcwQ3na64zGD8uO+jVav9+ujVVDAurQcatusGTxKKbGnjNhhQHq1WnzP0y/XsWo/m
         6ceOfBM39yyCGFey0wBz/epn+F3D1/wYvxMZ9hUwrx6Z8xr8YaY9egLkw6r3n1C4a+
         WaPSfsoyD2Meiud8VvyFE+zOV7LhHHKfbXTE49KAmdyeenFCT954SKFv0ly1lraXh9
         gS4Cm0/5KW7BQ==
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
Subject: [PATCH v14 12/12] drm/gem: Add _unlocked postfix to drm_gem_pin/unpin()
Date:   Sun, 23 Jul 2023 02:47:46 +0300
Message-ID: <20230722234746.205949-13-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make clear that drm_gem_pin/unpin() functions take reservation lock by
adding _unlocked postfix to the function names.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c      | 4 ++--
 drivers/gpu/drm/drm_internal.h | 4 ++--
 drivers/gpu/drm/drm_prime.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index c18686f434d4..805eb0d85297 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1146,7 +1146,7 @@ void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
 		obj->funcs->print_info(p, indent, obj);
 }
 
-int drm_gem_pin(struct drm_gem_object *obj)
+int drm_gem_pin_unlocked(struct drm_gem_object *obj)
 {
 	if (obj->funcs->pin)
 		return obj->funcs->pin(obj);
@@ -1154,7 +1154,7 @@ int drm_gem_pin(struct drm_gem_object *obj)
 	return 0;
 }
 
-void drm_gem_unpin(struct drm_gem_object *obj)
+void drm_gem_unpin_unlocked(struct drm_gem_object *obj)
 {
 	if (obj->funcs->unpin)
 		obj->funcs->unpin(obj);
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index d7e023bbb0d5..80f5bd1da8fd 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -173,8 +173,8 @@ void drm_gem_release(struct drm_device *dev, struct drm_file *file_private);
 void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
 			const struct drm_gem_object *obj);
 
-int drm_gem_pin(struct drm_gem_object *obj);
-void drm_gem_unpin(struct drm_gem_object *obj);
+int drm_gem_pin_unlocked(struct drm_gem_object *obj);
+void drm_gem_unpin_unlocked(struct drm_gem_object *obj);
 int drm_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map);
 void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
 
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 63b709a67471..8145b49e95ff 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -583,7 +583,7 @@ int drm_gem_map_attach(struct dma_buf *dma_buf,
 	if (!obj->funcs->get_sg_table)
 		return -ENOSYS;
 
-	return drm_gem_pin(obj);
+	return drm_gem_pin_unlocked(obj);
 }
 EXPORT_SYMBOL(drm_gem_map_attach);
 
@@ -601,7 +601,7 @@ void drm_gem_map_detach(struct dma_buf *dma_buf,
 {
 	struct drm_gem_object *obj = dma_buf->priv;
 
-	drm_gem_unpin(obj);
+	drm_gem_unpin_unlocked(obj);
 }
 EXPORT_SYMBOL(drm_gem_map_detach);
 
-- 
2.41.0

