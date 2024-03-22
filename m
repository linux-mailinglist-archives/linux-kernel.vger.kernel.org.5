Return-Path: <linux-kernel+bounces-111746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785888704F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A5E2817AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6041656B78;
	Fri, 22 Mar 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/dUuBgB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCE5A0E3;
	Fri, 22 Mar 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123606; cv=none; b=cMpu6YyNnQpaSnUazhTQ49mHDyRTsGpkvyHt9CxsmqDfIQBKy5N8glIEG3gmPhZptRFaBs5dGLFMuhIBmq4XT/9f+DgFRr8g9AKhn4ZzUQ/xiXU3U9n1YnwwzDHQVgxWpzH7L8rEMrkTOgO6CZ4zJRG2/Dqbshf+PsqSO1j6miA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123606; c=relaxed/simple;
	bh=jNixdvLmbYlpPwGHT7OTZy68M8BgCmi9z9/4OazvKY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWUNaC1gDW0zCdlRjLyibAhtsXxyvmWj7oXq/RohOhncXSonJcmTUdkA87BWCjct9cgFLFKhKLpryssf5ipVuOELGNKJ9d5RnIgtV7gQJSXMXt62YsHOblnAsAkkjJwx08DVNU8S4MDQRxR4dannKk8T8ja8gdI07BbNX1L+N0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/dUuBgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D579AC433C7;
	Fri, 22 Mar 2024 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123605;
	bh=jNixdvLmbYlpPwGHT7OTZy68M8BgCmi9z9/4OazvKY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/dUuBgBeKZmVhtE3pwalY6r0uugrKLvrgDZXcvghTaAAojqhL0kwxziiKqXCFdJC
	 jBP2neVKoOYX4/xAsKu5gAYcJ73FwKBaNqU0qv3s+0WSy1ChUnxpnW30mU038ivEuN
	 E1rZiLKtRvVR2I0I7P47ljUKcLtObluNFzwFNONVlrVb5TtUPVnVVImj2Oz5VaJgOJ
	 XNMRq1Rm+mqTRoMc2Ajqe1TU+ol/PWTzRMvJdJ80F/oDYCDTm4UhLrG7E6YSMWAyhu
	 AFVkXigGZF7Lk8M09QzMjCl7pYPfoVg4NdZpyGfZk1uRk1uYgozedLoAVplzgORzSK
	 DYPcCtEC58itw==
Date: Fri, 22 Mar 2024 16:06:40 +0000
From: Will Deacon <will@kernel.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <20240322160640.GF5634@willie-the-truck>
References: <ZfKsAIt8RY/JcL/V@sequoia>
 <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
 <ZfnkEqglNPRzH3Zk@sequoia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfnkEqglNPRzH3Zk@sequoia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 19, 2024 at 02:14:26PM -0500, Tyler Hicks wrote:
> On 2024-03-19 15:47:56, Will Deacon wrote:
> > On Tue, Mar 19, 2024 at 12:57:52PM +0000, Robin Murphy wrote:
> > > Beyond properly quiescing and resetting the system back to a boot-time
> > > state, the outgoing kernel in a kexec can only really do things which affect
> > > itself. Sure, we *could* configure the SMMU to block all traffic and disable
> > > the interrupt to avoid getting stuck in a storm of faults on the way out,
> > > but what does that mean for the incoming kexec payload? That it can have the
> > > pleasure of discovering the SMMU, innocently enabling the interrupt and
> > > getting stuck in an unexpected storm of faults. Or perhaps just resetting
> > > the SMMU into a disabled state and thus still unwittingly allowing its
> > > memory to be corrupted by the previous kernel not supporting kexec properly.
> > 
> > Right, it's hard to win if DMA-active devices weren't quiesced properly
> > by the outgoing kernel. Either the SMMU was left in abort (leading to the
> > problems you list above) or the SMMU is left in bypass (leading to possible
> > data corruption). Which is better?
> 
> My thoughts are that a loud and obvious failure (via unidentified stream
> fault messages and/or a possible interrupt storm preventing the new
> kernel from booting) is favorable to silent and subtle data corruption
> of the target kernel.

Looking at the SMMUv3 spec, the architecture does actually allow hardware
to reset into an aborting state:

[GBPA.ABORT]
  | Note: An implementation can reset this field to 1, in order to
  | implement a default deny policy on reset.

so perhaps it's not that unreasonable. I just dread the flood of emails
I'll get because the SMMU driver is noisy due to missing ->shutdown()
callbacks elsewhere :/

> > The best solution is obviously to implement those missing ->shutdown()
> > callbacks.
> 
> Completely agree here but it can be difficult to even identify that a
> missing ->shutdown hook is the root cause without code changes to put
> the SMMU into abort mode and sleep for a bit in the SMMU's ->shutdown
> hook.

Perhaps that's the thing to tackle first, then? If we make it easier for
folks to diagnose and fix the missing ->shutdown() callbacks, then going
into abort is much more reasonable,

Will

