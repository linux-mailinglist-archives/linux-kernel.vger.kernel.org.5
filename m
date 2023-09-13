Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34D679E55C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjIMKyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbjIMKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:54:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FB219AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:54:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-403012f27e3so48670505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694602448; x=1695207248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz27K9YR9w0fQiJ9Te2x4N9NzQgI00KGt4T8XMBUFg0=;
        b=WGUJTz8QsszW4Ja7bgpbpod/cBjlUmhVC/9bvnphWkbZPo58rm5UqL9+Tzdy7A+o+G
         /gRcr87LqxhSEFyxAqf2Fq7lDOzhw/ESxcsrA0xepVDhXnATFm+daRd/d7rNTiFJ1Wq2
         FgmvFQ6xSnYBlJqFa3gH5Jm+hQ266Kyhw3vIjAX7OvEX1A0Nli/f9SWkVM7ux0jhEhma
         2cwJs9lod8+MBxNBCBSzdiTYI4AIxLjPN/w96DRoC3yPcWl4HynzNyesxLaYGEgl64lX
         +6j7aS3CuShMFNZRktEGET6U3KslQGuAP1SvSAXTG+8IdarAqQPhpECFOoqDE0WswMXp
         PMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602448; x=1695207248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz27K9YR9w0fQiJ9Te2x4N9NzQgI00KGt4T8XMBUFg0=;
        b=FhhvYOJUtNQUJmJbITG8citJY4Dc+SeNEyJH7N2LVc2k4gFQcy4W350i6VRt4GNITs
         cDCoH28wEbe1wWWxzBDpakweCx+oGXfqQS45ZjUedgjqFg/oXZOonsKEcY0+TRn3yZSM
         36yA0U2hljQpkn1UYxee+zYQjRp5JuJQvFvmEC/fWyz5BZAYnMCzQ3EwUBKrQjr5UPuG
         tc3qxyauYbeGAZhL7IO5e9PBQC2dzjCYMMhMUDl62xmM8IskjiO5kTkBBXVzJyAf+GhE
         +1gg02u5VhnI04YiPrnAtjrhHXvDlE0AG1yRIcwP98PtM6s6jy3IbsWy6/5ubF1286Rj
         fO1w==
X-Gm-Message-State: AOJu0YyraDptqzo4aRe4KjbcyBCz6EU4qYxNjO+ysniJ/oafcLyDEUzX
        /V3XwcmyfuMCqwxvjVbWnyO9xw==
X-Google-Smtp-Source: AGHT+IELq4IpOoGAAOVl1ZdlRYGeDT1zMvMdNhwEFXBsF/9A4wBjX2ebeHr30qj0D/lpVvMZsIc+Jw==
X-Received: by 2002:a05:600c:ac5:b0:401:d803:624f with SMTP id c5-20020a05600c0ac500b00401d803624fmr1620823wmr.4.1694602448422;
        Wed, 13 Sep 2023 03:54:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:59d5:28b9:7f13:cd1b])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b003ff013a4fd9sm1757055wms.7.2023.09.13.03.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 03:54:07 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v5 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT flag
Date:   Wed, 13 Sep 2023 11:54:00 +0100
Message-Id: <20230913105401.519709-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913105401.519709-1-usama.arif@bytedance.com>
References: <20230913105401.519709-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For reserved memory regions marked with this flag,
reserve_bootmem_region is not called during memmap_init_reserved_pages.
This can be used to avoid struct page initialization for
regions which won't need them, for e.g. hugepages with
Hugepage Vmemmap Optimization enabled.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Acked-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 1c1072e3ca06..ae3bde302f70 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -40,6 +40,8 @@ extern unsigned long long max_possible_pfn;
  * via a driver, and never indicated in the firmware-provided memory map as
  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
  * kernel resource tree.
+ * @MEMBLOCK_RSRV_NOINIT: memory region for which struct pages are
+ * not initialized (only for reserved regions).
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -47,6 +49,7 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
 };
 
 /**
@@ -125,6 +128,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
@@ -259,6 +263,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
+static inline bool memblock_is_reserved_noinit(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_RSRV_NOINIT;
+}
+
 static inline bool memblock_is_driver_managed(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
diff --git a/mm/memblock.c b/mm/memblock.c
index a49efbaee7e0..8f7a0cb668d4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -996,6 +996,24 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
 }
 
+/**
+ * memblock_reserved_mark_noinit - Mark a reserved memory region with flag
+ * MEMBLOCK_RSRV_NOINIT which results in the struct pages not being initialized
+ * for this region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * struct pages will not be initialized for reserved memory regions marked with
+ * %MEMBLOCK_RSRV_NOINIT.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.reserved, base, size, 1,
+				    MEMBLOCK_RSRV_NOINIT);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2112,13 +2130,18 @@ static void __init memmap_init_reserved_pages(void)
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
+		if (!memblock_is_reserved_noinit(region)) {
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

