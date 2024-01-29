Return-Path: <linux-kernel+bounces-42109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F883FC66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C321C20B56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892B1F9E0;
	Mon, 29 Jan 2024 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBGLeDGT"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5DF9D6;
	Mon, 29 Jan 2024 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497153; cv=fail; b=QuqYjxPSvJxjexEqBk9D9IPriAPHHGpIL1F9LQz1o8GE7yN7u/kZbzlXs2GRUDnTC1glR4Poe3+QkamB5tvKJRediB4rkmgnDkI2CTT21vlq7J74F1j4aY7QarlEb+Nr+CosUKE/27t/k9U6VNhZz+GAIrcOSyXXyi0gYRUccP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497153; c=relaxed/simple;
	bh=WqfS8AmgLhQkTj2wCU8H8SsD6Pd9Twg57YOqFrDbqv4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WFNgjOilsD8E1leYLUU91YAS/ZUmQFVinnNJK5xB7sCRx8JpMb6j05WN6JhhNIHSowrFk5qp+re4O0cwdLLJsxpyEA+GbpaHgGomJadLZ2CIGSrNV7p6PbVQ5kkznBRbujL/jjyBHkE7wJbBecyShqJwy1/+U/EVbY3pfCoAW3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBGLeDGT; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706497151; x=1738033151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WqfS8AmgLhQkTj2wCU8H8SsD6Pd9Twg57YOqFrDbqv4=;
  b=MBGLeDGTP/v14X47JkToNtHdZ7LuCi3BuXQfuFGWescreAxUr5UfdT9I
   L75GntZdRwseIZwxHAa3C/qKTLpropuFxN/jmzUhGST6nP+FQtkNU9uhq
   nmZWUwSWcaAewmumRJtY25RWHbzNFE0MDE/XoXJIcVXRwlXUkeKvb6L8J
   IWbFnXFI64LPnGzLOuBa384BjulvIFzAl3t6poDRD+jv0KFlmpSiWfdfT
   2mLy1xeF0homhu1mzq9WbyXCL/VhV/fcCn/md6dlmnjLMuxV/Sp1Y81ya
   hOEOcm/PxP2X2Rks8cHvFFomCQfGMXaiwnnOr56s8qogSdgBUCycJgXki
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406559606"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406559606"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 18:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="787690924"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="787690924"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 18:59:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 18:59:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 18:59:08 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 18:59:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtK9eV/58y1spw9mMcCNsq31SD3rjZjRqZt2/ibCkXRK4fy/AZfVFE093bolR4VcqeE7yanAAe9RQNcobpzkDx0LGxO5/abZEDAk8NSvl3a5gF8yWYachxi5Nt4D0T0/Xuxm5Mnuc1ajJC9pQwKzun5Qf6Gd2Jn9R1Ihb05Czq75VKAWcxCTrOo3VTOJivD1aCB/w4Fe/xHXSJ5doOH0uxCsfLuYo6qsqfqwZVLioDPeg702e9X5hgg46XWfMk+dUCJ1hxNJg43MhUpUCFWkVF2Hhc1V/ErRixLTksFTMsyr1nH4hwcRAxDxKAdifVYhHlryTMe67lGmHwYtEPXCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7ojX+8nn1DQABbMFQb9zOFhfebua5jUH8VhTtDgJi0=;
 b=jhzbyhi7BAP9jgt4QzdGDN7tuqkxGtc4FnltSRqDJTOdf3T+vLZX29RQ0EtM1rubLUGARDS6kh3hNan2u5cT/fg5ure0KmEJOn4dff2/CtsTKZ6S1EmdL2h2yuoUJcLACa3h2smGwLSvGPgtbeC0cT3MJWuMV+0ilszI8kIRbbPWTrKu42Jcl3ILyBwnY4XDvWrNKlyEyAfBxBcMJNqA/1sot3VamBK3JhnXyJA8UlQMyw9Yy1vFsiNX4rzGEuAd82k9MvwN2dfAiYWz5tCUlpgF0/yV+/nKpYwE6x+Ji5EKrBtYbrHqgmRmP0Lfua6yVUJzxpb5siyGAQRx4RkAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6952.namprd11.prod.outlook.com (2603:10b6:510:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 02:59:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:59:05 +0000
Date: Mon, 29 Jan 2024 10:58:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, "Al
 Viro" <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>,
	"kernel test robot" <oliver.sang@intel.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: [linus:master] [eventfs]  852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202401291043.e62e89dc-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 888c829c-92e4-43b6-90e8-08dc2076414b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVjE3rhxhzhHCXVJRqtZWJBThx6weO/AB5NqhDv4oZE7gjTeF8Tmi9ppjcQxxnUYQTkFxB06aPU6bEzgzkGRAKI4iCLcKdGDABS+O1oQvVaYHTK+EPfE4+jlKEEKqgeZ/6hTGB1UUIbWT5b+fOfLlYzO9b8FwvJ1Hz1BHegGIO9fS24pyY1C4xJvScVP9BFOGPuIHPlQjflW8nyVcJdvtbFdCSvA3W80eEI6R7c+uL0E+48NSqrPuf6gtu29fsPvsHKKzk4LA9sAFTczD6RAEFDNEzNUd0eK8lZyZrxF1531mfT565HF3+KkuKhKekQmQlFfk8Em0N/UigAX3r01nxyFZXOtNVXerOnjqykhLJYQY+XgwLIUSpreksWu2iKUEBDo1O7XdWFvD3cw7jQP9WA57FJ1+MDjv1YK82pzESNeXbs8OdPcBJjABE2wmOO9wkHMGb4ID4ri97p4oxdQ8vV8/uwnLj+XXX6Iu0q/dAzDp+BJY4KCjqVm7IhliqF+VhzofYNL3X0jG6W0djVP6He1lweMmshTLZvElyiK2Jk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6512007)(26005)(1076003)(2616005)(6506007)(7416002)(5660300002)(4326008)(41300700001)(2906002)(6486002)(6666004)(966005)(478600001)(316002)(54906003)(8676002)(8936002)(6916009)(66476007)(66556008)(66946007)(36756003)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6EnURqEuarreUSJXovrYuchJaL7wbZBxdOz7ON2gqT9eComPStfD0pAb7NT8?=
 =?us-ascii?Q?0G7fPqWv6NC1nfe+1bKyN9q6fg7xllyIrLOGwLXlTLKmAQktTZ1Q7UuPbUJ9?=
 =?us-ascii?Q?M63W5MVqyF8aEacIUsUsaWwSz13KWc69bBYbvKn56ztFyTpV3D/EAPuzImpJ?=
 =?us-ascii?Q?Te9Q8IHH3Nco+BVKY/ERiPOqvC5Gn3We27zGI6jjfB/j0jDmLmBviy7+PJoP?=
 =?us-ascii?Q?XBK7s71rLTEuEfMFqHDsv1QUnkCeE0PuG2I6bQ0vEH9c77zuHNcQljByvu0c?=
 =?us-ascii?Q?TYUJAGYzDQ7O7ORBjpg6CkdhCLiTr3bBq6CfnmaDvkW7XCT1zhqYvEUAP4yz?=
 =?us-ascii?Q?Q/++ZNFeay0yefboAk8bVWLLuW1Tdsvr0yMBKUSME+ESdmiSk8rL/zzNs9wy?=
 =?us-ascii?Q?e5fWoTiQ94Fudkzs0+W+iSbXhoSNQ9Qh6ghR1T11ac8hG+siPgHSLh9rnWzg?=
 =?us-ascii?Q?lafPnDwuRoFH/EJ4g1ZtiohsmoC8UygWbKdMMXarAqxacpuPEYwzI7zci/tY?=
 =?us-ascii?Q?yLGA6XM7fxS82V9iWozmuXtAdP7ID2XjsmmHoTDNN/UumUy504Ta5Epg4mid?=
 =?us-ascii?Q?MgP9r/4xgXEYljNSm1v7i4YF/bEwqRtbjLyH4+EFcwNCqYj2jOz+gpzVf+oo?=
 =?us-ascii?Q?35HoB7JjpXubfoNBlhQqx0c9AcoJp7+iiCzu3io1T/NecTL83zTxBwGDzmYr?=
 =?us-ascii?Q?VrO91W7vnC0Ns33BSrOUs6+cmulTCcHMft5QE9LAqJFxdG9dBVR/UuXZhrpz?=
 =?us-ascii?Q?SFl0BrA3v2mmYBQCo+3X4JTQypkweqr2/AR8ClA2V7eMHdW2KFbZ0rPD95Ni?=
 =?us-ascii?Q?3/zh1KNNAf2ptLamp7PCfxT2YeVE4jmEo6CIWixASZFn8UZ76LwCgtoqb7fY?=
 =?us-ascii?Q?+M6cahXPE+VI592l30Ob1QeaDa2r9xflZZLtRkPIDkLla+RFHI/+azWEatLI?=
 =?us-ascii?Q?uHPRkKwvLZoTkNazK96gpMjNCgdKIkXd3v/8NVfacZbrpIm2xagmctgClFYq?=
 =?us-ascii?Q?k8DmFwvJKLrgwJ+NEuTOR0VJ3aRhE2sB/5RJMAr8GNatdCL7/cKQST3yvOve?=
 =?us-ascii?Q?mguxZlLKZSBbsQDE/Iz1H330RZE8cdlEGwK7x3X/L1XyOJ5nCDimH1jWrjmv?=
 =?us-ascii?Q?yUPFAM8fWFViqRiXTyejn9MdIdh0nk2fz/98QZ6NXonbZtWNrv51O7yYXk0I?=
 =?us-ascii?Q?cpPI11ayA25CQbJeqwbFUGLLXHLjNC/dbriM2K2ojpMzBS1gIDh4ag1dwghv?=
 =?us-ascii?Q?yAk7V78BS/EhnLzAylg2ezPK1fd9W4cXki4kjSrUKEF0UBXSBxgTTY5cjBOZ?=
 =?us-ascii?Q?Y15u80WPUSeh7LkDt/PJKDGCBdsej7ClgxAy5O7bNVYgt7YIQFvolHy2Uz8v?=
 =?us-ascii?Q?nnsekJFuZW+RwFTVTE9ULuB63kUTOJihaVV1OD24NL6KXU6LPeI+TXJ1QhZg?=
 =?us-ascii?Q?78HvWC8Wu1x6KcXwiCor7X7MMfjSN7lu8TJlF7GILZ0p51GKnbImxM0drNdm?=
 =?us-ascii?Q?Mhm3/mJk+6emZWF0WcqlX4/etr80nOfUeudMtWnprOZ+WVi40N9MqUSv1y/0?=
 =?us-ascii?Q?iwF/5grq8YyQwanfbTws9TUsi62kGU1XONqsAYsH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 888c829c-92e4-43b6-90e8-08dc2076414b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:59:05.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wi6q3dwQ1IPY6+pvohzge9rqSn218g7TE1h4pWk9cCknlnCKZJ8VkUDy/Tx1OXxCKsUCT/Huot/mmP4K4cZGpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6952
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: 852e46e239ee6db3cd220614cf8bce96e79227c2 ("eventfs: Do not create dentries nor inodes in iterate_shared")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf]
[test failed on linux-next/master 774551425799cb5bbac94e1768fd69eec4f78dd4]

in testcase: stress-ng
version: stress-ng-x86_64-1744999cb-1_20240112
with following parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: xfs
	class: filesystem
	test: getdent
	cpufreq_governor: performance



compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401291043.e62e89dc-oliver.sang@intel.com


[   52.318955][ T4398] BUG: unable to handle page fault for address: 0000042c000004db
[   52.326780][ T4398] #PF: supervisor read access in kernel mode
[   52.332830][ T4398] #PF: error_code(0x0000) - not-present page
[   52.338864][ T4398] PGD 186970067 P4D 0
[   52.342993][ T4398] Oops: 0000 [#1] SMP NOPTI
[   52.347552][ T4398] CPU: 32 PID: 4398 Comm: stress-ng-getde Not tainted 6.7.0-rc2-00049-g852e46e239ee #1
[   52.357235][ T4398] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[ 52.365278][ T4398] RIP: 0010:set_top_events_ownership (fs/tracefs/event_inode.c:172 (discriminator 1)) 
[ 52.371424][ T4398] Code: 00 00 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8b 47 f8 48 85 c0 74 11 <f6> 40 78 02 74 0b 8b 50 50 f7 c2 00 00 08 00 75 05 c3 cc cc cc cc
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  21:	48 8b 47 f8          	mov    -0x8(%rdi),%rax
  25:	48 85 c0             	test   %rax,%rax
  28:	74 11                	je     0x3b
  2a:*	f6 40 78 02          	testb  $0x2,0x78(%rax)		<-- trapping instruction
  2e:	74 0b                	je     0x3b
  30:	8b 50 50             	mov    0x50(%rax),%edx
  33:	f7 c2 00 00 08 00    	test   $0x80000,%edx
  39:	75 05                	jne    0x40
  3b:	c3                   	retq   
  3c:	cc                   	int3   
  3d:	cc                   	int3   
  3e:	cc                   	int3   
  3f:	cc                   	int3   

Code starting with the faulting instruction
===========================================
   0:	f6 40 78 02          	testb  $0x2,0x78(%rax)
   4:	74 0b                	je     0x11
   6:	8b 50 50             	mov    0x50(%rax),%edx
   9:	f7 c2 00 00 08 00    	test   $0x80000,%edx
   f:	75 05                	jne    0x16
  11:	c3                   	retq   
  12:	cc                   	int3   
  13:	cc                   	int3   
  14:	cc                   	int3   
  15:	cc                   	int3   
[   52.391324][ T4398] RSP: 0018:ffa000000f2efc90 EFLAGS: 00010206
[   52.397481][ T4398] RAX: 0000042c00000463 RBX: ff110002452ae2c8 RCX: 0000000000004000
[   52.405547][ T4398] RDX: 0000000000000024 RSI: ff110002452ae2c8 RDI: ff110002452ae2c8
[   52.413616][ T4398] RBP: ffffffff83080320 R08: 0000000000000064 R09: ff1100018a25dd40
[   52.421686][ T4398] R10: ffffffffffff8c98 R11: 0000000000000000 R12: 0000000000000024
[   52.429755][ T4398] R13: ffffffff83080320 R14: ffa000000f2efedc R15: 0000000000018000
[   52.437828][ T4398] FS:  00007f3b60e3d740(0000) GS:ff11001fffe00000(0000) knlGS:0000000000000000
[   52.446854][ T4398] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.453547][ T4398] CR2: 0000042c000004db CR3: 0000000113750004 CR4: 0000000000771ef0
[   52.461629][ T4398] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   52.469707][ T4398] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   52.477783][ T4398] PKRU: 55555554
[   52.481444][ T4398] Call Trace:
[   52.484848][ T4398]  <TASK>
[ 52.487894][ T4398] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 52.491898][ T4398] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 52.496854][ T4398] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 52.501725][ T4398] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[ 52.506858][ T4398] ? set_top_events_ownership (fs/tracefs/event_inode.c:172 (discriminator 1)) 
[ 52.512425][ T4398] eventfs_permission (fs/tracefs/event_inode.c:203) 
[ 52.517390][ T4398] inode_permission (fs/namei.c:462 fs/namei.c:529 fs/namei.c:504) 
[ 52.522271][ T4398] may_open (fs/namei.c:3250) 
[ 52.526453][ T4398] do_open (fs/namei.c:3621) 
[ 52.530540][ T4398] ? open_last_lookups (fs/namei.c:3569) 
[ 52.535670][ T4398] path_openat (fs/namei.c:3780) 
[ 52.540187][ T4398] do_filp_open (fs/namei.c:3809) 
[ 52.544696][ T4398] do_sys_openat2 (fs/open.c:1440) 
[ 52.549285][ T4398] __x64_sys_openat (fs/open.c:1466) 
[ 52.554044][ T4398] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
[ 52.558541][ T4398] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   52.564509][ T4398] RIP: 0033:0x7f3b60fcb127
[ 52.568991][ T4398] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
All code
========
   0:	25 00 00 41 00       	and    $0x410000,%eax
   5:	3d 00 00 41 00       	cmp    $0x410000,%eax
   a:	74 47                	je     0x53
   c:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  13:	00 
  14:	85 c0                	test   %eax,%eax
  16:	75 6b                	jne    0x83
  18:	44 89 e2             	mov    %r12d,%edx
  1b:	48 89 ee             	mov    %rbp,%rsi
  1e:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
  23:	b8 01 01 00 00       	mov    $0x101,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	0f 87 95 00 00 00    	ja     0xcb
  36:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  3b:	64                   	fs
  3c:	48                   	rex.W
  3d:	2b                   	.byte 0x2b
  3e:	0c 25                	or     $0x25,%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	0f 87 95 00 00 00    	ja     0xa1
   c:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  11:	64                   	fs
  12:	48                   	rex.W
  13:	2b                   	.byte 0x2b
  14:	0c 25                	or     $0x25,%al


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240129/202401291043.e62e89dc-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


