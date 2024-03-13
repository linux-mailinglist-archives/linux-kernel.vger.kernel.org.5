Return-Path: <linux-kernel+bounces-101428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D81A87A6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6E8B22917
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099B3EA88;
	Wed, 13 Mar 2024 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="JU5LECH+"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2F3D3BE;
	Wed, 13 Mar 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328533; cv=fail; b=IrXe4PyqIxVogweFp6B8odoF5ovo7YPJceucro92/1baJa30jFtlMSuHhJvsi4ySnRoDpIdkhXjUW20Vm4AgiU3qtk84VK7gKzOjREVAfHtr/NdlgbXZUQjbeEm3uj6bjSPiIlc22EG16EkUYJcDIIZlGeO6wUZyMSCDfV3BCqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328533; c=relaxed/simple;
	bh=2o7gBVRsO1mFaIk1FXhk2pnmr4m4sFXiWtZ81fojnSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QWS66f/vzr07EysbD4tpa1ppGv3dfHmz29/K7a6wtmRJ/Me8qGTGqzweVWDFpwQqnRyFHiye/bQG0rQaxRw1resOXoaUyLV40felwze+YMifL9VgTZe9X2dYgwe030+j6ZY8mFzVikAPb/TP85qO6quELwOpbVkZZrwIEh5t2ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=JU5LECH+; arc=fail smtp.client-ip=40.107.255.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/61dHp8iqS97kCmoGVxI6X1uuFovOfy+e9UmoD/RRQKPxh/+zzNYLo92t8SAAr4GWcz2o4QAsGq/16I8Ua5awitAIl42C1nhW4KeynfMZBWPMqIfflrpoTM5YVRnPB+vF6r0hf7PXv9ZiaCJVLatLebZKf/+Bz26NkNC7qTvilZYh0NuuXsd18WxtkimNi1lZzDRYpRR/Ex4cfUo8NGLwKHlzzDTom8mEJuH1rHO7SrYoDY22DL9BRfUQgCJ+vAGZU1Hv72EW9tGxEsUKy9EvB+YxMNP8SpfOUq6MgOD7CFUtmusFN+rscYe0ktkfrKuWUwTG8XiEhDbCfDSpBjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLJfG5HvBZvWjAcn1Y9YUzRoisvKwiuR2dRgVEz/2uc=;
 b=aZxEv7h5LkvwIM8Aq8DnXtlDp2+S0vlufZul8iIoBer46CCI8H3V0GwQ3HojtfLOmlDF7CUvqF/4rQ8vCB1WJX7KkY+aqu/BfGLnZlNP98pWRimoiJzJ/SIkGwalQvX02k8PD7qVScsE2uP3ugnf22e9Bv6p9hTIiezs0AZ18GUjbt6SfUbRr/qDCCLi3ZpfrCWt8cv0V60f/hBxSsAIo1zOnFiNvqZGwOQ9lo942uSNoqw77cXyL5Mrzn/fhx0Osf5WOHN8RkyxJQRHQOa4+ezjosaET7WzxeEKAr/z29ecFAxlSAsDBs0Hf/MioAjC9jabNIf8fl+mC4FZ3Rq4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLJfG5HvBZvWjAcn1Y9YUzRoisvKwiuR2dRgVEz/2uc=;
 b=JU5LECH+z5/C9eIFp+vdTPVwFo8Z5EHwF0IPknz5vC99Ub4fyMbInTw7+B0VZKq8vR7xn1D2bp8gh3J1Bn+2F5DVTytD+PaDGEZjykCMo4NbzoCjEn+i47YCSlmVmPVXS9ce45rIPDRuwRpRLfvcG4Jm4XhIsj28FySl7w3HAPFb1nLI8mgW3hVYwcOZVRHhVofdwd/1qqABxS7IUL69NK2AvYJ7nV/+ubm5cL853NW5cFKibFyAr8zUzMQOgrTLhQ8I13BSNLqgFCIqIk52cMGnfPQuI82NJ43fsK4nujJrvljUuhHhQGV6ZskXvg7VOzUyi1p/neWQY86bLxjbMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB8878.apcprd03.prod.outlook.com (2603:1096:820:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Wed, 13 Mar
 2024 11:15:28 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b%4]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 11:15:28 +0000
Message-ID: <8e498746-7e1f-4aa1-aa94-ee103c9579ff@amlogic.com>
Date: Wed, 13 Mar 2024 19:15:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: add support for A4 based Amlogic BA400
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <2e222e07-6a14-4cf6-9d62-8e6d73b25f8d@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <2e222e07-6a14-4cf6-9d62-8e6d73b25f8d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 13323baf-e9c5-4434-6e68-08dc434ee350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5UZ5Xyjx7jgkr5t36SawdNMaCVQVsIs60pyLQy7EoMV0gHZ5D5OmCsVFvPGn96OIqdvg7rDp3MLYa9fkcgpv7GlJRLHpOY1FkOqZKthRJjl6RPWNjydFHjoUr7qQwzW5JC0/K5F0bVyaMzMb8jL2io9VXzaIssmLltB/KiMPxkwoSXZD6QE7rJwjWTgocIeSl86waoEJlivMIVnQXNGXAkTbDKdwqkeixL4Y6kZZESJHNfEFtAGJ8nQP+k4IxC++ypfCsW6839kFxMkwZq6Lxl1rwF/pL8PQK5UYlFn6lmmJXuVTF0aeRLjPGeDWxG9T9yz/AJEwetSk2g3/D36zq44QBygvaFtXn4HeLYaBxco0cH6OS7MFEaPN7TAl99BBn/hhcCffeEbKPDJiCj/OaGoiPKC5QUW49EOQyZZQvfTHA3V1rcnMxgFqKWr/3P87LG6PWFOUxydaFsk1E4yZqLtcmNvFQqCYskt/oPz1KbrjMCuzpBS9aM+nSbkTfrk979UuVZHs8n26o4x3pGpcOgye5K1m995h8Yd2DFkCgv0WcGN4G1/KkPrDpKy9D1L6+zoBh6Nk9RrcAsR/hguMgFQ+TkLTiCp7eTVSJjd+BPzc8DreowEwbasbVMrOTVrIjq3+oQngk+HeiZZocPAe4kASyWxCqVFP10zl86urSio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWU5azBoVTc5MnM4Y3YvTk8wK29CbUN6b3RBSDJPRjFUdmo4NmowWmdyb0kv?=
 =?utf-8?B?UC9OYkJIVk4yRmpVTDJoVHkxUzBqSkJzU0Z3Z0Y3QnJKa0p5anh3dVEwL2xs?=
 =?utf-8?B?OTdhL0loamwxc1VUL3gzOC9Eb283MG95U3pSTXJWN3Q4bmt4MWE4ditWWCsz?=
 =?utf-8?B?TTRhYXRTc1NrMlNySFlQTXB3YlpjVGppR3hBMVowYnZSMlRKV2pnTnJ2YlFt?=
 =?utf-8?B?bC9QTFR1a2JFYllXS2hMNTNFRmozbVBkYzEwSHlTY1MvWjJzNDhMNkRJK1dn?=
 =?utf-8?B?amZsQTVrZU9rWjd1cFZWZy95RllZcFF6MnRIeGdhM3ptSDJjM0o5S3V6TnJo?=
 =?utf-8?B?QzRhVGtVQ0FxUlRWdXVNOVlMakdnQkVtU0hiUXZPUUJTekY4bUx3azFOVXZZ?=
 =?utf-8?B?NWhnN1RUMmhHRURmV2dmZFdaNHJpaWk2T2NyUXhTMUtDbDdNSkltU0hxYkZP?=
 =?utf-8?B?ZU0xRmJvTGgvOE1UdGFwQ3pRbU1rN2FKOUcraElxYlhaaFljcTVVblhxWlg5?=
 =?utf-8?B?dTdVbzVWNmg2V0d3OUVQVVdCNkFlei8zS3dQNmh6RVFWaEV5NmsrTlFrbjdD?=
 =?utf-8?B?RGtGd29jK0M4dkVCQ0RHa1N2bDl1blFuR2JKbHZXQ0VFcDJaMzZVb3ZLL2pO?=
 =?utf-8?B?ejJZckxDTFIzSG1EcFJrcVRvYi9PY1N0UFhpdHc5dnpDUzl3Zmk0MnFoZENB?=
 =?utf-8?B?TVZsbmUwZG1rdDVxUmt5cTMwUzU4bkRHcDlVbDlOMis2dWxyNWxVUlhLd1V0?=
 =?utf-8?B?eWIwTDBtQVhPZzBOVHJrUUZHT2Q5TUx3L05jRmJ6SDNiOXhBQitiT04zQnc4?=
 =?utf-8?B?dU9CQVRVSklhb1hYSjZSNkg2MzhIVE1vc1E0alVQN0lJZHF1L21EOGNpWlht?=
 =?utf-8?B?NEpOR1N1Nk9mOE5UenFMK2toNDhLemNlM2FobjNLMWNXZm40MC9Oc0NudHlz?=
 =?utf-8?B?c1B4MXhmL3UyZGlXbGxldk02UGhtbmFYelM3dGlrRmQzNWxRdjV4R3NyZFBM?=
 =?utf-8?B?YWZmSFdpNzRmT0hUSlF4M085bnd6YjRzcTVPMloxU084NlZ5RTlnTTdSMnhm?=
 =?utf-8?B?U2lveTNLamVZSEdHT2FOZnMrc3BCMUdZcDlTRS9nYWNUOFJJSE5iNzN5ZDVD?=
 =?utf-8?B?RUc4VTkxNUxNZHRHNjhHWkZZSVhmcXhmcXFFNlJYMko3K3lsYVdrOXBldmZD?=
 =?utf-8?B?aDFJTEYvM1VLcTQyRTJvS0RBeGVUR1JJT3o1ZTFEMjJ1NHdML2RSeEdta3l6?=
 =?utf-8?B?eTBqanRzWGg4bVlXTGZEakRpSUM1NTF3NXoyRHJDNXMzWng5TW1NdEQ0NGdx?=
 =?utf-8?B?SFNPUllqM0RXQmorMTFiWjBOdk4rTG9VaHVvQXFNeEsycS9GWkhrVkJTeG9H?=
 =?utf-8?B?VzJEYkx0VzlDaFhJUHI1bDRTazFsbCtqK1BEN0NxN2orSTFyQjBmbGxTKzkv?=
 =?utf-8?B?WkV2c0tDbm0wbzBBajZuUFp5QmNMbDRoRnZ4WkdVckhGandLZ2pwRi9BS2lC?=
 =?utf-8?B?aXFNMEl3NEoxQ2FFVXZDZkVyYTBKQUJqWk4zc3hyQ0I1dm56blJFZGEvc01U?=
 =?utf-8?B?U3pYcUxoUXdiNDZFRldNc1hRcFcwS3djeG9ZSlVJZUlJWGRRS3QvWXpUbktn?=
 =?utf-8?B?K1JGbyt2VFRrbGQ3ZXIvWkNLRTVaRVNqT0EwTXNJcFZSNU5NOUZkUXV3N3gz?=
 =?utf-8?B?VmVGZ0dDeUw5c2N0Y01XNGdFMnZZNzZXKy9xbGV1ZStrc29hSDVoa2lqZjdU?=
 =?utf-8?B?Z1VSTnpZOG5wbGIvQ3hZS0xxOFRtc2pkZnkwekxQbm15MVRzWW9OTUc2Ymls?=
 =?utf-8?B?WFIvSElSMTR0NndPdktqT0hoVlF6NXFWc2hvZ2NFdW14dnNibnYrS0JZempr?=
 =?utf-8?B?ZlEya2s0WDNhUWs5eFloKzV4azRBV1JjbW1BSGt5UWFDZ3BmZEdOYmI2d3ZG?=
 =?utf-8?B?VUxpdVJtZEs3NTVpNFdOSkovQk9BQ2Jna3RYZDNqWmdueS9ENWVNNHV3eTJU?=
 =?utf-8?B?elZJeHpGVS9Ba05yMnl1OFBXcDVrOUd0OGRMWFV1R2FpR0dMT2VRdlJpUmZp?=
 =?utf-8?B?MjAyZ0wydXpvMU82YjAxOXhESEp6YmRSM3MwYnI4Q1VJTHQrU2xRVGZsYy9k?=
 =?utf-8?B?cUg1WUVwdzh0dS9qZnlUb2NmenNoSjQ3dmMwMmpJRkRub3JCVXV0cU1JZHpS?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13323baf-e9c5-4434-6e68-08dc434ee350
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:15:28.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsXKOLhQ8sXux8pgcFHCnTbhxZ2NdX96jpQ70XBQgS+iYCtVjU2eOoaf7rjiWkPmqYSPxE/s5vvv3SbTBXTN0DYcnET6uNLM0D40HeEFTRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8878

Hi Krzysztof,
      Thanks for your reivew.

On 2024/3/12 19:07, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 12/03/2024 10:18, Xianwei Zhao via B4 Relay wrote:
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
>> +             secmon_reserved:linux,secmon {
> 
> Missing space after:, unusual format of node name. Are you sure this
> fits DTS coding convention?
> 
Will fix it.
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
> 
> Odd order of properties... reg is usually the second.
Yes. Will fix it.
> 
> 
> 
> Best regards,
> Krzysztof
> 

