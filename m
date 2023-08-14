Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1677BF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjHNSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjHNSN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:13:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371651BD;
        Mon, 14 Aug 2023 11:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSRsOmC6aS/6u6USMcK1kDadLx1k5DSlyOXPmv47ydRt2dzId5olpYp6EnfxxyI57S4EPbzq7HRzjVVb3GY+0HAABS4MwVAYtPP/uq07zZCfSBLy8bzijdfguKq3TDinCqT049CysxcPVsx0zGcOvyTES+EsuD6k57a8dFnZ1MV5Gw1YwwSYgreLDdouqRwHRVK0nT8fZHhy8b/p0iNL4NVYLOxMPZXZReqQ3jZ+zSVmH+DJQ+/WREOKmlP1Avv4nAPr2tgA7DRNkeuL3e60Y8Y+IJiOIvqRTSe5o7JO9cdzyeSKYzokJRzrlaRb5cGRzlcYRPiSiwcDpt7xT0vhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmx3mmqYHk3Tlh7R9QgMjHV+nPHbGYE+uKpySGyffz4=;
 b=iXe2Ri3pEoRH1pvq5HvC0Dey9Z5t6bZwNkJ2eAfjQVV73zDjEmc2J277ociPfRW+D9l82V52JsmbjUg4zAW39RXyPVOJHa8r9XNwPDLlzi7p9tYhsctbWgiG7B6HnKybmCKv+N+F7bgPebr66qvHTgPSK4gzbGTzz5NT9UNMziSAJ/8fe32PpZt00dmS0QrQGM0FpShqJFJ7hZxfKEsFkA7SQQCcxMcufJh5JJpsnRVMPkpezM82X9N+LRBaMjPNHrsmQACPW+lSX49XzNNipWLoIC//R0assxG4thL4z4hDUStMU2UmEZ+zFPGUPO5oJgPLaslW+raAzE0nUmlzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmx3mmqYHk3Tlh7R9QgMjHV+nPHbGYE+uKpySGyffz4=;
 b=drfKPC2X7PX4U5gbq921OeHlsbOldTzOQ+bWmmDqXo3a2X4Qy0x0NW6S1lsM1CMIgtHExsr9UPQqhmyEe79/1djRBQVTOUYAQl4L5HYijNFexsH+5TKaQuChd5IEoa5Gibjf+XXZ0/DJAk3N79UllUyjj+nZmkGCQbq0xfhE64zqHgmIhmATqCUgaJc22yLKykZTld3z6dAvP78vgjpsST9vTlqA/fd+jc5yDny4tIVUEpY0FXv+dhmCODh4VHVeuMGuDPAOprkPCm5mNvNHuUjqVRcPPI0C6yl8y6H3nHmd3e2x4dQ9sfWUokRvjkuACD+Drby45XAlJtFtCOB4WA==
Received: from MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::19)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Mon, 14 Aug 2023 18:13:23 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::c0) by MW4P223CA0014.outlook.office365.com
 (2603:10b6:303:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 18:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 18:13:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 11:13:08 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 11:13:05 -0700
Message-ID: <17b11665-874a-5b06-bc97-70f5202f238b@nvidia.com>
Date:   Mon, 14 Aug 2023 23:43:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch] cpufreq: tegra194: remove opp table in exit hook
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230809153455.29056-1-sumitg@nvidia.com>
 <20230810053127.y4wmumlggkro7r66@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230810053127.y4wmumlggkro7r66@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: a52a14df-c6d0-4e6d-7646-08db9cf22558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQyG6/Yo2rPOFXVVhTMaHeDlyYb3s8Ds4/dCbttuRKoiimrs7WUhsoSHjTmhnn0qSl/6mZolpQbfOem06XOAo1O1wykpA4ze+C7Ipg+eogZmYSG+92e3nYYB0EXevFwFqqYxaEzUvKxawIW2NyDYcxHl6aI8DFaRcXj2+FJ0gVrSnSMHreFmCqaXHg71wMdzrH9DYM9JKCG4Vj96SijDIMe/bfgN+7KByrNeSBPd5ldR/cA8RtIVCIiHT+czrCe1vQ403OgwPHhCibUO+dj2sLG5ki58BjFONuMIh3TEOz8PAnUwj4GRqIjxVr052Bsey/Ldnb64xadjbHjexyh5Dk+TfBX5Au+2wcaZKAmd0XuNoDRaF5KHRefZFoTOEiz8MvPk+T7BRlmBRd/mhofIgcAmm4aByma9K7Aro8MtZgje8mtWG0Hba1yoVvPV4FYTJrBD5UbwVmBIjL5n4ihD++Kb1k3jVU3r7gWcM9OTTFOapjXR56uW2SKjmJ8mCwT5JTt+RlpXokjhIacb/fZIrzvmSm7tQZoXpLiDQWhxoABVvpoTkdLirD9STn9Ihby1DeY1kYB/g7VS/kmMUGFVYZuO17H5ZZh3pjuoWXU87BCoX0bpz913aQdQiUUMDF/81ukHiCxVCr123zBQ2fcierNsyB8o0PC0qa9cHN2QAUh3LD0YO/TL+1WeZzC/TwmWeOyON/tTtETSnQhtsIsM6QuunVhqZ7Pe9kyvFp5vRzaPZPpHxTLQxi/rppyvszLoZxQHQ7iXJ5AJ8CYT0yeiOg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(1800799006)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(107886003)(16526019)(53546011)(26005)(336012)(8936002)(41300700001)(70206006)(70586007)(8676002)(316002)(16576012)(36860700001)(31686004)(2616005)(47076005)(426003)(83380400001)(40460700003)(478600001)(40480700001)(54906003)(31696002)(36756003)(6666004)(86362001)(6916009)(4326008)(82740400003)(7636003)(356005)(5660300002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 18:13:22.4692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52a14df-c6d0-4e6d-7646-08db9cf22558
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/23 11:01, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 09-08-23, 21:04, Sumit Gupta wrote:
>> Add exit hook and remove OPP table when all the CPU's in a policy
>> are offlined. It will fix the below error messages when onlining
>> first CPU from a policy whose all CPU's were previously offlined.
>>
>>   debugfs: File 'cpu5' in directory 'opp' already present!
>>   debugfs: File 'cpu6' in directory 'opp' already present!
>>   debugfs: File 'cpu7' in directory 'opp' already present!
>>
>> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra194-cpufreq.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> index c90b30469165..66a9c23544db 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
>>                if (ret < 0)
>>                        return ret;
>>
>> +             dev_pm_opp_put(opp);
>> +
>>                freq_table[j].driver_data = pos->driver_data;
>>                freq_table[j].frequency = pos->frequency;
>>                j++;
>> @@ -508,6 +510,16 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>>        return 0;
>>   }
>>
>> +static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
>> +{
>> +     struct device *cpu_dev = get_cpu_device(policy->cpu);
>> +
>> +     dev_pm_opp_remove_all_dynamic(cpu_dev);
>> +     dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>> +
>> +     return 0;
>> +}
>> +
>>   static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>>                                       unsigned int index)
>>   {
>> @@ -535,6 +547,7 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
>>        .target_index = tegra194_cpufreq_set_target,
>>        .get = tegra194_get_speed,
>>        .init = tegra194_cpufreq_init,
>> +     .exit = tegra194_cpufreq_exit,
>>        .attr = cpufreq_generic_attr,
>>   };
> 
> If it is only about hotplugging of the CPUs, then you can also do this I guess.
> 
> commit 263abfe74b5f ("cpufreq: dt: Implement online/offline() callbacks")
> 
> But since your driver is capable of being built as a module, I suggest you try
> to build it as one and insert remove it multiple times. It must cause you some
> trouble as you don't implement an .exit() before this patch.
> 
> Eventually, I think you need to do both, what this patch and 263abfe74b5f do.
> Just that the reasons need to be correct for both the changes.
> 
> --
> viresh

Hi Viresh,
I got the same message on inserting and removing the module multiple 
times as you suggested. After applying this change, the message is not 
coming. So, the current change is resolving both scenarios as 
__cpufreq_offline() calls either exit() or offline().
I can update the commit message to mention both scenarios and keep 
change as it is?

   cpufreq_remove_dev
   |-__cpufreq_offline
   |--tegra194_cpufreq_exit

   cpuhp_cpufreq_offline
   |-__cpufreq_offline
   |--tegra194_cpufreq_exit

Thank you,
Sumit Gupta
