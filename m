Return-Path: <linux-kernel+bounces-164620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38648B8035
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B966284C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506A5194C77;
	Tue, 30 Apr 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJbjC1Vj"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214917BB1E;
	Tue, 30 Apr 2024 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503544; cv=fail; b=C/sWdBMyMnidtS+J9NydZVGZZjN3JYS4MgcP2VRtEBUo3BG6xQtX1N2Z2s2KNwBCYyuGgPt/05bnDQZiKoYpag3a0hIIQEl2JVZi/KXOv17MVBTa3Vc+6TFTNEUmqVzDy4pP0Nyog1n35hWgYpjMtxNPIMO72bOwgkTAJhjjLes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503544; c=relaxed/simple;
	bh=N/yfGO9fGm9Z2bf1doGNWD8rDkI83fskKPINOGXbEwg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPRPiVO5ggzDwlRin7PHRLVvLMGAoxUWlPEttQpB1h5F56WRAiOtuSh69DCNqiJZQn62LGFo+t7SthRUvTJ95bp1ZUWApZqYVVcXDuGjq2Dq3RjHaOB38PtRTZwAeemmznM64BrZ36yXr9k50/U5ySYIVSYEa9Vnz+LO4H5qu3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJbjC1Vj; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwL9sd6HpsXqLUSWX3QPJChMEDbyUZg4gCFlip73BRMEHKxVUHmahGgIYnmvKdVAsD4bSqhVubwu3bB7YR77ZjO+qV51p7f98ySwN0zRaOC68Zl+79FN17ah1pVogy2scfi4aWiuteWVWAAJoqU1Hhgo0ah8zwxDsxY9tWsqg1Tvv2Lh/kiCjkKES+D2l2zbv9S1HvwvG0rnyRvRvaEP6R4wuN6ivT86/4DeAIPb6YiRXNpEKvCTzhJ3e1/NXoFhwfUszVX1PlbEMgSXMzch6hoiC5iT1Wjx9TfLi0kvtdrXOdbZ1Uu5LOqzXtb/cA25GHyzZTrpn5Px36fYTXgrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2vIGrngMlHz4Y7lX4nOfuSs7om1dy9RmHVpVFxRG+k=;
 b=C4/2EtMWpAj1qCctxYmtY4ejD0UAEvfey9yKiKH2fVM6akd2lvUwGia5cG9dZTiDGCwS5Kr9bJX622C4gOl4SCzyVVyI8U0eJc/YNqs8uuYJUub9Zd9EOwlAfN2LbGalGnLeCj3pzAJO3lIOncAWwoNmSwPU7rgJKmrfzePfCt9NpIDMK8RdVG09LviRe4cg5tBW7s5ML22/f3y0TOCWz+Trc9No7Tsz7SBD2YeaNh/8sXxlSCfnKVA75IDHmzEfYgrPNysAPjd1PunGaKyf6t3kvjG9mUFDrE1vgsJ/YGsEFq/gXra0NcwT7fZILYxKdjOImG5jWNma9YQSvFioJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2vIGrngMlHz4Y7lX4nOfuSs7om1dy9RmHVpVFxRG+k=;
 b=OJbjC1VjXouSUtTh2rQE56qyRT+lOSgkJe6QAuqsJmpOK9NjdrOcU9oTfCNiVG/vmRuEUcaXVXMURhRE5IOFzoXAJSoGiGkx4H1N8sw3Unz8FV4iNC4E+RbZp1fkX0ZPbSgbLwFk/1qkDFFMUbIk++c9k/QO3U37U1//xyjqw2XYTBYGTrDLO8XRnT84fJA8nTIDG1d4LIBI+gxm5pGUIYR1K2isUAI3Ntcb1sQx1yDYtOUNOSkvaTyg00GSAx472joX9ysjGlWL7HMqtmqOhOXWzGTDYypz8DS9qoR3/rOThWAAAMI9tKBlLGdl4pg7WqzZOvQ93rq/k5CxzCx/+g==
Received: from DS7PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:3bb::24)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 18:58:56 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::6b) by DS7PR03CA0079.outlook.office365.com
 (2603:10b6:5:3bb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 30 Apr 2024 18:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 18:58:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 11:58:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Apr 2024 11:58:46 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 11:58:45 -0700
Date: Tue, 30 Apr 2024 11:58:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <ZjE/ZKX7okSkztpR@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <4ee1f867e838b90a21de16b12cf2e39ba699eab4.1714451595.git.nicolinc@nvidia.com>
 <20240430170655.GU941030@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430170655.GU941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9bd359-0482-463a-c6b1-08dc69479612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4iuTsTmODsYtjVQSLwViasaIM/gJ8dMwGyxXQqPZjeGkQIx2NYDAqI6Ouorm?=
 =?us-ascii?Q?7lfyy8HZZxRf+0VJoE9JDg+buyERsymy7K9FXu6MZfvOgjwKsh0B5dc4qP2+?=
 =?us-ascii?Q?b5dhsaGu2QXLdKg+rXeezxgHhkobNlZi+KQZ+WWg9ng3MJeCqMQumoQe+6lz?=
 =?us-ascii?Q?VxaNsflVwWd+nfD3ycin1rHQAEhywfDTh8c4fvbI2TTrcb2iqWWoD1/KVDnm?=
 =?us-ascii?Q?nP7z3iAlhrGAe8RQQb3k/x0/TtFb3arJa52Wks8cdGtKaGLkcixYJHXe8VG3?=
 =?us-ascii?Q?4JBTSoCO750zNXHALuTKghsuyk4atSrp7SkXzMN9sX2IEgEljtX50cWFyEKu?=
 =?us-ascii?Q?KLLO0nwYDTn8tMxgVDud1L3uQ6ktJumMq61c0hmU4tBGa19GR9bCb3hWgIO3?=
 =?us-ascii?Q?PUk4HEIGdSZeEEcNawvOhD5DKiO3GtEHA+lECDSUu4fmlgFxcM257P1BA7Ej?=
 =?us-ascii?Q?i+v96E+nSEp+tVM4lC+FUobHPDo4ufzM0WDfeAYZWw4YLyGKTvYo7iJZifO9?=
 =?us-ascii?Q?qB9DwBOIiMe4XJXJk6+071C7LM92QrBnlWZpjhr/k+BRQyK0NhhmMIKr/EmL?=
 =?us-ascii?Q?smeC2gJQcIoaX64m2Y6qxHnDgTqKrE8XTl5ZyBDBaCYfLddwX5ZD8o37lCEo?=
 =?us-ascii?Q?riIXuaCpsK7c47bJyyKOz3/4Hw3Y3EVYlc6NIKhU9tSorVWecGxv/vN3Rk5h?=
 =?us-ascii?Q?qrEdFFTihQpUbaEJqHuOcEtoiClFXqs72/138I42rR1ulYjiI8hieN6uIfQv?=
 =?us-ascii?Q?shZAqVGpYi+UNgAeavR5eeJD2xrQwWJvpARGCFh6LqghEIgX2pK28gQlkd9H?=
 =?us-ascii?Q?7D+LYZ80y96IixHcxL0Gp/iuGWGGvjAv7H2IYEs3zsECbn6JFU0iZQx2vOqt?=
 =?us-ascii?Q?Q8twYJD7/jlX6XU7+kaKvLw/A0y2KwkEdbv+rf9EPDBBvG/1jlRVG+aiVUTX?=
 =?us-ascii?Q?OTpn+EGwAg1Fwl04CpcappO5dSkSqbhhMpRidO0h5NoH6O2tI3Dd2YXxIafS?=
 =?us-ascii?Q?7TREjq/jQT7MHrb+RcJh8uyv6uNzFeVVijk4Xns864Hu3rBR9cRpoJJ3MfBc?=
 =?us-ascii?Q?1RY6NSCAtQ8EBZLIQGedb1dppr6v8OzaTEbTCs/sAJgcSyVZ7F8X27LRkaqC?=
 =?us-ascii?Q?rwiGNlwAiy8iAdXz+fgLuhIkU/n5yUwtn5xAwt0rk9iJjNOe8TTQHRzYbJV+?=
 =?us-ascii?Q?1xJTV4lXxpvkrmIAc15LWnfvL5oJFgHhVlAL12NYk+fOR7gyjizy6YgQCm5V?=
 =?us-ascii?Q?sw8Uw/TOL9uFg7Gl70VNcP4Z7xfnpUyF8XtWWSpTOlBSfN7Um6kzSPKPLGMI?=
 =?us-ascii?Q?HvVMFO2S2RhGpVT6mZFkcKyI4lSeilLScduxhjH4qLCBpoW4fQEg8ov3cyhr?=
 =?us-ascii?Q?50DcbXg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:58:55.9769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9bd359-0482-463a-c6b1-08dc69479612
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566

On Tue, Apr 30, 2024 at 02:06:55PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 29, 2024 at 09:43:49PM -0700, Nicolin Chen wrote:
> > -struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > +static bool tegra241_vintf_support_cmds(struct tegra241_vintf *vintf,
> > +					u64 *cmds, int n)
> > +{
> > +	int i;
> > +
> > +	/* VINTF owned by hypervisor can execute any command */
> > +	if (vintf->hyp_own)
> > +		return true;
> > +
> > +	/* Guest-owned VINTF must Check against the list of supported CMDs */
> > +	for (i = 0; i < n; i++) {
> > +		switch (FIELD_GET(CMDQ_0_OP, cmds[i * CMDQ_ENT_DWORDS])) {
> > +		case CMDQ_OP_TLBI_NH_ASID:
> > +		case CMDQ_OP_TLBI_NH_VA:
> > +		case CMDQ_OP_ATC_INV:
> 
> So CMDQ only works if not ARM_SMMU_FEAT_E2H? Probably worth mentioning
> that too along with the discussion about HYP

Nod. EL2/EL3 commands aren't supported. And they aren't supposed
to be issued by a guess either, since ARM64_HAS_VIRT_HOST_EXTN is
the feature of "Virtualization Host Extensions"?

> 
> > +			continue;
> > +		default:
> > +			return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> 
> For a performance path this looping seems disappointing.. The callers
> don't actually mix different command type. Is there something
> preventing adding a parameter at the callers?

The callers don't seem to mix at this moment. Yet we would have
to be extra careful against any future SMMU patch that may mix
commands?

> Actually looking at this more closely, isn't the command q selection
> in the wrong place?
> 
> Ie this batch stuff:
> 
> static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
> 				    struct arm_smmu_cmdq_batch *cmds,
> 				    struct arm_smmu_cmdq_ent *cmd)
> {
> 	int index;
> 
> 	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
> 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
> 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
> 		cmds->num = 0;
> 	}
> 
> 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
> 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
> 		cmds->num = 0;
> 	}
> 
> 	index = cmds->num * CMDQ_ENT_DWORDS;
> 	if (unlikely(arm_smmu_cmdq_build_cmd(&cmds->cmds[index], cmd))) {
> 		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
> 			 cmd->opcode);
> 		return;
> 	}
> 
> Has to push everything, across all the iterations of add/submut, onto
> the same CMDQ otherwise the SYNC won't be properly flushing?

ECMDQ seems to have such a limitation, but VCMDQs can get away
as HW can insert a SYNC to a queue that doesn't end with a SYNC.

> But each arm_smmu_cmdq_issue_cmdlist() calls its own get q
> function. Yes, they probably return the same Q since we are probably
> on the same CPU, but it seems logically wrong (and slower!) to
> organize it like this.
> 
> I would expect the Q to be selected when the struct
> arm_smmu_cmdq_batch is allocated on the stack, and be the same for the
> entire batch operation. Not only do we spend less time trying to
> compute the Q to use we have a built in guarentee that every command
> will be on the same Q as the fenching SYNC.

This seems to be helpful to ECMDQ. The current version disables
the preempts, which feels costly to me.

> Something sort of like this as another patch?
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 268da20baa4e9c..d8c9597878315a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -357,11 +357,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  	return 0;
>  }
>  
> -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
> -					       u64 *cmds, int n)
> +enum required_cmds {
> +	CMDS_ALL,
> +	/*
> +	 * Commands will be one of:
> +	 *  CMDQ_OP_ATC_INV, CMDQ_OP_TLBI_EL2_VA, CMDQ_OP_TLBI_NH_VA,
> +	 *  CMDQ_OP_TLBI_EL2_ASID, CMDQ_OP_TLBI_NH_ASID, CMDQ_OP_TLBI_S2_IPA,
> +	 *  CMDQ_OP_TLBI_S12_VMALL, CMDQ_OP_SYNC
> +	 */
> +	CMDS_INVALIDATION,
> +};

Hmm, guest-owned VCMDQs don't support EL2 commands. So, it feels
to be somehow complicated to decouple them further in the callers
of arm_smmu_cmdq_batch_add(). And I am not sure if there is a use
case of guest issuing CMDQ_OP_TLBI_S2_IPA/CMDQ_OP_TLBI_S12_VMALL
either, HW surprisingly supports these two though.

Perhaps we could just scan the first command in the batch, giving
a faith that no one will covertly sneak different commands in it?

Otherwise, there has to be a get_suported_cmdq callback so batch
or its callers can avoid adding unsupported commands at the first
place.

Thanks
Nicolin

