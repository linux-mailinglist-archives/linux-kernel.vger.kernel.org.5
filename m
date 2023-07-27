Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65514765D96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjG0UrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjG0UrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:47:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87852D45
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:36 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so21959931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690490795; x=1691095595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQe+LnlORYwelNDP2OagFjwF2/T/1IMvjhocyHCh0HM=;
        b=gVT8uA85Q/2RybadFL1WMGqwI8huoiPfSEh3Ga80yhJTkx2wqYddCczcvHucvrLvi3
         8LyY62f1ojKZNCIJ1RJJ6AJm/H/D5kfULuGeQgjkEhp/sdQz5z18I7dL/szLmlIfJpYD
         u61EVQdgSt8wbKxI6DB5hsAcwBuLB2hgvn0jrCvRww9Z0lGEXVNLysQBc2Fe36p46uCT
         jl2OXbNIY2R4lV5NY2Ex7WgCxOm/ALG64TE59hb/8mRc6i3LDTDk1ah1xfi+hOTG8MYd
         4LLgZYdnHkKk+A17Ls6+GXL7nzPHfRkZeRmwu0Uv3hqpWoCBuyANT80yrLWtGgfm1gge
         gtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490795; x=1691095595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQe+LnlORYwelNDP2OagFjwF2/T/1IMvjhocyHCh0HM=;
        b=fIwHg8/52HS2L+/h6TlO/UClI7myuMGNqms80m595MZbW/ka/rULtjlJm4N8KnXJ6m
         MhRGlKPptJGbH58GvKiXwHeggjCEFm95YAfcP9grwnmuc+c5qI6sYJgJhHqpa2cmRV0x
         l/5ZsxvA5tnDIuClAJOW54O1Ol2/Ry8ozTb+V5+J/SB+cJavogtQUv+vY0IQDCzcZZA/
         4+xfIMcAg7ABkXtU5i5bHG5psl5Ua+7d5syCXILErkGSPWnsPzfNDFIWPLJaWYQgsP1A
         KjdR1fr/KgwqdX6DnS0my2vIQDb6OFUCQ9hOhXxwFEXikMyPez0jcxDQZGqJ780RhOIB
         V28A==
X-Gm-Message-State: ABy/qLZe596ymFhynY4Aqp2Gw3heu6nQkznfmI9tmOT7B04RD0ji9BKv
        d49NuY0uYgUsPPhUCy1XZ6V6fw==
X-Google-Smtp-Source: APBJJlFfgB46RLeDSeeOkYepjrGae0ZQ1eLESbLa8jxhbH1/PX3Edir8uGhF64v2uGzIFXEGRina+Q==
X-Received: by 2002:a2e:3003:0:b0:2b5:974f:385 with SMTP id w3-20020a2e3003000000b002b5974f0385mr129660ljw.9.1690490795035;
        Thu, 27 Jul 2023 13:46:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc401000000b003fc06169abdsm2701400wmi.2.2023.07.27.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:46:34 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v1 4/6] memblock: introduce MEMBLOCK_RSRV_NOINIT flag
Date:   Thu, 27 Jul 2023 21:46:22 +0100
Message-Id: <20230727204624.1942372-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727204624.1942372-1-usama.arif@bytedance.com>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/memblock.h |  7 +++++++
 mm/memblock.c            | 32 ++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f71ff9f0ec81..7f9d06c08592 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -47,6 +47,7 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't call reserve_bootmem_region for this region */
 };
 
 /**
@@ -125,6 +126,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_rsrv_mark_noinit(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
@@ -259,6 +261,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
+static inline bool memblock_is_noinit(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_RSRV_NOINIT;
+}
+
 static inline bool memblock_is_driver_managed(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
diff --git a/mm/memblock.c b/mm/memblock.c
index 4fd431d16ef2..3a15708af3b6 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -997,6 +997,22 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP, 0);
 }
 
+/**
+ * memblock_rsrv_mark_noinit - Mark a reserved memory region with flag MEMBLOCK_RSRV_NOINIT.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * For memory regions marked with %MEMBLOCK_RSRV_NOINIT, reserve_bootmem_region
+ * is not called during memmap_init_reserved_pages, hence struct pages are not
+ * initialized for this region.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_rsrv_mark_noinit(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_RSRV_NOINIT, 1);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2113,13 +2129,17 @@ static void __init memmap_init_reserved_pages(void)
 		memblock_set_node(start, end, &memblock.reserved, nid);
 	}
 
-	/* initialize struct pages for the reserved regions */
+	/*
+	 * initialize struct pages for reserved regions that don't have
+	 * the MEMBLOCK_RSRV_NOINIT flag set
+	 */
 	for_each_reserved_mem_region(region) {
-		nid = memblock_get_region_node(region);
-		start = region->base;
-		end = start + region->size;
-
-		reserve_bootmem_region(start, end, nid);
+		if (!memblock_is_noinit(region)) {
+			nid = memblock_get_region_node(region);
+			start = region->base;
+			end = start + region->size;
+			reserve_bootmem_region(start, end, nid);
+		}
 	}
 }
 
-- 
2.25.1

