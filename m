Return-Path: <linux-kernel+bounces-37088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186783AB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511211C21C76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2F7A70C;
	Wed, 24 Jan 2024 14:09:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BBD7A701;
	Wed, 24 Jan 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105397; cv=none; b=HcSLvS/sGFSXCfuyuFLbekU4tgDW+z1epqLYv4VVOj3pyo3StIziewa9FYKl1V5yg3ZhsHwf/qqiPs91MzywBOC1a0X+N+P41l4q5VV7IhexvEXPXuupok6DpyzWRLDdHcdLh3vDGB6rVRt33ky9cV5oYbVlhsSdbkNlRzsE3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105397; c=relaxed/simple;
	bh=qCGKRcoywPioNujxDqiV9k0jNhIKWOBNvLrRohxfy5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4+tBsWLhxWEat0/CCfQEXw0Tjz7KbbZa1xKuKQU43BWwCBAZazQ1WcxIkuHrBhVXEjiS4yqzhw+1GbLB99bkoiQc0E5OqRMxMOTnmOqCR3I3Bvbeg02wKi04BuF/LT7tm16upfAvTh5Y/x3TCcj0UtVC2ic2RB1HGVkbkYSnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C293E1FB;
	Wed, 24 Jan 2024 06:10:39 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A31E3F5A1;
	Wed, 24 Jan 2024 06:09:53 -0800 (PST)
Date: Wed, 24 Jan 2024 14:09:51 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH 3/4] arm64/fp: Clarify effect of setting an unsupported
 system VL
Message-ID: <ZbEaL5MAPJe7+4uQ@e133380.arm.com>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
 <20240122-arm64-sve-sme-doc-v1-3-3d492e45265b@kernel.org>
 <Za/gB3oCNAyiPPnu@e133380.arm.com>
 <46571fac-28bf-4c6e-a5a4-38b1182b93a0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46571fac-28bf-4c6e-a5a4-38b1182b93a0@sirena.org.uk>

On Tue, Jan 23, 2024 at 06:42:03PM +0000, Mark Brown wrote:
> On Tue, Jan 23, 2024 at 03:49:27PM +0000, Dave Martin wrote:
> > On Mon, Jan 22, 2024 at 08:41:53PM +0000, Mark Brown wrote:
> 
> > >  /proc/sys/abi/sme_default_vector_length
> > >  
> > >      Writing the text representation of an integer to this file sets the system
> > > -    default vector length to the specified value, unless the value is greater
> > > -    than the maximum vector length supported by the system in which case the
> > > -    default vector length is set to that maximum.
> > > +    default vector length to the specified value rounded to a supported value
> > > +    using the same rules as for setting vector length via prctl().
> 
> > Do parallel changes need to be made in sve.rst?
> 
> They are, in this very patch?

Duh, yes.  My brain seems to have auto-ignored the second hunk, since it
was clearly a duplicate :P

> > (There seems to be so much duplication and copy-paste between these
> > files that I wonder whether it would make sense to merge them...  but
> > that's probably a separate discussion.)
> 
> Indeed, thanks for volunteering.  Note that there are differences
> resulting from specification differences.

Thanks for agreeing to an unspecfied deadline ;)

I might have a go at some point though, just to familiarise myself with
the differences...

> > Nit: is it better to name the prctl here than just to say prctl()?
> > That would be easier for the reader to cross-reference.
> 
> I guess, though it doesn't seem entirely idiomatic.

I expect counterexamples can be found, but I guess the reader can figure
it out either way.

Cheers
---Dave

