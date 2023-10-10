Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66B97BFF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjJJO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjJJO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:29:08 -0400
Received: from out-195.mta0.migadu.com (out-195.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70888A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:29:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696948144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/QG0Z2F3QpUoVuiwm1cdKUqeM2tUh0VmscjJ0F6F+U=;
        b=MWezG50+O7UF+lm6gT/NNY5RH7a9ZopHj6n/EIkn62Z4LPC8w5SNIXi0a8Rgj52GVjSvYo
        3EvJzzjr7YfdBb0crTZGG+Hndwx69pJFC8xJobtbDgC16FB0JY6EgocjAcpWMzR122rcVV
        9pbMUMojnK8Du56fogifM1zDVCrzEt8=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] tools/mm/page-types.c: hide compound pages in non-raw mode
Date:   Tue, 10 Oct 2023 23:28:01 +0900
Message-Id: <20231010142801.3780917-6-naoya.horiguchi@linux.dev>
In-Reply-To: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

In non-raw mode (i.e. calling page-types without -r flag), any flags
for compound pages except for hugetlb are supposed to be hidden.
But currently KPF_THP is shown and the newly added flag KPF_FOLIO is
also shown, which is unexpected.  So hide them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 tools/mm/page-types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index b78448d19e88..c37e1e79bc61 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -508,7 +508,7 @@ static uint64_t well_known_flags(uint64_t flags)
 
 	/* hide non-hugeTLB compound pages */
 	if ((flags & BITS_COMPOUND) && !(flags & BIT(HUGE)))
-		flags &= ~BITS_COMPOUND;
+		flags &= ~(BITS_COMPOUND|BIT(THP)|BIT(FOLIO));
 
 	return flags;
 }
-- 
2.25.1

