Return-Path: <linux-kernel+bounces-34998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACF0838A53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DBF28D6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23459B62;
	Tue, 23 Jan 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f0ixeBDq"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2029.outbound.protection.outlook.com [40.92.103.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8759B4C;
	Tue, 23 Jan 2024 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002113; cv=fail; b=dNOBGStF+ihKFlnsKuXQj7BlCAkrFsJxgdbdKFcoOZhoRkrteZpRlw+V5KmuZ/spOeos4hLczQsaOvLNVCDh3CmD8mLqyL6GMf7MQR554qh9XMGcZZw4uPo4E6N5iKTwM41+uceqDH3Dg86vDUUYCs/KzWZV1AUD1WlMLInldc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002113; c=relaxed/simple;
	bh=1e2yjJIWbwMZUYZelrSZdy7kTu8t95DtY3ja1XUlzRM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F+lO+MS+Y7yH4+ds1jnBVlHImBkdGrYDm/YML59jMz5D9sa9GzoIZh2D/RlikR4AxOK/M1BvNQWc5G3YwP+j7LZ+9EmuD/GnQj6eNN/hAB71hZiY7+foasuOaP91de9hrWyZEkX4YBeQzHSL2rdX3SQJkyqX/5RzOh+mxQCNPz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f0ixeBDq; arc=fail smtp.client-ip=40.92.103.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kis/VqqsCbl9kOiaxLY98Fyux7B20OhGXPr/TgNwIFGWAF7EYca4CtrPKkHqPRfX0meLIRWsK/2CiMuMKFZcjKkuMwKbnWiZ2Iq7oUrjnDyq6rlg8g5wHRQrk4cPc4dXirGBrso0HKpNTndg2zAL36jMYHqZNbSkrfiTHeFrRdhTp6e/O2L2me4FSy+vMHlU0jNxt1Jzxn1QXtRMJNi6PTpEEwq+b5c3cyueLhFJHUW/a9uck+MWHSlhll1ML1xYHL3HaOSCem/LUSUpUlwemO/e2vrtoGHZnspcSN077tjw9w+PwF6xsVN2MqXdaMI0lJlKCWklc7gPXQdntu5UCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sskf7J1wJrl8s9RWAxDv40gnUGq/qBKKChNHBefGDi4=;
 b=bLJH1Wsf5bbuyBauPe2alRnplpCgs4nH7XdI6L8b/BNUU6QnpGlOc3wmjuhNHdNATObdwxTmMx+H9cLC6BBdpavVikj2N3jHXLzCeyOSnlACGoPl9RIC+EIlX05i+JyvuRmYNsewRl2d1KwPMz7/wiDngfvyrGuUhDUQvVezqrb2ZsY/ecVlf9lFk/5YoP9YVkXEMhwwDmJVjXAUL1IpoKNr5Rau0KhbAcNNO6qV3+141Y9aVgKCVhm7BQsqUhbeETiiSRXgWpKP9r5TCZmH/Uwb2vBIIyX9vcKp6C1YKrGgjiqFDCRUoSb0H3eJ8K5yZtmxdQarJsiqjot3F1M0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sskf7J1wJrl8s9RWAxDv40gnUGq/qBKKChNHBefGDi4=;
 b=f0ixeBDq5o6IjWO7j3fb/0swcoCjp/sImxhkAn3rHWfcxG6Sr4F7fcynlNEX8VXzkW8PeymbtAvBkkq6Q7I8km9+X/pAlQl8dICKIWpaHa8Ej0iNUGYjlqgl5faAqY7tnaEMMwb/ST6Yazsem5ESAEh6eDwpAzA4a6wo122gJCEFIJFJ0i1GVpaDlzvx8GNl6xQpWJJwODe60OrXXqsxw2baculrpJ9e8COJfWXF0GSt4/wXEkDsrUHV41zLLEf26pKCiznu4L0mLxwcPOxgfSU5XdJSuzjFu21vx/j5DzyLD+1Y+A5tE4IUixFrSRP6v8Dw0oaX7xhvoU3MDvpKDQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1255.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 09:28:22 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:28:22 +0000
Message-ID:
 <MA0P287MB2822627E67437D41C098F773FE742@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 23 Jan 2024 17:28:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: sophgo: Add Sophgo system
 control module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1705388518.git.unicorn_wang@outlook.com>
 <598b1026fdf9989bc48e5e10d1034b37947d3b80.1705388518.git.unicorn_wang@outlook.com>
 <f4a46311-2e12-458b-98a8-d3caa2c95517@linaro.org>
 <MA0P287MB282232DC6DF6290F5520BA89FE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB2822FBA18674540BA85035BDFE712@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <c9feb32f-1efb-4613-94c9-9d6bb0f45366@linaro.org>
 <MA0P287MB2822BCB4E43BCB495FCF9069FE752@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <7d87c455-7af5-4339-9088-6015d5847e88@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <7d87c455-7af5-4339-9088-6015d5847e88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [lxQOcf9RsahtWSokDqigeECIXkhAVyEK]
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <e5e58868-4c1d-4854-a938-c7bf1ba1d804@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1255:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c75517-b387-4f58-d3d2-08dc1bf5a4a7
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQBsYli3jUPtFvQ+dLrwPNuFuG67EiBC9oSGB7j60xxyOFGTIT7fETNwCGN4sr9X7g7WHLWHwQC1HY3jhuz9sp/knflewH8Z17LHqHWB7+D2OQd8OrLZCah4cJmFy3/ebXhDfK76ZHYPzQGpfhte4DilyfLgrpDYdarFsfAU/TBQdGUvCGTjQRTD3lY3w5+sh0bj0GNyAUUYd9VHkN61iPc6nj8/cX9wkBqh/FkRDJlXTJ9NHm8npvfr505FhOxESuhuuZQOASw7ttmhX/Lr8dOSURD8tsHwrSvQjxtZ2RP7lRi6t5xzqO49z4cni3FIo+GNDO7DL2pG2SUfkqs61pCCnmZ4RVpeGuWe4YKfmsSkdYt5sBKZhboVeW8NMrx+qxi3xG1J0c0KFYb2UHKKJHjWcWQSpBqo/i1o356c5il/WeQdV58qU6NyOeZ2ZRli1NDh1k6lPX66aLfb89bIw+VwBOA46ymD7b3y3YDfS+QPDSo0ltg4p8UOMUqP2eFe5jUivFr2cdIbgmWAZskz+kf4QZOBtSjYq0Gy33ZkKrvAoqTqlplrfUFg2xtgyHk6ucMAfC8AlVoCV4VeT+/Bw3McVypoHD2C5YX6W6xcX9n8kLD9L5l8iqOIJzm1KWGfV2KwJvNPRAbod/NIY4vAs6Sz1K0NjcS6Yw98RQkX2/wYw5KRCLS9PVMPB5xOHaMlqbFgAlXs33pynNFK62badyH4n+o2roVlbxgLzcIZHi1+q3lQ37cDrqSP9bwXVMFr6mCKxkWR8RtELuYx7D0qITypNCjcAFUxOVOQx5/5Sk9Mz8zMPDJ6+c8W
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W0KlYfetY9sVrIj9YtHVm3Kkli78U67+jovzIFX0SfKEtCmoz5BTZw2+sNIeyMA/E4yFodJZD/zpOuHIoIf+wvrUWpKNXpFlZEZ+HatdmccDDsz8pt5zJQxM2vk1MauZttcnmuld0Xb7X2G5qVyl1SlWBSgnd8cptN2uU+zW2rvNud1RcIwGe2UqVMNL0DyOWlfexgusxWBf9f3Xe0TsblF74BgkzB/SlS1SuSRKN73QLV0ZvPhFvKB54V0f58vbOaYdMbhZfb44Z51okyrubnJPa1BwfLgqbQn0aDtikNGIFrGHXMBlcdIJQXQyQ/4MYkLR+HNGfZS/5RJlPpre5hS9R12w4gseY5WmkF9fFrPtsC9YTX697qAGF3sTxOHPKh/4a5Q9UfMdaKXlVKSEKVJt7HyFDermgqzEiBRXtf24FaNas04C76jSxsL4qLN2UELNcVRHyHCdXhM7MgJE3EfES2yomfyZymkAabHYqxGXiCcwU4dVJ5TLQUtyhaiNpcKS4YPY68pDEXtsDNCrVvi9qtC5qsntGbVCjya139RyM3Fgp8KkLq4a2uTitTWyXIKg/0sExA1pFSYkuhhGJ9CEbkMH/w6Q9vDuor+zwdk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cllhS1h2c2Nsd3ZJV2pZK2ZNU0VPbHZFZnFxOEVMejJUNFZjRnFmNGIxNlVV?=
 =?utf-8?B?TVNQK3RFVkF4a1lzV0xLMG1wVXFMUFNnTXR0Qm5NOHQyQURxenppdTZEelZo?=
 =?utf-8?B?MGtYcHdzQnVjUEhhZHRITGpjcVdZK1pRdU9aL1ZwdHh2VXRkRFRXV1JWWk1X?=
 =?utf-8?B?Und2ZFhTSlJCK1JaKy9QUU9SYUVDeVBuVVJRMit0bXBrdlc3ZnBJRGV1YVhh?=
 =?utf-8?B?MEJGbnlhU25pcEt6YXQvV0VpTFBPVlgvSllRUmw1YTNjU3JSdE90d1ovTm1a?=
 =?utf-8?B?eHZYV1dHbTFBSHBJcU16UEp5NmJzVlV5eVlPbldBWUltSkk4VTNFVlJmSlJk?=
 =?utf-8?B?dWdkc0s3U2RiUjBhd25BUS9ybHI2SlVtVS96UFBCT09sdU85M09jMEZyUkF6?=
 =?utf-8?B?OUM2Vzd4TXA3b0FMZEtoVFF4eFdNZ2ZSVC9MUGJFV3V3aUo2RnF4WWtkZUxF?=
 =?utf-8?B?TkdoaVN4QWlyK3AzOFVBY2NpOUVLNXZkdnlCZmphV0luY0xWeVprMU8rN3Bh?=
 =?utf-8?B?UWoxWlVzUWVaK2twSVkrTWtncHVDb1I2NWdyc1dZQkxhQW52Y1czd2FRZlFn?=
 =?utf-8?B?ZGhSZ2tiUG5weUVOSjZTOWJZNEhDVS9XWmZuRXJyZ3JndWxtWEhsS3pGMG81?=
 =?utf-8?B?blFnWkFENU1oZ2pKMmxFbjBSL3FjVnBaOGZzZWVSZ09YN1VoN1A0OGQvYm9o?=
 =?utf-8?B?TU14V1liWjVOdjhUOFlCS3BxRVlwekxZRmprQzMySUhtdVcrRzF5MjA2aWhl?=
 =?utf-8?B?cjUzTEZXdVlPQTNiNzhVU29KSEx4T2d1bmdFcE5tenJ2SHZEaFNuVDJLWVBI?=
 =?utf-8?B?QmpWUkpZdW5BUG82WVBZRTJxZDczOTFqYUE0VlBCRk5RVnEzVjZVOXk0K0Vs?=
 =?utf-8?B?b0h4OTUwV2tyVE9ic1NVNE5FZnZTNS9qWHVyMXVuc2hyM3M2VlF2MVVsazRw?=
 =?utf-8?B?cXp5c0U2ckE4MThjREZRUDhLQldvZWhaOUVBMThkWFBNVXFtbUxDMGxJMVRw?=
 =?utf-8?B?eE9uV0VGWWhOekZoc3BNT2FJWmJFTVdZYVlyYzJEM3JnaytObExGTVZTM09s?=
 =?utf-8?B?RHRMclE3MnRrcTErVnlNaTMwN05tVjB1L3Y0dFpmME9nQjdSRDNaSjlhM2hX?=
 =?utf-8?B?a2NxVjVPbWVFcUk0NWVvWVcyTm8yc2dHNnVheHV2WG1SdkZaNitFMEVoWjRj?=
 =?utf-8?B?ZFVmNC82NTFUaFNWQ2xYTXV0UE91a0Z1NUhOVElUWFVTdTRva3Bwd1pjQmR0?=
 =?utf-8?B?NHVtZlpkZlRMN0JCZXhLcWw0UWpYOUpJUWtXK0xqM0ZQSEdVaUJIb2dCNGpO?=
 =?utf-8?B?dnNoS1hmamZhbm1ZaXpWTkxXMVpMNzBzSnJKbDR4RStLNFJ4Q205L3A1MHJK?=
 =?utf-8?B?UGs5ZlBIZStqNmN6THlLamh6ZjZ5WjF2OUVwOWY1SXRrTTBmUElHT3BqbnlK?=
 =?utf-8?B?WW14dkxIb1E1NzJuQW5PWXEwVHFYd3ErZTJWZ1BYU1RPcG1XWUh6dTQ1aDdn?=
 =?utf-8?B?QmZFL2t2Z1JPRWVxaXV4aWtRNlJHd3FJTlRHckpNaWlxWE5EQWFuVUxoeThh?=
 =?utf-8?B?K2tMYXdIYWp2bW9EeDhFWVRLb090MUNOdlllK0VnckwrVXVZK2J4M0t2Q2dG?=
 =?utf-8?Q?iTjGJrcoJY/yPIW+FeJpnpdZeW0Y+AeojN+VOsxaq/eg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c75517-b387-4f58-d3d2-08dc1bf5a4a7
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:28:22.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1255


On 2024/1/22 20:56, Krzysztof Kozlowski wrote:
> On 22/01/2024 11:11, Chen Wang wrote:
>>>>>>> +    $ref: /schemas/clock/sophgo,sg2042-sysclk.yaml#
>>>>>>> +    type: object
>>>>>> Why isn't this merged here? You do not need the child node really...
>>>>>> unless the clock inputs are specific to that clock controller and you
>>>>>> will have here more devices? But where are they in such case?
>>>>> I don't see more devices will be included later. It should be ok to
>>>>> merge them into one.
>>>> hi, Krzysztof,
>>>>
>>>> After some double check, I find we will have more devices in
>>>> system-control. For example, in the SYS_CTRL area, there is also a
>>>> section of registers used to control the "General Purpose Interrupt".
>>>> The pcie controller of sg2042 will use this interrupt controller which
>>>> is defined in SYS_CTRL, we will add it in later work.
>>>>
>>> I expect then all devices to be documented.
>> hi, Krzysztof.
>>
>> First, I'm very sorry for having double-checked with you for this system
>> controller and child node issue, but this time I'm sure there should be
>> no more child nodes except the clock and interrupt controllers, though
>> there are some other registers in SYS_CTRL section, but we will not use
>> them till now.
>>
>> One question, when you say "to be documented", do you mean I need write
>> binding/yaml files for other child node? But they exceed the scope of
>> this patchset (this patchset is for clock support only). That's why I
> That's not true. The scope of this patch is to add DT binding
> description for your device. If you choose any other scope, I don't
> agree and I am not going to provide positive review.
>
>> suggest just add clock-controller in this patchset and to add the
>> interrupt controller in another patchset for pcie support. This
>> mechanism should be suitable for our expansion.
> How then are you going to solve the requirement: "DO attempt to make
> bindings complete even"?
>
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L17
Learned and I will try to make bindings for system-controller device 
complete, thanks.
>
> Best regards,
> Krzysztof
>

