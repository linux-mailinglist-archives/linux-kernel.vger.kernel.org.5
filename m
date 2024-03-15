Return-Path: <linux-kernel+bounces-104947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153087D651
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5D1F224E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99A54918;
	Fri, 15 Mar 2024 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjcCyFg2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8154908
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538747; cv=none; b=X2hmJ0m0ybhm6jvxrPQLfnOrA4QXzpbPpSMhx1ERS/Uz+ZDrDXM/5gU7UcsYH3ymEJGBeunsYVDFeiD7lQW/YxpqU0m/+uWmUMJe7DcJDhfrNVPcXjDOMQXc0XubDkNK7cmQN0EUn6WbabK4RoaqSWSpcSB1S4Wcem/XeTjnaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538747; c=relaxed/simple;
	bh=RmGZydm8dUms/pt/l8u+2Hq02hkxE9ZbOrRu3WhgwMU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZwZH14SkeC9dvVRwZZmirWu4rsJYZ6YF96ZhLtiTalX7rXdxjRD98u9VecQ97n7vLs05dAI3Z3c6oSYdRns14EmKz/T2AtI3dADbt7GbTHBl/IbLlwB74XPs+SByFAGNC8WXfCohtsaAHhDz4eue6QiaMWCNNglPpoVmHqKv1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjcCyFg2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dddd7d64cdso15675ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710538744; x=1711143544; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4UFAX4z3jJDBCRUy6WDZJz3SsJI5lq7JeGg/ZMI7/c=;
        b=jjcCyFg2v4nCmxyKMaX6thYg7uu94bxZEc3p1iB/Anzjry+XlZiHMIA+P/bgjWEi0/
         LLdwd2kvdrlpfAx6peJzCPHDqmQoo2VN5aqMliQ3iY6UGwWzMbf5YemgfhfNjpfOmPCC
         l3dGNUy7eSl4JSiz6QP1/vh1bQ5QPJfuQdg0pu+L7toQaRaya70oqBs7khhxRIhOOnVy
         Z9hiRZx9WsomHjxCgiuP5/8gCLVwaxO4jXDKq02OGbJ3AED8gk0XIDn+nmw1vglUmC5H
         oE4XOI3UV1sZM5Ldodh/jl2zupgFC9O31hevAs+PAzyQVHCZJmfXRtiQ1BbvgidiauFj
         vHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538744; x=1711143544;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4UFAX4z3jJDBCRUy6WDZJz3SsJI5lq7JeGg/ZMI7/c=;
        b=RCNy9/zQPSnevbOmRQvVMO6/1xcj78CdJtXX8YjoZQgDzaqcKhPN5KNJEPwvEsn1z8
         FCX4lmDZMeyvHDsAXPLNINzOeyYHkeaMXEY68V/PfehqjtZ59jknCcU6OfVkAXYOModa
         AHdsMAU/sdTxIpCohMMKFwsWV3CPrEo72CdGY2mWVReN75c7sk6v7iYKHMrAtr3AGCcu
         EQW1JYyIOkRVm+ycYGa66n1m/v/SvEfsfoOrHcR+UiEYj5vPFoVGPhvC4rU+FkhqjzAh
         lpv5P7jqP7Q1qr80VL+0obSTKzOdNZrF4+OczuoqVcvvZYJ8CJGMEW9JbN7+qgPLXTY6
         HyLA==
X-Gm-Message-State: AOJu0YxZqsUXY1UzV7R7TcpaYWI9gofK854v7N70cIae5zr+jl/Kty83
	xABE935u2ZsljT9pm0I6QqLGlQblHMVnKxzicov8UNYGW2X2Ao/ePbGYXB3vZw==
X-Google-Smtp-Source: AGHT+IGrpgeOjBZ11SYwdIToTwLjbJrlMck5pazxQUYxF316Kq0lbZLpReWX2S3jtECZZiLl6C0ZwQ==
X-Received: by 2002:a17:903:1c3:b0:1dd:b2f1:6e9 with SMTP id e3-20020a17090301c300b001ddb2f106e9mr314272plh.1.1710538744032;
        Fri, 15 Mar 2024 14:39:04 -0700 (PDT)
Received: from [2620:0:1008:15:59e5:b9a4:a826:c419] ([2620:0:1008:15:59e5:b9a4:a826:c419])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b001dd90001b26sm4345543plg.159.2024.03.15.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 14:39:03 -0700 (PDT)
Date: Fri, 15 Mar 2024 14:39:02 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Jiri Pirko <jiri@resnulli.us>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com, 
    penberg@kernel.org, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, 
    peterz@infradead.org, mingo@kernel.org, danielj@nvidia.com
Subject: Re: [patch RFC] mm/slab: introduce KZALLOC_FREE() cleanup-ed allocation
 macro
In-Reply-To: <20240315132249.2515468-1-jiri@resnulli.us>
Message-ID: <171412ef-1a93-3e56-2b7b-3baf83233eb2@google.com>
References: <20240315132249.2515468-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Mar 2024, Jiri Pirko wrote:

> From: Jiri Pirko <jiri@nvidia.com>
> 
> With introduction of __free() macro using cleanup infrastructure, it
> will very likely become quite common to see following pattern:
> 	type *var __free(kfree) = kzalloc(sizeof(*var), GFP_KERNEL);
> 
> To follow the CLASS() flow from cleanup.h, introduce a simple macro
> KZALLOC_FREE() to wrap this over and allow the same flow.
> 
> Show an example usage in gpio-sim driver.
> 

Seems highly specialized especially for kzalloc specifically, so not sure 
this warrants its own macro.

> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/gpio/gpio-sim.c | 3 +--
>  include/linux/slab.h    | 3 +++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index c4106e37e6db..997237b3d80c 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -1496,8 +1496,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
>  {
>  	int id;
>  
> -	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
> -							    GFP_KERNEL);
> +	KZALLOC_FREE(struct gpio_sim_device *, dev, GFP_KERNEL);
>  	if (!dev)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index b5f5ee8308d0..baee6acd58d3 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -711,6 +711,9 @@ static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
>  	return kmalloc(size, flags | __GFP_ZERO);
>  }
>  
> +#define KZALLOC_FREE(_type, var, _gfp_t)				\
> +	_type var __free(kfree) = kzalloc(sizeof(*var), _gfp_t)
> +
>  /**
>   * kzalloc_node - allocate zeroed memory from a particular memory node.
>   * @size: how many bytes of memory are required.
> -- 
> 2.44.0
> 
> 

