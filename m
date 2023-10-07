Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39E7BC59C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbjJGH3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbjJGH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:29:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A6FDF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696663777; x=1728199777;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=KKsNX1B4ephXy3wePWdgK65UEebN0b8CYmREFVzaYus=;
  b=XkxLB8kcPupSoCwHMN1w4I/J3oD2UHlVluX/dZF/plqno785ojFrIrDA
   FLnddfmkpZAq4ddaGaoKz6Kf+DR8AHOX7n28KsQw7wDlwg76qblQrySgh
   ZS9b9I4p9kG/RJcE2g5idIyNWFeeCYqct5TfNBCgVEAW57lfqUna9a1SW
   vqsyWaVP9hkWKMY7juIifDBOi3J7zlpFAS2PGw4i4nHnr1F+sOVQ8QFAq
   ZvN77mH9SYJ8d43EmQOYVxovsgQshR/cA3DbQMDo2G24l71JWR21TPg8k
   reJVCcukKtnX0m2DW4merjswrr0zSjLIGwa5JdSce943VjkkPHk40wIR/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="382768536"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="382768536"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="868608902"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="868608902"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:29:32 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 03/12] mempolicy: fix migrate_pages(2) syscall return
 nr_failed
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
        <9a6b0b9-3bb-dbef-8adf-efab4397b8d@google.com>
Date:   Sat, 07 Oct 2023 15:27:23 +0800
In-Reply-To: <9a6b0b9-3bb-dbef-8adf-efab4397b8d@google.com> (Hugh Dickins's
        message of "Tue, 3 Oct 2023 02:17:43 -0700 (PDT)")
Message-ID: <87o7halwo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hughd@google.com> writes:

> "man 2 migrate_pages" says "On success migrate_pages() returns the number
> of pages that could not be moved".  Although 5.3 and 5.4 commits fixed
> mbind(MPOL_MF_STRICT|MPOL_MF_MOVE*) to fail with EIO when not all pages
> could be moved (because some could not be isolated for migration),
> migrate_pages(2) was left still reporting only those pages failing at the
> migration stage, forgetting those failing at the earlier isolation stage.
>
> Fix that by accumulating a long nr_failed count in struct queue_pages,
> returned by queue_pages_range() when it's not returning an error, for
> adding on to the nr_failed count from migrate_pages() in mm/migrate.c.
> A count of pages?  It's more a count of folios, but changing it to pages
> would entail more work (also in mm/migrate.c): does not seem justified.
>
> queue_pages_range() itself should only return -EIO in the "strictly
> unmovable" case (STRICT without any MOVEs): in that case it's best to
> break out as soon as nr_failed gets set; but otherwise it should continue
> to isolate pages for MOVing even when nr_failed - as the mbind(2) manpage
> promises.
>
> There's a case when nr_failed should be incremented when it was missed:
> queue_folios_pte_range() and queue_folios_hugetlb() count the transient
> migration entries, like queue_folios_pmd() already did.  And there's a
> case when nr_failed should not be incremented when it would have been:
> in meeting later PTEs of the same large folio, which can only be isolated
> once: fixed by recording the current large folio in struct queue_pages.
>
> Clean up the affected functions, fixing or updating many comments.  Bool
> migrate_folio_add(), without -EIO: true if adding, or if skipping shared
> (but its arguable folio_estimated_sharers() heuristic left unchanged).
> Use MPOL_MF_WRLOCK flag to queue_pages_range(), instead of bool lock_vma.
> Use explicit STRICT|MOVE* flags where queue_pages_test_walk() checks for
> skipping, instead of hiding them behind MPOL_MF_VALID.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

--
Best Regards,
Huang, Ying
