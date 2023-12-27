Return-Path: <linux-kernel+bounces-11908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CCB81ED64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5931C215CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8555687;
	Wed, 27 Dec 2023 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+H21L/7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6AE6FA3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703666567; x=1735202567;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=lMC0b21O8jkT3WnFIoyC81HrcF2dV+s4HGMt0nvzbQA=;
  b=G+H21L/7nIAw9npm32IcDZ2RoHdr+pkVXDeFdcDRL9gZ4idCba9V19mm
   Eay41zM6GAd+zkxWP8yLYka6rriCqXIZlJ9GWC09kErnfLW13/RKN+FXj
   lT2MAQFkq/kudjEkKYMxqzDSbn8iUWjkHpz/4DdmjxRc3JAJgcZpIy0g3
   tcDsSTWdz5Xtp8MX64bwApl8htlxnqI4KInX4qI2VnJS7E1D+Da4EZqpT
   CZ0HkEUKSt3ofyqeQb46pO6CTF7kd6SyfhnQh7sOhqEk+SyJkYefgxbMm
   32Irt2T9Bz/IHTD6Ho3KlSxuVIhFBYy6DZh8pLvzgWJdQidqVmsxi9ctu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3262067"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="3262067"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 00:42:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="896828520"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="896828520"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 00:42:45 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 00:42:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 00:42:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 00:42:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV662DvJiT9LYRsRzBD18r6/xG8qAhg6MI0ZmSGj3MHXVXEWZmEMrHDFGNRRVT+RZI9l5d23OIi98OQehtrgeuF/Wvac0vDSzz/dDP1TdeIumiHvx7uN3oLRVqZT5rZ71etnhGqcANQ1bGoidXoVthh/0nECJVBM24Q40xET8BdSoEeT9akKx7y/ffwfHSfrWnSdinZle4gowEf7E9/zydrR0BKrouKNQIBgt1hgRfWI9CamPlstSlGD2GyHm+R2vqe0zfWaEYerrCSNu9F+AfnNrhm5ARwEvmw3MW1h4pQhqqaOjT5nBGtfh3H51/tKViAl+/R9c7VCQFLUz41A8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri4Wrf1j7q9qU8sOmVVxYLpEn38CK8RcOs/GitRc0VM=;
 b=lqRUlTvs09dHolibPkvboT/831rdFfn92/V+I520rrafWFHaw0i1smuC3CjZxoQJ2I2ogiL+/TntDXluOrf3QCsfUwdmN5aVWXgZHPY6kgwimrqMdB1q9CLxsedd7asyKQB254UCqZAZzi60LRkWiAq1bNu6ksffZEu9VTi3PaBNtKfrdtSX9keT7gVvd2e3wiMrW6ZE3vTGWo+59wd15SO2GKPLZ7t9Z2V30H7Rr6k6pUe/RP3mQ6YwTQY6K5UUlfZF/8U2u+LOl/KKNQwUWkznoIb6p6u8Kaa1NCaRwRm1mJ15NT8VQqGZNvsJ8D1hnO3LAn10bOYCFmKSTEX45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Wed, 27 Dec
 2023 08:42:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 08:42:34 +0000
Date: Wed, 27 Dec 2023 16:42:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [tj-wq:unbound-system-wide-max_active] [workqueue]  f18db269e6:
 stress-ng.dir.ops_per_sec -67.1% regression
Message-ID: <202312271616.14f41ba2-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c49200-57a3-4c24-f4c4-08dc06b7c496
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udRxLfJybkEm17UtokBTLuBtxPJ0FOqfT4Q9iGAYS97B7id7Oo3Y9zTRZmD2HCGapO+MMdUCNuav8b6CCWOW33/jTjCqaBehWd4UKOxSkMUFtzWffvWNQpyb0BXajx9YJh9nH3giiIrQmgmB37JzwutH2Fz1Mv6rKdHVq8EZtn7ur6EIHLJkIhYirlCXjZQ5L4E+SBa0ns3/tdbYR6T+KKZoehmedN291tDTwzKioqhwBOCk7T68wWqgLp6HQZjbvoaQGaY4krs4G08dckmdkiQSfNIb6NV7yHdoHs52v+JvqcC7VMueQnDhcUSXRZruU+lDsrFJBHI5BfgqwTezhIf+oUB4BnRbOkS/Ra42OMrTpGs9R2da6vzFga9CxUD4KTruNse6Ji+AuBoJrW2lnPFEvSH1chF8NeFeGrp+LHXYQHppkl2hjMl+gioTHyX/UfqXpZzjvaaxR3xoZQbmAwBSMOhEP6+EfF5RHv0JxmINoYwZ4kz0limag6gkuJ0NuVKl8+FcXBBAOpBe8Ya7qfnDzlrM/0a3rY3dDj/Qk4FG5ptDxB/R9UlZVWl107vVXMxsZDrFOr4ttrF8II8ts7C1Ml1ad15HCYpJZ3+7MXXanAnmG0pmolskpmiLjf+r+TuYSW+Q8LYOzc5AKxrAGqMjL0ifnlfpZg9OSsbQIy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(230473577357003)(230373577357003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(66574015)(82960400001)(86362001)(36756003)(38100700002)(41300700001)(6486002)(966005)(66476007)(66556008)(66946007)(5660300002)(8936002)(8676002)(4326008)(2616005)(1076003)(6916009)(478600001)(316002)(6506007)(30864003)(107886003)(26005)(6512007)(6666004)(2906002)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ureBoA1LAuw5gVaOk9Qlva5HbN9iiuGn7icznYDhEVxVQ+evxADiFXHooo?=
 =?iso-8859-1?Q?tAErYoznNf4VP4ajcLTRaRiunxkB0fcZW9swO0+Y4jP3Y/gkgdDLupds35?=
 =?iso-8859-1?Q?/lavN1yMokN5+2gbXqH9nqpynLVWWjRABY5ICOKzrR7LhPnRs2duqhNznC?=
 =?iso-8859-1?Q?S+DvnjkxzOwZwO4osPR6Ja77iLIB9CPSPSH9DxGfgXnjMaoaJW9In+L1gQ?=
 =?iso-8859-1?Q?bvwWp7IkkptgxAo/0aWRq618YXcqcvi0ARF75J037IQ/KH5jVTb5HKwYvm?=
 =?iso-8859-1?Q?ckA3zm3gIEyXTr/FqKQUqU3ZLSXb49I7xTUcqcvCavHFKtf6N6qJnyH9Dy?=
 =?iso-8859-1?Q?Vk9Nz88tFXwQm+2olNrAacI6wIK6q44G0LhSBkh6kLYbIPGymd6NvxONSg?=
 =?iso-8859-1?Q?cCIJBLzrnQHUF2XxgpebEAxQMiygH7Lt6bjVK67a/LNrnF6BgQ5SHEriCh?=
 =?iso-8859-1?Q?JOfTvzWXoNiPzvCu7DIl4Uf63mHW1ITvxAN2SG7jyqkcKqHHalJ3pv0UjW?=
 =?iso-8859-1?Q?LZEJjAQsP3gD8jfXs2kv11ZVM6dGSC9fTo2jAjl9uWrmATKSqnnYtAXuKy?=
 =?iso-8859-1?Q?J9Vr1MQKCFcqC2sn22k0XOx822yxqAZ2O7YKjQpMaErDwcpMKufKj3szws?=
 =?iso-8859-1?Q?jcrMTy81B1GjMt1rtx/7drQzhwDZEfGgqoCj0gH2isMwYzKbqkgeMd+Ba7?=
 =?iso-8859-1?Q?OKLQqiOCNlUFxCLOmsskTANdurO40u8P2pvVpPe6pl+2gnGSsa71nISnl8?=
 =?iso-8859-1?Q?D5Y+dIVA5eRk4AgvMNQMhgbroJZRymFpieMQ6gW2CSdDHTi+ghPeGYs6yf?=
 =?iso-8859-1?Q?pEEy1haSeQ+7u44e5Cpj7dFjxC/VwZm2zT1962oI6PTvzK5bDq3VhADhuR?=
 =?iso-8859-1?Q?DjvnhJ1W7+BFCcvYa5Vard5Bpa4kuQokHWYRgDF7i0/poLaHcCKXz23hzf?=
 =?iso-8859-1?Q?quI9reBniyRqSuJMR//idxAPpQcLCHdHSySkuVdqC6coItQRHfIv5VNRQC?=
 =?iso-8859-1?Q?Jnm81UIWUYyokOUbDwMZh4BLTWuW1i9z7vP7abCLiKI2Kta9UWHrHwqBZC?=
 =?iso-8859-1?Q?mQCtFwEThrQJBjl4uGIONkfsEq6RX6ECC9qqFIGR90JHS47AGZbc3EL3w3?=
 =?iso-8859-1?Q?xCC1ZIM8UX5oI0mqFNc57fxSzrItVIJK2PL83hMInjNoqD+9yuhoYfBv6z?=
 =?iso-8859-1?Q?txiDNO/WwDFCndmcwjrOwEPFgMxyTMrbKGtsrA9EN9ZHp5HD7LVcOWPka9?=
 =?iso-8859-1?Q?Mx4o6zzV+62Xkf48VS9aQT0nCOuipDyDZQz3qVI8Q/H9lnwR8bI9dLNAfd?=
 =?iso-8859-1?Q?9tWEXxpd0ADNFs4hYiFNV/fvIZYKMA8ypH2hIf9cdmt9oZfZjOHIR+roOX?=
 =?iso-8859-1?Q?O9wnMy3hLOXadWUllUjUJuPVHPKONGcYKycSPst2ipqjHW3nyuUB/sWo68?=
 =?iso-8859-1?Q?CVCHDbaSWbaOrtxXmN+h76DthgY9wYvgH9LUvxt59Phh1sEdYU2EPzFKvh?=
 =?iso-8859-1?Q?0BQjUUxIp1vwM3mMH3VNa6ze2K3qvii88ZklCrLkkgay3Sd6GRgAD+BXaN?=
 =?iso-8859-1?Q?zOHYjreaQNvEKmFo4fhu9bpF6zEsbZAss0SZ41pdRGGa5xab7YuAvCr6+K?=
 =?iso-8859-1?Q?C1ju1EjmU6cPtMMF+B4HOv+yyswRAW/EasuFOi3+HSApwjRSA69QXW6A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c49200-57a3-4c24-f4c4-08dc06b7c496
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 08:42:33.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fx4dgx00kEw4ZLEkP/IshzFL39AKDhxoqc3knrSWkOxg/ObkmcBMw5PQAw46G+GMwBvMmtX8xoLMiGwlvKULJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -67.1% regression of stress-ng.dir.ops_per_sec on:


commit: f18db269e694c090e530cbdca28b6f0574c218fe ("workqueue: Reimplement ordered workqueue using shared nr_active")
https://git.kernel.org/cgit/linux/kernel/git/tj/wq.git unbound-system-wide-max_active

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	class: filesystem
	test: dir
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312271616.14f41ba2-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231227/202312271616.14f41ba2-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/dir/stress-ng/60s

commit: 
  b9e3571c2b ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
  f18db269e6 ("workqueue: Reimplement ordered workqueue using shared nr_active")

b9e3571c2b99af71 f18db269e694c090e530cbdca28 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     14310 ± 52%     +83.3%      26229 ± 26%  sched_debug.cfs_rq:/.load.avg
 3.572e+09           +30.9%  4.677e+09 ± 12%  cpuidle..time
  13976041           -43.4%    7917297 ±  9%  cpuidle..usage
     85.76            +7.7%      92.34        iostat.cpu.idle
     13.22           -46.7%       7.04 ± 17%  iostat.cpu.system
    546437 ±  9%     -63.4%     200183 ± 79%  numa-meminfo.node1.Active(anon)
      2548 ± 41%    +132.0%       5912 ± 39%  numa-meminfo.node1.Inactive(file)
    101.42           +13.6%     115.20 ±  7%  uptime.boot
      5653           +19.6%       6763 ±  8%  uptime.idle
    136610 ±  9%     -63.4%      50046 ± 79%  numa-vmstat.node1.nr_active_anon
    637.10 ± 41%    +132.0%       1478 ± 39%  numa-vmstat.node1.nr_inactive_file
    136610 ±  9%     -63.4%      50046 ± 79%  numa-vmstat.node1.nr_zone_active_anon
    637.10 ± 41%    +132.0%       1478 ± 39%  numa-vmstat.node1.nr_zone_inactive_file
      0.89            -0.2        0.67 ±  7%  mpstat.cpu.all.irq%
      0.44 ±  2%      -0.3        0.15 ± 39%  mpstat.cpu.all.nice%
      0.05            -0.0        0.04 ±  9%  mpstat.cpu.all.soft%
     12.64            -6.2        6.49 ± 19%  mpstat.cpu.all.sys%
      0.34            -0.1        0.24 ± 16%  mpstat.cpu.all.usr%
    303.25 ± 10%     -83.7%      49.38 ± 45%  perf-c2c.DRAM.local
      2587 ± 11%     -91.0%     233.50 ± 46%  perf-c2c.DRAM.remote
      2313 ±  6%     -88.7%     260.62 ± 50%  perf-c2c.HITM.local
      1399 ± 12%     -91.4%     120.12 ± 47%  perf-c2c.HITM.remote
      3712 ±  6%     -89.7%     380.75 ± 48%  perf-c2c.HITM.total
     85.76            +7.7%      92.34        vmstat.cpu.id
      3219 ±  6%     +50.9%       4859 ± 16%  vmstat.io.bo
   4069279           -10.8%    3629491 ±  6%  vmstat.memory.cache
      8.97 ±  3%     -47.8%       4.68 ± 20%  vmstat.procs.r
    330746 ±  3%     -72.7%      90212 ± 45%  vmstat.system.cs
    235899 ±  2%     -53.1%     110640 ± 18%  vmstat.system.in
    546.25           -47.6%     286.25 ± 18%  turbostat.Avg_MHz
     15.19            -7.2        7.96 ± 18%  turbostat.Busy%
  13950444           -43.5%    7884145 ±  9%  turbostat.C1
     86.21            +6.8       93.05        turbostat.C1%
  15564955           -44.3%    8666505 ±  9%  turbostat.IRQ
    282.52            -8.7%     257.80        turbostat.PkgWatt
     68.16            -7.1%      63.33        turbostat.RAMWatt
   1039660           -62.8%     386712 ± 26%  stress-ng.dir.ops
     17141           -67.1%       5639 ± 34%  stress-ng.dir.ops_per_sec
     62.78           +22.1%      76.63 ± 11%  stress-ng.time.elapsed_time
     62.78           +22.1%      76.63 ± 11%  stress-ng.time.elapsed_time.max
    947300           -28.4%     677958 ± 14%  stress-ng.time.file_system_outputs
    835.25           -49.1%     425.50 ± 19%  stress-ng.time.percent_of_cpu_this_job_got
    503.53           -38.1%     311.88 ±  9%  stress-ng.time.system_time
     21.07           -61.5%       8.12 ± 28%  stress-ng.time.user_time
   9927887 ±  2%     -68.6%    3121583 ± 35%  stress-ng.time.voluntary_context_switches
    854775 ±  5%     -46.4%     457988 ± 48%  meminfo.Active
    290799 ±  3%     -29.1%     206186 ± 16%  meminfo.Active(file)
     54224 ±  6%     +15.0%      62336 ±  7%  meminfo.AnonHugePages
   3914327           -10.9%    3486889 ±  6%  meminfo.Cached
     14645 ±  2%     -29.3%      10353 ± 12%  meminfo.Dirty
    475073            -9.3%     430810 ±  5%  meminfo.Inactive
    469741           -10.5%     420485 ±  5%  meminfo.Inactive(anon)
      5331 ±  7%     +93.7%      10325 ± 14%  meminfo.Inactive(file)
    132397           -13.5%     114535 ±  7%  meminfo.Mapped
   5339076            -8.8%    4867807 ±  5%  meminfo.Memused
      0.00 ± 10%     -78.4%       0.00 ±173%  perf-sched.sch_delay.avg.ms.btrfs_start_ordered_extent.btrfs_run_ordered_extent_work.btrfs_work_helper.process_one_work
      0.01 ± 11%     -80.5%       0.00 ±173%  perf-sched.sch_delay.max.ms.btrfs_start_ordered_extent.btrfs_run_ordered_extent_work.btrfs_work_helper.process_one_work
      1.61 ± 12%     -76.4%       0.38 ±173%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  6%   +1286.6%       0.30 ±111%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      1.62 ± 12%     -76.4%       0.38 ±173%  perf-sched.wait_and_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     88422 ± 10%     -56.4%      38545 ± 76%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
     34776 ± 21%     -64.3%      12426 ± 99%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_inode_lock
      9.75 ± 26%     -71.8%       2.75 ±114%  perf-sched.wait_and_delay.count.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
      3.21 ± 12%     -76.4%       0.76 ±173%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3.23 ± 12%     -76.3%       0.76 ±173%  perf-sched.wait_and_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ±264%   +4730.6%       0.37 ±106%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_next_old_leaf.btrfs_get_next_valid_item.btrfs_real_readdir
      0.01 ±142%   +7741.1%       0.55 ± 92%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_real_readdir.iterate_dir.__x64_sys_getdents64
      0.01 ± 89%     -78.9%       0.00 ±155%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     39.33 ±122%     -99.6%       0.14 ±174%  perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent.btrfs_run_ordered_extent_work.btrfs_work_helper.process_one_work
      0.02 ±  8%   +1485.2%       0.30 ±112%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.37 ± 61%     -86.7%       0.05 ±133%  perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
      0.01 ±264%  +40943.5%       3.18 ±113%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_next_old_leaf.btrfs_get_next_valid_item.btrfs_real_readdir
      0.01 ±182%  +36249.5%       4.77 ±151%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_real_readdir.iterate_dir.__x64_sys_getdents64
     81.54 ±121%     -99.8%       0.15 ±175%  perf-sched.wait_time.max.ms.btrfs_start_ordered_extent.btrfs_run_ordered_extent_work.btrfs_work_helper.process_one_work
      5.84 ±222%   +1491.3%      92.86 ±120%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_get_dir_last_index
      0.77 ± 44%     -80.9%       0.15 ±157%  perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
      0.02 ± 48%     -66.7%       0.01 ± 26%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     72703 ±  3%     -29.1%      51551 ± 16%  proc-vmstat.nr_active_file
     86176            -4.1%      82681 ±  2%  proc-vmstat.nr_anon_pages
    162037           -39.2%      98572 ± 16%  proc-vmstat.nr_dirtied
      3661 ±  2%     -29.3%       2588 ± 12%  proc-vmstat.nr_dirty
    978853           -10.9%     871995 ±  6%  proc-vmstat.nr_file_pages
    117443           -10.5%     105130 ±  5%  proc-vmstat.nr_inactive_anon
      1332 ±  7%     +93.8%       2582 ± 14%  proc-vmstat.nr_inactive_file
     33104           -13.5%      28645 ±  7%  proc-vmstat.nr_mapped
     37036            -5.1%      35129 ±  2%  proc-vmstat.nr_slab_reclaimable
     30558 ±  5%     +66.6%      50923 ± 10%  proc-vmstat.nr_written
     72703 ±  3%     -29.1%      51551 ± 16%  proc-vmstat.nr_zone_active_file
    117443           -10.5%     105130 ±  5%  proc-vmstat.nr_zone_inactive_anon
      1332 ±  7%     +93.8%       2582 ± 14%  proc-vmstat.nr_zone_inactive_file
      3660 ±  2%     -29.4%       2585 ± 13%  proc-vmstat.nr_zone_write_pending
     12326 ± 27%     -46.1%       6639 ± 50%  proc-vmstat.numa_hint_faults
    828499 ±  2%     -24.5%     625396 ± 13%  proc-vmstat.numa_hit
    762250 ±  2%     -26.6%     559153 ± 15%  proc-vmstat.numa_local
    277559 ±  5%     -52.2%     132739 ± 59%  proc-vmstat.pgactivate
   1177828 ±  2%     -33.0%     789385 ± 14%  proc-vmstat.pgalloc_normal
    793573           -24.6%     598138 ±  5%  proc-vmstat.pgfree
    212903 ±  6%     +80.5%     384255 ± 10%  proc-vmstat.pgpgout
     11570           +11.0%      12837 ±  6%  proc-vmstat.pgreuse
      1.66 ±  4%     -59.9%       0.66 ± 26%  perf-stat.i.MPKI
 5.567e+09           -47.2%  2.939e+09 ± 20%  perf-stat.i.branch-instructions
      0.36            -0.1        0.27 ±  8%  perf-stat.i.branch-miss-rate%
  17919104           -48.7%    9195910 ± 20%  perf-stat.i.branch-misses
     33.33 ±  3%     -12.9       20.46 ± 14%  perf-stat.i.cache-miss-rate%
  49265912 ±  2%     -74.2%   12700446 ± 48%  perf-stat.i.cache-misses
 1.452e+08           -65.9%   49474034 ± 35%  perf-stat.i.cache-references
    345782 ±  3%     -72.8%      94107 ± 45%  perf-stat.i.context-switches
      1.20           +30.1%       1.56 ±  7%  perf-stat.i.cpi
 3.534e+10           -49.1%  1.798e+10 ± 19%  perf-stat.i.cpu-cycles
    160.67 ±  2%     -33.7%     106.60 ±  9%  perf-stat.i.cpu-migrations
    803.03 ±  4%    +544.4%       5174 ± 35%  perf-stat.i.cycles-between-cache-misses
    320494 ±  7%     -57.2%     137326 ± 38%  perf-stat.i.dTLB-load-misses
 7.155e+09           -56.1%  3.144e+09 ± 26%  perf-stat.i.dTLB-loads
      0.00 ±  6%      +0.0        0.00 ± 31%  perf-stat.i.dTLB-store-miss-rate%
     33935 ±  9%     -31.5%      23260 ± 10%  perf-stat.i.dTLB-store-misses
 4.978e+09           -66.1%  1.689e+09 ± 37%  perf-stat.i.dTLB-stores
 2.939e+10           -54.7%  1.332e+10 ± 25%  perf-stat.i.instructions
      0.85           -18.3%       0.70 ±  7%  perf-stat.i.ipc
      0.55           -49.1%       0.28 ± 19%  perf-stat.i.metric.GHz
    278.75           -56.3%     121.88 ± 26%  perf-stat.i.metric.M/sec
      4017           -17.9%       3299 ± 10%  perf-stat.i.minor-faults
     86.21            -6.4       79.80        perf-stat.i.node-load-miss-rate%
  10839927 ±  4%     -75.7%    2637402 ± 50%  perf-stat.i.node-load-misses
   1689671 ±  5%     -66.5%     566054 ± 41%  perf-stat.i.node-loads
     71.41           -10.3       61.11 ±  7%  perf-stat.i.node-store-miss-rate%
   7337215 ±  3%     -76.2%    1747288 ± 52%  perf-stat.i.node-store-misses
   2758888 ±  3%     -73.0%     744949 ± 46%  perf-stat.i.node-stores
      4018           -17.9%       3299 ± 10%  perf-stat.i.page-faults
      1.68 ±  4%     -46.1%       0.90 ± 23%  perf-stat.overall.MPKI
     33.94 ±  3%      -9.3       24.67 ± 13%  perf-stat.overall.cache-miss-rate%
      1.20           +13.8%       1.37 ±  5%  perf-stat.overall.cpi
    718.14 ±  3%    +125.3%       1617 ± 28%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  9%      +0.0        0.00 ± 26%  perf-stat.overall.dTLB-store-miss-rate%
      0.83           -11.8%       0.73 ±  5%  perf-stat.overall.ipc
     86.51            -5.0       81.51 ±  3%  perf-stat.overall.node-load-miss-rate%
     72.67            -3.3       69.35 ±  3%  perf-stat.overall.node-store-miss-rate%
 5.479e+09           -47.0%  2.903e+09 ± 20%  perf-stat.ps.branch-instructions
  17633103           -48.5%    9085001 ± 20%  perf-stat.ps.branch-misses
  48489358 ±  3%     -74.1%   12561819 ± 48%  perf-stat.ps.cache-misses
 1.429e+08           -65.8%   48916511 ± 35%  perf-stat.ps.cache-references
    340301 ±  3%     -72.6%      93149 ± 45%  perf-stat.ps.context-switches
 3.479e+10           -49.0%  1.776e+10 ± 19%  perf-stat.ps.cpu-cycles
    158.23 ±  2%     -33.5%     105.28 ±  9%  perf-stat.ps.cpu-migrations
    315346 ±  7%     -57.0%     135594 ± 38%  perf-stat.ps.dTLB-load-misses
 7.042e+09           -55.9%  3.106e+09 ± 26%  perf-stat.ps.dTLB-loads
     33396 ±  9%     -31.2%      22960 ± 10%  perf-stat.ps.dTLB-store-misses
 4.899e+09           -65.9%  1.669e+09 ± 36%  perf-stat.ps.dTLB-stores
 2.893e+10           -54.5%  1.316e+10 ± 25%  perf-stat.ps.instructions
      3953           -17.7%       3254 ± 10%  perf-stat.ps.minor-faults
  10669475 ±  4%     -75.5%    2609184 ± 50%  perf-stat.ps.node-load-misses
   1662570 ±  5%     -66.3%     559695 ± 41%  perf-stat.ps.node-loads
   7222062 ±  3%     -76.1%    1727988 ± 51%  perf-stat.ps.node-store-misses
   2715037 ±  3%     -72.9%     736472 ± 46%  perf-stat.ps.node-stores
      3953           -17.7%       3254 ± 10%  perf-stat.ps.page-faults
 1.842e+12           -46.1%  9.933e+11 ± 15%  perf-stat.total.instructions
     21.35 ± 12%     -17.4        3.94 ± 35%  perf-profile.calltrace.cycles-pp.vfs_rename.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.12 ± 12%     -17.3        3.86 ± 35%  perf-profile.calltrace.cycles-pp.btrfs_rename2.vfs_rename.do_renameat2.__x64_sys_rename.do_syscall_64
     21.07 ± 12%     -17.2        3.85 ± 36%  perf-profile.calltrace.cycles-pp.btrfs_rename.btrfs_rename2.vfs_rename.do_renameat2.__x64_sys_rename
     17.69 ±  6%     -17.2        0.48 ±129%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
     16.89 ±  6%     -16.5        0.37 ±139%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock.btrfs_lock_root_node
     25.48 ±  5%     -16.0        9.44 ± 15%  perf-profile.calltrace.cycles-pp.open64
     24.87 ±  5%     -15.8        9.09 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     24.80 ±  5%     -15.8        9.05 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     24.62 ±  5%     -15.7        8.95 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     24.54 ±  5%     -15.6        8.92 ± 15%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     22.91 ±  6%     -15.2        7.68 ± 16%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.64 ±  6%     -15.1        7.54 ± 16%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     23.25 ± 12%     -14.5        8.79 ± 34%  perf-profile.calltrace.cycles-pp.rename
     23.17 ± 12%     -14.4        8.77 ± 34%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.rename
     23.17 ± 12%     -14.4        8.77 ± 34%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
     23.12 ± 12%     -14.4        8.76 ± 34%  perf-profile.calltrace.cycles-pp.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
     23.07 ± 12%     -14.3        8.73 ± 34%  perf-profile.calltrace.cycles-pp.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
     13.87 ± 12%     -11.8        2.06 ± 36%  perf-profile.calltrace.cycles-pp.__btrfs_unlink_inode.btrfs_rename.btrfs_rename2.vfs_rename.do_renameat2
     11.02 ±  6%     -11.0        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
     13.25 ±  5%     -10.7        2.58 ± 28%  perf-profile.calltrace.cycles-pp.vfs_rmdir.do_rmdir.__x64_sys_rmdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.83 ±  7%      -9.0        3.86 ± 16%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      8.86 ±  5%      -7.2        1.62 ± 28%  perf-profile.calltrace.cycles-pp.evict.vfs_rmdir.do_rmdir.__x64_sys_rmdir.do_syscall_64
      8.80 ±  5%      -7.2        1.60 ± 28%  perf-profile.calltrace.cycles-pp.btrfs_evict_inode.evict.vfs_rmdir.do_rmdir.__x64_sys_rmdir
      9.06 ±  5%      -6.3        2.76 ± 16%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      8.71 ±  5%      -6.3        2.45 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      6.19 ±  6%      -6.0        0.22 ±129%  perf-profile.calltrace.cycles-pp.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_dir_item
      6.19 ±  6%      -6.0        0.22 ±129%  perf-profile.calltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_inode
      6.54 ± 12%      -5.7        0.86 ± 52%  perf-profile.calltrace.cycles-pp.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_rename.btrfs_rename2.vfs_rename
      6.02 ± 12%      -5.4        0.65 ± 66%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_rename.btrfs_rename2
      5.70 ± 11%      -5.2        0.50 ± 81%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_rename.btrfs_rename2
      5.74 ± 11%      -5.2        0.58 ± 64%  perf-profile.calltrace.cycles-pp.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_rename.btrfs_rename2.vfs_rename
      5.31 ±  6%      -4.5        0.84 ± 44%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
      5.28 ±  6%      -4.5        0.82 ± 44%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
     14.04 ±  5%      -4.3        9.70 ± 25%  perf-profile.calltrace.cycles-pp.rmdir
     13.98 ±  5%      -4.3        9.68 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.rmdir
     13.97 ±  5%      -4.3        9.68 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.rmdir
     13.95 ±  5%      -4.3        9.68 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_rmdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.rmdir
     13.92 ±  5%      -4.3        9.66 ± 25%  perf-profile.calltrace.cycles-pp.do_rmdir.__x64_sys_rmdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.rmdir
      4.46 ± 12%      -4.1        0.34 ±102%  perf-profile.calltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_rename
      7.05 ±  5%      -4.1        2.96 ± 16%  perf-profile.calltrace.cycles-pp.__close
      4.42 ± 12%      -4.1        0.34 ±102%  perf-profile.calltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_del_inode_ref.__btrfs_unlink_inode
      4.41 ± 12%      -4.1        0.34 ±102%  perf-profile.calltrace.cycles-pp.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_del_inode_ref
      6.37 ±  5%      -3.8        2.62 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      6.29 ±  5%      -3.7        2.57 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      6.09 ±  5%      -3.6        2.48 ± 16%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      5.15 ±  5%      -3.5        1.61 ± 19%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      5.44 ±  6%      -3.4        2.04 ± 17%  perf-profile.calltrace.cycles-pp.__fxstat64
      4.20 ±  6%      -3.4        0.84 ± 43%  perf-profile.calltrace.cycles-pp.btrfs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_rmdir.do_syscall_64
      4.08 ± 12%      -3.2        0.84 ± 49%  perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_rename.btrfs_rename2.vfs_rename.do_renameat2
      3.88 ± 12%      -3.1        0.78 ± 49%  perf-profile.calltrace.cycles-pp.btrfs_insert_dir_item.btrfs_add_link.btrfs_rename.btrfs_rename2.vfs_rename
      4.80 ±  6%      -3.1        1.70 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__fxstat64
      4.72 ±  6%      -3.1        1.66 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      4.14 ±  5%      -3.1        1.09 ± 22%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      4.53 ±  6%      -3.0        1.57 ± 17%  perf-profile.calltrace.cycles-pp.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      3.96 ±  5%      -3.0        1.01 ± 22%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      3.51 ± 12%      -2.9        0.62 ± 64%  perf-profile.calltrace.cycles-pp.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_rename.btrfs_rename2
      3.50 ± 12%      -2.9        0.62 ± 64%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link.btrfs_rename
      3.57 ±  5%      -2.8        0.74 ± 42%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      4.23 ±  5%      -2.7        1.57 ± 16%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.25 ±  5%      -2.6        0.64 ± 43%  perf-profile.calltrace.cycles-pp.__btrfs_unlink_inode.btrfs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_rmdir
      2.92 ±  5%      -2.6        0.31 ±100%  perf-profile.calltrace.cycles-pp.btrfs_truncate_inode_items.btrfs_evict_inode.evict.vfs_rmdir.do_rmdir
      3.65 ±  6%      -2.5        1.11 ± 19%  perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      2.99 ±  5%      -2.4        0.56 ± 40%  perf-profile.calltrace.cycles-pp.btrfs_commit_inode_delayed_inode.btrfs_evict_inode.evict.vfs_rmdir.do_rmdir
      2.86 ±  5%      -2.3        0.53 ± 40%  perf-profile.calltrace.cycles-pp.__btrfs_update_delayed_inode.btrfs_commit_inode_delayed_inode.btrfs_evict_inode.evict.vfs_rmdir
      2.51 ±  6%      -2.2        0.28 ±100%  perf-profile.calltrace.cycles-pp.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_rmdir.vfs_rmdir.do_rmdir
      2.50 ±  6%      -2.2        0.28 ±100%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_rmdir.vfs_rmdir
      2.16 ±  8%      -1.8        0.36 ± 78%  perf-profile.calltrace.cycles-pp.ima_file_check.do_open.path_openat.do_filp_open.do_sys_openat2
      2.21 ±  6%      -1.7        0.52 ± 60%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.18 ±  6%      -1.7        0.51 ± 60%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
      1.94 ±  5%      -1.6        0.29 ±100%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      1.84 ± 14%      -1.5        0.38 ±101%  perf-profile.calltrace.cycles-pp.btrfs_insert_inode_ref.btrfs_rename.btrfs_rename2.vfs_rename.do_renameat2
      1.80 ± 11%      -1.4        0.44 ± 78%  perf-profile.calltrace.cycles-pp.mkdir
      1.79 ± 11%      -1.4        0.43 ± 78%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mkdir
      1.79 ± 11%      -1.4        0.43 ± 78%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      1.79 ± 11%      -1.4        0.43 ± 78%  perf-profile.calltrace.cycles-pp.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      1.78 ± 11%      -1.4        0.43 ± 78%  perf-profile.calltrace.cycles-pp.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdir
      1.79 ± 10%      -1.3        0.44 ± 77%  perf-profile.calltrace.cycles-pp.mkdirat
      1.78 ± 10%      -1.3        0.44 ± 77%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mkdirat
      1.78 ± 10%      -1.3        0.44 ± 77%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdirat
      1.77 ± 10%      -1.3        0.44 ± 77%  perf-profile.calltrace.cycles-pp.do_mkdirat.__x64_sys_mkdirat.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdirat
      1.78 ± 10%      -1.3        0.44 ± 77%  perf-profile.calltrace.cycles-pp.__x64_sys_mkdirat.do_syscall_64.entry_SYSCALL_64_after_hwframe.mkdirat
      1.73 ± 11%      -1.3        0.42 ± 78%  perf-profile.calltrace.cycles-pp.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.72 ± 10%      -1.3        0.42 ± 77%  perf-profile.calltrace.cycles-pp.vfs_mkdir.do_mkdirat.__x64_sys_mkdirat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68 ± 10%      -1.3        0.40 ± 78%  perf-profile.calltrace.cycles-pp.btrfs_create_common.vfs_mkdir.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      1.67 ± 10%      -1.3        0.40 ± 77%  perf-profile.calltrace.cycles-pp.btrfs_create_common.vfs_mkdir.do_mkdirat.__x64_sys_mkdirat.do_syscall_64
      1.56 ± 11%      -1.2        0.36 ± 78%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.vfs_mkdir.do_mkdirat.__x64_sys_mkdir
      1.55 ± 10%      -1.2        0.38 ± 77%  perf-profile.calltrace.cycles-pp.btrfs_create_new_inode.btrfs_create_common.vfs_mkdir.do_mkdirat.__x64_sys_mkdirat
      2.41 ±  6%      -1.2        1.24 ± 11%  perf-profile.calltrace.cycles-pp.btrfs_opendir.do_dentry_open.do_open.path_openat.do_filp_open
      1.86 ±  6%      -0.9        0.92 ± 17%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.84 ±  5%      -0.9        0.96 ± 12%  perf-profile.calltrace.cycles-pp.kmalloc_trace.btrfs_opendir.do_dentry_open.do_open.path_openat
      1.72 ±  6%      -0.8        0.90 ± 12%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.kmalloc_trace.btrfs_opendir.do_dentry_open.do_open
      1.21 ±  7%      -0.8        0.44 ± 59%  perf-profile.calltrace.cycles-pp.btrfs_getattr.vfs_fstat.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.53 ±  4%      -0.8        0.77 ± 13%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.35 ±  4%      -0.7        0.62 ± 38%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.99 ±  9%      -0.7        0.26 ±100%  perf-profile.calltrace.cycles-pp.btrfs_get_next_valid_item.btrfs_real_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      1.36 ±  4%      -0.7        0.69 ± 12%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      1.31 ±  4%      -0.6        0.69 ± 15%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.24 ±  6%      -0.6        0.64 ± 12%  perf-profile.calltrace.cycles-pp.memset_orig.__kmem_cache_alloc_node.kmalloc_trace.btrfs_opendir.do_dentry_open
      4.06            +0.3        4.37 ±  5%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +0.6        0.56 ±  6%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.51 ± 38%      +0.7        1.23 ±  9%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.64 ±  6%      +0.8        1.39 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.64 ±  6%      +0.8        1.40 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.70 ±  6%      +0.9        1.56 ±  9%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.9        0.92 ±  9%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +0.9        0.94 ±  9%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +1.0        0.98 ± 28%  perf-profile.calltrace.cycles-pp.btrfs_readdir_get_delayed_items.btrfs_real_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.83 ±  5%      +1.0        1.88 ±  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.96 ±  6%      +1.2        2.18 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.99 ±  6%      +1.3        2.26 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      1.40 ±  5%      +1.7        3.13 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.20 ±129%      +4.2        4.44 ± 35%  perf-profile.calltrace.cycles-pp.down_write.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.14 ±173%      +4.3        4.44 ± 35%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_renameat2.__x64_sys_rename.do_syscall_64
      0.07 ±264%      +4.4        4.43 ± 35%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_renameat2.__x64_sys_rename
      0.00            +4.4        4.42 ± 35%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_renameat2
      3.94 ±  4%      +5.3        9.19 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00            +6.9        6.94 ± 26%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_rmdir
      0.00            +7.0        6.95 ± 26%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_rmdir.__x64_sys_rmdir
      0.00            +7.0        6.96 ± 26%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_rmdir.__x64_sys_rmdir.do_syscall_64
      0.00            +7.0        6.96 ± 26%  perf-profile.calltrace.cycles-pp.down_write.do_rmdir.__x64_sys_rmdir.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.43 ±  9%     +49.2       54.59 ±  5%  perf-profile.calltrace.cycles-pp.getdents64
      5.36 ±  9%     +49.2       54.57 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      5.36 ±  9%     +49.2       54.56 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      5.34 ±  9%     +49.2       54.55 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      5.29 ±  9%     +49.2       54.54 ±  5%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      4.96 ±  9%     +49.5       54.44 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_real_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +51.0       50.96 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_should_delete_dir_index.btrfs_real_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
     31.66 ±  5%     -26.7        5.01 ± 15%  perf-profile.children.cycles-pp.btrfs_search_slot
     20.06 ±  5%     -17.6        2.46 ± 13%  perf-profile.children.cycles-pp.__btrfs_tree_lock
     21.35 ± 12%     -17.4        3.94 ± 35%  perf-profile.children.cycles-pp.vfs_rename
     19.68 ±  6%     -17.3        2.36 ± 14%  perf-profile.children.cycles-pp.btrfs_lock_root_node
     21.12 ± 12%     -17.3        3.86 ± 35%  perf-profile.children.cycles-pp.btrfs_rename2
     21.08 ± 12%     -17.2        3.85 ± 36%  perf-profile.children.cycles-pp.btrfs_rename
     25.46 ±  5%     -16.3        9.14 ± 16%  perf-profile.children.cycles-pp.__x64_sys_openat
     25.41 ±  5%     -16.3        9.11 ± 16%  perf-profile.children.cycles-pp.do_sys_openat2
     25.73 ±  5%     -16.2        9.57 ± 15%  perf-profile.children.cycles-pp.open64
     22.99 ±  5%     -15.2        7.83 ± 16%  perf-profile.children.cycles-pp.do_filp_open
     22.76 ±  5%     -15.0        7.72 ± 16%  perf-profile.children.cycles-pp.path_openat
     23.25 ± 12%     -14.5        8.79 ± 34%  perf-profile.children.cycles-pp.rename
     17.13 ±  9%     -14.4        2.74 ± 22%  perf-profile.children.cycles-pp.__btrfs_unlink_inode
     23.12 ± 12%     -14.4        8.76 ± 34%  perf-profile.children.cycles-pp.__x64_sys_rename
     23.07 ± 12%     -14.3        8.73 ± 34%  perf-profile.children.cycles-pp.do_renameat2
     12.10 ±  6%     -11.1        0.96 ± 17%  perf-profile.children.cycles-pp.osq_lock
     13.25 ±  5%     -10.7        2.58 ± 28%  perf-profile.children.cycles-pp.vfs_rmdir
     13.07 ±  6%      -9.1        3.97 ± 16%  perf-profile.children.cycles-pp.do_open
      8.93 ±  7%      -7.7        1.25 ± 16%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
      9.09 ±  5%      -7.4        1.70 ± 28%  perf-profile.children.cycles-pp.evict
      9.02 ±  5%      -7.3        1.68 ± 28%  perf-profile.children.cycles-pp.btrfs_evict_inode
     21.35 ±  5%      -7.3       14.07 ±  5%  perf-profile.children.cycles-pp.down_write
     20.67 ±  5%      -6.8       13.87 ±  6%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      9.49 ±  6%      -6.6        2.87 ± 16%  perf-profile.children.cycles-pp.do_dentry_open
     20.16 ±  5%      -6.4       13.73 ±  6%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      7.50 ±  6%      -5.9        1.65 ± 27%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      6.54 ± 12%      -5.6        0.92 ± 38%  perf-profile.children.cycles-pp.btrfs_del_inode_ref
      5.51 ±  7%      -4.6        0.92 ± 27%  perf-profile.children.cycles-pp.security_file_open
      5.47 ±  7%      -4.6        0.90 ± 28%  perf-profile.children.cycles-pp.apparmor_file_open
      5.92 ±  8%      -4.4        1.50 ± 29%  perf-profile.children.cycles-pp.btrfs_add_link
     14.04 ±  5%      -4.3        9.71 ± 25%  perf-profile.children.cycles-pp.rmdir
     13.95 ±  5%      -4.3        9.68 ± 25%  perf-profile.children.cycles-pp.__x64_sys_rmdir
     13.92 ±  5%      -4.3        9.66 ± 25%  perf-profile.children.cycles-pp.do_rmdir
      7.29 ±  5%      -4.2        3.09 ± 16%  perf-profile.children.cycles-pp.__close
      5.61 ±  8%      -4.2        1.41 ± 29%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
      5.49 ±  4%      -3.9        1.55 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      6.30 ±  5%      -3.8        2.52 ± 17%  perf-profile.children.cycles-pp.__x64_sys_close
      4.96 ±  8%      -3.7        1.22 ± 29%  perf-profile.children.cycles-pp.insert_with_overflow
      4.44 ±  7%      -3.7        0.74 ± 19%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      5.34 ±  5%      -3.7        1.64 ± 19%  perf-profile.children.cycles-pp.alloc_empty_file
      5.62 ±  5%      -3.5        2.13 ± 17%  perf-profile.children.cycles-pp.__fxstat64
      4.21 ±  6%      -3.3        0.89 ± 29%  perf-profile.children.cycles-pp.btrfs_rmdir
      4.30 ±  6%      -3.2        1.12 ± 22%  perf-profile.children.cycles-pp.init_file
      4.11 ±  6%      -3.1        1.03 ± 22%  perf-profile.children.cycles-pp.security_file_alloc
      4.55 ±  6%      -3.0        1.58 ± 17%  perf-profile.children.cycles-pp.__do_sys_newfstat
      3.71 ±  5%      -2.9        0.82 ± 23%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      3.49 ±  6%      -2.9        0.60 ± 20%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      3.45 ±  6%      -2.9        0.59 ± 21%  perf-profile.children.cycles-pp.down_read
      3.51 ±  6%      -2.8        0.68 ± 18%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      4.45 ±  6%      -2.8        1.63 ± 17%  perf-profile.children.cycles-pp.__fput
      3.56 ± 10%      -2.6        0.98 ± 55%  perf-profile.children.cycles-pp.do_mkdirat
      3.67 ±  6%      -2.6        1.12 ± 19%  perf-profile.children.cycles-pp.vfs_fstat
      3.45 ± 10%      -2.5        0.94 ± 55%  perf-profile.children.cycles-pp.vfs_mkdir
      2.99 ±  5%      -2.5        0.51 ± 21%  perf-profile.children.cycles-pp.btrfs_lookup_inode
      2.99 ±  5%      -2.5        0.51 ± 29%  perf-profile.children.cycles-pp.btrfs_truncate_inode_items
      3.36 ± 10%      -2.5        0.91 ± 56%  perf-profile.children.cycles-pp.btrfs_create_common
      3.07 ±  5%      -2.4        0.62 ± 25%  perf-profile.children.cycles-pp.btrfs_commit_inode_delayed_inode
      2.79 ±  9%      -2.3        0.47 ± 21%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      3.11 ± 10%      -2.3        0.83 ± 56%  perf-profile.children.cycles-pp.btrfs_create_new_inode
      2.62 ±  5%      -2.2        0.42 ± 32%  perf-profile.children.cycles-pp.btrfs_del_orphan_item
      2.52 ±  8%      -2.0        0.53 ± 16%  perf-profile.children.cycles-pp.btrfs_release_path
      2.41 ±  6%      -1.9        0.52 ± 17%  perf-profile.children.cycles-pp.up_write
      2.07 ± 21%      -1.8        0.26 ± 21%  perf-profile.children.cycles-pp.worker_thread
      2.06 ± 21%      -1.8        0.25 ± 22%  perf-profile.children.cycles-pp.process_one_work
      2.10 ± 20%      -1.8        0.31 ± 19%  perf-profile.children.cycles-pp.ret_from_fork_asm
      2.10 ± 20%      -1.8        0.31 ± 19%  perf-profile.children.cycles-pp.ret_from_fork
      2.10 ± 20%      -1.8        0.31 ± 18%  perf-profile.children.cycles-pp.kthread
      2.25 ±  8%      -1.7        0.52 ± 21%  perf-profile.children.cycles-pp.ima_file_check
      2.32 ±  6%      -1.7        0.65 ± 23%  perf-profile.children.cycles-pp.security_file_free
      2.29 ±  6%      -1.6        0.64 ± 23%  perf-profile.children.cycles-pp.apparmor_file_free_security
      2.00 ±  8%      -1.6        0.36 ± 21%  perf-profile.children.cycles-pp.security_inode_getattr
      1.90 ±  8%      -1.6        0.30 ± 23%  perf-profile.children.cycles-pp.common_perm_cond
      1.90 ±  9%      -1.6        0.34 ± 26%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      2.51 ±  2%      -1.5        0.96 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock
      1.87 ±  9%      -1.5        0.32 ± 28%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      2.02 ±  4%      -1.5        0.56 ± 11%  perf-profile.children.cycles-pp.sysvec_call_function_single
      2.39 ±  7%      -1.4        0.99 ± 24%  perf-profile.children.cycles-pp.__write_extent_buffer
      1.74 ±  7%      -1.4        0.37 ± 15%  perf-profile.children.cycles-pp.rwsem_wake
      1.80 ± 11%      -1.3        0.50 ± 55%  perf-profile.children.cycles-pp.mkdir
      1.79 ± 11%      -1.3        0.49 ± 54%  perf-profile.children.cycles-pp.__x64_sys_mkdir
      2.61 ±  6%      -1.3        1.31 ± 12%  perf-profile.children.cycles-pp.btrfs_opendir
      1.79 ± 10%      -1.3        0.49 ± 58%  perf-profile.children.cycles-pp.mkdirat
      1.84 ± 14%      -1.3        0.55 ± 40%  perf-profile.children.cycles-pp.btrfs_insert_inode_ref
      1.78 ± 10%      -1.3        0.49 ± 58%  perf-profile.children.cycles-pp.__x64_sys_mkdirat
      2.03 ±  8%      -1.2        0.85 ± 25%  perf-profile.children.cycles-pp.__memmove
      1.62 ±  4%      -1.2        0.45 ± 12%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      1.55 ±  4%      -1.1        0.44 ± 12%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      2.14 ±  6%      -1.1        1.04 ± 17%  perf-profile.children.cycles-pp.link_path_walk
      1.64 ±  5%      -1.0        0.59 ± 19%  perf-profile.children.cycles-pp.read_block_for_search
      1.76 ±  2%      -1.0        0.72 ± 12%  perf-profile.children.cycles-pp.read_extent_buffer
      1.21 ± 13%      -1.0        0.18 ± 24%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.77 ±  8%      -1.0        0.75 ± 27%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      1.55 ±  7%      -1.0        0.55 ± 12%  perf-profile.children.cycles-pp.btrfs_del_items
      1.18 ± 19%      -1.0        0.19 ± 24%  perf-profile.children.cycles-pp.btrfs_root_node
      1.94 ±  6%      -0.9        1.00 ± 12%  perf-profile.children.cycles-pp.kmalloc_trace
      1.18 ± 11%      -0.9        0.24 ± 21%  perf-profile.children.cycles-pp.free_extent_buffer
      1.88 ±  6%      -0.9        0.97 ± 12%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      1.76 ±  4%      -0.9        0.88 ± 17%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.26 ±  3%      -0.9        0.39 ± 17%  perf-profile.children.cycles-pp.__schedule
      1.18 ±  4%      -0.8        0.34 ± 13%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.69 ±  5%      -0.8        0.86 ± 13%  perf-profile.children.cycles-pp.lookup_fast
      1.02 ±  3%      -0.8        0.20 ± 21%  perf-profile.children.cycles-pp.up_read
      1.62 ±  5%      -0.8        0.82 ± 13%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.55 ±  4%      -0.8        0.79 ± 12%  perf-profile.children.cycles-pp.open_last_lookups
      1.28 ±  7%      -0.8        0.52 ± 28%  perf-profile.children.cycles-pp.setup_items_for_insert
      1.50 ±  6%      -0.7        0.76 ± 12%  perf-profile.children.cycles-pp.memset_orig
      1.51 ±  5%      -0.7        0.78 ± 16%  perf-profile.children.cycles-pp.getname_flags
      0.96 ± 13%      -0.7        0.24 ± 38%  perf-profile.children.cycles-pp.lookup_one_qstr_excl
      1.23 ±  7%      -0.7        0.55 ± 19%  perf-profile.children.cycles-pp.btrfs_getattr
      0.84 ± 21%      -0.7        0.17 ± 41%  perf-profile.children.cycles-pp.__open64_nocancel
      0.80 ±  9%      -0.7        0.13 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.92 ±  5%      -0.7        0.25 ± 21%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.92 ±  5%      -0.6        0.27 ± 20%  perf-profile.children.cycles-pp.schedule
      0.98 ±  8%      -0.6        0.36 ± 17%  perf-profile.children.cycles-pp.find_extent_buffer
      0.79 ± 14%      -0.6        0.17 ± 40%  perf-profile.children.cycles-pp.btrfs_lookup
      0.79 ± 14%      -0.6        0.17 ± 40%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
      1.12 ± 12%      -0.6        0.50 ± 15%  perf-profile.children.cycles-pp.inode_permission
      0.76 ±  8%      -0.6        0.14 ± 24%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.86 ±  9%      -0.6        0.26 ± 20%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.73 ±  9%      -0.6        0.15 ± 22%  perf-profile.children.cycles-pp.unlock_up
      0.70 ±  9%      -0.6        0.13 ± 25%  perf-profile.children.cycles-pp.btrfs_delete_delayed_dir_index
      0.68 ±  8%      -0.6        0.12 ± 43%  perf-profile.children.cycles-pp.btrfs_orphan_add
      0.68 ±  9%      -0.6        0.12 ± 43%  perf-profile.children.cycles-pp.btrfs_insert_orphan_item
      0.79 ±  3%      -0.6        0.23 ± 15%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.69 ± 11%      -0.5        0.14 ± 39%  perf-profile.children.cycles-pp.btrfs_check_dir_item_collision
      0.92 ±  8%      -0.5        0.38 ± 12%  perf-profile.children.cycles-pp.dput
      0.74 ±  6%      -0.5        0.20 ± 17%  perf-profile.children.cycles-pp.wake_up_q
      0.79 ±  8%      -0.5        0.27 ± 18%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      1.00 ±  9%      -0.5        0.48 ± 15%  perf-profile.children.cycles-pp.btrfs_get_next_valid_item
      0.87 ± 13%      -0.5        0.35 ± 40%  perf-profile.children.cycles-pp.btrfs_extend_item
      1.03 ±  5%      -0.5        0.52 ± 18%  perf-profile.children.cycles-pp.kmem_cache_free
      0.74 ± 12%      -0.5        0.23 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.71 ±  6%      -0.5        0.21 ± 19%  perf-profile.children.cycles-pp.try_to_wake_up
      0.72 ± 10%      -0.5        0.22 ± 17%  perf-profile.children.cycles-pp.btrfs_bin_search
      0.89 ±  5%      -0.5        0.40 ± 17%  perf-profile.children.cycles-pp.filp_flush
      1.01 ±  5%      -0.5        0.53 ± 17%  perf-profile.children.cycles-pp.strncpy_from_user
      0.61 ± 14%      -0.5        0.13 ± 25%  perf-profile.children.cycles-pp.btrfs_free_path
      0.76 ±  8%      -0.5        0.30 ± 17%  perf-profile.children.cycles-pp.complete_walk
      0.94 ±  6%      -0.5        0.49 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.62 ±  8%      -0.5        0.17 ± 23%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.70 ±  4%      -0.4        0.25 ± 15%  perf-profile.children.cycles-pp.btrfs_filldir
      0.71 ±  8%      -0.4        0.28 ± 18%  perf-profile.children.cycles-pp.try_to_unlazy
      0.81 ±  9%      -0.4        0.39 ± 12%  perf-profile.children.cycles-pp.btrfs_release_file
      0.84 ±  5%      -0.4        0.44 ± 13%  perf-profile.children.cycles-pp.strlcat
      0.63 ±  9%      -0.4        0.23 ± 19%  perf-profile.children.cycles-pp.__legitimize_path
      0.52 ±  8%      -0.4        0.15 ± 21%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.55 ±  5%      -0.4        0.18 ± 30%  perf-profile.children.cycles-pp.start_transaction
      0.56 ±  8%      -0.4        0.20 ± 19%  perf-profile.children.cycles-pp.btrfs_get_token_32
      0.51 ±  4%      -0.3        0.16 ± 16%  perf-profile.children.cycles-pp.activate_task
      0.68 ±  6%      -0.3        0.34 ± 14%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.50 ±  5%      -0.3        0.16 ± 16%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.57 ±  6%      -0.3        0.23 ± 23%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.71 ±  9%      -0.3        0.38 ± 16%  perf-profile.children.cycles-pp.cp_new_stat
      0.52 ±  6%      -0.3        0.19 ± 19%  perf-profile.children.cycles-pp.memmove_extent_buffer
      0.56 ±  6%      -0.3        0.24 ± 18%  perf-profile.children.cycles-pp.dnotify_flush
      0.46 ±  5%      -0.3        0.14 ± 16%  perf-profile.children.cycles-pp.enqueue_entity
      0.60 ±  9%      -0.3        0.28 ± 10%  perf-profile.children.cycles-pp.btrfs_get_dir_last_index
      0.42 ±  7%      -0.3        0.11 ± 45%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
      0.66 ±  4%      -0.3        0.36 ± 17%  perf-profile.children.cycles-pp.filldir64
      0.56 ± 13%      -0.3        0.27 ± 16%  perf-profile.children.cycles-pp.may_open
      0.58 ±  6%      -0.3        0.28 ± 14%  perf-profile.children.cycles-pp.__cond_resched
      0.51 ±  6%      -0.3        0.22 ± 17%  perf-profile.children.cycles-pp.fsnotify_find_mark
      0.39 ±  8%      -0.3        0.11 ± 21%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.43 ± 11%      -0.3        0.14 ± 24%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.37 ±  8%      -0.3        0.09 ± 25%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.48 ±  6%      -0.3        0.20 ± 18%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.43 ±  7%      -0.3        0.16 ± 33%  perf-profile.children.cycles-pp.__statfs
      0.36 ±  7%      -0.3        0.08 ± 26%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      0.44 ±  8%      -0.3        0.18 ± 12%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.36 ±  9%      -0.3        0.10 ± 21%  perf-profile.children.cycles-pp.dequeue_entity
      0.35 ± 11%      -0.3        0.10 ± 36%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.52 ±  4%      -0.3        0.26 ± 17%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.39 ±  5%      -0.3        0.13 ± 11%  perf-profile.children.cycles-pp.schedule_idle
      0.43 ±  4%      -0.3        0.18 ± 13%  perf-profile.children.cycles-pp.path_init
      0.46 ±  7%      -0.3        0.20 ± 19%  perf-profile.children.cycles-pp.generic_permission
      0.39 ±  8%      -0.2        0.14 ± 30%  perf-profile.children.cycles-pp.__do_sys_statfs
      0.38 ±  7%      -0.2        0.14 ± 30%  perf-profile.children.cycles-pp.user_statfs
      0.52 ±  6%      -0.2        0.28 ± 16%  perf-profile.children.cycles-pp.__check_object_size
      0.35 ± 15%      -0.2        0.13 ± 38%  perf-profile.children.cycles-pp.btrfs_truncate_item
      0.30 ±  8%      -0.2        0.09 ± 28%  perf-profile.children.cycles-pp.mutex_unlock
      0.31 ±  6%      -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.update_load_avg
      0.29 ±  5%      -0.2        0.08 ± 26%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.28 ±  4%      -0.2        0.07 ± 15%  perf-profile.children.cycles-pp.wakeup_preempt
      0.36 ±  8%      -0.2        0.16 ± 15%  perf-profile.children.cycles-pp.terminate_walk
      0.42 ±  7%      -0.2        0.22 ± 12%  perf-profile.children.cycles-pp.alloc_fd
      0.37 ± 12%      -0.2        0.17 ± 20%  perf-profile.children.cycles-pp._copy_to_user
      0.26 ±  4%      -0.2        0.07 ± 16%  perf-profile.children.cycles-pp.resched_curr
      0.38 ±  4%      -0.2        0.18 ± 16%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.31 ± 19%      -0.2        0.12 ± 32%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.26 ± 10%      -0.2        0.07 ± 41%  perf-profile.children.cycles-pp.btrfs_update_root_times
      0.39 ±  8%      -0.2        0.21 ± 16%  perf-profile.children.cycles-pp.walk_component
      0.26 ± 27%      -0.2        0.08 ± 68%  perf-profile.children.cycles-pp.__btrfs_add_free_space
      0.31 ± 11%      -0.2        0.14 ± 22%  perf-profile.children.cycles-pp.__filename_parentat
      0.23 ± 21%      -0.2        0.06 ± 42%  perf-profile.children.cycles-pp.btrfs_get_64
      0.29 ±  6%      -0.2        0.12 ± 18%  perf-profile.children.cycles-pp.__srcu_read_lock
      0.29 ± 12%      -0.2        0.12 ± 22%  perf-profile.children.cycles-pp.path_parentat
      0.24 ± 28%      -0.2        0.08 ± 71%  perf-profile.children.cycles-pp.steal_from_bitmap
      0.20 ± 10%      -0.2        0.04 ± 80%  perf-profile.children.cycles-pp.btrfs_trans_release_metadata
      0.30 ±  7%      -0.2        0.14 ± 17%  perf-profile.children.cycles-pp.locks_remove_posix
      0.32 ±  4%      -0.2        0.16 ± 18%  perf-profile.children.cycles-pp.mod_objcg_state
      0.26 ± 33%      -0.2        0.11 ± 16%  perf-profile.children.cycles-pp.btrfs_permission
      0.23 ± 15%      -0.2        0.08 ± 44%  perf-profile.children.cycles-pp.dentry_kill
      0.23 ± 16%      -0.1        0.08 ± 45%  perf-profile.children.cycles-pp.__dentry_kill
      0.32 ± 10%      -0.1        0.18 ± 29%  perf-profile.children.cycles-pp.btrfs_next_old_leaf
      0.18 ±  6%      -0.1        0.04 ± 78%  perf-profile.children.cycles-pp.mutex_lock
      0.31 ±  7%      -0.1        0.16 ± 13%  perf-profile.children.cycles-pp.process_measurement
      0.28 ±  6%      -0.1        0.13 ± 13%  perf-profile.children.cycles-pp.stress_dir_read
      0.21 ±  7%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.select_task_rq
      0.29 ±  6%      -0.1        0.15 ± 17%  perf-profile.children.cycles-pp.strlcpy
      0.17 ±  7%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__switch_to
      0.27 ±  6%      -0.1        0.14 ± 16%  perf-profile.children.cycles-pp.__kmem_cache_free
      0.18 ±  5%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.llist_reverse_order
      0.21 ±  6%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.18 ±  9%      -0.1        0.04 ± 77%  perf-profile.children.cycles-pp.split_leaf
      0.18 ±  9%      -0.1        0.05 ± 62%  perf-profile.children.cycles-pp.statfs_by_dentry
      0.26 ±  5%      -0.1        0.14 ± 21%  perf-profile.children.cycles-pp.check_heap_object
      0.17 ±  7%      -0.1        0.04 ± 37%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.17 ±  8%      -0.1        0.05 ± 62%  perf-profile.children.cycles-pp.btrfs_statfs
      0.17 ±  6%      -0.1        0.05 ± 41%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.25 ±  4%      -0.1        0.13 ± 11%  perf-profile.children.cycles-pp.btrfs_get_32
      0.24 ±  6%      -0.1        0.12 ± 16%  perf-profile.children.cycles-pp.close_fd_get_file
      0.20 ±  6%      -0.1        0.09 ± 16%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.20 ±  6%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.inode_get_bytes
      0.19 ±  7%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.irqentry_enter
      0.18 ±  8%      -0.1        0.08 ± 25%  perf-profile.children.cycles-pp.user_path_at_empty
      0.22 ±  5%      -0.1        0.11 ± 13%  perf-profile.children.cycles-pp.rcu_all_qs
      0.21 ±  8%      -0.1        0.10 ± 20%  perf-profile.children.cycles-pp.errseq_sample
      0.18 ±  9%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.generic_fillattr
      0.20 ±  6%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.20 ± 10%      -0.1        0.10 ± 18%  perf-profile.children.cycles-pp.__reserve_bytes
      0.14 ± 11%      -0.1        0.04 ± 79%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.20 ± 10%      -0.1        0.10 ± 20%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.21 ±  4%      -0.1        0.11 ± 20%  perf-profile.children.cycles-pp.verify_dirent_name
      0.20 ± 12%      -0.1        0.10 ± 22%  perf-profile.children.cycles-pp.__fget_light
      0.19 ±  6%      -0.1        0.10 ± 23%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.18 ±  9%      -0.1        0.08 ± 18%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.20 ±  5%      -0.1        0.11 ± 22%  perf-profile.children.cycles-pp.memchr
      0.18 ±  5%      -0.1        0.09 ± 19%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.12 ± 14%      -0.1        0.03 ±106%  perf-profile.children.cycles-pp.evict_refill_and_join
      0.15 ±  5%      -0.1        0.06 ± 40%  perf-profile.children.cycles-pp.lockref_get
      0.12 ± 11%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.filename_lookup
      0.23 ±  6%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.sched_clock
      0.16 ±  4%      -0.1        0.07 ± 19%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.14 ±  9%      -0.1        0.06 ± 41%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.23 ±  6%      -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.11 ± 11%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.path_lookupat
      0.11 ± 11%      -0.1        0.03 ±104%  perf-profile.children.cycles-pp.refill_obj_stock
      0.16 ±  7%      -0.1        0.09 ± 18%  perf-profile.children.cycles-pp.make_vfsuid
      0.13 ±  8%      -0.1        0.06 ± 40%  perf-profile.children.cycles-pp.__srcu_read_unlock
      0.16 ±  6%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.step_into
      0.14 ± 16%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.readdir64
      0.14 ±  8%      -0.1        0.07 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.14 ± 10%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.__check_heap_object
      0.13 ± 10%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.14 ±  7%      -0.1        0.07 ± 22%  perf-profile.children.cycles-pp.security_inode_permission
      0.14 ±  7%      -0.1        0.07 ± 17%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.13 ±  6%      -0.1        0.07 ± 22%  perf-profile.children.cycles-pp.putname
      0.14 ±  7%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.14 ±  6%      -0.1        0.08 ± 26%  perf-profile.children.cycles-pp.build_open_flags
      0.12 ± 10%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__fput_sync
      0.10 ±  8%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.mntput_no_expire
      0.10 ± 10%      -0.1        0.05 ± 43%  perf-profile.children.cycles-pp.kfree
      0.09 ±  5%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ±  6%      -0.0        0.05 ± 41%  perf-profile.children.cycles-pp.map_id_up
      0.07 ± 12%      -0.0        0.02 ±100%  perf-profile.children.cycles-pp.file_ra_state_init
      0.10 ±  6%      -0.0        0.06 ± 15%  perf-profile.children.cycles-pp.btrfs_get_16
      0.07 ±  4%      -0.0        0.04 ± 78%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.16 ±  6%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.06 ± 10%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.05 ± 38%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.update_blocked_averages
      0.08 ±  8%      +0.0        0.12 ± 16%  perf-profile.children.cycles-pp.find_busiest_group
      0.04 ± 58%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.06 ± 12%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.01 ±173%      +0.1        0.07 ± 37%  perf-profile.children.cycles-pp.irq_work_run_list
      0.12 ±  7%      +0.1        0.18 ± 14%  perf-profile.children.cycles-pp.load_balance
      0.08 ±  6%      +0.1        0.15 ± 21%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.07 ± 19%  perf-profile.children.cycles-pp.rcu_pending
      0.06 ± 13%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.perf_rotate_context
      0.06 ± 12%      +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.clockevents_program_event
      0.02 ±129%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.02 ±131%      +0.1        0.12 ± 37%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.btrfs_submit_bio
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.btrfs_submit_chunk
      0.12 ± 10%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.1        0.10 ± 33%  perf-profile.children.cycles-pp.btree_write_cache_pages
      0.00            +0.1        0.10 ± 33%  perf-profile.children.cycles-pp.submit_eb_page
      0.24 ±  4%      +0.1        0.34 ± 27%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.do_writepages
      0.06 ± 12%      +0.1        0.18 ± 49%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.12 ± 72%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.09 ±  9%      +0.1        0.22 ± 25%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.37 ±  4%      +0.2        0.56 ±  6%  perf-profile.children.cycles-pp.__do_softirq
      0.00            +0.2        0.19 ± 34%  perf-profile.children.cycles-pp.__btrfs_run_delayed_items
      0.43 ±  3%      +0.2        0.62 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.4        0.35 ± 25%  perf-profile.children.cycles-pp.btrfs_readdir_put_delayed_items
      0.00            +0.4        0.36 ± 47%  perf-profile.children.cycles-pp.btrfs_readdir_delayed_dir_index
      0.35 ±  9%      +0.4        0.72 ±  9%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.06 ± 15%      +0.4        0.45 ± 33%  perf-profile.children.cycles-pp.rb_next
      0.51 ±  8%      +0.5        1.03 ±  8%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.51 ±  7%      +0.5        1.04 ±  8%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.72 ±  5%      +0.7        1.39 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
      0.81 ±  4%      +0.8        1.57 ±  8%  perf-profile.children.cycles-pp.update_process_times
      0.82 ±  4%      +0.8        1.58 ±  8%  perf-profile.children.cycles-pp.tick_sched_handle
      0.20 ± 18%      +0.8        1.00 ± 28%  perf-profile.children.cycles-pp.btrfs_readdir_get_delayed_items
      0.89 ±  4%      +0.9        1.75 ±  8%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      1.04 ±  4%      +1.1        2.11 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.19 ±  5%      +1.3        2.44 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.22 ±  5%      +1.3        2.52 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.76 ±  4%      +1.7        3.45 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.09 ±  4%      +3.5        6.59 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     83.78            +4.4       88.18        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     83.58            +4.5       88.09        perf-profile.children.cycles-pp.do_syscall_64
      5.61 ±  7%      +6.6       12.16 ±  7%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      5.44 ±  9%     +49.2       54.60 ±  5%  perf-profile.children.cycles-pp.getdents64
      5.34 ±  9%     +49.2       54.55 ±  5%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      5.30 ±  9%     +49.2       54.54 ±  5%  perf-profile.children.cycles-pp.iterate_dir
      5.03 ±  8%     +49.4       54.46 ±  5%  perf-profile.children.cycles-pp.btrfs_real_readdir
      0.36 ± 11%     +50.6       50.99 ±  6%  perf-profile.children.cycles-pp.btrfs_should_delete_dir_index
     12.04 ±  6%     -11.1        0.95 ± 16%  perf-profile.self.cycles-pp.osq_lock
      5.45 ±  7%      -4.6        0.90 ± 28%  perf-profile.self.cycles-pp.apparmor_file_open
      3.66 ±  5%      -2.9        0.80 ± 23%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      2.53 ±  8%      -1.8        0.70 ± 12%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      2.28 ±  6%      -1.6        0.63 ± 23%  perf-profile.self.cycles-pp.apparmor_file_free_security
      1.87 ±  8%      -1.6        0.28 ± 24%  perf-profile.self.cycles-pp.common_perm_cond
      1.86 ±  9%      -1.5        0.32 ± 28%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      2.22 ±  2%      -1.3        0.88 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock
      2.01 ±  8%      -1.2        0.82 ± 23%  perf-profile.self.cycles-pp.__memmove
      1.21 ± 13%      -1.0        0.18 ± 25%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.73 ±  2%      -1.0        0.71 ± 12%  perf-profile.self.cycles-pp.read_extent_buffer
      1.17 ± 20%      -1.0        0.19 ± 24%  perf-profile.self.cycles-pp.btrfs_root_node
      1.18 ± 14%      -0.9        0.28 ± 15%  perf-profile.self.cycles-pp.btrfs_search_slot
      1.09 ± 11%      -0.9        0.21 ± 22%  perf-profile.self.cycles-pp.free_extent_buffer
      1.60 ±  5%      -0.8        0.81 ± 13%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.93 ±  3%      -0.8        0.15 ± 21%  perf-profile.self.cycles-pp.up_read
      0.92 ± 10%      -0.8        0.15 ± 20%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      1.48 ±  6%      -0.7        0.75 ± 12%  perf-profile.self.cycles-pp.memset_orig
      5.13 ±  3%      -0.7        4.47 ±  5%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.68 ±  8%      -0.6        0.12 ± 24%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.74 ±  8%      -0.6        0.19 ± 19%  perf-profile.self.cycles-pp.up_write
      0.67 ± 19%      -0.5        0.12 ± 32%  perf-profile.self.cycles-pp.down_read
      0.71 ± 10%      -0.5        0.22 ± 16%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.88 ±  6%      -0.5        0.40 ± 12%  perf-profile.self.cycles-pp.do_dentry_open
      0.60 ± 13%      -0.4        0.17 ± 12%  perf-profile.self.cycles-pp.down_write
      0.60 ± 10%      -0.4        0.18 ± 18%  perf-profile.self.cycles-pp.find_extent_buffer_nolock
      0.82 ±  4%      -0.4        0.40 ± 15%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.76 ±  6%      -0.4        0.36 ± 18%  perf-profile.self.cycles-pp.link_path_walk
      0.82 ±  5%      -0.4        0.43 ± 13%  perf-profile.self.cycles-pp.strlcat
      0.71 ±  6%      -0.4        0.32 ± 22%  perf-profile.self.cycles-pp.btrfs_getattr
      0.68 ±  5%      -0.3        0.35 ± 16%  perf-profile.self.cycles-pp.kmem_cache_free
      0.66 ±  5%      -0.3        0.33 ± 15%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.50 ±  8%      -0.3        0.18 ± 20%  perf-profile.self.cycles-pp.btrfs_get_token_32
      0.52 ±  5%      -0.3        0.22 ± 23%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.41 ± 11%      -0.3        0.13 ± 26%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.31 ±  8%      -0.3        0.04 ± 79%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.46 ± 12%      -0.2        0.21 ± 13%  perf-profile.self.cycles-pp.btrfs_release_file
      0.50 ±  5%      -0.2        0.25 ± 17%  perf-profile.self.cycles-pp.strncpy_from_user
      0.42 ±  4%      -0.2        0.17 ± 13%  perf-profile.self.cycles-pp.path_init
      0.41 ±  7%      -0.2        0.18 ± 20%  perf-profile.self.cycles-pp.__fput
      0.42 ± 10%      -0.2        0.20 ± 13%  perf-profile.self.cycles-pp.inode_permission
      0.37 ±  8%      -0.2        0.16 ± 23%  perf-profile.self.cycles-pp.generic_permission
      0.42 ±  4%      -0.2        0.21 ± 12%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.30 ±  8%      -0.2        0.09 ± 28%  perf-profile.self.cycles-pp.mutex_unlock
      0.44 ±  5%      -0.2        0.24 ± 18%  perf-profile.self.cycles-pp.filldir64
      0.36 ± 11%      -0.2        0.17 ± 18%  perf-profile.self.cycles-pp._copy_to_user
      0.26 ±  4%      -0.2        0.07 ± 16%  perf-profile.self.cycles-pp.resched_curr
      0.31 ± 13%      -0.2        0.11 ± 14%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.32 ±  7%      -0.2        0.12 ± 23%  perf-profile.self.cycles-pp.__write_extent_buffer
      0.27 ±  6%      -0.2        0.08 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.38 ±  4%      -0.2        0.19 ± 16%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.35 ±  8%      -0.2        0.17 ± 19%  perf-profile.self.cycles-pp.__cond_resched
      0.32 ±  5%      -0.2        0.14 ± 10%  perf-profile.self.cycles-pp.btrfs_real_readdir
      0.23 ± 22%      -0.2        0.06 ± 41%  perf-profile.self.cycles-pp.btrfs_get_64
      0.27 ± 20%      -0.2        0.10 ± 35%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.28 ±  6%      -0.2        0.11 ± 18%  perf-profile.self.cycles-pp.__srcu_read_lock
      0.21 ±  5%      -0.2        0.05 ± 60%  perf-profile.self.cycles-pp.__schedule
      0.29 ±  6%      -0.2        0.13 ± 17%  perf-profile.self.cycles-pp.locks_remove_posix
      0.36 ±  7%      -0.2        0.20 ± 13%  perf-profile.self.cycles-pp.open64
      0.30 ±  4%      -0.2        0.15 ± 18%  perf-profile.self.cycles-pp.mod_objcg_state
      0.19 ±  7%      -0.1        0.05 ± 40%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.23 ± 36%      -0.1        0.09 ± 23%  perf-profile.self.cycles-pp.btrfs_permission
      0.30 ±  6%      -0.1        0.16 ± 14%  perf-profile.self.cycles-pp.process_measurement
      0.29 ±  5%      -0.1        0.15 ± 17%  perf-profile.self.cycles-pp.strlcpy
      0.18 ±  4%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.llist_reverse_order
      0.20 ±  8%      -0.1        0.06 ± 44%  perf-profile.self.cycles-pp.read_block_for_search
      0.28 ±  8%      -0.1        0.15 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.28 ±  8%      -0.1        0.15 ± 15%  perf-profile.self.cycles-pp.__close
      0.26 ±  6%      -0.1        0.13 ± 16%  perf-profile.self.cycles-pp.__kmem_cache_free
      0.16 ±  9%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.__btrfs_release_delayed_node
      0.16 ±  7%      -0.1        0.03 ± 77%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.24 ±  7%      -0.1        0.12 ± 12%  perf-profile.self.cycles-pp.stress_dir_read
      0.16 ±  7%      -0.1        0.03 ± 78%  perf-profile.self.cycles-pp.mutex_lock
      0.24 ±  6%      -0.1        0.12 ± 18%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.22 ±  8%      -0.1        0.11 ± 20%  perf-profile.self.cycles-pp.do_filp_open
      0.15 ±  6%      -0.1        0.04 ± 79%  perf-profile.self.cycles-pp.enqueue_entity
      0.16 ±  8%      -0.1        0.05 ± 38%  perf-profile.self.cycles-pp.irqentry_enter
      0.23 ±  4%      -0.1        0.12 ± 12%  perf-profile.self.cycles-pp.btrfs_get_32
      0.20 ±  5%      -0.1        0.09 ± 16%  perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.21 ± 14%      -0.1        0.11 ± 21%  perf-profile.self.cycles-pp.may_open
      0.26 ±  8%      -0.1        0.15 ± 13%  perf-profile.self.cycles-pp.cp_new_stat
      0.22 ±  7%      -0.1        0.12 ± 21%  perf-profile.self.cycles-pp.do_syscall_64
      0.21 ±  9%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.19 ±  8%      -0.1        0.09 ± 23%  perf-profile.self.cycles-pp.errseq_sample
      0.16 ±  6%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.19 ± 12%      -0.1        0.09 ± 24%  perf-profile.self.cycles-pp.__fget_light
      0.14 ±  8%      -0.1        0.04 ± 81%  perf-profile.self.cycles-pp.generic_fillattr
      0.19 ±  6%      -0.1        0.09 ± 20%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.20 ±  4%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.__fxstat64
      0.17 ±  6%      -0.1        0.08 ± 18%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.18 ± 11%      -0.1        0.10 ± 18%  perf-profile.self.cycles-pp.__do_sys_newfstat
      0.19 ±  5%      -0.1        0.10 ± 21%  perf-profile.self.cycles-pp.memchr
      0.19 ±  9%      -0.1        0.10 ± 18%  perf-profile.self.cycles-pp.alloc_fd
      0.16 ±  9%      -0.1        0.07 ± 19%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.14 ±  5%      -0.1        0.06 ± 40%  perf-profile.self.cycles-pp.lockref_get
      0.17 ±  7%      -0.1        0.08 ± 18%  perf-profile.self.cycles-pp.init_file
      0.11 ± 31%      -0.1        0.03 ± 78%  perf-profile.self.cycles-pp.btrfs_get_next_valid_item
      0.22 ±  6%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.13 ± 17%      -0.1        0.05 ± 41%  perf-profile.self.cycles-pp.readdir64
      0.12 ±  9%      -0.1        0.04 ± 59%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.15 ±  9%      -0.1        0.07 ± 20%  perf-profile.self.cycles-pp.rcu_all_qs
      0.15 ±  7%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.step_into
      0.11 ±  9%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.btrfs_del_items
      0.12 ±  8%      -0.1        0.05 ± 41%  perf-profile.self.cycles-pp.__srcu_read_unlock
      0.13 ± 10%      -0.1        0.06 ± 17%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  9%      -0.1        0.06 ± 45%  perf-profile.self.cycles-pp.do_open
      0.13 ±  7%      -0.1        0.06 ± 43%  perf-profile.self.cycles-pp.putname
      0.09 ±  7%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.mntput_no_expire
      0.11 ± 11%      -0.1        0.05 ± 38%  perf-profile.self.cycles-pp.dput
      0.12 ±  8%      -0.1        0.06 ± 12%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.13 ±  7%      -0.1        0.06 ± 21%  perf-profile.self.cycles-pp.path_openat
      0.12 ±  9%      -0.1        0.05 ± 41%  perf-profile.self.cycles-pp.getname_flags
      0.13 ±  6%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.13 ±  8%      -0.1        0.07 ± 20%  perf-profile.self.cycles-pp.__check_heap_object
      0.10 ± 12%      -0.1        0.04 ± 79%  perf-profile.self.cycles-pp.check_heap_object
      0.09 ±  9%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.kmalloc_trace
      0.13 ±  8%      -0.1        0.07 ± 22%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.09 ±  8%      -0.1        0.04 ± 79%  perf-profile.self.cycles-pp.kfree
      0.09 ±  7%      -0.1        0.04 ± 79%  perf-profile.self.cycles-pp.do_sys_openat2
      0.12 ±  7%      -0.1        0.06 ± 41%  perf-profile.self.cycles-pp.security_inode_permission
      0.12 ±  6%      -0.1        0.07 ± 18%  perf-profile.self.cycles-pp.make_vfsuid
      0.11 ± 11%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__fput_sync
      0.10 ± 10%      -0.1        0.04 ± 59%  perf-profile.self.cycles-pp.__check_object_size
      0.08 ±  8%      -0.1        0.03 ± 77%  perf-profile.self.cycles-pp.open_last_lookups
      0.09 ±  7%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.security_inode_getattr
      0.08 ±  5%      -0.0        0.04 ± 79%  perf-profile.self.cycles-pp.map_id_up
      0.07 ±  9%      -0.0        0.02 ±100%  perf-profile.self.cycles-pp.__btrfs_add_delayed_item
      0.08 ± 13%      -0.0        0.04 ± 59%  perf-profile.self.cycles-pp.btrfs_get_dir_last_index
      0.07 ±  6%      -0.0        0.03 ± 78%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.09 ±  8%      -0.0        0.05 ± 41%  perf-profile.self.cycles-pp.btrfs_get_16
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.08 ±  6%      +0.1        0.15 ± 21%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.02 ±133%      +0.1        0.10 ± 44%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.02 ±129%      +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.18 ±  6%      +0.2        0.34 ±  7%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.2        0.24 ± 49%  perf-profile.self.cycles-pp.btrfs_readdir_delayed_dir_index
      0.00            +0.4        0.35 ± 24%  perf-profile.self.cycles-pp.btrfs_readdir_put_delayed_items
      0.05 ± 42%      +0.4        0.42 ± 33%  perf-profile.self.cycles-pp.rb_next
      0.35 ±  9%      +0.4        0.72 ±  9%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.01 ±173%      +0.5        0.54 ± 24%  perf-profile.self.cycles-pp.btrfs_readdir_get_delayed_items
      5.13 ±  6%      +6.8       11.96 ±  7%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.35 ± 11%     +50.5       50.84 ±  6%  perf-profile.self.cycles-pp.btrfs_should_delete_dir_index




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


