Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB677EE04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347257AbjHQAAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347256AbjHPX76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:59:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DD62723
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kICC4rlcecA1ygMJjdNZKMZVv12T6xrGg9qoh/j2ln9mD3/YEE/Ue9W9T7T6LLcTb5Tq27PE8EEow2gk2HEYnDLSr/+12lD0KC8ZOct5IorvkLs1L1gzWWCElCKIZCHKvDLK+/A4Wr2hc1t3Y9Zls85UuzrFtO/1vFnbSpFKlg7RIBpvu7ErdDM6BioK8cxafZS1750lZtxdaLf3BQrZSgffcLqRT/S2aNpV4Xtp5S7gxbtDscI8SMDdxru4XrNpsR8ePDi1IN094GqblAgUeufVEEl66F037ZcR8aHV4TxW1b1ncLVzQo7258eMgUcZfnhoML8zaZ1xcGu4QQsqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew33r6y1I2OuuUoPDQTUk1ZLuV15mRN77zrStgRkuDs=;
 b=W/AQkICE6CEAm2PF3s40MBlxdB2sKCN8xYbQ3KWru745ZenfHdImdWZIff76aG3MuHdY9zBoRr7Fue0AS18lzLFY/ElLu9gWpI4iWFkthWHiQcdOgtzMdrtvmBsMjKNaQ32JNoSuCgqudnoKuZgENgTwBgQhm3xG6Pa+N//COUS2C+6aBMEu/6GQ0mMLCRNJwPGrWA9eJ25pH+0PkIlBN4zKaNs/M1p2kDTy6HPc0c3lv76kS9/KAhCeS9QJnTMNMpwVW7ZP5Gzr3N0o9xJeA7I9Y7gcdObE3x0w5NpDOtGUk3+RZQR3rlePQDYogtis9JC8wNnf5MjiSOLol6N6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew33r6y1I2OuuUoPDQTUk1ZLuV15mRN77zrStgRkuDs=;
 b=cZcKS/TIucfsQ3e32cSkjKXEGcmUErqusbVlwj+hKYdV1HcW8vDGGQWbmYqfPKzGhcHL+ZM3E+z1REou6cnoclbcsBH9K/mloXCWQzFuFSLzthGO6+GNXMGMKikylbA7Ww6bEIdZjsGk5Osfe2eRBm42LagVUxYFO40fbpxEk434MSrMPpB+Vtg9Rw6v2RGADEhycN5Y4khh0vav4vkAZ9OOYMyWzKn3cY6N5tyxmTMymLCnC4AEHqqVURyETv7TED+W2rLj5O74pTdTclObu6Kzg8toG0sNzv7t7hZmog9rxneOExicZKxWb818bEi/weKfhocf3vWa5d9g6Xj2Ew==
Received: from CY5PR19CA0116.namprd19.prod.outlook.com (2603:10b6:930:64::8)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 23:59:54 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::c2) by CY5PR19CA0116.outlook.office365.com
 (2603:10b6:930:64::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 23:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 23:59:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 16:59:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 16:59:46 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 16:59:45 -0700
Date:   Wed, 16 Aug 2023 16:59:43 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>, <jean-philippe@linaro.org>, <jgg@nvidia.com>
Subject: Re: [PATCH v6 00/10] Refactor the SMMU's CD table ownership
Message-ID: <ZN1i793BPZ+snidD@Asurada-Nvidia>
References: <20230816131925.2521220-1-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 2653f965-e33d-4dde-9fc8-08db9eb4e330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aouBSyzccZfssej4fXCa64kBnWEaAdx+jK/u6keGjUEKW0wHNbRMIS6P3oQ/X4Ozuz92wtlESh5Kdbdwev76A3Dtk/+j/iJ+KTBC8NSuE/qa6gC0GDXfJ4ispKOVgJL/eeUjYq8jfpBTQ2mf53JWprzm54Lem9WtN52Tlwce0bD6AsnELhCvTLkKk4+G3nAT3odYJEejDy+92zpj7BkBgsxM0CgoPz6wRslCuIbpQukFF+20BjyY9XJIVFqv89v2EGBQXwVv4zfduhc7ZXRSsWCo2XAFV5VkAbvP7OsevlOGRrCdlGLjne/TxlTsuXqktx+w+Wj50F8eiLChbxvyk6SfQXsj8NtRxa+b5il1ezhlBY9PePxYS5Ck8kIyWI3A2djHeTK7d+GcDZgj5OHaksyV2zvTKeyH6ObOInsGibAnxuXcOAsb/6OXKQK23l4peikjGiOXeP/PdMrOvVwVUO4xfQLMh0re19o2svU9B8ilM0ow94i5MpVJmiQrb2kZCbCVrJQ5KTuU5rxKDZ0KzodRkL7how4b2yGzkbtHFuVPoJVvYEl+8IT8IaBUCvonUNsQjNF4HSMKt0rpxGEvsBh+hfHziKySZmfLlZkJ0Y0GrS5DqZ7qXK9pVKU9SDMyJgMrFKcTDNibAb1mCDJW9dw1qBw2lCwxf12A/2Qfs981ff+EcRTy4J8YpQ97YYODErQhOdD9c/AQd4hjkkfCnOIBn93UfFusZqshvAN+2p5imJgGR8+9/FZV80qwNr0pu+vpBCOXa7w1yJEzWiCutj1mzBjnYhe0ImOpjAu72BAd+Sjv7AaJ02Sy12UhSybp6W+sXnkLpichTS8RvtViZAh7nGGyY8oWglPvJ5YcFfY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(7636003)(54906003)(356005)(82740400003)(6916009)(70586007)(70206006)(966005)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(4326008)(8936002)(33716001)(2906002)(40460700003)(83380400001)(26005)(55016003)(40480700001)(426003)(336012)(478600001)(86362001)(9686003)(107886003)(67856001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:59:54.4567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2653f965-e33d-4dde-9fc8-08db9eb4e330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:18:40PM +0800, Michael Shavit wrote:
 
> Hi all,
> 
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
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24770/9
> 
> Thanks,
> Michael Shavit
> 
> Changes in v6:
> - Undo removal of s1fmt and renaming of s1cdmax
> - Unwind the loop in amr_smmu_write_ctx_desc_devices to NULL out the CD
>   entries we succesfully wrote on failure.
> - Add a comment clarifying the different usages of
>   amr_smmu_write_ctx_desc_devices
> - Grab the asid lock while writing the RID CD to prevent a race with
>   SVA.
> - Add the device to the devices list before writing the CD to the table
>   and installing the CD table.

Though there's a thing in PATCH-6 that I couldn't fully understand
yet, SVA/ATS sanity works with the series. So,

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
