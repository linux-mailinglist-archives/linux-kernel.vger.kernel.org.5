Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247C4800B62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378919AbjLANCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378858AbjLANCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:02:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB241B3;
        Fri,  1 Dec 2023 05:02:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gprZmvo1RGXBoStFSFuo5nBAAiZWbWf28uCsszDHpD3Y+aLUvps9gKCdLkiDX5znciss7+SE4cphaixVyOW6RdRGpHHqtjna3/kKPmBhrk+h6sQbOvvKbf50EKFWcQnsW20J2Q8dz2nc6kFdLvrSF3VhYSuLM5AMA1YpGe5uepzT424wAdWbQWYbW7prQTqxYjznFyWoOGVRPjGe9gxLKFxv3XJ2Egl0ORji8LGYdDZK7NDAwdxETgYV+4aRs2/qkrzbPj2pKaznGf3CjGtrjR+f2Efve0Zyx/lzGo+I7Q8LFNkEgtXvxKLomppXoUVYsy6JZcqYnrONUN6h0X726A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrCfA8ufham5WJFVdTba5/o9lVBfvgzfJ6TyG6wGXIc=;
 b=DCqohLzgVr6WSrfimXn4zmG601Wpmr1oxaS09bfQouqD2VFzAFiuekgaF1JfwixrGseEwTyVX8RhU57WBmIJrDeYnJNn2c3ve6xNO1c3qeDAXb2zfm8gaU26xalSxMUeReiz8QKEpYdkb/9sdcDXPKgQFJfVWo7TqLZmyVhUWhnHCs4Tbr2dOmtFlubdeAchtUxmQZ+1WOJug8vLvJxpAvdBi+Tgg+19dfLXtV04RzwiRjtjiD2mtBwoBcqib9ugiOIrmgclf/7KkwgQWf+nHY0ZFPoYUXZxGVmuoNh19NJE4kcR2HK1j9iZUXw/eeiSEZw0bZabKC0N7z5UF8VU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrCfA8ufham5WJFVdTba5/o9lVBfvgzfJ6TyG6wGXIc=;
 b=R/pRRFAnik1cjQ0RJqgzGQqS5KA+T22ik02js4Br476KbMls6nXZoVSGHFn6un5efM35XFFVznd2nKGNM77hC1efss2om9N1JLfYvEWxvuHUYCNJpe7/7A2AzSKrVg3bhhKouDv8JjQqf/BRipcxjdBAsIq09f1BqWmAyid30wlF3AiG6zsjNqatmk8u8uB4nRntQ+yPhQDW1mzwSXHCEjv1hpsLLGx61FGogq5BhBUbPHNnnTsv+VsFEPyCAFcI3O26VQP7tVadaHg2+LwxPG/PKanJD9fVbBBbfAUniZ4DNHHkToGeVT4wu1wq0fkQNwolO8q3D9b2WLdsXAr4pg==
Received: from PH7PR17CA0021.namprd17.prod.outlook.com (2603:10b6:510:324::27)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 13:02:43 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::2f) by PH7PR17CA0021.outlook.office365.com
 (2603:10b6:510:324::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:02:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 05:02:16 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 05:02:13 -0800
Message-ID: <3e6077bb-907c-057f-0896-d0a5814a4229@nvidia.com>
Date:   Fri, 1 Dec 2023 18:32:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into
 cpufreq_verify_current_freq
Content-Language: en-US
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Beata Michalska <beata.michalska@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <sudeep.holla@arm.covm>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <yang@os.amperecomputing.com>,
        <linux-tegra@vger.kernel.org>, Sumit Gupta <sumitg@nvidia.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
 <20231127160838.1403404-3-beata.michalska@arm.com> <ZWXy0h/fFfQh+Rhy@arm.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZWXy0h/fFfQh+Rhy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: bccdf2db-2f0a-45a3-4f72-08dbf26dce71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ogXGgQNdb/rTEiCZeK5XvOd6c/Cebhs3wlyR678hynVc71RcMZrUtkNzEbZ2VVz2oC9oiRmEyiuSVPgNkyh46QjrdMqUf1y3IPGaQ8hhqLx8laKsWgPJu85qfAXGl+xB1ZAqTaSWzgce5PkMop2ch+jZ0o6s1TV0QbMfCsCkL1c6Zf90P5pg/Eag9RIGmIiHqldV6Uz1oj3dNOoJpUoCgDyGncYuQHqMPu2E4gCqgemTaS2a/H5srfknl1vurfsd9AYuTflzdKzSrRy1Yn/3z0VAMoZtU6We01R4FTFwQrLoa8Ju04KtsMeqtjxPODrbyvyQ1Lw7EnRWl3H6Vs45jM2EI+skldllnaTLD8fQ3/T9I7883PHI4XOhcPUOP9DJFkWeJ9TLjqqI27EaM1DC49cxsozU7xALaZfmJzYfj3n5RiIpUER6CxQjMOqXgfgoSUAbwXY4EjdX58NdEulNMyBeGkeoiRF/Aw8ALnQaZUrhaFY4BF+20Qx4DRs94JUOj8d8E0KaCDE+QgH7aqZrL9NQYkGomfkZF+KMn/LHzdfarUNvPt/3cWGJe7FNmywj4RwjpfQJmK3WCMJQ7jyOcGwfpJiVUqJ2IN9LoC3JhoxcDZ/rqESyLEvhMK99ItWt00Di8lt+rYfY+9fM2lMGHy6cV8QVnV4ZKsGgVii20KYzkW5JyAXeihGNHAmP63mF6fCIEEprT60J98A41bwiYugJ7TFrnH0SDgP6TVTe7LnWXi1xtUw1Jt1aCieLYnxCwV08OcrcMUDtWajTPI56+vSESZQO1PIUTmlejTCBSaYUIYTyvmnYwwdgXehwfBkOstzcgNoN3uCx4hySz8zqh5dNq7zU2l4pDPdYBH2NFk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(31686004)(86362001)(83380400001)(40460700003)(70586007)(70206006)(7636003)(356005)(82740400003)(36756003)(31696002)(54906003)(47076005)(36860700001)(426003)(26005)(2616005)(107886003)(110136005)(966005)(16526019)(2906002)(316002)(16576012)(4326008)(5660300002)(336012)(8936002)(7416002)(8676002)(478600001)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:02:43.0540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bccdf2db-2f0a-45a3-4f72-08dbf26dce71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>   {
>>        unsigned int new_freq;
>>
>> -     new_freq = cpufreq_driver->get(policy->cpu);
>> +     new_freq = arch_freq_get_on_cpu(policy->cpu);
>> +     new_freq = new_freq ?: cpufreq_driver->get(policy->cpu);
> 
> Given that arch_freq_get_on_cpu() is an average frequency, it does not
> seem right to me to trigger the sync & update process of
> cpufreq_verify_current_freq() based on it.
> 
> cpufreq_verify_current_freq() will at least modify the internal state of
> the policy and send PRE and POST notifications, if not do a full frequency
> update, based on this average frequency, which is likely different from
> the current frequency, even beyond the 1MHz threshold.
> 
> While I believe it's okay to return this average frequency in
> cpuinfo_cur_freq, I don't think it should be used as an indication of
> an accurate current frequency, which is what
> cpufreq_verify_current_freq() expects.
> 
> Sumit, can you give more details on the issue at [1] and why this change
> fixes it?
> 
> [1] https://lore.kernel.org/lkml/6a5710f6-bfbb-5dfd-11cd-0cd02220cee7@nvidia.com/
> 
> Thank you,
> Ionela.
>
cpufreq_verify_current_freq() also updates 'policy->cur' in POST
notification if the frequency from hardware has more delta (out of sync).

As the value from 'cpufreq_driver->get()' is not reliable due to [1],
calling the 'get' hook can update the 'policy->cur' with a wrong value 
when governor starts in cpufreq_start_governor().
And if the frequency is never changed after the governor starts during
boot e.g. when performance governor is set as default, then 
'scaling_cur_freq' always returns wrong value.

Instead, the arch_freq_get_on_cpu() API updates 'policy->cur' with a 
more stable freq value.

[1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/

Best regards,
Sumit Gupta

>>        if (!new_freq)
>>                return 0;
>>
>> --
>> 2.25.1
>>
