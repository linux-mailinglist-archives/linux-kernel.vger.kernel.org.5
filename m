Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DB780E17A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345718AbjLLC2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjLLC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:27:53 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB46D5;
        Mon, 11 Dec 2023 18:27:59 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d9e993d94dso2881092a34.0;
        Mon, 11 Dec 2023 18:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348078; x=1702952878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuotiINhbKGxGGef8K7G7yCOze6MU0SeJK9/E0VqPZk=;
        b=mOu2oZ9PdmyEQBvwYpbB4CxFhLPixosCG/9dqh1Cc/zIR24Fy9cxxE1bnhoq1S4HSH
         2vlmhvyBtQA6tn2USXss6mEQeM9wt3l7Id3Tbu6029uRdoR/RA2glANWTWs/YjBv1Hrf
         RO/Bq3AuywwoN+LCLd+t/kP5HmkKKJGtbX3R58KaCqjuMoNFp/yw9rDdjSIIHkKMPiFJ
         ejqmZaLjmHXR4jE3vqghgoNj8WYXML9w9KOYHNlI/6E8PzshNsPZ6oKg7RLlSFj0GSaE
         4DFw8w8uzqma1JnB04lU5hqrxYCQFneSE1bTt7mVJi7m4RNINMm7qpk/IDGJxwD7hexQ
         o9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348078; x=1702952878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuotiINhbKGxGGef8K7G7yCOze6MU0SeJK9/E0VqPZk=;
        b=hNOl2H/obmBkuHof2JdmjYHXOu7+BQ9EvpAl/06W62xhN8MKny6AmKD7YGffI7etC1
         lpnA5K9w6xOx5pFZQ4V2x8SXsVHz4AnUc1PqpGqXBAMHqsNjZeWdAakpsccUVFS6qetv
         QGZx0/w6+ZecW/OIU6oI9D8/rcx0DcqVsHuAfpg9LvHKbMxH2YhPTy6IolGN9wvyl2IN
         zmwvaySq4eUxSEl6Qlo9AYisCF5BLRvQeAr9QbqK+QbmMmgJb67/gpBgIF/Z/5/Pr31q
         lvR80DxVqOpy3nmrfOHDNZfxyIRpBrl6ovmdsXd/5sw8S7C1ssA5dyI9Vn4BfrNo3Viy
         ZdIg==
X-Gm-Message-State: AOJu0YyMGJIhoR/j94c6UT2TGKIBe06djo4hGnT1j80nujKkkwCefYEV
        RRJemezSlojt0l0VbYAGfpuu5zgrB038Dw==
X-Google-Smtp-Source: AGHT+IEHnCevx/zjXgMWzqImSiSNPCTlhUeZk/gNmGSenVJT/HCL0VqZAYmviFs6i1xsO2WZY35Fqw==
X-Received: by 2002:a05:6830:16d9:b0:6d8:74e2:6f48 with SMTP id l25-20020a05683016d900b006d874e26f48mr4356891otr.68.1702348078162;
        Mon, 11 Dec 2023 18:27:58 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id q1-20020a0de701000000b005cb1bf4d466sm3464287ywe.82.2023.12.11.18.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:27:57 -0800 (PST)
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
Subject: [PATCH v3 03/35] lib/sbitmap; optimize __sbitmap_get_word() by using find_and_set_bit()
Date:   Mon, 11 Dec 2023 18:27:17 -0800
Message-Id: <20231212022749.625238-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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
find_and_set_next_bit() depending on wrap parameter. Simplify it by using
atomic find_bit() API.

While here, simplify sbitmap_find_bit_in_word(), which calls it.

CC: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 lib/sbitmap.c | 46 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d0a5081dfd12..8ecd830ba9e8 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -133,38 +133,13 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
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
+	if (wrap)
+		return find_and_set_bit_wrap_lock(word, depth, hint);
 
-		if (!test_and_set_bit_lock(nr, word))
-			break;
-
-		hint = nr + 1;
-		if (hint >= depth - 1)
-			hint = 0;
-	}
-
-	return nr;
+	return find_and_set_next_bit_lock(word, depth, hint);
 }
 
 static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
@@ -175,15 +150,12 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
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

