Return-Path: <linux-kernel+bounces-164045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED48B77A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4251F22CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BD172BC9;
	Tue, 30 Apr 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnGaovm3"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920A172BDE;
	Tue, 30 Apr 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485306; cv=fail; b=cn7cDyH10lbdC6kigVKDQQIJ5P0+IKM5jQdxkRP5b88MmSJuTDzkQ6BIhOx58hDsepPrvoX0ZyU4xZJsdwAbcquw0Vb4SV2aN4vl2BbFN95Kb5QcVR1e+SRAr8fQKoyCFMkrgfYliXLNgFm1sn4xeodhGG1xjfXYX1DVSXG835I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485306; c=relaxed/simple;
	bh=J48789P/UiYbmDruGqYUG/0kPnhwNY8SfCD/5STgS+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XSVQPt8V11FRIcesxyD8KGIyqBnpgZRi8nKNHBdnFjHHfuGlj6b7oIaJpTBtZQ8Tr+tF7k5zuzAmnDwbanlE1D0owbOlnTe1PlWkvjsKOTROe1sL3so1D6UpBg7Y02Hsj+CBwvaP/F6L6v6yaMXrZ769fvGgqQxMZFTL5/uWfJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnGaovm3; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi0YswpKbErorRxh2HNhSgW+fCY+7KtGG7kLYDP8OLdBF3X3C/AQrGIMeLqIlAaQpJbbisUwJW4/kf2KSb6t15/5/TahIm7WrKshog1errWJ5nSimYnjU3gUtkjauFSnvMY3NNxR6ieXxUjrPqLvXtkRKVgJrpoev26qoiUWH0k+SLYQ1lLTPxnvyW74FPVAd+muVMUneb2garaK4IQ1paLUa8PA65H8xEa2rUOQ+m1Y2daeuNAnfGcrdrW6l/EDFFTlksY2mdMw/HCkiHS0t5ehvg2KoNDksawOmENkUoZfoSl1yGAx6JRLWWNGNtBQymds9pjBlkeTN2tvPZS/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcxIyifRRMw+Plw9ZqrHZMuNKTIaNyQZS60WkeiFpf0=;
 b=DWvtKErTHVciW/O+O634jcpGY4d6LYhgO3f9t0bf0/LaektOMT+8xWNLxxtU7e1YYYLnTvOehlAgfCPJBj1j+gMuKzhJGFyacexRd845WfYAKn8jZYRjyCyLhUeLrhDP4fB0SYSwsMI16+sG7acoPpbrOnG3J1euvK4ickqOFlSHg0o2ml6MxjNSMFUOf0N3EqHnbzNjeNa6tiWnjafJN+tmpk2pYFqB75bLw8Nfk9rGJ804BwpeyhC1nbjS0a78v870uNFN7FLAY1PdQcaw7EqaY6QGtML6yO7CVt9hvKB4weMgS8US/7bNF63wqsxFIgXnX1VGVzP3Ov8CiUwS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcxIyifRRMw+Plw9ZqrHZMuNKTIaNyQZS60WkeiFpf0=;
 b=EnGaovm3xu2VXOG3iJGXBwRZ0NXHz/EWaRDADH2o+RVogzjYvkaRJfTxCVSuM5Xbz1Eo9MQL9VDbQroHEhuKlm8zpXS+2nDNS8JKIkLImthCTm1OXEoaA1Kfg83xsEG8x7LPtnVsLqiIDT6omIgRGyM/drFGS62Evz7yQVjA5DZstkdZHJ6NvQbFnk/vMfUPmX30WXSkTL6Z5xaNwspiJv6QwAEVD1tiaYvLvCfFQTedvOaSuGFTWHyyodimhk5xf3+EFEkYEIbmrHVu8RUVgQH7qfN/RrB+8z+nyyBn+ASPpv5BHcJJVC6J23cI5dGT/Dulw80PZliLREZUqzZWug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 13:55:00 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 13:55:00 +0000
Date: Tue, 30 Apr 2024 10:54:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 1/6] iommu/arm-smmu-v3: Pass in cmdq pointer to
 arm_smmu_cmdq_issue_cmdlist()
Message-ID: <20240430135458.GO941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <0acb55059f7212abdf4277a81e2f033127072bc9.1714451595.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acb55059f7212abdf4277a81e2f033127072bc9.1714451595.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SA0PR11CA0151.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::6) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: d08aa4b8-de21-44c2-044f-08dc691d20a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cioz7UwRDjZ1mCzlWziN7BTWO8Z6889mxdQvLfJmskY26YqAj8vgtG/IUifh?=
 =?us-ascii?Q?La2QwaWUfOA6+/TQcKN81aB6pv43gmqwn1vNj9D8Noc9N/8OrIaScQTfmRfZ?=
 =?us-ascii?Q?ceMCjMiScxlEMbtnDSEWGqeOJ5FmD+iplv20nJtXXvPQPG/wkdXL5AlKG6zR?=
 =?us-ascii?Q?+WC/YjxgOG8ih6Al/fuMj3fccZhwq/E+GXmuVbE9ZSju8/AdFIul+18VJwhg?=
 =?us-ascii?Q?P+2CQoAx1ozatmr9MECa9RZUtHMlHqmUNnFt3q4FxbKb3bQLf+IL9Vgr7AW5?=
 =?us-ascii?Q?YMyXpaJgGpHqeg2N3oa1GgEL0y7/LDcU2s+ShLyLBdWOh7hQTNnIG5gyx6s3?=
 =?us-ascii?Q?TezZ2WFBqJtpH3fqlbJ5Y2phR/f+plGEjhLcS/0uJWD0/FuCZh2IN8uAL72E?=
 =?us-ascii?Q?YL+WcEDdghb1x2TmzJGEDTnRYdooz2ySX7VaQ8IT8abhSgmJVLEpHRUl2Czs?=
 =?us-ascii?Q?3mjaIhWOB1rYU38IyqNJZIgmhi3a7LfptXdr9+g6RqXheMR7Y1TPR2jc/+AE?=
 =?us-ascii?Q?hPRtPyA5pwy+ICxxSBFf33n3Mzm2zIe552RpghOZ5CRWnIxHi2gHapdCdeYC?=
 =?us-ascii?Q?9qc4ZSynNS+DQjbFmUutXE4a5oRnCslySqdcgHE8Gu+g4W15UcO6OCwQOtIi?=
 =?us-ascii?Q?b1yfN2DuD+mQVE0yMXL5NwzNuS5JtQyOd4lkcLEGQgZjRO2ckMCnHFmpWUTd?=
 =?us-ascii?Q?KeHG+3mYYzoNQLH8EmnBu3Q7uytfnoLcKFJD1vdlY4kRQNo3f7MHeUIvKXGu?=
 =?us-ascii?Q?nyeMGiqcYgAHU3oLau0DkYCmFtvweRPjSG34VvEW7S7QlB9CoWb+50Fmsgy/?=
 =?us-ascii?Q?xooltbxNi9Swczl9sn/TFCxao8U3LAiQD9A+Ywsvg/nkYZ1mzTYPEiSWn95W?=
 =?us-ascii?Q?Oe4slZWrMUjt6BKqbPQfC4OUkKOjvkW8JXvYPjwHO4OYwou7li8+6F/3rT8k?=
 =?us-ascii?Q?oJp/BfLkpvRSas6CprWPFeZ/LzrMcfIWnQf2cdwGJhOaGxAE85vTRuZlq24M?=
 =?us-ascii?Q?wlmjHhDOKmza8tzvxSawbdi5JsHBhRxEqHbbuGE0xnf1vl7CA8rLqn8lVCks?=
 =?us-ascii?Q?q+qm+KzSGAlF7wdK8PQzoZs2rjFDr8RqI0Qq+HMbsfzrSSrUW63jg0LQda7J?=
 =?us-ascii?Q?RyVonIsN4V6lOPIcyu1wtbAOMl/T7qvJa6qa4SWTMI0meVydQZxPefFyxvxR?=
 =?us-ascii?Q?izPeLhIqSZI0ERBS0BakTorh4pcu6NENfWo7dHQY5Nc7o8GNQ7+KiUPrjdu2?=
 =?us-ascii?Q?+zg8Kza2Vh7AJDKwrJQukDXVeg1mmj4M4CHpQXTYQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jazuUsGmwZH0ijnMKwFKRiNcYIKPvWsHW8KgeGRP/t8R6qCf2Z/qhPcF7luX?=
 =?us-ascii?Q?nXAcXf1BSf42E9eAgxLU9Q5s/5sD3ag7q6cpqb6S6phv7+DrrESPq9XA7crv?=
 =?us-ascii?Q?zvyVma7J1ajHQ+EkNMAx01s3IGz/+SxtxgadEiMg+RnM/AnUxEu8rDVG9n4N?=
 =?us-ascii?Q?cXzIij53APJ0aGWoD+djZiwzoL3Ms1bScshidubzNbKqugAF10EDI7oDIHkp?=
 =?us-ascii?Q?UVN8fy5vryx3mWvQd6ykl3h12ptemW3b/8rM9RlAwEB40RFQxqvVLNQ9tZPW?=
 =?us-ascii?Q?Tp1dbD+D7Z/NxyBJE8uLCY98/tQvEwV0uN0UgNduKuvIIm8wlVc3Te37K6e4?=
 =?us-ascii?Q?qdgnfaFNsqt5DzT7/uPZAsn6JgKYMr6dqeumQbyLCyd5sxkdTa9aXpIhk7b4?=
 =?us-ascii?Q?AZAMgjzmu760+tdM+NhEbU5bXetoUz4PQZzNtvjmjiQtgRNjnqF74/1HLVQl?=
 =?us-ascii?Q?CKh0dz2CSI0+Qq3ctt6mEFiTqkVERsspcdIusGsHY4ISV448FJIVk2YqcKpZ?=
 =?us-ascii?Q?pHmBVFg9k4g6bizMKkszEq2Nomps9fkzipU5KsCsmNpUfFflUAlbYnlzV5H8?=
 =?us-ascii?Q?SZ00vc6EqYALJmslDxL+I8vD+7yDlJ0ICop2e9oAKNvkCxwctn5vI/eXMQ3h?=
 =?us-ascii?Q?Pk96OHQuTMO6Jvf9LNrdEfTEZKP3ZFYpQK4Dyn07/hmMOOymhBLl86IzpXJq?=
 =?us-ascii?Q?90GbghLd4aLMAKtnRaebywb4LFudEFl7OSfNYphLYR60Fm/+OQmJTJuLLpiB?=
 =?us-ascii?Q?NTiuCLQxPErEo2YWwYadugkbLBMjTnRy7538samlnT2o9TfCiKnB7mtmxZIc?=
 =?us-ascii?Q?+isbCuMQcrG/jtS83GuzO0SVem6vBUcNZZovX3bdK3kSwrqinpPRALegyAYa?=
 =?us-ascii?Q?yR13ZaAabRGGEhYNtTFRsu0xvtaxPgGQR2LRKHLTqlOSH+DwG6v+4NY7QQQu?=
 =?us-ascii?Q?rptcbdCxnQcm31ykk+JHVU29wS+zRK3bdetpoCTk0EfkU5zrnWkj21KE/P13?=
 =?us-ascii?Q?wyIT1vqzZ7+64a248OJefkq1Y5fbKl8uyUMZ6zs5lo9qswqDTjc1JVNGl5S1?=
 =?us-ascii?Q?jdsgcy5D6TKx3cbvV0GU/j16f6PJ0KzFmxM9+wy9s6wZ6PBMrc5l61UWrJxB?=
 =?us-ascii?Q?xlcZnePx0hP3UtZw1SAMckMe0GvdC6zUGYPk9CDyQ7Flw2zeBOLaA4k83ZS3?=
 =?us-ascii?Q?s11iHi4NbOSxXwupMDQD2JIBeA10AcfGMeWhW7ZvNSjoHN56QQRuPM6GJGbj?=
 =?us-ascii?Q?zryhXSwfZ9Eu/Vosw3Udtk11bQ/MbnXWcJTrGKXI4QkHbSIYG3F0WtObzESU?=
 =?us-ascii?Q?eoed4Xq2EBB0OhzcgFy0upKceQIQdFmHVoNP5ft9agnsIYRN5n+5ASNbWUDU?=
 =?us-ascii?Q?+3kE96g1et40oEosTTuMtdDWnGqWjJp4ooeT43jOQLnAyp0ynEjKFXo2VFtw?=
 =?us-ascii?Q?VM3jse1chlP5MHLn/EXoPeDsA/6cVrwEjKeLUJ5nFH1bd84yRTn5Bxoe9prv?=
 =?us-ascii?Q?fjrZuGfx1mPdoKt1ZgvXqzfIAeDsfflPVeclFsqd18vOtlom2IZCmU+kKg6l?=
 =?us-ascii?Q?+AB8QrXsJWwt5cjm0bcHQU9FYe64JjQfx8CgcG0g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08aa4b8-de21-44c2-044f-08dc691d20a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:55:00.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQB10nCy5pK/wzIJY0X92A7aP1rM6bmmPEukNshMFZjYMBOCF27h/+dzsDCfsQQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169

On Mon, Apr 29, 2024 at 09:43:44PM -0700, Nicolin Chen wrote:
> The driver currently calls arm_smmu_get_cmdq() helper in different places,
> although they are all called from the arm_smmu_cmdq_issue_cmdlist().
> 
> Allow to pass in the cmdq pointer, instead of calling arm_smmu_get_cmdq()
> every time.
> 
> This will also help CMDQV extension in NVIDIA Tegra241 SoC, as its driver
> will maintain its own cmdq pointers, then need to redirect arm_smmu->cmdq
> to one of its vcmdqs upon seeing a supported command.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

