Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C395B7902A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350685AbjIATxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjIATxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:53:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407F10FC;
        Fri,  1 Sep 2023 12:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG4HH6VEAUp4QzNwUIPAUe5WJv4z9bWT88T1qSB7hyr1GpCfylJ+k4z49VnmFICUFmJWyUux+bGK9xsp0OQe4IeFdzJ68g8v22cTIwOC1jUTvE4zPUxP/Aq3ExjQ672YQfHmg/ub4z0PmaQ3ChrR0eX4LYTUTsPskg/dyi/dbwnw591zBd76KxoV+fEq6jb4UZQKQKxECyd46lgt7pf+PFu4jmzt7UsoBYAc2Gv9/0Jdbhiq+Ut8fTrTdy6dsozG69nHBXqviSD8PpoV1ZhkgWYoxYgOurqka6jaiTF/MdHk3CLDnXds8qMFY5nLMzaf3Huq1tEycYesWk9st5R54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR+Mbb5F3HDaDKAEJTAq7Dyd5sKBNMg9Mk02EdrjV3Y=;
 b=H01osI1JvxYi+GKeN+oA5b0Sopk8EztCsdvgOTSpgaRh58QbL34QAli9QUvButuzvWAXGTkMvjt1Sk7wxttOxvxcifOBxgykLO2Me+fUJ9ImaSic5lsjO7LVolPTjkv2+MEanqSBzji3nKgOJsdvyItijNfqS98mCV4A5K+9w3LW+xXPQaDSpH73knxy+kuwT1fOZnUloICyHc1FADZ7wyyW05POOBFOTUX0i1RmXrD76WkVHoJKKG/x1ZiWbNVQEH/fREDxyG3q0yA+ZstpHrGzm/I4OIxQvfesbs5YA4mOrXuMDUWDm3oDIwKHIh/aZi+LaGj5zQofjt2bV/tkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR+Mbb5F3HDaDKAEJTAq7Dyd5sKBNMg9Mk02EdrjV3Y=;
 b=Ud55h/gPG1iTOlv3uatwozy5u9QMc80WO/ZJPxnuE0eBUML+ZXWSLXMFWU0pAHmqWQp+6TJ8i4Uyu32jpCb50IHDSHOLe85Vr07Bf3uKFtr3Ep2Tc2lNESr26M2QhwPVuM4VHyeLJB5rQTJfHHOMXZUa1Ky8zBKTbYmNmG6GQOy9sBBi6zhMvc749udl65ZVK6i9hvgjfYBKr6OZrE0dH40hj2vFKztg8LIaTQ92vEbGG/fVwb//AldXzfMLJTsFbjiMpoSQ/5O4EoJffnjQ8/Ub/cNJp+zH+/0yIozYFZFBHY10qFvJVg1NQmK4vEO1fEZey7ZD3X8epz2Kjig4/A==
Received: from DM6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:5:80::33) by
 IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 19:53:35 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::24) by DM6PR08CA0020.outlook.office365.com
 (2603:10b6:5:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Fri, 1 Sep 2023 19:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 19:53:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 12:53:23 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 12:53:19 -0700
Message-ID: <8522b877-3f6f-8225-4a9f-512d15b3d477@nvidia.com>
Date:   Sat, 2 Sep 2023 01:23:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 2/2] cpufreq: tegra194: use refclk delta based loop
 instead of udelay
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <bbasu@nvidia.com>, <amiettinen@nvidia.com>,
        "Sumit Gupta" <sumitg@nvidia.com>
References: <20230901164113.29139-1-sumitg@nvidia.com>
 <20230901164113.29139-3-sumitg@nvidia.com>
 <8c26f493-76d4-086e-c353-2f60a4ef7a72@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <8c26f493-76d4-086e-c353-2f60a4ef7a72@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 6070ae3e-4730-4d7d-3b0d-08dbab25203d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxHyoGWu6ZquMgV34wbGdhEciCUzPIwJgrdkUpvJ/m1WKce+CnxsllC28mNXxSBiSwR3SDq9erB0Jxf8veW/gCIhOB964/ln+MAqal+Tz/pCylgpSAKXn00MsADWt5JyDsd5DsGv+aGEcxiF/Gah4HsA6DHpMqD9Rmy/a7m4lCxoQXbOxJ4o7bxRBzWkfpxBCJbm8LHtwNNGlrS+C7PnndRi/SzT2c4pfNgMzt62aWuTYhLD7yr9jVBTwghgNwCyWHqPeOlGOEqsbFCctRXR1siZNHB7Lz7qfgewZqwQR9S/X3A+J5ciISNhpWMvN44O0EbELcugE3H7p5Eb8Nt3iGhFV+FOBMS0ckVh1tFZjY7pENmqOpVAhJELV74+Vez+O71VNc9xJHTPUaId8ugTRHJ1J41o+9SBw8ExEonTWyegWpS5q/6qa+cCh1XOWqQyFdtRCkrcbe9DnSTB98mSMtKWwHi+6i1Cv+WtV3X1vLKR1SNWCuA8/4AnIOcMb2L6CmFEXnbj9wd1+z1H3QFcHO3c711uCQOlXZ1ahmGs/lEy5IAjfd4mPn+1Dpe06sR75NGMKa8tkSgZBGyRv+vBA64rl6TkmPA6HG+6sl0+Z/f8qG/bIJkfDuKNicAt8Wl4ISwJa4D772dPa+Od7nuQYYR07vfBkLPnzRIFJRdngoPNYA/3d9c6q+sJxr+bG0qqjRTMSf+kEe8yMdl7/2eVU9uWdtj7tUNOatggwzIuIihu80GYQuDVkprNfBd6XCuuh+1tJC3JZE3VskA9lEgzHg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(70586007)(70206006)(2906002)(110136005)(4744005)(41300700001)(107886003)(2616005)(31686004)(5660300002)(478600001)(4326008)(16576012)(54906003)(8676002)(8936002)(316002)(6666004)(53546011)(40460700003)(36860700001)(36756003)(47076005)(40480700001)(26005)(16526019)(83380400001)(31696002)(86362001)(7636003)(336012)(426003)(82740400003)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 19:53:34.4674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6070ae3e-4730-4d7d-3b0d-08dbab25203d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/23 23:29, Jon Hunter wrote:
> 
> On 01/09/2023 17:41, Sumit Gupta wrote:
>> Use reference clock count based loop instead of "udelay()" for
>> sampling of counters to improve the accuracy of re-generated CPU
>> frequency. "udelay()" internally calls "WFE" which stops the
>> counters and results in bigger delta between the last set freq
>> and the re-generated value from counters. The counter sampling
>> window used in loop is the minimum number of reference clock
>> cycles which is known to give a stable value of CPU frequency.
>> The change also helps to reduce the sampling window from "500us"
>> to "<50us".
>>
>> Suggested-by: Antti Miettinen <amiettinen@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
> 
> Same here.
> 
> Jon
> 

This patch is newly added in v2.

Thank you,
Sumit Gupta
