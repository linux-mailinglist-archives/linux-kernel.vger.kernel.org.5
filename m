Return-Path: <linux-kernel+bounces-160188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3740A8B3A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405BBB24633
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C0148822;
	Fri, 26 Apr 2024 14:48:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE93610A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142901; cv=none; b=aHRKUNJS3QJlyhfXBvS7mouccCHGVfgapSnETxctFb2eI3MUkJhxVH0Y+uk5RTAJekdLTJRO4LAELvAG8CAZxQPDwZGewtCqA88RO1KbdKuTDix51YTw3X7Akw1H1ibIbfKibZHU8biZ2hlb6tvS/UeRAfovAuz+AVM1I3a22B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142901; c=relaxed/simple;
	bh=RkxnOL7/cz7XiQGItOyZoIVS24IynwZglHacFVfEFAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEmYVvktlH9RDd+rG0SZMprPxPixzK6Mho5rRMvNZaX6YYbiIdVuyPa41TB3INhz11795gF3HKLROiJ4in2Xon7V6itQxPfzbLkaVX2QxBTZHmNhs71zDvIkr7/3N4l44FbKZ48DhNw+fJ58hGJICu/1s0hNv24fkxQAb7tNemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32607C113CD;
	Fri, 26 Apr 2024 14:48:18 +0000 (UTC)
Date: Fri, 26 Apr 2024 15:48:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Peter Xu <peterx@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64/mm: Move PTE_PROT_NONE and
 PMD_PRESENT_INVALID
Message-ID: <Ziu-r2nkssCQ_uCS@arm.com>
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-2-ryan.roberts@arm.com>
 <b55558a5-a9d4-4aea-956a-1babad01b6cd@redhat.com>
 <df0475e1-9078-4629-b23d-0919ab1e37c2@arm.com>
 <eed172b5-c71a-469f-a790-76126760ca7c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eed172b5-c71a-469f-a790-76126760ca7c@arm.com>

On Thu, Apr 25, 2024 at 11:37:42AM +0100, Ryan Roberts wrote:
> Also, IMHO we shouldn't really need to reserve PMD_PRESENT_INVALID for swap
> ptes; it would be cleaner to have one bit that defines "present" when valid is
> clear (similar to PTE_PROT_NONE today) then another bit which is only defined
> when "present && !valid" which tells us if this is PTE_PROT_NONE or
> PMD_PRESENT_INVALID (I don't think you can ever have both at the same time?).

I think this make sense, maybe rename the above to PTE_PRESENT_INVALID
and use it for both ptes and pmds.

> But there is a problem with this: __split_huge_pmd_locked() calls
> pmdp_invalidate() for a pmd before it determines that it is pmd_present(). So
> the PMD_PRESENT_INVALID can be set in a swap pte today. That feels wrong to me,
> but was trying to avoid the whole thing unravelling so didn't persue.

Maybe what's wrong is the arm64 implementation setting this bit on a
swap/migration pmd (though we could handle this in the core code as
well, it depends what the other architectures do). The only check for
the PMD_PRESENT_INVALID bit is in the arm64 code and it can be absorbed
into the pmd_present() check. I think it is currently broken as
pmd_present() can return true for a swap pmd after pmd_mkinvalid().

So I don't think we lose anything if pmd_mkinvalid() skips any bit
setting when !PTE_VALID. Maybe it even fixes some corner case we never
hit yet (like pmd_present() on a swap/migration+invalid pmd).

-- 
Catalin

