Return-Path: <linux-kernel+bounces-143241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F68A3633
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AD1B213F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE3114F9EA;
	Fri, 12 Apr 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WCFiOK7h"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66E14EC60;
	Fri, 12 Apr 2024 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949082; cv=fail; b=NlXnFCQvg76pndKKcJ/YzODE+KP2nVJoqrzFH88EuLJ52rqr8DABdVcWIhYz6wxA/KvMcdxMtiOV9AO956Rz1M/QLUodmy04G331vHYYDpMunByRjm1PcC1lPAXePVH5lyzibjc1vj/XDujFr2TsdM6W/mSOnDZJmpfwZUmtqfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949082; c=relaxed/simple;
	bh=E5Yv3wQaFp3pRZaoaPv2MVi9ypzi3XT67o8s6oitq7k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLw8QLSSDuhaTsHISKtlIrfijwTP3ZutTA3IPhbOkN4UA3ypncHr5QvYjdjVsC31n4GPXCIlj1VUBVjIzB5w5yDdQFtghj91Lba87bKePzd9Shb9tKoRljosxsRegpkYtLwR10JQYm9ICQSKXSkFTmyGdt0S/ICUqBl4wwmm6Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WCFiOK7h; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsuJsQ3LvV6ezZGvC6tk27Uw/5Ko0YMQ6ONU8qklBfRyFGOiprksN5iJQUcP3/Kcooj6tsq/FdOY7HSOXaYbbb7Zan7zQWKnRo+IrPlvu1r1vYBwaBRmkAbmr9JiESieFzI+MN55FBiBn5DLETwf2mHAaIjgs6Xye2PUtAyK8XJAyK3bg2A1bK4F8cxcRPGNJ7Xqc+YJiz8lasIZ3bHsBtWfs1R2MfaFvHhiGDqdcXGKynW2EBU5+jcF3P45sk2GNQbPKLR8QdZ73TrvNZ0Qc4XoF6F7K/O/65uU3/GHzJxXOBYgn2RmCdP066T4gL4dYOXPN89XtuhGRGlslbsTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or7K6ZOiMhlEyUWf6hZSPzhC2L6rhh1iD9iS7Z7tC7Y=;
 b=NclgUlvdoRx51PeTwGMe6bmyuU3UdjDKE/nyAkKzFdx0gZy1RaWLRgeHX+ZOd5LJrA1C0AGurT+tNhwOgX68n7FD+r0ipNKSG3Kg5Dhy32OsKJud4BmpKoDzbMNyNzZO4gUxi4EJvIXDCoROvuRFrwkCxO4zeSFRnTyd2duTORF5XWnqzsjg7I57+Zesm18KG+RVAvP66cOb807F2/iw4IhWp2XP9eVQv+9aErmKcD5/pL0rZt1acs4DOi+cWnXoNT1nGA7ezDXIqVOKe+kG/1StD4yd0QbhRZ+Vizb+MQ3zsHW/tMSlBdzYuy2/5VpmrNBkK6PebAvjsdcE4MU2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or7K6ZOiMhlEyUWf6hZSPzhC2L6rhh1iD9iS7Z7tC7Y=;
 b=WCFiOK7hhoQKlHeU4gUOsjVUe6zF9rmzPldaKWHxNWOrbBYlS4vNr5uIvyN7HO4NG8BepUKEndJDr3MH8bxoo05K+P7QM9vDem62ZcMN4kGoIAkOWD+t0pHq/9ZDTmxMqGVfWAQRaxBawiG7+q2L18JVNXGEQTmBrnFhEDqxEVVI6tjDh28sce2irVS2r9+dqrF2wXoHYfLZVRK5VjCsN8nasfkqDb/ji/l0UZPqU7EV551x2SDIf2xVajtDLp81lWbmApbbleNqm5GaddsvAlPw+nhDhBey66BS4mYEvDL+8QBmX1fDL32+X5z4SseLiKvLr8WccIUtCXk0yOvihA==
Received: from SA0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:130::19)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.48; Fri, 12 Apr
 2024 19:11:16 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::ed) by SA0PR13CA0014.outlook.office365.com
 (2603:10b6:806:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Fri, 12 Apr 2024 19:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 19:11:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 12:10:57 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 12:10:57 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 12 Apr 2024 12:10:56 -0700
Date: Fri, 12 Apr 2024 12:10:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Message-ID: <ZhmHPyV6E/quh1O4@Asurada-Nvidia>
References: <cover.1711690673.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1711690673.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1cd956-78f8-406d-66c7-08dc5b245387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ZSjGxCSxf1YuClIrcnpKaWqf4QN63ACr82/tGOOfqfXCTDA1/tKw5nXgcA3gsAAjzmnadrsU/BzHX4JzaqMIFdGJJ/mMuyTKoMsg+6Jn7L/Qka6nUA/QNQcmWtR4GUd++Va9a6C1+inAsYTqXya0paYk8LYrTvIoIk2K4+A1rBorTzQn9TPlKiXI8Nh7SaFE54bLFoHFdFcWSpKwoOWWb/HBDKgAV6XIadftWXwxTdPp6jT34pr5PRXk4xyfhCp9kjabUNt4gpr/6ClvoOA+wB2JiWh1yMbCRLaEKfqJQAqskCY0OrBQfk4h1A+lYlYfdcnI9/l1KBuQViwH+fjX/mVaoDrkgwGsu83bQrVb+T3SUxj+RIAElWMMP82rC/xXOZsoKJPWQjqqAMmR1WJk7kTTF7GnttWpGDhbUol711nv9cB72vtewgs9GEsuSXc0ChILkaLOxZUhU3QYuwDSN2iMZ/zw7cCKfnCGsRAUjb3XSnAlLgZihv/kMDK8/zkgOme+1vfDTiyGqxAZtUYR2cT4f6BlBX/dYX92IUUAU2CeGsphge5M+YdXmJ2j+EZHD+AWvDjU23b5IqvuN/TnIS1Rr/+VhBbRw2/LcETKXntdCBbiGzBrmeSyv9MMcjmqtQuOlzUCJJ1MGTEvb4RNWx7F9gguP24lAIjLldjAui+xFBsLXgG9T2jCHmlhlTi21QCmBPN6ePqxIN3lf2g92JP36qsADHUZu5l4Wa3fHcHIxdEAlxdncFthtGW+xtgMgW4j8rfklNZHIrNB9yhVA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:11:15.6694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1cd956-78f8-406d-66c7-08dc5b245387
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195

On Thu, Mar 28, 2024 at 11:14:04PM -0700, Nicolin Chen wrote:

> It's available on Github:
> https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v1
> 
> And the part-2 series is currently WIP, with a pair of drafts available:
> https://github.com/nicolinc/linux-nvidia-6.5/commits/iommufd_nesting-vcmdq/
> https://github.com/nicolinc/qemu/commits/wip/iommufd_vcmdq/
> It's planned to send for review after nested SMMU kernel patches.
> 
> Note that this in-kernel support isn't confined to host kernels running
> on Grace-powered servers, but is also used by guest kernels running on
> VMs virtualized on those servers. So, those VMs must install the driver,
> ideally before the part 2 is merged. So, later those servers would only
> need to upgrade their host kernels without bothering the VMs.
> 
> Thank you!
> 
> Changelog
> v4:

In light of its user-space series (RFC) for VIOMMU infrastructure
review, I'll soon post a v5 by reorganizing the driver functions,
so that some of the helpers can be reused by the VIOMMU callbacks.
Most of the updates will be in the driver patch. So all others are
likely the same.

Thanks
Nicolin

