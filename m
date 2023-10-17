Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373667CBD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjJQIbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjJQIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:31:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3787E8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:31:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c88b467ef8so36882235ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697531507; x=1698136307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbcbAmOCv2GaogANlUUkIacNzCiiquB3TlI/GPI0gBs=;
        b=Yv9JaThm3joPTEDAryrZ/hwoONT8u7aIoNXmWCI7JOdQSAiMTAZwMsm196nJgSmPeZ
         Taf3Of13iHT7eV1IJnmqbY7Zr7s2qzIwvRWMF8du0QKHJSGoKFMaimBz9uu2jiQFCNPf
         SRfrrgvNWQAW3pTMsYfUz/WRKstBwVBxrtAKqKnstE2hk/MyVLYSNntSmz1VR0P6Q1h2
         ry+LFqvh69kWevAFcsSwvQgYeOQcml7LXLSPW+ycPiR0/4vr91bjDv1GN/UVaYtXfPP2
         zTzLx16efS2AbZGHeHl/RtpzzdzXKIyFxnOAcMvMu9SfYDl1rrvIv3urZ9xPXeucbI21
         GnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531507; x=1698136307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbcbAmOCv2GaogANlUUkIacNzCiiquB3TlI/GPI0gBs=;
        b=eTmHYZimp2cXsC2FeafPGlqxmIcWChzZylkpf4ob9bKl+aWE9F2QYIp2ElCd9E/Z9M
         n2jeZQjZyF36E5MhIHQ6cUrzP8xKyYzbyPTj2a904l1ZMdHoW2sHyrlfSe2qdQku9+K0
         R+ijzosB+6QMnJSh4W+huDuEv/YkuDUuOEZr2NLTV/qBOgyQ4qT+EwwEImM24wvjL9nE
         Sr5XAsMj0L09cSIYAm5yE/EqT/SEXck8ZwbXHzG6T+WUVx2jjU91tzIPuJ+X0boSee9L
         TxFzt2/hBUfmVPfs1yiF4PO6X19AJCs0+bP22zKJS3eDfNRY7EIE9+Ym+D8wBkIqlkFK
         7VvQ==
X-Gm-Message-State: AOJu0YzaQD7yD9onIZgVJl5/saggvhHVri/IntkRqouTRi/Fsq/FODJC
        R9DH14Dh35yv9jV55rdAdZMkGGn6hYQtIIGO
X-Google-Smtp-Source: AGHT+IEHlMnIQEbxWQLv6YjjNM5FsNxG9ZmE7/HIc2N7h4xzHEPy4DzECahLVTHTwFwqZjk3lkNLrA==
X-Received: by 2002:a17:902:c712:b0:1ca:7af1:8a85 with SMTP id p18-20020a170902c71200b001ca7af18a85mr1286971plp.57.1697531507232;
        Tue, 17 Oct 2023 01:31:47 -0700 (PDT)
Received: from aa-PC.zhaoxin.com ([180.169.121.82])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001c9d235b3a0sm924017plk.7.2023.10.17.01.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:31:46 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, rppt@kernel.org
Cc:     chenhuacai@kernel.org, kernel@xen0n.name,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, maobibo@loongson.cn,
        chenfeiyang@loongson.cn, zhiguangni01@gmail.com,
        zhoubinbin@loongson.cn
Subject: [PATCH V5] NUMA: optimize detection of memory with no node id assigned by firmware
Date:   Tue, 17 Oct 2023 16:30:33 +0800
Message-Id: <20231017083033.118643-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index cb00804826f7..fca94d16be34 100644
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
+	if (memblock_validate_numa_coverage(SZ_1M >> 12) == false)
 		return -EINVAL;
 
 	for_each_node_mask(node, node_possible_map) {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..95376e7c263e 100644
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
+	if (!memblock_validate_numa_coverage(SZ_1M >> 12))
 		return -EINVAL;
 
 	/* Finally register nodes. */
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 1c1072e3ca06..727242f4b54a 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -120,6 +120,7 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 void memblock_trim_memory(phys_addr_t align);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
+bool memblock_validate_numa_coverage(const u64 threshold_pages);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 0863222af4a4..4f1f2d8a8119 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -734,6 +734,40 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
 }
 
+/**
+ * memblock_validate_numa_coverage - calculating memory with no node id assigned by firmware
+ * @threshold_pages: threshold memory of no node id assigned
+ *
+ * calculating memory with no node id assigned by firmware,
+ * If the number is less than the @threshold_pages, it returns true,
+ * otherwise it returns false.
+ *
+ * Return:
+ * true on success, false on failure.
+ */
+bool __init_memblock memblock_validate_numa_coverage(const u64 threshold_pages)
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
+	if (nr_pages >= threshold_pages) {
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

