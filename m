Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A07C8641
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjJMM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjJMM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:59:11 -0400
X-Greylist: delayed 78991 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 05:59:09 PDT
Received: from out-207.mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E8BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:59:09 -0700 (PDT)
Date:   Fri, 13 Oct 2023 21:58:56 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697201947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/wTbhHU5rbrI+BeEut+pKSzv8F9ZWvt0d/dEa4I7XI=;
        b=WoxhJtddxX73sqPzb0Zn/12n8Qcqhnh/ZjGuuwy193Kt2MdYfPUvQmJDU8Z7sR6XtWqK0P
        NJ9mvs8lRCcNMCXT59gAD2k3Spx23QlowL41fp5dADWzY8kmxXDyrySilBuSlagtik8/wA
        RxUUXD2/RVQ3NNwOkl/qAbNpycce5Rg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/11] hugetlb: set hugetlb page flag before
 optimizing vmemmap
Message-ID: <20231013125856.GA636971@u2004>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230905214412.89152-2-mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 02:44:00PM -0700, Mike Kravetz wrote:
> Currently, vmemmap optimization of hugetlb pages is performed before the
> hugetlb flag (previously hugetlb destructor) is set identifying it as a
> hugetlb folio.  This means there is a window of time where an ordinary
> folio does not have all associated vmemmap present.  The core mm only
> expects vmemmap to be potentially optimized for hugetlb  and device dax.
> This can cause problems in code such as memory error handling that may
> want to write to tail struct pages.
> 
> There is only one call to perform hugetlb vmemmap optimization today.
> To fix this issue, simply set the hugetlb flag before that call.
> 
> There was a similar issue in the free hugetlb path that was previously
> addressed.  The two routines that optimize or restore hugetlb vmemmap
> should only be passed hugetlb folios/pages.  To catch any callers not
> following this rule, add VM_WARN_ON calls to the routines.  In the
> hugetlb free code paths, some calls could be made to restore vmemmap
> after clearing the hugetlb flag.  This was 'safe' as in these cases
> vmemmap was already present and the call was a NOOP.  However, for
> consistency these calls where eliminated so that we can add the
> VM_WARN_ON checks.
> 
> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

I saw that VM_WARN_ON_ONCE() in hugetlb_vmemmap_restore is triggered when
memory_failure() is called on a free hugetlb page with vmemmap optimization
disabled (the warning is not triggered if vmemmap optimization is enabled).
I think that we need check folio_test_hugetlb() before dissolve_free_huge_page()
calls hugetlb_vmemmap_restore_folio().

Could you consider adding some diff like below?

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2312,15 +2312,16 @@ int dissolve_free_huge_page(struct page *page)
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
 		 */
-		rc = hugetlb_vmemmap_restore_folio(h, folio);
-		if (!rc) {
-			update_and_free_hugetlb_folio(h, folio, false);
-		} else {
-			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_folio(h, folio, false);
-			h->max_huge_pages++;
-			spin_unlock_irq(&hugetlb_lock);
+		if (folio_test_hugetlb(folio)) {
+			rc = hugetlb_vmemmap_restore_folio(h, folio);
+			if (rc) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, folio, false);
+				h->max_huge_pages++;
+				goto out;
+			}
 		}
+		update_and_free_hugetlb_folio(h, folio, false);
 
 		return rc;
 	}


Thanks,
Naoya Horiguchi
