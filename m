Return-Path: <linux-kernel+bounces-116719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09BC88A2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39D21C395D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE6E6EB58;
	Mon, 25 Mar 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmHqle2M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBC130E44
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356609; cv=fail; b=S/dB+GkR83z3XRHc39mDbI59iuQaWDRNd9tqtevM8kpLIBLURYSBfoLUelZnprdbqvXUBbH5Y6nVxRx/63K+TfYpdDNn9TjvRBrksDcFd7LSRDgMn2awKCbJm2GJBLQAY2LRVktPtG+ns/sAkoXMnXJlE9bZaIFUPfTxfHgFp+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356609; c=relaxed/simple;
	bh=dojXUC0bUAvUJNhMvTvlfMlgcYlmXveb6rKoins3aXY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Y3AVCcQg8i4U64j3Zyzmat6Q7xQp/gfaDfc0q1VzgsYieNLj3GIAmVwssN7Uz0Sr6MFfTVLPu7Tt+lIUqcuYvTVwD/nQ2DEo66OCOIkPiFo/Ta/vTkN6ZIFQRr8uQ3EexRu/+JANCSsHqJsOEVQetUYf3gS/ggZLJaYrbRMUEGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmHqle2M; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711356606; x=1742892606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dojXUC0bUAvUJNhMvTvlfMlgcYlmXveb6rKoins3aXY=;
  b=jmHqle2MUIk+SfMia4gYMPV7WQHa9rpzESJ4g5lm/9P2GU+ycbrcbr5+
   7LEx8bWadoa6MmQCE+EdCEqe2pWLGlf8LeXxECVW6wy/+4X/Sj0CE5ZlU
   ovp+2t+kV9l21VUjwe1eMUJ4teHApmk/2gaBUsDXXe29bMsGMG/DML65v
   lM1jWF9aNt/0/VVMVhPd9AqjWOXeciChSUesg9eHcz7kLmedX3mfT8hO7
   SwwzAI/p8Nw86EmwTq3FQ9og3rudMF8YFMIz6oAF+e+YQcSsw68z/k54r
   pg5Z1U/gg7Z3DJ5/+Omx7penW5vLeCXGMcRyN3wjuH6AIqpVu04+9DG8/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10139898"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10139898"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 01:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="20288117"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 01:50:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 01:50:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 01:50:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 01:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/wNpZoWyqG18mOEuqLi9gwW7iPCf4g6OAk1uABRahtKUtd+ncsoiKapmGzFBI10QWcMnCkbZRQrg0/IHYGDIQrSc3ygIJbLlLzabMJJCTODMmgAqsWsmv5msrpbEmYt1cRhNT5wca7rPIhyqC6Kj7DhJMGQBqqmd9QKYXmwZreN7nOzCeib45UEZROtM+3KD9MLZx7iLOL0j5GNCRTfcL/sKLEtmDjbqGVKBy1FkvVULg3NXkqC+gmYFv8sOFm1PZwsOCwAdzqPINo7OznkCXUNJIdWoWQ22EY9OfepcZqKVuYuZQZa0K8CSxg2ALhrS5gVf+NHb5UPdTsSYsRvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXt5GEgUmW1/zAXD9l245inpyxXc7BEYFnBJLPyENxg=;
 b=YPLDfJWaCN7vLneCTVIzXH3Sq+cHkCBXn0deCJlqFfJgS9uCxXwYHy0URqUOqNHBZnoWnUyRPdSrzwPIh92g2Y6VrumDEyMeSP8CLedY/QfVw5fyXCixOfQrQ+GTCr2YWfhkV5juLEEmuW7bBBfYHYjEPBwBjhGzYuaSib5HeXZDrZ5sIzzAlynYeATHrnDbTgQL/ULJyzRVXiSxR1SQqI5f0fJtduo4PtXUY10trWjcZ3wH0lmDSZXq3lJ+JaAozBGOVXb9/H658ytfcsKLyjDlAapnzE9MP6L0usADIPUNQsXPTBcgCTKnfB6xFKCjNbMEikgdgn1CWzqrn+bijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 08:50:00 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::2dd3:6f51:bc3e:2d4a]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::2dd3:6f51:bc3e:2d4a%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 08:50:00 +0000
Date: Mon, 25 Mar 2024 16:49:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>, "Andy
 Lutomirski" <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys
 Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf
	<jpoimboe@redhat.com>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [x86/percpu]  ca42563486:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202403251658.8e92a8bc-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|MW4PR11MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: bf95fd0e-c91a-4195-738c-08dc4ca88df3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njij7XB+BVCKSf3Xd0AtD90pfd+VTzp1YdkX0iwVOVuGRRlTb+D5qfRyDIc8zn/6bTtQyjccFQ6XXdg9a6+vsRQ8C3mNRILVfuGac/NXerK38va1p4ImJdLHXry8zZZDkJ1dHFjJrsTa/S7tr0LlO8rJpqP/4R6PsGbVAiV37rgBliS9zTkifvrbMmSvRx411Qiv9yz85o9FNVkKIzNK1JxOGFNvDrakfU/c5JfjaNDbWheIVeOAsw91GZYAZwJ0U1L52rl9wmdkS87Zd5jRSyIxnHkIqe3X7aCJSYm5lmbcaHrMn9T4UztLs0vKEX+CrVhPHz+Cww8u24Wt3LSr6Nh2xeXUykHqAlArVHZKi1dFqKair0wvQQMk1dtCAhnRHM1RqS1wfGDm4guUDFA+Qdu0Cys/bQ3zyC/SUePvzqq75ZFLdS1BZ4IzHz6Xo7krBNc5hikpeETPf7ckrxS0DxKFCesf9kOaZZ7fzDKMmcaqQn2kPP2+lwwinDauzw9FrUP/GlTrU3d3OPUwCCZPAra5P+HWS8hZie5IhdwyzXM3JygG2kPqLlKNexGHVGt3/dgwgpPuiA2pbHqGJ8ax308UZr1TTaWPntGpNHehOnIbV7AiHa8MQqGzh9CK+brR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0RSjx0MIQ4csWem9/t9i04eS00Ty8a5vTIvAwjUh3CFH3ZVpgwshsvZPMId7?=
 =?us-ascii?Q?sxJkYWqkdZLgneOoqRwpJdoTdp/ZYtp49oK50amR3E7NdG3Y/yzyS7ZpZo95?=
 =?us-ascii?Q?89BgyRfeIFo1HYO/vh9C/tZHzTHgRHtunjppMyZBMwQOnurhB5rKniBCmWQ6?=
 =?us-ascii?Q?+Yob2drMW6jH0kT1ybBgmmAuZ3SeBV9MEek+AHR6KuBndTH0x/WW2WYr+XPT?=
 =?us-ascii?Q?Wpsxy1KGCkaUA6Rrz5RRvB7m8hcLclOoVwum+vQ16978oAPu/k4g2PA8AXeG?=
 =?us-ascii?Q?6StEibHHV9Nkq4SDt/1NxSM4kVAQJSF9C1D06GtmjPFo4r6bC9iW2J1ntKTS?=
 =?us-ascii?Q?TBX/OTc47Ebr5INqNmXVGE4lvJOWdHFYZ+XyNBsw5eohdGpo/ARpHChNe0i1?=
 =?us-ascii?Q?U6DAEXm05Fa9UxKR0sp0wXWeVoXDEWUQ8/Lt1FfgiZrhSCMIeE2afILUOnkj?=
 =?us-ascii?Q?i8f4dkWuu9rZ769i3ul9W0Le5W0A8No3tO8OtlFSPSxPT7T+H40gECQsNYAg?=
 =?us-ascii?Q?MZFLFeOxSGJeTyPtIAVGg1x9EnskcwDwIxw8X+vYdgKiyNvg8nXOBTuafuxA?=
 =?us-ascii?Q?C6Chw2Av724fcO788+avChhrwNy5A18SBRwtruPGjH1Cj2AUNjyyVWkTIeR0?=
 =?us-ascii?Q?o4KEkz6L4Z1xy75jxxmS/6FRrMmjkQi1/j2YqAX4hTGEGiZJWckZHqL5nA5d?=
 =?us-ascii?Q?G/7ZX5QPE12MVQo3FunvhdGyKuRcTpSAG2uGkNCZRDUduxMwl81l9Ttb01SE?=
 =?us-ascii?Q?667WlRWhftv/Grouaf8D9FswQnSSqrChVjXL6R/vMrOjEjbWtnfGz/ibpwYd?=
 =?us-ascii?Q?Xoqm45jadFZ3/c7KdEtR8mmt0XJbsUklQNbJRXSNZvFS/ynhajOFt9w7uAsa?=
 =?us-ascii?Q?8UQd3xPFlGhUe/JkHKfC6gL1CPNeQ8BeItTvJ3XV1gXTtvt4prjf4i1+LhOv?=
 =?us-ascii?Q?OvZMp3m9A7bFfWjJG3lOk01aD9MtgGuPnMC1wSZkII470Z6z5wauVpnyoUZ5?=
 =?us-ascii?Q?pcQeiXBUfcrtx+LdG19MPDkycKQ3PETZlG3Y7BMS77U5hFCYb5G0A9UwywsR?=
 =?us-ascii?Q?61n43SAypB9y1TtkvASxHuTIACYJ2AhtItCO4bqeBJTHJKkBNTTgVNFWCAk9?=
 =?us-ascii?Q?s/FthwAgstKv5rkVQQtXrlStnotFi8T5JQOEtOdkwQR6WTdmqK130viyeIO0?=
 =?us-ascii?Q?Bkm2qgLKF0u0VayqnJvsOPyBKhyc0fkexJUmtveR8VDe4M8EDiicuaGirNyV?=
 =?us-ascii?Q?5X+Z+2JVFKH6Nla5tlNUr52M3BAwO59IFPJmm9DXHBQK0m1IgO1R0x7w52GN?=
 =?us-ascii?Q?1lISur0djvnSpmw8rOuttZm9pReJh+QgsH0sMVYrFtNTnQir+segViqzq0Gy?=
 =?us-ascii?Q?nqAwJYc4+pyimjn7rAt63ls6BN9pfVBYq08CQFBihb6QACHbXwfimLs4Csvj?=
 =?us-ascii?Q?tOis4Fr1YP+HWFZHKQex/2IbrVg7SbkTfB34d1DyjvZNczIHyWK5VK1MRe0Y?=
 =?us-ascii?Q?CnvAMFAH6znssPbjo1FHB0Qq6mkdCeTC54yNHAuZ+H2ygz8gIrfVRqTJ88v8?=
 =?us-ascii?Q?WYMARAYon1EQbqUi34tkDNYQKbvVo4wxLJZ3jWc7MWkgTYTtTHuHfKHbEL+R?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf95fd0e-c91a-4195-738c-08dc4ca88df3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 08:50:00.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +R6uOYJzVMpgE/+zWKCT4JbHCSQ4x5La/uG8r2evBNumO3AudwQ6A1P3MkNqBROw0gNNnDYrRwKtnaytG/FcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-OriginatorOrg: intel.com


hi, Uros Bizjak,

we reported an early crash issue for this commit last Oct.
https://lore.kernel.org/all/202310071301.a5113890-oliver.sang@intel.com/

as you mentioned at that time
"It is KASAN that is not compatible with named address spaces [1]."

now we noticed the commit is merged into mainline, and we observed a different
issue related with kcsan_setup_watchpoint. below detail report FYI.

[1] https://lore.kernel.org/lkml/CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com/


Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: ca4256348660cb2162668ec3d13d1f921d05374a ("x86/percpu: Use C for percpu read/write accessors")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master b3603fcb79b1036acae10602bffc4855a4b9af80]
[test failed on linux-next/master 226d3c72fcde130a99d760895ebdd20e78e02cb5]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------+------------+------------+
|                                                                         | 9a462b9eaf | ca42563486 |
+-------------------------------------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address                             | 0          | 6          |
| Oops:#[##]                                                              | 0          | 6          |
| RIP:kcsan_setup_watchpoint                                              | 0          | 6          |
+-------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403251658.8e92a8bc-lkp@intel.com


[    1.416777][    C0] BUG: unable to handle page fault for address: 000000000002bd28
[    1.416777][    C0] #PF: supervisor read access in kernel mode
[    1.416777][    C0] #PF: error_code(0x0000) - not-present page
[    1.416777][    C0] PGD 0 P4D 0
[    1.416777][    C0] Oops: 0000 [#1] SMP
[    1.416777][    C0] CPU: 0 PID: 2 Comm: kthreadd Not tainted 6.5.0-11417-gca4256348660 #1 232bbe22019ca80af13d3fa459a6dc475e14d345
[    1.416777][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.416777][ C0] RIP: 0010:kcsan_setup_watchpoint (kernel/kcsan/core.c:353 kernel/kcsan/core.c:609) 
[ 1.416777][ C0] Code: d1 7e e9 ab fc ff ff 48 83 fd 08 0f 85 15 01 00 00 4d 8b 14 24 4d 89 d8 4d 31 d0 e9 d6 fe ff ff 48 83 fd 08 0f 85 f4 00 00 00 <4d> 8b 1c 24 e9 31 fe ff ff 9c 58 48 89 44 24 10 fa f6 c4 02 0f 84
All code
========
   0:	d1 7e e9             	sarl   -0x17(%rsi)
   3:	ab                   	stos   %eax,%es:(%rdi)
   4:	fc                   	cld
   5:	ff                   	(bad)
   6:	ff 48 83             	decl   -0x7d(%rax)
   9:	fd                   	std
   a:	08 0f                	or     %cl,(%rdi)
   c:	85 15 01 00 00 4d    	test   %edx,0x4d000001(%rip)        # 0x4d000013
  12:	8b 14 24             	mov    (%rsp),%edx
  15:	4d 89 d8             	mov    %r11,%r8
  18:	4d 31 d0             	xor    %r10,%r8
  1b:	e9 d6 fe ff ff       	jmp    0xfffffffffffffef6
  20:	48 83 fd 08          	cmp    $0x8,%rbp
  24:	0f 85 f4 00 00 00    	jne    0x11e
  2a:*	4d 8b 1c 24          	mov    (%r12),%r11		<-- trapping instruction
  2e:	e9 31 fe ff ff       	jmp    0xfffffffffffffe64
  33:	9c                   	pushf
  34:	58                   	pop    %rax
  35:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  3a:	fa                   	cli
  3b:	f6 c4 02             	test   $0x2,%ah
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84

Code starting with the faulting instruction
===========================================
   0:	4d 8b 1c 24          	mov    (%r12),%r11
   4:	e9 31 fe ff ff       	jmp    0xfffffffffffffe3a
   9:	9c                   	pushf
   a:	58                   	pop    %rax
   b:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  10:	fa                   	cli
  11:	f6 c4 02             	test   $0x2,%ah
  14:	0f                   	.byte 0xf
  15:	84                   	.byte 0x84
[    1.416777][    C0] RSP: 0000:ffffc90000003eb8 EFLAGS: 00010046
[    1.416777][    C0] RAX: 0000000000000000 RBX: ffff88842fc2b6e0 RCX: 0000000000000001
[    1.416777][    C0] RDX: 001000000002bd28 RSI: 0000000000000000 RDI: 000000000000002b
[    1.416777][    C0] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
[    1.416777][    C0] R10: 0000000000000160 R11: 00000000aaaaaaab R12: 000000000002bd28
[    1.416777][    C0] R13: 000000000000002c R14: 0000000000000000 R15: ffffffff841f2200
[    1.416777][    C0] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[    1.416777][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.416777][    C0] CR2: 000000000002bd28 CR3: 0000000003e38000 CR4: 00000000000406b0
[    1.416777][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.416777][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.416777][    C0] Call Trace:
[    1.416777][    C0]  <IRQ>
[ 1.416777][ C0] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 1.416777][ C0] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 1.416777][ C0] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 1.416777][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[ 1.416777][ C0] ? kcsan_setup_watchpoint (kernel/kcsan/core.c:353 kernel/kcsan/core.c:609) 
[ 1.416777][ C0] ? rcu_is_cpu_rrupt_from_idle (kernel/rcu/tree.c:357) 
[ 1.416777][ C0] rcu_is_cpu_rrupt_from_idle (kernel/rcu/tree.c:357) 
[ 1.416777][ C0] rcu_sched_clock_irq (kernel/rcu/tree.c:3869 kernel/rcu/tree.c:2240) 
[ 1.416777][ C0] update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073) 
[ 1.416777][ C0] tick_periodic (kernel/time/tick-common.c:102) 
[ 1.416777][ C0] tick_handle_periodic (kernel/time/tick-common.c:120) 
[ 1.416777][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1081) 
[ 1.416777][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14)) 
[    1.416777][    C0]  </IRQ>
[    1.416777][    C0]  <TASK>
[ 1.416777][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 1.416777][ C0] RIP: 0010:__tsan_read8 (arch/x86/include/asm/current.h:41 kernel/kcsan/core.c:206 kernel/kcsan/core.c:750 kernel/kcsan/core.c:1025) 
[ 1.416777][ C0] Code: 08 85 c9 7f 3e 8b 50 0c 85 d2 7e 57 48 83 78 28 00 75 7b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 45 31 d2 45 31 db c3 <65> 48 8b 04 25 c0 f8 02 00 8b 88 10 13 00 00 48 05 08 13 00 00 85
All code
========
   0:	08 85 c9 7f 3e 8b    	or     %al,-0x74c18037(%rbp)
   6:	50                   	push   %rax
   7:	0c 85                	or     $0x85,%al
   9:	d2 7e 57             	sarb   %cl,0x57(%rsi)
   c:	48 83 78 28 00       	cmpq   $0x0,0x28(%rax)
  11:	75 7b                	jne    0x8e
  13:	31 c0                	xor    %eax,%eax
  15:	31 d2                	xor    %edx,%edx
  17:	31 c9                	xor    %ecx,%ecx
  19:	31 f6                	xor    %esi,%esi
  1b:	31 ff                	xor    %edi,%edi
  1d:	45 31 c0             	xor    %r8d,%r8d
  20:	45 31 c9             	xor    %r9d,%r9d
  23:	45 31 d2             	xor    %r10d,%r10d
  26:	45 31 db             	xor    %r11d,%r11d
  29:	c3                   	ret
  2a:*	65 48 8b 04 25 c0 f8 	mov    %gs:0x2f8c0,%rax		<-- trapping instruction
  31:	02 00 
  33:	8b 88 10 13 00 00    	mov    0x1310(%rax),%ecx
  39:	48 05 08 13 00 00    	add    $0x1308,%rax
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	65 48 8b 04 25 c0 f8 	mov    %gs:0x2f8c0,%rax
   7:	02 00 
   9:	8b 88 10 13 00 00    	mov    0x1310(%rax),%ecx
   f:	48 05 08 13 00 00    	add    $0x1308,%rax
  15:	85                   	.byte 0x85


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240325/202403251658.8e92a8bc-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


