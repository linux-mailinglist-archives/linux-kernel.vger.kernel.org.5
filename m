Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5059675DF45
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGVXPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGVXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:15:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510FA171E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:15:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-765942d497fso290114285a.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1690067715; x=1690672515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz1WtFDUN503GFfPrb86//foDSemE6Fx12xrK89H/vw=;
        b=bY/thvLcgkc1kW1AiaCtDdgCl0GfMZRm3ZXHre3bwwItwa2QFP+rNHHQro/QmoOQff
         SI+ax91vPJVjZuEexwJ+NcNiJvh4ZD341RywPTp5zViX/QpyMlKvE3BatWDge2b9aXYf
         XRzErIo70NKB3/0lov6evFqbdQDftwlrF7WGfTt7v1ErLh86yDMTI1f/NmNREfl6eeu9
         JT2qhvs7omUMVpT19OxD5mhUoM7yVse9sNIt+segHAFkLEZSDmqFDZIBfzvQJAbRxmEO
         dHiDwjGBelZXtngdm3adx169KFbtYBzX1XRUx1NX2rbo7fGIjG9wank6BOnumMU7frS0
         bjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690067715; x=1690672515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz1WtFDUN503GFfPrb86//foDSemE6Fx12xrK89H/vw=;
        b=GuZELCji62BoaD+pivhe9uULynUWnNT03GVGTCOZKM1cOcu3dZQMryAq8bJ/nBBvFI
         tiqZFIF1jCt6i4Qsz0TejX91eb7baFnOrJ6qi60cXsoXlGTiS1cF/LqoMLpCIUfOEKVD
         FzCM2WgQxXEb8s2we95Ai0//8nMR623iPfqXQxOBl6HqxImw3us1XQxYLu5BA4LUUng/
         0zeElVwg86kRhCDJT2fZThQta4ZADUwC2xXQUbbmda6EN7PNL0G5otwgyl6bPp7Uv+ti
         AN1tnwGjItrkNIiDnLYL0rNVihpEhcwwcTGe4zg0zkJJ1p4q0fh3wXZyx6DBLKVIgY//
         2T0Q==
X-Gm-Message-State: ABy/qLYf40g8dqJBd+LHIHbzQOcy1PKnsGAr/q38T5RjITS9w63/Etlr
        vYwP/RIrylzzlHS5TEAKBHBARBb901N3MN4jLjc=
X-Google-Smtp-Source: APBJJlHl+ww4l/5L3aVaKf+nyHJSNfnHmrmG6yrGFh/lnSNpYxDd9Cn/A23HI9OTbXjjHyktI1V6bQ==
X-Received: by 2002:a05:620a:158f:b0:767:e27d:99fe with SMTP id d15-20020a05620a158f00b00767e27d99femr3915518qkk.29.1690067715304;
        Sat, 22 Jul 2023 16:15:15 -0700 (PDT)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b007675c4b530fsm2075957qkk.28.2023.07.22.16.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 16:15:14 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: [PATCH v2 1/3] mm/page_table_check: Do WARN_ON instead of BUG_ON
Date:   Sat, 22 Jul 2023 23:15:06 +0000
Message-ID: <20230722231508.1030269-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230722231508.1030269-1-pasha.tatashin@soleen.com>
References: <20230722231508.1030269-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, page_table_check when detects errors panics the kernel. Instead,
print a warning as it is more useful compared to unconditionally crashing
the machine.

However, once a warning is detected, the counting of page_table_check
becomes unbalanced, therefore,  disable its activity until the next boot.

In case of where machine hardening requires a more secure environment, it
is still possible to crash machine on page_table_check errors via
panic_on_warn sysctl option.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_table_check.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 93ec7690a0d8..ad4447e999f8 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -22,6 +22,12 @@ static bool __page_table_check_enabled __initdata =
 DEFINE_STATIC_KEY_TRUE(page_table_check_disabled);
 EXPORT_SYMBOL(page_table_check_disabled);
 
+#define PAGE_TABLE_CHECK_WARN(v)						\
+	do {									\
+		if (WARN_ON_ONCE(v))						\
+			static_branch_enable(&page_table_check_disabled);	\
+	} while (false)
+
 static int __init early_page_table_check_param(char *buf)
 {
 	return kstrtobool(buf, &__page_table_check_enabled);
@@ -50,7 +56,8 @@ struct page_ext_operations page_table_check_ops = {
 
 static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
 {
-	BUG_ON(!page_ext);
+	PAGE_TABLE_CHECK_WARN(!page_ext);
+
 	return (void *)(page_ext) + page_table_check_ops.offset;
 }
 
@@ -72,18 +79,18 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
 
-	BUG_ON(PageSlab(page));
+	PAGE_TABLE_CHECK_WARN(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
 		if (anon) {
-			BUG_ON(atomic_read(&ptc->file_map_count));
-			BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);
+			PAGE_TABLE_CHECK_WARN(atomic_read(&ptc->file_map_count));
+			PAGE_TABLE_CHECK_WARN(atomic_dec_return(&ptc->anon_map_count) < 0);
 		} else {
-			BUG_ON(atomic_read(&ptc->anon_map_count));
-			BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
+			PAGE_TABLE_CHECK_WARN(atomic_read(&ptc->anon_map_count));
+			PAGE_TABLE_CHECK_WARN(atomic_dec_return(&ptc->file_map_count) < 0);
 		}
 		page_ext = page_ext_next(page_ext);
 	}
@@ -110,18 +117,18 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
 
-	BUG_ON(PageSlab(page));
+	PAGE_TABLE_CHECK_WARN(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
 		if (anon) {
-			BUG_ON(atomic_read(&ptc->file_map_count));
-			BUG_ON(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
+			PAGE_TABLE_CHECK_WARN(atomic_read(&ptc->file_map_count));
+			PAGE_TABLE_CHECK_WARN(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
 		} else {
-			BUG_ON(atomic_read(&ptc->anon_map_count));
-			BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
+			PAGE_TABLE_CHECK_WARN(atomic_read(&ptc->anon_map_count));
+			PAGE_TABLE_CHECK_WARN(atomic_inc_return(&ptc->file_map_count) < 0);
 		}
 		page_ext = page_ext_next(page_ext);
 	}
@@ -137,15 +144,15 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 	struct page_ext *page_ext;
 	unsigned long i;
 
-	BUG_ON(PageSlab(page));
+	PAGE_TABLE_CHECK_WARN(PageSlab(page));
 
 	page_ext = page_ext_get(page);
-	BUG_ON(!page_ext);
+	PAGE_TABLE_CHECK_WARN(!page_ext);
 	for (i = 0; i < (1ul << order); i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
-		BUG_ON(atomic_read(&ptc->anon_map_count));
-		BUG_ON(atomic_read(&ptc->file_map_count));
+		PAGE_TABLE_CHECK_WARN(atomic_read(&ptc->anon_map_count));
+		PAGE_TABLE_CHECK_WARN(atomic_read(&ptc->file_map_count));
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
-- 
2.41.0.487.g6d72f3e995-goog

