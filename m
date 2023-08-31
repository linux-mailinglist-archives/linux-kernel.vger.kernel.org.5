Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95178F571
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345983AbjHaWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHaWdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:33:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7712BC0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdqdyqSNRFIzuyYsMiGGh1CpwEYDP181/C0pN6bdWA1fhLX1/LaMxyvjIpNNLPY1xQVCEZjkxPMyBmCJMtP9lD9EgzqX0M6Kg8IITvjB/ZabTeUkkgzYDLR+gu9EjIdg8So2g9iteThF2l97dJAmFQQ6bu5i9HUjtvA45OiTN2Qwm97UufFzb5Rw4kaw/yKl0KUuo6fD8fViLvQNF85PYzKC4BDI06aS8GsKEzPhCj8iWShFjTsSTDxVt+hJTjZRvCS7jkrIeFJF7NYSlHXaFpkFu0TBJpbXOMnCEAOPpFE25oLs3HyaaO+/VappQtUDT9vWQodtC9MtKauJe7Vaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCtaIfTqsyS4gJ3qvX+gTuxrVhkr9c7Kls2HrzM2sAo=;
 b=K/hrxFDG/yqKBP7mjKK/lVS6jocQdh+f6cKPNuYCs51C/DHLwv5XfP1dhLpWN22nHMwrr7wktLRCh9aX+q5gzWLdFU9hYMxnB5i8YXY5LYTI0ycyeRLnIv4AylVjf2tybmUZTc1cd/Gd2ykGmOc6lpf/bQvQRy5Pg4+Z6Mu4zhRJAXQ1kPZGu7AAh/viyt+z/DLjtbc3yk/RrwwLw5RKCW2BqSpmXbeUuBefky7N0kKm1QlWmyDrrspybdN5sZAAJpAU2S86iIJw1JpDOsLjJ4Yse6lDwmJtBcCkQWD0fI4JQtUf349LPi/cix10qVqOc3+YreAdlsG7v1SK4siFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCtaIfTqsyS4gJ3qvX+gTuxrVhkr9c7Kls2HrzM2sAo=;
 b=axttrVozzizglI4mKwa+JSYp2ADQfbzwt9qUll2Sw3BAXoyc/gmGZdAUAoLTlJwnRWXi05MsIDp1wVhe57Q6Yjehe+R0n4jjsDPB1/gaNTYbT2SPMZwwM7riQphQgPoLU2T2zDvEoooBK89rXbe46sYL1tD2IEjjPTdpBUbe503QNHjbhUQpTWfhiPUfKvViGdVjqx+h/qfG1fYWPylx4MeOMe6XSiX+ELFkH/Ani/4RdraTkQHuvqo837jSxZjSP+SicfajlQlFjTogxDzumGC3mHtsCFhuCyPBs+KH9xJ1MIGqq0PbQukPw90aqaMBPhnG5DKvCqy+meHqxHc6XA==
Received: from BLAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:36e::23)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 22:33:01 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::78) by BLAPR05CA0020.outlook.office365.com
 (2603:10b6:208:36e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15 via Frontend
 Transport; Thu, 31 Aug 2023 22:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Thu, 31 Aug 2023 22:33:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 15:32:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 31 Aug 2023 15:32:49 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 31 Aug 2023 15:32:48 -0700
Date:   Thu, 31 Aug 2023 15:32:46 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v7 6/9] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZPEVDnlGOf7s0NoK@Asurada-Nvidia>
References: <20230831174536.103472-1-mshavit@google.com>
 <20230901014413.v7.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901014413.v7.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 971ad0ac-47b4-4fa6-1afb-08dbaa723bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfWoA3o6ppmejYTWs7iuotPXuLA3/e9DDgcCFtGBAvtqffUZ1AMAiSXhEETg+20oWS+DgdBtU9MhxbB+4Bd4jtkdyaBNFjNp10soqmWmvZC814ulhTPiiSUUmr/b3i4jJTaIx/jUl1XZdNj+qEm/tCFKGuIHUf81csl1+p0sY5Zfowt6jstXXG4rvjO/fMvxgIiXdtHU8fY6v21mH4UiH2UrNfIBQaXkQU6tuju1YFx4RpVBRvIdmw2i6DDsdLocSjLlH5D98j59wlbePhPQrNcCUbthq4GgtqVr/52Ug4irTRW6YdcfOj3VphuL8TdVSaQ0/W1Zh4xi2zPRGTtCqRy3chHFIu5d39KLu0xtrivjX7JHki0HsRMvsnrJLwl0RK64bkiGK/CEwRtj+9tUvH6vfPUraMpcfA/QC0fwMi5Gy2AqetMevXUBb0nWoFuS62lsD877wMyEgB/CBdiZzcqTJiIFNdirJsmlDI1e2hUfi/hbz4bmNnxJ9NCuyN2golnXRMJwQi/R7oAYDqwCl+fO3ojq4/LlQ0xuhHPKg9jueVj2dX2zTmwCbcEFhClK7TuutkASnGNzT2Bi3VXugKAJ3CvUVWs32755YOaf8Ut1kFj31UED+ozZKgcxcQBdt/9t47mKFw+np9FkBnKie+BTEcxO2B7BEdoKVth43Tmu1ilYTlNlSH9wJWsNf4Ppu6SLrgPtdI3RhKLrWwLnM09S6U1uJo5RQNZ5Vl1C1rY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(356005)(7636003)(82740400003)(9686003)(40460700003)(36860700001)(86362001)(47076005)(40480700001)(55016003)(2906002)(4744005)(426003)(336012)(26005)(83380400001)(478600001)(70206006)(8936002)(70586007)(54906003)(8676002)(4326008)(5660300002)(7416002)(41300700001)(6916009)(316002)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 22:33:00.7669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971ad0ac-47b4-4fa6-1afb-08dbaa723bd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:44:35AM +0800, Michael Shavit wrote:

> With this change, each master will now own its own CD table instead of
> sharing one with other masters attached to the same domain. Attaching a
> stage 1 domain installs CD entries into the master's CD table. SVA
> writes its CD entries into each master's CD table if the domain is
> shared across masters.
> 
> Also add the device to the devices list before writing the CD to the
> table so that SVA will know that the CD needs to be re-written to this
> device's CD table as well if it decides to update the CD's ASID
> concurrently with this function.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Michael Shavit <mshavit@google.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
