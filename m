Return-Path: <linux-kernel+bounces-116724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FCA88A1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2EF1C3729D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AAA15EFB1;
	Mon, 25 Mar 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FapeCW6b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57ED16078A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356962; cv=fail; b=oP8s6gC/xs1w3BMxvng/Vs2UeFx/6lNXzTG+cA7kPts7vihdZQfSQisvhy1UylysA42cTzANAXEQe153sivFD+DZJLDF/PyCisdhw5DfpgGEymFg06P0kYtlya5uFZJaITevLoHy0aNqZSVXmRud2DEEstg+T9B2f8bdhk1jrU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356962; c=relaxed/simple;
	bh=KH+yl0RIuhSTo5Z8ig6Od800iJ+exsyG1VzCV8I8IdI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=m47sjp7N+UiTnwsN38WJ9b4kYVbtv+gVIUUcu3ezADZ3PCEI3zSc6g8AammJ5u3S2ehNGJszULxG6apWPukmENVVhsVRNaN8OLwiPoGXZNt+nUlBGVWkDsNJKSajm8UZZUVizAjB2wCBApyzdrXoCxWsADccqST43Wml9J0kph8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FapeCW6b; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711356960; x=1742892960;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=KH+yl0RIuhSTo5Z8ig6Od800iJ+exsyG1VzCV8I8IdI=;
  b=FapeCW6bcvt0WdkcX85C4XMU0pSniTogSTnKSNsk0PRvLT+ZCf4XJzdX
   XIj0RtSGXU8ktZdsxE1vPuXZGneQ/mp1fU2oWvH6ACEeRMOQIJHKr5bAz
   er4bkzXM4unVFgAuGliFiS1ktW993lUeXAucOBpr7GhOLSAfi+N/EgX3v
   troizmRQGG8PcIYrg55EwcwkmI7JSdAOw3eYqFTB6IyVQ3wvVrIGvdwUb
   El87zOF1DuWCN40N/k9Ymgg0Q78D9PCNKNJ0onP1TAykd3lRbLWyESUmb
   T1GwF8LAGWh03HefFGnv3BirTiuxoLKZ2WA1Q5TA9XkvK8L+cXr9gqjLH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17487308"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17487308"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 01:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="46685408"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 01:55:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 01:55:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 01:55:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 01:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foIyhczlhkDbj4Bt5kd3tp5OzDGN2OXBKW2UvTZbgZFedQBfyJoDvX93qK+/2XCub1CmvZ5iAyXk9Rp7j5mAR0xm/y+1HXG4oe1nYWo38Dr8YipmurDi3iHCeVIf+rKQnrqSOOr9JukWZBtnZkHdZHTI6eHiy/I6u8Fca98qwMWN9WYf8FQuwrNSBTTX0to4rYMoDxy7PlfdM2v8SsWG1pd9Jx4xZL9xtLt4QN0U7fv4CcGyaI8Cl7TTw9A3ltOqHrT6sJAyhls3LKaLa7bbt7Ac610ul7XDab5GJHR/crhfaLsFHmE4roiPQ1Eqwjjz4ZWQGbZTyEbRJWAEduUa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVDcNVF3H10+ZIh2HmjtqIA+lVkCZkFcYmJi27ji1V8=;
 b=L1pUm7QB1GbNmfxTMTOMX3cdmfrg8QSMSAHBmBLbSB8xKUQX+24jK+aW6+8s3RqTt05StRuhqHlotLE7VEj4gmwEfDgi/wDLSUjmyZY7J29K4al8FAxaAflhVst5E/B9DAUOXrDvVaZGa1CVipuVFY7er/8kFt4s8bfH6icsSalt9aS1PLevjw0WgWbzy0kZV6b2I+rAKVLzYoYO0aZKuZnvIjxqg/f8b+sASqadeTxlvSBsy+JCdRP7Bv9Wzg20frwPno/UN8neD77oSOgvNRsZASZgVta1Pnte1uJyjOPf7pO9tIRrRudwlm+w8ip29wE9kyXbOwAmVuYkyNuDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by BN9PR11MB5274.namprd11.prod.outlook.com (2603:10b6:408:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 08:55:55 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::2dd3:6f51:bc3e:2d4a]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::2dd3:6f51:bc3e:2d4a%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 08:55:55 +0000
Date: Mon, 25 Mar 2024 16:55:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ryan Roberts
	<ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, Mel Gorman
	<mgorman@suse.de>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  7c33b8c422:  will-it-scale.per_thread_ops 11.4%
 improvement
Message-ID: <202403251657.f8cbfe2a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|BN9PR11MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e759bf-ab1b-442d-ed1e-08dc4ca961c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cfetc6vbKbteKDfh1XZo7dbqlrAMWcrsVdz/B1f6WgKbi0Al+UP3PYaUp0j1UBA9ks6WJICRh9Zf2eOWb4Ohmzp0z3FjeNhB6S6dFJ3pBiQDM2lMt6y7rnV4OOiq3bPahzFc+8qC4McMBT2gZrBEfKXAJ/UJB6hVsjyDUZ9fj6JhHMRuIp2VKTgVo2Wn5T4OFOg44VX9e+3QUDigXEwzfPRkxHqnbIfGQRNtGLntKT4RN00vIdbLyMzrX/SQJQnu9Zv6ut50JMI6Lte97DJiRyrisL52U6C27qqTnhhX0lBxd1QLRDgcCmYt9gMQXY1Z4ekomOGgHOFUjcgUtZJQYPLoodVtFbV84XdjVWvnq9jsTlLwu+8uNQlxHuyc0aykWGme7VGgeM8J9EPN9hWC1R5RcDgB7/skzTouhDiUa7BRnsc1eXgvPouKeWDjQO3s3ZU7g6QTYTPMwabVQPPo3haHS/Lh+jfgGWcwyt5aJQq7tb3Uls6fXBvspCydtuPLveIsc+gcqgU5a5EQ+6AEUmubs/ZF37CB5T2tliV3qptQQKA4ZG3wmG7rQ/wezGYs5/faXeYR+bo1Jw/Bv2AAEL6Hb605dQjFnr3/nYgJCh0RXm2nF7H44xWWY7oT5Gqo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?u2CWnrnSPb5CyDymtGfnExitS857wx733RTnLZS+593ZXLca3cz7xk3wRR?=
 =?iso-8859-1?Q?VjbnzgmxgIWmx0GdyZ2fIfVmI1s/NIw/8Wpx/DgOksOdlws2ftJxUvZQnx?=
 =?iso-8859-1?Q?dKe4gN6N1CXfOTkzLbgRKjLBHLvEztHmXy1QgCRjm10bo8F+hSl8G61CCs?=
 =?iso-8859-1?Q?cFDBHq9E4rwFNxU7h3HYwC2W7iAzkeOyn5VjhTZvjdn1336/PIAkA7ffUt?=
 =?iso-8859-1?Q?aCyhLnrh/Lp5NERe+TL63dV5a195VYz5IfNfkueutnoJejMVYW13yU1u+a?=
 =?iso-8859-1?Q?Ww4a6NwOkn1qAd0F/+rfI+TqEAyhjtzFXvHfHINsR6aunYrrGqgzAlPuRK?=
 =?iso-8859-1?Q?ezzWrGZ/s/d/h3kZI6yZB94HZ9NinaAmrFbaRYcp16UQFL+wWmS7P1e+mK?=
 =?iso-8859-1?Q?ly6Q4nzZ1W/jNWAZ3/ZMzHmDqFB9/fHQbzunM3CADUSN/WKyAShiU4EwMf?=
 =?iso-8859-1?Q?UbWmc6T+92zEmEJT8gc8uR78QuyNHco+FOAwL46A+nbawwGowEzZ6WOu48?=
 =?iso-8859-1?Q?aluXH7rgUgTPhFs4I8Zj+9TmLbL1mHMb+IZdPwPyVhdef7G+kDQxtg7ZWD?=
 =?iso-8859-1?Q?uqmqGrSE4ljJVY3A598/wdCjSm50MIxvTvwsRenQjn9kXKpRrDIYHrpARC?=
 =?iso-8859-1?Q?P1idGS/a80yl1DWLIJ6Zxqf7qt6uk63KRFbhVpNJiu6sk/yamvrPG5B3K7?=
 =?iso-8859-1?Q?JPHjmSmckNLSlEF8I2yZ+X95Qy99wNZkF1BJqgICrhdVrXMiinm3wSNm+f?=
 =?iso-8859-1?Q?3uYT7M1ezbgq3N/i9HTRgN4LLPO5VX+whH8Px02aQxv0RGYt7Qw+KpZh16?=
 =?iso-8859-1?Q?I8uNHp8akaRL7MFqro3CZopzN/O++vpXWD9K4tGJRHhslXC7FXLDzubc00?=
 =?iso-8859-1?Q?XREmmKuG/ICsIkrqgp74EJSvrElTN/9sH6Y1d7IhbK5cPOUsIglrmIjL9t?=
 =?iso-8859-1?Q?sDC6sJLE7+TlRv4GlJI1alXeFj5mlJux7WtMljIVhVGCf1KbSaD4h2+Afj?=
 =?iso-8859-1?Q?w41E2oDsR4AXdqCAYIUJ7iBzHqhETPoKqI0X0H24ctpL6Uo67jKKrMtCat?=
 =?iso-8859-1?Q?sVPkGlx/cNBl44jIfidzZeGLgGH5M3E2cWHXijAcE14Gkz8vdazlbQG7Qy?=
 =?iso-8859-1?Q?Kehp5XWG8tjw+M0SzjD/Vb6D+nshNlEaR17drr1SPxIpAJFo5FU0yl2Jsy?=
 =?iso-8859-1?Q?GX4YWPuEmeGROOjGPRYXKBCO/jlHhmlsnnxXVP07ZTKLnBBsHEZZ9Xw8th?=
 =?iso-8859-1?Q?PemNOSdsfp2f42X8TRirqvsPJYcWD77nRlqoTriMd0hePkzHGLFkH1hXNG?=
 =?iso-8859-1?Q?KZEC/SgraVo4sGYXeoJOU24thYnB0VtvAGc3iX43am6Z7pmlsSO9J46J3W?=
 =?iso-8859-1?Q?loSOIhnRxm3szDIXgWoi0CQ/ifX96oTtZfn92w1gpHZEqBFbewWImDNcAr?=
 =?iso-8859-1?Q?4t97o6QjYN5SCS1Cq0CJGMVWbZyjTPd222NO7YMIZvk5jwYrGuqdZ9FdgJ?=
 =?iso-8859-1?Q?pAajdy2elZuzLhyPU9I3istDXV/Oq/UxtU50eJ60Jvpcs1Nsj/YJZ3OyNB?=
 =?iso-8859-1?Q?LcPu8MEPE3+h/mNIcvqzbaLpOhEp+LXOqhXbd2tXRNxnH2duhWkLJJXjke?=
 =?iso-8859-1?Q?Vc6/w1VDNTOpYxjJ14kVMMV5iapn80nMC+KUpEq2Mw2tO/B9XDT0LqUA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e759bf-ab1b-442d-ed1e-08dc4ca961c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 08:55:55.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nnw9ZgU+jdK6X30DW2/EJ0HfLdFU1VmaDXBANnjM3w615adHzmOId6tHXSgvFISPQ8tfcz/0Y2DJ/T69NS3qNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5274
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 11.4% improvement of will-it-scale.per_thread_ops on:


commit: 7c33b8c4229af19797c78de48827ca70228c1f47 ("mm: remove use of folio list from folios_put()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 16
	mode: thread
	test: page_fault2
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240325/202403251657.f8cbfe2a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/16/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/page_fault2/will-it-scale

commit: 
  4882c80975 ("memcg: add mem_cgroup_uncharge_folios()")
  7c33b8c422 ("mm: remove use of folio list from folios_put()")

4882c80975e2bf72 7c33b8c4229af19797c78de4882 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      9.19            +1.1       10.32        mpstat.cpu.all.sys%
      2.00            +0.2        2.23        mpstat.cpu.all.usr%
 1.171e+09           +11.0%    1.3e+09        numa-numastat.node0.local_node
 1.173e+09           +10.9%  1.301e+09        numa-numastat.node0.numa_hit
     12.80           +10.6%      14.16        vmstat.procs.r
      2179            +2.7%       2239        vmstat.system.cs
     28134           +10.1%      30977        vmstat.system.in
   3858794           +11.4%    4296995        will-it-scale.16.threads
     88.59            -1.6%      87.20        will-it-scale.16.threads_idle
    241174           +11.4%     268562        will-it-scale.per_thread_ops
   3858794           +11.4%    4296995        will-it-scale.workload
   4597109 ± 16%     -30.5%    3195509 ± 34%  numa-meminfo.node0.FilePages
     75985 ± 12%     -35.5%      48981 ± 34%  numa-meminfo.node0.KReclaimable
     75985 ± 12%     -35.5%      48981 ± 34%  numa-meminfo.node0.SReclaimable
   2516178 ± 30%     -55.8%    1113291 ± 99%  numa-meminfo.node0.Unevictable
      6475 ±125%    +199.9%      19417 ± 59%  numa-meminfo.node1.Mapped
   1149260 ± 16%     -30.6%     797998 ± 34%  numa-vmstat.node0.nr_file_pages
     18996 ± 12%     -35.5%      12243 ± 34%  numa-vmstat.node0.nr_slab_reclaimable
    629044 ± 30%     -55.8%     278322 ± 99%  numa-vmstat.node0.nr_unevictable
    629044 ± 30%     -55.8%     278322 ± 99%  numa-vmstat.node0.nr_zone_unevictable
 1.173e+09           +10.9%  1.301e+09        numa-vmstat.node0.numa_hit
 1.171e+09           +11.1%    1.3e+09        numa-vmstat.node0.numa_local
      1665 ±124%    +199.4%       4986 ± 59%  numa-vmstat.node1.nr_mapped
   2254868 ±  8%     +15.4%    2602210 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
    671734 ± 10%     +19.6%     803578 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   2254868 ±  8%     +15.4%    2602210 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
    671734 ± 10%     +19.6%     803578 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
     95.28 ±  3%     +12.6%     107.30 ±  6%  sched_debug.cfs_rq:/.util_est.avg
    530.36 ±  4%     +12.6%     597.03 ±  4%  sched_debug.cpu.curr->pid.avg
      0.13 ±  5%     +12.9%       0.15 ±  4%  sched_debug.cpu.nr_running.avg
      0.03 ± 14%     -39.9%       0.02 ± 29%  sched_debug.cpu.nr_uninterruptible.avg
     25765            +2.9%      26515        proc-vmstat.nr_active_anon
    463751            -4.3%     443812        proc-vmstat.nr_anon_pages
    988326            -2.0%     968357        proc-vmstat.nr_inactive_anon
     25765            +2.9%      26515        proc-vmstat.nr_zone_active_anon
    988327            -2.0%     968357        proc-vmstat.nr_zone_inactive_anon
 1.173e+09           +10.9%  1.302e+09        proc-vmstat.numa_hit
 1.171e+09           +11.1%  1.301e+09        proc-vmstat.numa_local
     21662            +5.2%      22790        proc-vmstat.pgactivate
 1.168e+09           +11.2%  1.299e+09        proc-vmstat.pgalloc_normal
 1.164e+09           +11.2%  1.295e+09        proc-vmstat.pgfault
 1.168e+09           +11.2%  1.298e+09        proc-vmstat.pgfree
 3.587e+09           +10.5%  3.964e+09        perf-stat.i.branch-instructions
  23777908            +7.3%   25506059        perf-stat.i.branch-misses
 3.201e+08           +11.4%  3.567e+08        perf-stat.i.cache-misses
   4.1e+08           +13.2%  4.641e+08        perf-stat.i.cache-references
      2139            +3.3%       2210        perf-stat.i.context-switches
 3.885e+10           +10.8%  4.305e+10        perf-stat.i.cpu-cycles
 1.844e+10           +10.1%  2.031e+10        perf-stat.i.instructions
     74.11           +11.2%      82.38        perf-stat.i.metric.K/sec
   3853671           +11.2%    4283769        perf-stat.i.minor-faults
   3853671           +11.2%    4283769        perf-stat.i.page-faults
      0.66            -0.1        0.54 ± 44%  perf-stat.overall.branch-miss-rate%
   1442267           -17.6%    1188877 ± 44%  perf-stat.overall.path-length
      2.16            -0.6        1.52        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      5.70            -0.5        5.18 ±  2%  perf-profile.calltrace.cycles-pp.__munmap
      5.70            -0.5        5.18 ±  2%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      5.70            -0.5        5.18 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      5.70            -0.5        5.18 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      5.70            -0.5        5.18 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      5.69            -0.5        5.17 ±  2%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      5.69            -0.5        5.17 ±  2%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      5.69            -0.5        5.17 ±  2%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.27            -0.5        4.75 ±  2%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      5.28            -0.5        4.76 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      5.28            -0.5        4.76 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      5.28            -0.5        4.76 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      4.92            -0.4        4.54        perf-profile.calltrace.cycles-pp.folio_prealloc.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     31.58            -0.3       31.25        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.80 ±  2%      -0.2        1.65 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.66 ±  2%      -0.1        1.52 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.12 ±  2%      -0.1        1.03 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.10 ±  2%      -0.1        1.01 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.86 ±  3%      -0.1        0.80 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.13            +0.1        2.20        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.60 ±  2%      +0.1        0.69 ±  2%  perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      2.26            +0.1        2.35        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.59 ±  4%      +0.1        0.72 ± 13%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu
      0.58 ±  4%      +0.1        0.72 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages
      0.81 ±  4%      +0.2        0.96 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range
      0.82 ±  4%      +0.2        0.98 ± 10%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault
      0.71 ±  4%      +0.2        0.87 ± 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru_vma
      2.85            +0.2        3.05 ±  5%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru_vma.set_pte_range.finish_fault.do_fault
      3.06            +0.2        3.27 ±  4%  perf-profile.calltrace.cycles-pp.folio_add_lru_vma.set_pte_range.finish_fault.do_fault.__handle_mm_fault
      0.45 ± 44%      +0.2        0.67 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folios_put_refs.release_pages
      9.85            +0.3       10.17        perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     14.80            +0.3       15.15        perf-profile.calltrace.cycles-pp.copy_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     32.43            +0.4       32.82        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     33.75            +0.4       34.18        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     35.10            +0.5       35.56        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     38.62            +0.6       39.21        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     38.89            +0.6       39.48        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.free_unref_folios.folios_put_refs.release_pages.__tlb_batch_free_encoded_pages.tlb_flush_mmu
     54.53            +0.8       55.31        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     60.07            +0.9       60.95        perf-profile.calltrace.cycles-pp.testcase
      1.06 ±  2%      -0.8        0.22 ±  7%  perf-profile.children.cycles-pp._compound_head
      2.20            -0.6        1.57        perf-profile.children.cycles-pp.zap_present_ptes
      5.85            -0.5        5.32 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.70            -0.5        5.18 ±  2%  perf-profile.children.cycles-pp.__munmap
      5.70            -0.5        5.18 ±  2%  perf-profile.children.cycles-pp.do_vmi_munmap
      5.84            -0.5        5.32 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
      5.69            -0.5        5.17 ±  2%  perf-profile.children.cycles-pp.unmap_region
      5.70            -0.5        5.18 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
      5.70            -0.5        5.18 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
      5.70            -0.5        5.18 ±  2%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      5.28            -0.5        4.77 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      5.28            -0.5        4.76 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
      5.28            -0.5        4.77 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      5.28            -0.5        4.77 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
      0.85 ±  6%      -0.4        0.46 ±  5%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      4.98            -0.4        4.60        perf-profile.children.cycles-pp.folio_prealloc
     31.58            -0.3       31.25        perf-profile.children.cycles-pp.cpu_startup_entry
     31.50            -0.3       31.18        perf-profile.children.cycles-pp.cpuidle_idle_call
     31.58            -0.3       31.25        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     31.58            -0.3       31.25        perf-profile.children.cycles-pp.do_idle
     31.04            -0.3       30.75        perf-profile.children.cycles-pp.cpuidle_enter_state
     31.06            -0.3       30.77        perf-profile.children.cycles-pp.cpuidle_enter
      2.26            -0.1        2.14 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     28.90            -0.1       28.79        perf-profile.children.cycles-pp.intel_idle_ibrs
      2.06            -0.1        1.95 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.45            -0.0        1.40 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.20 ±  3%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.33 ±  2%      -0.0        0.30 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.18 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.free_swap_cache
      0.20 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.22 ±  4%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.06 ±  7%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.49 ±  2%      +0.0        0.52 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.14 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.74            +0.1        0.79        perf-profile.children.cycles-pp.free_unref_folios
      2.44            +0.1        2.50        perf-profile.children.cycles-pp.native_irq_return_iret
      0.28            +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.free_unref_page_prepare
      2.14            +0.1        2.21        perf-profile.children.cycles-pp.shmem_fault
      0.60 ±  2%      +0.1        0.69 ±  2%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      2.27            +0.1        2.36        perf-profile.children.cycles-pp.__do_fault
      0.80 ±  2%      +0.1        0.92 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.34 ±  5%      +0.1        1.48 ±  4%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      2.87 ±  2%      +0.2        3.06 ±  5%  perf-profile.children.cycles-pp.folio_batch_move_lru
      3.07            +0.2        3.28 ±  4%  perf-profile.children.cycles-pp.folio_add_lru_vma
      1.32 ±  4%      +0.3        1.62 ± 11%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.50 ±  4%      +0.3        1.80 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.48 ±  4%      +0.3        1.79 ± 10%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      9.88            +0.3       10.20        perf-profile.children.cycles-pp.finish_fault
      0.00            +0.3        0.34 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
     14.84            +0.3       15.18        perf-profile.children.cycles-pp.copy_page
     32.45            +0.4       32.85        perf-profile.children.cycles-pp.do_fault
     33.78            +0.4       34.22        perf-profile.children.cycles-pp.__handle_mm_fault
     35.16            +0.4       35.60        perf-profile.children.cycles-pp.handle_mm_fault
     38.66            +0.6       39.25        perf-profile.children.cycles-pp.do_user_addr_fault
     38.93            +0.6       39.52        perf-profile.children.cycles-pp.exc_page_fault
     49.87            +0.7       50.59        perf-profile.children.cycles-pp.asm_exc_page_fault
     62.47            +0.9       63.33        perf-profile.children.cycles-pp.testcase
      1.04 ±  2%      -0.8        0.19 ±  8%  perf-profile.self.cycles-pp._compound_head
      0.56 ±  7%      -0.4        0.18 ±  8%  perf-profile.self.cycles-pp.__folio_throttle_swaprate
     28.90            -0.1       28.78        perf-profile.self.cycles-pp.intel_idle_ibrs
      0.27 ±  2%      -0.0        0.24 ±  3%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.free_swap_cache
      0.20 ±  4%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.08 ±  5%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__do_fault
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.14 ±  4%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      2.44            +0.1        2.49        perf-profile.self.cycles-pp.native_irq_return_iret
      0.30 ±  4%      +0.1        0.36 ±  4%  perf-profile.self.cycles-pp.shmem_fault
      0.15 ±  3%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.zap_pte_range
      0.66 ±  2%      +0.1        0.76 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.45 ±  3%      +0.1        0.56 ±  3%  perf-profile.self.cycles-pp.zap_present_ptes
      1.32 ±  4%      +0.3        1.62 ± 11%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     14.74            +0.3       15.08        perf-profile.self.cycles-pp.copy_page




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


