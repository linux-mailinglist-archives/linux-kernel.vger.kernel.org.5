Return-Path: <linux-kernel+bounces-79068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F676861D13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531191C24CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607014535F;
	Fri, 23 Feb 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHR3zGxd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872114532B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718312; cv=fail; b=Sc5sVZF27aIO3VqIpbo1EXEt15DnvyROTSMDm6a1dH/UEtr7F8dyy+MB7LUOu+1oUEPTiWqKVF069EaFUiAPQzf1HXT0Wn6YLzMyMolgVgT8ye+f/7VIQBMOqeYc/4yKnVkgFTBchMde6JvUGuTvuQojR7Nj32+xD7F9S6y4IPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718312; c=relaxed/simple;
	bh=i8wABGqt94IYV7+DvUp5bmYJq5nFpPgsHQVimhgmaUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZd98cVrUNSlx1bYkQR/JdlZi+fgyXqAWhAtL0JeI32rYMWib/xwm2rXTQxarNJj7OAxibKAz7N/Osl1fSuxbi5UDCoEb6jz6skK/GYasNpBmWOhktiPqMzEzjZ19Hesq95Qpq/5NkU9sZRKrUqLVa7PdoE64U/gkcA8HJAzxDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHR3zGxd; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APDHscDBb4N/dYuFwVyVfx7X3QXzkM+P94+FTwBsvKI2+TPIrH+JK7TAZH30LaQCzDY8ng4Diz/7u2+/bGTMEjK6xBhl4Z2JlX9+JNimuFDvbyALe+uqjadJ3115uOUPbx86yWXy0J7llZCWGWxWVf9gZB8QBqIWM8LjZPc5Zv+jB7BAv1eiS4VzGZyV+7r4SQ++fXLywZNONzZ7ryPnzr5/t5ZFXzrgxFYBWTf86RgGeeh93O2koiFow5MZTBcCmkOgjtfaKTrpM7FwCkcZxkeHds5CKz4UadrOZhnW+MiSV2a4ISQcG6cBqYeVY33e+DOVftZl2EOal0r12wR9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+DGRMHVhOX8b88OUvriafsTJVVfSqF+SQd6Ai3GK+4=;
 b=aFULXkgIBGQoBHKuPSTF8jQC0HbgWOtpdovtNdxwS22l7cndcvpD23SQygLps13JWgqrWjt4dmOEBoKfEK16jtpzrm31zQ1ZCQjDfBNXpLIhWzTqbLDp9EhKnEUodMOc8Hq/qv5VW/c92Tdl/SCPkRP3Gs2wzqUcvKv4ucSnAHYUMTCxd7eQanu1Jb8ZdXKdcbgf1aDYZnUjIksg9ULbQdUWXi/xoVyrBqgtnstie+ovapHftCOkmkrkEA6kppEZuha13IyKzN7fLUheXveFtpt51E2zuiZySrysggfQZ4b7l6D28OntmrrAymOvSNM/6hyWG8nTinnxZsnJRc/aJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+DGRMHVhOX8b88OUvriafsTJVVfSqF+SQd6Ai3GK+4=;
 b=FHR3zGxdvwiTQx7KXKtKTxx5qXgXVRYChzIsQ06fV4Tts9MUBYhiTZ8Ud8EIWjFgS0/KuA8xcIGaFz5HAXXzc6OmmKlFP/yXvX+AJfeyg04DYamRLv2pGW9V6u8U3Ykwz4NJkGTZ/sC5mG0+gZmoEuGLcS3NIO3FFfYNe3AAr/XzKiAdlqIPcFggm6pF7OtJpreq9M7T6bkr1GeFG/9WD8ehsXXDbuqdvuFZ6eGHs0AXHznlLJXOEqOUD65rhJLV4T+oqXV7e83GIanvgU1wNMln5NIpML4fs/rPEZ9NNCQoGpM1cJ6IwWI1Pr3DpF4yDA7V31Q9liMdsxDv8JReqg==
Received: from BN0PR04CA0159.namprd04.prod.outlook.com (2603:10b6:408:eb::14)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 19:58:27 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::2a) by BN0PR04CA0159.outlook.office365.com
 (2603:10b6:408:eb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 19:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 19:58:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 23 Feb
 2024 11:58:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 23 Feb
 2024 11:58:05 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 23 Feb 2024 11:58:05 -0800
Date: Fri, 23 Feb 2024 11:58:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Michael Kelley <mhklinux@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Message-ID: <Zdj4y7nqF2LHq2IH@Asurada-Nvidia>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
 <SN6PR02MB4157828120FB7D3408CEC991D4572@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157828120FB7D3408CEC991D4572@SN6PR02MB4157.namprd02.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 7303f021-d8d1-482f-c5aa-08dc34a9cce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ReX421XnTV8BrPA4AK9eB+uKGr0Y8hcvL21DUqiMigjifGDOhX1twf/JiELs120LIrpvZ8kbYuH6o/0nRcNWjW/CwPSWa6YBNTqm1FaGAtqgylc7oxBtUBs+QwpfWyL8x8j+qGEDzw9zHJ7vPbehNubkIfYMzId6WVkVE68PGUEpnb7xZ+AwFbGQeJR0ZcQi6lzEGC9rM4Zqd2Uz7k9msenT+RPdBAzMMaspJrW31by6Do7UUTL2oRDm7wfAWp8zgfs0968cgQGHGN7EVR+vBOowk2ZeRJ8TUp76Ou6ap+sYxJKlGrZirz2mTIBdgHP0dngHTA3E+TWHJyPKRLAZLSN/laou5I9G/59UKA2lT89GcVqUx6Hm7qzhweCre3FMhwyb2mhvzUWGa8DO3VBMXUtC6o8SUIxwd9yVoMKqy4CFZjRmtYsuSmAqSGt1peJl3XaH+hIspZgHXfcube+HbMizlzjBskaW/3ISLsc8d4/IwenKJda0J3uxPE9EeM7ZEBS1jy4QxynfIyU/5Bl6QjeW/yO85ygiOnH26IbW14qR9leaIgZXL358ng4uK5x4MBkrogv9bhAxQKMvVVdjPBJNSa5Qk0MFWuJpBcVk28xDHg6N7ydchyymJfwIPxEzw6rCHGFGs6TmhOlt6CPokGlDCYgdiHpNUfOxSd4ofea6/T9YYOrPua8HeCf+5xEV69BBMSRJo9g0eCbOF9idrpO+EFBAP6wMjX0lycrEnv0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(32650700005)(36860700004)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:58:26.8461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7303f021-d8d1-482f-c5aa-08dc34a9cce4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

On Wed, Feb 21, 2024 at 11:39:29PM +0000, Michael Kelley wrote:
> From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024 3:35 AM
> > +static size_t iommu_dma_max_mapping_size(struct device *dev)
> > +{
> > +     if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
> > +             return swiotlb_max_mapping_size(dev);
> > +     return SIZE_MAX;
> > +}
> > +
> 
> In this [1] email, Nicolin had a version of this function that incorporated
> the IOMMU granule.  For granules bigger than 4K, I think that's needed
> so that when IOMMU code sets the swiotlb alloc_align_mask to the
> IOMMU granule - 1, the larger offset plus the size won't exceed the
> max number of slots.  swiotlb_max_mapping_size() by itself may
> return a value that's too big when alloc_align_mask is used.
> 
> Michael
> 
> [1] https://lore.kernel.org/linux-iommu/SN6PR02MB415727E61B5295C259CCB268D4512@SN6PR02MB4157.namprd02.prod.outlook.com/T/#m14dd359c5a4dd13e6cb0c35cf94f8d746257ae48

Yea, I just confirmed that with 64KB PAGE_SIZE the alloc_size
can be over swiotlb_max_mapping_size, i.e. 256KB > 252KB. Yet,
the max size corresponding to the max number of slots should
be 256KB. So, I feel that this is marginally safe?

With that being said, there seems to be a 4KB size waste, due
to aligning with the iommu_domain granule, in this particular
alloc_size=256KB case?

On the other hand, if swiotlb_max_mapping_size was subtracted
by 64KB (granule=64KB), i.e. alloc_size=192KB, which seems to
generate more swiotlb fragments?

Thanks
Nicolin

