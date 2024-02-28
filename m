Return-Path: <linux-kernel+bounces-84449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046F86A6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A3128463B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2C1CD1C;
	Wed, 28 Feb 2024 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4CjP9pf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F871CD24
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088441; cv=fail; b=ojmu/+Isv1qIe3CxSOWghDCDM6uv2CejgS80PI9IwGztZU+/67lGkIjFEopIHwdf9AI9J5t9e8/Sswv4TCh630Q9awancnaAvign5P7J/v9qwvsVhSQb9LyG93F/ZLw0g+rYykq15IdC5Hz0E8VrO+Sfpa7bqPpmgCo0RNFTxeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088441; c=relaxed/simple;
	bh=Gb48iSUxsEyGVHcmFKIqqUxPrRrFd2DPUlMhKM4ej1U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cT6Kc8eBLQayxaHI2+UzlDKHNc8h3tNGsh3OPVy0DDORlPkTS28cz8ztH8npLaug8QujjX5hUS69ImFCTdJ1UJAvZRgpQvbZ5yBxBsSpuJsOFExTm0N7Fe481M8Nwlkfvmjgvi4oVZKZvx4IyX12szM/07mo/1sBEWbY6+f+zV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4CjP9pf; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709088440; x=1740624440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gb48iSUxsEyGVHcmFKIqqUxPrRrFd2DPUlMhKM4ej1U=;
  b=d4CjP9pfNRnXJy0u8oVuLKkvXeDy1lvBKT92x5eBoIV1CUb1PZTnnAoZ
   LttQa5gvUNDn3MbAxA41I0cjkoHctb+KmJidYDsGwlBEDMJJTz2eF/HzO
   mfTg+zxlU9sJDN/2AHFYXIlzWrYMLqAF5jpo5ZeadZNmXxtqLLktkQAKU
   TARYOIpQlKgSbXR5C1AyiP7MhElvBBnE1OWGlfPyc+RXL6E8oIeyi6GHL
   mORAiUCvRn86cAR0lUJNaCb8MjP3YnHReSpdVB7LQme1U/9z7HChxnaV0
   6QUcKsUPLKRrs3/iPNX9c9IAYJe70g+GNK236pYOc8VkUgXIdURfRkTUG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3327558"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3327558"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:47:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11834190"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 18:47:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 18:47:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 18:47:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 18:47:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9jPm7OIkWEvqj8vdHtbImfdzLCKOJVGDrhkSpa4dYC9B0b1PDG2CnntedB4XP61kH/pdQDyyeWpGJeCAmjljyMywKSY+SSFjBqP6/Xs+c1Q864O1D0rCdafM90JsdEr7MMO0U0jJGeY9O2wwNgXv24PzxTq5RsKSoL0ORm980rLxCibbPAVaLFL1g1spNmHuh6BgrLxqlSZvAwGNK8Yv75PA7+l/SsMcTWh6zN55KXVcEdFyRUGWKOGIWQjxjDpJPg4Ml38wF1ZBWNEat6n25tMVwFiJHUfAdk28tbIBOXmQv/ojIV3NI7MHz0u9tpGjAkeW3F1pxbFKOedb0O5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsvdN/cjnlor4YOYBl2ewNsBYGISxW5W06/2f2WXLvU=;
 b=j+6GkVuKd79Wspz1NmeAn2Cnk8/4aydqmrDZgzsZrJdOx02CvAiXzB9nuhUQDprE5vnff+vH5bIapLLEg2MsVUGVuAneig2Vw2Rf67eEMVYYM3oEwp+IWSLDLq5rJDlpWSeI5UKVN+a6rTy+13urOcrSFcZhJHQNOR8zygp4xLrLJaSARdraFiW1TjTHqGJclQPddFA1PHPBpFEYIDtC7zuuTRx1NLSKd8W4lb4ceKpXWIQFiNJj4wFYeBOzkkOKO3N9ZnqBMEmH62bZeZMUk3Fq+aFznlp5ZJf+xNDSkj1N9wqTnhvxtLklHrtLaVSnzF4Yl6l+U1+koecmpfc++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 02:47:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 02:47:11 +0000
Date: Wed, 28 Feb 2024 10:47:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Daniel Bristot de Oliveira
	<bristot@kernel.org>, <linux-kernel@vger.kernel.org>, <ltp@lists.linux.it>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [bristot:dl_server_v6] [sched/fair]  cf9fc54f9a:
 WARNING:at_kernel/sched/deadline.c:#pick_task_dl
Message-ID: <202402281042.5766096e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: 711a05e9-5f39-40ef-0c29-08dc38079028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsCW+0ikOrelqWBLTtjT0CJlsCAV2h9llXf/jJl48e3wqr62+o2ybRzYoFEJB9SMAgE2w1vy5g6fpHxC2mBqHjJSVmN/6gbB1u3vvyY85dW7VbYnJwEssEz118zUc/2bxApy0E1my2O2i2kQ+p8DeptKBkv2kWjdMR3Nxs/NJTojWWaqJhTZpcMT0gdoLhcP6Hg9g+xzdaemQJYisUS/w+lHD0mNQ4pGLmwurLw23/Jl1U3gpDYIyMkXo9iufHs0lzWEFr+Zl21yPFDBjXow9DQtgrOe7ZGpYToCDQisCb/3GGKsBWQO+leQupOawf/0kZBLCRNvUL74s0YU9PJmjBKeK81DaCz6+x9rCw8OxFriwP8zh0b6MW+JbX3Z4FAY3f2ttByQmXtbHojgR+zvRvHnYwqR3e+GznV0LVmxUX/IezHMmsdHo66k4w3VX+riOVt7+wSRbDMOCAEDAQnpocD9L+9bu+b4rLzxI4VjpnIpX9B9KM0geVtPNmXyZaGAwFS8lxdS9Vd5njsjXYNLN0GDp69O8HoPP1QD2W950Ept1PoBN1wG7HjQMKzpwhJJMjIjpXdlMLPBRNjR8Ffp5fGQ1M/z7DT0D1Oepat5cnk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DybtltzkltfIadMS9YHaPW0AYqTK4DRqP1adrNRkff3uPgpwG5RyXOggvJr+?=
 =?us-ascii?Q?LTv8PlEu4KLGxoQQ0BVoxKrxzyBnqywqAEvmwa/XizGUKtGwPJboDskvSlmt?=
 =?us-ascii?Q?K7wjjA9f5gPOOqlSM6uSEFSCdahugFNGWndHiMj5e+qkKRvsvBM6E6aQaJXS?=
 =?us-ascii?Q?IeKKEvUV+hy1Uqdz1tVr14uyvKmHa35DnR2AYwQqPGecWz0NO+BZdzgegO43?=
 =?us-ascii?Q?otFLj6WUKer6zxmguY9v9TNYr4qDzg2wKQS+Imf/HR4zESJEwhc1HM26A4Bl?=
 =?us-ascii?Q?o47t5Y9tp1pF07PeqwkhrpwDh+han4GiutizgSMmSD5yuOZO6tLNogJUeb+1?=
 =?us-ascii?Q?nn4DeRROIzkdeLwJ5wC2jcrnyHoFzbCS3YCEbCcACE7pXYdic52VmsYT3bED?=
 =?us-ascii?Q?c3LbHKOVSSp+UxQzY+UFnwg/c+XzB6BOTgEnskY1PWPQ8XUnae1DDP4mWy+8?=
 =?us-ascii?Q?84eX94Oy1zaeZNsWzoQEJMFjBLBVcXNNrwr55xgppfAZCnjF2x8TEGQUJayY?=
 =?us-ascii?Q?vFLVyDdF63Ux/qolO9qDMjU5MtER913wxPl0DvJWvubdDgA9qwuKm1B4qhPU?=
 =?us-ascii?Q?qR26K0ZQrB1XkqwAqqzqKiCUDt2P/5sGah3iT8vb5C71ijGQMGG3N2badL1g?=
 =?us-ascii?Q?3lZ69WtbHdsfGCWID3+onSI9xFUhO3l61mQUOV2iCbLAPmYaoPHDoJG9fLeY?=
 =?us-ascii?Q?4PjR2xJG0V+ORB8cPFhLPhh5hWSBvZQIeOUHG+x+jG0/KFVzPnwm9c8UsoNd?=
 =?us-ascii?Q?9i8DiUag+Ai5cjoeGRqFThma/FpByW/Hwv+0ZDP39+R9ooqedaxFQbKfN1WO?=
 =?us-ascii?Q?he88nG3bWNTTmbPPiMgkk2UfFu7iyg/MF2D66pkgBovlFUT9uFcIw4gKnvUV?=
 =?us-ascii?Q?Spq0LoEzWAssk4L3cXnzEmxgGPjKGarXVPy8N120eZgA2mz+k4rJFuM/GWX+?=
 =?us-ascii?Q?aSchQbNe0qnSBUfRH137paE52wE/RwSvs4rzKfrVi3v8403VAaeGiLg9DnY1?=
 =?us-ascii?Q?TeDNt97NOAMttpbMTt7W58u1iuXY9McluGsSr/zSHg3X6d6T4a4ILTAPrvpT?=
 =?us-ascii?Q?bX9PmdeP8qd3LEB7LGDkN2cvOrk9M/lB/PlAUSstp8KiEXjehMxT6D2tkqbl?=
 =?us-ascii?Q?DCPCNG9rYrFehy5tgcIQpmBOFHpSb+gfti0vjj9qvZbz9JRNcCPLktsFXNPI?=
 =?us-ascii?Q?Xigi+G/ezmWI/+Va12JPvGhehVy1EJFPU8xKjqY7JCESY0E6W2ltEydgKjXO?=
 =?us-ascii?Q?s+7i/K3APFBkaqxs9klHEP1rAtYMTLTinNLLrmtT9H/leRVWgvaVkLibygmM?=
 =?us-ascii?Q?7EXeAT7YqWJI9ABz/J1Bf+y6I04SMimdqkedKBJD8Ln43xvFtiw9vVly7HNT?=
 =?us-ascii?Q?+PVguVbI5LduG/UIi7yjdUcQJ7ps7cqUqDGnPNAPwF5hj93tLsO4UDY3mfg+?=
 =?us-ascii?Q?BXPWBC9Z62S1eyCyjnapNLLaLmDSWP41Arg/G0R33I4ivslu2fNFv99H89VA?=
 =?us-ascii?Q?sFvL7hqtuI3HPk9z9oQoU93D2KlxHKQIYyljLkBGd2lk3HI5SUULr8zAdN7A?=
 =?us-ascii?Q?xVErmziMG+BuDjrrV5EfqeRcj8HqSjqnlqpJCVztqz6V7XR3Hrdpxr734zUC?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 711a05e9-5f39-40ef-0c29-08dc38079028
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 02:47:11.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wp0ABMJOpcasBKVBeVOOhfptLXKcQBrr1FAnc2/aYcSPX+c2JSfhZQPVsectfoe4j+ak44XFyy7MK8WLESg5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/deadline.c:#pick_task_dl" on:

commit: cf9fc54f9a409f1a16798041a034d28bfc95b451 ("sched/fair: Add trivial fair server")
git://git.kernel.org/cgit/linux/kernel/git/bristot/linux dl_server_v6

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240224
with following parameters:

	test: sched



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402281042.5766096e-oliver.sang@intel.com


[  184.352299][ T4597] ------------[ cut here ]------------
[ 184.352603][ T4597] WARNING: CPU: 3 PID: 4597 at kernel/sched/deadline.c:2108 pick_task_dl (kernel/sched/deadline.c:2108 (discriminator 1)) 
[  184.352933][ T4597] Modules linked in: netconsole btrfs intel_rapl_msr blake2b_generic intel_rapl_common xor x86_pkg_temp_thermal raid6_pq intel_powerclamp zstd_compress coretemp libcrc32c kvm_intel kvm sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 irqbypass crct10dif_pclmul sg crc32_pclmul crc32c_intel ipmi_devintf ghash_clmulni_intel sha512_ssse3 ipmi_msghandler i915 rapl intel_cstate drm_buddy mxm_wmi intel_gtt firewire_ohci ahci drm_display_helper firewire_core libahci crc_itu_t intel_uncore ttm i2c_i801 libata drm_kms_helper i2c_smbus lpc_ich video wmi binfmt_misc drm loop fuse dm_mod ip_tables
[  184.354449][ T4597] CPU: 3 PID: 4597 Comm: cfs_bandwidth01 Not tainted 6.8.0-rc4-00015-gcf9fc54f9a40 #1
[  184.354767][ T4597] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
[ 184.355080][ T4597] RIP: 0010:pick_task_dl (kernel/sched/deadline.c:2108 (discriminator 1)) 
[ 184.355322][ T4597] Code: 00 00 00 49 8d bf e8 00 00 00 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 02 01 00 00 4c 89 ff 41 ff 97 e8 00 00 00 48 85 c0 75 7f <0f> 0b 4c 89 f0 4c 89 f1 48 c1 e8 03 83 e1 07 0f b6 04 28 38 c8 7f
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 49 8d             	add    %cl,-0x73(%rcx)
   5:	bf e8 00 00 00       	mov    $0xe8,%edi
   a:	48 89 f8             	mov    %rdi,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  15:	0f 85 02 01 00 00    	jne    0x11d
  1b:	4c 89 ff             	mov    %r15,%rdi
  1e:	41 ff 97 e8 00 00 00 	callq  *0xe8(%r15)
  25:	48 85 c0             	test   %rax,%rax
  28:	75 7f                	jne    0xa9
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	4c 89 f0             	mov    %r14,%rax
  2f:	4c 89 f1             	mov    %r14,%rcx
  32:	48 c1 e8 03          	shr    $0x3,%rax
  36:	83 e1 07             	and    $0x7,%ecx
  39:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax
  3d:	38 c8                	cmp    %cl,%al
  3f:	7f                   	.byte 0x7f

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	4c 89 f0             	mov    %r14,%rax
   5:	4c 89 f1             	mov    %r14,%rcx
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	83 e1 07             	and    $0x7,%ecx
   f:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax
  13:	38 c8                	cmp    %cl,%al
  15:	7f                   	.byte 0x7f
[  184.355832][ T4597] RSP: 0018:ffffc9000b42fd40 EFLAGS: 00010046
[  184.356091][ T4597] RAX: 0000000000000000 RBX: ffff8883475c2c40 RCX: 0000000000000004
[  184.356368][ T4597] RDX: 1ffff11068eb859a RSI: 0000000000000000 RDI: 0000000000000000
[  184.356644][ T4597] RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000001
[  184.356923][ T4597] R10: ffff888143ec3847 R11: 0000000000000022 R12: ffffed1068eb86ae
[  184.357214][ T4597] R13: ffffed1068eb86af R14: ffff8883475c3624 R15: ffff8883475c35d0
[  184.357481][ T4597] FS:  00007fd1a24a8740(0000) GS:ffff888347580000(0000) knlGS:0000000000000000
[  184.357784][ T4597] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  184.358024][ T4597] CR2: 00005642dfcc3548 CR3: 00000004117e8002 CR4: 00000000001706f0
[  184.358293][ T4597] Call Trace:
[  184.358476][ T4597]  <TASK>
[ 184.358676][ T4597] ? __warn (kernel/panic.c:677) 
[ 184.358896][ T4597] ? pick_task_dl (kernel/sched/deadline.c:2108 (discriminator 1)) 
[ 184.359130][ T4597] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 184.359349][ T4597] ? handle_bug (arch/x86/kernel/traps.c:238) 
[ 184.359585][ T4597] ? exc_invalid_op (arch/x86/kernel/traps.c:259 (discriminator 1)) 
[ 184.359807][ T4597] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 184.360040][ T4597] ? pick_task_dl (kernel/sched/deadline.c:2108 (discriminator 1)) 
[ 184.360268][ T4597] pick_next_task_dl (kernel/sched/deadline.c:2125) 
[ 184.360485][ T4597] __schedule (kernel/sched/core.c:6054 kernel/sched/core.c:6545 kernel/sched/core.c:6691) 
[ 184.360711][ T4597] ? io_schedule_timeout (kernel/sched/core.c:6608) 
[ 184.360930][ T4597] ? put_timespec64 (kernel/time/time.c:904) 
[ 184.361153][ T4597] ? __x64_sys_clock_gettime (kernel/time/posix-timers.c:1144 kernel/time/posix-timers.c:1132 kernel/time/posix-timers.c:1132) 
[ 184.361403][ T4597] schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6803 kernel/sched/core.c:6817) 
[ 184.361630][ T4597] syscall_exit_to_user_mode (kernel/entry/common.c:96 include/linux/entry-common.h:328 kernel/entry/common.c:201 kernel/entry/common.c:212) 
[ 184.361883][ T4597] do_syscall_64 (arch/x86/entry/common.c:102) 
[ 184.362109][ T4597] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  184.362352][ T4597] RIP: 0033:0x7fd1a25ac719
[ 184.362566][ T4597] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  184.363083][ T4597] RSP: 002b:00007ffcb3621228 EFLAGS: 00000246 ORIG_RAX: 00000000000000e4
[  184.363381][ T4597] RAX: 0000000000000000 RBX: 00007ffcb3621290 RCX: 00007fd1a25ac719
[  184.363664][ T4597] RDX: 0000000000f52567 RSI: 00005642dfcc3548 RDI: 0000000000000004
[  184.363940][ T4597] RBP: 00005642dfc8db00 R08: 00007ffcb3621290 R09: 00007ffcb3621290
[  184.364221][ T4597] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000004
[  184.364494][ T4597] R13: 00005642dfc98069 R14: 00005642dfca9cb8 R15: 0000000000000000
[  184.364775][ T4597]  </TASK>
[  184.364953][ T4597] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240228/202402281042.5766096e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


