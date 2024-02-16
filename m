Return-Path: <linux-kernel+bounces-68571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B5857C96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E681F2547A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9717FBAB;
	Fri, 16 Feb 2024 12:30:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C17F7FB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086656; cv=none; b=Lj1pHxO8VBF6HuY1GHWSd1RlmB2M/G/iBwM5cpsVQGfoN/oERR3NXkb6MiE7u8Eq+O+h5Aqw3bQDMPrp53JVaWnYkxQmPJNZY09eC5MbROkWy3bQ47PUPdeGnkjjm/SfV13P8DOYKKu01Q7bPf5K5HMToPKddAquziiRjk9bv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086656; c=relaxed/simple;
	bh=LkCYUVZu3cxw79tfcJ+izPDfRejV/FVLMOZ6EBl0D1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzYu6Qzy5PSsVfRUjZiGnWg8wbJv0BlFTBmZEvEyaYd9zwucYhZSNqy/nZNcll6GxUhC5XYWEDaLs9JSEO298MiBj4IU1FVLPVIAAGCMYqrb1fUZ8ihIUYQM7awrGn3JBl4vIeHWW+l+tTOpNJauGnqm/R4FpwMGEwFMUOHXnXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102C3C43394;
	Fri, 16 Feb 2024 12:30:50 +0000 (UTC)
Date: Fri, 16 Feb 2024 12:30:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v6 14/18] arm64/mm: Implement new
 [get_and_]clear_full_ptes() batch APIs
Message-ID: <Zc9VeMJpdpJG9LsH@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-15-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-15-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:32:01AM +0000, Ryan Roberts wrote:
> Optimize the contpte implementation to fix some of the
> exit/munmap/dontneed performance regression introduced by the initial
> contpte commit. Subsequent patches will solve it entirely.
> 
> During exit(), munmap() or madvise(MADV_DONTNEED), mappings must be
> cleared. Previously this was done 1 PTE at a time. But the core-mm
> supports batched clear via the new [get_and_]clear_full_ptes() APIs. So
> let's implement those APIs and for fully covered contpte mappings, we no
> longer need to unfold the contpte. This significantly reduces unfolding
> operations, reducing the number of tlbis that must be issued.
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

