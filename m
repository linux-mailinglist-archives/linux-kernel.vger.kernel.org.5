Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F98070E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378562AbjLFN2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378487AbjLFN2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:28:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED4E90;
        Wed,  6 Dec 2023 05:28:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIZ4srhRCA5XuXHw13B15fe0N6jsSQJDfOJfMl1H3kTE95JDnQWw97kj8t+VV7jVJq3ggQbJa947iusKCqVszUIHfBenj9JmiqjyaXPtElwI3SfxSHKbtnAncrsvNs36b21NgmF5Yl5hMuqh7ChHc3WcSr3yc1aLFwKscLXvJv/wgZUpiuos748Ef5z11vj7qF7xGX8djL8pLri7vWzJALoUUFntk/2iC8E8neBCQtAzqVXcS2wEEKKOVoVnckLanP/AbfoP3VTC6EFXMceYYhHjWQneaQQTldV5CSV4QAKow5fjUvTKHPJatkkSBm6l7NlRQhbI0YgB//TXqtvCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjkRkEjkdlCD34ZfTL2i6C4i5bZUPFPUbxEvCdt5drA=;
 b=UPXnXuMrbSH/s5sOxfGNko6lC/awUte4WgCdXk3HTDB/hh9IpA8hf1tybGQ0mVeOaKywdWtxHe9qT/DM5mJeJrpPsQZIzmpruQgXPaBXA5Af+G3pU/I47mEVmva2UmOORZZ+k1tKEYcZFi9LBeUVr2x2ZcKAeJQFZXqu136tXj8InWQEACdJlxdetYsSkd5DZ0IGxoe9pPVeYWwPOXE9nTjYFygl6i3Mc4g7n5V/TDhzYk8em7n1MfHv3BgoCbG/2qfq2ovUkBVjDdSMJYGLa63rCDswG+6vuJV7T43MLt0lNd8w6expfz4QazMs+hZqiWfL9G4FBn53mKmPHCIh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjkRkEjkdlCD34ZfTL2i6C4i5bZUPFPUbxEvCdt5drA=;
 b=C4ifNDH4U9LD/M+5gLaM2YCq1ZbrEHBxiwi47SOwS1LJvlFIMTRd/qW0b72uUOely3ecX88TiU2hzscXVVLHghhLXQfy9c3JWhxaEQhIypDj3ssLq/duTk6NJ8nbgdFuuOYT6rXcwMteu+ngcnPfUVHPfjrBdMgqLOMGamFFgImMz1VZogwH+/9dXZD3b8GNGuCKwkTqh0SoHaKqcwGIN6+qMtyr7migaQN0WlBFuKxX4fpq56Pmv/zXzMUoDly9eWsxfMT7HekFpjAxBLiJYIIk8FVOOdiEkziopxOw2ZEXE5gkKtev7s0z2AH/V7tyh+wCaEPOMnT1Y74QPVwZeg==
Received: from SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::34)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 6 Dec
 2023 13:28:36 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::ba) by SA9P221CA0029.outlook.office365.com
 (2603:10b6:806:25::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 13:28:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 05:28:23 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 05:28:20 -0800
Message-ID: <c8b4d391-681e-f4a6-2839-e5951429f043@nvidia.com>
Date:   Wed, 6 Dec 2023 18:58:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into
 cpufreq_verify_current_freq
Content-Language: en-US
To:     Ionela Voinescu <ionela.voinescu@arm.com>
CC:     Beata Michalska <beata.michalska@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <sudeep.holla@arm.covm>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <yang@os.amperecomputing.com>,
        <linux-tegra@vger.kernel.org>, Sumit Gupta <sumitg@nvidia.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
 <20231127160838.1403404-3-beata.michalska@arm.com> <ZWXy0h/fFfQh+Rhy@arm.com>
 <3e6077bb-907c-057f-0896-d0a5814a4229@nvidia.com> <ZW8D5TfSwuJfdYeD@arm.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZW8D5TfSwuJfdYeD@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 8532a01f-9e24-42f6-4b0d-08dbf65f4074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXvSnq58WHrDU9EJ+NMT5ws77LD5KSLLbywmKgO6RiKXGF1eQFR+/pdm48jGJsQnNsp62uVzwcNhV+KRJ1TFIT9DH8MYwoNUjWstRQ/FQbPKtQoOKxQ69Assk7wnH0C2QrlRaLFezvSID8MMYgausCCP9C/TjBHVqSKdpMjFdSH+HIlz9xgjfyYgqLE77j/GdW5NBHWLWbkRbEMvSEFQsLCUBuHuOAn0MLaZ6BuVn10uT3EsscA4EeraZtViofALDRqGWDAjv16MCK1mBYtwOc2u4z7xuGkBudTK6516pDqZktWodLE8SEg94+HVIZGtt5CKUnGW+ziDWdLWiz4/9vMbQA+iMHFFaGdkWOyjM5F0Z6rPq4jHhGiRVwp4uYKhCrTDI1kwdOz4LpiT1CSiZywmbCov0RhM7G7MSC8f9jHBGgcSp+vf1Drg87Tz4Ua1djjNGVQaWw7yzEi3it42L9mi8lNc9Kz8A7brgcjUJOihDhSgj1qb5TViacI4qY0JhMzOWfn2FmAry074DiBEYjpDcTfvuwU7tY/HU2UPL6xsV0w7m9o6nI/E4eK0BTPS4IA0Stx548Vflq5LxIW9GMccnMbHe3JJ3QsFaq+u4IP4RtWboPwyjoJgKSjaM81OiEGUiliJmW00kLdvcWnfaQZi5z02pOZY7sFPjXvoF4z4mQjAT1AMOylOtLG4QS0ypKqcUOActFEKB+kd35binfbCTM6G0fEz9cis7xQNh81k94SKA/5yBZEt0yIRffgRh7yiu5zPkF4VGU9mHpcTwUEtMvX6oaWDl+1E/d/oPBruBiN1Yr9F6glVBUJCUM0ys+pmvLNV1IbnltaMBlDdM3trqi2hk/JVaipfbLhitu6uHvoKfNaLSu8A7jA2FGDybqMDKiGvHiYhfNxM6uZAmQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230273577357003)(230922051799003)(230173577357003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(36840700001)(46966006)(40470700004)(36756003)(41300700001)(107886003)(26005)(31686004)(7636003)(2906002)(356005)(83380400001)(40480700001)(82740400003)(7416002)(2616005)(336012)(5660300002)(426003)(86362001)(47076005)(16526019)(36860700001)(4326008)(8676002)(6666004)(8936002)(31696002)(53546011)(478600001)(966005)(40460700003)(70206006)(54906003)(16576012)(316002)(70586007)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 13:28:36.5340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8532a01f-9e24-42f6-4b0d-08dbf65f4074
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/12/23 16:35, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Sumit,
> 
> On Friday 01 Dec 2023 at 18:32:10 (+0530), Sumit Gupta wrote:
>> Hi Ionela,
>>
>>>> --- a/drivers/cpufreq/cpufreq.c
>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>> @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>>>    {
>>>>         unsigned int new_freq;
>>>>
>>>> -     new_freq = cpufreq_driver->get(policy->cpu);
>>>> +     new_freq = arch_freq_get_on_cpu(policy->cpu);
>>>> +     new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
>>>
>>> Given that arch_freq_get_on_cpu() is an average frequency, it does not
>>> seem right to me to trigger the sync & update process of
>>> cpufreq_verify_current_freq() based on it.
>>>
>>> cpufreq_verify_current_freq() will at least modify the internal state of
>>> the policy and send PRE and POST notifications, if not do a full frequency
>>> update, based on this average frequency, which is likely different from
>>> the current frequency, even beyond the 1MHz threshold.
>>>
>>> While I believe it's okay to return this average frequency in
>>> cpuinfo_cur_freq, I don't think it should be used as an indication of
>>> an accurate current frequency, which is what
>>> cpufreq_verify_current_freq() expects.
>>>
>>> Sumit, can you give more details on the issue at [1] and why this change
>>> fixes it?
>>>
>>> [1] https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/
>>>
>>> Thank you,
>>> Ionela.
>>>
>> cpufreq_verify_current_freq() also updates 'policy->cur' in POST
>> notification if the frequency from hardware has more delta (out of sync).
>>
>> As the value from 'cpufreq_driver->get()' is not reliable due to [1],
>> calling the 'get' hook can update the 'policy->cur' with a wrong value when
>> governor starts in cpufreq_start_governor().
>> And if the frequency is never changed after the governor starts during
>> boot e.g. when performance governor is set as default, then
>> 'scaling_cur_freq' always returns wrong value.
>>
>> Instead, the arch_freq_get_on_cpu() API updates 'policy->cur' with a more
>> stable freq value.
>>
>> [1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
> 
> Got it, many thanks!
> 
> As the code is right now in v2, arch_freq_get_on_cpu() is called on
> show_scaling_cur_freq(), so the problem you describe would not show up.
> policy->cur would still be incorrect, but 'scaling_cur_freq' would
> return the value from arch_freq_get_on_cpu().
> 
> Would it be enough if arch_freq_get_on_cpu() gets also called from
> show_cpuinfo_cur_freq() instead of cpufreq_verify_current_freq()?
> 
> Thanks,
> Ionela.
> 

Yes.
I am not sure if making both the nodes 'scaling_cur_freq' and 
'cpuinfo_cur_freq' same is fine?

Best Regards,
Sumit Gupta
