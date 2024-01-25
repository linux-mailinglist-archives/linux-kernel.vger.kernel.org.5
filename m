Return-Path: <linux-kernel+bounces-38227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44783BCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21C91C28800
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289691C6B0;
	Thu, 25 Jan 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgeOmCN7"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38181C6A7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173439; cv=none; b=QIUPSiIJ4vij2RytXJaAEk6pCmuInJ4tqrkpNNRUzE0vAWP9EO8chdY3HQEGxMka2jN8ehgcZi9alM3t4KtSUqQPnkO7RnSC1UnfyVbQYj4o4shwPB0y/84rwXuDcylAQlKiyNjE76s1bzecwupez5vtLLHcMPvfHUhVM5uW/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173439; c=relaxed/simple;
	bh=lCpLs7E421WcMGulhvf0KfE1pIEkKe5LczYASKz1w1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9v/VRag9wvGYN4rHtpWi5ffm7JbsYQmPT5DH43fVKwSjdw89jLJlu8ftu0PxNNxL0cI9KnnU9bRVnVw7TJirBPdlwnwLTUmizo72AOdGdYdzzAbcC6w71p0kJlZK9xW3AgITWXWCJOVJwIc5SLsHvjSyMxWImNNO65kzDBynSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgeOmCN7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-510133ed214so2109504e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706173436; x=1706778236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCpLs7E421WcMGulhvf0KfE1pIEkKe5LczYASKz1w1A=;
        b=tgeOmCN7XGsKVc9o6W5x6z0mVhOh4xjxqKAijP3LQPNVrjfXQPwre+yfMtjSbPAd25
         3ABwAyD28v8y5Q4ra+tBK191TssYvnT7nyBDdmrPeWxsDudBTJ0CuqwuAB0BjrCOJJox
         qmhfRl7fT5HCv9Tb2wGz7sY8XKZIen4ZOKDBTjN39LXNrvMLgS5u1SI1Ge3MsHbukQNY
         /PnTodLoM0M2koONZ/+PmvuNJDca4HFkFF5KdI+FTyOrxXZWLtUk0kYOJ4B8q+b70uOC
         JOHuWA6zglEfmknyyC/0R6J9XkGTv5G0Ldj1ofOMryLllOe8aqzCJR6tqq8FxcAHhvRS
         s0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173436; x=1706778236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCpLs7E421WcMGulhvf0KfE1pIEkKe5LczYASKz1w1A=;
        b=dC+QeyGSKcswq5ir3AxUvJc6HwByJLk/WkobffvucgbNHGJWdhg176SYP5pp+DfWaZ
         DX2pEJE+p4r3W92kc8VrzP2KCvS/yhbNKvYBT6/5ZGZjX/QhSAeDQlkz7msGMAo4jizV
         esruiAZ+C2C2fhQX1ke1H+hBsiBvkoWi7O1gTQzgkK0j4Zysd3vHfYWdc8PktATEyQEy
         bztFZ2vzJZ0aJ/O6Zp3oF+c+OIKfgzgiPmVgSxI7iT04QSqGKL1MZH7j2jJ/44HkXgFv
         NTg774gPOqk0pkPXVNbs/KgXETBjAyQr3TN5nnlDTxs+M9YSGewu+XT2N6r6Ed7f7RiP
         TI4w==
X-Gm-Message-State: AOJu0Ywx1Wd2/bcryctHt8xvPL0V9Gxy/X38IH/p658MgT928j27g8xI
	P1GarKsoU8Nm27M7wvBojS+d4BnknVPPJ6sJFsgN6Cwbrf7QwWVjapnFQMSp+D5lHGyUaJ8ekFW
	qgy9uEYryrR03LEMcwBw/D+B5JOIHn/4KNgLXGZ5BfqbVW//SQnkj
X-Google-Smtp-Source: AGHT+IGaUFMupZ0OqkZ2M2weP4tIoXXZ5zWfJsaAb+DzoczkyGqeGdhCslJXaL4xjEDOPQj4Zgv36x+m1y+7Wb9zKFQ=
X-Received: by 2002:a05:6512:3caa:b0:50e:3fbc:7c12 with SMTP id
 h42-20020a0565123caa00b0050e3fbc7c12mr315562lfv.126.1706173435656; Thu, 25
 Jan 2024 01:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com> <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
 <1496dce3-a4bb-4ccf-92d6-701a45b67da3@bytedance.com> <CAJD7tkbrQw7FWx-EDKKCtH_E03xEd5Y+8BqRjE8d29JSOCGybg@mail.gmail.com>
 <35c3b0e5-a5eb-44b2-aa7d-3167f4603c73@bytedance.com>
In-Reply-To: <35c3b0e5-a5eb-44b2-aa7d-3167f4603c73@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 01:03:19 -0800
Message-ID: <CAJD7tkak+ZA8t+AVbYNXYWnrmVBBs=NfMTBQBsnHJQni2=gG2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >>>> The second difference is the handling of lru entry, which is easy that we
> >>>> just zswap_lru_del() in tree lock.
> >>>
> >>> Why do we need zswap_lru_del() at all? We should have already isolated
> >>> the entry at that point IIUC.
> >>
> >> I was thinking how to handle the "zswap_lru_putback()" if not writeback,
> >> in which case we can't use the entry actually since we haven't got reference
> >> of it. So we can don't isolate at the entry, and only zswap_lru_del() when
> >> we are going to writeback actually.
> >
> > Why not just call zswap_lru_putback() before we unlock the folio?
>
> When early return because __read_swap_cache_async() return NULL or !folio_was_allocated,
> we don't have a locked folio yet. The entry maybe invalidated and freed concurrently.

Oh, that path, right.

If we don't isolate the entry straightaway, concurrent reclaimers will
see the same entry, call __read_swap_cache_async(), find the folio
already in the swapcache and stop shrinking. This is because usually
this means we are racing with swapin and hitting the warmer part of
the zswap LRU.

I am not sure if this would matter in practice, maybe Nhat knows
better. Perhaps we can rotate the entry in the LRU before calling
__read_swap_cache_async() to minimize the chances of such a race? Or
we can serialize the calls to __read_swap_cache_async() but this may
be an overkill.

