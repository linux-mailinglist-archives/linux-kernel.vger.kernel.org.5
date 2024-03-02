Return-Path: <linux-kernel+bounces-89380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3A86EF9C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D631F23841
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49302BAFF;
	Sat,  2 Mar 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heSkk9//"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505A2BAE0
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709368009; cv=none; b=pCp9wECqsWg8yiiuw5F0MD5XRaM+Wfy+C3YxBp3NaUrHVFo/8JUTlxpSNGqG9clfYE2xjgO5USbS7mGW8dwbT8iS4reFoyghrFYMqhrXI4In0WtJZef/KqGdxCtCWp87e/to7zdQdzDpHrSlofbE4CfO6HfXZ0UohB1K8IUiq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709368009; c=relaxed/simple;
	bh=4qiWT7px/XZ61aJzZ0nqVgLgmGGalrlbHU97QpvMhqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZeIQlZMR/dkMmmQfL6u2sWNLveP1TZqHNBJGukyCLGtt3zKKfmhAQ/lHVGRPx8MlaxDsvMvWxQ8Fot6bS6+maj2GQq211yIyJ9BZsTIMS08FMWGiX/YFS0btHPxXGU8A1B50xcmOfZ/iRZipUaCiczfw09WPabuypYdFPK5AYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heSkk9//; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7db1a2c1f96so332776241.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 00:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709368006; x=1709972806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCMoo3vztN3na2tFmCH4My0IcdECSTBM8qQWswwsWag=;
        b=heSkk9//pDjfv7GVfAf3o1XqkNjKgToClwAlz8dnYfxc2aS6lP8CbY0B3HZvaWuje5
         BDKllJGYpcttnxikpdPgo4kjjozdxMwzdgW04oml8Z36aV4KfYCJNzTIhO1MuSbuwlRW
         vntknIrUp6NTvzzX89997EQSako3e89J+v/2432X2MZ+OHEU4403I4s+YfRcd7SiP2nw
         ZyUw8J6r/Rr4i9mIlPAguLP8zJUb+TycwWqWg58Q6mFcSfj14jbjpb8B1nJ2YjxIJUGr
         FATGYZ3Dl6ZvNT8FjYQznqajwp+LQMcY7vqyaCjigtQJvYOs99J+Lsn9boGyNC6ErS/N
         QflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709368006; x=1709972806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCMoo3vztN3na2tFmCH4My0IcdECSTBM8qQWswwsWag=;
        b=T2oj2lXpJK/72o6kugcqB4A//1sWcKxFoBwEpKmDuhWEc+fr7aT7TmI7iot2vurxtx
         4+sP01XiEcSZj5nkxCBK0mk1rKy/UwdSKjrJs8K7GW8z4iHkR6O/jm+GQJRTxZdNA8E+
         563dTDqwnIWLpLHg3566S5ntHMGHYK/Ot85xnkCd/WPYG/4tpXLj1xu0wzjRnpFB6UqG
         G5S6IDme5QMfGJbw1WZ8cOj2lFJwQA9/qbq2nB2WYNIlPKCzuzO0Q3HW9oJ5Ywm0v2ZV
         IkCpXE+Do3cp9+oUCU83lLeuwIourmZF1an68S3SldEBHaxGFpc0kngaj7jY05HedgFw
         F7qg==
X-Forwarded-Encrypted: i=1; AJvYcCVdDl29QT2biW7ziMU2HJ15IRIDtW2BOHfMXDiu7n5UCkUqoMtwVgRdtcDnC7botY9Eo/XU2AZZJhaonDo72dUL5Y0+rwh1q3KrAWk9
X-Gm-Message-State: AOJu0YzZCbFI9vg7B7P3AitLmkd+QLxvOgPpZZkzfKvvTb64Md3MnNX9
	75wZP7ps6nry2I2/AYfyriD3rR9BpPKL3tiSEOd17VZv7AA1TQYNVPmFgYAOz7tAD5bnum6VR9u
	I/fXZRgxZxbp/xtR+lnQJnnCWJ6o=
X-Google-Smtp-Source: AGHT+IFqx0qgBmdSXOzrwh75qX4iDbV7BZR5YjTGsFCbKVpAiusLHNUf4MD2rYjnWbwFihmjN1BYW/gvMWrjGeY8kRs=
X-Received: by 2002:a05:6102:2a68:b0:472:aa04:7648 with SMTP id
 hp8-20020a0561022a6800b00472aa047648mr685795vsb.27.1709368006223; Sat, 02 Mar
 2024 00:26:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301230908.7507-1-21cnbao@gmail.com> <ZeKrx8g3DSHaVWhv@gondor.apana.org.au>
In-Reply-To: <ZeKrx8g3DSHaVWhv@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 2 Mar 2024 21:26:34 +1300
Message-ID: <CAGsJ_4y3xmja7RFd2OUP7V+_sJPj9fqfqDc4TMsie5JSyj2Kzg@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: call kmap on each page even for lowmem if
 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is enabled
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 5:32=E2=80=AFPM Herbert Xu <herbert@gondor.apana.org=
au> wrote:
>
> On Sat, Mar 02, 2024 at 12:09:08PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > copy_page_from_iter_atomic() has the assumption lowmem will only
> > need one kmap to get start page_address() for all pages. This is
> > wrong if the debug option CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is
> > enabled. This patch fixes it in the same way with skbuff.h by
> > always applying kmap one by one even for lowmem,
> >
> >  static inline bool skb_frag_must_loop(struct page *p)
> >  {
> >  #if defined(CONFIG_HIGHMEM)
> >       if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) || PageHighMem(=
p))
> >               return true;
> >  #endif
> >       return false;
> >  }
>
> Thanks for the patch.  Perhaps this could be moved into highmem.h
> as a helper (kmap_is_highmem)?

makes sense. OTOH,  is skb_frag_must_loop even correct as
DEBUG_KMAP_LOCAL_FORCE_MAP
is for non-highmem pages and on non-highmem systems.

config DEBUG_KMAP_LOCAL_FORCE_MAP
        bool "Enforce kmap_local temporary mappings"
        depends on DEBUG_KERNEL && ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
        select KMAP_LOCAL
        select DEBUG_KMAP_LOCAL
        help
          This option enforces temporary mappings through the kmap_local
          mechanism for non-highmem pages and on non-highmem systems.
          Disable this for production systems!

And highmem.c also shows it doesn't depend on CONFIG_HIGHMEM at all,

void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
{
        void *kmap;
        /*
         * To broaden the usage of the actual kmap_local() machinery always=
 map
         * pages when debugging is enabled and the architecture has no prob=
lems
         * with alias mappings.
         */
        if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) &&
!PageHighMem(page))
                return page_address(page);
        ...
}
EXPORT_SYMBOL(__kmap_local_page_prot);


but skb_frag_must_loop is checking it under if defined(CONFIG_HIGHMEM).
so I guess it is wrong too. Never has a bug been reported.  Probably that i=
s
because nobody is really using CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP,
I guess :-)

I think the correct skb_frag_must_loop() should be

static inline bool skb_frag_must_loop(struct page *p)
{
       return IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) || PageHighMem(=
p);
}

Thus, kmap_is_highmem() can entirely replace it :-)

> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks
Barry

