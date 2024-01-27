Return-Path: <linux-kernel+bounces-41220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8107F83ED93
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22638B220DF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2921288AE;
	Sat, 27 Jan 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNBTqiRI"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B22563F;
	Sat, 27 Jan 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366524; cv=none; b=pTU7GJV4oRZbsOOwVd+7nIwM5nI4E1Y7dnKDvM7PHFHDLHh3U5XISY086/uaGXAMuWBwCh3E+oPv5Q/pIDE+Jtznyt5hRjNnj1MOpMiRQDPrxy1KimeriSz9blATf0DwydXRH+fer5FtQDc8sWs4zOCijKzKq/hUI1FBpUl/WgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366524; c=relaxed/simple;
	bh=HfL90naAADy81JPcs0YM+zkTGDajDG/W+LK5c+48bpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFkVyUfQ5iOeSlQHVjrPpdd1JP4Mm+HTvm+lHK5cgVKB66KlmyJ3tMvdGzhC+MgaCpWtGyCXIAvf/VTf4C1noGocmtezM1rYLy4YXIqu3gvRCCVLMvcLNWJxmYRFtwrcrHiHBGpuSDK75HPsqyYj9PTpm/rEAXddplbpW8UjeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNBTqiRI; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so592182241.1;
        Sat, 27 Jan 2024 06:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706366521; x=1706971321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=796hVN76xRHFliSsyjmiY1NL2iC0ZjTvhLKEWPuIZ2Q=;
        b=DNBTqiRILKXMWe+XK2xbV09dnc7VyshHhGMkUiexrsAfU8ZuJG5099hwT0V1HzmtDH
         QxX2YAy2FHcNF9gm7pYHlkHGZUT1iSDS2Ojyiy4KsITMvWFMOjKgHUli1ZD5qtv9jB/2
         ps1i4LcXjwCIEarvThfyuXgHNHZqd1JaVPETDJhWNa0ANEaKei6vB8n0bi0QFQIP8sNR
         Mij6l9+ab9VbNSZ5M4PD6wI+yNg06w3OQo5KrZKgL+V3vEf/cpR/jAgdtG2bZF4wt36V
         0X5R3KQD0VKNjY1bgkj3nZXP2KQrEU1piIYNSo8AEtJEcFj0N6DFJvT19Qbn/PENJhYX
         eDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706366521; x=1706971321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=796hVN76xRHFliSsyjmiY1NL2iC0ZjTvhLKEWPuIZ2Q=;
        b=dZpXQgqCaXZG94/FK0SonGqvBIYLQL3JEoknhz63REUIaoajZ8tqbkmx1qT+CsHZoU
         22ERZWBsLG7yTNThUZ6abNlBJxE0ciAtDeWuB2Cu+o2DseZMS/9MLme274Rg1GnYl2+X
         yCnBuzNXCYS9xEBskKuTo3cHcPSTQOB6tg51xT1xnGw2rVfmXJGZ1anQemam2uL+yHnu
         t9vqDkJ1u+4yaeede1kPQSJ5hUta2SyVq5EzEu+Tq6eCM+h7Fmjd3r520FHm3SPxYLRw
         UEkxo9bHYNYdnpv8B/8uDA3aZBY3+JIsZowc9r+KE72BVJhNFgBDFHiYgMuhJJxfMmqU
         l3cA==
X-Gm-Message-State: AOJu0YynTvW5Q8lPK2LV6TI2bahQ9NPbypapbSxhjNLjxX1I5l/R1LpA
	ZASd6UMn8MXFeokMqBjEPkkxjRbK+XgzSZx1j1Oh9MJzPG/LMm6QQ2CjNnP+eDEW9jxb9mWCGtv
	vZZgPyTgQhKF9awAYaiVqgKxJOTA=
X-Google-Smtp-Source: AGHT+IEB+ia/+5CqOs/g5/EYRaYUXNHhUMKokIZjZOjq8CyacCxUf3T3x6Q2xKgPwAYYecgl7t5Ft6+APw+3Sa88kEs=
X-Received: by 2002:a05:6102:37c:b0:469:a26c:cd40 with SMTP id
 f28-20020a056102037c00b00469a26ccd40mr550545vsa.71.1706366521356; Sat, 27 Jan
 2024 06:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZY1EnEefZsRTGYnP@gondor.apana.org.au> <20240103025759.523120-1-21cnbao@gmail.com>
 <20240103025759.523120-3-21cnbao@gmail.com> <ZbIsuN+bpHNX7CnL@gondor.apana.org.au>
In-Reply-To: <ZbIsuN+bpHNX7CnL@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 27 Jan 2024 22:41:49 +0800
Message-ID: <CAGsJ_4xcvYC_q-H+VrKwU-bOGm88Y+8LftgRXnuYvMm26OOf8Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] mm/zswap: reuse dstmem when decompress
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, akpm@linux-foundation.org, chriscli@google.com, 
	chrisl@kernel.org, ddstreet@ieee.org, hannes@cmpxchg.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, sjenning@redhat.com, vitaly.wool@konsulko.com, 
	yosryahmed@google.com, zhouchengming@bytedance.com, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:41=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Wed, Jan 03, 2024 at 03:57:59PM +1300, Barry Song wrote:
> >
> > > We could certainly do that.  But I wonder if it might actually be
> > > better for you to allocate a second sync-only algorithm for such
> > > cases.  I'd like to see some real numbers.
> >
> > some hardware might want to use an accelerator to help offload CPU's
> > work. their drivers are working in async mode, for example, hisilicon
> > and intel.
> >
> > I don't have the exact number we can save by removing the redundant
> > memcpy, nor do i have a proper hardware to test and get the number.
> > As Chengming is actually working in zswap, i wonder if you can test
> > my patches and post some data?
>
> I don't have the hardware to test this.  Since you're proposing
> the change, please test it to ensure that we're not adding cruft
> to the API that's actually detrimental to performance.

Understood.
sorry for the grammatical errors, i was actually asking for
chengming's help for testing as
he had hardware and was actively working on optimizing  zswap.
and he has already tested and sent the performance data which I quoted
in the formal
patchset.

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Thanks
Barry

