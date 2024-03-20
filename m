Return-Path: <linux-kernel+bounces-108730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E49880F47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51B21C20A02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8313C460;
	Wed, 20 Mar 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Dpe2v3It"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148883BBDF;
	Wed, 20 Mar 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929213; cv=fail; b=PCqMTGD+aR4fjH+JGGzQpKarN6OySsZIZ1T+JbnvYF1GjrWALk0rETNrLireb/oQ54kSGtUF7vU4g//DRGnRZUCjU74jv8ylqNA+5I8axN0+2Vsr/kFtrcqyKUxcpCt2UgCuWa7B7SWdWavlPfmG7Nm/2X5Q9N9ngILwvDA9m9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929213; c=relaxed/simple;
	bh=QbC53fgaKWDLTnJ+WNQQOeEYpMQ7Y75GTOyr844QsII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=baNcLPbIg2WWxdQOYzeTlglbk/YLSKCxA/hV4v+CYZgUNknnwxzC7Z+Uq6h1j6ugPoIHO7+ISjmAmhx4B2iCuMNx6cZ3uoxsgz3E4B+nJRLN1ZGSwhk2Rybt68G01r0dvaPyEcCVP4OW2rcHbJhxVOXtNBdozwpkxcfSGIEMUWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Dpe2v3It; arc=fail smtp.client-ip=40.107.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5irJj7eOzBGcZ9Bvpk54sD5x6NEyTBjlEjJSTtcy8ouuTuLyv97BaXYlMIp9fsNkLRJf/Zh19Wy644buG2viDoDmB5AZFM9dXjNOXBJMiEjykT7k/fHdjRJ5D064Zh68BT5Y6Wg55LOsahMmA9GwdUM7t9UaUTReMMWFh1u4estH50YMBLd4l8rUOHQk2TdPQZVU3VG6yWUYMHaJ83BHQG9PINajaH/lYOK6SFOvARKbQYcbjwD9F5CnFPA457q1JDjCcoXCw2nsNWbYE5RrtGPtpLCTJOrCa2KhI11xK3B+55M+yEt4x6rn9oAiL0/u7Anmd7I+6fO3Lceq7WvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY38dtJ0GvCdOFqOFgZBAa4RdxjJ8sGerA7n7v+LjYY=;
 b=QvfKtOn15gOUxNI7SnyuI5BOjOaOSOASYZwXnoG+Fd8VELDlx8p7QsOViXvbg/2wjX+CUrnLEPXIgNmDlTXNXpzVknmn9AbDMhVoU9m+ki2s+vgP94G0GOkDDXr29kGD/ZLQOMvvjJVC3OAMKRTaYECRFl/g7PJxEUgInIvOJ9wUWBeaQIX7jXT5w1pQws/28u3MXl849u8PKeK+7dsXeeNuPhpT54WW0rGKbI1bALoQmmCzlUCn6ukW3dCVFJQkOcL3/3CIMVZ3lD92DXKoZkBukb3JUpai2X7mNqkZ7bPtJHMpJ8MIvD3IE1Drk3jYxBerr3ltgbAF6IHvMC0Pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY38dtJ0GvCdOFqOFgZBAa4RdxjJ8sGerA7n7v+LjYY=;
 b=Dpe2v3Itvn1CHsEMcr4InXaTtvFn6rWM43aCTAdVrdSOYN1BmAhkcq4m+Ml8BtYwZ3eIXIT+p8rxMC665Px0OIf2iWBr/62ilM2CGh9O7cNLqSNHSUf4ANHTodrj08vMEPNEYS2AgXgrjpewD/rrmXG7CPdd+hPiZ4SnfrLH2aHfqFFbitg4yCqOwPlJ+jzx/mSbqvvc8kjVpVqC86/hk4fOO0O9bkPQgs1qURA3GYdH3dH2+mddYxwSRXx40NDwWsz50AuYEwsLAJgo/WqO1ruYPTtoYTylGsJ+MZxShWiPBsl2QZftoS0drHptcbyA53vKE/5bvf1cXHJmzmQMtQ==
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com (2603:1096:301:100::7)
 by OS8PR03MB9007.apcprd03.prod.outlook.com (2603:1096:604:2b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 10:06:48 +0000
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::c706:407:1c6b:ab17]) by PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::c706:407:1c6b:ab17%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 10:06:48 +0000
Message-ID: <5143565f-2865-4d3a-a848-7aa700fa26d4@amlogic.com>
Date: Wed, 20 Mar 2024 18:06:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: add support for A4 based Amlogic BA400
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
 <20240320-basic_dt-v2-4-681ecfb23baf@amlogic.com>
 <f0050b33-c4fb-4263-aee6-4542e2be39e8@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <f0050b33-c4fb-4263-aee6-4542e2be39e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0331.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::10) To PUZPR03MB6888.apcprd03.prod.outlook.com
 (2603:1096:301:100::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB6888:EE_|OS8PR03MB9007:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6gl+0eNpIdPpB0qQTgJvZj1NqV19OHfPdmxmrVBVLnsmFUO+fQtcym2bymRDDKNzssCSZPnVpzRIBs3JSj4qMvDGkqXhRZ4L3yhC+cN0MFM5oTRL7Wg+YM4bg36oROfjLPFH01LHjKU5ly/Dd8XjbW1AehHwV3FZByvkJ6hNrE5qOcpZwqDYq79V7eorpp/STdagLl/WB2kbvw8KDKX3WPhg/s5zmd04TicXYTy1ZpZ4vgzCjPI+pOVTuBGOqM6bwXxlLpVThZdqW+y2v4afg36OApHP6Ko1eL3bdw/DKWhHr/BS7woxiD6WCdDpJe9aqfvDcTS1uBn8Swqjyor4PyQqf/5VdjlDUQDtRvvFFEOZQ68zOKUFUnD7WnFe57UK3TCqov1DE4sJaHdptFXpvcZSnVeG8UyTw62yRjqkquk539mh1cPmL+IQoDHVDVzNgZzseUJGW3uRjYmDUXJ/qSx+j/H1/P/pDoefKUUWe/Omi4QjP2bd/ZsfzL8bHdLh5e17Q2kUwcoYSCoZnWgJtrH9NfuEcKSbZ2n1p85f5xRBIfhSXX6EA5oyPyX8Mn6V4ASfWS4RBnh0XZ5XW3YMEpPby8nnUcMcH59As8aCTeaVJRW3rC9Qqi+yR/E+F+EmpmHHfsOYYWb3mCwU+8rSMHZebS5+MJX5Z+kIjM3dku2Hd8kPnVA8kecehK5bL53GP/Wv0FLrMH035nXmVQJX9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytTeUJrTFdiVGxQdUlxb29sWTlTM2lWb2c0VE1mUzFSS0duejNSNnJuZDB3?=
 =?utf-8?B?MkoyVU96dWJnOWRXN3VNeCtUbHhiMTdSWi9JSVQybDZmZG91MzVDSXRxU3VP?=
 =?utf-8?B?QjdyUTdFck52Y2FUMitoS0FWb25aQUJDWkoweUNLNUpYSHNWQlo1elN4c0ps?=
 =?utf-8?B?K1BsalMyUmV3eXJXZG5MNDloMlJFWE9ISXdjVGFKZjJ2VTJVOGprR1ZwNkgv?=
 =?utf-8?B?NWR4RjB5NStmdUEzbmxHOTZUSzBwNEIzb1V0VENwL0pEVFRUNUNKZCtEeG5w?=
 =?utf-8?B?UEVPRWlFcnpyKzd2VHQ2MWV3c2VVRDR3ZlVjMEZPZEhDczRUd2hyZW5lbGVY?=
 =?utf-8?B?MENkMEF5UjJxTnJHUERaS2kxKzNuRDlNeHVtMjlFcVZOOVR4VXpPOFkraFFk?=
 =?utf-8?B?QWV5WWgvR1I4VkNxRU80M0UwUnVjcXdCYlV4ZjRxTERPWHZUdldnMEZwZXZv?=
 =?utf-8?B?bThNQlhPWXhDUS8yRkFUU3h2cmNuOHYyWXU4V3dTWFpUS0dDWG8xN0N5NFhO?=
 =?utf-8?B?aUVXQXRoNXFweEt4RTJWR291UERzSmNxa1lrbXJlYlhVT0Vzek5iL3IrYXFW?=
 =?utf-8?B?QVdvbkJKOG4rT3VuZzhFc3N2WGZTdjhUOVB4WDdtdVF4OHZBRTRlaEYwMlVo?=
 =?utf-8?B?Umcza09YaWJrRXA0SHpvNWE4ZjNNRG9ubzdvMmFiRksyWXhGblFHQnBka0ZF?=
 =?utf-8?B?RWloNWNQWDkrUzZwc3JvbENMNXl3dEtoMjVuSjN3NWN0T2NoeHFkQjIxYkdn?=
 =?utf-8?B?enhqNE1ZWlEyRXA5dHhTNitBb1FVTTNmYzZiK3NuQ3k1NmVuSUVDbzFEUlVw?=
 =?utf-8?B?LzRJNUxVdHdETUJSSW1zNFhRNldhWmhmMjJmYjBNL2FBenVDVDZUK2NjVmFw?=
 =?utf-8?B?WEJ2VVg3Z294aXltMldQZW5wb1ZEZGtWQjdoVUlGQkdMSzcvUktsOHkvS3k5?=
 =?utf-8?B?N3Y3cjJ1Rnd0dnBDNHBaejdRSk9ENmVBd2Z6VXZ0VXlIbjZhZGdMckduRkhq?=
 =?utf-8?B?cHRjSUZ1V242dFhOVE91THJCUWUwT1o1bG9vSU9CL0drTXR2ZmlQLzdpMUZV?=
 =?utf-8?B?TVJCUUFGNHZqblNBRFpqMkpLQnBockhEQm1wZXRzWEdSWjFZY1dlYytpWGl2?=
 =?utf-8?B?QXN4R1R6WGZyMVVKYktadDF2eW53Q1N0by9vZEg5bTlWb04rWTRybHZCR01z?=
 =?utf-8?B?NWlwQTFJRWk0ZVVZK1RwdjNtSjFlY3RuaUNaeDhYOUh6dkhYcHQ1K2crbzdI?=
 =?utf-8?B?UExuSm9nanhlR0ZWeDdORlJ1TzB1VloyRHE1czNPN0hsUHZHTmFkMVY0bFVF?=
 =?utf-8?B?cG9OcE1aOExKbFBnZ0lEK1BLYU1EWStzN0JjanVnYzRkZk5oeExTYmFucmtr?=
 =?utf-8?B?Rkg1Y3EzVTlZVWRVUHFyLytzelhTcnNYdEl3bmFiNUprYkJoNlNMc3Y5SUhT?=
 =?utf-8?B?WHhVN3dSYnBmY1VPUktObk9zc0FUY3VqRUo1aVJHT1dBclRaMDJhVXhxRFQz?=
 =?utf-8?B?K3U2dGZMOVlKTkpTZk1LcC96cGhQU0VoekpKeGxDVVdjZnZqWTg0TytXRGlm?=
 =?utf-8?B?ZjF0WXJNdGVRNUdKSlpXNWRqYThDeHMwUEJhY2FINW5YYlM3aEUyUTFiVWEy?=
 =?utf-8?B?VE9sV1cxc29PT2I3blNJOFJ5Ny95czRUNVkzSGlkZUpIbVU3OWs4amNoaU82?=
 =?utf-8?B?WWh4ODRTUTA2a3NyUkR4TDd3bFFKcnRsbDFxR3pvM1c0N3p6aThTeEl6OHps?=
 =?utf-8?B?ZGJNQ0U2RDNDKzlDdUR4Z2N1TWlqN2t4clFxMGJHdVh3MGU2RG9ZMXhNTlJH?=
 =?utf-8?B?SHA0TUdMS2doNmNSUVoyOVpkL0pvYXA2ZEx3V05odDIzLzBGQUNBbkFWcEJ4?=
 =?utf-8?B?bWxRZzNRT21hZWxGMmt4OFRCaHBaOGo0WDFhbG1iWU5zTC9BeG5Wb1UxV1pO?=
 =?utf-8?B?Zjg3aVIzZVY1dHpGd09yS1hFanpNaW13dGhDK0VUeWY0c2QxSURnYWlQc2Mr?=
 =?utf-8?B?ejlBc1JTY3NhTlowWGRxN1o5SmxTeU0rdW1oK1NxNDNTYVpKMWVOc3kvSzlu?=
 =?utf-8?B?cFJwakZTUDNMZUpVR0ZuOE55SUpkN3pFVkRmOS9TUkRBdVBCUW5EUjRaZUh3?=
 =?utf-8?B?SytHWHlhdE1OWHZueG11ckZ3RFZUeXJtRTk5MTYrT3ZxQWlVOUlnY3dKMHNJ?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f03aaf-4f63-4601-93cb-08dc48c574d2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 10:06:48.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G96d2r3vIJBHw1zTrvey1aI4VNpbxsIKKKV+NTzdUllgvRLH6x0PURyMTLIO4tMaFpne863re2fApmydzR5LLH2niLQ4E1YQQn6YwarkPxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB9007

Hi Krzysztof,
     Thanks for your reply.

On 2024/3/20 17:48, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 20/03/2024 10:44, Xianwei Zhao via B4 Relay wrote:
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
>>   .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   | 42 ++++++++++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 66 ++++++++++++++++++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 40 +++++++++++++
>>   4 files changed, 149 insertions(+)
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
>> index 000000000000..43a9c666e1de
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
>> @@ -0,0 +1,42 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "amlogic-a4.dtsi"
>> +
>> +/ {
>> +     model = "Amlogic A113L2 ba400 Development Board";
>> +     compatible = "amlogic,ba400","amlogic,a4";
> 
> Still missing space.
> 
> You received comment about this. Fix entire file, not just one occurrence.
> 
Will fix. I got it.
> 
> Best regards,
> Krzysztof
> 

