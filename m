Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22E07ADF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjIYSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjIYSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:36:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D6211E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwvOXMm5vjMSX7X+ZUJV4zpOS7Ja1I/WfZWI6V2gEew9kmDfTq7nTuj/ae1/O6HhrtaVxQAJO21YgCB/Yxua8IYXikOzp8DYKTfh7D784NkSiQxtE0Uxrpeuk3RulvWn/RncPfT49DW8H/7dA4eCDDQiAdhkTt2luAZUJXzy+RS48PiOpbrwk5hru927DSFzhWihzW4YVikmb35fyjrEcsLNdvyHvtUnifkr2R58noM51mE32BZYBDCO8v6qLsduuqzbNBedOrUubsHN3kLz+C5skX9hLVK0S1cZZVb6dGHnjdPyt5l5zujvDJ72ai45tUDDelRdjy3sl1k3JJhILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEOxq62bgI2lhrHjM4fnL5vIJAEBYGkH1TMeqqY/DfI=;
 b=dVrbRY6Z2AmhwblJofiyuR77WEt3rQ2vL5ScTx6nNvDrif7LWSG5EwhA0MObjZOqXjX8g01u4H6gcbfqoU4Ga98oJrm8YATbXK22BqzdVV4YLQl3E7kCUWyUPWnJlwTB4pWm/pvfU/KSbfHiDBgSENm2P4Qg9Wo/Nyycsk6zjL4z+m12KhfEUVQaLfdXWClwMTvE8HIB+VAZLwcrVooJjVQZdPHeCFM7wQMwFoMvOZgIfQJ0uID/KHV6feK8dxAaBYO+E4y9oDbf5bTo/v7pXXhE/SFNYQyeZD3To/XlPTp/B2H0cDZjozj/iiA6GscrBpxliKu65YA63NX4r97f5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEOxq62bgI2lhrHjM4fnL5vIJAEBYGkH1TMeqqY/DfI=;
 b=VmogJ0vrU65LoM11F41CrZ5H71yRw7t/nuCxlY8RhyTzi5o9OSl1HZIUbjHZx2M6Gws8i4feNvtBJ+Jtrc+LPuzjH4Ns5PdQ0bBJ0HRk/tU31x9PFO+6xX9bnuZAW586cIyPEdndgMvuzijUQjJ9t47JE19GLOpCMymD+i3KHxzwnb40ImHYvXyVRbr/5l9/G1zimFWIkLrFD3ucF0DrHj+Fdrx0GztdqMhi68GqEdkF7JbeU2LDxmqRMjYXaFuuHR04Oz7nREHfNNk4lrq9a1nW0AnkQlZehcfiJgHWhnUVLErnJMg8+cTH4FVR2r7i3M2Q6oJvBmzxfo06dUMPGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 18:35:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 18:35:24 +0000
Date:   Mon, 25 Sep 2023 15:35:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        jean-philippe@linaro.org, mshavit@google.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: Refactor
 arm_smmu_write_strtab_ent()
Message-ID: <20230925183523.GJ13733@nvidia.com>
References: <cover.1695242337.git.nicolinc@nvidia.com>
 <6e1fdea8ab43ea28e7e3c79eb6605dea71548c53.1695242337.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1fdea8ab43ea28e7e3c79eb6605dea71548c53.1695242337.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0371.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 45782ecf-a96a-4a3e-0182-08dbbdf62ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xo6x4x81XQuIN3KCCxACotY7OzXpzpGlzarfEFPwf75IMIjngyYkCwtKKKuk7BpNSj6IoLMqoVetaPCHc7SpzIsi8enKC40IBh4A9BmyzHQAon6ApyijGkmkXl0RiHhIo4r3Xgy3haY/1Gf+RN12FMPzBvGu2nsVx5pFkwLUGmFsuafsDgmfR4+8JXmmf3FT1UxKd15M1+KKYpIekciGkMuyRONlGKAbDTGC2YCAIoDVPBOsl/tPIfJLWxHYKTgDtjY2/EpX7tl1su0v28OiGZJJLWx1kFSQ/p0lu9TMmtUmitnm2vZp0yByzJ2LWx95zH+YoVpbuf6gTEhxp/twvtP9JRLysMaJvYaK9H9vc4qSibRob0tN5fV1IKzqOE5kEx7vtPiYARmF4wAkll9T0iwKFJLHRFDy3RbtkUMG+3fsg3dP6EctpOP7nM0UhG+3pPpD2VD7wgp8jEAnpGqExw0la6aOxXcuCkUEBkKK1skKhNqrltr84myDA765NDdgUw+a1w4WIh3LCd592eJWPVEEVa0eBimiiTKbJKf23dovkQllbyStJiBfnqkT+lLVj/uI5ae2A8KAaAUkxFs0UZvv+9z8gM4DI9ktbr3/WLXdudjc+rcQDVGiTkwC2enf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(316002)(86362001)(8676002)(8936002)(6636002)(4326008)(66556008)(41300700001)(66476007)(66946007)(5660300002)(6862004)(37006003)(83380400001)(38100700002)(478600001)(6506007)(2906002)(2616005)(6512007)(26005)(1076003)(6486002)(36756003)(33656002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o+ZiIwn2260ncGFdKmgEXP1cJ8pWBsER616CJFitkQ+Ry/bu+iVePg2CT0Mc?=
 =?us-ascii?Q?bChk0Qs0EpedfH0bUzltHy1VhPIVRXf9Uf+V2obva7Z0Q2m3cEAiapIsGwtJ?=
 =?us-ascii?Q?p4bv04nbHBrce0sueLW0kAZhhJ9kI3tnpV6phEBsImCiGIIBk2C7lSm0Wf2+?=
 =?us-ascii?Q?pXG1TAB0Gw7mqJti+GEqFBl08w6ng1lCLDhEuMf7tObbN6ZhmP6Wq4d1ZwTK?=
 =?us-ascii?Q?iVygkuH7RWe95WYYpg1Qdxsf+8YyxYVz6tNBvLye4fdU1lRkZz598PXV2K/P?=
 =?us-ascii?Q?HosxTZ+U6dVZKgNlLa4Li0T+3wLFOvSdCutcNwGMe38fJAMk0bNyt5egH28l?=
 =?us-ascii?Q?fnrfBQ5lvVqDDtrI3v7NzFwBsSa3ZpMSQBqax/FtoDwiqgxAib0tp56krmXV?=
 =?us-ascii?Q?t9ELxlxZsfVrP9hR0q7j6UfQdSfSodssOFHXEcsWGuI5F2WqeFM6hGawZz1V?=
 =?us-ascii?Q?uqzII9hKy2fEfiy13GcElxaEsCeaYMAI02DJE7prwYM5dZBzMfFbzRe9Xkac?=
 =?us-ascii?Q?w7DIOjP1T4km89aYZTxQm5BIbEl4NHyjK5VBTs92oSWTq0Bf1Hd0A30vxvzX?=
 =?us-ascii?Q?rsRizLmGU755w+oVWP4qhffjMrIHlbJvCTneTdgoF8xdbv8sMAWEM1rQTa2u?=
 =?us-ascii?Q?IbGKQGNuH8LrjsvXM9wBZ/vEuTUsQkmkTYMb1EPX5gOWZu0VkFQWHPQGXJ4d?=
 =?us-ascii?Q?ydV6tdKlJ7KUoqicJhkYkFdK1PwuIW/6lekbx1x+ZkmTEQ9RF5MAi0bl9bXl?=
 =?us-ascii?Q?nNkDLlu5CeROJ8sMPI+1VnNX1GnCLcQrUBACwzYymiKc34YMsGx7rwsb7Obd?=
 =?us-ascii?Q?Zg470r6RTP2OnikoqnsWdvOBvLmMUGGzGlJIgFfl9czLsqfWcRWTqHV0vEeM?=
 =?us-ascii?Q?zkbI4SfFqdfpVbHXAO9jZf3D9N3rOEfQiQ/IRqveAoqna4A2WbwMt8A55F+3?=
 =?us-ascii?Q?jEPUnkcwuCEV/LInKBl4tBYjM1W2vAswSwHCt8vJGlyc0svnem5nGZmWPqOo?=
 =?us-ascii?Q?mcLQrdYHNpwJ8u43bFy4EWYAhBZyIyO75xWqH9A5N+56DmwysyRAQ59Q0LgP?=
 =?us-ascii?Q?9GUx8MiqM3kjnxt9DvWO0uL85/+ytzoG8JTgHw6aWJViSh0xEo141d4g3icj?=
 =?us-ascii?Q?ohQKRS3UxH79uue+S8PUgCIxDIUp4lD0ah4LEzG/h5Xkaf2KLP651dK9CTAS?=
 =?us-ascii?Q?47BZjqrAZMdfSxSxE/+MRGv8gHgvH74cYpXIKDixhv+m/W7N2hXNKUGudrnA?=
 =?us-ascii?Q?Awiu0jUP3TTt+Ur7LI3XTa0mZQc58m4I7bFE7g4SZgwYWW2S/DBJkioIghVG?=
 =?us-ascii?Q?ComeRc8OV1i0gaazRh+cdHir+5ZvbccXPBKAhLDiUe06+zbD+DarMMO0V+ns?=
 =?us-ascii?Q?mSwb159VXMdEHLL6OYirjWHW5AoRlSNGM27Wx6P/bqPSRN68uNIJEzV4Gsa8?=
 =?us-ascii?Q?yImSawOa8J+wyrWCb8gJQkM51s2R912yzGwelfgq1HgJFAp+DXKAZZb3UvjT?=
 =?us-ascii?Q?fF4JVfxgVDTEmZhZzTTmpv5VztK4D46GHr+ipMVlMzW78PgX/4vO+7TP6jvT?=
 =?us-ascii?Q?x6E+LDXf9nB78P1+7UnofWFKsB9lLsnpb47GSj5I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45782ecf-a96a-4a3e-0182-08dbbdf62ebf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 18:35:24.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kvSaIau8tMJoiCLf8a342sN1/wBJFz68k9VKuoEEvH7Sk8PWVu0Jn84zYNIseA5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:52:04PM -0700, Nicolin Chen wrote:
>  
> +static void arm_smmu_ste_stage2_translate(struct arm_smmu_master *master,
> +					  u64 *ste)
> +{
> +	struct arm_smmu_domain *smmu_domain = master->domain;
> +	struct arm_smmu_device *smmu = master->smmu;
> +	struct arm_smmu_s2_cfg *s2_cfg;
> +
> +	switch (smmu_domain->stage) {
> +	case ARM_SMMU_DOMAIN_NESTED:
> +	case ARM_SMMU_DOMAIN_S2:
> +		s2_cfg = &smmu_domain->s2_cfg;
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return;
> +	}
> +
> +	ste[0] |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_STALLS && !master->stall_enabled)
> +		ste[1] |= STRTAB_STE_1_S1STALLD;
> +
> +	if (master->ats_enabled)
> +		ste[1] |= FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);

These master bits probably belong in their own function 'setup ste for master'

The s1 and s2 cases are duplicating these things.

> +
> +	ste[2] |= FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> +		  FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> +#ifdef __BIG_ENDIAN
> +		  STRTAB_STE_2_S2ENDI |
> +#endif
> +		  STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2R;
> +
> +	ste[3] |= s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK;
> +}
> +
> +static void arm_smmu_ste_stage1_translate(struct arm_smmu_master *master,
> +					  u64 *ste)
> +{

Lets stop calling the cdtable 'stage 1' please, it is confusing.

arm_smmu_ste_cdtable()

> +	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
> +	struct arm_smmu_device *smmu = master->smmu;
> +	__le64 *cdptr = arm_smmu_get_cd_ptr(master, 0);
> +
> +	WARN_ON_ONCE(!cdptr);
> +
> +	ste[0] |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> +		  FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> +		  FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
> +		  FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
> +
> +	if (FIELD_GET(CTXDESC_CD_0_ASID, le64_to_cpu(cdptr[0])))

Reading the CD like that seems like a hacky way to detect that the RID
domain is bypass, just do it directly:

if (master->domain->stage == ARM_SMMU_DOMAIN_BYPASS)
		ste[1] |= FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_BYPASS);
else
		ste[1] |= FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0);

> +	ste[1] |= FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING) |
> +		  FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> +		  FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> +		  FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_E2H)
> +		ste[1] |= FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_EL2);
> +	else
> +		ste[1] |= FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_NSEL1);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_STALLS && !master->stall_enabled)
> +		ste[1] |= STRTAB_STE_1_S1STALLD;
> +
> +	if (master->ats_enabled)
> +		ste[1] |= FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
> +
> +	if (master->domain->stage == ARM_SMMU_DOMAIN_NESTED)
> +		arm_smmu_ste_stage2_translate(master, ste);

I think this needs a comment

/*
 * SMMUv3 does not support using a S2 domain and a CD table for anything 
 * other than nesting where the S2 is the translation for the CD
 * table, and all associated S1s.
 */

> +	if (le64_to_cpu(dst[0]) & STRTAB_STE_0_V) {
> +		switch (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(dst[0]))) {
>  		case STRTAB_STE_0_CFG_BYPASS:
>  			break;
>  		case STRTAB_STE_0_CFG_S1_TRANS:

This thing could go into a function 'ste_is_live' too

> +	ste[0] = STRTAB_STE_0_V;
>  
> +	if (master->cd_table.cdtab && master->domain) {

I think the weirdness in arm_smmu_detach_dev() causes trouble here?
Despite the name the function is some sort of preperation to
attach_dev.

So if we change attachments while a cdtab is active we should not
remove the cdtab.

Basically, no master->domain check..

IMHO, I still don't like how this is structured. We have
arm_smmu_detach_dev() which really just wants to invalidate the STE.
Now that you shifted some of the logic to functions this might be
better overall:

static void arm_smmu_store_ste(struct arm_smmu_master *master,
				      __le64 *dst, u64 *src)
{
	bool ste_sync_all = false;

	for (i = 1; i < 4; i++) {
		if (dst[i] == cpu_to_le64(ste[i]))
			continue;
		dst[i] = cpu_to_le64(ste[i]);
		ste_sync_all = true;
	}

	if (ste_sync_all)
		arm_smmu_sync_ste_for_sid(smmu, sid);
	/* See comment in arm_smmu_write_ctx_desc() */
	WRITE_ONCE(dst[0], cpu_to_le64(ste[0]));
	arm_smmu_sync_ste_for_sid(smmu, sid);
}

static void arm_smmu_clear_strtab_ent(struct arm_smmu_master *master,
				      __le64 *dst)
{
	u64 ste[4] = {};

	ste[0] = STRTAB_STE_0_V;
	if (disable_bypass)
		arm_smmu_ste_abort(ste);
	else
		arm_smmu_ste_bypass(ste);
	arm_smmu_store_ste(master, dst, &ste);
}

And use clear_strtab_ent from detach ??

(but then I wonder why not set V=0 instead of STE.Config = abort?)

> +		arm_smmu_ste_stage1_translate(master, ste);
> +	} else if (master->domain &&
> +		   master->domain->stage == ARM_SMMU_DOMAIN_S2) {
>  		BUG_ON(ste_live);
> +		arm_smmu_ste_stage2_translate(master, ste);

This whole bit looks nicer as one if

} else if (master->domain) {
       	   if (master->domain->stage == ARM_SMMU_DOMAIN_S2)
		arm_smmu_ste_stage2_translate(master, ste);
	   else if (master->domain->domain.type == IOMMU_DOMAIN_IDENTITY)
		arm_smmu_ste_bypass(ste);
	   else
		BUG_ON()
} else {
    // Ugh, removing this case requires more work
}

(Linus will not like the bug_on's btw, the function really should
fail)

> +	for (i = 1; i < 4; i++) {
> +		if (dst[i] == cpu_to_le64(ste[i]))
> +			continue;
> +		dst[i] = cpu_to_le64(ste[i]);
> +		ste_sync_all = true;
> +	}

This isn't going to work if the transition is from a fully valid STE
to an invalid one, it will corrupt the still in-use bytes.

Though current code does this:

		dst[0] = cpu_to_le64(val);
		dst[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
						STRTAB_STE_1_SHCFG_INCOMING));
		dst[2] = 0; /* Nuke the VMID */

Which I don't really understand either? Why is it OK to wipe the VMID
out of order with the STE.Config change?

Be sure to read the part of the SMMU spec talking about how to update
these things, 3.21.3.1 Configuration structure update procedure and
nearby.

Regardless there are clearly two orders in the existing code

Write 0,1,2,flush (translation -> bypass/fault)

Write 3,2,1,flush,0,flush (bypass/fault -> translation)

You still have to preserve both behaviors.

(interestingly neither seem to follow the guidance of the ARM manual,
so huh)

Still, I think this should be able to become more robust in general..
You have a current and target STE and you just need to figure out what
order to write the bits and if a V=0 transition is needed.

The bigger question is does this have to be more generic to handle
S1DSS which is it's original design goal?

Jason
