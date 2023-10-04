Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E907B7CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbjJDKPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbjJDKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:15:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A9690;
        Wed,  4 Oct 2023 03:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcUvHfdjv94aqXtNryDCXUW3pU1eanDe62SgF3KAojdDlFgUmEhtHw40+Nh1e0mCKqObntZ0RK2yfzu+spyzwdy0vxopIMvzqEtEuySKMIS2OAQ0NLI9GQ34CXHzmzHxalOiLOUWA1bHHzPl3eb5GTG44UaREDLb1p24rnHjRL/LmNdDBWLPREN/SXe+ehbNlDDVYRMSinpdUfu8bPNtEg8Jl8wLVstb6TWL3O94bTQB0FueIFE9m1qTGE+1w/zFwWd5x+8NXyu2H8NAFiAAAfL4dXnuTsqcKTitZmR6eShL0vS7J0ywzNTNeJ//YmE9TcIUBjY4qurnBFSRDDvaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN/BEqbbuu2dme09mMaR6jP2r3CprAjGRjRs0WNAOSo=;
 b=j0HWaM/U4wJmgfdnJhlYzw9utirLE8EDddnK/eyPgJ5/QF6cSkc8a/t9gdttgEZRf12gLTJPmkxPhCySUt4Q+in/maEJO46OeoDSi8A/+8c8bRHxNZQjn/UBmXu3dcjqB7Ou7h6Vx1mhYWENn5mp/9NCFwfaWZNq8pL4whfTpkQHQgTMBXWPWgRf8IG4BC+Bgx09jKE5Ro0cWgDjNrORgHZ0rDJUJlq/Yv6vjrcvSneJ+IdhMKTGfk6WCLQGRYMCpiwjXZ/IVGXu09IVIITHpvleegxsV2OKRGCvv5rRqa+8C6kIBITBrYm0CuvVzVif5ZvXVNjDOfi5LV0GRK59Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN/BEqbbuu2dme09mMaR6jP2r3CprAjGRjRs0WNAOSo=;
 b=TL1yt3xDSbMncnzXnS+O1vcGoaTDEPanCbHW2vPnutLpMzlWTMLusbSnGgOnv5SOpTbIFliOQSSqTQPm4KvcGsDLmtVEyEEpr/RBKI9Xbt1zK+Wxj09biJvH6tFbyQKHKDC7TcZycifCAzHlGrV7RnoliXjSNWsdKY8eGEKDvDkSjNYrbvb9v16mLdQq5ZmL4xSCLskxbctmF7BFSVSuN6qVmoYIvQTwuLZKDNMKLHCoy2vdJ4UcSCjRMbrfJ8Kx8R9zyKZViwbvYgWFOGe3cUWV7QhDeCoPG4s0nakkjiNNv+yflEudTZG7Wp4uOjCfaxkXa7tVbBc++w1Yqq2Flg==
Received: from MN2PR22CA0029.namprd22.prod.outlook.com (2603:10b6:208:238::34)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 10:15:22 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::a5) by MN2PR22CA0029.outlook.office365.com
 (2603:10b6:208:238::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 10:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 10:15:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 03:15:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 4 Oct 2023 03:15:11 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 4 Oct 2023 03:15:10 -0700
Date:   Wed, 4 Oct 2023 03:15:09 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     <stable@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>, <baolu.lu@linux.intel.com>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH][6.5, 6.1, 5.15] iommu/arm-smmu-v3: Fix soft lockup
 triggered by arm_smmu_mm_invalidate_range
Message-ID: <ZR07LWh9JqnHc4v2@Asurada-Nvidia>
References: <20231003233549.33678-1-nicolinc@nvidia.com>
 <ZR05sWtiMmM0w2sb@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZR05sWtiMmM0w2sb@sashalap>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9793d3c8-1b07-456f-addc-08dbc4c2d1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVAECBPsa3nF92PYBmHlsv7qoRafOmdhyPIqxirlHi3RRYygvKLPjD2LB9r8ikuV/jh1P6I8pFLOqEajWXk+3uSgzsQC/Z1g2sF8EJn5ucL7Hf4YsFvw/ynm/0C0VK5gXfd1/6zvq4uh+biSUWjslhXsV0DUtmJ0/QQOt19MZYOo+xKrz16wJifVpRJ5hbL6NVhWNGTLr8/wWCVQEsZGVuhywBSFnmHw1AqupDi08Ny4IZHm0bp7DCyNl9LI9OnmLQAMflZC2zS869ae+G/DcEB/KXy0PpnlRhSBbdUYOJfxwnqOc5iJ8DEY8BSrU215NyxI7fVh3bEaTCbbH3Cfa5EvcPZsvZyXsj3/LEnZFbU2B+Ywt6DTWdKvUzxyQ+GsbqZmFGSODrvxZSdSDmvpqzp98Ix9H9VUzDGdryCAIIHwZ3VSifOzP8WJ8SazpEfP5lbNvOPgFRJ5smJc/POWzh+ZsWApj8TH0Mz47g1zvv8QeocfJqLE1g89B+Sg6GxARQVEj8Tl3uSa+mpvjwAHfsaL8STXSogOaKtPyDqyuplf+B9NGzEYbO6JDx1ursDbS+xxC0F01tpiI6I/PuTxlWbdtH1ZSAbmefVH+X1o3lyyJPAngWAY9WH3s9c0K8PMGBZOGdivsCLiX0g/JUgjSjceWWzl3jUVUOOit1WMvzQmyQ4AFUVe++JNk439SVxtIodBsiNSAnGRT1XQIetqxv0i5s97iWs9I2aCjamsIlmfNb8yJ6+r7UPY3NhgcMmO
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(336012)(426003)(9686003)(478600001)(47076005)(6916009)(36860700001)(8676002)(8936002)(70206006)(70586007)(54906003)(316002)(4326008)(26005)(41300700001)(82740400003)(5660300002)(86362001)(7416002)(7636003)(4744005)(356005)(2906002)(40460700003)(40480700001)(55016003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 10:15:22.2004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9793d3c8-1b07-456f-addc-08dbc4c2d1b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:08:49AM -0400, Sasha Levin wrote:
 
> On Tue, Oct 03, 2023 at 04:35:49PM -0700, Nicolin Chen wrote:
> > commit d5afb4b47e13161b3f33904d45110f9e6463bad6 upstream.
> 
> Queued up, thanks!
> 
> We don't need the addition of a stable tag here as the bot suggests,
> it's just being silly... 

I see. Will ignore next time. Thanks!

Nicolin
