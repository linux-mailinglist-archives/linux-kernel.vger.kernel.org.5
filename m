Return-Path: <linux-kernel+bounces-89450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6E86F085
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091D31F2232E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC717573;
	Sat,  2 Mar 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHNEQCFu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8F1754F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709385447; cv=fail; b=oplo6tJ6tbdX7uBnRQ9dcV6p6javW9ks44rs+Ra+3GDnwFpOH9xO27qkm7YQa6Dm8Ua0UM2z9bDyt9qbnm1Z+SFPxOMtwazpwVyEhMRGh8u7i7Nq1ddUXd3K4rPxwTQv5iq7ZRwTQB0vHt6cf5NsQgCL4SLVNL2i6tyFBTEqeGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709385447; c=relaxed/simple;
	bh=hz+51oVgObz6tQwL9dL7u+Iazb+v9D0i3rB6XSlbBtk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jzQ362EsB+Xo2B9VLekAKkiIWBvn7h32RUMT0hPGrE7IDlroPuq1Bv2Dtw5lutBPHjIeZh8rOBusB+iYhOWwG1nbnH9bsiprywqLoyKvH4pBKwNRg6mbAe0j46tqMm5UnFJFDZgNAsIaFfNyd356UjB3RpIA856yazhFASX7cTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHNEQCFu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709385445; x=1740921445;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hz+51oVgObz6tQwL9dL7u+Iazb+v9D0i3rB6XSlbBtk=;
  b=QHNEQCFu7GzGDl+EuDHd2Is0+RypUnSVbuaLblQam8JwLiukQeuVSdjF
   AvjvFTI9jQ2XZBywPIeL/wy9TW31pdSBee4KAVSfvWrZn6mVdo3Ct1GTC
   39Zu3T+N1Puq8LxOsFiGRtH6MMh0l+bxWZTlflEZt/y7Ct7+c0aRMaEwt
   adjfCTXFn0eQLlOMRRMjHd98tbvnfLwUG/9Lxq+/Ghlm6Hr0rZBUIG6Vb
   LviypnXPQCa/xoNkurJKKQxFJtEzFjO7yRrLKZcXJcKynM56ll0G8bUcX
   CbTOgP5tvb9dWGkSb6Uo6hVX7vYRm5SnT6DLV0Olf5WdMooNdYCvGow+B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3787941"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3787941"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 05:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8619365"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Mar 2024 05:17:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 05:17:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 2 Mar 2024 05:17:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 05:17:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfOBGuHdqB6/s/fyDSphdZ7lzEESVYMtnwlUZIdZYfrL2YbSfuUpRJvyEIFc1otxhuahGVA5Nzljigbpl46h7UbDXyYhRC8yT2FUkm+oPep/F096LUPz6+s3ll3bf8MgbHfJQycPOuoWBi2mvAaOv7ZN6uoAifeVdl68jYdr+eFxLTxI/OaABW1BshUowYghMdBafbD0Z0iVkyugMpr81a3PRZVEx0abbimHybBUxZ4FZPI+kvQRafbLQP2OQoKNM0tmaNeWjrCx+MHrLOjLmdQ48bOW5JOTdriFsGYifsJSCggKx42GdcxhpOv/lJSy8RJJYdWWLyRRkRoe7aYwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV9UMNR1d1PDFltJWqYYoEOo8afP/5/nQSmbKexhfKk=;
 b=kT9TvQSjth6MlAOzUQTmmJjjYO5wgcFanMq9Ivd5PcWv8Ky4wsRdwqizqJam5TtwiQWuvbBOcABXr+P2zEfJNiBoXoF2PicUjwqEo2t11v5vUbAs6PNkYwzVQ/vQBSCgM88uyJz+ZW78eCEM9RX3Ha+DQ5VqCVMHPqK4ioUIDcbkY0A/5X0S1zGqqbLUfP90zhefRXNAwipN10frmHXCXxlsPxHJokmcceXOCInYXHz/LJCqU0XHNAFrLnPIdZ9neyj+wL/U/z48450HFpUtJuaBy81OoH79KTMWELERO9YfuXYxOj0f2/alzPbBsqjmqZSj6HNLnyVvkFCP/C1Y3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 13:17:20 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.015; Sat, 2 Mar 2024
 13:17:20 +0000
Date: Sat, 2 Mar 2024 21:10:30 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Sandipan Das <sandipan.das@amd.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: arch/x86/events/amd/uncore.c:601:10: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <ZeMlRmZs6zX+wqje@yujie-X299>
References: <202403020941.UCnNA0rh-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202403020941.UCnNA0rh-lkp@intel.com>
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: fc52c1d5-e25e-4997-7dcf-08dc3abb1759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TJ/37Y5AgZf70oTN4bhBMfbSb4nUUNOOkmhdIlPodfNemGAsyVhRPC8b+x72CIDRtLg4qu7j/0EGbwKK4lGJ+5GJezDeXgN4Dj+0mzKkI4p884PbY8uZEgarAgnJ23E0AGzRqOAKc39iXNMLPPRNcPcO5zeazzLvAYvucHV93C3QBj2bHwCFyb0/ZWAU3ZW5JwlquKfCSmnV+daRANcmZJSA+yFepeMBGiiRhKpqnly0Z7JmpW2LKFhmS+ccy5o+6fTErEh0qDFDHPdbw3lqfym3uBvMO0vwHptB8B+xvP+zgFIHgNoVEYIikIJlrQHFBg4NqVaPDnukm3psFCrtP5W8rc9nm6OTcdGrrhpctp9L8caCzccPxzJskWt8GHIYUquFWxz3DHy82YEOvRmh1EP7yjc9FzFr2Qs7CObkeaDJCIuj3BshYXgcTKmU89D/ydj54bn4+NCwreSY0K4LY60vk0LoPGoaRQTFnlkRWXdlmkYp02pbvJG5dgEMCDwDcpSM68XvNDqp3wITWq/j2akVahDDywYjrGT8DvuWAvHLPoJ++Xheote71P5Kzi0hXW3qilJfllz4PKeYUR8Kt6XyLO2O1XBIy4yY/l+xX0YGJMqfnwdEDvaj1CYcqtt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0q3J6TgJ7039Y/onG3XDr1/Vu8LFscsmRiEkEkUOvRyu2HwlAF5t67l2bF4?=
 =?us-ascii?Q?HL8krduajOBaJNFxZUNtHV/29iRB0SrFf7aXiKjRELSTrVS3Dy/ZGr8aGw/V?=
 =?us-ascii?Q?Fbw6i+wEFRFruyvrFTsyOdEgMl3buhtVCRFzkskNDyIjzJczAYgDS5/8/fOy?=
 =?us-ascii?Q?ORaHml/s6A48G5m9GpqAPOcFMXqQeXIZUVCXH7di24DRPK23RTOqdZMSbr0q?=
 =?us-ascii?Q?NUyZO4JiXmrgZkm5JfHw0lfrBYpOL92H3v8vxElX7clg8dqkBFuIxk1ihkiQ?=
 =?us-ascii?Q?q2DnS2W6xT98vp+fDYbgPSXho7WuGZyKHB7qgqY9jU+rATDcQU8oHxTIWRzz?=
 =?us-ascii?Q?MXSRcgWRtQmd2XLIaDT88Y2viDv6nuYWi2vfpt0mAbYoMnzCHUg/ELFSqkIL?=
 =?us-ascii?Q?7PoTQCkyU5+y3GYgl1TBu97NrMdZXKZr5xnDiF7w36Tx2ci1guHb4bLt4Pmf?=
 =?us-ascii?Q?VBh0nW9vncjlRD9uCiBAgUMkrBmJY6XcMXXQqhpOLE9ZW+M2F2Y+DtXYinV/?=
 =?us-ascii?Q?scFX3xbhEQwR9rDrhXekaaYrBaWjFpyC2h1sqpPL83bZJdoBHUPand/tHYbR?=
 =?us-ascii?Q?de7V8nMvIOluMTcAUCUqbyuVwWBVz95wAjIEQ2TZKkKPiLpc5kO8CaaQA3s9?=
 =?us-ascii?Q?8H1tN4doTwB559im/j6imY3oAIsGZ4xaOikedL+JHpkiyrsy3m2ZRMDYxW+4?=
 =?us-ascii?Q?vDyTGfP0NGHY6GtEuvKludpg3jtcpEqmD43Xy9t+Uaa2cLDvpV5Po/7vaRyO?=
 =?us-ascii?Q?yndpQMMYrj8Pqb1GorWt2pYyXH0a1XIvj7MChlp8uehoHsQLcuFduSj2DmYJ?=
 =?us-ascii?Q?KE5COaBu3ouIXYk2x7IY5t0qpj5S1ge1VwMFbo1Ovr022eVyOeFcCQjRqUGu?=
 =?us-ascii?Q?baM1PW41VIwHgnACV2VXl6geDFU84el76aWLpF7Iizc5riS4zdLYKof/mS1t?=
 =?us-ascii?Q?/LgNxvdNpUkeQgSlvFUCTBlofMOxrd7sGsK4558QR+GlZTbVp1k/UL254XGo?=
 =?us-ascii?Q?uBibV4OXzqwIQEkZqGD+o2isgyzur4LEETVTfXE3WZq5b9kc3uqC7jwboPSU?=
 =?us-ascii?Q?rnbEP0nNt8ysSd+pdrLXbUXJej90x/M+oDHTPuA/6FvRIqc3PgIGzJwE8UCu?=
 =?us-ascii?Q?5nCg2IFFzWfQTBZLhwvkIHemqWq+rG61Ge8uF+uKdAiC8OOf7KGgXZaxuIjn?=
 =?us-ascii?Q?nUoKcaUwcqCtQ+91KQ8PvR2qPUNzubW6p3jgNgiXX3btpMWBQc2k4uz/zZZZ?=
 =?us-ascii?Q?OZqx0fltW9IkdZGLoqAZj737kejvbNn0OFXEVGsx2b/Ow5Vncup7/NT44wM9?=
 =?us-ascii?Q?uwPBzt7nyrJHiIvZ2XuuzTE/BIjYkjy5kmepuCl4rmb3CwaeVfI3WjudsTzZ?=
 =?us-ascii?Q?RFnyQMjIHFtUaZ3c2wavfQwSIHvRBnMDsq0C+yI11cXBje2YNHC6fl7vZBLl?=
 =?us-ascii?Q?4ENp+742rF9ZT7WxEfoaYyJHEjpzt+gha61dT5fyym8O+WkEpdUwCtcJKsL0?=
 =?us-ascii?Q?xTyYzxUD01NWBodMoh4sQt2e8ZeGwT00gWyx9pso7RSSbqFVy/UaMYbl1yFT?=
 =?us-ascii?Q?Vb4FSuWh21g48ejv6T+XSOmkQSNbzkawWcCc027w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc52c1d5-e25e-4997-7dcf-08dc3abb1759
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 13:17:20.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT3xNNfe4rRS48VdUQhBQLvPhVaZy8wLgxV9sQhKBNUEDZ/wF4iSOBhEMKrgH6FPmRGfhx5PXbQwrs7rA+WeKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com

On Sat, Mar 02, 2024 at 09:32:05AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d17468c6f1f49e6259698f6401b8d7a5b90eac68
> commit: 07888daa056e809de0b6b234116b575c11f9f99d perf/x86/amd/uncore: Move discovery and registration
> date:   5 months ago
> config: x86_64-randconfig-r122-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020941.UCnNA0rh-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020941.UCnNA0rh-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403020941.UCnNA0rh-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)

Sorry for the empty warning here. The actual sparse warning is:

arch/x86/events/amd/uncore.c:601:10: sparse: sparse: incorrect type in initializer (different address spaces)
arch/x86/events/amd/uncore.c:601:10: sparse:     expected void const [noderef] __percpu *__vpp_verify
arch/x86/events/amd/uncore.c:601:10: sparse:     got union amd_uncore_info *

> 
> 
> vim +601 arch/x86/events/amd/uncore.c
> 
>    582	
>    583	static
>    584	void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
>    585	{
>    586		union cpuid_0x80000022_ebx ebx;
>    587		union amd_uncore_info info;
>    588	
>    589		if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
>    590			return;
>    591	
>    592		info.split.aux_data = 0;
>    593		info.split.num_pmcs = NUM_COUNTERS_NB;
>    594		info.split.cid = topology_die_id(cpu);
>    595	
>    596		if (pmu_version >= 2) {
>    597			ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
>    598			info.split.num_pmcs = ebx.split.num_df_pmc;
>    599		}
>    600	
>  > 601		*per_cpu_ptr(uncore->info, cpu) = info;
>    602	}
>    603	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

