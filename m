Return-Path: <linux-kernel+bounces-164046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433EE8B77AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA571283E87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576D3171E67;
	Tue, 30 Apr 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upbKBlQe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1F17278D;
	Tue, 30 Apr 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485340; cv=none; b=TD3ZF6fE60/XWFpimubhKkDdLuU/OivdvBdFgekE3u67J9B9K0ffj4t88hbTywDewpPzMeSgDg6jvaBzTzFiAXs3CdtA0ooNnUoQkgBBhIQPcHmTKRXDsBpMqdKFbENqvQ3sa9R3lT71cLX4+kJMHKuc3XVFFFA+RHH5IlfDj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485340; c=relaxed/simple;
	bh=M7IVnGFLr+3YdAJm1nNLyT13rNLM67abtp8PgBWVffk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R92QaCYtYnSUNIbkiJDYHRLoTAT+PYWfCAqEW1GfQqeBHJAcjecfbc4y2UyqJgQl+Ynl/0F7R99BiGm6zFKiuudKqbo1L+niiwczi9tF1g1mRjYMvOW39Qabfz3zA1hoZp8jTODGQtO51+Nt6/ognbKA/wykEYz1xlnIwk2vNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upbKBlQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7511C2BBFC;
	Tue, 30 Apr 2024 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714485340;
	bh=M7IVnGFLr+3YdAJm1nNLyT13rNLM67abtp8PgBWVffk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upbKBlQeFcVEf6/hkL7/jrhL4sEXoRGENpi17fBMgfdnQQmPfzNr7PjoxOS7DiP2j
	 SI4uVLUQ2wJCUZ+tIpUUb6fgU6ftff1BY521OGdLz8hfeIgan08jivABUZATPZ3IQX
	 zOk6/wuUV2yesD6xWCX4s/M4Kjop0/MTKRzDe9gH1SHcKc++juiEHlO6mMqPBDmo2O
	 ONRhxKifKJq6W7hRwEcCBSrXphHbvwWk8GuKkheMsuohSFpKuASD8axHptDRtV/Nxe
	 b5kK/14wIxZR8+mrgflcmIgnVKPCQbfaYiWqFLyqFcOT033Tq2k+3VNckdzFm8rooa
	 ZAiD782xs5alA==
Date: Tue, 30 Apr 2024 14:55:34 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Message-ID: <20240430135534.GA14069@willie-the-truck>
References: <20240430133138.732088-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430133138.732088-1-ryan.roberts@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Apr 30, 2024 at 02:31:38PM +0100, Ryan Roberts wrote:
> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry. It calls pmdp_invalidate()
> unconditionally on the pmdp and only determines if it is present or not
> based on the returned old pmd.
> 
> But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
> unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
> pmd_present() calls to return true - even for a swap pmd. Therefore any
> lockless pgtable walker could see the migration entry pmd in this state
> and start interpretting the fields (e.g. pmd_pfn()) as if it were
> present, leading to BadThings (TM). GUP-fast appears to be one such
> lockless pgtable walker.
> 
> While the obvious fix is for core-mm to avoid such calls for non-present
> pmds (pmdp_invalidate() will also issue TLBI which is not necessary for
> this case either), all other arches that implement pmd_mkinvalid() do it
> in such a way that it is robust to being called with a non-present pmd.
> So it is simpler and safer to make arm64 robust too. This approach means
> we can even add tests to debug_vm_pgtable.c to validate the required
> behaviour.
> 
> This is a theoretical bug found during code review. I don't have any
> test case to trigger it in practice.
> 
> Cc: stable@vger.kernel.org
> Fixes: 53fa117bb33c ("arm64/mm: Enable THP migration")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Hi all,
> 
> v1 of this fix [1] took the approach of fixing core-mm to never call
> pmdp_invalidate() on a non-present pmd. But Zi Yan highlighted that only arm64
> suffers this problem; all other arches are robust. So his suggestion was to
> instead make arm64 robust in the same way and add tests to validate it. Despite
> my stated reservations in the context of the v1 discussion, having thought on it
> for a bit, I now agree with Zi Yan. Hence this post.
> 
> Andrew has v1 in mm-unstable at the moment, so probably the best thing to do is
> remove it from there and have this go in through the arm64 tree? Assuming there
> is agreement that this approach is right one.
> 
> This applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
> 
> [1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.roberts@arm.com/
> 
> Thanks,
> Ryan
> 
> 
>  arch/arm64/include/asm/pgtable.h | 12 +++++--
>  mm/debug_vm_pgtable.c            | 61 ++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index afdd56d26ad7..7d580271a46d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -511,8 +511,16 @@ static inline int pmd_trans_huge(pmd_t pmd)
> 
>  static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>  {
> -	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
> -	pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
> +	/*
> +	 * If not valid then either we are already present-invalid or we are
> +	 * not-present (i.e. none or swap entry). We must not convert
> +	 * not-present to present-invalid. Unbelievably, the core-mm may call
> +	 * pmd_mkinvalid() for a swap entry and all other arches can handle it.
> +	 */
> +	if (pmd_valid(pmd)) {
> +		pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
> +		pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
> +	}
> 
>  	return pmd;
>  }

Acked-by: Will Deacon <will@kernel.org>

But it might be worth splitting the tests from the fix to make backporting
easier.

Catalin -- I assume you'll pick this up, but please shout if you want me
to take it instead.

Will

