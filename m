Return-Path: <linux-kernel+bounces-166818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC058B9FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03A11C2231B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A36171664;
	Thu,  2 May 2024 18:00:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED057171068;
	Thu,  2 May 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672813; cv=none; b=i53exzSeloxaNCFPQsOy1bODzZuqUrd1ZDcPwPOIvfVPIdaLeWXzOPGPYd2RCmMrNhKymIyvxEk2JSvFxUh8QBdQfHwLxngmho+kpn7BxcF2L/n+1SrJIjNYmjWdA0vZbcXmSgr2YD/8j0kdcCKwdBfb2a0d24rOmGTgM9vLAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672813; c=relaxed/simple;
	bh=BwXhwwffklxOe2+TlmFS93TXrpMJq9ig2rSZlYauX/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6D/zSaUMcPx5azwnNApvFPcsTnJEelGEUAxoN3+WXpf9SY6dRQa0tm3SoZihGPAqr2lIFwk+GrisLgEuidUz3TTE7/EvyBareRVDKM/ZEhqtYvTCRjtZU9bQdgGQ7UXJ1CI6cJfT/AxKbwkuoZz33VsgGkDfGHK1kFwlWHt1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C20C113CC;
	Thu,  2 May 2024 18:00:10 +0000 (UTC)
Date: Thu, 2 May 2024 19:00:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Message-ID: <ZjPUqKSE_CUVT3Y-@arm.com>
References: <20240430133138.732088-1-ryan.roberts@arm.com>
 <171449974870.639201.3165060270571039049.b4-ty@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171449974870.639201.3165060270571039049.b4-ty@arm.com>

On Tue, Apr 30, 2024 at 06:57:52PM +0100, Catalin Marinas wrote:
> On Tue, 30 Apr 2024 14:31:38 +0100, Ryan Roberts wrote:
> > __split_huge_pmd_locked() can be called for a present THP, devmap or
> > (non-present) migration entry. It calls pmdp_invalidate()
> > unconditionally on the pmdp and only determines if it is present or not
> > based on the returned old pmd.
> > 
> > But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
> > unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
> > pmd_present() calls to return true - even for a swap pmd. Therefore any
> > lockless pgtable walker could see the migration entry pmd in this state
> > and start interpretting the fields (e.g. pmd_pfn()) as if it were
> > present, leading to BadThings (TM). GUP-fast appears to be one such
> > lockless pgtable walker.
> > 
> > [...]
> 
> Applied to arm64 (for-next/fixes), thanks! It should land in 6.9-rc7. I
> removed the debug/test code, please send it as a separate patch for
> 6.10.
> 
> [1/1] arm64/mm: pmd_mkinvalid() must handle swap pmds
>       https://git.kernel.org/arm64/c/e783331c7720

Since Andrew merged the generic mm fix, I dropped this patch from the
arm64 for-next/fixes branch.

-- 
Catalin

