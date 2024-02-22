Return-Path: <linux-kernel+bounces-77534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9518606F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4101C2344C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985271A5A2;
	Thu, 22 Feb 2024 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AThYakRs"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2049.outbound.protection.outlook.com [40.92.107.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630118032;
	Thu, 22 Feb 2024 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644278; cv=fail; b=p07Akjf8nx7VZKx46uDAnK6tcgkpJQmMSD8wTjTn4iiqOHTVkfi2YiqewRjdWdbduP1YJWuS7Xg/ZuluHONA32PpKgEF4rtvwsogcT4foon4WNGuW6eLpbJ2im5I5XbnAMS8bjv5h2m92Rtv92e1jrm27ZZyG/mPQvB6SickerI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644278; c=relaxed/simple;
	bh=MS7ASV9gCbWatwFhmx4vL2mA/beag4naQDU54V15CEM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mILzhrOnJk8rCB7E7LONNL5B4VWVwtj11n3ITy9hY+KCUDf+WeTkKI2H0vhpuO91SyoW82zo1pEsIcslzMd8h/PhhoG21UL5+vN+yfWnatjv0TF1jH7bxP6eYFW47t2Ddaj3RerzUTKoLese3Td5AbhXkClIkxFAicZVUX49ubg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AThYakRs; arc=fail smtp.client-ip=40.92.107.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUF5SqoIBySwIPobRgTl1MmYX9PcbE+84d2pC0vFgpix59TD8Nm6MeFnG1UO3RohiR+QMtiJbwPQjBj+xLf+Ri27TjhbkEv8+Pxw/4CwbO+MWaenV4FU7dYbzDQpASFgLFxNfSXZRVoO403HrJRQMSbjNOEjrZVpUzcQc3Ya7vgEzAjO0pEHDIkiGVnVs3CEXg17XOS9BkH1IARvWTcUt0ISn8HQmxBGEleTDIHqEq0pKNl0OblXJNjTJvgGjSbTrODX9uT3eRJXdnHgtHEBB5VPTiTtYPNaHm8Mhu5/Dp+yTBdP3xG78UsyGX3eLrrtaStYFJMEzzEs4LleLM5mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8HRf681DqF7ov6K+pgVuySti6jZuX+++3MUpZzxcGU=;
 b=TOsapKBWwNNHoYsobPj9rRO8NAJ/bgR1L9oMxcVgSQlfAj0N4+ICc+qBhFX0es3zche81gCwc8vAfM7bFzIPX3c7S4EpdoC2o0mONmxkdJ//gNssXhMAAMBadyB0lAHIRaUIWGs24M0GpKwImqdOf5LXmtzDjwybesOF5jabhIXpzqG7F21opLEak3qkfNRMhPcqTvD2SEjWoCjNj97gh9juh+ddiwzVGzjWrdUSiWtVwLZyo2rQ5tKADwKmspgki1+xAHkkYBu/WFyG5S0jG26llzbSC3g1AqZlV+/fcCOvE1F4ewYR0pPj6iNRW6Vd+aIJxwLK3snf6A4aLKnYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8HRf681DqF7ov6K+pgVuySti6jZuX+++3MUpZzxcGU=;
 b=AThYakRsEph7gUcRyUcTe+fDfPwYsgeRER2gtDAJ2OturCC/CyXi11i0dMt/VCfANRBNdfxgKvER9Uf0XLG4bUa0oveD0T2LjowMwrDbvREumRPywef0LaOd2sApiWt5l39nBqII5l3mffqKt+KiWBTEsiSftNKkXzzzerO9QrUC677kql8cJRfBBBeRevX0ayVPDmFGVDDUEQZvLIRvpKBbfW+AjwfOu7RNKqlllsA6lNe6P1NSpSE4tcEjg+/h5jRfZxpHg59HOUVPKUyGXDJw/eDR+5VCF+N9cZpMtFLBd33XiKhfbjf433h53wiwrmuk3Ls3RDODEDBSU7o/qg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TY0PR06MB5753.apcprd06.prod.outlook.com (2603:1096:400:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 23:24:32 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 23:24:31 +0000
Message-ID:
 <SEZPR06MB69595872C9886D9C38C5D8CB96562@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 23 Feb 2024 07:24:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] dt-binding: clock: merge all hisilicon clock
 bindings to hisilicon,clock-reset-generator
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Yang <mmyangfl@gmail.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
 <20240216-clk-mv200-v1-3-a29ace29e636@outlook.com>
 <20240222201411.GA3765548-robh@kernel.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240222201411.GA3765548-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [Vk3e7eLbUZ7bYjbovXMlVvxBqfX7OV1APZWhsrZOjsgkaWku/5FNc0FKSTyaoORnb0oaeoTgeoE=]
X-ClientProxiedBy: TYCPR01CA0014.jpnprd01.prod.outlook.com (2603:1096:405::26)
 To SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <20aca33d-d05a-4946-b921-6c2f3574176f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TY0PR06MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8abea2-7536-4820-81fa-08dc33fd6b55
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Q7vu2Zyxd4eJB1WEqAWX06HGXFBNarhZ+KcnINCfaieW/GJXP4bzeTlyvYAl6PgsM0So6Tw41nKh6RnnV/XxdMy9zAS13fNQRdq2HI3aklj0OGlFGhqLWJRCFXPtjxnMYzpRiLnKbU8Z7SDCQr7OsmZbUcBbewMBGaACoGrhV4ke0wv+8wlM3ZW4n2Absil4YoP9iVVrxYMr2DNpXDgvDyezGW62/foRkntyTVnJZtDo3t0b2Wjx7kogYTSr2gvwplxrWEG+RBhc2QEspM/f+hJ1W5hoV80yCMyoZWRSlXYIS9JtQddCFACd/py2hHn2JO417it5pxR1r7n1nLgKLzskFV+vVBG9JyORuiUkvl2Kgv7D6bR/6l2eQZ0euziNV/PxWzq4Do7KDxhNUZ3qGRQktXrgVrEhZbSHYgqgfqC8GyM1tjFM+IC8PX89qo2dChpX51CIGWy3CeMwZh127VTQQH4FsU4WAaqbjrXrloN63BiogRQ4sHNF7jzh+xD4u0b8/7yanAVtJqrNaZQLBvOtUfgV7F2fmr+3OLwZaTTYQHOZI33NAhi2hfe3cwxduXlV00kQhD1Hx+xMFeWBnBiLNJRcsoTFQO0ZqlcQaosBShTMYzW3PKBq0VuLthW99EMQDsWfhoQawZ59PhkxQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHhCbXRLMXZtWGk1bjVkWTZkUVJkZTdKZlFPV1NuMFRqVmd1RnpxVkk1cU1i?=
 =?utf-8?B?MHE1R2VSZ28wMXFvYThHNDVpb25Ta1QzM2dSZmJ1VCtBV2hVa1dtWnN1U0hG?=
 =?utf-8?B?Y0JPNkNveFQ0WEJGL3lkL2h3dXgxWjRyMlU3N2x6YUVQUTVWU1kwZFhSbWVx?=
 =?utf-8?B?TFc4TW0rZWxsNlZ5UjNPYUVzOXBtT21WbzZPKy96YTg5SEFYeHdKazZIa0pC?=
 =?utf-8?B?RUtnM0dITjcyK0dOUU8xV1JlRkk0UHBaMmx5QUh6UmRhaDFOWW9ObERNeXEy?=
 =?utf-8?B?d2VMK3QzSGlURW5XaGRFZkUyMFFkYVBIOUFHeFZ0UlUzN3V1dUQwMkpUVE9y?=
 =?utf-8?B?L1hKdCtPMXQ1Y3pjc3JESGVoZnJuVzJUeDlyUG5jdFRvQzlOSGdaMVMvZ3A5?=
 =?utf-8?B?MWVFc2I0Smx5QmhIZFA2b2FCN2JVZGlvdXVvbFQvYW5SejlQcG5XME9DWEZt?=
 =?utf-8?B?dXlrdlgzcTBJZ3ZaZ2NsNDJjVE93eVpISURkVk5WME5CZC9xR29IRGxubXlP?=
 =?utf-8?B?RUU0NkNhSWNudVQ0bDNnTUZ1bWl2VXlqVmY1THNuWFE2TkxrSGg0NGkwOUFv?=
 =?utf-8?B?VFprYTB5N0YxT0paU0tIY2RSVWYrU3VxaldhWUd6SHdEVnVPaHY0NTk5cWN4?=
 =?utf-8?B?OTNUOFJTaTNUK2tReHA2Umh1YjBaazExdDlWbFlIMGU2NVM3SzNiV051d1dN?=
 =?utf-8?B?RXlhcnlEZlRwaWVCeFc2S1RWaXZ4L1UvNDk0Q1VSUVhyVVZUVmxYMi9MRmVy?=
 =?utf-8?B?MFcyZG5Yc0hseWdtQlFoSGZzZmRrM0NKTnh2Ulhmc0pUYmVIaWdzVERlYVph?=
 =?utf-8?B?ZUtDNEo1R2orYjFBVDVJelZCdXhVdVBxM01wczZYN1oxbyt6Q1RVRUtkR01m?=
 =?utf-8?B?anBhd1ZHeGhLV0lEdlEveEZ0UFAwcFo1VVBnaGVvcmxhRmEzMUt5VjNyZ0U3?=
 =?utf-8?B?MkNvWURpTCtSMkcwWnhpZWFJOVJaOVdFeFIzdC8rRlVNM0ZwbkY5Tyt1OUQ4?=
 =?utf-8?B?N0tmdUxyTnpNZmJZWE1ERW0yVDNwekYxVThyM2pQMVBNL2dheVJ6MUduZWdL?=
 =?utf-8?B?eWRtLzNHa3BTRzBsMFduU0xWREtleWZNU1JQcWYxYUhnbWpEWnA4enlmcXpN?=
 =?utf-8?B?eXlnNWFGeThxak96WjBzaXFUWFBzREJONFdhSm5SS1A5TXlLY3hWR0VxdlEy?=
 =?utf-8?B?Yno2MTlIald1Rmw1a3cxQ3d3NU9hcWI1ZUVQZVFFb0pCc3dldnUxWmxzcE5p?=
 =?utf-8?B?ZFFhUElGTXk4Yit6N3E1L2JYKzFsV2h6YUM5a2pCSytTT2JqVnNVVnlLQUwx?=
 =?utf-8?B?czFVYm81SzJ6Zm0vbFpmWWlNaU9YdXFRb2wxd28wNzNZZDNqb2VjQWNoMzA4?=
 =?utf-8?B?ZUR6eWhRL1I0aDgyMUsrVTBybzliMzZrKzlWUEFYWEFoL0lQM3JGdEUzRlJa?=
 =?utf-8?B?NkJtd1MxNlg4cGh2dmdaWnAwS1ZBd0JsMFVOZ3J4ZHIveE92bWZLQk5jOXBw?=
 =?utf-8?B?d21IUDVjTFZzVHlRRE0rSmxza0RITVNlb2l5WXhEbUV6cGhtRmxWNUVmbkov?=
 =?utf-8?B?UmtiTEdPdGpoSHI3c2ZWUlNRZXdJeGFIaEs4ZEowSG8reGFDNHIvdDVUNEtU?=
 =?utf-8?B?b1hJWmpJSGRpbWJleTlCT3FXenpjRUNOSDR1Yk9mazBrR2xZaUx1TEFzQ3Bm?=
 =?utf-8?B?Y01IOXFWRWxnZVhhV0NMalU4MjlCNUVNMUlHa0dXWXM3NzJ3bURtM1ZuU1Bt?=
 =?utf-8?Q?bZv71sfjthLx7Xci6+bVV+HtTUrt9xMgFRconJS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8abea2-7536-4820-81fa-08dc33fd6b55
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 23:24:30.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5753

On 2/23/2024 4:14 AM, Rob Herring wrote:
> On Fri, Feb 16, 2024 at 07:37:53PM +0800, Yang Xiwen wrote:
>> We don't need so many separated and duplicated dt-binding files. Merge
>> them all and convert them to YAML.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../devicetree/bindings/clock/hi3660-clock.txt     |  47 -------
>>   .../devicetree/bindings/clock/hi3670-clock.txt     |  43 -------
>>   .../devicetree/bindings/clock/hi6220-clock.txt     |  52 --------
>>   .../devicetree/bindings/clock/hisi-crg.txt         |  50 --------
>>   .../clock/hisilicon,clock-reset-generator.yaml     | 139 +++++++++++++++++++++
>>   .../clock/hisilicon,hi3559av100-clock.yaml         |  59 ---------
>>   6 files changed, 139 insertions(+), 251 deletions(-)
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
> Don't need '|' if no formatting. Here and elsewhere.
>
>> +  Hisilicon SOC clock control module which supports the clocks, resets and
>> +  power domains on various SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    minItems: 1
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
>> +      First cell is reset request register offset.
>> +      Second cell is bit offset in reset request register.
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
>> +
>> +  mboxes:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> Standard property already has a type. You need to define how many
> entries and what each one is if more than 1.
>
>> +    description: |
>> +      Phandle to the mailbox for sending msg to MCU
>> +      (See ../mailbox/hisilicon,hi3660-mailbox.txt for more info)
> Convert or avoid adding new references to txt bindings.
>
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


Never mind. I've decided to leave them as-is. Now I'm focusing on 
hisi-crg.txt only. (We've already at RFC v4,   this patch set is outdated)

-- 
Regards,
Yang Xiwen


