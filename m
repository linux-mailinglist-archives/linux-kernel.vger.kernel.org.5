Return-Path: <linux-kernel+bounces-154045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5EB8AD685
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEC81C21816
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710C41DFF8;
	Mon, 22 Apr 2024 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OkoG1IKE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86D1D545
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821316; cv=none; b=mrF+1qqBO6hXdKQVKnJbsk1sA18Xy3uUxvr69SyxWmHXcETwp3+mwbwgy3iFDIzyyIaTmzV/AY+UGDNBxAft2HFs4r/j0QdgDL/IOS2CpqWeaLjY3ozJX21MvBjvIskNcbE8HUtOBqXaxigQ5n7zVJGgON6mVWxKLQDeG0eSy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821316; c=relaxed/simple;
	bh=itR0dMitJ2NlCR82j3JWy6OQZ6XqxLec96clwAPS/5A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TtO0obEAcdiOZLChi6+mPUrRRm109KC+SqByoGUNm6y8xHlliWlRnNfJbSwKz2rXRoRUZmEI4Eqjt5X0wg7W7OFkS+jrSnIFA1HwbjmDc4SeSFdfkXiZLYBhVndYUq24qJrhCodr3acfUwV1CASqFMFeTWhB2o7xh2OcHemmUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OkoG1IKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A2CC113CC;
	Mon, 22 Apr 2024 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713821316;
	bh=itR0dMitJ2NlCR82j3JWy6OQZ6XqxLec96clwAPS/5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OkoG1IKEfI+0ioKSLycirL/K1vFKFCP9Mg+mXh/2NPhjfxSYxkscRC224VhUrpqlm
	 ut39oY5YVyCTDXOETHlGj/s8vDmquE7/5fhe6KgMqKV6ZvSo5iypocWzgCLhrgLOtq
	 kzv/6mCiBEGDyRknt1D+c2vGg2bza38eJ44Jqt1I=
Date: Mon, 22 Apr 2024 14:28:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hariom Panthi <hariom1.p@samsung.com>
Cc: urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, maninder1.s@samsung.com,
 r.thapliyal@samsung.com
Subject: Re: [PATCH 1/1] mm: vmalloc: dump page owner info if page is
 already mapped
Message-Id: <20240422142835.3a2fe7740dfc3003b68de305@linux-foundation.org>
In-Reply-To: <20240419043910.2156379-1-hariom1.p@samsung.com>
References: <CGME20240419044047epcas5p4a90ca734d73bc9a87cd1670beaa24d8e@epcas5p4.samsung.com>
	<20240419043910.2156379-1-hariom1.p@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 10:09:10 +0530 Hariom Panthi <hariom1.p@samsung.com> wrote:

> In vmap_pte_range, BUG_ON is called when page is already mapped,
> It doesn't give enough information to debug further.
> Dumping page owner information alongwith BUG_ON will be more useful
> in case of multiple page mapping.
> 
> Example:
> [   18.258806] page_owner tracks the page as allocated
> [   18.258970] page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 81, tgid 81 (insmod), ts 18257811008, free_ts 0
> [   18.259327]  prep_new_page+0xa8/0x10c
> [   18.259455]  get_page_from_freelist+0x7f8/0x1248
> [   18.259591]  __alloc_pages+0x164/0x2b4
> [   18.259703]  alloc_pages_mpol+0x88/0x230
> [   18.259821]  alloc_pages+0x4c/0x7c
> [   18.259923]  load_module+0x74/0x1af4
> [   18.260031]  __do_sys_init_module+0x190/0x1fc
> [   18.260154]  __arm64_sys_init_module+0x1c/0x28
> [   18.260280]  invoke_syscall+0x44/0x108
> [   18.260394]  el0_svc_common.constprop.0+0x40/0xe0
> [   18.260530]  do_el0_svc_compat+0x1c/0x34
> [   18.260647]  el0_svc_compat+0x2c/0x80
> [   18.260761]  el0t_32_sync_handler+0x90/0x140
> [   18.260887]  el0t_32_sync+0x194/0x198
> [   18.260996] page_owner free stack trace missing
> [   18.261143] ------------[ cut here ]------------
> [   18.261272] kernel BUG at mm/vmalloc.c:113!
> 
> ...
>
> @@ -103,7 +105,13 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	if (!pte)
>  		return -ENOMEM;
>  	do {
> -		BUG_ON(!pte_none(ptep_get(pte)));
> +		if (!pte_none(ptep_get(pte))) {
> +			if (pfn_valid(pfn)) {
> +				page = pfn_to_page(pfn);
> +				dump_page_owner(page);
> +			}
> +			BUG();
> +		}

Diving straight into dump_page_owner() seems inappropriate.  The
higher-level dump_page() interface is more typically used.

Or, even more common, VM_BUG_ON_PAGE(), but that doesn't look to be a
good fit here.



