Return-Path: <linux-kernel+bounces-126091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4307489320E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DCD1F21BD4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A3145333;
	Sun, 31 Mar 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nucjm3lP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF9144D21;
	Sun, 31 Mar 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711897887; cv=fail; b=hfRezUJ1FpUeDRohYuZ0NymMRFDtfVszzOq/957OYyGeuOzYpzvzWiMYjM9yMX8V0xg0dh5/ScGOV1zClIus9HkKJGPIZDESzTDK6HKILE+rS0BibAyIG+9i7Rc5Ho22Njtb70Tgm1AjuZ03DywlvdgCOjSmp18tO1tP/zgFP0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711897887; c=relaxed/simple;
	bh=TNl522M15Nfi3zuWalAlAxNNnhH/pJBR8sRyHQOKMDI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lphSZ+Wx9K5+CQ+EkSDMdW9o9V3B/mVPNc+6EmVaTt7sVQ3Z/rO+dK9x861we7uaZqrtJRgpJL7VxaAqmLgaGCjZWg9Cm8mrWaBvCfYCd4IUh7dk5D5sy9HO+HtRgbFHg39HSNXe8m7C/ECJrb83+/D2XZ9c3X5FUt89YHEuLFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nucjm3lP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711897885; x=1743433885;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=TNl522M15Nfi3zuWalAlAxNNnhH/pJBR8sRyHQOKMDI=;
  b=Nucjm3lP2rtq9JEYF/NgxgjjaODuaPS/NBTvO7MQ3icMab0QYDCpKNr6
   ou1vk4rx7i58rSeIT2SyKex2zci9PdDIzLU5AKJjtJo0qnw1O8O7ZTtcU
   PG7wg4uIQBI0KtNZm8H6hYDP1JC3TNs8ZyVSraDPbpHf9vlhWX2U51h9x
   k5OkpJeFfoZccBB2/tRrXaN7VbBOQZqGN1Merg7RUg1boCoyzYZb9hdOz
   Yj80JAtMS0/G8oeIAEmKmMLg8P/+xqXNWP9JsvVDxkxmqEKLNO93kSBj/
   CfHDHBiCUIuFaqZ8W3DHeN54bnLCAjSOWR1eQq10ss5iCS7MF+ld9vrGE
   A==;
X-CSE-ConnectionGUID: BZsO8qMjQU6c8mXbAgOJbg==
X-CSE-MsgGUID: XnV7D8fEQU2MmbgTs2PAjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17753294"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17753294"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 08:11:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="54942227"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2024 08:11:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 08:11:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 08:11:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 31 Mar 2024 08:11:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 31 Mar 2024 08:11:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXtbqMDTw3HGkGJA3fcgJ2w5aHkx2apI81Azq6W6TC1gD1fk4qOjIg7fic7v1xRyQiJudtcBwm/QjqUDH3R9UGD+NdhS8QxNuAMUOKYojHAUqEIrVFxdOduK1O+5smJGbgWLvGrAdWDKZlxqzF/i4y+AlGHKksZFwhsynbaeUsM5tAkB/oV93oV3y+hMfvLPCqpteVEVB+79zuvIhebVsGTNq6P1HaDpVadWJwbIzuK6WvGCgBJgWL3FrHLtDT5dLGifUZiT8kkZ/05v5dBGWpNQlIgF4h86x5ShdbcPnNWrdxjvIdo6d4J+dxu/GMxWvMZjQNT1Ib6qcxjsonDlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAmFu84ktMzQztWEd3Ywi5qFZWUU5w0qh+wIZh/jJa0=;
 b=Lvn393NvLfDSmMPAqr5HqXtIZaEREH1ti1ANmbujUPT8QBQSSpr61K3G3sy9dM0bjosFolPSZ9I74n8SfNB0aFQWdm/XR1qFXd4op7dNGvY1L0HQ1gRdC8wThq7dMsWfGpAbPNjpezRQLCmYXzW03n5xfLMBODgWIK8xyPQMJisUE92wTrz+vwhShvXtZvXWX0AZAglGKJs4Y21St+bCtUWzI9qhpJydrao6IOFt+YPGLYml50bWb4tICjeVg9AYsI6pooCwPjC6GDygW5ot/VrWhnjIgpvhPzElx+XLCjuinJIUHTLRvqQWm7GC3y4C6sI177g0DoGM2IK7OBqfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Sun, 31 Mar
 2024 15:11:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Sun, 31 Mar 2024
 15:11:21 +0000
Date: Sun, 31 Mar 2024 23:11:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, "Muchun
 Song" <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 7/9] mm: Free up PG_slab
Message-ID: <202403312344.c0d273ab-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240321142448.1645400-8-willy@infradead.org>
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7012:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fC1jc3w84ybQVFrjE7A1mN7s0Qp34oC9lz0OHAHW515wsIqB1hY2rxkOJddW7oCbCzUppmdWdU97vDuDwplQA+mmeBwYc0nYUFYjTwh/XMIOjsfyLTgFP1IT0K2KQkOE3EM1KI5Vrm3m7w2q+l8QupvoLPxcsGBldDDT5Lh7sbtbkDsqoaMW/F11u/CXdaVPwgJW6SIspqT0jpVpLpgygy36MvZ1a8WZPFnV2y73Qd2a//TxJSN+9UjNHZnLqcmBUChHSrrppeDF47oiy+jaaoM0NWfLYTWXJUWRWSXi21cwwycmjg2b5ROQ6rnlUXnqZ27R+0E1gLoRVr6rCU6mRSiWCKBgOb107CnqvVnHVjJCWPxuknu5T8dbEH6QsxBMv2B+aOpx5NW8/JF1fIc4dEtkWph0yf6YZbhdho6osqXqUgmRd58cSvA4zWfg9zArzFkdxcf+3snEOzVSrsPpdX2JC8awGuHuOmhPjBYzaShN6dstG4p7WBeDpaVqX0vPBRoU2BZlf2wpA1fwQuE6bWBX1AddKnyUhh0CzLZEvfaRjqaQNCVLwP2bjlBQWutZf4cqsgRzhz1qOvjn2ehzT28Rnq33P6kUAadOwe0jG+uCPMA6Uc/dorMLr1iJN3QB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M1YwEyQ3GGwlQuDEQ5bnNBNEoZ1N3/UpWGC4ZwmTaamhV4VO+PKDsx1r2cY/?=
 =?us-ascii?Q?1+DJH7tgWeocY4oMwz4NuKQseNOSi7iZxEi01m57H5Z5V+08IsafpiSYVDpS?=
 =?us-ascii?Q?P4LyyGcZyq8ZgL9IneSUhtVhvpPtuTLDVzLJcUAblcSjo0ORtcdq+8ZHPZf9?=
 =?us-ascii?Q?H6rXURSIYnGZVlz0+WzOMibWWZwk2VyYs/EGUFPLUdXnWY3LwpUlBxbdZRzy?=
 =?us-ascii?Q?JzxyhvC/HQ8LWU1fP/o7fYWdOXAcCa8Bv5ho7FIwgNvZRKTvcFAStQqL+yAO?=
 =?us-ascii?Q?vYsqkQUjFM4deGuoY7qzFCCw3PGFVLkZrsc28jmuWxBTTqvUVwfm0uXmUW3Z?=
 =?us-ascii?Q?80k3dnsOkgKwTWt0iTh8zIrMrEY23iAWA+GDe5lzP5H5LxCKrzN7CGKw+mbQ?=
 =?us-ascii?Q?TuMOOFAkeSzvv4BcsvZu4F9VJematlOc4RuUN75eGDlNHIvjOiPwtVvC5wkV?=
 =?us-ascii?Q?IY4WCQ0idMeAsPe5ZfEl5t0CFOKUMJumuplELQn+VeeMEOy6coc2VVGg9hcE?=
 =?us-ascii?Q?za3hlQz/5wfPo3wipSoe6wBf9MuM+qdpic6vyDXVEV7R9T/HCz4vgx4T1bjB?=
 =?us-ascii?Q?rSpWc03UevNZCvmZaj27wLaaNFX5wE5JR0h5xROYUtGyFic4l0LLS8mO6zCf?=
 =?us-ascii?Q?aIhZem3zV0SyUAgv+JgpVccmnSxmaZB0Fk7wAPsxreza1tP8cFj8Cf6N847b?=
 =?us-ascii?Q?LrIh7mwcyz1GYqjbLGrKB5FduEcpRCufACUZL0M7ZGlOpIOwJtpGHvXDOJXY?=
 =?us-ascii?Q?xokFU6Z8jLVxfyk7zyS2Ihtt7BBdkPO+5gTz4//6KSMr3+z8/wPDSa2lV5BB?=
 =?us-ascii?Q?UhtKNRktHs0CMm60dX7gb/oF8IHS7phQ2Y7m1d7kfKK0dQtz/cseUrNwGIet?=
 =?us-ascii?Q?rprsZOhmToUQ8UPKDkkYSsA676zG7F3I1qftCr2iNHqMeVY9dEFMcGrBY0XH?=
 =?us-ascii?Q?am+40JxKTT2aapY3f6b0nRPtOK0hK8C1+sJFEVaaGN1bpsDy8RiykWVrXqlx?=
 =?us-ascii?Q?SK7BUCQNo64XZFgx/stOhBI8+e5LRI6c2kdQgyGL6Ncd1PFo98/FamvkD2O7?=
 =?us-ascii?Q?CRivaClTslLJ/xNReXQmnyg11RO15+Cka/Obe4FIOjKi2hpmDmWGYXxBtQVM?=
 =?us-ascii?Q?ko3VjfcZhGS8pAPYYw2Xd9hp3hsSAbfQWKKuZ/BKTmfuSF7PSppogKPO1aja?=
 =?us-ascii?Q?R36gKwuQLqpHu7c3YmWt3PLH2eJAvzMVkxj9pMlYucXmzlMkEeQIbsaYtoya?=
 =?us-ascii?Q?RWrCu94LByG784bGTDWgpBcrYlw/B9IkrLSecR/+Fa8F1LgoZ5lDFLkrHghU?=
 =?us-ascii?Q?+v71myOBZDWsuzqctdD70/nv22IC3Ra/qy1161Eb9ZbVKjSA7I0SseTxFPy3?=
 =?us-ascii?Q?oy0eBSJnRstfN3lIpQGUgwV2JgoBhMKV3H9x9vhYPeIa8Om266KT3btlWPJ+?=
 =?us-ascii?Q?FUpVPd2TlMXpnh5sOud2VEgJMYbyAduShWiRqEwYeOJuFaL2ulHO3p18UpmW?=
 =?us-ascii?Q?NMAzLgTg9uSrd2+73S4n0xeHbertlAPmSeii9tz7y916c82atRC89sTpoSXI?=
 =?us-ascii?Q?VL2BdDsUgeTBGMlMSsqD7ggANVzIbmpAli0jBDNq4WBrEdXVW1gC0G4nuN4T?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 342990e7-8c5f-46fe-09d1-08dc5194d271
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 15:11:21.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPII/pRYF/bpMibhGsERR99ElNs9dcf4cjD4JDJ6CaU3Xgjg9kCEkMJGhjkULPxBeZxDqGNB7IyUSejWyw5xPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:shift-out-of-bounds_in_fs/proc/page.c" on:

commit: 30e5296811312a13938b83956a55839ac1e3aa40 ("[PATCH 7/9] mm: Free up PG_slab")
url: https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Always-initialise-folio-_deferred_list/20240321-222800
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 23956900041d968f9ad0f30db6dede4daccd7aa9
patch link: https://lore.kernel.org/all/20240321142448.1645400-8-willy@infradead.org/
patch subject: [PATCH 7/9] mm: Free up PG_slab

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240323
with following parameters:

	disk: 1HDD
	fs: ext4
	test: fs-00



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403312344.c0d273ab-oliver.sang@intel.com


kern  :warn  : [  528.627387] ------------[ cut here ]------------
kern  :err   : [  528.627589] UBSAN: shift-out-of-bounds in fs/proc/page.c:107:18
kern  :err   : [  528.627884] shift exponent 4096 is too large for 64-bit type 'long long unsigned int'
kern  :warn  : [  528.628200] CPU: 0 PID: 4703 Comm: proc01 Tainted: G S                 6.8.0-11774-g30e529681131 #1
kern  :warn  : [  528.628446] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
kern  :warn  : [  528.628659] Call Trace:
kern  :warn  : [  528.628814]  <TASK>
kern :warn : [  528.628960] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1)) 
kern :warn : [  528.629134] __ubsan_handle_shift_out_of_bounds (lib/ubsan.c:218 lib/ubsan.c:454) 
kern :warn : [  528.629360] stable_page_flags.part.0.cold (include/linux/page-flags.h:284 fs/proc/page.c:184) 
kern :warn : [  528.629506] kpageflags_read (fs/proc/page.c:238 fs/proc/page.c:250) 
kern :warn : [  528.629623] vfs_read (fs/read_write.c:474) 
kern :warn : [  528.629737] ? do_sys_openat2 (fs/open.c:1415) 
kern :warn : [  528.629898] ? kmem_cache_free (mm/slub.c:4280 mm/slub.c:4344) 
kern :warn : [  528.630063] ? __pfx_vfs_read (fs/read_write.c:457) 
kern :warn : [  528.630225] ? do_sys_openat2 (fs/open.c:1415) 
kern :warn : [  528.630388] ? __pfx_do_sys_openat2 (fs/open.c:1392) 
kern :warn : [  528.630552] ? __do_sys_newfstatat (fs/stat.c:464) 
kern :warn : [  528.630717] ? __fget_light (include/linux/atomic/atomic-arch-fallback.h:479 include/linux/atomic/atomic-instrumented.h:50 fs/file.c:1145) 
kern :warn : [  528.630888] ksys_read (fs/read_write.c:619) 
kern :warn : [  528.631051] ? __pfx_ksys_read (fs/read_write.c:609) 
kern :warn : [  528.631216] ? kmem_cache_free (mm/slub.c:4280 mm/slub.c:4344) 
kern :warn : [  528.631415] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
kern :warn : [  528.631555] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
kern  :warn  : [  528.631756] RIP: 0033:0x7f90bf2ba19d
kern :warn : [ 528.631913] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 54 0a 00 e8 49 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 24 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
All code
========
   0:	31 c0                	xor    %eax,%eax
   2:	e9 c6 fe ff ff       	jmpq   0xfffffffffffffecd
   7:	50                   	push   %rax
   8:	48 8d 3d 66 54 0a 00 	lea    0xa5466(%rip),%rdi        # 0xa5475
   f:	e8 49 ff 01 00       	callq  0x1ff5d
  14:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  1b:	00 00 
  1d:	80 3d 41 24 0e 00 00 	cmpb   $0x0,0xe2441(%rip)        # 0xe2465
  24:	74 17                	je     0x3d
  26:	31 c0                	xor    %eax,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 5b                	ja     0x8d
  32:	c3                   	retq   
  33:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  3a:	00 00 00 
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	ec                   	in     (%dx),%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 5b                	ja     0x63
   8:	c3                   	retq   
   9:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  10:	00 00 00 
  13:	48                   	rex.W
  14:	83                   	.byte 0x83
  15:	ec                   	in     (%dx),%al
kern  :warn  : [  528.632309] RSP: 002b:00007ffe2eb3c008 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
kern  :warn  : [  528.632540] RAX: ffffffffffffffda RBX: 00007ffe2eb3d1b0 RCX: 00007f90bf2ba19d
kern  :warn  : [  528.632757] RDX: 0000000000000400 RSI: 000055e284e68c40 RDI: 0000000000000005
kern  :warn  : [  528.632960] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
kern  :warn  : [  528.633156] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
kern  :warn  : [  528.633399] R13: 000055e284e68c40 R14: 000055e2a975f8cb R15: 00007ffe2eb3d1b0
kern  :warn  : [  528.633645]  </TASK>
kern  :warn  : [  528.633813] ---[ end trace ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240331/202403312344.c0d273ab-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


