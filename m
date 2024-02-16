Return-Path: <linux-kernel+bounces-68707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BAF857EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B9AB263D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411D12CDAD;
	Fri, 16 Feb 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FvMsY3gn"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2077.outbound.protection.outlook.com [40.92.107.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609A59B5F;
	Fri, 16 Feb 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092527; cv=fail; b=dmFJT4aNN4na9SXysDBSGBwDOdoQ/mR8cXFkC9wiJ+Ge5DAl9PnFFofbO7UsW94xzgYiOolpZx9Iq1jBdMTnymcRyLj2z64vY75kcLmUhG3j8VRkdAZ+M+V4YeVE6eahf/7k1t6Hw6/EdP4MQwLY2aXfFCvL4+bI4s7/xAt2HUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092527; c=relaxed/simple;
	bh=0DWYtTq10NL4yLFRWlqy/H61RG0Pwtj7pjnMATgPafI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fT6SIMxBDdIX12AUgr8XIPzIkqOtOKruVJ273+wIFQ9Wphh6teJxbxOZBQ8BUCDm5YYVzeWK/XsUE439aSUQHJQxp8I9sUQ9vRfl7W0wlHQxzhlkIUErZr8RaPjEQCQRnCrRSdYKNn5bv9q7ScN5N/YQQPOEPtJ0tYpxXbUU6eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FvMsY3gn; arc=fail smtp.client-ip=40.92.107.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmkJa9rVsbezCujJ3LzhVrVq0ciobK0OIUk8yGxys4gemg0oTeEBhPly42hi9tc/5rfFUXfnA5XwjRqQ8cjLM6zyS6g5VK4q4jJJ+mQsiD/WaLS7Fx7asrhBxWdCBkssnGHHYbauHFFvZaMAVv20/jk8eSA33VUnOxGXd4xErHgHIUe5EqYQ2bWbqs492ep0xMtO0mLncxH1gjYaehPyuu239+ZvgUzUcfKP1eMYTh7KMD/e+DzIlV4OlbFNqMKbKSg++tTX2hAGwphyecP1ML51Nk66sXozrBQk/toRj2uvY/i7jTRkLzRZHHhqvtmyAn2G2CAD/dgqpJyqglWB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTJysSDiko1zL4wGyReBjKC4Lw1WUTDPn9ct1DOiFuA=;
 b=LWCdiN/y6DVJCeXm6BPMzn3IMf9L/ow3MZpFXs+wJB8PqnCmGTrPlEhDSgKo+NFzKs6AoCTBLTLmg/sSl4Bu8zopWSAR+AmdR3PA4KKK5ksbN+NTTFAqcQDhp2rQbpuGEtEtVMyTJbNLhnQgb8iAPlQleR1qQB4j/jR0t+hrXKQ/ewdy9f9Z0LhTmL4ChhlPE1cEIdVxWXV7pE2/Ju3fWDS2p+UDFfainwLiEZ5WukWvXedIL4cflsY0IQhUeZMKq1ERYMyBlF0KnnknxsetvFCClbAFv3x3nC92Y59kv8Ot8ee4MWtvHrTvflnbtBMKsIJPBSnLshlCaEpH3fy+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTJysSDiko1zL4wGyReBjKC4Lw1WUTDPn9ct1DOiFuA=;
 b=FvMsY3gnw/o/FdkHv1x8sesKOjvtww1nXyRZ3T9G6qsdkysCE6bEMT3VRGPp0+1AzpiFOKcq6gN9grGJ5EOiB7UQYj814TwN+tH24V+7h4GlB2mptlvH6A0iMuvnhJncoKULxPZiHSj7D8Z8ewq9Z5ti2YRKcqIB9PMxSYuc1ulZ+RteQ0LVCF0Q2u3nVxTeP2hUs9fLp6isfby13DgkX4rxyHmRk59wiziV/8VzKgCpZZ2fsXZKg/ten+nIRRFWVIlgWghw+3+5YqFymONHh1pVAn5ynB5A+FuNJZsn7hDO/s+mPXhaqpZtmJ8dsF3LFnk0jxrUca6/aIvU6HKM4Q==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB7282.apcprd06.prod.outlook.com (2603:1096:405:a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 14:08:40 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 14:08:40 +0000
Message-ID:
 <SEZPR06MB695985C02333DC5915A1203E964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 22:08:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-1-e0ad972cda99@outlook.com>
 <d3ac4638-d0bf-4c6c-bccd-519ad1f4dc5e@lunn.ch>
 <SEZPR06MB69593E00C6A69AFAC61BF2BD964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <143ee08e-e53a-41c1-8020-55b495394dd4@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <143ee08e-e53a-41c1-8020-55b495394dd4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [NFOYI0Bmxq0o6zGSBmW5/uVCUaRxMq6GvJJZQugCteLYH23t1d/rQpihrpvfssao0SEovUy+IR4=]
X-ClientProxiedBy: TYAPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::19) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <c256611a-375c-42f9-a6a8-dfcb68b61f2f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 646e7709-2001-497a-682e-08dc2ef8c660
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3izcbpLHFk7TRYcAS8nbhnwdddozxY5odVw2MXbiKma9N1T7XtEN7ojadTCU2At93bQE+DO1perRCymYAqYRFcLV5lPWglmB2D2AhaefR8hPyZ/vJW7b8hNPSFyHK7ESYKjfQFxM9cntvxDhhKQKq+xXo2k/YpUyttV4X31b6BksieGFJQFp+0Ou6YCZ6FVaMP1051M9HiJKfCCY/jtMUTCDkgu1Vo2RBsEkeKT7vFs4BkuTJOG2+L5f+JTvaUaNsuFa9JTrQHrbsuvcN8MDPEfDBi809v3pYtMgJdQIlbXgRhXerg8J0xViCof1Fn4TDYBf3SKlObc5HLKCT+u63GJBJdoBgtEZHsMLUkP3vsfmss02ziKRY+Ak94o1QtIPR4vYWK8xdf7RdMncvGLCONnz7RRVtj5bIybfM+w+B3vWgpVT39Eg0B6W8MdGt876Uwi4TCLNicoX5vpJHtpOEGZv81eeia20W58oB32Gxo9bsMZ0u41cv21tvCmPDmAXlTFPnZf7CK+gUL1u4nOdzznYgjdnnS+6IINtuvhMr6sgw+ILt+/3gLSrfUH/lQLF/Y9Rz5xRVtZNDcHqBQ9ysIGvM+j1xcl0UkF4NEufnSdW907o6x7MtsHV5fFdqKa5vvnVvdsqB92j7R42/VmO8BrVNCAtu0zzEGl8ZN8/4fjeWCGI/Mz8sQNlp6ND2MHPi74wyiXDzdk1Jo8+w3EQKQ09g4q9RsX+S0HzPKZTyRBIBl2z4lqmApvwV6kzxJDXe8N8jyUneIpYNwlQI1aDYODWSEbaUyhqus=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yGEGwxPXtLZomyJjivkcSSGgIX5q4tgGHJRuP0ShCuwMYn46le5knSf+1o6vqgWUjEp8NDArG0XyvzxqA233g4gn6JvBE/haEET/C08uBLuB9EEjDY8PyqsudxIouEQ2r5hb3yohUY6LHVhI9Ul/cfbkCreRbcSzFlGYqajQ9pfH/dMrq/FWJEWBkIFv3sI+2X2uSgWl+IMZov5HC6DneGdPc7KBFoJLYYBqUBe7j1LgLlhmmdgmzypw/HVfomDtw+AhAx+qbkiHIpdwWRfjcGQ+bfgSPV4mvLyz9xherP8WTy9DuPsGX0EwCv5qRaXx3IA9KrVBMvOmnEB+nCrKHQwbf0JmkuDJkFbbXimhspS3QG0Upc8TAW0tZkmxtqdtKpGGSqze1MHIxmUSjkR4qbtRZN7OWdKghQhfegzC0qPkiJMCzCY38xkaRUVgL1zE3k0uf8It9Xw1LTYzUw7HjBt+RavLe8mhM3yNrFYeNHIYXuFitzP9kV4oeVGx9N2sQKjYeN8Rvr8V1gZxI7QlfCqY/cREN6dHAKe0dTLVRVnxEoOOhXrx77M4OKPV0Xmj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWtBcXRkTFlOalF4SGtOMU5WOXZJWFB4Z2U2Sm5GK1VneDhURVZhdE9PT3hG?=
 =?utf-8?B?MmVua3JUSTErS2lpM3Y2R3MvcG1YQ0RCNmd0eUUxOUN4QmtpanA1cVUvTmp5?=
 =?utf-8?B?c2g4cFF6TGJrakM2cnZORFN0NE5acEs2dU5tV3Q4MTBDM0hUUkNZNHJrd2pB?=
 =?utf-8?B?cDhuSzNlZFlxYWhyN2JsNU1ld3hvWFRWK25xSG9YM0YyTlpwODY5L0p5R2xo?=
 =?utf-8?B?Q0tMOHR2NFk2Zk1NREsxNUExM3pxQmUzVzF0NUFNWnczSm4vTkVrUmlrdytK?=
 =?utf-8?B?b3hpc2NFWDNXRWIwQWp6YjVLSVhONjllMGhlVGdhaWZvUWRnVnc5NUZZeHJq?=
 =?utf-8?B?SFN0c3FmWHlLbmtlYjJGbjhWdmlpRHZIOEI3Skx0Rk5CRVZERzZLSFdWNERn?=
 =?utf-8?B?VjdzcWdsSHZ5cjdnVjR4Q2xBM25PTVQybEVNR0VlZUwzL2dLenI0RSs1Z2x2?=
 =?utf-8?B?VDBIQWVKMTR6aEdPdHdCemFqVWxmcEJudDVNWitodXpQWXFpMkNWL0NxclhM?=
 =?utf-8?B?Rjd0Z09rSndRNHZ0ejNteHNtMWVLUEdBYUVENFcyU3pwNkNNem9yWktGODdE?=
 =?utf-8?B?OWpXQk1hd25laUcxaUgzMWl2ei9MaVVqSVJKWnNxZWNiS0dxTVozdkdkdXVE?=
 =?utf-8?B?VitRVWZFMEtwV1FNeVVOaC9wZDBXYUFvZ2dSKzVWbllSSU4rNmFzK3F6SGNp?=
 =?utf-8?B?dy9sd3VNQ0Z4amsrWk1NTmRNNkhQb09pWjlVdW15QkIzb2Vwd1d1RXo5NkpK?=
 =?utf-8?B?TDZ1R0IzVEt5dVZuWm13VFV3Z2IxazExdzZWMzZZc21tQVVZNG15cG91dzZ2?=
 =?utf-8?B?T0dxbnVtUUYvR015SERHUXcva29qSzVOOWpHa2pYUHdBR3U3WmRvMDNzb1Fo?=
 =?utf-8?B?R0ZzYi9QeVVNMnJYUmg4NDdTRTNWWno4ait3U1pvVTF1dHU2L1VWME5NS3Z1?=
 =?utf-8?B?dVFWRnNMYTd2UThxaUNPZG1NQnBlQlg3UGt1M3l1ZTQ3T1RaNTZFcDZ3N0dt?=
 =?utf-8?B?MHFHeU1rSW5hazNreW4zSmNJM0IvenVGY2xRUHFoTmIvcDlXMi9PZ2M3aHYr?=
 =?utf-8?B?VnNEWUV4WjBkMkc3UmdFeFBFWTJ3VHQ2T2pzUXFFTTZpbEloRmRpcG5TRVh4?=
 =?utf-8?B?Wmh1K0wya2ZjYitDUENDN01sTUloQTkvSTA2c3hPbjZHZlpPS0pJaXM4dis0?=
 =?utf-8?B?cEl2VjBDcStYVWtvaC83RjlKbjBCd2VHeVBnV1BZYWRHR2tJam9iNzRueGxp?=
 =?utf-8?B?b0FpaC8rRTQzZ0QyMHQvWnJqblhnS2g0VGRSa1RWV3czcnZseUd1K1FEL1ZC?=
 =?utf-8?B?TDJ4L21FZzBuVkFieUpZL1R1TDl5VWNZcXJ0TCs2Ym9zd0dWd3B6K2ZNNzdK?=
 =?utf-8?B?L1k2MHFqUk1kSEFQU1ROQlAvRHpVVEJ6RTh1YkxRc3hmR0M2NUNqY1FwZ3Qz?=
 =?utf-8?B?a1BHYlR1bGNtc3hFTHJVZ3VTM3VPTWV1cFM0OGYwa1VHajYzM0UwUnZOUGFv?=
 =?utf-8?B?YUN0NWo3R1M2bndKeTV3cGRaM0FsQXEvMTgyZWJLbTgwRFZlbVVyR09IQnhq?=
 =?utf-8?B?L3phR1grMXQ2ODNDZ2pxOXNLRXBHeGlqbXpxL243cGVGQjIwOHZGWUtZcHBh?=
 =?utf-8?B?TGxEM2lsRE5FTWg3SmF5c2h0N2h4WGJQNFhkOE9Bb1diMWJuQkZ4a0diWWpE?=
 =?utf-8?B?dEpvMW1SdGVjYjJZUDg5WWJ1MWplOXdWc0N5OHJjZlR5TGY5Z3dYZU1YZ0VJ?=
 =?utf-8?Q?0fsrpzFykQdKMzWqUzr253T+RPHI4rlHkTV/EMW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646e7709-2001-497a-682e-08dc2ef8c660
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 14:08:39.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7282

On 2/16/2024 9:58 PM, Andrew Lunn wrote:
> On Fri, Feb 16, 2024 at 09:41:29PM +0800, Yang Xiwen wrote:
>> On 2/16/2024 9:23 PM, Andrew Lunn wrote:
>>>> +	// Register the optional MDIO bus
>>>> +	for_each_available_child_of_node(node, mdio_np) {
>>>> +		if (of_node_name_prefix(mdio_np, "mdio")) {
>>>> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
>>>> +			of_node_put(mdio_np);
>>>> +			if (!priv->mdio_pdev) {
>>>> +				dev_err(dev, "failed to register MDIO bus device\n");
>>>> +				goto out_free_netdev;
>>>> +			}
>>>> +			mdio_registered = true;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (!mdio_registered)
>>>> +		dev_warn(dev, "MDIO subnode notfound. This is usually a bug.\n");
>>> I don't understand the architecture of this device yet...
>>>
>>> It seems like you have an integrated PHY? In the example, you used a
>>> phy-handle to bind the MAC to the PHY. So why is the MDIO bus
>>> optional?
>> Because the MAC can also support external PHY according to the datasheet.
>> Maybe some other SoCs didn't implement this internal PHY and used an
>> external PHY instead.
>>> Do the MII signals from the MAC also go to SoC pins, so you could use
>>> an external PHY? Is there a SERDES so you could connect to an SFP
>>> cage?
>> No. MII signals is not accessible outside of the SoC. The SoC only exports
>> FEPHY pins (i.e. RXN(P) and TXN(P)).
>>> Also, do the MDIO pins go to SoC pins? Can the MDIO bus master be used
>>> to control external PHYs?
>> It can, but not for Hi3798MV200. The datasheet said it can use both internal
>> phy or external phy. But for Hi3798MV200, seems impossible.
> So for the Hi3798MV200 this is not optional, the MDIO bus is
> mandatory.
>
> Also, it sounds like it exists in the silicon. So it is better to
> always describe it in the .dtsi file.
>
> And i took a quick look at mdio-hisi-femac.c. It has a probe function
> which does:
>
>          data->membase = devm_platform_ioremap_resource(pdev, 0);
>
> meaning it expects to have its own address range. It is a device of
> its own. That also explains the compatible. So please move the MDIO
> bus to a node of its own, rather than embedding it within the MAC
> node.

It won't work. Hi3798MV200 does not have a dedicated MDIO bus clock. 
this clock is merged to MAC clock for this SoC. We need to enable 
CLK_BUS and CLK_MAC before MDIO bus access.

Assigning CLK_MAC and CLK_BUS to MDIO bus device does not work either. 
Because the clocks will be enabled twice, the MAC controller will be 
unable to disable the clocks during PHY reset.

Note that the source is contributed by HiSilicon almost 8 yrs ago. And 
they had never proved that this driver  works. They are not doing things 
like this in downstream.

>
> 	Andrew


-- 
Regards,
Yang Xiwen


