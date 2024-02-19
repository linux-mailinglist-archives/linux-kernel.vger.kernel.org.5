Return-Path: <linux-kernel+bounces-71476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C03585A5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60E72827EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D26E374EE;
	Mon, 19 Feb 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEg07LYD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5C37155
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352814; cv=fail; b=FjjR0/987kHgw+vqV+QllE8CEhbTNR+GHft13Sep097pUjSH4VajXpkR+J6c6u//rsZGCBSvQ0M6ztdpSd+wqyJzWtqwZ+25i8lMu9Q3qfMBWraE1XUHRzTAzshxDDBZpr4WCv20OR/uTQ4lNYF4cxFoIXrpPB6eoy3Nnv+W1oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352814; c=relaxed/simple;
	bh=erJAG4ZBXreGo7xJIeTcyTVHXBkG1x12XmjNDLvddCQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BeqHn7lvQeuBdMPyTMufx6toQiCCkBGaVMVtUHq6APrMaphbwV8hyhuprAIWleM1vQLzyEVAgDTPD1GmN17Exre8eK1r6ku1od10FLdWqg8pnTo4BoNRYcqgsqFPucVqcyWpAP07RmfasxfIQjc7dZdlAiGht/SmeoBWKgqqTr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEg07LYD; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708352812; x=1739888812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=erJAG4ZBXreGo7xJIeTcyTVHXBkG1x12XmjNDLvddCQ=;
  b=lEg07LYDzf9VxIMy25DNnzxnEaUaeFeClBst9ToiMoaw56lyPLjEULAx
   mc4/e7zG25PjaDWVkg6FAcIt1rfAd2TxAzRKy01QZkQYaeVslYXylt0mV
   m80WJYfTE7LgwIkCfNzefXyXqruxZlMALX51hGf3oWeHnFQgSGjp+C0gj
   APLOz1PPWaZj2iBjEkuprGPwWIPdnqZ/UVhaw5GF5bTuGbnYzGKeP7vuC
   wkCmkrT+HgFC55r2CYd64t+0VY/bBoWKR+6kN9V3lzRD+U0seA/Eny8ol
   cZ43klnVcvFDFwpxBfpMMOiDv6e9rLBw04dDWOXTR6IZocXPp8Ul5yb83
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6209651"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="6209651"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 06:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9188352"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 06:26:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 06:26:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 06:26:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 06:26:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Askdsnc7klqsS08Lu2aTPt3k6oej1ZbNk+88pg5TqQWsq8f3bP3oZJpRStt6YKztzT68Hp3L5z0a+AmGb3NpW67jNKXRloxvtYDyHcHYksDcqOXCycc7cfu63WSo3jyeHRffzi3JdlGPil4wOJiNPVRwvmTqkqs4bGTdWGjGCju0DA4ZhpWrudznAXSBIQ27Q+05SXtqTpXgXMofEU4limw+rSf/ECkqrIIztuRipLYvBti5LKzwztsPI349XTkSYZxmcQQOaMm6K+7L3RypyMZdS1w7K7j1Gz2hjnITkC/FBw4Nj3ftvx1qAVK1Vx2X+BV7uZiHM/8AHRGi97HeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwhZYQne7ylg543kIdQgWMtoF3ePaKVucuXkAMzURok=;
 b=UB9zEFdK+NmekXG/ErV0s+NzWlwISCOlzkYeTJZDFfr+v2RXbFSlNzWWYD5807W7bfmRqZa3ZugGYVMZqBiJ6f4X6MUJ0/BEze75W6ipY7CDYqaIsc40GveJC7UzWhVOv4L6b+r27aBBRUpB3cooHHSu6k1cfQqvbRJ1yqEI4BOooteTR5Msg93vHPxkvy3M6+/SCutD1eBAUeYWYRHlPRT4uT0vxAEmGEjIPQRnoy5Ut5HRUBQUk/uEUNMctZb0XSv/ChFXwEQm/p6gKYnfd0H9pOHyC2toDiqNPO7hFdw3smSXRj4q7v8nI0si08mBc4edo/cFFR4fR2xlHw9CSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Mon, 19 Feb
 2024 14:26:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:26:46 +0000
Date: Mon, 19 Feb 2024 22:26:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hugh Dickins <hughd@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [shmem]  3c1b7528d8: kernel_BUG_at_mm/page_alloc.c
Message-ID: <202402192250.f71dd353-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a64b64-e387-40b9-1504-08dc3156cd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzFTUhwT82GhCI3xlyBOYGYtGrCXc64e9AEKMfR87jZcVRnuLOc6uKfXN2WesmRFLWWxJgZ6Uc00XV8DmZP5aN/hCtUN4kjCnlUOkKyGVmq5qkE4D/7ftcbLiq0+56JROBMn/s2hDLQg1ViELa9FXGSjj2kNTuUgVdbji/M/iZBvvrhoynG50NkxHnkQ/saaA9+oNCLZ+7Qbej658cXW8obm0i4//I8IHaQ5cmJSGBXmVTmDvAX8KJnbFd1d/9biRIsmtqzZqyilS8vJUCtoJCg0MJw1j7q92jW8u8m/NZe9+IjQ4fTvHmgIg6IOZRH4n3QpWzKNK2yfgl+7gn74B94+LTALXX0DOWRHOSkQXapCXvNS1sYk3ahqRWiN1wM0DCPe6Tgp81TO51yLXJ5YCf+Tc5bnGqv7TQu+Tce63UolBmZzS8d0+ErTyRAJUbyKmDIVtfyTPdfV6ADOLLQXiIVwNIgCNqC1/dWcXe2WhB/PPz3hC1LSw7ThKegvKhlMEPGLVhHbCvcuZiTwqQLb3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VztuYh9JTTbGzhZaV7Es9JflvqxC4Z0sZmWaQbdXdhL6M4z7aFXUTNg/IMez?=
 =?us-ascii?Q?vW40fz3+trQgleAfnxhwAr7wrhcJG4eo32wfYSS0S2CmYwrlnG6InZcbU+gY?=
 =?us-ascii?Q?7rP5oMOJGyQb4y1odARBXiIBsulKtQ5kbDsQuZuMFPyZVqMP+lOSeUu8DOxo?=
 =?us-ascii?Q?9J6prk3fEqT0A3OqFmULkiUrVEyIwIaVdcPJj+yA42mNgLzE1pC+VZvSghYP?=
 =?us-ascii?Q?eoIo80902M/LkvzPo1EUr4SWEoBZ1ukVzJPrfk2Ga/CxKllSqaI1FXSAIxC0?=
 =?us-ascii?Q?9MMAn1Cy+s5O1IWEacTz6wLi/+nRiSEeM6WOF2+3OS9Bt2XH7EsI1Iumbw5X?=
 =?us-ascii?Q?flTANGUS0TFKKsWC5HUSzGIICw9gLyhEyj8V6fOqDEDLs8J6ub8lDeVAvoyX?=
 =?us-ascii?Q?UVANE3PLDQUXhzbOliJ+UbbEZyUl+hHu3Yt5xusT5hydCSd3Q/WsuAD3C7H3?=
 =?us-ascii?Q?zxCFlMxNMzYAeH3p6ff2t003LeCOYKBQosuU23bQo1BakSrMN2TySL5sZqYq?=
 =?us-ascii?Q?D4Q0g07tZZyYvFqQwh3FhWA5TFPNaeE6QewtgSwTtXxDnE6iUI3inmx4o/FO?=
 =?us-ascii?Q?nW/GzBfdj5eD4EqPcBhfJkRicxUf4dtJR2T0Q5JinPUmlPxHpLPj35JXDPtc?=
 =?us-ascii?Q?HisQVwybnupiEov5xP8fjSjzNpfSiNsQj2oruD2mqRorITx2TPIFWTZm1zp2?=
 =?us-ascii?Q?z5uLNe7+S1hOHcf+V7IK3YHz9GxAkpmtaJwVszBZs4OMkyidaS3QD/cJBwSH?=
 =?us-ascii?Q?LiVDTQLNYrHsFmmPFrRKVRb08M8WSWFGN2kmPEsRLcVIeYkUJIbjsKSrzQQh?=
 =?us-ascii?Q?yxcebeeS257WqfngTiaNXrXbjImrD6yiFUwQ61bniG7kmSdy5JgYQ4hN+fsU?=
 =?us-ascii?Q?BsL50/OQkNhdZhiCZUNX1IWWTY5V/Fn1hkgCa2uekMmGgP5DvRK3gwp1BhNJ?=
 =?us-ascii?Q?R0KiH2wHGqeTWC3AuZwRqoV53w3sO4sdvNVj/vhy+qJk62yqnubACvFDa970?=
 =?us-ascii?Q?aJL8158pDUwzjEcvQtqVVlxePHsmSKSHz/gkV6Baj+ZbvLdmxAGvyZCXF0Q4?=
 =?us-ascii?Q?N6uqHbgegSseYDzghtEI7Les03mGdtMqtNQPobZ34sv8Oz1hQXYbO4mGPIOl?=
 =?us-ascii?Q?4nWTXph43GhQX505N6XyeV4mjmiwYqV25Stv7XE/osIFy3Wx3oilwCV9x6SF?=
 =?us-ascii?Q?KOurfx3ZA+Cj51GEsOyPvlb7Ico4uNs3J+IzrIziMZUxLCBkAeDK6Q/1lM1y?=
 =?us-ascii?Q?HOj4ZSgDccJMwX1HiWfGWGRgbMIloFBG+l3JC5GKQMiFvRtEdDkU1FuO18b4?=
 =?us-ascii?Q?aqwV3CzMd5O4P/E39Tdla6F8eb01njRaIllcjzFexT31/qfOCdPEwftPYO5W?=
 =?us-ascii?Q?DgqH20+soVjjGPGM1yYJ4SpZisUhUBnFOQdZuGgX/4woZl9H8Gi7kjrskBvM?=
 =?us-ascii?Q?Ut/g+ReGZclfCFyOxTR7ypvawciD2Wjp62TFTzhiWojOWa96DLj1/uy8yRm8?=
 =?us-ascii?Q?gfiEWnf4AnPYABzEiuZCEO22wugKI7up0iNGrWikC0FT7+K1TwEsEXICgeew?=
 =?us-ascii?Q?+8t+tD06mAf6fezaAJpWRy1aKGXQQBTaKB+Na3ALy2zCneBmHcrH28ATCI/g?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a64b64-e387-40b9-1504-08dc3156cd11
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:26:46.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGkvKNBtll1E75ibRS8PN9C0bPmseAxIgtei5A5zoSjJ2DQdi6tBB0FquXhfJvht7pNLowBJuiOa9Z1FlSMl3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_mm/page_alloc.c" on:

commit: 3c1b7528d8969a8e89c77cd5eb867503152547b1 ("shmem: move spinlock into shmem_recalc_inode() to fix quota support")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 6d280f4d760e3bcb4a8df302afebf085b65ec982]
[test failed on linux-next/master 2ae0a045e6814c8c1d676d6153c605a65746aa29]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



compiler: clang-17
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



we noticed this issue happens randomly (54 times out of 999 runs), but keeps
clean on parent's 999 runs.

2be4f05af71bb2a9 3c1b7528d8969a8e89c77cd5eb8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :999          5%          54:999   dmesg.kernel_BUG_at_mm/page_alloc.c



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402192250.f71dd353-lkp@intel.com


[  114.132867][ T6116] ------------[ cut here ]------------
[  114.133655][ T6116] kernel BUG at mm/page_alloc.c:1107!
[  114.135493][ T6116] invalid opcode: 0000 [#1] SMP
[  114.136282][ T6116] CPU: 1 PID: 6116 Comm: trinity-c5 Tainted: G        W       TN 6.5.0-rc4-00013-g3c1b7528d896 #1 d8510d08c0d53acf78b29e84223457f938377390
[  114.137918][ T6116] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 114.139147][ T6116] EIP: free_unref_page_prepare (mm/page_alloc.c:1107) 
[ 114.139871][ T6116] Code: 8c fd ff 0f 0b 68 18 2e a2 c2 e8 53 dd 5e 00 b3 01 f7 47 04 01 00 00 00 0f 84 b3 fc ff ff 89 f8 ba 39 ba 59 c2 e8 e8 8b fd ff <0f> 0b 68 08 2e a2 c2 e8 2c dd 5e 00 89 fe 64 a1 08 8d cf c2 83 f8
All code
========
   0:	8c fd                	mov    %?,%ebp
   2:	ff 0f                	decl   (%rdi)
   4:	0b 68 18             	or     0x18(%rax),%ebp
   7:	2e a2 c2 e8 53 dd 5e 	cs movabs %al,0x1b3005edd53e8c2
   e:	00 b3 01 
  11:	f7 47 04 01 00 00 00 	testl  $0x1,0x4(%rdi)
  18:	0f 84 b3 fc ff ff    	je     0xfffffffffffffcd1
  1e:	89 f8                	mov    %edi,%eax
  20:	ba 39 ba 59 c2       	mov    $0xc259ba39,%edx
  25:	e8 e8 8b fd ff       	call   0xfffffffffffd8c12
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	68 08 2e a2 c2       	push   $0xffffffffc2a22e08
  31:	e8 2c dd 5e 00       	call   0x5edd62
  36:	89 fe                	mov    %edi,%esi
  38:	64                   	fs
  39:	a1                   	.byte 0xa1
  3a:	08 8d cf c2 83 f8    	or     %cl,-0x77c3d31(%rbp)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	68 08 2e a2 c2       	push   $0xffffffffc2a22e08
   7:	e8 2c dd 5e 00       	call   0x5edd38
   c:	89 fe                	mov    %edi,%esi
   e:	64                   	fs
   f:	a1                   	.byte 0xa1
  10:	08 8d cf c2 83 f8    	or     %cl,-0x77c3d31(%rbp)
[  114.142105][ T6116] EAX: 00000001 EBX: 00000000 ECX: 8efe0b10 EDX: c29ff294
[  114.142985][ T6116] ESI: 000974aa EDI: e0e80540 EBP: e60b5a87 ESP: e60b5a6b
[  114.143842][ T6116] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010282
[  114.144800][ T6116] CR0: 80050033 CR2: b7026000 CR3: 2c942000 CR4: 000406d0
[  114.145654][ T6116] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  114.146518][ T6116] DR6: fffe0ff0 DR7: 00000400
[  114.147143][ T6116] Call Trace:
[ 114.147648][ T6116] ? fault_in_iov_iter_readable (lib/iov_iter.c:231) 
[ 114.148387][ T6116] ? generic_perform_write (mm/filemap.c:?) 
[ 114.149072][ T6116] ? __generic_file_write_iter (mm/filemap.c:?) 
[ 114.149798][ T6116] ? generic_file_write_iter (mm/filemap.c:4044) 
[ 114.150512][ T6116] ? lock_acquire (kernel/locking/lockdep.c:5761) 
[ 114.151142][ T6116] ? do_iter_readv_writev (fs/read_write.c:736) 
[ 114.151814][ T6116] ? do_iter_write (fs/read_write.c:860) 
[ 114.152403][ T6116] ? rcu_read_lock_any_held (kernel/rcu/update.c:387) 
[ 114.153081][ T6116] ? do_pwritev (fs/read_write.c:933 fs/read_write.c:1030) 
[ 114.153702][ T6116] ? __might_fault (mm/memory.c:?) 
[ 114.154324][ T6116] ? __ia32_sys_pwritev2 (fs/read_write.c:1089 fs/read_write.c:1080 fs/read_write.c:1080) 
[ 114.155004][ T6116] ? __do_fast_syscall_32 (arch/x86/entry/common.c:112) 
[ 114.155656][ T6116] ? rcu_lock_acquire (include/linux/rcupdate.h:307) 
[ 114.156289][ T6116] ? syscall_exit_to_user_mode (kernel/entry/common.c:300) 
[ 114.157000][ T6116] ? __do_fast_syscall_32 (arch/x86/entry/common.c:165) 
[ 114.157660][ T6116] ? __do_fast_syscall_32 (arch/x86/entry/common.c:165) 
[ 114.158302][ T6116] ? __do_fast_syscall_32 (arch/x86/entry/common.c:165) 
[ 114.158947][ T6116] ? irqentry_exit_to_user_mode (kernel/entry/common.c:313) 
[ 114.159660][ T6116] ? do_fast_syscall_32 (arch/x86/entry/common.c:203) 
[ 114.160301][ T6116] ? do_SYSENTER_32 (arch/x86/entry/common.c:246) 
[ 114.160891][ T6116] ? entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840) 
[  114.161534][ T6116] Modules linked in: mousedev snd_pcsp snd_pcm crc32_pclmul crc32c_intel input_leds snd_timer psmouse snd evdev floppy tiny_power_button rtc_cmos processor button fuse
[  114.163575][ T6116] ---[ end trace 0000000000000000 ]---
[ 114.185146][ T6116] EIP: free_unref_page_prepare (mm/page_alloc.c:1107) 
[ 114.185909][ T6116] Code: 8c fd ff 0f 0b 68 18 2e a2 c2 e8 53 dd 5e 00 b3 01 f7 47 04 01 00 00 00 0f 84 b3 fc ff ff 89 f8 ba 39 ba 59 c2 e8 e8 8b fd ff <0f> 0b 68 08 2e a2 c2 e8 2c dd 5e 00 89 fe 64 a1 08 8d cf c2 83 f8
All code
========
   0:	8c fd                	mov    %?,%ebp
   2:	ff 0f                	decl   (%rdi)
   4:	0b 68 18             	or     0x18(%rax),%ebp
   7:	2e a2 c2 e8 53 dd 5e 	cs movabs %al,0x1b3005edd53e8c2
   e:	00 b3 01 
  11:	f7 47 04 01 00 00 00 	testl  $0x1,0x4(%rdi)
  18:	0f 84 b3 fc ff ff    	je     0xfffffffffffffcd1
  1e:	89 f8                	mov    %edi,%eax
  20:	ba 39 ba 59 c2       	mov    $0xc259ba39,%edx
  25:	e8 e8 8b fd ff       	call   0xfffffffffffd8c12
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	68 08 2e a2 c2       	push   $0xffffffffc2a22e08
  31:	e8 2c dd 5e 00       	call   0x5edd62
  36:	89 fe                	mov    %edi,%esi
  38:	64                   	fs
  39:	a1                   	.byte 0xa1
  3a:	08 8d cf c2 83 f8    	or     %cl,-0x77c3d31(%rbp)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	68 08 2e a2 c2       	push   $0xffffffffc2a22e08
   7:	e8 2c dd 5e 00       	call   0x5edd38
   c:	89 fe                	mov    %edi,%esi
   e:	64                   	fs
   f:	a1                   	.byte 0xa1
  10:	08 8d cf c2 83 f8    	or     %cl,-0x77c3d31(%rbp)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240219/202402192250.f71dd353-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


