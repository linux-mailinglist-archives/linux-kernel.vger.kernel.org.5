Return-Path: <linux-kernel+bounces-108788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC0880FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D20281CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211023BBC8;
	Wed, 20 Mar 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="k7cuBN/J"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272AE3B295;
	Wed, 20 Mar 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930681; cv=fail; b=rf7w+TU+npJWb+0g3R2M2Bt3K/dmNHF9LY689Jl7m9VML0SVRKG2bomsdGKtiTL0O9Li80CLrHCK/HW7q7sc+QizGkz1p06CyP1X5LGzh8QJmj9v5jd/r/7Ld0b4VTmwhxryHXUW5tw74esfWr0kM9FA6tLCxr6tbUxJmHvVUDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930681; c=relaxed/simple;
	bh=8N7TU4+oFb3uuGVhZxzb6azR2wTqBYF/biVUILdZIGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SO4/xCU5ZeaQ2szPbFfUc5W24d1Yvu1U8cBlmJODxwlJXlvPqmNwjTSJ1HAslr8zmLIn+mRhvY0M4rPjALuyWAP2qAKvIcrXH05ArglwNcsn9xPPVz819CCf9nHjJdF58uXrV4lci56wp+2JmdFmNZKIadPFe5v2tfp56teCH6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=k7cuBN/J; arc=fail smtp.client-ip=40.107.255.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7WzHRpp5f/jk5noUjmz2Qwn9m+oA7AP1pySyBPlKcSVIEgl8Jyf6YxE/FeRrGgfTf7E6y4B+l1q3+zDsKRs7inDuq3Kw+TKxqAX+XLJH2RGUWnqy0NB8KfhbW4aIFPqVBDVO8STC+GQoQIZUjDX0IUQllHT/CtINNr8lysjmOwWoAOxB2WEqwndnXBfa5tCjhunTQMG1EHC4IIVoJKnhiRnivVf2RO2BZcDibLIlwgIgBsgKBrDl+8w2I0DbyQGKZWImbwi0LsmWM6HRgttM4PDLRTCCNnuoTvwTAklMmnyninVNzgSqeJnxbWmyYb2gAaR7nDtyNdhBYzHzqhemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu1cBagnkADW1tA2e0AwlvvseAJxb7FS07hoch/fUg8=;
 b=lKfoB2GjSdndo+0TV6dxvf3M1/cnYtXR2C7bvlOFM60sqyOZpFQOI7vkE6BPY7s+8of++vBDg+EcTMettPQ/1u9vJwYh9eyC5X8TdFWxCleuYaPtQ3+S4ATiY5XzfhjnGmHzlhPj8rV56BcV8U+hSHa3oUyMZ+Qce+2jYKByULGgMBQeHPzmBy45lbf4RZEWpZUMrRm3orB/8E+NMPPSR+dq5FmEHaSPX6riNfR+nF8MkilMeS1uitxiD0dcONTRINk1dxiWpyJRuTDci8NgX6xtOEnWMpxfjEq/m+MofogzRY4ZhCrq+kZbGMqkjbiaIrlSCawVvaUFOWF57BN2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu1cBagnkADW1tA2e0AwlvvseAJxb7FS07hoch/fUg8=;
 b=k7cuBN/JlcKW1exm5TYwtYzQHYEcHCE71TYyUV7xDh1EiC+y+Ue3+IYCBsD6HdOubjagznBLH5fFZaxsVAEx8ZkK74NS6SDWOfPcLP1XazLZ4b/f6ws0JTOWDJjNR3f17h5MH4DEUNcsxCPB79U9V5AVGV3E8lJ4eUZsoB4RKdZ5LOUgmBZmc4b5aJRqXI4hAhYN21y9YgtOBgPFM5uhKK9l13cOgyCZPCBEvQfGNhbcFvYaH80sb2/UVtKg7YUrlrLFoBCIxbtzIYQj0ThAa5VNLf+KIJcglcVqrePZdwGt57vyzuYAQbfSFAH8wJPK/UHAQcjhJ+HLuNjeAxy4vg==
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by OS8PR03MB8961.apcprd03.prod.outlook.com (2603:1096:604:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 10:31:15 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::441:dcac:7f28:9660]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::441:dcac:7f28:9660%4]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 10:31:15 +0000
Message-ID: <cc86991d-1c8c-4d49-bdf2-a8d451ddd039@amlogic.com>
Date: Wed, 20 Mar 2024 18:31:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: add support for A5 based Amlogic AV400
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
 <20240320-basic_dt-v2-5-681ecfb23baf@amlogic.com>
 <98b3fb64-2256-4280-bbfd-c944e5df829b@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <98b3fb64-2256-4280-bbfd-c944e5df829b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|OS8PR03MB8961:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fCbqENdr4sPy4MyZ7/quuH26d53bB055Wv1RmF0rPK+dnlUbmx7KyKCNkqiN1QZ56t1sLXgTbZfW68giSTsOX5EckCVC4wbNVcrrOSocjd+zzL6XCgJyWHVe3nlhcxLAi+j7c567FK2vJw4KPotXc1aC48x+kgaqZpWu//PaPoSRiG28Ttu7JSUQbKSuU5FpEdjSA8ZJ0GeihncsHrhQZNjKBg8r5wzwFfI/BWpZ+RAx2QxI6aYrlsCzd4Wkipj56EQ4pngyhR7go/lxlKwZHzwbT0vNFJfYWa0peOJGR+TxtAuQQ0USbc27ockmXc8F2ogKWbBJiQoclOWhrz2zfu189LHUGaKxMOLyYS8i40zRH8wqE4fHw+EGyPi9ygVal6kxGMkwOjyVhIAXd/M2Es7cYV7DuQDySRinCdjdUG/rPuNluN3P+SWL8/CaltlWnS6dqA7HUnSYBi78oKI6nrQcbMDEdJkhmCh1zql+aWozbl34J8b+vE11CqIm2bdfLe/NpHhISnoVV6hkGPV3VVEBWBM+YyIew2mmSasUiXRZalHOTe85VlE3DrKwaFJ6QeQQSHhBN7lZDYoIHSZrvpyzUg4T4c45Dr/51LZPmyC9X1I7HkODMf1/HpVhifvvDd8kjqXw6ib8ZBnHsaT4HIDSx55jkEl5nw+X391pwevrtPcsYcQxS4NfxOKpU/dMcyKPJbqybtFupviMvB5jmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU1EcFVLazFyYTIwa1E0K2NOdWppUlV2RzBoTUdEZk5Xd3Z5ajFwaDN6RStq?=
 =?utf-8?B?bFQ4WEZxbitNdHNFS3l5Wkt3c0dBR3lZWTgwMlI0SDEvYmpkV0FVMEwrenNI?=
 =?utf-8?B?VVg5SExBVU9KU2xEN0Q0SnhSMlowZnM5aFJWdEt6RGVISEV5TnZ0TFR5QTZn?=
 =?utf-8?B?aHpKSDZnWjZvdWQzSFlQRmFFN2swSUtQVU9KMEo0NnJaYXpVRlo5Y1pMRVdI?=
 =?utf-8?B?alBNdWsxM1VqRzF1RklwNUdQWDN5ZUx3bE9ocXVFeUtkZGY5QXowZnRrTHpG?=
 =?utf-8?B?eFJiRVk2aU1DT1JYcnp3TllWTWEzUHo1bG9Eejc3WHpON0QyZ0lKbHZaKzVw?=
 =?utf-8?B?Qnc5eVI1cXV5S0ZNZThNRTNFRFYycHRrcysyOGxONXVBNzA1NTQyT0tSNjZG?=
 =?utf-8?B?SkF5U09YV1ROdW51aHJId1hVcm00SXF0WnhyM0ptL0puQWVwQUJLWFVIekY5?=
 =?utf-8?B?clM4TGNGc3h3WVZYREVHeWdyWThaQ0E0bTljM0g5Q1NOaFI2cnFEaHl1UE9M?=
 =?utf-8?B?ZTFHOUxvZTBZVFVDUWxNT1RRdi9MbVB5T2YxRmc1aWlzTEtDRVNOSXZieWxW?=
 =?utf-8?B?TnBEalVBa05VS2JMazkxNGFGK3l0SmlCbGhTL3A4L2ZyWEwxS09uYnhrUm1O?=
 =?utf-8?B?U0ZmUENBM3ZGMmRpOWFYNjUxYS81dVhGZ1JQeXpKd3ZYMVJET0ZHa25rVHp1?=
 =?utf-8?B?azFPcll6SWV5Y05rZmgyc2s2NmlEWWVSa0xheVVlVnZ0TkFyeWpBTkNVZ0dJ?=
 =?utf-8?B?bEtxQXM1NEp0b0R5anJMY09zL0ZRWXo1Z25yaVF2aVphTUlGc25PR0NGZkNx?=
 =?utf-8?B?dWw5Ry9pTUpxdFoyTXZZN2gyTmE0TFJ3YmxVUDRFMGhvRlVsL1E0S0kwSzht?=
 =?utf-8?B?YmJLWTRwVXZIS2JhNDN5Vk9CTk5JRUE2OE1vaXUzUHNOSjZ1Mi9DMFBIMWJB?=
 =?utf-8?B?OVZ2NU5NNElPN2xiNjBHL2NQZ0V6VW5lNVZLd3dXYnh5UjVPTmRmSWNlekx0?=
 =?utf-8?B?WEFKOUN5R1l4Ty8xK21vK2NYWXJvVGVGZUdodUVYK2UwZGJna2xNdDY0RXFz?=
 =?utf-8?B?SWswOXJCMDFLLzFUa1BYcWk0ajBOU3VkN2dVRjc1TnZzWGJKL3liMmJwbFEr?=
 =?utf-8?B?YlVhcFFnalJVM2xzQnFBaFAvVXYxRk5ndExKN3dpWW92blJQNXNVWERMTnRp?=
 =?utf-8?B?WUY4YTlLTy9WZWRWWnQ5cW0rMUo3SkFIZHk3UXhCVnE5ZkorSGlNc1ZrUmZK?=
 =?utf-8?B?WkkxV1BkMnB2Qm5TcGtjcXAvdEtFVU9CZ05NZnpHbVhUWkxaTmdkaDV3OEtU?=
 =?utf-8?B?aStuUnVPL2JXQlJ6WmFEeldUUXdtRjlJeVY5UDhJZzVJVWsybFo4dFdjZE04?=
 =?utf-8?B?U0hlWkVycDNuQUh4MHlERjlMcTFmN3FiMjVPUHNuOVRWTStsZ293aVVFdUNy?=
 =?utf-8?B?K05pRnZRSnNBTVd1N3VFbllZVkF3aXYvQmRTMjYyKy8wWVBGR2p2R1pFYVpt?=
 =?utf-8?B?eUVGc2lvdkpSeGN4Z0VpKzhLSWpoTmRTQmZDMkZEYXdqN3dhRHZoZ0FiNHps?=
 =?utf-8?B?T1BOSG9rZC8vUi9YUWFiUllLeGxuZGk0dTk5cEV4WlBOaDUzWUU5UG0xQ1hh?=
 =?utf-8?B?TS9YRHFFaXUzNk5CbWZ0aEM5bndqMlRuM25BZlBpT2lHai9IdWVuTmd4M3hW?=
 =?utf-8?B?M0xXMmVpT1hxR1VIb3ZGTVlsYXBRVnNHUXpkMHk1QXhQNVR5Wit6YXFpT3d5?=
 =?utf-8?B?cTdOREh2UEREejN4N0pWZzF3RzZzc0NkTVlxTU9jTWFkOElEcXhuTUNXeEIv?=
 =?utf-8?B?VVZJSUpSYjVBU1NtbURnSFNLYk1MWEhkVWJHMmpHcEFKcENxbWZYam5mUFBp?=
 =?utf-8?B?ZjJGRXIrZXF4MTJRcGViNU1lZytQNVcrbVdmRkdiVk12N0ZSSHRPWmI5Wm5D?=
 =?utf-8?B?TVkxSnVhd216M3p3UkduWnBHVklUU0V5cncyZDJ2b3A0eFgrSFpodkl5aE9u?=
 =?utf-8?B?VFdmaHl2dVhqY0JicHdtRk4xMlc5OC9xekp0Mmx5Yk5mVWVkUFBVTXV6TjJk?=
 =?utf-8?B?NmxOazR5VXE5WXBSNVZYTmd2WW1CRjk0NkphVE9EeHNGS0E1c2MvRzhTNUdx?=
 =?utf-8?B?QmNFM2lOaExJd1JQd0JpS1dwa0txK1Y3clZ1WDlYdlFNK2JGOEg5SmlsWXFM?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e8a00b-23eb-4dc0-b06a-08dc48c8def7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 10:31:15.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQofdM3H0aB/nbltQfmo53iud2nCyOjQ6Q9/sUL9LM1vDhBIU82p5WDtq3aYp/IB8YPZza+DZIFBreXkKBM3kdIyaLV+4psZ6xfjNpCBk0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8961

Hi Krzysztof,
     Thanks for your reply.

On 2024/3/20 17:48, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 20/03/2024 10:44, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Amlogic A5 is an application processor designed for smart audio
>> and IoT applications.
>>
>> Add basic support for the A5 based Amlogic AV400 board, which describes
>> the following components: CPU, GIC, IRQ, Timer and UART.
>> These are capable of booting up into the serial console.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>>   .../boot/dts/amlogic/amlogic-a5-a113x2-av400.dts   | 42 ++++++++++++++++++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 40 +++++++++++++++++++++
>>   3 files changed, 83 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index 9a50ec11bb8d..154c9efb26e4 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-a5-a113x2-av400.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts b/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts
>> new file mode 100644
>> index 000000000000..2f5f5ea74bc9
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts
>> @@ -0,0 +1,42 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "amlogic-a5.dtsi"
>> +
>> +/ {
>> +     model = "Amlogic A113X2 av400 Development Board";
>> +     compatible = "amlogic,av400","amlogic,a5";
> 
> Please fix missing space in all your patches.
> 
Will fix.
> 
> 
> Best regards,
> Krzysztof
> 

