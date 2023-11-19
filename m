Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA54C7F03E8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 02:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjKSBb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 20:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSBb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 20:31:27 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD6C4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 17:31:24 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc2a0c7c6cso40004985ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 17:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700357484; x=1700962284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+RUiSwPwCAAGr2F68oCXKGMiSPBpBfD2D0zBcrr6mw=;
        b=jSDD4XubCz8bkbPX9tqdIPKnXDP3+XtPHi/peFkOIzOQoARlcfxkPjZyvOm+98dLiD
         /QAX3ciPHGXlryY+k0qcbXGo96H/ODYHClIk0Z6ACzcRh4r6KLc1ZfKm08FEXCMsnV27
         nVFlgso7odvRAEsFwyxomZp512TsBwveDZAP3VXc6zN/NCnhDp6QkHXZSddm4kdKUFJ1
         9edRRXmHCirbFsjCCFkWkat9mU61r39TirWp/mqC8nyNgO4gCHz1ICY1u0p+HPIjYmYC
         +Nf65MoiBQ5EY3zgvDKh88ST49csyFwK7spK6UWDrwSq0EJEgsaonRq8C5xjZzg3A4Us
         K/0g==
X-Gm-Message-State: AOJu0YzcACSO99e35KMWh+HjZwD2K63ckShDfsHzemIuIY5EUDBIjcC9
        xSJfw1Z5tf0x+MKLtTd3Rl6pL1ikhLksEBFntfm9WwZMPN1yUC8=
X-Google-Smtp-Source: AGHT+IH8K4LCdd659AlLs+FBtHaZ/jZSRbPOcTdjGPBn7Xwg+ZyPwguKQe2KjWAMBKxlO/AhcnhiKY9bv+Fk8L4olbGXbvYuzTJU
MIME-Version: 1.0
X-Received: by 2002:a17:902:b7c3:b0:1cc:70f2:c1d5 with SMTP id
 v3-20020a170902b7c300b001cc70f2c1d5mr963176plz.11.1700357484245; Sat, 18 Nov
 2023 17:31:24 -0800 (PST)
Date:   Sat, 18 Nov 2023 17:31:24 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6fbd8060a7753e8@google.com>
Subject: Re: [syzbot] [PATCH] Test divide err in drm
From:   syzbot <syzbot+2e93e6fb36e6fdc56574@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
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
index ac9a406250c5..1a3e8f3c1ece 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -36,6 +36,7 @@
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/of.h>
+#include <linux/log2.h>
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
@@ -1297,8 +1298,12 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		den *= 2;
-	if (mode->vscan > 1)
+	if (mode->vscan > 1) {
+		printk("%d, %d, %s\n", ilog2(den), ilog2(mode->vscan), __func__);
+		if (ilog2(den) + ilog2(mode->vscan) >= 32)
+			return -EINVAL;
 		den *= mode->vscan;
+	}
 
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }

