Return-Path: <linux-kernel+bounces-108740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60D880F69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6159CB20FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F73C460;
	Wed, 20 Mar 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="oQlaSltW"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4392D78A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929689; cv=none; b=sIyzfcCL9lsaP+9MqRzxHsXQkzkTIxFGup8upEQTurkii0g1F3VpTSOpX5PsiQ3ZE9ka/+YQKTiwIGAE23eSsEgeB8Jv/00+TL8BQfTwDN0tl/Vd1W954QIGI6C9PV22yMVsUygteP89ydO4lO1kkDAv9QxhNy2FHAxD4mlHT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929689; c=relaxed/simple;
	bh=Dp7oI4jQ5BAPY470AuI/28Q1FtHX12Vsg/51DgQ9RUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNhGKXuJeHHn4oA8mWaR6vPlX8HRT4QAi7YzQZXFFF8aNsQTGSB9p8r+PzaM4u85/NcsA9ukUTvBrkHsFbbXMiHQxsEkPEJd++2pC2R5XcQDuibilWe77qYMvAmMj/hs9p/qdIvhySOkp2JaCgFby6ejiKmqIBtuagc6wmKeLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=oQlaSltW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6962950c6bfso18310516d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710929685; x=1711534485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIdNQKimwbO4SdsHu9cO1H1ZXloSska94vh6QN7qHYo=;
        b=oQlaSltWC3RifovFGJqrvHFcUawg0Ih+/RIUqK52BIPtW3W717dUM9e3mRFYVYNdEx
         38AA5Neo4g5ml5Hj7XUOLRWjovUk5WB1JJDZ3HY1pHGYkTVyPzOruRl1PDh9p+cvcnvp
         kC+Rx7hiQbav9IZn7XllM2PD6djYTotwN4P/UHI/CrvWowoHo4J1aQcpUbR8zSusr9LW
         7j5A6xRgphQoNu5YTVOb3bKuyOCWbbo0tKvXKoA54KU9fryNxXKgZmZYOgYaFO1mPzAG
         ntXLHlZ9ykYKidrY88HlGhZcFH4qTBtHpvHb5ce8wApVPk8dKhhIQqW+JrA/QspLRiK5
         9u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929685; x=1711534485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIdNQKimwbO4SdsHu9cO1H1ZXloSska94vh6QN7qHYo=;
        b=gbDP83s23EyEiXyIU9Fyfhs4CRI8AbL+MtTByR5MgYCbOap50Bt2RtoFQGoXHZ3sBp
         3Uz9hAK+ZcoHEksPQf9+2pN2+o41eNTNBaRU/QZGfV1v0nogJyKMqke3MvL2kZqHXvSe
         czDRb7o3Kr0+lSl4xmTHWv6SqvjgjJauSQEyK03FVKoRfm0AU9dGuqbyywj/jmoBm+Pz
         PzgKGSRtG6DGsQMhIx+sqL/LPqQtRm3nnPQqwVurjb+ms5HP+GvLoseY5tTgbspNSFwK
         TipmkSPJ5/erQQaPe3Pfy+oVupj5OfXbeG6vFFEzg5U4ok4SKVns5yz1VUZdXpcMBaDH
         gJbg==
X-Forwarded-Encrypted: i=1; AJvYcCX5kAUCsc2A5cfItjLhx5heJTFlClDLOVMyHXgJWCk2LKVTf0W1WlAVAnXDWwicxx7626Leky6Ey47Br0r+wXXSZ4HTFuDDuyqxWWIC
X-Gm-Message-State: AOJu0YyFiKVHNkI6Tk/mBd121i92sDu/R8pohMbMxajjcuL/VH8PsV89
	0PjZJsMXZ80qD/hlqHPmNzMo2ELSowEzglDjoQaEnbTVv7YYku5qGOtgbNLozkY=
X-Google-Smtp-Source: AGHT+IGUfT/MYBgGd9ydckJcwXtGLh1R76fV0hknm0SpugndiPCs6yl7UiANH3JRfS0vaJzxAHIezA==
X-Received: by 2002:a05:6214:bc1:b0:690:dcce:227 with SMTP id ff1-20020a0562140bc100b00690dcce0227mr15873225qvb.29.1710929685588;
        Wed, 20 Mar 2024 03:14:45 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id jn10-20020ad45dea000000b00690dd47a41csm7669869qvb.86.2024.03.20.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:14:45 -0700 (PDT)
Date: Wed, 20 Mar 2024 06:14:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
Message-ID: <20240320101444.GC294822@cmpxchg.org>
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>

On Tue, Mar 19, 2024 at 10:52:26PM -0700, Chris Li wrote:
> Very deep RB tree requires rebalance at times. That
> contributes to the zswap fault latencies. Xarray does not
> need to perform tree rebalance. Replacing RB tree to xarray
> can have some small performance gain.
> 
> One small difference is that xarray insert might fail with
> ENOMEM, while RB tree insert does not allocate additional
> memory.
> 
> The zswap_entry size will reduce a bit due to removing the
> RB node, which has two pointers and a color field. Xarray
> store the pointer in the xarray tree rather than the
> zswap_entry. Every entry has one pointer from the xarray
> tree. Overall, switching to xarray should save some memory,
> if the swap entries are densely packed.
> 
> Notice the zswap_rb_search and zswap_rb_insert always
> followed by zswap_rb_erase. Use xa_erase and xa_store
> directly. That saves one tree lookup as well.
> 
> Remove zswap_invalidate_entry due to no need to call
> zswap_rb_erase any more. Use zswap_free_entry instead.
> 
> The "struct zswap_tree" has been replaced by "struct xarray".
> The tree spin lock has transferred to the xarray lock.
> 
> Run the kernel build testing 10 times for each version, averages:
> (memory.max=2GB, zswap shrinker and writeback enabled,
> one 50GB swapfile, 24 HT core, 32 jobs)
> 
> mm-unstable-a824831a082f     xarray v7
> user       3547.264			3541.509
> sys        531.176                      526.111
> real       200.752                      201.334
> 
> ---
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>

Excellent! With the checkpatch issues fixed,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

