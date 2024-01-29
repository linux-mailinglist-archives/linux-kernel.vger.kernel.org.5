Return-Path: <linux-kernel+bounces-42429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B290840146
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EC81F23496
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5654FBB;
	Mon, 29 Jan 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPW1/iaD"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54D54FB1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520015; cv=none; b=NS0gD+IVY9NG5zTHA++4LlTUHLBa/+nGNe4ZP2OU/Q7ozxLSDnt+Zz/jmHRo/W/4GJFh6hg11V3NwGWEAE9zt6HN+1zrcxtKiJiJn134BH3EyVjPyaEqXVBYf3qs6R9tRlSD28A6B/94o5U9ZZDcWuPl5oBLs9TYSwbCLPW+mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520015; c=relaxed/simple;
	bh=eT5M4PGPIMeg2fCeb3Yf5untV7QcKJ3QzLrXE3MWYzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEiYA3CTYhojFrQj1CMfNG70UwEMY6IDIEO9NtBYdM2Adk1Rq5CUgOMomOMckUTUct8viKbi+Axs/YuYrmmNZuvWorkdRmqD60Z2OQHj/iteYrOnsbBb2dPhWGDd7BqFBkkEWy65vOkxxZ3OWnuR6PMzvVLVCj0ZvvwgxlFThkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPW1/iaD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c3ac1fdb9so15346236d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706520013; x=1707124813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5TI2xWX4WSWXGwvH1ONQ6nW9xXje+suf2TwS23YzRU=;
        b=LPW1/iaDTzn1rIddldewPpgEmBxbGqcC/6Qo5JfMGo8JX6T8aDQnj1rIvlMOGxfHsi
         a9nXI+8U+cYpvZm41EpAEIaH9iny0opaw/ufXJ34UJaLCCGy14GBDeq6mO0lDEq7Im+z
         QA0F2qmVuATze4E73sV1j1EoDHOT5U3l1X2x2ya8QkhigTAV0LB9xfXDyBkEdLAH4nVf
         6FP57GlANmc78co/sLwWt1wSp1aeMsHTR5AA+9ct7bhqIyHoe1wkQLMcw1puBiBpUAnP
         tj2a48rM0E343lkn6Mm3rFKtqzEDUr4A6jeGacjMq0wHi0ZxnDuRG4BFjc6S5rQG8Keb
         SCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706520013; x=1707124813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5TI2xWX4WSWXGwvH1ONQ6nW9xXje+suf2TwS23YzRU=;
        b=ZewbL0TPFni8vOEhf4N8Y6/0YCYzI+2/NYgQfAotx+OAOdXDCFoGBWq0C1TLJctmuS
         SemDJ+L/49Nsgv6ga+F3n6/+pZWk0H5qq+jz0NjxdLMNLCrrAw5MEfOpMkfJ7w0FGNl0
         xFFDFboT6UccF4TUH0/51NNQBnu9FcGKXVPKfMX7yYgI5k9EzA8qdXuYHco1UVgD1K9w
         ZngGy3CkvtTeviltVQTpsbaxHHQIrqNjfmG4QOx6vE8v4LgKKViUPU0KChwaxeNvED7b
         pk2Pgc7p6smAdKPdT5caufXOHe6Dgk0AYBOE7xHAyKM1WY/x+ag//l36dbhKu6no4Znb
         T6Uw==
X-Gm-Message-State: AOJu0Yxo2knwJF0iMgScDz4l9fh5AbGqyjDh9jOTcrcnzrVtLM8BR+2o
	CGZPb5FQxwFE42aU9iJJqSbLLB35Rmc+ZgLVYeZ1MU6PZw9m7KMI+Bia5nR+0wHRHtGpCinqD1f
	/PbE5zBpZd2bkJwN5cNHGqmhvLIA31D/fRlYBng==
X-Google-Smtp-Source: AGHT+IFgpJ8Pszt1MimvP0F6oYcpgps7CfEr4UpP5ROpsZKjeuq5nM0vRM/7HXvHUbqgAhUsYY/FjFO0TS7neZFlXRg=
X-Received: by 2002:a05:6214:528d:b0:68c:4f44:159d with SMTP id
 kj13-20020a056214528d00b0068c4f44159dmr1497734qvb.30.1706520012762; Mon, 29
 Jan 2024 01:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org> <20240127001926.495769-5-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-5-andre.draszik@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 29 Jan 2024 09:20:01 +0000
Message-ID: <CADrjBPrB1asSBxLe9wEfjbaNcEqz_3sXEu_3zfv=fTSk65o2sg@mail.gmail.com>
Subject: Re: [PATCH 4/9] arm64: dts: exynos: gs101: enable cmu-peric1 clock controller
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jan 2024 at 00:19, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Enable the cmu-peric1 clock controller. It feeds additional USI, I3C
> and PWM interfaces / busses.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index aaac04df5e65..5088c81fd6aa 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -429,6 +429,16 @@ serial_0: serial@10a00000 {
>                         };
>                 };
>
> +               cmu_peric1: clock-controller@10c00000 {
> +                       compatible =3D "google,gs101-cmu-peric1";
> +                       reg =3D <0x10c00000 0x4000>;
> +                       #clock-cells =3D <1>;
> +                       clocks =3D <&ext_24_5m>,
> +                                <&cmu_top CLK_DOUT_CMU_PERIC1_BUS>,
> +                                <&cmu_top CLK_DOUT_CMU_PERIC1_IP>;
> +                       clock-names =3D "oscclk", "bus", "ip";
> +               };
> +
>                 sysreg_peric1: syscon@10c20000 {
>                         compatible =3D "google,gs101-peric1-sysreg", "sys=
con";
>                         reg =3D <0x10c20000 0x10000>;
> --
> 2.43.0.429.g432eaa2c6b-goog
>

