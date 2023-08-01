Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471276A7DA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjHAE26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHAE2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:28:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E219AA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFkdyTU4kpDO9+1AtNjSh2KE1ghCHsaFp8DrMuMaD3j92ZsbFXXWOKUsxuekT4FcNWOwzZ7DQvaKHk/jwps3l4BQb2sABjPT6TTe9i/74cc4b1z1u7R07T/rNYGsCVavPE+2d1D+e5jZo/XJOVzkqbD8GeCQm20UIg9E5bUbRhQUvxTodeHWN1gtbr+VKze6snuG6SG3xj1OsK6anv5liXhzh00uhTicU8EDImTjvz1vl0e3BzcqLKTLDJld/G6LWWRWZJoRsxligUf6/tFXyiUt1HLSArctA3JVk2nYV9awD9Q1YnVJFiuQGfXn8U+XZJa5y2uSs8ymlVtqauZm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gclsbi4MF7/5yuNC82ycm3C6Yb2OtcW0jCNqImwgyHU=;
 b=HuMSvVBzIc2ZVKegQZ3TEMRxQ7Ac0FJvh8u3wM7CRuu5ALbTu73kplfvTnWfFbd+iOirM6DSI5PUaBFSIWDB3rNVN4Ir+hF362LpqWOBzUe1tQ+sWCzUKDt4T2gDkfFI55+b/SaoxkO6Lj+48jvC7LcXyc7sKLXkTC66HQMAsAnpBdI23CvvbTNBDSaVckeNJAs1K6DOKrQBe1OclKMV/Z63Yq6WJ5sN8N3W5EEHoMZumrQ3hBE/gmckbCl6JMBCVD6RHPPUBAoXNjWWGTmVSP688hAhl88wwHfHNuajBe+n1alJ+sfg99zCGNkdYmy5IWdgbO43Zyd3BnWWKK+GNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gclsbi4MF7/5yuNC82ycm3C6Yb2OtcW0jCNqImwgyHU=;
 b=mDoN1X29quFWcBhOlPNRNJCDoHyMtSbRoCp1/YXwHa8HIhkcXuGJ7pyAB4Yd4C4yLOmgdmjBUQwL9jcneYHM7duENTG5WcferMMNw2Jv0edJ0NPnOM6tF8Xwoh0p6pZKtzm25SMQRuekI9eILUctR/hXo/KCsRL6Msp1e/ASvx6bukmIm/vauUFw7AWRsle0haVrTa9qGubVrpF6IUeI1TksKT9I8F5zHbF3qTi3fZTqnNLbMRhxjmd+xSZv/cNdt6VnTHcG1Z+XK8gw8F/N3ClG3G/KFaukm0et0l0UBcNj4+8/kEqZbp06HWg150UcNDO7Lnz1qw5k3vMJA76bPg==
Received: from SA9PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:6e::26)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 04:28:50 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::40) by SA9PR11CA0021.outlook.office365.com
 (2603:10b6:806:6e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 04:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 04:28:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 21:28:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 21:28:38 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 31 Jul 2023 21:28:37 -0700
Date:   Mon, 31 Jul 2023 21:28:36 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd
 table
Message-ID: <ZMiJ9Cg5wfbxMZ+W@Asurada-Nvidia>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|BN9PR12MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 6601b5d7-b4c4-4a67-e85f-08db9247ce3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMfksrTyMyB9dgwvy5nNZlAVzv6Sxjyw3bdGZ9P45JZUKAgvOBvMu80HnKcPcvq1aRYWR+HqX4RNZkfEtG9MymQZq3yxmdecUgvf23xpFieIEF+fG5Fo43+6whTb2PtQghCDpPeFf3SD0g0yfUVV+XSVoWSCW300xTo5H6QmB0YTrYhtdFX4svWnzuk+cL5GiMIXxfnb7JzdMoUXM9w5OwoUkiNLlhMyedVa5i7pCjmXJ4TpGv6JDdVT+369Nw7ZFWWr/XMU3QlLcich4AIQerbz1PCBft/8G3a9oeIYG4ypMdaQzLsdtP0f8nkPFK1vl7/3oe93/Qh1q3hpDXeVarxFGwTN5kck240xc6rP+aJnNWYM3BEw9Vmw17eTlW9F0Znj0nSU1MrxKVvLsfx2DvZ5Q7Ok69/3cJzpJwb36DACbR4kPn+a7sJJlAUamJprOMZFzeWsSJgYpPv1MA7lOpKrWWDZYH5Tbbt3PG0aRxMJN2AEiV7CKNZPmIKUAho/KBj57XOnsVtyEjcCiU7zFn85t95CZxvdV/hAIrF7iAAE2m7rL0T4Xzd7osLG+I5C1zCbmchWIhPsPvM/g8DANfESr9KtWR8w/b/ji5OU9hWBNOi5mMAh0gxYWtZz2WDSHELMRGybf0uSvdQPu63jfOPA4iyoy784W2VromX/6AKkwb4jFmZxBPCoZIZEALbJRyYYyOxesQlYclvOtnfGuGPOJxe53MgTnb7n+NdzdTzeDo3M4KcQOUldlyWYOfmLjUrAvyDBjw7XnD6eHIpx+g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(36860700001)(5660300002)(70586007)(70206006)(4326008)(6916009)(40480700001)(55016003)(356005)(7636003)(40460700003)(54906003)(9686003)(82740400003)(478600001)(33716001)(2906002)(426003)(8936002)(8676002)(41300700001)(186003)(336012)(47076005)(316002)(86362001)(26005)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 04:28:50.2435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6601b5d7-b4c4-4a67-e85f-08db9247ce3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:48:14PM +0800, Michael Shavit wrote:
> This controls whether CD entries will have the stall bit set when
> writing entries into the table.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v2:
> - Use a bitfield instead of a bool for stall_enabled
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8a286e3838d70..654acf6002bf3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1114,7 +1114,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>                         FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>                         CTXDESC_CD_0_V;
> 
> -               if (smmu_domain->stall_enabled)
> +               if (smmu_domain->cd_table.stall_enabled)
>                         val |= CTXDESC_CD_0_S;

This cd_table->stall_enabled comes from master->stall_enabled, and
cd_table will be in master structure. Also, struct arm_smmu_master
pointer will be passed in to arm_smmu_write_ctx_desc(). So, there
seems to be no need of master->cd_table.stall_enabled in the end;
just use master->stall_enabled directly?

Thanks
Nicolin
