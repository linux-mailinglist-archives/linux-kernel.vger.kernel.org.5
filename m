Return-Path: <linux-kernel+bounces-75980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BA685F179
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0052C1F23550
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BEEFBF4;
	Thu, 22 Feb 2024 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOtKgL2q"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017C18046
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708583045; cv=none; b=fiR7IfR2RXzTvhbQyCwNdgasa03gc5fIFlsHhZnJWarvJZHay6ldqjEmBjmEqE4FsQ2yVkMEi3WrNGSGVn5t9CHSqWqmT8a+aDfGSk1gL/w+Uz7ooiD/tXQAk4bEIFhxofTu9XbRo7yL1NPHfU1drSOkYooRpVFQc9rMZfvIq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708583045; c=relaxed/simple;
	bh=ri4f+uV+Toa3UuYT6CTdh8+5f7xMDn6MuuNtTjFrq2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKuxIRFde0AQFRjYWhzE+Q7uzc9HdhhqFL6hsRSbI9t5GjpYsfnxKRexNNApp0/N87mfj5IFqxhRQtf/DJM2/y2nSfwvCbh4xaSwIVnU3oHaKE2Tr5nyS0Xe1Q5qs3LaQeYYLORFjRNR52Mx2C2DyUeh+AgeagvlpgHp43iJyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOtKgL2q; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c76e0c2086so87739839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708583035; x=1709187835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri4f+uV+Toa3UuYT6CTdh8+5f7xMDn6MuuNtTjFrq2c=;
        b=MOtKgL2qRuXwuJl5MSUIe3NjZyxsrKcy5BquYhGyxyiq33Xf5h5nfoUmSiPJHzaP4D
         2Eobdbt5V9+Uhgod4osjNjRyXpTO8IQZ0glZC8GT7RuyserPqggReI9EPKH8HZrblJys
         2u+PnhQPtjlvzte3G/2kH6Fxd0kl8nuH9XVC1drvHAUQOYXF956EyTScX4zRjpfeYd+k
         nGxZDRyj6WsZxG6jQ/riE5WrQcAzzT7bjRPBYeWhx6lPvdRHZ5AJ2eCqeCplkmeARRld
         UjmV/OsNxzXzijHiqopGc32cXClHKkgaJFAXoqVyVQVPPGVx63dG/7Tm7KexKGCv+Y37
         rnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708583035; x=1709187835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri4f+uV+Toa3UuYT6CTdh8+5f7xMDn6MuuNtTjFrq2c=;
        b=uyQ2k57ofPV14YKeHgc0Hdah3a3LQtjn02p7W4+t6aMu7+F4VEckzduDwdypzqANHh
         BHcC+7Zg2LtpS+Na/b8e4gyl1rd0W7gOhpETpw19TjQyWQybtdglt4E2k+Uij4D+lmmF
         4QeWt61COEnA7xjgsbZUOQ7DH2oNMZvGcMpTOCJHszo5dAh2o8Ty6CTW0gQJd2UfqYxl
         gbnKSs/ZbXUpShwvPGsPgatrbwvivb6jvi8+O0+ybxXTz8zm5xN0k31+ijebJfGLC/Ln
         NCJ4qHqtgsnmX3nWZzuUw9WnumIdt8/NDVlMPLQLXSjjLvCXWS+UYxfhRPrAEjc2IZhx
         1ysQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8QphhV4RefL4YthgBRd5R79jPMG2q+8pary1lTwBszWsVo71L2/ijbrxWFeJWJ7iHVIUK944/2BgxJ4y+46pT2ync3iRQHbTkz9xg
X-Gm-Message-State: AOJu0Yx3gBJj1VrA1iLjnNFt5PcC7/DRKIQlpCJSSn66gkODJHDhPEcj
	+TAMlkjNDiYR/ewqmCvffrmVKwR7/rrDANbNUEtbH96JNx3guQ7kIxIvLvBzERTD/C2M6HIf3hY
	6LyqrbxHfSbDX2xocdkBPSGnFBrs=
X-Google-Smtp-Source: AGHT+IFx6A+ZYKinukfXkiKrDWkPWs1ONeI0WZZ/VbxPqFeMwyQsl8NB1X68JpTnSemRLKt66Lql+o3oiL3xObhp2PI=
X-Received: by 2002:a05:6602:e46:b0:7c7:43f5:26a0 with SMTP id
 gq6-20020a0566020e4600b007c743f526a0mr13018369iob.1.1708583034853; Wed, 21
 Feb 2024 22:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
In-Reply-To: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 22 Feb 2024 13:23:43 +0700
Message-ID: <CAKEwX=MELnV5uzMg2sR0iLd9jiwe-Z9sTh1dhDRiescrDce5rA@mail.gmail.com>
Subject: Re: [RFC] Analyzing zpool allocators / Removing zbud and z3fold
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	Chris Down <chris@chrisdown.name>, Seth Jennings <sjenning@redhat.com>, 
	Dan Streetman <ddstreet@ieee.org>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 10:27=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> I did not perform any sophisticated analysis on these histograms, but
> eyeballing them makes it clear that all allocators have somewhat
> similar latencies. zbud is slightly better than zsmalloc, and z3fold
> is slightly worse than zsmalloc. This corresponds naturally to the
> build times in (a).
>
> (c) Maximum size of the zswap pool
>
> *** zsmalloc ***
> 1,137,659,904 bytes =3D ~1.13G
>
> *** zbud ***
> 1,535,741,952 bytes =3D ~1.5G
>
> *** z3fold ***
> 1,151,303,680 bytes =3D ~1.15G
>
> zbud consumes ~32.7% more memory, and z3fold consumes ~1.8% more
> memory. This makes sense because zbud only stores a maximum of two
> compressed pages on each order-0 page, regardless of the compression
> ratio, so it is bound to consume more memory.
>
> -------------------------------- </Results> -----------------------------=
---
>
> According to those results, it seems like zsmalloc is superior to
> z3fold in both efficiency and latency. Zbud has a small latency
> advantage, but that comes with a huge cost in terms of memory
> consumption. Moreover, most known users of zswap are currently using
> zsmalloc. Perhaps some folks are using zbud because it was the default
> allocator up until recently. The only known disadvantage of zsmalloc
> is the dependency on MMU.
>
> Based on that, I think it doesn't make sense to keep all 3 allocators
> going forward. I believe we should start with removing either zbud or
> z3fold, leaving only one allocator supporting MMU. Once zsmalloc
> supports !MMU (if possible), we can keep zsmalloc as the only
> allocator.
>
> Thoughts and feedback are highly appreciated. I tried to CC all the
> interested folks, but others feel free to chime in.

I already voiced my opinion on the other thread, but to reiterate, my
vote is towards deprecating/removing z3fold :)
Unless someone can present a convincing argument/use case/workload,
where z3fold outshines both zbud and zsmalloc, or at least is another
point on the Pareto front of (latency x memory saving).

