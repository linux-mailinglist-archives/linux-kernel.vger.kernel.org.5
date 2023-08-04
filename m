Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A981770C3E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHDXL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjHDXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:11:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07B14EDC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmFVncfVysgpjsm48iV3XVh6yDcCt+83D7ljmp6rvqbM8abFjVWq6TxofT/uVyoYiFn4IO1DtiefcNBwJHBxG2CRdhWe3ibRH8beVDxsvRRHS8EeaJ37QDw1/oL7J+sKDhvqlsmt3/V61n+U8eorxfi3JeHLvF2sglGzbfKiP2GIj3kLpE6LzM4HU3eDklu0uGg3l6ZrAvTyZRMaQMeBiwDgp6DQYfwo0zoFq428ExlrXhhxgMy10U+hyPZjJghyzX34mq6pVcFXIoLQVVywEpF1qXgMKrObpEyyHnVscpSZjnuvZb55RO4uypVr2YfZCRlK9VtQ0NZ0i+YdMKrvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQMTE2OQGXvgQt2IrJl/m4D/QexcvGY0BIWWg4YUNTk=;
 b=Z4qWHJ5AT/8Ck416h1zIKmrArInzV5w2UZwvphnGQusMIy6Qy94cB8UfHUm1H8gQIk570cmaML9599T+KCCEDl8Ovqu+F+XvcDhEqrIGuscnsTWtVIwlMfokkLZ7+mfoZiViSE8l6RT3wcbCUSCTogeJ5GM6AdTQKzRFZeijGTXLcIQx2Ipfl5ZTXAc8pvp6uIzLukaObMT1WFnmL692aU6QimRVm5YFCOXac1oOLkgC9mKrBbtT3dj8uMThx5WzWIMmk0KXUYdXSIymAjMLBNQGr77TAHonPQlEIycdY2cOL8br5b4/LomcygAF98PNwlE759zdn7wntqESVDzb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQMTE2OQGXvgQt2IrJl/m4D/QexcvGY0BIWWg4YUNTk=;
 b=clDc8M98Z4R+8UfZwMUMmBkhp10OqeLbuXI8wVyWTTuR3oQGCMME9kH022wg2FnJQVWSGN96squjlnGVOul9WKKIPYCsD+XKJoT85WK730Srqgz8/N04/n3wQsi0O6JAkVZrcCE0ys2hycbFTzenswi/+Dr6cZUYjI/1LMG1RolDZt8RKD9OQKdIVvKeJ2Y/1crd3Ba1Ck6n5N6P+ICdlYdwE3S8xBWtIxdlfSM6g1BUYZX541c7tZY9F6DSi6Bh1dkbnnyhTGpRMPur0k7TirEB27jK0lqo97Q6IHTJyfQD8/5Xu8FOgHOf1vtSp7JRoKYg1XpzUu6n/HrO0W2+tA==
Received: from CY5PR15CA0146.namprd15.prod.outlook.com (2603:10b6:930:67::15)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 23:11:51 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:67:cafe::f2) by CY5PR15CA0146.outlook.office365.com
 (2603:10b6:930:67::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 23:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 23:11:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 16:11:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 4 Aug 2023
 16:11:43 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 16:11:43 -0700
Date:   Fri, 4 Aug 2023 16:11:41 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Michael Shavit <mshavit@google.com>, <iommu@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZM2FrQcD8QzP6XM0@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <ZM165+0WUNsIZ3Sn@Asurada-Nvidia>
 <ZM1/vx0bgNZXYcY6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZM1/vx0bgNZXYcY6@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c4a1ce-e21c-46eb-8bbe-08db95402fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mao/unLETLQYFqxsgev3b3D7xayg4OpvRExLPgYOKwbFQxuCrxm6kxtHSG0HlQY4rsJ2gC7zPq25Sp9V4ShUGpygf20hZgC1D0vSlq+6Btc1RyRHKR9UcH3wjh1JznuNh877ZjU/+2A5azDZ4dvjEutyru69cVWoIdSLcx5OvYEH3XN+1/MnH8+oURATAhxvspKLpWwPeneFXuiUk/eByeGBibOxpJx3X1CpJUdfGmzU5jBZ5BWBFjEDvqiZB88OF8juTGVnDlnflen6uzE26FYyeSYR/00IWT5bJU0dh1gi4bgGwJYlnuK/e+e07rtoYcFa7et7kAKsl00fKFrB7EVy8HeN6YndSXR/tBmXXU1ahpdsyNRZPM81pJc6AKRAPtOEbk97qODTebN8WLPRbKaNeI32AI79en14FOZK08IZg03YfH0DdsH4qyZl1tokCJB1hoyWMYNIycEYzVDNotBVAgZzoeyxDcdKFxlZiRUH7yk9zfWbEVVqx9TCX7HuxOuSQB79mH90Lymj8Sz3WX1RN3T1KELC1BfRKfGRdgIm7ImWynGeeHVI35gq705lKEYrfYI4kmp2Ttb+YGrtfZ1khFibV2TdDdgsQJ9/uFMX5OphSKuJJYkSmvnz9T0HqbDZ4jvJYVSf9+b3FSWqqzbln3XtOnxLXSBdu0XwtkEzji3WxG88uDHPR3J0ze/YBJp8zre8iOi3t7UKadQhZ1BarVEqI5d4uJzd35pRJI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(1800799003)(451199021)(186006)(82310400008)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(26005)(8676002)(47076005)(4326008)(426003)(2906002)(36860700001)(316002)(70586007)(6636002)(5660300002)(70206006)(7636003)(40480700001)(6862004)(8936002)(41300700001)(9686003)(478600001)(55016003)(54906003)(356005)(86362001)(33716001)(336012)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 23:11:51.5407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c4a1ce-e21c-46eb-8bbe-08db95402fe1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 07:46:23PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 04, 2023 at 03:25:43PM -0700, Nicolin Chen wrote:
> > > @@ -2436,22 +2419,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >         if (!smmu_domain->smmu) {
> > >                 smmu_domain->smmu = smmu;
> > >                 ret = arm_smmu_domain_finalise(domain, master);
> > > -               if (ret) {
> > > +               if (ret)
> > >                         smmu_domain->smmu = NULL;
> > > -                       goto out_unlock;
> > > -               }
> > > -       } else if (smmu_domain->smmu != smmu) {
> > > +       } else if (smmu_domain->smmu != smmu)
> > >                 ret = -EINVAL;
> > > -               goto out_unlock;
> > > -       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > > -                  master->ssid_bits != smmu_domain->cd_table.max_cds_bits) {
> > > -               ret = -EINVAL;
> > > -               goto out_unlock;
> > > -       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > > -                  smmu_domain->cd_table.stall_enabled != master->stall_enabled) {
> > > -               ret = -EINVAL;
> > > -               goto out_unlock;
> > > -       }
> > 
> > ... then we remove this stall_enabled sanity also.
> > 
> > This means a shared domain (holding a shared CD) being inserted
> > to two CD tables from two masters would have two different CDTE
> > configurations at the stall bit.
> 
> I looked through the spec for a while and I thought this was fine..
> 
> Stall is basically a master specific behavior on how to operate page
> faulting. It makes sense that it follows the master and the IOPTEs in
> the domain can be used with both the faulting and non-faulting page
> faulting path.
>
> I would expect the page faulting path to figure out what to (if there
> is anything special to do) do based on the master that triggered the
> fault, not based on the domain that received it.

Yea, I went through the spec too yet didn't find anything that
could block us. And there is no SW dependency on the STALL bit
of the CDTE: actually it has an inverse relationship with the
S1STALLD bit in the STE, so following the STE/cd_table/master
makes sense. So long as a master has its own cd_table holding
its own CDTE for a shared domain, HW CD caching should be fine
as well.

With that being said, I think mentioning this behavior change
in the commit log wouldn't hurt. Someday people might want to
check this out in case something breaks.

Thanks
Nic
