Return-Path: <linux-kernel+bounces-28809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF483033A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7011C24D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E51DFC6;
	Wed, 17 Jan 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MpANVDJj"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923714AAE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485869; cv=none; b=tSzR3b7jThsCqy8facplZ4sPBItGqd5sHooHtI65f7hYkXbLITeGLI25wQtwqQaHr4iHy0cCvjS3GgUJ0l8KVw+UcfndhR1qRb/k80yY9u3fWcbNiggedvUXdxAdvh5hb+KD9bfbZJQ06Z/do+1Bg+OcKpf1hmOuqpz9nES4Uq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485869; c=relaxed/simple;
	bh=M3XhB67hkee2VxQJe2LsmfTQvglnPp488Z+xL8kMgwM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=PRIDf4SWk/CBaGXpYMAgl9Yxg7ozwOGdjfcwSi+krDC4PKj62TICbT7es1nPQSsZHRgQ0b5KUsCOQazWOjQi8WKDd66kzdrO/7VqYBHw0R/CWyt55dSimdRjNmCz8NLF1CZErjZJN+WWreQp/sHbbdnSMR+PUb/i7uEHMJLiWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MpANVDJj; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-467ec031988so1788709137.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705485866; x=1706090666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+HHWHLzcTgUcOMPEyGzQtr3xDzQkbehyO0vABAHV80=;
        b=MpANVDJjBwwL3qcEEgnkpusl+PNfIjngKTV8RZqRaLEt6rLKxd1IKD4j/wEW7iIAl+
         40Ssu1VqquIgS5NzxtqgdsI4snLYXNTzSIP/yeM/PYv11N9bNqMw6y3Ue28Fmehey6O3
         QjgoWvUDkyRN5Rvct3EMTiwjRqnvo0xLkA+fzODtYeYGmW+EokQzPLI1NC9XeohqLYR4
         DAZ9P+iutjbFK8Q7of12Uu8DaxweAPsNwWLSIT0g7pkJxI/u4izhRAsB934XzvgOHX+T
         RjSFe5MLvQrINttAZ8gD2TK9Iyva0nesSk+lshoY1aC+QAYIRaRtRFMTj1LcVKTf6hHr
         f4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485866; x=1706090666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+HHWHLzcTgUcOMPEyGzQtr3xDzQkbehyO0vABAHV80=;
        b=sHCTEOYnk668OV6qmLojGqvSOe164M76ca7EOyDr44MS9sU1GgjyR+iH/RsFWBJgk6
         exgJSard0AOFRZtujwIvayka8CKNbcsmZqweWG2lJiBWuz2e9p6MKhTWq14GsqKMGtZm
         zwxi0QUlz+K6Pkrx8GTW2n1w0JBNWu1sEvMD0/59KXHSsYp06doLwGU7X7mhSK2Ii30T
         9HEsXgMe5IS+lvS004rE42Ik7F9yBWt3VQ+876hGyzmdFeJzpxzmusNhwQLU1QF5/pmE
         vAsYehoxYcrN2UOrXXktkX96W7BLsUudTCFI4Q51dfbQfX3YgrPdAZXsleiDCpD8730I
         BMYA==
X-Gm-Message-State: AOJu0YxbqFsbfv8CWrD9UgJZZV2gyQ6Yj0hFfYgikMoR8ovhxONrHifj
	IX9Gz/zitEa2DRByrA8ADbuuLtpQm+rQuDixCt60pouQJjduLQ==
X-Google-Smtp-Source: AGHT+IF0cosbn5mIeLL8ecREh032b1Vd1wNpHQo/UCh6/dAr1uuGpRdtZRbNNTp7i2P7nLmOzscBM8EUAIskm/SjBKo=
X-Received: by 2002:a05:6102:30b1:b0:469:63f3:17dd with SMTP id
 y17-20020a05610230b100b0046963f317ddmr1642416vsd.15.1705485866291; Wed, 17
 Jan 2024 02:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117094453.100518-1-hector.palacios@digi.com>
In-Reply-To: <20240117094453.100518-1-hector.palacios@digi.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Jan 2024 11:04:15 +0100
Message-ID: <CAMRc=MduNZ63ATVFG9HyrO1GggroeCy7BFtozRmz5dEz0e4-RA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] gpio: support i.MX93 truly available GPIO pins
To: Hector Palacios <hector.palacios@digi.com>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, andy@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:45=E2=80=AFAM Hector Palacios
<hector.palacios@digi.com> wrote:
>
> All four GPIO ports of i.MX93 SoC show 32 pins available, but
> not every port has 32 pins.
> Add support on the GPIO driver to 'ngpios' property and set
> the truly available pins on the SoC device tree.
>
> v4
> * Remove 'description' from 'npgio' field in bindings as it
>   is a generic one.
>
> v3
> * Move DT bindings to a patch of its own
> * Improve reasoning for adding support in driver
>
> v2
> * Add 'ngpios' property to DT binding for proper validation
>
> Hector Palacios (3):
>       gpio: vf610: add support to DT 'ngpios' property
>       dt-bindings: gpio: vf610: add optional 'ngpios'
>       arm64: dts: imx93: specify available 'ngpios' per GPIO port
>
>  Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 5 +++++
>  arch/arm64/boot/dts/freescale/imx93.dtsi               | 4 ++++
>  drivers/gpio/gpio-vf610.c                              | 7 ++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
>

Please don't spam the list with new versions less than an hour apart.
Leave the maintainers at least a couple days to respond. Especially
during the merge window.

Bartosz

