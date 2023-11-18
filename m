Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002C07EFEE5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjKRKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRKaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:30:00 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDB3D5D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 02:29:57 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c1d1212631so3959677a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 02:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700303397; x=1700908197;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0Ro4Ihl1iy1RYkcPXOQiTZNQGmotjqIME1zQ0Wuar0=;
        b=BWaMNxugVsmzDbq00BYxPf1LH8Y63dd9IN1XKWXin7rU2VFf1G6hqQaGCWRrIDROEb
         nj/f2+pOLTo9hQVzVS9Y3K+VuOrELAMuCNHbqgoTPh27OQgqIfj+MyVOm/Vs94EXQbU5
         ELbnu+CadFJRcEkQgNqSx9fU4/MhBuJCgcwhF1CT/8rSb3Q95KX/7zlkuc76jFMkNy+F
         bpZiM2Ixe8ESD5PRsqdifhcvLZzsre3+izZ7qfVNn6lj145geBWBMftvy/ttR2qDqvnk
         uVqTqphAvhUhPVE17BAGyDMX0LBCVwEBhtj61aX7BiducpBE2S+rjgsWpZ+brpHfzpt2
         /h/g==
X-Gm-Message-State: AOJu0Yzut9sTMAEdNGHQ4cBcHlGaasrWRfoE8XK5OmU3zBNbnXpAY0Ex
        4MkhIMnPtrrZa/uFFTVXY4cuK8XT8p/knsqPB9uTK0iNIsRO7kQ=
X-Google-Smtp-Source: AGHT+IFpeX5Hq3XZONs/X+s8mayMvsTcUuoCzGNBReIE7V16qPbHjHC796V0X0F/R2sAtC4yNOSA/0xuE4nmHAOZJOTEWrD7W2xB
MIME-Version: 1.0
X-Received: by 2002:a63:5660:0:b0:5bd:bcde:c677 with SMTP id
 g32-20020a635660000000b005bdbcdec677mr337640pgm.2.1700303397366; Sat, 18 Nov
 2023 02:29:57 -0800 (PST)
Date:   Sat, 18 Nov 2023 02:29:57 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002b1dc060a6abc67@google.com>
Subject: Re: [syzbot] [PATCH] Test divide err in drm
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ac347a0655db

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..ca481c7f23e1 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1285,7 +1285,8 @@ EXPORT_SYMBOL(drm_mode_set_name);
  */
 int drm_mode_vrefresh(const struct drm_display_mode *mode)
 {
-	unsigned int num, den;
+	unsigned int num, den, n1k;
+	int ret;
 
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return 0;
@@ -1297,9 +1298,15 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		den *= 2;
-	if (mode->vscan > 1)
-		den *= mode->vscan;
+	if (mode->vscan > 1) {
+		n1k = mul_u32_u32(num, 1000);
+		if (den < n1k)
+			den *= mode->vscan;
+	}
+	ret = DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 
+	printk("mode: %p, ht: %d, vt: %d, c: %d, vsc: %d, den: %ld, num: %ld, n1k: %ld, %d, %s", 
+		mode, mode->htotal, mode->vtotal, mode->clock, mode->vscan, den, num, n1k, ret, __func__);
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }
 EXPORT_SYMBOL(drm_mode_vrefresh);

