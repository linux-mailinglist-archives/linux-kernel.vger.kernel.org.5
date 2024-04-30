Return-Path: <linux-kernel+bounces-163187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E08B66EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37CFB20D61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ECD1843;
	Tue, 30 Apr 2024 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RPcGzTJL"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2035.outbound.protection.outlook.com [40.92.103.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A43161;
	Tue, 30 Apr 2024 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437676; cv=fail; b=ZE+jUb048HHHDfs+DQGqsPvJzsjkh6fURfhVf2pfl3PRxnYmx7VXF5WoqKDJozO2UnYhpmO/9kP34pd/xEtY8u6zeB+NOoPpifWoaKybWZoijQgDPELxgUw2v3R+krwUV9gHG4p9N+sBqLb5OMfTSZ4YFsNAC+25DzZLBylpz4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437676; c=relaxed/simple;
	bh=kiyFPVrkestmBfsR71JLQS9llgbwGzGNCZC8Y35Ux8c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rnPGPygl4s8SPRT0mXXHG5vjnlN0+S5C5nTX/Rhz3blGBcP8u/qEF0lSFU/Zvd7jOcGS6DlBxb+uqNNt5yGJ2tolTD9DqOdw2BOGjUrVl9NGinyo6GSSLZK1ICvZHuHzZVHCX7DrJqYSZyWJthCJIyWoKoyAyKVWfajBJeRPMxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RPcGzTJL; arc=fail smtp.client-ip=40.92.103.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGv0NGHu0LL192j/r6yv9Zz5mlQK7G1tizflsnmklTjFqj8KmVnbDW9hPAy58sIxCehKkEnIi9Q8BQXGz4UpI9H8HT7OGVLnR/hv6g1zKqP860kg0KScYVCfXNoB0THyGw1ElNc8KzY3c/uDYkL5off/TVa+kPpm9LpiJXaKnQO2vLj7M2MJuTKnFpL5wa/dwMEh79r6Lks9tDP4p/duj4q7bRYtc3sP012dQPjh/AKvFAo0hiAIxcYHsWw4HOVloS474mXW2coTU14SqdxrnL0bZZpEaRmIRjbTM9jNQjSisVLKJ9ZVW2U3DW603ZZlC6VCdDrjsxvi9S1mehbTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBX2zPfuZ5GjHrr/JK8g+2cfVCbVjAAW/biNriGDW7E=;
 b=deWNePrC7BxoFWOHrecrfEL4PYtqxwTMLzJSQpaqeV1XfDt23mRyAlmjr82mzKSmHbCkYPl7YT+lWCmgMiAfUU7ZTIN8gfcxVZOTVVTYzEQWGA4TUpFkjTHFoyqdLio4WSbK/F53UUfkGlGDjuZiUi/1zoJvpTpw44gSdJxZtTpRLbAsbIig4nS9cyOUzi5K/6Z2EDMlezHkqEpZsZPXvQ+HzhqFjIHzukRXxJ0hwnZCYWSHtkmDVbGf9fDEjRRMMLGMPed74+4TmuYQUZqGxpSBUzWnrpJfyahJ7QUJmIByUUIwQE+QfGmQWNNKCO+k06nMHkbw4FLV1N61eD4CBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBX2zPfuZ5GjHrr/JK8g+2cfVCbVjAAW/biNriGDW7E=;
 b=RPcGzTJL3BBSeJjW+3vYhmvzBEgE40sGkplt+Bd1PdO61r1Q7MFXRpWMMzm0NSK0jWi+67YkSzzG6Hg8pQ0WMDWT+UYAaYS7TiE1oggQnXJ3rXobFRJ8HLJdE+AyMIaNb8jOYG9phst7HKIS3mBKSuLMnrA7w5epDLL2pkuvSISVKm6bmePZLnj3WtFT9jF4yPaulr6gOyOE/K0hFYRa8j/yNdlhIQGhs8/qLyq3+V4Rlg83kjPFGNVt/+javS/TIrbtBXl3b6LUCUFUhphnHdTmQ7a6dEjWMEC0Yz8Pvvovpc0ek231NBX53wbzfX1OCmcTF6cs5yXCq07pbvm/wA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB1630.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 00:41:07 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 00:41:07 +0000
Message-ID:
 <MA0P287MB28227252F140BE2A281AD2B9FE1A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 30 Apr 2024 08:41:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mmc: sdhci-of-dwcmshc: add callback functions for
 dwcmshc_priv
To: Adrian Hunter <adrian.hunter@intel.com>, Chen Wang <unicornxw@gmail.com>,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jszhang@kernel.org, dfustini@baylibre.com,
 yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
 guoren@kernel.org, inochiama@outlook.com
References: <cover.1714270290.git.unicorn_wang@outlook.com>
 <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>
 <ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [FlW7jZoKia5xOk9j29feLSgmnVZZDEko]
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0320ce88-5e01-424b-9210-6b2677a9ed2e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB1630:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6c8604-ad46-4174-8b6f-08dc68ae394c
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	gt/t3NEeAFK5oo5klL01OM521sDLLg7pIxmqzB/VFz8B15liX7fK57fVoWLx0foHuOanuZe2K29+NFIzONpmtMZyPh9QOi/6iScsM2ECUHY2im1mWFMMqR2m80DkHGpp/fcSLjdzxbiCDnXYJTtBDDigDEEI0Url+yeaZMHj4kEXm8kSxJXkZjsNe3+BU+EXPkRyZx5x4IHv11v8vMDQiz1J+h9Z9qfCCN45PKGwjeocSRgSWHgJE02OefTEo9QvuKOcSGCJs2OwUcM3Og9nXYVi827ldJp1pjyPZmkm6YusLxjKjB7e0jrhHkYmnbzfNbi/cS8P++RfGg3ay8XRA9Be4Cosl4FVtAGbov2gc2ggnr9mzvhEfQ6Wew87ChLZcflnwIHebdnUBNoXqAtTykK3E8LiLgpWph30HUOovcmhmzVXsoSqPkAf0pctV3jGIuGpFfMCMq32d8ZdEp/NdbA+xdxtu45uvf9Hle3y5cNSAMr+rzmg4gH6Y4ZxqZP4vZFvNDw/1+BSAvvX0vRSmhvEPdeomjbTMKAFK/j1FHKDLHNVcV36mL/2NYgN5usf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3ljTFRFcDU1S3pPcm5rclQ2VFU3VDRTKzBaU3g5c0tWVlJMKzZPYXVrbGtG?=
 =?utf-8?B?VElBZVNnQ0xHcm4xQktLNFJvYUcxVFRIbVJhOXE0ck9QaDhvTW1aVURCVjUw?=
 =?utf-8?B?ZXg0bXdnb0NrOUNSLytxbVBiaCt3NXh5WWNFeVgxcW9xTDQ3eDJHUDc5Y0gy?=
 =?utf-8?B?VlFKSFVvSU9ZbDFGbEFDOGxIY3ZZOVZScXFhTUZtejRqU3FYbWxFeVdMTHVT?=
 =?utf-8?B?MDNDQWxESFJEQWd0ankvOEFRMDRKdm02SCtuNjVqbXpvTXNrZ3JISHQ5RXpw?=
 =?utf-8?B?KzhjTkNBV3RqdEMxVVVPV2gwSGUvWXBabU5hdFJvRjBMamIyWjlmc2Y1ZXRJ?=
 =?utf-8?B?OW9iSHBLTkRNVGZ0NndQRzFEb3QyY2daNy9GL2VXYUE4WCtyRENOSjk4Y0VB?=
 =?utf-8?B?bUNtaHlwVXhNWldWajB1RnppK3lVenk1M2hPK3JadlhaZ1VDOW44c3o4dkpy?=
 =?utf-8?B?VUVxbFErNXVLZUlPWHZ3Y0krK09RRkxidnhTRUlteVBrU3hVRlhGZDdGYmpV?=
 =?utf-8?B?YUF0eWVnK1Zmb3FqTENwYUF3RUJnVSt6clNUZEhHN3g2YzJPMDZFZ01LUFRh?=
 =?utf-8?B?ZHZPZFkwbUlOUmhVNHkrUzY4eklPODh0cHJoeVdHUzVJRVU3WHRKN3NoQzJq?=
 =?utf-8?B?cGFxTFdWRDJOaHo1UWJTMGw4cS9mUlhiOUFnY1R0RnR2bHhUc0VCL2lLMG1T?=
 =?utf-8?B?RzBaalUrSWxEUVpPMHppQ1UrMHBjQlo3c2ptaWR6WjFCd3pvcnF6TkJqbTA3?=
 =?utf-8?B?VzIvL3g1ekt2enJUZTJCenNiaEY4MkdOcmk5M3FVOFBKSytzWFBjUU0zTHl1?=
 =?utf-8?B?c1dCTnMwRGp1SEpBTXVHb1NwUWRJY1ViYWVDa0o3SnliNXFHZDhXeTFnTmMy?=
 =?utf-8?B?SWZlSHlDMm51TWs1Y0I5blptcjlISk5LSjlpWUQva1pMc2x5NmlJbG9xZldJ?=
 =?utf-8?B?YjBvQmlvNE9MYW5LRmdtZ1QvQ2pGem1WYzFyenEyd1ViS2thVmllY3dXbmdh?=
 =?utf-8?B?U3JzUXNTUFRwRTlaakt3ei9IM2ZPTHIrTkVyN2JiL1FxdldlM0wxVGtRd2F4?=
 =?utf-8?B?VVFtcnJTV1ZGU0dneGNRRnJ3MVZFRFEwcm9kY294TGMzV1kyNFBHa3NEV01F?=
 =?utf-8?B?MHRZaE5rcFJZQldGdzFsR1A2SHY3czRUaWJjMG5xWFUxcWNod3NTKzh4cTcy?=
 =?utf-8?B?OHM4emMvcDVJRUlINGIxRE9vdFFZNWxqNnJMaXNHRDExVEcwelBGUmVBN25a?=
 =?utf-8?B?eWhpY0dpMERQZGw2WGFTL0hsVXZ5cDhoSU1hTGxqR2JzS3laUmJWbm81YVJ3?=
 =?utf-8?B?V0pkYnhFTHZBYWhLbU5KK3d0VnZjRzY5OFpqVnIwVXN1REZaajF4ZDlnQjEr?=
 =?utf-8?B?Yjc1em9tVExhOHpSWGNEem5BclpoYVlMYUNEaDJNWkhXMnM2alhvdEY4NXFE?=
 =?utf-8?B?Q1o1ZE5rTlBrdnozRmxwNDBSOXVtdjNpM3ErbUlPUVhnT3k0RExpb01ySEJC?=
 =?utf-8?B?blcxZGlpUVVxbVd4bjlDd0Fkam12ZFQzUVdTZ0YySjhLeTQzZy8wSitxQVBR?=
 =?utf-8?B?a0pndEVlM242d1Vzd2ZrYVNJWUNrZVVMNDdiL0ZHY0x2WHJGa1ExdjVRSlZH?=
 =?utf-8?B?OTdmVC9OZld5WE9pQi9tOUxHV2IwdmZPWVhtcEpZM0Q3cHNDRWR3YldaSGhq?=
 =?utf-8?Q?O4tQachDF7lvCUcYJ7Kt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6c8604-ad46-4174-8b6f-08dc68ae394c
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:41:07.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1630


On 2024/4/29 15:08, Adrian Hunter wrote:
> On 28/04/24 05:32, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> The current framework is not easily extended to support new SOCs.
>> For example, in the current code we see that the SOC-level
>> structure `rk35xx_priv` and related logic are distributed in
>> functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
>> which is inappropriate.
>>
>> The solution is to abstract some possible common operations of soc
>> into virtual members of `dwcmshc_priv`. Each soc implements its own
>> corresponding callback function and registers it in init function.
>> dwcmshc framework is responsible for calling these callback functions
>> in those dwcmshc_xxx functions.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 152 +++++++++++++++++-----------
>>   1 file changed, 91 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 39edf04fedcf..525f954bcb65 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -214,6 +214,10 @@ struct dwcmshc_priv {
>>   	void *priv; /* pointer to SoC private stuff */
>>   	u16 delay_line;
>>   	u16 flags;
>> +
>> +	void (*soc_postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>> +	int (*soc_clks_enable)(struct dwcmshc_priv *dwc_priv);
>> +	void (*soc_clks_disable)(struct dwcmshc_priv *dwc_priv);
> Normally the ops would be part of platform data.  For example,
> sdhci-of-arasan.c has:
>
> 	struct sdhci_arasan_of_data {
> 		const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> 		const struct sdhci_pltfm_data *pdata;
> 		const struct sdhci_arasan_clk_ops *clk_ops;
> 	};
>
> And then:
>
> 	static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
> 		.soc_ctl_map = &rk3399_soc_ctl_map,
> 		.pdata = &sdhci_arasan_cqe_pdata,
> 		.clk_ops = &arasan_clk_ops,
> 	};
> 	etc
>
> 	static const struct of_device_id sdhci_arasan_of_match[] = {
> 		/* SoC-specific compatible strings w/ soc_ctl_map */
> 		{
> 			.compatible = "rockchip,rk3399-sdhci-5.1",
> 			.data = &sdhci_arasan_rk3399_data,
> 		},
> 		etc
>
> So, say:
>
> struct dwcmshc_pltfm_data {
> 	const struct sdhci_pltfm_data *pltfm_data;
> 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> 	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
> 	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
> }
>
> Or if the ops are mostly the same, it might be more convenient to
> have them in their own structure:
>
> struct dwcmshc_pltfm_data {
> 	const struct sdhci_pltfm_data *pltfm_data;
> 	const struct dwcmshc_ops *ops;
> }
Thanks for your suggestion and it looks more formal, I will investigate 
and provide a new revision.
>>   };
>>   
>>   /*
>> @@ -1033,10 +1037,40 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>>   	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
>>   }
>>   
>> -static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>> +static int dwcmshc_rk35xx_clks_enable(struct dwcmshc_priv *dwc_priv)
>>   {
>> -	int err;
>>   	struct rk35xx_priv *priv = dwc_priv->priv;
>> +	int ret = 0;
>> +
>> +	if (priv)
>> +		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
>> +	return ret;
>> +}
>> +
>> +static void dwcmshc_rk35xx_clks_disable(struct dwcmshc_priv *dwc_priv)
>> +{
>> +	struct rk35xx_priv *priv = dwc_priv->priv;
>> +
>> +	if (priv)
>> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>> +					   priv->rockchip_clks);
>> +}
>> +
>> +static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> Avoid forward declarations if possible.  If necessary, it is
> preferable to move the function definition.
Yes, I add this declaration just want to make diff look clearer :). 
Anyway, move this postinit to the front should be better.
>> +static int dwcmshc_rk35xx_init(struct device *dev,
>> +			       struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> This patch looks like it might be doing too much.  Please consider
> splitting it so reorganising the code is separate from adding the
> callbacks.

Sure, will do like this. Thanks.

[......]



