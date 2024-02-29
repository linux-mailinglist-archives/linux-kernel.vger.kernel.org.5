Return-Path: <linux-kernel+bounces-86459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EAA86C5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231AE1F240BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5BD60EEB;
	Thu, 29 Feb 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCAp56jN"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9D60ED8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199710; cv=none; b=T4Z9qrSU3+NHnpFGwvaJnqHKEBunhRRgEvMABoLR6TpnS4ymGCelLn5sqjXul6Zs/pfrrP913xJv+f7hB2OKSsLQ2MhjnGRl4W5vADZ9XcBFzouSlib2vHuCPKDeKy9tKU3W580wUCHCAQS8BHxQeJx39R8O6r2b2F8k57qTfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199710; c=relaxed/simple;
	bh=7QaM8qpy8M/oO3QKoCLuK/VdyOhdJWKlvjZHCHtRTFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZCxd28zvE5yt28Ege6xqtitOC6CtKsAY2Jp8wPvWj1wRIIZUnatWTZtmrCQbX1fjefuBDNPPf2MH0mw/XdHU9ld6cv7n+eT0UsbtLRDlYMhPvKmpDV3TRHATv4Sk9oI5vpvn+5GIg42R8yaUWTrkVo0PYiUVpR3o2eJqU9RXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cCAp56jN; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60943ad307fso6799657b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199706; x=1709804506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QaM8qpy8M/oO3QKoCLuK/VdyOhdJWKlvjZHCHtRTFQ=;
        b=cCAp56jNV3x55QMjXW4GHgYJuzn9yCKi1eRw0GDwzvrnJYhxnzK00yIeaIyof9Qj4L
         Sw/51/SWCCRSsADhv3H7GRDnAM2qEk18r18jfzMUH45hs0D6uvFC/GWqKq4jDuFTfJOS
         wk+FdrgbXqr15PgIOfxG6UdhJAbjSUQfrDTbX/zp0Sh/8mZXvSJBZQHr/Fe6QfFEvcCs
         Gwqa0/G1r/UvdJHnYO//2FumcNa+WWJoTaLJ807ewk8uMqNzVDhZV05nGv5Cw3u1iFjk
         bjfAK0w8BaC+Z9DOudRrbtzo1LYFFVqJzRozONbQb3N3mewDcBaJ6emWcXiryJ9ptKMw
         d0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199706; x=1709804506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QaM8qpy8M/oO3QKoCLuK/VdyOhdJWKlvjZHCHtRTFQ=;
        b=urg8y45lb0nP0+cleIcPHRiaYw7AeooQJuWmUpAX7Zwp3u6SzdnGD0eI1z6kWtAQDa
         107xmM0aQDTC/zyDmd46roOQ2EEo9lKr9G4H6SzaAdZqucv9GUjICA6U/cHi5DkT5noc
         xVaPGr9/iLTH1yvw/szO5W8+C9FQAR1Xzg5BUPabG9pz/dWz1/Dxq++Uke9rNOWyHfVc
         Qn8/boWaaK65BhrnL3043p2tCLvO5BMbYW/aB+wOQqIs1YOtfs6devJoO5txKinY+9m3
         EAYWocC0qEwykYp2Us7BD7BRPbQSvtqQ+lxyjlYISO7M6jmTuBSIcYx6JkqNxY5PTYlt
         /w5A==
X-Forwarded-Encrypted: i=1; AJvYcCWdJ5JDQFOcGCSZLz2YQP//I22YA+3Z4cm5ybD/3u5mxGuZpxvq//OmEu77lXdoxfxvJjKi0T2kNaGhSVXnC29Oe04EynFAKxpbwMtB
X-Gm-Message-State: AOJu0YymOBQBLJxJ9Y99ZYfXKZ/+O8YOdAmzwrrb5VllvreEVccR7f/l
	d4CggNljXVtV2Gx0Vx8L4rhvzOUOHIomjXOp7pxCuuWFrQ6N3XvlEG78qUArbsHo4efPP0becIE
	Cltwo3oe2F03nnAt+GOYN2PrrjA3f6fF5xlRCUQ==
X-Google-Smtp-Source: AGHT+IHTAuOz4wQKF+O5S1+0NwHXGguKGkidGUeJtCBTbj6pfIQGuoVun6C8itBJL/zdjlB7Ma/a5EbWx2TkdEe4SLM=
X-Received: by 2002:a25:31d6:0:b0:dce:9c23:eafc with SMTP id
 x205-20020a2531d6000000b00dce9c23eafcmr1704317ybx.1.1709199706188; Thu, 29
 Feb 2024 01:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-28-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-28-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:41:35 +0100
Message-ID: <CACRpkdZnGSOhtZMc7Y+UMtmPnmx_rM8_PQKBXd8W6XVunGogfg@mail.gmail.com>
Subject: Re: [PATCH v2 28/30] MIPS: mobileye: eyeq5: add two GPIO bank nodes
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

> This platform uses the same GPIO controller as Nomadik. It however has
> its own pinconf & pinmux controller. EyeQ5 is the first platform to use
> gpio-nomadik independently from pinctrl-nomadik.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

