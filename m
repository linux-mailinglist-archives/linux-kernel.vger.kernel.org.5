Return-Path: <linux-kernel+bounces-71385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6685A470
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854C21C21B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31D43612E;
	Mon, 19 Feb 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CDffZrSR"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89036126;
	Mon, 19 Feb 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348321; cv=fail; b=VyssYNIIBeX+rR0IEpgabPNhBR88NyH9VFz980iVw9K+OFAIRVbZpyJ/cjBRmXAZK+30g0gRJX9wHa9Gr3vjRX1KZd+HObJH4+V0j6hQ43YeEJFDI6oB1iUQLPwJndy6CSRGABvjqnI0w7e99orTwQ9HwXb0yx1ueqO9lDsHrc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348321; c=relaxed/simple;
	bh=V5ccYzXEePFyBDZu4/Oo1xVocSy8SPunAMdN2V9J1bY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKoV0GWcjW2QB2AflnBG1WkE/CczMOCQOH/+YsXDYvlbXfQddYrq+xGM4E7clGzsWFZHBI4YdR8E6IRdF36EgAJiPts3AsgnMR+LLJq42G6CBXN0cwlpGuscW+m4p/sOA7hdVGtJwiiTZfCW3R9koWQOqGrsgFKu559UCy/+9Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CDffZrSR; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW6H16wgMxW0G2LppQuEM/lWLeUU5FwZVEvIBb43XjAkw+rvbc1+JMlXz3T2zazsZgi4xj5A4MWKGeKr0cyHd1F+kmgoxr5DjgR7z0cJ+LcNd2LudRcMXfEV3olEL39CoydAlKB1JyNYQGRAH+HPAeuI4XydIaGeUCGEV+NGx5E0CGi7vLZG4kMF/4e2DqUpmPir0bTSoq8AB3Ea+9MHHicHFMqUYb2xnUVAoPejoMS6tBzWijdezAbUlzgmg2J0CXieS8GrTG1hE1dhpGib4L+oaylLFzdBVSIz5edzskTC1wEF3JDV/BIlE5WBXf3VNsD9E7WZ+GkO2M2zn+gBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKwfb4jVizRQey2P4FwnKJVZoXIUOSf7O558LQ3c3/U=;
 b=m3nJYBAHmVEsmOq5Ka1nCicUQxXGKuKxxGi4qzTmZ6hlgDi3e2BmpNM+FYYKsrepfaNKh27H/m+9ul1nqitagOz1J2iLvRzJynw8gKS1cAidRA8/YhgmjMIWAHxtQYbEB2qwPGPXd9IWhUBjjLDkkNu/6diMTt8o/Y0Mmb2N17YGDZbGulCtI5+l28k7Ve3aIY7AXQ3DzvVH0bI6qcZL90J5Wg2PsYxBvNZ8mRg8Hd2nNdF7zBfgJ4gwevnxVFV49kGWlSA7jVwNXwIVEfhXVCEt9qPcqqPQvmgjn7YGwPV2PYSkQJeeym46OQYCgVd51ltqlc3pC4UeVltsuLJ8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKwfb4jVizRQey2P4FwnKJVZoXIUOSf7O558LQ3c3/U=;
 b=CDffZrSRzJAP6l6L27gs6u1rHTPXmgpOTGMmq4ElGn1OgCiqfbbJtjlm2fYCWMj1E7PTASD1NV0PWSeKm05z/34VAxtNojqACiTDkGULZVCzXwOBa2NAJqEnoPALfkilZ/Rii7zUdurD0SXk9+KQ++x0RXjaKXT4ISWmXSgTAxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 13:11:57 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 13:11:57 +0000
Message-ID: <96c0f613-7c53-4189-bfc8-7d572b308b9f@amd.com>
Date: Mon, 19 Feb 2024 14:11:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
References: <94726c90ff519185767475f672d70311472ea925.1708073513.git.michal.simek@amd.com>
 <5a81f16b-8ece-4263-b424-4dd6cd6e386f@linaro.org>
 <ed59671f-6e0b-45a2-bae7-38f7b4b7e625@amd.com>
 <ebcfd49d-f810-4d9b-8cba-b55071fc7fa6@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ebcfd49d-f810-4d9b-8cba-b55071fc7fa6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b31a17-9f71-4106-5757-08dc314c59ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FB8Q2/dsTTJAwhkfkb6kt2+9o7r/lf4hCD6C5YFlZIFfQXaWoQveI4Jip23SmdFDv2NJGKbXn8NxAYZrhHi2fee1s58qiFXhFztqDfmYCE4WDMXsQJGCygEuDgeOgCvB5oSJDUrPORHZQWIt9r5LDR6xQks05Vmy2c5iYvYqYLdcduO5tOAi4oL/ZGz2BTFKF0dd2vKzd/kJT9zaNgmb4v/O+woyNmwiI+MZ5Co3E3P8xHd8iJ9ijELBzzGGCBULl0d+vV9U3Uoc/qVnQEzweyCbWMWaOxAWrIMBsagndgZwMNAYQu4jKrSL7j2hgAB/0oFJJUDeoXsoViPuneCtZ6tey0sEp73sY2L0KCxGENk9gSYO1q5b7T9Bnu0kZiAR0+RhwjHVvVgjowXEKklqi1BCynXwcsqzEHfZsesZuO3aLgTrmHdpHGs0+C1pNLMzfs3aNFOCgRQyY/SKN/51UQ7+nXy899NDZpdnP6NiSqB+fd+oBQ3OFq0Syp/fnGRiBa4JX0H8eRyoz/arntnIzNvxfZVu86+h3xP1RjsuV78=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3NsVmZvR1Q1Z1NEd1Y4TEdtMTV1QXJWMUp2aWRHU2VhMHRwUUtwL2NrM3c2?=
 =?utf-8?B?UVVBQ0VVVlN2UHAxc3FlalF0aXVwUTBUa1hkbFh3Y3hCM3hIcDIwSlpvYmRx?=
 =?utf-8?B?TWhFaUlRZk4xKyt2UVhwQlpMbWRLQ3FLL2ZBaGFkOVlTcmw4N1Z1ME45ZGhk?=
 =?utf-8?B?b21TYTZEUXRkUHJ3NzlXRHBPc0J0L0F0THVOR3p5M2ZDM2plalh2L1Z0aG9a?=
 =?utf-8?B?OTVQNVpSN2ZSZC9NQUw5ZENOWlVROW90bEZCQ1U1alFlRTZoNHBpS0s3em9q?=
 =?utf-8?B?TGVBbE5aQlNOc1lnR0UwUVF1TS9oOGZBd1BzZEUvS1RCTUZOQUVBand6SkxR?=
 =?utf-8?B?SGVYYWwzT2ZnbDJiTjNBNThlY282TVhhcmJnQ1FieVJTTkRoSzZEd1plNzY5?=
 =?utf-8?B?Wk5iNEtrcHZsSVJXbnN3eGZZQWdHV3ZVeG1MdXR3VStNMm1BTkVmTjgvSUx3?=
 =?utf-8?B?NFN3ZGlVR3FTVWNaVHhWQzY4QjJZYS9MRWNyNjBhYk9CYUxpUmY5OExtaEpo?=
 =?utf-8?B?cm1KTW9aMFloSVMyMm9pRHZyQ3dPTVJYdDFYY0ttanJlblo0c0ExMkp4K2Za?=
 =?utf-8?B?L0JlbXFVZndFbUtwS3ZEZUF6emxpc0QwOGtWT1ZpMkR5UzhHZDdkNXBzYU9i?=
 =?utf-8?B?dHNjbzBqZEh2QVlnTmxsYlFtdFpwRkJYNG8xa0Y3aDV1Tng5YVROQ1N3RGJo?=
 =?utf-8?B?VnJ6L2R2OXBMQXkyQzk0Y0ZWT3N4V2w1TllwMG52Z0FYUXlKR01KZ2xpNlJl?=
 =?utf-8?B?Vm9aQStnbUpnWWRWZFNPVGQ4WGZLVitVNFlKbU1URTh0alNiM3R6YjkvVThq?=
 =?utf-8?B?ZDBjTGVWaXBHWU1OckM1Mk1xaWNhMUtyTnN2QmRrSEl1YnMxUCtBYktJMGda?=
 =?utf-8?B?R2hJamd6VWR4eHFsYzhnWVpXS1NFTWxFVXhoOW82Y3QrQU1qSjhLNEZJcGhE?=
 =?utf-8?B?K05uZlpDTGlIazB1eHFlc2N6b3Vvc0UyamhTV21MVkR4eU1Lb3B2Q3ZnOEgr?=
 =?utf-8?B?L1kvZW1QUE96WnVWcEx0VGY0Ym1URzlkOFpzNXJ6bzRuVXUzZzlnQ2xoQWND?=
 =?utf-8?B?RTFsUEV6RitnalliV2l5dUx6aHRwMjgxWGNXQnROUzM1VHppbFU1UkpvRkZC?=
 =?utf-8?B?WTdGV3BWUEMzWkdJWmFhV0JQQ1JMODErZzZiL3RHQ2NmZXQxNUl3UjNzQ3Aw?=
 =?utf-8?B?MERseWdXTDlpamJhMXFtKzQrNVo4UVdrU01PeHVBWGZ6UnEvYlJRYmw0ZHQx?=
 =?utf-8?B?aGNuZmc3WUNkbWIyYmRRb0xBczF3T2QybzdNZzc3d0hvaStXNnFDaTMxdCtX?=
 =?utf-8?B?OTh3YWRIODRoRHJMWTdNZHplSFlmMUllQUlsU2UvN0wySTRJR0hFNW92ZE5E?=
 =?utf-8?B?T25PK2o1Rnk4eXpHK1BkREZDSDJVdlV0Y015L0w1OFhOTU1CU2FTblJHNGtF?=
 =?utf-8?B?bWhVNVRqQkV5SCt4Q2dNM0dMNXNiV251UE95N3ZTeE9DMFJrR3VlR29ncFpt?=
 =?utf-8?B?cW5DSVBCOC9IeDRWNmE1S2lsWDc2SmtwWjRlM1E4c01GeWllVGFJL1VURTNy?=
 =?utf-8?B?THBpdkZWRHNsT0NvdjVEdE5RN2ZLZWxtdzVzNFo4K3BXOEh0T3FyOG1DdzZT?=
 =?utf-8?B?MVNoVVJwOEVudjhMOXMvRHhVcWVuanFSeU9qWURrcWFJZWNHRGhzWjZlTm1P?=
 =?utf-8?B?djd4S0VYNUF1RlZTTW1kdFlBbjZ2amFyYzZVVE5TelB5MzNZcU5aWlZJWG5J?=
 =?utf-8?B?MVVZRW8rZEFGZ2d5VTJnVkRXNUk3OUl0VGJDbE50d1pNK2dMaUV3ZE5zYmtI?=
 =?utf-8?B?aVVYc3BBTWluMTJCZGdrM0tTbGloOG1CU0kxSWJRY2xTNlJ6RnA1OVFpVU0y?=
 =?utf-8?B?Q0F0QnRINmxtQWRUamUzYk1idzZNZllZV25jQW9NTVJoMk9KbmdJMk16RHpR?=
 =?utf-8?B?SkZNanpUVjBOR3J4ems4emlMY1BKT3NyUTh5SyswS2xuSTdpZHlEVEhEdER2?=
 =?utf-8?B?cmpBSjRqQnRFcXowNjJvSEVuaFlCdHdEYWcxZ0dvUmpucWZVTkhURzNyelFK?=
 =?utf-8?B?em5QQXRtTkJndFYxWjNPa3dLOUczWDZCT0hoaUVVcW5YSm1iQUlrQ0Z1YmtU?=
 =?utf-8?Q?AoJjFT2XbDATHp07UDHgn8sQI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b31a17-9f71-4106-5757-08dc314c59ed
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:11:57.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsiklIb7iUMFxctsWh4fGHre4SA9ecZXmZkE1QObF0QUSj4VOV88WpY+WN85ssai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056



On 2/17/24 09:26, Krzysztof Kozlowski wrote:
> On 16/02/2024 10:42, Michal Simek wrote:
>>
>>
>> On 2/16/24 10:19, Krzysztof Kozlowski wrote:
>>> On 16/02/2024 09:51, Michal Simek wrote:
>>>> RTC has its own power domain on Xilinx Versal SOC that's why describe it as
>>>> optional property.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>    Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>
>>> But Versal is not described in this binding, is it? I see only one
>>> compatible.
>>
>> It is the same IP only as is on zynqmp with own power rail.
> 
> Then you should have separate compatible, because they are not
> identical. It would also allow you to narrow the domains to versal and
> also require it (on versal).

I can double check with HW guys but I am quite sure IP itself is exactly the 
same. What it is different is that there is own power domain to it (not shared 
one as is in zynqmp case).

Also Linux is non secure sw and if secure firmware won't allow to change setting 
of it it can't be required. I am just saying that Linux doesn't need to be owner 
of any power domain that's why it shouldn't be required property.

Thanks,
Michal

