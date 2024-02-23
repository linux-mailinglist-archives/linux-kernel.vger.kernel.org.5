Return-Path: <linux-kernel+bounces-78227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA086107B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E1F1C21397
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5C6166C;
	Fri, 23 Feb 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JX3dDn02"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1B76C83
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688120; cv=fail; b=MQhmpWaQU61OmquT77o7uBYy4hXF2rmKm+GqAKRJD+HMpHMTIS7Zyo2od8HuID3T/usS+ApCzhEt9+UmB4E7YlJUktSJfpNGxigUrQkp2cXqLKgJDqJq3khScDX0FslHSH+zWQp8nGlZw3hJp+Khz6rMVHN8+jWWgct5iI2LNQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688120; c=relaxed/simple;
	bh=Wafc+tcwdz5erezhF2gq5I+swaLhLWWEXxUHFMQwFv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh6Odp811kEDNcUO3DlE3pAePkxbK8VMwwLjZy4cNj1jGHunuzOP6a2m3NUscJt/TxATDjHvz8hMY96S3yNj62PXs6MceXDlCOV9UmYPf+PM+t1SyUnXErHdgxpY9bzoOqhQS29AkGks6E3Tw0k48YOITpgqZmBx9+li6gvBxaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JX3dDn02; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXiCCWLuU5yGTixRQyG5KUGRP4f69klbBIUcXwEonae8SSZNHbLagjwayngCkX5y7OIFPVwQDYCg/86YuDGGTvRdj8G9RvjMyWz40AhQryC4jN7zbXOhJalnIEExOt8pvDaSubAku1ZsHtmokE23R2TknAXuQ10HZK/BTLmP+w8G+hd0lW1+03Dm1cPmqcj18/rIxKK5XIDZTMCi3kZ6bds6k9htltF07guJQmsW3Fxi8P3vaNlPnxL6tGPSID243QTV9m/lJcVg/oxl0MY2n19L9875Nq5NKLEOrOHtOrT0p/ScdgVvkG7zO/skp5dPZKkRw+k/QfNzmUtRy8MLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRmU7pD5AxbiVa47px6OHcPyL9go9Vf7q3vfSTdG7pU=;
 b=kFNnxqglCyfX42+dSaEnm7mfr5VE5SxNpU29sMQO2qJJUuay3mfyOKfYBkj/BXoEds0dEn6SObys6Y4TuAGeEDAk7hSF0NKDUlabPgZgQ/qAIify9lN+iEj4hnF4LBHrqDxGLbxCSOz8ZBKkDV9YVe5ltu+Ntrr9bejQL01RZazqO43Tf+of597Re3jx6lCiQHvzr4tAqcOslWXeZk61wa3iftCBviRWoSbOMsBr3U1l1ba1avmVEsBotRtStrtsbk5vCvTDy85mQgQx+YHiWaT0YuIGr94/vtWTxWdIT91SwhKV69lKkb2ADKCdaSpoqNzDUd3DQUHxys8ZGHb0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRmU7pD5AxbiVa47px6OHcPyL9go9Vf7q3vfSTdG7pU=;
 b=JX3dDn02HeB67dv9+75us7XYGBiwQz5puPCmzpQVm8T7wTv8yiXRSCfDRin3PdI4A0wPj0I6F0NrPeQ/GRBTd6//0lBTXW9FnDdifhgQdCnqy4a7wDJ+qV9B2/XMvPaAan8fEpAVWBPb0NmEIxNuRHgYosR74Vop3wnw+8v1myWv71NT0S3mW1exr1h16TPUaRTY3LjNd1zn63DsJ9RXRiI74LSY5INX9Lv49sVrLzctsOjci8AYJ+t04iIa+CdK5vbdi5ZgiSyRrEYKF7Hpbd2odXGfbuP1RnzITT6SgW6Pi/z3bwaVK8A/F95Tej2w1HAo3qmJU+SGuMO9JnCm8A==
Received: from SN7PR04CA0071.namprd04.prod.outlook.com (2603:10b6:806:121::16)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 11:35:16 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::71) by SN7PR04CA0071.outlook.office365.com
 (2603:10b6:806:121::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 11:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 11:35:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 23 Feb
 2024 03:34:58 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 23 Feb
 2024 03:34:58 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 23 Feb 2024 03:34:57 -0800
Date: Fri, 23 Feb 2024 03:34:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
	<iommu@lists.linux.dev>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 0/5] Fix double allocation in swiotlb_alloc()
Message-ID: <ZdiC4OpEMQHQjEtv@Asurada-Nvidia>
References: <20240221113504.7161-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221113504.7161-1-will@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: be7135ec-a052-461e-6a72-08dc3463816a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2zzWfX+MOi/uReqVFGvh8b0zeNpgbS6uq04YdEr52D8upxgfoVLk2xXNHCT5FEKHdt0FCTHgR9nzDzhkwjoLA0iHFSuVELebd745ahSOJBR2TA+PWuPU6BbDSQ0d+aBnm1NRx99lVacUuauunulhGRBrbOT7ilckD550htfIgOWwaIyUo9C4wn4CyeCtBNxXM2UE5BgUtCjFQBavTdr6yNAGFEH6/lzxgNyXkFEIqTt9CvDkeb0TIIqdj2XSVZjTx8zoVHfksMTwWzsgY6GjL2uQrM9BuDf68XWaougZW/y3/shlvOXjPnKTB0xsNpf7QOg/PvCBkR9LD2f3MK+fpCLHqX1b16OFSM99DcgxsUZIKp/BBjtwXrhPnNWvXur8DH4cLsmfXxGqQKXEh6X5T+Lo23jAHt7NLyEe5L/Q5qyMFAts+CyGNbwssGKxq7scpOr4gbX+t+td0iVx3KF8E15U7DKUsIWTVgiRj8UzbbiVk6wUfHa6wXddwoKLkz+OnzjMjmyKWI+0mtMMwwDAHFl8Y0yl/+owoP2w6Q0G/R+vbHStjudyEIPG4zdvkBkXLcFKedb18wp1insz6r6xcWllZ6zUdlDY/iB+vFvx9Xr2Jgr0bwEKAFrc/kuOhgutas5DJkUaLtIGpfXIS7jeGXfuP8APjZ3bgDqHR4bTjXpUGUWSZIED0owxDEJP8J9Cybl+1xVtq67wVKmayQu4nD5JePsNmZGzehugYeEqSbs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(230273577357003)(32650700005)(36860700004)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 11:35:15.5065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7135ec-a052-461e-6a72-08dc3463816a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634

On Wed, Feb 21, 2024 at 11:34:59AM +0000, Will Deacon wrote:
> Hi again, folks,
> 
> This is version four of the patches which I previously posted at:
> 
> v1: https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org
> v2: https://lore.kernel.org/r/20240131122543.14791-1-will@kernel.org
> v3: https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org
> 
> Thanks to Petr for his Reviewed-by tag on the first three.
> 
> Changes since v3 include:
> 
>   - Use umax() instead of max() to fix a build warning if the first
>     patch is applied to older kernels which warn on signedness
>     mismatches.
> 
>   - Add two new patches to the end of the series to resolve some
>     additional issues with NVME and 64KiB pages, reported by Nicolin.
>     I've added them to this series, as the first three patches make it
>     easier to fix this problem in the SWIOTLB code.
> 
>   - Add Reviewed-by tags from Petr
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

This fixes the bug with NVME on arm64/SMMU when PAGE_SIZE=64KiB.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!

