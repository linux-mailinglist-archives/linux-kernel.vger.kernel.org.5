Return-Path: <linux-kernel+bounces-57388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8584D7D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B44228729E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF9171A4;
	Thu,  8 Feb 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBZ0BIJb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A11B816
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359535; cv=fail; b=KovH8zUEqiLAYZNbcMYlPv1pfo72cBP9uApQENwuMqzOYjxYFfFV0i4sj2Dj3BmRKgvSrLO9vu7cOIpG7OMzK4CD8gqgCfV1QSY2eyTUhjz2w2ALoPBJOYFvvK49X8A2a+Gh9bSIQ4Kh7nwnsvgVJrLzxBSOU0vR1y1p854NaZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359535; c=relaxed/simple;
	bh=ubhWA6AMVbrR3kQK2TrEz9bMVU38VnbxlNgFlsuHtP8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=mYABloQ3yJd4rwMdyh9zRsmbw94Ae6hyi7UvkP1Sfl+1N03xEHFoI4rGiXdYi1IhwJ4PKnJTDTbRv2NjsAZPvUIhWlSDZ6l1+eGPkO/fEPwJ+RGi1yz3AqDzQnJVLkvqaGa2DHQtZSherZAOxzAlR1GGTQuGN8c9gptijmAd+EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBZ0BIJb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707359533; x=1738895533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ubhWA6AMVbrR3kQK2TrEz9bMVU38VnbxlNgFlsuHtP8=;
  b=WBZ0BIJbKlf+5V5pRVet85V7C0nZ7JYQE0Rt+QO9HJhu0PfhRKUkY2nA
   oqD1QWqkrPT+X8ecWo1kJd3FvxciIV9ZU4GhLdko0OcV2SLeUbuhgH5hi
   WeqlMpUSMAAF/o5wCSsPt3Tal5ucqK77a8lPLYkFUs/USHrZttSBRZUwe
   FaizUxMXPeUgAi/KMopmeiR2MoOWquiYBQoVWpCgmrc4PqccHNcY6wtxk
   jrQ5cSym+JHnYM6TnTgKG11KkbLlpyEMMq80RRbEsCN3Wq870ycoZBqHT
   UoGalClsP3mn6/FkldPCPmOEJRqG36bnosEid+x4uLRJss/vX/7sf2oJh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="26575950"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="26575950"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 18:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="32333593"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 18:32:12 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 18:32:11 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 18:32:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 18:32:10 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 18:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8dDQ2VCvOAyy573NW880TqfJ4yWf7IDzoUA5EEnLY0njoQGyyALFkq2VPvQ3KYIU/dSVWFFg2j1oT3KMlf6/M74e2PQsuClhOs//5oy578+UsISavNjOMuU+sL0SzvcBCEvYHlIqfzxqgR1xumt+5urGFfgOyO6mMsBSnbueYoC3cjAGPFdVBrzv6ZZ3O5zB06GJRPFdNC+AuakEqNSZqBXuwjmC6ObrgA7ZAfsee3aWX11OA2YXYZ81xQP0CFtxk5FUAkOUgGqeHwcEC27quqxxnfRXavO1wNHYxB/JOuoJMC5SzVqO4oJZu6kHHrji9W7XjIerZkHYi7yvJUT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llcnreKBYxztD3ReKo94OWAqnOYLZUXsQXYWzAnr5OQ=;
 b=gAuzWnpDmvexmQYnlXMI6f+M2TnzV5OaL5R52nUu3wUI/c+RU26l/15c3qcTl2Mj47AHdNycr48xIBvSZncdkqJEr/zr5HpmUyNWb9icRUU1jzHI2elnEtrDeCHz/+BMEhgn/TBrkDS/KqoEI3w4GFQpnNv/hZm8UOcTvospT24irwcQd30qJHgmVQFXtptSTmhE2hBfWrlOMn9hPXqkXSX2g213Ls6DwMPRCQ8U7Nsj3Zvw9FtQKTIAFAFtpsBaRvf86dQRMl77Wm7W42zD58gdP6FDJFnkzr5y6x1j4Apo3Uhe5sr/jfJV0ECY3sMiTm1IFskO/NF/cyXVSeQ/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 02:32:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 02:32:08 +0000
Date: Thu, 8 Feb 2024 10:32:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Daniel Gomez
	<da.gomez@samsung.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [mcgrof:20240131-test-xarray] [test_xarray] 3bc2ee924e:
 WARNING:at_kernel/rcu/tree_stall.h:#rcu_check_gp_start_stall
Message-ID: <202402071613.70f28243-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: b4932e87-3f73-4681-b692-08dc284e25af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wwFBFcK50zjT/yu32VgD/BFmAdQ3nWj+PudGlMnLsMTt9BiraAD+xuRLJ+82n4+eyocjzXseGtOwZWkFfXA4z8GgckOLVXiigNv9v4eoRNYIND9cqWtYR9iahWxqkfgIIavrugYvUSTUBB8Y5UCdXb9nHTl1HKuzs3QDLFJgq0ZZt9EpXVuIrUICJHCRvhxsC60IAKV8ceQTWxDC/mAhX9o4UF7VHiQ5TE6iWbNlonS+jESPARJtZko56PtklQHQCa9OONdiacniRsakrdE1+Tcm4EI6KIzn/qwh2wOfRIMLvfHsBlTGJGr2iUrRWDhMKdRkxNUJnxlx5066RBqPeW91SFSzbMnzA7CqhutBPVjDdTydmGwNamzxk4cwH8geDSJZg7xtroCuqDPhbLVXGzWf7s4OYb1BHWklOtNNDPXRV8A8GMiXntkfjcyx0bvtCYVO+HkAsNgGELmwRbJ6yQ0pB5yXAhRhMFNt8hVb8aLXMrUxhqmtwGd6lm3gPuJFP9/jp0N3kq41n0lzHfoc6hVuWRNIiLBe0KLbuVT2P+D/CwaQa95Kg47JMyTUsqPssjWdqnjsSmzQn2aa6PzRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(82960400001)(66476007)(66556008)(316002)(66946007)(6916009)(8936002)(6486002)(45080400002)(966005)(86362001)(5660300002)(4326008)(8676002)(2906002)(30864003)(38100700002)(107886003)(6512007)(6666004)(1076003)(2616005)(83380400001)(6506007)(26005)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/PJk7uUHVs3lzkHvfvEsfiHpu9B0z/oRAeYi0PLhNFjJPDlRe80GPH9X7kv?=
 =?us-ascii?Q?K/D9Sq6n9Iosr3VXXO7OoQFXu0zPgtC31DqbiqntMwgYAp4RVY86tK+zCifu?=
 =?us-ascii?Q?l4RkPXLBUg1DnQ/Ir36H0Fb2itdfXJ3SDIoAg8VlX5elKhfGJb+3jhBTNh7V?=
 =?us-ascii?Q?oJdlP/8Qac1l14R40Itcbdl6YYhh9LjoW2x6FazM0kLmDO6wQbO9eqU0pKRe?=
 =?us-ascii?Q?f+Jt3/P9ZtYsdRUiu1IWu/GnApVlecblPmthoeOturPkE6oZTsPEWUDtcIhr?=
 =?us-ascii?Q?sMkwQOjhRZGtIPcI2qoSEH+8ZK8E2D9P3xAUI7nsu6vB+cOrJAaijoa/0OaP?=
 =?us-ascii?Q?ad52Geg9eyh782j0b5ufc3LupTJe11EqZ3Va0ixIfoV6Rk4Mp9IQ9jfkX9MH?=
 =?us-ascii?Q?43oLpJZ/XmYpXdBG+aFNq2jLmKV68V4oZwOmwoFVc/YtgfOMk59qu/wooCdR?=
 =?us-ascii?Q?yldV9iK5sZ5v47JCugA/uu7VE4qVp3H1JKFSEyuEi2J8ExzsQUTVuufXaNGy?=
 =?us-ascii?Q?IkOuegvNN0IjYNBwe03R2oveNKvIxjWSto1fUkINfRDMWFgWiB2XtrQ3RLwi?=
 =?us-ascii?Q?3ugc1JrjanO++2PAu2pA6C42XhKmV7LvMwkF9HSYrnS+zTh7twJdoo3l9PW5?=
 =?us-ascii?Q?1RVZY0Ms1wAtGf1E2KtjbZy5BQzl7PuQYW+Uy8aAauZLtQV9U4Tnc3G1s87J?=
 =?us-ascii?Q?XkG1BF4SmCj/Q4rFTl2BLlM2AhqHJgp16FioGFzjqshVJ5mofHdv6VpJEGvO?=
 =?us-ascii?Q?a/5NU4S0BUpCCrSWX4jhfIjrq8VN7WfoQMncv7xvh4VYa0ngkfpJNyKctL8v?=
 =?us-ascii?Q?gMZvnaI5/Up0ElTsxQVETu9TpKaUoQb3i7tlvihqzZXsrRAQkHeD+N93ouhw?=
 =?us-ascii?Q?z/wytklOaailsZb4cK7ZC5WJL7l1jH8WKizMZ6CuIK5tfQwRphjBsczopNXl?=
 =?us-ascii?Q?ojtZyJ89peulG07loSXM7Y9WD/zHdZVE8mVXW0PaKiB0qLfCVgGTi0kDNn20?=
 =?us-ascii?Q?6lICWqCVOfmekKGrR5SlZjV2SHIUdfY/CRttUomnVL1f6OzIl1PAxoKqUpvn?=
 =?us-ascii?Q?z0DH46oQOyz+2rLc6zCu4ZmsL5evuQScVtUbEvWygZRAH9j8TkkITF9wizAM?=
 =?us-ascii?Q?kIIFmmrfSPrpGwUyuGVR5E/aS45YC74eH7A++4DPUXZ5ccfYIX0qAzPdhc3M?=
 =?us-ascii?Q?42HNI23F1BY+NM97IigfcJx6eK7XeThAJ8Sv7aZNS6finZlY5FBjwY53ejVF?=
 =?us-ascii?Q?BoXsowVVBjuA94fIy60Qimsms0lPZOC3SCvgQDmYJAGoP5uZMCp964Bus8WH?=
 =?us-ascii?Q?pZzWu71VOvJntr+2SocMavtFbugdU1HwP/7COSEdiw5Z7Dj2N6Lhb3EcH/Yk?=
 =?us-ascii?Q?DF7eP52qaWIKzb0UTnb47wkz3Tal7T39/VYsWUFxmmonHeNeGdJrODrrj7VY?=
 =?us-ascii?Q?wM9xQm7RwaetV8qs7ukRWB7DLHQ9XiPGVcTWSb6XE5LCwjwtBnGh/+KRreGX?=
 =?us-ascii?Q?Q1uqFcuIVvYKsTdo9yLP1cF805dQyLr8U5l+FUOBQzQ56Wl1++SzNb1EfBD8?=
 =?us-ascii?Q?BAlZ4OxgAvDkxewSEQfR/dIi9aagYWOE7GoLRgL8TiZ1GleRkIFoKWX+vSKq?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4932e87-3f73-4681-b692-08dc284e25af
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 02:32:08.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1pPYDsarFmPEnRCAxLcDgq5+QQymY/wnMNJE2ozUEtwnWYDqnjEIl1ZxXOcqP3vhhb9DiaWvli5pxR6VC5KDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/tree_stall.h:#rcu_check_gp_start_stall" on:

commit: 3bc2ee924e22d16abb6483d266f4c461f665fadf ("test_xarray: add tests for advanced multi-index use")
https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux.git 20240131-test-xarray

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402071613.70f28243-lkp@intel.com


[  157.401342][    C0] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 59s!
[  157.403783][    C0] Showing busy workqueues and worker pools:
[  157.405264][    C0] workqueue events: flags=0x0
[  157.406458][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=2/256 refcnt=3
[  157.406481][    C0]     pending: psi_avgs_work, stop_one_cpu_nowait_workfn
[  157.406529][    C0] workqueue events_power_efficient: flags=0x80
[  157.411631][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=4/256 refcnt=5
[  157.411655][    C0]     pending: neigh_managed_work, neigh_periodic_work, do_cache_clean, check_lifetime
[  157.411741][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  188.121356][    C0] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 89s!
[  188.123611][    C0] Showing busy workqueues and worker pools:
[  188.124965][    C0] workqueue events: flags=0x0
[  188.126133][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=2/256 refcnt=3
[  188.126154][    C0]     pending: psi_avgs_work, stop_one_cpu_nowait_workfn
[  188.126199][    C0] workqueue events_power_efficient: flags=0x80
[  188.131195][    C0]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=4/256 refcnt=5
[  188.131212][    C0]     pending: neigh_managed_work, neigh_periodic_work, do_cache_clean, check_lifetime
[  188.131260][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  202.629415][    C0] ------------[ cut here ]------------
[ 202.630948][ C0] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_stall.h:990 rcu_check_gp_start_stall+0x17f/0x2c0 
[  202.633356][    C0] Modules linked in:
[  202.633356][    C0] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        N 6.8.0-rc2-00001-g3bc2ee924e22 #1 147c3e57e8173b4ddcb54882b8d3ddba616ae71f
[  202.633356][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 202.633356][ C0] RIP: rcu_check_gp_start_stall+0x17f/0x2c0 
[ 202.633356][ C0] Code: d5 00 00 00 48 8b 15 e0 25 c2 02 48 01 f2 48 39 d0 0f 88 c2 00 00 00 b8 01 00 00 00 87 05 f5 49 60 04 85 c0 0f 85 af 00 00 00 <0f> 0b 48 81 fb 00 65 3d 9a 74 2c 8b 15 04 44 f9 02 85 d2 74 16 8b
All code
========
   0:	d5                   	(bad)
   1:	00 00                	add    %al,(%rax)
   3:	00 48 8b             	add    %cl,-0x75(%rax)
   6:	15 e0 25 c2 02       	adc    $0x2c225e0,%eax
   b:	48 01 f2             	add    %rsi,%rdx
   e:	48 39 d0             	cmp    %rdx,%rax
  11:	0f 88 c2 00 00 00    	js     0xd9
  17:	b8 01 00 00 00       	mov    $0x1,%eax
  1c:	87 05 f5 49 60 04    	xchg   %eax,0x46049f5(%rip)        # 0x4604a17
  22:	85 c0                	test   %eax,%eax
  24:	0f 85 af 00 00 00    	jne    0xd9
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 81 fb 00 65 3d 9a 	cmp    $0xffffffff9a3d6500,%rbx
  33:	74 2c                	je     0x61
  35:	8b 15 04 44 f9 02    	mov    0x2f94404(%rip),%edx        # 0x2f9443f
  3b:	85 d2                	test   %edx,%edx
  3d:	74 16                	je     0x55
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 81 fb 00 65 3d 9a 	cmp    $0xffffffff9a3d6500,%rbx
   9:	74 2c                	je     0x37
   b:	8b 15 04 44 f9 02    	mov    0x2f94404(%rip),%edx        # 0x2f94415
  11:	85 d2                	test   %edx,%edx
  13:	74 16                	je     0x2b
  15:	8b                   	.byte 0x8b
[  202.633356][    C0] RSP: 0000:ffffaaae80003f48 EFLAGS: 00010046
[  202.633356][    C0] RAX: 0000000000000000 RBX: ffffffff9a3d6500 RCX: 0000000000003b10
[  202.633356][    C0] RDX: 00000000ffff9d65 RSI: 000000000000668a RDI: 0000000000000000
[  202.633356][    C0] RBP: 0000000000000246 R08: 0000000000000000 R09: 0000000000000000
[  202.633356][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000009
[  202.633356][    C0] R13: 0000000000000100 R14: ffffffff9b1c4368 R15: 0000000000000009
[  202.633356][    C0] FS:  0000000000000000(0000) GS:ffffffff99e67000(0000) knlGS:0000000000000000
[  202.633356][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.633356][    C0] CR2: ffff96127ffff000 CR3: 00000002c7257000 CR4: 00000000000406b0
[  202.633356][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  202.633356][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  202.633356][    C0] Call Trace:
[  202.633356][    C0]  <IRQ>
[ 202.633356][ C0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 202.633356][ C0] ? __warn (kernel/panic.c:677) 
[ 202.633356][ C0] ? rcu_check_gp_start_stall+0x17f/0x2c0 
[ 202.633356][ C0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 202.633356][ C0] ? handle_bug (arch/x86/kernel/traps.c:238) 
[ 202.633356][ C0] ? exc_invalid_op (arch/x86/kernel/traps.c:259 (discriminator 1)) 
[ 202.633356][ C0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 202.633356][ C0] ? rcu_check_gp_start_stall+0x17f/0x2c0 
[ 202.633356][ C0] ? rcu_check_gp_start_stall+0x8b/0x2c0 
[ 202.633356][ C0] rcu_core (kernel/rcu/tree.c:2463) 
[ 202.633356][ C0] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554) 
[ 202.633356][ C0] irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644) 
[ 202.633356][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14)) 
[  202.633356][    C0]  </IRQ>
[  202.633356][    C0]  <TASK>
[ 202.633356][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:649) 
[ 202.633356][ C0] RIP: 0010:lock_is_held_type (kernel/locking/lockdep.c:5830) 
[ 202.633356][ C0] Code: 0f 00 00 b8 ff ff ff ff 0f c1 05 fe 65 22 01 83 f8 01 75 31 9c 58 f6 c4 02 75 44 48 f7 04 24 00 02 00 00 74 01 fb 48 83 c4 08 <44> 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f 31 d2 31 c9 31 f6 31 ff c3
All code
========
   0:	0f 00 00             	sldt   (%rax)
   3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   8:	0f c1 05 fe 65 22 01 	xadd   %eax,0x12265fe(%rip)        # 0x122660d
   f:	83 f8 01             	cmp    $0x1,%eax
  12:	75 31                	jne    0x45
  14:	9c                   	pushf
  15:	58                   	pop    %rax
  16:	f6 c4 02             	test   $0x2,%ah
  19:	75 44                	jne    0x5f
  1b:	48 f7 04 24 00 02 00 	testq  $0x200,(%rsp)
  22:	00 
  23:	74 01                	je     0x26
  25:	fb                   	sti
  26:	48 83 c4 08          	add    $0x8,%rsp
  2a:*	44 89 e0             	mov    %r12d,%eax		<-- trapping instruction
  2d:	5b                   	pop    %rbx
  2e:	5d                   	pop    %rbp
  2f:	41 5c                	pop    %r12
  31:	41 5d                	pop    %r13
  33:	41 5e                	pop    %r14
  35:	41 5f                	pop    %r15
  37:	31 d2                	xor    %edx,%edx
  39:	31 c9                	xor    %ecx,%ecx
  3b:	31 f6                	xor    %esi,%esi
  3d:	31 ff                	xor    %edi,%edi
  3f:	c3                   	ret

Code starting with the faulting instruction
===========================================
   0:	44 89 e0             	mov    %r12d,%eax
   3:	5b                   	pop    %rbx
   4:	5d                   	pop    %rbp
   5:	41 5c                	pop    %r12
   7:	41 5d                	pop    %r13
   9:	41 5e                	pop    %r14
   b:	41 5f                	pop    %r15
   d:	31 d2                	xor    %edx,%edx
   f:	31 c9                	xor    %ecx,%ecx
  11:	31 f6                	xor    %esi,%esi
  13:	31 ff                	xor    %edi,%edi
  15:	c3                   	ret
[  202.633356][    C0] RSP: 0000:ffffaaae80013cd8 EFLAGS: 00000286
[  202.633356][    C0] RAX: 0000000000000046 RBX: ffffffff9a3d4080 RCX: 0000000000000000
[  202.633356][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff99b17b04
[  202.633356][    C0] RBP: ffff960f44e56000 R08: 0000000000000000 R09: 0000000000000000
[  202.633356][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[  202.633356][    C0] R13: 00000000ffffffff R14: 0000000000000000 R15: ffff960f44e566f8
[ 202.633356][ C0] xas_descend (include/linux/xarray.h:1216 lib/xarray.c:206) 
[ 202.633356][ C0] xas_load (lib/xarray.c:245) 
[ 202.633356][ C0] test_get_entry+0x8f/0x1c0 
[ 202.633356][ C0] check_xa_multi_store_adv+0x41e/0x600 
[ 202.633356][ C0] check_multi_store_advanced+0x36/0x80 
[ 202.633356][ C0] xarray_checks (lib/test_xarray.c:1971) 
[ 202.633356][ C0] ? check_xas_retry+0xb00/0xb00 
[ 202.633356][ C0] do_one_initcall (init/main.c:1236) 
[ 202.633356][ C0] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 202.633356][ C0] kernel_init_freeable (init/main.c:1553) 
[ 202.633356][ C0] ? rest_init (init/main.c:1433) 
[ 202.633356][ C0] kernel_init (init/main.c:1443) 
[ 202.633356][ C0] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 202.633356][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 202.633356][ C0] ? rest_init (init/main.c:1433) 
[ 202.633356][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  202.633356][    C0]  </TASK>
[  202.633356][    C0] irq event stamp: 7770391
[ 202.633356][ C0] hardirqs last enabled at (7770390): rcu_core (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/rcu/tree_nocb.h:1738 kernel/rcu/tree.c:2457) 
[ 202.633356][ C0] hardirqs last disabled at (7770391): _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162) 
[ 202.633356][ C0] softirqs last enabled at (7770364): __do_softirq (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 202.633356][ C0] softirqs last disabled at (7770379): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644) 
[  202.633356][    C0] ---[ end trace 0000000000000000 ]---
[  202.738070][    C0] rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: 0x0 ->rt_priority 0 delta ->gp_start 26476 ->gp_activity 26475 ->gp_req_activity 26277 ->gp_wake_time 26277 ->gp_wake_seq 15120 ->gp_seq 15120 ->gp_seq_needed 15124 ->gp_max 2505 ->gp_flags 0x1
[  202.743977][    C0] rcu: 	rcu_node 0:0 ->gp_seq 15120 ->gp_seq_needed 15124 ->qsmask 0x0 .... ->n_boosts 0
[  202.746434][    C0] rcu: RCU callbacks invoked since boot: 121850
[  202.747976][    C0] rcu_tasks: RTGS_WAIT_CBS(11) since 46815 g:16 i:0/0 k.u. l:63
[  202.749977][    C0] rcu_tasks_rude: RTGS_WAIT_CBS(11) since 46816 g:16 i:0/4 k.u. l:63


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240207/202402071613.70f28243-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


