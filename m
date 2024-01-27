Return-Path: <linux-kernel+bounces-41025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5C83EA4B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2C81C20F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D8ABA55;
	Sat, 27 Jan 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KM9P8Ffj"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F50BA22
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706324346; cv=none; b=QNCrENhGbrj4pYgkjDDKYIR2LCD7SYGrK2P+INbreAKFT4BEYxH5a2Wg5MLR6nIh0iNBgT8f/vZ8DyNUeGblN2JZMpYj7cP1JNWKQxWmGIQ+e4RcjcOS/+yizvwN3WUR+jIMQuIwBpzU5hsXzMJa8WIxNggbpLhSfjAx6d+BBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706324346; c=relaxed/simple;
	bh=cqz6h8qybg8zqeHMlgnFpj2fAVvyFuBzRiCjORdpKIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM9uRAjpksNwBdBd/anXzS8efisualzIgV4movxeMDdg9TQ5Kn8Vif/mH4V96t7LQsCwiyn4r5p0wLaiJh3wbLnzPnhr/6GvxyRHwOmPpI+dWMT+OMKAq0HCmjjKIFnCPO3cQ2uaqFYMT1tozKfGosr6BmCfHQ2cIQzc96PVckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KM9P8Ffj; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59a1f4b8d94so68009eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706324343; x=1706929143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgh8HDwSDPm2J03EDVHmibPYOLvv4r06hCadDQb19fQ=;
        b=KM9P8FfjDICBG8gPKPT5T4TbLmSo6cKuT8NhYiYAH8m8dX30rzTMcxHt4TfH7s38vZ
         o0E+K5Mfzw2yeChgvCe/B+Q2bEHGCDFCsc/tjgKY4rvo0NhYDcr/xYcNQhFcIhaG/aMo
         pYVeoaYo6bwUTiB6B7udeSkoDFgcqdCGPJcvxmRPyswHf7R1X1UYfX0PCQ/2RGGYDNiz
         7rIk7OOR1Lu5pIqZMDnJh0ehTCvnSq429KSv4CoUrFbz9ffTYvVYYeMkhM33kqPoXHxF
         nHTkGLVnwwHV18JPceizYHvwzN0YhH3+mtCi1H/v1tWCuIs/Eq/L2azyw1ZhyDTlhz7E
         Gs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706324343; x=1706929143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgh8HDwSDPm2J03EDVHmibPYOLvv4r06hCadDQb19fQ=;
        b=Bk4hNibWredE/JK6rYBqZP1Fml0cDPPAgh+UDYTxKEN+4Axyr5+firGQFsg2j9JUwU
         D/GmjgX3OYfioCW5hL2H9S/2MAGP5T5AKY0LLqs142kjRHPMNDbMPBSL66G8WCUkJNjO
         yM2NYkMXIDKLSt6Bm7Hr7s8AT70v6Z7GPC0+5Y9hEcy2OgzmpCxSOV5iZXkjVZ76Al7y
         xiO4FsJUpiumui4cf014P8SURJqS6X8W8A5W5ll+31Z4IP0xXR5iAMEAcWilDjOf+ycz
         fBif7xGsInhTvmoaOXyu4se3b06SdPhYHymuly3/ionrgx9Q9aESnhMYBdTPGQDWOS3S
         Z8rw==
X-Gm-Message-State: AOJu0YymMPD4O6NFQ/X0nRqP1i6fj0/0aHQDSlDci7WlPVcMmU9QKsSH
	XrvTpK0TPUbboGd7pVPlNEpN6OocjneqKhVN9iOKmZpdDhT+G3fs9o6ir2eyi/4tW694Kb/JJnR
	Gc55B16S0le+rU02qnQ2RXJkqgu39U7B9g8V6yw==
X-Google-Smtp-Source: AGHT+IEq0snClZUeq4rcjxQ00Gum27FvXapuVAnu/X2sIV8nk4Gb0dv6sVWx7czBtCSzZQnsoZAeAd5esWgduMRyUi0=
X-Received: by 2002:a05:6359:428a:b0:176:67f3:4159 with SMTP id
 kp10-20020a056359428a00b0017667f34159mr828828rwb.20.1706324343213; Fri, 26
 Jan 2024 18:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org> <20240127001926.495769-7-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-7-andre.draszik@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 20:58:52 -0600
Message-ID: <CAPLW+4m4G+-zFLGr6Bp-73-mERCofxDiD7F=2fd_Wq+18iTs9g@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: exynos: gs101: enable i2c bus 12 on gs101-oriole
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, alim.akhtar@samsung.com, 
	s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:19=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> This bus has various USB-related devices attached to it.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/ar=
m64/boot/dts/exynos/google/gs101-oriole.dts
> index cb4d17339b6b..c8f6b955cd4e 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
> @@ -72,6 +72,10 @@ eeprom: eeprom@50 {
>         };
>  };
>
> +&hsi2c_12 {
> +       status =3D "okay";

But there are no bus clients declared here? A bit of explanation about
how this bus is being currently used would be nice to have (in commit
message); e.g. maybe it's used in user space somehow, etc. Because
otherwise it doesn't have much sense to enable the bus with no users.

> +};
> +
>  &pinctrl_far_alive {
>         key_voldown: key-voldown-pins {
>                 samsung,pins =3D "gpa7-3";
> @@ -113,6 +117,11 @@ &usi8 {
>         status =3D "okay";
>  };
>
> +&usi12 {
> +       samsung,mode =3D <USI_V2_I2C>;
> +       status =3D "okay";
> +};
> +
>  &watchdog_cl0 {
>         timeout-sec =3D <30>;
>         status =3D "okay";
> --
> 2.43.0.429.g432eaa2c6b-goog
>

