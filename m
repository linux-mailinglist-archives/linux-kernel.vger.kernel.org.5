Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0714B7A6947
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjISQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjISQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:59:44 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3254BC6;
        Tue, 19 Sep 2023 09:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3qvwqNA9r0SBZFk8JbRkcQBwv7NKZz8KlVULW8jJMLaFJoyNfIJBXyU202iJMR4GW6dbGMlkedndhwWYm58En3HRaSJIDp7S1nn0dnuIWIX1MT/GSXdiGeD0LOhZnEHK/kgTOn9G9ZUOV2B7SJcA4Cc80JE7evIkusQRHx0YXxvFrYeRarqE6srOeUk4BI5qXmeylR4A7EG1uNEvn0OxcjsNQklB2rIYIDvorZnX1q4VnfoHgC9TxHnxOYi91Kvrg9cHBtrrMSpnlCR/bVUCRoRIEdcPP2dGVVaEbOMKxWC+5ZFImVOLoA+gSslkPsh/EriDOTFx5AB+pnBX36sgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61v4ImtPAcJllvrsMxies3NFHOMZP8kosdyMMr8ADaQ=;
 b=hz1C1mkv5e7U3TqDegjSYkyWg8ZMIKg81aQqw7F0fVUyUpa5k3pDA+VKdtb9hItI1qlLYpev5ebkda6P5j0yAOtmxk14gP5ZnfFmzGt2s6kxiBru2ijyIKMk1g8kJRc3xD982QW7zbB0//E5kcDoVeHBBAbPRRTO4IMovqDRLChw6dW1/5ZducbC4cT+1k4oNe+NX/y6gMbmRDOVWt0k9k0PSQVWqDfzkCpqvLMJxByU2bATykliFrSp0TvOx0CljuL/jTAXL76s7cUOWMdyP0bLqzmg+E5Rt5XV3XYkqgtF5pQo1WtgGnlq6PwMWwG1I/T9WpV5X400dcS0dpZF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61v4ImtPAcJllvrsMxies3NFHOMZP8kosdyMMr8ADaQ=;
 b=CBpjDguDc/7+HemOGSIrdGlp9/Bw3BYyipJ3OweOui0MA8N1aGcRZ97+qThjeFnWdUHVwmIUyyksfh6TZbJORuycOu3K1RDH36EO9UjwbOupxRgjzc+3zIB6fnhxvjrPFsG1KLQXrJC/OiK4A7r6kb2vZzV5an0xwrzFiU+7CUaB/uG1hzB9qpuDZdUB7cj9IxYB406K4NdZ/ITFhDDZs0z2Fpsl48wa5TkewKzUglFp1j8jGnLtufIRyjzc0cEmbJ3itfnvSHPCzoK/AyRJgk4Cw8ixhNZDRzlCLs38qtA5UfJ89bu875EF16Ie/GugP6wjsYFm2pCnUhRx04tjbg==
Received: from BY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:1d0::12)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 16:59:35 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::84) by BY5PR04CA0002.outlook.office365.com
 (2603:10b6:a03:1d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 16:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 16:59:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 09:59:21 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 09:59:16 -0700
Message-ID: <ca89aeb5-bdb6-96ba-5bd6-bc9cc23b9093@nvidia.com>
Date:   Tue, 19 Sep 2023 22:29:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     kernel test robot <lkp@intel.com>, <rui.zhang@intel.com>,
        <lenb@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230913164659.9345-3-sumitg@nvidia.com>
 <202309140915.2J9OzWIZ-lkp@intel.com>
 <c180c1e9-c15c-b4e2-678a-35a388a4a613@nvidia.com>
 <CAJZ5v0iJYb3cAq6VMY8s+AOmuMdCBY9KvshM8rcGnCT-tn8CmQ@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0iJYb3cAq6VMY8s+AOmuMdCBY9KvshM8rcGnCT-tn8CmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 321f9bd4-a0aa-42fb-b53c-08dbb931cd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTzpcYSiMlOxfbiN90WNKtUm3NFvdxi1CMRD0+Kv5gaeFfIpVgsstneGSHNIjmQIk7qrTaFYkjCxeW94J3vuYWfmIHNdTWNdJ2E8elL58pEKp7iZ7KZSx//v8Y1xiOzmQaA2/QIUNBKLtjxCeJ90qHCAFs4UqSSeP1CZkRKTiCDqXgVb9SEeLCC6Sn+C8y/yzhSInTXsQXhzkxgk5Xp7ZlGFnuQP8OKLpILiD6SNQkYjlcYwsWdaC7SpwnwvsX2YdynmC3oMQ5RZwfuJSxsY1eWSByeWO5Nd1+PkykwvM6Tx2ehXz4rIodtxlt2AAkIJbH9Homrexe/syqlKD8b+Q0Rayzt/2PDRkcN81ewfRm8JqsXrSfUV7FPDYclV1S2NGSbnuTiUP6LugUf9ceBtK9J2Y50apZkh2hT2R4Z0mkSL/kdbbnnVd1s+2/HUBUzWB2TAAqW1Jtvf6cDCfOGfemhtoZvo9YVmKA4OZDkhfXAA32HjckkpJRqRSiIH7KHNEgW+hZZD9T72/EuhJ/cKq4qd0RAb/3Gn8c+pcBLuRRGtaS6j+7U4qsBmw3Z9o1KUamXbNN//o9piPeggyr699L9KQzTpVTwzsP99ck1zSnr8DfvDPGX/rksIvSQ9iYEcuxa2NeyKHvUPLeL2sS3oTHJo4o/5ydOeRQ5ertFqVBi0uqb7NKOEV6aHlBcNl2sRbpzfpSQcGtreWCBBcQ2Q4C1Pklty8kHgiPw8W69nol/OyTdSePDKoAbLjtbb7rZI03h+D7/+Vfvw7B1zvp48SsbLGB2E8yatjV3UGH1rPgHEOf5pXHtmHslaSEgXv62t
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(70586007)(6916009)(16576012)(70206006)(54906003)(316002)(5660300002)(83380400001)(8936002)(31686004)(4326008)(40480700001)(478600001)(8676002)(966005)(2906002)(41300700001)(6666004)(2616005)(40460700003)(26005)(16526019)(107886003)(336012)(426003)(36860700001)(47076005)(36756003)(356005)(7636003)(31696002)(86362001)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 16:59:35.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321f9bd4-a0aa-42fb-b53c-08dbb931cd87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>
>>> Hi Sumit,
>>>
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on rafael-pm/linux-next]
>>> [also build test WARNING on linus/master v6.6-rc1 next-20230913]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-thermal-Add-Thermal-fast-Sampling-Period-_TFP-support/20230914-004929
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>>> patch link:    https://lore.kernel.org/r/20230913164659.9345-3-sumitg%40nvidia.com
>>> patch subject: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
>>> config: i386-defconfig (https://download.01.org/0day-ci/archive/20230914/202309140915.2J9OzWIZ-lkp@intel.com/config)
>>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140915.2J9OzWIZ-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202309140915.2J9OzWIZ-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> drivers/acpi/processor_thermal.c:141:6: warning: no previous declaration for 'acpi_thermal_cpufreq_config_nvidia' [-Wmissing-declarations]
>>>       void acpi_thermal_cpufreq_config_nvidia(void)
>>>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>
>> Thank you for the report.
>> The below change fixes the warning for me.
>>
>>    -void acpi_thermal_cpufreq_config_nvidia(void)
>>    +static void acpi_thermal_cpufreq_config_nvidia(void)
>>
>>
>> Hi Rafael,
>> If there is no other comment. Could you please add the change while
>> applying or you prefer me sending new version ?
> 
> Please update.
> 
> Besides, I haven't said that I will apply it without changes yet.
> 
> Thanks!

Sure, will wait for more comments and add this change in v2.

Thank you,
Sumit Gupta
