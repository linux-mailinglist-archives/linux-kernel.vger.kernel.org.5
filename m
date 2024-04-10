Return-Path: <linux-kernel+bounces-138379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFF89F056
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA241F21E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3D159589;
	Wed, 10 Apr 2024 11:06:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7DB159213
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712747172; cv=none; b=a/axBfG4J9VQ6QpbTte5ReUg1Hffniatatc5nDt6RYmWwcq4SiGPoRGo+smeZdsNsHejXYLlCY0nT1oeS3EMWlpn64Av6xf1noiGqdtckoVXRM3lFOMIwPwdmb6pZuM0Dzn37TjHt+um1+riutPbWLIk4oKDQ4dLCLqy6heenw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712747172; c=relaxed/simple;
	bh=MIKKdWpIXzEfI2ASI08B73Fk/0HCrXyX7CADzS8qC2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTOaYczcc+h+yDDCYiaw3zUBfv94EV43+recxPKfHHVco5dkReLUdGqRi/9at8geYXOG8260mH/+USi1oIdyV30EK9Z2gHlZM3whtd9g5s3uOw7FV549jJLZWlx/AFB0Ms+eD+7XKk+40lB7Mew4hbNltL0IL54IEIgB6jWsDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69B80139F;
	Wed, 10 Apr 2024 04:06:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.17.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB09C3F6C4;
	Wed, 10 Apr 2024 04:06:07 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:06:04 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: Re: [PATCH v2 2/4] arm64: mm: Batch dsb and isb when populating
 pgtables
Message-ID: <ZhZynGm6YcIdXVWV@FVFF77S0Q05N>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-3-ryan.roberts@arm.com>
 <ZhZkr7PHB6ppksWv@FVFF77S0Q05N>
 <a3197d4c-0966-4b38-af48-6cfe417894a3@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3197d4c-0966-4b38-af48-6cfe417894a3@arm.com>

On Wed, Apr 10, 2024 at 11:25:10AM +0100, Ryan Roberts wrote:
> On 10/04/2024 11:06, Mark Rutland wrote:
> > On Thu, Apr 04, 2024 at 03:33:06PM +0100, Ryan Roberts wrote:
[> >> @@ -234,6 +238,13 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> >>  	} while (addr = next, addr != end);
> >>  
> >>  	pte_clear_fixmap();
> >> +
> >> +	/*
> >> +	 * Ensure all previous pgtable writes are visible to the table walker.
> >> +	 * See init_pte().
> >> +	 */
> >> +	dsb(ishst);
> >> +	isb();
> > 
> > Hmm... currently the call to pte_clear_fixmap() alone should be sufficient,
> > since that needs to update the PTE for the fixmap slot, then do maintenance for
> > that.
> 
> Yes, true...
> 
> > 
> > So we could avoid the addition of the dsb+isb here, and have a comment:
> > 
> > 	/*
> > 	 * Note: barriers and maintenance necessary to clear the fixmap slot
> > 	 * ensure that all previous pgtable writes are visible to the table
> > 	 * walker.
> > 	 */
> > 	pte_clear_fixmap();
> > 
> > ... which'd be fine as long as we keep this fixmap clearing rather than trying
> > to do that lazily as in patch 4.
> 
> But it isn't patch 4 that breaks it, it's patch 3. Once we have abstracted
> pte_clear_fixmap() into the ops->unmap() call, for the "late" ops, unmap is a
> noop.

Ah, yep; I hadn't spotted that yet.

> I guess the best solution there would be to require that unmap() always
> issues these barriers.
> 
> I'll do as you suggest for this patch. If we want to keep patch 3, then I'll add
> the barriers for all unmap() impls.

Thanks. It's going to take me a bit longer to chew through patches 3 and 4, but
I will try to get through those soon.

For now a slightly simpler option would be to have patch 3 introduce the
DSB+ISB as above rather than in each of the unmap() impls.

Mark.

