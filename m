Return-Path: <linux-kernel+bounces-56486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C5384CABE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5BBB24ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B107603F;
	Wed,  7 Feb 2024 12:32:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FF25A4CC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309175; cv=none; b=fhZhuS3e6DX2cvKWH8q+qVnKQqkPbeyhS8hN5UvB00AvLGzJRWEsmfZ5d04mw5AKPh2poGKF0Xz5nCAo3oB8XlWTBrg2P0LqBUXITOi0CiBzx8JioY9VE9NZfN+adtakNA2YAG7Ea2bqgAwBQnz7/S+FXz0wR0yiPsyRAKVWh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309175; c=relaxed/simple;
	bh=0A2O2AnCQRdpMky+QV6PJ304LgFb3EgxTyizFXYemWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONXB9JIfA7lEiEUC6qPk8IYHezMqguKkpzEJ5uxU1wH1ocEKzwFJOARZpXCxZv8ZqOG3C7RRM34ECQl596Ge76dr2w0x/6NNUqQES1lISY5jpTgP+SAYp7xX9CF1RnZbH+NpDbWJvtWKZ/u24xqzQXfgGvW0d3LEEsr/PyI5PdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC0D1FB;
	Wed,  7 Feb 2024 04:33:34 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4761E3F5A1;
	Wed,  7 Feb 2024 04:32:51 -0800 (PST)
Date: Wed, 7 Feb 2024 12:32:48 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH] arm64/sve,sme: Refine scalable regset sizes at boot
Message-ID: <ZcN4cGb66qjSId/B@e133380.arm.com>
References: <ZcEaeLeEG8ve+Yp7@e133380.arm.com>
 <ZcNVyMyiFB3Nndth@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcNVyMyiFB3Nndth@finisterre.sirena.org.uk>

On Wed, Feb 07, 2024 at 10:04:56AM +0000, Mark Brown wrote:
> On Mon, Feb 05, 2024 at 05:27:20PM +0000, Dave Martin wrote:
> 
> > index a5dc6f764195..5c2f91f84c31 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -1189,6 +1189,7 @@ void __init sve_setup(void)
> >  		pr_warn("%s: unvirtualisable vector lengths present\n",
> >  			info->name);
> >  
> > +	arch_ptrace_sve_init(sve_vq_from_vl(info->max_vl));
> >  	sve_efi_setup();
> >  }
> 
> This will only get run if the system actually supports SVE since the
> first thing that sve_setup() does is to exit if the system does not
> support SVE.  That means that the size limiting will only be done on
> systems that have SVE, but since we unconditionally register all our
> regsets if the system doesn't have SVE it will end up with a maximally
> sized SVE regset registered which doesn't seem ideal.  As I mentioned in
> the other thread we should probably just not be registering unsupported
> regsets with the core, that would avoid the issue without a change to
> this patch.
> 
> A similar issue applies for SME.

Good point.

I guess if we're following this approach we also do have the option
to knock out entries of the array altogether once cpufeatures are
finalised.

If we want a quick fix the silly memory allocation triggering for
Douglas' splat then this probably isn't it, but if removing regsets at
boot time is desirable anyway, we might kill two birds with one stone
here.

I'll wait for progress on the other threads before digging too deeply
into this (but anyone wanting to see this patch expedited, please
shout!)

Cheers
---Dave

