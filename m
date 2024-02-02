Return-Path: <linux-kernel+bounces-50131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A727B8474A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF88B244EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAD1474D0;
	Fri,  2 Feb 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="v33ULgmk"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE51468FF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891201; cv=none; b=snZmgR7e9iGvMcr1Rf0WdzNEEZ1XShjPHB+5KuC4lWm8vYSsANIyiKoNsHIDLuLfraFCETGd8OHKaJFwmUIr+oS4dHq2cz49fm6GK7wqTVexR3Armf6vvbwVE2oFiHA1kt6D+v0Fvj3IuHnDXtNJcAOabzaMBaBhbTTv0ZRwrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891201; c=relaxed/simple;
	bh=YjQN028awgvU7iwus9yS0iiqFqbGMgbr0N4Uc2tkmyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4iIph2x4TzVLg5fr6C72dU96g1xx4VnKUPt/YUAODBHy8mnp242ZZ8x53z0CzHEET0177hPWaDdu33jhl34a/J0Ye/HVHfxJdMKlTIZ5XUct5YD+h8wiQ/KGzTwTN9TUbJwYLJ+FZtBmT9bikDDwrNJKSHTAotZjZU2gf8l0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=v33ULgmk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c7a26a5cbso7870906d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706891196; x=1707495996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUtud9MaY+8DbGFxC/AgiltFpITZmSHoCy6Sbv7PuJc=;
        b=v33ULgmkUuytML+3TiJy+Ev9t3BjXD8lwYKZy1WwjsS8zVRs+I7Gj0gGEpjLsZ6E+w
         2ZIgjqYO6AX/Y7ScoF3BbT186EmKW+JSBkuXin+eJCk6f/GJWAJY92d/n+fB8zX213ql
         DV0g3k4CRhI13W9i8XGZ049+6CSR2ptG0pa9U/j9DbMSDLh0ICX9dBIzKdLaYK6NP8YR
         YG6yQJw2NarT7ZMRxdxp/V0mn2w5sOOZQ6bITHwZ8ON2ltj8Eg/bDHtZeSuLRdi90WlQ
         DC2TiDH2xkIFrOl4bbIkTHKImX0+ejonXwiQmIhN98PAUl86jdoehf002n090CnOMAGE
         InIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891196; x=1707495996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUtud9MaY+8DbGFxC/AgiltFpITZmSHoCy6Sbv7PuJc=;
        b=wPG+zhAOsud4mtHmZU5XALzB1y3UNCH6HVe42Ey5oLzUTNJ1z4M/I00mWzOf+9OzKR
         FHAbF4XUSQoSHdJLv2jJCLL0Ko9lrfmQp+KJm24NNp/O8LNYqXe4nU/3l+E6cmed7LyD
         9Db51FV3R7YJ6LMqtJQab20OvfrfnTlvTIg8Vaa9nIwtCG/ANrxYiJpcEVIBn7fNON+p
         e2airVO/XvdnGMIRPWVZnLtf3VFg/h6PDNRlIJZup/En293FL6sEMVJ5BOCyvwLocY91
         vkmLDqypdT9OAie0nYrc/cLxBLSlY+90fmQeCHK2+Ng7GyQhiehWCf3zsddEYXXF7BcC
         YR6w==
X-Gm-Message-State: AOJu0YwPC55QUqJ2UDOBWjpS/IlBxvchpSlW3kyHJnGeBHg2RIBAAoiJ
	XZHhlbe7F4Q1VUpy9Iu10Czx3OQNSim7XWY8JKU6Dh23Vo345wrfOWBL7NBvzfQ=
X-Google-Smtp-Source: AGHT+IGLUxKyRPMROGThz1MChgUr1mLMIxBmZCUdizoeeceVrz2k1V+5m9Klz9Xi0rVC6HzCJg9MIQ==
X-Received: by 2002:a05:6214:1249:b0:68c:83fb:b612 with SMTP id r9-20020a056214124900b0068c83fbb612mr3698583qvv.31.1706891196695;
        Fri, 02 Feb 2024 08:26:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLy6eSRRk6gE+pUfspZpC36LSIoz8TKb6OrfiQcB/j535+xtv3G0UK4Jd4hk03HP45prGKixWhBela9dScvtWqZo0JcY7OSJh2l1+ZhzOyGtKU5lEwZKDvwlj+O7EHgg39b82jQloS9S8sBOdhJ40NwoSPwvi58y6q7dOfrynzzEbRifII/TxboaVy60mcfQc4Dg==
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id w11-20020a0cc24b000000b0068c5b3a7f2fsm938734qvh.37.2024.02.02.08.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:26:36 -0800 (PST)
Date: Fri, 2 Feb 2024 11:26:35 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/6] mm/zswap: only support zswap_exclusive_loads_enabled
Message-ID: <20240202162635.GF1227330@cmpxchg.org>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-5-56ed496b6e55@bytedance.com>
 <20240201181240.GE321148@cmpxchg.org>
 <d5455b43-aa22-4931-a6b3-062128f4d30f@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5455b43-aa22-4931-a6b3-062128f4d30f@bytedance.com>

On Fri, Feb 02, 2024 at 08:57:38PM +0800, Chengming Zhou wrote:
> On 2024/2/2 02:12, Johannes Weiner wrote:
> > Caching "swapout work" is helpful when the system is thrashing. Then
> > recently swapped in pages might get swapped out again very soon. It
> > certainly makes sense with conventional swap, because keeping a clean
> > copy on the disk saves IO work and doesn't cost any additional memory.
> > 
> > But with zswap, it's different. It saves some compression work on a
> > thrashing page. But the act of keeping compressed memory contributes
> > to a higher rate of thrashing. And that can cause IO in other places
> > like zswap writeback and file memory.
> 
> [...] A/B test kernel building in tmpfs directory, memory.max=2GB.
> (zswap writeback enabled and shrinker_enabled, one 50GB swapfile)
> 
> From the below results, exclusive mode has fewer scan and refault.
> 
>                               zswap-invalidate-entry        zswap-invalidate-entry-exclusive
> real                          63.80                         63.01                         
> user                          1063.83                       1061.32                       
> sys                           290.31                        266.15                        
>                               zswap-invalidate-entry        zswap-invalidate-entry-exclusive
> workingset_refault_anon       2383084.40                    1976397.40                    
> workingset_refault_file       44134.00                      45689.40                      
> workingset_activate_anon      837878.00                     728441.20                     
> workingset_activate_file      4710.00                       4085.20                       
> workingset_restore_anon       732622.60                     639428.40                     
> workingset_restore_file       1007.00                       926.80                        
> workingset_nodereclaim        0.00                          0.00                          
> pgscan                        14343003.40                   12409570.20                   
> pgscan_kswapd                 0.00                          0.00                          
> pgscan_direct                 14343003.40                   12409570.20                   
> pgscan_khugepaged             0.00                          0.00                         

That's perfect. Thanks!

Would you mind adding all of the above into the changelog?

With that,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

