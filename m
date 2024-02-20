Return-Path: <linux-kernel+bounces-72988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FFF85BB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152BA282A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E167C7D;
	Tue, 20 Feb 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MTYgmKfG"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2092.outbound.protection.outlook.com [40.92.53.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F36773B;
	Tue, 20 Feb 2024 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431145; cv=fail; b=pELaS88XAZgY7KD5lJ0kAoSSBMwxYWE4fwPwF5EIvYpJKfMxfTvn87uU+lJQt0no9SlV84U6gHjSYa3IobwaJCFHpFR8lU0vnzirXGE8Lj7Y5WsMm8yPDQ8LEdDZ/llHvCOwCJdZ7EiVElQ1prc3C1xVMhoefx+IiEsXa/XIizo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431145; c=relaxed/simple;
	bh=J17sqi3yPDmwl8dHk/UFxrEaWT+aoq4XlVvPgkCiIOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DEQkIkFfKVkj2C9VKeQoRfxoh7hfHg4NdtcZ4EjxpcHVDxVXzbKBeWHtjT8za53CSBPydnseCojav5L2+iLz1PaHGAx6B698rc/SgCH2ogsMBcwvBHiSdsqfyuEfjtg1n9Izy2q41t2rZBBVxywmOsQuA0Fga339A9ulCYItuNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MTYgmKfG; arc=fail smtp.client-ip=40.92.53.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvEFFiKLM4chmRtewW+LwaKMOu7GpRpGcYxEDYO3ztxD5xXQw57jS1qTbK039BHDGI9azSgtzKP7iLebv5EEUmHoBuIzKuRHaI3Af9jtXNeZh7cRl0VpZ4IBw5BtnAbIs5aY0Yq49cdJmFLwJbTDY2SvbVlllBA4NnN5cRch5bq9x+gogPrdKBuXei9kXB3HnYcx6GQnSGAskVBlZHo3Yy2vYxAfecunfd5ZJ+2Cqq65PnmoF4DYwUrCJHnDL2q0e7P0+msHnFwhEuIPdAVje68BF+c6YrYntPaHIV3DgqZ8/D63xX2i6Ue5PXDDZrZLiI274syFdv6udApu1lwApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raQHX+0L+uuBWbE2hxUpIYXCXEe1Ni2adMOQbhLH4O4=;
 b=A+uQeS+yMcsL6cR7BfaQY6IxgsC5sanX4kze7gF6KkZ1Su1pIxefEm19sem1KIxiOWZqxfGq4NT+/Y7i553E9yv1u2agBrhfP3OWDScaDBXSg3LK8aWgLpurjt1Sv2PMbBvu4OEP+IH1hG4DY5iZwNXmaCWt5bl9WxWOMOwPNtgBx/e7KQl8Z13bJccNI7SuhioEKlWTxMXYWqTW+xHIdHB37QyLt+tpqzQiwkOZeEnlljHBYVj4SvZx7ZQRfMmMgyQwBTOFlzZf5EUh0Ytf9TfOhaQi87qh5qyv4o9buSPypuguHCYQLKgK5m6eHrCGZwYyNplSK8sOKzCQUruhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raQHX+0L+uuBWbE2hxUpIYXCXEe1Ni2adMOQbhLH4O4=;
 b=MTYgmKfGET/RRJ125qisdL2laJ864Jf9iwjFGAucU/Aa1f8O3IKWSvzoKyJ7wUpZ/7GGVaT4vfsri/YDNfQvQUlLg4CfKCGhEbg4fotpax8nN4xlzSFpDFwF3fxHav+ELjjgts8IO2fldvG9B4f86x0DHp7IWqY0FcW+t2aWre1Y7N5+FWa25M1s27qFOSBEOGWWC7rJ/fiOtDnrWI7sz8Wi34Z9H6DkSkNRNLVtiHbQpo/MiaBJ0mTHxLUsWpJ0FwSAna2ZItqfBXaBWYhCPgACUz9zn+0ozs5XZMRRrpmvG4saxXSlv96WZYlYnMUWma8EuJ82mpUjB2cl9LHWQQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB5515.apcprd06.prod.outlook.com (2603:1096:101:b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 12:12:16 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 12:12:15 +0000
Message-ID:
 <SEZPR06MB695943CE42B3A91A22E70DD696502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 20:12:11 +0800
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
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <b4fe5565-9378-4786-8c55-113f9088f34a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [e7BEmipHcWRwVWlIux54ASXYdDNVfLsLVvPQVdlsCEny46cM+tTOS0JyxfSRSucS]
X-ClientProxiedBy: TYCP286CA0236.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::12) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <a78a161f-7c45-489c-a1dc-c1f915f55c0c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 474c2ea8-a576-4478-418b-08dc320d2d62
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TCsHoZUK6ztrUwcSS2ES/S4GcAdp1ApKBVIekKPBV6g39vSDo45ptle1U2Cp38f+mbEQ4r/WrT5KGqaaQV5Gxi7C9y8vaXW8qxC46DnCkKoyLHlWr3SuPqLRAUYHMF9lnAq+A9TFTgll9dVdiTtlFiVDdyyuGOoZKcOTSMR0Fs42Mdyxn5rPVYBeft+lFBdIp2FNLpuGf2Lxgzy6lRPnGtX33kgb5AoIM/6WQYeGTZ8jf0pYtzR4FunBAvl8OG9mfGdMq/043FqEBwj35k5pjLgS51349N2Osd4uhYIWH3XotihTwhnr7JUORg2y2TQGA9UbezvOHTuWATXDzvHAjcR7AzLsngGv1PYFK2r2es/B4QOgz1f94CfEj8Cfu3aVue1yLSJ4C9TT2H1NvAfZVglgSurgtfG+yGpTliYhtOiR5EgGduWVa9r/VoqngPAys8crLizzs7f3QUzy8svbrVtSnb2DKbyyf7lDx5WIemr3u3Cv/a8pAeXasd+iDRfLH+ghv73Zu9/UCjZt7HrZ4/PGhglUJlMozbUYZXeWAZA+qQ0fR++32134iVohwqNw/FOIufyU9hSEvGgjP7mGnWZ2eDvf0B11qFJejsBQCHA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1ZNcDhGN1VEd0I4K21JUkpwQ3FGbjNWYUZuUnNGY3E0UXBxSjE1ZHRUMG9t?=
 =?utf-8?B?VnBreEZydTRtWnJSRjNJVnN5U3FWYjNITWpvYUtXKys1WlpDMDE3cHBOVUQ5?=
 =?utf-8?B?YjRscXZXcFdGVTBVNXFBMFNnUmZMOWRuYTFvYXh4bkxhN2dieTc3VFM4NmRO?=
 =?utf-8?B?N0N3NUhYdlc1bC9JUkVCYk5hU2I5Q0dmenU5azJHVFRyQUwzT1dpZ1JjdnIx?=
 =?utf-8?B?cFRUUlVLVHRqSlNKWlN6eEd2UVFGWENxOWhWM1I5cE4vbUtCOXNCUTFQYmU3?=
 =?utf-8?B?ZWdnS01BbE44TXdlTnFUNFBLSDFKMzI4RDVUT094VkpUVHJQbDc4VjJKS3FC?=
 =?utf-8?B?UjVrZXdNWUlZR3AxVW9YMVE3OGxOZ1psUktMV2p3d1JBSG9RSzZGbU1TaW0z?=
 =?utf-8?B?OGpVUFllSUdwZjc2MXdpTkJZeU5Rbi9MUkQ4NThtdVA2bVNnWitoS2NjdTNw?=
 =?utf-8?B?UCtiMEZ1VDE1dWVEV2ZCYVRDRnVYaXg0d1dOUXNkU2QyWnZpOUhDSlFxcm01?=
 =?utf-8?B?Q1hDaEwxVzJJUTBpVnFiMlBEUDVRVGthODVjQXNmdFJtdGxhM1lDVk9sTGhy?=
 =?utf-8?B?enVhR1YwZ1IvdmJmYnhsQTh5OGtobU14WjBwZnd2dms5WmpWMUZhWjZINnJR?=
 =?utf-8?B?U1VQcnhTS0pIOUFqN1k4Y0ZJcTh5M1RBWC9wUlJ3aFYyeGg5a0NQZ0ZjaG8r?=
 =?utf-8?B?S1grWHN3Vnp4MlQ4cHNWWU1ScEZHb2xnWnlSQjFaZlF0QmlEanNVTnBSa1R2?=
 =?utf-8?B?NXlDRkxDQnRBelNDTlJXbjVOS2Y4OVFSMWU5MDBHSDltMTd3SXVlTk13b1JC?=
 =?utf-8?B?Q1FjaSt4cFp3ZENxRXo3SElUdFZFbUl4V0NqTlBPZHJPOGI3aksvSU5udmth?=
 =?utf-8?B?WmdzNGlKdklTYk9YTnZ1dTdFVU80MXFuQVoraFMya0R3TjR3djB6UjdWWnZm?=
 =?utf-8?B?dkFNMXZkRk4vZm9CQVJ2VHlXaVRKSTVydHhCaUJvdmMyQ3ZXSTJra1c3WDll?=
 =?utf-8?B?NWUyUjYwWXZFSVBXTi9RTWc5SzZueXBRV0pmcEtvT3RGVVVnZyt4ZkptNWlv?=
 =?utf-8?B?ZFcreUJjQllyVm1yYU5FY1kyOWloL0I5UVIzOUxXdW93ZGJaN3h0bWNhTmN4?=
 =?utf-8?B?TVdwSktFZ2hYMFNoZU9nTXIzT2lyUWRUS3BKdlQ1YUVaVkNZVVNvNlJ5L0Q5?=
 =?utf-8?B?bWgrR2xMVjdhMnVZMytCcDA5aTE1V1Rzcm1OM0JRQUVvU05BOVRWejl3UGhh?=
 =?utf-8?B?WGwrMTNjbmMydzdYcTUyR2ZUQnM5TGlhNXBtdGxsK0wrbVZlRzBySFF5SjZE?=
 =?utf-8?B?aS9kQTljVE9SdUtlZzhYdXpDaHF6NEIxUHNmanozcnIyWkNqREl1TnNUTlZs?=
 =?utf-8?B?cDBaSVVMRVJXRm8yYXRBaXlVTHRvNTNSK0x4RG1LT3lJSjNZaXhmUHhiZkUy?=
 =?utf-8?B?dG5VMW9ma1hiM2dEaEpCV0FTV3JBVXUra2VZM2RSa3pobVVwb1BuYVNUaFBo?=
 =?utf-8?B?TlZIZW9NQXdnU1VRUWxBNG1UOTlKMXlwbFZWWXNrZGVwSElmbE83T3A1c0t6?=
 =?utf-8?B?S2ZYVk4xOEs3VmVzUzZRaUxjaGxuOUkva1J4QmYvdzBVQlBOTjl6bEJUUTRn?=
 =?utf-8?B?Q0JYK0ZwNnQ3eHdRNEJsOTdmT2gwVk4wWjB4L1Y5bG1aUE12a2FHOTBzRURz?=
 =?utf-8?B?NzRMK2FNREJsT3ZEZlJPRm40UFhKMWJuckppL09XdFkrcHozNGFiTDRaR3Fr?=
 =?utf-8?Q?0Dgo1m2RQu1xdYQTeTNRUfwcAMKwZQGPw/O4vPc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474c2ea8-a576-4478-418b-08dc320d2d62
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 12:12:15.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5515

On 2/20/2024 7:43 PM, Krzysztof Kozlowski wrote:
> On 20/02/2024 12:41, Krzysztof Kozlowski wrote:
>> On 20/02/2024 11:40, Yang Xiwen wrote:
>>> On 2/20/2024 4:16 PM, Krzysztof Kozlowski wrote:
>>>> On 19/02/2024 22:49, Yang Xiwen wrote:
>>>>> On 2/20/2024 5:37 AM, Krzysztof Kozlowski wrote:
>>>>>> On 19/02/2024 22:35, Yang Xiwen wrote:
>>>>>>> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>>>>>>>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>>>>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>>
>>>>>>>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>>>>>>>> list due to prior driver change.
>>>>>>>>>
>>>>>>>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>>>>>>>> compatible lists.
>>>>>>>>>
>>>>>>>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>>>>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>> ---
>>>>>>>>>      .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>>>>>>>      .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>>>>>>>      2 files changed, 95 insertions(+), 71 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..1b57e0396209
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>>>> @@ -0,0 +1,95 @@
>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>>> +%YAML 1.2
>>>>>>>>> +---
>>>>>>>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>> +
>>>>>>>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>>>>>>>> +
>>>>>>>>> +maintainers:
>>>>>>>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>> +
>>>>>>>>> +properties:
>>>>>>>>> +  compatible:
>>>>>>>>> +    items:
>>>>>>>>> +      - enum:
>>>>>>>>> +          - hisilicon,hi3798cv200-usb2-phy
>>>>>>>>> +          - hisilicon,hi3798mv100-usb2-phy
>>>>>>>>> +      - const: hisilicon,inno-usb2-phy
>>>>>>>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>>>>>>>> hisilicon,inno-usb2-phy are not compatible.
>>>>>>> Ah, i didn't pay too much attention to that. I should remove the entry
>>>>>>> for hisilicon,inno-usb2-phy in the driver. Sorry for that.
>>>>>> We don't talk here about driver, although I used the driver as proof or
>>>>>> argument, because I don't have access to hardware datasheet (and no
>>>>>> intention to look there).
>>>>>>
>>>>>> What I claim is these are not compatible, so respond to this argument,
>>>>>> not some other one.
>>>>> Why not? Of course they are compatible. All 3 SoCs are using
>>>> Why? Because...
>>>>
>>>>> inno-usb2-phy. The only difference here is the method to access the
>>>> ... here! Different programming interface means not compatible.
>>>>
>>>> Please provide instead any argument that they are compatible, in the
>>>> meaning of Devicetree of course. You are claiming inno-usb2-phy  can be
>>>> used for hi3798mv100 and it will work fine?
>>>>
>>>>> registers. They are all enabled by `writing BIT(2) to address 0x6`. In
>>>>> the cover letter, I said the driver is actually doing things wrong.
>>>> Cover letter does not matter, I don't even read them. Your commits matter.
>>>>
>>>>> Especially the commit adding PHY_TYPE enums, the name is confusing and
>>>>> conveys the wrong info. It's not PHY which are not compatible, it's the
>>>>> bus. I'll fix the driver, but still the PHY hardwares are compatible
>>>>> between these 3 SoCs.
>>>> Provide any argument.
>>> Just take a look at the driver. hisi_inno_phy_write_reg() is the
>>> function that differs between different models. But for all of them,
>>> hisi_inno_phy_setup() is the same.
>>>
>>>
>>> hisi_inno_phy_write_reg() should be moved to a separate bus driver. It's
>>> bus-related, not phy. PHY driver should not care how to access the bus,
>> So drivers are compatible or hardware? We talk about hardware, not
>> drivers...
>>
>>> but the bus driver should. The PHY driver only needs to use regmap_*
>>> APIs to "write BIT(2) to addr 6".
>> Different programming interface, so not compatible.
> Although maybe I jumped to conclusions too fast. Do you claim that all
> registers are the same? All the values, offsets, fields and masks?


I don't quite understand. I've said there are two register spaces. One 
is the bus to access the PHY (i.e. perictrl for mv100 and cv200 and mmio 
for mv200), the other is the PHY register space. So if you are talking 
about the prior one, then no, because the PHY is attached to different 
buses. But for the latter, yes.


So here we are talking about two devices. One is the PHY, the other is 
the bus the phy attached to.


The old binding is mixing all the things up because INNO PHY is the only 
device attached to the dedicated bus implemented by perictrl. But it's 
not how it works. The binding is for the PHY, not for the bus.


For mv100 and cv200, it's: cpu->perictrl->inno-phy. For mv200, it's: 
cpu->inno-phy. cpu always accesses peripherals with MMIO, both for 
perictrl and mv200-inno-phy. But if the inno-phy is attached to 
perictrl. CPU must access the registers of inno-phy through 
perictrl(Here perictrl act as a bus driver like a I2C/SPI controller).  
For mv100 and cv200, the difference here is only related to to perictrl, 
not the PHY itself. For mv200, perictrl does not implement this strange 
bus anymore, instead the phy is attached to system bus directly.


I don't understand why you say they are not compatible, simply because 
they are attached to different buses. For x86, peripherals are mapped in 
dedicated IO address spaces with `IN` and `OUT`, while for ARM, they are 
all attached to MMIO buses like APB/AHB/AXI etc.. So peripherals for x86 
and peripherals for arm are also not compatible?


The binding now is still broken. I admit it's true.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


