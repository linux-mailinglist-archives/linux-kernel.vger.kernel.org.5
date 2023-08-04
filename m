Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E0770913
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjHDTcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:32:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E41BE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9VFn2D7yRAaXncqZcIzCsZVqT9F6S/Ry/6KisV1I75o4VoiIn4uv7zAsrZW3IA1t5DCC/2D7nyjMq1rYuH593yY55D3IHatHcoFC2/VHstz27Ld30MUSX4fU0Nv7NXI1RpJuSBVVD/WGfEQiXq8fbO4isw4m1oBlTTrCE8+F1D74VBrosBKrJeNinUO2dUce2N3D7EXND1W8uMQXCerqh9n0t/BAMAHOcy4V4Y9KeyjHX/NkzOl5uKi3PRW4DwPixoBctAN0lKHh/9S0ZAEnnYoDAFJXFQD90mBFhF1WkB3O57BxxpgiBuOHyx0QVIIysy0RidrgK4tlG1SGYVwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHehE5H+PRjS3vi0Gmh3hh7gJ5mRfjYFH4bR1ha6umg=;
 b=fqMRKi9D5u8IyvSvdkEetJSEgJLf/qorEeFIECQxplLvkDMrwQPIgzN+JXgywD306ZfbSeUzxLrmDfvaOzYiebc902cDRjGk6v9ID6dyZiu1rYAQxmLAB3btVDc8fnuzYCYzhjqgWkiH1c69YMzkAiE4FSEWYiyS/208qLPHqzD0Q39OcW8aixDBlHn2kyJaMVOyWZRPB3sgcBODTerArQzCVvbBVY+VTc/2oxJk9vcfQi4W7VASUISF1mJfvVOl09Rh7jUXhDDJ8pVT/Fm+UXV2WjzN8GuVhH9cb4Ct5C4gTB8gE0J5TGsPI1noEz0UovqezN3KMaskY76DQisVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHehE5H+PRjS3vi0Gmh3hh7gJ5mRfjYFH4bR1ha6umg=;
 b=VfkuAA+VQ3SnNCHYHj6HyPsWN8gmsrHuObiBGfHiO9ySwQYLtQRg//OPnbdqW4y8fSwYVxCfoDOzsaFPuQz4UsrgoXYJPSvqgMzb6hckY/N9zHuzr5KiinFg525ysb0ymYEmuORmLFG2RGnH6L/LInMCqBf2h7CSJ4zFL9M+5ooszEGQEp/Hze4Fy4M2RsIXSAbK12vPL4+6KmWyooAKlSIoUwoM0ux1g5XKNFtyY5+Kdjb+A1IWNcCWcoauhYmeowr8oCGwENRFfuAiOnLuo1UJ6kt/1Idt4C1r7qXv6eK/SRkYlI64oeCfg+ol/bD5Kjkkv3fPsRE8kYltJF/bVQ==
Received: from CY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:930:1e::32)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 19:32:09 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::b7) by CY5PR04CA0005.outlook.office365.com
 (2603:10b6:930:1e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 19:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 19:32:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 12:31:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 4 Aug 2023
 12:31:58 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 12:31:57 -0700
Date:   Fri, 4 Aug 2023 12:31:56 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 8/8] iommu/arm-smmu-v3: Rename cdcfg to cd_table
Message-ID: <ZM1SLOcBQK5TH3io@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.8.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803003234.v4.8.I5ee79793b444ddb933e8bc1eb7b77e728d7f8350@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f25ea91-c34f-448e-41d7-08db95217e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHWLrnt/Mlc88pzDTYurhNKYSkWEcULxiwsCFFsL75b6OBms+v9ioZv6weiwvZsVz9LGcWm22pG9sPzupj2tkfBuTMDIlCISkxVPW0IyofwS6N29iolrj6F+1YQeAle2nqP+rsM3ONUB9NLtOePpqFxv/qLP3UC/XX24KFYdyjGD8hRDBCEQq/zhyISmRAFN0jgiT755+NkRhr/nM7BumfjzpJSI8H7IysxAOOp14vxfXhLKj9W6o1URjsJD2Ax8VuKOaqcNyPrONdiBno1Dpr5MlsIS0z1i4RY/ddBeQnitrjbMW5CL3dG5DWKMTrk4JB4qOZ5QZC8CsNiZQmjdCLQMK50h+0pbv5Cuv2pL1JVgGCX/j1owHnpTfvobqCn71JkG+jMaoKfqWtNBgUEESm/vzhJJTQ18A5R/jwAIRiKk60RdOwjfGfYPF2HEXQaVlcDaActcC+RciBXcVkO6k1GkQEwclAIaCUOkQabFS9TN8WmQdDjEI1MFBsvvBuw9s4rejkQRP80Ojaetz7WNTYmFnqh2vWro2JtbyTFr2FjmSYAgK1Cuq7IY7joFm+KwS6urKyxJl8A4QJvJUmv+7zwjb+k1LhF3a9z537J8Um4auW/CgkMWRiMRfbOGFplkFFjblDDl59OIPMwoRrGt0nX1i1w5YEYKYkYbFT36JHh4RP3g66iKquzM/pQSU7l2XyvMYk5CwObh4+GG7L0Oq7Cpb5RVLDnjGqX2RVGWlls=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(82310400008)(1800799003)(186006)(36840700001)(46966006)(40470700004)(41300700001)(6916009)(4326008)(2906002)(70586007)(8936002)(8676002)(82740400003)(33716001)(356005)(5660300002)(478600001)(54906003)(4744005)(316002)(70206006)(86362001)(40460700003)(9686003)(7636003)(26005)(36860700001)(40480700001)(55016003)(47076005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:32:09.0051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f25ea91-c34f-448e-41d7-08db95217e7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:36AM +0800, Michael Shavit wrote:
> 
> cdcfg is a confusing name, especially given other variables with the cfg
> suffix in this driver. cd_table more clearly describes what is being
> operated on.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
