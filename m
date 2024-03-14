Return-Path: <linux-kernel+bounces-102959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA887B919
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA61284D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04B5D72E;
	Thu, 14 Mar 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="cFMfPnlU"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11021006.outbound.protection.outlook.com [52.101.133.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECCC138A;
	Thu, 14 Mar 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403729; cv=fail; b=Z4l8foRBfOXQFyloJc0FRk4N04UvpWX96ufyv2ZEVtPamzeG+EmBGefif28p8sSOT/+Cp2os3O8ueVPsUFjRJcZeozp9SFa52vDVSlkWk+G6ounR1PTnF+LxccATVlDfjE1v94xe2uTtI9qsAG1dW8b1T1zXTLMlwqZAE5+iRRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403729; c=relaxed/simple;
	bh=dh4lw2BTc8xKppTN4HzkBe/AS4XrlV3fq2iStWx9MSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HaP+66y0bSF3KrCoLOVs1gLaBt90YE/svnyu9EZc9O1IS+zKT5P+b3H+T9G7ehgoawzfYk58G9ov+X4dJLZUyceuGPEr4gpCUM+vAQ9GhsPQ8nH1MjVAqGdv0VHou5GW5kcQIdjle5bN+VyXJ7dn+hzKbcFsWcgk9hgnE/YpcKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=cFMfPnlU; arc=fail smtp.client-ip=52.101.133.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E72a7hLyDp6c2/UsHX5fXAX4nu2XIpG6Dj+YQWtaROwzT6PHfQQvRbBA4JpTviQXub/jE7evzV7RjtIrn+DyJg65g2kGvehFhJJV+G7JGQ0oxAydF1lp7j3QTUZUCvvIRLS2OgGf3KtZSO25OL7uJh/SiJ9PgUq0jw35aJ4Bsi/aHE2l+Z27uh5Q6boyNTs4SD0FZ00mXClVmK75i+bdCzy/Xo/qVRoYJcRaCk4NoRI8dPQUQtkxZzN5Jy+afYT6/9lBOE2+9v1Db0e3TsbVoZvxyivvUr3dVxORMdbwdt9OKfQJSSX+Wbvy4d4AcA4hDVAzVk0pa4v0CAqwIJsguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idvZdHZWlA9MOO/2ONmBTW9yHnZohAzfN3SsNQzlkeM=;
 b=KDTrcmVnLZvAYlPGfjeHXrq5RQaz9CunWGwALX6TsLy0ua97WAnkRNmyCCptgM4UUNC4nxRitwyl1yJAc9hvGc9VqMZgEdu00Rk5IHokg/cLk8+Y2TnNJ9GoBcDV3OhKDmG62c349f5mrDxP2x347H6BdJ7WSryZI/n6f9K8M9Y8ltE1+m1P22UQYI2x34+nQrSWEfD8XtfPD9GZep5SthhXByjmrcrezaj446Qnus3pEHeeoVSDAeXDVP845pHOllHobqswlSRIZssjrxnGl0hmLyW3Mtj7Yv64Iyu7gmN0lkt8X4W8XycWAKQOKWmMuXv76fk2msfItT4SbeXLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idvZdHZWlA9MOO/2ONmBTW9yHnZohAzfN3SsNQzlkeM=;
 b=cFMfPnlUxBgKEd5e510NZe3Paoeo3q2amLZiWme8+UEnWe+sU9RGKfDjiS4GWMv6nDqOfMtGB7bhBSfd2zIgS9VmKzAS/G/CJGld0/YR+0+Zns4xLhHfO6v8ppnnl4x8bCyvnUOU38DO5/JMkXihzqvHhI7THFgzNe+MfYmcdQ/NG3hOliqM8fZPLyqVB05G55WC9f+5GPxvdBtAPD7P6Q42ILp7o5wSd2fC0naseBqq7cmBMS4N0ZtT6IdoSGTBLrndP7kGd+pbeiZgwr/m/U434KMb7Fbs30A5RLeBof49xgkLpY8J91nasIHcJgZ2WCPIic41J6RkUTLBr7TP4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB8544.apcprd03.prod.outlook.com (2603:1096:405:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 08:08:43 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 08:08:42 +0000
Message-ID: <9a38fd52-5eea-468d-bd7c-29a505503268@amlogic.com>
Date: Thu, 14 Mar 2024 16:08:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: add support for A4 based Amlogic BA400
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <1jsf0vephv.fsf@starbuckisacylon.baylibre.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jsf0vephv.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c93cad-d03a-49e2-f0d8-08dc43fdf6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CbhdwvOleGGXfqUBe0lfH53XN06Ur1s9I/ox3PjYON8yB059YabYiKyeUMxN53oZ/A9uXvX+tUcQha1kw2mie5KTwrIu0eMazWdNg0NC6jlNiQFhY+t4t3DmaohcrklH9QiJlqU40lfs7pWBLI99ZCtQkLt4Yn8MtnC1+qbIyQgKd+JQX+l3QPpod/i8N9sy0EWK7C83+6St2HCME3TBXqUDUdQaivV19b8/YGuyiySPPCmGumirFsKD4zWocGpqzpsaD7GWPTzjJaKPiNic2HxKFSXoPIcjwBrsEmfzz5NRhJZKEN4zASPdds5EWiA5H5iTlWMlonTwSt0t6oa6Ny5H98S2kG2IrewMfBFSTBq6etCHFJHD7kQRI5DHyCc9N9IOOGMiVDSut2kZv5IxXDhFEUAj6SNpd0A4lFEyZPhGtfmpTBtwpVHB4KelV1g4kh1484zbYplvx7nIWTrS+HJOnL9TBBPlk5frH/zSlOEN1NhGocw53Q/aZZ4vyDcEL065AgDWdPdLmZq/fK0+5AAXQLXh31u0cjYNmVOU4Pviz9Ob7Jt2VJzo5SAjG1NMPqsozEKqgW3MYFncuSU6Z39embNuSS11yqRiZdWuI7kTth0Lh/s+Jz4PAVQSbZrtgk5Yzn5WTCBYgdDjYfuGi2xzicC8MsGO8GGCdBPo6Fk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODhYTFZkclpVUVNwclI4L0pKM1FXaEIzV1hpTGRwNFI1MVRtMjRuVWMzbVB3?=
 =?utf-8?B?ejNUNWtOYmRwZU1RU0pweDJMd0VUNWIxelJyNVlDcVd1bU1PdXZiQ2d5OTVo?=
 =?utf-8?B?eWhDVytMZnA4TFlKRnBsbHNTTExQUW10MXpwaWxWZFU5RnNna1FDTnJHVFF4?=
 =?utf-8?B?bnRHRTJIRlZtdHJia1BhaEVCNXdnYk1Ib3B5ak9XaDRVVzJ3dkJFSldiSXpx?=
 =?utf-8?B?d1pneXlwOG85SEZ6bGQ2R2tVSlBKb0VDQkhBRTNLRkVxendKdENuVzhsbCtW?=
 =?utf-8?B?bVRDTEhxVHUwUHpnaWl6VEtRVHJ5cVRJRVFqdGtKQk9YYWZYSXQvSmpuSU5y?=
 =?utf-8?B?VVNtaUd4Nm52YW9xbDM3YTVGMjhKVGhDekxtVmpCVTdaVEwwZXR0dktqaHBr?=
 =?utf-8?B?a2ZGMEpOc0JXUDFFYXZFNC9aMlIwRHlZc21wVEVFblp6eWNXUUdSRjgyOUgz?=
 =?utf-8?B?TkVtZVRkVWFwdEZsaU5wa3RueW5KakxPQUl4Q3MzSmQzUHJjVVBYeStZWldN?=
 =?utf-8?B?Zk01QVAwNVpheXFaeENhVXFzV0Z0d21pQllaWFRGaUtlRE02WVBjUW5uUnNG?=
 =?utf-8?B?eCtzRXd1Rjg0T3lQTWNLdXdjVnhvYnl1UUxLRlJWK1RLaXJwKytFQ3pRN0k4?=
 =?utf-8?B?ZUkyTnYrSncyengxWGpPNTd2aXB6eE81cWRlK2dkcEpldXNpR0tzNmdqblJL?=
 =?utf-8?B?b0xUU1lVN1dNMzF4Q3hKWkhtUHhMY083RkxDcHZ4SXRiN0tzYXJpREJxOFdx?=
 =?utf-8?B?S3l0Rk1ldFIycG5FMHpYby9ucmpGT0xXcURFSTQ2VW5JdEhDd0pleTE3bmNa?=
 =?utf-8?B?aTRWNzQxLzY3REp5MnZqa1lQcGloRGExb2REUHZxaGphaGE4Y3FNRWF2VWFK?=
 =?utf-8?B?S0JHaC9CMHVEN0FOaitJMG5nanVwT2N4RTY0VjkxcGdtd3RrQ0I2dTZMZ2xF?=
 =?utf-8?B?S282Y2VudUdlc283QjJ1RXVKVE0vY2d0VVlQaVB5aTdXamtZU2Jra0ZCbXor?=
 =?utf-8?B?THBidjVuVDZiOFV2QXhkUTZhTjNZdXdyd1pTWEs4VWxLS1U1bWtCcWE4Mkoz?=
 =?utf-8?B?aUwvRjZnYmlzUXo1WEZQbVhLQUNYNXdGWWo4M2lxcFFyemgzQkhycW9XR3I1?=
 =?utf-8?B?b0NHTEdrOVlxNlBTOEpuWktodlhzaGdDVEhSZUVkaFZYREE2UVRYeEp1ZWY0?=
 =?utf-8?B?Mm9TMUFOWnVQbHkyQ0VBK3RlVjdpL2NjOTd6N1M1WG43MVNqUEc4cEZjdDkv?=
 =?utf-8?B?QXVhWkJkaHFxV3VWbVdOWnp3Si9waWNGWFN1bGVNbElWS0RNanJ3U0dGS3o1?=
 =?utf-8?B?bUNONTZEQ0RrM21QRnNZaFNHWWx4QjlzNHNUL3FPekZjTlR6bGhjajV0cWQ5?=
 =?utf-8?B?SFBvNzhYMDFQa3dlTXhKWnNpNHRxMWNtSEdsMVpmTXV2SjNRcDZBYjNiTHdD?=
 =?utf-8?B?MnM2K2FBb0VvUVY1WkxrL3FqckRXQmdiMjRZWFZUaUlEUytRUlZWN1E2aFBx?=
 =?utf-8?B?bkozSUJpL1NOd3B5RmcrRDJsK1V0Qjdwc0R4UUdibzVZU3VUYVdTNWU2ZFlG?=
 =?utf-8?B?cG9haUp1SUl4OEFwR0JWZDczNXkyUmJMeTRGQ3VOZUJkeXRHNUdSdndycTJQ?=
 =?utf-8?B?WTNYRGJWcjRtdWs5S2htZVhqaUpHWnNkYUl6eFZOamQ5bmFxcTh4MFJHSXVX?=
 =?utf-8?B?eXNhQ0ZyQzVPaGZQNHZXUEF1VzllKytmeVBrekN1aW9Ob0dSdHlUbElJOTFq?=
 =?utf-8?B?VnJkck1lZkt5dkhZZXdHdUxLZ0VrTlhSbEFRRVRSZ0pLMm1yTDRrL0p2Z2I1?=
 =?utf-8?B?ckVQVTBlL05sMHlBZ2J5cWd4dUpXZUY2RzJDWHhBcGJGczdLdHJ5UE5uVm1O?=
 =?utf-8?B?RTlxcHBSb29CTitydVltbGNVZjdxQWxjUTFsb25kS3FUT1AzM0N2bVY1S1NI?=
 =?utf-8?B?aDV1U3JOZzhEYzBaaFdJTXVhbXNPNi9OdVlkOE0rcGNQcXh3L29Fb1FEaXRz?=
 =?utf-8?B?WXZ0bmdnZlp2eHZxa1RHTGtRaXJtRWZMVUlaZWVEQnZ5b1RicS9neWRsZU4z?=
 =?utf-8?B?OHlyN2M0MXNzYnJQOTc2VExWYnJSMThrbE5qT2E3T3VCUzFtUHQ5U0RjU0pp?=
 =?utf-8?B?TUZSVUg1T2VTaHhncGNocHhRRi9wUTJwS1pWSEthM21zOERQYkVMYVlkMGpF?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c93cad-d03a-49e2-f0d8-08dc43fdf6c1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 08:08:42.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CEKE9Fu/0UgUR1QRqu+USaUvQNZDG9RI2W2Okzv2+5M2LIL7MNMR63jlNp9F9H1fca6oAEw28mhZfq+fZuzbGvIMXpgsSBoc4OLrAXPeEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8544

Hi Jerome,
    Thanks for your review.

On 2024/3/12 17:55, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue 12 Mar 2024 at 17:18, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> 
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Amlogic A4 is an application processor designed for smart audio
>> and IoT applications.
>>
>> Add basic support for the A4 based Amlogic BA400 board, which describes
>> the following components: CPU, GIC, IRQ, Timer and UART.
>> These are capable of booting up into the serial console.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>>   .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   | 43 ++++++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 99 ++++++++++++++++++++++
>>   3 files changed, 143 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index 1ab160bf928a..9a50ec11bb8d 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
>> new file mode 100644
>> index 000000000000..60f9f23858c6
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
>> @@ -0,0 +1,43 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "amlogic-a4.dtsi"
> 
> Could you describe how the a4 and a5 differs from each other ?
> The description given in the commit description is the same.
> 
> Beside the a53 vs a55, I'm not seeing much of a difference.
> Admittedly, there is not much yet but I wonder if a4 and a5 should have
> a common dtsi.
> 
They are mostly the same, A5 include HiFi-DSP and NPU, but A4 is not. 
And  some peripheral modules are different, such as SPI and Ehernet phy.

I would like to wait for the follow-on chips to come out before 
considering a merger with common dtsi file.

>> +
>> +/ {
>> +     model = "Amlogic A113L2 ba400 Development Board";
>> +     compatible = "amlogic,ba400","amlogic,a4";
>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +
>> +     aliases {
>> +             serial0 = &uart_b;
>> +     };
>> +
>> +     memory@0 {
>> +             device_type = "memory";
>> +             reg = <0x0 0x0 0x0 0x40000000>;
>> +     };
>> +
>> +     reserved-memory {
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             /* 52 MiB reserved for ARM Trusted Firmware */
> 
> That's a lot of memory to blindly reserve.
> Any chance we can stop doing that and have u-boot amend reserved memory
> zone based on the actual needs of the device ?
Yes. U-boot will change size of reserved memory base on actual usage.
> 
>> +             secmon_reserved:linux,secmon {
>> +                     compatible = "shared-dma-pool";
>> +                     no-map;
>> +                     alignment = <0x0 0x400000>;
>> +                     reg = <0x0 0x05000000 0x0 0x3400000>;
>> +             };
>> +     };
>> +};
>> +
>> +&uart_b {
>> +     status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> new file mode 100644
>> index 000000000000..7e8745010b52
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> @@ -0,0 +1,99 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +/ {
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             cpu0: cpu@0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu1: cpu@1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53";
>> +                     reg = <0x0 0x1>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu2: cpu@2 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53";
>> +                     reg = <0x0 0x2>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu3: cpu@3 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53";
>> +                     reg = <0x0 0x3>;
>> +                     enable-method = "psci";
>> +             };
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +     };
>> +
>> +     psci {
>> +             compatible = "arm,psci-0.2";
> 
> Really ? still on the that old version ?
> Will fix it. Use psci-1.0
>> +             method = "smc";
>> +     };
>> +
>> +     xtal: xtal-clk {
>> +             compatible = "fixed-clock";
>> +             clock-frequency = <24000000>;
>> +             clock-output-names = "xtal";
>> +             #clock-cells = <0>;
>> +     };
>> +
>> +     soc {
>> +             compatible = "simple-bus";
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             gic: interrupt-controller@fff01000 {
>> +                     compatible = "arm,gic-400";
>> +                     #interrupt-cells = <3>;
>> +                     #address-cells = <0>;
>> +                     interrupt-controller;
>> +                     reg = <0x0 0xfff01000 0 0x1000>,
>> +                           <0x0 0xfff02000 0 0x2000>,
>> +                           <0x0 0xfff04000 0 0x2000>,
>> +                           <0x0 0xfff06000 0 0x2000>;
>> +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +             };
>> +
>> +             apb@fe000000 {
>> +                     compatible = "simple-bus";
>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>> +                     #address-cells = <2>;
>> +                     #size-cells = <2>;
>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> +
>> +                     uart_b: serial@7a000 {
>> +                             compatible = "amlogic,meson-s4-uart",
>> +                                          "amlogic,meson-ao-uart";
>> +                             reg = <0x0 0x7a000 0x0 0x18>;
>> +                             interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
>> +                             clocks = <&xtal>, <&xtal>, <&xtal>;
>> +                             clock-names = "xtal", "pclk", "baud";
>> +                             status = "disabled";
>> +                     };
>> +             };
>> +     };
>> +};
> 
> 
> --
> Jerome

