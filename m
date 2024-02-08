Return-Path: <linux-kernel+bounces-58466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543ED84E6DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873BE1C25108
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED69823DB;
	Thu,  8 Feb 2024 17:34:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99991823B6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413686; cv=none; b=kubAcmav2aGrP9QGX5wknDmH/TovXpF/OCj1K/761i7fDSOcYG6H5wiHepxFC7qdNma/1QzbvrkT6wzh8oN80ufUelBKvxWdHYwcaSCsJSn1kdGRhklUm/OwBmnPNmyEtq5k5RCkscp1qwZL9xBd7j4cTVhDowDJtzQhADzbzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413686; c=relaxed/simple;
	bh=us+HXIhb+brAc8aA7ceSijkcMv7baS1+59jso/r/a58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYWPgWzJoUfyvDKNVfD6r+trrlbLsfIVkGOonWrec3DoKIp5VbabwcomZQT41T2MOVvJFCJcl4U5+V8cLWt2F4BJ+wFwEG9OhqUZ/cKUi5UlnAA/+4nqWYQy94OhCcFHOh007HVBfb+u6ckObuNIDHyzV02igtTaK8AlhrUCwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC798DA7;
	Thu,  8 Feb 2024 09:35:24 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.33.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6E443F64C;
	Thu,  8 Feb 2024 09:34:38 -0800 (PST)
Date: Thu, 8 Feb 2024 17:34:33 +0000
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
Subject: Re: [PATCH v5 00/25] Transparent Contiguous PTEs for User Mappings
Message-ID: <ZcUQqfg39zCS2BAv@FVFF77S0Q05N.cambridge.arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202080756.1453939-1-ryan.roberts@arm.com>

On Fri, Feb 02, 2024 at 08:07:31AM +0000, Ryan Roberts wrote:
> Hi All,

Hi Ryan,

I assume this is the same as your 'features/granule_perf/contpte-lkml_v' branch
on https://gitlab.arm.com/linux-arm/linux-rr/

I've taken a quick look, and I have a few initial/superficial comments before
digging into the detail on the important changes.

> Patch Layout
> ============
> 
> In this version, I've split the patches to better show each optimization:
> 
>   - 1-2:    mm prep: misc code and docs cleanups

I'm not confident enough to comment on patch 2, but these look reasonable to
me.

>   - 3-8:    mm,arm,arm64,powerpc,x86 prep: Replace pte_next_pfn() with more
>             general pte_advance_pfn()

These look fine to me.

>   - 9-18:   arm64 prep: Refactor ptep helpers into new layer

The result of patches 9-17 looks good to me, but the intermediate stages where
some functions are converted is a bit odd, and it's a bit painful for review
since you need to skip ahead a few patches to see the end result to tell that
the conversions are consistent and complete.

IMO it'd be easier for review if that were three patches:

1) Convert READ_ONCE() -> ptep_get()
2) Convert set_pte_at() -> set_ptes()
3) All the "New layer" renames and addition of the trivial wrappers

Patch 18 looks fine to me.

>   - 19:     functional contpte implementation
>   - 20-25:  various optimizations on top of the contpte implementation

I'll try to dig into these over the next few days.

Mark.

