Return-Path: <linux-kernel+bounces-54975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443384B5BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76E91C235FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26078130AE3;
	Tue,  6 Feb 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bEBBMD7r"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2043.outbound.protection.outlook.com [40.92.103.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271A12F386;
	Tue,  6 Feb 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224263; cv=fail; b=ipv0njEoICt30wSMBsgGWG/nG8eVVnIoAPA5+ehxp9cqSru6sDeQh7L9773ZnZH+yfgOHqbeFyq+h/pqYwaliWv7h2+Q5XBXPCQ5bZAIXz0SFwM6ME6XNprjNg/9jjXgyNf69WS3I1/JQ1KRSg5q7N1N4Ngo8sUy/LHxBBGkrqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224263; c=relaxed/simple;
	bh=qWpZuNDj2ZzlzSpjyGbsOp/3FaBHvlYiqnA1GTKDrXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DA6KzEEuF1WO4GJmzGdgdN6ewc2EyBeXtRTw5cyZ1jQhyxiUwwHQxRau2DpcatlNGy7fIyVqaR3go++6Hd4GEqAiNNrWwEuBwI26FSdPkTcpwxSl0ZZLuRQTwlrYJ0384s8W2QPHKYleS60Qp2BUXVEtZC4dOaaoCCLX64ADfYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bEBBMD7r; arc=fail smtp.client-ip=40.92.103.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a46fauodscHKahpMF6uIX7wxoFLikDGVlrX8tXwl6CWElAAzwU/cVDOEjByX96pTBWK5HqwB0YilFsa9aJWzto1t9cFEhtSQiM+7wcU/cB9GgSkYKUK5HZVAhHV1V9tSy0mtWGmgarqfUiHX48ZHUG3VoeexnjDTLgfCgK6iQtQvy6GoeGrl4LM76SnBI3UM2P/HIWWX5vLQBUe+M4uooSYDozziZrNAzjE0anGhJkLqDez6LQYgQzyDH/G5wbGv+STYPsKHhCCPHuCp3oUB0VNFncjN/zhYdVcz2/g+KnuFMe0s3kdPhxOGLJfqBr2aKxY/MzKlC9F2PoB2CuWtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFTgli0Q06M8692lRLpQ/22uCcJPhpbPT5ZI82wtybc=;
 b=foQ7mhv/r2CsKQxwzuXexfAhHa10CrX8FTIu9FfFLuZ4Q1ajP5ZiOOuyazGLNbNoICOTu0KLjdEEajI9b8xcusxLdHUSwjAuevWURXkdRSIyII0fnejdYZwvnygnyoaB53vJTqDboAcLYyn8cCxPKnAIkVAUD8gxHMmNjJXMT1DNwWSyw4UEy3wiFaGEhrcYTrj1XPj49wlA/JhyRgEOnoazI8jd0UjDEADjuivqlrXCbLkwMhAtp6Vj4qBLFvOwJhscc3+r1QphHyP3mMTNzjZo3hNle9RdFJcQidXNBYPPdqIvFYDk8GsXwx+Ha3rAj8RpCk0T6jInzVnXSar6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFTgli0Q06M8692lRLpQ/22uCcJPhpbPT5ZI82wtybc=;
 b=bEBBMD7rHC5ZAieIF5jWaCFKHzkIvLj4aZRVTyu2gIY18LGMya8qYyZovhd8BTb01GoFVgSwEKTRnVn0Qwe3O69yvfE4V4Xirwi4fooGXlmQNgmXDvW8Dh8/SdE+4xcEFDqZ4gyVmE/lb/tRhxwSC6UNpbXr82dtAcAGlkmT41T9KR/pcUPIUT/ggQw4g8pDyS7xxAIUYYI81Ymg+w99qo28+phNmhKDnc6JpU0jMp9UZxqBfKiWACW767q32oqYpXxJWnT0Mql2s4HNhaiQURKOgmv+S1NJCU8wHnyPN2lQW0Y6ap+8oj5vhrhA78UzgIfcHSIm3uTK+GODS7vs5w==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB2086.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1cd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 12:57:32 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd%2]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 12:57:32 +0000
Message-ID:
 <MA0P287MB2822C8930916B90A9C1BAA49FE462@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 6 Feb 2024 20:57:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] dt-bindings: clock: sophgo: add RP gate clocks for
 SG2042
To: Rob Herring <robh@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 sboyd@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1706854074.git.unicorn_wang@outlook.com>
 <fcdd83addcd9af159a0bebf2a14543168bd59a07.1706854074.git.unicorn_wang@outlook.com>
 <20240205172422.GA3643653-robh@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240205172422.GA3643653-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [q9PRw6FclFsW5rl+vuv4cnHs1xWmWZul]
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0c5ada0e-5433-4f82-af53-1eab6a3c9e5f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB2086:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a4a3f6-2850-4eed-6ce7-08dc27132ec2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cE4UKiZwy8Tv09dcvIyZqZR6/DiCESy9IVduffq5M31rVYI31seivlzS2C9Ay9cdbiGQGeiNbLR40WSbz5qks2zQb94MPVCBnWjD3BG5JlDvFNXxIA5vCmmNplBfj/73/IuVZVc3NBbfJ7sgRjJLvCSjmbNfvthWDZJ06aGtAd9Rgi7DDcgepBa1bjhy/bO6sR2NFppg1RhD5X8wRbBaBRJH2Erv4UBKb4S+liy/md3F8bdIMISygtD58Kj5ssnWoQQZGCLPIJDBtJcnw+CNVU7vfBdzpJ4BWwjLDJ7e8pmfJTSF9cPcTmDvaWeptPMyZYXNQ4/MlsUduMiDuzWI7kTED6iLUKCREoQJcL5O9sg20pXwKZHMe6BNjGj+9FCeS2ZKaJMquBk5AD1w3hfEfljJSeftXefyAbPMvbcTofgIx2w0iLOIzmOWd2/aJJ2xyClOCDwNpvZp8q1pGbihPtI7vSVoaISrXOZKv8yxo6kdTit1dBRELShvE0RJoVNTqKiuFKwTXV2ra59FRDX9mCjihySLKjqeo5xvR/aBjG8k4wOHN6MpZsvYR6K6AtAhHG0l1ImQvwtBn7dUi16o2Gk+449bhjqFmG/t20/SsEQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZqUTF3MitPeVFxMGd0MjZzR2lpd2pHd0EyTkNaaFBnWFQrQlBCck1la1hR?=
 =?utf-8?B?enBaa0UyYmFqU2RYM1cvNVR1UmpIdkdhY0dVditBMiszamFNWGU1c2x6MFFT?=
 =?utf-8?B?dEdjSWFzNVk3UjhBYit1bU1ZZEJNditpbzk3TWVQRUFvVmZZSThsNFhGeHJJ?=
 =?utf-8?B?ME9la0xzN01MY2laWmJJeERsejRYc0JyOVRSUGhyRDFrWHNNWHl1WXRsV0lU?=
 =?utf-8?B?aS9UZlFka0FJRUNBcUVmaTg3aDY1aUNsS1VIRXJ1M3RiL0lUUGRZS3hmcDh3?=
 =?utf-8?B?VUc3TWlVUlNyUUg3QjhVRjVaTnUzMWIvV3hYZzVJSEVOQmlDSDBqVXQ3eGVH?=
 =?utf-8?B?OVFqa3FCK1NwK2Z4eS8rK1VDWE4vWitlUDJ4L3lHMVUyZjNWS2orK1V5ODUw?=
 =?utf-8?B?dlZYamhZV3owQU9HZHlBS3hWYWliZkg5YlQyREhWd2RFV0l5TzkrVVQvbEh5?=
 =?utf-8?B?SnU3L1lDOSs2bllwN0dZTWhuellyVHNKOGR1WnIvdDZHdzVacVVhMDJ0eXdN?=
 =?utf-8?B?czFGY3Q0YWFTNVRvZFRIUHBzRzVad1Z5N21oT0tVTEhUTlBpNDhTT3o2Ty9I?=
 =?utf-8?B?YkxwN29NRGltWWFHaWZyb2JqNzl0ZERTbEMweFhtYnc5eEplTjhOdXpiNjR3?=
 =?utf-8?B?ZUdiMmVDclB1djdSNDNKVTdlSW52cFdpOHV3c3dPMGdLNVl2c0RvME51OVNW?=
 =?utf-8?B?NmNRTjZUbW1ScG1mTG04M0RmZDZEWWEzc0Jtb1dyejd4MTZSR0QvVFJHeXM3?=
 =?utf-8?B?OGNwSFYrVG83RFJ1NGpZc2F1RDIzek9kNkVuSDZvc3B4d1lKMkZhZU82Sk9J?=
 =?utf-8?B?UFRFbTZPeWlPNWlVQWZxZ0J4VndwbE9OT1N5NFRML09GZEQ4T2dMRjdIT3hZ?=
 =?utf-8?B?S0JLTmNkQ2wwa2w0ak9Uam5MVlNrUE50ZldYZDNFall5aDdJWWU4YUIxSVBj?=
 =?utf-8?B?dS90c0s1TEp0MDVvczVzWlh6bURQTmFDaGpWMzVJa2NMRjZ6N3hSK1A5Skd0?=
 =?utf-8?B?eFdZakkzbWlPU1RmbWIrVnJoamcycHBCNDloaTQ3TTFxbG05bzRUbnRYVGZ5?=
 =?utf-8?B?aFNDbllYMWNqcFlORjdqb0orZDlkWUNIV2NyVjV1R0JWSGZsbEdvUGF2blhC?=
 =?utf-8?B?aUJqTzE3SHYzbzk3MnZ5ZEpWb29ZUHptUjRRZU1uQ2MwQUJZRStmWEFQenJU?=
 =?utf-8?B?UWxxK2pKRXNJMjdNNUFVRldhMjRSaUUwZzdZSjVDRy8wdlN1c3YwWEtRazJ2?=
 =?utf-8?B?Q0oyY2tMY3ZYTW1CK1N6c2VUaWovNE1NcTlER2ZOVXJuWTlyVzdhczc4TTA5?=
 =?utf-8?B?NExOSWkwSHMzbjFJNWZ1QlBxMGN5dkNreXA1U3N2eVc4V1RzYWRFYjdQMUh6?=
 =?utf-8?B?Ty9DWlBsL3k5NUE1MTIrVCsvZkZOUXNhN0R0MWxzVUsySjhRT0R2WkF0THpK?=
 =?utf-8?B?K1hpc0VVa08vdDdpK24xUmdaMCs4bGZOcG1XMXRpS082bXl4ZGRhMDF5dno1?=
 =?utf-8?B?OGlKMi9iOU5nNHNTMXZ0dStKYWNTYXFYY3hkeEQ2WnR3MitJV3ErYXhKS2Rw?=
 =?utf-8?B?WnR1RXVGdFVVVk1NNjVRQ1hHamJValBkNEVrdUJuV0FVeXRUYlhJM0l5eklS?=
 =?utf-8?Q?zOBrcy+7/Spdq7TZfIXfhSX0upuStvWZt8ehU1uf6UCw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a4a3f6-2850-4eed-6ce7-08dc27132ec2
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:57:32.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2086


On 2024/2/6 1:24, Rob Herring wrote:
> On Fri, Feb 02, 2024 at 02:42:02PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 37 ++++++++++++
>>   .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
>>   2 files changed, 95 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>> new file mode 100644
>> index 000000000000..69ce3a64f66c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/sophgo,sg2042-rpgate.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 Gate Clock Generator for RP(riscv processors) subsystem
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-rpgate
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +    description:
>> +      See <dt-bindings/clock/sophgo,sg2042-rpgate.h> for valid indices.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller@10000000 {
>> +      compatible = "sophgo,sg2042-rpgate";
>> +      reg = <0x10000000 0x10000>;
>> +      #clock-cells = <1>;
> No input clocks?

I think it should have some input, I will add it, thanks.

BTW,  can we ignore this property if driver doesn't use it？ In other 
words, do we have to add this clocks property just to indicate that this 
node requires some clocks as input from a hardware perspective?

>
>> +    };
>> diff --git a/include/dt-bindings/clock/sophgo,sg2042-rpgate.h b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
>> new file mode 100644
>> index 000000000000..8b4522d5f559
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>> +/*
>> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
>> +#define __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
>> +
>> +#define GATE_CLK_RXU0			0
>> +#define GATE_CLK_RXU1			1
>> +#define GATE_CLK_RXU2			2
>> +#define GATE_CLK_RXU3			3
>> +#define GATE_CLK_RXU4			4
>> +#define GATE_CLK_RXU5			5
>> +#define GATE_CLK_RXU6			6
>> +#define GATE_CLK_RXU7			7
>> +#define GATE_CLK_RXU8			8
>> +#define GATE_CLK_RXU9			9
>> +#define GATE_CLK_RXU10			10
>> +#define GATE_CLK_RXU11			11
>> +#define GATE_CLK_RXU12			12
>> +#define GATE_CLK_RXU13			13
>> +#define GATE_CLK_RXU14			14
>> +#define GATE_CLK_RXU15			15
>> +#define GATE_CLK_RXU16			16
>> +#define GATE_CLK_RXU17			17
>> +#define GATE_CLK_RXU18			18
>> +#define GATE_CLK_RXU19			19
>> +#define GATE_CLK_RXU20			20
>> +#define GATE_CLK_RXU21			21
>> +#define GATE_CLK_RXU22			22
>> +#define GATE_CLK_RXU23			23
>> +#define GATE_CLK_RXU24			24
>> +#define GATE_CLK_RXU25			25
>> +#define GATE_CLK_RXU26			26
>> +#define GATE_CLK_RXU27			27
>> +#define GATE_CLK_RXU28			28
>> +#define GATE_CLK_RXU29			29
>> +#define GATE_CLK_RXU30			30
>> +#define GATE_CLK_RXU31			31
>> +#define GATE_CLK_MP0			32
>> +#define GATE_CLK_MP1			33
>> +#define GATE_CLK_MP2			34
>> +#define GATE_CLK_MP3			35
>> +#define GATE_CLK_MP4			36
>> +#define GATE_CLK_MP5			37
>> +#define GATE_CLK_MP6			38
>> +#define GATE_CLK_MP7			39
>> +#define GATE_CLK_MP8			40
>> +#define GATE_CLK_MP9			41
>> +#define GATE_CLK_MP10			42
>> +#define GATE_CLK_MP11			43
>> +#define GATE_CLK_MP12			44
>> +#define GATE_CLK_MP13			45
>> +#define GATE_CLK_MP14			46
>> +#define GATE_CLK_MP15			47
>> +
>> +#endif /* __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__ */
>> -- 
>> 2.25.1
>>

