Return-Path: <linux-kernel+bounces-23782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CB82B19A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE701F22401
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69C4CB44;
	Thu, 11 Jan 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCIIp0lI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBF4BAB5;
	Thu, 11 Jan 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704986417; x=1736522417;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=yoe5NVCpAZh7H83TQ7/ayJn2TypggrOhH6lZaz4x8m8=;
  b=iCIIp0lI12jAhkzvroWjrIFWJjWFf6M97MVXrfe7/yQ9qn+hmSdrpjqn
   pGEnjMCgcRC8RrSc0WHtUhUJzqIKmMjNn3iDgKWXZ9Fcj8wZNdBY3PLR8
   yw5S7lKlhAwALs/vLfuOJutlzR5GPGMtToUuYDdO+Clz9qvu6QQ0C+DCd
   04OFqdbVdJbGWCDuq8eyBAjJACUHXlP0WxGtIf8c1zlEH+oYnTyk4Z+7I
   Sag4q0FW8gtNf2sqmUkMXwRNXS2LE06Qd6WPVeH8iACZCm76p/9PBMvM6
   NSiEEnTN37R+tZ17fNPhcK4NuXSY3UEVhayFtx96HgoUrLYe5vPDpTIK0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5959306"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="5959306"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 07:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="17077352"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 07:20:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 07:20:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 07:20:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 07:20:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLXpT5Oomoa0dwAkrKCxzih7szcBJMoIjSW762o6oIm1xnFpqHsIV7Io2sSJdkiw/HLrFR6BsJ1vaUJCOmUH/giK96f5+hsBRV8OdhB1Y+kcJHAYAQ2Do67PB+bLsv0S/VWMqMjpT6Cd8qyHECCXnpHqrdU2oQg8P8wWY35EwMzPlX3J9/PISx9JmQg9+U+3JWO0eE/cbsNPyaJ3rFkEwFwU6O7fOLHdchXIW0QlqHcUPz922phSGkz4m5xZEHrOX8C8c87n6aGpBrEK0edG9yhhmGESyCX0VCduqnxMNfBltmZwGWCdf/nCLvQC7NcOMbR6MOHIM34fNhlgCracpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UHIiDH3hpJKm5Qx7OYiTswCnpF8C/XI/XZmybtvzSY=;
 b=dSQ6B+RXzf4RU+bCx1m5tuJ0jay5PHLmMB3HgUm14IwQiHjpwWvwf8x+uHiz+nss9m0j21s+Y00x3luRwSaUH3divEnMuoSPGB+c/DPjJaa8t/eAmlWXQKV0l4uUkEXv7DNsFMMlptr8LKJ/CL87+jKmZUZC/7IKK62KkALaYxBpj+L7Lk/CIhNLSd+22XCmH/d/D9n9SdMHTjRBZBrTsSCFrRaKhBV3WbmhGhvOTfwjpLUF9ZH9st2oZdrm5563xyTXMAvbnNFygyK37uFlHuR3OJaJdj2aQ9BV1ecul/EaYKh/jvvkBZ3CEE9hH9fSJuhz2DL21PMxGFvsb8NjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 15:19:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 15:19:58 +0000
Date: Thu, 11 Jan 2024 23:19:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: wangkeqi <wangkeqiwang@didiglobal.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [connector]  c46bfba133:
 stress-ng.netlink-proc.ops_per_sec -97.2% regression
Message-ID: <202401112259.b23a1567-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 07dc2592-ec79-4944-e66a-08dc12b8c584
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3soeHH4BpVrtHbFayoEM0iMglXfmaM+e0ydASlQXKbjIl3ZXOcqrnuPtck/7D1Ns3RZY1NM9vNAfce0iBZQjYs0N2yGDpYYhD1yyms2Dj/ymn3U2OGEG9LjOZid8EtZYK2cYCQmcdYbV+Bb/bO3RJlXtQqqXd1jgYcYoU0TNhVcBZPKKfnhmNcD8otffjmwaAFNA+qHpDL19HtSxWZRwswjJydUfrL9L4kZRwCSlooBqewk3+j+NjL3KSHxHcTVGG3f29hRvYRVfFo2TfFfsWo6FYyeoyHDKgRjDfDKnGwxEZxU2vdOSSvASbw9/waHIhsWYWcBUGz/hCuoVRqGCUWcIceDKTUi11LkY9AfUoCLK736kh1EKlQktGKe8NwB1slmuh6KvoixPktvxgx1CypDwAtHRYkMlneySCFgVxcmNohC4WEPKFS49nQE1sZrkGmSgwmcLGTJsTgnSp/ekDtKdKB6+fT/MUnEwDiWjq5zVKqJ5tFqBFUShdKwT1/2xWpZiJwIJX7obpCsHtHP57i2dYrwm9Iw+pcGp1bHOxwhG/Hf7V984raMyPGGUeFny1eJQru9q1X/Q/xxl1TxcTyInAmS/oL9Es2FNEsypxzFcK9lcQh/QlEVzXeSGGZBowEtp8VklzM1ouPH103t1O5ECoMIfwff3TjHLmeFFpGnW5SRIauEzhZBouPVT1u9wkWNeesBREvEcR8ZNe4e8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230273577357003)(230473577357003)(230373577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(107886003)(8676002)(1076003)(26005)(316002)(6512007)(6506007)(2616005)(83380400001)(66946007)(6486002)(66556008)(66476007)(41300700001)(86362001)(19627235002)(6666004)(966005)(478600001)(6916009)(30864003)(5660300002)(38100700002)(36756003)(2906002)(82960400001)(4326008)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?68ms5lEOjTi7vEbv8hxr3OndrsczKZHxR1C9ze2SHaY39YI3VAySbtJ9pk?=
 =?iso-8859-1?Q?iM3biKm6ZylS01+PRMpmA2x9CUgA8nhDoIshvoauqOBRud2rWz4QSRT+pl?=
 =?iso-8859-1?Q?9dUWeZ7P5XdBWgKnRkICj9ORmgtNL/ubv0t/MxL35CtIcGyNTxCT+OdRcC?=
 =?iso-8859-1?Q?BWbfS3WwKoRGK/yPnxZjF0tdgQS8VG6DdOY57ioSKbe6W5DN2woBGtr9t5?=
 =?iso-8859-1?Q?SyVKNy2b9xGpp9wwxkHY2AsZ0w/gaewRsTxwo9cFh82R3fjpmPt5zFEQYl?=
 =?iso-8859-1?Q?O/VJQNF6njtZ0DbJPIwDzGr3Ero2pQsFJ3Y4BdEFRF9e3WIS5YnlORpsk3?=
 =?iso-8859-1?Q?9478wA8RcsjeY+XgQtzhSsxus0iUO2HZcvxXT3sDaKehzYGdpD/KUISJAK?=
 =?iso-8859-1?Q?cE+rjN/R+4NGIax/54KfC9LdJHcBdLpIx3j4YlL7E4RMc5S8xzXv2v/rl1?=
 =?iso-8859-1?Q?lcX2ygAlGPbLJSqPQ+gdobDSUk4mTTULyZhbhCrmJGko9QhetJFYaEgj7C?=
 =?iso-8859-1?Q?fTG8JifOmKd77Buv89I0a+XWJn20zDhifNUqVtAMjhCyw3+LXz690oZlFI?=
 =?iso-8859-1?Q?XhA1YR4ZPy4VV6M/oJPJOmmF1bG7ZBtdHgjxBU2BalOwpr21QOWlrOMuDX?=
 =?iso-8859-1?Q?FGp8MaU0ko5ClZXlwa9HfIb1MytDdNI7A+H5p4k+4zyC64/cr7wfhCkSvu?=
 =?iso-8859-1?Q?w6mm/oPBAK9NIAkvTef1p+bq1h9TKLEUMxluUUIorpz1k6sQIW05rTF+BF?=
 =?iso-8859-1?Q?JIKPGc7VMJzfKcZHsjlKYqZLebahn8uI/74D1dy4hJFkJ/ASYyF5MWcnH5?=
 =?iso-8859-1?Q?7yeDne4SYllkjMnjGHVUZ8lmRXwQDtrQGIpijv942SvQ+8ng6EVcDgRw4q?=
 =?iso-8859-1?Q?wFVDnRyFhg+mXpNmLKM8rYwACRDx2NgJVVa6RGXt4YYe8mbdUnsDxlH/2s?=
 =?iso-8859-1?Q?RdH+Ga7aTFziMIXPmNkYtsA4ERYRuB9C3Op8mRxHK1kyeKsHKtF6JV08Pv?=
 =?iso-8859-1?Q?/O8YQsiC/4kktj7UWZuWt/AQGRMiXQXacuUGjs6jSK3AXANYhQxjlbNaHh?=
 =?iso-8859-1?Q?b50CnczlPgglyJsYo9d00u1vRdVuVbvFAhq/E0ZRTl33Ld2nVsxcumQnyi?=
 =?iso-8859-1?Q?fxfjgC2NYm3H7DJLCCI7JXCbGrJEez8texWH59daLF+r6ycUwGpBK53ZEW?=
 =?iso-8859-1?Q?XvMNxhP+igrekdx+mntUzJEff/BphHIhbf5L6nu44o37phsHfyJJhlH/d3?=
 =?iso-8859-1?Q?sqkvKk81J6lNujKU9VabxyEzF5Q0vcebZKigCFVAhN2fbQ1/xStsJTgs45?=
 =?iso-8859-1?Q?J6tHITqbPTlDLIM2Jj2sPh1iAwuj/1D9LTVjHmCP9tLfhGVj7vJ9Oo55Z0?=
 =?iso-8859-1?Q?wlXrmUquVcIExLuur5M+Km0aJ2dq70JtNa+N0lH2rhhUKnZdK70GrfKHbE?=
 =?iso-8859-1?Q?WgOfVOWZfkYj6vw/GZVv50pwd8kV9b67vNXVocK5mcz3n3a5PWV9+gKHHF?=
 =?iso-8859-1?Q?anQ4aOO/1wSkz/7w9YPqViV7CXy6a20kSUamQBNrcZX1+yN5yoVhUss9K7?=
 =?iso-8859-1?Q?sxmyWV6cacrcUMpf84AOOdOybAFAzEqIKpa6JjmB2m7Qmql2nMzN053Ssc?=
 =?iso-8859-1?Q?QamvfcQRP6mtd1fxuPvWGxaQLj56MtiP7c2ULbrPx60q4A9q2sdtY9TQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dc2592-ec79-4944-e66a-08dc12b8c584
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:19:58.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPQ7q9f2OgNfKil/TKQgq60vI2l1GBsvA8lBkLhylLyQDlfe4auWRCEql1xl6sOM1q6TWxk/SvkqeWfwfTZcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com



Hello,

we reviewed this report and Fengwei (Cced) pointed out it could be the patch
breaks functionality, then causes stress-ng netlink-proc performance drops
dramatically.

below details:


kernel test robot noticed a -97.2% regression of stress-ng.netlink-proc.ops_per_sec on:


commit: c46bfba1337d301661dbb23cfd905d4cb51f27ca ("connector: Fix proc_event_num_listeners count not cleared")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	sc_pid_max: 4194304
	class: scheduler
	test: netlink-proc
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.netlink-proc.ops_per_sec -97.4% regression                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory    |
| test parameters  | class=os                                                                                     |
|                  | cpufreq_governor=performance                                                                 |
|                  | disk=1HDD                                                                                    |
|                  | fs=ext4                                                                                      |
|                  | nr_threads=10%                                                                               |
|                  | test=netlink-proc                                                                            |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401112259.b23a1567-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240111/202401112259.b23a1567-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/test/testcase/testtime:
  scheduler/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/4194304/lkp-icl-2sp8/netlink-proc/stress-ng/60s

commit: 
  059d37b718 ("net: phy: linux/phy.h: fix Excess kernel-doc description warning")
  c46bfba133 ("connector: Fix proc_event_num_listeners count not cleared")

059d37b718d38d26 c46bfba1337d301661dbb23cfd9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2359          +150.7%       5915        uptime.idle
 3.537e+08 ±  3%   +1019.9%  3.961e+09        cpuidle..time
   2103185 ±  4%     +94.6%    4092323        cpuidle..usage
  53818952 ±  2%     -96.4%    1950100 ± 13%  numa-numastat.node0.local_node
  53849056 ±  2%     -96.3%    1978128 ± 13%  numa-numastat.node0.numa_hit
  52086289 ±  2%     -95.2%    2523104 ±  7%  numa-numastat.node1.local_node
  52111562 ±  2%     -95.1%    2561457 ±  7%  numa-numastat.node1.numa_hit
      7.85 ±  8%     +88.4       96.28        mpstat.cpu.all.idle%
      1.24            -0.6        0.62        mpstat.cpu.all.irq%
      0.44            -0.4        0.04        mpstat.cpu.all.soft%
     87.22           -84.6        2.58        mpstat.cpu.all.sys%
      3.23            -2.8        0.46        mpstat.cpu.all.usr%
      1117 ± 30%     -99.8%       2.62 ± 53%  perf-c2c.DRAM.local
      6349 ± 23%     -99.7%      19.25 ± 34%  perf-c2c.DRAM.remote
      5462 ± 23%     -99.0%      52.50 ± 16%  perf-c2c.HITM.local
      4325 ± 23%     -99.7%      12.12 ± 36%  perf-c2c.HITM.remote
      9788 ± 23%     -99.3%      64.62 ± 16%  perf-c2c.HITM.total
     10.68 ±  6%    +800.1%      96.13        vmstat.cpu.id
     86.25           -96.0%       3.41        vmstat.cpu.sy
   4111553           -25.2%    3074209        vmstat.memory.cache
     63.63           -97.1%       1.82 ±  2%  vmstat.procs.r
    146012           -95.3%       6884 ±  4%  vmstat.system.cs
    152731           -55.9%      67335        vmstat.system.in
    523391           -97.2%      14879        stress-ng.netlink-proc.ops
      8722           -97.2%     247.98        stress-ng.netlink-proc.ops_per_sec
    356165           -96.9%      11052        stress-ng.time.involuntary_context_switches
      1473 ± 35%     -97.8%      32.75 ± 30%  stress-ng.time.major_page_faults
 1.372e+08 ±  2%     -97.1%    3998876        stress-ng.time.minor_page_faults
      5697           -97.3%     155.62        stress-ng.time.percent_of_cpu_this_job_got
      2906           -97.4%      75.58        stress-ng.time.system_time
    630.73           -96.6%      21.40        stress-ng.time.user_time
   5488052           -96.7%     181357        stress-ng.time.voluntary_context_switches
      3303           -95.8%     139.50        turbostat.Avg_MHz
     92.22           -88.3        3.88        turbostat.Busy%
   2067574 ±  4%     +95.9%    4050376        turbostat.C1
      7.97 ±  3%     +89.2       97.12        turbostat.C1%
      7.78 ±  3%   +1136.1%      96.12        turbostat.CPU%c1
     67.00 ±  3%     -28.0%      48.25 ±  2%  turbostat.CoreTmp
      0.14 ±  5%     +39.8%       0.19 ± 11%  turbostat.IPC
   9966000           -56.5%    4335673        turbostat.IRQ
     16.96 ± 16%     -17.0        0.00        turbostat.PKG_%
      3149 ±  7%     -95.3%     146.88 ± 14%  turbostat.POLL
     67.00 ±  4%     -28.2%      48.12 ±  2%  turbostat.PkgTmp
    400.65           -39.5%     242.59        turbostat.PkgWatt
    111.39           -43.2%      63.24        turbostat.RAMWatt
    136245 ±  5%     -70.3%      40480        meminfo.Active
    136149 ±  5%     -70.3%      40383        meminfo.Active(anon)
   3959315           -84.8%     602536 ±  5%  meminfo.AnonPages
   4004177           -25.6%    2978579        meminfo.Cached
   7381742           -80.9%    1408484 ±  2%  meminfo.Committed_AS
   4972929           -86.2%     686105 ±  4%  meminfo.Inactive
   4972727           -86.2%     685902 ±  4%  meminfo.Inactive(anon)
     19377           -20.2%      15459        meminfo.KernelStack
    803826           -84.9%     121559        meminfo.Mapped
   9256289           -49.0%    4723489        meminfo.Memused
     38513 ±  2%     -70.0%      11559 ±  2%  meminfo.PageTables
    192436           -13.2%     167031        meminfo.SUnreclaim
   1152571           -89.0%     126979        meminfo.Shmem
    290081            -9.8%     261779        meminfo.Slab
   9304070           -41.1%    5479814        meminfo.max_used_kB
     34041 ±  5%     -70.3%      10096        proc-vmstat.nr_active_anon
    990329           -84.8%     150523 ±  5%  proc-vmstat.nr_anon_pages
   6324920            +1.8%    6438128        proc-vmstat.nr_dirty_background_threshold
  12665306            +1.8%   12891997        proc-vmstat.nr_dirty_threshold
   1001066           -25.6%     744650        proc-vmstat.nr_file_pages
  63626644            +1.8%   64760377        proc-vmstat.nr_free_pages
   1243693           -86.2%     171359 ±  4%  proc-vmstat.nr_inactive_anon
     19374           -20.2%      15459        proc-vmstat.nr_kernel_stack
    201019           -84.9%      30403        proc-vmstat.nr_mapped
      9667           -70.1%       2889 ±  2%  proc-vmstat.nr_page_table_pages
    288163           -89.0%      31749        proc-vmstat.nr_shmem
     24411            -3.0%      23687        proc-vmstat.nr_slab_reclaimable
     48131           -13.2%      41755        proc-vmstat.nr_slab_unreclaimable
     34041 ±  5%     -70.3%      10096        proc-vmstat.nr_zone_active_anon
   1243693           -86.2%     171359 ±  4%  proc-vmstat.nr_zone_inactive_anon
  1.06e+08 ±  2%     -95.7%    4543130 ±  4%  proc-vmstat.numa_hit
 1.059e+08 ±  2%     -95.8%    4476750 ±  4%  proc-vmstat.numa_local
   2143961 ± 11%     -63.5%     782424 ± 30%  proc-vmstat.numa_pte_updates
 1.119e+08 ±  2%     -95.7%    4763634 ±  4%  proc-vmstat.pgalloc_normal
 1.419e+08 ±  2%     -95.7%    6148270 ±  5%  proc-vmstat.pgfault
  1.08e+08 ±  2%     -95.6%    4734648 ±  4%  proc-vmstat.pgfree
  13950826 ±  4%     -95.7%     599842 ± 23%  proc-vmstat.pgreuse
     47893 ± 11%     -94.3%       2749 ± 51%  numa-meminfo.node0.Active
     47845 ± 11%     -94.4%       2700 ± 52%  numa-meminfo.node0.Active(anon)
    641538 ± 30%     -64.5%     227998 ± 37%  numa-meminfo.node0.AnonPages
   3987839 ± 48%     -68.7%    1248480 ± 73%  numa-meminfo.node0.AnonPages.max
    957322 ± 19%     -71.7%     271292 ± 27%  numa-meminfo.node0.Inactive
    957220 ± 19%     -71.7%     271188 ± 27%  numa-meminfo.node0.Inactive(anon)
     10789 ±  4%     -20.0%       8627 ±  5%  numa-meminfo.node0.KernelStack
    282050 ± 10%     -79.1%      58983 ± 69%  numa-meminfo.node0.Mapped
   2153663 ± 44%     -48.0%    1120201 ± 30%  numa-meminfo.node0.MemUsed
     18360 ±  8%     -64.5%       6516 ± 34%  numa-meminfo.node0.PageTables
    107442 ±  3%     -13.2%      93210 ±  4%  numa-meminfo.node0.SUnreclaim
    366669 ± 13%     -86.6%      49210 ± 69%  numa-meminfo.node0.Shmem
     87484 ±  7%     -56.7%      37858 ±  4%  numa-meminfo.node1.Active
     87436 ±  7%     -56.8%      37810 ±  4%  numa-meminfo.node1.Active(anon)
   3291904 ±  4%     -88.6%     374444 ± 23%  numa-meminfo.node1.AnonPages
  10488521 ± 17%     -71.2%    3018784 ± 21%  numa-meminfo.node1.AnonPages.max
   3989075 ±  3%     -89.6%     414561 ± 18%  numa-meminfo.node1.Inactive
   3988976 ±  3%     -89.6%     414461 ± 18%  numa-meminfo.node1.Inactive(anon)
      8589 ±  5%     -20.5%       6832 ±  5%  numa-meminfo.node1.KernelStack
    519017 ±  4%     -87.9%      62597 ± 65%  numa-meminfo.node1.Mapped
   7074343 ± 12%     -49.1%    3603371 ±  8%  numa-meminfo.node1.MemUsed
     20325 ±  5%     -75.3%       5019 ± 41%  numa-meminfo.node1.PageTables
     85317 ±  3%     -13.5%      73813 ±  5%  numa-meminfo.node1.SUnreclaim
    784445 ±  6%     -90.1%      77811 ± 43%  numa-meminfo.node1.Shmem
     11963 ± 11%     -94.4%     675.25 ± 52%  numa-vmstat.node0.nr_active_anon
    160569 ± 30%     -64.5%      57015 ± 37%  numa-vmstat.node0.nr_anon_pages
    239486 ± 19%     -71.7%      67814 ± 27%  numa-vmstat.node0.nr_inactive_anon
     10796 ±  4%     -20.1%       8630 ±  5%  numa-vmstat.node0.nr_kernel_stack
     70526 ± 10%     -79.1%      14749 ± 69%  numa-vmstat.node0.nr_mapped
      4599 ±  7%     -64.6%       1629 ± 34%  numa-vmstat.node0.nr_page_table_pages
     91675 ± 13%     -86.6%      12302 ± 69%  numa-vmstat.node0.nr_shmem
     26866 ±  3%     -13.3%      23302 ±  4%  numa-vmstat.node0.nr_slab_unreclaimable
     11963 ± 11%     -94.4%     675.25 ± 52%  numa-vmstat.node0.nr_zone_active_anon
    239486 ± 19%     -71.7%      67814 ± 27%  numa-vmstat.node0.nr_zone_inactive_anon
  53829138 ±  2%     -96.3%    1978171 ± 13%  numa-vmstat.node0.numa_hit
  53799034 ±  2%     -96.4%    1950144 ± 13%  numa-vmstat.node0.numa_local
     21861 ±  7%     -56.8%       9452 ±  4%  numa-vmstat.node1.nr_active_anon
    823304 ±  4%     -88.6%      93730 ± 23%  numa-vmstat.node1.nr_anon_pages
    997615 ±  3%     -89.6%     103743 ± 18%  numa-vmstat.node1.nr_inactive_anon
      8591 ±  5%     -20.5%       6831 ±  5%  numa-vmstat.node1.nr_kernel_stack
    129802 ±  4%     -87.9%      15660 ± 65%  numa-vmstat.node1.nr_mapped
      5113 ±  4%     -75.5%       1255 ± 41%  numa-vmstat.node1.nr_page_table_pages
    196146 ±  6%     -90.1%      19462 ± 44%  numa-vmstat.node1.nr_shmem
     21332 ±  3%     -13.5%      18452 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
     21861 ±  7%     -56.8%       9452 ±  4%  numa-vmstat.node1.nr_zone_active_anon
    997613 ±  3%     -89.6%     103743 ± 18%  numa-vmstat.node1.nr_zone_inactive_anon
  52111878 ±  2%     -95.1%    2561265 ±  7%  numa-vmstat.node1.numa_hit
  52086603 ±  2%     -95.2%    2522913 ±  7%  numa-vmstat.node1.numa_local
   2056485           -99.5%      10801 ±187%  sched_debug.cfs_rq:/.avg_vruntime.avg
   3020107 ± 11%     -98.8%      35825 ±115%  sched_debug.cfs_rq:/.avg_vruntime.max
   1739016 ±  5%     -99.6%       7012 ±255%  sched_debug.cfs_rq:/.avg_vruntime.min
    186303 ± 20%     -97.5%       4730 ± 61%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.70 ±  4%     -68.8%       0.22 ± 20%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.51 ±  9%     -20.0%       0.41 ± 12%  sched_debug.cfs_rq:/.h_nr_running.stddev
     45330 ± 39%     -99.9%      25.47 ±183%  sched_debug.cfs_rq:/.left_vruntime.avg
   1935616 ± 11%     -99.9%       1630 ±183%  sched_debug.cfs_rq:/.left_vruntime.max
    285212 ± 24%     -99.9%     202.20 ±183%  sched_debug.cfs_rq:/.left_vruntime.stddev
     37250 ± 23%     -45.8%      20171 ± 11%  sched_debug.cfs_rq:/.load.avg
      2.69 ± 30%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
   2056485           -99.5%      10801 ±187%  sched_debug.cfs_rq:/.min_vruntime.avg
   3020107 ± 11%     -98.8%      35825 ±115%  sched_debug.cfs_rq:/.min_vruntime.max
   1739016 ±  5%     -99.6%       7012 ±255%  sched_debug.cfs_rq:/.min_vruntime.min
    186303 ± 20%     -97.5%       4730 ± 61%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.61 ±  3%     -63.8%       0.22 ± 20%  sched_debug.cfs_rq:/.nr_running.avg
     45330 ± 39%     -99.9%      25.47 ±183%  sched_debug.cfs_rq:/.right_vruntime.avg
   1935616 ± 11%     -99.9%       1630 ±183%  sched_debug.cfs_rq:/.right_vruntime.max
    285212 ± 24%     -99.9%     202.20 ±183%  sched_debug.cfs_rq:/.right_vruntime.stddev
    676.13 ±  3%     -30.1%     472.64 ± 17%  sched_debug.cfs_rq:/.runnable_avg.avg
     81.94 ± 46%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    656.01 ±  3%     -28.1%     471.81 ± 17%  sched_debug.cfs_rq:/.util_avg.avg
     62.02 ± 11%     -49.4%      31.37 ± 18%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    443687 ±  3%     +48.9%     660640 ±  8%  sched_debug.cpu.avg_idle.avg
     65920           -40.6%      39179 ± 25%  sched_debug.cpu.clock.avg
     65923           -40.6%      39182 ± 25%  sched_debug.cpu.clock.max
     65914           -40.6%      39175 ± 25%  sched_debug.cpu.clock.min
      2.23 ±  4%     -29.3%       1.57 ± 10%  sched_debug.cpu.clock.stddev
     65182           -40.3%      38924 ± 25%  sched_debug.cpu.clock_task.avg
     65438           -40.2%      39150 ± 25%  sched_debug.cpu.clock_task.max
     58224           -45.1%      31976 ± 30%  sched_debug.cpu.clock_task.min
   1239645 ±  3%     -99.9%     777.38 ± 23%  sched_debug.cpu.curr->pid.avg
   1505269           -99.4%       9486 ±164%  sched_debug.cpu.curr->pid.max
    568784 ±  7%     -99.6%       2059 ± 86%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 28%     -59.6%       0.00 ± 29%  sched_debug.cpu.next_balance.stddev
      0.72 ±  4%     -69.2%       0.22 ± 20%  sched_debug.cpu.nr_running.avg
      2.31 ± 15%     -51.4%       1.12 ± 29%  sched_debug.cpu.nr_running.max
      0.53 ±  9%     -22.8%       0.41 ± 12%  sched_debug.cpu.nr_running.stddev
     74166           -95.4%       3426 ± 33%  sched_debug.cpu.nr_switches.avg
    114148 ± 13%     -57.1%      48960 ± 20%  sched_debug.cpu.nr_switches.max
     54294 ± 10%     -99.3%     385.56 ±145%  sched_debug.cpu.nr_switches.min
     67.56 ± 14%     -69.9%      20.31 ± 20%  sched_debug.cpu.nr_uninterruptible.max
   -107.75           -88.3%     -12.62        sched_debug.cpu.nr_uninterruptible.min
     28.72 ± 26%     -80.1%       5.71 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
     65916           -40.6%      39177 ± 25%  sched_debug.cpu_clk
     64687           -41.3%      37948 ± 26%  sched_debug.ktime
      0.01          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.avg
      0.50          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.max
      0.06          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.stddev
      2.00 ±151%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.avg
    127.86 ±151%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.max
     15.86 ±151%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.stddev
     66642           -40.2%      39871 ± 24%  sched_debug.sched_clk
      6.02 ±  2%     -83.3%       1.00 ±  5%  perf-stat.i.MPKI
 1.717e+10           -94.5%  9.477e+08        perf-stat.i.branch-instructions
      0.84            +0.2        1.03        perf-stat.i.branch-miss-rate%
 1.359e+08           -91.8%   11159391        perf-stat.i.branch-misses
     32.98           -18.3       14.67 ±  2%  perf-stat.i.cache-miss-rate%
 5.277e+08 ±  2%     -96.9%   16350382        perf-stat.i.cache-misses
 1.558e+09           -96.7%   50901066        perf-stat.i.cache-references
    153850           -95.5%       6923 ±  4%  perf-stat.i.context-switches
 2.147e+11           -96.1%  8.312e+09        perf-stat.i.cpu-cycles
     61746           -97.0%       1845        perf-stat.i.cpu-migrations
    508.94 ±  5%    +919.9%       5190 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.38 ±177%      -0.3        0.04 ±  9%  perf-stat.i.dTLB-load-miss-rate%
 6.384e+11 ±264%    -100.0%     851795 ±  5%  perf-stat.i.dTLB-load-misses
 2.188e+10           -94.8%  1.143e+09        perf-stat.i.dTLB-loads
      0.14 ±  2%      -0.1        0.05 ±  8%  perf-stat.i.dTLB-store-miss-rate%
  15023445           -95.8%     636073 ±  5%  perf-stat.i.dTLB-store-misses
  1.03e+10           -94.9%  5.211e+08        perf-stat.i.dTLB-stores
  8.48e+10           -94.6%   4.59e+09        perf-stat.i.instructions
      0.42           +40.3%       0.59        perf-stat.i.ipc
     23.20 ± 37%     -97.6%       0.57 ± 27%  perf-stat.i.major-faults
      3.32           -96.1%       0.13        perf-stat.i.metric.GHz
    601.96           +18.8%     715.37 ±  6%  perf-stat.i.metric.K/sec
    791.29           -94.8%      41.02        perf-stat.i.metric.M/sec
   2272184 ±  2%     -95.7%      97915 ±  5%  perf-stat.i.minor-faults
     88.83           -14.3       74.57 ±  3%  perf-stat.i.node-load-miss-rate%
 1.349e+08           -97.2%    3766669 ±  2%  perf-stat.i.node-load-misses
  16021281 ±  2%     -96.5%     554627 ±  7%  perf-stat.i.node-loads
     51.80           -20.3       31.53 ± 31%  perf-stat.i.node-store-miss-rate%
  74501930           -97.3%    1983732        perf-stat.i.node-store-misses
  67613840 ±  2%     -96.3%    2522333 ±  2%  perf-stat.i.node-stores
   2272208 ±  2%     -95.7%      97915 ±  5%  perf-stat.i.page-faults
      6.23 ±  2%     -42.7%       3.57        perf-stat.overall.MPKI
      0.79            +0.4        1.18        perf-stat.overall.branch-miss-rate%
     33.85            -1.7       32.13        perf-stat.overall.cache-miss-rate%
      2.53           -28.3%       1.81        perf-stat.overall.cpi
    406.10 ±  2%     +25.1%     507.98        perf-stat.overall.cycles-between-cache-misses
     12.56 ±261%     -12.5        0.07 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.15 ±  2%      -0.0        0.12 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      0.40           +39.6%       0.55        perf-stat.overall.ipc
     52.20            -8.1       44.08        perf-stat.overall.node-store-miss-rate%
 1.661e+10           -94.4%  9.347e+08        perf-stat.ps.branch-instructions
  1.31e+08           -91.6%   10997863        perf-stat.ps.branch-misses
 5.108e+08           -96.8%   16156545        perf-stat.ps.cache-misses
 1.509e+09           -96.7%   50284109        perf-stat.ps.cache-references
    148799           -95.4%       6841 ±  4%  perf-stat.ps.context-switches
 2.073e+11           -96.0%  8.206e+09        perf-stat.ps.cpu-cycles
     59299           -96.9%       1823        perf-stat.ps.cpu-migrations
 5.189e+11 ±264%    -100.0%     842481 ±  5%  perf-stat.ps.dTLB-load-misses
 2.117e+10           -94.7%  1.128e+09        perf-stat.ps.dTLB-loads
  14645075 ±  2%     -95.7%     627416 ±  5%  perf-stat.ps.dTLB-store-misses
 9.985e+09           -94.9%   5.14e+08        perf-stat.ps.dTLB-stores
 8.198e+10           -94.5%  4.528e+09        perf-stat.ps.instructions
     22.96 ± 35%     -97.6%       0.56 ± 27%  perf-stat.ps.major-faults
   2204142 ±  2%     -95.6%      96510 ±  5%  perf-stat.ps.minor-faults
 1.301e+08 ±  2%     -97.1%    3721434 ±  2%  perf-stat.ps.node-load-misses
  16476921 ±  2%     -96.7%     551313 ±  7%  perf-stat.ps.node-loads
  71602024           -97.3%    1960249        perf-stat.ps.node-store-misses
  65575204           -96.2%    2487796 ±  2%  perf-stat.ps.node-stores
   2204165 ±  2%     -95.6%      96510 ±  5%  perf-stat.ps.page-faults
 5.108e+12 ±  2%     -94.5%  2.825e+11        perf-stat.total.instructions
      0.05 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      0.04 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.copy_p4d_range
      0.04 ± 39%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.copy_p4d_range
      0.04 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__pte_alloc
      0.04 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      0.03 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.05 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      0.04 ± 39%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      0.06 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
      0.04 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      0.05 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.04 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.00 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.07 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      0.04 ± 45%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.04 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.04 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.04 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      0.07 ± 32%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      0.08 ±103%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.05 ± 40%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.04 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.04 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.04 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.04 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.06 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.05 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.05 ±  6%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.05 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      0.05 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.05 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      0.04 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.04 ±  4%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      0.04 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      0.04 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      0.05 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      0.02 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      0.04 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      0.04 ± 67%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_expected_entries.dup_mmap
      0.05 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      0.04 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.03 ± 49%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.05 ± 52%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      0.05 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.06 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      0.04 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      0.04 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.05 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.05 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      0.03 ± 63%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.04 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      0.05 ±  4%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.06 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      0.06 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.04 ± 21%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.18 ± 89%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      0.04 ± 15%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.05 ±  7%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.05 ± 36%     -95.4%       0.00 ± 19%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.11 ± 96%     -91.6%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.08 ± 38%     -97.2%       0.00 ± 41%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.04           -93.9%       0.00 ± 18%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04           -88.8%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.05 ±  5%     -96.8%       0.00 ±100%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.04 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.03 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.04 ±  3%     -86.0%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.06 ±  6%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      0.04 ±  4%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.06 ±  9%     -95.2%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.05 ±115%     -90.1%       0.00 ± 19%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.05 ± 31%     -93.9%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.02 ±  9%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      0.02 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.02 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      0.04 ± 15%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      0.03 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.05 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.13 ± 11%     -97.7%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03 ± 28%     -90.7%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ±  7%     -88.5%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ±  9%     -81.8%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 70%     -88.5%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.03 ± 27%     -93.4%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.04 ±  2%     -74.8%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.24 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      0.35 ± 40%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.copy_p4d_range
      0.23 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.copy_p4d_range
      0.34 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__pte_alloc
      0.40 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      0.48 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.26 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      0.19 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      0.65 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
      0.13 ± 48%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      3.03 ± 62%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.26 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.28 ± 20%     -98.2%       0.01 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.15 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      0.35 ± 57%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.60 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      2.27 ±201%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.23 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      0.21 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      0.21 ±103%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.24 ± 57%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.49 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.59 ± 28%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      2.52 ±181%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.55 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      3.06 ± 66%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.44 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      1.35 ±116%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.25 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      2.21 ± 95%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.18 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      0.36 ± 59%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      4.20 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      0.26 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      0.15 ± 47%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      0.27 ± 56%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      0.05 ± 81%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      0.27 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      0.15 ± 82%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_expected_entries.dup_mmap
      1.38 ±165%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      1.46 ±151%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.13 ± 69%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.15 ± 95%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      0.42 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.12 ± 66%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      0.36 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      0.31 ± 57%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.38 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.42 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      0.93 ± 79%     -96.2%       0.04 ±249%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.19 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.16 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      1.22 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.23 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      0.38 ± 40%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.30 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.41 ±108%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      0.43 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.98 ±121%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.11 ± 29%     -96.1%       0.00 ±  8%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.15 ± 78%     -90.8%       0.01 ± 22%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.27 ± 34%     -98.6%       0.00 ± 70%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      7.28 ±  5%     -99.9%       0.01 ± 33%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     21.86 ± 17%    -100.0%       0.01 ± 36%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.03 ± 75%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.70 ± 28%     -99.8%       0.00 ±100%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.17 ± 54%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.12 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      2.45 ±109%     -99.8%       0.01 ±  5%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.59 ± 15%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      1.78 ± 95%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.50 ± 25%     -97.8%       0.01 ± 36%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.31 ± 30%     -98.7%       0.00 ±  8%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.19 ±127%     -96.4%       0.01 ±  9%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.22 ± 37%     -97.3%       0.01 ± 16%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.58 ± 10%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      0.81 ± 46%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      1.67 ±137%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      0.41 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      1.58 ± 81%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.44 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.69 ± 19%     -99.2%       0.01 ± 50%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.17 ± 69%     -97.2%       0.00 ± 16%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5.14 ± 46%     -99.9%       0.01 ± 13%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      8.69 ± 31%     -99.8%       0.01 ± 24%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ± 79%     -93.3%       0.01 ±  9%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.41 ± 41%     -99.3%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      6.23 ±  5%     -63.3%       2.29 ± 37%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.04           -90.8%       0.00 ± 11%  perf-sched.total_sch_delay.average.ms
     21.86 ± 17%     -88.1%       2.60        perf-sched.total_sch_delay.max.ms
      3.06         +9335.7%     288.87 ± 22%  perf-sched.total_wait_and_delay.average.ms
    626656           -99.6%       2692 ± 31%  perf-sched.total_wait_and_delay.count.ms
      2751 ± 21%     +76.7%       4862 ±  6%  perf-sched.total_wait_and_delay.max.ms
      3.02         +9463.7%     288.87 ± 22%  perf-sched.total_wait_time.average.ms
      2751 ± 21%     +76.7%       4862 ±  6%  perf-sched.total_wait_time.max.ms
     40.01 ± 77%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      2.44          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     10.75          +107.4%      22.29 ± 16%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      6.66 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
     42.16 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.02 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      9.70 ± 59%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     59.21 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
     16.63 ±100%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      2.04        +11100.8%     228.05 ±  3%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.12           -83.8%       0.18        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     41.82 ±  6%   +1322.9%     595.14 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3.38         +1567.7%      56.37 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     23.77         +2352.6%     582.95 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      9.18         +5985.7%     558.74        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     10.25 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      3416 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      4.75 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
     30.12 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      3292 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
     10.62 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      9.50 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      1476           -99.9%       1.00 ±180%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.38 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.vfree.part.0.delayed_vfree_work
    262169          -100.0%     126.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    262761          -100.0%     124.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    184.38 ±  9%     +24.3%     229.12 ±  3%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    326.38 ±  6%     -93.6%      21.00 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1484           -94.2%      86.50 ± 10%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     24201           -97.8%     543.88 ±  8%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     35356           -98.7%     469.25        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    215.48 ± 67%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
     10.87 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      7.12 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
    380.54 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     14.75 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
     69.86 ± 78%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    323.54 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
     31.91 ±101%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.vfree.part.0.delayed_vfree_work
    152.31 ±207%     -99.6%       0.58 ±  5%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     10.17 ± 16%   +3806.7%     397.25 ± 16%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.66 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      0.96 ± 40%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.copy_p4d_range
      1.39 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.copy_p4d_range
      1.25 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__pte_alloc
     40.01 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.33 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      1.54 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      1.22 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      0.75 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
      2.39 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.65 ± 46%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
     10.74          +107.5%      22.29 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      6.59 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      1.42 ± 42%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      1.18 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      1.21 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      2.56 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      3.08 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      2.39 ± 55%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      2.88 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__put_anon_vma.unlink_anon_vmas.free_pgtables
      1.33 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      1.22 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      1.19 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      1.30 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      2.90          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      2.76 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      2.66 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      2.39 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      2.68 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      2.43 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
     42.16 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.00 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.98 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      1.68 ± 30%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      1.22 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      1.35 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      1.45 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      2.82 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      2.69 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      2.10 ± 37%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
      9.70 ± 59%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      1.13 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      1.18 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      2.68 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      2.67 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      4.48 ± 86%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     59.21 ± 39%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      2.12 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      2.60          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      2.83 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      2.65 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.31 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
     16.45 ±101%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      0.65 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.65          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      1.99        +11342.4%     228.05 ±  3%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.08           -83.6%       0.18        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.98 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      2.36 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.09 ± 53%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
     26.12 ±251%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.77 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     41.82 ±  6%   +1323.1%     595.13 ±  8%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.95 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      0.55 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.45 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      1.08 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      0.98 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      2.24 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      3.35         +1580.6%      56.36 ± 10%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     23.75         +2354.3%     582.95 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      9.71 ±184%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      9.15         +6009.0%     558.73        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.99 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      7.12 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.copy_p4d_range
      7.11 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.copy_p4d_range
      8.05 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__pte_alloc
    215.48 ± 67%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      7.11 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      7.78 ± 23%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      7.07 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      7.49 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range
     10.83 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      6.92 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      7.03 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      7.28 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      9.35 ± 23%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
     12.37 ± 31%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      5.89 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      5.89 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      4.13 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      5.70 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__put_anon_vma.unlink_anon_vmas.free_pgtables
      8.83 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      9.49 ± 20%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
     11.97 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      9.67 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      9.52 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      7.08 ± 20%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      9.06 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      5.84 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      9.00 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      5.53 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
    380.54 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      7.79 ± 12%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
     12.82 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      7.23 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      7.51 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      8.70 ± 26%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
     12.10 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      4.92 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      6.97 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      3.76 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     69.86 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      7.75 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      7.30 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      7.47 ± 27%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      7.00 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
     10.40 ± 92%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
    323.54 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      5.53 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      9.69 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      6.15 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      6.15 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      7.41 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
     31.69 ±102%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      7.84 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     10.98 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    141.35 ±226%     -99.6%       0.57 ±  5%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      9.99 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    451.92 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      5.83 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
     67.34 ±242%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     10.42 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      6.85 ± 12%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      9.06 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      9.65 ± 22%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      7.49 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      8.39 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      6.08 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      8.09 ± 17%   +4813.0%     397.25 ± 16%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    250.19 ±173%    -100.0%       0.00 ±174%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     46.38           -46.4        0.00        perf-profile.calltrace.cycles-pp.__libc_fork
     44.83           -44.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
     44.83           -44.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     44.82           -44.8        0.00        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     44.82           -44.8        0.00        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     44.19           -44.2        0.00        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.80           -40.8        0.00        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     40.08           -40.1        0.00        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     35.47           -35.5        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.47           -35.5        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.47           -35.5        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.52           -34.9        0.59 ± 39%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.52           -34.9        0.60 ± 39%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     32.63           -32.6        0.00        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     32.62           -32.6        0.00        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     32.56           -32.6        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     26.62           -26.6        0.00        perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
     19.32           -19.3        0.00        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
     16.07           -16.1        0.00        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
     15.11           -15.1        0.00        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      8.92            -8.9        0.00        perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
      8.76            -8.8        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
      8.64            -8.6        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
      7.09            -7.1        0.00        perf-profile.calltrace.cycles-pp.down_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      6.80 ±  2%      -6.8        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      6.71            -6.7        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      6.58            -6.6        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
      6.53            -6.5        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      6.41 ±  2%      -6.4        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      6.21 ±  2%      -6.2        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      6.15            -6.1        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      6.02            -6.0        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables
      5.87 ±  2%      -5.9        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      5.62 ±  2%      -5.6        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      5.55            -5.6        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      5.25 ±  2%      -5.3        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      5.23 ±  2%      -5.2        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.22 ±  2%      -5.2        0.00        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.7        0.71 ± 16%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.7        0.72 ± 15%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.8        0.77 ± 16%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.80 ± 16%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains
      0.00            +1.0        0.99 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +1.1        1.07 ± 14%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      0.00            +1.1        1.07 ± 17%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.1        1.13 ± 14%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu
      0.00            +1.2        1.16 ± 11%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.3        1.33 ± 21%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +1.4        1.39 ± 21%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.00            +1.4        1.40 ± 14%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.4        1.41 ± 22%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.00            +1.4        1.41 ± 22%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.00            +1.4        1.41 ± 22%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.4        1.41 ± 22%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.4        1.41 ± 22%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.4        1.41 ± 22%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.4        1.41 ± 22%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +1.6        1.57 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.6        1.61 ± 10%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.9        1.89 ± 10%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +2.2        2.17 ± 10%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +2.2        2.21 ± 13%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +2.5        2.52 ± 43%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.8        2.78 ±  6%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.8        2.85 ± 76%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +3.0        3.02 ±  6%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +3.2        3.16 ± 67%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +4.2        4.20 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +5.0        4.99 ±  5%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +7.6        7.64 ±  7%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      0.00           +11.5       11.48 ±  6%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.00           +11.9       11.86 ±  6%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00           +15.9       15.85 ±  5%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.00           +17.3       17.29 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00           +17.5       17.47 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00           +19.6       19.59 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00           +23.2       23.21 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00           +28.5       28.50 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00           +29.4       29.43 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00           +39.8       39.78 ±  7%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.00           +48.8       48.81 ±  5%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00           +89.3       89.33        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +89.8       89.79        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00           +90.6       90.64        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00           +94.0       93.97        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +94.8       94.76        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +95.0       94.97        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +95.0       94.97        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.00           +96.4       96.38        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00          +123.5      123.53        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     86.80           -84.6        2.24 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     86.79           -84.6        2.23 ± 10%  perf-profile.children.cycles-pp.do_syscall_64
     46.50           -46.4        0.12 ± 45%  perf-profile.children.cycles-pp.__libc_fork
     44.86           -44.8        0.09 ± 62%  perf-profile.children.cycles-pp.__do_sys_clone
     44.86           -44.7        0.14 ± 43%  perf-profile.children.cycles-pp.kernel_clone
     44.23           -44.1        0.11 ± 51%  perf-profile.children.cycles-pp.copy_process
     40.83           -40.8        0.06 ± 78%  perf-profile.children.cycles-pp.dup_mm
     40.17           -40.1        0.04 ±112%  perf-profile.children.cycles-pp.dup_mmap
     35.94           -35.7        0.23 ± 28%  perf-profile.children.cycles-pp.__x64_sys_exit_group
     35.93           -35.7        0.23 ± 28%  perf-profile.children.cycles-pp.do_group_exit
     35.92           -35.7        0.23 ± 28%  perf-profile.children.cycles-pp.do_exit
     32.67           -32.5        0.14 ± 31%  perf-profile.children.cycles-pp.exit_mm
     32.62           -32.4        0.19 ± 22%  perf-profile.children.cycles-pp.__mmput
     32.57           -32.4        0.19 ± 22%  perf-profile.children.cycles-pp.exit_mmap
     28.02           -28.0        0.01 ±264%  perf-profile.children.cycles-pp.down_write
     26.66           -26.7        0.00        perf-profile.children.cycles-pp.anon_vma_fork
     24.98           -25.0        0.00        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     24.41           -24.4        0.00        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     19.34           -19.3        0.03 ±108%  perf-profile.children.cycles-pp.free_pgtables
     16.10           -16.1        0.00        perf-profile.children.cycles-pp.anon_vma_clone
     15.30           -15.3        0.00        perf-profile.children.cycles-pp.osq_lock
     15.13           -15.1        0.00        perf-profile.children.cycles-pp.unlink_anon_vmas
     10.03 ±  2%      -9.4        0.59 ± 13%  perf-profile.children.cycles-pp.asm_exc_page_fault
      9.09 ±  2%      -8.6        0.49 ± 14%  perf-profile.children.cycles-pp.exc_page_fault
      9.06 ±  2%      -8.6        0.49 ± 13%  perf-profile.children.cycles-pp.do_user_addr_fault
      7.89            -7.9        0.00        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      8.12 ±  2%      -7.7        0.43 ± 16%  perf-profile.children.cycles-pp.handle_mm_fault
      7.79 ±  2%      -7.4        0.40 ± 15%  perf-profile.children.cycles-pp.__handle_mm_fault
      6.81 ±  2%      -6.7        0.08 ± 51%  perf-profile.children.cycles-pp.unmap_vmas
      6.40            -6.4        0.00        perf-profile.children.cycles-pp.netlink_broadcast_filtered
      6.42 ±  2%      -6.3        0.07 ± 62%  perf-profile.children.cycles-pp.unmap_page_range
      6.26            -6.3        0.00        perf-profile.children.cycles-pp.do_one_broadcast
      6.23 ±  2%      -6.2        0.07 ± 63%  perf-profile.children.cycles-pp.zap_pmd_range
      6.34 ±  3%      -6.1        0.24 ± 27%  perf-profile.children.cycles-pp.do_read_fault
      6.36 ±  3%      -6.1        0.27 ± 22%  perf-profile.children.cycles-pp.do_fault
      6.07 ±  2%      -6.0        0.07 ± 63%  perf-profile.children.cycles-pp.zap_pte_range
      6.07 ±  3%      -5.9        0.20 ± 33%  perf-profile.children.cycles-pp.filemap_map_pages
      4.30            -4.2        0.07 ± 86%  perf-profile.children.cycles-pp.kmem_cache_alloc
      3.45 ±  2%      -3.4        0.03 ±102%  perf-profile.children.cycles-pp.tlb_finish_mmu
      3.33 ±  4%      -3.2        0.10 ± 39%  perf-profile.children.cycles-pp.next_uptodate_folio
      2.45            -2.4        0.04 ± 83%  perf-profile.children.cycles-pp.kmem_cache_free
      2.40            -2.4        0.04 ± 86%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      1.70            -1.5        0.15 ± 45%  perf-profile.children.cycles-pp.__schedule
      1.32 ±  3%      -1.3        0.06 ± 63%  perf-profile.children.cycles-pp.alloc_pages_mpol
      1.27 ±  3%      -1.2        0.06 ± 79%  perf-profile.children.cycles-pp.__alloc_pages
      1.16 ±  4%      -1.1        0.04 ± 83%  perf-profile.children.cycles-pp.set_pte_range
      1.03 ±  2%      -0.9        0.10 ± 46%  perf-profile.children.cycles-pp.schedule
      1.18 ± 28%      -0.9        0.30 ± 32%  perf-profile.children.cycles-pp.__cmd_record
      0.91 ±  2%      -0.9        0.06 ± 83%  perf-profile.children.cycles-pp.newidle_balance
      0.77 ±  3%      -0.7        0.03 ±104%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.92            -0.5        0.37 ± 15%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.88            -0.5        0.37 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
      0.54            -0.5        0.04 ±102%  perf-profile.children.cycles-pp.__cond_resched
      0.46            -0.4        0.06 ± 62%  perf-profile.children.cycles-pp.rcu_do_batch
      0.40 ±  3%      -0.4        0.05 ± 41%  perf-profile.children.cycles-pp.sync_regs
      0.34 ±  2%      -0.3        0.08 ± 61%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      1.35 ±  2%      -0.3        1.10 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock
      0.28            -0.2        0.03 ±102%  perf-profile.children.cycles-pp.update_load_avg
      0.48 ±  2%      -0.2        0.27 ± 24%  perf-profile.children.cycles-pp.rcu_core
      0.30 ±  3%      -0.2        0.10 ± 52%  perf-profile.children.cycles-pp.worker_thread
      0.24 ±  3%      -0.2        0.04 ± 78%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.28 ±  3%      -0.2        0.08 ± 44%  perf-profile.children.cycles-pp.process_one_work
      0.22 ± 18%      -0.2        0.04 ± 79%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.20 ± 18%      -0.2        0.03 ±102%  perf-profile.children.cycles-pp.vfs_statx
      0.18 ± 18%      -0.1        0.04 ± 83%  perf-profile.children.cycles-pp.filename_lookup
      0.18 ± 18%      -0.1        0.04 ± 83%  perf-profile.children.cycles-pp.path_lookupat
      0.11 ±  4%      -0.1        0.03 ± 79%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.1        0.08 ± 28%  perf-profile.children.cycles-pp.evsel__read_counter
      0.00            +0.1        0.08 ± 34%  perf-profile.children.cycles-pp.__bitmap_and
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.1        0.09 ± 31%  perf-profile.children.cycles-pp.__open64_nocancel
      0.00            +0.1        0.10 ± 42%  perf-profile.children.cycles-pp._dl_addr
      0.01 ±264%      +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.setlocale
      0.12 ±  3%      +0.1        0.22 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.00            +0.1        0.11 ± 30%  perf-profile.children.cycles-pp.elf_load
      0.00            +0.1        0.11 ± 28%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.fault_in_readable
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.00            +0.1        0.12 ± 48%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.1        0.12 ± 41%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.00            +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.1        0.13 ± 38%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.13 ± 33%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.1        0.13 ± 39%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.00            +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.tick_program_event
      0.00            +0.1        0.15 ± 33%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.2        0.16 ± 22%  perf-profile.children.cycles-pp.hrtimer_forward
      0.00            +0.2        0.17 ± 32%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.19 ± 25%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.2        0.20 ± 40%  perf-profile.children.cycles-pp.read_counters
      0.00            +0.2        0.20 ± 17%  perf-profile.children.cycles-pp.path_openat
      0.00            +0.2        0.20 ± 31%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.2        0.20 ± 23%  perf-profile.children.cycles-pp.do_filp_open
      0.13 ±  3%      +0.2        0.34 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.2        0.21 ± 23%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.00            +0.2        0.21 ± 39%  perf-profile.children.cycles-pp.cmd_stat
      0.00            +0.2        0.21 ± 39%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.2        0.21 ± 39%  perf-profile.children.cycles-pp.process_interval
      0.04 ± 37%      +0.2        0.26 ± 27%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.irqentry_exit
      0.00            +0.2        0.23 ± 18%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.2        0.23 ± 64%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.2        0.24 ± 16%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.2        0.24 ± 16%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.2        0.24 ± 26%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.2        0.24 ± 15%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.2        0.24 ± 22%  perf-profile.children.cycles-pp.read
      0.00            +0.2        0.24 ± 32%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.2        0.25 ± 20%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.3        0.25 ± 20%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.3        0.26 ± 18%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.3        0.26 ± 21%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +0.3        0.27 ± 13%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.00            +0.3        0.28 ± 16%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.3        0.28 ± 14%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.3        0.28 ± 13%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.3        0.28 ± 22%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.3        0.29 ± 35%  perf-profile.children.cycles-pp.record__pushfn
      0.00            +0.3        0.29 ± 35%  perf-profile.children.cycles-pp.writen
      0.00            +0.3        0.29 ± 35%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.00            +0.3        0.29 ± 35%  perf-profile.children.cycles-pp.generic_perform_write
      0.00            +0.3        0.29 ± 27%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.3        0.29 ± 27%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.3        0.29 ± 34%  perf-profile.children.cycles-pp.__libc_write
      0.01 ±264%      +0.3        0.30 ± 32%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.3        0.29 ± 34%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.00            +0.3        0.29 ± 34%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +0.3        0.29 ± 14%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.3        0.29 ± 33%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.3        0.30 ± 27%  perf-profile.children.cycles-pp.exec_binprm
      0.00            +0.3        0.30 ± 27%  perf-profile.children.cycles-pp.search_binary_handler
      0.02 ±129%      +0.3        0.31 ± 22%  perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.3        0.30 ± 31%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.3        0.30 ± 37%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.3        0.31 ± 38%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.3        0.32 ± 22%  perf-profile.children.cycles-pp.bprm_execve
      0.00            +0.3        0.34 ± 17%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.3        0.35 ± 16%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.4        0.35 ± 29%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.4        0.35 ± 20%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.4        0.36 ± 31%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.4        0.36 ± 25%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.4        0.36 ± 30%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.4        0.37 ± 25%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.4        0.37 ±  8%  perf-profile.children.cycles-pp.irqentry_enter
      0.50 ±  3%      +0.4        0.91 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.4        0.42 ± 14%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.4        0.45 ± 23%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.5        0.46 ± 22%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.5        0.46 ± 21%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.46 ± 22%  perf-profile.children.cycles-pp.execve
      0.00            +0.5        0.46 ± 17%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.47 ±  2%      +0.5        0.94 ± 15%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.5        0.47 ± 23%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.5        0.47 ± 23%  perf-profile.children.cycles-pp.do_execveat_common
      0.03 ±100%      +0.5        0.51 ± 20%  perf-profile.children.cycles-pp.__libc_start_main
      0.03 ±100%      +0.5        0.51 ± 20%  perf-profile.children.cycles-pp.main
      0.03 ±100%      +0.5        0.51 ± 20%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.5        0.48 ± 23%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.5        0.50 ± 15%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.00            +0.5        0.51 ± 15%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.5        0.52 ± 16%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.5        0.55 ± 19%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.6        0.56 ± 11%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.03 ± 77%      +0.6        0.60 ± 18%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.10 ±  4%      +0.6        0.75 ± 14%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.52 ±  2%      +0.7        1.17 ± 14%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.09 ±  5%      +0.7        0.74 ± 17%  perf-profile.children.cycles-pp.update_blocked_averages
      0.53 ±  2%      +0.7        1.22 ± 14%  perf-profile.children.cycles-pp.find_busiest_group
      0.02 ±100%      +0.8        0.80 ± 16%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.8        0.80 ± 15%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.00            +1.0        1.01 ±  8%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +1.0        1.03 ± 14%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +1.1        1.08 ± 52%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.00            +1.1        1.13 ±  7%  perf-profile.children.cycles-pp.sched_clock
      0.00            +1.2        1.16 ±  9%  perf-profile.children.cycles-pp.native_sched_clock
      0.84 ±  2%      +1.2        2.00 ± 10%  perf-profile.children.cycles-pp.load_balance
      0.36 ±  2%      +1.2        1.55 ± 11%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +1.2        1.22 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +1.3        1.29 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +1.4        1.41 ± 22%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +1.4        1.41 ± 22%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +1.4        1.41 ± 22%  perf-profile.children.cycles-pp.start_kernel
      0.00            +1.4        1.41 ± 22%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.00            +1.4        1.41 ± 22%  perf-profile.children.cycles-pp.rest_init
      0.00            +1.4        1.44 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.00            +1.4        1.45 ± 13%  perf-profile.children.cycles-pp.perf_rotate_context
      0.00            +1.6        1.64 ± 10%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +1.7        1.66 ± 10%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +2.2        2.24 ±  9%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +2.3        2.26 ± 14%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +2.6        2.55 ± 43%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.02 ±100%      +2.8        2.86 ±  6%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +2.9        2.93 ± 75%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +3.1        3.11 ±  7%  perf-profile.children.cycles-pp.menu_select
      0.00            +3.2        3.22 ± 67%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.59            +3.7        4.34 ±  6%  perf-profile.children.cycles-pp.__do_softirq
      0.00            +4.0        4.03 ± 59%  perf-profile.children.cycles-pp.ktime_get
      0.49 ±  2%      +4.7        5.14 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.06 ±  5%      +8.9        8.94 ±  6%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.20 ±  3%     +11.8       12.04 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.20 ±  3%     +11.9       12.11 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.36           +15.9       16.21 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.43           +17.2       17.64 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.43           +17.4       17.80 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.45           +19.6       20.00 ±  3%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.50           +23.2       23.65 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.54 ±  2%     +28.3       28.87 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.55 ±  2%     +29.2       29.79 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.05           +38.8       39.90 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.08           +81.2       82.33        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.18 ±  5%     +89.0       89.23        perf-profile.children.cycles-pp.acpi_safe_halt
      0.18 ±  6%     +89.2       89.40        perf-profile.children.cycles-pp.acpi_idle_enter
      0.20 ±  4%     +90.5       90.70        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.20 ±  4%     +91.0       91.15        perf-profile.children.cycles-pp.cpuidle_enter
      0.34 ±  5%     +94.6       94.97        perf-profile.children.cycles-pp.start_secondary
      0.24 ±  5%     +95.3       95.51        perf-profile.children.cycles-pp.cpuidle_idle_call
      0.35 ±  5%     +96.0       96.38        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.35 ±  5%     +96.0       96.38        perf-profile.children.cycles-pp.cpu_startup_entry
      0.35 ±  5%     +96.0       96.38        perf-profile.children.cycles-pp.do_idle
     15.13           -15.1        0.00        perf-profile.self.cycles-pp.osq_lock
      7.78            -7.8        0.00        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      3.16 ±  4%      -3.1        0.09 ± 39%  perf-profile.self.cycles-pp.next_uptodate_folio
      1.49 ±  3%      -1.4        0.04 ±104%  perf-profile.self.cycles-pp.filemap_map_pages
      0.40 ±  3%      -0.4        0.05 ± 41%  perf-profile.self.cycles-pp.sync_regs
      0.34 ±  3%      -0.3        0.08 ± 61%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.08 ±  5%      -0.0        0.03 ± 79%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.1        0.08 ± 34%  perf-profile.self.cycles-pp.__bitmap_and
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.09 ± 31%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.11 ± 38%  perf-profile.self.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.11 ± 29%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.11 ± 38%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.1        0.12 ± 42%  perf-profile.self.cycles-pp.sched_clock
      0.00            +0.1        0.12 ± 38%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.12 ± 37%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.00            +0.1        0.13 ± 31%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.13 ± 36%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.13 ± 33%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.13 ± 32%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.tick_program_event
      0.00            +0.1        0.13 ± 23%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.1        0.13 ± 23%  perf-profile.self.cycles-pp.tick_nohz_highres_handler
      0.00            +0.1        0.14 ± 40%  perf-profile.self.cycles-pp.acpi_idle_enter
      0.00            +0.1        0.14 ± 33%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.1        0.14 ± 23%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.14 ± 40%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.2        0.16 ± 17%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.00            +0.2        0.16 ± 32%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.2        0.16 ± 39%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.2        0.17 ± 16%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.01 ±264%      +0.2        0.18 ± 22%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.18 ± 31%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.2        0.18 ± 44%  perf-profile.self.cycles-pp.timekeeping_advance
      0.00            +0.2        0.19 ± 28%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.2        0.19 ± 36%  perf-profile.self.cycles-pp.__do_softirq
      0.00            +0.2        0.20 ± 67%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.2        0.22 ± 31%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.2        0.22 ± 23%  perf-profile.self.cycles-pp.perf_rotate_context
      0.00            +0.2        0.22 ± 26%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.10 ±  3%      +0.2        0.33 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.2        0.24 ± 28%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.2        0.25 ± 30%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.2        0.25 ± 32%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.3        0.25 ± 27%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.3        0.26 ± 16%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.3        0.26 ± 17%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.00            +0.3        0.26 ± 19%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.3        0.27 ± 27%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.3        0.28 ± 26%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.3        0.29 ± 25%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.38 ±  2%      +0.3        0.68 ± 18%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.3        0.29 ± 23%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.00            +0.3        0.30 ± 45%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.3        0.30 ± 22%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.3        0.30 ± 19%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.3        0.32 ± 18%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.3        0.34 ± 21%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.3        0.34 ± 32%  perf-profile.self.cycles-pp.get_cpu_device
      0.71            +0.3        1.05 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.4        0.35 ± 27%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.4        0.36 ± 18%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.4        0.37 ± 16%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.4        0.44 ± 18%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.4        0.45 ± 22%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.5        0.46 ± 18%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.5        0.46 ± 23%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.47 ± 23%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.29 ±  2%      +0.6        0.85 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.6        0.56 ± 19%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.6        0.58 ± 10%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.6        0.61 ± 17%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.10 ±  4%      +0.6        0.75 ± 13%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.7        0.68 ± 64%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.00            +0.8        0.80 ± 15%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.00            +0.9        0.88 ± 16%  perf-profile.self.cycles-pp.menu_select
      0.00            +1.1        1.12 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.36 ±  2%      +1.2        1.55 ± 11%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +1.2        1.21 ± 12%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +1.4        1.40 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.00            +2.2        2.25 ± 14%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +2.3        2.31 ± 47%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +2.8        2.82 ± 85%  perf-profile.self.cycles-pp.ktime_get
      0.13            +3.3        3.48 ±  9%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.06 ±  5%      +8.9        8.94 ±  6%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.12 ±  4%     +46.6       46.72 ±  4%  perf-profile.self.cycles-pp.acpi_safe_halt




***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/netlink-proc/stress-ng/60s

commit: 
  059d37b718 ("net: phy: linux/phy.h: fix Excess kernel-doc description warning")
  c46bfba133 ("connector: Fix proc_event_num_listeners count not cleared")

059d37b718d38d26 c46bfba1337d301661dbb23cfd9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     89.27            +8.4%      96.77        iostat.cpu.idle
      9.69           -71.3%       2.78        iostat.cpu.system
      1.01 ±  3%     -59.2%       0.41 ±  8%  iostat.cpu.user
   6179379 ±  3%     -95.3%     292556 ± 21%  numa-numastat.node0.local_node
   6219182 ±  3%     -94.5%     339100 ± 13%  numa-numastat.node0.numa_hit
   6224770 ±  3%     -93.2%     422996 ± 13%  numa-numastat.node1.local_node
   6251192 ±  3%     -92.9%     442678 ±  9%  numa-numastat.node1.numa_hit
     89.35            +8.4%      96.85        vmstat.cpu.id
      6.89           -88.6%       0.78 ±  6%  vmstat.procs.r
     24070           -88.3%       2818 ±  8%  vmstat.system.cs
     69769            -5.7%      65793        vmstat.system.in
      0.02 ±  5%      +0.0        0.03 ± 15%  mpstat.cpu.all.iowait%
      0.86            +1.5        2.38        mpstat.cpu.all.irq%
      0.12            -0.1        0.07 ±  3%  mpstat.cpu.all.soft%
      8.95            -8.6        0.37        mpstat.cpu.all.sys%
      1.01 ±  2%      -0.6        0.40 ±  8%  mpstat.cpu.all.usr%
    469.38 ± 19%     -99.2%       3.62 ± 43%  perf-c2c.DRAM.local
      1304 ± 10%     -97.9%      27.25 ± 23%  perf-c2c.DRAM.remote
      1738 ± 10%     -96.9%      54.12 ± 15%  perf-c2c.HITM.local
      1133 ± 10%     -98.4%      18.00 ± 20%  perf-c2c.HITM.remote
      2871 ±  8%     -97.5%      72.12 ± 12%  perf-c2c.HITM.total
     43690 ± 68%     -87.7%       5370 ± 19%  sched_debug.cfs_rq:/.avg_vruntime.avg
     26078 ± 78%     -98.4%     408.16 ± 53%  sched_debug.cfs_rq:/.avg_vruntime.min
     43690 ± 68%     -87.7%       5370 ± 19%  sched_debug.cfs_rq:/.min_vruntime.avg
     26078 ± 78%     -98.4%     408.16 ± 53%  sched_debug.cfs_rq:/.min_vruntime.min
    166583 ± 94%     -97.4%       4297 ± 11%  sched_debug.cpu.avg_idle.min
     55253           -97.4%       1413        stress-ng.netlink-proc.ops
    920.84           -97.4%      23.55        stress-ng.netlink-proc.ops_per_sec
      3512           -97.2%      96.62 ±  8%  stress-ng.time.involuntary_context_switches
  14344971           -97.2%     397390 ±  2%  stress-ng.time.minor_page_faults
    579.75           -97.3%      15.75 ±  2%  stress-ng.time.percent_of_cpu_this_job_got
    288.15           -97.1%       8.21 ±  3%  stress-ng.time.system_time
     72.30 ±  2%     -97.6%       1.74 ±  4%  stress-ng.time.user_time
    634891           -97.3%      17180        stress-ng.time.voluntary_context_switches
    351.88           -84.7%      53.88 ±  2%  turbostat.Avg_MHz
     11.43            -7.5        3.97        turbostat.Busy%
      3084           -55.9%       1360 ±  2%  turbostat.Bzy_MHz
     11465 ±  2%     -16.3%       9602        turbostat.C1
    680235           -88.1%      81023 ±  9%  turbostat.C1E
      6.23            -5.6        0.68 ±  5%  turbostat.C1E%
     82.64           +13.2       95.80        turbostat.C6%
      0.15           +62.5%       0.24        turbostat.IPC
     58.12            -8.2%      53.38 ±  2%  turbostat.PkgTmp
    158.42           -21.9%     123.74        turbostat.PkgWatt
     57.90            -7.6%      53.50        turbostat.RAMWatt
     96795           -78.4%      20950 ±  2%  meminfo.Active
     89506           -84.5%      13908 ±  6%  meminfo.Active(anon)
   1009177           -65.4%     349530        meminfo.AnonPages
   1590446           -59.2%     649479        meminfo.Committed_AS
   1134660           -61.8%     433496        meminfo.Inactive
   1122208           -62.5%     421239        meminfo.Inactive(anon)
     16126 ±  3%     -10.9%      14375        meminfo.KernelStack
    165907           -36.5%     105360        meminfo.Mapped
   5318112           -16.7%    4429934        meminfo.Memused
     12261 ±  5%     -50.3%       6095        meminfo.PageTables
    205864           -57.0%      88596        meminfo.Shmem
   5629293           -14.5%    4812679 ±  2%  meminfo.max_used_kB
    394598 ± 21%     -58.2%     164970 ± 40%  numa-meminfo.node0.AnonPages
   2256635 ± 31%     -88.7%     254633 ± 52%  numa-meminfo.node0.AnonPages.max
    423034 ± 19%     -57.0%     181718 ± 41%  numa-meminfo.node0.Inactive
    415347 ± 19%     -58.1%     174072 ± 40%  numa-meminfo.node0.Inactive(anon)
      5870 ±  7%     -50.1%       2927 ± 11%  numa-meminfo.node0.PageTables
     91164 ±  3%     -83.7%      14856 ± 22%  numa-meminfo.node1.Active
     87908           -86.0%      12266 ±  9%  numa-meminfo.node1.Active(anon)
    617272 ± 15%     -70.0%     184963 ± 36%  numa-meminfo.node1.AnonPages
   3122142 ± 20%     -86.0%     435739 ± 27%  numa-meminfo.node1.AnonPages.max
    714417 ± 12%     -64.7%     252095 ± 29%  numa-meminfo.node1.Inactive
    709652 ± 12%     -65.1%     247485 ± 28%  numa-meminfo.node1.Inactive(anon)
      7546 ±  9%     -15.1%       6406 ±  3%  numa-meminfo.node1.KernelStack
      6510 ±  9%     -51.3%       3172 ±  9%  numa-meminfo.node1.PageTables
    180425 ± 16%     -58.7%      74525 ± 30%  numa-meminfo.node1.Shmem
     98799 ± 21%     -58.2%      41249 ± 40%  numa-vmstat.node0.nr_anon_pages
    104004 ± 19%     -58.2%      43523 ± 40%  numa-vmstat.node0.nr_inactive_anon
      1465 ±  7%     -50.1%     732.05 ± 11%  numa-vmstat.node0.nr_page_table_pages
    104004 ± 19%     -58.2%      43523 ± 40%  numa-vmstat.node0.nr_zone_inactive_anon
   6219196 ±  3%     -94.5%     339138 ± 13%  numa-vmstat.node0.numa_hit
   6179393 ±  3%     -95.3%     292594 ± 21%  numa-vmstat.node0.numa_local
     21922           -86.0%       3067 ±  9%  numa-vmstat.node1.nr_active_anon
    153302 ± 14%     -69.8%      46269 ± 36%  numa-vmstat.node1.nr_anon_pages
    176413 ± 11%     -64.9%      61899 ± 28%  numa-vmstat.node1.nr_inactive_anon
      7558 ±  9%     -15.2%       6406 ±  3%  numa-vmstat.node1.nr_kernel_stack
      1644 ±  9%     -51.8%     792.78 ±  9%  numa-vmstat.node1.nr_page_table_pages
     45071 ± 17%     -58.7%      18632 ± 30%  numa-vmstat.node1.nr_shmem
     21922           -86.0%       3067 ±  9%  numa-vmstat.node1.nr_zone_active_anon
    176412 ± 11%     -64.9%      61899 ± 28%  numa-vmstat.node1.nr_zone_inactive_anon
   6243377 ±  3%     -92.9%     442671 ±  9%  numa-vmstat.node1.numa_hit
   6216956 ±  3%     -93.2%     422989 ± 13%  numa-vmstat.node1.numa_local
     22377           -84.4%       3486 ±  6%  proc-vmstat.nr_active_anon
    252413           -65.4%      87402        proc-vmstat.nr_anon_pages
    787977            -3.7%     758546        proc-vmstat.nr_file_pages
    280677           -62.5%     105304        proc-vmstat.nr_inactive_anon
     16131 ±  3%     -10.9%      14374        proc-vmstat.nr_kernel_stack
     41487           -36.5%      26333        proc-vmstat.nr_mapped
      3081 ±  5%     -50.6%       1523        proc-vmstat.nr_page_table_pages
     51472           -57.0%      22151        proc-vmstat.nr_shmem
     24685            -2.0%      24183        proc-vmstat.nr_slab_reclaimable
     37640            -2.7%      36613        proc-vmstat.nr_slab_unreclaimable
     22377           -84.4%       3486 ±  6%  proc-vmstat.nr_zone_active_anon
    280677           -62.5%     105304        proc-vmstat.nr_zone_inactive_anon
    891483 ±  6%     -98.8%      10906 ± 36%  proc-vmstat.numa_hint_faults
    432525 ±  9%     -98.1%       8274 ± 60%  proc-vmstat.numa_hint_faults_local
  12470709 ±  2%     -93.7%     785652        proc-vmstat.numa_hit
  12404485 ±  2%     -94.2%     719425        proc-vmstat.numa_local
    459347 ±  9%     -99.4%       2893 ± 86%  proc-vmstat.numa_pages_migrated
   1138450 ± 12%     -96.4%      40628 ± 17%  proc-vmstat.numa_pte_updates
     67004 ±  7%     -62.6%      25091        proc-vmstat.pgactivate
  12986580 ±  2%     -93.5%     838904        proc-vmstat.pgalloc_normal
  17279401           -95.3%     819331        proc-vmstat.pgfault
  12246108 ±  3%     -93.4%     802615        proc-vmstat.pgfree
    459347 ±  9%     -99.4%       2893 ± 86%  proc-vmstat.pgmigrate_success
   1800112 ±  6%     -97.2%      50374 ±  8%  proc-vmstat.pgreuse
      3.16           -80.6%       0.61 ±  6%  perf-stat.i.MPKI
 1.898e+09           -83.3%  3.168e+08 ±  4%  perf-stat.i.branch-instructions
      0.89 ±  2%      +0.1        1.02 ±  4%  perf-stat.i.branch-miss-rate%
  17135799 ±  3%     -65.2%    5963858 ±  8%  perf-stat.i.branch-misses
     34.56           -19.0       15.52 ±  3%  perf-stat.i.cache-miss-rate%
  29396419           -94.7%    1565243 ±  3%  perf-stat.i.cache-misses
  84235895           -93.5%    5503745 ±  2%  perf-stat.i.cache-references
     24974           -89.6%       2585 ±  9%  perf-stat.i.context-switches
      2.41            -5.6%       2.28        perf-stat.i.cpi
  2.21e+10           -89.0%  2.437e+09 ±  3%  perf-stat.i.cpu-cycles
      1623 ±  2%     -90.5%     153.99 ±  2%  perf-stat.i.cpu-migrations
    806.52          +931.9%       8322 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.08 ±  3%      -0.1        0.03 ±  7%  perf-stat.i.dTLB-load-miss-rate%
   1957035 ±  2%     -94.5%     108272 ±  5%  perf-stat.i.dTLB-load-misses
 2.393e+09           -84.5%  3.718e+08 ±  3%  perf-stat.i.dTLB-loads
      0.13 ±  2%      -0.1        0.02 ±  2%  perf-stat.i.dTLB-store-miss-rate%
   1601070 ±  2%     -95.6%      69877 ±  2%  perf-stat.i.dTLB-store-misses
  1.21e+09           -87.1%  1.567e+08 ±  2%  perf-stat.i.dTLB-stores
  9.36e+09           -83.5%  1.546e+09 ±  4%  perf-stat.i.instructions
      0.43           +13.8%       0.49        perf-stat.i.ipc
      0.34           -89.0%       0.04 ±  3%  perf-stat.i.metric.GHz
    486.12           +28.7%     625.46 ±  3%  perf-stat.i.metric.K/sec
     87.09           -85.5%      12.67 ±  3%  perf-stat.i.metric.M/sec
    272812           -96.1%      10632 ±  2%  perf-stat.i.minor-faults
     91.63           -12.9       78.73 ±  3%  perf-stat.i.node-load-miss-rate%
  15176190           -96.2%     583756 ±  9%  perf-stat.i.node-load-misses
   1548480 ±  5%     -83.8%     251170 ± 14%  perf-stat.i.node-loads
     49.87           -19.8       30.07 ± 13%  perf-stat.i.node-store-miss-rate%
   5408301           -95.6%     239835 ±  9%  perf-stat.i.node-store-misses
   6125812           -93.0%     429311 ±  3%  perf-stat.i.node-stores
    272812           -96.1%      10632 ±  2%  perf-stat.i.page-faults
      3.14           -67.7%       1.01 ±  3%  perf-stat.overall.MPKI
      0.90 ±  2%      +1.0        1.88 ±  3%  perf-stat.overall.branch-miss-rate%
     34.78            -6.4       28.43 ±  2%  perf-stat.overall.cache-miss-rate%
      2.36           -33.3%       1.58        perf-stat.overall.cpi
    752.33          +106.9%       1556 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.08 ±  2%      -0.1        0.03 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.13 ±  2%      -0.1        0.04 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
      0.42           +49.9%       0.63        perf-stat.overall.ipc
     90.32           -20.4       69.93 ±  6%  perf-stat.overall.node-load-miss-rate%
     46.90           -11.1       35.83 ±  6%  perf-stat.overall.node-store-miss-rate%
 1.866e+09           -83.3%  3.123e+08 ±  4%  perf-stat.ps.branch-instructions
  16768519 ±  3%     -64.9%    5877656 ±  8%  perf-stat.ps.branch-misses
  28912651           -94.7%    1544646 ±  3%  perf-stat.ps.cache-misses
  83136724           -93.5%    5432912 ±  2%  perf-stat.ps.cache-references
     24594           -89.6%       2553 ±  9%  perf-stat.ps.context-switches
 2.175e+10           -89.0%  2.403e+09 ±  3%  perf-stat.ps.cpu-cycles
      1607 ±  2%     -90.5%     151.91        perf-stat.ps.cpu-migrations
   1936940 ±  2%     -94.5%     106844 ±  4%  perf-stat.ps.dTLB-load-misses
 2.353e+09           -84.4%  3.665e+08 ±  3%  perf-stat.ps.dTLB-loads
   1574562 ±  2%     -95.6%      68974 ±  2%  perf-stat.ps.dTLB-store-misses
  1.19e+09           -87.0%  1.544e+08 ±  2%  perf-stat.ps.dTLB-stores
 9.198e+09           -83.4%  1.524e+09 ±  4%  perf-stat.ps.instructions
    268072           -96.1%      10500        perf-stat.ps.minor-faults
  14881864           -96.1%     576947 ±  9%  perf-stat.ps.node-load-misses
   1595791 ±  3%     -84.5%     247069 ± 14%  perf-stat.ps.node-loads
   5309475           -95.5%     236982 ±  9%  perf-stat.ps.node-store-misses
   6012142           -93.0%     423311 ±  3%  perf-stat.ps.node-stores
    268072           -96.1%      10501        perf-stat.ps.page-faults
 5.783e+11           -83.6%  9.496e+10 ±  4%  perf-stat.total.instructions
      0.00 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      0.00 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.01 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.00 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.01 ±125%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.01 ±106%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.01 ± 12%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.01 ± 95%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.01 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      0.01 ±109%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.01 ±103%     -88.4%       0.00 ±173%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 15%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.00 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.01 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.01 ± 11%     +48.3%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 17%     +59.2%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±  3%     -34.2%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 46%     -92.6%       0.00 ±264%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.00 ± 15%     -94.4%       0.00 ±264%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ±121%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      0.00 ± 14%    +170.4%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ±  9%     +24.6%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 42%    +117.0%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.01 ± 29%     -37.0%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 13%     +60.0%       0.01 ± 23%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.01 ± 10%     +50.0%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01           +92.5%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 30%     +42.2%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
      0.00 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      0.01 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.06 ±129%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.00 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.03 ±225%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.06 ±142%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.01 ± 15%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.01 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.06 ±159%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.07 ±115%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      0.04 ±199%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.08 ±219%     -98.6%       0.00 ±174%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.01 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.05 ±124%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      5.41 ± 46%     -99.7%       0.02 ± 26%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.12 ±113%     -99.6%       0.00 ±264%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.01 ± 43%     -97.5%       0.00 ±264%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.04 ±134%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      0.02 ± 81%     -86.3%       0.00 ±142%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ± 41%    +116.3%       0.01 ± 10%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.07 ±210%     -87.8%       0.01 ± 37%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 30%     +42.2%       0.01 ± 19%  perf-sched.sch_delay.max.ms.schedule_timeout.transaction_kthread.kthread.ret_from_fork
     14.38 ±  2%   +1904.1%     288.29 ± 26%  perf-sched.total_wait_and_delay.average.ms
     63545           -95.4%       2891 ± 56%  perf-sched.total_wait_and_delay.count.ms
      4008 ±  9%     +21.5%       4870 ±  6%  perf-sched.total_wait_and_delay.max.ms
     14.37 ±  3%   +1904.3%     288.11 ± 26%  perf-sched.total_wait_time.average.ms
      4008 ±  9%     +21.5%       4870 ±  6%  perf-sched.total_wait_time.max.ms
     10.60 ±  4%    +116.8%      22.97 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      3.37         +7231.1%     247.13 ±  6%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     75.13 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
    366.09           -12.9%     318.85 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    483.15 ±  9%     +19.3%     576.62 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4.10 ±  3%   +1074.0%      48.14 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     74.48          +522.8%     463.81 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.88 ± 36%     -89.4%       0.62 ±111%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     28019           -99.6%     123.25 ±  3%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     28024           -99.6%     122.50 ±  3%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.00          -100.0%       0.00        perf-sched.wait_and_delay.count.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
    196.75           +14.3%     224.88 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     35.00 ± 10%     -39.6%      21.12        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1218 ±  3%     -91.7%     101.50 ±  9%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4256           -89.7%     438.38 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1000          +381.2%       4816 ±  9%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2670 ± 35%     -81.2%     502.37 ±100%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1000           +51.0%       1510 ± 33%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     75.13 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      3488 ±  8%     -69.9%       1049 ± 12%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      5.05         +8450.8%     431.87 ± 12%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.26 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     10.60 ±  4%    +116.8%      22.97 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.52 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      1.73 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      2.19 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      1.73 ± 14%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      3.36         +7212.1%     246.01 ±  5%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.18 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    365.45           -13.1%     317.69 ±  2%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    483.15 ±  9%     +19.3%     576.61 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.63 ±  2%     -21.8%       0.49 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.10 ±  3%   +1075.3%      48.13 ± 10%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±145%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     74.46          +522.9%     463.79 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.28 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      1000          +381.2%       4816 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      5.58 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      4.78 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      2670 ± 35%     -81.1%     504.97 ± 98%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.20 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      5.77 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      1000           +51.0%       1510 ± 33%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4.58 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      3488 ±  8%     -69.9%       1049 ± 12%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      5.03         +8483.5%     431.86 ± 12%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.08 ±209%     -97.9%       0.00 ±189%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     41.46           -41.5        0.00        perf-profile.calltrace.cycles-pp.__libc_fork
     39.06           -39.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
     39.06           -39.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     39.06           -39.1        0.00        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     39.05           -39.1        0.00        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
     38.26           -38.3        0.00        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.33           -36.3        0.00        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     35.35           -35.3        0.00        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     31.23           -31.1        0.14 ±173%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.23           -31.1        0.14 ±173%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.22           -31.1        0.14 ±173%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.16           -30.2        0.00        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     30.15           -30.2        0.00        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     31.28           -30.1        1.16 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.28           -30.1        1.17 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     30.08           -30.1        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     18.19           -18.2        0.00        perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
     15.25           -15.2        0.00        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
     15.16           -15.2        0.00        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
     10.13           -10.1        0.00        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      9.32            -9.3        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      9.70 ±  6%      -9.1        0.59 ± 40%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      8.66            -8.7        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      8.51            -8.5        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      8.20            -8.2        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      8.12 ±  5%      -7.9        0.23 ±130%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      8.61 ±  2%      -7.8        0.81 ± 13%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      8.14 ±  5%      -7.8        0.37 ± 80%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      8.19 ±  2%      -7.4        0.76 ± 14%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      8.18 ±  2%      -7.4        0.75 ± 14%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      7.13            -7.1        0.00        perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      7.26 ±  5%      -7.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      7.64 ±  3%      -6.9        0.69 ± 14%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.64 ±  3%      -5.5        0.14 ±173%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.00            +0.7        0.74 ±  9%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.8        0.80 ±  8%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.9        0.88 ± 24%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.9        0.91 ± 24%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.9        0.93 ± 31%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.9        0.93 ± 31%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.9        0.93 ± 31%  perf-profile.calltrace.cycles-pp.execve
      0.00            +0.9        0.93 ± 31%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.9        0.93 ± 31%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.9        0.94 ±  6%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      0.00            +1.0        1.02 ±  5%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu
      0.00            +1.1        1.07 ± 28%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +1.3        1.34 ± 11%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.4        1.36 ± 15%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.4        1.42 ± 12%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.4        1.43 ± 13%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.5        1.46 ± 15%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00            +1.5        1.46 ± 15%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.00            +1.5        1.46 ± 15%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.7        1.67 ±  5%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.8        1.78 ± 17%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.8        1.81 ± 10%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +2.0        1.97 ± 66%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +2.0        2.02 ± 11%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.0        2.03 ± 65%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.00            +2.0        2.05 ± 64%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.00            +2.0        2.05 ± 64%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.00            +2.0        2.05 ± 64%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +2.0        2.05 ± 64%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +2.0        2.05 ± 64%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +2.0        2.05 ± 64%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +2.0        2.05 ± 64%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +2.1        2.06 ± 16%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.4        2.41 ± 19%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      0.00            +2.5        2.50 ± 14%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.7        2.75 ± 11%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.02 ±  3%      +3.2        4.21 ± 16%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +3.6        3.60 ± 10%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.11 ±  3%      +3.8        4.94 ± 13%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.06 ±264%      +9.5        9.56 ±  9%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      0.78 ±  7%     +13.4       14.22 ±  7%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.76 ±  6%     +14.0       14.71 ±  7%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler
      1.51 ±  4%     +17.8       19.27 ±  5%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      1.72 ±  3%     +19.2       20.95 ±  4%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      1.73 ±  4%     +19.4       21.16 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.97 ±  5%     +21.1       23.08 ±  5%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      2.27 ±  4%     +25.4       27.62 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.52 ±  4%     +30.5       33.06 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      2.53 ±  4%     +30.7       33.19 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.25           +31.1       35.39 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.00 ±  5%     +37.0       41.00 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.28 ±  4%     +43.4       47.69 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      8.92           +76.3       85.25        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.63           +77.0       85.64        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      9.27           +80.8       90.05        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      9.80           +81.1       90.86        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      9.82           +81.3       91.08        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      9.82           +81.3       91.08        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      9.98           +83.1       93.13        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     72.53           -69.0        3.52 ± 13%  perf-profile.children.cycles-pp.do_syscall_64
     72.54           -69.0        3.54 ± 13%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     41.61           -41.5        0.16 ± 37%  perf-profile.children.cycles-pp.__libc_fork
     39.06           -38.9        0.12 ± 44%  perf-profile.children.cycles-pp.__do_sys_clone
     39.06           -38.8        0.24 ± 27%  perf-profile.children.cycles-pp.kernel_clone
     38.26           -38.1        0.18 ± 23%  perf-profile.children.cycles-pp.copy_process
     36.33           -36.3        0.08 ± 64%  perf-profile.children.cycles-pp.dup_mm
     35.44           -35.4        0.08 ± 62%  perf-profile.children.cycles-pp.dup_mmap
     31.69           -31.2        0.49 ± 12%  perf-profile.children.cycles-pp.__x64_sys_exit_group
     31.69           -31.2        0.49 ± 12%  perf-profile.children.cycles-pp.do_group_exit
     31.67           -31.2        0.49 ± 13%  perf-profile.children.cycles-pp.do_exit
     30.20           -29.8        0.38 ± 12%  perf-profile.children.cycles-pp.exit_mm
     30.16           -29.7        0.50 ± 12%  perf-profile.children.cycles-pp.__mmput
     30.10           -29.6        0.50 ± 12%  perf-profile.children.cycles-pp.exit_mmap
     18.20           -18.2        0.00        perf-profile.children.cycles-pp.anon_vma_fork
     15.26           -15.3        0.00        perf-profile.children.cycles-pp.anon_vma_clone
     15.18           -15.1        0.12 ± 29%  perf-profile.children.cycles-pp.free_pgtables
     15.55 ±  2%     -14.3        1.20 ± 15%  perf-profile.children.cycles-pp.asm_exc_page_fault
     14.40 ±  2%     -13.3        1.12 ± 15%  perf-profile.children.cycles-pp.exc_page_fault
     14.36 ±  2%     -13.2        1.12 ± 15%  perf-profile.children.cycles-pp.do_user_addr_fault
     13.17 ±  2%     -12.1        1.06 ± 17%  perf-profile.children.cycles-pp.handle_mm_fault
     12.96 ±  2%     -11.9        1.03 ± 17%  perf-profile.children.cycles-pp.__handle_mm_fault
     11.49 ±  3%     -10.7        0.77 ± 23%  perf-profile.children.cycles-pp.do_read_fault
     11.50 ±  3%     -10.7        0.82 ± 21%  perf-profile.children.cycles-pp.do_fault
     11.28 ±  3%     -10.6        0.73 ± 21%  perf-profile.children.cycles-pp.filemap_map_pages
     10.15           -10.1        0.02 ±175%  perf-profile.children.cycles-pp.unlink_anon_vmas
      9.34            -9.1        0.28 ± 21%  perf-profile.children.cycles-pp.unmap_vmas
      8.67            -8.4        0.24 ± 23%  perf-profile.children.cycles-pp.unmap_page_range
      8.98 ±  3%      -8.4        0.62 ± 25%  perf-profile.children.cycles-pp.next_uptodate_folio
      8.52            -8.3        0.23 ± 25%  perf-profile.children.cycles-pp.zap_pmd_range
      8.38            -8.2        0.23 ± 25%  perf-profile.children.cycles-pp.zap_pte_range
      7.68 ±  2%      -7.6        0.05 ± 91%  perf-profile.children.cycles-pp.down_write
      7.16            -7.2        0.00        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      4.77 ±  2%      -4.7        0.06 ± 88%  perf-profile.children.cycles-pp._compound_head
      4.50            -4.5        0.05 ± 80%  perf-profile.children.cycles-pp.__slab_free
      2.74            -2.6        0.12 ± 28%  perf-profile.children.cycles-pp.kmem_cache_alloc
      2.46            -2.4        0.07 ± 65%  perf-profile.children.cycles-pp.tlb_finish_mmu
      2.43            -2.4        0.05 ± 78%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      2.28            -2.2        0.05 ± 60%  perf-profile.children.cycles-pp.page_remove_rmap
      2.28            -2.2        0.12 ± 41%  perf-profile.children.cycles-pp.kmem_cache_free
      1.59 ±  2%      -1.5        0.05 ± 87%  perf-profile.children.cycles-pp.release_pages
      1.22 ±  2%      -1.2        0.04 ±105%  perf-profile.children.cycles-pp.mod_objcg_state
      1.05 ±  4%      -1.0        0.08 ± 47%  perf-profile.children.cycles-pp.alloc_pages_mpol
      1.01 ±  4%      -1.0        0.06 ± 67%  perf-profile.children.cycles-pp.wp_page_copy
      1.00 ±  5%      -0.9        0.07 ± 44%  perf-profile.children.cycles-pp.__alloc_pages
      0.96 ±  2%      -0.9        0.04 ±106%  perf-profile.children.cycles-pp.wait4
      0.84 ±  3%      -0.8        0.04 ±104%  perf-profile.children.cycles-pp.mm_init
      0.81 ±  2%      -0.8        0.03 ±104%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.82 ±  2%      -0.8        0.06 ± 69%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.75 ±  3%      -0.7        0.05 ± 84%  perf-profile.children.cycles-pp.dup_task_struct
      0.74 ±  2%      -0.7        0.05 ± 62%  perf-profile.children.cycles-pp.mas_split
      0.74 ±  3%      -0.7        0.06 ±122%  perf-profile.children.cycles-pp.__cond_resched
      0.66 ±  7%      -0.6        0.03 ±101%  perf-profile.children.cycles-pp.pte_alloc_one
      0.59 ±  5%      -0.6        0.03 ±101%  perf-profile.children.cycles-pp.finish_task_switch
      0.81 ±  3%      -0.5        0.26 ± 22%  perf-profile.children.cycles-pp.__schedule
      0.61 ±  5%      -0.5        0.10 ± 19%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.58 ±  6%      -0.5        0.08 ± 32%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.48 ±  4%      -0.4        0.04 ± 80%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.49 ±  5%      -0.4        0.07 ± 31%  perf-profile.children.cycles-pp.find_idlest_group
      0.48 ±  5%      -0.4        0.06 ± 52%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.45 ±  7%      -0.4        0.05 ± 80%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.42 ±  2%      -0.4        0.05 ± 60%  perf-profile.children.cycles-pp.sync_regs
      0.47 ±  4%      -0.4        0.11 ± 42%  perf-profile.children.cycles-pp.rcu_do_batch
      0.57 ±  4%      -0.4        0.21 ± 34%  perf-profile.children.cycles-pp.rcu_core
      0.46 ±  3%      -0.3        0.15 ± 17%  perf-profile.children.cycles-pp.schedule
      0.34 ±  4%      -0.3        0.04 ±107%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.29 ±  4%      -0.2        0.05 ± 78%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.26 ±  9%      -0.2        0.06 ± 93%  perf-profile.children.cycles-pp.update_load_avg
      0.27 ±  5%      -0.2        0.08 ± 49%  perf-profile.children.cycles-pp.schedule_idle
      0.41 ±  7%      -0.2        0.22 ± 34%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.21 ±  5%      -0.2        0.04 ± 79%  perf-profile.children.cycles-pp.clear_page_erms
      0.20 ± 10%      -0.2        0.05 ±121%  perf-profile.children.cycles-pp.activate_task
      0.24 ±  5%      -0.1        0.09 ± 50%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.20 ±  9%      -0.1        0.05 ±108%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.18 ±  4%      -0.1        0.04 ± 80%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.24 ±  4%      -0.1        0.11 ± 42%  perf-profile.children.cycles-pp.newidle_balance
      0.17 ± 10%      -0.1        0.05 ±112%  perf-profile.children.cycles-pp.enqueue_entity
      0.13 ± 20%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.cmd_record
      0.13 ± 20%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.__cmd_record
      0.14 ±  5%      -0.1        0.04 ± 83%  perf-profile.children.cycles-pp._find_next_bit
      0.13 ±  4%      -0.1        0.06 ± 60%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.12 ±  5%      -0.1        0.06 ± 60%  perf-profile.children.cycles-pp.__wake_up_common
      0.06 ± 12%      +0.1        0.13 ± 29%  perf-profile.children.cycles-pp.cpu_util
      0.01 ±264%      +0.1        0.09 ± 29%  perf-profile.children.cycles-pp.do_anonymous_page
      0.00            +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.strnlen_user
      0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.evsel__read_counter
      0.00            +0.1        0.11 ± 16%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.12 ± 34%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.00            +0.1        0.12 ± 39%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.12 ± 36%  perf-profile.children.cycles-pp.__libc_read
      0.00            +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.pipe_read
      0.00            +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.irqentry_exit
      0.00            +0.1        0.12 ± 21%  perf-profile.children.cycles-pp.__bitmap_and
      0.00            +0.1        0.12 ± 63%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.12 ± 47%  perf-profile.children.cycles-pp.__open64_nocancel
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.13 ± 34%  perf-profile.children.cycles-pp.readn
      0.00            +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.copy_strings
      0.00            +0.1        0.13 ± 32%  perf-profile.children.cycles-pp.walk_component
      0.00            +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.14 ± 33%  perf-profile.children.cycles-pp.pipe_write
      0.00            +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.__vfork
      0.00            +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.intel_idle_irq
      0.00            +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.14 ± 38%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.exec_mmap
      0.00            +0.1        0.14 ± 58%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.1        0.15 ± 29%  perf-profile.children.cycles-pp.__split_vma
      0.00            +0.2        0.15 ± 50%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.2        0.15 ± 50%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.2        0.15 ± 24%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.2        0.15 ± 36%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.04 ± 79%      +0.2        0.19 ± 28%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.09 ± 11%      +0.2        0.24 ± 29%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.2        0.16 ± 33%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.2        0.16 ± 22%  perf-profile.children.cycles-pp.tick_program_event
      0.00            +0.2        0.16 ± 38%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.2        0.16 ± 34%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.2        0.16 ± 43%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.2        0.17 ± 32%  perf-profile.children.cycles-pp.write
      0.00            +0.2        0.17 ± 22%  perf-profile.children.cycles-pp.begin_new_exec
      0.05 ± 38%      +0.2        0.22 ± 37%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.2        0.18 ± 30%  perf-profile.children.cycles-pp._dl_addr
      0.00            +0.2        0.18 ± 33%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.00            +0.2        0.18 ± 29%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.2        0.18 ± 24%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.18 ± 13%      +0.2        0.37 ± 18%  perf-profile.children.cycles-pp.__libc_start_main
      0.18 ± 13%      +0.2        0.37 ± 18%  perf-profile.children.cycles-pp.main
      0.18 ± 13%      +0.2        0.37 ± 18%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.2        0.19 ± 34%  perf-profile.children.cycles-pp.hrtimer_forward
      0.00            +0.2        0.19 ± 26%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.00            +0.2        0.19 ± 20%  perf-profile.children.cycles-pp.rb_erase
      0.09 ± 11%      +0.2        0.30 ± 21%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.2        0.22 ± 30%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.00            +0.2        0.22 ± 23%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.2        0.24 ± 28%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.01 ±174%      +0.3        0.27 ± 27%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.3        0.26 ± 29%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      0.01 ±173%      +0.3        0.28 ± 22%  perf-profile.children.cycles-pp.read_counters
      0.00            +0.3        0.27 ± 33%  perf-profile.children.cycles-pp._find_next_and_bit
      0.03 ± 77%      +0.3        0.31 ± 28%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.3        0.28 ± 29%  perf-profile.children.cycles-pp.collapse_huge_page
      0.00            +0.3        0.28 ± 43%  perf-profile.children.cycles-pp.path_openat
      0.00            +0.3        0.29 ± 42%  perf-profile.children.cycles-pp.do_filp_open
      0.00            +0.3        0.29 ± 29%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.00            +0.3        0.29 ± 29%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.00            +0.3        0.29 ± 17%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.3        0.30 ± 14%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.3        0.30 ± 29%  perf-profile.children.cycles-pp.khugepaged
      0.02 ±100%      +0.3        0.32 ± 18%  perf-profile.children.cycles-pp.cmd_stat
      0.02 ±100%      +0.3        0.32 ± 18%  perf-profile.children.cycles-pp.dispatch_events
      0.02 ±100%      +0.3        0.32 ± 18%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.3        0.30 ± 40%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.3        0.31 ± 38%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.04 ± 83%      +0.3        0.37 ± 46%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.3        0.32 ± 18%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.08 ± 10%      +0.3        0.41 ± 20%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.3        0.34 ± 17%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.04 ± 58%      +0.4        0.40 ± 22%  perf-profile.children.cycles-pp.ct_idle_exit
      0.05 ± 39%      +0.4        0.41 ± 18%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.4        0.36 ± 25%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.4        0.36 ± 19%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.4        0.38 ± 21%  perf-profile.children.cycles-pp.mmap_region
      0.58 ±  3%      +0.4        0.96 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.4        0.40 ± 18%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.4        0.41 ± 21%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.4        0.42 ± 12%  perf-profile.children.cycles-pp.read
      0.03 ± 77%      +0.4        0.46 ±  9%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.4        0.43 ± 23%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.10 ±  6%      +0.4        0.54 ± 22%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.04 ± 57%      +0.5        0.49 ±  9%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.5        0.46 ± 17%  perf-profile.children.cycles-pp.get_cpu_device
      0.01 ±264%      +0.5        0.47 ± 23%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.5        0.47 ± 18%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.22 ±  8%      +0.5        0.69 ± 43%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.5        0.48 ± 53%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.5        0.50 ± 24%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.03 ±100%      +0.5        0.53 ± 18%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.01 ±173%      +0.5        0.52 ± 18%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.5        0.51 ± 20%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.01 ±173%      +0.5        0.53 ± 19%  perf-profile.children.cycles-pp.exec_binprm
      0.01 ±173%      +0.5        0.53 ± 19%  perf-profile.children.cycles-pp.search_binary_handler
      0.18 ±  8%      +0.5        0.70 ± 16%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.01 ±173%      +0.5        0.54 ± 15%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.5        0.55 ± 17%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.6        0.55 ± 19%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.27 ±  4%      +0.6        0.84 ± 11%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.6        0.62 ± 13%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.01 ±264%      +0.7        0.66 ± 15%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.14 ±  8%      +0.7        0.80 ±  8%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.commit_tail
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.memcpy_toio
      0.03 ±100%      +0.7        0.70 ± 45%  perf-profile.children.cycles-pp.bprm_execve
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.00            +0.7        0.67 ± 27%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.14 ±  8%      +0.7        0.83 ±  7%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.19 ±  8%      +0.7        0.91 ± 24%  perf-profile.children.cycles-pp.worker_thread
      0.15 ± 11%      +0.7        0.88 ± 24%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.8        0.76 ± 25%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.00            +0.8        0.76 ± 25%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      0.30 ±  3%      +0.8        1.07 ±  6%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.30 ±  4%      +0.8        1.15 ±  6%  perf-profile.children.cycles-pp.find_busiest_group
      0.06 ± 10%      +0.9        0.93 ± 31%  perf-profile.children.cycles-pp.execve
      0.06 ± 10%      +0.9        0.93 ± 31%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.06 ± 10%      +0.9        0.93 ± 31%  perf-profile.children.cycles-pp.do_execveat_common
      0.18 ± 41%      +0.9        1.10 ± 31%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.07 ±  9%      +1.0        1.05 ± 12%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.06 ±  9%      +1.1        1.13 ± 27%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.29 ± 25%      +1.1        1.41 ± 14%  perf-profile.children.cycles-pp.tick_irq_enter
      0.29 ± 25%      +1.2        1.46 ± 13%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.09 ±  6%      +1.2        1.28 ±  9%  perf-profile.children.cycles-pp.sched_clock
      0.26 ±  5%      +1.2        1.46 ± 15%  perf-profile.children.cycles-pp.kthread
      0.46 ±  3%      +1.4        1.83 ±  6%  perf-profile.children.cycles-pp.load_balance
      0.10 ± 16%      +1.4        1.48 ± 11%  perf-profile.children.cycles-pp.read_tsc
      0.10 ±  4%      +1.4        1.50 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.08 ±  9%      +1.4        1.52 ± 10%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ±  6%      +1.5        1.57 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.44 ±  3%      +1.5        1.95 ±  9%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.09 ± 11%      +1.8        1.86 ± 16%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.10 ± 19%      +1.8        1.88 ± 10%  perf-profile.children.cycles-pp.perf_rotate_context
      0.17 ± 18%      +1.9        2.05 ± 64%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.17 ± 18%      +1.9        2.05 ± 64%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.17 ± 18%      +1.9        2.05 ± 64%  perf-profile.children.cycles-pp.start_kernel
      0.17 ± 18%      +1.9        2.05 ± 64%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.17 ± 18%      +1.9        2.05 ± 64%  perf-profile.children.cycles-pp.rest_init
      0.11 ±  5%      +2.0        2.07 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      0.12 ± 23%      +2.0        2.10 ± 15%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.40 ±  4%      +2.2        2.56 ± 13%  perf-profile.children.cycles-pp.rebalance_domains
      0.37 ± 21%      +2.3        2.62 ± 23%  perf-profile.children.cycles-pp.ktime_get
      0.16 ± 19%      +2.3        2.46 ± 19%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.17 ± 11%      +2.7        2.86 ± 11%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      1.17 ±  3%      +3.1        4.30 ± 15%  perf-profile.children.cycles-pp.__do_softirq
      0.26 ±  2%      +3.4        3.70 ±  9%  perf-profile.children.cycles-pp.menu_select
      1.27 ±  3%      +3.8        5.08 ± 12%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.55 ±  8%     +10.6       11.17 ±  8%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.90 ±  6%     +14.0       14.85 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.91 ±  5%     +14.1       14.96 ±  7%  perf-profile.children.cycles-pp.perf_event_task_tick
      1.79 ±  4%     +17.9       19.69 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      2.06 ±  3%     +19.3       21.34 ±  4%  perf-profile.children.cycles-pp.update_process_times
      2.08 ±  3%     +19.4       21.51 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      2.33 ±  5%     +21.1       23.39 ±  5%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      2.67 ±  4%     +25.3       28.00 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.96 ±  4%     +30.4       33.39 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.97 ±  4%     +30.5       33.48 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      4.32           +31.3       35.60 ±  2%  perf-profile.children.cycles-pp.intel_idle
      4.60 ±  4%     +36.7       41.33 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.94 ±  4%     +40.1       44.99 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      9.05           +77.8       86.90        perf-profile.children.cycles-pp.cpuidle_enter_state
      9.07           +78.2       87.24        perf-profile.children.cycles-pp.cpuidle_enter
      9.82           +81.3       91.08        perf-profile.children.cycles-pp.start_secondary
      9.43           +82.8       92.19        perf-profile.children.cycles-pp.cpuidle_idle_call
      9.98           +83.1       93.12        perf-profile.children.cycles-pp.do_idle
      9.98           +83.1       93.13        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      9.98           +83.1       93.13        perf-profile.children.cycles-pp.cpu_startup_entry
      8.81 ±  3%      -8.2        0.60 ± 25%  perf-profile.self.cycles-pp.next_uptodate_folio
      7.11            -7.1        0.00        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      4.66 ±  2%      -4.6        0.06 ± 88%  perf-profile.self.cycles-pp._compound_head
      4.46            -4.4        0.05 ± 80%  perf-profile.self.cycles-pp.__slab_free
      2.24 ±  5%      -2.2        0.05 ± 91%  perf-profile.self.cycles-pp.zap_pte_range
      2.23            -2.2        0.04 ± 80%  perf-profile.self.cycles-pp.page_remove_rmap
      1.33 ±  4%      -1.3        0.06 ± 71%  perf-profile.self.cycles-pp.filemap_map_pages
      1.33 ±  2%      -1.3        0.07 ± 61%  perf-profile.self.cycles-pp.kmem_cache_free
      0.73 ±  3%      -0.7        0.06 ± 40%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.44 ±  5%      -0.4        0.06 ± 52%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.42 ±  2%      -0.4        0.05 ± 60%  perf-profile.self.cycles-pp.sync_regs
      0.41 ±  6%      -0.2        0.22 ± 34%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.20 ±  6%      -0.2        0.04 ± 79%  perf-profile.self.cycles-pp.clear_page_erms
      0.05 ± 43%      +0.1        0.12 ± 26%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.07 ± 31%  perf-profile.self.cycles-pp.find_busiest_group
      0.00            +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.ct_idle_exit
      0.00            +0.1        0.09 ± 50%  perf-profile.self.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.09 ± 38%  perf-profile.self.cycles-pp.strnlen_user
      0.01 ±264%      +0.1        0.11 ± 42%  perf-profile.self.cycles-pp.cpu_util
      0.00            +0.1        0.10 ± 53%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.10 ± 49%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.11 ± 27%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.11 ± 39%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.__bitmap_and
      0.00            +0.1        0.12 ± 36%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.12 ± 52%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.13 ± 42%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.1        0.13 ± 41%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.13 ± 45%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.03 ±100%      +0.1        0.16 ± 40%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.1        0.13 ± 44%  perf-profile.self.cycles-pp.intel_idle_irq
      0.00            +0.1        0.14 ± 30%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.14 ± 23%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.14 ± 39%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.1        0.14 ± 27%  perf-profile.self.cycles-pp.tick_program_event
      0.00            +0.1        0.14 ± 30%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.03 ± 78%      +0.1        0.17 ± 26%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.1        0.14 ± 32%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.15 ± 22%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.15 ± 34%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.2        0.15 ± 36%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.2        0.16 ± 18%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.2        0.16 ± 38%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.2        0.16 ± 34%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.00            +0.2        0.16 ± 31%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.16 ± 26%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.2        0.16 ± 29%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.05 ± 39%      +0.2        0.21 ± 18%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.2        0.18 ± 54%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.18 ± 33%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.2        0.20 ± 32%  perf-profile.self.cycles-pp.__do_softirq
      0.09 ± 11%      +0.2        0.29 ± 21%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.2        0.23 ± 30%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.00            +0.2        0.24 ± 27%  perf-profile.self.cycles-pp.timerqueue_add
      0.01 ±174%      +0.2        0.26 ± 26%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.3        0.25 ± 20%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.3        0.26 ± 32%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.3        0.28 ± 33%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.3        0.28 ± 19%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.3        0.29 ± 24%  perf-profile.self.cycles-pp.perf_rotate_context
      0.00            +0.3        0.30 ± 17%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.04 ± 83%      +0.3        0.35 ± 49%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.3        0.32 ± 31%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.3        0.33 ± 34%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.01 ±264%      +0.3        0.34 ± 14%  perf-profile.self.cycles-pp.scheduler_tick
      0.22 ±  4%      +0.4        0.58 ± 20%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.22 ±  6%      +0.4        0.60 ± 27%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.53 ±  3%      +0.4        0.93 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.4        0.40 ± 18%  perf-profile.self.cycles-pp.tick_irq_enter
      0.00            +0.4        0.41 ± 25%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.01 ±174%      +0.4        0.44 ± 33%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.4        0.44 ± 18%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.4        0.44 ± 21%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.5        0.46 ± 16%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.03 ±100%      +0.5        0.52 ± 18%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.5        0.50 ±  9%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.01 ±264%      +0.5        0.53 ± 27%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.06 ± 12%      +0.6        0.63 ± 20%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.6        0.60 ± 28%  perf-profile.self.cycles-pp.memcpy_toio
      0.16 ± 45%      +0.8        0.93 ± 38%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.12 ±  6%      +1.0        1.11 ± 10%  perf-profile.self.cycles-pp.menu_select
      0.29 ± 27%      +1.1        1.37 ± 48%  perf-profile.self.cycles-pp.ktime_get
      0.09 ± 15%      +1.3        1.44 ± 12%  perf-profile.self.cycles-pp.read_tsc
      0.11 ±  5%      +1.4        1.50 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
      0.08 ±  9%      +1.4        1.51 ± 10%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.44 ±  3%      +1.5        1.95 ±  9%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ± 25%      +1.7        1.84 ± 17%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.15 ± 18%      +2.3        2.44 ± 19%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.30 ±  6%      +3.8        4.14 ±  6%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.34 ±  5%      +4.2        4.58 ±  6%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.55 ±  8%     +10.6       11.17 ±  8%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      4.32           +31.3       35.58 ±  2%  perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


