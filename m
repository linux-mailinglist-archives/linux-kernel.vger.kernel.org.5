Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7B7F13CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjKTMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKTMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:00:15 -0500
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4759F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:00:09 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28513ea9e15so1970593a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700481609; x=1701086409;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEXXljN3rCCw93/ROnFZECXwdMgPXZVCRul5GFcysIw=;
        b=W5nwyjvzPTvyzLtnI7ND4rfcRKuQJPM4B88bbwBGnABEZULGKU4gARTBGD7wY71wMo
         x6t85trbDWCy8H5OxgbT+z8MRH20isNmnco5QsyHO8ln/2gfv1jCeL1Z6Fb+BHYGQPKe
         r9Mk2cl8PVb9zkuCtvaUqZ5koocBW660DAliN6Pkm3thCqewkmn3Fs3afsOdqBu+45TQ
         dTyNw6lU2PmOFn4In/1llnG5n/Fv5yhE+cf5Nhf4L8nVzB6QzulffHdqtfcEwsnhiMOR
         5LKUU6MX7Husk/r9F4o8bqWfmnMTMc5cGS892+047oNfK/6a9QsBDArCA0ROhQu2uod2
         hO/Q==
X-Gm-Message-State: AOJu0YypHMR7iWXcd0irDcUR6S4t50UIazBmXK1tKKz8zBjkSJkLfWbK
        ry+GsBiN6q3P5xiHFp8es5mLpBrtkfxD6WXcylkHe6Dx2Xa0PPM=
X-Google-Smtp-Source: AGHT+IEsf/hGTEy6LrlvzRq2unbISsjgglmUiuVuQndI7vybE1Agn+kW+JQb0LblrYJccFxSLCzlGcFk/C1sFLIgHflT1h9icG5k
MIME-Version: 1.0
X-Received: by 2002:a17:90a:8982:b0:280:a5e9:3b61 with SMTP id
 v2-20020a17090a898200b00280a5e93b61mr1808029pjn.9.1700481609482; Mon, 20 Nov
 2023 04:00:09 -0800 (PST)
Date:   Mon, 20 Nov 2023 04:00:09 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047c963060a943a54@google.com>
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
index ac9a406250c5..117ee4e41c63 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -36,6 +36,7 @@
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
@@ -1297,8 +1298,11 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		den *= 2;
-	if (mode->vscan > 1)
+	if (mode->vscan > 1) {
+		if (unlikely(check_mul_overflow(den, mode->vscan, &den)))
+			return 0;
 		den *= mode->vscan;
+	}
 
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }

