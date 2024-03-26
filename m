Return-Path: <linux-kernel+bounces-119505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB988C9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C1321434
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0AC1C6BB;
	Tue, 26 Mar 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsBNkVxy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE517C6C;
	Tue, 26 Mar 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471678; cv=none; b=ljekaWX7mwl3+6wqU5h/osNLBQWuk2A6xnu3K9J6bvjEWwKxtEK2hG7Yiot3/dEnm88hX9gnv6nAY26nBwxq3+ku8XlOGXJ7gaSvGH9IWIxWbu9Oj0S9UrYpPIkOa/4tbx4JzOgikjmnswXPtmY81fO09ag3gVve3HoDkjKDrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471678; c=relaxed/simple;
	bh=YEWSItngtZtSn6YzsyAmXAncFmLGbQet0N0nNxxkTbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+Ta46iQiNweHMaakmhhheg33FeJi4lKk7Dp/fuSWaLbO2m+YacZytk9S2/wq2w0stf2F0bmZfYWmHiHsV9CLq0Y9V6Urxn+87pgiqeWeAEXMYVsVVTT+XcSxg+gae8tP/dWFRqm5BSwhKWYizyFmbeuvHuCF4XlZ3xrbzaYrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsBNkVxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72050C433C7;
	Tue, 26 Mar 2024 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711471677;
	bh=YEWSItngtZtSn6YzsyAmXAncFmLGbQet0N0nNxxkTbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsBNkVxyCJewwHQBer/ntQVvTwAoLpDeWXg8Nm6vLTXD7gIp9Ko2YpDW9hv/UlVlo
	 kUx5S2xAS9jrdS707aVXb3iSK84iDoMHKS05+xNcTN3Rc4GgFH0Owu2YYLSF3quON2
	 4s6I3oEAbnad0R1j56paUY49WPO7xdtcJBHHGZk9M1WLZR+c6N3T89KTYqr8fw0qGi
	 O/vlqEkSZH2X6059V7LO/1G+ftUMNL5152km04iSYaQgPpJbmdoGq9AfV4qMg/XEHx
	 GhJOMADaVg/T2uEAVHdV6vCde/43cFgqdf4HGuiVY2Umc9g3JsQAH/WK5yCX5ac2Am
	 sM56/1IPTWJ6Q==
Date: Tue, 26 Mar 2024 09:47:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Message-ID: <20240326164755.GB1524@sol.localdomain>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>

On Tue, Mar 26, 2024 at 10:51:48AM +0200, Ard Biesheuvel wrote:
> > Open questions:
> >
> > - Is the policy that I implemented for preferring ymm registers to zmm
> >   registers the right one?  arch/x86/crypto/poly1305_glue.c thinks that
> >   only Skylake has the bad downclocking.  My current proposal is a bit
> >   more conservative; it also excludes Ice Lake and Tiger Lake.  Those
> >   CPUs supposedly still have some downclocking, though not as much.
> >
> > - Should the policy on the use of zmm registers be in a centralized
> >   place?  It probably doesn't make sense to have random different
> >   policies for different crypto algorithms (AES, Poly1305, ARIA, etc.).
> >
> > - Are there any other known issues with using AVX512 in kernel mode?  It
> >   seems to work, and technically it's not new because Poly1305 and ARIA
> >   already use AVX512, including the mask registers and zmm registers up
> >   to 31.  So if there was a major issue, like the new registers not
> >   being properly saved and restored, it probably would have already been
> >   found.  But AES-XTS support would introduce a wider use of it.
> >
> 
> I don't have much input here, except that I think we should just
> disable AVX512 kernel-wide on systems where there is no benefit in
> terms of throughput. I suspect this might change with algorithms that
> rely more heavily on the masking, but so far, we have been making
> quite effective use of simple permute vectors and overlapping loads
> and stores to do the same. And as Eric points out, the only relevant
> use case in the kernel is blocks of size 2^n where n is at least 9.

There are several benefits to AVX512 besides the 512-bit zmm registers.  Besides
masking, there are also twice as many SIMD registers which make it possible to
cache all the AES round keys.  There are also other new instructions such as
vpternlogd which I've used in AES-XTS to XOR values together more efficiently.

That's why this patchset adds both xts-aes-vaes-avx10_256 and
xts-aes-vaes-avx10_512.  And I've adopted the new "AVX10" naming, maybe a bit
early, to emphasize that it's not just about 512-bit...

Consider Intel Ice Lake for example, these are the AES-256-XTS encryption speeds
on 4096-byte messages in MB/s I'm seeing:

    xts-aes-aesni                  5136
    xts-aes-aesni-avx              5366
    xts-aes-vaes-avx2              9337
    xts-aes-vaes-avx10_256         9876
    xts-aes-vaes-avx10_512         10215

So yes, on that CPU the biggest boost comes just from VAES, staying on AVX2.
But taking advantage of AVX512 does help a bit more, first from the parts other
than 512-bit registers, then a bit more from 512-bit registers.

I do have Ice Lake on the exclusion list from xts-aes-vaes-avx10_512 anyway,
since the concern with downclocking is not really about the performance of the
code itself but rather the impact on unrelated code running on the CPU.

And I *think* the right policy is to just disable the use of the zmm registers,
as opposed to AVX512 entirely.  As AVX512 was originally presented it did tie
these together, but they don't have to be.  AVX10 (which supposedly future
x86_64 CPUs will have) explicitly moves away from that by repackaging the
existing AVX512 features and making the zmm registers optional.

- Eric

