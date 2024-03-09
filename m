Return-Path: <linux-kernel+bounces-97793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4DE876F78
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC728281F47
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409F364D6;
	Sat,  9 Mar 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TTfsRbqx"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006B249F5
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709968308; cv=none; b=VNYgqUpRpqB/qAC0T5jidALu/yWNb/wQXR7BH0VMjte0+9z+sflZscSdHzueE2wW+29qAJm/iTo3EZ4RCn9moxDnha+xg/pYhunzlYzbn2JmIMKE+MXkNkDkbVXAOtSdYCT0TzVIjte6KPrvzjnTNEU0ndLAYrwLlv1dn7lO2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709968308; c=relaxed/simple;
	bh=BjOCfoUYMRP7OqNx+8EvdDWA2QJ8DGIIUjEVK6aS+wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9v9NEi+eZJGTrs5SafYsB69S7Mds9Roce/qNs3imqRw8sDUjBsCqB/p7dhdiXj+tzCUAp163jDYeFVuZ8ImuQm0iW1swbajxJ6VMXx/1xBmNju/BfmelwBOjkQtGKAEq9PG5FpbT5XqtPqcf3WDlMNdKvLDSwbRtuY6YQPak5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TTfsRbqx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e655a12c81so2136229b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 23:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709968306; x=1710573106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzMizfaSjLR1VVjX8BQWxkiusEt5V28FKCfB4nOvlsI=;
        b=TTfsRbqxUu22w89mYt/vtsPckj4fQ7dmxE5cBESFRFedD9s+Nzb8w3Qak4IGyhvHeg
         nEb6iEm7n8UaIM/yL3x8MN6dbiIL5HwmkcVSFHc2vVwphnQm61C/PCpgAocHLpuE7obi
         sMqJoJafK+DMTYSht+HtX0CZ566pRE9PJd1/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709968306; x=1710573106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzMizfaSjLR1VVjX8BQWxkiusEt5V28FKCfB4nOvlsI=;
        b=qwzSL9fkMC5KFHXbl0RLRh/v4fVeHnF1UAPfYQg9Tz68y/MrbwxSi+Jw8pYfsSJ/ez
         7VQv1P/djuMkT5VeTh8PpfN2tOUKOta8oH9x+ISqbqxVPvlV46AbVapK9GD3mB43foYa
         dhKeuQCdr01sYOOQmKVleMOXRKjfUDvmjbd6P2rDVP/ZksxHopSudfmcdw0s/1zmBP2P
         mhRq5iJWmkTm+t8mwIFYBwgeZpSeDGT8PHmCIFVWVCzzQbtkFngSofxexhVtE/D+q2eb
         Y+WtnH2heLt6o5KT0hhDoLef3mZTqR60L3sQGvJSgbuPAe+Qolo7BN2hZKZE9hJT0ZHq
         QQhA==
X-Forwarded-Encrypted: i=1; AJvYcCXjZGkqjRZfbuUB3gvG48ihuY91y5D1gBATYO/VtgihcrdTylpWaMKqgMO13Tf30vYkuYV4l0ulIgpniSq/FueAk2h6dJjiz2f4K+VG
X-Gm-Message-State: AOJu0YzxeskNWJS82CYJgzh2G+6wB4KUyTc72guwpwZSUYDEmAcJvAyz
	AQRvXlYnYPN1Wrn6zpoexhuOgMye/f6au3Fpq85MuxQWUsEwpNtuKxLt+u6eKlYssL+Jihsiqk6
	ELRBQQ2ZaGr19OfNdMxUjld47XKkb4/LiFYbK
X-Google-Smtp-Source: AGHT+IEjv3I74rC5g5xttaAypFWQmqJiyvJ1tVlk5IQ8Hs7cvr3AbTcQJPutfvDuP4dT6AXev5gMw+VQ3hhs7s7zuLM=
X-Received: by 2002:a17:903:1c9:b0:1dd:6c08:af with SMTP id
 e9-20020a17090301c900b001dd6c0800afmr1493796plh.4.1709968305651; Fri, 08 Mar
 2024 23:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308090548.269625-1-kuro.chung@ite.com.tw> <20240308090548.269625-2-kuro.chung@ite.com.tw>
In-Reply-To: <20240308090548.269625-2-kuro.chung@ite.com.tw>
From: Pin-yen Lin <treapking@chromium.org>
Date: Sat, 9 Mar 2024 15:11:34 +0800
Message-ID: <CAEXTbpemo3FDkOUf_3Wb0dbQxHKjP5OykdkkvK-xgHgqCR4pkQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] drm/bridge: it6505: fix hibernate to resume no
 display issue
To: kuro <kuro.chung@ite.com.tw>
Cc: Allen Chen <allen.chen@ite.com.tw>, Kenneth Haung <kenneth.hung@ite.com.tw>, 
	Kuro Chung <kuro.chung@ite.corp-partner.google.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuro,

On Fri, Mar 8, 2024 at 4:54=E2=80=AFPM kuro <kuro.chung@ite.com.tw> wrote:
>
> From: Kuro <kuro.chung@ite.com.tw>
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
> Signed-off-by: Kuro Chung <kuro.chung@ite.corp-partner.google.com>
>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 50 ++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index b53da9bb65a16..eff888fe7c2e7 100644
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
> @@ -2475,31 +2477,49 @@ static void it6505_irq_link_train_fail(struct it6=
505 *it6505)
>         schedule_work(&it6505->link_works);
>  }
>
> -static void it6505_irq_video_fifo_error(struct it6505 *it6505)
> +static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
>  {
> -       struct device *dev =3D &it6505->client->dev;
> +       return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
> +}
>
> -       DRM_DEV_DEBUG_DRIVER(dev, "video fifo overflow interrupt");
> -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> -       flush_work(&it6505->link_works);
> -       it6505_stop_hdcp(it6505);
> -       it6505_video_reset(it6505);
> +static bool it6505_is_video_error_int(const int *int_status)
> +{
> +       if ((it6505_test_bit(BIT_INT_VID_FIFO_ERROR, (unsigned int *)int_=
status)) || (it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, (unsigned int *)int_=
status)))
> +               return 1;
> +       return 0;
>  }
>
> -static void it6505_irq_io_latch_fifo_overflow(struct it6505 *it6505)
> +static void it6505_irq_video_error_handler(struct it6505 *it6505)
>  {
>         struct device *dev =3D &it6505->client->dev;
> +       int int_status[3] =3D {0};
> +       int reg_0d;
> +       int i;
>
> -       DRM_DEV_DEBUG_DRIVER(dev, "IO latch fifo overflow interrupt");
>         it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
>         flush_work(&it6505->link_works);
>         it6505_stop_hdcp(it6505);
>         it6505_video_reset(it6505);
> -}
>
> -static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
> -{
> -       return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
> +       DRM_DEV_DEBUG_DRIVER(dev, "Video Error reset wait video...");
> +

I still don't see any code comment around the following section.

> +       for (i =3D 0; i < 10; i++) {
> +               usleep_range(10000, 11000);
> +               int_status[2] =3D it6505_read(it6505, INT_STATUS_03);
> +               reg_0d =3D it6505_read(it6505, REG_SYSTEM_STS);
> +               it6505_write(it6505, INT_STATUS_03, int_status[2]);
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

Okay let me make the questions more specific:

1. What would happen if we remove the loop and only check the video
error interrupts once? If another video error interrupt comes out, we
handle it in the next interrupt handler. Will this lead to an infinite
loop?

2. Why do we run the loop for 10 times (100ms as you mentioned), but
not 5 times or 20 times? Does this "100ms" come from the hardware spec
or your experience on debugging this issue? I guess it's okay if it's
"I tried it a few times and 100ms seems to be just enough", but I
would prefer you to write that down in the code comments.

>  }
>
>  static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
> @@ -2519,8 +2539,6 @@ static irqreturn_t it6505_int_threaded_handler(int =
unused, void *data)
>                 { BIT_INT_HDCP_KSV_CHECK, it6505_irq_hdcp_ksv_check },
>                 { BIT_INT_AUDIO_FIFO_ERROR, it6505_irq_audio_fifo_error }=
,
>                 { BIT_INT_LINK_TRAIN_FAIL, it6505_irq_link_train_fail },
> -               { BIT_INT_VID_FIFO_ERROR, it6505_irq_video_fifo_error },
> -               { BIT_INT_IO_FIFO_OVERFLOW, it6505_irq_io_latch_fifo_over=
flow },
>         };
>         int int_status[3], i;
>
> @@ -2550,6 +2568,8 @@ static irqreturn_t it6505_int_threaded_handler(int =
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

