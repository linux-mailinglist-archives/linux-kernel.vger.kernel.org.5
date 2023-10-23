Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491657D4329
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJWXYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWXYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:24:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0709C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTwKAJH/pcqOFClLhZCfYV/K/C/yzD4kJXa3i4mWN8mFUmXDqo+XK9Z0zmEKc4SftwI6WhaK2MOIeFUbb5lfuon+zlcs30LxAMik3k/k5QFvCgk4FGk3ZlE23+SY2B4ULUiCBkvwx7JxDT3gT8l67w0ljv51atgzsoLjXk1NUhf9GZXlxaXTsJ0UMBGyjnKxNkgxum4mUiJOF+iZzG/63UOljNlDG3Lw9PsreFm5AQiGAcpYudath58qrT4wk5qTAjhLT7HnpH3yLjQYQl8JSjGqkxrAw6f0UG3p99vmWcmO5pKiHn/5waSKiuH4oAZyVjd9BjLA155xQiLQFksA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXFuPS29Y5AwVRc+dtnIEJC9QBnS9Xv4NdUNs5dsXWg=;
 b=X8uCWpv0Xbctu0qUc1qXs1AwtvrAx+K1dIuLbCkpCyljnusD7+kjmbv0yxIdgCg7lQb2mO3kslNRdeXBv6PisJFlDvh6VUpiaUsO25T0cbmkAFKy0v3bQxjEYYTN2ZoMIj921VEhOw+tas+49YFSbpKPInlSdgcYwm9ISBz3KGDNNYZR8pWhuFW82UAiiitqAUrgoTafwrAYeGF48KcVMDVnjSzej+y7PedW9DPgp2kr35xJO7FVocP6kEDQUr9tTord8wM8mDVhakVHholGEheZPPlr11pAFUsrK2CPx1xaR111dThCM6PVCVv1YM3YGJ/o2FTHK9gc21+gPaMXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXFuPS29Y5AwVRc+dtnIEJC9QBnS9Xv4NdUNs5dsXWg=;
 b=IKY13PKwj5zka3GEAJQ3abfGpfe4AVmcnGvzbv/fY5Bi0NQAmI42i1WUVhXBjTjhnKMU4V9OC51f8snhS3usDLBRmXpnXuurzmbd3rfd4HTuheIh+b2Em+vXI1ggK1FAqv6Y9yeP4qRGNyCG6RynqYe7jHvyFlFc5BngAw5IGpBzn2QpjDt9sqMA7Z2uaJk/9kKdzYSeL2zvLL7/qmjNK4W5tLU8xVahM/5zdaB7FjOLXIeRe1fTaHPew2osysOiqQXYqg0edGPHPR1S2kMWvIH0TkNCNRc1UnnU4JWLFfX2f5ElB6m3s0VD5mXqmnyiXaamL58v/ZA5vZ9j+SMlyQ==
Received: from DM6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:333::16)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 23:24:14 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::95) by DM6PR03CA0083.outlook.office365.com
 (2603:10b6:5:333::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Mon, 23 Oct 2023 23:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 23:24:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 16:23:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 16:23:53 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 16:23:53 -0700
Date:   Mon, 23 Oct 2023 16:23:51 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yi.l.liu@intel.com>
Subject: Re: [PATCH v3] iommufd: Only enforce cache coherency in
 iommufd_hw_pagetable_alloc
Message-ID: <ZTcAhwYjjzqM0A5M@Asurada-Nvidia>
References: <20231023185700.11407-1-nicolinc@nvidia.com>
 <20231023230509.GI3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231023230509.GI3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|BN9PR12MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bfbfe5-f8d9-406e-5d5d-08dbd41f2b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZv9WZNMzU325QkRCRYAbSo6sf3/F4BvM8gcLTQRWYzeClFcW4MUTYN4M6LoBkstece2OIss91pegvSvYrCMV0DSop5liGHWNM5XULfRt03+AtitqHbZUo9Ds/oBq0OerWzmMN69IzXFoLGJFJpfNXIPZLgL1Go/ZlZsruwRI+sZmouZMY5mE7BVBPA9vSlquyV/uIHG4wvJ4sidyhv6HZ6TL052gcpw7/X3S8sUYbj3SJjPt9WRi7FgnARckbSMT9KAR9WQjTTGmx2lImcq24HrYSUnxxr7XCxopYFpR0sjU0JKgIUO3rt7Lp/cnDaeq9PyBBRjTEPr5f2QFV0UDB8Ik60FUhdFNgxr+faOGtYUXPtxbpJ8LrgCVBoJsAan4gP7M27wcj060h1udxwjh3t51wurq1SVCtLrABaVOqaxWuXLmqaZnrQCWybnaJlxN7PsoWLi0w4Ti3yI3WNNMJefU7C+V35HnGY4VOzOxTnBTHHnPqJa5PcEfuqUgczZuLiH7PuJWbR9znCbbjJ2KtJDtdS83OjLTtOHoR149LjFmpxviIV3/xGNW1Fgn+wsHuUGRe1OgLFVy1x3TEP1NDlV+Ab/yMqwOFdRfnO+xMH4VD4EkzUTbvg9S3gvTUuP8jGhSEHnuoACyAcLXPoSfKyCR6cnpwfLUp5xHh2MFYslwPWQqIcUm54ayzb2Y6QKjb3JgwEWy0B7qdi74Tbqabalku152TV9Gj3qInqacBD381YLjVcLv3p8EyKtz7+3WEFXj4Ok5Z2Ca2QT32lBuC/gv6nUCwClKuPAjUfS3ET90cpQTUfuG57No/BabaWJ
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(33716001)(40480700001)(82740400003)(83380400001)(26005)(426003)(336012)(9686003)(86362001)(7636003)(356005)(47076005)(36860700001)(2906002)(966005)(41300700001)(478600001)(8676002)(6862004)(4326008)(70206006)(8936002)(70586007)(6636002)(5660300002)(316002)(54906003)(40460700003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 23:24:13.9207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bfbfe5-f8d9-406e-5d5d-08dbd41f2b69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:05:09PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 23, 2023 at 11:57:00AM -0700, Nicolin Chen wrote:
> > According to the conversion in the following link:

Ah, a typo here: conversation.

> > https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
> > 
> > The enforce_cache_coherency should be set/enforced in the hwpt allocation
> > routine. The iommu driver in its attach_dev() op should decide whether to
> > reject or not a device that doesn't match with the configuration of cache
> > coherency. Drop the enforce_cache_coherency piece in the attach/replace()
> > and move the remaining "num_devices" piece closer to the refcount that is
> > using it.
> > 
> > Accordingly drop its function prototype in the header and mark it static.
> > Also add some extra comments to clarify the expected behaviors.
> > 
> > Suggested-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> > Changelog
> > v3:
> >  * Reworked the first line of the added commets.
> > v2: https://lore.kernel.org/all/20231023035733.27378-1-nicolinc@nvidia.com/
> >  * Dropped "fixes" tags and merged two patches into one (Jason)
> >  * Added comments to the remaining enforce_cache_coherency call (Jason)
> >    [Please feel free to rephrase, or let me know what to change.]
> >  * Replace "num_devices++" with list_for_each_entry (Baolu)
> > v1: https://lore.kernel.org/all/cover.1697848510.git.nicolinc@nvidia.com/
> > 
> >  drivers/iommu/iommufd/device.c          | 20 ++------------------
> >  drivers/iommu/iommufd/hw_pagetable.c    |  9 ++++++++-
> >  drivers/iommu/iommufd/iommufd_private.h |  1 -
> >  3 files changed, 10 insertions(+), 20 deletions(-)
> 
> This looks OK to me, Kevin is it what you think it should be now?

I will respin a v4 after Kevin's reply. And I can attach his
"Reviewed-by" if everything looks good to him too.

Thanks
Nic
