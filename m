Return-Path: <linux-kernel+bounces-155856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5F98AF816
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC91C2218B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B3142E8A;
	Tue, 23 Apr 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GGcpfzFY"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6FB142E73
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904653; cv=none; b=iZLkQT1sStlVzuLxEOWbQBUZ0ErG6iqk5A5rULzNPMU2D5DJUkMUzv9NBm/LfkNV1jf6dMFOXeAy6TKVFb93hqT3+CTkcuPm4jk9mzWx3ukfuvWCmOKBijHEv2tmyNjdoDGm6UY6FHrhyHHcl4w7Na/q+3UOK1vebgTvJemdmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904653; c=relaxed/simple;
	bh=rfhmOs1XODOFJs1l4DWhrD2bkxios+soWFbzgeUP8Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEAR/3IVDR9/e7cSx5cGy3hVIwDQWqzFC4xXT86XbWw80P3+Sgn/Njz1UmCuBlat3eWB+5j7G3DyLfTAox+IE1RqLUWv0mqmxTYeXnE8nUyBEZmZhkDEaIS39KprI3628sdbVfSflUJ3hIGoIvKRq0jTO66N3vz8/2/mEUFJZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GGcpfzFY; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-618874234c9so66144567b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713904648; x=1714509448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8Z4Xephtak0B6Z0C10bXQoxaaScZEGJ8HuSBBJAqAk=;
        b=GGcpfzFYUJLBQnGwSWyhreb9yGqz7lbtwpIgktXrvLVkfuvg7TR1hSgevNYM5o8fSw
         0hWI/PJImoPnWf2/NEzwsFT0YHTJiRw/BFgL2TB/VOCic+WezZ9A3mrJCzMSUH3jkSOo
         PbeqMME/OMN0P1zVcHGsRElSpFyiIuJj75cIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713904648; x=1714509448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8Z4Xephtak0B6Z0C10bXQoxaaScZEGJ8HuSBBJAqAk=;
        b=BlLzshhjnJa/NkatElbpzR5hBaX0BUcztvLgBoRLQqMzrYLZQ/KCfpDA+t+rAByMzk
         HGlcmsZjqAnr8o/xcow8CQwawWdLWDcVJoEcY10wngZ8t5JJu3Osc6QNYrglblamHsHk
         UbCmWOqZIxsbhiS9eAWsWYjEIBL77CfpqjwhFd/jwGQ7+wRLvZRxDt9XmbDJOKB41foa
         CI/97CgW/bS8IfKc4yGAg302WkdebYj7YZhwbXVa53uu3rTiepvPfe2gictygQWd3CEK
         1fbOkfcfLQP79wkL5vj9w9iDh8QYaRhzxlCqJnqn0G178uye+PUy4hM+qHteRiYQH8jq
         YbTg==
X-Forwarded-Encrypted: i=1; AJvYcCUgXnQrhK+D21DnmnnowJp7RdEVT7bNjbKDx2rbn5c3Q1pCW4MfZp89p4IpjJIlWXyDLmMRyqrvfGbGUrdDJK8c65cB+3X/q480kVNT
X-Gm-Message-State: AOJu0YyGBobZVWlZbQwNbdv8sDi3BAC9wDAnyVgPQ2I1KDXq7WiROYWC
	ySDhRzChMtxjXJkQlgv5RtR9cWGzGB2670C1YaD/ZGc+EcKArz/0XJl/qRkYjx99ySe5+XGCvo5
	7dwRA
X-Google-Smtp-Source: AGHT+IHzC0tXgyntV6LFl1jxEPjFfB/NknTDFxLpWioOqJu/rlkMHGoZWxKJFDReFR6UcQVqb+iUcg==
X-Received: by 2002:a05:690c:6486:b0:618:1034:f4ef with SMTP id hs6-20020a05690c648600b006181034f4efmr661376ywb.16.1713904648279;
        Tue, 23 Apr 2024 13:37:28 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id l6-20020ac87246000000b004369f4d31f2sm5499525qtp.50.2024.04.23.13.37.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 13:37:27 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-439b1c72676so30771cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:37:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxe+zpMRbem6o6w6CL4p5hIL30qrMjixYwydg5Kj95M87CRASB4/gApuICcPBR8BUaZQn4BdBca81NY8N5i+r7fmO46P4GX0EiebYu
X-Received: by 2002:ac8:48c5:0:b0:439:9aa4:41ed with SMTP id
 l5-20020ac848c5000000b004399aa441edmr71354qtr.16.1713904646630; Tue, 23 Apr
 2024 13:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134611.31979-1-johan+linaro@kernel.org> <20240423134611.31979-5-johan+linaro@kernel.org>
In-Reply-To: <20240423134611.31979-5-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Apr 2024 13:37:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XP8aCjwE3LfgMy4oBL4xftFg5NkgUFso__54zNp_ZWiA@mail.gmail.com>
Message-ID: <CAD=FV=XP8aCjwE3LfgMy4oBL4xftFg5NkgUFso__54zNp_ZWiA@mail.gmail.com>
Subject: Re: [PATCH 4/6] HID: i2c-hid: elan: fix reset suspend current leakage
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2024 at 6:46=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> @@ -87,12 +104,14 @@ static int i2c_hid_of_elan_probe(struct i2c_client *=
client)
>         ihid_elan->ops.power_up =3D elan_i2c_hid_power_up;
>         ihid_elan->ops.power_down =3D elan_i2c_hid_power_down;
>
> -       /* Start out with reset asserted */
> -       ihid_elan->reset_gpio =3D
> -               devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_=
HIGH);
> +       ihid_elan->reset_gpio =3D devm_gpiod_get_optional(&client->dev, "=
reset",
> +                                                       GPIOD_ASIS);

I'm not a huge fan of this part of the change. It feels like the GPIO
state should be initialized by the probe function. Right before we
call i2c_hid_core_probe() we should be in the state of "powered off"
and the reset line should be in a consistent state. If
"no_reset_on_power_off" then it should be de-asserted. Else it should
be asserted.

I think GPIOD_ASIS doesn't actually do anything useful for you, right?
i2c_hid_core_probe() will power on and the first thing that'll happen
there is that the reset line will be unconditionally asserted.

Having this as "GPIOD_ASIS" makes it feel like the kernel is somehow
able to maintain continuity of this GPIO line from the BIOS state to
the kernel, but I don't think it can. I've looked at the "GPIOD_ASIS"
property before because I've always wanted the ability to have GPIOs
that could more seamlessly transition their firmware state to their
kernel state. I don't think the API actually allows it. The fact that
GPIO regulators don't support this seamless transition (even though it
would be an obvious feature to add) supports my theory that the API
doesn't currently allow it. It may be possible to make something work
on some implementations but I think it's not guaranteed.

Specifically, the docs say:

* GPIOD_ASIS or 0 to not initialize the GPIO at all. The direction must be =
set
  later with one of the dedicated functions.

So that means that you can't read the pin without making it an input
(which might change the state if it was previously driving a value)
and you can't write the pin without making it an output and choosing a
value to set it to. Basically grabbing a pin with "asis" doesn't allow
you to do anything with it--it just claims it and doesn't let anyone
else have it.

-Doug

