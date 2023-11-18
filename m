Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DE7EFD8A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbjKRDnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKRDnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:43:02 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0504BD72
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:42:59 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-692c0c3bcc5so2857650b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278978; x=1700883778;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jf486dR93tmnojhsU+9sn35zLNeQe0ssbxzTjkrxM9E=;
        b=ukaDGA/SQXCvkQOM4KhcpdJGyckT18OKDQAhXTrAfVb7RSATdSnf/6UzqQS1uVOKF8
         33vO+h3BaK9p3kAlmYoABXio2V9ApFnV7VF/HH8hyXAu163D6gJRlnkv9FEJZGeLAt/G
         a3EIhTu3FptNaMkloAEdHITzixXy5ojI9swQqBkywyNq7RCX1YTepWbc72KqR0wzDyYD
         5kEi5XyynCW2b6+/JX/z3oR2IhD21rL4r4JCWOKHiJNcj64v7Z0R1Sk4zKGL02/Uj/Qa
         smhjR6lyttcYOUp4Dxm6+7bgF1oShy6G9oPbjOBr2SKMIizdqXeCLYumLH5xFM9LMcSW
         rJ8w==
X-Gm-Message-State: AOJu0YxrOx5M2sIjk8yvgAejCH2Y581CdDcttpXSbludo+rAVjC2XZ5K
        ++G0SzU6XIYagyblDgTGJrG6tF3ydiNEI8cMIYxMYLIS18NhX+E=
X-Google-Smtp-Source: AGHT+IFiZim2OCfWpzfx8QViOclOfMtoPjU9oyoxtQQPVXSICSGYYyEN8r7ljZ/pcvHh/WXIrVtV4NXXAMF551pMbPW0VAzXDwWc
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:8987:b0:6be:208:4bbb with SMTP id
 hx7-20020a056a00898700b006be02084bbbmr275849pfb.3.1700278978556; Fri, 17 Nov
 2023 19:42:58 -0800 (PST)
Date:   Fri, 17 Nov 2023 19:42:58 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089388e060a650cdf@google.com>
Subject: Re: [syzbot] [PATCH] Test divide err in drm
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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

Subject: [PATCH] Test divide err in drm
Author: eadavis@qq.com

please test divide err in drm

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 888cf78c29e2

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..e3f05539f704 100644
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
@@ -1300,6 +1300,8 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 	if (mode->vscan > 1)
 		den *= mode->vscan;
 
+	printk("mode: %p, ht: %llu, vt: %llu, c: %llu, vsc: %llu, den: %llu, num: %llu, %s", 
+		mode, mode->htotal, mode->vtotal, mode->clock, mode->vscan, den, num, __func__);
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }
 EXPORT_SYMBOL(drm_mode_vrefresh);
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
 

