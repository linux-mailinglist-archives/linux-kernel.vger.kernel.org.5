Return-Path: <linux-kernel+bounces-106254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37E87EB76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DA11C20DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B2B4EB42;
	Mon, 18 Mar 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tvSHEkUh"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AD54BA88
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773734; cv=none; b=mS1cqmQYZRQblqD8QrtzCZHHe5D3fVYtbtuJjvO3OXrQj8m42LiAuQDMBVpJN+pkJ8BDKUHbOO0nBMnvSWDfpKogY1+YvK/AhxdYsVBK2oKciztGced3sX95mazyDfY3Esez+qeZPp9oiszIR+kJVBluiICGv0+m2zVF2d4ciOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773734; c=relaxed/simple;
	bh=7nofET7OQ03Sq7cIC4DoYn+Bc4Y8IIymjcxEXaOPJXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx5H7OCxIELEydzfM6X0WfPT2SvyK9k5MBKISTmktCjUC/Hp5V3QRBwF2CSq2DL9I+afbXYFcQrwMZmX5bWZbgbijOZ62//fUtSwCGXepzcwiFnLSFnQJUjzUGUVTTWI2Kkkr0Tp5oejIBXjsgM3nmZg9evnYQ4zsFq2+D5GJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tvSHEkUh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d28051376eso72043911fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710773730; x=1711378530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nofET7OQ03Sq7cIC4DoYn+Bc4Y8IIymjcxEXaOPJXo=;
        b=tvSHEkUhmDpqpwsrcoPrJZBss81bgCmCIj3q3vnxXjplKGxthK6N4rDJzjQ35lb/Nk
         St5RHp0/BrzSCEvQtgr4uInNJv7r8tFWmC77VMV2phjdJ8dr9rQZXVB/rGAr6lVXLkkE
         ebrJVmKsPa8Yo/AgQO66c6XouccmUMRGDoxPvsz/ePcu7G8QHOfFhC2ad573qjDFipov
         tZKJzaXAWI0AEDO6r7fzThAcmZwbzcjk87Xlyq1k8uH/zbsioP7NTAI9Lbd6Kn1OXKAr
         XQdUWQDjz40GAp65SRSac0kkuSz9ITOeepzUaFL9l9SxxfdhEM1VXBaT7wQrmABm3MWW
         3H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710773730; x=1711378530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nofET7OQ03Sq7cIC4DoYn+Bc4Y8IIymjcxEXaOPJXo=;
        b=wN6/0D3PBudrS3fFf7VfN8YvIyFHgqAnGUNTyDWfK9CcsLUDbhkm1mH693AmYC+q1G
         rgVoLh1pvh7iXY0nkiLCAb4L3Eh2exiBV/5ZKVDwDLap0GQJNk81zJJzbzm345o0yDa2
         fHPIP0fyodg3/xSgUrOjc7L2o/EKgnfpT17/vTLZoIVUIb+gUpkw4EFxN5Ol6OCc44r3
         n4TJ7XQ00VlsQkrhsx5SriGMh7sS6TZzZQhPH/6xEI3toJxV0LZB7AljIIT2A42AD+1u
         TFEHMbelzvCpEcb+DCjdnkc0XzsBCW2Raxy4GLgfcjBRdzR5FxTU/4Ko0crW9hiNYJFn
         Nc3A==
X-Forwarded-Encrypted: i=1; AJvYcCU7UDSbQwVe8P56x+LlQ8dqiuQJF2Q5Giwjna5JMW9yWbt6HOd2NLBGLYRv1lMNoCsKdaZC9p2K6r+rdfjOBDx/33eixIztvNKT1MsG
X-Gm-Message-State: AOJu0YxlsLBeUpkJahft8oU2VnsifwQ2iAFQKbry15jGZoUaeT0jpSYR
	gtKPRb7i6yP2N5g8O94d+WCdSCotNKLo/sh7okK4r+yiKTUfvyOhUol4deY6p3gofW1doebW/HZ
	uU+ExkqR4fxlFL/4c66pgC8D3teZzeGqWuvoaWw==
X-Google-Smtp-Source: AGHT+IEv+eYCy5ghVxZ36mlwbWIcp/u04B6R1KZ1C++5boY7huigSjs+Bx5vZUUBldatlWRtSLbpYO90M7txRtasPcU=
X-Received: by 2002:a2e:311:0:b0:2d4:9647:a01d with SMTP id
 17-20020a2e0311000000b002d49647a01dmr5901266ljd.0.1710773729931; Mon, 18 Mar
 2024 07:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
 <7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org> <Zd7hSOw3_zosyrn3@atmark-techno.com>
 <daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org> <Zd7qz1Qte8HWieF_@atmark-techno.com>
 <20240228142441.00002a79@Huawei.com> <Zd_zB_ymxkx0HB3q@atmark-techno.com>
 <ZfPg-nMANUtBlr6S@atmark-techno.com> <CAMknhBG_kJx8JPvTBQo7zpy3mFAkUjZpRY3DLBfXt+39nRJWiA@mail.gmail.com>
 <ZfejyEvPIncygKJ9@atmark-techno.com>
In-Reply-To: <ZfejyEvPIncygKJ9@atmark-techno.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 18 Mar 2024 09:55:18 -0500
Message-ID: <CAMknhBHwVHOS742aVL-pmHzpheicb2=6Hi2Lgz0DvTcXcMoeCg@mail.gmail.com>
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jonathan Cameron <jic23@kernel.org>, 
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 9:15=E2=80=AFPM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> David Lechner wrote on Fri, Mar 15, 2024 at 10:53:36AM -0500:
> > How about using udev rules to create symlinks for each device based on
> > the label attribute? No changes to the kernel are needed.
>
> Right, it's definitely possible to make symlinks for each "device" -- my
> patch comment links to such an udev script "solution":
> https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-cor=
e/udev/files/verdin-imx8mm/toradex-adc.sh?h=3Dkirkstone-6.x.y
> (the script is launched by udev here:
> https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-cor=
e/udev/files/verdin-imx8mm/99-toradex.rules
> )
>
> My conceptual problem with this is that this makes symlinks in /dev to
> files in /sys and it feels like we're crossing boundaries.
> As far as I can tell there is no way for userspace to create arbitrary
> symlinks in /sys, so I think we could have an interface more
> user-friendly by allowing paths to be static for users with multiple
> devices.

How about this: Use udev to create one symlink from /dev/frendly-name
to /dev/iio:deviceX. Then in your application, look up the device by
/dev/friendly-name. Then resolve the symlink to translate
friendly-name to iio:deviceX. Now your app has the correct iio:deviceX
and can use /sys/bus/iio/devices/iio:deviceX/ directly instead of
making any symlinks to sysfs.

