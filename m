Return-Path: <linux-kernel+bounces-56383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157F84C985
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07400283BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4C1B279;
	Wed,  7 Feb 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ImxC9KpO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292417BCB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304893; cv=none; b=cWoBUfMVVygqG7/YwC49UkbKAQqG1VVqBhLDtGK+qfS7eNV+b3+pgoUOXfI+N0dpwYGKZNBkflEH19UTMOnsoi1KW9dHGfNC/tSh2cuNpbAH2bm6FwITK7HXz1ifusMh4qWjGzltd8A2IEVYVgCe/NtNXhnh49r34AopnWLvREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304893; c=relaxed/simple;
	bh=dCNfvFwSJa8Rp8P+IbRv4dPyBw+ZIdZdM5oYn2lS0eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq9WSdPkyYXQIjweaPgzVT8k2HcvGg3GJhDxxnt0v2zQTnBohpXEL++NkeNs7bliPhIEZqrh4Hx8sfmSoq5Typ0LvWI2k3bj7VMFQHauQiul36yYbb1+HZkiqmEBpt7+5ctmlfnW9qgZQxzCHXqQQdK9a4KkKDW6QpVieFeyv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ImxC9KpO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WpX5mJ+dnqA+dv/RTqJrWW+rQFLmTBT94nD0uWiwdMI=; b=ImxC9KpOSn9Kp0yFacpAPbEXBC
	QgbMi18qkmmyI9lmhwLdu/xEpKlsg9SptWborQ7SxET2RfEPO+Etjs97p0IoPatPFO8iaA7bC36YI
	e7WvpDgWq+MzGUdEBxK7cVsjWIRazsEidEFb/U+NdZDDGTs8FISZ6QMNvr3SjN6CZ7a6bkW+ioYky
	UEjihsZRLEASsrjmij8aP/NxFrPSfPJaX2CgtUHmVgu5Wj6uwoNAH+PFymrZivF7DJhEoTOvsTqiF
	fpw9JM9IxVo6HV5JHCv3GF301Y0zZnQF2HU2kGXzcDvZb+6pIdofdsvOGJtPSayOiLNECLLfJVaRE
	dl3sWP0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXfzR-0000000EzNf-1XL0;
	Wed, 07 Feb 2024 11:21:17 +0000
Date: Wed, 7 Feb 2024 11:21:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Will Deacon <will@kernel.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, mike.kravetz@oracle.com,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <ZcNnrdlb3fe0kGHK@casper.infradead.org>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207111252.GA22167@willie-the-truck>

On Wed, Feb 07, 2024 at 11:12:52AM +0000, Will Deacon wrote:
> On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> > 
> > On 2024/1/26 2:06, Catalin Marinas wrote:
> > > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > > HVO was previously disabled on arm64 [1] due to the lack of necessary
> > > > BBM(break-before-make) logic when changing page tables.
> > > > This set of patches fix this by adding necessary BBM sequence when
> > > > changing page table, and supporting vmemmap page fault handling to
> > > > fixup kernel address translation fault if vmemmap is concurrently accessed.
> > > I'm not keen on this approach. I'm not even sure it's safe. In the
> > > second patch, you take the init_mm.page_table_lock on the fault path but
> > > are we sure this is unlocked when the fault was taken?
> > I think this situation is impossible. In the implementation of the second
> > patch, when the page table is being corrupted
> > (the time window when a page fault may occur), vmemmap_update_pte() already
> > holds the init_mm.page_table_lock,
> > and unlock it until page table update is done.Another thread could not hold
> > the init_mm.page_table_lock and
> > also trigger a page fault at the same time.
> > If I have missed any points in my thinking, please correct me. Thank you.
> 
> It still strikes me as incredibly fragile to handle the fault and trying
> to reason about all the users of 'struct page' is impossible. For example,
> can the fault happen from irq context?

The pte lock cannot be taken in irq context (which I think is what
you're asking?)  While it is not possible to reason about all users of
struct page, we are somewhat relieved of that work by noting that this is
only for hugetlbfs, so we don't need to reason about slab, page tables,
netmem or zsmalloc.

> If we want to optimise the vmemmap mapping for arm64, I think we need to
> consider approaches which avoid the possibility of the fault altogether.
> It's more complicated to implement, but I think it would be a lot more
> robust.
> 
> Andrew -- please can you drop these from -next?
> 
> Thanks,
> 
> Will

