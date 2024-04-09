Return-Path: <linux-kernel+bounces-136146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD889D07B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE46E1F24EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309485467C;
	Tue,  9 Apr 2024 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBLY5eHZ"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FC5464A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630894; cv=none; b=CXmX/TY2YILr6vyNt/zwM61/gRhEYP53soDyPq4RFkdh7/7ebSudP5OSQTG0MB7lU7qvq0EVxo2MZWn/zucceNusMtGCcpalHiVwUGdmW8+bOQ/gnrOXXpH2MjxuLGUQLlhEBkBXJI0qvQ3aAvZv7Svv2FdlpfJwlq+QiQl9wmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630894; c=relaxed/simple;
	bh=W4VPnTaME3YXfp3NpzQHHD041XAWthswcv7tncBwfu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6Cj85treBqO9vPmZiKthq1c7Vtvk7q11vfw6f8bVB3AvB23ujck7JOOPgkAebPUnmoudHM0wYsEXNd8FPZ8+JmGXVNG3Rs5cJw8QZcuIUKm/VUBEBFDylq3nuYI6Of8T1N+u6g+sj2bzan+H8NpmOVYOaLttlvvH3DhMHa1kG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dBLY5eHZ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4daa68eef71so1487626e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712630892; x=1713235692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dBIuA8MJb7TXY6gP2nJKpF5Bnu0yGdIwXcvJf/sg8k=;
        b=dBLY5eHZFJ12aIoqTRXhZDF/xQ8m3L2hwgknOYODFpiR3u/j9LCUCU6wWpWwX+EJuS
         Ok0bGnS1YOKhcwyBYP8d1G1df79Lx22QFjSOgLD1pdNVgYMpi1bFPpRteqCOa2qkpKE2
         UxdVNUdRIii+bhONfxQYZ+R373TODSdaMpuP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712630892; x=1713235692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dBIuA8MJb7TXY6gP2nJKpF5Bnu0yGdIwXcvJf/sg8k=;
        b=uSlWmRXISkI7WXaO0GZqJQ2KVJ+XHOvk/AUvBCjjPIJ6e5Y9FsB51YRJMe47K9/a+S
         zyWxd0wz/L1UE2Xl/smOhPKJhGTeuFRN0BuJY01dtBz7m9lyoKVpzhcAClfhggfhcIdl
         91LdDG+Lev77ILLw6xIYIHmUvEGRFTVBXsBOBQyPO5yZDnEIkSkdG4S4Ci3gaqbvHaOG
         01MstbIDo5rk4hy+vZeBEId2+AM8++ai0HaRj2+VEX25UmGAs34FALZ/xiGBL08px+ng
         sKBJtR81m6eGfB3YVDBwAnIwBH5iIbIKFuwk5k4Xr03lbmRfeWHwRyaV2HPAOG4o8hPI
         b+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV2w2QWi9enIGtfwCtH8jzfitTUhs5fpSF1x2kkN3Ad+1cBQ0nh7yCS7bEXKzy9LmVmAMH/5qil7t7J1uZ0i5Ud+p+oursN6jSUACA9
X-Gm-Message-State: AOJu0YzFAnXROpQWo91jI0rzMryangS4PiXPiNOlyZCFcP8n11hVPOv6
	zCA4859vCm7G95dEzsCjnqF5sMJHlmQpSp8blGYAUB4CmKuhRcjANp29KY+R1RSg6qkLTj3dINp
	aVtyruizOCmc+zv9pwH0ylE6LYDY+j7jMh4/k
X-Google-Smtp-Source: AGHT+IFIXf0vpiEQ1qCQSCaNGZ8MV+ukl2NhARckU0H0zff/FgyaI+tYw3clXwkn/jgzLFQ8h12wgcpIe0KLPUaDmtg=
X-Received: by 2002:ac5:cdd1:0:b0:4ca:4a07:9006 with SMTP id
 u17-20020ac5cdd1000000b004ca4a079006mr6531323vkn.0.1712630891756; Mon, 08 Apr
 2024 19:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org> <ZhOnKWcNllls6gdA@google.com>
In-Reply-To: <ZhOnKWcNllls6gdA@google.com>
From: Pavan Holla <pholla@chromium.org>
Date: Mon, 8 Apr 2024 19:47:35 -0700
Message-ID: <CAB2FV=4_TYP=uBHjJLDwKOdnyfdurX5k5LqqtOPpX4er1fKiZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've uploaded v4. PTAL.

On Mon, Apr 8, 2024 at 1:13=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> How this driver get probed?  From drivers/mfd/cros_ec_dev.c?  If so, ther=
e is
> no "cros-ec-ucsi" in the MFD driver yet.

Yes, this should get probed from drivers/mfd/cros_ec_dev.c. However, the
corresponding change in the EC is still under review. I was planning to sen=
d
it out once the EC change lands. Please let me know if you think that this
review should wait until then.

>
> > diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/=
ucsi/cros_ec_ucsi.c
> > [...]
> > +static int cros_ucsi_async_write(struct ucsi *ucsi, unsigned int offse=
t,
> > +                              const void *val, size_t val_len)
> > +{
> > +     struct cros_ucsi_data *udata =3D ucsi_get_drvdata(ucsi);
> > +     uint8_t ec_buffer[MAX_EC_DATA_SIZE + sizeof(struct ec_params_ucsi=
_ppm_set)];
> > +     struct ec_params_ucsi_ppm_set *req =3D (struct ec_params_ucsi_ppm=
_set *)ec_buffer;
> > +     int ret =3D 0;
>
> The initialization is redundant.  `ret` will be overridden soon.

Removed.

>
> > +     if (val_len > MAX_EC_DATA_SIZE) {
> > +             dev_err(udata->dev, "Can't write %zu bytes. Too big.", va=
l_len);
> > +             return -EINVAL;
> > +     }
> > +
> > +     memset(req, 0, sizeof(ec_buffer));
>
> The `memset` is redundant.

Removed.

>
> > +     req->offset =3D offset;
> > +     memcpy(req->data, val, val_len);
> > +     ret =3D cros_ec_cmd(udata->ec, 0, EC_CMD_UCSI_PPM_SET,
> > +                       req, sizeof(struct ec_params_ucsi_ppm_set) + va=
l_len, NULL, 0);
>
> `sizeof(*req)`.

Done.

>
> > +static int cros_ucsi_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > [...]
> > +     udata->ucsi =3D ucsi_create(udata->dev, &cros_ucsi_ops);
>
> `dev`.
>
> > [...]
> > +static const struct platform_device_id cros_ec_ucsi_id[] =3D {
>
> To be consistent with other symbols, consider either:
> - s/cros_ec_/cros_/ for the symbol.
> or
> - s/cros_ucsi_/cros_ec_ucsi_/g for echoing the file name.

Replaced cros_ec_ucsi_id with cros_ucsi_id.

> > +     { "cros-ec-ucsi"},
>
> The driver has declared DRV_NAME, use it.  `{ DRV_NAME, 0 },`.
>

Used DRV_NAME.

> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(platform, cros_ec_ucsi_id);
>
> Ditto.

Replaced cros_ec_ucsi_id with cros_ucsi_id.

> > +static struct platform_driver cros_ucsi_driver =3D {
> > +     .driver =3D {
> > +             .name =3D DRV_NAME,
> > +             .pm =3D &cros_ucsi_pm_ops,
> > +     },
> > +     .id_table =3D cros_ec_ucsi_id,
>
> Ditto.

Replaced cros_ec_ucsi_id with cros_ucsi_id.

Thanks,
Pavan

