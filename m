Return-Path: <linux-kernel+bounces-148873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC258A886C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2621C20CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516261487F0;
	Wed, 17 Apr 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TA+d8DII"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B4148302;
	Wed, 17 Apr 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369899; cv=fail; b=oz3BzdxBLkZxmJskc6q592jQFKkCggXzgSQ9IekxmB+qOe7KYcRwAX52zGQZ/qerNbC/q4paF9hghATz4ObMdmIPi0oVbI9jQO4/ezG+tjeRUphzqUh9o8vWkWoHaH70LHzHXhYrY7zXdK13PvBHRSsnI307seY8r2+MGw6H+/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369899; c=relaxed/simple;
	bh=3QpStp14Zubuwpuh1v0cpJYQdi825pFnuyVr/3OCLMY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlNVBvJLIAu59BVquOGuev8N3jpcTU5MNg4ZR126464LcmNh/YtvYnragzALZ1+30zgrAqczZwv/1AIEa8UOHebl1VP1/Tgj62xSJKuH52A/avlHsnuzyJ1JSBwzjI4aDLOID/1IByEXFYE0SfL6oQfzI8GQlgVCXr/EFVjEoyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TA+d8DII; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH6Ij7uwfPmHf3viH7FY/wPll/J4Ud7q2RFkeJnLYyIKhkcF1luFiFHdgZrnQ2vUy4lFYZefif3U34PsXc3TtvUHWxNoC4IUh32cWnugT/Ug9NoHkIi/Zl6TNKeTyN/GVnfMDVliu936evWfaIMczpsS/c2TB4KbQCJdtsh/O8/xbFn9T1IOJAP9DKABXZlLJdBeB00gNP3WwFysiUD9jx4Cdx6/K9kvV/ybCHyt7zb9pcGxFThwmGZ96VpMvGLrl0RsVl7Mjzd7UAf/LdMrFdTjBQZbfh94P/oUqi4MosoqvFNGvP4NrfBPwb61m1qkBnMSk/YNRym4k09sUtKzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXkbvfxw18aZGwx8uo1EkVljC8dDRPeFp4ddLk8wGz4=;
 b=ApFiW4Zyc/ibhGEizXDrVwi59RGqJ/rc2vOb5uTkqEArs7hls5m5cpikiA4+n6gGJjteYDp5y2oWurbd6wMNpFhbOZ+WB+U/d41dnifeW+pQQSeWTkVUd2RQiphKU630F+MolVOhnEv0Yf5/cNmoXKF6Z2lU+WRdxMDN0XYmzQOTpZ88waLSs1l72K+AvOHvGXh2UYnV7DyAc6Hv3tEqn0hESlC1BKOJ5gjZveHYTd1eKCZiVUuLlydhWXozyTO2ca6gqdWCbxjK0wEL5/lakaPo0oXzp9Z1yRM7Kfl4j1J5vQKLupgh8A9xOTxL3h4OAOHnZQl9F9C7/Erw66P6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXkbvfxw18aZGwx8uo1EkVljC8dDRPeFp4ddLk8wGz4=;
 b=TA+d8DIIshFBBg9gnY8MSo0tfrriF4CjoScNBEz3j35bj0qeMmC9SNScvQ+C2jxw1ROsAQQGR7T0T0sXcgNEjxlCTQulgovkNMhcSqXFFB/smg7c6xGw+9+lcl1GmVdIZNwufG0j7GNTGOYltQNnJG/mr99xMjotXX+N5uHlmq1o1BtjjJwympH03zuB9OdV3AG0MvZ+vdJWZpU5Xe+usNeTq3pFvmprsyzzNwYjy62mkKpAxzCX/JZKmm9pQdS7beg8uU7kFcBC2BeScTTp7aKBnJKr+5ZkdPDzAuT+zqfdysTUDR126x/PEovc538D8xlg9NG2r5bId0iLCBJT0A==
Received: from MN2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:208:1b4::31)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 16:04:51 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::79) by MN2PR15CA0018.outlook.office365.com
 (2603:10b6:208:1b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Wed, 17 Apr 2024 16:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 16:04:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Apr
 2024 09:04:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Apr
 2024 09:04:23 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 09:04:22 -0700
Date: Wed, 17 Apr 2024 09:04:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>, "jonathanh@nvidia.com"
	<jonathanh@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <Zh/zBZoubYvqLQza@Asurada-Nvidia>
References: <cover.1712977210.git.nicolinc@nvidia.com>
 <ee70b82c8268e9a6746486ddcb3e8e7f32f0629f.1712977210.git.nicolinc@nvidia.com>
 <1d68c21591fa4f8497aea0e6a0afda8b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d68c21591fa4f8497aea0e6a0afda8b@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a7f3a0-95fd-4652-42e3-08dc5ef81cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AzPgA1r1CYfY0yeRUL1ica1QtT1F2hjVvXeHnmLMZtEzGtbS64nA2plLne0b?=
 =?us-ascii?Q?/OGHPGNzQ4Z1Z/T/vbyF8MO/Ttnqnu2WPR21u37lWGO7gwUO7GcI0Bs4U+NW?=
 =?us-ascii?Q?LE5zF1v9hSjUkxk8r+rsf0RmpJGZVVjU69Rqw+hQdvEhIjpsOBr3MYMrcsNz?=
 =?us-ascii?Q?go9lzbZdgB84A0IW70Abaqy7xPka8NJHbrdkqCAsuIdwJ3JazaQDp9waJ24b?=
 =?us-ascii?Q?yWVxDEHvvua/UTWNXmDDHlSyFQ/W9AQ9au4n5KMYhhxmTOKdKoEvol3ckoTP?=
 =?us-ascii?Q?wOZD6Jn+8HQsvi+aVztHJN5U3rGkzwWW+Ob1ePCHOeaivgYMWPb4kcH5sqcN?=
 =?us-ascii?Q?419V4lAMTkhG+uRrbRALA1Hi54W8QCt+uvm/3ePXhYzmS8zqGJPXPgQtOWL/?=
 =?us-ascii?Q?+aZ/Gf0UbjzpLq7B7Ks/nHZp5HTNSFqS47ycnov96dN57vwkM/rhn2j/vbwF?=
 =?us-ascii?Q?1hwBKugai++qzz3UzacEpkHEy3bg9e3lQyhVI1/9mAg/IStEzQ4/veN++nHe?=
 =?us-ascii?Q?o9sHAzYMmtQH1pgoWNDZ9pZCvMSMDl03bNaQdMwRfKdU1OcCebvFVGv0tXBs?=
 =?us-ascii?Q?xrgFZxMeHfsWWIoJbNESg2EMGJP8yCOoPQz3c4MCh/LglC0VjzXCwV0tD7Aw?=
 =?us-ascii?Q?BddpxZpWAIk+9vzQDdbZBzDDbSSSskxeNr23tTKGq5LKMVNqOFSPBVGZ2ECp?=
 =?us-ascii?Q?dpVUK+qEDqiihOTU/NyeBeLEhixnJDSa267Vzt2WF4FnVDlTw3+9PZwdM/ct?=
 =?us-ascii?Q?hXD1TazqdY5Sb/Hz8WQuEW2nfXay1C5RZb7tfx9qRbVMCPIxRBhyCsc6tKnx?=
 =?us-ascii?Q?QefyGFrHuOiHrvfTSMCEDj+LYzB3VRTbpz4txYjg2c+8UaScVNM854miRK6C?=
 =?us-ascii?Q?36M/Q4qeyGbkKXAecgzGBU+yGzCWs9AGEPPCj5neXrw/PAG9Xn1e86h9dknA?=
 =?us-ascii?Q?GRmH9j4Rp926Fwkt7H/kzunZao4Tb0X+0bwAuVKdCDSR6wutXU0BYt0jY+T0?=
 =?us-ascii?Q?YSphpfV+mQHjfSKsFLSh0XIEEq8EaLNJLXFxrQYsApWjzcnvB4EJzzeRaoCn?=
 =?us-ascii?Q?AD+8RDyNVPoc+W0i7tvoWNhIIu7KdS9pY5Dd9Y6XGgEBft/0Cd54EHdzBXRR?=
 =?us-ascii?Q?T+2o2Lf4tAM2o7oTpgR3XDnmwb0QC5+JsZ4ZoWWKIQI3QswFYk6Av5Ju3FsX?=
 =?us-ascii?Q?C1G7Bhivnm62ot9p4QTFQH8s843NYOr2GWUGVHodZLKBdy/tzEnU3zY69azO?=
 =?us-ascii?Q?r5hftNADSMpqzO4vxLdpahTgu6S1aC9CdLCWSb6OnBRtehphIBXEz2EqoCNy?=
 =?us-ascii?Q?+EUVx8CpC9EKUgo0IrVLPuyayNeEcmZ4Cq/BpU+9RUhaqXc/WfobZHyiz6ry?=
 =?us-ascii?Q?0Uc1XHM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 16:04:50.6350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a7f3a0-95fd-4652-42e3-08dc5ef81cd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535

On Wed, Apr 17, 2024 at 03:12:57PM +0000, Shameerali Kolothum Thodi wrote:
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, April 13, 2024 4:44 AM
> > To: will@kernel.org; robin.murphy@arm.com
> > Cc: joro@8bytes.org; jgg@nvidia.com; thierry.reding@gmail.com;
> > vdumpa@nvidia.com; jonathanh@nvidia.com; linux-kernel@vger.kernel.org;
> > iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org; linux-
> > tegra@vger.kernel.org
> > Subject: [PATCH v5 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
> > VINTF
> >
> > When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
> > only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
> > add a new helper to scan the input cmds to make sure every single command
> > is supported when selecting a queue.
> >
> > Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
> > guest kernel driver writing it or not, i.e. the hypervisor running in the
> > host OS should wire this bit to zero when trapping a write access to this
> > VINTF_CONFIG register from a guest kernel.
> 
> Just curious, suppose there is a malicious guest with a compromised kernel
> which bypasses the HYP_OWN bit check and issues other commands, does
> the hardware has the capability to detect it and not make the host unstable
> in any way?

Only that specific VINTF/VCMDQ would stop and error an IRQ.

Even a device command (ATC_INV) would be strictly checked
against the Stream ID table that's set at the host level.

Thanks
Nicolin

