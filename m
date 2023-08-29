Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2872A78CD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbjH2UQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbjH2UP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:15:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2799
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTyhl8Y5eUVm/orrXaW+RbyyB6DhPbvvs8Mqy/6gT7t8Ogv731eOqQ2ZG0Vw9p8haJK4+uSjdfv1Zi1wQz6OmpZZDc+DeKkATXCWya9IzjrrRsyBVbt1v11DdWXeN4GQ9MELSaOi1GqSacq+5jSSxcR2Esqp+cFNAXVcX2JOeNixHiN84emjoAd8iye/ApVZCsqhT/gG0opatsHncdv2zYpC2rBj/FlQkdW1dxfAVdoC53Csmd1ANLVF7HVSL0MIMnSMZrf/Ifk2AWaF/jN+vF+5BeTIJ3ecWla7zEKYDN35poeEyrAWuYzFjNbsegOggUvAahr87NMU9Ps0Q9xyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cysxDWXUNFMmR+QA1lbPxJHvqE47HPJAb9ux9PSf6eY=;
 b=PTg9Jrh/LQg6Vmuy4CKgTikK7u/vBmg6nYsdQtUN1BtaN0q07vK80ArwvncgV6KMrqQh8WteSJRSD0dOAwHQeumyN79PezVU25ebCylW2fysIoFEbASSjKAJbeOSF/dCrsC1c4AnsnJGB+stWlx8b7xYL3PfreVZPHR4/dsPISqN2CACBdwmh3jHf83wFYNmHY6upEYiathH3MdK8bvsnr0GAkWitsPxjqQEhwfIESJI1VjtpSw9WxOxaCIrBqEXC3b8hY5V1w9r+YKFlhTcOc771iB3m2k7KVIM6J9CRlLi95DLNidV+pz4qAdh3ERxLffImoodw2zvCvz8H2fvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cysxDWXUNFMmR+QA1lbPxJHvqE47HPJAb9ux9PSf6eY=;
 b=jmUUjue+wdBH3HRpepDkRF3r8BS8vk7TjH2WhHlAT9ycd4agoUB3Hbe3xeX4juz+lo7JRTwFIP5W+qb5TgGaBQj0I/JmCQhbvYpVRf7BtQzxINmrYlEogQHPIz+2u7vYGPxu/5KH4HTZiYKk0WoE7pC+8RdI3vV/X30bC/VWHvper3dfkoT7nKSrlqHS0iad86MxvYI2h82a5iUirY9uWRoggSLkXv02KI+Sk6Y1tBDGxNWjFBh3wbv1pYbmYbHjLU5er7STVVsoGmj7us5pPokA9shRi7MYJJR8zKD8A0rggl6pOfp7PBhG6iT50SOcpESyIoU+uSXG1NXniHKH6g==
Received: from DS7PR05CA0108.namprd05.prod.outlook.com (2603:10b6:8:56::27) by
 BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 20:15:51 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::61) by DS7PR05CA0108.outlook.office365.com
 (2603:10b6:8:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 20:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 20:15:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 13:15:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 29 Aug
 2023 13:15:36 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 29 Aug 2023 13:15:35 -0700
Date:   Tue, 29 Aug 2023 13:15:34 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e7f436-047b-4252-8654-08dba8ccbdb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6oF/d/xQwQiLiefe320ogScqORFJYPsFXZ6Bp6dKC1Ll+jMuhPo7NDqAjVklMFyOi3XW9LlZozVEKikJUtahyr5g9ZbkUrZ+hEF8TBS/AcbEpKzqDTzeS7vj2fx2r3SeAgOglUh7YvbR26ck+T5X7eVlwL+VZL1m7VVmgCOsAr1hR9y17g9DD05BkkervpwAvrNk+AMRwuSyjTuPV/T1/tgxYEZY0O72qbiv9BVkZ1nJUz1MIF2hKCSUTT+gtfzYKipLAXqBcdC9Vt2fbNyLOzzuTTHHHES/Y/rQsg/1K0sPMP88e+++C8aetlQo+DP8HHN+/ARgPjmBVLLSgc+rpL3EEdwOGjmPypQeEU1vg0AeM4Va6uP3OjULWbDRUydzrMXqXIG5DEzFxoJJ2rREq/n2FJGx0GLFKLqNnceqqgHYHLXSEYH/NpEKEq+1RhPLzMqtIPSk3/7pU7b7vEKe+EpmgA7I9eZbkTTiL18+1hfMs0+shmbaKt0TZylQ4McUUuAB9zXNTIGa6+fgwrISjj03l/re8sSYt75kknXRRau92+yAezNoR9faK/X9g2iOQ8FrUZAYsMKTX4Flh26tjA0Qtt5wbcixC0krwXARJhSh/5yO+fvvcZwjrHWjTfXa+sWadGxULSEDUAaztvXtZTxLWkg6DtDvTU5nnJiCmQw71rScJBAHtIKUbYgBOXN+UbuovoZDq8wJWBJTO30fu7mVfXWX3Dis8gT4x3J0MhzO0A4f6Ko+UPhoEvST/jk
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(356005)(82740400003)(7636003)(8936002)(70206006)(53546011)(478600001)(70586007)(54906003)(6916009)(316002)(41300700001)(9686003)(40460700003)(26005)(8676002)(5660300002)(2906002)(83380400001)(33716001)(47076005)(86362001)(55016003)(36860700001)(40480700001)(426003)(336012)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:15:51.1064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e7f436-047b-4252-8654-08dba8ccbdb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 04:37:00PM +0100, Robin Murphy wrote:

> On 2023-08-22 17:42, Nicolin Chen wrote:
> > On Tue, Aug 22, 2023 at 10:19:21AM +0100, Robin Murphy wrote:
> > 
> > > >    out_free_data:
> > > > @@ -1071,6 +1073,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > > >                                          ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
> > > >        if (cfg->coherent_walk)
> > > >                cfg->arm_mali_lpae_cfg.transtab |= ARM_MALI_LPAE_TTBR_SHARE_OUTER;
> > > > +     cfg->nents_per_pgtable = 1 << data->bits_per_level;
> > > 
> > > The result of this highly complex and expensive calculation is clearly
> > > redundant with the existing bits_per_level field, so why do we need to
> > > waste space storing when the driver could simply use bits_per_level?
> > 
> > bits_per_level is in the private struct arm_lpae_io_pgtable, while
> > drivers can only access struct io_pgtable_cfg. Are you suggesting
> > to move bits_per_level out of the private struct arm_lpae_io_pgtable
> > to the public struct io_pgtable_cfg?
> > 
> > Or am I missing another bits_per_level?
> 
> Bleh, apologies, I always confuse myself trying to remember the fiddly
> design of io-pgtable data. However, I think this then ends up proving
> the opposite point - the number of pages per table only happens to be a
> fixed constant for certain formats like LPAE, but does not necessarily
> generalise. For instance for a single v7s config it would be 1024 or 256
> or 16 depending on what has actually been unmapped.
> 
> The mechanism as proposed implicitly assumes LPAE format, so I still
> think we're better off making that assumption explicit. And at that
> point arm-smmu-v3 can then freely admit it already knows the number is
> simply 1/8th of the domain page size.

Hmm, I am not getting that "1/8th" part, would you mind elaborating?

Also, what we need is actually an arbitrary number for max_tlbi_ops.
And I think it could be irrelevant to the page size, i.e. either a
4K pgsize or a 64K pgsize could use the same max_tlbi_ops number,
because what eventually impacts the latency is the number of loops
of building/issuing commands.

So, combining your narrative above that nents_per_pgtable isn't so
general as we have in the tlbflush for MMU, perhaps we could just
decouple max_tlbi_ops from the pgtable and pgsize, instead define
something like this in the SMMUv3 driver:
	/*
	 * A request for a large number of TLBI commands could result in a big
	 * overhead and latency on SMMUs without ARM_SMMU_FEAT_RANGE_INV. Set
	 * a threshold to the number, so the driver would switch to one single
	 * full-range command.
	 */
	#define MAX_TLBI_OPS 8192

Any thought?

Thanks
Nicolin
