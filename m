Return-Path: <linux-kernel+bounces-103986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79287C775
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F482281B65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F7B7476;
	Fri, 15 Mar 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHfJmHPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A16FBD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469541; cv=none; b=Rz/eHF34tc2oRNGKF0Y3+bk8OmKYpik7b5VXT/7gPi6esSZ/CU38oi+Qi1NCykM36CR3zwBBRQUf9ZFb5DqWnOjuiSXHMINtLKy0ogdSHqSpXMSBxKaQxvfq9Jq0kSPeYqCY3zzhQSxhHtWjjBP/ZyTjHhKu3Y9pXssV1GaoO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469541; c=relaxed/simple;
	bh=g/yhIwX3XvlhVWvh9kFVm4R5Le/gPv0TUWKca6Jwjg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxpK9uvJCeOK8T3vRuVdwybSBPHjhz/c04krvO7MrAOh/5hSB4sx1hH3GMDnAzqJOrvjiIfc/koo4V3Zo/3LSPGEP1iRB00V6HnZB07hNUp9spYZNXt3tSfifymNa+qBVckL516uQIgGnZaQKv7Vgi7pBymw0zlIH/UmIOELJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHfJmHPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C15C433F1;
	Fri, 15 Mar 2024 02:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710469541;
	bh=g/yhIwX3XvlhVWvh9kFVm4R5Le/gPv0TUWKca6Jwjg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHfJmHPB3o7/qILSKnQc+WnzSMZV7uO0+2RHkjCoTkkOPCf7lJ6Xs8+s9mQqFQOXq
	 Q9bsU3hHzrcgg8Pz0LC5eq7jHm45z4awbJ8Rft9uSYiydDzVshBpHFGBThJhdyCrU4
	 cmVXJ7lfClQBP7R6B0ii2DH7uGqhRLTlI62ROyic7LE/Cr9BEOUfVNxJjlzEca2Cn5
	 LlzOD9mlM5hIyDjKLwxv/5/Q5O4jb3Rd5RUzv46uaL0vYFB8AW1cyH9c5z+SJYh/X3
	 8Je0Bg93ytVSqel5I/KPQmBXOaRwenUBklQBdd2y7p7qSJmxmOtsmsethDdeEfuPXo
	 peoQ2a3m0XQ7A==
Date: Thu, 14 Mar 2024 19:25:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 0/2] mm/madvise: make MADV_POPULATE_(READ|WRITE)
 handle VM_FAULT_RETRY properly
Message-ID: <20240315022540.GD6226@frogsfrogsfrogs>
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

No worries, I can convert my reproducer into an fstest.  I actually had
no idea that there were so many madvise flags, it's tempting to wire up
fsx and fsstress so that the long soak group tests will exercise them.

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

With this patchset applied, my reproducer no longer gets stuck in an
infinite loop.  I'll throw this at fstests overnight and see if anything
else falls out.  Thank you!

--D

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Hugh Dickins <hughd@google.com>
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

