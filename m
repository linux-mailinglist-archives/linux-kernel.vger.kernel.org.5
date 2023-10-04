Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8E7B81E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbjJDOMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbjJDOMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:12:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434CC6;
        Wed,  4 Oct 2023 07:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvYHsxfPDv3kAc77jhMerCO4TW/EDcTuJMpHnh2zh7N9FtOlPI+G5Giyr1xVz49uCcXKxqeOTh8n7O6xYOwZx+MOPexua09xHg3RC3594m37i6IugtJ3RZwcAL0eoTHgQ2XPKbdCL7SzAyiAR94G1D5uB4TiZtN4TWIzkK9qZalp0RlocHsbgndxHGIFbqP+wz3FClp/3nAhnFB6GPzyfhAqwChpEdhBiE/jCEZFXLfWp7KjdVAl7rpXsSLjKcPhFZj392WviHeMyvKvrj42rAJbMbhVUNPstdzkZ2vgrJkrwDiEBwQupX93bptRBM/qTLvky9iVf4wDCr5Cb+r6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WQ9eLoLKyAzSGLIOGGz9WVm0ntya8Sg5Ennj8VGnBM=;
 b=mTaq7KHltqyMOnATXHXMkRs7LBWnNSgcFnoodMavAkYlbnUdsNcjhTJbuTJdLAN2JaQcDGLhtQKfp4NFI/OTQhBZj+DItThRwk35wV8WJhfWUqfXneP5uFoBnI7LAE6qdHEU8s/XS0idi3gDqgemJrT+QXW9lssKdqZSghEBae8ahEHhAOhmMM5EmR+9QWi2SQjIQfp8d41kPDdFhgo4N4TgiF6G2L/KfoWr7RYi1ueVLDNQQi2AsS2qkq+BM2OUkpHK+c52mLnQuKcJ25EV/FIb18g4ecft8gNCJ+f3dY/mc5sb8sKIGUYVr8867mCv2FIP0ebyXTHg9ZURW7m/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WQ9eLoLKyAzSGLIOGGz9WVm0ntya8Sg5Ennj8VGnBM=;
 b=J9Oy1tJCMrsIJ87xH0u1FRI5yO63mGZMzU6oko8KHDWVqVhM0vOH9iesOwFI8N80rfdA1Z1Xqy80zZsSaU33kT98mxJGEAGTaGUtNc0b5DaDpIBY6g2ghHZNLGv19n9Ou0q412RT/D7F9YaFjzXn4uEFIt4f5zjQfckhCu0QjAcU2a3JnozkXNYwIE7Ev657YhNh/o6yBvOE/s0eHzSFvp5MaxHMI6P3Glm2GxGldMFS0CTR3zuc+ExRVEMYjcAoUOfXYuFs2ztKo5XkIrFlOmfhBpoIwfenarXpjU7JUe1bawZF6bS+0mw5QBSj9p+uQKxt4VZI7Hz4Ao+4Q9Gd0g==
Received: from CY5PR19CA0043.namprd19.prod.outlook.com (2603:10b6:930:1a::33)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 14:11:51 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::d9) by CY5PR19CA0043.outlook.office365.com
 (2603:10b6:930:1a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34 via Frontend
 Transport; Wed, 4 Oct 2023 14:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 14:11:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 07:11:36 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 07:11:32 -0700
Message-ID: <379ee551-c2ef-72ca-9372-c812373a1e0c@nvidia.com>
Date:   Wed, 4 Oct 2023 19:41:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 1/2] cpufreq: tegra194: save CPU data to avoid repeated
 SMP calls
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <amiettinen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20230901164113.29139-1-sumitg@nvidia.com>
 <20230901164113.29139-2-sumitg@nvidia.com>
 <20230928070545.b7l367qi2q4rynji@vireshk-i7>
 <8cb33679-5056-8983-9334-3ab3d170568a@nvidia.com>
 <20231003050019.a6mcchw2o2z2wkrh@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20231003050019.a6mcchw2o2z2wkrh@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 245a9602-6287-4594-ed7e-08dbc4e3db2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPiz9o3BQF4mQ8ntqFHrod7X5FECqaf+nu9yY5KB4OcCOCRBhTqrSqrK8W8KKb7ZYjzr8wdrDk0pK7vt1L+eY+duPviOYgI55pgw54RzSQCtzheXx1+3yMYyzwq1H+RFfjXBAKTBfLxq2CUAnavaF5Z9sec++ffs8IvMI5fIZBBaDYOmjoNw1FHlmK0NSjy1fddDQ4aU5bBLke9WH4EKljHKFqncHWpIdHimOOPEULIwMhxM9VVV0119LuU6XLO1n4hlLYa2l7r4DTUiajnCEDznrHluMDZp9C7aTlKRFAcohBG811WN7i5kPd6V3QPXRmKMBgTQDJcQkcmeInrpl/PCvs7mmEL480IzhdMMC5bVOFYxGdsyjqbUt+gCJ+FToZLCpEioFAierSV/sbI2LL2hVMHrWa8hvhGuXMkHtfVQ00MZmL6pvP2Jg5734sCu3tVxjhJpDKcap1dxVF/dIq94+bD6Ql8LDRXUBFtAHspSfxM7O8pSI++ktCfXAc24K+uhcE3v0ahelCMd96ZhgIggqTEMF3/rpQtSzUfYw+GHnfnC1/6/CuFyg5Tw7f3S8dLP96kL1pxX7UdbFuOYcpFOWcJ6Xr5QcpZRf/QwdfpmRGR8iXErso/1CWq+zPKowXpakudXN2OD9l6++l2ggQEmhd3JR1gCac6PanqWH/w4W82NcKbABEd88ePsbn4pJxhLOoSC4nj86BknWjKVLXqIBzC8BVsCE6x7Fs9JUz2lA7/zgeFwp6ZB3n1TgJOIvhmmMXoc1xCKwyIL7QOJXQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(31686004)(66899024)(53546011)(2616005)(107886003)(40480700001)(36756003)(31696002)(86362001)(7636003)(356005)(36860700001)(82740400003)(426003)(336012)(26005)(2906002)(54906003)(47076005)(4326008)(478600001)(83380400001)(316002)(8936002)(8676002)(41300700001)(16526019)(70586007)(16576012)(6916009)(70206006)(5660300002)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:11:51.5138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245a9602-6287-4594-ed7e-08dbc4e3db2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/23 10:30, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 29-09-23, 19:47, Sumit Gupta wrote:
>>
>>
>> On 28/09/23 12:35, Viresh Kumar wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 01-09-23, 22:11, Sumit Gupta wrote:
>>>> @@ -131,19 +132,10 @@ static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
>>>>    static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
>>>>    {
>>>
>>>> +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask)
>>>
>>> (Yes this is existing code, but ..) you don't need to perform AND with
>>> cpu_online_mask as policy->cpus should only contain currently online CPUs.
>>>
>>> Please check if you ever see it differently.
>>>
>>
>> I think this was kept to be safe.
>> Should I removed the AND in v3 or send separate patch?
> 
> Sending it separately would be ideal.
> 
> --
> viresh

Sent v3 with the "sizeof(*data->cpu_data)" change.
Will send a separate patch with change to remove AND with mask as suggested.

Thank you,
Sumit Gupta
