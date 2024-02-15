Return-Path: <linux-kernel+bounces-67570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2C856D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274BA1F21A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40F139597;
	Thu, 15 Feb 2024 19:22:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768113699A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024979; cv=none; b=GDz3fKQnZNioZ6QEwr3ZfsbgjZzoEZSH88spdiERNy07hYeOUQzobBzgSc5RW9hoJY4IHhCo2AR+sCkzzCPfr2FWGjbY5eopGwNqF73TGcsv0/6qHDBj/zLGcdyljEZbrd2DENWRb92Bc/642dsMrSGlUQNg3Ef0N5XzgdFQnNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024979; c=relaxed/simple;
	bh=mkgNUm4xyRfw33PHYI3lP6y9p/NZoMAfQESJbqtAHwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWLVgpkT8hFI8ugW7vPD4/jvOfOU6O/HJMRuerRvOc2sBn08HnfjlPMKYDGla4p4YqlmTOwKdf2s1Gd518HuhdIyv7cbBLEH9gVbzhKMKCTsRamBL+dl+8mKvWaXn/+1URYwLdKXdbjXu6aSkLxfmudVmEXV68PJhEwmKFVy6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88915C43390;
	Thu, 15 Feb 2024 19:22:54 +0000 (UTC)
Date: Thu, 15 Feb 2024 19:22:52 +0000
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
Subject: Re: [PATCH v6 11/18] arm64/mm: Split __flush_tlb_range() to elide
 trailing DSB
Message-ID: <Zc5kjJlGnva6qJRt@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-12-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-12-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:31:58AM +0000, Ryan Roberts wrote:
> Split __flush_tlb_range() into __flush_tlb_range_nosync() +
> __flush_tlb_range(), in the same way as the existing flush_tlb_page()
> arrangement. This allows calling __flush_tlb_range_nosync() to elide the
> trailing DSB. Forthcoming "contpte" code will take advantage of this
> when clearing the young bit from a contiguous range of ptes.
> 
> Ordering between dsb and mmu_notifier_arch_invalidate_secondary_tlbs()
> has changed, but now aligns with the ordering of __flush_tlb_page(). It
> has been discussed that __flush_tlb_page() may be wrong though.
> Regardless, both will be resolved separately if needed.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

