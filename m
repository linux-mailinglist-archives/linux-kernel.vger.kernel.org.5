Return-Path: <linux-kernel+bounces-77049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B44860079
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B54B1F2729C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD17157E81;
	Thu, 22 Feb 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=outlook.com header.i=@outlook.com header.b="XVaQf4JL"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2096.outbound.protection.outlook.com [40.92.53.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9E156990;
	Thu, 22 Feb 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625344; cv=fail; b=qKRC299Wd8iyoyZbEyZz5LeY37HUW3JD6heJmBsdxs5PnfXYnygUAIOGv3VQiHwQxpJkVHoeHQ409IcHuV/8VesHn6yLkmcF0pf2yh1wqPexncQ5/N7oIY4wLaGGFVX+aJhl0qhfxejpP34o50Ay+RHvWfD22kiWsBnYXB7uS7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625344; c=relaxed/simple;
	bh=QwVNwoarxerJ/qp2mz5yvIEaIn7n2MI9NtUG4z5nxX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ibsUYxkjOUeUBduc6c5VlNG0fdCkx+7OkL0rrlbbnbusdVJR77vFwfcvOwiZUOWdF+eJTGWizm67jNc7p+gRJGScn0ocHj8SYqHtpxKzGdOCHenX2gZ3QG3I/bY5XxGf5G+GdRg0I6RM/bRidF52ud1nLhvwUPL7AoGF67id8UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XVaQf4JL; arc=fail smtp.client-ip=40.92.53.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DskNr/R/YBFv9JJTLWpTvhNVbE4/1ugKobczZAebEq9T5gHxElBiZl2x9tQQecFok7jq5wI5Io1gzUPfpXc9tT9mKzvv1HoyYHwOhupM7EaxX5NPWmhG7VQLrHIxkBFy6mJ4YLCbEsnHvC+7d7KHcwHFso7GxANk/u3h/0tXz+PV6plyixJT4lgtSF2DYBCu+BgUfe69Vi4D90xfrX1ikqdAgm+cIprzeq/6VR4ocUZdu8owNyotyCVbXeHjd4LITp4QQNob9+kGvlEmLCm88GDcJv8jon4n+mwKDnAUEkR4uu0xsSGNsLV5BoybDxnZ1Sm/sXqBlf56FcU9gWSAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boik0WYb3eCdF+R+n+9/8j3cvtIlbPgnQMv587RCwPA=;
 b=cHhSwA2UmkSgMGBj836yQBFivr9bWb0+oTFnAQl87+rvSaqxGOOJ+4nHt23efMJ7btKjw5eacLP9ztLhGr0pDUubJ2yrSTdzdExP8VvwY6hgtpfL7BxT/ylsGP5fOeEXdwRzGsbaS7agB029dgNQPsI28Yp2E3Z+WcP+/5cByQltAVlHfQvRlsToh6mdLoui+Xjzk3J1kCFRF5NtzM+sz77dPcm3f/GWcDQ/DpwkevTK3InOtXKp/RvFfUpvj9G3rfIS8eMKcSrhcLPWlulb1x/z9pEz4bya6uWo1/3wTHyBiulYaRx9ufjEDAqFkq194cZnBL6qpyHKTsMHyI6/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boik0WYb3eCdF+R+n+9/8j3cvtIlbPgnQMv587RCwPA=;
 b=XVaQf4JLnF8d3Hb299exyckDivHIHY1nyYJkA5Jra0I7aHiWqq+kLP5FstFBx2YBQWiTI9BTxjOKvBmQEdKGczM4Yq161uZ7pQcWQ1/ghzusaMpxCQbjqb+8VgCkoESySgjekY3LO3pTZAvsDk8HTO55GLQtVpba0ZphUsNbllvU0txYcG6eB8SwiCy1ZKpwttzMzwIJNj4nfRvYDGUbtekASu8KHd3ZKaG3BYPIYAU9dgCHY08Z5PfvXb+s3/sqSbZc8am4XIX86HFiw75KQG92H0kFmAuMGS58kxuenVf2RuWk2x9FW8/HxkLTT1Ql3je3oaIvRTOmvUg9TfAsIQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5522.apcprd06.prod.outlook.com (2603:1096:101:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 18:08:58 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 18:08:58 +0000
Message-ID:
 <SEZPR06MB695945A0BC315187BCF3284496562@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 23 Feb 2024 02:08:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: convert hisi-crg.txt to YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
 <20240222-clk-mv200-v3-1-f30795b50318@outlook.com>
 <f6dd8194-979a-4409-a300-f1eccba7fce7@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <f6dd8194-979a-4409-a300-f1eccba7fce7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [OWRQxBZapP99VmD6duG+Q0JowEu8ab6z4KaGGCYqb8n7vRzHHFy+/Z5kRQEzLx0lO+bz30zRby8=]
X-ClientProxiedBy: TYCP286CA0177.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <b20cb3e8-77b7-4c93-a9b3-526e5e8923b3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: 478bad72-e558-4a9d-cbb5-08dc33d1557f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HnVE/3ReiuzVQbdpf8ylzR2+8SLHg9LwgActPz6j0/Td0WMfrZ7M0l2yEeITDDI/G0644s6pERJryAk07bMTdqbhvGV0BoTddzyAscPWO+jGYpnXVw4+ANYYztBB6pb0rikGHek6EUFXtL9NsX6TLLA+jkeWQgYqv/828TjC59pUCSA4E8vuYglI78P+F3+Itmptw6TEJEmShw00bjrRsMIbNNOGsYu0nWFXVYf7GnY+FX+Qhzb/G+sSscBvEDDelXi/DqdMPeEiOoQikMwzhPG2iUdji8qgPXXyde7+67PDQ5zpR1+VIs4HVYru6EnOSoxlm1DpMqzMMhn5oEtyIFLnvuijtzD+RFNk01PWpHXE6NlAqd8bdjDik1tVLJnhLuUnWlwnYxraQPqbnXvTWKV+s06UE0U2nhIiOZfjAdFB9P2MPXYOMCnEltpE7uIg6peJ1bvdymk1o8tkp11u5KRZNK1uIB89j4mZ24cF0loOl9wsnqHNqcJ9a2KVa4DY4+9jJxLwX5djCdDpq1veatkDlhCw6Zu5/dHU/yhYgna0Ii8IqFUznGwVrkXp84Ez
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzAvZzFJa1ptM1FjNm9FWnl2ZFdLNFBnMjJ1QnBLcmt4NGt6YzJISjVreWM4?=
 =?utf-8?B?NkxLV2ZvZkhzODFEbXJleGxEMjZvKzZiM1FRUWJEa3hra3FXdW1VMW1heWNl?=
 =?utf-8?B?ZG1WWHNmWi9BTXBYTFFEQ203T0FHWmU5RU9CeklFSnY1Q00xb3htb2N2d2oz?=
 =?utf-8?B?ZDd0Z1M1eFExMEZodFErcEN5RXFuYTNsWUtXdFVlWVpYMnpSSVpRS2tXZ1ZO?=
 =?utf-8?B?Y0pVSzZEdmlEUnRKaXFoZ0VzWERUK2svc3JnanFablRoRjZ6c00xWFFzdU1X?=
 =?utf-8?B?YUNyRDZaV3lqcDlwZ0RCLzE2RGQzUjVBRGJOMzlndUNWcmprb1RaRWljQkF3?=
 =?utf-8?B?YTlRdFN5eGFYeUhQTDN1cVQ0QWE2VFdRcG9pVEc2dnBPTWdZWmN6Tmc5elVv?=
 =?utf-8?B?bHdrOEVsRlpLL3d1bTBVdGdNbldZdDIxVUFTeVZScUwzMTgyRGNnUXViejNV?=
 =?utf-8?B?Sks2SVlDdVVuSHdpS2JLc0JFcVZYQkhqYURZYjNvVjRYcm5meWp4S0pyZEZJ?=
 =?utf-8?B?aUFlQmczZEZRb1VIckpiVFR0S1Ixb1RTaTlvcU5TTUl2NGRUSy9vRE8yRkll?=
 =?utf-8?B?LzV6VGZjQm05YlVicW5wandSaU1tTHovNXdhUzJNUGxWTDZabEtCZGdCMjNQ?=
 =?utf-8?B?NjB5UGJHRFJLZ2VVbGdYbXFZc3luMTBtcjQ1SDRUc0Fhc0pwbTluS0xoMXZF?=
 =?utf-8?B?V3RmMVZxaTNWTVp6bENhaXI0cUM2RTc0RlVJRVdsRHZ4bUhEdEJwYnN5Zkox?=
 =?utf-8?B?VTVxeU5GK0RxLytqKzlJV3d0aUQ0eGFzSnhtUHVWdmxtSVlPYlFBZlpDNk1z?=
 =?utf-8?B?R3JTZU5yLzFaU3RRNUVrNTVHZWhPMGkyZFdKWUJzNkRZU1hPb2JwYVRzY0to?=
 =?utf-8?B?cmJINzNKZkh4K0hXc3pZQTROYzRvNXlrd1JNMTRYOURsWDlUYlhlRDNCcVIw?=
 =?utf-8?B?MUNvT2QzM3VLT2todThQOGt2dHpUMFFVckxicU9pMzRhUjVOWC9ndjcrZGwr?=
 =?utf-8?B?QlpZRGNtbEJZaG42U3k5VVBDTUlkRVRDYlZZMG1Wbk1zaDhaSldzRndQZDJ0?=
 =?utf-8?B?L3IxUkZrK0FhaEpZUnhSZmJpSTdOVzdjTXpuTWdveXNyYkdYN09aVi9aRnZ2?=
 =?utf-8?B?ekI2bkVEeHlpdWFJTzFUMFVEZ0dLbmFTY1g3SXVPV3pORkhkQStZa2Qxa3hm?=
 =?utf-8?B?ZlZTRXlRUitMdkhoQTQxdHYzS1RxSWNJT1RUSjFTRVRLcTg3eXRVajJRM0ZR?=
 =?utf-8?B?ODNCcGFxY2tFUWFKL1RBR0NDR0MvNUxPSmpUV1c5b1Jhc0I3Zy9KSTV0bnlR?=
 =?utf-8?B?SEFOcFE0cVIzTGJnK29PU2pVU0prb2pIRFp0allCZUwyZjEwMzUxb05xS3Nz?=
 =?utf-8?B?QStVempWZXBsaTIydE9GMi9IcmQybG0rb1JkRm8rVmUyZHJVbkZBaDlvZzBD?=
 =?utf-8?B?d3JoZFM3T1h4RkJ4S0dldExuWEZVVFdCVWx4Njdubno3b3ZrN0FuNnRhejNi?=
 =?utf-8?B?MVlqZEp1dzlmT1FCayt1UGh3WGpvZ05Gam4yMGtvNTVmSjJTZURJNnl1VHdJ?=
 =?utf-8?B?ZFhKeTdMODJJZURzVEdXUUpXT3VQZkk4MEtOQWVpL3FYL0VJRVNNWUlMT1BH?=
 =?utf-8?B?MlZGckcreC9ZVGJsdml3NkpUMi93UzF3c3NvdkQrdGR4MENKU0JXT3VPWklh?=
 =?utf-8?B?SjZBbzU4WWZmVmRCL1l4dTI2V2FVY25oVjNwekFRM3RkaytWQWxScC9sRHYv?=
 =?utf-8?Q?stRBPBDK3AAw7SrDqpl91Hxz3KJN4fnEkEJJ++R?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478bad72-e558-4a9d-cbb5-08dc33d1557f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 18:08:56.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5522

On 2/23/2024 2:06 AM, Krzysztof Kozlowski wrote:
> On 21/02/2024 17:41, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Also rename to hisilicon,hisi-crg.yaml. While at it, add "syscon" and
>> "simple-mfd" compatibles to match the existing dts.
>>
>> Add reset-controller subnode for hisilicon,hi3798cv200-crg to match the
>> existing hi3798cv200.dtsi.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../bindings/clock/hisilicon,hisi-crg.yaml         | 69 ++++++++++++++++++++++
> I don't see any conversion here.


Ah. It looks like i did something wrong during rebasing. Will be more 
careful the next time.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


