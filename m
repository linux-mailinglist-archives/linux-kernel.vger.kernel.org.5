Return-Path: <linux-kernel+bounces-20127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C18827A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22AEEB22CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3644056442;
	Mon,  8 Jan 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="acY5tpkf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6F56443
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso2771691e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 13:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704749103; x=1705353903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR9McGLlTiEfzqcRXBcYSkmSDTOc2iHSoi6pDKX/2j0=;
        b=acY5tpkfvAxpWEMLUExLfXB6SMRTMejfAwrgPX7zFEqco6uJm8EQAflC+A9DDSs1Yc
         stAxsFS6BCAu2IzqFIni9+NLlsnmEQHvFj3jLq+jb8d5bipyPOe2UTQcUTl8Ps2XzSWz
         ww+/CKR+a1nJ6/SWBgPZmUpdw2PvaiwpA64J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704749103; x=1705353903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR9McGLlTiEfzqcRXBcYSkmSDTOc2iHSoi6pDKX/2j0=;
        b=Wtjjn5w8ejWFJ0etxa1keQnGrcLvN7oIIxAUCyIfsZ2Hr29JKkuCAg3/znSG/Pl8iq
         ZrGnwp/XfXwejDy4rArRgLPkwbl4UlbRptNsXid7zhFSL7Mn6wCLc7lk5UqCkcHQdQb3
         keXaYLWwgDPs/NvWGgaLxhVfvMzGAgzP+W2pF6C6213P0VWK0NSf4rVyOMCWg2M1b3mA
         mxoRJfJmwy9uT39wQ0asMVZ3scLJi95sD4gntNUa2IVBMaiF1PGEJaWX5DESfjbK2oUs
         WYjihrd8IWTwYl/ztT+Ml/0SmaUxRLauAlJIBZH4TjuruWHR8aqqAyhneToLR3jcBJx8
         btbw==
X-Gm-Message-State: AOJu0YwqFArvO6ongGNEZogPe27XIfJR9GrO8nqKKMaac1luDX5yFk3X
	vIggzqdOyn9l0A81ySd2rqV/A0VC8WSlbjTCgGVx9EYhL/fk
X-Google-Smtp-Source: AGHT+IE9WpMELvx6bUFBM64ao5S82rrIMmq19zmnU7guvSiP5o9k51LHdrt5NIfXZi4bAlNV0WVKrA==
X-Received: by 2002:a05:6512:6d0:b0:50e:ca15:aab5 with SMTP id u16-20020a05651206d000b0050eca15aab5mr167394lff.25.1704749103080;
        Mon, 08 Jan 2024 13:25:03 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090680c300b00a2a4a6e1bc5sm261871ejx.204.2024.01.08.13.25.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 13:25:02 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so16905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 13:25:02 -0800 (PST)
X-Received: by 2002:a05:600c:2e51:b0:40d:56bd:e8c4 with SMTP id
 q17-20020a05600c2e5100b0040d56bde8c4mr40194wmf.7.1704749102084; Mon, 08 Jan
 2024 13:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103003355.747335-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240103003355.747335-1-kai.heng.feng@canonical.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jan 2024 13:24:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VmGNB5dP5WO7=txNDScNfhCDEsfFFivXqz+PH6rt=x8g@mail.gmail.com>
Message-ID: <CAD=FV=VmGNB5dP5WO7=txNDScNfhCDEsfFFivXqz+PH6rt=x8g@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Remove SET_POWER SLEEP on system suspend
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Johan Hovold <johan+linaro@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 2, 2024 at 4:34=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> There's a Cirque touchpad that wakes system up without anything touched
> the touchpad. The input report is empty when this happens.
> The reason is stated in HID over I2C spec, 7.2.8.2:
> "If the DEVICE wishes to wake the HOST from its low power state, it can
> issue a wake by asserting the interrupt."
>
> This is fine if OS can put system back to suspend by identifying input
> wakeup count stays the same on resume, like Chrome OS Dark Resume [0].
> But for regular distro such policy is lacking.
>
> According to commit d9f448e3d71f ("HID: i2c-hid: set power sleep before
> shutdown"), SLEEP is required for shutdown, in addition to that, commit
> 67b18dfb8cfc ("HID: i2c-hid: Remove runtime power management") didn't
> notice any power comsumption reduction from SET_POWER SLEEP, so also
> remove that to avoid the device asserting the interrupt.
>
> [0] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power_m=
anager/docs/dark_resume.md
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 2735cd585af0..dd513dc75cb9 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -957,9 +957,6 @@ static int i2c_hid_core_suspend(struct i2c_hid *ihid,=
 bool force_poweroff)
>         if (ret < 0)
>                 return ret;
>
> -       /* Save some power */
> -       i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);

IMO this is not a good idea to do universally. Specifically:

1. There are many vendors of i2c-hid devices and many different
devices per vendor. Even if your device doesn't save power in "sleep"
mode, that doesn't mean it's not important for some other devices.

2. There are some boards where an i2c-hid device is powered by an
"always-on" regulator. On these devices it seems like a bad idea not
to be able to put the i2c-hid device into sleep mode.


I'd also note that I'm really not sure what ChromeOS dark resume has
to do with anything here. Dark resume is used for certain types of
events that wakeup the system where we can identify that the event
shouldn't turn the screen on, then we do some processing, then we go
back to sleep. I'm nearly certain that a trackpad / touchscreen wakeup
event would never qualify for "dark resume". If we see a
trackpad/touchscreen event then we'll wakeup the system. If the system
is in a state where trackpad/touchscreen events shouldn't wake us up
then we disable those wakeups before going to suspend...

It seems to me like the board you're testing on has some strange bug
and that bug should be fixed, or (in the worst case) you should send a
patch to detect this broken touchpad and disable wakeup for it.


-Doug

