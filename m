Return-Path: <linux-kernel+bounces-82567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5DF86866E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CBB1F231AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B58F4FB;
	Tue, 27 Feb 2024 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HI/qXUx8"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2046.outbound.protection.outlook.com [40.92.107.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88015D0;
	Tue, 27 Feb 2024 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998701; cv=fail; b=pHLDb56RvDFEhBa8AcI7AA643rZZgro9TZsG0pEFYzVMgXceiCBiKuZmIsZ+K8DZdE3V/BUwCqSgczvDWyToOtChn5dlc/UfIPf1mO4otxwYMwx/3RBCqxBXUgfSZskKUBWVAf6vVgGYwCI536J9o8cYIcNUwuxEfBmlaLR0WDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998701; c=relaxed/simple;
	bh=RwTGrO2Fo8MhMpW6TnGW95iFjJjsHgynTf6qnpCUZDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ghV3QRHYGeWFIlkDIBmIVR+s87Ii895G5/8nJRG+hiQKhPifIdKwfnZY5o9mKclYC3MgxTFYVPAD/r5qdl//8WN3xu1Fp2KDkqbMPEYaTJ4sXKVreeqR6DFoHWInEMgpSynAz7Av/FsWFlLFV3PM0RzJtH7IlUsGoX5TmG/eLAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HI/qXUx8; arc=fail smtp.client-ip=40.92.107.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/xKRCYUpReRrdlZyHHDp/5JaSZgsMDzHtWPxs+ETm4t+wyxWmnXtp2in0eAsrwthbKAQxZeQcs/3fnnIYz/9R8Fqbx9Sjducsu42b9MjDAmIfGg2klcbV86KKZOyU8zg36srBjV15O2lXS535231aJJoRJyiZcVliCEcom8lLTnqKFP/fhG8DC9NarLAqowsk8FXzUFfB7eGRZVHzm3MT2rR7ATIChAM/D6jjr7EZe7DgZwoQUgTQQmDEL7b6Yxhup12GTxk8avPz3oKLBpDiwrRmlSZoh6S5PCCiEK6LMlqY18l+RyUnVw/viGgXBhgQLKUqRQVTT7YSFMMS66Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWl6ccEQSSClHaBJleXwc/gRqz7Cm8tu3Llhj7MiiuE=;
 b=gZkB6wqzKG10bav9TJcTUzblO6GPQc+3J/Gu/BItz4JuB7P35+qZ2HDJYk28mggXlMTbmfoGvpl0h5OHtqq/J95E6soLG0+a4IjO55EKJB3BTTx7sL/Qz6WWj1nLZaWlOIbNMQAendkMkbRdh1nF4GfbxBQfu+nF71TYtd2zSyQ4w239GluECmhfAwUCiBYq9MrLfVqpYQ5ENlb1Zs7gNozKlsZjVoAXCDw3yxJmNp5bAne7IYjd767nxp5raVLzqaGubCeqxfP93q48pvjSq2wpttTFzdxC5K3tcKPojL827SPwFDYuC9NaGbK3/qmAdy3GQeNSDKDd39IEBmOpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWl6ccEQSSClHaBJleXwc/gRqz7Cm8tu3Llhj7MiiuE=;
 b=HI/qXUx86p0F9eiYLa2L84Ie4zsV9JU6H/qpYckvj7S5ERzja9OOmLXLm8hAfXRCaz+HvQJOWjL1medXv6y94pvtQC7xGHCT4Vhn2TtxSgbzurvwSb33k6k+4OL8Poiz/gKYUGvczNBYJNCkHYu0Mkf8oErV5uRbQBNPWvVgmm0xZCfIF/ngW5viWHoGvOqoj+TFHSfO4VYiiFbbaspQnd6ZlqdLyQ/3n6h/bLJO2AT9MauMh3sHFWnVpZrcJrQ4Yh0tT7r2gM03epHKsuJPwfJgdqIHnh99+WBhAjj89ZdTmfDXHvBAMo/cBWkIQeVhzkj8fWMDbb2hCxBVq6B2Sg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by JH0PR06MB6439.apcprd06.prod.outlook.com (2603:1096:990:3b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Tue, 27 Feb
 2024 01:51:33 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 01:51:32 +0000
Message-ID:
 <SEZPR06MB69590A200BDDD6D3DA4CD2DA96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 27 Feb 2024 09:51:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/6] net: hisi_femac: remove unused compatible
 strings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
 <20240222-net-v4-6-eea68f93f090@outlook.com>
 <ccdcdb1b-44a9-4233-994e-18d875a99c2f@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <ccdcdb1b-44a9-4233-994e-18d875a99c2f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [hamtEx/FyRYd9ehj0OR0hLzQZVyRviU51+9rEJ0ibBVw00ldPF2m+Bsr/C8HWT/6]
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <876febcf-f24d-4416-9e6a-579fe0512cfb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|JH0PR06MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: f35b58bd-9ac3-4a9a-9be7-08dc37369f72
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aDw9keObvhZ19e6Pu7nJQWs1SHzPJDVTc3NkjveCGbgZkG0Jgv0cRLdZlLbPYIOfYJecoEeyjk/Lz/plrW1+3JkEMf/YKY8nlAABZRkh/CDYMn78k0f1g76H6plS9d1btOl20T4Pb0W0bp4UqBi8gcafo+I7ZacaVULJKHpjgYhQs2218VlrXUj1Pb6ZSfZAzb2jCQdUexu8Kz0ae4B650byUCA0DWnqC1CUvokkvFMfnJ/5kc+GUB0/IHrujZb+NKZivuAhRvH/E6tnfVJuCaCjj9dQafrx6d19lyvKrgI1e+/eRKBhDNIQX9bJkcIKzhlzHfWF33Ry/rknlTvCEZnZBTiIAtvyv10XDT7kickfVvqCj+JoAUmuJyHAZVbBRxWxzcwN+Q4oWaWeQFe+OdoHm65qtvZyin0lT0Dzd8ahFJfURB3w6iPl8jwDPvu7xXWY5OtpbtB9FbnnfGLSDMmDPiUFuafM6cx+XQuhsQ3IocWsyzyU2svQSNjvzWLHEiUbL4LKw/ulgEVsZ3KxanferxzPzjBAPxhKQtNBSIdhiReLXXZSmY4M4yYGMJAK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1VEVEVwMlB0NkJnOW5XQUR0WlZHWlhHaXo2RnQ5MTQydy9VbVlob0hUOUQ1?=
 =?utf-8?B?NWV4TGpmYWpLREtLNy9wUGlkY3dLYTdMOUdHUUtxY3FENU0rZ2d5QkVlMnYx?=
 =?utf-8?B?aXR4RWpTQWJHNWdLMVFDWEVPWVFMbjlOM09QeGlta2JkczNmTWFQblpTVWRx?=
 =?utf-8?B?WGhZdWpxT28vazJ1aHliZ3JoczFOc3oxR1lRRXFZVEVSN21FclhXWjhuU3d1?=
 =?utf-8?B?L3BnK1J4OGhJZG1LblRQSzRSbTZ5cDhleWtCc3h4NENQZWFQbHhHMnExYlNV?=
 =?utf-8?B?a2traW1YZzB4Q3N1NE5lV0hnOVlNM043STY2c01zTHpyV2FXUGYxOWE3d3BQ?=
 =?utf-8?B?bkgwckNiK1ZFdGpkK0xPd21oazMybW1DOWFyL0pxR3l4d2lrUkNlOTRFYVcw?=
 =?utf-8?B?NFNyb2dXWE95Wlp3OXRqSlRaaXV6cUNtbVBSanlRdUVhQy9TY3FsUmpETE1v?=
 =?utf-8?B?Qk1PdnFmeUFTdUszaGJEMDVtbEt6ZUZzM1FObnNYUERyZ3hxeXc0TDZVZjhD?=
 =?utf-8?B?VkhxaXFqZ25GVWRkUzI5SmI1TXN0c0dOVlh3YkdJVG1LZ2JrSEdycllPbWNU?=
 =?utf-8?B?STRCNmEvalNrS0g4cUdTZHo4T1RmMTNOazZBRld3citocTdIMjNwNkdhZzdY?=
 =?utf-8?B?OW1oUXFoSDRxdlBhYlQ2MEJBQzdUSERlYnlwYjI2RFc1eUFZZ2wrL0tQUWJi?=
 =?utf-8?B?Yk9WV0lqbkFvdTdHdGZJdjVrUXpKNlNvQlhXUElXVzdIS2R2OEJXU1hITFIv?=
 =?utf-8?B?RzN2T2xnYVMwY2gxY09QTWJBQ0VYRlp3TUpjUVZWSDJjMzJ3K0tFMVZCeHp6?=
 =?utf-8?B?ODU4YTJtbnp0ZmVyTW0vZER3cUE0UTdzd2c0Uk5NWHM4SGVDUUllTGpwUEM5?=
 =?utf-8?B?RlVvSjFkTDRCc3pKb3lIYXpKeTl0cTJ1eldNSXkyVXVETTBOanlFN3czUlpV?=
 =?utf-8?B?VHErODNmenI0RTMzOXQ3MjI2akw2bzZFbVFkcmVVajc5TUdGRWYzYXhCZjBM?=
 =?utf-8?B?SSs4OVcrMFJ0MEorLy9hVTdSTGVIRnFNVFd4bThIK3c1L3IvY282QzY4N0RZ?=
 =?utf-8?B?YmcwNTZ0d3FNc0ZIMXNaYVcrNkU1MDlOaTd1U0huRmE1ckJJaTRnem1DZkUx?=
 =?utf-8?B?ZHRXNWc5TEtZaTZJK29RdmhRamFLSmZ5c0RlSXMrOW5hN1BrcjYzVVJaZ3Jq?=
 =?utf-8?B?cVdCWDkyVjZZMUVBcml3S093a05ybURYdFRSeGV5ODJEaStMNXAySW9tYXli?=
 =?utf-8?B?SERia3FLb3FaWVl5aFQ0cUVyZS91dmcxaWRTR0dxK2NoRlJ1ekdxWXBwdUxr?=
 =?utf-8?B?UHpTSnZ4Tnk5MVlqSlpyNHFuK1hxcHVhT2VhSGJOUll2bWY0UGFScnB1MDMr?=
 =?utf-8?B?cW9CcHRrd3d0SDZWUU9ObFBsNi85Uk5LRXJVcVMxUnhScW1lL2VjUHI1b09j?=
 =?utf-8?B?VjJaRVQ0ZnUrVWdTaC9KWWtXOGdGK1VFYmtIY3g1ZkZSWHRkcjZSWGVUY0Ny?=
 =?utf-8?B?L2ZVWHB0QWtxVFhXcG1PK3JhTVE3QmJZem5hMGs2MW1IdUh2dmZoNFAxWjgv?=
 =?utf-8?B?Z0lWQnBXTlM4R2hVME4vSlBTdWJVVUNzKzZBem5xMmVCRzl3enFhREpuaUJq?=
 =?utf-8?B?OXR0Wml4bitSek9CVzRKS1ZnS3FMS0RzYjc0RkxiMjU0UzBFK0NRNTc2TmdH?=
 =?utf-8?B?NHhGcVZuUWYvTWNDaHllMWtITW1nR1JWNFBoMlQ5TnFsSUNIejZMOHVuQlZ4?=
 =?utf-8?Q?ycGeL6IRQ+qQKY9nkDmUVBSSa7x8OlvpezDJNWv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35b58bd-9ac3-4a9a-9be7-08dc37369f72
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:51:32.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6439

On 2/26/2024 3:55 PM, Krzysztof Kozlowski wrote:
> On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The only documented SoC Hi3516DV300 does not receive any updates from 8
>> years ago. With the recent driver changes, it unlikely works for this
>> SoC anymore. Remove the binding for this SoC.
>>
>> Also it's hard to get the version number and it's unknown how the
>> version can be used. Remove them until it's really needed.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>  drivers/net/ethernet/hisilicon/hisi_femac.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
>> index eab91e011d11..9466ca9da2bb 100644
>> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
>> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
>> @@ -990,9 +990,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>  #endif
>>  
>>  static const struct of_device_id hisi_femac_match[] = {
>> -	{.compatible = "hisilicon,hisi-femac-v1",},
>> -	{.compatible = "hisilicon,hisi-femac-v2",},
>> -	{.compatible = "hisilicon,hi3516cv300-femac",},
>> +	{.compatible = "hisilicon,hisi-femac",},
> 
> What is happening here? Removal could be justified, but then order of
> your patches is totally wrong. But that hisi-femac is a no-go or provide
> proper rationale.

I don't understand exactly... In dts, we commonly have a SoC specific
compatible string first, generic compatible string the second. e.g.

compatible = "hisilicon,hi3798mv200-perictrl", "syscon", "simple-mfd".

So i think this is recommended. Or does it mean we only need them in
dts, not in the driver? The generic driver only needs a generic
compatible "hisilicon,hisi-femac" in all?

> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,
Yang Xiwen


