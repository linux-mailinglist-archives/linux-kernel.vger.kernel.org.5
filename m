Return-Path: <linux-kernel+bounces-30290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D389831CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E44B219B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046BA28DAB;
	Thu, 18 Jan 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fcHk/YjR"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714D28DA0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592079; cv=none; b=jfBRchvIiyzW2L6Lv0lI2Fi8JEzhKzrWNRVCudef8dhjtTjZ5bf4SzY7hcW3nHNWhgpii1CM1fTinBip+V9Rbi4JtEl6127cZuv1R/h4wN5wfONqPBa+KdoZmYShXyESzNmhuyZyC3gQenRAVeluNiep6wjSpiWRa1fYElQEfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592079; c=relaxed/simple;
	bh=UGxG6EyibmRAM5Y8/h5dxRVzsp4YczRcqVH4LdOjekE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=Kse23T+BdtE/j5K4rBV9+z+E7HRv3klM0WX9dgZqoA7iNhmPwOegUVLBxt4bKloYfcSED5wAdSCAZf+mBIjAc6ZPvmvfCuiiEjw2JrxkMHwRjD2zQn8h2VAp4mWYnLZj0HFpQi9Sx4Xe+u4LMdaPDMkirJrNyl5xFrTHhZxzLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fcHk/YjR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7833bd8be24so64624085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705592075; x=1706196875; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z90u0SuucO9XdrnILoeOBey/mQvJmgZQH7Wy3n6yiQ0=;
        b=fcHk/YjRkTT7EwBvCqG0rkxfKqk6wgzVR6TteWnxFXrRi6Mh7Z2d5L+A0Y+LRyL3yc
         mCc0xJLqPN5SfVRlp0jU0jBXei0IhOpGWis0aNb+3aqIwOGdFAvFmBbUjAmmuIIUr7KM
         v0ZZyAMaTdlj+jvyiVae55pdmElGGvKSYaY47FXxO8OqU6BAiHC89xLWdhyr3P90zcDH
         oZC/rgvORFSxCm3aYCCCyRt1blbSHgl+O9sDhn+3dQrOe/QSkwZZDrONJhVuP/YV3xSM
         0PIJV8OR++xfJttd8Szw2qHwFlXmkftNMYcBOFftQWLJuGh4HpLa7fq8HD2DE9MkAqDc
         aLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705592075; x=1706196875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z90u0SuucO9XdrnILoeOBey/mQvJmgZQH7Wy3n6yiQ0=;
        b=v09Pw7JFdMdtaAd1bw7lMtvmqbJyWFk/GWDf6VQox1YeCwiAalYPTVHeR+t10LBkSz
         s3AjXGFHgER9XTNpJXbZwhhCIkfqGOCA3bc0Av4kW+KhAYSSWjZXeuGmrBmfSMdHYvdF
         F3F9HI2pcHMJ08h/qlJTsjUmzIg4aNkDZbifstqLMQk8JVE6RcZVgxQMuZUN8vwoqowi
         +tsrnilh+222Zp2MEbXxZHp6DQSvJcSIUdTOnihUKamWizgh2I9HSf20khnESBuBObnJ
         003YLoqxnJsKVP89aPKdm3b0SHPgFb+QK4BcWkNO37ZgF8Qe0J4acUnckLc1NQ3OHbg7
         h7Dg==
X-Gm-Message-State: AOJu0Yzmn1JbRb81LdUqzRCrSfug4fyGfFb44LJCpzm+PxaNV4F34QS1
	ADClWPCw2Ipvj3qxoRi3H+kg9rAgJAvjHN35RzyrcNsYnqv7HYGIeZeLcPDYWwA=
X-Google-Smtp-Source: AGHT+IEJpW6Lgi4UzRfBaM94wBsZuW5rwjyurtWeDGfMBYfTAFgQqavFd6uKsVqZK9cdsmYFOFoMag==
X-Received: by 2002:a05:620a:3902:b0:781:b6a7:2d6c with SMTP id qr2-20020a05620a390200b00781b6a72d6cmr4016350qkn.8.1705592074948;
        Thu, 18 Jan 2024 07:34:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:d00e])
        by smtp.gmail.com with ESMTPSA id m1-20020a05620a214100b00781df3924f3sm5350981qkm.129.2024.01.18.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:34:34 -0800 (PST)
Date: Thu, 18 Jan 2024 10:34:25 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
Message-ID: <20240118153425.GI939255@cmpxchg.org>
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>

On Wed, Jan 17, 2024 at 10:37:22AM -0800, Yosry Ahmed wrote:
> On Wed, Jan 17, 2024 at 1:23 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > When testing the zswap performance by using kernel build -j32 in a tmpfs
> > directory, I found the scalability of zswap rb-tree is not good, which
> > is protected by the only spinlock. That would cause heavy lock contention
> > if multiple tasks zswap_store/load concurrently.
> >
> > So a simple solution is to split the only one zswap rb-tree into multiple
> > rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea is
> > from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
> >
> > Although this method can't solve the spinlock contention completely, it
> > can mitigate much of that contention. Below is the results of kernel build
> > in tmpfs with zswap shrinker enabled:
> >
> >      linux-next  zswap-lock-optimize
> > real 1m9.181s    1m3.820s
> > user 17m44.036s  17m40.100s
> > sys  7m37.297s   4m54.622s
> >
> > So there are clearly improvements. And it's complementary with the ongoing
> > zswap xarray conversion by Chris. Anyway, I think we can also merge this
> > first, it's complementary IMHO. So I just refresh and resend this for
> > further discussion.
> 
> The reason why I think we should wait for the xarray patch(es) is
> there is a chance we may see less improvements from splitting the tree
> if it was an xarray. If we merge this series first, there is no way to
> know.

I mentioned this before, but I disagree quite strongly with this
general sentiment.

Chengming's patches are simple, mature, and have convincing
numbers. IMO it's poor form to hold something like that for "let's see
how our other experiment works out". The only exception would be if we
all agree that the earlier change flies in the face of the overall
direction we want to pursue, which I don't think is the case here.

With the xarray we'll still have a per-swapfile lock for writes. That
lock is the reason SWAP_ADDRESS_SPACE segmentation was introduced for
the swapcache in the first place. Lockless reads help of course, but
read-only access to swap are in the minority - stores will write, and
loads are commonly followed by invalidations. Somebody already went
through the trouble of proving that xarrays + segmentation are worth
it for swap load and store access patterns. Why dismiss that?

So my vote is that we follow the ususal upstreaming process here:
merge the ready patches now, and rebase future work on top of it.

