Return-Path: <linux-kernel+bounces-117083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F067488AFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B2BBA28DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843873174;
	Mon, 25 Mar 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MuUNcVJN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E02579
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371937; cv=fail; b=LkfhpjV2kAYAV0Lqr1s9DQi6PnOWHWf1iqmh7E/MawnYeS0ZwGAKYu9ygNxgr3w3GfLBu6q6RLPDgp9HMYtQklQ47AghpMReGvCcQfPX4WdJyaKv5JCp6pzolDviD/8+GZvImYKiQ3vlAagF2v0nSoPl2zDuf7DnJ2uY41SfTZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371937; c=relaxed/simple;
	bh=O++bUITJUZuuPdcvay26H8yp3/bf02g4Wvn+lGsuiT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eVipzvcDnHCetcoVm8mTusYV64IlBdJWq9zzX3u6xB2YgxOtFn8MXjYlsH/WUppnOAssMZV4D2+4fSA/3oegiQJEfM7WLjMZXjlMJd2pV8P9IhyQNlsnoTRrpW28CMJ5DHW/1Cgv0dCGqK9GleNALTq8F6CJR9sCO/Jw9iWr72E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MuUNcVJN; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtY7W9LlDjgvnrS64e3r77YA4tUwq/epCyt2FpqbJTmzRODlQi1PesINQG+mX6wfDvB1CL40GdmEYKojoP6Di1fmVaZAXOraHFiv/f0O/+1a/X8QSO8Wt4stdRnHZ+5mTnr+TNc/X4z56MEoq6Btm3Q3KT2GKmjCsGDSz7FkC5sdMkOhHwcZ+0n5XQoJ1rzF90wVFScOAZZ5cIUcyAOSkaQbT/WZwX/m92lAyniKUmSUdpTud7/uJvvVmmZ5gyEieI93wSZ3YfiyGbFeQ5It+f6i0rAf3M7yOEi6e6UtMJ9bn0NbSEtihFm7ZVTPtWcFNJf/GEG1SOLZ85FnOVEaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oEYuHtgJbIv/DYUGFIT5l40FjkZiXnCbJehGRFc++o=;
 b=KVYKZjbQStwtdY7GHOi5SslKTrH2eAz4il4UccJAfcTx//pNSMLnq27NL18ZQEUnAsF0JeF+kATj2nbf+B676QHLgNdZgZinszQgkPxrVCsUWzd4TwSnAzD9pc3ynsLCqY5W4E3h2IO2vMP8oRfLO5Y2flkygPtZZzOVuIskBLLuIRwXvzMdootCt4cJTiwrxrQQgZoNowlmPW/vEMX8YPj3280/dn+eNSkUi+zkKsPriC5HFcEKr/DPNUxuJwNHkNH44fDOIC86HnEZW5gTgCg6sP+U108aTNQKHifIQ7CK2oGZykXbVY96jZ+n+SIgdpOF2rX6x1RFwKkdL/dGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oEYuHtgJbIv/DYUGFIT5l40FjkZiXnCbJehGRFc++o=;
 b=MuUNcVJN0JDdn+bkITqB11RBvCFyjv+g4nnis823XAD63ywX7LcKR7kE1Mgvxnk+DE3TeGSrAbflbpHIFVYVoiYO8WuLWLHiOdwnSvhR/C0FxTLJPWAFibHTLNntUq+lAYp9WaQL0eRgks3bpsQHdjZDOw5hRSuTe8zBkRAtY6YWB6Ek6ZzGfcO4fgWsR2BrRNq5H+z8vNwyHQ1Z+DyAmu4iTLq7fr373zlxYPvIOxWIQALpwVZDAsfeAEw6CaxI58JX2Yx1NcXmKmeYlQhdXvoA4GBqCaNE6DHI+EBhhWUOwT17xWMOfe10JaGwEIM5HLULeGtglpAUPW4GW3SWUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 13:05:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 13:05:32 +0000
Date: Mon, 25 Mar 2024 10:05:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: peterx@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/arch: Provide pud_pfn() fallback
Message-ID: <20240325130530.GA6245@nvidia.com>
References: <20240323151643.1047281-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323151643.1047281-1-peterx@redhat.com>
X-ClientProxiedBy: BL1PR13CA0342.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 64423dd9-20e7-42ba-826b-08dc4ccc4080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F4JsR1NMQVgS2o3d3iXgtcTuiLY8nSk0M7EfWG6gn6OIWmcxOzQxipSzX3j5byEQg+XcMSPlpopBpOqbMQYysE95t5LmUVCtxEX++ievXARL3iOWSffujBsg4Sp9br0Lf82yeO3sEQNayL981JO5hW2CAszFiHjQEay6m1MEUFrieEHBtK1mvWDsFLmf4KN5ILKVxX9gp0dK3zejtJOyP2F2s7ntbBeTRfSga3YiaNdVD/2zB/3WAwouuCtNNZjOzpYT4FHMA7g8wXhRIh08NiPKBFRYnD2vY+H6B/wI67YQMAerK8y5K2Pyj44Rd0E25dcHNSHtlqt22LFXg73qsuWB7Ow2cV/jS1cLxI+fd1gap4gphn9skOckkc6AqWp2RjJXkd8rtvCmX0Uac63/puLC6C3hBUFA4/FomBe9Q9klbPuYFfVzah8p7eEKlfZtZJPgbiIHJB1vqNJHJdz2JDzXMdIhnWO4cXqbsGGrXkKhFv3THc4BpbN+Yk8d/0Esj4rwc6H47YsQlroTinYwaetFa+urolSd9wmqZZLOkSkl3qEGlmCx/xnTfEhVC45UhsxqjQBVrc1EqGhtiWToBv81TBYShLIO+tjXXNyiwlcZThKJB70vkgFRL4CrnkdCEihSYINyHh9nkp22FCsy2aMJ/TlyNF1KwYL6l2Ux0Qg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LwrbklxdzxcprG0uPzadrPujEcnpNEqqBAk/M6PA5nTIyC9En+Qtb7iae960?=
 =?us-ascii?Q?CqpCeA851BDKe6D7GUhwOHtmVHkRefjjey5N40J+GFzuljeW4zUFxxv8nz9u?=
 =?us-ascii?Q?iv4Tw2oMePe4jA/1nwrs2nxpBlWpnVqtFNatk5a2PZS1EhcEyriAbavQMCTp?=
 =?us-ascii?Q?ETMMIRjFhn43vfcJheOEfJqprjpP8WT2zAPxqgUDXD/4aQhOpCgugbmwXWqd?=
 =?us-ascii?Q?FcTay+38Vvf05BYQ+DaUvTtqFeW3yLsj1mBt0nVGcCWEyovqEqUVk1j1B7AQ?=
 =?us-ascii?Q?ICTELzl06rc1YvYYFoS47F306asq/7kjDZygDY9vCbkq0/62m0/PBRhmUVox?=
 =?us-ascii?Q?rMjPd698ielO9koK7DSJnVrdRnK8H+cCQNynz87KqvDO3J1ZLVrG6rWen8dB?=
 =?us-ascii?Q?I/bX78WluKS7CC2I7Hzz8CMO+JgMxcR5sQccaWo1VHitmUxcEZhrOPxJNjoZ?=
 =?us-ascii?Q?VXUqvfI6l5voYoCGC/OA7tu33ejX7pzBObO93uafoJsORBnJ6enMt7tgTWoI?=
 =?us-ascii?Q?+B2TquabBZDYfcSeRDqh0XRCnD7nWL8xGpm2MqzVDHJ3MOE21p6ZfhRe9N5k?=
 =?us-ascii?Q?AsP0EnxEfffYI0F43K/NuiKuW+R2wj4azg8++Hi9iHiOWHwzQcs8ukoAJlM2?=
 =?us-ascii?Q?jXiSHf9zuMxdVnq6/AiJU4jQNp2XTbJxJ44TmuVypyrzH0pleda2GeAj3oz7?=
 =?us-ascii?Q?WufSKRXJbl4xZL1bmvromyhOXtc0/F4v1FiTdyLXgjuWOZUkiauZAMilgX3L?=
 =?us-ascii?Q?QoSnzz9tRcNiHijBkbZdLYwYoP5aX7mhtPElVWpqTyYu4Zmy6YpRFiDpNVyl?=
 =?us-ascii?Q?1snhm/SZhRNa7SvhqU5yu+PLXaRpsgZ+Jud6TL5MLxWsUuk7EAaWsZLCQT/A?=
 =?us-ascii?Q?iLzomDOfj70KmWxtOA8pkTtmvKmpgmqicsRkr8XjiUfKNSiwwYD8M+Aun9Ob?=
 =?us-ascii?Q?AUxwmVFkiCR+zWF/04jEBIAavFcIEzQJN99m7I+9byMf+r5bYPsnuZj3aADH?=
 =?us-ascii?Q?OzA93o6E1D9Darpbber0n/ar+pgKQcJBTqmR6l93CYzDJSUA8jeFlypu/Sk4?=
 =?us-ascii?Q?LE4g11oNSubNP5pzVTIjKJx85yRtcTNgjKQJh+v4Eo/gtGcW2xeRFgiGlqzw?=
 =?us-ascii?Q?VrQtiwCTmyZNpj5LhWgmUAoGWX1IW1FEDzmEggXcEsrRzHCdCdMgC+x8KF3a?=
 =?us-ascii?Q?KgQ6fu8bWrerL5boZG9JGp6K7BBRG9hH8tXybGxm2ZxeTXPrahTTF7NHWCtD?=
 =?us-ascii?Q?QbPzdArd/EuAX2wxXNBjWqph1sjN+EgmP9oasN5uqazFdjvd3QA9VAcopQRt?=
 =?us-ascii?Q?bcJASFKWjsk25TTSzrFLb2Q0rXWf6TqjdK7h2nMeNIRCrWtmFoQ8/wWcZBpp?=
 =?us-ascii?Q?UoY2nHVq1yhyOd1NZtA/TV94cYqBZabKFOrx0NeoG5GKkrYaYz7q4orSuzZ+?=
 =?us-ascii?Q?R63zgPJd7/ufFg5zucHyRQcObl0bLwh0Ogsb7rMTP8Wh6vwpPkJGLFdgX5RL?=
 =?us-ascii?Q?Lih4GVTY0irIdDhLdqzEhxYpgJ2p16KCnImI/xMbWS/r42OdIaY2s4hCdD8g?=
 =?us-ascii?Q?sXqekGWCaJMUugKwMBg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64423dd9-20e7-42ba-826b-08dc4ccc4080
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 13:05:32.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ds6A5xlWxCBDlzjrBZJiNiJTDkjJQLUZbv1lREcBiAm7MnrsSViWKPU0au9Q1C6T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

On Sat, Mar 23, 2024 at 11:16:43AM -0400, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The comment in the code explains the reasons.  We took a different approach
> comparing to pmd_pfn() by providing a fallback function.
> 
> Another option is to provide some lower level config options (compare to
> HUGETLB_PAGE or THP) to identify which layer an arch can support for such
> huge mappings.  However that can be an overkill.
> 
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403231529.HRev1zcD-lkp@intel.com/
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

