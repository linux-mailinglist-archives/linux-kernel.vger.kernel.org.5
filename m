Return-Path: <linux-kernel+bounces-157347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F150C8B1025
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBD5283D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF6816C6A5;
	Wed, 24 Apr 2024 16:46:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409015EFA8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977213; cv=none; b=jPt9714d5Kg6aXmFayV0oJUWh7LEVn7iBt8jxDsxrg90zrcawzTCP9ZnRsWyP9j6C3PXKx8SLCot9xeW3wI3n8EcAXOrQWCPBBs8q2/hlFWpyCA+0UNYmHusLGSzhTeKpBJcfiY9cVqmzy/uieLLnZo9Vfjdwz9fCp1Eb4TQ6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977213; c=relaxed/simple;
	bh=paXWtLd+vMIpou8828U+D/f8DV5lUFVZijN5DJyJATQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmV1UrKSXFxeunQFoAVN9bTo+OeakNp7Wi9izQCByiStFjNU+zhw9LNCHT7wf2pyJ0u3RQewln4/GbpRm73XvPiU7mH/Lu4KCTr7BRMiWhlxVjb6kjY97afPsgWrFCDshv5J+I30/TPrwWMf+1FtMwiZpfju/OuvbG1VdMkXxfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFC1C113CD;
	Wed, 24 Apr 2024 16:46:50 +0000 (UTC)
Date: Wed, 24 Apr 2024 17:46:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64/mm: Add uffd write-protect support
Message-ID: <Zik3eEEFxwGAIjgn@arm.com>
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424111017.3160195-3-ryan.roberts@arm.com>

On Wed, Apr 24, 2024 at 12:10:17PM +0100, Ryan Roberts wrote:
> @@ -1248,6 +1302,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>   * Encode and decode a swap entry:
>   *	bits 0-1:	present (must be zero)
>   *	bits 2:		remember PG_anon_exclusive
> + *	bit  3:		remember uffd-wp state
>   *	bits 4-53:	swap offset
>   *	bit  54:	PTE_PROT_NONE (overlays PTE_UXN) (must be zero)
>   *	bits 55-59:	swap type

Ah, I did not realise we need to free up bit 3 from the swap pte as
well. Though maybe patch 1 is fine as is but for the record, it would be
good to justify the decision to go with PTE_UXN. For this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

