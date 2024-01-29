Return-Path: <linux-kernel+bounces-42338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702E83FFD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D891282C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E385F52F8E;
	Mon, 29 Jan 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="isVh1dkR"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2113.outbound.protection.outlook.com [40.107.7.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30C52F7D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516277; cv=fail; b=oDeGIYIw7xIijAP23FlyBA5iNbP8etDmNINYKokWJjFvzKvNQaivWzERSHi6lhpRRU4gPk5KWd8+tIZX2dmFbQ6hyP2JtInshRH993wSgYeGbQkqUFblxCUNB0qhhVDHN9dBysazybgoPzj2TqXRAathrj2iCvgIJhXdFClihKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516277; c=relaxed/simple;
	bh=xBOxsl0/Yf+i3xy047AF6SBoLw+t0sYKRYNitGbriXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UP2ur5oHk8CvPdEI0apEPECP7zrfQmsCb8+spsHG4hwJ2fojtDMTbkpYA8bzjxYg0QhKM3WPbzGyWHGvIow6cKy4n1lw6EOE6JR1mq05P6gWVtpWl7llCNxYgKd69i6BXBYleDrkDy0zYC45exEm6kYkHtA/nlLQVNxm6ucYFl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=isVh1dkR; arc=fail smtp.client-ip=40.107.7.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHLW+6GC2xwZRU9ybQ9aObIOFaE8QvWUwSFsRMBauEf6YEmtZPs+jeez12/9q8D8mEXh17l8Mufc/4DF9agOmmH0ybaLj1fFK0HObSGKX/F4FP15+bHGEyUbTOQCMjX2ZqDcm3SQR56QeRf4xHAGEnFFwukfXg+q1YsR9FE5NtiRWsBotpVYO62AoYnYbdqgzDhqM9+AMrfzX/SA0ZIfuWUzIXpJWr4z+xXdxTDZODoGdnqGeXHcKK0qHxouU/xcDxC+ay9m9TzoE391xeYo0gYku84MlKtOJScAk1cX2MQB3TM9IJmIR9KVQ6UlO/jYTIEx4kCgw3+f9xJnrbyKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbGZfX7GN4VCgix0Auh467JXRGwu8olphbVDSo3nER0=;
 b=KV6N1fyL6s/UXixGLqh9vR9Rm11az72m6/ncZi9CBS7FM0Xo7XYGadsOg0WMevq5vsibuWdUQJ77vO32aDNm7NQWVwcmvgIGPS1kHYSwN2uexQzqLZt+swLy04fmWfDAgZMv51v1kj1LU1U6Goe66G7O8ve4p4KbHv8QSG4Z4Mn4GkX84DllLKE02zNZK6KSowVJ12ocIZNsumNQCQoF9mx8ac+j+er0PKFcbxs5m8hQc+g7HEeCN6KxNuRKw5WSi+GM3Tpsi2e4lQBnVwOzf4HsGN8TbJRbVexg1QahoGhKmCYpDH4D9x0pugJDC8Iu7DdU6zyUEe5PNBAbgj/t6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbGZfX7GN4VCgix0Auh467JXRGwu8olphbVDSo3nER0=;
 b=isVh1dkREPdRNgvgzo9ZghVDCBEwqxT7ZVuDRhQMlKBwUAihBSOugC2jwXdn8Vh0IJR9sFzxFX1KjN8w1KwtIBPet1EqcGYWwQ4hGqb27HunKMoXcwyPX7hVDq3uEN+5fV2VvuyRadKe64S5Tnla4N7cvABRUw9eMo2aygUWtDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PRAPR10MB5321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:17:50 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::44de:8e9c:72ac:a985]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::44de:8e9c:72ac:a985%6]) with mapi id 15.20.7228.027; Mon, 29 Jan 2024
 08:17:50 +0000
Message-ID: <e2688a01-47d2-4f89-ab92-252f378d37ba@kontron.de>
Date: Mon, 29 Jan 2024 09:17:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation
 rounding
To: Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com, Inki Dae <inki.dae@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20231212033259.189718-1-aford173@gmail.com>
 <20231212033259.189718-2-aford173@gmail.com>
 <CAHCN7xKKMzOtVaEXzgTgsO4yZF0JZ6=o+TFJOeTCza0fMGss2w@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAHCN7xKKMzOtVaEXzgTgsO4yZF0JZ6=o+TFJOeTCza0fMGss2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PRAPR10MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: eb672d13-c5b3-47fb-5703-08dc20a2c892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N1p05e3toAqUjumtJhFxipqKWySQ5pZqFNBtxW/5UhKpSTjaguH0Ln6KvlrQfGznW6EW8df672THdyW6Brn7+yCx3NuudCZ8eoj05WgRN0XCxjYRQ9oeJNKVKyPcUkb74rrVxpYP7YNVVpmL/4r6/mjoZtqOINgPBQygLnirhPAGb9+NUqU/R4fB6VBrnixnGSOSaIQVAv3OMIqFAbj/O6aa6BdIMc7Jj3KmfQLqhftEpKpT4RcHSzEdB6jtl4fBZy+ZyDVrXv5LATI2gv3nO/Cqf6P85xf4e4rncSDhJ9kgM4Q7yzMoASDBKq7CoWKElThljhcY3ZBm4uDGd5vrtZzY9s4TEQ8WnWu8cTotzscMuEiDtw1gQsC/81PELgtZaluRZyiM3j7flsDalct8S7jdIgsf+TRrGRsoqJNBXdbng6tMKLl0uEvxYMDpyoZAAZwMl746coSs65nTUeOttbZ9EXMYb7lx6CNrF7WmYgMzGgrteiPSVSf4l9iZ434zkDfAdqjkP3NzVqE+UB9THetkS1LAP7Kn07XMqluGVPFBY+c1TvTWrlCxiGjib0x1wVLBVbwUp5AUlIRJau8oBIhEqWKTaQ2ogAswlQSire2UFdOYOMTdTlTh0vMFuMZsv876+LjuGW72VsJp49m0kg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(2616005)(26005)(31686004)(316002)(54906003)(36756003)(66476007)(6512007)(478600001)(53546011)(6506007)(83380400001)(6486002)(38100700002)(66556008)(5660300002)(7416002)(44832011)(8676002)(2906002)(66946007)(31696002)(86362001)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0d3YU42Tktyb2plbG9TU3dZYXZIV1hEZ0xQMmNZVTFacGhaVGVkTjlTV25E?=
 =?utf-8?B?YVE0NklyV1RaYllBYUgzZDhETnpqbVVyREwrejRMeWl2Sm1OSkRXNmw1Yjl3?=
 =?utf-8?B?YlRzTjFCTTFDaXJlbEsxUkpxSlBhWG9nTDZvaW1ET1JaUWFMWGZZQ1BWU0Vj?=
 =?utf-8?B?RmdabS9mTFJwaE9EN09oZFd3T3ZmRUZyTFMxT2JhL3NvWUlpVXBINFJ6ODVM?=
 =?utf-8?B?MzB5MnhjRVRJcnBjWnRjMU1JRmprWFZlbkJWaGlIMVRiRVJSd0U3TmpINy9J?=
 =?utf-8?B?K01GNU9xblRxVkREVzFpc1l1Y3h6UW1HTExDdVdTaTJkcjkrRTdIOHhVNnpU?=
 =?utf-8?B?WW9TMTVzNTU1anRuMHRCaFpZNzVveUtOampidUNOV3MzZklpbVROUXpKSmp6?=
 =?utf-8?B?MUFKMmdEVDlxNlVPWlRod3E5VVVnVzJVSWlLMzN6Wkl5dFBEaGxIcFhoQWND?=
 =?utf-8?B?WFhVaFowbnZYN3dHeGJPSExLQzN0VUNIQVVWUFFvRnU4VEMyWGFWd0JnZnpY?=
 =?utf-8?B?MWNPRU8yek52RFVYVmpJN2NyRG1HZXBkYkMyQUpzbUZQaHZuSXRuRXRiUlpr?=
 =?utf-8?B?QzlRZ3VkMWpWODdDYUkrejdTOHJBQ3VtMytkbExkeW5kckc4T2hmaGJtRHlX?=
 =?utf-8?B?Q0Q5TEVHaE1LOHBBTWIzREJzdm1pa0FGYlhLNFZvQ2Q0VGovS2Rlc21pS0dX?=
 =?utf-8?B?bTE4SGROeFd2bDhVbUE0M2tyc01OVGU4bDZFUk4xWDhDQUNkUzU2bE9mSG5Z?=
 =?utf-8?B?M3VaeUlFTm42ejZ5QnkyT21RbUxYSEwvd0UvMXlBZElmYTIwUlBGZ0xGS2J2?=
 =?utf-8?B?QVJ3cUtEL1dMMHhFdVdrajcwbWg0cjhMY3djS0ZuZk8yR1YyNW5FeC96Z2NT?=
 =?utf-8?B?MnJEK3F0ZU9ORDdMUXBNOHRmeGwyRDNjbEI2YldObklxbldYTEdmRU9VREZT?=
 =?utf-8?B?WXd6RmY1UWRMTXB3WURROHc4MGpwM0Y0cWpyUzNyazVSZm41amFMUTloMk1a?=
 =?utf-8?B?THFCVWJ3QSt2VUVaNHN5c2ZJUENSd0hIc0VXbk9sZ2dYZk00dVdrTkNMMnRC?=
 =?utf-8?B?MXhzdjRiQ2JyUDJRYlkvVGs4YUtrOWVUL1hlZkNhU0NDa2NieE9CRmRUZVRP?=
 =?utf-8?B?VktTbkFxdHdZRmorNzJuaUgwbXJHR0tJNElBcWpnZitGZGtpY2Y2S2V5RWpz?=
 =?utf-8?B?dlZqRkNveHJPd0ZvZTdKcE4yZWh6eVphVHFPQk5OeUt5RlBTcmFERVpFWXZQ?=
 =?utf-8?B?MEpiWWJSdDRtTTQzSldxZkptR3RNcU51VUVoc3BOUlcyL2x6VDl3S2Yxai9z?=
 =?utf-8?B?ajZDRjJlZEkxSk9EUkthOUs5MGdHRHg5WndGN3pEdmFURlUwWlFtaVhlVDZS?=
 =?utf-8?B?ZlpKRzV6L3lBWCtoVDBEOHFNNTl0eC9OZ1RlRElTRUdEakJOWkZEMElqZjVz?=
 =?utf-8?B?TU9mMDJPeDlmT3J4QVhmUzFzZGt0ZUxWV1IzTkF3d3p3UTY3ODBhSWZXOE90?=
 =?utf-8?B?RFZUM0ZsdHdKYmV3UG5CRkNWQ24wYVlLSnpBNHRxekEwYThMeGdYQmx2ZHFD?=
 =?utf-8?B?bXM4TXVlejVDaFhBVjYrZlpPUjZsY3l4cVZweVVzci9nVkQybGRvUTFacjUz?=
 =?utf-8?B?YW0zVklHekpSelBDMlVjeFhzRzZpa1FYRE1XZWExSnhDTGx5YnR2S3lPalBh?=
 =?utf-8?B?R2JSNW1PaFhjNFoxS01ZV05vbDFjSmxyTmtIUTJHTVlQa0ZXM3VGd0NPRTJy?=
 =?utf-8?B?b1pZZDc0TXBaU1BzYll1VEI4dFdwUkpERHJwWmFCMWJZeEVHSmZwd0xpbnRT?=
 =?utf-8?B?SW5YYzZsTHpMT3M1cmplaEtWQ2c4aHZUMCtYU2VjVGRuYjRIWmkzeFRvalVR?=
 =?utf-8?B?cDB2Uno1VlEwYWxSbEFxQnhoZjJZdnc3T3ZDK1NGUnFjeWRyZ21OTU9KT3p6?=
 =?utf-8?B?dWpEQWx5UTMrbDBUNlFOWDFwS1dlMllNNUZ6U0JuMVFnekZ0b21HcW9hTDk4?=
 =?utf-8?B?YVo4NitqOE1JMk1pVDNyMXlSLzBGWkh3U0xaYUovc3JpMk55WlZMZlU1d3g1?=
 =?utf-8?B?b3crOG9hU1hYWWsxOHhvVlQyYWhHajdpajRQRGgwVW5FbmpESkZhK2I0U2sr?=
 =?utf-8?B?QkdUdFpvVUdFM3RnaFpVQm0xZ1EyZ0FFUnlPTHpXbTdvanFMOHN2MFJTS0dG?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb672d13-c5b3-47fb-5703-08dc20a2c892
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:17:50.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJVD4NdZaeZmAW1157Co3/RWDDMxL8W/59H2QyaaQ6m4yQ9JO7aSD5Z+GePRLm4FRFlXdxJAg3IvhM4BGTN5+DOQ2cpA0rYkCcNd8DwYq8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5321

On 25.01.24 19:44, Adam Ford wrote:
> On Mon, Dec 11, 2023 at 9:33 PM Adam Ford <aford173@gmail.com> wrote:
>>
>> When using video sync pulses, the HFP, HBP, and HSA are divided between
>> the available lanes if there is more than one lane.  For certain
>> timings and lane configurations, the HFP may not be evenly divisible.
>> If the HFP is rounded down, it ends up being too small which can cause
>> some monitors to not sync properly. In these instances, adjust htotal
>> and hsync to round the HFP up, and recalculate the htotal.
>>
>> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM with HDMI monitor
>> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> Gentle nudge on this one.  Basically this fixes an issue with the 8MP,
> but it's still unknown why it doesn't work on 8MM or 8MN, but Frieder
> confirmed there are no regressions on 8MM or 8MN.

I only tested two specific display setups on i.MX8MM. So of course I
can't confirm the absence of regressions in general.

Anyway, I think this should be applied.

