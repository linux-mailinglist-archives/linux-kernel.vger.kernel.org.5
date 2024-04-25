Return-Path: <linux-kernel+bounces-157929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD4C8B18C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2301C21744
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2311C92;
	Thu, 25 Apr 2024 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="jCaoz1Ds"
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996FFBF0;
	Thu, 25 Apr 2024 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714011101; cv=none; b=N8caMH1oiIyc2Ngxy6a0xLToQaYBeLV7eOXTmSOZGwZ4o1psn3gpax0wGGRXlRdylFnOQEtqDTyR49w27YMweFK+vqiIETsRijgy0jkxr3QqC3p1veR5bNxT2eA3trOX2ZdaZY7VtrOZkYKb3HP1Kln2Sw0XM0PjqE0eXRWiEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714011101; c=relaxed/simple;
	bh=N2fQLR37PTUiko07ZkLTePJE+4Y6KWX362T/pv/F0QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLctJZyKIs9GXCMsKaXZL1k7LYFLxi1S8yB8KDrQTbJFgIxnyIAEVqoB5w6N1Vk+ck4LcK457d8+pVI9lKvFPGD+bSsNu49hTY5cFi6e2XdV8Jis2+rx/xVfCrEbyY8MIHeymC2kFzmFbaCHy8OubBtMxAVL/CWQTg3ok3GGmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=jCaoz1Ds; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EZVXgbN1wH/AqYBH20dS4hDQxOscPBy6Iif8n7vgDBM=; b=jCaoz1DsjQls5AriAYHHTjG5DR
	yCC8rIAC9GBxC5Uh7e4FoaV3NcrNzw1LMCRPyIFJBblebL3+ws3ENLx/lTkB3Zt5htSpeck7ti1eg
	mG2xNuSF95784vCCThpi4+I/kOcLatjnruTZOPWdzv6YMITeILxmPMQdbtoH7HUpQ2KIlh/2CawRy
	IuP/iqq6OsCwUKHm47eJbO/FwcD6JVkW7GX3DwW9mDHp1PjesE3DpwYjAPqsKPWz2SgdnV6iyaG9R
	jBbt3yJJAJoykU892umrmkob0UOcO2hzQkqpIIX9OuhsZn0xi/Z0VRIaMEk5AJdbk4W0u3S7pgyrT
	tPCzislg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lars@metafoo.de>)
	id 1rzoJS-000CGV-MC; Thu, 25 Apr 2024 03:54:14 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1rzoJS-0008R9-0N;
	Thu, 25 Apr 2024 03:54:14 +0200
Message-ID: <c0a71e48-6cab-46a2-a9b5-1a734f922363@metafoo.de>
Date: Wed, 24 Apr 2024 18:54:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: spi-cadence: Add optional reset control
 support
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Michal Simek <michal.simek@amd.com>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eng Lee Teh <englee.teh@starfivetech.com>
References: <20240424051317.2084059-1-jisheng.teoh@starfivetech.com>
 <20240424051317.2084059-2-jisheng.teoh@starfivetech.com>
Content-Language: en-US
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20240424051317.2084059-2-jisheng.teoh@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27255/Wed Apr 24 10:26:21 2024)

On 4/23/24 22:13, Ji Sheng Teoh wrote:
> Add optional reset control support for spi-cadence to properly bring
> the SPI device into an operating condition.
>
> Signed-off-by: Eng Lee Teh <englee.teh@starfivetech.com>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> ---
>   drivers/spi/spi-cadence.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
> index e5140532071d..41f2f51d39e4 100644
> --- a/drivers/spi/spi-cadence.c
> +++ b/drivers/spi/spi-cadence.c
> @@ -111,6 +111,7 @@
>    * @dev_busy:		Device busy flag
>    * @is_decoded_cs:	Flag for decoder property set or not
>    * @tx_fifo_depth:	Depth of the TX FIFO
> + * @rstc:		Optional reset control for SPI controller
>    */
>   struct cdns_spi {
>   	void __iomem *regs;
> @@ -125,6 +126,7 @@ struct cdns_spi {
>   	u8 dev_busy;
>   	u32 is_decoded_cs;
>   	unsigned int tx_fifo_depth;
> +	struct reset_control *rstc;
>   };
>   
>   /* Macros for the SPI controller read/write */
> @@ -588,6 +590,16 @@ static int cdns_spi_probe(struct platform_device *pdev)
>   		goto remove_ctlr;
>   	}
>   
> +	xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);

The cadence SPI core has 3 different resets signals. Maybe use a name 
for the reset to make it clear which reset this is referring to.

> +	if (IS_ERR(xspi->rstc)) {
> +		ret = PTR_ERR(xspi->rstc);
> +		dev_err(&pdev->dev, "Cannot get SPI reset.\n");
> +		goto remove_ctlr;
> +	}
> +
> +	reset_control_assert(xspi->rstc);
> +	reset_control_deassert(xspi->rstc);
> +
>   	if (!spi_controller_is_target(ctlr)) {
>   		xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
>   		if (IS_ERR(xspi->ref_clk)) {



