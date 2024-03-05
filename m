Return-Path: <linux-kernel+bounces-91719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED918715A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35CF283519
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEF47E0E8;
	Tue,  5 Mar 2024 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2yF4/Mq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0207B3F8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618920; cv=fail; b=bdZOq5e6gqFJbskHHwt3sB7fW0PiZAUizYul/dQw/9K4GV6J7+rf2fg+iP80x9xZ0GflZsTGIjey/OuYjxRg9O2iAaXPXZB2jy+HfCskAyASvFg9vXgtgCnXi+ypyY8PdgdSmBnZqwKJKcXbcTQTRUAAebcezwiojDb1QUYHJo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618920; c=relaxed/simple;
	bh=MBN55b19mlGcRUmxP6kcDOC0SU1Jn0TS7ySInooV1Nw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EcWiyQU9ojJBRhZ/e7xhaHJyQf4uQsdhs0d8AZ6CNENEJUiUvbJIAjIt+0JA01PtWiEHXuZeUcWPN9dXYMYw+IK+VY8CoWaC7jY4PpYyGX58GPDYBv1d0FTrvwdr4+ZOpSJsi/w4ITn0QuIVyFg/t7TbnXihsG5si48VlchqraU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2yF4/Mq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709618918; x=1741154918;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MBN55b19mlGcRUmxP6kcDOC0SU1Jn0TS7ySInooV1Nw=;
  b=m2yF4/Mq8UezU3laYdmYev4XmAJvnbRGIC2zwNZ/c8//rnS8GC6bb1eW
   kwrOAiUtljmCJH0wavnYtnOSNpqGauA6VMVb/gHN9u2t+uSj1xrEw/Dcp
   hEuVmzpkyulOCsOOnBmanJtkXcNHorah2tj+SqJ/u0R1kR2Yxq/T4uu2R
   OvDWquJbiG094vdxOTC+orF3V23FskdQBHX+malmEgg/3CN5Yh+csW313
   O9SkHK9YILkCsN4BwB4+JvNRVkV4HeX2kOJpItz2bmvuU1A1ssYXDjKxk
   A0XmEyRoj5eBXOKq0PoGKYDON9lglDmT9QCFqlWWSouXLM98evuD8vNzg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4309142"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4309142"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 22:08:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9837290"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 22:08:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 22:08:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 22:08:35 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 22:08:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ3B25XbfYIBH+Vc+yJnGHvhiSAWMuJpU83ttYM8KpA9fDMa7yTIEylr8YU9rKKbUiGQloznWlXYtnbshq5webJcAllhmJPVSyTqR17cpucsGyZ02mJRaZk0LDVTKWBkPlNAQp/HTznOmmICcj+EzQLZwc+6PRKnt4lUaer7y04vX1og3e/OcB8cSiKjUElZ4vdNVkeKuUmWdsOcKInvpjz4+A3GGUG/T4b1ZW2Sz2EFykeMcjTJhQTfChVcvKOp9V1YBVwnH8zKO3XcEzUTB2E+3fuk4g0INeKuwEK/TePp7vWe1UQjaNl06BkAcXwL7gbZyFvjzmkMYYaDb58uMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oacI+T06jbtyy8UuylT2vg3GYNrLDhg/CaDh242g60I=;
 b=oXtjJogw+6qum7zluHFuY/MZk+QwpJdy1ZAFYuI5jqAS7k4sLFq8UCGHOu8DCePJWGFeekMrCXPogEapX5FAR4vgF7uKOeyC457YXpU2RB2BM+iyJLEegcgO7JNtsTyQtYdaSQD8P/Im4CcIx6W/R+iX9unCooUHHGHgwT1HXrvQ7ortEJJR2+IocsvjaCnyLbBiDzOjBDUxxeTmgTo3rIlbSRH4Xy/a2gd0o/ANcTMzwaqmYRPkPyRWHaltxMzfjRJ8w2FyH0UuIzsY2hodbrTNpmUSwJFAa7bpfPJ4QcRsoVY6/ZK7/tYZy3mvFScfJ714Kw+9dMSycy7ZiYTi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 06:08:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 06:08:33 +0000
Date: Tue, 5 Mar 2024 14:08:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oscar Salvador <osalvador@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Vlastimil
 Babka" <vbabka@suse.cz>, Marco Elver <elver@google.com>, Andrey Konovalov
	<andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, Michal Hocko
	<mhocko@suse.com>, <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [mm,page_owner]  4bedfb314b:
 BUG:KASAN:null-ptr-deref_in_init_page_owner
Message-ID: <202403051032.e2f865a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9a836b-c5c6-4fb1-673e-08dc3cdaaff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+hQqS8kOqbNArXq7vBhpVeVwk/CPd4XQrRlKmwD3ghPytl0mpt/35vhngA2PtVxV9fQplwwWpQoCS4bUSV8gPOWNFxyaECn09sHBrK0on2CzzO/uiweNJRTtb3ZKJDaWEl8PEB6IeGEM4/zeR1Iz8WqmF5tZDP5bFwge8FwzC1X1dZHJmnmJQhJjmcgBowQNHtw8JRFbLCIUuCHC8u7eBnsio+L6Zi93AyEEBawp+172wYHv9Bo+uEtBeBQSIzJjcUZkcs3qS4YCuNFsI06K1z92LS0ufOMvutbLG4MQZKOse9o36e1Zc6fV/3QLipRZagDe80HEzAzWV4JERiShXft/A9WXIzQg6bJc6YkjA6qx++qUytK71XJ9bdp1L2rZL8VinuxspJO8isXF04PT4XfGhSZk6jTHrt35RPiKwUhVBLu1aMt6Y+AfK2nuDuafBdBRGeW88EJJZqIBz6/Bw8n4VR/jzXYqnOjD0XJb0xqBSVvNVPIRffkd69zjyI+hRtvjWEGdxSVLibcHG8TYn/rnqmQ1oWjrl5T3vXR97642dOPY0V9TKHYR5u2p9y9ENam+QMlzN/83+YSdRH+5+F2EEm4GpSSBWvn8/4FffxiC89G/JDF/tBQQF39Yb4m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LK5PcktGeCPDhH5GlKU/KZsxjsW80cDidTujvvIbnPUBm1q9g94431/H5jeS?=
 =?us-ascii?Q?0D382mhVRiMdr5XCIrBZlKL/BVuIzD9rq238S9Z3x5q9smyBq3s69NZ6WwzE?=
 =?us-ascii?Q?L6XcuOBfgOBSY8Rkm4tJRZLxg1ifnHKobl3OQbEWzcfZaDdzpjdjLqiPjDbs?=
 =?us-ascii?Q?83dyxPySbL5EHosztlTXwFi3QEUaw1TV9V5XrC4qc1QA65Z/KpVXTrL4e56/?=
 =?us-ascii?Q?rUIuw5h57trK5NDVbnRELBHKpcU2mKvaHggJyQ+lWhH73ZkL6cV6lqCwiwan?=
 =?us-ascii?Q?iexmkHmijxlMEphXuLvon4uMyYn35tsj/oOj2kRqeq3qGEvAsRYLnS0cb/z9?=
 =?us-ascii?Q?QdhF/qti85GvUqMBlDqtzHctKem639QZcwxDcqqafb/bPWkWBAlme9Nb2QY7?=
 =?us-ascii?Q?Z10qJ78WpotQdjuzCQo0iltMwhQbxAmC1j8xxWljZjow+bJ0wtf/9jDnnM4F?=
 =?us-ascii?Q?IBk6dzGQKh29saggeesJ6o8FBVU6d6DIpZWozd/h5IPuL0fDXtEXJsB/E9mF?=
 =?us-ascii?Q?+HWf8lkL92TBDJfQ+WTLxElmWntTTVR+kT0ZavduHFI6cCDbheBvcrTaQeFg?=
 =?us-ascii?Q?JytpqDqtI1EkPGFI8+SoL5s70znspX9oYO4mndCUDuiZNEBtNTG+gkT25G69?=
 =?us-ascii?Q?6GXwhPMTFkLw01mXtzPD62hwRAcHIPHDUOEeIfF7Yay/z9QyVT4DYdJ9kbUM?=
 =?us-ascii?Q?+OSqLohyEaVd+TcRtXs8rrmNhTzonQ1OeF2GWmEYUGLvcZRldduBnTruraF9?=
 =?us-ascii?Q?2RpNBzqChepazyoJ2QN1CNsGiskrZfx53xkudGdzqoml7JBh+IzM/UyApaWH?=
 =?us-ascii?Q?zRKsGwjDdc+Ms0FOeUlx450lFK0Mz6DpJHekqMcwDkibGZJPqLKD+FbrvIn7?=
 =?us-ascii?Q?qv1Ap3JPS7YYuKIfN6DyNO+VmwVys6Y4f1xR6deJDC/v2VUwi6qOp6nTE20Y?=
 =?us-ascii?Q?mXsFpe/mvPViPGXn0aSB/8C9vBiYbryhtwV/qVQHLe8mGpTgdEuEukKrYVKc?=
 =?us-ascii?Q?lgE4JOWfU384PLIo2YsFiVJdwh07HEymbuTO3DRAZeQBgLXqQDxd4NegiKi+?=
 =?us-ascii?Q?u9EyA0sp6yleqG0+/3pGbnEGF6TUSMPX5kRPb3U5OjdNjqLr1zlQseYa6lxX?=
 =?us-ascii?Q?XT/r8aF3tE42QMI8qfi5OhYswTl/wXYHgi005GQstafaj86XXR9oMjwLVdJV?=
 =?us-ascii?Q?/gcMWYjL8usxWEUsBVaUI7N0/xZjvCrt9pmdSn00WxOqJPmL/2byV1n8M/Rq?=
 =?us-ascii?Q?ZufxAuOoUY3OvvpPpn3ORVQC2J7gRVPCpUaGnkOydkex6gN5e0ryTo9EnJ6L?=
 =?us-ascii?Q?6mSr7FRDFUS4krXrLk295LA3RsBYI7xNkWEteJBBlxZ/qQlqL7erFGqSFYfW?=
 =?us-ascii?Q?+ZzuaEt3jMGI6to6NXY5oQvQpfuG6LnWLFZZtJkwAhEZz5cma8fGu9H1HBKW?=
 =?us-ascii?Q?O9OynnBhczRFTFCcdogm0u76L2t1bZgtMbWJ604ZuE70lOGLK03EkhGyO8ed?=
 =?us-ascii?Q?lhi6zk6jHDivK08jI3GCcrkxwy7CocSfbpH1I0xmMGjDNJaghKQkIFbV8GZO?=
 =?us-ascii?Q?CHKm0K8T9YLkFzHd/3QjDro/LkqMlCMENf4cgQxdSjCYHXIPMoBu0V+8ZJot?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9a836b-c5c6-4fb1-673e-08dc3cdaaff5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:08:33.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfNQo8LsVP/CSAi7kQsPYb6fO+qZsgw/37W+3qtkKTsRT0Qw+aRf70eKXvWqKgQMmom1Eqf508LmyKzg+73SBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_init_page_owner" on:

commit: 4bedfb314bdd85c1662ecc46fa25b33b998f994d ("mm,page_owner: maintain own list of stack_records structs")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 67908bf6954b7635d33760ff6dfc189fc26ccc89]

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------+------------+------------+
|                                                           | 8151c7a35d | 4bedfb314b |
+-----------------------------------------------------------+------------+------------+
| BUG:KASAN:null-ptr-deref_in_init_page_owner               | 0          | 24         |
| canonical_address#:#[##]                                  | 0          | 24         |
| RIP:init_page_owner                                       | 0          | 24         |
| Kernel_panic-not_syncing:Fatal_exception                  | 0          | 24         |
+-----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403051032.e2f865a-lkp@intel.com


[    6.582562][    T0] Node 0, zone    DMA32: page owner found early allocated 0 pages
[    6.612136][    T0] Node 0, zone   Normal: page owner found early allocated 73871 pages
[    6.612762][    T0] ==================================================================
[ 6.613351][ T0] BUG: KASAN: null-ptr-deref in init_page_owner (arch/x86/include/asm/atomic.h:28) 
[    6.613893][    T0] Write of size 4 at addr 000000000000001c by task swapper/0
[    6.614434][    T0]
[    6.614600][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G                T  6.8.0-rc5-00256-g4bedfb314bdd #1 29e70169ace75ef72d53825e983f3dcb1d5756d9
[    6.615605][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    6.616367][    T0] Call Trace:
[    6.616604][    T0]  <TASK>
[ 6.616816][ T0] ? dump_stack_lvl (lib/dump_stack.c:?) 
[ 6.617161][ T0] ? print_report (mm/kasan/report.c:?) 
[ 6.617499][ T0] ? init_page_owner (arch/x86/include/asm/atomic.h:28) 
[ 6.617863][ T0] ? kasan_report (mm/kasan/report.c:603) 
[ 6.618206][ T0] ? init_page_owner (arch/x86/include/asm/atomic.h:28) 
[ 6.618567][ T0] ? kasan_check_range (mm/kasan/generic.c:?) 
[ 6.618940][ T0] ? init_page_owner (arch/x86/include/asm/atomic.h:28) 
[ 6.619301][ T0] ? mm_core_init (mm/mm_init.c:2790) 
[ 6.619627][ T0] ? start_kernel (init/main.c:934) 
[ 6.619969][ T0] ? x86_64_start_reservations (??:?) 
[ 6.620380][ T0] ? x86_64_start_kernel (??:?) 
[ 6.620751][ T0] ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 
[    6.621204][    T0]  </TASK>
[    6.621420][    T0] ==================================================================
[    6.622015][    T0] Disabling lock debugging due to kernel taint
[    6.622474][    T0] general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT KASAN PTI
[    6.623342][    T0] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
[    6.623960][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G    B           T  6.8.0-rc5-00256-g4bedfb314bdd #1 29e70169ace75ef72d53825e983f3dcb1d5756d9
[    6.624959][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 6.625725][ T0] RIP: 0010:init_page_owner (arch/x86/include/asm/atomic.h:28) 
[ 6.626133][ T0] Code: 9c 8e ee fb 48 89 05 55 8f 2d 01 48 8b 1d 0e 8f 2d 01 48 83 c3 1c 48 89 df be 04 00 00 00 e8 dd 5c 8b fa 48 89 d8 48 c1 e8 03 <8a> 04 28 84 c0 0f 85 8a 00 00 00 c7 03 01 00 00 00 48 8b 1d 1e 8f
All code
========
   0:	9c                   	pushf
   1:	8e ee                	mov    %esi,%gs
   3:	fb                   	sti
   4:	48 89 05 55 8f 2d 01 	mov    %rax,0x12d8f55(%rip)        # 0x12d8f60
   b:	48 8b 1d 0e 8f 2d 01 	mov    0x12d8f0e(%rip),%rbx        # 0x12d8f20
  12:	48 83 c3 1c          	add    $0x1c,%rbx
  16:	48 89 df             	mov    %rbx,%rdi
  19:	be 04 00 00 00       	mov    $0x4,%esi
  1e:	e8 dd 5c 8b fa       	call   0xfffffffffa8b5d00
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	8a 04 28             	mov    (%rax,%rbp,1),%al		<-- trapping instruction
  2d:	84 c0                	test   %al,%al
  2f:	0f 85 8a 00 00 00    	jne    0xbf
  35:	c7 03 01 00 00 00    	movl   $0x1,(%rbx)
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	1d                   	.byte 0x1d
  3e:	1e                   	(bad)
  3f:	8f                   	.byte 0x8f

Code starting with the faulting instruction
===========================================
   0:	8a 04 28             	mov    (%rax,%rbp,1),%al
   3:	84 c0                	test   %al,%al
   5:	0f 85 8a 00 00 00    	jne    0x95
   b:	c7 03 01 00 00 00    	movl   $0x1,(%rbx)
  11:	48                   	rex.W
  12:	8b                   	.byte 0x8b
  13:	1d                   	.byte 0x1d
  14:	1e                   	(bad)
  15:	8f                   	.byte 0x8f
[    6.627591][    T0] RSP: 0000:ffffffff85e07eb8 EFLAGS: 00010007
[    6.628035][    T0] RAX: 0000000000000003 RBX: 000000000000001c RCX: ffffffff811f54d8
[    6.628619][    T0] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff85f3f220
[    6.629202][    T0] RBP: dffffc0000000000 R08: ffffffff85f3f227 R09: 1ffffffff0be7e44
[    6.629788][    T0] R10: dffffc0000000000 R11: fffffbfff0be7e45 R12: ffffffff86d96298
[    6.630372][    T0] R13: 1ffffd40021ffff8 R14: ffffffff86d96888 R15: 0000000000440000
[    6.630956][    T0] FS:  0000000000000000(0000) GS:ffffffff85f0e000(0000) knlGS:0000000000000000
[    6.631610][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.632091][    T0] CR2: ffff88843ffff000 CR3: 0000000005ef2000 CR4: 00000000000000b0
[    6.632677][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.633261][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.633849][    T0] Call Trace:
[    6.634085][    T0]  <TASK>
[ 6.634296][ T0] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 6.634614][ T0] ? die_addr (arch/x86/kernel/dumpstack.c:?) 
[ 6.634930][ T0] ? exc_general_protection (arch/x86/kernel/traps.c:?) 
[ 6.635339][ T0] ? kasan_report (mm/kasan/report.c:?) 
[ 6.635682][ T0] ? asm_exc_general_protection (arch/x86/include/asm/idtentry.h:564) 
[ 6.636104][ T0] ? add_taint (arch/x86/include/asm/bitops.h:60 include/asm-generic/bitops/instrumented-atomic.h:29 kernel/panic.c:543) 
[ 6.636413][ T0] ? init_page_owner (arch/x86/include/asm/atomic.h:28) 
[ 6.636775][ T0] ? init_page_owner (arch/x86/include/asm/atomic.h:28) 
[ 6.637136][ T0] ? mm_core_init (mm/mm_init.c:2790) 
[ 6.637465][ T0] ? start_kernel (init/main.c:934) 
[ 6.637810][ T0] ? x86_64_start_reservations (??:?) 
[ 6.638222][ T0] ? x86_64_start_kernel (??:?) 
[ 6.638594][ T0] ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 
[    6.639046][    T0]  </TASK>
[    6.639263][    T0] Modules linked in:
[    6.639547][    T0] ---[ end trace 0000000000000000 ]---
[ 6.639942][ T0] RIP: 0010:init_page_owner (arch/x86/include/asm/atomic.h:28) 
[ 6.640348][ T0] Code: 9c 8e ee fb 48 89 05 55 8f 2d 01 48 8b 1d 0e 8f 2d 01 48 83 c3 1c 48 89 df be 04 00 00 00 e8 dd 5c 8b fa 48 89 d8 48 c1 e8 03 <8a> 04 28 84 c0 0f 85 8a 00 00 00 c7 03 01 00 00 00 48 8b 1d 1e 8f
All code
========
   0:	9c                   	pushf
   1:	8e ee                	mov    %esi,%gs
   3:	fb                   	sti
   4:	48 89 05 55 8f 2d 01 	mov    %rax,0x12d8f55(%rip)        # 0x12d8f60
   b:	48 8b 1d 0e 8f 2d 01 	mov    0x12d8f0e(%rip),%rbx        # 0x12d8f20
  12:	48 83 c3 1c          	add    $0x1c,%rbx
  16:	48 89 df             	mov    %rbx,%rdi
  19:	be 04 00 00 00       	mov    $0x4,%esi
  1e:	e8 dd 5c 8b fa       	call   0xfffffffffa8b5d00
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	8a 04 28             	mov    (%rax,%rbp,1),%al		<-- trapping instruction
  2d:	84 c0                	test   %al,%al
  2f:	0f 85 8a 00 00 00    	jne    0xbf
  35:	c7 03 01 00 00 00    	movl   $0x1,(%rbx)
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	1d                   	.byte 0x1d
  3e:	1e                   	(bad)
  3f:	8f                   	.byte 0x8f

Code starting with the faulting instruction
===========================================
   0:	8a 04 28             	mov    (%rax,%rbp,1),%al
   3:	84 c0                	test   %al,%al
   5:	0f 85 8a 00 00 00    	jne    0x95
   b:	c7 03 01 00 00 00    	movl   $0x1,(%rbx)
  11:	48                   	rex.W
  12:	8b                   	.byte 0x8b
  13:	1d                   	.byte 0x1d
  14:	1e                   	(bad)
  15:	8f                   	.byte 0x8f


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240305/202403051032.e2f865a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


