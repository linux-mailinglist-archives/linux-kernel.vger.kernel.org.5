Return-Path: <linux-kernel+bounces-37842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7283B656
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB3B1F23EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCEF1388;
	Thu, 25 Jan 2024 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv6l9chR"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2A7F8;
	Thu, 25 Jan 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144654; cv=none; b=o84tpWi+dmR9jO+Ts1lxK1rRrFh8Sb0FeVrCh42DZdClGU+AEUJHkOnveezN0ryH/esfXUv0dEWUbv1ANafij+Y/p5biWrci7ldwZZbCA5ysR6bOJdO+tEzapLdq+X/9P/A+5kX1UqRV4POtRYwC1xrm5GIVz0qvFoxNmQIgGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144654; c=relaxed/simple;
	bh=yrn1KceoCEV9E2X+gMdi5SB7RD3fOrfIAtwD5tqFxVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDesedane8Ktj9dw96OIVuYIV0J5VRfW53tAjDUz8s6ksOTYKEomCLpHodguOLPRIrdTWUu4WAfPhyPfdyPKYq1DSCYDoVw/stgO5kvD1U+iRlrcvZJsH6jXh2VzYy+TxrI45r3HimBSB3XAom5z0UN280Cyc4I75sOyZpQn4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv6l9chR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4085099a12.1;
        Wed, 24 Jan 2024 17:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706144651; x=1706749451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAjy8o7mK2jxLO30WD6vuXRYXSBlcMTLyTUzMLzRzmM=;
        b=gv6l9chRjqA+jnjP7jJOy3dztBPS5ABAJDzEGu5wZPqYGd5/LED3M8wxo45znYRKkR
         dN8PZs6s61WAWmN38CzFU5tvhTMOaiFigz7hDyRL9Kjb8moTjyJ0JF32CnzttAHAPHnv
         UT4xW7Xjibz3rmpkMH3wUlCAthnshQq+JkgMbGN2OWrFT/VlmnhpIts1kGFbgP9KEmVG
         9/oej/qOSa/hNzsBicS5ZAIDMK9gTo5iLfSqu7o9aDrszudHUIiDKGtbZ2Bfv5GBijmi
         tow+Hudp7mgSZdSKMbgfPXWGaQ8Z7a9CZP0recOHuTk8cnZQ3JZwv8OXhuaMQ1YPc9Zp
         rW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706144651; x=1706749451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAjy8o7mK2jxLO30WD6vuXRYXSBlcMTLyTUzMLzRzmM=;
        b=jo/vlqqXzYXstsU/cNvdVlHU1ymaSW1eKjyutw2RENBiF25+yNs+jmzeThw3OIxEpb
         9zJP1MC+2ocnYwwBNTV/PeuXJP6Si0XjfQmBveH0aN1EWkxuCUFtfJ3lULS4KVNLgog2
         /6rrzeHFA3xIyNGoL1grQKx0H3dDyBD1nhq9faJgh1fi5BxWxM5P6MojT3nXvnJX+WCL
         Rm0HSas7hZtoOHnnb386fsSW63JLLr5At1z5302tWhugODqnee+WnTgoQGvZP1ZrvSbA
         Cc4UyBV1Nr3On5duNM5/IrV+T2Qg8GCgadIlLYuUwrI1kI4pd9Jz+wfHQGE98rFje0er
         ALMw==
X-Gm-Message-State: AOJu0Yw6nwQQoOwhov8DUOZdk6YYKpesFuNiNtJlMpSzHmzf7RbAWh9E
	9tDKCn4IlHC4hSGTIzuRdxTBXQrUuGVt2hIR9XFxRk0l2qjw5uDvub6joRUMN1/Osd3HDe+Tp6H
	jYRZNhnfap3L6nsmDV0vPfsDMPb0=
X-Google-Smtp-Source: AGHT+IFfRQT8q2bTr2lvLvt1k3dEQYTmghKRBGQcSSdxPyWzD3wGRlFoNCG3ipXjXBP77gBYHfA0vH24LllOT5X9uRo=
X-Received: by 2002:a17:907:a809:b0:a31:5773:9f9f with SMTP id
 vo9-20020a170907a80900b00a3157739f9fmr64279ejc.32.1706144650803; Wed, 24 Jan
 2024 17:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <20240115144538.12018-8-max@enpas.org>
In-Reply-To: <20240115144538.12018-8-max@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 24 Jan 2024 17:03:59 -0800
Message-ID: <CAEc3jaBU3M0Zce2pdFvdBSG50a7Ky=GY4gLO3dkYdDrkYtiO0Q@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] HID: playstation: DS4: Add VID/PID for SZ-MYPOWER controllers
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 6:52=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> It seems like this USB VID is not officially assigned, so let's create a
> hid-ids.h entry without a vendor or product name.
>
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/hid/hid-ids.h         | 3 +++
>  drivers/hid/hid-playstation.c | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 72046039d1be..df831ab464a4 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -22,6 +22,9 @@
>  #define USB_DEVICE_ID_3M2256           0x0502
>  #define USB_DEVICE_ID_3M3266           0x0506
>
> +#define USB_VENDOR_ID_7545             0x7545
> +#define USB_DEVICE_ID_7545_0104                0x0104
> +
>  #define USB_VENDOR_ID_A4TECH           0x09da
>  #define USB_DEVICE_ID_A4TECH_WCP32PU   0x0006
>  #define USB_DEVICE_ID_A4TECH_X5_005D   0x000a
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index a0eb36d695d9..0aa474f1e96f 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -2747,6 +2747,10 @@ static const struct hid_device_id ps_devices[] =3D=
 {
>         { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER_DONGLE),
>                 .driver_data =3D PS_TYPE_PS4_DUALSHOCK4 },
>
> +       /* Third-party controllers identifying as "SZ-MYPOWER" */
> +       { HID_USB_DEVICE(USB_VENDOR_ID_7545, USB_DEVICE_ID_7545_0104),
> +               .driver_data =3D PS_TYPE_PS4_DUALSHOCK4 },
> +
>         /* Sony DualSense controllers for PS5 */
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5=
_CONTROLLER),
>                 .driver_data =3D PS_TYPE_PS5_DUALSENSE },
> --
> 2.39.2
>
>

I'm not familiar with this device, but if it indeed works. Then I'm
okay with it.

Thanks,
Roderick

