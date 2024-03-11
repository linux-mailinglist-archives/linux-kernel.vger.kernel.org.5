Return-Path: <linux-kernel+bounces-99321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F61878689
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE65BB2122C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65A151C58;
	Mon, 11 Mar 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBe8EM3M"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929A4D9E8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179059; cv=none; b=hsQv4MQJM7M9lfvyKBtCTUQq5fz70wvi7R8AvAezHqbtsUZQaXl4mC+MCsMQvzTnoiiIplNX90lfZ2Ig2CnOuMVigLEU9RnvORBWZfnzvGTJPP7Hm71AhFO3PS2/KM9/103+LGeoiMdvWZgaOzFE0Bt/Ti9+wyZfE7l8SPbfOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179059; c=relaxed/simple;
	bh=dVABVYkEnzvrtDxSt88BcX8bbJ/2fnXzw4JV5D5ODLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDorW4rhZT2T3JskocFzxL0gtQ8AYCf/b+hAasV4zn6OA5Z+iTqp97ZuuLpdw6NTtOFUtmqeXwZRO7PoYapiO5hp24DrGkKmKw/7kEOD8L/nIQv1TJnT2n5jfIQxKPQ6Zl3s7U5oiPblaYeGpNuNr1VbUJy4eygeFd1zWgfQS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBe8EM3M; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so1070a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710179056; x=1710783856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6njN+Ix5AAlz5r+8JT2vb+hUlGcvA64q3xEcgqXOsgU=;
        b=DBe8EM3M+uOHgw1nuC7hfGZRI7t6tM5y4+3JzHaot8whTg7ABkkVNrtoJsGlLD9GX1
         ZhtYJEh8+STsA2Os6ZcBeQG9iLBswZ11efZMMgXf3Z/xwfJapbhH3akH295fcqiu9CJe
         k/JreTCCozDDZbXeZ70lNAl4cQOFc4m44g210OVCLwv9GB0VvnTE3txTesLOZQOklO0H
         x5euopO2KIuD6fUvmeN0eBifPvsC87zDNBl177DBtrnOu66HVP7jIEZaIuLAas2C+pj5
         xo1VIftcS1OsuRt3WSuqK6T7lHRpvn26FmMn3WkJigIY4wwFPnF/MhhSVEgoxuIQznkK
         Weqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179056; x=1710783856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6njN+Ix5AAlz5r+8JT2vb+hUlGcvA64q3xEcgqXOsgU=;
        b=QUXzZ0kl5M7I+ohlRZSjagF37p3i4outNth8TCAZ7mMp5Gw6NMLl/mrhGMBbE6xnIl
         aJxzoXvXHWNCCDX5ubIxAllfKge/MFKApiLNc4dzgMBcpq8/BwHxf9FOW492HCRJpEnw
         DSbfAJHOUizYt0YXJ0Of8HU8sabQF5KpgkFmpHjzqqd5HpmJSPvX6TTaCv4ByKlf0irl
         CS2tqEWURSy415dwGFeUm8HaFeTTL84hwXV2d/Ls7F7KSSb7E16PZQy6JomIRVRSyQUZ
         8iE1+G8Ga7hByesgji6JBkVnTorEFklDzMXDLlxUzre4PVjBStztmhpQe3HgzCL8criW
         mz6w==
X-Forwarded-Encrypted: i=1; AJvYcCUd/sOdCk710Ra6CJjkAX6um/ai/YkgR/kVgka/WNwLsFYKA2GKALtmyGwMFfKdjRMt/RJWL3vsj/ZnXXXAoiTpFeb/TTSpMz58vKTY
X-Gm-Message-State: AOJu0YwjRmuC12CUTbWC1iBnZKnxhM0BbOXu7Wz1h+nmbRqnh35/DnuI
	3xAdpWhRsaG7k8s9Ah97TNynVkHAJAcTMa+pFUHd2lrx6R21uxwdrGFn5LtEsFLSE1wfs6qGH2F
	4+F1TwoT1gzHyDG82JzYxoGh1xOksaywUGJXCRXkrQ9XV0Rpc6w==
X-Google-Smtp-Source: AGHT+IEiyXoLtl8FGPR0QpQwioDmfpwtMlSqt/TB1uax5qtbflKwpR9qoDDE3tJQLCaR9qvo9iItIuvqoZmyCSDKVLQ=
X-Received: by 2002:aa7:d891:0:b0:568:569f:be4c with SMTP id
 u17-20020aa7d891000000b00568569fbe4cmr193644edq.3.1710179053955; Mon, 11 Mar
 2024 10:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306111157.29327-1-petr@tesarici.cz> <20240311182516.1e2eebd8@meshulam.tesarici.cz>
In-Reply-To: <20240311182516.1e2eebd8@meshulam.tesarici.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Mar 2024 18:43:59 +0100
Message-ID: <CANn89iKQpSaF5KG5=dT_o=WBeZtCiLcN768eUdYvUew-dLbKaA@mail.gmail.com>
Subject: Re: [PATCH 1/1] u64_stats: fix u64_stats_init() for lockdep when used
 repeatedly in one file
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 6:25=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesari=
ci.cz> wrote:
>
> On Wed,  6 Mar 2024 12:11:57 +0100
> Petr Tesarik <petr@tesarici.cz> wrote:
>
> > Fix bogus lockdep warnings if multiple u64_stats_sync variables are
> > initialized in the same file.
> >
> > With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
> >
> >       static struct lock_class_key __key;
> >
> > Since u64_stats_init() is a function (albeit an inline one), all calls
> > within the same file end up using the same instance, effectively treati=
ng
> > them all as a single lock-class.
>
> What happens with this fix now?
>
> IIUC it should be reviewed by Eric, but I don't know through which tree
> it should be merged. Any plans yet?

I thought I gave a reply, but apparently not .

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

