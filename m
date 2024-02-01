Return-Path: <linux-kernel+bounces-48675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B65845FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65FC1F2C6C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106C12FB25;
	Thu,  1 Feb 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="rdVGw7i+"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B812FB0D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811170; cv=none; b=md3hNwAbVVIH1NjjhpLb9oyZcz0uyfiTUAjpoWd3f0bTQwsvzP19P438YzMIpyCZfv4KzZkqfIf7BdsgJ5UcSU5VrPLyb0TfmaIpkX4URqWS+CPAv4t0f4ARVgSvNk8EzNDf5yc7f0TF43H275fuIvEHz3NTQYoLsxHDCveenPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811170; c=relaxed/simple;
	bh=UuPIhFNDBOLIYfF7vX2ZEWimc9XTtKyUfVwEEO/21NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efWMTHeN59/yL7CSgH+4xTb5aUCGP2aqWr8wqxL4Wh5o4MhB+LFXx6j06QLS8gUyaGaB3+ldUo48NRsO67tcoN28+ls4Fr97w7r2QYqTxdWrEnS1x5b5X2p0Fn/HTud3ABYXxLKb7kqItouVg9aik1fZxaGdRjjhtfIt8TkZX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=rdVGw7i+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783e22a16d4so174593385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706811166; x=1707415966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7pFNo9wllIUlLWgzZSFIzQX8/BIsC9AxRoRCkFQD3o=;
        b=rdVGw7i+SbmkBpHtLRJ+JjDN0WGgV/B+1YgbqeaEiCway2EjAVa0hEXlSlWwAzFrkl
         ZUhZ6asYd6B9QlKC+MAJ/mdIGbM279B4FZy4JB+mozRUPMsKDeJfOAAeWXk3phYphOdM
         o3Z51MWInL3ux3V+3dlqO4GpENhf9TLgOo4d8I0BgXT6qCvD8CVljBJKpFyKQw7ln9HI
         cue6shJPb4AB7LicJ5G35lYN+UWh3UwqQbOehs0UYkS9glZNLwP5a9eBRM8Uh3Ji8wby
         ziuQwhh/Bdbbpwz129Xpcx7Gw+OBh20iE2J7wR03uuC0b8fJc8tjT6XwQzUEicjeO5DC
         dEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811166; x=1707415966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7pFNo9wllIUlLWgzZSFIzQX8/BIsC9AxRoRCkFQD3o=;
        b=EMcUe5ZRiBSu+PsRe3NvZzRqMrCGl/3QVHrdaryVJl09t6hv+bHFe63nOeH3Ec6EJL
         jM5rfHv4u37yeFsFV/ce5A/zZdNN2itfEyi7bg9OV41vpdC/jclnjGDAS0U81FP2bw7h
         /CjQ2NbiauMt1il+cwFSZ6K9CWufCWjAk5O5wLg/6/aghH/4V0IzWM0ABIxzLelHFqVw
         bhIrAnU15I8sQacieko+xjQ4Gf3J+TGx9maenUtH0T4ZVg4yCtyiDUg6L8jtNK4ANTzs
         NH0o33Wk2fjamyPVhkGXRANrgWgwH9SqC1+OJ+sTDmZJ7rmOGN1mNrpT28essWJwqnX7
         P/Zw==
X-Gm-Message-State: AOJu0YzUPjrdp2z2FFSjgs8bsG+MMlibboFjk8/X19g3dNGmO146e4xW
	zrRTdWrYUkyOb83E6PIGX/4jebgaFwbwX2Q9lQNcIFwNnSYBm79hcHtsP8fyDXc=
X-Google-Smtp-Source: AGHT+IH+kpI7VVtmvFtvKwua4b/SnW+Caog8FEaXBrC3QNWDmleH6fXAbOl8JftGfv8N2puw18DjZQ==
X-Received: by 2002:a05:620a:46a9:b0:785:3c7f:304b with SMTP id bq41-20020a05620a46a900b007853c7f304bmr4534794qkb.39.1706811166216;
        Thu, 01 Feb 2024 10:12:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcpzEYHSB9QtnuNeBy/nj/gZmwU9fKY7dvMJLTUzSlVxOjfHZ7NT+Or1jhBuwspiHPIUSYp5tD2BnTrQqTgB0gonYjW1Zw2HLckwPO5F6+oOJiSh/G+WuseOsPzvZSVsk1CFeWm+ct5lRrinSxTQ8d98vc44APWKEdjaiOoGrrInVJ/fjORxr9ymMExz5QtBGRUw==
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a159b00b00783dd0f9383sm28770qkk.7.2024.02.01.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:12:45 -0800 (PST)
Date: Thu, 1 Feb 2024 13:12:40 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/6] mm/zswap: only support zswap_exclusive_loads_enabled
Message-ID: <20240201181240.GE321148@cmpxchg.org>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-5-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-5-56ed496b6e55@bytedance.com>

On Thu, Feb 01, 2024 at 03:49:05PM +0000, Chengming Zhou wrote:
> The !zswap_exclusive_loads_enabled mode will leave compressed copy in
> the zswap tree and lru list after the folio swapin.
> 
> There are some disadvantages in this mode:
> 1. It's a waste of memory since there are two copies of data, one is
>    folio, the other one is compressed data in zswap. And it's unlikely
>    the compressed data is useful in the near future.
> 
> 2. If that folio is dirtied, the compressed data must be not useful,
>    but we don't know and don't invalidate the trashy memory in zswap.
> 
> 3. It's not reclaimable from zswap shrinker since zswap_writeback_entry()
>    will always return -EEXIST and terminate the shrinking process.
> 
> On the other hand, the only downside of zswap_exclusive_loads_enabled
> is a little more cpu usage/latency when compression, and the same if
> the folio is removed from swapcache or dirtied.
> 
> Not sure if we should accept the above disadvantages in the case of
> !zswap_exclusive_loads_enabled, so send this out for disscusion.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

This is interesting.

First, I will say that I never liked this config option, because it's
nearly impossible for a user to answer this question. Much better to
just pick a reasonable default.

What should the default be?

Caching "swapout work" is helpful when the system is thrashing. Then
recently swapped in pages might get swapped out again very soon. It
certainly makes sense with conventional swap, because keeping a clean
copy on the disk saves IO work and doesn't cost any additional memory.

But with zswap, it's different. It saves some compression work on a
thrashing page. But the act of keeping compressed memory contributes
to a higher rate of thrashing. And that can cause IO in other places
like zswap writeback and file memory.

It would be useful to have an A/B test to confirm that not caching is
better. Can you run your test with and without keeping the cache, and
in addition to the timings also compare the deltas for pgscan_anon,
pgscan_file, workingset_refault_anon, workingset_refault_file?

