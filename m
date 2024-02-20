Return-Path: <linux-kernel+bounces-72199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBED85B0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096D21C214BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201EC3A1CD;
	Tue, 20 Feb 2024 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="grGGi2uC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12B2F48
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394779; cv=none; b=bR8OEaqp6u6KjAQgAVoySrtDCSjRAnkw7UmSDoka9VvfLRTAJ6nWutq3FRrJjSHHP5qLWib47FNejW3jOZjie/F8oTYcQsIJavKLR9PVR4BjTfiZKYwqDQo6KvUy1DNPc0/kezoDkV1lFwww2WLkPAD1ZG5wIZ2HVrVRunqo1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394779; c=relaxed/simple;
	bh=bDdjROKZZj2dBsGE19iE/SvwQShTfjvKJH7+gIGX4Fg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K4sydhctApaMBabw47LMj5npWTa+ddfRFP0k5HjpMrZRu781B6BstEI6rId8dCC7kwRcc+0JPeAm8XAG31GrWgGOdrkyuQOinScGdBGU3/WvpcCvW1+YFSmwkXVUP/nSCiBiAFw1cjys5ZevWEvd4hWX4rhxvUp9MnmWiwrgm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=grGGi2uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D6DC433C7;
	Tue, 20 Feb 2024 02:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708394778;
	bh=bDdjROKZZj2dBsGE19iE/SvwQShTfjvKJH7+gIGX4Fg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=grGGi2uCM0OHsKj6ADvKVJr7u0wZZKSCOXP9AYaD4A90xkdSJXmnlS0NiBL9JCJW3
	 skfJvC59rdcRXPvuK6O2h90DQJS+UWOpNx0JLCvFR82ifKxxAOlcsdRSAve6wCUWL9
	 8LC3qXZdO8xYNWHYj8WyKgh0T3Dn+ZmoC9nyH3Yk=
Date: Mon, 19 Feb 2024 18:06:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Zi Yan <zi.yan@sent.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, Ryan
 Roberts <ryan.roberts@arm.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rohan Puri
 <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>, Adam
 Manzanares <a.manzanares@samsung.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>
Subject: Re: [PATCH v6 0/4] Enable >0 order folio memory compaction
Message-Id: <20240219180617.89a0daaba45ce124ef01be50@linux-foundation.org>
In-Reply-To: <20240216170432.1268753-1-zi.yan@sent.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 12:04:28 -0500 Zi Yan <zi.yan@sent.com> wrote:

> Baolin's patch

Baolin writes many patches and patches have names, please use them!

> on nr_migratepages was based on this one, a better fixup
> for it might be below. Since before my patchset, compaction only deals with
> order-0 pages.

I don't understand what this means.  The patchset you sent applies OK
to mm-unstable so what else is there to do?

> diff --git a/mm/compaction.c b/mm/compaction.c
> index 01ec85cfd623f..e60135e2019d6 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1798,7 +1798,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  	dst = list_entry(cc->freepages.next, struct folio, lru);
>  	list_del(&dst->lru);
>  	cc->nr_freepages--;
> -	cc->nr_migratepages -= 1 << order;
> +	cc->nr_migratepages--;
>  
>  	return dst;
>  }
> @@ -1814,7 +1814,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
>  
>  	list_add(&dst->lru, &cc->freepages);
>  	cc->nr_freepages++;
> -	cc->nr_migratepages += 1 << order;
> +	cc->nr_migratepages++;
>  }


