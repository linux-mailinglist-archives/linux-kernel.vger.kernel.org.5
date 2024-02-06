Return-Path: <linux-kernel+bounces-55165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA484B8B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874A51C22818
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B59133282;
	Tue,  6 Feb 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="s/TW/k3g"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DC12FF97
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231626; cv=none; b=OuABDMGnr6dRh7b79JGbJzVzyLQu/y17V2UfRanxvcdSUxwQlrYU1Pk1jEE/25UuFcemVLPSBIWkEMqLlJlQXvT393PsVKK2Csq0NTKdghhu0oXxJicuU3MoqVno47BX3KuehBb+Bqck9Px9kV8BwQiOaNiTU6PQzlDGqU8r7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231626; c=relaxed/simple;
	bh=5EwUYwTc+Kdby4uzdPPGkLQf+mKZYK9sgOSsYP5H7h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR5Kfu5LWlSj8jcN6rAydZy8opzaJbNVLquRLPYU6M/wg/aiV+TCm8s2TSAqbhKJr7BMWgPdKZCG8Q1+igKkgzbmB7tuRiu4lJFRff2sL9lMrEWdb0doVcOIe+wXnTMEMbGF3ekYunSm8WWBNekhB7iuRk6CNc7K5OJVmM68SZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=s/TW/k3g; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3832ef7726so74045766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707231620; x=1707836420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lm1WVEGM70O+cn3cikjEPo6m6D1TFmEKWlvuRMtKW0=;
        b=s/TW/k3gU+5mMHoxgeN/PohmQN6yVEzCAtyAUu8lHXweSuVPYFM6lKSSt8l9W9n7y3
         gvFm0h9AlebIUNtrgBDc4ciu0OdmdjcENcFLSgqClWDWTpVkrEDEmjDBsMbE9ipzcjzg
         mxgL4zizieSTFItKxmNgATbcoidnhDMPDjjkJTBEeu0t9I76lzcSJQy8139/ONG886Y9
         r4BEYzDtTwP8TFkB29k/lRncF57CXUmiB/ztHkpKNUmY81KVLmWQOmcffTdmRP04/8zo
         cerqt5bMCCpn0WVLdHCyDej4H6uaNxOk5Q7MKphNF3nQgb1psNU5hTxw5XJ1GM3GIIrJ
         3KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231620; x=1707836420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lm1WVEGM70O+cn3cikjEPo6m6D1TFmEKWlvuRMtKW0=;
        b=jYIQZNLpbkcaQzpwZwEoCD+x5CEqwr2MBd3dqWy3va2N77RzZmM3JiPidcWXU902nz
         OnM6e7d0PeyLoRsiUfoYNvdnvkH+eTYA0CQqEPqgVLhKyWMi/XHC43E7iga+1Asz+JeQ
         WMBhxD/rMlK54D2xuOHf5QweQ17G3Zl4u07fpATsTEH4xgdQzrfiNG1FI5FsTwhrZCaJ
         7YqiMVrtqk8pH/cdZcZEYka1fiPNS/c7ih77s13Pcoa41QAOkJXY9jrvwnZvMiEUsc4T
         4/IdQvW3pJ9ORD7eB0WbqQnkRixxXJsHOjSrX8FknWErKImH8BqBPiSWk0k7mXwGWERe
         QTqA==
X-Gm-Message-State: AOJu0YwYEX5/Q//ryYgcKfkmhddKKwLIYQJYmAJzaIOqoVmiWmkJ3Ygm
	Ffe/imk9CzozlJfTPspAbELzjoWBEcP8V9BtEb+7x5tVZXcwAoUsm/Dl2XPN5MM=
X-Google-Smtp-Source: AGHT+IGceBr3BsfPSINxik1wZC9wfeqv3DtYddrVTGjXJSAa0LOiPkbthXoSt5XOCFWUqO14w9hajA==
X-Received: by 2002:a17:906:80d3:b0:a38:4b2c:8178 with SMTP id a19-20020a17090680d300b00a384b2c8178mr434721ejx.19.1707231620196;
        Tue, 06 Feb 2024 07:00:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVgJHarqCma8HvB4toK09zIBbeF/vn+Hodrsf4cUEiVZB62SW8VfBlBDme8C6t2Y6OXpdCAglRYf6XoYKHIlaM5cCrVBBZKuowQ5ElUrZezJom3+VbV7fXpxgh2etzjGFMvIAKv2F/XkuN56zuEQyjUfkxm57aFYYIjMg4UvE0DIRdvBbcyBcd4KBGfGc3SEzEXuMwB1CX4yw2Qp7qquazdY4ZrJKS+y3M2x/I=
Received: from localhost ([2a02:8071:6401:180:f8f5:527f:9670:eba8])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906585500b00a369b47996esm1242213ejs.80.2024.02.06.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:00:19 -0800 (PST)
Date: Tue, 6 Feb 2024 16:00:14 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] mm/zswap: invalidate old entry when store fail or
 !zswap_enabled
Message-ID: <20240206150014.GA54958@cmpxchg.org>
References: <20240204083411.3762683-1-chengming.zhou@linux.dev>
 <ZcFne336KJdbrvvS@google.com>
 <e5315e2d-a03a-4b2f-9e12-1685fa0515e0@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5315e2d-a03a-4b2f-9e12-1685fa0515e0@linux.dev>

On Tue, Feb 06, 2024 at 10:23:33AM +0800, Chengming Zhou wrote:
> On 2024/2/6 06:55, Yosry Ahmed wrote:
> > On Sun, Feb 04, 2024 at 08:34:11AM +0000, chengming.zhou@linux.dev wrote:
> >> From: Chengming Zhou <zhouchengming@bytedance.com>
> >>
> >> We may encounter duplicate entry in the zswap_store():
> >>
> >> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
> >>    the zswap entry, then got reused. This has been fixed.
> >>
> >> 2. !exclusive load mode, swapin folio will leave its zswap entry
> >>    on the tree, then swapout again. This has been removed.
> >>
> >> 3. one folio can be dirtied again after zswap_store(), so need to
> >>    zswap_store() again. This should be handled correctly.
> >>
> >> So we must invalidate the old duplicate entry before insert the
> >> new one, which actually doesn't have to be done at the beginning
> >> of zswap_store(). And this is a normal situation, we shouldn't
> >> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
> >> to detect swap entry UAF problem? But not very necessary here.)
> >>
> >> The good point is that we don't need to lock tree twice in the
> >> store success path.
> >>
> >> Note we still need to invalidate the old duplicate entry in the
> >> store failure path, otherwise the new data in swapfile could be
> >> overwrite by the old data in zswap pool when lru writeback.
> > 
> > I think this may have been introduced by 42c06a0e8ebe ("mm: kill
> > frontswap"). Frontswap used to check if the page was present in
> > frontswap and invalidate it before calling into zswap, so it would
> > invalidate a previously stored page when it is dirtied and swapped out
> > again, even if zswap is disabled.
> > 
> > Johannes, does this sound correct to you? If yes, I think we need a
> > proper Fixes tag and a stable backport as this may cause data
> > corruption.
> 
> I haven't looked into that commit. If this is true, will add:
> 
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")

You're right, this was introduced by the frontswap removal. The Fixes
tag is appropriate, as well as CC: stable@vger.kernel.org.

> >> We have to do this even when !zswap_enabled since zswap can be
> >> disabled anytime. If the folio store success before, then got
> >> dirtied again but zswap disabled, we won't invalidate the old
> >> duplicate entry in the zswap_store(). So later lru writeback
> >> may overwrite the new data in swapfile.
> >>
> >> This fix is not good, since we have to grab lock to check everytime
> >> even when zswap is disabled, but it's simple.
> > 
> > Frontswap had a bitmap that we can query locklessly to find out if there
> > is an outdated stored page. I think we can overcome this with the
> > xarray, we can do a lockless lookup first, and only take the lock if
> > there is an outdated entry to remove.
> 
> Yes, agree! We can lockless lookup once xarray lands in.
>
> > Meanwhile I am not sure if acquiring the lock on every swapout even with
> > zswap disabled is acceptable, but I think it's the simplest fix for now,
> > unless we revive the bitmap.
> 
> Yeah, it's simple. I think bitmap is not needed if we will use xarray.

I don't think the lock is a dealbreaker in the short term. We also
take it in the load and invalidate paths even if zswap is disabled, to
maintain coherency during intermittent enabling/disabling. It hasn't
been an issue in production at least.

> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > 
> > For now, I think an if condition is clearer:
> > 
> > if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> > 	zswap_invalidate_entry(tree, dupentry);
> > 	/* Must succeed, we just removed the dup under the lock */
> > 	WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
> > }
> 
> This is clearer, will change to this version.

Agreed! With that:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

