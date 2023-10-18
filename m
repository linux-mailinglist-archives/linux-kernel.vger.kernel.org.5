Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1C7CD805
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjJRJae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJRJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:30:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE30FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:30:21 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9QT763HmzCrMt;
        Wed, 18 Oct 2023 17:26:19 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 17:30:18 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3 3/7] mm/kmemleak: fix print format of pointer in pr_debug()
Date:   Wed, 18 Oct 2023 18:29:48 +0800
Message-ID: <20231018102952.3339837-4-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018102952.3339837-1-liushixin2@huawei.com>
References: <20231018102952.3339837-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 0x%p, the pointer will be hashed and print (____ptrval____) instead.
And with 0x%pa, the pointer can be successfully printed but with duplicate
prefixes, which looks like:

 kmemleak: kmemleak_free(0x(____ptrval____))
 kmemleak: kmemleak_free_percpu(0x(____ptrval____))
 kmemleak: kmemleak_free_part_phys(0x0x0000000a1af86000)

Use 0x%px instead of 0x%p or 0x%pa to print the pointer. Then the print
will be like:

 kmemleak: kmemleak_free(0xffff9111c145b020)
 kmemleak: kmemleak_free_percpu(0x00000000000333b0)
 kmemleak: kmemleak_free_part_phys(0x0000000a1af80000)

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 54c2c90d3abc..289b3be5ee6e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -975,7 +975,7 @@ static void object_no_scan(unsigned long ptr)
 void __ref kmemleak_alloc(const void *ptr, size_t size, int min_count,
 			  gfp_t gfp)
 {
-	pr_debug("%s(0x%p, %zu, %d)\n", __func__, ptr, size, min_count);
+	pr_debug("%s(0x%px, %zu, %d)\n", __func__, ptr, size, min_count);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		create_object((unsigned long)ptr, size, min_count, gfp);
@@ -996,7 +996,7 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 {
 	unsigned int cpu;
 
-	pr_debug("%s(0x%p, %zu)\n", __func__, ptr, size);
+	pr_debug("%s(0x%px, %zu)\n", __func__, ptr, size);
 
 	/*
 	 * Percpu allocations are only scanned and not reported as leaks
@@ -1020,7 +1020,7 @@ EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
  */
 void __ref kmemleak_vmalloc(const struct vm_struct *area, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%p, %zu)\n", __func__, area, size);
+	pr_debug("%s(0x%px, %zu)\n", __func__, area, size);
 
 	/*
 	 * A min_count = 2 is needed because vm_struct contains a reference to
@@ -1043,7 +1043,7 @@ EXPORT_SYMBOL_GPL(kmemleak_vmalloc);
  */
 void __ref kmemleak_free(const void *ptr)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
 		delete_object_full((unsigned long)ptr);
@@ -1061,7 +1061,7 @@ EXPORT_SYMBOL_GPL(kmemleak_free);
  */
 void __ref kmemleak_free_part(const void *ptr, size_t size)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		delete_object_part((unsigned long)ptr, size, false);
@@ -1079,7 +1079,7 @@ void __ref kmemleak_free_percpu(const void __percpu *ptr)
 {
 	unsigned int cpu;
 
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
 		for_each_possible_cpu(cpu)
@@ -1100,7 +1100,7 @@ void __ref kmemleak_update_trace(const void *ptr)
 	struct kmemleak_object *object;
 	unsigned long flags;
 
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (!kmemleak_enabled || IS_ERR_OR_NULL(ptr))
 		return;
@@ -1131,7 +1131,7 @@ EXPORT_SYMBOL(kmemleak_update_trace);
  */
 void __ref kmemleak_not_leak(const void *ptr)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		make_gray_object((unsigned long)ptr);
@@ -1149,7 +1149,7 @@ EXPORT_SYMBOL(kmemleak_not_leak);
  */
 void __ref kmemleak_ignore(const void *ptr)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		make_black_object((unsigned long)ptr, false);
@@ -1169,7 +1169,7 @@ EXPORT_SYMBOL(kmemleak_ignore);
  */
 void __ref kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && size && !IS_ERR(ptr))
 		add_scan_area((unsigned long)ptr, size, gfp);
@@ -1187,7 +1187,7 @@ EXPORT_SYMBOL(kmemleak_scan_area);
  */
 void __ref kmemleak_no_scan(const void *ptr)
 {
-	pr_debug("%s(0x%p)\n", __func__, ptr);
+	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
 		object_no_scan((unsigned long)ptr);
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
  */
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 {
-	pr_debug("%s(0x%pa, %zu)\n", __func__, &phys, size);
+	pr_debug("%s(0x%px, %zu)\n", __func__, &phys, size);
 
 	if (kmemleak_enabled)
 		/*
@@ -1223,7 +1223,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
-	pr_debug("%s(0x%pa)\n", __func__, &phys);
+	pr_debug("%s(0x%px)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
 		delete_object_part((unsigned long)phys, size, true);
@@ -1237,7 +1237,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
-	pr_debug("%s(0x%pa)\n", __func__, &phys);
+	pr_debug("%s(0x%px)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
 		make_black_object((unsigned long)phys, true);
-- 
2.25.1

