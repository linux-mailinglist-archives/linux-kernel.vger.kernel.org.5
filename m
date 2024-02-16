Return-Path: <linux-kernel+bounces-68238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408C8577B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D061F21EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED15717C61;
	Fri, 16 Feb 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VgfCkYFm"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2074.outbound.protection.outlook.com [40.92.53.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E91B807;
	Fri, 16 Feb 2024 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072173; cv=fail; b=L5Cz0Ufdu/dUJ17/YCZyusce5kKjxQeWHMpp6hqHtWeTcn+LSS/wVhe/DnQfM60CnTobPJTGGC/4RZARv2GCAMkDWsxArRLw1rZ/FGMjLJozF1mWMmrwr23nf00YWcx6M6Tzttw+S+d8aflAkTBRCcxHryD9JcMe/NudsAYaqpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072173; c=relaxed/simple;
	bh=D1MLHaJa//BTk522v0WUDx6TK4G5k8tgd9ttppM1pU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEMYy9Q6d5NcMPTY39RIz/3EzbYr7jnMoI3lO20tZS/mKPx4/l9ZHwIScsl8R0bUWY+aClClm01bUQwdY/tJvxKPMRvr89GM68JS6t97vhPQCM2vNLRN2tEPiSxEs5KXwhiBLF2WE4jbm996z0sDfg5SDrsWTvbv4ggv73POBQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VgfCkYFm; arc=fail smtp.client-ip=40.92.53.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBzqIVVYUaT70FxfcgFjVKXobjEcRkMos9N68xov+SG8bNPHmgV4RF4R1kI2/Ksj0w3nZxBF0SDJxwnndYN8t61hxekGn2bUJJ0ot+EzU8UdeP0A274dHXZLBcsf5FEUr6Ei/1hmi2RehhOQ5AhqJy3E8fGk+w3y1aaI/36b1pdcKGuntwUhmPv1IFCezwo1f5iWHQHsKYbRgv4cBzZ2pvULrP5SNUnY6tL8FqBMr+i4sYVo32Dwx5cwLW8UYMY8Rfvh8nli4Lmcsf9zwA1GI2cgbYSuX3onbCVd/e71ZqNMJP9wOm4xsOzTyUkf3tQum0w0jTuC7RAbWOmKXiiFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rGG+KEC46WbF1ty3HMw16JaUqgAkiUx48menpsobuo=;
 b=JBHNBmMcbz1ClyyJC21J9KWB/7rMCKGRUbOw6LXCZCnR0lMrbCb11QhpTtHE0t3OxKKF1NlrL6ZLgIXJ5/YWruZy1FadJTXgajuHVJCTP9BCDe2+7HBi0K286xxYOGc5BEFeQtfmGMm2xlGcSQcQzNAxIR75LTn8eU5wos7pxe8Gq2E5W5aOZlqDKgMUO0lhfMnN4cJjlxHEHyZnTtjUzXJg/8AQC6+HXNAS1V10VFOZE3q+nSq5/atePjQGuk8VW+ev/rXpD3gS/J+FmYVvh5SEndqePUFmim1AjawLoIWmCHsdI7YwSCKxo+IiFuC5oDuOt1CVoxObh2nqWwuGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rGG+KEC46WbF1ty3HMw16JaUqgAkiUx48menpsobuo=;
 b=VgfCkYFmkH0ide81aQW2eiC0EMGhTq87yynVIk0tsu46aLemgBgCOeNDnw2FsyHP0lLRE0jYRK8Bafa0ztNJrWgxoenHwe2C06Mul7gGM6/k87C/ujN4JwV8PaPcVpbeyAXOaDwk+O/OdKvbXEJ8LOI4Tujr5PNAEtbhLjVEV+y/lAX+LFKMdvVZ9PLyfNUt5Ayq72EK6RBjZLgwkFniqtSMSrRnhlEd41ItAsL03W7eGQpTEeO50DXQN5Yxh+z0T7hpXBJjt/qFPxmVytHnY4ZaCDI4h+aBKPJ/yQ34u5YyzlSRvpAZq6GK9dayXv8Q/8ivhsVgNeU+LKfD/Fzhpg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB7040.apcprd06.prod.outlook.com (2603:1096:405:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 08:29:26 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 08:29:26 +0000
Message-ID:
 <SEZPR06MB69592A3F9737DFA6E0E9096C964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 16:29:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: mmc: dw-mshc-hi3798cv200: rename to
 dw-mshc-histb
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
 <20240216-b4-mmc-hi3798mv200-v1-3-7d46db845ae6@outlook.com>
 <36450b1e-7a80-4d6b-9046-9a57b7c845e2@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <36450b1e-7a80-4d6b-9046-9a57b7c845e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [Z3IgYi6snRVJArGFVJlXy3MtWgp2fO3maiXagXr4FxnoGdY7bvI+FD9nQIJzIJjFDHzWA35REy8=]
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <2a06be09-477b-4199-ac00-85868f58977a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 028e5033-1518-490a-ad0b-08dc2ec96299
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fUkFEJDbgU9/8KABWhhjeGzPDCk0sylqAujbkHz6hjlDSBmNvfE/EH3IBPdO64Hxpnbe2lHc646Wi84xNpQAhAHIkbmtdBt7gC/X40E6p3vVELLgJDO+Fq8BmorX70iMbE/X2XCnkudNwB9X3c1q7eznSYTHYappmNJwMYqM8ziS0neQe+TYNWUDbnxF4wmEmYH/6ALUDgcW4sCznkyoJXwrsjkV92Y4Zxfo36QyjhCO9BlYwQEcnkkWPaQ1VFlIA2LL61eXb/9W3oW87+tW3yMQr0t7FG1ecjAoVPVRXhTbZLAIZBU7HjtcHqPayj1jB3YUQ5kNCj16GoJ/KGKDHugQD5dtxpKVpraGedVASGBfaNLBDnA4yXtErzPIkSlJFDAM2V+c4y0q6H/VUD7Y9bzgCI3pwSYfd2HyDOqff7qTZ7i2XvNnPzm20kibHaVKOhp2JMbrGlSe2mCyBJamR2t5t/FwnPKmgqrSM+hr3H8pYBT09tkKTJtIMl1bD1zjEjRGVo3JwE0sDGtpfVC6BIIEy46pA7QqRg5vuYKpY7QWgUBPXkUowNWxb+W+bBMeTyt5scfyOoGZlsf+S7TqMmMlgEP+XBcVUNajsQOaXuA4Xyv3QMe5cWPkjF4AMMHOjDnsCx27UXDpyPN1JWYRrA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmtlMWtqNVFGUFlIZVpuMjAwVXJMMk92ZDVBK1k5NURsYTk5R0J2RStJb0RG?=
 =?utf-8?B?ZVk1Ulh0cXBGVGF3ZXNxVHQyVFlVUGdEQVA0M2pWdzFUc1ZjK01acTVHM3Rl?=
 =?utf-8?B?Z0lPME0xdjYwNkJWYkttMnkyWXE1VDlQcE1Wem1MVHg1Nkkwdys4dHZzYXVQ?=
 =?utf-8?B?VEx3T0pWWGxtdDRSSzZFaTEvVHdmNGtBUHJyb2dxRFR2VFZRN1F0Mk5MUWti?=
 =?utf-8?B?ZEtTUFZnTXpTN0tXcDA3QXozRi9YNmZ3eENaUko5Z0xGdWkvS0N1YWZTaEZn?=
 =?utf-8?B?cFVvWGI3YWdGTDBPS1ZqbEliMlNNMng4L2lTMUVKelVNRzlMTUd6WDhMcWY4?=
 =?utf-8?B?VzRhMXJtek96Q285T21MYjdvc2lSZlovTnlnS1VOMnR0elNJUW5obnBON0hv?=
 =?utf-8?B?U2RFbFByNnJJY3VMSkI2NW11NnJ4MzdDcXBnLzMwUStDbkxJamdoQTJYTDIz?=
 =?utf-8?B?ME45TWxiZFhKbXh2d3BNMjhhZ29XMkpnODU1alI5Tk53NWF4eU90cW9BOXl5?=
 =?utf-8?B?TVNlMnIzdVVQMGNVRVNsdlJtdFZDTHJLemRQdWtNU1BNNmt5cXhSWEFDbHlN?=
 =?utf-8?B?VUZkRDNGRmdOVlVOUW5ONjBBeENaWm5xMkkzcysyeVdTNXVRVEVHVTYxVlQ5?=
 =?utf-8?B?dDZ5OG96bTkvbXZ0MEZ4VVlWWCtxNEp3dnlnajd2VFJFMTcwYVlFaGovRE5W?=
 =?utf-8?B?UXRpamJBQzNua2F5SVhCZVpvdDBaVDUrc1ltclJ1TFFQeDlSa2RNb2ZxcU5N?=
 =?utf-8?B?Q2lxWVFQK09YK2w4bk1lY0Z0WmU4WGFwRmVML2UwMUFYeWw3WGhPV00vbllW?=
 =?utf-8?B?Z3VkSDlYNGZMUVdtbXR6OHlNRVh0VUczOWliWEdkT2hYK3oxSjN0Q0VLWVFy?=
 =?utf-8?B?MWNqNWpFa25sa3M3eXNlMnVQWDVQWm9IakkxdUNhZElnSU5Ob3hPUHZCWjgy?=
 =?utf-8?B?Q2NsTHgxRzlYTGNKTjRrTGpiNDA0TDU0YjlWbjNvdHU0ZkR6NThkWDBRZkRT?=
 =?utf-8?B?cU5YTzV2SmFkWVVUeUs4cHEydHYxeVZXaHR4SWIwVVVJc3MrMUhXTmhsL0h3?=
 =?utf-8?B?cDNXc2FHMkU3cG9vL25rbEpJVUNBdEJwNXk1TkpqRU56K3RUUHBoRjB3ZlBx?=
 =?utf-8?B?ck4zRE91MUdwYkE0aURQeGpHQTdpaFdFcE4vdGlxVkJrMy8rVmtveG8xVDBC?=
 =?utf-8?B?YXY0VUZoeENyWjB1djB6eWlwSStSanpLZGZCM3g4bVdtWHA3WWhVeU9Lc2dL?=
 =?utf-8?B?ZG5DZlM1ZktmS01sSHpZdE5DVHlxRUhmcXRsMmJaVWFBcEMrR1dEM2VMbk9l?=
 =?utf-8?B?bXVWWXZKMFgyRGV4NVlHT3k1TmJKKzRBRkhYS1FmNm5MSXEyL3RRV0JIZyts?=
 =?utf-8?B?SkxFU3ZJTThjZmRNc21ocThYVjYxbVQwTEczK3dzeVNtdjI1aWxjSFU1V0ZV?=
 =?utf-8?B?bUhJU2J2aE5kOVdlSTUybmk5QzU0NkZ5QnJDVE0rTjl5UXBPMzZBZGNXUERw?=
 =?utf-8?B?dE1Bb24vRHFkMC9wZXFROHgzMzUrOWRtRnI0SVdXZG9idy9pT3prZDR0dE9Q?=
 =?utf-8?B?ZE5YV3lTT3B1N05IYXgzR3dSaWxFUTNMdDBDcEg5NjFjTWllQUdCNDZROElR?=
 =?utf-8?B?Yjc0Si8xam5TbDFlMkFHc2s0K3k0NHVTdzkxN0E4TWNBVTZueGNLMW1pQ2Nh?=
 =?utf-8?B?Z1lwOE9iU0NMY0J1VDkwUks4bUxOdDJnNFJ2aUhhZXlhTHgvMG5KU3FSZGVr?=
 =?utf-8?Q?DCBIowGLzY1M3Iw9asPV+dq5tbRlBNYE03aBthH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028e5033-1518-490a-ad0b-08dc2ec96299
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:29:25.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7040

On 2/16/2024 4:21 PM, Krzysztof Kozlowski wrote:
> On 15/02/2024 18:46, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Add binding for Hi3798MV200 DWMMC specific extension.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   ...hi3798cv200-dw-mshc.yaml => histb-dw-mshc.yaml} | 60 +++++++++++++++++++---
>>   1 file changed, 52 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
>> similarity index 57%
>> rename from Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
>> rename to Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
>> index 5db99cd94b90..d2f5b7bb7a58 100644
>> --- a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
>> @@ -1,11 +1,11 @@
>>   # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>   %YAML 1.2
>>   ---
>> -$id: http://devicetree.org/schemas/mmc/hi3798cv200-dw-mshc.yaml#
>> +$id: http://devicetree.org/schemas/mmc/histb-dw-mshc.yaml#
> Really, one wrong filename into another...
How about "hisilicon,dw-mshc.yaml"? I found rockchip using a similar 
naming: "rockchip-dw-mshc.yaml"
>
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>>   title:
>> -  Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller
>> +  Hisilicon HiSTB SoCs specific extensions to the Synopsys DWMMC controller
>>   
>>   maintainers:
>>     - Yang Xiwen <forbidden405@outlook.com>
>> @@ -14,16 +14,14 @@ description:
>>     The Synopsys designware mobile storage host controller is used to interface
>>     a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
>>     differences between the core Synopsys dw mshc controller properties described
>> -  by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
>> -  specific extensions to the Synopsys Designware Mobile Storage Host Controller.
> Just drop this sentence in previous/conversion patch. It's useless.
Will do in v2.
>
>> -
>> -allOf:
>> -  - $ref: synopsys-dw-mshc-common.yaml#
> Put it in correct place in the first time. Don't needlessly shuffle the
> code right after previous patch.
Will fix in v2.
>
>
>> +  by synopsys-dw-mshc.txt and the properties used by the Hisilicon HiSTB specific
>> +  extensions to the Synopsys Designware Mobile Storage Host Controller.
>>   
>>   properties:
>>     compatible:
>>       enum:
>>         - hisilicon,hi3798cv200-dw-mshc
>> +      - hisilicon,hi3798mv200-dw-mshc
>>   
>>     reg:
>>       maxItems: 1
>> @@ -48,6 +46,12 @@ properties:
>>         control the clock phases, "ciu-sample" is required for tuning
>>         high speed modes.
>>   
>> +  hisilicon,sap-dll-reg:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      A phandle points to the sample delay-locked-loop(DLL)
>> +      syscon node, used for tuning.
> Does hi3798cv200 have it?
No it does not. Currently only hi3798mv200 has it (it's called himci 
v300 in downstream, while cv200 is using himci v200).
>
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -55,13 +59,25 @@ required:
>>     - clocks
>>     - clock-names
>>   
>> +allOf:
>> +  - $ref: synopsys-dw-mshc-common.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: hisilicon,hi3798mv200-dw-mshc
>> +    then:
>> +      required:
>> +        - hisilicon,sap-dll-reg
>> +
>>   unevaluatedProperties: false
>>   
>>   examples:
>>     - |
>>       #include <dt-bindings/clock/histb-clock.h>
>>       #include <dt-bindings/interrupt-controller/arm-gic.h>
>> -    emmc: mmc@9830000 {
>> +    mmc@9830000 {
> ???
It's complaining about duplicated label when i added emmc label to both 
nodes. I'll remove it in previous patch in v2.
>>         compatible = "hisilicon,hi3798cv200-dw-mshc";
>>         reg = <0x9830000 0x10000>;
>>         interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -84,3 +100,31 @@ examples:
>>         bus-width = <8>;
>>         status = "okay";
>>       };
>> +  - |
>> +    #include <dt-bindings/clock/histb-clock.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    mmc@9830000 {
>> +      compatible = "hisilicon,hi3798mv200-dw-mshc";
> No need for new example.
>
>> +      reg = <0x9830000 0x10000>;
>> +      interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>> +      clocks = <&crg HISTB_MMC_CIU_CLK>,
>> +               <&crg HISTB_MMC_BIU_CLK>,
>> +               <&crg HISTB_MMC_SAMPLE_CLK>,
>> +               <&crg HISTB_MMC_DRV_CLK>;
>> +      clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
>> +      resets = <&crg 0xa0 4>;
>> +      reset-names = "reset";
>> +      pinctrl-names = "default";
>> +      pinctrl-0 = <&emmc_pins>;
>> +      fifo-depth = <256>;
>> +      clock-frequency = <50000000>;
>> +      max-frequency = <150000000>;
>> +      cap-mmc-highspeed;
>> +      mmc-ddr-1_8v;
>> +      mmc-hs200-1_8v;
>> +      mmc-hs400-1_8v;
>> +      non-removable;
>> +      bus-width = <8>;
>> +      hisilicon,sap-dll-reg = <&emmc_sap_dll_reg>;
>> +      status = "okay";
> No, really...
The property "hisilicon,sap-dll-reg" is introduced in this patch, i want 
to add an example for it here since the common dtsi will use this 
binding and will be submitted when it gets ready.
>
>> +    };
>>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


