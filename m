Return-Path: <linux-kernel+bounces-94053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F709873921
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EA11F21332
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD07133994;
	Wed,  6 Mar 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hKkb9pnT"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2058.outbound.protection.outlook.com [40.92.107.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF87133993;
	Wed,  6 Mar 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735426; cv=fail; b=nBKF61b7RloDj1BQhuSUDA+uj1fACcptPLz9XRqgXgm/8DctsLA/7Tvvb1EIG2bXJEXScI25wUpJq7bWwMuVlKzgDt9I1xaaEsDPT7i/MvzyXFloRx40EfGw8bzFtdCPiirKZ+B5eUUE7JZhHgCcr+X+dj2waLF8t6BvHzW4KJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735426; c=relaxed/simple;
	bh=CFbm+awWMNtL11GzWPbfJZMl8AeCNsCzBjnqUzDK0ek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jY9+ARsWmv0i3Ng1j+11QBaZTTLfTXM1Ky855TOX6lXOYKmqhyraicLZREjRSAsUX6+aMwHA/aozevwE7dRzhfztj/ya8LLkFsALt7VAtF9iJ56p1hCu6gQox8ZwwTsiXBpVt6YBsN7amjSIiiMSCPVFevezYnfa1xYzDSgqbxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hKkb9pnT; arc=fail smtp.client-ip=40.92.107.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAX91y6qGiiy2PFP4cIvqmwpPQQKF3BKaFHvYD5Pdg7hVfGixcW2gTDD4QiYGSo8FidQfq472WdHs1yYK+rlpYEywPtygBqBYmlgqNG/jqrDAf9hBIh1lZBRq60h1l7mbvmjhnSNro+6n1LgpCuiqm058pkLDWQBoI1RjS7I073O/ojfG3gjt4ut4Nb0FpXiujetZarxONNBmT41eNjIDHfWhwdT7TE5rQforyvmChd02HTaibNEYZOfkLTJkcwcwAaGb4Nv+rWhghkfWE+smPoNOd6JMKUJ+eq5xJUIr6bfk+zWc8zaGivtV97cngIb7Oa3yRTXpEIOG9SMB8GuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYFNLmpwjJ9yEfDdjdYqAlY6POqhf572KCxz6TWOajY=;
 b=oVJ7tPUDVFOeP+MQeWb10TD5MxBK7uGwI5jFLpwN9+VMXmoDT48zGKK+uJ0/iBBnyQzfVQS1kwVac/KgsJnfS9XDvtk7y9ygpKpFqAmvCYUU9EeYq1eeigsyWfHE9pXiZXyxs7mMGV9WFAqECMyR4rsSSpVDpHrWksRO+9rI+YuOwDxLrJX4rvOEGpwMuit9IAsStW0EWscj5SZI3i8HH8XcgvlSwVwkBGd+4S/3Nl1mTNb1sVJJVhZFjPRhWbzBrlPQPweyzeU8YvlcLM9Z4HZAD9P+49IdnAC66HnSCmjT4SYuK/wLK9IHjI3r7Vo3vrA/aTbqrqomtHQG6HC0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYFNLmpwjJ9yEfDdjdYqAlY6POqhf572KCxz6TWOajY=;
 b=hKkb9pnTFikCRrq4rZh3WDYz4dWcm8oUfbgbqhiDuqU8m4O0trr6BUn0Ryzgn0bEm+18Mo1c8cuaIQA/RKzffRfMIRmoipTDgMAkTRwRiK+f+dhVDzgjOY79nkeWKjiq1ARPbTrRR8JIhRfItDriNou44uaHgf5nMR/Mrzv6tMplNSsXRML6VZKTYz4aKGXh+kjmfvrU/Dws4BkpAyuWUsJpigsu046AZCANSVnY4j3WdJNCXHZxyKab8/hS5ISLew+Hh3Q2XZ9WLp3EiJ+5srqGnQDL3lT1dN9rpgjfhV/mC6KZuoVysq1CzRPZF849ftH4kIVFrQmQKDvZ8Ekgrw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SI2PR06MB5044.apcprd06.prod.outlook.com (2603:1096:4:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 14:30:20 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 14:30:20 +0000
Message-ID:
 <SEZPR06MB69595E580354C25A9AE9C16596212@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 6 Mar 2024 22:30:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk: set initial best mux parent to current parent
 when determining rate
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240306-mux-v2-0-92a5fa461fd2@outlook.com>
 <20240306-mux-v2-1-92a5fa461fd2@outlook.com>
 <20240306-inescapable-astute-bobcat-20c3e8@houat>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240306-inescapable-astute-bobcat-20c3e8@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [ZhdQVPzFbshejFEbOcBeLWGv3RO3rTeTXQGG8YiU+EsSKTHTYZiG5GA5hMGfzbI+]
X-ClientProxiedBy: KL1PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:820:f::13) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <734f7efd-f9b9-4be3-b904-b741d12e2e83@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SI2PR06MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 9201385d-a096-4503-bfa0-08dc3de9f375
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vPobl9LDx/sTdKa8IEY74SJ2gnbzISxDOUqnOtye4YNHbn6M2DAd124POoQzwHmJ5G4bicw0YltIe57dmHY1P0NLST3CaPPN7Wg/lHNVhhscdP3ZH9IKIGLO6Bop9FHMn7hxJIKSe8rH/dq1HbJIe1BopPUJwgG3FV6GqUlwquKWsIcXB2Qi56QdCVgu3jInlR2mxYfENtmkT6POhc10cA2vUKhEe2aJ04JRYD9LTusUQsyOkBCH+YKSy05z2GemH38h2njojYw9Rsfe7bhCSUYg4GbeJny/LZ4dhFUpzBvQSSqQE5631XMHL9GvEm1OwbG9koYdzyezyzreqazd7ws42hAqo4tQBKS9ZY5IrxZ3xYKgKD6CDLJ6n22g9FBjGnkPbyIzF0ZxFFX3orDz6Euw21Zc0PtEwpNdG9+QNb4cwFZ4zsMS4Mh6NAU7tjMaPXp5T0ZevV7Q22CWFamb5aj6114qv9mfEfpiK0sr899TTMhjiIFQMYV3Hqko4Zvf69a7AdgNGJboG49+6U9Yll2dqQWEVVmFWHv1ODQsJ09KIsSPUIMhiwKAr1PXH6wY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WThqMnVpZ2VTU1ZyZGpGcG5tejVKMjQ4REVHNWFwYi9RY3lYOU03aUh6bjFU?=
 =?utf-8?B?VW9nYWxSbS9ZY1JDa0xoN3V0aGNzRGJiUkJjdTdwSVRsRFA4anBYTmNjWXpa?=
 =?utf-8?B?ODQ2cC9jZUs4UUl4WEh2OTJkUjhNeEk5ZjJIMWhWYjFBd05raXh2ZStBOHoy?=
 =?utf-8?B?ZG13Qnc1WTBRb0pDckRpTUpmcEZJODFXT21UUEJYc2pIcWJDZk9jcGVtWVY3?=
 =?utf-8?B?VURtczEySlBiMHg3TWNIYkVBNUdTdTlNR3duYW55UmhtT1VjTnZUT0l4bGlR?=
 =?utf-8?B?ZXBTY3gzdmxKUUJZeSt2Z29xVUdjc2VqKzNwaG11bnpoQkxLc0NWeDgvTG9X?=
 =?utf-8?B?UVppVHJ1N2tWUlM4ZllHM2t0ZHFkeE1aSzBzdHU0VzNwSkJXR0hicngycUd2?=
 =?utf-8?B?eU90ai9sSlJWL1p1aFA2Vit5MWlGRXFaYVhuZWFPOWtxZ2kwOVZ6blRvOGZC?=
 =?utf-8?B?WDhhTi9RelNkMDBIaXFnL081SU9IMmhpRDBVOTRHdjNXaVRvRS9VcE45dzFr?=
 =?utf-8?B?MWpUZmVIN1ByQzY1ZHFIVDVFc3dOdWdCNjNmUzV3NTZoTGRBVHUxTERUVllw?=
 =?utf-8?B?dTVIZjR3VE5KMUxTQ1Y5aGxxT1FqSGhNYTQ4MldsUDNFeWpITkE0eGRnWG5t?=
 =?utf-8?B?RGdUODRoM2tCckVLYmhSQ0lhczdENTN3cDVTM0h4Ti9NS2dmb2VDcUxUU0dz?=
 =?utf-8?B?ZlZwdWNvMWlIOVFhekFoMGtLUWo0VllBMzNXb2V0ajZhdm5IM25ZcU1OaDI5?=
 =?utf-8?B?ZzV3RVBwTnF1VVhQK3VwRkFRU3ZCcWZBaFdzUU05UG8zZ0Q1S01RdktaSnk5?=
 =?utf-8?B?RlczQjEwbEpXTWh3T3VZSlNISm5ka3MyOEhqN1hFRmJscWFvelBqaGJMbURa?=
 =?utf-8?B?VmdGSzFEYXlUK2ZFRzFwZnd2K2xiL0hNVzZwRWxYZzlJbmY2N3hGU3J0bFZl?=
 =?utf-8?B?emFqRXFTQnF2VE9iQ2FsV0VHNDU1YTNKTTNKNVBUK3BxNk1nblFNN2M3V2NB?=
 =?utf-8?B?YzNraUx4ZjNMR1paWjd1NGNQSk9FUXQ5Tm5ycnVDQURzRGVZTkxmcXBTdGt5?=
 =?utf-8?B?U0NXa01mNGxkMm1nUDk2WUoyYjlsVk0zY0cxUUMvakRTWEoyUjU2MHlkaUFR?=
 =?utf-8?B?NGkrRFVEaDIzWVo3eVRlcWZzNEVxM3o5TnNVWjVTN20vSVJ6YlRlSUtvMWRj?=
 =?utf-8?B?eHc0YTl0TzFzay9SQndYbGVxbFp0S05SQ2lsRVdSdWUrMEhrcm9MN1RkN1dz?=
 =?utf-8?B?YTZDNW96aU96VXJPR2hzQ2pDbmc2YUs2Y2pvRGY2ZGpmM3NGblFwZVhySUlj?=
 =?utf-8?B?elFHcHptZW5LVlBYTjVYYkpvbFk2RkQrZUIwVU1jWDdRdUdSWU1aamdTbVd5?=
 =?utf-8?B?UXpnNzA2NHNld0V2MDdDZytHZjFnUXRmeDlLMmtob0FyUnFpclB3VUNLOVg5?=
 =?utf-8?B?WjBXUnhhUzlWd01PUWd1eGFDMEYyQ2E2cndJbVFMZHhjcEVtSnhVbGZXUmNN?=
 =?utf-8?B?V1AyL0ljUVR6eE83UW9UZmxnVGhYN0YzT3IxOFk1VnVRY0xSYnpEdGlVWUxh?=
 =?utf-8?B?NHRkZHdndlB4UUJndnlJTWMrdnMrUDQzVU1vQVVQVVJRZFRSdDlNdW1Uc0Fr?=
 =?utf-8?B?UFJ5dmkwbUdWNk50WEduMCtoTkM3RG52RjJUVzl5czJvWStSWEtzVUVzaTZS?=
 =?utf-8?B?V2VlOURYaVlVWmJOVU9FSFpud3RaeXBHUk5pZmtnK3lLcjdmZDd2ZnVGTGpD?=
 =?utf-8?Q?ohGUZlWwZI5mnSLRDz+dViF3N87T9G2cGgINPbe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9201385d-a096-4503-bfa0-08dc3de9f375
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 14:30:20.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5044

On 3/6/2024 10:24 PM, Maxime Ripard wrote:
> Hi,
>
> On Wed, Mar 06, 2024 at 12:22:23AM +0800, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Originally, the initial clock rate is hardcoded to 0, this can lead to
>> some problem when setting a very small rate with CLK_MUX_ROUND_CLOSEST.
>>
>> For example, if the lowest possible rate provided by the mux is 1000Hz,
>> setting a rate below 500Hz will fail, because no clock can provide a
>> better rate than the non-existant 0Hz. But it should succeed with 1000Hz
>> being set.
>>
>> Setting the initial best parent to current parent could solve this bug.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> That patch makes sense to me, but this changes the behaviour of the function.
>
> Before, if we couldn't find a good configuration for the rate, we were
> error'ing out. Now, we keep the current configuration. We should
> document the new behaviour in the function documentation, and we should
> probably run that through kernelci to make sure we aren't breaking any
> platform (and from experience, we probably are).


We can limit the new behavior to CLK_MUX_ROUND_CLOSEST as well. The 
current behavior is okay for common muxes i think. Though probably wrong 
for CLK_MUX_ROUND_CLOSEST.


>
> Maxime


-- 
Regards,
Yang Xiwen


