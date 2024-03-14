Return-Path: <linux-kernel+bounces-102784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A887B740
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3228B224FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64C9441;
	Thu, 14 Mar 2024 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="OC48zxcc"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF879EE;
	Thu, 14 Mar 2024 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710393613; cv=fail; b=nRpfKSWxf6sMHT4qcX9XXMiFIfDYdrN7K+UdJaF0jiQ95JX9lq4ObFOXuHVoFCtcUF7byVBi3OJdF1xCHpsCba1QIJsv0x49LYr3K4oGhm5ZE2gpGDSMy7EohTGN+n27yQkKVQ3tDMhMLtcnJaHXMS9WNbAYtSRxOIZtZx+UAlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710393613; c=relaxed/simple;
	bh=zheNkISPc/uXIbiQXajvnUIpxKHtqycWXIfOsyh4nXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7HehraPJ/TP4DfnetWm0vyWDlRLU8wRj0HCid6wA9oGeqnNEj7a8xdU8GbPRFjULGezz841TY1ibcJSa2QpVUJNUl18Hu8xtjbM1pS1v0sYRCq1iv1bZVgVytF3DcdB5OavuJy+9lIpcfH00p6vcYCoN9XtoivFwgfk7vaCDUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=OC48zxcc; arc=fail smtp.client-ip=40.107.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vwi+et4ilkqz7eRdR82UKdueY0Ntaj5eEQNZs0+aEsjSxWsZUT1OvWn+Awsh/52Hh9PRah2T8kRIYOlLSatJc2eAtEhwG9yebLuTXltAgHpkDlZZ7DhtQyVzehHm2dPEBEWRrhkOa7QkBW0REPmGmVIy8XUyoE23jw0HOjRmUqVChPXGJxA/8SlpnxAmTi3q5yhAuNlncGXXuTLNDoAsiONgZcs47Axy+/BCE4ChXgduy1nTohlds5VNlqyXIhYV7/t8ljSuejzjCq3Ba/m6LXHngHtcMnJCwAvx5pdRYCuT9q6zPPZdfIhmldBZioqam30O62EkdtZ/HgpvpAGKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzvKLJbwn4hrxzSN14mNjYnIvvr2nI3EiBS+a6cCgT4=;
 b=Y+wmMTlC4005HrCZGZbOsGhcxogu5TS2jC28yhhc4gjrBVK8S6xSMC44DFyd1R3uUgJGkQCA+NfP82u8qOOiNtU7dvLKXlL7dUchMu4Pwl4cRhavLSUD09djO2Bf2cZoPqJu/S4LA6AqNFGYnY/AHzWJJWUIXDPM/LdXZpw8U5OvyLOIAwjyUhpgbwimqC0jAh9KA9LjzJNxqzBeBUc7cYby2O7uaza1u95SBDw3R/mHo8TWMatQId2QRUPTAu44lRbQ8wJR2bAABpXuOHvPwuz6zurRWJ3Np469+/JwwPa9XfblP1KpaeU4ou1vVfLPMuH3IjS7Mu9m1XYuahPejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzvKLJbwn4hrxzSN14mNjYnIvvr2nI3EiBS+a6cCgT4=;
 b=OC48zxccYFy6jxQgfW7+0dtOYcUQOfpj/u6cTnD4Y0WiwH7Vdvxu3freinjTGokqVq0FeM1y9FGHNMeC0dvCVIA9/2h2UuODrItQMD/3m2ZN29mQX2dvoMUdtsVPceWBlBCokjSqcngfIVSzS9q8qs/H+A4eM2E5B+CbtN4vDhBmH1VWjfDFQRFOMkXFpL2kJCm6R9Y9bXjJB3NOr7HD7HkVeQJYAJnaGS6zp7v7Qyo8RK/f0qDYdOsPHSi5LcfRgGMRFkyCO/g43litqzvEyMkxmK9uQ8XQaNOLJRMLWrIZu6xJx+tGSumkS5sewwraORZHoMAZ4zaR5z9Dd37vGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB7891.apcprd03.prod.outlook.com (2603:1096:101:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 05:20:06 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 05:20:05 +0000
Message-ID: <74f96887-572d-47eb-bce4-9d61ec51b88d@amlogic.com>
Date: Thu, 14 Mar 2024 13:19:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH 3/4] arm64: dts: add support for
 A4 based Amlogic BA400
Content-Language: en-US
To: Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <20240313095311.dxrr7gvt4t3gwoho@CAB-WSD-L081021>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20240313095311.dxrr7gvt4t3gwoho@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: ba97f204-0cb0-4dfe-6056-08dc43e668a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EZL21zitX8I0WYt089g/5mMcOzpxCzjsOR5JjsuB1H04ukNQ6x3D0JZ2I5xTJKX0wFrI/jOwGmbWF5MM/RCwxWJsQrrHvNiXe+J6WlQlQBtDWtUWyW0LBPtF4KvJm/pyNS8jFaa1x4Aoy6KOUP0x+dI+HHFc+VHjgJF+5r6XN65xmEjd+50J18S88gQFZHHrrJMJ7eisfmwyVMLa/QjHpE+/frQOxHtShcnnRaV0pD0uWAkwQcmqkBseVG1OVvzWPJSYTCa3I1AM9kwAjm6LvMP/cSiN/LslMdn1jVCkXaaHPpm74oZ7919y7/BHED0qfbzDxfKKbybDEewQY/xcuvyLA5w0GOC1yUmQgWkj5J4b17KsCzpSbNvH5/eRscFK7NAYkasntBxJJnxrqQU4XgLKo21zKJAafGHc/GyGqwkrBT4sfdaNxTZOaoYPpUF0raQkQVuGndIabx0H2drJCDBPAhVvvHjbONaSjDGVi9zeY/uMfAQYm3wfFRqFbFhg2F7POSL+LnUlEdnYVyXXNm7p0gtSTYoYyHjcrpVauOoicznpBXk8FPr9VgKOP7voi733+xOrBRzTeZKeJ4Z9BqokWSvIOE3WYD4kGYcRTww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3UxMXcwVUNNd1Zub2tnZVdTU3FCUTVtSWtyQXU4ZnRyeEwrQkswSFl2MUNj?=
 =?utf-8?B?WXBOL0tVWCtodkRiUlFxT1dVK1VVR0h6b0tpbDljdk9sMWNNUnc0V0U0THhK?=
 =?utf-8?B?U1FQa1Q3aFpZbGhydEtsZ1FGeHJ1ekFXanZxOFZYQW5pZFVMcTdQelJhN05O?=
 =?utf-8?B?dUE5Vkh0Q1cycS9KSUR0ekN6eGs4bU4zN1dCRGN0ZW5ESFowUW0wT3Q2Ris1?=
 =?utf-8?B?allHMnF0MU1ZNHhtSmYrenJmbGpTdWtKUlBEajVlb21waVRpK3dTMzZtaWw1?=
 =?utf-8?B?ZVZNSUFJS1k2b2RQRVRSeXBDVWt1N2NueUFOTXFGZjBibzRBWFA2N0x6aytm?=
 =?utf-8?B?NlRjbzBud3VGQlNkRTlya3FHRHhUcFNWdzdxOHA4eCtYVDc2RzVBWTdPQ3JU?=
 =?utf-8?B?TjM3K0tFWitMUEdPZ3ZBWjFMT1VFUXhVaUFaL1FtT3VDVUJEMktkTWhWWU1W?=
 =?utf-8?B?Z2ZoR2xzUjRyUDdJamlEVHBSZGZ5a2N2QVljakpzS25iSGhpTDY2clhFWms0?=
 =?utf-8?B?SGlSNWcwNUtOckp3UFRxQjZxeW9LZm0yVGdXaVdkNjd3YzRycE14eTFrTVZZ?=
 =?utf-8?B?dFVCV24wOHFUamVZTm1hRk04NGlSUHM2ZGpuYXNISjF0cTZmQnYvVVRuQi9Z?=
 =?utf-8?B?RGlpN1ViSmxVWDhqM0NPSndLeXNSeW9rbGpqNlFLbW5oZmtkTzNvUWhJUHVt?=
 =?utf-8?B?aWdMVE9pTDBSRDVBSlB3azM3ZENLY3NxcnBVOThBRlRHVTlMa2Q0RlFseE0v?=
 =?utf-8?B?N1YwSzFPcUhnczZnOW1KRE5pR2JsRmQ2QVora1Q0NW9nMW9iY2hqUUJYalNl?=
 =?utf-8?B?WDVPTEZzdEJCME5Lb3Y5aVBITHQ0NDdDK00ySXlxUjM1d1g4MEpDcGVwZkpp?=
 =?utf-8?B?cllPWGVlZkdTckFPMUxsUW1pNEdQQjRzdHlsc0p0RGdCeDVJMWlYaUhZUlQ3?=
 =?utf-8?B?MjduMkhLaWJibFFKMWEwZ3hWaWRuOHNkU2lFMFV3bmYvU3lMTFRhRllZQTFL?=
 =?utf-8?B?NHJoMzgvTU40VWxaYWp6QjZwR0FCWXpMdHJQbFhpczQrOXNJd0tHaFByRW5D?=
 =?utf-8?B?WHpPVFlHRTU3aWc5aHZBamdxZzBCOHpjRHEvNW44QzYwdWdnK1BmNzZEV1lO?=
 =?utf-8?B?Z1daV0R1aHplbUNqR0JvU2d6eGU4WmVEZEY3dUFWK3BsM3YwOW5VcTV3U0pw?=
 =?utf-8?B?Sk5GS3lBK2N6K0pHMWMyUythaVcwS0drMGo2T1dtdEYycUpCV3RiS1VwbDF0?=
 =?utf-8?B?djJTdGJrQjY4aUhtN1FoVDZ3ZDNkODZWWW5OakZKNVBDMnlPQzJXV2ZyR2Mv?=
 =?utf-8?B?ZzNPMEdwSTBHQU4ycVZEek10T2lTcmZJeDBsTWEwT24rYUlaSDcrakIxLzlt?=
 =?utf-8?B?WFJqdVJqazQ5dHZIc2NvNjBKMUpnVzZQZGQ1cUc3U281SDN5SGFyR1RrSUtS?=
 =?utf-8?B?T1hOcEkxWTltT3ZwVWlvM2s4TUt1NlVQNER6c041cFAxVVFkRU54UitVdHRD?=
 =?utf-8?B?bURnNUpwQjBVa1pWdjdyMCt4V1cySnFYUHFBZmtIdThvQnY5WTRuWFRKOWtT?=
 =?utf-8?B?KzhZK2xkVm5tZTRBSVNKZ2pEd1J2VUZrSXF1bTlpM2Jic29SRE94NFl5Tmdj?=
 =?utf-8?B?b1oyM1ZQaDdBNHlYemhvTXg2eFY5Y0FwYk45UnlkRklRNmpxU2c5STJiY0dp?=
 =?utf-8?B?c3prQ25wUkQ3NHEvdkthQTR1WjlEY2hiTnNjVHhSdmo1MnlkcjNVTkVVTVFT?=
 =?utf-8?B?QkVlOG0rUXM3TkpnVzN3QVZLS0ExZ3JYVWFiVXp3WVZHQWxEZVQyTTQvTGh5?=
 =?utf-8?B?djkwd3JwanJZalB0aDU4UXZUclFVVjcvSWRacnZnbUxWcytvdlZpYUpLZjI0?=
 =?utf-8?B?WjZNYThqbXd4N3RyMVZXTGpkK1Rzc1o4M3Y0K3Q0WURyb1lQZ2gybE1lUjcx?=
 =?utf-8?B?Y2dmSkdEQTk3ZFo1TVJMV05qZGYxcXpSeENnZzRNdW83UzdXWHBkSDVYLzl3?=
 =?utf-8?B?WVg5SlZLdHdvZWNKVlZLWFpJNFdPVjlINnRUZ1dvWStWRmovY3doUndDeG1x?=
 =?utf-8?B?VU5BQVRkSGVnN0hJRkFGcDVGZ3g1Q1JlREtmZ3ZsTk5MYmFUNWV3T0FvU1Z3?=
 =?utf-8?B?dXBSQzZDbGhSUHVLZ2wzdXpsZXZrekIrRHAzRHU4UkozRENGWHo0S0lvOTVW?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba97f204-0cb0-4dfe-6056-08dc43e668a1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 05:20:05.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsqNp+eQWu3hWklWcb+7dqKTwApmxeJQuByIPZU3y7DiWOB8fQQfkF2Sl/q8E7lS8iNcz5Dq5OTtbNG4sXQ6WY2k8z2wyJrin/P6t/bYnXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7891

Hi Dmitry,
    Thanks for your review.

On 2024/3/13 17:53, Dmitry Rokosov wrote:
> [????????? ddrokosov@salutedevices.com ????????? https://aka.ms/LearnAboutSenderIdentification?????????????]
> 
> [ EXTERNAL EMAIL ]
> 
> Hello Xianwei,
> 
> On Tue, Mar 12, 2024 at 05:18:59PM +0800, Xianwei Zhao via B4 Relay wrote:
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
> 
> If I'm not wrong, you need to create dt-binding alias for meson-a4-uart
> and use it as 3rd compatible string.
> 
On UART module, A4 and A5 SoCs exactly the same as S4. There's no 
difference.
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
>>
>> --
>> 2.37.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> --
> Thank you,
> Dmitry

