Return-Path: <linux-kernel+bounces-105700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B862687E2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DE11C20B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D14B20B12;
	Mon, 18 Mar 2024 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s2bJPa3M"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB5208B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710738279; cv=fail; b=W96CErWacOUBjR17a02I2QIVVtUFwLUeAeOn2MVLTooCRrjpW2u2qPKYibfwryjJQRpNj9YjoP1WxGym3+FyuhD7V6108GEm/7N4Sbjav1e5URFYE2rJLRdNOLL8IWUnCL8KYV/h5M2LOvXnW9UQ7sT8NlUdPoqe+Ay+8NEBhgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710738279; c=relaxed/simple;
	bh=YgVJ/kz61veeyrSxqx7+4OTeRQogLWvqLxNNdOGALjU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ITGkCbHd1KQU/0v2Zj/zSo+SLREyDOaP/c6Oogw7ryvovUrhKO4N9BHQIW/+GEXm/Pa7rtg7uqJFO8VMjFArDYDwv3ka+qBwWbMohq864C6F+8wygQaqx+HzRat+h9ZFMjTiN1O/kJ0clTL0BsENANXn3l7CK8yZlFvJRuLHbwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s2bJPa3M; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy3xb4j2MTnSWZk/akz2sBMmeCsHS/jupztLuJ4BSGMYKLFEg11zcQSijhXGwOZ1RT9AFPfH3zSsq1UCcqGNS6mwffkeWl1rD0xJVizdEG7zd/C8RaXBbrRBcLZQbPw7vQ6gL+tGHDAnzCmotYBttTxP724JSwdsjNjPY0ycZa7IsQUqfXAS2gzFfRrTMlgu9cz0Xh0g9qGPMVt6tdeV7CCOvOVsWz4Ymtq5wwf/TIwa51CkLz1JEQ6uA2d4VzBuTuzXsZsuSqB25gYOrmcInXG6ygO0PVmCtkIAuWMm2HvlEA6GSt6OM80HqCwAEbGffMLKIZkqftjFNoiwoac4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQU/gcDvgxD08b7AwwCo7RZ83spt53YOCnsisIkPjpA=;
 b=hAfD8bsWLYYqVX2n2UZr/myRZVtr1HJrjpm3oPGEHI9YCPuaAbspkmY/clwCLSmAr1WrkYUD6t4fbkFvW9Xu8GAPiM5R6K3G9nEb3LbzI/G4t3kpFoMQTSsJYJLmRzfmsQXnmRentXaMbLhrPTJh/SbAw8Bh1U5356U/GYhaXu3Vi4hGsGfhY3P/P41YyA3w15Ax/xszI0xHJarKXofjS+xpF7slsFMh781RagVgrmSLwPVuWjKydv43gOkyCLkgLd9BwoP7DYFux+OQ6X5VWOi68j6Z0DIKbz7kzxpLoUqQpXIo0zaeVeZcuK+P7AkJ3/Eht10UxFrgr1ou77pLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQU/gcDvgxD08b7AwwCo7RZ83spt53YOCnsisIkPjpA=;
 b=s2bJPa3M3CzcvAS19T8bVT73SQewd+v39OTPjTu8Wyt7FrF6NAlYSLxjFQ/yS6a8rTd3SsJ4/9FLorHxdiZgyngN3wqiSh3RWP6iMigP5P5RhmF7FDBie06A7oGc1CbbYS17dbFmSliBGutXIuaNwf1SQXYzxMNb75mZxjp+DT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.25; Mon, 18 Mar 2024 05:04:33 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::948f:c6a5:70a2:f809]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::948f:c6a5:70a2:f809%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 05:04:33 +0000
Message-ID: <de6827d2-0012-4f23-b55b-083aba84c0ff@amd.com>
Date: Mon, 18 Mar 2024 10:34:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched: Report the different kinds of imbalances in
 /proc/schedstat
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, torvalds@linux-foundation.org,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 vincent.guittot@linaro.org, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org
References: <20240315135501.1778620-1-swapnil.sapkal@amd.com>
 <20240315135501.1778620-2-swapnil.sapkal@amd.com>
 <839ae17e-3818-463d-9a5c-3c1eac927ae8@linux.ibm.com>
Content-Language: en-US
From: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <839ae17e-3818-463d-9a5c-3c1eac927ae8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f4078a-7ae5-4a5e-160f-08dc4708e620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bCImW/ILrc33IryP7Riwb8qFaKXL4dDjXncyzBgXltl+Eahriyh2mSw9p21i0K7TNJZCE13mTOUqlImuXK0RQPv+h4h/yIz9tIKmvqmC4qqHNMSDHphC4Xcso3cU9wpTv/C0SeHcKIJd3StoQ9mrJe6Xy3sHyDkdFpEnJ0QCUHmtnf69m91to8g+QYjmfiw7G5eRpl5qFdpzcZKJoPX28iqaH5H/HLv6hzTIaxfA2zP4dX8QoOAAmBhNIjEBfVF59D1hRQGRKbTIErrD/jJoVVl0LDasTcYx0/oHFZedpY3JZisbvtSgdDwPITjjSRZMlfj5Bzg/2YkGTFPDT+rqcITAji24UGHJmnj7Pwg13D67UIYk2bNBvMvcgdwPl5eNgReQdcI9T9JddFeOLqPFxyjaincrleGaoZYs00eOsUPeZchCxtaAxg0+4UA1OKC0Rovus/aRsBGQA280f/WMPom/YzVQ7XRFyJ9qK1mB7yQKsAFE76+e8LnkaDDTkoiuOWs0NuNEFwnMh/vBbSBk4nShpj/Yy2k3hYAWXexY/2+geD6oh9jqmMNiQtbEUzbpuMTwTKYnNaaiNBF6O0M7Aa0jpjJuz9KwaTASZHLuCOLYygCcEP2JThVeTO9i0xeo6vFUw9DK1FmP1ArmtC1Tt/w67/xS7u3Def8lP9AdkSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUtWRVRubGpQU3NTd3pPZG1PL2o0K3BYUGlHbmtKZENiZjFYdlpPQTdwTnln?=
 =?utf-8?B?aW53L1NWYThvbG1FK3pwc25iV0lSQWcxLzg0c3B6NStmbmpaSmNBV2MzWk1y?=
 =?utf-8?B?L3BNQTlxODBtOGJJM3A3bkpPT1N0QkZ6VXYyWjJSajFkb3VIamNXU1JoZ0lG?=
 =?utf-8?B?QVdrMTIxUDgxcVg1N1ZSN3ExY29GcCtwRU5JQ0lzdVJidUpRWjFoWWJzSWE1?=
 =?utf-8?B?d3U2NjRramlpWHZxUGNTajJtSTNDeWdvdFJYbUpLemp6Tk91N3phSzVMR1dC?=
 =?utf-8?B?aldQQ1M3bSs5emFwSmNtb2dpbDRtai93TFRiRTVhVHlCcHVQQkFDcmtYSGM3?=
 =?utf-8?B?eWdpajd4SGxBRit0M2JUa2d2cndCdU1sWkFpYkZRdnp6dENaQzhlWnQxa2h3?=
 =?utf-8?B?cktDb2VIaEZIYzdkV2dkMUplWmlYTlVrTzJLUXlxblVCWXRFRGY4Z3h2L3Vm?=
 =?utf-8?B?YSs1VkZUeGNCMXZhM0xDTVpIVjNmUDc1WmRIemFnaTlkT0pTRkRNUVp3NWVD?=
 =?utf-8?B?OGZQYWJzeCtwSU84SVZHWU1DazJlWUFZZDdwWnBrRkFzamErTkJoZFIwMS9q?=
 =?utf-8?B?SWtmd3NrWXRHdkl0cjg5Z2FJNTZYby80ZFg5QTZQTW1DcFB1ZnFWTlRLRG1D?=
 =?utf-8?B?YlpTVVYrVStqKzR4TWw0UGdHcnBLOTRESnJQdU1mZ1VGWGpVWVFWemFobFpz?=
 =?utf-8?B?Mlh4OUR0TEdsNzM2K2pxaGFmcWkrT3hPaHhSUkZKRm50bWR4UHpUUkFDZHpn?=
 =?utf-8?B?VFIyMUhqWkNvQnlaWTJ0eDhVeDdtR0xBamRhRkRtVU11NVNndUtpKzh4K1RK?=
 =?utf-8?B?Zkdmd1JRQmswTG1XMURBb2p4QUlYbWh2MWxBSXBEc2l4TnFnRUY0Z2hObVVH?=
 =?utf-8?B?bUhrcXJmaUpCdjZucEVmck10U3JkS3NMc3hMS29sM0N2MzYweDFuMmJpeHhN?=
 =?utf-8?B?bkJBSnh1WXlMYWI5SStaRFRUalBBdlk5bzlBTmJtZmJQaVp0ZVk5bnJ0RkJI?=
 =?utf-8?B?WTh4djdHblFFQ1JETS9wNTlmMU9wTk5Rb1pnQlJNQ1kxVXJFemkwZUZuK3F0?=
 =?utf-8?B?dmM4dEVDM29rM0VDV1FxNmc1SXEyL2xwenc4SzRoaWVvdlRYMUhpVXdpeVYw?=
 =?utf-8?B?OHk5NXpIN21PbVFqZDVIeTdGQTFndWlaR2Nzak91d1RESWtxMVgrRS94Z2k3?=
 =?utf-8?B?NTF3TFg2M2lCdEU3MUpsYWxjWFFnYUJOOGV6Vk9oS1dOcWErU2FTRjR2SmhM?=
 =?utf-8?B?WFhNNlYxM1JJby84MXZuTnhXclJueDRSdTBqK0VVMGFVMUt3cU9BYnNhQTF2?=
 =?utf-8?B?d1pyMXZyMWVaSzFvcE1LbmtnUldMaURVbFdzd3NoakhnOElkV01pbnhZbTFk?=
 =?utf-8?B?QWthd2NtUGprVTNGOHNIK3JtUGliRG45dUNsbWUwSTVrdjlyd0U2U1c4bFFO?=
 =?utf-8?B?Q0FtUTRzL0w5UXg2NFlHMkFyM21FS2laaCszTEZhRWhibFM0Um1zMHo1cjI2?=
 =?utf-8?B?MFVzcW9iRUw3VFZya1ZaOTBtSXZTelY0OXdTaG4zd05pYVRUWlp6MStwdXBG?=
 =?utf-8?B?RGwrZlR2ZnFJRzE0aTFhaFdpVGEvRXpVZUQwd0U0RnVKeUFkTHV6ZUZzQXlG?=
 =?utf-8?B?N1NMVDV1bjNuU2dmNW01a0dnZkxhcmx3aFk2K3ZkQVczSTNMZHExVlkxZHJn?=
 =?utf-8?B?LzdJeU5EZU1lTHVGQ3Qyd2llbktlbUVEWWgyK1hCRWpJSlA5OGxzNWc2TUpI?=
 =?utf-8?B?OWthRTZXajB2a3IzcFdsbUt2MUpsWGVzT2F4TjJGbFJBNnFCYU5GZjBEaU9V?=
 =?utf-8?B?bjVnbmpVb1RTM2VOOGRmaEdsV0pEbGQvRVpISjR3ZmJieE1MU2RBVzZTcjNp?=
 =?utf-8?B?RGc3bUNlWktieC9CajY0Vmx4U0dhNGgwcnNCeTZLY2JnQTZ4N0t5QTNqUGJL?=
 =?utf-8?B?eVlPUjQ0VU5sZVJsdDVYUXR1eFlxL0NtMGlKQVZHVFFscGxBUis1djlnZlRq?=
 =?utf-8?B?dFZvWHZPdGpiL3ZGQlFEVUMwUXJoaDIzNW9lVkNSUjQ1eVRwSUFZdXIvVGZ5?=
 =?utf-8?B?MXU0NUFjWnU2cFg5aUtUSXg4ajFKNHBmVXJtRC9tNjFPTlA3d0lUOXFXNnMz?=
 =?utf-8?Q?OXjM/q8OXth6V9S0P9BGFQrd9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f4078a-7ae5-4a5e-160f-08dc4708e620
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 05:04:32.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM9Aix36OhneNRNd/ZFgwU8kj3c8D5U6PgCVAu44oT4iNSJz0UoM+/CquD/AiacTeDfHelZKM7LzNcfw0hDZpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059

Hello Shrikanth,

On 3/15/2024 10:26 PM, Shrikanth Hegde wrote:
>
> On 3/15/24 7:25 PM, Swapnil Sapkal wrote:
>> In /proc/schedstat, lb_imbalance reports the sum of imbalances
>> discovered in sched domains with each call to sched_balance_rq(), which is
>> not very useful because lb_imbalance does not mention whether the imbalance
>> is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
>> from /proc/schedstat.
>>
>> Currently there is no field in /proc/schedstat to report different types
>> of imbalances. Introduce new fields in /proc/schedstat to report the
>> total imbalances in load, utilization, nr_tasks or misfit_tasks.
>>
>> Added fields to /proc/schedstat:
>>   	- lb_imbalance_load: Total imbalance due to load.
>> 	- lb_imbalance_util: Total imbalance due to utilization.
>> 	- lb_imbalance_task: Total imbalance due to number of tasks.
>> 	- lb_imbalance_misfit: Total imbalance due to misfit tasks.
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   Documentation/scheduler/sched-stats.rst | 119 ++++++++++++++----------
>>   include/linux/sched/topology.h          |   5 +-
>>   kernel/sched/fair.c                     |  21 ++++-
>>   kernel/sched/stats.c                    |   7 +-
>>   4 files changed, 98 insertions(+), 54 deletions(-)
>>
>> diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
>> index 7c2b16c4729d..e2a6b53a38ee 100644
>> --- a/Documentation/scheduler/sched-stats.rst
>> +++ b/Documentation/scheduler/sched-stats.rst
>> @@ -6,10 +6,15 @@ Version 16 of schedstats changed the order of definitions within
>>   'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
>>   columns in show_schedstat(). In particular the position of CPU_IDLE
>>   and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
> Size of the array would change after this patch. So this line can be updated.

 From this line it is not clear that whether it is referring to enum size or number of columns. I will update this in next version as enum size is unchanged.

>> +Also stop reporting 'lb_imbalance' as it has no significance anymore
>> +and instead add more relevant fields namely 'lb_imbalance_load',
>> +'lb_imbalance_util', 'lb_imbalance_task' and 'lb_imbalance_misfit'.
>>   
> Rest of the changes look good to me.
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

--

Thanks and Regards, Swapnil


