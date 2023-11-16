Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49E7ED8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjKPB3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPB3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE94182
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4PU7kaICTCYIryKeefw2/Ev2pNew0CTTu+cawaO/2M4=;
        b=bGT1faX8UOC6hAK9KienBvMOUdKIZa0GmFVCK+kNctTMIhrwcxyhVHA7FlnQK4zxYQxqI5
        IVuZ+hv0DP9lsoudZOtnMz56Fl9wb3rFQvioBGzj5/ZpPbcT4mr73fMQo+ao6jduZrphTv
        d8PnyuINFVTCR+NX8Jr6F1saWtSJx3Q=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-E34-e6psNDaq8YrzhyyDxQ-1; Wed, 15 Nov 2023 20:29:12 -0500
X-MC-Unique: E34-e6psNDaq8YrzhyyDxQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-581d59ea23dso63117eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098151; x=1700702951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PU7kaICTCYIryKeefw2/Ev2pNew0CTTu+cawaO/2M4=;
        b=AwxBKJX0lysjUI0ax7J95NT/DLSUfflYuzZ9thrg98uSZvf3c7rFmv9vzlSceTcPiX
         Czr/M4VvAna0g2vQBRVukpCuugE4yFI6dcaQf5szxbvYNDbh7vS1SbDOT55t6Zwq+vIa
         0QmhNMiIEEGaAlS+dptY4IH/V9g5aaiVsV0I4SSHsofDE2WDIkoBNOH1w5ZFV4cTpsnZ
         FYdvwrBKR8dR9TkvORgvSBnrN10lkEEOg4/YMWVn/G7xw9ean7Ei8lUUisS6pcCEeAsM
         daejX9fpjNXMFtdpiBW3Dzfaf6i7K9HWEI0V2CEiA0AxzsU5ypfK3cqdOOcIfF0kAjTS
         e7IA==
X-Gm-Message-State: AOJu0YyRCynY/1nABsN25mY/d9CxIJNq+3jBMdZpyrcgapso1Op1lQBO
        1W4ayWz36s/CRKKtinRqMduVBfOTmIuevtWM0VH52vS3C/5mzjgPYEnKb5Ahd2MMJm4hGSycQyf
        gv1+dgjmTk1S34lw9/eY1NRk5eYiYGabMtVNrDfXdxrUxoUOjjVj60XgmWW8HtD/hI+qjysFOEW
        nrTz6Wpw==
X-Received: by 2002:a05:6358:7e55:b0:16b:96fc:650e with SMTP id p21-20020a0563587e5500b0016b96fc650emr7346647rwm.3.1700098151525;
        Wed, 15 Nov 2023 17:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFImde6pf3JVssBAvi5nvxUOfTkQFEUHKzKi5Co8doDN7L44uxCciulaI4uHmQLQCXmL97l4Q==
X-Received: by 2002:a05:6358:7e55:b0:16b:96fc:650e with SMTP id p21-20020a0563587e5500b0016b96fc650emr7346617rwm.3.1700098151045;
        Wed, 15 Nov 2023 17:29:11 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:10 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RFC 00/12] mm/gup: Unify hugetlb, part 2
Date:   Wed, 15 Nov 2023 20:28:56 -0500
Message-ID: <20231116012908.392077-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is in RFC stage. It's mostly because it is only yet tested on
x86_64 in a VM.  Not even compile tested on PPC or any other archs, it
means at least the hugepd patch (patch 11) is mostly untested, or even not
compile tested.  Before doing that, I'd like to collect any information
from high level.

If anyone would like to provide any testing either over hugepd or CONT_PMD
/ CONT_PTE on ARM (before I reach there..), or RISCV over 64K Svnapot,
that'll be very much appreciated.  I'm copying PPC, ARM, RISCV list for
that.  It can be as simple as "./run_vmtests.sh -t gup_test -a" for now,
making sure hugetlb pages can be allocated along the way; the non-hugetlb
gup tests will guaranteed to be covered more or less, I suppose.

In summary, this is a continuous work for previous series:

https://lore.kernel.org/all/20230628215310.73782-1-peterx@redhat.com

And this more or less is my current take to move one more small step
towards merging hugetlb code into generic mm code, as much as we can.

That part-1 series dropped follow_hugetlb_page().  The plan of this one is
to further drops hugetlb_follow_page_mask().  The hugetlb GUP will use the
same code path for generic mm after whole set applied.

It means the generic code will need to at least understand hugepd, and
that's already done like so in fast-gup.  Fortunately it seems that's the
only major thing I need to teach GUP to share the common path for now
besides normal huge PxD entries.  Non-gup can be more challenging, but
that's a question for later.

Patch layout:
=============

Patch 1-4:    Preparation works, mm generic part
Patch 5-6:    Bugfixes; I think patch 5 if verified can be merged earlier
Patch 7-11:   Preparation works, gup part
Patch 12:     Drop hugetlb_follow_page_mask()

More information can be found in the commit messages of each patch.  Any
comment will be welcomed.  Thanks.

Peter Xu (12):
  mm/hugetlb: Export hugetlbfs_pagecache_present()
  mm: Provide generic pmd_thp_or_huge()
  mm: Export HPAGE_PXD_* macros even if !THP
  mm: Introduce vma_pgtable_walk_{begin|end}()
  mm/gup: Fix follow_devmap_p[mu]d() to return even if NULL
  mm/gup: Drop folio_fast_pin_allowed() in hugepd processing
  mm/gup: Refactor record_subpages() to find 1st small page
  mm/gup: Handle hugetlb for no_page_table()
  mm/gup: Handle huge pud for follow_pud_mask()
  mm/gup: Handle huge pmd for follow_pmd_mask()
  mm/gup: Handle hugepd for follow_page()
  mm/gup: Merge hugetlb into generic mm code

 include/linux/huge_mm.h |  34 +++----
 include/linux/hugetlb.h |  10 +-
 include/linux/mm.h      |   3 +
 include/linux/pgtable.h |   4 +
 mm/gup.c                | 197 +++++++++++++++++++++++++---------------
 mm/huge_memory.c        | 117 +++++++++++++-----------
 mm/hugetlb.c            |  75 +--------------
 mm/internal.h           |   6 +-
 mm/memory.c             |  12 +++
 9 files changed, 233 insertions(+), 225 deletions(-)

-- 
2.41.0

