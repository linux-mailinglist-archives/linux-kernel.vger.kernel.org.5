Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388F77CDCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjJRNGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjJRNGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:06:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7565B10F;
        Wed, 18 Oct 2023 06:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWBK7xL0pcewK9g7f7okcTvLaGZCigTPYrxyDVBzSiEgA8/72AhcoN5XWoikh7zd8IU6khX9K+v9aUe4UUI5MAeDm4BmogDFoSDmH0HZTvU+230JPOxJA+y+SkYZnecqYWnk56sdYTJTUW3liW5i29M1nMfuBkyvQBezxKFbkaXGGEZespinVgkjisPCwUc23qZJKZTi8mYkq7E1+VV7zaI7fuLxgoe37YqV6LB1/sQDq+hO0b4m21CTXXFqBVW976VbnDvjypJCIDyw4AhNolIjCoNqS87cv/vPTY75RQMjVPOTD3Q+UMnG2EDfC1XWZTrJt10Q9OaMuQAfefmx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mgc64HneaXWmkf4iLuq59ahhL/P6EBbY1HjvRfgsrUs=;
 b=Y9pG8gsN7GbYhGjdvnKeFUgfbTczZcGiwdIzenkbE3yeWR5Ma2zq4Rv0xGBmbhGQs7b84eGWrNph9BeAbMuyDgh2HrQN5+IZtBdcuqG0YD1SggE9Z2tMWE6XIYeNuLZlPE7MuWnI8tNFIMbDenQwx+Vwo+ooTUfo7vmnmwMHjG0Qu4YG0Vqu8E+MPgeSDpa1Ynsf92HJZMDj/oNSZVA7y5BlTBhqX36M57dt9ZsOkmpGr3q2zQxWfjhQcltZImegMeEyCTf9B8i6vlc/gk9RYOrQi6atMdb2ncsJjiluK4ZOi/7i/y5w1Xr34gjgNOB0paOkLJSnhtYJH5GkOUvxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgc64HneaXWmkf4iLuq59ahhL/P6EBbY1HjvRfgsrUs=;
 b=Chwz6mW7a+cjv1vXN9nHbljY5g3i6kmv5U+Y2DrKY2kYrOzvLwQjHdobUA//B7N7iJW9NA53CQ+TClNo/9Pyt8y+WUOzxTesRkVSA/kpRvhdLt9+p6/ZkI4SUu4h+bNlwgWXh2XqCljIQ50sXLHfUR9iwZjo3ZHs+FcSaw7mVd2g+HCUSZiPmKrq0UjaAQf3VgfOISPhd+DOu7xZLH16oQGMRq5dgDldstXXrguac+bbk81v2Qg+dow96d92s7Md14BnFBWfH4r47cSZDVgWMY6eYcO5L8UPTRCQYyK3ZBM9zN+6kOAz94K00dfKMcML5d7UAVoFWoiaJWXh6NMcqA==
Received: from MN2PR20CA0031.namprd20.prod.outlook.com (2603:10b6:208:e8::44)
 by BY5PR12MB5512.namprd12.prod.outlook.com (2603:10b6:a03:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 13:06:09 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::68) by MN2PR20CA0031.outlook.office365.com
 (2603:10b6:208:e8::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Wed, 18 Oct 2023 13:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 18 Oct 2023 13:06:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 06:05:54 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 06:05:50 -0700
Message-ID: <6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com>
Date:   Wed, 18 Oct 2023 18:35:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Content-Language: en-US
To:     Beata Michalska <beata.michalska@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
        <will@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <sudeep.holla@arm.com>, <ionela.voinescu@arm.com>,
        <yang@os.amperecomputing.com>, <linux-tegra@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        "Sanjay Chandrashekara" <sanjayc@nvidia.com>
References: <20230606155754.245998-1-beata.michalska@arm.com>
 <8e755438-4b1f-b3d6-b2b8-a5efcca813bc@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <8e755438-4b1f-b3d6-b2b8-a5efcca813bc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|BY5PR12MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d88439-04db-4a34-4861-08dbcfdaff01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69nCBobvn1xeUG27TVhMzlBxrZpJoIcEKKeQPxMHKCtatGAHrFVzqouVEkU0KYcLDP8vzEhOQ/U13TDbv5cllv3IAdk7eKYTHgz34uH+CmYwvzFxPL6+0ixUzEKvDzm+P5zpkU4jF6FKAIBYKg7DGkKz68YrpSToZYeP8QED+w1ezcL22RcG/byqmbvGPZpGePMR5LNmMODZMnN4Cxy4Pw1b4EXmM/hZW79NNsb0CKKglJ8TM1ZisSZQKlRz4IYLOWx7WtNZQiVnqFKZ9ir2x8JetyAv0YKfEZTnq1lnk8H3djjjhZj6jpIkVKABZSXgrMxCHHQDlJ7b5+XCVSFBoyWo4rlXHhfgydZr8bmDY033KrBDUCqRjJqh7UKzRMksxu1lQogjhpynQVLHhfon9IE9wbvpgSqLjS9oh//KysUz7Bs3aYaxb7pAbTCCv8JPdvM3YViR4JP7u2u2R09M/EQ/cRLHlfZ8QS1Q3SfNqZvatBl0NiwNxPEuSUUbNnZrTmUNOtafA3pnXOZXRIyjOMNor0cUR8bTi/Q53sb0Y6nziLOof7o4k8KtFzjec9quEL3nvruxl+MUMSUZnFXJzNWA+oTI/EVA+wQhy494fze/2TsRcK/7Qx1ZiIdME/VSV2hMQ1+hhdle18COqRC/eZ00E00dB/03l7YepnQMOKdGJH8Jdb3350g42r0ZhdPyJCQgu97ZjARq9ZG+ApuMNLSFyQz5+2rQua3FgWDUCUK7A6qFYhJ0hLSuHi7EsxYEm0+U4ZpfcL3JZahqCh16DmYw/0grro66VfLBnRVmJEbKiccDJI6fhpDQiea5coUydom+yjDHTnoeNES2z17Sqf9boJdQ70LbxobNj59lhaSGTtYtAcji3D/sikd6s3Sm
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(40480700001)(40460700003)(107886003)(36756003)(2616005)(31696002)(2906002)(86362001)(316002)(16576012)(110136005)(70206006)(41300700001)(54906003)(5660300002)(7416002)(70586007)(4326008)(8676002)(8936002)(478600001)(6666004)(53546011)(966005)(336012)(426003)(7636003)(356005)(26005)(16526019)(82740400003)(36860700001)(31686004)(47076005)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:06:08.8807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d88439-04db-4a34-4861-08dbcfdaff01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/23 00:29, Sumit Gupta wrote:
> 
> 
> On 06/06/23 21:27, Beata Michalska wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> With the Frequency Invariance Engine (FIE) being already wired up with
>> sched tick and making use of relevant (core counter and constant
>> counter) AMU counters, getting the current frequency for a given CPU
>> on supported platforms, can be achieved by utilizing the frequency scale
>> factor which reflects an average CPU frequency for the last tick period
>> length.
>>
>> With that at hand, arch_freq_get_on_cpu dedicated implementation
>> gets enrolled into cpuinfo_cur_freq policy sysfs attribute handler,
>> which is expected to represent the current frequency of a given CPU,
>> as obtained by the hardware. This is exactly the type of feedback that
>> cycle counters provide.
>>
>> In order to avoid calling arch_freq_get_on_cpu from the scaling_cur_freq
>> attribute handler for platforms that do provide cpuinfo_cur_freq, and
>> yet keeping things intact for those platform that do not, its use gets
>> conditioned on the presence of cpufreq_driver (*get) callback (which also
>> seems to be the case for creating cpuinfo_cur_freq attribute).
>>
> 
> Tested the change with frequency switch stress test but was getting big 
> delta between set and get freq.
> After passing "nohz=off" and commenting "wfi" in "cpu_do_idle()", the
> delta is less. This confirms that more delta is due to AMU counters
> stopping at "WFI".
> 
>    +++ b/arch/arm64/kernel/idle.c
>    @@ -27,7 +27,7 @@ void noinstr cpu_do_idle(void)
>            arm_cpuidle_save_irq_context(&context);
> 
>            dsb(sy);
>    -       wfi();
>    +//     wfi();
> 
> I am not sure if the expected behavior here is right.
> In our tests, we compare the last set frequency against the re-generated
> value from counters to confirm that the CPU is actually running at the
> requested frequency and the counters are working correct. But that won't
> happen with this change.
> 
> In [1] and later in the updated patch within [2], we are busy looping
> on the target CPU and avoid WFI to get the actual frequency.
> 
> Please share what you think is the right expected behavior.
> 
> [1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
> [2] 
> https://lore.kernel.org/lkml/cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com/T/#mb898a75fd0c72d166b26b04da3ad162afe068a82

Observed another issue where CPUFREQ is coming too high when the
performance governor is set as default.

Below change solves that by using the new API arch_freq_get_on_cpu()
if present over the existing one, while verifying the currently set 
frequency.

  diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
  index 62face349fd2..2c74e70f701e 100644
  --- a/drivers/cpufreq/cpufreq.c
  +++ b/drivers/cpufreq/cpufreq.c
  @@ -1761,9 +1761,12 @@ static unsigned int 
cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
   {
  		unsigned int new_freq;

  -       new_freq = cpufreq_driver->get(policy->cpu);
  -       if (!new_freq)
  -               return 0;
  +       new_freq = arch_freq_get_on_cpu(policy->cpu);
  +       if (!new_freq) {
  +               new_freq = cpufreq_driver->get(policy->cpu);
  +               if (!new_freq)
  +                       return 0;
  +       }


Best Regards,
Sumit Gupta
