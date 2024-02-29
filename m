Return-Path: <linux-kernel+bounces-86423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52386C52C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EE91C238FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBA5B699;
	Thu, 29 Feb 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5lfH0Z1"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0805B5D8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198972; cv=none; b=MWgfbfqWeTI4OEBQFT53WR90Arw1iy1v2GKNvh2OGEQMkN5FYZybg6BaPAVYp7M1jDUdu7F/fSzbCuXXKOsGEVcWzDS6DmazAI93Q2WA2oXWjmcOHDSxpN1p0ajifyn75biQ+SgjeyaSUlLdW8Svw3BMQI3p2h0exhwXhrUrvTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198972; c=relaxed/simple;
	bh=9xrun28hvTbwUNlBt/r1pmmvIKLwTUek4EH0OAQeY6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBfh6Ouifu3t115kl31712MayuhAw6SSEud7d9634qwAIBkuJI1mDxOUSr/rC1KEJNmUZad//l3ap1Rc8CT4lAzObuddssj82oV6aI8ZScbQMHk7lpzgReGKjL/OfFKuW2ssrvQ31DwDQrE0RQIVy1A6LrnXcqhnN0C2emVZM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5lfH0Z1; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso778571276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709198970; x=1709803770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xrun28hvTbwUNlBt/r1pmmvIKLwTUek4EH0OAQeY6g=;
        b=d5lfH0Z1sSIgs50yYIeIQKbO474hjQu/EvDmwE49iQgsPOInNaUQDOSA+AF4CXIpmy
         Xb1yPwzdhzClmaM4/Sk0iXEUpm+yQhSsgDzdlqlLeZvTwcW3dE3W01U7sSMPo0shu7Fc
         DvniCqD9rNmEwOafYGPLQlfQwYPz5sQoI9To5ytwb51myDjMz8imulc5asSJHGygEuRW
         niIiT0OyykV5slPLPb3X8XhzLIz8bSeMBjuBVD+hqMi3M/ZVN6reQuYyVcKeW7hgzrHU
         GJh75fl0fgOWApwNO5tjbiM5lwSFeovt7YtrIQmbdYcRK4gc52P62cd5kaS1C6Oqf5xj
         tbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198970; x=1709803770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xrun28hvTbwUNlBt/r1pmmvIKLwTUek4EH0OAQeY6g=;
        b=KQxoXj0LL+ImpjL5F1x/mJ5iwAt3/jByTeo31GcslhXJpeYXucoXbNIFtDI2Dw/jAW
         u8R1Ht9odad5S57t7T1U3NX4UnvvLxTADs7gcmgNU5hnIKoaIXdmWJmE8LEnsMW4pSaN
         jreZxjyXLZ8qW1ThIwH2mlFd5xCZxPXVXTLez8Xi8pN2T49MLsI97A1Z9IMds7L7AIo/
         m0DFWWSV5PjZALt87lUeYJ/7J7RalbzOHdnPUxXAstkZByHcUtPJ/fU5Jp333uSiHYsy
         CGwCzm6YjJnCNLbSz7THA5j1cUJy9ShulG5Y2hv6n5HxXap+0DDW6ZJVWTSeiX08SilQ
         wejA==
X-Forwarded-Encrypted: i=1; AJvYcCVpRZLMT7VM7Rh0eYdPiTq3u31lRPNMKqYcqtXydV2M71Ci5k+POp80IDtpj/Pou3CEUbt83m/9XlyGQ4z+njAY4bWu6+OMtBIQA8Bx
X-Gm-Message-State: AOJu0YyFzTmaIhMNDX+KuF5LkbqcYOYBm3n83N2XK3tpbeNFE8srCwU5
	UebQQR2CN0+PrWmpriK1+Q0G09W54SV5hvYvKBs7twrX3tO9V8l+n2OdzcNnbwJLyUlNx2EsHZ2
	OGyE53UAZ8vK+xGVxxmX88o/J0xKvAvr54Kz2Ww==
X-Google-Smtp-Source: AGHT+IFcIq6rOa8YJF/37W++7S7G6OEFznJJRmbQw71XiyjH8oKuNU7jWDHU4uKxFfdpywX9lIfEjnnzQ3AuD36QOkg=
X-Received: by 2002:a25:81cd:0:b0:dcc:8c5e:7c9b with SMTP id
 n13-20020a2581cd000000b00dcc8c5e7c9bmr1795722ybm.57.1709198970093; Thu, 29
 Feb 2024 01:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-14-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-14-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:29:19 +0100
Message-ID: <CACRpkdYavroWGW5HXLJATF0UuffQYnyoQYnO=aV364=XA7ARsg@mail.gmail.com>
Subject: Re: [PATCH v2 14/30] gpio: nomadik: add #include <linux/slab.h>
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:28=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> Add linux/slab.h header include for GFP flags.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

