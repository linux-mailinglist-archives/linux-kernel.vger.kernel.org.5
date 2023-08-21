Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72282782810
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjHULhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjHULhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:37:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBFEDF;
        Mon, 21 Aug 2023 04:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2Vh4uepDXtXUgf3Ns8rVfYJ3TEOq/oSt4375dfsOlGbgkzpEm+rjPnOkTeQl115hZ7KUyeOP2T2aiFN0vWyzABottFvbHASuy5vFSeqx9pvyLU9W9oPV5mi+zdKc7ReuSahytiLEtQ2qPlUThVjxKGlde8/wZeho1uHpWOmr++1zAfHE5W7InHUCSAiA14YvAuEfkUFOvJ73EPhp+YgQI3euKRnSWkMCl/RTL0/X1ZXBzv1teQrpyT6AKkWS+QpcD+TEjs+XviihTO73jqkYKxlClxkp0Gvj2Ug+L306HvLigzIkQbp8RdbnIdI8AgMq3vM/EhPzvw1ieZYH8zsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+915wjKjs6ipNAXE/xlqWT6Lny3n5wVHkPwevCSWEc=;
 b=MAb2uV7iChLtYzSJ03M2IqjU++xsOJKL4eG79YOcRV4kjpDcgDRNYE2xqcc4x6w1FHKQKbqVDNUGJxXmCKhPUf0sHCongditEmEW2VY6hlzoYSKABdTJc5Es8pJnUAYdkSNABgj46wHpRGuIFY465RsbrrQw+Is6XCrVOPfjmTEXXpMMvp9xb9MtRiO8IOoliepf5bpJ0bldBTZ6oqNEc5e8TbiwB4ejHXiqpOCZDESTaJlF86L9DMXMp9HfERy+bE3zdECG7B1zLl3LKER8lGyWN82EzJ+djmfhXyUPG2XCT0QxY4XVxmOnC0Rx4QwNKuwq0/LrGNUP7jpA7w+GVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+915wjKjs6ipNAXE/xlqWT6Lny3n5wVHkPwevCSWEc=;
 b=gsZRFEpECXZ5J8uVocafLP/m7jux+YHwrnpe8ps+fGY0mWQmu+a75Cg7fVl7/yJEKeFbj7SPh+pmxq21cNLx38tOO3urkWbw0H5/QO3l7/s56URS8d+0Z05Hm3PIBLmvguRF59yoI+iK6fJhE6YEWW1oUYIc2PAgUUpqMM19htMMNtDG+y9i/zAtQ/Na0pnVSgK+O5QOGSmzRBoMKKchpnu+8H0wiHKIVegxAHOHiiTd7hOEzGHTXKOBd5KuZrNWuJDguf/PcY6lc4cwExnAZvJMT/GaJ4XSSsCYRv7QBRGuZV8Ht6Do7orO2UrvYWcD4/jBRvwYMth1hmbk6Xeuyw==
Received: from CY5PR15CA0251.namprd15.prod.outlook.com (2603:10b6:930:66::23)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:37:09 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::a9) by CY5PR15CA0251.outlook.office365.com
 (2603:10b6:930:66::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 11:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 11:37:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 04:36:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 21 Aug
 2023 04:36:58 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 21 Aug 2023 04:36:53 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <arnd@arndb.de>, <digetx@gmail.com>, <frank.li@vivo.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <sumitg@nvidia.com>, <thierry.reding@gmail.com>, <windhl@126.com>
Subject: Re: [PATCH 3/6] soc/tegra: fuse: Add function to add lookups
Date:   Mon, 21 Aug 2023 17:06:45 +0530
Message-ID: <20230821113645.4373-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZN961t8WesCG2J0+@smile.fi.intel.com>
References: <ZN961t8WesCG2J0+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 334d04e8-d3da-4492-f6ef-08dba23af3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gVE/srFpS/hO4c08tW2xECLSh+copSm3bNTB8zhQ8qiHL/q1EqD4w/LBQMpK8E3Miwp7ymDOnv9GUf2+V7FfEk+5V0vdwpjgGdCGWSk1AVQFmV7UtUMcihEMPyO83QZLrUqcfIwBj2KMS9e+Zk/32kdDhdNRHbJJnvuJdCKYFAdIE37NPQ9tHNu3yEue+PLjqBYbpke0MWCIXPltrV0ijng65+ngClp2pfjUAdP10ctqCaukx/PEx7FxXaNIWkCUXyLnStMTZ5RhtkY1U4NT2Teo3ndxRSKZ/wU1bs59ec/DRCy7Mu9j7t0/TfSAPp2hFIGDUkbwLlqOUMCmzK990DR6jLrRFp116Pj+2EABPZ8URK1nKIUW/9L2T2YuTkitPacN9ds6pjArozDdWUUqAyiW3VJZdqdxGy1T10elxI+P24HhBT/6ALrQrciRfg8teqep8yu1cA3of9ODJwq2dUAijlR5kS9M0tN2LSyWVW+h/lYbwZ25yShTeumpVRC4FP9z053TMHC27DLCa+P7YhmQtAXOLCmPSPiZP1gA3RnetobwkvP17byJzvlt3s6BRK5HrrV0V4WhIlYcbKHJKb9Q7Q4f3rc4Mk81rByjvZZHrgenCRaIJhukNfiFuB34/HxP6wXiT5I/6vrI8CsipMoVqTe808SXt8sRchQyfL1OkgaQ06DPC3Y7zaq6+e6rQ7pR6fIKUx/qwvTxLAqR+QRX1sdnUkYBcNJ/8AKo9DibPEc0IQ6twqHS13nUiMI
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(6666004)(4326008)(40480700001)(8936002)(8676002)(316002)(6916009)(478600001)(54906003)(70206006)(70586007)(41300700001)(47076005)(7636003)(356005)(82740400003)(36860700001)(26005)(36756003)(426003)(336012)(40460700003)(66899024)(5660300002)(2616005)(1076003)(4744005)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:37:08.2751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334d04e8-d3da-4492-f6ef-08dba23af3b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-18 at 17:06 +0300, Andy Shevchenko wrote:
>On Fri, Aug 18, 2023 at 03:00:25PM +0530, Kartik wrote:
>> Add helper function tegra_fuse_add_lookups() to register Tegra fuse
>> nvmem lookups. So, this can be shared between tegra_fuse_init() and
>> ACPI probe, which is to be introduced later.
>
>...
>
>> +	size = sizeof(*fuse->lookups) * fuse->soc->num_lookups;
>
>At least this should use size_mul().
>
>> +	fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
>> +	if (!fuse->lookups)
>> +		return -ENOMEM;
>
>But ideally you need to add a patch that brings kmemdup_array().
>
>Okay, it seems it's in the original code :-(
>Can you add in your ToDo list to amend this?
>
>-- 
>With Best Regards,
>Andy Shevchenko

I will update this in the next patch.

Regards,
Kartik
