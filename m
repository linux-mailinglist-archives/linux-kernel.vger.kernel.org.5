Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46FC7A4BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjIRPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjIRPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:20:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E7EA;
        Mon, 18 Sep 2023 08:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJ6FYAbfpe6+PIsbvrfa9KUdNQQNYtCQQt9LjTSNC185iGNBrl+pGYvmSMn2DyVukgkuRHGWQZM2VmeMETc1v//R44as0s5Ebztz1zdODPQVaAYTv84HZA3qA7Y7DyU5gZgF5ltFglFUSGtgfMrMyLJNMFA4s6LsUGq4GaltLXSdOXKHpaK5DmXIpsbZkXd7bFhOo0xw7X1c3kZCWkk2aziKL9JDxU2Qgt4c6lhO4BjqyO5eixBIb03RuuL3yC7vK4Zto7xuyAl9GCWYeqKpmgy29O9EVQn8iRs4K/CfvNKoulWG4oBPkI4DvXYoq3hVWtQ4Hq4YfP1TFJg3SYaHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbPgcWK48XFBt2TflwoSZaMjHQ+x9xnQzVSeZL+g+yU=;
 b=i0RK8C1v1aOOlgcWOWzwJmkdnl6qiBgR3lxd/eBGl5Jap0DV90jO3izWYzp4sQ4tN13HBryW0Lu1iZLOla1Z5uNnFMmHf0lfegqMg9gjp7ydac3u2Q4sNQMu7fARpnyCj6ESrC53L0MB7/YMGTVy7h3AKVcTZQse7jL9Ssm1SowgEUta2okEg9YfNGSD2UoejQLv19vxe5Uu06lIKp5izSfKgkkBPtNkFgv/pfh3VgIH6oUA3UBuc9Q659PSsSZyJFAXWlPkiMHVbOfYFx1PItjlC5IQa7YllqopTg+Kt9vZZPUMzbkAXtZYxp/f6L7Lh3UR28/6dvKA9dl6kt0uHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbPgcWK48XFBt2TflwoSZaMjHQ+x9xnQzVSeZL+g+yU=;
 b=kezj+5M0OxKPSqiTwmJij4U+19ryqGwqV3zy1Y/uTygSUH4TF2udcXTNeVhX9bfsDuy6EqrOvHfHHOcez4xRal/MJfeLqfzrsE3Y7HlqG/SwHp0s5WNf7a1IjqB0V5GAytZVHo1QP/TPbwQ3ZC3a6kPUpjzBgWJ1nBiMHpvS+c4m9yL16ngvXxwRt2pu4+IcAPq6YDFDg8+ea5EpJBpx+gva+rG/owhuYn2bZVV+w4lgD4mYLo9dRPMeQOMPKAbyaS1tq4izym6A8aQSFHH2UwQeUYQyGY+lKplcpuX6ibaVIeIH3nfAUPGnapkYnLdABmYXluLQ3OX3K08cOPVN5Q==
Received: from DM6PR10CA0032.namprd10.prod.outlook.com (2603:10b6:5:60::45) by
 DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Mon, 18 Sep 2023 15:09:30 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::8) by DM6PR10CA0032.outlook.office365.com
 (2603:10b6:5:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 15:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 15:09:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 08:09:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 08:09:13 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 18 Sep 2023 08:09:13 -0700
Date:   Mon, 18 Sep 2023 08:09:11 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix soft lockup triggered by
 arm_smmu_mm_invalidate_range
Message-ID: <ZQhoFz+6WShsf00j@Asurada-Nvidia>
References: <20230901203904.4073-1-nicolinc@nvidia.com>
 <20230918092235.GA17341@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918092235.GA17341@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf978dd-0762-45f7-dcca-08dbb85941ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktXV1QDazD4dE5UaXalnNV2loGn+C12TUB2Zxj2M6m10GThkVWSfVZ3GZFaf9brKN2RGRIIHzTzs8c4s7sIuSnHa1N6WiCJ8cVOA+2FBBy3vxWZ1qg6KfyXtKB7bcUhB4QetR78UnvsmW39da0/5gci46xuo0mYsyqfg9E1pYfEj5Mi/xLxGat6tygt8Fixryzdfa15Uk0vYAWzW4491tBFiVrLg6xb6CQf8oxlW288vu8R4b+nZzNpQ430xAwSAWmDu0EKew/H75J5PxmKBzTM15XB+JcYU7qTFsK7zFKoPS/bjsXPxsmnYD9F/S2qpKyeTawTmgwaPRmkE0xv2qoA+XAh9x7ajrR+5Zs0AZHYmOiX299KHRoQrUIuZhvMZUuEtoq9CIOtFwHrKoe/dcF53e3wBL5+rPeG36CKmMd1BzG9emZfdZKWwB0cp6E+ulkdE+vsy5RNB8oLet0F/7lZG/sRMF0fiQxoBSIbMnnmxeD0LOsXXb7JqMcndACmnj5/bKGEl2EhD5f+OpzWMYzZBNLTUArJHdf3ErMPPLl4U1apOuiF3CpP/UAbJxoebGg5pfP0L7/wb2wiJYSVyhmxLUf94TvTgJ/tEE/PmwmG2L2NRYYHx5OXuN5Wb9IIbnKXohHmTOYIeX7Fjg+qlIGoqEHkoC0sUEhn85cANKcI1vGKidbMbHYklN2tFmrkjjqb9cYk2SnZM6Iu7B5PJV0JqW8jWOUCOqVtkEFfoJZtfCbLqE91kPFfxEJPGVf2cf9Vgra3r9NKdG4C0m2Ibaw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(33716001)(356005)(82740400003)(7636003)(55016003)(40480700001)(40460700003)(86362001)(478600001)(54906003)(70206006)(6916009)(70586007)(2906002)(9686003)(8676002)(8936002)(4326008)(5660300002)(41300700001)(316002)(47076005)(36860700001)(26005)(426003)(336012)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:09:29.7326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf978dd-0762-45f7-dcca-08dbb85941ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:22:36AM +0100, Will Deacon wrote:
> > @@ -201,9 +201,14 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
> >        */
> >       size = end - start;
> >
> > -     if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
> > -             arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> > -                                         PAGE_SIZE, false, smmu_domain);
> > +     if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
> > +             if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
> > +                 size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
> > +                     arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> > +             else
> > +                     arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
> > +                                                 PAGE_SIZE, false, smmu_domain);
> 
> cosmetic nit: Please use braces for the multi-line conditionals.

Ack.

> > +     }
> >       arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
> >  }
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index dcab85698a4e..79a81eed1dcc 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -326,6 +326,15 @@
> >   */
> >  #define CMDQ_BATCH_ENTRIES           BITS_PER_LONG
> >
> > +/*
> > + * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
> > + * is used as a threshold to replace per-page TLBI commands to issue in the
> > + * command queue with an address-space TLBI command, when SMMU w/o a range
> > + * invalidation feature handles too many per-page TLBI commands, which will
> > + * otherwise result in a soft lockup.
> > + */
> > +#define CMDQ_MAX_TLBI_OPS            (1 << (PAGE_SHIFT - 3))
> 
> Maybe stick "SVA" in the name of this somewhere, since that's the reason why
> looking at PAGE_SHIFT is relevant?

Hmm, that does make sense, yet it wouldn't apply to the non-SVA
pathway, which makes putting it in the common header meaningless.
Perhaps I should have just left it in arm-smmu-v3-sva.c file...

Meanwhile, we'd need to figure out another definition for non-SVA
pathway.

Thanks
Nicolin
