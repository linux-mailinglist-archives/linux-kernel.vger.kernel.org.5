Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CC677FDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354469AbjHQShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354478AbjHQSgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:36:45 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579412D59
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxtzCte5TfzHctYj17+Bw9+zTYx4X03gvXyxcqa1yD07JASgb3ts3+kAN85sdEnRmwmMcXoeqXjNboJ4h92RIHUnM+9di4nu4TQoagL53MMoC8CGkhFI6ipGykIdTC3xm7K3y0AV+z55n31BrWviBAG8ilK6uKJ3g7sTCECZ3XTCDItq4xErN2wQm22eVhH5n0tRHlZjMQoLT0/iB5h2xRsI58MhJPqpi6HgpSXTK25Q8x9oNblpc5WNrKKWI7iPS6b8Qwdm1yZNcOIruvwRcXpenr7oPa032VHDZFtBaLtg3Q9mjGEKVhlenbgiYHBjtlSfWj00duaZTr/X30GulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzBpGDeVQqC38vAD2xI2mFjRS8ge609yqAWohJWMd08=;
 b=RGTKGVexvHX6wch4exY2ocZMaTNy8Q1inzDR3HkQyG0VkSsl7RtuhgHmwsOFgEVoM+OF/ZXO9W83OStM2wO3HxvwnwZ5ABrHny27u8UJ7MwdqkvwelNSKeoVcZ6W4mgGjAp7oluS3vse6bqxBWqx9ctkPj12PZBRNcTnYtUcGJBoYDRuyhjZSvsJp3uclLNMrtdKhHin3yLYP5/DAzv2RKXUKMDxiuBB3AKuxkbTWZwHum16K1LJHxugCV0EoOIzq066Nq4gGdDFd8f718mJpBOQLRjxFEJY6cl6Mub2Hp95E6c0VmT8SzTYqTonWttxRWjWA4HG5Zau7ZKawrDEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzBpGDeVQqC38vAD2xI2mFjRS8ge609yqAWohJWMd08=;
 b=oB/QBmWNxE8IfPqCxNjzW5Fs3yz6a3hVdF+oigzW7gMAUXfgUBzyIBXtp1zRIVfv/QIloccqB9n/JnttJo5+9uQ7DV7q+oiGuTv+yF+nSt9Zudk/f2XeHTZWTTkfL6r1voWNp8dBcgSs/hDoIs1DpXQsRPNTlNkvg73vybw9IZ1WtIf7h+kp8fDPFNBjL542PkZoT07zUWC4akxgB0mabPwG73MRbzOCoRUASNYTpT4HTN7jpKsyWUECSycjjbx+x4czNVrGb6SRpCWtEmBv/gqVAa5rJq5SWbZLMKbbCHYf2sL5+hohm8gzuY4+MVNUkomPHzP5DbbXMTnVt0Fp+Q==
Received: from SA1P222CA0084.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::25)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:36:41 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:35e:cafe::3) by SA1P222CA0084.outlook.office365.com
 (2603:10b6:806:35e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 18:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:36:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 11:36:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 11:36:20 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 11:36:20 -0700
Date:   Thu, 17 Aug 2023 11:36:18 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Add a user-configurable
 tlb_invalidate_threshold
Message-ID: <ZN5oojF6vKOKB/eI@Asurada-Nvidia>
References: <20230816204350.29150-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816204350.29150-1-nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b347fb6-5d85-4194-0c47-08db9f50e62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76iWY9Ke8JapGx8GyXecPVFBozTJE5qwhcG/TNecYZfDahEGidPvAiSdRYCju4RLLNwYqAuDgwpjtM5CW9TZzsU+COQGVIAmD/m29KyTEQmtxaAlieC1JyWgJ6i4teWSNB1hfn63houjbBXbcW7TYtkXGG6fwJZ06Dlo46rKgviCYi4yeEef6xRPoZLic8WRDeRF4fNsxwFLaWhrs8Svv2jhRqyS9yz4JM8spdgxjjwn//sKjQ/IJkagERTSwQ9UHVCMmrh92wBvx5MCTdXj2nsc520eioaAVBIZmgWI1FwqgIK0VW/LGdiGZZsUjniopsQsiuT+XG+fFYG6ZWAC7b1XDDplwSbNvtbY5uQhO9LCABZBTrOZlypmnPMRlVY2J6fi3OSBhxWdiGF+rNHlNUeat+NyOaot0hf/Xl7y91m6+Au5cjSKsUtje6csqECIe1VPn4l+pKJYWYIduA/a+fiWE4ReyRL+1rVM5U2SUD94o6/OsfMtlf6ei0lKJjxqVFD3T9ihKLpEu3opcYiu+AVsf58Z5CfQnngwvGhYoMnbHVJupLw/3RYTnHoyM6BCSeVrJIS3kOH6xXkd+rpXtQJ4/7erhQcff7Yw87Sksd9UQ/D2OmBoygl/YGRuDW26Pwp7M2WV+w/I0muELWWS2xF1LelxrHhluN94Vtyl7Us0jOv7K1a06I95Alov9qygghV0homQnMkA1qWpv1RecgThUxfZVqq9GFs8Az3v/xVWMXTcv1aJWGuRNX8xZgnA
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(55016003)(40480700001)(40460700003)(47076005)(426003)(83380400001)(2906002)(336012)(36860700001)(70206006)(70586007)(26005)(54906003)(6636002)(316002)(478600001)(5660300002)(110136005)(4326008)(9686003)(41300700001)(8936002)(8676002)(86362001)(82740400003)(33716001)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:36:40.9366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b347fb6-5d85-4194-0c47-08db9f50e62a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 01:43:50PM -0700, Nicolin Chen wrote:
 
> When receiving an __arm_smmu_tlb_inv_range() call with a large size, there
> could be a long latency at this function call: one part is coming from a
> large software overhead in the routine of building commands, and the other
> part is coming from CMDQ hardware consuming the large number of commands.
> This latency could be significantly large on an SMMU that does not support
> range invalidation commands, i.e. no ARM_SMMU_FEAT_RANGE_INV.
> 
> One way to optimize this is to replace a large number of VA invalidation
> commands with one single per-asid invalidation command, when the requested
> size reaches a threshold. This threshold can be configurable depending on
> the SMMU implementaion.

I'm rethinking about this size-based threshold, since what really
affects the latency is the number of the invalidation commands in
the request. So having an npages-based threshold might be optimal,
though the idea and implementation would be similar.

Thanks
Nicolin
