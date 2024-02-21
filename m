Return-Path: <linux-kernel+bounces-74499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A3085D52C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B3F1C219AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869E3E468;
	Wed, 21 Feb 2024 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LVYmtML0"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2028.outbound.protection.outlook.com [40.92.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1723D577;
	Wed, 21 Feb 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509955; cv=fail; b=H0MvSBzleVAu6CIy3i6wnEYrP7IrT9MFA3Js6s87P3OaaRGYWl7h1e9On1pYb5kXa2TC7TVy51zsiWVQRsVGXHR8Tk6mdTOt2NET/nsv5wlsJ3/QXjI/QAbfh45uMd7s0z14v9e2jaFhKZIYvL0KQcVMmbTSBwVnK1Uh+kg5Mzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509955; c=relaxed/simple;
	bh=Xoa/R3pZuZXYgZmZw8yyit5H1UjVGO4OHPs5nQ6FOgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DRhBbhgMszMlqPo9z0sgMu8Ei9TYmLC5rjYjy4yuh0qsWj9gAGnv3DAchGRWjcQN94gPAGBk38TV8mjS2mGjdshviAcR2dY06HKZO0tHrVXBb2e301B1At0FcL+BBPqePkUNSHs0eQ8oUBW/RzUzcw/0fAO8MzkramWvD5Aqio0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LVYmtML0; arc=fail smtp.client-ip=40.92.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OARFz76S94VYmjCozkM1Dni2F2cICLAoUOzbHXIEZqDQtvsqnkrTTxUiJOeZyH2qNUp/vxhCXImZawij9+0y471MyzpmTDE8Lc809MsbqDP0eLTvGyXckc8SRoZdQeHwwOq7myzy/dSyFT2bABXQdekugaGGnjw9VSir1+T8nwK80L1zFuK3VzXH/6xpsdKhKYLz5USi8wL6+KgqAlKwTjjmDtndwb4XxP2yLbG0qJOx7IDxfs7OIwMEAb6FxcmLHBDLpjalqKkJqGs4IePQfgHdAQgfBYlFuW5H2iwIerh+iy9rCQs2OldhMnolIYFZMbtZko+mQjORCc8LkET9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym69Ug17c4D9APJ1jIJrcmqwo6ZhlpbNTL1VHp/ozsk=;
 b=AMjRdMlmCP8jEidc5qSBX9Pfc1xXTwhucLoHXMo6S2oBOsHO3zvmr7PEQQf/Tn5Upk+ESy1lSAXE6mBzH9i6UIfUbEbLXqt1ZkjLoqkr3X31adA0LjA7Lz+G3SjhAb58ASwrmL45WFcSNY5GVkcYZhOoqBPYJs+iiGDmTRnxDRQwIhP2N7Dw3h6zmeB54NbtEDOtTFq+ePB44MGgzdknDn6bQ4hJDwbK3peOjqmSHMk7RSYYQ0ln0xg5uGGk9Bh+ea2kYn0RZmMkF7Zl0fVqxqL7xknVdd6aDPLR7xqhHl3wXNtg61CkWGR66R4+8LwCYUd5Vl73APXT9U83Q1gVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym69Ug17c4D9APJ1jIJrcmqwo6ZhlpbNTL1VHp/ozsk=;
 b=LVYmtML0PyGd4CMkYUc8TZdr01HmRWfyeD+fDjZ5YKb/OLSbJaNGBSN/MdZ7jAg3XDTVJFTwpasAnNBquezlMACDhOlyCiErkuhoChBitY4NSPp9x7K0tdpT6oHE4UaPJdPSbPELtmp3J2gkTnQhy17knFtLbeXhTJpOYHYu2X71Jl5MHY171CQYdFHD8m5aV2wIMbCbFQ0XnEgr1SR2+29GhNMmIxlnRsD55CYAnELrZ6fafg8HhCSliewuJElKJf5L0qD4cARGxMpQDvJopQlydJNyJ4FQQlc1dN7xMVjsu1oEjMt5HSvxCI48ZmtolAS9L0foPssVtQGJQiPHRg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6153.apcprd06.prod.outlook.com (2603:1096:101:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 10:05:47 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 10:05:46 +0000
Message-ID:
 <SEZPR06MB69598321E39AEF0FF9738FB396572@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 21 Feb 2024 18:05:39 +0800
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
 <SEZPR06MB69592FACB1EF1B9FEDA89E5996512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <9a5e9363-79eb-416c-89ae-c826062350b5@linaro.org>
 <SEZPR06MB69594A5036F122CE6C14043C96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <bf4ce87a-51ab-49e1-ac70-c463d8008a62@linaro.org>
 <b4fe5565-9378-4786-8c55-113f9088f34a@linaro.org>
 <SEZPR06MB695943CE42B3A91A22E70DD696502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <94730d0a-0e5a-4777-aadc-4748038a3ca8@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <94730d0a-0e5a-4777-aadc-4748038a3ca8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [9SUTcQn2hOAQrZnEu1OWtHhX1eEEbEKtOO01OIjwgPMwSdbq0zHKpLAySTMdvfuM]
X-ClientProxiedBy: TY2PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:404:a::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <ee3a2ef5-4770-428f-9639-bdf335a6777f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: d718f22f-74e0-4d73-dcd7-08dc32c4ac51
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VSB42e6xF23cllTF3sih3cz7QhFbUPtyQgA7OwofnpijpOIwLhQ2aaDq5TWPZqKEgrU7QIw5AhpbGQDckJiKp08AAlUrHGrRlg2e5lsaMrQM2vYtvS+FgvYDPsadvSFBZpZSiXwbpfSbijHqndCSS8B5Vl60CmJU5wVat4jcSHc6HloHSJPi3GA/USuwAbGg3wyCn5ClqvkWwEFgFSoqqeWgaXu8v/6pWy5bPNmwM28t9h1p25CoszjSzC/w6MrhD++9O/STRjfdlgf5hh8FQy4oXXmPZKsTgENR2aKPp8RLNyNekCqsH+IL0ytllRjd7QSFkIqwB7ZtcZzuCBUGSLJNeohqcslEb5u9Uz/fU96gFNrek7RkjK4nEW7Gb+oTOEfhCzPIGuVzxZLWSwrmVOWuOwVc5T79Grsp3zjtUYG0eiH/ls0uQouFziaCRRjOUWHS6XHkBaFanZMz0QlSx13XJGAoeyBry1R9PS0t5ItNkkYGavtoaEHQVODva8AFbcDNDleconmAokxNTADu13bHetbtpVxsRDJ+OUSQRRJUFYq/bK1SYe6bvJY8WHwnM9XpRn3aJL1m4wYYg9We4mCgjmEChpAfqxuGEWJ63nI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTE5RjMrYWtFSzk4MUN5TWROQTd6eFpTTDNFcm0zU3VMdFZPUy9Pb3cxK3lu?=
 =?utf-8?B?TmN6cENCM3pSSyt6ZWF4Q2FTT3JNUTZaZWVJaG80QjlKcVhJeWZFUE9KVm1Q?=
 =?utf-8?B?K2s3dFVkZHprV2FRb1QzMkQvM1dzS2ZUTWNid3BvSmZmemJCK2ZCSGszdHIz?=
 =?utf-8?B?aWo4bjlQMWRPWHRtdUlFZ2grWFlvWjVWcUUwY05UU2U2SjZFN2pVY2oydGVU?=
 =?utf-8?B?Y0FRMVFtTk9WbkxIRHZucGVqQWhXTzlHSGM1ZnVYeEg0NXhSblVjL3grbWhP?=
 =?utf-8?B?SzcvZys1d2VXMElSMVlRSFJTbVVTdXVOVWVLUFlDSlBPMS82c0oraTA4cElW?=
 =?utf-8?B?ZmRTNldUU0QrRlRHcmV6VitQbWxlbE0zSk9CeTRaZ01aZ3RNU3czaXBFb000?=
 =?utf-8?B?Um1Ldk44aDc2OXRnQnRYVjhPd25RM0dWdnJ5K1BxOTl6MzgwWHFpVDRhK3NQ?=
 =?utf-8?B?OGpya1l3L25rS25DRUJlVDlQRVNOU1VJRFp3SGZMK1Mvdk1la0ZvemRZanpC?=
 =?utf-8?B?Zlo0VHVpNzA1WGFnejVrdzRXdTQxOXQvaU54c0wxbE4zNVdIcnMxSWhjNHdR?=
 =?utf-8?B?NDVCTDNVL0RXUWtub01ZWUdaVmZPeS9zbW54RUdJTTUxOUJqRDBUdHA5ZVd3?=
 =?utf-8?B?d3Qxejl4Wmgrd1ZTbkEzZ1ZXV0pSd2cyb0xWV2Z0MUFucFkweWZqRUwzZnQ5?=
 =?utf-8?B?czBuRnM2NTF4RHBkakF4aG8rUTl5S0QwbVl3TndtWER1R01hTzRoMXdzU3lN?=
 =?utf-8?B?VG40b1VYUlEzY3JZaFRNMkFmSi9ldkd3dmV1YzJqd3FTRURUSXdzVDNJMXdY?=
 =?utf-8?B?VmNEYTg2c0tZNDZyeTlWZ3pUZE1JRFdMQk1pWnkwWUNMNW9CQ29vMC95eVNl?=
 =?utf-8?B?NGwxYTJrNFdPd3l0L21sVTE5dStQWlpHckZyN1RCNnV6VlV6cit2eVRkS3ZD?=
 =?utf-8?B?ZEJTWXY2YUJrYm5uQzh5NHlUM09kMU1NbVhaQWFqbHVJaXFZTWJxNlRzaGx5?=
 =?utf-8?B?YnBFc0E5N1hEc2U2TDA0N2ZRSnpOdkpIYm9FM2ZzYnl2S1N0WjZMSEcxRjFP?=
 =?utf-8?B?TWdKdWFpNGFNNlFvdEc5SnRsY0RzS3E3ekVwZHkxS3RDaWRHWGxxNHFCYzBx?=
 =?utf-8?B?RW85K3ZSVVFGZWs5ZUh4YTVWZDNDUkJvdGE1SFdPTlQrL3JoRWJJWWM4VVd1?=
 =?utf-8?B?bTZlQzNwY0k4a0RPVmJ1VlVpWG5SUjFiRWpKV2JjRUQvckdHV2xHODhCSndy?=
 =?utf-8?B?T3hSMi9CNjQwL2FMd0JLQTZBM0o5MjVHM2lmNlpDdmt0QVhNak8wWUxLdjc3?=
 =?utf-8?B?L0s1R1Z6YzVoVEpSUEtPQ3VLLzNDZlR0RmhPRUVza09JTXQzQ3d3cVp5UnBM?=
 =?utf-8?B?SHBGYXlxQUtHbi9QTlRiWGJBb05vM2U2M21OV2ZTQlFBZmFXbTdlZGlkN3hm?=
 =?utf-8?B?TWFiRnVvZFZCQU1xbEJaVm5YWnZSWFdFR05QeWQzV20xRExIVHltVTJlTWFZ?=
 =?utf-8?B?U2JzZE04MktvbWRDQkNyMHVZWWpDZnR5WW1DSTFabllJQjg2RDdZYlhzZTdh?=
 =?utf-8?B?RnU2dXVmRi9mMit2ZWk1bUlxWFdCV041R3NwT0YxN1NnSkdITEZNOUo0NTJU?=
 =?utf-8?B?Zk5aWVN1U3NueHR6SnltNEN1dlduYjc1dEozNjMzYmszeXdKQ3RiaklQb24y?=
 =?utf-8?B?WEFaa0NNTjdybmllNlladng5N0xnc0oyUG1qSm0zaEFpaUxETTZoT3VkVWFw?=
 =?utf-8?Q?l7mJD+NGFd+ZEF5J0ncG2ws6C7P0iiQZ6r9l2AJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d718f22f-74e0-4d73-dcd7-08dc32c4ac51
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 10:05:46.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6153

On 2/21/2024 4:22 PM, Krzysztof Kozlowski wrote:
> On 20/02/2024 13:12, Yang Xiwen wrote:
>> On 2/20/2024 7:43 PM, Krzysztof Kozlowski wrote:
>>> On 20/02/2024 12:41, Krzysztof Kozlowski wrote:
>>>> On 20/02/2024 11:40, Yang Xiwen wrote:
>>>>> On 2/20/2024 4:16 PM, Krzysztof Kozlowski wrote:
>>>>>> On 19/02/2024 22:49, Yang Xiwen wrote:
>>>>>>> On 2/20/2024 5:37 AM, Krzysztof Kozlowski wrote:
>>>>>>>> On 19/02/2024 22:35, Yang Xiwen wrote:
>>>>>>>>> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>>>>>>>>>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>>>>>>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>>>>
>>>>>>>>>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>>>>>>>>>> list due to prior driver change.
>>>>>>>>>>>
>>>>>>>>>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>>>>>>>>>> compatible lists.
>>>>>>>>>>>
>>>>>>>>>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>>>>>>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>>>>>>>>>       .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>>>>>>>>>       2 files changed, 95 insertions(+), 71 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>>>>>> new file mode 100644
>>>>>>>>>>> index 000000000000..1b57e0396209
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>>>>>> @@ -0,0 +1,95 @@
>>>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>>>>> +%YAML 1.2
>>>>>>>>>>> +---
>>>>>>>>>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>>>> +
>>>>>>>>>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>>>>>>>>>> +
>>>>>>>>>>> +maintainers:
>>>>>>>>>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>>>> +
>>>>>>>>>>> +properties:
>>>>>>>>>>> +  compatible:
>>>>>>>>>>> +    items:
>>>>>>>>>>> +      - enum:
>>>>>>>>>>> +          - hisilicon,hi3798cv200-usb2-phy
>>>>>>>>>>> +          - hisilicon,hi3798mv100-usb2-phy
>>>>>>>>>>> +      - const: hisilicon,inno-usb2-phy
>>>>>>>>>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>>>>>>>>>> hisilicon,inno-usb2-phy are not compatible.
>>>>>>>>> Ah, i didn't pay too much attention to that. I should remove the entry
>>>>>>>>> for hisilicon,inno-usb2-phy in the driver. Sorry for that.
>>>>>>>> We don't talk here about driver, although I used the driver as proof or
>>>>>>>> argument, because I don't have access to hardware datasheet (and no
>>>>>>>> intention to look there).
>>>>>>>>
>>>>>>>> What I claim is these are not compatible, so respond to this argument,
>>>>>>>> not some other one.
>>>>>>> Why not? Of course they are compatible. All 3 SoCs are using
>>>>>> Why? Because...
>>>>>>
>>>>>>> inno-usb2-phy. The only difference here is the method to access the
>>>>>> ... here! Different programming interface means not compatible.
>>>>>>
>>>>>> Please provide instead any argument that they are compatible, in the
>>>>>> meaning of Devicetree of course. You are claiming inno-usb2-phy  can be
>>>>>> used for hi3798mv100 and it will work fine?
>>>>>>
>>>>>>> registers. They are all enabled by `writing BIT(2) to address 0x6`. In
>>>>>>> the cover letter, I said the driver is actually doing things wrong.
>>>>>> Cover letter does not matter, I don't even read them. Your commits matter.
>>>>>>
>>>>>>> Especially the commit adding PHY_TYPE enums, the name is confusing and
>>>>>>> conveys the wrong info. It's not PHY which are not compatible, it's the
>>>>>>> bus. I'll fix the driver, but still the PHY hardwares are compatible
>>>>>>> between these 3 SoCs.
>>>>>> Provide any argument.
>>>>> Just take a look at the driver. hisi_inno_phy_write_reg() is the
>>>>> function that differs between different models. But for all of them,
>>>>> hisi_inno_phy_setup() is the same.
>>>>>
>>>>>
>>>>> hisi_inno_phy_write_reg() should be moved to a separate bus driver. It's
>>>>> bus-related, not phy. PHY driver should not care how to access the bus,
>>>> So drivers are compatible or hardware? We talk about hardware, not
>>>> drivers...
>>>>
>>>>> but the bus driver should. The PHY driver only needs to use regmap_*
>>>>> APIs to "write BIT(2) to addr 6".
>>>> Different programming interface, so not compatible.
>>> Although maybe I jumped to conclusions too fast. Do you claim that all
>>> registers are the same? All the values, offsets, fields and masks?
>>
>> I don't quite understand. I've said there are two register spaces. One
>> is the bus to access the PHY (i.e. perictrl for mv100 and cv200 and mmio
>> for mv200), the other is the PHY register space. So if you are talking
>> about the prior one, then no, because the PHY is attached to different
>> buses. But for the latter, yes.
> I am talking about the register address space which the binding document.
>
>>
>> So here we are talking about two devices. One is the PHY, the other is
>> the bus the phy attached to.
>>
>>
>> The old binding is mixing all the things up because INNO PHY is the only
>> device attached to the dedicated bus implemented by perictrl. But it's
>> not how it works. The binding is for the PHY, not for the bus.
>>
>>
>> For mv100 and cv200, it's: cpu->perictrl->inno-phy. For mv200, it's:
>> cpu->inno-phy. cpu always accesses peripherals with MMIO, both for
>> perictrl and mv200-inno-phy. But if the inno-phy is attached to
>> perictrl. CPU must access the registers of inno-phy through
>> perictrl(Here perictrl act as a bus driver like a I2C/SPI controller).
>> For mv100 and cv200, the difference here is only related to to perictrl,
>> not the PHY itself. For mv200, perictrl does not implement this strange
>> bus anymore, instead the phy is attached to system bus directly.
> Your driver writes different values depending on the device. For one
> model it writes PHY0_TEST_WREN+PHY0_TEST_RST+PHY0_TEST_CLK. For the
> second PHY1-versions of above.
>
> The PHY0_TEST_CLK is written to the "reg", so I understand that to the
> device address space.


All these stuff belongs to the bus interface, not the PHY. PHY0_TEST_CLK 
belongs to perictrl bus interface, no the phy. It's not in device 
register space.


clocks and resets are resources to the PHY actually. Here the driver 
does not model it correctly. About WREN, it's only related to the bus, 
not the PHY.


>
> If you write two different values to the same register, devices are not
> compatible usually.
>
>>
>> I don't understand why you say they are not compatible, simply because
>> they are attached to different buses. For x86, peripherals are mapped in
> I did not say that. I said that according to quick look in the driver
> and to your explanations you had different programming models and
> interfaces, which means devices are not compatible.
>
>> dedicated IO address spaces with `IN` and `OUT`, while for ARM, they are
>> all attached to MMIO buses like APB/AHB/AXI etc.. So peripherals for x86
>> and peripherals for arm are also not compatible?
> Depends. You did not answer to my question whether you even understand
> what is "compatible", so I assume you don't. Compatible means
> programming models are the same or one is subset of another, so
> effectively both devices work with the same compatible and everything is
> fine.
>
> Answer yes or not:
> Can PHY1 type of device, so hisilicon,hi3798mv100, bind using
> hisilicon,hi3798mv100-usb2-phy compatible and operate correctly, so you
> remove hisilicon,hi3798mv100-usb2-phy from the driver and device
> operates correctly?


No, with this driver. Because it mixes bus interface and PHY. With 
hisilicon,inno-usb2-phy compatible only, it's unable to know the bus 
type (i.e. it doesn't know how to write to PHY registers).


But it's the driver which is currently broken, not the binding. The 
correct fix would be extracting hisi_inno_phy_write_reg to a separate 
driver, so this driver only needs to `write BIT(2) to addr 6` which is 
done in hisi_inno_phy_setup().


You must have seen PHYn_TEST_CLK and PHYn_TEST_RST. They are the 
resources of the PHY, so they should be modeled as clocks and reset 
controls resources for the PHY. That's why i say the driver is terribly 
tricky currently.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


