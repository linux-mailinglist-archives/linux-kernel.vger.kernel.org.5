Return-Path: <linux-kernel+bounces-68649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA30E857DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9DAB25BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529812AAD7;
	Fri, 16 Feb 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oNIHsTN/"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2077.outbound.protection.outlook.com [40.92.52.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F6129A89;
	Fri, 16 Feb 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090723; cv=fail; b=RGfFvJ2nEezPDQt8oS/J7hmtT99h/dRN2y3WG8KjnjSary7bAG1wgz/KpeZO6Ngk+NRq3n2DktlWZT08yUJeyBmFces7eYU5VU++zTaVU8X65qj7k5M/Gqs6oainMMKCyRy7uv+pxH167j3hUqsJPg5meaF2/FSB/GDawJ6utr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090723; c=relaxed/simple;
	bh=/phnVtKduuzpYCMql2XacEK0dJvamFR88xiTUZXtGfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrIX3a3i3LL7QdpQr+2jF2zUwPeeQSfuwwjZcN/bnsVfzH2UkwB0M+ERkdb9s7HPxPubVYIGX9hzcIg7+IL46LdDNY/yfjixJM9JMuqz6ZUNi1Ks9JOlxQNoQuyqhaqXJMWn5c9EJ6GX9CnUZygpWTFHAUXONiEARNxfEnhtVaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oNIHsTN/; arc=fail smtp.client-ip=40.92.52.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpW6YI0Hw+DmhW0goT1pxasx1GhoOhB6I1FhLHhw0Fwa02EKS/F3JSYVfYJ35ImWJ2hW2Z3C22S8bmwZ3u7AuOxu+LYkIW4FK1U8CO0O8/i0Ec/jEgjDAWc+C7LEs0tadYj+qsSMXPdGjsqFYnzHE2pJwIux2gVl6o5wEtaU8IOPkobb3FZJbb10a24Im7eCSbTVXDSkICU+CjP66YYL7Z0GjtQVNH3/Q7gdaKCGq+x8cHxNShQDBqH5iIdQdvYvzVduhZtKX2BAnVKvltKtb2FTTTdUuY67u2c70ptym6mJWzCuoTsltiaQSOSCPP1el41owo28XuKb0CnRDoT/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXlz5Tv8LPem8hDcxARYDxu3ROdCTTWA73Hxuvqk5Ds=;
 b=fTgLd3oQ6Jj1klwFwk4Uk1Ld0ZiGtPHo1KJPD68mM6fGssRO5UTbaI1Ma00bvJErWI8R0A+rXfBW9AsKHkX+QbrHR7qwHrKqzJdu6xgY7p6EKZjb5BCeS2UlDoPOrQASk7NbNUpAzyIUjHDJsSp2AlvMYos4Nm3ZwISB85LPJ9TaAQ15Hq9QVToWAZbAMKd2Kw5j0UPAjp9kDZqU327kZNbmf//xvPnGnY1QiLVBaUVrQyvtpy0WJgFDgQDKr6Gs8bZSSoGJjG75l9QfzQKZIOp2w6tet+KoFKH8rFWUFtakZ5wFz5WQJK/Umq2upHBiBxLow7wT6jWpsdxOih9VfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXlz5Tv8LPem8hDcxARYDxu3ROdCTTWA73Hxuvqk5Ds=;
 b=oNIHsTN/Gy4nUw8af+YZ+e1mou2tpjNkkdhlBgUxnaZ1S5gphQnO7igGYYIhuO9vrd2Dv7N1otJz3sf9rFEbgkvrqRmwoGqjnpIRaOKI83fjpkYlGnjfXZjDOd5iQ7KavqThHSXsDFLLM7Vbun3O3YUMSWa/4IocWOE4W5M5LFKGY86goIZOEsIyraP0iRv+EJ2JCFdYUp6W8t+cBoxtnXcf0HxYAg3ot9i2vldskmikqVsHCk65pgQ+Bv+3TD+ODCAlg97nt6ApShB/wJm/pdJPqEAPDQah8jzaISoIjiYaKac8QikhLiAtIpA1YyyrMPirRIvtFZMY7YCypJT31Q==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6075.apcprd06.prod.outlook.com (2603:1096:400:33a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 13:38:36 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 13:38:36 +0000
Message-ID:
 <SEZPR06MB695927E7E18D62EB1E6FB603964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 21:38:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] net: hisi-femac: add support for Hi3798MV200,
 remove unmaintained compatibles
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
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
 <254d3c4d-bc74-4a26-9c23-17b4399c3755@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <254d3c4d-bc74-4a26-9c23-17b4399c3755@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [yXQgq+55od0JIBEqBu2jo3QX4Rap48wBQDoRErO+WXWHikzINOtF40+h9vGfGdOwprq4B2cZQvE=]
X-ClientProxiedBy: PU1PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <774de70b-5521-4d94-89fe-a7816f2d1c1f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e5d116-fdbf-4f0a-d3c2-08dc2ef49347
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oaSY59WvLm9HLaV0mljXoQvUfssyppB4y7HC/9HRiVXHJWIifatMhd1sle9eRS+3fC+Cc9PZlQrrVm3aWrxBo3kk1y0mq0hnk+E/go6OR6p4ja7lwb1gAb7YpaZBzqwgSXaOKb7frz5aQZZfPoCfs6GPnbDgpcvKNw+WxSK8UB1FmlATaHBSa92bsglsDNxDMN3eTkw5gyOS0jThwI/0A4uc9D1t5geXQvb1Lus0WqEMwIokRxKAYV9yRSgzFXxKCw0I+Zyc/YxVcJ2zMXWdjUJvof2AsGCmmSp2MW2AVqdqwFWKAG4ka5QtizYV4rNnxQ5aWgOSgQ4pqJGX5q9SuTf/4B7qzVYpsbvKPklDnc6pa8FVsqGWKCEcvNR8vveHhKYldThABYmSKdvPTyitYKYFkIIczVo9eM/rzu9IeqgkFHMvCN6PqBFXOVED2Vt7E6PkOO1P3QRpOKc/ZSttqO9JxWQuZvH/PUiyGG3m0TvXniIm2T8op8eXCchVKsnsv7K2TziVIg4/quhH3+u5ciPotKkRbmQzJYPmsWc6Ztg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXBBWGROa200OEI2U1Z0a1hDSkJVdzgrMXRyNFEyQkNYblBuckcvelFLWEpN?=
 =?utf-8?B?UUxMWUlHTExqdmNJRFpWbEZSdnBxUVZiNmVvVFJqRWp4TWlpeHNxZU1uRHZa?=
 =?utf-8?B?MzFxeFdTZ3lBbHZqZnFlUkJlMTJtSGlVaXBGOVJKNE5TMUhhYzdnZ3pCQk9G?=
 =?utf-8?B?M05naTVxYzNUOS9Mamp4WTZMZENtcWllZVFGVHU5cnpFSUovUmUwNFNRL29C?=
 =?utf-8?B?NTZhWTNIVUJKelBSWEc4bU9jdVY5dDJLZytrekRvTkNGd0Q1MzZaL1BGMG1V?=
 =?utf-8?B?Zk5yQ25lbms1NDlQZmZOK0lQOXIvRWRGd1p5RG5xQmRBWjM4VkZSUENnV1lB?=
 =?utf-8?B?Ui9MRzh3NTJKNGUvbDVYSUM2dktpVjJtWkIrRGJCbkhBeW9jQlJzd25vTmpw?=
 =?utf-8?B?ZG5tOXdZc3FCSEYzcDFoYzFpUW9hUkhiU3pUR3RNWk1hN0FQcE8yT1RDMVlX?=
 =?utf-8?B?Vk1ZaDA2aEZlSmJhY2xOVWt1dStCLzZqZDdxSEhEMjcxZENnN3JsWW8reTZM?=
 =?utf-8?B?dzAyeURKdVVadnN3Y0VId1ZRSVpmb3ZDZ2piS3hlQzVRWFBCc2p2TTUvVFJS?=
 =?utf-8?B?OXpIbC9VMDUzbFpyWk1LV2NzSUN4WnYyVTJ3cFZBWENyUnNDd2Q1YnFqZUMy?=
 =?utf-8?B?V1o4U05tZ1N2VEJKaUxkMXdNZ1BtSFdxSXU2YUc4c2o2QzYxWjBLcm1IU1VD?=
 =?utf-8?B?T0pDS2FGRWtwZ3JmZmFmMUNRUDIwcjRkeFdLWWNlQWlQWlJ2elRGNEt2eE9V?=
 =?utf-8?B?UXYyN1U2Vm4yRjlCSnlGcHVmUFlzTXV6YVJFcnIvZlJCR1VoczVTdjk5MmZm?=
 =?utf-8?B?UU12cFRuRlNTY3hUUWFCcWN6dlUwTzVzUnVSNXRrR1VoS2R6aWd2R1JUK1dF?=
 =?utf-8?B?dzhLU2g1T2FkazBjNEZCV1FtbXQ0THFuVEx4SEhHai9mSkRoR00vay90L2Nm?=
 =?utf-8?B?b21mR2UxN2FEajRmQ3JkNXh5VjNmbUt3NEtkQ1lFWlFFT1lmaDZvNU1tZXNi?=
 =?utf-8?B?RWMxZkRXbGs3MVZtM2hlNzNVVkl5VXZKV3RaYy93YmE5ditlTlpJWFJGRjVi?=
 =?utf-8?B?MDArMVJzYnpIQTFTbVlUeHVqeCtGSEpRdjZwaXFYM1JnZUJScUxmckRKZmgy?=
 =?utf-8?B?ekM3dTByWlk0ZlpkQitmV2YvRmxJUzBWcFRKT2xZOHFQL0g4L0RXcStZT0R2?=
 =?utf-8?B?bVA1aS9Ha3hTeWxwaUNGRGc4dXpnOGJZVkFoRy9mMFNiS3FGcmFJNTFVNWFO?=
 =?utf-8?B?YS9KUWtVaVc0V0RoRmU1Rzk1aWhnNjdoZHdObUJYaCtrUWN0dTVBYmo2M1dn?=
 =?utf-8?B?aVVXQ3ZGTlBQZHZXWGdEdno1VU5PeUpzRTZCRklRVWJONXpGbU96Q1E1Rlph?=
 =?utf-8?B?b1dHOTYwa2Z2WGNnZ3FyZWMrK2EwY0xhcTlMcTlYem1xMy9xM0dWMUdTUExs?=
 =?utf-8?B?NHpmZzRKNmt4Wi84NDNIVEpQRG90Vzd6UmdVdENKNXhPRzFsVVVrS2QxNEQ5?=
 =?utf-8?B?M1d6dW5KajYvRGFjU1lEMGQrWG1NUTVwVXRrbklxQzMzV2NmYkx6a01TVHNk?=
 =?utf-8?B?WnA4cGkzVDA3Y2JmTEZUSWc3Z3h0dmYwSjZxbkRUT3kxeWJZYkJtczlqQmlu?=
 =?utf-8?B?cUdPd1hyUjgvaE5XbUhQWURJMElsZ0hLVmh5QjREYWd3U1IzMUp6NjNJZjFI?=
 =?utf-8?B?WDBIMUVXSUFmR1BMM2gvOHk4N2c0MzF3QzlKcUptTnBPcEdMaEpCdGlLcVRZ?=
 =?utf-8?Q?30amQ1+2nItLu5HsnUdb+uBVdKajtLLnCwuIz+5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e5d116-fdbf-4f0a-d3c2-08dc2ef49347
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 13:38:35.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6075

On 2/16/2024 9:37 PM, Andrew Lunn wrote:
> On Fri, Feb 16, 2024 at 06:01:59PM +0800, Yang Xiwen via B4 Relay wrote:
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>> Changes in v2:
>> - replace email.
>> - hisi-femac: s/BUS/MACIF (Andrew Lunn)
>> - hisi-femac: add "hisilicon,hisi-femac" compatible since the driver
>>    seems generic enough for various SoCs
>> - hisi-femac-mdio: convert binding to YAML (Krzysztof Kozlowski)
>> - rewrite commit logs (Krzysztof Kozlowski)
>> - Link to v1: https://lore.kernel.org/r/20240216-net-v1-0-e0ad972cda99@outlook.com
> Generally, you wait for discussion to finish before posting a new
> version. Also, netdev requests you wait a minimum of 24 hours between
> versions.
>
> Having discussion happening on two different versions of a patchset
> at once just causes confusion.
Sorry for that, it's the first time i send netdev patches.
>      Andrew
>
> ---
> pw-bot: cr


-- 
Regards,
Yang Xiwen


