Return-Path: <linux-kernel+bounces-72845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC7285B95A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB493284AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB765190;
	Tue, 20 Feb 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGisgCWt"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905156351C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425793; cv=none; b=YE7RJk8jNY0JFCz7FlXou/0pGPtt+ymTt9ZXORBPvOUAPtheAXwhbzIFb0oCkjiW4JXoHsfQMc99xgY0Vxal/sz9A2wkaW/MjUhRrUPE37MlyxMYpBEUSZEXFkhF4o1VA+Prm8+NsVOjMItDvSKk60TU1p3uzS4yy/3tFdjuuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425793; c=relaxed/simple;
	bh=VkR0B/TOuKeGtTOK9qEC13UDMig/E9hScfb+cujwVY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUPyysi+5i7Rkw1DJ2gF1Z9tCepI+Zbm8GClXIoeiiJNBoTMgBGX7LDAYfCK+ucBA41X1AxQN+7JJRRcjnM2wBIHFZt4Eqh/n6uXlGDgQ289LU6k/qRlcZGbFQfjGEa4e1Gz6FOvdN42wXYCadMIsbAPwQPFHIhde3INiHNejhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KGisgCWt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e552eff09so197944566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708425789; x=1709030589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07TryGGvvDSKgfkSXszhhTVFd+qTH1nT47NESrZ5/Fs=;
        b=KGisgCWtKPD4vYHHGP40/vn4ZAkgP1qLYk2y23cbRAA6/l4pGNOWxpEQZcj63WIgzK
         IzNDf9VjFwT6PKS0O3nRzjUw9tOS8b2w4PBhkk+2wZSeHeiPf8+u1Bw87s3cGQGAhskb
         cH8xx0UkwuMziwU3qeLG5oNmYvzxwrhs12Fgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708425789; x=1709030589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07TryGGvvDSKgfkSXszhhTVFd+qTH1nT47NESrZ5/Fs=;
        b=vWKPtsv2ImiKitMB6zvSDoNiTmjnbo7NNDmsc+g7jmxecOTO5V6BFCBVbnUwc50kNO
         IHVMBjG8fMx3WppBUTjiWT+/lsXBoWIF4TMVk/sOTc6Qzent3YGwwVcVOrgeDMsDTD3b
         kRzM2rWY9okWNH8LNfaI+tS0qMioUaMsBFWirB6G7uYEn+rotHgrzFAgmx/0XSp2dSiS
         mw50eYm8xf4uE8aVdOh2DY8z2Vt/5JrBaVHZ+WnDwmjJ21aqV5VK5G2OF5w0zhMMRirn
         tKCVn9rQKYSkmNJi0Ly5jqSddFDA8YtYZMMxW5j173C74dGyYStTEkA2tGXAEtPImube
         RDvA==
X-Forwarded-Encrypted: i=1; AJvYcCUFMTULDqd0/4bg3l5GBY2chxYKVylGraFoPgCUtA7HV1j0WKFugdaZZ5UAJx4BA+XEOxipAF+C4MJD7rmBSpCiqClVVd0sGLxGzAfb
X-Gm-Message-State: AOJu0Yw9da/43NyiKzb+pmkMAyeZlnoemosfxAs5WR4mZQKw21T0Q5bI
	yVAvsEBsoCPqqPT6M+xpfl48Fr4PvZmnv+yTSyC/QEp4esgEdmnDUZSMa9+KgCXYlbo/8cm/3vM
	2TQ==
X-Google-Smtp-Source: AGHT+IEMXWY+OCuZ26bB5GG+xa32DjJY6LqfNkVbk9J4W32WolWb9JXMvazw5eLG06SLtdOiwCgg2g==
X-Received: by 2002:a17:906:fcc6:b0:a3e:36a9:f70d with SMTP id qx6-20020a170906fcc600b00a3e36a9f70dmr5117576ejb.38.1708425789334;
        Tue, 20 Feb 2024 02:43:09 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id p15-20020a170906140f00b00a3d2f55bc2esm3848884ejc.161.2024.02.20.02.43.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:43:08 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4127188dd5cso180165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:43:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3APQ5baMx/3d/iSKztRjZOS8DBijhhXpuTdfJBIrF93EWlIIgZFFzaOYC9B6376k600bjCcLjidCy5hq3HzxgXj4eC0gMx0PDg3ff
X-Received: by 2002:a05:6000:1e8f:b0:33d:2120:1011 with SMTP id
 dd15-20020a0560001e8f00b0033d21201011mr6506170wrb.54.1708425788061; Tue, 20
 Feb 2024 02:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220080628.13141-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20240220080628.13141-1-benjamin.gaignard@collabora.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 20 Feb 2024 19:42:47 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DR5z7xhXrnHc94FVY9Si9KWW2gYH+=Ov3yT1HMUpjhzg@mail.gmail.com>
Message-ID: <CAAFQd5DR5z7xhXrnHc94FVY9Si9KWW2gYH+=Ov3yT1HMUpjhzg@mail.gmail.com>
Subject: Re: [PATCH] media: usbtv: Remove useless locks in usbtv_video_free()
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:06=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> Remove locks calls in usbtv_video_free() because
> are useless and may led to a deadlock as reported here:
> https://syzkaller.appspot.com/x/bisect.txt?x=3D166dc872180000
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the num=
ber of queue stored buffers")
> ---
>  drivers/media/usb/usbtv/usbtv-video.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/us=
btv/usbtv-video.c
> index 62a583040cd4..96276358d116 100644
> --- a/drivers/media/usb/usbtv/usbtv-video.c
> +++ b/drivers/media/usb/usbtv/usbtv-video.c
> @@ -963,15 +963,9 @@ int usbtv_video_init(struct usbtv *usbtv)
>
>  void usbtv_video_free(struct usbtv *usbtv)
>  {
> -       mutex_lock(&usbtv->vb2q_lock);
> -       mutex_lock(&usbtv->v4l2_lock);
> -
>         usbtv_stop(usbtv);
>         vb2_video_unregister_device(&usbtv->vdev);
>         v4l2_device_disconnect(&usbtv->v4l2_dev);
>
> -       mutex_unlock(&usbtv->v4l2_lock);
> -       mutex_unlock(&usbtv->vb2q_lock);
> -
>         v4l2_device_put(&usbtv->v4l2_dev);
>  }
> --
> 2.40.1
>

From looking at the code in related vb2 functions and how the uvc
driver handles the cleanup, these locks shouldn't be necessary indeed,
but it would be good if someone could test this.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

