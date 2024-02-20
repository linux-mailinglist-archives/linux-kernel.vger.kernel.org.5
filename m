Return-Path: <linux-kernel+bounces-72183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F885B08F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0E61F21DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D212383A5;
	Tue, 20 Feb 2024 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="udjUBuNY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438C2C18E;
	Tue, 20 Feb 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392708; cv=none; b=HHlUrnh8E1JAtN2eSSPxsaLtMsPPFmI1W3AsSX6pfe2mAnPABA5nUIua8b8TZsUZHdCN1I/2ZlE1YW3Ct8fFqWSlJ+7F1nOhI3EAZKFJi40EFPKhpqol826asQHe2cimKa+EsbLJs77TZKqSScBygqR5euw9BxZ3j5A3gz1FNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392708; c=relaxed/simple;
	bh=tpxsdC5YcAUY6lkZarOTnYclCEbb54OfNodgJZlo95Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fi64qPOZbxwrd+2XXJ2gmxUbt3Wn7r4JOH/bWnMxJQiIr1mzh7M0UYnrV17yoxM5YT4Qs34Zn3mGzgVoBIE/N3JjhcFPGnSRP9os9vi10n/l2endLSkgKM5qB/H8XyElisVkn5PQVDRuEDCpk7/11YoXi7VJcNFUwhOUBWFCeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=udjUBuNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98352C433C7;
	Tue, 20 Feb 2024 01:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708392708;
	bh=tpxsdC5YcAUY6lkZarOTnYclCEbb54OfNodgJZlo95Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udjUBuNY3u4ggtpqTZdfZV2NKWbZ90+fhEhk7JDSiCyqqNGW4cwhpxQplUgvcZgog
	 gKGRXmrGeyT1aDDEqwmQvl+CA8j7OnpCwrZCj/Xgw4BW1/vTc6H1US1P8FIsEjmnol
	 BEWQh5IuFepzHNtpZSHCuoLimmHcMe2kfB2a7USo=
Date: Mon, 19 Feb 2024 17:31:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, "Huang, Ying"
 <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, Minchan Kim
 <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Yu Zhao
 <yuzhao@google.com>, SeongJae Park <sj@kernel.org>, David Hildenbrand
 <david@redhat.com>, Hugh Dickins <hughd@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko
 <mhocko@suse.com>, Yosry Ahmed <yosryahmed@google.com>, Aaron Lu
 <aaron.lu@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
Message-Id: <20240219173147.3f4b50b7c9ae554008f50b66@linux-foundation.org>
In-Reply-To: <20240219082040.7495-1-ryncsn@gmail.com>
References: <20240219082040.7495-1-ryncsn@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 16:20:40 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> From: Kairui Song <kasong@tencent.com>
> 
> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> swapin the same entry at the same time, they get different pages (A, B).
> Before one thread (T0) finishes the swapin and installs page (A)
> to the PTE, another thread (T1) could finish swapin of page (B),
> swap_free the entry, then swap out the possibly modified page
> reusing the same entry. It breaks the pte_same check in (T0) because
> PTE value is unchanged, causing ABA problem. Thread (T0) will
> install a stalled page (A) into the PTE and cause data corruption.
> 
> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!folio) {
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
> +			/*
> +			 * Prevent parallel swapin from proceeding with
> +			 * the cache flag. Otherwise, another thread may
> +			 * finish swapin first, free the entry, and swapout
> +			 * reusing the same entry. It's undetectable as
> +			 * pte_same() returns true due to entry reuse.
> +			 */
> +			if (swapcache_prepare(entry)) {
> +				/* Relax a bit to prevent rapid repeated page faults */
> +				schedule_timeout_uninterruptible(1);

Well this is unpleasant.  How often can we expect this to occur?

> +				goto out;
> +			}
> +			need_clear_cache = true;
> +
>  			/* skip swapcache */
>  			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>  						vma, vmf->address, false);


