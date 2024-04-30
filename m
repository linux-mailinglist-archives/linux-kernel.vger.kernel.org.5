Return-Path: <linux-kernel+bounces-164572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528128B7F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38AE1F23234
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628201836ED;
	Tue, 30 Apr 2024 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VQBg+jD/"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD5181328;
	Tue, 30 Apr 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500566; cv=fail; b=m9W4DtTX53etj3/SOZFg5iO6aDgZ8Vw0/+vAhEajDKZBV08/VpIJGfUag8SBKs30wNgEdWKp+4WVeSEOwN/ovDXxn975TdJZ8lmeb+93gaWNYbF7sux3sajW9eTnT8paCzXxaxDppZwgMHWeZZdwhA3jK9l23FK9tLxCqieJtpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500566; c=relaxed/simple;
	bh=I6ox4muHql8QWtlq1q2npatw4Ch6VGimBKw/cjqNu9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gslru6bq0cjvbUywbBiaycfv6mMR1OXHQA0pES+/gLvnX4n3ZH8BMwKOj2LLuKofeRqqn8tBd8Tq9FPXhw4aDi/hgOadA/JhdgJsYyJoxAzsXHtTC73GMcZ8A3hi//7x2nA1kDI92O4P6SIGk8Y6NC3j39zB+hLO3pf1haSgWzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VQBg+jD/; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3G7FrIKwV5WOYVqKjDLIaFK2gZhJZNy/n7N0ZB//7BTGAs3JAtL3Blr9Bge9sFqd9v2Xy87gpM/dHg0x2eNn2sN5GsrZ8oKXuV9BqcTsAe6yDNc9BB2aOl82hPMTn2tY5TuEeHW36FpsEUA9phhnv5JiYEBCsuvHMeOH70NkKWIJzW0R2+M0cK3H+PX3qj3LiMT0b81CPp3eOR5tPBNUP+3I/3eKWE8AUg/U2u3DXn0n4qq2ZEF1gtNRI+DGbgC77wZ0U/y8dz1EwfWPk44d0XkXc2GSnTLT4Kz6I0bjumG4GagWIC1xTtYUG2gY9kUbIFBVcYmFw4SCAGQ/4Z3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgstd9R9z39NNeMUTMrH2rcxwMuKoZteiCoJHVTbnTs=;
 b=aYbFMnQfMfogEIP0iIrDYgPx/w1vGtEp6WjAkFSOfIHPzPE5v20+glH6jgNSKpPXndx+48B8qvjCRqM3zC8HYvLNNLnQEm3BF6AEJhKoaYJZj39SxUEqbKIgAQ+ByJQ2dhkTKxJavkFSImNpVp5idRfZ36XoSLzKjokSne7wrKily5Su+kpR6cY7cHoIklEVNqnhOh/U/tvNW0Yr9Y8LvdH3ebLQeFAPZyhDsY4nN4K7LfAeerr7Vir4G2lzXbxPZlRJSxpFgn84X/6hnunkwfNK6Cb5vOHwUXfp8ppVRgif1AA+5FfkPwFFrVbX4NziCZSnojRxeMQVoGheyaT19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgstd9R9z39NNeMUTMrH2rcxwMuKoZteiCoJHVTbnTs=;
 b=VQBg+jD/qvc3qs4KMWYL3f4JjodT+Y61nfVfriWXDl1fL5ZpRqPRc2fISKkGcSMdoCU6RXFM7P9hhfa2GrMBIOl8y2ME0Byil+A0RDON7hlPlmeQbl3j/ReXZ9/edkvau9Byt+q6WjRFsJ0ECwI24z4X6Ue4a3R7gsEgfGsXzL7vPjd+KjBQC0YcyNVmZmdq79+I6bU+8MN8iwyjdX+RaOqe36R+6BttlLhw2J+1l58fUVMWRlToEcHvXOqJ+xlfrxgt0Wqg972T8NP+VDTh+H04KasDTSvbY9xr8DKRLfSJZFY28KgfSjN0r2kQNiHcSs/S4ZcD/w/LKQOJpEz4zA==
Received: from SN7PR04CA0202.namprd04.prod.outlook.com (2603:10b6:806:126::27)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 18:09:18 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::27) by SN7PR04CA0202.outlook.office365.com
 (2603:10b6:806:126::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 18:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 18:09:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 11:08:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Apr 2024 11:08:57 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 11:08:57 -0700
Date: Tue, 30 Apr 2024 11:08:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZjEztwhd5AN1FTCk@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <63414546b1eafdf8032ac1b95ea514da6d206d63.1714451595.git.nicolinc@nvidia.com>
 <20240430163545.GS941030@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430163545.GS941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a0921b-3be5-4154-d728-08dc6940a6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PDa4Xl9OHcZ33uGrS/g8HWFGl5Fo29rsDOAjVfgHF575jza+pcuq/yG6XcRW?=
 =?us-ascii?Q?upuSWl+uJa2Vm8mrJpk8aqKhDoLQxLwDTo5VuX3BHs/YtfBhu2IM74tdjftZ?=
 =?us-ascii?Q?fB1vKdKsTT0pbZnhOeq75B5cFjvri8U7CWxim6nKNZo77FqYYdS2ifU+sfn1?=
 =?us-ascii?Q?2RhyblqqLAotDfpZcGwKJM/VRrdR3mLPnJDJeAVdLRPdMgXHEXmO0Do2evNj?=
 =?us-ascii?Q?YEO0gnTV0UFADc8MWpVNwDxQH7wSaytVFy/4JisUhJxoR7DwnGscoyt/y1wa?=
 =?us-ascii?Q?wecydrqEQxNV64jJGfk3zsFAmmvxgtG1gg60n0F6NFfT6WTDCIbgHYYMYQ7o?=
 =?us-ascii?Q?HDOKJXw8HlranUXVSCxNXVFdZ5K+yNXnbD29cmZfPC6uMnw1ECThrlCQ+gP9?=
 =?us-ascii?Q?wEbWPNK7t9LwYIBl5q5LilSW+6m3UE4pWvN+rtSolMW8x+nBLQLTce2xj7di?=
 =?us-ascii?Q?GB8yfbKQGkW3RpeZuouLVPetnX5ZXybYmildgkkAWSHXyM6CjXpWIGp5ozaJ?=
 =?us-ascii?Q?JRG9i2o5sUSOU9vxN9VqwmSgTKGYXSqiFRJaALVkTvI6slhEzpv1CFb8JTTu?=
 =?us-ascii?Q?hLU4MDf6mYLP0ETfY7ri7ZZWsNsXZE7aXizQuILsRvKC8TN8jYvtPiaRBw4S?=
 =?us-ascii?Q?2WxXh0YW3Zsew1xsiF29kKWaU/XaflqaMq1wdiCcGuxHlGxQavM5DFjF8pc8?=
 =?us-ascii?Q?YmBLji96e4+ZoEm9I5hDiy2iQoSrVky8vLv3Qg+PvMBeZj430zB/vwMVmGq/?=
 =?us-ascii?Q?vZHAAXrx4/i1C/bThnuBj/xdyGaieO14sNtZmz2VlXgati7wfa4ujhg6nKo+?=
 =?us-ascii?Q?e7NI90adzA3JmXXp8XsvKVDoUXDxdvSysqiaJB0/Vuh8Xo+/CY+ADEkvXLh1?=
 =?us-ascii?Q?XYpQAVqkZlF1Rd7eDS7HpHWYuuznVIwHvokbjF9zfdx4G4xdOnm4mlR+Dlod?=
 =?us-ascii?Q?YVWl3HKr6WGHqzp+9zSFOXDR3aRCAUtjOGnxbZdhz28uqlpiND7KA37FGQ8x?=
 =?us-ascii?Q?5rTGD/OgjHjFd0Fzra7xHX4+8eZ2SfVCVqbNc0ZI6g6b2oJ+ehtGraY965pP?=
 =?us-ascii?Q?zQQnrvJZ9lZstDlq6x7o8hxDaPOIqQu9cIWYzY9vTrqJ1KtSVtB0cyS5E9au?=
 =?us-ascii?Q?DTn8NGtPxro0HOMXMBxjydlz3Uh1K85I1ElROWwEoaq1VOGkNjbbxQ1sRZCP?=
 =?us-ascii?Q?VYYqPRqIDUPb+Ej4t0G3w3YSCM0YCx5VpyYaHIIR4AkIjFMst0/lwXSwrBAQ?=
 =?us-ascii?Q?OZ4AODi9qddeiktffrixCut9ws+50Zqms3b590tco9IjfynamkOwdX3GouhP?=
 =?us-ascii?Q?GK85tG5Usr483OTwQdsSO6R04s2Q4BIE6hAdKZaVdtLTRWOxYCW7vr+V2FaH?=
 =?us-ascii?Q?P0VEpkrtdegM0sfV6ReFV+8cjmrH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:09:17.8969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a0921b-3be5-4154-d728-08dc6940a6ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388

(Removing chunks that I simply ack)

On Tue, Apr 30, 2024 at 01:35:45PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 29, 2024 at 09:43:48PM -0700, Nicolin Chen wrote:

> > +/* MMIO helpers */
> > +#define cmdqv_readl(reg) \
> > +	readl(cmdqv->base + TEGRA241_CMDQV_##reg)
> > +#define cmdqv_readl_relaxed(reg) \
> > +	readl_relaxed(cmdqv->base + TEGRA241_CMDQV_##reg)
> > +#define cmdqv_writel(val, reg) \
> > +	writel((val), cmdqv->base + TEGRA241_CMDQV_##reg)
> > +#define cmdqv_writel_relaxed(val, reg) \
> > +	writel_relaxed((val), cmdqv->base + TEGRA241_CMDQV_##reg)
> 
> Please don't hide access to a stack variable in a macro, and I'm not
> keen on the ##reg scheme either - it makes it much harder to search
> for things.

I can pass in cmdqv/vintf/vcmdq pointers, if it would be better.

> Really this all seems like alot of overkill to make a little bit of
> shorthand. It is not so wordy just to type it out:
> 
>   readl(vintf->base + TEGRA241_VINTF_CONFIG) 

vintf_readl(vintf, CONFIG) is much shorter. Doing so reduced the
line breaks at quite a lot places, so overall the driver looks a
lot cleaner to me. It also helps a bit, when I want to debug the
HW configuration flow by adding prints to these helpers. It might
be a personal preference, yet I would still like to have these.

> > +/* Logging helpers */
> > +#define cmdqv_warn(fmt, ...) \
> > +	dev_warn(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
> > +#define cmdqv_err(fmt, ...) \
> > +	dev_err(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
> > +#define cmdqv_info(fmt, ...) \
> > +	dev_info(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
> > +#define cmdqv_dbg(fmt, ...) \
> > +	dev_dbg(cmdqv->dev, "CMDQV: " fmt, ##__VA_ARGS__)
> 
> Really not sure these are necessary, same remark about the stack
> variable.

Same justification. And it simply keeps the same style of prints.
Also, it eases the following vcmdq prints.

I can probably change these logging helpers to inline functions.

> Also cmdqv->dev is the wrong thing to print, this is part of the smmu driver,
> it should print cmdqv->smmu->dev for consistency

Yea. I can drop the dev from the cmdqv structure.

> > +#define vintf_warn(fmt, ...) \
> > +	dev_warn(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> > +#define vintf_err(fmt, ...) \
> > +	dev_err(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> > +#define vintf_info(fmt, ...) \
> > +	dev_info(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> > +#define vintf_dbg(fmt, ...) \
> > +	dev_dbg(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> > +
> > +#define vcmdq_warn(fmt, ...)                                                   \
> > +	({                                                                     \
> > +		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
> > +		if (vintf)                                                     \
> > +			vintf_warn("VCMDQ%u/LVCMDQ%u: " fmt,                   \
> > +				   vcmdq->idx, vcmdq->lidx,                    \
> > +				   ##__VA_ARGS__);                             \
> > +		else                                                           \
> > +			dev_warn(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,           \
> > +				 vcmdq->idx, ##__VA_ARGS__);                   \
> > +	})

> Some of these are barely used, is it worth all these macros??

Only vcmdq_warn isn't called. But I think it would be useful.
I could also find a place to call it, if that's a must.

> > +
> > +/* Configuring and polling helpers */
> > +#define tegra241_cmdqv_write_config(_owner, _OWNER, _regval)                   \
> > +	({                                                                     \
> > +		bool _en = (_regval) & _OWNER##_EN;                            \
> > +		u32 _status;                                                   \
> > +		int _ret;                                                      \
> > +		writel((_regval), _owner->base + TEGRA241_##_OWNER##_CONFIG);  \
> > +		_ret = readl_poll_timeout(                                     \
> > +			_owner->base + TEGRA241_##_OWNER##_STATUS, _status,    \
> > +			_en ? (_regval) & _OWNER##_ENABLED :                   \
> > +			      !((_regval) & _OWNER##_ENABLED),                 \
> > +			1, ARM_SMMU_POLL_TIMEOUT_US);                          \
> > +		if (_ret)                                                      \
> > +			_owner##_err("failed to %sable, STATUS = 0x%08X\n",    \
> > +				     _en ? "en" : "dis", _status);             \
> > +		atomic_set(&_owner->status, _status);                          \
> > +		_ret;                                                          \
> > +	})
> 
> I feel like this could be an actual inline function without the macro
> wrapper with a little fiddling.

It would be unrolled to three mostly identical inline functions:
	tegra241_cmdqv_write_config(cmdqv, regval)
	tegra241_vintf_write_config(vintf, regval)
	tegra241_vcmdq_write_config(vcmdq, regval)

> > +
> > +#define cmdqv_write_config(_regval) \
> > +	tegra241_cmdqv_write_config(cmdqv, CMDQV, _regval)
> > +#define vintf_write_config(_regval) \
> > +	tegra241_cmdqv_write_config(vintf, VINTF, _regval)
> > +#define vcmdq_write_config(_regval) \
> > +	tegra241_cmdqv_write_config(vcmdq, VCMDQ, _regval)
> 
> More hidden access to stack values

Btw, any reason for forbidding this practice? It will break the
build if something goes wrong, which seems to be pretty easy to
catch.

> > +/**
> > + * struct tegra241_cmdqv - CMDQ-V for SMMUv3
> > + * @smmu: SMMUv3 pointer
> > + * @dev: Device pointer
> 
> This should probably be clarified as the device pointer to the ACPI
> companion device

I could drop it and use cmdqv->smmu->dev as your previous remark
suggested.

> > +struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > +{
..
> > +	/* Use SMMU CMDQ if vintfs[0] is uninitialized */
> > +	if (!FIELD_GET(VINTF_ENABLED, atomic_read(&vintf->status)))
> > +		return &smmu->cmdq;
> > +
> > +	/* Use SMMU CMDQ if vintfs[0] has error status */
> > +	if (FIELD_GET(VINTF_STATUS, atomic_read(&vintf->status)))
> > +		return &smmu->cmdq;
> 
> Why atomic_read? The unlocked interaction with
> tegra241_cmdqv_handle_vintf0_error() doesn't seem especially sane IMHO

Race between this get_cmdq() and the isr. Any alternative practice?

> > +static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
> > +{
> > +	u32 gerrorn, gerror;
> > +
> > +	if (vcmdq_write_config(0)) {
> > +		vcmdq_err("GERRORN=0x%X\n", vcmdq_page0_readl_relaxed(GERRORN));
> > +		vcmdq_err("GERROR=0x%X\n", vcmdq_page0_readl_relaxed(GERROR));
> > +		vcmdq_err("CONS=0x%X\n", vcmdq_page0_readl_relaxed(CONS));
> 
> Less prints, include a unique message about why this is being
> printed..

Something must be wrong if disabling VCMDQ fails, so the prints of
error register values would be helpful. And "failed to disable" is
already printed by the vcmdq_write_config() call. I can merge them
into one vcmdq_err call though.

> > +	}
> > +	vcmdq_page0_writel_relaxed(0, PROD);
> > +	vcmdq_page0_writel_relaxed(0, CONS);
> > +	vcmdq_page1_writeq_relaxed(0, BASE);
> > +	vcmdq_page1_writeq_relaxed(0, CONS_INDX_BASE);
> > +
> > +	gerrorn = vcmdq_page0_readl_relaxed(GERRORN);
> > +	gerror = vcmdq_page0_readl_relaxed(GERROR);
> > +	if (gerror != gerrorn) {
> > +		vcmdq_info("Uncleared error detected, resetting\n");
> > +		vcmdq_page0_writel(gerror, GERRORN);
> > +	}
> > +
> > +	vcmdq_dbg("deinited\n");
> > +}
> > +
> > +static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
> > +{
> > +	int ret;
> > +
> > +	/* Configure and enable the vcmdq */
> > +	tegra241_vcmdq_hw_deinit(vcmdq);
> > +
> > +	vcmdq_page1_writeq_relaxed(vcmdq->cmdq.q.q_base, BASE);
> > +
> > +	ret = vcmdq_write_config(VCMDQ_EN);
> > +	if (ret) {
> > +		vcmdq_err("GERRORN=0x%X\n", vcmdq_page0_readl_relaxed(GERRORN));
> > +		vcmdq_err("GERROR=0x%X\n", vcmdq_page0_readl_relaxed(GERROR));
> > +		vcmdq_err("CONS=0x%X\n", vcmdq_page0_readl_relaxed(CONS));
> > +		return ret;
> 
> Same print?

Yea. Here the prints are for a failure when enabling a VCMDQ. Again,
"failed to enable" is already printed by vcmdq_write_config(). I'll
merge three to one call here too.

> > +static void tegra241_vcmdq_free_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
> > +{
> > +	struct tegra241_cmdqv *cmdqv = vcmdq->cmdqv;
> > +	struct arm_smmu_queue *q = &vcmdq->cmdq.q;
> > +	size_t nents = 1 << q->llq.max_n_shift;
> > +
> > +	dmam_free_coherent(cmdqv->smmu->dev, (nents * CMDQ_ENT_DWORDS) << 3,
> > +			   q->base, q->base_dma);
> 
> If we are calling dmam_free, do we really need devm at all?

Hmm. This is a part of SMMU's probe/device_reset(). So, all the
devm calls in cmdqv driver are following the style there, since
the arm-smmu-v3 driver could be rmmod-ed? Though the arm-smmu-v3
driver seems to miss a dmam_free_coherent for its own queues..

> > +tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
> 
> id is a u32. 

Ack.

> It might be clearer to just pass in the struct
> acpi_iort_node *?

Well, it felt quite similar to me, yet acpi_iort_node probably
fits the name better.

> > +{
> > +	struct tegra241_cmdqv *cmdqv;
> > +
> > +	cmdqv = tegra241_cmdqv_find_resource(smmu, id);
> > +	if (!cmdqv)
> > +		return NULL;
> > +
> > +	if (tegra241_cmdqv_probe(cmdqv)) {
> > +		if (cmdqv->irq > 0)
> > +			devm_free_irq(smmu->dev, cmdqv->irq, cmdqv);
> > +		devm_iounmap(smmu->dev, cmdqv->base);
> > +		devm_kfree(smmu->dev, cmdqv);
> > +		return NULL;
> 
> Oh. Please don't use devm at all in this code then, it is not attached
> to a probed driver with the proper scope, devm isn't going to work in
> sensible way.

Mind elaborating "it is not"? This function is called by
arm_smmu_device_acpi_probe and arm_smmu_device_probe.

Thanks for the help!
Nicolin

