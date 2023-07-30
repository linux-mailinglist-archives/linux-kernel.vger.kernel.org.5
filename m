Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DFD76862D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjG3PQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjG3PQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:16:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3D2171B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso42076825e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690730174; x=1691334974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed3bTY/DQrtVo38S3b99vtsCN5ydWYuckmFt+jfpXnQ=;
        b=CsLvLnj1VBExXRAAglTYPWH2EpYCorZggOAC3yIHs0vybciyxsExVcLP/39obiFOYD
         FverDpvbx+BWRlvxddS1Ucch0Lo8ySBj5n4n9qsls9ncd4/U0ukC8FCsg5LU0Ps7yXpS
         0x73YYFy0A18lccSHORRLeDqKaS8nvvq1tbkN/1SKvxZESadhIFOz/0oIn1npIu6dGrI
         2CSL9zF3tMODmGVmKAr7ZywN5DBo03IuiGI33kAtutuURXCt6kQH4LYr2FKRdNpyhVsi
         OuuSaUD++enIZiLNISEKbcIDH+KKX7DGzU9igsnu/+61mXgL/I4WQRrk8Tlu5bD6f8xb
         lAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690730174; x=1691334974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed3bTY/DQrtVo38S3b99vtsCN5ydWYuckmFt+jfpXnQ=;
        b=l5DFJAE0OqA9UJDZYpLQO/ng+i2JvHTjYiEzqZaaun9rcgHVcl1Uxb91s8q+qW0kuJ
         smr+zYXKp5p15eiiywO+ff9grWdzmeZ4FOjVEZYeguNG301skm9lSRGezrVHYnQPC73/
         pZiNDPQ+5RIe+hPA16eZaQcZBEt5fe6K75RL2I4t3weCApIocySPqTje/eR6QyQJIldv
         la9NwSG9rDRlw7hJaMSd2gOCyoReqC8lnel64Ex+9NDyA1yphvGPQ33BJnbs+AYnNzKb
         J50d7GRRHTk7kB2WH5I9u+0P0xg9dctsWw9uIR6UnbeGeckIVR/YxJ99coCG+W57Na+7
         jDzA==
X-Gm-Message-State: ABy/qLZmMb2vUXBzzez8p08zQhbpIfAUk1AsJc7C/LX3sz0BEMu4URxX
        zDBnaWP7ieN7iy+swL2F3r10/Q==
X-Google-Smtp-Source: APBJJlEvwIYdcin+SgJIaKf3f0NWjv2vOyb8TeOb/EE1tTkylJ9cPozIeSxvQxhFH8cAtZQs6UhkkA==
X-Received: by 2002:a05:600c:3787:b0:3fa:97b3:7ce0 with SMTP id o7-20020a05600c378700b003fa97b37ce0mr3917250wmr.26.1690730174681;
        Sun, 30 Jul 2023 08:16:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:eda5:aa63:ce24:dac2])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcc11000000b003fd2d33ea53sm9123027wmh.14.2023.07.30.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 08:16:14 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v2 6/6] mm: hugetlb: Skip initialization of struct pages freed later by HVO
Date:   Sun, 30 Jul 2023 16:16:06 +0100
Message-Id: <20230730151606.2871391-7-usama.arif@bytedance.com>
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

This is done by marking the region for which to skip initialization
with the MEMBLOCK_RSRV_NOINIT flag.
If the region is for hugepages and if HVO is enabled, then those
struct pages which will be freed later don't need to be initialized.
This can save significant time when a large number of hugepages are
allocated at boot time. HUGETLB_VMEMMAP_RESERVE_SIZE
struct pages at the start of hugepage still need to be initialized.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb.c         | 21 +++++++++++++++++++++
 mm/hugetlb_vmemmap.c |  2 +-
 mm/hugetlb_vmemmap.h |  3 +++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf60545496d7..8434100f60ae 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3151,6 +3151,9 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
 	struct huge_bootmem_page *m = NULL; /* initialize for clang */
 	int nr_nodes, node;
+	phys_addr_t hugetlb_vmemmap_reserve_size =
+		HUGETLB_VMEMMAP_RESERVE_SIZE * sizeof(struct page);
+	phys_addr_t noinit_base;
 
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {
@@ -3158,6 +3161,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 		if (!m)
 			return 0;
+
+		if (vmemmap_optimize_enabled && hugetlb_vmemmap_optimizable(h)) {
+			noinit_base = virt_to_phys(
+				(void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
+			memblock_reserved_mark_noinit(
+				noinit_base,
+				huge_page_size(h) - hugetlb_vmemmap_reserve_size);
+		}
+
 		goto found;
 	}
 	/* allocate from next node when distributing huge pages */
@@ -3172,6 +3184,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 		 */
 		if (!m)
 			return 0;
+
+		if (vmemmap_optimize_enabled && hugetlb_vmemmap_optimizable(h)) {
+			noinit_base = virt_to_phys(
+				(void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
+			memblock_reserved_mark_noinit(
+				noinit_base,
+				huge_page_size(h) - hugetlb_vmemmap_reserve_size);
+		}
+
 		goto found;
 	}
 
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
index 3e7978a9af73..3fff6f611c19 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -64,4 +64,7 @@ static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 {
 	return hugetlb_vmemmap_optimizable_size(h) != 0;
 }
+
+extern bool vmemmap_optimize_enabled;
+
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.25.1

