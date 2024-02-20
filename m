Return-Path: <linux-kernel+bounces-73203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78185BF38
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19981F2314A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55026BFB8;
	Tue, 20 Feb 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fAEBhUGy"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2065.outbound.protection.outlook.com [40.92.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822C6F53C;
	Tue, 20 Feb 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441039; cv=fail; b=GZG3Wa+IKr1Onnbwi8rqdh8G6LG4hvNGUDRiNZepRH5u1GU9uselvKj78UpnkZtroJYSiRH8sqLfk9vwYe7VQpqznDNfM0uhnuw1inYzHynBe9YAO9GfrLJ+adDg3WaOak9qxbgxcEHs1VqEUKjcUXHfDUQil4i1+1y7iyG3SB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441039; c=relaxed/simple;
	bh=0dV0o2GEDnlWMT/YqHZsv9iV6huXK9I/mgAl3274FWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o9n8i0xTVwVdGOfWLvcMySYVnenVhPnV5Q1z41n9by8qg6f78HJQUNgdxZiOpQehviD7zjf3kfAjTy2+XyV+9AouYmpu8HFl62EH4AQcZqf/uQMyz81Rhl2/9EmaJHAD+BoNzE7sONYeXcyBBzUfDZOVk7Ft7BhAyX4DadjcT/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fAEBhUGy; arc=fail smtp.client-ip=40.92.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmRswL0gkbsv/ZJZx8T3NWzNYu6FPq0UUWR3y8WIZjhhNXu4S7nO1yoci5B98jNVcLiSv8L1gxMCm1KuE7g1K+MWsRxhhI5XSvdfPJpfLdAkbi1WhsD0x0rA4bhN7izNp0J6AxXbM7D116LdUkiQ5JR9S+twgPsPK/76vZTgAt2hWB0KfXqHVXkathqoBxcuxdmLC2C4O3LTG9awPqrCd+8fs/RGEE2nIeiPPzE673PtIxX7weYoY48qykl+wsGNJ3AKa5tURea0zm+HtNgTw0QCYsDYIg41uf8d59VOmBJgZ012NNbUPjLOSzz+EU7kvWPG4PwQpM86UWQMyxgSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=on+q6omrZIA0FBW2dndMuhZyoAnmFamtB1/ZXt+x+5E=;
 b=EMXcLWZPnG0Fka8lBQtZcNcEAePcNWUql9mON2iCL+EJVePZcB+YEpwWZbtfVCxWZqJzXuVM9blwhR4G2PwDPflfILKcdMhNmDGp7RVOvzQyrTWWzsW43944kneh5y8du8mHyOWZeS9T8GtMkuoCb+q/WBpJxteEU7qbSQXAUnDDId7LB7oXESiqfeFgBpGRK9D/p0y0Z0NTUIEbDUpO+o2xN2ixMbv8rfa6/FmQW2cjiyNyAq2uQUI0ti720X/3mFLTLGrTLcN5Q+Vzi1YG0o8Msv2MLlYBElqfHaZr4ghfDPI6uPtDFgsXfONPdeIJZO0PLpdnxWrVTiXRS+XmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on+q6omrZIA0FBW2dndMuhZyoAnmFamtB1/ZXt+x+5E=;
 b=fAEBhUGyDlQwj54iw2Y2XLNo/5vu2iV0eqcjEp/Fmu7fx3xan9IjMNYuJ+OZnxR43McnnXKC9n7uA9FQE9EH4DIfPAgCkPrj70MDh2LpgBu/Covq0QqXRa0pMOxr9HqI3uUqtrVq0CYRUoLkFq6FeEr8vJ/+o66ufh3o6drTVEPy8zahOE3Go4c2IOpXqt3AO7gZ+9xP5rVqh4SMCZabtiVA821DE+M9nROGQB3FcG2MK9er0nYEdE0OBJmffleYFDEwqk80Z43uIijG17dNmnzMXa50YhkLmb2WdOFNKnMaa103qQokRQ7QYXZS2Sp/6iGasCaxGbEEQI4WZJM2tw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB7363.apcprd06.prod.outlook.com (2603:1096:101:254::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 14:57:10 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 14:57:10 +0000
Message-ID:
 <SEZPR06MB695992D70F6002F7568B6D9A96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 22:57:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Content-Language: en-US
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-3-b68e5b75e765@outlook.com>
 <20240220154737.705c33e5@device-28.home>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240220154737.705c33e5@device-28.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [V1VpcjzCMQNMWgVsXNmC8vJgZFvYVLTq2elQKYTUF9UM+z/FKFHC1EPt/J8rEpAA]
X-ClientProxiedBy: TYAPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::30) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <366a6322-6456-401a-abee-29a116a3c59b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: be08d998-e2e4-412f-f8aa-08dc322436ce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lYIw/cd5HoTs2YhWzrAmeQTAsVn1DmnOk92u4FcIL3I/OefUqrzSxrZpHQ9GSANoa7Cb0DZwjJwJ74LcwX6gtdc3v//zixIe6tkUoxbUicS4XuH3QYqmQ09fTqfx3eiHW50BUjSA8p2r/dWStmrismFm5AVGYr4QADRpmPhExz4CoSjTbOKBqarbZSlyiwvtbrVqRCJRM3IskZRrPw5gkLETVnj8/5gA2m6fklyRhm800+ZfgjeCu5IAiQelZ4aX/540qY42GJcqNymYB8zNee+5IP+TnoZqEnf7OvioBAqyKYhhn8yxPyo+6N0tC2Xp0sS9VMMGvAhW3IQb7z7kXpZGhyg2mid77P+HxBZeVmU3L+qRV9EDfFv3i2cGpF8zZvlXuzzzBnFuiD8AWZAEo6KyDGctuVF9Haq6oKgDBUgXuTQoVq/HKOeWG+II/NKssrrGiBnk3gK2zczIHR6CWaLuvP6xLMsG73RhmkDTsZUDKqjXoMdNdYSzADKcQOF/Gr0N2Sbn76k0bRH6l/tgWEhZRHaoLD9w4jqvUM+MKa2kCh8TX9n0wyhWbVPE3GkG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC9neldta1dwWjNXSEwvdjE1UmJydjEydkxEZU10UTJiMS8zUW43SlJna1hi?=
 =?utf-8?B?YW5yeW5wQnhGYTEvQUM2NStRVlByQlZvN1B6bXg5S0RQMmU3ZnkxRldmTlIx?=
 =?utf-8?B?RXlEVUluL0xOaDZWZ0NtU2Z5dkRGVTJvbnI4L1BlTGRna0ppTFNVa3N4TzEx?=
 =?utf-8?B?dEY2K040UjFDY3dITkhRb0xnajBtaTF2OTZOMFdoVklISHh6TXJlM3hnQXNh?=
 =?utf-8?B?VUZ6aDJGaUVjQ0o0UEdDeldzVUxyR0ZqdjVYYkNVTDhqM21nYU1NaGt0TTVa?=
 =?utf-8?B?ajdaYzNudDdnQUNkdk5iU3lWTGFyY2xKSmh4c3o0UWdrTUVDS3lqcjhabDkv?=
 =?utf-8?B?cFJ1N05WUm9RcGhqSEloMkhwanBaWkJ3cGk4Z2JyZE1RSnhyWnFxTUF1R2JN?=
 =?utf-8?B?S3lQMjJId2ZBOEEyV1hkTEFLVVZ1d1AzdWozd1B4SWRTL1dUcklqc1RObTJR?=
 =?utf-8?B?SFBaVkhZRmRMSEMwTWpjb3h3N3IvWkhxdk5FNGZabmVqTTRaT2hMdlFKZXJy?=
 =?utf-8?B?MW9RdGxNQUJ5S2xYajdJNVd6endZL1Ixa3R1MEJtVk5BT0szaXRQV0txVlU5?=
 =?utf-8?B?cFNkYXZXc09Vek5UQW04UktsV2F2NElEYXcreVZvWmFHQjNxUzNyR3NpRGZh?=
 =?utf-8?B?by9BM2VRL0xMekJmQy9mVHd1QVVIN014dVJVNFQwWFlpbXorcnRIMmZNeG1j?=
 =?utf-8?B?UzROdG1ValhtWjJYS3JiSFBVbTU2Y0dpTWFTeUI1RnYxQnhubUVMSmk4bG4r?=
 =?utf-8?B?bFNoTy9Ud2YxbTREZVFObTBJUUVhMW9Oa29vNWFCNE5ORTFjamhoVk1nRVkz?=
 =?utf-8?B?R0dITGxINDVaUm53MEFWbVY0dW04aWR4UEVxb1MzYmYxZGZoc0RpaE5MYUNG?=
 =?utf-8?B?dEhHQ1Y4Rys1eG5qbVNkQnNSZko0VlhvRUg3eXRwVzJicjJaVHZLcWhyaVky?=
 =?utf-8?B?RlByeU9MSDROZVZBd2xvZFJUcjNqN0VmOXU0YU1kejdSNjVBL29qMEd4aHpX?=
 =?utf-8?B?YkczdUw1eSs1cW1mY0FHdzFUQ1gwbDE4NlRZOWsweExURnlSeDgyWG1jcUhY?=
 =?utf-8?B?SlI0YXd1NE4vaGN4SDFBbkZjY0RFWFlDb3FpTXB6NTgrY1AyeXlNNG14bHZl?=
 =?utf-8?B?eDFTTVRyUERpRDVBV2JoWUlFSlY4WGF2amlLRU13SkdtZldzRUlZS3JDNWZn?=
 =?utf-8?B?czZFendXMXlKa2E4ditPUG96QUhic1QxVS9uV1RoeXRwckF0MDlQbDNHZW5O?=
 =?utf-8?B?Y2RrbGZRTGZEK0QxKzd4azMzeUVubGNRTElLazVXQ2JBT2tZeExzdnFpS3Bk?=
 =?utf-8?B?YWV4enVaNDZDTEFieVZaZDlXNkFhY2dPV1pTWGgvbUhmcGttTFU3a2d2NUpO?=
 =?utf-8?B?UTNNSk0wVUU2NEZZTmdDekFRT0g1cFJBQ2JBRjlUbFcrQ3VPOGJXcFN4VWJB?=
 =?utf-8?B?TDc3bHN6a0wwWDNTVFhkbkVUam9VdXNPdFVLa0QreEs1TVArcmFhQm1wb2tO?=
 =?utf-8?B?VGVmRkdzbTRubUtqZ29GMzRVV0hjZEZMRFhnQVZ0UGpPZXlYNTFWaFc2dGdo?=
 =?utf-8?B?eVBhMGE1NHVmM1k2T1RaR0wyQ1pIWTNLaGJTbmV5aUkzTjdIWm5pSGRjQThp?=
 =?utf-8?B?UysyWXhndkdFV3JQeGZLU01CdkxmSlJYSms1bmpjWEluTUJHVFJSUDNTcHMv?=
 =?utf-8?B?VzNoVnJDY291RlJZQ1NUZXRTcFFOQ24yR1lGTWRPcjlPYmRIOGRkMDlLamNU?=
 =?utf-8?Q?yX6ViS9w8CNfYD7G2csHKcfHCYOG023boLSa3O0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be08d998-e2e4-412f-f8aa-08dc322436ce
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:57:10.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7363

On 2/20/2024 10:47 PM, Maxime Chevallier wrote:
> Hello,
>
> On Tue, 20 Feb 2024 03:57:38 +0800
> Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
> wrote:
>
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Register the sub MDIO bus if it is found. Also implement the internal
>> PHY reset procedure as needed.
>>
>> Note it's unable to put the MDIO bus node outside of MAC controller
>> (i.e. at the same level in the parent bus node). Because we need to
>> control all clocks and resets in FEMAC driver due to the phy reset
>> procedure. So the clocks can't be assigned to MDIO bus device, which is
>> an essential resource for the MDIO bus to work.
>>
>> No backward compatibility is maintained since the only existing
>> user(Hi3516DV300) has not received any updates from HiSilicon for about
>> 8 years already. And till today, no mainline dts for this SoC is found.
>> It seems unlikely that there are still existing mainline Hi3516DV300
>> users. The effort to maintain the old binding seems gain a little.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> Besides what Andrew and Simon already mentionned, I have a few other
> small comments :
>
> [...]
>
>> @@ -797,23 +816,22 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>>   		goto out_free_netdev;
>>   	}
>>   
>> -	priv->clk = devm_clk_get(&pdev->dev, NULL);
>> -	if (IS_ERR(priv->clk)) {
>> -		dev_err(dev, "failed to get clk\n");
>> -		ret = -ENODEV;
>> +	ret = devm_clk_bulk_get_all(&pdev->dev, &priv->clks);
>> +	if (ret < 0 || ret != CLK_NUM) {
>> +		dev_err(dev, "failed to get clk bulk: %d\n", ret);
>>   		goto out_free_netdev;
>>   	}
>>   
>> -	ret = clk_prepare_enable(priv->clk);
>> +	ret = clk_bulk_prepare_enable(CLK_NUM, priv->clks);
>>   	if (ret) {
>> -		dev_err(dev, "failed to enable clk %d\n", ret);
>> +		dev_err(dev, "failed to enable clk bulk: %d\n", ret);
>>   		goto out_free_netdev;
>>   	}
>>   
>>   	priv->mac_rst = devm_reset_control_get(dev, "mac");
>>   	if (IS_ERR(priv->mac_rst)) {
>>   		ret = PTR_ERR(priv->mac_rst);
>> -		goto out_disable_clk;
>> +		goto out_free_netdev;
> When you return here (or even later), you are missing a call to
> "clk_bulk_disable_unprepare" in the cleanup path


I didn't notice that. Originally i'm using devm_clk_get_enabled() so 
it's not needed.


Maybe we can add a devm_clk_bulk_get_prepared_enabled() API to clk 
framework too.


>
>>   	}
>>   	hisi_femac_core_reset(priv);
>>   
>> @@ -826,15 +844,34 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>>   						 priv->phy_reset_delays,
>>   						 DELAYS_NUM);
>>   		if (ret)
>> -			goto out_disable_clk;
>> +			goto out_free_netdev;
>>   		hisi_femac_phy_reset(priv);
>>   	}
>>   
>> +	// Register the optional MDIO bus
> I think this comment style should be avoided, in favor of C-style
> comments ( /* blabla */ )


Will fix in next release.


>
>> +	for_each_available_child_of_node(node, mdio_np) {
>> +		if (of_node_name_prefix(mdio_np, "mdio")) {
>> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
>> +			of_node_put(mdio_np);
>> +			if (!priv->mdio_pdev) {
>> +				dev_err(dev, "failed to register MDIO bus device\n");
>> +				ret = -ENODEV;
>> +				goto out_free_netdev;
>> +			}
>> +			mdio_registered = true;
>> +			break;
>> +		}
>> +		of_node_put(mdio_np);
>> +	}
>> +
>> +	if (!mdio_registered)
>> +		dev_warn(dev, "MDIO subnode not found. This is usually a bug.\n");
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
> Thanks,
>
> Maxime


-- 
Regards,
Yang Xiwen


