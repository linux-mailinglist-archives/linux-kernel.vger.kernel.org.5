Return-Path: <linux-kernel+bounces-135322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D989BEFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAD91F22938
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC26EB62;
	Mon,  8 Apr 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugz7LOVy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB46CDA9;
	Mon,  8 Apr 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579471; cv=none; b=azcZk6CgfofKWRhvgutAeBfibOe+I75og4c8QtOO6OQ4mmJ0KippK+3yOYU8P6QexlIN4PVp9P/wroRn/oFyDLfMdJSvLDcEMxz4uNZUvph6RpZ1exISALDUYZHt4/QsN7DHk8H5I65kozz6VokNAiuNaP2AaDE82cMFMeWjk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579471; c=relaxed/simple;
	bh=hAf068l3Nm0d9JEUttg8/muc9fg+jcdg1rtCCWVZF6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ5Wu+hphVIcT1+EH5Dndmq9O8b4LxqWg41CyAx4lddRQZ7JFb3ByMbsH42D/rYpqhHzsDKw7RDgSusreKNw/T6lTfyeuif7EfIENMJMakqsuDr9ojPNn+lRbTC08/iSSZ2241O9q3hh0FReOOQs7pyBbNrPYwVcaX89EvSoBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugz7LOVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD6DC433C7;
	Mon,  8 Apr 2024 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712579471;
	bh=hAf068l3Nm0d9JEUttg8/muc9fg+jcdg1rtCCWVZF6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ugz7LOVybBzVtz6+uRTeZl8Jt3HWhp/3g6RT8hgA393jNE6Olgti/L/+Zlz6QE6Jw
	 haQ8+UvaJ/IdHyHnqSmlovsUdqGpScRkJrolh7VnWFhy4uyg0bw9CN+CzItD5S8zCt
	 50Igib856+TdoreVjGSI11RlMXbIQbcHa59cCUcb2r1gSnEbAumdjpd18Wen1vyqUs
	 2wfM8Acjc4PHsoKhVq/L7S3fQ5z3JRnCjfhwlmWCoawySduZ+v/7j5/viTZ53X68iB
	 oz14SNqp+Chq52CLG6UXXo2gfenspOLqZVGX625Lgrmf+VtaUVQ/OKVLzHfBaXPoo5
	 WT2Sdh6AutcWw==
Date: Mon, 8 Apr 2024 08:31:08 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Message-ID: <20240408123108.GA732@quark.localdomain>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
 <20240326164755.GB1524@sol.localdomain>
 <6629b8120807458ab76e1968056f5e10@AcuMS.aculab.com>
 <20240404013529.GB24248@quark.localdomain>
 <142077804bee45daac3b0fad8bc4c2fe@AcuMS.aculab.com>
 <20240405191904.GA1205@quark.localdomain>
 <e49a2868626f4f9e9169ce8b8b926a49@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e49a2868626f4f9e9169ce8b8b926a49@AcuMS.aculab.com>

On Mon, Apr 08, 2024 at 07:41:44AM +0000, David Laight wrote:
> From: Eric Biggers
> > Sent: 05 April 2024 20:19
> ...
> > I did some tests on Sapphire Rapids using a system call that I customized to do
> > nothing except possibly a kernel_fpu_begin / kernel_fpu_end pair.
> > 
> > On average the bare syscall took 70 ns.  The syscall with the kernel_fpu_begin /
> > kernel_fpu_end pair took 160 ns if the userspace program used xmm only, 340 ns
> > if it used ymm, or 360 ns if it used zmm...
> > 
> > Note that without the kernel_fpu_begin / kernel_fpu_end pair, AES-NI
> > instructions cannot be used and the alternative would be xts(ecb(aes-generic)).
> > On the same CPU, encrypting a single 512-byte sector with xts(ecb(aes-generic))
> > takes about 2235ns.  With xts-aes-vaes-avx10_512 it takes 75 ns...
> 
> So most of the cost of a single 512-byte sector is the kernel_fpu_begin().
> But it is so much slower any other way it is still faster.
> 

Yes.  To clarify, the 75 ns time I mentioned for a 512-byte sector is the
average for repeated calls, amortizing the XSAVE and XRSTOR.  For a real single
512-byte sector that eats the entire cost of the XSAVE and XRSTOR by itself, if
all state is in-use it should be about 75 + (360 - 70) = 365 ns (based on the
syscall benchmarks I did), with the XSAVE and XRSTOR accounting for 80% of that
time.  But yes, that's still over 6 times faster than the scalar alternative.

- Eric

