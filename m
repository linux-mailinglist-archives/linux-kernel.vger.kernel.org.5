Return-Path: <linux-kernel+bounces-111956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B90887335
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E5E284694
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCF67C68;
	Fri, 22 Mar 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caZM4pUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193067C4B;
	Fri, 22 Mar 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132359; cv=none; b=q8hmYnIgYdsIRrFQnFis9Qt+5fS0jf7qjKS+DO8WldmXQdRiSRQAXpAv4/RMDcUV3NeSIA7GijG48hHnZ1N9exMwJH6BWZ8FMIGVKkva8A26Nt2yqq5xYnRWdtLzc1vUM5nfah4Wu4XWAPkJaWOs6HPcal9RtW+SzOvSgnJNyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132359; c=relaxed/simple;
	bh=6SWXGlKDcni+o9A1KIXPMHnZZssK4+07jre7CJqb0HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PyIS+HXBGS8cWEZtGx4k5HPn5Q7Dvk/VM+w1BEc7UMEOtVOL1N05qo6YJZywdgBgZR4aC0hnkMiYAfTUYV1mry69cgcxcpFOT+lB8nmcU4y4iqFWIc3Ri8MFoqGn73DoIbqN9+KpcFkL/vCv5oFftQIIrr+AJT9B1gjIeskv8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caZM4pUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1A8C433F1;
	Fri, 22 Mar 2024 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132359;
	bh=6SWXGlKDcni+o9A1KIXPMHnZZssK4+07jre7CJqb0HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caZM4pUzav/IALH0ueXGMSPVTfyvm5fkplU8Myaz7iupAt99u5iOjn76V9XPeEVAh
	 lNj7n9/y8AnZc8pSdYVOh4CjqNc9lybEpQ6qLPKJH4Tp3VU6SeQqhvKPuACEOtjJbq
	 ajG7PnI3J7R9MfOURAr4w/RBG+OqhNmGXdR0hn37hNe73Ms9Nh7DtrTsign8O1bCOF
	 dWw1eczGBZjwle2nDWN+3m41KUKQXVE+ceyW2oXcc8FnGug76az1Z/A6HYK3IX1QU7
	 Hfzbr2JNssL02Ea9At5e2rRQ4synzIQnLwiXEIpK/08gcjHQuoej7fd6xMMtorW8EN
	 FYLWc3m+NX/Ug==
From: SeongJae Park <sj@kernel.org>
To: "Prasad, Aravinda" <aravinda.prasad@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"s2322819@ed.ac.uk" <s2322819@ed.ac.uk>,
	"Kumar, Sandeep4" <sandeep4.kumar@intel.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Subramoney, Sreenivas" <sreenivas.subramoney@intel.com>,
	"Kervinen, Antti" <antti.kervinen@intel.com>,
	"Kanevskiy, Alexander" <alexander.kanevskiy@intel.com>
Subject: RE: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Date: Fri, 22 Mar 2024 11:32:36 -0700
Message-Id: <20240322183236.119419-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <MW5PR11MB5907D17C1EBC1869C553256DF2312@MW5PR11MB5907.namprd11.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 12:12:09 +0000 "Prasad, Aravinda" <aravinda.prasad@intel.com> wrote:

[...] 
> > > For large regions (say 10GB, that has 2,621,440 4K pages), sampling at
> > > PTE level will not cover a good portion of the region. For example,
> > > default 5ms sampling and 100ms aggregation samples only 20 4K pages in an
> > > aggregation interval.
> > 
> > If the 20 attempts all failed at finding any single accessed 4K page, I think it
> > roughly means less than 5% of the region is accessed within the user-specified
> > time (aggregation interval).  I would translate that as only tiny portion of the

I now find the above sentence is not correct.  Sorry, my bad.  Let me re-write.

I think it roughly means the workload is not accessing the region in a
frequency that high enough for DAMON to observe within the user-specified time
(sampling interval).

> > region is accessed within the user-specified time, and hence DAMON is ok to say
> > the region is nearly not accessed.
> 
> I am looking at it from the other way:
> 
> To detect if a region is hot or cold at least 1% of the pages in the region should
> be sampled. For a 10GB region (with 2,621,440 4K pages) this requires sampling
> at least 26,214 pages. For a 100GB region this will require sampling at least
> 262,144 pages.

Why do you think 1% of the pages should be sampled?

DAMON defines the region as an address range that contains pages having similar
access frequency.  Hence if we see a page was accessed within a given time
interval, we can assume all pages in the page is also accessed within the
interval, and vice versa.  That's why we sample only single page per region,
and how DAMON's monitoring overhead can be controlled regardless of the size of
the monitoring target memory.

To detect if the region is hot or cold, DAMON continues sampling multiple times
and use number of sampling intervals that seen the access to the region
(nr_accesses) as the relative hotness of the region.  Hence, how many sampling
is required depends on what precision of the relative hotness the user wants.
The size of the region doesn't matter here.

Am I missing something?

> 
> If we sample at 5ms, this takes 131.072 seconds to cover 1% of 10GB and 1310.72
> seconds to cover 100GB. 
> 
> DAMON shows that the selected page as accessed if that page was accessed
> during the 5ms sampling window. Now if we increase the sampling to 20ms to
> improve access detection, then covering 1% of the region takes even longer.
> 
> > 
> > > Increasing sampling to 1 ms and aggregation to 1 second can only cover
> > > 1000 4K pages, but results in higher CPU overheads due to frequent sampling.
> > > Even increasing the aggregation interval to 60 seconds but sampling at
> > > 5ms can only cover 12000 samples, but region splitting and merging
> > > happens once in 60 seconds.
> > 
> > At the beginning of each sampling interval, DAMON randomly picks one page per
> > region, clear their accessed bits, wait until the sampling interval is finished, and
> > check the accessed bits again.  In other words, DAMON shows only accesses that
> > made in last sampling interval.
> 
> Yes, I see this in the code:
> 
> while(time < aggregation_interval)
> {
>   clear_access_bit
>   sleep(sampling_time)
>   check_access_bit
> }
> 
> I would suggest this logic instead.
> 
> while(time < aggregation_interval)
> {
>   Number_of_samples = aggregation_interval / sampling_time;
> 
>   for (i = 0, I < number_of_samples; i++) 
>   {
>     clear_access_bit
>   } 
> 
>   sleep(aggregation_time)
> 
>   for (i = 0, I < number_of_samples; i++) 
>   {
>     check_access_bit
>   }
> }
> 
> This can help in better access detection. I am sure you would
> have already explored it.   

The way to detect the access in the region is implemented by each monitoring
operations set (vaddr, fvaddr, and paddr).  We could implement yet another
monitoring operations set with a new access detection method.  Nonetheless, I
think changing existing monitoring operations sets to use this suggestion while
keeping their concepts would be not easy.

> 
> > 
> > Increasing number of samples per aggregation interval can help DAMON knows
> > the access frequency of regions in finer granularity, but doesn't allow DAMON see
> > more accesses.  Rather than that, if the aggregation interval is fixed (reducing
> > sampling interval), DAMON can show even less amount of accesses.
> > 
> > What we need here is giving the workload longer sampling time so that the
> > workload can make access to a size of memory regions that large enough to be
> > found by DAMON.
> 
> But even with longer sampling time, we may miss the access. For example, 
> consider all the pages in the region are accessed sequentially. Now if DAMON samples
> a different page other than the page that is being accessed it will miss. Now even if we
> have longer sampling time it is possible that none of the accesses are detected.

If there was accesses to some pages of the region but unaccessed page has
picked as the sampling target, someone could say only a tiny portion of the
region is accessed, so we can treat the region as not accessed at all.  That's
at least what the monitoring operations set you use here ('vaddr') thinks.

[...]
> > Also, if we can allow large enough age, the random region split will eventually find
> > the small hot regions even without high level accessed bit hint.  Of course the hint
> > could help finding it earlier.  I think that was one of my comment on the first
> > version of this patch.
> 
> The problem is that a large region that is split is immediately merged as the split
> regions have access count zero.
> 
> We observe that large regions are never getting split at all due to this.

I understand this is a valid concern.  Especially because we currently split
each region into two sub-regions, finding small hot memory region in the middle
of a huge region could be challenging.  This concern has raised before DAMON
has merged into the mainline by Jonathan Cameron.  There was also a research
from my previous colleague saying incresing the sub-regions for each split
improves the accuracy.  Nonetheless, it increases overall number of regions and
hence increased the overhead.  And we didn't get real issue due to this from
the production so far, so we still keeping the old behavior.  I'm thinking
about a way to make this better.

That said, the real system would have more than the single region, and the
access pattern will be more dynamic.  It will cause the region to be merged and
split in more random and chaotic way.  Hence I think there is still a chance to
find the small hot portion eventually.  Also, the sampling regions are picked
randomly.  A page of the small hot portion will eventually picked as sampling
target, even multiple times, and at least reset the 'age' of the region.

I sometimes turn on DAMON to monitor entire physical address space (about 128
GiB) of my machine and run no active workload but just a few background
deamons.  So the system would have only small amount of accesses.  At the
beginning, the monitoring output shows all regions as not accessed (nr_accesses
0) and having same 'age'.  But as time goes by, the regions are still showing
no access (nr_accesses 0), but different ages and sizes.

Again, I'm not saying existing monitoring mechanism is perfect and optimum.  We
should continue optimizing it.  Nonetheless, the current accuracy is not
perfectly proved to be too awful to be used in real world.  I know at least a
few unnamed production usages of DAMON, and they didn't complained about
DAMON's accuracy so far.


Thanks,
SJ

> 
> Regards,
> Aravinda
[...]

