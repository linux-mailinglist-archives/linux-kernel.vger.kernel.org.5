Return-Path: <linux-kernel+bounces-46339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3444843E67
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488DCB25056
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E2745C8;
	Wed, 31 Jan 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="WWfl2WRX"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6A1E522
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700201; cv=none; b=VMuzrFgKRZpdqDz053OMVe8rurOLwLhRNK56xA7MVzkUaP29JZXysr9heGuZvWGyN80yU1eDeK/nh3rP+pX7fdrCC3Tz1y7DP+2S2uW56iaCZPNksDDNA+hn/gnw8xNVtOuk4OyoTmImewRDt1S+GiiYaHM4oT+RoCF+HBKKJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700201; c=relaxed/simple;
	bh=GcKJ/kjbOtj2Mx3eE/Tnn5S8OhL6znVcGMVgal8pvyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a334gmqmYktUWSV9DmGOl4l4uarGrB9DaNjmdI/A5doBORcjJSP+m/UUCH0KcUVDgZgC/F5uGaDmefEU6tcm5GT7Gv9xlQTiAtPWYfckJO3OpHZtPHD3DLV8hI0PXGUfx6IrD6YHSXDpSCS9Vnl+OmoJuDzuoxPF4hBTgs4ZSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=WWfl2WRX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4116647276.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706700197; x=1707304997; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/9gczpGohn5iLddoKsL7g1bBHEVL9hWJmIo2Zlfb0Ks=;
        b=WWfl2WRXzKikrKt5ChE2Za+KJy4xJ+RKcquTDYAAnvYP2TudmD1VA4qLvAR0yD6L8n
         1UTDJMZuwDvOVdM8bm0mCum30QQ71LpM23OUosFJRPnXkbj3x9uOxnTgIkpPyA/qbzg8
         OpE/8st5K8wuIpnqdlYJIm/4T0TGiPjjj/UBre2PiNzFkCyZ4VSBbYQlwruiSYpGwzbr
         AazaoMzeFRHlS6EtEnONVrAH6536ow5/jM3ywVPFFQ+p7mFZiQROaStE9dpD46OZbbBD
         wcbNQLWOZhMoY4c92TUnbdrI50xmmsCi635pawF0W8MDTf/zq3zJ+7S32Owla5okB29S
         F9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706700197; x=1707304997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9gczpGohn5iLddoKsL7g1bBHEVL9hWJmIo2Zlfb0Ks=;
        b=ZMawtKNKmduWnLoRSwFQqHf/AOWDrzR65b5V2f49nwLJmuIbMYRJX88qrZh1J/lMWK
         J4EGeZBvRb446aM1a8Ow/Q+SULKI7Op6wM2MtiMqWRJhcx1NILkDoYIG6mvOmjiNVkCC
         nQwnxydvrKaJhrdHpEbpKuF8Rpkhff94Q2ttNdjj5JGJBt97DNw7YcszGbB7EoqrqE5m
         my+65A7Q7zRX0FsUnvA2LtYVBOO8JyLvuq2rudGB4e70ZwIAx5KoTvdyKj7Txb3JrNmc
         N+nL5wAEGadEiz4SX39eHh9hdplDbrBhPNBFxzKaVxJ+h1/uQPeZQwq8RZPqR8SHgtoW
         zkvA==
X-Gm-Message-State: AOJu0YxsUWtASaesM9khEJN0/A6DK6RjAbjEc9NSDSs+1D5d24DbJ0iW
	j6OGAULoZXGyBUZQSfZqw3cC6ubdGcvG6YmKhvgu+HQnNbIT5S3mn2EBHVSU3/k=
X-Google-Smtp-Source: AGHT+IFoEmMZmzk/tLjXo242ICzlnsU+Iz+H2nujddO3b0fekdDXxr652s0wL9lHaH6YE6S03+38WQ==
X-Received: by 2002:a25:df8f:0:b0:db9:9134:bb28 with SMTP id w137-20020a25df8f000000b00db99134bb28mr1286024ybg.4.1706700196984;
        Wed, 31 Jan 2024 03:23:16 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a0e8300b00783148d1269sm2432128qkm.62.2024.01.31.03.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 03:23:16 -0800 (PST)
Date: Wed, 31 Jan 2024 06:23:11 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/20] mm: zswap: function ordering: pool refcounting
Message-ID: <20240131112311.GA1227330@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-12-hannes@cmpxchg.org>
 <CAKEwX=PN3vFZO1VkFVoRJGOnwgRdfuyOrFPA6DvfkM761o1B9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=PN3vFZO1VkFVoRJGOnwgRdfuyOrFPA6DvfkM761o1B9g@mail.gmail.com>

On Tue, Jan 30, 2024 at 12:13:30PM -0800, Nhat Pham wrote:
> On Mon, Jan 29, 2024 at 5:42 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Move pool refcounting functions into the pool section. First the
> > destroy functions, then the get and put which uses them.
> >
> > __zswap_pool_empty() has an upward reference to the global
> > zswap_pools, to sanity check it's not the currently active pool that's
> > being freed. That gets the forward decl for zswap_pool_cuyrrent().
> 
> nit: zswap_pool_cuyrrent() -> zswap_pool_current() :-)

Whoops, my bad.

Andrew, would you mind removing that typo inside your copy?

> Also, would it make sense to move zswap_pool_current() above
> __zswap_pool_empty() to get rid of the forward declaration? I guess
> it's now grouped with current_get() etc. - those don't seem to use the
> empty check, so maybe they can also go above __zswap_pool_empty()?

There is a grouping to these functions:

- low-level functions that create and destroy individual struct zswap_pool
  (create, destroy, get, release, empty, put)
- high-level functions that operate on pool collections, i.e. zswap_pools
  (current, last, find)

They were actually already grouped like that, just in the reverse
order. The only way to avoid ALL forward decls would be to interleave
the layers, but I think the grouping makes sense so I wanted to
preserve that. I went with low to high ordering, and forward decl the
odd one where a low-level function does one high-level sanity check.

Does that make sense?

