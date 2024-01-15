Return-Path: <linux-kernel+bounces-26077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C423D82DB18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F01F2277A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520D17592;
	Mon, 15 Jan 2024 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jI6jrBTi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79217586;
	Mon, 15 Jan 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705328070; x=1736864070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j+3JcWO0BYyNCD06ksazGEx0eILzyYsLFlgkk1u/hfo=;
  b=jI6jrBTil+69/og+PCeihrSFldDA9p3T1msRtDqQD4DQMvjLgXoguhdg
   igYkFrPxIU21MX6XcCmbSozX0LefYvw6IEX2J0rhJiAmwDsL0Z4h9UDMm
   0E/m447A6n6kTFs6ixaLDHwn30PfpkKthZpRrtdsWAuAkcBIi1wG1zbbd
   hK388rQzBWcOR93qdisf22g68tKSGQbagVBDuD5bJ8IuVbRPU0EAft5om
   +hszVyCi5FtAlekqgvybk/azsQ00IZdaCIz1BynHORxHo/xAOtDTSra6g
   qOPuL0OJpnVY+jlnbH9vhaTviCBAHVryJNhxoneEdFA6qTRUHXVxr2UaJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="21099974"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="21099974"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 06:14:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="956835423"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="956835423"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 06:14:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 06:14:27 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 06:14:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 06:14:27 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 06:14:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE1EDL4IPuUueqOUxF4DnPdS5ytNaYPqyEnl0nlTY2rkihH9UFkVdMhggf3Oj301reHy9nGR/ii8opewEhx9pO/O/VFqPRJ8RZmsXrIuIMoeGQea3MEqYT3Dq0Fy6GhsEf9iXMb5u4umj2lcv6TJQiIgojAThsXEIIs/8poOTcqbMwzY8QCRTrae8sRI2+N5EVXqDGmX817XCsmWUHQyeOPVhJyosl4sc7yiclHWCI8EHBJnsQl6+I2M0Wt7BPiadYhX8PaOkkGI55TGUngyAVNqQJ3xRVSEblItHieT4BtvuzQ2gvoWLy2MDMppozHu1K7t/XUGx3gXn/MtJ2FvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbSC/pt4096+oDOi0KbCILHZofj9u2hait2DyuFewKE=;
 b=h73+Rx8uoOl5zZsMAFqpNwNfYiStxh4XX0JJ10zOZvKAru6gJOWNGmKypN8ryhTLhHaASB8BHsyjWMbYGCM+WCBAl+3qLDv3wy3XN0roGuxM/Qhu4+ishuSK5acbU8vaqoqiSbTg38Ptu61dM4jG07kchqN11/5x/kxKg/Q5Mxiiy09Q+a/jLP3101hkvJI3AcRKVdNr2YqtUJYUlnqT6Ss9VRTUubw+R68L2Lf+4m2dckAio7WtG/EI1kob/SgiAPg9j94EL2uS7PhaD8tyHiwnQWRI/T1V7zh5Sia5zju7rfmxXVPWwLwT4WkU5sKJz2gy+Ps2t41strWowibplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 14:14:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 14:14:23 +0000
Date: Mon, 15 Jan 2024 22:14:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ajay Kaher
	<akaher@vmware.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [eventfs]  493ec81a8f: kernel_BUG_at_fs/dcache.c
Message-ID: <202401152142.bfc28861-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 700003a4-d816-4d31-836d-08dc15d445c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4AaA91zTcbEx90VyY4R9msU2SH6f9s8/9xvow8ghj18L5PBNMQzvNqQ/jadKWg1MmJS2kFtIwkMcs48TuU+7jjLlS0tLxD9GP1lJLhKasXyUdd+cE7rYMJhYDxjPsnudz6WjQSx92NSReWB3Hlan1tEBkewmioiA5HCALWT1cdFWm9ipaYUm9Z6hQO7mUguF3rzraAI0VxnUh2mIv3yBZz8Kh7O08OpZDiE5+f0EKR2Vnu6E7na2mcbrCfEjOJyjwUsPFPXR3XgaJ6E+bXmwvSHI2R7wKC/FmywR6NpO8ytAX9vfTmw2DsYZwJ9qnZuI7ScGBR2SLX7KrEcm83WwIDfUF+qu23SL1D1NNFhwXjaP4KrfhMtATxvZeIFRzvGWID84ZM6Y9v9396jcGP7phXim9yss+lQDZr0Ey3CbgiSoMO/LzuFmQRZ5CV93loC3OWdvRtYOVhmQ6CYFFaFy26RBo+fdF/hC43GxUMgOi6i1AqYlJZdYCA12J0YzJv1d55wLQLDrgVqc4B1LrrirfzNk5aViqIv/HG4AFUtpa6sXVMhFP2/wx938HbrzOjc7XD0VV+EvPYtLaAnHrlPQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(107886003)(26005)(2616005)(1076003)(66946007)(38100700002)(5660300002)(6512007)(8676002)(4326008)(8936002)(316002)(41300700001)(7416002)(66556008)(6506007)(6666004)(478600001)(966005)(6486002)(45080400002)(66476007)(54906003)(6916009)(2906002)(86362001)(36756003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cElPoJHdN+eho18DOwXGwAu6ATmTqgpZbWjiIkEoBxhLG7Y0uEzLHQBe6v07?=
 =?us-ascii?Q?lAasTnnW9Sfst4awxuAj7zzk6qlybnt2MHhc6/DJALaWkyVQlntcgqgzzfpy?=
 =?us-ascii?Q?Z3LVdQbIy66/E0j35Vr+ZRvyNYEFaToiiJscjzbdv/Na6SBisE0s+0soDnz+?=
 =?us-ascii?Q?tGOZFX3X1pZoa6EMKDJLApEuBSIdSDXF1swFkk187AXBjl+ba/omBFo8zYwE?=
 =?us-ascii?Q?5IUO2HKNtun4QjMFwwdfQN5EI4+u4LiZ3pfUpOQNI3duAJSc/yxX1LdwurQK?=
 =?us-ascii?Q?EXEVTken/3Mzadp5B7Ademi+evt4QXv63iJ4GAIKR225BmSf+BuwcNnsTEU8?=
 =?us-ascii?Q?ToRvD3eliCMImlEsF7WcNflxEBsJZqvO3v7NQ4wfbO7flpYQSHChjuOxtB5a?=
 =?us-ascii?Q?h4w45Bwdt/gmFLoxEu5XgOHFcmq7Fw9dV5NIM0Dl5bCiSPVOrkFdXjQqujiq?=
 =?us-ascii?Q?ucCaN9fRsxNu2v5Fj8SbV3QZm/34dLTUUq2xv4uSY5fXvfp6JgmdQkU6B+ui?=
 =?us-ascii?Q?N+NJFwu0TrRxc2GGAnTW3e9JlJ3/Bj/eYuEsbiPMW/uxhpmAaSA/cwlMHB4n?=
 =?us-ascii?Q?OWo40lI9vYsigqjX+Rn+t7qtL2GimdOC0tVU5yIy5jPwC8AfLt5EVZSZwjHG?=
 =?us-ascii?Q?Mk5+7n1pWR86Hvvno5xTk5KMZAcGzsR5OhdQX1Sm6gpuBUlXAPrq72At6o8G?=
 =?us-ascii?Q?OmyfLYiC0C9pukDSGyJ52ppjobGQI93fJO6S1I3AhxQZQyZhMnJeEjDMFPo4?=
 =?us-ascii?Q?d9VpKeLPSRlVvZoPINuJOiZSwzmnMeQSfjCbEaYu/6+CXJOmeVB8O72H7SPy?=
 =?us-ascii?Q?eE94XnsnGh/DilqMsszoX81DaznnY4oet0OkgzOdlbWsZkKeMAm/zew80vOK?=
 =?us-ascii?Q?ot6pUGnA841vHgXr71yIpUxuEJQxIgLQRI1EmtnxDoXthyzWiKJ03ee7bMkh?=
 =?us-ascii?Q?v8Frf/6YRZapBpQ5GBXYJT4aJ7aTwp5czj83+fqXjjzkLF4EJWOLGkGp4ISb?=
 =?us-ascii?Q?DcDpIZDysBTBT4NLlVEDT7dLV0lCusm6/9refUoklSfc97OCbahGbWhnBQN4?=
 =?us-ascii?Q?nxAv8yVRCGpouknZZOJObRkgmZH4nhva2Q6jB6yDnEePI3CyTGU0Yc9PMC9y?=
 =?us-ascii?Q?K6uymMGuqvdMjnAbCHwEgdYjHtA3ev/qYrC5O8UuFynhcsPgjDTKjjnBLCDE?=
 =?us-ascii?Q?hFVfvCYZLfKSr72O6FzvOHAcbW9uAlfokZfFclnDGyCtnydc6R+Ha2Y0Tz+u?=
 =?us-ascii?Q?bnx/lcKaSz5hzAnTWFEUuJ4kzmnb0jp4D1emFCZq0rpzNelrUH+jFa5caXRC?=
 =?us-ascii?Q?RrKmZhYoHXvZK3/+4MKD9q5yIrXJ2JXK8rr6x10UDlHQba9DPJWFi7lc1yqL?=
 =?us-ascii?Q?xXTAoRDPCUlmmUw+qSiA/6njPQPkRYiH9vwN6sn1fOqYDBDbr3O6jSjPC4E2?=
 =?us-ascii?Q?yKFi/u0gzjmXaG2raGKIqpNnaFjJpRSKzS2/d0R7LsrEQeCOatNHW0Q7PeCP?=
 =?us-ascii?Q?p9Z+ImVmmYDPW84Q1XHGqqAC7EM5MFxEUbBYPtj4CoUEs0UNyw+IfiQ9Adn5?=
 =?us-ascii?Q?Mg1xyliyL48iszvnEEFsYEs/pKn0m559KWD8Eh6MgL2MOER6wL6v80zQtJaT?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 700003a4-d816-4d31-836d-08dc15d445c5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 14:14:23.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qlCi4WWEguCyyfXozoBt70FkjeOSgTxOXjfHJV4kAPb3G8UHQOwQP045TowTKogXZ65CxGDDLvnzOp6D62tzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_fs/dcache.c" on:

commit: 493ec81a8fb8e4ada6f223b8b73791a1280d4774 ("eventfs: Stop using dcache_readdir() for getdents()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 8cb47d7cd090a690c1785385b2f3d407d4a53ad0]
[test failed on fix commit 1e4624eb5a0ecaae0d2c4e3019bece119725bb98]

in testcase: stress-ng
version: stress-ng-x86_64-3040a078a-1_20231212
with following parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	class: filesystem
	test: getdent
	cpufreq_governor: performance



compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401152142.bfc28861-oliver.sang@intel.com


[   41.602502][ T4375] ------------[ cut here ]------------
[   41.602519][ T4376] ------------[ cut here ]------------
[   41.602607][ T4374] ------------[ cut here ]------------
[   41.602607][ T4378] ------------[ cut here ]------------
[   41.602608][ T4374] kernel BUG at fs/dcache.c:2031!
[   41.602608][ T4378] kernel BUG at fs/dcache.c:2031!
[   41.602613][ T4374] invalid opcode: 0000 [#1] SMP NOPTI
[   41.602616][ T4374] CPU: 50 PID: 4374 Comm: stress-ng-getde Not tainted 6.7.0-rc2-00042-g493ec81a8fb8 #1
[   41.602618][ T4374] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[ 41.602619][ T4374] RIP: 0010:d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
[   41.602623][ T4377] ------------[ cut here ]------------
[ 41.602623][ T4374] Code: e8 92 c0 1c 00 4c 89 e7 e8 0a 79 b8 00 48 89 ef 48 89 de e8 7f fc ff ff 4c 89 e7 c6 07 00 0f 1f 00 5b 5d 41 5c c3 cc cc cc cc <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00
All code
========
   0:	e8 92 c0 1c 00       	callq  0x1cc097
   5:	4c 89 e7             	mov    %r12,%rdi
   8:	e8 0a 79 b8 00       	callq  0xb87917
   d:	48 89 ef             	mov    %rbp,%rdi
  10:	48 89 de             	mov    %rbx,%rsi
  13:	e8 7f fc ff ff       	callq  0xfffffffffffffc97
  18:	4c 89 e7             	mov    %r12,%rdi
  1b:	c6 07 00             	movb   $0x0,(%rdi)
  1e:	0f 1f 00             	nopl   (%rax)
  21:	5b                   	pop    %rbx
  22:	5d                   	pop    %rbp
  23:	41 5c                	pop    %r12
  25:	c3                   	retq   
  26:	cc                   	int3   
  27:	cc                   	int3   
  28:	cc                   	int3   
  29:	cc                   	int3   
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  33:	00 00 00 00 
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)  
  3c:	84 00                	test   %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
   9:	00 00 00 00 
   d:	66                   	data16
   e:	66                   	data16
   f:	2e                   	cs
  10:	0f                   	.byte 0xf
  11:	1f                   	(bad)  
  12:	84 00                	test   %al,(%rax)
	...
[   41.602625][ T4377] kernel BUG at fs/dcache.c:2031!
[   41.602625][ T4374] RSP: 0018:ffa000000fcdfcd0 EFLAGS: 00010286
[   41.602629][ T4374] RAX: 0000000000000002 RBX: ff11000109392980 RCX: 0000000000000000
[   41.602630][ T4374] RDX: 0000000000000000 RSI: ff1100405e46c6f0 RDI: ff1100405f05afc0
[   41.602631][ T4374] RBP: ff1100405f05afc0 R08: ffffffff830ad0e0 R09: 0000000000000000
[   41.602632][ T4374] R10: 0000000000000280 R11: ffffffff8162036a R12: 0000000000000000
[   41.602633][ T4374] R13: ff1100405e46c6f0 R14: ff1100405f05aff8 R15: 0000000000000000
[   41.602634][ T4374] FS:  00007f2582ff9740(0000) GS:ff1100407fa80000(0000) knlGS:0000000000000000
[   41.602635][ T4374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.602635][ T4374] CR2: 00005624511f3328 CR3: 000000208a342006 CR4: 0000000000771ef0
[   41.602636][ T4374] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   41.602637][ T4374] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   41.602638][ T4374] PKRU: 55555554
[   41.602638][ T4374] Call Trace:
[   41.602640][ T4374]  <TASK>
[ 41.602642][ T4374] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 41.602644][ T4374] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
[ 41.602645][ T4374] ? d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
[ 41.602647][ T4374] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
[ 41.602648][ T4374] ? d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
[ 41.602649][ T4374] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
[ 41.602652][ T4374] ? d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
[ 41.602653][ T4374] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 41.602655][ T4374] ? tracefs_alloc_inode (fs/tracefs/inode.c:38) 
[ 41.602657][ T4374] ? d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
[ 41.602659][ T4374] create_dir_dentry (fs/tracefs/event_inode.c:329 fs/tracefs/event_inode.c:516) 
[ 41.602661][ T4374] eventfs_root_lookup (fs/tracefs/event_inode.c:611) 
[ 41.602662][ T4374] ? terminate_walk (fs/namei.c:691) 
[ 41.602665][ T4374] __lookup_slow (fs/namei.c:1694) 
[ 41.602667][ T4374] lookup_one_len (fs/namei.c:2746 (discriminator 1)) 
[ 41.602669][ T4374] eventfs_start_creating (fs/tracefs/inode.c:536) 
[ 41.602671][ T4374] create_dir_dentry (fs/tracefs/event_inode.c:309 fs/tracefs/event_inode.c:516) 
[ 41.602673][ T4374] eventfs_iterate (fs/tracefs/event_inode.c:701) 
[ 41.602674][ T4374] ? atime_needs_update (fs/inode.c:1842 fs/inode.c:1994) 
[ 41.602677][ T4374] iterate_dir (fs/readdir.c:106) 
[ 41.602680][ T4374] __x64_sys_getdents (fs/readdir.c:323 fs/readdir.c:307 fs/readdir.c:307) 
[ 41.602682][ T4374] ? __pfx_filldir (fs/readdir.c:260) 
[ 41.602684][ T4374] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
[ 41.602686][ T4374] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   41.602690][ T4374] RIP: 0033:0x7f2583190f29
[ 41.602691][ T4374] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
All code
========
   0:	00 c3                	add    %al,%bl
   2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
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
  33:	48 8b 0d 37 8f 0d 00 	mov    0xd8f37(%rip),%rcx        # 0xd8f71
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 37 8f 0d 00 	mov    0xd8f37(%rip),%rcx        # 0xd8f47
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   41.602692][ T4374] RSP: 002b:00007ffe038f3e28 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
[   41.602694][ T4374] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f2583190f29
[   41.602695][ T4374] RDX: 0000000000001000 RSI: 0000562451159150 RDI: 0000000000000008
[   41.602695][ T4374] RBP: 00007f2582fcd398 R08: 00007f2582fcd398 R09: 00007f2582fcd398
[   41.602696][ T4374] R10: 00007f2582fcd398 R11: 0000000000000246 R12: 00007f2582fcd398
[   41.602696][ T4374] R13: 0000562451159150 R14: 00007ffe038f80d8 R15: 0000000000000008
[   41.602697][ T4374]  </TASK>
[   41.602698][ T4374] Modules linked in: binfmt_misc dm_mod intel_rapl_msr intel_rapl_common btrfs blake2b_generic x86_pkg_temp_thermal xor coretemp raid6_pq libcrc32c kvm_intel ipmi_ssif kvm irqbypass nvme crct10dif_pclmul crc32_pclmul sd_mod crc32c_intel nvme_core sg ghash_clmulni_intel sha512_ssse3 ahci t10_pi rapl libahci ast intel_cstate mei_me crc64_rocksoft_generic drm_shmem_helper intel_uncore dax_hmem acpi_ipmi ioatdma i2c_i801 crc64_rocksoft megaraid_sas crc64 ipmi_si libata drm_kms_helper mei i2c_smbus intel_pch_thermal joydev dca wmi ipmi_devintf ipmi_msghandler acpi_power_meter drm fuse ip_tables
[   41.602723][ T4374] ---[ end trace 0000000000000000 ]---
[   41.602724][ T4378] invalid opcode: 0000 [#2] SMP NOPTI
[   41.602726][ T4378] CPU: 27 PID: 4378 Comm: stress-ng-getde Tainted: G      D            6.7.0-rc2-00042-g493ec81a8fb8 #1
[   41.602728][ T4378] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[ 41.602729][ T4378] RIP: 0010:d_instantiate (fs/dcache.c:2031 (discriminator 1)) 
[ 41.602733][ T4378] Code: e8 92 c0 1c 00 4c 89 e7 e8 0a 79 b8 00 48 89 ef 48 89 de e8 7f fc ff ff 4c 89 e7 c6 07 00 0f 1f 00 5b 5d 41 5c c3 cc cc cc cc <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00
All code
========
   0:	e8 92 c0 1c 00       	callq  0x1cc097
   5:	4c 89 e7             	mov    %r12,%rdi
   8:	e8 0a 79 b8 00       	callq  0xb87917
   d:	48 89 ef             	mov    %rbp,%rdi
  10:	48 89 de             	mov    %rbx,%rsi
  13:	e8 7f fc ff ff       	callq  0xfffffffffffffc97
  18:	4c 89 e7             	mov    %r12,%rdi
  1b:	c6 07 00             	movb   $0x0,(%rdi)
  1e:	0f 1f 00             	nopl   (%rax)
  21:	5b                   	pop    %rbx
  22:	5d                   	pop    %rbp
  23:	41 5c                	pop    %r12
  25:	c3                   	retq   
  26:	cc                   	int3   
  27:	cc                   	int3   
  28:	cc                   	int3   
  29:	cc                   	int3   
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  33:	00 00 00 00 
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)  
  3c:	84 00                	test   %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
   9:	00 00 00 00 
   d:	66                   	data16
   e:	66                   	data16
   f:	2e                   	cs
  10:	0f                   	.byte 0xf
  11:	1f                   	(bad)  
  12:	84 00                	test   %al,(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240115/202401152142.bfc28861-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


