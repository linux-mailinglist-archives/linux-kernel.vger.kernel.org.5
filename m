Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7677FAA1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353167AbjHQPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353163AbjHQPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:20:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E7B2D6D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV1ubuNnyDQqDPje6eUdamxD8xgNiEu8FSpQN1rcF/BADJov291jBsvC5X/EkZi7nSXSh5Zgxo2xU2LXdAnAeWDoFstiEOgJn0Wr8CiKd55WMRyTMfzp88/A/OtCbEb+jNblfNfQ2IIbdvNEyRd8wujezQO4IOsmymN3aYuRVfHKo33qUnIuoT7XAilO7mtqB7Ev2iXIjDxC8xdZY34TsPh0jOG+QEvbXyFkhQc2klAupRXDK+yDcQjN0+UntD6gwNUlN1Ptm60Ihgd7PAHhg5fhFX5EB8kqmwD0iWcGAeQKKNf4Dhhdqd2zmT29mqpf3MVC69zESHcGaX4HbyMYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95CtRlUdMiNrG0mYPXfO8WUQDqCZIxCTI5gIgu5eNlM=;
 b=gbDu68bTCS+YdmPg9kLGlSxBjNPKwHeZMWdqVekAgMDs0yfJcZ03o1mToUu5ZpIb0pqIkL3o0EQPRFxyI4H8pUTppku/60smpP2EubTNuCGc2MJ9otLKk6K33V6bMca4Rt2AZvgtitzoIQC8HpbK1KFyPzbXu5GCGpyHdUIWFL1ClW/bfGclLOPCdakc1NpHpklzQY5z8tiNH6qf4NixGS9e6o66Hul8PlL0aS7Sgy2aIbN/auXChD46jy10P90IcSf4vfvmLfBgeS5SJypz/5i4ha9kmA//ZGgBkin2FDA41MOLJ0SL4+4PSBvMfrFviJsIeAPYzxdh1QxpP6VsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95CtRlUdMiNrG0mYPXfO8WUQDqCZIxCTI5gIgu5eNlM=;
 b=Xu9rld7/UBGVcHMgOJQSKHvFui2jm1W226zSlet+bQJoXhe+wqDDPIBcb8wGYJLbo7cK4AeccvVVMz+VvffdOHOT5vP0p1Iml0Y2AMaENNb4Hce2xEQhwTRTO83iOMrs3VbpuYj8/g6CZc4klBnHJ83oo3CT1lVGdkzX9ct1xHGbqy0pWKgDqzEhpfI53eLlTXFTbnrQtteZk7wdkz+I+HgeqFF+rFidxU5OYnSklr03B+L16mIWFDydMHgPNSEAWYQxrVSRfjzxlF+K82EohjdFBBWGLpD9VQYygoSEnAK2pAiI34bMscCL7ODnKX3pVze+VB194xxfc1nLbeiDtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 15:20:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:20:27 +0000
Date:   Thu, 17 Aug 2023 12:20:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        mshavit@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZN46upjIBFcI4mL+@nvidia.com>
References: <20230817042135.32822-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817042135.32822-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: deba0c73-dcac-45fd-b1b5-08db9f357c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFdLtlrn2PN5QL2DJe9tZUUmivo+p4ruE98mGp3w+tTTw3gz3FOb5u1woYW/Vx9akIo4f31iRG7/G37Jb9bxtUVVBeA306lDFKuMnDb9cpyFl9JCYJ2XhZSRIN2YSKC2uehOmmnrKu3TzxjJ8fu3NtSJ2HROBoK5H1zKfEUxXGfPlb81leWyxxsRpeUBwMQ+LE73JamsyxUd6D5Kp2eJWSNaf6APWbRVWc8GPa7WbHZOkvxIRqavL44kiQdd/l746zOkIQWqBmkssLNsjlWcrrzrMFGwgUmsFejszqsPTvZfFAA5CuMlw1LNP+eqA1kP5cC1dyqOv/45PegxygJnZG6wROYRUhNUh2RVjhOjW38JnC5kR6D6qpVM8nQReWpGR9KzfEUKaPEKJOCW98efzbzCNsNRMFfbzy2QcH7hpJwroif5GiNfR7TnRpvPM9a3WCCgxgm1djarXItsQXFuYAIied0gISv9ujL7R3Kn9+RgdNiAtKARYw14Txst3+79VfeF6IE3Qczk0EkcJNh9AeZp8ASvOoHPvihk8AWi+BLJKZTDaDXWS4c3Z61hN85H81c5nKWOUIRSc6lbzb3v13DGvyoiqgV06cclAuk5/IBLXcTJxXpmaxGlflKu9ZKdfmT9mmKu+M2HXUxvbM94GrGdFLklyGt/KrYr6ojUEKWr1HN4y80Rr4UlQ6uXoWis7S5FdbT4QKxjix7W/97FNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(186009)(451199024)(1800799009)(66476007)(66946007)(66556008)(5660300002)(2616005)(37006003)(6636002)(2906002)(316002)(41300700001)(478600001)(966005)(6862004)(8676002)(4326008)(8936002)(6512007)(6486002)(6506007)(36756003)(83380400001)(38100700002)(26005)(86362001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y41La3Qx02pkaHIZ2tLsFtXF+BalZ2vyYsuTKelRQXhQifqgDYDYlRAzmop6?=
 =?us-ascii?Q?cCz2LL/PHRF2WR8EwDV+ifRINK1imlykimBQWUxvNPDvdgDnWJTEJtKEZJDq?=
 =?us-ascii?Q?DQEI1ckd0R2zI7BpyOxNsA+ml5zAnbmzOdy04kx2o6SYqQ7crgfLNaf8XCux?=
 =?us-ascii?Q?aYSDGFYZgYchn5oQ/ztJF8QJ7AOhP2P6svZtOeKrsiD9vHSNVwvQXHr9x3ie?=
 =?us-ascii?Q?m2crCqbHR7hIB1BNH7OqU5Oe9VQK4ZqRXjsbjmrVeNpl0BCtXIPnWlhl0Da9?=
 =?us-ascii?Q?FctSlrHloLWBWQiKpSjZ4e8wcyP8Nh+c0JdbJQFEZpfWSolwcNddVzcpNowB?=
 =?us-ascii?Q?SU6RvxG+X9OIPBvFXYQWlcnIhsnkhlfGhjEpldcfWx/He3nxRapuA16215RR?=
 =?us-ascii?Q?gL23lmWhBUmQG9YGYfGflj5ilT4UCxr98TY89alkf4nSCJ/wST5TKEPr28/F?=
 =?us-ascii?Q?sLyZh6FpGiv2956jN0HciavD9l32e2fSg91XnghofpYgygOFzXUMbEY7u9CT?=
 =?us-ascii?Q?nZ9KHWG7MchRvRYavH4H0Fmpc14OC989FRSq8utsMHxKnVNR2Wy7Di8wkJLH?=
 =?us-ascii?Q?fT0KL35cEZg79wZRAgNoA+dUv6pSYc0ov57zbGfNk37PVG5B0qmmSZR5ttpO?=
 =?us-ascii?Q?JGnTAm8Qy6Q05q3SrUTlmceIRL8YL8ROQ6oePB8E5Tg9ztHKuWW9hxIsVyxY?=
 =?us-ascii?Q?8sKg0EHG7Y5sNeASv3Sru9O9YVdoyt8SDVUUHEfj6oKou48x9L8EkbcPmEJ/?=
 =?us-ascii?Q?E3uoeIKRIQkzqWhTa6QsjSwcPkHeS+wtlJwrNR08NOd/dVFlfOT5Y2q+LvmI?=
 =?us-ascii?Q?BW9IImVUc8J1ddsWCgR/gRrWfm4oozKjj63SM4ZCTBP4oXnybhWtli3C3TG2?=
 =?us-ascii?Q?pbnJWSobRL+w5hroc6hypmxNH/i+OHMYGUZHDgQV6TGoc1aSWieHtbZanNd3?=
 =?us-ascii?Q?fRnm1jaTcc8mV1ypa8mShf+U+XxAWLUX+1d2ZvXwTn78KOm6dz91gc36RgmA?=
 =?us-ascii?Q?typ+XI+9zauqAgFQoLAaw2+/mpEUw1k7IlvErzy11z3ivc5nLfq4iXGy+IW+?=
 =?us-ascii?Q?kazqH2gCwHIJUm9QZ65CLcg9QnXylVQWH9W/bAt0OGG86pElNVX9tlvPT5vr?=
 =?us-ascii?Q?ro8pN4YXzMnCpF+s1j8R1IXsISb+iw3irfyZEsJh177VtaziyLNHlWQEUexf?=
 =?us-ascii?Q?7u4z02VZREtBnoft2Ad+C+aMioDxdTpxjIkZXpjyoiG14A/6X2DypkSvTEqp?=
 =?us-ascii?Q?A7iteEoiXgwQkw+4TaBT9aSAFEkE3gx/OfkJPNdoOiT+MdOAmbYRytSX7lKi?=
 =?us-ascii?Q?fy1clU6hvlrY+md8pYrmJYSQaHC4VvhSp4krDfbwILA08dJlx65+Xeo63ggc?=
 =?us-ascii?Q?JeuigUWd6ukafKNv/4fU4iv/xG6AY6My0p/WFZT2c0KegUNShTi48I1IOOlv?=
 =?us-ascii?Q?Nlj+H+QI/RbvJsaTL1vMCEDfYeuXJ07Dw3bcZhLPLx/R7+k6PUAdYP0U4ILp?=
 =?us-ascii?Q?Bz6+/oLYPJGfV9zlkBKvnGW0wJH2wnaHONuSEfnAHzYgWxgc/5oDIKyHrDPA?=
 =?us-ascii?Q?E0Z0lgaUTk0PNw36+3LL+jhTkxLTb2UoJDYxMy4u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deba0c73-dcac-45fd-b1b5-08db9f357c82
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:20:27.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5OXdbs1BsLeC21C6wx7UpAE4OmDxY6Gne9RUX7bCZme7TvayNv9m+M36lXMnZjL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:21:35PM -0700, Nicolin Chen wrote:
> When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver sets the
> arm_smmu_domain->stage to ARM_SMMU_DOMAIN_BYPASS and skips the allocation
> of a CD table, and then sets STRTAB_STE_0_CFG_BYPASS to the CONFIG field
> of the STE. This works well for devices that only have one substream, i.e.
> pasid disabled.
> 
> With a pasid-capable device, however, there could be a use case where it
> allows an IDENTITY domain attachment without disabling its pasid feature.
> This requires the driver to allocate a multi-entry CD table to attach the
> IDENTITY domain to its default substream and to configure the S1DSS filed
> of the STE to STRTAB_STE_1_S1DSS_BYPASS. So, there is a missing link here
> between the STE setup and an IDENTITY domain attachment.
> 
> Add a new stage ARM_SMMU_DOMAIN_BYPASS_S1DSS to tag this configuration by
> overriding the ARM_SMMU_DOMAIN_BYPASS if the device has pasid capability.
> This new tag will allow the driver allocating a CD table yet skipping an
> CD insertion from the IDENTITY domain, and setting up the STE accordingly.
> 
> In a use case of ARM_SMMU_DOMAIN_BYPASS_S1DSS, the SHCFG field of the STE
> should be set to STRTAB_STE_1_SHCFG_INCOMING. In other cases of having a
> CD table, the shareability comes from a CD, not the SHCFG field: according
> to "13.5 Summary of attribute/permission configuration fields" in the spec
> the SHCFG field value is irrelevant. So, always configure the SHCFG field
> of the STE to STRTAB_STE_1_SHCFG_INCOMING when a CD table is present, for
> simplification.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> 
> Changelog
> v2:
>  * Rebased on top of Michael's series reworking CD table ownership:
>    https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/
>  * Added a new ARM_SMMU_DOMAIN_BYPASS_S1DSS stage to tag the use case
> v1: https://lore.kernel.org/all/20230627033326.5236-1-nicolinc@nvidia.com/

After rebasing there really shouldn't be a
ARM_SMMU_DOMAIN_BYPASS_S1DSS. I want to get to a model where the
identity domain is a global static, so it can't be changing depending
on how it is attched.

I continue to think that the right way to think about this is to have
the CD table code generate the STE it wants and when doing so it will
inspect what SSID0 is. If it is the IDENTITY domain then it fills
s1dss / etc

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b27011b2bec9..860db4fbb995 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1271,6 +1271,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	 * 3. Update Config, sync
>  	 */
>  	u64 val = le64_to_cpu(dst[0]);
> +	u8 s1dss = STRTAB_STE_1_S1DSS_SSID0;
>  	bool ste_live = false;
>  	struct arm_smmu_device *smmu = NULL;
>  	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
> @@ -1290,6 +1291,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  
>  	if (smmu_domain) {
>  		switch (smmu_domain->stage) {
> +		case ARM_SMMU_DOMAIN_BYPASS_S1DSS:
> +			s1dss = STRTAB_STE_1_S1DSS_BYPASS;
> +			fallthrough;
>  		case ARM_SMMU_DOMAIN_S1:
>  			cd_table = &master->cd_table;
>  			break;

Eg, I think the code looks much nicer if the logic here is more like:

if (master->cd_table.cdtab) 
   arm_smmu_cd_table_get_ste(master->cd_table, &ste)
else if (master->domain)
   arm_smmu_domain_get_ste(master->domain, &ste);
else
   ste = not attached

And you'd check in arm_smmu_cd_table_get_ste() to learn the CD
parameters and also what SSID=0 is. If SSID=0 is IDENTITY then
arm_smmu_cd_table_get_ste would return with S1DSS set.

arm_smmu_domain_get_ste() would multiplex based on the domain type.

> @@ -2435,6 +2440,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	} else if (smmu_domain->smmu != smmu)
>  		ret = -EINVAL;
>  
> +	/*
> +	 * When attaching an IDENTITY domain to a master with pasid capability,
> +	 * the master can still enable SVA feature by allocating a multi-entry
> +	 * CD table and attaching the IDENTITY domain to its default substream
> +	 * that alone can be byassed using the S1DSS field of the STE.
> +	 */
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS && master->ssid_bits &&
> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S1)
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS_S1DSS;

Then you don't technically need to do this.

Though if we can't atomically change the STE from IDENTITY to IDENTIY
with a CD then you still have to do something here, but really what we
want is to force a CD table for all cases if PASID is enabled, and
force DMA domains to be S2 domains as well.

>  	mutex_unlock(&smmu_domain->init_mutex);
>  	if (ret)
>  		return ret;
> @@ -2456,7 +2471,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	list_add(&master->domain_head, &smmu_domain->devices);
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ||
> +	    smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS_S1DSS) {
>  		if (!master->cd_table.cdtab) {
>  			ret = arm_smmu_alloc_cd_tables(master);
>  			if (ret) {

So more like:

 if (smmu_domain == IDENTIY && arm_smmu_support_ssid(dev))
     arm_smmu_alloc_cd_tables()

Jason
