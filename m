Return-Path: <linux-kernel+bounces-99706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDCE878C08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F86F1C218F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D7E17F7;
	Tue, 12 Mar 2024 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I2cL5/Wh"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2072.outbound.protection.outlook.com [40.92.107.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22E567D;
	Tue, 12 Mar 2024 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204579; cv=fail; b=Oy8vjk7TR+Y0zAgNbllnanxdLpLYl4kFcLdQHxJkHK9Uysd3d0kH0LsfohKb9P1WPSo7RmOZWJPe+9ZG+6GXxt8BiNOB6ufQ7Rv/P43kjGnrDpzxxbM1mXLIr4dtGxN4q2Tsn2MXqBCLJcQlyNN2WrjqgnMKBZfNjdFM9+nHjyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204579; c=relaxed/simple;
	bh=SAmxpN4V4Yk999HRPaKbvk4F/4wAn1gTGRm3NqR0o5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ty2bUgGew12hFxDwvhl0Eu4y+YSRFAwx8JScIeOZIlV2yHYL1zDKjl47MYSITPCr8u9R2swyuE22Pg0SrnCuMtGy0Ee0UvLzKLsryuwKf5hPhTDbH+OOOPmZNhC2yUUMnen3x1NTlWItsZDXAVX+cg2HjatutuISODXUCIOdM2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I2cL5/Wh; arc=fail smtp.client-ip=40.92.107.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj7N4rU8N/uuoKHgnSnm19jAkfP3/5ntrH2vn+Fy4zooJxOVM5DjKFZ/u3dpqh+G66i0Uo5kzdTvCmPOLA+2RUtAnemXnguebOQmIqt4ajGj9P6yDiMPXBRFXLDBIwuwxpRy4MJ+4H+iMvXg3RPLZeyUQ8eP3pf4UjORBSycOQ9+5flsj0zI7umU2ORjgEf/yHb/MGevubl0OyrRiUuiFRGxVlXkmAAV9f9Oln7mX/kqkpNDz41U6Xnj+MC3VcDt3f6kqYlDeAAdKBQBODPYAQh6scSF8OAG0C5DDRvhFliHWK04d6xF6IXw+l8z8K1gvFMNlyTQnXemMkiPjjc4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARQgDRErLDgBQKFTN3AU/bUJXuAVIm+Hz/LytpB4ZP0=;
 b=KuJHR7cOy7nbepn+s25nk6RAtgKWlS6kNHbOE+oux/3599yEiKHJ4Q3NmgicUXIG/36/RbE8PNZq1QLb+WtYp0nQqlj4er5YOVlSDYxPUiX6IoZoxDd+qkreYECfGHv2LEwv2alSXwgI6gUul11Haz2+r5Tm8/b/nIx7679nJApq7Y7rMmaTkLvC2SP+3aMIOpJ60C0+XTkyWArAMAxQmoPLVtEMDFsa3YEnk9nZOn/8hO66UGelhqI9KcNIQwB6/1/WVTep9Ci9HwKqIswVV1gUPVkHqA9tq5jJC7H+BLdmLKexncrD3NHn5JRrERJ3a+2QZp0XRaVtBJkaK6/hLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARQgDRErLDgBQKFTN3AU/bUJXuAVIm+Hz/LytpB4ZP0=;
 b=I2cL5/WhaRG+RzRjoLo6kyBUYpUDgGl3gE3tD6elZUv0zdJhsL4qHE55Ei1jPOxf8xhJBjufHDcIV3hjSjW06BWlsIaBC2YSuw9UjB+alIPTO0FAHUt3IV+pra0R10kHEhrRRe/x8sgRLcOSP8IdvjVs5VEPlurWmXAa20oVuoa9bvl6NSvOFWnR1RSFTYx5Z4rPQ1eD5FQUG2iHwZr6htAGAoWFPOIB77aRUF7hivBMDuM2pvSuVbOANNJPdXOxxdv5y9DEkhZwLl0U1zhgcRdW4mG2/mrLrcrDdnw5g5kAWuNHsl43tfOwxDows5fRoY4VhJj/t9/O2Htw4uhhtQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 00:49:32 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 00:49:32 +0000
Message-ID:
 <SEZPR06MB69596EB6D2097DB14FF5C9C6962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 12 Mar 2024 08:49:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
 <20240309-net-v11-4-eb99b76e4a21@outlook.com>
 <SEZPR06MB6959090F2C45C3E5D6B3F9F496262@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <20240311090341.32509303@kernel.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240311090341.32509303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [h03ibApY05tT0PAplEjh1oSvxX2RUZ89Z0QmQXQBCSIPCMlfH1YKX9GAFoY791ta]
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <7f974ea8-b778-4f85-9dfb-00a15afe7db1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 057dcecf-f462-4c7c-aa73-08dc422e46b3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A6CF10VkEQ+PeWicRosd/cSaN6sow5FAwJ8olcgs5p9jRF5sdtiOnqk5v23+GGcUaqhphBjj1gi7SUoCx5IIsg9ywpspNNJc+VwTNbhG6oGZKbZ3wtNWbJOjNNaibyRMhoEfXul6TOLKXgHAEweB9NiYXCj8M6SQn2ueiV39XyXfFrR0OxPep3eQGp/duYLggcDwpkxfut8WYTcOSqjIwFoNkGkr68OKChEbR+Bx1itisN7oaMvtCGrHOcf5BbfZqcwuywuPDqhTEoz5UZidtS9kfAtuRy/XjK1ssjUAYzG8E2as5ZykAIGxyJz7Qxe3Vn+PD3IzjOa2FSVgoOAJD4o8ccH2T5IZ9coSSJOtaT5KwltGe8iNMoYzlGfu9VoIfYsSnkye6AjonpKw+SlsHBC20GZuXcKefqutQXIoRSqZ4xi0Jc3foSchmri0EMK83H+nVsAoWxoImSfbjBHTwp0NHl0QL7UvIVcrGiYwXeX5OPEB7x3rn/0fjuxdL9G1OYBvh3nkNEoy5GukRc29+Jk4Z5fstyNyvl6hhwntafIxXZ8eFob6z3vmL7oBDU31
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUJ3dFg3RDA1azJxRFRFVUNSN0RpVTNwRG9mNEpnS29KVWpRblMxTktvUis0?=
 =?utf-8?B?MG80NUpGWnRab1dmTFZVTmVYT0szbUswUU04Vk1OY2lkeTRiNi9ZeVJWdmZv?=
 =?utf-8?B?Y0pPeFByTXJIb1NDU1ZYWVU3MW5MNlhTc211c0lQajJuMUN2K2dpSGxqeFBr?=
 =?utf-8?B?MlNRTElzaGtNb0RBRkRZeEtLWXpYZTdJRGdYam1GamVwUWJ2RE1lUzBPNGpE?=
 =?utf-8?B?eXpCSVFUdXBpSFBQR2NibVBrOEVhTjRkak9jRkxhSGNVSktRRkJsVFlyVnNi?=
 =?utf-8?B?bGZEWGg2K0EwSTRFdW5QZ3U3d2VZbDJCcVN3Q3kxWTB1alVQZTZpZW8yay8z?=
 =?utf-8?B?NFhHN0RhM3FadFhwSHB0M2VISVd4S25XeXRhYkVBcExETUVpcFZvOWw5cFAx?=
 =?utf-8?B?Ti9MRzlGcDNTRitQN29wT3A1S1h0NHVTRFphOE9ydzVBdGdFRytiQmUzTkFO?=
 =?utf-8?B?MVZLeXgvYThLbmU1ZGU3cWFFSlA2ZXlCaElDaUNrNC9BTjFESUJzTXRJV3RD?=
 =?utf-8?B?RVUzSEdGczlRWm9qQlhtNzZ0MWxtYUowU0luSkROSGwzcm1VK2haY3gxYlQ3?=
 =?utf-8?B?RGVVcTM4ZDB0NkZuN2FvZTE5ckdMeEJoSXUrc011cEtTdUVsTTcwV0ZiN0lr?=
 =?utf-8?B?MFN2TjFhVFJ6N255UjhRNEhaSGpnenVYMlFNOXJRTVdscTcwYTIrb3RQR2I3?=
 =?utf-8?B?MXZ2S21uaVJVUUV1MVdSQ1VjekVNZEtvd1U3NGt0ZXhWVWxNS1dkU3dEQlpT?=
 =?utf-8?B?QjFkY3JyWVBzN1U5OXdvMjlYSk1mSWJtbEUyZFlyTldUQkxQY1pGV2xCdTFE?=
 =?utf-8?B?anJZakFSSGNQME5iR3VFbTY5VGNNNzdOZW4rUnR4ejRpMFFFU0N4UmtWbzha?=
 =?utf-8?B?eUEySkxGUUE1dXZPMG94Mml4RG1wdktTTmhQakYvYWtIbE9iVm8wRHk4bVl0?=
 =?utf-8?B?aU5lTUNEM1ZNNjFIek9qeG4wUGMrN1o4UFhHazU5bzVibHBkaUo2U0RuMXoz?=
 =?utf-8?B?d1VydGpaZENSdEtKcmg5TU4xdU80MnZyc2phd25BTENUSXRrK0Y4ZGt4RDBQ?=
 =?utf-8?B?aitydHZJUkViK21kMUxvVTVqWWlKK0JZQS9XWUxjVklEQVNkUUk4cDh5cWd2?=
 =?utf-8?B?enhjMWpycEVIL01QZHJHQkNTYnNBMStyMFdoTzVWdHRzYmlaRDIveGVLR3FF?=
 =?utf-8?B?YlZpWWcxQ0Voc1dROG1QVzNyZmtaNVh5bldJOGtBR1UyUysvOFlIOW92R1cy?=
 =?utf-8?B?SnNuWnZ5ODV3RXRaOWJ5WTlDR2orKzhZUXBLZHRVK1VLTkdUajdvOHFYZUJS?=
 =?utf-8?B?ZWJSQUhxNkVydE5yWEM1YjAwREE2THpsRW8rRkNhU0k1RjVGZzF6OXltNC9v?=
 =?utf-8?B?Y2xmcXZsdmpoMTZWY2dZOEg3R3ozMkJSR2d2Wk5RM3Z0cVNHcW04SnBMejhP?=
 =?utf-8?B?Snc5SzR6YnNYMVkvd0JmalB6Sk5UUWltQzJHSjZoTklkRGFaZUtrSHpRTFdW?=
 =?utf-8?B?dklFdHcxV0c2WWxvR3BzblpOdnNCSVp0UmpMMVVhZnBwN2ttd1lLRWRVY1Rr?=
 =?utf-8?B?MGsxaDJldm95Q0Rxa1FKSlJxdHhBVDV1azNoMHg2U20yekZPcXAxVlJvU2Zx?=
 =?utf-8?B?dlZmYVI4WnlDVllCbzZCdEs3SUtBVWtMVlFUaEpUM3BtZGFzUFNyZ2lDMjIv?=
 =?utf-8?B?Y080dytPSXAvMXJvT3dqeVNreGR3ejdoL2NhQ28rVFZURmJ5VGZDZWE1WmNk?=
 =?utf-8?Q?Wl3fbRCm9hGyPuSvG1sShyCRtG12DM4ZwzfYL4I?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057dcecf-f462-4c7c-aa73-08dc422e46b3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 00:49:31.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6568

On 3/12/2024 12:03 AM, Jakub Kicinski wrote:
> On Sat, 9 Mar 2024 20:30:21 +0800 Yang Xiwen wrote:
>>> +  clock-names:
>>> +    items:
>>> +      - const: mac
>>> +      - const: macif
>>> +      - const: phy
>> Still not very correct here. In downstream the core can also have an
>> external PHY. The internal phy is also optional. So maybe this clock
>> should be optional.
> You are responding to yourself 4 min after posting?
> What is the purpose of your comments?


Just to remind others or myself this can be improved. But i think it's 
ready to be applied. There won't be similar design in mainline soon i think.



-- 
Regards,
Yang Xiwen


