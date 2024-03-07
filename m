Return-Path: <linux-kernel+bounces-95400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F294D874D36
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707171F24E41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D2128390;
	Thu,  7 Mar 2024 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aPCuvyrz"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2011.outbound.protection.outlook.com [40.92.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E886AE9;
	Thu,  7 Mar 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810294; cv=fail; b=rwbD2WBc8luZG1/QHmJVKCwn3WO1wMFNyG1x0GTvkHAGaU+HWm8Cf3Dmr7FkgxIVioNJ2zxfShPsK4yXC+emebd3Q08TU8vD5aXvtpJ3KLgMdSr2fH9Grgg7XBzjqi3l1JtDHaIKdvYqvrwXP50Ggh3oWni+zsUL00vVPa7RM7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810294; c=relaxed/simple;
	bh=e1UtNccqSuekjuyKQELIOccWaiKk4Et1imD2EF53NUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BfN+rE5IZuhrj07P1o3tjGgDc6MOufkGVlf9dmK4Ir0V7doxYZHv3zVEo9/u9S44FsXmkaobfdhq0c+cLLXKc6bIUBh+2LAeM98F+2/PggP9NrCJw9OKfMvZ8wS7Nn3s96a91et1WuknD+CjioRcgyY9P7Rn9yl4J5At0YGVc7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aPCuvyrz; arc=fail smtp.client-ip=40.92.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvyyblgLqNMuJgRdTROnw8hWtap5qkncrkTH8/Yf7BkjPtBImcf+MZdIQ0HcMbEQZ5ElsC06ICI0naHrVyOH53jXlJu5n4MBd54JWySLVU2wyAR840BMHrjKYsd8akRRYp10s2ngV3T9kkGJRfkyAHkkICliZ3lfzKLxtyDJuTMoLMyRAko9PiyJ5NxrvircXJjyE2fhbKAKUQRqCCV4+xEohjZMNATZcoC/Xkj+olBB+4OYkh9gPKiJCljro0EOOx5m3KozIunVUiJ1SFR0lbkUxL7G+ZY3Es6wYrBj3UQwr8PqLiKiGTcSbJ2VqHJRoHblSJ5/C5PfCjnhzmm1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OnX/BH6Xjawc0pDowAWuvFe/CmzILBKY/IW+PooznE=;
 b=RJcUARw4rhF1Q/UrJ6TdHAQZdSJSeL/G5u6ZSrunVNv230cvVrBzVFwH5mNqYsMCIdXuipNbiXkQu/uvAB5d3ksEKIaHegAYDA3/4LgMLtSoaVpiJTKb4E8JHEX/FplXXO8NNnfbGz8Yjr5xt4OKuSvgiz8CWiur905LXXTB+Yh1q6Se2UItMcf2/W0AOOk8bz0/Bv29MmN+Oy//v/+TKLQdShfO7uLX6hlPbuXilk1Y+NFbkt7hoQqg+7YA+mbMvWwkjpgyeZkNGaGh2/yQukTEU3zWBCWrUrCQls4jzd3A1CBKulsc1/r2wRJNSB1lTpTmP9x2jTTu2QSzvC4JUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OnX/BH6Xjawc0pDowAWuvFe/CmzILBKY/IW+PooznE=;
 b=aPCuvyrz/EAlpHlm9g50c504dT8c1gTMQT+u3DCuovMqc27J7hba4vPWVidOjLw4PEYdA2xoILez6Qce/bD4rVBcycXLD82Z5FUKz/wgQTn9+sV1ReAi0gv9IFYmNC9iKzzO2eNcqi1zCB/HqE9liigwbKarQYUSG+gE9mL2SJ+NKAR42wZOe19q8i00gTazvVJn4xa1mXdawUq/r5Adk0JPGuWVMS1EBha/72jvxE8NPbHGMpCKmy6oQdCHuqj9ztzgL68eXaDRQu26Nc+KCP/3j6pQcHXDsFZdTFW9W0QJ1SOTrz3mX3PsnvWU7WIYhPZhr3fI0d8G2C52jUZIcA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TY0PR06MB5610.apcprd06.prod.outlook.com (2603:1096:400:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 11:18:09 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 11:18:09 +0000
Message-ID:
 <SEZPR06MB6959882F5DA673456A3AA85D96202@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 7 Mar 2024 19:18:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: set initial best mux parent to current parent
 with CLK_MUX_ROUND_CLOSEST
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307-mux-v3-1-0885fc1ab2c9@outlook.com>
 <20240307-hot-hummingbird-of-atheism-87503c@houat>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240307-hot-hummingbird-of-atheism-87503c@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [0GIMtF9n+AeMdnid0UXlEF+1JRk8/WqqWkBxfu4KD+oIeClG5dm7SX3ppXumtX2G]
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <4502b9ff-d0bc-45f6-80d4-2e0ebc75061e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TY0PR06MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a4c4d5-c6be-49cc-a22a-08dc3e9844cd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PvySqgxivn9LzJbd3BpghVovMSIVW2F6IamyKeoBUxdmtLuFTRal9st9e8fRdwIhPv0W3JE3N8Tr8nbhV9wSOK75osuvIL2srZBBQieYlhnx8Neeu922yIAZvnpnjgyLS0zv11/o19oE7xYyA8z6SjYM6WrSvj2UxlxUDHNUNlZXYfOErJYo5b3iRA/01X9i61P4vU9OEF1E+s5f5+DsSRIM6uLiqAu2xNYwd85R4vvZ2kr+AxNLK2K6qzZZVc6cWkNCDltNTSypa3OIXYj2TGvT8zcJ2yH2lfI7BkK1H6SnAYsGXBtPCWNTO7Wh7apXGnvsozbblyPSih6rw4zNLMk/oJKHa+EqJ6xLx/AqwpeQplW3N61xXonYyb/eHGeV1ucL1GKBHOnWgeSizV/RlIYI4K75spWduGYtgxDG2cF8LYErgQIdiCCYJYCqADd9Q5lcWF9OKZhgXgAxhBl2uzo8XzZmzLzPmVkpkDi+uvYO7jKkYPeN2+hrr5tMAf16EHrp59izAuQMZFQLGYHwAtJntjb6HcEN0TIMwluY+FYCkozTiH6+M7khXR5DTZOe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjJEK0VlaXhJckNtZTkrdEpKUGZrWU5OUnFBd1RqU2J5Q3lodG0zR2ExQjkw?=
 =?utf-8?B?cjhCQ2l0QlQ5UGNkVm5lZFpUZ2IxN240eWJSR0pqTk9QWWYyekdnY25VN1JJ?=
 =?utf-8?B?V0hvdHBYUnczWWF2SWM1L3NVYkE4Sm9JZ2o5SUQ4N3h5aE1tWVdBM2phVGhI?=
 =?utf-8?B?MmtUTWtGRFRIVUpPalZ4VEZiUjEyejRsRUhvR015dVlia3lqVnptOFgzMGsy?=
 =?utf-8?B?czFXWXhCWUdVNmpmR3pHME54dlJXUE1VZFdZelEzVW9QamZMQmJHUDNBVzVv?=
 =?utf-8?B?bEZtU0cwZ09xM0NJenRMS3g3bW0vMkVUTSsyNUI0dmlZUkp3bG1Tb3dPcVFz?=
 =?utf-8?B?bHJWRlV2OURhWU5jbGxvbGhRNjhOVEtuTGRDTE1iSFYrWldxeGxFOWh4YktG?=
 =?utf-8?B?UXJjMFd0Um5KdDVnelhOWDkxTnhsdDRvdDBFaEN3M28xdkhLcHBudm5PK2Zp?=
 =?utf-8?B?QnZBL1lCOENSSE81cTRQZFVnMXBCVFJtb0tMdVgyYnV3YVBNNlVRUmVTRjNt?=
 =?utf-8?B?VVRuWHVPWW51eThMQ2t5ZXViNUtvSTh4STVNQlBvZis0ZGFjWTNHWGgyOHBu?=
 =?utf-8?B?OEhWT0ZySzJIZDNkMVlwaU90ODhIQlg5TnpSME9tRU5uWHVHS3VVMm9hbi9X?=
 =?utf-8?B?YzcrQWpWRmhEbStwa3hzdjBrV3NacG1XZlRoZ0Q4TmRGeThDYmdkRWk1NjNL?=
 =?utf-8?B?SFZ6aUo3TlNHZ1h4RXExWndUQ25KbUJPY0d2VTByUjdBRXVXQzl4dkFrQWtm?=
 =?utf-8?B?eHdZVjBMeDVWZmpqVGNwZ3ZYVC9KbnRjV2VWdUpZWXNkb2R4T1hKbWJTdmxH?=
 =?utf-8?B?VHlRbTluQVdDeDl0TVcvK21qTTExMUVKVEM5N3diU2dXZEY5WS91K1F2TmJ0?=
 =?utf-8?B?Vi8zVjdkakxWVWdmckhEY1JZVHZQQkNJeWJYMHBZSGhQZTFmclR1UmJITG5Q?=
 =?utf-8?B?clBkbzQrVDVwZzcvVURsTzgwOTVWcC92Z084RmsraENmMGJ2Nkh4aThhczZP?=
 =?utf-8?B?YW1CMmpqRWJtWnNCKzFSUXpWS083cjhRWVVCT2U0L1BESENqMU9lTkxCUnp2?=
 =?utf-8?B?RjdyWC9wMGhaTXdwN0lJLzAzRzMxc2NWbVhxcExQalBMT1FUOWRjaGtrWXo5?=
 =?utf-8?B?dFRyMGxEcDZoSjVBY1pIVlZCSkxJSFN4WXRnOUMvMFY5TENNdEpEaEs0cWJP?=
 =?utf-8?B?UTFGdWZKMnJOYm5FaE5GbVZwMlRISG9PQlN6T0JkVmFrM3hBbUhqWXpQMk4z?=
 =?utf-8?B?dDBiZGF0QllVQ2g1aXpaNFloRWVuNTdMUm5mc3QyelZrdXJONDFYMHJsNTdh?=
 =?utf-8?B?S0ljdkY5ck1OUUJ6bmRpK3hDeWc5dG84NEg5SGVpNGlvVjM4YTVRQ2xtMkYy?=
 =?utf-8?B?UnZ4ZzhPSDJwb1BtRGJMOU1rbmpkZFBoeWp6dHJWRUE2TlVzcUF6eG1PTFhZ?=
 =?utf-8?B?OXNqbnZvc2h1Mk9pRkVKc0gxSjMzb0d1VGVUc2ovbjJTMjhkemJaU0xSaW9X?=
 =?utf-8?B?cDRkbUsreHZQdit0WE1mYnh1Q1laeW5BV0oycCsvc2VZbVE1OWNBeFlEZ0h2?=
 =?utf-8?B?dXVLcmtoUEppQm5FeGFhYmJzL09Mejl1TllNN2JYVGhIaG85UkN4cExlZHRU?=
 =?utf-8?B?NjV0blFyZWNVZEt3czVBSTlOam5QM0haKzlxMlBNTlUzcVNWWkJKL3pRVUFM?=
 =?utf-8?B?RWVERXh0b3E2dXBDOXFOTnJJZ21wd1ZQUU9KR0YyVCtzeCtKUnBoSGQ1SkRX?=
 =?utf-8?Q?H6uaLtMPRNNCwVC9jy/AqzPnDjq31dP7YPbXt3/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a4c4d5-c6be-49cc-a22a-08dc3e9844cd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:18:09.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5610

On 3/7/2024 4:48 PM, Maxime Ripard wrote:
> Hi,
>
> On Thu, Mar 07, 2024 at 10:03:50AM +0800, Yang Xiwen via B4 Relay wrote:
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
> I don't think it would be the way to go. The biggest issue to me is that
> it's inconsistent, and only changing the behaviour for a given flag
> doesn't solve that.


I think the current behavior is odd but conforms to the document if 
CLK_MUX_ROUND_CLOSEST is not specified. If i understand correctly, the 
default behavior of mux clocks is to select the closest rate lower than 
requested rate, and CLK_MUX_ROUND_CLOSEST removes the "lower than" 
limitation, which is what this version tries to accomplish.


>
> And again, either way, we should document it. And run it through kernelci.
>
> Maxime


-- 
Regards,
Yang Xiwen


