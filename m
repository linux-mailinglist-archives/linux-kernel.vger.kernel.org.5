Return-Path: <linux-kernel+bounces-126645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B51893AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A036A1F20F80
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B95374CF;
	Mon,  1 Apr 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SVcP3P5b"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2113.outbound.protection.outlook.com [40.107.93.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C528DC0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974069; cv=fail; b=OO8QXm9x4Pul+LqeYcUqwi70yvVrqfnaK+sHR5JeMy9IL6Nbf1skdc5tLJW/3FFS61ANE45mFZJTF/5Io1QwHrCpryo25rJJWprinRdmer928BGy0XDeqCsZ5j2S3greW2TkpWUvvBcCdVI8HGeg+QN5aztEQEuKGHmjAtYTQLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974069; c=relaxed/simple;
	bh=hgB5BPqnjEL3WoacEAdM6ATWP+joZGbjtCBPMsn6DeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P2vPcDU38hD+iw6gVsahYT3G3QsPsWVYbCvU0ZvY/bdZvDPHTjbMqCVT0RiYAmxdc3CISwtuVM7FHx8NOYz4tzD+aEXHmcMQs1BHRyIrzRN5eLyW+YkNLY6FsBOTBku5zp3gO4D5jJtx1qheh3q15KUkIhiGGwVwrbVC30bAUe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SVcP3P5b; arc=fail smtp.client-ip=40.107.93.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMOKt8jaTUkayYg/h75m+0kW16gjW9Xb0lrMF00jklUzws3UDcIPloaij/NfANFa1l1aqr0KTthW5MLQBNfBusvo6OgA3LJimYsjKz1SoGFcZa0GeK6gQuT2MmyT8cmGmKymYsjbaQe9FvgRZuiOHSck4mvVI0ndKCTkc1HBuUS6J+B6IJ45fdh+8HOKeXC+oZIUyDTQx9ijhURxFSGWZpNRfmmxfdYMlFmAcWIgbHzKfpSpy/JEO8p61Vy69RozviL8CFHWjnowkmLVfhkwLkkvtiqlWbExF9yv5cnj9je0V3TE4yIp7xJ79tqWe1xBBx6rFu95lmcd2SYeWFlfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NIKSjipgobXUxPNsSNXZ17XnTe8bWasFIA/hvGc+mU=;
 b=Z9x3MRMubJUl4uzFOl+yL/x7ftJYOh2uphTMz9lfXHTw60nv/wE7O35hTPAu+1GBZmtwkKVBDfdOHxgzjVCDnrfTJrLkZVbWldF/rGOcYuMVLjrOju56rKTH1NV7AEBreAO++aEa3wH6ndv99f5QhulgSPymbIy5dbN2JDYFUUXgwn1w3ZxnwIk/aQElLV4neDTaP51VqlCPLcAss5jbEAysYb5VPa0j/cjyJHOIyVS6zth2XpEZlPv2zT+ssBcr9KeO1DPhLCkrJNuAWSoYagESgEnxmlCoHheDjko/20kuF+cf+iu8bGWymjuCBFzKMIwPbShaaSZg7Gdmz9ABgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NIKSjipgobXUxPNsSNXZ17XnTe8bWasFIA/hvGc+mU=;
 b=SVcP3P5bE1amQbDmH3pEDr84FZJ5BmhRG3iARkyISpyyR5l4Te6LYi0olNJ6yCnC34CgFBYp5fWnlHeRcm1HZrSHJZOAHyHHCCv8vZlgXWSB3tSmvTfXRvU8xZTjXkjdBS7ASc3t1lTbCHg/vipS3XQ9tp4qsnJrtKSW1olUnJc=
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 12:21:05 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::a628:d2dc:a0e9:67e2%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 12:21:05 +0000
Message-ID: <7e373c71-b2dc-4ae4-9746-c840f2a513a5@amd.com>
Date: Mon, 1 Apr 2024 17:50:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large address
 space
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
 mgorman@techsingularity.net, raghavendra.kt@amd.com,
 dave.hansen@linux.intel.com, hannes@cmpxchg.org
References: <20240327160237.2355-1-bharata@amd.com>
 <87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
 <87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
 <875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|BL1PR12MB5900:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O55Er1RaB+Uhm4VA9h23fBMLlnilkdat+W3MKMiWJB95Hkt7G+aBWR5aOmLE8rYMJeU7MEHPQTMjuxIRwsO0nu2OVEwETg6Wz0qHhN9XSN8dGvvRHUgpPLQcSZv1ayrOUBPOB29yL8umpYU+130It1kVe3A2Mz+mF0/y7jnhORXJU+Nu5unLUXdoKZFn8y5jtkKFlPDfUG0Ej8Gk0f+I1D061Voxnictb1t9QhBC4DKs6+3yKVT+wn/V9FGWCpk4AphZX7w10gUdD9Q4N7b781yjrxthb05g0prL+GNxgqymP0sIwUsAQGsbj60geK1lKrPoV3GtbXlSLgAbU8w8sn59u5iuqX86GO1Oa638zutKU9IsEdY08UU/V1BLw/iof58O6sSaxtH3IOp9dx3PDrwR7GkJCXspa0vh0ESkfLLWbRDGRIu5CBUP6OYlz/rr3GLc37PJKHpFHvaeO3sO80VXeWuQafPHN/GAuJ9dUeq7IuPM9zzJIv/oyswJucqALe+Yf2sEC7U31/CQvRY/9NzX9MqfKMqSD7rWHl9NTX4HVA/9S3N2ZuVhGIveCanb+UxIHlvo0wAV6NnH2qHSBXFzG38CqP1ZG8XRq6QR1+WI2UjPdp1S9o8H8qtNnhPyakjGH9uilyt1riNTP+MGHzAkd22S//M+KgumfxLS4Pk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmhyRitFeGIrNHpycFRHanowZTBOTzlLTXBjTEZmZ1l5Qmc2U1gyYW0vekNS?=
 =?utf-8?B?b3YrWmJzTU9SbHVnVTI5dEtmQ1lLZ0hHUTJkMGV3dlc5KzVlQW84eHNQL2c5?=
 =?utf-8?B?VUsvSWN2WjdZVXg2OTdRejEvZHErc1ZPOWMyTDQ4aGRWWjFxSjJXdmIrVXkv?=
 =?utf-8?B?enBobFRKM2JBaVRDa1ZIZVIxN3VCNmV5TW1Za01jemVwVGtZV0M0Z21nemxr?=
 =?utf-8?B?TjFkdGJPZmJLQlhZenVaSE9PTENxVWxJZkVHWk9Mek1XRGhneHh2WVkzajg2?=
 =?utf-8?B?TVQ1MHMrUEczSFlWS2RuRVlmRXhqZUZXVzZIS2crVnFHZnJlNG9reDg3VWhN?=
 =?utf-8?B?cjVFajI3ZzJyejJibXJzYnl3K3c1ZUJaUFBXaUw4ZFdyWFpTS2RwTDR6M0M3?=
 =?utf-8?B?clJyWXBuVnp5VVJoY0gyV09YdCtIek9JWjRoRUtqZFhQZkFTREVSc2VabU1L?=
 =?utf-8?B?bVVwY3cveTJCaTBRNEZRcU1mTDZ2bnlGb29lVTdqaDYyWHR4dXZRM2FxbFhI?=
 =?utf-8?B?WmpNR0YrVFkyUWtHWTV1cmcxWWdhem9DbHE1SjJEQktOZUVXRTh5ZndXUjNB?=
 =?utf-8?B?UVI4UU9ySGNlNjdUWFo0QWdDN0JWNktHQ0xHTFlyYVpXOUFUbFNCUzlTKzZv?=
 =?utf-8?B?YkMwV1ZMSUNXbG43WVhSbm9kbWY0MEg5RVJ2RGZuVmp1UGZTVmUvbW1OekZk?=
 =?utf-8?B?Q3NGR09Ka05SQ01RWWtubTZnUlBMekxvZ2hwMTk4eSs0OFlTVlRkZGl2Njhz?=
 =?utf-8?B?TDJHZnBOZ05rVVZnRWpReEVwTEE5UTBRU0tPWklOaEJmbDh6OGJ1QnZ2Z05S?=
 =?utf-8?B?UXR3c2pKUUZDV1dVRXdyTzkxN0wwZ3RCR2x4TkJ0eHBvTzdyeTlUQmRrY0ta?=
 =?utf-8?B?ZmdxYmFLTkR1a3ZFYXZwYlBNTzgvdkFpcVkzUWRkdFlyMEtQYWFmMExndDRO?=
 =?utf-8?B?NlV4RDZwaHVuZnRGaU1QT2JDWndIMlRUVVlQVC91aEpaaUs1ei9PN2dwcWtz?=
 =?utf-8?B?RVJvdXRnYXZ5Y0g0QmcxQ20wSWRodTRVem1lYkRGYjErc1JxVndvcG16a2hM?=
 =?utf-8?B?N3VTcC9EOWN1R0VyNUVtdmh2eklqYmlaS2MwL3BRSU1NeEZZaGZ4dE5GMGdC?=
 =?utf-8?B?NEJ0ejR0S2ZQRVF5RWR5dDdTUzJML1VSTStHeGFkQ1NaL0RQN2JMSGRBYWlD?=
 =?utf-8?B?bzZYb3lMc2E3UGU5YU0vdEQ0K2NyNFdpTkloT00xMEE2V2hPNHQxZ3F1bTlv?=
 =?utf-8?B?QTZCQ0hMd2NnOFJkMkRFZTlXcFZJNzduaGczR0RZUDkxNGh1ZC8vYm1rNU9T?=
 =?utf-8?B?NEJIY1dFK1cyQmlJQ3JIaHBlWGZISFNuczFkN05uN1ZpNEdtNnFPNnpjZ2Vn?=
 =?utf-8?B?YVRlMHd1LzNvQnUyMzVmbHVuVm03RklDQmFzME5KZHRjY0NOQzlrWDFXZUJn?=
 =?utf-8?B?a3B3YWV0K0luOEtFV1JOQSs4dHBWbmpQRE8yWlZLYStLSDY5dUhxdzJVTGFl?=
 =?utf-8?B?b1p5MkovdTMzdnJnYTErNWZUOE5qWENaL3lhcVlDZFVNNXBhTGJFbWc0c0tl?=
 =?utf-8?B?VVpkVEtlQWx2NFBnQXlZQnJKY29FSFVzNFZyeWdRUHM4OUJtQVlUcndzVCt4?=
 =?utf-8?B?dGNLWVMyQ1hFdCtMOVVJR1ZMc292eWVGRDI2ZWpSamEyUytFazVzSG5xd29o?=
 =?utf-8?B?T3hMWEdPYSsyRnhFcVNOTE1KY05iMlF6RlZVWmZIRWJpSUlKNnNYVDNySTdX?=
 =?utf-8?B?NDJaaHRJTm12bWQ1bVFUQS9kYTh6bnkvb1Z1OG50bFpyMjdYS2t3SnIxWk91?=
 =?utf-8?B?L0JaNk1OYllpNFB5d3p3ZE9PZEU5ZGhDUnhKK240cXZqUFhYTXBFSk0vOEFu?=
 =?utf-8?B?OVJ0cGt3WkwzTjJJbzF1LzB3Y3JoQ2lWR0RhZXJvRzBGN2Iwbk1VVDIweVJE?=
 =?utf-8?B?dzFVc3lHYmVMRDUySHdpMVg0OGhqZC84ekxyVlFjWGtYclFvaXJhVWNEdFNo?=
 =?utf-8?B?a3RQekJlWWNXdWQvSGsyTjdUb0NwUHJBOWJyUWJqMExwK1FjNTl3cDJLUkl6?=
 =?utf-8?B?VGdjazVzTWFyblgvMG5xc1F6VjYrVlRrdTRpZEpxM1ZwR1VHUENLZmtBSlFI?=
 =?utf-8?Q?Xg3X/dNDyGRHsT0epIqyV2/7t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658b69db-c9c3-4b96-6083-08dc524633f2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 12:21:05.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELpej1ZvPlZ8V+kfjdp4shUVu3lkv3PZ8S05LZ0XNvSJ+jsooyNPUCCRsn6s0zJ7kg6kZYAVeAQNsR9yoPkihg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

On 29-Mar-24 6:44 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
<snip>
>> I don't think the pages are cold but rather the existing mechanism fails
>> to categorize them as hot. This is because the pages were scanned way
>> before the accesses start happening. When repeated accesses are made to
>> a chunk of memory that has been scanned a while back, none of those
>> accesses get classified as hot because the scan time is way behind
>> the current access time. That's the reason we are seeing the value
>> of latency ranging from 20s to 630s as shown above.
> 
> If repeated accesses continue, the page will be identified as hot when
> it is scanned next time even if we don't expand the threshold range.  If
> the repeated accesses only last very short time, it makes little sense
> to identify the pages as hot.  Right?

The total allocated memory here is 192G and the chunk size is 1G. Each
time one such 1G chunk is taken up randomly for generating memory accesses.
Within that 1G, 262144 random accesses are performed and 262144 such
accesses are repeated for 512 times. I thought that should be enough
to classify that chunk of memory as hot. But as we see, often times
the scan time is lagging the access time by a large value.

Let me instrument the code further to learn more insights (if possible)
about the scanning/fault time behaviors here.

Leaving the fault count based threshold apart, do you think there is
value in updating the scan time for skipped pages/PTEs during every
scan so that the scan time remains current for all the pages?

> 
> The bits to record scan time or hint page fault is limited, so it's
> possible for it to overflow anyway.  We scan scale time stamp if
> necessary (for example, from 1ms to 10ms).  But it's hard to scale fault
> counter.  And nobody can guarantee the frequency of hint page fault must
> be less 1/ms, if it's 10/ms, it can record even short interval.

Yes, with the approach I have taken, the time factor is out of the
equation and the notion of hotness is purely a factor of the number of
faults (or accesses)

Regards,
Bharata.

