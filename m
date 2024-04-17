Return-Path: <linux-kernel+bounces-149214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841048A8D41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D441F22E12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D4547F7D;
	Wed, 17 Apr 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LKnznURn"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC03D966
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386937; cv=none; b=kK1l3zLUExOgOISP+JUf1G9EpFM2vJnnJnnaRGj3fn1F/+U+lDjmqNo6Aqk68p94sKPzMc+d4EM/Bgt3sKumCADrb6mmsdctp5KL7M5g8rThEk08V4wx61/lRuIkf4AuzDx98X3I3qThcLhBsIjr0BzrokE5YFNqqUfAh9x31Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386937; c=relaxed/simple;
	bh=ORYpKCCPco9BsZmLehTJC39f1aThfzW07CoeCNcrPq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB8OeuRNPR2hnpkCItxjeGh+SjKO86vNAZLmzz8vJSVmP9aHoT0PCp5wACW5SPIZG5MMrcC0WBjjlIia2wfyD3FPYFF5LC9Ck9PCWwrzsFs8+QyNeN683t7RenbFgoaQemRG7meBrOVObVbTS9jWn7uNmaujaofBwuaP4w/FcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LKnznURn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518a3e0d2e4so187894e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713386933; x=1713991733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjgmJRjeO60SRDB0oJ2Pp2K9Z2QIcWbq/4i6csP1QjE=;
        b=LKnznURnoL28TOv0yeK/tcJvFMB8yFUwDxtvNm084/Yi8bJH0xw/zS0U0SpeEbUgWz
         g3IHucYwvGPfkWcLCSlLnKMYDT8xtcMMgTwU9tNJbQ1VRUSV+Xp1Q0ggde8Lso/IPXCM
         h6vc1o8aL2QseKcwy0l5089IVv6OjbHUVq2fJRaufLkNLcNJQfV7t+qQnIMMUa/a+Vxg
         ETcFOSNl3AkB6+DhNDVFdmFYUg22xPS1PHZ93x9rtkLJKsAtNQ8k5Cwm8zfIT/TdvLMW
         bxfUAeWSKRax7VFpYNbSKU5NkRRAF0Pi3FSPamt+7N2bKnfJ6Ee9E/p910wIXRqcMIiw
         X89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713386933; x=1713991733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjgmJRjeO60SRDB0oJ2Pp2K9Z2QIcWbq/4i6csP1QjE=;
        b=ENjW1drFDbxjJTVp5SAxRhANO8oGLOzeyvBq+vRY7u5paFERjaFwrYFcuZGhtbDsKL
         sXuYbF1fdes7wH/X3L2or9hLyPdIw2BDoE8weKAPjrg/zTEwMZxNCAB/1E8dOASbrvQQ
         TmaT4SRJPvDmgA32aru38fCksEprizlZfteE6nwaD0zIHR+ly0/w7ULTPHVeH0NQfKUm
         zVgb3b78PQPiZpNMOPISe1K3dMviPxI/lWEmXcqGfLmwq7wulAYkqL82SXNA9cyCWawo
         trLF1gIt6njQ+HkSWFTw0i2JcboabllIlwAG4Aw4qMTjBklnZvlm4RIpLkG2YvaTJMyU
         eXcg==
X-Forwarded-Encrypted: i=1; AJvYcCWbF/dvi1rKAsbazHUcqts1WEaVJEcChVKmElmH3y6916YjfBq4knAFlUyEK3SrV3tEnAWvojI2SGkv2INLarK/nDj62xZximPklSqM
X-Gm-Message-State: AOJu0YxKIxjIC7M+LXH73aV/uci5JyI/qRv5hnwjsHowfP0G+eRj9bQI
	aDz/U6pPcVY/32tsfQ4MKmDtIXjfok/i2DBvf3h+YykQsJuS628L3wFLxpqEDErb3PS1P6lIh8+
	+zEiRo0WoscByVXe5Yr5gDXRAb3F/0B8b7s4cpw==
X-Google-Smtp-Source: AGHT+IHcqxh9ROeyHiMPpqEPKTaldD80WfMEcSrhIQuy47rBkDPzOmHiCobO3e/Ek32Xp+msA0OAPMdRC7nTfy3Fpyg=
X-Received: by 2002:ac2:48b0:0:b0:519:1c25:7759 with SMTP id
 u16-20020ac248b0000000b005191c257759mr66768lfg.1.1713386932915; Wed, 17 Apr
 2024 13:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417141914.2905621-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417141914.2905621-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Apr 2024 22:48:42 +0200
Message-ID: <CAMRc=McqBBFEHksn70wraWy2Oh20Scur6KQzRvhuKr=ja-_sRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: swnode: Remove wrong header inclusion
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The flags in the software node properties are supposed to be
> the GPIO lookup flags, which are provided by gpio/machine.h,
> as the software nodes are the kernel internal thing and doesn't
> need to rely to any of ABIs.
>
> Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/gpio/property.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.=
h
> index 6c75c8bd44a0..1a14e239221f 100644
> --- a/include/linux/gpio/property.h
> +++ b/include/linux/gpio/property.h
> @@ -2,7 +2,6 @@
>  #ifndef __LINUX_GPIO_PROPERTY_H
>  #define __LINUX_GPIO_PROPERTY_H
>
> -#include <dt-bindings/gpio/gpio.h> /* for GPIO_* flags */
>  #include <linux/property.h>
>
>  #define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

Applied, thanks!

Bart

