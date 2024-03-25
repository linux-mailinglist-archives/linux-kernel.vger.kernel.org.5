Return-Path: <linux-kernel+bounces-116609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13A88A110
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE7C1C37326
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226271B53;
	Mon, 25 Mar 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mImgcIZV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC2178886
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350136; cv=fail; b=ipCHiezdRp/0yo+wECA5bo+h8lARiL72FKzejHOuI9k4bjUPCVXDjsTmUmoiwMCCmKnotjd3BFFjfI/b7vW/timclsoLYK1j/GpaYOYGwmLZwme2NYZnyD3DcZLZ1EkwRmhj86+zg0XEUDlQ42Hk/1TKrAJAtWs2zDXeGwtJmsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350136; c=relaxed/simple;
	bh=y+ZuvqWD2zTbWxkeiwKNa1iaAB60XxW08OVr4B6A2zs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ISqCbxP/yDcyaS+d/LdrnTbX5XeJ6Q4C6yIxl1NIz6e1r4tOkYJGGfrxfMcLsRHz/K7wynuJ9KvWqpwbbqlE6NkVh8CyWrTwK4Vxcv6twYGWPGRlLlFG8JWiigv3JGgBpZ6K7RomqnSCLbLmkOZbz82j3e1G6u6L5pxS3Kpmfrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mImgcIZV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711350135; x=1742886135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y+ZuvqWD2zTbWxkeiwKNa1iaAB60XxW08OVr4B6A2zs=;
  b=mImgcIZV+MKil9mt80GFsKBmztgiWxKj/V1DKNWQQG+qivPX4TqWZwm/
   ahN22ONY/sEJDmn+84S4xr8GY150k/4VKyzQ3lSnDilHKQozUyIGwzEko
   UQI+heK22qGYneWBB3OZChUPcNSHOpiv5veY5qzpsSvkSBhbSRNscqRsW
   lZEE1at5bfWo2R+4sGlJ9nsICj+u0lLukyMxo4az4sWUNe3BSHrLuBohJ
   bzYpbpVkf0QgveVCZWGbj9/Ez4nRk1euBbIT+/K05g+ggT/aqrthKy8FL
   /+kroCcj9Z+4FNGjUPTKm4LKLJyUWx935an/HJVjgzqYg2iiulND1Tcn8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="16878982"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="16878982"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 00:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15542236"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 00:02:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 00:02:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 00:02:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 00:02:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 00:02:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNpx2KujHA/Gz6gJGpLEIZ9YKRWxilPhra5SP+8UZzpXpbp+bZa9e5fdPc6BJ9UeKMayXMLl59ozlVtfs04/rTT88ZMn4va5xBnpF0QsAq9ujncxNmftaW7qLh2V9lACApO4VF5Csnsrq80HCRMjUoQiUlQsEAD+Amizamfee+cakKahAaif7AhoiQDMnsNqMSXBy7u7vqrBOV29Qn8+zJvMuhPb4cvPjxeYa8801xKaeUhYodNYCXkbk2HX2fODvsqYRxo0mRhiC98LyU1uBcyEoVQ53lw40g/3XLiRPmF4KlmMS8yJPgfxAZMJcHtsZ2jhjbUxHOe/WaK1qUSaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNasrGHLamHWACLLNE55HHGLuqqO+kbVMqH32wk5Ffs=;
 b=j4+2SyaOCV70ECsNoU5CIFyfpFDNAEMEFqwXQZEYSceJBEHpnQ7I3XkC0Z1s56Z2V7exA36ffxIt6OG0LfFlVII1vZcWXE9XfOexT1FKsZydErQ7H/aegiI0GYDObNU6xwy1CdjHKBUY9wD2/lpaFQCIyb0hivXPh0tvmKpzCpgmIc19FZ9CzKBdstoCRQcC6CLGOKOJLHWShq30LojbSOHCaSSumTVMA2YXeLYHUZKtHYsT1L0y/wWJcxzcrKx18Z26BnLKVIVMxxNvJ8RcBocfQjOTMbhyZZw7YCgrd9AgDHPMT7BUvRbar0cUlGiOsmRLXsVI9GgwOdtHn3t3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:02:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 07:02:05 +0000
Date: Mon, 25 Mar 2024 15:01:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>, <oliver.sang@intel.com>
Subject: [linus:master] [x86/retpoline]  4461438a84:
 WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk
Message-ID: <202403251454.23df6278-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV2PR11MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 3affe4ac-8764-4f41-9c7c-08dc4c997a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WKEJtRMogcEIK03KYhk0zt8T+YkFbAezt/PvKmobb3rDVV7xqKUNw0jHbX/WCho7zuR2D6ERMB8CYUmeqoct3cbkodp37/8reXo0JXM6gWdjwOxJPMNkjm1OUZX3OFT83iU/Hmh2/6bVH/4nANiYLX4s2xredDcTVyA1ayrPE8TmlxuHtr99DZxQsckvtmHsm6JOLtxSJS6VxgxIuwWgsE8fkzQEKCwn0Lh+lBrrkMSA/1ZHV4VFCWo2ERyMWgcX/UXc6bMX6eGhl4Pwkds/s/SL9GELQ3HKGvkD1y/B5zdSHvQ3tw1r/NLKPyQO71OerH7ljhiOKW4ihheIo7dtC/E5EyJAQ+H2Jy5KHSi44ZHhKD/CVRm4+IbmpXAusQAikP4rIpsmHm63JW2SOH9twzUjkbM4K6xB3NzcNx/5xWn9eH18wboKLjaNOGe1MD26oroCrb5N/XNCRSXTjKQViM4sp/KBmOPoBbmubkkqVFMNBnGWKIPIVtcpcGhOxjJvFL19mKMihAbKaOdvhG2qgFyNxWNWuZRxE8zJLUz3BGu9vHhU4rOUV4PoGU9zGcI99yGt00xA70Y2/ADQ3Q7THQj+qew3FH59oOVUNOb7Zzs4Se14+PMf7SI3m4psAII
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+i5Iq88Nd52jEW3oS6PokPETxA9F95+CIKgwlxeFodxeFQRzDV1IGpYUuFGk?=
 =?us-ascii?Q?vqLIk0ll9EDGgLk4HsXW8wUwGOarcL+gpFmoeGW/HDbli7GkbgjkwaMa5W77?=
 =?us-ascii?Q?lbCkJ1QMJ1UWpLcyW7gq/0urhOu/Q8E/WcQKxoAU5CuEWq7fG8EXVuGZk9hu?=
 =?us-ascii?Q?ji5Go+6M/stHVWiuWwpgSJ0Ijz4f9gJkvE//+9uOshGPdKBrEUD53pAOaloz?=
 =?us-ascii?Q?pSgXO4ljGBThypl4E9/AeYWR6U2uaTJ23AkVCDiCKXiFoi9bdNxwiIvS5nGV?=
 =?us-ascii?Q?ei5Q4io+FCN59MkS4oReahI8D6h0gSTBB+sWHo+EH3lskj1BFouFSODYkwwc?=
 =?us-ascii?Q?2Po7GA027G6tN/lXg6Z+Moek7evnNsbr19aaBVwS3a3HpkY0kqOjSPuJgXxn?=
 =?us-ascii?Q?THYl3au/ISrI542iEWnSBkVx4NtgpEqpofvs4h3ftwFj0Ef4o4fg/xhk7A7H?=
 =?us-ascii?Q?QWEDJSy4s71ZlPUf+2jO0kU1zrNViN5N3GX1hvoT/ybbTHXY8rkonMbrNFpA?=
 =?us-ascii?Q?Tu+re1ndMPok6Cgfd74YAktWqvYd9BAPylcXz6Zs6faNASgHU4be1duHAr7v?=
 =?us-ascii?Q?10iFhjIhvm9ss62wlsdkGaAiq9tf8PxA5h6oJaZJogH21D19bdBcpcgusyP3?=
 =?us-ascii?Q?O6wlRxpt6Kbsf7vwQAs0wEJSp+W2geOQJb0zWll7Uvgm92ePDhpTm2T8y2FM?=
 =?us-ascii?Q?/CnvJMuGLFfYhed9zdEkemlk9aEkYnfIXzT0bb9pwIfUTAkijrrCOUAax5WN?=
 =?us-ascii?Q?WxYdxwIBFavjjw5c1sZof1N9WaMhsT16qA5/fi3YW4tW9F+dZkaAi6ck0lbv?=
 =?us-ascii?Q?S9uP9f7d81Az8AAC1qBTLwyW6NSsJii46rkPKmUn74ciI3xBMRPoCLsXAsSc?=
 =?us-ascii?Q?w3RtH2aeldgrSvzmTw/9iaoUR6EDiY6ETP9u1ROCOBnMgAWGom1ZJLo3sJrU?=
 =?us-ascii?Q?KdpJEV4BtqxuPIzJbicaRDRQCiuaa5tEhOHsy+BuJHt1ny+frCpOoc3XENBf?=
 =?us-ascii?Q?RIkFsUOV5vTMVrrU48ECUxVTgv+znAHZMkVuq7Meb3XpBgGA7FW04nU5uz/Q?=
 =?us-ascii?Q?7GvSeXEq3OpND8AlRbRoEd/XCg2yNBQ8lKJeHOcToh9thm3lnA9dWa3azFGA?=
 =?us-ascii?Q?7VOOgg/+aQjhkQvCrfjR7bTbXi89pgGAkWVcIVMiTN/+qZ2WrdyB930Il9IG?=
 =?us-ascii?Q?OljYvJAdPHLTbxgYHMZJR9ZthMfu/Dlu6Icj8jz6Z+4liZwIWUkpZMWk4NWf?=
 =?us-ascii?Q?mKC2//d9nX9iTPb0iu1Wl5YnGOwGJTBuiJw4msHejoz0pDrqejLM/IjZi7Av?=
 =?us-ascii?Q?IhemVV/Ycg5OfiRhB7Ll4we5lVr7zxlMr+04+HUbEllABOISyux+Q4TiGNiZ?=
 =?us-ascii?Q?SSFAObZ856J5ODDl5gYzhjnUC+KDEBHD/xqkaH4PzpQOLDqKW8XWzn6cl4iZ?=
 =?us-ascii?Q?mvpzMeYE7DC1OlwrLPXn1dtScMKUWclNL96Vi7jQ7m5X9lNoF7E81ODtlqk/?=
 =?us-ascii?Q?o39WsFCHp5saIaYL03EEc4EM0xn28UOdGoPRM0wT5rp0QZ9Sf9Oajr/5hOdJ?=
 =?us-ascii?Q?65TT4+BuuREU/yz0Vu5fkq2dBsnGN8JFHln+j7yKp7IapR9vdH/Kjq2GEFbd?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3affe4ac-8764-4f41-9c7c-08dc4c997a96
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:02:05.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOZBq8pLKEaAWY8nFN3kLbtRswTs17W1pXCQfC08bbmefb2A2tUh2FN6y19y+BIdiFLaxm3V+KkFa4nVqJ5BLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com


hi, Josh Poimboeuf,

the WARN_ONCE added in this commit was hit in our tests. below full report FYI.


Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk" on:

commit: 4461438a8405e800f90e0e40409e5f3d07eed381 ("x86/retpoline: Ensure default return thunk isn't used at runtime")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master f6cef5f8c37f58a3bc95b3754c3ae98e086631ca]
[test failed on linux-next/master 2e93f143ca010a5013528e1cfdc895f024fe8c21]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------+------------+------------+
|                                                     | 0911b8c52c | 4461438a84 |
+-----------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/kernel/cpu/bugs.c:#__warn_thunk | 0          | 24         |
| RIP:__warn_thunk                                    | 0          | 24         |
+-----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403251454.23df6278-lkp@intel.com


[    8.964931][    T1] ------------[ cut here ]------------
[    8.966085][    T1] Unpatched return thunk in use. This should not happen!
[ 8.967448][ T1] WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:2856 __warn_thunk (arch/x86/kernel/cpu/bugs.c:2856 (discriminator 3)) 
[    8.968229][    T1] Modules linked in:
[    8.969058][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                T  6.7.0-01738-g4461438a8405 #1 e41218aca9131c31f31eb52746294819f64dd29b
[    8.971429][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 8.973422][ T1] RIP: 0010:__warn_thunk (arch/x86/kernel/cpu/bugs.c:2856 (discriminator 3)) 
[ 8.974508][ T1] Code: 90 90 90 90 90 80 3d 75 0e eb 04 00 74 05 c3 cc cc cc cc 55 48 c7 c7 c0 da 02 84 c6 05 5f 0e eb 04 01 48 89 e5 e8 db 0d 0e 00 <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	80 3d 75 0e eb 04 00 	cmpb   $0x0,0x4eb0e75(%rip)        # 0x4eb0e81
   c:	74 05                	je     0x13
   e:	c3                   	ret
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	55                   	push   %rbp
  14:	48 c7 c7 c0 da 02 84 	mov    $0xffffffff8402dac0,%rdi
  1b:	c6 05 5f 0e eb 04 01 	movb   $0x1,0x4eb0e5f(%rip)        # 0x4eb0e81
  22:	48 89 e5             	mov    %rsp,%rbp
  25:	e8 db 0d 0e 00       	call   0xe0e05
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	5d                   	pop    %rbp
  2d:	c3                   	ret
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	5d                   	pop    %rbp
   3:	c3                   	ret
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	90                   	nop
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
[    8.977710][    T1] RSP: 0000:ffffc9000001fd48 EFLAGS: 00010282
[    8.978937][    T1] RAX: dffffc0000000000 RBX: 1ffff92000003fb7 RCX: ffffc9000001fb60
[    8.980510][    T1] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffc9000001fac8
[    8.982147][    T1] RBP: ffffc9000001fd48 R08: 0000000000000001 R09: fffff52000003f59
[    8.983731][    T1] R10: ffffc9000001facf R11: 0000000000000001 R12: ffffffff85fdbcf0
[    8.985364][    T1] R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc9000001fe38
[    8.987025][    T1] FS:  0000000000000000(0000) GS:ffffffff850d2000(0000) knlGS:0000000000000000
[    8.988184][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.989452][    T1] CR2: ffff88843ffff000 CR3: 00000000050a6000 CR4: 00000000000406f0
[    8.991078][    T1] Call Trace:
[    8.991825][    T1]  <TASK>
[ 8.992516][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 8.993382][ T1] ? __warn (kernel/panic.c:677) 
[ 8.994235][ T1] ? console_trylock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 kernel/printk/printk.c:347 kernel/printk/printk.c:2612 kernel/printk/printk.c:2657) 
[ 8.995222][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:2856 (discriminator 3)) 
[ 8.996179][ T1] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 8.997120][ T1] ? vprintk_emit (kernel/printk/printk.c:2303) 
[ 8.997962][ T1] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 8.998826][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 8.999813][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 9.000845][ T1] ? ia32_binfmt_init (kbuild/obj/consumer/x86_64-randconfig-a005-20230528/arch/x86/entry/vdso/vdso-image-64.c:508) 
[ 9.001794][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:2856 (discriminator 3)) 
[ 9.002723][ T1] ? __warn_thunk (arch/x86/kernel/cpu/bugs.c:2856 (discriminator 3)) 
[ 9.003698][ T1] warn_thunk_thunk (arch/x86/entry/entry.S:26) 
[ 9.004689][ T1] ? apply_alternatives (arch/x86/kernel/alternative.c:508 (discriminator 156)) 
[ 9.005745][ T1] ? optimize_nops_inplace (arch/x86/include/asm/irqflags.h:42 (discriminator 1) arch/x86/include/asm/irqflags.h:77 (discriminator 1) arch/x86/include/asm/irqflags.h:135 (discriminator 1) arch/x86/kernel/alternative.c:264 (discriminator 1)) 
[ 9.006664][ T1] do_one_initcall (init/main.c:1236) 
[ 9.007562][ T1] ? __pfx_do_one_initcall (init/main.c:1227) 
[ 9.007960][ T1] ? __pfx_parse_args (kernel/params.c:171) 
[ 9.008957][ T1] ? __kmalloc (include/trace/events/kmem.h:54 mm/slub.c:3982 mm/slub.c:3994) 
[ 9.009894][ T1] ? do_initcalls (init/main.c:1308) 
[ 9.010835][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 9.011777][ T1] kernel_init_freeable (init/main.c:1555) 
[ 9.012872][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 9.013875][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 9.014892][ T1] kernel_init (init/main.c:1443) 
[ 9.015752][ T1] ? __switch_to_asm (arch/x86/entry/entry_64.S:203) 
[ 9.016746][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 9.017637][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 9.018667][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[    9.019632][    T1]  </TASK>
[    9.020297][    T1] irq event stamp: 0
[ 9.021144][ T1] hardirqs last enabled at (0): 0x0 
[ 9.022509][ T1] hardirqs last disabled at (0): copy_process (kernel/fork.c:2439) 
[ 9.024326][ T1] softirqs last enabled at (0): copy_process (kernel/fork.c:2440) 
[ 9.026138][ T1] softirqs last disabled at (0): 0x0 
[    9.027536][    T1] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240325/202403251454.23df6278-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


