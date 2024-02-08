Return-Path: <linux-kernel+bounces-58141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A984E1D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018161F22ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D0763EB;
	Thu,  8 Feb 2024 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGYDgmKZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34A7640E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398261; cv=none; b=Gy7Z2Odz84kxRBxfmO4eJQdHJDAE+zc180hckjbnZincKjPlMU+6+NrG7A/M3Uk/VKnDJA2Jm88+aYiGRDaUNxg2V6vyESmWeN7uCSdwyccGywrjUkfC4bJr7O4tvfC15/U+RmPyILp1QfZYig6yq9YeffIbQPD7rKV1CULL8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398261; c=relaxed/simple;
	bh=rfFaoOvWoMWSRfibASMU8lqwrNttyoGnh9WN0nUfRvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0mGqgc2HDtPbZJ5VT0o4ClTsDi1UwFeeB1e+YIGo/a1beQJx+v4jCMgg3c1tOpAUlR5fyEA67ZnkLVncoGqZQvMlECg5GX/iJ9ndEDfteunFTiTSaAZA9HuAh0O15ojoENeDUz6Yshd1lyThHLLJIVCT/eCbroHLHk9FYuSTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGYDgmKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9B3C433F1;
	Thu,  8 Feb 2024 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707398260;
	bh=rfFaoOvWoMWSRfibASMU8lqwrNttyoGnh9WN0nUfRvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGYDgmKZzTJAEXufSJ0dOeZAyQAONBsR9/SAw+vl5F8ERqrCbEpJkqTMwF0zkzc0W
	 jzSpVHSejeScDQRRgqvCstV7TrHY127o5Qz63TGko1dOvXIpCe5Hjn8yWH4lDSBXs4
	 u8/c8f2p6WH3XHdlsalrCB9o6VyzuZi5H9cnwt9qV51FXTdIIc6ne2e73OkJpJrCNd
	 108tuwuNs3Zcl0vhpuwIKh3mvxX8ajmT+lTwx3Ip2wlMusbkyBwfd+uDvYFA+Ti1Jt
	 tdFMpN8HzubOZ8oyUgCRMMQMGZceF5eF6Mnb3brXtoroqh7R9zS/x8CoAjnbCpAkCr
	 hgWZ0F0CjT4xg==
Date: Thu, 8 Feb 2024 13:17:34 +0000
From: Will Deacon <will@kernel.org>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Matthew Wilcox <willy@infradead.org>, mike.kravetz@oracle.com,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <20240208131734.GA23428@willie-the-truck>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <ZcN1hTrAhy-B1P2_@arm.com>
 <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 08, 2024 at 05:44:48PM +0800, Nanyong Sun wrote:
> 
> 在 2024/2/7 20:20, Catalin Marinas 写道:
> > On Wed, Feb 07, 2024 at 11:21:17AM +0000, Matthew Wilcox wrote:
> > > On Wed, Feb 07, 2024 at 11:12:52AM +0000, Will Deacon wrote:
> > > > On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> > > > > On 2024/1/26 2:06, Catalin Marinas wrote:
> > > > > > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > > > > > HVO was previously disabled on arm64 [1] due to the lack of necessary
> > > > > > > BBM(break-before-make) logic when changing page tables.
> > > > > > > This set of patches fix this by adding necessary BBM sequence when
> > > > > > > changing page table, and supporting vmemmap page fault handling to
> > > > > > > fixup kernel address translation fault if vmemmap is concurrently accessed.
> > > > > > I'm not keen on this approach. I'm not even sure it's safe. In the
> > > > > > second patch, you take the init_mm.page_table_lock on the fault path but
> > > > > > are we sure this is unlocked when the fault was taken?
> > > > > I think this situation is impossible. In the implementation of the second
> > > > > patch, when the page table is being corrupted
> > > > > (the time window when a page fault may occur), vmemmap_update_pte() already
> > > > > holds the init_mm.page_table_lock,
> > > > > and unlock it until page table update is done.Another thread could not hold
> > > > > the init_mm.page_table_lock and
> > > > > also trigger a page fault at the same time.
> > > > > If I have missed any points in my thinking, please correct me. Thank you.
> > > > It still strikes me as incredibly fragile to handle the fault and trying
> > > > to reason about all the users of 'struct page' is impossible. For example,
> > > > can the fault happen from irq context?
> > > The pte lock cannot be taken in irq context (which I think is what
> > > you're asking?)
> > With this patchset, I think it can: IRQ -> interrupt handler accesses
> > vmemmap -> faults -> fault handler in patch 2 takes the
> > init_mm.page_table_lock to wait for the vmemmap rewriting to complete.
> > Maybe it works if the hugetlb code disabled the IRQs but, as Will said,
> > such fault in any kernel context looks fragile.
> How about take a new lock with irq disabled during BBM, like:
> 
> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
> +{
> +    spin_lock_irq(NEW_LOCK);
> +    pte_clear(&init_mm, addr, ptep);
> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +    set_pte_at(&init_mm, addr, ptep, pte);
> +    spin_unlock_irq(NEW_LOCK);
> +}

I really think the only maintainable way to achieve this is to avoid the
possibility of a fault altogether.

Will

