Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB3C77E7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjHPRiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345251AbjHPRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:37:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76299C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDsT1Y1FZIKMSpSifrM3cJfYVROSee5yjiwmtx6XHzf+IJGTQtWdZtby8/OIcm7zOiW/i6FYl/I4BggpkoPfaU5OKDlUNBazTRmPtW7KANhgMmVfpdR5YjzCOtuNdTA27uGF6i8CQLqFWw3v6CEUKWCs4rM7vp80eSmMl7DYHyaFMOh1x4UdGScSkMuH6xStiNtYk6vwQD4NU1l4Embi8zM8vGaiRxR57IIDjoTNjSGgtigcYXuid6VH65qNM494qyWH3dgQP2+SU/FfW8sRx1RU+qfcPi9FvHVhNz332Ovfq8NUi6Cr0YBa8uGM1ZqfDgDXn2dnwAKeRZ5wNe+Dkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0QMKM4ZwnbK2cUBXw0bIyj8hGj1wEYPDZJZ6lUpVKc=;
 b=XfEFZHY6JhxqzE+ZzsHV3cb/Fwknye1oNZVff3oZ25LmzEZzmlFc/+hp+BLlm/Q5mQ29wr68wim1mETNjgk79+pc29OP3u/VU1FMLnqHbhp2VWW0fsJd+icaFuQCteRjMUuhin+WpeJylaPA6ixndxFYNVzY2dIo2KuVqu4RSHvc9H32srglv9SUW6laO2cG6ihSm0HtBTSS2qxbKyrulb+PS/m2EW5028WFT4irfuP0fEY1H/NyjmIR54EGGudTWZL6/VKGl9CqvYgdP9FNWnmQzZg06SGAtcQMNVbeW2d12hFhfqaFNGHn6wwn0dz48XEv1k/kGR57DJyDMMt2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0QMKM4ZwnbK2cUBXw0bIyj8hGj1wEYPDZJZ6lUpVKc=;
 b=fzVC/NSsxL5cHBKc8TXDuusi3klo3ty3noXfch3Yfg/EoFlHd/tBI942WvoO9uOiF9JzOwMwohJ5wMVCjWL59QQdUCbjeWI0XUCpADUgFcPuTksWK/mwFyEtZrvK/xSwH5DM7tPko8kBdDxYYgNVeDsr51m5F2IkLEWEIPDdsxV5quzh3MDwNaoi18cYGJF5BDFntpurTN6DJipJlVCyRnnRz76xsrZhNmDTrs5JrDhlpXf8oFq8IKzu4PDz9rEhXT1cg3f0xvlVPKgQF/p7DqpzFsglr8eTTru0JyzZYZLzty5LdtpJCrVYSYzORdwECIvLo8rylf9WBKZ6UewHeg==
Received: from CYXPR03CA0081.namprd03.prod.outlook.com (2603:10b6:930:d3::27)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:37:52 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::f7) by CYXPR03CA0081.outlook.office365.com
 (2603:10b6:930:d3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 17:37:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 10:37:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 10:37:39 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 10:37:38 -0700
Date:   Wed, 16 Aug 2023 10:37:36 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a configurable
 tlbi_range_max_n_shift for TLBI
Message-ID: <ZN0JYO/of2qH0krp@Asurada-Nvidia>
References: <20230814215701.5455-1-nicolinc@nvidia.com>
 <ZNy6Pw/Jxn6jsIxl@nvidia.com>
 <ZN0CciT2hBISXxoJ@Asurada-Nvidia>
 <ZN0Iqf9xrCEOOXUJ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZN0Iqf9xrCEOOXUJ@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 7388e9b3-5ad2-495c-4b1f-08db9e7f84ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuFw8Ubn3+4NgQDOW+eLiVHhpz2UKtdp8IncrfxNj5daH/ToL+eOLAv89rwcXmkMq6F39asR2j5+iU8D0lnnxBSqf9lz9p1av4vu8/CSApYNO+wGIJbP0O3O4O+5z8VLdGrjgoyqX5aESlPPfaw+fRWKv6XJI46c8LUTQPYui/Y6fJS0t+fs+L8kd//w8IZadTWPg7FgP3taHQ/qGf6tQsKYcFOq7Yh51hjKBBLq1Z5nMX2yFz7PCmWPRVI4Jg4798xl+ByJnjqq9K32Wdvpn1ETOQO4t0l9uRM9ltfQWi8DEDwQ5G6Uh9q/VVe/FHmAJpPR7XwL9WxYK/nf58tPRrt1nHrahv5neudzKDc6VcjjlDP3v8T/vT1Gv2fs+bjqV24RiC8utJmUUmp8Btnc5u0W/updVeS1GmeLWGHiPDU8zZSPFq+7YFvOtRVPJslBZngXtx2Ylz8amz4Pl8ceWz+fLLNNAXteYsV1npEJsy25icFcyKbVSOKyVbREv5V7zUidUH/7DiRMuzFJz3j43CE3ANBV6H/LYnXSBX1pKe1kXXgFb2qjKk4VKYerhROjXaH/yRmGyf34MCoUyweFsAH7YSUKMSz+E3prF+d/IY+7EoAJtSmGx0pr73arTn9mX3htZLPhV6RwE3x23GLGBFn8o08zmxRKgzkXQmWjKH7JXVNhDmhfJf7qORzKHDBlOVFbyZhIEBSwCBESEl3t18LlbplO2Mz/NsCTyrOqm7sZR4z2IIA3x+lB3qy2aZKg
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(4744005)(86362001)(40480700001)(478600001)(426003)(336012)(9686003)(26005)(55016003)(5660300002)(36860700001)(41300700001)(356005)(54906003)(6636002)(82740400003)(7636003)(316002)(70206006)(70586007)(8676002)(6862004)(8936002)(4326008)(33716001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:37:52.6800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7388e9b3-5ad2-495c-4b1f-08db9e7f84ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:34:33PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 10:09:20AM -0700, Nicolin Chen wrote:
> > > This seems convoluted for a uapi, you should just make it
> > > 'invalidate_threshold' in bytes or something simpler.
> > 
> > Hmm. That'd be a direct 64-bit size configuration, and very likely
> > to be at upper 32-bit range, so I feel the value would be very big
> > that might be hard to read.
> 
> hard to read is fine, it is sysfs

OK. I'd just do it in size then.

Thanks
Nic
