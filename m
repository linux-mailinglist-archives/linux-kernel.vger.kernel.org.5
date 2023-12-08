Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9130980A781
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574314AbjLHPer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:34:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4810EB;
        Fri,  8 Dec 2023 07:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJyoLVObNIZO/xhe6kfEoc3cmWH9WoZRn+ovdoIHvHrJRd/8X2akpxlhqMYuBzkDubMQBD0VWYKYE8WkFcJBSXEhnKINCwhvnYjxR0NY8nbhodtKb4SM0PErr9PDoixh2HnWrPrDo73k+wUMl+GqA42K6RyIFiuHAUYyEifAzyazagrNC6dp2epKk5oBrgEYAzGvLzfuzgNz20kNkQP3f0rBuae9tYpiVKWBKAvZ2H6s8BFspIS8yfIktletz9sDAERSRMaMANmlp8sNUDoZAYo7be5QkfmgzIi6IgBFng8u5S/MT+y2y0A4psDfD1F2TYr2ARBBI+hpz9AAwL3ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEaiplXiFsMqhygc0qR4UdYz9nBvmSVYOgtnl68lzVE=;
 b=RFeLzP0l+9Srtrc1/47JWSyFHUllUN5sZE60NU31tao37VHVp7CybXk6+5uv6iOSxJcSbbACdZShmAo1HJHt1dgIFHZr7wFnJjpFXl7CvbFaRd9LB7LWi8SKXZsM2CA7x3JCkiPfldnsDq2xsshEBZxvjVcOzsHYhDKqfT2CfsVoYpekCBi3lDuW2ykIGzH9BZNw8Nq/mgSfNmKf8jolCSn7WsnHg811V/TJv5aSE/DNlhYAljXizjod2ezr2SDPz0FL7iXJoYcjoIRkYPlQD0q3dRRm9lhUqlp0PsEQkc7iH6buJhEAOVexh4nXYPumjvHQX9gv3/S3yvtQvL5ZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEaiplXiFsMqhygc0qR4UdYz9nBvmSVYOgtnl68lzVE=;
 b=dKcCvdns25BGk5PcgN+IEkjXKBpWK154xV1OCQdRsgIqFF3S4Cd8h5Bmy7hqiy+XhU57/V3BbvdEgGArRXxjKHVlY1QPsHLPs0okzqHeFwpnxVY2NUYxULxlLzgIfBdAg7/BSJl0wgkD40EYRlMr5uAwV7N+IVZQJ9F4YVWf4QdX7TNW7wEM541IIbrm86bRgl3a9kfZPg4eUqZzFaZc3Um7Ci6V3TOLPyd8oMr0EKAu1eZqTSjEyvjSl+L8+d/Y4DC7Y32uscrzOzt6Akd/2Obapq8l38oZq3/I5UD7ZrWJXsFVSoOzSL8U1RRiYr/QzXikjuFjJ7RFOEHer/FpbQ==
Received: from BYAPR21CA0015.namprd21.prod.outlook.com (2603:10b6:a03:114::25)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.28; Fri, 8 Dec 2023 15:34:47 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::99) by BYAPR21CA0015.outlook.office365.com
 (2603:10b6:a03:114::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.14 via Frontend
 Transport; Fri, 8 Dec 2023 15:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Fri, 8 Dec 2023 15:34:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Dec 2023
 07:34:38 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Dec 2023
 07:34:35 -0800
Message-ID: <2cfbc633-1e94-d741-2337-e1b0cf48b81b@nvidia.com>
Date:   Fri, 8 Dec 2023 21:04:32 +0530
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
 <c8b4d391-681e-f4a6-2839-e5951429f043@nvidia.com> <ZXGOvsE4mKOsdoLp@arm.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZXGOvsE4mKOsdoLp@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd5afc6-830c-489f-c03d-08dbf80335aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +G6tJH6NC0kILMiADEdlRA9HInYXrQzmOm/zwsoG3oHXgh9fy+yTp00wCGLEXJ28HOFpZV+vu9mCA0XFIMXDoxGYu/j6r7CiP4PH/g/WqN8ibSZW3UQWH5ORIk+OSQkY044NYvtt9NnGj9RuJaLMrTjPSxv6cRSlBYmd6lXprZjkOmpCppsWkkiL3wM7/TOAqHVg6QxGlBlj7IUViVR64yEzRRBe/yaoYuap7xxPLFdZfSK2+B1nqKdvwkbnyeAdfdqKRgfD+OOzODos/0sychLjPUSRa8IfTS2Z6YyjHkBgVaVp3IFoIt3/bOwxPfZRSQVNxs2HZg6a1MBrlRsRUuIc9F7qJpnTkZvQ3ssjy/MiOTFSOw+Wgl2ibkS94M2TQVwKeB1PxqYp1k8cAAKqySHj69uq5jc04USyCQYQhQ1BNo+yFeRmL7xSl8SPP6eCEVimCvaMit7r7y4xrnG2V74/EcQGb2q2M6lwqQGhlSQSLQKwu4Btr8uQj5a84axsBCAeFcrFgxilgE9iEfD3k6WF2UscB/myVambfKovUZweJwDydwR2jJO4KqgBmkLl7yR418JJ0TNiyJJXUMbFueJ478IUHhjN9Dy0PweVxuf+KlxSxB1Jb4Cu3466Bfg4hHNfxinxESMqqVHVOY5RbVbWBS4/YY4lH9y9j36bb559h7Df3jH63Y/EFWrDaz4TfRqCmOEwNsk7VFNeqYAdq35ZFeERoPYM2wQETh6khHXPLPF/gQJaVm9fWb1qPBBJ02AHPUfbrcWzLa52UOh1TwBOXCfWuRs03dl2xjgz2jmAvJ1Ywbi8ABE7bM+PMxW0PtnBRdLBgyCafxDjzsXDcOj/ir8B3sF6VfYgX3Ap4ys=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(26005)(16526019)(2616005)(107886003)(966005)(478600001)(6666004)(47076005)(36860700001)(426003)(336012)(83380400001)(7416002)(2906002)(5660300002)(41300700001)(54906003)(70206006)(70586007)(16576012)(4326008)(8676002)(8936002)(316002)(6916009)(36756003)(356005)(7636003)(82740400003)(31696002)(86362001)(40480700001)(40460700003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 15:34:47.1092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd5afc6-830c-489f-c03d-08dbf80335aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>>> --- a/drivers/cpufreq/cpufreq.c
>>>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>>>> @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>>>>>     {
>>>>>>          unsigned int new_freq;
>>>>>>
>>>>>> -     new_freq = cpufreq_driver->get(policy->cpu);
>>>>>> +     new_freq = arch_freq_get_on_cpu(policy->cpu);
>>>>>> +     new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
>>>>>
>>>>> Given that arch_freq_get_on_cpu() is an average frequency, it does not
>>>>> seem right to me to trigger the sync & update process of
>>>>> cpufreq_verify_current_freq() based on it.
>>>>>
>>>>> cpufreq_verify_current_freq() will at least modify the internal state of
>>>>> the policy and send PRE and POST notifications, if not do a full frequency
>>>>> update, based on this average frequency, which is likely different from
>>>>> the current frequency, even beyond the 1MHz threshold.
>>>>>
>>>>> While I believe it's okay to return this average frequency in
>>>>> cpuinfo_cur_freq, I don't think it should be used as an indication of
>>>>> an accurate current frequency, which is what
>>>>> cpufreq_verify_current_freq() expects.
>>>>>
>>>>> Sumit, can you give more details on the issue at [1] and why this change
>>>>> fixes it?
>>>>>
>>>>> [1] https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/
>>>>>
>>>>> Thank you,
>>>>> Ionela.
>>>>>
>>>> cpufreq_verify_current_freq() also updates 'policy->cur' in POST
>>>> notification if the frequency from hardware has more delta (out of sync).
>>>>
>>>> As the value from 'cpufreq_driver->get()' is not reliable due to [1],
>>>> calling the 'get' hook can update the 'policy->cur' with a wrong value when
>>>> governor starts in cpufreq_start_governor().
>>>> And if the frequency is never changed after the governor starts during
>>>> boot e.g. when performance governor is set as default, then
>>>> 'scaling_cur_freq' always returns wrong value.
>>>>
>>>> Instead, the arch_freq_get_on_cpu() API updates 'policy->cur' with a more
>>>> stable freq value.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
>>>
>>> Got it, many thanks!
>>>
>>> As the code is right now in v2, arch_freq_get_on_cpu() is called on
>>> show_scaling_cur_freq(), so the problem you describe would not show up.
>>> policy->cur would still be incorrect, but 'scaling_cur_freq' would
>>> return the value from arch_freq_get_on_cpu().
>>>
>>> Would it be enough if arch_freq_get_on_cpu() gets also called from
>>> show_cpuinfo_cur_freq() instead of cpufreq_verify_current_freq()?
>>>
>>> Thanks,
>>> Ionela.
>>>
>>
>> Yes.
>> I am not sure if making both the nodes 'scaling_cur_freq' and
>> 'cpuinfo_cur_freq' same is fine?
> 
> That would happen anyway if arch_freq_get_on_cpu() is called from
> cpufreq_verify_current_freq().
> 
Yes, that will happen in both the cases.

> In principle, according to [1], it would be correct to use it for
> 'cpuinfo_cur_freq' and not 'scaling_cur_freq'. But the call from
> show_scaling_cur_freq() is already there before these patches,
> introduced a long time ago for x86.
> 
> The topic was discussed at [2] and the agreement so far was that it
> would be best to keep the behaviour the same for both x86 and arm.
> 
Looking at the previous discussion in [2], seems to be fine.

Best Regards,
Sumit Gupta

> I don't like going against the user-guide, but these patches don't
> actually go against the user-guide. The old call to
> arch_freq_get_on_cpu() from show_scaling_cur_freq() goes against it.
> But I agree that's something necessary to keep, as legacy for x86.
> Additionally, you also mentioned that you'd prefer to have a more
> accurate frequency returned for 'scaling_cur_freq'.
> 
> [1] https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt
> [2] https://lore.kernel.org/lkml/20230609043922.eyyqutbwlofqaddz@vireshk-i7/
> 
> Thanks,
> Ionela.
> 
>>
>> Best Regards,
>> Sumit Gupta
