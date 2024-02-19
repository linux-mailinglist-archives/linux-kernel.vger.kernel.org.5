Return-Path: <linux-kernel+bounces-71623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E871285A7EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E478B24B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8BA3B18D;
	Mon, 19 Feb 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cPfZGq1r"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2024.outbound.protection.outlook.com [40.92.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFF1DFE8;
	Mon, 19 Feb 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358220; cv=fail; b=Y0ZECNK5x8NF1uRTyScdNrpIn0q8HmGfBZ29dnTxVECfBdWzBFWCrXuj6zG3Db4XXum/Qw7vHgJGPG/wz3X5l75NtZp2+0IuMcq9FIoNIKSVdLsjSkG+a0L0bh4kRdSdefFUnuOcTCVOvR9lqcWkbFxbIepdp8HrDmXXCb3C6zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358220; c=relaxed/simple;
	bh=h/ZALkrNjBD+DN2kWgJXn5zPWQkyOBGEaDktEflveDA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G9MPp1vUoXK/ZrwADI61o2bb9LhLgbESyNZPCbX1h8dOKkZucewCSuRJ7lVP8BvnQ0iqxkqpcSkjahBqENCPkXRm4ToQfreUgT+YSKAphp/cnb6hsWQ+YHqsBE1J8O4Dm8dfliN6PAVJ4LMCQBH24mHsaGVKwOcMSBXdeXgYo/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cPfZGq1r; arc=fail smtp.client-ip=40.92.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ4y6XBSZVZsb2eSCQ40J0dHPIUVSBqTn5FEqZrwN/PsR1SBoQQEHhouG8O1xnGZ75r08T3WSpqH89vhillZYGAjDqwhGiSGJx5NbHmgRxVJmhHZjf3qAzrVpMA7qN9njWmID6S9wZfPWHAQL6VDyUa/RcT+sHO9GpMPMIrcR5iRzy6++cAbd/aT/mMsatBIcxJ1vUZZUPFlUkoEPYdsy30FpZgEs39VzxgyHFEgS6MY62ie7Bm7MjskCuZyiFo588LwEkiuWXWIvAH7FSePp7eomtBrLj423SjNxf7WWudSXVDbdwNcEZ2TAsfiGo+ibauDRERCad4PGC+i3tOaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faohQmhY9PxliFMJJTev2O4hahpWTrxm6nbIV+473Qc=;
 b=HNwotOKZj9OT+Fgy7rwROGkwJp4Xdt/z+ZzVdKVnQ+SAc1TBPs22MpbKQBoxLLyrRUz710HCxK8vBc34gWZngrNeT8MvuKX6CnoO1Y6BWjmKwLhF5BcNV8U7FwQx5Q9Iczg+DSb0vB9keD/8vHMk360gIrjaIHe8h5NZW+WQavXLhdPuNDYLf2TiQoqiYJczPBsk4eab93d+VPLBcl50/jlAE6bWpshCXy2R7dybvdfhcmlI1ext38sJB9EWvkLwAJT4iYzmkfhUUvdXPOFFW5aWHk1qQo5h/GkLZbZiSNg3xKeoRaM5QYmIVAGg7DlEagiKzhFoQ2MG1i7AmAOxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faohQmhY9PxliFMJJTev2O4hahpWTrxm6nbIV+473Qc=;
 b=cPfZGq1rLb1MhmG2vjwppHVcXfD//2bKznZr7AA4/QAyxi6krpOEpH4qW8U5C5eAwrWjfi//8834Fb618TCZdla97Drgq32Qt5FSm50kdrxpVoziEjGtSeO/IVH2GDbXlbutM+6wn2Nle28WITFrzlntogzLWKEzNFXhOd6oapfkFtFlvq+9mYJ1fzw3fhcgj89LyVHJXAL8AuM0mL6cADAw8SB3OBzpNdL67aA7xyhB9C37JszBZ+LyGCCPK8oMAYpNNL2pD3hnSOjDhye3QdgmishiS1llf+0HOsP1nLVTX/TO1oheDJHNNpuX4kTVhDUdr8pudIJ6L9seRvCu8w==
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11)
 by TYSPR06MB7483.apcprd06.prod.outlook.com (2603:1096:405:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Mon, 19 Feb
 2024 15:56:53 +0000
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::c971:fdb5:84cd:dd71]) by KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::c971:fdb5:84cd:dd71%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:56:53 +0000
Message-ID:
 <KL1PR06MB696494800980E97A1CBD449E96512@KL1PR06MB6964.apcprd06.prod.outlook.com>
Date: Mon, 19 Feb 2024 23:56:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
 <20240216-net-v2-1-89bd4b7065c2@outlook.com>
 <20240219155346.GE40273@kernel.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240219155346.GE40273@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [GG01HwWAa1FZ6a0OKSswIQ0/hdkZcAZ0dNtUaxS2XADeYCKLuONZHdaNrpORaV65lP0waORTR7M=]
X-ClientProxiedBy: TYAPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::35) To KL1PR06MB6964.apcprd06.prod.outlook.com
 (2603:1096:820:121::11)
X-Microsoft-Original-Message-ID:
 <2790f5d0-16a1-4b29-af36-b5d621570bf4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6964:EE_|TYSPR06MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 91be3064-3ca1-419c-a940-08dc316363e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PqG85d+RQcLo5jRizOrdcHhs+v4Gdl7eezqlgB8b4AAgBRxtYafE62H6G1ejm1Wd+c/Dl/G28XDSJRQS8NjmIJdfsHDWfYMpAf43xinKpCbwKBbq4p7iyjjujruuB1jEahoNkomhCwqVhdCXZUSSOl+JPtOUDPzR+i+24UBm4URjmosz4tPVFcAAAURQigh95PNzwYMqRt1ZEoi0Px6ex5TSQaaKupp2P2lvyHNkg6G6Vtm7M4CTnq/ySDA1YXntsx925PT0AFAFMngyuFdAVUpJRZcP66Qo5Up9plfuO+B6GzCRcO0P05KMFGAXc1y/DKPIbCrQa8+oVwqb389LYWBS2T9btFe+M6ypBcNnplHxXcBwVHaZ7tXohE3tbkWXhLQG5yC7Ffoi4yzFNRiPTVEDIebrtetVC9Y1WXs3mDookadNJ3Klc8q7euLzSp7WwoywnuaDGdKG3kk0c0r7beo3eCYn8YwGbUq081Nqcd4EXbdjh+02yb5/zA1SjBJlEB91VbSXOyZVdBk2TG1ZKqnAHg8x9M1lEEVIEcyLnjTcR9sJP+/20eU9buV4ezu/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzA1amdjU0NQZ01OMXkrbzFJZU4zalVDS2hBM0RHT3ZzcnZmelVMM0QyYWhF?=
 =?utf-8?B?dkZ5L2lsaU01R3lQekttalJNL3B5RjJ1TS9tN0ZqeWJxcG5kUmFtK3VWYW93?=
 =?utf-8?B?MTlWVVMwa1RpbE5pUVhpb0lWZ1BBUlBaUW1mSDNmUTJjcnV3V1I4Q24wenBC?=
 =?utf-8?B?ZG0wY3pKUUNvZlNKVjFkNWxSMTE2dXFLTm4xWUtSb3p1OThRdTIyUmh0Qm5y?=
 =?utf-8?B?U3UwcDlSU052dlRXWHErWlRLTTNlMzNTaHdhOGxiRk1ISlhZbUlubFNzMXVK?=
 =?utf-8?B?cEdCcjBzUE9zSzMyeFpmcGZEbWRFcE92bWwrSUw2VFBDazV4RUFyNjFIMWhx?=
 =?utf-8?B?VUgybGo2SnZSNm45YUswTGdCa1NCbEd0VjhJL1ptQlVLTXIwWjM1UzVYeVlh?=
 =?utf-8?B?dW1yckNrd1J0SDRSb1ZFYTRYdENFTEhMcXB2ZHlrUlVOcTZkTjFweHFCSmdo?=
 =?utf-8?B?alFYWFFYR015dk91LzZtZlhKWVh0RzdjMmlvVnJCUndxTXNZcVFacitTcjZO?=
 =?utf-8?B?WlZ4Kzc0bWcyVHFJcmc4amlHWlpPbkFsMTRCcVpmZXhmN2U2UE1sSU9hV0s1?=
 =?utf-8?B?ZEw4L3pFcUV2MU1oQ2ZNa2YyRE43MHJHRlhHWkJqMWJxazNId3dCcHVKNVls?=
 =?utf-8?B?NFlwbFB0UzFZNTJYMGwwcWR0OExQckRObElrVTdoS1N5Y1JaVUxrRWNCS3RJ?=
 =?utf-8?B?cEw1SkYyNlNlbDNhRWFBQkU4K2RqWlpxTWN5RjN2VDQyQzZ4RW9FVWFyaG8w?=
 =?utf-8?B?TEZLaW1sWHhVc3JNSUl0NWVNWlNGZ0lUclgvQTl6ZHpqZ3JKRWNHR1BzQ2NG?=
 =?utf-8?B?bkVsNy9tcWxNS1pGeDJkZ3RKSjhlL1Q1cGV0RlBWelUrKys1TU1hdy9MYzdi?=
 =?utf-8?B?N3NXY2xDdkVjMldQTTZqWEtoUUtQMS9WVWt3M3lVQUszZHBUMEJWY1hBOWJk?=
 =?utf-8?B?R0pSamdrODlCUUhlU2QxNkgrOXpFUHNvQ05ESjRnWWQwcUpTR0pTeHNPLzVT?=
 =?utf-8?B?UTJhZlF2VC9wcWhnZ3NFc3BDOHBWdzY0bm9PempFa1VQa2ZVRnNSdGQ2S0tT?=
 =?utf-8?B?TTRPMGx6QkpHbG15STlsRUxzazZNTmtCS1VMTUdPbXJHQjcycUNMVFNBRVN3?=
 =?utf-8?B?YldSSGZseDhUZlE1Uld2M282anE5aTBEcXJheDVUTC9WM1hCdnhkbnhZUkcz?=
 =?utf-8?B?SVIvTHYrVWw0N1o2QkhaOW5nRCtoSGZ2N2hnY3hMMm1WWnlVa0xYcmxVQStm?=
 =?utf-8?B?di82TXFwU0o1K3hPY3lLaHl4VENkamE5UHBSTEV5cG5XTTN6WGszYmdYaHYz?=
 =?utf-8?B?c21kSFFYQ0ZoRXF4eGxsYXl0enkvWE9sNVRPaWxxaGNyWEZVWCt1Q24wMUNY?=
 =?utf-8?B?NU1GUnNTTHpwQWJxMFMvQWJEVjQzQU53UTFiWElvdFp6TGo1ZmRxVEtkbWdu?=
 =?utf-8?B?YmtUOTRqa1h0bUN3YWZYdkRZMFI3aXBxUDFQMHVmN0NoSFljYXYyYXFSRmxJ?=
 =?utf-8?B?dkhpNGd2a1hHbnNQUzRjSDhXRGVzTTRVbEtidUNiZVhoU1p3MkxodXBEVWRq?=
 =?utf-8?B?aDFaZVI2SFpkeVQxeEtabEcxSnc5RGY5MXEzVmFWUFBiOFRRTWZwWURKRlo5?=
 =?utf-8?B?bmY5K1MwUWVNY3dVVHlLYnArQjUwSmxYbEhEcCtVOEMvV1dPMXA4YkxIOTg5?=
 =?utf-8?B?c0dWck01Z2FSRysvOXlQNEJwVUlzL25RaWtOR2I0citDS0pLcUxEWmxjM0tq?=
 =?utf-8?Q?6UAQwW2d+Mo90dy1IzgxWmVl9IM4xHsJCRNKXhx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91be3064-3ca1-419c-a940-08dc316363e1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6964.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:56:53.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7483

On 2/19/2024 11:53 PM, Simon Horman wrote:
> On Fri, Feb 16, 2024 at 06:02:00PM +0800, Yang Xiwen via B4 Relay wrote:
>
> ...
>
>> @@ -826,15 +847,32 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>>   						 priv->phy_reset_delays,
>>   						 DELAYS_NUM);
>>   		if (ret)
>> -			goto out_disable_clk;
>> +			goto out_free_netdev;
>>   		hisi_femac_phy_reset(priv);
>>   	}
>>   
>> +	// Register the optional MDIO bus
>> +	for_each_available_child_of_node(node, mdio_np) {
>> +		if (of_node_name_prefix(mdio_np, "mdio")) {
>> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
>> +			of_node_put(mdio_np);
>> +			if (!priv->mdio_pdev) {
>> +				dev_err(dev, "failed to register MDIO bus device\n");
>> +				goto out_free_netdev;
> Hi Yang Xiwen,
>
> out_free_netdev will return ret.
> However, it seems that ret is uninitialised here.
> Perhaps it should be set to a negative error value?
Oh, you are right. Will fix this in next version.
>
> Flagged by Smatch.
>
>> +			}
>> +			mdio_registered = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!mdio_registered)
>> +		dev_warn(dev, "MDIO subnode notfound. This is usually a bug.\n");
>> +
>>   	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
>>   	if (!phy) {
>>   		dev_err(dev, "connect to PHY failed!\n");
>>   		ret = -ENODEV;
>> -		goto out_disable_clk;
>> +		goto out_unregister_mdio_bus;
>>   	}
>>   
>>   	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
> ...


-- 
Regards,
Yang Xiwen


