Return-Path: <linux-kernel+bounces-69798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C15858EB1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A174B21AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B11F955;
	Sat, 17 Feb 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M0SqRdso"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2030.outbound.protection.outlook.com [40.92.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42F1EB54;
	Sat, 17 Feb 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165490; cv=fail; b=Z3hsXFrTr4ABOipMxgzNynzz3rqtssm2kRbp76wrbAsR4t+d1sGXmifp536DZAjD6XyulK4KLYHR3c4yXgc1uTNicLrnJHbwfflhwHHQOLczL+YV1igqQxCleGuqyhxwlya9afwjWGYrDO/BbTo5dBWV/Q5GQOd8AQ2fDSZXeFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165490; c=relaxed/simple;
	bh=jcUDDkE0Bavd9CWy1Fz/1KDcDMtfYuGPELarqvA47+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kQEjwe9gUluLreBAgwQ4yYC3RfrvAMDKPfZkF2LUCISEMKn2GQ8OPBaTQoWNnFKpo7nox4grOs3f05Oe3V/9dCW74BsN7pA9AkOwnAdKc3nB7of1hvxafV8OkfWoY1t3hIG5Rt3psA4kvrzSI1O7K8Fh2zGQ4ibPtoErwNqQEE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M0SqRdso; arc=fail smtp.client-ip=40.92.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nel80BYR4dB77SyBKlngF0I48thx001NRk3AjBkKa/VlgMoPRgYrqd47J7/VJXXyo1UfWoqihBJ1S9jkO5AzCDWgwvcGypQI6314G2biLNNjqHlgQ9K/Yelmfv80dOkjv4ro62suiwBITL1ZYblFzmyADm7nS6Z52uB7lnJplyhtVvSA9nsve9Na2R/9To2zTKLTx1m8jdwOOVbuBmEgCzLzyAQrq0oilxz5iI7Cy/yvV9WF2uaS1zS7wFnyVfSFryV9mMdB4luqKGzUQprvE3hXiXdC5MmKu0iOaRBUsHq4k6vlFBRGiIzDSF4WJVE6jRPT6Ftaj6G2YCv2yLMaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGCy3TFRCrrMh3gg7fPZ0RdE7hHs3ZjVmoJqD36i1Mk=;
 b=Uu1r+iiGBw6FiElODbo3b+5uhJGG1MqPxQEdUxu+q8rThfp//B6ziDXdE8KyJS8kyZvAEAhGJmMcu0snnQY7q0fHNH0AON6CMs23JMfbjNMYP2OWk4QkcgLI2ux8bioMBrwS0uOijUMxNH2DwBp6d3J4e0EzLx6iuDsGdIUftaou6aM3CUqtTomSPdIHV9EviSDbV2zyBW9wR2BbnF0ARas9LGQkirczB8l+t1EDWZIOOLsa9wJ9qTPyFEq3TJhScqAURc1S7AvJjr60wNzTTFH6ANPVnYmp7Isu675GewtLWMAHR/cMIrh0dCUFKcT/W1dbprXTsIUWdA/kGe6/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGCy3TFRCrrMh3gg7fPZ0RdE7hHs3ZjVmoJqD36i1Mk=;
 b=M0SqRdsoRaXPhBgOLS+DdE6/lfRvtoOZ2ae0gz3GSNFZgH/isw4cHpSABKYUsKp5+bHOOu3TrLK9HJv+15248jezUSksJdfKuaUbnAv0UqE7rkLLUKio/w885dx5oTuO+bTuFuLbgWbwJQgA4IzFcTVWZKG8fQ5sxSAZLfltRCQIEivl2W6Xyq5XaMjz46UVVQR8vM+sOIjETw4VIEGHR2eGc51kuJa3z0cUhzk//fi5eBsjav/pVLeWnMcF83VvF5ZhrD3G/+NuioHK2Tw1d094sKR6RcYFTAoT8ciiGoxYTSjaCPy77d2xul7oF2yKMD1tyRqAxw9m4S9CP6eInQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB7453.apcprd06.prod.outlook.com (2603:1096:405:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sat, 17 Feb
 2024 10:24:43 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 10:24:42 +0000
Message-ID:
 <SEZPR06MB69593B898A42192D134B01A896532@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 17 Feb 2024 18:24:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] dt-binding: phy: hisi-inno-usb2: convert to YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
 <20240216-inno-phy-v1-1-1ab912f0533f@outlook.com>
 <63b3eff6-49eb-46f3-a6d9-878eddf6de53@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <63b3eff6-49eb-46f3-a6d9-878eddf6de53@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [lWi/r41few19Dt5tQd6V+L54nd1Bq0rnksVvzUKwvKyT61qH+fuwO4Hcva5B8DyLCceX6AZ8DnI=]
X-ClientProxiedBy: TYAPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:404:29::26) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <192aece0-b577-47fb-a8d7-0837204c5501@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 897d49e2-e78f-418e-5980-08dc2fa2a7bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g371cUkJvfrjUZpsKGONc6ls6aE4dJoeJpUbTV99yPWFaptr8I8zjILkfq+fVuHsF0yug8PSK30ghWCWyacH+XdaCkOUl7SE55YxjFzAYgkge4XUOqeZtErqfA/bnIVZEs0sQ41ob+biYvnsy/rrrCBhytawBSUuV0CnbBKMOyVQFkVzEMlaO/3/M7K7S2vJCORAOKbg3jzDXaqe4CKNLlOOyymMfdspUb6vSM5X3JboXz+60yf48vnBSns1wVpHTvSTusTyt40PJYvVRws0xih14TCjXzri+1y82yQmcU0OwM2LUSqzYaHxDwK7iyPjgWy/wVdNX1C9Wy7W/246eXXysdMI5wIyx3XQzveDrp8tDYh8PlrVSvoke/oqZK6KcVk28jXc8FcyZeZtLwIqnCtfPvnKHxTqljNRZwoAt+YGjoem+XORu1NusAIKWqTq6iZv/b+DzPrtmU8TKO/2U0PN7zfi2zUsQHZAmz84rA1n68P73jzCLIQcEvtBWh4iPQM+m1bAn/ubmkMg4uTKVI7HI/wBxxRJWtzbnh+kwUM10/GsCjPje6Ok9PPHI3+pMFL6U9Ew50tqJ3I5ztw1QOP++1AEhZ1PK7/fJhxsnD6BiAtuj9weT/UP4P6LFctSkzGOP9lctyTBUr/KyDBXbQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEVvLzU3Wi9DQVlMcWp1a09XT3lVU2Fuc2pEV2hBTUhaQ1ErYzlRc05nOGZt?=
 =?utf-8?B?NnllT2RsaG9ZMkVMWFVlQUdTQ0EzcWpZK0g1NU5LQnNJMXVrQ1NzSjZBa0NS?=
 =?utf-8?B?QktxQ2EvZU9HekI3ZjI5Wi9UTzhwMU1hNXk4YXN5V1JkV3d3WlZjR3pJSmtE?=
 =?utf-8?B?cEE3TlFudFZ2cmRSL1RMOFM2NzV4RzMwc1V0Y0l2OUtxWU43S1FuSkIxQWwv?=
 =?utf-8?B?NUgyQStGaUMyL2tIY0svZnhtSVRIOURadlBQK3VoeCt0VXhzSy9td1R1TE85?=
 =?utf-8?B?S2dUay9WazJ4ekM2NVlkcVZsMzZGUHRrUXJYZDV5bGloaStJV3dYaTJVOHVs?=
 =?utf-8?B?cTJSNWxWbWtaeFZqdFZRSjdBMkFoMk5QUEFST3cwVXZpRjNsb2VjcklBaGZF?=
 =?utf-8?B?WHl4SXNGK2EwUlpMVVVEWi9iRm16UFFnYlZ2TVRFMW9nV041REFsZHlJclNy?=
 =?utf-8?B?d3VaVGhxSUJVS3J5M2JzSmZnSTBMUUltU3lJMHlIUkVCd0NxWTJSRHRkNHk1?=
 =?utf-8?B?a1l1SWJqVnRDdDRJQXhsZ1pmVWlpajZmZENIVGNreUliQURnN0NiZVFvcWwy?=
 =?utf-8?B?L0tZZklZTEI1aU13YkZ1T0o3TVkzNW4yWjk1VjNqNE5FMkIwMy9NMmdudDJi?=
 =?utf-8?B?SUQvZXJ6ei9jME9laDBIK1MyMHo0cGVlcHVzelRQTW9kMkN1dU52clRRWno4?=
 =?utf-8?B?NzZEZmJQREdqSHVuYTBCM294M2ZYTlkxNjg4QUk4VXRmTHJ2SEJWdFczWkhz?=
 =?utf-8?B?akxyUG0xTVFFZm5WaTVISmlCZ0hOcndlK3R5b1pmZGtUa085MnE5cmJQbnJ5?=
 =?utf-8?B?ZmZzdVBMT0czcEpFdUE4dTFjVU1tbXlXeSt4YlJ6VTltUVJyR3J1NGVPWDdn?=
 =?utf-8?B?Tzg0cVFDZU1Nb0M5WFVZNjRzN3BWWXlycTAwMThIZzVFRms2cG10dVE3dytW?=
 =?utf-8?B?TzlrdmNzWDNPdkFic05BNTB2OUplVkpmN0l1WmJ2dEF1ZlZHM2NEWnprZG5x?=
 =?utf-8?B?V3JhY3FvS3M1U0NPWWFsaXdzUEZxRnN2Y3BweWlWSEJVdkJJem01WWJWYm81?=
 =?utf-8?B?enRwRnZjYWo0OTIvYnQ4V2t5TC8zM0krT2M0ZWhlY1gxMFBiYjFXRFZzaXM1?=
 =?utf-8?B?ME9DWTI3K1hoaitHYTlzNytoc21xRFp5UFhwQUw0ZXpwK1NUYmxMbDhra2U4?=
 =?utf-8?B?SStBS2JVNjZoQWs2UFg0dXNMU0d2TXhGQUMydi84cEVGZGFOOGVTSDhPT2xK?=
 =?utf-8?B?Y1lESGJOenFUVVl4S01sNmVFY25BMmkvUDZibFV1RFc3TVh1VnFjVHAwNW5q?=
 =?utf-8?B?M2dJbiszMUVVUVdaSjV5TGJlN2ZMcVJrT2o2N0NHODZJWEJEQnNjUjhHUTJE?=
 =?utf-8?B?MlJRb0E4Zk41dldQRzZIUUdZbVlQQm1ubWRlSEMwb0lPVWRVVHB5Tloxbzk5?=
 =?utf-8?B?TFJqQkRrT09RVStpOWptM1BJMWpxaCswd2QyK2FKNjNpTGxyazlvWFZ6MHFw?=
 =?utf-8?B?aWplY01ENitBM0E3Y0J4WXN4ckE4SFhOZGFENW9nblJTeElOS1lVai84TnVU?=
 =?utf-8?B?bGlZRGVCRHlRbzZFbDRNeFhueXJ3NHZRNXZMY3JORXRWWWs4Ymxsc1c0M0FS?=
 =?utf-8?B?TGt1eHBzQVhRamU0VGsrYnpiSy9VVDlxYndtYzV3ZXZSNlNkT2IzRXZybHlC?=
 =?utf-8?B?eDFLVWJvdGlJWHk4dlp1aWYyZmtwSlppQ2ZFL2VHU2NCTVFqcVJDcS9hZG5H?=
 =?utf-8?Q?gK5vpqK0vhzKE6dLYWu2pVTSXlsanG9mMr1AOF1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897d49e2-e78f-418e-5980-08dc2fa2a7bd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 10:24:42.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7453

On 2/17/2024 6:14 PM, Krzysztof Kozlowski wrote:
> On 16/02/2024 16:21, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>> compatible lists.
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
Will fix in next version
>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 115 +++++++++++++++++++++
>>   .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 -------------
>>   2 files changed, 115 insertions(+), 71 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>> new file mode 100644
>> index 000000000000..73256eee10f9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>> @@ -0,0 +1,115 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>> +
>> +maintainers:
>> +  - Yang Xiwen <forbidden405@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    minItems: 1
> No, why? Compatibles must be fixed/constrained.
>
>> +    items:
>> +      - enum:
>> +          - hisilicon,hi3798cv200-usb2-phy
>> +          - hisilicon,hi3798mv100-usb2-phy
> This wasn't here before. Not explained in commit msg.
The commit 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for 
Hi3798MV100") does not have dt-binding change commit along with. Will 
explain this in commit log.
>
>> +      - const: hisilicon,inno-usb2-phy
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: |
> Do not need '|' unless you need to preserve formatting.
>
>> +      Should be the address space for PHY configuration register in peripheral
>> +      controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798CV200 SoC.
>> +      Or direct MMIO address space.
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: reference clock
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  'phy@[0-9a-f]+':
>> +    type: object
>> +    additionalProperties: false
>> +    description: individual ports provided by INNO PHY
>> +
>> +    properties:
>> +      reg:
>> +        maxItems: 1
>> +
>> +      '#phy-cells':
>> +        const: 0
>> +
>> +      resets:
>> +        maxItems: 1
>> +
>> +    required: [reg, '#phy-cells', resets]
> One item per line. Look at other bindings or example-schema.
>
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - reg
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - resets
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/histb-clock.h>
>> +
>> +    peripheral-controller@8a20000 {
>> +        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
>> +        reg = <0x8a20000 0x1000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0x0 0x8a20000 0x1000>;
> Drop the node, not related to this binding. If this binding is supposed
> to be part of other device in case of MFD devices or some tightly
> coupled ones, then could be included in the example there.
For CV200, this binding is supposed to be always inside the perictrl 
device. The PHY address space are accessed from a bus implemented by 
perictrl.
>
>> +
>> +        usb2-phy@120 {
>> +            compatible = "hisilicon,hi3798cv200-usb2-phy";
>> +            reg = <0x120 0x4>;
>> +            clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
>> +            resets = <&crg 0xbc 4>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            phy@0 {
>> +                reg = <0>;
>> +                #phy-cells = <0>;
>> +                resets = <&crg 0xbc 8>;
>> +            };
>> +
>> +            phy@1 {
>> +                reg = <1>;
>> +                #phy-cells = <0>;
>> +                resets = <&crg 0xbc 9>;
>> +            };
>> +        };
>> +
>> +        usb2-phy@124 {
>> +            compatible = "hisilicon,hi3798cv200-usb2-phy";
> You can keep only one example, because they are basically the same.
Will remove
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


