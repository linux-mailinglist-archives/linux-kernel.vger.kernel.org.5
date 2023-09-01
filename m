Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB417900F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348390AbjIAQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjIAQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:50:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E510F0;
        Fri,  1 Sep 2023 09:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvtOwAr0qvFT89bEfi1JPxh+yqQKLneAznNo34oReFKdoysCvNonL+VDrwsJEQ/D0T6c3dn/zzGaKd3PMR4araF/Bvbt+4vtn8IdVAEdVwcQVL4AOasyk7YDl/O3Vky9YmtE2fEi0Z9CqOY6br/NX33eAxJgi4EyhMxXihb5bs2rH12I80zhxXdZjyqqVC+pKz0f8jEXUcM4kt172pOP4yJZaZcXZdXY5d1A+0aYbHNJ0sLBLVgyWCbX2b0oPbg85OjuObNMT30RyzBUM2h2hHBFWnrFE1Ro2f7k2qqoP+wSorpiEuyIzD4rPRfqgYg9VtwmBPMDCiQp2e/s69UYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ys8GrsxOJlCStgUdmcsYOC+HqGjJCYt/qI1zipvoK4=;
 b=IiymGNRjQuzSQKJtbT0r3+66+VBpUbNB+gQOcIBq8CQQUM6d1UAlk7NLroMEHo10HbUWuWX58VGap3AWtbmCw9QKlFL+B9EH6iaXUZ7WzLufOLkWE/BOJX3id5ai/Ll9sQPfaAPCQhRdJZqO7/kyt7srJiwRnntOXNOAcLtqEgwstUJNdi0Xvyny9kA1GrzqW4UHU/vZ1pLGBvCd/ibXWNcY19QoSNE36Lvy/pXj3PeNRFuomtXNuiG0HmCmnttM6jbulDPXqj6xsYujWLdaNALvoJJGNj/xr6sSncRAJ8dn9fPN9tq3NPzunPAuNIlPz6Y2Xzc+5OndL3Scalbkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ys8GrsxOJlCStgUdmcsYOC+HqGjJCYt/qI1zipvoK4=;
 b=gjV7lmkC567hr8Xrcm/kucYssSQvCp/KKsSrDG6HXWI9lR8uTokQc3ehk/xUtcF1I44TFp6lnOp5QfZJzbdwAS9HXOEIGoVcx059FsMIN/QLXcqT2Er6jMdk+rNbLnf/LGcps0zfW9RS72F2/kcW8VNQZ5l/3x8Q8oB1GSpCeM9bR5rJvTn4POj0Jo/5OWRQ2Hkmy//E6quNPiEINs0PCZIx4oP0KGTxgJAMgantgIDI0X1plCCdrr8S2/+P7cdcFyeA1vuoWvUgDCuVP7ysqJYgvtYK31z8LvqH/100VH2tPiG8ojIzIFLd8h25IttFxZyQqHuJrOx8xMaKrWp/CQ==
Received: from CH2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:59::16)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Fri, 1 Sep 2023 16:50:04 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::c2) by CH2PR03CA0006.outlook.office365.com
 (2603:10b6:610:59::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.25 via Frontend
 Transport; Fri, 1 Sep 2023 16:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 16:50:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 09:49:52 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 09:49:50 -0700
Message-ID: <f0059dd9-e258-80e9-bc4d-c8ee0c72a754@nvidia.com>
Date:   Fri, 1 Sep 2023 22:19:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch] driver: cpufreq: use refclk delta based loop instead of
 udelay
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <bbasu@nvidia.com>
References: <20230901152046.25662-1-sumitg@nvidia.com>
 <c2bc6447-d8de-4f0f-d735-df377ab40f1c@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <c2bc6447-d8de-4f0f-d735-df377ab40f1c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: c32c6e00-c31d-4e4a-3023-08dbab0b7dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9Mw824b24Fn/e2kv9X4asS/BdLMJbIC3gRNT492nVdn4+iVdch8NAmIs/x5qw+4UOWLJzy/jwgoav7p5gsPqaJMq7nWlv4MDPaszCdIxb5ZF/UHiJfLcolZ4HPWI1pfG/5Nz5oeSgljuhfaN7Qnrl/67UJlhI5RcbnJntxpID5j6of9mB6HOoyC5oQhALk0sUv6R7M/acrOSMhYWv4UAxdZmxXIweqtusRQVai6QE9epfGiZSdZaNGmzee5Zj/K6U/mQ3+ELAgiJWu75fgNZMqwdr6hrISEBjejb5kS/GhVzx7N7Xl+3uPjpOx/aZGOYWu1vtifwtgzv4WNsAUrmkW/MD+DyY0Z0Z7N0D03pgnaSFWRQhbvFd/FNoS8XEWDYqrSVs9qTsUzinkGYIui3B1fY4adCsU3Lo9CNljQ3s3JJJ+ti/NEGDvIXhCRcVjPbX5KfBecyHEjKuNJVJhXxqPdFnryXN8OzqCDxj508fmxzDkOlvIC/DYGfBbIsaYvbnVNOdKbCsXzKQdzWRQDPfXJlRBGLL3aWZSZgby61rylCEU/XmbZi/eUNtftJs9F9oUvHMrW5QLmNw+7bkHV4gNC9/56C+lmqxFVUMDfw+por8Hy0hZtBi2y33awPSDTABB0zw8EoHzaiToRQyuygTf/83vMrhwPzSK0/4+cJAkNZU5Eyr1gv1YFWZgT9uPnyLpqS0VHzr67bvulwr+tTKndzw5BO3/pQ7jeFIcQCeL6NWKC9b71ygln+fy2gKV/n7/PJq+dO1LUE9EjjNYJzIEZbfyy37JGgI8O92SVlU4ZmDU9dXVHW8F7VX+phPHx
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(31686004)(36756003)(40460700003)(40480700001)(7636003)(8676002)(53546011)(86362001)(5660300002)(41300700001)(4326008)(8936002)(426003)(336012)(26005)(16526019)(47076005)(6666004)(36860700001)(83380400001)(31696002)(107886003)(2616005)(82740400003)(54906003)(110136005)(356005)(966005)(478600001)(4744005)(2906002)(70586007)(16576012)(70206006)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 16:50:04.5436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32c6e00-c31d-4e4a-3023-08dbab0b7dd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/23 21:28, Jon Hunter wrote:
> 
> 
> On 01/09/2023 16:20, Sumit Gupta wrote:
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
> 
> 
> Please can you correct the subject and drop the 'driver:'.
> 
> Jon
> 

Corrected subject and added another patch in v2 at [1].

[1] https://lore.kernel.org/lkml/20230901164113.29139-1-sumitg@nvidia.com/

Thank you,
Sumit Gupta
