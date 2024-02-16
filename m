Return-Path: <linux-kernel+bounces-69215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B68585D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC811F2457A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF1135A41;
	Fri, 16 Feb 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9yQ1R65"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120177F05
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109794; cv=none; b=iTkjomxTAyHVqQsuHAfSwmhW6l5kjhi2igN1l6GcIVqsNli78rIXRO4cLCfILCllTA5BUXXS6sYwZLpwgVSRT5d6AVI5klJWE6PmVA0VET2BFsJxIcOc3qHM8bHwfZByyRw591QKFioGbG+qvfzK0YEgaISO0CP4o99+M2Sdv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109794; c=relaxed/simple;
	bh=wRWbVWAEKVkxJsdndgxagEHlaVTNcRJCTLDdOqr5zAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CB5676+6aXk4+jjABCAvqpQnkcIDpEEcm0vf22CUvhw3RPRyOkLGbjo7OLxpPo/1bE7cNEsPwYvmuWUFHu+XkGelzWlP/O2KL1IxQPtyRZ9z43F263A+7J5XVeFL5fDSfC86OTnFlfQ6GgEWiRpZP2ZxvyBhhhuP9Dl28bND1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X9yQ1R65; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3cfacf0eadso275754166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708109791; x=1708714591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE/HFK8ZkQBK0NOQoyAka/SpFeDf9gV8qZ6Feq04yvY=;
        b=X9yQ1R65KEtLDpE4ChwspUaVcHBT3qc6QVDXTUqZ8F4lgxZozcCOWNrMs+qOHGjdtT
         QlXVlaqTxXVBJjiHkA0P9RoaksoIgB3j2Zsf5hfZmKXUl++aIvRta8ErbAzDzXf4NxsC
         Tja0McK5mHvEP0evKUDVgfaLXt/GTznU3PKRsIoQn/LLhndoOpL4itufuO389kgkdBuu
         Own+PZ2ps8uumfRLM9TJeTc5FGsvg4PX9zt5N4HecFsR6aZy/kzBwJfMdJa/JGgYBbw1
         V8wi6syWWx0X3tqfYV/iH7Bcbw0BEmmQR8PBZiFM9DL6mYDr/KqiiN+39SXVlIq2zhR3
         uvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109791; x=1708714591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE/HFK8ZkQBK0NOQoyAka/SpFeDf9gV8qZ6Feq04yvY=;
        b=uD65JirvwaSU7zRkKOP5po1uVex2nq9C3hguatSKCWJVtL7/y3QqTE/fd44btsHvIV
         xscdXONo/ch1cmZLkuIgBF4c9t35JXCk4+2ncXELCpNAa+PveZ9L/HPJs+0UoCWMQ7OO
         o2jLN5AUcOIJb2Kgc/jTXBhXmD1p8EyClMB4BEtfzSGqHAkx6scFHKh2JVknmFmONoAP
         94Gyo0GspB2v8+dOmk+bBbWw/Np8sCaU4GKQvPmPF7O6ByB4/NCKJqQOvrBa2qZkC8lZ
         NCAF09hpIz2OJ7sNii0u9ZnT8YGD1NbtJHEXPxVBb6hKiECTkBpfpq9ia9DYYPchq3/s
         Mf4g==
X-Forwarded-Encrypted: i=1; AJvYcCVed4M0f3PSIl35uV3A4oJhmn36MMcqV5W8Cc3npaBFFzc17vfztsTf076JmUUV5hnCw/xiXRCc3zUe1hrqfP5iZx+0d+1FWwfb6uuH
X-Gm-Message-State: AOJu0Yz3yMUAvVu9ZwVLZ6dfOk78n2WFjjLlGS7NoK7Ln5BsNbV2jq+r
	ZoFhnqzqc8MltQcUhJhAgGJ4NyJO7SwUAlMQPhe4v6e6seJGXJcRLewdLvPe6ESJsFhJxvFkEXG
	UJGoYcNDy7mbXWXjfAAwXBrGgKhzbg5cw3Tcp
X-Google-Smtp-Source: AGHT+IFp78DbQechB0DTN7tbQDGsBKYQ1Zyk8Gs2l+SlA4DTOzSIcgkQHJdlamOu2SKiEkm8ULNQuqRmXmt3YRpZigc=
X-Received: by 2002:a17:906:b09a:b0:a3b:e9d9:bf6a with SMTP id
 x26-20020a170906b09a00b00a3be9d9bf6amr4326843ejy.40.1708109791012; Fri, 16
 Feb 2024 10:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216163201.1901744-1-arnd@kernel.org>
In-Reply-To: <20240216163201.1901744-1-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 16 Feb 2024 10:56:18 -0800
Message-ID: <CAFhGd8qmR+EPVUDt0DVttxm3aBQpdL2i4XbFZ3_ko6Li=mVH3A@mail.gmail.com>
Subject: Re: [PATCH] media: dvb-frontends: avoid stack overflow warnings with clang
To: Arnd Bergmann <arnd@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 16, 2024 at 8:32=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A previous patch worked around a KASAN issue in stv0367, now a similar
> problem showed up with clang:
>
> drivers/media/dvb-frontends/stv0367.c:1222:12: error: stack frame size (3=
624) exceeds limit (2048) in 'stv0367ter_set_frontend' [-Werror,-Wframe-lar=
ger-than]
>  1214 | static int stv0367ter_set_frontend(struct dvb_frontend *fe)
>
> Rework the stv0367_writereg() function to be simpler and mark both
> register access functions as noinline_for_stack so the temporary
> i2c_msg structures do not get duplicated on the stack when KASAN_STACK
> is enabled.
>
> Fixes: 3cd890dbe2a4 ("media: dvb-frontends: fix i2c access helpers for KA=
SAN")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/dvb-frontends/stv0367.c | 34 +++++++--------------------
>  1 file changed, 8 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/media/dvb-frontends/stv0367.c b/drivers/media/dvb-fr=
ontends/stv0367.c
> index 48326434488c..72540ef4e5f8 100644
> --- a/drivers/media/dvb-frontends/stv0367.c
> +++ b/drivers/media/dvb-frontends/stv0367.c
> @@ -118,50 +118,32 @@ static const s32 stv0367cab_RF_LookUp2[RF_LOOKUP_TA=
BLE2_SIZE][RF_LOOKUP_TABLE2_S
>         }
>  };
>
> -static
> -int stv0367_writeregs(struct stv0367_state *state, u16 reg, u8 *data, in=
t len)
> +static noinline_for_stack
> +int stv0367_writereg(struct stv0367_state *state, u16 reg, u8 data)
>  {
> -       u8 buf[MAX_XFER_SIZE];
> +       u8 buf[3] =3D { MSB(reg), LSB(reg), data };
>         struct i2c_msg msg =3D {
>                 .addr =3D state->config->demod_address,
>                 .flags =3D 0,
>                 .buf =3D buf,
> -               .len =3D len + 2
> +               .len =3D 3,
>         };
>         int ret;
>
> -       if (2 + len > sizeof(buf)) {
> -               printk(KERN_WARNING
> -                      "%s: i2c wr reg=3D%04x: len=3D%d is too big!\n",
> -                      KBUILD_MODNAME, reg, len);
> -               return -EINVAL;
> -       }
> -
> -
> -       buf[0] =3D MSB(reg);
> -       buf[1] =3D LSB(reg);
> -       memcpy(buf + 2, data, len);

I'm curious why a copy was made at all.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> -
>         if (i2cdebug)
>                 printk(KERN_DEBUG "%s: [%02x] %02x: %02x\n", __func__,
> -                       state->config->demod_address, reg, buf[2]);
> +                       state->config->demod_address, reg, data);
>
>         ret =3D i2c_transfer(state->i2c, &msg, 1);
>         if (ret !=3D 1)
>                 printk(KERN_ERR "%s: i2c write error! ([%02x] %02x: %02x)=
\n",
> -                       __func__, state->config->demod_address, reg, buf[=
2]);
> +                       __func__, state->config->demod_address, reg, data=
);
>
>         return (ret !=3D 1) ? -EREMOTEIO : 0;
>  }
>
> -static int stv0367_writereg(struct stv0367_state *state, u16 reg, u8 dat=
a)
> -{
> -       u8 tmp =3D data; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=3D81=
715 */
> -
> -       return stv0367_writeregs(state, reg, &tmp, 1);
> -}
> -
> -static u8 stv0367_readreg(struct stv0367_state *state, u16 reg)
> +static noinline_for_stack
> +u8 stv0367_readreg(struct stv0367_state *state, u16 reg)
>  {
>         u8 b0[] =3D { 0, 0 };
>         u8 b1[] =3D { 0 };
> --
> 2.39.2
>

Thanks
Justin

