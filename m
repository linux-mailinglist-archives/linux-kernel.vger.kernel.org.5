Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA27DB0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjJ2XTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjJ2XTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:19:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8527295
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:21 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D51C766073AE;
        Sun, 29 Oct 2023 23:02:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620578;
        bh=wqGvYp+XsBubezC7g24J4y9IRLkJRkmLc/LBzEkyYBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOwYdYKjt/I83fqDDsTMg5Buu1wHFIkeuyU9wAcSaZy3NfTy6QueCldxukReDXMo3
         KBPvD83s9Glkx/p+53DWqpsQHJm+S0ci8yNyxTwamtrjRvAFIQz0FU6NOPJe6sJzsb
         cSuipy3uuEDuZgiK4toXK1IG6qQBdkNeIGgNjnj57QkEtNdzrsm93/1UBbgpAVAdjX
         Lot0g4ZFK+tKMsJLbrn+6DzBWbCp0cW9/2Jt5leAiGDM91fUu6C5b4afwkU8AQBY0a
         YECMj0VIWnka9VVDcHBwwap2dQUuNs2oJc+meDtl3mrAoSYWUeQUhvf8k1DRoHIEI1
         jZWv4n6jSLZrw==
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
Subject: [PATCH v18 21/26] drm/shmem-helper: Optimize unlocked get_pages_sgt()
Date:   Mon, 30 Oct 2023 02:02:00 +0300
Message-ID: <20231029230205.93277-22-dmitry.osipenko@collabora.com>
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

SGT isn't refcounted. Once SGT pointer has been obtained, it remains the
same for both locked and unlocked get_pages_sgt(). Return cached SGT
directly without taking a potentially expensive lock.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 560ce565f376..6dd087f19ea3 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -955,6 +955,9 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
 	drm_WARN_ON(obj->dev, drm_gem_shmem_is_evictable(shmem));
 	drm_WARN_ON(obj->dev, drm_gem_shmem_is_purgeable(shmem));
 
+	if (shmem->sgt)
+		return shmem->sgt;
+
 	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.41.0

