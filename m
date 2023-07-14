Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98938754051
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjGNRRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjGNRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA9D9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689355015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2kL6s2iGtpGIjyrMzCwNbgQ+dYlVfsjyP7TiMQdzptE=;
        b=MJsq7X3j4xAZWUFDU1bl21XyHWfIDUGyADxbRZ7RbhKeUlePd9qpEW4yTqZ8S7MfQ+H4SG
        LFkz81XQUJhvhr9T3UaObB+BrldEy9KzdLv0o6VSiZPdwQgRXypW5OWLfSfjZYFFrYAvl2
        +8CBjR4k8lkisprBJCxUrdeAlIsxb7U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-Z6g8KaYgPHGarkKC02xHIA-1; Fri, 14 Jul 2023 13:16:53 -0400
X-MC-Unique: Z6g8KaYgPHGarkKC02xHIA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-315935c808bso893730f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355012; x=1691947012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kL6s2iGtpGIjyrMzCwNbgQ+dYlVfsjyP7TiMQdzptE=;
        b=WZeb/mxvPUJkBVHc5+nu4/Ks9/aoMt1dqQg7Y5V8WUhVoznTBhb095YIc9U/uC31UP
         tH4HWPkLt9kaV1G8Pojx5UiWfdshuXCcVxl+3n1Uw6PZhLBBaza0tVLYvdpXtcaM8NMt
         EAI9veeBI10GzAqeU1tJ2+T9UoxhyfFpsEPNabouH/yrdEH/SAjCYeY/gzC8V7YdoBbV
         Wsa0XJUeykTypNcR2nV3wjaAYldHYoAl79GIRmQ/pmQaq+T0t+/mpw+GzWRbJKG2JvnQ
         xfLf8MN09a2+SGgoKgWGX8/I4Ji0MMQLpbrOd2qM3EJWKYHcIInzmeonUMiDBgNwGJuF
         qX/A==
X-Gm-Message-State: ABy/qLaObiSMdRY4mkcKEs0dnre+yu2CZ4XBubd2rXglXrGvp8fXdsrH
        wXmyC5Y4PgxzXBGDDjFA2LFD0GimkxXIA6DM/vMsiZdNibGf9czQjZd9adVr/tAKAgNChOaSu23
        U52OoALMKJ1LZ4/HgCP+yXtUAQHLRUEvWIRJPle7v7OQ69mtbU8GeYgrzHHJXtHG0rahj0j3eQ5
        GOiRublc8=
X-Received: by 2002:adf:f04f:0:b0:314:3108:500a with SMTP id t15-20020adff04f000000b003143108500amr3012627wro.0.1689355012187;
        Fri, 14 Jul 2023 10:16:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+Si2gkk224xulr2GYQ3B2/NaZI0tm53emCdaXDgKsHXxBVo/NNGKHPxSgoWGegYqwn2oCFg==
X-Received: by 2002:adf:f04f:0:b0:314:3108:500a with SMTP id t15-20020adff04f000000b003143108500amr3012588wro.0.1689355011770;
        Fri, 14 Jul 2023 10:16:51 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe891000000b003143cdc5949sm11620842wrm.9.2023.07.14.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:16:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Melissa Wen <mwen@igalia.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v5 0/4] Allow disabling all native fbdev drivers and only keeping DRM emulation
Date:   Fri, 14 Jul 2023 19:16:28 +0200
Message-ID: <20230714171642.91185-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series splits the fbdev core support in two different Kconfig
symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
be disabled, while still having the the core fbdev support needed for the
CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
disabling all fbdev drivers instead of having to be disabled individually.

The reason for doing this is that now with simpledrm, there's no need for
the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
now disable them. But it would simplify the config a lot fo have a single
Kconfig symbol to disable all fbdev drivers.

I've built tested with possible combinations of CONFIG_FB, CONFIG_FB_CORE,
CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE symbols set to 'y' or 'n'.

Patch #1 moves the auxdisplay drivers to "Graphics support" Kconfig menu,
patch #2 moves the core fbdev Kconfig symbols to a separate Kconfig file,
patch #3 does the FB symbol split and introduces the FB_CORE symbol and
finally patch #4 makes the DRM symbol to select FB_CORE if the DRM fbdev
emualtion support was enabled.

Since this series touches three subsystems (auxdisplay, fbdev and DRM),
I would like to merge it through DRM with the acks of these maintainers.

This is a v5 of the patch-set that addresses issues pointed out by Arnd
Bergmann, Thomas Zimmermann and Geert Uytterhoeven in the previous v4:

https://lists.freedesktop.org/archives/dri-devel/2023-July/411842.html

Changes in v5:
- Take the auxdisplay/Kconfig source out of "if HAS_IOMEM" (Geert Uytterhoeven).
- Fix ifdef guard check in drivers/video/backlight/backlight.c (Arnd Bergmann).

Changes in v4:
- Fix menuconfig hierarchy that was broken in v3 (Arnd Bergmann).

Changes in v3:
- Really make a hidden symbol by removing the prompt (Arnd Bergmann).
- Change FB_CORE to config instead of menuconfig (Arnd Bergmann).
- Keep "depends on FB" for FIRMWARE_EDID (Arnd Bergmann).
- Compile out fb_backlight.o and fbmon.o that are only needed for FB
  (Arnd Bergmann).
- Make FB_DEVICE to depend on FB_CORE instead of selecting it.
- Make the DRM symbol to select FB_CORE if DRM_FBDEV_EMULATION is
  enabled (Arnd Bergmann).
- Also make DRM select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
- Make DRM_FBDEV_EMULATION to depend on DRM instead of DRM_KMS_HELPER.

Changes in v2:
- Keep "depends on FB" for FB_DDC, FB_HECUBA, FB_SVGALIB, FB_MACMODES,
  FB_BACKLIGHT, FB_MODE_HELPERS and FB_TILEBLITTING (Arnd Bergmann).
- Don't change the fb.o object name (Arnd Bergmann).
- Make FB_CORE a non-visible Kconfig symbol instead (Thomas Zimmermann).
- Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).

Javier Martinez Canillas (4):
  video: Add auxiliary display drivers to Graphics support menu
  fbdev: Move core fbdev symbols to a separate Kconfig file
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled

 arch/x86/Makefile                   |   2 +-
 arch/x86/video/Makefile             |   2 +-
 drivers/Kconfig                     |   2 -
 drivers/gpu/drm/Kconfig             |   7 +-
 drivers/video/Kconfig               |   2 +
 drivers/video/backlight/backlight.c |   6 +-
 drivers/video/console/Kconfig       |   2 +-
 drivers/video/fbdev/Kconfig         | 213 ++--------------------------
 drivers/video/fbdev/core/Kconfig    | 206 +++++++++++++++++++++++++++
 drivers/video/fbdev/core/Makefile   |   8 +-
 10 files changed, 232 insertions(+), 218 deletions(-)
 create mode 100644 drivers/video/fbdev/core/Kconfig

-- 
2.41.0

