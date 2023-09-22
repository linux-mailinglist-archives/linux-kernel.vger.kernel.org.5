Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05997AAD9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjIVJPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjIVJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:15:46 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08541B2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:15:32 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38M9FBK6033971;
        Fri, 22 Sep 2023 17:15:11 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RsRNP2mzdz2SdWY0;
        Fri, 22 Sep 2023 17:11:49 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 22 Sep 2023 17:15:10 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>,
        <steve.kang@unisoc.com>
Subject: [Resend PATCH] arch: arm: remove redundant clear_page when CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on
Date:   Fri, 22 Sep 2023 17:15:05 +0800
Message-ID: <20230922091505.2196197-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.40]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 38M9FBK6033971
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Double times of clear_page observed in an arm SOC(A55) when
CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on, which introduced by
vma_alloc_zeroed_movable_folio within do_anonymous_pages.
Since there is no D-cache operation within v6's clear_user_highpage,
I would like to suggest to remove the redundant clear_page.

struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
				   unsigned long vaddr)
{
	struct folio *folio;

//first clear_page invoked by vma_alloc_folio==>alloc_page==>post_alloc_hook
	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
	if (folio)
//second clear_page which is meaningless since it do nothing to D-cache in armv6
		clear_user_highpage(&folio->page, vaddr);

	return folio;
}

PS:
Here are all positions called clear_user_highpage which are paired
with alloc_pages. IMO,  it is safe to skip the second clear_page under
armv6.

drivers/media/v4l2-core/videobuf-dma-sg.c:441:
clear_user_highpage(page, vmf->address);
fs/dax.c:1612: clear_user_highpage(vmf->cow_page, vmf->address);
include/linux/highmem.h:231: clear_user_highpage(&folio->page, vaddr);
mm/memory.c:5974: clear_user_highpage(p, addr + i * PAGE_SIZE);
mm/memory.c:5982: clear_user_highpage(page + idx, addr);
mm/shmem.c:2621: clear_user_highpage(&folio->page, dst_addr);
mm/khugepaged.c:796: clear_user_highpage(page, _address);

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 arch/arm/mm/copypage-v6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index a1a71f36d850..6f8bee1b3203 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/gfp.h>
 
 #include <asm/shmparam.h>
 #include <asm/tlbflush.h>
@@ -45,6 +46,13 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
  */
 static void v6_clear_user_highpage_nonaliasing(struct page *page, unsigned long vaddr)
 {
+	/*
+	 * This criteria only help bailing out when CONFIG_INIT_ON_ALLOC_DEFAULT_ON
+	 * is on. The page has been memset to zero when it allocated and the
+	 * bellowing clear_page will do it again.
+	 */
+	if (want_init_on_alloc(GFP_HIGHUSER_MOVABLE))
+		return;
 	void *kaddr = kmap_atomic(page);
 	clear_page(kaddr);
 	kunmap_atomic(kaddr);
-- 
2.25.1

