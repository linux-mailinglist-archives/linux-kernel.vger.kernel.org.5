Return-Path: <linux-kernel+bounces-53898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F295784A7CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B40B1F2ABC3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964D12F39D;
	Mon,  5 Feb 2024 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txhdvRjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0E12F388;
	Mon,  5 Feb 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163872; cv=none; b=SSCLjcGn888PVMQJZX1MYMA0kMXid3nKffC8nkx90KLOAr/NM/kT9TXYH9Bwt89jCGFuRWPJnaxKbB5vvBI65AH9FpqZSHfXP45t27jRraIckWfNpsBDEN2bE4Ssyjxf+wqAdG8pihOkyW9N2gXdn8hdFpLHrXuEwH6uuuegtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163872; c=relaxed/simple;
	bh=5A3KTajyzlfiyqCx6ogaKRTMf5L1vQAHm6WF8BBbYi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etFxDB1iCiOu8bcOSuOyGlL4GHUrHNDOFU/LXTiFHeYUBDAVRNFgWVM/B6hWH/ciM+cxue37IW+vD58TvQRmn7cbS9HDl9SZvULd/2MF5TZshKPjY9Zvlwk0OgGAsVfcCuqj6Rpd8H+YNGSwrRv9zhqLr4+xkGrOMi4JGZ6l94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txhdvRjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C3AC433F1;
	Mon,  5 Feb 2024 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707163871;
	bh=5A3KTajyzlfiyqCx6ogaKRTMf5L1vQAHm6WF8BBbYi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txhdvRjNQDUnze0TucLwhHlfWSx5DElOfsPrV5PZgEMf2b7PGJ/Xh1MSSnX2klFqg
	 BJtBpFfMuP8EskcGjS53a8adKDToULjwu8IWUKEootYIgDe90zxJSWYtoiKMgAlNgV
	 sf4uFBsPQnQRCMpTBuXqi5KG1jTujQMP5ySigq26P1HBCG/P9KetItERYRdCExTc/g
	 CbvEx/upsHlR1l71/7Md1L4+looSE206zPMzewBRcz+WNTElEOcVuvbfyI5KQ+WO9l
	 CmoXpwmxAqZD8THlalIxap/J8gMrw/dGEzCj4QjWoE32UuRWd08myV19m+eA8it2IA
	 sq+FGC6v342Qg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: check apply interval in
Date: Mon,  5 Feb 2024 12:11:09 -0800
Message-Id: <20240205201109.88463-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240204204946.87265-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I mistakenly broke the subject of the patch.  I will send the complete one
again.

On Sun,  4 Feb 2024 12:49:46 -0800 SeongJae Park <sj@kernel.org> wrote:

> kdamond_apply_schemes() checks apply intervals of schemes and avoid
> further applying any schemes if no scheme passed its apply interval.
> However, the following schemes applying function,
> damon_do_apply_schemes() iterates all schemes without the apply interval
> check.  As a result, the shortest apply interval is applied to all
> schemes.  Fix the problem by checking the apply interval in
> damon_do_apply_schemes().
> 
> Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
> Cc: <stable@vger.kernel.org> # 6.7.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0c144fb466b8..f444734cc613 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1064,6 +1064,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
>  	damon_for_each_scheme(s, c) {
>  		struct damos_quota *quota = &s->quota;
>  
> +		if (c->passed_sample_intervals != s->next_apply_sis)
> +			continue;
> +
>  		if (!s->wmarks.activated)
>  			continue;
>  
> @@ -1216,10 +1219,6 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  		if (c->passed_sample_intervals != s->next_apply_sis)
>  			continue;
>  
> -		s->next_apply_sis +=
> -			(s->apply_interval_us ? s->apply_interval_us :
> -			 c->attrs.aggr_interval) / sample_interval;
> -
>  		if (!s->wmarks.activated)
>  			continue;
>  
> @@ -1235,6 +1234,14 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  		damon_for_each_region_safe(r, next_r, t)
>  			damon_do_apply_schemes(c, t, r);
>  	}
> +
> +	damon_for_each_scheme(s, c) {
> +		if (c->passed_sample_intervals != s->next_apply_sis)
> +			continue;
> +		s->next_apply_sis +=
> +			(s->apply_interval_us ? s->apply_interval_us :
> +			 c->attrs.aggr_interval) / sample_interval;
> +	}
>  }
>  
>  /*
> -- 
> 2.39.2

