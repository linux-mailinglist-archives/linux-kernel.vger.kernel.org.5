Return-Path: <linux-kernel+bounces-68653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6B857DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3676D1C24D18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65512B153;
	Fri, 16 Feb 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SHiHTh0U"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2086.outbound.protection.outlook.com [40.92.52.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6BC12AADE;
	Fri, 16 Feb 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090901; cv=fail; b=X9AbY3DEz8sdZ8stLlFQh55NutoLUqA2D2w4hLSPJWXmT7eD1dJor0nfD8hMO/1XE7ZQ1nvTNj7vbiLhiLyrhHoXUPHmzgy70MFCmksxfWvGWYEQFxWUgiIJZyiyWZv7JdeTX3XDI43qwXx48jakHpFKAaUnwd5ynRkMF2gVibw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090901; c=relaxed/simple;
	bh=JvoXsWnZUrfyJ/Mq4dljnJk06FX5lrarkIgZ1BX0g+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rrVXGVELStrRkBJOuTBWzEuyK+Wxlckl0VSTuG2AXoNq00kfLN+rDyVYJ2fHs0F44fGzpZidy5kzalALZ8GhOlX5sDXdbLxI0eKBCP4ar32oT0YoQe/7nNGqxuv1KgPTVk9ldddcVieI5utNzLo3ZcNZSTaIcMpfq4qbH05OpKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SHiHTh0U; arc=fail smtp.client-ip=40.92.52.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHuQCNTsqGAOLt2HlY5bIqLz8JYIytUAZcX6RgAl0fOnx5GqdQXkFahPhozIPHJzLiJ7VwvwqYsdm7lD0ncEkmv6S08IOsnXpM1QIXMpp+7JLkKmApvXvkjnIRSuCJor/j7eUfZeRXZTGsTxHQvAb9yFqTmLPSwytWAE9vqWrxA/9/utqMcZpJn5LeAgpdYKKls/wTGKh5OXkX4H66G4iZfpKskKTZIqVlq1vc7LnTtNeVNHxgILl8cMwvz7RfNrPS+xberitWPZZTrByGcYlt8uiWYAP9jhTsmWVvKqypNhe/EiT2GesFd5WWuL7lxNOIWZahn/wDFA6eQv/5JUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAOacMmyYUAZp2HKi57ic9JDAMueGN2FrfYOyztnTAI=;
 b=WkBWIpCc9Gj5UCk7nKDnptDv4IHXq6fftdAp4cnAt+S33RQg2t0+xsePJSZrRYUiSLg2+LdUimyyxDeqeHMsl3UjFX0dPUpLLjr/mb7MSohAwamUqpGq2wU3UKcGaI9xvVEo4vH0hsMcvhuENF89D8R/G33zPChbzHcSxZK//RBP2ApOiqoplJKISfUmy6nrb5QcAE6EAE25UZsmeWgPFKWswIjYWml+0oFEXoHMQ11KGOW6p92MORX4pJeAEbeFKL5tOLmYRDv2MCbM/0NY57RRVNKqCTg6chwjxUQ51G2QYryJJRXH1fhqNeMZC+MZgWXcSmP6eFRArkJi3gat5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAOacMmyYUAZp2HKi57ic9JDAMueGN2FrfYOyztnTAI=;
 b=SHiHTh0UHkI7ip3nfL39MIBM7du7OeHr2hd+KkjlKibe31pO7DwgK6RDmgDqjPBNlaB//l9b/+DXNc7h4YApK2JdVzKVzu5SdljPxpOIgfevP7JcIV2uBBDarcjp7XKCLNublF2k63TBZoi+qjf46wNokjQmEomwl2Cq7s6eyaz9FPShjkaJv82stl46b/AAHbGj8w/iqop+KfOJbg6/S3jVE3WjAgPoUk5MUzjqtKXOuosRAKwh7ooLqbIz7qblz8ZzWVMd+CAqnB9icpdqESmXVJdpR6CPTaWA1zRw0L/FMyQB7USN6Y5yV1aRSeWaYyZkNx06QTV89NF07OOBAw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6075.apcprd06.prod.outlook.com (2603:1096:400:33a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 13:41:34 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 13:41:34 +0000
Message-ID:
 <SEZPR06MB69593E00C6A69AFAC61BF2BD964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 21:41:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-1-e0ad972cda99@outlook.com>
 <d3ac4638-d0bf-4c6c-bccd-519ad1f4dc5e@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <d3ac4638-d0bf-4c6c-bccd-519ad1f4dc5e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [1wpjFpmmUBGEHJvEiND0EKGpM/ma1q6XxaoUflPs0Pco2RQ8uxlRFvUdYT5HaW8g]
X-ClientProxiedBy: TYCP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::18) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <a10df8d0-6755-4041-bf1b-660b750f48ad@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bc7fa3-81e0-4bc1-d47a-08dc2ef4fd45
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eMQZtueMIEuUrFrwGdpSlVRqqyUJRCsRQvrhd/v1wJ/lOH8tteixDFhZlstcbnkZhnLEcq2HVw2YM320bJnfzwHKCZeUCMZ5R0KzSk9dM5z7BD7NKTRUB+zav0imgxbPFr/YJ4yrPra9ulmDe4iUxNwefo5mqzRehcyowTMeW5/3tcGrOLxDofGmNVMi9E9N27Is2kpLwDIecrGJRj8dbDYlslCHLtMcQyio/zth7d2KKsyUi4nIEXcUfqDhrqsDuGPMCsvcqBPkzyByZGUsJIkl6KmtkXc0Yniy/A1mGujewSEZTunlfQj4/5xZyA/7fMSqST8bsRAVpyRmgbs2TBeip5OqqZkkP38sZAPxepN8GixYh1KNYXQlifYwpMM7wQzguZRD5c+gmf5M8uSCi/DNL0Dz0LmtLGXFLHd8OF0imt3kS03OtZSNkuSuqgwJEMM0cp1JsmYB/yYn98+e5OZM+KG1r6NS34tKO/05MEA6SI8xoLikjbK22+oCgrt+xPAoTl4HJd64SxvAwg+6Ig82EO8t07F5ci/UYhOFfAr9JXJZ5XMcUSc3fYPGoBjv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBoTExEbTBicXdGS1JJUWhpbTFQZjlWcC84TitrUW8xTXBKaUljSXRCb28y?=
 =?utf-8?B?VldsNjFTeTBCU0JxZmJnWFNPemdYeGZGbUFod0h2eEIzbjNHbk0xN1ZQYmw3?=
 =?utf-8?B?bXVUK05nVmUrak9zVk9XZVdKU2pqZWhBMnFJbm1vOEdlenM5dVFETk9RWGFl?=
 =?utf-8?B?czhrMWUycHd4enp2T25VR0FEd2lTYlBlMElzbjBzMnFNOEpPZDJzWERvMkNT?=
 =?utf-8?B?R2Z0NG5VN2ZBZStXYlNUVW5lanRLVTNUeU16cEFIQnE3YldjRmdqeW13TXVO?=
 =?utf-8?B?ak1iV2RjdS9yNkhXaEhJYTA3aCtleTBTc3Q1eklzeGRvZ2hvaVNUN0VVTmFy?=
 =?utf-8?B?WEVLODdjT3l4TEZVa0ltbHUyRExOL0FBNXFzMGpvVVBHZnR3R0xnd2dNZHMw?=
 =?utf-8?B?aVdHVmdKKzBSeGlaQ0RGeU9kTDBnay96S2EzWHJRSkR3dGpSTW16RXQ5WG42?=
 =?utf-8?B?cWxleXdzUWplTUZvdTNIcTlma2YwOVN0VVV2R0crd3h2bkdteVZuL1RnY2t2?=
 =?utf-8?B?MUlnSEZ1SHQ0OUxuZVBJRDlUTjh0MDVHNHFrMHRoSHpRUXRHc0kvQ3VMT29p?=
 =?utf-8?B?WUFEVTljdlc0bFYzcy9TZzJiMWhnZnlINE9LSVlqcTRNTFhDdUd3UnpueEI1?=
 =?utf-8?B?QWFoZ2JRUHB1cHpQdEtsWitNbzZMZDY5cUFpa01jNTVJQXp0cnB5S1VCeGc2?=
 =?utf-8?B?dVlnZXZiRk1WSTBRaEluN1lpL2dySDROak0vVkdsTVF5TDdnOWVBOUFBUWds?=
 =?utf-8?B?RHd3MjV3U3RLeXh6TWRFYnc3RVJ0SnNUS2FlUFN2R1IxaEc4UmdYSG4xbEJJ?=
 =?utf-8?B?eXNuZ29VT2RWTS9mZjJFRGNOV2VWalgyN1hjTzNVRXUxUnJDU3g1UWhvYUVT?=
 =?utf-8?B?QUY4dk40WkQ0UXQ0UTh4ODVTTDYzbVovWXZ2T3BWOUVlZ0RoU2RsWDc4Q1ZG?=
 =?utf-8?B?bS9RVEU1aVNxaGhGNVRKRzRZOGpIb3Q5ZzhHSzhlc3VSZ216TkZldVpvMDVU?=
 =?utf-8?B?Uk1pRXBtU2FaY090cjc1b2tPK2RYUEpxK21CbDNUNGhzOHBueEtOVEhXMkk0?=
 =?utf-8?B?NzFRQXBvTEwrQkhWRDRHL3FOL2RzV3ppc0dnbnVVajBBTlJPTmlJQVExTVcx?=
 =?utf-8?B?TjN0RXdOU3E5cmErV1RTUm1TaGU2c0NnNlN1bDQzanpyT0hTTzI4UG1EaGhl?=
 =?utf-8?B?bnVLK1lUZlNYOU1TNzhoZTZaUE91SUhPcngrVDdaSWRxeG05WWxLODNPcVNw?=
 =?utf-8?B?eHlzWnFsSy9QUnhUTHFURC9ZcG5yM3JpNTJIZkR2MmpZLytEbHFQdFJUMGg4?=
 =?utf-8?B?TGpzNzBZRWhVaituYU5BbG9SWTNaNUFPNERqdWhycnBOOWZ2WWlhb0lxaFZM?=
 =?utf-8?B?M1lId1BzYU5vSEpUdWw0NWFXSlFNdGRNYkxWTlZsUUlsYTRhVlBBa2p4UEZj?=
 =?utf-8?B?THNXOTBnYisrbVgyQVozM1ZrT2RVdU9hOWtpdjJNUmFvR0NIak5JQXNDdnd0?=
 =?utf-8?B?TXdWL3JyQ1dmQXQyZWhYc0szWEM1Y0VOTWNEOUJ0WERnUGZtWDl0UGJYVFZk?=
 =?utf-8?B?SEdLV2lNWDlMYWhTeUErcjVkT0J1d0UvdEhMWThkT2krSHgyVngraXptakVP?=
 =?utf-8?B?dXM0OHI1QUV0T1NSNWV1aThzZWV0UkJNbHNnSWNRYUlsc3Zya203YUVSYUhV?=
 =?utf-8?B?TjBaSStuZi9UK2YzSmNaWkdRNndqWXNuVFhmM1hIcTlJdHVudldNY1A1Mldm?=
 =?utf-8?Q?UxTSQLysuRhkv5nM4p776RrIjUbWHgIDwuNv/65?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bc7fa3-81e0-4bc1-d47a-08dc2ef4fd45
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 13:41:33.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6075

On 2/16/2024 9:23 PM, Andrew Lunn wrote:
>> +	// Register the optional MDIO bus
>> +	for_each_available_child_of_node(node, mdio_np) {
>> +		if (of_node_name_prefix(mdio_np, "mdio")) {
>> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
>> +			of_node_put(mdio_np);
>> +			if (!priv->mdio_pdev) {
>> +				dev_err(dev, "failed to register MDIO bus device\n");
>> +				goto out_free_netdev;
>> +			}
>> +			mdio_registered = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!mdio_registered)
>> +		dev_warn(dev, "MDIO subnode notfound. This is usually a bug.\n");
> I don't understand the architecture of this device yet...
>
> It seems like you have an integrated PHY? In the example, you used a
> phy-handle to bind the MAC to the PHY. So why is the MDIO bus
> optional?
Because the MAC can also support external PHY according to the 
datasheet. Maybe some other SoCs didn't implement this internal PHY and 
used an external PHY instead.
>
> Do the MII signals from the MAC also go to SoC pins, so you could use
> an external PHY? Is there a SERDES so you could connect to an SFP
> cage?
No. MII signals is not accessible outside of the SoC. The SoC only 
exports FEPHY pins (i.e. RXN(P) and TXN(P)).
>
> Also, do the MDIO pins go to SoC pins? Can the MDIO bus master be used
> to control external PHYs?
It can, but not for Hi3798MV200. The datasheet said it can use both 
internal phy or external phy. But for Hi3798MV200, seems impossible.
>
> If everything is internal, fixed in silicon, no variation possible,
> you don't need to describe the MDIO bus in DT. The MAC driver can
> register it, and then get the PHY at the hard coded address it uses.
>
> 	 Andrew


-- 
Regards,
Yang Xiwen


