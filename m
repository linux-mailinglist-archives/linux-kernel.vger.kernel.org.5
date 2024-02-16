Return-Path: <linux-kernel+bounces-68575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02F857CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A11C22916
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F345128825;
	Fri, 16 Feb 2024 12:34:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24531A6B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086849; cv=none; b=petQU57PHVty1bgqlWeVXhMpLC80QlkpQ5QWpx4hIyoaFSxfDuTJzkgLhyTUbCqqEKdFE7HZkerb33eWyXVAqBmjLhYByeO/LUiTQeRy8kbLtP3NlPpEA9NtPMyIzsgFRz5rHz0L8RtpO7bzeo3sD5wGCML6Dl32pbA/xIghQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086849; c=relaxed/simple;
	bh=U+Nd0Nrku3Vnfy7PcrItv1vzYsXp20qJMpnqhVTVlVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoBzIykqz95mw5LahABNDNqUPyTUg362Glxq5mduoNSxIQ6czi2qARYiZUpCTyBoVpGyrSE9Naj5qRkIWtrAs09tnaVGDw3kfC8XoLIK3tezxT0og8l6CM6UlTye7VrZYq4lZtxAfdpoyZ+aK/NhP+vMeEGgFCQ2gPTKVNZjYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9B9C433C7;
	Fri, 16 Feb 2024 12:34:04 +0000 (UTC)
Date: Fri, 16 Feb 2024 12:34:02 +0000
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
Subject: Re: [PATCH v6 16/18] arm64/mm: Implement pte_batch_hint()
Message-ID: <Zc9WOmh-uYRajvGp@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-17-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-17-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:32:03AM +0000, Ryan Roberts wrote:
> When core code iterates over a range of ptes and calls ptep_get() for
> each of them, if the range happens to cover contpte mappings, the number
> of pte reads becomes amplified by a factor of the number of PTEs in a
> contpte block. This is because for each call to ptep_get(), the
> implementation must read all of the ptes in the contpte block to which
> it belongs to gather the access and dirty bits.
> 
> This causes a hotspot for fork(), as well as operations that unmap
> memory such as munmap(), exit and madvise(MADV_DONTNEED). Fortunately we
> can fix this by implementing pte_batch_hint() which allows their
> iterators to skip getting the contpte tail ptes when gathering the batch
> of ptes to operate on. This results in the number of PTE reads returning
> to 1 per pte.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

