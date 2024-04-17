Return-Path: <linux-kernel+bounces-149078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 366028A8B89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C741F25481
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BF2BAF6;
	Wed, 17 Apr 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fXj8RIQO"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80909208CA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379724; cv=none; b=p6n9nMa6nGb5sXOs0lHDxG6j1PDeY12hNKC05TdQGIu8s7uFofvLqKJeusgJOGK4ugklRYz1itbkgUH40ecDJOj/T+FbRwI058AbsrwQ6LU0jOoL8a65PzCHijUnBq6827D67O+Dp95+pgcPJa3fZ43lqdUz9kWn7mOfev2XSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379724; c=relaxed/simple;
	bh=rutsOn/f39LcCOHC2CAWzop5cfLJktAPax9ROiVqARI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhuhbctKktEPD/6Tr7cNKhgqf1iZbnQ7QQqSTT/2lu7kTMPmbjuTo2X/csUZadcpD+2URrGGxz7FwhAx+PgKVicHjLvZzrSmym0lcS+CCMgg6nK13k/IF7Y4Tl8jpHoxs+uUtJNaKgga9UUE5Zr1YiLa0xdCKOP8oOUHT7XRwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fXj8RIQO; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-479d1454cb4so23008137.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713379721; x=1713984521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i3Ps7dtRF5OPrxcjL1/j+nNKltItcMv5lBmuac1kY1k=;
        b=fXj8RIQOM1/eQ3FKPRD6YIVhxJ/uFHAtGRsdo/GXZ9yFFPyJMMlFbR49N0B+T9CGWl
         UlqTqtOy3vnPVrB4cyXsrg7sJaU4KwJkzjOGjO5sJn8CjmTcOFTqBr7TGiCR1dxJ3yiw
         B0zcCB4mCg4qYq53E3aGLv1lrk6/FfrsySAzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379721; x=1713984521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3Ps7dtRF5OPrxcjL1/j+nNKltItcMv5lBmuac1kY1k=;
        b=ZZOGLQZGYuuToQwJJnMSuSOsLG/FMwP9rH8w1XVlHk17BcoJjXx9tPngFFxHS/FeJw
         qVzfLU4sTH+dHmMTZAmHW37OQsicJi3RXSSrQABK6tXYDNl6QW/ON2q8N4SrRELQnbFO
         HbG/P9fECADyw5zwFyX4L5kbHBVD4V/C7xaoji+6+EewiC7MMnkfNhRApQb194LXKTG4
         LUCdkTj0uR/2WiSx0bMqM8iDvadA++kzolB9zQVfDNoxoQl5JGwh8VMP+LSaVgrOrM0b
         bFPM/cdZJx8ay3puNae4jsQDL0NqyNuOr2VEvlGAxKyK7LbM5taYjgqCqEGVjIcxPN+k
         zBfA==
X-Forwarded-Encrypted: i=1; AJvYcCVjWw68ChuLIbNzBGZ4/sYRnYoHagHh3Xs2dM3YJIo0OyI114ddaJeFJHC5JYTKrxjQHUu4kD1kga8UNqjOPdoDlLMNXJx/mBmmBcrY
X-Gm-Message-State: AOJu0YySTc6A0QPPSPxOV5AvNv+xvbUHB3axBJK3YEOBH/MXMHoD2bcv
	/Y0YEq739n/LJ5VJhrJMijg8ixJw4AdOKOvWt58shZl57JDw2tAOoJ4SyRdEU+fcIWmHhsFD8HU
	MlQ==
X-Google-Smtp-Source: AGHT+IFBNSoki4/346EUrHgyC8G2qnZc4Zq4pCQ8s7YWobY6huU2DPyfxLY7xkDh931pXJ2n1tD6wA==
X-Received: by 2002:a05:6102:c02:b0:47a:22cd:9717 with SMTP id x2-20020a0561020c0200b0047a22cd9717mr480980vss.24.1713379720897;
        Wed, 17 Apr 2024 11:48:40 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id l25-20020ab07199000000b007e8485c3c93sm1432698uao.23.2024.04.17.11.48.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 11:48:40 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4daa8e14afbso1936181e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:48:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfFH5cwkfi6jqUY17A2Jac/CoWne24H9T9Dik6evEUDSPPOLTROtAYUlYjS8NxpWz6/1+82Kt5Sn8H1+R09QZcPDZjj8qpkDHi6vFb
X-Received: by 2002:a05:6122:252a:b0:4d8:75d1:f733 with SMTP id
 cl42-20020a056122252a00b004d875d1f733mr476748vkb.11.1713379719654; Wed, 17
 Apr 2024 11:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab56c444-418a-423d-8528-cf04d5d458ef@moroto.mountain>
In-Reply-To: <ab56c444-418a-423d-8528-cf04d5d458ef@moroto.mountain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 17 Apr 2024 20:48:23 +0200
X-Gmail-Original-Message-ID: <CANiDSCvGc2hv-6+THH28vE6uaTL+go7144hSYafkhp21uaM1Cg@mail.gmail.com>
Message-ID: <CANiDSCvGc2hv-6+THH28vE6uaTL+go7144hSYafkhp21uaM1Cg@mail.gmail.com>
Subject: Re: [PATCH] media: stk1160: fix some bounds checking in stk1160_copy_video()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <elezegarcia@gmail.com>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan

On Wed, 17 Apr 2024 at 19:51, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The subtract in this condition is reversed.  The ->length is the length
> of the buffer.  The ->bytesused is how many bytes we have copied thus
> far.  When the condition is reversed that means the result of the
> subtraction is always negative but since it's unsigned then the result
> is a very high positive value.  That means the overflow check is never
> true.
>
> Fixes: 9cb2173e6ea8 ("[media] media: Add stk1160 new driver (easycap replacement)")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This patch is untested, I just spotted it in review.
>
> When this bug is fixed, the two checks for negative values of "lencopy"
> could be removed.  I wrote a version of this patch which removed the
> checks, but in the end I decided to leave the checks.  They're harmless.
>
>  drivers/media/usb/stk1160/stk1160-video.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
> index 366f0e4a5dc0..bfb97ea352e7 100644
> --- a/drivers/media/usb/stk1160/stk1160-video.c
> +++ b/drivers/media/usb/stk1160/stk1160-video.c
> @@ -139,8 +139,8 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
>          * Check if we have enough space left in the buffer.
>          * In that case, we force loop exit after copy.
>          */
> -       if (lencopy > buf->bytesused - buf->length) {
> -               lencopy = buf->bytesused - buf->length;
> +       if (lencopy > buf->length - buf->bytesused) {
> +               lencopy = buf->length - buf->bytesused;
>                 remain = lencopy;
>         }

I think it is a bit more complicated than bytesused.

bytesused does not take into consideration the actual position where
it is going to write.

What we really want to check is if

offset = dst - buf->mem;
if (offset + lencopy > buf->length) {
  lencopy = buf->length - offset;
  remain = lencopy;
}

>
> @@ -182,8 +182,8 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
>                  * Check if we have enough space left in the buffer.
>                  * In that case, we force loop exit after copy.
>                  */
> -               if (lencopy > buf->bytesused - buf->length) {
> -                       lencopy = buf->bytesused - buf->length;
> +               if (lencopy > buf->length - buf->bytesused) {
> +                       lencopy = buf->length - buf->bytesused;
>                         remain = lencopy;
>                 }
>
> --
> 2.43.0
>


-- 
Ricardo Ribalda

