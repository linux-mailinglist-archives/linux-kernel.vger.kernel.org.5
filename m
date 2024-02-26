Return-Path: <linux-kernel+bounces-81665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F186797F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B04B2BEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0D12BF3F;
	Mon, 26 Feb 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2BmgJUS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55277132C0B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958151; cv=fail; b=fV1r3CAqDS0RcVTqkh5oStr5xq1f6xCzkTeOgwDIOiKlmVVQg4lPBCbxRDzblU4wlTZWuVsOe1ZZqC+yNBs6X6D2uYfYc8X/dhEocdTamsnlYK5hsLfznbdBvUA/+L94JgNmSfEyStAdRqw9PoopMQlQLy7wQxM9p0AFbWIzEN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958151; c=relaxed/simple;
	bh=WYXZC4aQrNiJr7CZkAvqd640vUqh2SqsCHkl1qzrMQ8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JsrR7AMsA8iRiMwLeEzst6oU1uOAw5CJTDIg0bbzKCUDqJKZiA08/OrPWeV7Nt/z7RNzgEenA+omCsaEM2ciHrttOe6hBsj9GwQc3scN1g5HYAiRBIsxj+anc7VcyXfmlrRw55tSJkQcd/bm2d76QvVQRcev1PU1XS2pIsUt7dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2BmgJUS; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958149; x=1740494149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WYXZC4aQrNiJr7CZkAvqd640vUqh2SqsCHkl1qzrMQ8=;
  b=N2BmgJUSdsNXPyQny61tVqQgnQ4Shr8Y0khpDd/AmFsSO0eBphJycb8P
   PYBl8A54tQyjQLI+HXWBkV9kOYDqih/2Kxa5BvuWtBU07GrVSN0ALDMGX
   DMEzovSRC9cwE0utNmTEWp8WOHlUWCnZyVdPK7niYT7y40rVuugTBLV30
   gA0McRX3x5cd9+YNSePU+6xySouNy6Og8gb1wQ41gWRyax9W2xxkA/Dfy
   MrRlnmyka5iXVrEa+xejR1dwWERSQ9Vn3IMl7gzEMsndn8yC99iAV74A7
   ObfKM73dyQ/u9h0Rw/gVVxSHP6xAeOyW4hlwXkM8SFYVb+wqq63kzz9X7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13801172"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="13801172"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6571508"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 06:35:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 06:35:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 06:35:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 06:35:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFSQ7BnjgKKuuwJvQJU1sxhSw7hMfQkpwl2FPffYh+ms0f8vhcADZZsfVnTW4wx39qQNxCpPD1eSjb14qfwrhUSPhOQIyIjLpVHCthRu+bfJruR5Mzg1TVucw0Trv1gtQk3fvUElh2MwdB9KLcmD+YJ5uk962XqUBs+3l8HmdWM+wbsuTTgMFKHpz0S+3UWJEHLBVnK8zlaHzY6bL16Ty44Q975ExAGko//nn+boH18DAZi/ZYRWMzaqEBhYmKmCxPngZON/3iyOIfePlDmY6TgNSWjEjqO09bmid4XyiyVxDyLcT2CBC5W1FCTxUx3jJqfh71H7PcrYdDBm+cRFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nFhmxxhcxmzQpToPdUTZi2aShnlkc6tSsYSr9TxLuQ=;
 b=nv4Y/S94IwtA1w0E5JMtDRP9Vr1/ygZNj9qbkwwtuql/bK8y7nXiYtC8hPQCC0lRRAgVJFaQ4vtt2/U0XYA0rXWfDJ1ijwl5CGLPaRcrtALkoP1yLlKhGF55Rf5Oyntkm5rCMMUOEXxhMCiRLSPoo9a7AUFSg1CSA+nxWywiwrs85PAjv4IYIaq/604SqaAJA/98NZwUuj7zDHJXxKooQpC2ucxz8bBs5vrpS5VpZc5hTsbMwiuA7ipPU2m8MardB8+5yQw3gHEiT5WZVMWp3fvWryqppQ/mP0AHKBLSYUJypaKFipDD65r1qFB6lZO35xDQcC+r3oyaPUfWhGh4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 14:35:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 14:35:02 +0000
Date: Mon, 26 Feb 2024 22:34:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Xin Li <xin3.li@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
	<oliver.sang@intel.com>
Subject: [tip:x86/fred] [x86/fred]  65c9cc9e2c: WARNING:kernel_stack
Message-ID: <202402262159.183c2a37-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: bde75bfa-787f-454c-69df-08dc36d81d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPSZIcHeAcJH/Q5qHbf2L4SJmfSBH45J0JosXLMw5+RZjKq+NycSLTE1TyNADhXQLSdXcpevrB1zTbJuKQjXus7SvOr8TXtWmQp/QTtfv9t6qBJ8wc9G3LxFPAaQmW9XgJD0rnwjLP8LCZycQe7JuzKOYYgxNYPkXSJiNBiY4Koo3gTv6TcWE48yUwvl8LESSOvCoZw5ncJ1EZVAFrsPzMFU2EfCHN1+f2E2tlWZgDa4K277dqcKZo7VrifRhUQFTmmyuFoFgkjsG1Df+nqniyuiWsqMXTELu7Bs2lFPF6Ib6WLpN2jrL2ytZ4QBbYkQhwCIbQ37bCXADlPkMFFUGhC24Z10LZkSRfTFvDN33S2ivseA+50tFy1J5JOMPwmYp4BZdwP3KMZggmh1uoBJP2zXrketAd/382kSsT4eMeTYAcVMqG9gzpd1Udo2cQEIphQCVDa7Fu+Zxk4Iz8dhbE3XfnJJZaNqNULjOVwT/mO19o+MNBUjUHov3OlHNFXq7F7X9OylxrfGEAXJrwCUstfLXd0D4M3wsEgYx7nT0MYL5gD4vFNbYGCqiRCfIeSx1FRbSr0TLpNwiLNR6PonjS7yKQPbGdggFEcNJm7DClpqqeCthAVgZLT+pbaIV1BElqtFjsyP58/bk274IsZL0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3GvW+wdHXU/dVC/nU0sMz417FFkprbWdIPq5kkm5E0mRJ0Wmv24x75jPES3?=
 =?us-ascii?Q?lXR3/Q1IHn7pAQERp/Yoleyr21+B1AgbCVtzirzUAbB8F2KSHz6rlAAsFg1b?=
 =?us-ascii?Q?3V36cFHwh5aihuNTOVv18ig+8MxjbhzplQocdiM991RLUekXU5hK+Ew2OxIL?=
 =?us-ascii?Q?gbBNwyzCr8P/Y+mcx2xrg/Z1nK2AzpB+t9Lxi5lyMGOW51Lkf1EJb1b54Q4x?=
 =?us-ascii?Q?eo0ZFML1Y8aCggGa8dSri+aGTBiFuVXU3W0oGvGIGhG1kb/3ZOPxdPwXWCEz?=
 =?us-ascii?Q?AzcAxYE8P57ajv2DyxvzBCj6BnZCc/Q6ceEwedVVqvHSa1Fa9yF0Pozc8UQC?=
 =?us-ascii?Q?/9L+EU8Joy7MLafmwVmglgrpihU3f/56Sr7kh0/qCFsxHy11+Cw2Jfd80z2p?=
 =?us-ascii?Q?/dcY/UmJtD04XLawOmmnx809VdOQQPLTPuGxfYhSLXyv+FIQl4obLUu+n1SS?=
 =?us-ascii?Q?doD2KZlfJW8DHJO5H0AgLCAIj65f4g2/6VAlg1Dgq1wjmYHJaP4fe6I0A5HF?=
 =?us-ascii?Q?TVKQUXY3fZbuZRZ+bKVj2HWnvA8XekQDFs3BAGn5VlbsEF4dNwm0h52IlKgf?=
 =?us-ascii?Q?5119bhWv5LV08u4Hl84zClT/XFcKZ5sYebr4ohG7VS4Fv2RaV6E7AA8qP+4/?=
 =?us-ascii?Q?BXKMhQhtccPkFPIjd5HFpKwaNweQGVC0qyhCnaLSkb5oEKODWfmI9rNh4Z4w?=
 =?us-ascii?Q?SxRKl9lR1jCkGyZ7BcbZ7CsvPcpzCGAEMLprDhtXmT2A5/5ySFTYRgGwFe0U?=
 =?us-ascii?Q?Fi+DKYbwHHc8/9EJm+daU9w55UDgRMPjrwSIZ+LEd4haYoy7NNpWRPsDuNFA?=
 =?us-ascii?Q?qr1XYcIPVFUkzmKiibUKo5NQIked46YTl1ReapCHBDJcNpE4aQ9Mc1yArXvP?=
 =?us-ascii?Q?yV190j6rFVawOoMND5yTFqWLUL66U3M0f/8qAuZDZnrzhiFjglKlOZmpjHx8?=
 =?us-ascii?Q?SLPfL79SxCXWD5apfi/BECHzRN1kg4soGuS8j8S7tSln1RyQCHLBnZZp51A1?=
 =?us-ascii?Q?Pt6CvbUYNLaA2pg1sxd+0EJy+AsT2AvzqGjVwLkEFyvNiglZg9HMDWmrj0Ri?=
 =?us-ascii?Q?kiNDQTvi4haKhYUGUFCg26dgTCphSyTEXTE8+E0Po+FaWdf54+YpAWFGgYi4?=
 =?us-ascii?Q?09wFu3bnuu2eyRyE354IsZkAMTE12otR/75UOoxGQzHfDYH52HB4Qq63Ljme?=
 =?us-ascii?Q?2kfDcwuSTtPyobbRhOU6d7pDMEx3GqdL4O8qnkVpWWkfTSiNEaTJjo70BTz2?=
 =?us-ascii?Q?2p0/8vI34ujfAD6KdHxG6WBXVW/B1mpe4Af8ISG7KUDjMDXqRfTSPvnl9uco?=
 =?us-ascii?Q?uKSFmztHDcZSzl6vI61KtvPsplmsYkaCA0MZNX1jGG/3Rl65FuyNRkW4Ere8?=
 =?us-ascii?Q?nbn3453p0fNhhJ7EmOf2iGjZNcPDWNFqF99sQjCGCq+UP1fnVe1lqd1WZKgP?=
 =?us-ascii?Q?p7rvVLnqgTEq6HgyuU50vDn9kTvSfNu+iQ/Xi3irtcs9EFnkq/iDJYzfQ1q0?=
 =?us-ascii?Q?mCkaYGSpgt3MuC7pBJNRNSWE8wSahVRNUHUOicIPvASgKnRBPHXW738QEbQ7?=
 =?us-ascii?Q?wUWG5RNZrxK1ScWxWVr28iYG+3lXR3YNuDCmzwpgGIemcw/COa13UZc2L0Dl?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bde75bfa-787f-454c-69df-08dc36d81d85
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:35:01.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDJ8zoPHYuUzqfBbzZohsJjHin6Fy5uVu5kxEQaItqSJNz0CaYHU0jcFXvi0IBid0lyGTaF3KIwE2SZrxi4Buw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:kernel_stack" on:

commit: 65c9cc9e2c14602d98f1ca61c51ac954e9529303 ("x86/fred: Reserve space for the FRED stack frame")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/fred

[test failed on linux-next/master 33e1d31873f87d119e5120b88cd350efa68ef276]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | 32b09c2303 | 65c9cc9e2c |
+-------------------------------------------------------------+------------+------------+
| WARNING:kernel_stack                                        | 0          | 14         |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402262159.183c2a37-lkp@intel.com


[    0.000000][    T0] WARNING: kernel stack frame pointer at (____ptrval____) in swapper:0 has bad value 0000000000000000
[    0.000000][    T0] unwind stack type:0 next_sp:0000000000000000 mask:0x2 graph_idx:0
[ 0.000000][ T0] (____ptrval____): ffffffff83e07960 init_stack+0x7960/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff81093000 arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 0.000000][ T0] (____ptrval____): ffffffff83e07960 init_stack+0x7960/0x8000 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83e00000 __end_rodata+0x2a000/0x2a000 
[ 0.000000][ T0] (____ptrval____): ffffffff83e08000 init_stack+0x8000/0x8000 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[    0.000000][    T0] (____ptrval____): 0000000000000002 (0x2)
[ 0.000000][ T0] (____ptrval____): ffffffff83e40080 cpu_loops_per_jiffy+0x9a0/0x9a0 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[    0.000000][    T0] (____ptrval____): 0000000000000001 (0x1)
[ 0.000000][ T0] (____ptrval____): ffffffff83e07f48 init_stack+0x7f48/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff83e078a8 init_stack+0x78a8/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff8100017d secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[    0.000000][    T0] (____ptrval____): fffffbfff07c0f2e (0xfffffbfff07c0f2e)
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83e40968 init_task+0x8e8/0x2660 
[ 0.000000][ T0] (____ptrval____): ffffffff84fac8e0 stack_trace_hash+0x20020/0x20020 
[    0.000000][    T0] (____ptrval____): 0000000000000008 (0x8)
[ 0.000000][ T0] (____ptrval____): ffffffff83e079f8 init_stack+0x79f8/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff813c0492 stack_trace_save (kernel/stacktrace.c:123) 
[    0.000000][    T0] (____ptrval____): 0000000041b58ab3 (0x41b58ab3)
[ 0.000000][ T0] (____ptrval____): ffffffff83d45f3b linux_banner+0x21565b/0x26a4f0 
[ 0.000000][ T0] (____ptrval____): ffffffff813c0400 filter_irq_stacks (kernel/stacktrace.c:114) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff84fac8f8 stack_trace+0x18/0x400020 
[    0.000000][    T0] (____ptrval____): 000000000007fffd (0x7fffd)
[    0.000000][    T0] (____ptrval____): 000000000000000a (0xa)
[    0.000000][    T0] (____ptrval____): dffffc0000000000 (0xdffffc0000000000)
[    0.000000][    T0] (____ptrval____): 0000000000001fec (0x1fec)
[ 0.000000][ T0] (____ptrval____): ffffffff85588d48 lock_classes+0x18ff48/0x190020 
[ 0.000000][ T0] (____ptrval____): ffffffff85588c80 lock_classes+0x18fe80/0x190020 
[ 0.000000][ T0] (____ptrval____): ffffffff83e07a10 init_stack+0x7a10/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff812e5001 init_data_structures_once+0x81/0x600 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff85853620 console_list+0x40/0x40 
[ 0.000000][ T0] (____ptrval____): ffffffff83e07a88 init_stack+0x7a88/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff812e7250 save_trace (kernel/locking/lockdep.c:582) 
[ 0.000000][ T0] (____ptrval____): ffffffff85853620 console_list+0x40/0x40 
[ 0.000000][ T0] (____ptrval____): ffffffff83e07af8 init_stack+0x7af8/0x8000 
[    0.000000][    T0] (____ptrval____): 0000000000000046 (0x46)
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff84334800 cgroup_mutex+0x60/0xc0 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff8369adc0 cgroup_subsys_name+0x2a0/0x720 
[ 0.000000][ T0] (____ptrval____): ffffffff84fac8f8 stack_trace+0x18/0x400020 
[ 0.000000][ T0] (____ptrval____): ffffffff85853620 console_list+0x40/0x40 
[    0.000000][    T0] (____ptrval____): 0000000000000008 (0x8)
[ 0.000000][ T0] (____ptrval____): ffffffff83e40968 init_task+0x8e8/0x2660 
[ 0.000000][ T0] (____ptrval____): ffffffff853f8e00 lock_classes_in_use+0x420/0x420 
[    0.000000][    T0] (____ptrval____): 0000000000000008 (0x8)
[ 0.000000][ T0] (____ptrval____): ffffffff83e07ad0 init_stack+0x7ad0/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff812f5d57 mark_lock (kernel/locking/lockdep.c:4673) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83e40080 cpu_loops_per_jiffy+0x9a0/0x9a0 
[ 0.000000][ T0] (____ptrval____): ffffffff83e40968 init_task+0x8e8/0x2660 
[ 0.000000][ T0] (____ptrval____): ffffffff83e40080 cpu_loops_per_jiffy+0x9a0/0x9a0 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[    0.000000][    T0] (____ptrval____): 0000000000000004 (0x4)
[ 0.000000][ T0] (____ptrval____): ffffffff83e4094c init_task+0x8cc/0x2660 
[ 0.000000][ T0] (____ptrval____): ffffffff83e07af8 init_stack+0x7af8/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff812f729c mark_usage (kernel/locking/lockdep.c:4603) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83e40080 cpu_loops_per_jiffy+0x9a0/0x9a0 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83e07ba8 init_stack+0x7ba8/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff812f7b4c __lock_acquire (kernel/locking/lockdep.c:5091) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83e40980 init_task+0x900/0x2660 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83e40988 init_task+0x908/0x2660 
[ 0.000000][ T0] (____ptrval____): ffffffff83e40960 init_task+0x8e0/0x2660 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[    0.000000][    T0] (____ptrval____): 0000000000000001 (0x1)
[ 0.000000][ T0] (____ptrval____): ffffffff83e40968 init_task+0x8e8/0x2660 
[    0.000000][    T0] (____ptrval____): 1ffffffff07c0f7e (0x1ffffffff07c0f7e)
[    0.000000][    T0] (____ptrval____): 0000000000000001 (0x1)
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff84334800 cgroup_mutex+0x60/0xc0 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83e07cb8 init_stack+0x7cb8/0x8000 
[ 0.000000][ T0] (____ptrval____): ffffffff812fa85b lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff84b39df1 cgroup_init_subsys (include/linux/xarray.h:380 include/linux/idr.h:137 include/linux/idr.h:151 kernel/cgroup/cgroup.c:5986) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[    0.000000][    T0] (____ptrval____): 0000000041b58ab3 (0x41b58ab3)
[ 0.000000][ T0] (____ptrval____): ffffffff83d42ee6 linux_banner+0x212606/0x26a4f0 
[ 0.000000][ T0] (____ptrval____): ffffffff812fa6c0 lock_sync (kernel/locking/lockdep.c:5722) 
[ 0.000000][ T0] (____ptrval____): ffffffff8127aaea __might_resched (kernel/sched/core.c:10138 (discriminator 11)) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[    0.000000][    T0] (____ptrval____): 0000000041b58ab3 (0x41b58ab3)
[ 0.000000][ T0] (____ptrval____): ffffffff83d41e6f linux_banner+0x21158f/0x26a4f0 
[ 0.000000][ T0] (____ptrval____): ffffffff8127aa80 trace_raw_output_ipi_send_cpumask (kernel/sched/core.c:10131) 
[    0.000000][    T0] (____ptrval____): 0000000000000000 ...
[ 0.000000][ T0] (____ptrval____): ffffffff83665a60 sched_feat_names+0x480/0x960 
[    0.000000][    T0] (____ptrval____): 0000000000000249 (0x249)
[ 0.000000][ T0] (____ptrval____): ffffffff83e40080 cpu_loops_per_jiffy+0x9a0/0x9a0 
[ 0.000000][ T0] (____ptrval____): ffffffff84b39df1 cgroup_init_subsys (include/linux/xarray.h:380 include/linux/idr.h:137 include/linux/idr.h:151 kernel/cgroup/cgroup.c:5986) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240226/202402262159.183c2a37-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


