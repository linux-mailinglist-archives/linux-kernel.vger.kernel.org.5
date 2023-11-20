Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4977F1320
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjKTMWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjKTMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:22:07 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701ECF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:22:04 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c1d1212631so6967704a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700482924; x=1701087724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbUbaskN5THQ5lbAtdeg7F98SJq+P9xPJ03Gz0q47AQ=;
        b=w9ApVr5JAdRoHdn6YAaMvMhXOhXX9+Tp1e8I/3yvoHyLbJHijAjxQt2mT9OfOPpcZS
         v/VDuWMEFcYoc8DtjDbiX6V6YAuGtb7+QCn+XgPTv++QcaRcaqkbMXACfOBCin09ZBJW
         qn0HFdp53grKXpIGGKbBbfXMnqOgWk605HiR6+Lxamg/9Vnhf8pi+TL7CTTX8oFgupy2
         RAYTYGHe/4DSS77hVcQOyU2e/oKLxojsYBeSzh5TKVSoQ4wUur1wg4zBBhFNfTv6JPqL
         a3RlYdyYuTNizmXKtevMoIeciR/8UG/2w3zqB27MyaBtGuB1d0UF/6VyAgv5vqSoY3Zg
         5ERg==
X-Gm-Message-State: AOJu0YxHjcL1Cl4D3R1fAL5yAM/EiLoPfc5NR47bOFjN4Ky3Y8iuChP0
        J3kLnh1MQjyaGKxcganGd+phfvpyz2US6q93SSXpDxQF39ShTPw=
X-Google-Smtp-Source: AGHT+IE0+oNlndZWEuFWMRIXN38+VghFds+NaBtbgOrjqOyFlga1ZpjqGeSD8xNJ++gt82VRnrPB5/yJC8GtbTuRGnSfMyMtLQXJ
MIME-Version: 1.0
X-Received: by 2002:a17:90a:b388:b0:27d:ba3:fbf9 with SMTP id
 e8-20020a17090ab38800b0027d0ba3fbf9mr2002825pjr.8.1700482924484; Mon, 20 Nov
 2023 04:22:04 -0800 (PST)
Date:   Mon, 20 Nov 2023 04:22:04 -0800
In-Reply-To: <000000000000bf0b1f060a2d9bea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a91e9f060a9488d3@google.com>
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
index ac9a406250c5..7c6d0229630d 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -36,6 +36,7 @@
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
@@ -1285,7 +1286,7 @@ EXPORT_SYMBOL(drm_mode_set_name);
  */
 int drm_mode_vrefresh(const struct drm_display_mode *mode)
 {
-	unsigned int num, den;
+	unsigned int num, den, x;
 
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return 0;
@@ -1297,8 +1298,11 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		den *= 2;
-	if (mode->vscan > 1)
+	if (mode->vscan > 1) {
+		if (unlikely(check_mul_overflow(den, mode->vscan, &x)))
+			return 0;
 		den *= mode->vscan;
+	}
 
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }

