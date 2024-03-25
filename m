Return-Path: <linux-kernel+bounces-116564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC388A0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1911C37E53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F014E2CC;
	Mon, 25 Mar 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dK2GkPk9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A014EC65
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346425; cv=fail; b=EOjgdlIlGllODCdoUblWRP/rTlpj6cOD5L5lklF6x5pSVd1kAi+6LcvKAUJAYP9Yn7Vt61uJ8MfrQHKhRTXHpWBKwaagk1t/k9KSskrIStb8ZkPFZ4ToMs9RrA9zJqCoUgm3pH+9kgkLv96ZP1JxaewBho+D6ON+C2dPA9CCy7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346425; c=relaxed/simple;
	bh=Muh7CMmlISBF+FNe9IK3v49u30+ZcKcUbaIb1A+jnXo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qPJW5ly4gjblOvSVssQ0qBHO/r+F7RidiZuBY+u5Unt08Xugis4olPRqSzHMKkHtOfPBc/ZZwtm79PmdzFGCU8BmWCivXT+B2qt0M9Kr6PLpeaptB+TfIeVE8o7cLSQ3p2j8owKsSqKKzhVSKXWgHKXs57NyUhsr+Sw8kS5aYCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dK2GkPk9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711346422; x=1742882422;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Muh7CMmlISBF+FNe9IK3v49u30+ZcKcUbaIb1A+jnXo=;
  b=dK2GkPk93OAqGsXXdpxoDyWstP2HRrnxf8MhTnFijDkptsStZP2dsw8f
   MfSqkaqAUF1pgBCrS4c81DQyiTj3pREg86IJMWic+smE3N5SLxEXAVKDN
   Rsvdx5QFDUt+ET1FPZ9Zg5MrM9hFHXab9o1NnoaU+DIKTLXaQLr8lZxQu
   ExCl2KEPe5ZShzR9pILGaLQQ6LR+oeMFabhfxkG4rBp8fSWay60sMCqnR
   PHbPpM3aL5wA6h1dCrMPTkqSFXC5hB+DnqZx1FTd9J/KMWulSKaT8mx9l
   SmuW+HdmpLodBfsJI9xDP7N8CGG7C/854fcjx7tPpyeE2zIaFEafNuqvA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17764170"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17764170"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="20188032"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2024 23:00:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 23:00:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 23:00:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 24 Mar 2024 23:00:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Mar 2024 23:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkEWE9zwy3a6KNbXmsdRUxjzj2Ukd2lLrs92nuOxr89Ua3YXM9aKHv2D69TOEz/A5vKUz+8IZtYw6iG8md8kuWhdmwzjBwrCcVh0NlYaStGbW4MNAINaRU5oiF/hsNt5/ZOJ6ElCNobquSSlZKNKTd6JkC5sR5y2xMMhI8w8BcyE5LPFDxIk9Yq9aeqFXmWcJZ2/PlggRcok+bkk+/QUvuE3YOG3wiICADdMBT+LEvMOpp3tPyzyX8IrJ4p5Ae5W+xh9FtxxCbfH1vlbwL2brMws0XvYCIAzVoRU0Cosez9HXDlre8FcrgnlG73TCeUmR4A5JUJqmf/C2rLVMs92iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yswaOh9jYsUSr7bwen5c5AfFhysW5cZ/wCKXq0R2qsQ=;
 b=Fpi4/1t3miEOdolEcGMj9V0YGHp3dXPFZ4OVGERnZHm9PNL1CfKw2wlTvXgbF0ZZ/cnA0oRGD/nvXjbsTLfxrrUdsZ+8PbEUnuY9U0qoHAs8iFbv/URi/dth78JSYBE34bf4YU8950IqA3Gw05p/TBcHWTnJ/iFJ4Xc6tBuEntnwpEJLCFpiDuaeoj1u81+m3Nn8KZEgJovHZAdVt+RG/YDPcO/kyQwYWIK3XmjLWfZLnRS+JSjnZhLiAXWWeyDmYho1Ch1ryK5e5fOMWdSK7i9DVCvxmFNd5mDuWR738k3j7r6OClAC2L0sevcVaqvIwIenmg7zpwcK9GdDqaxClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7657.namprd11.prod.outlook.com (2603:10b6:510:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 06:00:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 06:00:17 +0000
Date: Mon, 25 Mar 2024 14:00:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andy Lutomirski
	<luto@kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
	<hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Oleg
 Nesterov" <oleg@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
	<linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Andrew
 Morton <akpm@linux-foundation.org>, Dave Hansen <dave@sr71.net>, Peter
 Zijlstra <peterz@infradead.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/1] headers/deps: x86/fpu: Make task_struct::thread
 constant size
Message-ID: <202403251006.3568d460-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240320131908.2708438-2-mingo@kernel.org>
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1ad42c-b562-4342-274a-08dc4c90d8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apdf5ckXbBFTEu96605W2B/yhgFam0pwgZZ+iICNtc63F+givt9ySNrrYgC7SV/+Z6w9ramKAoFnD5EqEN+N7LRLzNlv7Z88InHYtVOdTzeE4K/7+M+QKhVYfM+zG33tAUPI9qA9nT0lAt128/fp4rHf5AvmSbjIb5myI4tiVVyOoc2H0P4ixcpRD9GPyCoILF6KX6ArwZICsfavtqi+acPaBbJicGBC4x0GHUcCVz9M5jXe52qZ+xQwE44j7oPlErnxAg/Zv3ayO/izwq/dF5G4nxx8EwpfijMDrUbach5COa3MndIHrlCB4QTd0ry9hAcbgsoavkexL+wkDTRRmSi4+fnsY+XMK3A8sOCTtkHtorkv9LPyWvh2Ur02xoxSZBPy/bSYKweIg+i3URtIroFTVb1ic5gwhHqdqQo9OM8/jDRErI9gbr/Kk9+MspOgwJO65dE8U1gQ7pGo9yGZWiSXqtCqsIQoXefYWUv06Vlk2q37sANFGFgdUE4CaifgWXi3hymZKv71sK2kyBWLPyzuIn0zHYUgIcXOMTm9CtCcK0HR4OIp5U1XcO0nlo2sEkBU1bg1kJzxyLUV6ea9C4KCcZcMmXMuUay3Ny7dvLzwJIZTFq/HzqTYNDWPgUaQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PP2dy1XzD6gnQBDj/iBppajEKZqZgqIHByTQ0ZtZtnYHlgXewSSAK7TDJcnl?=
 =?us-ascii?Q?qRgwEtGCm5N7tfcVmQnf+3aDBK2kkvDrNTb1+2euo09aQSGaBPdi4cie6ohi?=
 =?us-ascii?Q?eqODgGP978lDFJYXwlkgDMQahpP2nzRhOwfOu/aRsGaIbkZLNuj8+RpyfkbC?=
 =?us-ascii?Q?uW7YNludNjAVWaaJR8PYUnJTPrBqHFquWbOkcil3SnsxJAFPtdn9ZTfy+wb7?=
 =?us-ascii?Q?HvC8ABtDwkuaCsGE345UQWe9AleWA54cpOhGLzcV5lbxpqX0NKtZlMwC/VlG?=
 =?us-ascii?Q?RPJIFLm3UoL/fIkSVA4EDNMJN6sV/oMFvtMuD893E4ZA+9Z+0OXWQOoFf+4n?=
 =?us-ascii?Q?LfhqJwnsRGKX3/WSPX1//kMFLnji++rZmo63nR7AAIJICZylqdoZGtj3WBH7?=
 =?us-ascii?Q?8kuIHaOKhwai9RnhFclqeD0bDhdgMPuusf//2gL6O8vrEFUQwSexO62iE8nA?=
 =?us-ascii?Q?N7wWpDhvUj/zE5xtRVkLeQxAOaPZtB3pdfRxl9yiVy9DOo8qDNcHZTo6Plhb?=
 =?us-ascii?Q?KIHe+/WehtgjP/mcsc2r4Jid2dUSY2MJD6nPYAbG+XmyHOzI+446zFqEpOX2?=
 =?us-ascii?Q?XCKvE1wghpynI/SNKuJSDztXbujyc/YFtSOKTlNbH/DXnIkzYbFlvS4BoN69?=
 =?us-ascii?Q?MIrDDn3Dq6uc8fkIZJl3hBlmyWKW8XFCCSw/Mux0Dex3mZpXX+YD+uvRREyS?=
 =?us-ascii?Q?fqMuScJuT1MdoA4aLb25defb2rHUHtlBnsGImxtQeU+dxA0kdcSDlyFmVzAQ?=
 =?us-ascii?Q?S449MSRNDfVLVTeDAZokpS6rsXAVDT3NQ4dhSbcSlh2xhTcMyZq3/JAAF5VB?=
 =?us-ascii?Q?uNQCGJKYzSqgzjncfZuBDH7yE7015vAf4+wtVJ0G6zBlKW5Km60TydcVJBxT?=
 =?us-ascii?Q?ZF3XNbBft5cNgIRxcUPxhO8cVt4+BO5IvM+cntdGFt5uur/zXzyqh5MOB8df?=
 =?us-ascii?Q?0PVvD9A2IqFJsXSvnvRer//O9Fp+PYHik7w9Z1g7kOhNUHpXmbOO1bLGdb6D?=
 =?us-ascii?Q?xre/it5WRUL8SlsseP06IymgFOaHQ1d74qYXRphV4XJSa8DvmG38MEPineZe?=
 =?us-ascii?Q?DwT1Ua6oc2W/HT80G5n35WWKMN3Y4uca8sKQ2+7PmR82UjQKoVA4TN5VAbos?=
 =?us-ascii?Q?/i9zGw1zk6S5VXp0iyie6SyLklZCSU2HOa/+TFJGRH+tZbZLXnqiUlsQyqzD?=
 =?us-ascii?Q?yEOth7fYuW7HFGG4cmIe8D+JvNPzmINAKw0RP7cvhQQLJ8Xt4grDkgnN6rOb?=
 =?us-ascii?Q?PYB8Tp3TjhBzvRL9uZaICPopgvvqKuFWhQpMhqrnJ8ektPUVG4qXQJVxc3d5?=
 =?us-ascii?Q?hUfaYuI7yKNX4T8x7SHoi+wY7a0o6Y/oMI5CfgF1YjfcMQ2nsjP+05i1T4hw?=
 =?us-ascii?Q?A8lsvxYAfhscDUxeNh4PGwnkO5cXITgcNSiVjbqQRvCRoX7JYlH3dBcZDjXe?=
 =?us-ascii?Q?58t+boI2HacZCLYqdhqzGdjzyEI1dT2I/E8QW4RydsgA14fh66jNFf49Yau+?=
 =?us-ascii?Q?KPd2Z0CH50kK6H8xYoRDGY8jokkxqddB4rkvNMuYbb1JFiRMuKNwaolmL6JP?=
 =?us-ascii?Q?E+fwObz0o2ginZfXk0gC/rjqHm35rhtz/ZOGeZ1QU5npzt3YN9c8icSDdpgW?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1ad42c-b562-4342-274a-08dc4c90d8dc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 06:00:17.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbTH6KHdqciGtbgP6JbvWw+KJJuoBSLux6+lPTMEtbj5sfd7qvExfK5wTjWnIYqHATW6Be0jPcnpfDDeH2Y3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7657
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/mm/extable.c:#fixup_exception" on:

commit: 9738bc8321cc5abbab8676f6c1eb1b8c7c3d172d ("[PATCH 1/1] headers/deps: x86/fpu: Make task_struct::thread constant size")
url: https://github.com/intel-lab-lkp/linux/commits/Ingo-Molnar/headers-deps-x86-fpu-Make-task_struct-thread-constant-size/20240320-212236
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 35ce64922c8263448e58a2b9e8d15a64e11e9b2d
patch link: https://lore.kernel.org/all/20240320131908.2708438-2-mingo@kernel.org/
patch subject: [PATCH 1/1] headers/deps: x86/fpu: Make task_struct::thread constant size

in testcase: boot

compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------------+------------+------------+
|                                                                           | 35ce64922c | 9738bc8321 |
+---------------------------------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/mm/extable.c:#fixup_exception                         | 0          | 17         |
| EIP:fixup_exception                                                       | 0          | 17         |
| EIP:restore_fpregs_from_fpstate                                           | 0          | 17         |
| WARNING:at_arch/x86/kernel/fpu/xstate.h:#os_xsave                         | 0          | 17         |
| EIP:os_xsave                                                              | 0          | 17         |
| kernel_BUG_at_mm/usercopy.c                                               | 0          | 17         |
| invalid_opcode:#[##]                                                      | 0          | 17         |
| EIP:usercopy_abort                                                        | 0          | 17         |
| Kernel_panic-not_syncing:Fatal_exception                                  | 0          | 17         |
+---------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403251006.3568d460-lkp@intel.com


[    7.844011][   T58] ------------[ cut here ]------------
[ 7.844665][ T58] Bad FPU state detected at restore_fpregs_from_fpstate+0x3d/0x88, reinitializing FPU registers. 
[ 7.844686][ T58] WARNING: CPU: 0 PID: 58 at arch/x86/mm/extable.c:126 fixup_exception (arch/x86/mm/extable.c:126 arch/x86/mm/extable.c:275) 
[    7.846556][   T58] Modules linked in:
[    7.846556][   T58] CPU: 0 PID: 58 Comm: modprobe Tainted: G        W          6.8.0-rc4-00056-g9738bc8321cc #1
[    7.846556][   T58] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 7.846556][ T58] EIP: fixup_exception (arch/x86/mm/extable.c:126 arch/x86/mm/extable.c:275) 
[ 7.846556][ T58] Code: 88 0d a4 50 22 ce e8 9b 07 01 00 0f 0b e9 a8 fe ff ff 89 44 24 04 b2 01 c7 04 24 68 29 a9 cd 88 15 a6 50 22 ce e8 7c 07 01 00 <0f> 0b e9 c0 fe ff ff 0f 0b ba 88 f8 38 ce e9 e9 fe ff ff 8d 74 26
All code
========
   0:	88 0d a4 50 22 ce    	mov    %cl,-0x31ddaf5c(%rip)        # 0xffffffffce2250aa
   6:	e8 9b 07 01 00       	call   0x107a6
   b:	0f 0b                	ud2
   d:	e9 a8 fe ff ff       	jmp    0xfffffffffffffeba
  12:	89 44 24 04          	mov    %eax,0x4(%rsp)
  16:	b2 01                	mov    $0x1,%dl
  18:	c7 04 24 68 29 a9 cd 	movl   $0xcda92968,(%rsp)
  1f:	88 15 a6 50 22 ce    	mov    %dl,-0x31ddaf5a(%rip)        # 0xffffffffce2250cb
  25:	e8 7c 07 01 00       	call   0x107a6
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 c0 fe ff ff       	jmp    0xfffffffffffffef1
  31:	0f 0b                	ud2
  33:	ba 88 f8 38 ce       	mov    $0xce38f888,%edx
  38:	e9 e9 fe ff ff       	jmp    0xffffffffffffff26
  3d:	8d                   	.byte 0x8d
  3e:	74 26                	je     0x66

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 c0 fe ff ff       	jmp    0xfffffffffffffec7
   7:	0f 0b                	ud2
   9:	ba 88 f8 38 ce       	mov    $0xce38f888,%edx
   e:	e9 e9 fe ff ff       	jmp    0xfffffffffffffefc
  13:	8d                   	.byte 0x8d
  14:	74 26                	je     0x3c
[    7.846556][   T58] EAX: 00000000 EBX: cdc38510 ECX: 00000000 EDX: 00000000
[    7.846556][   T58] ESI: ea1abef0 EDI: 0000000d EBP: ea1abe5c ESP: ea1abde0
[    7.846556][   T58] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010046
[    7.846556][   T58] CR0: 80050033 CR2: bfda18db CR3: 29d1d000 CR4: 00040690
[    7.846556][   T58] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    7.846556][   T58] DR6: fffe0ff0 DR7: 00000400
[    7.846556][   T58] Call Trace:
[ 7.846556][ T58] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 7.846556][ T58] ? fixup_exception (arch/x86/mm/extable.c:126 arch/x86/mm/extable.c:275) 
[ 7.846556][ T58] ? __warn (kernel/panic.c:677) 
[ 7.846556][ T58] ? fixup_exception (arch/x86/mm/extable.c:126 arch/x86/mm/extable.c:275) 
[ 7.846556][ T58] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 7.846556][ T58] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 7.846556][ T58] ? handle_bug (arch/x86/kernel/traps.c:238) 
[ 7.846556][ T58] ? exc_invalid_op (arch/x86/kernel/traps.c:259 (discriminator 1)) 
[ 7.846556][ T58] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 7.846556][ T58] ? rt_mutex_debug_task_free (kernel/locking/rtmutex_api.c:487 (discriminator 11)) 
[ 7.846556][ T58] ? set_memory_global (arch/x86/mm/pat/set_memory.c:2298) 
[ 7.846556][ T58] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 7.846556][ T58] ? fixup_exception (arch/x86/mm/extable.c:126 arch/x86/mm/extable.c:275) 
[ 7.846556][ T58] ? set_memory_global (arch/x86/mm/pat/set_memory.c:2298) 
[ 7.846556][ T58] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 7.846556][ T58] ? fixup_exception (arch/x86/mm/extable.c:126 arch/x86/mm/extable.c:275) 
[ 7.846556][ T58] ? restore_fpregs_from_fpstate (arch/x86/kernel/fpu/core.c:188) 
[ 7.846556][ T58] ? __lock_acquire (kernel/locking/lockdep.c:5137) 
[ 7.846556][ T58] ? __delete_object (mm/kmemleak.c:798 (discriminator 3)) 
[ 7.846556][ T58] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 7.846556][ T58] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:267) 
[ 7.846556][ T58] ? local_clock_noinstr (kernel/sched/clock.c:282 kernel/sched/clock.c:306) 
[ 7.846556][ T58] ? exc_bounds (arch/x86/kernel/traps.c:643) 
[ 7.846556][ T58] exc_general_protection (arch/x86/kernel/traps.c:617 arch/x86/kernel/traps.c:677 arch/x86/kernel/traps.c:643) 
[ 7.846556][ T58] ? __delete_object (mm/kmemleak.c:798 (discriminator 3)) 
[ 7.846556][ T58] ? exc_bounds (arch/x86/kernel/traps.c:643) 
[ 7.846556][ T58] handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 7.846556][ T58] EIP: restore_fpregs_from_fpstate (arch/x86/kernel/fpu/core.c:188) 
[ 7.846556][ T58] Code: eb 0a cc cc cc db e2 0f 77 db 45 f4 3e 8d 74 26 00 8b 3d ec f1 bc cd 8b 4d f4 8b 1d e8 f1 bc cd 21 fa 8d 79 40 21 d8 0f ae 2f <8b> 5d f8 8b 7d fc 89 ec 5d 31 c0 31 d2 31 c9 c3 8d 76 00 3e 8d 74
All code
========
   0:	eb 0a                	jmp    0xc
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	db e2                	fnclex
   7:	0f 77                	emms
   9:	db 45 f4             	fildl  -0xc(%rbp)
   c:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  11:	8b 3d ec f1 bc cd    	mov    -0x32430e14(%rip),%edi        # 0xffffffffcdbcf203
  17:	8b 4d f4             	mov    -0xc(%rbp),%ecx
  1a:	8b 1d e8 f1 bc cd    	mov    -0x32430e18(%rip),%ebx        # 0xffffffffcdbcf208
  20:	21 fa                	and    %edi,%edx
  22:	8d 79 40             	lea    0x40(%rcx),%edi
  25:	21 d8                	and    %ebx,%eax
  27:	0f ae 2f             	xrstor (%rdi)
  2a:*	8b 5d f8             	mov    -0x8(%rbp),%ebx		<-- trapping instruction
  2d:	8b 7d fc             	mov    -0x4(%rbp),%edi
  30:	89 ec                	mov    %ebp,%esp
  32:	5d                   	pop    %rbp
  33:	31 c0                	xor    %eax,%eax
  35:	31 d2                	xor    %edx,%edx
  37:	31 c9                	xor    %ecx,%ecx
  39:	c3                   	ret
  3a:	8d 76 00             	lea    0x0(%rsi),%esi
  3d:	3e                   	ds
  3e:	8d                   	.byte 0x8d
  3f:	74                   	.byte 0x74

Code starting with the faulting instruction
===========================================
   0:	8b 5d f8             	mov    -0x8(%rbp),%ebx
   3:	8b 7d fc             	mov    -0x4(%rbp),%edi
   6:	89 ec                	mov    %ebp,%esp
   8:	5d                   	pop    %rbp
   9:	31 c0                	xor    %eax,%eax
   b:	31 d2                	xor    %edx,%edx
   d:	31 c9                	xor    %ecx,%ecx
   f:	c3                   	ret
  10:	8d 76 00             	lea    0x0(%rsi),%esi
  13:	3e                   	ds
  14:	8d                   	.byte 0x8d
  15:	74                   	.byte 0x74
[    7.846556][   T58] EAX: 00000007 EBX: 00000007 ECX: c2d836e0 EDX: 00000000
[    7.846556][   T58] ESI: c2d836a0 EDI: c2d83720 EBP: ea1abf58 ESP: ea1abf4c
[    7.846556][   T58] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
[ 7.846556][ T58] ? exc_bounds (arch/x86/kernel/traps.c:643) 
[ 7.846556][ T58] ? restore_fpregs_from_fpstate (arch/x86/kernel/fpu/core.c:179 arch/x86/kernel/fpu/core.c:181) 
[ 7.846556][ T58] switch_fpu_return (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/fpu.h:57 arch/x86/kernel/fpu/context.h:50 arch/x86/kernel/fpu/context.h:76 arch/x86/kernel/fpu/core.c:788) 
[ 7.846556][ T58] syscall_exit_to_user_mode (arch/x86/include/asm/entry-common.h:58 include/linux/entry-common.h:330 kernel/entry/common.c:201 kernel/entry/common.c:212) 
[ 7.846556][ T58] ? call_usermodehelper_exec_async (kernel/umh.c:114) 
[ 7.846556][ T58] ? call_usermodehelper (kernel/umh.c:65) 
[ 7.846556][ T58] ret_from_fork (arch/x86/kernel/process.c:157) 
[ 7.846556][ T58] ? call_usermodehelper (kernel/umh.c:65) 
[ 7.846556][ T58] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 7.846556][ T58] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[    7.846556][   T58] EIP: 0xb7ee70b0
[ 7.846556][ T58] Code: Unable to access opcode bytes at 0xb7ee7086.

Code starting with the faulting instruction
===========================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240325/202403251006.3568d460-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


