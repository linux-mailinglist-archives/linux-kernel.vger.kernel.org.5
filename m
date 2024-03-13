Return-Path: <linux-kernel+bounces-101293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E865C87A52A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7694C1F2207C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF58122EE9;
	Wed, 13 Mar 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="LuAiZgTo"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5131B273;
	Wed, 13 Mar 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323308; cv=fail; b=ZJ9dvk+6KflYAnKrHpiA7GCmZqAgnLSXa0gstRioZM2yIT4HL0BF0ZhBvEOutFZUE5fyE6EzCWjCwFlE+uEKJkpBFe8Nr+mOsOWXFqy6e9cILLxvTW4YRKjPVGPXfOya2zwGnCNKzA7zElyU6V1bloxyfW9mJoTjsMPq3rF/XCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323308; c=relaxed/simple;
	bh=vSrOK9Z7Ok/G6Qx2iGza66zPh0vweUEvpXAsFtmK6F8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eaY1Qt3NIg47N8OZYZ5ZTgPOHIU7XiqhbqaMtI0DeyP52KDnlqZXjWKXZvTw5jS9Z+XEQqRypLYLe/RBhdCCxJHUNhw+edvRHgAkhuJgD4eyHPulQ5PF5LNNWeNRD/WbM2fB9ET9uV5RemQSkcZnZRvuERB6bIsVpiJ0qO9aGpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=LuAiZgTo; arc=fail smtp.client-ip=40.107.255.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv/hFqWhaPvfdh5P0EAsXp3fZ57jmIfPQ6rUSnWaLZEcJhLyVQLTKO3P9icxQh+KsFa6ZvdgPz0No44svmr9YonZBubK1+Tcd0hehkvut//qw2VJ5TCo3TkHOQfNOBwUJw7acbVAUVFosyunjcuAfIxS2PcyacVSZtBfmvjSddDxGoNKwkLZIJJu1cvE5FjZpPx6UucbRm7YUC2NNxUhfqLSLNHac6O4RVjfPsMYOMeMk8cY6CTwY8Zj8qRVHIyoZ+dvbeoTgjHiAAjNWM23IbX77c9Zph06GZcQS0FTlmheDQsyJSVe1tgg5rkDv613yxuBE3nhqXeOBCj2FntCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGbbhcTtSQxCbJONjRlcTeRM91XAQMjoA9GTdw2qxjc=;
 b=PBGUjtX5tHFPD2xBL4RXjdDCe4ZNa4Sr5Ouo3XehBU7Sdaw1kH+xBeg0OgvievrDZE0WyAeoD0cTL/Ne3mFhBcE0QXAvBx5mbCxYPSq26aDH2bleJz+Dgl/+E2ny5F3Xu1xL9tTh3WT0unick7CqScV0AANMnb3u78PBHYndGqhk7rVAu/oq1B9oh6xuazn4ueTcjQ3CQ3mHtqoQ4MMQ3Xp7vd5pi16Gb5Umvw9EjYSaz3WWoGW9EXnQMJdwvOXYU16vLBh5FzcL45C7toh8kClxJBtThVVhAMa8glC5wCci/kysPr26KwbusCuWz9IrjfKl95ZxKC4SCcmbaAulAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGbbhcTtSQxCbJONjRlcTeRM91XAQMjoA9GTdw2qxjc=;
 b=LuAiZgTofaNSp1FkzJVKEjToZAVxdAwh/lrgHIPeCsLZ35+9RHc6mmI6YbaVk5JacDjV7FwIO8m/b2Zg3NGg0AjmZi7J+HaQTK0/M/3U90AyaS8eUIImo3I+FGghHfr2sIbWDwPNCCCR+lI40PtfUF0i4OSeIyRad6dUPFLdq5LKN94vlZZLpIm92U6mirHbUg8UNTCvzkriQSjc3unTtgoa+lyRiDBN4+34+6adrVYAdHXKm2pzW3EILrBzbA1z6r9GEs+Nl/Mzzw7LyLn8BRQnldWKTRCEQ51+30q9K6G5nyqQQG3ggf9pE3ZPHdFQuuErNO/2/EX+2kB9+EbqKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB8033.apcprd03.prod.outlook.com (2603:1096:400:45a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 13 Mar
 2024 09:48:24 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b%4]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 09:48:24 +0000
Message-ID: <fcb8496c-665e-486d-8fc6-7a2b3e3f2d3c@amlogic.com>
Date: Wed, 13 Mar 2024 17:48:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: arm: amlogic: add A5 support
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-2-7f11df3a0896@amlogic.com>
 <CAFBinCCzmmVf+iyFkjNRmyyrjcuSS-s7qCYZMwwK0z-FnYMeqQ@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAFBinCCzmmVf+iyFkjNRmyyrjcuSS-s7qCYZMwwK0z-FnYMeqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b2c458-981e-4f4c-aedc-08dc4342b9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OfhG3vkiAX9iRjxWrlvz/yfvJyF+i5LyNXP4OFpFmGCMyc1cohSRVQJ2xfrVvhwO6AjvnEU+CldveXy1+87xJz8LFdRcx8xVVP11d3+ssqpjvAvthW5bzOT9PZ7Pt8RjW37vEraPNOHHUUkYn9j6Vvk9dYfQiDABHJABANTyo9bL1Tdlx3LkoBNIQP1S9zX9PtXoyxEVf6mkuuTmXu0CxFkc95TvQibb+z3ZemgXz3DVYew9lZRO9XSyDFNOo1u8fKo4pa31jk17472EoZ2uem5WBfzlsrrHiBx5h2yOdnfd+7r1litkALGzV7A1HFhceSMoIeehsq/tQp8f18NCivHK1i3dVy5wOophgfAE7qVylrJfCpew03Q9GLGHY7wTKGQKLALACkc11g+DBnBOgRG4PmtzqLS1Km5P+xIdDqsPyiasDXj3YFPO3IIfLOyp4/4Wu4OyWxSI7kTgEewc5Vuh/al+lL2AE4dQFtOf2FwsLzCdkIcqt6EGJrB6xyVwykn3HG2hCZhc9/s5yUr1Nsst6LpKZRZ8sk16RasKBMxoHV/u2qGKvM+Z7CgsGEiLzcWkcrPs3+rVLw4rNqIUqSeJolUUNYlXXDtEulTta0Z3HzFDA1fxjnbvKToHIYVx7mcJLRAIVNJOnFa2gU/WuiJsdBhVGENFOZ4W2PHxwHo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTRqNWpGZW03RW1mNUdCSnA5aDFlN2NFd2l1QmJZeU1jQm1aVC9zd2JZSFpl?=
 =?utf-8?B?bnZoVlVXbktRL3owZHBobzV6dy9ETjBpWW5pUlhaemdadm85aUk4aWd3d0hH?=
 =?utf-8?B?WUZ4R2U3d1c5N0pySEl4SXBHdWlqQ2daalJBQmZxakVaT294OVpoUkxtYk5U?=
 =?utf-8?B?SXllTFdjcGpDV3ZyYnlXSGlmd1ducklTWkxKRUhPSHNNU3RhbllreGVRSGxR?=
 =?utf-8?B?SzdiV3ovcWluS3VuYTNpOWFKcXdVNU5jcVVyOHNYQW1rL3cyUXRoTjZvWjJj?=
 =?utf-8?B?WG43dG5Ka3IyZFZZVjVWUVlWcnhaWFF5NS9XaWs1UE1Sb3ovaFFvVnhOdWFl?=
 =?utf-8?B?VGo2RnhxcWkvUzR2ZGxtTVdPOWwzZEpUSFozckkrSnBtM1d1MS90czZJaWVH?=
 =?utf-8?B?eCtRbVE0Q2J5SEdJb24zRlYvZXdrdWRlUUdyMktMdkVqWk9ySkdUa3BRSmQ3?=
 =?utf-8?B?ajB4QVQ4SU8xVzBCS3VoclpvY0lFM2xLK1cvdzFHL0wrN3lNM1pJTzRzV0FX?=
 =?utf-8?B?SlZvWnlEcUhrbmFQcXNGb2UzNmthTkhKRDFQT0VqQk1rd0hZTzUvNzZIWHRP?=
 =?utf-8?B?MWxqanF4YmtCZmFyNWx0YjhxbDlSRlczMXFidWpoYmFyckw4SE9QKzJrZEtB?=
 =?utf-8?B?aEtqUjlQemcyVzUwWEpJZnV4WlJDTFF4K1ZKUm9VdmpNMjBVN3FndkR5Smhq?=
 =?utf-8?B?SHROdGoxRVBpVTRESG9ML1doK1pWSExadjlEUHB6ekdMWEcvMXZCTTZaMURB?=
 =?utf-8?B?dVZPb0VOL3pXR2c4ZkVtaDZoRzcrTFI1Wi91d080MkxqWFNrU25wTkw4WmdK?=
 =?utf-8?B?dDcvZ1BwQTJsNENmR3VxeHVTUlBwbDVrTjhUUXJ4QjdzZzIvSGtWMWhwSW1H?=
 =?utf-8?B?azBGblh2SzNaL3UramRJOVRKL0dDck1zTlR0cnRKUmx4MzZra2ZaNVpZTzZY?=
 =?utf-8?B?YmdDMjVCVEs3NFVsclQrUm9DSU5qOVBxNHRoYnlpWXhXc3JvOExraHQxTjFE?=
 =?utf-8?B?TzNCMXcvYUExN1M5ZDBGRmZoci8xOTRGcURQUnVGTTlIUnJaNW11WVFydEIw?=
 =?utf-8?B?Q3JNM2dPV014RncvWFIyRXA4VkJKRDNaMHJNZUI1OHBTUldQTlhhbUNwVlpo?=
 =?utf-8?B?eTVmUEFLOTdWMjIxelJRS1I3Z2lqS3BiT1FVejlxNDR4WVVJQWtSSEFob2Zs?=
 =?utf-8?B?SWRyYmhYZjJjYnZwQU1FSDN3OFcwV280TjlOcEI4SHhQdHlrVlJzN0E2ZEFj?=
 =?utf-8?B?V2JON2tMUGFhUGc3NlZnSXFyOFNFdTVzR1VEeXh4K0ZGSktneXFhRldWbWJL?=
 =?utf-8?B?WnhhNlY2Z0lIRkRWQVp5Q0k1S2tFeDcwSDJjM000NEhlUk41SGZtWDFnZzFi?=
 =?utf-8?B?REk4ZUh4eWlIYzI3ZmlRdURybUxQcU9YUFJ2Vkl2UHVRTVNNY0R3YzN6Z0FN?=
 =?utf-8?B?VUVOMjBPRDBlZGw5YXJGcUs1K01Ga0lDMDRtaUhpanBJL0FLOWljSndBWnpt?=
 =?utf-8?B?cWg4OEJOemduZ2N5Ung5SDdTY0daclF0NkRYelhvTXhxcjlld2xqWTFDSUVR?=
 =?utf-8?B?R3ZZdGVuVlZ4TEphb0RoUjFrZzVOUnQ5Y2dwRUg5RXNFVytteUdzN3l1RnNx?=
 =?utf-8?B?U0NnSmYzZmV4UmYzMFVUK3dGR2FoNmJzdkRYL0h4QjRBMlFVQ0JHeE5JUmFj?=
 =?utf-8?B?bFZTR29ML3B1SEpGOWJ0QzVDL2s4YnhHeWFjTWNBT2RsUkY3TFRtcXN5K3dh?=
 =?utf-8?B?M244cFVDclltdjhWNUxocjJ5WUs1SzFwdDRSUW9Nc0lpMmFIMlpFMmN0M2J4?=
 =?utf-8?B?RVYvbzR2Z3ZyYll6WVVKSVNrSldid1ZHaGxzcmtvUCtDMlFqNHNpOHdqNENy?=
 =?utf-8?B?a2kzLzhVQmNSb2ZBc1p1d2o4cDNiQytnRUtsdjhKRVVzakZ2cDVZUnliVlkz?=
 =?utf-8?B?Yy9uczM1SWtsS3ZiWDEwTGJ2L2NGMU9OMkVaRzJOYkt0NmkyRjBTUEZueG1B?=
 =?utf-8?B?ZjZNcUd0Y1l4SnBDUmhhSXhnNTZTYlVnZXJIdG5HUXNYRnNvYXUxTGNLSFJa?=
 =?utf-8?B?Sm1VVHZzeU5lTFV4dExaVXowSEJsNlpLNlF4Wmh0Q3hSMXpVTzdCUHBSYWY5?=
 =?utf-8?B?QXFvN2FkM3hzbFpwd1UrOXN5eXVTUUVLdndjVnpjU2NNS3gxRkxxUnRmTEpS?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b2c458-981e-4f4c-aedc-08dc4342b9ff
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:48:24.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unrthVns/Q/S5a9KS95O0yNOHBdR9dh4HMe1Ifz0zUAs1E7LavR5ekgAWA9gokAy8hmSqc0zNF1uDhU3aruYSzjHCEH7rDfvCHBaHqgaa4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8033

Hi Martin,
      Thanks for your reply.

On 2024/3/13 01:21, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Mar 12, 2024 at 10:19 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> [...]
>> +      - description: Boards with the Amlogic A5 A113X2 SoC
>> +        items:
>> +          - enum:
>> +              - amlogic,av400
>> +              - amlogic,av409
> Similar question as for the A4 SoC: this series does not have a .dts
> for "amlogic,av409" - what's the plan with that board?
I will delete this strings.  I re-add it when I submit AV409 device tree.

