Return-Path: <linux-kernel+bounces-110782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5C58863E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57060B21A31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E7B669;
	Thu, 21 Mar 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7C/EAKo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D238BFD;
	Thu, 21 Mar 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711062622; cv=none; b=YaISlXg/VynuceVZhAqqU08phz5Nbdn9nXLUCiXLdQ0AGhbaNNWbKcFR4XjDDKSeekHzwAsp2FK/COIJ1NO+ogHkNGiiDNwAFLaaAXqzn0thZbGA9AM1IuKvwt5+wBz6naAZVQgBcY6N8dllmA54UlVjbxl26TBCb1BQnTSQXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711062622; c=relaxed/simple;
	bh=Syj3VIsbBHyNODRuAcpAPAnpfPox+6CfQY/gUxvqRfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOBid51NvlsUO0ND2Vsrze2Fs0fk535TT/pbva2/bnhMnIJo/93MhlfeZPjiEBvXnYPLNRer1koekj/ATEDK2c2pc7vk1oZJgsDYrEZFlp9peXJaLlj9GBkwJqzwzMljTqAgIVkYX16/NYRj7nropg0hnwjdBN4YPirLg7Hdrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7C/EAKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EDDC433F1;
	Thu, 21 Mar 2024 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711062621;
	bh=Syj3VIsbBHyNODRuAcpAPAnpfPox+6CfQY/gUxvqRfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7C/EAKoe5psO3Rz+5pmEOOSZjeGKAu5uygqUpHmccnNhpXmVNkVtt0IDme9MgOj2
	 4AUD7d3EoYRG8pIVy4lG3LTnr8aLhG+WbVCzBxzFEmeVeHWuuRQaYh21BWw+Tg1ByY
	 Z3rS04HcTBw5X7TiYhGWy/IkZXJX4IZVUG9WUVUC53gYO94iQOBs2Tunx8U3AmX8aH
	 rOywz64c3KTxpk7s8RsvG1FouZ75uGrAKNPZTeueY0ZmAvYAvrPmtEMc0E5C0yGEGE
	 h4mKXHOsmWBMKWxaq88p4lH/tHlLV8WXLZQ/TkE6awIXp0ukoco8+xNdLWd2V10lmW
	 7QVfDJgXTSbuw==
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
Date: Thu, 21 Mar 2024 16:10:19 -0700
Message-Id: <20240321231019.81064-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <MW5PR11MB5907D65A7557AA1381B477B0F2332@MW5PR11MB5907.namprd11.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 12:31:17 +0000 "Prasad, Aravinda" <aravinda.prasad@intel.com> wrote:

> 
> 
> > -----Original Message-----
> > From: SeongJae Park <sj@kernel.org>
> > Sent: Tuesday, March 19, 2024 10:51 AM
> > To: Prasad, Aravinda <aravinda.prasad@intel.com>
> > Cc: damon@lists.linux.dev; linux-mm@kvack.org; sj@kernel.org; linux-
> > kernel@vger.kernel.org; s2322819@ed.ac.uk; Kumar, Sandeep4
> > <sandeep4.kumar@intel.com>; Huang, Ying <ying.huang@intel.com>; Hansen,
> > Dave <dave.hansen@intel.com>; Williams, Dan J <dan.j.williams@intel.com>;
> > Subramoney, Sreenivas <sreenivas.subramoney@intel.com>; Kervinen, Antti
> > <antti.kervinen@intel.com>; Kanevskiy, Alexander
> > <alexander.kanevskiy@intel.com>
> > Subject: Re: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
> > 
> > Hi Aravinda,
> > 
> > 
> > Thank you for posting this new revision!
> > 
> > I remember I told you that I don't see a high level significant problems on on the
> > reply to the previous revision of this patch[1], but I show a concern now.
> > Sorry for not raising this earlier, but let me explain my humble concerns before
> > being even more late.
> 
> Please find my comments below:
> 
> > 
> > On Mon, 18 Mar 2024 18:58:45 +0530 Aravinda Prasad
> > <aravinda.prasad@intel.com> wrote:
> > 
> > > DAMON randomly samples one or more pages in every region and tracks
> > > accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
> > > When the region size is large (e.g., several GBs), which is common for
> > > large footprint applications, detecting whether the region is accessed
> > > or not completely depends on whether the pages that are actively
> > > accessed in the region are picked during random sampling.
> > > If such pages are not picked for sampling, DAMON fails to identify the
> > > region as accessed. However, increasing the sampling rate or
> > > increasing the number of regions increases CPU overheads of kdamond.
> > 
> > DAMON uses sampling because it considers a region as accessed if a portion of
> > the region that big enough to be detected via sampling is all accessed.  If a region
> > is having some pages that really accessed but the proportion is too small to be
> > found via sampling, I think DAMON could say the overall access to the region is
> > only modest and could even be ignored.  In my humble opinion, this fits with the
> > definition of DAMON region: A memory address range that constructed with
> > pages having similar access frequency.
> 
> Agree that DAMON considers a region as accessed if a good portion of the region
> is accessed. But few points I would like to discuss:
> 
> For large regions (say 10GB, that has 2,621,440 4K pages), sampling at PTE level
> will not cover a good portion of the region. For example, default 5ms sampling
> and 100ms aggregation samples only 20 4K pages in an aggregation interval. 

If the 20 attempts all failed at finding any single accessed 4K page, I think
it roughly means less than 5% of the region is accessed within the
user-specified time (aggregation interval).  I would translate that as only
tiny portion of the region is accessed within the user-specified time, and
hence DAMON is ok to say the region is nearly not accessed.

> Increasing sampling to 1 ms and aggregation to 1 second can only cover 
> 1000 4K pages, but results in higher CPU overheads due to frequent sampling. 
> Even increasing the aggregation interval to 60 seconds but sampling at 5ms can
> only cover 12000 samples, but region splitting and merging happens once
> in 60 seconds.

At the beginning of each sampling interval, DAMON randomly picks one page per
region, clear their accessed bits, wait until the sampling interval is
finished, and check the accessed bits again.  In other words, DAMON shows only
accesses that made in last sampling interval.

Increasing number of samples per aggregation interval can help DAMON knows the
access frequency of regions in finer granularity, but doesn't allow DAMON see
more accesses.  Rather than that, if the aggregation interval is fixed
(reducing sampling interval), DAMON can show even less amount of accesses.

What we need here is giving the workload longer sampling time so that the
workload can make access to a size of memory regions that large enough to be
found by DAMON.

> 
> In addition, this worsens when region sizes are say 100GB+. We observe that
> sampling at PTE level does not help for large regions as more samples are
> are required. So, decreasing/increasing the sampling or aggressions intervals
> proportional to the region size is not practical as all regions are of not equal
> size, we can have 100GB regions as well as many small regions (e.g., 16KB
> to 1MB).

IMO, it becomes worse because the minimum size of accessed memory regions that
can be found by DAMON via sampling has increased together, while you didn't
give more sampling time (a.k.a the time to let the workload make accesses that
DAMON can show).

> So tuning sampling rate and aggregation interval did not help for large
> regions.

Due to the mechanism of the DAMON's sampling I mentioned above, I think this is
what expected.  We need to increase sampling interval.

> 
> It can also be observed that large regions cannot be avoided. Large regions
> are created by merging adjacent smaller regions or at the beginning of
> profiling (depending on min regions parameter which defaults to 10). 
> Increasing min region reduces the size of regions but increases kdamond
> overheads, hence, not preferable.
> 
> So, sampling at PTE level cannot precisely detect accesses to large regions
> resulting in inaccuracies, even though it works for small regions. 
> From our experiments, we found that with 10% hot data in a large region
> (80+GB regions in a 1TB+ footprint application), DAMON was not able to
> detect a single access to that region in 95+% cases with different sample
> and aggregation interval combinations. But DAMON works good for
> applications with footprint <50GB where regions are typically small.
> 
> Now consider the scenario with the proposed enhancement. With a
> 100GB region, if we sample a PUD entry that covers 1GB address
> space, then the default 5ms sampling and 100ms aggregation samples
> 20 PUD entries that is 20 GB portion of the region. This gives a good
> estimate of the portion of the region that is accessed. But the downside
> is that as PUD accessed bit is set even if a small set of pages are accessed
> under its subtree this can report more access as real as you noted.
> 
> But such large regions are split into two in the next aggregation interval. 
> As the splitting of the regions continues, in next few aggregation intervals
> many smaller regions are formed. Once smaller regions are formed,
> the proposed enhancement cannot pick higher levels of the page table
> tree and behaves as good as default DAMON. So, with the proposed
> enhancement, larger regions are quickly split into smaller regions if they
> have only small set of pages accessed.

I fully agree.  This is what could be a real and important benefits.

> 
> To avoid misinterpreting region access count, I feel that the "age" of the
> region is of real help and should be considered by both DAMON and the
> proposed enhancement. If the age of a region is small (<10) then that
> region should not be considered stable and hence should not be
> considered for any memory tiering decisions. For regions with age, 
> say >10, can be considered as stable as they reflect the actual access
> frequency.

I think this is a good approach, but difficult to be used by default.  I think
we might be able to get the benefit without making problem at the
over-reporting accesses by using the high level accessed bit check results as a
hint for better quality of region split?

Also, if we can allow large enough age, the random region split will eventually
find the small hot regions even without high level accessed bit hint.  Of
course the hint could help finding it earlier.  I think that was one of my
comment on the first version of this patch.

> 
> > 
> > >
> > > This patch proposes profiling different levels of the
> > > application\u2019s page table tree to detect whether a region is
> > > accessed or not. This patch set is based on the observation that, when
> > > the accessed bit for a page is set, the accessed bits at the higher
> > > levels of the page table tree (PMD/PUD/PGD) corresponding to the path
> > > of the page table walk are also set. Hence, it is efficient to check
> > > the accessed bits at the higher levels of the page table tree to
> > > detect whether a region is accessed or not. For example, if the access
> > > bit for a PUD entry is set, then one or more pages in the 1GB PUD
> > > subtree is accessed as each PUD entry covers 1GB mapping. Hence,
> > > instead of sampling thousands of 4K/2M pages to detect accesses in a
> > > large region, sampling at the higher level of page table tree is faster and
> > efficient.
> > 
> > Due to the above reason, I concern this could result in making DAMON monitoring
> > results be inaccurately biased to report more than real accesses.
> 
> DAMON, even without the proposed enhancement, can result in inaccuracies
> for large regions, (see examples above).

I think temporarily missing such tiny portion of accesses is not a critical
problem.  If this is a problem, the user should increase the sampling interval
in my opinion.  That said, as mentioned above, DAMON would better to improve
its regions split mechanism.

> 
> > 
> > >
> > > This patch set is based on 6.8-rc5 kernel (commit: f48159f8,
> > > mm-unstable
> > > tree)
> > >
> > > Changes since v1 [1]
> > > ====================
> > >
> > >  - Added support for 5-level page table tree
> > >  - Split the patch to mm infrastructure changes and DAMON enhancements
> > >  - Code changes as per comments on v1
> > >  - Added kerneldoc comments
> > >
> > > [1] https://lkml.org/lkml/2023/12/15/272
> > >
> > > Evaluation:
> > >
> > > - MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
> > >   and 5TB with 10GB hot data.
> > > - DAMON: 5ms sampling, 200ms aggregation interval. Rest all
> > >   parameters set to default value.
> > > - DAMON+PTP: Page table profiling applied to DAMON with the above
> > >   parameters.
> > >
> > > Profiling efficiency in detecting hot data:
> > >
> > > Footprint	1GB	10GB	100GB	5TB
> > > ---------------------------------------------
> > > DAMON		>90%	<50%	 ~0%	  0%
> > > DAMON+PTP	>90%	>90%	>90%	>90%
> > 
> > Sampling interval is the time interval that assumed to be large enough for the
> > workload to make meaningful amount of accesses within the interval.  Hence,
> > meaningful amount of sampling interval depends on the workload's characteristic
> > and system's memory bandwidth.
> > 
> > Here, the size of the hot memory region is about 100MB, 1GB, 10GB, and 10GB
> > for the four cases, respectively.  And you set the sampling interval as 5ms.  Let's
> > assume the system can access, say, 50 GB per second, and hence it could be able
> > to access only up to 250 MB per 5ms.  So, in case of 1GB and footprint, all hot
> > memory region would be accessed while DAMON is waiting for next sampling
> > interval.  Hence, DAMON would be able to see most accesses via sampling.  But
> > for 100GB footprint case, only 250MB / 10GB = about 2.5% of the hot memory
> > region would be accessed between the sampling interval.  DAMON cannot see
> > whole accesses, and hence the precision could be low.
> > 
> > I don't know exact memory bandwith of the system, but to detect the 10 GB hot
> > region with 5ms sampling interval, the system should be able to access 2GB
> > memory per millisecond, or about 2TB memory per second.  I think systems of
> > such memory bandwidth is not that common.
> > 
> > I show you also explored a configuration setting the aggregation interval higher.
> > But because each sampling checks only access between the sampling interval,
> > that might not help in this setup.  I'm wondering if you also explored increasing
> > sampling interval.
> >
> 
> What we have observed that many real-world benchmarks we experimented
> with do not saturate the memory bandwidth. We also experimented with
> masim microbenchmark to understand the impact on memory access rate
> (we inserted delay between memory access operations in do_rnd_ro() and
> other functions). We see decrease in the precision as access intensity is
> reduced. We have experimented with different sampling and aggregation
> intervals, but that did not help much in improving precision. 

Again, please note that DAMON can show only accesses made between each sampling
interval at a time.  The important factor for expectation of DAMON's accuracy
is, the balance between the memory access intensity of the workload, and the
length of the sampling interval.  The workload should be access intensive
enough to make sufficient amount of accesses between sampling interval.  The
sampling interval should be long enough to allow the workload makes sufficient
amount of accesses within the time interval.

The fact that the workloads were not saturating the memory bandwidth is not
enough to know if that means the workload was memory intensive enough, and the
sampling interval was long enough.

I was mentioning the memory bandwidth as only the maximum memory intensity of
the system that could be achieved.

> 
> So, what I think is it that most of the cases the precision depends on the page
> (hot or cold) that is randomly picked for sampling than the sampling rate. Most
> of the time only cold 4K pages are picked in a large region as they typically
> account for 90% of the pages in the region and hence DAMON does not
> detect any accesses at all. By profiling higher levels of the page table tree
> this can be improved.

Again, agreed.  This is an important and grateful finding.  Thank you.  And
again as mentioned above, I don't think we can merge this patch as is, but we
could think about using the high level access bit check results as a hint to
better split the regions.

Indeed, DAMON's monitoring mechanism has many rooms for improvements.  I also
have some ideas but my time was more spent on more capabilities of DAMON/DAMOS
so far.  It was a bit intentional proiority setting since I got no real DAMON
accuracy problem report from the production usage, and improving the accuracy
will deliver the benefit to all DAMON/DAMOS features.

Since an important milestone of DAMOS, namely auto-tuning, has merged into the
mainline, I think I may better to spend more time on monitoring accuracy
improvement.  I have some immature ideas in my head.  I will try to summarize
and share the ideas in near future.

>  
> > Sorry again for finding this concern not early enough.  But I think we may need to
> > discuss about this first.
> 
> Absolutely no problem. Please let me know your thoughts.

Thank you for patiently walking with me :)


Thanks,
SJ

> 
> Regards,
> Aravinda
> 
> > 
> > [1] https://lkml.kernel.org/r/20231215201159.73845-1-sj@kernel.org
> > 
> > 
> > Thanks,
> > SJ
> > 
> > 
> > >
> > > CPU overheads (in billion cycles) for kdamond:
> > >
> > > Footprint	1GB	10GB	100GB	5TB
> > > ---------------------------------------------
> > > DAMON		1.15	19.53	3.52	9.55
> > > DAMON+PTP	0.83	 3.20	1.27	2.55
> > >
> > > A detailed explanation and evaluation can be found in the arXiv paper:
> > > https://arxiv.org/pdf/2311.10275.pdf
> > >
> > >
> > > Aravinda Prasad (3):
> > >   mm/damon: mm infrastructure support
> > >   mm/damon: profiling enhancement
> > >   mm/damon: documentation updates
> > >
> > >  Documentation/mm/damon/design.rst |  42 ++++++
> > >  arch/x86/include/asm/pgtable.h    |  20 +++
> > >  arch/x86/mm/pgtable.c             |  28 +++-
> > >  include/linux/mmu_notifier.h      |  36 +++++
> > >  include/linux/pgtable.h           |  79 ++++++++++
> > >  mm/damon/vaddr.c                  | 233 ++++++++++++++++++++++++++++--
> > >  6 files changed, 424 insertions(+), 14 deletions(-)
> > >
> > > --
> > > 2.21.3

