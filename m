Return-Path: <linux-kernel+bounces-100191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47F879358
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BA028528F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D042379DC9;
	Tue, 12 Mar 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZENlQaD"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106179DA4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244378; cv=none; b=VsGJ1987oKhNMfGKztt1jqfUddPjN9+BRk3WWxWb3EjOfkGl2qYTXpE4/PLMESrqDXtpgZkYYa7mS17a9f7o85Ev8zNG3UNGHqbJGgy6lmOvXuPlv4IJsAFIFUYQdtyqrf8SYcXJGmVoRO2C+A6tNGMAJ780dFY1vW+r+f/WqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244378; c=relaxed/simple;
	bh=JWULMh7o9qtF+RsBiOf3B41hJfHZ1YtSIOHKt7eEqF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHSbk6jMGoJ1M3aOApO0AI+OX7FVr2m/w/L7kVdpT2ofupY3RP45ge827NlEl03lHrQ/YmBycwMWm0cCZsktuFNuVLDNuN8ogubTDU2VAolyIw8zEwsR/Nk2P9W14Md0Md905zUESgtDzSSiDRDWVc+4F0BuSqVdD9SB8txNH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZENlQaD; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso5327873276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710244374; x=1710849174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYh9NgFiUlDSRFh0N6tnk2Yai7KZlV9KzVjtJmtqPwA=;
        b=yZENlQaDzlx/kvHDBhrtvkA4pnGAmJ+dTWbp/c6NJHi5zG5fb1aQWnofvuCtgwEoXx
         f526ph+FDmbKC6AiAadWwltrVIGGLNA5zMW9KJQM3nipF4ssFV2K2GGRwqPcouDt16Qu
         QLdkpSFfvRx52yqkWDMvfaaInDlwACBbbsu/4TEo7JLu1Ym2HruaiwAFw01S0KB9LQf5
         xZOGEgQB+VwyfwMzydkXkBQMaD2BkCMn9c1I8oMalsLNOh4F0u0dC/ONrWFX4HoGCqAx
         bn4Lx9X6HOiUiIJ2xUDI6yeLwR7YRPzRZd9WW9hsTWBofm6T+wU9qy7TUOP+JXfybLUe
         WkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710244374; x=1710849174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYh9NgFiUlDSRFh0N6tnk2Yai7KZlV9KzVjtJmtqPwA=;
        b=Sxzn3KcOcae+qlIU+dFsCBikwGnGU0+O1s6EwzyLXh7JAG0h7ikDJO28rys+bq4iL6
         4lBLzfi/8g8T549MHJr0hDMp2P3z0uFHSHAmSJGzKtFonLxZz2p8rgf0YCtmkRebKjEW
         S0OsMu7r5vDa5cJbXK9jIK2UXaWUSwMOYNB3mU3IqfhcOVQxxKLjkwfpAgLwZRWxveU1
         Eu88JBaUV/ISHFaezJDPwEXP7zEp5X9vsfidpR/HlFomTN60+6MH/3nZuVeHeId7aIGw
         7YHa/rGV6KnuML94K+7sVC2YOq3/FtfLw2XjZWIF8rt+BkahBY50UnWq4Nqd4tofHdtU
         e81w==
X-Forwarded-Encrypted: i=1; AJvYcCXdlCSZZ0k2wrPbmlUeaDAKSzsh+IkvRTmSiHtwUGP74iCFBl/T8jkwmrMbKt4OrMgnKAzL2QebWfzz3bEp/ua9Kv5Xty2dbFWorKZt
X-Gm-Message-State: AOJu0YypfdQBQUffEX3eRl/6uHsqDJqw0VADvcupd8X9mcJV4PQxmePa
	Bh0v1t45r9anzNiWjxNbJVebwW7Wpot3OxwZeZrOjzqP/vDzKoanbrTpNztvezp21i2Hekxit7i
	K3N8cn8t7d5NnYmpG+Ey3GGoqSEYw304whqIp6g==
X-Google-Smtp-Source: AGHT+IHM4+XkGrEr4TR1Ej4v7sv8rnNzednJ2Q7ydm5WMikNndCuOBWPz9jPurIvtRqHtOuQiNrGRxmNT6kHIFbRmWU=
X-Received: by 2002:a25:140b:0:b0:dbf:23cd:c05c with SMTP id
 11-20020a25140b000000b00dbf23cdc05cmr6527345ybu.13.1710244374125; Tue, 12 Mar
 2024 04:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae643df0-3a3e-4270-8dbf-be390ee4b478@moroto.mountain>
In-Reply-To: <ae643df0-3a3e-4270-8dbf-be390ee4b478@moroto.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 12 Mar 2024 12:52:42 +0100
Message-ID: <CACRpkdYtiyHgvtPJYxq2BNb9UxthwPQPHyUddQ5Q1eat1NY4XQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: nomadik: remove BUG_ON() in nmk_gpio_populate_chip()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 12:00=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:

> Using BUG_ON() is discouraged and also the check wasn't done early
> enough to prevent an out of bounds access.  Check earlier and return
> an error instead of calling BUG().
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks Dan, I applied the patch to the pin control tree since the
rest of the stuff is resting there and Bartosz already sent his pull
request.

Yours,
Linus Walleij

