Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168C87EA821
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjKNBON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKNBOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:14:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E5119B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699924449; x=1731460449;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oQJpuKDOhuR/4NqGomdXErid0IdxtIX2pZNk0d/K/XQ=;
  b=Ubc3wtQmYkJrOhLeGXTRsgiZm08IQaA0DJ8jBhJCHeLaQLcWEaW7R7ko
   WgdF/ZtnNcQMYeM14fxACrL3H/7G/hF4lOu6fABuWO6/uXn2twayTEaDx
   kw6VxuCJhn+9HcxbJ1XWg9tCoAnVTgcDcRY7eFmnP6v2hZT4+/Q3H45ar
   J4tngyRNy0nZAQ6hqwmfXyX0cudWXaISWZpeangpJG/VQYUIrMNfo4cAx
   fie5B0vNZZTGsm5UcTrYqhBt9Sx4s67qxEyMWVOx6MOieHBetVC31jJtd
   hmBpT4w8rLoKL3II22/aQVwGmToR1OyCXhWF6RVKrZSrIFLyaH1AkN9XL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="387704496"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="387704496"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 17:14:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="768080707"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="768080707"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 17:14:06 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
In-Reply-To: <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com> (David
        Hildenbrand's message of "Mon, 13 Nov 2023 11:53:12 +0100")
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
        <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
Date:   Tue, 14 Nov 2023 09:12:05 +0800
Message-ID: <871qctf89m.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 13.11.23 11:45, Baolin Wang wrote:
>> Currently, the file pages already support large folio, and supporting for
>> anonymous pages is also under discussion[1]. Moreover, the numa balancing
>> code are converted to use a folio by previous thread[2], and the migrate_pages
>> function also already supports the large folio migration.
>> So now I did not see any reason to continue restricting NUMA
>> balancing for
>> large folio.
>
> I recall John wanted to look into that. CCing him.
>
> I'll note that the "head page mapcount" heuristic to detect sharers will
> now strike on the PTE path and make us believe that a large folios is
> exclusive, although it isn't.

Even 4k folio may be shared by multiple processes/threads.  So, numa
balancing uses a multi-stage node selection algorithm (mostly
implemented in should_numa_migrate_memory()) to identify shared folios.
I think that the algorithm needs to be adjusted for PTE mapped large
folio for shared folios.

And, as a performance improvement patch, some performance data needs to
be provided.  And, the effect of shared folio detection needs to be
tested too.

--
Best Regards,
Huang, Ying
