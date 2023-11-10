Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1FE7E780A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345861AbjKJDeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjKJDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:33:53 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056F44BD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:33:51 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SRPV46W0Gz1P89B;
        Fri, 10 Nov 2023 11:30:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 11:33:49 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 3/7] fs/proc/page: respect folio head-page flag placement
Date:   Fri, 10 Nov 2023 11:33:20 +0800
Message-ID: <20231110033324.2455523-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kpageflags reads page-flags directly from the page, even when the
respective flag is only updated on the headpage of a folio.

Since most flags are stored in head flags, make k = folio->flags,
and add new p = page->flags used for per-page flags.

Originally-from: Gregory Price <gregory.price@memverge.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/proc/page.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index dcef02471f91..553a7c921cb4 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -110,8 +110,7 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
 u64 stable_page_flags(struct page *page)
 {
 	struct folio *folio;
-	u64 k;
-	u64 u;
+	u64 k, p, u;
 
 	/*
 	 * pseudo flag: KPF_NOPAGE
@@ -121,7 +120,8 @@ u64 stable_page_flags(struct page *page)
 		return 1 << KPF_NOPAGE;
 
 	folio = page_folio(page);
-	k = page->flags;
+	k = folio->flags;
+	p = page->flags;
 	u = 0;
 
 	/*
@@ -202,7 +202,7 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
 
 #ifdef CONFIG_MEMORY_FAILURE
-	u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
+	u |= kpf_copy_bit(p, KPF_HWPOISON,	PG_hwpoison);
 #endif
 
 #ifdef CONFIG_ARCH_USES_PG_UNCACHED
@@ -211,13 +211,13 @@ u64 stable_page_flags(struct page *page)
 
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
 	u |= kpf_copy_bit(k, KPF_MAPPEDTODISK,	PG_mappedtodisk);
-	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
-	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
-	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
+	u |= kpf_copy_bit(p, KPF_PRIVATE,	PG_private);
+	u |= kpf_copy_bit(p, KPF_PRIVATE_2,	PG_private_2);
+	u |= kpf_copy_bit(p, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
 	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
 #ifdef CONFIG_ARCH_USES_PG_ARCH_X
-	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
-	u |= kpf_copy_bit(k, KPF_ARCH_3,	PG_arch_3);
+	u |= kpf_copy_bit(p, KPF_ARCH_2,	PG_arch_2);
+	u |= kpf_copy_bit(p, KPF_ARCH_3,	PG_arch_3);
 #endif
 
 	return u;
-- 
2.27.0

