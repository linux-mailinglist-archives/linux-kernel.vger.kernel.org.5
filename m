Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D193F7DB0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJ2XWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjJ2XWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:22:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7847D8A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:17 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC9A36607324;
        Sun, 29 Oct 2023 23:02:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620572;
        bh=Jlmaekvj2hQJiZVYx0ur3VswhsYpjRjF0Slf4fhImyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5/Za5qX/f5RyiBjvLAk1GRX8JbJYZZxc4QRxhUA6GF1hRLeCIO5EbE+Hkv9N3EjK
         Pz1PUVy/2rpk4UWTW1+ccY6HQCO95x1NlavnfbU+de4gJ85ukcsDYceFr1lI3avV6J
         G7qaSLb1k2WLQdgnI2rMqCh1zK2IAA6MnMcsGSAbZvvIdG/62Op81b2ne4aPtCjifM
         rgbo9XiguiJSziDH9xM00EGN9a0g7TOR+Lw0k1hNNlzYw6QM9HZ16gwFnnmw0uHgft
         kMYRx86WLPfGHRPtoR0ez5igEZb1S1ZFCM+eTvLIKY020GQg71CFKmjQyOSYbxW1CZ
         QNCg2w3IJKnnA==
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
Subject: [PATCH v18 17/26] drm/v3d: Explicitly get and put drm-shmem pages
Date:   Mon, 30 Oct 2023 02:01:56 +0300
Message-ID: <20231029230205.93277-18-dmitry.osipenko@collabora.com>
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

To simplify the drm-shmem refcnt handling, we're moving away from
the implicit get_pages() that is used by get_pages_sgt(). From now on
drivers will have to pin pages while they use sgt. V3D driver doesn't
support shrinker, hence pages are pinned and sgt is valid as long as
pages' use-count > 0.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 42cd874f6810..0597c6b01b6c 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -47,6 +47,9 @@ void v3d_free_object(struct drm_gem_object *obj)
 	/* GPU execution may have dirtied any pages in the BO. */
 	bo->base.pages_mark_dirty_on_put = true;
 
+	if (!obj->import_attach)
+		drm_gem_shmem_put_pages(&bo->base);
+
 	drm_gem_shmem_free(&bo->base);
 }
 
@@ -135,12 +138,18 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
 		return ERR_CAST(shmem_obj);
 	bo = to_v3d_bo(&shmem_obj->base);
 
-	ret = v3d_bo_create_finish(&shmem_obj->base);
+	ret = drm_gem_shmem_get_pages(shmem_obj);
 	if (ret)
 		goto free_obj;
 
+	ret = v3d_bo_create_finish(&shmem_obj->base);
+	if (ret)
+		goto put_pages;
+
 	return bo;
 
+put_pages:
+	drm_gem_shmem_put_pages(shmem_obj);
 free_obj:
 	drm_gem_shmem_free(shmem_obj);
 	return ERR_PTR(ret);
-- 
2.41.0

