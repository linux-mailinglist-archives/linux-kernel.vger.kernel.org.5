Return-Path: <linux-kernel+bounces-91590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A128871402
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75044B21A88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88F3B193;
	Tue,  5 Mar 2024 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jav/B1Mr"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2101.outbound.protection.outlook.com [40.92.107.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184238FB2;
	Tue,  5 Mar 2024 02:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607519; cv=fail; b=m9DD0jigFV/i0FlPlyVoZDG1HYhVxiawjk7Z0QXTeqTob1Uj5O+NORwGMa2hg+w6pAFdfnmBx5Y9How6LHArW9BCBsKPWgcJECmai5w2SVUhhYjtAQN8HYr6YBdXsXWr64FBV8qJhXunPdsDXV5McZJ+bMOE5YKI9/A/QIqWuT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607519; c=relaxed/simple;
	bh=cyP5mt7XUx0g4jkYiXkiW0J6QTPiZyKUS0Kz2lR+wZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pvBc91McdZwAbLRzyJ18VHmBKCWoXt8iJgH22cGhN9feS3IsSgTLZWu8RPFpz2ExQnsDHCFdnvK7qoR79BcL46fUmAK9aeO3IZ4mPz/8PZ6fOGbEduTbfF//s3aQvJ8UeipRQ1+7jQCFGK/O/Djh2j7rJz67rsesPOkjLNG+QJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jav/B1Mr; arc=fail smtp.client-ip=40.92.107.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkbPs8VUiZQNlnxFdKVgX2pCZClrsrEDRd87KppOjsEBao2bW4KUN5FMFRMViOrDeN1zxvcU6FOIhJRr63dDssDFs/H16O3gYX6l1eKQVhcAmMnfBeEeu7nkH0aKJtfIUeTXCqsYOzXiCwMvZbygb0SMPSTvHge7XkgDs9zHkCzvKWjvCZBHnF2rsaV8gs3WovHBsaYcWVCvxY1IEmb44HwZix9dL+a/Zm49j+emih6wYceKB3S92i6d7jjQW4LJmGyWy7dP6NViLhC9dXLDuSShNfagZ+V4XKFxc/ZvHlnEg0rtaWoxmwh80u+DLE7CCykBJWGdCzVKLfuPi0XIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHoVZ8OqvY42DuUarf6SVfurmoTdjFUVZbpc4lPB/UM=;
 b=DIPQjs1ODP9/MhCTTwBXRXLc7gD/Arcm7Bk76z32eDo+90l31CyuYn19RR6kKP42cDhXYqn8IFgBQCWxx9qCLWs7g+UW4W0uSJTqKh7USYPqzaqzodVBAwBE5cphxuj9zJ3DIwajMarqbi6LW3dAjsS5wHmcZtYzXch1qUdNSCyuGwfIrt93v2tm1/yIRmUkN46gh2ephYD6nKaNFdshF4n/8OBH6243HUp4cWWSdDhUMqs/V5HwUiTaEeT/pgubXgnoFGvYhZVM2zZkJDtvmVr3HoYbakOAGHuxpUEpsNVeJ9VkN8NYzzz+Ujzs9pZnbJJpAUoDRHmbQSKip7m90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHoVZ8OqvY42DuUarf6SVfurmoTdjFUVZbpc4lPB/UM=;
 b=jav/B1Mrm4wi8azt6wCXHm/DkOxEwGoOrrhkF3+kKwnVQ6QkUa+oD5tk3YOj0SKn2G0Nq0L3Qy9YANVJcIyIotiEmcKzy7z6cg9NjO2nQ5fk/xRVBu2nUegrAwao280rsq044/gNSiRd9fZiBNaYYtwJcDynvcT75USH59dFJrsSRPPRSrFVBhvF8VqCsPoPiInQkn2S8vvPqEllEBiy/+xmc9f4gfjz6I3rFpsZHRxj1dVb+Jwd8Iu0Cx2gmVzNI9AI5bx7Us/FOEa/Fu7O5E6csIpssF8rMQ8BFTJJuAevljp41ejJ6mIeDyI9PjVbmG06NPEO2DzFt6nnBr8c8A==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR06MB6297.apcprd06.prod.outlook.com (2603:1096:820:ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 02:58:31 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 02:58:31 +0000
Message-ID:
 <SEZPR06MB6959B927591D5FE1F4B4D1D196222@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 5 Mar 2024 10:58:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240301-net-v7-0-45823597d4d4@outlook.com>
 <20240301-net-v7-4-45823597d4d4@outlook.com>
 <2c90731b-709a-4baa-963a-fbd35372fb3b@linaro.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <2c90731b-709a-4baa-963a-fbd35372fb3b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Zk1lNi57convhlo+U0pymia2VchqE4GplQOKOBiSymlbSdC4a3cHO9IdEbsoNZ3s]
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <05746022-8c27-4eec-9171-2d9f6391520f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR06MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: f57df1af-6cf2-413a-b1fe-08dc3cc02372
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQB4/iWMavP5S7Uvsl9sZ9PpF0iTAE611Fp0Fj/gSmBiDrQ6FQNfcR++t/9AR/7hWg7SuFFu3iN0H6nb0uUSmxMTuP7ufw7AcFE+uxAKz+PwDXX0fAAyVPrLE925jppWMKtrxVnhs9i45wfdUSiv0OBela9vfap/pC8qJId7vUYxsLd0U+P51gVC8p8OYzkC9gHidvE2DAMNXozRVCHmyt9XT+cFT+1WWrIK5ZUeJIP+7DwlzyJWYT7ZtqFVKbg4G8PgZ4HBjnUEgMLTilwNosl20dLeYsxAqoZQ/EMCrjJcgEL1fPC7KKn2nAVSvFsN/tVei94d/HSEPSg+y6NwK4wy6Do/yQJLyLYlGkceGvF6+a0J/4zkF9ClBE9ZpzgJ/HymfaS9xwSnOy3YeIlX7L4RISBU7kEIZ3/+1wXAXZ/n2wLfyBoLLqF5X/a2gXW4CgQwO8sXkTqTHLn+Wm2Wgw4qygwF+x3ZUWzUrx6EXq2GCOIpMTBzHX+GY8MHCPMgjUs+93EhJLSiqt4oIxkpoPo5nweAxyyUBY1EgHYig/8XnqKBKqbB4gog7HPB9qdtwvaKzLqdsH2okiWJVpJFbRsgU7V2anbcckF1WtEu36VPhyLlEnQLvDko5xSi5KsfwLfSQ8yDkmVNyG0Spf56K+gJNIHBPhUM0yTbNNtd3E5B/3mxtcAHgJoxW8hx5/2dcPqgjiDoghRzEnvul8D8Uzv9b0R6rRakytUkUlwIEpJKeGz1jkUvCge9lBJYlgZoDOUQN1eYBmEK2Q97bOkXjcfCp24H6lsvQWS0azHHOjZE56fqGnQ+YIxK
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ww6jUnIlCSHk2H68W/+ouHP1NdqDlq1zMuNdVKuSDQaUKadooxFtjb9pvEZJaVKCTEdgUyZOFOeWZp9FQ5ecfXOCc/HQzOXHX9X1T00T3v+pKPtjbdNbgydcBCmOimHuJhY0UZLQP8vHa9EYym1KOcADH/Zy1ulRNqhNkaN9j6RDLC11mLog4dV6nOaSN7+jvIjSBNheinf3n5bom07NxNTjvRcsZMMk4uPO59xvZUgNICSHLGpEPCjnwEg6aBpSsc/ekAd4YUf/tHEkSiTCEs49iggQekRNe+TXbdql0bSUfUGGbp3chcl7jjLAJ6h9d1J3czlYSEmNR3TRBslQhyZXA+c0gNkLKM7miQtSuO2iFos4X7UtM+vpaQpQ6N11PbgcZtDRCVJysowrSRPhtTmqgOK6KxhKRZmLCPBZ14mqw2JEy78qHpjyycOv0sWivMF8CXGczvBH1Qo5xF0JEg+SPlkoD+X6Wp4HHGREDa50BLFhUcfZ5gk1Aj4zH37wV5m+BpGgLJFltX9QOXBzmtLdgvSa0ron1rouNtN9PYkReKwHT8LjOxAsT9sG5bIfnO2im9seBkgrBSK8GIkURMxgL9OJ23SsPaeG0t7qrh5EoaP04VW7eM37CgJteQINxUwOmXpSbqL31yMmF5o4zWkZzcAbkMLt1TdRDo6f/rQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWRKTm9yZ0ZGQlYra0R1c2VXN0RhbHJuYU9FVkNOUkRDd1ZRTVZRN2t1Vy9H?=
 =?utf-8?B?VUFZTUVIR2hzWDJkcTY0SXI3TFNRZ3hJUnBDZ0tZcFdRcG9EeU1VWW9VaEN6?=
 =?utf-8?B?eGVCLzNnZ0FuMXB2N094V1ArdGt6U1B4RUJOUFlTaTdod3NlK1FDMzBlVFlr?=
 =?utf-8?B?SWljcmpwRzB0YVQ1Ky9LQTJzdDk0OHVhRjJ4MjlCOXo1VmViQ0JLbnNISjFN?=
 =?utf-8?B?YTVRR0gxbEFOYmZtQTBJaGFjUUx1TEpvNzhTVE5aM3g5aUlleVBzVjBsVGpC?=
 =?utf-8?B?N2xQRm0xMER1c0lJbTZUNFdPVUFBRlNYMWdMeXRONEt0NFNiZ0FYSFRGM2Fk?=
 =?utf-8?B?bHpra3hDRU5ZK3hNQVhvNVc2aG81MHhNOURoL2hSRU1mOFdlZUFkY3NFV0Y2?=
 =?utf-8?B?eFpObkFnbVh1TWJQQkE5NU9yTy80SFBIdThnbHl5cGhORXBPUVVsVmJnSU1G?=
 =?utf-8?B?Ti9YaFVyUVhtcjNmVFlRaWhoWU5WaFRkNm1DdTc3L0dNYWs0aGNEMlZCeXhx?=
 =?utf-8?B?ejRnSmdxM1NoWWd1b1RtRnRKdWlVOVJwWlRESkF2QzhxRExzT2p0Y3pMWjVw?=
 =?utf-8?B?TThndUdEQlZjb0VrNUU4N1h4SFlsVE1MMFJrdS9YNXo4NXhoMXMxaTJRc3I2?=
 =?utf-8?B?TThDcHozTzNuMklOdlpLMk1CNVdLTytOS2x4cDYveHNYMkhrZ01BRHcwT0w2?=
 =?utf-8?B?OFRqNFhzTys4aWhDMUhhM2V0a1RuZ2FMOWFIaVNUTTNhRTJHcEFvY1FGUkdt?=
 =?utf-8?B?UmNBVXJDTndLWHRmaDdKemswQ1VVWUhKZUNyME9PRVZ6aExFSHNaYmNkM1ZT?=
 =?utf-8?B?Z3pJYTl4bXpKMlplb1pZYzFUYjRDK0llYmM4ZHN5a1NTTFV5SGtmaElRcDlY?=
 =?utf-8?B?MllPZ1hBaCtrb1ZOMDR1UWxWM2JwQTlzRDBRUC9lVVNSN3RjKzI2akhFakdo?=
 =?utf-8?B?dCtobUVuZzVRM1hZUXdBdjhxRmFtWVg1NHkwRUZFUzdoMzlIbXFzTnBvWmJx?=
 =?utf-8?B?dHBpUS9WbDVxcWIxTDNFa1FlcUwxQmU3alFrc3lTYWhsVnZNakRZQXRraEow?=
 =?utf-8?B?RTViazdyK3RrM3NicG9BaFdSMWlJcXptWVNaQlJJLy9lalpGbkdicXczaytt?=
 =?utf-8?B?MEttRDVGL0FVK0xUd2FiQmNteGJjcGlXbjhIaDc5anFMdkp2NzF5cVJEcUw2?=
 =?utf-8?B?T1BrcTVraHdzTEFsMWh2R08rQ0FHbWJSRXM1bjN1MmdwV0NNMTRuRER1MzA3?=
 =?utf-8?B?bWxUZGVhcWhXZ1I1U2t2eUpERU5ScGZ3UU9nV29YZFl2TGNTMENXcVZRQTRS?=
 =?utf-8?B?c2pmdjVpSE4vdUdiQ0YySkd4UHNOUVlnblpJMzBudWlSQmZsRjhrZjJldFF5?=
 =?utf-8?B?UW12SXgwY0c3c00rdkdJVyttTlRlTjF1WUhuQ1Jjb0JsVU9tbUl1N3ZITjIy?=
 =?utf-8?B?MmFLNDRqbmt6QUhWRVpwOFU4NFQ1aHlOMUVPY0FGdmpIc0lhSmVYOHFvOTdK?=
 =?utf-8?B?ME00TkNxNituejZyN1pzd2NydUdKcStZb2VOSWhKalpsUWtDYk4weG96Y1Yz?=
 =?utf-8?B?QURnelZ4a05XV2tmYUpoUnoyaVVJaHorUXNkdGorSWhmSE1BNE1kTmRhWFc0?=
 =?utf-8?B?bElldG9LOTdrQnB5MmVjWG1hdVdBdnR0VklVaHNUUlhPeWVQZzhqTkRhMkFO?=
 =?utf-8?B?QXZwd0xPaVpER1B2R2dXRHVKeDRCYXBiTXpNcmFTNE5VKzFEUDIwTXBGclBN?=
 =?utf-8?Q?R5mCk3P201cqJmO1jtzt9WpcUug3FCZ058BhAMU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57df1af-6cf2-413a-b1fe-08dc3cc02372
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 02:58:30.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6297

On 3/1/2024 2:49 PM, Krzysztof Kozlowski wrote:
> On 01/03/2024 04:35, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Convert the old text binding to new YAML.
>>
>> While at it, make some changes to the binding:
>> - The version numbers are not documented publicly. The version also does
>> not change programming interface. Remove it until it's really needed.
>> - A few clocks are missing in old binding file. Add them to match the real
>> hardware.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../bindings/net/hisilicon,hisi-femac.yaml         | 89 ++++++++++++++++++++++
>>   .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------
>>   2 files changed, 89 insertions(+), 41 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>> new file mode 100644
>> index 000000000000..ba207f2c9ae4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>> @@ -0,0 +1,89 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon Fast Ethernet MAC controller
>> +
>> +maintainers:
>> +  - Yang Xiwen <forbidden405@foxmail.com>
>> +
>> +allOf:
>> +  - $ref: ethernet-controller.yaml
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - hisilicon,hi3516cv300-femac
>> +      - const: hisilicon,hisi-femac
>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.


Could you please tell me which one did i miss? I have read all replies 
to v1-v7 once again and fails to find one.


Do you mean the discussion about "phy-mode" and "phy-connection-type"? 
I've decided to drop that commit and stick to "phy-mode", in this patch set.


>
> Thank you.
>
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


