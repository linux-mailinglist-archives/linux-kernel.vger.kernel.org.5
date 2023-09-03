Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D610C790D03
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjICRIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344384AbjICRIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:08:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE93106
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:08:43 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 15EDB66071F4;
        Sun,  3 Sep 2023 18:08:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693760922;
        bh=JSMRwiEgAtRV+rZZyvXx/rNB4W7SizXZUQgRnIwQVuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtkberEj2p5mchU3AeGdlzHZQfBcB4sMk9n5l/8S5mfBWTMyGoWgBdZWdn45tyQ+B
         zMrjKWKwlI2TO2kOj0d+R4Q4LRCZzWGfwEFi2g8E8A17tgR3ksu6qLvoFjePlRK4/R
         4iCD3pkiCgC42YcyJwxAkrSriFN5J8pTu3syG0NwpBriQ4tha7Tx1ThaC1p2W6NZs0
         56J93DC2O0c6OCqAZrPJlh0Kekxh8NlJLaJpLfDvPrEmpb1OeLatNMOAd+67jT1oJO
         c3CJHLRN4TNfnnesDcLCAxNQf2k5J4RABGq80d2MnJW+jwAyz72KPC1pyavzUSJT0O
         tGevfT2Ngzg0g==
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
Subject: [PATCH v16 04/20] drm/gem: Add _locked postfix to functions that have unlocked counterpart
Date:   Sun,  3 Sep 2023 20:07:20 +0300
Message-ID: <20230903170736.513347-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
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

Add _locked postfix to drm_gem functions that have unlocked counterpart
functions to make GEM functions naming more consistent and intuitive in
regards to the locking requirements.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c | 6 +++---
 include/drm/drm_gem.h     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index fae5832bb0bd..8c0268944199 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1488,10 +1488,10 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
 EXPORT_SYMBOL(drm_gem_lru_scan);
 
 /**
- * drm_gem_evict - helper to evict backing pages for a GEM object
+ * drm_gem_evict_locked - helper to evict backing pages for a GEM object
  * @obj: obj in question
  */
-int drm_gem_evict(struct drm_gem_object *obj)
+int drm_gem_evict_locked(struct drm_gem_object *obj)
 {
 	dma_resv_assert_held(obj->resv);
 
@@ -1503,4 +1503,4 @@ int drm_gem_evict(struct drm_gem_object *obj)
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_gem_evict);
+EXPORT_SYMBOL(drm_gem_evict_locked);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 110a9c0ea42b..d8dedb1f0968 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -542,7 +542,7 @@ unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru,
 			       unsigned long *remaining,
 			       bool (*shrink)(struct drm_gem_object *obj));
 
-int drm_gem_evict(struct drm_gem_object *obj);
+int drm_gem_evict_locked(struct drm_gem_object *obj);
 
 #ifdef CONFIG_LOCKDEP
 /**
-- 
2.41.0

