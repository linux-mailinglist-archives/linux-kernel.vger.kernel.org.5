Return-Path: <linux-kernel+bounces-126796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD5893CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B588A28301B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698B46426;
	Mon,  1 Apr 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLGzxIfu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC74D5AA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984886; cv=fail; b=ZbYdiZBEOrvklVKEa+wWSRz7v4d/7JcQBLMIWL4nZbMkGvkNCEV5zPuAG6qTtj13BaqX7muN/knMhkZUtGo9jBVMy2QbIOCb9N680lOh/8DMJ7dmd/2zmxRpYR319cNyS60eqHy6KZoE7x4PG+4aDEFlOCUddK4FuqL1OMlV2Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984886; c=relaxed/simple;
	bh=BWhxpa0Fb/Rxz186WfX5E/xg8bI9lh/XLripPFpAk/I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Dgq1Uy0t5dpyfxavWQi1klqhkhaiZGg/tu299uEypHS8zJRm8YCylipjJLxBw4jiHjMnbr30WmqzRdeSTDXJ0Riucu8MnKmz3XiQCWUG8ekEMnN90GNIZVJ+eBl1pra3yJR/Z1cczITD8kk7SPqDBuG2pAs3sYW0l7o3O+AIvnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLGzxIfu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711984884; x=1743520884;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BWhxpa0Fb/Rxz186WfX5E/xg8bI9lh/XLripPFpAk/I=;
  b=XLGzxIfuA3TfjalkxfwHkU5Q79bJIofKGcbBkayUxLlrNw3bLYdYnlB7
   44IU038tLMBstNtB6Hu07f+/tZWvqT5eLDGGK840QkIvsHguMDTfn4QF9
   p+bZukoNtGzAsCIh4GPW0TKu4ZBFj2JX1Qjyt7r8VICi/1b49brT0ZuSd
   EXPkaRqMNKSRU22qKZdZiw7g7ulR7cgniRAlpbkr9ceP23I4uCOgGu+qo
   Vd4648V7DlCVCFiRLwI8gx+eHPFbJfzP3ntqIAIFs2b428ZU83kIi8kqT
   UcWxu2TPvBOl2Yj2C12Fe+47edfz69LVNPaNNQAeNXbYQvc2FJdJffPKU
   A==;
X-CSE-ConnectionGUID: kgLFoh90RR2tWi2JuBFEZA==
X-CSE-MsgGUID: UQOmQHNIQ3KIE+gu75ZhWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24609157"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="24609157"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 08:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17775879"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 08:21:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 08:21:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 08:21:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 08:21:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 08:21:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUEmbsohU248IAymtQ8PeDWcJBhTUvzAP1lUEfErsxusj4SYcjfz08XjAq+P25m4MPNaBnhvbEqnhdCrl8j9OBph4J6Ozx21fSOryjaAr3NVWuTetxrnqEFSTKDyssYgSCz5VXTLI2cZVxlzZSIwdhjj0nLRvQYA0rJTZ7HllXt9lAfxfHdev8br8ACV6GCb0sggwYRlnrTPvJzwhBC8L4Usnw96WahBmmH3MsASQPuQpElXkOFX2t79DWj9T49VPNXhcRhSQqGJ6cz4E5dwbuF9LUUuG7G76ZcAh2yc49WuNtsZ4GeYu1oa7VCjdBErH7a+UJSqIYzCtZxzsQHmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C14lCzWmDivtVRpsT7sNQlh7Lp3nfVR79KG0sd/sx0=;
 b=WJlJZ4MthQB42rfVXUDguF6P1q+mruPZh2w1EFA+alOgYP/8Xk3wwvEWZ2lU/R05ZlRrh13TI8+fQWjHWSL5mlQDokwtSoBHOXOiBwR5BU5CvboTzwqmOqLUAjItFirHFWVHt+U+Zqs3SxnMDxSfTGFEmkG6/ACvPdfW9L3oGE3BWAyrgI5ja7t5NRIO8RJraGz6PCVN17uX3APL+653/pmL4LxrmLKUhWCXMBAcWlngiJaSH6jiZJp4HiR+GPnvEw0RCpb0gjSgEtzbNCRuXHKxvJAjECv/CoGfu2VqbSYzm6szWw0WtLnnSqQAceYb44sds+p4FGRpyY1kXHPkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Mon, 1 Apr
 2024 15:21:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 15:21:19 +0000
Date: Mon, 1 Apr 2024 23:21:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/eevdf]  eab03c23c2:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <202404012303.41984b81-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6036:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHhuF0gpglZoi462wOH+69LmqLW37ZgU313nFst9lqx2V6F68gJd8IOzPK0WdPTkmvclx708g/rMWbCo9PzsW73ow58oyOuWg9WG+nvMuq480W9gB3rvrqlfyO4a47FpMFpEuztY9tF6PUzQN6trVqAkF6AnnDV0Y0LHjBuHdche+sXe6YWk9Uy0Gu6IctckI5cYXQU12bOzmepRW0z55LS0a6FkvytAZ8X7kNW0czk13TL/PRFZyhhtqT9AF+fxnsVc1BJF4b0CZtnJ1UCOPOZD4A//jiCW6uNm/ECr78jO+3MVnNSTut6NIMRO8C3evVT2sgTk8jiNpH7Axh+ufYKjqXcuWGP8BDs+Mz7Ytnaep8EZG9ij7NnZ03xpYtTYFvkchFBO5nM+r9qvHlAtNyn16I0B9O084I8DM1yKg9Wc5bEbIqtckvaS15Y0YyY4PoRIvlKzqd8S8tN7iRLIRym5ZmLpvyiS6xCWjibCEzMVZIl1fy2EY41un9w81ugTzKAdH+6+2PAogxUL9nPXKIX009sJWpnARBVl5p6NoUuIjkifpRu1iKntZdNGLzTkykyBUGAPoX/29jds2smjHCUota0eMBjQc5j1Xh60zgzfqepaYgg5E3ZqIybG5DTt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8FTl0xrTnlXmISCFU9AzLsYT7WwdlkWHz14aBCzblQ3ImIU1zUyAwacemMj?=
 =?us-ascii?Q?ulrs3ACuNi2Fi09EaYU8Sv4UYa6XNNhOnZU2qKAjnRN4ment1D7tOot5IPrf?=
 =?us-ascii?Q?sy29g4HKkW0dYWXaLdXxijL+PWo5jPYxi9CDKc2mULTAqWF+gk0CPw4UtzAU?=
 =?us-ascii?Q?3wXPG16+5fIQPbDV+zaREa3jFbj7BzePFm8r7Mau4zq3Xl4g+HBgjzFrtsVg?=
 =?us-ascii?Q?3xDs3MzXDJlnnZtYP69GUgOA8CWNripjSaoKJQtctaBnHJixHs7E1HMglBRz?=
 =?us-ascii?Q?ycuuR6ih77SzRaeY/y9zmYAKKuqIkQkwkJfplZTfAXT735NU4MlUhexH+D0T?=
 =?us-ascii?Q?eyt31AMnMsGFrwu2f3yXbUxYi2lPch2LLyOjCCcy/okVbsHpbUc0Vp5M3ZFL?=
 =?us-ascii?Q?JdBfT0XnUK3S2VLdNx6GA9G94dJesqif2XTqbVz5A/3/083urydTfY7GOVpl?=
 =?us-ascii?Q?mYwfjDLBIerre5tkXROzEEi94+5hWniUyGtvSO2cr2iTO8wSLQw0rrq3iBMR?=
 =?us-ascii?Q?eU/fMoeZaljbmcgDtDwMz4OIb5pv9Tkezq7RNlNEldORur6n09sJ9/GCK9zu?=
 =?us-ascii?Q?K2DQrLKPD2j2mwyQJfK4ZWzyAj2y3eLojzEgHDune0FB7OTIqKHbVPykPSjK?=
 =?us-ascii?Q?7WoRc2n8gA83SLSRcmETdW1M+0W/iXlV+nc65KZXLGlq0oktvxKwhNgxT0Wa?=
 =?us-ascii?Q?BWM0Qup0WjKbq7iBLHb9P6Lx2UJIOisk2gATB2PxRc1rWtV7KjU1xeQT/mmz?=
 =?us-ascii?Q?wtKrFljtZ4QGOEik36u4VOvcNNl8pl3AK2kGTqIqPT7kYpsE4JOJ3QVH/o1q?=
 =?us-ascii?Q?UZ60KevINSbNpNDI6lL4MJTgRepbIOTxkO62GceL7EgMNbRQrZUrxfDmT2BN?=
 =?us-ascii?Q?9vue5gim9nVKohGIWQ/Q0NjV7lDGxzspxM+IjuYnD9Runj2VzWHie+vsQ7aL?=
 =?us-ascii?Q?FuZWDDa+1m+xyv+wTPZ35LYrOJwfl8UyaZ6hxfMVjocY+ohOS7Cu0vYjFs3z?=
 =?us-ascii?Q?twc6dtJW8QUiAoAvvcyQqlZxeZtioqqKDwJ/xIrY0h6mPJnMgaJg1tEhuDz1?=
 =?us-ascii?Q?KNhiwGel0OSrlNy+J7jCTJ6B4yVUSBKtR5VrFA4eBFufQOJ0b3JKTFUYfvI7?=
 =?us-ascii?Q?Jy6/ZghfPECci3mZUBS/VGNV1WYP/yMVrNUi34tCgTGjIRCZGQthkmCHaH5F?=
 =?us-ascii?Q?6YSisGNyPB8N3KV4MfsqUwfNLp5Iwk6ptVclnOKeAmVw5WkRC/wSxJoycsCa?=
 =?us-ascii?Q?GEc0SJIAREe/TkLzFvO1kPALY1+pLXZGVjpPmL+OkPLo3kK0WTh/n6IoarnF?=
 =?us-ascii?Q?D4Wg+QzeXX+8zUot8DCQ0i/ScJAEjZ8HiUzA71xG2arww+MvXte0L5Cgco0v?=
 =?us-ascii?Q?f2crwwQuJXNk49Yg/IXfHRvXJm8t8cOesxU+uYC95uoaWICIRocWeclgFbCw?=
 =?us-ascii?Q?/TvP6jiQnfINgpnHA6WoT9dj2OGbdg5fuXew0VbJAGUJrlcFIAbn9ZoGPgRu?=
 =?us-ascii?Q?Acrq5xs9nfvSRLGATdMRtha2+JfJRnCVr/hbENWvZPtHQt2POSOBvffZF1H8?=
 =?us-ascii?Q?3P/ef5STIrHs5hPKmGNrLUN5vm2S8/FFGcYfwqVAGvZQeINUMZ7xFnVnddh8?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3777009-dd4e-42dd-6530-08dc525f61aa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:21:19.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/TNOfmyjHvDcL7VlEA3J3dXg8qawwVAZ/G4kiWycJoPgsUdjwWfDZqsgUylx1goQmMgdmG9/S7sdIcv8w6rug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: eab03c23c2a162085b13200d7942fc5a00b5ccc8 ("sched/eevdf: Fix vruntime adjustment on reweight")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 4076fa161217fcd64a578ca04586c4be728cb004]


in testcase: trinity
version:
with following parameters:

        runtime: 300s
        group: group-01
        nr_groups: 5



compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


this issue doesn't always happen, 36 times out of 308 runs as below.
but for parent, we never observed this issue.


        v6.7-rc1 eab03c23c2a162085b13200d794
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :308         12%          36:308   dmesg.WARNING:possible_circular_locking_dependency_detected




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404012303.41984b81-lkp@intel.com


[  195.727401][ T3470] WARNING: possible circular locking dependency detected
[  195.727403][ T3470] 6.7.0-rc1-00001-geab03c23c2a1 #1 Tainted: G                TN
[  195.727404][ T3470] ------------------------------------------------------
[  195.727405][ T3470] trinity-main/3470 is trying to acquire lock:
[ 195.727407][ T3470] cb267a18 (console_owner){-.-.}-{0:0}, at: console_lock_spinning_enable (kernel/printk/printk.c:1854)
[  195.727416][ T3470]
[  195.727416][ T3470] but task is already holding lock:
[ 195.727417][ T3470] da2d4350 (&rq->__lock){-.-.}-{2:2}, at: __schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:560 kernel/sched/sched.h:1349 kernel/sched/sched.h:1663 kernel/sched/core.c:6604)
[  195.727423][ T3470]
[  195.727423][ T3470] which lock already depends on the new lock.
[  195.727423][ T3470]
[  195.727424][ T3470]
[  195.727424][ T3470] the existing dependency chain (in reverse order) is:
[  195.727424][ T3470]
[  195.727424][ T3470] -> #4 (&rq->__lock){-.-.}-{2:2}:
[ 195.727428][ T3470] _raw_spin_lock_nested (kernel/locking/spinlock.c:378)
[ 195.727431][ T3470] raw_spin_rq_lock_nested (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:560)
[ 195.727433][ T3470] task_fork_fair (kernel/sched/sched.h:1581)
[ 195.727436][ T3470] sched_cgroup_fork (kernel/sched/core.c:?)
[ 195.727438][ T3470] copy_process (include/linux/timekeeping.h:154 kernel/fork.c:2619)
[ 195.727441][ T3470] kernel_clone (kernel/fork.c:2907)
[ 195.727443][ T3470] user_mode_thread (kernel/fork.c:2985)
[ 195.727445][ T3470] rest_init (init/main.c:695)
[ 195.727447][ T3470] start_kernel (init/main.c:875)
[ 195.727452][ T3470] start_kernel (init/main.c:1072)
[ 195.727454][ T3470] i386_start_kernel (arch/x86/kernel/head32.c:79)
[ 195.727457][ T3470] startup_32_smp (arch/x86/kernel/head_32.S:295)
[  195.727459][ T3470]
[  195.727459][ T3470] -> #3 (&p->pi_lock){-.-.}-{2:2}:
[ 195.727461][ T3470] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162)
[ 195.727464][ T3470] try_to_wake_up (kernel/sched/core.c:2232)
[ 195.727466][ T3470] default_wake_function (kernel/sched/core.c:7020)
[ 195.727469][ T3470] woken_wake_function (kernel/sched/wait.c:444)
[ 195.727472][ T3470] __wake_up_common_lock (kernel/sched/wait.c:89)
[ 195.727474][ T3470] __wake_up (kernel/sched/wait.c:127)
[ 195.727476][ T3470] tty_wakeup (drivers/tty/tty_io.c:527)
[ 195.727478][ T3470] tty_port_default_wakeup (drivers/tty/tty_port.c:70)
[ 195.727482][ T3470] tty_port_tty_wakeup (drivers/tty/tty_port.c:434)
[ 195.727484][ T3470] uart_write_wakeup (drivers/tty/serial/serial_core.c:121)
[ 195.727486][ T3470] serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1842)
[ 195.727490][ T3470] serial8250_handle_irq (include/linux/spinlock.h:406 include/linux/serial_core.h:667 include/linux/serial_core.h:1085 drivers/tty/serial/8250/8250_port.c:1947)
[ 195.727492][ T3470] serial8250_default_handle_irq (drivers/tty/serial/8250/8250_port.c:1962)
[ 195.727495][ T3470] serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:127)
[ 195.727498][ T3470] __handle_irq_event_percpu (kernel/irq/handle.c:158)
[ 195.727500][ T3470] handle_irq_event (kernel/irq/handle.c:193 kernel/irq/handle.c:210)
[ 195.727503][ T3470] handle_edge_irq (kernel/irq/chip.c:833)
[ 195.727505][ T3470] __handle_irq (arch/x86/kernel/irq_32.c:97)
[ 195.727508][ T3470] __common_interrupt (include/asm-generic/irq_regs.h:28 arch/x86/kernel/irq.c:270)
[ 195.727510][ T3470] common_interrupt (arch/x86/kernel/irq.c:247)
[ 195.727512][ T3470] asm_common_interrupt (arch/x86/entry/entry_32.S:636)
[ 195.727515][ T3470] _raw_spin_unlock_irqrestore (kernel/locking/spinlock.c:195)
[ 195.727517][ T3470] __create_object (mm/kmemleak.c:753)
[ 195.727521][ T3470] kmemleak_alloc (mm/kmemleak.c:761 mm/kmemleak.c:1033)
[ 195.727523][ T3470] slab_post_alloc_hook (include/linux/kmemleak.h:42)
[ 195.727527][ T3470] kmem_cache_alloc_bulk (mm/slub.c:4056)
[ 195.727529][ T3470] mas_alloc_nodes (lib/maple_tree.c:165 lib/maple_tree.c:1287)
[ 195.727532][ T3470] mas_expected_entries (lib/maple_tree.c:5633)
[ 195.727534][ T3470] copy_mm (include/linux/mm.h:994 kernel/fork.c:681 kernel/fork.c:1691 kernel/fork.c:1740)
[ 195.727536][ T3470] copy_process (kernel/fork.c:?)
[ 195.727538][ T3470] kernel_clone (kernel/fork.c:2907)
[ 195.727540][ T3470] __ia32_sys_clone (kernel/fork.c:3018)
[ 195.727542][ T3470] do_int80_syscall_32 (arch/x86/entry/common.c:164)
[ 195.727544][ T3470] restore_all_switch_stack (arch/x86/entry/entry_32.S:947)
[  195.727547][ T3470]
[  195.727547][ T3470] -> #2 (&tty->write_wait){-.-.}-{2:2}:
[ 195.727550][ T3470] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162)
[ 195.727552][ T3470] __wake_up_common_lock (kernel/sched/wait.c:?)
[ 195.727554][ T3470] __wake_up (kernel/sched/wait.c:127)
[ 195.727556][ T3470] tty_wakeup (drivers/tty/tty_io.c:527)
[ 195.727558][ T3470] tty_port_default_wakeup (drivers/tty/tty_port.c:70)
[ 195.727560][ T3470] tty_port_tty_wakeup (drivers/tty/tty_port.c:434)
[ 195.727563][ T3470] uart_write_wakeup (drivers/tty/serial/serial_core.c:121)
[ 195.727564][ T3470] serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1842)
[ 195.727567][ T3470] serial8250_handle_irq (include/linux/spinlock.h:406 include/linux/serial_core.h:667 include/linux/serial_core.h:1085 drivers/tty/serial/8250/8250_port.c:1947)
[ 195.727569][ T3470] serial8250_default_handle_irq (drivers/tty/serial/8250/8250_port.c:1962)
[ 195.727572][ T3470] serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:127)
[ 195.727574][ T3470] __handle_irq_event_percpu (kernel/irq/handle.c:158)
[ 195.727577][ T3470] handle_irq_event (kernel/irq/handle.c:193 kernel/irq/handle.c:210)
[ 195.727579][ T3470] handle_edge_irq (kernel/irq/chip.c:833)
[ 195.727581][ T3470] __handle_irq (arch/x86/kernel/irq_32.c:97)
[ 195.727583][ T3470] __common_interrupt (include/asm-generic/irq_regs.h:28 arch/x86/kernel/irq.c:270)
[ 195.727585][ T3470] common_interrupt (arch/x86/kernel/irq.c:247)
[ 195.727586][ T3470] asm_common_interrupt (arch/x86/entry/entry_32.S:636)
[ 195.727588][ T3470] _raw_spin_unlock_irqrestore (kernel/locking/spinlock.c:195)
[ 195.727590][ T3470] uart_write (drivers/tty/serial/serial_core.c:74 drivers/tty/serial/serial_core.c:617)
[ 195.727592][ T3470] n_tty_write (drivers/tty/n_tty.c:574 drivers/tty/n_tty.c:2379)
[ 195.727594][ T3470] file_tty_write (drivers/tty/tty_io.c:1021)
[ 195.727596][ T3470] redirected_tty_write (drivers/tty/tty_io.c:1113 drivers/tty/tty_io.c:1136)
[ 195.727598][ T3470] vfs_write (fs/read_write.c:492)
[ 195.727600][ T3470] ksys_write (fs/read_write.c:637)
[ 195.727602][ T3470] __ia32_sys_write (fs/read_write.c:646)
[ 195.727604][ T3470] do_int80_syscall_32 (arch/x86/entry/common.c:164)
[ 195.727606][ T3470] restore_all_switch_stack (arch/x86/entry/entry_32.S:947)
[  195.727608][ T3470]
[  195.727608][ T3470] -> #1 (&port_lock_key){-.-.}-{2:2}:
[ 195.727611][ T3470] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162)
[ 195.727613][ T3470] serial8250_console_write (include/linux/serial_core.h:? drivers/tty/serial/8250/8250_port.c:3403)
[ 195.727615][ T3470] univ8250_console_write (drivers/tty/serial/8250/8250_core.c:601)
[ 195.727618][ T3470] console_flush_all (kernel/printk/printk.c:2905)
[ 195.727620][ T3470] console_unlock (kernel/printk/printk.c:3036)
[ 195.727622][ T3470] vprintk_emit (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:2304)
[ 195.727623][ T3470] vprintk_default (kernel/printk/printk.c:2318)
[ 195.727625][ T3470] vprintk (kernel/printk/printk_safe.c:?)
[ 195.727627][ T3470] _printk (kernel/printk/printk.c:2328)
[ 195.727630][ T3470] register_console (kernel/printk/printk.c:3542)
[ 195.727632][ T3470] univ8250_console_init (drivers/tty/serial/8250/8250_core.c:?)
[ 195.727635][ T3470] console_init (include/linux/jump_label.h:270 include/trace/events/initcall.h:48 kernel/printk/printk.c:3689)
[ 195.727637][ T3470] start_kernel (init/main.c:1009)
[ 195.727640][ T3470] i386_start_kernel (arch/x86/kernel/head32.c:79)
[ 195.727642][ T3470] startup_32_smp (arch/x86/kernel/head_32.S:295)
[  195.727644][ T3470]
[  195.727644][ T3470] -> #0 (console_owner){-.-.}-{0:0}:
[ 195.727646][ T3470] __lock_acquire (kernel/locking/lockdep.c:?)
[ 195.727649][ T3470] lock_acquire (kernel/locking/lockdep.c:5753)
[ 195.727651][ T3470] console_lock_spinning_enable (kernel/printk/printk.c:1854)
[ 195.727653][ T3470] console_flush_all (kernel/printk/printk.c:2901)
[ 195.727655][ T3470] console_unlock (kernel/printk/printk.c:3036)
[ 195.727657][ T3470] vprintk_emit (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:2304)
[ 195.727658][ T3470] vprintk_default (kernel/printk/printk.c:2318)
[ 195.727660][ T3470] vprintk (kernel/printk/printk_safe.c:?)
[ 195.727662][ T3470] _printk (kernel/printk/printk.c:2328)
[ 195.727665][ T3470] pick_eevdf (kernel/sched/fair.c:961)
[ 195.727667][ T3470] pick_next_task_fair (kernel/sched/sched.h:1417 kernel/sched/fair.c:8377)
[ 195.727669][ T3470] __schedule (kernel/sched/core.c:5998)
[ 195.727672][ T3470] schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6764 kernel/sched/core.c:6778)
[ 195.727674][ T3470] schedule_hrtimeout_range_clock (kernel/time/hrtimer.c:?)
[ 195.727676][ T3470] schedule_hrtimeout_range (kernel/time/hrtimer.c:2364)
[ 195.727678][ T3470] do_sigtimedwait (kernel/signal.c:3653)
[ 195.727680][ T3470] __ia32_sys_rt_sigtimedwait_time32 (kernel/signal.c:3729)
[ 195.727683][ T3470] __do_fast_syscall_32 (arch/x86/entry/common.c:164)
[ 195.727685][ T3470] do_fast_syscall_32 (arch/x86/entry/common.c:255)
[ 195.727686][ T3470] do_SYSENTER_32 (arch/x86/entry/common.c:293)
[ 195.727688][ T3470] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840)
[  195.727690][ T3470]
[  195.727690][ T3470] other info that might help us debug this:
[  195.727690][ T3470]
[  195.727691][ T3470] Chain exists of:
[  195.727691][ T3470]   console_owner --> &p->pi_lock --> &rq->__lock
[  195.727691][ T3470]
[  195.727695][ T3470]  Possible unsafe locking scenario:
[  195.727695][ T3470]
[  195.727695][ T3470]        CPU0                    CPU1
[  195.727696][ T3470]        ----                    ----
[  195.727696][ T3470]   lock(&rq->__lock);
[  195.727698][ T3470]                                lock(&p->pi_lock);
[  195.727699][ T3470]                                lock(&rq->__lock);
[  195.727701][ T3470]   lock(console_owner);
[  195.727702][ T3470]
[  195.727702][ T3470]  *** DEADLOCK ***
[  195.727702][ T3470]
[  195.727703][ T3470] 3 locks held by trinity-main/3470:


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240401/202404012303.41984b81-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


