Return-Path: <linux-kernel+bounces-93290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA517872D95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE98B2310F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7114280;
	Wed,  6 Mar 2024 03:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dihLCKc9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090BDDA8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696500; cv=none; b=heNz8qJQCq0PAKMWrEPUhshikNWXpQbwxKk+wayDQU/c14yvwx/eIymDICTLj7mNCz2YwXcDdl3M0aAVwL4ZApjYJDFiQ4sbnRd7R9JO3qhR2WvhJ/Esl6LQ7+q/LTd2oZo6CDYbNt9D7DP9L9/gO3MCGKAstbAI2tMVkAN+oS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696500; c=relaxed/simple;
	bh=peL5XKtzLDxmuF6iVVN++9xuEPx8Bz/akBSfgvOkuXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPELSPZoOf5q21taXWniDA0R4tbsbngqw9dCs76RFxk5j4IazC3ZlbBCyTNCNegSpl7vQckE8ATZhyNl+ETQQmzDgf+IJt8tVO3T8MWq3qxg5sTZmlqDXqCM/Y3fByBQh0AowXmpLSHDIVEblkYqBDp7At7lfu1Y/yTdxecvCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dihLCKc9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709696497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibcI34pthASxYoHGlqW8DKfcW+bBdFdXjr+O0iXne5g=;
	b=dihLCKc9x6ZdysnjF24qoczYooT/KXgK4tMpw2+mB3OjfYWN3L1W74Zlipo/nhGqhfBY4i
	zOpXfTaTgxmwMkkIDOhShTCGm34BTcAjpTyc68BuIqRlTnOhWzB4GjpisJDeBJgwSQ1cUY
	rYWfuvhSzfCNnUgGP2D4hZGgFZgjLsQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ckYwjQulOv6zVUSUPbPBtQ-1; Tue, 05 Mar 2024 22:41:35 -0500
X-MC-Unique: ckYwjQulOv6zVUSUPbPBtQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29999b97b39so2320457a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 19:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696495; x=1710301295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibcI34pthASxYoHGlqW8DKfcW+bBdFdXjr+O0iXne5g=;
        b=Sb+klRCVa5w9JrvL9+cSgxJsrWox/J8JeriWoJDvAJTZEtkKSk4YDpJNCSx6d9qPT+
         HCpDsJK2uBWIvUpb13lF/AexO3hgMGjQkcd+d6RARWH93WGuCq9ZabgeMIlv2CWqff1R
         n9jS0NULU6ORgPx6/UmHcrht5hRXvjC46Rg4lBIkNficUitc1w8kVmoRn8pUL5phrY4M
         Z+d/j+DPh8iql+8/zRePCe0nYIxVwVaxI0Kc2EpSmu8knzQMhOY/SbMJIAzR2wQgnLeA
         eoJPkTHTOfMsZfjkVpuJvXwuqIAngWJGMpjW5OzK3K4Qz8mpc8DnV3EF16tS1eeVjEk+
         /2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkmRWmtBBSZ41XMWGd3/JTjSZyCSKhKxmONPljIVWPPh5GIFtQJMqZZcDfIeYxYTm4SgiA7rdlV0xfGKpC3Nd8j1e9PYzNkjEAU44j
X-Gm-Message-State: AOJu0Yxsz0rruicZGgUuMhOXcP4OPyAyy/ozLiLtDBWQaxmFpsTPvIpN
	7AZ1+smADfI9wd6U2HRHkMwS9ny3EwxrW6u+0gDMQlHafVhPLMFDuqHTKKulb3we981l52iieft
	rbR/PTRTEkEZ47vlB2ZwCPsqDS2ZUpoYPr/I3Ma9+NXofM2uoiKkleWCDdTXTIQ==
X-Received: by 2002:a05:6a21:9991:b0:1a1:4de6:dd5c with SMTP id ve17-20020a056a21999100b001a14de6dd5cmr2748320pzb.2.1709696494710;
        Tue, 05 Mar 2024 19:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjHhh3h0Xf8t67GGbynTvJ4/UD8RBKKUQMtZxWtlMf3sAOFnxKDqr+xcp4qacl12ghUUXbdw==
X-Received: by 2002:a05:6a21:9991:b0:1a1:4de6:dd5c with SMTP id ve17-20020a056a21999100b001a14de6dd5cmr2748312pzb.2.1709696494245;
        Tue, 05 Mar 2024 19:41:34 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090aa00e00b0029b32b85d3dsm6698735pjp.29.2024.03.05.19.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 19:41:33 -0800 (PST)
Date: Wed, 6 Mar 2024 11:41:26 +0800
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Add an explicit smp_wmb() to UFFDIO_CONTINUE
Message-ID: <Zefl5mJ32IxxYtaF@x1n>
References: <20240306001511.932348-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240306001511.932348-1-jthoughton@google.com>

On Wed, Mar 06, 2024 at 12:15:10AM +0000, James Houghton wrote:
> Users of UFFDIO_CONTINUE may reasonably assume that a write memory
> barrier is included as part of UFFDIO_CONTINUE. That is, a user may
> (mistakenly) believe that all writes it has done to a page that it is
> now UFFDIO_CONTINUE'ing are guaranteed to be visible to anyone
> subsequently reading the page through the newly mapped virtual memory
> region.
> 
> Include only a single smp_wmb() for each UFFDIO_CONTINUE, as that is all
> that is necessary. While we're at it, optimize the smp_wmb() that is
> already incidentally present for the HugeTLB case.
> 
> Documentation doesn't specify if the kernel does a wmb(), so it's not
> wrong not to include it. But by not including it, we are making is easy
> for a user to have a very hard-to-detect bug. Include it now to be safe.
> 
> A user that decides to update the contents of the page in one thread and
> UFFDIO_CONTINUE that page in another must already take additional steps
> to synchronize properly.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
> 
> I'm not sure if this patch should be merged. I think it's the right
> thing to do, as it is very easy for a user to get this wrong. (I have
> been using UFFDIO_CONTINUE for >2 years and only realized this problem
> recently.) Given that it's not a "bug" strictly speaking, even if this
> patch is a good idea, I'm unsure if it needs to be backported.
> 
> This quirk has existed since minor fault support was added for shmem[1].
> 
> I've tried to see if I can legitimately get a user to read stale data,
> and a few attempts with this test[2] have been unsuccessful.

AFAICT that won't easily reproduce even if the problem existed, as we
contain so many implict memory barriers here and there.  E.g. right at the
entry of ioctl(), mmget_not_zero() already contains a full ordering
constraint:

/**
 * atomic_inc_not_zero() - atomic increment unless zero with full ordering
 * @v: pointer to atomic_t

I was expecting the syscall routine will guarantee an ordering already but
indeed I can't find any.  I also checked up Intel's spec and SYSCALL inst
document only has one paragraph on ordering:

        Instruction ordering. Instructions following a SYSCALL may be
        fetched from memory before earlier instructions complete execution,
        but they will not execute (even speculatively) until all
        instructions prior to the SYSCALL have completed execution (the
        later instructions may execute before data stored by the earlier
        instructions have become globally visible).

I guess it implies a hardware reordering is indeed possible in this case?

> 
> [1]: commit 153132571f02 ("userfaultfd/shmem: support UFFDIO_CONTINUE for shmem")
> [2]: https://gist.github.com/48ca/38d0665b0f1a6319a56507dc73a173f9
> 
>  mm/hugetlb.c     | 15 +++++++++------
>  mm/userfaultfd.c | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bb17e5c22759..533bf6b2d94d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6779,12 +6779,15 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  		}
>  	}
>  
> -	/*
> -	 * The memory barrier inside __folio_mark_uptodate makes sure that
> -	 * preceding stores to the page contents become visible before
> -	 * the set_pte_at() write.
> -	 */
> -	__folio_mark_uptodate(folio);
> +	if (!is_continue) {
> +		/*
> +		 * The memory barrier inside __folio_mark_uptodate makes sure
> +		 * that preceding stores to the page contents become visible
> +		 * before the set_pte_at() write.
> +		 */
> +		__folio_mark_uptodate(folio);

Can we move the comment above the "if", explaining both conditions?

> +	} else
> +		WARN_ON_ONCE(!folio_test_uptodate(folio));
>  
>  	/* Add shared, newly allocated pages to the page cache. */
>  	if (vm_shared && !is_continue) {
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 503ea77c81aa..d515b640ca48 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -531,6 +531,10 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  			goto out_unlock;
>  	}
>  
> +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> +		/* See the comment in mfill_atomic. */
> +		smp_wmb();
> +
>  	while (src_addr < src_start + len) {
>  		BUG_ON(dst_addr >= dst_start + len);
>  
> @@ -743,6 +747,20 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
>  		goto out_unlock;
>  
> +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> +		/*
> +		 * A caller might reasonably assume that UFFDIO_CONTINUE
> +		 * contains a wmb() to ensure that any writes to the
> +		 * about-to-be-mapped page by the thread doing the
> +		 * UFFDIO_CONTINUE are guaranteed to be visible to subsequent
> +		 * reads of the page through the newly mapped address.
> +		 *
> +		 * For MFILL_ATOMIC_COPY, the wmb() is done for each COPYed
> +		 * page. We can do the wmb() now for CONTINUE as the user has
> +		 * already prepared the page contents.
> +		 */
> +		smp_wmb();
> +

Why you did it twice separately?  Can we still share the code?

I'm wildly guessing: I don't worry on an extra wmb() in failure paths, as
that's never a performance concern to make failure slightly slower, IMHO.

Thanks,

>  	while (src_addr < src_start + len) {
>  		pmd_t dst_pmdval;
>  
> 
> base-commit: a7f399ae964e1d2a11d88d863a1d64392678ccaf
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

-- 
Peter Xu


