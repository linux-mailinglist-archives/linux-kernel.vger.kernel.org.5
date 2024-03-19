Return-Path: <linux-kernel+bounces-107741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED10388010A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F101F22AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA257CF03;
	Tue, 19 Mar 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsE+Dgj7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF22657D3;
	Tue, 19 Mar 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863282; cv=none; b=tu3JzoEpH8Rmus7298Via0HcFc8WBO6lUTS3RPqepvjcUEc8AnDDj9G44xTfySn59O2E0Pdt7Oa5j1wdOqmy8RxMa133z/AnIPbWhHqPIStvKdg4TOQPB/tuiXQFR06grCuC5/gqzgXPm7VbkiEf5ipsWkqu2Fk/mX4bAtJPN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863282; c=relaxed/simple;
	bh=eHlATGPtHi4Dvca5jjoXEJntrvdbTpLgFF3K6HWMAzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndYwGMDp0HzAOTnFpzCckyNv8OewHm0DM3Cw9KaLQTqzqYZ27DEUV5CtfX4mEBZF8wutRC0Pr6D5xqpfO8AK/MQ7RsCo2gjf3MIgjOI19ZOEIdvWT2d+OBGUX5Z6Czmg8b5GflO6W7kUzHIZtfMKpD22gCucfU955m7P4PRKqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsE+Dgj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11012C433F1;
	Tue, 19 Mar 2024 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710863281;
	bh=eHlATGPtHi4Dvca5jjoXEJntrvdbTpLgFF3K6HWMAzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsE+Dgj7KK5X9edOigr2E9e0soVH+z1IP9FfEPEuF2WC5aZzxXt8QUODUToTIwdWA
	 TSPeAV/m5dgZiwVBZy90MnQQ2RNSdiLA9yaPtSRLQQzU/AEWAjcxcwKcbbDoyGTlZK
	 GlXC/lllWrTuWCvXbilzgE3r129QA0y2Ob7DGXN6uNylVU3NeQXDJG0X0KfRK+QUb6
	 aMnjD5FMNGWA6xhWtzJTEi1l6tzWDhvUgfNzAuh8dwlu7zkFCLYRQxJgBxm+aQSzgZ
	 M+2Zsx5jNwi40c3wns11IgtOBLZK93TYDsR5ys30AHgc6wbRIscvljvw1d+riJF9Kh
	 oCF7zuBJr3/Yw==
Date: Tue, 19 Mar 2024 15:47:56 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tyler Hicks <code@tyhicks.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <20240319154756.GB2901@willie-the-truck>
References: <ZfKsAIt8RY/JcL/V@sequoia>
 <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 19, 2024 at 12:57:52PM +0000, Robin Murphy wrote:
> On 2024-03-14 7:06 pm, Tyler Hicks wrote:
> > On 2024-03-14 09:55:46, Tyler Hicks wrote:
> > > Given that drivers are only optionally asked to implement the .shutdown
> > > hook, which is required to properly quiesce devices before a kexec, why
> > > is it that we put the ARM SMMU v1/v2 into bypass mode in the arm-smmu
> > > driver's own .shutdown hook?
> > > 
> > >   arm_smmu_device_shutdown() -> set SMMU_sCR0.CLIENTPD bit to 1
> > > 
> > > Driver authors often forget to even implement a .shutdown hook, which
> > > results in some hard-to-debug memory corruption issues in the kexec'ed
> > > target kernel due to pending DMA operations happening on untranslated
> > > addresses. Why not leave the SMMU in translate mode but clear the stream
> > > mapping table (or maybe even call arm_smmu_device_reset()) in the SMMU's
> > > .shutdown hook to prevent the memory corruption from happening in the
> > > first place?
> > > 
> > > Fully acknowledging that the proper fix is to quiesce the devices, I
> > > feel like resetting the SMMU and leaving it in translate mode across
> > > kexec would be more consistent with the intent behind v5.2 commit
> > > 954a03be033c ("iommu/arm-smmu: Break insecure users by disabling bypass
> > > by default"). The incoming transactions of devices, that weren't
> > > properly quiesced during a kexec, would be blocked until their drivers
> > > have a chance to reinitialize the devices in the new kernel.
> > > 
> > > I appreciate any help understanding why bypass mode is utilized here as
> > > I'm sure there are nuances that I haven't considered. Thank you!
> > 
> > I now see that Will has previously mentioned that he'd be open to such a
> > change:
> > 
> >   One thing I would be in favour of is changing the ->shutdown() code to
> >   honour disable_bypass=1 so that we put the SMMU in an aborting state
> >   instead of passthrough. Would that help at all? It would at least
> >   avoid the memory corruption on missing shutdown callback.
> > 
> >   - https://lore.kernel.org/linux-arm-kernel/20200608113852.GA3108@willie-the-truck/
> > 
> > Robin mentions the need to support kexec into a non-SMMU-aware OS. I
> > hadn't considered that bit of complexity:
> > 
> >   ... consider if the first kernel *did* leave it enabled with whatever
> >   left-over translations in place, and kexec'ed into another OS that
> >   wasn't SMMU-aware...
> > 
> >   - https://lore.kernel.org/linux-arm-kernel/e072f61a-d6cf-2e34-efd5-c1db38c5c622@arm.com/
> > 
> > Now that we're 3-4 years removed from that conversation, has anything
> > changed? Will, is there anything we'd need to watch out for if we were
> > to prototype this sort of change? For example, would it be wise to
> > disable fault interrupts when putting the SMMU in an aborting state
> > before kexec'ing?

I've grown older and wiser in those four years and no longer think that's
a good idea :) Well, older maybe, but the reality is that the code around
the driver has evolved and 'disable_bypass' is even more of a hack now
than it used to be.

> Fundamentally, we expect the SMMU to be disabled at initial boot, so per the
> intent of kexec we put it back in that state. That also seems the most
> likely expectation of anything we could kexec into, given that it is the
> natural state of an untouched SMMU after a hard reset, and thus comes out as
> the least-worst option.

Heh, that sounded too good to be true when I read it so I went and looked at
the code:

SMMUv3: arm_smmu_device_shutdown() -> clears CR0 but doesn't touch GBPA
SMMUv2: arm_smmu_device_shutdown() -> writes CLIENTPD to CR0

So it's a bit of a muddle afaict; SMMUv2 explicitly goes into bypass
whereas SMMUv3 probably does honour disable_bypass=false! Did I miss
something?

As discussed elsewhere, if we remove disable_bypass from SMMUv3, then
we should be able to be consistent here. The question is, what's the
right behaviour?

> Beyond properly quiescing and resetting the system back to a boot-time
> state, the outgoing kernel in a kexec can only really do things which affect
> itself. Sure, we *could* configure the SMMU to block all traffic and disable
> the interrupt to avoid getting stuck in a storm of faults on the way out,
> but what does that mean for the incoming kexec payload? That it can have the
> pleasure of discovering the SMMU, innocently enabling the interrupt and
> getting stuck in an unexpected storm of faults. Or perhaps just resetting
> the SMMU into a disabled state and thus still unwittingly allowing its
> memory to be corrupted by the previous kernel not supporting kexec properly.

Right, it's hard to win if DMA-active devices weren't quiesced properly
by the outgoing kernel. Either the SMMU was left in abort (leading to the
problems you list above) or the SMMU is left in bypass (leading to possible
data corruption). Which is better?

The best solution is obviously to implement those missing ->shutdown()
callbacks.

Will

