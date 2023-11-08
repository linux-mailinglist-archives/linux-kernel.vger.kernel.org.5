Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9C7E5BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjKHQta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKHQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:49:28 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04FA1FD6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:49:26 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9d216597f5fso533101766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699462165; x=1700066965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f+htJKZ/Y85O1839RGUSFWieIBLrRpnb2wXiA69z2nI=;
        b=IMchypkkkkIeAyHe+k80g0EDc8tDHxpxZYSNZzFLqP1SwPod/sEp2mXwuKa4zqoIFg
         Q0qeZydacv3HIK5omOUxb69VVKalvzRyhBKMKErcrl8UnGoFz/kLLlossqfF5YZNNwJE
         EWQzl/CGX7S4sXDxofLQZJzHmjrZyRbPudvopJTEyWtHngWQUuUNWqlONh9yqRZsthRF
         +P2JrRDY8pikBVRN0GGb1cs+uZihWhD530oAlcc/wHtp9uklGXQstxqqyoA8snpW8ISP
         R0IKPRpLK13TrXLe/cQVW0TdPknV3aVXN05m7s0UkqQSGlEDDL22M11+tVUQwGw1u5Ku
         2ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699462165; x=1700066965;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+htJKZ/Y85O1839RGUSFWieIBLrRpnb2wXiA69z2nI=;
        b=Ygsndwus/2mdNaw6Y8LJbk/ooXpD39GIPovdkdi044W4GT7Q9Axu4cEu7Is+M+EkZO
         gKfBdgbsm7jps0HSJWL+956n9oSy9q4lOWsLzIKDQrcMdjekaSGIRUPmhuhGkFW4os5R
         d0XBsDYBnJI+lAXgCrKG5reLuwSLNFiM7Ykj+ytw2dVkWq3X/OHPz8ZWx4X3to6fd473
         PPKu1OcZ2idBo5TI7LXgHfMqT9ArHAYY5UclyTcSStKfxlllx01yjH5FjJB+YN7CrybP
         Lv6n3H1aZfPeHBZobI6mZaLe2DzXybMaNuesG7OVrFWbScVEEFi+hooQOSAOD5XKH2L2
         XZKA==
X-Gm-Message-State: AOJu0YwxCQp9Mt/jGBuLJy/ZWsrkPLdaWxfe21vmEjE2sVSrcUf+6vBE
        MMxwSEsgSzUlS2GdfIv1MkkbmA0ReHEFvw==
X-Google-Smtp-Source: AGHT+IFXD7JBU7Ih4GN9dRKagmjiX/0+G1ettC7JnYtPW36ZDnFm+K0UN+rGEj+e/pp9dXcfNvFb0HPFeWQLvQ==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a17:906:dfe6:b0:9be:dbea:42a2 with SMTP
 id lc6-20020a170906dfe600b009bedbea42a2mr15361ejc.8.1699462165146; Wed, 08
 Nov 2023 08:49:25 -0800 (PST)
Date:   Wed,  8 Nov 2023 16:49:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108164920.3401565-1-jackmanb@google.com>
Subject: [PATCH v2] mm/page_alloc: Dedupe some memcg uncharging logic
From:   Brendan Jackman <jackmanb@google.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The duplication makes it seem like some work is required before
uncharging in the !PageHWPoison case. But it isn't, so we can simplify
the code a little.

Note the PageMemcgKmem check is redundant, but I've left it in as it
avoids an unnecessary function call.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..dd5e8a759d27 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1086,13 +1086,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
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
@@ -1123,8 +1121,6 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	}
 	if (PageMappingFlags(page))
 		page->mapping = NULL;
-	if (memcg_kmem_online() && PageMemcgKmem(page))
-		__memcg_kmem_uncharge_page(page, order);
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
 			bad++;
-- 
2.42.0.869.gea05f2083d-goog

