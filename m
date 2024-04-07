Return-Path: <linux-kernel+bounces-134129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982189ADFD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F161F221FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED971879;
	Sun,  7 Apr 2024 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fHsQySQp"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDB17C9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712455553; cv=none; b=qSTHZL/x4URyd3o3WYcMdNtwq6AiTqa9yks5X41cGTFaEELqLjc3eY093auhuhKu4q/2W+vOoIC2v1J6TK6A1QPFrTW4DaJQfzQkvdpWE+V+HzjSF5wUjwUO6/v3wyvRBjsBqel8MhC3PPec65p097+rWTRUubhd9tPvenm5Eb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712455553; c=relaxed/simple;
	bh=itW1+FsSDP7MzJiW68SPB99UmrAE9+bbc/2h2NLCKdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baiTmikyDIegpchn2oq8o9EBrj+8qyZGgeTtGw94uQmmdARDoeh74jn4QAlJLGivtcvUSK55dqAXR6Xeks07wqBxBAS5OxkSjJls9QDzasXRdzFp2qeCBJQgJZVrbthtmUk8QUmqdHNWDA5myd85iw2lFVcoumQAoW1xXkGteqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fHsQySQp; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Apr 2024 22:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712455548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGX5JLi1/vbrsO57O+WszQdhNAOw0u9Oa/2lUx/+KOc=;
	b=fHsQySQpRihf20VPoaSm9f7f8mOrZMZYEzZ7wFsiR/dGQ3oDycZdAFg/O5ePjWEhUKUl/g
	w/9TBFUnzmQVhzOHAnegWbI8Z63qb8qs+G6oLpiznij/h6hMSc3S2HuZdiMfZJa6l5CnVd
	dbOSjtNLtaAo41kiZ3zrcn/cyH5y6XA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: bfoster@redhat.com, jserv@ccns.ncku.edu.tw, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Optimize eytzinger0_sort() with bottom-up
 heapsort
Message-ID: <3vvrirq3yljcuhjj5muvuk7quihllyfhzmygbb7rrchbgh7hzj@7psuth5ctxd5>
References: <20240407013349.672667-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407013349.672667-1-visitorckw@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 07, 2024 at 09:33:49AM +0800, Kuan-Wei Chiu wrote:
> This optimization reduces the average number of comparisons required
> from 2*n*log2(n) - 3*n + o(n) to n*log2(n) + 0.37*n + o(n). When n is
> sufficiently large, it results in approximately 50% fewer comparisons.
> 
> Currently, eytzinger0_sort employs the textbook version of heapsort,
> where during the heapify process, each level requires two comparisons
> to determine the maximum among three elements. In contrast, the
> bottom-up heapsort, during heapify, only compares two children at each
> level until reaching a leaf node. Then, it backtracks from the leaf
> node to find the correct position. Since heapify typically continues
> until very close to the leaf node, the standard heapify requires about
> 2*log2(n) comparisons, while the bottom-up variant only needs log2(n)
> comparisons.
> 
> The experimental data presented below is based on an array generated
> by get_random_u32().
> 
> |   N   | comparisons(old) | comparisons(new) | time(old) | time(new) |
> |-------|------------------|------------------|-----------|-----------|
> | 10000 |     235381       |     136615       |  25545 us |  20366 us |
> | 20000 |     510694       |     293425       |  31336 us |  18312 us |
> | 30000 |     800384       |     457412       |  35042 us |  27386 us |
> | 40000 |    1101617       |     626831       |  48779 us |  38253 us |
> | 50000 |    1409762       |     799637       |  62238 us |  46950 us |
> | 60000 |    1721191       |     974521       |  75588 us |  58367 us |
> | 70000 |    2038536       |    1152171       |  90823 us |  68778 us |
> | 80000 |    2362958       |    1333472       | 104165 us |  78625 us |
> | 90000 |    2690900       |    1516065       | 116111 us |  89573 us |
> | 100000|    3019413       |    1699879       | 133638 us | 100998 us |
> 
> Refs:
>   BOTTOM-UP-HEAPSORT, a new variant of HEAPSORT beating, on an average,
>   QUICKSORT (if n is not very small)
>   Ingo Wegener
>   Theoretical Computer Science, 118(1); Pages 81-98, 13 September 1993
>   https://doi.org/10.1016/0304-3975(93)90364-Y
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> 
> This is the same as the patch I submitted previously [1]. Since we
> decided not to move eytzinger.h to generic library code, I resubmitted
> this patch.
> 
> This patch has undergone unit testing and micro benchmarking using the
> following code [2].
> 
> [1]: https://lore.kernel.org/lkml/20240121153649.2733274-2-visitorckw@gmail.com/
> [2]:
> static u64 cmp_count = 0;
> 
> static int mycmp(const void *a, const void *b)
> {
> 	u32 _a = *(u32 *)a;
> 	u32 _b = *(u32 *)b;
> 
> 	cmp_count++;
> 	if (_a < _b)
> 		return -1;
> 	else if (_a > _b)
> 		return 1;
> 	else
> 		return 0;
> }
> 
> static int test(void)
> {
> 	size_t N, i, L, R;
> 	ktime_t start, end;
> 	s64 delta;
> 	u32 *arr;
> 
> 	for (N = 10000; N <= 100000; N += 10000) {
> 		arr = kmalloc_array(N, sizeof(u32), GFP_KERNEL);
> 		cmp_count = 0;
> 
> 		for (i = 0; i < N; i++)
> 			arr[i] = get_random_u32();
> 		
> 		start = ktime_get();
> 		eytzinger0_sort(arr, N, sizeof(u32), mycmp, NULL);
> 		end = ktime_get();
> 
> 		delta = ktime_us_delta(end, start);
> 		printk(KERN_INFO "time: %lld\n", delta);
> 		printk(KERN_INFO "comparisons: %lld\n", cmp_count);
> 
> 		for (int i = 0; i < N; i++) {
> 			L = 2 * i + 1;
> 			R = 2 * i + 2;
> 			if (L < N && arr[i] < arr[L])
> 				goto err;
> 			if (R < N && arr[i] > arr[R])
> 				goto err;
> 		}

Use eytzinger0_for_each() to just compare every element against the
previous element, and check in the test code.

> 
> 		kfree(arr);
> 	}
> 	return 0;
> 
> err:
> 	kfree(arr);
> 	return -1;
> }
> 
>  fs/bcachefs/eytzinger.c | 50 ++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
> index 0f955c3c76a7..9a99a1410d12 100644
> --- a/fs/bcachefs/eytzinger.c
> +++ b/fs/bcachefs/eytzinger.c
> @@ -171,7 +171,7 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
>  		       swap_r_func_t swap_func,
>  		       const void *priv)
>  {
> -	int i, c, r;
> +	int i, j, k;
>  
>  	/* called from 'sort' without swap function, let's pick the default */
>  	if (swap_func == SWAP_WRAPPER && !((struct wrapper *)priv)->swap_func)
> @@ -188,17 +188,22 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
>  
>  	/* heapify */
>  	for (i = n / 2 - 1; i >= 0; --i) {
> -		for (r = i; r * 2 + 1 < n; r = c) {
> -			c = r * 2 + 1;
> -
> -			if (c + 1 < n &&
> -			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
> -				c++;
> -
> -			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
> -				break;
> -
> -			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
> +		/* Find the sift-down path all the way to the leaves. */
> +		for (j = i; k = j * 2 + 1, k + 1 < n;)
> +			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
> +
> +		/* Special case for the last leaf with no sibling. */
> +		if (j * 2 + 2 == n)
> +			j = j * 2 + 1;
> +
> +		/* Backtrack to the correct location. */
> +		while (j != i && eytzinger0_do_cmp(base, n, size, cmp_func, priv, i, j) >= 0)
> +			j = (j - 1) / 2;
> +
> +		/* Shift the element into its correct place. */
> +		for (k = j; j != i;) {
> +			j = (j - 1) / 2;
> +			eytzinger0_do_swap(base, n, size, swap_func, priv, j, k);
>  		}
>  	}
>  
> @@ -206,17 +211,22 @@ void eytzinger0_sort_r(void *base, size_t n, size_t size,
>  	for (i = n - 1; i > 0; --i) {
>  		eytzinger0_do_swap(base, n, size, swap_func, priv, 0, i);
>  
> -		for (r = 0; r * 2 + 1 < i; r = c) {
> -			c = r * 2 + 1;
> +		/* Find the sift-down path all the way to the leaves. */
> +		for (j = 0; k = j * 2 + 1, k + 1 < i;)
> +			j = eytzinger0_do_cmp(base, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
>  
> -			if (c + 1 < i &&
> -			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
> -				c++;
> +		/* Special case for the last leaf with no sibling. */
> +		if (j * 2 + 2 == i)
> +			j = j * 2 + 1;
>  
> -			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
> -				break;
> +		/* Backtrack to the correct location. */
> +		while (j && eytzinger0_do_cmp(base, n, size, cmp_func, priv, 0, j) >= 0)
> +			j = (j - 1) / 2;
>  
> -			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
> +		/* Shift the element into its correct place. */
> +		for (k = j; j;) {
> +			j = (j - 1) / 2;
> +			eytzinger0_do_swap(base, n, size, swap_func, priv, j, k);
>  		}
>  	}
>  }
> -- 
> 2.34.1
> 

