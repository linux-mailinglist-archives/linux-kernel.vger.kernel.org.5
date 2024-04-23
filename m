Return-Path: <linux-kernel+bounces-155182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E18AE669
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329B61C21D66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2E12A14D;
	Tue, 23 Apr 2024 12:38:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4684DF7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875884; cv=none; b=UgKLwjNyEIj/WuvvKGRoDar7dS5Lh5iUuV7+dY91d0WIzCRra5Rrk37AEETJ7vDLLlc1qC/1bp2swIYDBkwb3WICRjfbvNCOpDAeXfNkON1QLvCbTSkFdBXuFRdZYfI5BnFRKxSsjFYK7IiyQMovkf9QW8uPUMDpmOzYwv6ZnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875884; c=relaxed/simple;
	bh=AY5JJeDJivKChvabexTUc3tK2jPNqYuOCFzaoJVLCUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDEWdeKrijfBES9Q7pSxtfkax8h/idcGhfIY40grsgS7igVFnteNk+pnJdGKo69Rvt972s1TNN5VEakbKqvqweU6WX3hZCDrsBiwhH6t5H/Bwdm5N6y8aPE1/FYHN1hS/qHFizoa74l+1Sm6+cHiW0OQVwRZRPN2Sqd+gTCdVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF022339;
	Tue, 23 Apr 2024 05:38:29 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18F043F7BD;
	Tue, 23 Apr 2024 05:37:58 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:37:56 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
	James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com,
	amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <ZierpCsSN7mr6Rka@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
 <ZiE8/oXyjBef2qTy@e133380.arm.com>
 <acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com>
 <94c3bfd0-e221-46c7-86c4-f0545e66f17d@amd.com>
 <4cf859be-294f-4db3-948c-a96b5457a10d@intel.com>
 <CALPaoCi6cd8=Kc6ozDok=s6koxvOH-vTDmaCxbichk_72e6auw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCi6cd8=Kc6ozDok=s6koxvOH-vTDmaCxbichk_72e6auw@mail.gmail.com>

On Mon, Apr 22, 2024 at 11:39:00AM -0700, Peter Newman wrote:
> Hi Dave,
> 
> On Mon, Apr 22, 2024 at 9:01 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
> >
> > Hi Babu and Dave,
> >
> > On 4/22/2024 6:51 AM, Moger, Babu wrote:
> > > On 4/19/24 23:06, Reinette Chatre wrote:
> > >>
> > >> [1] https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/
> > >
> > > Do you have any more feedback on this series. I have few feedbacks from
> > > Peter. I was planning to work on v4 of this series.
> > >
> >
> > Babu: It is difficult to start drilling into the implementation before there
> > is agreement on the interface. One reason you went through the effort of
> > the first few iterations was to accommodate Arm's use cases as we understand
> > it, but we need to hear from Arm if we are on the right track here.
> > I do hope that we will hear something in the next couple of weeks.
> >
> > Dave: Could you please check in if the interface introduced [1] is something
> > of interest to Arm? If it is not, we can proceed with the implementation without
> > trying to consider how Arm may use/need such an interface. If it is, could you
> > please let us know when we can expect feedback from Arm?
> 
> Because MPAM implementations typically expose an MSC for each DRAM
> channel, there is an alternate strategy we can use for the monitor
> scalability problem:
> 
> When a single DRAM MSC does not provide enough monitors to track all
> of the supported PARTID x PMG combinations simultaneously, the DRAM
> MSCs collectively may provide a sufficient number of monitors.
> Therefore, as long as the distribution of traffic among the DRAM
> channels is uniform (or predictably non-uniform), it's possible to
> estimate the total bandwidth with sufficient accuracy.
> 
> -Peter
> 

So you're suggesting that if (say) DRAM traffic is striped symmetrically
across N channels, and each has counters, then a counter matching
PARTID:PMG on just one channel should given an unbiased estimate of the
traffic from that group (with some sacrifice of precision, and assuming
the workload is non-pathological)?

I guess that could work, though this might work badly for some workloads
and might give a malicious workload a way to hide transactions from
monitoring if the placement of the counter is too fixed and/or
predictable.

Cheers
---Dave

