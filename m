Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60E0782045
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjHTVy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjHTVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD71A9D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692568454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+R/sWlMT7wVG64uORegqci3bW98/zYiz5u+hdhEocSI=;
        b=E0hhtUd29/P5T+K/lyyXOK4W68cxgvz6CCZB7brk5YyCBbiiwQUrLKCqyuet5SVzZfh+qB
        BDlpWW+2fw71T9pwlPNBNDfAOcT6RFva9eNJKhX9zRW+cGWlV1V9Ateb/s8D+LTmSYPa6U
        3m572SsN3Cxe4pah87PP7MxjND/o2Qk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-y3OSmn3SMYuSPnkY9oXnFA-1; Sun, 20 Aug 2023 17:54:13 -0400
X-MC-Unique: y3OSmn3SMYuSPnkY9oXnFA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5007f3d3293so391652e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692568452; x=1693173252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+R/sWlMT7wVG64uORegqci3bW98/zYiz5u+hdhEocSI=;
        b=OfnOK9HJvFs2UvFMfChZ2gES2J7ldJd480y8pWSObYFVHPwyMCMUZ2t1SeoehcUK6G
         P7ChjYiyQZ0KTtwxvJ/kyoZphqt5zj59gO+GZNd2oqiSa3Kffij93yawl01PldohjeRb
         eePB8IDZmBEqkg6lKjPRlqoB5ZicqdkARyedwyaRdBvLx1QLvRbe2sjmcF/4PJT9OMVG
         YTjF+F0hTfhNVR7Vu4nO+O4Wz/0evgYkuuVGBc8ImSNu8CHyx1w0GBoUgLXDaB5Kf49P
         HEP+HyCjKivEZmHpTLfQUJ8f62vvcfzvI2MrhArg/HZ6xoYNZijT7Ray7dwkeYBMx1tf
         NAWw==
X-Gm-Message-State: AOJu0YxmPNj0vYWDLjnLPQjpG7ZokMp1ow6I1zU7oc3vB4wnyho4duNx
        VIVScmQgJU9n5sxqMnLG4/CNzrWk/U1pHWYsFomFp454yyzA9u3ew2TOtb8WGgHPGcyjp6Skj6k
        8DHfHPj/L9mkNK2K4pchFAzyr
X-Received: by 2002:a05:6512:2396:b0:4fd:fafd:1ed4 with SMTP id c22-20020a056512239600b004fdfafd1ed4mr4221922lfv.2.1692568451865;
        Sun, 20 Aug 2023 14:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQOe6EUHANI7lcqkPBWc4kZcyrIJjTjqCjCwwhLtlytYfuYgg2prfqx79jcLJiK4a6N2mu/w==
X-Received: by 2002:a05:6512:2396:b0:4fd:fafd:1ed4 with SMTP id c22-20020a056512239600b004fdfafd1ed4mr4221907lfv.2.1692568451672;
        Sun, 20 Aug 2023 14:54:11 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id f11-20020aa7d84b000000b005257f2c057fsm4897287eds.33.2023.08.20.14.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 14:54:11 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 1/3] drm: drm_exec: build always builtin
Date:   Sun, 20 Aug 2023 23:53:08 +0200
Message-ID: <20230820215320.4187-2-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820215320.4187-1-dakr@redhat.com>
References: <20230820215320.4187-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_exec must always be builtin for the DRM GPUVA manager to depend on
it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/Kconfig         | 6 ------
 drivers/gpu/drm/Makefile        | 3 +--
 drivers/gpu/drm/nouveau/Kconfig | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index ab9ef1c20349..85122d4bb1e7 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -210,12 +210,6 @@ config DRM_TTM_KUNIT_TEST
 
           If in doubt, say "N".
 
-config DRM_EXEC
-	tristate
-	depends on DRM
-	help
-	  Execution context for command submissions
-
 config DRM_BUDDY
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 215e78e79125..388e0964a875 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -23,6 +23,7 @@ drm-y := \
 	drm_dumb_buffers.o \
 	drm_edid.o \
 	drm_encoder.o \
+	drm_exec.o \
 	drm_file.o \
 	drm_fourcc.o \
 	drm_framebuffer.o \
@@ -80,8 +81,6 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 # Memory-management helpers
 #
 #
-obj-$(CONFIG_DRM_EXEC) += drm_exec.o
-
 obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
 
 drm_dma_helper-y := drm_gem_dma_helper.o
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index c52e8096cca4..2dddedac125b 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -10,7 +10,6 @@ config DRM_NOUVEAU
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select DRM_TTM_HELPER
-	select DRM_EXEC
 	select DRM_SCHED
 	select I2C
 	select I2C_ALGOBIT
-- 
2.41.0

