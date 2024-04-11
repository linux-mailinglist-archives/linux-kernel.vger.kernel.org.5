Return-Path: <linux-kernel+bounces-140255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668BC8A104F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D287B266C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649A8148314;
	Thu, 11 Apr 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sGByOkNE"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2062.outbound.protection.outlook.com [40.92.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716CB1487E6;
	Thu, 11 Apr 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831529; cv=fail; b=CVFWl8zCw2/wNrK4GNYQXClC39qgbMeQniiQvUc0MDZuDYpSfkB8C0+A3K+zgUNJB+1TlTmm+J6tiNdiFxD6aH6dlmshyj1i7iazD8vhb8MDc7C0MIa1ZJXlifBzY0wNKOSutnluCIvgAiZckVS7VSz5MIC3Z3jYrhGBz0cZmX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831529; c=relaxed/simple;
	bh=dbr50i99DjMGMfkMgP6fiYWh4igfNJL6RxxIGHEJ3jE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W6QckLERXiwSR3FvttKb6MMvkOX56tWJdoj7cTpHOv9P8+LwE1aWKXaBzdPxhTBEMq3K/K5UuS9x+FCGVqYMjbVIYEA44rQby9bCDKOIv46YHbhF/XoIxFqS63TjJefbDsZbG9gcbbUsFwRVzm0TJskDC6+B5JYaouCVFcCe0do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sGByOkNE; arc=fail smtp.client-ip=40.92.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8vaBu2oNaxwOqLZepcl2li55+Hb4+xZcP3zXvVIgp5cKIO/iheBTeSSz3csMM1cxbySzolqkgSyYXCOgPnNFSAPWtRnSjoFuNu5JXg6Uw3a0sGX6lWJ6TcbcRPSqm9FzjwvhThpIbFwpkkiqKPGw/CRiVDdzNBC+9tPZ0JiiGG8l3mbjcfhWallE5nfRID2k0HbJRqqYTcMLGdf/2oq4LXM6o6YlX65ooI0WP6QkgC8hfwKS3gJCycqwQLW+I2Ny2gnWk9BbFvGkVPVFdMC4SjGc6jhfgHE3ZHOG6YmScwTos1STc8Cc7slUyAt/EJ9kVSfTUOOBBp2VoLuw3b81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R06FXRuVU9DGo+kwtajkTm83AH2stYDzzH7sMAFai3A=;
 b=anQC/7CE5WlqVKh0VCxExtO1UtYNQ4qC9F6jvbVKsSjv9Uh30q+e/WyYEKHT4WWOAADFT1h3+R+iCuuReYZb5/8HPrDxfJca/2F5LDQS72rWkUvwSxvuI4nJCCZ+4O2WL79mHo1MbiFcqlJJQLU72yAzhy4QzWnDtjQzM0x0PLNwiD2CcL6KvV+0gS9xYTCy+FyjTIL5tlkf63AW0kPLDck92wemVb206q7u8j49o8mPPtPe1ftxTYk8cFRzZguMXerFlGTqr2ek13L2gFkUfzstWSmy4QxBdrtB/7ene856h5iSnq4POdkpy2s1qZNsNJwM2pZwDjpwyNYsg9Qk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R06FXRuVU9DGo+kwtajkTm83AH2stYDzzH7sMAFai3A=;
 b=sGByOkNEv+TpTCpYihlmkNJb87Yo+YK3DYPvHQAkxfZcL/o/tpW76TwYoudORgkkzCa5d2xmHgo6EUz2Rw1GBUy1O2w6QjKMRhVxdi1L3r8w+NhCO9cJmfr5CVbcvVQick8IWsXXKRpHCaQllosNjgw8cDjST6NnZj/MDwSJ8pk+Lsz0hEXB+9yMvve5SGaKqiMmeWe7eBEsqip55MvvIDsvraVwIp9C9KIbQxWclSr9nZofWcxD0D/HHo9deREBfUoWaKwGBe2SQ1zZ/93uWh/5vDYhh6KgoukkXDzWekcE9dFpm35/7kI8KRVqloA0Mpy6rNQUMu9xCKoPLtROUw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6095.apcprd06.prod.outlook.com (2603:1096:400:342::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 10:32:03 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::351e:200b:add4:6478]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::351e:200b:add4:6478%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 10:32:03 +0000
Message-ID:
 <SEZPR06MB69596A0104AA2385391049EA96052@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 11 Apr 2024 18:31:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] clk: hisilicon: rename hi3519 PLL registration
 function
To: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>,
 Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240225-pll-v1-0-fad6511479c6@outlook.com>
 <20240225-pll-v1-1-fad6511479c6@outlook.com>
 <d8dc639c2c6d188d2ce3728573d9a53d.sboyd@kernel.org>
 <SEZPR06MB6959E563B692827A3E5152DD96052@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <fa5fe57faeda3323174e4caddc1ac2a6.sboyd@kernel.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <fa5fe57faeda3323174e4caddc1ac2a6.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [tODC011ah1cU5v9bycpd4wRXdqrPM13xu/LSTrbQOD0rSFrFDMpw5kttL2N0Bipj]
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <5d6fe5a1-cfb4-4172-90f6-3e3c17bb177b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: c19ea522-abf0-4486-74ec-08dc5a12a0ae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vAj+5Kc7+XHS18qYubMgZrpsV/p1qfc34dvF/4j+TSFT24lhFR+iR0eT4EYinX9MpwaYaSznhVQhwU+DycjAohQzDzJt5VZEc90GDumo36BjKU/8cxdyQ2hpvw7C1aQvLmCFgT8jk/8Zuou6ClT5N83H8rPxUInPI2cwoB3crgsI8i04YG9R8ITCIZkOa+FT6AmdCLg/2GOJgo49HcWB+cWX16t2Dp4zu863vremooR7UMDgkqaPvfucmX9kAXtkXXVZagDUv0q2G56AAoNnN1U1l92dOR83L6J80EJ/U6BMDvB9LgQz4GfT0BgXbeanw8Wy/PKNfEerB3bSQMSWBN+CIvFNz8IOX1dpUMlIbDJIopHwz9KLAPmZ+FkAaBohWM+ks3EXWk9sxGORApzgp/qj++nuq+K0R7xFuxVMtAmJKCO1m3kcRqqYss3nDR8EuAQ3/XXLt2+kHNOXAi7RdBPDNTw3gr0gH7iwKLxTRmw2FyT81R9IJOhWlOxOgEp21Qa6M1ew0o4QRH9T6IUyhRtmtp8yvtAIqVPuY60C+6VOt/gFH8QJ+QZqlYZKo6Gv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTVXTGtXMDRsNFlBUkorRjkrTjdJTXJPTmR3Y3ExSmFZc1VpZ09wclR3TWVh?=
 =?utf-8?B?M2VNbW9CVXFMWmYvM2NwU3RUT2NIU1RZajdUaDY5L1FSYW5Dby81UDg1Y08r?=
 =?utf-8?B?dStGZVlXSXZkZ0xTalVrRFByZ3grNnNzRGdkc21OL00ydENvUGRLTVhkakRi?=
 =?utf-8?B?dldrWHJZY0xHZWhIbHNPZXVRV3hQdzZzaVBJMzJKY1ZQNm5JeDdRSnNtTFFC?=
 =?utf-8?B?b1E3SnE4cHNpcXpIZEJxT3JBUXZaRjVPeVRrTzZqWitmMWNSUkcrRTQxdzRz?=
 =?utf-8?B?LzBrODllb3AxL3JiUitQSGs1R1FuZlQ0UUlPYTFBWTBwVFl5SXhGU3ovb29r?=
 =?utf-8?B?azExWkUzYWREcThUeFdYeXpNSWNTSVdyeVVPdHh0bThyUHBQa2J2ODNJNjdX?=
 =?utf-8?B?NitDYVpmN2hwWG9qQklzZjcyRmFHZ2VVWHRjRXlqU1FVU05Nbm5Dbm15NW5T?=
 =?utf-8?B?MmwvTmRmOUxraFBIVndZRmlyWDZnVnJ6YkMrR3R1YloweGRObHJPNVo4WDNa?=
 =?utf-8?B?bUVzRi9wd24ydkJUeVdGcVFKWTduL3ZtS3pyVHFzZERaTmxITDRibGprWnZI?=
 =?utf-8?B?WXVWZnRjNXEvaUVSNnE1RVpRYmphaHJFSFdxTU41VjlLNGZ1aUFqNkdiRFpS?=
 =?utf-8?B?RUl3VENFaWM5UjVLV1B3L2szb21ybEhYUzcrNnJWOXNIQ280cUxRZ0NVbmdW?=
 =?utf-8?B?ZlRsQkZUeUhEWkdTT0E0Z25qYldRMEFHNXlLMU04ZnpzUTR5NnpqWk5ud0tn?=
 =?utf-8?B?ZE9JY1lkbzRacWhvc3lWcjlGWDlCa2VxZjUxS3g0bDBiMTJGUDQrUDg4RTJj?=
 =?utf-8?B?S1NFVFQwMTMrWUZHdXZoZ0FGeVg0SG1jWW5ZM093UjQyTHZYN3lDWW5RczYv?=
 =?utf-8?B?bUpxME9vMVEzVFA4dVJ6UXVodUtGOE1xTXRIWmE0RWlSd2YvU3VSNXBUTFlj?=
 =?utf-8?B?NHJiMWh5SUM3dnhRWSttVDNWYkhWOFZ3MDZpeVJpa00vTnk3U3VzMldrcEVI?=
 =?utf-8?B?ZEVvY1U2NlNiYlVrc3dPQXlucWFYdGtIUkJBQnBHNWFzcW0xT3hPdWF0cTd6?=
 =?utf-8?B?ZFZReXNjdkF5dHFzL2FSVzE2TEpSSUVyVjZITWZOaU43SVpaS2cwZFRGQjNY?=
 =?utf-8?B?TnZFRTJJelFST01sVlZWME1kOUJVUGF3emRscnZ4VVdRa1NtRTMvR0xLMWQx?=
 =?utf-8?B?TjNHVlJtaUpVbGtJMTdjREZxaFhNSmtGY2F1cXEwUE9RUE9lOHVSOXNhMmd5?=
 =?utf-8?B?eEcwWWJPeS96Sm9MQldMMmJWTFRCOXZqMm9sdlJSY2tHSjRiQktXcjlsTVNW?=
 =?utf-8?B?OFl4TE5Ja2F3ZXZ1MDlUanFkZklvY2MwQzZzSG5oOHpJUEdOM05LdXd2VGVz?=
 =?utf-8?B?WEJaaTFad3FVbDlSQUc5Qk02TzE4L0xNVVk3Y2tGTUR1U1lzaFo3UU1hd2hE?=
 =?utf-8?B?azdVd2pmY3hWUGs4NU00aXVWQXRYMXNVK2hBalpaY0FTc29xRkMxZXNiN2J2?=
 =?utf-8?B?bzR2K2hEbCt5QXdzZ2pBRm1WcmVqVk1GMXYzSHFuNVNiYkFmMXZYWTJpc09z?=
 =?utf-8?B?OXFFN2g1d0tUZUM3dEJpYTJaMngxV3lrMGtHMVM1Y1RyeElMZ1MzWUVWNDgy?=
 =?utf-8?B?VEUrNktBcU1jNlovUkU2QllBRjhENjU2YWdDV0tlUi9IN0hLWkVOU0xSUUkz?=
 =?utf-8?B?bjdrcFV5M0JEazhVWlMwSkJSd3FtMFpMMnZqdWVzRHVJRWZOTVdyRTVKZmdR?=
 =?utf-8?Q?jbIyJIg4VU0lH1I7+pIqB/iltmlEdGv1QKo1zFb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19ea522-abf0-4486-74ec-08dc5a12a0ae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 10:32:03.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6095

On 4/11/2024 3:53 PM, Stephen Boyd wrote:
> Quoting Yang Xiwen (2024-04-11 00:44:33)
>> On 4/11/2024 2:52 PM, Stephen Boyd wrote:
>>> Quoting Yang Xiwen via B4 Relay (2024-02-24 08:56:09)
>>>> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
>>>> index ff4ca0edce06..77fa4203a428 100644
>>>> --- a/drivers/clk/hisilicon/clk-hi3559a.c
>>>> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
>>>> @@ -452,7 +452,7 @@ static const struct clk_ops hisi_clk_pll_ops = {
>>>>           .recalc_rate = clk_pll_recalc_rate,
>>>>    };
>>>>    
>>>> -static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
>>>> +static void _hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
>>> Prefix it with hi3559a then to be SoC specific please. But this is also
>>> static so I'm not sure why this patch is needed at all.
>>
>> it includes the header that marks this function non-static. Also the
>> prototype is incompatible.
> What is 'it'?


The line 18 `#include "clk.h"`, and please see patch 2.


Patch 2 added 2 functions to "clk.h", one of them reused the 
`hisi_clk_register_pll` name with a different prototype.


>
>   $ git grep hisi_clk_register_pll
>   drivers/clk/hisilicon/clk-hi3559a.c:static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
>   drivers/clk/hisilicon/clk-hi3559a.c:    hisi_clk_register_pll(hi3559av100_pll_clks,


a snippet copied from patch 2:


+int hisi_clk_register_pll(struct device *dev, const struct hisi_pll_clock *clks,
+			  int nums, struct hisi_clock_data *data);


-- 
Regards,
Yang Xiwen


