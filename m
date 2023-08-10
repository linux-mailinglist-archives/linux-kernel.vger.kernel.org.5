Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087CD777AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjHJOaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjHJO35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:29:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9E6126BD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:29:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9B95113E;
        Thu, 10 Aug 2023 07:30:37 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 288DB3F64C;
        Thu, 10 Aug 2023 07:29:53 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/5] mm: Allow deferred splitting of arbitrary large anon folios
Date:   Thu, 10 Aug 2023 15:29:38 +0100
Message-Id: <20230810142942.3169679-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810142942.3169679-1-ryan.roberts@arm.com>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the introduction of large folios for anonymous
memory, we would like to be able to split them when they have unmapped
subpages, in order to free those unused pages under memory pressure. So
remove the artificial requirement that the large folio needed to be at
least PMD-sized.

Reviewed-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/rmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1f04debdc87a..769fcabc6c56 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1446,11 +1446,11 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		__lruvec_stat_mod_folio(folio, idx, -nr);
 
 		/*
-		 * Queue anon THP for deferred split if at least one
+		 * Queue anon large folio for deferred split if at least one
 		 * page of the folio is unmapped and at least one page
 		 * is still mapped.
 		 */
-		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
+		if (folio_test_large(folio) && folio_test_anon(folio))
 			if (!compound || nr < nr_pmdmapped)
 				deferred_split_folio(folio);
 	}
-- 
2.25.1

