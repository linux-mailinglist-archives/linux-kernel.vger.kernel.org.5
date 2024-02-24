Return-Path: <linux-kernel+bounces-79795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF818626DF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA28B21DD9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AB481BD;
	Sat, 24 Feb 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp5EO/Km"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413013FF6;
	Sat, 24 Feb 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708801378; cv=none; b=OgstdBg0Sglf+q5O1ANvPQouqET0kdbaJh2EmnEKvTZg76Dfkyjt8bBGzsdbl6tXo0IkuXCoU+GefEN4tnjR28c5DD0PDvzJxaJYsix5QbOk8sOKUIfwvjXtSDy69vX/Tkl4N4aRu9+TNah9dLQMf2aPsrsY0ALbBECVP7BX3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708801378; c=relaxed/simple;
	bh=CPTtSiUAW9ek5cTfmW4yjbTl4pvfe0S34pxaaji0qt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfVj5gQD2tb1ZuuKaZafFnxiJtNoy2rWZRUDpDZmppfq3SqYrIGnnj1FSsjlHiUgrVmeQr8SyFzsjLBH2opAKr4o6orQwih5H4n/jUhYUYt4afVb8P+GjOqF82RE04Xx6KmsS4qsJOYkCmTNrilyIckcPNNDXPPoVOU27UvdZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp5EO/Km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59EFC433C7;
	Sat, 24 Feb 2024 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708801377;
	bh=CPTtSiUAW9ek5cTfmW4yjbTl4pvfe0S34pxaaji0qt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kp5EO/KmpcW8kIT8p9pkV+DJRwCxsTo5qK9ZNPbp7EuyISsRR7rSfdBwyX5B0R+gf
	 /1paXPhJrqr8VrlW0UqFrFL4Ys8CarZxhYj5DiTp2IB9CGXBfZtNwHuK+SerzPq14K
	 aEI+wP7dxdUt3wvL7cbLHDbZicbyWxaKg6PTYZy/xDLrKArwTUDnTcq0RGLMbnIPcN
	 TcAIA4pr5hJEapNY9OmkJLNZsp2R7WFCQtFX131y47g/HwJVP1VPnpZYp8MyflBRWj
	 F6VtiIWneS27exo6lV/3tj/wS/UCJ7+utbaN1sgJaa8gWg10GaEzoaUmMYCz9qmXj2
	 QRcXF/Eph1ZDw==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	minchan@kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than clearing young
Date: Sat, 24 Feb 2024 11:02:55 -0800
Message-Id: <20240224190255.45616-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223041550.77157-1-21cnbao@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 17:15:50 +1300 Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <v-songbaohua@oppo.com>
> 
> While doing MADV_PAGEOUT, the current code will clear PTE young
> so that vmscan won't read young flags to allow the reclamation
> of madvised folios to go ahead.
> It seems we can do it by directly ignoring references, thus we
> can remove tlb flush in madvise and rmap overhead in vmscan.
> 
> Regarding the side effect, in the original code, if a parallel
> thread runs side by side to access the madvised memory with the
> thread doing madvise, folios will get a chance to be re-activated
> by vmscan. But with the patch, they will still be reclaimed. But
> this behaviour doing PAGEOUT and doing access at the same time is
> quite silly like DoS. So probably, we don't need to care.

I think we might need to take care of the case, since users may use just a
best-effort estimation like DAMON for the target pages.  In such cases, the
page granularity re-check of the access could be helpful.  So I concern if this
could be a visible behavioral change for some valid use cases.

> 
> A microbench as below has shown 6% decrement on the latency of
> MADV_PAGEOUT,

I assume some of the users may use MADV_PAGEOUT for proactive reclamation of
the memory.  In the use case, I think latency of MADV_PAGEOUT might be not that
important.

Hence I think the cons of the behavioral change might outweigh the pros of the
latench improvement, for such best-effort proactive reclamation use case.  Hope
to hear and learn from others' opinions.

> 
>  #define PGSIZE 4096
>  main()
>  {
>  	int i;
>  #define SIZE 512*1024*1024
>  	volatile long *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>  			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
>  	for (i = 0; i < SIZE/sizeof(long); i += PGSIZE / sizeof(long))
>  		p[i] =  0x11;
> 
>  	madvise(p, SIZE, MADV_PAGEOUT);
>  }
> 
> w/o patch                    w/ patch
> root@10:~# time ./a.out      root@10:~# time ./a.out
> real	0m49.634s            real   0m46.334s
> user	0m0.637s             user   0m0.648s
> sys	0m47.434s            sys    0m44.265s
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>


Thanks,
SJ

[...]

