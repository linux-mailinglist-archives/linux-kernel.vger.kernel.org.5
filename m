Return-Path: <linux-kernel+bounces-32307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 424E98359D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB66CB238F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BED1C32;
	Mon, 22 Jan 2024 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NCgHwQLY"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2031.outbound.protection.outlook.com [40.92.103.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302AD17FF;
	Mon, 22 Jan 2024 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894910; cv=fail; b=nbLo0yhUapxIUAugIPL4eGt2KQohJWN1QEZLZjXRmJBnmXCjSPtmdMtQ9g6f8j5zGTS0fJc8jZegBzKuVbREohag5lefJkjg0vbAgKdqeJ6k1bly/yFnhqvnNrarLzawsCwef+py6cFQIC7xSAOg/Efm2ypUzweLe787WPpAmbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894910; c=relaxed/simple;
	bh=Widu4rwSI5rZhNufaZfAUl+LeZcEZZxn4Wf0laLQwx4=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1V6GZIcXwkDKnK5TuyeaPfFBHR4yhJC4mb/L5W778G/ZK4JqacVimGaoQ82Q0StNg4Estu5pTqVquyKD+L1zI4iKqja+5MsssqzBpMyJHewYevui7R2L02vPtPRH9eIlrlC6OVU01xgh3NrMpf/i3IFNN9lZ5mj3y6qa2A+dnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NCgHwQLY; arc=fail smtp.client-ip=40.92.103.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsJbhUCAYadbPfgiRz/8FIKtFUHkjHI2AtNSR8j/nJbQTBFRYfKIG6GTPDX+wQh3k+Iwaf+Bte4qfI4Bn6Xv2sHoiwGez6ytdFNeaY/QNB+3qSvjfxkVrNhbWZzWwQ144RqP0hgh+QURhxeIiEqAeq1StAjZPB3BkET15D5zWnYr3A6dpvrRBGk3sGHe0fqomCYsQ4YkRfZRgRM/O+2LF/Wqn8F+w7eFfkp41GgF7ChUdLi2CkNxmMLDZe+obq6go7j+jyYrRrbAzxkUleObVfc7CrajxwbDqwSnc/tfPbK5bfm1vSX1TAsiGYEQxoZ5/UZo1Sr1LbXQiy/cQsWh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDyp1LG0RquqpZwnX8RcW2qxfzZBPEbclsvmofzKBCM=;
 b=OFt9IfgybjpOTPsufSZgChvGimId6jH1pcjFcKb8tdMvWtrWVngWlrZ6eiBFylat99Qc4z0wx2HdLUj+q+/O7EfcyIscbsP0Cbq8zEaafhG9z3JcodLF2nq/J6UwFnU54x/+X3DgVEnRHo8gR5RcBXXd+gGJYvicK0mK99/G4POloFIqkqFEHjvi0P8SaS3XptZu86IUAzr8HL3CcHNjj7A+PlGjyyDIS9HX74aHP/aG4I4Ss00U4RZkbY7vjDFsinHPYannGLO6ea6gtmb2TcqI8wVo5RhFBeDimUUV8xYvhYl0uG6DXHxCQcWDI9kYPSi9mC8NRKGLdIv3MRAchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDyp1LG0RquqpZwnX8RcW2qxfzZBPEbclsvmofzKBCM=;
 b=NCgHwQLYEwH0mhvolGKlVzKvBa9ItuY3RYPKcDsYtjeFWFXkHYy/pc3u6IlVFppWNdh93d6BNJtQV3RatKjC1EmKKtATLRLR09VD5hMo4oU3AbqGeSsWiQX2e9FR2ALzPqUL3BT+pymF1wGacQlUFCA6I0r/Yka/2b1LRHghF9jrIdqvgRQU3EPzgQZUkCYsr5efMfTtuA5/NlrJJeBm6L+rrwpmBQ9Y6MFOnV4JMllyoDdYfuArPKJe7blM+6uq5HLqok3F/OHiqIsfGFXUsXu4bq8YvXsi+perEDOvqs/ycqcAel8lY7SHId9J0bAGyBZEfM5HUvwc1Khhp0CSkA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1618.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 03:41:39 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 03:41:39 +0000
Message-ID:
 <MA0P287MB28225C6758E08536CC495B48FE752@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 22 Jan 2024 11:41:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: sophgo: Add Sophgo system
 control module
From: Chen Wang <unicorn_wang@outlook.com>
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
In-Reply-To: <MA0P287MB2822FBA18674540BA85035BDFE712@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [uBWA1LTfOhipSzRK1PxfBW8Bye851o3L]
X-ClientProxiedBy: SL2P216CA0148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <ad1d8d85-770d-4541-88a1-770864164eb9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d60b22d-8026-4752-2020-08dc1afc0936
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f1XtjZ8A202dczqQKLKNCiQ71/F2j6OG5d8K4Ca+EfPJWfvMvuYJQ6kirX4vhy5JfgTg3l4Iuud7zSXm8GEBNZe44tlCXiNimb+nDlvGyXBg8Q0QuYQIk5ERPiE5I0XNuNbUwsj7IWOxWo+4dVl3NbgnOdGhKIJr3CPhw6Z4z3YEjkFp4TccutskPmx/kk0sGsDxu0Q3YMHaV5xbZ9wAanMeena+CbNI5nM1SXvfBQCqaBf8FCqzBUeVNUXiUwuZW8O0ideMGdHc9f9R56C4M9G0jxFkdpHsKYF2/eIU6r/uJDglsv7n2pNX7v28O1l0ret2kqCJXr2yM3rFyxLf2BXDSjjuyGKAJoGkuBDP8V+JM+tCTIxYrzW83Z46sADKbrUvdIFxT6jMOxty74bAa//K2ZaJaAK8LqNVYdNlKuclWTeY+/1fIk5YXQcyNJPgqW0qyhNLwrldmaaG5asqg4OquKR2tGg5/vCOILU/fK2VbNSsLWgw9EGnmVLF581NnD0r7f2C3HqkgWUre/1hCc61zhpvtMOiRRYORz+cvagTcQmPMM/RfEoUMaCLT23H7O55qTxF5VGjQBOQt6bi7CdC+j3C+Bo+KF6U0R2Ds2oYfSaUqwSRLmmHOC8a3BN6Nm/wHdByqhp6FUnXqCXTlw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm5pZENOcklqcUN6ajRPTitESGU2VW4vUUE3VFVOaDcwOGZvWVBDUFlJRGUy?=
 =?utf-8?B?UjNsV0xjS1d0Sm1MZjhaa1V2VFJ3ZTNuSm9ndU15NE1Xc1IzdjlRZW9JT2dX?=
 =?utf-8?B?VUkvRWRjSm9DRlVKUytEcnR0blRxSXFQT2FJYjdFZk5pQ3N3Q3J5OWRBY2lF?=
 =?utf-8?B?OCtpTVU1cWJSNFFPVWZUajkvNnlLMzNMMnNNQVdMa2lZbDVGd2pkREwveUNp?=
 =?utf-8?B?M1lSY0RTWGt1Zkp1UXRENHltUU8yK3VkeVVLakxrVitCeW1aL2toN0ZyVGUy?=
 =?utf-8?B?M0ZOYWNWTSt4aFVsYVg1TS9Rb2VqOCt1SXVmMWFyZnQ2NVMwalNyclhyWDNK?=
 =?utf-8?B?Tll0OTdXempEZ2tZU05xMUwrdi91WUY1OXFCMk1SUm1FcmhJdmtnSVZOYjFI?=
 =?utf-8?B?YlYzNW1mRG1yM241MlN0UTVsd0UwMGVDOGtTdkpQSEtWaUs4b25PYnZaalBB?=
 =?utf-8?B?VXFlV0tqRlpQeG5IV0diQVJMVXd3dXBXOUkzbFdLUHMrcXhBVS9ONlNVNWdO?=
 =?utf-8?B?dTZhT3V4RDhuVGhueVpHYTFZVldIdkR6Y0NIZXU2c3VzTTFpeVhHd0lzL3Nv?=
 =?utf-8?B?ODkrMm5OcjZPTzVEV0YxTEV1TlF0a2dEa3VzYjdpRGRyN2NyY3JEYmFFK0Fn?=
 =?utf-8?B?dkxoaDN2R3BoWWF6YmJGSFVnUm1jQ1BWdWxYWmV6dTJ1VnpYbER2Z1ViM2NT?=
 =?utf-8?B?cW5NWjZSVVV5Q1FZVWs2VmhZYm5RSGdXNXhsMExUSmEvOTB4MExtNVdKZDd6?=
 =?utf-8?B?cDFrdTNtMlZiYkNPQWwrdFRkTGo1U0cyUkk2eUV5Lzh4RFpSWFRoblNiOUdV?=
 =?utf-8?B?WWJ6dlo3bFo1SjRFTWlzOFdMRFBmQUtHUEx6Q1k0TUlLbERweGkrMzk3SkJD?=
 =?utf-8?B?WHZGZWhSM2RtS0NmMm9uTTNjVDNiWTVIcml4UkUwUTJ6TngxNkk5NXA5OWk4?=
 =?utf-8?B?bWNFTUNLTDlDanJxZUI0ZlQwekRITi9FSUo3aU1nNTgvclB5RlNJb0NUYVB1?=
 =?utf-8?B?Um5NZEMxT1pNWUNXbW52dDc4YVloK0kvcVJRMUZKTFZaeFhxZU1hcCtudFh2?=
 =?utf-8?B?VlY2R1JXL1ZGS3hsSUV1OUN3ZUpyaWl6TFhVMlFITHd1V0xPNVA5a01JaEVh?=
 =?utf-8?B?dWV3SG5nNlJOY0lIU0hnZ01SN3N1R1VqSEFyWkIzOVNnVVNaT25nYkNkS2pG?=
 =?utf-8?B?UDVyRHl6MDIwRG9kdElReE1rWFBsN3hiaXR0ajEzS2lLOXp6ZlY4cGw1RzYx?=
 =?utf-8?B?ZWM4dUFXdzh1YmVLOHk0cjNWQzU0dndNTk1aZDlKOTc3RzF6VlEybnVaWG5U?=
 =?utf-8?B?K0lyMU94YmZhY0xhVnVpSEltMWVjMnhrKzlUS01sWWJEMVRuQytlUG1BVCtR?=
 =?utf-8?B?SG9oZ1BXNC9odTU2RVhRSmQzRlZTajNDd2tHaEtwdkhOWnMyVDlyemFWQ28z?=
 =?utf-8?B?Tm0yT3JrM1ZVUkpHSS9EUVNPbEphVnVCU2plM3JiVkgreVdWb0psamR0YTQ3?=
 =?utf-8?B?aU54M2xsSUNlTE9sWHhkbm8zaUxiYTFLZ21iS1RnU1E5b1VOMVpRR0RvL2VF?=
 =?utf-8?B?N1lWNHlhc25Cb08vRFdrYnVCT2d2b1o3WnlNY004YXNQMlVzR2hyUzR6NnQ5?=
 =?utf-8?Q?M7HF9Xht+QwsaiKkzGx05Xn5l+CkmEhJ7G5vrte6ot5Y=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d60b22d-8026-4752-2020-08dc1afc0936
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 03:41:39.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1618


On 2024/1/18 13:29, Chen Wang wrote:
>
> On 2024/1/16 19:37, Chen Wang wrote:
>>
>> On 2024/1/16 18:06, Krzysztof Kozlowski wrote:
>>> On 16/01/2024 08:21, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Add documentation to describe Sophgo System Control for SG2042.
>>>>
>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>> ---
>>>>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 46 
>>>> +++++++++++++++++++
>>>>   1 file changed, 46 insertions(+)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml 
>>>>
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml 
>>>> b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml 
>>>>
>>>> new file mode 100644
>>>> index 000000000000..7b50bb56b4cf
>>>> --- /dev/null
>>>> +++ 
>>>> b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>> @@ -0,0 +1,46 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: 
>>>> http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Sophgo SG2042 SoC system control
>>>> +
>>>> +maintainers:
>>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>>> +
>>>> +description:
>>>> +  The Sophgo system control is a registers block (SYS_CTRL), 
>>>> providing multiple
>>>> +  low level platform functions like chip configuration, clock 
>>>> control, etc.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: sophgo,sg2042-sysctrl
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clock-controller:
>>>> +    # Child node
>>> Drop the comment, it is obvious. It cannot be anything else.
>>>
>>>> +    $ref: /schemas/clock/sophgo,sg2042-sysclk.yaml#
>>>> +    type: object
>>> Why isn't this merged here? You do not need the child node really...
>>> unless the clock inputs are specific to that clock controller and you
>>> will have here more devices? But where are they in such case?
>> I don't see more devices will be included later. It should be ok to 
>> merge them into one.
>
> hi, Krzysztof,
>
> After some double check, I find we will have more devices in 
> system-control. For example, in the SYS_CTRL area, there is also a 
> section of registers used to control the "General Purpose Interrupt". 
> The pcie controller of sg2042 will use this interrupt controller which 
> is defined in SYS_CTRL, we will add it in later work.
>
> Specifically, the distribution (offset) of registers in SYS_CTRL is as 
> follows:
>
> - 0x0C0 ~ 0x0FC: for some PLL clocks :
>
> - ......
>
> - 0x2E0 ~ 0x30C: for General Purpose Interrupt:
>
> - ......
>
> - 0x368 ~ 0x3FC: For some gate clocks
>
> So it seems that it is still necessary to keep the current child node 
> method, and it will also facilitate future expansion.
>
> What do you think, please feel free let me know.
>
> Thanks,
>
> Chen

hi, Krzysztof,

Can you please take a look if you have time, looking forward to your reply.

Thanks,

Chen


>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

