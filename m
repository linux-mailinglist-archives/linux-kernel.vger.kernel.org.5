Return-Path: <linux-kernel+bounces-67565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F008856D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4111F22B91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C748139597;
	Thu, 15 Feb 2024 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZBj82k6M"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2059.outbound.protection.outlook.com [40.92.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B41386C6;
	Thu, 15 Feb 2024 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024845; cv=fail; b=usYSvSEAUdLmjPdzo2UOHq3vYMmVZZnH7Qo3ynni9ZY2soen0odN2raFBbyhvIjSHzBbJsEx5kCNoVHJ+YZijrnZB2BM1amXk1pPq3uaAjiJDhXzwcSWlclkPzG+ebzkVlvcUZ5TML94qGp0b7KefxBy2kHRKuai8tzwlfS8oqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024845; c=relaxed/simple;
	bh=g35GVFCxZ7cYEvFUsB1lBCLN3K3leMG5X+Rb+PxF7ig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=heGw1LAiaohR86uEB7MM7W/HJ7xxIs2hAiyC/wKZkX1e+K/PW6taFxxpldzj6mlMO+yD6nFtkwVMwErKJjJMst5EfDJNYAt+HZGsJu34gnPkca44Ux3rIlDFfZ+0vKMHG8D2lz5mp1O6Vdjl61+YfYBnrM6rEhvfQFWmXSaoqAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZBj82k6M; arc=fail smtp.client-ip=40.92.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKYijb1ZmKbOrRcqXWMel7m+qkq9nVUOPgr/xciEg4aft/UEm7PhWCeI0NXIJEXgTt1Q3tDla1Q4k46V9sSfQ6zFDZ64riTyfBBKxuHE58M/Z5R/ovdF7nadt6LG5BN7YhOkr3yMPxymirY5c/fHMHPzkoKfOnZtOfEa8emdAn+X6gPe0rB8yi29iqG2G7+jXySLkev96b73LG7g/PeWxRQar7cKQveDaZzkeM8ukfNGY5+cOu7SQy8/b/XT3O2blImHQd1g4TbXPKtlv9CaabX38k/KShvND4gX9wnTo/T771lv1TL0l3O1mYFiQ6mvAvq/ZQy0rzB2WBTUTfQu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGLIhcXfaEaza4ey+zPtnhnI19xVJhWKLxLSTiRGgKM=;
 b=cGYOXgoaVa7M+Nt5He1z+HT4FMXqRrL7YCMSQtu6h0KAohT50yuILMX5Hu1eYSWLLVF0ACajKrs/ksJFavGuXcmLfi19RB0ETYjMJC770iSxeOINkJt6TTjxqqH7C67iiLNxJ7UlkqOyoTcLRojd/5Ptuc+02qj/ToUaClZbNPDvOR5Z4PvyK2H7luclIjmraZTfQaIVyltFcBIVv6uO7Xptpf5WOMtBVdWwBGAN/kjh/piTZ/mKZmW06aZ8LNaei0cWSLTRpK3RkwNfvR8tAKGQADhyvfcWuwGFNPVUdlgeGvcWEMo5f1Lpf+U+4ZIkcAZGV+v2WX0CEYKs2UdFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGLIhcXfaEaza4ey+zPtnhnI19xVJhWKLxLSTiRGgKM=;
 b=ZBj82k6MlsTGL7kGZJ+SdEPSMzZNiQBjT/rjJZgOunaczI9UJtgnvnm2xgDb4kT8n8UDCVP8WCYSxCRUTSKBaUTrUv7t2KMP1cWIDgSStzDAqLS41cvHxupsdr4LCq1h05LVqe3R/lBI5fBc8Fh/II0Tw7oPfOT8vuxJVyg5pSVhgNTljDtgtA8+uNykfpC9G1g2gQQ5oTmalguuDMuGL3Eyy7ShinbRwkOzPBsGNEJR7G2Bgc+MMdPC6yCoqGaTBHb28xq2NoJD/1mL6SL+BP3N0/ci+7xrOPBkG20jw9I8ET6zbEpVl2DH/cdWMMtoq65eWJZMrlHJdvkqQrrDxw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB7389.apcprd06.prod.outlook.com (2603:1096:101:24f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 19:20:33 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 19:20:32 +0000
Message-ID:
 <SEZPR06MB6959B783D324C7EF79095FE2964D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 03:20:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
 <20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6@outlook.com>
 <682f2d6e-31fb-418c-9622-d3e5ebd4ee7f@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <682f2d6e-31fb-418c-9622-d3e5ebd4ee7f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [SjH+NfOGzzNeMvhD0ZYfiKkS1w1p6whacb5lkyFaiu6F4zguTf9prH7mE5P+lcX86POoXtGqG6E=]
X-ClientProxiedBy: TYCPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::7) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <718bc55e-a086-458e-b2ae-e5fe55a48715@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: 07095a4b-0505-4a0e-b3a2-08dc2e5b2da8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cclkLH31eV2g/MwjOIaGxjyNQzShVtGHCxNiSrmoEZRSVXQW6sYk1yZBbxVMYz2y7a6gVmBE7znWTkUR20TK+8cCMNSLquyUBsy6at0Stof1O20FQWTJYFQBPqhIM71gwB8fW+hS7/UVjkggGUII9CU+d2H7uQPsS4FLhs+IZ/ryzOIC6mR96TlrtuIIvmGcXjZYj9Haaam+pQVLBfPs4T3TeiAL1wiAP49bylxx1q8EKnEqTmbcwlVUBxaJAtwv1WX9tAdEmhCK2Z1NpgWNaJr32MGbcr13ddnIPDExnED4MeLKltDutjSy+vdpg5hWRSnvdkaLz2Jol9cOGvPK1zujVz6hEROmAUFycbROXjrn4Pnw6hwC6vk4kO/wz3rBLcqX3mKDyPbYbyVobMEBC/FMLrOPah2r4quwPsGo6aHWOw5BwnMtDBvCokaVovYmGgESRlLVMnk6/TVQ6+ArUBe1XnTXEIJPmhyF2v1tBUN7i1KMIEgACPUznDzHY55u7OoBiJv9y5/lZ5mi1cPPvSkRFvxl8P5F+7JHSBZHkuqczyrhfMoEG35cjrHYrpWy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTRiSEgvMmNldGhYcjRjVVRiNk1GaThxbHQ1RVYybUxQZVk3ck5hNDVWbzVv?=
 =?utf-8?B?MjBadXdFNmVxbjFod3drQTRGNEJDMk44VXo1MUo2dmxqNnFqbzl1YlhrekNU?=
 =?utf-8?B?ckZpdzMrZktNTzhLUjlCVUVWd0lieUFUOVpLMkZ1b0hXVWVzazJ5VkJhSDlI?=
 =?utf-8?B?RzZoWVJybnJsdGY2ZkZ2UnlGNmZUdjI4WS9GYXlQSTJEeS9JLzlQdW5RRXhx?=
 =?utf-8?B?MnZrU2xIN0laOTQ5UEhsWktnTjRNTTZKTEpJZTFGOEErci8zd3RvdCtCQUV2?=
 =?utf-8?B?OGVPdDF4cStTb2xieCs4MkhoMVI0c0grUlNoWityTnNhcVJOYnpFYnZMaGQz?=
 =?utf-8?B?L1NJU2pSb2R2TlhZaFRnWnVueTU1TCtuZ1VGZnJ2S0V3eHJsYWthMkRZUGtW?=
 =?utf-8?B?eUpneFZFeEo0SmZrMk5mbGZtUXNXNzV0Nko2dFlaK2pHMGdKdGxTVW1IcmRS?=
 =?utf-8?B?cUc4dXYyS2VWTlcyaHFYbDlLKy9maDFiTEI5T3Vyd2FybjkxejBMakorRk5v?=
 =?utf-8?B?T1JBR0lqeEcwZy9kRHpGdExmSTRtbnVmYVNlTHR3L0J3dWtqOUJLcU5Vano2?=
 =?utf-8?B?M1RKMkJ3RWlXa1JpTWFrU2lHbjI3K2ZUYXRXMGkyVmlSMUR1NXlKMktEc3d3?=
 =?utf-8?B?SmtPak5pQVFYUDdnSDlCY3c0SGRaaDQxT3RpTzhYby9PK1VhMmdYbWFPRzVt?=
 =?utf-8?B?cm4yeGh2MnhBVm54SHFuL2pPTitZVkV0OFZUOVdXRHVvRHZqTU8vWGxKZG9V?=
 =?utf-8?B?QlhlNVNiYW5OZzByZXNKZkpadDViSm5tZVZtZVplaHo0dkwrMWowQW5xaWFq?=
 =?utf-8?B?K1JTaFFyOG53dklMTWVzbzkyMGZvZFJWU0hVUXhXd3NTUVVZUHRNL0Y0dC9l?=
 =?utf-8?B?aEU0YnY2cnFhS1cxdWk1c0hscXQ0VGRSY1ZvZnNDeEhNNFB4WXVHeERmNlRF?=
 =?utf-8?B?bitaZXpkWUJwcS9YdEROVnhiYXlhSUw5QmU2NzMxVlkvbDE0RDZ2aE8ySUJj?=
 =?utf-8?B?bzFoZWE3WDhxMTRrbW1VMFdCaDh2eVU0eXg4V2c3QXhNNmw1QURNcjFWUDBB?=
 =?utf-8?B?YUFqUGZMSzMybFA4b0lMM2syN2VpRDA2SDk5dW1LWDJUMC9uV0djVlEwZHgw?=
 =?utf-8?B?VVplRHgydmhPVk5vVkhCQjJYTU1PYW1abTYvWElPOGRmVVV2VmZUTVRSNmFB?=
 =?utf-8?B?bEJiQWRXRVU4aFg2Snd5NEd2aStUejFhUEw2SnpUQks3cVVXVXFPcFdNM1pZ?=
 =?utf-8?B?U1dmKzhmOGhlRitIcTV6TmFNUW5CSXJnYXduVGJ5d0kwS0ZVUlRLc0hHemNk?=
 =?utf-8?B?YlpEL3lpZUg3VW5XNVQrT3hZNWxKdlNWSXljdGt4aTMwWUI0cThIYjU0NEM4?=
 =?utf-8?B?K3hZMmFnbzVNMzVDVGRvc3lTYmJBRGRyZTgyWmlCcmYyZEdWN1ZLdGYwUmk5?=
 =?utf-8?B?MUU3OGZjbi9qaVdKVVdXWWxpOXhRbS9OM0VpT2R1dDFXcGszSkc0cWQ1RXBw?=
 =?utf-8?B?U2tTTUdiL21VSDE1K1JCY3hDMUxVR3Zka3IzQzF3SDF2U0l0ZHE1d1RqZ1pB?=
 =?utf-8?B?UnEwd0pxL05FVVZKWjBQTC9HTVR1Y05GSHVIb2hQWmtLTmNMY256Sk5aYWly?=
 =?utf-8?B?NzM3UnU2OXNsNytaSGlmbGxsMjNOQ05RTHJCeTJZZU4yZnZJb3JpdVFaK2Ns?=
 =?utf-8?B?MVBWbHB5RlpUMEFWbC9oQzU4TkxuL3NHVmlJb2g2QWtMM3pkaDRSZkZIUlYz?=
 =?utf-8?Q?z8ljiAzfvR9BhX1r+8+y1pjAeU5MfB8007WK7s7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07095a4b-0505-4a0e-b3a2-08dc2e5b2da8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:20:32.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7389

On 2/16/2024 3:15 AM, Krzysztof Kozlowski wrote:
> On 15/02/2024 18:46, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Add support for Hi3798MV200 specific extension.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>
>> +
>> +static int dw_mci_hi3798mv200_init(struct dw_mci *host)
>> +{
>> +	struct dw_mci_hi3798mv200_priv *priv;
>> +	struct device_node *np = host->dev->of_node;
>> +
>> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
>> +
>> +	priv->sample_clk = devm_clk_get_enabled(host->dev, "ciu-sample");
>> +	if (IS_ERR(priv->sample_clk)) {
>> +		dev_err(host->dev, "failed to get enabled ciu-sample clock\n");
> syntax is: return dev_err_probe()
Will fix in next version.
>
>> +		return PTR_ERR(priv->sample_clk);
>> +	}
>> +
>> +	priv->drive_clk = devm_clk_get_enabled(host->dev, "ciu-drive");
>> +	if (IS_ERR(priv->drive_clk)) {
>> +		dev_err(host->dev, "failed to get enabled ciu-drive clock\n");
> syntax is: return dev_err_probe()
Will fix in next version.
>
>> +		return PTR_ERR(priv->drive_clk);
>> +	}
>> +
>> +	priv->sap_dll_reg = syscon_regmap_lookup_by_phandle(np, "hisilicon,sap-dll-reg");
>> +	if (IS_ERR(priv->sap_dll_reg)) {
>> +		dev_err(host->dev, "failed to get sap-dll-reg\n");
> syntax is: return dev_err_probe()
Will fix in next version.
>
>> +		return PTR_ERR(priv->sap_dll_reg);
>> +	}
>> +
>> +	host->priv = priv;
>> +	return 0;
>> +}
>> +
> ....
>
>> +
>> +MODULE_DEVICE_TABLE(of, dw_mci_hi3798mv200_match);
>> +static struct platform_driver dw_mci_hi3798mv200_driver = {
>> +	.probe = dw_mci_hi3798mv200_probe,
>> +	.remove_new = dw_mci_hi3798mv200_remove,
>> +	.driver = {
>> +		.name = "dwmmc_hi3798mv200",
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +		.of_match_table = dw_mci_hi3798mv200_match,
>> +	},
>> +};
>> +module_platform_driver(dw_mci_hi3798mv200_driver);
>> +
>> +MODULE_DESCRIPTION("HiSilicon Hi3798MV200 Specific DW-MSHC Driver Extension");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:dwmmc_hi3798mv200");
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.
Will fix it in v2. I simply copied this from dw_mmc-hi3798cv200.c and 
s/cv200/mv200/. I'll remove it for dw_mmc-hi3798cv200.c in next version 
too because it seems not useful in that driver too.
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


