Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD0E75DF59
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGVXxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGVXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:53:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A8A0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:53:05 -0700 (PDT)
Received: from workpc.. (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D4F5D66070FD;
        Sun, 23 Jul 2023 00:53:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690069984;
        bh=ItwtACNwTldcczPDEGjsi3ay6TWYAqy3UP5lTHw/868=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hN9csKS5hXLd+tCj6f229JGO9sZuI4TkAhHk0pgon60xN4YKJPFvjn5i4ySWNYgpH
         ECLj3GXfvCoU2IwcWPd/QzeEAFaPXBVKEEkjqOLcvAS0OhfaY+jZ64niPiQ83FLAcc
         BYHGz6qceVEJecgFyAe/+DrmTGyGRF+5C5e8hdVA3BJFKPxK94UGLQ0VBmf5nWTw2g
         A1kdLuYe1lfryIw+cIhIdybTidYNidU3ES/HU7SLr6aXL1ML7QKGFD1ItyYXRX2ODq
         h6JSaL170AzfOmAS7AwUski65DJHVovLCzd009pn1IXDEjOElKJ6EfIXEP+2sPa0Vs
         QIkdhC3Iucz3w==
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
Subject: [PATCH v14 02/12] drm/shmem-helper: Add pages_pin_count field
Date:   Sun, 23 Jul 2023 02:47:36 +0300
Message-ID: <20230722234746.205949-3-dmitry.osipenko@collabora.com>
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

And new pages_pin_count field to struct drm_gem_shmem_object that will
determine whether pages are evictable by memory shrinker. The pages will
be evictable only when pages_pin_count=0. This patch prepares code for
addition of the memory shrinker that will utilize the new field.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 9 +++++++++
 include/drm/drm_gem_shmem_helper.h     | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 267153853e2c..42ba201dda50 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -274,15 +274,24 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 	dma_resv_assert_held(shmem->base.resv);
 
 	ret = drm_gem_shmem_get_pages(shmem);
+	if (!ret)
+		shmem->pages_pin_count++;
 
 	return ret;
 }
 
 static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
 {
+	struct drm_gem_object *obj = &shmem->base;
+
 	dma_resv_assert_held(shmem->base.resv);
 
+	if (drm_WARN_ON_ONCE(obj->dev, !shmem->pages_pin_count))
+		return;
+
 	drm_gem_shmem_put_pages(shmem);
+
+	shmem->pages_pin_count--;
 }
 
 /**
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index bf0c31aa8fbe..7111f5743006 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -39,6 +39,15 @@ struct drm_gem_shmem_object {
 	 */
 	unsigned int pages_use_count;
 
+	/**
+	 * @pages_pin_count:
+	 *
+	 * Reference count on the pinned pages table.
+	 * The pages allowed to be evicted by memory shrinker
+	 * only when the count is zero.
+	 */
+	unsigned int pages_pin_count;
+
 	/**
 	 * @madv: State for madvise
 	 *
-- 
2.41.0

