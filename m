Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEBF7EBB61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjKODAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbjKODAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:00:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C08E1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700017240; x=1731553240;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0ABMAvlua1+dMNScNiJgwLMEsJzQQD0nYg82pujlRYY=;
  b=ISnSwe6l9eSX2n0szcUMw/6qwE29FiW83LltCXxWMfPa+K4uHFMxIV89
   /jJfOVAC4dRv+5hhWNq65lifrIdutahtZxLhSQHyxNiwvnCU6ZkgqCgB0
   8TbJePnxfsgdZjgfqYPgGca1Nl4nmiM4zcHqtjMKIiNyjXkrCjXNorHHe
   E2XHrLjcC4ncUP9Cw4BWlXQkcvi1ejpB7jeBWUkZ2NYSxC73jgpqFA1yX
   m3GQMhvb45prxVvVOhV7/kzZeCowWoz5oaanDCZGahWhPPjyGsA57BN/A
   RgC3N4Dkh57fqYM/1QB0CsDwoBhpDzFR4+i4qYdWHnKEiNM1/PhDygxTC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394714510"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="394714510"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 19:00:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012127430"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="1012127430"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 19:00:35 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
In-Reply-To: <f22001bb-e474-4ddb-8440-2668e6cec000@linux.alibaba.com> (Baolin
        Wang's message of "Tue, 14 Nov 2023 19:11:56 +0800")
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
        <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
        <871qctf89m.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <f22001bb-e474-4ddb-8440-2668e6cec000@linux.alibaba.com>
Date:   Wed, 15 Nov 2023 10:58:32 +0800
Message-ID: <87sf57en8n.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 11/14/2023 9:12 AM, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 13.11.23 11:45, Baolin Wang wrote:
>>>> Currently, the file pages already support large folio, and supporting for
>>>> anonymous pages is also under discussion[1]. Moreover, the numa balancing
>>>> code are converted to use a folio by previous thread[2], and the migrate_pages
>>>> function also already supports the large folio migration.
>>>> So now I did not see any reason to continue restricting NUMA
>>>> balancing for
>>>> large folio.
>>>
>>> I recall John wanted to look into that. CCing him.
>>>
>>> I'll note that the "head page mapcount" heuristic to detect sharers will
>>> now strike on the PTE path and make us believe that a large folios is
>>> exclusive, although it isn't.
>> Even 4k folio may be shared by multiple processes/threads.  So, numa
>> balancing uses a multi-stage node selection algorithm (mostly
>> implemented in should_numa_migrate_memory()) to identify shared folios.
>> I think that the algorithm needs to be adjusted for PTE mapped large
>> folio for shared folios.
>
> Not sure I get you here. In should_numa_migrate_memory(), it will use
> last CPU id, last PID and group numa faults to determine if this page
> can be migrated to the target node. So for large folio, a precise
> folio sharers check can make the numa faults of a group more accurate,
> which is enough for should_numa_migrate_memory() to make a decision?

A large folio that is mapped by multiple process may be accessed by one
remote NUMA node, so we still want to migrate it.  A large folio that is
mapped by one process but accessed by multiple threads on multiple NUMA
node may be not migrated.

> Could you provide a more detailed description of the algorithm you
> would like to change for large folio? Thanks.

I haven't thought about that thoroughly.  So, please evaluate the
algorithm by yourself.

For example, the 2 sub-pages of a shared PTE-mapped large folio may be
accessed together by a task.  This may cause the folio be migrated
wrongly.  One possible solution is to restore all other PTE mappings of
the large folio in do_numa_page() as the first step.  This resembles the
PMD-mapped THP behavior.

>> And, as a performance improvement patch, some performance data needs to
>
> Do you have some benchmark recommendation? I know the the autonuma can
> not support large folio now.

There are autonuma-benchmark, and specjbb is used by someone before.

>> be provided.  And, the effect of shared folio detection needs to be
>> tested too

--
Best Regards,
Huang, Ying
