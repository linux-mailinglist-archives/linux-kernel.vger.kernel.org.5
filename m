Return-Path: <linux-kernel+bounces-68338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076958578F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7359CB21DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1D1BF40;
	Fri, 16 Feb 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jvkFIW3B"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2023.outbound.protection.outlook.com [40.92.107.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DF1BDCE;
	Fri, 16 Feb 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076230; cv=fail; b=LprsZG0hlABJM+vPKbW7MD7CVhn2lDuayRJHWGu4yAClpRE5W9bRKcjQmwIIaDBotAy9IpB37yo+M4VXzPiQjY0aef4srXC1i1NpZqLwaF+jl1O0od0zU7USvI7KRhRWhJUtNB+k9YWaZDAHl/O68HyjEwLGYEoY+IIOyK8qi/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076230; c=relaxed/simple;
	bh=ocM/XUZhqjkw3Gl/PA2bPuNOgo+jU4iNkYk8OFDDleg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FpHQtZTj5imXJgYvqejrSTiwjOO7Yu5SrnzXkIAMpXuHR8tHzpraEFA61kV/Cm6Rjmbio6M1ycehU5WqDRgkZKTaWgH3c9qV/HWD/89MY9X/Jf2gUzOxJNUyD74mJp4Io3nkV2Oxa42PGON6Hu4Hi6EX4XIQTZoo3Q1WNtIq/6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jvkFIW3B; arc=fail smtp.client-ip=40.92.107.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+UBwQz8qpLNcFbfoe1B94qrSFeRSvqfh6qhNYzmLRVkbQaj8M77yaWhyjk57bAFHAudV4y4c4i57LHVYEmeHjOotaXW186pjRv3DA8JKRaCKjLa6O0FwdnSg9kLtD/hqy1TWYfH98Z2Sb8qG3Lkm7EyFpKcvBR6sV96XOAeV6yR6HL4hFA77xFoVE4I39avLRF2rmYh8PfWtbsr/b2Ev6JKHV4U/4CcjyvbLIpdWI5KbiyoOI8NvUf2a2e9cuj7SS/FM0uvFQjA/ThPoj3rrIJqo18CAuuCQQImD0cQj3lO5hVdo2yZyEbfKJrSdgh5Mmd6fybdRKBOA/27EWoJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEFK6e6O7ea8ujSnJmN5RCUjISjevfLeSfZzJDeNwm8=;
 b=l03Q8QCgL7zI+SPJSvZ0C2R3Kw70w8Zh5Z4PQ0gEdQ6Af7qRrNgoolS47IKSCmNwf9ermS7TkWaEJqCsMyIGtoL9u/KrsMc2MXHJ1NBx6awCxL+GjbDCzXWugpGFcyBJkmIBQNcbqVlc9CZRPCSIdTYLMilBM/iO7DLQP0UzcZCScvKqQdhQuOpsuor2rJgrzOpFflRBKA3afDThWn9SixCt6PKgOJP6l8g6WSMrOXezBJCJg23zW+2vdar03OBarBAvU59rKlqHwjZ6S6tRcGrXJc8N47BZteEptqMHtnSocjIRJkywGTryQa4K3BWqzsyyLRZsg5mgV3RxmaIpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEFK6e6O7ea8ujSnJmN5RCUjISjevfLeSfZzJDeNwm8=;
 b=jvkFIW3BM4vOWij+v5WH6uWUU8o0wBr2j7AihA0TCsXqnyzRtBz6kI3HdXZueLtltsj2Oj42VHG0EXpJlu1KF/CWMxtW/rVY5o0DqZw3nbyFIqU40HHfviBZ0GNcvCCeY67gd9Mnssn1S23w4oQW2UEjEG6npMFpMNA1RuupkfBXSThK6kBeOsYwy1RiyinqAv0Y7gZm8kCaNiipxkMTcxp2vrPOIaNgS2eGKItksU1vaVodZL81qKHa+QjZiv2W8IgNFXC/jsnuIElMUhq907tO8l6c5RwP78Vt0kXuUxb5Ml1dNCt8JjaHarCrRWYsWIv+5OmvgrbD3WIFC+nyhA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6357.apcprd06.prod.outlook.com (2603:1096:101:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 09:37:02 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 09:37:02 +0000
Message-ID:
 <SEZPR06MB695956C782A434A63501CF89964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 17:36:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
 <5cecd33c-7436-4b2a-84c2-8a28c87b26b3@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <5cecd33c-7436-4b2a-84c2-8a28c87b26b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [O3K7gExqmE8iX6m42g2rZNgYnJC4RF8DBNzqzsWv5lLFigZzr9M9vRcD8jvCNy9mfny6nb11Clg=]
X-ClientProxiedBy: TY2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:404:f6::28) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <cd0e58f0-7b50-424d-b2a7-89ad655df3ba@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c87e12c-8823-4dd2-f3d0-08dc2ed2d402
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	69Y3RZDm+IcTbiAij79hqZOm6l0HB0IWcRG+HNkSyz1UGbSTMfP1VwgDIqsNvH93oP33g6uKCWpMjUVDhoutyqIZ0zxxWDX+pst7oxsRY7FWBqPQTY15Bsfea0foAa7M9ZQMUNHi92tQClwMRIyWJbim889zt4Wxy4n6fzcy0q0GniLnzPHOwn2NACrcieRcR2C4uGSq4YtMX99/L/1Evkp+sBUg80Vf38CvIELg5A8UEjIS5UCBKZtgY8aWUVapwGBRdMBUgFQ2CDUcAtoPvnTmadWNhOK0MRxbHHAEtGKJxjrUudGiydTBRt2mR3Sd2D9Dm/yHyK4r+zpHjlPpfE+82kyyNd0W3mn4FtYnEwW/3IQec7oZ9ArSMu7iZOHmsSWzPOaNAYdkKYhdWAlfq44MR/KK0jZwbp9zgHNAQnej8s8IP1Tkk99xQomCgaC2ZAsAYssn5WCpr30wv0e6PcpMbhkOve5lJLqcvT6nKoQtfT7BF/DrUPRvsaF58aepkC/MQtrXIrb2YzZdbVG2+EH1IpMayVT+s16RzZ5x2XjCosG203wnYeoxWOCD91/npHnE7M+02wgY0WXSlDSun1008WSFrwajextVp3EkQE+UjBxnj+JObC8Ojm9+kxHUXJEH7tniBTGKVt8Ff5m+gw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXNHN3hMYWI4K1RXamgzb1ZmRWEvZmhZMlB3Sk1rWUo2a0ptaEhGVmJUOGxy?=
 =?utf-8?B?S0FKWDJweXlqaHM0ZmRJaUYyNy9LNEtFbkY5WHBaRzd4L1BsMHgrWEhGMVF0?=
 =?utf-8?B?WFVKTll0Nlg2ZEc3Y3o2ZzdNOTdtcHNaeUJ0bnBxVjZqY09OUVJ3UU1FLzkv?=
 =?utf-8?B?OUdBZzNXMkd6ZmVYckJTeHBLVjNHeEN6TDJXUUp3K1pwZ3A0dnpCT3h4NzZz?=
 =?utf-8?B?Q21ERE9LQ0d0ejJMU2ZjWitlQWc3QXhjNWNrVHBoaXk3ZjFZcC9GMU5QRElj?=
 =?utf-8?B?ejNtNnFYWlJRbHl1T0RmelJaZGJGOWYxQkQzRlBsWXVNYm9jbGFqTUJIbDgv?=
 =?utf-8?B?UzJnSUJ0TnNtNE5CZHhHZThodUVaL2Q4UFUvNW9ucURMUUVEQ2Y5NUtHWW00?=
 =?utf-8?B?V2FmQmsrT0J4ZmdoaHVKWVBnamFpa3hFazMySWZJTTErQ2ZLK3hQcFdLMGdT?=
 =?utf-8?B?YzE1SFJEZGMwNGp5NE1nRkwrZzhUUWZsaG4yYTBDOU83ekk4RTEvU2ZBZVhO?=
 =?utf-8?B?WlFjZFdXblg4bzFvdFYyVHVsVFFJc1RxYU9RMlQ5YW5EdEQzL0kzS3dmdmtT?=
 =?utf-8?B?Z09Jc2VjVVhkbVFrRFJ4ZUw4cVlJK3ZCcThBcXhYSlVlVFFpallQZ1JPNWIv?=
 =?utf-8?B?MTVKSEdaSWpjT0ZNdWYvYmpjckVBaUQrc292dnIwR2xiUjJ3ODlsMmdwR0k1?=
 =?utf-8?B?eWxHTkxTa2lJY3J4R2ZlNWRXRUJCRmJMK1o5c3F0RVhXTnpxZFIwMGdTb29l?=
 =?utf-8?B?L2FPTkQvSGtNTmYvemlHekt0VERxSVJsNzZwLzR1Wi9saTdBZzdsWHVsZVlU?=
 =?utf-8?B?NHBGN0tmMis5VDd2OFQ5Kzd0UlRtbkdkU3p1Myt0NDhFWHNlUldqYmlGOS9V?=
 =?utf-8?B?S2FiNUN5UXVFTmxkLzI4YXBRblFxejlRRUtXOXJad0VFb1FCdVFEeXJPSGlG?=
 =?utf-8?B?bFNCaEx6TW1wak8wM1pLK2QxOVVWdUNXTmlxMHd2VXR4Y1NkbnpHcE5zd3hZ?=
 =?utf-8?B?QnNvMnNzQkxzQTViNmtOamJOc2cvSWhKc2NOMWFmdGNVUWFzWHlRUnd0UjRI?=
 =?utf-8?B?Y0VXb2lIN1VwWXlOWEdkTVF2MlVoOG1pc3NxcjdGVkZsM1F3QmI4WW9XNDdt?=
 =?utf-8?B?K0M2WnFEdDZMcVhwOENvcCtuNUpmZXNDSTEzU0JNNU9HZTgzdFBqM3Nlb0Vs?=
 =?utf-8?B?U1V6RUlodE11dEpxalM1OVZkU0M2VWtnaEQvM1lLYThXaldMQVBtMkhwTEw1?=
 =?utf-8?B?YXZ2aFczcnNmanhwZUZaMjRpTlErSkdjUHUzV2g4VUpPTUVqT215NHFTdHRp?=
 =?utf-8?B?TnlwTnBoN0lDVnpmV0gweUlZR2YvSVppM0dJM0lOWkxrWExXOVpMNDJXRTNh?=
 =?utf-8?B?VkdrWnRwQ1YzVktOUStFbW4vRHNCb3lob1dlMk9DdldzeEJsejAzWHNHUUds?=
 =?utf-8?B?WFh2Ly8rRWJMSWkybnUvTldRL3BoWEV1L3R3V056S05lTVBSdVdCdnFXc3Ny?=
 =?utf-8?B?U3JzQzh6N1BqbExxUWo4V3k2dEZDeDI5dmRrb203U1RUckRScmlybGpmK3Zo?=
 =?utf-8?B?TWk4WGRONVFNelBRanlaNDY2YnZEZGYzZ3UyTThMOGhvVHQvYTdYRGY0bEhh?=
 =?utf-8?B?bTR2OVA1TTB0QW0zUFYxVTlGeGhlK2FMeStXTmNPenZnYjFpSDYxYkhVRmU0?=
 =?utf-8?B?VjBYYW9mUWtrcWtJL3Y2bjA2emR2QTNaSkgvcmpYNFQ4ek9KMFVkc1hNSi9L?=
 =?utf-8?Q?660GYHPrYhvOsOxZc0DhiDmawuvICnr9f5NBhEd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c87e12c-8823-4dd2-f3d0-08dc2ed2d402
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 09:37:01.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6357

On 2/16/2024 3:24 PM, Krzysztof Kozlowski wrote:
> On 16/02/2024 00:48, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> This binding gets rewritten. Compared to previous txt based binding doc,
>> the following changes are made:
>>
>> - No "hisi-femac-v1/2" binding anymore
>> - Remove unused Hi3516 SoC, add Hi3798MV200
>> - add MDIO subnode
>> - add phy clock and reset
> I don't understand why conversion you make in two commits. Please
> perform proper conversion and then propose changes to the binding.
>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../devicetree/bindings/net/hisilicon-femac.yaml   | 125 +++++++++++++++++++++
>>   1 file changed, 125 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon-femac.yaml
>> new file mode 100644
>> index 000000000000..008127e148aa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/hisilicon-femac.yaml
> Use compatible as filename.
>
>> @@ -0,0 +1,125 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/hisilicon-femac.yaml#
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
>> +    enum:
>> +      - hisilicon,hi3798mv200-femac
>> +
>> +  reg:
>> +    minItems: 2
>> +    maxItems: 2
>> +    description: |
>> +      The first region is the MAC core register base and size.
>> +      The second region is the global MAC control register.
> Just items: - description: instead of all this.
>
>> +
>> +  ranges:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 3
> Drop
>
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    items:
>> +      - const: mac
>> +      - const: macif
>> +      - const: phy
>> +
>> +  resets:
>> +    minItems: 2
> Drop
>
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: mac
>> +      - const: phy
>> +
>> +  hisilicon,phy-reset-delays-us:
>> +    minItems: 3
>> +    maxItems: 3
>> +    description: |
>> +      The 1st cell is reset pre-delay in micro seconds.
>> +      The 2nd cell is reset pulse in micro seconds.
>> +      The 3rd cell is reset post-delay in micro seconds.
> items:
>   - description:
>
> Anyway, isn't this property of the phy?
It ought to be. But it seems a bit hard to implement it like this.
>
>
>> +
>> +patternProperties:
>> +  '^mdio@[0-9a-f]+$':
>> +    type: object
>> +    description: See ./hisi-femac-mdio.txt
> No, please first convert other file and then reference it here.
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - phy-connection-type
>> +  - phy-handle
>> +  - hisilicon,phy-reset-delays-us
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/histb-clock.h>
>> +
>> +    #ifndef HISTB_ETH0_PHY_CLK
>> +    #define HISTB_ETH0_PHY_CLK 0
>> +    #endif
> Drop these defines.

It is depending on a local patch which update 
include/dt-bindings/clock/histb-clock.h. But currently i'm not going to 
sent it since i'm still tweaking clock drivers frequently.

Removing these defines now would probably leads to a compile error.

Or I can just change them to some magic numbers.

>
>> +    femac: ethernet@9c30000 {
> Drop label.
>
>> +        compatible = "hisilicon,hi3798mv200-femac";
>> +        reg = <0x9c30000 0x1000>, <0x9c31300 0x200>;
>> +        ranges = <0x0 0x9c30000 0x10000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&crg HISTB_ETH0_MAC_CLK>,
>> +                 <&crg HISTB_ETH0_MACIF_CLK>,
>> +                 <&crg HISTB_ETH0_PHY_CLK>;
>> +        clock-names = "mac", "macif", "phy";
>> +        resets = <&crg 0xd0 3>, <&crg 0x388 4>;
>> +        reset-names = "mac", "phy";
>> +        phy-handle = <&fephy>;
>> +        phy-connection-type = "mii";
>> +        // To be filled by bootloader
>> +        mac-address = [00 00 00 00 00 00];
>> +        hisilicon,phy-reset-delays-us = <10000 10000 500000>;
>> +        status = "okay";
> Drop
>
>> +
>> +        mdio: mdio@1100 {
> Drop label
>
>> +            compatible = "hisilicon,hisi-femac-mdio";
>> +            reg = <0x1100 0x20>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            status = "okay";
> Drop
>
>> +
>> +            fephy: ethernet-phy@1 {
> Drop label
>
>
>> +                reg = <1>;
>> +                #phy-cells = <0>;
>> +            };
>> +        };
>> +    };
>>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


