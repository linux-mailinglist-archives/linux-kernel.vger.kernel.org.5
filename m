Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB85774D67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjHHVxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjHHVx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:53:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0CB21E8F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:31:57 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKlyH2ThczVk75;
        Tue,  8 Aug 2023 16:01:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 16:03:36 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] iov_iter: Use helper macro offset_in_page()
Date:   Tue, 8 Aug 2023 16:02:58 +0800
Message-ID: <20230808080258.2301297-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro offset_in_page() to improve code readability.

No functional modification involved.

Also, it fixes the following warning:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+               unsigned offs = offset_in_page(p->bv_offset + skip);

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+               unsigned offset = offset_in_page(i->xarray_start + i->iov_offset);

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 lib/iov_iter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 424737045b97..b76704c36528 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1089,7 +1089,7 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 		*size = len;
 	skip += i->bvec->bv_offset;
 	page = i->bvec->bv_page + skip / PAGE_SIZE;
-	*start = skip % PAGE_SIZE;
+	*start = offset_in_page(skip);
 	return page;
 }
 
@@ -1116,7 +1116,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 			gup_flags |= FOLL_NOFAULT;
 
 		addr = first_iovec_segment(i, &maxsize);
-		*start = addr % PAGE_SIZE;
+		*start = offset_in_page(addr);
 		addr &= PAGE_MASK;
 		n = want_pages_array(pages, maxsize, *start, maxpages);
 		if (!n)
@@ -1280,7 +1280,7 @@ static int bvec_npages(const struct iov_iter *i, int maxpages)
 	int npages = 0;
 
 	for (p = i->bvec; size; skip = 0, p++) {
-		unsigned offs = (p->bv_offset + skip) % PAGE_SIZE;
+		unsigned int offs = offset_in_page(p->bv_offset + skip);
 		size_t len = min(p->bv_len - skip, size);
 
 		size -= len;
@@ -1306,7 +1306,7 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 	if (iov_iter_is_bvec(i))
 		return bvec_npages(i, maxpages);
 	if (iov_iter_is_xarray(i)) {
-		unsigned offset = (i->xarray_start + i->iov_offset) % PAGE_SIZE;
+		unsigned int offset = offset_in_page(i->xarray_start + i->iov_offset);
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
 		return min(npages, maxpages);
 	}
@@ -1670,7 +1670,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 
 	skip += i->bvec->bv_offset;
 	page = i->bvec->bv_page + skip / PAGE_SIZE;
-	offset = skip % PAGE_SIZE;
+	offset = offset_in_page(skip);
 	*offset0 = offset;
 
 	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
@@ -1773,7 +1773,7 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
 		gup_flags |= FOLL_NOFAULT;
 
 	addr = first_iovec_segment(i, &maxsize);
-	*offset0 = offset = addr % PAGE_SIZE;
+	*offset0 = offset = offset_in_page(addr);
 	addr &= PAGE_MASK;
 	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
 	if (!maxpages)
-- 
2.34.1

