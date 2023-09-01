Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2B78F63F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347907AbjIAAAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjIAAAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:00:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D63E67
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBhoduJe4aB+Fv2oJfUQgbQ86EGULIh9RyqsnN48UToOVr8muyq7Yuka9uiT3gyeIVQqDFrEtJvPoTQRM8nr3fC1JKdc9tlOSCJRTDFYXILmHZUKg/xZXDDt9Pdd/4/9QKf2crAAQOWumrd2UecZtOCBEfeAklNb0Yct2mrxmznlVQWz85tocaLKGTW4773rfAirzdUg7cpBMc3QtRNhXAV+cerNI/Lx0CRudurfHvOAuqexAuK7RoOQfCtuXQqg2pmsBqhSvNKJhC5aagMAS0zUmsBOrnTWD0OzduTTwwyLO9tBR4i10F9yW0ikaHIqibj8R0O1uEz5z+9bACTKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=697LC7Ma6qq/JCKeiYN0S+gT+0/cRqo9aT4Ytn6/QHQ=;
 b=bh53kcF1x8skxb2A4PQhPpiG5ngS24tF00Aqw59GwNTxKN+NtpdWPIhGvt2OTOp9buY9t/PAvHf1DQX9Q4wY9CNu4Ee3YmsADKQnCoffVAT8uNHyMsxbDtyKmOkjR00SBk1VjMZATWJn/8KU3sQ69JmHD65Ou7iQnQ4UVZXveo6o0dMRQJSH0TpYz73kFwZk8ll77xhtm1pTKkQnRifg1ZWxmQxXxcGoEFRTeB/+BT4O4YdV3XJ3+NmLWYl5uQQbQjSVaEOm4vfRO+SBkmEbzjJwhxxlnqSEBEFUMc54dxOOomVI9sOjxiQ7ELhL10qahq1QYiJ/5MQ1fP8bSLyn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=697LC7Ma6qq/JCKeiYN0S+gT+0/cRqo9aT4Ytn6/QHQ=;
 b=NWm9Y5dSl4kCtHD+uGFEivTRRdidzm2cHwSoyMv2FDfhHC7gDlLfUGbHMLbrFXlfU6HleWJYjNGgDPwPjvArVMbbcbEzpLi0Dz3ITpX6xtKCFLngbeXA67f4WwRxkoyYPQ6MvA+fpn7Nz0h0g2QhtXvgctDlIq6mUWQPUuKsT4P955zwvuerFGf/8Hy3ix8ExpnurQg7wryZc30I80QzVFQhdI3v/JVoTKGv1lSiaO5va6nNNXYv6eMI3aGsacQxTTKZnI92GqkGv4mVPD8cgbkGEw/zm250IqYp+cBWMYZ62KHWkl5w3R3BLSUKj12gVOEguqLoax60MPmLeqHpFw==
Received: from DS7PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:3b5::27)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 00:00:39 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::3f) by DS7PR03CA0052.outlook.office365.com
 (2603:10b6:5:3b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Fri, 1 Sep 2023 00:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 00:00:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 17:00:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 31 Aug 2023 17:00:26 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 31 Aug 2023 17:00:25 -0700
Date:   Thu, 31 Aug 2023 17:00:23 -0700
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
Subject: Re: [PATCH v7 0/9] Refactor the SMMU's CD table ownership
Message-ID: <ZPEpl9D/CqQWYhzk@Asurada-Nvidia>
References: <20230831174536.103472-1-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831174536.103472-1-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 181986ec-5580-41eb-37e3-08dbaa7e7a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9xl3J4fbEDjUwq3mQNXoDjTNtz3OvtUzH/E7CEyRJiOZj0QnrZDgzJPDdiRn+4QE7jGRhUXJzTOVZ4Y70MHntgo7eRVqBDvGmixGrolQIyCgYkYQZapB96RBFpZQ7zPVDKXbOjHpf/h/kcuFQd1t8D02Nd3efuWPIZ5xhv2nOh2If4+tjgYGFKtUMfUVAVPVfsC/pZE8KW2Dx+CCygOr/fjtIRdje3uJE7XflcyJFL029jPuDs0fTvvuz/X9ykiuaNnoixKiWUTxCRH/BAeQjNfp8TeRBsDM0UgAZjCPnqDQ5iPrDMeUjWVxRhZjIdmMuuLxJ5c4Uxa7l1fN/OUr9489X9go6egJEzy1ovv0u0t407FaEOg7uZkG9yneIP+s/brV4aTPDBuk++VbsuLd+XU6hwDW8BvKaagt4cRFUlA090K24VBkeVSbpmhggdzaQQuUAWNLtkusYTt1HV+TZClpcMY4qWo1sYIfRNEHcdI+nIwzdBWJbjGOIn5sA36LrXbJZ9Qlwk6GrH7lyGzvHJR4f74tCqRPRxfRMW9MWq6b+Ptj8XgkhtawrXgljaVofxASDhFxW06deYfdevGwzHsStkrwbCo2o4XUzUov9Jz94Ed1+r0YU0tsl9zWNyLxcLzrZDpuSXBsatW1qHrH8ulX5bNjGQgUH4UnHlAQ7tly4Ka8Y8eSNFwoYBRqcwTJl1sj2va1l2LY/6ZPYO+JL8Hl3hb0DgUccyXaamjdp91Ja84RSKVwSzPwEwyZi5wFMIZj+ISeWqwSAcyQIsC7ymnHUfWIGIjg/fInj85YuE=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(356005)(7636003)(82740400003)(9686003)(40460700003)(36860700001)(86362001)(47076005)(40480700001)(55016003)(2906002)(4744005)(426003)(336012)(26005)(966005)(83380400001)(478600001)(70206006)(8936002)(70586007)(54906003)(8676002)(4326008)(5660300002)(7416002)(41300700001)(6916009)(316002)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 00:00:39.2503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181986ec-5580-41eb-37e3-08dbaa7e7a18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:44:29AM +0800, Michael Shavit wrote:
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
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/15
> 
> Thanks,
> Michael Shavit
> 
> Changes in v7:

Ran some SVA cases after applying this series

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
