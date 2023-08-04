Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93587708E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjHDTUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDTUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:20:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE26B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/5rp4q/n0YD5AvKqo9ZjyLGcHJOuOxcdndU7MHsYXAyq6ZvdUsoQNME0ccBb5D04+3vkttZJyl+4WwbT0RGYKO4EBoJx9WlLmjFbXb+rLiQH6iislsc1S1ehkL8HDRBZC9eITzHkjuyxGW9TEi49dWdHb/0DUZdfMTTp+K+SqIs9Af43oHTBNQlVjhPY0bleOF4ZZwHG7k8ljhIU24ijYaVVpDufiOncec3BWLSntB7HJ4unkyFrTeeZ6D+fAxs7SgzRcBmDYvGDXliFkhhwx7WoYeteaGnu3CLPxXLoHS/CaYgjLi/KGF9QbNaJMzWMI/o411Y3mCX681Q4jfjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxatYg5MMDPkpA26LmckHapvvA9ZBT9RDlhJcDKKNG0=;
 b=Ek2pFVyL+243lCtkrTPoPWAVbSx1rsMyOSrHdzKsWENqJT0H2fmaX/a4FYc5uCDet5IKh3/TgsYZVYYy1ogi5q3FaAV40FIoZjlPzbY+06i2l1IQWHh8/7M7GAi5K7+zXSnMpR9Fp7R6UWLheugtu+mOTk+QycbLm+HR8PWo6Rh8YvY1ocikzQn66mm3eW8hcJicFnJBWizKMy0vpj8JfQLlA/x7ZaO8BMxyz53GSZW6c3SVrh7B7nTcmKIT3Jy6LkfPI1bFuHxaLflLWw1bNR8HFjhV93cWDADLdEmNSBIkvTVK0GDJhPe+SMZvT81O9JBbPjp4CFhkt6tlVD7Y0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxatYg5MMDPkpA26LmckHapvvA9ZBT9RDlhJcDKKNG0=;
 b=QdcCSZPT1Ld1zc60J+jhPqPwGsEDdbADKezxIkReFUhWTKVO1kGbUYWXp0yihe0v+QxXB9TKo1OzZIZBmdz29fq7KmSw7SiLHHI/B/fNGfEDvPkK8Nr3C2NOiM1eLrt/dKpZfwC7amZdHLAe0dHLMZjzr/6DJtxgXcFr6s8K03TFQQcEkAOwdxjPl2PknBNmamKgxRe6cKOJRjgJ6R/2qAB3PNh1r2w+gc/CkrgyXB/mA9SiP7wCwGoF+pus8KC5Go2xV2y8CIlJyEmhC+h+oX2lZIxb2dVU9ghFyQrqt3LfUaqmCZp0Oxy7CYz1OWvpv9KG+16eAG1891+HqOwtPw==
Received: from CYZPR05CA0042.namprd05.prod.outlook.com (2603:10b6:930:a3::8)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 19:20:08 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::ab) by CYZPR05CA0042.outlook.office365.com
 (2603:10b6:930:a3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.10 via Frontend
 Transport; Fri, 4 Aug 2023 19:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 19:20:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 12:20:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 4 Aug 2023
 12:20:00 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 12:20:00 -0700
Date:   Fri, 4 Aug 2023 12:19:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 1/8] iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
Message-ID: <ZM1PXgcbEZTdM2jW@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.1.I67ab103c18d882aedc8a08985af1fba70bca084e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803003234.v4.1.I67ab103c18d882aedc8a08985af1fba70bca084e@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BN9PR12MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe14c8c-2671-48e5-583c-08db951fd0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lOsfa2bBb9kK4aMI1yCbWJ8oFc3HMTCr9mI6H654r4O6lnQ+YOlX32yUySomLUB16M0wb4a1mx0nJ/4pDRvqzue/3FAKPI9c3NXxXDNz6IbVG8QQ3NwOslaif7t6604ocYVYebxdXS0IcYHaY1iksC3gj0RNSw08wi0HRxknfqa/SUrDirZ7ZG92/KVCAZ7G3C8GOf5BA0+9GuUxG6npEyEI1io0OpSWg7By4S5bkGZ/JBBYmID+uPkmPhHvbWsfDB9dqnAaYDiWLLKZd1BeDMoh3JN4ZcRrslyXwjujp2JEWf8PViNtecgFKygiAlnZvDnOx7rGeSF2NUXdYu9nGLaYBrOOkOikCfjYepSX544yQY6m0/mbmObqmy3OJq5G3vKPVh8XC6YamVk23Nz0/X8uinsziwYKCCyyHwCHP+ZVqZ+b9rS99CFc+FTYvP4iUFqSrtmkeABRLAo7EMv7w63kUHysYCcoG4UDjVkMXH/zvG8m3Tv6eGmVS2dd+ht61TbDE6tbTL/GRAz4pyr0HFAjFqLBb7tWS5PAe31LtNZOve7/QUuwWbu0/E+v7AfmulWhm+Xaz3SwexpGwiOIcPupvLuGeS2xpPm9bRar5W0gVvxMpyG8odIUIA7LRNry4gt6b2+guMi5EKgXMpzm4CWSlv0hXlRQ17opGl8640ML4pUQKmknry5h1ibaem8GYBVTTSvhpVHg1tVuBDV/AzqhlBmNzAmUkODspFjEOc+pp2ItQHbRxyEEbDL4mRA
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(82310400008)(1800799003)(186006)(40470700004)(46966006)(36840700001)(40460700003)(26005)(426003)(336012)(47076005)(8936002)(41300700001)(2906002)(6916009)(4744005)(70206006)(5660300002)(4326008)(70586007)(316002)(7636003)(8676002)(9686003)(36860700001)(478600001)(54906003)(40480700001)(356005)(55016003)(33716001)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:20:08.1883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe14c8c-2671-48e5-583c-08db951fd0d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:29AM +0800, Michael Shavit wrote:
> s1_cfg describes the CD table that is inserted into an SMMU's STEs. It's
> weird for s1_cfg to also own ctx_desc which describes a CD that is
> inserted into that table. It is more appropriate for arm_smmu_domain to
> own ctx_desc.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
