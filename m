Return-Path: <linux-kernel+bounces-84549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B827C86A82B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF0F1C23E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F8219F0;
	Wed, 28 Feb 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MGoiSrOo"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64221353
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100080; cv=none; b=TVDBc+TmhdA4veqO75yXQiOtGOMWq9CZhLCyZulqUuZfJBIcwhfTfuO0eeh7rSPoRsYxyhVqlYekitTmU/+741Y8ZSxYizpMKdD48kwQ3Bpp4EftnTzYWHwBzmTiax786aUGq+zGMS9n9fRpbdHnSmuUGHnuPRw7rk3luBj/4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100080; c=relaxed/simple;
	bh=BZ7dhgtLm4mdChn/lEzX5NyylaP5toxodQZ5WqYmKqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd5RAZfjrlDZWovq/pUeQdWZ1QOITvxUvnxpcEP670aD81VKXoDQ5+LAzKmMdTLJn+aG29zSqDndnnr+5Z3JRz/ZRWzh64rVs+QIJdHCXl3CayhOXHaTeyxp58tJECjP/p8zGoM12xSxW4ciAiOC8tYwGFFiiv6Gp7vNlK15Z2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MGoiSrOo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29ab7073dd2so2250511a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709100078; x=1709704878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v64P2JtDs/Jve0LUtIoH4sj0OPsa7P81HCpBbPHS4wo=;
        b=MGoiSrOovSgo+fsNIrSwkZOiQMpHP0Xh+VL55cMf1JMok7+NknbEZ6v+dG+mh3QiOa
         9wJWaEjHlV/jsuz2qon36b/B2aW/pkzrSX9tHdvQopgxvPLhi8GKa/FXMkQIzK9ywPG8
         C01ymp89xBH5pRLXrWYE6BPkJSRH6VMl0tgK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709100078; x=1709704878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v64P2JtDs/Jve0LUtIoH4sj0OPsa7P81HCpBbPHS4wo=;
        b=g9VPnrmD0X7hbdCmL+h09vwibPOsceLN7rI4ps5f/qcjR7UhAUjwVhgN3F4wIYAClA
         Vei0gE3kZtKuPc4oglHQg9W3qEFP0K5x8zwtKrZIgssmniVO+PNKzQhay2Tz+yK5CJks
         gq5ZDxl1lQsdfNoOS48DtIDKqHerWdcziQj7Mb/BWJXY0TSZrAoTfRg+SFVKvPCd6zi9
         S2XZJpc9LbCYgmg3Yctw7ffKXVUu35k1bgk9RJFw9OzpgbIL34L03nXQr358QCmtcoWe
         PPvg6JJE2lYTwN9g27n1bkm/ZhsJvfmFQKh7bFF9nzCVFzPl5YXjFNA+g2ksRSy7jUxC
         N/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZkZ8ymDlPu8rmeMP03S3Tr8Het4DYEzjNi02zsxBqWPHfnmHMUqxQWIVDIbaVPy5j/hSz79USGFwAoLG3AJqK5KV4oyFRgLWInfra
X-Gm-Message-State: AOJu0YyccNHFENum9mpLVG+RaB/Jmjr0QLY7F1PhqDCGU6EvhoFfYi8p
	3ts9n6+Q4Zo5u2/kaPkTw1FQRq76tCP+nUkjpNkYDhwOz/bB73OZl0CAk2h9PA==
X-Google-Smtp-Source: AGHT+IHZu+4hRcVL2xaCoROJmdUcdSraSK3bknD2RM8H9rh9+RY1d9KWjZBRbllfjDrb13udiEHVVg==
X-Received: by 2002:a17:90a:b014:b0:299:5d2c:9aa1 with SMTP id x20-20020a17090ab01400b002995d2c9aa1mr9140316pjq.5.1709100078288;
        Tue, 27 Feb 2024 22:01:18 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c1:1ad2:3268:cacd])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a0f0800b0029a3da37123sm685792pjy.23.2024.02.27.22.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:01:17 -0800 (PST)
Date: Wed, 28 Feb 2024 15:01:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
	hannes@cmpxchg.org, nphamcs@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when
 free_zspage()
Message-ID: <20240228060113.GJ11972@google.com>
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>

On (24/02/27 03:02), Chengming Zhou wrote:
>  static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>  				struct zspage *zspage)
>  {
> @@ -834,13 +841,12 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>  		VM_BUG_ON_PAGE(!PageLocked(page), page);

Who owns page lock here if free_zspage() doesn't trylock_zspage() no longer?

>  		next = get_next_page(page);
>  		reset_page(page);
> -		unlock_page(page);
>  		dec_zone_page_state(page, NR_ZSPAGES);
>  		put_page(page);
>  		page = next;
>  	} while (page != NULL);
>  
> -	cache_free_zspage(pool, zspage);
> +	call_rcu(&zspage->rcu_head, rcu_free_zspage);
>  
>  	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
>  	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
> @@ -852,16 +858,6 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
>  	VM_BUG_ON(get_zspage_inuse(zspage));
>  	VM_BUG_ON(list_empty(&zspage->list));
>  
> -	/*
> -	 * Since zs_free couldn't be sleepable, this function cannot call
> -	 * lock_page. The page locks trylock_zspage got will be released
> -	 * by __free_zspage.
> -	 */
> -	if (!trylock_zspage(zspage)) {
> -		kick_deferred_free(pool);
> -		return;
> -	}
> -
>  	remove_zspage(class, zspage);
>  	__free_zspage(pool, class, zspage);
>  }

