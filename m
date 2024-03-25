Return-Path: <linux-kernel+bounces-118154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE73988B511
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD251C368E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5A82D6B;
	Mon, 25 Mar 2024 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ObzTlQBw"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757FF82D63
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408366; cv=none; b=Tt4Jy3tbYd9hy+Yc7XtyBh7E6ckC9tvokM9hZ83jD7wc4aqIZrxnRuN6RL2fGzdalWNnvNoOhBFc2T7b8xQAFy+2GGQXWldMBaZW1oINCJ82zOfmfpwcCElcqIv1KIO3Ylk0iLZv1VZtcUOA9sCYXNdAzkSNFhKoFJTgBEzaYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408366; c=relaxed/simple;
	bh=0ryjR25W+4XYUKpxRIFpQkdPipPiaotlUMMEk/7gGno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpeHJI2GpD6/R9XJraiG/cneAUGB2+aM12DuNiJ64ZfZZqyCtEwHoPZJzs+vHU24NbiT3L/c4q/g42+i/hqM/7Y3aQ43Eck7mR571rPnaRXklM6R9KQH02vyRqpYG4G6zbmfLa/9gN7Svr6MYvzITyxKhIlRtvIngcWmz7jAGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ObzTlQBw; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7e0fa900784so658377241.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711408361; x=1712013161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RlYH6izUM2rxtwt/YBr2HvwCdCxPPIhithRJ0Si7KE=;
        b=ObzTlQBwFxd45+sLPhM7w1jHyIvBf+F/07X9CzFtpzfjMTi7IQXXU5BNcfG/12BjS0
         6Mol1mJSf5wwROpxhtKtN2NkGlb3hvv5ifZ8HQHDAaQreO0PUutz9bQphw7U3VbL6oeF
         KBWwcL7GtIQebqEam4+pnQOt7mo6LSJlw2pmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711408361; x=1712013161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RlYH6izUM2rxtwt/YBr2HvwCdCxPPIhithRJ0Si7KE=;
        b=T2A1/W/6oxqpYuwN10Jz1Ep/QkHetu4XGhMxCOVcqgWb6GJcj46MrHtF+z7QZkli7X
         /a136lpjoYAHp3HB/aA/cZqcDNeZLZZXkZIcf5jXYYgWG94wApo/oIGQk7vi8gftYs0I
         BdmxV4ga+nkVX74SIbNt31Y/dHzR+WT3IQ3A5HqW0jXaNIOm4qxCGhYm+tIWWHksRtGp
         2qFOHTKvU1nCiLx86X/FgcI9LnyqrGlvepC7ue7Yojta11WKU28sd6Su2+o+3sxyhs8i
         ovf+j1RwHnSNsS9pasoS0zhev1nm3GRDCHsMWuv1Z4JNPwrYMFeLqc7tKFz4fjIl7T/E
         9/jg==
X-Forwarded-Encrypted: i=1; AJvYcCWwchwgBe/ZcS1f42WoamKrZ29ZPef2o++Fn1hb8iQvmzCvgN0r9YvQCLVtMDhRS8PawZ4h5T8N0MjBFYJYrdabaAkt9DKw9U/bRvUE
X-Gm-Message-State: AOJu0Yx8bd1CQYuUybEagOt/QB0VghBh+0N9QPKYlOv6wWO9Jz6imPkU
	38Y3P2zXlY02LgjEQoeBHdIJLO9u6DEdqP8sp+VhBCSUYi63NGfxu2cfVAtrlhXaHPIbp0t/twI
	=
X-Google-Smtp-Source: AGHT+IGaWhGC7xF4oJWWb6eGN0CwC9fztCSSYmpJeQOh0cbLvGYGUtlb0vqsoHzFQq1AUKCxhZzPHQ==
X-Received: by 2002:a05:6122:d21:b0:4c0:254f:75d5 with SMTP id az33-20020a0561220d2100b004c0254f75d5mr6903159vkb.10.1711408361088;
        Mon, 25 Mar 2024 16:12:41 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id r10-20020a056214212a00b00690c9256676sm4594373qvc.49.2024.03.25.16.12.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 16:12:40 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-428405a0205so65631cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:12:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2PgRm9L3i7MpZC1hVG9+CeSSdyqHJ+HBZFBG2epB9UQEqGBmLcCqDXkj3FS6GhOpWIHnJW7us1aNhyI3eMHTB9f7ZbUjoQNj7XG5b
X-Received: by 2002:a05:622a:6101:b0:430:b590:e88c with SMTP id
 hg1-20020a05622a610100b00430b590e88cmr43919qtb.6.1711408359196; Mon, 25 Mar
 2024 16:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325105452.529921-1-lma@chromium.org>
In-Reply-To: <20240325105452.529921-1-lma@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 16:12:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VHps2d4dqLXCqE=hNMbk4pxeN607nFA0nEkd7chNAr3A@mail.gmail.com>
Message-ID: <CAD=FV=VHps2d4dqLXCqE=hNMbk4pxeN607nFA0nEkd7chNAr3A@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: Lukasz Majczak <lma@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 3:55=E2=80=AFAM Lukasz Majczak <lma@chromium.org> w=
rote:
>
> This patch extends the early bailout for probing procedure introduced in
> commit: b3a81b6c4fc6730ac49e20d789a93c0faabafc98, in order to cover devic=
es

nit: checkpatch should have yelled at you saying that you should
specify a commit in the format:

commit b3a81b6c4fc6 ("HID: i2c-hid: check if device is there before
really probing")

Please fix and make sure that you're running checkpatch.


> based on STM microcontrollers. For touchpads based on STM uC,
> the probe sequence needs to take into account the increased response time
> for i2c transaction if the device already entered a deep power state.
> STM specify the wakeup time as 400us between positive strobe of
> the clock line. Deep sleep is controlled by Touchpad FW,
> though some devices enter it pretty early to conserve power
> in case of lack of activity on the i2c bus.
> Failing to follow this requirement will result in touchpad device not bei=
ng
> detected due initial transaction being dropped by STM i2c slave controlle=
r.
> By adding additional try, first transaction will wake up the touchpad
> STM controller, and the second will produce proper detection response.
>
> Signed-off-by: Lukasz Majczak <lma@chromium.org>
> Signed-off-by: Radoslaw Biernacki <rad@chromium.org>

nit: I believe your sign off should be last. It's also unclear why two
signoffs. Did Radoslaw author it and you changed it? ...or was it
Co-Developed-by, or ...? You'll probably need to adjust your tags a
bit depending on the answers.


> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Overall comment on this patch: I know that this is based on a patch
we've been carrying downstream in ChromeOS for years and some folks
considered it not upstreamable because it's too hacky. My $0.02 is
that, while it's ugly, this is needed to support real hardware that
was shipped. There's zero chance we can fix the hardware, a .00001%
chance that we could convince someone to update the firmware on the
i2c-hid device, and a .01% chance that we could convince people to try
to figure out a workaround by adding something to the main AP firmware
on this device. As I understand it, nobody has come up with a better
kernel workaround than this patch.

To me it doesn't seem terrible to have this retry here and it's not a
huge penalty for other i2c-hid users. ...so personally I'm in favor of
the idea of this landing. If I was a consumer and had one of the
affected Chromebooks I'd personally rather upstream have the support
for it.


> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 2df1ab3c31cc..69af0fad4f41 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -1013,9 +1013,15 @@ static int __i2c_hid_core_probe(struct i2c_hid *ih=
id)
>         struct i2c_client *client =3D ihid->client;
>         struct hid_device *hid =3D ihid->hid;
>         int ret;
> +       int tries =3D 2;
> +
> +       do {
> +               /* Make sure there is something at this address */
> +               ret =3D i2c_smbus_read_byte(client);
> +               if (tries > 0 && ret < 0)
> +                       usleep_range(400, 400);

Having both ends of the usleep be 400 is iffy. In this case it's at
probe time so I wonder if udelay() is better? If not, maybe give at
least _some_ margin?


> +       } while (tries-- > 0 && ret < 0);

I'm not a huge fan of having to check "tries" and "ret" twice.
Personally I'd rather see a "while (true)" loop and test the condition
once to break out. AKA:

while (true) {
  ret =3D i2c_...
  tries--;
  if (tries =3D=3D 0 || ret >=3D 0)
    break;
  udelay(400);
}

..if you feel very strongly about the way you have coded it, though,
I won't stand in your way.

Pretty much all my comments are just nits and, since I'm not the
maintainer here, my opinion is just an opinion. I'd wait at least a
little while for the maintainers to comment before posting v2. I'm
happy to give a Reviewed-by tag when some of the nits are fixed.

-Doug

