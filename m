Return-Path: <linux-kernel+bounces-133518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E259589A4CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B29A285A10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35B173320;
	Fri,  5 Apr 2024 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwAXZirt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57496172BD6;
	Fri,  5 Apr 2024 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344750; cv=none; b=FTw5O8oahv6G7dkjHqriFOfl8dmU4V/EXGXJoacRxREcfpFHgLETFsWkBk3gO2KG4E4dQLBzro2pyLGhCnT2o7uG2yyJaULjXiBAC4mQsGJBbO/KKpFQnxrhWG7vrXUk3uJ5f8gPphG9PvpbDCN/Zi5iWg0NmdPaZNQfuArDwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344750; c=relaxed/simple;
	bh=YZzETK3dGt+U2zTRZF8z8a/1QYwhigjIioNvAPSyom4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dryDNwOv/3pHZN97fSXGkVQYTxzB2cpQa6PF4gKHkFN1XQB0QMxiTwk8uwV0tD/0NGY50PrMwt4UmsSg8wW12UcJenv9CONd/1vlItergoNtBu21f+0H5QQfJjTWnigefMg/wnbLGPqM9kjrdqOiKvcWQ4viapPmfC7cxRXqDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwAXZirt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77358C433F1;
	Fri,  5 Apr 2024 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712344750;
	bh=YZzETK3dGt+U2zTRZF8z8a/1QYwhigjIioNvAPSyom4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwAXZirtowUqs2wpxl/ix1iXRnZBLFIVr+07JWCgEVAv3TbNHnYTCoV+eVyPgmn8S
	 ZXORJb2PdZLdlwvLI/Mw8oc6F2/pc9KqCc6aogOExTM+WRmTPnXrv0fNjtOVYNAJC5
	 zgEi0VG8WP1AqJM1xtCZRdylDe1nyh4mMkQ7HygJ0dAC3oKej0YRZJQGM51gs8JSIT
	 yS5xHTDFuHnJKBg3TA8+xJUj6NBKzg69LexnYTvZ0LN9XI2Dv1dca11lzgFkFtBQ/B
	 c06QxeB7AtDRBJgoKb2ObPajCgU9rKreXnvvfy5ogX2gvExHLlYUHp9DLwF/nQllDU
	 zQm7gpW0ml+JQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 1/7] mm/damon/paddr: refactor DAMOS_PAGEOUT with migration_mode
Date: Fri,  5 Apr 2024 12:19:07 -0700
Message-Id: <20240405191907.66958-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405060858.2818-2-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 15:08:50 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> This is a preparation patch that introduces migration modes.
> 
> The damon_pa_pageout is renamed to damon_pa_migrate and it receives an
> extra argument for migration_mode.

I personally think keeping damon_pa_pageout() as is and adding a new function
(damon_pa_migrate()) with some duplicated code is also ok, but this approach
also looks fine to me.  So I have no strong opinion here, but just letting you
know I would have no objection at both approaches.

> 
> No functional changes applied.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> ---
>  mm/damon/paddr.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 081e2a325778..277a1c4d833c 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -224,7 +224,12 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
>  	return false;
>  }
>  
> -static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
> +enum migration_mode {
> +	MIG_PAGEOUT,
> +};

To avoid name conflicts, what about renaming to 'damos_migration_mode' and
'DAMOS_MIG_PAGEOUT'?

> +
> +static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> +				      enum migration_mode mm)

My poor brain has a bit confused with the name.  What about calling it 'mode'?

>  {
>  	unsigned long addr, applied;
>  	LIST_HEAD(folio_list);
> @@ -249,7 +254,14 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>  put_folio:
>  		folio_put(folio);
>  	}
> -	applied = reclaim_pages(&folio_list);
> +	switch (mm) {
> +	case MIG_PAGEOUT:
> +		applied = reclaim_pages(&folio_list);
> +		break;
> +	default:
> +		/* Unexpected migration mode. */
> +		return 0;
> +	}
>  	cond_resched();
>  	return applied * PAGE_SIZE;
>  }
> @@ -297,7 +309,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
>  {
>  	switch (scheme->action) {
>  	case DAMOS_PAGEOUT:
> -		return damon_pa_pageout(r, scheme);
> +		return damon_pa_migrate(r, scheme, MIG_PAGEOUT);
>  	case DAMOS_LRU_PRIO:
>  		return damon_pa_mark_accessed(r, scheme);
>  	case DAMOS_LRU_DEPRIO:
> -- 
> 2.34.1


Thanks,
SJ

