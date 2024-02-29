Return-Path: <linux-kernel+bounces-86461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B086C5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7DE1F23243
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813E7612EC;
	Thu, 29 Feb 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1jLiK5t"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1760ECF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199750; cv=none; b=YbmCvRfAV52qCYjhd4XQDnxIl8zU/tMZm3h1xg9izT5FuhO8bRKSf//LjihOR8KLNXS1O6bLL/FLTeztIMjYX9I0eQSglptX+U/gZ3Jl/N9JLmqNB/4r0TPXCq+OsoQykrrmwS8cLZxvfZQj16VQdbD9PgIbWRzM/NohqLV7S6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199750; c=relaxed/simple;
	bh=7uKC/FvBJpACc0ZQ/imEXkYWFQ7oYf5ML6Z59yi/fM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1SsZ74eOi21QktiWQkxQcexzxlIZ+5eiqWGqBOCWGZZnOvcIFN6nwmXS8IPVD/A3YbumfHgEt9jR9q92AsdpFt1N9ue0EgPHZKxg7q8yKi9ZR/gIBWzZf92IIyrQxRtUkeub6WyJow95d36oVn0w+pYATQOaBHEgyBgI10Hz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1jLiK5t; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60943ad307fso6805667b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199747; x=1709804547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uKC/FvBJpACc0ZQ/imEXkYWFQ7oYf5ML6Z59yi/fM8=;
        b=O1jLiK5tNdoIuhCWhmcMHOSCl+L+Kub7p0BfgOb1lMu1o2jlqrTYRSyoKbF5aRoX4z
         5MSaYrAQnCbJeGc5GXnMbEPeYADekqm4IAUkFJriINVsoqRmrzRFt0DpwDirM9x56BIF
         UbWCEfxBvaTDPDM+9ixQMC34dC9XkT5POpdhDExEmPyrM9uQOct4w6HuHa3MFqbo1vbX
         hi819j8TpZbYX4vof/2qWPfXVI1wcLVBQbR1ARAlWrdsxb83xn8LYzKnN07W/iOOnX9m
         GtPP1IOks/RruAlPcHdKCQ4ulubCKdLdWFOWzO4eMrh+MgYwipz9wkftRO2+zJ9VdfXW
         6Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199747; x=1709804547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uKC/FvBJpACc0ZQ/imEXkYWFQ7oYf5ML6Z59yi/fM8=;
        b=j4CMbLKUBLksCQ/ft3rP5k4khgSj+T3fCo39pvfVCTzFODcox+3XSwy1cyw4GdMDNq
         ZlK3/LtnzjF9Y38r+c/Vcb0hSRU6WGtDjUKxEv5eoK3/7URMoArdBeHn7yVEHZ8SWpFt
         SdH9a4WMfQe/5Q4Bi5eXdIC9RwFHiYIzEgyEKjd8uApPYlpHSA1AslCBFr7lcKQK5xhZ
         H8BtJmTNmHM6bzDK0oCv3iLEB/hPXS3M15tmUF1w+du45TlU+d4jWo6ryHd2Td/ejUkZ
         pu/pZiZAZNe43VFQeNQZQm6uwv99KrqrJFuoD1Z2hnJTrXoPUjW0lXv9xUCxYn4fRRaD
         PesQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcE/5we795fhcG9Kb9yhkHHKJQtXbtRQwUko9oV6E99O/psuUYMTYEb8tAUKf8a02jGRPhE0E3M/Z8RuRQUNnEV8QPiKWeJrObEhCi
X-Gm-Message-State: AOJu0Yw/Hw+WFCaMJYxrqHQx5leFVPyFk5FMQzeWXRqj6GppY0S1ocUc
	5zoqKq4MxjqXH09MPUmqwEfFLroIF5dIWokSE6FAlRYIsGieB1omK9phl1rcrd4jwSG9WYcqSWK
	n46FhBW67lKAUd+2MO50374FwW8DDC8czqFImOA==
X-Google-Smtp-Source: AGHT+IEpJ3NFu5a8qlfTHTx/bDighLY1fBT+nS1X9VL0cGXlwBe5EOlcAMNoF6lc/EO/wb8zGIf7qpxZCEmSAd7rIAg=
X-Received: by 2002:a25:ad62:0:b0:dcd:13ba:cdd6 with SMTP id
 l34-20020a25ad62000000b00dcd13bacdd6mr1498057ybe.47.1709199746956; Thu, 29
 Feb 2024 01:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-29-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-29-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:42:16 +0100
Message-ID: <CACRpkda7m9qvTED-meROn=U1RQUYe4sW47n9EJisPFoVV10Z0w@mail.gmail.com>
Subject: Re: [PATCH v2 29/30] MIPS: mobileye: eyeq5: add resets to GPIO banks
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

> The two GPIO banks share a single reset line.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

