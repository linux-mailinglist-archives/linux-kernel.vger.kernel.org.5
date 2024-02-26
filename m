Return-Path: <linux-kernel+bounces-81619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E3867872
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45B21C2A56D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B81012A14A;
	Mon, 26 Feb 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFYpXXqR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4812A143;
	Mon, 26 Feb 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957689; cv=fail; b=NRAbXBTbKifkl6Icduq/FMpjzhGSC7GJjW40McN8FHleqOnG9eebqHbP+J+sfflmjQRcAChF3kEpvl3LzoXTOQkYwJXpjv7Rp6w8FXPYRs9ihgUJN6a/e+6/BQXqpERKOtyH186q2zMTxPojrOBfcNt3vHvMvpk11RyI0rcsBbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957689; c=relaxed/simple;
	bh=OJG7hTgbIGJNQAxpJOO+AN1AUigaAGKMMEf1D3GxuLc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ahO3jU16X0v9/KoQAUv1lplObxoBS7LsxAq+W1bqhlfF5DlsOwMcCnhJvKO7oyyw131u4kKW3BPrtcJgE3ZlvX+vb1pjJcK1os0tzBcMbEqKtkKEyTm5pHtabuZVAWY6JlGuzL1B4hFMNJWsrQbndK+CwRiG90y9RU4KtrtkCgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFYpXXqR; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957687; x=1740493687;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=OJG7hTgbIGJNQAxpJOO+AN1AUigaAGKMMEf1D3GxuLc=;
  b=lFYpXXqRhCD/jnwamCm/uCOR2pIkMQPbvN+IzQtqoWXuh4NxJ0YRq7F5
   r3PWF4fXYQn/wjT3qZhI+VceuSI7HhbyOwuwnIlJgzRyNwYbbw86sE7u/
   az32m+LZhFQPNZ0iaQ3zcBJRtOE2MDUm9raDWkS7XYy61hVYmaGpT97wj
   iaavxlebYQgFzLyX7QY9P14ls32gBSj/GUIDGAIOmb2noVZrUGHsUPxEv
   2JTLBrzbZSroDivZouT73lr2DQb+kk+aEos7ef5YZndoN+uQV4ZFUsLGe
   +t2HXkLanoHkQhWRdsUAssDkbJzLmh2n5CxfBgb+eLyoQyrt6nYbqEwER
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6189852"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6189852"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6709873"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 06:27:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 06:27:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 06:27:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 06:27:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVVJWnnc2QU1M6J+GTyP3lJFwH50XQ4bAGuvnm4yxern0F+FqxphT5tI87XZVEdvM67E9sWtdCWE9yF8e/ixSnCOHRoPoBbi0xltiXO3U3+R1zKbf+VRl7gg1WeCS9ovXgI09ZYp8yWeBR3lONasEGCXgDvi7kVALuLjZYmPVXLg7oQL80y2VfuN2kwEi2QMwSmTS9DY5eqLGFfCBzU8RlP4jT0OJq3BhU8COAz8ZPaXlzc8TFti6mqZmHrNUP/mwemczDCgBRe00G0Aoxufv4JBeigi62OlqUoKKOsfOOy0sNulDdvXG4tsV0Y+xYwFGSgENKL4k3+0M6co1bQAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TuMX5RBwyMNhwd+GGLhzDVczZ1nq+S0ftVfJ3YIYuA=;
 b=QhsYFCIpu0dq0wNVDQ5tghBqIxwnaPiZYKnd2U/2Yx3gD3BbVtL7KwSt3qrLB58xDrUoM0E9OSTk+t2DfqPZsviV5qkJyFMUi/IiId+JLGyR8Z7YUQB3PuGQVivjTsyflNC+DscwI0p1ZGetBxyyZ2XxqLwV6tJk5sFa+p8BOmVvWpcWNZcfY9WDZaPElVOOjhzgosThWH65jlGsuc+x2lL5o/WhYCg4vKqCjdGVuZSxMg2LBQTi5C8+CrW0DdUWllYCtDqGIUDzye6NEn9hb7xLydxjvBySZUBSrOzc72FGAIAWLfslS+F58BB9+yX8csKkxydjrPstOSU6tL651Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8148.namprd11.prod.outlook.com (2603:10b6:208:472::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 14:27:43 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 14:27:43 +0000
Date: Mon, 26 Feb 2024 22:27:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, kernel test robot
	<oliver.sang@intel.com>, Linus Walleij <linus.walleij@linaro.org>,
	<linux-gpio@vger.kernel.org>, Kent Gibson <warthog618@gmail.com>, Alex Elder
	<elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E .
 McKenney" <paulmck@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "Mark
 Brown" <broonie@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	<linux-kernel@vger.kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/4] gpio: cdev: use correct pointer accessors with
 SRCU
Message-ID: <202402262225.50983057-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214084419.6194-3-brgl@bgdev.pl>
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ea674a-a239-40ae-093f-08dc36d7184c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77zrDeDWqm7mx1EFWsynnX80ZUFaoLeUKkM9mdBKns4f167u/hEgBwIsTdEEsOYXAHx0VIDwLa8PhZn6ZZlsUS9pu1g/cNNdXWMSOZgw/jRq7sLECuiDwTdYQdvKV3I18/wgLgdNmyGkxnncn9tmS4tu1a62GHKOsgKKC4A5BxEDvZddGTO8Af7IwkwghbHOi/RikQchlzL2ykr0aQMOrN03QxA4IgGMRN+xiroCe0FK7+A3PghWe4puBmFh+s3k6CaLUd6tQn11v3TGWP9OVXyHFxPw+UQLwQkeeauPiDXOb+S4dSyl2V/+RSOWsYvxlQPaLGBTtqQDVt1Zw8ccC5lxmH6BQ4mzEtFw6V0r2+IZ0YFtT7LZ4dE8T1pixXBzalHy7ZW/lPjDc0XbcZAXS3CRxUppee8GuOlhbGNqCLIyzopjSa+K7B+cWRFDKZ/kfNmZhHB2fd7scGPCNnB/JgUergSgzRqzHiO626JlALbpwgVFomobQBDC7BT5tb/WBl8SfbpnEOovG7KM75YALFlTataJcIc8ZVmYzP463oiGBXnAKl7TseIPBV0liSmgAhhckSp+h6RZIeCzbc3loqUdxPiFTzEdfGCmqF/GShAHZT0u/wRDUdTO9rXrswKQlZIicrkLaQsFGmkbGXyZig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XSKM/85Xevsnya00FupU0xMJBGbE1RczE8YW83QgvVR5DlNZM7+IBnNC/kJB?=
 =?us-ascii?Q?8t+dqgLtFd6YIoPuwIw8jFgXSQznCS6ovWHHs++AOb206iV0YhoR0PRIaF2r?=
 =?us-ascii?Q?Wrxk0ypMS0x/p1XUI7GPp4hSstP6o3ynAKDBcWxhGfT1MBlDj19pJ2RveHar?=
 =?us-ascii?Q?7tHZPrXDjdouXQlX67UOhpqukqTPWWoPD9ujEuk3MQHzDz3GElGAdHfcytpI?=
 =?us-ascii?Q?ax6F/6Uh2DMJRUv62pTNYqSQIBXRaH7G8NKMEWVNMFrKo/oAwSzrP996nAs/?=
 =?us-ascii?Q?PAmNp2LLbzIppTG6Y+pZwCQutfslbM7mCLHqSMUQYe7OSac0/vogUykP6ZPx?=
 =?us-ascii?Q?A/y//C8nD9CByQRL/4QRB/ZBOJ6bXl+FwdBy3MgYgAMcG7MT8dEDyqU0Ajyy?=
 =?us-ascii?Q?JZ1i+tjfWwx+Mziv5C1iH0e0RVWriWxMJgBpyQfxdji8LkwoYdgYl+l639du?=
 =?us-ascii?Q?Oto59cj6njUXor8TWQOHQKNf4KsbDokrSn8k5FDwPL6ZegsK4ngbT5E3Ufov?=
 =?us-ascii?Q?YqzI7y1P6v80jB2SlWTzIUMZiNEsJnV5kY7g4BVxf+QKW6LYJ0sG74r0cafG?=
 =?us-ascii?Q?dZbCc69SH31nFbPKBlMDPSbZ0JYbIzAkarXHZdIwtv2kYuXDhBWirhu/E0Kj?=
 =?us-ascii?Q?JVvQwphnZd7Z9N9y/cCZ1JLhyTTzRfC7+Wl9L+rbZ0xr70TmV481BJOipy16?=
 =?us-ascii?Q?UjfmfujRsfkcn42FHUhjqNcv8Y/mrnWM3ztR3Y9AdBSPuFu3WE46ZxXwJWFJ?=
 =?us-ascii?Q?shyOmcyX6Ws2k9dbXWCiVeuWmemIodsG8UusGYHtWEwLQo01MgSFkSeobPX+?=
 =?us-ascii?Q?3OMZ2HbYokQdEZlJ0DK7MCe9gXmjz20UIcSr/dZox1Hm6tZWxkmf3Hf8QD6D?=
 =?us-ascii?Q?QTfKYK3IOg/lC1PWARQnt8qyQ/WGYpQC7VJkQ74Ic1BtpctwUmTSH6LrdPlZ?=
 =?us-ascii?Q?Tq3g2EtScfaUHfMcqjh2cuWqrfU5FT5r1pDwGJ1QANSL0sM6KSOnPfmvMFj1?=
 =?us-ascii?Q?qh9aqdHirSirxKz68fXHZ/koiN6Y6S55V2oywHf9uYZMky1ufHdJ03pn9VvH?=
 =?us-ascii?Q?mOT2xY46gZXH9ekTcvJnptRmd5d9uNH8peAWLwQKI7YVq/H082NjzLWg5JYe?=
 =?us-ascii?Q?k6UiSJwncKOr3+A0Tk1ny4Tc0MpKrMkiPLRLUxFUxJKHIapye/a8+yjsWkpe?=
 =?us-ascii?Q?mRB/y5mo53qMuJFAATrJxjG9QHBoZV2bnqNG39ZXviy7P8LDcL1wVQOYFkAG?=
 =?us-ascii?Q?Ovxm3zF8FpgLkDxzxZuHzBaTKdXJwTQlB9cruXlTb5AZINhd9TQgUUFa3nJy?=
 =?us-ascii?Q?ZDmOCD2GkhEXWHIjPaO3Wm95Nbbslfy514rH8Hr2qT5vItwo7nxSv1NbWequ?=
 =?us-ascii?Q?3E4D8QCnkqKnfCbi1h0U+RXfa2SAhKXtdaWkAI/EtzNQ3Yf1LvTr3YftmdBd?=
 =?us-ascii?Q?842O3A7JFBCqKhpW0LQ7L7RhOcMYoxWs1s+NmVhIdgjVu8EL9afKiQTBDk8c?=
 =?us-ascii?Q?F72rvoXGnP1/s+2zZDFWhGRh2kf3GcI7qK89AqTjz6hxtilsvCBHSlS+X1RE?=
 =?us-ascii?Q?6aox0U68Zaeh7jfxcQ1gJ4eP+pfjidMfXfp8RvqPG7m8zWkJhxDTQqZaN7rW?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ea674a-a239-40ae-093f-08dc36d7184c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:27:43.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlyK4fwq4m4bVjf0YQSm2z2GepgtJVTnWkv4BYPh/B+GsC3UmdBN6m6iFk6x6nQIQPKYlMHX3zykcYWiKQ87Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8148
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: ef4aabaa372144b2bfa9c4ddc83255831cff9ebd ("[PATCH v2 2/4] gpio: cdev: use correct pointer accessors with SRCU")
url: https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-take-the-SRCU-read-lock-in-gpiod_hog/20240214-164752
base: https://git.kernel.org/cgit/linux/kernel/git/brgl/linux.git gpio/for-next
patch link: https://lore.kernel.org/all/20240214084419.6194-3-brgl@bgdev.pl/
patch subject: [PATCH v2 2/4] gpio: cdev: use correct pointer accessors with SRCU

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | 5c3cf44c4e | ef4aabaa37 |
+----------------------------------------------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address                                      | 0          | 14         |
| Oops:#[##]                                                                       | 0          | 14         |
| EIP:gpiolib_cdev_register                                                        | 0          | 14         |
| Kernel_panic-not_syncing:Fatal_exception                                         | 0          | 14         |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402262225.50983057-lkp@intel.com



[   57.990853][    T1] gpiochip_find_base_unlocked: found new base at 512
[   57.991570][    T1]
[   57.991875][    T1] =============================
[   57.992480][    T1] WARNING: suspicious RCU usage
[   57.992993][    T1] 6.8.0-rc4-00057-gef4aabaa3721 #1 Tainted: G                TN
[   57.993787][    T1] -----------------------------
[   57.994289][    T1] drivers/gpio/gpiolib.h:205 suspicious rcu_dereference_check() usage!
[   57.995135][    T1]
[   57.995135][    T1] other info that might help us debug this:
[   57.995135][    T1]
[   57.996198][    T1]
[   57.996198][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   57.997073][    T1] 2 locks held by swapper/1:
[ 57.997559][ T1] #0: ea878e8c (&dev->mutex){....}-{3:3}, at: __driver_attach (drivers/base/dd.c:1216) 
[ 57.998494][ T1] #1: eb682f3c (&gdev->srcu){.+.+}-{0:0}, at: srcu_lock_acquire (include/linux/srcu.h:115) 
[   57.999365][    T1]
[   57.999365][    T1] stack backtrace:
[   58.000005][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                TN 6.8.0-rc4-00057-gef4aabaa3721 #1 10e84cefff2a9bf1626b34c75cc7b6c846de4a3a
[   58.001317][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   58.002330][    T1] Call Trace:
[ 58.002690][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 58.003158][ T1] dump_stack (lib/dump_stack.c:113) 
[ 58.003631][ T1] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6714) 
[ 58.006180][ T1] gpiod_hog (drivers/gpio/gpiolib.h:?) 
[ 58.006632][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799) 
[ 58.007165][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:829 drivers/gpio/gpiolib-of.c:1144) 
[ 58.007663][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:1013) 
[ 58.008278][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886) 
[ 58.008799][ T1] platform_probe (drivers/base/platform.c:1405) 
[ 58.009268][ T1] really_probe (drivers/base/dd.c:?) 
[ 58.009738][ T1] __driver_probe_device (drivers/base/dd.c:800) 
[ 58.010265][ T1] driver_probe_device (drivers/base/dd.c:830) 
[ 58.010776][ T1] __driver_attach (drivers/base/dd.c:1217) 
[ 58.011258][ T1] ? driver_attach (drivers/base/dd.c:1157) 
[ 58.011734][ T1] bus_for_each_dev (drivers/base/bus.c:367) 
[ 58.012234][ T1] driver_attach (drivers/base/dd.c:1233) 
[ 58.012692][ T1] ? driver_attach (drivers/base/dd.c:1157) 
[ 58.013168][ T1] bus_add_driver (drivers/base/bus.c:674) 
[ 58.013652][ T1] driver_register (drivers/base/driver.c:246) 
[ 58.014177][ T1] __platform_driver_register (drivers/base/platform.c:867) 
[ 58.014730][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969) 
[ 58.015285][ T1] of_unittest_overlay (drivers/of/unittest.c:3217) 
[ 58.015804][ T1] of_unittest (drivers/of/unittest.c:4129) 
[ 58.016264][ T1] do_one_initcall (init/main.c:1236) 
[ 58.016755][ T1] ? dt_alloc_memory (drivers/of/unittest.c:4080) 
[ 58.017247][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.017766][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.018269][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.018802][ T1] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 58.019348][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.019864][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.020382][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.020900][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.021400][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.021931][ T1] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 58.022471][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.022979][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.023496][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.024000][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.024526][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316) 
[ 58.024982][ T1] ? irqtime_account_irq (kernel/sched/cputime.c:?) 
[ 58.025553][ T1] ? irqtime_account_delta (include/linux/seqlock.h:444 include/linux/seqlock.h:516 include/linux/u64_stats_sync.h:151 include/linux/u64_stats_sync.h:187 kernel/sched/cputime.c:46) 
[ 58.026091][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 58.026594][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 58.027070][ T1] ? common_interrupt (arch/x86/kernel/irq.c:247) 
[ 58.027567][ T1] ? asm_common_interrupt (arch/x86/entry/entry_32.S:640) 
[ 58.028119][ T1] ? strlen (arch/x86/lib/string_32.c:175) 
[ 58.028540][ T1] ? next_arg (lib/cmdline.c:273) 
[ 58.028991][ T1] ? parse_args (kernel/params.c:153) 
[ 58.029467][ T1] do_initcall_level (init/main.c:1297) 
[ 58.029957][ T1] ? rest_init (init/main.c:1433) 
[ 58.030398][ T1] do_initcalls (init/main.c:1311) 
[ 58.030846][ T1] ? rest_init (init/main.c:1433) 
[ 58.031299][ T1] do_basic_setup (init/main.c:1334) 
[ 58.031769][ T1] kernel_init_freeable (init/main.c:1555) 
[ 58.032283][ T1] kernel_init (init/main.c:1443) 
[ 58.032732][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 58.033192][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 58.033680][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   58.034672][    T1] gpio gpiochip0: Persistence not supported for GPIO 2
[   58.035366][    T1]
[   58.035669][    T1] =============================
[   58.036180][    T1] WARNING: suspicious RCU usage
[   58.036739][    T1] 6.8.0-rc4-00057-gef4aabaa3721 #1 Tainted: G                TN
[   58.037546][    T1] -----------------------------
[   58.038050][    T1] drivers/gpio/gpiolib.c:112 suspicious rcu_dereference_check() usage!
[   58.038893][    T1]
[   58.038893][    T1] other info that might help us debug this:
[   58.038893][    T1]
[   58.039950][    T1]
[   58.039950][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   58.040837][    T1] 3 locks held by swapper/1:
[ 58.041318][ T1] #0: ea878e8c (&dev->mutex){....}-{3:3}, at: __driver_attach (drivers/base/dd.c:1216) 
[ 58.042234][ T1] #1: eb682f3c (&gdev->srcu){.+.+}-{0:0}, at: srcu_lock_acquire (include/linux/srcu.h:115) 
[ 58.043116][ T1] #2: eb6831dc (&desc->srcu){.+.+}-{0:0}, at: srcu_lock_acquire (include/linux/srcu.h:115) 
[   58.043992][    T1]
[   58.043992][    T1] stack backtrace:
[   58.044685][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                TN 6.8.0-rc4-00057-gef4aabaa3721 #1 10e84cefff2a9bf1626b34c75cc7b6c846de4a3a
[   58.046006][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   58.047050][    T1] Call Trace:
[ 58.047417][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 58.047896][ T1] dump_stack (lib/dump_stack.c:113) 
[ 58.048430][ T1] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6714) 
[ 58.048974][ T1] gpiod_get_label (drivers/gpio/gpiolib.c:?) 
[ 58.049450][ T1] gpiod_hog (drivers/gpio/gpiolib.c:4519) 
[ 58.049901][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799) 
[ 58.050433][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:829 drivers/gpio/gpiolib-of.c:1144) 
[ 58.050933][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:1013) 
[ 58.051503][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886) 
[ 58.052013][ T1] platform_probe (drivers/base/platform.c:1405) 
[ 58.052484][ T1] really_probe (drivers/base/dd.c:?) 
[ 58.052953][ T1] __driver_probe_device (drivers/base/dd.c:800) 
[ 58.053480][ T1] driver_probe_device (drivers/base/dd.c:830) 
[ 58.054001][ T1] __driver_attach (drivers/base/dd.c:1217) 
[ 58.054482][ T1] ? driver_attach (drivers/base/dd.c:1157) 
[ 58.054958][ T1] bus_for_each_dev (drivers/base/bus.c:367) 
[ 58.055451][ T1] driver_attach (drivers/base/dd.c:1233) 
[ 58.055908][ T1] ? driver_attach (drivers/base/dd.c:1157) 
[ 58.056386][ T1] bus_add_driver (drivers/base/bus.c:674) 
[ 58.056871][ T1] driver_register (drivers/base/driver.c:246) 
[ 58.057348][ T1] __platform_driver_register (drivers/base/platform.c:867) 
[ 58.057900][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969) 
[ 58.058450][ T1] of_unittest_overlay (drivers/of/unittest.c:3217) 
[ 58.058973][ T1] of_unittest (drivers/of/unittest.c:4129) 
[ 58.059476][ T1] do_one_initcall (init/main.c:1236) 
[ 58.059967][ T1] ? dt_alloc_memory (drivers/of/unittest.c:4080) 
[ 58.060472][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.060994][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.061500][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.062037][ T1] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 58.062580][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.063084][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.063595][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.064122][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.064665][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.065201][ T1] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 58.065742][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.066248][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.066768][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.067271][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.067805][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316) 
[ 58.068268][ T1] ? irqtime_account_irq (kernel/sched/cputime.c:?) 
[ 58.068795][ T1] ? irqtime_account_delta (include/linux/seqlock.h:444 include/linux/seqlock.h:516 include/linux/u64_stats_sync.h:151 include/linux/u64_stats_sync.h:187 kernel/sched/cputime.c:46) 
[ 58.069333][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 58.069836][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 58.070341][ T1] ? common_interrupt (arch/x86/kernel/irq.c:247) 
[ 58.070842][ T1] ? asm_common_interrupt (arch/x86/entry/entry_32.S:640) 
[ 58.071388][ T1] ? strlen (arch/x86/lib/string_32.c:175) 
[ 58.071812][ T1] ? next_arg (lib/cmdline.c:273) 
[ 58.072278][ T1] ? parse_args (kernel/params.c:153) 
[ 58.072756][ T1] do_initcall_level (init/main.c:1297) 
[ 58.073247][ T1] ? rest_init (init/main.c:1433) 
[ 58.073693][ T1] do_initcalls (init/main.c:1311) 
[ 58.074142][ T1] ? rest_init (init/main.c:1433) 
[ 58.074585][ T1] do_basic_setup (init/main.c:1334) 
[ 58.075052][ T1] kernel_init_freeable (init/main.c:1555) 
[ 58.075573][ T1] kernel_init (init/main.c:1443) 
[ 58.076029][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 58.076498][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 58.076989][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   58.077544][    T1] gpio-514 (line-B-input): hogged as input
[   58.078433][    T1] BUG: unable to handle page fault for address: ffffffff
[   58.079116][    T1] #PF: supervisor read access in kernel mode
[   58.079703][    T1] #PF: error_code(0x0000) - not-present page
[   58.080316][    T1] *pde = 02e00067 *pte = 00000000
[   58.080829][    T1] Oops: 0000 [#1]
[   58.081210][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                TN 6.8.0-rc4-00057-gef4aabaa3721 #1 10e84cefff2a9bf1626b34c75cc7b6c846de4a3a
[   58.082492][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 58.083471][ T1] EIP: gpiolib_cdev_register (drivers/gpio/gpiolib-cdev.c:2802) 
[ 58.084015][ T1] Code: ec e8 7a 10 00 00 89 f8 89 da e8 c1 c8 a5 ff 89 f0 83 c4 0c 5e 5f 5b 5d 31 c9 31 d2 c3 8b 45 f0 c1 e8 14 ff b7 d8 01 00 00 50 <ff> 35 ff ff ff ff 68 7c de 5c c2 ff 35 03 00 00 00 68 3d ad 57 c2
All code
========
   0:	ec                   	in     (%dx),%al
   1:	e8 7a 10 00 00       	call   0x1080
   6:	89 f8                	mov    %edi,%eax
   8:	89 da                	mov    %ebx,%edx
   a:	e8 c1 c8 a5 ff       	call   0xffffffffffa5c8d0
   f:	89 f0                	mov    %esi,%eax
  11:	83 c4 0c             	add    $0xc,%esp
  14:	5e                   	pop    %rsi
  15:	5f                   	pop    %rdi
  16:	5b                   	pop    %rbx
  17:	5d                   	pop    %rbp
  18:	31 c9                	xor    %ecx,%ecx
  1a:	31 d2                	xor    %edx,%edx
  1c:	c3                   	ret
  1d:	8b 45 f0             	mov    -0x10(%rbp),%eax
  20:	c1 e8 14             	shr    $0x14,%eax
  23:	ff b7 d8 01 00 00    	push   0x1d8(%rdi)
  29:	50                   	push   %rax
  2a:*	ff 35 ff ff ff ff    	push   -0x1(%rip)        # 0x2f		<-- trapping instruction
  30:	68 7c de 5c c2       	push   $0xffffffffc25cde7c
  35:	ff 35 03 00 00 00    	push   0x3(%rip)        # 0x3e
  3b:	68 3d ad 57 c2       	push   $0xffffffffc257ad3d

Code starting with the faulting instruction
===========================================
   0:	ff 35 ff ff ff ff    	push   -0x1(%rip)        # 0x5
   6:	68 7c de 5c c2       	push   $0xffffffffc25cde7c
   b:	ff 35 03 00 00 00    	push   0x3(%rip)        # 0x14
  11:	68 3d ad 57 c2       	push   $0xffffffffc257ad3d
[   58.085813][    T1] EAX: 000000fe EBX: 00000000 ECX: 00000000 EDX: 00000000
[   58.086476][    T1] ESI: ffffffed EDI: eb682c00 EBP: c3e1baec ESP: c3e1bacc
[   58.087140][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
[   58.087927][    T1] CR0: 80050033 CR2: ffffffff CR3: 02dfd000 CR4: 000406d0
[   58.088601][    T1] Call Trace:
[ 58.088950][ T1] ? __die_body (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420) 
[ 58.089388][ T1] ? __die (arch/x86/kernel/dumpstack.c:434) 
[ 58.089790][ T1] ? page_fault_oops (arch/x86/mm/fault.c:703) 
[ 58.090279][ T1] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:761) 
[ 58.090815][ T1] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:817) 
[ 58.091344][ T1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:866) 
[ 58.091846][ T1] ? do_kern_addr_fault (arch/x86/mm/fault.c:1226) 
[ 58.092347][ T1] ? exc_page_fault (arch/x86/mm/fault.c:?) 
[ 58.092822][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1520) 
[ 58.093407][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 58.093964][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1520) 
[ 58.094556][ T1] ? gpiolib_cdev_register (drivers/gpio/gpiolib-cdev.c:2802) 
[ 58.095076][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1520) 
[ 58.095666][ T1] ? gpiolib_cdev_register (drivers/gpio/gpiolib-cdev.c:2802) 
[ 58.096187][ T1] gpiochip_setup_dev (drivers/gpio/gpiolib.c:740) 
[ 58.096665][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:1047) 
[ 58.099219][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886) 
[ 58.099744][ T1] platform_probe (drivers/base/platform.c:1405) 
[ 58.100210][ T1] really_probe (drivers/base/dd.c:?) 
[ 58.100662][ T1] __driver_probe_device (drivers/base/dd.c:800) 
[ 58.101172][ T1] driver_probe_device (drivers/base/dd.c:830) 
[ 58.101667][ T1] __driver_attach (drivers/base/dd.c:1217) 
[ 58.102131][ T1] ? driver_attach (drivers/base/dd.c:1157) 
[ 58.102587][ T1] bus_for_each_dev (drivers/base/bus.c:367) 
[ 58.103061][ T1] driver_attach (drivers/base/dd.c:1233) 
[ 58.103505][ T1] ? driver_attach (drivers/base/dd.c:1157) 
[ 58.103962][ T1] bus_add_driver (drivers/base/bus.c:674) 
[ 58.104431][ T1] driver_register (drivers/base/driver.c:246) 
[ 58.104902][ T1] __platform_driver_register (drivers/base/platform.c:867) 
[ 58.105443][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969) 
[ 58.105976][ T1] of_unittest_overlay (drivers/of/unittest.c:3217) 
[ 58.106475][ T1] of_unittest (drivers/of/unittest.c:4129) 
[ 58.106911][ T1] do_one_initcall (init/main.c:1236) 
[ 58.107384][ T1] ? dt_alloc_memory (drivers/of/unittest.c:4080) 
[ 58.107860][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.108367][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.108853][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.109364][ T1] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 58.109889][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.110377][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.110926][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.111428][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.111917][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.112441][ T1] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 58.112964][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3762) 
[ 58.113450][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 58.113964][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[ 58.114454][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306) 
[ 58.114963][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316) 
[ 58.115399][ T1] ? irqtime_account_irq (kernel/sched/cputime.c:?) 
[ 58.115903][ T1] ? irqtime_account_delta (include/linux/seqlock.h:444 include/linux/seqlock.h:516 include/linux/u64_stats_sync.h:151 include/linux/u64_stats_sync.h:187 kernel/sched/cputime.c:46) 
[ 58.116430][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 58.116929][ T1] ? irqentry_exit (kernel/entry/common.c:?) 
[ 58.117391][ T1] ? common_interrupt (arch/x86/kernel/irq.c:247) 
[ 58.117869][ T1] ? asm_common_interrupt (arch/x86/entry/entry_32.S:640) 
[ 58.118390][ T1] ? strlen (arch/x86/lib/string_32.c:175) 
[ 58.118799][ T1] ? next_arg (lib/cmdline.c:273) 
[ 58.119238][ T1] ? parse_args (kernel/params.c:153) 
[ 58.119689][ T1] do_initcall_level (init/main.c:1297) 
[ 58.120167][ T1] ? rest_init (init/main.c:1433) 
[ 58.120596][ T1] do_initcalls (init/main.c:1311) 
[ 58.121033][ T1] ? rest_init (init/main.c:1433) 
[ 58.121460][ T1] do_basic_setup (init/main.c:1334) 
[ 58.121908][ T1] kernel_init_freeable (init/main.c:1555) 
[ 58.122401][ T1] kernel_init (init/main.c:1443) 
[ 58.122873][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 58.123330][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 58.123804][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   58.124281][    T1] Modules linked in:
[   58.124686][    T1] CR2: 00000000ffffffff
[   58.125108][    T1] ---[ end trace 0000000000000000 ]---
[ 58.125635][ T1] EIP: gpiolib_cdev_register (drivers/gpio/gpiolib-cdev.c:2802) 
[ 58.126171][ T1] Code: ec e8 7a 10 00 00 89 f8 89 da e8 c1 c8 a5 ff 89 f0 83 c4 0c 5e 5f 5b 5d 31 c9 31 d2 c3 8b 45 f0 c1 e8 14 ff b7 d8 01 00 00 50 <ff> 35 ff ff ff ff 68 7c de 5c c2 ff 35 03 00 00 00 68 3d ad 57 c2
All code
========
   0:	ec                   	in     (%dx),%al
   1:	e8 7a 10 00 00       	call   0x1080
   6:	89 f8                	mov    %edi,%eax
   8:	89 da                	mov    %ebx,%edx
   a:	e8 c1 c8 a5 ff       	call   0xffffffffffa5c8d0
   f:	89 f0                	mov    %esi,%eax
  11:	83 c4 0c             	add    $0xc,%esp
  14:	5e                   	pop    %rsi
  15:	5f                   	pop    %rdi
  16:	5b                   	pop    %rbx
  17:	5d                   	pop    %rbp
  18:	31 c9                	xor    %ecx,%ecx
  1a:	31 d2                	xor    %edx,%edx
  1c:	c3                   	ret
  1d:	8b 45 f0             	mov    -0x10(%rbp),%eax
  20:	c1 e8 14             	shr    $0x14,%eax
  23:	ff b7 d8 01 00 00    	push   0x1d8(%rdi)
  29:	50                   	push   %rax
  2a:*	ff 35 ff ff ff ff    	push   -0x1(%rip)        # 0x2f		<-- trapping instruction
  30:	68 7c de 5c c2       	push   $0xffffffffc25cde7c
  35:	ff 35 03 00 00 00    	push   0x3(%rip)        # 0x3e
  3b:	68 3d ad 57 c2       	push   $0xffffffffc257ad3d

Code starting with the faulting instruction
===========================================
   0:	ff 35 ff ff ff ff    	push   -0x1(%rip)        # 0x5
   6:	68 7c de 5c c2       	push   $0xffffffffc25cde7c
   b:	ff 35 03 00 00 00    	push   0x3(%rip)        # 0x14
  11:	68 3d ad 57 c2       	push   $0xffffffffc257ad3d


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240226/202402262225.50983057-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


