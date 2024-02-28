Return-Path: <linux-kernel+bounces-84508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E16886A7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2320D286550
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3020B03;
	Wed, 28 Feb 2024 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KK0pgXK3"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF61D689
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094845; cv=none; b=M1yJPn7KCshcnSJH0AGo1TiXh0Q3YM4zDcA3MlCjcvjIT11nKlbSAqiSfvggWILNDi+LIHK45Sckgbkb0jLUq5ggq1ckjdaLx++Nbhs/+p5yQ7uY2ntd6bdQpaNf16sR1pMSYipyBuKoSktuBQJsIUTb9Vov5zYifQQBmCof2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094845; c=relaxed/simple;
	bh=Q6pbyOxbPJ0t46h4TSoHNSNo/QAJmJsfatkGJitPS7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFnUJadUieGASB2oCIXEyzEGOpb9q2UhPCulA4ZKlfRm88sD/UAQPxKhy5ob0go4DUlwr61OZcwzXPFvu0DQs00ngSRKBh6jPaAQWL4IT8T3iFjvSPuHjNm1sbdbwwv0NS3iu3rYRO/32a5v07tOC14STnJHamXjFhtebTB9S+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KK0pgXK3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a940614easo2710440a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709094843; x=1709699643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8g7nV4bObI1u+NR0MdOCXyTkPOObxNO/D7LB7657tSo=;
        b=KK0pgXK3IW1uakQ9naaHLAj0bvKR+5JQYFnOIM4IOFMDpUvyaZuki6f/AJWQbgx5T7
         Fd18cgBmNH0lbzt/dELh4XpUh8tbRsnk53clz+lcnoaXsoM5pZegiosp3VZ5cROSclMp
         ogsPxzzFZ/MODS7WJekMvHfTgA5XFlcEg03uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709094843; x=1709699643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g7nV4bObI1u+NR0MdOCXyTkPOObxNO/D7LB7657tSo=;
        b=KTMuR5gS5Ccn9j/0FlKUShIwqkOzGYfkDcVQZ8GMutwjOW1E3xkU+4Q/++2DAhGuiR
         TNQDAQZWn8nSiJwFLdnUYiQn9KIy0uRwNAFGDp2h635nIHMXioGMxGQOszqcppEGDBKS
         6ra4R/5DzZrlKRuhOsI4Hnxo2Jq7InHEajMiQa4M5MiRc1ViwkRUmUW36Tuk6Ktvnogc
         x7U+hxFj6pTqOcVaoT3x2AMvvUdq9xd0PBsi41l1VkpHjYP62jNny8KGoosKKPOdPHL3
         msmCLUXJukwzLWLEfej4StTGGvHDuipvCFrKHdul9156frJ9Xpheu3ojXflDInyEoSjw
         eCgg==
X-Forwarded-Encrypted: i=1; AJvYcCUmta4VQnPz9nS9vQaKHDt2q8Cn076M7kYDiYeCCIDAsVCOgsSmGNcmiQMeDpDvZwZKK2Q3ThV0Dhivh4Pu1LzgAdtG6bqWUTlRkqrz
X-Gm-Message-State: AOJu0YxbxERo3wKZPJkWbJpVFrTjRd/hVcDN+dQh5ZRRsgZtfp1asFNk
	JImDRg/XF6go49ERmlfKGwLXCFwHqc9FaBDg+r+C1Mn23h3x2tMQRpoTOVFtjNnCqLOIb0Of9gD
	H6Q==
X-Google-Smtp-Source: AGHT+IH8xhC1KwkLdQDQu4LfLXKYj+xTx3KtqrAondDNU4DzvJcfALCq86tdS8GT32oCif3SNJtZYw==
X-Received: by 2002:a17:90a:7408:b0:29a:575c:7d90 with SMTP id a8-20020a17090a740800b0029a575c7d90mr9949643pjg.9.1709094842793;
        Tue, 27 Feb 2024 20:34:02 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c1:1ad2:3268:cacd])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090abf0700b0029acce2420asm424101pjs.10.2024.02.27.20.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 20:34:02 -0800 (PST)
Date: Wed, 28 Feb 2024 13:33:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
	hannes@cmpxchg.org, nphamcs@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when
 free_zspage()
Message-ID: <20240228043358.GF11972@google.com>
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
[..]
> @@ -978,10 +974,11 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>  		pages[i] = page;
>  	}
>  
> -	create_page_chain(class, zspage, pages);
>  	init_zspage(class, zspage);
>  	zspage->pool = pool;
>  	zspage->class = class->index;
> +	/* RCU set_zspage() after zspage initialized. */
> +	create_page_chain(class, zspage, pages);

So this hasn't been tested, has it?

init_zspage() does not like to be invoked before create_page_chain(),
because we haven't setup required pointers yet.

So when init_zspage() calls get_first_page() it gets NULL zspage->first_page
which we then use in is_first_page(first_page)->PagePrivate(page). As far as
I can tell.

