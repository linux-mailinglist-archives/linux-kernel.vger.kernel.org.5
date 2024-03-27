Return-Path: <linux-kernel+bounces-120728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16BD88DC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5980829E139
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B754667;
	Wed, 27 Mar 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="viAFksyY"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D347F54
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537629; cv=none; b=Ugc4BTxoWgD8KCU3XPk6Y+J16F9DAvrXGkEwCj8O7AQUP44prb6tmHizB0FB8H/IPFAo12h8zJAfS3LOXaiAHSW3F47iWU6zlzkoaypB6fJyKdZGWPSnZeB1GeEu7qF2MTLSOzVj16Wni/qMzQZlUNdVch7JZ0ypc4cKDKfHOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537629; c=relaxed/simple;
	bh=UpPwTlFeVuNhQ7A/I73hK8ipP0pDGaOECXwitkiWUE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8Wa6ZWcWordELSs1VWeiKqT79OC8feZXckhRIvrTjVI9Axhx1s6FmK9HZ6QK3EaY3C8DFIV2oYTMe6oGU+4RAbcKEo/5AS3lMGc0d5wJkKoUZM3a5lVs7s6pzBQWRnuNRRazwNxmQUiv+A9/ywguCkOzj5MAYI4+TIBRKQlKn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=viAFksyY; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Mar 2024 20:06:53 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711537622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cKnCgqbX8j13jMe515y66dUGUM6g8Vc57B9DGG+HNfI=;
	b=viAFksyY9On9ofPHgViltOSBswQioaTNLmrWYJrqfM75aywR6UkLJ839DIpYh0tFHIBvpk
	Gnuf4AbWRR3Pr9sDXfNeLledawBlJSB2hFUQnkNcQES8SD2t5hiwumUzqCfKhnkhKilHSw
	16JuYF+j0qP2ZGL977LcqsSpmaXr/Ow=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Speed up boot with faster linear map creation
Message-ID: <ZgP9zfHz2NfiQqSZ@vm3>
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326101448.3453626-1-ryan.roberts@arm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 26, 2024 at 10:14:45AM +0000, Ryan Roberts wrote:
> Hi All,
> 
> It turns out that creating the linear map can take a significant proportion of
> the total boot time, especially when rodata=full. And a large portion of the
> time it takes to create the linear map is issuing TLBIs. This series reworks the
> kernel pgtable generation code to significantly reduce the number of TLBIs. See
> each patch for details.
> 
> The below shows the execution time of map_mem() across a couple of different
> systems with different RAM configurations. We measure after applying each patch
> and show the improvement relative to base (v6.9-rc1):
> 
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
> no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
> no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
> lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)
> 
> This series applies on top of v6.9-rc1. All mm selftests pass. I haven't yet
> tested all VA size configs (although I don't anticipate any issues); I'll do
> this as part of followup.

The series was applied cleanly on top of v6.9-rc1+ of Linus's master
branch, and boots fine on M1 VM with 14GB of memory.

Just out of curiosity, how did you measure the boot time and obtain the
breakdown of the execution times of each phase?

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Thanks,
Itaru.

> 
> Thanks,
> Ryan
> 
> 
> Ryan Roberts (3):
>   arm64: mm: Don't remap pgtables per- cont(pte|pmd) block
>   arm64: mm: Don't remap pgtables for allocate vs populate
>   arm64: mm: Lazily clear pte table mappings from fixmap
> 
>  arch/arm64/include/asm/fixmap.h  |   5 +-
>  arch/arm64/include/asm/mmu.h     |   8 +
>  arch/arm64/include/asm/pgtable.h |   4 -
>  arch/arm64/kernel/cpufeature.c   |  10 +-
>  arch/arm64/mm/fixmap.c           |  11 +
>  arch/arm64/mm/mmu.c              | 364 +++++++++++++++++++++++--------
>  include/linux/pgtable.h          |   8 +
>  7 files changed, 307 insertions(+), 103 deletions(-)
> 
> --
> 2.25.1
> 

