Return-Path: <linux-kernel+bounces-105612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF1A87E190
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4378A2820DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6A17BB5;
	Mon, 18 Mar 2024 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBhktSUu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22C168C7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710724643; cv=fail; b=EARWAND8nyYjwtLtr1657DfIfStOieHsSp51BZF5UyeuIVSaoswOqGeo+ouTmSXQ1ki21ZI70BsxfMoAV3lv8OHfnADpQOBYc7qvpslFL2G+PM7ruKO3/1n3ArYzyqya6HPXjQpdfvDWwE/gd/mT6R0K88iEAH0jAcRvlL/HZR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710724643; c=relaxed/simple;
	bh=YPQTqRXv0u8Cdj7ZjA3+XtlEAbmO0DSoQJws94zyUGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXN/gkvJecTuWWEFDhtIpjaewbZJNye100cKEaiPJ96H6to//oyjzfK93+edn4HUuPHVI8hVAP5vwHMG66XfqfGijDCcoEPrfzh8dA6OiBwFdryslzul996RACupH2wzjrFayLz7ECWvHJ7cDXc7NCTKTo79jOy0c2t3t9nCNSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBhktSUu; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710724642; x=1742260642;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YPQTqRXv0u8Cdj7ZjA3+XtlEAbmO0DSoQJws94zyUGY=;
  b=KBhktSUuRt5BXPGgQqWsaVpkLmfJDKzjmc3t7p/ERMX8YR8alcIIu30k
   GWpLtu+UemsALWB97kdpygTWKlWNgs3YgCuprH/oIPVE+OL269bl4n+37
   CPsrjALz+lbfbZQK9bJ8gBbG0G48SedMadpmohuePJtCCmXyd7iopCiMC
   RbySV6TpBmOlReKAVStOS8KQ97zTwM4nii2/7RZt7Lw/loNPn7HsfA8x4
   DDwVTomlwgp/Nn0e/oUOgxo/aczN++I8sp+Z/fQes2QvUILlF6ikL9WU4
   cZP/uZcTLEJe9k/+TmuxO07TFbg99zl4JfSr9P9K325Ghob1ll6e3Tc6c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="9332997"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="9332997"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 18:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="13949675"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2024 18:17:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 18:17:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 18:17:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 18:17:19 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 18:17:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8Gjv6mjslAMLi196bfjJJI125RviUT7AnYKxi5HzydttK1ynHT1BVH3vF6uAQkA+kGQl5wjbhQ4in+fhs+Ftsyibk31+HgfkWoaLc8v7mvmnmeBbEbRVtO7lQYGuLbh2h1dfZZTD4VPw1NBiVMwKA5DS+1tQdtjjosgJ2d+PUXm3FYsCtzrB/vSbs9ysy1rhgQgw4HIJLhOVJVxAWlmggUPPXW1DhUQqYZCBmNMdi7nzs7eAMZQLVN5KNO7DT8aG4/5cWEUPWXtiVZU0MGewvumeJkww1ubjTluIw3cpbu1hnXO0n2Ih0VDiwg21jk8jhThHhIQwvnXP6zrzanIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h24jYm8mkOdHxY7bRQQBriHnRu3yS332f0lc4T+DOs=;
 b=laTC0NML91lhy0tlP0SZQU6rmhnVVC3FzuHjOY4H0zyYCng68CKWGXD0BvXgcHZBoWHXBOI5Ah5KLzC3B1FJ1wLqKqaAuW1G4p/d6z3Fi0nyp+11vm2Hpd0rhzjjBUJBCDWrbkZkdC6fCWvM9IBkCq1UP9BtaaEl5YaWbef+djxpNhP0oi99QWGg0VOXgtQrgKvnm5ldjW8wGJBfBWLGM1szom1tN/VNrCuna9nlVT6PEGlyK6udLeOaJWjm4ILcPRRzaO0D/6q7VeJvrpV+WxiNYfmw3+eqT+oAVNCkESVL9WxhGoV65/7mc8xnrNyUpvPJgKw9XpXE/Ztvnt2yRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8; Mon, 18 Mar
 2024 01:17:17 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 01:17:17 +0000
Date: Mon, 18 Mar 2024 09:03:19 +0800
From: Feng Tang <feng.tang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <x86@kernel.org>, <paulmck@kernel.org>,
	<rui.zhang@intel.com>, Waiman Long <longman@redhat.com>,
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tsc: Use topology_max_packages() to get package
 number
Message-ID: <ZfeS16iHtEYsqs5m@feng-clx.sh.intel.com>
References: <20240315112606.2248284-1-feng.tang@intel.com>
 <ce02f1a8-870f-41bc-8650-4bd6103f9637@intel.com>
 <87r0gbjk17.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87r0gbjk17.ffs@tglx>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf0cce7-a578-4152-248f-08dc46e926a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75PytxyYer2LXMxEv6cw9EzyKWQI1WShG9qx2VG+6pZhKep+mPZgT9XMCwrLUkFSvedzWgoCNb/DBPanQh5aN0IWAjdlUHBKNtB+9oY3TlQPvbFCcYzfLd8fKa/mCtikDP3ukiutatriYVqk7wtikN7shgEVbGvs2CZ38Ze5TOWxXlb0OwHdoPRNQWXJp3DBIcLTCv+ODIHVbgfNLqoizPtxD+mm8M1cC9yAlMw1a/updBy2kMVN4gwGk4SMxxP2aXkt2OWkpkFAVIbirsIdvbYVEaov3/HXsVFgTPAjb6ImFqJgjHrifslTKWYj+ogDulEywbr0cL08KH5UnClg0qRioFmy0NAoiofJL7Qmyr8kMLvksWYpMO82CUYTBpiSUVRxpPRcMaUOMe5zsXZqD1ExpR4MnZrktp+Sx0axj0DJEKRks05sfCJ1K3kb069sDpYf+BqEvPsRqIyrwsGcxoZlhsIFIzp5zwsaN5ltQmwwBoSrz4eDUdMAtjWreOA1RRoPkhCxTINGB22o8xYYk/QuugCtFwFOT8JjfHgdPZG6gl49+Hv0HlXKkpBwiedsxLVXHdUqSVmQ9NFcitIPvQXwLs6/IVadIGnZv7yNSramrpvI0cE4Cw2OInrNrO+GdXMDVhvM5YdOkzxBOyVJX/oqr6Sm07OOF9C5SU6QmHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2VNSLFi3P6um6gsSvXrH0PR2CseL1THD706pi1hDfKN+ldpFl7yqkvw9Q+Fo?=
 =?us-ascii?Q?nwd7hVYONhdoTmKTrIVMaeqDyH4PQcrkAskGXwmMDpUbnUWDkEStiS0IsgWU?=
 =?us-ascii?Q?JWyJ3sh8UHKLA3VB1fjlXyC7ErRMaRXXRvDQFcU0cLmxiyzI+Lj43HzgKUQv?=
 =?us-ascii?Q?H8YB3MLOR3ORQ4cT495+HoSp12WUAnzvxdXc29JwW4efHyNy8CIJWqpahhAm?=
 =?us-ascii?Q?DaJPbvms//HmxFPcxXdLiUfu2OjkcPowpBDoj7t5cfKMde0w2yyk8eKzWH5k?=
 =?us-ascii?Q?oljS17CtqwqVEl6j2wj+XTDfHOr878uRKw9FD37OKgIpNlqgOXsKuUMOS8+V?=
 =?us-ascii?Q?Gmtgc4EF18sTXaI7NCyhQHjev+CE3LlnGaIZkBWEcAK3GChiI1EWETxHDeSY?=
 =?us-ascii?Q?+v7w2yuq/XVFB0ufKITumq8/+H6vJEFhS2hRE/s7enV468divlwZEwCwz8+/?=
 =?us-ascii?Q?69Ra3wPmnDBgCSkUuV9XbJRPj7oH4iHFDRZOlK6C2yVhdo1qzjRt9quMdDhy?=
 =?us-ascii?Q?fSSAqV0txsioi/HLvfqoA5ZlfAQ8VVPpoy6V5gymjBZahT8f4vj2PEXa2bSf?=
 =?us-ascii?Q?R6DMayAKtja9YZRuzgYmnyXlBthUOdGR58SSpEMU7Tk9Tgjq1OTMIoUT+9Uq?=
 =?us-ascii?Q?uLlHtkza8JVElqIWHgrY2S1r4QMqCj8jt+hhtlraIyBtr6VwOEX48bh+7vnW?=
 =?us-ascii?Q?MSpEEvxYHF4xNTxsJChx/ufVFRlepWljgKFW78Ve1tY2HTNktV1Z/KIWpbQH?=
 =?us-ascii?Q?rh1fQsPV9/te4BnqwPXzaF5N9lwAwjjmbPXi23pcwvwGrIlYrYAZjtTa0NsX?=
 =?us-ascii?Q?2gaf1vtcr+QK2XAGHH0QCmptq4OZWvMH8ZECj9ErxZkyB+SLGdTS19wmgwrz?=
 =?us-ascii?Q?W3dPtNNSeJgnviLJhWT6q7i9rCunNTzUPhPeGjfXGeg9JaEKmPwWGf9rnSGl?=
 =?us-ascii?Q?Y7H3jg6YgpjRIPtIbsMV9Q9zaxMevLJ69rLIwU8uHsTJoOpHBVSZgCrjQIup?=
 =?us-ascii?Q?aGMH6JlY/mLTtB159/0oEvBEGUo3Zd+KKLEqggiGoAF4u2/T4/7TLRFjiSZq?=
 =?us-ascii?Q?qRl9kZIq6zmCOwq0iDA2TWV42ttSWsMqUeQYV5xPcVmxVYT/Rkk81yw0loIn?=
 =?us-ascii?Q?E5DIeu1tN4ENn0mz4CSYn6odUDWOyIXAc7M8AwFvyqndwWYQD+dRq1lMDnMb?=
 =?us-ascii?Q?5Gp6s7prkQNlOScmmKzsLkGm2s4GttxRG9I+EHrcl7rVHE9usiLtFsVvpg0k?=
 =?us-ascii?Q?O/ZBOCRkjIl0Ohr+hezpTcsFdsS2lNWzEDVX54dgjgXcPQriH4l56CfZz3N8?=
 =?us-ascii?Q?HPfw93jP78ekgarBkbsfuJxdUgVjqJLNjiP4KTV+GAA1wVkitsv1ehcG9NFv?=
 =?us-ascii?Q?UMIFwC1cxG499h2dXWpxZm3Dc79adp56Cer+DezSE/UvyrYOUzkDeaaLY68m?=
 =?us-ascii?Q?dSSRMgF7wPjlNOlsN/zlf08j8EFiOSRgJLgCpZ226+USEkJDX/pw1jKdyaFt?=
 =?us-ascii?Q?XvU6YmjHjR3BZBcUlHUbODp5EZI3JlgBIJYDhg3gxsDKI8YZ7koORsgiDjDi?=
 =?us-ascii?Q?jPNmKBc0RobyRfHRpJbERBjHa5NKQJ+94Ti7YrPK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf0cce7-a578-4152-248f-08dc46e926a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 01:17:17.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGwHL32kN4ua22Oo2iYSrZGPpGj/5UfZqSxTT1FjqOnpNwXlZKZbmAQyhb4XCQK0hWDP9+Wb2wyP26dVI28wtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6526
X-OriginatorOrg: intel.com

On Fri, Mar 15, 2024 at 09:51:32PM +0100, Thomas Gleixner wrote:
> On Fri, Mar 15 2024 at 10:58, Dave Hansen wrote:
> > On 3/15/24 04:26, Feng Tang wrote:
> >>         /*
> >>          * Today neither Intel nor AMD support heterogeneous systems so
> >>          * extrapolate the boot cpu's data to all packages.
> >>          */
> >>         ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
> >>         __max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
> >
> > Because Intel obviously has heterogeneous systems today.
> 
> Hybrid is a per package property. 
> 
> But neither Intel nor AMD support populating multi socket systems with
> random packages, where socket 0 has less cores than socket 1 or socket 0
> is hybrid and socket 1 is not.


Before posting the patch, I run the latest upstream kernel with your
topology refactoring patchset on one AlderLake and one MetorLake box,
and they both show the number of package is 1.

> 
> > So I'll buy that removing 'nr_online_nodes' takes NUMA out of the
> > picture (which is good), but I want to hear more about why
> > topology_max_packages() and '4' are the right things to be checking.
> >
> > I suspect the real reason '4' was picked was to give the calculation
> > some wiggle room because it's not actually all that precise.
> 
> IIRC the TSC is only guaranteed to be synchronized up to 4 sockets, but
> my memory might be wrong as usual.

Yes. I did try to increase the bar to '8' with a patch, and at that
time Peter Zijlstra mentioned there was real issue with TSC found on
some old 8 sockets machine.

Thanks,
Feng

> 
> Thanks,
> 
>         tglx

