Return-Path: <linux-kernel+bounces-67566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE63856D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD9288F51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF1139594;
	Thu, 15 Feb 2024 19:21:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E0139587
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024880; cv=none; b=Mjq3f3kTfc4hPhJT+y2FQqwx8toCSH7ir1gyzTmzxkudr3GYcC9nvcjHa5FAR4rFDtrPvtW0aQ62IFrlvxt95QA97mgmmu+fM5N6vKur6WYH9c2EhWpp37qbMG/WYf1L9Ox5xwXAcT98Pd97kuiyG7KE4xhhNm6IdWCpgFXU51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024880; c=relaxed/simple;
	bh=549+N3C6wlmLc9KrTSgg5zXq+E9UR6kzo8DVOvVQFEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUjbDtVgSNMttK0I59n1tgmaBB8HhOYJAHACpZao1juisjg2WTpzK79UoyfbEdTiV6whBti+mGpH5UhrNVwfQ4e86HkvPBJoB97vdCNI6vu/IYoHJ83foQXIrPD5iVuizO2IDcGThlra4DGMyHU+q/CTDgdV3WeEBWaWSbfl/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852F2C433F1;
	Thu, 15 Feb 2024 19:21:15 +0000 (UTC)
Date: Thu, 15 Feb 2024 19:21:13 +0000
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
Subject: Re: [PATCH v6 10/18] arm64/mm: New ptep layer to manage contig bit
Message-ID: <Zc5kKSViCq8_77NW@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-11-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-11-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:31:57AM +0000, Ryan Roberts wrote:
> Create a new layer for the in-table PTE manipulation APIs. For now, The
> existing API is prefixed with double underscore to become the
> arch-private API and the public API is just a simple wrapper that calls
> the private API.
> 
> The public API implementation will subsequently be used to transparently
> manipulate the contiguous bit where appropriate. But since there are
> already some contig-aware users (e.g. hugetlb, kernel mapper), we must
> first ensure those users use the private API directly so that the future
> contig-bit manipulations in the public API do not interfere with those
> existing uses.
> 
> The following APIs are treated this way:
> 
>  - ptep_get
>  - set_pte
>  - set_ptes
>  - pte_clear
>  - ptep_get_and_clear
>  - ptep_test_and_clear_young
>  - ptep_clear_flush_young
>  - ptep_set_wrprotect
>  - ptep_set_access_flags
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

