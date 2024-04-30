Return-Path: <linux-kernel+bounces-164381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9898B7CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7851C20BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384D1E4AF;
	Tue, 30 Apr 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mn/kAHep"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D22E3F7;
	Tue, 30 Apr 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494671; cv=fail; b=LNPmtTYrmyiewgTtZWZSvrTsL81lBUBm4MaxaL2MzvZX/Slnfm0adhvvG2aZbl+uvCrtvIYPmluZvjr8jbuZxiu0yEDILNWbn6pfIq6u9zD3GOMWwDrVOohQmjJDSqeLTaxOH/mT4XLXwI113Wj4dk9lb2Y1q8qujmqdtdULZmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494671; c=relaxed/simple;
	bh=v1eezTMSaxKv4ZtAhCPTYLRWTiSz9QiD2AvmxQrx6pw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo8ZJGEnEOV18oY4kg84wYQKg4bYzjTr5H9GacBC5shmHaJwwBiHxXffkQW0SZqX5i551Cea8DRWjOA6fSDt4jT6zp6vi4AzDn5rqVgDoZFjKfmKYLNDxtS1h6807w0sgbNLnAJd2T8ChURZ61Gnpky2R+3QmDh/OQXqhee/MaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mn/kAHep; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtalCH6V5vEfKrKDYT3lsNl9K0oOTbsg1TT1rSuVn2XD6+esDFlZgw+0ZZdSDrQ62yltWC9qKhaMSYYPQDTeirtTH6MSEVZbupuO+GNApXHTJnG1qIEDWcOpVwEd8xsYckFL+kwJN6456xrZ9hlaazyGJQUDb/+WRt90QvNf6hEqYvbbAmrscn2rDUrQsMEzhgxtIxeTqP/tRdtm/GPC7/G3VjjR4dVToxTHj151qZRmph18hS/GThR3Vq71darE7/cu+eLGWjME4jgcVOot1R81BvZWlIIcw8WgT9ZeBf7R/XaBfpLSAnR+y75M2WsFOwMIYKycax55K4sYnEzfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlZiHaWdGPOiaSo7GrQKrWC6yDTLRZNWIFqIvAtUeaw=;
 b=JgNYNzaSlKkCLpHjrqBElvIDzW/2Kp7nwkUYN0isG1JW/5tECPjIfu0g3aoEH1XiDaR+p+qynlqIECARY8G9Yq4KPXV9S7IXNF2yCf6JZIgkVdVETl4OPtfSdmnS+b137bZn6XQU++Fx+Q/SRKZyRkYquvSiqP61oxO9jIOlXxvuST/K62C9XSU4v4L/fGRHVXWBEdmrkpRbUkzKPfQWRN7cToLX3HreARWmZQ2SEkEbHAKgREtxrmpALcDLQBeLzXMwD9jxcUC9V1CA0fYF4ty2qerhUaDWZWLQ8pCYJps+wBtVqGbcaH6QK2h8qJji70E4v+bFTE4dA7vX2tb1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlZiHaWdGPOiaSo7GrQKrWC6yDTLRZNWIFqIvAtUeaw=;
 b=mn/kAHep5arPs7J+ktIECunFxX/OoBUcRJXTAwa1y2UQpexAz3foaypsw+L6NJDkgAaC97h2LCUKpixssOHOrWI5QOGeUU7ggQpRio92u5wqY+5Ac8acQNJsZSV9u9FEhk+cp6AEPWHgDiu+OGQeMchjS1rIf941KFDR7rD7Fb0yFx1KV1HfpEhA/qudeEncWuGW6hU4WF1SNLm34jQCZFozKAzDCNElzHAnVQ0k1IJelBQHRZGFquR1YHny5rSjiFQxPshfoNbKnznJAMr7/g5Yzjr1ICASsmsptXky7jizfb7Ka2hUtTjROMsmG0MWhCBIfvRW9cuAwutcJPRsZQ==
Received: from DM6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:5:80::17) by
 PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 16:31:06 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::ba) by DM6PR08CA0004.outlook.office365.com
 (2603:10b6:5:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 16:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 16:31:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 09:30:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Apr 2024 09:30:45 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 09:30:45 -0700
Date: Tue, 30 Apr 2024 09:30:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 2/6] iommu/arm-smmu-v3: Add CS_NONE quirk
Message-ID: <ZjEcs4rY1HpPz4Oa@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <81d79f51c69604a38ea4f72c8ac2c573c52e8609.1714451595.git.nicolinc@nvidia.com>
 <20240430142201.GQ941030@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430142201.GQ941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c89b69-ff2e-4bd6-74bb-08dc6932ef3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WvKcPAPepP/RAKLXqk4OEwyUt8yI0dkDK8dH6NtTjiVQeAI8Es8pS4h0TVqu?=
 =?us-ascii?Q?9GraMoHpLfNs3VAiBq7KW2K0hyZ2taUT1py8meJtZKfnT402Qu8cjULPWbDc?=
 =?us-ascii?Q?X3xCn/gVpqPkqYYhepPzXAuhKU3B9tMXC3rcyxf9WmEWURmyUKXnbiPD4ok0?=
 =?us-ascii?Q?qqIvCEnKkEe5Hwti2uN5EQU+O1Hmlji4F4hzJgkhCWvQcTCjl7IKqWErIptC?=
 =?us-ascii?Q?VSrThvNda5UBz+bLNMfiDca6l8ka8OyxRr4KK+iPJXifEDzSZotGop/wrxiK?=
 =?us-ascii?Q?P9zpANHx6od7HwGBx4mck0LGh2N4XkNY2vp/D0ULf2NcI7QKtR9qwSuyJrbV?=
 =?us-ascii?Q?u4KY6N8MHTkQpavyYGNK6cC1BypBYmah/E9u5XrsYwFNz7dqPIL5dGfXFmYZ?=
 =?us-ascii?Q?qF8vVbvu6SfP4kSGRkEZkOPiwRkf4V5FRUnCoefSM3tm3phTxbA92pHsJ8Rg?=
 =?us-ascii?Q?Y8O0HN8vJrniet02TlhatJKy7ypnYlNmtGrIKQSQEZtYHc4fRNWAlqTvlFpd?=
 =?us-ascii?Q?8wGgqWXu5Hp8abqMSXgLZRl/MRSQOcYTNOIRYNKmNDH0sgYxmqUbqoQ+g2ww?=
 =?us-ascii?Q?LqJzFbFcctmvD+W5LHjypJcq7oCAddfEKC/zXi6PErqAuCOATY+q6L8APahn?=
 =?us-ascii?Q?0T7Kt+OrjJA8Q8K+cr7R2wbfhB/Zz8LfgS5Kmc2hiyCRU3rIorcHjpv5Dv/6?=
 =?us-ascii?Q?T8qEGRv3vMz2dizAA8C9zncfiiGbdQYVk4gCszh9V1Z7rHdoOnWsJRP8e9M9?=
 =?us-ascii?Q?vXW9DW1r3RVaG0SUjsmERdYxC6BTnD/+lJ1BPkmjTjPODqgknWuJm74ZiR3t?=
 =?us-ascii?Q?bevw2DhSq2BC9knCcqouKMSfHPz8HUcsIcYFQQPxfOypiamltgc09/j3vxaP?=
 =?us-ascii?Q?1ukqmLo9CZaIp/uSTTkgUjtg0BD/TSmifUqTYvXdmxW3fNBHuDziuT9EJWsK?=
 =?us-ascii?Q?1HITgvo6cxG0L0+T8o3fTspkrAUX9aBwTy5dQ7waF9F6U3ttuL8ZLzNN7UUd?=
 =?us-ascii?Q?wnkymcaSDLWed0ymmISjrMwhpWZ8bqxWv5qKZYD968Hxpfqi7bKFPNnVRV6l?=
 =?us-ascii?Q?LL6DBEkfxVeOi38w/+YYYVACeLhBiAlcbYdT5EPbh3DZmeMG3yvwOu4ZYiAB?=
 =?us-ascii?Q?TaGlZpsCwqCRIx7+dezHSOngQLn7c5Yu+DLI4GfsF3B4mkhfsfz/K1n5yGpE?=
 =?us-ascii?Q?MqTj5Bq1j3j5JS38Voqi9kysGbG+ZSWn3HnLVRSOZoLIgSeRqg9zuuroLm6U?=
 =?us-ascii?Q?rbhj/8aEudqSr0DdWgG5KUlAtASqXXmQoLHlAFU6GYMKDGE3ApXXJWz4/RLc?=
 =?us-ascii?Q?AcCemV8jen2bfwugMPgi/nrlM8viKsSDvs90MCCucwt76efXbZtpZrtSA543?=
 =?us-ascii?Q?gJn1QKb3lAAVjl0ZZsS4AuDE445/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:31:06.1803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c89b69-ff2e-4bd6-74bb-08dc6932ef3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988

On Tue, Apr 30, 2024 at 11:22:01AM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 29, 2024 at 09:43:45PM -0700, Nicolin Chen wrote:
> > The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
> > CS field of CMD_SYNC. Add a quirk flag to accommodate that.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> This seems fine, other than the misplaced hunk
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> But it might be tidier like the below. There is already a function
> that is called to build the sync that has the q, just build it
> directly there and avoid going through the ent?

Yea, and looks like we can have a patch tidying the existing sync
building function, and then another one adding CS_NONE.

>  static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> -					 struct arm_smmu_queue *q, u32 prod)
> +					 struct arm_smmu_queue *q, u32 prod,
> +					 bool msi)
>  {
..
> +	if (!msi || !(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> +		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> +		return;
> +	}
..
> @@ -402,9 +395,6 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>  	u64 cmd[CMDQ_ENT_DWORDS];
>  	u32 cons = readl_relaxed(q->cons_reg);
>  	u32 idx = FIELD_GET(CMDQ_CONS_ERR, cons);
> -	struct arm_smmu_cmdq_ent cmd_sync = {
> -		.opcode = CMDQ_OP_CMD_SYNC,
> -	};
>  
>  	dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
>  		idx < ARRAY_SIZE(cerror_str) ?  cerror_str[idx] : "Unknown");
> @@ -437,11 +427,8 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>  	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
>  		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
>  
> -	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
> -		cmd_sync.sync.cs_none = true;
> -
>  	/* Convert the erroneous command into a CMD_SYNC */
> -	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
> +	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, 0, false);
>  
>  	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);

Here is the only caller for "msi=false". Maybe we could just do:
+	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, cons);

So, no need of "bool msi"? It would slightly change the behavior
though, a SYNC for ARM_SMMU_OPT_MSIPOLL should be still a SYNC.

Thanks
Nicolin

