Return-Path: <linux-kernel+bounces-28317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72882FCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B13B25DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A5C5FF08;
	Tue, 16 Jan 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VPepfY2q"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74C3C489;
	Tue, 16 Jan 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441174; cv=fail; b=sBsKGwW2XOs9+j3Dl9nsWp/6hvwgzuUAxR8mZ/gW57XUMTgeC5pVUyrMQz+EGfzydKHn94vwIIwDYtGsZ4Yt7/0kcr+09vq3JnukWU7bo+UnDUbHfRFDQhzYzN7N2btUqUjXz3bZjmnwGj+f+rO+bw1xOmToNCZeUd0ijDmDwqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441174; c=relaxed/simple;
	bh=a6XdV5wI+GE5JvdFvHEQSYQ/lnX0lgRd63O945kQNh0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=bl8pDfdLMHv6f5zVy9R9NTwB9EUTUDhz2SodOVPNiW9zAJfhv/xG6Iow/x2YnxKMwL3ZUiMB8rVbXTBIQLLIbxScqcocK2f32p5ZV6DY48k8azCaLoeR1PdkmH2bDbD9f94/1NYnWESG0zu3TFuPsy5aPp5J9VZJoX0JDT3tlTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VPepfY2q; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXbia8wAzs/ku6raZaAtfQDAKj9UdNjvm4S/f7T/GJtkGOIOdbpScF2ktbghZVraIJhVPTD4Yp/3AVL3cFIhjYu19nxPR9Flw0pGBtwUs3GX5NbxbAamCbiK1Rq57TGy7RGjJyaEMXJC7uovQMiKDeIUab0Qz835EmgMwoQIYsfcErUbcPUSwEVauwVb3ITw17LjfbW2qRF1mU6shzSzdA89+vtZsaRC55PYffGOU0vXmd6GzKmDhqbgoSPP/Ioqoew4odHwO1SRtF/snr2Wm4z8vlsU8f1PV/p83NzLrJCoWDim7pk0tbs3gYg/ldsEwZ6/Fd/g8GCmcOSpsEviBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcWpvGKEyZgUsZ4YgJRJLhk4mnd9qE+RdLCK9aw0G+8=;
 b=P7YyPEfIfzXRCyToZT3hLGmSoA0vXPFKbj9v51ccO48RJ7PWL28TxAJgSyObTNqy2RyTdvOjpe2s/Bo3AXILEJZ1PsIe/y6QBHsoTYoQW2qjAeJHpPvR9nUR3XAVozKziJxTJWbq1sYLPzxj7hEQaATiSEvp+ocvu2342zWoTp+d2jhzXMr6+rVmhkoQf/AFPywiMGsjBpE/Zy518FhHPaPlcq8/o28mY7lWNz8cPDPi0dfi18sjl1cnvXhAnuzx+iFPD/242OWOH0+03hMHLVnBtaOQiN+a/ZCByv8QhY/+oQmO8xnFzfHqQn8xA4cKKaN6ksyluouP0Sksd48PtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcWpvGKEyZgUsZ4YgJRJLhk4mnd9qE+RdLCK9aw0G+8=;
 b=VPepfY2qi0biR9zmDxEhkHI2JdXk1SJxaHApz1FEnv/T2AwLVUdsaNmPTxr4onVvu2ucm7P9N+qX3iid7ssnPLZdMfdP69WkrVDNdzkYmzLQXJadNfe8bObOilaFRRSJ9oXXZGB1yNxjGxjNxjFTeQ/LS66OibNVpvSaCyD0Xx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 16 Jan
 2024 21:39:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 21:39:30 +0000
Message-ID: <e8f54e2a-8524-7fde-e31b-8da9126ad292@amd.com>
Date: Tue, 16 Jan 2024 15:39:25 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 2/2] x86/resctrl: Read supported bandwidth sources
 using CPUID command
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, seanjc@google.com,
 kim.phillips@amd.com, jmattson@google.com, ilpo.jarvinen@linux.intel.com,
 jithu.joseph@intel.com, kan.liang@linux.intel.com, nikunj@amd.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, rppt@kernel.org,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, peternewman@google.com,
 dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com>
 <e89278a8-cd40-4e73-ae39-800c29dae385@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <e89278a8-cd40-4e73-ae39-800c29dae385@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:806:6f::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6967c5ee-47d3-48dc-0b1f-08dc16db9f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YTU9lTj+Y6Tp1/3M8G7bHv0gEizWggc1Ld10mpPY5xmobs7UUiB4kOJh4Iy6NnRaF9+GFi7wNmY2OEIkYgP/f0HXrEQfXs0GqBGAnWHkpTMJgbaDwJh953dZx3pV+sgDo8lPaFXGzwXWg47p801baTGhiTBLaqOl9347LC/yPySsOYHlsb9zmQBDLv7bv9m3oh2hx5TYMeSrlKdG3bq77+17LAPHcD6DsMZkMly9FBIZ0PvvJA8AiC23aq1d1y2VtOdxa3tXyOGJZmT9gintLUeN3IuQ36cOoKxOun+tak4zPnLqBAdG9RpZxZd4w2u2Z6/+s4MJkw6A1OZAFY0YPKuvflwJNwqVPKbfDd9mrFXCeq5iDDJ0c8rC68c0TaEV9MsK6iNKonaYzjPVA45g7912nr7aV67A7nxh+MOd5ByeTP8mPHr+vN+1x8JQOuVHI+8MqBTjPbbfhGLvzY6fiDxm2NPXKrhnJuidLnv7vKc4n04MY0Wz7I3alPCvT9Im65RY5L/1sHLmr39eDtssCS0jn6to/vsmK9Lv4QC7DSrRXHIhPS1EzzXydpxLHCpagTl/ci6cbE1l4Qp7J9/g5VXFp0UneMJSjANqsoOu5ldf1Ag5tJmR/3d3o0L/QkkG0fqCM85jTuAem+q+aDSR6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(6666004)(966005)(5660300002)(4326008)(7416002)(66556008)(316002)(8936002)(66946007)(8676002)(66476007)(6486002)(6512007)(6506007)(26005)(110136005)(2616005)(478600001)(38100700002)(53546011)(41300700001)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2phVU5DY0hzK2UxUjFuQm5McGNia0hWZkhNTHl1TTlMcnljaDdjNVh4eVRx?=
 =?utf-8?B?cUZ2TTFSMkd6T2hUcXFIdkxhd1Bvb2g5bmFVTUtQaGFMQVZZUmNuSlJaaEJu?=
 =?utf-8?B?UHNHbEhSU3lObXBtYUVBOUNZTld1OW1pQkVOTnlkMzAweHdBV0FvcDRrMkdG?=
 =?utf-8?B?QVRkQUVEdWROQWZkeVI0Rm0xK0phSHhnQURTL1pmUytYemFlTkZ1M01TUzJC?=
 =?utf-8?B?RjlqS2dsTHhBUlZJVXlPUDBKVkpSL1l4WXp6b0tlc3QvZDNHeStMN0ZYdW1S?=
 =?utf-8?B?RFp0VFhScTVLc0w3R2JQZ0hPQ1J2S0FuczlFM0IwR0RRTE9hcnBEejhMbkJv?=
 =?utf-8?B?d0FudWkxVks5S1NNaVhYTHR6WGdUVnkvWDl2WE5uYVI5T2l5cjBWLzdFTGlK?=
 =?utf-8?B?b3hKaG1vdWgvUmJsalIwQXBpeVFOTmN2MkRTMzBmbFc1aE05R3puSG15YTNv?=
 =?utf-8?B?SlJ2eVVzZHMvSXljNkNNeDJSbWh0ZDVXR2RHV05UcFJRZHdLUUpEM09VeTdI?=
 =?utf-8?B?elc0VjlldDdZaTlWVlZPbkJzckhLN2VVZzFMdnpvUmgvUTdLSVZkQ3YyZ0VL?=
 =?utf-8?B?a0VVQ1F0OEZuMHZ5RFdveXRDMWV2Nk5VcTJXZ1o3aXA5bTVrTEZtT3BjMkF5?=
 =?utf-8?B?d1ZrTnlpY0NNcjl2dlFNYlltL0YxQjFTVDZLR1lmSUZWN0xDaHNpRTk5Mmt1?=
 =?utf-8?B?cWc5enpvYWd2R2Z0elJFWTVHWXRvaklZbzIrRDJjR3AySHcrU1g2WllQT015?=
 =?utf-8?B?RmdGOXMyRUxoZ3hLNTJhN0NURFpMUWZWOStiSWZBUlUxOGVlMy9KZFFXUGxo?=
 =?utf-8?B?SVNMVmNlUHVmckZiaGhaSURqNzJFR3haVmVsbHROS1NvTFloSnEwV1hNekU4?=
 =?utf-8?B?WENwTTV4QXUrdHR4ZkVoVjRTOStCL25CSEJuQUF3U1g2WHpsT2VxN3l6TGts?=
 =?utf-8?B?c09RVHZEaGI4WDBzemJYYnVjVXZnNHR2SDgrMFdVZUREL0dpRWF5WEU4Y2oz?=
 =?utf-8?B?QnBZYU1jNjdlR0pzN0pvMXlxSy8wR25haktzT1pHVEVERiswR3BGWFV4bUZI?=
 =?utf-8?B?NHd4Z0lEMEc4UVBmNlhBL1krNmZySWFVdnNUUzlVRXNIL0d3Z0ZZQks1NHdu?=
 =?utf-8?B?azVyeWU5UmlSQ01kZzlXYTd6ZWxwWWZha1k2MzcrQjJSMzcvWGd0M29yWmhI?=
 =?utf-8?B?YXdVVWNpbHBHdVJkMHNXL0hlOUwrbXFlOFpNcFExNTRTc0syZ2I5ZkN0ZWFD?=
 =?utf-8?B?YUNoYUYyaW1CZzFMMFQ3dEhvdUFmR01yRnFvMXNRY0hpUVVIcXpMeUF3QktE?=
 =?utf-8?B?dnBSbEJUMkR0RTBlTlFnOHpCdHdEUUYrd1p3R2JEakJOMUdRbnphSjJGakE1?=
 =?utf-8?B?Z1p0ekt1ZVhxNW1Bd2dlcFNxYXM3emFWYjhEeElHSm9wWkJJVzVleTM3TVdQ?=
 =?utf-8?B?aWNLSk5BRHBSQ0ljcXpWODBYZHRTZHQ5cUtlUTNvajJNT2dubWpMNU8rbjlm?=
 =?utf-8?B?eFh5TkV3L2U0b3hRMmVNZlZkUWM4dXZhWTc0SkV3R0lKY3Jjcy9nSWRhOVBp?=
 =?utf-8?B?eFh6QlZJNUxrK2xMcTdsQnR6K3VpRlptd2czalBZcWI0MDM5ZjdiMkM2Wlls?=
 =?utf-8?B?bll6RHpJT2NERUxuN2ZidTljVHV3cW92WGtYMmJTeHcvU2pwOE1oZldVa0Rr?=
 =?utf-8?B?N0xtMEtuR0tRbFA5M1doYXQ3U004UkFEUG52Z0VwVy9DVlFkYkdMTkJYRVcy?=
 =?utf-8?B?SThpb25maGx2cCtUYVFvbDJwQzhNN2tpaWtIYk9QQksrK0p6MUt1YzlXTWwz?=
 =?utf-8?B?c1JJei94VkRIcjk3RkppWWROY3JEaEg1RG5scHNycEQ0eDFzUHVWcFFGenc4?=
 =?utf-8?B?L2RudEVPNGI0ajNUVnB0bW9sZmZ3ejBpZmxoSG5hZ0pRWXJPTG0vNGMvcnQw?=
 =?utf-8?B?WVBhaTR0MDdvT09VaDZaemRrQ20zV3VVSzRlMDh2QTFodVM1bkJZdnk1bEh3?=
 =?utf-8?B?ZVJ1ekVVejFKalFtZkNWY29ZTFN0VGNFNk13am5KeC9Yb3M1SDcyVUpJWGNa?=
 =?utf-8?B?a2NzRTdWMmx2STM1WHEydU03ZTlNakdwTEIxcU9UQ2MwVjZldWVRak85YzEw?=
 =?utf-8?Q?x/5GGvkhOHfTQmvFu9X0kje06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6967c5ee-47d3-48dc-0b1f-08dc16db9f07
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 21:39:30.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM6UQTwE0gwpQqJYBu7ce7lzylbp+vDnjxpBkVeDFYBJFcAmOD5cN44Jagw6Cb4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997

Hi Reinette,

On 1/16/2024 1:44 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/15/2024 2:52 PM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured. The maximum supported
>> bandwidth bitmask can be determined by following CPUID command.
>>
>> CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
>> Configuration] Read-only. Reset: 0000_007Fh.
>> Bits    Description
>> 31:7    Reserved
>>   6:0    Identifies the bandwidth sources that can be tracked.
>>
>> The bandwidth sources can change with the processor generations.
>> Read the supported bandwidth sources using the CPUID command.
>>
>> While at it, move the mask checking to mon_config_write() before
>> iterating over all the domains. Also, print the valid bitmask when
>> the user tries to configure invalid event configuration value.
>>
>> The CPUID details are documented in the PPR listed below [1].
>> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
>> 11h B1 - 55901 Rev 0.25.
>>
>> Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
> Thank you.
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thank you

Babu Moger


