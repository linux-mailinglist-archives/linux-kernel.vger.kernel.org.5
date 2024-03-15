Return-Path: <linux-kernel+bounces-104015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252287C7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD0C28306E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D1D52F;
	Fri, 15 Mar 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cdd87GA8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50722D272;
	Fri, 15 Mar 2024 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472662; cv=fail; b=Au6+b4oPNv7f5PrYyOVb78v0kje4m6dvihzXEbBrKTQFa18+BwSK2yEsrO8dTT5m2nvWxSLTLw2cgl1BDUA4t2mC7q2Aw50JeTGYWgh4ajer6gwfGbSUjC12uHTVGZ+6Itpa0bef7GY+FN7cX1xWCaEGAlsr/2YmGQNQWfUUmkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472662; c=relaxed/simple;
	bh=VZunPgnxvPVqRM8T0YWibqeh3vnR+vwN4Kmrha/lWSA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WDP2U/FJCtQ8SDm+J5ih/dmUPPTyARTtxdLvyyyxeSuxGhLa5zXNNCaGwzVv44dzH1Py8JEgYCaKgohRezk6nO34nRjRh8mruvLdZC3Ze8bprp5+46TTiYOBaUwXrD68GW9yLkyJod1vh04m+cD1vRyPMuJH7lyVO/vplLi4z1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cdd87GA8; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710472661; x=1742008661;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=VZunPgnxvPVqRM8T0YWibqeh3vnR+vwN4Kmrha/lWSA=;
  b=Cdd87GA8lfOo2X+xpUhQQebALkK/ijmkkmWK5oAw9n5qua8DnP6BtFYi
   cJburIYgW7kJQwqwuw9DW70UrZXLuJD2m0DSRHo6DKQ4OHQ+QmBgWVmrO
   e5N4HwumFXKT/mBHJOtVJ71Ocu02PHO8Ecq2iHQnP5m78YumYARGUvrJB
   Q6WakRhfXLU8MmKzPIqc8k3jUPpdiF4nba2o/eDeJU0w8L8hqXP+CGluo
   dz42oQHISgk1UJKCf570TKItnM73/dNiezuQc1cw9cCE8s0yg7cdoDXYo
   okJQtG81SKx5YOwRrr8SnUDbc/wASsZffn52OcYasmNVy9JWyIRGAPGgk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16781604"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="16781604"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 20:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="43421713"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 20:17:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 20:17:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 20:17:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 20:17:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXRFCqXoYpas9S7Kuj3R6MAhh8a48b4RI0XWaTzI3lr5AvDE3/U5bUvPnduUDZqXdlmRt1y14SPVG030mmzL2dGwqmkeWxK6XBqcXAQAOWrLDfpqtA3+5sOqKhnPJtqnQl6zY3CO04JnjJYd3cSrsXGTprq+qy+D2h91eJQx8YSDRaBql3LJlm385lPzguq696llRU9zrboGd0/4v7Kv3KWcAqsIsJ2BZJFCQoJ7PAY1Kfo1vSGLACBTygETZjUzKo66Z/Lh/aF7tXEQUS2gD3AjSdu/Wdsc5kLYmKl+SV09AT9U0GwAkUSYHOYWTJWk3U09kEjyBmgvhxVo/O5b4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgA+zcxyPTJ5k3RxxDItHn09LGjMxVpxrQladjh1ljU=;
 b=cBnrdyC62F2T1DMtph6bOaOYU40cP0d4IregjF073j1Gh5KipQ3qiRpoHZcioM/kTgi17FnBu+/aeucknZYUWHrxwavPi9zsqPhjA00skHINrhEULBuocvB4D0IGi8U+AttXxwXaRLWaiPLlgDr0xQhMyg6lAlYhlP8uGUBzcU/rAeJm0viNnW3V6BLm3G6QIhHN8q/telpRZMMrpVgjJwAk4sjo8t+gMd7vsvrw9svuUfwlL3U6zA98XZxj4uZvyo1CJZkXRHkVpPJrDuylkE1BmmLuBs+l2Dmavtiy8HmYvbZlHMyrQsS4cgVDFMTz742D+mC1o7oLLD4mJJGvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.13; Fri, 15 Mar
 2024 03:17:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 03:17:35 +0000
Date: Fri, 15 Mar 2024 11:17:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [af_unix]  d9f21b3613:  stress-ng.sockfd.ops_per_sec
 9.1% improvement
Message-ID: <202403151041.2a9a00df-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4686:EE_
X-MS-Office365-Filtering-Correlation-Id: a504e422-dfd9-4be6-82ce-08dc449e7592
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouauNtsDYbc6l6ioFI9kMB5/07uY0nSv4L+elHnLEh/jdN+QLv0jutObJ3QEWH5+YMwHMltXMXHsKc7egcDFsF1rEHs54TJVfBzeu77tx0qMF+050hbqxOAE2DqHZI3I0OOhue9e4MUrJAmpiMGdNIDl39kMKiYWkIHGs7rfbdAtoa+nhMVt4C505nHjJjNZ2DtrFUPMUhX1nqVl67GrCXO8dFcLTRGGgqzh6oWKT8KkjoVv0XsMwhUPl6Q7SLhdJJjhbH3xREpif04QXhhxfZYwpQWM4GET3hlx0u8Oz1yG0C2JkNWNNJ4zpCkSN6LWP1p9qJNhEpbg5hbwd+8LfvEWrSy/35FOhCq9WozPXzmCpt/0J0LwxWPbTEYF3pWXcMHKEFQgA6Fl5dGrSQ4dGhS61WvLVdpw+/y5F0eQ6H4ehNuffEBcJlNY5X5EpkBSBWkqJ5WCmWGYdAipwioHu0VPgTDoXrqkwWQ/O48JGfvkh46vZCo8x2nK0xRTKunV1d7dF7uW8HWMYrLfDcnC6hxWZP6XuBQLLejE1AzVJMmQJMI6u8MXBuTwk/cO5tPv2y4tFUNt3OWtV/7G5nxjSwOgrQ0DQlzhTu12yBucfEunGHN+hgWQ4Y0vBmO//5Z/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+bnufICtzBzTTUyojnuLmwoZ13h09ejJTrXvcN0e3A5YeE/Jtwid/7rNEi?=
 =?iso-8859-1?Q?6HYYIXpztaUa4lz3R2NxoBfdT0sAOPqnrzXOlL9EsEFy/eotLxAhfsfx0W?=
 =?iso-8859-1?Q?f0MEcxuUdbAVW9YMIgZzTypwa3oW3WHrv55zTDGzIm2NPebOh1uK548n+6?=
 =?iso-8859-1?Q?bOvkP+VyYxraZfPTuZ7anidx8BqdT/rzhyA9PEEkWlZesy4sY+D6Xb7j7V?=
 =?iso-8859-1?Q?mTesqwFXUun+JeDWtdGwhSzPvUziCBIeeArQDCBVGGleTYs1q+C1fLfTYe?=
 =?iso-8859-1?Q?Fdt/1cnsyugjnUKM3HH09CrBBhczt2hZ1OKtOD3uzg4acOnSlvo0Semaay?=
 =?iso-8859-1?Q?+kUkAJD9MqkQt1ceqemA29nxQV5MIffAdM1M3fAKnuHUxEKGRFE1HnpeR6?=
 =?iso-8859-1?Q?Ky9pjjz24kc1Fn7RRyhr3HJuyXuVbpZteWTZyR3q5QIaOIfJLxLYnJNGMg?=
 =?iso-8859-1?Q?MlJyki1SpxFmycKISArAiUPuq+bRQiIBr8doYaw/JGzp1qEozMDyZHB9tM?=
 =?iso-8859-1?Q?44/bDertFOK7GZahwkJjZF/zpNUTWewuxcAPXW9NTG8XL1cj11Z7ZLClvw?=
 =?iso-8859-1?Q?qM/c983mQBauAM/xDuH823BFXoQ8vVHeMVPpy0ILokbxQ/hDZFgL92CCw3?=
 =?iso-8859-1?Q?q2pzNSVseekhCM+215p6Tw54cermcXuWAcNzZd1Eg5uUzdzjrqjEpQRXKv?=
 =?iso-8859-1?Q?yXoLLb5HnDkjieAkpqnJEA3shTHamYgVT8HWh+Nf5xpq+Iyv6dN3vgKfjt?=
 =?iso-8859-1?Q?GgrgqbmDkRHx88SqTVH7fjG0PIuOpFmxXp1qm78E2QBv7VeBUp81pXPWqV?=
 =?iso-8859-1?Q?nJ2EbxOjcgOCKRA8egqIN4b4vm1q6mtoe8w/rqoH1Jsn+WZtFi4kSaLASj?=
 =?iso-8859-1?Q?bDtz4ohzZ20vKIJZMFFztG4AbFeFwPvG61zMSUiijAkCykQYGl5GHx5RhB?=
 =?iso-8859-1?Q?w6AAYmNcb0tYChbm5/awXZENNYJuPCPFiNcpL6Nd8o0oNhT+0l/sI9SAa0?=
 =?iso-8859-1?Q?4/N1p6mh0ZUGTXbTQVe0sT2Ukh4ROEk+WcsESMZv5MEFhwRyCwAJS31Ogk?=
 =?iso-8859-1?Q?RaHhhnz0kslwNsIRgEUoftboDGBLB4OrtCbRLNBld6V6CYePNwnC2zZ/x0?=
 =?iso-8859-1?Q?v0fUNHnGM1qthg8+7SnYTyb8PecLk9YEG+8EJ7w6E9vBRrkjURFL//5GkM?=
 =?iso-8859-1?Q?OUiX8yaip7cesh4syqvUVRpd2E36Cigq4Nb/81Lc405YDxPBiESAUSyGBd?=
 =?iso-8859-1?Q?4SXuw+r2Ia7IbZEqiLoBU0KS54V8joDSr6kLrG+iWZw2oS75NLQKfPoQqW?=
 =?iso-8859-1?Q?GO92aTWM7n8tA+LEWde3M3cEs+iAQ05AC19a2vzmTGrGL90PWh/LWUdJUz?=
 =?iso-8859-1?Q?s/Uga5Z2+xCEFnvHuBnSSG79YSWEmJmDEeZzEfthz9MxOgcmYHC7D9zGrP?=
 =?iso-8859-1?Q?q0av+rbBLvjn4gUzVwcRHgF10ra9Maw/GunhPnrgT1RIuyuYdm0xn+pDJk?=
 =?iso-8859-1?Q?8pt/GohtB6nIdH/6nCc0QAzofl95o44LS4pi6ZLoV64w8aHPVs+s1aN0us?=
 =?iso-8859-1?Q?dODa9YBFMpygRMOZPfkxAuvFTyuqTTMl9+p3GnTIbWhVA80KouExv4B624?=
 =?iso-8859-1?Q?xnFi29dHOQnRGDIJER0IKgPbWW3mgDgeSXkmibd0qTWM2WgTd7+eDTvg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a504e422-dfd9-4be6-82ce-08dc449e7592
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:17:34.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjaU6WeqrKtmmSTFPi7QVtk85dbvGl4HLl6cO6MQH/UIocWKjVsXEG4NhFCevd4l5zL6IbBNyBsVLBldb9nXwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 9.1% improvement of stress-ng.sockfd.ops_per_sec on:


commit: d9f21b3613337b55cc9d4a6ead484dca68475143 ("af_unix: Try to run GC async.")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sockfd
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240315/202403151041.2a9a00df-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sockfd/stress-ng/60s

commit: 
  8b90a9f819 ("af_unix: Run GC on only one CPU.")
  d9f21b3613 ("af_unix: Try to run GC async.")

8b90a9f819dc2a06 d9f21b3613337b55cc9d4a6ead4 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     25305 ±  4%      +9.7%      27753 ±  2%  perf-c2c.HITM.total
     64392            +1.8%      65544        vmstat.system.cs
   1926720            +1.4%    1954260        proc-vmstat.numa_hit
   1694682            +1.5%    1719926        proc-vmstat.numa_local
   3151070            +3.4%    3257664        proc-vmstat.pgalloc_normal
      0.28 ±  8%     -15.0%       0.24 ±  9%  sched_debug.cfs_rq:/.h_nr_running.stddev
    259.21 ±  7%     -12.9%     225.86 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
     23.78 ± 13%     -20.9%      18.80 ± 27%  sched_debug.cpu.clock.stddev
  50265901            +9.1%   54861338        stress-ng.sockfd.ops
    837446            +9.1%     913917        stress-ng.sockfd.ops_per_sec
   2293458            -2.8%    2230066        stress-ng.time.involuntary_context_switches
   1581490            +8.1%    1709261        stress-ng.time.voluntary_context_switches
  26480342            +4.2%   27595498        perf-stat.i.cache-misses
  90320805            +3.9%   93807170        perf-stat.i.cache-references
      9.86            -1.7%       9.70        perf-stat.i.cpi
     25274            -5.1%      23975        perf-stat.i.cycles-between-cache-misses
 6.498e+10            +1.1%  6.571e+10        perf-stat.i.instructions
      0.11            +1.7%       0.11        perf-stat.i.ipc
     10.00            -1.7%       9.83        perf-stat.overall.cpi
     24733            -4.7%      23575        perf-stat.overall.cycles-between-cache-misses
      0.10            +1.7%       0.10        perf-stat.overall.ipc
 1.438e+10            +1.3%  1.458e+10        perf-stat.ps.branch-instructions
  24920120            +4.9%   26142747        perf-stat.ps.cache-misses
  86987270            +4.5%   90934893        perf-stat.ps.cache-references
 6.162e+10            +1.7%  6.268e+10        perf-stat.ps.instructions
 3.698e+12            +2.2%  3.781e+12        perf-stat.total.instructions
     66.00 ± 70%     -49.5       16.45 ±223%  perf-profile.calltrace.cycles-pp.stress_sockfd
     33.12 ± 70%     -24.9        8.24 ±223%  perf-profile.calltrace.cycles-pp.sendmsg.stress_sockfd
     33.08 ± 70%     -24.9        8.23 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg.stress_sockfd
     33.08 ± 70%     -24.9        8.23 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.stress_sockfd
     33.05 ± 70%     -24.8        8.22 ±223%  perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.stress_sockfd
     33.04 ± 70%     -24.8        8.22 ±223%  perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
     32.99 ± 70%     -24.8        8.20 ±223%  perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.95 ± 70%     -24.8        8.19 ±223%  perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
     32.67 ± 70%     -24.5        8.16 ±223%  perf-profile.calltrace.cycles-pp.recvmsg.stress_sockfd
     32.65 ± 70%     -24.5        8.15 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg.stress_sockfd
     32.65 ± 70%     -24.5        8.15 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg.stress_sockfd
     32.64 ± 70%     -24.5        8.14 ±223%  perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg.stress_sockfd
     32.63 ± 70%     -24.5        8.14 ±223%  perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     32.60 ± 70%     -24.5        8.14 ±223%  perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.60 ± 70%     -24.5        8.14 ±223%  perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
     32.59 ± 70%     -24.5        8.13 ±223%  perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
     32.58 ± 70%     -24.5        8.13 ±223%  perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
     32.51 ± 70%     -24.4        8.10 ±223%  perf-profile.calltrace.cycles-pp.unix_scm_to_skb.unix_stream_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     32.51 ± 70%     -24.4        8.10 ±223%  perf-profile.calltrace.cycles-pp.unix_attach_fds.unix_scm_to_skb.unix_stream_sendmsg.____sys_sendmsg.___sys_sendmsg
     32.44 ± 70%     -24.4        8.07 ±223%  perf-profile.calltrace.cycles-pp.unix_inflight.unix_attach_fds.unix_scm_to_skb.unix_stream_sendmsg.____sys_sendmsg
     32.43 ± 70%     -24.4        8.07 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_inflight.unix_attach_fds.unix_scm_to_skb.unix_stream_sendmsg
     32.37 ± 70%     -24.3        8.06 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.unix_inflight.unix_attach_fds.unix_scm_to_skb
     32.31 ± 70%     -24.2        8.06 ±223%  perf-profile.calltrace.cycles-pp.unix_detach_fds.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.____sys_recvmsg
     32.30 ± 70%     -24.2        8.06 ±223%  perf-profile.calltrace.cycles-pp.unix_notinflight.unix_detach_fds.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
     32.30 ± 70%     -24.2        8.06 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_notinflight.unix_detach_fds.unix_stream_read_generic.unix_stream_recvmsg
     32.23 ± 70%     -24.2        8.04 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.unix_notinflight.unix_detach_fds.unix_stream_read_generic
     66.37 ± 70%     -49.8       16.57 ±223%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     66.36 ± 70%     -49.8       16.56 ±223%  perf-profile.children.cycles-pp.do_syscall_64
     66.00 ± 70%     -49.5       16.45 ±223%  perf-profile.children.cycles-pp.stress_sockfd
     64.86 ± 70%     -48.7       16.17 ±223%  perf-profile.children.cycles-pp._raw_spin_lock
     64.64 ± 70%     -48.5       16.11 ±223%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     33.13 ± 70%     -24.9        8.24 ±223%  perf-profile.children.cycles-pp.sendmsg
     33.06 ± 70%     -24.8        8.22 ±223%  perf-profile.children.cycles-pp.__sys_sendmsg
     33.04 ± 70%     -24.8        8.22 ±223%  perf-profile.children.cycles-pp.___sys_sendmsg
     32.99 ± 70%     -24.8        8.20 ±223%  perf-profile.children.cycles-pp.____sys_sendmsg
     32.95 ± 70%     -24.8        8.19 ±223%  perf-profile.children.cycles-pp.unix_stream_sendmsg
     32.68 ± 70%     -24.5        8.16 ±223%  perf-profile.children.cycles-pp.recvmsg
     32.64 ± 70%     -24.5        8.15 ±223%  perf-profile.children.cycles-pp.__sys_recvmsg
     32.63 ± 70%     -24.5        8.14 ±223%  perf-profile.children.cycles-pp.___sys_recvmsg
     32.61 ± 70%     -24.5        8.14 ±223%  perf-profile.children.cycles-pp.____sys_recvmsg
     32.60 ± 70%     -24.5        8.14 ±223%  perf-profile.children.cycles-pp.sock_recvmsg
     32.59 ± 70%     -24.5        8.13 ±223%  perf-profile.children.cycles-pp.unix_stream_read_generic
     32.59 ± 70%     -24.5        8.13 ±223%  perf-profile.children.cycles-pp.unix_stream_recvmsg
     32.51 ± 70%     -24.4        8.10 ±223%  perf-profile.children.cycles-pp.unix_scm_to_skb
     32.51 ± 70%     -24.4        8.10 ±223%  perf-profile.children.cycles-pp.unix_attach_fds
     32.44 ± 70%     -24.4        8.07 ±223%  perf-profile.children.cycles-pp.unix_inflight
     32.31 ± 70%     -24.2        8.06 ±223%  perf-profile.children.cycles-pp.unix_detach_fds
     32.30 ± 70%     -24.2        8.06 ±223%  perf-profile.children.cycles-pp.unix_notinflight
     64.36 ± 70%     -48.3       16.04 ±223%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


