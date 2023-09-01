Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947DC7901FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350564AbjIASX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjIASX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:23:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CDBF2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFCHVHVWf5VOI/TNFm8heyW21owu4EgFhnYYBm8a3NZ+YGPz2UqyVfvAgmg0uwb0RB9LvyNJJlHkPUDhS6y5nhxzjeRtgLH1by1IQnP33pTXtTXwC1uInqqh2HbGMmbA6PAsCQgGB8T9Ycj2BBd3hwFZ4pN/LjwN3Mcck5HUmsDM2woqx8NcYXq4fFf6UNd+gvJZSBMJPW3hGfJcXGy+NNB4WoWLcqjjwPsvV6GUH0nX4dIH8eqn32fuwyXQvfE5Ldvl0ad+W9zAbL0Vw023TNxYF3Y0Sblh0cuSAv3zFZkLXu9fk7dRF/j8LKYRClGXpD7LZtbP+zxsRtFk4cAlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q0bG6ZZgd0ZViv/qyjlKEKVFfv3Ptjvp/m+QMS+HoY=;
 b=Ok9V1Fw+ip6cceteX/mBHydvcjkOCvFeB444Nc7I+LW9lS8K6z9u1mDyIl1zrMLMFsZRolaDSXWoS8NmUW9m3VsXki5mE/1CuvPO6W374bm08iuWfvNDLNzFaV6U8Fv0LpBvYNl5NCreB+ZwcNBTbMv6hJsiZL0jZrd96/LIPtZO2cXCScLLlV6U73FyZ8TIzPf64J85ILwjiLdwLzpZTNLSFx51bN2QHjjEcpsRlC0v+SDeb9eWpwi0rdR9EL/OuOnzZKt1+wxP+2ew1HnVoGPbH4AYPYGQdQBs4AbsjCLjYd5hHTHFq3p4/b1/ydOwJ7w54yiiJ4X9DhutlrqEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q0bG6ZZgd0ZViv/qyjlKEKVFfv3Ptjvp/m+QMS+HoY=;
 b=ryctFklMnDryWTUhwzmNDsNwCm0C4l32XMjnlPj+2muyE856ufjzwFoqM/PlJvD/pYfHv5ew4wNFq9CaLzzqGMwVA+JFkFAiDGr4ByregYpT1DuWE8V+9vrBNGALKe60DpLGVJzLaOBFmHJfmkcuTLl9aM6Idmp1Q63IQv7ZedYyldDMiw2xwIqOhP60TIjWLLPuxhpbDPwBy7/txS4b3t/jdzHrFxSoC3Qxbq7sKSkX9UsmPv8yyJVfLRt7V8yXR4zCWk81aaDweOyJmEHCpxt2YA8+dBrQO0lp5k1L2DTpiCPDdAQ1OYsmdGnIaUo3zJt3Dk/GY5YqYIa0AYC2lg==
Received: from DM6PR07CA0080.namprd07.prod.outlook.com (2603:10b6:5:337::13)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 18:23:51 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::5f) by DM6PR07CA0080.outlook.office365.com
 (2603:10b6:5:337::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Fri, 1 Sep 2023 18:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 18:23:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 11:23:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 11:23:36 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 11:23:36 -0700
Date:   Fri, 1 Sep 2023 11:23:34 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <ZPIsJl832r68bUaU@Asurada-Nvidia>
References: <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZO5uGKzGsaliQ1fF@Asurada-Nvidia>
 <20230830214958.GA30121@willie-the-truck>
 <ZPDQPs9UL2sksblM@Asurada-Nvidia>
 <ZPErio3R5redmDNU@Asurada-Nvidia>
 <58fbd72b-32bc-c6da-15b2-0b8a284df60a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58fbd72b-32bc-c6da-15b2-0b8a284df60a@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: d86282a2-d2cc-46a6-f870-08dbab189755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyZJb/OtASxQt5Tm7YzF4r5iX5Ntc/VYVW4OQ+trlcIEfO2d9NdnuG9cA/l2oOSjEbAetsyPVdj9NrvEM4hCgr/QjuMl5l3CxyTM0H6BLzshebDY2Lpsq8EDZae1PWRa2C5KH/rNBxT5nCLjN44otUk3udCa1qhUnXhd3PEyz3iM0Fo1T04V85r8REMenDr/0FRuOXoINo9z3rTY8b4tKoZfN19DGqKC2V8TBtiQiLZ3fAFz5X5S/qptFvRD8H4fdBIhkZhSVO0X0yvhjPqNUjInS/61lQI2+k3BjNy6zuRF5mymbYNChc2rlaKSypVEKA6rpOC888sgZIZ3LXc/LgH79JnybX1cuFG4ITx51Wkg63qPQpSLfrEHEbtHdth+u5yBT1KFsqufFVw235FDgkS842jHuSLQANoC8zvYXgyHnN6x5C1XMhWff1vLkGWDW91kcQgobFxB2Xjgk66W0QcbBd7iURLwDc4L4QMrR5NT7B+EbLnb1bmIKgqi39sz7mJDLaoFU2nF3cp8HS0ZP19hFnySDVT7wEXYwDq/cfcAXX4QkKeu/OuebGVRRJHMKJP2l2WEuX9B1oy9q+cLO954Fdu94bwHxXKHIa9RIhRKCAzZcTlfhb4iPUjlw0kxEwZkSyaW3qoaMqjNzfUA5dWAsf8t3iuYgYm8oAecYRvnfqaM0LaoJ+shz3YpQsGD+2MzTWjkNxFdydrWrNwmCdG89K6jyPcvDvi14UiUfvLE+Ewmn+/hHiDIpdM4x3nL
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(41300700001)(82740400003)(2906002)(9686003)(478600001)(6916009)(70206006)(426003)(26005)(5660300002)(336012)(33716001)(54906003)(8676002)(316002)(4326008)(70586007)(83380400001)(40480700001)(47076005)(40460700003)(356005)(7636003)(86362001)(36860700001)(55016003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:23:50.8209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86282a2-d2cc-46a6-f870-08dbab189755
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 07:02:19PM +0100, Robin Murphy wrote:

> > Our test team encountered a soft lockup in this path today:
> > --------------------------------------------------------------------
> > watchdog: BUG: soft lockup - CPU#244 stuck for 26s!
> 
> That's a lot of TLBIs!

Well, imagining the use cases of NVIDIA Grace, I'd expect it soon
to be no longer a surprise that we see more stressful cases :-/

> > I think it is the same problem that we fixed in tlbflush.h using
> > MAX_TLBI_OPS. So, I plan to send a cleaner bug fix (cc stable)

> > What do you think about it?
> 
> Looks reasonable to me - I think it's the right shape to foreshadow the
> bigger refactoring we discussed, 

Cool! Thanks for the quick ack. And I could move the MAX_TLBI_OPS
to the SMMU header so a later change in smmu.c can just use it.

> and I can't object to using
> PAGE_{SIZE,SHIFT} for the calculation when it's specifically in the
> context of SVA.

Yea, the current SVA code passes in PAGE_SIZE as the TLBI granule.

Thanks
Nic
