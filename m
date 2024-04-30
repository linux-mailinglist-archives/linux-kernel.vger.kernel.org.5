Return-Path: <linux-kernel+bounces-164489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5188B7E25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528F71C238A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AB172BC6;
	Tue, 30 Apr 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="An5GXD6W"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A017164E;
	Tue, 30 Apr 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496822; cv=fail; b=G1Lf2cDugV51g4cUrCiYD3/IPT3OzDdDK/h74/wjOwgm864nYKNx/lBeiQdvayEAlJAGwcR2EZu3mr+AIjhRxgSOZZ3spdAz3LMzoH3SOtuHRLt5MqKRp+kl0a6VJm9xuIOWqJZJDHYKzbZ5gckm2+lIru8rFahSRr6zPWSyQRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496822; c=relaxed/simple;
	bh=rDO5xIPD/2eZROK/T6V5D7Ex5iMgzZvNmpIv8ZL00aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kxFfXzJjoh6+70SZYAEdjVl6ugZBXFkISt4WmUy+bGem+68430CfjMu1z0bVTe0+daeQjL+5cKfsJbSitjVvczMKalnvwDmPsog/pia6R9jvwAsgBoECNW+ySqIi676vIwueYpGeM1nVU4Y3B5CL4OdpJtehzjDXVHqflULL/nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=An5GXD6W; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCr742anetQFCeMhUkdSc9nNfwX1+/KeC2n89EyHoDByz3x0YkauArAujEMMgNwInxLxBqS2LsrVnYCX5IWJfwfD8jWTWzv6gsyt47f2WUIKirsucWCuRlYRnTb6Lzw+d9+Gdpv/SIVOzgm6H/JIq9npJCaWDCF0wAZ4fuotwTlp4fLCQklD5bvrZXB+fTNUZjb5qgGLqSCG5NpXsWYl2ssWT6Arv/tGoP7zZF5MIApKc4CxbnO8gG9yHL7l8NoZt3qKTOqz5+JhpvFFDi6Pg6LfgbncDGiuhriIqIhG4vnQvsW4k5L49JJySw0DJoqhmXrVDRCqI+ijHedH/Z7MVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPQK+dGmU6eZzVclfpRD2BvSAgzFcTcLtQvtjWQFeV8=;
 b=XARsYIcD0U7u7MYGUL86DISvItIo9VBsbmoHz/mmSHmsoaOk9dcCpHn045L5ieaZxJPIc1Py5H3xR1IhMMZNHTKr9X4bs/iKt8dtGSCObQTePCfgYEDfkiRUuN8JNhWs68FWg0jyIYn1E4H5HhJT2qMa6ND3ik6UO+QtRHb9k11o2fgtJjv4VQXDItXZSZEndPAj1pldhjeIxQHP3+czp7P3ksAC2xAxJ2NxzrWT+BRDuta8yle1GNOaCVrvub7suuWvRfytmeHOe86nqBH7DKrtg4mapwqOOWNf/SjPTC0ceInOOljGS6zTrtg4ENWQ6fDtUy0tS5WhbOX7RLxmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPQK+dGmU6eZzVclfpRD2BvSAgzFcTcLtQvtjWQFeV8=;
 b=An5GXD6WvJvkQPQZaWsyhQwUjxsf6yDbJoo1JQ/UCVzpP3Ql+KFPfEunL2faqHPxPrv02ASzjRR+CjxQIxTvC/2LTPyaqM1vr4JxlP4JLD1CSOBdvTY/iqSgyuIsOm+1dD+31xSpIRF8fvhZwiWQIRqKfnCqd3S9ap+KMNWQrKhYMa2Cxdvd/VmPChxSztelmd7/2X5FZXyuRL3tJaDCiWll3tYwsW+Z8m9dHu83qWQFbtIm+SAtvCpjWkC17W5zkEnSfvbIOARYY8cGGWLTymHrK2GsJYhrAZuXHohIbIHZrGHK11F/yY5e/VUcOX4q4CH9g4ghSrHeZPxjxeAC6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 17:06:57 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:06:57 +0000
Date: Tue, 30 Apr 2024 14:06:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <20240430170655.GU941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <4ee1f867e838b90a21de16b12cf2e39ba699eab4.1714451595.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee1f867e838b90a21de16b12cf2e39ba699eab4.1714451595.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:36e::24) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 719e71c1-9411-4b9f-0ee6-08dc6937f128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLTwPSmmgozoHT0LpHQXxsvoAtn7nGudR+Pw15Jq9iFsoltSzs5BA8uvQybP?=
 =?us-ascii?Q?I/GInJT5rHwmq6xf56ilLgJABcxt2mW9hn0bVr0E4PFnkGJ8BU9SXwULievS?=
 =?us-ascii?Q?0aJrZ2cNDCsnADnY6HRkh9i0wCwoE3Suv/RjcXDgQqU7VLNSqgoYijDVG4QI?=
 =?us-ascii?Q?qXiArsnC9po1oTonv8bEhJVXNxCigZSy7IEa1ElseGPVLGoCoggrkIWW3cMT?=
 =?us-ascii?Q?Tjm5EgfOtgjQdQZuUF3SaCh7nY6lb9iNXy4M+1KFYHNW5sYC1+k9TGusrBPY?=
 =?us-ascii?Q?josZDAByfbenVKO48pgG/3mfp0uVl64iZkZlM9r6N30C+GcFlKBAOlCrnBIh?=
 =?us-ascii?Q?0BqYMY65nnZSSm4EoIZXQXdXd9UBqEn4GHtY5hwKTTIDJpfoUreKBDgnb22c?=
 =?us-ascii?Q?2eWINjzIfz8ljc5qkXkDK6Kcl7sYaakmWwtON7e915eIBcr8nGQ3K2EzEMnO?=
 =?us-ascii?Q?kU/iVoRfwchhGdqgu/gKfLTY/fd47X4NDXSMv8cgVv7HC1BJumI/DH8Dl9IE?=
 =?us-ascii?Q?TnLxMcKWbQgNncGZUXoQUdRIBg4ix11MpkWTX+K6Mu6BVnSlmw+qFGEwsmJ1?=
 =?us-ascii?Q?LLIZPH5bDd1PiZpQ3NWy9KPsxf5760ouQzWsoPWR60bM/Vbs119A+AUCgyun?=
 =?us-ascii?Q?TVbDGEShsEdze774PmJzI363ZEYzABEEYsXiBkmbdGLyEVkUI8aAZFvC3KJf?=
 =?us-ascii?Q?9f5N5eU12NxvJS2eSgSomqKJbnWWVUSkSyx0voKeX99S0OR3QWIZ6QGibACJ?=
 =?us-ascii?Q?YhqSnGs/UUK/AyUErqZD9oPNKqQHJQyyBViW/90pZqr9PDSS8alckULRnLsr?=
 =?us-ascii?Q?GfY0U+GWqpA2lumiiObo3zq3SGqJabeLGCH6jXEoI7DwThlp2v/N4erp7w8u?=
 =?us-ascii?Q?N683223zL9q8EkxVAA3Wz+ZRFLJalbmlKTswCdSHk7deJcvV8xbb2e/NQ/6u?=
 =?us-ascii?Q?mpL0GH8wGJO04z6l+pbXFyIQRCkeQi4ezHJ4qtOI/gtwJtOlcN/vALHyTXOa?=
 =?us-ascii?Q?vUU2+xAVcmPyI9LasaB+w+4z2XC6y7IYUVKk8LhHIDg4moq5TM5LomA5a3nt?=
 =?us-ascii?Q?t2HYB9bdsOfndaFsrFBqMLo6u3dtvIbxZ1O6oiu0btOWZ1zP6ZntjlIMLcb9?=
 =?us-ascii?Q?nMbjBFSuO26r9NYHinCB1PSNs67EKZcnQxtb9zi0boiKb5ieLP15cU8AjpDj?=
 =?us-ascii?Q?7R3zPsG0DDcgWk+88A0ucR/8TCVBp3PIOBMX0SZAkx15UHuRJ2bzXYE2U7UR?=
 =?us-ascii?Q?uVsB6CvN7I39dtF2W4x5vP75wOj3Z8qUajsfUsyp6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I68z1h2qgL0oRwOH3yA1R+KtRbRcVm7yz9qZMY+f14XZm/I1fR7HMo4uPnTO?=
 =?us-ascii?Q?Vtu36g2ZWEkITMfWC8EubV0GT8to9q7CrqArrJs8uGPdLZ337QqdcKHWgx3W?=
 =?us-ascii?Q?yVOI/WZ3oMGLtTfkl8woWX7smQfr9KoLBBwiPL44TdsV6QkgoaZLbC4al776?=
 =?us-ascii?Q?5ZFv8tb47B9XkZZJSAVTqOjaEGtgMkN8XjHLjCO+qmNuUo0Njy/ZNM1HQT+m?=
 =?us-ascii?Q?uncf8s7CpzKedlGaNo6YeOgzHAEJ9GAqZ5P4u/2pPfqRpUjS6Jr4f61pocE4?=
 =?us-ascii?Q?MzHLwzAmVpTKOJ3uHuxeg0NuHVesG0pb7JaVE9JNzQ9kczzo4p2E6hXDKIaT?=
 =?us-ascii?Q?X0TE62tiHa58IOhCv6EIwpoaC63+zM0sqcovkF0p+QArx71/70iZPEjJrLvf?=
 =?us-ascii?Q?+1Y4XdRDTfW4pAjoHqM7pCNsNHh6//bZ77Jpkwdw0rZuW6LBEjpLd7aErBNL?=
 =?us-ascii?Q?+6XZThs3+ptDRWe5Nt1xYxQV3ghHy6m1Wcea7cB3w8vsTn47aqblLs6PBrU0?=
 =?us-ascii?Q?b6S4nggmhYJ+cycMwu/b15AJPjbl98WL8mT+yLKEpWWBwYWtFTOrWzqBveVk?=
 =?us-ascii?Q?iohfcAGlCr+aIcxUYq/G/x46ydGzPt9DwgIGTorxtNTg1Rp6S1Sg6bNDBCqL?=
 =?us-ascii?Q?U44aZZf+G3g3xD4HX0NpObcnD4PEKTZYWQx9UZN+cTGVBVYhsZZqqoG0MbDr?=
 =?us-ascii?Q?u4uRuz6vLnURyvCe3KCkOR2MRjs4UjzpzPOLKSVeanKbzMD6HTY02Q0BeWXv?=
 =?us-ascii?Q?yVuIPNQCNG8b7sb9SnOATrrmlnjEfozZVavrruG2y8R4/tGJHtWwmA648TUG?=
 =?us-ascii?Q?qks1RxwkHwB8enZFAxLTjTn6kKdRqaVHRS7gECxozAJjzYwNDGxC9lX+scHL?=
 =?us-ascii?Q?0I2W3nLtJNCy1y9F/bDyIX8x7t+CaCAHh9J2oaP8U3WkngYlqYdr1Ka/ASQW?=
 =?us-ascii?Q?06PdKpR/SLwyq28SZB1v7B6DgUf2oO+XE+RzaJaGSLy/9N07iGDg+CPYDikN?=
 =?us-ascii?Q?vtFD4tesulkbvlFglV/CK9OGZ55gnubJbHyX7q59/P7BFO1gPtOpU1zNhy9v?=
 =?us-ascii?Q?qoQ7dc8RREM0szMmPbp44ggig6zS9DcafidiUSSL71ofvN5TEafVBu2J98Fk?=
 =?us-ascii?Q?/fUACHmPeHSmtRn+1ETWUN66AdfCJ9gM2pQ+s+U1V0/PGrOAodrA99u0+Ok5?=
 =?us-ascii?Q?MJvENCdOmvQKH98zn4zCq2tbAs0jNWp23axSoNVDNCqDc1LwcTgrUUj5+m4h?=
 =?us-ascii?Q?cIZF5KdZfsYBTywQ1zbcVjXn8Y8SMItRY7ueTxoeuwRZlwBK05ZmRq361ZBE?=
 =?us-ascii?Q?Qx4ZO35XFy5xTC5LfJ9J9NJM//Xt8nsU0L/g+3iietJnUZSnqMJqq8aph7XF?=
 =?us-ascii?Q?ADP0A4MHhdv1/mtm44+aaW8ABHaofrDFeXvRt8I0CO2MNYOJ7FVIOvs4nPuc?=
 =?us-ascii?Q?NvXpphzBNtPPzufM84s+2PHZhzscKOg5jlLU+hS+ceaHaKl80X0t74trr9HK?=
 =?us-ascii?Q?mH525uOwBVUoBXyECi4fcvfB9GfZvp/f0BpnQzI0B6kjj0UWT/7nCfOfvQsq?=
 =?us-ascii?Q?3GKegdPLe+PADYHHN7ETIecJRg3H5iVsoLv78fOC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719e71c1-9411-4b9f-0ee6-08dc6937f128
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 17:06:57.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDT2pKIyqgIWgL1U0WEKSyjOjhBSg4mis2ex/FZeyRldY17vtecIuX+Wk5tmZk3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104

On Mon, Apr 29, 2024 at 09:43:49PM -0700, Nicolin Chen wrote:
> -struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> +static bool tegra241_vintf_support_cmds(struct tegra241_vintf *vintf,
> +					u64 *cmds, int n)
> +{
> +	int i;
> +
> +	/* VINTF owned by hypervisor can execute any command */
> +	if (vintf->hyp_own)
> +		return true;
> +
> +	/* Guest-owned VINTF must Check against the list of supported CMDs */
> +	for (i = 0; i < n; i++) {
> +		switch (FIELD_GET(CMDQ_0_OP, cmds[i * CMDQ_ENT_DWORDS])) {
> +		case CMDQ_OP_TLBI_NH_ASID:
> +		case CMDQ_OP_TLBI_NH_VA:
> +		case CMDQ_OP_ATC_INV:

So CMDQ only works if not ARM_SMMU_FEAT_E2H? Probably worth mentioning
that too along with the discussion about HYP


> +			continue;
> +		default:
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}

For a performance path this looping seems disappointing.. The callers
don't actually mix different command type. Is there something
preventing adding a parameter at the callers?

Actually looking at this more closely, isn't the command q selection
in the wrong place?

Ie this batch stuff:

static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
				    struct arm_smmu_cmdq_batch *cmds,
				    struct arm_smmu_cmdq_ent *cmd)
{
	int index;

	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
		cmds->num = 0;
	}

	if (cmds->num == CMDQ_BATCH_ENTRIES) {
		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
		cmds->num = 0;
	}

	index = cmds->num * CMDQ_ENT_DWORDS;
	if (unlikely(arm_smmu_cmdq_build_cmd(&cmds->cmds[index], cmd))) {
		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
			 cmd->opcode);
		return;
	}

Has to push everything, across all the iterations of add/submut, onto
the same CMDQ otherwise the SYNC won't be properly flushing?

But each arm_smmu_cmdq_issue_cmdlist() calls its own get q
function. Yes, they probably return the same Q since we are probably
on the same CPU, but it seems logically wrong (and slower!) to
organize it like this.

I would expect the Q to be selected when the struct
arm_smmu_cmdq_batch is allocated on the stack, and be the same for the
entire batch operation. Not only do we spend less time trying to
compute the Q to use we have a built in guarentee that every command
will be on the same Q as the fenching SYNC.

Something sort of like this as another patch?

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 268da20baa4e9c..d8c9597878315a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -357,11 +357,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
-					       u64 *cmds, int n)
+enum required_cmds {
+	CMDS_ALL,
+	/*
+	 * Commands will be one of:
+	 *  CMDQ_OP_ATC_INV, CMDQ_OP_TLBI_EL2_VA, CMDQ_OP_TLBI_NH_VA,
+	 *  CMDQ_OP_TLBI_EL2_ASID, CMDQ_OP_TLBI_NH_ASID, CMDQ_OP_TLBI_S2_IPA,
+	 *  CMDQ_OP_TLBI_S12_VMALL, CMDQ_OP_SYNC
+	 */
+	CMDS_INVALIDATION,
+};
+
+static struct arm_smmu_cmdq *
+arm_smmu_get_cmdq(struct arm_smmu_device *smmu, enum required_cmds required)
 {
 	if (smmu->tegra241_cmdqv)
-		return tegra241_cmdqv_get_cmdq(smmu, cmds, n);
+		return tegra241_cmdqv_get_cmdq(smmu, required);
 
 	return &smmu->cmdq;
 }
@@ -766,13 +777,13 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  *   CPU will appear before any of the commands from the other CPU.
  */
 static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				       u64 *cmds, int n, bool sync)
+				       struct arm_smmu_cmdq *cmdq, u64 *cmds,
+				       int n, bool sync)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
 	unsigned long flags;
 	bool owner;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, cmds, n);
 	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
@@ -897,7 +908,8 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return -EINVAL;
 	}
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, sync);
+	return arm_smmu_cmdq_issue_cmdlist(
+		smmu, arm_smmu_get_cmdq(smmu, CMDS_ALL), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -912,6 +924,14 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
 	return __arm_smmu_cmdq_issue_cmd(smmu, ent, true);
 }
 
+static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmdq_batch *cmds,
+				     enum required_cmds required)
+{
+	cmds->num = 0;
+	cmds->q = arm_smmu_get_cmdq(smmu, required);
+}
+
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
@@ -920,12 +940,14 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->q, cmds->cmds,
+					    cmds->num, true);
 		cmds->num = 0;
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->q, cmds->cmds,
+					    cmds->num, false);
 		cmds->num = 0;
 	}
 
@@ -942,7 +964,8 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->q, cmds->cmds, cmds->num,
+					   true);
 }
 
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
@@ -1181,7 +1204,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu, &cmds, CMDS_ALL);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2045,7 +2068,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds, CMDS_INVALIDATION);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2083,7 +2106,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, CMDS_INVALIDATION);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master_domain, &smmu_domain->devices,
@@ -2161,7 +2184,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, CMDS_INVALIDATION);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9412fa4ff5e045..5651ea2541a0a2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -576,6 +576,7 @@ struct arm_smmu_cmdq {
 
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	struct arm_smmu_cmdq		*q;
 	int				num;
 };
 

