Return-Path: <linux-kernel+bounces-120212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523288D481
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4942E5F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F98208CA;
	Wed, 27 Mar 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B6ELc9Rf"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8D1D558
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506342; cv=none; b=h3VZF8nUva5VaBz3YDuHgLgmnOGYAjUOf9wyN5qwAZwn8DpBRt6liYOebNLI4obNTvbEByvL7nC5QwAelAwqrqczQOWzDdNg/OwMyAw1/NMqYBbGJDG/mQ47hioi89oWM9GNP2uyJIZOXdB3lQwbMYCCAOAtnr+gZZ+Lv3UPtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506342; c=relaxed/simple;
	bh=W1pMnaJdpxIwGtfutYxyuW2Wco1yDNydnZPYws4jAvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqPNpQag9fE5wq0wc9pYXaxBxlFxMA/rF6Jk0NPXFiY2mxXVKLqKOBG13IDV1K6A/SXK/Ieiqd9bc864Obq6pR3+dd1nS+zSB3caqzZybkvCH3AZYZy4dx7x579y5O93H/79OgUm+hKFg9Q5oC8nuhTYnuaSVECRt3VSI7NvsI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B6ELc9Rf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5e394253-4f01-4172-998e-bbf3d82de6b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711506338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toVz9Slq6rIwBWxbkYIDUn9vUvSsS1ey1uAF2j5dJmk=;
	b=B6ELc9RfvCchRRhzKH81eaisSD9A1eUgkJm7YGdpCuPmUBD6IpKVJNJ6ZXM9pmT5dQVWrJ
	n+kSomt7yclc3Gm7S9HOnf3KMyF0YfgitxJ6nsi9PK2gpc0fqdh+x/WC6Th9/a2mk3wpHy
	mxsKUvSIfuje7Qw7XBj9lOapPgNbzXk=
Date: Wed, 27 Mar 2024 10:25:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/9] mm: zswap: refactor storing to the tree out of
 zswap_store()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-3-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240325235018.2028408-3-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/26 07:50, Yosry Ahmed wrote:
> Refactor the code that attempts storing to the xarray, handling erros,
> and freeing stale entries into a helper. This will be reused in a
> following patch to free other types of tree elements as well.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 1cf3ab4b22e64..ff1975afb7e3d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -827,6 +827,30 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  	atomic_dec(&zswap_stored_pages);
>  }
>  
> +/*********************************
> +* zswap tree functions
> +**********************************/
> +static int zswap_tree_store(struct xarray *tree, pgoff_t offset, void *new)
> +{
> +	void *old;
> +	int err;
> +
> +	old = xa_store(tree, offset, new, GFP_KERNEL);
> +	err = xa_is_err(old);

Seems to use xa_err() to return errno, xa_is_err() just return a bool.

> +	if (err) {
> +		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
> +		zswap_reject_alloc_fail++;
> +	} else if (old) {
> +		/*
> +		 * We may have had an existing entry that became stale when
> +		 * the folio was redirtied and now the new version is being
> +		 * swapped out. Get rid of the old.
> +		 */
> +		zswap_entry_free(old);
> +	}
> +	return err;
> +}
> +
>  /*********************************
>  * compressed storage functions
>  **********************************/
> @@ -1396,10 +1420,10 @@ bool zswap_store(struct folio *folio)
>  	swp_entry_t swp = folio->swap;
>  	pgoff_t offset = swp_offset(swp);
>  	struct xarray *tree = swap_zswap_tree(swp);
> -	struct zswap_entry *entry, *old;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
>  	unsigned long max_pages, cur_pages;
> +	struct zswap_entry *entry;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1485,22 +1509,8 @@ bool zswap_store(struct folio *folio)
>  	entry->swpentry = swp;
>  	entry->objcg = objcg;
>  
> -	old = xa_store(tree, offset, entry, GFP_KERNEL);
> -	if (xa_is_err(old)) {
> -		int err = xa_err(old);
> -
> -		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
> -		zswap_reject_alloc_fail++;
> +	if (zswap_tree_store(tree, offset, entry))
>  		goto store_failed;
> -	}
> -
> -	/*
> -	 * We may have had an existing entry that became stale when
> -	 * the folio was redirtied and now the new version is being
> -	 * swapped out. Get rid of the old.
> -	 */
> -	if (old)
> -		zswap_entry_free(old);
>  
>  	if (objcg) {
>  		obj_cgroup_charge_zswap(objcg, entry->length);

