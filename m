Return-Path: <linux-kernel+bounces-104478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A131387CE75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43CF1C2187D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792A7381A8;
	Fri, 15 Mar 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PS40e+7N"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF067376FA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511431; cv=fail; b=dbhjKsmbYRc81ZvocNyjcxZRrqE/nUo8X1+09Ahcrgb+zF6IYzWWR/bIgngWzLVsS5rK8+1R8CEHjXadwqyboQvqA0xVAgTQZAcg1bt/jgX4/THZrva11IqhPd2O79IfZgbXMGvSMQOVk0N8rYPML4y38BqGR8Kc8TqbTCs2hTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511431; c=relaxed/simple;
	bh=/ZMiocdhcwQozX4Zx6sE9zgoY6DVcq6EjmuC0zO8srw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bbOMQaC55497Q7R7J67f2kyLkh/71mwP4Ng8kFm4xvII1KJpIfo3Woym5jtZGBhn69yUOl9pz8tqJu448Mjwr3fOP9XsbY1ROyXwFwQElugSDDni1WUnepbrpvSSuLdrT3n6oPu3j0Ci7U8FIa+BhHDS45AxZEcz2ywRftjs6zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PS40e+7N; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3QSfMpsGYZJyEVg45qcXy0eQrIOhyxT6DG7bWAh/9nja0/gEjEjDFkddDQKZEMJPHJWtzivdClrLJLE698+du2FAFvHl8X9qg82zX4JKQbu3X0rstf8jwvxXep2hmXpt5hO98wjBSn5siJooeYC2Ixh3yCRqXKSXiZLinWQDcTTUp1AoxcTE5rGVgfjAovI6q4CwA3107+W83U9+mMpG7PWs/s64+Cg6bwyjgWhr7G+nWUxgmdfhbd5CainfPQrKaPL6YdnyKlidt1loFqplhxvI823X1CuSBQ4MQoQLhjOgx2WL2wLF9koDCq9m6DU/r2ipQcC0RUw9voW7AaThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKeLgd5DaAWCmXtgR/yeatIUgdlJvIS/ziW60uOHKfc=;
 b=idj/JVpQysy54LE2PA0rE/vVM8h7ZdXYDQ+jcc3muTv2D64/ss+xGB1VDXqFlr1lH3j7Ahher9tvCoL9Ruv4sqIHiNzT+CyWFle93PPXif7+lIMmLRTx2t3oRwuy4/Nlk6lfVf10OiYpXm2RTKnMsmksfCylm03WAtQxwx+CTAnTTf/dSpzDixmtpWi4nbwFnZ/vO5Swp4L0HNhFK06bNHh4vCxNufxtUsRb9QNNjVJVss8mCdKJkZ0mKyPbVOiMoG54GsblsL9fFBZYQynADbQ99csEjcGiig6L3e/hh3uAl+kGSYusNTxQcwGktowaIC1TqQ8KcYaoMu5B01f1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKeLgd5DaAWCmXtgR/yeatIUgdlJvIS/ziW60uOHKfc=;
 b=PS40e+7NS8SWsuNagJ/WDSwklzKVQrcEscrB6SLeMcSDd5ZVt/sJS0z2ZIq4MuGgUubZ6NRl2DKVLEm30xXhUGz3M4bntJjuydYSwG642JxCZb0V746DyW6/72CMk9Qc/HCT1NqhzusxCrmjmWa9pp5eICqgq1vP3peocamgGV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Fri, 15 Mar
 2024 14:03:43 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::948f:c6a5:70a2:f809]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::948f:c6a5:70a2:f809%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 14:03:43 +0000
Message-ID: <fafaf2ec-a997-4802-88a8-1c1c9e3b60f5@amd.com>
Date: Fri, 15 Mar 2024 19:33:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
Content-Language: en-US
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-5-mingo@kernel.org>
 <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>
 <ZfAoEmH6KRhjyUor@gmail.com> <ZfKJaztM0FhKRmjg@BLR-5CG11610CF.amd.com>
 <66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com>
 <d5a53c05-6ff3-4bb3-96e0-b8865bd81611@linux.ibm.com>
 <07b35339-c369-4c5c-b5a5-b557fdaa5827@amd.com>
 <40325480-238a-4839-98e5-018e1890ab78@linux.ibm.com>
From: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <40325480-238a-4839-98e5-018e1890ab78@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::10) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0bcbfd-6615-48a1-cd40-08dc44f8b94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CqkGQGDkrxGOXeC8KBVyCOs3+ozaOOq5ikcpQ0Dy6iZZaYxVNMevNGwVAbA7idXzzghVDo0UmPjhjqp8ajRk4ci8FeiXvXNW+13JEHgaFmPkmvowO85/4dcwiCUBaVBHdiqYvdmM3jhl3KI/EcMEC2GJmUaDumOyjo+n9IGhjbOL7MixA3AvNYouBbnqOHoZJ0z6uDmlAhCJN7yZrSjaGdcbPlIWF3imbzRIW0SxGDCm8b3NNfGRXg5kxfUHDYsa9IJVfBZjt9LuL+p+7ta5/ulyALEtiloQ8KO4pQlQKZ2XS/uJ9J+vjHESnOKE/OUVumlOPMDnsrObwaWf2xzi3K/jV0s6w5HTGTrHkbOL2FD/Xi3MXhG3aCxR1/pmJZV/6nKDpUJ7EBqhaKHkWrAYMwfZsCx1jdxjlr2HvZUHXx2saQ93gu7DNEJuUj7k7mrwRmeS7nHEI1sOM7f0FIynZrWrSpxz67rQ68rUlunK3AwdZgNTMvqcvepbUyhGndJGi1RW2QGbPQQDw7tD+QKOVLnafoRrexVn0C0M9jrU9PfIWZP7IRQdHIvq7TxY1gCe6k626Kajz8lUZWOoFiuTG7WE/ur5O3rDzZv9ncElwIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0FqakdWM2loZkRtb3ZLZ1dWdGtnMG5ZRU5LWldCOEtIRkZqL0VUQkg2czNj?=
 =?utf-8?B?Rnd4Wit1djVUVjlLZC8reGg0M3FSU0ZYUVFTRlptZ1pURXdic1I5TVNqeFk3?=
 =?utf-8?B?c0kxZzlDaXJxZWFDcnR1b200RGFKcUVLK21oU0dqZkVsTER6Y0JBQUR0OURC?=
 =?utf-8?B?WHBFLyt2RnFpRXVXY3M0Z1MrQlQ1dmFSMmsxdUIraDF4UURrY3ZqR2JMQU1L?=
 =?utf-8?B?dUZQa2tuZkxaSjYrQ3RZRldxS2Y4TE5iYjVlcGt5dlJ4K1B1OE1zVDBTbDlS?=
 =?utf-8?B?bWdNZ2FOVlJSeVUxMmRML1AwbHQvQnlNZk1HZjRKdVNxMVJieExiQmhmcURR?=
 =?utf-8?B?MkR2TVZlYXhZMXNsQzRJdGFCUmkzQVNpdVAxWlNIYnpxTTJDcUtodHBYRm5M?=
 =?utf-8?B?UiswSmV5K0lqc3p1T3loTzdhSVlob210UFJwY0ZOaUI2NkFZSjhOOE1vb0RP?=
 =?utf-8?B?TWJFYzRGRzFWVDBRbHRaMGY2c0F0amhPUXN1cFdReWxpbm1BRTdTNjF0OWY3?=
 =?utf-8?B?bHhtSG5kSEpMamZZMmd4WGRsMUVtSUs4WlpFbmJ4djZ5bXdRZVdEdUJiUEMz?=
 =?utf-8?B?NmMrVFpsQjZWQVBLZUZaWHJ5d0MzZWExQUVTMlRIM3R1dkMxNXo0a1N2TVp0?=
 =?utf-8?B?VjRGSExTVnYzRDV3OEFqOUVmZThCeXlVVEJYdFExM3c5ckl2V1lKWDg0TGRj?=
 =?utf-8?B?RG8wenoyT0lDMy96UGxzbFBESnlrUmJIYkRFT2FONUUwS1JlYmEyc2tERi9s?=
 =?utf-8?B?VHVWYVNtb1p4RVdxT09rOE9pSFVtb1lvOG56OGg0aENpT1pEdG52VGgrY0RY?=
 =?utf-8?B?WnpUTFZBRzBMZFhQMDdpcmhlcDZXYWNSK2VtQ3ZWYWc2U0Q0MWVjZTJKeS9p?=
 =?utf-8?B?KzRmL1kzZEU0b3dTYVljMU9mT2FweE12QXFRRFVta25lVXFqS0pDOW5ZZjly?=
 =?utf-8?B?ODdkTlFVUVZtSnlQOWl1aU1tZ09TeUNJd3Z1UEdVa0UwM2hFK1FVTmdPODNN?=
 =?utf-8?B?bi9ucUh6QWE5eXczL1pkUXMyVTE2SVdSSWFtbFk1Unhha05TczYxaWJ3OGty?=
 =?utf-8?B?aHdmNU5aWFdlSXp1WXM0ZFVxQjYwT3dsVHhOcU1sYk5jZjZpdG1OZnFLa0xt?=
 =?utf-8?B?U1RBNHRoTkhyQ2syNTVTWmRtcGI2aDdqUXh4WSswemlRNW1kOG8zbENydDVH?=
 =?utf-8?B?d1dJajJSWmUyanVJeDJtK3BRV1ZyMFFrTlQ3dk4rcTR4c0VlQjZqeUZxUk9p?=
 =?utf-8?B?OWpGMDA2YUFxZ2FWM25YMFpXMkYwdEVFcGd3SHlsc2tZYTZnQUFYcDBnMmFH?=
 =?utf-8?B?VWVhQ1JjM3FPaDlKQ2l5cG1kcFBWZk0vQkhlOEJmMy9PMnpsVkE5U0E5SW5y?=
 =?utf-8?B?bTc5SmFRbURacTJMcmpHTGN2NHVCakEzK01YN01wQTZGenNoRWZTczI2aGxZ?=
 =?utf-8?B?UmVDVkRIczZyaGNWaFVlMXZJWlROR1d5dEs0b3ZYN1NxV3ZJdGt2L0J5UWZo?=
 =?utf-8?B?b3BGbU9kVmx5ME9NQ1lMdkxDSHY2R2tYcEcyZGVOdkJ1TGwvbndJN1o1clJV?=
 =?utf-8?B?L2dlVHNrUkpUMHpoUnNJZ3RPVU1VTjNDOFRBVVpFRmx0cHZaZkQ2Z0NycStI?=
 =?utf-8?B?UE5xWU5ZM3BuSEdXTWs2MVowSStzRFNIZzVDZGw3NjkyWGFGTDFRVzFkY1pD?=
 =?utf-8?B?amZMVloya2N1elh6RDZjcGl1K01acVdsdnZLUTZmMklKWnpHVlJaUHZxV1ZQ?=
 =?utf-8?B?YWlrSktyVHFvcXFlRUZ1Mk4wc1kxNlZvYzRlcjRXVVdCZSt1MjQ3MDREMFR2?=
 =?utf-8?B?aElQTlMwdUhNcUR0ZFMycEpyR1VlSEFZZ0IzQ3M1TExlZmdGSUMrUEVtdEN1?=
 =?utf-8?B?cm9KNldOWlNLenZ1T1FvQVBpOTI1OVdCSXhITkJQazhIWTVwM1o5TXJQUjFL?=
 =?utf-8?B?SWdkMFUyZnUwK2JlRmlGclV1NEVBbEt4NDhpM2QwMm5sMlB3VThJZlp3YXdl?=
 =?utf-8?B?QXNaVDcxZG1DWmNNU2VTUnZFbkpoTUw1OUh0dTlSb2FTMmlDZng5U1g3L293?=
 =?utf-8?B?Zks3T3REcU1tUm43QTRLd24xLzhaSDRMSGhQbmpQekJWT0pmTHE0S1pRWGpT?=
 =?utf-8?Q?3cPxiakqxmbzZQKlCQmZ5pBI5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0bcbfd-6615-48a1-cd40-08dc44f8b94b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 14:03:43.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1Z2fSoa4IynY6LpYoe6KwnrOeBhpZihdJK///2cuFhZ3WeZkw7fKFpYxg5gJMe6ig41+bUJCp1F9izziUXnwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909


On 3/15/2024 2:50 PM, Shrikanth Hegde wrote:
> On 3/15/24 2:36 PM, Swapnil Sapkal wrote:
>> Hello Shrikanth,
>>
>> Thank you for reviewing.
>>
>> On 3/15/2024 10:07 AM, Shrikanth Hegde wrote:
>>>> 19 20
>>>> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
>>>> +domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>>>> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
>>>> 44 45
>>>>      The first field is a bit mask indicating what cpus this domain
>>>> operates
>>>> over.
>>>>    
>>> IIUC, this is editing the content of Version 15, But changes would
>>> happen on Version 16.
>>> Instead can we add the section for Version 16 and not modify for 15?
>> This file contains the field details of current schedstat version and
>> the short
>> summary of what change across the versions. Maintaining each versions
>> details will
>> increase the file size. Instead I will add the links to previous version's
>> documentation.
>>   
> I hadn't seen that. what you are saying is right. it would bloat up.
>
>> Thoughts on this?
>>
>>>> -The next 24 are a variety of sched_balance_rq() statistics in grouped
>>>> into types
>>>> +The next 33 are a variety of sched_balance_rq() statistics in grouped
>>>> into types
>>>>    of idleness (idle, busy, and newly idle):
> Please change this to
>   of idleness (busy, idle, and newly idle):

Thanks for catching this. I have updated this in v2. v2 is available at:
https://lore.kernel.org/all/20240315135501.1778620-1-swapnil.sapkal@amd.com/

>>>>          1)  # of times in this domain sched_balance_rq() was called
>>>> when the
>>>> +        cpu was busy
>>>> +    2)  # of times in this domain sched_balance_rq() checked but
>>>> found the
>>>> +        load did not require balancing when busy

--
Thanks and Regards,
Swapnil


