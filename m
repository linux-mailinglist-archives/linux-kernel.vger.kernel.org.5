Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26B7B448E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjI3XKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjI3XKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:10:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C98DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:10:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3226cc3e324so14071500f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696115433; x=1696720233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZlRJtWn09ugbDVFoE3uxLCWlbXzvShTBhbpPLHoziU=;
        b=J09rjg8rj54O8mZO/mjmBZ+TbXgOMVm1R/EI17OQRSpPXKjS92Llhki4Q0ZVOR4F0b
         /YVLtsagT9ZcawtmBuaXMUdVu+thQgN0i7Ab1h1cwpp7brNAd0gmwkLliIUM1YljxE8u
         71G+0SUBspgfTlEoP1iUZoG9S5VGEVDq8vecT9N+VJFEvurPp76uKUseuO3FnT7pTD5m
         ZtmOOh2ngolU3aa6OYxEkDTf5Z3pIjVatcwNA32UViiqo8w7cuvMIDxZgmN9WPewcSSL
         h6gYEsAdnZawcRlbVSbA7FNuHpEJla/45mdvDPTM8yYzqZkzzoX+iF8FtjGB1IbppTzh
         HuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696115433; x=1696720233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZlRJtWn09ugbDVFoE3uxLCWlbXzvShTBhbpPLHoziU=;
        b=wKq/jjsKjo0vRpXYPJavjK9Yn4cuXfbLrb/SW4P54kNxyfMf9H4YnCufynj6gEO/Jx
         r26n1bCIkPvn/XVWB6VOAFJoGayE2ztz+vy88/TeI2WJKsCVjhXqGLQ74NLXDiGoWXPC
         kRZoUOzNBneJguo0BHgFOjvEI8KhWCHfZrD1wKRDgxS+Wfan+RG5FK9Fk5T/0HTM2W6T
         GhuU6WBv5+TuinNhxPSBQRJR5+oOg/+cF2BbpqJKxUGa+vIs8NZazCAKjZjsFfAnRBT3
         4ETdO2MN6FRJ1SFQosnFAu1ZwMHjAQI2ZhsqtnOOBx0dZuVRzS8bF2+nMfHErChmRZnO
         +yQA==
X-Gm-Message-State: AOJu0YwM/b4Is592ARLKTwT+tDhL3PR0r2bF7qMxVRkO+YPW1eKoVpms
        SoKdGJyrsynPrLO+b2dj+Io=
X-Google-Smtp-Source: AGHT+IH4Vhgtdz4wmCzsnJGkwujfW7IvU1trkSzkeS//40APhn3o+nUZc9ZUQ4FEDWPGNV62eIJfcw==
X-Received: by 2002:adf:ee48:0:b0:311:1dba:ca65 with SMTP id w8-20020adfee48000000b003111dbaca65mr7040323wro.51.1696115433225;
        Sat, 30 Sep 2023 16:10:33 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm24524471wru.52.2023.09.30.16.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 16:10:32 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm/filemap: clarify filemap_fault() comments for not uptodate case
Date:   Sun,  1 Oct 2023 00:10:29 +0100
Message-ID: <20230930231029.88196-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing comments in filemap_fault() suggest that, after either a minor
fault has occurred and filemap_get_folio() found a folio in the page cache,
or a major fault arose and __filemap_get_folio(FGP_CREATE...) did the job
(having relied on do_sync_mmap_readahead() or filemap_read_folio() to read
in the folio), the only possible reason it could not be uptodate is because
of an error.

This is not so, as if, for instance, the fault occurred within a VMA which
had the VM_RAND_READ flag set (via madvise() with the MADV_RANDOM flag
specified), this would cause even synchronous readahead to fail to read in
the folio.

I confirmed this by dropping page caches and faulting in memory madvise()'d
this way, observing that this code path was reached on each occasion.

Clarify the comments to include this case, and additionally update the
comment recently added around the invalidate lock logic to make it clear
the comment explicitly refers to the minor fault case.

In addition, while we're here, refer to folios rather than pages.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/filemap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d285ec5f9162..959694a2ade7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3308,21 +3308,28 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
 
 	/*
-	 * We have a locked page in the page cache, now we need to check
-	 * that it's up-to-date. If not, it is going to be due to an error.
+	 * We have a locked folio in the page cache, now we need to check
+	 * that it's up-to-date. If not, it is going to be due to an error,
+	 * or because readahead was otherwise unable to retrieve it.
 	 */
 	if (unlikely(!folio_test_uptodate(folio))) {
 		/*
-		 * The page was in cache and uptodate and now it is not.
-		 * Strange but possible since we didn't hold the page lock all
-		 * the time. Let's drop everything get the invalidate lock and
-		 * try again.
+		 * If the invalidate lock is not held, the folio was in cache and
+		 * uptodate and now it is not. Strange but possible since we
+		 * didn't hold the page lock all the time. Let's drop everything,
+		 * get the invalidate lock and try again.
 		 */
 		if (!mapping_locked) {
 			folio_unlock(folio);
 			folio_put(folio);
 			goto retry_find;
 		}
+
+		/*
+		 * OK, the folio is really not uptodate. This can be because the
+		 * VMA has the VM_RAND_READ flag set, or because an error
+		 * arose. Let's read it in directly.
+		 */
 		goto page_not_uptodate;
 	}
 
-- 
2.42.0

