Return-Path: <linux-kernel+bounces-68355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5552A85792E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12B628524A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B761BF40;
	Fri, 16 Feb 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VZMK6Itx"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2040.outbound.protection.outlook.com [40.92.107.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CE17BC9;
	Fri, 16 Feb 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076899; cv=fail; b=srkBBKbjGwdbfr8aNvRTmVwRoN2TkxlyacFijvq2GhKD4eFDFXwI4QnkqHA+hVZy0/mKGm3fmIIZmlJPG3uIHUmFYo2Jx9Xx97VZjQnT4N2qlDFbTHVqBRtVhWqaz1oWlm8fg58MeuG9q246p6JLbe32OJdh5x9VU6qA1VrsxQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076899; c=relaxed/simple;
	bh=anxm9Af74onrsFHGDGvWqS+HzzDsYHcWku9K8NwNr6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YK/LfLc5cuzX6c0CbyDLiJaZgyJdObz81nHhCKq4e5SjMYZCAO0VPFRc3Ur1cYtBcfW96QtJ1cOq7LI7YnQLClcIaBYyKcTGgmYh8Q4snwQlE2X1OYT3VswQv8Rp0pu/ocai6/bqNoNmhwQ2Bn9u4X7R1DIhGZ15K3XBRTWPKG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VZMK6Itx; arc=fail smtp.client-ip=40.92.107.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVFND14Z2K67doQC80n/agrUxcIXHz9KIOu6+WIVrSNeCNQm0wm2ZmhXOOKR1ZA8wkqdzwSWOGIZsFpz1CPcF7XvkxpYhB+7OOfKqZYK/9gliKRleun+sjWWCSSzyZcCIGob3bPVV8dHYHslwKKYtyZlZ7Ck9aneWoacjY8cj8dPtiZ2aFaY1qja17SoNwqTKBgiC79YgVNg6Hhh3I6iuKS6H7hefgjTgDyj3Eu47Lc7C/XNl6MFvAa5pjq+1v56XR8ya9GBuXNs4P6ZAGIb3hXSLyv+h9iz/AJEd9iD79uplXFTLgtTTJSvpncsMsrVCmVsHo+2ib/F0+07voz/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCeQLxjtWl/NWXXcySYz4pRqrdEDUSlnF5wSuDG2ES0=;
 b=B/4HqJ1nOyWna9+FBVrBwSBp7ekt5zH2afUKKkinNHhLs+Pz13QVXVugNArBN7Eid6wXLveF+OmuQ4FN85ufh0QHn3cwNoTJTgw2HbAj7Nza/tSd1BXPb+Sp/qKPvtLVW8ZsztfrhEFL898U8JQJwBn/41jencba80EOBweSELd8k00kq6KH6af3puDgYfXeSMMsRY2D8YS885o9lgQ5KHoWDdMaIWzAgQN62u2h9tn8xvLj/iWHFu1agrXlDj2eah9wfexegvDewleQSNgN4mP/X5/TY392a8tGrCZNxFlcYbli3xhYWfmSh8GNk/4Cv1aIRmmIh3/7w/MyCjRoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCeQLxjtWl/NWXXcySYz4pRqrdEDUSlnF5wSuDG2ES0=;
 b=VZMK6ItxzNCJJnrUdE2s6mExOjxPoA2wZYMBs8CMaoKEpADlUzIoyZSR2MCslFEcJI4WU/orHEXH3y69yMoxx3cVcC0ONf0ii9QTQDNEM6LRGTAznYP52D/uZaDNmGtBvRyHLgD3MqwJVcJYibw+6B90mf/ogKSBaUGPocQfz7F4dxSAba+JTVyQ39ZoePYlualyCV52OVx4s4TRlAjLDp/2Wlko8XlVjRUDgy/32UIk3B0WFmVdubYgFx+JtTPx3DroBoWedr83ASCLEkGoFqFHZJf39sAMbqfk0LWzpOkq+Sc0CspTvMxxnB6dfejvjMWGJwd1ifJtErcaFfM1GA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB5482.apcprd06.prod.outlook.com (2603:1096:400:287::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 09:48:11 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 09:48:10 +0000
Message-ID:
 <SEZPR06MB6959A553A6A2400507ECA645964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 17:48:06 +0800
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
 <SEZPR06MB695956C782A434A63501CF89964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <018144fb-0736-4aff-9622-238f8a98f4e3@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <018144fb-0736-4aff-9622-238f8a98f4e3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [A36vM4a7o++DH1bBs2UFYc/X/Pru7qPVweZ42Hn95dcjRUp2JctBRMH1IDG4DUH/scUBgB0yJDo=]
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <7b195e5b-1293-47bf-a087-4a5652b84495@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d10422d-9efb-412c-0b68-08dc2ed462a6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tERs1VW8hcyNf53s4YckoGB3rzMHoT9xkqixBdd40keMw1koiYQrhysneHLJdEsT7PD4ShziFI4KEFinuVcidv/i0ZpxkZkxoXHBf6+XRYpn8AD7aafjFz0mtv50UPTiz5DOukWsH4b9YOUJ9sjijeBdN7s/zrE3J4swIyM+7LSNeLNsoUDdIamDzZ3TYwc/6G4vcwcd1nTVuhnRoknnnIYSRvlJx1qqB8QMNUaO05OKpaEnbXAjtEQ5cSTgJ/0Hk9gvrcCm92N8xslf4WNs87XdjyEvs3pQl3vmGn72wppaF3N4Jc/njcajiV0BxGLC0RsyEJCm/fnd4ggrNRLLs4eiAZY6RzWasj+oqMjWW2GLYieO2WSU0tacY9mIXMkAA9LgE1ehnS2XLW/++WRwz1UKaVAeCybK9jj52XpFpOg8fXGklUvxjb53IEfmpx6Ap5GMdPxRVDb+zDhL7eZZDTYYyn0F3vchGjSXWz8F7jz01FcbrRNSL+toRlCyA2XddXb3/eIxcS2GF09vCgrt2dzzntNxsrORABJ3NmQJVJ5k0E0byVut8Jc0clBMB+4v
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWJmZTNFN0pLZnY1SFZTNzlrRGQ1Y1FYMVZESUZkZ01zVitDR3JCSFVlcTNi?=
 =?utf-8?B?U1NGNmNlK3VXNDY4Z2wwM1VWU1VCU3VqaFNMVjdsWXIxUmVERndEOTY0ZTQ4?=
 =?utf-8?B?MGVRR3lCSENFRWJUL3F3NEN6cjVNSzJxdzVoUEZNMElxVEloNkMxdHBxU0w1?=
 =?utf-8?B?RnFiM25EdlBNSWU0dy9kYyswSUpaNXprbzIvTnNZUnI1NS9PVDB0eTY3eWVa?=
 =?utf-8?B?WGlQcGVjeHowUmNpSDZ1SGFNa213bFhJK2pLRnpiVmNwbDJjbVRlcjQ5UHJ1?=
 =?utf-8?B?RzlRSTNsaFRFY21VQUJtZzhKV1ZkMjlvd09GazNSZkVneWJiN2E0b2k5RTJ4?=
 =?utf-8?B?WEpaY05QUUozQkdQL0NVaFdLaVhYbXhiT1I5YnAvd2g1ZlprMEZDM2luN1Bl?=
 =?utf-8?B?VUtPWkFJR3pxMEJtK2IrMlhETXJHZmMyaDNubzI5ZzNhN3FFQ0xXZ0w5aVV4?=
 =?utf-8?B?ekN4VXJ2OUd0VEhLVTV0NndTYmZxUXN4Ukw4WWN3ZFlVbEwyaE1aRDZuNWlT?=
 =?utf-8?B?SXc1Sm5ENUt3c2NNTEFUSDk0TVVsakNBUDRTVk1aL3BrSDVoY1pEVkM4OGJX?=
 =?utf-8?B?K1cvTVVmaXVOMUN6c0lNVFRVMjBValVZb2diUUYySmFyRFJyYnluNFpEVGY5?=
 =?utf-8?B?QkJnMElDWTl5dzVxdlcxWldnbm5ZMWdFNzZXQ0JXMTlkbFBlSWpnRTNhNWhS?=
 =?utf-8?B?R3g2eVpIU2RUTExVVnplaUxNVEhuRHRnV3VmQlJhU0IrZUhVeWNoZG0vNnVm?=
 =?utf-8?B?TXFRcXBETFZoMDI3WDFpdDdpaWF5VXJISWdpSUpmdnFaSDNYN2E0Q3ZNN2Fx?=
 =?utf-8?B?RVlRbW5HNlpaNCs0cTh5MFNWRzRUMHhxdVhEYnFuWGhYZzhjZVZ0d3JrSDRP?=
 =?utf-8?B?OCtFbjZ1YW4xMEJSV01DdU11RFY4UEN5dDNqWk0wd2FIWVViaWZDRXE1N2R2?=
 =?utf-8?B?ZmdwRzUrWlc3N0d2ZVJhVXZLeDZZM0UwNEVZcWQ4V2RlL1FDa3ovMDVoYkpl?=
 =?utf-8?B?UW5hSGY3TlhIbGFSajBtVitMemkzWG56Umd1Y0ZOWVVqL1R1VkVwc2FKUjBU?=
 =?utf-8?B?Q0pNa0ZOMkVwSmtHZjJWM0VCSTl0cDFHbTFhem12bjJJLzdnMi96OTBGcmRY?=
 =?utf-8?B?Y1QvWUFYM25TMC8zZGpLYzdFOWs0cW1URGh2OWQ3SUQvWHBhZjdSRWRta3R4?=
 =?utf-8?B?UDNXcTViYjEyK0duSG92dVpQUjB2WUdsdVc4bjZ6YitjeVg3YUF2TmhUSFR1?=
 =?utf-8?B?TUlZODhJSHBKS0FOak44cGNaZmdKcVE1YS9DODgxZVV2RHRRTjNpbkM0c3VD?=
 =?utf-8?B?SWtjQ3YrZkZlY0hQUzlaNmZXRE1FOEVhaHlsc3oyck9BUEtkWjR6Zkg2enhW?=
 =?utf-8?B?YTI2TTlickJKUVlWZ0NZeTllWURCdWlEa1BuNHhMTTdVM0NqOEptUmZVVzFj?=
 =?utf-8?B?bkZnd1YrTExSSGx5WU15QmJKZ0hqVVUvMHNxMUxLY0s1ZU9FV2FXLzF2N2pN?=
 =?utf-8?B?aEtwVmR1VlRETW5kS1A3Z1hrRHlWMDhQRnplRWtIVFB0cDJRcTVibjV6aE15?=
 =?utf-8?B?TW11SzJVdjBhbnZiU2t0aDJXL0MrUDMzSDIrSTdQR0QrWktId3JzODBHbGtQ?=
 =?utf-8?B?MDMxanhQM0NCdklURmtXUUNJeDI0RDFaTU5VZWdyMXc1QmNKNmZtNWJSOCtK?=
 =?utf-8?B?Q2wzYXZaZkhCZndXa0JJQzFwUlBCMzR0S0JtaThxcCtrWUtQdkNLRW0zaWwx?=
 =?utf-8?Q?si57fhm8UlJU3nvxoxli9E/k7CegmV0fqhVrPIX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d10422d-9efb-412c-0b68-08dc2ed462a6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 09:48:10.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5482

On 2/16/2024 5:41 PM, Krzysztof Kozlowski wrote:
> On 16/02/2024 10:36, Yang Xiwen wrote:
>>>> +    maxItems: 2
>>>> +
>>>> +  reset-names:
>>>> +    items:
>>>> +      - const: mac
>>>> +      - const: phy
>>>> +
>>>> +  hisilicon,phy-reset-delays-us:
>>>> +    minItems: 3
>>>> +    maxItems: 3
>>>> +    description: |
>>>> +      The 1st cell is reset pre-delay in micro seconds.
>>>> +      The 2nd cell is reset pulse in micro seconds.
>>>> +      The 3rd cell is reset post-delay in micro seconds.
>>> items:
>>>    - description:
>>>
>>> Anyway, isn't this property of the phy?
>> It ought to be. But it seems a bit hard to implement it like this.
> Why? You have phy node, so phy should know what to do.
It's not PHY which needs special treatment. It's the MAC. The PHY needs 
to be reset with MAC and BUS clocks disabled explicitly(see 
hisi_femac_phy_reset() in patch 1). I can't find a way to implement this 
easily except moving all clocks/resets management to MAC driver. 
Especially when the boot loader might has enabled the clocks already (so 
the clocks need to be disabled explicitly(i.e. call clk_prepare_enable() 
and clk_disable() for them, and ensure there is only one consumer).
>
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


