Return-Path: <linux-kernel+bounces-134161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA889AE67
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B1E1C21D02
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647025240;
	Sun,  7 Apr 2024 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UeQyHtIc"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E7184D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712463150; cv=none; b=arzsDZSjGYxFL4wINj3PCKjqDgs6BXOzTKnLuoLee1SPpoJjfFrkfqP0HLU+TnPQ4cpR/PX4ePwyQisxdHFzYDCsHuLVF0bMe/WoKS5sFPqh95rQk4LthwcBf4vz91pHh3fJsBB/RRXSJclP/OpKAw6D0i7ss7hSQHTISBNRPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712463150; c=relaxed/simple;
	bh=Z4KqCREDgBjK4L8+1jCUewIR3d1elGDVnhZBpRAtp2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFnvHsYeY3TmScKOrInBlR/nBNrn7Qky2e2x1zAyuAyujf/2hwym+25FA7sA3aLpFnYb7jB6cjo/WBx/+N1EBvXwAEOO/4iMnum4Rb7qfPMsK5iRyFCtIGlOloy1KKWEM+q8+ToZBKwIeIIe9JSzwvjhXA+DurHTOL2PWNExOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UeQyHtIc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 7 Apr 2024 00:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712463145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Akf+5PjShga/Knr2bfSD++VsHqynTRQPRIszKrS9DM=;
	b=UeQyHtIcV8Lc9NLfxaHwq2NA4kugPQURyVr0yc8mvtcEdG89Mx3lf4G5NShmKMKMlpE89B
	S1N2HFQiycv1UV2Hu/oGKV0I0fJfG3GjA2TmLEJiL+088ODm4rOHH+Sn6UAUkQxbSwyRbD
	Vhzo++NSvrLpOtgtlCfaAgqwlGuAcmE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: bfoster@redhat.com, jserv@ccns.ncku.edu.tw, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bcachefs: Optimize eytzinger0_sort() with bottom-up
 heapsort
Message-ID: <jx6yufij6gygb6ypsoq2yhw3eb3nobr4ytnb7phgmbpn5gmtws@23hu2rwhm4mt>
References: <2vm32rfcbgy4fap77scebqorlrpaihz3angd6bl2lnpslrcp63@kekiknxt5vup>
 <20240407033904.719773-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407033904.719773-1-visitorckw@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 07, 2024 at 11:39:04AM +0800, Kuan-Wei Chiu wrote:
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

Thanks - applied

