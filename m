Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07E807499
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379309AbjLFPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379209AbjLFPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:41:02 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924D1E9;
        Wed,  6 Dec 2023 07:41:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDIcHRLE1xB8eVNrtgPJupjggBgE/qf1f6ZbBzUi74Thc93tiJR0spEiP0inLiAnhX9fWMYuW1M0aWk50mWA+DmCtHdC1S1vmmMqJdLpi3fiqGRWuCctuxociOPMH6pHcQyrNIwvfZTsrYNmNTy7HVde5cTd8mItDpRBKsGLRLTygSqQkJ6DUTzEqzvkHJ/8h/qqyeORVoWiP0n5sS791QC5vySOwjzKLz8NWe3GryNElxUJBE2FCCHGurpHWms4tpIEWFP0keCSxvcCQ/CdAr/e1Oax7xUhEcK9VcE976ip1LOvEPErw0EUutY8ZPZITfeH05ZgMSeli1bPJZwNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0bzaAFNbrm7AjAgAPazPsAwKxzVVB6QmSeHO6cjyKg=;
 b=X/4noFhQb2lyahiQk3Fp3iZ+N0vtCHJS+h/uBUfkkCQXh4xRX6BZj+QurWKVlKnoYHLGmqZPCq8XmPd9NkQL8EilVIXa/EQKqlzHqTmH9bEfCGlGsvPvwe87uh0H6hqJ7KpA6Phful9AmydVblWPZ0APWtUuGoMS6aINNG1u7Lf+GThMKI5iH7E+bn6gh2SynBDR0ZIHnlxbN8yQ2GcASdRHjQCeBKlFo4JPN7WljK8HS/6jl1tJ/gw5VFes/Yt5HdMqnO+YcbAQJIQ7LysI3Tmt9pAFCtvGpAqouzxxMmYc/LIDfLD3qv6/VsgL8IvRFjv9Ts/INuWSwe0oOdKB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0bzaAFNbrm7AjAgAPazPsAwKxzVVB6QmSeHO6cjyKg=;
 b=HIWjrAopHVNRGAYHs2TfQvDxE7WaF7bPmlmB37vsPR10+KjaFTkZ5euWMm715rqJ1FK5NmNfH9vS3Kv3T6AKFkgj2Vt8SCA4hSHo9L52PjCO+jqxIfqDU55YoY+aMVgqVF4Q+T5lCBCqZTUlpZHBhhpGEJProk0k/+bkj6ovTAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:41:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 15:41:02 +0000
Message-ID: <71e85bf3-a451-4adf-ad5e-d39f7935efa0@amd.com>
Date:   Wed, 6 Dec 2023 09:40:58 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
        seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
        ilpo.jarvinen@linux.intel.com, jithu.joseph@intel.com,
        kan.liang@linux.intel.com, nikunj@amd.com,
        daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        peternewman@google.com, dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:806:24::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6052bf33-a379-4256-cf9c-08dbf671c051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Fxt7pw+N//3OiQ8+Oyzr+TPWz53XFgMu4vdy5N7Fhm7KE+MB3oxPN/hvOEvIAE/z+MCKsZqh1CsSMx+hB1f31k/0TIUaTTQDi1I6Hnvp9JKcbN80cxpEwF4rXKWQIU3Dxn+/nO9ro1E/UGckzpFoXtOswbfkpZCRCbcgv2gforXnimDcZ4OzK1JG3RPXiigt0QHaOvtgAez3ZBGSHChkIUOyrDS7bWePz0JxnSsD/Ro88SyuxJ4gqycjB51qijG5rED0QCqC0phnbrn/M3jxCeCldxX/0+TVmIU7nE27dOeaRTNsJGSW1oHxz2i+a7r7z3xZYWRLGz9f2KK/PiQuQRkA+WAasAI+yZHzNM1tXxl4KdrTkd5tXKt1mVfxjX+gsmwi8T2UhSEkcfHJ+dUdwWj1P0yoUPjnoCSdQYMJ4jjHGOutW7C1emRlRf3Y5X4cG59IWosXkcbFlsmHHshqEviYImoA7Tvft+4bXsuHH6OHmUbkOVG8+fpuHkO8oX/MpSOnpWp4bE4ONUFNx3KkTcHdw4n0SvmQhCLlClMG6BS5vHTb7E/V7UiHBwck4GNIuG1NMkizFljbfUv8oqKbkqcXuxja/uwGgi/pkTFMCfzhqopoL+Mjwh9O3SVQMDs7WjhN2AMSBdO1efFTyX3+N6WntzaoFYh6SBAg88Fy5WIBQEYyoWJoAGXmVAmpcJk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(66899024)(6506007)(26005)(2616005)(36756003)(86362001)(31696002)(38100700002)(53546011)(3450700001)(83380400001)(7416002)(5660300002)(6512007)(6666004)(8936002)(8676002)(66556008)(110136005)(4326008)(66476007)(6486002)(966005)(316002)(41300700001)(66946007)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlU0akhWWHVYN2x5dy85VDl3dGdkdVZUdUVSbUM0Qk1NWGRzQ2E2NTgvcGZI?=
 =?utf-8?B?VmI2MmJFdzlFcGp5eUprQmZLenJUN1ZiU25CaFdVM3l4OXZQQzRuOXI3T2xH?=
 =?utf-8?B?ejFuUUMvd3Y5cVB3VDQxcndKK0pKbUFDcUlGTXp5ajRSeUs4ZzdncEc2VEQw?=
 =?utf-8?B?dzNkVGdFVmdKVzhOR1BXNm55T0kwMXM1ZDBxUWhCL081azEwMnRTbWEyK1pI?=
 =?utf-8?B?VGVDa2g1OUpac0FJWHRlWmI4QmNiVVZBNmtCR1dBSnZsUWd4TXQzVWNqQUE0?=
 =?utf-8?B?VTNxSkdrNmJLeFFaY1dxb0NiR2dIWEdlQjdBY1JvSVB2SDR6cGpROWRqS05M?=
 =?utf-8?B?OGhvOGNxUjRKTmovVnppTlFzcWdORE05Sm1UVDJHek4vVGFYUTVFY3RwY3JD?=
 =?utf-8?B?aC9qTW5VRVZqK0VrOTVPTGpHSGV0ZWFKS28xL3RzdU9qSmFDTTJhdlV6Qzkx?=
 =?utf-8?B?dTBUMlpuWDcrTUduVEtyS09ybzlUdEtxUlp6Z0NaN3pVODlBRTZ0QjdNVVEy?=
 =?utf-8?B?bzM4Z0hPQ3hwVzZFcEJmTml4QlYweU94VWo3U0JzV2p3K3B4SVlYSDVpOURI?=
 =?utf-8?B?UHFybGdnVEdVSDB0ekFCcXZVZkRZVWtKMUpVY0xxdGpmc0NWL3NZME9LbGVS?=
 =?utf-8?B?WnVscG44MjFXdHBuVG9ndmRxZks2SDM3UkNkbUJmZmtOOVpncm04YXNudkRX?=
 =?utf-8?B?bjJMMVZCZEJiUnVLU094YjB1RVB0Q1Mxc2pZM0EvYk1xa1p4QUZNVlhVTEVE?=
 =?utf-8?B?aE92eXYyQlFqT3lxa205Qnhuelc4aS92QlZCanhCT3o3N0pUdEFNaWMyQWlL?=
 =?utf-8?B?a3BNSzdpVVpITXJ3RkdQRHN4Rk50NHU1WSt5QmR4R3IzcVdHblQ2M3Q3YVBh?=
 =?utf-8?B?eFFsckpRTW5GSmp2aWRFN3EvUGV5VXFXK2EzMTh0Z2FPLzQvNGtGbGQ5SHBM?=
 =?utf-8?B?OXpTOVNIQnlER25QQVZCa1l0MmdQckY2SnJiTXgxZS9Xa2o4R203NmgwVk42?=
 =?utf-8?B?RnUyN0dHOTFaNXl6aC9qSllyeGZ3MDZDTGtwZ0tuZVQxVjJJTkFaenlQNklr?=
 =?utf-8?B?UU9ScUUyb1JudzA2TU1yNlI5aHVNWTc4ZENJYTZubmRYa1o2WVd1VU5EdjE4?=
 =?utf-8?B?YmdOUlJNbFZ3VkYyNjB1eWRTdHBrNC9qYVNsTWVyMS9qb216cEM2NGRNR05w?=
 =?utf-8?B?RFZVZHVrbC9uYTFlNzBXbnM3Y2JCVFlqQ2tSWjU3QWpJWEovRkpRZnNZK1p0?=
 =?utf-8?B?THdnNllJN2ZFeHRaaGxLQ3NzVGJUMllET0xzMHdkOHd0UGhoWHdQcSszU1BN?=
 =?utf-8?B?cDUvYjYzc0lUOWZEVjRLYzhQaFJIQXR5V3VtMUJzQlByRmhEODZnL1IzM3FS?=
 =?utf-8?B?N0VURkJQZjlwYzVDOEtPTThWUnZ3OWhMUXlKUktDRlEyc1YxUWFOa1dnUk5B?=
 =?utf-8?B?OXdPSmR1VjlOUUpRcUN6czY3UnB3cVRGb0JPSHV1RTVRbUltUStKaC96ZmZT?=
 =?utf-8?B?WTMyc0hIbFg1Um01cllGbHNoMmxDZnptK0s0cW9TMHRLUzhxN01FR1R0Wndo?=
 =?utf-8?B?b3d0K3lBQ3B5ejFYcU5hSW01NVJtdHBhSldOSFhoOWc5T2tWOXhCSnV0aFdQ?=
 =?utf-8?B?VGU4YjBseUNWaWhlTkdiYTVEeFYyVzhBNGhLc2FxY0FiOG43akJndjlYeUZQ?=
 =?utf-8?B?eVZYaVMwMjU4a2hpVmdWNDRyQTQ5RGlCNnErRUxkMW8ydncwUHg0WjRDNXZw?=
 =?utf-8?B?ZVZlZTdubTZZWng1SjlXdC9KTXRCRkx4dDJGZmtvcVRRTjlsbGxQS0xDMFdW?=
 =?utf-8?B?eEFhblo5OUlUWGMwTWJHeFdpcldZUFBmVmRQSmFpTHdkWTFDd2tjckpibzc4?=
 =?utf-8?B?MWZKbU8zUlZkUVErTmFZSDU5OXF5NElrbUJQYVFqUXJZUUQrM2tlWmMyejdq?=
 =?utf-8?B?OEd2NEE0bGRlR1hhdlhZbTNjaGF3RjNsTUdxQzZiRmExQTBVcXo3UU5zTXBv?=
 =?utf-8?B?SWN4VWdQbGhJOHYyVVBwV2lGZWI5c285SjlaWEMzMHBaVVRHMHZwR1g2ZUZ3?=
 =?utf-8?B?ZkNSdFV0bXE4RUNJRmNCTEFwUkdyd21hM2s5VzJRaEVob1lJc2xzYXJpTzlp?=
 =?utf-8?Q?Hcps=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6052bf33-a379-4256-cf9c-08dbf671c051
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:41:02.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxqPvIC17ftPdMR2iWc4nSp8KOp6ser+tQuy9EhPnahH81zd6/e1rD3RuHXV+Kma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/5/23 17:17, Reinette Chatre wrote:
> (+James)
> 
> Hi Babu,
> 
> On 11/30/2023 4:57 PM, Babu Moger wrote:
>> These series adds the support for AMD QoS RMID Pinning feature. It is also
> 
> "These series" - is this series part of a bigger work?

No.
There are some some plans to optimize rmid_reads. Peter is planning to
work on that. But both are independent of each other.

> 
>> called ABMC (Assignable Bandwidth Monitoring Counters) feature.
>>
>> The feature details are available in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC). The documentation is available at
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The patches are based on top of commit 
>> 346887b65d89ae987698bc1efd8e5536bd180b3f (tip/master)
>>
>> # Introduction
>>
>> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
>> feature only guarantees that RMIDs currently assigned to a processor will
>> be tracked by hardware. The counters of any other RMIDs which are no
>> longer being tracked will be reset to zero. The MBM event counters return
>> "Unavailable" for the RMIDs that are not active.
>>
>> Users can create 256 or more monitor groups. But there can be only limited
>> number of groups that can be give guaranteed monitoring numbers. With ever
>> changing system configuration, there is no way to definitely know which of
>> these groups will be active for certain point of time. Users do not have
>> the option to monitor a group or set of groups for certain period of time
>> without worrying about RMID being reset in between.
>>
>> The ABMC feature provides an option to pin (or assign) the RMID to the
>> hardware counter and monitor the bandwidth for a longer duration. The
>> pinned RMID will be active until the user unpins (or unassigns) it.  There
>> is no need to worry about counters being reset during this period.
>> Additionally, the user can specify a bitmask identifying the specific
>> bandwidth types from the given source to track with the counter.
>>
>> # Linux Implementation
>>
>> Hardware provides total of 32 counters available for assignment.
>> Each Linux resctrl group can be assigned a maximum of 2 counters. One for
>> mbm_total_bytes and one for mbm_local_bytes. Users also have the option to
>> assign only one counter to the group. If the system runs out of assignable
>> counters, the kernel will display the error when the user attempts a new
>> counter assignment. Users need to unassign already used counters for new
>> assignments.
>>
>> # Examples
>>
>> a. Check if ABMC support is available
>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>> 	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
>> 	llc_occupancy
>> 	mbm_total_bytes
>> 	mbm_total_bytes_config
>> 	mbm_local_bytes
>> 	mbm_local_bytes_config
>> 	abmc_capable ←  Linux kernel detected ABMC feature.
> 
> (Please start thinking about a new name that is not the AMD feature
> name. This is added to resctrl filesystem that is the generic interface
> used to work with different architectures. This thus needs to be generalized
> to what user requires and how it can be accommodated by the hardware ...
> this is already expected to be needed by MPAM and having a AMD feature
> name could cause confusion.)

Yes. Agree.

How about "assign_capable"?

> 
>>
>> b. Mount with ABMC support
>> 	#umount /sys/fs/resctrl/
>> 	#mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
>> 	
> 
> hmmm ... so this requires the user to mount resctrl, determine if the
> feature is supported, unmount resctrl, remount resctrl with feature enabled.
> Could you please elaborate what prevents this feature from being enabled
> without needing to remount resctrl?

Spec says
"Enabling ABMC: ABMC is enabled by setting L3_QOS_EXT_CFG.ABMC_En=1 (see
Figure 19-7). When the state of ABMC_En is changed, it must be changed to
the updated value on all logical processors in the QOS Domain.
Upon transitions of the ABMC_En the following actions take place:
All ABMC assignable bandwidth counters are reset to 0.
The L3 default mode bandwidth counters are reset to 0.
The L3_QOS_ABMC_CFG MSR is reset to 0."

So, all the monitoring group counters will be reset.

It is technically possible to enable without remount. But ABMC mode
requires few new files(in each group) which I added when mounted with "-o
abmc". Thought it is a better option.

Otherwise we need to add these files when ABMC is supported(not when
enabled). Need to add another file in /sys/fs/resctrl/info/L3_MON to
enable the feature on the fly.

Both are acceptable options. Any thoughts?


> 
>> c. Read the monitor states. There will be new file "monitor_state"
>>    for each monitor group when ABMC feature is enabled. By default,
>>    both total and local MBM events are in "unassign" state.
>> 	
>> 	#cat /sys/fs/resctrl/monitor_state 
>> 	total=unassign;local=unassign
>> 	
>> d. Read the event mbm_total_bytes and mbm_local_bytes. Note that MBA
>>    events are not available until the user assigns the events explicitly.
>>    Users need to assign the counters to monitor the events in this mode.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	Unavailable
> 
> How is the llc_occupancy event impacted when ABMC is enabled? Can all RMIDs
> still be used to track cache occupancy?

llc_occupancy event is not impacted by ABMC mode. It can be still used to
track cache occupancy.

> 
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>> 	Unavailable
> 
> I believe that "Unavailable" already has an accepted meaning within current
> interface and is associated with temporary failure. Even the AMD spec states "This
> is generally a temporary condition and subsequent reads may succeed". In the
> scenario above there is no chance that this counter would produce a value later.
> I do not think it is ideal to overload existing interface with different meanings
> associated with a new hardware specific feature ... something like "Disabled" seems
> more appropriate.

Hardware still reports it as unavailable. Also, there are some error cases
hardware can report unavailable. We may not be able to differentiate that.

> 
> Considering this we may even consider using these files themselves as a
> way to enable the counters if they are disabled. For example, just
> "echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used

I am not sure about this. This is specific to domain 0. This group can
have cpus from multiple domains. I think we should have the interface for
all the domains(not for specific domain).

> to enable this counter. No need for a new "monitor_state". Please note that this
> is not an official proposal since there are two other use cases that still need to
> be considered as we await James's feedback on how this may work for MPAM and
> also how this may be useful on AMD hardware that does not support ABMC but
> users may want to get similar benefits ([1])

Ok. Lets wait for James comments.
> 
>> 	
>> e. Assign a h/w counter to the total event and read the monitor_state.
>> 	
>> 	#echo total=assign > /sys/fs/resctrl/monitor_state
>> 	#cat /sys/fs/resctrl/monitor_state 
>> 	total=assign;local=unassign
>> 	
>> f. Now that the total event is assigned. Read the total event.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	6136000
>> 	
>> g. Assign a h/w counter to both total and local events and read the monitor_state.
>> 	
>> 	#echo "total=assign;local=assign" > /sys/fs/resctrl/monitor_state
>> 	#cat /sys/fs/resctrl/monitor_state
>> 	total=assign;local=assign
>> 	
>> h. Now that both total and local events are  assigned, read the events.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	6136000
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> 	58694
> 
> It looks like if not all RMIDs asssociated with parent and child groups
> have counters then the accumulated counters would just treat the "unassigned"
> as zero?

That is correct.

> 
>> 	
>> i. Check the bandwidth configuration for the group. Note that bandwidth
>>    configuration has a domain scope. Total event defaults to 0x7F (to
>>    count all the events) and local event defaults to 0x15
>>    (to count all the local numa events). The event bitmap decoding is
>>    available in https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>>    in section "mbm_total_bytes_config", "mbm_local_bytes_config":
>> 	
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
>> 	0=0x7f;1=0x7f
>> 	
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
>> 	0=0x15;1=0xi15
> 
> 
> These would not be available if system does not support BMEC. From
> patch #3 it does not seem as though ABMC is dependent on BMEC.
> 
> Is ABMC dependent on BMEC or are they just using the same
> config bits?

Good question. They dont have to be dependent on each other. To keep the
rmid_read interface same, we made it dependent on each other. I will add
the dependency in patch 3.

I have added explanation in patch 15.
https://lore.kernel.org/lkml/20231201005720.235639-16-babu.moger@amd.com/


> 
>> 	
>> j. Change the bandwidth source for domain 0 for the total event to count only reads.
>>    Note that this change effects events on the domain 0.
>> 	
>> 	#echo total=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
> 
> typo?

Yes. Cut paste mistake. Will fix it.

> 
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
>> 	0=0x33;1=0x7F
>> 	
>> k. Now read the total event again. The mbm_total_bytes should display
>>    only the read events.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	6136000
> 
> hmmm ... seems like there is a need to make the MBM events configurable even
> if BMEC is not supported.

Yes, in ABMC mode. Will add the dependency. Will use the standard mode if
BMEC and ABMC  are not available.

> 
> Reinette
> 
> 
> [1] https://lore.kernel.org/lkml/CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com/

-- 
Thanks
Babu Moger
