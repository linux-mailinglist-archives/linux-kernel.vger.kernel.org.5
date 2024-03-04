Return-Path: <linux-kernel+bounces-89974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7886F86A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4911C20A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF817C8;
	Mon,  4 Mar 2024 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9VzEelt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FAA31
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709518396; cv=fail; b=pEKp+JXL2qfayP4hbB5vFBUesY1FCX7aVyH/e2HqtCU375zQyGpAQjDFdkSjE/X8dSRRlViXjZLbZ0EdnBfgur6xwT1J5lZdTNPjAgvS57fhHySgaO5O8JbAzRfaOYGQcF87HOmtuk0C39p1DHRqQWlKjoD4Pyymc1TpV+mwFIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709518396; c=relaxed/simple;
	bh=TzEpoJZQ011PHaYmSAl7AszDR6so757sm71O6GnSrNg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jPuq0/QZO71UUekeYw120iKPemD41c/UTIUsZuldoxf+Po8hjLxT2V6l/kNdL79mlGLJIBXl6sg4m/Te3/1MlxrRKpRQfH700hsZQTkWNsD4Voqkrm/GgWiI7TYJWHKa1cLOsGmXNjUK6bcLfbUUhkNHFoAAlNA+Mp+fIuQzVEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9VzEelt; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709518394; x=1741054394;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TzEpoJZQ011PHaYmSAl7AszDR6so757sm71O6GnSrNg=;
  b=g9VzEeltk7o66vkYAapkwrG5EbZ47W5VSFjQzT8PloUT35pbMUbO+DiT
   rvbzRJqytapIb+SYQs3Z9Vnbi6vHid9JpWhVQY0zizhzZS2V8H3PGwS37
   /WHdW+oXQ01lB8Jisq8H0VvNpE8enSN1+U0IRfpUMO3Uh8fXpmolsVyh8
   1yypKqgd6xqpyXVbbY6g+hstNFal/D9r9IJRV7NVUvwCSQHVtfLJ+cG7s
   UXBr6+Fkk/1Ezinu878RD1szZuApj7RQtTu/AF7WWA5ITdfgt8vI9GKJR
   51rIaT7NEcYm7LEBMpHr4OzVybgVVrWI62ESWGREfOkedya0AWJbY8nq3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4158445"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4158445"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 18:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="46340371"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 18:13:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 18:13:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 18:13:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 18:13:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 18:13:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM5iSX0WLRweHbi1pGW2iw8c0W0yLOO2jh23mu3GUaMyZXFhkg4E5ukK8QavDrRjoWor5de7linvKPrr+WW6Rj/cIfAgbEt9v62aJRiqConb5aYW73z4shKqaHbtuIhHSyrNQ3VasDmV3P6S0Wf27Ldhk24D+gUahMhc0t5rDRrEAHVvluQD/JLTT4s5di8Bzzt5nsMaH5cHXnBCVDvKCGM0wePEYytDXmMPYBFI3KQWXzmZAuceGGKHx+sohW0gtwEFnBIByPz9HN8Tt7HDBrh+9AVgAFfZM4/I9nF5xXWbdG38hAUawQYsVmO3kPUyAp3SeK8HAu81jGwxzb8ANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBc0Ms8NfIwwTNI6rqncuRYMq39cRb2mXr5HbuPZPzk=;
 b=eev+NXCD5PNfoYxbqHbtZb1mcOcgsIBJdKmEv9YYnTQbUzzTL7/DwIwbiFXkqclHduI/xU8zk0pdgSrpHOIk7ocgzbo+KCTbTN3PYnN0Xex+46wi73omAuFitF8GJzDDLvOCmw/+p9F7pqMhjq0+t8tR8kejeoQWfhMLeyZUailixqMHMy3vk58m/JhwABUi4WCoqEDyn3DY/NWTtlgcfKC9PP5GhVSQon8ad7Hj4A6I96R0Si/sNN2uOCIRfZsuzY8dF0MtLNs7Cz0Ptwg4huvUmmTBoi45z3cCX7xTaEJCpzllyZQLGbrjhcDqY0OxvCT8kG+9+nJ/yhTq+hWq0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8535.namprd11.prod.outlook.com (2603:10b6:408:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 02:13:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 02:13:09 +0000
Date: Mon, 4 Mar 2024 10:13:00 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: Anna-Maria Behnsen <anna-maria@linutronix.de>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <ZeUuLPXfLCmB39qq@xsang-OptiPlex-9020>
References: <202403011511.24defbbd-oliver.sang@intel.com>
 <ZeUWreWcp4UWQ081@pavilion.home>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeUWreWcp4UWQ081@pavilion.home>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8b6b9c-893a-452b-82d9-08dc3bf0a2b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMP0dMmRfMunwftZ0VnhrNnCrbw0VAyEVpQqkJ7jDP5122z6YD1rMU/s3abPrtzBTvmIKR+BsB0m7H5JACzYR0LuF41ovsKwHm+QkER9/ejYLV6khpFhAPykJFfY/2ey9XAO1hpbyI0fGpH2wbUBbl9C5lCkTnTA/GL5953BzUrVSu00U0cEdsfBKA1aRtiwjepZ1y9Au+eIAFS4ewGM19e/g5uX/bsVY4fuN9x+7lw28QC5dMtpr/BCzkMVnQIA2L5D3RK1lnd2SFtr3/cWBpPnSRff36SIwBJwwCCRziPFnvjx7HKM3L7vKKLmYUcKPXz7jrZ+DykogHyRIC5JmLQgh/v/yGJZDrjmwhaSXqBMR9ALgwNmUil7Ollt4YLfYvHqqojpY4765WimEa7puDWr1UiPzcGh9bSAIrc7Er29pvgw7BXS/u4v8q1ueycK3S7YcBloYm1aCsfFyaNdZWGAlf7XjinkkaT1QYFXCA/Hbyp7d2XKZAyuuHWWphzBcTyFQrh7srCgOl306gKyWOsht9Lj2Oz5ZwemcFN6Fmfz6sql2M3EBDxh6mj04IUGo0ugIdgMcwd8a9uLHFFmlEsGet4WN0GiMcEvyEWQiWIgP2JPll43i4Pc6DZN/Xot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qelgy+pCwvMQFUvhL2gdxQsdBoJwj+k0dmYdCRkzI83MbiqyEnIb4KTl2l?=
 =?iso-8859-1?Q?ENuwaQIE7zXhnPtuWvTgYtXK/Fnb5JB6iVaqAlzvutOXEGDFMf9t4Y6iLG?=
 =?iso-8859-1?Q?VeEP6bzQR2OCAApWp3WdV+2sKTjUQ46W6zNeg8hHxhzL1kpjOzla3ygj0I?=
 =?iso-8859-1?Q?/C+ly7cx/ysXDRC8F0NwMOaHeWnLNwJ5ppbUBC8iYRwz9GBkhjq42YU0/q?=
 =?iso-8859-1?Q?TMx2PmsBLLhViMDdU0hd6SZpJYDVPPX0+jzsj2FAAG7/cd8B9p/C5CJjqj?=
 =?iso-8859-1?Q?ESF5aOpwHblbSFXIIBp/hR/kgtNnYvvkLTTsENE4qXT7emHGHZK0y5K2gJ?=
 =?iso-8859-1?Q?k18KZmZoEE6i+r8AsMzeBHy2Jqa7FQ7s3g8H17nnEPz3WtxvigbpJsISqj?=
 =?iso-8859-1?Q?tuaoRpZ1o80/bW2xTVdLtVq72yICYsrjIy4MFZVLFamoqQt61AzHUfM4SU?=
 =?iso-8859-1?Q?4Z6eZEihEKbWn2kOxxflPXp1kaZvXKsca3GMx6Eb81qsGsK8nOJCmp+EFM?=
 =?iso-8859-1?Q?QC6jLFtnsP96RE7Bl6bc1jh8BaO1/3mKNrFZJ00Jl9lPVXq4CfRLMVsXJt?=
 =?iso-8859-1?Q?L7YYfV2ci7xylGbThC6YeRusp3tOT3SGmp96AhmawElkKCJTAIKRcrxYZz?=
 =?iso-8859-1?Q?B/XijUuksXOWGoXFF7oKLrO1st+P1uwiNJI0NnxfC27CYDL3GYYzI7nMEb?=
 =?iso-8859-1?Q?dkXb9QD5KcUZvnmwF9m6b8Vy8PP/WwYNdJA3h3BxavUVZR6rY2rH1g9b0p?=
 =?iso-8859-1?Q?a/DBPqPNACByw005TwGUSCW9Mn0Me3tG048w+LP53OA5XtNXVoTSLHPOKH?=
 =?iso-8859-1?Q?8pzOpQCZNFk1mRCIwQYhBDPq0YrVD7DcBvSKxJBYu6VKd01wF8HF+7V+Wl?=
 =?iso-8859-1?Q?nfimMF12hkL8OEZ/cBEtHS95jL2GXg8lHztqz0t1VrudvMkkP738CzOHel?=
 =?iso-8859-1?Q?wb17mvDbapxwmWvQXLWorejPOMiU5haGK/+TD7qO/EwkLERiKz323h3W8e?=
 =?iso-8859-1?Q?skBlBMUY+BMKxoAhLLLDNP3M5PhpnKUiIDFuw2JCohp4IAAFUCv3HFpsYL?=
 =?iso-8859-1?Q?YvpIWFoyqHlJKqFhreZPD1RWlcMOqgnziYgYfQ1TiMevnvOoBjO0CicYUd?=
 =?iso-8859-1?Q?CZay2Taa405tzo559kPKporrsIk271Q+xU/Q4nln6kSLN+iHw/PmyfoWpv?=
 =?iso-8859-1?Q?Yz2I1seBpu1NVk0AONcaHd0GEHoY+rxJ87Xt0HFVCkooOOPKHc7iSkcJ6P?=
 =?iso-8859-1?Q?+UWwRS6w4cwLHJ+iEYpmpV/XBckz7TRMX6zzVY6GVBaoq1jzdz1Os1YNUE?=
 =?iso-8859-1?Q?9337sBarqqdoRQXnlKw/Xpfyj+ND4/o8PYL0vkNpxV9KH66FhsvwUJgiop?=
 =?iso-8859-1?Q?eaWVkPveW3cGE3fGDrpSNCfoGMD8YtE1PynAIOO7UW7+iE1kkVNXRVBKTI?=
 =?iso-8859-1?Q?vijfr5GmG6oFhzg/q9H+OxJynJA+f+isdOxAH8YzzWGEBxpm+xpl/EaoLc?=
 =?iso-8859-1?Q?nphpFcOfNvNCNJAv+fKFby1tPne4Jzn7oYHNu59bERTL7iNsOWJQFkUGDl?=
 =?iso-8859-1?Q?c34yNEgsaPg+ldTPosTHPyRkxivlO6K8yie35UP2AcX4/ydZID+jOAnNAI?=
 =?iso-8859-1?Q?OmDkO4zFV5NkCRHiWIfIXELOO1ye/x2mga?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8b6b9c-893a-452b-82d9-08dc3bf0a2b9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 02:13:09.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJi0ADTmtD16HbxR4HlX5LpjMVsS7zI9udVMTPXQSwe/00qrNZbkmOhYMYIxKScvlKsaR+Xf+FTGuAWGZ3JBwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8535
X-OriginatorOrg: intel.com


hi, Frederic Weisbecker,


On Mon, Mar 04, 2024 at 01:32:45AM +0100, Frederic Weisbecker wrote:
> Le Fri, Mar 01, 2024 at 04:09:24PM +0800, kernel test robot a écrit :
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -1.2% regression of netperf.Throughput_Mbps on:
> > 
> > 
> > commit: 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the hierarchical pull model")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/core
> > 
> > testcase: netperf
> > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> > parameters:
> > 
> > 	ip: ipv4
> > 	runtime: 300s
> > 	nr_threads: 200%
> > 	cluster: cs-localhost
> > 	test: SCTP_STREAM
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202403011511.24defbbd-oliver.sang@intel.com
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240301/202403011511.24defbbd-oliver.sang@intel.com
> > 
> > =========================================================================================
> > cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
> >   cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf
> > 
> > commit: 
> >   57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
> >   7ee9887703 ("timers: Implement the hierarchical pull model")
> 
> Is this something that is observed also with the commits that follow in this
> branch?

when this bisect done, we also tested the tip of timers/core branch at that time
8b3843ae3634b vdso/datapage: Quick fix - use asm/page-def.h for ARM64

the regression still exists on it:

57e95a5c4117dc6a 7ee988770326fca440472200c3e 8b3843ae3634b472530fb69c386
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      4.10            -1.2%       4.05            -1.2%       4.05        netperf.ThroughputBoth_Mbps
      1049            -1.2%       1037            -1.2%       1036        netperf.ThroughputBoth_total_Mbps
      4.10            -1.2%       4.05            -1.2%       4.05        netperf.Throughput_Mbps
      1049            -1.2%       1037            -1.2%       1036        netperf.Throughput_total_Mbps


> 
> Ie: would it be possible to compare instead:
> 
>     57e95a5c4117 (timers: Introduce function to check timer base is_idle flag)
> VS
>     b2cf7507e186 (timers: Always queue timers on the local CPU)
> 
> Because the improvements introduced by 7ee9887703 are mostly relevant after
> b2cf7507e186.

got it. will test.

at the same time, we noticed current tip of timers/core is
a184d9835a0a6 (tip/timers/core) tick/sched: Fix build failure for CONFIG_NO_HZ_COMMON=n

though it seems irelevant, we will still get data for it.

> 
> Thanks.

