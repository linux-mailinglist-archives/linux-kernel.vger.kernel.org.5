Return-Path: <linux-kernel+bounces-88053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87786DCBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712CF1C23EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A836930E;
	Fri,  1 Mar 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RArTSxVP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAAF69D3D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280580; cv=fail; b=DL05ZL/HoTXOFhoyovz4eSrv2o2w3KW4nxWj97sbr0+eSyFHtmbZyr7tAQTq7CwkO8v30/lOHstTzM/djAWm7U3JgCdd4Fq42ZQ5yMipFXvePdaIbZihtboxJklqi9SgmD5G1+BlY5XUn8YYpPJzV4Nvuj+Ka88Dv7y/aJ1R3j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280580; c=relaxed/simple;
	bh=GusJxhianzO04hh0mX0KfvECt94aZCBtsVDJzP/pwSU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ciDSm23WjEOc5Vtrf+RqaaFJ5UOD552eruW7CyBHF+3rF9XJWzY3wvh76v74ciUUAHpCEj4HrXLWiCorCI679e8ZEK1D2pNSPi5vEfYpymuFChtGT5hSmyf08GBp+GqftVOofpw7k2hE08OR+X0S1aMhQ8AtDNWU/MrztTIfgVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RArTSxVP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709280578; x=1740816578;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=GusJxhianzO04hh0mX0KfvECt94aZCBtsVDJzP/pwSU=;
  b=RArTSxVP+F6keL8pJR25PJCkmt3SRhpV1qx5FZXlEDHsLiZuoGEMJDZr
   IAigHqUwTLuGGJsxrZnUgP1VR+7Vlg1uzjeEzKBIuaxUAVUvAdOknppUr
   WxGHV8OgwtGFAzQ22iPYuqpzLiB5eHlOdxj11u+c2g+o11UlSbP8OFPCY
   Vt1FvzfUcG70VSCBL8FsLoPK4IwCOtjO0j9fBHRJuqltLUlDYXekrqYdl
   id9C5XloW6+QSoR2UzIgSo2liBlJJer3hvyZzsX9OsI4YV24ywh1D6Ins
   LnQ7/dOYD0fT3Nl8JCRRMDVAPFgW+RwyvmiQ2Flch3Iu9ihFQkfzywB9A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3732462"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3732462"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:09:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12805278"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 00:09:37 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:09:37 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:09:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 00:09:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 00:09:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2VxFQyC6mAYMM9ihfhEzVCukQi0BfZizbvcnJnK17POd+RAVmV+sMBk8astzv//WAqYNPhyJyfGJS7v31/KZIcvm4hmX2qx1D2VRSJGXEhoEk6OfRRiXkcEJkUJX9D+77uhkUH4rZVPuuPeoNIIJQg2gd1EhizCfwHrD03gc5zjOw95Xlh8/mgFrjHh9h/PFIyikpjqb9Eg+rPABVqk2461F2LYAv+CTl2bhR4sNy1LlhGQy9iD6YSHaLJ6HUq2AtA7aadGLDUiOkSzDgDkgdtqgsUHDu33m6efYp/e/lhfr1x7sLTrwgppa1op8roiNbqimz/e9/88C5gF9y7L0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6l77PMyNcgtz1qRdC7DC6sXENshfNVZy1smsPJBAuY=;
 b=gQ4JxcifnrrqdwmcgLcNuQIGw1nLKyn2E2QbgdkUY2+ct3L3KZDYj98ETo/RMS0N3qnA2eOhy+ek0deM+IvREoZBmFaqpT+C0/SKTog9xs4BeyVdrlYyxuINMxzaQg4ERU6XmbVoC8JHaPdnNiUs7L/O44FpJMDUm9Ai+B7N3V2Wg7BuZuumHwU9UCn4yWIb1I4vzNhbqrUTyQJtm6Tc9/+X1VaSmqG6yG+UBj+Tk9wGA26Hv4PdjbmBFQ2Ljc2lNrc5LUeOL9SwsWF1gHhx+wSiaDDkPlAuXTmEY3fSLt7uqukmHU6Nqtgv+Zp8vP7A4bHmSS1jAz5hKeiMtuBtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Fri, 1 Mar
 2024 08:09:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 08:09:34 +0000
Date: Fri, 1 Mar 2024 16:09:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <202403011511.24defbbd-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: f4deb5b5-8d8a-47ee-f4c9-08dc39c6ee11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKR4lh+satzR8OIg/8FJXVOfqyyG2RmlEBfyXJ80U32LCjE6pNEXD6cOrWzkReqWOMnQb8jc4iNWbYNG7j+0LNjvs3rwp5aDyk7VfZC3i5a4QbC6lRikvHlWJeikdJ6PaujvYO0P9Oxaastz90a+oRLNP7PkbOwE7AV1aQov4a986E3OYdEgTEVekKJ9g0s3TnjX857CiohWSMxauNvZLjUhJ/Xf21mmUQEAF6rY6KHTdNvRCLJlQ3oAH5wx+R4lmC10p5jtxedXtvXs2stRX+iP/BmUAb9MvWWmw3G/Nz/ADNY7Q2DpWj0nfwp+rLUYeYXZViuUHBEPJCDftGsKXfOoqgTSyTERaNxUMzxHRU940T0ZtzAXK+dhJ5E9REEQi5SMTK2Vf8v2ivZ81tlrNSaTGPhdwOz4FHxHQAgo/f4+W5ZN39MNrmuzeBBGNnxU9hXjQSTghIfb//G6FepjrR+HflywNAx7IIrd4pEM9adKQe6zpqX1db+QhjODM2vnrIkWUO28hJltu+RLAy0fxuudNsWHKnewSWNzx1TgOIr1DwRWPEmQysr34ED4noAPc6ProlBj1ECbrdbhPfDRVvsADEWwIt3WgnyNasdk/gI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9m6nh9QGRVKfeZTXPHlLG2SUqZpmUXArbcnk7ptt+IonxIrxfVW2MmKrNi?=
 =?iso-8859-1?Q?n+wvRCjqEdE8M1IkxrnSnSjXBRaHVEYWxo9yxvpm1A5cqlH0RRj9HC2JHZ?=
 =?iso-8859-1?Q?U/JTVA/SIrkNqbi2o92aMscZFekatzCW7UDsLjo67L6yGxWBlUmqsFGJJM?=
 =?iso-8859-1?Q?Lkbj7khk/US8IXC5l3f3Bk+gf9xDVqSutd9UciaLlLzL6pY/W+SlIu1rsm?=
 =?iso-8859-1?Q?w8r++Y1nuJJuWLkG68Umm/knii3fzkyQkH/fYmwScf8C5fQ6NGEbraIuYb?=
 =?iso-8859-1?Q?jasytpuZIgbcEZXu7lHtalvew+bR3Um+flB3elYw2hDhX93vUt8xQ1N2RQ?=
 =?iso-8859-1?Q?uhp5YcDXxDBSsfjyLd/jPLoot8G82/+LcmsD7zM7eyP1VPHpIXYz9IzFMk?=
 =?iso-8859-1?Q?0DRBBT1fTSLwKeMZJ2j/svMUJgR5PL1qAfSWX/YsYdcw7araUiGJ/4fxb7?=
 =?iso-8859-1?Q?xT0Ios1sQdt5+Hvi1vOpYml9lOtEJGvcJSzKiqTivviw8lwInk0eBrq8SO?=
 =?iso-8859-1?Q?CUxDVmZljCgQI45pzb1zxOPQsQQ/NBY6mOLPlm9eWGtpfONDuxrzx/HZiL?=
 =?iso-8859-1?Q?AVgjqKe3RRVf6ej0XlGU5btAnnwIrcfGJiBrAI7n04Gp7Am8NGQNJm5Awh?=
 =?iso-8859-1?Q?r39Z+uwsaVZdWmutzy98v6drAiPcAfD84eZcScdPJwzFroMiAJDw3jM6KM?=
 =?iso-8859-1?Q?PEGDPxhMqdvrByZ21bzbxn9lbu3pPRziqHdFI+KR6pC6gGYGmxDxQIZTWB?=
 =?iso-8859-1?Q?WfK0Srv/HAxtkHX82gypF75+i9C9rHyElatKTlTiMljtKyB49JQvlTAySo?=
 =?iso-8859-1?Q?CHbetOeuUmv+sYtRxBEYgJyFtDdiNV06v7s7aruXP0yuh4SMlEWdSFzoAD?=
 =?iso-8859-1?Q?v63SpGH6NQBhgodwS7Tog1Ef8kYZzA2y5CPUc4PJWfB026y78IfPWpjBDR?=
 =?iso-8859-1?Q?o4eL73/aRr9YHKl6riKIG4uLip2v8W2YI6y0SuYrWt7DCnFD78SABLHYbC?=
 =?iso-8859-1?Q?7loyUCCGKWWQIULHOk6F8ytu4yVEaUE2iU8mH8osbPwU90fhxZdYJyURC8?=
 =?iso-8859-1?Q?pvRGgcpdS2vZfu1KvGJnznsH18tDNlJivcV+mf33BLl08RcsRUJEVsoTm6?=
 =?iso-8859-1?Q?fWw66Yt9qDpKbUY2i/aiJ3b1BeU2IPaErjmFGE2P1XTN4/ejcObIJrZWja?=
 =?iso-8859-1?Q?EhmK/AelqtA/MUa/uQxM52gqCW0jyUC5CRGfeDJDxJF0132nF0fppTUNe9?=
 =?iso-8859-1?Q?pWAVBSCsVU2bIVvFLtMRS/aPG60mRzEoImc8VNh2GMN7CY99gfsnFHJosZ?=
 =?iso-8859-1?Q?qIAhSn8RjZ2uDS41cjrIBedFB7ew9LhrCgcQbqZaE6fbaXxbrgPwx9S/wB?=
 =?iso-8859-1?Q?zWyLGOHCNBmjhY12L5geGSqRDkBTMBfzRsQLb9J5zM60rKr4OJor0BW0Ah?=
 =?iso-8859-1?Q?0Ohq0QN4s8OmlAzsS01udL+Uath1ayRgCWc+Yj358drHvTrbRs9hYL4YYr?=
 =?iso-8859-1?Q?LFQO/9+wOg2iJ/yz6ZQJT3aztATP/ZR3OxX1Qc6JHU9VqYK55Q515YJWyr?=
 =?iso-8859-1?Q?wr4B1l+84pHKhDkhKzHS3xi3SKGFEBUAFaIMWVtNSNF+Z2JgXnTORl2mXJ?=
 =?iso-8859-1?Q?NyiF8LxORslOwj8a376foK7Jvd+bh63OQEc2BkNdz2mhNyW0ONrFoccA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4deb5b5-8d8a-47ee-f4c9-08dc39c6ee11
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 08:09:34.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eyi8AI9OqYxWgm1Te+trqdshWq1oRg2NxphPKPFylLw3mpjt5/xQWTuFvsrO5ZV+btne98AQIjNmoyY00n4+YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -1.2% regression of netperf.Throughput_Mbps on:


commit: 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the hierarchical pull model")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/core

testcase: netperf
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: SCTP_STREAM
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403011511.24defbbd-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240301/202403011511.24defbbd-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

commit: 
  57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
  7ee9887703 ("timers: Implement the hierarchical pull model")

57e95a5c4117dc6a 7ee988770326fca440472200c3e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5232            +6.8%       5589        vmstat.system.in
      0.03            +0.0        0.04        mpstat.cpu.all.soft%
      0.04            +0.0        0.08        mpstat.cpu.all.sys%
    201.33 ±  3%     -34.1%     132.67 ±  7%  perf-c2c.DRAM.remote
    187.83 ±  3%     -28.7%     133.83 ± 12%  perf-c2c.HITM.local
     40.67 ±  7%     -57.4%      17.33 ± 26%  perf-c2c.HITM.remote
      4984            +4.9%       5227        proc-vmstat.nr_shmem
    100999            +3.6%     104640        proc-vmstat.nr_slab_unreclaimable
      8114 ±  2%     +11.0%       9005 ±  2%  proc-vmstat.pgactivate
     20.00         +1907.5%     401.50 ± 79%  proc-vmstat.unevictable_pgs_culled
    965754           -10.3%     866147        sched_debug.cpu.avg_idle.avg
    101797 ± 12%     +41.8%     144376 ±  4%  sched_debug.cpu.avg_idle.stddev
      0.00 ± 22%     -40.7%       0.00 ± 18%  sched_debug.cpu.next_balance.stddev
    886.06 ± 18%    +339.7%       3895 ±  8%  sched_debug.cpu.nr_switches.min
      5474 ± 12%     -23.9%       4164 ± 10%  sched_debug.cpu.nr_switches.stddev
      4.10            -1.2%       4.05        netperf.ThroughputBoth_Mbps
      1049            -1.2%       1037        netperf.ThroughputBoth_total_Mbps
      4.10            -1.2%       4.05        netperf.Throughput_Mbps
      1049            -1.2%       1037        netperf.Throughput_total_Mbps
    102.17 ±  8%    +887.4%       1008 ±  3%  netperf.time.involuntary_context_switches
      2.07 ±  3%    +388.2%      10.11        netperf.time.system_time
     15.14           +18.8%      17.99        perf-stat.i.MPKI
 1.702e+08            +1.6%  1.729e+08        perf-stat.i.branch-instructions
      1.68            +0.0        1.71        perf-stat.i.branch-miss-rate%
     18.46            +3.1       21.57        perf-stat.i.cache-miss-rate%
   4047319           +19.7%    4846291        perf-stat.i.cache-misses
  22007366            +3.2%   22707969        perf-stat.i.cache-references
      1.84           +17.0%       2.15        perf-stat.i.cpi
 9.159e+08           +10.4%  1.011e+09        perf-stat.i.cpu-cycles
    161.08          +183.7%     456.91 ±  2%  perf-stat.i.cpu-migrations
    190.71            -1.6%     187.66        perf-stat.i.cycles-between-cache-misses
 8.434e+08            +1.2%  8.535e+08        perf-stat.i.instructions
      0.61           -10.6%       0.54        perf-stat.i.ipc
      4.79           +18.4%       5.66        perf-stat.overall.MPKI
      4.21            -0.1        4.14        perf-stat.overall.branch-miss-rate%
     18.39            +2.9       21.33        perf-stat.overall.cache-miss-rate%
      1.09            +9.1%       1.19        perf-stat.overall.cpi
    227.07            -7.8%     209.29        perf-stat.overall.cycles-between-cache-misses
      0.92            -8.3%       0.84        perf-stat.overall.ipc
   1379820            +2.3%    1411871        perf-stat.overall.path-length
 1.702e+08            +1.5%  1.728e+08        perf-stat.ps.branch-instructions
   4035389           +19.7%    4830446        perf-stat.ps.cache-misses
  21948285            +3.2%   22642774        perf-stat.ps.cache-references
 9.163e+08           +10.3%  1.011e+09        perf-stat.ps.cpu-cycles
    160.61          +183.5%     455.30 ±  2%  perf-stat.ps.cpu-migrations
 8.433e+08            +1.1%  8.529e+08        perf-stat.ps.instructions
 2.551e+11            +1.5%  2.589e+11        perf-stat.total.instructions
     31.82 ±  3%     -12.9       18.91 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     36.90 ±  2%     -12.1       24.83 ±  7%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     27.61 ±  3%     -11.9       15.68 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
     31.75 ±  2%     -11.5       20.25 ±  8%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     24.39 ±  3%     -10.0       14.38 ±  8%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
     24.33 ±  3%     -10.0       14.36 ±  8%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
     21.00 ±  3%      -9.2       11.84 ±  9%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     20.97 ±  3%      -9.1       11.83 ±  9%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu
     20.97 ±  3%      -9.1       11.84 ±  9%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      4.92 ± 10%      -4.0        0.91 ± 28%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.81 ± 13%      -1.5        0.29 ±100%  perf-profile.calltrace.cycles-pp.run_timer_softirq.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      9.76 ±  7%      -1.5        8.26 ±  8%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      5.08 ±  7%      -1.0        4.12 ± 12%  perf-profile.calltrace.cycles-pp.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      2.99 ±  4%      -0.8        2.22 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.98 ±  4%      -0.8        2.22 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.66 ±  7%      -0.7        0.95 ± 11%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      1.58 ±  5%      -0.7        0.90 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.05 ±  9%      -0.5        0.52 ± 49%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_generate_timeout_event.call_timer_fn.__run_timers
      0.95 ± 14%      -0.5        0.50 ± 46%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.90 ± 14%      -0.4        0.53 ± 47%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.90 ± 14%      -0.4        0.52 ± 47%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.64 ± 17%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ± 17%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.96 ±  8%      -0.3        0.65 ± 45%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96 ±  8%      -0.3        0.64 ± 45%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96 ±  8%      -0.3        0.65 ± 45%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.53 ±  4%      -0.3        1.22 ± 12%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.53 ±  4%      -0.3        1.24 ± 12%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.62 ±  4%      -0.3        1.33 ± 12%  perf-profile.calltrace.cycles-pp.read
      1.57 ±  5%      -0.3        1.28 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.57 ±  5%      -0.3        1.28 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.23 ±  8%      -0.2        1.03 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.50 ± 45%      +0.4        0.92 ± 14%  perf-profile.calltrace.cycles-pp.rebalance_domains._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single
      0.45 ± 72%      +0.5        0.95 ± 17%  perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.75 ± 46%      +0.5        1.26 ± 24%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg
      0.82 ± 45%      +0.5        1.36 ± 22%  perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg
      1.08 ± 12%      +0.6        1.68 ± 14%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.08 ± 12%      +0.6        1.68 ± 14%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      1.08 ± 12%      +0.6        1.68 ± 14%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.18 ±141%      +0.6        0.83 ± 14%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains._nohz_idle_balance.__do_softirq.irq_exit_rcu
      0.00            +0.7        0.66 ± 18%  perf-profile.calltrace.cycles-pp.sctp_generate_timeout_event.call_timer_fn.__run_timers.timer_expire_remote.tmigr_handle_remote_up
      0.30 ±101%      +0.7        0.97 ± 28%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put.sctp_ulpevent_free
      0.00            +0.8        0.77 ± 18%  perf-profile.calltrace.cycles-pp.call_timer_fn.__run_timers.timer_expire_remote.tmigr_handle_remote_up.tmigr_handle_remote
      0.00            +0.8        0.80 ± 17%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put.sctp_datamsg_put
      3.45 ± 14%      +0.8        4.26 ± 11%  perf-profile.calltrace.cycles-pp.__memcpy.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data
      3.46 ± 14%      +0.8        4.28 ± 10%  perf-profile.calltrace.cycles-pp.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter
      0.00            +0.8        0.82 ± 18%  perf-profile.calltrace.cycles-pp.__run_timers.timer_expire_remote.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq
      0.00            +0.8        0.83 ± 17%  perf-profile.calltrace.cycles-pp.timer_expire_remote.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu
      0.00            +0.8        0.84 ± 31%  perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put
      4.44 ± 14%      +0.9        5.36 ± 10%  perf-profile.calltrace.cycles-pp.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      0.00            +0.9        0.94 ± 16%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.sctp_chunk_put.sctp_datamsg_put.sctp_chunk_free
      4.33 ± 14%      +0.9        5.27 ± 10%  perf-profile.calltrace.cycles-pp.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      2.42 ±  9%      +1.1        3.56 ± 17%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
      2.41 ±  9%      +1.1        3.55 ± 17%  perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      2.42 ±  9%      +1.2        3.58 ± 17%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit
      2.34 ± 10%      +1.2        3.50 ± 17%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      2.56 ±  8%      +1.2        3.74 ± 17%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
      1.72 ± 15%      +1.2        2.91 ± 19%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase
      1.76 ± 14%      +1.2        2.97 ± 18%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free
      1.88 ± 13%      +1.2        3.10 ± 18%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg
      2.34 ±  9%      +1.2        3.57 ± 19%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
      2.34 ± 10%      +1.2        3.57 ± 19%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
      1.98 ± 13%      +1.3        3.23 ± 19%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg
      2.23 ± 10%      +1.3        3.50 ± 19%  perf-profile.calltrace.cycles-pp.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +1.4        1.37 ±  9%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.4        1.38 ± 10%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.52 ±  7%      +1.8        5.30 ± 15%  perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      4.94 ±  5%      +5.6       10.58 ± 16%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      4.94 ±  5%      +5.6       10.58 ± 16%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      4.94 ±  5%      +5.6       10.58 ± 16%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.83 ±  9%      +5.9        8.73 ± 18%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.73 ± 12%      +6.2        7.93 ± 18%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.73 ± 12%      +6.2        7.93 ± 18%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.70 ± 13%      +6.2        7.91 ± 18%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd
      1.70 ± 13%      +6.2        7.91 ± 18%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      1.70 ± 12%      +6.2        7.92 ± 18%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      0.00           +10.2       10.24 ± 89%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     36.91 ±  2%     -12.1       24.83 ±  7%  perf-profile.children.cycles-pp.acpi_idle_enter
     36.80 ±  2%     -12.0       24.80 ±  7%  perf-profile.children.cycles-pp.acpi_safe_halt
     29.95 ±  3%     -11.8       18.19 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     27.78 ±  3%     -11.4       16.39 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     25.75 ±  2%      -9.1       16.65 ±  9%  perf-profile.children.cycles-pp.irq_exit_rcu
      5.07 ±  3%      -3.4        1.71 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock
      6.04 ±  8%      -3.3        2.70 ± 17%  perf-profile.children.cycles-pp._nohz_idle_balance
      2.80 ±  6%      -2.3        0.51 ± 31%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.83 ± 13%      -1.3        0.51 ± 30%  perf-profile.children.cycles-pp.run_timer_softirq
      5.62 ±  5%      -1.1        4.52 ± 10%  perf-profile.children.cycles-pp.sctp_outq_flush_data
      1.40 ± 13%      -1.0        0.38 ± 25%  perf-profile.children.cycles-pp.tick_irq_enter
      1.44 ± 13%      -1.0        0.44 ± 18%  perf-profile.children.cycles-pp.irq_enter_rcu
      1.77 ± 11%      -1.0        0.78 ± 20%  perf-profile.children.cycles-pp.__mod_timer
      1.36 ± 15%      -0.9        0.48 ± 24%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.97 ± 15%      -0.9        0.10 ± 38%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      1.46 ± 11%      -0.9        0.60 ± 23%  perf-profile.children.cycles-pp.sctp_transport_reset_t3_rtx
      1.53 ±  7%      -0.6        0.92 ± 21%  perf-profile.children.cycles-pp.update_blocked_averages
      1.00 ± 27%      -0.5        0.45 ± 32%  perf-profile.children.cycles-pp.update_rq_clock_task
      1.73 ±  7%      -0.5        1.21 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.65 ±  5%      -0.5        1.14 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.94 ±  6%      -0.4        1.56 ± 13%  perf-profile.children.cycles-pp.vfs_read
      1.16 ± 10%      -0.3        0.84 ± 19%  perf-profile.children.cycles-pp.sctp_generate_timeout_event
      0.66 ± 12%      -0.3        0.37 ± 17%  perf-profile.children.cycles-pp.update_rq_clock
      0.99 ±  8%      -0.3        0.73 ± 20%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.99 ±  8%      -0.3        0.73 ± 20%  perf-profile.children.cycles-pp.do_group_exit
      0.99 ±  8%      -0.3        0.73 ± 20%  perf-profile.children.cycles-pp.do_exit
      0.34 ± 17%      -0.2        0.12 ± 46%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.28 ± 23%      -0.2        0.07 ± 83%  perf-profile.children.cycles-pp.__release_sock
      1.24 ±  9%      -0.2        1.03 ± 10%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.54 ± 17%      -0.2        0.33 ± 20%  perf-profile.children.cycles-pp.idle_cpu
      0.30 ± 16%      -0.2        0.10 ± 32%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.09 ±  5%      -0.2        0.88 ± 15%  perf-profile.children.cycles-pp.seq_read_iter
      0.26 ± 26%      -0.2        0.07 ± 83%  perf-profile.children.cycles-pp.sctp_backlog_rcv
      0.35 ± 25%      -0.2        0.15 ± 41%  perf-profile.children.cycles-pp.release_sock
      0.39 ± 19%      -0.2        0.20 ± 11%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.72 ± 13%      -0.2        0.54 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.50 ± 14%      -0.2        0.33 ± 18%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.39 ± 18%      -0.2        0.23 ± 14%  perf-profile.children.cycles-pp.sctp_inq_pop
      0.51 ± 15%      -0.2        0.35 ± 20%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.46 ± 14%      -0.1        0.32 ± 18%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.26 ± 20%      -0.1        0.14 ± 29%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.46 ± 10%      -0.1        0.34 ± 20%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.22 ± 17%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.should_we_balance
      0.21 ± 13%      -0.1        0.10 ± 20%  perf-profile.children.cycles-pp.lookup_fast
      0.36 ± 16%      -0.1        0.25 ± 24%  perf-profile.children.cycles-pp.__split_vma
      0.29 ± 10%      -0.1        0.20 ± 27%  perf-profile.children.cycles-pp.wp_page_copy
      0.54 ± 11%      -0.1        0.45 ±  8%  perf-profile.children.cycles-pp.balance_fair
      0.14 ± 34%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.vma_prepare
      0.21 ± 28%      -0.1        0.13 ± 27%  perf-profile.children.cycles-pp.vsnprintf
      0.14 ± 31%      -0.1        0.05 ± 75%  perf-profile.children.cycles-pp.irqentry_exit
      0.15 ± 17%      -0.1        0.07 ± 45%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.19 ± 19%      -0.1        0.12 ± 21%  perf-profile.children.cycles-pp.__vm_munmap
      0.10 ± 22%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.dev_attr_show
      0.10 ± 22%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.22 ±  8%      -0.0        0.17 ± 17%  perf-profile.children.cycles-pp.diskstats_show
      0.05 ± 72%      +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.__fdget_pos
      0.07 ± 52%      +0.1        0.16 ± 44%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.06 ±106%      +0.1        0.18 ± 32%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.2        0.17 ± 24%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.00            +0.2        0.18 ± 23%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      0.06 ± 23%      +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.2        0.19 ± 19%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.00            +0.2        0.20 ± 20%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.00            +0.4        0.38 ± 17%  perf-profile.children.cycles-pp.tmigr_update_events
      0.07 ± 24%      +0.4        0.49 ± 13%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      2.29 ±  4%      +0.7        3.02 ± 12%  perf-profile.children.cycles-pp.__kmalloc_large_node
      2.32 ±  4%      +0.7        3.05 ± 13%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      2.09 ±  8%      +0.7        2.82 ± 13%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.9        0.86 ± 16%  perf-profile.children.cycles-pp.timer_expire_remote
      1.25 ± 10%      +0.9        2.15 ± 14%  perf-profile.children.cycles-pp.rmqueue
      1.48 ± 14%      +1.0        2.51 ± 13%  perf-profile.children.cycles-pp.__free_pages_ok
      0.58 ± 29%      +1.1        1.66 ± 14%  perf-profile.children.cycles-pp.free_one_page
      3.00 ±  6%      +1.1        4.11 ± 17%  perf-profile.children.cycles-pp.ip_finish_output2
      2.88 ±  6%      +1.1        4.00 ± 17%  perf-profile.children.cycles-pp.__dev_queue_xmit
      2.23 ± 10%      +1.3        3.50 ± 19%  perf-profile.children.cycles-pp.sctp_assoc_rwnd_increase
      0.00            +1.4        1.40 ±  8%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      0.00            +1.4        1.43 ±  9%  perf-profile.children.cycles-pp.tmigr_handle_remote
      2.43 ±  9%      +1.5        3.91 ± 18%  perf-profile.children.cycles-pp.do_softirq
      2.46 ±  9%      +1.5        3.95 ± 18%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      2.16 ±  9%      +1.7        3.87 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.53 ±  7%      +1.8        5.30 ± 14%  perf-profile.children.cycles-pp.sctp_ulpevent_free
      5.02 ±  5%      +5.6       10.65 ± 15%  perf-profile.children.cycles-pp.ret_from_fork_asm
      5.00 ±  4%      +5.6       10.64 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
      4.94 ±  5%      +5.6       10.58 ± 16%  perf-profile.children.cycles-pp.kthread
      2.83 ±  9%      +5.9        8.74 ± 18%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.73 ± 12%      +6.2        7.93 ± 18%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.02 ±141%     +10.3       10.31 ± 88%  perf-profile.children.cycles-pp.poll_idle
      2.41 ±  5%      -1.1        1.32 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
      1.11 ± 19%      -0.7        0.37 ± 20%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.84 ± 28%      -0.5        0.34 ± 30%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.65 ± 23%      -0.5        0.16 ± 34%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.29 ± 16%      -0.2        0.07 ± 62%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.52 ± 19%      -0.2        0.31 ± 21%  perf-profile.self.cycles-pp.idle_cpu
      0.43 ±  9%      -0.2        0.23 ± 23%  perf-profile.self.cycles-pp.update_rq_clock
      0.25 ± 28%      -0.1        0.12 ± 50%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.16 ± 34%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.need_update
      0.16 ± 32%      -0.1        0.06 ± 80%  perf-profile.self.cycles-pp.call_cpuidle
      0.12 ± 19%      -0.1        0.04 ±101%  perf-profile.self.cycles-pp.sctp_inq_pop
      0.23 ± 22%      -0.1        0.15 ± 42%  perf-profile.self.cycles-pp.sctp_check_transmitted
      0.13 ± 47%      -0.1        0.06 ± 55%  perf-profile.self.cycles-pp.all_vm_events
      0.19 ± 14%      -0.1        0.12 ± 25%  perf-profile.self.cycles-pp.filemap_map_pages
      0.05 ± 72%      +0.1        0.11 ± 24%  perf-profile.self.cycles-pp.__fdget_pos
      0.08 ± 54%      +0.1        0.16 ± 22%  perf-profile.self.cycles-pp.sctp_skb_recv_datagram
      0.00            +0.1        0.09 ± 31%  perf-profile.self.cycles-pp.tmigr_cpu_activate
      0.00            +0.2        0.18 ± 26%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.02 ±141%     +10.1       10.08 ± 90%  perf-profile.self.cycles-pp.poll_idle




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


