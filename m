Return-Path: <linux-kernel+bounces-67869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019DE85722D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E81528241E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E042146001;
	Thu, 15 Feb 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="etbRRQqC"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2010.outbound.protection.outlook.com [40.92.107.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98E145324;
	Thu, 15 Feb 2024 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041572; cv=fail; b=qkSUMKs3r1qft+8u+E8yvB9yYTFoVVT9hWpS1a7dbMPOBWGXXv+kkdXylQvp+lWb10X8LrupnFt2mlv9lxeoqOX6TSaMhof0/Mo5kbLHD4YGf0TwIq1B3PVLmIL+o/rsXwY/p8s1udPJApuodGCE6xygwOG65Nvab1+L+dIRqMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041572; c=relaxed/simple;
	bh=clGF3tjChdBSqT6SCEngpatyNxzb14g5o4HuhMeVcY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o1bQZ7SBjha36pxsbHJ+HDmj74A9R/YmbENDCbzzUiJrF4wVAGSxp7Jg61bpf24/gzXIdTFmb/9vgVeP2xJc99JGCM81YlO4P8agDbi1EAZNTM8OQk6IfXl0eExy3QoKzx2qlPImVjkqIH5UOxb1UzqHtzL3zFYYd71aLms5Xo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=etbRRQqC; arc=fail smtp.client-ip=40.92.107.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiwIdCtZkbjjrNgC7ZLmAt+UiazciLLZd+dWT+t4Bs+JRXbGMyVAUspgvY054XWEW18qj+AE78ex6STk8bCTNyAdZnOSFIBxCiV8EhIPjph/aGrQth2kIPfTfXFp4wkD0eJw45uZP8cHFbX+Dhu8flZuQmbInsWi7RkQUgwtE6o/T1l/Pqf49eD3fhC4NLPFgVQM9tFbbL4RY8XpwzDfm3rZ6Am11PrmigDcqLn5qANBhJQA1dlOSxUPIgHyhJe/IcnPBquboPAuMgxv8nQDE/wNkFU9zTDQFMkqt0pHs99BKwD3WY2m6nqsGDnsYfNhM3N/EoYn/nOj4jk2o9zspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxlJ8AJW6ElPohuO/zw1b6TZQbuF/7fyb34xrwPxyuw=;
 b=GxK6tXAJeCPvsGFYslwLVp1r4C3j3kTbLd4o3987PuXnBufFmHYnhEBpl4hKyr2/4/zpIgjq3IhQIft/larSfiU4xoY6lsvDeD1xV2TTJceSIQ6me2Rr+xna/dR+dXVlPaMQI/z7LL0+5MNeYX0UfCuA+MYaxJufUxPm5qrj7xRqvbsawtWV6bcxbXLoiAbAmzLr+8hRkrvSm1FMuTvOhKCkXCUj3BZgfJlopYLb3Z/lSLuItR7aY3YGees6bSVuObhnGsHGknH0WGPFeYR8fCJ5aSF8bInJwqxQAh7tiRVH0rSmTT0XKVNbmOIbYaMbiQfKuJDFYKH1e+JOxCWMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxlJ8AJW6ElPohuO/zw1b6TZQbuF/7fyb34xrwPxyuw=;
 b=etbRRQqCj49DYZCqAhvZsz2cA8/Pjur34OuhTbWTQCcjc4xMKjuaXxp/Oibiq+5h2/yDkuulW9fDhU75Gk/WgSCe/rYKuFd/Bc3Dn69HIkLaaNXJQA2L4c2ISOyJo3w3cLhnH+pb2itEM9VmZLbzIpYfKalq6jlf4WDhqbJLnHFRtWzQxizo+4zusobOusZyDYr4kdr8tn2cpb1BjZeveQYKmwD6EVWha5EVTLxCbm0v0PP68GboCcIW/r9th1qBiISevpdrWyp3IbTGfbfyUdYnj8WHF0vnK1VjiDp5qj7e0RoN8FF8T5KFf95eXKGgnKHevhaV0wV836QvRQZqfA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by JH0PR06MB7470.apcprd06.prod.outlook.com (2603:1096:990:a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 23:59:23 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 23:59:23 +0000
Message-ID:
 <SEZPR06MB695972ECA5223EF5F81077BD964D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 07:59:19 +0800
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
 <c00dad08-00f5-41f0-861c-cb40593b49fd@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <c00dad08-00f5-41f0-861c-cb40593b49fd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [9kTsuTuzqBIQjatx5eZv4zhGYeVPOP80uD9c6hV2o5z9iA/u4k7qE8KJETfk276A20iWQo4ho6I=]
X-ClientProxiedBy: TY2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:404:a6::24) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <eed0e226-aea6-4574-b85b-4ec4bed17c9b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|JH0PR06MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: fd06764b-5322-4b71-bb04-08dc2e8221f5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G2HjaBn7QmnLIwASG7Qhy0wqSTUW87jl0XCUPx3ry40G0Tt9mtx7F5QMeMqHH+2WuUKCd3mn2pwBUu7IYzzVTEhoWQHIov6AVAv4OWTkGl9ta3DgHuwvbwSpwRrZvT2fAKVy9YG8rXRnIcAY8EdcT8xS1WYEGeepmuZ/RW7gBON5QjlweuV6LPWLfQjoeAA9scpZbDbTbCzRVbr4ucIxeoA4CvAlPipBGPD86yXQUF9zsunZnGOfEMbhFr7udqRgqtd4FQ0PIeRhOLWZpxzr3mX6nO7wwIjCJINHmYvuauxUaLSiRhQNY+X25Wir06mWkBCAWPW8hKaJz0Lyo5GQm9ItFenNoMD1ZMVt7YV7b199iFKE0IDpo7c1Esf7nTgBJxI9ajjzBLflN5K59VIbAiM2YqKVH+JodFRSYxHSEMY01o32kAQdfMMiRdh+KrRjMW9bOq2MhkTJJzpQOSEkc1oiRbGWVijyzsKAJ+hp2h8N9XltOAzv1QpG87rC4IRQKDaotdJLy9QVQPN50nMjGsZQoxhlBRnQxEgRxpJZb4dXTMVBA/5ceDUfpK8HGVmp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVV5bFo4cXg0UTNpbVdNeTRLL0JNSkpFY0VSSW1YcGhKamdoOE9SS2djVUgv?=
 =?utf-8?B?UU9jM0VGYS9hYlJGVTVWT1picHI3UmRwNEpVcWFxQ29nRXNRdDdjd3FSdlNZ?=
 =?utf-8?B?SW14bzBaN0cyQUZJTVlkZENxSW5ZWFIvcXpUaWtkaEc5YkdxMjcvczhzRlRQ?=
 =?utf-8?B?MnRyV05qNTF6UjVraVc0cEFrY05kbE1GTldTQm5tWkgwaTA4SHlTVDVUQ2FN?=
 =?utf-8?B?czVNZHBmbVlNL2lxMncyUkZMUHFRZkFrOGk3eUpta3BsT0lXUWwzMC9LN3Fm?=
 =?utf-8?B?Yk16Ymk2bWYrT2Nwd2hoaDFkT2dweDVBVDdwcFVjejJtU28rRU9KZ0FKS2Vm?=
 =?utf-8?B?M1Arb0hMR2k3U1kxa0pFVXVuUWlmamlLKzVRM1FicG96eU8yek83R1IzNmh3?=
 =?utf-8?B?UXp0OUZSWk1BQkd2c0VGRUt4cmFSNGExMkFrOG85bWVRMmdJN0VZV1ZUTno4?=
 =?utf-8?B?Nmo4dHZzbFAwVmNqS1hqcWtrMzMweFdHNXZ6bXRNaU8vMVVFRENad1lsWHpK?=
 =?utf-8?B?UEJZZkoxcit4QzNpbjIwVGlBdW45dEJXOG1JSVBqdGs5SEQyTlBkMlA1RWw1?=
 =?utf-8?B?RzllSnQ4WTJVL1FuTU9Zd1JKSUtJV1RrUHFYeHZsRnM4blJUNzR5cTZoYU9C?=
 =?utf-8?B?ZXZVK1dzTlEyaHNabnEyWlpiZk9HcWh0MUF1czBrSWV3eVRveVhNMUZXNTZN?=
 =?utf-8?B?cWQ5dTQyVmdCWlRjYy9VQXNYSkdYY1hMU1NtWkxaWXRXK0NXRUNiSWVrelRp?=
 =?utf-8?B?ZmFEWnlDVFVZQ21OMGxYSkhOUk1WWnRsZVYyWEpXZzk0Vng3a3pVNnhMMWNs?=
 =?utf-8?B?RnZHQTAwYVR6ZUlBWjFpV0lIRTROMXhORVptRnN4bExPS3BvQ0xEQXZtQjdk?=
 =?utf-8?B?YW5wNUI4ZktJVlJualAxd29YWHJUUmJQUURyQ29ERzk4R2Z3TDBQV2FEbExB?=
 =?utf-8?B?QldnZUpOT2xNS3JVQ1hCYWJKaUNmL284aEN6T20yZ0Y3bm84L1ZHeWhoOGtq?=
 =?utf-8?B?VVlpdDlmK3VrUytYNXVXTkFIRzFVcUg1N3FRbWRjZVkzeEt2dkZMSXA1bi92?=
 =?utf-8?B?d3lnbnJvYjFhVjhqN1dubFh1MWtSK29IeEZ4WlhGemZCakphQUg1SWVnQ1du?=
 =?utf-8?B?eUxtRjhtZGhPUlVHaXNubERBRlV6dTMyc3hORkgvRGdNUXlGQUFMQUlOeW4w?=
 =?utf-8?B?TURvM2czNUxnZXVvTjdleG4zeVlieFlFNk45MDJBKzFNUDk5UUdKRW5XUGVs?=
 =?utf-8?B?ajZmelMvaUFEdnAxa1ZqYlkremVJb0Rkc1lnNmpNQ2IzdkhRMENVVks1WFNI?=
 =?utf-8?B?WmpJdnBDSGlyd1psRTA4bDJkMEZlOWorS3BzcWtER2ZvR1YzRHkvVXhibVVF?=
 =?utf-8?B?bnE2ZThkb1NLUEo2QThEREp4dHBDOGpSRTZIUVFKUG5yVjJjTXBDRXc5c280?=
 =?utf-8?B?aUZ6RVJQNGFUdE43WWFpMmh5Z05md2xERjdTSDhzWlN3N3kyZ2k1bjZMSnda?=
 =?utf-8?B?aHBkQWs5RUhTNytHUERZeTl5SzRFMCtDWGw2cVVxYWNUSm9GZUVwKzYrbm1W?=
 =?utf-8?B?UzRud3B3dVZHRzFSSWVhdUtwTjIyS0tHemJLcmlnRkNRb04wYW9uZW9aQWNO?=
 =?utf-8?B?YzFwbU5SR0k5UkE0cVdmK04wZWR5VWhNdFpyRm5qNml3ZTBsdXoxTzA3bDNx?=
 =?utf-8?B?UHN3alJ5Wmlrdll1RWtLelBWeC9SYnF1Zm9WWVo2alZmNFQ1OHBvWnVyK3FZ?=
 =?utf-8?Q?ZaVqQ03VuXgtg7JR47hE8BzBWnSmyOa/blrewkE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd06764b-5322-4b71-bb04-08dc2e8221f5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 23:59:23.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7470

On 2/16/2024 7:57 AM, Andrew Lunn wrote:
>> +	for (i = 0; i < CLK_NUM; i++) {
>> +		priv->clks[i] = devm_clk_get_enabled(&pdev->dev, clk_strs[i]);
>> +		if (IS_ERR(priv->clks[i])) {
>> +			dev_err(dev, "failed to get enabled clk %s: %ld\n", clk_strs[i],
>> +				PTR_ERR(priv->clks[i]));
>> +			ret = -ENODEV;
>> +			goto out_free_netdev;
>> +		}
> The clk API has devm_clk_bulk_ versions. Please take a look at them, and see
> if it will simplify the code.
I know this API, but it can't be used. We need to control clocks 
individually in reset procedure.
> 	Andrew


-- 
Regards,
Yang Xiwen


