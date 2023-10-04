Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5957B7A15
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbjJDIcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjJDIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:32:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD18A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:32:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c5db4925f9so5413445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696408351; x=1697013151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZldOxV+c4bwKc6J0kQAYnC3fAIMV5HICSvouxRGQ9mg=;
        b=PLt/tn5rhBlKITEM1j71HDrlwhZdco8miFPRc+gWxsMLPhsAE2E6Mv9xsYgaQ9K8Q7
         n4DlFi0MFWDKspxYmego5FIgIzPNeDHFAFFOTYwnHhSCZjg/3p7NoenjPPGgc7g7v76s
         ylyISSR0nfx9GWDkvFZQAM5nS2208ftJUjsQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408351; x=1697013151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZldOxV+c4bwKc6J0kQAYnC3fAIMV5HICSvouxRGQ9mg=;
        b=VcWIzS5NXQC5zXvLugtifNpSsHWDvpalhTKnivJgbbEv+7JGuCOoFK2i9OoRoerp7d
         glFvy8zllvulxul9uYMbK0Yj3rPkVv3yfPaKVjf0tui+BvK9guX+vOY1WAIwd5oE6/8v
         zoupeTAieoXBqH17oxWHIDubSw121U6IpizcA82Em6Rz8hlGEYjutRk/aJagXZiUBH3n
         tBoQM6LzxqqYC/dwNVrzPQg6m5W5WbGh/ngM6FSRj/rxNrWX5WIKkgjVVskFqtOvKQaz
         nXOVvWvELidvF36hIjH8475OgXqDZ+qSsomkZDJP1keVVltDCQEMdQUjWVeh690Rjfam
         TINg==
X-Gm-Message-State: AOJu0YzhnYF5Ufe2GS4HDrX56vZoXQRdgIyJAhTyEI05btLsYdUZNr2L
        yuCiP2d7sxMtf2unWoLs+KI0kg==
X-Google-Smtp-Source: AGHT+IHPFtFRpDAbBWYZ0AkQ+t6cKaHbihDnGlYJ+Lg4L83KqHlHsnttPEhpVTVbh8QLQYPAN7bkZA==
X-Received: by 2002:a17:902:db11:b0:1b8:8682:62fb with SMTP id m17-20020a170902db1100b001b8868262fbmr8840475plx.4.1696408351467;
        Wed, 04 Oct 2023 01:32:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:eff2:d66d:cbf7:f41b])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902b28b00b001b890009634sm3015940plr.139.2023.10.04.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:32:31 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH v2] drm/mediatek: Correctly free sg_table in gem prime vmap
Date:   Wed,  4 Oct 2023 16:32:24 +0800
Message-ID: <20231004083226.1940055-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek DRM driver implements GEM PRIME vmap by fetching the
sg_table for the object, iterating through the pages, and then
vmapping them. In essence, unlike the GEM DMA helpers which vmap
when the object is first created or imported, the MediaTek version
does it on request.

Unfortunately, the code never correctly frees the sg_table contents.
This results in a kernel memory leak. On a Hayato device with a text
console on the internal display, this results in the system running
out of memory in a few days from all the console screen cursor updates.

Add sg_free_table() to correctly free the contents of the sg_table. This
was missing despite explicitly required by mtk_gem_prime_get_sg_table().

Also move the "out" shortcut label to after the kfree() call for the
sg_table. Having sg_free_table() together with kfree() makes more sense.
The shortcut is only used when the object already has a kernel address,
in which case the pointer is NULL and kfree() does nothing. Hence this
change causes no functional change.

Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Please merge for v6.6 fixes.

Also, I was wondering why the MediaTek DRM driver implements a lot of
the GEM functionality itself, instead of using the GEM DMA helpers.
From what I could tell, the code closely follows the DMA helpers, except
that it vmaps the buffers only upon request.

 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 9f364df52478..0e0a41b2f57f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -239,6 +239,7 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	npages = obj->size >> PAGE_SHIFT;
 	mtk_gem->pages = kcalloc(npages, sizeof(*mtk_gem->pages), GFP_KERNEL);
 	if (!mtk_gem->pages) {
+		sg_free_table(sgt);
 		kfree(sgt);
 		return -ENOMEM;
 	}
@@ -248,12 +249,15 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
 	if (!mtk_gem->kvaddr) {
+		sg_free_table(sgt);
 		kfree(sgt);
 		kfree(mtk_gem->pages);
 		return -ENOMEM;
 	}
-out:
+	sg_free_table(sgt);
 	kfree(sgt);
+
+out:
 	iosys_map_set_vaddr(map, mtk_gem->kvaddr);
 
 	return 0;
-- 
2.42.0.582.g8ccd20d70d-goog

