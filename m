Return-Path: <linux-kernel+bounces-61848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D45851764
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F43282405
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166103B799;
	Mon, 12 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1NeR66K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6573B2A1;
	Mon, 12 Feb 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749777; cv=fail; b=btqjTK1X9zIaGxaAFHefJUX1cMTnvsgznLgDi2nxrVA7rcwSvgo4OjFTwaWmI0zbDWTd7OiOD3CEDE3RHkoc+Hh5nVMliPv77CzRNT6+e34k+KyCgfdqBIGQubiXYHg07/c1KpF3bp2GqxGxMop6wbzTOx/cqI1+8f9DcEo7SPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749777; c=relaxed/simple;
	bh=Kw+uML1tZTiHg4eLPkadabIylV8JvoVrtpZv8+vUWfw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PhLQ5JO7OehNMVpZkDBYVmRWOgv4BHLc2ySAg6UkKRwsOJbOYmTNmyoe/i8c2yrvo4I9dQj7B+KKAOzbzCI3U3A9vZQ3/rgsDl531coYt6MeayaLwhiYi1BYHjgi59HYEIhSjviYj3ZxB2sKEtXFhfnmqrhxNZ0CxLA6e6vGP7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1NeR66K; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707749776; x=1739285776;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Kw+uML1tZTiHg4eLPkadabIylV8JvoVrtpZv8+vUWfw=;
  b=k1NeR66KGKEN3Ie+4IrZcsr4Hs7KLl+s6Hmjw181oyzXEhPh3+BHHddo
   iKnPuBJVW6BLMXteEaGvhBN9hUrjYuzWu/hOMUHV+IgFGUCTjv7nrkNRo
   pIMhtk/MEvDVIqmn2I1ZvGi+C+MysyZ3hfQ9Ycn8o/5YH3gWuMlcvwTWm
   lyVKmV+Rh6yUtGueOcGzuUGk/MYXnMJRa/nKRS/CBrubY1vdsZb5/MgSY
   U7ubvITtSWeacKE+YlRNAAXenOii3rM7gger9zzdm2Sh87kuPj1FwodA4
   DCQ+mv64Mt9yqGtsSSN5dVIhRAO3XvZlzY51uURHy9rl47+3ZqumJ7Z70
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1610153"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="1610153"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="7186965"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 06:56:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 06:56:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 06:56:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 06:56:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 06:56:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5xrV0oOar0KfShTZrYU7T6C34k/gTJqlLjKlO3SwAodhyg07aDZH8jg3Cq6FSsOygNfcparPgGJ8DQWoVAv1r81uioDGunbbRKjSgvC5bXiT8sghlxOBRcZNdahFgOoOj9gM+QzPZjRkVxzc/4R4VgJ+Qs+CNkju4I853T7Q9jgoE5cHxPYQlu7OG7EZCwJOvmgLGGtLnVYI8/fcp6xC7FF+/r8SArysqi+gX5LqJOB0If80TfxloQiMLKIVEMuenKq822HC8O31vtgWxDjGHbSEMPujnWpbI0BNoa4FgIz7MsZ9yyYuDfect0EtRzAfAtE8U4KRGGlkYVW+KgROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWhdAt38QGN9trzLWCdoiPt7LyaDsPXmv7y79V8zT9A=;
 b=WTjCaUpPeUnkTzKbMRZXzoJpx4QHPTQX8oddDrUl3HYE0AXutJrtc8wCT47tYLEXylw2NArqDCtQGrDgm+fcxDa0XYHaxCwk+62kyB7UOmCm4X2KKLr8Jn7hs5n0WLt49dgpjMLqRpuaXgk+op3HiwH94B38FLbhge3ILJw+PdzDbnBkgEf0VZJ4BE0oQdz+uPOMe4KmTCK5iwDRjdP0cTOrRta2UC3ml1ETfq+lypmRRBQEUbw0r//IRswywXu6LK4Mpf+RC6tSYcBy4NkM8HCTRCsxd28+OwOnTm0zOqXEV6xL6GcjpYr/fjZrF/ag1akI9+VLfS7WFvTOLofdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6748.namprd11.prod.outlook.com (2603:10b6:510:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 12 Feb
 2024 14:56:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 14:56:10 +0000
Date: Mon, 12 Feb 2024 22:56:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>, Kent Gibson
	<warthog618@gmail.com>, Alex Elder <elder@linaro.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Wolfram Sang
	<wsa@the-dreams.de>, <linux-kernel@vger.kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 07/24] gpio: protect the descriptor label with SRCU
Message-ID: <202402122228.e607a080-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208095920.8035-8-brgl@bgdev.pl>
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc71965-3b94-4a95-0979-08dc2bdabfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsbJDEi44wK8oNxOGOcfLdsDmmhIbCSCKnXYEJnJ5gtPS5o5PXoUoofmvkxCLwiSYEuORX2eAdSyjkhTgOUE8rPVvD0FI5eaZhEMCaA1lQ+GLbx4DbaG0coKLWsqz8aPKQwNhboDww7goZZ0rZ+HUuzc79BeRnjWuaLPe3IuyLyMWTYJkQF6IPxJejFu/FwdyDwxbyy06GT1z6FvcV/1ovqZbZzsmIeI/M2AFZf7oDs/gejMw6h1/CJcMLma4fpkwDWqSYLBrng9ndLB47Pz8CdbLggKHvm33+IMstiGKVgSPnaVlANQzBdEDyho8wokh/YbbcymC/lXjiNYczG3XOB+JDAO+8JoIyK0fLATbW40IRxm466RK1qeecXe7OaXNpvKZ/knamyMKcFBfx6IhNMbqc4I5lJtBptJCpaVKn5k3Sso08AMps56bqgAAP5kde84BoqPVSzYIVw6/+15sqbl6tVpo5RGswL2pookaTqzKQVLthvVB1uzAQ0iB2JWdedJCMp65PE/u/vrBARtLjleEwiSFC8CiTTe+eX5SD5aS7/+DqMuqPZdNx9Iy4am1tId1I6eJKs61ICSgynG8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66946007)(41300700001)(8936002)(66556008)(6916009)(54906003)(316002)(66476007)(4326008)(8676002)(83380400001)(86362001)(5660300002)(2906002)(1076003)(38100700002)(7416002)(6512007)(26005)(966005)(6486002)(45080400002)(478600001)(6506007)(6666004)(2616005)(36756003)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URONle5Ns7jaA5ZRg61Z/ARVKNzbaupOs2lPKDZFQ1DL1nLtInvrtRgpeM11?=
 =?us-ascii?Q?YwtOJfnQFx6Sec5col7PWPbTMrcTT9/qtgWw5R5RBdufd4VOzohmgwi9qfI2?=
 =?us-ascii?Q?1c9tF9GHFynDFX9X0RyVwAqD/46b58cbyipjeIDVuJNxWRGzeVV1MXaDwL+7?=
 =?us-ascii?Q?kUr4FAN7d9ZsPu4cQZaTLnxxFowDyFBMRIyyuFXaVbQjpi0zrjmUPs5Y5A7+?=
 =?us-ascii?Q?4anQumSRsdPPWU5lHfrORIQwePqannZblB5wshMKIKcHngvzz6pZQLYMvJtu?=
 =?us-ascii?Q?tqL5RhrWajskRDP9dU0UuReCXKeYbMLWKDreu3flCc2Tlpk59bSpHDtrzhE4?=
 =?us-ascii?Q?bg9H7XP/LBPhsclaqStSpyeMcJj+F2nRaGpIvzpZfMWa2L/jMB2awYkAAdYy?=
 =?us-ascii?Q?yMW5CoS4k5QLEbcl7gC0+cFt0a/LjL9HSveNU59c3Q8t0lwvQN6SEN3UfjF5?=
 =?us-ascii?Q?v0yVP0+nmkyWwxqSC8OQlkybs0hytr5gGCKcRAHIRbcOBqidWWdO3+SbzYgw?=
 =?us-ascii?Q?AZlQz99FegF/FIRNTQ9/8Ycr5BYKK/sIYH7id92rkeIGHZT/Y1jQGlEgk8wd?=
 =?us-ascii?Q?oCIu9nfGpRnuRXhV8MSd0j8uf4o2BW4v65GN5tNm9lNiql2NkSxugGPZRGOB?=
 =?us-ascii?Q?F2mfsM8wqFB3C1EGkZAMnj0BH3h87xtU3+VPLrSJdSWBg3qwYrl/OZz9hmfa?=
 =?us-ascii?Q?bFBcqmxTQdjTP6oqbXOC3ps8sdLbXitRo30R8H1dqoI3OlotSRI5ZZ1gsH2G?=
 =?us-ascii?Q?VoWp8AJJOEDZaj4wXVYO6h+xz/8bOXP2pBi48Bx2QlSr5BGcYjORciOm+nBl?=
 =?us-ascii?Q?wrejUlaGR1zmmmvEapqIdrtaPDo9LUEgd1syKJ5CKGw5U3BZ+esQ8lCXDw8C?=
 =?us-ascii?Q?TI6JZ2qw30ZIXuyuJbZsNLXhfwZv34NzP60+4RfPU2vmbJXjAOQMAuGeQ+mH?=
 =?us-ascii?Q?afyBa8GcGRYPNcjFa5uycyc4oRRteil6mzjWmTmnrnSrJgVQFTlTBlFJmiuE?=
 =?us-ascii?Q?46pbcP1e2JNVLeX+JoMcmnkATjCtHv1MA+WLdBpCPg7nfqxWRBCDBk+poy+y?=
 =?us-ascii?Q?gKvND2HPFr/r02JVMPecCQc0l1gDHBKT180CnNeQhe1ajGCTSF5Fm+C6uRKE?=
 =?us-ascii?Q?ME8WK5TjkNtDx1o+AwXTNfdSPNtk7UkRHM80Ks6HyAyV2L3Zm4ZaRd/65d59?=
 =?us-ascii?Q?pseJtdGzWFUmZNyXyp3Y79PgpJhiYAtgGjzTVmVrLZsaqGWW+LXH1ag83d2V?=
 =?us-ascii?Q?m5YMpCUQvWKwRNGvVuzKMewHVZrm1CwkPbrcawP5BA2THJnmbCTa8R+dJtVv?=
 =?us-ascii?Q?f32vUl0dI5D/UnJMkIt4oHx/aDPhuwRf7QjZnnw/ohYqTTD5IJGVBbfPGeMr?=
 =?us-ascii?Q?O4LQOsg0hiEwc/mTtwkWXpHdibOhBBBes66F9+4hvZjavNnTMoy46bCfEp+d?=
 =?us-ascii?Q?oZwjWbEJsojaFvQJxvPj6GdND8u+BiK2MFZNK7c7x9IwHL+QkFFb4KnAR6mK?=
 =?us-ascii?Q?juVbWkRdrG4+Z4BzLORuGwdvjaiMmYbNcfKqqtj1w182Ef3zlXm3/nqRpPvR?=
 =?us-ascii?Q?xckbBdNDXDNGYOQxOZTgzA7TyCjSL6kNFBB8gJspV+v+8XjyqSnrewKeryeU?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc71965-3b94-4a95-0979-08dc2bdabfab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 14:56:10.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QI7NuP5i62tX+o0WSJRCVgr6O6FQo9CpKSuROnbztyW9Pb8t0rO5tTdIBfvE6nPOaL3nAgUwVI+WuroXySK1yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6748
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "canonical_address#:#[##]" on:

commit: 04cb69cd30bb05c127e2b86b31ee778100439d14 ("[PATCH v3 07/24] gpio: protect the descriptor label with SRCU")
url: https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240208-180822
base: https://git.kernel.org/cgit/linux/kernel/git/brgl/linux.git gpio/for-next
patch link: https://lore.kernel.org/all/20240208095920.8035-8-brgl@bgdev.pl/
patch subject: [PATCH v3 07/24] gpio: protect the descriptor label with SRCU

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | 47b87115af | 04cb69cd30 |
+----------------------------------------------------------------------------------+------------+------------+
| canonical_address#:#[##]                                                         | 0          | 9          |
| RIP:check_init_srcu_struct                                                       | 0          | 9          |
| Kernel_panic-not_syncing:Fatal_exception                                         | 0          | 9          |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402122228.e607a080-lkp@intel.com



[   53.381777][    T1] gpiochip_find_base_unlocked: found new base at 512
[   53.383799][    T1] general protection fault, probably for non-canonical address 0xdffffc000000002f: 0000 [#1] PREEMPT KASAN PTI
[   53.384902][    T1] KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
[   53.384902][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.8.0-rc1-00035-g04cb69cd30bb #1
[ 53.384902][ T1] RIP: 0010:check_init_srcu_struct (kernel/rcu/srcutree.c:408) 
[ 53.384902][ T1] Code: 53 48 89 fb 80 3c 02 00 0f 85 fe 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 38 48 8d bd 78 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ce 00 00 00 48 8b 85 78 01 00 00 a8 03 75 0b 5b
All code
========
   0:	53                   	push   %rbx
   1:	48 89 fb             	mov    %rdi,%rbx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 fe 00 00 00    	jne    0x10c
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df 
  18:	48 8b 6b 38          	mov    0x38(%rbx),%rbp
  1c:	48 8d bd 78 01 00 00 	lea    0x178(%rbp),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	0f 85 ce 00 00 00    	jne    0x102
  34:	48 8b 85 78 01 00 00 	mov    0x178(%rbp),%rax
  3b:	a8 03                	test   $0x3,%al
  3d:	75 0b                	jne    0x4a
  3f:	5b                   	pop    %rbx

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 ce 00 00 00    	jne    0xd8
   a:	48 8b 85 78 01 00 00 	mov    0x178(%rbp),%rax
  11:	a8 03                	test   $0x3,%al
  13:	75 0b                	jne    0x20
  15:	5b                   	pop    %rbx
[   53.384902][    T1] RSP: 0018:ffff888103e67730 EFLAGS: 00010202
[   53.384902][    T1] RAX: dffffc0000000000 RBX: ffff88810a65f8f8 RCX: 0000000000000000
[   53.384902][    T1] RDX: 000000000000002f RSI: ffff888168ad7b40 RDI: 0000000000000178
[   53.384902][    T1] RBP: 0000000000000000 R08: 692d422d656e696c R09: 007475706e692d42
[   53.384902][    T1] R10: ffff888103e67768 R11: ffffffff8190f8d4 R12: ffff88810a65f930
[   53.384902][    T1] R13: 0000000000000000 R14: ffff88810a65f8d8 R15: 0000000000000000
[   53.384902][    T1] FS:  0000000000000000(0000) GS:ffffffff84cd1000(0000) knlGS:0000000000000000
[   53.384902][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.384902][    T1] CR2: 00007fb8169d96f4 CR3: 0000000004cac000 CR4: 00000000000406b0
[   53.384902][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   53.384902][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   53.384902][    T1] Call Trace:
[   53.384902][    T1]  <TASK>
[ 53.384902][ T1] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460) 
[ 53.384902][ T1] ? exc_general_protection (arch/x86/kernel/traps.c:701 arch/x86/kernel/traps.c:643) 
[ 53.384902][ T1] ? asm_exc_general_protection (arch/x86/include/asm/idtentry.h:564) 
[ 53.384902][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 53.384902][ T1] ? check_init_srcu_struct (kernel/rcu/srcutree.c:408) 
[ 53.384902][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1167 kernel/rcu/srcutree.c:1458) 
[ 53.384902][ T1] ? kstrdup (mm/util.c:62) 
[ 53.384902][ T1] gpiod_request_commit (drivers/gpio/gpiolib.c:134 drivers/gpio/gpiolib.c:2275) 
[ 53.384902][ T1] gpiochip_request_own_desc (drivers/gpio/gpiolib.c:2484) 
[ 53.384902][ T1] gpiod_hog (drivers/gpio/gpiolib.c:4474) 
[ 53.384902][ T1] ? of_find_property (drivers/of/base.c:223) 
[ 53.384902][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799) 
[ 53.384902][ T1] ? __pfx_of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:785) 
[ 53.384902][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[ 53.384902][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 53.384902][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 53.384902][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:828 drivers/gpio/gpiolib-of.c:1143) 
[ 53.384902][ T1] ? fwnode_property_read_int_array (drivers/base/property.c:268 (discriminator 5)) 
[ 53.384902][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:985) 
[ 53.384902][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 53.384902][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886) 
[ 53.384902][ T1] platform_probe (drivers/base/platform.c:1404) 
[ 53.384902][ T1] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[ 53.384902][ T1] __driver_probe_device (drivers/base/dd.c:800) 
[ 53.384902][ T1] driver_probe_device (drivers/base/dd.c:830) 
[ 53.384902][ T1] __driver_attach (drivers/base/dd.c:1217) 
[ 53.384902][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1157) 
[ 53.384902][ T1] bus_for_each_dev (drivers/base/bus.c:367) 
[ 53.384902][ T1] ? lockdep_init_map_type (kernel/locking/lockdep.c:4892) 
[ 53.384902][ T1] ? __pfx_bus_for_each_dev (drivers/base/bus.c:356) 
[ 53.384902][ T1] ? bus_add_driver (drivers/base/bus.c:672) 
[ 53.384902][ T1] bus_add_driver (drivers/base/bus.c:674) 
[ 53.384902][ T1] driver_register (drivers/base/driver.c:246) 
[ 53.384902][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969 (discriminator 4)) 
[ 53.384902][ T1] of_unittest_overlay (drivers/of/unittest.c:2189 drivers/of/unittest.c:3217) 
[ 53.384902][ T1] ? __pfx_of_unittest_overlay (drivers/of/unittest.c:3155) 
[ 53.384902][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[ 53.384902][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 53.384902][ T1] of_unittest (drivers/of/unittest.c:4129) 
[ 53.384902][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080) 
[ 53.384902][ T1] ? add_device_randomness (drivers/char/random.c:918) 
[ 53.384902][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080) 
[ 53.384902][ T1] do_one_initcall (init/main.c:1236) 
[ 53.384902][ T1] ? __pfx_do_one_initcall (init/main.c:1227) 
[ 53.384902][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 53.384902][ T1] kernel_init_freeable (init/main.c:1555) 
[ 53.384902][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 53.384902][ T1] kernel_init (init/main.c:1443) 
[ 53.384902][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 53.384902][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 53.384902][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 53.384902][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[   53.384902][    T1]  </TASK>
[   53.384902][    T1] Modules linked in:
[   53.485664][    T1] ---[ end trace 0000000000000000 ]---
[ 53.486974][ T1] RIP: 0010:check_init_srcu_struct (kernel/rcu/srcutree.c:408) 
[ 53.488507][ T1] Code: 53 48 89 fb 80 3c 02 00 0f 85 fe 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 38 48 8d bd 78 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ce 00 00 00 48 8b 85 78 01 00 00 a8 03 75 0b 5b
All code
========
   0:	53                   	push   %rbx
   1:	48 89 fb             	mov    %rdi,%rbx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 fe 00 00 00    	jne    0x10c
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df 
  18:	48 8b 6b 38          	mov    0x38(%rbx),%rbp
  1c:	48 8d bd 78 01 00 00 	lea    0x178(%rbp),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	0f 85 ce 00 00 00    	jne    0x102
  34:	48 8b 85 78 01 00 00 	mov    0x178(%rbp),%rax
  3b:	a8 03                	test   $0x3,%al
  3d:	75 0b                	jne    0x4a
  3f:	5b                   	pop    %rbx

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 ce 00 00 00    	jne    0xd8
   a:	48 8b 85 78 01 00 00 	mov    0x178(%rbp),%rax
  11:	a8 03                	test   $0x3,%al
  13:	75 0b                	jne    0x20
  15:	5b                   	pop    %rbx


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240212/202402122228.e607a080-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


