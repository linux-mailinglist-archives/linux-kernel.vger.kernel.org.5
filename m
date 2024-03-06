Return-Path: <linux-kernel+bounces-93702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 531AD8733AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0BE5B2B251
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274176024A;
	Wed,  6 Mar 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mdghgIa6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813635EE84
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719503; cv=fail; b=pf+IcFopp+WmTntzNgE5OREy++l6IK5K2M5K/o0dS5F8OhG8e/gC4DEl8yzFMcwdD1qcUdLfurlWAcN6trEuMMMoMUQvrVe3SaQgR1csgp7FGm6fNlJbRIcEXve8RV+MswSgeuuAw21XwQZNbAwSsyLw9BgtsONA5kPr2U1CB7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719503; c=relaxed/simple;
	bh=Nn5Ij0wTr0Cw/W6vcpQ3ynSoaxfvxrR8wAnsap1iIkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MdfKs/8Q4zS4cExcUAYhsZtiepiEKKjK1vgP5QRBQ42q3I18HRQa3cDoRhC4z8LhhjqufyOXXE6fD5zzNlcBQ8vgY00+ydp+nlpJAh2FMNaCxMBuyAeSYWSsrfwATlzCnkW+bNJlSey9P2Or8HVEqXQFwysGmhbFE+Ba7TQ68OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mdghgIa6; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKu2TEskUimbcYSxh33Bzf7mEx0ByERjDxU465VAvtOM+r/lpDEI7my0FTrHg33df2KrNVB7l9bVZz60FOzEkjgxkPICpCqqn9R/1lAl7PquZa+hapMH14FAxEh0fb0h1H+A01qPjegNtGl2oYSNdMRoijyj/rl/V+IA1l7Zs2e7Ik8949W6RSx6+Eh0C+Nkg2Ln7O67w2byACjApOf4wZQ94xOb/kKjYxSiXxTGmfBqcQArCjQeZmmCdF6kDyhxD0iufE/2JVgvjeDWsu+fy8+aJxixcEstzWO1D3rk+7EVJSfG3jzxlNzE1vplaROR1HdWpG4Sz04dssB2GaLLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAtcgUa3V0EOz8Sj2482KMSFzI1qvxezCRaX688wXak=;
 b=WJVdtyEJ2K03abeExIkT1eehbY7sHVgoKNXUFJyeh30n7iqJlBaSvK+vRUR706khLIbU8Gg9rboYZwXs/igHOUFHtrzee05CcfsUmoNM3Ljussqu3u0Tu8BQKohtRa8lRrneinN7VO1QKz3UFSmU25vN8vbNQAC4OlfBjpR7ZuofICiJX72spctd3A/62y6VKPFZfmqJAlTkSddm3A6gOrZ8n5h0LN1OBHJlP91zsHXGYnhIk2LnIbJVI/a7reAGfOBTZmo3TVIYDnUaQ+wCzyqIYzAGR6UCiYIKAzWFmyaoC7Vyh6bjSPt6MTSoWew7GbYeQ+39Pm5zaqA+ndfS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAtcgUa3V0EOz8Sj2482KMSFzI1qvxezCRaX688wXak=;
 b=mdghgIa6oK1wY1Qk0/sWzkpu3DUXjDgkO+M/tiybI38vMSrLR6aTK+KLQJQAKBxGyUnA8JbImy34/d4VudOgH447f3Np3oJQqhYFBHjevW0YufdNC2h2fBhAeE6YCDQ5ft4XRW4tq9+zyFQua7YwSmSGCBWnsvCunMldQfabits=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 10:04:58 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb%5]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 10:04:58 +0000
Message-ID: <0914758f-f492-8cb5-2bd2-c13473c32e48@amd.com>
Date: Wed, 6 Mar 2024 15:34:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 00/14] Introducing TIF_NOTIFY_IPI flag
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ard Biesheuvel
 <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240220171457.703-1-kprateek.nayak@amd.com>
 <CACRpkdbxjU0r+PDTxJwrgzuJgaKnOCHtkaZtm4jO6bmFQ0SPiQ@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CACRpkdbxjU0r+PDTxJwrgzuJgaKnOCHtkaZtm4jO6bmFQ0SPiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: a13ce31f-4652-415f-4601-08dc3dc4e0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h5L/EeGNY0SgquOe2/NGYnnu3NiZv+pNwfmomTe5muH8J7PJjkgZfHfxigKaj4OnmapZ6ILdIGXGnfdVbgyWrcGhvmQz6xO+umLcN0l9dVYfUgOaCugzbOLWS7FQr68DEPwlRQsFVGgsE+aq/1m2h6zfv8SSD3dNMzhyNXl5DqTSAT5CM+40vO8dQHL1s/TM+mVnR4A6Ii4ZBqqc40UggsxuGUgg2V/02UCW88H+BVF3E3IUUrAONaivGIqVqy4/VXNeu1khymOGDJKxkhQEHuNMygnS8CZpJCOugFocLcso5Aqqrkt84U/Sxl6r2qvGx9NrT65GPN7n/g8ek0QywMCkaiy7030EKddBTn6W/LOb0IT8VW+CncNc9gFps9H03BjbqeWnqxfZ33jimPs+u0J290S39JZNWz+hZxoGpgXKmcJSMLxWasHrz6v5kJp5YR+O7EuxrdRHis2fHbZTI9RF7AMxPnZJMgBNaetAvkuWFdf6z2tttFxK6v6BvNX2dd+cJHodL6WfwafkooYmsrZDGwl7racZq1NcKQHYawCOz3ifsm0pXtiw00qu3OQCKenI182NKVbkuvCSV6M5dbbb2Db1ZPwdhrLruetA12jLQ06YdrHO6vpzIkqDwsFfzyfJ0yMMcw0s6fQc4eMfaG/8KAtZzFhxMVvUMzbVTOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHhDeHZWV2pyYy85bEFMc0hIZXJJQlRvNmw0cVQxb3N5NHhwV21jaFZWbE13?=
 =?utf-8?B?T0MrbTIvQ1A3SmJSR0NjenJ0MGd3TndlQys5N2dTNlhZUVlBcmFDMXdiL1pv?=
 =?utf-8?B?L2paMFJOODFxRkxnU2ljRkp3cHpWT1ZiVzV5aXlrc3RsZ2xmNmtsRExHMHR1?=
 =?utf-8?B?cUpWOFlycHl2MWcvRHFpMTdQUzUrdFo5V1NmOG5lMkFNenlQaFVkcEhDQjY1?=
 =?utf-8?B?TlVqTGN3QnJ4UnVOL0J3Vmo4N0Jzak1UbUVRaEl0UVN0VFIxM00xdW1aT21D?=
 =?utf-8?B?cjUva28wbTRpczI1ZUt3NzBDZis1dFFUMmJMaGwxRDk3SWF4ZlNDaW0rMkc2?=
 =?utf-8?B?SWJjSVdMakdFd0hwWGtIUGZsVXFOdkhrTTc2WG9qa05pREVkK3pRend6VFBw?=
 =?utf-8?B?THdadkVLM3lTcExhZW1ERE1XYjFEbE4vTDc0eDZCOVppS0NFYWJBcUtsVjVJ?=
 =?utf-8?B?OEFEc29TdE1zYlNJNiszcGR2ZWxSdHNyN3BjdmNOekZRblBYR3h1eExYaW9j?=
 =?utf-8?B?L1pKU1loQUFTZVlJeEFmMDlYU1UzelhPRmpaUHY0UTNhU2FMbjRObWlaN0Fj?=
 =?utf-8?B?UW15by9Wd3FFM0hING5mZWtucWlETitEUVJ6L0dHN3hlNVl1ZFh3aDRISlpX?=
 =?utf-8?B?VXFreUEyK2xlZjFpNTJlK1d3cUhhVTFCcUYwUFlZcDhTMllEamFqL3JMS2dY?=
 =?utf-8?B?QzZCYkNwOFBvbUp1eVRkUzNQOGhrVnFPbkg1MFRxdGxjNkFIa0djTndLN1lB?=
 =?utf-8?B?KzhYNkhRYlpiK2FoUFc1bmxYWlhNNW9PT3doYWlSOEFiWVFhbUtVWTFkSGF1?=
 =?utf-8?B?YTJaOFhNa2xoU29WalhxYXZ4cGNIVGoyZUhYbEd1NHpVblRwNDdTdllsR0FS?=
 =?utf-8?B?dlNhZ3VnQmZKVWxyckpSc2JXaGMvQklXRE52NWVHd0EyNlpkSjlTOG5oS0t0?=
 =?utf-8?B?Q2FBb2daM01nWG5LOHZjY2xiU01SaFZBTmF6aGZ6eVZvdHhFMTRXYXkraGM5?=
 =?utf-8?B?RlJFNEpJay9FbDhzM3JmdXJnZmNaSWZpcy9oanJ3djFGY2tHd1BPOXNUNWtq?=
 =?utf-8?B?YjJLemhhbFpuemFtbzVxN3ZIYUNsTzJ6Z3IrVktyNEFjck5ZWG9lRkFkRjBO?=
 =?utf-8?B?MFV5SVR4a25KZDk4WWtrc3VWR25MeDJXOHlZcUFpQmp4UlFGZ1BqUVVXaWdr?=
 =?utf-8?B?NmVXV0FzMy9yM3FESGh3U0RZS0hxYlJqc3NEVk5ySzNvVGdKRGtqN203VW5q?=
 =?utf-8?B?MnVsZDI1UEZHeWxaMkUvWGZYV1FrcUlNeitPa0xjb3JzZWE5N3FIUFFsSXpn?=
 =?utf-8?B?OEZGc0xveEE0bklMWXg0aDRkUTI4TnpPUjlYaE9RL1ZnNzFYR1ovK1AwTjZi?=
 =?utf-8?B?WjZyd0dGUVNCbHMyZUpaNDIxcUptQk1OcXpiMXRCdGRuK1JKMnJ4U1RKRHpu?=
 =?utf-8?B?SmluU1ExVTNJbGlTK1V6eHd2SGtPM2o5eHBydzFUMnU5WUl1eFNpS2w3a0sy?=
 =?utf-8?B?a1A0NlhyZjlMaVF6WVRUQS9FRmlRV0xUZzRCZm9tWjA0RUsrTG9UekVEa2Z0?=
 =?utf-8?B?Zlc3bTlOaktQZVRYZmpJSnFqbVUvZUtncmszQjY0YXgvcHVIQ3U0ZkFqSlhn?=
 =?utf-8?B?ZjRnOEZFQmxQSEZUNTVZS1NMc0pyd1FUTm4wdHYzTUFYSEpuWVZLUnpQSzky?=
 =?utf-8?B?NC9zMk5peEtlZnRLVkp1cy9iMnV1UUFxZVpmSEVna05lNTBFdTZjeHoxbHUx?=
 =?utf-8?B?ek0vMzUrQkJhM2hSRVlHVURqUXhrT2RVVEo5U1BXdFZyTUgzWHNwUzN0VkFp?=
 =?utf-8?B?Lzl3U2xpYnYrNzJ5ak43V1RGRGRuUmFqSWdtMCs4d1ZLTXkyRHVJZTZxcGJK?=
 =?utf-8?B?Z2dXTFpCRE8ya1FxTmhrNUtBWTN6SmFoZVgxVzFJM3hkYThIOHlFcnZtNzMx?=
 =?utf-8?B?djlpbUlEaTJ6WFJ4M244Q0pwdFhORlc4RXB6R1ExZG9uK3pOMU5sclRla2pu?=
 =?utf-8?B?ejVYUno3dlR4YitEbThzSmZLWGZ0UHFaYnE3SFlYWDQydXo4Vmd6VlVuYnFR?=
 =?utf-8?B?NTFRODZZTG5pd1ZyWkdmNjlpTlc3cDdtVi9SYStlNHVONXhpNjJ4ajczTEI3?=
 =?utf-8?Q?i1tiZPlZZV8vPpNvL6bCgHVEN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13ce31f-4652-415f-4601-08dc3dc4e0e5
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:04:57.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoaenpiviY9ISs5kmpAp9bmInGm08rkjZLa7jGvu6u4uMeMZ0U3J63t7NGSHJDkxZeSa8i09XahFZxJvwxVOaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672

Hello Linus,

Thank you for taking a look at the patch.

On 3/6/2024 3:14 PM, Linus Walleij wrote:
> Hi K Prateek,
> 
> I trimmed down the recipient list so we don't bounce.
> 
> On Tue, Feb 20, 2024 at 6:15 PM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> 
>> Same experiment was repeated on an dual socket ARM server (2 x 64C)
>> which too saw a significant improvement in the ipistorm performance:
>>
>>   ==================================================================
>>   Test          : ipistorm (modified)
>>   Units         : Normalized runtime
>>   Interpretation: Lower is better
>>   Statistic     : AMean
>>   ==================================================================
>>   kernel:                               time [pct imp]
>>   tip:sched/core                        1.00 [0.00]
>>   tip:sched/core + TIF_NOTIFY_IPI       0.41 [59.29]
> 
> Is that a 64bit ARM64 system or really an ARM 32-bit 64-core system?
> 
> I'm confused because:
> 
>> K Prateek Nayak (10):
>>   arm/thread_info: Introduce TIF_NOTIFY_IPI flag
> 
> There is no arm64 patch in the patch series.

When I started out, assumed both arm32 and arm64 shared the same
thread_info file. I basically ran:

	$ grep -r "TIF_POLLING_NRFLAG" arch/arm*
	arch/arm/include/asm/thread_info.h: *  TIF_POLLING_NRFLAG       - true if poll_idle() is polling TIF_NEED_RESCHED

and reached here but now I see "arch/arm64/include/asm/thread_info.h".
The machine I tested on was "aarch64" and was listed "Neoverse-N1" as
the "Model name" when running lscpu. This series changes some behavior
around IPI delivery to an idle thread but without "TIF_POLLING_NRFLAG"
defined, the behavior should remain same. I have limited access to the
server I tested on. Let me see if I can get some cycles to test this
once again.

> 
> I can perhaps test the patches on an ARM32 system but all I have is dualcore
> I think.
> 
> Yours,
> Linus Walleij

--
Thanks and Regards,
Prateek

