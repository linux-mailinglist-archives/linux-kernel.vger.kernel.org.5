Return-Path: <linux-kernel+bounces-143415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D04E8A38A0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF431F232D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB6C1482FA;
	Fri, 12 Apr 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S9p6DXVR"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97F225D7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712961881; cv=none; b=ibocq9HvsjZa+vL35eMqfGujya4bHkMnEDTvokzZ1cdarVZmEgZGb7RPz2crM1X5VhvvVl5c151hDLVe1M2tsTqH2Q7VC61HdF3wd71yRBGHolihTMKRqv9uGQ14wsyA2s/58sGq/qGxF9YS1XyKdyJ7xAFZ2PxCuw1uG6KhUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712961881; c=relaxed/simple;
	bh=2/G8pva0QKXdcG7pAlRPcQQaEkGLUnJpeXwjjOIqChY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/xGacUho4Eu1q3lFEI1kVQnRN9Ri6knlooKyPgh54ogcF97+D+Rk02239ZgSkP4p/z7CBwjbFAZlVH9/RplrB5ThTVqyD259YxvM0/LIj5tNPPk46Z6x1fT+yOOOkcYHM+1/BBi0Uc68gXXp/nKDd+SZLt88TcTXKetdR9448M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S9p6DXVR; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Apr 2024 21:53:41 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712961877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bK7KfBMPyOIucwDtN0e7NfhXAX7dIzQN2rgbT78Breo=;
	b=S9p6DXVRqT4Q3RBVm7Uq9aPDAJOOzIiSGngKqvRMvNWI8kHldgoRu+I3oxpRc8RPeCTXYE
	rNPpTaRupbgiEaYYO+Wb9MdGx5CS1G/ZS+NpHFGPZgs4dI7FECqKaBUKjvrNuPLzlwPpCm
	KonJVHhiEGrZwSX6WL6pvVmUyuIlROA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Speed up boot with faster linear map creation
Message-ID: <ZhaL1TABj0Qf7UKR@vm3>
References: <20240412131908.433043-1-ryan.roberts@arm.com>
 <171293670589.3659902.6442840474459477952.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171293670589.3659902.6442840474459477952.b4-ty@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 12, 2024 at 05:06:41PM +0100, Will Deacon wrote:
> On Fri, 12 Apr 2024 14:19:05 +0100, Ryan Roberts wrote:
> > It turns out that creating the linear map can take a significant proportion of
> > the total boot time, especially when rodata=full. And most of the time is spent
> > waiting on superfluous tlb invalidation and memory barriers. This series reworks
> > the kernel pgtable generation code to significantly reduce the number of those
> > TLBIs, ISBs and DSBs. See each patch for details.
> > 
> > The below shows the execution time of map_mem() across a couple of different
> > systems with different RAM configurations. We measure after applying each patch
> > and show the improvement relative to base (v6.9-rc2):
> > 
> > [...]
> 
> Applied to arm64 (for-next/mm), thanks!
> 
> [1/3] arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>       https://git.kernel.org/arm64/c/5c63db59c5f8
> [2/3] arm64: mm: Batch dsb and isb when populating pgtables
>       https://git.kernel.org/arm64/c/1fcb7cea8a5f
> [3/3] arm64: mm: Don't remap pgtables for allocate vs populate
>       https://git.kernel.org/arm64/c/0e9df1c905d8

I confirm this series boots the system on FVP (with my .config and my
buildroot rootfs using Shrinkwrap).

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Thanks,
Itaru.

> 
> Cheers,
> -- 
> Will
> 
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev

