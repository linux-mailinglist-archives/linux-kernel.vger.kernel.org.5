Return-Path: <linux-kernel+bounces-127280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55389492A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093431F22D20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131EDDAB;
	Tue,  2 Apr 2024 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qqm4FR6+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66188DDA8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024061; cv=fail; b=bgvAbl28dWLqjPRxJvx1JydXcMnLTIU8sNAhWN2pm8l0i9Wrcn1KFdaDgWkG9NVZVNVVp85xPzn7s7B1KEaCQhgEoDnH/v4uemebdgpZggIiX9MAPTyW4QmuEIv69AMP+p7W3LpWdukpDo5fzwaCibzClvqeVyVvr3aGZfySt38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024061; c=relaxed/simple;
	bh=XfJFGOvz2UDGggR35LSP/WQK47WYBaaBl45GmcBe0gA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KhH2/rQO/eFMzOIildcoZr/qra+vS4+Ct31CAdltdqJMTrBWqkoUhvsS6NrVbvJ4Q16nbOsf8ZWbLE5lt1/5XzjZ0VjEGfIEuHyKOOCclWbj3mNRkFmPZD3PAp+1yRpgPlWsE9xo1fd16eFr1Rik802/ZlCpJxFJWRUa6GVmr70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qqm4FR6+; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712024059; x=1743560059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XfJFGOvz2UDGggR35LSP/WQK47WYBaaBl45GmcBe0gA=;
  b=Qqm4FR6+OKaEzGNLr+UrRUOy12s58TGPFcJSKCQZZvo/yOXLUebPWv1A
   PeC6H61F0Lx0Vb3dL5t6rWM++PeIC6iblOiPyGFvf7xV1OdIEh1OfhIs7
   1wy0tOca4hPKymUuperukBMepccucLiw2bm12RfhpcOvDnE/Z2QMRrD7x
   OghPAjEz2SZC6LMtGlmro87YajVkp4SOneBQy0TIOcRSdTBieHFKJhhSp
   eKQRBWQ+/32uNuMkheHHZW/E+C/3vXHkKYllJ5ezmdwGXpC7NfaRZkt0X
   nXn2Ix3Zl0o4v4T4NJ0qjxxORupD6qFFq14Yst/0w+bvBrt73AZMYAtdx
   A==;
X-CSE-ConnectionGUID: xM5QnHyjTz6HTQsroz1A1w==
X-CSE-MsgGUID: W/4bQwPbT2aLuq809uiSQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18531543"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18531543"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22639511"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 19:14:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 19:14:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 19:14:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 19:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/5vBA+ieUuTzPAMPNR/UHhoF80BOP5naBUCW2OzqFj6U9OczgzTOVzhHlAMy1dg9bMYxg7H5VYuKnkrf7H90hCqY0YyBt1v5tD+vBGCHMLpc9vRw54SSByZ2QeEcuq54ToXRrjMJDd53lOK5lFWgr+d/Xsi6MH1i+wMWiC1B+7oMv24QsJscQbagvy7yh6Wy/7owIDTm+9HdMig3naXvPAR1oTti7Erse73ZX2tkFjBrO1i5dcSgJjzTJMRFiQhK/l7oLOBCa0ozuiE/9B7FLy9A5ebVnu1RHDjj3YtFg5MLylKHHRGYY/B08Jjk7mgzIAy/p/J9Yzn/YpGJZ1wRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj08XoTeJ8aQPgYeCdNvf+MSDYhh2KsebQ3rmPrLh3I=;
 b=ih1o52qtlZRgSACQmlkzkG5WItvU1mTvIFojLa31nNqvB+ejfXzcOyTD0P4gZg04giFEEmPRD/YZZ7u919cDXpUvCM0D47FZ2wIYOl4Npqlrnn1dm6LvULRqXSg5p9yorOmQPtIOvZDLbeh7ATcx6x7pPwb5FkEDZJyfeOSQQtzHj3MRIWg78snvdeiloTeUogBCVYqQiF+OLR0r93jv1rW/SgunHnlePQrizM1I6FmEDkYU/Xr54NWjTK+dB/JeKRMIveQc47xuzf6LlbjyKU3wSefXd6zHxSN4S+tAL3EvI9GM4Z/LnfMiq8yR+BoJNZuyExiuaH3eWgvBpy8IVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 2 Apr
 2024 02:14:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 02:14:15 +0000
Date: Tue, 2 Apr 2024 10:14:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar
	<mingo@kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [x86/bugs]  4535e1a417:
 WARNING:at_arch/x86/kernel/alternative.c:#apply_returns
Message-ID: <202404020901.da75a60f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4518:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETuHKVIbsnk23aGWqTmT8TOZVWjL/B38Af3jdFrvQdqaQF0HVlCBTTTyE6dyKlRb8cRPMfm0hRCTtSrJVJK/NX3J0MBgnf/7WVOGOwTxc5h7mSkBIEdF7Y0AhY9+dtqVxK9i/wX+TQDAIe8iETYKbcOeBTnTcyki+5FDda7iGlkOXDNbL1F3AXC3x0utKc9sqNDZ/g6pK6GJL59+74NuKaUzBaJOifvsl0yiVawtNZs2iJuMSILMWTr6VIsRJ60/ZURh0L92vXqBQuvlIDf/mKyDYENTyWjdkBuN0zoozflLwT3oEnDAWirMZ50tyT5PQfQhtOTYwRaKaTzjeZxWWL3tmDnNy5ueDZmmvP38Xc0KiCBUVORpecT+vRLolWcpIcCf3DZRgXeKgQI3RkYf1QV4YunZ3XMKRrriTS7xpEZ/X9mbmzEl3wUWYXVMtkQ11eHppvsIQ5QYdTquNEGYVGci0lwp/Q53waj9S3hS8f2dmgBxYn8Rdff+81bbA6Dbf89zlEGJ2Oxs0viL6dvIg+/Czvye1tkVBk/ykJxzvbqPeHXMb4a9/gn56PtjMxWfGzCqvKxLgMdijy9Kfaa1Rso7mzcygOVDjNIXTHoLUwBIM/ZI0OeAg3yWsVutgISO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g85ZcxkX+to5dQ8qZm7SQT5nZ/UHqiEXMayENeYXQks0g3rvrxO6rKJ8YOkO?=
 =?us-ascii?Q?JxXRQKQ9/ZGCOSufocMhhJMqauQU9ChiGdWdvbCC8SxcumTohvVGdYtrh2Lx?=
 =?us-ascii?Q?HFaI6aYQfiYuhRNy4K+mZDKQ95ibRbfsmLoTSRG0CAfzX9ky4ozbtMwqgC2t?=
 =?us-ascii?Q?JRvbllmVHzFoJW7lONikiiPgnjhHsjAS41jq4ZRapzjm9IMtAk035lcE/B/k?=
 =?us-ascii?Q?CAZLkIgMZTVWTATDpZLYvCahD1uWM6ws7JWUzX1P/2VPaxINMk1KwmCcRnuF?=
 =?us-ascii?Q?5efbzVHLg2M1iMysYWSyVNTP41Ikk4PEr6PN19RsNKDcX/UU9d5nYT7Koiky?=
 =?us-ascii?Q?cvwXej9bdV3po1kg38ALxOiHM9SpXWQsn3LitIsCrWEhv+3hnnFkeMIellNv?=
 =?us-ascii?Q?B4bj/IAx1pRSbyA1B2qha6gzFqWGsYHf7aLtxjwbJsqSuHCvIR90H9/Vm4Dj?=
 =?us-ascii?Q?BahSHCUlLlLZlpSGK6uIREPf1SbvcMPUtiLj+amq6HHmfXeDz/YnfZwgcjr0?=
 =?us-ascii?Q?Kihi3Np/zOGphQkK2hnapbQih7fVunH3DdfCuyMVJPnBqrrKzN3rwuLOCZ/l?=
 =?us-ascii?Q?sMuR7M6asA2r8MChW8zY4yHllu+jJFDmqmjv7hues5rQsKHOf/IK34lUW+mD?=
 =?us-ascii?Q?VP22S7vVhv92TbGMBqaPlwPR84mKeALkKiU5roFGXBWnPYNlsP3i0VUq7Vmf?=
 =?us-ascii?Q?hhpTHPMVrIPBOqMzMIoPfsKuWpaLTH1uvhl6iPKF+wHyEGecitOjVrq6DYeB?=
 =?us-ascii?Q?8Wjs86kkhGgd372+Wpx3V1ycIjGnA/5AC+/5WvT3uIGmwAI21h/pVSWgW64v?=
 =?us-ascii?Q?hDZf9LIes8QqVxPxuwDISP35RGJDSDD+WSXABLTWIcJo3ahN7RCbEw9/B8Qm?=
 =?us-ascii?Q?eHLziTA2sMpBMbOH59m7X5k6WHTc6d0VacbvRZ7UBBdt0mK70kq9g/HvM9aR?=
 =?us-ascii?Q?7s10bTv7tnEQ50wV1XXY5v+HRfFscz0Vu/z59cam6H3hKEoSyPl/VOIodSpj?=
 =?us-ascii?Q?U3tFZ48STBRPxDrcuduU83ZC0zS4sXHy9xTtGxeHMNjMgoBLkoZkN5OGfFbx?=
 =?us-ascii?Q?LMOasuNsGq3Gh33Z1S4194oTFPRpI41hBFny98Y3Ngeb1TEhcSROHTrqEEv5?=
 =?us-ascii?Q?zOZRdAbLR0hK2oO+EAcqXPP7Y0NjIUAFqIDsXX7sn2PqOkNGrXliP34m0fdb?=
 =?us-ascii?Q?+HHECpAGbadf9e4Usnut2cjI1xfgoO/h5lqjTJrFQwZJ7qbV6AKuIgpDz0au?=
 =?us-ascii?Q?jcSqzbSj/QQi9197GrwhAEbZA9rbCMOhD+RghLk9ws8c6f7mu6YtUacSiYkC?=
 =?us-ascii?Q?Tx1tUkh9odAyg4hZb316TOe3mHuP2cBzIluK9Ye4VFYVrp2Chfet2VpUhBoU?=
 =?us-ascii?Q?rTPA0uUGOLY4bRJkXOzq4fJ5w37faLaDVn24rB849ziFedMcTXL+NItgbI3W?=
 =?us-ascii?Q?vN7UmUKV6tECTCb1YbI0PWh1BFBc6Rr2L8QxbkmOulMOgSjEz7Ojy9eyIBaz?=
 =?us-ascii?Q?qtSgPqIkWt3ic68TW0yMnEhfMYsjC0aIdyC1pI6wVTzuep4QzPVMJhEaC2yj?=
 =?us-ascii?Q?6Cy3+KdJwVrq9cbEUlM+SrIiqHSy17IaMMgeBS8erxjiaMlRn63HRliacLex?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bde52ed7-c697-43d8-8437-08dc52ba9808
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:14:15.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Zqbq5UnkTNNTqu8F8/4xhTISocE7/d61TJIQakI57+/1EoY7J3OYKFzwDwZRj6xiFOe5HqThthqVSbdy73aqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/alternative.c:#apply_returns" on:

commit: 4535e1a4174c4111d92c5a9a21e542d232e0fcaa ("x86/bugs: Fix the SRSO mitigation on Zen3/4")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed (WARNING still exists) on linus/master 026e680b0a08a62b1d948e5a8ca78700bfac0e6e]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | 091619baac | 4535e1a417 |
+-------------------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/kernel/alternative.c:#apply_returns     | 0          | 26         |
| RIP:apply_returns                                           | 0          | 26         |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404020901.da75a60f-oliver.sang@intel.com


[    4.454924][    T0] ------------[ cut here ]------------
[ 4.455865][ T0] missing return thunk: srso_alias_untrain_ret+0x0/0x10-0x0: eb 0e 66 66 2e 
[ 4.455900][ T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:826 apply_returns (arch/x86/kernel/alternative.c:826 (discriminator 3)) 
[    4.459866][    T0] Modules linked in:
[    4.460995][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0-rc1-00206-g4535e1a4174c #1
[    4.463858][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 4.466087][ T0] RIP: 0010:apply_returns (arch/x86/kernel/alternative.c:826 (discriminator 3)) 
[ 4.467863][ T0] Code: 6c 08 00 0f 85 55 ff ff ff 49 89 e8 b9 05 00 00 00 4c 89 fa 48 89 ee 48 c7 c7 40 16 21 86 c6 05 70 35 6c 08 01 e8 b9 67 13 00 <0f> 0b e9 2d ff ff ff 48 89 ee 48 c7 c7 c0 15 21 86 89 54 24 20 e8
All code
========
   0:	6c                   	insb   (%dx),%es:(%rdi)
   1:	08 00                	or     %al,(%rax)
   3:	0f 85 55 ff ff ff    	jne    0xffffffffffffff5e
   9:	49 89 e8             	mov    %rbp,%r8
   c:	b9 05 00 00 00       	mov    $0x5,%ecx
  11:	4c 89 fa             	mov    %r15,%rdx
  14:	48 89 ee             	mov    %rbp,%rsi
  17:	48 c7 c7 40 16 21 86 	mov    $0xffffffff86211640,%rdi
  1e:	c6 05 70 35 6c 08 01 	movb   $0x1,0x86c3570(%rip)        # 0x86c3595
  25:	e8 b9 67 13 00       	call   0x1367e3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 2d ff ff ff       	jmp    0xffffffffffffff5e
  31:	48 89 ee             	mov    %rbp,%rsi
  34:	48 c7 c7 c0 15 21 86 	mov    $0xffffffff862115c0,%rdi
  3b:	89 54 24 20          	mov    %edx,0x20(%rsp)
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 2d ff ff ff       	jmp    0xffffffffffffff34
   7:	48 89 ee             	mov    %rbp,%rsi
   a:	48 c7 c7 c0 15 21 86 	mov    $0xffffffff862115c0,%rdi
  11:	89 54 24 20          	mov    %edx,0x20(%rsp)
  15:	e8                   	.byte 0xe8
[    4.471957][    T0] RSP: 0000:ffffffff87c07da8 EFLAGS: 00010286
[    4.473322][    T0] RAX: dffffc0000000000 RBX: ffffffff8a7dd3d4 RCX: 1ffffffff0f99780
[    4.475864][    T0] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff87ccbc00
[    4.477470][    T0] RBP: ffffffff85f20ec0 R08: ffffffff813065f6 R09: fffffbfff0f99780
[    4.479864][    T0] R10: ffffffff87ccbc03 R11: 0000000000000001 R12: ffffffff87c07e18
[    4.483858][    T0] R13: ffffffff87c07e38 R14: dffffc0000000000 R15: 0000000000000000
[    4.485336][    T0] FS:  0000000000000000(0000) GS:ffff8883ae800000(0000) knlGS:0000000000000000
[    4.487866][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.489476][    T0] CR2: ffff88843ffff000 CR3: 0000000007c2c000 CR4: 00000000000406b0
[    4.491094][    T0] Call Trace:
[    4.491866][    T0]  <TASK>
[ 4.492462][ T0] ? __warn (kernel/panic.c:694) 
[ 4.493552][ T0] ? apply_returns (arch/x86/kernel/alternative.c:826 (discriminator 3)) 
[ 4.494545][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 4.495483][ T0] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 4.495865][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 4.496810][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 4.497820][ T0] ? __x86_indirect_thunk_r15 (arch/x86/lib/retpoline.S:231) 
[ 4.499863][ T0] ? this_cpu_in_panic (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 kernel/printk/printk.c:359) 
[ 4.500846][ T0] ? apply_returns (arch/x86/kernel/alternative.c:826 (discriminator 3)) 
[ 4.501836][ T0] ? apply_returns (arch/x86/kernel/alternative.c:826 (discriminator 3)) 
[ 4.502811][ T0] ? reacquire_held_locks (kernel/locking/lockdep.c:5405) 
[ 4.503861][ T0] ? lock_sync (kernel/locking/lockdep.c:5722) 
[ 4.504758][ T0] ? apply_retpolines (arch/x86/kernel/alternative.c:804) 
[ 4.506093][ T0] ? unregister_die_notifier (kernel/notifier.c:203 kernel/notifier.c:608) 
[ 4.507869][ T0] ? __x86_indirect_thunk_r15 (arch/x86/lib/retpoline.S:231) 
[ 4.509312][ T0] ? srso_alias_untrain_ret (arch/x86/lib/retpoline.S:231) 
[ 4.510384][ T0] ? srso_alias_untrain_ret (arch/x86/lib/retpoline.S:231) 
[ 4.511446][ T0] ? int3_selftest_ip (arch/x86/kernel/alternative.c:1610 (discriminator 2)) 
[ 4.511865][ T0] ? debug_alt (arch/x86/kernel/alternative.c:1610) 
[ 4.513050][ T0] alternative_instructions (arch/x86/kernel/alternative.c:1705) 
[ 4.514165][ T0] arch_cpu_finalize_init (arch/x86/kernel/cpu/common.c:2368) 
[ 4.515869][ T0] start_kernel (init/main.c:1042) 
[ 4.517000][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:495) 
[ 4.518085][ T0] x86_64_start_kernel (??:?) 
[ 4.520060][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    4.521097][    T0]  </TASK>
[    4.521858][    T0] irq event stamp: 197308
[ 4.522913][ T0] hardirqs last enabled at (197316): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2731 kernel/printk/printk.c:3050) 
[ 4.523863][ T0] hardirqs last disabled at (197333): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2731 kernel/printk/printk.c:3050) 
[ 4.525769][ T0] softirqs last enabled at (197331): __do_softirq (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:583) 
[ 4.527861][ T0] softirqs last disabled at (197350): irq_exit_rcu (kernel/softirq.c:428 kernel/softirq.c:633 kernel/softirq.c:645) 
[    4.531857][    T0] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240402/202404020901.da75a60f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


