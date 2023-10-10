Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2E7BF467
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442490AbjJJHfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442452AbjJJHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:35:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5621F92;
        Tue, 10 Oct 2023 00:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgjOKFbrxsNPoUg68YUgTkjYVZG4qTg0lq9ggt+J8h5jjO/rIz1m2k74qmT1T5zqkHfgOy6Bw8IBM6X8Idh5FcMkr4JARu11+ppiKcA+eRSK69awOCIKzvcH9ZL+Cly4cbeHNfKNeHajEW1Ufxx91iZjUyyoHGO8wPXOw6kgf1q5SQArkYW6t/8KtESsYbsUw7RfUVPKGyUHenPuDB5Pvnad28/XwmF2706DPDoHiZbvv0yIsbIZecuShtjn7v6dzZ+o2dDY0NAL+WVRRcsI9nlLwupG7LfZz2ZTCw8baS8t+CiFSNOPXHwx3u0v1TowixEqmx9/uZhpKmtZyrWudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SUC4r6VzdLQIw0m+sDYTJCkK/ios2W1Bv0D2f7Utx0=;
 b=AzGvu7GDgsagR4plm1xgQHBE/T9CmDVoqv7aqnJOS6dA8Te2t5dgZchj9I1W9StfgbU8ly4PSmazkcInMGx6m5yq/2Ff/bIKStT8KlQySiEm1d5jcX0D6InUQ4SXVadfZxYxQ7EY6G0GavfI8GVQopmYFUFBBuuE30e3LCRkHTIWaXp0Wd1shT/Yve2mghQJ1/Nf6nt+KH19zp5tT+Zn1rA2jHi4+ykfz+E8rNsmmtCpj9tormd+BArvxidABdf7Tjw4P1xibwhqzf10echPncmZFX0IyYnNEz0x6OtjEIOXzO40DGvLrTPeQlmpDr/UBPO61SN3QPTXNMAM4c1jvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SUC4r6VzdLQIw0m+sDYTJCkK/ios2W1Bv0D2f7Utx0=;
 b=mmgygM2H/B1M1JasgPQTab84sD0QGTA+O2QJnfeiz0oKUwOfYVlg1U/MNMMwtR79jVCf+JZfaozHFr5F9MWoUHNX5qXBVbtYi31Z6ns9cUIVEKc4A4gaIMD67rAleZYvjBU+2SkYj5NZ5ei4hoZiY8032GPw65M5ovPzRs78uYUVD3WSu6Oxen+/86qq8ZOY30NpzvePB+GEFyzrReGZr/nTr1V89rjMC/xhabUkxW5wUpNkWr/KK1WUVIcRdj2EiJzGcmsl+NB4BSIYqEHpZVl+AA9l/77syLUiH9PsBJqEeu/RaovA/ubemMlIDrK4mw5tDBET4lKpuOBnSKb3Aw==
Received: from BL1PR13CA0209.namprd13.prod.outlook.com (2603:10b6:208:2be::34)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 07:35:45 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::d) by BL1PR13CA0209.outlook.office365.com
 (2603:10b6:208:2be::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Tue, 10 Oct 2023 07:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 07:35:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 00:35:31 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 00:35:27 -0700
Message-ID: <6d2b652a-17bd-b6ff-03ed-081ab299da56@nvidia.com>
Date:   Tue, 10 Oct 2023 13:05:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v4 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, <rafael@kernel.org>,
        <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, "Sumit Gupta" <sumitg@nvidia.com>
References: <20231009171839.12267-3-sumitg@nvidia.com>
 <202310100219.lpVzbckv-lkp@intel.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <202310100219.lpVzbckv-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dad434e-d451-48be-e583-08dbc96383d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mb4kizZsrkY8TRr5b97BkxurYuaqfVwi/bdTJ0Gm4r5Wv9E6bJRdo2CBq437h99rTf7T3SBLZWG/PzkUjkiQUDIRvbW94yweHfga7kvygUFppyDSYk0IolctLPqCV21TNyVBToxiw5FHuj37zc/nH3CiL1f9hqloZkRMFYy2CW6GGhM9qQDRrAP8vhi7ke0ynU2SSTWLlk5iKBnqWCsz/u0l+jOCsVKNh0GlBwBvHX3qvBEA5kxoJtS8yAEiQUahYRQc1IkdAeTFpwNYQ7zXez9ecr70Va0EXIVoydVrERK9BTKCk7L46n8GnG5pk3HuCeUeiF2F3yTiMBDKRz8xe5W0lVp4RdajJfXbw13NIDP/9kN9z7PkHp8U1fC08KszqDDhZWq6+jbTQ2PyUXaAJwyfOZXsst81dq2uln8XCR1v5WZLTneSq8WKwETEoeAz6fd/s/yMTN9RseqdUvXA+vCYeEhoZB1zdhYZLRRIgCMhF/nKxXNo3JLvfuYGQqTGYn71b3VkjlWVHQZNeESEnwawtUk442F0ddN6eIuY+fHrDVn0ecStSmBr+TYeAt3Jtc3p6PPcGyk5vpAJHKDTE2k+vU+A0sQwx/ryIZSBHxgbuU9H4cLatOBhjaQkyYYG3/nghw4B2ivRaZ2Ja4k78BA7nMxIi9uhIolgWHlrhbQWiRvEwquODmpqDOTpFalKXk0T9Di1c933GGWEwZgqiejKKGzjPnpP8/lBM5q3RSyHd7cYelvs7TNkyMnLzj5yl4c6FR+mqrhcvptsjqK5WRxeegmd8rfD5NYEmKViZHo=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(6666004)(82740400003)(2616005)(107886003)(478600001)(41300700001)(336012)(47076005)(2906002)(83380400001)(426003)(70586007)(110136005)(5660300002)(16576012)(54906003)(70206006)(8676002)(4326008)(8936002)(16526019)(26005)(40460700003)(316002)(36756003)(36860700001)(356005)(7636003)(40480700001)(31696002)(86362001)(31686004)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 07:35:45.2000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dad434e-d451-48be-e583-08dbc96383d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Hi Sumit,
> 
> kernel test robot noticed the following build errors:

Thank you for the report.

> 
> [auto build test ERROR on rafael-pm/linux-next]
> [also build test ERROR on next-20231009]
> [cannot apply to linus/master v6.6-rc5]

[...]

> All errors (new ones prefixed by >>):
> 
>     ld: arch/x86/kernel/setup.o: in function `acpi_thermal_cpufreq_pctg':
>>> setup.c:(.text+0x3): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
>     ld: arch/x86/kernel/x86_init.o: in function `acpi_thermal_cpufreq_pctg':

[...]

>     cpu.c:(.text+0x128): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
>     ld: drivers/base/property.o: in function `acpi_thermal_cpufreq_pctg':
>     property.c:(.text+0xa87): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
>     ld: drivers/base/cacheinfo.o: in function `acpi_thermal_cpufreq_pctg':
>     cacheinfo.c:(.text+0x231): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here

Below change fixes the issue for me.
  +++ b/include/linux/acpi.h
@@ -1542,7 +1542,7 @@ static inline void 
acpi_device_notify_remove(struct device *dev) { }
  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
  int acpi_thermal_cpufreq_pctg(void);
  #else
-inline int acpi_thermal_cpufreq_pctg(void)
+static inline int acpi_thermal_cpufreq_pctg(void)
  {
         return 0;
  }


Best Regards,
Sumit Gupta
