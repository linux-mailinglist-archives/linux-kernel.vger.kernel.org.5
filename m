Return-Path: <linux-kernel+bounces-131359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA428986B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5119E28D5CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707AF85264;
	Thu,  4 Apr 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOGF+/Zn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217984FD4;
	Thu,  4 Apr 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232063; cv=none; b=G0ZIoQ+oSiyiY1K7KNxIRNlh28ujIAgX9GEEyNDIL2mwa2IbRBrcBkjEQsQag7LnEaoxO+83e1ARsG++qtpDfs36hRZi01mmed/Vq7siIh2Z8cngi/iTCDR1x7Huy2qkNjKtwzou0xHCb8m5X3y87MBBElVICYe813+aapd8Rhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232063; c=relaxed/simple;
	bh=Aqeqvw4GrvT18e980JUpO21rtv2qBW15mhfK8EzHsvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Na70TxuYkDB65Z8YXOh3vy92mefAWhEj5//XqXSqj9GsXYtBhPVYw1EPzlMDCjvH8mK0kABP+cbVKu8pT6cJT9f0xYDMLZ5G1ycMcTTcVa9QN2SQd+J+gC+bpVukooMYf8+Tpe+yGLqSHKgnGZpE6fC7N2gwpCFdKOMTIL0NVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOGF+/Zn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2178b2cf2so7866425ad.0;
        Thu, 04 Apr 2024 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712232061; x=1712836861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL4i2rxVSO4Dx2Z9A/DMCu9nioCZUVI1YGXCUgVZyec=;
        b=FOGF+/ZnEOR3ylocD/3UAgQUSu5k4swk5sdbNcjNvN15GsLjR09ummw3pEQm6lf6st
         E9K5y2x53vH5VseLux3zfbz8ewsXkyY3sAlz9Qx8BPedJDJE0w0fklwvpsYU+FjZcu8a
         pFBRhDo/GOEys99km8ZP8/NnqMn6Ar150eHs2rSNOI9kC2+0A0cE+H5V4w+pvCXUVMv1
         mW3fzRGGjUjNQhbzftFOKij8CrUbJ4imJ9k742VUcvqg+/DAsHFulDXeaFrchfylyY6H
         OlBgQnpCiSO8oxT0W0v/M1+NxcJtc1cJxV+KiexsRJf5bK0hH9XdOw2zbacUF/YhoTnF
         bWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712232061; x=1712836861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL4i2rxVSO4Dx2Z9A/DMCu9nioCZUVI1YGXCUgVZyec=;
        b=TYmOJQmWmy1GgZvqQMql+t1Zl4XQjacTAc9hyuflmo1Mu4lyhFmi2q7wV01fwOLgHX
         1DOySzUwZPh/NSZYNRtpyTVpnT9VXK+YjZryEii8V6vJyi4EuCYQdl6TgHkSK6HHNGDW
         YrOvW2xBKOo1zBsjooaEMwvBHXie30HjQbNZeELEEsZZNlH4H6YmMMWEkJNSem7k6gSM
         +dHrnArJmLk6mX97CtGrhqr1c2IJuTLjdv+VX3Wao5TPY6KUjpntiXFkAOEBgsKqnvL+
         MY14zD9bG+2GcrLmL8By3vq05WPyoN2pIxZQ/tmDGfkoUFPhz5104H3zZfo1oR46LG2c
         URbw==
X-Forwarded-Encrypted: i=1; AJvYcCWCX6PuDHXSUP8379vjf0UUre12hLJC42HbA7JvmXevafjs1fDz8RkzOFAJ+Vzvjrk2l3DeMSnzFdl/oTRDxgsANV+ZlVPHlgtZPkmHZFV9xfGIKI1TNa6SZ4SlHObmWsLHIvBhlVwWjw==
X-Gm-Message-State: AOJu0YxZbdeZ4Ip5cZa33mm5ByHg96OVR3BAhdPm2WIeIT4UN7LUkRgz
	3PBOhn5KOqkqy/qrsWkYffSokNCyiMBwTqfIzSxckjrlCnbY80f2N7y7vRSQCsRQTMdyJd1eSmQ
	ZKvnV+ke5M8Wp81jmGc5riEc0yZw=
X-Google-Smtp-Source: AGHT+IGcM7phzQ4a6LWlb+ZbUy46QOrWqPtD6hZ2VF2T8uxuZk2nkBNtUNgHlEIleOyY0tflROY1ahFFF1Z2hTRU4SA=
X-Received: by 2002:a17:902:7282:b0:1e2:7356:aa31 with SMTP id
 d2-20020a170902728200b001e27356aa31mr1882050pll.34.1712232061199; Thu, 04 Apr
 2024 05:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305004859.201085-1-aford173@gmail.com> <20240305081816.GF12503@pendragon.ideasonboard.com>
In-Reply-To: <20240305081816.GF12503@pendragon.ideasonboard.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 4 Apr 2024 07:00:49 -0500
Message-ID: <CAHCN7xKwScoXouUHyH=dPZ0fgibmEUXRFwFPUF8mdKMf8YNA2g@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] drm/bridge: adv7511: Allow IRQ to share GPIO pins
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, aford@beaconembedded.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 2:18=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hello Adam,
>
> Thank you for the patch.
>
> On Mon, Mar 04, 2024 at 06:48:57PM -0600, Adam Ford wrote:
> > The IRQ registration currently assumes that the GPIO is dedicated
> > to it, but that may not necessarily be the case. If the board has
> > another device sharing the GPIO, it won't be registered and the
> > hot-plug detect fails to function.
> >
> > Currently, the handler reads two registers and blindly
> > assumes one of them caused the interrupt and returns IRQ_HANDLED
> > unless there is an error. In order to properly do this, the IRQ
> > handler needs to check if it needs to handle the IRQ and return
> > IRQ_NONE if there is nothing to handle.  With the check added
> > and the return code properly indicating whether or not it there
> > was an IRQ, the IRQF_SHARED can be set to share a GPIO IRQ.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>


Gentle nudge on this one.   It's been about a month, and without it,
it is preventing hot-plug detection on one board for me.

Thanks

adam

>
> > ---
> > V2:  Add check to see if there is IRQ data to handle
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_drv.c
> > index b5518ff97165..f3b4616a8fb6 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -477,6 +477,11 @@ static int adv7511_irq_process(struct adv7511 *adv=
7511, bool process_hpd)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* If there is no IRQ to handle, exit indicating no IRQ data */
> > +     if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> > +         !(irq1 & ADV7511_INT1_DDC_ERROR))
> > +             return -ENODATA;
> > +
> >       regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
> >       regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
> >
> > @@ -1318,7 +1323,8 @@ static int adv7511_probe(struct i2c_client *i2c)
> >
> >               ret =3D devm_request_threaded_irq(dev, i2c->irq, NULL,
> >                                               adv7511_irq_handler,
> > -                                             IRQF_ONESHOT, dev_name(de=
v),
> > +                                             IRQF_ONESHOT | IRQF_SHARE=
D,
> > +                                             dev_name(dev),
> >                                               adv7511);
> >               if (ret)
> >                       goto err_unregister_audio;
>
> --
> Regards,
>
> Laurent Pinchart

