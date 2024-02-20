Return-Path: <linux-kernel+bounces-72588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759B85B59C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39ABB249FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9D5D46F;
	Tue, 20 Feb 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcO0biqs"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D785CDF5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418494; cv=none; b=MC8XdYiDujXz2+HtooftSjrBbsY4ka7QPbqftLH4EqCrxLo39AgPfjZqVTidfcEEOcKI69JytcOOd/6Kvi0LnYfIOY4+CNw7enonH24jYq/DNwh4tQyTa2DZmqQIvmlY3tFCFfLwV2t4GhUYPBlpA+VCWLMKYYJkOY4WwwE8kzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418494; c=relaxed/simple;
	bh=9ekC5HPUrNoy1GRhN2rh+bxhzXxfKFqMFqA2kvueEWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqWYnndqOu3FB4vbzlv7MrFJ92FIBZ7VlpW0EKqtOcF/IDeMJqGX5iJg6KhzKcUkc2bAVioeWw8mZRPJwyAOrao4K143V9M7sPtKwiTUO/nKqowcWHuU+BwCq7B/m2PN1UIF59O29jo0MmSpf+/E8a6p3o0EioWAIDnlwMkKRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NcO0biqs; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4885692276.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418492; x=1709023292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dFgumD1yW7PVeRFLqgU/aWZ41UsZ2fN0lPKRULxgCQ=;
        b=NcO0biqsEW4dHVNnDhtCyWagLTGXbJ5qy6N+NIrYT80hhK7T71IuPAIOvc5YL/lPjr
         Zl7npLToWb27NRhfBYJxQ7BbQ0x7ayrCVc1tuvnjGCCDdN9B5EIBCAW7gXxFkVDiUCkG
         TOnYsm9dv4yhgIdMi+XGaHAk2vyqGzS0J+JLcPqN6U1m8fk3h2gvo8Obbv3wC5QtVoWT
         /cCSLqHFx+sz9GSUDpvQed5KkzWQg5OoN/lpFZnSg7Yh2a0RbDzCb3LNwYsc1blCxa7C
         YVveebZHEH1uwencX3ZuIaLOTipmd5xu2+H03NA/Lzv4wPlbmLYs9I2enMrgDSl0L9VI
         OCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418492; x=1709023292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dFgumD1yW7PVeRFLqgU/aWZ41UsZ2fN0lPKRULxgCQ=;
        b=W/XxBYntwnYWVgsq/bekGhQ22VNwN95JQfEieOCbjchO+ty58nZ1kiv05fYiNMq07T
         KZ6XknpdYHNmDQTp4TsB6TgoE9eO3Hj89kJ5pUw6Uyzar7zztz6z8Tr4jrl+eiHzJN+3
         /HJq2z3wB9Sa7qt/cD9978qHXdDlpchjSFYdMFL0kMCCRFlHwsPPdyE7/kJEX+pJ3TiA
         aHnAy9qi5cSx8N6NCpea7S1bU5wrtio0AIOMii+amjlY/PvEuquc9g8itIfs93XV9PO/
         G8cozwUMSAW9SYNYU4kF1mT8urKhFfJJOea1G/e/MS/IxE8yUi1KAOxBPC4hwtK1Km4d
         /gcA==
X-Forwarded-Encrypted: i=1; AJvYcCXZXrAWHF3QcSRFgzKg4OYNyK4IdY4Bgz3/ZuOhQGpgL9rd9cvH1QKB7qDFV16MjCjP63UxCB3624g+UGpJAqTQTj7CiagHyIfiKWsB
X-Gm-Message-State: AOJu0Yx8dPGPt+r3HXkap+fYK145aR6CCctGKgh5ZZMirYtn33KXrDhu
	bJ2eKVhrJOad10uRre+BIeAvxlfzdCD/joVnoo2sUCmiuPTO8AnXNZiPHG56X03pyyPHjhxLxzG
	tknWDEFqxoXr6waFTIZdybyupb8Lp76HhLQOqUw==
X-Google-Smtp-Source: AGHT+IGkyNRR+Ep1c+zqGzNk1FdvaWZCNuQOs62IuTTBhudvJEy8KFTcyFT+jHplQ6yoG8h4Pf4T4W+DiwE1IXhV5T0=
X-Received: by 2002:a25:e0d5:0:b0:dc2:470b:887e with SMTP id
 x204-20020a25e0d5000000b00dc2470b887emr14147504ybg.21.1708418492204; Tue, 20
 Feb 2024 00:41:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219172514.203750-1-emil.renner.berthing@canonical.com>
In-Reply-To: <20240219172514.203750-1-emil.renner.berthing@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:41:21 +0100
Message-ID: <CACRpkdaS3oEyQjuHK2LVKKGws8CEdgzhWVGEfjJPY+a0ndt0-w@mail.gmail.com>
Subject: Re: [PATCH v1] gpiolib: Handle no pin_ranges in gpiochip_generic_config()
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jisheng Zhang <jszhang@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 6:25=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:

> Similar to gpiochip_generic_request() and gpiochip_generic_free() the
> gpiochip_generic_config() function needs to handle the case where there
> are no pinctrl pins mapped to the GPIOs, usually through the gpio-ranges
> device tree property.
>
> Commit f34fd6ee1be8 ("gpio: dwapb: Use generic request, free and
> set_config") set the .set_config callback to gpiochip_generic_config()
> in the dwapb GPIO driver so the GPIO API can set pinctrl configuration
> for the corresponding pins. Most boards using the dwapb driver do not
> set the gpio-ranges device tree property though, and in this case
> gpiochip_generic_config() would return -EPROPE_DEFER rather than the
> previous -ENOTSUPP return value. This in turn makes
> gpio_set_config_with_argument_optional() fail and propagate the error to
> any driver requesting GPIOs.
>
> Fixes: 2956b5d94a76 ("pinctrl / gpio: Introduce .set_config() callback fo=
r GPIO chips")
> Reported-by: Jisheng Zhang <jszhang@kernel.org>
> Closes: https://lore.kernel.org/linux-gpio/ZdC_g3U4l0CJIWzh@xhacker/
> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> I didn't add your rb since I don't think
>   if (IS_ENABLED(CONFIG_PINCTRL) && list_empty(&gc->gpiodev->pin_ranges))
> will work when the pin_ranges member is only there then when
> CONFIG_PINCTRL is defined and it seemed like your rb was on the
> condition that I used that.

I was wrong about that!

Yours,
Linus Walleij

