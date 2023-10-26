Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5807D7A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjJZCDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZCDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:03:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A3128
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:03:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso279590a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698285819; x=1698890619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5Aqv6dlA0H+Btg56Nn64Q5cxiHM9wUKXyXUnjiSU3A=;
        b=jyVA6I24LeEVyzWVpHpEbpCP6q9MFJAcfZK4zoPk+/uclpXj1xNV86Wfgm23icU1CA
         UYdWX0fzKQXthl3TxtPQpqh98OnmUbmE9wT92XQf0u0ZJt2Yft4R8bmvdj+JgtEUuNXi
         7N6Y9M6DTV/5b3GaIbrRkuLkm1XCIOMXAHQ8Mft11LhIzZRhosNxuYTOlG0zMDRu/yi1
         0SFmlmvefKRmgCvbvq2nzbXEj9ZAVYBFmAqxDghd3BhOu1vztDH+8XpJN7wbX8IbhA/7
         T2yLHy6u929wcp0RjlrHYu5tNvswLk+d5wdejBE+/qKdvRMt251aM97w2PIdeof26PiI
         DLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698285819; x=1698890619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5Aqv6dlA0H+Btg56Nn64Q5cxiHM9wUKXyXUnjiSU3A=;
        b=ho6N4dobFUuK1ODj1Itm4I/HkPHe0jpkRxcnRbNbx/ZZJpfJcsmn8k9ZTHoWy0L9Px
         QDKOeZmNunEXZOguMrVvPtDWL3UbScOn8p/L1DaSVjbb0Dtmv3VcBmydKTwBQDS3IoX4
         PHm6NEqj9u45jlsiU/FmmwOUM8qBu2XlP90YEEcs+7mss93mKnPv0dm+Jla7L25RvtDz
         mcjZsZsgXOw6JReNr+N/U696BwcdTgexJVat3pKLjQOnhVM8laVhs1Om18Q4AVlVXiqf
         bM4LoosIxD+NxqwhQzNTCtGSC0iqCyZfjO3Hvsp5cTvBC6YiY5QaogdS8PS1tnIYh0lA
         M8xA==
X-Gm-Message-State: AOJu0YwI9Txeqj8knphCLmONy1SWjLaXaY+YD23pfcolFHCJNQNGJvwQ
        r5tzYdN/5iqJC0WNxqv8Fyg=
X-Google-Smtp-Source: AGHT+IHtZOR273U91ceyKReQ/5kBhO+DzSBKVAs+uLU758ZOC3HkSK5KXuOScCLjzVRRYYvpCqf6LQ==
X-Received: by 2002:a17:90b:4a4e:b0:27c:f9e7:30fd with SMTP id lb14-20020a17090b4a4e00b0027cf9e730fdmr13993763pjb.7.1698285818787;
        Wed, 25 Oct 2023 19:03:38 -0700 (PDT)
Received: from localhost.localdomain ([180.169.121.82])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a1a1600b0027d0d4d4128sm597371pjk.25.2023.10.25.19.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 19:03:38 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, rppt@kernel.org
Cc:     chenhuacai@kernel.org, kernel@xen0n.name,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, maobibo@loongson.cn,
        chenfeiyang@loongson.cn, zhiguangni01@gmail.com,
        zhoubinbin@loongson.cn
Subject: [RESEND PATCH V7] NUMA: optimize detection of memory with no node id assigned by firmware
Date:   Thu, 26 Oct 2023 10:03:29 +0800
Message-Id: <20231026020329.327329-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Sanity check that makes sure the nodes cover all memory loops over
numa_meminfo to count the pages that have node id assigned by the firmware,
then loops again over memblock.memory to find the total amount of memory
and in the end checks that the difference between the total memory and
memory that covered by nodes is less than some threshold. Worse, the loop
over numa_meminfo calls __absent_pages_in_range() that also partially
traverses memblock.memory.

It's much simpler and more efficient to have a single traversal of
memblock.memory that verifies that amount of memory not covered by nodes is
less than a threshold.

Introduce memblock_validate_numa_coverage() that does exactly that and use
it instead of numa_meminfo_cover_memory().

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 arch/loongarch/kernel/numa.c | 28 +---------------------------
 arch/x86/mm/numa.c           | 34 ++--------------------------------
 include/linux/memblock.h     |  1 +
 mm/memblock.c                | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 59 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index cb00804826f7..0e69679bfc8d 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -226,32 +226,6 @@ static void __init node_mem_init(unsigned int node)
 
 #ifdef CONFIG_ACPI_NUMA
 
-/*
- * Sanity check to catch more bad NUMA configurations (they are amazingly
- * common).  Make sure the nodes cover all memory.
- */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
-{
-	int i;
-	u64 numaram, biosram;
-
-	numaram = 0;
-	for (i = 0; i < mi->nr_blks; i++) {
-		u64 s = mi->blk[i].start >> PAGE_SHIFT;
-		u64 e = mi->blk[i].end >> PAGE_SHIFT;
-
-		numaram += e - s;
-		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
-		if ((s64)numaram < 0)
-			numaram = 0;
-	}
-	max_pfn = max_low_pfn;
-	biosram = max_pfn - absent_pages_in_range(0, max_pfn);
-
-	BUG_ON((s64)(biosram - numaram) >= (1 << (20 - PAGE_SHIFT)));
-	return true;
-}
-
 static void __init add_node_intersection(u32 node, u64 start, u64 size, u32 type)
 {
 	static unsigned long num_physpages;
@@ -396,7 +370,7 @@ int __init init_numa_memory(void)
 		return -EINVAL;
 
 	init_node_memblock();
-	if (numa_meminfo_cover_memory(&numa_meminfo) == false)
+	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
 
 	for_each_node_mask(node, node_possible_map) {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..4079c9edaa93 100644
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
@@ -583,7 +552,8 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			return -EINVAL;
 		}
 	}
-	if (!numa_meminfo_cover_memory(mi))
+
+	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
 
 	/* Finally register nodes. */
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 1c1072e3ca06..a94efe977539 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -120,6 +120,7 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 void memblock_trim_memory(phys_addr_t align);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
+bool memblock_validate_numa_coverage(unsigned long threshold_bytes);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 0863222af4a4..397d61c4896a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -734,6 +734,40 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
 }
 
+/**
+ * memblock_validate_numa_coverage - check if amount of memory with
+ * no node ID assigned is less than a threshold
+ * @threshold_bytes: maximal number of pages that can have unassigned node
+ * ID (in bytes).
+ *
+ * A buggy firmware may report memory that does not belong to any node.
+ * Check if amount of such memory is below @threshold_bytes.
+ *
+ * Return: true on success, false on failure.
+ */
+bool __init_memblock memblock_validate_numa_coverage(unsigned long threshold_bytes)
+{
+	unsigned long nr_pages = 0;
+	unsigned long start_pfn, end_pfn, mem_size_mb;
+	int nid, i;
+
+	/* calculate lose page */
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		if (nid == NUMA_NO_NODE)
+			nr_pages += end_pfn - start_pfn;
+	}
+
+	if ((nr_pages << PAGE_SHIFT) >= threshold_bytes) {
+		mem_size_mb = memblock_phys_mem_size() >> 20;
+		pr_err("NUMA: no nodes coverage for %luMB of %luMB RAM\n",
+		       (nr_pages << PAGE_SHIFT) >> 20, mem_size_mb);
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

