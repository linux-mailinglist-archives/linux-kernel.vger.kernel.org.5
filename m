Return-Path: <linux-kernel+bounces-90622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E4A87025A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E0E281540
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482693FB1D;
	Mon,  4 Mar 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Md6xUEq0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B23F9F4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557840; cv=fail; b=L4mA9t9aYndPvymq/Bm1r8g2JJQn0NijgI/EK2j0xjIMtV6ojN4UIJjI6vlTpJzmdImcrtK0qVkXnp+++D2f2Dndc04UstKmwRRQrZ7DIdu2EW8ibt97XK7kvTs5mmBXO/DAgvVS8IrK2WyFO2dRCbzUZXQ9QOLOa8eqEUaywpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557840; c=relaxed/simple;
	bh=GVe8esTujzziImLi8UrmDbY7MASWrbhnML+nRW9NBz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HLWuvbTB9BqBrmlGkwJ29K5fFKbCb9eV9/Yl5rGFbcBT+eH9CZQyfIZ9Ns7iqEZMIU8Il6no2K0YpNvkbTZ9OW9UmEGwEyXegDzw2JTk2IlM8+1aqW6PtBeoZCg23ZB3JBtmgJafY6nonwbTh5IIkVqypWKcUTQwR/Epc068m0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Md6xUEq0; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y07ilV7Cp03dwUkRYooWgkCVk6DsK4EiTAZ7HtM7uJXqkiC1YsjrZsyNRzNkcjKAhAkFRLBWiwy6a4YTJtHm6iUusqX8p93iNu3XyAaK7A6WtBm9rAoDrmNzDAYFo665Djoa/InASKfaO8wcd4J9fdixQn1Md+2DDOejuAudchJBTup+ma4ivrAgCY819D2DvIN7YgeK1++0y1/Ip6UXYzr+LsaDqzEwCgCV5FlPQ0/dqSfFydg2oAkrB+chJUlnD0U5mLNtWIlzUM0+wODFs3JWP7Iyi4U7uz13mUizYOMcOauPrCIoOwXtyZ4LxQKquROTS3WpfBfZKaUKt5o43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5rNV9EyIvhZ382muK0IM27yTk/CEVCsOJII29fdSbo=;
 b=myIBpgwsbcyf+GzyJmSXNE+darBp7MmZ/YpF9R2utBeVPysu5BDikN13RYkAQPVUiXVnfjoUfwg5i69m3ZaeSmWyZqO/wnjUs+dsbrq3dRjUUfqh/ozreQZKcYABhaMs+nX2weiobbeNFtMi09zii8jpkQhxqghLDjBT6f8L0j0DrG8NHbzUUtIe5CdlNK35QXI4rAVIK4WKEmZaW5VWaxVj2Kbsq1Wdo9FX7PeD94zvO4kDPM7OmJ2ba/kDEwwCupht1wRJagT5d1GSkX/4nmXghdxQ7ktIDo/JJZhpqYYs7X5nyTIitN2FZFUJLsh+GGykGgBYuIE3fc1eRpGLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5rNV9EyIvhZ382muK0IM27yTk/CEVCsOJII29fdSbo=;
 b=Md6xUEq0wlonPKhwHRZz+CER7oNPvNqOCo4EZ1nAj3iw4wcrxT1QQPfOPO4WEdNBHoumTUDcJLF9h3QzjLBIpEtVxkMjTg4ke/XT0MI046l097J6l/Qq3ZTiNp2Ee4+bx31a+XsYkB0v4CVC/Qfu5nmy4aoCY04OJ1ASIsjw4nJp4lI2o0GK+aqxluoRQbKetsU3QbES/67RDjmpzAvEpfUiDu0JviBOhoXcXkBebn3gsIv3ZzlrjAn0rZJvwlE0CFosVAXR2sC5CyEYrGiKAmeO4dXXSNRXX2DXqlSc8nuHmRiVOhGTteHWBdcOsOeodZhU3wV0tmiZI5uuaI3vXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 13:10:33 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:10:33 +0000
Date: Mon, 4 Mar 2024 09:10:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [PATCH v2 7/7] mm/treewide: Drop pXd_large()
Message-ID: <20240304131031.GU9179@nvidia.com>
References: <20240229084258.599774-1-peterx@redhat.com>
 <20240229084258.599774-8-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229084258.599774-8-peterx@redhat.com>
X-ClientProxiedBy: SA0PR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:806:d0::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ed7d36-0f8b-4a9d-2e7d-08dc3c4c7937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZbNlEjS72xL1ABOxRMkvc2OR+Rxx2MGvXl7z0nhSWvyPPYj+UDxL8maLj1ITfL9nCLmHzvNQpzKALqNUuUibv61Z6ffTjEtSkxxu56JoaQwF3pzIb+BqH9A+1JPpvxcrMOdIfOX8ulxZzYd+PGfE6Z2gFXjGpefP7SnFLFkRlb7/GRI4nBDqcTfc0vNveUv8yMCAw1imsKooVPRPNHMf8Yt6vWDWH2bqTNPsmeqrfbvdf35DA1PWC51fEZMNe3Ui1kvgBSnsDineGIxruhdKbG7Zt92IncG1ikkFCtueajGSCIBZGCJkRDxxSvfXrxQu0SfTFQVsLyjXgIA2NFz+LPHXRw6ahdaIDfIJr26M6EAN3cLzfEWSg4brdZ6TOR8qD2M19hIxDTfCURCAMS6FvJWQyZoKyn1o9fF/6lDo70WeCVjecMEg2Ft3DZhTUy6m/txFepd2U5zJkhFSQ0OZ1z5AcraLrXkeTQ3jeXfM1pxS2ICFP9O0k4wRkSDDyR6xiYjpxoBcXjLzPm+JNMBhP9/RG2kn8sht1Nzd5LzQwIjLSTZobGfWErWBb5QioML6y18qY0BWpBHcVg+AucOnT42SAab9xqEfofLy/UeqM2gqymQ8TqHm4KOzObgVnNSnmdI/HG1+6ojEX8lK2RQRufuXMs9BOKwYU9Gk8BEWudY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6XuJF7ahQi5aCx+/Lr+UDakxD3FQ9zDJREbDs8LcTJuL0nIaX6XuwjFcz4X?=
 =?us-ascii?Q?cPT3HMUrp0VV9vpQpqgG7i5dS5t1laUCmriS5IZru4iDLs690rX146kmXWbk?=
 =?us-ascii?Q?XN+7MJMm0s/7zE9wUimosUcfLI67RwGfgOPIfODbneZQkTtHUdR0DK2/0rh4?=
 =?us-ascii?Q?c2AH8E+pud8vOJShiliPbf356IS0O8Yza7izJhRDmnFXkLykoitowy59ZKOc?=
 =?us-ascii?Q?zeZLl/03wLXWhPJBp8mKvF7z1g6ibQZ+hnUsk23mUyl8n4b2Vv9MFtO7SWBm?=
 =?us-ascii?Q?c1eRWR9b/g/hFcPtJz9eDnP+xvWcq1KNjptFpNmVALvXAcHpdvBOv/n2ojuZ?=
 =?us-ascii?Q?OzAnlfHBnj3sJY+rDNjwLJM9LeNKgz7eaG02PCP7p4wb1z9ivMDmc6kAGPvC?=
 =?us-ascii?Q?ZZA1eklzmy/rOIjXQd7hF/WuvDHgsRKaSOVThjZ2TFWkjDrSaPUPAMTAiP17?=
 =?us-ascii?Q?mRpdS398cdVtA3FYF3Aygy7KvPBWf3rX0qptkgzm+8ap5BIqmqVQywEjFOP7?=
 =?us-ascii?Q?cls6anTH7I7rDROHMuwJ0IDaMPF29vr4cNhV70SkmV6vV826R6kte0ir3WGe?=
 =?us-ascii?Q?3Zpu8ZyF9016PGW58j4Z+GQLACy/V1ER0cgwoz8V/2h/G+UbYfnDEwITQ3oV?=
 =?us-ascii?Q?5+Qch7I9VfwHFG68DfgWjNt+EUzW40vPsm1gbHIIjcsQu5EgPp1N8R0jg6Om?=
 =?us-ascii?Q?561m8zXzYxurO18VRN7iL+nZj3i2TyNRwOaxOkhNOSbNhHTjf5H4+JMj6ZH8?=
 =?us-ascii?Q?NxO9yVYIbDlL6kYsy6W7JrQk5X51SO1dNsEeXwurTgsyo+ZzpxJsuJDAcogh?=
 =?us-ascii?Q?aZ705Sihr3Wxu7VL78m3EfTqc5DPzn1VpA6lEVUmeRn0iTOdKx9LZDwccHUE?=
 =?us-ascii?Q?pcP2bse2fDf++/Qz5ituksmc4k9GnP4WQ3aHPpU9tokUZRJPALt0+Wm72tO7?=
 =?us-ascii?Q?6+SPzuoRNUpx5FejSuJ8sx1q4XWdQ794U0R7/z3KCc2qy0mxwnOWX8EkJerv?=
 =?us-ascii?Q?By2s3yA7AmSDWALxQ53XMR0k6tvIN9cwIqvuCF41vICGzdEzDDoJ580Y6Xq8?=
 =?us-ascii?Q?rPFCDFzfD43SaFDfAgyPHEO5cEnb9Dy11tmSONoUvEXC6s9UmN0zCUk9xkLz?=
 =?us-ascii?Q?HGXo9MoIGtN0zmVxbe5IuRRi1eMPYpmgSupIoiX6o5ev+AplBMaZfEESW+AE?=
 =?us-ascii?Q?cOnxKE8Bbg4bgVJjEsASYEC9gIBgimShvg49QBp930JY+ABj/h4c6JuRd9x+?=
 =?us-ascii?Q?TCDuQ+J/xJvlVroMZRLD3Qz1uI9MjqkNUE2utI4JqSiXMODsdzlhleLvhO0t?=
 =?us-ascii?Q?pVzxW43EFAFwlEy1Y5kBKT3b9t18vJ+XH1ub0CvITjP+wDWFegv3ug6tUyHk?=
 =?us-ascii?Q?KmWXpbwAR/wXDe5HLBlQLR5PhErmQNgtqYJOGPs9rkIedxBBw3YeDNbwlghl?=
 =?us-ascii?Q?0dHnDbYlrQ6Uod1WdGYgYd1ksSAICthKkJV4M36a+J1c76Q+uwNx3ws4DOpg?=
 =?us-ascii?Q?zx0rwN/PInpi0yq4Bz0Q39qKJJfoYr/UF23HMreR8CaBoFhcx5Nx5yAEeCQl?=
 =?us-ascii?Q?ZC3wqwASKrIf7LY5efM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ed7d36-0f8b-4a9d-2e7d-08dc3c4c7937
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:10:32.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PrW9FcIVy4CHmBOq7TTUXgz06T5ZrwBltMs15jYjiyxlJXmCZQJodF5x0+tB8SY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662

On Thu, Feb 29, 2024 at 04:42:58PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> They're not used anymore, drop all of them.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/arm/include/asm/pgtable-2level.h        |  1 -
>  arch/arm/include/asm/pgtable-3level.h        |  1 -
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  4 +---
>  arch/powerpc/include/asm/pgtable.h           |  4 ----
>  arch/s390/include/asm/pgtable.h              |  8 ++++----
>  arch/sparc/include/asm/pgtable_64.h          |  8 ++++----
>  arch/x86/include/asm/pgtable.h               | 19 +++++++------------
>  7 files changed, 16 insertions(+), 29 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

