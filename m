Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D9E7ADF22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjIYSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjIYSj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:39:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A5B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRmpzHX9q/w1wNLStRFf2pytwKAcrqw3/McIC3HIIpAocv2aCfp/4f46fX96/s4LZTVIgP6h9yyT4dhlGGs8uLAe1NcG6QtN8J5HnOQN+CnyOOKg+GulSr/+eunmX4vctLJppTN2pddtEjN+aDv4LMZvdkYndmnE8UB5aaa9MM1Nqm+xJQF616arE43J52ALgJgVv1PbP+E5hFaqjZwFldF7gNfPAP1+XFogDrV9e77UV1znH9xW+/YZpemafbVxkSZsGA2Lmk+Od0Gn5SdRZzyAznxRvl/2catLOIst+i9XHgw9kn92vp70mT4M8sAQEq+j2dwMkaT2x/hUz9h51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad5qwVE6cXddCiLm2dNc1jo9xic5n7Qv2wty6xtz6Rw=;
 b=iaZzkzdua3wGX7yCzGzwaXDGlok71o5sF6TdEF3TJ8UcRpzgrhEdmbpiCkjHgVErtnzhumBpuW0Qam70mv7mznrayTdGai2KURi5935jOjnb1WBLiVVo8ZYM6gofxwM+0H8aYOS/4zo+Y3+xLXATZGwjeceMQrbCZXpbawWIQAwBPWzVYyoSxCbYlkCDrr4sLNqb3bEir8OfOfkqIRM48bNLM3we47m6GL/3SSgRM+4WWDQFAqRWH4K2Ttk/3Z/bI7lsLsOztvpjfyOOc936MRO0YtNqdYoOLR3hb0akS4RNINbKcMxki4nsZ73AGdSNIwbmH8C2IunZw/gGsdyi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad5qwVE6cXddCiLm2dNc1jo9xic5n7Qv2wty6xtz6Rw=;
 b=BI8Gtnfw87MCdpAzYGHbI2xziP4voVu/zC9r64VxnPpBFLwczkKtxKDZ41s35pWpG3BYHZS8k33e+Z/OX338gGTg4W4gi7P/oOFSZWgjOUtvnIIrTTpDHDom301KN5JwyGdK4aQuc+EbvLqLRveTAv1WdbxU2wpHcA99/NAFQrwqtnE3OYf0HCdyRHpv6SBHZTwua5lj/TzZRblzAU0IC9sEr0RtidZp4KZRJ1Pq9tuWyyNsIJCM3K1PcYpdbW+78RQ3SdhlAT87ek7k51VETRootL1zqWswQ2Xjai88tswnqMUBFNgYRsD/jaAAa9ctUButCmsZSDHmJXOXMV7LXQ==
Received: from BL1PR13CA0253.namprd13.prod.outlook.com (2603:10b6:208:2ba::18)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 18:39:21 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::30) by BL1PR13CA0253.outlook.office365.com
 (2603:10b6:208:2ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Mon, 25 Sep 2023 18:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 18:39:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 11:39:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 25 Sep 2023 11:39:00 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 25 Sep 2023 11:39:00 -0700
Date:   Mon, 25 Sep 2023 11:38:59 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <mshavit@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Add boolean bypass_ste and
 skip_cdtab flags
Message-ID: <ZRHTw0+DCYGjFX0P@Asurada-Nvidia>
References: <cover.1695242337.git.nicolinc@nvidia.com>
 <45b65b0a774068be805b7e1b45063fe10ec51d3a.1695242337.git.nicolinc@nvidia.com>
 <20230925175708.GA251639@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925175708.GA251639@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b8bfc2-777f-4e71-b606-08dbbdf6bb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRUOBthb7BBYZhnvZE26MlaDVZ/LUXyiM9OLff53JmVI+0Dc/CczIWQ71sHwl/gMApWjUs4ZfiSVY4pI1gIj97+fl/eGLCWkxCZsFTgztkgE+kpidgQ4p8mZLUnHS7Suv6yGIafcrhNUPMxuk5wIa2R+0lrTnGHEZMWvi1RwdN7no6F9wQsw6hDyE4wQj5yp/tt/g7KPFy+rcoiI0K7Rbr/5jeCOMPuB6ECeXhFwJZsH1h5dDHSQw4zBOwxWmMsPFM5PBIcYSQiQvJwOX5RAaWy4VqrUAtzreEAtepgakwCuY1+aYJKnCC/HhHZBW2NsQe52ETb+ItWhkiXcwdt9a0oT6R5Tz2ModQWsAmBnhZdcfKhGCMp3NMCylHcPCfmJt0xp2wDRpE6QMIWkde3P1HPtNOAuOSG5QS9UShhqw+b0VBdbExlp3gBX803X8R8HrT7N58y2Z3p952bUeCQVhoqLp2t+xbRoroYxTp79NrCCfBA+IMPohfCLEfR5nmJGxIVZqNYcu1SvM3n4SRku+MrGRH79d9qCZC1kphlSkbtLCeVFJayW8qa66Jh2R/2wz/gD5/NfNCwTmdUegvqOZgbE1dIJQKsOfV6tHuu10ZkCQ4/eTD5RBTrnKN+8OpiH56ww4v4eID7gkkXlD4coi+ETivn7r8cUGhm0klPFr6AfSj5M4yV5LpArJ6B1MyGPz0Z1O9I9QmV95VXljtmcjwy+ajsgwgZuyGA2GMIqTpcwL8Z52p8Q1hPQHY3EfMDpP1BYM3nuoZAOBechBGEaPQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(26005)(40460700003)(478600001)(83380400001)(66899024)(426003)(336012)(86362001)(82740400003)(7636003)(33716001)(356005)(47076005)(36860700001)(55016003)(5660300002)(9686003)(40480700001)(2906002)(4326008)(8676002)(6862004)(41300700001)(54906003)(6636002)(316002)(70206006)(70586007)(8936002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 18:39:20.7730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b8bfc2-777f-4e71-b606-08dbbdf6bb99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 02:57:08PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 01:52:03PM -0700, Nicolin Chen wrote:
> > If a master has only a default substream, it can skip CD/translation table
> > allocations when being attached to an IDENTITY domain, by simply setting
> > STE to the "bypass" mode (STE.Config[2:0] == 0b100).
> > 
> > If a master has multiple substreams, it will still need a CD table for the
> > non-default substreams when being attached to an IDENTITY domain, in which
> > case the STE.Config is set to the "stage-1 translate" mode while STE.S1DSS
> > field instead is set to the "bypass" mode (STE.S1DSS[1:0] == 0b01).
> > 
> > If a master is attached to a stage-2 domain, it does not need a CD table,
> > while the STE.Config is set to the "stage-2 translate" mode.
> > 
> > Add boolean bypass_ste and skip_cdtab flags in arm_smmu_attach_dev(), to
> > handle clearly the cases above, which also corrects the conditions at the
> > ats_enabled setting and arm_smmu_alloc_cd_tables() callback to cover the
> > second use case.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 ++++++++++++++++-----
> >  1 file changed, 27 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index df6409017127..dbe11997b4b9 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2381,6 +2381,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  	struct arm_smmu_device *smmu;
> >  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >  	struct arm_smmu_master *master;
> > +	bool byapss_ste, skip_cdtab;
> >  
> >  	if (!fwspec)
> >  		return -ENOENT;
> > @@ -2416,6 +2417,24 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  
> >  	master->domain = smmu_domain;
> >  
> > +	/*
> > +	 * When master attaches ARM_SMMU_DOMAIN_BYPASS to its single substream,
> > +	 * set STE.Config to "bypass" and skip a CD table allocation. Otherwise,
> > +	 * set STE.Config to "stage-1 translate" and allocate a CD table for its
> > +	 * multiple stage-1 substream support, unless with a stage-2 domain in
> > +	 * which case set STE.config to "stage-2 translate" and skip a CD table.
> > +	 */
> 
> It might be clearer like this:
> 
> static bool arm_smmu_domain_needs_cdtab(struct arm_smmu_domain *smmu_domain,
> 					struct arm_smmu_master *master)
> {
> 	switch (smmu_domain->stage) {
> 	/*
>          * The SMMU can support IOMMU_DOMAIN_IDENTITY either by programming
>          * STE.Config to 0b100 (bypass) or by configuring STE.Config to 0b101
>          * (S1 translate) and setting STE.S1DSS[1:0] to 0b01 "bypass". The
>          * latter requires allocating a CD table.
> 	 *
> 	 * The 0b100 config has the drawback that ATS and PASID cannot be used,
>          * however it could be higher performance. Select the "S1 translation"
>          * option if we might need those features.
> 	 */
> 	case ARM_SMMU_DOMAIN_BYPASS:
> 		return master->ssid_bits || arm_smmu_ats_supported(master);
> 	case ARM_SMMU_DOMAIN_S1:
> 	case ARM_SMMU_DOMAIN_NESTED:
> 		return true;
> 	case ARM_SMMU_DOMAIN_S2:
> 		return false;
> 	}
> 	return false;
> }
>
> Then the below is
> 
>        if (needs_cdtab || smm_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> 		master->ats_enabled = arm_smmu_ats_supported(master);
> 
> And the CD table should be sync'd to the result of arm_smmu_domain_needs_cdtab()..

Ack.

> It looks like there is still some kind of logic missing as we need to
> know if there are any PASIDs using the cd table here:
> 
> if (!master->cd_table_empty && !needs_cdtab)
>    return -EBUSY;
> 
> if (needs_ctab && !master->cd_table.cdtab)
>      ret = arm_smmu_alloc_cd_tables(master);
> 
> if (!needs_ctab && master->cd_table.cdtab)
>     arm_smmu_dealloc_cd_tables(master);
> 
> And add master->cd_table_emty to the arm_smmu_domain_needs_cdtab bypass logic.

OK. I will give it a try.

> Also, are these patches are out of order, this should come last since
> the arm_smmu_write_strtab_ent hasn't learned yet how to do
> STRTAB_STE_1_S1DSS_BYPASS?

Hmm. It could although it's a status quo IMHO -- in practical
only ARM_SMMU_DOMAIN_BYPASS would be changed by the 1st patch
to allocating a CD table that still doesn't work since this
STRTAB_STE_1_S1DSS_BYPASS is unset.

Thanks
Nic
