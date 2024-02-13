Return-Path: <linux-kernel+bounces-63944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271885369E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBEB23308
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A15FDB5;
	Tue, 13 Feb 2024 16:53:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF05FDA1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843189; cv=none; b=MjMv7P8/+dOapF/NzpcX7a0gBmYFAdHTDydJY1zbrBc6O5YkikzDaIGY9H1K5HgZ+3WNlQf7FN0sqxYBz0hvdlislcUYiVSS3RIqiXJQYw1mYv7EjHiKV6he7QsP1MUHrEK8gYqnf5t3Nr/xdX8bdLG45MUwSv2iY7Pl4MPU6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843189; c=relaxed/simple;
	bh=IXbhYZ1xaMkBf+Jw3xxduw1mD+IlC///ZLOxs47C4Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRGl6qhgqbMNRMwMiP5EBuJhTpHcdGtGlZlV/gh5KDqULBqvGDc08WhL+10MDj1VUkq68pRXXug7VsAKOf3qvQ6uTICX0akqhWY1M4gVCinsbt+Q88i4tdaelfkEMyFUSmlm5AAwt2y2C0jSDlioXia0ZD4vdxfy7kz/HEZg+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA9CDA7;
	Tue, 13 Feb 2024 08:53:48 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.36.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5073F5A1;
	Tue, 13 Feb 2024 08:53:03 -0800 (PST)
Date: Tue, 13 Feb 2024 16:53:01 +0000
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
	Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 21/25] arm64/mm: Implement new
 [get_and_]clear_full_ptes() batch APIs
Message-ID: <ZcuebesH1pvx4sxl@FVFF77S0Q05N.cambridge.arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-22-ryan.roberts@arm.com>
 <ZcucHyb1OBG677gx@FVFF77S0Q05N.cambridge.arm.com>
 <aaf2bc8e-3fe3-4d41-ab5b-fca99b33c8a4@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf2bc8e-3fe3-4d41-ab5b-fca99b33c8a4@arm.com>

On Tue, Feb 13, 2024 at 04:48:50PM +0000, Ryan Roberts wrote:
> On 13/02/2024 16:43, Mark Rutland wrote:
> > On Fri, Feb 02, 2024 at 08:07:52AM +0000, Ryan Roberts wrote:

> >> +static inline void __clear_full_ptes(struct mm_struct *mm, unsigned long addr,
> >> +				pte_t *ptep, unsigned int nr, int full)
> >> +{
> >> +	for (;;) {
> >> +		__ptep_get_and_clear(mm, addr, ptep);
> >> +		if (--nr == 0)
> >> +			break;
> >> +		ptep++;
> >> +		addr += PAGE_SIZE;
> >> +	}
> >> +}
> > 
> > The loop construct is a bit odd; can't this be:
> 
> I found it a little odd at first, but its avoiding the ptep and addr increments
> the last time through the loop. Its the preferred pattern for these functions in
> core-mm. See default set_ptes(), wrprotect_ptes(), clear_full_ptes() in
> include/linux/pgtable.h.
> 
> So I'd prefer to leave it as is so that we match them. What do you think?

That's fair enough; it I'm happy with it as-is.

Mark.

