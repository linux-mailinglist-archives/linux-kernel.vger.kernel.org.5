Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0E7ED8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjKPAwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjKPAwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:52:05 -0500
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC41A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 16:52:00 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c334d2fd4cso324791b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 16:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700095920; x=1700700720;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktNWwjZN9n0W6R4NdHvte0cVjiR6eAdUfF9Fu/NDP1s=;
        b=dPbVQqCM+NnCIyfJ5TiJb+WucUAcT9ZZP1YH35qx1OE95KkOfPWh3ZH9WH9yBa0SWg
         YJcBwceM5SA1TOzeEHAaeovbeNsjg62KCit4q7vGln329QROBqmzXPffYjApLBccJRU2
         fRztAu4F9Zt3N+fwj32TsfnECsQ2n0tysCA2aJmAWJ8KEjQ7QFX1M5jnIEz1OVLqlmJG
         muPB1kt8jbh/1/R+ydTpXuaxRG/t1eUHBXgB0NO9ujREzFx59as9yr2p2CXHz3x9tfwq
         i4KJg7fqdGBKJAbjlCc9nORDaTUKdM0LocHZ+lZ0paz1eMljbbq+35Z9RNZOL3BzLUeZ
         3MsA==
X-Gm-Message-State: AOJu0YwnC9omBLHoTgpgJg3O4P6uooc5vKLPHrqSb6i6GTmq14G0HS5E
        x0HDp2D3GCd+JLoeob9ZywTXqqXgvs9E92tcIaKx1Mm3b5XRe6w=
X-Google-Smtp-Source: AGHT+IEgl7V7Q0t9vzhzPRo5nbFtr8bnboJCQiGbXzAm03ohvhAxuZpEAzZ10hlbhMycqGsCNog89Fz8+renhduQpGoXQ4RwK+S/
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1d88:b0:6be:2f41:71be with SMTP id
 z8-20020a056a001d8800b006be2f4171bemr4158099pfw.3.1700095920468; Wed, 15 Nov
 2023 16:52:00 -0800 (PST)
Date:   Wed, 15 Nov 2023 16:52:00 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c7a42060a3a6d71@google.com>
Subject: Re: [syzbot] [PATCH] test divide error in drm_mode_debug_printmodeline
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] test divide error in drm_mode_debug_printmodeline
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ac347a0655db

diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index c613f0abe9dc..19e37e92dfaf 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -422,7 +422,7 @@ struct drm_display_mode {
 /**
  * DRM_MODE_FMT - printf string for &struct drm_display_mode
  */
-#define DRM_MODE_FMT    "\"%s\": %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
+#define DRM_MODE_FMT    "\"%s\": %llu %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
 
 /**
  * DRM_MODE_ARG - printf arguments for &struct drm_display_mode
@@ -526,7 +526,7 @@ static inline int of_get_drm_panel_display_mode(struct device_node *np,
 #endif
 
 void drm_mode_set_name(struct drm_display_mode *mode);
-int drm_mode_vrefresh(const struct drm_display_mode *mode);
+long drm_mode_vrefresh(const struct drm_display_mode *mode);
 void drm_mode_get_hv_timing(const struct drm_display_mode *mode,
 			    int *hdisplay, int *vdisplay);
 
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..6f376001728c 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1283,9 +1283,9 @@ EXPORT_SYMBOL(drm_mode_set_name);
  * @modes's vrefresh rate in Hz, rounded to the nearest integer. Calculates the
  * value first if it is not yet set.
  */
-int drm_mode_vrefresh(const struct drm_display_mode *mode)
+long drm_mode_vrefresh(const struct drm_display_mode *mode)
 {
-	unsigned int num, den;
+	unsigned long num, den;
 
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return 0;
