Return-Path: <linux-kernel+bounces-34894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8E8388ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1AE2849BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEA55676A;
	Tue, 23 Jan 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="OZDWVUNH"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazon11020002.outbound.protection.outlook.com [52.101.133.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E316C6121;
	Tue, 23 Jan 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998562; cv=fail; b=Jg4mg9XJ+0xs9HfcAMitiaB0xZ5FmwhG6qqaYAqUN2bjrwWQcd+PEwCh9D8A51fBBSigFqgdobgHnvR7PDOsD2Bae/d7EqNxwBqWUlywakmkHUdewS82oSNSJUNPbAwublz/aKU7FAb2oEFGofSo+7xpV48zdul4bNbkwG2qZFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998562; c=relaxed/simple;
	bh=GAp7sNGPnT3YHrHK/7pZvmBkD5dF1hS2RatU2HQf1NE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLwARgKlNigFK4MHY0a65GB7l/0YyRLlaXbsNTYgoGkeHHamIJjFNKE1+F5ZVrOCwMa801gf8wTHEUCovwmrnX9OGdzuZSL+Q0c5b9AajupWwR9Rd62HySA+qvjZNxa0pN4hHD9ouSiN6AjeChnUouiBl/SIUFGnzABSHukKmBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=OZDWVUNH; arc=fail smtp.client-ip=52.101.133.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/bkCC7NfGbg0Wqi3/0DWg2XsZE5LJfxVl2lfEsAfg7WE6kMR1U9dp0goOVqb9i/IcGQHO5ZssNFV0xbGfIqdNz1Uj67PPeG/sAF4UicVLOutsjwjiauYGn5m5lrKUL2rn5nxCYEEnEpb910GKorsHg9vHRxOIERR7qv5T2dVc6uytSxcEzJW5iF4xhuiBgOozWuzWHttW0YqGGE88RBaT9iEA4WKpzf54VWPNomz2RVC2l6RuqCS2v58rBs7n8EIfv2Ak8trwZxEKPnK8Wg4tJKAYjFKVXihOdA6YQEMwkCfI+lXekuAcuMwNw2wmKjX3HplnLk933mbrNeT3SF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcNGOnC5SvB38mXshBQi3U0sHED31FtI2sBciK8GJsk=;
 b=n5oLkNzqcIWgH0oAMWe640OJRc01lcW9//sKCLpYEwxF9lg0fBRTD/x9crHvUo791u8QE7VwF1MoJgT0jcBkdTjkY+vI3QSrVIXnQ3owaiHvCUZm0t10vkzdnbx/X8Dq2N+6OX5gU7IwiBfOo2Y/U84fdVBbqtSpj4kfrI9qoZwGC9+dJLf7r44N9/Mj7OdQ7PheiES1xAU6Gw1baQhLGdXm8YhE+Pi/4MUi6UeLWBNTgjEmMO7W4jA3lYLcp1aOYqhow50C3pw8fRYFttFuiZscR2o2eTTW67luvGoV8rv36PJzFZkggDyhX6Xaqpg62/zAypHQCVfDKnD+8GN2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcNGOnC5SvB38mXshBQi3U0sHED31FtI2sBciK8GJsk=;
 b=OZDWVUNHKgv66zm/Al/icTL0nlxTm/sYc0YO8xBDPk/mERU1BtGgJvWsIX2BxuzNpg6cZwDgr2qdZYOlG7QG8bNpQKO/Vgzc2Jf8Mp2VvXqw7IFu3a8IxhG/JqPfXOYhQqiydUFPxlIIEv1iX9PT1cs0NI0cq34qJci/t4RDPtKFqm3KDL560PoGqQ6e6Fhb2LQquenRvb0OG3mtE9vwzfgHQxm5MfiA6wwf0IQ4wp7xfMGbvZEpsM7CQX3NW4E8rOOgJQ0KNmTHbxV71+aO2JCfFkPAtHbDBOD2zzb3pxBWElfW4yeISncALAHh4vyAqrRlIQqxzlNQ5ECZRD4AwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by KL1PR0302MB5428.apcprd03.prod.outlook.com (2603:1096:820:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 08:29:14 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::bcf5:a954:cee6:a0ed]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::bcf5:a954:cee6:a0ed%5]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 08:29:14 +0000
Message-ID: <66299b86-311a-43ff-a06e-9698dec5e804@amlogic.com>
Date: Tue, 23 Jan 2024 16:28:34 +0800
User-Agent: Mozilla Thunderbird
From: Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: pwm: amlogic: fix s4 bindings
To: Jerome Brunet <jbrunet@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-2-jbrunet@baylibre.com>
 <awxboh3nv4r5p7v7vcgwttu2m74fws47johb73c5f7econ2qqu@zl5xbnoeyclq>
 <1jbk9kxm52.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-GB
In-Reply-To: <1jbk9kxm52.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::16) To TYZPR03MB5743.apcprd03.prod.outlook.com
 (2603:1096:400:74::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|KL1PR0302MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: c625db98-fa1b-4179-1908-08dc1bed61be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SM0SnPZT/DVL9tC5kjnjTE6AbpgrhU6m+YQ8NeOcDMnNbtm1fXspFgVBVrbIqNVM52EZDoas5cKAZa81ei2OjK5jdyWvcHNa+ah7Qz3rmBJ77gLoAx+131az1bp0xKnGzuH36QY9+R3/mOvlnXK+qlevWCl79+R8N++CEeDJhgkjf5CJ3lh44N/XDvoHYEZf4UMFNBzWTrixCJv6zOAx5wddjDUo0+Olkh6jEIJ0ivw8q/0sBbyuXK9zWRHI4AqaarjUol2OzHbszQi4Qnch9u/g9xXItzs6Uzd1xjZEUni9hWZGm4GSTJB0IBu3uqQmScuID6ta6wbJTOTlt7fHY5mRLkv/6eCQinAE52CoPZwK8d6tKFBpPYDkCrgJZgDhdhYH6K7TjUl6RJrNf3je+CNizCsYDXaZR+tNAMq7pv5Tf+coXSNDotV2yZr6M/B3HbfjxjFJAsEW8WmUw7pBJ7xjiz0csVWzKJAWgbNXhCOAYSG/myEwtnPcWWBe7TvxeyoHpG7GGnggKpIlSXrfAycfJ+0lgLP2eQGapHgR9uYYW3S8fFBmyiu197u+soUllVwXRca8wT9tkCJvic4AwguHra2bkJRLrF44k4MZohh2jKQZlFZ+MpJKB5jF0s+PKqFJJLRf8r2P/8jiwVLwP3H+O2hgPhTxU/OMpWPYkFqTw40sUcEnLmq5GtUftQZM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(346002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(53546011)(6506007)(54906003)(66476007)(316002)(66556008)(2616005)(110136005)(6512007)(66946007)(5660300002)(26005)(66574015)(478600001)(31686004)(6486002)(6666004)(83380400001)(44832011)(2906002)(36756003)(31696002)(38100700002)(41300700001)(86362001)(8676002)(66899024)(8936002)(4326008)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzQvSWxDczNRUGt3VHpxQlFwOGMrODFLTlZIUEVLYWRTTFJSdlBDY0tiakFX?=
 =?utf-8?B?ZTBWTjRYZnlLU2ZtMU5lSmxXejltRFI2eDdlVldlRE5xRnY3bS9janhIWWlK?=
 =?utf-8?B?UWpOSkQvSEpndXREV1R2ZStPTldjUi9kNmI4RzQ2YlROclBCcGhYVVZQd3Zu?=
 =?utf-8?B?SmRQT0RYb1l3QjFMNThZQUl5Nis3Um9MMjlsWVdJdmh4U1lyOTdJWXdhQjlt?=
 =?utf-8?B?NlpVa0N1NWhvek81TFE5ZzN5bjdNL29HSDU0bTRpb08zVjZhTFovajd6anNv?=
 =?utf-8?B?OWhhbTFtM2tYSytDYkR5SlZ6cGdzYk9mRTF6NklnZDZ6UjhmYjUvNytRcUtm?=
 =?utf-8?B?T1dkbTJsRk40cDBhMVBOQ0VEQVAwMTRFVGlTcS9sQ1VaQzZ2RXVFTHNEWUtY?=
 =?utf-8?B?ODl5RmtaY1dSZ2xramNUb1VBdjFzOXQ3U1h5QWxPdXNGTmZ6V1dZM29WRklH?=
 =?utf-8?B?d2RLTTg0UVA1czBiZGJGQkdXZ2dPbmZ3c1dEUUNNRXZBYVprYTVFMzhPaFND?=
 =?utf-8?B?YjdSbmJuTGhkZEpwL2tGeXpTRjNkK0FNanljN21VYkNKRHRjQmxUb2ZTajhG?=
 =?utf-8?B?ZldKQVZNT3BNRElUSENTWmJNUEpLbTFUM211Y2ZNdDV0WVNudHlDV3pQZzRZ?=
 =?utf-8?B?YXh2cUhlUlZtd3NnbjZGd0xEdTRuVGpoT0gyVlNPVWNScDhpM0NHaUhqR09W?=
 =?utf-8?B?ZGFnY1RUcHdNTjRTY1JkWk81ZGlaT1JCM29CS0JacEk3d0Y5amtjY3JLQU5W?=
 =?utf-8?B?L1BVaDd2R2dqS0YwenVNbEhjVEpLRVoyVFVnTk9yTzFHTTNsZW9BbEJyWEFX?=
 =?utf-8?B?aWNlY2trbUdzWkRyRUsrR0E3YTV4Mk12d0ZadS81ZzRrZXlHY0NOY0hpNW15?=
 =?utf-8?B?WUdhMXYyMHRmTXp1Um1tUGVTNVpBV0QyNlcxMlFCelFvOEQ0eGJSSGVJMjRm?=
 =?utf-8?B?b1IxYVFJUUdDdFZiZzhjd1FZSWFjZmpWOUtSZTFHZ3ZJMHR3TmdHdC9UK2FV?=
 =?utf-8?B?VjNqMk9XdkJOM2xJSFdjZHVoeE9yaXlKS1VHSDROeVk0Wm94bEZ1WnJjZjVL?=
 =?utf-8?B?a0xoOFQrd2tFMW5VQ1BoOXFOVkxKOEZiaUZmSnhkWTMxNTY1dzdDQWNSc0RI?=
 =?utf-8?B?NmMzanZlUENTYTQ4ZGxzanFlRzdabEUwMjZZM2NDNGx0NUg5VDZWTXZmSEVM?=
 =?utf-8?B?bUVOOXovNEJXb3BLOVZLUFhvS1ZJa1duRlZBODh5WmtURGppajJYelZSdXZL?=
 =?utf-8?B?RGgyRGtSZVRhZjhTSHMwZFhYL3l2K0kvWUdwenIzQThjSlNiSVJFZFljeFc1?=
 =?utf-8?B?OVJocmZvRGYycmRBZ0IvMnlxMWEzNE83Mng3bVpCYThnUG1uVHVQNHlURnZS?=
 =?utf-8?B?enNjR3BDRFQxbXhMaVl0alpXWUNHUVR4NkF1L0RIZEpSb3RqWGRZekpVM245?=
 =?utf-8?B?aTRDV0Q0dUZ0bnZ4bUpLUTlZU2V0K2NlRmszTVltSGRicDFpNERQc1B4QStN?=
 =?utf-8?B?UmJnaFd5MWh5NG0xWjVRVythU2JuT2Rac01HSngrZzZqTXhLZHdPdHVzY1dr?=
 =?utf-8?B?YmNiOTkwYVFKNU9WV1FlY0xlblZjTXcvZitnWStoUkh3UmlYek1Uc0IzcFo3?=
 =?utf-8?B?WEhHVmxsR3BkYlJRZjRVVTlUL0o1VmNvdjNZMXVHNHFCNmdxcWdpZW5Eb1VJ?=
 =?utf-8?B?L0M0Z2oyRXpmUWgvS1MyV0lDVUhoQ3FMWGdHV0xVck5IT2ZOWC9LaGs3QUlp?=
 =?utf-8?B?T2ZDRS9rYzQzTDQrUit1YktaUmhmazM2OURyam05aDBUMGd4U0pJVkZtM1lw?=
 =?utf-8?B?WkJvNzRrU0pMVUZPQU1aSGhhZit4c0tIQUpLWGJlS2xaeFdXNVNQUHYzdXQ1?=
 =?utf-8?B?bFVKUzBpY0tvcHVCUG5nSlRMVmQ4NXFiQ0lZS01uWmhrZXJTZW43NjJKSWlw?=
 =?utf-8?B?aFUrNEIxdlF5T3R1azllMlhYOGZpTHcvNnZBRFh6MTlZVy8vaHFlYzkrZ1Jv?=
 =?utf-8?B?VlVXWktkRERqbkxCRW1JMUpYcWFFc2JUeTN2SEZSNmxNdmx0LzROSzNTUGdP?=
 =?utf-8?B?YTJKMGQrWkN2UkpveURiOHgzMW9aSyt6c0x1eHBCQS92SjVwTmFjZFZnckhR?=
 =?utf-8?Q?J053f3tQ6FOPygPHSjeKKP6wZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c625db98-fa1b-4179-1908-08dc1bed61be
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 08:29:14.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxjmGu0U9PNN1S6YVz6VpO7nmeeb6/kxiRd4QTj7dp5/Li2ELvMcKd5cfr+gwfZm8TMJPtE2Lqzj+NaQyhnDVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5428



On 2024/1/17 18:30, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 17 Jan 2024 at 11:03, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
>> [[PGP Signed Part:Undecided]]
>> On Fri, Dec 22, 2023 at 12:16:49PM +0100, Jerome Brunet wrote:
>>> s4 has been added to the compatible list while converting the Amlogic PWM
>>> binding documentation from txt to yaml.
>>>
>>> However, on the s4, the clock bindings have different meaning compared to
>>> the previous SoCs.
>>>
>>> On the previous SoCs the clock bindings used to describe which input the
>>> PWM channel multiplexer should pick among its possible parents.
>>>
>>> This is very much tied to the driver implementation, instead of describing
>>> the HW for what it is. When support for the Amlogic PWM was first added,
>>> how to deal with clocks through DT was not as clear as it nowadays.
>>> The Linux driver now ignores this DT setting, but still relies on the
>>> hard-coded list of clock sources.
>>>
>>> On the s4, the input multiplexer is gone. The clock bindings actually
>>> describe the clock as it exists, not a setting. The property has a
>>> different meaning, even if it is still 2 clocks and it would pass the check
>>> when support is actually added.
>>>
>>> Also the s4 cannot work if the clocks are not provided, so the property no
>>> longer optional.
>>
>> s/no/is no/
>>
>>> Finally, for once it makes sense to see the input as being numbered
>>> somehow. No need to bother with clock-names on the s4 type of PWM.
>>>
>>> Fixes: 43a1c4ff3977 ("dt-bindings: pwm: Convert Amlogic Meson PWM binding")
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>   .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 67 ++++++++++++++++---
>>>   1 file changed, 58 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>> index 527864a4d855..a1d382aacb82 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>> @@ -9,9 +9,6 @@ title: Amlogic PWM
>>>   maintainers:
>>>     - Heiner Kallweit <hkallweit1@gmail.com>
>>>
>>> -allOf:
>>> -  - $ref: pwm.yaml#
>>> -
>>>   properties:
>>>     compatible:
>>>       oneOf:
>>> @@ -43,12 +40,8 @@ properties:
>>>       maxItems: 2
>>>
>>>     clock-names:
>>> -    oneOf:
>>> -      - items:
>>> -          - enum: [clkin0, clkin1]
>>> -      - items:
>>> -          - const: clkin0
>>> -          - const: clkin1
>>> +    minItems: 1
>>> +    maxItems: 2
>>>
>>>     "#pwm-cells":
>>>       const: 3
>>> @@ -57,6 +50,55 @@ required:
>>>     - compatible
>>>     - reg
>>>
>>> +allOf:
>>> +  - $ref: pwm.yaml#
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - amlogic,meson8-pwm
>>> +              - amlogic,meson8b-pwm
>>> +              - amlogic,meson-gxbb-pwm
>>> +              - amlogic,meson-gxbb-ao-pwm
>>> +              - amlogic,meson-axg-ee-pwm
>>> +              - amlogic,meson-axg-ao-pwm
>>> +              - amlogic,meson-g12a-ee-pwm
>>> +              - amlogic,meson-g12a-ao-pwm-ab
>>> +              - amlogic,meson-g12a-ao-pwm-cd
>>> +    then:
>>> +      # Historic bindings tied to the driver implementation
>>> +      # The clocks provided here are meant to be matched with the input
>>> +      # known (hard-coded) in the driver and used to select pwm clock
>>> +      # source. Currently, the linux driver ignores this.
>>
>> I admit I didn't understand the relevant difference between the old and
>> the new binding yet.
> 
> Let's try to explain differently then:
> * So far each AML PWM IP has 2 pwm.
> * Up to G12, 4 input PLL/clocks are wired to the HW IP and there
>    mux/div/gate to select which input to take.
>    - The historic bindings just described how to setup each of the 2
>      internal muxes - 2 optionnal clocks.
>      The actual 4 inputs names from CCF are hard coded in
>      the driver. This is a pretty bad description. The driver has been
>      updated since then to use CCF to figure out the best parent
>      according to pwm rate so this setting is ignored now.
>    - The 'new' bindings (introduced in patch #2) fixes the problem above
>      but the meaning of the clock binding is different. It describes the
>      actual HW parents - 4 clocks, optionnal since some are not wired on
>      some PWM blocks. To avoid breaking the ABI, a new compatible for
>      these SoC is introduced.
> 
>> (The driver currently doesn't support the s4, right?)
> 
> Indeed. I know Amlogic is preparing the support. I could do it in this
> series but I prefer to encourage them to contribute. It should come
> shortly after this series is merged.
Yes. Amlogic is waiting these patches of Jerome. after these merge, we 
will start to rebase and submit s4 code.
-
Best Regards Junyi

