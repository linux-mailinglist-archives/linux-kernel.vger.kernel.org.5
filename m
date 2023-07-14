Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335E8754059
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjGNRSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjGNRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7663A2683
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689355021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vxKxDl8hkASbmof5obTD+MsN6Wed2Skg+HdVQ+mL5aQ=;
        b=L9chM0Wie/Bek0HYoEx+NWotVszErv0NTVL69noYmDf67t17fhUrQKAiJBKZTyFXM07foc
        A2QZbMWocE3QEyiPqf6ljgYy5T6q+SAhD9d1xaScb14sz/o0tSh6KQUBPSPxi+9HbSKqFn
        +F4u0xRoRxujdx42+AKfglUzW4i4LdM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-miSZorVhMsqg6qhbabc57g-1; Fri, 14 Jul 2023 13:17:00 -0400
X-MC-Unique: miSZorVhMsqg6qhbabc57g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3143a431a01so1256258f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355019; x=1691947019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxKxDl8hkASbmof5obTD+MsN6Wed2Skg+HdVQ+mL5aQ=;
        b=AAPVVSGMXDVdMrIDENtprCyPTLF+ZTTI4zFsxitafnIWaaOhckWsUqmU6D9HlonKhI
         eJsNGQr61fy7wqCo27yDODuhrXGdeAgLmFxo1a4yDrBUgOs8y9VuyXpZsEkpOHxLkPTa
         fQcwQoo6IufeWMMPf54GTJwY+xMchD6dolep1CrCpKVAholX3Mf3gI3OON9db12ADLd+
         VH3IlU29WoKzbuviFLo75ORJz3KcfEyFGDHiLXYmTiScqbpRjvpau162qqEQcH7adMIl
         zyFdsXQcLjWKCwFgY1sWH8TjAyBGFl7wUCTLDViK87C/LKCMY13gfE3TszWeJWRNHj6+
         M4FQ==
X-Gm-Message-State: ABy/qLats3qWfd/nFadTMRG5fVRGXrcNmzwIoRkhd5iuIKENY6XdPari
        exx6O4HsKj0E8QxTtplv/zh8wgjqtbk1mET9zqwEHXPSPvNQ64UWtelR6tPFgy3AeyhP8CcNdn0
        Lx64J6JnlKaVHGyWHJZty5OluNIK4HNer+qvFXdOniEnHMSCNqBVuJZ4zt7h7KRZh/v7XqrmI/o
        ViSFp0nJ4=
X-Received: by 2002:a5d:4c41:0:b0:316:d887:624a with SMTP id n1-20020a5d4c41000000b00316d887624amr4545166wrt.15.1689355019257;
        Fri, 14 Jul 2023 10:16:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKPw1UykVcusjqH34hV6KXPzLB9kjRoLXf9wmHhY9nt93nNtlU2qXpYhntJXfeqdJlboF9dw==
X-Received: by 2002:a5d:4c41:0:b0:316:d887:624a with SMTP id n1-20020a5d4c41000000b00316d887624amr4545148wrt.15.1689355019005;
        Fri, 14 Jul 2023 10:16:59 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe891000000b003143cdc5949sm11620842wrm.9.2023.07.14.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:16:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v5 4/4] drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled
Date:   Fri, 14 Jul 2023 19:16:32 +0200
Message-ID: <20230714171642.91185-5-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714171642.91185-1-javierm@redhat.com>
References: <20230714171642.91185-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

