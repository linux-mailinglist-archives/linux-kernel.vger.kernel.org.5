Return-Path: <linux-kernel+bounces-72857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A1B85B995
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9F81C2239E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCC2657D1;
	Tue, 20 Feb 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CcGPwSce"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2081.outbound.protection.outlook.com [40.92.53.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC57657AA;
	Tue, 20 Feb 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426379; cv=fail; b=kxyqvU3dw3le9YGGy4lhafjysJtQ9EyaDoHiU2dEq0wnQsWK6cb7c4lDHoEPWI87mGWzSCfMlJJI0f1ZwOSgyLtikovZWA6NjPYg7CogFU4EKtJ1AakdwXDFgx3l4G25gYLxB1614DcIOhx2fabhceTj2XNdmb6gQl8lB8+qLCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426379; c=relaxed/simple;
	bh=ZhHHGesvdqaZPld8Ft15pqw3ryR9gwVQfDwwQYBQf0E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTsJDbaHZRndIIC9X9dCLAB+TqnM8eKR/5eM91gaQxqOjvPZ3mJT6mbqSoP6HpaMpISxxd07vpNWKWGNpk3irvglOf8S2Mz2Z4gynJheaBfUy3Cvbf3XqYcLrKawBCzANwTkxwZb7nACGlH26Luph0ejzPWErae/C6ivLjZVtvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CcGPwSce; arc=fail smtp.client-ip=40.92.53.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8UlFQc08YXnpTw28F9TBZw/U8rHrpFp6vnZ7qeFvDRoR1szB5SEXTjp+Tha+62chsCQqBuA75d4TPJEwX3QWoG3B5kdND7TtO/BddpXfDeYh9k2wI8AZZKLSHjY6DekjEpgK57nFf3TYpVT5wyWOzKUFmNkEU+RkNDvz7kT7ljhmB7395KwN1/7azjTBWBrIcy9lHYrn1W2vf0AFvVOQ0xtcPRhIHK9Tsj3Ewj0JCKogGvy6QEH9ZJ4b/wUQKQM8wgr8KQouV0J3IuzACZu16T5S/hI2uEj1JJCzHw/E3VZh21kRAzuOLIs3knvrJ5+1TI5zPPS7e4eYnPcqtR0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMv92itRY0o6p0wb8AiKlbfrhyLTYWLeGEXSVxhwToI=;
 b=BQA+IeEsgloPvN5mITq3psySH7zYQKSfn7yVgfriTL/99XQh12roXuac1dMgTHTSYUvR4/lXeYQVMkWky1J+u9OpZBNJIhbcBoa3FKRxlX6uS8mS4XYlOd4N919hKmk+Szx81b+MTtBGZY7dDJfhEcSSO8lo4uNk4Zm6gwmNKhQQbOwJgVO9D6RAlW/Kp7I2j2tFXIw8luV8L8MVTLDyPIdzArLhuFhTA/AJ2BRHLtm37Dp1MVWaMzZmHpvB7hJzZlHJoiG73hTJVG7ChsybcnpPjw74I98dX1KWt3mRwK1tl34hKWUkKr2L3xf+CEgtMhchiKldLYltDhZoxEPe3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMv92itRY0o6p0wb8AiKlbfrhyLTYWLeGEXSVxhwToI=;
 b=CcGPwSceFHuMX4mI4mN3Tb2wfElFmQxLhpuhWSjlCPBaHw3PT6w7wg2niGLza5uF8p0pMmBwY0RUcKwo6gHKmqfJuVVsyRc5r1Gp+UkXBdAwC5+2joWJNf7R/lgdqzwMhBRwr/w3OFvWW868c1g5djQ8vqEApraPGSSJa1biAio4l68LjUMqsm1j9j6K6s7oXheUaXFJYruK7ZrGbtlzFzRFFXuh8ColVdcDUSEOQ+ahOPZL+ufjkI+JkbNK3nJu+Ylb86DnMvjQo+G930vsjsHBJAj/nwJtgWQnJHfOG0tr4H29zWc8H9ENKYfQPpCCi5e0Js/qXyQ0UpN+VtN9fA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR0601MB4050.apcprd06.prod.outlook.com (2603:1096:820:2a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Tue, 20 Feb
 2024 10:52:52 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:52:52 +0000
Message-ID:
 <SEZPR06MB69598A635C5AB1397348ED3296502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 18:52:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] dt-bindings: clock: merge all hisilicon clock
 bindings to hisilicon,clock-reset-generator
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-3-b782e4eb66f7@outlook.com>
 <32d0a9c5-6c4b-4d85-bcbe-6192c63ba5fc@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <32d0a9c5-6c4b-4d85-bcbe-6192c63ba5fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [68h07m5q7bwGaa9exOyOBAcJh+6CpModUGzfwJyts9eLAQmSUqHBoYKVcKFssJPi]
X-ClientProxiedBy: TYAPR01CA0018.jpnprd01.prod.outlook.com (2603:1096:404::30)
 To SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <3a312f97-7644-490d-963d-5afc099314c7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR0601MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4e21e9-140c-4175-a102-08dc320215c0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eBVtIV+tjwbbQ0U8D7puSXj7tkkByZWLELDA2EmHS1QoYNAYN/yXhkfwv4QSqjrONyRHMWixmYk+vYOi6mRuNoB61+99ZDP2f4QHqbXf+yM3Qa9XO4sTtI96FC3BrYovpNiU+586xBtOAvT6TrWTsrwl+A97TvREwjyTf2+XR44hJSV/gN4KQE4HGZlJrvRwO7qz2K9BgJrCyKxUdSjsRUjLTdet2+NYT02YYH3c6Tg/3RnmHOZ3IsQ1mkU7lgCaQPl3MwGsqlqWQ33mgGKrHss+ex/6hkSjXhrhln44a/u6MU/JWJEu8zB0cLiDg7lXmaLikMTyl+cbLhyCnvEuW5rUsMJWe59HBO4KTeSfbvBK1J6eYK6j2T8LjA3brhl86oHa13HNyaUCt2lVD23T6P74j4uEXvSxBSjZj19dLIUYPd36M2+jOPBkPGfBb1pjZw5tocVh0kJ8lZrBV9qEXLU0tTu+xKRCIOITrlWACCeS2JgM/oHWx7iBHI0YlN7LYkLpTHSxXumq7WH+qTFV+sZAgBzYZGgR4Zscgvoe3E5JPD3PkwtStIg0WUiM5OsiI2E3kjwc3dYYQ4Zy8/mv5oFKns98sDu2ypke8CUvYW8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVBIdlhoOGdDaTRIbDh5V3FlZW1PMTJhaWpkcUFqOUFFajZwM2VOMmpKdnJO?=
 =?utf-8?B?eFpiNUI0SWJlVlpnZWpTZWFrODhmMnVveGFvdlFWTkprcis0dUlOUjVORHVK?=
 =?utf-8?B?UDkzYnRrUWcxQjVnQ0NOVXV1cEx5ZVJCTzZVWmRQWDg3ZWVOSk0ycE14Mm5h?=
 =?utf-8?B?SWZTa0NiYmlYMGFEQ0poRjBxYTJoSGdCUU9VamZNY1g0cVQ3ZWNhTlNQQmdU?=
 =?utf-8?B?MjRzNkV2VG1qU3FQWE1lSDdTRnRleEtYaThaZnZIYUpFTkxxajVLaHZGNTZq?=
 =?utf-8?B?NUpmclp2RVZRS2tFcXBDR0xoQjNDdVZhZzBwcmtrSStWcWlPL29EV0NXdUZQ?=
 =?utf-8?B?dnk1R1EwUFdqYnNGRGRQamdJa2Ixc2dpWU93Y0ZUdnJadHdHN0hWM092MHRW?=
 =?utf-8?B?Vm9FUi9tTmY4aVBnVDBxdkIzVmxvekR3eTNmNFpUcEpodVJ5VTdPZjNTS3JO?=
 =?utf-8?B?OVpXSGNtVHNhdm5tOWs2OW1xcHhYckVBVFJ4T1p3clA5VDd2SHgyUTVTZ2FP?=
 =?utf-8?B?UUJZcVowL1JGUE93Q2NiKzZqZWRHVEdZRUNSM0xNWHlGUWVycnhpVlptVytu?=
 =?utf-8?B?OEhCc0lvTTdwYTVHak1FSUVCaVdRRFRGKytJY0RXNC9LRjZjL0lkdVZFNHZQ?=
 =?utf-8?B?QVNxSWMrMm9wQ0ZSMnJ5eHBYNysyNjVUZG43d2JSazJQWUpibGk3MUljcXpW?=
 =?utf-8?B?ZEU3ZUhuK2Y3UkE1bWhlNllzUGlybHEwZXpMeWIveTlhb1h4YzViRng1aGRt?=
 =?utf-8?B?cFZlTzlmMWJzM2hiTExoV0dVTFhlRTlLbFBqTXlXMkpLL25kRERtYjMxalIy?=
 =?utf-8?B?cnZaTEdzTU52NldyNzRDOXY1UXFmRlJWckttV1JMekNueE93UlhmQVhLUVpS?=
 =?utf-8?B?WW82M0t2My9HbFF5WCtQU2g3djJFYStyTi9SYjJESEZESWJoMnRKcU1xM2ZY?=
 =?utf-8?B?endJRWlwZzZKS2txQ3p2R2RNYjBwa2dqaGgyZlBnd095SzNiM204MVM3dXcr?=
 =?utf-8?B?YVNiblMxRFlnZXZGNFRyaDJKakNtRmN6d282YlVxVUI2ZTk4VUE0MWplSHp4?=
 =?utf-8?B?L0FweWNPTWJLK2xRNEFkZE1MR0xwRlBtOXlDejc2WWNiTUluZUoySkF6dkVl?=
 =?utf-8?B?c2g1K0tsZEYzdkRMcmc4QzRUSVhrdk5uTDdFUDdrcTJHSzNwSlN0SDQzRlhv?=
 =?utf-8?B?TllxVVQ2UnZkRlpyNUxDQmFRQkJJbG1LY2tRay8zamxUWmZQY25XSDczTFI5?=
 =?utf-8?B?MGkwaGowUEkwNXptY0xkV1p0YUsyMEZCZHBlWlBTNnVDMmVlMTlYbmVFZlBx?=
 =?utf-8?B?VDZEUktKUkhQSC8wTzNLNmNBSFl5RForaXc1M2tnU1c1K3RweWo1MWxGb01I?=
 =?utf-8?B?MGNuQXNhald6amwyVUFiK2VQbnhNVDhmU2s0OFZyTTFpYnN5azcvOUR1NUp5?=
 =?utf-8?B?RlpuNEppcFB4R3dGSjZtYlFWNG5sZjVWUERickxmcWUxMzlkZEI4bS9waTN6?=
 =?utf-8?B?UzYxWlRHMy91YUEvSm5MNDlkQ29VekxmWkF6Qm5ib1hhd00ySG1HazVEOW5P?=
 =?utf-8?B?ZFBXVG1wZlFiaVdGVXMrZkNqUFhicHN3azRkbW1NR0N5bUZhZ2M0alNHL1FV?=
 =?utf-8?B?QmFKSklFRlR4cDRiNURldklpYXZXTFNHUDdqMlY5V3BWSVpuMm94c3FocUo2?=
 =?utf-8?B?bWxiZHU2SFJuOWZ5dFZyRG1qSzgxd1RPZ29iVHNKbXBWTnJueXBrWjBScmVu?=
 =?utf-8?Q?nuUrsTU4Ax2x9lAHt4TIn2b+bfliqWTEgBPoqqL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4e21e9-140c-4175-a102-08dc320215c0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:52:51.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4050

On 2/20/2024 6:14 PM, Krzysztof Kozlowski wrote:
> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> We don't need so many separated and duplicated dt-binding files. Merge
>> them all and convert them to YAML.
> What was exactly duplicated? You created unspecific, lose binding...

You can take at the drivers at drivers/clk/hisilicon. All of them use 
the same sets of APIs to register a few clocks and resets. That's why i 
think they should be merged.


>
> Why this is RFC? RFC means we should not review.
>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../devicetree/bindings/clock/hi3660-clock.txt     |  47 -------
>>   .../devicetree/bindings/clock/hi3670-clock.txt     |  43 -------
>>   .../devicetree/bindings/clock/hi6220-clock.txt     |  52 --------
>>   .../devicetree/bindings/clock/hisi-crg.txt         |  50 --------
>>   .../clock/hisilicon,clock-reset-generator.yaml     | 139 +++++++++++++++++++++
>>   .../clock/hisilicon,hi3559av100-clock.yaml         |  59 ---------
>>   6 files changed, 139 insertions(+), 251 deletions(-)
>>
>
>> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
>> new file mode 100644
>> index 000000000000..d37cd892473e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
>> @@ -0,0 +1,139 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/hisilicon,clock-reset-generator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon SOC Clock and Reset Generator (CRG) module
>> +
>> +maintainers:
>> +  - Yang Xiwen <forbidden405@foxmail.com>
>> +
>> +description: |
>> +  Hisilicon SOC clock control module which supports the clocks, resets and
>> +  power domains on various SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    minItems: 1
> No, it does not work like that. Compatibles are fixed, not fluid. It's
> quite a hint that your merging is wrong approach.
>
>
>> +    items:
>> +      - enum:
>> +          - hisilicon,hi3559av100-clock
>> +          - hisilicon,hi3559av100-shub-clock
>> +          - hisilicon,hi3660-crgctrl
>> +          - hisilicon,hi3660-pctrl
>> +          - hisilicon,hi3660-pmuctrl
>> +          - hisilicon,hi3660-sctrl
>> +          - hisilicon,hi3660-iomcu
>> +          - hisilicon,hi3660-stub-clk
>> +          - hisilicon,hi3670-crgctrl
>> +          - hisilicon,hi3670-pctrl
>> +          - hisilicon,hi3670-pmuctrl
>> +          - hisilicon,hi3670-sctrl
>> +          - hisilicon,hi3670-iomcu
>> +          - hisilicon,hi3670-media1-crg
>> +          - hisilicon,hi3670-media2-crg
>> +          - hisilicon,hi6220-acpu-sctrl
>> +          - hisilicon,hi6220-aoctrl
>> +          - hisilicon,hi6220-sysctrl
>> +          - hisilicon,hi6220-mediactrl
>> +          - hisilicon,hi6220-pmctrl
>> +          - hisilicon,hi6220-stub-clk
>> +          - hisilicon,hi3516cv300-crg
>> +          - hisilicon,hi3516cv300-sysctrl
>> +          - hisilicon,hi3519-crg
>> +          - hisilicon,hi3798cv200-crg
>> +          - hisilicon,hi3798cv200-sysctrl
>> +      - const: syscon
>> +      - const: simple-mfd
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    enum: [1, 2]
>> +    description: |
> Previous bindings has only 2. Your patch is difficult to review and
> understand.
>
>> +      First cell is reset request register offset.
>> +      Second cell is bit offset in reset request register.
> All of these are reset controllers? I doubt.
>
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
> All of these have children? No, sorry, but this merging does not make
> any sense.
>
>> +
>> +  mboxes:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      Phandle to the mailbox for sending msg to MCU
>> +      (See ../mailbox/hisilicon,hi3660-mailbox.txt for more info)
>> +
>> +  mbox-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description: |
>> +      Names of the mailboxes.
>> +
>> +  hisilicon,hi6220-clk-sram:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: |
>> +      Phandle to the syscon managing the SoC internal sram
>> +      the driver needs using the sram to pass parameters for frequency change.
>> +
>> +  reset-controller:
>> +    type: object
>> +    description: |
>> +      Reset controller for Hi3798CV200 GMAC module
>> +
>> +required:
>> +  - compatible
>> +  - '#clock-cells'
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          not:
>> +            contains:
>> +              enum:
>> +                - hisilicon,hi3798cv200-crg
>> +    then:
>> +      properties:
>> +        reset-controller: false
>> +  - oneOf:
>> +      - required:
>> +          - hisilicon,hi6220-clk-sram
>> +      - required:
>> +          - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/hi3559av100-clock.h>
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        clock-controller@12010000 {
>> +            compatible = "hisilicon,hi3559av100-clock";
>> +            #clock-cells = <1>;
>> +            #reset-cells = <2>;
>> +            reg = <0x0 0x12010000 0x0 0x10000>;
>> +        };
>> +    };
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/hi3660-clock.h>
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        clock-controller@fff35000 {
>> +            compatible = "hisilicon,hi3660-crgctrl", "syscon";
>> +            reg = <0x0 0xfff35000 0x0 0x1000>;
>> +            #clock-cells = <1>;
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
>> deleted file mode 100644
>> index 3ceb29cec704..000000000000
>> --- a/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
>> +++ /dev/null
>> @@ -1,59 +0,0 @@
>> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> -%YAML 1.2
>> ----
>> -$id: http://devicetree.org/schemas/clock/hisilicon,hi3559av100-clock.yaml#
>> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> NAK, not related patch.


Okay. I'll revert most of the changes here. Maybe i should only convert 
hisi-crg.txt to yaml. That's what i really cares.


>
> Please split all your patches into logical chunks.
>
> Please read submitting-patches *BEFORE SENDING* further submissions.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


