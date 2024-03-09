Return-Path: <linux-kernel+bounces-97887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058887712E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A53281DEF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E83BBDA;
	Sat,  9 Mar 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VYwraCh8"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19012004.outbound.protection.outlook.com [52.103.64.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EA16FF52;
	Sat,  9 Mar 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987438; cv=fail; b=cXx2phvwLftUC1HRraUEH3zV7/GZPDNndkAaRV9ScxwI8nZQURYsOS/L/w2EU0S0lPqa88UYII1pmkO3UPTz9F9vhsRv+WxfU2+iKv43OlW36U4q4Swv7MBBvr6IXQNrYfrCDNyhDb5ealD8klSpOgNF6ol+agjsyXlMSWTdry0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987438; c=relaxed/simple;
	bh=u+VkzISeco/JklhdXmARk8pxL5uvMk8NpbXEg+U7iGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eqYUiT8+MGj1wtetLauHAMFGY+PWUnNZ6h9AEvbKQycD8VBxe+JLDCBKYe8sAU35LVEFs2E3nKUL+yahpODrzPLHmR+bP2Cdae11BWjHqL8T/gqsnKAbcq4JaZX99dlrrKr9pQHAGoMGj8VDOdvk6C9nSnVffodNfwttDkI7bLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VYwraCh8; arc=fail smtp.client-ip=52.103.64.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8o9p0JWj9h9G6xl4KnaPkiXY4mXItjJ5YRiaMyL6kof6JUlx2PPZvj81E1OK4l2YXlK2il4paH+sm4955DOlK5zCNus3Z/kzNDO7TFNCr3TFqHMr4kcoJOa4FQUExQvmouCm7IAeUt2p2wlBB4Kav4fKTsO69dmG0eXc/H56U/UDy5BcdIT66wn09TGyW3+PJOw6Q+UYJjbj0igd4UBCHEF4gmZMPrckle95efX6XI108Dy7BMX/MeIOUFc2I0MBMPZ+/YtnU7up1tOtfqb7pvTiWFPi/oEukTvChF1IgSv45U/diw2ZGjpthnee32h3SjGusVB4cB/p607E7D70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DrcjjV1xW18My6tmUkNZqzeDH8TqmsdNJPpAje1PJw=;
 b=JfArNQ+4YcMOiCVhuZOKFfXZAfJMfSAg2QzrPv3R6hbDwH83HBjwBDpHOIXj4PamYYPmr67mOkdXx7IUMgmuLPAlAyPiJ/Cnmv7IkRoadQ5OeEzVcYphTGqapVhB492VZkoMNmkYdaUy888pHRvxU5R4eTQUnhnlR6U98QDwdNW28oi//6COnDeZwKmMY/J/4azxnmv9Fpa+4Gu7ZtFRHF8dW80oFmFfFZcELtlE6Er/y2YrHLnsZCuJKp31x9QDsrZOHQ11ETPa8/VlSbosfBmGe1RNlvUygv5cIwWAdRKRxZfIMAFleKs/kGRZo89pK17IaOw1KjHfOLgfEGj3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DrcjjV1xW18My6tmUkNZqzeDH8TqmsdNJPpAje1PJw=;
 b=VYwraCh8fHtTRIkRXMC2PGAoUzjD0NWuLNwMbjQp3nLbv2ZeMW9eLrt/osu+XOiQWxfT4uwr30BL68wX8PGDJp+nL5s8Vtz6YShTieFvjJZF/L0Z9fft1fX9AvVivItxa0aXXOssn1+DTF207lyuHSySHn0X7sFM+ek3eAP7tDzxdnTbrDvGZU9FunwCRwM/DvbAZdDvN7an9shOYkSMBSyQLkIfl29fJIiMaokRc+grngyTRU63JB30C13gGap2O2AQKP6bnNnJ/3HjphLvPsnZTV1wphdjvXC59ZUD59+lNNt4Lb0Ez2pj1jAh1cvMApuyMe6/AFLQre5oOxgQKQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SI2PR06MB5412.apcprd06.prod.outlook.com (2603:1096:4:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 12:30:30 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7362.030; Sat, 9 Mar 2024
 12:30:30 +0000
Message-ID:
 <SEZPR06MB6959090F2C45C3E5D6B3F9F496262@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 9 Mar 2024 20:30:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
Content-Language: en-US
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
 <20240309-net-v11-4-eb99b76e4a21@outlook.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240309-net-v11-4-eb99b76e4a21@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [KYYlyop0K8RQ7PPqlCYlqaSGjQSMoOV9sD4CUGvwDLAThN1lOh7welnVrUESs2so]
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <60b6a593-59e8-4350-9a9f-2b35719d37b9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SI2PR06MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a90155d-b5eb-4574-7b10-08dc4034b4e9
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQCMYMcbXXZJy0svpOwpVDjptAEIJfK9UULqWLDcXqyHGuhAwbsdGtHJ/wHoTT1Hxdb2pqFQUOca6fF/IRt9DJgoTkaCFhNV38WUe0WQm7Uo/0cjHci14FwE7Nr4pSkkSOcPhZAyaTtnb39e1kLMAccobv0y3g7DfS3/FwZufscvz9aspCeuCtGrUVpW0CcDZqk+yzxo2P1kZUQHPoRoHAzGWL8olQDzv4B08dSkJ4rmlB0Mz8M53RNyX9Kt4Fwuy4VEMDX/xJNfKnZJFmLz8ypIrBtG3fsa4Z4KQcd8o75OOIblSZ4C51GJBC0rdc3mf+fWPgdSWJIty/mFJTxP2OMQzh9c07+QCS+ysxzPAYur9kEYs+zhPkP760fSdOx1iP5SIDy8uWz/9yCoVgYYqJB3iTnyfWgydL7JPleFj+dWok1kvRldVCJ0L+6tvw9ZJ1MoVyqoDv+iprY46t0YuaJApo8Nr8tAJBCN1VyJGxX7ZNBSJj1RqlfxvDfbtaIQhlCGp35Vdek3bP+Ly/S+S8O9iXCL6XBEzIbHxRQWsRr9QTDOKTVJ9VBV5YnxyAxITHqcNlBP2gwKwW/CSrM3zDIajDLmpJoUpJDZus5G6ahJSZz4YQoc2uKn3OXtjPy4IE/oY2spsyC+PPD24uOY5lbD8HHkDvzWEwuDtlCL8WlqgmZGmgXrEmxmt9G7DOkQtBlZFNQlgEEQCly8A+5/xYBfNO+X7akk85nmvy7dzWv8eYCqSsEQHaYxD+HyFkiqdRHnH6k/v3JWh0mnJOgFlpyVrIBr/fZ2vlKr9tYLmpLuwnyA4Q8tUE+D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0In8RTEZdYiBFKpSdLkYcpa6c9lWyiTtpnktzZXz6tmYMH+WKMNHeMwbATzuQszpR8BejMagDK2UIhbWGaQuj98W/2U9cqvOtrMfDKoZaMyD4/kk09iO7fLGHw9RGxXDhlA76CzDOW8weZd1zqoB0uicszaQEJuLsQaNx9EDUgRHNzeg+yt1LdHtqJq7jDn5pANmLix0nH+Y/yqbjdrSvL1AYcX8VhM7JKK6FH3S6jASlLPCt+MTQhScbxhh3KgOzefG1o5JxyYJ9lYIelqYhPX9j/q3EHKSE7x41Ck4dgbFJ1BLuUnFqRGKhXHWPvN0r+k9QtHQp6a9vvp9M6VJR1eXWlKccrEC9ZruZcPfhZYETc462TJR5x/qUtd0KVJ+cU7top/m/TaXkgtF2zhgf+PGuuTzmnQKaPvny0tsCNAFbOo6CiB9+71SresInv1dipkvbvnEsWIBTQznQIViccTRFu6b7z/F8T9ufjSfpkcTOluELTrmYk0fV9+stBPALiC6tN6ZgRKQJ5vC1vih+Y/1N0wjRqTD6nC3kmJwQT6DvErKLnSScsld37iEDO8iBWQI+t5/TlXwS1hZtjYZrgSOJssQyoE/rxMXQTWJbWbLA22Bh86AQR1CGLinv2uu5PVpWEA4MfZiaka+WUHS0/ExpHu7OpUsgJriiKMiYCI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0pVUTFtM0c0elR3eDNLQ2lrMUx6Zy9sbEJrK3NpYm1KYTJicm1nanVjSFVh?=
 =?utf-8?B?alA1aXpwMFhjczVBb2xxekZaMFBYV29jTHY0ZVRHZXRITm5tV3A3cGFCYXYx?=
 =?utf-8?B?ZlNLaExxQTg2bENLS29XWCtzeTdEQmhXRldKdGZGYWpuYXJzRkplWWh5N2x0?=
 =?utf-8?B?dU1EaUVEeDd0QjBUQmxuSlFid2RTOGp0ZXViSTdnQTg2dk1jcVVnSnhGYnNS?=
 =?utf-8?B?MzcyMTFpYXVDUm5LM1Q2ZlVYRkgrUW5zamY4ZHI5a2o1YVVxVisvMFhDVThO?=
 =?utf-8?B?OG1lSXlBR2hWcVMvVlRpWk5FTzFiV3VvS0hDVWxjK2cvNzB1QkFrNjh4aUhY?=
 =?utf-8?B?OXZaU1lreFAxbzdYTmkyVmN0L3BYaXdVSWJjSmJhRlVYSjNnU0VXWkF6ZWJ6?=
 =?utf-8?B?dVpMNDV2UGYwcGJDTWNwM0I2czFSb1djT1RGVEpsbitwTG9XYW4ySXBwL2tk?=
 =?utf-8?B?YXRGUGNCYjhaL0RMRFZxR1czV0kyaGdaZXhPUTVQWGZ2UDNmSUJvVUJxaitI?=
 =?utf-8?B?VXNDVjBkdmx0cGFXWTJ1d29WL1YvQXdQN0NuQmFWK2gvRmZCUk4vbml5T3dx?=
 =?utf-8?B?cytFZ3YrVjNMVEJvbXRoQWNPZWpQZU5sYTRidWg2V0dEWE8zTlMweXEzZFVo?=
 =?utf-8?B?QUtiQnZxdk1MSjg1ME1VcTBXLzNMb3dvQWFxQktpb0xXMHhHUGF0c21VTW9Z?=
 =?utf-8?B?SklqQUx3SHRkTmVmeEpUa2JwN1ZXV2g3NkFkdTBSTnNRQmEwT1QzSjQyMko5?=
 =?utf-8?B?cFByTDdMQW91cTlNK2hoTGhTZDBtL2thVUxqMmFsdHZYUVphQm1Fb3J5dHli?=
 =?utf-8?B?NWVxTWdNMGZ0NkdZWms4MGFkbS9hci9Zd1AwVUpoQ0ZMWWVzaGxUcDBaVXVD?=
 =?utf-8?B?Y0RnVzMvNCtDM3dDZ3l0ejFEa3JmSXRORVZYNXc1a2R2M3ZSNDJoNk1qZk8z?=
 =?utf-8?B?MlFhK0M5UWhnZXNDYzNiaTgvUFNPYTFkWmlGQ2hNK2RMa2cwUHptSnljeE45?=
 =?utf-8?B?bmhXTWZxZzhSV1RYMUxaQWhmU1Q1MUt3ZTk2d1hGUUdiK05yOUhVUzRVdzJn?=
 =?utf-8?B?TnBYZjl2WG01RWlpVENGZkNQS0w3MFl4bStTNC9GZGk2SzhJZVFzTDU5RXhm?=
 =?utf-8?B?aWJ0SmFKUlJ4RGIzREhMV0RZdjVNRGJHa3M1bUpyU3pQeXI5YmVnaElYd2di?=
 =?utf-8?B?dHh2VXQrZGVmZ0Z2Ym1BNGdvb2ZoNEFvVkJ1V1lwd3ZVeFdyM1Q0alplTHFh?=
 =?utf-8?B?TjFNVzNFc0p1amtzWWJvY1JNQ3kySDlQYjJTVlFZTE1aUWFLWWs1bjMyV0pD?=
 =?utf-8?B?ZEMwNUZiRXdGcWw5ZHhjSWhUeWVFNDk2ZUNzYmJwYkRETDhUYjJTS283ZS80?=
 =?utf-8?B?R0I5WGlqT0VqYWVsSEk0YThNL2llK3N5VGJGZjBiU3RHcnNSZmE3eDlRdFBv?=
 =?utf-8?B?ZHdDcnV1cXlVbzFzQkNiN0V2NVFSYzlsYnFPZitNdGdXOXRWeEo0MkdYam9R?=
 =?utf-8?B?VjNTSnRnN25rYlNleEs0WHNrWFM2U0VXRExyRzhBTi95N2ppQlR1K2xOb0dh?=
 =?utf-8?B?WmtFb0Y2Rmc4VjdRSHFRdTBXakxXN1pZTmZ2aGZ6Qi85K0xMMVVJaHhTMGp1?=
 =?utf-8?B?dGZkREIxL1hJSjUvam52aStBQlM3b2VXZm1EVE1JRWJLNFNrcVJvZ1N2UGR0?=
 =?utf-8?B?Z2dwTEsyNlFGcHpuaUFUL2JJaCt4K1ZvL0JNUXBYTGREbExBK2ZFWGw0TUtt?=
 =?utf-8?Q?MOV6Hw9NxaADO66Fyj6kbYCDU+ac7LgBWAlxGao?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a90155d-b5eb-4574-7b10-08dc4034b4e9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 12:30:30.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5412

On 3/9/2024 8:26 PM, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Convert the old text binding to new YAML.
>
> While at it, make some changes to the binding:
> - The version numbers are not documented publicly. The version also does
> not change programming interface. Remove it until it's really needed.
> - A few clocks are missing in old binding file. Add them to match the real
> hardware.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   .../bindings/net/hisilicon,hisi-femac.yaml         | 87 ++++++++++++++++++++++
>   .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------
>   2 files changed, 87 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> new file mode 100644
> index 000000000000..3344d3bfefb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon Fast Ethernet MAC controller
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@foxmail.com>
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,hi3516cv300-femac
> +
> +  reg:
> +    items:
> +      - description: The first region is the MAC core register base and size.
> +      - description: The second region is the global MAC control register.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: MAC main clock
> +      - description: MAC bus interface clock
> +      - description: PHY clock
> +
> +  clock-names:
> +    items:
> +      - const: mac
> +      - const: macif
> +      - const: phy


Still not very correct here. In downstream the core can also have an 
external PHY. The internal phy is also optional. So maybe this clock 
should be optional.


> +
> +  resets:
> +    items:
> +      - description: MAC reset signal
> +      - description: PHY reset signal


Same here


> +
> +  reset-names:
> +    items:
> +      - const: mac
> +      - const: phy
> +
> +  hisilicon,phy-reset-delays-us:
> +    description: PHY reset timing requirement (in micro seconds).
> +      The integrated PHY usually have a special reset timing sequence and must
> +      interact with MAC controller to accomplish the entire reset procedure. So
> +      these properties belong to MAC controller, not PHY.
> +    items:
> +      - description: pre-reset delay for PHY
> +      - description: reset pulse for PHY
> +      - description: post-reset delay for PHY


And here.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - reset-names
> +  - phy-mode
> +  - phy-handle
> +  - hisilicon,phy-reset-delays-us
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet@10090000 {
> +        compatible = "hisilicon,hi3516cv300-femac";
> +        reg = <0x10090000 0x1000>, <0x10091300 0x200>;
> +        interrupts = <12>;
> +        clocks = <&clk_femac>, <&clk_femacif>, <&clk_fephy>;
> +        clock-names = "mac", "macif", "phy";
> +        resets = <&crg 0xec 0>, <&crg 0xec 3>;
> +        reset-names = "mac", "phy";
> +        mac-address = [00 00 00 00 00 00];
> +        phy-mode = "mii";
> +        phy-handle = <&fephy>;
> +        hisilicon,phy-reset-delays-us = <10000 20000 20000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac.txt b/Documentation/devicetree/bindings/net/hisilicon-femac.txt
> deleted file mode 100644
> index 5f96976f3cea..000000000000
> --- a/Documentation/devicetree/bindings/net/hisilicon-femac.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Hisilicon Fast Ethernet MAC controller
> -
> -Required properties:
> -- compatible: should contain one of the following version strings:
> -	* "hisilicon,hisi-femac-v1"
> -	* "hisilicon,hisi-femac-v2"
> -	and the soc string "hisilicon,hi3516cv300-femac".
> -- reg: specifies base physical address(s) and size of the device registers.
> -  The first region is the MAC core register base and size.
> -  The second region is the global MAC control register.
> -- interrupts: should contain the MAC interrupt.
> -- clocks: A phandle to the MAC main clock.
> -- resets: should contain the phandle to the MAC reset signal(required) and
> -	the PHY reset signal(optional).
> -- reset-names: should contain the reset signal name "mac"(required)
> -	and "phy"(optional).
> -- phy-mode: see ethernet.txt [1].
> -- phy-handle: see ethernet.txt [1].
> -- hisilicon,phy-reset-delays-us: triplet of delays if PHY reset signal given.
> -	The 1st cell is reset pre-delay in micro seconds.
> -	The 2nd cell is reset pulse in micro seconds.
> -	The 3rd cell is reset post-delay in micro seconds.
> -
> -The MAC address will be determined using the optional properties
> -defined in ethernet.txt[1].
> -
> -[1] Documentation/devicetree/bindings/net/ethernet.txt
> -
> -Example:
> -	hisi_femac: ethernet@10090000 {
> -		compatible = "hisilicon,hi3516cv300-femac","hisilicon,hisi-femac-v2";
> -		reg = <0x10090000 0x1000>,<0x10091300 0x200>;
> -		interrupts = <12>;
> -		clocks = <&crg HI3518EV200_ETH_CLK>;
> -		resets = <&crg 0xec 0>,<&crg 0xec 3>;
> -		reset-names = "mac","phy";
> -		mac-address = [00 00 00 00 00 00];
> -		phy-mode = "mii";
> -		phy-handle = <&phy0>;
> -		hisilicon,phy-reset-delays-us = <10000 20000 20000>;
> -	};
>

Currently both binding and driver assume internal PHY is always present. 
This should be fixed in the future.

-- 
Regards,
Yang Xiwen


