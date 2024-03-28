Return-Path: <linux-kernel+bounces-123791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40874890DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBD8B214A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCF535D2;
	Thu, 28 Mar 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjvVCqp+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B81D68F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666430; cv=none; b=OgA0yRkSPgq4KlVN/08iMq3m5n9WIaufQg68k1qpFExbebFUjm3HG2DIwbpHuPydlDPwbOLdbnz2djZvGIe/tdcCeR/9zaKs9s+SbH04hVWU0KBHyfP2dcbRPu8Ilx6kPRgPaDQs6qmyCS80O3Oz5u2LrFJFXs8+k2Z/vJWT1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666430; c=relaxed/simple;
	bh=m2sHr69UQ23/+yNNagVCVSd+tL9gNcumuplvgXMM3eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcE3oMa4k7mmxwPsEWrms06B/dmZEyIGknZ4ZmhlweLcH0zAo7rqWEoBq1Gp8GM5fsDl3uMc0sjb7Mc6kANHNgbTlSY04bhk+lgleZ9BICwZJXZXj0UDX1Npm05Z7Imi36BJXvKlWXVuve8hw3gaFAR1QVqVgMEaJ0mD3xQUbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjvVCqp+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so1954743a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711666428; x=1712271228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEbIDW7kbPaE87dBPORDU/rsnpNPLPoHlh1VVnWn9NA=;
        b=GjvVCqp+UrkJj/Q1BkHxcMX1d1B0WrYzJZU4b12Im5rjUMSk/I1e59Gl2QrWEdObM3
         WVc/EDOfGYTRdrVD47dbkVYM7MuIf37jur8eZgPmL+8hG7PgTYwfXzifmBWzk8lveWAu
         pL0hI0UrIrSW/nh8lmgfAbsXzygVZWxD4TtHdgZcC4pdTnUigPdjglq+uAMNxGA2jvri
         K6tZOk2oF/XSN3H5BV90vwHs0JQbplddepfes2CCS4QTGh07WMaBJrLApLTdwTjGhLPZ
         EGKKa3bVP2Cb8BAMFjmMMbQTMCoCKjcFvd0keKtBzIICixLNsRrR6gCAEJa8cbc6+Mid
         zDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711666428; x=1712271228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEbIDW7kbPaE87dBPORDU/rsnpNPLPoHlh1VVnWn9NA=;
        b=qwOmx3JPP+zFkjf9zKvx2mgkhGcSxaX5I1XWPzyHV7tJhcZdKiYSjp9AsN4d7DYMUN
         43+b19uuA9KyciYvxFZ8N8kIc4IHLdrW+8OT/1abOjL3IjPYw+/au6NAtYplVCh5GSk5
         P5MsD2qOl5lmu58LpIXfkcwbAnwvsR4fAKkOeTxzGehsrTdZreN9sU03wjjI/sYHjNqD
         Wjbzp9qz+6r0YNaCLSlXt5WeynYjLu87uFWBsCUMXgUbrs2RuZCqk9BQNsTEUcHSObzJ
         REVICIv+TXM4qr29QoZoCgoLi8R8qZwgcVfZP83yOddAppMdoNo+4kx5bF1zmEJQ1XrZ
         ZdBw==
X-Gm-Message-State: AOJu0Yz3rCNcRvdV756lhPXuxs73EKRN6eiof1ulN+Mg5wyEymDh745N
	dbHqx6G+9X2IefmNXzBjR79d0MilhCtXCeERrSUzDiU9L81DBs48Ois6SmgsUuml3VKqTCs0B4u
	53eg/rzqfGdCGyYVEFpCDd4f8xSV0lt0eB4oo
X-Google-Smtp-Source: AGHT+IHSOF7Jz1HlwWi9ZnZS4sDGFwM0sUVO6wKPz80s3bzKUakcomIa558eS7Mlmg+NfUj6hjAXDu38td4y54TNQ6s=
X-Received: by 2002:a05:6402:254a:b0:56b:e089:56ed with SMTP id
 l10-20020a056402254a00b0056be08956edmr540944edb.39.1711666427673; Thu, 28 Mar
 2024 15:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-3-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-3-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 15:53:35 -0700
Message-ID: <CAFhGd8rCzhqK18KLtLVLWyWHtQzJsHCkkkQQyLbmw83K6ExKkw@mail.gmail.com>
Subject: Re: [PATCH 2/9] libceph: avoid clang out-of-range warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Milind Changire <mchangir@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang-14 points out that on 64-bit architectures, a u32
> is never larger than constant based on SIZE_MAX:
>
> net/ceph/osdmap.c:1425:10: error: result of comparison of constant 461168=
6018427387891 with expression of type 'u32' (aka 'unsigned int') is always =
false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
>             ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ceph/osdmap.c:1608:10: error: result of comparison of constant 230584=
3009213693945 with expression of type 'u32' (aka 'unsigned int') is always =
false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
>             ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The code is correct anyway, so just shut up that warning.

OK.

>
> Fixes: 6f428df47dae ("libceph: pg_upmap[_items] infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  fs/ceph/snap.c    | 2 +-
>  net/ceph/osdmap.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index c65f2b202b2b..521507ea8260 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -374,7 +374,7 @@ static int build_snap_context(struct ceph_mds_client =
*mdsc,
>
>         /* alloc new snap context */
>         err =3D -ENOMEM;
> -       if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
> +       if ((size_t)num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
>                 goto fail;
>         snapc =3D ceph_create_snap_context(num, GFP_NOFS);
>         if (!snapc)
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 295098873861..8e7cb2fde6f1 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1438,7 +1438,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(voi=
d **p, void *end,
>         ceph_decode_32_safe(p, end, len, e_inval);
>         if (len =3D=3D 0 && incremental)
>                 return NULL;    /* new_pg_temp: [] to remove */
> -       if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
> +       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
>                 return ERR_PTR(-EINVAL);
>
>         ceph_decode_need(p, end, len * sizeof(u32), e_inval);
> @@ -1621,7 +1621,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_it=
ems(void **p, void *end,
>         u32 len, i;
>
>         ceph_decode_32_safe(p, end, len, e_inval);
> -       if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
> +       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
>                 return ERR_PTR(-EINVAL);
>
>         ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
> --
> 2.39.2
>

