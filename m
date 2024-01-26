Return-Path: <linux-kernel+bounces-39691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D483D4A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F377B2106B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A763250FD;
	Fri, 26 Jan 2024 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YFOPswdg"
Received: from mail-m12752.qiye.163.com (mail-m12752.qiye.163.com [115.236.127.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15E21A14
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253118; cv=none; b=ABXpsitL7WjogXVvNM+EHd3DzqHSZ8J/N53r2vqTeR3cWywTVBwcle5w7YJCKOAWSVRWSpicN+sRpvM/JSIljbhQU6Et1nR4g5oHb8tDqm6EgNDIf5h2ko7w9Cw4GPenYK6PEKbHdCr0GNUZMGGSywMTDHDQW4j09pTWUTutxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253118; c=relaxed/simple;
	bh=dcIAeG3Ad3qzRg2oAb5j/Ir8olPhDHQEiDDtXnwU9Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH1q+iGKGeSqwYFttR1rDrp4km0pt7uDPm1Lq/g5pxDo2ug1MO1/xofCMIl+pjOYHMy+MVZHDfDreL6aqYrQtiEOhQD+suIctAGkuEvN5hkwLGFnjWTM/hrgFCvN1ocOOGFAI5nfH2POywvq58zj/08SdI6KrVJnCkC22IUnzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YFOPswdg; arc=none smtp.client-ip=115.236.127.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=YFOPswdg7rBxtjGvY8CH7u++ZspuDmBVGAFE0YiKDY6Kpz3ROhPkZhHAbsg7udKDRdxOgI31dRT9zqciiqi7d9qiL0UZ5WSReqjhjDiZWASQCHHWqMPzOHfxZbgDNZxwIDXbHEsVn5ZdQ5XmhVxbxeJ7th/i5iQYAZ79079zH1U=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=o0t+MfDqVm3X5Nqibb28Ci/mN20IReJ02S0VvZJURXU=;
	h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 683D79001AB;
	Fri, 26 Jan 2024 10:56:46 +0800 (CST)
Message-ID: <ffb77494-e452-4fdf-be18-bb0dccfe1404@rock-chips.com>
Date: Fri, 26 Jan 2024 10:56:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: rockchip: grf: Fix SDMMC not working on RK3588 with
 bus-width > 1
Content-Language: en-US
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20230619011002.2249960-1-megi@xff.cz>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230619011002.2249960-1-megi@xff.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEpMVh8aTx8eTBkYTklJTFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8d43b2c95a03a9kunm683d79001ab
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46PTo*TDMJDA9OFgsPEU4q
	SUwwCkpVSlVKTEtNSUhMQ0tMSE1CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhMQks3Bg++

Hi Ondrej,

On 2023/6/19 09:09, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
>
> RK3588 has the same issue as other earlier RK SoCs. JTAG
> functionality muxed to some SDMMC data pins causes issues with SDMMC
> interface. Without this patch, I can only use SDMMC inteface
> with bus-width = <1>. (JTAG is muxed to data pins D2 and D3)
Which board did you met this issue?

The force jtag function should be work if all the iomux and hardware 
setting is corret:
     All the IO for SDMMC signal including SDMMC_DET, should set the 
iomux/pinctrl to mmc function
instead of GPIO function.

Seems like you are working on rk3588-quartzpro64, when I check its dts, 
I found below setting in sdmmc node:
cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
Since quartzpro64 is using the correct IO and there is already a 
&sdmmc_det in sdmmc node,
you don't need to overwrite it with "cd-gpios".

Could you help to revert this patch and remove "cd-gpios" in dts sdmmc, 
and test sdmmc function again?
It should work with SD card 4 line mode and force jtag available when 
people need it.

Thanks,
- Kever
>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>   drivers/soc/rockchip/grf.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
> index 15a3970e3509..d768c5a70174 100644
> --- a/drivers/soc/rockchip/grf.c
> +++ b/drivers/soc/rockchip/grf.c
> @@ -121,6 +121,17 @@ static const struct rockchip_grf_info rk3566_pipegrf __initconst = {
>   	.num_values = ARRAY_SIZE(rk3566_defaults),
>   };
>   
> +#define RK3588_GRF_SOC_CON6		0x0318
> +
> +static const struct rockchip_grf_value rk3588_defaults[] __initconst = {
> +	{ "jtag switching", RK3588_GRF_SOC_CON6, HIWORD_UPDATE(0, 1, 14) },
> +};
> +
> +static const struct rockchip_grf_info rk3588_sysgrf __initconst = {
> +	.values = rk3588_defaults,
> +	.num_values = ARRAY_SIZE(rk3588_defaults),
> +};
> +
>   
>   static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
>   	{
> @@ -147,6 +158,9 @@ static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
>   	}, {
>   		.compatible = "rockchip,rk3566-pipe-grf",
>   		.data = (void *)&rk3566_pipegrf,
> +	}, {
> +		.compatible = "rockchip,rk3588-sys-grf",
> +		.data = (void *)&rk3588_sysgrf,
>   	},
>   	{ /* sentinel */ },
>   };

