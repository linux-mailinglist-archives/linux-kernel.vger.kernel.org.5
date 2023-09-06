Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F22793B2E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbjIFL2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbjIFL2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:28:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D19F199C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:26:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401ec23be82so36702505e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693999576; x=1694604376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ+4wrvPpGZ5a1nklWsXWLvy3+iTY75RmIyUz7pfkEI=;
        b=hg+HWA6x7AUaGc7r9e+u+i8RJ0/TYgJhXY7d9ySaCeUxU3YRWAy3hi70H3etEjdgcH
         6vK4UE2wg9/HejvqWWUcFEY5VxQxt+th8uM/OclYJzfZxQ6w8M2cLuf52PJY2poeKTbx
         fy9HmJ1W6iHFRe/1izQAx/R7W2QhEVENfmDT58kUCSh9xzLXrVaXUyYXpWF3huNWeT31
         hc8pwYFoVKwzYeELYdEFoezwDon1oJbEuhU95yNEezenv/FFj3lFrT3xeIN/7KevrMQf
         rZPkKzgR/2nyU3T6NXK6oBR1xN+dj5kDM/1KMFQw9y3pCuJZeZL83e5N7cfmkqyD6Eck
         JeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999576; x=1694604376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ+4wrvPpGZ5a1nklWsXWLvy3+iTY75RmIyUz7pfkEI=;
        b=cz64ZgD60SgaL0pQU5LJOK2D8QNhd6CSUoFly6Or1Sn5iXNxKjFvXZEPPY6fDsSHQZ
         BWI29j5xriOdd2o4hGWrPkNdSsp/ph2HmSO+otEUxxFk/60VrsbXL8fWLSX5Lss0ULVA
         21YCtKDAfQ5uKancYOFYCIesaATDxEm3zX3K2/+9nykqglFFAot4WoSbSVZ/L9i4ZWiA
         kCespiV9xVJ0a1RHDn4bcN72FdPCppD86LFSmM7YAxi+uRT4a4bwK6vTyrbIldizRCxC
         aj74lQQqYVDlM+YB9XnxZ5ZvDD8CK91HJLRUG8L9IUfeRyjfg+kV5xu1Vy1waf1+Kr6+
         9OZA==
X-Gm-Message-State: AOJu0YzTgZz2YkHxNWJfvw8SQbtYHC0+WB2Sf3xEYZlVeV+l/a0+hWhn
        /jorjl0qfUo1nqNKPIC9JMkAUw==
X-Google-Smtp-Source: AGHT+IFKTigEzECohyKXcbSiG234lo0AYUo/LW5o7o0IXxyKMwkwe7Dz6DDQAswIExRg7WA4d/Alpg==
X-Received: by 2002:a05:600c:ada:b0:3f9:b8df:26ae with SMTP id c26-20020a05600c0ada00b003f9b8df26aemr1895949wmr.34.1693999576050;
        Wed, 06 Sep 2023 04:26:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:6dce:31d8:efb1:5d81])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003feff926fc5sm19517038wmd.17.2023.09.06.04.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:26:15 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v4 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT flag
Date:   Wed,  6 Sep 2023 12:26:04 +0100
Message-Id: <20230906112605.2286994-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906112605.2286994-1-usama.arif@bytedance.com>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

