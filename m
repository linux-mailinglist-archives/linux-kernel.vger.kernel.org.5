Return-Path: <linux-kernel+bounces-134142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5220D89AE2C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75D91F22904
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281A1C0DCC;
	Sun,  7 Apr 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nEsTCdnZ"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA81849
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712459572; cv=none; b=WOdTGCa70MaNZcnA+LiNiw6SkqqWTSKncrjtqbFUS4PvfJWyprdkLJRAwBuIy8h0U2MZI7UIrEOIg++RFpphm5IzWLB9mBYSTLENxDgZRjWYrXy1oRYCnn2shkRKdbtumFI+b1pdL/MPR2GAjlsOWVPkiQT/Lt2NOrEktW0RjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712459572; c=relaxed/simple;
	bh=Rc61LzNdTZPfPgNdAA45w0QSG+0bHjA+F0vyslCayLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1bUDluOPr4eh28scaNBr8vX0cOpDy5dF7xQCkznnyldV/yBdj4rLxynUZqXti70L227+E6NVQzIwdmjPjkLvmTDdlbMI96lhmrautPUs0la+/kv8e5v/ImWKJWfXdcLb54mBSt1r8SrPhwAqA1HKF0RHDkhDgVEy/RHuIqgIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nEsTCdnZ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Apr 2024 23:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712459568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGaVxMBPzojr3QEvcEsSTcQ874uMtXte1lfsEYDwdcI=;
	b=nEsTCdnZCB27a6kMWxaRR+KGaCwwkNWTVVHiOnCP3INe/yOd+NhfZGDMkYjcj5oqaZMaDb
	ZQX7Puz3FOBEEvNdKWQUjnPmUTo4GeDGTatjvw7eh136k3/LKyog9osYjOCxZ58pExgkFN
	MXCn7js6CYHAzbqPET86iaGcXNd47eE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: bfoster@redhat.com, jserv@ccns.ncku.edu.tw, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Optimize eytzinger0_sort() with bottom-up
 heapsort
Message-ID: <2vm32rfcbgy4fap77scebqorlrpaihz3angd6bl2lnpslrcp63@kekiknxt5vup>
References: <20240407013349.672667-1-visitorckw@gmail.com>
 <3vvrirq3yljcuhjj5muvuk7quihllyfhzmygbb7rrchbgh7hzj@7psuth5ctxd5>
 <ZhIK9gcY4ptAHUq6@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhIK9gcY4ptAHUq6@visitorckw-System-Product-Name>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 07, 2024 at 10:54:46AM +0800, Kuan-Wei Chiu wrote:
> On Sat, Apr 06, 2024 at 10:05:44PM -0400, Kent Overstreet wrote:
> > On Sun, Apr 07, 2024 at 09:33:49AM +0800, Kuan-Wei Chiu wrote:
> > > This optimization reduces the average number of comparisons required
> > > from 2*n*log2(n) - 3*n + o(n) to n*log2(n) + 0.37*n + o(n). When n is
> > > sufficiently large, it results in approximately 50% fewer comparisons.
> > > 
> > > Currently, eytzinger0_sort employs the textbook version of heapsort,
> > > where during the heapify process, each level requires two comparisons
> > > to determine the maximum among three elements. In contrast, the
> > > bottom-up heapsort, during heapify, only compares two children at each
> > > level until reaching a leaf node. Then, it backtracks from the leaf
> > > node to find the correct position. Since heapify typically continues
> > > until very close to the leaf node, the standard heapify requires about
> > > 2*log2(n) comparisons, while the bottom-up variant only needs log2(n)
> > > comparisons.
> > > 
> > > The experimental data presented below is based on an array generated
> > > by get_random_u32().
> > > 
> > > |   N   | comparisons(old) | comparisons(new) | time(old) | time(new) |
> > > |-------|------------------|------------------|-----------|-----------|
> > > | 10000 |     235381       |     136615       |  25545 us |  20366 us |
> > > | 20000 |     510694       |     293425       |  31336 us |  18312 us |
> > > | 30000 |     800384       |     457412       |  35042 us |  27386 us |
> > > | 40000 |    1101617       |     626831       |  48779 us |  38253 us |
> > > | 50000 |    1409762       |     799637       |  62238 us |  46950 us |
> > > | 60000 |    1721191       |     974521       |  75588 us |  58367 us |
> > > | 70000 |    2038536       |    1152171       |  90823 us |  68778 us |
> > > | 80000 |    2362958       |    1333472       | 104165 us |  78625 us |
> > > | 90000 |    2690900       |    1516065       | 116111 us |  89573 us |
> > > | 100000|    3019413       |    1699879       | 133638 us | 100998 us |
> > > 
> > > Refs:
> > >   BOTTOM-UP-HEAPSORT, a new variant of HEAPSORT beating, on an average,
> > >   QUICKSORT (if n is not very small)
> > >   Ingo Wegener
> > >   Theoretical Computer Science, 118(1); Pages 81-98, 13 September 1993
> > >   https://doi.org/10.1016/0304-3975(93)90364-Y
> > > 
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > > 
> > > This is the same as the patch I submitted previously [1]. Since we
> > > decided not to move eytzinger.h to generic library code, I resubmitted
> > > this patch.
> > > 
> > > This patch has undergone unit testing and micro benchmarking using the
> > > following code [2].
> > > 
> > > [1]: https://lore.kernel.org/lkml/20240121153649.2733274-2-visitorckw@gmail.com/
> > > [2]:
> > > static u64 cmp_count = 0;
> > > 
> > > static int mycmp(const void *a, const void *b)
> > > {
> > > 	u32 _a = *(u32 *)a;
> > > 	u32 _b = *(u32 *)b;
> > > 
> > > 	cmp_count++;
> > > 	if (_a < _b)
> > > 		return -1;
> > > 	else if (_a > _b)
> > > 		return 1;
> > > 	else
> > > 		return 0;
> > > }
> > > 
> > > static int test(void)
> > > {
> > > 	size_t N, i, L, R;
> > > 	ktime_t start, end;
> > > 	s64 delta;
> > > 	u32 *arr;
> > > 
> > > 	for (N = 10000; N <= 100000; N += 10000) {
> > > 		arr = kmalloc_array(N, sizeof(u32), GFP_KERNEL);
> > > 		cmp_count = 0;
> > > 
> > > 		for (i = 0; i < N; i++)
> > > 			arr[i] = get_random_u32();
> > > 		
> > > 		start = ktime_get();
> > > 		eytzinger0_sort(arr, N, sizeof(u32), mycmp, NULL);
> > > 		end = ktime_get();
> > > 
> > > 		delta = ktime_us_delta(end, start);
> > > 		printk(KERN_INFO "time: %lld\n", delta);
> > > 		printk(KERN_INFO "comparisons: %lld\n", cmp_count);
> > > 
> > > 		for (int i = 0; i < N; i++) {
> > > 			L = 2 * i + 1;
> > > 			R = 2 * i + 2;
> > > 			if (L < N && arr[i] < arr[L])
> > > 				goto err;
> > > 			if (R < N && arr[i] > arr[R])
> > > 				goto err;
> > > 		}
> > 
> > Use eytzinger0_for_each() to just compare every element against the
> > previous element, and check in the test code.
> >
> 
> I rewrote the testing part as follows:
> 
> 	u32 prev = 0;
> 	eytzinger0_for_each(i, N) {
> 		if (prev > arr[i])
> 			goto err;
> 		prev = arr[i];
> 	}
> 
> And the test still passed.

Great, can you include that? I'd be fine with it #if 0'd out, I just
want it there.

