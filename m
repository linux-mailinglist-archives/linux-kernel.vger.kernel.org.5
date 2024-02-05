Return-Path: <linux-kernel+bounces-53967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCED84A88D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3191F2CC97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A974F1E5;
	Mon,  5 Feb 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsDHlM0s"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E945953
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168051; cv=none; b=H0wuiMQ1ZG9089ikgcPYWdz7esdC9Qi9yoWhbgoYvrPvLWC7EyYA0fUraVkO1A5e7buzQedWiPYK2/CGMTbWGiaa0UOJdjO4WwapIHXHLbAUVwOSVNQXRo1hb6njO9ZInZMky2/OLTVW0gfjE2y5qvvQOEWfwvQSWc9zvHnAQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168051; c=relaxed/simple;
	bh=M9O3+Ozab6saJ9Z898RaMAf45Ltfzqt72TIxEA7NSds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E1ncCwmDct8FKbwmSo9hSdNs4J6J3XXpvTf1VKJcOYk29ObKNwp3+6Gi9Ds/KkwKgvJ30s4yTeL9VU/nPuE0d9FkxTQ9Gxfo9riSmiKWNjKU4XnJyPkuwwBiIvfTjEsdNMgjj3bHkhNuo7d3Tm+LE4/KygqsgfW86V1fbNgyHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsDHlM0s; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040a34c24bso3478547b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707168049; x=1707772849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNIvfpTU2Fpa4ge5KnuIotPD5KC6q3mmjxvezR8AkOo=;
        b=KsDHlM0soT9qHy72nMp+pmFlQfvY+J2Vy6/RKbSpR0G6RLHY0KWQz/MptMS5UNUdqT
         eeghsPO7jhE/hNOLf4SLxxfd079JsXVufE5g6B+2GopueuqLnwh2PdF2SUxiAKVw2IuN
         1DqgUgR1tnOOWsPvqGLdj9yqwGG4xNqThJvH1gac2lln71XFqFYoBz7KVgL8qzyLORyC
         NflTDKiKwRzUFkFKZIWIYOSPzMwbsyWUfY+jnIYQo2qroOGgK/CBY1uOUml4Qoag3DTU
         KMZqTdQQayw84vfKhpNNpodPlICJfhcqdb+OeeiJ6U159hZnV4yEdioIS18bsd01GCZ/
         9iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168049; x=1707772849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNIvfpTU2Fpa4ge5KnuIotPD5KC6q3mmjxvezR8AkOo=;
        b=wYN8X/PZIgC+NkPuVL+uD6F2FIspipO2G7HBIJdhpYoGdXTGRNXuCtbRMvABE1u71g
         afLzfl0o81VFFfu64QR4QzVlYntkfQpxSV68+FKGfS+73RBXrJZsKp0DV0ajKjs2zgOK
         Shfva4U24T1XAIdQPWMO5nWlFNbmYjfo3bew4eygrMN7BnuWcMUb3Zr35w6IxX5kRsRn
         7Y9hYupsXAymN94SHwXhGC73XsX9z15MeWOoZHB5ebPo+yLbCnLpQdshpuD+Cqh9kUMt
         m8EXF/A6hYczWSlpi+Te/+66Jl+hB5nM6cXJmdOHXytS3PSlE13uviMOHZUh/N3cxyim
         AO/w==
X-Gm-Message-State: AOJu0Yx4xajkefyjHJhfhdny0qh0xRVTi9jDoyYGKeLbNguM1UeFYpgT
	IDT7tenETcKDBaWBMHmz1YGoRah9KNsjMmj/GEVtmEM2mYdsetv/WEYZtwieom+B5OcqbDhDp0Z
	8ewBPlNk5NadsnrW/jg==
X-Google-Smtp-Source: AGHT+IG3rtxQ30HFoMYrB9CwJEYIFwygob6z+BpBr6JkE2L81EEy5Naj69geg9TJ7LPf+Bv75g4pLQO69lQDNu4M
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4cc7:0:b0:602:d83f:bf36 with SMTP
 id z190-20020a814cc7000000b00602d83fbf36mr150466ywa.0.1707168048867; Mon, 05
 Feb 2024 13:20:48 -0800 (PST)
Date: Mon, 5 Feb 2024 21:20:46 +0000
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v2-2-99d4084260a0@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v2-0-99d4084260a0@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v2-2-99d4084260a0@bytedance.com>
Message-ID: <ZcFRLiazBrbhm4Gf@google.com>
Subject: Re: [PATCH v2 2/6] mm/zswap: invalidate zswap entry when swap entry free
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 04, 2024 at 03:06:00AM +0000, Chengming Zhou wrote:
> During testing I found there are some times the zswap_writeback_entry()
> return -ENOMEM, which is not we expected:
> 
> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
> @[-12]: 1563
> @[0]: 277221
> 
> The reason is that __read_swap_cache_async() return NULL because
> swapcache_prepare() failed. The reason is that we won't invalidate
> zswap entry when swap entry freed to the per-cpu pool, these zswap
> entries are still on the zswap tree and lru list.
> 
> This patch moves the invalidation ahead to when swap entry freed
> to the per-cpu pool, since there is no any benefit to leave trashy
> zswap entry on the tree and lru list.
> 
> With this patch:
> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
> @[0]: 259744
> 
> Note: large folio can't have zswap entry for now, so don't bother
> to add zswap entry invalidation in the large folio swap free path.
> 
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>


