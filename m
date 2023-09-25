Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC88C7AE02F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjIYUDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjIYUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:03:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321510E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPVYfS0uSWnoj5jRG2NTY3bGbN8/AxZiivcIK7uraVfwA9DqGVMKqEO3mUBTO/kt3WO8PcoPqdN1o8bS7gV0j2+wcOy7BoPZ4xBbkc/ChOUvKMB9yDJLo/0gGomefLlCUOebFrNuzEmvf7swC/JArDEf1H5zht8l6tBIQ5TRiqAgRGe7vtBhiDgk6RlXO+JsZH8mQQ6KAurQLRsxi0JzJgScMIS8v+LSs7VukiXpRbJJ+A/k+WtP1DQN7aoFrDIX+X+6aGt5zYk6qfPRMAXMMH6uR7Ob8ok23k6Jt6UPFucWrtH/eXLm0GgTW3bgslOLiCVipeFg5888oHIpbbWr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZZ9gWwKbIm7G8RsYRqlGu7o7d9xCqIqANrJMfztySo=;
 b=foD9w9nd1JWVpcUB+D7plzTYA7iL38okPiX1nrMNXee1HHeDVP8m8sbP7PAM4sApa3dAfF3bYnOyrMWPzRHdmVlwtPVYRKWm+QWdckYY5qel1XNK+4j3j68Uw2DoCePS6aSxcl0/0sj3md95CCPwUJKRbP9vW72bK1++XdEKkhuuPaXvI1Chur7WC0SjMhFq4jqgCy1RAYY/FcsPXPu0qoaouYCy6akjX7Gbk3mnL+bxEmDJBiypcapq5uSoTPrGySN4PwEaewBS+YP9+mBxYNdZBCqryQMYjEFtwsSMgwaKWMyLeEk6bA8KgvyPc9PIHoDseBV58FCWKnBa2w6jAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZZ9gWwKbIm7G8RsYRqlGu7o7d9xCqIqANrJMfztySo=;
 b=NtbAxZln1FvPFYxrkI7ajdKaZklqZmWUxgPU5PJNOQq+vkeVKVz84zBifO+NTbv6dA556uThwua25zsT9uOElqbE42x07DmCZa1GaTOve/RHQYl4IpRzfYJXbxJd03udtYf01RaRNhLa60yT8HCOmpsgWfuRnzwYEoO1SgasyHb/gf8dx+njE6JJym2zHWKm0OFxFSXVLJ6588UXJS7lYq/tQPV6UPIzHN3+PF1kwg3qJACLHcPQ0r/JY15QLabx1SuA88cWQKJCs8uyHEWzCc3VxCw20iwGjl9wv6QqQwOr05VXRrltlbHgtUE0yeqZc7OcGMxFrZuq+iYcB9ckgQ==
Received: from BL1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:256::32)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:03:31 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::8d) by BL1PR13CA0027.outlook.office365.com
 (2603:10b6:208:256::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Mon, 25 Sep 2023 20:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 20:03:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 13:03:14 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 13:03:12 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 25 Sep 2023 13:03:11 -0700
Date:   Mon, 25 Sep 2023 13:03:10 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <mshavit@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: Refactor
 arm_smmu_write_strtab_ent()
Message-ID: <ZRHnfq6mzDz5zTLC@Asurada-Nvidia>
References: <cover.1695242337.git.nicolinc@nvidia.com>
 <6e1fdea8ab43ea28e7e3c79eb6605dea71548c53.1695242337.git.nicolinc@nvidia.com>
 <20230925183523.GJ13733@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925183523.GJ13733@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 277e168a-b3a5-4588-a58a-08dbbe027dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hIVnCBfcx711njvH+mhusgUV1RjMwLSCDQJvyj2ezUxGMXMae0NaX0yNaCuUA6i71DtBll1+j+qiKNsbiaKMOyN6VfUIFwld7vN5dAfm11I31yIiav6VstAR89qc7Mx5qw4VsNx3bueuNTR9rRIw9Jsavlk9oOcyiGXv2IPeteX54os/sEZwfrY/ilZYYBO2ZP8A/ujAFLorB092xFCU4maPqs5DjZrVVufqHSXAL7lyY9ZA0yM/Xdrekk5g4XxgtLmtmb+wsMmXM7wqmBeMzt0LLlgZ7va38tI76H29Yzbar/W4J/8mwd65cOQs9HPjErLcfIGs0iGowNhZvJWAoty4Mhc+tUOuDocqzT8Jypv/GWJANHS3ivpw+sk8MkdiypAr6QKhr6cRGLZwfc1hw2Mw8Ldqf0QIrI4lxeFNSkiGZw9ePFHdLdCTiwnWpnqvW6j7vW+c+SquLRPVqBhWPBQBGclEPXcdc0qec7gFrd9d6mIinWJBIFn4xBjQQLmGcuCCvsxjtvcoZ/bSKR3TnoEmzTGw95nFxqFDemMQy7TdbG9GybG6972Ud6sPUXEL0J9PtOKGH+a9CG0iFgZQqiOKUtM2LQSSTND1I1ZlD9OgmqZbzqEF3avYFajRHo0rWF8MkHyXqehYDlsnMkOFErt9bn5nIjCeiuuwmvi+b/QhXKTwXrn6i+xNdfS0dN/ZLMjB2dGzLiRDlD+alDHd0hN9DyEe9a8juWt3Hygigpuc8sx5L/4nnuRgzm9j7Y8DTVLvk5Q3x6vKvLU8WvAOQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(70206006)(54906003)(70586007)(478600001)(33716001)(9686003)(26005)(336012)(426003)(8936002)(8676002)(4326008)(316002)(6636002)(6862004)(40460700003)(41300700001)(83380400001)(82740400003)(86362001)(7636003)(356005)(55016003)(40480700001)(47076005)(36860700001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:03:30.8860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 277e168a-b3a5-4588-a58a-08dbbe027dac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:35:23PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 01:52:04PM -0700, Nicolin Chen wrote:
> >  
> > +static void arm_smmu_ste_stage2_translate(struct arm_smmu_master *master,
> > +					  u64 *ste)
> > +{
> > +	struct arm_smmu_domain *smmu_domain = master->domain;
> > +	struct arm_smmu_device *smmu = master->smmu;
> > +	struct arm_smmu_s2_cfg *s2_cfg;
> > +
> > +	switch (smmu_domain->stage) {
> > +	case ARM_SMMU_DOMAIN_NESTED:
> > +	case ARM_SMMU_DOMAIN_S2:
> > +		s2_cfg = &smmu_domain->s2_cfg;
> > +		break;
> > +	default:
> > +		WARN_ON(1);
> > +		return;
> > +	}
> > +
> > +	ste[0] |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
> > +
> > +	if (smmu->features & ARM_SMMU_FEAT_STALLS && !master->stall_enabled)
> > +		ste[1] |= STRTAB_STE_1_S1STALLD;
> > +
> > +	if (master->ats_enabled)
> > +		ste[1] |= FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
> 
> These master bits probably belong in their own function 'setup ste for master'
> 
> The s1 and s2 cases are duplicating these things.

OK. I thought that writing these helpers in form of STE.Config
field configurations could be more straightforward despite some
duplications.

> > +
> > +	ste[2] |= FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> > +		  FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> > +#ifdef __BIG_ENDIAN
> > +		  STRTAB_STE_2_S2ENDI |
> > +#endif
> > +		  STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2R;
> > +
> > +	ste[3] |= s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK;
> > +}
> > +
> > +static void arm_smmu_ste_stage1_translate(struct arm_smmu_master *master,
> > +					  u64 *ste)
> > +{
> 
> Lets stop calling the cdtable 'stage 1' please, it is confusing.
> 
> arm_smmu_ste_cdtable()

Well, this follows the STE.Config field value namings in the
spec. I can change if you don't like the terms in the spec..

> > +	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
> > +	struct arm_smmu_device *smmu = master->smmu;
> > +	__le64 *cdptr = arm_smmu_get_cd_ptr(master, 0);
> > +
> > +	WARN_ON_ONCE(!cdptr);
> > +
> > +	ste[0] |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > +		  FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > +		  FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
> > +		  FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
> > +
> > +	if (FIELD_GET(CTXDESC_CD_0_ASID, le64_to_cpu(cdptr[0])))
> 
> Reading the CD like that seems like a hacky way to detect that the RID
> domain is bypass, just do it directly:
> 
> if (master->domain->stage == ARM_SMMU_DOMAIN_BYPASS)
> 		ste[1] |= FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_BYPASS);
> else
> 		ste[1] |= FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0);

OK, that'd make this function depend on "domain" also v.s. on
cd_table alone though.

> > +	ste[1] |= FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING) |
> > +		  FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > +		  FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > +		  FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
> > +
> > +	if (smmu->features & ARM_SMMU_FEAT_E2H)
> > +		ste[1] |= FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_EL2);
> > +	else
> > +		ste[1] |= FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_NSEL1);
> > +
> > +	if (smmu->features & ARM_SMMU_FEAT_STALLS && !master->stall_enabled)
> > +		ste[1] |= STRTAB_STE_1_S1STALLD;
> > +
> > +	if (master->ats_enabled)
> > +		ste[1] |= FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
> > +
> > +	if (master->domain->stage == ARM_SMMU_DOMAIN_NESTED)
> > +		arm_smmu_ste_stage2_translate(master, ste);
> 
> I think this needs a comment
> 
> /*
>  * SMMUv3 does not support using a S2 domain and a CD table for anything 
>  * other than nesting where the S2 is the translation for the CD
>  * table, and all associated S1s.
>  */

OK.

> > +	if (le64_to_cpu(dst[0]) & STRTAB_STE_0_V) {
> > +		switch (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(dst[0]))) {
> >  		case STRTAB_STE_0_CFG_BYPASS:
> >  			break;
> >  		case STRTAB_STE_0_CFG_S1_TRANS:
> 
> This thing could go into a function 'ste_is_live' too

Ack.

> > +	ste[0] = STRTAB_STE_0_V;
> >  
> > +	if (master->cd_table.cdtab && master->domain) {
> 
> I think the weirdness in arm_smmu_detach_dev() causes trouble here?
> Despite the name the function is some sort of preperation to
> attach_dev.

Yea.

> So if we change attachments while a cdtab is active we should not
> remove the cdtab.
> 
> Basically, no master->domain check..

OK. Got your point.

> IMHO, I still don't like how this is structured. We have
> arm_smmu_detach_dev() which really just wants to invalidate the STE.
> Now that you shifted some of the logic to functions this might be
> better overall:
> 
> static void arm_smmu_store_ste(struct arm_smmu_master *master,
> 				      __le64 *dst, u64 *src)
> {
> 	bool ste_sync_all = false;
> 
> 	for (i = 1; i < 4; i++) {
> 		if (dst[i] == cpu_to_le64(ste[i]))
> 			continue;
> 		dst[i] = cpu_to_le64(ste[i]);
> 		ste_sync_all = true;
> 	}
> 
> 	if (ste_sync_all)
> 		arm_smmu_sync_ste_for_sid(smmu, sid);
> 	/* See comment in arm_smmu_write_ctx_desc() */
> 	WRITE_ONCE(dst[0], cpu_to_le64(ste[0]));
> 	arm_smmu_sync_ste_for_sid(smmu, sid);
> }
> 
> static void arm_smmu_clear_strtab_ent(struct arm_smmu_master *master,
> 				      __le64 *dst)
> {
> 	u64 ste[4] = {};
> 
> 	ste[0] = STRTAB_STE_0_V;
> 	if (disable_bypass)
> 		arm_smmu_ste_abort(ste);
> 	else
> 		arm_smmu_ste_bypass(ste);
> 	arm_smmu_store_ste(master, dst, &ste);
> }
> 
> And use clear_strtab_ent from detach ??

We still need bypass() in arm_smmu_write_strtab_ent(). But this
removes the abort() call and its confusing if-condition, I see.

> (but then I wonder why not set V=0 instead of STE.Config = abort?)

It seems that the difference is whether there would be or not a
C_BAD_STE event, i.e. "STE.Config = abort" is a silent way for
a disabled/disconnected device.

> > +		arm_smmu_ste_stage1_translate(master, ste);
> > +	} else if (master->domain &&
> > +		   master->domain->stage == ARM_SMMU_DOMAIN_S2) {
> >  		BUG_ON(ste_live);
> > +		arm_smmu_ste_stage2_translate(master, ste);
> 
> This whole bit looks nicer as one if
> 
> } else if (master->domain) {
>        	   if (master->domain->stage == ARM_SMMU_DOMAIN_S2)
> 		arm_smmu_ste_stage2_translate(master, ste);
> 	   else if (master->domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> 		arm_smmu_ste_bypass(ste);
> 	   else
> 		BUG_ON()
> } else {
>     // Ugh, removing this case requires more work
> }
> 
> (Linus will not like the bug_on's btw, the function really should
> fail)

OK. Let me try that one (and removing BUG_ON).

> > +	for (i = 1; i < 4; i++) {
> > +		if (dst[i] == cpu_to_le64(ste[i]))
> > +			continue;
> > +		dst[i] = cpu_to_le64(ste[i]);
> > +		ste_sync_all = true;
> > +	}
> 
> This isn't going to work if the transition is from a fully valid STE
> to an invalid one, it will corrupt the still in-use bytes.

The driver currently doesn't have a case of unsetting STE_0_V?

> Though current code does this:
> 
> 		dst[0] = cpu_to_le64(val);
> 		dst[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
> 						STRTAB_STE_1_SHCFG_INCOMING));
> 		dst[2] = 0; /* Nuke the VMID */
> 
> Which I don't really understand either? Why is it OK to wipe the VMID
> out of order with the STE.Config change?
> 
> Be sure to read the part of the SMMU spec talking about how to update
> these things, 3.21.3.1 Configuration structure update procedure and
> nearby.
> 
> Regardless there are clearly two orders in the existing code
> 
> Write 0,1,2,flush (translation -> bypass/fault)
> 
> Write 3,2,1,flush,0,flush (bypass/fault -> translation)
> 
> You still have to preserve both behaviors.
> 
> (interestingly neither seem to follow the guidance of the ARM manual,
> so huh)

Again, it is probably because the driver never reverts the V
bit back to 0? While chapter 3.21.3.1 is about V=0 <=> V=1.

> Still, I think this should be able to become more robust in general..
> You have a current and target STE and you just need to figure out what
> order to write the bits and if a V=0 transition is needed.
> 
> The bigger question is does this have to be more generic to handle
> S1DSS which is it's original design goal?

It feels an overkill. Maybe "Refactor arm_smmu_write_strtab_ent()"
is just a too big topic for my goal...

Overall, this version doesn't really dramatically change any STE
configuration flow compared to what the current driver does, but
only adds the S1DSS bypass setting. I'd prefer keeping this in a
smaller scope..

Thanks
Nic
