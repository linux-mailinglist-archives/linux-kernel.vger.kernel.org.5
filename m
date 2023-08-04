Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF43877093D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjHDT7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHDT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:59:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7084E6F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCiKev+ndgn8VVA1O/rTxM6333+gqRm8mIVoqgpIThwpDLW3q1P6MnqwsPuERdyGow3C+vOCUEEUfU+8NGVRPLOZIOr4dMvqAPDxYtrm/om3w/dPrVRKaw0vvC85IZnalmhc/SeWn2+Xc+1KgUFj7a8HMD6ogi4qA7Aumz65pcEHkchUcctqzyUNsQ5UPPg62Lne/rNTOzxGscSU3EFJPYMhFfIyDtja5zxsZ9uqX/Ehz4JKpBDi13Pfjj9vzL6pr40oD1T1/QFofhDjHnzOz00ZZ654ceq2GTg6AyBZMtWgioXK12YR2Yg6Ol/7YxIfJaecHvHb+aLqXBZJ/yL1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPMFKoOR1OSW5FXrC9tDN0RCgrRe2eysvnJKEjI+LoQ=;
 b=OGhUzjVDWmWch/StQSsoOHSxRoHh9cWYk352VZeweN5h4pAsboLDWXx3c/V5XOkqfX29iRIRBgmVorCGMDUn/5rK07C6Rf9D2S1fY9/g0ZnSbw17r4Y0zoSCYrwgYl5vyMEL5+HAYzZ2WkysxQXTmJPW6KkmsIRQYEt4bmD42IO228THmrSXKMx9UflegKTjPnHP9PsyH+C/ODhDs7Y7B2u/3Jm7Ly//iLmUVxZfMPAUx0NOSHLsBOgfkP98vRrAUTLxIcYcl66ePSYjM/Z/x7oYkOKm5yh485ApRUM9hBJHravlY3300jomlmdB6GugUfx1PbQ04Qt69jKg6B3tBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPMFKoOR1OSW5FXrC9tDN0RCgrRe2eysvnJKEjI+LoQ=;
 b=gQ2UZlQ0y16RUfIJQi74xZ68P1Z8HUjd311FqGZQ9CxFfBg5re06q5WP/jeSi6Mt0zeeetHElj0pIoSVX8BwxWSejtuY1z6fkwhUW3J9fVuWJIFVQLR6uQNViMEel3nOtWStB1JRgSNXO5vO7MXHvmpWFE/IVbktSa8uRjrxyNjI2KqdbVwabKa0ejv/dCqBgD9Xgld+UQKaT4GUkmTN1U5RyD/Medps1v76mMB1EErYw39mXoRdoAQzLaOGvFZGXl68gct7Sl/YoEThbGo1vmNNadk8UJtMPAY0RROMGLHj3kbWa8PMbSUlqdEGoOdnEMrhImpszvxPb0OF50wtdg==
Received: from DS7PR03CA0207.namprd03.prod.outlook.com (2603:10b6:5:3b6::32)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 19:59:14 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::fe) by DS7PR03CA0207.outlook.office365.com
 (2603:10b6:5:3b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 19:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 19:59:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 12:59:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 4 Aug 2023
 12:59:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 12:59:05 -0700
Date:   Fri, 4 Aug 2023 12:59:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 7/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't
 active
Message-ID: <ZM1Yh5vzfxwV5Rbc@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.7.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803003234.v4.7.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: a905a491-cc3f-48a6-7228-08db9525473a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vf60jkcjEUTI3plQx/Kcz7Wb7/MHAVP5ppJfOyPYLy3JkjjdS5nZ9E9i3yb535RJYb8Cfkwkrz//Q8Zlgx0x5zEDbh0fE2c20HCGLzhCAtlCli1s88lkmDrrhNn/NSXSkkUcYf6aHpa6OCBDw4HNP0enY+kLDXYBnigV3nlNWMYF9iveRs+RGvkQr3QrCyL/VYgElHrtgTCSVjsiBHoqGrK3oNKdz1hI3AfIgVSclLC3gDQoVrxfLOxu3N/jy/ROTBp9rnAMCj/FyInJSQ3Fx0858Rckd5twvVDb2TriKO1b1YSzL95pOCDN9upO3oxqJzHKGsZKNVc53h82soorDjiwFfY+AvxUWnxo6flxadngnc8ndRwhFYcXQvrX9jy2AoXDjUI7YE1qtg8uxONB7bql/ew8q7O+Saut/Ow/1nf4+Pyz4Ny0OK19hP/D6vbVnMsfZDQtwSEAk7s+fLudEHy6TQ6pVUaJg4ii3iqVnN+b06hRQRVLTF76BHlyASFD7iotJi653nTo8Xpc86LSLeagCNUzZMd+Zik7cVjD33mL2LiZy9BlCNfqX+hdgjyR1DDBxKBAA2TfoVGD/LyC5rIxuX92sv9FYa0qp3QcGpQkQXpDi0MkNhUrUR+UNBRAz4/FclwVJLgKFJp7WZl3WpPLDAOckuzb401hygZJsWuDDo79MJBx81gi7EbdAFOnIhFKmYD+ImpOMtPc8d8GZMujLfGdD7fDOCTb1qtuFaFfT5/JNoVbfTw9nXkFvK1E
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(1800799003)(82310400008)(186006)(36840700001)(40470700004)(46966006)(33716001)(86362001)(82740400003)(40460700003)(40480700001)(54906003)(478600001)(55016003)(356005)(7636003)(47076005)(426003)(336012)(26005)(9686003)(8676002)(8936002)(41300700001)(6916009)(4744005)(4326008)(316002)(36860700001)(5660300002)(70586007)(2906002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:59:14.3304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a905a491-cc3f-48a6-7228-08db9525473a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:35AM +0800, Michael Shavit wrote:
 
> This commit explicitly keeps track of whether a CD table is installed in
> an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> was previously achieved through the domain->devices list, but we are
> moving to a model where arm_smmu_sync_cd directly operates on a master
> and the master's CD table instead of a domain.

> @@ -1360,6 +1363,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>                                   cd_table->l1_desc ?
>                                           STRTAB_STE_0_S1FMT_64K_L2 :
>                                           STRTAB_STE_0_S1FMT_LINEAR);
> +               cd_table->installed = true;
> +       } else {
> +               master->cd_table.installed = false;

Before this chunk, there is another fork for "Bypass/fault", where
we could set "installed" to false too, although it doesn't seem to
cause a problem at this moment since arm_smmu_sync_cd() is called
only in the context of an ARM_SMMU_DOMAIN_S1.

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
