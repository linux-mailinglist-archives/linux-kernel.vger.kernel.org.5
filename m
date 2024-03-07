Return-Path: <linux-kernel+bounces-95340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95DA874C76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C8D1C2263B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCB286656;
	Thu,  7 Mar 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AbQBUMTs"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazolkn19011003.outbound.protection.outlook.com [52.103.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556D82D9D;
	Thu,  7 Mar 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807616; cv=fail; b=XXMTGmV/5TIurDoHDOArkpc2kje+/MuwUypV5kt3TWFIIc5UBQJdZIE/uxO0u8BvxAfbpE1zwLJQEGp//f1XfhkxyPs1YqC5ftJeLvM4O8+sWVeAWqzuNUKGf6pdMcu9LzXWfoSXyGAud973NU3bW/3wuTdRgc9yPPBSYVLZNfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807616; c=relaxed/simple;
	bh=6cnmqkxCeH2yz7+u6OhnCUhf4sG2M7uNyfuy8wrTN9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTn81tfa7dIGoTOKMJ7Sd1u7of0ADHkKNp1dPxoo+tDZsbcsnHQbKZ5em2SdGzZIUog4h2YHS63Y8VaPvi8cHJsUYtvofQcQpZc0T/ZEAz1IT+urSlf/9v2iRxfVUjfgN5h010xRQSQDv59HeCficeEJ19hYNM9EYvSzUAigEwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AbQBUMTs; arc=fail smtp.client-ip=52.103.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfqUncNAdHp9TOmIlpbPty9/FmUDJ0us9FGeBvx6HJllYGFXvY7Hw7Ubed2geMtKyR9IoIHkuR8McznmjlLMsxm3CqE2UnqztBZ0/k1olJRqd1HKXS0JfFoXi4Mfb8lwf6vW1uummka2awagheeMVqO+oRqFYP7WLwXpifOxFIDASTTHL2ItnTIvEun4py1fto1Ci+2SMOhTXVldJrHTQetF9ymIH5pZJ1gzj6yDLOvsqx6awaavNx6S0Pn5h6GJRBbwhsZSpAJZMTPoKAW5Gb8nTuOkhyR2Wc56Hvoh/XmExlD8+MJF9BRJvamIACGzHHEpOsyg/k/4P/4xSjslKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSgPyqU64C9vjAFBvsBXy9u+1n7Uyp2mC4mZ1W//Hhg=;
 b=KIWcSJlkaajnSCIbBl18aGGlKB9ueqo6ARrsd4ChS15SiIA2yWIZY61AL4ZOmMb5SAagvaiAJAqY8SSX/ZwG4L9oskWvZIaWJvu0MlX+VPRyIFuIbWErBmcgEn1QnIz2X2UV6Hvlr2GEHKV7hYGRXZM+9O6+E2FM4EjOVdZ6Mz+gqLj9DwVvndfK9RLUOjAQnGkziDugsNnTqpaKzszmxs7PB2g4a0GX5DY4RNpGIpje+HyuIQsybBSVMHCK3fHum0g9ovLT8T/AYJtXW0X0s4h7+/gW9iofkCuPG8F1HHL51UGzK9oQaLdWqAZftm1muc4hU1odDTbV/3jrgUsb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSgPyqU64C9vjAFBvsBXy9u+1n7Uyp2mC4mZ1W//Hhg=;
 b=AbQBUMTs8pfq65hWWoi1gGKFeRoT1mwgEeYa4FhcIIbSm0bTuTu5SRjaqPk56lJTL+UtUK9Z++SYcjc/xT2mrUuis4hhNTizBidrjhza1ZLUg1kIKXP0mbjQl9/sRWwEotdH22s7NCa9W4M1MpIZEu/gksDTrAUgnyoubfpXEyu0qIawjgZ9jUBx1Dz6pQqDbJdJspnyg0P/VVubQlmIzyA2HhA/ugAQPz1524kAd5BmgCOvL0jghsjiJvPEfXb4G+jXdMry9quRrwUXusA3oTDDOH8TLq9WKp/0h2JZWmIY9qUEoW9J7w+CKmmbd8iqWYUF/z/cUAZZUGPUgVsfBg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR06MB7403.apcprd06.prod.outlook.com (2603:1096:820:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 10:33:28 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 10:33:28 +0000
Message-ID:
 <SEZPR06MB695907832BFAF8108053976B96202@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 7 Mar 2024 18:33:22 +0800
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
 <SEZPR06MB69594BB6F24CF86E859D698196212@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <66f578b4-5e1b-4cc3-b39c-3b61797cacd3@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <66f578b4-5e1b-4cc3-b39c-3b61797cacd3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [SYFqZ7OIiDJSX6zWo9CPjIhfaFm+7u16/ZTeTFoRvE/7ZmAuj0McQN+zSgurFrug]
X-ClientProxiedBy: KL1PR0401CA0028.apcprd04.prod.outlook.com
 (2603:1096:820:e::15) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <a4e87d7f-ff71-412c-8d5f-9760b598156d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR06MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 9303c98d-52ad-424f-53b4-08dc3e9206b1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E30i2Bi58LHhjs4z3cuo/QjybB+j/dH+HIjlQ3l5L44sabEhmv4CQ8JOI+bEFahXappOiJZ+iMXcONTR3G8y0STdqjrhbdR0ZA5ke0FXkStHe6R/zKT4NvkZf+iSlKOm2oQebqSH+bMM9CjuYDZ/gftlaBkCF3k2SwbQY+9phi9Fcq0F3fdLDzThfVpAbOFyJw6hPKX64KcMHQwO3DJiFedOVaqrz0xYKwaRezewMkXznDqTzWskq9Jum4koh4qdVq4Xn6s57kAWhFEjfbM+ak3WjMCYQFWPGSwQBGb6hCvuEFq0zXdLKchsalT00GoVwvCbDOjRYtYnUfoOhnyeLHV681zn0yf7MlNm3uC4mlqUJFtXqnSuaMo4G1vGfHldwTPBdjSBRKzYdzwsVHiyzM3yWh3+WlblHwVytJosXpTWHzLOX7/TTiKNfmkjb1GX85Qic5/3/z7lz9umEfM5N8YoPwDPHAc+kYJ6a9E0nboZ9p/HSh9GVtdqYvd9LK0ns+yr/pmopzhznbK8v17J0Eoyx1ijSXKpRSBCjOwB2rabNIjkEdcNkVKPiLWe26Yj3crenScVLzce4MhVsSJlsYBM7vOTUh/KMVv9W53HL/Q41z12tpdWVuujpEGmj8zf/kEBbuljROpnedrSIEcG1tga0lsCh+7/q4gmFMdfs+o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDhOUFdJSXhWbTdGc1EyQkJrZEk1djM0elJSc091R0lmRVA0Q1J5eGdldEgr?=
 =?utf-8?B?Z3pERFVTZHU5UXhqdU1OOXlldXNjVzdxWkZuUXBlTGtUdWRVNjVheDZiL2U1?=
 =?utf-8?B?eTk5TzQxbkNSTWd2dUdHZ0hTZmFuK0o0VW0xelgxVnJWK0JvVzV1Tmk0b1JD?=
 =?utf-8?B?WDB6cGJmZGF1aHBpOWlZc3hwc3I0em9SQXlKdHBTc1oyQzJFTU1rclczS2d5?=
 =?utf-8?B?alpnWW1IbzBTTzBlc0xneU04ZkFMb0pDcStybGw3T1BNb3VWbzJURTRpcHpn?=
 =?utf-8?B?VGRKdndQaW50ZURsYzhkUjNGNHlnZ0pBY3NWUkhobjFJZ1ZpU0N6YVJvMFUz?=
 =?utf-8?B?Yk42aUFNT1dhUDl2aUYwMU1zUGtDWHdrNzUxZ0FlNjlybkw3WDNsWGYvU1Zi?=
 =?utf-8?B?dzNNeW1kMUF6VklJMENmbFdIaHZka1FWbERZZVJoMlRvYktMaVR2L2EvdVk1?=
 =?utf-8?B?Y252bjVzV1RRZTMrRnN3aUFMU3NRcXZyclloaUlBSzFGcGJQbmJ2aldETkpy?=
 =?utf-8?B?My82TkZ0R2VHR1JDUlRDS1VEcnZXL1p3ZzhlN25sVW9hZkRjVGNXL2wyclEy?=
 =?utf-8?B?S1dURUJUSnp1RDBTeFBwNGlub0c4dUV6RmVWdTlWTTUvd3YwZkRHaExmQ3VE?=
 =?utf-8?B?bHJuN0xBMkxMR2tjUW9XdjNId3VvVXV5N0x3ZUljMGlUdWVkLzhOdHk3a08x?=
 =?utf-8?B?TGRtOTgyQWNwcEg2TXd0OUJ0SlZQak0wRDVVZE5UKy9iTTVvMUVzK1FhTHZw?=
 =?utf-8?B?TlNvTHlxSEc3ZXBGUzhlVzh1WlJ5cTRtQ3VWblBrUlgzdkV0UlVXSzdUcHM2?=
 =?utf-8?B?dUEvdEZGWjN1MEFscVdUaU9NKzRKYjhzazNZaDN4VktpTEwvenhLdSs1czdH?=
 =?utf-8?B?a29abDFrRWJGQnFJNFVVR2s3ckFrOXpFTkR1R0J3RWpvRytGMWh1TXBBZEo2?=
 =?utf-8?B?R1YxY05laldORGFoTDh2K2UvcmpoeVJzWjlEM01SNUZEb2hYcENiN2ZJZGF3?=
 =?utf-8?B?SXRQZFI0N2dHdXplV3NOanJ4bFQ1bU0yenp3Q1hrNWYwd284UHk4QzZZaEta?=
 =?utf-8?B?NXFpbFcxdmFhWHdvRDkvQThNZWo3L3NXUVJnQ1VqQldGWVQ3L0hZV05EOWFw?=
 =?utf-8?B?ZmRkUUE3YlpjMXp6UzRPQWMrVi8zM241SDhQWHh4a01MZ2Vma2t3UFpuYytu?=
 =?utf-8?B?SlI5OGhFbTM5VU1lN1NxT0dHUGRCR3N0NEo5Z2NvZnA4WFluaXA1OGUvS001?=
 =?utf-8?B?WVVmNU5NRmN4cE1sRUJQN3pNVXAydzVvYWNPeWpGekVTQjV5aHBtcm43c0RY?=
 =?utf-8?B?cE9nbjhnWC9TbEd1MTVWelFzNTdJUkg4RFAzcEVUL1BWamUycnJ5Z3JQSVRz?=
 =?utf-8?B?ajNpSUNkbnNiMk1LUVZrS3VvRGNLT2RaOHV4VnZYbm1BZGY3d1kyU0Q4Z1Uv?=
 =?utf-8?B?aVIwVFdRZWdsc3hacGZMbHFHYkF6NllrdDZGTHdpYmhjaGJzMWJDQnlVckdN?=
 =?utf-8?B?amkyelZiM0h2REhveUNMcnpjVi8ycW9tSTlNMHFPS3FiZDJNUCtET2NOczh5?=
 =?utf-8?B?V1pMTmorMkY3elFTaDRqSEtucXQ3ZGNuZzRJcDNNUEVNWXRHR3l4MjhOTEpQ?=
 =?utf-8?B?OFVvZE12TzVqS1J4azkxNjlhTVRVcGhPWFFUR1FvRGpSbUhWTHF0SEpsOVRy?=
 =?utf-8?B?VWdnWVg2NWxuM2hkZEo4SS90SUN5dGNEVG81UTVlWkV2Y3pkRTBoMGVsdzg2?=
 =?utf-8?Q?QbOiMGGQcfHvevkJxnsr41cILPDnxz4vZeIo0po?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9303c98d-52ad-424f-53b4-08dc3e9206b1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 10:33:28.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7403

On 3/7/2024 3:48 PM, Krzysztof Kozlowski wrote:
> On 06/03/2024 10:28, Yang Xiwen wrote:
>> On 3/6/2024 3:39 PM, Krzysztof Kozlowski wrote:
>>> On 05/03/2024 08:51, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> Convert the old text binding to new YAML.
>>>>
>>>> While at it, make some changes to the binding:
>>>> - The version numbers are not documented publicly. The version also does
>>>> not change programming interface. Remove it until it's really needed.
>>>> - A few clocks are missing in old binding file. Add them to match the real
>>>> hardware.
>>>>
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>> ---
>>>>    .../bindings/net/hisilicon,hisi-femac.yaml         | 89 ++++++++++++++++++++++
>>>>    .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------
>>>>    2 files changed, 89 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>>>> new file mode 100644
>>>> index 000000000000..ba207f2c9ae4
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>>>> @@ -0,0 +1,89 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Hisilicon Fast Ethernet MAC controller
>>>> +
>>>> +maintainers:
>>>> +  - Yang Xiwen <forbidden405@foxmail.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: ethernet-controller.yaml
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - hisilicon,hi3516cv300-femac
>>>> +      - const: hisilicon,hisi-femac
>>> Drop this fallback, your later driver change does not use it, so neither
>>> should have binding. Explain in commit msg, that old binding was
>>> incorrect (we discussed it a lot) thus you are making such change during
>>> conversion.
>>
>> What about deprecating "hisilicon,hisi-femac-vn" compatibles and
>> introduce a new generic compatible "hisilicon,hisi-femac" instead? This
>> way, We can keep backward compatibility.
> What backward compatibility? Didn't you say bindings and driver are
> broken and you are going to break ABI to fix them up?


Yes, indeed the old binding is broken. I'm just wondering why you say 
"hisilicon,hisi-femac" should be removed. The FEMAC core on both SoCs 
are compatible afaik.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


