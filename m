Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9E7F0074
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjKRPvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKRPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:51:17 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5C1A1;
        Sat, 18 Nov 2023 07:51:14 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5c99226c1e6so1048087b3.1;
        Sat, 18 Nov 2023 07:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322672; x=1700927472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wja3OVPJTOloxhD0fIIOnOKhGR1o2s7RteZ+eX82u+o=;
        b=LezXZ6w9oRAfsFpEnEKgrHaoIbxiWXXQoO30aBaUNEVY0CLBzI+FewEhmYuXPZgFKO
         Jlbvc5gUCIIwxhD9C0Bxp70TB5JCyXzNNQCD/G0DpriBVPAjnGN0KHTnVGH0iQun5keL
         jyuXirnQpGF06pyHvQQLpuvEX+IvtzLyWur7RQ4ym3KhFoLs6n0B/liW7BzI1uCAIQbT
         Kd9BuNbqP972eUXr4T39BiQssIVmO6b50pP2kH9YNiLulUmAydIfSGoPl+NXoVX7b801
         5aPMBuiMvu1zn17OSGlXCEsrbk0gw/lrzL9XTa4UnyrK7dy2+3SEOhtcYRyZrZCbU3Ar
         TiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322672; x=1700927472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wja3OVPJTOloxhD0fIIOnOKhGR1o2s7RteZ+eX82u+o=;
        b=fPg9Wk8B7a9XsZV2klt/QL9asY6omZUYzjsXUcoHmLgRPPOtBv0W+d5zj18BdlvGiw
         8qbU9JiywXNbxyr0izJ9gdoIBFYqEJvDQJcVUMvtuvHQ/EnTa4VOzWh3/C/Qo/K3D6Ka
         R3ulKPKJ74X2LSWaDfCsNOzqJU3Jturs0oea+1kSbUM8+UChXGyhwltJrf7/s77E1hZF
         of9hymMHOK8094oHdnWUaLwo/k8nUeePiWL1ACTMIe8BdTfcGJ+njCyPcoadVdkpf63r
         lq/B6D5OzEKV1l0z+3S/S0dT7BoJHrEkoshoPkd7Uzm0UD1T7e5ie4sUVSHz9k6D8wjL
         XF8Q==
X-Gm-Message-State: AOJu0YyXNKgAz1Fmg6sH1SglDhhnOHZ61P8qy8Zm6BuFu1RCZVkU9zMK
        +us+yntGlycaWft6zUeswbeHVhS+wQgazg3e
X-Google-Smtp-Source: AGHT+IEFudjl0N99Cl4PwLQEleOne3mxPbcgnDGVV5racEbAxc64DY18CSZOjNB06KLe6F00y6ofIA==
X-Received: by 2002:a81:528d:0:b0:5b0:36f5:81d2 with SMTP id g135-20020a81528d000000b005b036f581d2mr1329059ywb.26.1700322671999;
        Sat, 18 Nov 2023 07:51:11 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id s189-20020a0de9c6000000b005c5c3bae1dfsm1178248ywe.54.2023.11.18.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:10 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 02/34] lib/sbitmap; make __sbitmap_get_word() using find_and_set_bit()
Date:   Sat, 18 Nov 2023 07:50:33 -0800
Message-Id: <20231118155105.25678-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__sbitmap_get_word() opencodes either find_and_set_bit_wrap(), or
find_and_set_next_bit() depending on hint and wrap parameters.

Switch it to use the atomic find_bit() API. While here, simplify
sbitmap_find_bit_in_word(), which calls it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/sbitmap.c | 46 ++++++++--------------------------------------
 1 file changed, 8 insertions(+), 38 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d0a5081dfd12..b21aebd07fd6 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -133,38 +133,11 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 }
 EXPORT_SYMBOL_GPL(sbitmap_resize);
 
-static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
+static inline int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			      unsigned int hint, bool wrap)
 {
-	int nr;
-
-	/* don't wrap if starting from 0 */
-	wrap = wrap && hint;
-
-	while (1) {
-		nr = find_next_zero_bit(word, depth, hint);
-		if (unlikely(nr >= depth)) {
-			/*
-			 * We started with an offset, and we didn't reset the
-			 * offset to 0 in a failure case, so start from 0 to
-			 * exhaust the map.
-			 */
-			if (hint && wrap) {
-				hint = 0;
-				continue;
-			}
-			return -1;
-		}
-
-		if (!test_and_set_bit_lock(nr, word))
-			break;
-
-		hint = nr + 1;
-		if (hint >= depth - 1)
-			hint = 0;
-	}
-
-	return nr;
+	return wrap ? find_and_set_bit_wrap_lock(word, depth, hint) :
+			find_and_set_next_bit_lock(word, depth, hint);
 }
 
 static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
@@ -175,15 +148,12 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	int nr;
 
 	do {
-		nr = __sbitmap_get_word(&map->word, depth,
-					alloc_hint, wrap);
-		if (nr != -1)
-			break;
-		if (!sbitmap_deferred_clear(map))
-			break;
-	} while (1);
+		nr = __sbitmap_get_word(&map->word, depth, alloc_hint, wrap);
+		if (nr < depth)
+			return nr;
+	} while (sbitmap_deferred_clear(map));
 
-	return nr;
+	return -1;
 }
 
 static int sbitmap_find_bit(struct sbitmap *sb,
-- 
2.39.2

