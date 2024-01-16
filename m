Return-Path: <linux-kernel+bounces-27049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE482E9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167CD1C22EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300B10A2B;
	Tue, 16 Jan 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="EWb1mvNP"
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50110A05;
	Tue, 16 Jan 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=l9cbtoVxmahu43eSHexnSSM/C+AFOi8SW69yat4JZ0A=; b=EWb1mvNPtJnN6SSi52fNO/z6wg
	wbhDrovcJ/US7uMMt3iw6ibEiLzJEgT6aJ10GwT7gae7oM84PF7RZcrJthI7NZIQaDQQ4ryYGLESs
	idq9FSTqiNIL/N+ZGX/A2LK0e1pxSKxb4amtoubTbfTVC5MQBuV4LEZdL3IKMtha/Q4xyME1tR4WC
	GeeMoxppEqJm6xYUjUKYg2iE/ZrlgdnpSHteFEUgTqaFwrVw8QoczfS8ItSv579rlps7A/pi1sH2H
	CzDvslR+repTDMWObh+jKvWrqKeK85YMxChoGOhlzMLUBtA8hXQy8AtGxjB7VxP644Ihd5tphh5Uj
	K4Cwnzlg==;
Received: from [39.110.237.146] (helo=[10.19.62.31])
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <cyndis@kapsi.fi>)
	id 1rPd44-006n2A-2f;
	Tue, 16 Jan 2024 08:36:49 +0200
Message-ID: <84be2248-9789-4b32-8f89-296c0f195835@kapsi.fi>
Date: Tue, 16 Jan 2024 15:36:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH v3 2/5] gpu: host1x: Add Tegra SE to SID table
To: Akhil R <akhilrajeev@nvidia.com>, herbert@gondor.apana.org.au,
 davem@davemloft.net, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
 catalin.marinas@arm.com, will@kernel.org, mperttunen@nvidia.com,
 linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org
References: <20240109091708.66977-1-akhilrajeev@nvidia.com>
 <20240109091708.66977-3-akhilrajeev@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240109091708.66977-3-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 39.110.237.146
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

On 1/9/24 18:17, Akhil R wrote:
> Add Tegra Security Engine details to the SID table in host1x driver.
> These will be referred when registering the SE as host1x device.

Technically, these entries are required to be in place any time we want 
to configure SE's stream ID. Register writes to stream ID registers fail 
otherwise.

> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   drivers/gpu/host1x/dev.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index 42fd504abbcd..b564c7042235 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -214,6 +214,30 @@ static const struct host1x_info host1x07_info = {
>    * and firmware stream ID in the MMIO path table.
>    */
>   static const struct host1x_sid_entry tegra234_sid_table[] = {
> +	{
> +		/* SE2 MMIO */
> +		.base = 0x1658,
> +		.offset = 0x90,
> +		.limit = 0x90
> +	},
> +	{
> +		/* SE4 MMIO */
> +		.base = 0x1660,
> +		.offset = 0x90,
> +		.limit = 0x90
> +	},
> +	{
> +		/* SE2 channel */
> +		.base = 0x1738,
> +		.offset = 0x90,
> +		.limit = 0x90
> +	},
> +	{
> +		/* SE4 channel */
> +		.base = 0x1740,
> +		.offset = 0x90,
> +		.limit = 0x90
> +	},
>   	{
>   		/* VIC channel */
>   		.base = 0x17b8,

With the commit message slightly adjusted,

Acked-by: Mikko Perttunen <mperttunen@nvidia.com>

