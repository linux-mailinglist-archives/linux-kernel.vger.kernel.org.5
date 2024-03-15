Return-Path: <linux-kernel+bounces-103956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3894087C703
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF78282057
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C98BEE;
	Fri, 15 Mar 2024 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="d8xESCj1"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450679C1;
	Fri, 15 Mar 2024 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465376; cv=fail; b=MPdrhT4KN19ZAjFD2vOq+vxscbOPLCmZBJR4IOEvfpsinIf4O+EuYbT2m/I4rgP+Wl4s/ZH7SlNTbMb4v/lb0+3D5i0aRu3qhlCdej+E7uxuSqJW0CfOC7U+pCWfFi6YwK1pfq963GWzMhNT5nESkFuyXDqGNg3YKv1tfCNmhco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465376; c=relaxed/simple;
	bh=BJDlzc79WcZlcvAnrFoyk+NumXOSy5YYtcbOKqu4CSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/1mjm4K0M2kayuXrdYvkfKzI0cIbR+UnF7z6do/9IhUZhUqiv8Hedai14H8NgmajttNertAXnjsuN7uvrLgSLhDpVRJlpzEX/7rbfTmyh1F/E39mpBKYx4IdjMGFz+o84iGPu8lENk2g/v+BrODzoFkFGUsUDZHneoyOXl90UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=d8xESCj1; arc=fail smtp.client-ip=40.107.255.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSBf0PLWV37V4YypMxHzair5MFMaLok0alMrh1cIxgfO/oUc/OOsJRjZbbXvMwg3VuHQ+hmgD5Mr7B4DW/Ya54MnmeYZ/uXp9ovGUwM5uCMcPEJVK7/w1SaIbVt8H1aDsko8a0mCRTQIpwVd4uQ4jdeXJdtUzOYHuV7uN3vWsBKFzCAEcExgKuXJIm/hn90y4C6I3SCGAskh4Tt6+e1cLUDk/1Vs/yhB3bGNTpXyy8NmkL8R2MSAL1VLouUfDYIfYhzAE1dc1Hn4TvIee1pYp8dounYby/lxMTCKuCLjwTxzo/KIqiiLfCsJLw7n0L04gWnjS/uLyafh6/FPvEP/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akZ3bMfMKXwfz972QDgrEK58fdC1JgjCxxAt2YVw8Ek=;
 b=PY4VKadluXo3jvnjphaqBT7rCi7kN4Ge0yU0RLi1ooPaOIw7Dy6T2/pn1SJ7dPyLOTP2GyoM79z5SK3QUMoCRj5n0UX8ctfvIATxwqhA3ojxr+cd+OT1bgENQxPnQvaoJwpTIYUeQM6t2nJBVq/RTfRVlwpid+X3xf/DfZcKzxks76RmJ1Y+jq3DApoPFsfSG14prZYiYHSAUnJS18+Ji8YBdHKmt6x5uQKGmYtIJzx6/IkRqIUgNp5AdVbJHdGQ0X7lDg1uGMBR9B/YoJYKCVDdSprLcYyFZeXuQ5X3JiIcbz/12Sd3b6p1/1nccLcjr2NGvSuso3RpQTgdzBLxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akZ3bMfMKXwfz972QDgrEK58fdC1JgjCxxAt2YVw8Ek=;
 b=d8xESCj1yPiTdS5woUYKGofksHVqpOdCM71xrez1e7MZgW99ZJs70o81F9BflEayGfgw8QT2j0vUmt7bg7oWaTh8CKNM6g5UYnwUeiHFIILpn9M/phEaPLuCaaEM+wtGEdqlNWTL+XeTGgKVHaaIkTYkJsYmDms7O+I2+OmPkdGrI4AtmPrczLpNpyyf3qgbWc9cgPvXjTVu/t/GnJ/SiRcyeIPYD2iI5VTmehx+QV05MjOhzgf3GAam19zEEFbtn5jlkAnUXP90cxSoI49oKK66O5JclRTPOc3EBAhB5d3rbYIz6xr1EtySEDIcDw+RVOGgE+sWHT01qlkb4BX1vg==
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI2PR03MB6712.apcprd03.prod.outlook.com (2603:1096:4:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 01:16:09 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b%4]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 01:16:09 +0000
Message-ID: <f9c380bf-05c4-4a24-9d42-5ad24b181e66@amlogic.com>
Date: Fri, 15 Mar 2024 09:16:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH 3/4] arm64: dts: add support for
 A4 based Amlogic BA400
Content-Language: en-US
To: neil.armstrong@linaro.org, Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <20240313095311.dxrr7gvt4t3gwoho@CAB-WSD-L081021>
 <74f96887-572d-47eb-bce4-9d61ec51b88d@amlogic.com>
 <024b8567-af4c-4522-9b9d-594c42930442@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <024b8567-af4c-4522-9b9d-594c42930442@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI2PR03MB6712:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qeSKD8itlxWKNwYcrgDe99ggnMcDUY56+qnuWH9FEXVTq+VCuymnSrp5wmTf1r8TfIGxfhPrkAOUjUk6pfZ7QrgbYkQjHYQkxQsEdPyaWkRZH1iVVJ3ewxFZ8I/zbsTxTr1eQXjbTA+8mabqvymcCK6L6qN+AHf/E5PM+2Spw/CqxRtncX8VUbSK4gEdavrtkpXnut3Ro1HswzcWaCE7ekOvnGE7IwRmtDgNV9EBpAQx4TClM/Ly3pccDwTkIwJUNCn4KmOrGm+IGWSRWIW4IVAKa5/5XVGxLzx02ZRvABwxHnyhLiljFrJl+Dc6fIWjeDRoXuf7GeOJQdJTpGuuRtWTipNfY4XuiOV9RZjmT1FTvaumboFP0VFp8Nk1mz2qp+0U/HHA8U6OSC5onVY8vqSmJQ+g8403v7mIFLv2O31qr7CqdcspQC1ucEKZgdkePkOSyFKmtCKAXiODvDJRgnKT0RaDOzPPgjVyNV7wXYlxo29EA3p9ULl1PaLe4MF28IEIzlodWDowZvxIOobE4UyyvFNBWuLQ3dIqr5sPOxTIxIOTo3SBr9VA067EsrXyqWeK2c+7/3gIozUQ3RrrmUqBYHxKgEvPV3Z7FvRxL0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjRhT3pHeEdlSnhDQ1c5VmNVQWR1YklSNG00eTZnR0poUnVDRG5TS0krdXBh?=
 =?utf-8?B?dnZaQVRabGJyY3RwK2x1VU1PWHcxMHg0dGU3ajlKV3d1Z3JTKzFRbVVUOHlw?=
 =?utf-8?B?RGs3MEZOS1RkL3lHZkZmOEkxMFJzN1pyU1lhVHRLMzhhRkVUTVY2WS95enow?=
 =?utf-8?B?dzkvUm1EMGUxZkRLUmRXcHJsSEhkM2QxTnEwdS8zdWtXUmY5b0hDZ2MxOU9R?=
 =?utf-8?B?UUdIbHAvRktrK3ZINk0wbTRMcE03NVFUeDNDdFNsTVhhR1dOTkRVcFRLTzJj?=
 =?utf-8?B?R1NLZFMwamdiWTJEYjkyNXoxVG4wcXZqK3N3WGtNRFhld090QjRZYWRJSUZz?=
 =?utf-8?B?UXpPVE5PT25sUmNjZ0VBZEt0VnU1MHk5YlM3emg2dTN1SkZpQittMVlKY3lI?=
 =?utf-8?B?VEY1OGJlM21BWXdFY2txL0g2R3FUQ1ovU1hzajdZWUNOQ3ZmMnNlTnlPLzB0?=
 =?utf-8?B?MThSNjVLSHoxcGUrK0lUeTY5S2FNNkt1TGJobzFhQWF5UDhtZ29RTEljWXlK?=
 =?utf-8?B?SThvUW8wVjlVNkRGWUFJSmtEaG5DVHg0R1VDcHZXYmJtUi9mR1dPNnVRYWg1?=
 =?utf-8?B?MWx4b3FkMCtCY2lDblF2VEZkcXVKSkNpVEdPcU1LUlBlb1NPb040bE9Fbjlk?=
 =?utf-8?B?NFo0T2JuSjdTaDlLSFYrbzlubGxwQ1FYd0lSMU14TGwwc2EzSU0xNEdhTU9V?=
 =?utf-8?B?QzJEOW12YzkrelVoNjEzcGZhQzNEd0RUem01OE9hSm1XUVJiZWcwZDBSRGlq?=
 =?utf-8?B?L0c2VjR1eFB5bDFISlpieEVlYXoxU0kva2RFdTN6TFZCZzIrMXVUTndLcE4x?=
 =?utf-8?B?MGhCU3h6SnhpQ2xuMmVLTmNqTjcyYTZYYWZhOERaWlFYU3g4TUtQM1VvSjZ5?=
 =?utf-8?B?aFFKS1hmQ0VaRDBGRXYwWlVUaUFlNlRBMVlSWTBvYWJtZ2ErWDNxTmxRL2hV?=
 =?utf-8?B?L3lHcGo3NVJqOERTMXJubm1tWjdZWVJHR2JJdnNRclk0d1NuOEdNV0x2bWZt?=
 =?utf-8?B?ZGVSQWZmRXp4ckd1STNaU0lleFI2bURRcDJlWnA2OU5lYUEvQk4vMk1vL1p1?=
 =?utf-8?B?QUx4T2FHUXNOVWJ5REd6R3E5NFNuaXU5YXBqeGdhaW54NUhoYXFWTlRYY3k4?=
 =?utf-8?B?VEtaNGJ1M01NRFdRLzFsWWgxVWJDWEtZbmhXVm53cXYrQXFxalVjK1B0SFY1?=
 =?utf-8?B?SkdhUzB3Y0tDNndsNm4xWTZSaVh4ZjBVRzZpK0g3a1FobVgvMzE4S1lsdHRK?=
 =?utf-8?B?UXVoNGVtLzNEWHBjd0h4TkZrWDc4NjRjaXhqZ3VpRWt0eGRrdHllZUpiUy9s?=
 =?utf-8?B?c1hrRnE1SW14UzVWU0hQM0NGT1EwNXd6YjBIUXBUZ0NURVpxMWQ3dGVBZ1Jm?=
 =?utf-8?B?Ry8vZ3V2UW5zNWFqcndEdmJ0RC91ZG82VnJXWm5XTEZKUks3bmNidEhCWW94?=
 =?utf-8?B?MUdVV3Z5VVAzd2hVellYdkhpdExLRmo0Z0lmaTVtZms4VHQyZHBkSUVkRFF1?=
 =?utf-8?B?dHk5U0RUZGNNV3JtajVSbnpERGo1UEJrMEtJLzd5emFCN0lPMnl5Z2c2bElq?=
 =?utf-8?B?Q0xIc2Z1NjMySFNVQi82aWVWZEwvWU50U0RGeDR3QzliczJtdGZDZEtZRzdQ?=
 =?utf-8?B?Z01mTmNUL2FXSXVSM09NcUhTNHVxUlZ4SDdrQjhhQWswMEdqMENOcWs3djQw?=
 =?utf-8?B?TmpXMHdWQXFZZm54cFY3VzNzWW1oUUhSajJHNkwwblRvUDFVZEQ1YjZKZGVD?=
 =?utf-8?B?NFh1bmJiWU9HR3VhWWZoUmxRNklWTTlZQ2tXYnJnMkZINXdGaWdVNm5BZWI1?=
 =?utf-8?B?bnV5QW1CT0txZVRiUmtreXEvZWFlUm9iNUxnSE5uVzlJNzZKQnFqKzBzK1hh?=
 =?utf-8?B?dzdZYnVjSFFzYjByYnRodFB5OW43VFI3Uk04WHQ5blZNcnhWb0NzcTBvOXNl?=
 =?utf-8?B?Qzdpa05nYTh2bmsvbWpHQUZodldGNTc5aW91Z1d3VUJPL3BhT0ZmaEpXZ1pW?=
 =?utf-8?B?L1J5RklFR2p3Z0cwR0VQSEk4d2pKUlZoQUx0TXdjMDJuc0thMExEWWpEZVp5?=
 =?utf-8?B?VkVYU1lseEZ3UzZXZFZkWmNsMlRQVjh3NWUyWk4ydHhPenI3d2d3bHhKVUVV?=
 =?utf-8?B?RjlnTzdpZ0VVL3AzQVZFaFA5dTA5RkRpK3RZNUxmS3o0eDhWVFJ0N3krWDJ1?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec79e54f-e4ec-4d5e-bbf9-08dc448d7eda
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 01:16:09.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQRJfz8P0vZa76hPCNdmOpbRHnLO+EKjCoRTWa9RiLu8j8pGjb0TjzHQk/h/vehKNm22UeP/vk+CF04kGdhk9dtFMM883EHqhImaJcJ9Rzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6712

Hi Neil,
   Thanks for your review.

On 2024/3/14 17:04, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> On 14/03/2024 06:19, Xianwei Zhao wrote:
>> Hi Dmitry,
>>     Thanks for your review.
>>
>> On 2024/3/13 17:53, Dmitry Rokosov wrote:
>>> [????????? ddrokosov@salutedevices.com ????????? 
>>> https://aka.ms/LearnAboutSenderIdentification?????????????]
>>>
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hello Xianwei,
>>>
>>> On Tue, Mar 12, 2024 at 05:18:59PM +0800, Xianwei Zhao via B4 Relay 
>>> wrote:
>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>
>>>> Amlogic A4 is an application processor designed for smart audio
>>>> and IoT applications.
>>>>
>>>> Add basic support for the A4 based Amlogic BA400 board, which describes
>>>> the following components: CPU, GIC, IRQ, Timer and UART.
>>>> These are capable of booting up into the serial console.
>>>>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> ---
>>>>   arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>>>>   .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   | 43 ++++++++++
>>>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 99 
>>>> ++++++++++++++++++++++
>>>>   3 files changed, 143 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile 
>>>> b/arch/arm64/boot/dts/amlogic/Makefile
>>>> index 1ab160bf928a..9a50ec11bb8d 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>>> @@ -1,4 +1,5 @@
>>>>   # SPDX-License-Identifier: GPL-2.0
>>>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
>>>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>>>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>>>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts 
>>>> b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
>>>> new file mode 100644
>>>> index 000000000000..60f9f23858c6
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
>>>> @@ -0,0 +1,43 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "amlogic-a4.dtsi"
>>>> +
>>>> +/ {
>>>> +     model = "Amlogic A113L2 ba400 Development Board";
>>>> +     compatible = "amlogic,ba400","amlogic,a4";
>>>> +     interrupt-parent = <&gic>;
>>>> +     #address-cells = <2>;
>>>> +     #size-cells = <2>;
>>>> +
>>>> +     aliases {
>>>> +             serial0 = &uart_b;
>>>> +     };
>>>> +
>>>> +     memory@0 {
>>>> +             device_type = "memory";
>>>> +             reg = <0x0 0x0 0x0 0x40000000>;
>>>> +     };
>>>> +
>>>> +     reserved-memory {
>>>> +             #address-cells = <2>;
>>>> +             #size-cells = <2>;
>>>> +             ranges;
>>>> +
>>>> +             /* 52 MiB reserved for ARM Trusted Firmware */
>>>> +             secmon_reserved:linux,secmon {
>>>> +                     compatible = "shared-dma-pool";
>>>> +                     no-map;
>>>> +                     alignment = <0x0 0x400000>;
>>>> +                     reg = <0x0 0x05000000 0x0 0x3400000>;
>>>> +             };
>>>> +     };
>>>> +};
>>>> +
>>>> +&uart_b {
>>>> +     status = "okay";
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi 
>>>> b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>>> new file mode 100644
>>>> index 000000000000..7e8745010b52
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>>> @@ -0,0 +1,99 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +/ {
>>>> +     cpus {
>>>> +             #address-cells = <2>;
>>>> +             #size-cells = <0>;
>>>> +
>>>> +             cpu0: cpu@0 {
>>>> +                     device_type = "cpu";
>>>> +                     compatible = "arm,cortex-a53";
>>>> +                     reg = <0x0 0x0>;
>>>> +                     enable-method = "psci";
>>>> +             };
>>>> +
>>>> +             cpu1: cpu@1 {
>>>> +                     device_type = "cpu";
>>>> +                     compatible = "arm,cortex-a53";
>>>> +                     reg = <0x0 0x1>;
>>>> +                     enable-method = "psci";
>>>> +             };
>>>> +
>>>> +             cpu2: cpu@2 {
>>>> +                     device_type = "cpu";
>>>> +                     compatible = "arm,cortex-a53";
>>>> +                     reg = <0x0 0x2>;
>>>> +                     enable-method = "psci";
>>>> +             };
>>>> +
>>>> +             cpu3: cpu@3 {
>>>> +                     device_type = "cpu";
>>>> +                     compatible = "arm,cortex-a53";
>>>> +                     reg = <0x0 0x3>;
>>>> +                     enable-method = "psci";
>>>> +             };
>>>> +     };
>>>> +
>>>> +     timer {
>>>> +             compatible = "arm,armv8-timer";
>>>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | 
>>>> IRQ_TYPE_LEVEL_LOW)>,
>>>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | 
>>>> IRQ_TYPE_LEVEL_LOW)>,
>>>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | 
>>>> IRQ_TYPE_LEVEL_LOW)>,
>>>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | 
>>>> IRQ_TYPE_LEVEL_LOW)>;
>>>> +     };
>>>> +
>>>> +     psci {
>>>> +             compatible = "arm,psci-0.2";
>>>> +             method = "smc";
>>>> +     };
>>>> +
>>>> +     xtal: xtal-clk {
>>>> +             compatible = "fixed-clock";
>>>> +             clock-frequency = <24000000>;
>>>> +             clock-output-names = "xtal";
>>>> +             #clock-cells = <0>;
>>>> +     };
>>>> +
>>>> +     soc {
>>>> +             compatible = "simple-bus";
>>>> +             #address-cells = <2>;
>>>> +             #size-cells = <2>;
>>>> +             ranges;
>>>> +
>>>> +             gic: interrupt-controller@fff01000 {
>>>> +                     compatible = "arm,gic-400";
>>>> +                     #interrupt-cells = <3>;
>>>> +                     #address-cells = <0>;
>>>> +                     interrupt-controller;
>>>> +                     reg = <0x0 0xfff01000 0 0x1000>,
>>>> +                           <0x0 0xfff02000 0 0x2000>,
>>>> +                           <0x0 0xfff04000 0 0x2000>,
>>>> +                           <0x0 0xfff06000 0 0x2000>;
>>>> +                     interrupts = <GIC_PPI 9 
>>>> (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>>> +             };
>>>> +
>>>> +             apb@fe000000 {
>>>> +                     compatible = "simple-bus";
>>>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>>>> +                     #address-cells = <2>;
>>>> +                     #size-cells = <2>;
>>>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>>> +
>>>> +                     uart_b: serial@7a000 {
>>>> +                             compatible = "amlogic,meson-s4-uart",
>>>
>>> If I'm not wrong, you need to create dt-binding alias for meson-a4-uart
>>> and use it as 3rd compatible string.
> 
> Please add an A4 and A5 compatible using amlogic,meson-s4-uart as fallback,
> and drop the ao-uart since there's no more AO uart.
> 
> Follow how it was done for the T7 in 
> Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> 
> The amlogic,meson-s4-uart will provide an earlycon like ao-uart did.
> 
Will do.
> Thanks,
> Neil
> 
>>>
>> On UART module, A4 and A5 SoCs exactly the same as S4. There's no 
>> difference.
>>>> +                                          "amlogic,meson-ao-uart";
>>>> +                             reg = <0x0 0x7a000 0x0 0x18>;
>>>> +                             interrupts = <GIC_SPI 169 
>>>> IRQ_TYPE_EDGE_RISING>;
>>>> +                             clocks = <&xtal>, <&xtal>, <&xtal>;
>>>> +                             clock-names = "xtal", "pclk", "baud";
>>>> +                             status = "disabled";
>>>> +                     };
>>>> +             };
>>>> +     };
>>>> +};
>>>>
>>>> -- 
>>>> 2.37.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-amlogic mailing list
>>>> linux-amlogic@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>>
>>> -- 
>>> Thank you,
>>> Dmitry
> 

