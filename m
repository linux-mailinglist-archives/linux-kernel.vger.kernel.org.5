Return-Path: <linux-kernel+bounces-74601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED58885D69D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD7B28365A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3983FB3C;
	Wed, 21 Feb 2024 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NdHlpYm5"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2089.outbound.protection.outlook.com [40.92.107.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD763EA94;
	Wed, 21 Feb 2024 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514166; cv=fail; b=f8JPunt7F/sV3Oks3P9GFoKe6LLMMNyHC9N+hvnQcYjTOOiN3z2pcT8WlBaZS+pEb7dgvbi5zr5ip6QFBLEAomL82QNwrL5kaBI9IT5Z+rTsgk+ZkMXBEFx6U0Ji12jj2PJDlYftRpdlI6O6bOdTMnJaf1iO7lccE7O1tYfBilw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514166; c=relaxed/simple;
	bh=GhUoqkpB3ico0Io7V4Ht1LeJKUfZCkWFMb44Ti6yuxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wq15NthDlHCt8A0gMf5i24ebtcjB0qeTqW70gT8KxDere3FOh1Vwjg35Ki6xXNBH1cVK4mE79och/SJ1f2pMGWtkMcsiUBnnYXj6q8NrfwTsbNZ+DAE8u0+mUmTavyZ2Z+PrbnUkCT0+sXfa0ddVjaxevor8TYE9LFyDaQFanxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NdHlpYm5; arc=fail smtp.client-ip=40.92.107.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCGvpiPo6xRD8JFoIRCGu4TCkIN5PGxSyK8cfgse1sEa+xamv5a3dGUFxlJDEPhFLfTPT0VbIHk/lQZlF+1H9DcM7AHXYFMvhbHi1oMayrDc6cOSfBuye53c0DGDgjqRdbCTp1M+Zzs4dWBLxVPktNSkqQbCeVF2q8s/gbBE9pTqyXfRdnJg8/03KqaHRYre99RBGvHdVJ9v5Ot2LKmQTKucdUqQd5gIm7FyXOyAr/DytN2s9w19yZ2IgWnDLmY+hgdddvClSpOcbT6AHc4Sfh897q4x3aV0DSMFUukg4Zjoplnqqh5vjqmu9vzVgVk1b58LXW9DJ2ohe6B8fcVy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yh+ovd8aa1Sc8Cth5KMQQHtreGox+pazB2fDmFYkr4=;
 b=ZAhX2a4C1lVYP5jl1k7Q2e09tcErcP+6ZRa9fJNKzOaosyPhgThQOoQUxExz4TY/PrceaXhE9rUbQUt18pIVcfCoDhiNpJgoUDG6uGkDXltvrG6PPSTqt1Wgwyys2GKPoBTJEnAnrshTP0tUKwwc2IcXVqJ4k++DRcEVk+U5u9IePvFln0N/V5ZdiPWZCGaFKW9Bj0qDMmiEFAgCl/fij542cKXuiDQt9c3F0qFg75LKNk12uErFZk2NjynwWKVv6LY1mNCw8tNonwpsZ9pjicp3dR0/ac++m/Zmx21sxYBThrhZdlyuslc0D0bin00YlyhEiYVrZZk9+dTRvmx5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yh+ovd8aa1Sc8Cth5KMQQHtreGox+pazB2fDmFYkr4=;
 b=NdHlpYm5czux2kaTMrmhNCSYpBrDuJ7JPjJH9SMuJlFZiEg21HfC852JnwXC9UlCYjd8p2ugdTbLAKEpO+q2sUrqV3I49ZB+MYfkQc7D13v+7ew0wp7JcBSi/u/2JjqTm/ImjL1WG6plV78HdYvSyxqIaViee4dlMjPtw/tdaujoZ2EaFVW5CTbA304cEhe/2QZYQCr9/x1LkHPbLPdOsJEf+cXkvGeE4yf7ySpWXkiOEmt6AIsJWQJclOkbes+AN72pZ1+TpyEsaGkqaVi3AQUjJpyXuuITfQ2MHTKnxUm1J3aftDe+5fl7joPKqkqh331Txu34bs9FCLkyZ4ahLw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6192.apcprd06.prod.outlook.com (2603:1096:400:332::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41; Wed, 21 Feb
 2024 11:15:59 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:15:58 +0000
Message-ID:
 <SEZPR06MB6959010AA0C96A432CE6596296572@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 21 Feb 2024 19:15:53 +0800
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
 <SEZPR06MB6959AAB6B43F3E1F5E1C526596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <6f3f22f6-f659-494d-963c-544cf5f44adc@linaro.org>
 <SEZPR06MB69592FACB1EF1B9FEDA89E5996512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <9a5e9363-79eb-416c-89ae-c826062350b5@linaro.org>
 <SEZPR06MB69594A5036F122CE6C14043C96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <bf4ce87a-51ab-49e1-ac70-c463d8008a62@linaro.org>
 <b4fe5565-9378-4786-8c55-113f9088f34a@linaro.org>
 <SEZPR06MB695943CE42B3A91A22E70DD696502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <94730d0a-0e5a-4777-aadc-4748038a3ca8@linaro.org>
 <7c07c822-5962-41d6-b2a9-8ca6bf125b35@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <7c07c822-5962-41d6-b2a9-8ca6bf125b35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [MlKs0ZaSJlECF2nPuLLcaW3xWOfiHVVMRVjW5sAousLW48ybhdqThcfGdvzVdW66]
X-ClientProxiedBy: TYCPR01CA0115.jpnprd01.prod.outlook.com
 (2603:1096:405:4::31) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <5b8aea2c-b2a0-44d7-90aa-0d2d98225567@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: ac43071b-4828-43cf-19fa-08dc32ce7aac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f5VwnCy+YLuIvHqw2hyaRuSYszAq6kLmJembuGiAK6jA3pKaVyRHPtOp5g6HpLJuNAxZMeqa1aNVy/Ui++t5cgWx0yv6U3GiYJWYI+W1I0ZatfOBCnHHH5YPvzK0j/gVdHjS2d8oB2+2o+54DkTwiPawlzEmb3Mg37EQtxEOA4HWRRp0CgCeVAgs6UOurOLHU4Un3mfMygUkvWCCopKQKwMUDA+HiIBlYJWtfCWApxixUec6wWHpsKkHsotF1Xb5RWyG+yhnMU18JpgCa0OkG1VjyhkLLp2519Ay11WBBWo0eMqQ5yr2Vnmi9MF4rZhTuevaA4g77sZuEzdNYI6EY5n4liVFDRQW/PIKTQxrFtF3gbyCJHzVZfvzC8CVzEMe+GKFBQRnfQGb9yyT+V1+2+MkieV7WAI5pIZeo9iV5PIbF3zKfDnb16sQUhJAqEGPEBgjq9mss/jYWkXO4pfS+2eRd/H8AchChVBOyNBbzejc7zUG1KdGwXljx4/97JCvNjPx2CjXgjg1KbIeTvvHzUNfdlVRRByGvm1woeKO8h1fMPV4zlHwBNxqcQmdikwvcIJ0Nm0szUsOZhInZ+bPA0zeOpTmJUQCQ9sHoIYIq0k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDNvN2dBZWRkME4rRDlRcndnRTFOSkJxcjcvU2hyN1czUTk2cDBvRlRJdDRT?=
 =?utf-8?B?djB0TmlKczhxbHU5c2tLQ0o5eS90S0tsU0o5VWtMOHZoQ3l6V2xKMjd6VHI3?=
 =?utf-8?B?ZzlUWHhNQlh4STkxRXZtQWx3UUdDSWNzVWlMMXNUejAwc3dFQldtZVhqdjMr?=
 =?utf-8?B?bGMvT0p4YVFnVVp5OEpMdTJERGU5S3EyZU12SjFLS1VWbGVERzlDT2piVDVh?=
 =?utf-8?B?S0lsbHl6eEk0bEVzemY0ZTVwYlQvYzIrSTcxMnNIaVl6ekszeXRzMnhRd2NK?=
 =?utf-8?B?THZsTXZWTDc2N0UrWU8zVlVYb3E3bFE1dG5naXFmaVpsS21hVWJCdnBTdEY5?=
 =?utf-8?B?amJUeVJOQnQ0VzVwK3haeG9nYjI4TFJqN2NZZUlKV0dDTkJtanlIak1IUEFB?=
 =?utf-8?B?R0JRVk9BdkxrcW1sZTFNVHMyMFdJaXI1UXRVM2NCYk5wSkV5Z2dYZWlNSlVa?=
 =?utf-8?B?WmhkamRRdGY2VVduSWNGd2xKQ3VxUDc4cHdnTzFEODk5a3BsZWNLZnlKZ25s?=
 =?utf-8?B?ZkNtcHdyUjh3aW8vMzAwTmNLSkhjUUpsZzh0dGJGbUxibnF2ZHNJc2tUaUFF?=
 =?utf-8?B?bW1CeGdsUUhXTi9mYVE2RURzMVkwRE9oMnZwNUp2WXFQSk1MMGdQeUw2NUVX?=
 =?utf-8?B?VzBnM1pXbnE3eFlPbnZIRWdjbW9FazBPa3ZSMHRxZExJeEdKNHdNVXV3TTdl?=
 =?utf-8?B?cWh0N1lnY1liUUhuRERnaFZmQ0srYStldHdydkJZT056THdhMnNDOStsREZP?=
 =?utf-8?B?TmNjOEtuRzZVS1l2SmsxV3RFZlY5a1VlZHhna21vMUd0VUEreTFqRXlqblRF?=
 =?utf-8?B?eDkzVUJLNW1nNjZReFFBaG5EVFRBZHdHNTBhbmtYdjJLUG90b3NVWm56VVly?=
 =?utf-8?B?Ry9namh4TnRMWXdOK3hmTU8vRDVkeTVscndVZE5GbUVTdVh0YzZleW1KdWpn?=
 =?utf-8?B?bEJaVGUzTDJONlgxOFpyWnJ0SDhTQ2R4YmhhS3ZwZUhtbk9ybzlCVGxBVUpq?=
 =?utf-8?B?bXg1LzJSSTdpdVNldzR4UlMrd0FzUFVWdDE0Y0lyNXBzZFo1SXNyeU9Na3Vs?=
 =?utf-8?B?MzFSZzdaVHkyVzB5cUNWa2g5SHlTdWdHa3g3TUtZV2pxdkMraVBKaGhSV3Q1?=
 =?utf-8?B?MzJ0eXFDODhPTStvZlIwR01HNld1VTA4V2V6Q0xFc3JmVFdUdjJBY3pZY08z?=
 =?utf-8?B?MGtmTnVpempHVmdqZ2hidGJKTTdQNHJ5WE1LWkVuRG92SjBQaHlnNXUrMHZx?=
 =?utf-8?B?U25kYnJPZ0QrSmljTmNJRVJENHp5OFQxYzIzMHFmUHFQY0NsOERmRVZHbmVq?=
 =?utf-8?B?a0hsM2hNMFRMaXh1cjVMc2hzTmVKaU0vK2dXcCtwTDE0Qmh1bW41OHUyVmFz?=
 =?utf-8?B?RGs2UlhOS0NqK09VTVBXUmd4VXdmaW1hRmMzdmFMN29TbGlaL1gwSm1MaDNR?=
 =?utf-8?B?WkN4NTg0d1RaTDU2TTBPZ05BQU1LOC8zOGJHQUQ3K0lEMHRka1YxOE9xVFFM?=
 =?utf-8?B?WXZZd2RmRVd3MU9YU0VteUtnNVRYVUpXeTB6YThOR1B4NGJPUW93WGh6VGpM?=
 =?utf-8?B?Und3VE1TeWlWMWpwN3RCY01qcENtcGcwSHU0elN6eVI1Z1NNaFU5RnkxREZ2?=
 =?utf-8?B?eFcwMlNuZjZVblROOVZad1o5MDBRazVBdldibzlQd05KVFdIZWFkZFEyK3kr?=
 =?utf-8?B?YUhwS1M5Q3pGNXZQMUNMTXNJQzZqYnBubWNUNDJuWmxxNUo4ZkhJVnJLVkpv?=
 =?utf-8?Q?9msli1Z5Sfqb8xKJmbfcbIezwIbqeFgBQMgFSdZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac43071b-4828-43cf-19fa-08dc32ce7aac
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:15:58.6185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6192

On 2/21/2024 4:25 PM, Krzysztof Kozlowski wrote:
> On 21/02/2024 09:22, Krzysztof Kozlowski wrote:
>> On 20/02/2024 13:12, Yang Xiwen wrote:
>>> On 2/20/2024 7:43 PM, Krzysztof Kozlowski wrote:
>>>> On 20/02/2024 12:41, Krzysztof Kozlowski wrote:
>>>>> On 20/02/2024 11:40, Yang Xiwen wrote:
>>>>>> On 2/20/2024 4:16 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 19/02/2024 22:49, Yang Xiwen wrote:
>>>>>>>> On 2/20/2024 5:37 AM, Krzysztof Kozlowski wrote:
>>>>>>>>> On 19/02/2024 22:35, Yang Xiwen wrote:
>>>>>>>>>> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>>>>>>>>>>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>>>>>>>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>>>>>
>>>>>>>>>>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>>>>>>>>>>> list due to prior driver change.
>>>>>>>>>>>>
>>>>>>>>>>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>>>>>>>>>>> compatible lists.
>>>>>>>>>>>>
>>>>>>>>>>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>>>>>>>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>       .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>>>>>>>>>>       .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>>>>>>>>>>       2 files changed, 95 insertions(+), 71 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>> index 000000000000..1b57e0396209
>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>>>>>>> @@ -0,0 +1,95 @@
>>>>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>>>>>> +%YAML 1.2
>>>>>>>>>>>> +---
>>>>>>>>>>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>>>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>>>>> +
>>>>>>>>>>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>>>>>>>>>>> +
>>>>>>>>>>>> +maintainers:
>>>>>>>>>>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>>>>> +
>>>>>>>>>>>> +properties:
>>>>>>>>>>>> +  compatible:
>>>>>>>>>>>> +    items:
>>>>>>>>>>>> +      - enum:
>>>>>>>>>>>> +          - hisilicon,hi3798cv200-usb2-phy
>>>>>>>>>>>> +          - hisilicon,hi3798mv100-usb2-phy
>>>>>>>>>>>> +      - const: hisilicon,inno-usb2-phy
>>>>>>>>>>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>>>>>>>>>>> hisilicon,inno-usb2-phy are not compatible.
>>>>>>>>>> Ah, i didn't pay too much attention to that. I should remove the entry
>>>>>>>>>> for hisilicon,inno-usb2-phy in the driver. Sorry for that.
>>>>>>>>> We don't talk here about driver, although I used the driver as proof or
>>>>>>>>> argument, because I don't have access to hardware datasheet (and no
>>>>>>>>> intention to look there).
>>>>>>>>>
>>>>>>>>> What I claim is these are not compatible, so respond to this argument,
>>>>>>>>> not some other one.
>>>>>>>> Why not? Of course they are compatible. All 3 SoCs are using
>>>>>>> Why? Because...
>>>>>>>
>>>>>>>> inno-usb2-phy. The only difference here is the method to access the
>>>>>>> ... here! Different programming interface means not compatible.
>>>>>>>
>>>>>>> Please provide instead any argument that they are compatible, in the
>>>>>>> meaning of Devicetree of course. You are claiming inno-usb2-phy  can be
>>>>>>> used for hi3798mv100 and it will work fine?
>>>>>>>
>>>>>>>> registers. They are all enabled by `writing BIT(2) to address 0x6`. In
>>>>>>>> the cover letter, I said the driver is actually doing things wrong.
>>>>>>> Cover letter does not matter, I don't even read them. Your commits matter.
>>>>>>>
>>>>>>>> Especially the commit adding PHY_TYPE enums, the name is confusing and
>>>>>>>> conveys the wrong info. It's not PHY which are not compatible, it's the
>>>>>>>> bus. I'll fix the driver, but still the PHY hardwares are compatible
>>>>>>>> between these 3 SoCs.
>>>>>>> Provide any argument.
>>>>>> Just take a look at the driver. hisi_inno_phy_write_reg() is the
>>>>>> function that differs between different models. But for all of them,
>>>>>> hisi_inno_phy_setup() is the same.
>>>>>>
>>>>>>
>>>>>> hisi_inno_phy_write_reg() should be moved to a separate bus driver. It's
>>>>>> bus-related, not phy. PHY driver should not care how to access the bus,
>>>>> So drivers are compatible or hardware? We talk about hardware, not
>>>>> drivers...
>>>>>
>>>>>> but the bus driver should. The PHY driver only needs to use regmap_*
>>>>>> APIs to "write BIT(2) to addr 6".
>>>>> Different programming interface, so not compatible.
>>>> Although maybe I jumped to conclusions too fast. Do you claim that all
>>>> registers are the same? All the values, offsets, fields and masks?
>>>
>>> I don't quite understand. I've said there are two register spaces. One
>>> is the bus to access the PHY (i.e. perictrl for mv100 and cv200 and mmio
>>> for mv200), the other is the PHY register space. So if you are talking
>>> about the prior one, then no, because the PHY is attached to different
>>> buses. But for the latter, yes.
>> I am talking about the register address space which the binding document.
>>
>>>
>>> So here we are talking about two devices. One is the PHY, the other is
>>> the bus the phy attached to.
>>>
>>>
>>> The old binding is mixing all the things up because INNO PHY is the only
>>> device attached to the dedicated bus implemented by perictrl. But it's
>>> not how it works. The binding is for the PHY, not for the bus.
>>>
>>>
>>> For mv100 and cv200, it's: cpu->perictrl->inno-phy. For mv200, it's:
>>> cpu->inno-phy. cpu always accesses peripherals with MMIO, both for
>>> perictrl and mv200-inno-phy. But if the inno-phy is attached to
>>> perictrl. CPU must access the registers of inno-phy through
>>> perictrl(Here perictrl act as a bus driver like a I2C/SPI controller).
>>> For mv100 and cv200, the difference here is only related to to perictrl,
>>> not the PHY itself. For mv200, perictrl does not implement this strange
>>> bus anymore, instead the phy is attached to system bus directly.
>> Your driver writes different values depending on the device. For one
>> model it writes PHY0_TEST_WREN+PHY0_TEST_RST+PHY0_TEST_CLK. For the
>> second PHY1-versions of above.
>>
>> The PHY0_TEST_CLK is written to the "reg", so I understand that to the
>> device address space.
>>
>> If you write two different values to the same register, devices are not
>> compatible usually.
>>
>>>
>>> I don't understand why you say they are not compatible, simply because
>>> they are attached to different buses. For x86, peripherals are mapped in
>> I did not say that. I said that according to quick look in the driver
>> and to your explanations you had different programming models and
>> interfaces, which means devices are not compatible.
>>
>>> dedicated IO address spaces with `IN` and `OUT`, while for ARM, they are
>>> all attached to MMIO buses like APB/AHB/AXI etc.. So peripherals for x86
>>> and peripherals for arm are also not compatible?
>> Depends. You did not answer to my question whether you even understand
>> what is "compatible", so I assume you don't. Compatible means
>> programming models are the same or one is subset of another, so
>> effectively both devices work with the same compatible and everything is
>> fine.
>>
>> Answer yes or not:
>> Can PHY1 type of device, so hisilicon,hi3798mv100, bind using
>> hisilicon,hi3798mv100-usb2-phy compatible and operate correctly, so you
>> remove hisilicon,hi3798mv100-usb2-phy from the driver and device
>> operates correctly?
> I mixed compatibles, this should be:
>
> Can PHY1 type of device, so hisilicon,hi3798mv100, bind using
> "hisilicon,inno-usb2-phy" compatible and operate correctly, so you
> remove hisilicon,hi3798mv100-usb2-phy from the driver and device
> operates correctly?


No, currently. But it's due to the fact that the bus to access the phy 
registers are not compatible. Not the PHY itself is incompatible. So the 
correct dt node (which represents the real hardware) for mv100/cv200 
should be


perictrl@8a20000 {

     compatible = "hisilicon,hi3798cv200-perictrl"; // or 
hi3798mv100-perictrl

     phy-bus@124 {

         // the bus has its own address space

         usb2-phy { // the PHY does not need an address

             compatible = "hisilicon,inno-usb2-phy"

             port@0 { // the port needs

                 // To enable a port, we need to write BIT(2) to address 
0x6 from phy-bus@124

                 reg = <0>;

             };

             port@1 {

                 reg = <1>;

             };

         };

     };

};


In this way, phy device gets regmap from parent bus node. So i would 
insist that the PHY is always compatible. What is incompatible is the 
bus to access the PHY, not the PHY itself.


Please note ONLY hisi_inno_phy_setup() function belongs to PHY driver. 
hisi_inno_phy_write_reg() should be moved to the (not implemented yet) 
PHY bus driver instead.


You say "programming interface" is different. But i'd say it's not. On 
the opposite, it's the same in fact. Because all of 
"hi3798mv100-usb2-phy", "hi3798cv200-usb2-phy" and even 
"hi3798mv200-usb2-phy" are sharing the same hisi_inno_phy_setup() 
function. And here is the key, this function should be considered as the 
"programming interface", not hisi_inno_phy_write_reg(). And this is why 
regmap API is introduced to the kernel, I think.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


