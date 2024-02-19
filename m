Return-Path: <linux-kernel+bounces-72011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7C85ADCB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3741F25ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073285467B;
	Mon, 19 Feb 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Fl9a1/dZ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2076.outbound.protection.outlook.com [40.92.53.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1053E16;
	Mon, 19 Feb 2024 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378543; cv=fail; b=Um0mACn9H5nlLBxywNcwEopdE/n+TopRwdYTmvEUZzgNdBmrRXYtW4D2xnjPpbKGCZB/2ABJkMjsSwkuyUh1XcUh1puXsRXDNTVJ1T3MC+uiCxvbDQd0X1PSh5Vh7qg8yIZXJyO0teKwFbKOsY8kO2WEDae8VglkydHPl26Xqos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378543; c=relaxed/simple;
	bh=qOvmK6wSn1LUmCjyfhlji9J8Who4JFrqPy1UC6Ss2eU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fWtxUiMSihIdpCh64cPPkxniCD2x5mtQQfN5OB957wh4zZ+MqF3N6l4B7qUUgH5sZwVpHrHIwfiat/BOcLKTzBrZCEImGUG/XpXNLnQtHsGxPGQXfbrCicfFTBqr+e0w9i1/79UevYMi0HcVCKS2RHRGszJuHgaGe2wYqMBkm0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Fl9a1/dZ; arc=fail smtp.client-ip=40.92.53.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjS33xcGK28Hr4VS8+TTqgL4WkFk+z+9dyIS9UQpZgT+bVCpqXKNdkhitgcfcycBE3tHAlCEv018icjnmyoqojQVvzTn4ZyCIyPvUBxzLGt6fOYy72xJIZzR/mre7Po6zwPAvYhkK+uxdCq5rl99ZP3vS7ZC12E3912fxJOQmMXX2rcAJB+zNn4b41biM8EWe9Hl3QfRKf1uBc3AqrQGYx5OLTGX+OEk0FjCZQPNSVMcxF5Df5ZOXsi32Fwg2wkhGNcG6KpINok6ebV2m3falQzhw66OUGkWK57EmKAYh0vHB9E06lZOguS3/c943uvQZQ08bNHQkyz6k5dx6E4PGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9sHRcGxzp6UcsuXRugA2uHHm/MHfNYs80l/NTQcdkc=;
 b=BDpwziAgbLMtWaoZKQypnEAwE5/tnK/HImWKYh3+Hpn2+vx9eESA33XAJ6F+9WwcTKvXh6tPmHiv2SDebA2d1gsKX5luhZcpVhJ+Rh9GNSJ61ZcWW84mC4ZDhtMISWWJ+8+6CK02yn3JtmaVtrdio3ldh1UL5yN8uWW4qeitQUzdOryOmHG6or7h8TXcGUlAgudZAfpKYhNWpRrLxe0uEXVzWz5m+bWwcaI/0OurypPXhZAgBaSAvsRaKFnVDzre7IKQPNuyVDc6K8Vb4egfdReJPllGE9ZHkta4UvCdNDXCIQavndTeQtNg+Z2c9cxVc8BIrOYh6NQrYAw5mk6j+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9sHRcGxzp6UcsuXRugA2uHHm/MHfNYs80l/NTQcdkc=;
 b=Fl9a1/dZm8sE/ptgThh71f8qLenQac5gZJ0bNF9qvcLElwGuYxwytN7ntFxldvsdFCo8I9bWhwHFiTBorWAxP7rdvqshWg2NSJnN68hkZGNIrcnfL1uCHLtFNxMgb7KmZUydNcVNQoF1KUpgZevBZ6aV+tLI6l/RcLxWVwer5rNQyU7F/rGIVfg9BgKXH8va9IcWgoiBRDzNTtWUOpqVQIrDLIMKFn6iEFQhpuE70IsqM1wgrYKBX5ElRMlh3v6811BtgCrjzubx+HUx7wz+MdhJiPftB/qFhKMFyEy94XQ0g+Vy3pjvqfPTSf2JwKil9MXKetunh32HWJd8DKeuog==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB4413.apcprd06.prod.outlook.com (2603:1096:400:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 21:35:35 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 21:35:35 +0000
Message-ID:
 <SEZPR06MB6959AAB6B43F3E1F5E1C526596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 05:35:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert to
 YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
 <62221084-247c-4a0b-a030-e12cb2931411@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <62221084-247c-4a0b-a030-e12cb2931411@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [8AIZyI3BGHp0fk59uwv4HrPN+ZSTU23zDTn0v95zyxhLC3L6AL4gOB60gbBuZBkVkwO5JYuSF7k=]
X-ClientProxiedBy: TYCP286CA0327.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <42d47b9c-1ee9-448b-9464-9d8e17a95077@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f91490c-6237-422e-f934-08dc3192b510
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k4W+qzpqXGEHR+VFvw8oh5/XzRK3gP1Z96F2i42hnF3jxzutZuDyPSVxTQmjM3ow89tf/D8rOuwZhZh/lIVun8KWhR0prsJEtiB5c0KwXmvQZvF8LY2Adutpem2qiUHzD0EuT6hKf3czKAENab1fd3f+Ix3ElsMkpLVPSm11FkqOECDV41CYq+9oPg1Q0V19AuwlIpHUWhu2cBCVyO6Icqxuy/EV2vhqlAcnOHTAZWWf54FU4PmH7mT69J0hUiXGWgjKv5VQss98EZUpss0wgxKCxRIG2ntWiG7w1wrKBV8DeKj0+L/zMK3uAuA2rPogyo5XHmgVurJUoInN3csBFOZ4mr/M7OcB++T8DpOCrtDLz39XSJv648GKA2hbZIbTeMh6GL4KtWM4XqHZGcVSlwodNGyeqoLCJpBeoQFJzn7lw+FsgOoTImmKVfp1VpeblNddHKvzEZ4Dcn893DvHuiqjwzYi1ofniXAJD7AG0TiV3p0jO/94METqOwKEs2hvo8JSNPuZs3UjifMVa6siUPR/9uNu7zNiAkyw97CvP55pZT/mDu915tSTM9WizAAwk/h00XjriekpJAzRzb6CmzfLP/ezbDyth1PTO/v9rpgDhCVfGWaY9/j6U1xxwJrLvj7WHP8r/xbAU9dGYltjXA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVpsZi9NVnlXMEdrN2lwR0JUa3dSUUQ3ODV0bG9pUytmemZYeWdJb1JvcU94?=
 =?utf-8?B?NnRrT00zTmtwamtQdG8wL3l4N3lZWEozODZ1MlZ2WWtRbU5JR2VaVW1XbkhF?=
 =?utf-8?B?RmV0UlZvR25tM1NOOUFoM0lIOStUSFVnZVNMOEdQVXNaZDhQcjU1dmpoN0NS?=
 =?utf-8?B?Q3RMRHVOOHRhbjlsalNmREJ2QmFPOWVYZWpOSGNLMysxbFQ3YXh5V3NFbHpG?=
 =?utf-8?B?a0RXS2NPcUdGS1Q2cFE0VGhHWHRxbXptNVQxZFFsS0JabU9FOGtFZjhLZUZN?=
 =?utf-8?B?TFJLak9Tek9PNTFCd2lpSWErbVJUTGZ3THBSRGpueGNBYytGL0R1NytCQmR3?=
 =?utf-8?B?YTBKdms3K0E4Vllkb3VCUTIzSUk0dGRGWStHSnVkcEh1a0pQNEd0cVVKeHhT?=
 =?utf-8?B?Z3VscFVvRzJHUFNvYm9Ja015dSs0bFVZWEpJajBpWlJQS3I1Ykd2eXpvcDJN?=
 =?utf-8?B?SGpaUTlLZElSSGF2bisxa0hCZXU0OXlyU2ZjVitIdDB5OGtZcmtBNVhkdEtK?=
 =?utf-8?B?Nys1KzV0cFRzNFRkNVBCY0xuVjJPVWNDd3piTThoM29vaW5KWEdJQ2QreXhi?=
 =?utf-8?B?VkhzY0tuYjJsemludDc1NzhPU1FaMXF3S0NSS2ZiUnVlOWExNWNtMTZNOEFY?=
 =?utf-8?B?MXVIQ1lkb2ozQktwUVFCMHZIREZKYVFRQzdORmZHRFFFMVRIck9BUXZxWW5Y?=
 =?utf-8?B?TzFiMDVDK3BpL1V4ZFh0Q1hZYk1lVXk0YXRYWnZndk1BeSs3ekZSUUU1ZFEz?=
 =?utf-8?B?WlZEN0llNVlETTVldE1BRHlRSHdjMU9CWnRuK1IrWFJTaG5CbmdKWVZZNWZG?=
 =?utf-8?B?ZzE1bEMzcVNsaitvbkhmUWZaSndiOHV5bDEwNGRrUmVLWlFLcGIwYWlOMER6?=
 =?utf-8?B?WHZYa2R2MGM0U0wxU3Bhbno4RzNYcTJYd1FQdEd4ZDBBRG1PMkQ0N2d1UEJ1?=
 =?utf-8?B?QVR4T09YTG9GRTVJa1dxenYvdk1RenEwSFdJUFFCRjhDakM4eWtFcjdMUmI3?=
 =?utf-8?B?SURoM2dDcThWYlFFaEswZFNheUlOSEF1eDRGYU9RWitzR1hQMSs0bDJqZzhI?=
 =?utf-8?B?U1VIK0RFZDVvcm9UNFUvL1BKRjJPbCtzazgxdmlKSHdiOHoyRitKV05sR1dn?=
 =?utf-8?B?elZhL2xtamlPa0EvcStkT3pSaGxVQStMNUtqWE9XRTk5L1FiSWFCNThEekZC?=
 =?utf-8?B?ajBxdG1CUEEycFUycmpJSnphQkJPR09wVk9IZFFJY2ZRWHIxdjB3YUJDMWda?=
 =?utf-8?B?ZFlZcmRnVWthdHgxWnZoaDFhMTBZRzh2OWIzc2JxbFRaOXBQQklhT1NEdk9x?=
 =?utf-8?B?cXJMTXJ3bjY1cWMrcktLSWZXTFQ1eFI1cnVBUGRKNHJmSFhGYmowMVpTS0xh?=
 =?utf-8?B?NWYzdlFYR21FSkhjazRzWkVTamptdEhzLytqekxnM3ZjNHlrdEo2TElJajhT?=
 =?utf-8?B?eUoxZUtNUjdyYnZPMHJaajNWTmVJVG9PMm1Nd3dTZ0hsYzhLay90YVA5NG04?=
 =?utf-8?B?VFoyVHgrQkQ1VEdHOHI5NkIrOStxb3NGcHR2eWwzd0JWUFZyVll0a0Vtd1lQ?=
 =?utf-8?B?SHdRdDhvMjRCeVFQM0JvSjZtVUsxcUhrMjg5NlBlSVFOSVRncVJ3TG1PVk5o?=
 =?utf-8?B?Z09oTThFeFIwaEoxOHdMMlB4aE1XQWl2QmZJZGF6cGJJeVBxU0t3ak5JdFM5?=
 =?utf-8?B?RmdZZUV0MlZBeXRDaC9vVHk0T0RSaXJoUVB2R09OU0JkNFRZNTVHcWJFbklK?=
 =?utf-8?Q?W+SjEP+1oXNONieC09mxktZLoQFaq+bm++Q3Smv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f91490c-6237-422e-f934-08dc3192b510
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 21:35:35.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4413

On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>> list due to prior driver change.
>>
>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>> compatible lists.
>>
>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>   .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>   2 files changed, 95 insertions(+), 71 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>> new file mode 100644
>> index 000000000000..1b57e0396209
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>> @@ -0,0 +1,95 @@
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
>> +    items:
>> +      - enum:
>> +          - hisilicon,hi3798cv200-usb2-phy
>> +          - hisilicon,hi3798mv100-usb2-phy
>> +      - const: hisilicon,inno-usb2-phy
> According to your driver hisilicon,hi3798mv100-usb2-phy and
> hisilicon,inno-usb2-phy are not compatible.
Ah, i didn't pay too much attention to that. I should remove the entry 
for hisilicon,inno-usb2-phy in the driver. Sorry for that.
>
> This is confusing.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


