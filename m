Return-Path: <linux-kernel+bounces-21551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C6829108
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BFE1F20CCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE93E485;
	Tue,  9 Jan 2024 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQeKOsM9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ACB3E480
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA85C433F1;
	Tue,  9 Jan 2024 23:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704844384;
	bh=vwKOfafdCokp96wmQa5YnL/u1Ge2PlNEhiViBts/sFs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GQeKOsM9loQGp1zsYZo2Ns4aITy4Bx5NsNZ6NpeGLfODyY2WIFfPB11V+dLP4hQP/
	 wZw/arEokJSSZIdgE+A5vuuFSBVevUvYvs+uPBjegwHctA3P+MlF/9Cx1b1eEMLC8U
	 x35olFTHZDwmeBdk+F9EbS9pcG2HbFz821JRhGjgNAj1GMO1HYD+TpnjrtVTF8UYcz
	 sjSx8BYq3e1nKhokkvC33C4ejGxWbNBOkUzNtbnW4h3H6iOnSH3m+9/fVxi0K2tKJK
	 wNiKbe0ozv259XI60pWL3eO84tIipxR9aTBLBSHbL0GACiQD71UXRjNphMaSoBUZee
	 DkVecu0kPFhJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 485A0CE15CD; Tue,  9 Jan 2024 15:53:04 -0800 (PST)
Date: Tue, 9 Jan 2024 15:53:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] kasan: avoid resetting aux_lock
Message-ID: <b56444a5-c2f6-42f8-8722-badcdbb3de62@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240109221234.90929-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109221234.90929-1-andrey.konovalov@linux.dev>

On Tue, Jan 09, 2024 at 11:12:34PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
> 
> With commit 63b85ac56a64 ("kasan: stop leaking stack trace handles"),
> KASAN zeroes out alloc meta when an object is freed. The zeroed out data
> purposefully includes alloc and auxiliary stack traces but also
> accidentally includes aux_lock.
> 
> As aux_lock is only initialized for each object slot during slab
> creation, when the freed slot is reallocated, saving auxiliary stack
> traces for the new object leads to lockdep reports when taking the
> zeroed out aux_lock.
> 
> Arguably, we could reinitialize aux_lock when the object is reallocated,
> but a simpler solution is to avoid zeroing out aux_lock when an object
> gets freed.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Closes: https://lore.kernel.org/linux-next/5cc0f83c-e1d6-45c5-be89-9b86746fe731@paulmck-laptop/
> Fixes: 63b85ac56a64 ("kasan: stop leaking stack trace handles")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Very good!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  mm/kasan/generic.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 24c13dfb1e94..df6627f62402 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -487,6 +487,7 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>  		__memset(alloc_meta, 0, sizeof(*alloc_meta));
>  
>  		/*
> +		 * Prepare the lock for saving auxiliary stack traces.
>  		 * Temporarily disable KASAN bug reporting to allow instrumented
>  		 * raw_spin_lock_init to access aux_lock, which resides inside
>  		 * of a redzone.
> @@ -510,8 +511,13 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
>  	stack_depot_put(meta->aux_stack[0]);
>  	stack_depot_put(meta->aux_stack[1]);
>  
> -	/* Zero out alloc meta to mark it as invalid. */
> -	__memset(meta, 0, sizeof(*meta));
> +	/*
> +	 * Zero out alloc meta to mark it as invalid but keep aux_lock
> +	 * initialized to avoid having to reinitialize it when another object
> +	 * is allocated in the same slot.
> +	 */
> +	__memset(&meta->alloc_track, 0, sizeof(meta->alloc_track));
> +	__memset(meta->aux_stack, 0, sizeof(meta->aux_stack));
>  }
>  
>  static void release_free_meta(const void *object, struct kasan_free_meta *meta)
> -- 
> 2.25.1
> 

