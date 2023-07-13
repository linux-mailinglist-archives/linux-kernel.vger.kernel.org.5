Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A1752866
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjGMQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjGMQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B33273E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689265952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hA4oXFz7iMz2TN7Oq1WGXGk81ddHsb/K8fUHUI+fX50=;
        b=OtLS2MwFZtmhHALcbAOqfg0VM3aSQMTAgIKTdSrM3b77CGvvEQpJHjvIedSPQPRuTehfxi
        GiGKEQ2VUkSo2oAEQK9kNIqbeMwrmpAh7hI1X+gwODxTDPsP1rTe4zvcqD5BMccoRxW/ak
        gm9BJnfR2BzdEIY63e/ekEIYfEUS6ho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-z80AxN_PNIqPEgABguwkCQ-1; Thu, 13 Jul 2023 12:32:24 -0400
X-MC-Unique: z80AxN_PNIqPEgABguwkCQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-315998d6e7fso591135f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265942; x=1691857942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hA4oXFz7iMz2TN7Oq1WGXGk81ddHsb/K8fUHUI+fX50=;
        b=H9AUQeY03zwN0DOv7L9l9pcU6X2PUyjopt+uorXgPjnH/agQtheuTYxZ28DV6q+Z3G
         GBVmsa6yi/NkRc/dYMMUeHTtXWJsFIJPAVKNjbfT6OVMeGTglzprBKzVhiDQdtRR9IAm
         T+fx+kh9mhA135D9xZYFhTSkgFwyIfgKI280GI8bSIB+sMFqWXDKo1llSXdDfrLCoUqH
         50RtqKwfxrCdkUc0pWi49s8XciBpJ/KgXYnDrb7QwK6MbXG85Rs4ByBRNmC6z0fFciD0
         gJ9z+FFPpLfqBOctyTqey+46OrHUKE7qUdpzytX0WnmKbI9spOGdlCeFAX4KVO/3LA10
         Ncow==
X-Gm-Message-State: ABy/qLaTN1BJLNP1u6MVtdw+LksBMWxRFtpLMRbzKmjdA4fq4BJXAHPL
        Abof2X/jxrcX4g4to+1cd1bObOK16hV9YnqGD9ClSnE11WQDDt6YElmmNDZDDjQWJwppstJDqZ6
        SeKUnu5nS8joUCAJhQkcKq68M4JBI2rYZU+y+AugHuRjT8ReQlQ2bNO498A3N1EaQKZNKy/0vIp
        j1MU414RM=
X-Received: by 2002:a05:6000:87:b0:314:449e:8536 with SMTP id m7-20020a056000008700b00314449e8536mr2005175wrx.10.1689265941820;
        Thu, 13 Jul 2023 09:32:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEa8zIOvCR3FZIuk4Bh+6wmih6StOOoYjgtZavSN3obv2xketnv0WzrE7x0Q/+hJFIveJRfiQ==
X-Received: by 2002:a05:6000:87:b0:314:449e:8536 with SMTP id m7-20020a056000008700b00314449e8536mr2005152wrx.10.1689265941523;
        Thu, 13 Jul 2023 09:32:21 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b003143ac73fd0sm8486974wrm.1.2023.07.13.09.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:32:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Fix an oops when attempting to update a disabled plane
Date:   Thu, 13 Jul 2023 18:32:06 +0200
Message-ID: <20230713163213.1028952-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Geert reports that the following NULL pointer dereference happens for him
after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
plane update"):

    [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
    ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
    and format(R1   little-endian (0x20203152))
    Unable to handle kernel NULL pointer dereference at virtual address 00000000
    Oops [#1]
    CPU: 0 PID: 1 Comm: swapper Not tainted
    6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
    epc : ssd130x_update_rect.isra.0+0x13c/0x340
     ra : ssd130x_update_rect.isra.0+0x2bc/0x340
    ...
    status: 00000120 badaddr: 00000000 cause: 0000000f
    [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
    [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
    [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
    [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
    [<c02f94fc>] commit_tail+0x190/0x1b8
    [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
    [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
    [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
    [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
    [<c02cd064>] drm_client_modeset_commit+0x34/0x64
    [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
    [<c0303424>] drm_fb_helper_set_par+0x38/0x58
    [<c027c410>] fbcon_init+0x294/0x534
    ...

The problem is that fbcon calls fbcon_init() which triggers a DRM modeset
and this leads to drm_atomic_helper_commit_planes() attempting to commit
the atomic state for all planes, even the ones whose CRTC is not enabled.

Since the primary plane buffer is allocated in the encoder .atomic_enable
callback, this happens after that initial modeset commit and leads to the
mentioned NULL pointer dereference.

Fix this by not using the default drm_atomic_helper_commit_tail() helper,
but instead the drm_atomic_helper_commit_tail_rpm() function that doesn't
attempt to commit the atomic state for planes related to inactive CRTCs.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index afb08a8aa9fc..12820d16b15b 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -795,6 +795,10 @@ static const struct drm_mode_config_funcs ssd130x_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static const struct drm_mode_config_helper_funcs ssd130x_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
 static const uint32_t ssd130x_formats[] = {
 	DRM_FORMAT_XRGB8888,
 };
@@ -923,6 +927,7 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 	drm->mode_config.max_height = max_height;
 	drm->mode_config.preferred_depth = 24;
 	drm->mode_config.funcs = &ssd130x_mode_config_funcs;
+	drm->mode_config.helper_private = &ssd130x_mode_config_helpers;
 
 	/* Primary plane */
 
-- 
2.41.0

