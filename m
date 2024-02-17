Return-Path: <linux-kernel+bounces-69880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F45858FCA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9AD1F21F87
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7D7AE61;
	Sat, 17 Feb 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mle11lRO"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2054.outbound.protection.outlook.com [40.92.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F7657B6;
	Sat, 17 Feb 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177594; cv=fail; b=X/ohT2D1Yt8pbLwwpkM55PfCkp4x4+5+JCr7WYFOAM12dx8oDZ3x6988GIrVoogqzjvgCU7I4rakSX0W51XGzkqeAjCQk6s22kPjHPqVQ/QfBZtTasuqtuagHj03Xi0jr76vcN233+MjOcBgON+YAgbbWhv/lZuVAC+9F0rjvDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177594; c=relaxed/simple;
	bh=r3K131B+2F1vLQfY60Bt8HzSE1PNdPD6fIFG1/fkl2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DkMN4PYs3fIycpDugkynNRbWyL7ckf0FtW7X25ZsMJUPaTtZ/LFc4A7e9jP/tzBQF6sig2oZWnm8babLucA6XImZLA7JeEv9mrOonfUBNuoLrZbkr1d1RirdV/UThbRpxND/q29/B/GpUW1tgqlkrlSrSJdFHbYcI9daykoZL0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mle11lRO; arc=fail smtp.client-ip=40.92.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewG9ewkW0kOENqpGnv8j8o1mjV0+coUCS6S2PN4yXVMXTSBkN+g+3CjHFz47cECdoAatNnTB44ybTcPL7a/cO9/OC+wyRv8oKfNuBgSSjLP/MUL+zp7aGwwlDqcfcEwB7XOdXwhXMJHUtjRPuegFhANbZzcOYilqTXqUYhCE12t0yHi7MTKIHxN4BuPgaLaKRa5x79HVyoo3zL4J6XFRPlBJcHIpjOgZ37Zrn5DeUK9mnljQGAQtLSvQ2gKYyK904fDT2q08l0vmqQ1n+SFypF0dMuMFtS/ucG1CWafOXphhh5CnGKKJhF8jRsd4w3D6TpcQitOEL908bOeWqfm/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD7x1ZE+ecHpnA3Zc+yVQ1ZNQhRtdRrO9T0COkxdbKw=;
 b=Um/2Ulsfl1DNe691TgFOFlj6aCtE9iVC5c5kzHxNuzWiBQ7geKjpBE+81/zD+yX0Kn0GmecjHLa++GLqLzF6pyg5vuNKImziEo7G5QMnUW98l00d+pCfFA5+G6JKr9PsfIIz6gYQWacg9zpVpz2EHn66t4Z4KwS+IzD2cPqooOMjcyTe0sEIrsPkHkMMSdhXy5sTNjc4yyxvMMo73qZvu1mORz6/xM5esAihkmI+a+Zb3mjp8IRf420z28iyF2s5nk/mwLi3bzzyv9WVpO1U/eUwzoxUmGw0xcPrlhB8tPqO3LAUiLJxA82iV9vfq1kCCFbnH01vhvNUyKnDb4JXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD7x1ZE+ecHpnA3Zc+yVQ1ZNQhRtdRrO9T0COkxdbKw=;
 b=Mle11lROGRQWrkUIIykrVO5SYO9KERLE+OM+YzC9p7dopbufhUeT0b8jScQjQ2BQHaYctncDcsWSsz04eRvbAE+wgNfG7A4INulrzcwUK+RTJ9V/oPR8U+/p7FfUcuaaUwj8FGcaXLPNjGJad+/kHa6vnCavKlvTZfqKdHwl/INg22ATQ6csVUsfGRC/1+Nt+/Wf3S/6UBPpK/XJ+8l8lhu0riiyCp7zLML9LlvbmMoGujeKVltdh/UsOAro3DTHLYGISrP6PW+TOOA5GIcUTGhR4k+oTLBQfHppHfJ+5R7tLW1HW/ph6TNYjItyhEhrJkv+lPdAEIFxep7y+fOaKA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by JH0PR06MB7054.apcprd06.prod.outlook.com (2603:1096:990:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 13:46:25 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 13:46:25 +0000
Message-ID:
 <SEZPR06MB695993BA7C54A2D5B19AAB7496532@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 17 Feb 2024 21:46:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] dt-binding: phy: hisi-inno-usb2: convert to YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
 <20240216-inno-phy-v1-1-1ab912f0533f@outlook.com>
 <63b3eff6-49eb-46f3-a6d9-878eddf6de53@linaro.org>
 <SEZPR06MB69593B898A42192D134B01A896532@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <dfecd473-dcc1-4977-901d-6c7bb615bc97@linaro.org>
 <SEZPR06MB695983231D04A2E1947AF61896532@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <712f8904-4b63-4a3b-8135-f17f41bbb501@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <712f8904-4b63-4a3b-8135-f17f41bbb501@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [W9Cymd93jNzxM7u/a0GCK9wMfWBb62jTER71+AFnrpggTEObRGbHPgNW0PxpXgYGfGWRVlggkAw=]
X-ClientProxiedBy: TYCP286CA0254.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::8) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <95ed61ca-38ba-4fa3-85c9-3219029edd86@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|JH0PR06MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fbe64e-63fb-406a-f3b2-08dc2fbed53e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hlDwM0zymNECVKF855XsazTtOBrA37vTylM5GI2x7h8Cz+NqGNHIGL+UZO4uD/qSmHFixyVfwUeHexSmISRaHGe7yJd8Jp5C0Z7QDrXS6IxA4qyCtmjs+Z8y6RvNjTMAK4ls27JJt5OVGFyiyRUZhnBYwkbKOOnsrtUYs6wYFvw+Pr+y5PrTOGWWx/xMdafLtZmAd9ikAKmtRHah3QDhNBjBtp1j1ztvA6bV0vl6HBpkoWjfkOELlAXCekH/TG0UynmCs7MpGun+1g/qU/SUEu6D8OjHRBgKrcpyi51JKZxiVG1gBG1yEKyn/qo8rA+I5tF30SImsSv8MS6anOwj4qxvWCjVMjpeLVoV2pitOOF97SLGSq54BLn9WyLtAL+Z5app7/SMaATSTY5L7QeFfgF7N9ATYt5VFWiwI6omp2ot0QN6fQq7CViICmgJtXUYFHoKSI5sUYemUiJQ/ElrBepTM+NnJGVQVSAFKlMFOs+Mf1lwaKF4OhyrYTFiN9o4331U0bsA5hVbZ0X5hdCtYAASG1lIp+p9kf+ZMgqURVqJ5k2Lu2zMBrPiADd+uCuu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmFNT3VHVWxNeDd5SjJac0FBVVdHQjBRM3dpam1mdE5ydWJZakFuYXhSd1E4?=
 =?utf-8?B?dXJ4Qjk2eFN1Z3dsRFU4Q3h6UG1KVG9WdVVPNEtCT08vclc5Y0t6Z3RwYjds?=
 =?utf-8?B?Mk9uYXhNb1dRaHdoVU0yUWdERWhIUXE1ckczOVNFWXA2TTdxQWJYbGJHSExE?=
 =?utf-8?B?Ry8xNk1DU00xUWRKeGNzMFBlN3B5L1oxcHY1RHBUNGhBbkNjcFhEeWhZMTE1?=
 =?utf-8?B?dTZjQTQ5WndUWWZwRG9vYnl2c2FuTDB0RlBjZVAzdkg0VEpPT1hzN1E5amxU?=
 =?utf-8?B?NHFIVTJ3Z3NabEVLZ3p3Wm1JRldPMDlnajhmVUhpdmY4L29ZWXZHWC9iaXUz?=
 =?utf-8?B?TzNTK2FSaFBlcFVybWlUMGppb2M1WTZUL2gySVh0VmpGZW9KS2xscGs0NDVZ?=
 =?utf-8?B?dVd1L2Z5QUNWN2NpUEoyaHo5MGtWNWtKSEJCZVNMclozeS9uYmt5ODRxcmZZ?=
 =?utf-8?B?TnRXT1IrZjU4STRYWklnaVVjdzBNblczajkwWVdXNDNpeDZUdm1nNXh4Y21J?=
 =?utf-8?B?c2NnajBqZnYzOGkwR3ZLWnZseW1uRUVhTDhIaFhZUXFTbjZGSXFtRk8xaUVV?=
 =?utf-8?B?VzFkL2ZoY0JTS0hwUklkaWhvQWpQM0c3MW43eHhoQVowKzlqdTk1WVF4T0JF?=
 =?utf-8?B?aUt2b2hrRHlCSWgxQlhqbVNvTGEvTmFXc3lRSzlhc1BQSzFyVkRlcHVFNEhN?=
 =?utf-8?B?NFgwZjVITnd1d2ZScWxBK0ErRU54V3gyZHhBY3cyV3NEWDdsS1NaYjhRMUlX?=
 =?utf-8?B?a09kQlBhcnZrMzBmeHphMzdtVmZRMnN0UitIUUgyTytVT0NNK05NbTc3Rkwx?=
 =?utf-8?B?NzlTKzFGcFFoSmNkaTh6RFJIaU55ZHFYMlo3ZFliNlJiVjJIT1pRajRKWjBj?=
 =?utf-8?B?cUFPcVZGUEtENjNDYW5pY0JMZ1VkU1I1bWxURE82cEdXUHVBeWJCT0RCWGRk?=
 =?utf-8?B?dERaL3lOVXpBZG9oVWFTTWczcHc5NjRFb2taUnZPK013eXpOTXVnUm8veHhP?=
 =?utf-8?B?U1VMNXZNZjZ0bFlKd1pTdEdidUpZcWJBaWtsWk1RbEJabGdESXp4UVMydlBi?=
 =?utf-8?B?NHBnaFMzY2ljUDIvNS9jaldiU2htQlp2NGRnbWw4Qmc3Y0s4aEFLeGlheTBL?=
 =?utf-8?B?YkN5bDRIdjJGeGR0dWxTMlZ0bFJRVnZ6Z3VuUWQ5YThwdGxpVWZyN0Q2M0FW?=
 =?utf-8?B?NE8wNTh2dTRSVXJDeDJLL0NzTCtneXhxNFZKOC9TSmN4ZVVMcnpZOGtvM1Zl?=
 =?utf-8?B?dXBGRWUySU1PUm95WG1kcnEwUk5ka2dWSkdETXVabXl3MDlad0xHdXhBZ0l5?=
 =?utf-8?B?blNoaTIvanVXeFNkRFVlZDd1NmlaRkw2MVhkNDQ1U1hZSmpOMHQ4WFl6M0RU?=
 =?utf-8?B?NFFyZFBXSlZ5a2NPbUVBV0thd2ZPWjV1U3NEWEl1TEtJL3k0NVQwK0sxaE5E?=
 =?utf-8?B?Q1NaM2JDU2Q4TlYxZnhjam4zby9LcDhaSXFTMnY5U3pFUGlod2lza2FNd2ho?=
 =?utf-8?B?c2ZUZFhON0ZyZGY1QWdmL3pzakRBZkhKaTZmRFUwT3dlQmV5OHJLbTVTQ0tT?=
 =?utf-8?B?SVQxMEtldTVWei9ieHJaM3JzRXJkaE96VzliWVdCbjRvZkIyL3F2UEdLZjBz?=
 =?utf-8?B?Qk1BTy9nYnBsYTJXN3VmdnNpOUhPejR4eFY5WGs0dVpJQUZDTk5wRVRMMEpV?=
 =?utf-8?B?TzFPRHl4azh3TXRicnpkcGNnZFNJbndVekZUMWl4OVBxWE4zbGtKbG1Wd0tE?=
 =?utf-8?Q?XJure9WWX3hW5MWPNfzkcNvPNqvYbjRQt956uJQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fbe64e-63fb-406a-f3b2-08dc2fbed53e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 13:46:24.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7054

On 2/17/2024 9:39 PM, Krzysztof Kozlowski wrote:
> On 17/02/2024 11:54, Yang Xiwen wrote:
>> On 2/17/2024 6:29 PM, Krzysztof Kozlowski wrote:
>>> On 17/02/2024 11:24, Yang Xiwen wrote:
>>>
>>>>>> +
>>>>>> +examples:
>>>>>> +  - |
>>>>>> +    #include <dt-bindings/clock/histb-clock.h>
>>>>>> +
>>>>>> +    peripheral-controller@8a20000 {
>>>>>> +        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
>>>>>> +        reg = <0x8a20000 0x1000>;
>>>>>> +        #address-cells = <1>;
>>>>>> +        #size-cells = <1>;
>>>>>> +        ranges = <0x0 0x8a20000 0x1000>;
>>>>> Drop the node, not related to this binding. If this binding is supposed
>>>>> to be part of other device in case of MFD devices or some tightly
>>>>> coupled ones, then could be included in the example there.
>>>> For CV200, this binding is supposed to be always inside the perictrl
>>>> device. The PHY address space are accessed from a bus implemented by
>>>> perictrl.
>>> Every node is supposes to be somewhere in something, so with this logic
>>> you would start from soc@. What's wrong in putting it in parent schema?
>> When the ports reg property only has an dummy address (no size), it must
>> be inside the perictrl node, accessed from the bus implemented by perictrl.
>>
>> But when the ports has its own MMIO address space (mv200), it should be
>> located under a simple-bus node instead.
>>
>> So it's either:
>>
>> perictrl@8a20000 {
>>
>>       usb2-phy@120: {
>>
>>           reg = <0x120 0x4>; // this is the register that controls writes
>> and reads to the phy, implemented by perictrl. (just like SPI/I2C)
>>
>>           phy@0: {
>>
>>               reg = <0>; // the reg is used as an index
>>
>>           };
>>
>>       };
>>
>> };
>>
>> or:
>>
>> soc@0 {
>>
>>       usb2-phy@f9865000 { // MMIO
>>
>>           reg = <0xf9865000 0x1000>
>>
>>           port0@0 {
>>
>>               reg = <0x0 0x400>; // used as MMIO address space
>>
>>           };
>>
>>       };
>>
>> };
>>
>> So here is why i include perictrl node in the example. If the ports are
>> not mmio, the phy must be under a perictrl node. Or if the ports has its
>> own address space, it should not be under a perictrl node, but rather an
>> simple-bus node.
> I don't understand why you keep insisting and discussing this. You are
> adding other compatibles to this schema example, which usually we try to
> avoid. You entirely ignored my comment above and pasted DTS which is no
> related to the topic we discuss here. I did not question whether this
> can be or cannot be in some node.
okay, I can remove the parent node if it's preferred. This is simply the 
most usual example that exists in real dts.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


