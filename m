Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249217A7248
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjITFqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:46:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB394
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEiLrmkcUhYypB5cQwXJNHx59t5B3q6fTw+N3cdjQ5ioaq91OUOoBaZTDhgi5C1oDoy22BT6a0qFBOc448YajlgVi8EH/3ZN69JGxA+zAudMNuWi7P9YfiktrJp0+abRpe98h8DY3RDt32TMZOtxis63sJHOlrC4Hv1qIB7hSOg3MA+IejL3x/fI8qQiElXGZK6ZuTTNCu6FSPRDlSg4FF3LXs79sHWSCyaS2cGQCIlwkeZDIb2/H+uN3RtpZ4asinEFM0a3XU2Ku8OyPUmXCgRBF1EEMy3NK/UwlOJX8383ZO80rytlH+0w7sSTc5IY9ygIfb+xcyleFLgVBdpXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bD/MXVv+U61wlCIf4RpUfYikmzpEZUf3NQpqDYHdC8=;
 b=TJE5niAvFUL6phUc80bxsC4H6ewYyY0d/WrFs+JSJ5ybidq5LmXOusAgJbFjKEUlfL/g5/zi52HSYJYCFbbsfki2sb7Mq45Xx/CnAt1OIIwQOSJh/AMKfqyZ7HVoREUOY+rpLfRjEzv1uUZg6SGp7cAE84+pW4EeQj88OEZQAdbrKBLuFBzHHZGREwwqDXeEt5dMjIOvrcOdCFubuMkoeDFbDul10i5cJntFXFPyaBNNET/0LDy61q+JC/D2gdVBs1ZT1a1j0WHX6feqBP/OJQYEGZ9X6ZDJjo2dr6p04KkXXUU8Y+VQHNb5DWvkbg9d2HpdaPpQuXW3j1HkryVRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bD/MXVv+U61wlCIf4RpUfYikmzpEZUf3NQpqDYHdC8=;
 b=Sg/o6rXnaY5tSFzEhBQqkFamS4DhM9c4bxyA897iRrI7jRi4/e/jR/JmhFWXSFa5RnKFeqW3xAquxUm8GAFILdumraYF5Dg3eyFtQud1w5Cxyt1yMSdmXiYmFvzZ31fDVMqYCyn6LjbfuXEIiNrb98KZW9RPgbdZ+UUOox0dvUxtnFCW2hTb6oPHE8nLqWMl60WX/YJd+y/NmDZ+WxdyxSHH43SZ1qGfVIqy/09JyfajJi5ReznEdAAfRC+Ks+kg+cjsnBB/P8Dh6yiViU0bJwv3daC2nRZkDu/ufBw3ifx3oMK3b+pyc01TVvrmV3ZF1K32kdjVxT5MRMRT/6ivkw==
Received: from BL0PR02CA0109.namprd02.prod.outlook.com (2603:10b6:208:35::14)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 05:46:20 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::5f) by BL0PR02CA0109.outlook.office365.com
 (2603:10b6:208:35::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Wed, 20 Sep 2023 05:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 05:46:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 22:46:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 22:46:01 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 19 Sep 2023 22:46:01 -0700
Date:   Tue, 19 Sep 2023 22:45:59 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>, <robin.murphy@arm.com>,
        <will@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Tomas Krcka" <krckatom@amazon.de>
Subject: Re: [PATCH v8 0/9] Refactor the SMMU's CD table ownership
Message-ID: <ZQqHFz4WUQOub7/F@Asurada-Nvidia>
References: <20230915132051.2646055-1-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c41a970-795c-407a-1992-08dbb99cea79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/WXIGEVmCVcVoW/3Wtuv2ZfQBaXZeP134fwNA7F6ubAmyEbsgMrNCPqBccE3qhtQkJitFKfaDYx9jLwhZ6yiwM6fYpQ47WJA+3NwVnayG0AllX1p1MUhnbxQNCob5enmM2GVK7vyxq+J4Y+WIETdyJxQYU0FwMw9l7LtgrjMU8tHxQO3usjcg/1aKaPNPZJwNWukFHsjm6wbBG3waGhoaRO4FsqpnnwT5XcwJc0lZjiyTVZAaCV9Tbt2qNVbXjg70a0XlEBci7kPmPPaYVXidQ1d86U2F6REAh9h73rlvksOB487QMuuSv3zvo7ogtUpxmaOjCSpymRi+T4wJ3AFAJXLSBSs8JVhHaEmlnHd8tC0uopOHCtb8sNxswD3RuIOtcOtO7391NE1v27ECi4y1/R5tHKyxb7jVdcXA0HgpcAYgNh0kNbNoiDJo5S9ykUh0fMswB1Hg7N7bsEAo47o24TFe/x6tt9pk1OFD/+32IO6rZ3LWom3BIgDpTf04JxQ2KkQKrlaxsU1uFA1Y5a+oc2bT4FChfgYC+rKhrHmSNN3ZiyllmfquvsDpcK+PnqjsruvguHQgNyhSfXqGdc3rlIXGcbZiIto4TdUsdoRMS8WnR5gFAJA6lzC/VSZbCipelJhLJXnkHC7XI0zFr2hxtr5l+OK02IVqpaWdzXqpoycRApc0iNgEyNleFF2hoqvngLRCYXFDR0aizeYl8eQesGXoz4xPI9roNOUHg6Qsro9MXwOw23yG1Zf09vbkIXlOEbnxEvGlgALJS+4hdNM6WtuThcv20PmLC/AZDHsjc=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(55016003)(83380400001)(7636003)(40460700003)(356005)(40480700001)(36860700001)(32650700002)(82740400003)(86362001)(26005)(336012)(2906002)(6916009)(966005)(9686003)(426003)(478600001)(4326008)(8676002)(316002)(41300700001)(8936002)(5660300002)(33716001)(7416002)(54906003)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:46:20.0711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c41a970-795c-407a-1992-08dbb99cea79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:17:31PM +0800, Michael Shavit wrote:
> 
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
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/16
> 
> Thanks,
> Michael Shavit
> 
> Changes in v8:
> - Rebased off of 6.6-rc1
> - Drive-by update of the "Move ctx_desc out of s1_cfg" commit message to be less
>   vague.
> - Link to v7: https://lore.kernel.org/linux-iommu/20230831174536.103472-1-mshavit@google.com/
 
Hmm. I recall that I gave Tested-by to v7, yet some of the patches
in this v8 don't include that. Anyway, I retested with this v8:

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
