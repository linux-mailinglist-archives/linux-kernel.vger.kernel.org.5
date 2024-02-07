Return-Path: <linux-kernel+bounces-56476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21484CA9D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867851C2497A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E6A5A0F3;
	Wed,  7 Feb 2024 12:20:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26EE5A785
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308428; cv=none; b=tKxfPR+Vs8dZFFW+kTd/DQUpuM4oIAVSK9fQC3F4gCMxRhbV4k/Vxz9yoP/mE4+NhRPeP7H0qzpXj9uGctsT8X1No3Z9pelhM7cMxwFm0j74IxAw32fnxx5XGKCBMApPiBw5lF2kol9GGQ7k3FbyxAwd5DovgnS5OYKR9eS8e5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308428; c=relaxed/simple;
	bh=Pn7tOMM6QU+EjDKvoXtQ6tV+upxMGu1a0ytn1xCKq+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3I6T85CD+Y8RbhwK34GKeGqa3bwb+/tZQNMofDB79wjuZhTrKPEBP4Fz2L9TYLCrzsKdi1MnpZS/0i+e89GjbUSY5tEJNu4VdEWet1vYmWw04AlD9mUfp5BUZTNnupvUYpJT8OQkXwZkcuyfD7OXscPI7XyXp3fPRKa1lAhjPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F91C433C7;
	Wed,  7 Feb 2024 12:20:23 +0000 (UTC)
Date: Wed, 7 Feb 2024 12:20:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will@kernel.org>, Nanyong Sun <sunnanyong@huawei.com>,
	mike.kravetz@oracle.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <ZcN1hTrAhy-B1P2_@arm.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcNnrdlb3fe0kGHK@casper.infradead.org>

On Wed, Feb 07, 2024 at 11:21:17AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 07, 2024 at 11:12:52AM +0000, Will Deacon wrote:
> > On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> > > On 2024/1/26 2:06, Catalin Marinas wrote:
> > > > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > > > HVO was previously disabled on arm64 [1] due to the lack of necessary
> > > > > BBM(break-before-make) logic when changing page tables.
> > > > > This set of patches fix this by adding necessary BBM sequence when
> > > > > changing page table, and supporting vmemmap page fault handling to
> > > > > fixup kernel address translation fault if vmemmap is concurrently accessed.
> > > > I'm not keen on this approach. I'm not even sure it's safe. In the
> > > > second patch, you take the init_mm.page_table_lock on the fault path but
> > > > are we sure this is unlocked when the fault was taken?
> > > I think this situation is impossible. In the implementation of the second
> > > patch, when the page table is being corrupted
> > > (the time window when a page fault may occur), vmemmap_update_pte() already
> > > holds the init_mm.page_table_lock,
> > > and unlock it until page table update is done.Another thread could not hold
> > > the init_mm.page_table_lock and
> > > also trigger a page fault at the same time.
> > > If I have missed any points in my thinking, please correct me. Thank you.
> > 
> > It still strikes me as incredibly fragile to handle the fault and trying
> > to reason about all the users of 'struct page' is impossible. For example,
> > can the fault happen from irq context?
> 
> The pte lock cannot be taken in irq context (which I think is what
> you're asking?)

With this patchset, I think it can: IRQ -> interrupt handler accesses
vmemmap -> faults -> fault handler in patch 2 takes the
init_mm.page_table_lock to wait for the vmemmap rewriting to complete.
Maybe it works if the hugetlb code disabled the IRQs but, as Will said,
such fault in any kernel context looks fragile.

-- 
Catalin

