Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E934276862C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjG3PQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjG3PQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:16:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A54171A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so2025485e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690730173; x=1691334973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRlgK3gsc81CRpAMRRPsywIlI5j9OUiW8IxZjNa20o0=;
        b=W/lVFu8oBYOHaQON2+IUAE4OeTID9l1Wz5BLxJdEu8LJBB9z/KErJPNGKn4gPKcqET
         TOz183J9eC9oj+adoUW1wOIA2x17GqKNs+kATE99/ZRY8Fjp8O5VirlHjPixUUm43ku4
         z+wT3z1JbZFobFUIlYBs/gN3XFoPKT2xOzlfLL6MoMgEtn/SiRo+2YI4xg86K/JhVl3i
         MuhecVQM9cEuPwUzqT4PGXvn5nnp3Ror/whrcq0G86C37cVp/BcEGPKbi/b5/niap3Zq
         DtL+erRe6APzX6GQNORLFAEQj9gidto4zepL9icunXIYosg8Xv4r0ivr6Y0+U81B8I1M
         t8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690730173; x=1691334973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRlgK3gsc81CRpAMRRPsywIlI5j9OUiW8IxZjNa20o0=;
        b=YZ3KGxN0H8XlPhQWdPsNzjiPZEJQntgotTMelPIicrugNOD/xy5FzjAwbMCMohbOnT
         MU4GhI+WjCvJJrn5Ig3sTLnoylcdGB6inONai6y+uHAYOOxXs9gjCfN/0lT5sMcZPbTm
         A0jnaOrm248kwuMPthVEK5DRwfWqKNS6WJdPtv1Lf5WiS5NdAzWlE0yZ3NFkEG1HeFnt
         ML7GRs19ORDhLmK22TSigItHLPiV/SmXGHLxl07AjieVhRxLomR7vB5kl1DG2DPpvi9G
         7yqEPYcrnpOro+w5KmTWRju+1dQUmZdlt1z5UcEkYDzl+uwanupD3Wrn+Icg0IFqfC0G
         Ku3g==
X-Gm-Message-State: ABy/qLbvk6sCB0Rof9wXWm+4Yk7oNos8J6amGuYvI1idkCPNB+n9xPbk
        RhPscleu2TXuHL1HeuT6NXZe35/+l3W6viI/nNw=
X-Google-Smtp-Source: APBJJlFzVJI2UxHIjpRrxyZbsv8rAC3x9G9eCF0qIIb2iLIkSv48sgus3BhU4mIBADGNAt8oxdN7wQ==
X-Received: by 2002:a05:600c:2809:b0:3fa:9767:c816 with SMTP id m9-20020a05600c280900b003fa9767c816mr5021376wmb.39.1690730173023;
        Sun, 30 Jul 2023 08:16:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:eda5:aa63:ce24:dac2])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcc11000000b003fd2d33ea53sm9123027wmh.14.2023.07.30.08.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 08:16:12 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v2 4/6] memblock: introduce MEMBLOCK_RSRV_NOINIT flag
Date:   Sun, 30 Jul 2023 16:16:04 +0100
Message-Id: <20230730151606.2871391-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730151606.2871391-1-usama.arif@bytedance.com>
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
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
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 30 +++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f71ff9f0ec81..de7760aeb870 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -40,6 +40,8 @@ extern unsigned long long max_possible_pfn;
  * via a driver, and never indicated in the firmware-provided memory map as
  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
  * kernel resource tree.
+ * @MEMBLOCK_RSRV_NOINIT: memory region for which struct pages are not initialized
+ * (only for reserved regions).
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
 
+static inline bool memblock_is_noinit(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_RSRV_NOINIT;
+}
+
 static inline bool memblock_is_driver_managed(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
diff --git a/mm/memblock.c b/mm/memblock.c
index 43cb4404d94c..40690ce0b06e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -991,6 +991,21 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
 }
 
+/**
+ * memblock_reserved_mark_noinit - Mark a reserved memory region with flag MEMBLOCK_RSRV_NOINIT.
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
+	return memblock_setclr_flag(&memblock.reserved, base, size, 1, MEMBLOCK_RSRV_NOINIT);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2107,13 +2122,18 @@ static void __init memmap_init_reserved_pages(void)
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
+		if (!memblock_is_noinit(region)) {
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

