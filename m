Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A8D79F60D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjINBDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjINBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:03:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20E8170F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg5b4OFNo/JfPj6D8FOzYN+xEIq4BykNo9Hki0IEZL6yu7JH2k0QD5gy2kV/37dqx9WoYhFS+A4i0suneTVmEUL6NSXEUN3OSUJ1effdptEAJcrq0ykCLEAP8840cVKtkF9fxl0o7McaapX9guv4mn4tZR8Tda4GuQJvlFxTY7hf+X8ZYrj4vAAZ5e6pVyikvasiAGK+l+ovmR6TqGEJ+rtX8QRRriE8fy+B1czo06kmsVZcDV+fctiTyrSpvr+XzjSDyS+8EcanbruSJU5qCJ1JJ8nWuU3Zhw/f2tc56C7FtEONdUBbTJl+AWivC+cRXmtbILDzpPobwOao8jnezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmyydSmDOzkO40VGcWQhq2zqsZnpC+chFnCvKTOJU1w=;
 b=JVVTrPGzzEFYdCwnCKc+DjgmZPI3crDAb5IchBZFkuR/LuRV+xkxaPcMeLT6yeiRG7qvB6lleuO/rU1khlti88m86JibNRCOvoAfjaszehi6cpRAeCrFXqMK0AQ3eRPe3bmmu6XJJYiTFU+fLC4EYzm0tUZCAvepWuEL90t5Bdylne36McAUor56OYlJNMrrD0mn9DJHUtHiEMoEW5Hq1NjrheSmvpc11X9ib1bHy/PtPaut04fygpQTFi3VTnh14x55wxlNFtSbGABT1Mn5ycFmiZZ8jem0jp+EQnVweDs8/Ot1EtFRyuGGXTNI9qvuXpXC+Iq3SVelHmWJNVPJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmyydSmDOzkO40VGcWQhq2zqsZnpC+chFnCvKTOJU1w=;
 b=NFoy5bZZq03c1rvKLbf/AQ5vNPriTZq8PG1Qr2LEMwChDcUerr8kodsA2c/nUNt2zV4xh/BGb0+97E29TuBmz4iWcQy0GIfaEXNOVCXV+PP69ltQWFc9I/Ypp7GdjUWz7IaXKX8aUs6kNitMW5FMsLP8NMFlRhioEVbJM4XoLvLWKS/Hqlad1frYloju/YWubo7s7Lo3S8Mj6pPT8H9p8dSPHOKQXxN9iCyEimcFgnglmeHbNSU4P5cjUMAaQ+/rSQoTih5nk0zue2X5LNAJE6YxzXKNQpQrqgCXV84RdNqoNhbKykVFOxS1rmrUL3DxV1kHRWjyJNfOW43rYZphfw==
Received: from DS7PR03CA0195.namprd03.prod.outlook.com (2603:10b6:5:3b6::20)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 01:03:05 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::84) by DS7PR03CA0195.outlook.office365.com
 (2603:10b6:5:3b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 01:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 01:03:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Sep
 2023 18:02:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Sep
 2023 18:02:52 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 13 Sep 2023 18:02:52 -0700
Date:   Wed, 13 Sep 2023 18:02:50 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Aahil Awatramani <aahila@google.com>, <mshavit@google.com>
CC:     <robin.murphy@arm.com>, <will@kernel.org>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <yangyicong@hisilicon.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZQJbunPj6Q8XRcpV@Asurada-Nvidia>
References: <20230627033326.5236-1-nicolinc@nvidia.com>
 <CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: e086fb46-d322-46b6-4266-08dbb4be5a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DuOTFO1BY3RPbv4bVz0vGLUvLn7yubNvkk7DfZNIPnBFJMulGsteJqOgz8Xz9tRnqooJme4jtUUGnLwrMLsQ/hfrPL/gx1FJQF/6zQbIFDh55sICsvz8QK/DF5iqpun+7dYHlrErbgIA3hqsPDWzWv+HDIF1NnIYQq/nSo0/iaurA2HMgMCTVKV0rJZXSdXHVOBZaDPygBm6BCvB0AqVO0JinfIDXtQ92cSnqYUza2EFpCoe14QfNZSNpgj7oW2ye4GH7yXZzl1gGRLWSRFAvM1uEgjUifYUzwp+H/LxV3yU1W5R8SuTfSCfhsTpjATpCy/L0ufetcu17RcCrIuCXut7eq0I7Lp++x40SLqbJbeNpzT/SbW4/ZOSAM7MPtIESigYmQTF1XTaVyR2lI8gf+lAVzzDKNdFvJwnJaN5vfd5ZijBiTwafr7ZKmGyF+73ak3Yyvyhlygf7mEjaZWB8j59WWRr4RQZ/xP2OVNqqRWwIYITmAfzMuI6j+bpWp26XhJ3YvBu8tGoOlZqiXPWIOngWf2UtoRuYpQUA36Ha3S6QSORLN/TBZ1qNIAe4WtXSoebWQ/J2xedMqeU6u09uPa7eWkgK6iBEVge+eJakDcs38Ita2dleppoUTLqZEmACH5vwtFzkv8LlBqMwkmafyim8ijeZ6y/K6z3IE6jU5N2PfrmpnfXiPDbjJsvmNrMGryOc/19lUhG2fehjMsN1OBig7hpDLXDSovfzClosjDljBIxDPMIN1zRUHPQG7C3E0S+/bwPFhWP45CC+Mex3bST12zenKS6g94JhMCzow=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(356005)(966005)(9686003)(478600001)(336012)(4744005)(426003)(2906002)(26005)(33716001)(7416002)(41300700001)(70206006)(8676002)(5660300002)(8936002)(4326008)(54906003)(70586007)(40480700001)(40460700003)(36860700001)(82740400003)(47076005)(86362001)(55016003)(110136005)(316002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:03:05.4588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e086fb46-d322-46b6-4266-08dbb4be5a5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:13:25PM -0700, Aahil Awatramani wrote:
> 
> We have a use-case for this patch to help in avoiding the map/unmap
> overhead in some cases but still maintaining support for PASIDs.

This has another version [1] rebased on top of Michael's refactor
series [2]. We'd need Michael to respin the refactor sereis and I
will resend mine.

[1] https://lore.kernel.org/linux-iommu/cover.1692959239.git.nicolinc@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/ZPEpl9D%2FCqQWYhzk@Asurada-Nvidia/

Thanks
Nicolin
