Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E456A79ADB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjIKUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjIKNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:39:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA88CC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:39:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-570836f1c79so3105235a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694439544; x=1695044344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzjWWSPat2JgzSDnNcTFgX4QJsPLKM/SCLEwhPsOghY=;
        b=Isg+TPirVyWMTpcQTAfXXmt1HRxb2HDYuUDvW8+7EY7dlUUG2iu9oExSMqg6rhuDUP
         LffvaEKglPmov46522x4910NVaRvrXQA3koGbqUqVRwOuOHEYRyWHyrKIxKkp/4jb8RQ
         C/asoWQ1ZNJdsaE8wZ01NquJZr+afpInSOxKduWw7CvRPJSFpZQYmpjiWpILTM0oIYw8
         lHqPqFQe/ghM7IEnhR+ZNcHW4mevy25l1MeqOfCh6QeG8TN4CEADXSH5m96HaKBNU4iq
         +MKGRYpsE9ScofefHBVQl6zOuCczmRKsZmGQF0MaBMDpFb3vUf11dOL/3AGSKuY1QR7x
         Yxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439544; x=1695044344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzjWWSPat2JgzSDnNcTFgX4QJsPLKM/SCLEwhPsOghY=;
        b=qfFhs9Eu9HHKkwwoqSepbNx8WB9zh2ulyEdLsjj8Hz/ix5aF685UpCIO4cHH654WHf
         NRO7z1MCABV8kBsebVFb+1Zr0+xLsTVktYuddYyObbu/suLR1DhO8Dx3UXG7Xj2M5WaF
         UmFiBnh3u/+ZwmKoQHoju+jSt2LJm/PF7GIasZDFttdd2IJW8QnJJx1iSUEKKXhoTbuN
         LB1dxmmtpaqc6pQrgLALny02Ws0bv8oPL4xeqODhyjg/2kzRNqFF5edNnlXvr5zU+fGj
         7apPoWjzM9V8Hu5Vwv3uUq0sUFZMMg9a/IjfqJ0LzFtVQO1ln/w66mwLqrSZQirgQ57D
         CThg==
X-Gm-Message-State: AOJu0YyNlR8z8S0wOp7tUz0ayppM+s4h/zugQMhPOsaPzpUaTDBdsAR3
        TQO7nFzwG4qs+bk4ftcrnXZVYGWcTkZW7Q==
X-Google-Smtp-Source: AGHT+IH8HWLxoNkhA8I8mAWSHBs8jufPtqLVvAu/k6LkGMx57d5cT/PNbs9sTc0ZdSx9AHJg7UZbCw==
X-Received: by 2002:a05:6a20:3c9f:b0:153:4ea6:d127 with SMTP id b31-20020a056a203c9f00b001534ea6d127mr9849451pzj.18.1694439544396;
        Mon, 11 Sep 2023 06:39:04 -0700 (PDT)
Received: from localhost ([58.37.145.245])
        by smtp.gmail.com with ESMTPSA id m26-20020a63941a000000b0056ae1af610asm5475157pge.58.2023.09.11.06.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:39:03 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, rppt@kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org,
        Liam Ni <zhiguangni01@gmail.com>
Subject: [PATCH V4] NUMA:Improve the efficiency of calculating pages loss
Date:   Mon, 11 Sep 2023 21:38:52 +0800
Message-Id: <20230911133852.2545-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize the way of calculating missing pages.

In the previous implementation, We calculate missing pages as follows:
1. calculate numaram by traverse all the numa_meminfo's and for each of
them traverse all the regions in memblock.memory to prepare for
counting missing pages.

2. Traverse all the regions in memblock.memory again to get e820ram.

3. the missing page is (e820ram - numaram )

But,it's enough to count memory in ‘memblock.memory’ that doesn't have
the node assigned.

V3:https://lore.kernel.org/all/CACZJ9cUXiWxDb6hF4JFhWe7Np82k6LopVQ+_AoGFOccN4kjJqA@mail.gmail.com/#r
V2:https://lore.kernel.org/all/20230619075315.49114-1-zhiguangni01@gmail.com/
V1:https://lore.kernel.org/all/20230615142016.419570-1-zhiguangni01@gmail.com/

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 arch/x86/mm/numa.c       | 33 +--------------------------------
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..ee5f08adfaf6 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -447,37 +447,6 @@ int __node_distance(int from, int to)
 }
 EXPORT_SYMBOL(__node_distance);
 
-/*
- * Sanity check to catch more bad NUMA configurations (they are amazingly
- * common).  Make sure the nodes cover all memory.
- */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
-{
-	u64 numaram, e820ram;
-	int i;
-
-	numaram = 0;
-	for (i = 0; i < mi->nr_blks; i++) {
-		u64 s = mi->blk[i].start >> PAGE_SHIFT;
-		u64 e = mi->blk[i].end >> PAGE_SHIFT;
-		numaram += e - s;
-		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
-		if ((s64)numaram < 0)
-			numaram = 0;
-	}
-
-	e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
-
-	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
-	if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
-		printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %LuMB e820 RAM. Not used.\n",
-		       (numaram << PAGE_SHIFT) >> 20,
-		       (e820ram << PAGE_SHIFT) >> 20);
-		return false;
-	}
-	return true;
-}
-
 /*
  * Mark all currently memblock-reserved physical memory (which covers the
  * kernel's own memory ranges) as hot-unswappable.
@@ -583,7 +552,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			return -EINVAL;
 		}
 	}
-	if (!numa_meminfo_cover_memory(mi))
+	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
 
 	/* Finally register nodes. */
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 1c1072e3ca06..0c3a193ebc58 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -120,6 +120,7 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 void memblock_trim_memory(phys_addr_t align);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
+bool memblock_validate_numa_coverage(const u64 limit);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 0863222af4a4..8f61f868bec1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -734,6 +734,27 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
 }
 
+bool __init_memblock memblock_validate_numa_coverage(const u64 limit)
+{
+	unsigned long lose_pg = 0;
+	unsigned long start_pfn, end_pfn;
+	int nid, i;
+
+	/* calculate lose page */
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		if (nid == NUMA_NO_NODE)
+			lose_pg += end_pfn - start_pfn;
+	}
+
+	if (lose_pg >= limit) {
+		pr_err("NUMA: We lost %ld pages.\n", lose_pg);
+		return false;
+	}
+
+	return true;
+}
+
+
 /**
  * memblock_isolate_range - isolate given range into disjoint memblocks
  * @type: memblock type to isolate range for
-- 
2.25.1

