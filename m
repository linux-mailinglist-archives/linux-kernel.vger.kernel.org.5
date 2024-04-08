Return-Path: <linux-kernel+bounces-134700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1D589B5B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475A51C210D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7CC184F;
	Mon,  8 Apr 2024 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7g1SnmF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7015A8;
	Mon,  8 Apr 2024 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540889; cv=none; b=HlvzoVB5kTPGTkJKBKPlstegrW+jFr8sRh2HhEZzonDZ/qdwExlKgr5viACJ9NHKW1SjIEuPDb1YclgHiBvujxGQaww7aWf3V1B1vU5Z9VgzstXmp8OQ5/b3ayz/SohBPObcPp0DxOFkMEd2hhzHNnt1E9QrYj/Ef/EY/uvOp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540889; c=relaxed/simple;
	bh=hgtWgXDcxLrCWNebDoDAm1hclRUkUPS80inuEmO1aPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3XE7bMnmS8+bv+KgGG/sSS7V3MgEoEEg/e3QI04BSLpnrH+waAHcxTNUB6mfPl9unGFFTW8/aNny4oAQOCm3yt06viL93E+Dt7SZq9aYttEW5vIJ7bBdj4UFWLCQ00piOD3BeXflW6fpJSJsA6tvSpAEoy83g7EVx7ou79qj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7g1SnmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D32BC433F1;
	Mon,  8 Apr 2024 01:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540889;
	bh=hgtWgXDcxLrCWNebDoDAm1hclRUkUPS80inuEmO1aPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7g1SnmFTMKanNOppPYSZJQOLtDyIqLHnIPS0sxTOCChlDg6ssm7W5/tftXPJ0CvJ
	 ui+aKhmk7KmOoVVeXcSuxjLiYNa+uQI/rznZElUXhNHMWoaVQnxKvU0V6uHJ/eGpde
	 Cz42R1XHdVX7765px/pkYezJaW3pcIYAC59U4NZwhhf7s6qBVmaOQk/EEpg0skJ8yl
	 nIDbMGCzNi48fJGJTGde8mZ9mNWxyJ5DIUy4NDEPMbbj4cCETtp4lvoOmgUzA/0xgv
	 hi8MMURD9ypfOTqU4T00StYzrTQ+wIo2OrOG/+EDTP3cD6iK+JyfLgc0DEJXOLk2zn
	 HhSznAAoYp/4A==
Date: Sun, 7 Apr 2024 21:48:06 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dm-devel@redhat.com, luto@kernel.org, dave.hansen@linux.intel.com,
	tglx@linutronix.de, bp@alien8.de, mingo@kernel.org, x86@kernel.org,
	herbert@gondor.apana.org.au, ardb@kernel.org, elliott@hpe.com,
	dan.j.williams@intel.com, bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com
Subject: Re: [PATCH v9 00/14] x86: Support Key Locker
Message-ID: <20240408014806.GA965@quark.localdomain>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
 <13bb2f0f-5894-4366-be53-44658144a23d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13bb2f0f-5894-4366-be53-44658144a23d@intel.com>

Hi,

On Sun, Apr 07, 2024 at 04:24:18PM -0700, Chang S. Bae wrote:
> On 3/28/2024 6:53 PM, Chang S. Bae wrote:
> > 
> > Then, the following is a summary of changes per patch since v8 [6]:
> > 
> > PATCH7-8:
> > * Invoke the setup code via arch_initcall() due to upstream changes
> >    delaying the FPU setup.
> > 
> > PATCH9-11:
> > * Add new patches for security and hotplug support clarification
> 
> I've recently made updates to a few patches, primarily related to the
> mitigation parts. While the series is still under review, Eric's VAES
> patches have been merged into the crypto tree and are currently being
> sorted out. Once things settle down, I will make a few adjustments on the
> crypto side. Then, another revision will be necessary thereafter.
> 
> Thanks,
> Chang

Thanks for the updated patchset!

Do you have a plan for how this will be merged?  Which trees will the patches go
through?  I think that the actual AES-XTS implementation could still use a bit
more polishing; see my comments below.  However, patches 1-12 don't need to wait
for that.  Perhaps the x86 maintainers would like to take patches 1-12 for
v6.10?  Then the AES-XTS support can go through the crypto tree afterwards.

As you noticed, this cycle I've been optimizing AES-XTS for x86_64 by adding new
VAES and AES-NI + AVX implementations.  I have some ideas for the Key Locker
based implementation of AES-XTS:

First, surely it's the case that in practice, all CPUs that support Key Locker
also support AVX?  If so, then there's no need for the Key Locker assembly to
use legacy SSE instructions.  It should instead target AVX and use VEX-coded
instructions.  This would save some instructions and improve performance.

Since the Key Locker assembly only supports 64-bit mode, it should also feel
free to use registers xmm8-xmm15 for purposes such as caching the XTS tweaks.
This would improve performance.

Since the Key Locker assembly advances a large number of XTS tweaks at a time
(8), I'm also wondering if it would be faster to multiply by x^8 directly
instead of multiplying by x sequentially eight times.  This can be done using
the pclmulqdq instruction; see aes-xts-avx-x86_64.S which implements this
optimization.  Probably all CPUs that support Key Locker also support PCLMULQDQ.

I'm also trying to think of the best way to organize the Key Locker AES-XTS glue
code.  I see that you're proposing to share the glue code with the existing
AES-XTS implementations.  Unfortunately I don't think this ends up working very
well, due to the facts that the Key Locker code can return errors and uses a
different key type.  I think that for now, I'd prefer that you simply copied the
XTS glue code into aeskl-intel_glue.c and modified it as needed.  (But make sure
to use the new version of the glue code, which is faster.)

For falling back to AES-NI, I think the cleanest solution is to call the
top-level setkey, encrypt, and decrypt functions (the ones that are set in the
xts-aes-aesni skcipher_alg), instead of calling lower-level functions as your
current patchset does.

If you could keep the Key Locker assembly roughly stylistically consistent with
the new aes-xts-avx-x86_64.S, that would be great too.

Do you happen to know if there's any way to test the Key Locker AES-XTS code
without having access to a bare metal machine with a CPU that supports Key
Locker?  I tried a Sapphire Rapids based VM in Google Compute Engine, but it
doesn't enumerate Key Locker.  I also don't see anything in QEMU related to Key
Locker.  So I don't currently have an easy way to test this patchset.

Finally, a high level question.  Key Locker has been reported to be
substantially slower than AES-NI.  At the same time, VAES has recently doubled
performance over AES-NI.  I'd guess this leaves Key Locker even further behind.
Given that, how useful is this patchset?  I'm a bit concerned that this might be
something that sounds good in theory but won't be used in practice.  Are
performance improvements for Key Locker on the horizon?  (Well, there are the
improvements I suggested above, which should help, but it sounds like main issue
is the Key Locker instructions themselves which are just fundamentally slower.)

- Eric

