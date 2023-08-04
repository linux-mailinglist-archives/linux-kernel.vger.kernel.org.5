Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC747704CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHDPdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjHDPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:33:02 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01614170F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:33:00 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583ae4818c8so23886847b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691163180; x=1691767980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sKylUnd028FWgrPUAFRbuJwa3rsNXsvhALZm8JlmZzo=;
        b=sxqgCNh5sE276naqOGqJHcebfYQ8vboPRS86BmXUC7kYD3qBpP+CGGjIq5Dnn+GvDq
         G7A9ppbmz8easrgHjdfF8V+wFi48ka/pCxPmRNKfW6V7KTtkAGEVxkHlQrATXGouX+0k
         XBfZtybtjF6pQ0jo+wFvOzmIPqd5mFzKBDh1Ghnq8T97KpJje32PxauWL3fTZ9ENHCpj
         SKU0dKqX3vZNCG5+9Zr/1YovSRQXdQVD4tdSYRH0oUiGvTI876e5SRp755QB/FIow8+R
         S68SOzPhqOwU+Y1Topp4IBxZW8m1IvnInXTLIqkOOE+YYDZkwWsERl01jlMgaF8gV+Iz
         4PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691163180; x=1691767980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKylUnd028FWgrPUAFRbuJwa3rsNXsvhALZm8JlmZzo=;
        b=Ezn36mHebRLs0akVjxapP7cMws9KL5FOC3IJjBmugacsP2gfr7c4xbIKaX+/LOk+Dl
         oPT24bYltXDx0KmpzJEuCePeXGjUai1UJ75YvWSiSTeSTw5wIBR3YKurXP0A8sztRIVW
         7CnZJbDyJ+2hEJ/BHA2i9wqND89hIhwDyGsUChBMjzVk06Gr8p7RvlhenSsgwc/TMvTx
         yNjQBnmdoe5CoLWGkqmJNQh0i/AXJWei34XSen4hmZJpKh3xOCvM8oTCSD9JyPeWX9av
         tzIgwQEkOjxc2e62QUIWi7AqD/FEMPqgG5fKEBwLrkN4acLdYQ+yYAYj9y7kpGBzc7p3
         eVCg==
X-Gm-Message-State: AOJu0YzNouXeEVhmNHzsqfyAyRqcruwd64l1cxyt1RRqS/FbpbpD70Lm
        o22VrB3JGtX1AaDSqIl8PAgvPmnXDqke3EF170U=
X-Google-Smtp-Source: AGHT+IFzPzk2F7C5QklwDvvG9e9z1pwQHIKHbBy+stPBPltppo8U31f7nZHZWJmSAfBJ4Is7IqIP7Tm/81Yq0DoC7kg=
X-Received: by 2002:a25:26c9:0:b0:d0d:786:2999 with SMTP id
 m192-20020a2526c9000000b00d0d07862999mr1878306ybm.29.1691163180075; Fri, 04
 Aug 2023 08:33:00 -0700 (PDT)
MIME-Version: 1.0
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Fri, 4 Aug 2023 23:32:51 +0800
Message-ID: <CACZJ9cUXiWxDb6hF4JFhWe7Np82k6LopVQ+_AoGFOccN4kjJqA@mail.gmail.com>
Subject: [RESEND PATCH V3] NUMA:Improve the efficiency of calculating pages loss
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Mike Rapoport <rppt@kernel.org>
Cc:     zhoubinbin@loongson.cn, chenfeiyang@loongson.cn,
        jiaxun.yang@flygoat.com, Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        luto@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        kernel@xen0n.name, chenhuacai@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

But,it's enough to count memory in =E2=80=98memblock.memory=E2=80=99 that d=
oesn't have
the node assigned.

V2:https://lore.kernel.org/all/20230619075315.49114-1-zhiguangni01@gmail.co=
m/
V1:https://lore.kernel.org/all/20230615142016.419570-1-zhiguangni01@gmail.c=
om/

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 arch/loongarch/kernel/numa.c | 23 ++++++++---------------
 arch/x86/mm/numa.c           | 26 +++++++-------------------
 include/linux/mm.h           |  1 +
 mm/mm_init.c                 | 20 ++++++++++++++++++++
 4 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 708665895b47..0239891e4d19 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -262,25 +262,18 @@ static void __init node_mem_init(unsigned int node)
  * Sanity check to catch more bad NUMA configurations (they are amazingly
  * common).  Make sure the nodes cover all memory.
  */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi=
)
+static bool __init memblock_validate_numa_coverage(const u64 limit)
 {
-       int i;
-       u64 numaram, biosram;
+       u64 lo_pg;

-       numaram =3D 0;
-       for (i =3D 0; i < mi->nr_blks; i++) {
-               u64 s =3D mi->blk[i].start >> PAGE_SHIFT;
-               u64 e =3D mi->blk[i].end >> PAGE_SHIFT;
+       lo_pg =3D max_pfn - calculate_without_node_pages_in_range();

-               numaram +=3D e - s;
-               numaram -=3D __absent_pages_in_range(mi->blk[i].nid, s, e);
-               if ((s64)numaram < 0)
-                       numaram =3D 0;
+       /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
+       if (lo_pg >=3D limit) {
+               pr_err("NUMA: We lost 1m size page.\n");
+               return false;
        }
-       max_pfn =3D max_low_pfn;
-       biosram =3D max_pfn - absent_pages_in_range(0, max_pfn);

-       BUG_ON((s64)(biosram - numaram) >=3D (1 << (20 - PAGE_SHIFT)));
        return true;
 }

@@ -428,7 +421,7 @@ int __init init_numa_memory(void)
                return -EINVAL;

        init_node_memblock();
-       if (numa_meminfo_cover_memory(&numa_meminfo) =3D=3D false)
+       if (memblock_validate_numa_coverage(SZ_1M) =3D=3D false)
                return -EINVAL;

        for_each_node_mask(node, node_possible_map) {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..14feec144675 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -451,30 +451,18 @@ EXPORT_SYMBOL(__node_distance);
  * Sanity check to catch more bad NUMA configurations (they are amazingly
  * common).  Make sure the nodes cover all memory.
  */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi=
)
+static bool __init memblock_validate_numa_coverage(const u64 limit)
 {
-       u64 numaram, e820ram;
-       int i;
+       u64 lo_pg;

-       numaram =3D 0;
-       for (i =3D 0; i < mi->nr_blks; i++) {
-               u64 s =3D mi->blk[i].start >> PAGE_SHIFT;
-               u64 e =3D mi->blk[i].end >> PAGE_SHIFT;
-               numaram +=3D e - s;
-               numaram -=3D __absent_pages_in_range(mi->blk[i].nid, s, e);
-               if ((s64)numaram < 0)
-                       numaram =3D 0;
-       }
-
-       e820ram =3D max_pfn - absent_pages_in_range(0, max_pfn);
+       lo_pg =3D max_pfn - calculate_without_node_pages_in_range();

        /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
-       if ((s64)(e820ram - numaram) >=3D (1 << (20 - PAGE_SHIFT))) {
-               printk(KERN_ERR "NUMA: nodes only cover %LuMB of your
%LuMB e820 RAM. Not used.\n",
-                      (numaram << PAGE_SHIFT) >> 20,
-                      (e820ram << PAGE_SHIFT) >> 20);
+       if (lo_pg >=3D limit) {
+               pr_err("NUMA: We lost 1m size page.\n");
                return false;
        }
+
        return true;
 }

@@ -583,7 +571,7 @@ static int __init numa_register_memblks(struct
numa_meminfo *mi)
                        return -EINVAL;
                }
        }
-       if (!numa_meminfo_cover_memory(mi))
+       if (!memblock_validate_numa_coverage(SZ_1M))
                return -EINVAL;

        /* Finally register nodes. */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0daef3f2f029..b32457ad1ae3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3043,6 +3043,7 @@ unsigned long __absent_pages_in_range(int nid,
unsigned long start_pfn,
                                                unsigned long end_pfn);
 extern unsigned long absent_pages_in_range(unsigned long start_pfn,
                                                unsigned long end_pfn);
+extern unsigned long calculate_without_node_pages_in_range(void);
 extern void get_pfn_range_for_nid(unsigned int nid,
                        unsigned long *start_pfn, unsigned long *end_pfn);

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3ddd18a89b66..13a4883787e3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1132,6 +1132,26 @@ static void __init
adjust_zone_range_for_zone_movable(int nid,
        }
 }

+/**
+ * @start_pfn: The start PFN to start searching for holes
+ * @end_pfn: The end PFN to stop searching for holes
+ *
+ * Return: Return the number of page frames without node assigned
within a range.
+ */
+unsigned long __init calculate_without_node_pages_in_range(void)
+{
+       unsigned long num_pages;
+       unsigned long start_pfn, end_pfn;
+       int nid, i;
+
+       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid)=
 {
+               if (nid =3D=3D NUMA_NO_NODE)
+                       num_pages +=3D end_pfn - start_pfn;
+       }
+
+       return num_pages;
+}
+
 /*
  * Return the number of holes in a range on a node. If nid is MAX_NUMNODES=
,
  * then all holes in the requested range will be accounted for.
--
2.25.1
