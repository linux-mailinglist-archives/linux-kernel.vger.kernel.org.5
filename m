Return-Path: <linux-kernel+bounces-33174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564FF83659F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1DD1F24CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867073D564;
	Mon, 22 Jan 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UTEfWBjD"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F73D968
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934357; cv=none; b=HMNURZ06XrxjGU+ltWcpB/CvGnDLdRv5M22DwCj19rierHdH48J8S+NtZuPLwfnOVFfCRYVDnxEzKBIqAobfOhebwP6SHW68Bx7GaPbEDYTu52PY26T3YY+MINKwVUE3uIyiQsv1f7Nv6kgyKJkLmwItXHQzPwWlbsloIbB55Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934357; c=relaxed/simple;
	bh=8IL3W8YacvqnzsFiKFtRldVqCRnV0Oht1oPxo8dTD3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmoyoy2j1tgKPgtWju/snHgbb4r9Otdu6JLSJ811aCzLA4avI9OnKhJFrvt7GueSIUzZTvCmk3pJwvFB+ZSihUCZ/nNP4uDcmtZqJZPF/Cq7BeyJzl36hPvg4t4tUxsL174+D3tlEgwVwmdlu0hsofMLGlVxXtpNeQUE5oNkqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UTEfWBjD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3392ba29845so1719537f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705934353; x=1706539153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KomsthGC22mRSAkX7VZrGaLAUK3A/nZYKDyItscvw7o=;
        b=UTEfWBjDC8fGQ2xR+/lgWGFlHToH4V55LsBq5I3OjIUPxKF+WCRN01H0/qLwZTNj9X
         zuWwz1YjB1js3FZfy4jpl9czYEYu0wYcNuTQ+oPjeDYg3YJrYz5+5fI2IW7AA9jmFoi8
         lIE0URN27DdIxS4gyGPHrn5gGvCdEoydI0IKypMZOn7W+o0DOyCAByQ1j0vnolPR1fEY
         P/hSMN7TJIHKG3nsaLp8x/S92J640IpzP/QguSS02R/2mZggaAIWsnDAKzX5MWP2f24J
         QwBu9AD3IQvA+dVieHAP3DeZ3Sb9ZJMOGfAPEjA9L20z8WpZ/Z7Uw+j9bRqwRMowVdja
         UKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705934353; x=1706539153;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KomsthGC22mRSAkX7VZrGaLAUK3A/nZYKDyItscvw7o=;
        b=iLZJBl6MJmc9K2yPKd1l7XK821UdJ9eZ1fQaXXBRcZUvJAHsPhqaOYg/abYDm2Bfp0
         ItfSHQhyjEhSsORMCNK9ry5mco1Wjv4evWyix8q6KN1KIzblOOJnVr1rnNtLt27T23yd
         TRooH+NwNpgxAvMLbI8pdtXryRR+hEBzFx+U1K+EsKZ6fc7lWJvKxGfioxs9dgzhW/pm
         mEWX1vLlQewSb1vTDn3EhEvHMsjPXleTvy7vUH+qKHVPcexkLj/9ErOqKYnFqgbSS6n3
         lvimPdG5aqV2nNJVJfor0ZAe/C4o9duFW4jYv+P0yiGLUxpJFMkUH1FkLwCZDrbXWp9w
         46zA==
X-Gm-Message-State: AOJu0YxV0TES4O/9aoyOUdWViEKgfE+YzjaR2aZpmPBg8cy6OxkCaXox
	Vr87FfHVLzxaAxj+nWRquDeRznY2pQTbOgQa/wT7EHDoYn4bytVWdc9dC3GQ2ys=
X-Google-Smtp-Source: AGHT+IH0T9XrNxjHsrWV1LVB3l7ok5A/XsRgwZGk2Xy7qKflvrF0yi5ysolbDDo1UUUQh5NAxz8Eyw==
X-Received: by 2002:adf:ed10:0:b0:337:c888:6d45 with SMTP id a16-20020adfed10000000b00337c8886d45mr1537577wro.155.1705934352758;
        Mon, 22 Jan 2024 06:39:12 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b00338a3325331sm9111017wrn.69.2024.01.22.06.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 06:39:12 -0800 (PST)
Message-ID: <94742ebd-bc3a-4726-9ba7-5954203e4da1@suse.com>
Date: Mon, 22 Jan 2024 15:39:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: s32g: add SCMI firmware node
Content-Language: en-US, ca-ES, es-ES
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Chester Lin <chester62515@gmail.com>, Andreas Farber <afaerber@suse.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: NXP S32 Linux Team <s32@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Ghennadi Procopciuc
 <ghennadi.procopciuc@nxp.com>, Catalin Udma <catalin-dan.udma@nxp.com>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
 <20240122140602.1006813-2-ghennadi.procopciuc@oss.nxp.com>
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240122140602.1006813-2-ghennadi.procopciuc@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/01/2024 15:06, Ghennadi Procopciuc wrote:
> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> 
> Linux controls the clocks over SCMI on S32G SoCs. Therefore,
> add the SCMI device tree node and the reserved region for SCMI
> messages.
> 
> Signed-off-by: Catalin Udma <catalin-dan.udma@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm64/boot/dts/freescale/s32g2.dtsi | 27 +++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 5ac1cc9ff50e..ef1a1d61f2ba 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -3,7 +3,7 @@
>    * NXP S32G2 SoC family
>    *
>    * Copyright (c) 2021 SUSE LLC
> - * Copyright (c) 2017-2021 NXP
> + * Copyright 2017-2021, 2024 NXP
>    */
>   
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -14,6 +14,18 @@ / {
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	reserved-memory  {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scmi_buf: shm@d0000000 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0xd0000000 0x0 0x80>;
> +			no-map;
> +		};
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -77,6 +89,19 @@ timer {
>   	};
>   
>   	firmware {
> +		scmi {
> +			compatible = "arm,scmi-smc";
> +			arm,smc-id = <0xc20000fe>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			shmem = <&scmi_buf>;
> +
> +			clks: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
>   		psci {
>   			compatible = "arm,psci-1.0";
>   			method = "smc";

