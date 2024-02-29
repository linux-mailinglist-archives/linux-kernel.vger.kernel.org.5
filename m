Return-Path: <linux-kernel+bounces-86941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9986CD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B009287223
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B8C14A4CF;
	Thu, 29 Feb 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yh1Hl6h5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA914A089
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221455; cv=fail; b=KbsrVgb7dcy8znR0oF8YpkfjkG0wamoyDPJBPCqgsydJA8/FsYbSxUCzDUmDvYuHk0q2sefAvhDES38nwUCtZvBpsLLK8fFtunqbsjRwB4NOvOIyp5jHLwcHKC7CjsjlN7iSH0KDcybvFVbsKCviHu6A0qekwfM7SkhjnjcFM4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221455; c=relaxed/simple;
	bh=Z2D1YHJ2JBKasHH4tUjcCQbt54WScYbiSHTM8p6qLC8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VxXckMyMDGw9x1XsJniyG3sFYOfWbC1bxLTfMNZ7YsA59d+ChmlYkerpWX+OxM/tIgX0uSBLn5uAlk32gYaDv9zWbIakLiOu2OqJBVyBcGRECYbprRiRJa5eSqggb5Gst502lj4FrxxywgGAE2fm+WM2v84TbzgHyv/Y0jI5uQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yh1Hl6h5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709221454; x=1740757454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z2D1YHJ2JBKasHH4tUjcCQbt54WScYbiSHTM8p6qLC8=;
  b=Yh1Hl6h5Z03iqbwin1xKw97Q/lXGAJC72Q9tAwCwmodV5U5kX2tjUuQH
   1V9Am8TTbEOPqeNH3JtdMtJzttwWISfKwU63MfFlmdhqQ06tnLg26OdaU
   qWv+p5p70wIgUARlrJ5qBO/PlkE+9WMb5hGLyPRMXHS9LfPKB1fPxePS8
   lqsmMk6lJyZH3WzwBCqI3Q7uKz0ULTcbL9EKoysepqehLaR7V+XH11eYR
   f1SSW3PguMKoooNW4xnc1zDwZOQ/DlNDj/lS+rNIYxKER2BjPd9VFJO3k
   2gP6Vfd9ZXbtY0PQBNWTdCkiYPH5LSj/tZlHRoFLOnt5mTSItQ6pm/FuG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6646747"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6646747"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:44:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8421296"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 07:44:08 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 07:44:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 07:44:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 07:44:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVa2QZWqdErI5IWMxPXgqburRK0W0oX/X0pyyCRDAuhY/2utuQj9Y8eAxdmyicrTM0i1MKyP62A65qJufMSbnAHdmS9rgDE1H5w3El7dP1vo9X14/XEiKFPHWRENwOYioxncuE2J8uVdJoR+P7a6IzkVFMD5X+Ot7jC9o+2i05PqN5ouR+esclkPyWHx/wRbmoIQ0/kuBQJNtzL6u9aGqUpahzFeRCuBXua/UDdQhJO5WewlJv7+2aI3OSXj2eShtCryFqSe/y3vUZzHNfZkzmwSwVDdBnKlKtJAwDAhh+DcrkmsXqTPrYlwyhUGMmWG2e7eevQSWpjuQkK4m6GfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxOJCSYEjIcrFLNz86WZMDx5hh6BgH76bTPqUwRaW78=;
 b=KVw8JsaoWNc4DMAO8+NJZnKhRMhoarCR4AVbYJtsWwm9Q5DERjxfmAQu831IAeo78BRAyavPT2F3Eff9tgNnDtmeEjPBRJ3WFtg48JEi3rKYIAGUpuliD/+583ktpV/Pes9/emB6fQnIdY6NIPqx2iqAb/zMbmG6pUOtQQcCDM+QtpgDqpr9Lcm3Sjte+czk+Pos/EjtFEy7FaIqh3eNzgqcZQKkSUnWRWjFnvADXD748PoauxsQ94LJOtwaAJ7tIj5HZdHVFTENBiw+AHhxss9QrbU1QKphRCpJz/TDvv4cYJA+HqdUKcoaUoikgJ3WlvoTv/XTC5lkPA829q89AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 29 Feb
 2024 15:44:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 15:44:02 +0000
Date: Thu, 29 Feb 2024 23:43:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [broonie-ci:regmap-test-format] [regmap]  af560701e3:
 RIP:__regmap_init
Message-ID: <202402292329.a1c8a83f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 870b36c8-bee6-4225-238e-08dc393d40df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: If7jwh1N/Tqyrpe2B/FZmheht/HadaRxuZqXHALQFS9QYrqLz/A859WPUAbQ8SnUMhnt+KnER4dYj1kB7ltB1kotcMbJygyRxVy6BZOl1QemzOox8FfidvCF7p/sDYgpoYZgdG3wDf9YcIY1PT+N8evab4o0OEoL00hTVPdpFaGPMofOwA9Fvv5ZkTY4q30yUcSvsYFGdxMyi1yzmdPSX1Ll0kIZkQYbuvGxHzW/WqtBcr6i8pp12Bf+FrgJsVnXUelqNscWwxBbuLYYhd5Okjckf7t136DlfbKnoyM9AYLL4sOXdk8iPYcTpsavvH+P1jEvKHtC6KyEcxFnVePC4Ig57gd8vKr10kSaC2KIua/BwJXRxxX0r9SwBzshel5qWU/+sMV38oRRAEw0vcYSQ7kPAO1JfJdhXpZitdpIZiPIcZEnvnZioMSAQO1x291V1uz7uaki4RKCm4HAFwJh2RHewmjbcZukTF3hfdnhg7Sq71qRuhtHZLjvIZMjwt4K7S+PLDFS+6L3ALW2b3E6R2DqoimpSuQ5cNRS7k0wZA4f4iGCGve+VElNucDYpiSI/5rLMSm7HFVEGlgW6GEiGAKTNqggIzMqUsashID8yMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9uyvd7YWuby8g62k3wCp/ri3vWjYBZG1RGsw7W5l6V9t8w1SvZsBRKJvqPF?=
 =?us-ascii?Q?IylWv10YeqcX71zI54z9lr4ksa4JWCO6x5aj9CmG2l+OCb3hqeU1lYSi4dhI?=
 =?us-ascii?Q?rayBGziGgUFpkglohM4Q34wtEIXJUNfZgwJFz9dG0wvwdQQsXOJdTWyTsL29?=
 =?us-ascii?Q?9Kqlm0lyUEnCq7mE1hVWoND4yD12W/HNKrRtrbViKLKWHmV47u1mVpCLOGl9?=
 =?us-ascii?Q?0XlwbJUkCT8rO6FXu6LJQiuyuPUYu0XmHWEHAYGnKhsVGeisC4QAJ/EgZ99i?=
 =?us-ascii?Q?4MOqZNEdDbG8neNImSXBqZi4K35O+K+eQuf5fvpaPAeCnEq66bIPDCdIs2A9?=
 =?us-ascii?Q?StfIoWshqOpuOOrd6I9B7X8743N/ZXSfvDRdCFc7+n03vR6fVsXqiNqjg7/5?=
 =?us-ascii?Q?U1YgGh9fmsIph+iWyVc6uCusqT8zWTplas/fP5/BSy7qEeJ6jAXJ+uRPJHgN?=
 =?us-ascii?Q?dzhbo5yAQEd/sakLmtHO4ouUzCeFPiBMEMxyF4wdD+6eXpkJNjSsEtyEqPDY?=
 =?us-ascii?Q?9OJuKffE5AgAwvP3BjzyxJZpwU+ovvX4LEsxIsNaMc0v5xzb/YZWLRyGMdmi?=
 =?us-ascii?Q?WHg5c/gwFSam6Do0Q2T64Fn/RHL8wq2iToGmXBhh3Bu271XvWrTr/ZPhlQhQ?=
 =?us-ascii?Q?3SZJT6SWK7JbAgllvMF+1IYataFLTQ8G8L0SoSGf+tYRt3QyOC1CQ9QWR5tO?=
 =?us-ascii?Q?iStF6UTsixBpzt+QBT00XVnhSjg9Q679geP8VDDfMX7K0QtymvTrGL5z1wIM?=
 =?us-ascii?Q?eGHFxcz1PVBpmuLdPRWRrwsBvqCwcLl2/SsWPid2ph9A0OOXIM+3mN62Iwqj?=
 =?us-ascii?Q?1oWr5p7rqfp95Av0jSO7GcYm34Z+R011Slul6UmuaCJLb9tbdFMUErzk3NsS?=
 =?us-ascii?Q?uX+ITAjJvvLx5se7enp13R0ZwvKO6eBPIYjHjgKrx4xiZKbNcCY2LThaBFH5?=
 =?us-ascii?Q?V5fzgVW9iejq8MMiE/97RwijwaA3Rgwet9n8mcnR5xzDrW3tTED29DMi5dRE?=
 =?us-ascii?Q?lVI+n2sKK3DhMRW25t7IcGSL7F0lMNzN2SwBltkj8Nlr5UeHGsluD+iPHI24?=
 =?us-ascii?Q?1Gq1RJpNlD8c6c+u1SdGW8cEUD28kBuV6Gax4Itfp5x/4cr8O2btTM8jvzne?=
 =?us-ascii?Q?Pr5Y7gxu0Pg3iVUOedAJoN+qze5J1oXs8Uc22qYYsJ732xMfM+Fvqj0YFUPQ?=
 =?us-ascii?Q?fPw+u/6e+0X9EZNcOJCwbAUyS0WqsfRTVyC58cRtcDxqnMcHohTenOp6gBqh?=
 =?us-ascii?Q?q2C7WMVKjJD3g/09pTt3pVZk/RHnAb0BDs7Onl6T5eL+7s7RHfjjRf7uF5o+?=
 =?us-ascii?Q?sM3Xvb/WlSmS9Ak0B4p9ZJ5wOmnDcbEJXmtmwwT9hcpNtJ2LAErGNiVdsnFh?=
 =?us-ascii?Q?FcLwgjitmsf0LhzrQ1M9tW3anv0nNrbzN7qs7SNRQmHsEmMILlx5AU4ZxCo7?=
 =?us-ascii?Q?PNTzMA54Txd5JjA+dg34VjnOO2kxMTTljUhv5+Y6vqGKsm8qKt41DuwN+KQb?=
 =?us-ascii?Q?i8KoFm+bTn9mfbspk6E12dozYkBWkvGMryUHTs21a0ikUkZD9lnLsbKj2Cs0?=
 =?us-ascii?Q?1Yyc+/Hm/oDOpTTSonpTLatMuHwi8L/qOE+QkwixPAV8pxfCG1hTKPTR/aLc?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 870b36c8-bee6-4225-238e-08dc393d40df
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:44:02.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYJdwwQwVHAYMqS2+r8pzXP2TZisfhy8CWkKvSS/xyE5InjfvsmhwXBAnsGKEYFxrhdhUfsFCq9J4BUL5Z0ykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:__regmap_init" on:

commit: af560701e366502504aebae54af374710e35b55b ("regmap: Provide a callback for bus specific initialisation")
https://git.kernel.org/cgit/linux/kernel/git/broonie/ci.git regmap-test-format

in testcase: ftrace-onoff
version: 
with following parameters:

	runtime: 5m



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402292329.a1c8a83f-lkp@intel.com



System Message B[   19.311388][  T211] RIP: 0010:__regmap_init+0x26fa/0x4a40
[   19.318140][  T211] Code: bc 97 ff ff 4c 63 e8 45 85 ed 0f 85 06 10 00 00 48 8b 44 24 08 48 8d 78 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c4 21 00 00 48 8b 44 24 08 48 8b 40 08 48 85 c0
[   19.330604][  T191] scsi host0: ahci
[   19.338703][  T211] RSP: 0018:ffffc90000ccf408 EFLAGS: 00010202
[   19.338707][  T211] RAX: dffffc0000000000 RBX: ffff888172c27800 RCX: ffffffff83a271cb
[   19.338708][  T211] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 0000000000000008
[   19.338709][  T211] RBP: ffff888172c279f8 R08: 0000000000000001 R09: fffff52000199e6a
[   19.345023][  T191] scsi host1: ahci
[   19.348120][  T211] R10: 0000000000000003 R11: ffffffff83c0009f R12: 0000000000000000
[   19.348122][  T211] R13: 0000000000000000 R14: ffff888172c27a55 R15: 0000000000000000
[   19.348123][  T211] FS:  00007efca7a8e8c0(0000) GS:ffff8887a5500000(0000) knlGS:0000000000000000
[   19.348125][  T211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.348127][  T211] CR2: 00007efca702c55b CR3: 0000000807fe0001 CR4: 00000000003706f0
[   19.357944][  T191] scsi host2: ahci
[   19.363655][  T211] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   19.363657][  T211] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   19.363658][  T211] Call Trace:
[   19.363659][  T211]  <TASK>
[   19.363660][  T211]  ? die_addr+0x40/0xa0
[   19.373829][  T191] scsi host3: ahci
[   19.374968][  T211]  ? exc_general_protection+0x150/0x220
[   19.374975][  T211]  ? asm_exc_general_protection+0x26/0x30
[   19.384252][  T191] ata1: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b100 irq 125 lpm-pol 0
[   19.390500][  T211]  ? entry_SYSCALL_64_after_hwframe+0x63/0x6b
[   19.399218][  T191] ata2: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b180 irq 125 lpm-pol 0
[   19.405598][  T211]  ? _raw_spin_lock_irqsave+0x8b/0xe0
[   19.413367][  T191] ata3: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b200 irq 125 lpm-pol 0
[   19.416904][  T211]  ? __regmap_init+0x26fa/0x4a40
[   19.424672][  T191] ata4: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b280 irq 125 lpm-pol 0
[   19.432429][  T211]  ? __regmap_init+0x26d4/0x4a40
[   19.432434][  T211]  ? __devres_alloc_node+0x4c/0x170
[   19.521757][  T211]  ? __devres_alloc_node+0x4c/0x170
[   19.521776][  T211]  __devm_regmap_init+0x6c/0xd0
0m] Reached targ[   19.539892][  T211]  ? clk_hw_create_clk+0x87/0x3b0
[   19.554331][  T211]  ? really_probe+0x3d2/0xb40
[   19.559630][  T211]  ? 0xffffffffc0442000
[   19.559632][  T211]  ? dw_reg_read+0x90/0x90 [i2c_designware_core]
0m] Reached targ[   19.559640][  T211]  ? _raw_read_unlock_irqrestore+0x50/0x50
[   19.559659][  T211]  i2c_dw_probe_master+0x10c/0xbb0 [i2c_designware_core]
[   19.559663][  T211]  ? _raw_read_unlock_irqrestore+0x50/0x50
[   19.559666][  T211]  ? i2c_dw_unprepare_recovery+0x60/0x60 [i2c_designware_core]
[   19.610796][  T211]  ? ktime_get_mono_fast_ns+0x87/0x1e0
[   19.616188][  T211]  ? dmi_matches+0xc0/0x2d0
[   19.620616][  T211]  dw_i2c_plat_probe+0x9c6/0xbe0 [i2c_designware_platform]
[   19.627721][  T211]  platform_probe+0x9f/0x140
[   19.632260][  T211]  really_probe+0x3d2/0xb40
[   19.636687][  T211]  __driver_probe_device+0x18c/0x440
[   19.641890][  T211]  ? __device_attach_driver+0x260/0x260
[   19.647354][  T211]  driver_probe_device+0x4a/0x120
[   19.652311][  T211]  __driver_attach+0x1d2/0x490
[   19.656997][  T211]  ? __device_attach_driver+0x260/0x260
[   19.662459][  T211]  bus_for_each_dev+0x103/0x180
[   19.667261][  T211]  ? bus_remove_file+0x40/0x40
[   19.671948][  T211]  ? klist_add_tail+0x133/0x260
[   19.676724][  T211]  bus_add_driver+0x29a/0x570
[   19.681327][  T211]  driver_register+0x134/0x450
[   19.686013][  T211]  ? 0xffffffffc0602000
[   19.690096][  T211]  do_one_initcall+0xa1/0x370
[   19.694698][  T211]  ? trace_event_raw_event_initcall_level+0x1a0/0x1a0
[   19.701369][  T211]  ? kasan_unpoison+0x27/0x50
[   19.705973][  T211]  do_init_module+0x22e/0x720
[   19.710576][  T211]  load_module+0x1826/0x25e0
[   19.715093][  T211]  ? post_relocation+0x370/0x370
[   19.719954][  T211]  ? kernel_read_file+0x243/0x820
[   19.724900][  T211]  ? __x64_sys_fspick+0x2a0/0x2a0
[   19.729848][  T211]  ? init_module_from_file+0xd1/0x130
[   19.735137][  T211]  init_module_from_file+0xd1/0x130
[   19.739737][  T242] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.740147][  T211]  ? __ia32_sys_init_module+0xb0/0xb0
[   19.740151][  T211]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
[   19.747013][  T235] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.752147][  T211]  ? _raw_write_lock_irq+0xe0/0xe0
[   19.752151][  T211]  idempotent_init_module+0x23b/0x660
[   19.757541][  T240] ata3: SATA link down (SStatus 4 SControl 300)
[   19.764317][  T211]  ? init_module_from_file+0x130/0x130
[   19.764320][  T211]  ? __fget_light+0x58/0x410
[   19.764323][  T211]  ? security_capable+0x6e/0xa0
[   19.769389][  T242] ata4.00: ATA-10: CT1000BX500SSD1, M6CR030, max UDMA/133
[   19.774437][  T211]  __x64_sys_finit_module+0xbe/0x130
[   19.774440][  T211]  do_syscall_64+0x63/0x170
[   19.780525][  T238] ata2: SATA link down (SStatus 4 SControl 300)
[   19.785763][  T211]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[   19.790336][  T242] ata4.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[   19.794849][  T211] RIP: 0033:0x7efca7f479b9
[   19.801759][  T235] ata1.00: ATA-8: ST1000DM003-1CH162, CC44, max UDMA/133
[   19.806848][  T211] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
[   19.811574][  T235] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[   19.817209][  T211] RSP: 002b:00007ffd75a31238 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   19.817212][  T211] RAX: ffffffffffffffda RBX: 0000555f15f8b4e0 RCX: 00007efca7f479b9
[   19.817215][  T211] RDX: 0000000000000000 RSI: 00007efca80d2e2d RDI: 000000000000000f
[   19.823854][  T235] ata1.00: configured for UDMA/133
[   19.830418][  T211] RBP: 0000000000020000 R08: 0000000000000000 R09: 0000555f15f830c0
[   19.830420][  T211] R10: 000000000000000f R11: 0000000000000246 R12: 00007efca80d2e2d
[   19.830421][  T211] R13: 0000000000000000 R14: 0000555f15f82b50 R15: 0000555f15f8b4e0
[   19.830424][  T211]  </TASK>
[   19.834659][  T242] ata4.00: Features: Dev-Sleep
[   19.835192][   T65] scsi 0:0:0:0: Direct-Access     ATA      ST1000DM003-1CH1 CC44 PQ: 0 ANSI: 5
[   19.841470][  T211] Modules linked in: kvm(+) drm_buddy intel_gtt
[   19.870688][  T242] ata4.00: configured for UDMA/133
[   19.876667][  T211]  irqbypass drm_display_helper crct10dif_pclmul crc32_pclmul crc32c_intel ttm ghash_clmulni_intel sha512_ssse3 mei_wdt
[   19.884870][   T11] scsi 3:0:0:0: Direct-Access     ATA      CT1000BX500SSD1  030  PQ: 0 ANSI: 5
[   19.892195][  T211]  drm_kms_helper rapl ahci wmi_bmof libahci video intel_cstate intel_uncore mei_me i2c_designware_platform(+) libata mei idma64 i2c_designware_core wmi pinctrl_sunrisepoint acpi_pad drm fuse ip_tables
[   19.992664][  T211] ---[ end trace 0000000000000000 ]---
[   19.998347][  T211] RIP: 0010:__regmap_init+0x26fa/0x4a40
[   20.003858][  T211] Code: bc 97 ff ff 4c 63 e8 45 85 ed 0f 85 06 10 00 00 48 8b 44 24 08 48 8d 78 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c4 21 00 00 48 8b 44 24 08 48 8b 40 08 48 85 c0
[   20.023434][  T211] RSP: 0018:ffffc90000ccf408 EFLAGS: 00010202
[   20.029498][  T211] RAX: dffffc0000000000 RBX: ffff888172c27800 RCX: ffffffff83a271cb
[   20.037438][  T211] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 0000000000000008
[   20.045401][  T211] RBP: ffff888172c279f8 R08: 0000000000000001 R09: fffff52000199e6a
[   20.053349][  T211] R10: 0000000000000003 R11: ffffffff83c0009f R12: 0000000000000000
[   20.061290][  T211] R13: 0000000000000000 R14: ffff888172c27a55 R15: 0000000000000000
[   20.069224][  T211] FS:  00007efca7a8e8c0(0000) GS:ffff8887a5500000(0000) knlGS:0000000000000000
[   20.078096][  T211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.084627][  T211] CR2: 00007efca702c55b CR3: 0000000807fe0001 CR4: 00000000003706f0
[   20.092563][  T211] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.100496][  T211] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   20.108433][  T211] Kernel panic - not syncing: Fatal exception
[   20.114453][  T211] Kernel Offset: disabled



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240229/202402292329.a1c8a83f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


