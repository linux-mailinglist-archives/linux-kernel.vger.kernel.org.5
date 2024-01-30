Return-Path: <linux-kernel+bounces-44810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A38427B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DD8B27BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02B680058;
	Tue, 30 Jan 2024 15:10:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738086D1A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627443; cv=none; b=ASOXaO1xXDOtePsU33c9o9573s/dNJA3BCqt+88a9h6RlGtFbLOjSqMpmAqUZNWimaLwgJEhlpfaSEILV1dLYtzoTTstNjJkHvuZMt4F4xD7g+PEhWk/m2fZttYJd6aA71Reka3bNtwbIAD4bM9OeBZrRgNQZ+aYw9PRdzDivDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627443; c=relaxed/simple;
	bh=ew5D2W9FVs4jqMe4LU4sKqMLtY5HWwIiEstbwuA8TL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYKz8zfvMwecMEtCys4SrQcSQaZJqaSnqmD9nbDgKBTEKf38ralQce8qPXToW9x0FtJ2ItM2kW48k57ImsnPTo0CGh+pWaKr9upr6B/nhm1Q7thT4ZapqWD3APYpjQmuDxEk5U8LIlC7uVM+wdlGzv84NCua8FNwrhANDzP8U+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5671DA7;
	Tue, 30 Jan 2024 07:11:22 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ACDC3F762;
	Tue, 30 Jan 2024 07:10:32 -0800 (PST)
Date: Tue, 30 Jan 2024 15:10:28 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend
Message-ID: <ZbkRZNNS5WrfRpjU@e133380.arm.com>
References: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
 <20240130-arm64-sme-resume-v1-2-0e60ebba18df@kernel.org>
 <ZbjVTigk0YlGd3mA@e133380.arm.com>
 <ca380b64-3420-4817-b3b4-584b8640c0ac@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca380b64-3420-4817-b3b4-584b8640c0ac@sirena.org.uk>

On Tue, Jan 30, 2024 at 02:34:23PM +0000, Mark Brown wrote:
> On Tue, Jan 30, 2024 at 10:54:06AM +0000, Dave Martin wrote:
> > On Tue, Jan 30, 2024 at 12:02:49AM +0000, Mark Brown wrote:
> 
> > > +	if (system_supports_sme2())
> > > +		smcr |= SMCR_ELx_EZT0;
> 
> > Side question: since ZT0 is likely to be sporadically used, maybe it
> > is worth having separate lazy restore for it versus the main SME state?
> > (Not relevant for this series though, and probably best deferred until
> > there is hardware to benchmark on.  Also, ZT0 is small compared with
> > the SME state proper...)
> 
> One of the advantages SME has here is that we've got a clear indication
> if userspace is actively using the registers through SMSTART and SMSTOP.
> We only restore ZT0 at all whenever PSTATE.ZA is set and the strong

Good point.  I was still thinking in SVE mode there.

> recommendation is that should only be set when either ZA or ZT0 are in
> active use for power and performance reasons.  While it is likely that
> there will be code that uses ZA but doesn't touch ZT0 I would expect
> that the overhead of entering the kernel to do a lazy restore will be
> sufficiently high for it to be an unreasonable penalty on code that does
> touch it, as you say it's not *that* big compared to likely ZA sizes.

Agreed.

Cheers
---Dave

