Return-Path: <linux-kernel+bounces-47993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B22EA8455DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F44B21CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124AD15CD5C;
	Thu,  1 Feb 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="eShVOcAM"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965A15B973;
	Thu,  1 Feb 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785045; cv=none; b=abr3rwNokHf8Xaf/+gDHLhAOgXuHAHE1lbiJbaKhmS+yHvRJmSecf6G5XVIEQzVaDlTl6Zlmyszq9tr1S/b6JZoWQWZdcP1y6rFA4v6E0RzF/pYmM5YqRCZiQnoO9bIWl+6pRNvQ2G8Hy7J1XDjBQ1MS8gWiN5CAfD5XAfh91qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785045; c=relaxed/simple;
	bh=TobCazIkkY/DGv6KVites0C1Weh4sD9kwXNvynrufss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eIE1tD3khz7n8+YRyDw79zundERn0eMY6vLYbrmohcSxYB9HjmwT6aWDsnCovJrHxhO7ps6dKFMPyph6PkGoNZzFdzbUa1tOq7qrxYI9zNq+69Jou7mMBDKB9iR+ccLc7QwXSFX2BtAfiEf70/glCnRbpnfV8E+9MiRrGzLsra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=eShVOcAM; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1706785029; bh=TobCazIkkY/DGv6KVites0C1Weh4sD9kwXNvynrufss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eShVOcAMm+cB+X0RWgH5IO3/4QM6fJlOkepkyv9YFeLf9Ubga5dDB0QYXpoKJIYWD
	 zTXLuhWsmkSJv1OJd+fZUH9O3184GgJ97cZCPTDO4GEtQyOLZ61hjV9KNHlfkdGZrt
	 sqy496ZNlUE9OaYrNn126NvH86DetjmwS0NO+BjMN2wbhFyZfHzKkAn6fQeCDmTuiN
	 ucFXyauK26qHskcEJgfY/rAbaeBHTQsyEh5x0o+sWJyypkOvrdeqV4J1RmzNGWV1MG
	 U6rIdftsYYAsUSiCaIvDkMGxKiWXT/l4L/L9bLTgHSqESniazOnDVhW/oJWjuogy1C
	 D35hkn76NvQyA==
To: Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@kernel.org>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin
 <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Lee Jones <lee@kernel.org>, Brian Norris
 <briannorris@chromium.org>, Srinivasan Raju <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, Linus Walleij
 <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
In-Reply-To: <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
Date: Thu, 01 Feb 2024 11:57:09 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874jeszc3e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Linus Walleij <linus.walleij@linaro.org> writes:

> The ath9k has an odd use of system-wide GPIOs: if the chip
> does not have internal GPIO capability, it will try to obtain a
> GPIO line from the system GPIO controller:
>
>   if (BIT(gpio) & ah->caps.gpio_mask)
>         ath9k_hw_gpio_cfg_wmac(...);
>   else if (AR_SREV_SOC(ah))
>         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
>
> Where ath9k_hw_gpio_cfg_soc() will attempt to issue
> gpio_request_one() passing the local GPIO number of the controller
> (0..31) to gpio_request_one().
>
> This is somewhat peculiar and possibly even dangerous: there is
> nowadays no guarantee of the numbering of these system-wide
> GPIOs, and assuming that GPIO 0..31 as used by ath9k would
> correspond to GPIOs 0..31 on the system as a whole seems a bit
> wild.
>
> My best guess is that everyone actually using this driver has
> support for the local (custom) GPIO API and the bit in
> h->caps.gpio_mask is always set for any GPIO the driver may
> try to obtain, so this facility to use system-wide GPIOs is
> actually unused and could be deleted.
>
> Anyway: I cannot know if this is really the case, so implement
> a fallback handling using GPIO descriptors obtained from the
> ah->dev device indexed 0..31. These can for example be passed
> in the device tree, ACPI or through board files. I doubt that
> anyone will use them, but this makes it possible to obtain a
> system-wide GPIO for any of the 0..31 GPIOs potentially
> requested by the driver.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This seems reasonable, thanks!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

