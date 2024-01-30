Return-Path: <linux-kernel+bounces-45440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C28430D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D85C28804B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84D14F61;
	Tue, 30 Jan 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpRd5lvT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9D7EF08
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655705; cv=none; b=CggNlZy+AVWpLtRrHY9pc5gnzJD4wrYhYRr4eGZy5AIh7OBYv3IZ3pIxM8Mrw9ywpkwG827LR8x6uunX4WgwKB++tDwKXBebPEZVfcH1iheQZ4pkcZ53sClQrUS03IpGXok1F4hZQ2wh+pPBNF8iec1CFYIhlf3U0U6Jh2xW/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655705; c=relaxed/simple;
	bh=BhXfGyAPv4SiBtMKJ3yf878gVc2hoptHT3pniLDIM20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX3WOKQ6OI452UsUd29+sxn1lApOtuzwB7THh3OW/Z+zhBMywzNnp7+aOYVdtpaLXG7QELgzINpyQjCij3MkNg4OQ3vbyxkZSiuURq537zdl5XwgEfcCF8PjQdlcPyoNfS+b8xsDtiwSMSZJrS5P0mWLZqk5+AHbBF1BrVtYqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpRd5lvT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8d08f9454so29055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706655704; x=1707260504; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=InqSXSTpbT1eiS6unjbH+Gd3bGvOKOKvltW4HzECThc=;
        b=RpRd5lvTS00wy3JtmBLu9dGD33xQ6OX28VGFno/GYwlLFxiLuQIkSCk0GMHBNkZVWY
         VOUBK2wbqtwbt/1DQQAd0h37ksNJRlAW0BXFCENY8yUlLx405/7aIOwP0HwWADBv6ATm
         +/fb11FDGSXR1tadTGuhoKPHajzkGNjR5rb4UOIg7dlLhZTJXdpDcI8WdL4R1eo5+XbU
         0VFyToz6gWr9sP9VZMXVykIKxgcoVbt9rdzpHs2yxSX5aLaXK2Sz8+6RdWO1vXz9TaEI
         25HaovjgmSdPOCeddIFnsJHneNDXJMATFcjaSxYzZo4T6v9rbAkyn1ThlH3ebBHI716C
         /GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706655704; x=1707260504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InqSXSTpbT1eiS6unjbH+Gd3bGvOKOKvltW4HzECThc=;
        b=khgO6a9/9oUeAy2V2cZ2Cb+g074n9mNge8kK/z+HuIAvbNkjYEIVnlOKj91batNSWl
         lZH5YteAaSkKMLHH7zKcvBHGn3P2zAeQ+4V5wNn1cxNErLPWvtDczBgoQMkeAYMs624C
         58fGG3p5CjaZL4T9b2WPr9+DRl90X4q2Diu/s4z9Ez2fZxaYHhznBo0mLHaBQ0RaZGOc
         FVCypIr/OlPp0T4TepgE+w8NFsKU7sDiKA6T6pZoYbicEcq1jJDhcF/yucbE06fjcZTE
         avIATPxN3HEIlJR1TQXw29WgMkQMGLOO1tgoW8rpDikSLb/+Q8zMRzxSOpTta+uP7IxA
         +dkA==
X-Gm-Message-State: AOJu0Yzf+ytLVtoPn5mhIjkh0F2m6iKRnOY8wjSNCMwt0aRRrxIdNzSY
	+N0cYkECuY7aoJkQDkl3domK9Axh+5KOtCuoz7eeag7N5M1zt6OTTuLL5dBJtA==
X-Google-Smtp-Source: AGHT+IHHlfMmJN3TbbAqe9NgDhqGhzDl2uuy1MggUp8v8ebeUy6kOFXJOYClhwrKxKJuMakJW6TItQ==
X-Received: by 2002:a17:902:c943:b0:1d5:78d5:760b with SMTP id i3-20020a170902c94300b001d578d5760bmr389018pla.10.1706655703427;
        Tue, 30 Jan 2024 15:01:43 -0800 (PST)
Received: from google.com (69.8.247.35.bc.googleusercontent.com. [35.247.8.69])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001d8e974ed2fsm3827918plb.284.2024.01.30.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:01:42 -0800 (PST)
Date: Tue, 30 Jan 2024 15:01:39 -0800
From: William McVicker <willmcvicker@google.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, tudor.ambarus@linaro.org,
	semen.protsenko@linaro.org, alim.akhtar@samsung.com,
	s.nawrocki@samsung.com, tomasz.figa@gmail.com,
	cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/7] arm64: dts: exynos: gs101: define USI12 with I2C
 configuration
Message-ID: <Zbl_01J_T6FoNZPy@google.com>
References: <20240129174703.1175426-1-andre.draszik@linaro.org>
 <20240129174703.1175426-7-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129174703.1175426-7-andre.draszik@linaro.org>

Hi Andre,

On 01/29/2024, André Draszik wrote:
> On the gs101-oriole board, i2c bus 12 has various USB-related
> controllers attached to it.
> 
> Note the selection of the USI protocol is intentionally left for the
> board dts file.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> 
> ---
> v2:
> * reorder pinctrl-0 & pinctrl-names
> * collect Reviewed-by: tags
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index e1bcf490309a..9876ecae0ad8 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -451,6 +451,36 @@ pinctrl_peric1: pinctrl@10c40000 {
>  			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH 0>;
>  		};
>  
> +		usi12: usi@10d500c0 {
> +			compatible = "google,gs101-usi",
> +				     "samsung,exynos850-usi";
> +			reg = <0x10d500c0 0x20>;
> +			ranges;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>,
> +				 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>;
> +			clock-names = "pclk", "ipclk";
> +			samsung,sysreg = <&sysreg_peric1 0x1010>;
> +			samsung,mode = <USI_V2_NONE>;
> +			status = "disabled";
> +
> +			hsi2c_12: i2c@10d50000 {
> +				compatible = "google,gs101-hsi2c",
> +					     "samsung,exynosautov9-hsi2c";
> +				reg = <0x10d50000 0xc0>;
> +				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				pinctrl-0 = <&hsi2c12_bus>;
> +				pinctrl-names = "default";
> +				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>,
> +					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>;
> +				clock-names = "hsi2c", "hsi2c_pclk";
> +				status = "disabled";
> +			};

Can you include the i2c aliases for hsi2c_12 and hsi2c_8 (added by Tudor
previously)? This will ensure userspace compatibility with the existing Pixel
userspace builds.

Feel free to do so in a follow-up patch, but I'd prefer the aliases get
included in the same kernel release that these devices were added in (v6.9).

Thanks,
Will

> +		};
> +
>  		pinctrl_hsi1: pinctrl@11840000 {
>  			compatible = "google,gs101-pinctrl";
>  			reg = <0x11840000 0x00001000>;
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

