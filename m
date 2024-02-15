Return-Path: <linux-kernel+bounces-66817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADF856239
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160E4B32D41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9312AAC1;
	Thu, 15 Feb 2024 11:36:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301612B152
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996993; cv=none; b=aXL4qmbQoXedHOW3rcm7Bj6TwJB/il2SbiawRPJDqwk4s8TLRlr95TkQSaOoSooXNuMm0abFHLDXivvtMetg/dmHEESkHxWxDEr1XiOZ8yzawIzs/4C+SYKNo6yrOmkJLyLsw/O/3H5IYFzH8Aq1NbIdCZXILOmZ1YSRywtdMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996993; c=relaxed/simple;
	bh=8g7dhm2bfs1KXzC1xPed9APN1G94sWjLcvBX3dCnKD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDgh63WVwiGuBTHhVZuSe7XjVFTw5QuY1/8Fb80XQXE4VMmzPqZs6j7bXDmj4DV/xvX0ZweBAkMmGKM4kvOyS2dL0GarKLRPqwqPJ7sZ3zVs58IWGYQQHOP7OD8/gmMjU/Iw1Swd/tcJNdyvfDSIhrNAt+Y+YLnG2gkHH4Y77ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7C991FB;
	Thu, 15 Feb 2024 03:37:10 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.68.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6408F3F7B4;
	Thu, 15 Feb 2024 03:36:26 -0800 (PST)
Date: Thu, 15 Feb 2024 11:36:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/18] Transparent Contiguous PTEs for User Mappings
Message-ID: <Zc33Nx2ieCnzVfCe@FVFF77S0Q05N>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-1-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:31:47AM +0000, Ryan Roberts wrote:
> Hi All,
> 
> This is a series to opportunistically and transparently use contpte mappings
> (set the contiguous bit in ptes) for user memory when those mappings meet the
> requirements. The change benefits arm64, but there is some (very) minor
> refactoring for x86 to enable its integration with core-mm.

I've looked over each of the arm64-specific patches, and those all seem good to
me. I've thrown my local Syzkaller instance at the series, and I'll shout if
that hits anything that's not clearly a latent issue prior to this series.

The other bits also look good to me, so FWIW, for the series as a whole:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

