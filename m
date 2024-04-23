Return-Path: <linux-kernel+bounces-155311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF93E8AE8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4273B25971
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2A1369A8;
	Tue, 23 Apr 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI68GxxR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB7135414
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880239; cv=none; b=SG/muoFel1UL6N4g3ja2kbtRwarfsbUSBfq35WV0aSvew7g3oL64NfAoc9DQY54krntSL1sVnqvP45N08g/j3q9rq56SoajGVfPojKQq0s3Owe28NWOLp3qE+rDnvkHrulv1rb+ouvF5W3mLoKZyEpyrVWkrw8nIE1p5l3m5XBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880239; c=relaxed/simple;
	bh=WvgEJunFxQxvZe5kKGX5pJ8T4b7SjDJ99+xPaVRVWMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUAjweXWtDTh3MRbtteIVcQpAmtMP32YCEgsT+kaT8QlEe9QyRwXt2MG10dHvQeTol3gibwfhIPgFzsscS+ABp+pcJMHmWYePdXJ7zF+jr53+kvvSvrnqsKTzFXbfbeQpmjo8EvCzTMxEe9QPUpOKds6sD/PO3MTaW35jCwxlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI68GxxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF104C32782
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880239;
	bh=WvgEJunFxQxvZe5kKGX5pJ8T4b7SjDJ99+xPaVRVWMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mI68GxxRP5tbNsV+KQPm/AUrW1EpoZ3ti5srNmCTsI1uBIy5riuElETJVcSG3Nei1
	 WokJ1uxAJH3yLeQtRoBFCEKp106Bf6PslvNSqKhDy9cSNfP0GxfU77KllOC2pP8EcL
	 1hECMk0lfGLMueNvng0MMbdJt3gFLuP7n6WHJtBl31TlPweLHFUDLX5puy5fFEDI6M
	 FN02WzQkaIO7Sw6k13NsmRVFqpl6XTWGQJpTg+P4mwk1ZmRwRI4rBHE2oTy+cbYU4I
	 DSjPYwS6b3uHx9PAk/8/KrxKEXCjAYxYZTNz3/5sLpgEgPqSn9sRAbh+L7VuHLJcqm
	 AElfigklgWGcQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22f746c56a2so2572175fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:50:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWphqgt5yEuHY5F8pOmuXvDdSEaMYwm9semXOcsX1THh9pGv3LqXIgylLyvP7+IP6eOKq6igD2NUj1xoRM6zQFWdhRhCNO1g3GWnYLR
X-Gm-Message-State: AOJu0YyMkiLrzXXudvIadiiJrHE77Qnokr0LBrSWYQw6gWciCDBJJLPc
	CVyUveqwBek0XMt2DVWCk2wCZcdHrFOUwcPvtjlcu61lD9jSOno/7/kSNSDZcYNRobo69a/yEo+
	e9TVjM9JP1jSlV/5S5nAB9EwoWP5N7CJwqUf5vQ==
X-Google-Smtp-Source: AGHT+IE/YD0s84IsYB0S2ZE6yekA5zCcCTcTvhBJHQHR+U6iv+FpDCMJciZD7J3d+FRWEGJM6YD/NW9iPYrm7WJNEps=
X-Received: by 2002:a05:6870:b601:b0:233:5557:c6a2 with SMTP id
 cm1-20020a056870b60100b002335557c6a2mr18799782oab.34.1713880238268; Tue, 23
 Apr 2024 06:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423082722.843587-1-kuro.chung@ite.com.tw> <20240423082722.843587-2-kuro.chung@ite.com.tw>
In-Reply-To: <20240423082722.843587-2-kuro.chung@ite.com.tw>
From: Robert Foss <rfoss@kernel.org>
Date: Tue, 23 Apr 2024 15:50:26 +0200
X-Gmail-Original-Message-ID: <CAN6tsi5cM=2qDAVQk3vdQAHJCOZFMPnA9ypZ_U2ZnKn7JDLGyA@mail.gmail.com>
Message-ID: <CAN6tsi5cM=2qDAVQk3vdQAHJCOZFMPnA9ypZ_U2ZnKn7JDLGyA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] drm/bridge: it6505: fix hibernate to resume no
 display issue
To: kuro <kuro.chung@ite.com.tw>
Cc: Allen Chen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Haung <kenneth.hung@ite.com.tw>, 
	Kuro Chung <kuro.chung@ite.corp-partner.google.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:16=E2=80=AFAM kuro <kuro.chung@ite.com.tw> wrote=
:
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
>  drivers/gpu/drm/bridge/ite-it6505.c | 73 +++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index b53da9bb65a16..ae7f4c7ec6dd0 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1317,9 +1317,15 @@ static void it6505_video_reset(struct it6505 *it65=
05)
>         it6505_link_reset_step_train(it6505);
>         it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_VID_MUTE, EN_VID_M=
UTE);
>         it6505_set_bits(it6505, REG_INFOFRAME_CTRL, EN_VID_CTRL_PKT, 0x00=
);
> -       it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESET)=
;
> +
> +       it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x02);
> +       it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x00);
> +
>         it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, RST_501_=
FIFO);
>         it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, 0x00);
> +
> +       it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESET)=
;
> +       usleep_range(1000, 2000);
>         it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, 0x00);

Can any of these magic values be defined as macros?

>  }
>
> @@ -2249,12 +2255,11 @@ static void it6505_link_training_work(struct work=
_struct *work)
>         if (ret) {
>                 it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
>                 it6505_link_train_ok(it6505);
> -               return;
>         } else {
>                 it6505->auto_train_retry--;
> +               it6505_dump(it6505);
>         }
>
> -       it6505_dump(it6505);
>  }
>
>  static void it6505_plugged_status_to_codec(struct it6505 *it6505)
> @@ -2475,31 +2480,53 @@ static void it6505_irq_link_train_fail(struct it6=
505 *it6505)
>         schedule_work(&it6505->link_works);
>  }
>
> -static void it6505_irq_video_fifo_error(struct it6505 *it6505)
> +static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
>  {
> -       struct device *dev =3D &it6505->client->dev;
> -
> -       DRM_DEV_DEBUG_DRIVER(dev, "video fifo overflow interrupt");
> -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> -       flush_work(&it6505->link_works);
> -       it6505_stop_hdcp(it6505);
> -       it6505_video_reset(it6505);
> +       return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
>  }
>
> -static void it6505_irq_io_latch_fifo_overflow(struct it6505 *it6505)
> +static void it6505_irq_video_handler(struct it6505 *it6505, const int *i=
nt_status)
>  {
>         struct device *dev =3D &it6505->client->dev;
> +       int reg_0d, reg_int03;
>
> -       DRM_DEV_DEBUG_DRIVER(dev, "IO latch fifo overflow interrupt");
> -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> -       flush_work(&it6505->link_works);
> -       it6505_stop_hdcp(it6505);
> -       it6505_video_reset(it6505);
> -}
> +       /*
> +        * When video SCDT change with video not stable,
> +        * Or video FIFO error, need video reset
> +        */
>
> -static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
> -{
> -       return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
> +       if ((!it6505_get_video_status(it6505) &&
> +               (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *) int_st=
atus))) ||
> +               (it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, (unsigned int =
*) int_status)) ||
> +               (it6505_test_bit(BIT_INT_VID_FIFO_ERROR, (unsigned int *)=
 int_status))) {
> +
> +               it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> +               flush_work(&it6505->link_works);
> +               it6505_stop_hdcp(it6505);
> +               it6505_video_reset(it6505);
> +
> +               usleep_range(10000, 11000);
> +
> +               /*
> +                * Clear FIFO error IRQ to prevent fifo error -> reset lo=
op
> +                * HW will trigger SCDT change IRQ again when video stabl=
e
> +                */
> +
> +               reg_int03 =3D it6505_read(it6505, INT_STATUS_03);
> +               reg_0d =3D it6505_read(it6505, REG_SYSTEM_STS);
> +
> +               reg_int03 &=3D (BIT(INT_VID_FIFO_ERROR) | BIT(INT_IO_LATC=
H_FIFO_OVERFLOW));
> +               it6505_write(it6505, INT_STATUS_03, reg_int03);
> +
> +               DRM_DEV_DEBUG_DRIVER(dev, "reg08 =3D 0x%02x", reg_int03);

Is this correct? Doesreg_int03 contain reg08?

> +               DRM_DEV_DEBUG_DRIVER(dev, "reg0D =3D 0x%02x", reg_0d);
> +
> +               return;
> +       }
> +
> +
> +       if (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *) int_status)=
)
> +               it6505_irq_scdt(it6505);
>  }
>
>  static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
> @@ -2512,15 +2539,12 @@ static irqreturn_t it6505_int_threaded_handler(in=
t unused, void *data)
>         } irq_vec[] =3D {
>                 { BIT_INT_HPD, it6505_irq_hpd },
>                 { BIT_INT_HPD_IRQ, it6505_irq_hpd_irq },
> -               { BIT_INT_SCDT, it6505_irq_scdt },
>                 { BIT_INT_HDCP_FAIL, it6505_irq_hdcp_fail },
>                 { BIT_INT_HDCP_DONE, it6505_irq_hdcp_done },
>                 { BIT_INT_AUX_CMD_FAIL, it6505_irq_aux_cmd_fail },
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
> @@ -2550,6 +2574,7 @@ static irqreturn_t it6505_int_threaded_handler(int =
unused, void *data)
>                         if (it6505_test_bit(irq_vec[i].bit, (unsigned int=
 *)int_status))
>                                 irq_vec[i].handler(it6505);
>                 }
> +               it6505_irq_video_handler(it6505, (unsigned int *) int_sta=
tus);
>         }
>
>         pm_runtime_put_sync(dev);
> --
> 2.25.1
>

