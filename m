Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B847DACCA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 15:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJ2Og2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 10:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2OgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 10:36:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06873B8;
        Sun, 29 Oct 2023 07:36:23 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a6907e9aa8so127728039f.1;
        Sun, 29 Oct 2023 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698590182; x=1699194982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOotfpE7UygG9u+jO7okxXpuJl/dpW05Sd73/FzJiB0=;
        b=GsP8ePenkX41jxjMPSbzMExd805XG+5rREld9+lvJduoYj+QzuzsbnqGmA3H3uKBws
         w7/BoMhALV6Fmg2oG1dT7CZ5/D6vQWE151Phj1ycxu9yNEYyk7jlGSLa8D/BuAmythuZ
         6pwPensPYxlwrjZty9bOmRTnNeE0h8dO70Lt5OShNn4c1kBwuOTE09WeqTNRrybduoXH
         zy0yBXuuImmQ/faSYrr0lhTJg00eUqOVJTyJBot/es5OJ2QDarEFA0WHYWf48faQI/Xr
         R5QAikwDahEFT8W9dE5wcZQbLnYWOo711nlHirS/w65u0ljui4GC/LPbH+raV1f0553P
         ISmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698590182; x=1699194982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOotfpE7UygG9u+jO7okxXpuJl/dpW05Sd73/FzJiB0=;
        b=k/D+q2Id7wFfEUenp7OCx+GvDI7anA2RnB340MXvBq/vL02seJnw052vYWohsc/vf4
         fN61YUVPar0nWJu95cMEbQw7ps9/iSpXGKqrdO4CBIWb92nZyl8kyUlOAvvkTmlBGo86
         WoQXt8GhT63ZeYipKluwCo2a7VZsqKnFO8xnF5Fea0VHxMwiRPAARW75eJ0AhRYli9Qb
         a2DXrc3W3vjtVCVSmP9bkc85gq8diynQksqcJ16d72scsRXaZOdid+oWiUDxs/YYWi50
         dNpRjv8xK/JmQ82cny0uAGV56sq6m73DcWHo4gCAnnxfwwgOe/C9dsNyMj5jP/ghwLzI
         3nrA==
X-Gm-Message-State: AOJu0YxchG3WRWO/npFMz/Cs3SRC4rQ+4fMXW2MKauab2uFL8Cvn5mtz
        PHTgOcYFsDV/sFkrZaAayo4=
X-Google-Smtp-Source: AGHT+IEENLk8ESJW5E5A28KlVgccH1FwYwzXqSbjRZcxnjVHBeKBoTbMnxB5GgIFQFt3XPzKtgUChg==
X-Received: by 2002:a92:cdaf:0:b0:357:600c:7c5f with SMTP id g15-20020a92cdaf000000b00357600c7c5fmr10083288ild.23.1698590182261;
        Sun, 29 Oct 2023 07:36:22 -0700 (PDT)
Received: from localhost.localdomain ([202.137.218.21])
        by smtp.gmail.com with ESMTPSA id a26-20020a63bd1a000000b005b8e1b0090asm3421348pgf.67.2023.10.29.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 07:36:22 -0700 (PDT)
From:   Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org
Cc:     Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] media: stk1160: Fixed high volume of stk1160_dbg messages
Date:   Sun, 29 Oct 2023 20:06:04 +0530
Message-Id: <20231029143604.120329-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function stk1160_dbg gets called too many times, which causes
the output to get flooded with messages. Since stk1160_dbg uses
printk, it is now replaced with printk_ratelimited directly.

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 drivers/media/usb/stk1160/stk1160-video.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 4e966f6bf608..f5b75f380c19 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -105,17 +105,6 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 	u8 *dst = buf->mem;
 	int remain;
 
-	/*
-	 * TODO: These stk1160_dbg are very spammy!
-	 * We should 1) check why we are getting them
-	 * and 2) add ratelimit.
-	 *
-	 * UPDATE: One of the reasons (the only one?) for getting these
-	 * is incorrect standard (mismatch between expected and configured).
-	 * So perhaps, we could add a counter for errors. When the counter
-	 * reaches some value, we simply stop streaming.
-	 */
-
 	len -= 4;
 	src += 4;
 
@@ -151,7 +140,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/* Let the bug hunt begin! sanity checks! */
 	if (lencopy < 0) {
-		stk1160_dbg("copy skipped: negative lencopy\n");
+		printk_ratelimited("copy skipped: negative lencopy\n");
 		return;
 	}
 
-- 
2.25.1

