Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF327788580
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjHYLT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjHYLSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:18:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9211FCB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-319559fd67dso685955f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692962331; x=1693567131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt7VA+fn11wPN2WZOsDR2kSrdsBwWADUH8ZcQSjaiPs=;
        b=EsMNC1tzWSxQdc599l5SHDEEa98rqlp7iDryuFhBYk8fHJ511NFQyTznh0mCDBUIn8
         VL8K3tloTbGtKUrcH4jjAAsVmaUTZ2RNBUAs8YhCr5NG+vVevNZdq3uQ1G1uBY6LhJVF
         rTwmWgEz1MvQA9fuhdFC9bXz4LoNfymZjqSABGUPV23JzQFZnk9thziUhDk9YadzQzpK
         0Y4SguwVDubIC/esFXv70EfncJva9GyavT5l0kJrs+9ZjMhqgofSo0kMiSVl8P6uaV89
         V29hVlv/XbysBximjie5EPo24O7osCBf+oDoT7rAPNGdseqXFPTWzYczRyNlM8M7odR8
         9gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962331; x=1693567131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt7VA+fn11wPN2WZOsDR2kSrdsBwWADUH8ZcQSjaiPs=;
        b=M6flj4A8x/w8NgVcGLECzTLyw71Y4f3hkSW/cn6raUIJR2t0LPtA4cbFq8m1FQmT1q
         LG1A2AySW3pWnVwrr5YKpGOCIksJNda9/fi3uw9506OfmFm/8FPMMt5O3V8SQPZp9t5R
         EtRTIvpt6BAvSjo043/BWONnxI4KsDNr42tvvRTsYbZaQptY2acbcrHBW6kBqIIZ8hDS
         sCGOtGg4QlYygL3oLc8dSLlFUv9IJObeHfVdTqm3mFPRMsF17nL27FjUpDEO+8/+lQ61
         iistUbhiaE3chIHzQqXIKElPScuMKkclSYVFhFpMy4PP7L9CAZbNYLxW3P6R30uTzp3G
         hWrw==
X-Gm-Message-State: AOJu0Yyvzm1vLWO3qLiUjNVEZ45/e2risZgCElBFZHBd9CIwnqSe2YcP
        Do3llPiqASjUFT30m5mxydpezw==
X-Google-Smtp-Source: AGHT+IEec5EPpcaKObbex9bUWyp4GWlAmHPClDlt9NrVYi+5iTZNS2Jj3ebXr6R8Gt7v2gUbQKOW1A==
X-Received: by 2002:a5d:4403:0:b0:31a:d49a:38d with SMTP id z3-20020a5d4403000000b0031ad49a038dmr13545294wrq.54.1692962331003;
        Fri, 25 Aug 2023 04:18:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:9000:8d13:d0bb:ba7d])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm1939502wrx.58.2023.08.25.04.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:18:50 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v3 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT_VMEMMAP flag
Date:   Fri, 25 Aug 2023 12:18:35 +0100
Message-Id: <20230825111836.1715308-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825111836.1715308-1-usama.arif@bytedance.com>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For reserved memory regions marked with this flag,
reserve_bootmem_region is not called during memmap_init_reserved_pages.
This can be used to avoid struct page initialization for
regions which won't need them, for e.g. hugepages with
HVO enabled.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 include/linux/memblock.h | 10 ++++++++++
 mm/memblock.c            | 32 +++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f71ff9f0ec81..6d681d053880 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -40,6 +40,8 @@ extern unsigned long long max_possible_pfn;
  * via a driver, and never indicated in the firmware-provided memory map as
  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
  * kernel resource tree.
+ * @MEMBLOCK_RSRV_NOINIT_VMEMMAP: memory region for which struct pages are
+ * not initialized (only for reserved regions).
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -47,6 +49,8 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	/* don't initialize struct pages associated with this reserver memory block */
+	MEMBLOCK_RSRV_NOINIT_VMEMMAP	= 0x10,
 };
 
 /**
@@ -125,6 +129,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_reserved_mark_noinit_vmemmap(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
@@ -259,6 +264,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
+static inline bool memblock_is_noinit_vmemmap(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_RSRV_NOINIT_VMEMMAP;
+}
+
 static inline bool memblock_is_driver_managed(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
diff --git a/mm/memblock.c b/mm/memblock.c
index 43cb4404d94c..a9782228c840 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -991,6 +991,23 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
 }
 
+/**
+ * memblock_reserved_mark_noinit_vmemmap - Mark a reserved memory region with flag
+ * MEMBLOCK_RSRV_NOINIT_VMEMMAP.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * struct pages will not be initialized for reserved memory regions marked with
+ * %MEMBLOCK_RSRV_NOINIT_VMEMMAP.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_reserved_mark_noinit_vmemmap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.reserved, base, size, 1,
+				    MEMBLOCK_RSRV_NOINIT_VMEMMAP);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2107,13 +2124,18 @@ static void __init memmap_init_reserved_pages(void)
 		memblock_set_node(start, end, &memblock.reserved, nid);
 	}
 
-	/* initialize struct pages for the reserved regions */
+	/*
+	 * initialize struct pages for reserved regions that don't have
+	 * the MEMBLOCK_RSRV_NOINIT_VMEMMAP flag set
+	 */
 	for_each_reserved_mem_region(region) {
-		nid = memblock_get_region_node(region);
-		start = region->base;
-		end = start + region->size;
+		if (!memblock_is_noinit_vmemmap(region)) {
+			nid = memblock_get_region_node(region);
+			start = region->base;
+			end = start + region->size;
 
-		reserve_bootmem_region(start, end, nid);
+			reserve_bootmem_region(start, end, nid);
+		}
 	}
 }
 
-- 
2.25.1

