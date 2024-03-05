Return-Path: <linux-kernel+bounces-92653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EC68723B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAF8284E01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D148128803;
	Tue,  5 Mar 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q4R8PY8q"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B212880F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654749; cv=fail; b=Lhuyl6B7VV6fMoWEanHxnwgLLnWZs6AZd+gW4hGJLMryT9ELsnx20qyW2apxchPYU3kCqJZX/XfsT2A+FM9icQCz5Xxb/ERYBLZgXBdZu4PUgACU8QQGSomb9kJrXGD7g61g2DtloaX7dMMogrbQc15qS4N8fjtqKyamwh3yYu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654749; c=relaxed/simple;
	bh=nznRikeGs8762UMl+UB+isdG9N8n+vAa4xx+QE+n6q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M4AjPH76ciVCOEEcH8yxoRf831hXpRzqVGNlNzHgWRuLVXrWQ1V8AmJnuVEu0+BfxltsWVkIZXiEW93ixiaXq2kSRujHsiJ3HA4I3KZjD+2a+TkQ1xXptXJ425kBHm/sJQFpaQjPBCY1G6ga2w0id+2qCd3PQKdCujSgvhUKvOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q4R8PY8q; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzolugL34sovFc+A0BAvSF4osaSiZ1nH9D0eiT1HYx3ZA11URn+eH+YpL9KNPNruewSIhsy2cfhhmVowMIxtRPH45KhO2E0CsR1sPvaqf8ThSRgQHksgqv3mP+8o3cc+KZsB0Opjai9Gj+/YU8YOI/BlQNQX5sD411VBgSUuOeEKk3iT9/OKvStfNslK+U/YMZt11Xq9oAa5ivYoeYC82X87BKYC1TC2rP3VMDs41z6LmrYLaQmcR8w0TWnynLY9bqfeEippIfmWf3zAcGDwWyTUjSxrZz2THykcE+Dw9c+m3myHQ3AQmdypxzc/SwJa+VqJKqgismIAtsAwnQU7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSh4p77EeOclB4dYcWDQnx8vJQCiB+u0lnIPFcSJrU0=;
 b=XqA8Bq3qIf84LXlX+RR94BSkw5nf1Cuc7i+eJpXcl/Hw8erCO9NyZiZFK7O1JIlYO3G8nOkWzy57dtyhbkCeSilLKeJYKN/VqqidqrI418kYwKZSvcsPHjmjC/Za7olCE5bbZLXLPVZE6489BeECOKpU7luX1MNmZDoBkBOgLhr3PyfERvqwUB9/d/tAP2SzQu3SMn1SSRk41Z17v32/Sy7CM+W1czJcHD2vP6IRONM4K9EwPFdMKQ9Pt1D1D4PBJEcgWWC5PJwLxulq9EpZpPcttxLRrUtAiriLiU3dkcNnusFiAtfO3U/1oyOK/aJdV6PSccg1evay+3bkQhGLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSh4p77EeOclB4dYcWDQnx8vJQCiB+u0lnIPFcSJrU0=;
 b=q4R8PY8qw7EXUZjN1C4XZeHhf0rDRDCIbNAdrlGPxw+1nE67bz+kA3ojID7gV/qCFnnkgwsKk0ftWWnsjk+DgdlbPIWkQGljG5xNkh6JbPtLpjMqKrRO2DH4c0bImRvGZG3Er5Ej4QNo2z/54JC7EiJAKqycSoFLe0w8Hi4O4LkvIuT96OpM+E7xKBfhWuU3n9Ihiq3w42sOVb00IpxlR5aUEjcKtKG3xObapdoTzV/3xfVtrcid706uBWARa/kyRmA71Xf+TV3cFYj60DsiGTOLuMNN16+YvJtalpIyAT+T4SvlDcS05XFfG7kDoRXaGwaRQCN4Win1WYQ09cS3Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 16:05:40 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 16:05:40 +0000
Date: Tue, 5 Mar 2024 12:05:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 04/10] mm/x86: Replace pgd_large() with pgd_leaf()
Message-ID: <20240305160538.GA9179@nvidia.com>
References: <20240305043750.93762-1-peterx@redhat.com>
 <20240305043750.93762-5-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305043750.93762-5-peterx@redhat.com>
X-ClientProxiedBy: BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1c0641-f72a-4fa4-ab9a-08dc3d2e1a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WD8KMZ9dMO/OQGre96F8ajjMC1iYklJfLG0Iw5dDkDOcwI/+jkaSbZNKYMl+i80iIv/2wyd/1qSQ5SK8+1V5oAEVTLyjH93ZFIS0990JuO7aYvMaueqbqhUFwwRtPYyN6eVX6mcKHoKybrC60zDDEstFhlWXBKz94MOLgRQABTmYz/XX1y/Dcr2/4IPlyPgU3eYnnscWmifqx84wNFLiBiHi9GTKmE+MYp3juYWSEyYBMN6jBc6zLMzhgnCwUAfU6BLSSEUcPXwpxwEX5ZHV2Tt7Bk9Gx6PfX1x+1gVF4hLP7/3i36Kka1pZeuovjuBr3ccjBcpWpJZc7GXjsdmd0LArlb5zVNuEMMCvKFokz4ztpsYuLa+OBZBsFqO/HLpPpcSuPyeMjnXX6S4MDbrEkqLNmuNaASOIWIgAS2Ni3oLnn/DgLPgOHDojbCNH14M+h2FzplnrbUAd9Qiu6e6MlZiEE+/znrK2U0Y/8yuRwvjqW7OuBu55UzIDiGu/sPDcD3q3bOkvKRurcZb8TSOXJwysLoWAk58ysWvafJKF2W6rJOa5ru0IHbC8ydHIfWG64K6D71wuVJ0bhqwnAJ67xrBQLp01J6CmAzzGgf9YDg5IYTdAu6nq3mhJNbOKVWmJArWOVBZi/4FEecU3XmYr1ZTPA2jY0rSTL52FSgB0iLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJzYa4VP3YCjNDFBq9I9xH/oBIV84c+F/+rv7STWFM4vzslzNZiqKE6lPKIv?=
 =?us-ascii?Q?pSMvAuDJMrzSzL2DwbYNyL/VbL7aSKBCgQ+8Om+GsCJJsz4SBLUU0X0kV5VO?=
 =?us-ascii?Q?cN3d+1nsmfvja7aaCgtYd8utKfaGvvW31g2PY04wUQdnaTlXEZ136bOoHNJ/?=
 =?us-ascii?Q?rXxPkRDp3pmhLzxYi+VlsyAMUBqSXGBUBAS78v4ZCv39Ja8uLmE9pOCh/bxW?=
 =?us-ascii?Q?K29AOWQ0DQy0RkJ9Nacnl3E7n/g05QMlc6vKDZM/kJMCWmgKVzvG3rZEPWAD?=
 =?us-ascii?Q?LTngsO+qHehqf4zWmp2zf4rF6BAFLAj5aBUooVjDqQEmPS93L9l60sY4TTPN?=
 =?us-ascii?Q?wNbgQRSefgDymHjws2Dkr0sedj/Fj8KCJsvyCDloL8vGkhM8x7lo2GvJB7hH?=
 =?us-ascii?Q?OazlW7Z7oNgYBm/PDUsqdPnAsWDJ9LWhGSg5boPzwEALWOOgK9cd3fV4D9qd?=
 =?us-ascii?Q?71mjy6KSoL0K3izQK0CpLWBhakCqvv7GBrAwD9cB9hQMVHoW1ytaMPO7Ux1k?=
 =?us-ascii?Q?8teZF+Y928eWj4N7QqQ8VL6gmrPJrFQTR1RTfmONsuQS11t1BAgiQ1tfQ5DJ?=
 =?us-ascii?Q?XOagkO0q2jRnwaCY+UCBJvPB3v63PvRBUEwNha5/zjULCxiqKgxbqf0kpabI?=
 =?us-ascii?Q?m3YLr2kwVMIn/yxJtytNVyg2bW6kCWWgI74ZCVpvRgCY/CwU4vC/ajaOVgE1?=
 =?us-ascii?Q?T2PqK0G4/ZiQX6sjGamkPNfEc8IsuYN8q4BmSycutkOE0VT1sOsKF/PUiqXh?=
 =?us-ascii?Q?gNALwDP9LIXs6BuKXTnz3ef20jEld2U3+dlx9jedB7hZmiLV9D9zmu2uCyBy?=
 =?us-ascii?Q?wIWF8FvDJMh4xC6KeqsMrTPYVykxTAmaIOuSA3Puy1za6lDqnk3euNwkOaWm?=
 =?us-ascii?Q?2/EhOl7edeH2pMQAXwX7En2qWq1XtuMjqYl8o5S83RctHDz7Gy396fqFargw?=
 =?us-ascii?Q?eByf1PPIxnz6TFz37mRTSUfAL2B99Vk6t/6oK3IwuiKka/kVyFKghF3X9Ho4?=
 =?us-ascii?Q?tUOpWim63HWwj4TfIwJkMESSBjuWoFfLA07pIYBu1y6yjqY+hkyV9PylpTQR?=
 =?us-ascii?Q?k0F8xQo0ITT3A/QFnsapMLNIZnMI2YgYYhovX07fnpflLVbzZjLAKUg4N3wT?=
 =?us-ascii?Q?bO6MuuAFO5fbRkK1tAIzaCfLXHlffC9K29nBdz0YjimcPlu+rKsAwrdVqSst?=
 =?us-ascii?Q?SJS2ujYDqpuZ+gkuBCZhrJsKOpUg8doOjKyuiUfUf61VCh22gPzcoZC/unf4?=
 =?us-ascii?Q?NufjD+HW8/k2b6GPTFpYk8jy4e4Tq0ukJj6ESUZx+cPYPVoPV6OBTDCJL0r6?=
 =?us-ascii?Q?1tQA+sovnFsHl5bqh3xaxeOopQ/0RWxkTy9SPtIycvFlSn5XB09cPbArjHxj?=
 =?us-ascii?Q?GTP+PmbbfhGebNwQTnZxYwLLIB44HHg2XNyJ8gY9+75p+3f2P4+cfFBtStpm?=
 =?us-ascii?Q?2HmyndeGghEcSYTqX8PEVWM7bbhmdfPyLuO9w9aEOusD2JrM/nl9lVjUsMIq?=
 =?us-ascii?Q?N0ktPy8gfiPSZ1gTycFDa1PNxUyFbg5Dm1XGe8LoC9SM0+13LzE/scg32MMb?=
 =?us-ascii?Q?OjlcbD5rkAF8gxoFhgbie3WD++84t555wRd67qW+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1c0641-f72a-4fa4-ab9a-08dc3d2e1a3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:05:39.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR9QSCaL967YGpMMAGxpMr/YckHLdr9ipPzcDCU9SQ+Fl5T3AoQOk/jI4o4XGACF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

On Tue, Mar 05, 2024 at 12:37:44PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> pgd_leaf() is a global API while pgd_large() is not.  Always use
> the global pgd_leaf(), then drop pgd_large().
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/include/asm/pgtable.h | 4 ++--
>  arch/x86/mm/pti.c              | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

