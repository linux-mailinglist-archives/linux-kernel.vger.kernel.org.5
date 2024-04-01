Return-Path: <linux-kernel+bounces-126798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB7F893CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75511F23169
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2DD46B80;
	Mon,  1 Apr 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzpormkp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2E3FBBD;
	Mon,  1 Apr 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985127; cv=fail; b=Avpd3Z1GfE4NWXfS7osEZjYFzDKyIrmU3oHTG4WC3csdz/ZbZZcqff6l/BM/R8HY5K2ZhAZ6sZTy/C46OangFY6SCGSQVnHq0drVr2uasnfdLqyxYyyg1MNJZV62o5YK5/B/U1yTIx+62ztwbEWMjUiGRKAHbwR+ftj29vMcz/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985127; c=relaxed/simple;
	bh=to7YY3/+kSlH/sWQdnXvbmzk0JYZe3zp+TPaJfHLQNc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pWQ53Is1MAlwNi6ygQ55lDte6HaVLAl7uzGFCQzinWT0ApjHvDV2GVPIhfcOd+e12QVVbmJNsu2LIkrRxBh66U0r5zML0c/HDmeY2Z1T006V/3Tm2HNQ8fYFLd2wqj4VX9+BzhgLDzwr4+35yRJMpadn3J7BKJ6HMg/WQAIj+gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzpormkp; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711985125; x=1743521125;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=to7YY3/+kSlH/sWQdnXvbmzk0JYZe3zp+TPaJfHLQNc=;
  b=kzpormkpMP1ScD2gyFePUqoUaY8UiUUyW1DF75U9wMdnAlpvZwXu1xtz
   CffxwxNypVZTGYbVLMKOU8wLHOJ2aEwYOo/Owtq74ci55RC0lXaXWK0hf
   79tU089/okKqWtavIMyiELX/d2rKU6w+LCt+Z2+IPff+P/wNr7Rmv/0Fd
   dBHPbmv01Sj5uO35RUIGAA8cztWg9N7YNffAI9hCFZBnlK9XmBtLzDMe9
   D2TO3CuaK1HmfI7m+7Jhw7sL7bZ6Ml4aEUzomf06tgt5fRSvkgR1x9L59
   HqFvphvw9RXjB4MyiMJ+82dQK+FpSIhp3UknN+HrFJF29tC4zr3E6grM+
   A==;
X-CSE-ConnectionGUID: BANCIcAsRoeII7h0kRiymw==
X-CSE-MsgGUID: 4FA3ipMXRUuTu6YJApTP5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="6973195"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="6973195"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 08:25:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17558664"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 08:25:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 08:25:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 08:25:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 08:25:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdN1V3bJS/jqane+IaLmFTUXUbuRF37KWcdz6HPQb/QdfS/clvyuAPIs1BP+8Lxzd8DJHwkuc35ebY67tRn96oTFxHgjLZLTPFcXKfq9PPZANBi1J0mlqOBBHXoGBJ+GQ1qrzm5Ww37OFN2ceTpHDkwv+r4QzZU7tc5UvCyl11pbtk39rLhI5xKqtU23jQ7fN8VjAz3ksb0cZs1WPavZhrglyQdj+WlltKo4CmwdWl/DS2V+cebweO0BLeyxSrCN2j0W2aTZcxAxItQgwP/ErHnfAt6Y4KTALPOhoNk0m+UufBXIOJXjkoTtpAMFH/ng6Y73LyX6L7AWXVUhQXRXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RgzYjuFhTcYLFV4eXT+3Q3/BkAg8PTCYCGAWbJw/Uo=;
 b=YOPHi+ty+tNz5sD7iBKBg/RXGfxG42e52EL6RbawnEU22iCW0P4LO9pjed0vjSAb2V4Qdbg/61xSOfFsR3fIls4zlFpdIi9llXWg5ZCBbeHpLIWFmI9AHLDvhOU4mZygBS7+Npg7yXFqsYp8rIHhQ8t0Q41VwmGM0Ayxjp/+/NRYZ31baH0FesflEbZSDqv1wJyHyDfBCqSiqYDcPd/Y8NMqoLW4ssEy3IoodrCwGPt3iAtEi34DgBvx1HDdVhOFXR54oF1SxDn8tjmWaUdVaghYkNtqwfgV6g8pE9c1OJuJtp/MG/12dBJI6QrE4CTVuWUeFjEDnK/lSjWn9XLvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 1 Apr
 2024 15:25:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 15:25:21 +0000
Date: Mon, 1 Apr 2024 23:25:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sock_diag]  f44e64990b:
 stress-ng.sockdiag.ops_per_sec 147.0% improvement
Message-ID: <202404012326.d995728e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB6246:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFa99nUtIAy9Pw/S0qYGd1uP7D6Xg/9yse13hv4TFnJ/DCXDJcU++rJVAXGWMHC2SbYS8mCWUU00XjTkpBGSRlVXzeZaec4rLPRqZjZzN4/4OzpSyI3laFuqxtZJeebhgU+xc8vJ7SU0DvgC4fACOJ0XkwUxO+Dzem0B4x+QMBqXpd8kMbyFIBUwBEShlJLSAocfyqNaJjOPFDFt/iyN0Xgh/NWgtmFoqyGneBGuuVAum8sR2lUO9hVR6YvKJIhC25mqfVMxBhlNSYPxELCSzJ/ug2m3ROwuhNlhATlHb3dAcxhyFfOrM4xT6YGDHTYEszXtWHjs1+D/Pz2ieJTprpqfMkGulAnenqXMTazfoPoMKkqRndw97kJ+aAJeN7UVkmLV0mbrtxQFLXrP5ANM2H6x2gKLnQoY/3y81P6FXwg2i0SoQ/G9BH+dk6t80gqTdGlnv9Yd/8lCGuP52j3EO0bQcJciugSzi72hNgEkEL1ZkogFZb3XKLXZU9atuA1PynqPon3PRMh76z0HBrSpP/I8Q0Z63swNfY55ESrGSC/Zp3LLR864YQZkfPimE1xAXsxlxfU9oB97VCGmGROeOcGVkOxQj5VP8oAba0bGTv9aMOfwmVEbjEtr9YoYkp/e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?M1beSF0YaY75hH8z6ZyLTqHhEGvch/1VqJJbFzIJSUwsLEywjAVlDmT+O4?=
 =?iso-8859-1?Q?jOiZyYdJr8eV96YSxA9x3le6RvzwAo5B0/BLAruYh4agR0Ys8xUbo+VNOX?=
 =?iso-8859-1?Q?X/Meu6eU8hzO3ma2WvIDl+OBI5TESWxh5CNdFUbEcahJRQOz4o1wc7Fdz4?=
 =?iso-8859-1?Q?Kf9il9HBhI6jR4UtxqGKcDdEIuxXDaLLrUY4rlS8GEGT0W1TNcLwcWR0ja?=
 =?iso-8859-1?Q?CqDYL/9+fj+kR3EH75Lc9sntHNSEKzeRP1lg0IMLAzSICBBgwk0WG9mZOU?=
 =?iso-8859-1?Q?DBPtG4NAMl4oclEo+7xoH/BzHfx9z7cju0tk5JvKuG6oBSOUBTdR3wSBZb?=
 =?iso-8859-1?Q?NLRY8X9Defe7Nbtvmpirmsp6Jx5qJlUfE9kVaI3dTHrJe0kry/XwqP1Blz?=
 =?iso-8859-1?Q?0x0j+c4IwOBQpSgmRwugQ7hDTeTFxBYjqalfmb9wzC8Dc79Tq4xuyWUR2a?=
 =?iso-8859-1?Q?BSSH1dQA85/Ak04N1EiMy4wI5pMgXfChTkhc51kx9KPGEYv2CMOheX5Mbs?=
 =?iso-8859-1?Q?88V4y7ULzJG57pnJ0LtFeH2K1tlkeA6smccY0Pp64m8vLWs8eZEyaDC2po?=
 =?iso-8859-1?Q?tyks7W+j5ZNklIYeWoZQjFmwOL00DBpJ3hbGjPBC32sw6B6/SPhBpMznVl?=
 =?iso-8859-1?Q?e//Yv+KMUUtc7jHWQC51tMZOgeblUwqjU7Pbdgcsg1cXNalSXVNLO6VhAl?=
 =?iso-8859-1?Q?gsgLMV0pIB/fA4BF+Nku3GIBKIHDq3gTAmRYXyPEUkxLIkfe+kVftWoiB1?=
 =?iso-8859-1?Q?XaN3oZ1LQGMyw4VwC6BDepPoY9x2Nutvjy2h/iYKgmsEu/3DXhimqAbWY7?=
 =?iso-8859-1?Q?pTtahn3sz/FbXgewSealC9XoOOqIegZWSz+06WSz9LrD8FwD4HWgDk/5mC?=
 =?iso-8859-1?Q?HQ9nIpH1vtt8AdCumBd+WZgMctda5NBi2iKLjVqFI214OJcd6bv3jui2pI?=
 =?iso-8859-1?Q?CKB7TLR65bRSsjHgCVMaEKYDHpm6XvcKmwY2/5+63ybRw1rUddBYiY5zQz?=
 =?iso-8859-1?Q?6s8Owa8u/EyVSW+DbmZewpw5qj1dKXKP/AQSeycoV74EBy78VF5fRvVI6l?=
 =?iso-8859-1?Q?0hiM0pbpvQVgV/YKUhKeImATiI7Z9Jx7lRVExjip1AxOfNE3iZ0EtJv4m5?=
 =?iso-8859-1?Q?ek5t95mRSMpKAbn+i3I5nex6QZXLttHG4ualZ7+KDVjfhexlwBZLFyRAJ9?=
 =?iso-8859-1?Q?odZ34VCw0NB7TyzPefbkIBKos3XsdkkYyG2MP+TbsKPy8kv0l5/5eAlwiO?=
 =?iso-8859-1?Q?w4n0jgBDaN1+2BcgbX6m8ZEHEnNwRRkseSyL2wLPh7p8ug5yTa4uI8Zw5w?=
 =?iso-8859-1?Q?kdNdzv5/J6/YckzKTs4ElL72wg/6lM+Pz4lPjefPIzaDO8g/TasE+l0iIk?=
 =?iso-8859-1?Q?D2ebiyYPYxFynyIo6WpUxa2hJbeKS6WNk6B3ZmBXucVVVsOd7KTUFxAQQ9?=
 =?iso-8859-1?Q?oj9Wa/lGVe+/a5sbC4An3eDtdlSETEnGzklY1ZqZDxBrJ2SvCtdDzR+w8w?=
 =?iso-8859-1?Q?pb6ZtcBEW/MoTetoe/8lF1qeu4cWROtWyZdxpdfShQIP3iwd27JkvGSckH?=
 =?iso-8859-1?Q?JMA015A6rBCrZnms93rKvUR/qcrPq+Czu/rj+nks/R4IzK4SspA2r+KhJS?=
 =?iso-8859-1?Q?VPIkAk5w0DaWU6B6DAAY+u2xjwDe8z55Tsq5+GVfGknB6v03tEsLEFsg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3a055d-a81f-4028-67e2-08dc525ff198
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:25:21.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gz7IkweZC/IP9MjnM2Gom31APQPemmQBBjbewWAZtAEfSkoXmNlpdnr87Z2kbnWCH3M9LTMQy80+KTf9ntrlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 147.0% improvement of stress-ng.sockdiag.ops_per_sec on:


commit: f44e64990beb41167bd7c313d90bcf7e290c3582 ("sock_diag: remove sock_diag_mutex")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sockdiag
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240401/202404012326.d995728e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sockdiag/stress-ng/60s

commit: 
  86e8921df0 ("sock_diag: allow concurrent operation in sock_diag_rcv_msg()")
  f44e64990b ("sock_diag: remove sock_diag_mutex")

86e8921df05c6e94 f44e64990beb41167bd7c313d90 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      6805 ± 37%    +630.7%      49725 ±137%  numa-meminfo.node0.Active
      6767 ± 37%    +634.2%      49687 ±138%  numa-meminfo.node0.Active(anon)
      7690          +906.4%      77394 ± 48%  vmstat.system.cs
    420471            +6.2%     446552        vmstat.system.in
 2.491e+08          +147.0%  6.154e+08 ± 40%  stress-ng.sockdiag.ops
   4152375          +147.0%   10257279 ± 40%  stress-ng.sockdiag.ops_per_sec
     86849          +350.0%     390836 ± 28%  stress-ng.time.involuntary_context_switches
      0.55            -0.3        0.30 ± 20%  mpstat.cpu.all.irq%
      0.10 ±  3%      +0.0        0.15 ± 22%  mpstat.cpu.all.soft%
      0.46            +0.1        0.54 ±  2%  mpstat.cpu.all.usr%
     46.33 ± 12%     -84.2%       7.33 ± 84%  mpstat.max_utilization.seconds
   2234616 ±  2%    +136.2%    5279086 ± 37%  numa-numastat.node0.local_node
   2378097          +124.6%    5342166 ± 36%  numa-numastat.node0.numa_hit
   2678667 ±  2%    +108.5%    5584120 ± 35%  numa-numastat.node1.local_node
   2768310 ±  3%    +107.9%    5755443 ± 34%  numa-numastat.node1.numa_hit
   1211899           +13.3%    1372481 ±  2%  meminfo.Inactive
   1211695           +13.3%    1372284 ±  2%  meminfo.Inactive(anon)
    540274           +25.9%     680362 ±  7%  meminfo.Mapped
    449208            +8.6%     487827 ±  7%  meminfo.SUnreclaim
    862353           +23.0%    1060355 ±  3%  meminfo.Shmem
    161.00 ± 21%    +579.5%       1094 ± 64%  perf-c2c.DRAM.local
      1480 ± 15%    +661.4%      11271 ± 57%  perf-c2c.DRAM.remote
      1391 ± 14%   +1182.4%      17843 ± 65%  perf-c2c.HITM.local
    585.00 ± 10%   +1199.8%       7604 ± 59%  perf-c2c.HITM.remote
      1976 ± 13%   +1187.6%      25447 ± 63%  perf-c2c.HITM.total
    965151 ±  3%     -47.0%     511917 ±  6%  sched_debug.cpu.avg_idle.avg
    225203 ± 48%     -84.8%      34261 ±130%  sched_debug.cpu.avg_idle.min
      1759 ±  6%    +542.3%      11302 ± 45%  sched_debug.cpu.nr_switches.avg
    899.42          +738.6%       7542 ± 42%  sched_debug.cpu.nr_switches.min
    -30.17          +221.8%     -97.08        sched_debug.cpu.nr_uninterruptible.min
      1739 ± 37%    +612.9%      12403 ±138%  numa-vmstat.node0.nr_active_anon
      1739 ± 37%    +612.9%      12403 ±138%  numa-vmstat.node0.nr_zone_active_anon
   2377796          +124.5%    5337172 ± 36%  numa-vmstat.node0.numa_hit
   2234316 ±  2%    +136.0%    5274091 ± 37%  numa-vmstat.node0.numa_local
   2767474 ±  3%    +107.8%    5750481 ± 34%  numa-vmstat.node1.numa_hit
   2677832 ±  2%    +108.3%    5579160 ± 35%  numa-vmstat.node1.numa_local
    980143            +5.0%    1028901        proc-vmstat.nr_file_pages
    303091           +13.2%     342957 ±  2%  proc-vmstat.nr_inactive_anon
     40864            +1.6%      41510        proc-vmstat.nr_kernel_stack
    135507           +25.7%     170340 ±  7%  proc-vmstat.nr_mapped
    215970           +22.6%     264729 ±  3%  proc-vmstat.nr_shmem
     41429            +7.8%      44664 ±  7%  proc-vmstat.nr_slab_reclaimable
    112306            +8.7%     122083 ±  7%  proc-vmstat.nr_slab_unreclaimable
    303091           +13.2%     342957 ±  2%  proc-vmstat.nr_zone_inactive_anon
     37590 ± 28%     +51.2%      56819 ± 18%  proc-vmstat.numa_hint_faults
   5148855          +115.5%   11093970 ± 35%  proc-vmstat.numa_hit
   4915589          +120.9%   10859566 ± 36%  proc-vmstat.numa_local
    206083 ± 27%     +58.4%     326447 ± 14%  proc-vmstat.numa_pte_updates
  32486467          +143.2%   79020889 ± 39%  proc-vmstat.pgalloc_normal
    759303           +16.3%     882814 ±  3%  proc-vmstat.pgfault
  32050628          +144.9%   78486695 ± 40%  proc-vmstat.pgfree
      0.13 ±  7%    +536.1%       0.85 ± 21%  perf-stat.i.MPKI
 3.083e+10           -56.4%  1.344e+10 ±  2%  perf-stat.i.branch-instructions
      0.19 ±  3%   +6870.7        6870 ±104%  perf-stat.i.branch-miss-rate%
  42989880 ±  2%    +2e+06%  8.623e+11 ±101%  perf-stat.i.branch-misses
  16796111 ±  9%    +189.6%   48642444 ± 25%  perf-stat.i.cache-misses
  68857289 ±  5%    +196.5%  2.042e+08 ± 12%  perf-stat.i.cache-references
      7918          +929.7%      81533 ± 44%  perf-stat.i.context-switches
      3.94          +165.6%      10.46        perf-stat.i.cpi
     39043 ± 10%     -64.0%      14047 ± 19%  perf-stat.i.cycles-between-cache-misses
 1.541e+11           -62.6%   5.76e+10 ±  3%  perf-stat.i.instructions
      0.26           -61.2%       0.10        perf-stat.i.ipc
      0.10 ± 92%    +479.0%       0.56 ± 28%  perf-stat.i.major-faults
     12344           +20.7%      14898 ±  3%  perf-stat.i.minor-faults
     12345           +20.7%      14899 ±  3%  perf-stat.i.page-faults
      0.11 ±  9%    +685.5%       0.84 ± 21%  perf-stat.overall.MPKI
      0.12 ±  2%   +9674.7        9674 ±101%  perf-stat.overall.branch-miss-rate%
      4.00          +166.1%      10.63        perf-stat.overall.cpi
     37756 ± 10%     -65.1%      13184 ± 18%  perf-stat.overall.cycles-between-cache-misses
      0.25           -62.4%       0.09        perf-stat.overall.ipc
 2.952e+10           -56.5%  1.284e+10 ±  2%  perf-stat.ps.branch-instructions
  35366132 ±  2%  +3.6e+06%  1.256e+12 ±100%  perf-stat.ps.branch-misses
  15767609 ±  9%    +194.8%   46490063 ± 26%  perf-stat.ps.cache-misses
  67236264 ±  4%    +194.1%  1.977e+08 ± 12%  perf-stat.ps.cache-references
      7505          +941.8%      78193 ± 47%  perf-stat.ps.context-switches
 1.475e+11           -62.7%  5.497e+10 ±  3%  perf-stat.ps.instructions
      0.08 ± 88%    +399.3%       0.41 ± 28%  perf-stat.ps.major-faults
     10427 ±  2%     +19.6%      12474 ±  3%  perf-stat.ps.minor-faults
     10428 ±  2%     +19.6%      12475 ±  3%  perf-stat.ps.page-faults
  8.86e+12           -62.6%  3.315e+12 ±  3%  perf-stat.total.instructions
     99.55           -99.6        0.00        perf-profile.calltrace.cycles-pp.sock_diag_rcv.netlink_unicast.netlink_sendmsg.____sys_sendmsg.___sys_sendmsg
     99.10           -99.1        0.00        perf-profile.calltrace.cycles-pp.__mutex_lock.sock_diag_rcv.netlink_unicast.netlink_sendmsg.____sys_sendmsg
     98.57           -98.6        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.sock_diag_rcv.netlink_unicast.netlink_sendmsg
     99.57           -62.8       36.75 ±107%  perf-profile.calltrace.cycles-pp.netlink_unicast.netlink_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     99.58           -62.8       36.82 ±107%  perf-profile.calltrace.cycles-pp.netlink_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
     99.58           -62.8       36.82 ±107%  perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     99.60           -62.8       36.84 ±107%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
     99.60           -62.8       36.84 ±107%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg
     99.60           -62.8       36.84 ±107%  perf-profile.calltrace.cycles-pp.sendmsg
     99.59           -62.8       36.83 ±107%  perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
     99.59           -62.8       36.83 ±107%  perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00           +36.2       36.16 ±108%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_diag_dump.netlink_dump.__netlink_dump_start.unix_diag_handler_dump
      0.00           +36.7       36.65 ±107%  perf-profile.calltrace.cycles-pp.unix_diag_dump.netlink_dump.__netlink_dump_start.unix_diag_handler_dump.sock_diag_rcv_msg
      0.00           +36.7       36.69 ±107%  perf-profile.calltrace.cycles-pp.netlink_dump.__netlink_dump_start.unix_diag_handler_dump.sock_diag_rcv_msg.netlink_rcv_skb
      0.00           +36.7       36.70 ±107%  perf-profile.calltrace.cycles-pp.__netlink_dump_start.unix_diag_handler_dump.sock_diag_rcv_msg.netlink_rcv_skb.netlink_unicast
      0.00           +36.7       36.70 ±107%  perf-profile.calltrace.cycles-pp.unix_diag_handler_dump.sock_diag_rcv_msg.netlink_rcv_skb.netlink_unicast.netlink_sendmsg
      0.00           +36.7       36.72 ±107%  perf-profile.calltrace.cycles-pp.sock_diag_rcv_msg.netlink_rcv_skb.netlink_unicast.netlink_sendmsg.____sys_sendmsg
      0.00           +36.7       36.72 ±107%  perf-profile.calltrace.cycles-pp.netlink_rcv_skb.netlink_unicast.netlink_sendmsg.____sys_sendmsg.___sys_sendmsg
     99.55           -99.6        0.00        perf-profile.children.cycles-pp.sock_diag_rcv
     99.10           -99.1        0.00        perf-profile.children.cycles-pp.__mutex_lock
     98.60           -98.6        0.00        perf-profile.children.cycles-pp.osq_lock
     99.57           -62.8       36.75 ±107%  perf-profile.children.cycles-pp.netlink_unicast
     99.58           -62.8       36.82 ±107%  perf-profile.children.cycles-pp.netlink_sendmsg
     99.58           -62.8       36.82 ±107%  perf-profile.children.cycles-pp.____sys_sendmsg
     99.60           -62.8       36.85 ±107%  perf-profile.children.cycles-pp.sendmsg
     99.59           -62.8       36.83 ±107%  perf-profile.children.cycles-pp.___sys_sendmsg
     99.59           -62.8       36.83 ±107%  perf-profile.children.cycles-pp.__sys_sendmsg
      0.51 ±  2%      -0.3        0.22 ± 27%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.50 ±  2%      -0.3        0.21 ± 27%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.62 ±  2%      -0.3        0.35 ± 18%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.64 ±  2%      -0.3        0.37 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.38 ±  3%      -0.2        0.15 ± 22%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.39 ±  3%      -0.2        0.17 ± 16%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.36 ±  4%      -0.2        0.14 ± 21%  perf-profile.children.cycles-pp.tick_sched_handle
      0.36 ±  3%      -0.2        0.14 ± 21%  perf-profile.children.cycles-pp.update_process_times
      0.31 ±  4%      -0.2        0.12 ± 19%  perf-profile.children.cycles-pp.scheduler_tick
      0.24 ±  3%      -0.2        0.08 ± 31%  perf-profile.children.cycles-pp.task_tick_fair
      0.17 ±  6%      -0.0        0.12 ± 14%  perf-profile.children.cycles-pp.main
      0.17 ±  6%      -0.0        0.12 ± 14%  perf-profile.children.cycles-pp.run_builtin
      0.17 ±  6%      -0.0        0.13 ± 15%  perf-profile.children.cycles-pp.cmd_record
      0.17 ±  5%      -0.0        0.12 ± 14%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.16 ±  5%      -0.0        0.12 ± 12%  perf-profile.children.cycles-pp.perf_mmap__push
      0.09 ±  5%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.writen
      0.09 ±  4%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.write
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.ksys_write
      0.07 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.10            +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.09 ±  4%      +0.0        0.13 ± 26%  perf-profile.children.cycles-pp.rcu_core
      0.10 ±  3%      +0.0        0.14 ± 17%  perf-profile.children.cycles-pp.__do_softirq
      0.05            +0.1        0.12 ± 48%  perf-profile.children.cycles-pp.__sys_recvmsg
      0.06 ±  8%      +0.1        0.14 ± 47%  perf-profile.children.cycles-pp.recvmsg
      0.00            +0.1        0.09 ± 48%  perf-profile.children.cycles-pp.netlink_recvmsg
      0.00            +0.1        0.09 ± 48%  perf-profile.children.cycles-pp.sock_recvmsg
      0.02 ± 99%      +0.1        0.12 ± 47%  perf-profile.children.cycles-pp.___sys_recvmsg
      0.00            +0.1        0.10 ± 49%  perf-profile.children.cycles-pp.____sys_recvmsg
      0.07            +0.1        0.18 ± 49%  perf-profile.children.cycles-pp.sk_diag_fill
      0.00            +0.1        0.12 ± 62%  perf-profile.children.cycles-pp._raw_read_lock
      0.00            +0.2        0.18 ± 61%  perf-profile.children.cycles-pp.sock_i_ino
      0.00            +0.9        0.85 ± 60%  perf-profile.children.cycles-pp.__wake_up
      0.00            +1.1        1.07 ± 60%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00           +23.6       23.58 ± 63%  perf-profile.children.cycles-pp.netlink_create
      0.00           +23.6       23.62 ± 63%  perf-profile.children.cycles-pp.__sock_create
      0.00           +23.7       23.65 ± 62%  perf-profile.children.cycles-pp.__sys_socket
      0.00           +23.7       23.65 ± 62%  perf-profile.children.cycles-pp.__x64_sys_socket
      0.00           +23.7       23.66 ± 62%  perf-profile.children.cycles-pp.__socket
      0.29           +35.9       36.21 ±108%  perf-profile.children.cycles-pp._raw_spin_lock
      0.42           +36.3       36.67 ±107%  perf-profile.children.cycles-pp.unix_diag_dump
      0.44           +36.3       36.70 ±107%  perf-profile.children.cycles-pp.__netlink_dump_start
      0.44           +36.3       36.70 ±107%  perf-profile.children.cycles-pp.unix_diag_handler_dump
      0.44           +36.3       36.72 ±107%  perf-profile.children.cycles-pp.sock_diag_rcv_msg
      0.44           +36.3       36.72 ±107%  perf-profile.children.cycles-pp.netlink_rcv_skb
      0.44           +36.3       36.73 ±107%  perf-profile.children.cycles-pp.netlink_dump
      0.00           +38.9       38.94 ± 63%  perf-profile.children.cycles-pp.__sock_release
      0.00           +38.9       38.94 ± 63%  perf-profile.children.cycles-pp.netlink_release
      0.00           +38.9       38.94 ± 63%  perf-profile.children.cycles-pp.sock_close
      0.00           +39.0       38.98 ± 63%  perf-profile.children.cycles-pp.__fput
      0.00           +39.0       38.99 ± 62%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00           +39.0       39.01 ± 62%  perf-profile.children.cycles-pp.__close
      0.00           +94.8       94.81        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     98.02           -98.0        0.00        perf-profile.self.cycles-pp.osq_lock
      0.06 ±  6%      +0.1        0.15 ± 54%  perf-profile.self.cycles-pp.unix_diag_dump
      0.00            +0.1        0.11 ± 60%  perf-profile.self.cycles-pp._raw_read_lock
      0.00            +0.3        0.25 ± 51%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.26 ±  2%      +2.6        2.82 ± 72%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00           +94.7       94.65 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


