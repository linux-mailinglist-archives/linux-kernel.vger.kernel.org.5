Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6A7BDA15
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346240AbjJILhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjJILhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:37:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30694;
        Mon,  9 Oct 2023 04:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqxBJmiKhhWe2vjtgAgZUqjxKpShPob6I7pdvBCseneFO5UTIcmB0NSFN1rWR3PFgcZtGn+czfpqRwaCjXt0hS6mzOepucuKButJ3snkSaJOlfbMy0tIoZV9FVNiJoPgODsl1HoYJ65pI2evVsoUD5XF1J3/XuiMWEyawDYPbp3l/meislh8RVMNMSldyWmIjMRq99ftwZbX3vpIk1KSCr4MuGZ5+RhEapTPmq8fINmWtBLVv6f5XNznl3yXJ2uT0zYU0ybhm7S5iD6+TrjVPWzmQAaJIPM/gdVCW+3gsfXsIuUAKum+7IUNyf3EvZ+QdzzNm7FTu/dDLAKWg1pNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VIY+Sw25htvtyxLbQ9nkkLSH+8IYN5mP0NVAQpHsf8=;
 b=jWAb0bWND9xd1tituUHI0AFR4XB3rSC434kx1x2FRdNTSPChfTBX5Qre2iSxty67YmKY+tdci1u+7HlVLJ8xZ3EvXsSa/uBxMRcl062jlvI6/Hx4D6qEFytfcRim6CSlobG1AD8nVsyGb9lDen/PglgGphad6fmNT8SMC5Hi9FRpxU7bnL0ryLSXtKx37yAHJVcdVtpQLtJpMjZRUl+00LoluKlTbc89mGAIPvxtVOMvkXBBw+t7AM1fxShPZsgbk0WmLwC1ceDeRth1z887ia0mDuPTvdQG6HcCdOtgQnCpck3OYtHuva00b/6H4vzq1ERKtiUgaCEaQu7AGOnc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VIY+Sw25htvtyxLbQ9nkkLSH+8IYN5mP0NVAQpHsf8=;
 b=rsB65FuqcHuuSgr4Q14HLL6/UrT0SyV8RdgGtnDKvPodRVGmoN92Yy/3DfuWVUi5VvEd+gAkEJTXmXsM0sEZQiKEaOpjW7432K4NDoLZMxcsxrOulrzdtWdk/5+cm4lONdWGTZ/GhkI6BGF0gTGtvDEaIOzBq6kgTIB0cL/MbjAu22/NQwBqoa7pZZa1MuJMeRD9Vl4UaVh83eM6u9gCMjq+sUSenGVPgYzGuLT+RiQnGN3eq+EI0QwwLexGlc2hiUtHm0Z93DngDolzDiKa0RGtcOKJB7bo2FMo9hRVarJWEpjyGBFcJg4ol+m+w1iOK7x9t8t8wViRx1+TgQBWYA==
Received: from CH0PR03CA0434.namprd03.prod.outlook.com (2603:10b6:610:10e::16)
 by CH2PR12MB4938.namprd12.prod.outlook.com (2603:10b6:610:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 11:37:05 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::b4) by CH0PR03CA0434.outlook.office365.com
 (2603:10b6:610:10e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29 via Frontend
 Transport; Mon, 9 Oct 2023 11:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:37:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:36:51 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:36:48 -0700
Message-ID: <72e9f769-9cbb-274e-e99d-10c71f84bbe0@nvidia.com>
Date:   Mon, 9 Oct 2023 17:06:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v3 0/2] Improvements to the Tegra CPUFREQ driver
Content-Language: en-US
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <amiettinen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20231004140537.1954-1-sumitg@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20231004140537.1954-1-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CH2PR12MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fb7de4-1549-450c-3aa3-08dbc8bc0fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAkTnJVz+vbqs5CRWQZXMutPZ+IidJmjs1yyB14w0SI5yGVT8tGAYL4tQQgkZ520BERl0hrQO/vrmYchb2iaKiAHvuLyN15Mxq6YE3cItmQDtDwnm8b7G0IZUR2O7JIqq7E6Frx0IOde06PQ7SjR3uktjs7QnldRic7PP+i5I4iYeWoAJXm9J5HHunwl41ueBUprr+li3RtBGsUQVCSlETr/1joIvHsMCkBt4fIXM/7xlSbZsYkcrJmH1UT0NEI+/aZSDbl7d+zMzoaL68dXn2JisJwAGnOYm/+4dWKhRpmEyxfoskxF4aLH6vUv3zLExsWcYXG9teuBeP0KQymzC88biXn4Ap6RoNXd3GzxeThCHExySjnDm6RYi2cHl+Bpqne4GzMMQ7nITH6GcgCPffcxi93Q7MAa8yCdd4Tjlf0jRijHY8jystE/mL/sBnAeKEKU0w9NobHc3JchoGdCQ2YmRd0hKGQ0Rbo9QCBaaz1tbozuNzp9ZhNbFy1HTbrM1PN7Vrtcng1gZ6eEynzODQyc9NW8x1GWchKd69XeNxgL2efuf3ng//CbhzUP4Bj4VDeSJy7avrETqVdvy/ExIt4qy3nw7yc8qyTo4SdR5K2DEmIycXrpeL4e5UF7YSxwKRiYfPoHXwLTNjMLkYFY80It58MCKVCWk0j6k/QhBoFkTnBafIDIUIY/mNy99VNzoex+Pn4+2d/WZqQ9pUSUQv9i8tb0QEppoD25Kn13e4EO09ZPdvUBYViJLYwtcTx40xx8vI1SfsNb26AzPbYhcrcc95bEjNr0SW2zPY4Y8Q8EhXWa3dZUH1Lusr4l8xgJLheFnYTD6q4yCoHf+1gW1rkPdKAWYC++KIpwQ+Z9kUw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(31686004)(2616005)(26005)(336012)(16526019)(426003)(53546011)(40460700003)(36756003)(82740400003)(31696002)(86362001)(40480700001)(356005)(7636003)(83380400001)(107886003)(4326008)(2906002)(478600001)(6666004)(8676002)(36860700001)(47076005)(966005)(8936002)(316002)(16576012)(5660300002)(41300700001)(70586007)(54906003)(110136005)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:37:04.6664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fb7de4-1549-450c-3aa3-08dbc8bc0fd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4938
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/23 19:35, Sumit Gupta wrote:
> This patch set adds below improvements to the Tegra194 CPUFREQ driver.
> They are applicable to all the Tegra SoC's supported by the driver.
> 
> 1) Patch 1: Avoid making SMP call on every frequency request to reduce
>     the time for frequency set and get calls.
> 
> 2) Patch 2: Use reference clock count based loop instead of udelay()
>     to improve the accuracy of re-generated CPU frequency.
> 
> The patches are not related but have minor conflict. So, need to be
> applied in order of patch numbers. If 'Patch 2' is to be applied first
> then will rebase that and send separately.
> 
> ---
> v1[2] -> v3:
> - Patch 1: used sizeof(*data->cpu_data) in devm_kcalloc().
> 
> v1[1] -> v2:
> - Patch 1: added new patch.
> - Patch 2: changed subject and patch order.
> 
> Sumit Gupta (2):
>    cpufreq: tegra194: save CPU data to avoid repeated SMP calls
>    cpufreq: tegra194: use refclk delta based loop instead of udelay
> 
>   drivers/cpufreq/tegra194-cpufreq.c | 151 ++++++++++++++++++++---------
>   1 file changed, 106 insertions(+), 45 deletions(-)
> 
> [2] https://lore.kernel.org/lkml/20230901164113.29139-1-sumitg@nvidia.com/
> [1] https://lore.kernel.org/lkml/20230901152046.25662-1-sumitg@nvidia.com/
> 

Hi Viresh,

If there is no further comment.
Can we please still apply these patches for 6.7 ?

Best Regards,
Sumit Gupta
