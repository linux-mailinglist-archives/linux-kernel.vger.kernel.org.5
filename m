Return-Path: <linux-kernel+bounces-157364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2628B106D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B28B23B63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF4F16C87C;
	Wed, 24 Apr 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKqlAErN"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2C15ECE4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978038; cv=none; b=OrxOsKcqvXnplkvh+2xvLA09caNuA1n5WMgEOVYBrIlTuypPuqHYwK85/W9ee6CAFz39CDKodap8ABBS9ZqyDFV9tvL2KqCrQAyCDlQ1rh/jXkywMZ3V94BQL3l3tOItQ/d/9pmsUNS2QqYInE9XcwsVgXdHcGJ3yzTg6mMZrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978038; c=relaxed/simple;
	bh=casyLeEEBfK4ikHLS0W+RwKPDoHx/Ev9PSKWpfdKTKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHTd5czzsPcO+BCVa3EKPvqlqrxWhNhfm21IXYhQK8H8YRU8Ct6FnC45yCR7zuiLzYRuu1OmBKp0bNZYiwnwKJSa1FgBWYph10Gd9aE0oTHKlkwz9aeF9qsbXVZUG4ZHCvJIq2E7Z6kpTbkyHe+A8/p0gVAoouE/elgjiu/nAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LKqlAErN; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ea2f95ec67so43999a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713978033; x=1714582833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg/qAOTqmSx+R9zjCsmKNbYVeXAxK/pRxpkNV37yyXo=;
        b=LKqlAErNVuRM1Lurs15Ln5KbTn5RhKZPjKpEf4SdEIBhSgynopx0tZJJeOxLahyaWg
         YxTvKbD4XQOE/VMnfU2XjHvVaDxWh/qogXwzNFQHUID3ZINDwmz8k/NhCoYPyNOc/1Zf
         5FJQmW2D1rU7WF6Qm2YdQEPQ0F/hbeu0e61nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713978033; x=1714582833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg/qAOTqmSx+R9zjCsmKNbYVeXAxK/pRxpkNV37yyXo=;
        b=C+uMpgtHDEWQY/GvTLD+A9aXGY6Edb4Q9Nm2uAQ+YnaSJ8OX7M/m55sGDyEHlZcF/a
         PJkJyw1zBG2y0pQMKpj00cAS1VW51VyiL477ERNVshxdypooO5od5eDvK1xOQR56kqUn
         MOY0Jfu6ZEdiCh1NLp3ml4eBb9fvhVPOSqJaRJ5f8kQIkJTdUMUgk+tHaw6zRzepl68Y
         kgpCT74Swc3fA0KSB8q/ilQTxC/5NDjCS/+Ol78tUGebzddvYt4mCBFDtu0bEA1/20M+
         ffkFYadS6VsWoBbpkSiMm22Xy/xQ370GNLtrFy80DTkUxU4s5e5viekR7AQalBcD1ufO
         mhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSikk9/EMoHRkTO3aaoBJA9ga/UqVjykEatmFR+oIJXJrtdDqS/RzjPYVcwOp4dAyoxtc9KpqDzXnIUGChXJUa84XVk6NOm6wD9ZYa
X-Gm-Message-State: AOJu0YxYFvoxZuVoKVEl8tLcfNvj0HHk4Ag7Kt7dYtj/+agHzrFMROJg
	pVBqJyQY388u3sr8STeVF4+gkEC7TMxvMjxNWl89RZJWhcDMkltdRwy8vfEZ+q9OanNKOSFZUlM
	=
X-Google-Smtp-Source: AGHT+IHDMoAB5SY5++nhDGWIA1fCTw1r1cd2DQc97p466KGstzHeztOzW4DrRGWKsgG3yfNVLIv9cA==
X-Received: by 2002:a9d:7f09:0:b0:6eb:89ce:9c6f with SMTP id j9-20020a9d7f09000000b006eb89ce9c6fmr4053662otq.33.1713978033277;
        Wed, 24 Apr 2024 10:00:33 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id i19-20020ae9ee13000000b0078eca9de099sm6242771qkg.134.2024.04.24.10.00.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 10:00:33 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-434ffc2b520so5101cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:00:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWanHPr1mCwgvumrA/ZGJBqORX4e/6S9lAReh7Gpm4nllScm4w+TixvGuzB44fFMjPjxBAs9cqZ6VPOt3/lE+F5V7twktx+xJmdGa5W
X-Received: by 2002:ac8:498a:0:b0:439:9c1b:ce93 with SMTP id
 f10-20020ac8498a000000b004399c1bce93mr403282qtq.12.1713978031476; Wed, 24 Apr
 2024 10:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423122518.34811-1-kl@kl.wtf> <20240423122518.34811-2-kl@kl.wtf>
In-Reply-To: <20240423122518.34811-2-kl@kl.wtf>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 24 Apr 2024 10:00:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xr6NsW085Sc+NhVmGDOn-zCCQ65CMNce_DsHxtXUgm9w@mail.gmail.com>
Message-ID: <CAD=FV=Xr6NsW085Sc+NhVmGDOn-zCCQ65CMNce_DsHxtXUgm9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] HID: i2c-hid: Rely on HID descriptor fetch to probe
To: Kenny Levinsen <kl@kl.wtf>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>, 
	Lukasz Majczak <lma@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 5:26=E2=80=AFAM Kenny Levinsen <kl@kl.wtf> wrote:
>
> To avoid error messages when a device is not present, b3a81b6c4fc6 added
> an initial bus probe using a dummy i2c_smbus_read_byte() call.
>
> Without this probe, i2c_hid_fetch_hid_descriptor() will fail with
> EREMOTEIO. Propagate the error up so the caller can handle EREMOTEIO
> gracefully, and remove the probe as it is no longer necessary.
>
> Signed-off-by: Kenny Levinsen <kl@kl.wtf>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 2df1ab3c31cc..515a80dbf6c7 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -894,12 +894,8 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_h=
id *ihid)
>                                               ihid->wHIDDescRegister,
>                                               &ihid->hdesc,
>                                               sizeof(ihid->hdesc));
> -               if (error) {
> -                       dev_err(&ihid->client->dev,
> -                               "failed to fetch HID descriptor: %d\n",
> -                               error);
> -                       return -ENODEV;
> -               }
> +               if (error)
> +                       return error;
>         }
>
>         /* Validate the length of HID descriptor, the 4 first bytes:
> @@ -1014,17 +1010,13 @@ static int __i2c_hid_core_probe(struct i2c_hid *i=
hid)
>         struct hid_device *hid =3D ihid->hid;
>         int ret;
>
> -       /* Make sure there is something at this address */
> -       ret =3D i2c_smbus_read_byte(client);
> -       if (ret < 0) {
> +       ret =3D i2c_hid_fetch_hid_descriptor(ihid);
> +       if (ret =3D=3D -EREMOTEIO) {

I worry a little bit about keying just off of -EREMOTEIO. If I'm
skimming the code properly it's up to the different i2c bus controller
to decide which error code to return here. Looking at, for instance,
"i2c-qcom-geni.c", I see:

[NACK] =3D {-ENXIO, "NACK: slv unresponsive, check its power/reset-ln"},

Maybe we should just use dev_dbg() in all cases here when we fail to
fetch the descriptor? ...otherwise I think some boards will start
getting a noisy error message.

..and confirmed that my skim seemed to be accurate. i put your
patches on my system and then changed the system to think my
hid-over-i2c device was at 0x11 instead of the normal 0x10. Now, I
get:

[    5.973417] i2c_hid_of 4-0011: failed to fetch HID descriptor: -6
[    5.979701] i2c_hid_of 4-0011: Power on failed: -6


-Doug

