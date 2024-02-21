Return-Path: <linux-kernel+bounces-74584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8E85D660
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EA3284870
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2421C3FB0A;
	Wed, 21 Feb 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AU8fZkmF"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203E3F9C7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513342; cv=none; b=lQ07BnerLNiKEwGdG4ovGV6Pg8m63xqMeLNTZMTcLRbOI5HA0ZAZWLxvuSeLUQp4KNMT2EFrOwN/Qnc3nATBHTtzBhcVrtDrhGMZZgwY0yswhD1J1QcoykFa4HzwZ6R1rab61jcsIkDz7bw9HB1RkHJ02Ii6OTIW0mw8bea2AHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513342; c=relaxed/simple;
	bh=T+lgS8dmmkjjqjCx9CTn2BJK+j+Myq/vBnAxt8dGRL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKeuzpOGgRuDWYQE3pv+4V3nUbdKUYNV2I0JeQU7zt/kwTX7t7OKsCEmaAuM5tb3eFTnP+Hu5CbcUeNJ9GPJkvP3pWdkp5Ue4SXRx6isWFVI0YaCYDaEJW9aesHizQG6MMck16nttWKYz04Yz9bV24EM78ZPK7clsU0ZkUd/vmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AU8fZkmF; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3651c1e1022so15843675ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708513340; x=1709118140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj6plWk587aeTNhJ0vkYdN+O+gXvvYvjwMhID6PtyEo=;
        b=AU8fZkmF8YNotX1dA8KUhlSZi9+bOmpn+PsCaBvknIF3R/bb2vFZeQqYd59I3LtlPQ
         u7IvYjN85dioRUkkMrEJYlhFpRBKHGqwBvDmd9Mcqe7BD79AshKFPExwHK407ZJluqrD
         V9iDluns9vX8NyPc9S1Baolcoyry/jCcIlNmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513340; x=1709118140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj6plWk587aeTNhJ0vkYdN+O+gXvvYvjwMhID6PtyEo=;
        b=bJP2C6A4GrvCkwfZeQEL2Hn7dNT3sLpH49U6omhdWEoP/AbzbFH+1OWoBmIX0tgQBf
         +UycMjNz7pBFGrhwnQIZcRrKpSoYk7v7knHx0YFUMo56Sim1NhcUYaQrtt00GwxmvX9J
         z3qMv6DZW+V97FIo4Sx7fyRbiZ8v//yEX/9T1xNYpz2JKl62Aky/o4X5GA3+CISJhtOS
         TXT4+sfGxoU/cTZEg1TKNQnKe9FC2p1HTB4JKeQ4VcsyP/780NatkZPlLN0slEhaekFf
         +He80ixYIe9EVXB0MjWdCpxzLb7Wien+B2vkw8vccNm8wG579O6TpHRD+i8iqRvP+/GC
         Nkqw==
X-Forwarded-Encrypted: i=1; AJvYcCWumhRstK7K1qj9BrE9UgWR6uLu7sm5MDLtbsh6CX1kSUipLoR4SogBSvGCs0rdPVAfMMgvy3g7dX4TAmgWnBHVQK+xHRJjpbDhru7D
X-Gm-Message-State: AOJu0Yx4loQywZtJLmZgs3MfJOIvjQkAtGdi867PbxShpWHpcXg6a34c
	1+GYyP3bHXgRp9XM40x0aB0yf54acMM2At7G2sRZj1zMUZIMsIAApin1Re9Bw+xx5gcir3jKBxh
	pXmLGU/dM9mwiUkp/PVw5kKSGp2AcZNuwDvfW
X-Google-Smtp-Source: AGHT+IFRuetw5HHoAaykdxsWg1k/jdCPmgy1RRD0vtBNXNkGDwXav9XOh2vDYGqoq5JVOhvuSphvXWyMcI7Q5su/xZg=
X-Received: by 2002:a92:de48:0:b0:365:4b91:7cf9 with SMTP id
 e8-20020a92de48000000b003654b917cf9mr3286429ilr.26.1708513339714; Wed, 21 Feb
 2024 03:02:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221080441.190922-1-kuro.chung@ite.com.tw>
In-Reply-To: <20240221080441.190922-1-kuro.chung@ite.com.tw>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 21 Feb 2024 19:02:08 +0800
Message-ID: <CAEXTbpf-Kn8YH1KPq=CT2-0Uu3HSoaejW4c4SWAftKAUhNxy7w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: fix hibernate to resume no display issue
To: kuro <kuro.chung@ite.com.tw>
Cc: Allen Chen <allen.chen@ite.com.tw>, Kenneth Haung <kenneth.hung@ite.com.tw>, 
	Allen Chen <allen.chen@ite.corp-partner.google.com>, 
	Andrzej Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, 
	Robert Foss <robert.foss@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuro,

On Wed, Feb 21, 2024 at 3:53=E2=80=AFPM kuro <kuro.chung@ite.com.tw> wrote:
>
> From: kuro chung <kuro.chung@ite.com.tw>
>
> ITE added a FIFO reset bit for input video. When system power resume,
> the TTL input of it6505 may get some noise before video signal stable
> and the hardware function reset is required.
> But the input FIFO reset will also trigger error interrupts of output mod=
ule rising.
> Thus, it6505 have to wait a period can clear those expected error interru=
pts
> caused by manual hardware reset in one interrupt handler calling to avoid=
 interrupt looping.
>
> Signed-off-by: Allen Chen <allen.chen@ite.corp-partner.google.com>

IIUC you should also sign this off with your own account, and don't
include Allen if he is not involved in the patch development.corp
account here

>
> BUG=3DNone
> TEST=3DNone
Please remove these two lines for upstream review.
>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 53 ++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index b53da9bb65a16..86277968fab93 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1318,6 +1318,8 @@ static void it6505_video_reset(struct it6505 *it650=
5)
>         it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_VID_MUTE, EN_VID_M=
UTE);
>         it6505_set_bits(it6505, REG_INFOFRAME_CTRL, EN_VID_CTRL_PKT, 0x00=
);
>         it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESET)=
;
> +       it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x02);
> +       it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x00);
>         it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, RST_501_=
FIFO);
>         it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, 0x00);
>         it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, 0x00);
> @@ -2480,10 +2482,6 @@ static void it6505_irq_video_fifo_error(struct it6=
505 *it6505)
>         struct device *dev =3D &it6505->client->dev;
>
>         DRM_DEV_DEBUG_DRIVER(dev, "video fifo overflow interrupt");
> -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> -       flush_work(&it6505->link_works);
> -       it6505_stop_hdcp(it6505);
> -       it6505_video_reset(it6505);
>  }
>
>  static void it6505_irq_io_latch_fifo_overflow(struct it6505 *it6505)
> @@ -2491,10 +2489,6 @@ static void it6505_irq_io_latch_fifo_overflow(stru=
ct it6505 *it6505)
>         struct device *dev =3D &it6505->client->dev;
>
>         DRM_DEV_DEBUG_DRIVER(dev, "IO latch fifo overflow interrupt");
> -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> -       flush_work(&it6505->link_works);
> -       it6505_stop_hdcp(it6505);
> -       it6505_video_reset(it6505);
>  }

Do we need to keep these two functions if they do nothing other than loggin=
g?

>
>  static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
> @@ -2502,6 +2496,45 @@ static bool it6505_test_bit(unsigned int bit, cons=
t unsigned int *addr)
>         return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
>  }
>
> +static bool it6505_is_video_error_int(const int *int_status)
> +{
> +       if ((it6505_test_bit(BIT_INT_VID_FIFO_ERROR, (unsigned int *)int_=
status)) || (it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, (unsigned int *)int_=
status)))
> +               return 1;
> +       return 0;
> +}

Maybe just:
return it6505_test_bit(BIT_INT_VID_FIFO_ERROR, (unsigned int
*)int_status) || it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, (unsigned
int *)int_status)

> +
> +static void it6505_irq_video_error_handler(struct it6505 *it6505)
> +{
> +       struct device *dev =3D &it6505->client->dev;
> +       int int_status[3] =3D {0};
> +       int reg_0d;
> +
> +       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> +       flush_work(&it6505->link_works);
> +       it6505_stop_hdcp(it6505);
> +       it6505_video_reset(it6505);
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "Video Error reset wait video...");
> +

Can you add some code comments here to explain why we need to clear
the interrupt bits here?

> +       for (i =3D 0; i < 10; i++) {
> +               usleep_range(10000, 11000);
> +               int_status[2] =3D it6505_read(it6505, INT_STATUS_03);
> +               reg_0d =3D it6505_read(it6505, REG_SYSTEM_STS);
> +               it6505_write(it6505, INT_STATUS_03, int_status[2]);

If we clear all interrupts like this, won't we risk missing other
interrupts here? E.g., if an HPD interrupt is fired here, it will be
cleared without being handled.

> +
> +               DRM_DEV_DEBUG_DRIVER(dev, "reg08 =3D 0x%02x", int_status[=
2]);
> +               DRM_DEV_DEBUG_DRIVER(dev, "reg0D =3D 0x%02x", reg_0d);
> +
> +               if ((reg_0d & VIDEO_STB) && (reg_0d >=3D 0))
> +                       break;
> +
> +               if (it6505_is_video_error_int(int_status)) {
> +                       it6505_video_reset(it6505);
> +                       DRM_DEV_DEBUG_DRIVER(dev, "Video Error reset wait=
 video (%d)", i);
> +               }
> +       }
> +}

Why do we need a for-loop here, and why 10?

> +
>  static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
>  {
>         struct it6505 *it6505 =3D data;
> @@ -2522,7 +2555,7 @@ static irqreturn_t it6505_int_threaded_handler(int =
unused, void *data)
>                 { BIT_INT_VID_FIFO_ERROR, it6505_irq_video_fifo_error },
>                 { BIT_INT_IO_FIFO_OVERFLOW, it6505_irq_io_latch_fifo_over=
flow },
>         };
> -       int int_status[3], i;
> +       int int_status[3], i, reg_0d;
>
>         if (it6505->enable_drv_hold || !it6505->powered)
>                 return IRQ_HANDLED;
> @@ -2550,6 +2583,8 @@ static irqreturn_t it6505_int_threaded_handler(int =
unused, void *data)
>                         if (it6505_test_bit(irq_vec[i].bit, (unsigned int=
 *)int_status))
>                                 irq_vec[i].handler(it6505);
>                 }
> +               if (it6505_is_video_error_int(int_status))
> +                       it6505_irq_video_error_handler(it6505);
>         }
>
>         pm_runtime_put_sync(dev);
> --
> 2.25.1
>

Regards,
Pin-yen

