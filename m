Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC30D7BBBA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjJFPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjJFPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:18:57 -0400
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E5EB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:18:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696605531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2bfkEo5JYZuK7Cv8VAKlPll7M52jynkOgAjxxr9P8w=;
        b=vlDt89zqqnculRELuSeD9jLjZvKkTm/HiU3ElzO3T+fxatuKvM2A4E2SdhRUNGBH2xbgro
        3wvtsb368B03sIGwZKqVO5PGL8PxfVJNm+p51ld6CPnb10yOlBCdGxfsf4fknSSnhps7S3
        EcII2j00X56lu2ZTTlQlFbk3V+F7v2Y=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 3/5] kasan: use unchecked __memset internally
Date:   Fri,  6 Oct 2023 17:18:44 +0200
Message-Id: <6f621966c6f52241b5aaa7220c348be90c075371.1696605143.git.andreyknvl@google.com>
In-Reply-To: <cover.1696605143.git.andreyknvl@google.com>
References: <cover.1696605143.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

KASAN code is supposed to use the unchecked __memset implementation when
accessing its metadata.

Change uses of memset to __memset in mm/kasan/.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 4 ++--
 mm/kasan/shadow.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ca4b6ff080a6..12557ffee90b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -538,7 +538,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
 
 	start_report(&flags, true);
 
-	memset(&info, 0, sizeof(info));
+	__memset(&info, 0, sizeof(info));
 	info.type = type;
 	info.access_addr = ptr;
 	info.access_size = 0;
@@ -576,7 +576,7 @@ bool kasan_report(const void *addr, size_t size, bool is_write,
 
 	start_report(&irq_flags, true);
 
-	memset(&info, 0, sizeof(info));
+	__memset(&info, 0, sizeof(info));
 	info.type = KASAN_REPORT_ACCESS;
 	info.access_addr = addr;
 	info.access_size = size;
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index dd772f9d0f08..d687f09a7ae3 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -324,7 +324,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	if (!page)
 		return -ENOMEM;
 
-	memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
+	__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
 	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
 
 	spin_lock(&init_mm.page_table_lock);
-- 
2.25.1

