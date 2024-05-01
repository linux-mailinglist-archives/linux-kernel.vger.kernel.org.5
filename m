Return-Path: <linux-kernel+bounces-165121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E98B8858
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6941C23241
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497D524DC;
	Wed,  1 May 2024 10:04:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B626286;
	Wed,  1 May 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557889; cv=none; b=aYr5fJ7JvuYc2H0MeWBK33x1aBl7BXFe+Ozf5cqW6D5KXek4qdZCWvvAd4e8IahSpq+RtpmsojO1JdWMZ3aWhRfA7qBYr2Gy4kQMnp+mAqdpW45ls5QQIxds6+weakLXumKliNi8gY/RhJXUJ6FhoIvkb9VHtdFKRCku/Gu/GoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557889; c=relaxed/simple;
	bh=6acgbOkRAMHlRghsM7KyV6HLqiinUNzYGGeLgespLvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0umhST4EeRZv+LsXE2fsZFQt8e8YtZySkDQ2qQnDNS9FHIv75Usgf2FgyZg4GaK3DQowa2LQtEsza0cfbnoEVgyxla8xStN4AHVCwAmP8LL4nPgPwoJZhlEku2W9IhRkUrqYELTPLWB55oYn8fpkfQ/9tC+Nu4E3JwLFF79yrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA12C113CC;
	Wed,  1 May 2024 10:04:47 +0000 (UTC)
Date: Wed, 1 May 2024 11:04:44 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Message-ID: <ZjITvH87_hxDvrxj@arm.com>
References: <20240430133138.732088-1-ryan.roberts@arm.com>
 <171449974870.639201.3165060270571039049.b4-ty@arm.com>
 <e0624ca9-b321-479e-9b64-59a4cd242f6d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0624ca9-b321-479e-9b64-59a4cd242f6d@arm.com>

On Wed, May 01, 2024 at 09:05:17AM +0100, Ryan Roberts wrote:
> On 30/04/2024 18:57, Catalin Marinas wrote:
> > On Tue, 30 Apr 2024 14:31:38 +0100, Ryan Roberts wrote:
> >> __split_huge_pmd_locked() can be called for a present THP, devmap or
> >> (non-present) migration entry. It calls pmdp_invalidate()
> >> unconditionally on the pmdp and only determines if it is present or not
> >> based on the returned old pmd.
> >>
> >> But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
> >> unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
> >> pmd_present() calls to return true - even for a swap pmd. Therefore any
> >> lockless pgtable walker could see the migration entry pmd in this state
> >> and start interpretting the fields (e.g. pmd_pfn()) as if it were
> >> present, leading to BadThings (TM). GUP-fast appears to be one such
> >> lockless pgtable walker.
> >>
> >> [...]
> > 
> > Applied to arm64 (for-next/fixes), thanks! It should land in 6.9-rc7. I
> > removed the debug/test code, please send it as a separate patch for
> > 6.10.
> 
> Thanks Catalin! I'm guessing this will turn up in today's linux-next, so if I
> send the tests today and Andrew puts them straight in mm-unstable (which will
> goto linux-next) there is no risk that the tests are there without the fix? Or
> do I need to hold off until the fix is in v6.9-rc7?

It looks like we don't push for-next/fixes to linux-next, it's
short-lived usually, it ends up upstream quickly. I can send the pull
request later today, should turn up in mainline by tomorrow. You can add
a note to your patch for Andrew that it will fail on arm64 until the fix
ends up upstream. It's a matter of a couple of days anyway.

-- 
Catalin

