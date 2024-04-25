Return-Path: <linux-kernel+bounces-157944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C31A8B190E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D02128500C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6951772F;
	Thu, 25 Apr 2024 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T5cgjZod"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71D4C7B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714013709; cv=fail; b=jYyTVqRRFnViIfQDM59uiMTCIA14KmquGow0gr1tSvo+OgCZyFKgUxTM+MTZ27sJ8r6Ct0URhEt/h+Lhs6/D13jn777g9owkWYjoEQeR2eq4UOof3VMrzPT+XI8EaIN4MxUDAbnM8RyWSyfbYbbP1UQbj28CVpR6yQ83kDWp4DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714013709; c=relaxed/simple;
	bh=wxXZLgzYkOYTdfM1eEdfgT18AFFxubXbhBMx9B4Moec=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=FfoYBcwvzjqtmtEPFz0gd/svMaG9jewPWCXdcmI/1/gMFoERhkGQUZhkxYhwnT+dK3HwlzVaR9QNiQgF05EV79godzeTXQaagxG+eyKXTfsZY38THPO7c1U4bTkigeTlFxR7eeypYWnFei8wvSNtxxKZO7ajO75OQzplvVddEWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T5cgjZod; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1bJ4UlMw9L8LLm6y+jfZw+VGYU2zsWOICsXMtgkFKM58vP33Y4KdZel8oHSCYhQ2q3iPZlV86Y85RPbK9OVXaBwZEchFOrECt1GGNOYMlym1eMNEWI8gXkbSR4TICC/mfr2MX8PkaEnYLFzJtpxTlymuhPH5a+BDoOoslPUtPeGFUAOqJ3HCTW2S8Jww1zxoHCcQtaxyKXW5bLsPtAXH48k7p3ggsblY/+Px1Q7Ryj5p6j303vmTC6VoR56+/Ld/uISZOtMjauwOg91ZCqFPJVUmLcDUFEsUu0vNrp0xo3CicMwOUQUlUvwD8S4Uq9Nr0w5du5pyxfKvjLkWu9vOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsP1L379sxrWUlbqyOvqhmMu/9Lh6jOq/LoemlrRA5c=;
 b=QTWBImBWcxCCBiwjzjy2Am6LkS1WFEhEVnuRS2T2fBdhKGd8iEMJnVD69bNTfUf8KPo0TX5lKIzC+f9xxC7Tgad/JobRWxg/lFc20+O93xNwUuKLVk+mxBjacLOZ4LXRIFjxlx2Z+wBVZF/elGt1HSo+1MscXzJkG+ZbThuaLjON3m7Eb6UOB3uBNs0vIjbejw9Ab/YqrrMYlPYuKqR5DGMeglBPsNNB6qtusVrNQ09hnwtb0YGzk5IQyK85wwrDeVRth/bKCOZhDSI8kCVXtGj6hk9/q0XBOM+QQEUaCWtwuNHYJJZpTfhOv1DWzouqhogrxObTy0lN2Yk72L+aOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsP1L379sxrWUlbqyOvqhmMu/9Lh6jOq/LoemlrRA5c=;
 b=T5cgjZodo1aifFkl3fYbe5+YJbNyJst4asWybDZBH7TsQgyd+EthFgWL/Gg8X95p8JqKwTiqRPotMyWlXFadkehKsca/ktgs0XvkUo/PuNHHumsMv3qvXnp1x/gK9QrCewaoJ0rv6RsevngZthdaK5Kq4/9NFXPKEZhAH8C+s2xXJHoMe8RdwmyM4Z+BGTYLapk/yJO/oBHSrGCwFyeDwa+ErR/3Ri/D8TkDYM56eN2XLvYt0GTbuaJmmDxrPWuXZhM7wvgch8XcVp16PpR5fo4UPQ61ROtEAALO17xHLqKq+2gLpKd+h+4U2UtCYD38bfNMU/bzJOE0zI0ue7a8vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6411.apcprd06.prod.outlook.com (2603:1096:400:42a::11)
 by KL1PR06MB6448.apcprd06.prod.outlook.com (2603:1096:820:f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 02:55:00 +0000
Received: from TYSPR06MB6411.apcprd06.prod.outlook.com
 ([fe80::af33:ff9c:cf31:45e9]) by TYSPR06MB6411.apcprd06.prod.outlook.com
 ([fe80::af33:ff9c:cf31:45e9%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 02:55:00 +0000
Message-ID: <a1698611-f386-4974-9cbd-a270fb417af2@vivo.com>
Date: Thu, 25 Apr 2024 10:54:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dm: Avoid sending redundant empty flush bios to the
 same block device
Content-Language: en-US
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>
References: <20240422100540.2213-1-yang.yang@vivo.com>
From: YangYang <yang.yang@vivo.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev
In-Reply-To: <20240422100540.2213-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To TYSPR06MB6411.apcprd06.prod.outlook.com
 (2603:1096:400:42a::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6411:EE_|KL1PR06MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: cd02010e-2051-4157-53ed-08dc64d3190d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUp4VXJwQk12bGJTN1paRGFJWUJJVGR5WG1KQktlS09ycFQybE56bk9FVjRm?=
 =?utf-8?B?am0xbHlnTXNLQUROY0VONitjS0tyRHpZK01MMHhGbVl1cEx5ajh5MHRZL0xP?=
 =?utf-8?B?Nm1uc0g5MkkzazdaMWNCQ2xPSWo2WnNDVDdZRmszNDM0TWJIZUI3aFplcmMz?=
 =?utf-8?B?cjA4YjBVRklkOW03WERCTXR3S0xGNUhQNWdKTGJHMGNnYzlTNUZpeFhtVTlO?=
 =?utf-8?B?Z3pldm9oQ3dyNzJxSHJROEV0Q2RsaW1RNENXbG5mM2Fndm5PbUlRdGo2c2px?=
 =?utf-8?B?Z3c0T1VkR0FnWmYvVWI2NDVZQ1RrZXk3UWRiL1VrNWd3QW9USWM0N1hyb3JT?=
 =?utf-8?B?cytlQnBKYWl5N3ZRcGZqbFlNRklFTDh4TitQVGcvSFduNEtCckJvdjVtd1J6?=
 =?utf-8?B?WUFMa1ZEK3NuSEZLRGYwMWlYaVFlWVRLTUZZOWtueVhZWWppZkluMkFvWGNV?=
 =?utf-8?B?Qmx6WVlUaXQwMXpVaisvN2JGbGE1dERhNUh1cThiYjlGWm5sM2NjdmtrMndH?=
 =?utf-8?B?YUlVcGxtSW5uTmFnR3NTM2NlK1paREh6bGpTekRmWnRHdERFWWpBTnhLWWNo?=
 =?utf-8?B?NGhJakZEeC9iK2xTK21jWE1UbXVSYUZ6SmNielRIVWNTdUl2OVVyV0ZkLzN6?=
 =?utf-8?B?bm4rOGVGbzgzSDlzeWVKNjZhRTdCa3ZzMHJXaisrN0NzY2tVaVdNVFRNTVVY?=
 =?utf-8?B?eC9jMVIzTHN5MEhQUCt1NTFRcVVlRTdpTWgzTFlRQXBKNTZ5SFkxd3ZVQlpX?=
 =?utf-8?B?REY3VzgzVHFWTjdCZXFxS3JQZEdXSXRCSHFpWjcxdDF4UjhtUkk2NVhqc1ov?=
 =?utf-8?B?aVpTalNvVzR3c1RtWjJjQ2tGcHhKTGU0VU53TGlPa2tqS2w1YTQzUDVhMWUw?=
 =?utf-8?B?U2tDbHgwaVpiRWl5RDNWMVNOZFM4dzdoSmhQUkY5b0hTeE0zdnZkSGtRMlRC?=
 =?utf-8?B?MU45aEc0d2JnSEZBbWhPeHI1NjdJUWpHbmhSMDV0b01xa3pLTmFLVGtEZ2JV?=
 =?utf-8?B?SndpVHExNDBWN0ZpY21HUXBIdS9Jd1Q5UnNFL0hyNDJnendCSFJqTURyakow?=
 =?utf-8?B?TERiMTBDZCtZeExhaXhpM3RkUUdQYThTeE85V1VVbXBkL0d5UGo2NmlrU25K?=
 =?utf-8?B?dSt5a29HZmhyZFU5V3oyb0NCeFdXNEpZYkpNNGl1MUFBYit3UjZVMmFMeXNu?=
 =?utf-8?B?bW4yWnVOK2JsbXVqSEpUb0V0YmpiUG04WWF4NXVQSHpZaWsva2cvdGFKV004?=
 =?utf-8?B?b2N0dHlQVFFadjU2VGNpL2lLMVRTMzJvRjU0N0txUllFWStLNkx6QjQrZEdZ?=
 =?utf-8?B?U2h2azlWWXc5WEd3MW92Z3c4dElDSFd5aVNZVFFaNW9ncnd6bm1iQnRnSXZH?=
 =?utf-8?B?Vi8xZWxiUTAzeE9lWHVLQlZZSzIzT1JNVlZkZWdsOXdoU1d2YjB1Yys2dXYy?=
 =?utf-8?B?dERYT1M1MFpmWmhPRlRDNG5ZUmZXdStWTzFKTnQ4QWRMOEZKbzBaNGZRZ0pQ?=
 =?utf-8?B?L1FnNkg3anpFWGFtbnlsRWU4YXlGRWpaaFlISVA4bk40ZWs0ZEJUSmUwSU05?=
 =?utf-8?B?QU5mNnB5YkV0bTV3UFRaQWc1Q1IrK0JyVC9zdkNpd2FxUXEwOXdiTCtpeTRS?=
 =?utf-8?B?T3llRUNoYlh3UEZLbFdQVElIcUpCOW1BRmJoQjRDMHY5R3Z1SisxVmVhUlAw?=
 =?utf-8?B?OXYvaWxaMlU4OGk5SGtyVnlhOVptNnFGOFNJYVNBN0VnR2IrU0NIcElRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6411.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UERSRU8xU2RKUWNBbTRCb1AwSXBQbmpkbkV6TXZCWlMyVUsrWUhkQXZvR053?=
 =?utf-8?B?ZFJ3dkxWbEtPUFJXdTFGbHNwTDZjOWFQMUJTQVVML1cvQmIzaUQ0RmM5b0wv?=
 =?utf-8?B?WjlYRFBYSytQRTZlT05QRTZmNk9tQnFYazd6czA0WjNjQ2xDVDNGS20xY0Yy?=
 =?utf-8?B?OFhibkRFcklmaUFqeEJLWThVOEwyMVZSZU1yVzdqYm1yb0NtWXp3YncyZWU4?=
 =?utf-8?B?Qm4yeFlSaGhtMnpCRG9hdHNzcGZOMGNvbzJNdk9SMWRhd3BlUmVXMHFGaGFz?=
 =?utf-8?B?NDNPZ1FudFR2eWljV0UzbjZRMlhJajczNGIySHNmaGtMdVJaNThkaStNQzZj?=
 =?utf-8?B?cmo4UXMzK0UzMzh1L0hUUjVCWURhaUpVRUI5VjRRaGNwLzR6MnFPMTFLbW5q?=
 =?utf-8?B?cDl1ODhyQkFiTE05ZlV0Vzk1N2hrUnp0UFB6Zis3dnAyQWIzcVg2K1dmOHY4?=
 =?utf-8?B?ODVQbEIzSjc2Z2NPU0ZhR1BRUVA1c01EMWJpOGo4b21WUUEyaGsyQmhYa2RY?=
 =?utf-8?B?b3RxTHVyTnlzVmhhTEVaZmY3K1NGK2R2NkM4M0JmaUtsWG12eUNGVGxEdmdY?=
 =?utf-8?B?bUQ1eDVvZEZjY1pnRFBqSGxteld1THkzNDFFVWJUbCt4Vk5XRVV3TzhQalNY?=
 =?utf-8?B?ZWwxbCtjSEp4UUZXZmh0RHlleGtwM0FqaUwzZkU3OUllV1g1MmNoV2laejVz?=
 =?utf-8?B?VnpRcUVFOHpYQ1d5L0h3L0NJdnU4REV6UEZEMUhmUUV4NVZPcktBWEtTb3Rv?=
 =?utf-8?B?VjJDY21HSlVZV0Y1d3FMZ2dKZm5kRVBUdmtXVUlHMzFuRGxCblMzSVh6dlZw?=
 =?utf-8?B?ZTRqREZsN1VUcmdRZTlMUzBzeENTeHYwMzZsM0hsQlFiRkt5RWp2U3VwSzFF?=
 =?utf-8?B?aVJJVzVNVmVFQUQ0TDlob3orZXZTN21uS2J5UG1XVnRjU3NnVUpjTHJRWkxB?=
 =?utf-8?B?STc1UFdVUXlqR3FHYlRLRmx0dzNtYlRzYUNSeWQzZmdOQ3k4VVpFZTk1Ylk5?=
 =?utf-8?B?cUQrdjRxMzBZNktNdHNnYkRPVU1XdDV1WWE4Yit0OTU0ZVl5emlTeXZESktk?=
 =?utf-8?B?STlmRXhCQndUbmRxcjJFc0ZpaldNa2twaTZ1ckgrRHYydEpwSm16WkFJOUt4?=
 =?utf-8?B?bTNxeWFaY0Z5QnpRamY3NjhhYXJ4V01ORVQzcllURnJZUnVmaDZjVFAwVmkz?=
 =?utf-8?B?NTArVFgybkNKY0ZHbnUyTE9pdFVyNkRKYzQ3VVB2TEc1ZFl6OVYvekNqemMz?=
 =?utf-8?B?bEMvVFN5b3QzTEdhV3BaSXVCZzlWUHZaMGpxcFhLU1dKUFJBc21pSVFqa1hq?=
 =?utf-8?B?azlIQUI2WnN1SVNBMjE1b2lnYzFka3ptVTF5a3pwSkJrODJ5YWt0YmFPcGdw?=
 =?utf-8?B?Z0V5aUp1NklLWlI1WFVya0tueisvOFpCR0d2cXl3MTlsN3ROUkMxQ0RRTzZF?=
 =?utf-8?B?UnNuVVQ5NzJTUHU0Rit1SHJPbjE1Vkc1RFZVWEZFT0tDMXloZEFOOEhDY2s3?=
 =?utf-8?B?dzJNekxVek5jZHdEalEvMEZJcWQvcUlwZTY2aUlWcDN3WFI0dkRVTngrVkxw?=
 =?utf-8?B?anlHSGtTUVdWaHozRGVSMlJRWXV0V3JhUGY2OTB6dWVCSXBDcVVZWkM0VDJ2?=
 =?utf-8?B?d25HRG1VU2dSbW5ITU1VRUltdzJyWVBIbDJ0UUtPTHVWS2loclRNWWlITmdC?=
 =?utf-8?B?T2lXVU9qVFBudlN2Nk5aL0x4NlFJRThja1RVNElyVjhFNFFmNG9Xb3p5QXRB?=
 =?utf-8?B?UWZWd3h0TS8yYWs4UzJwdUNkZkk1c0hhbWtRdEVPemVRdDRyb3krQUJVa0w4?=
 =?utf-8?B?RXhjblVnaTJ2aTR5Mnk2enc3b1pnbVp3ZGU1SkhLeHVJL0NYYXJHTTF0SUVX?=
 =?utf-8?B?RFBzb3FhSzBpSU9ybUllN240NUpnUlRNVHVUZ0orK0M1dTFmeW81ZU9kQjB4?=
 =?utf-8?B?bHVzVjNBZWIyczRUdVJNUFdtY2pEaHY5TWlMcTAzKzRic3dVa2hnbjRUb0Ft?=
 =?utf-8?B?VklBY3VHR2xZek9wNzk2eHo0eXF5dXpyU3R6UVgxOGNnM0lad1o1Yk9ydFN2?=
 =?utf-8?B?M0t0UitCZ1ZzT2tjenZRWVN1WVdVVHM5TE9mWTg3VzNkWDlOb2FQSExtZzhH?=
 =?utf-8?Q?pKDc1m5YTZ7doK/JsvDp5I/nW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd02010e-2051-4157-53ed-08dc64d3190d
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6411.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 02:55:00.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0YF86YfjSxs7HqSsRHAo60gT04443IwuBySOPzEkJjEbXJvJmTd4JOIQelkiedOw2EV5WdK1fP+udDVrRK7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6448

On 2024/4/22 18:05, Yang Yang wrote:
> __send_empty_flush() sends empty flush bios to every target in the
> dm_table. However, if the num_targets exceeds the number of block
> devices in the dm_table's device list, it could lead to multiple
> invocations of __send_duplicate_bios() for the same block device.
> Typically, a single thread sending numerous empty flush bios to one
> block device is redundant, as these bios are likely to be merged by the
> flush state machine. In scenarios where num_targets significantly
> outweighs the number of block devices, such behavior may result in a
> noteworthy decrease in performance.
> 
> This issue can be reproduced using this command line:
>    for i in {0..1023}; do
>      echo $((8000*$i)) 8000 linear /dev/sda2 $((16384*$i))
>    done | dmsetup create example
> 
> With this fix, a random write with fsync workload executed with the
> following fio command:
> 
>    fio --group_reporting --name=benchmark --filename=/dev/mapper/example \
>        --ioengine=sync --invalidate=1 --numjobs=16 --rw=randwrite \
>        --blocksize=4k --size=2G --time_based --runtime=30 --fdatasync=1
> 
> results in an increase from 857 KB/s to 30.8 MB/s of the write
> throughput (3580% increase).
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>   drivers/md/dm-core.h          |  1 +
>   drivers/md/dm-table.c         |  7 +++++
>   drivers/md/dm.c               | 59 +++++++++++++++++++++++++++++++++++
>   include/linux/device-mapper.h |  6 ++++
>   4 files changed, 73 insertions(+)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index e6757a30dcca..7e3f2168289f 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -217,6 +217,7 @@ struct dm_table {
>   	/* a list of devices used by this table */
>   	struct list_head devices;
>   	struct rw_semaphore devices_lock;
> +	unsigned short num_devices;
>   
>   	/* events get handed up using this callback */
>   	void (*event_fn)(void *data);
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 41f1d731ae5a..ddc60e498afb 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -2133,6 +2133,8 @@ void dm_table_postsuspend_targets(struct dm_table *t)
>   
>   int dm_table_resume_targets(struct dm_table *t)
>   {
> +	struct list_head *devices = dm_table_get_devices(t);
> +	struct dm_dev_internal *dd;
>   	unsigned int i;
>   	int r = 0;
>   
> @@ -2159,6 +2161,11 @@ int dm_table_resume_targets(struct dm_table *t)
>   			ti->type->resume(ti);
>   	}
>   
> +	t->num_devices = 0;
> +
> +	list_for_each_entry(dd, devices, list)
> +		dd->dm_dev->index = ++(t->num_devices);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 56aa2a8b9d71..7297235291f6 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -48,6 +48,8 @@
>    */
>   #define REQ_DM_POLL_LIST	REQ_DRV
>   
> +#define DM_MAX_TABLE_DEVICES	1024
> +
>   static const char *_name = DM_NAME;
>   
>   static unsigned int major;
> @@ -1543,10 +1545,38 @@ static unsigned int __send_duplicate_bios(struct clone_info *ci, struct dm_targe
>   	return ret;
>   }
>   
> +static inline bool has_redundant_flush(struct dm_table *t,
> +		unsigned long **bitmap)
> +{
> +	if (t->num_devices < t->num_targets) {
> +		/* Add a limit here to prevent excessive memory usage for bitmaps */
> +		if (t->num_devices >= DM_MAX_TABLE_DEVICES)
> +			return false;
> +
> +		/* dm_dev's index starts from 1, so need plus 1 here */
> +		*bitmap = bitmap_zalloc(t->num_devices + 1, GFP_KERNEL);
> +		if (*bitmap)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int dm_get_dev_index(struct dm_target *ti, struct dm_dev *dev,
> +				     sector_t start, sector_t len, void *data)
> +{
> +	unsigned short *index = data;
> +	*index = dev->index;
> +	return 0;
> +}
> +
>   static void __send_empty_flush(struct clone_info *ci)
>   {
>   	struct dm_table *t = ci->map;
>   	struct bio flush_bio;
> +	unsigned long *handled_map;
> +	unsigned int nr_handled = 0;
> +	bool check = has_redundant_flush(t, &handled_map);
>   
>   	/*
>   	 * Use an on-stack bio for this, it's safe since we don't
> @@ -1562,17 +1592,46 @@ static void __send_empty_flush(struct clone_info *ci)
>   
>   	for (unsigned int i = 0; i < t->num_targets; i++) {
>   		unsigned int bios;
> +		unsigned short index = 0;
>   		struct dm_target *ti = dm_table_get_target(t, i);
>   
>   		if (unlikely(ti->num_flush_bios == 0))
>   			continue;
>   
> +		/*
> +		 * If the num_targets is greater than the number of block devices
> +		 * in the dm_table's devices list, __send_empty_flush() might
> +		 * invoke __send_duplicate_bios() multiple times for the same
> +		 * block device. This could lead to a substantial decrease in
> +		 * performance when num_targets significantly exceeds the number
> +		 * of block devices.
> +		 * Ensure that __send_duplicate_bios() is only called once for
> +		 * each block device.
> +		 */
> +		if (check) {
> +			if (nr_handled == t->num_devices)
> +				break;
> +
> +			if (ti->type->iterate_devices)
> +				ti->type->iterate_devices(ti, dm_get_dev_index, &index);
> +
> +			if (index > 0) {
> +				if (__test_and_set_bit(index, handled_map))
> +					continue;
> +				else
> +					nr_handled++;
> +			}
> +		}
> +
>   		atomic_add(ti->num_flush_bios, &ci->io->io_count);
>   		bios = __send_duplicate_bios(ci, ti, ti->num_flush_bios,
>   					     NULL, GFP_NOWAIT);
>   		atomic_sub(ti->num_flush_bios - bios, &ci->io->io_count);
>   	}
>   
> +	if (check)
> +		bitmap_free(handled_map);
> +
>   	/*
>   	 * alloc_io() takes one extra reference for submission, so the
>   	 * reference won't reach 0 without the following subtraction
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 82b2195efaca..4a54b4f0a609 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -169,6 +169,12 @@ struct dm_dev {
>   	struct dax_device *dax_dev;
>   	blk_mode_t mode;
>   	char name[16];
> +
> +	/*
> +	 * sequential number for each dm_dev in dm_table's devices list,
> +	 * start from 1
> +	 */
> +	unsigned short index;
>   };
>   
>   /*

Hello experts,
Any comments are welcome!

Thanks

