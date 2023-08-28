Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E3C78B77D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjH1Sou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjH1SoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:16 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F092BB0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:13 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bca3588edbso2412600a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248253; x=1693853053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xsr5nuLzGFxbxx1dxP1OouE4C2MjCJK6X4fU7S8Qbg=;
        b=MTBh2p4dZ2lSWT3AayKmfZTXiMSYGb+4LftonLa4Z5Yozn/ZasQ7MFI4sPMAV021hv
         140IJmcvo23zt/UEn1G4fwZHFWhGMuFeV8rUjyfbHs3bee4rg3fZDE4KO2ALI6cy9t9a
         9G9yc3/i+46l9srmjmQaIQoGZaKqWHJeQ5d0gTkkYXUCnDm/3NPxNr9YKULLEi2/pkZG
         m2JdL4TQ7OhQ/sW/aXae+ea+S/gNb8a1S/ryCQ4oGqoItilLoY237xMWEw0NyFdbYfmK
         SWLDIuaJ+X9r7yb9WEbk2CUGxOQ+3nZnNHdVzrtrQQW/AiOT4vuVQIV8A/w8jAIp0vaU
         9fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248253; x=1693853053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xsr5nuLzGFxbxx1dxP1OouE4C2MjCJK6X4fU7S8Qbg=;
        b=Om7pxYwjfe2Skjnf0w9GBKZI4+QE5b6oR0TD4BkkHvyH/CMYqFwCIPH4YTXdyAamUR
         /p9Ak7Y3T8s6gFcno7UfSiR0+teWAd6rguEbwecntWVLJzVBfOy5n+NOUDA6dtdYIzBd
         M5WqJf7GMOsHWb6JbybYE9zQqaHiOC58/YvV49NhdrsxV7mZzv76ASRFpMTchn7mnG4r
         L771QIChWw0QJYMw9vzIYNHqgl1wyFBmwRj9iTG2jsvJ7g58E1km7fglSpjrqRIL39Pw
         1YwSQMgNHMHsl54oygfrfMNIvtBamNw8Spi1eXY9CmGhaWV+RDMDZ4Iy+McrUI0vvboD
         rgLw==
X-Gm-Message-State: AOJu0YwXAN9tEjjtDaOYfkkdRP1OQ7lJrRXYnzpHzKqB/sA2L0rB0HIX
        cCQ8iA+SIrnT1xfMrDjHd6Ae87NGc9g=
X-Google-Smtp-Source: AGHT+IGbHDCCFDLGLe2HLemq4m/efj7fH9wBMxKTtFu9ecDGYAAh2SYDEbmI/pyJsFAa05gVz9ZLmg==
X-Received: by 2002:a05:6830:32aa:b0:6be:fb88:8352 with SMTP id m42-20020a05683032aa00b006befb888352mr5766080ott.8.1693248252838;
        Mon, 28 Aug 2023 11:44:12 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id i6-20020a056830010600b006b4281cf424sm3719852otp.4.2023.08.28.11.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:12 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 11/12] bitmap: defer calculating weight of 'new' in bitmap_remap()
Date:   Mon, 28 Aug 2023 11:43:51 -0700
Message-Id: <20230828184353.5145-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828184353.5145-1-yury.norov@gmail.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'old' map is empty, we don't need to calculate weight of 'new' map,
because all 'src' bits are simply copied to dst.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index f62ea97e942c..1fca60d54cb4 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -996,23 +996,24 @@ void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new,
 		unsigned int nbits)
 {
-	unsigned int oldbit, w, n;
+	unsigned int oldbit, w = 0, n;
 
 	if (dst == src)		/* following doesn't handle inplace remaps */
 		return;
 
-	w = bitmap_weight(new, nbits);
-	if (w == 0) {
-		bitmap_copy(dst, src, nbits);
-		return;
-	}
-
 	/* Identity part */
 	bitmap_andnot(dst, src, old, nbits);
 
 	/* Remapping part */
 	for_each_and_bit(oldbit, src, old, nbits) {
 		n = bitmap_weight(old, oldbit);
+		if (w == 0) { /* if not initialized */
+			w = bitmap_weight(new, nbits);
+			if (w == 0) { /* if empty */
+				bitmap_copy(dst, src, nbits);
+				return;
+			}
+		}
 		__set_bit(find_nth_bit(new, nbits, n % w), dst);
 	}
 }
-- 
2.39.2

