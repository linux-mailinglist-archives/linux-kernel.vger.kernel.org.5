Return-Path: <linux-kernel+bounces-74-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCD1813B94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786171C20ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6946A356;
	Thu, 14 Dec 2023 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C7c+FnRY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB4433A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a22fb5f71d9so208921866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702586047; x=1703190847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deJfGFzyJNks7N/BltMI7GtIwHuIoyf8Os70wSNeWV8=;
        b=C7c+FnRYfu8bKUDQOOPWFAeI9HwHEscuQBJs7r/CgZBwIZEXH9CTPd/XjbKdYpt1AW
         r0lQjId1YSNJGsXONJyvKKUwdwW7OoG2JawAqPZ3ipvklIjoNqRMtpy19xCJnEi9K9AC
         yz/8jyBaz/oWznwfYbqsiosWjCQdnHO+L19fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586047; x=1703190847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deJfGFzyJNks7N/BltMI7GtIwHuIoyf8Os70wSNeWV8=;
        b=tTpxH3DRqZp9+NhkWV3qNwHAR0080t2+KxiiS9DMrvn2ouBKt2fQfrWFwElhYhGM36
         pke2IAopw+gC49dTayIYhlbqgwqRMoSmhMfQ2FC/rtjZCYiiz0ivxMnurna5Ad0zV+Nv
         S94eJm5zgtLHQ41DpnTLSj60M0bML/63fchno4X9jnaeeYrlRwfQ4HjXHhD/JFwEfydP
         kB8RDwGnCXfRmqb9MUzj+x0IuyFUoAmPcEcoemh1bxs2lF0janfGU4JqNt+R+KVLUSw3
         EqLt1G58HV47A8mFQkR+JGAFLX4lk4P/2yCGc3+roCk6xkrPM9iS0NsjpDRArdbOszIb
         j+Jg==
X-Gm-Message-State: AOJu0YyqTI4s2SMLUfeAjPYOVNgaKuSaVDfTCjBcr0JwmUL/LG1y/6wH
	Noq29ILjkzS+XDnTr9BfSb8KiELKU5yE/QlxTYFlz4Ku
X-Google-Smtp-Source: AGHT+IFVTBa0rbzd3cnQkrjCTylQEcjiq+HnKB2SYGPBAE0bgGIAw1DCh2CDLHhsBaXmt5mkg/lUIA==
X-Received: by 2002:a17:907:2723:b0:a1f:8149:558c with SMTP id d3-20020a170907272300b00a1f8149558cmr9284148ejl.30.1702586046983;
        Thu, 14 Dec 2023 12:34:06 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id tp5-20020a170907c48500b00a2304386f4bsm2668841ejc.211.2023.12.14.12.34.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:34:06 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5529df1d4d1so1557a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:34:06 -0800 (PST)
X-Received: by 2002:a50:d643:0:b0:54b:321:ef1a with SMTP id
 c3-20020a50d643000000b0054b0321ef1amr706322edj.6.1702586046109; Thu, 14 Dec
 2023 12:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214123205.v2.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
In-Reply-To: <20231214123205.v2.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Dec 2023 12:33:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X=UCn55Z9vYpis41GwQowFBjM+L5j6tO-dC7nWRdX7tQ@mail.gmail.com>
Message-ID: <CAD=FV=X=UCn55Z9vYpis41GwQowFBjM+L5j6tO-dC7nWRdX7tQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: parade-ps8640: Never store more than
 msg->size bytes in AUX xfer
To: dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philip Chen <philipchen@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Boyd <swboyd@chromium.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 14, 2023 at 12:32=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> While testing, I happened to notice a random crash that looked like:
>
>   Kernel panic - not syncing: stack-protector:
>   Kernel stack is corrupted in: drm_dp_dpcd_probe+0x120/0x120
>
> Analysis of drm_dp_dpcd_probe() shows that we pass in a 1-byte buffer
> (allocated on the stack) to the aux->transfer() function. Presumably
> if the aux->transfer() writes more than one byte to this buffer then
> we're in a bad shape.
>
> Dropping into kgdb, I noticed that "aux->transfer" pointed at
> ps8640_aux_transfer().
>
> Reading through ps8640_aux_transfer(), I can see that there are cases
> where it could write more bytes to msg->buffer than were specified by
> msg->size. This could happen if the hardware reported back something
> bogus to us. Let's fix this so we never write more than msg->size
> bytes. We'll still read all the bytes from the hardware just in case
> the hardware requires it since the aux transfer data comes through an
> auto-incrementing register.
>
> NOTE: I have no actual way to reproduce this issue but it seems likely
> this is what was happening in the crash I looked at.
>
> Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX chan=
nel")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Still read all the bytes; just don't write them all to the buffer.
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 8161b1a1a4b1..dfb97fbb5be6 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -330,7 +330,8 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_=
aux *aux,
>                                 return ret;
>                         }
>
> -                       buf[i] =3D data;
> +                       if (i < msg->size)
> +                               buf[i] =3D data;

Ah crud. I just read over Stephen's response again and realized that
in this case I'm returning the wrong length from the function. A v3
will come shortly.

-Doug

