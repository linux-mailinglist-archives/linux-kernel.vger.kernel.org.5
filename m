Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B491A78C000
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjH2IMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjH2ILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B3E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5007616b756so6548801e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296706; x=1693901506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR6SvlG6RVqjpwTXvW3wIJv5GQWXT7NLdjvAZjLWLsM=;
        b=QxThSYRwDtcE6nVhtK77Bm0vpeVqL1+GW7jmP7pJXd2x1LSjjVHUSOzUkmQ50ayv1A
         Wk8PDFDtcTBiDNVJyGosExWMqHj0UnI11W5Howqzjd/g6CiGQZrRGR4cSSv151uKSnAF
         pMN4P9e398gh/DtM2IioA/kT2cgyNgezI62AjKiJNw/sm/8YPwqFO5ear/XGoPX9ZJ3r
         cydejULmZlzX3LouEZVkLDFq5LpxOEG7Qhil0DCO2+8SSC9q8je8V6+goqRnyIaBvyhI
         UgMFNWk7WtmxZoO+GcfZ3aR8jO+hBkTj6pnIxKqEebqGcKrtimaMyY/nopENrKiqtx2G
         r5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296706; x=1693901506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZR6SvlG6RVqjpwTXvW3wIJv5GQWXT7NLdjvAZjLWLsM=;
        b=FDp6XaXhl78r7zODNO34lVPc8ceTMdNiI0sbCe2U2CF2M2qfsxKf4DLfE4PFKrF6si
         SPibEikr+KMhSSFOlvrGMPH7kB1Q66fp/6wns9hGSUHhogexSsigUQoaPWEzayR5Er4c
         v2a8QmKDinYgeToM27W+7ID+BHSutkwkzXDMaE0BnlAAFh946Evq3jwAXJb6NQ5qgto9
         gVNs51WmrNWtAvgFPP1dJ3tJXPZFl2h86PDJf80l7pV0jfSRv7OeWll6nE0jwC3UgrYp
         XUkFO5Q8IDHvnl5pkN0jFGSmCVMKsAxC3JCozSM00XkHpkYPcIWCk2fjPvyfZvhG4mPy
         OfAQ==
X-Gm-Message-State: AOJu0YwWJbSd8Wmxwn85fTDsSGYaiQIOOxdyRZkvM8OSvrEBwpsuEh4l
        mNJl45D2+xNx9rq00149VSE=
X-Google-Smtp-Source: AGHT+IGEnacQTpxADckRzHoYIXvZaUhpJE6tHjbYNN3uY99M3n0FzgtKGoq4Q7h2iZ7uuaPLaYrrjQ==
X-Received: by 2002:a05:6512:304f:b0:500:b890:fb38 with SMTP id b15-20020a056512304f00b00500b890fb38mr5023278lfb.24.1693296706241;
        Tue, 29 Aug 2023 01:11:46 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:45 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 3/9] mm: vmalloc: Move vmap_init_free_space() down in vmalloc.c
Date:   Tue, 29 Aug 2023 10:11:36 +0200
Message-Id: <20230829081142.3619-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230829081142.3619-1-urezki@gmail.com>
References: <20230829081142.3619-1-urezki@gmail.com>
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

A vmap_init_free_space() is a function that setups a vmap space
and is considered as part of initialization phase. Since a main
entry which is vmalloc_init(), has been moved down in vmalloc.c
it makes sense to follow the pattern.

There is no a functional change as a result of this patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 82 ++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 09e315f8ea34..b7deacca1483 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2512,47 +2512,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
 }
 
-static void vmap_init_free_space(void)
-{
-	unsigned long vmap_start = 1;
-	const unsigned long vmap_end = ULONG_MAX;
-	struct vmap_area *busy, *free;
-
-	/*
-	 *     B     F     B     B     B     F
-	 * -|-----|.....|-----|-----|-----|.....|-
-	 *  |           The KVA space           |
-	 *  |<--------------------------------->|
-	 */
-	list_for_each_entry(busy, &vmap_area_list, list) {
-		if (busy->va_start - vmap_start > 0) {
-			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
-			if (!WARN_ON_ONCE(!free)) {
-				free->va_start = vmap_start;
-				free->va_end = busy->va_start;
-
-				insert_vmap_area_augment(free, NULL,
-					&free_vmap_area_root,
-						&free_vmap_area_list);
-			}
-		}
-
-		vmap_start = busy->va_end;
-	}
-
-	if (vmap_end - vmap_start > 0) {
-		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
-		if (!WARN_ON_ONCE(!free)) {
-			free->va_start = vmap_start;
-			free->va_end = vmap_end;
-
-			insert_vmap_area_augment(free, NULL,
-				&free_vmap_area_root,
-					&free_vmap_area_list);
-		}
-	}
-}
-
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
@@ -4443,6 +4402,47 @@ module_init(proc_vmalloc_init);
 
 #endif
 
+static void vmap_init_free_space(void)
+{
+	unsigned long vmap_start = 1;
+	const unsigned long vmap_end = ULONG_MAX;
+	struct vmap_area *busy, *free;
+
+	/*
+	 *     B     F     B     B     B     F
+	 * -|-----|.....|-----|-----|-----|.....|-
+	 *  |           The KVA space           |
+	 *  |<--------------------------------->|
+	 */
+	list_for_each_entry(busy, &vmap_area_list, list) {
+		if (busy->va_start - vmap_start > 0) {
+			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+			if (!WARN_ON_ONCE(!free)) {
+				free->va_start = vmap_start;
+				free->va_end = busy->va_start;
+
+				insert_vmap_area_augment(free, NULL,
+					&free_vmap_area_root,
+						&free_vmap_area_list);
+			}
+		}
+
+		vmap_start = busy->va_end;
+	}
+
+	if (vmap_end - vmap_start > 0) {
+		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+		if (!WARN_ON_ONCE(!free)) {
+			free->va_start = vmap_start;
+			free->va_end = vmap_end;
+
+			insert_vmap_area_augment(free, NULL,
+				&free_vmap_area_root,
+					&free_vmap_area_list);
+		}
+	}
+}
+
 void __init vmalloc_init(void)
 {
 	struct vmap_area *va;
-- 
2.30.2

