Return-Path: <linux-kernel+bounces-54040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6384A994
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235331F2C5A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FEF26AC1;
	Mon,  5 Feb 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT8wzIvp"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D21EF1D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173760; cv=none; b=OTeFhNy3ul7CmRaU6Wp/8ZkMrdfplhHXQuFbuuupr5CzmhzAe72P73vSynn3EsLn9wo46Mgz85bAHrbKglWplp8YdVIJ8VsDP8SJ/aItbseo5ITaEui8mXfhJ8Jfh9iIDb+cpUuWlIRUV2VD4tI/CopITYRDRrkamWszgz3Ckuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173760; c=relaxed/simple;
	bh=F4WJ1Vw8q6RyYPuipcp1/BKDhcKpOZEqbpTvCZV0eiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LeBO+ENhEnjdPNPhwkf3F8mazy3+QbftL0gXyE7a3mEe1fYJxrnhRWYtwzJ5wzWkAFjxBhaunwOaxc1CrLTl8iExfXdcdo8hohpCxRgMDQk2gpr0OIi4x2ad7ciGEUuIGQKsb44RV+EIasPaYCyGpFcPka6TbxhcOXbvXjG3vDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nT8wzIvp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6043c795ee9so28067347b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707173757; x=1707778557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ng2e0Mk0os0T2CuSo4hFQWlpZrULav2tPmScvzzfgA=;
        b=nT8wzIvpVii4Osz10mDY2gVTMZeXBPL9VJnzKBHc/vwtob9oXjtOsCHdvQFpBjX2iJ
         mRo+TdgexrQny+TpcNV96VZ7TQp6HZp2ugKpU3uW++D2AWGM3iidHSIuVr2a4zL+pZdf
         KB1MTPStWK2QWWuFJnMsu1pRjxqpR4wPAtG3bAK5cc7emT6g/6f5sIvBleM5O0nlkP0c
         zLb07dmN2WVbzLRKxkouHOlg2uiKlCc0lrZ1p7LCGTKQpq4xjyDVIKWzAAhH2tCiS9aI
         3DhfG65zESyTYDE0+gsUET1kRi4MgoduW0HIS924uMcniigmXVwviOBP0dhIE7t5JYkN
         wdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173757; x=1707778557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ng2e0Mk0os0T2CuSo4hFQWlpZrULav2tPmScvzzfgA=;
        b=k7NdIun3i7qVkFJgyRjPZ0JBkHrTeztJK0SorZRhnvADdsu83Szl1Ip7Zq0aIKhfNE
         G6WDK04yqsiNt1nhtF6OjEJ1NtpKmytvmkkmDRWoG3SCJZ+1XfhZI1YqACbk2gyj3PYH
         19Xv9XodiWKFatGWEAC/o6+bYve2qaiPPqoI3WoMKrozaqbm5HD9F+NSbALjw5pixrN7
         3y7eW6z2eDF5B/HljD+28B4cjzy89G8qPo7sC3OcAomJ7XWn1m6kf/27mfqIusrng2HK
         9oqze0wv+ch+qs1ylBEdDNaEnTqaBeYhhulgw8BI10bUZ1G//noRzN6Y/JV7YHccaqjR
         QqxQ==
X-Gm-Message-State: AOJu0YxEOBm/KyGXTSZLZxnoqxLXqaJJzNw820FndWi/UeQ5JEMbWwIC
	RYAW8BqrzKzM2AEn8tu6kCE2ATgG3D5eqwQTSF1ygvLQpCvXl46YpmKSXVL5e4yUvv1Avt6dDnx
	ehUFn5jIH41Cj+xUeKg==
X-Google-Smtp-Source: AGHT+IH9gyc29/buiu53gaGpMwLh7J/ItpL9EQ5ysoaPUZAnd1ueM5sG0fNmWuyiFaAwabgq4g9O/sCU77WwpXBB
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:398:b0:5ff:5135:ffcf with SMTP
 id bh24-20020a05690c039800b005ff5135ffcfmr186830ywb.4.1707173757594; Mon, 05
 Feb 2024 14:55:57 -0800 (PST)
Date: Mon, 5 Feb 2024 22:55:55 +0000
In-Reply-To: <20240204083411.3762683-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240204083411.3762683-1-chengming.zhou@linux.dev>
Message-ID: <ZcFne336KJdbrvvS@google.com>
Subject: Re: [PATCH] mm/zswap: invalidate old entry when store fail or !zswap_enabled
From: Yosry Ahmed <yosryahmed@google.com>
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 04, 2024 at 08:34:11AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We may encounter duplicate entry in the zswap_store():
> 
> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
>    the zswap entry, then got reused. This has been fixed.
> 
> 2. !exclusive load mode, swapin folio will leave its zswap entry
>    on the tree, then swapout again. This has been removed.
> 
> 3. one folio can be dirtied again after zswap_store(), so need to
>    zswap_store() again. This should be handled correctly.
> 
> So we must invalidate the old duplicate entry before insert the
> new one, which actually doesn't have to be done at the beginning
> of zswap_store(). And this is a normal situation, we shouldn't
> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
> to detect swap entry UAF problem? But not very necessary here.)
> 
> The good point is that we don't need to lock tree twice in the
> store success path.
> 
> Note we still need to invalidate the old duplicate entry in the
> store failure path, otherwise the new data in swapfile could be
> overwrite by the old data in zswap pool when lru writeback.

I think this may have been introduced by 42c06a0e8ebe ("mm: kill
frontswap"). Frontswap used to check if the page was present in
frontswap and invalidate it before calling into zswap, so it would
invalidate a previously stored page when it is dirtied and swapped out
again, even if zswap is disabled.

Johannes, does this sound correct to you? If yes, I think we need a
proper Fixes tag and a stable backport as this may cause data
corruption.

> 
> We have to do this even when !zswap_enabled since zswap can be
> disabled anytime. If the folio store success before, then got
> dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store(). So later lru writeback
> may overwrite the new data in swapfile.
> 
> This fix is not good, since we have to grab lock to check everytime
> even when zswap is disabled, but it's simple.

Frontswap had a bitmap that we can query locklessly to find out if there
is an outdated stored page. I think we can overcome this with the
xarray, we can do a lockless lookup first, and only take the lock if
there is an outdated entry to remove.

Meanwhile I am not sure if acquiring the lock on every swapout even with
zswap disabled is acceptable, but I think it's the simplest fix for now,
unless we revive the bitmap.

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cd67f7f6b302..0b7599f4116d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1518,18 +1518,8 @@ bool zswap_store(struct folio *folio)
>  		return false;
>  
>  	if (!zswap_enabled)
> -		return false;
> +		goto check_old;
>  
> -	/*
> -	 * If this is a duplicate, it must be removed before attempting to store
> -	 * it, otherwise, if the store fails the old page won't be removed from
> -	 * the tree, and it might be written back overriding the new data.
> -	 */
> -	spin_lock(&tree->lock);
> -	entry = zswap_rb_search(&tree->rbroot, offset);
> -	if (entry)
> -		zswap_invalidate_entry(tree, entry);
> -	spin_unlock(&tree->lock);
>  	objcg = get_obj_cgroup_from_folio(folio);
>  	if (objcg && !obj_cgroup_may_zswap(objcg)) {
>  		memcg = get_mem_cgroup_from_objcg(objcg);
> @@ -1608,15 +1598,11 @@ bool zswap_store(struct folio *folio)
>  	/* map */
>  	spin_lock(&tree->lock);
>  	/*
> -	 * A duplicate entry should have been removed at the beginning of this
> -	 * function. Since the swap entry should be pinned, if a duplicate is
> -	 * found again here it means that something went wrong in the swap
> -	 * cache.
> +	 * The folio could be dirtied again, invalidate the possible old entry
> +	 * before insert this new entry.
>  	 */
> -	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> -		WARN_ON(1);
> +	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST)
>  		zswap_invalidate_entry(tree, dupentry);
> -	}

I always thought the loop here was confusing. We are holding the lock,
so it should be guaranteed that if we get -EEXIST once and invalidate
it, we won't find it the next time around.

This should really be a cmpxchg operation, which is simple with the
xarray. We can probably do the same with the rbtree, but perhaps it's
not worth it if the xarray change is coming soon.

For now, I think an if condition is clearer:

if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
	zswap_invalidate_entry(tree, dupentry);
	/* Must succeed, we just removed the dup under the lock */
	WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
}

>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&entry->pool->list_lru, entry);
> @@ -1638,6 +1624,17 @@ bool zswap_store(struct folio *folio)
>  reject:
>  	if (objcg)
>  		obj_cgroup_put(objcg);
> +check_old:
> +	/*
> +	 * If zswap store fail or zswap disabled, we must invalidate possible
> +	 * old entry which previously stored by this folio. Otherwise, later
> +	 * writeback could overwrite the new data in swapfile.
> +	 */
> +	spin_lock(&tree->lock);
> +	entry = zswap_rb_search(&tree->rbroot, offset);
> +	if (entry)
> +		zswap_invalidate_entry(tree, entry);
> +	spin_unlock(&tree->lock);
>  	return false;
>  
>  shrink:
> -- 
> 2.40.1
> 

