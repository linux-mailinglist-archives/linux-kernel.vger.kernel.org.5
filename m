Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6734577D478
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbjHOUnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbjHOUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:42:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BF91FFE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692132133; x=1723668133;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=exbiW8jhthhzTeNaTfGZ9rElvFKsApJ1bUdOpF1JaE8=;
  b=OhA4rK2LSu+uVZca3K63dqDG4nDxGNLDjWisX7NALYW3v6lQtYxwG0rm
   pUccwic/EhV532IxORoeQcuAfiN+A5/Vm+d4Q4ExP+oNGi3b1JI0NdR0+
   jLt0gW5Yr46X43a/NXQfzJLA+ADICMdJp9/meZghuBfDfMvS6z7XPbDF7
   3NC0O/H+UnH0YdkGIBsD4WkLY4vrJI0om5Zlx2Dn4TOOOqP3rwha5RX7o
   TkGsQEoZD+An+lu8BzdejAtd6daoJzQ3gN74P4Jr0OigJl+U2DMRUK75p
   1wdybd0ssBY5kSNoYZmQYBnEw1mLtS6pkyGsTt5oXvxHgeU0ZaowIWiXM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375142540"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="375142540"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 13:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1064574785"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="1064574785"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 13:41:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
        <20230802095346.87449-2-wangkefeng.wang@huawei.com>
        <ZMpKYfNWA/jNgEuL@casper.infradead.org>
        <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
        <ZMud3RreEpsvFKuA@casper.infradead.org>
        <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
        <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
        <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
        <871qg59cwd.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2E8CA295-CEA2-4093-8287-F68C3977A538@nvidia.com>
Date:   Wed, 16 Aug 2023 04:39:50 +0800
In-Reply-To: <2E8CA295-CEA2-4093-8287-F68C3977A538@nvidia.com> (Zi Yan's
        message of "Tue, 15 Aug 2023 09:49:06 -0400")
Message-ID: <87zg2s6nvt.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Zi Yan <ziy@nvidia.com> writes:

> On 14 Aug 2023, at 23:56, Huang, Ying wrote:
>
>> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
>>
>>> On 2023/8/4 10:42, Zi Yan wrote:
>>>> On 3 Aug 2023, at 21:45, Kefeng Wang wrote:
>>>>
>>>>> On 2023/8/3 20:30, Matthew Wilcox wrote:
>>>>>> On Thu, Aug 03, 2023 at 03:13:21PM +0800, Kefeng Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2023/8/2 20:21, Matthew Wilcox wrote:
>>>>>>>> On Wed, Aug 02, 2023 at 05:53:43PM +0800, Kefeng Wang wrote:
>>>>>>>>>     	err = -EACCES;
>>>>>>>>> -	if (page_mapcount(page) > 1 && !migrate_all)
>>>>>>>>> -		goto out_putpage;
>>>>>>>>> +	if (folio_estimated_sharers(folio) > 1 && !migrate_all)
>>>>>>>>> +		goto out_putfolio;
>>>>>>>>
>>>>>>>> I do not think this is the correct change.  Maybe leave this line
>>>>>>>> alone.
>>>>>>>
>>>>>>> Ok, I am aware of the discussion about this in other mail, will not
>>>>>>> change it(also the next two patch about this function), or wait the
>>>>>>> new work of David.
>>>>>>>>
>>>>>>>>> -	if (PageHuge(page)) {
>>>>>>>>> -		if (PageHead(page)) {
>>>>>>>>> -			isolated = isolate_hugetlb(page_folio(page), pagelist);
>>>>>>>>> +	if (folio_test_hugetlb(folio)) {
>>>>>>>>> +		if (folio_test_large(folio)) {
>>>>>>>>
>>>>>>>> This makes no sense when you read it.  All hugetlb folios are large,
>>>>>>>> by definition.  Think about what this code used to do, and what it
>>>>>>>> should be changed to.
>>>>>>>
>>>>>>> hugetlb folio is self large folio, will drop redundant check
>>>>>>
>>>>>> No, that's not the difference.  Keep thinking about it.  This is not
>>>>>> a mechanical translation!
>>>>>
>>>>>
>>>>>    if (PageHuge(page))  // page must be a hugetlb page
>>>>> 	if (PageHead(page)) // page must be a head page, not tail
>>>>>               isolate_hugetlb() // isolate the hugetlb page if head
>>>>>
>>>>> After using folio,
>>>>>
>>>>>    if (folio_test_hugetlb(folio)) // only check folio is hugetlb or not
>>>>>
>>>>> I don't check the page is head or not, since the follow_page could
>>>>> return a sub-page, so the check PageHead need be retained, right?
>>>> Right. It will prevent the kernel from trying to isolate the same
>>>> hugetlb page
>>>> twice when two pages are in the same hugetlb folio. But looking at the
>>>> code, if you try to isolate an already-isolated hugetlb folio, isolate_hugetlb()
>>>> would return false, no error would show up. But it changes err value
>>>> from -EACCES to -EBUSY and user will see a different page status than before.
>>>
>>>
>>> When check man[1], the current -EACCES is not right, -EBUSY is not
>>> precise but more suitable for this scenario,
>>>
>>>  	-EACCES
>>>               The page is mapped by multiple processes and can be moved
>>>               only if MPOL_MF_MOVE_ALL is specified.
>>>
>>>        -EBUSY The page is currently busy and cannot be moved.  Try again
>>>               later.  This occurs if a page is undergoing I/O or another
>>>               kernel subsystem is holding a reference to the page.
>>> 	-ENOENT
>>>               The page is not present.
>>>
>>>> I wonder why we do not have follow_folio() and returns -ENOENT error
>>>> pointer
>>>> when addr points to a non head page. It would make this patch more folio if
>>>> follow_folio() can be used in place of follow_page(). One caveat is that
>>>> user will see -ENOENT instead of -EACCES after this change.
>>>>
>>>
>>> -ENOENT is ok, but maybe the man need to be updated too.
>>>
>>>
>>> 	
>>> [1] https://man7.org/linux/man-pages/man2/move_pages.2.html
>>>
>>
>> I don't think -ENOENT is appropriate.  IIUC, -ENOENT means no need to
>> migrate.  Which isn't the case here apparently.
>
> Are you referring to a comment or the man page? The man page says
> -ENOENT means the page is not present. Or you think it also implies
> there is no need to migrate? If yes, we probably need to update the man
> page.

Is it possible that a page isn't present, but we need to migrate it?

--
Best Regards,
Huang, Ying
