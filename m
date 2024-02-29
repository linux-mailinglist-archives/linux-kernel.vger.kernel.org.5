Return-Path: <linux-kernel+bounces-86462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BABD86C5CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C2928D233
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A39960ED9;
	Thu, 29 Feb 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwpAPcha"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D560DE7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199781; cv=none; b=DTBGCSI/5L9NlXMXaTY+dEt+MwnEsPhSfxLPm65m+e2NInieXUzFs0D63fs4RlRbq9bGLmIklYYl4pXzCgFIaZ41G+338YltJLZhtDFEXz7eWYnVYLpA6jBlIvn3MAerVtWKnJlXTS/iyNxsQ6k7uB6gD8N35r16fHcElAzwYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199781; c=relaxed/simple;
	bh=WX6ElzN18ENGeITFFDkMWABhcHlHX3NBsTlvSRXysgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuFhtXkZeTyBW44bpwFG8wDvu5OkSH2fXxiBaqUcpuoS0Zt63PbTuKKnvH8nJK8vzUvCcSUsubTI483TQ41r3CMZoqJRwkZw8AM6e7slfJGMSWjCDJ4hFFjt6m+b6mDcFT97Kf6URCIvDyUv6N8a9MWEIUAmMOfeFMhZXriyjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VwpAPcha; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso731716276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199779; x=1709804579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX6ElzN18ENGeITFFDkMWABhcHlHX3NBsTlvSRXysgY=;
        b=VwpAPcha58IVwBhOUoRrxXcCj4urcm/iMWfWwUZjGayw9A6C87UU/jo0/YS9kaMSlz
         RxQ8CrM4nRtLU48hYwDoMeTNFpYXJh+IUbvD9DFbwtnIEA7UHTwZr2PBNDvNifkGuMgK
         UCVHWJ2SnfPt7jtO+Cldq2VPS94EYrNQQn6CgcdlejoJHkMOKW8pRon3uzWonq8mRo/w
         NBL3xd2c40WKqJCz7/Oyf7auOeAgP9lyCFfbsgr7xuuYnbBMW8omDHnk3O5GB6rlgzCk
         6fhbSouQodxb/7QoUkppeH3j6k5tWfOx7QAbVGq5Un9ZzaJjtayB2Hd2/Bqsi8CZ/UuK
         Tkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199779; x=1709804579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX6ElzN18ENGeITFFDkMWABhcHlHX3NBsTlvSRXysgY=;
        b=GxpaI72zIPQ0shlS56F4f2uZo6k6Tb/u9IqltvGkAkJHmWZAIfgbjI4WX/2SEIDtGJ
         5xybPJguk3xng6ekyz9TXh8A02uQQ+0CZxHTKo8ClqYnaeDTiS/efxJM4plaMbhMhyMq
         4fRPFGX12bdAbBsFuGipkPq80r2Ngm1N8H9MOLD/QrqWYZoQGBZ9RBEaRRshiXuHe/2f
         nqkVJs4JhIaTZIuyWqf2jO+t4r9EmKNtusMLP7qjan7ocikGtYhUamxZ2JraKc8A7G2V
         fKWWRAWSwWSPUt+ksdgY3xOjAQciQwBpOSVk1YFq0MxaRsewZKZn2/pyeXRTk+ZM1c0k
         xn8g==
X-Forwarded-Encrypted: i=1; AJvYcCXYBawPmtKg087h0ov8BQFA6SzqVw5laX5czfbQx37gJWiuSsf6zNKC3doP/QwDJKuLgq2/tPviwMQWXfNk5w9zL8XGBDmE5wEdVMHB
X-Gm-Message-State: AOJu0YzJig/MWd6DqeMKVBK9DSQGCWS3SZBzP/80fW3h3zlJYBlHqJay
	lBrNzpTSN0Mixux0xknqJlGCibJD6FliVGmlzkzSvd+VNWv6T0WhqPILUiSyjUiJqjIl9aXUa3D
	ku2akuzvTNEFSBxw5/QF8JEoZjbOC2P6JWEYmKA==
X-Google-Smtp-Source: AGHT+IGWB8ii4Rr1OBtluZ0lydmBWdI57cDGyFQbH9+5gpfG9FKxBEkZzmzb3kJFjrZ9rPeNA84QZSnk4Kq3aGP+H3s=
X-Received: by 2002:a25:b209:0:b0:dc6:9b9f:d3c0 with SMTP id
 i9-20020a25b209000000b00dc69b9fd3c0mr1735381ybj.10.1709199779367; Thu, 29 Feb
 2024 01:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-30-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-30-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:42:48 +0100
Message-ID: <CACRpkdbHhbxu4TX8ZnkEGA_+v2GdaYSMMgBZH6pL2a356kcS7w@mail.gmail.com>
Subject: Re: [PATCH v2 30/30] MIPS: mobileye: eyeq5: map GPIOs to pins using gpio-ranges
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

> Create a mapping between the GPIO controllers and the pin controllers.
> GPIO is handled in a one-instance-per-bank manner while pinctrl is done
> with a single instance for both pin banks.
>
> See gpio-ranges documentation:
> Documentation/devicetree/bindings/gpio/gpio.txt
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

