Return-Path: <linux-kernel+bounces-76558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0785F91E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17422824B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848C383B4;
	Thu, 22 Feb 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MP/9C6cW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315712F393
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607094; cv=fail; b=N/CdvocwJo6gSnhipGBemZRBvZX4skX5S6R61tCh5O7iwEmsguWt/fEiOToVDUjaVpnZPKyBTrNrLbmqpIOeDpSTkk4qUtAc9sSXPAnqZNbI1uRXu97Wt0ZN69JMa+cv9+sHS7fED+UiZQeMhGnLVpoFozqmDq0jnXxAY5+SrYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607094; c=relaxed/simple;
	bh=i1zbKlgO8N8rMXznwACbnAI1ko1/gGfWw/AHggurSxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqU8VXNvfFes4guDSQrsiu5Wt9CyWqxoAn5z/rGZu0+QOfas1YmtAe+x1ca8u0CJyMiwc0EoA73l4xiRH+Uixanv0KMthkE56tBczkQh+xRBEe+9wiBKmkDBTcrodozZyokZDhyctm+Y5GAKS76lTXB1Aah/84Nvn/7jsDMVA4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MP/9C6cW; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/NAiHCdMtp1kMhQx5p/peDLNPgBPKdqSY2XHh1Z6Ngf93Mst/kIdyjddQUMicnKXAzEojWPTMWGbH07weTtw55uDblSBXiDwymIW6/nS6iIKMhprNCi+MaYpr2XUwnkl+OvdykhJvICEksy8UheYOvWHzuqRlCkOKYjN/Q0hNm9z/Y0JseZx4t6EfgiTqP1WD8Y0wN9Arm6g5Z2Mrcc09Fv/iIG06NKCrL9z4L0B8JTD5R56YQyo9LBjma4pRmNs+aHycmV7QwG09FAyEA40ZVyD4AVbTu3eaepGpQSrlAGjAtpzyVDjqGBpRwKBsmrHGx/XIw6DjPjwN/0RzxoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFD1GqkWVjHDu1+TMbphdEVgxZUxgbbQMjnlzfdPtKM=;
 b=FdGeFLcon6qv4RxQYtPKqkjUwyX8noHWV4bi85yQHK6Gk6mFnlHWC/Lq18dTgxjH3vhkhTTa5EOgUKfuEKHyao5bocSObY2+Xj4RcFD4dCQ70J1Iwk0bWNS0KB0kBG9Rkoo6AYyQjR25l2YhZwbGye4sqnNlNXOg2kVrZudlYWcXZLWGbxkUpmqQN+onu9buiavY86NR7bc1dgb2rCHdxP9paU2ffhAZEnntVHsOWouW8BKsHAlByNO82VuswwzWOTEI3Uhqpp5EQgY9uIZu/9nlV+1Bkq2aGAnJUC1IMozmRjfxdIu5h7+S3nz4xdOqGXalVS7ABJc5FcV7/7xFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFD1GqkWVjHDu1+TMbphdEVgxZUxgbbQMjnlzfdPtKM=;
 b=MP/9C6cWMKCByxi0JIOxlyUTTxxCuXxYuPhpR2wtcbL/YfvvnowYq/+uZwukJGC4kDb6wAJXQLx2pjdTL25uVLl9GVCEEDbUz7zZuYj2YKKdmhKULv3Q4ZNeJW0ZYIz72vuKJnvftyb6HrEmEA6ZovsjySWVJ5UNoO1XnqwF/PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 13:04:49 +0000
Received: from BL1PR12MB5804.namprd12.prod.outlook.com
 ([fe80::10d6:cc0d:b80d:a53d]) by BL1PR12MB5804.namprd12.prod.outlook.com
 ([fe80::10d6:cc0d:b80d:a53d%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 13:04:48 +0000
Message-ID: <af122806-8325-4302-991f-9c0dc1857bfe@amd.com>
Date: Thu, 22 Feb 2024 18:34:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
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
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com> <87zfvtg2mh.ffs@tglx>
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <87zfvtg2mh.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To BL1PR12MB5804.namprd12.prod.outlook.com
 (2603:10b6:208:394::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5804:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: c88c4c3c-bcd4-494c-ed71-08dc33a6d970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NB2PtxkGgwFQMCgQkEQlOzCOzE7+uL4RBwaklGhMba4nzzQ77zR0Ssy92+oLhKhe8aYjZ9rjBqzF0BWA2+QZuYgQop3jqlAcgRegckZjDVAySRpr6SEMB4dRtN6uJ4135cdaCguPeU22krMlZKBWpfAPbNQoBTDszd6sB5Wksgh7WoxJzSqN0XtTtU+IGjhPrCZvV/XDtAEFxWPuOex3aW68RVH9XEG9ioYo4TkWrawmnPfHIF3urH2yZJCWAd7ftjC/xGn2rpa+I5nflNl2TXvm+VaNGx0qWetxZGjN8uKZHJHs6HMsbMuLkPa/YQoiU90E2nOUk3f4TzhBrcPcwH5r9a76YU7KGiohDqH9d3aKWqp0k/HVQlgrt/hi60cWKDRo0zmDKB4s2Eiatomx06Ungbo+4PGaIf6OYl39YaqRiEnDc7QRdUIQMKdfkyf1Fe78fxVzixuWnKeEBrLovfaBysrsnUeecEzdYRGbFlkdbCWDuBfLBeMO7liPn7QJ19ja4KDCmAX6sKL5bt9fyAu1fpD9oLufZ/g9lA6xri0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGFaVm9wd0FOdGRFQUpKdzV5c1FxaGRMZXZBS0xEVTN3emZncXB4elpoU3N1?=
 =?utf-8?B?RFNhZTc1YlRUUTV4cThmVUNvZSswVnlQU0dTbWtzNlZ6QzduZytBN3dDT0NO?=
 =?utf-8?B?Q2NwZm1iUlN2QnBQL0hrcmp6cVJnZHVzck5OZUFxZXM2eENtZmM2djFNdUhz?=
 =?utf-8?B?dGpVYVcwNXdPU01DQktQY2liVElKREpuTXY0bUhNUTIrV3hqYURaV2tDRkt5?=
 =?utf-8?B?SjdNNTFhMGlJOUxHYnc4YzRhNlFFZWlSMVlEcjRBNHRKZ0JWZjlOTFhBaE15?=
 =?utf-8?B?b0tmMkhrR3NYU3VhMkx0V1ZWK0JUYkNDclcwbjlCWDVidGVqejhSWnZTUWRW?=
 =?utf-8?B?N3lCSVFWRFoyc3Vud0R5MjdQbUtFcVRlaWVNeU8zbkRxQVVXWjF4aTN2Nlpa?=
 =?utf-8?B?L1k2Rk9UUnRERTZPN0VnZi9nNXdFcnhRc2pNaG5IRHo4L0N1UUtkYjJ4ZXJ5?=
 =?utf-8?B?cmhwV3c5VFJLejFCT2czeUFjUW9hRkdsZzBZMnJBZnFxRk1QeXY0aCtyekRw?=
 =?utf-8?B?N1pCMTQxUUVHY21LQTVsR2hqazNlQ051dnJ0ZkUxSkpGbStoUnlDZ1dieXdm?=
 =?utf-8?B?cTlrQk5rYURaQ1loVGVZTnZpY1ZqUDNYMTg1Qy8vdDd6a2t1UW14L2M0dU9i?=
 =?utf-8?B?ZDdnKzR3VUI3L0o3Z0lkL1pEMHAyWTBTVGhFcjEzNURacm1GWjk4cWJsVURk?=
 =?utf-8?B?NTArMjhkaVBsWWw5WDBicEtlWERXTisvV3U4ZHBoSVJKaFd4WGxRakhSK0ZD?=
 =?utf-8?B?bGtZdFB6REFDYmRSV21LaXFpSWgrbTVMQjFHUXdqRVU4ak5pbktMU1RDcTIw?=
 =?utf-8?B?Z1pkaWdERmRJcXlPamRBVDFYZ3pTVjRzNVMraUg2cHVkSnlXeVJCT3VuckNY?=
 =?utf-8?B?SWpGaFk3MEpqNk5qZ2cyanpocjN3d2dCMThHNStyY0lTMFNTWHRyTDBjUXBr?=
 =?utf-8?B?OStWRTUzLzlNUlZZMlF5cFhWK2RDWGwyNGhrQUl0K3FzSFhLMUFmOGM5WnZX?=
 =?utf-8?B?RG9wUFBzN2VRblNOdHc0UENXbVdNQjVYOHdNV05KOVpoYVhJRkpQcE1vdi93?=
 =?utf-8?B?OWJ2cVFzQzJvOVREZW9HTmd4S05qc3Aya21GMkFhYTArYWJpTXNubXpCVXBY?=
 =?utf-8?B?N1o5R0EvWC9HVEllSzRlc0tQcTdUeDhtVVJJajFOenFOV1JhS1h4aWcraDRr?=
 =?utf-8?B?bjkwcWhsV01NekNqSFZnODFydU9wS0NvYmZLRFgzc1FIM0pQWlV2WnZGQXV3?=
 =?utf-8?B?aEVUcnBFWUI5ME5lUldpbVVXdDA3ZUkyZWtnckx3b204OUtQT0Z3TStqT1Vr?=
 =?utf-8?B?YXJpMWdVODVSMEYvc1ZDYk00eFNNMFI5Q0gzVEEvQXpGL0VSQ25VNVd4aDBj?=
 =?utf-8?B?L1NzS3gyNCs3Q0lHM0d1ZEJ5a1BYVWJiZVRmT2NSRGR0cGxGbnRLa0VudVJP?=
 =?utf-8?B?T2hyTHB0UXVUR0pnQm9VVGZEc05NWjU2blVUVVErWUZLMGhVZkdwNzJEeU9u?=
 =?utf-8?B?ZUNQNEpobU8rUTVobUhYRXNZOWZLZm9hZTJ0ODhRS1N4Q1VUQWtvbEYxM09s?=
 =?utf-8?B?WjVFTkh2UWVSc2F5dVVUQldObWdSVTQrdjMvL3VUbFp4cS9JMG9MWlJkS0gv?=
 =?utf-8?B?a1ZvOXgreVV1NGJ6dGlDb0hLSkxrMTJnU0VMa2ZjUkNMMnI5Z0RGeEJJdFpZ?=
 =?utf-8?B?TjhDRmVPNm9tSjhpVFpHRHBmekU2a29lTnZLYnVXUHc1R0xWb3hDcjdSVnR5?=
 =?utf-8?B?YkRsMXp1NFE2eHNrVUtLdUtDU3FXKzQxWVZZckdVb3IwTS9oeTIvQXdVdVl6?=
 =?utf-8?B?YjFhS3lYeHJwU21LQjUzRmRESzkrSVMrSk5jWHRkazRWdDJ1MC8ySllzeVV5?=
 =?utf-8?B?NTlhZ3hKYU1sOE56NHJGZjREQ2xtRXRFUWVYcUJQN0JtODIwQnBVV0YxVmha?=
 =?utf-8?B?aW9ZK0JwUnhub3MzZy9sVHVzZWF2S1ZHempHYklsbEdEblh6V1NUVE5pKzhN?=
 =?utf-8?B?bEJ2MW9GUWpvMEpORVFDeTUvUGt2TitWZnIvTHA2WW8wRTZJdFRaeitkQzN4?=
 =?utf-8?B?OWJnMXZzTS8vbThDZVpRSXdPWG9LZkYra09LeGw3OHdHYVkxSFZFd014S3Rr?=
 =?utf-8?Q?qKgFwcyX9mSa6JRAqvyY9G6uZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88c4c3c-bcd4-494c-ed71-08dc33a6d970
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:04:48.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ORhka9QyBCpQ64Duwhv5JtyFAnxvGbudcg6Ybl2lVjtArRQWiioKk2qD2T6E5dlUBgSOtvad0Aglsqd9gEr/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788

On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>> Configuration tested.
>> a) Base kernel (6.7),
> 
> Which scheduling model is the baseline using?
> 
>> b) patched with PREEMPT_AUTO voluntary preemption.
>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>>
>> Workloads I tested and their %gain,
>>                      case b                   case c
>> NAS                +2.7                    +1.9
>> Hashjoin,          +0			     +0
>> XSBench	     +1.7		     +0
>> Graph500,  	     -6 		     +0
> 
> The Graph500 stands out. Needs some analysis.
> 

Hello Thomas, Ankur,

Because of high stdev I saw with the runs for Graph500, continued to 
take results with more iterations.

Here is the result. It does not look like there is a concern here.

(you can see the *min* side of preempt-auto case which could have got 
the negative result in the analysis, But I should have posted stdev 
along with that. Sorry for not being louder there.).

Overall this looks good. some time better but all within noise level.

Benchmark = Graph500

x  6.7.0+
+  6.7.0-preempt-auto+

     N           Min           Max        Median           Avg        Stddev
x  15 6.7165689e+09 7.7607743e+09 7.2213638e+09 7.2759563e+09 3.3353312e+08
+  15 6.4856432e+09  7.942607e+09 7.3115082e+09 7.3386124e+09 4.6474773e+08

No difference proven at 80.0% confidence
No difference proven at 95.0% confidence
No difference proven at 99.0% confidence

Thanks and Regards
- Raghu

