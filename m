Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62242759001
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGSIQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjGSIQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1184199D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bcU/rlpXrVWc1+sSauJ1JjLJG+mGlwSz84SkWL7yj6M=;
        b=RuhC6Ulhq6vATitW+k2GZ4MHmSdbxPS4TBd5dKwg1LNlS1B4PQ2Tqh4G70tK/aqNEJOoBF
        5wqXf6CRayjXOMgIJ/eQEMKokOD4hnoQJaIH2BLs+aMB/nqYdSKe8M+4Xv6kHXUZvLiDOv
        AdAHAPChxFc4x0W8qD/R+JPi7q2BVL8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-o8aDADOxPnGndmO5r2i3kA-1; Wed, 19 Jul 2023 04:15:59 -0400
X-MC-Unique: o8aDADOxPnGndmO5r2i3kA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314326f6e23so3685463f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754558; x=1690359358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcU/rlpXrVWc1+sSauJ1JjLJG+mGlwSz84SkWL7yj6M=;
        b=YrIrERba/CvNkfeaHMnGh4z3ttO+ZooU+Z29SmfcFxJ+sAEASFsvGDgAtpZ7m0lHkg
         5NP4H8C6aibSiZhLPy2Po+N+gj7CAW7o8oMjjO801NKL/25CTmX+6pWmYcG6+V7rhd2K
         ygFATduz7vMbPOhgKIaEIf89i/r2RmpNE8g00vJ+j4TKxNSp2K0NJyVzq7Y/Z2Y5F2ek
         cW/BhRua/73IUlpwkexXFlA9VOmargbYuTh4vFEdR2QBihGHlnyBf10jxwHiUqu/3KvR
         LH0n6lZjC/29XPHr9/QhGgad+nwCDL1092ZmVIEiQT+AAH0Fefv/4CX1enmellsbbtsT
         TSBA==
X-Gm-Message-State: ABy/qLbTJm4yYPSMCpmNLdVNimGyZZqDP4jA1GKc7MJ3a0Lhs2X3GKV/
        +78VdtAeI1CCeeqHbh2/9VWfaGhyn/SFb3uhBmd/7yiI3KvqLvYQNHbnnEn0rzYxO+wgI57EPs1
        DCCryh7uoRblKMZxk422nvjOp564vyo4xPwuLG3zn4hVROTjiGBsgoKbQp5txS/78CLjQdV0TF1
        b25U3Fi9Y=
X-Received: by 2002:a05:6000:1372:b0:314:12b8:641c with SMTP id q18-20020a056000137200b0031412b8641cmr11957818wrz.70.1689754558441;
        Wed, 19 Jul 2023 01:15:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHsbVjauFmNT/vRl+JPx4O3MKbI+jZCgByxetPf2Hfe5iKn6L05qJBLj522sJa1I8oKCRJP7g==
X-Received: by 2002:a05:6000:1372:b0:314:12b8:641c with SMTP id q18-20020a056000137200b0031412b8641cmr11957800wrz.70.1689754558149;
        Wed, 19 Jul 2023 01:15:58 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d5385000000b0031423a8f4f7sm4574354wrv.56.2023.07.19.01.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:15:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 4/4] drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled
Date:   Wed, 19 Jul 2023 10:15:38 +0200
Message-ID: <20230719081544.741051-5-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719081544.741051-1-javierm@redhat.com>
References: <20230719081544.741051-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that fbdev core has been split in FB_CORE and FB, make the DRM symbol
to select the FB_CORE option if the DRM fbdev emulation layer is enabled.

This allows to disable the CONFIG_FB option if is not needed, which will
avoid the need to explicitly disable each of the legacy fbdev drivers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
---

(no changes since v3)

Changes in v3:
- Make the DRM symbol to select FB_CORE if DRM_FBDEV_EMULATION is
  enabled (Arnd Bergmann).
- Also make DRM select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
- Make DRM_FBDEV_EMULATION to depend on DRM instead of DRM_KMS_HELPER.

Changes in v2:
- Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).

 drivers/gpu/drm/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 22c1ba9ea28c..4f209e5c958c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -9,6 +9,9 @@ menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
 	select DRM_PANEL_ORIENTATION_QUIRKS
+	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
+	select FB_CORE if DRM_FBDEV_EMULATION
+	select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	select HDMI
 	select I2C
 	select DMA_SHARED_BUFFER
@@ -96,7 +99,6 @@ config DRM_KUNIT_TEST
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
-	select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  CRTC helpers for KMS drivers.
 
@@ -132,8 +134,7 @@ config DRM_DEBUG_MODESET_LOCK
 
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
-	depends on DRM_KMS_HELPER
-	depends on FB=y || FB=DRM_KMS_HELPER
+	depends on DRM
 	select FRAMEBUFFER_CONSOLE if !EXPERT
 	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
 	default y
-- 
2.41.0

