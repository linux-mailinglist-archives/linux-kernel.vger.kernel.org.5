Return-Path: <linux-kernel+bounces-105625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1E87E1B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712D8B21937
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA222EF0;
	Mon, 18 Mar 2024 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZ/lJ7nC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423322EE0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725462; cv=fail; b=b/B5vuoavMeSNtjGCeM1fqH3JiCkV063v1nnVeQkXJDetUyUOVyncZ+3227Oad7qh3sEcRICkTlfMUBaYNvih+1NLgmQ++eS3dr9SCH6qWzwlZIW+kdE4i0/msCp44g2c0y88ISDMpleo4dejOYqUtrB8Bc5RhbiAQvH+c6gaS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725462; c=relaxed/simple;
	bh=VA9onWLiTGgh7v08yeQuFf6G4wPCd0oS0t2nIYwEak8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nl7e7o0abrSYu0wDbVblG0bKpFNrR1cT1ir2D8ozmLRcAJtJiT0j/U3gJwihPUHrlCIoDI7cD3S9oSy4jt7H7KFgmradbwzdpV977rNtP+3gBskIN479x4p0SKtcjnknT55zYSnbgPKpj2xY5OFGHczXppGfPlcHMGpbcA5uxws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZ/lJ7nC; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710725460; x=1742261460;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VA9onWLiTGgh7v08yeQuFf6G4wPCd0oS0t2nIYwEak8=;
  b=OZ/lJ7nCMM79jeEMR6n8FD/2lddpMHhJ7sF8/Z8dh4pEYBQSXzucUF7n
   D/zngYIcRLQ5cSPxVE1b6BqFj3gLF+LuNz43lpG7DKq7PfY82QnHX18eF
   Igbl5ZvoJfiWMN2cVwLthGEOQbFSz9nvQNwNhh93KXqI1Diw5LwkEz0k4
   ZH0EhCTrXCnDhVzXkgyQEeI5ZsHEz8DAVytYr7Xk1/ZWtEFbQ5EqMrHnO
   Mv1phoyEzGnTxpKM8yqtk0zVlTRzZ7V+1bEGs88z3XcdCfdfJuztWQWDb
   /+9TJBykiy3xAXriYK8mO7j8PoSxBVu0/C7rf214S1sts6zicBQIVHi4U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="6128951"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="6128951"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 18:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="13205557"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2024 18:30:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 18:30:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 18:30:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 18:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwInGXQE5fmgflUNRPQCIVfp9jCMF9YYLevB5uIXLvghBvNWSOGd85e+OpNGAjk/LOr9xGzWEW6bizgZ+ulBmhcqJk2R5LnLk1jbFQz1QNikfTgN5NJ2AdPssdOHqIj5AhI5KwFuInFh6g0PYKxqHdsbW62tUEs6mqG+KqkaDjPz/2HXzVCNonTpeAtL2g1Cg5yBcUCOr24zNdr0AJG1StWrOW7poNCljPzpySN7QY9bKsc+6wi214mYajOoYtRPNtIS0QERHmk3GRpT0FyzdKjsA2jPA3UE118yBRJ6FSjt33UBajIkizzr/Bcz26DuySHy+0SolXWZCBEez1HLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjVaSBUJYbLoKBiCzSIcrRdSTWld17cU5EW8IG6zCic=;
 b=FKxGVDfdIAJ1anLnuiJuazKgF02qPB1GzhH3E4GDzCS00D01uylyYw5D9Hc/CYwCFyw5bHznSGvclsq1xzLONbwZAJNlQp3bJ3j2moWp+UaNMXOMlzC3q9IVie/s0SW3QPnQ2OW6X48qZSLJMAq680f5OFg3PSSt7NYZCjNg+g5ihKY+fGesl3fIqg+A7fz+yM9Z2dWBmpbkRCGAL99kPbrbMJJPI/7dU2alBRK/Gbvq6205Ij1dKKfJywc9ORDNCjCkcbD4ltZOGmJ3IpysRJQiF3mCGrIx7MU8cZiq6ojm//yG+mJyPVOM1vOF9PKFIaCBOZyjqer/ogS/slqFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Mon, 18 Mar
 2024 01:30:47 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 01:30:47 +0000
Date: Mon, 18 Mar 2024 09:16:49 +0800
From: Feng Tang <feng.tang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <x86@kernel.org>, <paulmck@kernel.org>,
	<rui.zhang@intel.com>, Waiman Long <longman@redhat.com>,
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tsc: Use topology_max_packages() to get package
 number
Message-ID: <ZfeWAQoYLFLnhbmG@feng-clx.sh.intel.com>
References: <20240315112606.2248284-1-feng.tang@intel.com>
 <ce02f1a8-870f-41bc-8650-4bd6103f9637@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ce02f1a8-870f-41bc-8650-4bd6103f9637@intel.com>
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6c2e13-26a2-458b-815f-08dc46eb09e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4igcons1x1dNxhV9GNiFzPwanTmu+XyRqZRxYbcNUXeRlAwRb9me7Zdjfwh0/FGnCenIi2EnO3eUNHHJZfS7hiIHK+Pzlggo54Xe7+g/29exB5PL8vpMKPn3JO+nj8gn9mDPKNLqXbEd8se5e7o6+r1Eqjm6g9m6WRAlTeANutRSUghHZvVrIgccAB7o2T+fxeurLhrXZ8F+5Zer9EV43sN9t5Xyts89VX4OZGp+P7grUaXNvdzcWZbWBFUlDvemhja5apC8KsW8nyjCLnbSMJs4E+D2junp1iov9JW5JTpLLxShCqRxHNEyTYPinPEl7I5U0J4Cq6/Z4LSJM1OUVJ/VvgnIRNWgKQTqNFuOqfx0Kc+5eoTfW64I0mDuXmVjC8PVTO9hTnqAWFksMBlBDKLAablc8xjL1jfTBCTThxYeyDj2fGFbdRvttR2l3BE+4VwDwJKJ2i3cBth43MhOrMCk5/9xI0vw3SfZpV3xagMRU2zuymZ6qArgQcp62jJ1tMG4Lu5UK/BBCArNOQbcGLoxTZOWknnI7kU2RJsE5z7B31yQOKlJUCS0s+fsXmdcPoscRE8N93ih3Zz0EdDimLN2UQ2XArRWt+IKFTsM/VbrsaFsH6dGn9Py2rFwLFk5FLABzSHDrFPzdvV1esWc9HwAuuMNCgMdxFNkB7wqev4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x79HhKRMMUQuA0oWwMBaBmlDijZIj0FpH/pzLmBCIS1ah1Da/v7ikYZlThY9?=
 =?us-ascii?Q?XiON2/gmsAyJKPgynZjfrbxIStds/dYJYVY65GgdPMJdHP0l4Q6g8n4yCfYQ?=
 =?us-ascii?Q?BvR/U/KaFtYj4FsXlZV4vkEyrzylAZnmiid5IB8PqbBZbVegGMXqEgOeTFQq?=
 =?us-ascii?Q?DXUS2jzeOJhKVHZey5Er9BEDyC2kgq1vTXWljMQ0HMSCB2J5iEEIe55ZhNcK?=
 =?us-ascii?Q?Ha+cC+9A8DKZncyyulkQDSKdbSmsGlaAgijQEuiCfnVsXvGDxXQ2uI1bBPS3?=
 =?us-ascii?Q?7CoRM3xr7nFr4PENSLM7woVoJ+S4juzSo6YUVWb97bFy3PR8HPkSQxu2WUYb?=
 =?us-ascii?Q?P7YyIxmf2D/9gTg6B04UFweeSf9MG3X8CawKH5p5fK//jChvaPtROBWvtfxW?=
 =?us-ascii?Q?HBNhmA0pYHm1DMN6arC2Vje0KpuQqrHlTLy2xkXn2i2oUK7u51/Bnq/Bco7g?=
 =?us-ascii?Q?B+w6iAt3jsO2kTO7xnRrwbaRpK0YuiI9lhimlI08LSL6+YPZRUrVo8QnhEHO?=
 =?us-ascii?Q?rlNF5kKUqOJVIsWDFrJFXtJQHzysRPVwc+8DGuHGo0dAFKpR6kV9U1+Qwyo5?=
 =?us-ascii?Q?Gkooss/SGAU95cumDAWpjN4f2ZF7AE1Z08Q8iEVGeJ00fiLsf4Z0/+0+5yK3?=
 =?us-ascii?Q?4D15AfedSnqnhi51Mt7nZi3NrlTVbS8df1KAXRNuDXhfe13Q6NIfODsuYGpJ?=
 =?us-ascii?Q?fRZK8b19AGk2+V4PXeQzk4SRs/35hgsNMo/NTye6d7QuizNC72gxb+Gs6jzu?=
 =?us-ascii?Q?qekffBrxlLwivutz97fdJ1DYH+65544TIVld2Auw68C6Z2cY9VSWbFWJ7fMF?=
 =?us-ascii?Q?W7UwgEmABMLkNuk4dnUjQA7oAw/AOmFIfkyyXrr7BtAkc2LOGPc7FOXItTpu?=
 =?us-ascii?Q?/Qdz9Rr8FO1HG9ff/9fZKkSpvPQxe0cMzNk6DnZ+r/KYwMcqRHallKlcz/7a?=
 =?us-ascii?Q?LaYcW+ozcMCIyEENF80VHjAc+YIraRaIRemU2Pk8qWGuD/J6Nsq7cZkHM9hp?=
 =?us-ascii?Q?UPSNhkO+uFoqxo29VF/XR2ShZmxM6NrSDWus2+x+jOo+8k/cDSczSFfmYZUB?=
 =?us-ascii?Q?1ECSrAJIDZU6u+7UoQ/DfTKQVuvGeWX4fgbnYGwI+ZE/CLKTEEjuJvp6X8a9?=
 =?us-ascii?Q?rSpQGQlk+eQJEyMCyHqWaDiSZ1bTpvD8dwsrDWw3q/OwWv+dpxlTrnuo7T/7?=
 =?us-ascii?Q?wyzjkuB5Y9IFSadT19zfhPAJ3gskz+S0AQscwo43+USo4eV8NJGh+QeOSTC5?=
 =?us-ascii?Q?sJ3QEDmQG8LirslBkHYqFq9rwAimg5Tm85Gp64V7/TVuOnI/Y7BcBY7Rw3zO?=
 =?us-ascii?Q?QbSKSfah6Kwfb5AGnjv8XgYsq2eKl/BUL2lOkExonhb0y3UKZf0skDV4atZt?=
 =?us-ascii?Q?V4HKerPIHDPChcOPr2AbiPji5V5N1I/zT0rk6EOXAZR9rsRnJjddZlQ7AOrz?=
 =?us-ascii?Q?iDzOFHvEYPxQ8nSL4HigdiNJs1S+Xdxt3Q97g7B7qKUdlnqvVsw9TUvgl3Ed?=
 =?us-ascii?Q?JNaLW40mk/ZcqAo+1IzYjkufpGRI5xwobneRhhPgHpLCP3/9QJhSj0p5n7vr?=
 =?us-ascii?Q?xTmhsbKTSqUkrzUp75LxYouISFcMOk0y4RVEIStG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6c2e13-26a2-458b-815f-08dc46eb09e6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 01:30:47.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM5Ru/wx9evIFeCl4sCfl8mqgZugfd3uHmVuADrq7y+7CQ2ZlAwiu2BfAK/Z90hIPbAjr5wSPDHytyuUbyTxhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com

On Fri, Mar 15, 2024 at 10:58:38AM -0700, Dave Hansen wrote:
> On 3/15/24 04:26, Feng Tang wrote:
> > Thomas' recent patchset of refactoring x86 topology code introduces
> > topology_max_package(), which works well in most of the above cases.
> > The only exceptions are 'nr_cpus=' and 'possible_cpus=' setup, which
> > sets up the 'nr_cpu_ids' and rejects the rest of the CPUs, and may
> > cause topology_max_package() less than the real package number, but
> > it's fine as it is rarely used debug option, and logical package
> > number really matters in this check. So use the more accurate
> > topology_max_package() to replace nr_online_nodes().
> 
> In the end, we have a bunch of hardware enumeration and then a bunch of
> processing on top of it taking CPU hotplug support and kernel command
> lines into account.
> 
> The hardware enumeration is relatively simple.  The processing the
> kernel does on top of it is complicated.

Yes!

> 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 5a69a49acc96..87e7c0e89db1 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1252,15 +1252,12 @@ static void __init check_system_tsc_reliable(void)
> >  	 *  - TSC which does not stop in C-States
> >  	 *  - the TSC_ADJUST register which allows to detect even minimal
> >  	 *    modifications
> > -	 *  - not more than two sockets. As the number of sockets cannot be
> > -	 *    evaluated at the early boot stage where this has to be
> > -	 *    invoked, check the number of online memory nodes as a
> > -	 *    fallback solution which is an reasonable estimate.
> > +	 *  - not more than four sockets.
> >  	 */
> >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > -	    nr_online_nodes <= 4)
> > +	    topology_max_packages() <= 4)
> >  		tsc_disable_clocksource_watchdog();
> >  }
> 
> I know there's some history here, but the changelog itself is not clear
> about what the problem is or how the patch solves it.

OK, will improve the changelog. The problem is nr_online_nodes() is
not a good option for get package number, it is mostly a memory node
concept, and easy be cheated by different kernel cmdline setup like
NUMA emulation and hotplug tricks, while it had an advantage of being
availab early before TSC get initialized. Thomas' patchset improves
the topology code, and provide a much better topology_max_packages().

> 
> I also kinda dislike the comment talking about "sockets" and the code
> talking about "packages".

Will unifiy to use 'package' term.

> I also did a big *gulp* when I saw this:
> 
> 	#define topology_max_packages() (__max_logical_packages)
> 
> and:

Latest code has dropped this.

Thanks,
Feng

> >         /*
> >          * Today neither Intel nor AMD support heterogeneous systems so
> >          * extrapolate the boot cpu's data to all packages.
> >          */
> >         ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
> >         __max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
> 
> Because Intel obviously has heterogeneous systems today.
> 
> So I'll buy that removing 'nr_online_nodes' takes NUMA out of the
> picture (which is good), but I want to hear more about why
> topology_max_packages() and '4' are the right things to be checking.
> 
> I suspect the real reason '4' was picked was to give the calculation
> some wiggle room because it's not actually all that precise.
> 
> 

