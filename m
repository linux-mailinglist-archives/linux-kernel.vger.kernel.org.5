Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24F08026C0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjLCTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjLCTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:07 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75E1D7;
        Sun,  3 Dec 2023 11:33:13 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d8a772157fso827577b3.3;
        Sun, 03 Dec 2023 11:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701631992; x=1702236792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAyYvrL0t2q2EDlcDQbeeWn4OCREUUSIjrvkd6SFaaI=;
        b=ViFkvIUYg4v6/lNqDfNqYsLRcXHWUnBnF+vsVxHZ3HO+xYkMlTwHPwBk/TMsyuvK8o
         ND7cW9QOxRjxm1CcydxuC7IJZsJLyvUmxVF11Qpic71op2WLmHcI+M8emGqsSJvks2Hs
         TP/8dagURbCYETp5iZv65uIui3uAmWDpzF3wf4ClTD481/390d/ziG+Lp9fJR28krv/i
         5yAop0eKmyuNRmunozf1w8GRsNvylHvTqypmB41VxIj6MSYq6yAWq4TlCEEVZqD6h0v9
         ry2+208kxYnOC4FkFILHQ2KYF0uOnfZfGmgUVFoA9ZcOx5pE+gCKujxGAKOy6fN7YY56
         gbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701631992; x=1702236792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAyYvrL0t2q2EDlcDQbeeWn4OCREUUSIjrvkd6SFaaI=;
        b=m4Pxl3NUEzQIOOySBkFw0xgh8D9HcB79wwpEsubH6B7mStLh412Grm7g9sZa2NUDMy
         GDP/RaUng+LDYRjBSDbo4lAlfZWaj0+IWSMpA7h+erQBSIkGx3ARB6U9iSyfQ7p9dcmS
         BYlw0sIFHvAa4aH3GzbUpALnbl8gG2ZOqtQ4fdXwfzcjuGhNUgMGdD/IwAscEYUxOBzr
         w0AjvfqTovHTZ8PVN+JWvxgjZvUewAUBuXhjfCVljmkviy71L8USPDBYZXdepcDaFI5u
         YK9l1KwMZQN2HH9ZdzTYNunP99zaTtQvMBcv004pz7OJaMb0uaDdusw0JH86epfSx/fM
         5Htg==
X-Gm-Message-State: AOJu0YySR3cnvTDvzPI5UCbESjy0flZt12t6x7ENKxysqNEzcFSNP0a2
        adEX8SG8F26krxJ1BQpn6ypE4tJeYmt72w==
X-Google-Smtp-Source: AGHT+IHZp4uuqUobiMQ9oWOkOaWnBd/KxIOvjuhOfcj4DTkHUV3w9yWl7F5kLe2SoeLF4SXOjanoWQ==
X-Received: by 2002:a81:ee0b:0:b0:5d7:1941:a9a with SMTP id l11-20020a81ee0b000000b005d719410a9amr2124651ywm.53.1701631992159;
        Sun, 03 Dec 2023 11:33:12 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id w19-20020a0dd413000000b005d6da42e443sm1718421ywd.59.2023.12.03.11.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:11 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 03/35] lib/sbitmap; make __sbitmap_get_word() using find_and_set_bit()
Date:   Sun,  3 Dec 2023 11:32:35 -0800
Message-Id: <20231203193307.542794-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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
2.40.1

