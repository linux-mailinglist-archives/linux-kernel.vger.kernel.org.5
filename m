Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A167675AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjG1Sm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjG1SmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:42:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36324494
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUWZRPjRvlcfc5BJ960dHNSNE9ZHd+S9Tscmjw9GoXeydgpspKqUphkpbwe4O4m37AWtAOy+C5K4xM1uTUiYVJY1AagnrZqJHk/C4D6YVfesHy3y2JSHoDJOyozcFvBH/rwLHjf5EqykkURQ5N/U401F7LXXdVEbvK+I2whz8MfNK+2m5dY3FFLYRneC//R78j99umo55jShSIf4P3irE1LVumTiaLtWPZC++8CLL8R6zdavp1gruPjfQiLUhebyjETF8OqnrsaX1D36fb7AOr4jKPhsO89Ad+TrviTUyHhMJoFGeLuJRpGHANqLwrys2w9etXFPAr2D5bXNFvqnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FLmy2XHuvSFiMWYJfHfWuBDA1n1wWOznY0unL+3Mlg=;
 b=C2WudQuleChiWgxlj31sZRxwM02XyCFjbQb4TscpY0ya+8hSpy1e7dhsMEaREt9nhcYSJdZOF7IWih1cnAYjBrefPZ2or0X09b/Z6kVCp1i9ghhaopTeAjVoly6+RGhXTcu/p08ZAdX3VN0t/Xho1CcedcqM7mNuvLrgO4mAnnrjukdbNxxSX4gTMb212DCPmbsS9ZfhxHME/bHs1dFTDj7qHhgGqsJSo8GXI+vw1YhqIsqyGuRH5qoAmOyZmYrDYPR3q8abINT/SKF6n17C9Bcry5SRSwr3i1/PyfwmxEIGHcsrFKJGhYSPEpFWh9NPsxaab8RyUHdUhdfNMajYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FLmy2XHuvSFiMWYJfHfWuBDA1n1wWOznY0unL+3Mlg=;
 b=sdbfhLEd3k/toWkZZqihuinWxbnNfR4FzT4EGHYQJKiXfTlCQIO6NnjgTpFFA466m1igrVLusz2QBvUvfkM1G2y542KGj/Eg4AXPbc5xGAf1t13DgG3ccw+YiO26YKff0MeipL+4HxPPjCaEpNqvukB7dAr4rvLd2hBzlksEW+arV/zKG1sOMdnVVylyyYxt5LljyUyMhUphmoKJMmABOZvUBtzq7ub2yTRHcyQCquI/iSFdbnm7txbqdFaW+j2JYAJDmzNl1RToqFfEeFB50WG4o8ZKt24CrnE0d9gqo5bBFO49UNnaVXE9YUXb8OTqNrkcvj29K96mIAtRbOXiHg==
Received: from BN8PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:70::26)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:41:43 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::87) by BN8PR04CA0013.outlook.office365.com
 (2603:10b6:408:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 18:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 18:41:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Jul 2023
 11:41:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Jul
 2023 11:41:28 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 28 Jul 2023 11:41:28 -0700
Date:   Fri, 28 Jul 2023 11:41:26 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with
 ctx_desc_cfg
Message-ID: <ZMQL1qjHT3NE9FR2@Asurada-Nvidia>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-3-mshavit@google.com>
 <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
 <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
 <ZMOzHJO23ZakRs8b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMOzHJO23ZakRs8b@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 127d83b5-f094-4f62-d9d9-08db8f9a4a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUlSMMIeRqnC8jVUCDdZkMovp+FvHbzqRXkUj8wYhJf4c5fyw26Ock6i8fRaPoSa5Eiw0YQQULkggQAf54dMTaDrrEudw3P1+nueb4I2/Jkw6PRzXdTpchZW8Fh7s2OB8AsxyKmNZIcegyGhBp2e5hTcTRPCs+PHmpBYOGslh5Z5+PM2Al9gXeoLXdQIOF/7zwj5ycm6u4hFPQh/I3Q5YZzHoUU3JOY/hX74P3WoZds+HWw478CqcMmBPaAhLn3pEjEFEEdnlgWiAR3p/2wr84UQ4KVVnTZj0jGcyZaH07ETWW5QyGuBz5nIE/5bfwH2cM90bwKebhTt3MxtI23Qe2O0z8NccDe4dehPGaP7aNWi1U7xIbkiiSBCCk98Ob5Ye13tNMYCTGo5GJgbvZnEU6ZnhTaZMm09ew6YZBmRo+XkxCsRcMF1HZKYTPIyF46nStZH/1udFaqW5T+at9CZ41866uvQB2UV1uG8wu0Q1UiKQepW8PiwQktkYvltfvP8fSkBR4us6rGUH+3F7nUMZFGP5kmpaStEq3CnjVMa+S9ftVmTJa/pIMPOxXB/R2H2XA0pE7V+lBV9EBFkmWgEmeyFMfdHpdW7G3wyP6JhvBbPtGW1eFvUQtA6bkmf24MQA0OxGlXLKc0ablu0iGsGdWUjZUM1Twe0fD1E/Ax7liTLXm5/ixvyalLKNlHgliQOHKhwPmghvR/JimJZqgimjus8AOSo6HHaTJkWsXQPoqE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36860700001)(54906003)(9686003)(478600001)(336012)(47076005)(26005)(186003)(6636002)(53546011)(70586007)(6862004)(2906002)(426003)(316002)(8936002)(5660300002)(4326008)(8676002)(41300700001)(82740400003)(70206006)(7636003)(40460700003)(356005)(86362001)(55016003)(40480700001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:41:43.2781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127d83b5-f094-4f62-d9d9-08db8f9a4a23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:22:52AM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 03:47:45PM +0800, Michael Shavit wrote:
> > On Fri, Jul 28, 2023 at 4:57 AM Nicolin Chen <nicolinc@nvidia.com> wrote:
> > 
> > > It'd be nicer to align all the variables to "cd_table" like the
> > > 2nd piece here. And if we rename the struct name too:
> > >
> > >         struct arm_smmu_cdtab_cfg *cd_table = xxxx;
> > 
> > I agree that renaming these would be nice. There's 36 usages of cdcfg
> > in arm-smmu-v3.c, and 6 usages of  arm_smmu_ctx_desc_cfg.
> > I can rename the struct since we'll be touching many of those in this
> > patch anyways, but I'm a bit concerned of the churn from updating all
> > the cdcfg usages.
> 
> Will was not keen on churn for clarity so it seem better to be
> thoughtful about what is touched to get this merged.

Still, it would be odd to have "cdcfg" and "cd_table" at the same
time. If we have to be conservative, perhaps we should just align
with the old naming: "struct arm_smmu_ctx_desc_cfg *cdcfg;"...

Nicolin
