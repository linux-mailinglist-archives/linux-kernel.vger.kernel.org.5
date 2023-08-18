Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2078117E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378912AbjHRRTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378926AbjHRRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:19:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7EF3AB9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgw12ONzO/abZreGadmRXKc5zMseQBOCacECfNrwMLdhRH3X0+g/TbLbNo8pt5LwupFteHgspI5KOJNaQtMKwuUPi11wpwYxfMZLPgXfVboVzxHlPrYhw+Y0II7DkmC5GYVgacTrbLorFMZCt7ZZywWNzRSTX4DaG7sxcO14A1ZEXiWyzgiffK/BhTYHul6Bpwgi0Eq60zIIc3n4P5R2vCVTMFJxQ+XgiRoix951l/YBt60Fa1nZB6ALUr60WE29Ft4bBj+5NuNEwGdW8WJ6qDjPodKcib8d+gJKTUQGvJWv8nBb4Ux6B0q3GyI8IJwtvFLPUSIw4QTQz7yt+DvrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLvJNsjCzZ0qh044+zwSojJJSFsSt8DMTsqqUcWPP4g=;
 b=VkrlGFUyr+N1cfohyltJhxc0LHkXVLAXR0M+9+jwjGUHv0hcaTg9ABQqVzWV21BXFFWsBMe4NH35tPeQRcpSioGAC9gywc+6hFsyAacVqpEE+rXYmBLWR3bx4MjkQe17gqPZOx9tzZZAKMgKTzpKKsc2gqS7s1NTBAkw9PfXqeLK4fkB2Xh1hg40Lv3soqGxu5sCmvJOkhJdYr2z8nGtiZmAp3NAUzM9c90TIsNmYqkyE3T0AwMswI/C9Dfq086Z551c0YQwFiJ0r1r/FiR+7ytQ0i6ALncRo4bvtmtNu4XjEhNXKT+xDLHNfc/RPxQou+vXU/s91ad4KvR+UHp1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLvJNsjCzZ0qh044+zwSojJJSFsSt8DMTsqqUcWPP4g=;
 b=VCj67/vhJoN2Dwp3KujhX4LsaDStf+CeBmVEyEP7c2VX2Kr419LYKausz39Ny6CrENMrmqSy4KPo+DfaA/+6XETHGtKK8VQuX07UP0yngTa+II3prvrJP75LnDjcRb0CyZ055oSiNCSjlJb0F9KlgxvoZnnj++T1TdX0X1xLor7hglgdvhUDJybB/5nnosSPZH9NrN2zL8rgMPpQRIIN3QzLBrOx9vn1FhNMW0/uETMwYdP7xOf8EyCb8dK1YWIBdOnufRINcRBrQABUDcRGr1ckrtx3bVD10EVZ37X6IBnU+o+0sKcOpDqcObpjvbgne/PfmAQYKPYr0XE70/mFbQ==
Received: from PH0PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:e::16)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 17:19:10 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::ed) by PH0PR07CA0041.outlook.office365.com
 (2603:10b6:510:e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 17:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 17:19:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 10:18:53 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 18 Aug
 2023 10:18:52 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 10:18:51 -0700
Date:   Fri, 18 Aug 2023 10:18:50 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     <robin.murphy@arm.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Add a user-configurable
 tlb_invalidate_threshold
Message-ID: <ZN+n+lwM655TVeJp@Asurada-Nvidia>
References: <20230816204350.29150-1-nicolinc@nvidia.com>
 <ZN5oojF6vKOKB/eI@Asurada-Nvidia>
 <20230818161119.GA16216@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230818161119.GA16216@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 0765e992-4b8e-4d02-dcf6-08dba00f3c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvrUHh9LB1h4B5CyJN9r+rUuUiYxX41ZKSfPQoK8C+1yLeiRbRN44Trw6eeG1o2XlgJv3yhNFmDjMhsN4MTiSnxdtswz1cb2hF5yAk8dChiYF0ycEVJyGeEk7GGv/VM00Yr+Y3Pm/Q5Fw1zJEUuV25xAJbkxLhWlPZI8xBpZVrBjAocpftckCbvwqGru4tGNtANOcgvjJPJxJdXGJe722I4I6seneAjf1gVRQyZv04Qu5d3jwg/ZCtDwCbajay4ROYaS8CtmMbDM818x7RRGQS2/ZoCTpSSVrF2Vzhp56NvPgopj6dALGZHbdAhFucp37oYofFD6PRNt5hFuVWbKAKFPdsu///uEotYxcPORDekSpuVYOV/muQ268NZqt9d6IYoKyXNCReoXvd3niRgi5dAXYh/qPZ9v6fmtYxb5ObRzV0vOBTxRg+xvQqNd9TivRxSk5HRQRWaPJxRQghNwKQ0mHTHou6uVUsSissx0YERcyCdd4WHfR4mUu/o4PVspqViPnto0R1w29Ioz3jDi0WIDU10Zcr1EnPNgqy0S5j08EyvlnhUA/yx3bQ+s0moNr7d+BJn7xPjCIr6aXJKSzYs1SPzZD/gtddG1w7Sm4e6QzAY/UFQA559bKOdDtwJcGl/TpCuKClJ0qrzUg3pWs+zAg7NOS2C0lS8B+5a+RqQy/gH5UknchWkriMC07RiCy/I3iqPVxuWrVowJMy000SnV6o2utlVVXlJm4TSNGU3kdMO2zm8cogkcvpMK6JBs
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(83380400001)(26005)(86362001)(40480700001)(478600001)(336012)(426003)(9686003)(55016003)(5660300002)(41300700001)(36860700001)(70586007)(82740400003)(7636003)(356005)(54906003)(70206006)(316002)(6916009)(4326008)(8936002)(8676002)(33716001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 17:19:09.4473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0765e992-4b8e-4d02-dcf6-08dba00f3c12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:11:19PM +0100, Will Deacon wrote:
 
> On Thu, Aug 17, 2023 at 11:36:18AM -0700, Nicolin Chen wrote:
> > On Wed, Aug 16, 2023 at 01:43:50PM -0700, Nicolin Chen wrote:
> >
> > > When receiving an __arm_smmu_tlb_inv_range() call with a large size, there
> > > could be a long latency at this function call: one part is coming from a
> > > large software overhead in the routine of building commands, and the other
> > > part is coming from CMDQ hardware consuming the large number of commands.
> > > This latency could be significantly large on an SMMU that does not support
> > > range invalidation commands, i.e. no ARM_SMMU_FEAT_RANGE_INV.
> > >
> > > One way to optimize this is to replace a large number of VA invalidation
> > > commands with one single per-asid invalidation command, when the requested
> > > size reaches a threshold. This threshold can be configurable depending on
> > > the SMMU implementaion.
> >
> > I'm rethinking about this size-based threshold, since what really
> > affects the latency is the number of the invalidation commands in
> > the request. So having an npages-based threshold might be optimal,
> > though the idea and implementation would be similar.
> 
> On the CPU side, we just have:
> 
> #define MAX_TLBI_OPS    PTRS_PER_PTE
> 
> in asm/tlbflush.h
> 
> Can we start off with something similar for the SMMU? I'm not massively
> keen on exposing this as a knob to userspace, because I don't think most
> people will have a clue about how to tune it.

Yes! I was hesitating about an arbitrary threshold setup that actually
fits our situation better. Now it makes sense. Thanks for the input!

What I would do was to pick a number based on our test results. Yet, it
seems that 1024 was chosen at the beginning to fix a softlock bug, and
it changed to PTRS_PER_PTE for a better perf, IIUIC. Should we use the
similar setup for SMMU? I found it is stored in data->bits_per_level,
so perhaps pass it back to the driver via "struct io_pgtable_cfg".

Nicolin
