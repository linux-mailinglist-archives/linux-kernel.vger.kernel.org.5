Return-Path: <linux-kernel+bounces-35827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377E839705
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5791F23D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2818120E;
	Tue, 23 Jan 2024 17:54:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9FA664C4;
	Tue, 23 Jan 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032463; cv=none; b=OPVPTHt3yGJ6I27o4bLwq2AHppUtvRGv5SM350gqClFGgul89EBhT1DpbQ2QbrQxF6RvfRRiAD09c5bK+VEElHVMp2r2eWm6YFfXqtkrQwr5kVWHue9dUUlPNXeE1bM8cX64u6zt90UDXFCZbOpkTfVWgMUjtyXOd5heOb+tXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032463; c=relaxed/simple;
	bh=EmbDpOX7soO/jTlAEEcGlSi8sSSt71tWrUUfP+zx2vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpEn8/YQJK6edYnNTtN5yIi15ThvFbkQnGlMLQH4zwB3GrLCNsf8d4/8iNh4pnvxAwZIXXykmhXCBy+i4qTriLEj6Tl2bQkgSZgID5hC6NhC3y5qsQB+NFOfs7mP6CvUTYI/J6PBy8WW6ZtPy827naBavUO4p9gjpai6MVdaV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312061FB;
	Tue, 23 Jan 2024 09:55:06 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD4B73F762;
	Tue, 23 Jan 2024 09:54:19 -0800 (PST)
Date: Tue, 23 Jan 2024 17:54:17 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 1/4] arm64/sve: Remove bitrotted comment about syscall
 behaviour
Message-ID: <Za/9SawqwXmlG/9B@e133380.arm.com>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-1-3d492e45265b@kernel.org>
 <Za/e15zUOEaa1b7d@e133380.arm.com>
 <991d84b4-e184-4fd6-900f-601f8c31d518@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991d84b4-e184-4fd6-900f-601f8c31d518@sirena.org.uk>

On Tue, Jan 23, 2024 at 05:31:58PM +0000, Mark Brown wrote:
> On Tue, Jan 23, 2024 at 03:44:23PM +0000, Dave Martin wrote:
> > On Mon, Jan 22, 2024 at 08:41:51PM +0000, Mark Brown wrote:
> > > When we documented that we always clear state not shared with FPSIMD we
> 
> > Where / when?
> 
> In the document that is being modified when it was written.

Ah, right, I see this:

d09ee410a3c3 ("arm64/sve: Document our actual ABI for clearing registers on syscall")

where the zeroing is made explicit.

> 
> > > -* In practice the affected registers/bits will be preserved or will be replaced
> > > -  with zeros on return from a syscall, but userspace should not make
> > > -  assumptions about this.  The kernel behaviour may vary on a case-by-case
> > > -  basis.
> 
> > This was originally an intentionally conservative statement, to allow
> > the kernel the flexibility to relax the register zeroing behaviour in
> > the future.  It would have permitted not always disabling a task's SVE
> > across a syscall, for example.  There were some concerns about security
> > and testability that meant that we didn't use this flexibility to begin
> > with.
> 
> > If we are making an irrevocable commitment not to use this flexibility
> > ever, then this comment can go, but if we're not totally sure then I
> > think it would be harmless to keep it (?)
> 
> I think everyone except for Catalin had felt that the original
> discussion had concluded that there was a commitment to always clear the
> non-shared bits and was disappointed to learn that the documentation
> said otherwise.  When I tried to take advantage of this as part of
> optimising the system call overhead for SVE there were eventually
> complaints.
> 
> > (Feel free to point me to the relevant past discussion that I may have
> > missed.)
> 
> See the discussion on my syscall optimisation series:
> 
>     https://lore.kernel.org/all/20220620124158.482039-8-broonie@kernel.org/


I think my excuse would be that this was consciously left unresolved
when SVE originally went upstream: the kernel played safe by always
zeroing the bits, while userspace was told not to rely on this always
happening in future.

If the decision has effectively now been made to close the door
permanently those optimisations, then I guess it makes sense to clean
up the documentation to be as consistent as possible.


I still feel that it is iffy practice for userspace to rely on the
extra bits being zeroed -- I think the architecture hides this
guarantee anyway whenever you go through a function call confirming to
the regular procedure call standard (including the syscall wrappers).
But there may not be a lot of point trying to put people off if we
can't force them not to rely on it.

Cheers
---Dave

