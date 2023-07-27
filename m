Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6D765D16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjG0UUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjG0UUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:20:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34222213A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZFbFCCzkmjmVZ2UojdWTd83eyQ93AlP1moh0IHfId69+OlaMChc24bFizppGODfwsizd1fpn3LMK2GD395psNSDTIl0AORgvkt8gCtiGXfNZ1f6xbUEzPPg9X+XmDyhnCeUzt8680askaIGLgWIVrPo240jt9ZfMqooPWDG9whNzfwM5+fR8eZy+awvv/AFe5NV4nzSAq3/721BOaBijRdOaKDyAVigdpJoafx6H51ih5p5Frs/psSGgWyDdKO8HPSyypb9oKnuFoyPhLaDa+jx39fbCrdMSRuzLok3TrsJbC/bLzAsjCU3dVfsZ4koWbMrBjOQ6a2WpOnDUw7KDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrZq4xPUqw0ZefXTKNzbHD3Ee220tu6u5mt59zwRtBM=;
 b=YLaeUE/ZSIld9hGWhelOgdFg2Sprwrol68Y87EC0COJ9iflyIkHHCZwDxfpTPmP3+78Zoki/fKXsPiAX6y1EyVyALQdrMkBE8bzxfuUyXai6l1uFRnqJ3xGCV3FRjeDkyBFemkj0vSc+XoEmqukVcuqFMJRYt7TRBWm5hVLZ/wDuVQO8NjqjJKsMgdw53KSzbCDb0DjP/RJdn3HGKWT8qylUzNUx8WKKW0/Jl0aGRfA9a9IyAOwnSzvnsqEZMZbKJmwlZ7MTOHTREskjVtd/DrHiBiobFEocj2nEd+x4Le0VKyKKXEirIjJKzAqcQolesCm1/ia3mVH1ammD848CMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrZq4xPUqw0ZefXTKNzbHD3Ee220tu6u5mt59zwRtBM=;
 b=PyxIHFEn9DQsX0Rknst9TEDxNp+sbu7LgvPfH3LoUxcofR89HJ98HJQnrFz6kiH4wl2xoYb99nt21wcIeD2wpndemmW8o0/SFue1JiWM4u9x/xwX0bxiPXjn2yFrLhK2TuJJuJKdsgkYIaVlFp74vSgSzFlriZkZ+fgqRsNHdjyB5Hx59iZgqA4VbngSHnvdcXHtFBrAOIfO5zhB0ObdRmd6QZMFpLJMrIocQF86Brx7HPXt87E1CsQeAMpvtBP1rwPXuBHML9FBcfNQJxlLQaRMZX2CK46nLyqWw6vxzn4g5HoENVYOg7Ugfae05JZMKN/nD9cEIVNAaExTEJr46Q==
Received: from MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:19:58 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ce) by MW4PR03CA0199.outlook.office365.com
 (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 20:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 20:19:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 13:19:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 13:19:39 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 13:19:39 -0700
Date:   Thu, 27 Jul 2023 13:19:37 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/7] Refactor the SMMU's CD table ownership
Message-ID: <ZMLRWfLET9FC3FQB@Asurada-Nvidia>
References: <20230727182647.4106140-1-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230727182647.4106140-1-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c24ce65-d8ce-4369-74b5-08db8eded8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1FrnsL0TGAWmm2Yw8JZW7Y8L1zHPeIwl0T302fDPOKUb3Qzi+ChAeznDtaoZdrdFLC3/GWFfqCWXxOmHaPEmbQMRfltAQtaje8xW2qO1XxHjcDIvKRrR/GSEQ+YIU8zd0FsdP2Vj2qvBt/4+oy8ygOLeRHfDfJuYx9VR+2u7zPKKKck8qGvH5hLlrQVLFQ/sOC0ydANXFU3UBK3TX+PHOEBeYFvLhF3CmI5M3c+k3C5Z/ZmzDPwAOUNBdAEYikJAHYiPM3Qa8JUbw3/OIOsAz+drYo9ZiPCgtvML2cBA6LP7I1yKR5QKCWdDjvXOcLurB/lk9CgKLTfsQxUpk7tdg8CRLzvF4WOkb04rQXNL7JUD7eKzmsGtNzQv6D+kLjm61BTyXhCn9zM3kpdi3S/F748G3RhQxYPYW/H/wH0aIIyUVrYNl0rhouuSiEjX+CyNDx0B0FO1eyhoty3lgXMJ0Es0YLK47Itnu2Hi4LucsX/BsJVIjsqIDUrH7ntz9+ppc1qqrwSodZOV+wtPtkc6Tzqt2DKRoseFJ1AL/KmSRF9+dV4p6Ha2QP53gkJ5zMdjjatZGIecFV6tZbrQTrLK7SCS0Qz0EustvJFAPc6KFeFq1u4OJcT1V7h1xI0L4ISfifllSg3iPraT8bHLlTJh9d4D/S5oYzt4Mi9o98BxwtGa6OQhRQVWAb7ZB16rIxm8/b6pyWhFOl9F2MbAxpKCnvGSFzsKs+Sn8mj622pXcayZhCJZkyUYKVIUe5gkvQ2x4zqBFfYNn4xgIU8rHTfJQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(26005)(41300700001)(316002)(8676002)(6916009)(4326008)(8936002)(70206006)(33716001)(40460700003)(54906003)(478600001)(82740400003)(40480700001)(7636003)(9686003)(966005)(70586007)(356005)(55016003)(2906002)(4744005)(426003)(83380400001)(336012)(86362001)(47076005)(36860700001)(186003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:19:57.4647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c24ce65-d8ce-4369-74b5-08db8eded8e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thanks for sending this!

On Fri, Jul 28, 2023 at 02:26:16AM +0800, Michael Shavit wrote:
 
> This series refactors stage 1 domains so that they describe a single CD
> entry. These entries are now inserted into a CD table that is owned by
> the arm_smmu_master instead of the domain.
> This is conceptually cleaner and unblocks other features, such as
> attaching domains with PASID (for unmanaged/dma domains).
> 
> This patch series was originally part of a larger patch series that
> implemented the set_dev_pasid callback for non-SVA domains but is now
> split into a distinct series.
> 
> This patch series is also available on gerrit with Jean's SMMU test
> engine patches cherry-picked on top for testing:
> https://linux-review.git.corp.google.com/c/linux/kernel/git/torvalds/linux/+/24729

The link isn't accessible for public. I guess it should be this?
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24729

Nicolin
