Return-Path: <linux-kernel+bounces-89989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30F86F8B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4124C1C20C08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA12CA4;
	Mon,  4 Mar 2024 02:51:30 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D319A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709520690; cv=none; b=SJqoylfm3Y85cSqkxZgUIIAZED+43VvKgS1QKWpkQGtR8lEJnfyYVEXHglTzJzBcKNfPVA5gmrUxg2VYXCbBFm9EmweFSiSgf9CrA1J+VDrXBmf/cLqT6OuWHDiP4wOEuCsG5c9EGts8uRdI0jM27vvzY1u4r/eRzT2x0+5ZzTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709520690; c=relaxed/simple;
	bh=6Tbm8y2Wwo2qrsir0NRImaQMZ2S9xaCq1taZ5ojmrKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuCLJJReMuKmxN/RXXgW3vZ47Sg8AAoxi4DacYyROm0MRiHC9QafO8e+HgYPaX1H3nqSVDbKTL02sGMxumwbmF5rr2UGbIAP7DSJoR+paDM5IAXO9YeL1UPha/r+FQdviM0Z2oKk/Ays5wfKWJLviUI1CisxqkwB0Fd4cDnK8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-d1-65e53727c477
Date: Mon, 4 Mar 2024 11:51:14 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [RESEND PATCH v8 0/8] Reduce TLB flushes by 94% by improving
 folio migration
Message-ID: <20240304025114.GB13332@system.software.com>
References: <20240226030613.22366-1-byungchul@sk.com>
 <20240229092810.GC64252@system.software.com>
 <54053f0d-024b-4064-8d82-235cc71b61f8@redhat.com>
 <87wmqmbxko.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmqmbxko.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsXC9ZZnka66+dNUg757ihZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugSvj
	0aK5bAXdUhUbtt1ibmBcK9LFyMkhIWAi8ebNSzYY+/u6qWA2i4CKxOs9P1lAbDYBdYkbN34y
	g9giAhoSnxYuZ+9i5OJgFvjLJNF1uI8VJCEsEC2xrGsKO4jNK2AhsW5BPxNIkZDAGUaJx79v
	MUEkBCVOznwCNpVZQEvixr+XQHEOIFtaYvk/DpAwp4CdxI07m8FKRAWUJQ5sOw42R0JgHbvE
	zPmPGSEulZQ4uOIGywRGgVlIxs5CMnYWwtgFjMyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQJj
	cVntn+gdjJ8uBB9iFOBgVOLhzeh8kirEmlhWXJl7iFGCg1lJhLfmF1CINyWxsiq1KD++qDQn
	tfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDo9xdvSjJ5rjSh1/NuF/n+0Uoqzb/
	W/iUwUis6szUd1unMU+PSHniwZ7Ayhz+QSDmxrp3kRGf/S7HNraorgp9sa1hq7TF7gXiCxZr
	v77nlKQ3c/ZumbomFoPjNqEW4rNPv5jCY1p0uJOJ8/iNCf6mZtpBrBefcHbb2kTozc/PbJ9i
	dpWXT+y2EktxRqKhFnNRcSIAjCDitMECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsXC5WfdrKtu/jTVoPkgv8Wc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mh4tmstW0C1VsWHbLeYGxrUiXYycHBICJhLf101lA7FZBFQkXu/5yQJiswmo
	S9y48ZMZxBYR0JD4tHA5excjFwezwF8mia7DfawgCWGBaIllXVPYQWxeAQuJdQv6mUCKhATO
	MEo8/n2LCSIhKHFy5hOwqcwCWhI3/r0EinMA2dISy/9xgIQ5BewkbtzZDFYiKqAscWDbcaYJ
	jLyzkHTPQtI9C6F7ASPzKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMDIWlb7Z+IOxi+X3Q8x
	CnAwKvHwTljzJFWINbGsuDL3EKMEB7OSCG/NL6AQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w
	1AQhgfTEktTs1NSC1CKYLBMHp1QDY0DovDbbgopH0yYYPRK8PqnV/eezV+9mX1O4b6pjUWf2
	uzlBxk3ATKTObUnS1JSSFSa3QlOWzFhU0sqtdzXgyMpwQ6Om+UdSP3D8Chf9znZ+RVnltHsp
	9V89lwvcO9x1oL5/RYfezrUHD2Tcu7KJRbLts9rL3n8TJ1bYMZucTfC6M/PmUYeyW0osxRmJ
	hlrMRcWJAPKgIrKoAgAA
X-CFilter-Loop: Reflected

On Fri, Mar 01, 2024 at 08:33:11AM +0800, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
> > On 29.02.24 10:28, Byungchul Park wrote:
> >> On Mon, Feb 26, 2024 at 12:06:05PM +0900, Byungchul Park wrote:
> >>> Hi everyone,
> >>>
> >>> While I'm working with a tiered memory system e.g. CXL memory, I have
> >>> been facing migration overhead esp. TLB shootdown on promotion or
> >>> demotion between different tiers. Yeah.. most TLB shootdowns on
> >>> migration through hinting fault can be avoided thanks to Huang Ying's
> >>> work, commit 4d4b6d66db ("mm,unmap: avoid flushing TLB in batch if PTE
> >>> is inaccessible"). See the following link:
> >>>
> >>> https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> >>>
> >>> However, it's only for ones using hinting fault. I thought it'd be much
> >>> better if we have a general mechanism to reduce the number of TLB
> >>> flushes and TLB misses, that we can ultimately apply to any type of
> >>> migration, I tried it only for tiering for now tho.
> >>>
> >>> I'm suggesting a mechanism called MIGRC that stands for 'Migration Read
> >>> Copy', to reduce TLB flushes by keeping source and destination of folios
> >>> participated in the migrations until all TLB flushes required are done,
> >>> only if those folios are not mapped with write permission PTE entries.
> >>>
> >>> To achieve that:
> >>>
> >>>     1. For the folios that map only to non-writable TLB entries, prevent
> >>>        TLB flush at migration by keeping both source and destination
> >>>        folios, which will be handled later at a better time.
> >>>
> >>>     2. When any non-writable TLB entry changes to writable e.g. through
> >>>        fault handler, give up migrc mechanism so as to perform TLB flush
> >>>        required right away.
> >>>
> >>> I observed a big improvement of TLB flushes # and TLB misses # at the
> >>> following evaluation using XSBench like:
> >>>
> >>>     1. itlb flush was reduced by 93.9%.
> >>>     2. dtlb thread was reduced by 43.5%.
> >>>     3. stlb flush was reduced by 24.9%.
> >> Hi guys,
> >
> > Hi,
> >
> >> The TLB flush reduction is 25% ~ 94%, IMO, it's unbelievable.
> >
> > Can't we find at least one benchmark that shows an actual improvement
> > on some system?
> >
> > Staring at the number TLB flushes is nice, but if it does not affect
> > actual performance of at least one benchmark why do we even care?
> >
> > "12 files changed, 597 insertions(+), 59 deletions(-)"
> >
> > is not negligible and needs proper review.
> 
> And, the TLB flush is reduced at cost of memory wastage.  The old pages
> could have been freed.  That may cause regression for some workloads.

You seem to understand the key of migrc(migation read copy) :) Yeah, the
most important thing to deal with is to remove the 'memory wastage'. The
pages deferred to free for the optimization can be freed anytime when
it's needed though TLB flush required that would've been already flushed
unless migrc mechanism.

So memory wastage can be totally removed if resolving some technical
issues that might need your help :)

	Byungchul

> > That review needs motivation. The current numbers do not seem to be
> > motivating enough :)
> 
> --
> Best Regards,
> Huang, Ying

