Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA59A77EDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbjHPXpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347218AbjHPXp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:45:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267822723
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9NNieOdxnw0+0R3bHTXJgbLgUZgcaAzTggn9oZfl7oxzBy7aO/to1f9HwknPcE3MujD+zW/b1vuqpj92ZdMXGRsnD4B2/X02ShWpopyAmlLUXat3bF00adO7ELuc6n1V8IuQnm/7ZENT5LgDghbXzzCUV7FZJduMYRg883+n5RT3DoAzmoD8tAePiduwj1+Pdhkwx5To4IAnIInYBOG53RfP/63g51IgVY3apnKIbH27EwlYQowU3Cxf7pR86/DP3z53uaGN+NUI0X4Mkiqfr35BRTeucQXosJS28ORqI0c1lnj+urg9c/Rpv++zhbZ6g093QJPl4aBzmoTGkH6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPcnZMrgjvjSF1P6eaFSEg6Bqeou+USPSXEleh0CjT8=;
 b=hlhmXwFEEH0OSyMDp7Dtgxg50OdTaCswxmkXln/5PcZVk2Zn4g07cOb3x0fCe4PBaMmwS21KWxuj0LUFbLWZH9F5Dmo804iAkCAweImrlf5ooo97sMOvV7PuZVXC4bbJaipOYvr3L/JKe4fpLf5WmM92L/2xSzBHgA+7v0N54yYmUqU0T++yGFZDViaje4MFEQmROhSBPB/uM1t5uYebk9nKDUdmAl77k/snDZ0WaI4dQFbpBv7eC/k+XZtpm0OGFSj9VyXoej/0Z1gbVRlKaLahJm6b+ebf+70v9MRE+61xENdz44Ne4CLfoKC4xWlbHRGJ7WYgcx/PDCGGxwvITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPcnZMrgjvjSF1P6eaFSEg6Bqeou+USPSXEleh0CjT8=;
 b=Fzw4KNVmpwvrmyUWRjYettVR+Nwx5U5wBZATQtVQQ+hUwHNXRkBzYY1dWyv4X2nCEMnNFp8ho2lYBO8ondtxVkMAqVnliGiVq3QFP6baPQX7g5UyMjy0x+9vh+R9UFgDhIXoqpi125wShxfSvEmzWhrZbAEL19mO+HC97Q+7iWS8fLQnyi8VBe98X/5IEc3xjwBFHiAZPmhnmLgOkodyURys4SM1115s4ae9vi5v+yiNAUn7dmKcweAv/S9435k0t7opxoiN6qU11Q2Mhr7yTzlYL2kLN8mCxJRIeW73BN4wq0WCjCMNaYZO4O3A+OQK1/9EU1N/ti7G7dTyZsGTvw==
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 23:45:24 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::25) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 23:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 23:45:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 16:45:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 16 Aug 2023 16:45:13 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 16:45:12 -0700
Date:   Wed, 16 Aug 2023 16:45:11 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>, <jean-philippe@linaro.org>, <jgg@nvidia.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Cleanup
 arm_smmu_domain_finalise
Message-ID: <ZN1fhx6g/HFs/Rtu@Asurada-Nvidia>
References: <20230816131925.2521220-1-mshavit@google.com>
 <20230816211849.v6.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816211849.v6.7.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CO6PR12MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 589658b5-a4ea-4b29-bed0-08db9eb2dc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AtW0GoyJKpf9TylAi2edGdqMnVswmD8xfl1ixe83NpaXG5/a3RNhkY4qxKLOtj8iLEFlDuehaz8KRRzaCbakWxEUbOy9BJu3YObmGLQ71Fi1bBmxr73XVMFBaNRqfJj8h5NHZUJ4ZiMlRMd9Bb7rGzKrL1H54IpuL/Id3kqZtgfHb9k9Kz38z9/luVAxHcURBuMdYNlOQiLPf3IkR4JKVylK3JfFpM8XOoEw2ZFoG1zXMnnn36g3p6Ac7GOgVLDRvWgBIP7aCYzJlYj0SQAxD9OdktsDGLpGdxSze1ls4oxplk5E30+QdhheXFPMubah5FEkRcd6hCjC1XK2vJe7ER9S6Qo0riD2jrAajQSWPOi83dtZS4aXCpf07S4LUHkNWFIk08MUjPSWOBNJ6VmdMiwRYyqBJ0RWNU9uGb+HpyckOMXAxxtTLBOhw4WzDFyPtkcRxIv0GfrMI25UnqWsT5RnDccBcx4Kr2t6znbp9oeZovzo+wam27U041+1xqoAAgP5IWSC8FvagJM1SOKEdEqqXuVv0RrRR9d1LOXDdyByFRrYzTEHWCIyHgNfYFJtcbRHYaspg6Iv7dZpCUod3zV40l7Z7a5sSDhd14+GmPjx2tNRroLuuMPMXE7B6C505Ppgiky/4Ec8sDT4cZjnlKD8RJtPyIGVFu8bkLUfxHTWoi8KirCHz083WIood+lXajZK0Hae5Jt+wQKLzvUaZl67U5w4/JdTGrF1mJYrfoPWGzkytUzTQD9QBDy4Irn
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(7636003)(54906003)(356005)(82740400003)(6916009)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(4326008)(8936002)(33716001)(2906002)(40460700003)(26005)(55016003)(40480700001)(426003)(336012)(478600001)(86362001)(558084003)(9686003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:45:24.1470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589658b5-a4ea-4b29-bed0-08db9eb2dc6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:18:47PM +0800, Michael Shavit wrote:
> Remove unused master parameter now that the CD table is allocated
> elsewhere.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Michael Shavit <mshavit@google.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
