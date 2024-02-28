Return-Path: <linux-kernel+bounces-84536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF286A800
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6012B2209B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0A210FD;
	Wed, 28 Feb 2024 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QUlPnuYr"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24F4A1A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709098153; cv=none; b=P5U1MZVGMTFcYJn3arQUw1mkSkM9XD0dWUacws4j2Wuv2nDK5nUpmmljB0Sfj3gs7R4YhwEckV65YJHmqfEHUDfQ1vTTYnycJIQil22YxQYjfjzd+IuC9f35AI4+zDSiqJNj0bbZXMRGuefQyyjnLlLH6i2PaGfjnNciW5PlGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709098153; c=relaxed/simple;
	bh=WVOsekD0YlciUNDmos1PUGyY/as40Tb7Hp31obpuQjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqlhBv6dEYr79WVZHlojJa7UTLKppqT8HXST/S2DEnQMiVqHYZqzA5k+ROaIgd/e6AoyluVEyxJ34ey53cU41Lx+dQnC98ihwcrv6DTsrqHX69tNO9bCh6s3DR1wDPXhOrS4qEWnHWamK1QvbQwUOzEauTu8fV74nO6pZEAucfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QUlPnuYr; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e4b03f0903so554466a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709098151; x=1709702951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmmc3lSEBpnb8JOhy5dmt1TkGfOTvRv7m9E2Kxyp/to=;
        b=QUlPnuYrt4DmFrRWe7cUw2/0nrmj2iUPxI/Oubmt4BJeInIB1lMOwNY7EJrf4LMF+6
         UWbcxhy2OUyNbEwMazl4JCkdiQfcO/zBrCuIbZWP380a84q5SlYkGWPPrjzxCDlYGlAZ
         1+l0qfg1uhU8sRoC6WdnFZUjLdd4p5+2xy6h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709098151; x=1709702951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xmmc3lSEBpnb8JOhy5dmt1TkGfOTvRv7m9E2Kxyp/to=;
        b=DIpHmDxtbDg0mcX4VFayEVbMgVsEFcWWy7Q1berCrP/I0DkeuCt+69mkdGQzlv5gAW
         ip7Q738iefUwrd9TPSYIyOeBmqDBY1kOw23f4PhsmzFcbd5m0jVOZUqOehlgDzvrgHad
         uIQM/l9/4cteboWZXrw8euUJOmKxLmsgS1/ZIx95CkhhQZp1yAg1h5Vzs372+1F5v8nh
         i3hapiluCl23fjaQG0tAZ1UZfpyktl0bROwkRu3WKu8aVbdeQoSFrYGTqmzuOWl/Bom1
         rs4/fEG2GgykNYTopn8YcIo544SgO3h8L++iMEDY1uxQrnu4E0w8Wvxc2HfpvqMbw15y
         ncew==
X-Forwarded-Encrypted: i=1; AJvYcCWarKnsz93ThClLdu9ZTkAbAZyhK50eoxv018c/nUVS5AIjvx2IYc3qC6k3akZd41YfbFbwdt9Nmq5+ZlNmhNYYKH4g0MhaHtahBGaF
X-Gm-Message-State: AOJu0YzQ6gluvR5NSNgfl80Xx2FBvw3M5RXPbqu6LNbXmVCTRxGbWS5f
	XXZSxyF+VfHHb/91dNJswr7gs047NTYFE3DdHaRkjVZZvTXDbm+le0xmuB3KXQ==
X-Google-Smtp-Source: AGHT+IH+DD0XmnpARsicdXrncyIxsAW7NXvLB3VQEMd/cq4Y3AnNu4PK07nBXV6d2cSB2AbtnlsuOg==
X-Received: by 2002:a05:6808:1a1e:b0:3c1:adf7:c169 with SMTP id bk30-20020a0568081a1e00b003c1adf7c169mr4598680oib.4.1709098150902;
        Tue, 27 Feb 2024 21:29:10 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c1:1ad2:3268:cacd])
        by smtp.gmail.com with ESMTPSA id du15-20020a056a002b4f00b006e4bcdcff43sm6905919pfb.78.2024.02.27.21.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 21:29:10 -0800 (PST)
Date: Wed, 28 Feb 2024 14:29:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <zhouchengming@bytedance.com>, yosryahmed@google.com,
	hannes@cmpxchg.org, nphamcs@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when
 free_zspage()
Message-ID: <20240228052906.GI11972@google.com>
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
 <20240228043358.GF11972@google.com>
 <5a556476-05b2-483e-8875-eeb3e2a51151@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a556476-05b2-483e-8875-eeb3e2a51151@linux.dev>

On (24/02/28 13:14), Chengming Zhou wrote:
> On 2024/2/28 12:33, Sergey Senozhatsky wrote:
> > On (24/02/27 03:02), Chengming Zhou wrote:
> > [..]
> >> @@ -978,10 +974,11 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
> >>  		pages[i] = page;
> >>  	}
> >>  
> >> -	create_page_chain(class, zspage, pages);
> >>  	init_zspage(class, zspage);
> >>  	zspage->pool = pool;
> >>  	zspage->class = class->index;
> >> +	/* RCU set_zspage() after zspage initialized. */
> >> +	create_page_chain(class, zspage, pages);
> > 
> > So this hasn't been tested, has it?
> I have tested it in my test vm, but it hasn't KASAN enabled. I tested the
> kernel build in tmpfs with zswap enabled using zsmalloc pool, not sure
> why the kernel didn't crash then...

I hit the problem on non-kasan-enabled kernel.  KASAN was enabled
later on.

[..]

> > So when init_zspage() calls get_first_page() it gets NULL zspage->first_page
> > which we then use in is_first_page(first_page)->PagePrivate(page). As far as
> > I can tell.
>
> Thanks! I will fix it and test throughly before send an update.

I'm curious if we want to add RCU to the picture, given that zsmalloc
is quite often run under memory pressure.

