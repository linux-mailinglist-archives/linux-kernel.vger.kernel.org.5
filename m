Return-Path: <linux-kernel+bounces-142490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C468A2C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B6528409E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D3353815;
	Fri, 12 Apr 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DX28EUpl"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2092.outbound.protection.outlook.com [40.92.102.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D553384;
	Fri, 12 Apr 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917407; cv=fail; b=gVG1uQtwHBA97L6bYFSxfD+KoG4pUI9YdkJO2sEYCuZnxf8AhwQSgwTICtpPT/V16Ypo3qt6sGJNi5FBmYJEzgHpNhs7AKoAXK4Y0sglj0Fd/QR0V8nOCgFe+0UOLO7ED0gghHLEeqWPaJ3z4QDYyPHdlG/3jxXyraxCjBdsjrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917407; c=relaxed/simple;
	bh=SPwY/+bk/JO0ZFn7MGz96nM07sN9xIXy1IzFqOLzFAc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ts8zC6hSVnWkqNC2HN9urJxrjVKglGy/9MObsBBJyT380dprZu3U0FqkdGI3xH7VbazKnt1TRgdZW+vEWoqHm+yzXhtTGgKqh6T/3Dq4SdrWdDqb6rKlsEQpTh+QJqSCSaZln6c0nOSuIWL8gmFIT+VcPY67/USyySPsWPQEev4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DX28EUpl; arc=fail smtp.client-ip=40.92.102.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBok5bBibzXVjq4hf/Xa3+jA93JvxmOEEGCjzYyigX4e/QZJ2rhA/tAGRT9aT3OlqLnicuiCv0YGrDlivgar6noYaYEzE+qNw9kkBUl0qDiN//+EpBEByIJxEi6GjY51ANJb5f8QJ7oAO2S5gJVvZqX9pYNC25fcMu4MjFzA6NCd6GquL1wfcpi3VRjhrtFsgz4ArhFnsKvoGYgcO9pkXeP7heWnNGegYsdYKhgrWuTU0AU9Drrv5L+C/dA+iIB0uhjKMLqReaJXjhnuMJLNNro7AR3A19gfOwwcDadJFghlVBsh10hOuzkzpvlGIrrKJF6BGaNqEMAHMIEELLfqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfblepfYTbRGVzZYMUwHrLjsmfB/aOh4FoCyB0F6H2c=;
 b=RLc2QPKV7SEU5m0Chk2tKUAp7suvg/pBN+r1VCw+jJN1hF2fVPYhGRJWwopFBKeaaNskWguMUu1YBlmNIuVIZ+oDIRz+IvcMbtmq+OPpJx8xoPfmJJR+FOgMnqxQoX7Ka+CdkBEsqaFbRDUo03DudYvvL1Fo1AwyOxYKXs5AEynYZkiwvqrjlI/jPV2zcEoZtIYn9GHIKISA5PROpQmsQA+CC4vinRKefgjWI6rDlEkbTNPTj3/UG6v2DbAKQBDITQRJGs88pw2njObnxNs+lqHMG5IysljanMSyvYmMGAvWgIwfOdKLVagyiohmxCPizlGA6QNnoBORPzT9rAQ1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfblepfYTbRGVzZYMUwHrLjsmfB/aOh4FoCyB0F6H2c=;
 b=DX28EUpliAQB/5lEbbdE5hRyrq5ft5fUc5VmMcjsFNN0DuzLjc3+jr8r4sfG4lYhJizK24N2bboUwcrixMKdWkLn2A1+CUkxfnVpZ5hiKWkMPk4iNcQFIjJjW84KjLsY4t2pqaqG3WjZTh/wAG/lxYvOePSWz0eI7b/1ljbnf98EbZLC/JihqQqluzp+XY3e1gLMrT3lRjTxWZ+ZhLoAn3ObllSPC5ZsXT1Ro+MnJTp8CfvXo9P+MAffOstywrDXMbST5JJdOzj8PIOc28jvm9rJ2g5NlnlhL/M4fq5bvVsi96NgWd6T1GpfgGRKaVqCC71WT78sToqKQ1s78O2RWg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1078.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Fri, 12 Apr
 2024 10:23:13 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7409.046; Fri, 12 Apr 2024
 10:23:13 +0000
Message-ID:
 <MA0P287MB28223E4F14E6D08E1139CA63FE042@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 12 Apr 2024 18:23:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/5] clk: sophgo: Add SG2042 clock driver
To: Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com,
 xiaoguang.xing@sophgo.com
References: <cover.1711692169.git.unicorn_wang@outlook.com>
 <816122e9f22ddd9927e81e627be7f4683ba5c9e8.1711692169.git.unicorn_wang@outlook.com>
 <433e01f22ce5472aeb28cf0182d951bd.sboyd@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <433e01f22ce5472aeb28cf0182d951bd.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [qdbs4tZprd1ql3E+xUca5by/1V4X87i3]
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <adb50bdb-a30d-4c67-849e-d85ab6be65fa@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1078:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a6f9d4-5a5b-4a28-314c-08dc5ada8f2f
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQDmFN0yKEpvbPDpAvl+/SbOWXduVvlLbBWjF5sNSML0mcvsbdmL77ixpe34E2HOGTgYzKcemFerXjZae30mGFbQL3QAhukIiezaDHMx8I7z9zt9oE7WdT37qEXC8cqbKLYxczY9krdSd5dyAGTQ5/aryOuAEg6zfG0JEKKdcyDtPh78XvkQkG1hT4IBAUJlt3S3B/HV4cWGo7Jrba5ZTCuTWPjh0QcpefDS9A18Vt5iHL+mzEuGBridwsCvIyMc+xlsqKQtQ647JBgJesLZgdADwXVAq7zkyOzCty+W8YChdRY8TAvF+e6/LAs5Ec2wPhC/AUEVKW4Mf+lXysBd1gw4WKIUtyZ/zXbn6U4ioUbS1vYgEfr2dcnebD2NOv37p0vmFVpdZ0tlat/hzLXzLPR/I6jMEf73lkmxn5/OnEu93pSkmR5uwHf434CiZrYbe/Zj8QGFIyfZ7242/EzVpdQainFK/HZXXVoqo0GIwnb80bsGNqQTPFCj3xqU17gq7tT/+7kvzNaBHtWY1NGLW6rAeevdIsb2tPRWDIQ1Ov8iwbNKnZHAeCwtIPx55QKkKLNpfw8TR2EI0aPR7cBUxsLKxwAQEyTp0Mf/suDH5Go0ZalcQku8iyctiIKtNqW8EB5F79fgLObASrmcBBFZy02m2NO1vDiIednXg5x8o+p1sdZrvpor2GGRAxJ1g7iXYnCbWSPrKhzrhhcQdITnHCEPqrd/Dan4P8Bs2KqzCgGh5icLjGa3SovlJE8kR9s8UxXU6CnWdwMPNWdmdUDTNuRWl4S9LTmsNXyJ+Iwb34l5rkVMZP/bL+fh
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LlYZuGBFzWn+vb+E3HDupUHAlESQljTXEuw9w3dDqVgGsfDqvgojylv7QtBrg2WEHUw/JMN5qfIZNpQRuoY2qI17hu1w4mXFCEIwKODbSDgWHEgv2sSbxJ1J5Gpu7UnhzU33h40RrTVstacwCgm6M1ptsn6nJZk2uButya6qehdPw40+eHszPgdu4SNibdkNnUBkcEntW1dcDScmt7DF2gkjQ9AczZzbeKM+QQvHd9fjp5vxPP5wKxfX999xhnC6P5S/pm2tsmBKF2BY9jLlRKKXCgrMhUnCnwTYWDzpeC3YxIr7rDuId1S1xSaf9YADX2CVBqbDX9KcONRX1AcXjc1rlHtppEUpas+OYNvUuCGHvpNdb5y0nB2if5RzVA2dcLIrkYY/HukkcBbRcTfJZ+ta7vSqAtMxfoN8KT8Fk3csCPSC3nv4OdDsccjUO4sAwTxubIi/8fZ90Qnn7KiD1qwxm7rvdKiEeIEyK0qg5hhNGpdq88tRn46oMc+6kBTr9E5rIxJzr7xMxyomgzNI+2P91rneg5r8N4VLswzyjfpKGU/hwEeeMu5BAfTv3Ux+eNYZ7AHLsQkioHoILXBNaPyIdacyGIxX2N7jsuKTZ7+D93j9G9xP0+wd8bHMbD/RSe2UTocoJa+LTxZ2EOYjhHowB26EKl6YFf3N0JArUWOJvZhelLFUBW3CCrYmIRbd9Ll3cFb4p/7zUbHkoodEAw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1VvRnlnOHI2OTVPWW5xa3ZselFUUVNzVDJNNWhrRmJqcldaOXVpYjI2emI0?=
 =?utf-8?B?OW5oNXR0amxRdG00SWZXeldRZEl0V2gya3F2Q2JaWk4vcGFSODdMMzRiVWJ4?=
 =?utf-8?B?ZFZVYWF1LzJEMHhzYXUvNGptWERPK29adExxVDdlNmFUZlV5WTkwVS9Rd2lM?=
 =?utf-8?B?ZWJDV1dncnI0TlNJNTd3NmsyaFZmRlRsVlVMekJlTytweURoM0pZQ1JBalEz?=
 =?utf-8?B?bG01NVRDNnZYUkNudXFMbHlsS2NCVllyNnpDV2piUG9Jc0dtdDJqTnl3NmZz?=
 =?utf-8?B?OWx5N1VBNVMxMXJwZ08rWWViSVd4eCtqWjJVRVpyV2dXZmE2SmdkbUd0SHhM?=
 =?utf-8?B?cTRwS3M5a2Z0SjVsTVpGNm1Zc3JxTFN1c3VUOHVlWk1aVEoyV0pSSkRmdEdR?=
 =?utf-8?B?aTVudExlNWZEUEZtOVNNM1daR3R5MjB4bjc2d2Q1OWszazVMZXZ5WXpnUnpF?=
 =?utf-8?B?Z25KTy9LWGxoOFZaclVyNWZucENuMjR3TTg1Tmhyb0IrZzB1NDR5amxKL2R3?=
 =?utf-8?B?L1RBZW9jYnpnbE13SXJNR1ZEb3lMQ0RUbVBMbHhENmRmK0IvZXZrYmx2VWJO?=
 =?utf-8?B?K1c4dUFoQnN3YmlDZHNEWnN2eC9MNVpOSGdiZmZzbVlHT1pTWHNwYXNKMzJn?=
 =?utf-8?B?Z2N0OUR2N0VYbFo2dmlnNVE5a2tzd20zc1dlaFNiaGhRUzBsZmRFSE5IQ1U0?=
 =?utf-8?B?aEdaT3RUaDlSdDEzZWpCc3VreWl0Y1RUcmtuT2duZjBRc2RheElkZ0FRU1Yv?=
 =?utf-8?B?ODNMaFFFL200VUJadVNVK1FYWkZRbGJnaENNS2x6a05XazhxSjdxQTVMdEhl?=
 =?utf-8?B?Z1o2U1dTM1pHRkxaSUYvMVYvTUc2V0ZuaTdNeGxlZ1NWV0lGajJjTVJkZ0x6?=
 =?utf-8?B?THNqcDB2NDBvbVZSVTZiNk5RTFVWMWhxdTV4RzdnZEJEeVNVOWVRWXg5QXE1?=
 =?utf-8?B?aS9vUGEwMS9uUFd3VUJXWFZQaGxhVGRLaXIzM1dMQUFBVGtwUzltdndSeWla?=
 =?utf-8?B?YTZuSkdYSUZOM2FCTWRJSzhoVUE3MGRoY21jcjd2UHhLWGFidVM5ZnEvZnJr?=
 =?utf-8?B?Mjl2cXEycUJpbWFvZUtpY29ibmpBbjRiTVpBaXBCMk5rLzVuOENXVWZPVTdB?=
 =?utf-8?B?dVR5elRaaEkvSGRHdlkxMUVvR0QycERBT3JGQUY4dEovRzFlNjBOaW5xNDZu?=
 =?utf-8?B?S3lralpGUkFUVzRFRDdCdnhpUzBmUElCT1h5Y0cwZ2F4UlhkYzNaQkJQZEZS?=
 =?utf-8?B?VlZVZ3ZlWGNhTXZvSHFiMlJWZ3oxVDNSZUsrQSs3NzZiZUdMY25GSHRJcmZB?=
 =?utf-8?B?Wlp5TktySlZqYVJIUGhvT254eEszbGI0K3lFSlppZ0hHRmVHTnphdWpobmxC?=
 =?utf-8?B?NE9lOThxL21pNW1TM3hwZ0FRaUdMQlR3dnlvQ2VwY2ZkY0lYWWFNcExsN1lJ?=
 =?utf-8?B?cWk0eVhRU0s3bmxDODJETkZ3R2wzbVlrVkVCV2NGZjJmaGtLZlBoalQxeHlt?=
 =?utf-8?B?VkVXNGw5UVdnLy9mdWxDbi9YczBYYVprTTRJTjBnT2JVRUZuUHI3ZFAwTzdJ?=
 =?utf-8?B?eGRwdXU1RHZyby84dkhSQ0lzdTR1akVzSW9DT0FNUVpTakdSZUZkdUFkaVNF?=
 =?utf-8?B?YXAyRitaSHZETVpNcm8xdXhqQlYvNFRldm85WG00WUhTK25pUmRUem9NSFZF?=
 =?utf-8?Q?pNe0V/yFsPw8w3x57ScU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a6f9d4-5a5b-4a28-314c-08dc5ada8f2f
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:23:13.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1078

My feedback embedded.

On 2024/4/11 12:11, Stephen Boyd wrote:
> Quoting Chen Wang (2024-03-28 23:21:40)
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add a driver for the SOPHGO SG2042 clocks.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/clk/Kconfig                    |    1 +
>>   drivers/clk/Makefile                   |    1 +
>>   drivers/clk/sophgo/Kconfig             |    7 +
>>   drivers/clk/sophgo/Makefile            |    2 +
>>   drivers/clk/sophgo/clk-sophgo-sg2042.c | 1410 ++++++++++++++++++++++++
>>   drivers/clk/sophgo/clk-sophgo-sg2042.h |  216 ++++
> Inline the contents of this file into the driver C file.
ok, now only one c source is needed.
>> diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.c b/drivers/clk/sophgo/clk-sophgo-sg2042.c
>> new file mode 100644
>> index 000000000000..7b468e7299ae
>> --- /dev/null
>> +++ b/drivers/clk/sophgo/clk-sophgo-sg2042.c
>> @@ -0,0 +1,1410 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Sophgo SG2042 Clock Generator Driver
>> + *
>> + * Copyright (C) 2024 Sophgo Technology Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/platform_device.h>
> Need include for BIT macro, io.h for readl/writel, do_div() header,
> ARRAY_SIZE, etc. please check.

ok, will check and add them, but I did not see warnings/errors when I 
build with W=1

[...]

>> +static inline int sg2042_pll_enable(struct sg2042_pll_clock *pll, bool en)
>> +{
>> +       unsigned int value = 0;
> Don't need to initialize value? Also, type should be u32.

Sure, no initializatation is required here, and u32 should be better, I 
see some other places have the same problem, will fix them too.

[...]
>> +static unsigned long sg2042_pll_recalc_rate(unsigned int reg_value,
>> +                                           unsigned long parent_rate)
>> +{
>> +       struct sg2042_pll_ctrl ctrl_table;
>> +       u64 rate, numerator, denominator;
>> +
>> +       sg2042_pll_ctrl_decode(reg_value, &ctrl_table);
>> +
>> +       numerator = parent_rate * ctrl_table.fbdiv;
>> +       denominator = ctrl_table.refdiv * ctrl_table.postdiv1 * ctrl_table.postdiv2;
>> +       do_div(numerator, denominator);
>> +       rate = numerator;
>> +
>> +       return rate;
> return numerator

yes, my stupid, will fix it, thanks.

[...]

>> +
>> +       static int postdiv1_2[][3] = {
> const

Good catch, will fix.

[...]
>> +static unsigned long sg2042_clk_divider_recalc_rate(struct clk_hw *hw,
>> +                                                   unsigned long parent_rate)
>> +{
>> +       struct sg2042_divider_clock *divider = to_sg2042_clk_divider(hw);
>> +       unsigned int val;
>> +       unsigned long ret_rate;
>> +
>> +       if (!(readl(divider->reg) & BIT(3))) {
> What is bit 3? Please make a define.

ok, will fix it and I see some other places have the similar problem, 
will fix also.

[...]

>> +       }
>> +       val |= value << divider->shift;
>> +       val |= 1 << 3;
> Make a define for bit 3 and bit 0 please.

Same as the issue upon, will fix it. thanks.

[...]

>> +
>> +static const char *const clk_mux_ddr01_p[] = {
>> +                       "clk_div_ddr01_0", "clk_div_ddr01_1"};
>> +static const char *const clk_mux_ddr23_p[] = {
>> +                       "clk_div_ddr23_0", "clk_div_ddr23_1"};
>> +static const char *const clk_mux_rp_cpu_normal_p[] = {
>> +                       "clk_div_rp_cpu_normal_0", "clk_div_rp_cpu_normal_1"};
>> +static const char *const clk_mux_axi_ddr_p[] = {
>> +                       "clk_div_axi_ddr_0", "clk_div_axi_ddr_1"};
>> +
>> +static struct sg2042_mux_clock sg2042_mux_clks[] = {
>> +       SG2042_MUX(MUX_CLK_DDR01, "clk_mux_ddr01", clk_mux_ddr01_p,
> Please use struct clk_parent_data or struct clk_hw directly instead of
> string names.

Learned and will use clk_parent_data, thanks.

[......]

>> +               hw = &pll->hw;
>> +               ret = clk_hw_register(NULL, hw);
> Use devm_clk_hw_register() and pass a device.

yes, will use devm_xxx.

[......]
>> +
>> +               hw = clk_hw_register_mux_table(NULL,
> Pass a device and use devm.

Yes, will use devm_xxx.

[......]

>> +
>> +       clk_data->iobase = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
> Why can't we use devm_platform_ioremap_resource()?

yes, will change todevm_platform_ioremap_resource

[......]

>> +
>> +       num_clks = ARRAY_SIZE(sg2042_pll_clks);
>> +       if (num_clks == 0) {
>> +               ret = -EINVAL;
>> +               goto error_out;
>> +       }
> This is dead code, please remove.

Thanks, you are right, I will remove it together with some other dead 
code similiar.

>> +
>> +/*
>> + * Divider clock
>> + * @hw:                        clk_hw for initialization
>> + * @id:                        used to map clk_onecell_data
>> + * @reg:               used for readl/writel.
>> + *                     **NOTE**: DIV registers are ALL in CLOCK!
>> + * @lock:              spinlock to protect register access, modification of
>> + *                     frequency can only be served one at the time
>> + * @offset_ctrl:       offset of divider control registers
>> + * @shift:             shift of "Clock Divider Factor" in divider control register
>> + * @width:             width of "Clock Divider Factor" in divider control register
>> + * @div_flags:         private flags for this clock, not for framework-specific
>> + * @initval:           In the divider control register, we can configure whether
>> + *                     to use the value of "Clock Divider Factor" or just use
>> + *                     the initial value pre-configured by IC. BIT[3] controls
>> + *                     this and by default (value is 0), means initial value
>> + *                     is used.
>> + *                     **NOTE** that we cannot read the initial value (default
>> + *                     value when poweron) and default value of "Clock Divider
>> + *                     Factor" is zero, which I think is a hardware design flaw
>> + *                     and should be sync-ed with the initial value. So in
>> + *                     software we have to add a configuration item (initval)
>> + *                     to manually configure this value and use it when BIT[3]
>> + *                     is zero.
> Do you use the init clk_op for this?

I think this does not apply to init ops, because I want to configure 
some parameters here, rather than communicate with the physical clocks 
and do any special initialization work. As I explained in the comments, 
due to hardware design issues, when the clock use the IC default 
initval, we cannot read the current initval from the register, so we can 
only use the initval we configure in code as current factor value.

[......]

>> +
>> +/*
>> + * Gate clock
>> + * @hw:                        clk_hw for initialization
>> + * @id:                        used to map clk_onecell_data
>> + * @offset_enable:     offset of gate enable registers
>> + * @bit_idx:           which bit in the register controls gating of this clock
>> + */
>> +struct sg2042_gate_clock {
>> +       struct clk_hw hw;
>> +
>> +       unsigned int id;
>> +
>> +       unsigned long offset_enable;
> Usually we use a u32 or a shorter size so that the member width is
> unchanged on different CPU architecture.

OK, I find some else similar problem and will fix them altogether.

[......]

>> + * Mux clock
> Please use kernel doc. See https://docs.kernel.org/doc-guide/kernel-doc.html

Sure，I will learn and try this.

>> + * @hw:                        clk_hw for initialization
>> + * @id:                        used to map clk_onecell_data
>> + * @offset_select:     offset of mux selection registers
>> + *                     **NOTE**: MUX registers are ALL in CLOCK!
>> + * @shift:             shift of "Clock Select" in mux selection register
> Is "Clock select" actually @offset_select?

No, the "offset_select" is the offset of register, while "Clock Select" 
is the bit shift for each mux. For SG2042, every mux has two parents and 
so just one bit is enough for it to select the parent, and one register 
contains multiple bits, one for each mux.

[......]


