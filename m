Return-Path: <linux-kernel+bounces-117470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8A88B13A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB8BC61E67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C944213BC23;
	Mon, 25 Mar 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nXnScmPP"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA713B2BF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384213; cv=none; b=lgI4/66iWSF7sgIRemIbA/h97Q9LhdCSb8vOinoJPIRQslsLiWsfQl01KvsN9jpkENlzWb/vKYCFDtcKCSqT9FOLB47mXeHmhPgLouDKe+J9PX0xkEMU+Tojtl8F9NSwpqQFiXqm5tOuuh2ZQcv01vC7hcuZyu9OJquaIM0CF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384213; c=relaxed/simple;
	bh=pzIDEvDYn0DvQqlQatHFYLs+SqVIi4LsjW0ZnR/fbxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryf9lK3VpgpnwZqXf+/YHZ7yuTqikK+HGRhWu0ewAUyfZE0bo9jeZXp+BgXWLnB8/FJ/llBvI/EZXwjlBUhtGvO013poRb/ho/J251T0G3VBi/Az+qGWJ+kLBHbx/t2Deoof+veXxaYXa9zbQux2tI5Q+kv9TC/1TtOX3BdBFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nXnScmPP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78a3bccc420so217692585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711384209; x=1711989009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWU1iomNitCz7xhvZ+axr2VvsxukZq2xkRMym6uJF3U=;
        b=nXnScmPPXZE+wQv+bek0TJAUjFT6UXFGtT2qkom/nbxMYPOpuv9KkA+pPe4riCzy/s
         Shu2BG6CzVundU5g6rKH8d2dx5pblroLRFLUfnYfIiOwfKUdbft0ShG71lmr0Z/4inhN
         bAnj6NpFJpHqD29l303leyT3L/2BHNFf3q3M+qKk05DUlJQd7HCfANuZ7IJWUkkNszZG
         /DFW7g5WNcMWlvJ28sJ2T5QH+mMlOTuVyPkxJhPpJJuMmukr1dTSikZk5ot/o/F9lqdT
         V8Xlc7Gspksan3sNwH2eSLMD08mOjjFiucdDOFWs6gOnBVS5EfkZYbUVqhQW6hkXj79U
         xyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384209; x=1711989009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWU1iomNitCz7xhvZ+axr2VvsxukZq2xkRMym6uJF3U=;
        b=w6E3ga7l/tRYsbMNirl9XOsS8v8UisQnElK2LDeoyOogflYqMkLf118cCvDoKcD9aV
         GPNHU2gosO5OErfh8Tya4kDcTLtA4KnWh/F6yU8G0SV0BvIrMziNw+gBJOv5pdLAeeEU
         WaM2rQGVR7krbjCftonyRHS2d2G/EkU/BwT89zbGhnYcROi2Ksnq1fZ/dHlfEfyMIMLp
         5ux5iEFbvwz0niKZ3KoFPwMFrDkIYCwaAJMEGm8VHtqVbE2ihRxjsjiz9TJX2Has+fK+
         2TTyABVnIA0nd7JPFRYr2UeNiADmaloOj7m1MzukBhDUVbd2sGZ/sQR2QmzZDOkKR//G
         x49g==
X-Forwarded-Encrypted: i=1; AJvYcCWs6BKoQQ2hqu/sh+BiOIFDH54qsnamLh2P9LZGKDVt4wo1EyrxHkY90ozFRFIHaEiehlHTeENtclGt3x2ffaq+ivPkm/ZVoyDb5afT
X-Gm-Message-State: AOJu0YwsfulAJatHU9CcqvT3vu7CovCeuRBZvPu9zA/fPq6uYLUCeqQU
	M07dxXEcBj5cwA+ffTRmEImG81hvm4ue07iMFOSk+CqehVrplwlvbxXwDr9lkX8=
X-Google-Smtp-Source: AGHT+IGfXdktUARTW/DIGirjPlGgHS1vx0o8seoKe5LBSCoLW8vOBkpB6lCZU2LWre+0twxZLn25MA==
X-Received: by 2002:a05:620a:564f:b0:78a:29e1:6255 with SMTP id vw15-20020a05620a564f00b0078a29e16255mr397584qkn.20.1711384208711;
        Mon, 25 Mar 2024 09:30:08 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a0b0100b00788402160besm2232411qkg.128.2024.03.25.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:30:08 -0700 (PDT)
Date: Mon, 25 Mar 2024 12:30:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
Message-ID: <20240325163003.GA42450@cmpxchg.org>
References: <20240324210447.956973-1-hannes@cmpxchg.org>
 <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaWQAV=X1pzYG=VkWe7Ue9ZFbjt9uQ5m1NJujtLspWJTA@mail.gmail.com>

On Sun, Mar 24, 2024 at 02:22:46PM -0700, Yosry Ahmed wrote:
> On Sun, Mar 24, 2024 at 2:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Zhongkun He reports data corruption when combining zswap with zram.
> >
> > The issue is the exclusive loads we're doing in zswap. They assume
> > that all reads are going into the swapcache, which can assume
> > authoritative ownership of the data and so the zswap copy can go.
> >
> > However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
> > to bypass the swapcache. This results in an optimistic read of the
> > swap data into a page that will be dismissed if the fault fails due to
> > races. In this case, zswap mustn't drop its authoritative copy.
> >
> > Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=zV9P691B9bVq33erwOXNTmEaUbi9DrDeJzw@mail.gmail.com/
> > Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> > Cc: stable@vger.kernel.org      [6.5+]
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> 
> Do we also want to mention somewhere (commit log or comment) that
> keeping the entry in the tree is fine because we are still protected
> from concurrent loads/invalidations/writeback by swapcache_prepare()
> setting SWAP_HAS_CACHE or so?

I don't think it's necessary, as zswap isn't doing anything special
here. It's up to the caller to follow the generic swap exclusion
protocol that zswap also adheres to. So IMO the relevant comment
should be, and is, above that swapcache_prepare() in do_swap_page().

> Anyway, this LGTM.
> 
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

