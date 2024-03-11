Return-Path: <linux-kernel+bounces-99635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAB878AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45EB1F21298
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85258229;
	Mon, 11 Mar 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cwDXP+cr"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0656B7F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197739; cv=fail; b=DMf7PUwH8XUidUTS1l13/+WhbNG/x559b/tZdLjjWOL7H2YyG+FOK8a7vYbCDdpHzZ8aIyWu9j1zNDq0Bt4ujZ7aDsbQnv0FwaMR0C3oAGM3n57pKmZtS0y6IEtu6SUZrmdQMZip2XCLvwc8xinY63gjniQAuO+ea4H2+Oz3TEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197739; c=relaxed/simple;
	bh=MOmi08FohoizqKclsbWFJEka9On8qhsY94Uv3rlFvDM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLalg26rt5OMO83c0v40VHZsH3jJPUPVGkn8wsV3UlDiNZk0l1GcMtdivZp84Hf/+s1byZ+anEHFd/4QGpbDfj4yvIrNzmvdms0gM2GcvuR5MPmqUFrlbTfhDiCEateAcrvuCPseBhEs72UidxWiX4NdzA9w4R4TkkEdinREfy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cwDXP+cr; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjkNyEyd0NYT9a9AyKszGWQLEZcwcpgSVqH/WKtlIMUiICY4vpO/Fwm/5gFklDDhTisuu5jrbexc3pxhHOwDmP4ILWCGNhN7g2auMDXNjrmmfpUzYcE/0M2kEv1pCcMRUms8CNpLFywzdmRl6oFuQKFkfLYPyHEzDme3S/UjDMd2rnwhm9/clH0VdyBjMgp488IMwFcDZwMBiJDoMGxZpaeK8AzkYcPMgbCwUiW2uSnD+iQoiI36X0FN0YfHQMnlzFCET5LiuHGzS1rko9S+VvREW/W9rLMIsIQCZ/ANevNIhM8OjXKdN5Vp+okMQFFVkd+dwCFeaeyp1UMeoyp+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkIkvtvrwqJYu5VbEyD1WmdlnmbyF6325zXXn0+AR/U=;
 b=nI6x9Lq4DWFWu6vT4PILAIteDz1402iJLet59au/PgTIViV1Gaa/ZLdxfy3fVZ7Fh+GO38XgygkCpJsrKCqqBXM47UUCfdbkwMliu3rQJahrGIuxInhtVTklScN7FBnzEQK5XeZWjNq02cJkZ2IzC9tKKIWN/GL4sO5sggXtrsPnM4qvph2wy9D23Kx1ac5RAy0QZ3TchDiZF8PURSWeWQR2vDy+Uvi1RRD1C1BgQHy3CI56i684+v3XVz2sdO9LUKxN6Eu3COfG8sBH5q6Pvp3fbT6FnUuffEaah4ZuKAqzCoKALKLpgmv5PW4E99Y1AV9oXHrzeiuHGp8WgniJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkIkvtvrwqJYu5VbEyD1WmdlnmbyF6325zXXn0+AR/U=;
 b=cwDXP+crfV5GSTmAEJ4uA6NCv1KAgRo7GkkD0p0B3ZmKNete13+jFwyUXvU8tY84rvzGyYJc+fX+ppiUdfqhUv1nYBhFWP1VGHi2AuMMVWNTaLl2F/SJheE33xpbYhARQ8lrjydtYZ1k3bfM0IZue58ZJpCaHtX4tGFhxHzV9VFd8YYvJkVkmRaOHPHYLqgCGuaoOuQyur4ef2RZZ5k6XquyyhCPBX+REyN3IIEN7kTBXcSugJBUtHzCpEv3QGcSk8hbM9sZKszsssRSjwY9ps8JrRCY+N2rfoPMnj6lBxd8/Ib5Z4CHyHX6mpDN2mP6hNTNotjeiGVGnpqrSsGnGw==
Received: from MN2PR18CA0016.namprd18.prod.outlook.com (2603:10b6:208:23c::21)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 22:55:33 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::b8) by MN2PR18CA0016.outlook.office365.com
 (2603:10b6:208:23c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 22:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 22:55:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 15:55:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 15:55:16 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 15:55:15 -0700
Date: Mon, 11 Mar 2024 15:55:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
	<iommu@lists.linux.dev>, Marek Szyprowski <m.szyprowski@samsung.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 0/6] Fix double allocation in swiotlb_alloc()
Message-ID: <Ze+L0qBdc/+gOCCi@Asurada-Nvidia>
References: <20240308152829.25754-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240308152829.25754-1-will@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: ed200798-3cfe-4c8b-6c28-08dc421e5baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JstOig4Eb5+aK09QHU3cOCCmgKBNa7sa5cTxxH4y7KehfxJ7RMfpukddym+1XrV6Z0T+2dgi0wzklttnXa+aUg1o2TaiZ4V+IK344HiBTPF64XzdvZ1hw9dVnQ9zcGAC5dX7cLXLb8/5C6QZSOBSA0zE86CVUl8zLZzzhKSqevnoSBpMlqCrXlXvfBbwbhXcGyokqUBz/nC04w8SNLYUhhIfPMZQwjtHIb/YKNz8EK2+1YcoIWOJvQo71D96sO3D/0CDgBQYJOfybr1cbS0iA79StOpEf3JktzOc3OydrTZHnyjvM4mIu84RfwxuI88FNpmG4IIuicjMYPp1nw+lvHlhBfLw4VuLvIY4xfeIZ9RQtXQ9USD5ECXjP0Vu7DGoQe5mLWQh9oJ9BypxTsj5fj9dH3jfSX7dnPLLciTE3V4QMyG0nZXpFOm2+hKWH+qYZVShvnfCoT45oapAPKIdNvNwYqlvJ2+9k7zmm0KfiGjDGPH7Ocy3FH039lrf0d/asj/rc+rPL3T4HH9FFCeiZXN1Yp6b+/1I2DJQ6U3B21oOrlzBZPRYG4kk+wVmiLdscYmiJ84yRnUPwGnQkx5hyrYL+m4zGHBjso01kVAlo8x9vfTS27JiazjPA2xqm9JkS61IMLuUrVDRF8FPxkQ07+Vr4MSx0BygGGvlKlbxVIkadkiR8O9N4OVyD1RPuE7MpIsFsi+vSpgfA3+D16VVh5PRaSL6fJ0WPMKTj0L1cTVeRvR5KMwl5Gp1Gbk8BIQB6d+JAJTscxtfhedudUUR9o7a9ThBi0fzXwTqZxFCz9M=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(1800799015)(36860700004)(376005)(32650700005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 22:55:33.2724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed200798-3cfe-4c8b-6c28-08dc421e5baf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132

On Fri, Mar 08, 2024 at 03:28:23PM +0000, Will Deacon wrote:
> Hi again, folks,
> 
> This is version six of the patches which I previously posted at:
> 
> v1: https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org
> v2: https://lore.kernel.org/r/20240131122543.14791-1-will@kernel.org
> v3: https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org
> v4: https://lore.kernel.org/r/20240221113504.7161-1-will@kernel.org
> v5: https://lore.kernel.org/r/20240228133930.15400-1-will@kernel.org
> 
> Changes since v5 include:
> 
>   - Rework the final patch to preserve page-alignment for streaming
>     requests without a DMA alignment mask
> 
>   - Added Reviewed-by tags from Michael
> 
> Cheers,
> 
> Will
> 
> Cc: iommu@lists.linux.dev
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>

Was out of office, so couldn't rerun the test. If it still matters:

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

