Return-Path: <linux-kernel+bounces-111730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E744488700E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01D92867AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070755C0A;
	Fri, 22 Mar 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9cSUxp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20550278;
	Fri, 22 Mar 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122724; cv=none; b=LecxSpnAifj8jntPna3Qnx6bfgFqm/klTQoNymebWmrJfR+JYI2Nm708X5dz7vAlWAsBVbl81BabTv+aZlEkW01jFUy+AMfbBe/5Tb3yxK8Igu9kvwDOl9TQvm4uTzBshW4HvrjFxaue+FI1hSW3H+ChQxkLGLy/Z79qWwSUjn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122724; c=relaxed/simple;
	bh=a9x0EjWyPdwufxgTEjOLoHdDlBCO8EawXvsde+dmWeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4RND8EFbrQU+kzjd/ZRZ6EMhHrY04K1O2Xya1/18Va3BsY1k2vQAv4oFtc6kLXBRy4Lxx6Tga0twUvFPz9on4flEpEAo7W5Shr+qbl6E0mMd8tvj1+JJP4iFL3CcpGUZn0HQwSZvzFabCtkPX4l0Ep4bpLt0VeuvWEtbid06h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9cSUxp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3439FC433F1;
	Fri, 22 Mar 2024 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711122723;
	bh=a9x0EjWyPdwufxgTEjOLoHdDlBCO8EawXvsde+dmWeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9cSUxp8ZpIaCT3GAK0ljz4aaFQiOh8lWr7QbjXiQWGqvohorTAQ3bfaTZ9VWhyrK
	 ZJbRUrIFWyi/EhtRHlBVNvjYEN7KmNYZO6KO8SBWMYO8XICuGNJoD95TIsox7wWhZQ
	 Qt0gevJauPkZ42w7AfvqdolJJQ2RoympO2lhgD5h+y+jdigNwb/5Rs+EV3acskoXen
	 fRMzThDcSIGhiGKfZBfPtPLMpZt9IFJhliLwp8swnGVWOlOXRnVL9i1EqxDRM+fLKp
	 cy/UmhjPIG6VeCIvbLEYBqcLf0Isi1pUwTFjJI85U/X8q1IWF6sqsBsoWMOkZG9hR1
	 l5s2EUWeIGXWw==
Date: Fri, 22 Mar 2024 15:51:57 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tyler Hicks <code@tyhicks.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <20240322155157.GD5634@willie-the-truck>
References: <ZfKsAIt8RY/JcL/V@sequoia>
 <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
 <5b19ab13-a7a0-48e2-99a4-357a9f4aeafa@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b19ab13-a7a0-48e2-99a4-357a9f4aeafa@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 19, 2024 at 06:17:39PM +0000, Robin Murphy wrote:
> In terms of the shutdown behaviour, I think it actually works out as-is. For
> the normal case we haven't touched GBPA, so we are truly returning to the
> boot-time condition; in the unexpected case where SMMUEN was already enabled
> then we'll go into an explicit GPBA abort state, but that seems a
> not-unreasonable compromise for not preserving the entire boot-time Stream
> Table etc., whose presence kind of implies it wouldn't have been bypassing
> everything anyway.
> 
> The more I look at the remaining aspect of disable_bypass for controlling
> broken-DT behaviour the more I suspect it can't actually be useful either
> way, especially not since default domains. I have no memory of what my
> original reasoning might have been, so I'm inclined to just rip that all out
> and let probe fail. I see no reason these days not to expect a broken DT to
> leads to a broken system, especially not now with DTSchema validation.

That sounds reasonable to me, although we may end up having to back it
out if we regress systems with borked firmware :(

> Then there's just the kdump warning it suppresses, of which I also have no
> idea why it's there either, but apparently that one's on you :P

I think _that_ one is because the previous (crashed) kernel won't have
torn anything down, so there could be active DMA using translations in
the SMMU. In that case, the crashkernel (which is running from some
carveout) may find the SMMU enabled, but it really can't stick it into
bypass mode because that's likely to corrupt random memory. So in that
case, we do stick it into abort before we reinitialise it and then we
disabling fault reporting altogether to avoid the log spam:

	if (is_kdump_kernel())
		enables &= ~(CR0_EVTQEN | CR0_PRIQEN)

Will

