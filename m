Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7B7C4985
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJKF6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKF6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:58:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF45094
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697003890; x=1728539890;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=YahCY+6RxGW3/ZhuVqv5IVUbfCdBvQEtjngAOeCRTzU=;
  b=PppmZkFL5haLNf41N7y8XzQNaHlaByPs8PK2i+DKIssFnIO2pTRcIshR
   mgFjFy2WmsFCehT0V5tW0DcwSTqY+MQYd2EOpAkTCHIsevQF5dBrmgClm
   vw+th7kXVUsr5PYpeuRsazJ7W/XjtifT9u9WDqW01wQNxWeVj9PfmiQWF
   eTK9UcJFmmWqnplA1nDRvcNZquwS3fsr4USmgElxU8TefvcB4jrsf4Hmz
   d5ByqV3xXXZ0OaoEkB0WzVw30E08vVRgyFfIzqG7tlBy278wZgWnCI7LS
   zqf/tfaHsIP4i4bHBx/MZkVtDpASH7CEn34DzVXi+xcyjpq3IJ3kKwjiv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451079943"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451079943"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 22:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000977399"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1000977399"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 22:57:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH -next 1/7] mm_types: add _last_cpupid into folio
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
        <20231010064544.4162286-2-wangkefeng.wang@huawei.com>
        <ZSVEmhPCjZKyp97a@casper.infradead.org>
        <3b56b26b-a550-4e06-b355-55564b40cfb5@huawei.com>
Date:   Wed, 11 Oct 2023 13:55:05 +0800
In-Reply-To: <3b56b26b-a550-4e06-b355-55564b40cfb5@huawei.com> (Kefeng Wang's
        message of "Wed, 11 Oct 2023 11:02:13 +0800")
Message-ID: <874jixhfeu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> On 2023/10/10 20:33, Matthew Wilcox wrote:
>> On Tue, Oct 10, 2023 at 02:45:38PM +0800, Kefeng Wang wrote:
>>> At present, only arc/sparc/m68k define WANT_PAGE_VIRTUAL, both of
>>> them don't support numa balancing, and the page struct is aligned
>>> to _struct_page_alignment, it is safe to move _last_cpupid before
>>> 'virtual' in page, meanwhile, add it into folio, which make us to
>>> use folio->_last_cpupid directly.
>> What do you mean by "safe"?  I think you mean "Does not increase the
>> size of struct page", but if that is what you mean, why not just say so?
>> If there's something else you mean, please explain.
>
> Don't increase size of struct page and don't impact the real order of
> struct page as the above three archs without numa balancing support.
>
>> In any event, I'd like to see some reasoning that _last_cpupid is
>> actually
>> information which is logically maintained on a per-allocation basis,
>> not a per-page basis (I think this is true, but I honestly don't know)
>
> The _last_cpupid is updated in should_numa_migrate_memory() from numa
> fault(do_numa_page, and do_huge_pmd_numa_page), it is per-page(normal
> page and PMD-mapped page). Maybe I misunderstand your mean, please
> correct me.

Because PTE mapped THP will not be migrated according to comments and
folio_test_large() test in do_numa_page().  Only _last_cpuid of the head
page will be used (that is, on per-allocation basis).  Although in
change_pte_range() in mprotect.c, _last_cpuid of tail pages may be
changed, they are not used actually.  All in all, _last_cpuid is on
per-allocation basis for now.

In the future, it's hard to say.  PTE-mapped THPs or large folios give
us an opportunity to check whether the different parts of a folio are
accessed by multiple sockets, so that we should split the folio.  But
this is just some possibility in the future.

--
Best Regards,
Huang, Ying
