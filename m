Return-Path: <linux-kernel+bounces-102269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75587B006
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C352897D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2612838D;
	Wed, 13 Mar 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0UXDivk"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BBD6024B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351152; cv=none; b=W3jDETpbVYI+LMusGwkwUSEAP+I1aZp8i7pHicWQXRapzLQy/m0W+TF77WnCq7RRSOZcSgSWxqPansfetfl+s2Ux8//uGdJHfdW5Ht6CoBUAehrSgr5piiHZ9CdPg1/wDYiENcV7J4wVflKxojr6RYhQ0sYXY1CpWS8iR1SpcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351152; c=relaxed/simple;
	bh=aEoMTt6kqzlpV7U/TLlePcO1++ARFfOMAlOBoucXPak=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FWc+MYD+sutf307q7Gj3Ia7M/H2q8BbPC2s9gdi2OQkt19Coejbarwncu70XI3X5plBljNaLDQ6+z2EOj2ewoJ79s9ACD0Xjf0DpsFz3n8XhgyX58OGYGRYWCEdupH+G3kvbnlLqVi76rL0Lo1UEEuT0bwvbgNvvBge2NZ+D0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0UXDivk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60cbcd04de9so1091017b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710351149; x=1710955949; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZx8O1CCSSHjeqqPpD1J8JZt7vp8Coah+qOaLoeYkrs=;
        b=d0UXDivkghjVnZwHcIwK5/wHeuShmbuI0egdpww5yHo3B/IoEhchUIp6JFSlLhy7p6
         h4VOb8SWUWokcHM/s0qMxxXH9E6T0ign/dxN9rmAP3ki25oicmw5lyg0FRipSwZlwHRk
         y7YmpurbUaE4NUJtLHR9E95wjy6jFMiCrxRTZ5tcA0OU3fshhG6NRJG4BiH0WXEl3FUZ
         m536iqyh9lt7eVFLQsOCvcyxgSsvbDAXs7cezV/L7hj7yAgsBf7dqnL9PMdjRQqb2uhH
         4dpnlCS1SkG9hci43FJoI0pqrfqjruh88LK9dEg30S9jnZFithkA25NMYoM1ZskvipE8
         3lFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351149; x=1710955949;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZx8O1CCSSHjeqqPpD1J8JZt7vp8Coah+qOaLoeYkrs=;
        b=HOfcXTyxXNu0/bs48B5h8tcubsz8fkPmydAxcfFXw7as2rbPGooA1O0syTcpacTXh1
         +zEu8Es5Wl3zZKkI4jBxiiufafmjFUYfr9RG7zPY/XF2xpKqUpf3tb3SuQWYCOnvo9bs
         VXtAKQrKoTOt7/W6G09Ufd/j7UFVYf4N5nIDitui3UEdn/SSfe5OsUXUKi2b41vUcsG6
         bOxm53zZgIo5SD4fc7QpzQVRS/7XYhQ8FDkUuZzIlA04SpCUYrkvTW3LqmiN4c2RF8Vv
         OCjDEVlODB389Dwb+hU9KvbBzftwBS5KFBC6qB2DLThmPOKGnWXNuDhsiLF8Y+mavIUg
         PX6Q==
X-Gm-Message-State: AOJu0Yy1M1lq5RgMfYxdrmm6e7U9xNwTy8Pd5kSAdOzlBO+d4QaHgKzN
	DnEAqxvmqqeeZOOgfrTUO/TKGBvGBCjp0PW9H1j0F/fij54HT7uJ56odsWfsRQ==
X-Google-Smtp-Source: AGHT+IF1zRN0ur0QcmaHhYa0aQgICBJh1KBdfKxcL9cY9FBJHZt/60IFvmdALVqDl/QspawRhw0lTg==
X-Received: by 2002:a0d:c9c2:0:b0:609:fb70:2a96 with SMTP id l185-20020a0dc9c2000000b00609fb702a96mr3420592ywd.20.1710351149181;
        Wed, 13 Mar 2024 10:32:29 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id hf12-20020a05690c600c00b00607f86fa184sm2483004ywb.99.2024.03.13.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:32:28 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:32:26 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sasha Levin <sashal@kernel.org>
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, Zi Yan <ziy@nvidia.com>, 
    David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, 
    Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
    Mike Kravetz <mike.kravetz@oracle.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6 07/60] mm: migrate: convert numamigrate_isolate_page()
 to numamigrate_isolate_folio()
In-Reply-To: <20240313163707.615000-8-sashal@kernel.org>
Message-ID: <7571ccc0-2192-6b90-83c8-7e4bcefe5de5@google.com>
References: <20240313163707.615000-1-sashal@kernel.org> <20240313163707.615000-8-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Mar 2024, Sasha Levin wrote:

> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> [ Upstream commit 2ac9e99f3b21b2864305fbfba4bae5913274c409 ]
> 
> Rename numamigrate_isolate_page() to numamigrate_isolate_folio(), then
> make it takes a folio and use folio API to save compound_head() calls.
> 
> Link: https://lkml.kernel.org/r/20230913095131.2426871-4-wangkefeng.wang@huawei.com
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")

No it is not: that one is appropriate to include, this one is not.

Hugh

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/migrate.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c9fabb960996f..e5f2f7243a659 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2501,10 +2501,9 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>  	return __folio_alloc_node(gfp, order, nid);
>  }
>  
> -static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
> +static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>  {
> -	int nr_pages = thp_nr_pages(page);
> -	int order = compound_order(page);
> +	int nr_pages = folio_nr_pages(folio);
>  
>  	/* Avoid migrating to a node that is nearly full */
>  	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> @@ -2516,22 +2515,23 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  			if (managed_zone(pgdat->node_zones + z))
>  				break;
>  		}
> -		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
> +		wakeup_kswapd(pgdat->node_zones + z, 0,
> +			      folio_order(folio), ZONE_MOVABLE);
>  		return 0;
>  	}
>  
> -	if (!isolate_lru_page(page))
> +	if (!folio_isolate_lru(folio))
>  		return 0;
>  
> -	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
> +	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
>  			    nr_pages);
>  
>  	/*
> -	 * Isolating the page has taken another reference, so the
> -	 * caller's reference can be safely dropped without the page
> +	 * Isolating the folio has taken another reference, so the
> +	 * caller's reference can be safely dropped without the folio
>  	 * disappearing underneath us during migration.
>  	 */
> -	put_page(page);
> +	folio_put(folio);
>  	return 1;
>  }
>  
> @@ -2565,7 +2565,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  	if (page_is_file_lru(page) && PageDirty(page))
>  		goto out;
>  
> -	isolated = numamigrate_isolate_page(pgdat, page);
> +	isolated = numamigrate_isolate_folio(pgdat, page_folio(page));
>  	if (!isolated)
>  		goto out;
>  
> -- 
> 2.43.0
> 
> 

