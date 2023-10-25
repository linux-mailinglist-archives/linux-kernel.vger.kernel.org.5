Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C437D7059
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjJYO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjJYO5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:57:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379C12A;
        Wed, 25 Oct 2023 07:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRmDu2lLmN2Hcjm1AU3jiCBc+4mrZLy+nzM9WT5Tlm6XQ0jkivJ8mc32RoD3heHZGgh7c1xNN1pQF3iTCs1ZsJT6GnuH4ihCm8dtz4NBwNK8T8LahNoO4d7lf+EcwEi+C0Sh1Shw616KpIC6IFcxsk95D9oJgww/ZVpIF+p/wDoTPmEegxbaOq5JMBtO935ykHWOkQowdE3I4w3HeV8bIHi6HmzAEVh2pqFa0UUKUrmNZETfMAiFmK6lBKVvGO3eSz44Ft+9+eMwA/pcPy9qKnxuOrnoqhdOjHvk82AhA26QD3iQCHWJsMBbavQEpygutTfMbuHqmqiJtLrQTIq5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKIcUYWgGiBymAj96RcyVMwjexDWoxZF9f3nGrZH5Ko=;
 b=IxGN6mfasSF4/YNwdqcS+kTVDQifhTrzps5EBJY+iGt96twNbt/3WQdZd5jF3OqnbnyzBRIlKm7BRV1r53+LXssoxktIaBnj3j33+zO9p1bpMoV4N8LyUEYWhX4Csp4sjPWmH5LQlS31BvBAAZkC2xNrk8engDA20IjYvKaxVP9RlH/NlGgZUOM6Ojp6Co9bQ5mCzu+8lrQoRQ9sKVrF5KD7delgohjVSBuQlZ1MsrxrN2+gb+Urt8JfoTTC9LMyKBbW/787kjq7hihocWfGLE9QmKGZbi3Ox+T4oHP4dcdD3vCSpeun+h9lsA5IHiWjqGwdiSQ/+RrrovutWLm86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKIcUYWgGiBymAj96RcyVMwjexDWoxZF9f3nGrZH5Ko=;
 b=WB24xZEUkf6B6m+28AjB59MLilMdQhZqc1pQS7lQ5ro7wEH/VS+Nc6G+KZq5aEfqN7Gu0zfXAKLlucq+qugCxhkXr3aN+3bwwYG+JNiUmzYTsfyoc7JoYi4esUOhQhPj35xWaULeNBCj7CqwG91pbP4iPgO0mfAwkgqwU3V+3yduptkvx7DDIyj/QA58qkfcz2njhu28nHXZhtLkvBzirrdq0v2gZbFLdMXNBimGCUa9QvnEakvJm4q71t5qEeFSrpimCBpglbXHcZPp3fQhhyl60S0bFPyi+8uYV7sV8NFaRr2EE01jmr1dCLZcGtaidLgM4w0bsZVjWSMfFmpCTg==
Received: from BL1PR13CA0139.namprd13.prod.outlook.com (2603:10b6:208:2bb::24)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 14:57:48 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::e0) by BL1PR13CA0139.outlook.office365.com
 (2603:10b6:208:2bb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16 via Frontend
 Transport; Wed, 25 Oct 2023 14:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 14:57:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 07:57:31 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 07:57:25 -0700
Message-ID: <28a6e60c-4492-105b-5fcf-3129ca868349@nvidia.com>
Date:   Wed, 25 Oct 2023 20:27:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] cpufreq: CPPC: Keep the target core awake when
 reading its cpufreq rate
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>,
        Beata Michalska <beata.michalska@arm.com>
CC:     <broonie@kernel.org>, <joey.gouly@arm.com>, <will@kernel.org>,
        <amit.kachhap@arm.com>, <rafael@kernel.org>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <yang@os.amperecomputing.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-3-zengheng4@huawei.com>
 <ZTjz2Ox_iqorbejw@FVFF77S0Q05N>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZTjz2Ox_iqorbejw@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: a42bd0fb-29c3-439c-7e98-08dbd56ac0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yd+bk/eYzxbYem4QZ5ReXbZR+OZ9x0TjA3mEHqYUpLr5a02aFLDXdzK/WORn4Atig/Hc5H4+QkEKmKsQ2YHkQBN414l/AQVN+rD7N0QG5+OoSFXDl7W5vPKkg/j5GvIKUPI/NqkWyHsZD8e0svQKl44PtyYrNWJDC8M408lebRd/OhdalfmE/bu54uP2/wqnCSLHg3Hm7QGh9qZbPBzk5PHPGwY3vb2xGh5WrLcT2pSbF90bQl0XTpeFUK+r6TbZ+uvL/TWrnA+4jDfD3mhx8eRxgfKBKjJOGYM8ms1FzXduC5C9zYKkkVGMuCysNdfEcIxaTx+GwplKN7cxxK84hsAHOYAU7CE7hsY8O+0UyeYJcRhjI5V01pxUDxAQQocspbkwORMN/HiNlaMYPrcyUHesHLQo9wbY7s72JqlItKVboPqadYgIVTNJNzUX5a5QVb6igk10bd9CUJ4ouoM/ndl7ICREwP8NzsrphqPPZ9vnAV/bTwEm5r0Xxxot0Xc8WSYkLi3nLuR3HN6FdA8iQ6wKpaClIiqDpBzdeI6SE3gIT3fmh0V0N3nVoi3+h/w2DOnYPPjE8stSPcSTTido0uMz3J8hptrM8JgkrNjpQBcZPUz5IZF7jCjcAQZHbgjIm3gAJ52UHJXlNTHW0Hid2PFgngcdViIYkeSQG3AJbi8p4NTRNkFLcEuB86XReCqZ91t9JTDH+mthEJjfmmdG/woJ4rutqBvPHDNIwoByqc3wPptHe8A/am2bgfW8EGmINO+CBdPDON0lfsEkBzksGMkriOrM5BAdO+YHdHrCMLhrRxbOaWLNqFaQCJEAz9iNf/ulwddz6w2r/c4Wgi0IYtK+UmW9ECaaZzo1yJ4EHhE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(47076005)(16526019)(107886003)(36860700001)(966005)(26005)(478600001)(316002)(110136005)(54906003)(70206006)(16576012)(70586007)(336012)(426003)(82740400003)(86362001)(31686004)(2616005)(36756003)(31696002)(7636003)(356005)(4326008)(8936002)(41300700001)(8676002)(40460700003)(40480700001)(7416002)(2906002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:57:47.7224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42bd0fb-29c3-439c-7e98-08dbd56ac0b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> [adding Ionela]
> 
> On Wed, Oct 25, 2023 at 05:38:46PM +0800, Zeng Heng wrote:
>> As ARM AMU's document says, all counters are subject to any changes
>> in clock frequency, including clock stopping caused by the WFI and WFE
>> instructions.
>>
>> Therefore, using smp_call_on_cpu() to trigger target CPU to
>> read self's AMU counters, which ensures the counters are working
>> properly while cstate feature is enabled.
> 
> IIUC there's a pretty deliberate split with all the actual reading of the AMU
> living in arch/arm64/kernel/topolgy.c, and the driver code being (relatively)
> generic.
> 
> We already have code in arch/arm64/kernel/topolgy.c to read counters on a
> specific CPU; why can't e reuse that (and avoid exporting cpu_has_amu_feat())?


This patch seems mostly based on my previous patch [1] and discussed 
here [2] already. Beata [CCed] shared an alternate approach [3] 
leveraging existing code from 'topology.c' to get the average freq for 
last tick period.


Beata,

Could you share v2 of [3] with the request to merge. We can try to solve 
the issue with CPU IDLE case later on top?

Additionally, also please include the fix in [4] if it looks fine.

Best Regards,
Sumit Gupta

[1] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
[2] 
https://lore.kernel.org/lkml/cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com/T/#m2174305de4706006e0bd9c103a0e5ff61cea7a12
[3] 
https://lore.kernel.org/lkml/20230606155754.245998-1-beata.michalska@arm.com/
[4] 
https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/


>>
>> Reported-by: Sumit Gupta <sumitg@nvidia.com>
>> Link: https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 39 ++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index fe08ca419b3d..321a9dc9484d 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -90,6 +90,12 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>>                                 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>>                                 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
>>
>> +struct fb_ctr_pair {
>> +     u32 cpu;
>> +     struct cppc_perf_fb_ctrs fb_ctrs_t0;
>> +     struct cppc_perf_fb_ctrs fb_ctrs_t1;
>> +};
>> +
>>   /**
>>    * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
>>    * @work: The work item.
>> @@ -840,9 +846,24 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>>        return (reference_perf * delta_delivered) / delta_reference;
>>   }
>>
>> +static int cppc_get_perf_ctrs_pair(void *val)
>> +{
>> +     struct fb_ctr_pair *fb_ctrs = val;
>> +     int cpu = fb_ctrs->cpu;
>> +     int ret;
>> +
>> +     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     udelay(2); /* 2usec delay between sampling */
>> +
>> +     return cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t1);
>> +}
>> +
>>   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>   {
>> -     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>> +     struct fb_ctr_pair fb_ctrs = { .cpu = cpu, };
>>        struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>>        u64 delivered_perf;
>> @@ -850,18 +871,18 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>
>>        cpufreq_cpu_put(policy);
>>
>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>> -     if (ret)
>> -             return 0;
>> -
>> -     udelay(2); /* 2usec delay between sampling */
>> +     if (cpu_has_amu_feat(cpu))
>> +             ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_pair,
>> +                                   &fb_ctrs, false);
>> +     else
>> +             ret = cppc_get_perf_ctrs_pair(&fb_ctrs);
>>
>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>        if (ret)
>>                return 0;
>>
>> -     delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>> -                                            &fb_ctrs_t1);
>> +     delivered_perf = cppc_perf_from_fbctrs(cpu_data,
>> +                                           &fb_ctrs.fb_ctrs_t0,
>> +                                           &fb_ctrs.fb_ctrs_t1);
>>
>>        return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>>   }
>> --
>> 2.25.1
>>
