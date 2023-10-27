Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320DB7D99A5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbjJ0NWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjJ0NWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:22:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F1C9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:22:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b02ed0f886so1265677b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698412955; x=1699017755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=97bswsbZUtfLtcRYk2QqxU2uMSJhqWkgINgMHmv0BiM=;
        b=FCF6UVxakvmAsOIuiOh+UJ4Him6U8MPB03Khvb+uUqVB28IbKIjU6ohZkg28P6Jh6n
         yecuDLaVWdkNN8xW+dj/CXcwXyn6PPZASqrgEfk9XXsL5RyX+DAjonqP02R/vNYe7+81
         kZIDwXoJUZ2Ij2Gl41GFD1OWse+AoM8Tqsb8H4ZEdndD5zIzywfG+5CsD2GapttrK3av
         /RezKQ29PoIsvX0EGjrWQxFF0Ex8bg8wt8IOKUZqwFrz/VXib5ZaIfzwtASI72CXlQTq
         98uGYqw0ICoDdlnYr1tV1aHZ5THVMczWbbpRShiYGpwaeYkVffkNDXpcn5Y644Is+4fc
         nmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412955; x=1699017755;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97bswsbZUtfLtcRYk2QqxU2uMSJhqWkgINgMHmv0BiM=;
        b=AUchhgt0AX0WAFo5xCyetEcaGykNhxjYny4He5d/GEMNyDRtuJfp8ZGP9UPSIqBSDp
         QiFddV93TUjTSobcuumvv6aBCq6rMfDjOW/qkiODYDyKnlxkzq40oLiq/1YmhOKqPz2K
         ibQh4K9NjerzkpRxNurfpHxEC0Ybrn9+KZzxrK/VSURm+EaEw6d8B96eHtF3CxtX/QZM
         SOCKEl9qDNAJuNHZYtochO3jJrOIv2GflS2hFpehDEXz7V3Q4jJFOusXo7WO7vnXGSUb
         V91e1cLlne7Twm0z+r21WmoHX1++3XjMdhf53/cZwmMD/u1n/3rzyxgLgkmzU0eqGlJp
         gwxw==
X-Gm-Message-State: AOJu0YyMNyFW8L2/qpGI58jTlbQw1xcFudk9YQ7SgvUSQGKjtnDzSPxt
        BMSzzArlfZtr0eHkEhuOv5mvCHHXthVxQw==
X-Google-Smtp-Source: AGHT+IGL+C0fbBM5VafdLuPRMYH6kUsoS46L/qe2BlH7/k/MU9gckSSk8mdv8Ldfy7Mmxhb9dPUSL+diEg8N9w==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0d:df48:0:b0:5a7:b496:5983 with SMTP id
 i69-20020a0ddf48000000b005a7b4965983mr49780ywe.9.1698412955678; Fri, 27 Oct
 2023 06:22:35 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:22:13 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027132213.3817924-1-jackmanb@google.com>
Subject: [PATCH] mm/page_alloc: Dedupe some memcg uncharging logic
From:   Brendan Jackman <jackmanb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yosryahmed@google.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The duplication makes it seem like some work is required before
uncharging in the !PageHWPoison case. But it isn't, so we can simplify
the code a little.

Note the PageMemcgKmem check is redundant, but I've left it in as it
avoids an unnecessary function call.

Signed-Off-By: Brendan Jackman <jackmanb@google.com>
Change-Id: Ibe0f9941b6b24fc98ea2510a75d0a0d1066a2a2e
---
 mm/page_alloc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 85741403948f..b9e81e416e73 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1084,13 +1084,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
+	if (memcg_kmem_online() && PageMemcgKmem(page))
+		__memcg_kmem_uncharge_page(page, order);
+
 	if (unlikely(PageHWPoison(page)) && !order) {
-		/*
-		 * Do not let hwpoison pages hit pcplists/buddy
-		 * Untie memcg state and reset page's owner
-		 */
-		if (memcg_kmem_online() && PageMemcgKmem(page))
-			__memcg_kmem_uncharge_page(page, order);
+		/* Do not let hwpoison pages hit pcplists/buddy */
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
 		return false;
@@ -1122,8 +1120,6 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	}
 	if (PageMappingFlags(page))
 		page->mapping = NULL;
-	if (memcg_kmem_online() && PageMemcgKmem(page))
-		__memcg_kmem_uncharge_page(page, order);
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
-- 
2.42.0.820.g83a721a137-goog

