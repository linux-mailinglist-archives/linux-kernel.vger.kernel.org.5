Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11BA7708FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjHDT0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHDT0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:26:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF0DE7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1K3Ut/mOPqUwcG22DKkMRZV9oybwTgRhHneqAiDF0ArVk3VGn5PqAzfytQEUzZLy85TcUBHUI8SWdeQ1zLbWQfRe9ebPg9WNxKijaythHY2C2FyXqTdAYxpcFQLzmPlfaA2sxqZYJpL8yezuEqHNyBgrD8xJt6Oyy0T7NFZFiRHec26G3l3llCljFFMCGDXU86SHkZD0DNx61NA+pseCXn2ZXi4Xo2y+3OCCwiEs5VBD+/uUH/8Q/fHgCSpAnXK/4G8x/BffebaKWvIyjpeWsFQF3s986+B1qclbiuacxEU8ywzZdxJGgIDCS6VkB/RL3+2crYmLCVTbyXO0QyP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUwcob6GZN0x3UIDry4AkTzNuBEnj6g4vUtoIQyOMPE=;
 b=HtI6Q6gW1+FUvYoix18ntdLvyxQc3ctRnkw4zqM6arwieEFhKZDqpsnX9CBD7NX5IyJkIiU6oW3lUBwGeIAstKNlECVq6UjgV/uFvES6/2N8PTUKxznEPZeT3e/zerhS4PR3MWtus4SDbZUpVuT7GomEoJOXsSUxpQxT2Exeedgjy39fyrgftC7fXLaai5tvKwb4cdcYuA/HG8LXnjLljdKbYzcscfM2Tz2bjdQKlR1mm9/tDQA3iZrPFecgXfnilu9rjBUp+MFA+o5Fp2hZkmNcTeytwiJe2vZDKJBs0N8WYUsKqqigdn6y+hlqZitF3d97Wq6C9/paX2i9ISWkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUwcob6GZN0x3UIDry4AkTzNuBEnj6g4vUtoIQyOMPE=;
 b=m2j+HLV8Af/qFPRc7ihG8f8XaRKPpv4d1SuNbavBZf2Utc99z7fGcbH2VuH5ZpStI2LWZSkyhyMzHyiQmpmnqkTB9nzHnPbfct8ZLtXmFyyUXMXz4Y6TNkR/NVeQTu2TygxZXLmKkGC27wmjYXqB1Z+yRAalrhHr/Hvg9UYfcSM3lwufhLEyMi0gQl8RrYwoO7+mvB05xoQlynwAVeoIUIuQ6ZuVpIY+lFX2qirktVLPK5A6ayERS4rMTptSf2nxxC8mUviQg3h6rHzm7U2GlvojdHSUk40dlNI5KCuEV+N6UPWa90v80Ez0N3fRgbJadiaNGrUzNWiD1VhMy2ffOA==
Received: from DS7PR06CA0034.namprd06.prod.outlook.com (2603:10b6:8:54::18) by
 SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 19:25:56 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::20) by DS7PR06CA0034.outlook.office365.com
 (2603:10b6:8:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 19:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 19:25:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 12:25:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 4 Aug 2023
 12:25:45 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 12:25:45 -0700
Date:   Fri, 4 Aug 2023 12:25:43 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 2/8] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZM1Qt6uCfFDLpOJE@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803003234.v4.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SJ0PR12MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a4abbd-9d53-4c75-f1b7-08db95209ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awzS0K6fa02GaCbllI/ilTdxWwVdXKUWdnnGxftQGcUTVBXSFK7T0C86ZxyvdLfLQAxUJp6WSzK/jfiruu7iVsGT3LIYdiTZFtRsQ1nbIth3mJj43/h5iqVBg2tP9b2sZlrPjMoj+4A1gdc0DPVZIb81IeVA2zjXBttMu6roucaDiZnOaK/msz+XeEuv8SMky84fijgamedAqkHLYJHFTfLlNsc3D5iQ0tn2hcCf6ldHTY8ZjGdwcxLLuiOLNVf3EUUcR7Rvo88JJUC2w96kkUpecX9Ga1BHY/F7esFenpOZsgMtIJAiSamI+Pp1VqQfZKC1I4gZdOnmuDkV/Z+JBClr1G8nYAr0dZf4163+lxF7oxy/06fOxqrKe3EgrESNbezphwYJve/6UkQyPI8IMiDW3Og8lW6frlSogeD47r2YrBnGfOnp6zo0oBr0UVRkCDFBFctK4Z0eEZcNZiDHm8KOVamPAAI2DqVbvImQWwDgxYYjWq/9F74hzwNf4/P1c6v75wNXlCCDrc7uCzYhQTcxcVinkkrqUYK5r3j2wLb7rdcRjbFXeMCK88exZxuUg3DhMp5syxxg/DALmGbuBAeyNchKKD/X6JL/ek8vaM2+WaVcGe5uY2AUaiLES7Vzw/9edjCq+4TkQGL2Pp6X8hhF4qqfjNaRQFpGz9D6lcHLdWIcAI+SLP/llF0sXqiqnD86fYkowRjbezH/hOIE9O6Oe5by3XKvnpiv9siL3lCcnJARMWNPHeRFgqgqrIftSaxtABHmfUwXy/vGC57drQG+Gd6MSOk4Ywl/GhXHvWg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(1800799003)(186006)(82310400008)(46966006)(40470700004)(36840700001)(316002)(478600001)(36860700001)(5660300002)(2906002)(426003)(47076005)(86362001)(4744005)(356005)(7636003)(82740400003)(40460700003)(26005)(33716001)(40480700001)(8936002)(8676002)(41300700001)(9686003)(55016003)(336012)(6916009)(4326008)(54906003)(70586007)(70206006)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:25:55.7413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a4abbd-9d53-4c75-f1b7-08db95209ff9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:30AM +0800, Michael Shavit wrote:
 
> Remove struct arm_smmu_s1_cfg. This is really just a CD table with a
> bit of extra information. Enhance the existing CD table structure,
> struct arm_smmu_ctx_desc_cfg, with max_cds_bits and replace all usages
> of arm_smmu_s1_cfg with arm_smmu_ctx_desc_cfg.
> 
> Compute the other values that were stored in s1cfg directly from
> existing arm_smmu_ctx_desc_cfg.
> 
> For clarity, use the name "cd_table" for the variables pointing to
> arm_smmu_ctx_desc_cfg in the new code instead of cdcfg. A later patch
> will make this fully consistent.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
