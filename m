Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE175F8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGXNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjGXNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:49:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA991BD8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso34268115e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690206411; x=1690811211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4pGELgjvEXBJuRM+kyS6zBxvRB1Y0OOMkMsDX033Vw=;
        b=U9TJoPZM8Vb+e/+TDxZOJ/G64+DOvXK8duWaCY98EJ9LR85s7Ir6jydu8BZa479KxZ
         jRykc91Lr65/WdO14wqIbrmESX+QVJSfPKmbkz08W6PegHJYRKhZsHYX5/ZeohmFO5I6
         ROm+xlqvOa/+KqvRaMncQyPQY2le2+8HqRa+EVD/36i0+8/kad2mKe6z940vhrF7rJAO
         MA+rdL862CQeWZy+wv9ZnuKLEUaUrm6Ho1ie1q6HfyD0bJpWH4Cwb1xB+e3/cLjPXN9C
         v8pFji+l0xoy/MHWdK9ePxYNKHToDuhq5eys6H6aN5bmin9SIzYcVj3G2fhYuOBSlPSk
         kY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206411; x=1690811211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4pGELgjvEXBJuRM+kyS6zBxvRB1Y0OOMkMsDX033Vw=;
        b=keKkqPfnskHUYymN/Qw3p+uXYNwNhkabm1tSoPmCi3PSLpqQhWQaJCppKzQh6qZCp4
         xo3ITe5nhKQnQyjnt4zDJ88qtcCYx2utMw+I6kXI6YDKoIesuzwP7FQiZnze3VnJHY6o
         7jjbmiKMPZ90BNwCsBcMRX5YBRPKftHtctUeQIrESYLFUgmR6sEsgy+ef5wn2tUt/5Vv
         y5EBc/Rc1eVZnYVZRJikj6an+drbMnVmQnZckG1W34OaxLHu/CV3d5yUl9HlC+AQ3FSM
         qFsTdayJwNfIOh5lI+KSAeT2Fve7DqM7QnZYSaSEFM/q3EJvvBf8Vj60uY8ki3DocJIc
         DRQQ==
X-Gm-Message-State: ABy/qLbCbo/XemkDQNmub3SA+O74ShCyCAaTV1h/8zC94g2DFbMObrTz
        p8zA/QY0V2IfHyk3Bi9WPUPT+Db7pjvTTJf0BMg=
X-Google-Smtp-Source: APBJJlGC9ngrxmvPhoLL2+ZVdDO/kVFluie5EE/bs+tXQXKrVPr0EB5rctNwlrUxp2EATgtzWXfzgg==
X-Received: by 2002:a1c:7703:0:b0:3fa:d160:fc6d with SMTP id t3-20020a1c7703000000b003fad160fc6dmr6581149wmi.30.1690206411484;
        Mon, 24 Jul 2023 06:46:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:d7c4:7f46:8fed:f874])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbe791a0e8sm10209354wme.0.2023.07.24.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:46:50 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [RFC 4/4] mm/memblock: Skip initialization of struct pages freed later by HVO
Date:   Mon, 24 Jul 2023 14:46:44 +0100
Message-Id: <20230724134644.1299963-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724134644.1299963-1-usama.arif@bytedance.com>
References: <20230724134644.1299963-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the region is for hugepages and if HVO is enabled, then those
struct pages which will be freed later don't need to be initialized.
This can save significant time when a large number of hugepages are
allocated at boot time. As memmap_init_reserved_pages is only called at
boot time, we don't need to worry about memory hotplug.

Hugepage regions are kept separate from non hugepage regions in
memblock_merge_regions so that initialization for unused struct pages
can be skipped for the entire region.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb_vmemmap.c |  2 +-
 mm/hugetlb_vmemmap.h |  3 +++
 mm/memblock.c        | 27 ++++++++++++++++++++++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index bdf750a4786b..b5b7834e0f42 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -443,7 +443,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 DEFINE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
-static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
+bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
 /**
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 3525c514c061..8b9a1563f7b9 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -58,4 +58,7 @@ static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 	return hugetlb_vmemmap_optimizable_size(h) != 0;
 }
 bool vmemmap_should_optimize(const struct hstate *h, const struct page *head);
+
+extern bool vmemmap_optimize_enabled;
+
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index e92d437bcb51..62072a0226de 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 
 #include "internal.h"
+#include "hugetlb_vmemmap.h"
 
 #define INIT_MEMBLOCK_REGIONS			128
 #define INIT_PHYSMEM_REGIONS			4
@@ -519,7 +520,8 @@ static void __init_memblock memblock_merge_regions(struct memblock_type *type,
 		if (this->base + this->size != next->base ||
 		    memblock_get_region_node(this) !=
 		    memblock_get_region_node(next) ||
-		    this->flags != next->flags) {
+		    this->flags != next->flags ||
+		    this->hugepage_size != next->hugepage_size) {
 			BUG_ON(this->base + this->size > next->base);
 			i++;
 			continue;
@@ -2125,10 +2127,25 @@ static void __init memmap_init_reserved_pages(void)
 	/* initialize struct pages for the reserved regions */
 	for_each_reserved_mem_region(region) {
 		nid = memblock_get_region_node(region);
-		start = region->base;
-		end = start + region->size;
-
-		reserve_bootmem_region(start, end, nid);
+		/*
+		 * If the region is for hugepages and if HVO is enabled, then those
+		 * struct pages which will be freed later don't need to be initialized.
+		 * This can save significant time when a large number of hugepages are
+		 * allocated at boot time. As this is at boot time, we don't need to
+		 * worry about memory hotplug.
+		 */
+		if (region->hugepage_size && vmemmap_optimize_enabled) {
+			for (start = region->base;
+			    start < region->base + region->size;
+			    start += region->hugepage_size) {
+				end = start + HUGETLB_VMEMMAP_RESERVE_SIZE * sizeof(struct page);
+				reserve_bootmem_region(start, end, nid);
+			}
+		} else {
+			start = region->base;
+			end = start + region->size;
+			reserve_bootmem_region(start, end, nid);
+		}
 	}
 }
 
-- 
2.25.1

