Return-Path: <linux-kernel+bounces-134874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0589B81B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E949282E1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFEA2232A;
	Mon,  8 Apr 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccwYlMIZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477125605
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559884; cv=fail; b=uly33pR4gVdu6a8lAlUcUa1i2qsFJYHmmo6TuIqy9FDp/GZ6ujFJn3yzLYBrtH73u3ATyvQJ7h60PesRiIhOLXDR2EFUYDcHjXKOWdD8Y0ACl3o1DUo5UQJVDkIFOWAS97S4bNWkFqmVhjavmOEfkZ0kUHdLUTmzHUKhG/3EU6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559884; c=relaxed/simple;
	bh=ZDRe4gnNDX2TKqZYTpHh6MpqEPAnIbZ4RNMXXNcVqf4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lPgmhv70z1UhRzAmv7tbamywKdgpFsIiEEwvFAj5RIHnI+D+NYa+D6wLhOITGvPHW4yoy94PQsqigAqf+OWt4qzafzlu/bkvp3djEBlc2lTbcHMg+qRUorJ46+J0MbLpKXoMVnO64fARJMVWRXSm3mhvRPJ9CsG8+OKC1J7QxHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccwYlMIZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712559880; x=1744095880;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ZDRe4gnNDX2TKqZYTpHh6MpqEPAnIbZ4RNMXXNcVqf4=;
  b=ccwYlMIZ4Jg+/v/u2qiMFjGkNrEEMl5HYU3xO95VnRPIuT8WYoybQGa9
   yoc+lmIGgdUD+VRTiqic49/4XLGgcNZtSPQTmfAL94HTL4npUrHGNYCJT
   /hf0PeUGc7cNrodBdD/jnsAVMy2oyx+kfSo+12Uf+EQ3Dy9uzDdBI6DS4
   6/WUyQo2v1xEjHmA1WUgNZXhLBc1tca/qAAFRWcseHaOUft7G3reCLQ4T
   YpNubYnaq2xzJn7uei9Op/cZBO+GEKVGLz4mZePzDYyJfs4KTn43VgNjj
   hnTWlfVV7r51G78BemwSIzxx1nazGeuuVTGMksiKGV6QZS6CC19/ed1de
   Q==;
X-CSE-ConnectionGUID: WA3qhSMZQxiGqHeixzi02A==
X-CSE-MsgGUID: cwGBl9T/TjmC7H4OUmQP4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7685211"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7685211"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:04:40 -0700
X-CSE-ConnectionGUID: +OyOUO7zTXu/NeWAd+KB3A==
X-CSE-MsgGUID: KfFFg9CSSsWfuTk/fWScDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="20227683"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 00:04:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 00:04:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 00:04:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 00:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCx3+ie9kxtgLDKL/aM3wE/cw9PTVfbN4E8ljC6GD/DRoMiMKWWKNs0UN16ZnJHCrnng6U4Tl+UfHA9/TvUXfPynVUVFRo+EnUPhMbbTNutbSha0KnJC5q2ImrYEL7WUSCmGIUTeF7wZt1RGNen5W3D56+wdKnU5vE7ohmi78F+eraRws/XReq3S0ZOXZKco0Jjbh0/D97+WJ9FIpHujIc9ACzI4QzZBUD5Bv4k5wQtf7rPre+g/pV+Y34+Cnry59CGOzATyZpWyapRCqHDuHgS7N/UAhE7XuOTWzh4Frk8tE9Fp6JL7CP7Q6OFfh3Pk2YgVgV63JsSu4JIczlny9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjQ5vrpFbqMC+pQt5zz5x5pnFYfJgmQelqfA7PJ0Ig8=;
 b=VUaBwl3h98D4zuI0m55LPsXL2XTFMxfLHHWjEzYD59vBk8bXriHP/mvbCw+SsJnW6fm+MEHOa9kgpzzbHuxvS4Ozmu4UxFMMJ8IOKYRd3iyCWXhWpPN3ij4XWZpDp6/+q4AVEyYhlMuD/fWC3y66PPg8SdB3vRxuUFgU9KTlXdqbet4LWS3uIJgF2U/AY0p8tpLSUikIzhBFT6HpE74FxVD9SEjxTJvcUpsRsl/yXoL3C5jiMsCi1MzfMl/ZudNkXMYSwBU8G/Siloytn9Vul7Voim8/VuW49FcLNsQij19RK2psdwRsgnLsOvJNmg95gGxVtc9rSm47oAAfOWSjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8434.namprd11.prod.outlook.com (2603:10b6:610:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 07:04:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 07:04:35 +0000
Date: Mon, 8 Apr 2024 15:04:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Daniel Bristot de Oliveira
	<bristot@kernel.org>, <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [bristot:dl_server_v6_try9] [sched/rt]  3d2f07d039:
 unixbench.throughput -5.0% regression
Message-ID: <202404081444.3abc3f64-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8434:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8KTe7RfQ31JvtPFJMz95rUOAvEYV5p6qJf9sAmll9jGNp+TFas6Oe+o3i4XE4qKZ/9O8bqYL001YHEG7xZ2ZhL5/mFmP6EDBaZ8ealJuC5c3TvnbASPBRvmdWMmfJvQh4Z8meZYo2TsE0vE77dDlbV64p6wDnlwAOMPz9i/++G685IkDmctFLYJtbVM6yy3evd48sGSuXzPkka6UzIzwqEroplku6r9FhMn+vIfLdSfTmVvbbRbEtJHE32QF9BBma2sBpe9pDVpyIrbEoqO6+0t1lC4bcH+N+JfyGNoui+VCr9UoZbzAegoKewRpcLjy3tSeOmYU0UTSO5ln+BuQm8lc/uqJUySL/MP/pxhXqcN87abGTC6z+85ftLLJz6/+iUCCn5lu0SzNBnHIHQOCeog0UJMSSnKXrVYJ2KK2mxTCs16xlbVV5dgIOnpcAC8yeHVkThyPqarXGnqbP6WCxhcbqW+JOOTsaaTh9pBEabY7gMn6p06PYVcoVIfp5GWmd1WXP+GZ91I8dohWDc3TNCUMtW2FfYI6KoRaMdo/sjQ/G5R8Zp8bOW74aE55k/rbw3GeAHCqlfhRz6Q+lGAd5aD9Xcf2UgLFbDVVUkhqFZ88meyx6NxUCgIO2OHzpOt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DLLuzyCk3QvwH+oijrbNxSBGpInNmKTytijv2ixYzajW6mXSZsUIXbpTe0?=
 =?iso-8859-1?Q?SaNsmLtBNWcrshUJ09wx36lSIpLdqy3EpsZH7d8BbJLBjEDiHk/Cw97T3/?=
 =?iso-8859-1?Q?9YurjoHzE0b2ruPiD1KLyeDIia0kEKcHNvP2eSoE9DOnTTx6TFNefLXbP/?=
 =?iso-8859-1?Q?qgLZ0MDpR/JGlZy07hcVr42jaHTzQ5hgLCANk2Daj5HzL9SgsPFb0essb7?=
 =?iso-8859-1?Q?RcX67KRk7WQDAm2FGDYXxuT+qeuy437/2rTqJHO9uXfWx2Nlrg6uaecvZi?=
 =?iso-8859-1?Q?T7XbURLyv6OL9flQIyLCMp6BdPDqPaeeDkM2aucKIpqsi6XVo8+tvVYUal?=
 =?iso-8859-1?Q?0a+toL+U0h+K2MXTFyxPJNwJcqoWeTPtRSEnDLtPXz5KNsmpTbBFfk0q0c?=
 =?iso-8859-1?Q?GtPnDZvRR5ggP+yfT2SvYE0rNZ9rNq12FjJ9GGdDkGYSBLJzc7NtrMqZ7S?=
 =?iso-8859-1?Q?P5xjclXMusmSwRWEG+05nhKDeKzVhq8469garC6gL50aNc54QVqmg21Lx1?=
 =?iso-8859-1?Q?NWaYziffvkYxVXU71K3gL5p/3zJmX4Bdpj1CIrhCsbaaK34+rZEIrkQAyJ?=
 =?iso-8859-1?Q?zWoK6ffMgkc35dq7BKaPE1PbikRP3qFVnvouOMz/U8I1GyRtaArnbwLXN6?=
 =?iso-8859-1?Q?U6J3kQXrjKd1QYOYKa5lMgORuKUC7MX7dORv/I8IgIV9VNbZKQRkHgUFis?=
 =?iso-8859-1?Q?TQclpBlrceEauJsWyZ8d+4WbPbho2QwBxgkSRx9LPKm0qsa/ZOPHPL/muz?=
 =?iso-8859-1?Q?tf8FONHRusgl7XN/8d1OzgY23H7JLdGZ6noBEpe02ip8m45YSFNKv6Xi+A?=
 =?iso-8859-1?Q?mLzGXosjrJLKPEowzb0qPQ51zI0Huw/RVALkaCvXVF4ZMf+e0GQBAQfejk?=
 =?iso-8859-1?Q?pfex5U8uqNs0Y63pVzX08qFnVA/vphKTd5opDf5ay3OQ94HSBcdLli3dt+?=
 =?iso-8859-1?Q?UvcDU1N9EgmljK/zOmsDmb/LQx5bsikUod35vfp26aSHQJkzmN9wDO6huh?=
 =?iso-8859-1?Q?KrBAONt/RnV6vdzxfPi932/MqzqzgPUYvXx0Y2DDgIDZNXcDBTwWH2G0eR?=
 =?iso-8859-1?Q?+i3b6UaPJR1dpoflTt6SbKUJsBDSFtuWkIs2mnGJqVupTiiGUGLZTJPk1E?=
 =?iso-8859-1?Q?DJ79rgZDywA3vQHEuGSrAyQVbiReK+3Jwm2UHVKkv2G9jmAm9fqP79kGpk?=
 =?iso-8859-1?Q?jmEQhpnWFNfJevBhcNKaaA5wjDV4MRgurIg0ldhAeVZtVLzdGRVKf61cMk?=
 =?iso-8859-1?Q?BA5zazsFsUcGAZ9lslN015FnHw8FSZTfF1G9NhGHYJB5+uF6VDgGqVwsjS?=
 =?iso-8859-1?Q?dqSfXdvRbWUBJQwrVrM5RHgvvnLEVxfZ5fpfQw1stuhupCGCQ7W/D/uhCB?=
 =?iso-8859-1?Q?rWvZDJzlJvmYX7hLNO+IyKj1xePyjywePHpnnNuuAn0peB2C+2nfzMvWIK?=
 =?iso-8859-1?Q?xKA4h+7LOae4JZwymauxNlMBSphb/akZ21mXyoP4POAf5g3GUTYHb58515?=
 =?iso-8859-1?Q?O//RwtFptY+7bVs2FcHKJDAcMAC+EvzdUscZj27EwJv2GJhr5fJo0NhbQ4?=
 =?iso-8859-1?Q?khiew/6Jnw2yv7x5FHQChEWhuT2s0l2BzdRV45v2VUbXhaZJD7GNyD9pXI?=
 =?iso-8859-1?Q?9WWF4lvYOybwROqYEpOMNntupTZ5uykw2wQNh2we6P4Gf2VL81jb1ARg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bc0db7-993f-4f2e-9339-08dc579a260a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 07:04:35.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDfmJE371zP3hf+W6yjJx/Jy4JtQTGWyf25Sh7HB0WW6SSvgf1jK0qyAn/4i9Ugjk0FM0gOXPm3sKHIaTT2fTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8434
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -5.0% regression of unixbench.throughput on:


commit: 3d2f07d039b863082bbc4c9c541ea2b8fa9a5b1a ("sched/rt: Remove default bandwidth control")
git://git.kernel.org/cgit/linux/kernel/git/bristot/linux dl_server_v6_try9

testcase: unixbench
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
parameters:

	runtime: 300s
	nr_task: 1
	test: context1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.mutex.ops_per_sec 142.6% improvement                                 |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=mutex                                                                                |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404081444.3abc3f64-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240408/202404081444.3abc3f64-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s/lkp-csl-d02/context1/unixbench

commit: 
  f8ff3b9eab ("sched/core: Fix picking of tasks for core scheduling with DL server")
  3d2f07d039 ("sched/rt: Remove default bandwidth control")

f8ff3b9eab15a5a9 3d2f07d039b863082bbc4c9c541 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     12.87            -1.0%      12.74        boot-time.dhcp
      0.05 ±  2%      -0.0        0.04        mpstat.cpu.all.irq%
    825446            -5.1%     783024        vmstat.system.cs
     10625 ±  9%     -54.1%       4873        vmstat.system.in
      0.60 ± 74%     -71.1%       0.17 ± 86%  sched_debug.cfs_rq:/.util_avg.min
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.max
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.min
    691.03            -5.0%     656.18        unixbench.score
    276414            -5.0%     262482        unixbench.throughput
  81128149            -5.1%   77020343        unixbench.time.voluntary_context_switches
 1.079e+08            -5.1%  1.024e+08        unixbench.workload
 1.003e+09            +4.6%   1.05e+09        perf-stat.i.branch-instructions
  15693493            -2.1%   15357187        perf-stat.i.branch-misses
    829525            -5.0%     788190        perf-stat.i.context-switches
      1.86            -6.5%       1.74        perf-stat.i.cpi
 7.301e+09            -1.4%  7.199e+09        perf-stat.i.cpu-cycles
 4.821e+09            +5.0%  5.064e+09        perf-stat.i.instructions
      0.61            +6.3%       0.65        perf-stat.i.ipc
     23.04            -5.0%      21.89        perf-stat.i.metric.K/sec
      0.12            -4.6%       0.12        perf-stat.overall.MPKI
      1.57            -0.1        1.46        perf-stat.overall.branch-miss-rate%
      1.51            -6.1%       1.42        perf-stat.overall.cpi
     12354            -1.6%      12157        perf-stat.overall.cycles-between-cache-misses
      0.66            +6.5%       0.70        perf-stat.overall.ipc
     17446           +10.8%      19325        perf-stat.overall.path-length
 1.001e+09            +4.6%  1.047e+09        perf-stat.ps.branch-instructions
  15661288            -2.2%   15323663        perf-stat.ps.branch-misses
    827195            -5.0%     785930        perf-stat.ps.context-switches
 7.282e+09            -1.4%  7.179e+09        perf-stat.ps.cpu-cycles
 4.808e+09            +5.0%   5.05e+09        perf-stat.ps.instructions
 1.882e+12            +5.1%  1.979e+12        perf-stat.total.instructions
     10.56            -0.4       10.21        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     10.41 ±  2%      -0.3       10.06        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     10.64            -0.3       10.30        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     10.17 ±  2%      -0.3        9.85        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.84 ±  4%      -0.2        0.66 ±  8%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.60 ±  2%      -0.2        1.45 ±  4%  perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function
      1.14 ±  2%      +0.1        1.24 ±  5%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
      0.54 ±  3%      +0.1        0.67 ± 10%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.44 ±  2%      +0.2        1.64 ±  4%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +0.7        0.72 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.dl_server_stop.dequeue_task_fair.__schedule.schedule
     14.75 ±  2%      +0.8       15.59 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     14.66 ±  2%      +0.9       15.52 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     11.63            +0.9       12.54 ±  2%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.88            +0.9       13.79 ±  3%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     12.66            +0.9       13.58 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.52 ±  4%      +1.2        6.76 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      5.67 ±  4%      +1.3        6.93 ±  7%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.07 ±  3%      +1.3        4.35 ±  7%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      0.00            +1.4        1.35 ±  8%  perf-profile.calltrace.cycles-pp.dl_server_stop.dequeue_task_fair.__schedule.schedule.pipe_read
      0.00            +1.5        1.48 ± 16%  perf-profile.calltrace.cycles-pp.enqueue_dl_entity.dl_server_start.enqueue_task_fair.activate_task.ttwu_do_activate
      0.00            +1.5        1.54 ± 15%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      4.28 ±  4%      +1.7        6.01 ±  5%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      2.19 ±  9%      +1.8        4.01 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      2.42 ±  9%      +1.8        4.24 ±  8%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      2.28 ±  9%      +1.8        4.12 ±  7%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
     23.30            -1.3       22.03 ±  3%  perf-profile.children.cycles-pp.poll_idle
      1.82 ±  3%      -0.4        1.41 ± 10%  perf-profile.children.cycles-pp.update_load_avg
      2.90 ±  5%      -0.3        2.56 ±  6%  perf-profile.children.cycles-pp.schedule_idle
     10.42 ±  2%      -0.3       10.08        perf-profile.children.cycles-pp.ksys_write
     11.48            -0.3       11.14        perf-profile.children.cycles-pp.write
     10.20 ±  2%      -0.3        9.87        perf-profile.children.cycles-pp.vfs_write
      0.67 ±  8%      -0.3        0.38 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.68 ±  9%      -0.2        0.45 ± 15%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.60 ±  2%      -0.2        1.45 ±  4%  perf-profile.children.cycles-pp.llist_add_batch
      0.37 ±  6%      -0.1        0.30 ± 12%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.25 ±  7%      -0.0        0.20 ± 12%  perf-profile.children.cycles-pp.perf_rotate_context
      0.30 ±  3%      -0.0        0.26 ±  6%  perf-profile.children.cycles-pp.main
      0.20 ±  5%      -0.0        0.16 ± 15%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.12 ±  7%      -0.0        0.09 ± 17%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.10 ±  7%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.10 ± 23%      +0.0        0.14 ± 15%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.14 ± 16%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.09 ± 24%      +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.update_blocked_averages
      0.07 ± 21%      +0.1        0.13 ± 20%  perf-profile.children.cycles-pp.wake_affine
      0.00            +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.03 ±100%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.rb_erase
      0.02 ±141%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.rb_insert_color
      1.16 ±  2%      +0.1        1.26 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      0.12 ±  8%      +0.2        0.28 ± 14%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.2        0.17 ± 17%  perf-profile.children.cycles-pp.hrtimer_active
      0.00            +0.2        0.18 ± 19%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.10 ± 13%      +0.2        0.28 ± 15%  perf-profile.children.cycles-pp.timerqueue_add
      1.46 ±  2%      +0.2        1.65 ±  4%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.2        0.23 ± 21%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.47 ±  4%      +0.2        0.72 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.11 ± 12%      +0.2        0.36 ± 13%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.3        0.27 ±  6%  perf-profile.children.cycles-pp.task_non_contending
      0.40 ±  8%      +0.3        0.70 ±  2%  perf-profile.children.cycles-pp.read_tsc
      0.72 ±  5%      +0.5        1.24 ±  4%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.7        0.67 ± 13%  perf-profile.children.cycles-pp.task_contending
      2.11 ±  6%      +0.7        2.84 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     17.16 ±  2%      +0.8       17.94 ±  3%  perf-profile.children.cycles-pp.read
      0.00            +0.9        0.86 ±  8%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.00            +0.9        0.88 ±  8%  perf-profile.children.cycles-pp.start_dl_timer
     11.70            +0.9       12.60 ±  2%  perf-profile.children.cycles-pp.pipe_read
     12.88            +0.9       13.80 ±  3%  perf-profile.children.cycles-pp.ksys_read
     12.67            +0.9       13.59 ±  2%  perf-profile.children.cycles-pp.vfs_read
      8.25 ±  4%      +0.9        9.18 ±  6%  perf-profile.children.cycles-pp.__schedule
      0.00            +1.0        0.96 ± 13%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      5.69 ±  4%      +1.3        6.95 ±  7%  perf-profile.children.cycles-pp.schedule
      3.08 ±  3%      +1.3        4.38 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +1.3        1.33 ±  4%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.00            +1.4        1.37 ±  8%  perf-profile.children.cycles-pp.dl_server_stop
      6.78 ±  2%      +1.5        8.30 ±  3%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      6.08            +1.5        7.62 ±  3%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.13 ± 18%      +1.6        1.68 ±  8%  perf-profile.children.cycles-pp.dl_server_start
      4.44 ±  2%      +1.6        6.05 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +1.6        1.62 ±  8%  perf-profile.children.cycles-pp.enqueue_dl_entity
      2.66 ±  3%      +1.6        4.28 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.42 ±  4%      +1.6        4.07 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.50 ±  4%      +1.6        4.14 ±  7%  perf-profile.children.cycles-pp.activate_task
      0.65 ±  8%      -0.3        0.37 ± 12%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.73 ±  4%      -0.2        0.50 ±  5%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.67 ± 10%      -0.2        0.44 ± 14%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      1.60 ±  2%      -0.1        1.45 ±  4%  perf-profile.self.cycles-pp.llist_add_batch
      0.62 ±  5%      -0.1        0.52 ±  6%  perf-profile.self.cycles-pp.do_idle
      1.16 ±  4%      -0.1        1.08 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.34 ±  8%      -0.1        0.25 ±  9%  perf-profile.self.cycles-pp.prepare_task_switch
      0.12 ± 19%      -0.1        0.05 ± 52%  perf-profile.self.cycles-pp.dl_server_start
      0.09 ±  9%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.menu_reflect
      0.12 ±  7%      -0.0        0.09 ± 17%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.10 ±  7%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ± 13%      +0.0        0.16 ±  6%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.13 ± 18%      +0.0        0.17 ±  9%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.09 ± 26%      +0.0        0.14 ±  9%  perf-profile.self.cycles-pp.get_jiffies_update
      0.05 ± 47%      +0.1        0.11 ± 24%  perf-profile.self.cycles-pp.wake_affine
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.08 ± 37%  perf-profile.self.cycles-pp.enqueue_dl_entity
      0.02 ± 99%      +0.1        0.11 ± 19%  perf-profile.self.cycles-pp.rb_erase
      0.02 ±142%      +0.1        0.11 ± 17%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.49 ±  6%      +0.1        0.60 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.06 ± 11%      +0.1        0.17 ± 16%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.2        0.15 ± 15%  perf-profile.self.cycles-pp.hrtimer_try_to_cancel
      0.00            +0.2        0.16 ± 22%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.00            +0.2        0.16 ± 21%  perf-profile.self.cycles-pp.hrtimer_active
      0.00            +0.2        0.21 ± 15%  perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.33 ± 13%      +0.2        0.56 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.2        0.24 ±  6%  perf-profile.self.cycles-pp.task_non_contending
      0.10 ±  6%      +0.3        0.36 ± 11%  perf-profile.self.cycles-pp.update_rq_clock
      0.23 ±  3%      +0.3        0.51 ± 10%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.40 ±  6%      +0.3        0.68 ±  2%  perf-profile.self.cycles-pp.read_tsc
      2.09 ±  6%      +0.7        2.82 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave


***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/mutex/stress-ng/60s

commit: 
  f8ff3b9eab ("sched/core: Fix picking of tasks for core scheduling with DL server")
  3d2f07d039 ("sched/rt: Remove default bandwidth control")

f8ff3b9eab15a5a9 3d2f07d039b863082bbc4c9c541 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4534514          +186.0%   12969011 ±  5%  cpuidle..usage
     18411 ±  5%     +81.5%      33415 ± 11%  meminfo.Active
     18362 ±  5%     +81.7%      33367 ± 11%  meminfo.Active(anon)
     22481 ±  4%     -36.4%      14294 ± 12%  perf-c2c.DRAM.remote
     30250 ±  4%     +56.2%      47240 ±  9%  perf-c2c.HITM.local
     16753 ±  4%     -37.0%      10551 ± 12%  perf-c2c.HITM.remote
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.max
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.min
     39.43          +111.3%      83.32        vmstat.procs.r
    408134          +193.9%    1199488 ±  3%  vmstat.system.cs
    284439          +112.5%     604483 ±  3%  vmstat.system.in
      6.19            +1.1        7.31 ± 10%  mpstat.cpu.all.idle%
      9.99            -4.2        5.77 ±  2%  mpstat.cpu.all.irq%
      0.12            +0.0        0.17 ±  2%  mpstat.cpu.all.soft%
      0.98            +1.4        2.38 ±  3%  mpstat.cpu.all.usr%
      9864 ± 15%     -69.5%       3010 ± 27%  numa-meminfo.node0.Active
      9832 ± 15%     -69.6%       2985 ± 27%  numa-meminfo.node0.Active(anon)
     11389 ± 17%    +161.9%      29832 ± 11%  numa-meminfo.node1.Active
     11373 ± 17%    +162.1%      29808 ± 11%  numa-meminfo.node1.Active(anon)
      2314 ± 13%     -67.9%     742.93 ± 27%  numa-vmstat.node0.nr_active_anon
      2314 ± 13%     -67.9%     742.93 ± 27%  numa-vmstat.node0.nr_zone_active_anon
      2592 ± 21%    +189.7%       7509 ±  9%  numa-vmstat.node1.nr_active_anon
      2592 ± 21%    +189.7%       7509 ±  9%  numa-vmstat.node1.nr_zone_active_anon
      4672 ±  5%     +74.3%       8146 ± 13%  proc-vmstat.nr_active_anon
     96076            -3.2%      93034 ±  2%  proc-vmstat.nr_mapped
      3358            +2.8%       3452        proc-vmstat.nr_page_table_pages
      4672 ±  5%     +74.3%       8146 ± 13%  proc-vmstat.nr_zone_active_anon
     15725 ±  3%      -8.3%      14426 ±  5%  proc-vmstat.pgreuse
    184888 ±  4%     -54.7%      83747 ±  6%  stress-ng.mutex.nanosecs_per_mutex
  17960524          +142.6%   43574575 ±  7%  stress-ng.mutex.ops
    299337          +142.6%     726235 ±  7%  stress-ng.mutex.ops_per_sec
  11685849          +202.9%   35396491 ±  3%  stress-ng.time.involuntary_context_switches
      5167            +2.8%       5310        stress-ng.time.percent_of_cpu_this_job_got
      3093            +1.2%       3131        stress-ng.time.system_time
     21.40          +232.5%      71.14 ±  2%  stress-ng.time.user_time
   9213570          +196.1%   27278654 ±  4%  stress-ng.time.voluntary_context_switches
      1.31           +45.0%       1.90 ± 10%  perf-stat.i.MPKI
 4.026e+09           -22.0%  3.142e+09        perf-stat.i.branch-instructions
      0.31            +0.6        0.89        perf-stat.i.branch-miss-rate%
  12656494           +96.8%   24903211 ±  2%  perf-stat.i.branch-misses
     36.65           -15.2       21.46 ±  9%  perf-stat.i.cache-miss-rate%
  58740401           +88.4%  1.107e+08 ±  3%  perf-stat.i.cache-references
    419916          +195.4%    1240313 ±  4%  perf-stat.i.context-switches
     11.28           +37.6%      15.53 ±  2%  perf-stat.i.cpi
 1.873e+11            +1.3%  1.898e+11        perf-stat.i.cpu-cycles
    117555          +126.6%     266333 ±  4%  perf-stat.i.cpu-migrations
  1.71e+10           -13.4%  1.481e+10 ±  2%  perf-stat.i.instructions
      0.10           -12.9%       0.08        perf-stat.i.ipc
      8.42          +179.7%      23.55 ±  4%  perf-stat.i.metric.K/sec
      1.26           +26.3%       1.59 ±  9%  perf-stat.overall.MPKI
      0.31            +0.5        0.79        perf-stat.overall.branch-miss-rate%
     36.76           -15.5       21.27 ± 10%  perf-stat.overall.cache-miss-rate%
     10.96           +17.4%      12.86        perf-stat.overall.cpi
      0.09           -14.8%       0.08        perf-stat.overall.ipc
 3.958e+09           -22.3%  3.077e+09        perf-stat.ps.branch-instructions
  12430945           +96.5%   24425332 ±  2%  perf-stat.ps.branch-misses
  57673349           +88.5%  1.087e+08 ±  3%  perf-stat.ps.cache-references
    412967          +195.2%    1219069 ±  4%  perf-stat.ps.context-switches
 1.842e+11            +1.2%  1.864e+11        perf-stat.ps.cpu-cycles
    115616          +126.4%     261770 ±  4%  perf-stat.ps.cpu-migrations
  1.68e+10           -13.7%   1.45e+10        perf-stat.ps.instructions
 1.034e+12           -13.9%  8.899e+11 ±  2%  perf-stat.total.instructions
     46.30           -46.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.enqueue_task_rt.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
     45.94           -45.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.enqueue_task_rt.__sched_setscheduler._sched_setscheduler
     47.64           -36.8       10.89        perf-profile.calltrace.cycles-pp.enqueue_task_rt.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
     59.48           -26.2       33.25        perf-profile.calltrace.cycles-pp.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64
     59.66           -26.2       33.42        perf-profile.calltrace.cycles-pp._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
     59.77           -25.7       34.03        perf-profile.calltrace.cycles-pp.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     59.78           -25.7       34.04        perf-profile.calltrace.cycles-pp.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     64.15           -25.4       38.79        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     64.16           -25.4       38.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     64.25           -25.2       39.01        perf-profile.calltrace.cycles-pp.__sched_setscheduler
     10.09           -10.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.enqueue_task_rt.activate_task.ttwu_do_activate
      9.38            -9.4        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.enqueue_task_rt.activate_task.push_rt_task.push_rt_tasks
      9.30            -9.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.enqueue_task_rt.activate_task.push_rt_task
      8.35            -8.4        0.00        perf-profile.calltrace.cycles-pp.enqueue_task_rt.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      8.16            -8.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.enqueue_task_rt.activate_task.ttwu_do_activate.sched_ttwu_pending
      9.69            -7.4        2.31 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task_rt.activate_task.push_rt_task.push_rt_tasks.finish_task_switch
      9.99            -6.2        3.77 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.push_rt_task.push_rt_tasks.finish_task_switch.__schedule
      6.21 ±  3%      -4.8        1.41 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      6.17            -4.8        1.42 ±  5%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      5.38            -4.6        0.78 ±  8%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      6.79            -4.2        2.58 ±  2%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      5.25            -3.9        1.32 ±  5%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      5.27            -3.9        1.36 ±  5%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      5.80            -3.8        2.00 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      5.72            -3.8        1.94 ±  7%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.__sched_setscheduler
      5.72            -3.8        1.94 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.__sched_setscheduler._sched_setscheduler
      5.72            -3.8        1.95 ±  7%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      3.10            -2.7        0.45 ± 44%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      3.06            -2.6        0.44 ± 44%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      8.48            -1.8        6.70 ±  3%  perf-profile.calltrace.cycles-pp.common_startup_64
      8.33            -1.8        6.58 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      8.33            -1.7        6.58 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      8.33            -1.7        6.58 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.12            -1.4        0.74 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      2.13            -1.4        0.76 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      2.06            -1.4        0.70 ±  6%  perf-profile.calltrace.cycles-pp.enqueue_task_rt.activate_task.ttwu_do_activate.try_to_wake_up.wake_up_q
      2.28            -1.0        1.30 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      2.28            -0.9        1.41 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      2.09            -0.7        1.38 ±  4%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.wake_up_q.futex_wake
      2.26            -0.2        2.07 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.wake_up_q.futex_wake.do_futex
      0.98            -0.1        0.89 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.task_rq_lock.__sched_setscheduler._sched_setscheduler
      1.00            +0.0        1.04        perf-profile.calltrace.cycles-pp._raw_spin_lock.task_rq_lock.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      0.58            +0.0        0.63 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rt_mutex_adjust_pi.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      0.58            +0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.rt_mutex_adjust_pi.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      0.64 ±  2%      +0.1        0.78 ± 21%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule
      3.88            +0.2        4.06        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64
      1.07            +0.2        1.29        perf-profile.calltrace.cycles-pp.task_rq_lock.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      4.25            +0.3        4.52        perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
      0.55            +0.3        0.85 ±  2%  perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.36            +0.4        4.72        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
      4.62 ±  3%      +0.5        5.14 ±  3%  perf-profile.calltrace.cycles-pp.raw_spin_rq_lock_nested.find_lock_lowest_rq.push_rt_task.push_rt_tasks.finish_task_switch
      4.62 ±  3%      +0.5        5.14 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested.find_lock_lowest_rq.push_rt_task.push_rt_tasks
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.cpupri_find_fitness.find_lowest_rq.select_task_rq_rt.select_task_rq.try_to_wake_up
      4.78            +0.6        5.35        perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.find_lowest_rq.select_task_rq_rt.select_task_rq.try_to_wake_up.wake_up_q
      0.00            +0.6        0.60 ±  7%  perf-profile.calltrace.cycles-pp.push_rt_task.task_woken_rt.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.00            +0.6        0.60 ±  7%  perf-profile.calltrace.cycles-pp.task_woken_rt.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      0.00            +0.6        0.61 ±  4%  perf-profile.calltrace.cycles-pp.push_rt_task.task_woken_rt.ttwu_do_activate.try_to_wake_up.wake_up_q
      0.00            +0.6        0.62 ±  4%  perf-profile.calltrace.cycles-pp.task_woken_rt.ttwu_do_activate.try_to_wake_up.wake_up_q.futex_wake
      0.70            +0.7        1.36        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_pushable_task.activate_task.ttwu_do_activate.try_to_wake_up.wake_up_q
      0.00            +0.7        0.68 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_rt.__schedule.schedule_idle.do_idle.cpu_startup_entry
      2.88            +0.7        3.56 ±  2%  perf-profile.calltrace.cycles-pp.push_rt_tasks.finish_task_switch.__schedule.schedule.syscall_exit_to_user_mode
      0.00            +0.7        0.71 ±  2%  perf-profile.calltrace.cycles-pp.select_task_rq_rt.select_task_rq.try_to_wake_up.wake_up_q.futex_wake
      0.62            +0.8        1.42 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.wake_up_q.futex_wake
      0.62            +0.8        1.44 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.wake_up_q.futex_wake.do_futex
      0.00            +0.8        0.82 ±  2%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.futex_wake.do_futex
      0.00            +0.9        0.95 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_rt.push_rt_task.push_rt_tasks.finish_task_switch.__schedule
      0.00            +1.0        0.95 ± 17%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule_idle
      0.00            +1.0        0.97 ± 17%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule_idle.do_idle
      0.00            +1.0        1.02 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_pushable_task.activate_task.push_rt_task.push_rt_tasks.finish_task_switch
      0.00            +1.0        1.05 ± 16%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.64 ±  2%      +1.1        1.72 ± 19%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch
      0.64 ±  2%      +1.1        1.72 ± 19%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule
      4.92            +1.2        6.12 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.double_rq_lock.find_lock_lowest_rq.push_rt_task
      1.19            +1.3        2.50 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.20            +1.3        2.50 ±  6%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.4        1.36 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_rt.__schedule.schedule.futex_wait_queue.__futex_wait
      4.94            +1.4        6.38 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.double_rq_lock.find_lock_lowest_rq.push_rt_task.push_rt_tasks
      4.95            +1.5        6.41 ±  3%  perf-profile.calltrace.cycles-pp.double_rq_lock.find_lock_lowest_rq.push_rt_task.push_rt_tasks.finish_task_switch
      0.78            +1.6        2.36 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.78            +1.6        2.38 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.86            +1.7        2.52 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.64            +2.0        5.63 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.futex_wake.do_futex.__x64_sys_futex
      3.66            +2.1        5.77 ±  3%  perf-profile.calltrace.cycles-pp.wake_up_q.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
      0.00            +2.1        2.12 ±  6%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +2.1        2.14 ±  3%  perf-profile.calltrace.cycles-pp.cpupri_set.enqueue_task_rt.activate_task.push_rt_task.push_rt_tasks
      0.00            +2.3        2.32 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_rt.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +2.6        2.61 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_pushable_task.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      3.86            +2.7        6.56 ±  2%  perf-profile.calltrace.cycles-pp.futex_wake.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.88            +3.0       17.91        perf-profile.calltrace.cycles-pp.push_rt_tasks.finish_task_switch.__schedule.schedule.futex_wait_queue
     15.63            +3.1       18.77        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.futex_wait_queue.__futex_wait
      0.00            +3.2        3.18 ±  7%  perf-profile.calltrace.cycles-pp.pull_rt_task.balance_rt.__schedule.schedule.futex_wait_queue
      0.00            +3.2        3.20 ±  7%  perf-profile.calltrace.cycles-pp.balance_rt.__schedule.schedule.futex_wait_queue.__futex_wait
      0.00            +3.2        3.21 ±  2%  perf-profile.calltrace.cycles-pp.cpupri_set.dequeue_rt_stack.dequeue_task_rt.__schedule.schedule
      0.00            +3.3        3.26 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_rt_stack.dequeue_task_rt.__schedule.schedule.futex_wait_queue
      0.00            +3.3        3.34 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_rt.__schedule.schedule.futex_wait_queue.__futex_wait
      0.00            +5.1        5.12 ±  5%  perf-profile.calltrace.cycles-pp.pull_rt_task.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      2.66 ±  2%      +5.1        7.81 ±  2%  perf-profile.calltrace.cycles-pp.push_rt_tasks.finish_task_switch.__schedule.schedule.__x64_sys_sched_yield
      2.96 ±  2%      +5.3        8.28 ±  2%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
     20.42            +8.9       29.28        perf-profile.calltrace.cycles-pp.push_rt_task.push_rt_tasks.finish_task_switch.__schedule.schedule
      0.91 ±  3%      +9.3       10.21        perf-profile.calltrace.cycles-pp.cpupri_set.enqueue_task_rt.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      1.24 ±  3%      +9.4       10.68        perf-profile.calltrace.cycles-pp.dequeue_task_rt.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      0.70 ±  5%      +9.7       10.40        perf-profile.calltrace.cycles-pp.cpupri_set.dequeue_rt_stack.dequeue_task_rt.__sched_setscheduler._sched_setscheduler
      0.72 ±  5%      +9.8       10.48        perf-profile.calltrace.cycles-pp.dequeue_rt_stack.dequeue_task_rt.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      3.72           +10.5       14.22 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +10.5       10.50 ±  2%  perf-profile.calltrace.cycles-pp.cpupri_find_fitness.find_lowest_rq.find_lock_lowest_rq.push_rt_task.push_rt_tasks
      3.72 ±  2%     +10.5       14.24 ±  2%  perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.00           +10.6       10.56 ±  2%  perf-profile.calltrace.cycles-pp.find_lowest_rq.find_lock_lowest_rq.push_rt_task.push_rt_tasks.finish_task_switch
      3.98           +10.6       14.58 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      4.09           +10.8       14.92 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      4.09           +10.8       14.92 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
      4.15           +10.9       15.08 ±  2%  perf-profile.calltrace.cycles-pp.__sched_yield
     17.03           +11.3       28.32        perf-profile.calltrace.cycles-pp.__schedule.schedule.futex_wait_queue.__futex_wait.futex_wait
     17.04           +11.3       28.35        perf-profile.calltrace.cycles-pp.schedule.futex_wait_queue.__futex_wait.futex_wait.do_futex
     17.08           +11.4       28.52        perf-profile.calltrace.cycles-pp.futex_wait_queue.__futex_wait.futex_wait.do_futex.__x64_sys_futex
     17.25           +11.9       29.18        perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
     17.27           +11.9       29.21        perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.08           +12.9       22.99        perf-profile.calltrace.cycles-pp.find_lock_lowest_rq.push_rt_task.push_rt_tasks.finish_task_switch.__schedule
     21.13           +14.7       35.78        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.15           +14.7       35.81        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.90           +15.3       37.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.91           +15.3       37.25        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     87.96           -68.6       19.31        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     88.72           -67.6       21.11        perf-profile.children.cycles-pp._raw_spin_lock
     70.93           -55.0       15.97 ±  2%  perf-profile.children.cycles-pp.enqueue_task_rt
    123.91           -51.5       72.44        perf-profile.children.cycles-pp.__sched_setscheduler
     59.66           -26.2       33.42        perf-profile.children.cycles-pp._sched_setscheduler
     59.78           -25.7       34.03        perf-profile.children.cycles-pp.do_sched_setscheduler
     59.78           -25.7       34.04        perf-profile.children.cycles-pp.__x64_sys_sched_setscheduler
     23.78           -15.0        8.79 ±  2%  perf-profile.children.cycles-pp.activate_task
     14.20            -8.7        5.48 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
     14.74            -8.0        6.78        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     13.57            -7.9        5.67        perf-profile.children.cycles-pp.ttwu_do_activate
      6.28            -4.8        1.45 ±  5%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      9.38            -4.0        5.40 ±  2%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      9.40            -4.0        5.44 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function_single
      9.55            -3.9        5.67 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      8.48            -1.8        6.70 ±  3%  perf-profile.children.cycles-pp.do_idle
      8.48            -1.8        6.70 ±  3%  perf-profile.children.cycles-pp.common_startup_64
      8.48            -1.8        6.70 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      8.33            -1.7        6.58 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.95            -0.4        0.55 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.89            -0.4        0.51 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.59            -0.4        0.21 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.60            -0.4        0.22 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.61            -0.4        0.24 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.64            -0.3        0.30 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.64            -0.3        0.30 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.50            -0.3        0.17 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.42            -0.2        0.18 ±  3%  perf-profile.children.cycles-pp.put_prev_task_rt
      0.22 ± 10%      -0.1        0.15 ± 29%  perf-profile.children.cycles-pp.load_balance
      0.25            -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.32 ±  4%      -0.0        0.27 ±  4%  perf-profile.children.cycles-pp.__cmd_record
      0.21 ±  5%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.perf_session__process_events
      0.20 ±  6%      -0.0        0.15        perf-profile.children.cycles-pp.process_simple
      0.21 ±  5%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.reader__read_event
      0.21 ±  5%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.record__finish_output
      0.18 ±  5%      -0.0        0.14        perf-profile.children.cycles-pp.ordered_events__queue
      0.18 ±  5%      -0.0        0.14        perf-profile.children.cycles-pp.queue_event
      0.26            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rebalance_domains
      0.07 ±  8%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.06 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__get_user_8
      0.06            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.deactivate_task
      0.05            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.find_task_by_vpid
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.01 ±223%      +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.os_xsave
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.plist_add
      0.59            +0.1        0.64 ±  3%  perf-profile.children.cycles-pp.rt_mutex_adjust_pi
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.stress_mwc32modn
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.09 ±  8%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.wake_q_add_safe
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.09            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.wakeup_preempt
      0.07 ±  5%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.05            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.05            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.plist_del
      0.08 ±  5%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp._copy_from_user
      0.08 ±  5%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.mutex_exercise
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.raw_spin_rq_trylock
      0.26            +0.1        0.33 ±  3%  perf-profile.children.cycles-pp.do_sched_yield
      0.05            +0.1        0.13 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.06 ±  6%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.pick_task_rt
      0.05            +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__futex_unqueue
      0.10 ±  4%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.13 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.02 ±141%      +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.06            +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.00            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.irq_work_claim
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.06            +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.update_rq_clock
      0.06 ±  7%      +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.futex_unqueue
      0.00            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.irq_work_queue_on
      0.06 ±  7%      +0.1        0.20 ±  8%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.06            +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.pthread_mutex_lock
      0.10 ±  5%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.update_curr_common
      0.01 ±223%      +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.llist_add_batch
      0.01 ±223%      +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.set_task_cpu
      0.00            +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.get_futex_key
      0.12 ±  4%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.prepare_task_switch
      0.20 ±  5%      +0.2        0.36 ±  4%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.00            +0.2        0.18 ±  5%  perf-profile.children.cycles-pp.resched_curr
      0.16 ±  2%      +0.2        0.35 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.08            +0.2        0.27 ±  3%  perf-profile.children.cycles-pp.__switch_to
      0.42            +0.2        0.62        perf-profile.children.cycles-pp.rto_push_irq_work_func
      1.08            +0.2        1.30        perf-profile.children.cycles-pp.task_rq_lock
      0.11 ±  4%      +0.2        0.34 ±  7%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.06 ±  7%      +0.2        0.30 ±  2%  perf-profile.children.cycles-pp.futex_wake_mark
      0.05            +0.2        0.29 ±  2%  perf-profile.children.cycles-pp.futex_q_lock
      0.66            +0.3        0.92 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.14 ±  3%      +0.3        0.44        perf-profile.children.cycles-pp.switch_fpu_return
      0.12 ±  5%      +0.3        0.43 ±  5%  perf-profile.children.cycles-pp.apparmor_capable
      0.12 ±  4%      +0.3        0.45 ±  5%  perf-profile.children.cycles-pp.security_capable
      0.13 ±  6%      +0.3        0.46 ±  4%  perf-profile.children.cycles-pp.capable
      0.10 ±  4%      +0.4        0.46 ±  2%  perf-profile.children.cycles-pp.futex_wait_setup
      0.12 ±  4%      +0.4        0.50 ±  2%  perf-profile.children.cycles-pp.pthread_setschedparam
      0.46            +0.4        0.90 ±  3%  perf-profile.children.cycles-pp.irq_work_single
      5.62 ±  3%      +0.5        6.07 ±  3%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.14 ±  3%      +0.5        0.69        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.09 ±  4%      +0.6        0.71 ±  2%  perf-profile.children.cycles-pp.select_task_rq_rt
      0.80 ±  2%      +0.6        1.44 ±  4%  perf-profile.children.cycles-pp.task_woken_rt
      0.13 ±  2%      +0.7        0.83 ±  2%  perf-profile.children.cycles-pp.select_task_rq
     90.33            +0.8       91.13        perf-profile.children.cycles-pp.do_syscall_64
     90.35            +0.8       91.18        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.85 ± 15%  perf-profile.children.cycles-pp.__bitmap_and
      0.11 ±  4%      +1.0        1.08 ± 11%  perf-profile.children.cycles-pp._find_first_and_bit
      5.16            +1.3        6.42        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.22            +1.3        2.55 ±  6%  perf-profile.children.cycles-pp.schedule_idle
      0.79            +1.6        2.41 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.80            +1.6        2.42 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      0.88            +1.7        2.57 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      5.50            +1.7        7.22 ±  2%  perf-profile.children.cycles-pp.double_rq_lock
      0.42            +1.7        2.16 ±  5%  perf-profile.children.cycles-pp.intel_idle
      3.66            +2.0        5.66 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      3.67            +2.1        5.78 ±  3%  perf-profile.children.cycles-pp.wake_up_q
      3.86            +2.7        6.56 ±  2%  perf-profile.children.cycles-pp.futex_wake
      0.12 ±  9%      +3.1        3.22 ±  7%  perf-profile.children.cycles-pp.balance_rt
      0.30 ±  4%      +4.2        4.49 ±  2%  perf-profile.children.cycles-pp.pick_next_task_rt
      0.55 ±  3%      +5.6        6.12 ±  2%  perf-profile.children.cycles-pp.enqueue_pushable_task
      0.32 ±  8%      +8.0        8.31 ±  5%  perf-profile.children.cycles-pp.pull_rt_task
     21.52            +8.6       30.08        perf-profile.children.cycles-pp.push_rt_tasks
     22.71            +9.3       31.98        perf-profile.children.cycles-pp.push_rt_task
     22.84            +9.7       32.50        perf-profile.children.cycles-pp.finish_task_switch
      3.98           +10.6       14.58 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sched_yield
      4.17           +11.0       15.12 ±  2%  perf-profile.children.cycles-pp.__sched_yield
     17.08           +11.4       28.52        perf-profile.children.cycles-pp.futex_wait_queue
      0.45 ±  7%     +11.7       12.12 ±  2%  perf-profile.children.cycles-pp.cpupri_find_fitness
      0.48 ±  6%     +11.7       12.18 ±  2%  perf-profile.children.cycles-pp.find_lowest_rq
     17.26           +11.9       29.18        perf-profile.children.cycles-pp.__futex_wait
     17.27           +11.9       29.21        perf-profile.children.cycles-pp.futex_wait
      0.92 ±  5%     +12.9       13.81        perf-profile.children.cycles-pp.dequeue_rt_stack
     11.20           +13.7       24.92        perf-profile.children.cycles-pp.find_lock_lowest_rq
      1.80 ±  2%     +13.9       15.65        perf-profile.children.cycles-pp.dequeue_task_rt
     21.13           +14.7       35.78        perf-profile.children.cycles-pp.do_futex
     21.15           +14.7       35.81        perf-profile.children.cycles-pp.__x64_sys_futex
     25.78           +22.6       48.33        perf-profile.children.cycles-pp.schedule
     27.00           +23.9       50.88        perf-profile.children.cycles-pp.__schedule
      2.17 ±  4%     +26.0       28.18        perf-profile.children.cycles-pp.cpupri_set
     87.95           -68.6       19.31        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.05 ±  8%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.05 ±  8%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.__get_user_8
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.put_prev_task_rt
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.os_xsave
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.stress_mwc32modn
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.plist_del
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.wake_q_add_safe
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.05            +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.llist_reverse_order
      0.06 ±  6%      +0.1        0.12 ±  5%  perf-profile.self.cycles-pp.mutex_exercise
      0.07 ±  5%      +0.1        0.13 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      0.05            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.update_curr_common
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp._copy_from_user
      0.08 ±  4%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.05            +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__futex_unqueue
      0.06 ±  6%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.11            +0.1        0.19 ±  4%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.pick_task_rt
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.02 ± 99%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.01 ±223%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.select_task_rq
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.wake_up_q
      0.04 ± 44%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.pthread_mutex_lock
      0.00            +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.set_task_cpu
      0.00            +0.1        0.12 ±  5%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.irq_work_claim
      0.00            +0.1        0.12 ±  5%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.06 ±  6%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.futex_unqueue
      0.00            +0.1        0.13 ±  7%  perf-profile.self.cycles-pp.select_task_rq_rt
      0.07 ±  6%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.prepare_task_switch
      0.05            +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.get_futex_key
      0.01 ±223%      +0.1        0.15 ±  9%  perf-profile.self.cycles-pp.llist_add_batch
      0.00            +0.2        0.15 ±  4%  perf-profile.self.cycles-pp.futex_wait_queue
      0.00            +0.2        0.15 ± 12%  perf-profile.self.cycles-pp.irq_work_single
      0.05            +0.2        0.20 ±  3%  perf-profile.self.cycles-pp.futex_wake_mark
      0.11 ±  4%      +0.2        0.27 ±  3%  perf-profile.self.cycles-pp.find_lock_lowest_rq
      0.00            +0.2        0.17 ±  4%  perf-profile.self.cycles-pp.resched_curr
      0.00            +0.2        0.18 ±  2%  perf-profile.self.cycles-pp.dequeue_rt_stack
      0.08 ±  4%      +0.2        0.26 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.2        0.20 ± 11%  perf-profile.self.cycles-pp.newidle_balance
      0.00            +0.2        0.20        perf-profile.self.cycles-pp.futex_q_lock
      0.64            +0.2        0.85 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.09 ±  4%      +0.2        0.30 ±  5%  perf-profile.self.cycles-pp.futex_wake
      0.05            +0.2        0.29 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
      0.01 ±223%      +0.3        0.26 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.05            +0.3        0.31        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.11 ±  4%      +0.3        0.42 ±  4%  perf-profile.self.cycles-pp.apparmor_capable
      0.24 ±  2%      +0.3        0.57 ±  5%  perf-profile.self.cycles-pp.__sched_setscheduler
      0.08            +0.3        0.42 ±  3%  perf-profile.self.cycles-pp.pthread_setschedparam
      0.07 ±  6%      +0.4        0.43 ±  4%  perf-profile.self.cycles-pp.push_rt_task
      0.00            +0.4        0.40 ±  5%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.4        0.41 ±  2%  perf-profile.self.cycles-pp.do_sched_setscheduler
      0.14 ±  4%      +0.5        0.68        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.19            +0.7        0.90        perf-profile.self.cycles-pp.__schedule
      0.59            +0.8        1.36 ±  9%  perf-profile.self.cycles-pp.enqueue_task_rt
      0.00            +0.8        0.85 ± 15%  perf-profile.self.cycles-pp.__bitmap_and
      0.11 ±  5%      +1.0        1.07 ± 11%  perf-profile.self.cycles-pp._find_first_and_bit
      0.76            +1.1        1.84        perf-profile.self.cycles-pp._raw_spin_lock
      0.10 ±  4%      +1.6        1.73 ±  2%  perf-profile.self.cycles-pp.dequeue_task_rt
      0.42            +1.7        2.16 ±  5%  perf-profile.self.cycles-pp.intel_idle
      0.26 ±  5%      +4.1        4.36 ±  2%  perf-profile.self.cycles-pp.pick_next_task_rt
      0.53 ±  3%      +5.5        6.06 ±  2%  perf-profile.self.cycles-pp.enqueue_pushable_task
      0.31 ±  8%      +7.4        7.68 ±  5%  perf-profile.self.cycles-pp.pull_rt_task
      0.31 ±  9%      +9.9       10.20 ±  2%  perf-profile.self.cycles-pp.cpupri_find_fitness
      2.16 ±  4%     +26.0       28.17        perf-profile.self.cycles-pp.cpupri_set





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


