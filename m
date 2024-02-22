Return-Path: <linux-kernel+bounces-75988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6B85F19B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D2B1F2091B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE0B17BA2;
	Thu, 22 Feb 2024 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VVry7q3B"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3BF179BF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584383; cv=none; b=Sy3l5KvINOx0giavMAVr8NHmDL03ZBC8AgP5/5LvnKGd5zEb2KhkjennI29sLQi1uS/pACdYPPlagqMvu/1wFGaBa8Pilqg22N7NUzJWxfgEz0mjDcRe4QRK5+eYLu7zZSrEIVHlgwCMic0pqOB3pT/fuI+7o9pilP9ViLHFDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584383; c=relaxed/simple;
	bh=fTjcatIr5q46GfmEME9qLn7IjyjNb5otrsTdlLO4XgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8NB5KuSL1IsX/vFAOjaUCoRGKZpXpZW8BRxra6yGtFgBpPF6aXOlymgZskbPAkaebPK35SAItlm1BEJljIAfNP71WLRgb+OoMhce8ANfuaFdp3w1PlPqedGashrxyjm/Ctc0+Af8+BFbLvI6uYb+2FXOeac8Qd0ZouZuVuOb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VVry7q3B; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512bde3d197so4155755e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708584379; x=1709189179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cSyGKG6RJTtrUN3YM2qk3bT/yMnWF63aXnhhLxjivo=;
        b=VVry7q3BTv4MgcV/s3d8uYwBw8PjoTuoq9l7XTPMjVf3mCXjswG8G02B4QzOnlz+qz
         dFZ1wDNHbAC6ilRcZfIdNwB72s5FBr9In+C/vl4pTkgkvxcYjHbjzcLODZG41nARKB6g
         gvE1+Xapeiwyd0kTWzm+UBxEwpUYE2ssh+c4WqHiioMINda4JDhdGRxXero2wsktQtgG
         JpACvugVnTzQxBM3uaSfbpxpz+resM6MHYqvCi8VK8+wBXQd/b30ylHfB2Hyg8gm7TL0
         W/MeR50bNezd7wMN0GEA1zheE7hZwkEkqtvUj7cnwdWMw5cx0AAFI3yEXZ2U+lAbNA30
         l+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708584379; x=1709189179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cSyGKG6RJTtrUN3YM2qk3bT/yMnWF63aXnhhLxjivo=;
        b=gfSfTwnTaoCraAjylxRkELsPVRNCS5cr3XkQyRAub0Jo8tq5y6eaMgZGYuW6IiBP/e
         2NcyDDpVgSGybWO7I7QSwfLerA7wWaymgceJhiOdqLtx2vkN4LJj4Yy8sRpRKQB0HYYS
         0NdrU9dA851DLZHtDqU7wPelnSber+q5B0Jvrr2ezsdmLbPwCc8oVdry8Y4L/CTLV0mu
         A8Ra3c4YEsF6CBLp4Nj+DQ/3b3VcWCfX+nBwccDisxHfb8+AMTP2mtaDs87meVlStEO/
         RyeQmHg8ayC/O0f3gh7UWVYPdijXiY0rPd/sEDzLKOE/6uZE3Ywk3ofZu0PXO2+mi30p
         PiAw==
X-Forwarded-Encrypted: i=1; AJvYcCWe8HBU+ebcLLH61HMhU7k1UI/Rshp3krMM7YfawZreoHygdc7gGFE/MQH2hnQG4dWKuPHOsz/2ysb+NxJVCjna36P1dg1oVX0Rd1Q+
X-Gm-Message-State: AOJu0YxVKDj9kBfWPWV347ApDNz70HzquWKEcHdyLC3EoeUInH4wDPkh
	UaZSi7p1CgUcwhm5hdceRRYFYq8zh2jtP9H5eyAt1KwEJ5VPwh+5xwMJqFPowwZFgzT8OE4ychS
	WyZeMUaujRLaW93QKSa3WhtDNP3ZoxQxRNQKJoA==
X-Google-Smtp-Source: AGHT+IFCazBVkU5oQbjM3Ki6AJPYszSsGcPNPfqmeQOdrLMxPk6jIMY5qCqWqmBJrkuyccOjhwc+4Chyu0I5OnWCdq4=
X-Received: by 2002:a05:6512:3d01:b0:512:daac:d9bc with SMTP id
 d1-20020a0565123d0100b00512daacd9bcmr917855lfv.15.1708584378934; Wed, 21 Feb
 2024 22:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
In-Reply-To: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 22 Feb 2024 14:46:07 +0800
Message-ID: <CACSyD1PW+L+GhGxbio=ARiNFzNFfi2kMVgGjbE1uCmQAf7d8aw@mail.gmail.com>
Subject: Re: [External] [RFC] Analyzing zpool allocators / Removing zbud and z3fold
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Linux-MM <linux-mm@kvack.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	Chris Down <chris@chrisdown.name>, Seth Jennings <sjenning@redhat.com>, 
	Dan Streetman <ddstreet@ieee.org>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Hey folks,
>
> This is a follow up on my previously sent RFC patch to deprecate
> z3fold [1]. This is an RFC without code, I thought I could get some
> discussion going before writing (or rather deleting) more code. I went
> back to do some analysis on the 3 zpool allocators: zbud, zsmalloc,
> and z3fold.
>
> [1]https://lore.kernel.org/linux-mm/20240112193103.3798287-1-yosryahmed@g=
oogle.com/
>
> In this analysis, for each of the allocators I ran a kernel build test
> on tmpfs in a limit cgroup 5 times and captured:
> (a) The build times.
> (b) zswap_load() and zswap_store() latencies using bpftrace.
> (c) The maximum size of the zswap pool from /proc/meminfo::Zswapped.
>
> Here are the results I have. I am using zsmalloc as the base for all
> comparisons.
>
> -------------------------------- <Results> ------------------------------=
--
>
> (a) Build times
>
> *** zsmalloc ***
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>  LABEL   =E2=94=82 MIN      =E2=94=82 MAX      =E2=94=82 MEAN     =E2=94=
=82 MEDIAN   =E2=94=82 STDDEV
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>  real    =E2=94=82 108.890  =E2=94=82 116.160  =E2=94=82 111.304  =E2=94=
=82 110.310  =E2=94=82 2.719
>  sys     =E2=94=82 6838.860 =E2=94=82 7137.830 =E2=94=82 6936.414 =E2=94=
=82 6862.160 =E2=94=82 114.860
>  user    =E2=94=82 2838.270 =E2=94=82 2859.050 =E2=94=82 2850.116 =E2=94=
=82 2852.590 =E2=94=82 7.388
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>
> *** zbud ***
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>  LABEL   =E2=94=82 MIN      =E2=94=82 MAX      =E2=94=82 MEAN     =E2=94=
=82 MEDIAN   =E2=94=82 STDDEV
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>  real    =E2=94=82 105.540  =E2=94=82 114.430  =E2=94=82 108.738  =E2=94=
=82 108.140  =E2=94=82 3.027
>  sys     =E2=94=82 6553.680 =E2=94=82 6794.330 =E2=94=82 6688.184 =E2=94=
=82 6661.840 =E2=94=82 86.471
>  user    =E2=94=82 2836.390 =E2=94=82 2847.850 =E2=94=82 2842.952 =E2=94=
=82 2843.450 =E2=94=82 3.721
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>
> *** z3fold ***
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>  LABEL   =E2=94=82 MIN      =E2=94=82 MAX      =E2=94=82 MEAN     =E2=94=
=82 MEDIAN   =E2=94=82 STDDEV
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>  real    =E2=94=82 113.020  =E2=94=82 118.110  =E2=94=82 114.642  =E2=94=
=82 114.010  =E2=94=82 1.803
>  sys     =E2=94=82 7168.860 =E2=94=82 7284.900 =E2=94=82 7243.930 =E2=94=
=82 7265.290 =E2=94=82 42.254
>  user    =E2=94=82 2865.630 =E2=94=82 2869.840 =E2=94=82 2868.208 =E2=94=
=82 2868.710 =E2=94=82 1.625
> =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>
> Comparing the means, zbud is 2.3% faster, and z3fold is 3% slower.
>
> (b) zswap_load() and zswap_store() latencies
>
> *** zsmalloc ***
>
> @load_ns:
> [128, 256)           377 |                                               =
     |
> [256, 512)           772 |                                               =
     |
> [512, 1K)            923 |                                               =
     |
> [1K, 2K)           22141 |                                               =
     |
> [2K, 4K)           88297 |                                               =
     |
> [4K, 8K)         1685833 |@@@@@                                          =
     |
> [8K, 16K)       17087712 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [16K, 32K)      10875077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@              =
     |
> [32K, 64K)        777656 |@@                                             =
     |
> [64K, 128K)       127239 |                                               =
     |
> [128K, 256K)       50301 |                                               =
     |
> [256K, 512K)        1669 |                                               =
     |
> [512K, 1M)            37 |                                               =
     |
> [1M, 2M)               3 |                                               =
     |
>
> @store_ns:
> [512, 1K)            279 |                                               =
     |
> [1K, 2K)           15969 |                                               =
     |
> [2K, 4K)          193446 |                                               =
     |
> [4K, 8K)          823283 |                                               =
     |
> [8K, 16K)       14209844 |@@@@@@@@@@@                                    =
     |
> [16K, 32K)      62040863 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [32K, 64K)       9737713 |@@@@@@@@                                       =
     |
> [64K, 128K)      1278302 |@                                              =
     |
> [128K, 256K)      487285 |                                               =
     |
> [256K, 512K)        4406 |                                               =
     |
> [512K, 1M)           117 |                                               =
     |
> [1M, 2M)              24 |                                               =
     |
>
> *** zbud ***
>
> @load_ns:
> [128, 256)           452 |                                               =
     |
> [256, 512)           834 |                                               =
     |
> [512, 1K)            998 |                                               =
     |
> [1K, 2K)           22708 |                                               =
     |
> [2K, 4K)          171247 |                                               =
     |
> [4K, 8K)         2853227 |@@@@@@@@                                       =
     |
> [8K, 16K)       17727445 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [16K, 32K)       9523050 |@@@@@@@@@@@@@@@@@@@@@@@@@@@                    =
     |
> [32K, 64K)        752423 |@@                                             =
     |
> [64K, 128K)       135560 |                                               =
     |
> [128K, 256K)       52360 |                                               =
     |
> [256K, 512K)        4071 |                                               =
     |
> [512K, 1M)            57 |                                               =
     |
>
> @store_ns:
> [512, 1K)            518 |                                               =
     |
> [1K, 2K)           13337 |                                               =
     |
> [2K, 4K)          193043 |                                               =
     |
> [4K, 8K)          846118 |                                               =
     |
> [8K, 16K)       15240682 |@@@@@@@@@@@@@                                  =
     |
> [16K, 32K)      60945786 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [32K, 64K)      10230719 |@@@@@@@@                                       =
     |
> [64K, 128K)      1612647 |@                                              =
     |
> [128K, 256K)      498344 |                                               =
     |
> [256K, 512K)        8550 |                                               =
     |
> [512K, 1M)           199 |                                               =
     |
> [1M, 2M)               1 |                                               =
     |
>
> *** z3fold ***
>
> @load_ns:
> [128, 256)           344 |                                               =
     |
> [256, 512)           999 |                                               =
     |
> [512, 1K)            859 |                                               =
     |
> [1K, 2K)           21069 |                                               =
     |
> [2K, 4K)           53704 |                                               =
     |
> [4K, 8K)         1351571 |@@@@                                           =
     |
> [8K, 16K)       14142680 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [16K, 32K)      11788684 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    =
     |
> [32K, 64K)       1133377 |@@@@                                           =
     |
> [64K, 128K)       121670 |                                               =
     |
> [128K, 256K)       68663 |                                               =
     |
> [256K, 512K)         120 |                                               =
     |
> [512K, 1M)            21 |                                               =
     |
>
> [512, 1K)            257 |                                               =
     |
> [1K, 2K)           10162 |                                               =
     |
> [2K, 4K)          149599 |                                               =
     |
> [4K, 8K)          648121 |                                               =
     |
> [8K, 16K)        9115497 |@@@@@@@@                                       =
     |
> [16K, 32K)      56467456 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [32K, 64K)      16235236 |@@@@@@@@@@@@@@                                 =
     |
> [64K, 128K)      1397437 |@                                              =
     |
> [128K, 256K)      705916 |                                               =
     |
> [256K, 512K)        3087 |                                               =
     |
> [512K, 1M)            62 |                                               =
     |
> [1M, 2M)               1 |                                               =
     |
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

Hi Yosry, that sounds greate to me.

I was reviewing the code for allocators recently and couldn't find the
advantages of z3fold even without doing performance testing.

It would be better if there was only one allocator which would simplify
the code and interface.

>
> Thoughts and feedback are highly appreciated. I tried to CC all the
> interested folks, but others feel free to chime in.
>

