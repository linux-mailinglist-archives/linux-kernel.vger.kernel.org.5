Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CCB7EFE24
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 07:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjKRGom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 01:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKRGok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 01:44:40 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FD4D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 22:44:34 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so3600422a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 22:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700289874; x=1700894674;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+zXR6Il02cCtDoAuhKqBOFy3NmRcj2ElWG2TvIv6ys=;
        b=EgK22Vchv5Akqf4OAsl9tAjS7mvGzVcElSZviUsIO8A5PLz1dBfTYO5oKSBqkNZqj4
         Wdi6s77kJc0rKjUlJQpknF+Sjz/9VyiUM6+BnFxItjnAl2eFilyg9U9Mun4/gwI3avex
         mE+zSB+G7iKulUhMLSCpB4IGqP+XBq17VGNNdUGbdyIxhRI2o62vw+fJTgBk72GuNjjC
         Xo2D75RIGcNtH7JFniYeyyhPI0LiJd7NPXoKS06g+ki3zvLtG1tciob9iKJTyh+XL5XJ
         K4MP6exUd+Phs/bAQdGPMXydMgwgQxR2K83O/XJFlI1k2VdLysNZrP013kfM8KZ7AA0O
         4WXQ==
X-Gm-Message-State: AOJu0YwLQOKzCjEzLLIGhAUrYlQFSQCXp54rh3cE8O5DyI1h5IHK8Pgo
        z23wlOgwA3dq4y33Cnm3V2vFb2Vgwr2/ckSTzqmnc8LEOw6i+/g=
X-Google-Smtp-Source: AGHT+IG6TY5W2ibypBNjZXVzUADL17G8E7YgOQ79hb5g5xDAIzaA+CgXvDpZ1rS6NFn58DQgS7UpszqL+8737JFqlcrOTSp0cC/o
MIME-Version: 1.0
X-Received: by 2002:a63:170c:0:b0:5b9:63f2:e4cc with SMTP id
 x12-20020a63170c000000b005b963f2e4ccmr271952pgl.2.1700289874230; Fri, 17 Nov
 2023 22:44:34 -0800 (PST)
Date:   Fri, 17 Nov 2023 22:44:34 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f80839060a6795ea@google.com>
Subject: Re: [syzbot] [PATCH] Test divide err in drm
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

Subject: [PATCH] Test divide err in drm
Author: eadavis@qq.com

please test divide err in drm

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ac347a0655db

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..0b0dd1c7b217 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1285,7 +1285,7 @@ EXPORT_SYMBOL(drm_mode_set_name);
  */
 int drm_mode_vrefresh(const struct drm_display_mode *mode)
 {
-	unsigned int num, den;
+	unsigned int num, den, n1k;
 
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return 0;
@@ -1297,9 +1297,14 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
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
 
+	printk("mode: %p, ht: %d, vt: %d, c: %d, vsc: %d, den: %ld, num: %ld, n1k: %ld, %s", 
+		mode, mode->htotal, mode->vtotal, mode->clock, mode->vscan, den, num, n1k, __func__);
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }
 EXPORT_SYMBOL(drm_mode_vrefresh);

