Return-Path: <linux-kernel+bounces-61876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C28517AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1141F21B06
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B693C088;
	Mon, 12 Feb 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfS84lup"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391B3B782;
	Mon, 12 Feb 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750669; cv=fail; b=trNv+lWiwmIn3/5HHwb4FfI5nBD/rq4793Bp/fSEdY6gKKpr85S+ikWmJ7on4Q+FJJE+67BKOfYsR4WbmCrXMc+CyTeyRq370ym+Cf0NHn3MgeaK5mMpnxksgITtI86hoZIfun+nzRhWmxx7VWFmjIKU+x7R0pKqo8ozAOD/KkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750669; c=relaxed/simple;
	bh=jNuF0i6J9HuYutJ4m/qJwzob4z8PayVwpT64EcskIh0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nk8j6ftKFtnr7QX8aQ45+pSriafuuZZD7Fc2DrSuFTmI0I4dg71ACvpPdw4DIMCNSA3pUEuHJSiJqCqi2/BxH4YydWRvDw7J6G+VlvhFe8BxxEmNJuATH1GV6VjjoHmpjTof4p7/v2TsgAfSLDpNg62iQHuDFa9QwnfBrp6Z+ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfS84lup; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707750666; x=1739286666;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=jNuF0i6J9HuYutJ4m/qJwzob4z8PayVwpT64EcskIh0=;
  b=hfS84lupju6nrA5SuVLpY+g38UkKFTGm4y2E5CYNyfdytg/UvhyskNe+
   xSoRUxAU26kfur47LFQ4rTqaHc913aq/clBW2b3YVSvoPxbS6vYd6z9Hg
   hVDu/OQFDGhh9c8RQv2QXcYWWAeWsJPuRo1UVW9P1C5Mc47EFKEQRVksU
   268obaAXOXIuGFnWh8ugXS7drGTfCMh3PpX6m6fi/fVjlj83lG9LZYHYf
   05vMiOkab6IEfCI8XqErFnLqUSzP3DvvhYD9vA1lo8d8SRn2AH+9zJv6i
   9VoeO+QaSP/GeW7TgDVGoU0/Sp6kY1c/prheyIUC+ltiXCm3lsv4A0aXg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="396163102"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="396163102"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 07:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="7243176"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 07:11:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 07:11:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 07:10:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 07:10:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 07:09:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShbzszWb72Lsb9vglkina3sQKLPPEnlC7fmiOpW53vn2g1t2PWH+IRp+iQmTXC8B6rEJv6nrNtwiHX+hwDUbJ4JDfLO1uQNvDoFMOM8qOChAx+NE//VbsRozQpEpBp8s2lCxbE/7yGDI2AAveRY9/14mN12Z0b9ZqZm7L9WeUggiWUclQyk+r+z9G8RnPHROWgBbLQCdEJvEp399w9UkRXDvsA8pmWQFlY1M+99C5MEvl7OLd4biISD1sTlNb+FG8TkGR+8JP84OgRitqcMreizksR+N7GgwBnnLEhI405/NqPJBbGjFqAX7WIllAU5xbvZqVNTx1uHTHStOeLmowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XsfxBwpcffkcORs2NexttyMPIThKLvZwyYfBGkRQJY=;
 b=H/4xzhqVVqQk7JGXqRP/dX79tZvybWleP09uNjvLS2d0ji5dG2HLdZS0lifwMsVH78qvx9nXZh9cVOfWwZVmusaR5W18hRSyQXBn5LJXDqfg2iT5xDBs5ENgYHrek8FMr0p0Bob/NQtFw1WIjXpuxbyhjI6MNQpJv4YwAOgMwS4RdMsiPc99nlTKRcWKgHmCLePYhixvlkGdfEDPHR1sU0dPI0g7Ge0KHRS1AvwvvDjePUeSMJoAsey/O8szho6t08BtDOdped8ZYVvnHo1iqb2gXJ3E9evmc88jQScOUzdAmaKt4DuIkKVog3tn0B1vj8zTTKK1u2N3dDjzbmqUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 15:09:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 15:09:19 +0000
Date: Mon, 12 Feb 2024 23:09:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>, Kent Gibson
	<warthog618@gmail.com>, Alex Elder <elder@linaro.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Wolfram Sang
	<wsa@the-dreams.de>, <linux-kernel@vger.kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 22/24] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <202402122234.d85cca9b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208095920.8035-23-brgl@bgdev.pl>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cffdc1c-96e2-434b-f9f2-08dc2bdc95f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3HaQ7wO+2rjFXOh4ZLpCNS8IBUh/XYJ+DgsFLmiAPSOkFapr09X8SnlnYOLpdCS1n1VgC1FVL4pISxtxvtZqHV3WFvNygFtkLk8QxSyxYfWJQoVhQUJH3/cRBI3qZbDAC1ZzjiXHVVGY1Jj09yxg4Jtr2PWIxaVNvj4aNjmz/fIfp71wAyZbhiX6Doyw5057++AGI1laqMJU/X9wSnCkZ0gEl+wrw2/eEIGch/FYtMkILKUheFmkiLOCYDMzpIgOi+NHaMzqmdV3CmfuU1RzRV4/oWp+k9873L3idGFU6yCKIroqhnB/AbWeRNKKZ65pPyce86qrUDOgb6Owzw5mby2oLS6eV63Z/KQtk71C42fqDQ8W+cv6EAd9jsJ/Ra7wu5WQUhaql/ZaEKD4Q7w8ZNjWNUqydHEH/qibk1Tnm/OZG6OSVJnR4PdS/3jmPycincYfrfGsKkGVzV6E/JydaHiIKqztDfuqhKqxe/FeAImRuXNweSlMtvuNWqB2PwMmhUAmVrcjwUIVwA4XTMe6+OWcmjvjyebE4Vz4svMmK4uDQewo5X73agL6564FSbpLTH0gzoMXKGkysVOv8ynww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230273577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(8676002)(7416002)(30864003)(5660300002)(66556008)(6916009)(8936002)(66476007)(2906002)(83380400001)(38100700002)(26005)(82960400001)(36756003)(1076003)(54906003)(316002)(6666004)(86362001)(41300700001)(966005)(6486002)(6512007)(6506007)(2616005)(66946007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0zTSut038vAW3S8XFvyJRHOgYRaXTb4wzmoUfb9giyQkGxZV7e8VS2ohjR0?=
 =?us-ascii?Q?VNSJnpH5MNZ90YuzB9vae7xugOBf3Hzu3/HWi9OjqbOvCmt28Ay557QPOvtg?=
 =?us-ascii?Q?4KZdqCvzWQehC+gQVDDb2BkJbdyhuXjavAZUc/gzGnVYLQtmokYtUQtI4UMh?=
 =?us-ascii?Q?Op/zEAl/WlqBAN+Gm05ns6uKLCGQb9mTw7IgY412prBv95E3myB3nsZOKCDs?=
 =?us-ascii?Q?Kt4io+eE7qmwkhpwYY5rzCNUEbVjOmwyTIjZXSEUseNo3KJpqgapicsVLQCz?=
 =?us-ascii?Q?QaVTkBfUaODSwv9xE2ZnT1WLJH0KcD4kuYvUm71xIfnV/b/dHDG65cLGmYG0?=
 =?us-ascii?Q?UKZPxPYthLPuOPTmuWDLTCSP7IsYes1zLFouDUQBIfgxOJApFYBiKVFtAG/j?=
 =?us-ascii?Q?ttiYZw0j/ALEO8nA6FrSt8oW7j8i6zm7X5PWppb+29pGmZv9nhnvzqJRo1nz?=
 =?us-ascii?Q?jUWt1nJN5wvEhjvH+GETxwWP/0Rm6+Vl5fOmEbthlOwhJ3eKNVqWNZDbNRvK?=
 =?us-ascii?Q?NEhcVEVcre1ErNloYxZ/ulFeDWMpyDcVPF/JU2WhLNlNYLr0DvVim/VP52eu?=
 =?us-ascii?Q?LcSbv8/s/7OoHNSUty8z/5d19YMhk1JyBUz319Zgw3AWLWdqx/qf/L4Shxdj?=
 =?us-ascii?Q?gkGvuWXQDTR22fgldz4UwMU71+Gx1cVQJwowQkb0mOZPFzAEpbCcEIAM8/Yk?=
 =?us-ascii?Q?gT7GX4JJlhaIQvxkx7Mf+TdQ/cZM3xPNUPlduYy8HTekjidHn02rc+jxZA2g?=
 =?us-ascii?Q?IccV708nosmaqMsAfn9dLSYNLLJM5GoRZtCc/9pv6wRqVFUwEyWU2jrGKSne?=
 =?us-ascii?Q?+QGtLccL4BmfkaP+XM9jlmW98oPqhAYAjXB+jFasjtXIL5mY8/6OZTBmk8bg?=
 =?us-ascii?Q?TKKyL4HFwDHuD4KOZQ0dR3ftYcTcO1t6HVL1IKd4vXJYnMsLhvw9bc9FPKxx?=
 =?us-ascii?Q?kEQuN0dICN9onTcKLRQppB0fED53PTf/BAWcdR5yAN22AZ2qvKMHCWU8mI21?=
 =?us-ascii?Q?d80jLiqW7sCcQDSkRYzM+8IDIEyfRmoZ0Qa6w0YD1AtlWNYjKuDOLo/hIxvy?=
 =?us-ascii?Q?dcn6BMLREmWFz+3NniYYQFa/2XFje1+zq+8+Idff0Yzi1FC8yypjbFYISCZ1?=
 =?us-ascii?Q?OAQcjkltvUdq1EGLqc0bF67Q5iOqcL5SYBcH+p1Tpq3xIry0zbXZVvcHXazn?=
 =?us-ascii?Q?QKxPWPZ0y+55DjOU+IgSaDGP1yN60ry2WlOr9dgUcwkZnl8SueD9rENGyuVK?=
 =?us-ascii?Q?wxvDVZBpaZLwav6NJG2LPqcO44p6YrxyMnZGtBHg3YzKAHvNKMALHkMbJahk?=
 =?us-ascii?Q?5QSmBvmungRDipUTPE3kt/mIOsNAlZIWE7b2F7tYXQlO2id32yQKXRJYP7b8?=
 =?us-ascii?Q?n5yNXlX7dn4neXVLUf6tsrwhgsHNkHyRpM1kHqW89mimXRo+iRSsgeWqRfX9?=
 =?us-ascii?Q?Q/h3ysjvjG2ZjTQAgcbORMKkdQvFt3HyuphBeqEds5Vw0BUp5TucfTkfEqg1?=
 =?us-ascii?Q?26m0j1Jfm12OnG6IBHECP4ETtiyPkMNM2ElkpUI+y9+PYXo72ewj5yQXKSNp?=
 =?us-ascii?Q?KRb6k8MaM54H1mj74ROAFcDjGJavjebqgPq09+aifSz32TAN2mYHlxaaWiZz?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cffdc1c-96e2-434b-f9f2-08dc2bdc95f1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:09:19.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibWXS/ufKfKyox+fbXEB0ivPoBISIwxFmb9MrLfcz1Ou8MQ55cDVU12ysjsXx+tLsaVH3s8G/X/io7puqdYOTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: c21131f83abc1f7227e7a6d5311e1df68bfa44e0 ("[PATCH v3 22/24] gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
url: https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240208-180822
base: https://git.kernel.org/cgit/linux/kernel/git/brgl/linux.git gpio/for-next
patch link: https://lore.kernel.org/all/20240208095920.8035-23-brgl@bgdev.pl/
patch subject: [PATCH v3 22/24] gpio: protect the pointer to gpio_chip in gpio_device with SRCU

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------+------------+------------+
|                                                                 | a3dfc11062 | c21131f83a |
+-----------------------------------------------------------------+------------+------------+
| drivers/gpio/gpiolib.c:#suspicious_rcu_dereference_check()usage | 0          | 8          |
| drivers/gpio/gpiolib.h:#suspicious_rcu_dereference_check()usage | 0          | 8          |
+-----------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.com



[   76.432519][    T1] gpiochip_find_base_unlocked: found new base at 512
[   76.434591][    T1]
[   76.435240][    T1] =============================
[   76.436545][    T1] WARNING: suspicious RCU usage
[   76.437813][    T1] 6.8.0-rc1-00050-gc21131f83abc #1 Tainted: G                 N
[   76.439873][    T1] -----------------------------
[   76.441158][    T1] drivers/gpio/gpiolib.c:219 suspicious rcu_dereference_check() usage!
[   76.443364][    T1]
[   76.443364][    T1] other info that might help us debug this:
[   76.443364][    T1]
[   76.446059][    T1]
[   76.446059][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   76.448217][    T1] 1 lock held by swapper/1:
[ 76.449412][ T1] #0: ffff88816954f0f0 (&dev->mutex){....}-{3:3}, at: __driver_attach (drivers/base/dd.c:1216) 
[   76.451938][    T1]
[   76.451938][    T1] stack backtrace:
[   76.453486][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.8.0-rc1-00050-gc21131f83abc #1
[   76.456114][    T1] Call Trace:
[   76.456936][    T1]  <TASK>
[ 76.457682][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 76.458833][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6713) 
[ 76.460205][ T1] gpiod_to_chip (drivers/gpio/gpiolib.c:219 (discriminator 9)) 
[ 76.461346][ T1] gpiod_hog (drivers/gpio/gpiolib.h:243 drivers/gpio/gpiolib.c:4502) 
[ 76.462400][ T1] ? of_find_property (drivers/of/base.c:223) 
[ 76.463671][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799) 
[ 76.464933][ T1] ? __pfx_of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:785) 
[ 76.466378][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[ 76.467894][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 76.469220][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 76.470786][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:828 drivers/gpio/gpiolib-of.c:1143) 
[ 76.472060][ T1] ? fwnode_property_read_int_array (drivers/base/property.c:268 (discriminator 5)) 
[ 76.473692][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:989) 
[ 76.475271][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 76.476567][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886) 
[ 76.477928][ T1] platform_probe (drivers/base/platform.c:1404) 
[ 76.479162][ T1] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[ 76.480403][ T1] __driver_probe_device (drivers/base/dd.c:800) 
[ 76.481791][ T1] driver_probe_device (drivers/base/dd.c:830) 
[ 76.483097][ T1] __driver_attach (drivers/base/dd.c:1217) 
[ 76.484388][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1157) 
[ 76.485805][ T1] bus_for_each_dev (drivers/base/bus.c:367) 
[ 76.487037][ T1] ? lockdep_init_map_type (kernel/locking/lockdep.c:4892) 
[ 76.488477][ T1] ? __pfx_bus_for_each_dev (drivers/base/bus.c:356) 
[ 76.489897][ T1] ? bus_add_driver (drivers/base/bus.c:672) 
[ 76.491195][ T1] bus_add_driver (drivers/base/bus.c:674) 
[ 76.492463][ T1] driver_register (drivers/base/driver.c:246) 
[ 76.493723][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969 (discriminator 4)) 
[ 76.495167][ T1] of_unittest_overlay (drivers/of/unittest.c:2189 drivers/of/unittest.c:3217) 
[ 76.496478][ T1] ? __pfx_of_unittest_overlay (drivers/of/unittest.c:3155) 
[ 76.497886][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[ 76.499410][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 76.500744][ T1] of_unittest (drivers/of/unittest.c:4129) 
[ 76.501862][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080) 
[ 76.503098][ T1] ? add_device_randomness (drivers/char/random.c:918) 
[ 76.504492][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080) 
[ 76.505807][ T1] do_one_initcall (init/main.c:1236) 
[ 76.507054][ T1] ? __pfx_do_one_initcall (init/main.c:1227) 
[ 76.508517][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 76.509731][ T1] kernel_init_freeable (init/main.c:1555) 
[ 76.511106][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 76.512435][ T1] kernel_init (init/main.c:1443) 
[ 76.513566][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 76.514947][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 76.516125][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 76.517440][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[   76.518731][    T1]  </TASK>
[   76.519758][    T1]
[   76.520477][    T1] =============================
[   76.521774][    T1] WARNING: suspicious RCU usage
[   76.523076][    T1] 6.8.0-rc1-00050-gc21131f83abc #1 Tainted: G                 N
[   76.525108][    T1] -----------------------------
[   76.526429][    T1] drivers/gpio/gpiolib.h:210 suspicious rcu_dereference_check() usage!
[   76.528621][    T1]
[   76.528621][    T1] other info that might help us debug this:
[   76.528621][    T1]
[   76.531350][    T1]
[   76.531350][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   76.533414][    T1] 2 locks held by swapper/1:
[ 76.534616][ T1] #0: ffff88816954f0f0 (&dev->mutex){....}-{3:3}, at: __driver_attach (drivers/base/dd.c:1216) 
[ 76.537073][ T1] #1: ffff888163afb6d0 (&gdev->srcu){.+.+}-{0:0}, at: gpiod_request_commit (include/linux/srcu.h:116 include/linux/srcu.h:215 drivers/gpio/gpiolib.h:202 drivers/gpio/gpiolib.c:2243) 
[   76.539703][    T1]
[   76.539703][    T1] stack backtrace:
[   76.541276][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.8.0-rc1-00050-gc21131f83abc #1
[   76.543890][    T1] Call Trace:
[   76.544767][    T1]  <TASK>
[ 76.545549][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 76.546740][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6713) 
[ 76.548196][ T1] gpiod_request_commit (drivers/gpio/gpiolib.h:202 drivers/gpio/gpiolib.c:2243) 
[ 76.549584][ T1] ? dump_stack_lvl (lib/dump_stack.c:108) 
[ 76.550829][ T1] gpiochip_request_own_desc (drivers/gpio/gpiolib.c:2454) 
[ 76.552354][ T1] gpiod_hog (drivers/gpio/gpiolib.c:4504) 
[ 76.553556][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799) 
[ 76.554948][ T1] ? __pfx_of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:785) 
[ 76.556536][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[ 76.558176][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 76.559633][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 76.561252][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:828 drivers/gpio/gpiolib-of.c:1143) 
[ 76.562584][ T1] ? fwnode_property_read_int_array (drivers/base/property.c:268 (discriminator 5)) 
[ 76.564302][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:989) 
[ 76.565974][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 76.567328][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886) 
[ 76.568780][ T1] platform_probe (drivers/base/platform.c:1404) 
[ 76.570065][ T1] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[ 76.571309][ T1] __driver_probe_device (drivers/base/dd.c:800) 
[ 76.572801][ T1] driver_probe_device (drivers/base/dd.c:830) 
[ 76.574175][ T1] __driver_attach (drivers/base/dd.c:1217) 
[ 76.575513][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1157) 
[ 76.576994][ T1] bus_for_each_dev (drivers/base/bus.c:367) 
[ 76.578331][ T1] ? lockdep_init_map_type (kernel/locking/lockdep.c:4892) 
[ 76.579877][ T1] ? __pfx_bus_for_each_dev (drivers/base/bus.c:356) 
[ 76.581368][ T1] ? bus_add_driver (drivers/base/bus.c:672) 
[ 76.582799][ T1] bus_add_driver (drivers/base/bus.c:674) 
[ 76.584128][ T1] driver_register (drivers/base/driver.c:246) 
[ 76.585452][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969 (discriminator 4)) 
[ 76.586969][ T1] of_unittest_overlay (drivers/of/unittest.c:2189 drivers/of/unittest.c:3217) 
[ 76.588400][ T1] ? __pfx_of_unittest_overlay (drivers/of/unittest.c:3155) 
[ 76.589958][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[ 76.591624][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 76.593071][ T1] of_unittest (drivers/of/unittest.c:4129) 
[ 76.594323][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080) 
[ 76.595700][ T1] ? add_device_randomness (drivers/char/random.c:918) 
[ 76.597164][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080) 
[ 76.598482][ T1] do_one_initcall (init/main.c:1236) 
[ 76.599728][ T1] ? __pfx_do_one_initcall (init/main.c:1227) 
[ 76.601163][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 76.602389][ T1] kernel_init_freeable (init/main.c:1555) 
[ 76.603810][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 76.605101][ T1] kernel_init (init/main.c:1443) 
[ 76.606235][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 76.607627][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 76.608797][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 76.610112][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[   76.611412][    T1]  </TASK>
[   76.612591][    T1] general protection fault, probably for non-canonical address 0xdffffc000000002f: 0000 [#1] PREEMPT KASAN PTI
[   76.615654][    T1] KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
[   76.617847][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.8.0-rc1-00050-gc21131f83abc #1
[ 76.620463][ T1] RIP: 0010:check_init_srcu_struct (kernel/rcu/srcutree.c:408) 
[ 76.622072][ T1] Code: 53 48 89 fb 80 3c 02 00 0f 85 fe 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 38 48 8d bd 78 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ce 00 00 00 48 8b 85 78 01 00 00 a8 03 75 0b 5b
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
[   76.627183][    T1] RSP: 0018:ffff888103a6f718 EFLAGS: 00010202
[   76.628803][    T1] RAX: dffffc0000000000 RBX: ffff88810ee660f8 RCX: 0000000000000000
[   76.630879][    T1] RDX: 000000000000002f RSI: ffff88816976b000 RDI: 0000000000000178
[   76.632960][    T1] RBP: 0000000000000000 R08: 692d422d656e696c R09: 007475706e692d42
[   76.635045][    T1] R10: ffff888103a6f750 R11: ffffffff810b3aef R12: ffff88810ee66130
[   76.641151][    T1] R13: ffff888163afb6c0 R14: 0000000000000000 R15: ffff888163afb6d0
[   76.643224][    T1] FS:  0000000000000000(0000) GS:ffffffff84cd1000(0000) knlGS:0000000000000000
[   76.645563][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   76.647278][    T1] CR2: 00007fab8f4456f4 CR3: 0000000004cac000 CR4: 00000000000406b0
[   76.649355][    T1] Call Trace:
[   76.650221][    T1]  <TASK>
[ 76.651020][ T1] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460) 
[ 76.652132][ T1] ? exc_general_protection (arch/x86/kernel/traps.c:701 arch/x86/kernel/traps.c:643) 
[ 76.653604][ T1] ? asm_exc_general_protection (arch/x86/include/asm/idtentry.h:564) 
[ 76.655133][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153) 
[ 76.656355][ T1] ? check_init_srcu_struct (kernel/rcu/srcutree.c:408) 
[ 76.657792][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1167 kernel/rcu/srcutree.c:1458) 
[ 76.659048][ T1] gpiod_request_commit (drivers/gpio/gpiolib.c:127 drivers/gpio/gpiolib.c:2273) 
[ 76.660430][ T1] gpiochip_request_own_desc (drivers/gpio/gpiolib.c:2454) 
[ 76.661898][ T1] gpiod_hog (drivers/gpio/gpiolib.c:4504) 
[ 76.663000][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799) 
[ 76.664334][ T1] ? __pfx_of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:785) 
[ 76.665830][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[ 76.667387][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 76.668763][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 76.670279][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:828 drivers/gpio/gpiolib-of.c:1143) 
[ 76.671550][ T1] ? fwnode_property_read_int_array (drivers/base/property.c:268 (discriminator 5)) 
[ 76.673171][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:989) 
[ 76.674714][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 76.676002][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886) 
[ 76.677340][ T1] platform_probe (drivers/base/platform.c:1404) 
[ 76.678544][ T1] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[ 76.679745][ T1] __driver_probe_device (drivers/base/dd.c:800) 
[ 76.681126][ T1] driver_probe_device (drivers/base/dd.c:830) 
[ 76.682411][ T1] __driver_attach (drivers/base/dd.c:1217) 
[ 76.683679][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1157) 
[ 76.685074][ T1] bus_for_each_dev (drivers/base/bus.c:367) 
[ 76.686340][ T1] ? lockdep_init_map_type (kernel/locking/lockdep.c:4892) 
[ 76.687774][ T1] ? __pfx_bus_for_each_dev (drivers/base/bus.c:356) 
[ 76.689176][ T1] ? bus_add_driver (drivers/base/bus.c:672) 
[ 76.690452][ T1] bus_add_driver (drivers/base/bus.c:674) 
[ 76.691691][ T1] driver_register (drivers/base/driver.c:246) 
[ 76.692949][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969 (discriminator 4)) 
[ 76.694377][ T1] of_unittest_overlay (drivers/of/unittest.c:2189 drivers/of/unittest.c:3217) 
[ 76.695724][ T1] ? __pfx_of_unittest_overlay (drivers/of/unittest.c:3155) 
[ 76.697198][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[ 76.698764][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
[ 76.700151][ T1] of_unittest (drivers/of/unittest.c:4129) 
[ 76.701323][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080) 
[ 76.702622][ T1] ? add_device_randomness (drivers/char/random.c:918) 
[ 76.704050][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080) 
[ 76.705347][ T1] do_one_initcall (init/main.c:1236) 
[ 76.706572][ T1] ? __pfx_do_one_initcall (init/main.c:1227) 
[ 76.708227][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240212/202402122234.d85cca9b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


