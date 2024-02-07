Return-Path: <linux-kernel+bounces-56338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EB84C8E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80F92898ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D951D16431;
	Wed,  7 Feb 2024 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtiECEDE"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5D14A8E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302728; cv=none; b=u7Qmi5xD+HYrb4zHSNy9dq6peCXtLgpvxg44K7hCgZwFxLwnL7gm9cQgYMc3Y4uc7XfHQSDzHQIISEnbfqp+Q2AM+qFXk8FzNWyYPKKQUrrlyUSKnGSsX4Fj1Y4IusPpMsNJyEWNprKJppR3RRxl22yEvibDf2oV74G1tmcyz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302728; c=relaxed/simple;
	bh=zx/TbZQKImahNt+7vIsidHWjAMcFHpW7Q2SH672vuPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKojAgaA8guoPf7D0eqksdYQL8Yhb+MEw4l85TSEBLeBQwDsyiXeJQfLb6EHVuqk0J7KfkahKaee1t7rSwY9fhBqd55ycE2OjCrilt9Z55Gxlcfk9vT+bGyVhusgB+cxQIBSLoEJNW7Gcofs5KU7VW7+4JocB2/HDhf6GMicFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EtiECEDE; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60486805aa8so5195687b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707302725; x=1707907525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO1cuzbZEvcOb/xBKlHSWUgxNAB1xNrbQxxqm+U1OtM=;
        b=EtiECEDE0UqcYXS+z1UzJfqXswzfPnmc+QLPnFDi6dxcAp0w+C1LWKrF//Tj5S+031
         qhnkBOuxz21Amp9civCrfw9Z36Ke+/ytfbU9ZKWLiQjxlEwHBNiAAFBzNO7PGRDNMKGi
         gwT+lq0tcarHho5izVjN7BLXBGQ0fMqupVBKh2/MX601AxdkZxA0NkqT2puaS3DvuOI6
         10k8iB8EdxjvIAWb/vuhqvbK7WCfcIex8Fq2qwprHZ4Eb5gGDT/nIu6ewBbM9NJ27gc1
         ErZmQH/GothZuQuMrsOS82oMZEGWuVCGM1CEJFbK9aeCl02NxmOgWgBUXvr0DkcFqglp
         NWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302725; x=1707907525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO1cuzbZEvcOb/xBKlHSWUgxNAB1xNrbQxxqm+U1OtM=;
        b=XAoTKMuv335VNJIUoynV/boTTdOX/62Wx6ccClwJ5D+HBsX+iXeV0s9zuSgZVRCQtt
         L1GRg1J2JrZqvI+LbAd3PaXDwyduPr/yOhRl6c7Ixd/Pi8LVBbK7aD5mpDOjmpHiN0Uz
         tKAL3r4DkbVI6JO4z3ZXYvM6AkmrLua3yw1U96wSMEovEV3GbQvmVTo00fQNUUmbT6mX
         A3LbvGnc4dR9QJ4DQ/ovxPVR4Yj7AyAKF599qwUF6sKCg+9knEQNZ0enQmJ6hdxHE+9G
         9iLPKUmMh0JMBsmnNiYwCHKRHTP9zpXalJFdbmnIJUhObVWBXJuDcxJRY65BxWppUPvo
         Rs+A==
X-Gm-Message-State: AOJu0Yy6MyNDmR/kcsMEFVK+5INf5L5maijuVZ1Pm7YKRa9zuorJ6zNM
	0dWlmCWbK7tLFMJn5ShAffmivOVll2FRlXUD9wFqo6w8hD0AcVmDtSNvQfApVRUGq5T3jh+JOFZ
	S+Pdo3CHP96Qj8RfdHaxqgUopxdikTN2S6ad8vFVZ2NbKceeoVRM=
X-Google-Smtp-Source: AGHT+IE1ftODiv+xLOHecUFUm++aMHwfgZ7h08sXj2xrCeIg8UY/Uu1Wa7/7wK0TEDHsqKVhdSUcstbAlEEEvg9Ffq0=
X-Received: by 2002:a25:d050:0:b0:dc6:c3e0:82d1 with SMTP id
 h77-20020a25d050000000b00dc6c3e082d1mr4143050ybg.60.1707302725545; Wed, 07
 Feb 2024 02:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201162758.50733-1-brgl@bgdev.pl>
In-Reply-To: <20240201162758.50733-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2024 11:45:39 +0100
Message-ID: <CACRpkdbAw5NfSr8GSNiQhOzSi-tERyn=-ZroLfF-FRbsW2JviQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: set device type for GPIO chips
To: Bartosz Golaszewski <brgl@bgdev.pl>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:28=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> It's useful to have the device type information for those sub-devices
> that are actually GPIO chips registered with GPIOLIB. While at it: use
> the device type struct to setup the release callback which is the
> preferred way to use the device API.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
(...=3D
> +static struct device_type gpio_dev_type =3D {
> +       .name =3D "gpio_chip",
> +       .release =3D gpiodev_release,
> +};
> +       gdev->dev.type =3D &gpio_dev_type;
>         gdev->dev.bus =3D &gpio_bus_type;
>         gdev->dev.parent =3D gc->parent;

Looks good to me (TM) but we should run this by Greg so he get the chance
to chime in, I doubt he will see it on LKML.

FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

