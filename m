Return-Path: <linux-kernel+bounces-121549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579188E99C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65F91C3107C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537B130A63;
	Wed, 27 Mar 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkFAoSvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35112E1D2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554081; cv=none; b=pGrg99R79SZ690EzPrpuPsyLDG52X3QHGoqwZTjhaXJX6jAiLI53EfssCOoXvrBzFD3FPxbnXC4+2CRrod7qBg1WTwf5xXLYFxf2U742EjHoXTY4NOkKr5X8XIv8C9xfKf3lRdgv1hK/P+lr81TioYv4BXicoYjGgBHKgmrlGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554081; c=relaxed/simple;
	bh=YkpXI8Y4E5O0pSnw1xlG7QH+gWTbFLfo1f7E5+HqAZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9bDKCsyN9+bco+SDOkJYADijWUif/4PG4tHaVWgbiD+02xZRZkUDi/bgEyXTzkpxnIdb4Qu8TPjvD2+AvRzUIAGPr2hKNd4VgAa1kuWqpyzmGHZyjwPhNjlarw792atJL9D58iqO9pzQ6iU5RvGnw7eZEj5Jl+amAm1d2bQxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkFAoSvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2D3C433C7;
	Wed, 27 Mar 2024 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554081;
	bh=YkpXI8Y4E5O0pSnw1xlG7QH+gWTbFLfo1f7E5+HqAZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkFAoSvECyFOu4CWh7hFOPMthOkr2i/TebRy5IlzhK+g5sPwyAtlgNi0H4s/QuTWQ
	 p6mv6hTx4moEGi2CbURw76YIz/ZIklvZ2sAmsMbZ2YxnQwiR+VQvb1Xoti0mPvRTP+
	 Wtt/YX34R4BJzWV2fbhV0pcrYowD31U4eG0N/Mkmobhe7NrfK54W0B/lBcqQbZQBPn
	 pQSf5FjkUMtIptLuKVlNsq5LrZNQptBdoWxNXpO6W+QRfH7E5uhvXsJh4Xc+nvsCkz
	 EO0OiTf1wxEv7h6euXU/0Pi7zjLjfz2+3S2zhs/xQ52LYDpY9Pian1dnYPcxnRCv7i
	 8W3n4Jqw67LZg==
Date: Wed, 27 Mar 2024 17:40:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/6] mm/mm_init.c: remove meaningless calculation of
 zone->managed_pages in free_area_init_core()
Message-ID: <ZgQ99kf4D893Y7-Y@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-5-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-5-bhe@redhat.com>

On Mon, Mar 25, 2024 at 10:56:44PM +0800, Baoquan He wrote:
> Currently, in free_area_init_core(), when initialize zone's field, a
> rough value is set to zone->managed_pages. That value is calculated by
> (zone->present_pages - memmap_pages).
> 
> In the meantime, add the value to nr_all_pages and nr_kernel_pages which
> represent all free pages of system (only low memory or including HIGHMEM
> memory separately). Both of them are gonna be used in
> alloc_large_system_hash().
> 
> However, the rough calculation and setting of zone->managed_pages is
> meaningless because
>   a) memmap pages are allocated on units of node in sparse_init() or
>      alloc_node_mem_map(pgdat); The simple (zone->present_pages -
>      memmap_pages) is too rough to make sense for zone;
>   b) the set zone->managed_pages will be zeroed out and reset with
>      acutal value in mem_init() via memblock_free_all(). Before the
>      resetting, no buddy allocation request is issued.
> 
> Here, remove the meaningless and complicated calculation of
> (zone->present_pages - memmap_pages), initialize zone->managed_pages as 0
> which reflect its actual value because no any page is added into buddy
> system right now. It will be reset in mem_init().
> 
> And also remove the assignment of nr_all_pages and nr_kernel_pages in
> free_area_init_core(). Instead, call the newly added calc_nr_kernel_pages()
> to count up all free but not reserved memory in memblock and assign to
> nr_all_pages and nr_kernel_pages. The counting excludes memmap_pages,
> and other kernel used data, which is more accurate than old way and
> simpler, and can also cover the ppc required arch_reserved_kernel_pages()
> case.
> 
> And also clean up the outdated code comment above free_area_init_core().
> And free_area_init_core() is easy to understand now, no need to add
> words to explain.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 46 +++++-----------------------------------------
>  1 file changed, 5 insertions(+), 41 deletions(-)

