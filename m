Return-Path: <linux-kernel+bounces-57956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A084DF83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0332856D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3066E2D1;
	Thu,  8 Feb 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sq04pULv"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711366E2CB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390892; cv=none; b=CkG5J3IYyfQF35kDrtGGDSMN8WyxEfgb7j26HqF3YSrZRiqbBVvRSwijSx3+6bV3lQhbRTfQuGkBMEiLBXk7HFHTyoLaWzHtl1wjgFst8CiD2Rv6fTYg1cfBLfaBjMVWboESAMUsM7V3DrWdJuu4UQxuNZ+R3U3WiPUxuNBYnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390892; c=relaxed/simple;
	bh=YF3AwsIziMoJKgQELRqtTwJWt1NnnUaynRdJ8slMOqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhTNagvdCdDv/2iGgw3o7swMOXxI10FgbcztFEVCpHveMW/SNOczNf9EW3jlQwx8vDiOwNUvSKRHvZqhHxWifY+vMfxCeFP2LjAW78lnrDwHaZeUN43GfsYPrXL2kZbs33eDNJQ0HeWAcm4Wt3d+ARWAIh77Pi9VjkM0PiHL9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sq04pULv; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c431c6c91so6615126d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 03:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707390889; x=1707995689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fJRRGrWXukyhlF5rwheSnxZvpxEuo/Z7R1gl3W8UWUQ=;
        b=sq04pULvblqHu4kWBeiJdO6vHV0SKQlctGNFtwz05DF+uIcLUU/O9/yqKgJe3CQ+9p
         CLVyjW92w/1VvphUIUBSCWfayoog/v6Vxlbnha6Tr9QYidbMjaC6jJdqU4sMKYIazfVH
         uNflA91IVUP20ePu3FgvK/szHB57H1U7Izey7ft4Kelke7lJdN3uDZ0M8CEbgyYohL1e
         zFSUerc81Aqbyedoz8j8zoYCjj6ARSQl67QbChgYlVPZ7E8V+e4MGcD3QHU+dp+A/0N7
         cPZjMv5lYuFNt+Is7LXKQokl1/fG5TXu4+otcY9+nEwbightM3m/gVHQ5s2txUCC8iD5
         FT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390889; x=1707995689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJRRGrWXukyhlF5rwheSnxZvpxEuo/Z7R1gl3W8UWUQ=;
        b=ny++yGcKFfGCg/+KO3kKWj+xZuDL8t/QjLKkO3JHIgU2n1sat4gm+CH1YhQC5d808+
         BGEkn1kRd8eIkZAFORJFRz3+MlKMY8zhPQiN8g83AhDmYWfhXBt7bcGM+9Cp2l6jTLVS
         lDohziBkG7AuN4tRE9r8Wc8y71pOC/lQF2Xyj7jbLtEJT50Vu+/LXfkUsBwWWkzlOXa9
         McfTOocpkGJFFjA5chV8clS0Kkfom9gIpfq4rSbb2J0Yo+YqMyAszmI4tnHKpX+o4lYb
         h/brdabx4u7RXsRdPVhC5IxgFbI851oTnvU+WQYYEjGXefNYN047kLKmk3H12sGWEXQ4
         uU7A==
X-Gm-Message-State: AOJu0YymH5sy78RgLXgHvk8MZPUBC52SLf2Rdli7HC2f/yTtdzB9NH+5
	99tlU3svXJ4rBVd4EWVZdlOSwB4mxFyWX7BF5PxIZWbk5esW1PF/aL7b0VShB8VojoOwz4k1DWw
	XKY1fyQ3Z4pSHwMEhNFC3xLdhlncL5QlRWQS+Ww==
X-Google-Smtp-Source: AGHT+IGZDj75tdfnjsfYjBWALjP4rXBAPdM4LZKlPAJGJ98niyWndw03uuCQ9KxHtey2Vh4PRD2Iwgtkrgu5pOd+iYU=
X-Received: by 2002:a05:6214:19e7:b0:68c:96ab:5672 with SMTP id
 q7-20020a05621419e700b0068c96ab5672mr10954168qvc.17.1707390889086; Thu, 08
 Feb 2024 03:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208105243.128875-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208105243.128875-1-krzysztof.kozlowski@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 8 Feb 2024 11:14:37 +0000
Message-ID: <CADrjBPqscNwMpGmDiHSnAti_RzJZRCQNpcjJ+9vrPt7TAyctVQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: exynos: gs101: minor whitespace cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 10:52, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The DTS code coding style expects exactly one space before '{' and
> around '=' characters.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  .../boot/dts/exynos/google/gs101-pinctrl.dtsi    |  2 +-
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi     | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
> index e6a9776d4d62..a675f822acec 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
> @@ -251,7 +251,7 @@ gph1: gph1-gpio-bank {
>                 #interrupt-cells = <2>;
>         };
>
> -       pcie0_clkreq: pcie0-clkreq-pins{
> +       pcie0_clkreq: pcie0-clkreq-pins {
>                 samsung,pins = "gph0-1";
>                 samsung,pin-function = <GS101_PIN_FUNC_2>;
>                 samsung,pin-pud = <GS101_PIN_PULL_UP>;
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index c7a9e81d23b9..80cc933cca3d 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -73,7 +73,7 @@ cpu0: cpu@0 {
>                         compatible = "arm,cortex-a55";
>                         reg = <0x0000>;
>                         enable-method = "psci";
> -                       cpu-idle-states =  <&ANANKE_CPU_SLEEP>;
> +                       cpu-idle-states = <&ANANKE_CPU_SLEEP>;
>                         capacity-dmips-mhz = <250>;
>                         dynamic-power-coefficient = <70>;
>                 };
> @@ -83,7 +83,7 @@ cpu1: cpu@100 {
>                         compatible = "arm,cortex-a55";
>                         reg = <0x0100>;
>                         enable-method = "psci";
> -                       cpu-idle-states =  <&ANANKE_CPU_SLEEP>;
> +                       cpu-idle-states = <&ANANKE_CPU_SLEEP>;
>                         capacity-dmips-mhz = <250>;
>                         dynamic-power-coefficient = <70>;
>                 };
> @@ -93,7 +93,7 @@ cpu2: cpu@200 {
>                         compatible = "arm,cortex-a55";
>                         reg = <0x0200>;
>                         enable-method = "psci";
> -                       cpu-idle-states =  <&ANANKE_CPU_SLEEP>;
> +                       cpu-idle-states = <&ANANKE_CPU_SLEEP>;
>                         capacity-dmips-mhz = <250>;
>                         dynamic-power-coefficient = <70>;
>                 };
> @@ -103,7 +103,7 @@ cpu3: cpu@300 {
>                         compatible = "arm,cortex-a55";
>                         reg = <0x0300>;
>                         enable-method = "psci";
> -                       cpu-idle-states =  <&ANANKE_CPU_SLEEP>;
> +                       cpu-idle-states = <&ANANKE_CPU_SLEEP>;
>                         capacity-dmips-mhz = <250>;
>                         dynamic-power-coefficient = <70>;
>                 };
> @@ -113,7 +113,7 @@ cpu4: cpu@400 {
>                         compatible = "arm,cortex-a76";
>                         reg = <0x0400>;
>                         enable-method = "psci";
> -                       cpu-idle-states =  <&ENYO_CPU_SLEEP>;
> +                       cpu-idle-states = <&ENYO_CPU_SLEEP>;
>                         capacity-dmips-mhz = <620>;
>                         dynamic-power-coefficient = <284>;
>                 };
> @@ -123,7 +123,7 @@ cpu5: cpu@500 {
>                         compatible = "arm,cortex-a76";
>                         reg = <0x0500>;
>                         enable-method = "psci";
> -                       cpu-idle-states =  <&ENYO_CPU_SLEEP>;
> +                       cpu-idle-states = <&ENYO_CPU_SLEEP>;
>                         capacity-dmips-mhz = <620>;
>                         dynamic-power-coefficient = <284>;
>                 };
> @@ -133,7 +133,7 @@ cpu6: cpu@600 {
>                         compatible = "arm,cortex-x1";
>                         reg = <0x0600>;
>                         enable-method = "psci";
> -                       cpu-idle-states =  <&HERA_CPU_SLEEP>;
> +                       cpu-idle-states = <&HERA_CPU_SLEEP>;
>                         capacity-dmips-mhz = <1024>;
>                         dynamic-power-coefficient = <650>;
>                 };
> @@ -143,7 +143,7 @@ cpu7: cpu@700 {
>                         compatible = "arm,cortex-x1";
>                         reg = <0x0700>;
>                         enable-method = "psci";
> -                       cpu-idle-states =  <&HERA_CPU_SLEEP>;
> +                       cpu-idle-states = <&HERA_CPU_SLEEP>;
>                         capacity-dmips-mhz = <1024>;
>                         dynamic-power-coefficient = <650>;
>                 };
> --
> 2.34.1
>

