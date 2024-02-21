Return-Path: <linux-kernel+bounces-74692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACC85D7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34DA1C21A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DE50272;
	Wed, 21 Feb 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rhIPI/tJ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC844F8A2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518237; cv=fail; b=nPLJ+09ibRO4ZTtHDzzVDDvnLqR1di6VEwrCeLbzLN+vHoXNTGDnY2KdJFIzSix5DoqX2is1sujlXfOPhh2LxYbW4KGmwKCK94pSiD1oJYtoa9zQ9EcR43fxASD6Bu6UDU9ls4F0ynTeBdIqdLnbsDGlwuvfxvLNmno4ShB2Kb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518237; c=relaxed/simple;
	bh=8GXz2/DYKt/6L82cjr1821MUEBItcfNkKV1Smvf7h2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K6Iie4Do+2Xip2ZsdSqZYZnIkDhlADWjJC1XLSfXPodEOg2w9Yh/Q1US1REIlucAgJQXRv+8rn0JOtyoR4Z9kej2HbeS+TrDsEufbGwDhHJnU76hwVY+D0q3TfbbR4b+g4kA2wLPmh6dEH3D/sJb+AQSyS4wHAkDIibLKHyEa3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rhIPI/tJ; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyenvw7QtnZn5jxy72kH0iBd79fkKPoz1L9Yypl8TfBx5aE2FXxDsFHnEyQMHb6r1k2OMN7oZYuH3GeaziIUOGlgSqfmTJfyp1XqeQAHGrTH4fHnKXJl5Ot3ysyLG9QydmyLtHVCsEatxIXTI+HFxajOTBvwauNWGLckSPZrFQxT2Uk+yrY28YBYRgPlvookGFWlBrbw1i/WV7CaI1ocq/spw7Q45k9U6JtmUldhEPBfeCP3a/ExFOu6uFcXjAS+I1FLrBydOvGYokeHTTHK5VChLgMFnZJnVFxfrrpNExSKH8fgWQsHSzqJhk8GCPvONM1IXUHUst2MV2K5mRFA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRW3fMOS0J2VabwNHm4N2AeHEOZ6f+RjBztYabrBEbw=;
 b=ZmrkJzZnxDP44mKbgiOHArjw5u1BAUQKP8a5Ki9JZ1oE3cFKp0hdABzEFXO/JpHzscQqQbsWpDjx1D8tdRwWilg4rd/XimBT3vXdXu6Rvy2PWZP/Vb8TakNSaLYQ3FPRQPPNx8mWSJZ4Faz+8rAP4P8qOSTqsU0r0k03/iItNxY1p60P8uEZKT+/EdAejJwO/EjUVhukyMfszf+GgSMwn8H26mmMMxTI6NYGl5rDFz1gNReJxtozUuvVXQ2Xng2AyUq9mN4yyIPk3Uo6di3qX8QoKOP7KEbnK/vYTGuX5DdGTVrwz0LIK0eo0GPazzKumRJg6k+3GvwFrsMd8OpJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRW3fMOS0J2VabwNHm4N2AeHEOZ6f+RjBztYabrBEbw=;
 b=rhIPI/tJ91o0mkKg0rokwFJY6cuXCzkBzbCV+DDxOo9ndrIQZx/IpjBnVMpyI/7Da9ea61ngw6wjMrv0zwkKQ6RnT6cILv/UEMPEKIff1Z5DPPrXQlm4+9fxvxaVylzlP6d95QaafphcjaoIOqNGo9Dzm70yd0FJKXim6OzsyGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 12:23:53 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::7bca:b335:5e25:753a]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::7bca:b335:5e25:753a%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 12:23:53 +0000
Message-ID: <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com>
Date: Wed, 21 Feb 2024 17:53:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
 paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::20) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 093da4f9-4c06-4979-52d5-08dc32d7f73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uIcG9xu5RZN5BTjMTtXy0zGQOFuBq05Q9f9YR9IftUlHofNr9i6NRMDqcbRZ9mkLWvlxOZEIHc0S/jHhBBBQ3ayA/XOCQdoYfdims8p4L3aXC7dbrnhiAa8JbBhOUrWBDSODSQ8MfTlcoIjBXR8BGLE32fsoMZo0sBvyunfRRxAq4VHWayPO+fl4V2/hbwTIN64RXMd1RJBV7x78S/e8RIjfp3xMCBaTPQOas8tpn4TGIbgb3Y0tykvx1FUQcMtefUcZpq6gT4TOBg2hg/fgbMvFafIk6QdsSEkBzFvkgZ9mDpQAzAexEyW8d9pnBPpb8mj/pc+BroybyW295wxB3LfbTmlTbvHKNtKgqTFOuqU8Hh/qI9Wm7VmX/nRMaWesqXywi4YHn6TmIEU/Jor0kujGeoKv3eRUcLL+eVHfqBr0EBnzUU5aybUOk5kXJ8IAEXDvwNYBV4EmkgdqTz/qG88VrSscoZsQvsZaGk8X+j2wUr7HYUG61wRi0+x46LUGq9P8jhvZFWkbDcnPfQrTvM1LcNVZPgQ/rUAJUATpvIE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm56Y3pycFk2NFY0NjNTaXpvRWo5YURuUFFxRm9tVWZqZ3ZiWXkzaDdlV2Fq?=
 =?utf-8?B?cEZiRXlONHZBYTYwcFp4eGp1a2xjcVA0NFV4TGNoZENORUpvT0pYbXVsbG5Z?=
 =?utf-8?B?d1pvbGlFTGpYUUxHcjJhclpXWGhtRTBIeDYxUTc4ZlE1N244N3kxb042OGZX?=
 =?utf-8?B?WmJjVHFBcTZKMkVJV3NRdEZqYUVQV3pKUHR5aU1NOUlzSEZ4TGhqYXU1NmFl?=
 =?utf-8?B?K2VUQ0dEdkFacW42d0s5clB2YXIxL3Vid2VlMkRPcDlQTHNEc08vM1hpK0FZ?=
 =?utf-8?B?c0V3YUJsTFVYMVBUcUdCSndNYXBTYnFwVENBTE15VGYxSitjaUN1aUxpSStD?=
 =?utf-8?B?WUdZajlBbFF3Ulk2Y0dvSWR4V0xWUkIrLys5Z1p0My81YUtaY1hXSVlUOVFU?=
 =?utf-8?B?OVpRblo2Y1lSNXE0TVNQRTFJbmJJdWZCNzRrcDQ1UnJQdndUYy82Uld6ck1U?=
 =?utf-8?B?OHFoUFFSMjFMZDNONU4rSTF2WURURTYyQ2pYL1dEaUwvckxHbHVnbURlMVFk?=
 =?utf-8?B?eGFNUDk3UzZGYVNrNklZeEt2SG9kNlRldWVPMVluQ2dFbDRRQ1RhVnZyUWlE?=
 =?utf-8?B?bnZTYnNkM2ZXaFVRYWFic2wrMW82MXNZcmVyT0FYY2IrRE5qQWJZOEhkQjNj?=
 =?utf-8?B?ZCtGdGU3UlVLc0ZJYzdzc3VwbTVraTFHREtyYXplYkJNc3Q1YWtVSXpGSHhv?=
 =?utf-8?B?bnNrQUhjVk5pVElWL3pYRkx3MDhHMkdyYUY0NjVuUkhIVllISXVMMEluK1JU?=
 =?utf-8?B?QlpzL2pQUW9wL3p2Y2FKNUNVYmxQc0hYbkQ5L2xHM1JxaUdvdHNUVXFRM081?=
 =?utf-8?B?c2FrcVRGMllVbDlEenZzUm5UL0RCVnNTaklZRVhMNmRFRHJRcDRnTUxtR3Vj?=
 =?utf-8?B?Qkh0RExJcXZTbkEzU015R0ZkbkpzaWN0WmlrK3d4Y3Y3cHNKNmhJTHlYcEpT?=
 =?utf-8?B?Rkc2WG5CSkhqZFRJTWVwUkFENVVsY1E0NzhQUFZqR04rK1NJSG91ME43MzZJ?=
 =?utf-8?B?YjhyemFjc0ZJalNvazF0U1hnUVBXYWJtb2Z6VkVmY2NJTW5IRThMRm1xZTd5?=
 =?utf-8?B?aVZIUkdEY0pqOXBIZ011L25rUkNoMVN4b3NYc2V0U2tvZlBxTXdRZnZKOElF?=
 =?utf-8?B?N0dBbG0vRkJRaHJBVllRWk11dzhUeG5tcWkvMjFQTzBWekRXOGIwYlhTazN1?=
 =?utf-8?B?bXFaZ0l0aGhHNUdLUmZ0aGFrd0k3QlYvRnh6a0NNd0hmUHNDUGtRb3lZbjhP?=
 =?utf-8?B?bXlXcVJPMDBzeE5peTJmYUJTUDRGTEZiMWsyeWVRNlVLVUpNNU0xSmd4TG1j?=
 =?utf-8?B?aFVwOHYwWHgzVmJQQll2cXZGcXlqRkFFU0hKQVEwU0JMSEwxcVR5a3lCMlRv?=
 =?utf-8?B?T2txZkxYVUkzNTBTNzZIbENOYksrU0FZSUw0YVliYzVMenhQd0dmQ2lpNFp5?=
 =?utf-8?B?bWVYTTIyTmtKbVF1YlVaQnpVSUpmV0xtbDFXZGxBSW9tMWlnYlRaYXZtWUJI?=
 =?utf-8?B?QXhVRWo0elBpT0N1Z05lbHpaRlpmNUY2ay85QlJRVitQNVlvYkppVmpqTll4?=
 =?utf-8?B?MnAraVVWcXkyVS9PYlNYNWVGRVBkeUFiR2RLWDFxaFFwRklDVklYSG5jalhQ?=
 =?utf-8?B?aGxIRzAwcjJ0anZOeW9lZEt1a3RtUFVyQngwTkNIb29vcEFmclBENTAzRFFH?=
 =?utf-8?B?amVsYmRjM2dxS2hCakFrUUdKSzFNRFlMa2haSHE2WGE4dWxWU0o2MmViaVkz?=
 =?utf-8?B?b0xQQmFYYTBVRS80ZTNlWm1JSTJMQ29MV1JsMnZ2b0MwUTdPaGc3MmU0VWFE?=
 =?utf-8?B?WnM0QjZvNnBid2ZrYmQzdHBZOW5PZGFCNGRCb3ZpNWZzZW9XZHFIaGpJeDg1?=
 =?utf-8?B?RnIvZk9NbENmZ0kvRGRlY1RTN1pYWktnQXNpeE1vRFVMUjZEWUw2Z2orN241?=
 =?utf-8?B?UTl6QUI3alBLNURsdkNza0VVS0JGNjVyVkU2MktFU0Q3OGhOTUZNcWN4MUIv?=
 =?utf-8?B?Y1FFZWV3U2NNR0VRUCtKV2NtTm9PMFRDRHpkWWJkdUE4bWt0eEhXWEFWbUpM?=
 =?utf-8?B?d2p2NXJPSHRvNHM5UmNWTEYwTnpqZWJzTCtNV1BWd3BKdTZUR0o3Wk02N0pF?=
 =?utf-8?Q?ooidDILMOd6m+4QWpkbak0/wy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093da4f9-4c06-4979-52d5-08dc32d7f73e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 12:23:52.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DVX4bE6b/1aXbzwiTcSUXm4NXGX4tkNYToQXt98zta45bWytWfVS/Wt7I0fUCQUZdalduFVQLHDWWQTSKIjqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528

On 2/13/2024 11:25 AM, Ankur Arora wrote:
> Hi,
> 
> This series adds a new scheduling model PREEMPT_AUTO, which like
> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> on explicit preemption points for the voluntary models.
> 
> The series is based on Thomas' original proposal which he outlined
> in [1], [2] and in his PoC [3].
> 
> An earlier RFC version is at [4].
> 

[...]

Hello Ankur,
Thank you for the series. Just giving a crisp summary since I am
expecting a respin of patchseries with minor changes suggested by
Thomas, Mark and a fix by Paul. and looking forward to test that.

I was able to test the current patchset rather in a different way.

On Milan, (2 node, 256 cpu,  512GB RAM), Did my regular benchmark
testing, to see if there are any surprises.

Will do more detailed testing/analysis w/ some of the scheduler specific
tests also after your respin.

Configuration tested.
a) Base kernel (6.7),
b) patched with PREEMPT_AUTO voluntary preemption.
c) patched with PREEMPT_DYNAMIC voluntary preemption.

Workloads I tested and their %gain,
                    case b                   case c
NAS                +2.7                    +1.9
Hashjoin,          +0			     +0
Graph500,  	   -6 			     +0
XSBench		   +1.7			     +0

Did kernbench etc test from Mel's mmtests suite also. Did not notice
much difference.

In summary benchmarks are mostly on positive side.

Thanks and Regards
- Raghu

