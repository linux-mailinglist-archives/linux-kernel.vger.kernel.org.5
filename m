Return-Path: <linux-kernel+bounces-42488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5784020F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D3E1C218E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3480755E4A;
	Mon, 29 Jan 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeGa3dgS"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FD55789
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521733; cv=none; b=LzKPg+cfSSehoQQ4eDJYc3P5+P4adIxySdh13nKjNdDcDla/noctqGwfpDWvXff6w4spPmDnKB0PmoK3/K8Gp3nUr/TW+PcIkLJgPBsT7VqT623zksjPpMjPWyErpjLr7ds/71xBEfjBflKLvtApVLg9642Q8d8VdBpbtPuQ5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521733; c=relaxed/simple;
	bh=BA1tOGEvLJ2F1biwjB2573ANIuiUoV8stL0uXeeVPnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/zKnYDxcBqXNnpCLlNnaqJbcU0PnwzRZwpWw2LHO+SXuiaH4ljo+SjPZn7A8mJpPQdMKxIrl7MG+06mO85+uJ0tiiNJ5EnFWBsr5eptVF7oN18wqMzNoBgCxqBOrE0BH7mdF8YrM1ixZ8omZo+JeQ2pJI04Ee3zVM0HDjJ25Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JeGa3dgS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-781753f52afso232250885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706521730; x=1707126530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHEsVlM7f5nwbIgc9gzWyFxBBE04dfKP6ctAVu1W4LQ=;
        b=JeGa3dgSsjcygSr6r7tr9gwnGHHJ8xC36E0lXADUUDAT3b0z2wUc6orpW2w0W7R5JK
         8zVXJhEfUEDcyef6P7Afmg7jGg8OZxspOaKOtd7BFI1TFql/wui+tRnHKDMvAgEQUQ3G
         3/EFX659GThPRQsE6F5ewxqExsC6JOjkzuPSVqTnVrOjETaHaj0qW34JAWHV/JFmv7u4
         vRsZcQBDxlOu+8OKloqntIXF7dureVbgvK9sN8r1gJVXDOzX/LCH3KZ3TUT5KI+fRmsu
         PxRj9KFixCsVGFts4VkluiW2uqHhWWN0FZzTYvvfZ5DCK2K/1aPpBmEhF+xYVzVL1Vr6
         AT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706521730; x=1707126530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHEsVlM7f5nwbIgc9gzWyFxBBE04dfKP6ctAVu1W4LQ=;
        b=uKeP169dkPzpw8BwUh42bVNH+/boV1Z9yRbkvM/eezOtfhcZ2X0s0EKgMxYjfs4kbe
         5ffC7uLg3+sznkqvt7M8uEw3dxlSLh1a0P8xt3ceXp0mUDQpchyUXVinhjexOb5l8GYc
         XhPNogvayq9+PX/9KrGVRuMad8T4lMItmU5RMiEjjP9ge+xXVJiAGH+vS4rPWIQFkvwI
         w6fOM6JJ7diGBRFALPFSFw5O5DkKF13u0PKoWixs4cSdo4wastNyoooDGU7efq5yOAmb
         g9edHrfXWjRfHgdSeuMqFIvKK5p423dOtsake8vsJtNDcWez2M07pgx7T52T91U7H9Hf
         c+dg==
X-Gm-Message-State: AOJu0YweAxD1Dg9fsrzLTVjhOA7GdpOcD8pVwb6WXosNa0PStJ1Ga3Eo
	z0vrPX93KrnbuCSnBLPvARILt6WFJX8AkvT1tD7joYsyDyPlAJ4RcpFz/pjTczWdNh/Vo71A5WI
	AXflp2urY348EQOEVkqTuqrSJ9knbS7YGaaJO6w==
X-Google-Smtp-Source: AGHT+IE/FkXm22hoOy7Bm93rW+z/+jgXNC3MtDsNhFcBpfDqK2p05aSH1dhnMpcNvIVeXslT5ipbAnbdvzJvrwoQ90U=
X-Received: by 2002:ad4:5f8a:0:b0:68c:467d:c60d with SMTP id
 jp10-20020ad45f8a000000b0068c467dc60dmr4539234qvb.118.1706521730025; Mon, 29
 Jan 2024 01:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127003607.501086-1-andre.draszik@linaro.org> <20240127003607.501086-3-andre.draszik@linaro.org>
In-Reply-To: <20240127003607.501086-3-andre.draszik@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 29 Jan 2024 09:48:38 +0000
Message-ID: <CADrjBPoTewqx2eF9Zw2EHZtjEpPzesAA5cEjVKw-WWgTT8fd_Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: exynos: gs101: fix usi8 default mode
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jan 2024 at 00:37, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> While commit 6d44d1a1fb62 ("arm64: dts: exynos: gs101: define USI8 with
> I2C configuration") states that the USI8 CONFIG is 0 at reset, the boot
> loader has configured it by the time Linux runs and it has a different
> value at this stage.
>
> Since we want board DTS files to explicitly select the mode, we should
> set it to none here so as to ensure things don't work by accident and
> to make it clear that board DTS actually need to set the mode based on
> the configuration.
>
> Fixes: 6d44d1a1fb62 ("arm64: dts: exynos: gs101: define USI8 with I2C con=
figuration")
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index aaac04df5e65..bc251e565be6 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -384,6 +384,7 @@ usi8: usi@109700c0 {
>                                  <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0=
_IPCLK_7>;
>                         clock-names =3D "pclk", "ipclk";
>                         samsung,sysreg =3D <&sysreg_peric0 0x101c>;
> +                       samsung,mode =3D <USI_V2_NONE>;
>                         status =3D "disabled";
>
>                         hsi2c_8: i2c@10970000 {
> --
> 2.43.0.429.g432eaa2c6b-goog
>

