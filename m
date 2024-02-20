Return-Path: <linux-kernel+bounces-72841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A38C85B947
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCECB22D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE629626B2;
	Tue, 20 Feb 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IJakxOFf"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2062.outbound.protection.outlook.com [40.92.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6A62178;
	Tue, 20 Feb 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425637; cv=fail; b=cHCDQJgpOHRzGksF+hXssn7YbWp2+4+DPL4uEjVy+v/2JjAdlyqbUXrsNPFOOMhEa9DQ/jh2AxKe3+0MlpAlANCHl9Dgv26TACQMvfAC7Dzp0ESyyGXcJADL5debDcOnutz9XaLvh7wbeb1ZXoQ5I7VGU/LmCfddelHI6s3hRCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425637; c=relaxed/simple;
	bh=Sg/F9PoHkl/mH205HhPyR/75FS3nwqwEnGydsjLgZow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pH9EdmJ4qx1LBLnKdc6KoM35SWNeIBom4pJv9gtyedPX25mGZSFaB0Y2INUDDioZw6basWuwLjVzSEWB1oKkLzyaHfIniF8Vx2720106FMVAEfoxzzBB81K9uAA7KAOQxf6WiZQNK76q0E93S/gyg2B06sEfTyvn2QWSyQ34h64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IJakxOFf; arc=fail smtp.client-ip=40.92.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/NRIEQtLzznDvg3TlweP1yLnkF2tGLgiA1WB5Ft/acczIMXhYaQj5nrVDo27ExVEDCTUWNkmaoid1YHsvHijjV9yW3QkmrZ25nn0nYhii0Z8bW1706AjNs6kvbZkVdPcs7ep588n//O/mgiZ/pi0IxyF70Juh+Zbxzd9hZGu4H37aguMynWxZGyb7KYV47ysJ5LGqkoIkq8MOmEO8uubY6YNfXy+O8vl8oq2mncO7vxc04psPa4xZ5C1gJxUFYiNNLl76CPEXrI5KvcF6s7S33LTH3Tmtyvj7jmnFVH3vKi302mMCGjGmDoAs9iWyOfrSumc/o61nAZXhFWZYtCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynzqihl5m6RG2EHU6ulgyrEty8/XuckZJ9LfbS+ymG4=;
 b=FBPb8D121NpXa7G98bSmlNZYz1Gj21BFdT5+6409hMySn+EeRmNDz2ReU7hilOGgBtZFFdtHETVLnz1b+q+bzD6nNFteYZk6Ie6g2/AQvFbgxNhSalXuAnd1v5oL8ApT8pYJdgYVEh8MKNYMQ4PxvB/rmFFeR48+R/HI5deLKyvV4R+iYEs4zch11e8+N1o4ZExUw9GUVR64kEUQB9fejGG+TOam6tpys4IF4Ksbhj9Szkkmhcp2QOTOMNKgc8MM4+IITHSouy9TThD37PnuJcrKuVNWccUusPj3NKmscb2UcZRKIF3vYLxi5qDTbTbS/vRUp5+ylzYlnMJL4+6KVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynzqihl5m6RG2EHU6ulgyrEty8/XuckZJ9LfbS+ymG4=;
 b=IJakxOFfYCj6Ai8/d2nM7PHmQBIl0gongrK1YK0Eudso4Fv3ZussgSU2bXd4qJuSxMvyOCt8GUwxDNbbeg2cskaAeQxFjCQptmmlGWEjPn++tajaq2Sp1abeYBD9D4iUN2s6uFkDT43eZwUEWUZ+Bt1qp+clNszlqAx5wWHv6nqlxIopU/RvIW5bHciQfmUY+RWt1tBTFEQ/fwygy23amvfbVyw3yv7Sg0w+tRjhOlnhvAabT1eZIqjKFXppaYHKqDy/XnBTQIEVX2ybUPJhCN5Kk0CZhER/Qv6kSu83vXWanLZDe7bunU4MB0BpwNqbztIuyAwUsM8erZsqSmVtUQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PSAPR06MB4343.apcprd06.prod.outlook.com (2603:1096:301:78::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:40:28 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:40:28 +0000
Message-ID:
 <SEZPR06MB69594A5036F122CE6C14043C96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 18:40:23 +0800
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
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <9a5e9363-79eb-416c-89ae-c826062350b5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [1SEx1yBc0sVBU2Q+aWh2FHRG/vhUrhr02WLJQEGsv5OjZnhhInLqBcnkzNYvCRY/]
X-ClientProxiedBy: TY2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:404:e2::33) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <1615f7c5-21bd-422d-84fa-fbffcaa56454@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PSAPR06MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: c2800f1e-e7c4-42fc-984c-08dc32005a63
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rcmCUaLiMk7znWigMA9hihrJAMvNbzU/Pr+PRScoiD6Hk4L9TD35mN+yxTVPJ0sGbOcNoUs/ffAp/Et7Sk7avAbCau+5JVdjcr086bVBAAg3kLUjvs3B1L0kNiWyo8c/ozh1VoGMOYIcTgcIE7+GwhsQ1sbr/XDfTNYK9lM1yA8SzmBRZgjEvhzHacTlXjJd9/IRiwV9YPwjxdo//luVCUrIJc2cp9jqQz/7JjobeoGpPnAExMdFBlk9FUpEQZmY1I0hggQ4+fDPNOQvBIpRAs8XlPbzv0xCkggL6kllkwUpX2KcV1ZAnir1uy0DjlAJvKxaGHYmCvpmWk2KYiHCNtM4PQt2BbHz1NxQJjWb0O20Ogzjp4idAqgAEc5kQOrQRi/VXsHQ7VbWuZf6gWRnOFGQsSk65xEHciH0FBQWTo2/KMwgNntsWndGiRfwm6f6pFo2tesiPtFVJmxfsKWzLpiZaop8506AwfY0xWUeSFFmUtrG5okazJR4uO6pRX24NuiqFYN7zojDu8NMQbVgpzynMMVvYdMps8eb069uc2Xxh0wYQn9lX+hZASsH/hfuPJpIm7hM8Kvz8lMbBU3sNXbol1xHnavb+GNsbbX4YQU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yi9iWjhtcThOamdVYVFxVVpqbXQrRmliT1NISzZaSXRaeE1CazBVUGg0aFJD?=
 =?utf-8?B?ZU5GM3BYenY3MWtOY0VCc2haWjJxVzNTWEZuY2JuVzdyc0VveWh3b3FTeU4r?=
 =?utf-8?B?ZkZzM0d6T3AyR3Z3ajllV2Y4bmt6TDlPR2JoSG5MK1gxSjYrTGc2b0NxS2E3?=
 =?utf-8?B?UWd1RFZpSnlHQUJFRVF1OGVQTmNtMEpvdFBOWUh3dEJSQjdvb0tCaXJDOCtL?=
 =?utf-8?B?VXdZd3QvY0ZWREpNM3BaMVJheFZEV3NUVHgrN2dTdVB2U1N3d0J2OEthRHlD?=
 =?utf-8?B?RnZyQSszbm9UK3dZK0JKeVZuSlI5d2RiZE5rR2dDdG9aMEpBQUMzL3lQd050?=
 =?utf-8?B?VUJOVHJSWE52UDV5dmJWZ1ZTb0hnMmFFMGxBZmk2eWRtVVJzMmJ1MzBOcXZi?=
 =?utf-8?B?UklQYUhsWVBya3pOazBsZHdwc01tMzhMamE2Nm5WMnd6OGNuTUxaWlQ2ZUlD?=
 =?utf-8?B?RlhjTGpsYTQ3MGxhRytpc1NpYlVpY0p5NG5JbUN1YVlZR3hPeUxacUtpMnAw?=
 =?utf-8?B?NHJ1QWN2UitTR0sraTQzc2JJa1A4OWpaVnF5U3hvd1dUdE1UbHhQVnZ3T2Q1?=
 =?utf-8?B?WTdscUlhT3ZKV1orM1QzZ25qbmNwNDZ2Wmpnb21UYXVBWWJHYUhmTSs4YkRx?=
 =?utf-8?B?U0FZVFc5T2s4aHRwR0diRjkrdVdyemtNaTdBVG44QndvRzQySm1IbmQvRU93?=
 =?utf-8?B?OXpKcFdxeG0yS2JNT3dsa3NRUFJLZVd6bTVLTmNLVHo4ZGNWbkk2aVlBOWJX?=
 =?utf-8?B?bU5MS1U1WVdpVEpNNnhDN0swck5WbG54bDNuVWVJVkluZDRtWWRBdSsxd3dT?=
 =?utf-8?B?UlUxWGRUMmVxY1VQK0p5NmduYVUzUldOZ2NBcGZxQzNqWnlIUnFiY0t5dmF6?=
 =?utf-8?B?eUlXQXkwSUgzcDFIK2NMVjMwcTZkWnMzS1RmcFlRMU1sRDJwdHNvUFRmd3N2?=
 =?utf-8?B?K09Va1ZVbE5Fd0tYR1JUak95NkJCY2E4ckZsQmZGUTdjdG1YdzNmVEIwR3dS?=
 =?utf-8?B?QkdPZnZpWmtnMytXeGM1Z3FCM3lzNWhuVnFiVnI1L1ZKbmZNM3ovSUZqcTEx?=
 =?utf-8?B?SGVCZkJhMDkvKzhXYVI1aXhrcEgvblFOd2R1UkRyNng0UWRrdEhpS216eEdK?=
 =?utf-8?B?bUpFTEZNOXhLcXNpd0JxaVdZWWhQNGFIQjVIZTdwM0xCV2haY2g5NldGQUdL?=
 =?utf-8?B?dE42bGJ1OUZOOU5TV0p0Q0huMjl6L01XMkdNUVdXMXJNQ0J1UkFhaXZ4d1JD?=
 =?utf-8?B?N1ZzV1NLdXBRdFBqZG5GRlE2eUVia0FBUzhwU0wwVDYxd0l1ZDlBQWxRdlNs?=
 =?utf-8?B?SFFiREpiSzRuSGhwQUZmbDMrbnI4OGtiZlQ2TDR6aXd5aWREZjhXeEtWblV4?=
 =?utf-8?B?ZzJubjhsZm5mNE90ZlJmUXExdEZqaFZ3T3o2TGRhV04zb0tFWjZTbnozRWk5?=
 =?utf-8?B?U0owTEtZcDlrZHdKaktCaHlnbERLUGNNMXcvTG1Ec3dGY2ZLRWZQc1FGWFJM?=
 =?utf-8?B?YVRrbElEeUhnN1RJY29jNGloRkhzQ1NLMWJ2WUh2VHhZK0huSDZVQ1pHMFlY?=
 =?utf-8?B?RmpML2o5NWMyS3VIOUQ4R1JUVWNKQlQxb2JhZVliUTZHcWYzcExQcG9uMWxh?=
 =?utf-8?B?Q0dGL0xHcW1DMGFiRER6dkpiQmRoYksvd00zWFZyV1BDU2Nsc3lIRERxeDZE?=
 =?utf-8?B?UStFOS9qT20wM0JHSDhBdkRFeHBDcUVBb0pFTytXRVBNY25NekxnSUdOVnVG?=
 =?utf-8?Q?gYxNF2em7AS7kIw/m9Hp7JrT6Ftuc6QzDvI1bNv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2800f1e-e7c4-42fc-984c-08dc32005a63
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:40:27.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4343

On 2/20/2024 4:16 PM, Krzysztof Kozlowski wrote:
> On 19/02/2024 22:49, Yang Xiwen wrote:
>> On 2/20/2024 5:37 AM, Krzysztof Kozlowski wrote:
>>> On 19/02/2024 22:35, Yang Xiwen wrote:
>>>> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>>>>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>>
>>>>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>>>>> list due to prior driver change.
>>>>>>
>>>>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>>>>> compatible lists.
>>>>>>
>>>>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>>> ---
>>>>>>     .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>>>>     .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>>>>     2 files changed, 95 insertions(+), 71 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..1b57e0396209
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>> @@ -0,0 +1,95 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    items:
>>>>>> +      - enum:
>>>>>> +          - hisilicon,hi3798cv200-usb2-phy
>>>>>> +          - hisilicon,hi3798mv100-usb2-phy
>>>>>> +      - const: hisilicon,inno-usb2-phy
>>>>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>>>>> hisilicon,inno-usb2-phy are not compatible.
>>>> Ah, i didn't pay too much attention to that. I should remove the entry
>>>> for hisilicon,inno-usb2-phy in the driver. Sorry for that.
>>> We don't talk here about driver, although I used the driver as proof or
>>> argument, because I don't have access to hardware datasheet (and no
>>> intention to look there).
>>>
>>> What I claim is these are not compatible, so respond to this argument,
>>> not some other one.
>> Why not? Of course they are compatible. All 3 SoCs are using
> Why? Because...
>
>> inno-usb2-phy. The only difference here is the method to access the
> ... here! Different programming interface means not compatible.
>
> Please provide instead any argument that they are compatible, in the
> meaning of Devicetree of course. You are claiming inno-usb2-phy  can be
> used for hi3798mv100 and it will work fine?
>
>> registers. They are all enabled by `writing BIT(2) to address 0x6`. In
>> the cover letter, I said the driver is actually doing things wrong.
> Cover letter does not matter, I don't even read them. Your commits matter.
>
>> Especially the commit adding PHY_TYPE enums, the name is confusing and
>> conveys the wrong info. It's not PHY which are not compatible, it's the
>> bus. I'll fix the driver, but still the PHY hardwares are compatible
>> between these 3 SoCs.
> Provide any argument.

Just take a look at the driver. hisi_inno_phy_write_reg() is the 
function that differs between different models. But for all of them, 
hisi_inno_phy_setup() is the same.


hisi_inno_phy_write_reg() should be moved to a separate bus driver. It's 
bus-related, not phy. PHY driver should not care how to access the bus, 
but the bus driver should. The PHY driver only needs to use regmap_* 
APIs to "write BIT(2) to addr 6".


For mv100 and cv200, the PHY master bus interface is attached to the 
perictrl core in SoC (though the perictrl core provides slightly 
different register offsets to access the PHY bus). For mv200, it is 
directly attached to AHB/APB system bus so we don't need to put it under 
a perictrl node anymore. So here, clearly it's the bus the PHY attached 
to which is different, not the PHY itself.


That's why i say the driver is wrong from the beginning. It's mixing PHY 
driver and bus driver together but they ought to be different. PHY is 
always compatible, but the bus is not.


The correct fix should be moving hisi_inno_phy_write_reg() to a new bus 
driver and migrating to regmap_* APIs in PHY driver. But i'll have to 
write a new driver for that, which i try to avoid (it takes too much 
time!). So i said clearly in the cover-letter this should be considered 
a hack.


>
>> I'll say the driver is broken from the beginning. They should move
>> write_reg function to a separate regmap driver and only left `write
>> BIT(2) to addr 0x6` to the PHY driver.
>>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


