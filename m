Return-Path: <linux-kernel+bounces-110886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D788653C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC2F1F24719
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4FB6FAE;
	Fri, 22 Mar 2024 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUOcvkMs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956364C79
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075301; cv=none; b=ODZazOSuqsA+hTRW1Xmb9wJFKtpX1/NGoEVtL1LCTUFFt9ksoWtpiTqPu2kkEsrx/pHZNZU6So2CLHluvvkbdqVZ9swIuFQL3iZFDFp9XEOY7ppXMIPxaHr9cEp7FLqb4sGPRxOWkDxH0T6Qv3tp2wSKQyh6TXNZ/eo6uSfI2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075301; c=relaxed/simple;
	bh=S+KJCnYbiOXWCaXB4wBl+59lZCLZQieFdwqcCOeL4J4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rqwZ6K6OnzR6MULjFCyfrLN4NXditqdknw7EtQJ1ve+gk0lR9eAbOs7g7y/pQD6HqUdWFVaPo8jcYgmRCNi70EEe5WbjesE2ddly/ToCynv59fLbHWG8dr0DGTMURHi77iB5iP8TLwwi+FK6zS5vdvazFvELtT/ORvUVIz9xiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUOcvkMs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711075299; x=1742611299;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=S+KJCnYbiOXWCaXB4wBl+59lZCLZQieFdwqcCOeL4J4=;
  b=AUOcvkMsBH0oU9KrtjQFPyAY4+RYxcWdtXQO8HRpCzViDpr5PM+KxrPC
   ey6W9RIGbGfSuoWFHSh8zEVYQVnCHVmNOQsmsjqvFjYtVZj9MzbHqSTGE
   /1GCHxsEhfzWXSEjq0As/AmJtbFqMWjjm9/Wp+Z8mp1HgzrZcZeTberKX
   rELn/9SMHFru4YSwVC+3L9dBP8niG3nEVpIgKVDsYY/v5k4j/xKaodVJE
   vjCXUKl34KgGRyjuyq1As5PMsk0F0xI+Lf4u+nivgMQAHekVtBZPEW0Io
   UoJpH0Fd3uT8nbk6j715Tb520XI7rU6jFArT2hUn6zQMU/6dEUgeoYOdW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17258335"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="17258335"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 19:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="19437709"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 19:41:36 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] mm: swap: Allow storage of all mTHP orders
In-Reply-To: <b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com> (Ryan Roberts's
	message of "Thu, 21 Mar 2024 12:21:46 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<20240311150058.1122862-5-ryan.roberts@arm.com>
	<87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com>
	<8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com>
Date: Fri, 22 Mar 2024 10:39:42 +0800
Message-ID: <87plvnq9ap.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 21/03/2024 04:39, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> Hi Huang, Ying,
>>>
>>>
>>> On 12/03/2024 07:51, Huang, Ying wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>> [...]
>>>
>>>>> @@ -905,17 +961,18 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>>>  	}
>>>>>  
>>>>>  	if (si->swap_map[offset]) {
>>>>> +		VM_WARN_ON(order > 0);
>>>>>  		unlock_cluster(ci);
>>>>>  		if (!n_ret)
>>>>>  			goto scan;
>>>>>  		else
>>>>>  			goto done;
>>>>>  	}
>>>>> -	WRITE_ONCE(si->swap_map[offset], usage);
>>>>> -	inc_cluster_info_page(si, si->cluster_info, offset);
>>>>> +	memset(si->swap_map + offset, usage, nr_pages);
>>>>
>>>> Add barrier() here corresponds to original WRITE_ONCE()?
>>>> unlock_cluster(ci) may be NOP for some swap devices.
>>>
>>> Looking at this a bit more closely, I'm not sure this is needed. Even if there
>>> is no cluster, the swap_info is still locked, so unlocking that will act as a
>>> barrier. There are a number of other callsites that memset(si->swap_map) without
>>> an explicit barrier and with the swap_info locked.
>>>
>>> Looking at the original commit that added the WRITE_ONCE() it was worried about
>>> a race with reading swap_map in _swap_info_get(). But that site is now annotated
>>> with a data_race(), which will suppress the warning. And I don't believe there
>>> are any places that read swap_map locklessly and depend upon observing ordering
>>> between it and other state? So I think the si unlock is sufficient?
>>>
>>> I'm not planning to add barrier() here. Let me know if you disagree.
>> 
>> swap_map[] may be read locklessly in swap_offset_available_and_locked()
>> in parallel.  IIUC, WRITE_ONCE() here is to make the writing take effect
>> as early as possible there.
>
> Afraid I'm not convinced by that argument; if it's racing, it's racing - the

It's not a race.

> lockless side needs to be robust (it is). Adding the compiler barrier limits the
> compiler's options which could lead to slower code in this path. If your
> argument is that you want to reduce the window where
> swap_offset_available_and_locked() could observe a free swap slot but then see
> that its taken after it gets the si lock, that seems like a micro-optimization
> to me, which we should avoid if we can.

Yes.  I think that it is a micro-optimization too.  I had thought that
it is a common practice to use WRITE_ONCE()/READ_ONCE() or barrier() in
intentional racy data accessing to make the change available as soon as
possible.  But I may be wrong here.

> By remnoving the WRITE_ONCE() and using memset, the lockless reader could
> observe tearing though. I don't think that should cause a problem (because
> everything is rechecked with under the lock), but if we want to avoid it, then
> perhaps we just need to loop over WRITE_ONCE() here instead of using memset?

IIUC, in practice that isn't necessary, because type of si->swap_map[]
is "unsigned char".  It isn't possible to tear "unsigned char".  In
theory, it may be better to use WRITE_ONCE() because we may change the
type of si->swap_map[] at some time (who knows).  I don't have a strong
opinion here.

>>>>> +	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>>>>>  	unlock_cluster(ci);

--
Best Regards,
Huang, Ying

