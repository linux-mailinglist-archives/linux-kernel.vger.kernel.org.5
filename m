Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026317A6124
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjISL1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjISL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:27:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E335F99;
        Tue, 19 Sep 2023 04:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7rCt1VFWvR14mslU+RUAjA2u7l+sY4zM1O6aD2aA7aMM70zBzuN/GmwxArpEbn4+nuElVszLRvkVJvM62XI5gNTVwKUfdSkRb5fgg9DVc8OBfBcWtzRUOLGZ1OHk3IfL5UVPozkhparIwkqAvQY/RPEu3pYi1KRmOjFHP6DSF975N863GLKAmxRfYTAjQP7WxO06R6WGu/64K1+oq55iVDvUgW7eWk/9rJv0vJytaaf2ZnhR0sDeWmkX3PjciW9FbmWtAwV9fTDSzEux/AHT46mO1v9SKzh+b0Xpu+9RVtm9w0RbDOJ0oRyZc4yT2CkS09zrkDZSHsvaHhRZcqxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo/yd+41TYzvh3X2wkhg9rpyn9hmqRj2/xAYhmoqjQs=;
 b=PS5p3SKxUWwnOqbCJJThLA22wjO1n03QZzQnDVOLW8qWTuhEtjnG60RUSgHwCrLl2begFY0n8ZFkwXFAeRRodxszBlz3Mmf0qJmIH1sm1lW+3c7GbNHWVUExSN7cVTgo1Nd4LFbR0vEOz0O6FtPbYNjev09SndEBAghL6Z5ZDZVYLZlmfmugR8V9qUUCgTKUD9D7EHyuFLnuIGB4g1HLQOy33P768KH2JZ2mBZwyne2Xv9TKgqsWtM+Ka4wLtXUuJAXkZ9TlMarFmHzyISi3oEP/p9DHZIlO32d+IQ7q5uWhAx25t5wMjsbWD80ocfgg2dAZ7NZcPYEbT4o4WDc+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo/yd+41TYzvh3X2wkhg9rpyn9hmqRj2/xAYhmoqjQs=;
 b=dfPYV1JiZcMZb59n+EoV2wyn9HCXe7coNLkMVP6kxo8s/Ie+iA9zvCt9X5NyQkdnnxVZld9VSl/clO5pgBS3Rk0Ns6HdBRzLmDnIhcNPadVOeGvJEQrb0sE9nmBYideSV0KVhV2JxmLU0OJgb2VL1pPaklmmeR3Ou2vtN1ViS5wVOfYumcXiWAGAR04REuSiJbNPgj8A5VYw02vEmJau5UC8CxkL6eJySxH3pX+RFOzadXp0CbJrxE/u3G9sk9pl0p1XlrjGkBQdLIfm7CUVX7Rac64pxKySKM3xHoVWE6A3jtDX1ch9Zbkvnn6jD5NCTcf+q19C92Jbe+0d2tivKg==
Received: from MW2PR16CA0069.namprd16.prod.outlook.com (2603:10b6:907:1::46)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 11:27:34 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::44) by MW2PR16CA0069.outlook.office365.com
 (2603:10b6:907:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 11:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 11:27:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 04:27:20 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 04:27:14 -0700
Message-ID: <c180c1e9-c15c-b4e2-678a-35a388a4a613@nvidia.com>
Date:   Tue, 19 Sep 2023 16:57:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
To:     kernel test robot <lkp@intel.com>, <rafael@kernel.org>,
        <rui.zhang@intel.com>, <lenb@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
        <jbrasen@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230913164659.9345-3-sumitg@nvidia.com>
 <202309140915.2J9OzWIZ-lkp@intel.com>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <202309140915.2J9OzWIZ-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b7be3c-21de-46f8-4c80-08dbb9036b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzWkk+7rL+L2uPAIIHu79xqoS9qjvclWSP2Ka2Xm+aeqak7ERfc7pi6Wglw9PSpKgbzElkFbiXl6VRMiaG6TT3vu+53o39F/5nfKN7T8K12Wsk72RBMxpQWAZO8vmjuf20T6If/lTtQ/yk/XmoMArBVt4AYEL1b4g/PbMXB0j1y93vnDE28EKBxSMIEjTqr0mg2zzWoGB9h06JmO5LEA8nC+lkrVsG3yCxi1mzGYaXxuly1Z27hKTXq6EYWUS6h7yg9L1SUCrynQwYOnj/aJDDbUf5WKoCNslx9nLz+UJXLBrX/G0O+T4Cnp7IA4HGbRg7uBjDGgSNIykxlqG8NO1aAinDDDnkK0gcF0fD4+fdx7xeIVtlt8W3HAXrUrqr3Jc1RPiRhDUhRxt67E9554+650Og8eUyUcS3ITdhjx00b3s0F+y6Gmye8foq16h6CeXWPmgpg4GPlEvAwwo02Z9aH+oHMhgRFnZU6NVx0F2illSmZ02a7DzG/s+pidtXEh48Ss5JeSRqVAPiqZZYodnR4Dxe0bwKv/8STq9KdRIDHoecEvT8lMZQdz71TkFW83gJjqWdzKq6nbva9X8oVqGI+SOEPLGixvNS1AZhI1kWHIJ/MXzQrpa0mTof8XmGah/en5cG6N7OGT9om/jsHEJQxdjNz9iStYywKq3Dtc2qkQ4zNSh4DzO6BeYRT1NTsLeFxQnt6zecU2oP8SyWWVtBk38hrJN3Oe0xt58sCJ+LbafXgC2szsBm2hvlozEKGU/TdK7Gd+7Spxyf68JXVdnfHcNuShCgqNJ0SIWtuCnVp15pui6bHDhkVfHnF6R6/MrQj+X9dNkAjWtdRAea1F5A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400011)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(54906003)(16576012)(316002)(110136005)(70586007)(70206006)(478600001)(966005)(2906002)(31696002)(86362001)(8936002)(8676002)(4326008)(41300700001)(5660300002)(83380400001)(36860700001)(47076005)(2616005)(82740400003)(6666004)(356005)(7636003)(426003)(336012)(107886003)(26005)(16526019)(36756003)(31686004)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:27:33.8347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b7be3c-21de-46f8-4c80-08dbb9036b4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Hi Sumit,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on rafael-pm/linux-next]
> [also build test WARNING on linus/master v6.6-rc1 next-20230913]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-thermal-Add-Thermal-fast-Sampling-Period-_TFP-support/20230914-004929
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20230913164659.9345-3-sumitg%40nvidia.com
> patch subject: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
> config: i386-defconfig (https://download.01.org/0day-ci/archive/20230914/202309140915.2J9OzWIZ-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140915.2J9OzWIZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309140915.2J9OzWIZ-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/acpi/processor_thermal.c:141:6: warning: no previous declaration for 'acpi_thermal_cpufreq_config_nvidia' [-Wmissing-declarations]
>      void acpi_thermal_cpufreq_config_nvidia(void)
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

Thank you for the report.
The below change fixes the warning for me.

  -void acpi_thermal_cpufreq_config_nvidia(void)
  +static void acpi_thermal_cpufreq_config_nvidia(void)


Hi Rafael,
If there is no other comment. Could you please add the change while 
applying or you prefer me sending new version ?

Thank you,
Sumit Gupta

> 
> vim +/acpi_thermal_cpufreq_config_nvidia +141 drivers/acpi/processor_thermal.c
> 
>     140
>   > 141  void acpi_thermal_cpufreq_config_nvidia(void)
>     142  {
>     143  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>     144          s32 soc_id = arm_smccc_get_soc_id_version();
>     145
>     146          /* Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) */
>     147          if ((soc_id < 0) || (soc_id != SMCCC_SOC_ID_T241))
>     148                  return;
>     149
>     150          /* Reduce the CPUFREQ Thermal reduction percentage to 5% */
>     151          cpufreq_thermal_pctg = 5;
>     152
>     153          /*
>     154           * Derive the MAX_STEP from minimum throttle percentage so that the reduction
>     155           * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
>     156           * the CPU performance doesn't become 0.
>     157           */
>     158          cpufreq_thermal_max_step = ((100 / cpufreq_thermal_pctg) - 1);
>     159  #endif
>     160  }
>     161
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
