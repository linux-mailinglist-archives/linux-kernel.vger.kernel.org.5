Return-Path: <linux-kernel+bounces-132262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DB89922A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2D61C22A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B113C679;
	Thu,  4 Apr 2024 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0UVbGX4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0A130A7F;
	Thu,  4 Apr 2024 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273763; cv=none; b=S2VPRr0HiGCbioW+wBIkpoaS0xEnzl1Yr+O9M3LURRMAehZIx7bFscw/pyy8vjSVsDeQsckdHMd6VmA8vHq2JF98b6w9P/3ADqDY/rTG8sQTNpVlfsUjOVAipPBFruvpoNGFeHeNVExhE7DdJNPtCqK+VUcTX+gHmNyDlcYkadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273763; c=relaxed/simple;
	bh=c4dlqL7Ifu1XCWKPZneuO2tG29yIvg4/flcQpTb0TNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbqReZOQZCNPyjdZ8TCm6vMoeyG3f76Nd8qMfaqzGVXaitrojKnvB0/c6dvAu8HgHXhpf94TO5G5ODuk1SjViCgZI874PJrQY2fRmmpK3KF6fmXEIRs+SJf+1KQl5XKBemG8khTERWvvdgiUG74HWevYVDLflPe7ZLI5GF9BDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0UVbGX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8912AC433C7;
	Thu,  4 Apr 2024 23:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712273763;
	bh=c4dlqL7Ifu1XCWKPZneuO2tG29yIvg4/flcQpTb0TNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0UVbGX4dyn+lgNOBxBq4IvZRC5S1u0CKnXM25Oh0X2vVpbFBowe338pOPoUZ5JP5
	 ldMIgl+qUtcymPGNKRDoRvhbBe4MitIO1as1mGQVFqBS3x69CyLKhhb1PHU7Npxfjm
	 bGOrJqiIPlao8TDDyLu6b0CvnRMO5Uqakf9YJg1Lfa4DX49anqUd+EUMUMXUujDkdH
	 YXeVPWLl0MbkZIHoFBtcT1Rq8R42kyUCJ8NWDVxVihNJbKskA0/qK/247vmwogOI91
	 niF4eFrw2ckNf9fnKBV04HrQ5HjMvolN7dx83EBu8txyRVw+QoGbVVzUOqX8CXClUI
	 TQni90w4qoXhw==
Date: Thu, 4 Apr 2024 19:36:00 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 6/6] crypto: x86/aes-xts - wire up VAES + AVX10/512
 implementation
Message-ID: <20240404233600.GA746@quark.localdomain>
References: <20240329080355.2871-1-ebiggers@kernel.org>
 <20240329080355.2871-7-ebiggers@kernel.org>
 <f5461df0-6609-42db-850c-de6a32728fe2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5461df0-6609-42db-850c-de6a32728fe2@intel.com>

On Thu, Apr 04, 2024 at 01:34:04PM -0700, Dave Hansen wrote:
> On 3/29/24 01:03, Eric Biggers wrote:
> > +static const struct x86_cpu_id zmm_exclusion_list[] = {
> > +	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_SKYLAKE_X },
> > +	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_X },
> > +	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_D },
> > +	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE },
> > +	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_L },
> > +	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_NNPI },
> > +	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_TIGERLAKE_L },
> > +	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_TIGERLAKE },
> > +	/* Allow Rocket Lake and later, and Sapphire Rapids and later. */
> > +	/* Also allow AMD CPUs (starting with Zen 4, the first with AVX-512). */
> > +	{},
> > +};
> 
> A hard-coded model/family exclusion list is not great.
> 
> It'll break when running in guests on newer CPUs that fake any of these
> models.  Some folks will also surely disagree with the kernel policy
> implemented here.
> 
> Is there no way to implement this other than a hard-coded kernel policy?

Besides the hardcoded CPU exclusion list, the options are:

1. Never use zmm registers.

2. Ignore the issue and use zmm registers even on these CPU models.  Systemwide
   performance may suffer due to downclocking.

3. Do a runtime test to detect whether using zmm registers causes downclocking.
   This seems impractical.

4. Keep the proposed policy as the default behavior, but allow it to be
   overridden on the kernel command line.  This would be a bit more flexible;
   however, most people don't change defaults anyway.

When you write "Some folks will also surely disagree with the kernel policy
implemented here", are there any specific concerns that you anticipate?  Note
that Intel has acknowledged the zmm downclocking issues on Ice Lake and
suggested that using ymm registers instead would be reasonable:
https://lore.kernel.org/linux-crypto/e8ce1146-3952-6977-1d0e-a22758e58914@intel.com/

If there is really a controversy, my vote is that for now we just go with option
(1), i.e. drop this patch from the series.  We can reconsider the issue when a
CPU is released with better 512-bit support.

- Eric

