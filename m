Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819817C4ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbjJKGkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbjJKGkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:40:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38BA4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697006405; x=1728542405;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=09Ah/xh872aHOGZOGpIWrTMNbCb6X9gQD8G1LjWG4/Q=;
  b=ghHmIURxOTgfKVzPPUSq0L4wt6vL9h91zMCsLL4BPzM3iLeDuEzzlZf0
   VvM+WjIcx+61EAh5lejLwMGQFTIwH6zwmfDrRDmkDOTCWIdWAh/Xzl7L/
   1lLhaQwsVrUC8o5eMPhL4417CXLpfCD28zpV6ofAleM/3EKqudzXrFexo
   T4Dhofwzoau7VJtu9TsDrspDtRWUjLyaus5IqVnvssLkp6SdLBtbL40dC
   7F8tSKiGQXaFb2Q7hAQMgLRqwwa1kvd1fMc+asi3kt0tVUqqZX0StYgBQ
   KUgGsH886yCuQDGFehRuqnzdyet8bxFHZ6XlBiTCPeDXUpd1ozdxmEn/9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387435634"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387435634"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824047061"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824047061"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:40:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 0/2] Swap-out small-sized THP without splitting
References: <20231010142111.3997780-1-ryan.roberts@arm.com>
Date:   Wed, 11 Oct 2023 14:37:58 +0800
In-Reply-To: <20231010142111.3997780-1-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Tue, 10 Oct 2023 15:21:09 +0100")
Message-ID: <87zg0pfyux.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> Hi All,
>
> This is an RFC for a small series to add support for swapping out small-sized
> THP without needing to first split the large folio via __split_huge_page(). It
> closely follows the approach already used by PMD-sized THP.
>
> "Small-sized THP" is an upcoming feature that enables performance improvements
> by allocating large folios for anonymous memory, where the large folio size is
> smaller than the traditional PMD-size. See [1].
>
> In some circumstances I've observed a performance regression (see patch 2 for
> details), and this series is an attempt to fix the regression in advance of
> merging small-sized THP support.
>
> I've done what I thought was the smallest change possible, and as a result, this
> approach is only employed when the swap is backed by a non-rotating block device
> (just as PMD-sized THP is supported today). However, I have a few questions on
> whether we should consider relaxing those requirements in certain circumstances:
>
>
> 1) block-backed vs file-backed
> ==============================
>
> The code only attempts to allocate a contiguous set of entries if swap is backed
> by a block device (i.e. not file-backed). The original commit, f0eea189e8e9
> ("mm, THP, swap: don't allocate huge cluster for file backed swap device"),
> stated "It's hard to write a whole transparent huge page (THP) to a file backed
> swap device". But didn't state why. Does this imply there is a size limit at
> which it becomes hard? And does that therefore imply that for "small enough"
> sizes we should now allow use with file-back swap?
>
> This original commit was subsequently fixed with commit 41663430588c ("mm, THP,
> swap: fix allocating cluster for swapfile by mistake"), which said the original
> commit was using the wrong flag to determine if it was a block device and
> therefore in some cases was actually doing large allocations for a file-backed
> swap device, and this was causing file-system corruption. But that implies some
> sort of correctness issue to me, rather than the performance issue I inferred
> from the original commit.
>
> If anyone can offer an explanation, that would be helpful in determining if we
> should allow some large sizes for file-backed swap.

swap use 'swap extent' (swap_info_struct.swap_extent_root) to map from
swap offset to storage block number.  For block-backed swap, the mapping
is pure linear.  So, you can use arbitrary large page size.  But for
file-backed swap, only PAGE_SIZE alignment is guaranteed.

> 2) rotating vs non-rotating
> ===========================
>
> I notice that the clustered approach is only used for non-rotating swap. That
> implies that for rotating media, we will always fail a large allocation, and
> fall back to splitting THPs to single pages. Which implies that the regression
> I'm fixing here may still be present on rotating media? Or perhaps rotating disk
> is so slow that the cost of writing the data out dominates the cost of
> splitting?
>
> I considered that potentially the free swap entry search algorithm that is used
> in this case could be modified to look for (small) contiguous runs of entries;
> Up to ~16 pages (order-4) could be done by doing 2x 64bit reads from map instead
> of single byte.
>
> I haven't looked into this idea in detail, but wonder if anybody thinks it is
> worth the effort? Or perhaps it would end up causing bad fragmentation.

I doubt anybody will use rotating storage to back swap now.

> Finally on testing, I've run the mm selftests and see no regressions, but I
> don't think there is anything in there specifically aimed towards swap? Are
> there any functional or performance tests that I should run? It would certainly
> be good to confirm I haven't regressed PMD-size THP swap performance.

I have used swap sub test case of vm-scalbility to test.

https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/

--
Best Regards,
Huang, Ying
