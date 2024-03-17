Return-Path: <linux-kernel+bounces-105479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E318587DEF8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A331F2154F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47181CD2E;
	Sun, 17 Mar 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJP3pt7r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058E1CAB1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710694219; cv=none; b=itODXUt62ftt2Snam/HJh9PETAk02ioBMZC4SPjXQTuaiqC3Vjbt4d1V8wKxUV2hUQdfgX5IECrJXhYjFOa59JHHpyzN/qdmy0RlKYJ5EhLinRgkW5SWTXmCrTLLmGMjVujbtWr2Oj9selMSmcEdTEW+nhe1bBdOkLmKZkSPQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710694219; c=relaxed/simple;
	bh=xEAJw0ZQhX123wo5YbhIlzw/udZVwfWZul3CMtOyu8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3emLWyGfowxCqyAb7v5InPRoCN1EQYw6DR47t+gnurVoXaOveVmygJ3FNwZfpp1M1lGEH9h7xhKgmYLtDKRR2NLKfcCKhfuhj4F6Te9AtUrTUhe0lE2y3nd73xfkVGF5EcoQWyaw0Y1JYXRidRSWf/xOa4LJifkMezXoH5Gt9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJP3pt7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F93AC433F1;
	Sun, 17 Mar 2024 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710694218;
	bh=xEAJw0ZQhX123wo5YbhIlzw/udZVwfWZul3CMtOyu8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJP3pt7rVpsiqWxGN/fmUghTX5b4F8SyvWLoyXOCSezU6bnN1UH2FyH1sWa5O1whU
	 BJEAnj/rid/0i1A3z+FiUv6m2ulP7ItDh6MOZFt3IklULcPjfGHwPSax6209N9ipCx
	 D4Vw9GReURPz4Z9h7ajPqh/8bs4R4toBFOpRNWNTvTSf46KI5qzeYXRX2zzQk53Uk3
	 3XlyAyezDgY4N6cO+Zn0AtmBKuuOtRXaGJ84Zt+YHf9+tKmJEMHGoANzj6nsVaJpS9
	 pYdJnIzXmFyHOUhsyJvG/hzrEXhQkXvDvhjqzDODoZuTo6ZB97ycBpcQQ6sKfuZL1q
	 ZhPNU4Pas7g8w==
Date: Sun, 17 Mar 2024 09:50:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 0/2] mm/madvise: make MADV_POPULATE_(READ|WRITE)
 handle VM_FAULT_RETRY properly
Message-ID: <20240317165017.GD1927156@frogsfrogsfrogs>
References: <20240314161300.382526-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314161300.382526-1-david@redhat.com>

On Thu, Mar 14, 2024 at 05:12:58PM +0100, David Hildenbrand wrote:
> Derrick reports that in some cases where pread() would fail with -EIO and
> mmap()+access would generate a SIGBUS signal, MADV_POPULATE_READ /
> MADV_POPULATE_WRITE will keep retrying forever and not fail with -EFAULT.
> 
> It all boils down to missing VM_FAULT_RETRY handling. Let's try to handle
> that in a better way, similar to how ordinary GUP handles it.
> 
> Details in patch #1. In short, move special MADV_POPULATE_(READ|WRITE)
> VMA handling into __get_user_pages(), and make faultin_page_range()
> call __get_user_pages_locked(), which handles VM_FAULT_RETRY. Further,
> avoid the now-useless madvise VMA walk, because __get_user_pages() will
> perform the VMA lookup either way.
> 
> I briefly played with handling the FOLL_MADV_POPULATE checks in
> __get_user_pages() a bit differently, integrating them with existing
> handling, but it ended up looking worse. So I decided to keep it simple.
> 
> Likely, we need better selftests, but the reproducer from Darrick might
> be a bit hard to convert into a simple selftest.
> 
> Note that using mlock() in Darricks reproducer results in a similar
> endless retry. Likely, that is not what we want, and we should handle
> VM_FAULT_RETRY in populate_vma_page_range() / __mm_populate() as well.
> However, similarly using __get_user_pages_locked() might be more
> complicated, because of the advanced VMA handling in
> populate_vma_page_range().
> 
> Further, most populate_vma_page_range() callers simply ignore the return
> values, so it's unclear in which cases we expect to just silently fail, or
> where we'd want to retry+fail or endlessly retry instead.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Hugh Dickins <hughd@google.com>

After a few days I haven't seen any problems, so
Tested-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> David Hildenbrand (2):
>   mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY
>     properly
>   mm/madvise: don't perform madvise VMA walk for
>     MADV_POPULATE_(READ|WRITE)
> 
>  mm/gup.c      | 54 ++++++++++++++++++++++++++++++---------------------
>  mm/internal.h | 10 ++++++----
>  mm/madvise.c  | 43 +++++++++++++---------------------------
>  3 files changed, 52 insertions(+), 55 deletions(-)
> 
> 
> base-commit: f48159f866f422371bb1aad10eb4d05b29ca4d8c
> -- 
> 2.43.2
> 

