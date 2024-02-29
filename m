Return-Path: <linux-kernel+bounces-86425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3FF86C531
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B32B21770
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990085B69F;
	Thu, 29 Feb 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyfEiDU/"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849655B697
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199013; cv=none; b=ivzYIv24s49Tq0Y3JT8ftu/lkvT1gX4CDA3jOgsGNqlzrZQiTdoh7uusX+Mj1Et1Bik4pT0dPspGI2ofiVb7DS7OFam4IHoEnljJt9lecUJXKjckHkH1DZ0Hnn2TSYffTGvg8Fpfy6C4xwu/5TyntsgfF3t2Yt2wqqBUoODtVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199013; c=relaxed/simple;
	bh=32/5B0NefyE5Im6y4dgv6xs8UUdR/CI5RtA6xy+a9G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esPGEBAzzI9buu6i1EyFRfSjrH1UnNgBvajL/HGaaoAqd6CYzjgZcH1bHGVYxaF0XsAAV7WiJ3ILItRBajTQPU5W47EDINrIakcHfI4TiMKlTTDWTGnlGDUbIFOdTvrwJXYfQMq6XtePfc8gopQYByYoTSbjstLyeT1YqlVvdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MyfEiDU/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6084e809788so14812447b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709199011; x=1709803811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32/5B0NefyE5Im6y4dgv6xs8UUdR/CI5RtA6xy+a9G0=;
        b=MyfEiDU/hNwctN/mfF8cFWJDLkWJklFEmmHrau5vDymWWXuN4q6gcJp/TiwvhqQ3sv
         FkgPV+pGtvVsLcMSdVMNhMvSll0VfdkBzon9OuMYeAow0hRtZEvF/dTkgErPcuiQEfqU
         fXDwJTyQvAt2Py47TjfALZeVh8FSJQPfBG2PQ683RpbI8HEWMLuns0V/i7GBH5zgBxkm
         G7xgFi+5V7t/2WT2lDXO5qSzMNdDl145xgo9RjDQMLvDThRb/Gaq5yCgd7MOtcWFA1Ho
         3DilfT8RLMdDnxGlpsW0xhb30RZ/azLf79zMK1htCe00x0+z9jIsVKCM5nY+LEK1/8AN
         +4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199011; x=1709803811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32/5B0NefyE5Im6y4dgv6xs8UUdR/CI5RtA6xy+a9G0=;
        b=T02xKoGIl1eJLeYy4d2yae1uXetSWrACl737sTG8lkvGhRMhrhFflDUTDlQajbcjQX
         y65jgj+QW+mh0s84+oKpi3pyzr013X5s+MwtQhm7BPkY38VjjtPZ+LT/PI4v04Qs9NZf
         SmGDvQP445vlqbF1yFdnMnXlmFHO+EmNNpTS2CwZqbo2aDkGrJhVdpXk0hLANLKoXXo+
         CKhfTwN5oKTLFdNejtT/jiBIMYWEn8B1IQ4RSAkVoaY7r7ZUFQg3AbnZFxBQtEzIPIIe
         XBr9Z9lPeVYyvzFrWaPyIZnoXYnxqcwADkBPj0jxnQpMsM0igB5EqPV0WGuh9318xoPn
         W1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVG2qb92fN0CYFIVzUlxxenMnfoiSW7Lmp5tc6jA6SPht+ROe9tXK7GHHXDyZUAJpESqjyqlb6a8F///Sujs6PkiMk5o+qMwvuXO+cZ
X-Gm-Message-State: AOJu0YxTmrcK7eakE4saZhLXS4fU+w2r6OhpB2DSJRGUCbrl2PYCxr4E
	CsiUESO5hfFN0mXshOdR02ywKz74sGmCwUOxLi7E22mR1aq9RtSZu9mf8e+jmsoQO/F5/sBHeVL
	l30PVMhyJreNwRUDwpqP+4iR02t9DyRURGNFn0g==
X-Google-Smtp-Source: AGHT+IEW4s5E6g3mYFwqcNbY0h2ya2bzFGJoHdTzyRjvnNi+KrG7CYwSfoIGofcklwbV7Yav2ZNyUpLc2YKAqe52SjI=
X-Received: by 2002:a25:c750:0:b0:dc7:4645:83ab with SMTP id
 w77-20020a25c750000000b00dc7464583abmr853571ybe.0.1709199011587; Thu, 29 Feb
 2024 01:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com> <20240228-mbly-gpio-v2-15-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-15-3ba757474006@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 10:30:00 +0100
Message-ID: <CACRpkdYVuAMRAN_YDnZCzmjLg1+AbHyjSw7ymjCb=wFSL2=GuA@mail.gmail.com>
Subject: Re: [PATCH v2 15/30] gpio: nomadik: replace of_find_*() by bus_find_device_by_of_node()
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

> Avoid OF APIs in the GPIO subsystem. Here, replace
> of_find_device_by_node() call by bus_find_device_by_of_node().
>
> The new helper returns a struct device pointer. Store it in a new local
> variable and use it down the road.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Patch applied!

Yours,
Linus Walleij

