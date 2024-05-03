Return-Path: <linux-kernel+bounces-167978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D48BB1D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEABB282503
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052E157E94;
	Fri,  3 May 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mHMQO7jY"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965541EA87
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757276; cv=none; b=HrOTPlt/j6rEyds7KU02bJJpIgoUbMUatqKQ0fzS/GgvRHQbPkD6m2vwf5pao6NcEvr90lRIipXF3GqmVYM5MJ/gov7QvR4tvO2Q4d0BoPBSp2S9Id2IxXFI4q5vsHrjYLAWaY5DscrZrHz5cdtv9txt9OLTCa1MhczBuNLsjdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757276; c=relaxed/simple;
	bh=MzVRkJJP4OxlhoqjyGDk0Zxm3Rguu8M4TsLwAGKFTqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqsXcXaVeuRtmkpA4GZ440WpXrqHFmACCtPZ+aOpmUexqCuZPJ0BPYECWoT0YPnOS0KNnaQAFTC7FzGS/FwNASWeDICnsRa7SXnB1onyG2Q+gAOgZjvNrKntAlqU3Qsdp5zOKn35x7GX1qTM9R+oEPK6FLLugw39nU+JQPXY4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mHMQO7jY; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 10:27:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714757272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lkfu3aF+7HSJzFb8vZvf6vy1XzKC3Kd7KishD/IFflc=;
	b=mHMQO7jYaWPMY18NmrUK8fAqCVXI7qF4CkWacUl9C0Or8849Sy9zAPd3M1EMMYQaI1Y5Wd
	SeKkHoPnEit66IrkLwSh5a9vSFVOr1k16rIsw93G2F/JFeJ9FQ2A/WDr9XEEMS+gaIUfw1
	dXM/tFBCitSpWg2X06mM2ERTLPNLGs8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: Sebastian Ott <sebott@redhat.com>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/6] KVM: arm64: add emulation for CTR_EL0 register
Message-ID: <ZjUekqVOwCWMAKdE@linux.dev>
References: <20240426104950.7382-1-sebott@redhat.com>
 <20240426104950.7382-5-sebott@redhat.com>
 <ZjH6DcedmJsAb6vw@linux.dev>
 <861q6irj2t.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861q6irj2t.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, May 03, 2024 at 04:50:02PM +0100, Marc Zyngier wrote:
> > Marc, I know this goes against what you had suggested earlier, is there
> > something in particular that you think warrants the consistency
> > checks?
> 
> The problem is that we have a dependency chain: individual cache
> levels are validated against CLIDR/CCSIDR, which are themselves
> validated against CTR_EL0.
> 
> Change one, and everything becomes inconsistent. I absolutely don't
> trust userspace to do a good job on that

Violent agreement on this point, heh. 

> and not validating this will result in extremely hard to debug issues
> in the guest. Which is why CTR_EL0 was an invariant the first place,
> and everything derived from it.

Sure, but userspace can completely hose the guest in tons of spectacular
ways, I don't see why feature ID registers require thorough
cross-checking of relationships between CPU features.

We already fail at this. Just looking at ID_AA64ISAR0_EL1, we do not
enforce any of the "FEAT_X implies FEAT_Y" relationships between all of
the crypto extensions. Userspace can also setup ID_AA64MMFR0_EL1 to
advertise that no translation granule is supported by the MMU.

I agree that KVM needs to sanitize feature ID registers against the
capabilities of hardware + KVM itself. Beyond that cross-checking
userspace against itself is difficult to get right, and I'm worried
about what the tangled mess will look like when we finish up the
plumbing for the whole feature ID space.

> Take for example CLIDR_EL1.Lo{UU,UIS,C}. Their values depend on
> CTR_EL0.{IDC,DIC}. SW is free to check one or the other. If you don't
> have this dependency, you're in for some serious trouble.

Right, we absolutely need to sanitize these against *hardware*, and
using CTR_EL0 definitely the way to go. Userspace cannot promise a
stricter cache coherency model than what's offered in hardware.

Making sure userspace's values for CLIDR_EL1 and CTR_EL0 agree with each
other shouldn't matter if we've determined hardware coherency is at least
as strict as the model described through these registers.

Without the cross-check, it would be possible for userspace to setup the
vCPU as:

 - CTR_EL0.{IDC,DIC} = {1, 1}
 - CLIDR_EL1.Lo{UU,UIS,C} = {1, 1, 1}

But we would only allow this if hardware was {IDC,DIC} = {1,1}. So while
the values presented to the guest aren't consistent with one another, it
seems in the worst case the guest will do I$ maintenance where it isn't
actually necessary.

-- 
Thanks,
Oliver

