Return-Path: <linux-kernel+bounces-104039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B587C835
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A7D1F222A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F2DDA5;
	Fri, 15 Mar 2024 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htMcxp87"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26ED52E;
	Fri, 15 Mar 2024 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710475527; cv=fail; b=Vk2WWEil7aRGiIpzPUBLlY89dCXA8GSCZBahMsoh7YFK6r3NO4RPHzUG7BvpNX3NaMk80cTvjgc2jCyK2fzNBwai9oW5T2Jve+7j5at3lON2AAfqQh1Wjwx5S/5L1sX2eMPZi0kXInZBT0k0TMItOHjrZYKDDd0e246pM3FfsEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710475527; c=relaxed/simple;
	bh=VFNfm7U2ryrz9ln7oPRUWSHHv4PK1BxOWV6IEQepMv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FBvJ24vhfeWcPAWy3JJpHCpW3mFZRtpOdzM9SFoG7a0pWMKuW1yD9I3CrDpLO85O/uz8CHjG05188h468ht4B5qbb0GWHEX9CzWmP3po4q+EbkAG9Q9nPnRdPDqW+PRdOm22hwR2Bc1K51hL3iBNBETtIh2h4nc/cSXzEmH7AkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htMcxp87; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710475525; x=1742011525;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VFNfm7U2ryrz9ln7oPRUWSHHv4PK1BxOWV6IEQepMv8=;
  b=htMcxp87eNsOeTI37Kqrr8Q5vJ3ZF5jMTSMH50jhXeCKdbYrZ3SVftJt
   HEp80N+2KxJ1K9sPY6EMpuW/iQHo/P3XnZrK12rWI5pYhLG/X8KH9Oj7d
   VcYx6TnLHWbgiph4xgpCCqEngYQMuVamwEi+ifQdYiqWA64xNE65IxAr1
   KzF5VeGiy2pJAiOAD1hZncOPDsKvxYOUuHP6MDpb5Jl3nGPyTl1WTYYTU
   8eU1Ir9DS8PHtNcOVfQ19myd2WoLwhA+mJRHmxEMLnhXOQo4S2pFfVxJ7
   g6JPqwx3c4QEXdoooWu3cpNo4VI1gRaoiIwU6/fw685luyisGLAjrjASh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15974164"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="15974164"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 21:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12622190"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 21:05:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 21:05:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 21:05:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 21:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEg389idYIlRjGVVxwgI/SrEd9SiZ1KhMtWjWQY3ZW83mSwVYxauPq2toRNDUGgKqjc2rEnSCiWTyABCBxiLxKnINnCIen57c+Frv1olXE5n8PI86O9r1bunjyOwq0c5A7uR6ULIGP5SYwMNv1SamVeKRuGcnYud5MuwSueELBsvKqhE+hcqE6CtzJTi32lsOrGgajG/WiMkHQk7wpNHYw7yAM8WLAF9Ib7io6mtwPGpYpGm0Pr8PHUkRqPgDn8/3qjggC2fo8c0ZTmUL4qrde4wggQSwFrUtgXhe3ghnywJq9LU08cf3p0MLY0TIjRxrXE1Yu3Eq1OIJNzv1EVv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPgTsa9fIgY/jA+bZw9gz0AgpZjdrCIykggrV3MqTe4=;
 b=Bn9/2AYIw50DnR95M+QjtgcjHDMspddlYFaeIcPJmxqoG5aNt1+sFh6aH8WkaV2xcj6M2vdXHPUlUifOA/V4wGZTSJ552LQDTSkmZreWCpsuJImH1WCRlxIu+AOT8BiY5WmOSCAnkaAoNIXYTiKjzHr5uf6rQcKLbsUp0+y0F+70vHUe9De7Y87JUTNgFLAJsym6Dwztt42tlVBlltmMjwDesVsy9/uJTo4Id9BlL+QC7HHIFdANxbrpEk1wOr7LBD7zxWX3Ssbrx2m44nroUHEDALn+mjNuksC3bTzGnkZ9lHSkQcHLF5i3aZt6ka/qXWCFQSY4GGUpXXdzbwLkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 04:05:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 04:05:21 +0000
Date: Thu, 14 Mar 2024 21:05:15 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Li, Ming" <ming4.li@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/6] PCI/AER: Extend RCH RAS error handling to
 support VH topology case
Message-ID: <65f3c8fb458d0_aa2229435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-5-ming4.li@intel.com>
 <65f3b2b29cfe9_aa22294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f2dd9f36-5e69-4c6e-9640-7140a694086c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2dd9f36-5e69-4c6e-9640-7140a694086c@intel.com>
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4dd232-7bef-44d9-e7f5-08dc44a521ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Y96GWtKLk7UCNdfBGzV5rActruULaVMvyiN3INz9QHMJWx51t0oZnbQAvNnPueyJ5ms3OhgzsjY/30of5iLRxrwrxaQgJ1vxhMWdPaJ/196tuT8OVO7TgZDEk9QGOVS9cXjOXsYWpK1vliemf0ojHpvIt9ILmk901QnGNaF4vFX/+eYC5wRcEiKNIeh3hcM8CyjG2RLq/a6Rf0VBby/efPV64hhaYZnVfEvGsmGhK5BhpGYffe2g3c6uY7pK3FvoTWsdorcRfahuhirTX+dT8ctDucBa5PR09Q5CPT4qjkaxRn5H5nVGNcPIwaf+2i106acsT4h0e+E7DSBwWXnpDpBsOXy/W7yuNMpEjFwdmc4W6H6Yw4ZQ/hwwzko2todU1jP7EDuVJ3v4qaM2GrADppUgGRDY/UpAskvEEpkekPIIXO4fJ4e8fAPXYL84oiVLGhQo355ih3p3mMSQLmV7XdgydZaN34/42Az0qdVNZ514/CPi23z/yxAxshPpgITGR7qYnVff63ygza2bqb//w9SvNJXB4i8tbZWeh49myx37rg3+ZDbgmIbl/pCv/M+QhbOd0Be5fZxsiRE0ri2FfTdqzmwAwUSwVAYoIqMjXrHEjxz9Ceh8Sz9yaCkiSoselZ9mRZLlGHNG95nV6Z+D1CKVeyU2Gn41d5QCeTny2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AY0TubINO3P+EW/LpTXIgfC/SXiewzaJpfjB8QQRZJLtmniT06pEtLiVsxXP?=
 =?us-ascii?Q?gPIycFjjWlfj+b7EjPSDhgMLyYWh7tTVPgOF7xExgKjsjbiPfyuN6w0fanTj?=
 =?us-ascii?Q?4E0lEwiLSgWYGOrL87TQWWS+bQ4Lk+7q3XnCSSyeKtjhCtkZk0FS2geO/xKq?=
 =?us-ascii?Q?0LRLreAUqMrj3n1pqNuVNrJsNg+GoYbcddHaaYS6eCuW0DBGuP6EhoOe3qt4?=
 =?us-ascii?Q?Zz4dW5XXs2OHhBgHoDytYNSUNOy9bLRMfsjXVjszsxmL9sd1YmrEn/3bsMpy?=
 =?us-ascii?Q?U+wIxm93FqH3kAWXf7q0VrqnStucZGu1JZ2JyENk8gE8RKchXDZiLqb0ynu6?=
 =?us-ascii?Q?VSuod84gkdquSo9Xt34gk9I0B/FU5+Ef+zPSWgnHYzMpI2PVXM5yiTBjZruJ?=
 =?us-ascii?Q?NBDq39CmbVIvXcINYbRJVe17LNrkuN4aSo2k6gzC68aBPUbmZTl3xaXObCjs?=
 =?us-ascii?Q?OTav29bOfF/w84qVsZdf0pLXQdsRVOujm/LM5Auwo0zSawh0/FDszkCKfoxe?=
 =?us-ascii?Q?wDCWHACAPgQlY54MJrWR8MICbZJDEGBoJB65cEBYG/LgPNjhyUfE5BHXpCbc?=
 =?us-ascii?Q?jgPSSp1yAPiuJ4CWAvwyIzNsuopTwy3mkFLvySTourTgJqzMexYbt0/9D6Uo?=
 =?us-ascii?Q?6H4IPUXfn7rNXVtsZDzFE8i0dAnhmtmucKnzcvq4pIAD8AyzELh/l7RZm8DR?=
 =?us-ascii?Q?1RGdqhdTe0NiEYdBdykOc7b+eebTKsdxLpM3qps5duPitGiQYdgK3y8x/3ef?=
 =?us-ascii?Q?8EkOvyCiSUrMBGlaurY+04iVAA78m+cTeIxluRwApSUZgeHCgcRhy1AwaCVY?=
 =?us-ascii?Q?l2BZ2bCbN7zp7Q37PBxUxwIgJ+xP3wsaX8AVWBNAveKl9lnnzrZOKKdXLuyc?=
 =?us-ascii?Q?2ZGrXFCIRa4Hp3ys2uSvFJlZtwR8GA4JMPt5EOaVSSQInHY97YwaNOJ5plcE?=
 =?us-ascii?Q?dir1CHv2z9ieBAu4AVLIxc4wA0j6stiTYG2b24u1QiIIySYOtbdDcliBgV2v?=
 =?us-ascii?Q?ypGhWHnp8tz/vPs4+Tx7bTQtgWXGG4e/O9fnCmqq4pxvW9HLfzxMV/w90FN/?=
 =?us-ascii?Q?tmzEI5tX3L4/JEQb5mOyjGxKu/jXwV4vivxKDV3j3VqHGhe23qOKlDIGpNiz?=
 =?us-ascii?Q?dF72faFCUQSSRKgbG1qawNPkzyeB+cIy5/FE3c9Q6trc4STKnnGdBygMBVCP?=
 =?us-ascii?Q?RshpyQYoq3edVHVwjNqUzgfVKuZxFKi+qrJSLiHlTpy5p6RVP9H5qICr8sIZ?=
 =?us-ascii?Q?oPjZrCB3X9ql7bLvrSYDbjgRwuZa0vWegP7szHXbaWJWblwiomCSKrdxqyTF?=
 =?us-ascii?Q?2ma/QkuU9pysB+ewpNhYSY22CT4y7BkNEDOf+iAJNolcrOHYijlDyCJgSqFc?=
 =?us-ascii?Q?MnyT0GLAoz3+8yN8CqSUlEDmIoYoQajybuYMPlBfgOwXDl1iY/biokZr2uNy?=
 =?us-ascii?Q?jgCsbSDtUjoonLsY0Ymz9w0BAd9p76lztvzxWZi8GNzV74Z57YipOjqkczxf?=
 =?us-ascii?Q?+UJzKiFrPmx3QtyhwX2Uo+2YxzEtadoeO2C4vCG7bVmI/ovNLv0RVPawlSCs?=
 =?us-ascii?Q?MivkiJzoYvm/iJULnIrNdMShajixamGX6fyw1E9Fbcc8rer6TZ234ZG1A+/P?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4dd232-7bef-44d9-e7f5-08dc44a521ee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 04:05:21.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaD9M4cJ27HvCusBjskuJKLjrYSl2I1FzyFmgyEE2Z5UlttegLlcj62hjcPxUZ5RYUsjjxsCmY0D8sGSiuaDTNEjcfht4y4VPBtyAgvP4Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Li, Ming wrote:
> On 3/15/2024 10:30 AM, Dan Williams wrote:
> > Li Ming wrote:
> >> When RCEC captures CXL.cachemem protocol errors detected by CXL root
> >> port, the recommendation from CXL r3.1 9.18.1.5 is :
> >>
> >> 	"Probe all CXL Downstream Ports and determine whether they have logged an
> >> 	error in the CXL.io or CXL.cachemem status registers."
> >>
> >> The flow is similar with RCH RAS error handling, so reuse it to support
> >> above case.
> >>
> >> Signed-off-by: Li Ming <ming4.li@intel.com>
> >> ---
> >>  drivers/pci/pcie/aer.c | 20 ++++++++++++--------
> >>  1 file changed, 12 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index 364c74e47273..79bfa5fb78f4 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -996,11 +996,15 @@ static bool is_internal_error(struct aer_err_info *info)
> >>  	return info->status & PCI_ERR_UNC_INTN;
> >>  }
> >>  
> >> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> >> +static int cxl_handle_error_iter(struct pci_dev *dev, void *data)
> >>  {
> >>  	struct aer_err_info *info = (struct aer_err_info *)data;
> >>  	const struct pci_error_handlers *err_handler;
> >>  
> >> +	/* Skip the RCiEP devices not associating with RCEC */
> >> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
> >> +	    !dev->rcec)
> >> +		return 0;
> >>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> >>  		return 0;
> > 
> > is_cxl_mem_dev(dev) will always be false in the VH case, so how does
> > this change help the VH case?
> 
> Hi Dan,
> 
> I think it won't be false if the CXL memory device is an endpoint.
> pcie_walk_rcec_all() will walk all pci_dev in RCEC assocaited bus ranges. So these two checkings can help us to filter:
> 1. CXL memory device is an RCiEP associated with RCEC in the RCH case
> 2. CXL memory device is not an RCiEP, so it should be an endpoint in the VH case.

It will be an endpoint, but I though cxl_handle_error_iter() is only
called for RCIEPs and RPs that are share a bus range with the RCEC. The
endpoint in the VH case is downstream of the RP.

I had been assuming that pci_walk_bus() limits itself to buses within
the Root Complex however it descends the entire bus hierarchy so this
implementation will walk the entire topology on all root ports
associated with the RCEC looking for any CXL device. That feels wrong.

I would expect that this limits it self to only finding root ports and
then only proceeding if that root port has a directly attached CXL
device.

Note, when you send a v2 of this RFC be sure to copy linux-pci for these
core changes to PCI error handling.

