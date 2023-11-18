Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BCA7EFF5A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjKRL7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKRL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:59:32 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01362E0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:59:28 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so3153546a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700308768; x=1700913568;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5cvEyP9e5+539SPTpJVNjpYxSJw1r+zQ1Jb6FbCprY=;
        b=XIw1hoLfzkWnPeasWLgYePz0uXKZFB9sAlkn/dzoTrSpVPRFe00TwyiXBeYKogURUz
         DadAzlQbDLVOV973lNX8rcv/9PbuRk4gxpCCY7wtK93Uae9bl0lcMhQpiOG252vAvfOg
         PCMOLAnxAautzolstvzOEzKCTGSRgz24IBTxmpq/lSuAjE+PgaWtJrYEEpYn2g0//W1K
         sJHFSAzSRimsWOOMD1qqgxNmsw2o65fKRLVeUIplwi/uSWVmTkcC2dkUYgOvZSOMMhDh
         dYK4e4JLLAuylrPpJJSmrlM/I+GhYXtkra0srddTJ2XC+vN8QKuwDeETGIsiq6ymkAjT
         gGtQ==
X-Gm-Message-State: AOJu0YyWQD7/9pUIrlKA2OL/+kZjLFzfzaJf+Irb/SBCuqND6Nm8hVW+
        vHEYE3KU0brZqxt7hy508lbrv1tmHoFA+gO9G6i0GhPrjx1Gi5w=
X-Google-Smtp-Source: AGHT+IGb59x5K9AxPxE33MHw08zqL4ZqV6KyzwP2E3pCpNWIrOUWao3HhR45r0enyH8SJqYrn/4aZy4HsC8+yZKe0DBfmKGSlDh1
MIME-Version: 1.0
X-Received: by 2002:a63:5c59:0:b0:5c2:1ffc:ffb9 with SMTP id
 n25-20020a635c59000000b005c21ffcffb9mr333746pgm.5.1700308768564; Sat, 18 Nov
 2023 03:59:28 -0800 (PST)
Date:   Sat, 18 Nov 2023 03:59:28 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028ab9d060a6bfcf2@google.com>
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
index ac9a406250c5..539aa26cfc72 100644
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
@@ -1297,9 +1298,17 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		den *= 2;
-	if (mode->vscan > 1)
-		den *= mode->vscan;
+	n1k = mul_u32_u32(num, 1000);
+	if (mode->vscan > 1) {
+		if (den < n1k)
+			den *= mode->vscan;
+	}
+	if (den < n1k)
+		den = n1k + 1;
+	ret = DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 
+	printk("mode: %p, ht: %d, vt: %d, c: %d, vsc: %d, den: %ld, num: %ld, n1k: %ld, %d, %s", 
+		mode, mode->htotal, mode->vtotal, mode->clock, mode->vscan, den, num, n1k, ret, __func__);
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }
 EXPORT_SYMBOL(drm_mode_vrefresh);

