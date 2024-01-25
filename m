Return-Path: <linux-kernel+bounces-37841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4B83B653
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF1F1F237FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59517C2;
	Thu, 25 Jan 2024 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs9IGCqt"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B227F8;
	Thu, 25 Jan 2024 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144476; cv=none; b=scytJxutzDghDd+0HoPT3hYaiS25o1FrFDjGEpyhu2uAJVdC2O2D7qA+eB2OcenUlb4lF9Vy3zcxFL259+K/XD/ubPqC/GUQUaUDRz0/sVcWtNPNg7rYXn/L3DgCTCrP8mXB17wU0fYUXn9md75NtI4x4vsbc9DLn4505CpNDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144476; c=relaxed/simple;
	bh=aAY/Pry5Kjaz4wqkv7lOYDN55tnggAzWhDbTtjVonGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgjcGiPPl6uzGfsRcG8rUnANALAP2j2GzycziXJsmVZ77ZvRo2UeJKBKLxGCeza6FuEGNL12tqe1/OaDEAho3jS6tTj7RrypZoTcJyRXRKphEbB4sjhjP12Zv5vfcpfuX40VjKh04JapjVZi9arvMvxK8WvgpzrXkzuRJbFpvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs9IGCqt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55cd798b394so454025a12.0;
        Wed, 24 Jan 2024 17:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706144472; x=1706749272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wlytBSogeuOwCdynHPj1+lp6nTAVWkrJDq1Bxhe/cg=;
        b=Fs9IGCqtnHQYJI8IX0l47RA9Q9vxZSERn/hMuOnuxI9JJOdbUp5Mz9znS7FwiznAYK
         il03fhqN//fLfPpaiWEF6JUgpcEzngS0N1DhHFhvUZ/TH6oZ1rcjwcag5ZJzLBV34PXL
         qcs+MQrcbFVEGiKv3LwHuh0n8wfpxoKP7BCRaCpx1lXreFvhVkLY+7SQOWkd0KxutHuW
         IDrO1G9ah6Ofdgfu5qi9KUxw9KBCmvpxW1DO6UYFhHtkRx6Qv6r9m+p5YMgV8YzzTkBa
         7gSaa/eUliVriQn5LmmD5ZvUN2Yvy5gq4uhuBnCQk+DmSpg0ryFKu0/cZ5Rr2kMhZKGP
         48Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706144472; x=1706749272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wlytBSogeuOwCdynHPj1+lp6nTAVWkrJDq1Bxhe/cg=;
        b=HhAtiZV2ocFF80fNiwqNfed1f2byfN+Q3VbHRH856GRFsedp8wsh1jg+q1qCqB7rJr
         Dj0K9QzqORHY2hwXB67afZ934Nlblq0S5TrCDBYhIfhzAHyUSYqWqvUaLdRcIzVRsER1
         CH5z6BbKP7m6ON9D8aUVarJ8n+lWxnyM5l8OgIqg08Nw3VSTN3BRoREjxtjJjcK19C7J
         DDwUoM91dbOXPAkVY/LfuegVRwdbbSkEz6mFXQx28yVqXpleox0SF+hg9Udy5Nfhf8kQ
         06jmiZXv0ZJEEAdUCcJTLQRq5lHZNJsiGeum74xn/P3EMJjo+ACCsViTJgF+ShUibBTy
         Ob5Q==
X-Gm-Message-State: AOJu0YygxUGDcv8TOhpH7h2v5XpAu9Z5XdhK9IKrhT5PNjK/m9LD3axl
	8/cVVGsHbU8AzCzHfsrlFRooXHvHD08fxqfM1ont7cYCDk3vrMXsGpnMrWVCt6TjKFmmTRbyy5R
	Oh6leXHZF29vRNmHiYQjEwXN3m0LZPS70
X-Google-Smtp-Source: AGHT+IHQD5LlBm8SJXBxKjam2afeKPNXa2zBEHx9DJF/ZanTf+IoePmuXYN2ChhXANTvSOymlaHkgrytu+GA5VFFY84=
X-Received: by 2002:a17:907:d501:b0:a28:abfa:e405 with SMTP id
 wb1-20020a170907d50100b00a28abfae405mr200905ejc.58.1706144472329; Wed, 24 Jan
 2024 17:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <20240115144538.12018-7-max@enpas.org>
In-Reply-To: <20240115144538.12018-7-max@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 24 Jan 2024 17:01:00 -0800
Message-ID: <CAEc3jaBvsr5vnc_Dfm2YsThxBr94TkE3i16GLQipVZM+4KH3cw@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] HID: playstation: Simplify device type ID
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 6:55=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> Distinguish PS4/PS5 type controllers using .driver_data in
> MODULE_DEVICE_TABLE rather than by VID/PID.
>
> This allows adding compatible controllers with different VID/PID.
>
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/hid/hid-playstation.c | 40 +++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index 086b0768fa51..a0eb36d695d9 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -27,6 +27,11 @@ static DEFINE_IDA(ps_player_id_allocator);
>
>  #define HID_PLAYSTATION_VERSION_PATCH 0x8000
>
> +enum PS_TYPE {
> +       PS_TYPE_PS4_DUALSHOCK4,
> +       PS_TYPE_PS5_DUALSENSE,
> +};
> +
>  /* Base class for playstation devices. */
>  struct ps_device {
>         struct list_head list;
> @@ -2690,17 +2695,14 @@ static int ps_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
>                 goto err_stop;
>         }
>
> -       if (hdev->product =3D=3D USB_DEVICE_ID_SONY_PS4_CONTROLLER ||
> -               hdev->product =3D=3D USB_DEVICE_ID_SONY_PS4_CONTROLLER_2 =
||
> -               hdev->product =3D=3D USB_DEVICE_ID_SONY_PS4_CONTROLLER_DO=
NGLE) {
> +       if (id->driver_data =3D=3D PS_TYPE_PS4_DUALSHOCK4) {
>                 dev =3D dualshock4_create(hdev);
>                 if (IS_ERR(dev)) {
>                         hid_err(hdev, "Failed to create dualshock4.\n");
>                         ret =3D PTR_ERR(dev);
>                         goto err_close;
>                 }
> -       } else if (hdev->product =3D=3D USB_DEVICE_ID_SONY_PS5_CONTROLLER=
 ||
> -               hdev->product =3D=3D USB_DEVICE_ID_SONY_PS5_CONTROLLER_2)=
 {
> +       } else if (id->driver_data =3D=3D PS_TYPE_PS5_DUALSENSE) {
>                 dev =3D dualsense_create(hdev);
>                 if (IS_ERR(dev)) {
>                         hid_err(hdev, "Failed to create dualsense.\n");
> @@ -2734,16 +2736,26 @@ static void ps_remove(struct hid_device *hdev)
>
>  static const struct hid_device_id ps_devices[] =3D {
>         /* Sony DualShock 4 controllers for PS4 */
> -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4=
_CONTROLLER) },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER) },
> -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4=
_CONTROLLER_2) },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER_2) },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER_DONGLE) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4=
_CONTROLLER),
> +               .driver_data =3D PS_TYPE_PS4_DUALSHOCK4 },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER),
> +               .driver_data =3D PS_TYPE_PS4_DUALSHOCK4 },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4=
_CONTROLLER_2),
> +               .driver_data =3D PS_TYPE_PS4_DUALSHOCK4 },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER_2),
> +               .driver_data =3D PS_TYPE_PS4_DUALSHOCK4 },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER_DONGLE),
> +               .driver_data =3D PS_TYPE_PS4_DUALSHOCK4 },
> +
>         /* Sony DualSense controllers for PS5 */
> -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5=
_CONTROLLER) },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTR=
OLLER) },
> -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5=
_CONTROLLER_2) },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTR=
OLLER_2) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5=
_CONTROLLER),
> +               .driver_data =3D PS_TYPE_PS5_DUALSENSE },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTR=
OLLER),
> +               .driver_data =3D PS_TYPE_PS5_DUALSENSE },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5=
_CONTROLLER_2),
> +               .driver_data =3D PS_TYPE_PS5_DUALSENSE },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTR=
OLLER_2),
> +               .driver_data =3D PS_TYPE_PS5_DUALSENSE },
>         { }
>  };
>  MODULE_DEVICE_TABLE(hid, ps_devices);
> --
> 2.39.2
>
>

Hi Max,

This one looks good to me.

Roderick

