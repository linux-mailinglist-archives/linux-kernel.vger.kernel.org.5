Return-Path: <linux-kernel+bounces-72030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D167485AE0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E09B23A60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AD5475D;
	Mon, 19 Feb 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MdAk7S4r"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2109.outbound.protection.outlook.com [40.92.53.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B163535DB;
	Mon, 19 Feb 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379402; cv=fail; b=RkysTRg5OhMbLE7Fer920Z9ZND0k94wOpx37nbEiXLySTXzANajoAmSkVhrcMjzi+jSUZeSoRMwJCkTVv0Fm98Ova6RBkxzVjiL59pBbKTzVH3NO5+qf3kCaMKh1Gdgq+6+jwbbQwqlI+O45lYOdNhDQjxs5apN9HeGPwFVItrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379402; c=relaxed/simple;
	bh=BzYpql2bHNNIXVS0beAoZxkmc1dCPBfS1bY4k8xs4fw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYO3Wx1yoC6RQKSeCzyyR/HaShl+6NxTFhtpcUSq1iK9fVCm1cTZM3blVqFBDGJVbeLdr14fZ2+dlzz61BtIxIPa5so0w3cmMU4x3wYb6pJ1MzqyJ1q5IzPoAAphTB4zM80I4CNy3QAdgMaMuwa8n45JfutiDhAnGrnK1pvBgfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MdAk7S4r; arc=fail smtp.client-ip=40.92.53.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqoru7kk3C/jKZchAi30BQVuP0GrbVdVJgnAG9HGMshOnSaHHGHuczbtvL2xfmG05OgqEWbpQsYe9njgW2uGhsZ4bjWUwIqVCav4fOYEmh3ZalpBp17Wqft3Amu0DroAXhn1ePoMztpBkANoKUHE+bbP7hiNdisB02SXnHTND6UB0IhM/E1XCsNI7GXmUNsrbczAMPncryMC0GALTNnF9UcVRs0th9byYoAbcpjckMg1LuCPlboX7yVje7AznsXTQqjWJEFvBh0Is0ZiYwljQ4GOQ56ul6y4ngPoyuP56DnZjHBOSW/Df0dzukzZuBtL0c90QJPfDCtbZD5Gfl3yAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7kU2f1K6bQMsMfQhGT/iroaK+/1ORBJ3fUDB6VViEU=;
 b=XICPnuhMZLkbJXo4PMGwGIDJa0cu0omU8xDdi0gg1uyUVprQQqj/KiFkdeqsJgsW1XzgUNysZAiP1iLALK5BjC7/Ll+1G7qXs0vpvBXr9pv3JkeI58jZkimDKfJidwCyJb5JLfWI0Mvp4wRAoOpu0XW06FwJ3iA/dzUglH2yJr8XrdtloVmgFumfedL+V9mdKF7FkpWvI24pggWZIHXtecYQXOgNprzsk45puW3DgkrrZ6SH0rWUORzW2ZYRDYOzlEkrAeS02lwjoRHtD8GJSur7Kr3dw1d2Ej4uRFk6OakSWP95hvXsYbM69xYY695JkurdM/uA3DYYBCMBSFhcww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7kU2f1K6bQMsMfQhGT/iroaK+/1ORBJ3fUDB6VViEU=;
 b=MdAk7S4rUsjiAS/Xn1BaK6zRLVQYH4YdHG3he8oIx7J7/2PTpUMpjXO9X9FQb1FQEiF/yqn96WWBpzR52HDuusHu9S2HFP7SN2MD3EQ57RntAD3lzOSl85ieHQknKJsz48BRC4i/I7rw5RI1x6gTVG0YqnCaWc+gwYFleaI3+QohVVv2X0V00t9lTnlz2PzlunxInMhr6dcomm5iKzgOma2W3S3BW4rlwCjfZLVI6KkKmlYdBRHiZY4FlmPStu30E/uZL3LX1RuktcK/Cb47YPVy6INSti6svb9BDSUSbmYLgwxluvLhN87J1RsNzVaOAyKhovvpXesIpnV9xqh9Mg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR06MB5993.apcprd06.prod.outlook.com (2603:1096:820:d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 21:49:53 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 21:49:53 +0000
Message-ID:
 <SEZPR06MB69592FACB1EF1B9FEDA89E5996512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 05:49:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert to
 YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
 <62221084-247c-4a0b-a030-e12cb2931411@linaro.org>
 <SEZPR06MB6959AAB6B43F3E1F5E1C526596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <6f3f22f6-f659-494d-963c-544cf5f44adc@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <6f3f22f6-f659-494d-963c-544cf5f44adc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [FQ3BXibj0QxnPFnthjZcncLRcL4amSLO4nu8uv8+dxsJtF89CDT/WWZPZufXeG+G72F8HVCBxbU=]
X-ClientProxiedBy: TY2PR0101CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::13) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <d1e3ebb4-ca40-487a-8171-3a5a5fa567f6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR06MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b4d655-0ae7-4c2b-543e-08dc3194b40f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ELcJds9EkO7zMbbi8X5YN8J94Pmi02FkE0T7FlvKmHhvf8OnaZYHo2DuxK+o/SWKBGqvnbJ0PrZTjw8DRwGumtRXrJctglCA5SafGKwdjJEh8wXw30jskeDSNkOXgDYCRb70RVqPtDhssCCw86MpFfG9Va7M+rEG94Zx4FTwooDxRhsH1KuRveIkVOe37eV++CALZY3NSAfymr1vZZKnQL5HaIijkl07X36KixqDNSljzl9UTC2fQyLrdwVnRCfscGrLO/SII01sBS8yDLQsc9p2B02xuXsRlB1VBoWfIECo1ZakanX4ve03Uqkm3e3UfOv31WSIto+FRvbEou5VpLoWQYb0wlwSAjN/pPCl9eHdzgGyhTHRKJGspTHM1ivEdrbglzmJ01l70+gw3+TOJw2jmfTQRiVgnjmwHOv/WzSAR6YcESR+IHA8frTReg82NWbdX/Vg9vi5CnppaMT2THmvSt4QLb6ThEpxayzbyQwZyVVZeisgnuDskFpRKwJxTKpNDYOI9+npiFTb87bwlR0NgB8zAqsyZ5uOOPU0CRhJC2sJleYbhGAVo4zIb961cDoNIIFLIGxHzVmaa636PnrH+GkmYNaKJ8vPyoL8TnIYuFU3PRLeOaoBZtKBIf/tlJBH62n1Dz/0dA3uP8rVAQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0VibVJJeDE0c1lqendNelJkUUVwejhyQ3FVbi9IQk1PYm5ickZSZjZlYWlx?=
 =?utf-8?B?UWpZOUtWZWpBelRKRUJnenNZZHRsV0hMcHRwTm1WajFtUkNEK2ZweTZsZDZN?=
 =?utf-8?B?Z1p0cnArZTUzOU1IZjR0cUJ4VEVCUDdEQm5sU054MEhkUUlkdmRqMnY0dmNV?=
 =?utf-8?B?ZEdNd3RzdWVuYVZVNXoxTllzWEtRZXVoVW1FQlJKR2JsTzVBZjQ4Q28zUW9Z?=
 =?utf-8?B?Q0FpYndaaGhNbG42L3lYdGY2RjA2L3pwNStlemtkaVpPbWNqWE1pRFlWdFZU?=
 =?utf-8?B?Umx3UStQenZGWFFaT2JsUDZ2Q2lJbW5SdG1Ic3ppdGpwRzY0elRWSVQ1V0R6?=
 =?utf-8?B?NXd4dzFsc3Zxc20rbGtNMDJKOFJKN0l6ejZmY085VXZla0lWMEdwaEluUHFn?=
 =?utf-8?B?S1RhV24yVGVWZktyT2MzcXcycGxqckVhRmQxYkhDM2s3eHZtbHAzdEF1M3gy?=
 =?utf-8?B?TkNub3l6YkZQMkVJeVA4Wm14dFRBdmhpTFU2L1g5bkF1Zy9NV3piRWlEenFJ?=
 =?utf-8?B?OWJaT0FoeWEwTlJtZ0ZwQXhCMk1MQ0pJQlZwSFJEdGNIQndaaGJ1THFWVDZk?=
 =?utf-8?B?YXRuaDBjNWoxTEdlbWZpZmN1bW56UTlpTVkxNWRtaEgrNE5BOHhqNkQrNVNj?=
 =?utf-8?B?Wk1iblpGdUhIeHhHSUgrdklFU2xCV0dST0ZkYzFsSWRsRzJnbkVZTWVta0ZI?=
 =?utf-8?B?YTFwR2ZUcFNyRnZzbTRqeThCMDMzdVpTZ0RhSkZONzJBNktFUTNscEo2SVI3?=
 =?utf-8?B?eGprTGZpWWJ6ZjNkNzdiV3ZuZnUrZnhGbDVCU0NNc3JScnBvdHlTaG9EbEtY?=
 =?utf-8?B?SGdWbnVOUWdKUkhHOVdGSjNpY05HQzJIUnhiOVNkQVBVMEkyMEtxZmNXMDNT?=
 =?utf-8?B?YU1zZm96a1BhVWJZeGR2eGJLaHdERFNHQnJ5bGQxdlJTUjdZd3lFWW9zZ01N?=
 =?utf-8?B?QU9peWVlUWZ2YW5jaHljcE1zb0liaXVOV3pEMis5L0grMFhKZHVZZG96YlUy?=
 =?utf-8?B?V0FrMFhsSVNPSzlneG1mU0pvbFdvUFRVOVlJUSttUlkrcElpdW9vN09aUk44?=
 =?utf-8?B?UzRvajcwTzAvSENyVkwzTDJQWEZxMmZsd1hKdmF2NVhnSmVFY3p2cmtycWNy?=
 =?utf-8?B?UHh4YVowbEh0VmFHL29tVDFlb2NLdk5sK1FMSE5ueUdZSjBjYUkranBmVmFk?=
 =?utf-8?B?Sjhha1RLSHFaUDB3bkVrbXF2ZTB4WHI1amVNRU4vbUFCV3BkYWJGSzYrYm9I?=
 =?utf-8?B?QlBiUFVBN2VKTGFpQU9CckprNGFTUWNQZjBuZHdlMmVjdFBhdkhyNkhQMmhU?=
 =?utf-8?B?T2NLNEt6YXQvOEgyU3ZCV1h0WGh5aW91andIeUJSYUpHdW5UdG4vd1c3U0Vu?=
 =?utf-8?B?MFJuTWtzUHEwb2R4RldMcDRpQmppUE9sVnpVdW8xVGtORDEyeVlEMCs3ZEFt?=
 =?utf-8?B?TUpmc0liYUk2RHRUUE9NQUhwR293R1ZuVm1YY3p2SXBRV2hxcGxkTUtGNzVs?=
 =?utf-8?B?TU9XZDNYSFkwTy9QS2l3c3Evdm9sV3BFVW5hN0JHaFlxMExUelJFWlVtTTlD?=
 =?utf-8?B?RHRFM3VycWFJZisrSzFpSUJ5LzhOSTloQ1EreGtoeHFYZGNSb29mdmg3Z0tz?=
 =?utf-8?B?MDh2a3pCQVo3blBIbVZvUHVreDljM0NTQlBSc2UwWEt5d0FvYjBYZXNabHpM?=
 =?utf-8?B?NjhiWEVBSHByREtPV2lmci84eHJkOExMWVBBZUU0TXRlTXQ1R1pnUFdGdTNz?=
 =?utf-8?Q?9j7shLkN09Voydp9BDZ7R6m1fbDof8xfZ/qZeG8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b4d655-0ae7-4c2b-543e-08dc3194b40f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 21:49:52.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5993

On 2/20/2024 5:37 AM, Krzysztof Kozlowski wrote:
> On 19/02/2024 22:35, Yang Xiwen wrote:
>> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>>> list due to prior driver change.
>>>>
>>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>>> compatible lists.
>>>>
>>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>> ---
>>>>    .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>>    .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>>    2 files changed, 95 insertions(+), 71 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>> new file mode 100644
>>>> index 000000000000..1b57e0396209
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>> @@ -0,0 +1,95 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>>> +
>>>> +maintainers:
>>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - hisilicon,hi3798cv200-usb2-phy
>>>> +          - hisilicon,hi3798mv100-usb2-phy
>>>> +      - const: hisilicon,inno-usb2-phy
>>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>>> hisilicon,inno-usb2-phy are not compatible.
>> Ah, i didn't pay too much attention to that. I should remove the entry
>> for hisilicon,inno-usb2-phy in the driver. Sorry for that.
> We don't talk here about driver, although I used the driver as proof or
> argument, because I don't have access to hardware datasheet (and no
> intention to look there).
>
> What I claim is these are not compatible, so respond to this argument,
> not some other one.

Why not? Of course they are compatible. All 3 SoCs are using 
inno-usb2-phy. The only difference here is the method to access the 
registers. They are all enabled by `writing BIT(2) to address 0x6`. In 
the cover letter, I said the driver is actually doing things wrong. 
Especially the commit adding PHY_TYPE enums, the name is confusing and 
conveys the wrong info. It's not PHY which are not compatible, it's the 
bus. I'll fix the driver, but still the PHY hardwares are compatible 
between these 3 SoCs.

I'll say the driver is broken from the beginning. They should move 
write_reg function to a separate regmap driver and only left `write 
BIT(2) to addr 0x6` to the PHY driver.

>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


