Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC046765D95
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjG0UrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjG0UrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:47:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386382D60
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3174aac120aso1423313f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690490797; x=1691095597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckgW/P+ejqydrp6JQqQrrU5HjkGQNsndgwMWGYDB/pc=;
        b=MHW+96etwxTrHcysNxNv4Jt5Keu/21p5ZeNuDIbQx9GnIkEA1kq7sTTqw6Q/8BayM4
         1Acht/ZPiVv8tOChy+mgBTfHG6ixCBKorlj2dJl7YTk0/sTWgbMWE9WJCFXy+OQ9Iijl
         F797zrYkH1WHN8+kZpWGtO4V6mpRCt3ijeyEEL/x0uHMVkx2JVs2E0JF144vy0BqQwCm
         brRLxremJQxfBWLsYq+wA+OhATOq4v3hK/HHE03k794S7TLjgAEkUPQNfZuGNCFBakRv
         3NI8Jepy+Nx2mW0XqXn6WjNkB/tP3+1AiL7EGltSxqblDgE7Db3FfhwIHlnqEs7zbPpH
         c/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490797; x=1691095597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckgW/P+ejqydrp6JQqQrrU5HjkGQNsndgwMWGYDB/pc=;
        b=HcWvJSbMTkhtzPPMgy1c8PJUZ1VeaGPrrkHY2pYet46UdygVtss9oCzPVKcvTe54Of
         GFptEERuCyulR0+3BQnd+Xi5c4qTwRUi6vZa9VSV7GSrOhjrkUDsiy8m+l+TLKcMlw/9
         04VlTdOcJlrKfOSspUJbWsVWzC084xNSbAhqxYIanqCr3UhYlISQrMwPStMhqRh7NX/8
         CiSSsc/NV4fZxhr1qNJYtzYQi8BHZHDqd6TTvHteeJJsXP5CrCiGEHTzUIaTtsOdzXl5
         0F3GHHss1U4MpAzRPWUrpSePHQCqUtwcRQYg/xedRpbnbqeiCKsqES12+0aQ/twvGsVw
         nkjQ==
X-Gm-Message-State: ABy/qLbewnaQyyodr5P7r8U4wej9aBuz3Z54VvVNXpAzqORGF8rV2yee
        tUPAXQWL5CiH5K8vo9HC0Y1u0A==
X-Google-Smtp-Source: APBJJlEO7+YO7D/m+lNz0Wmsb1Fis9T5rZ6fiE8hYl22nZAClbV/pTs8BoCD41J0AwcBpujlXdeyTA==
X-Received: by 2002:adf:db44:0:b0:314:34dd:aaec with SMTP id f4-20020adfdb44000000b0031434ddaaecmr229166wrj.8.1690490796779;
        Thu, 27 Jul 2023 13:46:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc401000000b003fc06169abdsm2701400wmi.2.2023.07.27.13.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:46:36 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v1 6/6] mm: hugetlb: Skip initialization of struct pages freed later by HVO
Date:   Thu, 27 Jul 2023 21:46:24 +0100
Message-Id: <20230727204624.1942372-7-usama.arif@bytedance.com>
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
index c1fcf2af591a..bb2b12f41026 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3166,6 +3166,9 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
 	struct huge_bootmem_page *m = NULL; /* initialize for clang */
 	int nr_nodes, node;
+	phys_addr_t hugetlb_vmemmap_reserve_size =
+		HUGETLB_VMEMMAP_RESERVE_SIZE * sizeof(struct page);
+	phys_addr_t noinit_base;
 
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {
@@ -3173,6 +3176,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 		if (!m)
 			return 0;
+
+		if (vmemmap_optimize_enabled && hugetlb_vmemmap_optimizable(h)) {
+			noinit_base = virt_to_phys(
+				(void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
+			memblock_rsrv_mark_noinit(
+				noinit_base,
+				huge_page_size(h) - hugetlb_vmemmap_reserve_size);
+		}
+
 		goto found;
 	}
 	/* allocate from next node when distributing huge pages */
@@ -3187,6 +3199,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 		 */
 		if (!m)
 			return 0;
+
+		if (vmemmap_optimize_enabled && hugetlb_vmemmap_optimizable(h)) {
+			noinit_base = virt_to_phys(
+				(void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
+			memblock_rsrv_mark_noinit(
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
index 07555d2dc0cb..cb5171abe683 100644
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

