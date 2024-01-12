Return-Path: <linux-kernel+bounces-24679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9D182C0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EBC284038
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536D59B5C;
	Fri, 12 Jan 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6yjpMIw"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482959B4D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705065633; x=1736601633;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=x8IlFf03EsZkIjdEsl4M9/uksqpFP1czFjmImbi8IJ8=;
  b=g6yjpMIwRW/z3oaWpUwm2XFrLOdo9FJbOAhJjoOthbLzBd0qEdUHmGzA
   M2XmkmWAyETNoiB46ZpwwjfstRFUVsXCrs4W4Hht+YHxT4HvGwHVdwE2n
   7jlkaF2Z3vGFvDJKBgyJeZWgtQm3kgga6GcD+EbuvErGAo4A5O6bE8AmV
   OC4aKsCXoiINdEyxhiWXHz7EMlmDKpyNfZBZMYQkHPCFZ7BLbNRfixJZr
   P+nX01J1CItedVe+TqemDzKN4+VFZhcMdYn1nhXhN+Czd4+rHVRuZs3BU
   DGyzMPiG0Uf/0OtgL19XK+ivDV1yRKYzbKD849Vn6wHMZLLmcoiggbP+y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="389612683"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="389612683"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 05:20:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="926395633"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="926395633"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 05:20:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 05:20:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 05:20:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 05:20:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 05:20:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6XttuJ7L0ZbOaN9lnEiupxYr43Wuy3P8Gq97oXwxfbeKpQCTLn7GC1BaUssPZKzdnC4I66Xh5IfD0+OC2dvrE1rI4d/YBN0rQWChousQCCb6nvejP3Cx3ThcxZgHD7xUeefq2vJrTMJM/uuTmvsG97Bb3bfOVtLusPkOAkburZZK/7R2KHrB00IOw0l0TlnjmnUafUWfGhnBqNHYODrQtZGwNf69F23rnPiESWOcyOwL/mEN+GVEeVjFYRvaEdpLjJ4K7pAeebZToP2zBCBHW4IZ2x3/mJUrnk4p/3PWDjf3U01MY46NJ5aD/ioa9zDVjZEB7qEMB3E0523b6M6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MQl2801NLK+BrbjtCy81rHxB+ybxrWgywy9p89yRmQ=;
 b=QqYQs+gWfNxi+b0Yc/XIPrW1ypKAiu0UearUJfnejj62vuJrE8afFfr8s+NoMoBKGYN6vlpXGxFqDSwgFMlZV8aLUZaG8aShd8a+0gUM3UsE4tU9VU5R7v5WVL3nyhNbYogbOCDAsejTaRw7llhzwWoJeRU7rKdfAp6WRt7jJEShD/BZmOJyulQVfKtbRqdXOY2My62SjwU4CSb2CtE35gJySTxSC8+hSTs/81YECfJ4Rvz+woeUNLF+VDGix0g+GXJSnZSHcNfZJXs+bobfwqUEyXo41inRrPzwzWmK3eZfNhC/EV5u4oZTv5jEHamtS6H5wnKTDXDiEQ7EQBACrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.22; Fri, 12 Jan
 2024 13:20:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 13:20:27 +0000
Date: Fri, 12 Jan 2024 21:20:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yukai Wu <wuyukai0403@qq.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Yukai Wu <wuyukai0403@qq.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] x86/mm: Remove unnecessary casts in init_64.c
Message-ID: <202401121719.fb50534f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_16DE28073E2F2BF284331B21ADFA58AB2907@qq.com>
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6bf103-08b3-401b-9a25-08dc13713e05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: td+tDI6NgnIkF+4UPjhogvTLkwMBTCvS8S1W9y9OqDwCedNHNg3f8Ciq+UDhL9RcN0ow6BAN3tojUUujwBAQVe0yFuKk4fwJ3u8jwFU3GBwAy0YiWqyETx4Nw+8oK0tNBrVH/QKJutZcmOcLJ0iBFtilrvLP69kf0vp8dshTBt8Fg4HULopgTTYVFX59Ph9LFOo30JOKoxQnzzazAeODYGygNhUjd+RuQ95ucVSitVA0hT7MMKIvVCUpzOgjk9JqxQz9Twwl0/3R4pJpj0e+xZ7LZA5NgbAqL3HxSDHz3VRLRg0Z1lcCztd2vYTDkKCe0wtHM/oAavbjxAzWEcSQovSzNuUN9d2thww4IDr/NZSjuGOosyYZVFFel2FDAJIe8J32LA+BUiyhnUZKSCROR3CXHHsbn+QQQHRKsE3Wz9dufM+8tXBj3BIxd3T3RHrOXrX28NUDuFFAVJtqh5/JmXKTkszKK98fSdSkvsUlxuI5MTfwoSHp6Ct0AuYlHB81gXtUwE66ishoeenxcaglG9BpjSoaAxfPBb9gCjEKt5zzs2Q/p2lil16bV4++n15Fn9HVGLU700dHKf6dFricpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(6512007)(1076003)(2616005)(26005)(38100700002)(5660300002)(4326008)(8676002)(2906002)(8936002)(966005)(6486002)(478600001)(66946007)(6506007)(6666004)(54906003)(6916009)(66476007)(66556008)(316002)(41300700001)(82960400001)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2kbIdhnAKm4BhewOAhOw2BEZLrte3FSCR1y3vqth8pMrTp3lQHNbhe0amHCQ?=
 =?us-ascii?Q?4hWB/7HVYzk2UD9TVQRZIa6W5aQtzDh2FrkaYuNMrUmNKBjg5IaFdWkBOeSX?=
 =?us-ascii?Q?SD4FeMyj8MssmvPh3jrhyMVWQvPTGS5tcMpfDvRl4l7jnOz5rRQqpL6RcABa?=
 =?us-ascii?Q?WJ3iPYN9lzvZqYArKIKEnfnjruO2CKiPLPU85KerIVc481WBvnRUMFPpWmUB?=
 =?us-ascii?Q?yZmT720asiWeD6apu6ZvtgumilPf6PJfzPH3V+FkEbpJ2xgIuyAryUqCwzAP?=
 =?us-ascii?Q?WrhjMR/OwfqHS6An1usumvMPV17w3WCE3xnKUK0Q9eheqUmSIPBwzepbgB04?=
 =?us-ascii?Q?2tLjPWrjUThaCTTAow100N7w/phkDnLu6d5diLJJc8uz9NKrZLyxVmNyCODc?=
 =?us-ascii?Q?UZ/zkgq7y/eEWJPqe1+Sm3MjNy7mgkxdW/UqHHTaSmGmQQDGy4+npmhAtOSg?=
 =?us-ascii?Q?E/7kO7owS9WqL1yn4/kGaTqLdvp5P1KXuidJ3QQlPW6IUwrOMgRZKrdWsSBX?=
 =?us-ascii?Q?JZsysfrPDV2L7k4HHNww60Z5eFdSCL9MpF1/8J8ec74NfbKOMQeZb/6jeHfT?=
 =?us-ascii?Q?2Oe96hw/GORXk4EhArRPEij/t+HttdY+7CPo9JTBwDgbYceASO1YsT9oIhQL?=
 =?us-ascii?Q?My6Nl6f9qLC7io+XVFhzExXODfU+HQRvDEYxX2O0cx9+Kw3nFBpXwvPih15l?=
 =?us-ascii?Q?zKlK7ME+SQTFKc6goCo1goqzRB3lMKELaMZyb+91VxgxTUWB1ds5E7z9JAha?=
 =?us-ascii?Q?BPbbrLBHALg1E+BlB2HTUeGO/wiJcMXSmGHMyynNZxokXa7XaudUNz3j+vmM?=
 =?us-ascii?Q?CXLyvzkDk5O2z/flLlSH9aml5Attc6P5HO4xh+vcpxwSjMD4XcHXqvWNjEwc?=
 =?us-ascii?Q?uc0zWaDvgwvqKjzEPvZVEsubJCZQbQc6fRRxju2Pz9Ii9zFt7aYF6bylW8hb?=
 =?us-ascii?Q?D8m/jF1lw0ZuIPRfOnZ9fN5bcS1uT1xecq5jz1TSDWeRe/Zm1eojvWAGAUZq?=
 =?us-ascii?Q?qaj66n8fH+ZREj1Kd02tRf441PDFAwQW8TuM17EZ8P3aFo/HsC40gMNLrMWj?=
 =?us-ascii?Q?9pX/j9PiMy9+x8sXGwStetxDcC/9gL22Ix3BXin6r/nKHgRBVXfwIfuxq9DJ?=
 =?us-ascii?Q?ufRzWnm0MM/JITTcGDMVs+uJPNn4CT24g1p+CNZHIM7LgcKvHhKgNgcP2O+e?=
 =?us-ascii?Q?n/0sUYIvVHGwaPEUP2UOPfrXxq+Y5MSU6z+9891XUlKsTyx707Drqls/SWMq?=
 =?us-ascii?Q?m7Lez0LDbDSLH/YuS1bZK4ZsumRfWb0t4HOEu/IenoB8E007EpIOoog+/+lS?=
 =?us-ascii?Q?QRSsKRDZWOTF2vw+Ip48izZXB9hEfLua+ldg29NntY73vcdvOT4tznwExUpv?=
 =?us-ascii?Q?kXYB13JKj0VsPlcHsi75UOl3fASAT09kcUS63aNHCPclEqxmwtDkw2XfulU9?=
 =?us-ascii?Q?bQWyHfVVU3ZU1z2J3dQVm1a6Nv8h2ryjP8GlJlzRRmJFz34SxsfiF4Sxj9AI?=
 =?us-ascii?Q?PJPP6+bXC7p21DIO+GQAhCoINvuKBCAFtPNwhx4eU4qugRK3AzcclBRplC2s?=
 =?us-ascii?Q?ihVSiy9yw3yK/MLw5AQJp/TBO8mbRz6Vu+lm1yh1AIn1OYsK9edCQqwYqIuX?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6bf103-08b3-401b-9a25-08dc13713e05
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 13:20:27.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzbSFOqbFZNaMyuRmmb+hiqdjDmBpiwGXyPLt2T2vYy53xejE1LLYA0YLc2CnsRQNbKjF+kZrhpshQBOw759eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_arch/x86/mm/init_64.c" on:

commit: b4f7cb0d6fbedcc9946304f02513f97ae2d3ef0c ("[PATCH] x86/mm: Remove unnecessary casts in init_64.c")
url: https://github.com/intel-lab-lkp/linux/commits/Yukai-Wu/x86-mm-Remove-unnecessary-casts-in-init_64-c/20240107-123342
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 91c17d7b04498ffb52939a18eb7e28fd23c9b654
patch link: https://lore.kernel.org/all/tencent_16DE28073E2F2BF284331B21ADFA58AB2907@qq.com/
patch subject: [PATCH] x86/mm: Remove unnecessary casts in init_64.c

in testcase: filebench
version: filebench-x86_64-22620e6-1_20221010
with following parameters:

	disk: 1HDD
	fs: btrfs
	fs2: cifs
	test: filemicro_create.f
	cpufreq_governor: performance



compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401121719.fb50534f-oliver.sang@intel.com


[   31.641127][ T1120] ------------[ cut here ]------------
[   31.646457][ T1120] kernel BUG at arch/x86/mm/init_64.c:202!
[   31.652129][ T1120] invalid opcode: 0000 [#1] SMP NOPTI
[   31.657362][ T1120] CPU: 12 PID: 1120 Comm: systemd-udevd Not tainted 6.7.0-rc2-00003-gb4f7cb0d6fbe #1
[   31.666670][ T1120] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0286.011120190816 01/11/2019
[ 31.677790][ T1120] RIP: 0010:sync_global_pgds_l4 (arch/x86/mm/init_64.c:202 (discriminator 1)) 
[ 31.683541][ T1120] Code: e8 97 ea 00 00 48 89 c6 49 89 36 e9 2a ff ff ff 48 c7 c7 48 90 bb 83 c6 07 00 0f 1f 00 8b 0d 8d d1 94 01 e9 84 fe ff ff 0f 0b <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00
All code
========
   0:	e8 97 ea 00 00       	callq  0xea9c
   5:	48 89 c6             	mov    %rax,%rsi
   8:	49 89 36             	mov    %rsi,(%r14)
   b:	e9 2a ff ff ff       	jmpq   0xffffffffffffff3a
  10:	48 c7 c7 48 90 bb 83 	mov    $0xffffffff83bb9048,%rdi
  17:	c6 07 00             	movb   $0x0,(%rdi)
  1a:	0f 1f 00             	nopl   (%rax)
  1d:	8b 0d 8d d1 94 01    	mov    0x194d18d(%rip),%ecx        # 0x194d1b0
  23:	e9 84 fe ff ff       	jmpq   0xfffffffffffffeac
  28:	0f 0b                	ud2    
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
[   31.702992][ T1120] RSP: 0018:ffffc9000aa8b9b8 EFLAGS: 00010206
[   31.708918][ T1120] RAX: ffff88805f7f4000 RBX: ffff88df7f20d4ac RCX: ffff888000000000
[   31.716743][ T1120] RDX: 000ffffffffff000 RSI: ffff8881bdc72000 RDI: ffff88df7f20d4ac
[   31.724566][ T1120] RBP: ffff890000000000 R08: 8000000000000163 R09: 0000000000000001
[   31.732395][ T1120] R10: ffff890000000000 R11: 0000000000000001 R12: ffffffff82c1c890
[   31.740218][ T1120] R13: 0000000001ffff12 R14: ffff88df65642112 R15: ffffea017d959080
[   31.748045][ T1120] FS:  00007f916a9ae8c0(0000) GS:ffff88903f900000(0000) knlGS:0000000000000000
[   31.756822][ T1120] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.761388][    T8] EDID block 0 (tag 0x00) checksum is invalid, remainder is 125
[   31.763260][ T1120] CR2: 00007f9169f4f56c CR3: 0000005f6511a006 CR4: 00000000007706f0
[   31.763261][ T1120] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   31.763262][ T1120] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   31.763263][ T1120] PKRU: 55555554
[   31.770744][    T8] 	[00] BAD  00 ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff
[   31.778566][ T1120] Call Trace:
[   31.778568][ T1120]  <TASK>
[ 31.778569][ T1120] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[   31.786396][    T8] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 31.794218][ T1120] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
[ 31.794221][ T1120] ? sync_global_pgds_l4 (arch/x86/mm/init_64.c:202 (discriminator 1)) 
[ 31.794222][ T1120] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
[   31.797627][    T8] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 31.804843][ T1120] ? sync_global_pgds_l4 (arch/x86/mm/init_64.c:202 (discriminator 1)) 
[ 31.804844][ T1120] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
[   31.807991][    T8] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 31.810789][ T1120] ? sync_global_pgds_l4 (arch/x86/mm/init_64.c:202 (discriminator 1)) 
[ 31.810791][ T1120] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[   31.814368][    T8] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 31.821589][ T1120] ? sync_global_pgds_l4 (arch/x86/mm/init_64.c:202 (discriminator 1)) 
[ 31.821590][ T1120] ? sync_global_pgds_l4 (arch/x86/mm/init_64.c:201) 
[ 31.821591][ T1120] __kernel_physical_mapping_init (arch/x86/mm/init_64.c:773) 
[   31.825611][    T8] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 31.830749][ T1120] init_memory_mapping (arch/x86/mm/init.c:548 (discriminator 3)) 
[ 31.830753][ T1120] arch_add_memory (arch/x86/mm/init_64.c:969) 
[ 31.830755][ T1120] pagemap_range (mm/memremap.c:246) 
[   31.835203][    T8] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 31.842420][ T1120] memremap_pages (mm/memremap.c:367) 
[ 31.842422][ T1120] ? devres_add (drivers/base/devres.c:70 drivers/base/devres.c:134 drivers/base/devres.c:249) 
[   31.847568][    T8] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 31.852100][ T1120] devm_memremap_pages (mm/memremap.c:407) 
[ 31.852114][ T1120] dev_dax_probe (drivers/dax/device.c:449) device_dax
[   31.859677][  T777] scsi host5: ahci
[ 31.864475][ T1120] dax_bus_probe (drivers/dax/bus.c:201) 
[   31.869394][  T777] ata1: DUMMY
[ 31.876575][ T1120] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[   31.881714][  T777] ata2: DUMMY
[ 31.886852][ T1120] ? __pfx___driver_attach (drivers/base/dd.c:1157) 
[ 31.886854][ T1120] __driver_probe_device (drivers/base/dd.c:800) 
[ 31.886856][ T1120] driver_probe_device (drivers/base/dd.c:830) 
[   31.892773][  T777] ata3: DUMMY
[ 31.899989][ T1120] __driver_attach (drivers/base/dd.c:1217) 
[ 31.899992][ T1120] bus_for_each_dev (drivers/base/bus.c:368) 
[ 31.899994][ T1120] bus_add_driver (drivers/base/bus.c:673) 
[   31.904873][  T777] ata4: DUMMY
[ 31.909318][ T1120] driver_register (drivers/base/driver.c:246) 
[ 31.909320][ T1120] ? __pfx_dax_init (drivers/dax/device.c:263) device_dax
[   31.913776][  T777] ata5: SATA max UDMA/133 abar m524288@0x92180000 port 0x92180300 irq 358 lpm-pol 0
[ 31.920990][ T1120] do_one_initcall (init/main.c:1236) 
[   31.925525][  T777] ata6: SATA max UDMA/133 abar m524288@0x92180000 port 0x92180380 irq 358 lpm-pol 0
[ 31.929709][ T1120] do_init_module (kernel/module/main.c:2530) 
[   31.937992][  T777] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[ 31.941722][ T1120] init_module_from_file (kernel/module/main.c:3148) 
[ 31.941725][ T1120] idempotent_init_module (include/linux/spinlock.h:351 kernel/module/main.c:3111 kernel/module/main.c:3165) 
[   31.947303][  T777] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sadm sds apst
[ 31.950878][ T1120] __x64_sys_finit_module (include/linux/file.h:45 kernel/module/main.c:3187 kernel/module/main.c:3169 kernel/module/main.c:3169) 
[ 31.950880][ T1120] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
[   31.977632][  T777] scsi host6: ahci
[ 31.980789][ T1120] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   31.984225][  T777] scsi host7: ahci
[   31.988473][ T1120] RIP: 0033:0x7f916ae63f29
[ 31.988475][ T1120] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
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


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240112/202401121719.fb50534f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


