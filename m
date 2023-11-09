Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67267E6C07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjKIOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjKIOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:05:51 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E84E30D6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSTkqY9Zqcg83V274cbJelX+dP+bsOV7eEYAljM3o0dTSFzCOPDADQLWYk1lB026k68Mc5I/Xg4yUrW+u0BPStvJbaM+nrZxUyJ7VZI3AftDuFE82hmu7qC7oGdIGIYrQws2T2xmqwwXMbbgA5ADEXFqIFC5/SKXlrsKREDsgBY4roebKAvzDKcm56x2cpmS+bVOBHGWutFq4i6MocRFXZXa4pysZF+bm7/TOX8sXnZkwV5bYsvFcPcjvs3RgF+mitVHgTmhJlqaGzbA5r3fstWF5DobUvyTCbIk+R5zyu0ctj2kF9/i19Td3dp89jO4w33KdXsQOQqPm8m1d6XVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHbmGxdkEarfSvTSr05Oe5lAfK/TEZTHGDXcia+f660=;
 b=OHPKAohdJ+cswLAI+EguFhJguBIVeNLovoY40XPz7zxyFooBLwFsiJvMpz2UExXnJivulYXmlGShXsnUlHSq3cslYFOMeftc27TPvjele6nGfQLns9rESGWdzL98efOUFblq1uFPaX8V2vIvH0EjNCLWIKgZ2UHt8ACSYugt9v1AU0Hjc6X0o4nw9GTjm29C5lNghuSwMH5vJWH3lRhxrZy9ZDGcJYTVvJIM7DIa82/ekSrPehgMhRBx5kfmBs34RvS9+FY9xra6kNB/jwfJGaLhHpmV1Oujtdk4Rk3EWTvKxOj+12yybo9hYn18p1TzQmZwFE5ixBw/QJctB4Y6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHbmGxdkEarfSvTSr05Oe5lAfK/TEZTHGDXcia+f660=;
 b=f47CBtIGNBOsvJmwO0VcWdsf8mVwoKtGBzZiBAAnnNBfdVKDt4UJEy78qQaCTNex+Rz+E1MUhSUjuPXV6z06bmYwlFecu8mjeM79hJS6FBN5MI57pNT/Aw/GmhNLEx4kDxd0sHmkhM8VFWT4nCqdxQjhDpA/Cfxzpn2l8fGoaJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 14:05:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 14:05:43 +0000
Message-ID: <57bdfc66-2030-4357-9fc5-56f5a0934888@amd.com>
Date:   Thu, 9 Nov 2023 08:05:39 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231025180345.28061-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:805:ca::42) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: f2536140-190c-4ecb-55c0-08dbe12cf64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGdy6TDyHlzStHovCPlt4bXrG9Pdhi+ZSjqXZ66xbVTtiDH2gKWpQBgzrfzllIdGijof9wGCW04ZgDvIW/MUYS8QEwSjH56rTMk7xKcZVeLJkpHdu1xXyOdzc6AV+BHVAEVr1R8rl6s1iB6GV8owDlL6NYmBB7UcCHfjjAJWfy7kM9PR8qka839Hs2hBRJW02b0pJHQfeQuayLDrM2EkrvOdfiPBwDMbWOxJIy2agXSb9wiVj17KLGR+o1JAZxX9qhs4UOt0Nkb0QtMiMo0U2+vKW3X03ZCHSGn73Z6+w8SWWgEj3JoruKBwRDE6yt7HozVAK3p7uAEND+5S1ZZT8S6rP5PTLVLTcSA9xFacnWCJOgg3uijE+wF7M9yrfu0ny9Pg39UOczutcI+tCXcLHEnM+z4DWzz185ASnDNojzA7Hcq1lbjoO+Y3aN0Yoyel2xAJ4gwQYEULlzvBB/I9LqNeWAWsRoqXMv+cb21Bj0N3euEkZde0yZkONdhC0g9JkoZovCxz5UXDpu6IDKTd9GBusFmlZwIDp0wQ7QY0lUpKOQ3Qfy1ISrFis1x+FxJBBqKjT+ZME7njvGAV6hikeXzefUymw6MRmo4kbN8TW8IGV6jkT/2zmtBf70U1C4gW3w7tzb74Ze4Rx43gxlg6KkHRii96OLD4iaAPbF8TqaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(8936002)(8676002)(4326008)(31686004)(83380400001)(6512007)(38100700002)(86362001)(31696002)(41300700001)(54906003)(2616005)(316002)(36756003)(6666004)(53546011)(6506007)(66556008)(66946007)(66476007)(3450700001)(6486002)(966005)(7416002)(2906002)(66899024)(5660300002)(26005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGpVV2Jad3VhK3daSmk2Nkh0ZXVCa0ZqSkNta3lkcFZxUEJEK2QxRjIxc2hx?=
 =?utf-8?B?aW9JUWZuRVd0bEw2aUc3RFFSZlBkUWQ5RW5WNEx5SnpRUWxpOWtoNlhSQ1VX?=
 =?utf-8?B?UXc2cXlsTHVWemJhbUFYcWJQaDFWakNGZnA3aCsrdDQvd3JyalU4MHlHSDRy?=
 =?utf-8?B?Z0p1MDcwVHNRZ1NNOXVNWDd1L3FLOGVXTmtEa0tmS2IrM3lvNTh1Y2xWbWR3?=
 =?utf-8?B?N3c4OUJ2eHRKNjMyV2ZscjF6ZVVjWjNuTjNaejJIZ3RsMitqUEZ1ZEtNcjRz?=
 =?utf-8?B?RHlIU3hLR3ltdWd4WjNQYTRXZkh2Rkgzc2F5V3MveU4vaGFzdFl4aUNxOFpi?=
 =?utf-8?B?d0ovd2JIaWc1NHdFSDlCYVR2Z1M4TzV3WmJEdlRuZ1dlTDVGbkxXNzFMWUw4?=
 =?utf-8?B?Um1mTGhNSGVIY2Z5ekhxU2swWGpXTWhxMk5OV1htY0cxN2RuSjY2SjJRdXFm?=
 =?utf-8?B?b1YxYjJ1NGVEUlFiS2wyL0Q0VGtQdWg0azRORHVEVzhCVjU5aWZZbnBsTHds?=
 =?utf-8?B?VUlGRmlnRDRGVXh1aHd2ZkVsaURsRW5RYVpPK0w1UUx2UE0vUEVBOTVOZG1x?=
 =?utf-8?B?UFZzQ2pUNzg0ZC8rY1hHaWRVSzQzQkx5UFdqSE1kMERoMW44S2dKa05nbDhM?=
 =?utf-8?B?d1FkQlJqVFlKVnFFZVVsVmFtL3FHeHkrcEdvb0QwbG43Y1JDMXhNNkVWVGNL?=
 =?utf-8?B?Y2djV28rczJvaDVRTzE4aUVEc2pNMllMci9PREpnYzQvdTBWd2dNSGNQd25V?=
 =?utf-8?B?ODlaeWNERk4yK1V5TWJjQ0xiUXVvNklGOHhLRzJzVWQ1NDMxdCtKNzdDSDBn?=
 =?utf-8?B?WDFtMTNXU0xObUhVWCtZZlhVREpRMHlkOHE0aWRVRXBKeXpFMURpOE5PSkFj?=
 =?utf-8?B?RllaVUhybGs4eWthbitrRnZ4OGloTWdCRXlBeTJSeXhYbVlLS0g5S2FmT3pQ?=
 =?utf-8?B?dnNaemV6Q3M5SXNBOTdzc1l6QklmY3NyckM5UldjSW1TbUF3bFAvN1Bsb2t4?=
 =?utf-8?B?dHVPZk50VWVwMnl1L2E1TVU3d1FoblBITlVzUWdnSDY0Q1YzQUw0RXRLQkZ4?=
 =?utf-8?B?eEZMSTRPUm1ZbU9yNFBUTHhYTE1mM0l3L01BWWRVanJHbDIxK2wwRzkwbWJ3?=
 =?utf-8?B?WHJmRnVWT3lQbjBNMmxyaWk0YTdTaXcwYjQ5cWZ3STlyYnJxWHlKUmwrakZ4?=
 =?utf-8?B?d3A2OEtMbWFlcnU1OUluR1ZPUjNWME1qOU1zUjJEOFA0bVVwVll2eE1Da3JJ?=
 =?utf-8?B?d3lGZmsxZGdXZlBURlhpcW9OempwUGFSdWo4REJjcVZwQlgwZ0Jta1NOQVRR?=
 =?utf-8?B?Nkw5NUdxMzFIU0d6UEE3dEdMS0pQcndMa0txdEoyM1YzRmZkYU9DVE9iMUNx?=
 =?utf-8?B?bTJaa1JTZ2txRDZXajFDWjlvSW9HaXJrNTRkdUtlbVdLY0x3V1dXb3lrQXh5?=
 =?utf-8?B?UTBhK3lDZHBqc21QQ3hJdElnRSt6Y3VqZlVERW5CcTFCcVZYVWZsSWlKekhS?=
 =?utf-8?B?dlB3SlVCdGx2eWE4cDJhU2JIWU1BeTBsSFpOaGpYeGlTUDN6TFlqV25ZdUtC?=
 =?utf-8?B?djRmQXpNVnpyaTBIb01aUEgzS1FMQ0dqOUlta0lZa29nR0NtanVZN2ZiU003?=
 =?utf-8?B?ZjZlZDRBaEE2RlVHTHEzR2thNHZSUlErTVloaUJQb1o5Mnh0Rldmd28yTXpt?=
 =?utf-8?B?MEVnN1FBS09YWDNpZUxnNU9qV21qNktPamFaNC9GamV0U1M5amRLa21BTkZu?=
 =?utf-8?B?cVdoYk5lVHp3NnRzYmRiMG1EL01pdlUvVVhuVE5Wdnh6clhTdjNDR050MnZZ?=
 =?utf-8?B?MFhwRTBhOUtMSklldHhpankvU3hScHBkMFBSZ04vSVRYMGhLSnFac2VzRFFN?=
 =?utf-8?B?TmM3aitkc3ZrUUpEMlBMb2taTmFsR2UrTHdqWHhjbEFCdXNxemV4eHZva1ZJ?=
 =?utf-8?B?UlIzNmtsalJVSUJpMjdXU0Y4dWdlWFFLZUtOMGxwcS9RY2l1Mm8wazJjNjE0?=
 =?utf-8?B?MGI2Z0hkbzIyZnJaMjl4VzlOWjlXUEErMy83eUhpK2J3a2tZaWV1Q2I0ekRi?=
 =?utf-8?B?UjRFMzZFYlk0MG4zQXRuMXdFK0xPbDNHZzlESmFsb0hFZnhIWmdhemtjOGFP?=
 =?utf-8?Q?FaQQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2536140-190c-4ecb-55c0-08dbe12cf64d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:05:43.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Rte6O9wJKw5rnbbCbQAfDQ6sjHxPF51F8RMnk519QIdfyiEr7Oi3gfB7389YnU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I have tested the series on AMD systems. Done some basic sanity testing.
Everything looks good.
Thanks
Babu

Tested-by: Babu Moger <babu.moger@amd.com>

On 10/25/23 13:03, James Morse wrote:
> The only significant change in this series is to add cpus_read_lock() around
> the limbo and overflow handlers in the last patch. Other changes are a mix of
> comments and whitespace, or code marked __exit.
> 
> Changes are noted in each patch, some patches even say 'No changes since v6'!
> ~
> 
> This series does two things, it changes resctrl to call resctrl_arch_rmid_read()
> in a way that works for MPAM, and it separates the locking so that the arch code
> and filesystem code don't have to share a mutex. I tried to split this as two
> series, but these touch similar call sites, so it would create more work.
> 
> (What's MPAM? See the cover letter of the first series. [1])
> 
> On x86 the RMID is an independent number. MPAMs equivalent is PMG, but this
> isn't an independent number - it extends the PARTID (same as CLOSID) space
> with bits that aren't used to select the configuration. The monitors can
> then be told to match specific PMG values, allowing monitor-groups to be
> created.
> 
> But, MPAM expects the monitors to always monitor by PARTID. The
> Cache-storage-utilisation counters can only work this way.
> (In the MPAM spec not setting the MATCH_PARTID bit is made CONSTRAINED
> UNPREDICTABLE - which is Arm's term to mean portable software can't rely on
> this)
> 
> It gets worse, as some SoCs may have very few PMG bits. I've seen the
> datasheet for one that has a single bit of PMG space.
> 
> To be usable, MPAM's counters always need the PARTID and the PMG.
> For resctrl, this means always making the CLOSID available when the RMID
> is used.
> 
> To ensure RMID are always unique, this series combines the CLOSID and RMID
> into an index, and manages RMID based on that. For x86, the index and RMID
> would always be the same.
> 
> 
> Currently the architecture specific code in the cpuhp callbacks takes the
> rdtgroup_mutex. This means the filesystem code would have to export this
> lock, resulting in an ill-defined interface between the two, and the possibility
> of cross-architecture lock-ordering head aches.
> 
> The second part of this series adds a domain_list_lock to protect writes to the
> domain list, and protects the domain list with RCU - or cpus_read_lock().
> 
> Use of RCU is to allow lockless readers of the domain list. To get MPAMs monitors
> working, its very likely they'll need to be plumbed up to perf. An uncore PMU
> driver would need to be a lockless reader of the domain list.
> 
> This series is based on tip/master's commit 6b7b1e57a824, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/monitors_and_locking/v7
> 
> Bugs welcome,
> 
> Thanks,
> 
> James
> 
> [1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
> [v1] https://lore.kernel.org/all/20221021131204.5581-1-james.morse@arm.com/
> [v2] https://lore.kernel.org/lkml/20230113175459.14825-1-james.morse@arm.com/
> [v3] https://lore.kernel.org/r/20230320172620.18254-1-james.morse@arm.com 
> [v4] https://lore.kernel.org/r/20230525180209.19497-1-james.morse@arm.com
> [v5] https://lore.kernel.org/lkml/20230728164254.27562-1-james.morse@arm.com/
> [v6] https://lore.kernel.org/all/20230914172138.11977-1-james.morse@arm.com/
> 
> James Morse (24):
>   tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
>   x86/resctrl: kfree() rmid_ptrs from rdtgroup_exit()
>   x86/resctrl: Create helper for RMID allocation and mondata dir
>     creation
>   x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
>   x86/resctrl: Track the closid with the rmid
>   x86/resctrl: Access per-rmid structures by index
>   x86/resctrl: Allow RMID allocation to be scoped by CLOSID
>   x86/resctrl: Track the number of dirty RMID a CLOSID has
>   x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding
>   x86/resctrl: Allocate the cleanest CLOSID by searching
>     closid_num_dirty_rmid
>   x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
>   x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow
>   x86/resctrl: Queue mon_event_read() instead of sending an IPI
>   x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
>   x86/resctrl: Allow arch to allocate memory needed in
>     resctrl_arch_rmid_read()
>   x86/resctrl: Make resctrl_mounted checks explicit
>   x86/resctrl: Move alloc/mon static keys into helpers
>   x86/resctrl: Make rdt_enable_key the arch's decision to switch
>   x86/resctrl: Add helpers for system wide mon/alloc capable
>   x86/resctrl: Add CPU online callback for resctrl work
>   x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but
>     cpu
>   x86/resctrl: Add CPU offline callback for resctrl work
>   x86/resctrl: Move domain helper migration into resctrl_offline_cpu()
>   x86/resctrl: Separate arch and fs resctrl locks
> 
>  arch/x86/include/asm/resctrl.h            |  90 +++++
>  arch/x86/kernel/cpu/resctrl/core.c        |  94 ++---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  48 ++-
>  arch/x86/kernel/cpu/resctrl/internal.h    |  67 +++-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 453 +++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  15 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 349 ++++++++++++-----
>  include/linux/resctrl.h                   |  48 ++-
>  include/linux/tick.h                      |   9 +-
>  9 files changed, 903 insertions(+), 270 deletions(-)
> 

-- 
Thanks
Babu Moger
