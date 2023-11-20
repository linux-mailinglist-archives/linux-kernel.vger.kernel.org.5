Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A07F1470
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjKTNax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjKTNak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:30:40 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9908D131
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:30:36 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ce5b6ec63cso37244255ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700487036; x=1701091836;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaBs9yaex3CpTCsjQhZQgAZfjs1nKcoUFzS37fbktjc=;
        b=jjl9oqAYz9KqVZYRYmFWgDO9nkzTq+Sn/IxqfHRgC3BDJTHDLjWROz9sOx7pIM3VOx
         ptzsFgbpfyohRQtehkv/OgU9MOe67p7YJkpYmfiquKenke0xjOdwiR9LIheBf/+Ajf1a
         oDIfaDOI0fnMLstY7pD7h3ScCUtlFv29ylxjisCcF0qtSKyt8odwNbP6Q1DzPemW3lTB
         CIQ1DWySLz6f+Z+TfRlu0CvmshCVIlqNc3y15dh5aNMhaWD/oxa3jcETYCJszvIhUeRo
         tprcubm61MhbOpXoweUFslIQXPMYduK/aACzwLV6yhfl8ys9gG/kOSym3aseSsdY73jO
         tTYQ==
X-Gm-Message-State: AOJu0Yz2pEZOf8LnBgqz1aZ8rpVuFxSkc3dpBGoz596quKif6ExVsqVU
        toRWLXuokiIeuwnrDLNmrZoavnaUJtiHiPzvq2NE7O0AQ087hjc=
X-Google-Smtp-Source: AGHT+IG5byLfrF4ihdnfCMdyvpEzGraz/2NTP/4r381JvT5NiVr4OwBdtKn5Cm/h15ZYwg1VyVxj2UvgjWQ0VDD+ZYTvKdgeptkp
MIME-Version: 1.0
X-Received: by 2002:a17:903:22c8:b0:1ca:7a4c:834d with SMTP id
 y8-20020a17090322c800b001ca7a4c834dmr2458430plg.13.1700487035864; Mon, 20 Nov
 2023 05:30:35 -0800 (PST)
Date:   Mon, 20 Nov 2023 05:30:35 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7d228060a957d5c@google.com>
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
index ac9a406250c5..60739d861da2 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -36,6 +36,7 @@
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
@@ -1297,8 +1298,10 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		den *= 2;
-	if (mode->vscan > 1)
-		den *= mode->vscan;
+	if (mode->vscan > 1) {
+		if (unlikely(check_mul_overflow(den, mode->vscan, &den)))
+			return 0;
+	}
 
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }

