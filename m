Return-Path: <linux-kernel+bounces-93625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22397873289
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC42A2858C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38C5DF29;
	Wed,  6 Mar 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DPL10Ywi"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2095.outbound.protection.outlook.com [40.92.107.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4E5D8FB;
	Wed,  6 Mar 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717326; cv=fail; b=r9yf75N/rHP6B/l6OmnQXcnabBbUcge5XZFEVRLFe6E7XSzH44VJ7MfcIwRHCuf3a/7gijcJYAEnX1EKSg+MJ/k7nzT5Fmey7oIpLy+d+D7rTfruJFaBV7mlC7X9DyAwwApJbJo4FfgVPHab/jD2Go75VGXnfL0k1e92lAQi1mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717326; c=relaxed/simple;
	bh=SHyH7W/weD7gDmfLLQ8QOTf2I47OAug/XoSXbniRcuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CMJIeU3H8DSIB87+ZFDeD3DiVoMPn/BgHeKzDSSyiXDiDxn4OeF0bxeepwT2SpPCXrm0IqaarGNP4oOyb9hrOUzWg172V4FVTRmtCn06k5nZHbifH6oQtZ8EqnXG6he0XxNB/ZdUbIOkFN7niubPIQ6T+0td4YygeMKRjFwzPxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DPL10Ywi; arc=fail smtp.client-ip=40.92.107.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpJHPY3ay+6gx863ZtlwXXDuDyTufGVqNh1iJw8jwPvH9qSLIhM2XiPGyokziQ8ybqOn3C1nA11J7yGLo64FlAb5st/070VU2yJ11DzDwab33pqzsoYvEijyP3osoEVjMLpSeJXt6fY6mSfcpM7EqETyd5pxAO3+eT/kEs8FAY8FA7vJCQQWl6NWqhRYccPajEeMe0eWyZWPFtpTtRNhO5lcCPRBzaSgk5DRUQtH+NjoXb1zH6664pM5noTeVoeoc93goaoW4ea4chFCqt817xg/9vowT88SGuCykWanq6esDjEiDSp0drr38D5oj+ezNikkj1hGUN8v9tg0NoXnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGo4ZC6YvmF888JPmaUx8IE0HiYz7LXkXehhzGngtUk=;
 b=frvWRsIWwd8nTek7RNybTTOSdhmrcz/S8qwBa6e8WF1iof3CjsB7Ij5A2ryHgxpAX5S/bDAIODHK0A/huZphL1EHz4nFOYH1d4zBQopMGkcnFsz07G1lbTYs2FU23/IFRmIKpwaZKW+K/D//tdaqkwAUBLlEcp/tbUba5GSON0qsj0lKLDJ0nNQiog+YnxXd7Hq4LtAdlCqlfp+NDDJT1Q8cPeBmfsjCx5QgzgE7UDYq4gWGrenvF0ZAhJoierCToLqteG4ClC05gXQM4kj8ON/dwlE8bg0mo5CrSoGe+DQIDGurWFFB+AoqwqXNg2cezaOIDgXSouT7eggsx2EhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGo4ZC6YvmF888JPmaUx8IE0HiYz7LXkXehhzGngtUk=;
 b=DPL10YwiJENcM9UJyI914R8c6XiawrJeYLwmrGGi8Lw34Xfl+Y86fllxY3ANirQBkoZwDmESkNmQkcGLprG7edwhWpARk7oQGQNt0SAVTf3utI8Lb0flgtGrohlee24WfDobgvlOu9fqbIHf8EwlOzs2FuiZkhDZO15vBmL6AYAUL+pGJTDHfVBjnFF5pzL/X6sItTNtowpalIFhyDfOoFbty8a36CdVtOsfHvLgSkTwYX2cGVeBDt0jvNjH/2zpi56IEVIqE5M6tDXizkkANyBuf4ZB6wp31KW0PWWdrvtVLLV3QMSbUTrJUzikPQZWnvvLsm5W4T+3/eOypHblRQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6613.apcprd06.prod.outlook.com (2603:1096:101:169::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 09:28:38 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 09:28:38 +0000
Message-ID:
 <SEZPR06MB69594BB6F24CF86E859D698196212@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 6 Mar 2024 17:28:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
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
References: <20240305-net-v8-0-166aaeea2107@outlook.com>
 <20240305-net-v8-4-166aaeea2107@outlook.com>
 <66cf4c42-5b8e-41b8-bbdb-7fb2c6bb9e66@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <66cf4c42-5b8e-41b8-bbdb-7fb2c6bb9e66@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [ACSyLj/2pw3Q4gpFszX+18bJ/9DoPtbjJiWSCO/aGi+EGCaAyfo++Wuwhw0Mjfkg]
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <0414374e-6fc8-4606-9ee8-45a85b27b10c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac6ef1e-1b9e-4caf-4228-08dc3dbfcd9c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VX2HSxjPhveW5LpcBfoMhsOHuyr7n9pxOC6HOpJWe+kYUAe3T3qpALiN0UntjqacUJO195orYQdhjnq3iICMBFVMhFhk/WHQyZoLCxcCmiZTWzFxMwGKJes9h+swdpj5hbaoaa7mB4eT7W4S08x6pxPTAbcVuOrCmXOxPmjlXk9qgW8w3G/safz4xUndewgW26tZAEYx0Ww1nP3MzBgJFIo1tVPyXFMZhuG22gKoJy1xxzc9fHuTzAdRnGxY+Q42FGIc+3DkVrU+k2elF93TG6gfd9B34fDiigwmg/iE1Q16NftiW068qYzci+vEcU/nc67Pnd0i9RBozh+2Qnm6bHUdoLoXUylUIy4AuGcd72zJNBNmYgDgqw+L4EzCwzH9mEQWlqZux7gVzNimX6eR+S3rQt0DgUkca52wduF6LpW9d9WV5N0XCeJ1k0vOMFxZY6d433fio+tl/ksnY6JSgMs93e6RTnNta5bqK7y+Gn2HSRHzqTxEmkpK9devZjuSOot/3TPh3pYT1iqTDSzFW3KAlyEi/+4buCI7fcZoGMW6e52YYdYJgCcaLX7YdoM1TeXRGbueV2yUIN0D47Jo+0Ve1Tva2fAKeq7326jkNg8CqOyiXEz7lDFioVUtUIPZji5bXeBI4dIEcu2e6K4lQu/xGRMZl32IiAM/xXhVQnQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC9tTVRObFFCWmJ0cEY0bWRGVnp6b1duYWRZR05Rc3d0d1FhMlEyaGdreG12?=
 =?utf-8?B?YWJUTkI2S2ZjVEwvSE85Uy9PN00yenBnTnpHNnUyT2t1eXlCK1ZOVS9Lc0p3?=
 =?utf-8?B?NW1kMmhwVTc1eVBZa3JBSnlvVUtBaU1KMkRJM2x0TlZscUZaNkhMc3JBQllu?=
 =?utf-8?B?cmpmeU0vbmMvWUNQMUJ3bVo5V0hyYXNWeXZ0dEhYOHlnaHNSK0Vxc1IwZndn?=
 =?utf-8?B?dTdwY1QybU5TbEEyMWxOT3Q3RXBHazV3VWFnZVJHWGNZNzYwOGFHVzZKOFd4?=
 =?utf-8?B?SnNKTllIb0Q2dUs3NFZhSXpoZjk2U01FcVphdXM1UHVTM2UrNGZKeVdSTVUv?=
 =?utf-8?B?RXc4c2NrVERvdnpNclQ5Y1E3cGhGOWhpcExDbFpZeHRJYUZ6a2grbmFOSHZ2?=
 =?utf-8?B?OXh1Q3c1RjdPNkRZMmsvL0tvcW5vWHJjTVZMZC9Mc2tSN2pBckNURkZ5SEdU?=
 =?utf-8?B?QlZ2UXJ2dXMxTERhZkNkZXQxMThOYU90V05CdDAxRldTUVFERU1TMlNrYVlQ?=
 =?utf-8?B?M0p6YnQrMFFLTUQwcmZ6SmExMHRPS1kyNEtzTEdDb3BKQVVWRXJXNzBpL1p6?=
 =?utf-8?B?YnlIREV1UzhTVDFXMHFaUm00bUV6L0Q4VU81b0gzR0xlRWtOUnNvN0JRTjg5?=
 =?utf-8?B?TjFpazR5UG9PQ2kzZWpqdzEzd3ZORU5PUUZ3NHh1VnU2bXE2SlNodTBrMVZj?=
 =?utf-8?B?WnpXU0w5MlJCSUh4a2NCYzJqeXZLV2UzVTI0SEdpR002cEZVZVpmbk9GY2U2?=
 =?utf-8?B?a1ZDQks1M0NObGtrd2h1SDhQMklUWnRoVE1JQnp4Rm43b3dPUGtHY093MWNS?=
 =?utf-8?B?QkpsUC9ibXRFY1N6c2VGRmpEdFVYQ3ZkOG1POCs0ZlhRME01c2lzY3I5czdi?=
 =?utf-8?B?UDhTbm5lR2hqbVBJUStXc3NnbU1nb1FjRTNGeTZiSnZzTFdDQXpwWDhoT01p?=
 =?utf-8?B?bUlFSWN0bjBpMExkeitEeWxBd0RNNW9CSjlNb2RQL1hsdm1DR2FmWE9DZFhW?=
 =?utf-8?B?STEybWVXZDJ3V1lsMndLclU1YWEwdTBOR3ptdC9JV0EyVXJ4TjY4TFp6akVo?=
 =?utf-8?B?bWlvRzVobkZmM1VEbUM4T3QrWFJpQ3ZSaUhaRTdsbjZRaUY5VWhmRXRudklK?=
 =?utf-8?B?WjZuNENFNTJmTmZWTTRNVzJOMHY3QmwwNjVDNWVqSHFwUUZoclJ5dUx2N0Iy?=
 =?utf-8?B?NEtMcDB0Qm8wUzQrSjc1NjFMb0IzZklDaGJCZk5YbEY2NW5DMnkyKzNtRXdV?=
 =?utf-8?B?d2VaTExtQk9WdEVzcFhIaTJCNWFUaFBvZDNhN3BRYWRDR2NhM0JRa0Y3VzVS?=
 =?utf-8?B?ajR4dFVxNTJmalhaWTdBR0xNL0FMMStNSjE4QUx5UkFWUk1YNVREOTZOZGJn?=
 =?utf-8?B?d0RORDRURmRyeTdzN285WGliQkNFeDNzRG5DdmcvalhDUXgrL3l1TjFZWFpl?=
 =?utf-8?B?T25pMTc0UW83TUNFaXpVaEdzc0w1dFVha1YxSUJEMEdTSWowUkFpYjVqUDZ4?=
 =?utf-8?B?YWM3bTQ0MDdpeVVYeGxpVDZDUEFTK0hBalRYRnBoNytLV245MWtGN2drUTA4?=
 =?utf-8?B?ZjNQM1VSZ1hJTlpmRVBsNXNvQklkQ05uUkIxZlB0cFUva2dxUEM3VmRCSGRv?=
 =?utf-8?B?WUZZVVpZYWZ1SURWUVVlekY2ZUVCVUFteWZzRzJsQkhQZVByWE9UZUoxSXVP?=
 =?utf-8?B?ZjI4Tld2aFdhRC9XZmtrWXloTElrZ3Rwa3RNUElTREltSnR2QzdpVHJRd2kw?=
 =?utf-8?Q?1345m9a5s6ChreYwx9FZiL0Zv+SqTgd9l6T9zjf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac6ef1e-1b9e-4caf-4228-08dc3dbfcd9c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:28:38.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6613

On 3/6/2024 3:39 PM, Krzysztof Kozlowski wrote:
> On 05/03/2024 08:51, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Convert the old text binding to new YAML.
>>
>> While at it, make some changes to the binding:
>> - The version numbers are not documented publicly. The version also does
>> not change programming interface. Remove it until it's really needed.
>> - A few clocks are missing in old binding file. Add them to match the real
>> hardware.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../bindings/net/hisilicon,hisi-femac.yaml         | 89 ++++++++++++++++++++++
>>   .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------
>>   2 files changed, 89 insertions(+), 41 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>> new file mode 100644
>> index 000000000000..ba207f2c9ae4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>> @@ -0,0 +1,89 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon Fast Ethernet MAC controller
>> +
>> +maintainers:
>> +  - Yang Xiwen <forbidden405@foxmail.com>
>> +
>> +allOf:
>> +  - $ref: ethernet-controller.yaml
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - hisilicon,hi3516cv300-femac
>> +      - const: hisilicon,hisi-femac
> Drop this fallback, your later driver change does not use it, so neither
> should have binding. Explain in commit msg, that old binding was
> incorrect (we discussed it a lot) thus you are making such change during
> conversion.


What about deprecating "hisilicon,hisi-femac-vn" compatibles and 
introduce a new generic compatible "hisilicon,hisi-femac" instead? This 
way, We can keep backward compatibility.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


