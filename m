Return-Path: <linux-kernel+bounces-86853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0186CBBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C10B287E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242DC13D31D;
	Thu, 29 Feb 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsAfyK5X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C213D0BE;
	Thu, 29 Feb 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217534; cv=fail; b=ieACQL0yjr9K3y+eabx9x//AEqMIRNlkgg0pD2acngIP5qGGLZsoAlC17EvJ+xHN1TI/WpuL5IU78GWIPMygcnQSHWYirF3TAvzdmZw9UAgPkPTAGddH2nSdCc1WgF8jrUEjij6BSCB1wp5dbQKJ93LMTJyL7Ql+wyCRrVI+cc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217534; c=relaxed/simple;
	bh=z/btq/WVUM6a1ptGVHSxI1DQ4LUt8rUeo3T8kGXGaKI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=fvT3qUhCiagUHMad+Ans/qkUWzWIIYI1DqxAgoRWiv66CaR0kshsTGQY4WCAslVOm4LGpcmWiIRFm8atItrce9cAZrYuYqIEXOxEcGncjpd6S+5x79NweL4iivEtOxy/rbVMcmqhQWqa/IDknvRY1lweY3xFzTmW4MetsR9Jouk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsAfyK5X; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709217532; x=1740753532;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z/btq/WVUM6a1ptGVHSxI1DQ4LUt8rUeo3T8kGXGaKI=;
  b=WsAfyK5X1UoewAyfjp30cNAEvjPG7IGQUlaOZpWrpkZLgT/+tt4BKNCe
   7VLgJl3/Rns1mmtw8stvAKboN/WenQvkh/eZvSxjuiz28dhqyZVBP1asw
   KgvvDiU4kGoQ2ujcmHCrLPxKRG+eTpfm10v6PuZCDeTs3OYhKqkAtjKAv
   DkGcPgj76/8A0R+JT02ATRYL3+W3y/Ulhhai/fLluxDyNM0r5gQU/tLQr
   0d0YNrcjAqvxdHA8O9oeyTD92Xn7hEgk+VhCqT/EMrrpGJKikZxbdeo0b
   8/9uFYXcmaM0TPLhN4RzCGJDeGXusL78KMVxvIls4Wy2VpWb1W5/wP3MA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14325091"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14325091"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7797118"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 06:38:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 06:38:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 06:38:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 06:38:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAmsGg8+54QR3IUk8WxihuHMld/BS/Tv0PsqQ64oQRxSYVTdVAad4kSlBOhVNaR9IHd/vpdKUrAbNWPPlmsL7X37ziWln/KyPSK1wBR+8l7py0woZqwpB+0JatUZUj6p/nWvaF3Xz4tQYA51JZ2Eo8HesbMRatR0NjREGcafrdRH8FXT9LUk36fGXPGZbbWnpsXaAR3qoY3p6X6GozEwXvwZiini3SXeGytNz1eEozroVfV1PZOBaJbnUHZm4XZAxpTLH4H0EkQ8s3jSAa9Ps8YKBhSiebl5kJ7kS/xhKSb1lsYrChHjpsdLbRtrRtHP870sTfRrsCXqsdl3lzWyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29zxRum4+aKDy3oCi7sz1cSMgFgOiig5LZd4aBNe5HE=;
 b=QMkFiCwKanKDxGI2MF60qG83qVS49bhPhWx2lX+wEjP/JCk1Sh5ZqeYex3RJULlQbc1GrK6Xf/l5w9fW6CwRumnXvL4LltAFRn2UAdeoyixULkwW3PnJWQxLbJW9UHum1hCMaQOmczyuRuN5yDQ9dEX1lEwc4qSPBtBGB8bVvnnjJnNeG5dWxSiV4EoELNoDfnrkXY7LjK8YXE4pbyGE69OA8j/rgEYNqjzeFANG9LQn8UFEDXznNwZkJkwYmcI+6h7+nXzaQajfANp/jjhELE1blhzaaKXxgrq3YbuF9vje7McH8mJ2il9IV3kuaHknp5zMRwgr05kbPRjupgGnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4576.namprd11.prod.outlook.com (2603:10b6:806:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 14:38:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 14:38:47 +0000
Date: Thu, 29 Feb 2024 22:38:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [mhiramat:topic/fprobe-on-fgraph] [function_graph] ab712273e5:
 WARNING:at_kernel/trace/trace.c:#run_tracer_selftest
Message-ID: <202402292204.c1f77860-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: 2148434f-a9e6-48aa-6997-08dc39342316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VS0TaKOp/NLYFMDvHNMrz3ZIkUzUvE7F331lbppe655mtJrdlqzD4uSmEdnltgpCWBGqpqFufTAMfDbQIx0rXJn7eEQnpRA6XAHjZhMZbyOmtpSfQYZ6ZYH0rvGpUvIIuGHLmVpX1MrVCcERBC7G59T8RsKRDs/tydJqD/YMbmxjdPkHshpITHfgu7ECoa3fXJVSZRZW5C+CDaiP6/4RVw98SM5hGAJ0pFOx0p8lNfhrkT7uzMslrjOPhHzpwAL2WyoyUyEs3jTJRML/wajLG1L8MUGqGi/nxOxjRnuzWx9TsGZxPZJjJK6qw2fA4lfryhudwSUcAmfWdrOcFwzsPtKPFvY+XGMsYg2KEPbiW5NidluZBOUNFPA9LxITxSaHici9DxgC+9gP/BZ4MPe9Hm1in+CRQZZtAma3iZY70x41CZsyQ1NTXTkftgz8I8WgffH2ejfViAqdBIdwzbfYlKKWNwZAshref+oanC8CPSUPdY6KBfB0lXztCuGzaClF9XljqSLPJxBiMkvtH1P8dq4XHuClaUdSTkdcrM3BUbT1zWI248XJBdeD/bq5LrhXD6Qe3PT2iDmpW9+bb1pbgqnZEPSHPbZdKWw+6O06E7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WjmrsKfwgJ/VQY3KnNTYUIRKDnJ664rUwh7+V6LGxF0VfZVHf3vTDbQ/fuf8?=
 =?us-ascii?Q?I45jGw2NEvvSEPN0pX31ZRnGx+vTIOX+9rE5HDsDCDqxFMn0y4Fukw1CyVTq?=
 =?us-ascii?Q?d+ix0MGbqyJPAFNgaK3v1p7dvaJUBaRl1r1Bs6kdJeNSalnlFnVBUaDrtTDj?=
 =?us-ascii?Q?QUOpW/PEvp3DkWKvG1ZJ/S/G7Ava8zmk/3U6ocNWaCoQs6BU1yjP6A/l4NK7?=
 =?us-ascii?Q?2Ej6uN1LnayjOAo2H6L3LtKgIeONxN1xrY2KWD5jp82wvebNv6jk655+T62p?=
 =?us-ascii?Q?wzFJ9+ekdpWdtc9ksfC/QUm0n11Mah63liK1yIjX5SQ/A2k3SpHF+BNUg+ok?=
 =?us-ascii?Q?I7av9maUoMpjdcrPLrxsj52k4MBkcLDGnLt1rvXmaZUKJtRVDMiuvULD3bhp?=
 =?us-ascii?Q?jLBV/6GCqQwER2VtXtgN9YUAF9q4vRakIx0jv4r17+RWo7Q/VoxvzANG7pXX?=
 =?us-ascii?Q?U+ZDqfqFltk/xAwIwyIjnPdvNyEsJDBWVzcX7h+7KXhRjSltX/qDvymPj4Re?=
 =?us-ascii?Q?BHqJCb2nHWtiadxXU8DL8pZ9pJdW2kgT/+zL2N6YLIcL5uHtIVsCMTsTxsJ5?=
 =?us-ascii?Q?Mt9rHbT4+FiZawXZ7JGAgn6H+Pbf5tLPJCWpB6V03ykAMO13HbeufXUTBuv9?=
 =?us-ascii?Q?HQQySvT+b2Pd1F9nFqyyxna4a9AZsc2HMt3Qop/UMEOmdGGP2IJDbNGaMMcV?=
 =?us-ascii?Q?HawbOra3q36Itf6XFgS/m4XpmBmahTAyDcajTnqZ52EQLYHk5O2MJW8Tebbg?=
 =?us-ascii?Q?clB2pzKPcXFC3mTpfEeDYAb2w0N+bTIdDEP0yK0VKD+5BHqm+XahihKOY3aQ?=
 =?us-ascii?Q?f8CUIiMPzNmefv8GbTp5/GAxXX2q0yC5/KBJG7wLW8L4+ga24TdCd+pxJpgN?=
 =?us-ascii?Q?AU83OW2WrdkXk01Ii71yf646XEtNjWDxKKoT4q1mIYSTxpVAZhcCurC+pIsB?=
 =?us-ascii?Q?bh8qPwsjVkxjW4rGnyhJefeyiFIqrB682IquoL5P1Igq4OmE0Fl4P+LJkCQo?=
 =?us-ascii?Q?fRcqNFcZOvg7sEWgXAngK3S79DaFfTM88q71qSgzl83ELJGv+07c35MG6mgF?=
 =?us-ascii?Q?YJQxFuv7+t6s6YR66iAc+QfwAiUkGg3fwzSa/Sy3xs1ik8SPZYrsWDVxR4wS?=
 =?us-ascii?Q?ct1wVLj893QmS6HSkgAWOhIV2dbGYHZgwlH++bXSYAhg3A48cPpH6BXeyXyT?=
 =?us-ascii?Q?1h0+QHa6P2cX5V/HcJPUNSQD01oYrFdY+TLVutGP5m9ITbEQsYNAhOAfwr5F?=
 =?us-ascii?Q?Kq0nicbnNWxKwqczMjy+gLBfdoIJjSwwgW/cjE9EjHMjVlvpRnPAeAGAdCTG?=
 =?us-ascii?Q?IYqGw7B/HJk+88qIiyqO2d6hmk3bft6pTwL3yKMVj9C+fS+8uKKTUYIzxkSR?=
 =?us-ascii?Q?WA1d1OuhJ4JsnHsiWbQ7MKQw9O3Kc2eypuK8qNWH6lCprphF75olik7WwkxV?=
 =?us-ascii?Q?aBebjqZInx7pkT0wflpi8raqAwiqwgJTOij+jL1TugAyOkjDitisn3EXekqM?=
 =?us-ascii?Q?dno3Z/vNOASod7Tqb4GJRd2X6Jkww+rbNg4nJ6WwYq5uVaFuFY3kTJQjKfmK?=
 =?us-ascii?Q?mstfgdoFBAL053tOEkmk7TPeC/ZG8d2B7gPu7/9gc1O2Iz5hETAbqmfS6vhl?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2148434f-a9e6-48aa-6997-08dc39342316
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 14:38:47.1167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utfjDHDILzwQnNA3ohRAa3YYvsSN8OGhry9aZNFL65xMGYLTvdMykTdtZXynprIAVOyuzkO+9VUz4gV5kXatsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4576
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace.c:#run_tracer_selftest" on:

commit: ab712273e5b93b2162bd25823c50afa067c971d7 ("function_graph: Pass ftrace_regs to entryfunc")
https://git.kernel.org/cgit/linux/kernel/git/mhiramat/linux.git topic/fprobe-on-fgraph

in testcase: boot

compiler: gcc-11
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | 18e3163a72 | ab712273e5 |
+-------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/trace/trace.c:#run_tracer_selftest        | 0          | 17         |
| EIP:run_tracer_selftest                                     | 0          | 17         |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402292204.c1f77860-oliver.sang@intel.com


[    9.224340][    T1] ------------[ cut here ]------------
[ 9.225209][ T1] WARNING: CPU: 1 PID: 1 at kernel/trace/trace.c:2053 run_tracer_selftest (kernel/trace/trace.c:2053 (discriminator 1)) 
[    9.226920][    T1] Modules linked in:
[    9.227542][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-00021-gab712273e5b9 #1 b22c8cda139bb32aef1f09ba4b94f28d718abc25
[    9.229490][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 9.230911][ T1] EIP: run_tracer_selftest (kernel/trace/trace.c:2053 (discriminator 1)) 
[ 9.231772][ T1] Code: 00 00 00 00 8b 15 5c 14 27 c3 b9 ff ff ff ff a1 a8 14 27 c3 e8 23 60 ff ff e9 8c fe ff ff c7 04 24 c3 18 ca c2 e8 ea 9d f4 ff <0f> 0b be ff ff ff ff e9 60 ff ff ff be f4 ff ff ff e9 56 ff ff ff
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	8b 15 5c 14 27 c3    	mov    -0x3cd8eba4(%rip),%edx        # 0xffffffffc3271466
   a:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
   f:	a1 a8 14 27 c3 e8 23 	movabs 0xff6023e8c32714a8,%eax
  16:	60 ff 
  18:	ff                   	(bad)
  19:	e9 8c fe ff ff       	jmp    0xfffffffffffffeaa
  1e:	c7 04 24 c3 18 ca c2 	movl   $0xc2ca18c3,(%rsp)
  25:	e8 ea 9d f4 ff       	call   0xfffffffffff49e14
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	be ff ff ff ff       	mov    $0xffffffff,%esi
  31:	e9 60 ff ff ff       	jmp    0xffffffffffffff96
  36:	be f4 ff ff ff       	mov    $0xfffffff4,%esi
  3b:	e9 56 ff ff ff       	jmp    0xffffffffffffff96

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	be ff ff ff ff       	mov    $0xffffffff,%esi
   7:	e9 60 ff ff ff       	jmp    0xffffffffffffff6c
   c:	be f4 ff ff ff       	mov    $0xfffffff4,%esi
  11:	e9 56 ff ff ff       	jmp    0xffffffffffffff6c
[    9.234972][    T1] EAX: 00000007 EBX: c34453a0 ECX: 00000000 EDX: 00000000
[    9.234972][    T1] ESI: ffffffff EDI: c3479760 EBP: c4c47e84 ESP: c4c47e70
[    9.236035][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[    9.237240][    T1] CR0: 80050033 CR2: 00000000 CR3: 03739000 CR4: 000406d0
[    9.238361][    T1] Call Trace:
[ 9.238877][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 9.238912][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2053 (discriminator 1)) 
[ 9.239756][ T1] ? __warn (kernel/panic.c:677) 
[ 9.240397][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2053 (discriminator 1)) 
[ 9.241233][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2053 (discriminator 1)) 
[ 9.242070][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 9.242782][ T1] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 9.242911][ T1] ? handle_bug (arch/x86/kernel/traps.c:238) 
[ 9.243607][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:259 (discriminator 1)) 
[ 9.244341][ T1] ? __wake_up_klogd+0x49/0x70 
[ 9.245189][ T1] ? preempt_count_sub (kernel/sched/core.c:5881 kernel/sched/core.c:5877 kernel/sched/core.c:5899) 
[ 9.245969][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 9.246767][ T1] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 9.250912][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2053 (discriminator 1)) 
[ 9.251749][ T1] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 9.252458][ T1] ? run_tracer_selftest (kernel/trace/trace.c:2053 (discriminator 1)) 
[ 9.253288][ T1] ? graph_depth_read (kernel/trace/trace_functions_graph.c:1349) 
[ 9.254057][ T1] register_tracer (kernel/trace/trace.c:2086 kernel/trace/trace.c:2210) 
[ 9.254800][ T1] ? register_trace_event (kernel/trace/trace_output.c:783) 
[ 9.254910][ T1] ? init_graph_tracefs (kernel/trace/trace_functions_graph.c:1449) 
[ 9.255706][ T1] init_graph_trace (kernel/trace/trace_functions_graph.c:1463) 
[ 9.256448][ T1] do_one_initcall (init/main.c:1236) 
[ 9.257185][ T1] ? parse_args (kernel/params.c:183) 
[ 9.257891][ T1] ? rdinit_setup (init/main.c:1282) 
[ 9.258602][ T1] ? rdinit_setup (init/main.c:1282) 
[ 9.258918][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 9.259617][ T1] ? rdinit_setup (init/main.c:1282) 
[ 9.260332][ T1] kernel_init_freeable (init/main.c:1555) 
[ 9.261149][ T1] ? kernel_init (init/main.c:1443) 
[ 9.261870][ T1] ? rest_init (init/main.c:1433) 
[ 9.262567][ T1] kernel_init (init/main.c:1443) 
[ 9.262911][ T1] ? schedule_tail (kernel/sched/core.c:5338) 
[ 9.263644][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 9.264345][ T1] ? rest_init (init/main.c:1433) 
[ 9.265046][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 9.265798][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[    9.266571][    T1] irq event stamp: 5037117
[ 9.266911][ T1] hardirqs last enabled at (5037127): console_unlock (kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 9.268327][ T1] hardirqs last disabled at (5037134): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 9.269742][ T1] softirqs last enabled at (5036722): __do_softirq (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 9.270910][ T1] softirqs last disabled at (5036717): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[    9.272383][    T1] ---[ end trace 0000000000000000 ]---
[    9.273787][    T1] pinctrl core: initialized pinctrl subsystem
[    9.275831][    T1] workqueue: round-robin CPU selection forced, expect performance impact
[    9.277324][    T1]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240229/202402292204.c1f77860-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


