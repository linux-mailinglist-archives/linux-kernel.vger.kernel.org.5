Return-Path: <linux-kernel+bounces-165581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CA8B8E38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321151C21616
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB3D2F0;
	Wed,  1 May 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FxPZVf4+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004CC12C;
	Wed,  1 May 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581189; cv=fail; b=MUjHlIXx/nq/2cmbXY9Sib/Z2+S5dNwK04GfnvUsQXyWI3MOv6yPrmy7LPGQNGodrF52hbj4g+nxRIOm3uknD3Ahm1IvInOF4vEUYSeiAudO5FWHUxAzM2S8OdERITfSp7MREABS/eYohYXaXQj8GsU870g40BZs1Z5rH0q2TAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581189; c=relaxed/simple;
	bh=wJbiSiZ11KbZOt1S+/GiQo8RKDzict6kJ8yMTxrRoao=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDzjePA2TkfFm5HHtpq9SIO76qJmLFIMLmY5woPYADGX4xo5iWQo18ZRDe5mOuKWE2rX1py+WbIFRpnBa9x6r51kDj0U4KsGgmfDwBTz9dryEGk5CfHn6D0RjPnNVXv33mne0ah33Eym9OdD8k8uzTyCGDuD8BOlKInYNfkXT3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FxPZVf4+; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot08mBKmQLHEafVUuL2bV+xXWBL70ROo9yx+OByFo92a5S99uUxnzOzC4aJo8WdDH3YETsFSft5mU0ieU0F4os5EPBDoBVmXIJemMvcEy5lLCpyko2GczaRb5CvLr0r1UIYCbAlM91dBH4y4oelSNFTbK0xuS9BXAcdLue1PbYX4WL1zTOmAozYYuGtyUgSrGmPHzY+SobgENTg82Aq5DmRW9BmcQGMt8Kvr0lpSxbVlPFzuO3Rvh9yA8OqMnVbhHK/ktxSc8hlQlD0sGlA/4cAOvHFnkN6uK7qoD4p1H9s4KbyAJDMMh007KYur8yCvDkzALcz07KgbDJjdoNjb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMpD7sUYyKlkGhc5ODmv2+pF06a3HmO7b9KZFl2so2A=;
 b=FUt/1P9UqTo1Q69ZJb7xOaU/j1L9uBaEsUwq0/qxWcUE27bJOaZMHPEh7GQ3US9hU+E+/JOQSYYfV9T80eoif518WX9vud6DiZl3Ut+xP1DvGSpUFRGyFMEPp8gfFZMbnB075U995XMdnZKbEVOmar8pLP4jWjjLeB2blo54ZqN9SxanVAYCtiEyi1fzRC3LWga/3tW+JIs95e6HLwmXh+6oQqE9dXZg2nuPo7Tzmx7xDdS4KH7ZuiHWnDCzFWoQ0LCyUgNjtkxBvb+4cIbb4QaQ/tURYCxWAj3Se8zZhQuUffP7Hap/YBPPsSZVrxrAC40290DoMNWcAoLHE6CuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMpD7sUYyKlkGhc5ODmv2+pF06a3HmO7b9KZFl2so2A=;
 b=FxPZVf4+CI+F+dsPmEf9dfPHbQtxxzSXZnQDKOmDVHK/W2/EYC4pTGitmT/6t42cu07d8G4QyUwdeeDPcuXKbWRjjHUoxh7UEJsYa2blDqSts9napXcj9WR1exCAduh+dCNSsgxxpI44dFHLVswwfA5txTFFg+/6N8HjS/i9lwu9/2SeSYuA9tYaiDkX+tXbxQdtcSU4yEzRxnG7xKZaAJ5ZKlgkt59M3SfIM4OW1AZ5D0Ya+YFd8RKrqRn48nkY4Tiwu2fBo5J6xzF5sMJ4u0oXh3W7tUv2YauSK65aavQva64pGlg0/Zs9O082RbrRq/xWw9XmodC/Dmc0jUgXiQ==
Received: from CH0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:610:cd::20)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 16:33:00 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::fe) by CH0PR03CA0105.outlook.office365.com
 (2603:10b6:610:cd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 16:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 16:32:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 09:32:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 09:32:46 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 09:32:46 -0700
Date: Wed, 1 May 2024 09:32:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <ZjJurCoepdiUMCpX@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <4ee1f867e838b90a21de16b12cf2e39ba699eab4.1714451595.git.nicolinc@nvidia.com>
 <20240430170655.GU941030@nvidia.com>
 <ZjE/ZKX7okSkztpR@Asurada-Nvidia>
 <20240501001758.GZ941030@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240501001758.GZ941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: e3db6ebf-846f-409c-b113-08dc69fc5d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sluIWMMi84hIA5gag5XXo50RrxI3zxN50xMDsCD5N7xuCpPff+T41Pspa1jU?=
 =?us-ascii?Q?e2y9AeWeac0SbWRCd8z4ayrR9JbhAVJUWyXlOqlFdMV6K70WyusmSPI9moFZ?=
 =?us-ascii?Q?slDoVOHJeYlxzWk+cz4+FolaymYfYUE71oah8coSPicE1H/jBwtLfouBN8wt?=
 =?us-ascii?Q?13HrgwsaLgLrPTzEXWmlgWtJycRZJkM2utIZczMnIuEzSn4TlazkUYPepqHN?=
 =?us-ascii?Q?uAvYhfrP1YM1o6A3dgNF/yYs12JcpvXxIWiomjuOkiNiXk3xellLUtXnNw1s?=
 =?us-ascii?Q?mfacGrnoTuZ+/w6Vos3DfhUUqKJCUwomhpyIv+EAvdwAKy+RSEWYGGA8hWRM?=
 =?us-ascii?Q?wLACl2Ii69vGMOr1fcKNLcdBrPM/Gyw1xG/ExmkVXXzyUUO9eYhYxZMSAHK5?=
 =?us-ascii?Q?LzdNSkmSA+McDD4d9ZwdndnP0TZPQICSyTaYi/bZ/Oc7EmefkZNx9mBDJzKn?=
 =?us-ascii?Q?7/8d5Mn93i4tbv7kTIYKk4H3vVKZPX2JAth+ZOZ9IyOsPdRZVK7IuNi680gj?=
 =?us-ascii?Q?2Teb+T7kDFCr/lh+y+5GgvO6qOWz/TQ9cqFSQ2SCYnnhgaRMeo7u/Qj07qz9?=
 =?us-ascii?Q?78RHT4CLAkPgs4pdZs1Hv74jeohVX2bQXQQWU55nGxrPgtq3pJByIJfXjIaS?=
 =?us-ascii?Q?A6c83/lMIwf5kG/r5hFv92iRBuahGKeA1KPVTh4PaFhMHJPbjrxVdwLX0EmE?=
 =?us-ascii?Q?kCOOQfjKTuSfUaM4uCCQcik2nVt2R+tAGkEcGfLdm62NNROJa7Cyoegin8SU?=
 =?us-ascii?Q?YLEd6nOBrqzgHZrDLuF0lnpEAF7LtASIK1i0F8IQtUigZE2eSRMpnKbdEEap?=
 =?us-ascii?Q?+LY/Pq/04Jb6KbMtTY+rMD2pBxMXnm+3vgyYNLKIfSfmqEeWh99+o2D0ozc9?=
 =?us-ascii?Q?gEf2QvDzPwiaARC1F7HRsl5s7iYs/Mg3kumWpDQ6CvjmRcXbKhX13DqkPCM/?=
 =?us-ascii?Q?/bL4+gJkzEwX4s13AhU4JVMwdFYeW+bBOZ8nlmunVWX1gL4Oh1SN1HUW3ilS?=
 =?us-ascii?Q?pBxFkpC4SCCxE1E4wqgntjsqz4HfDqFCNrwMGDEINJY8WhcGdpQBPeq05rLm?=
 =?us-ascii?Q?AcjI13W+gpf8XppmXtDdFMG0JJkNKgzZ0KIOy6pcdT1dzx/5ZIOvDL4LH3ue?=
 =?us-ascii?Q?YegGP3h4DFX+ePE8mToE1tFC2tcyqtFQu549NW5rbN2hZeCbXhtZywLL7TIt?=
 =?us-ascii?Q?whOnX0ykFC7rCr2LIM7sOjiMtRJY/jywF7Bn2a09BloKVow8Jr1NgDgs02l9?=
 =?us-ascii?Q?2md64MOua+ltRIJzs3sOmXP/WYDbG7D3PeNIp7UKIurGbGjpnYcYwp2rW7JA?=
 =?us-ascii?Q?HiB64UjnAZ7B7s/yLtl4UA7ijLvszPvUcS6Vzvts0fTxSsak9YFTFZUQhl0m?=
 =?us-ascii?Q?ZYxeha2qaEVdcJ+V0bCU4PPf1tZe?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:32:59.9686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3db6ebf-846f-409c-b113-08dc69fc5d7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

On Tue, Apr 30, 2024 at 09:17:58PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 11:58:44AM -0700, Nicolin Chen wrote:
> 
> > > Has to push everything, across all the iterations of add/submut, onto
> > > the same CMDQ otherwise the SYNC won't be properly flushing?
> > 
> > ECMDQ seems to have such a limitation, but VCMDQs can get away
> > as HW can insert a SYNC to a queue that doesn't end with a SYNC.
> 
> That seems like a strange thing to do in HW, but I recall you
> mentioned it once before. Still, I'm not sure there is any merit in
> relying on it?

I was hoping to get some idea from the designer. Yet, at this
moment, let's say there's likely no merit besides SW can care
less and stay simpler, AFAIK.

Robin previously remarked that there could be some performance
impact from such a feature, so I think adding your patch would
be nicer.

> > > Something sort of like this as another patch?
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 268da20baa4e9c..d8c9597878315a 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -357,11 +357,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> > >  	return 0;
> > >  }
> > >  
> > > -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
> > > -					       u64 *cmds, int n)
> > > +enum required_cmds {
> > > +	CMDS_ALL,
> > > +	/*
> > > +	 * Commands will be one of:
> > > +	 *  CMDQ_OP_ATC_INV, CMDQ_OP_TLBI_EL2_VA, CMDQ_OP_TLBI_NH_VA,
> > > +	 *  CMDQ_OP_TLBI_EL2_ASID, CMDQ_OP_TLBI_NH_ASID, CMDQ_OP_TLBI_S2_IPA,
> > > +	 *  CMDQ_OP_TLBI_S12_VMALL, CMDQ_OP_SYNC
> > > +	 */
> > > +	CMDS_INVALIDATION,
> > > +};
> > 
> > Hmm, guest-owned VCMDQs don't support EL2 commands. So, it feels
> > to be somehow complicated to decouple them further in the callers
> > of arm_smmu_cmdq_batch_add(). And I am not sure if there is a use
> > case of guest issuing CMDQ_OP_TLBI_S2_IPA/CMDQ_OP_TLBI_S12_VMALL
> > either, HW surprisingly supports these two though.
> 
> These are the max commands that could be issued, but they are all
> gated based on the feature bits. The ones VCMDQ don't support are not
> going to be issued because of the feature bits. You could test and
> enforce this when probing the ECMDQ parts.

Ah, I see. So cmdqv's probe() could check the smmu->features
against ARM_SMMU_FEAT_E2H, and disable VINTF0 right away, in
case of guest-owned while E2H is present.

And we could do the same for ARM_SMMU_FEAT_TRANS_S2, stating
that the driver does not expect use cases of issuing S2 TLBI
commands from the guest OS.

Thanks
Nicolin

