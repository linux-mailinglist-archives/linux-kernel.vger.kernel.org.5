Return-Path: <linux-kernel+bounces-80558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF5866977
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36C81F21385
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A711BC37;
	Mon, 26 Feb 2024 04:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsvSy37a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51C17BC5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708923485; cv=fail; b=V4Clv4vq0uJnAOeMRgxHfOq2vECh/2rb+3dZxIPwOh3JWUCAzhNgZZZxUs+vJLqpOoXiVFYEfJAOJlKhhXUdzH8hATVWTvwWbiF66LyhiO8bHgj9R8ilt8grAOsxNEbJHFsQw1cCJaiYu8GvZCoXIgMl07yaWE+kZrBUnI7QvPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708923485; c=relaxed/simple;
	bh=9bo5nmWlDLKHRtwZxG6KAUJtdakqcaN0GvfrsXRyJOI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IdNBoM855P/0y4++Iu5EG1/I3fKfJaq3zNeOZkXjgAgusNUxMV7Asq1HkTzyAZYpseqC4Syb5wl1No1eYm01JSeM+od+ZwqqowxM+AQambXZu6awO/7S+yt81w1xjtQd6t8MnIt+HlUoV8F16svVxztZ/d1yA/mVElRJ5oOnOP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsvSy37a; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708923480; x=1740459480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9bo5nmWlDLKHRtwZxG6KAUJtdakqcaN0GvfrsXRyJOI=;
  b=XsvSy37ajx3AB3HfG4qgQOQt63OgD6mM4FHxLEfK/f0Nqbn5ymMeSV0x
   TlWJRefMAL+ZQguPzIcfFklW4hdE2l+eobZXh9tDJXT4vJ//EIaYCBSEU
   vM2hdS0ro5CiDzAwk2hX0x+9LvTnOazFUI978mBgi+QxjaCSOYHAJSM3E
   nUNTLauadFrDEKaNFqnh9x30oaafZ5xd3MkBNoLEKLyMoWxY/0jVgBhSh
   pPLwgsKz9UdQuEG57cJSI7OIq1fgBymb6OT6oq/OhF2QKgWODgXJyDaUG
   82QKHmFNbMlTGQTNLN37tCwXGyVk0D7I2KWpdodNY1NBClLmTwiTNnvPj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14320307"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14320307"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 20:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11131440"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2024 20:57:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 20:57:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 20:57:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 20:57:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1riMf7N/WDb7AwPjDSdylYZe2yl3an6iqmlNQrPkuGH4etEQeLf4yFh59OEszlEJ7x45W9SUSf8BzMgZH3jCRXCQUqAhKSQKJsy1YqLSQpqaOHsl/hQHg+YkDElmo6f4gYRq75RXlYW4liXSLy35VotzeBhZ+Wo5j0KCQU8vwRllHspYjV1DwToPUiIilF4/kFvj5VI6s/nIrZCQ3bmBGVhR/TEGoAZuykYGpsoaNUjd/iqCvfzBNZvbKw4Fweafz7t3S1NpE/cUs5yNqHK3KxhdSwyOen7Q3gd+HyRi+eRWD3TkvnvkSrbK9AG4/Lo0NqnCPsrLRs0GfcznTIKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9DPprLdnslRqBlXnIG+w/11ir1jQk39BeRbXi4hB/k=;
 b=J5kUTxBRE0QVRKXS7pvNsRxC57WVJrTx8ZefEu6Nyw9YVrTYLEBlGU+ibTMpmo6CoDlMweKY95oDmFOEvNGsjlnaknufCLZ2b8tLZrMOkkgWptXTkgS79bS5yIr9k5MGJtjAxHsOa3uMfN5p/xGOBa7tzeaJyrLSbRZ2xm+MN9dICmE3X/JXzynAs61k/gTDCCnk5nV+B1v3jnfGXPf8t2NPQIMtNQ3wMDgwyrtqX6bc7V7agocEe0tpVw2y9+hLy5BdqF0IgD9lc1AEAqYc1WO7I5g8+KTTxGqY9QzUwm7SUMqdRC//GaBJaPxzkRKe9soEbIxFIZSsoZ43UxcHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Mon, 26 Feb
 2024 04:57:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 04:57:55 +0000
Date: Mon, 26 Feb 2024 12:57:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Marc Zyngier <maz@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Anup Patel
	<anup@brainfault.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, "Biju
 Das" <biju.das.jz@bp.renesas.com>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [avpatel:riscv_aia_v15] [genirq/irqdomain] c3842e43d9:
 kernel_BUG_at_arch/x86/kernel/apic/io_apic.c
Message-ID: <202402261004.1e2e3e3e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 2525d8a4-dc5f-4921-de10-08dc36877e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31LZJacrB/0McjmC0S/alAzTtv3paGLTBYnEnbSfuA9FXvwnkRCDP+K6ESbGNEpjnNtwb2z7XmOGVb8U3gyjs9a9qdBbTkSfFSGkAoGRBgnMqVyHOt19QcoiETvoNTCwBN5w0XqeLusTa0YyTjmGtc1YstKL3BSSg2QaELtkO0sLJpYUndVPX4zZWXAvbE1VK9xiBhP3xEUr7TIiu3Xvmqg3h2XRL+UNpDIsQS8omwwkKDyQKZy0K3y53pT2NSyI961sktnTiO/GTnoWbKoLjGsGGT0k03sH6pzwnVk08uLx5VtEJwjmgghQkscZCV2PuS5dvieNq32rBBvScX8k4Io6mED/aWjR5gSV+WMI/CUEtkCPjMHqP/SJgGAXDWQKkX4/nI80SbIAkcgCGwDXPxgl1GgwP2SQvzYqnrFmWve9i0iyYVc7y1EPAnCN7FLuHZOjRlIQnXVYPcsNGwCexU6Srz1AMz2p4DY63BvrgyKd9ut6ViIdni+Orb4m0pIWwEsyxglZ+FaD6x0Hd2LPwhSOSRDRecjpPwvV0DdtnDFxt1hhyIJuROiuwmQ4mKb8yhoDCtmZ7wOotZ7mANnuOPZI9RLx6NmFzn0omClVG0OttyhgQTBveMOykzxutYRw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Le8PuaBEKlRSd7Hszc318fsyVBnyUs8YPSWMhl37NSy4ifPyCBnDgKeD8IIn?=
 =?us-ascii?Q?AKx5gtrXQJdmc3/YOKOixs4UoQ1iNtsUZyOHB32cqTnZVJMp82MIcoedLdck?=
 =?us-ascii?Q?vUg7ptF5qnOPfCSS5Eq89r/vQfbXmfy20FhVu3wT3NQ7xfpaZYGefZ/XEBa9?=
 =?us-ascii?Q?dXFy3R/Za+RjWdCPZGthmArpaDo0Gdwk8ymF/00nfNGg3Blb7vvSEot61tfD?=
 =?us-ascii?Q?Sqx8NqECDenuTdmY9JswCO7PDCIdG648gunt8FAYKTFGJmdV6MOTBkstkapi?=
 =?us-ascii?Q?35XJvnY56opItVjC17gMl1Z/pbt4ljZRko9KUmAvTL0+ssgMtTQHJ78+d7Rx?=
 =?us-ascii?Q?Wb1CD52EQzb3VTADLJH6dyYLcYGdJqSUqVcegME1A0JEsPIKYgpFWM/sAW7X?=
 =?us-ascii?Q?E43PKH4F0vPajEz35kWzbCiveSv7PO0tKgG6TFOkedAG68zrA2YNgPIIHHsr?=
 =?us-ascii?Q?22VR/WxXi3SCLGVY8AEJ9Oi6rx4dvKKARNeDh3iEQ0ec9epYT4sDT3iAvRIy?=
 =?us-ascii?Q?MizW8ULswLXx1bZLJsEy3AsR49UOqBqVpAonnLkpkwbqyt+kuMZWESR+L0g+?=
 =?us-ascii?Q?i+/lbfBPQvqyUwEgqi5bCZDsyrJVyMzzGXI26P77bM1L11pyeD3ZkWFxaAjW?=
 =?us-ascii?Q?aKLTXIkDEf+b+48Nv0RLWpmZnNy+2LZG5mtNyvyLOD2cyRVTKIwdiqMSjS42?=
 =?us-ascii?Q?IHhQbPrNKyXprYL4unOvnmDKx+edXEb7sNiXGpQqx8I6LPMUrv5LM5udO5zU?=
 =?us-ascii?Q?I3tKIrEcx43SlHlS9JDCIv6n9iJHl4scFJQU+yljbl4UCa7zWeIdptqhXL3G?=
 =?us-ascii?Q?qmTfF2TdhVWgq1hUN/29D/0TVbW2qr6Jwbu+bXDSxmG1d8sEi0EP6K5OZSoy?=
 =?us-ascii?Q?cbgKGqKmwH6qs8UuyvBULxEijmtyr6McLoEa1pT4ZOLdZ0OaWPk/s4WRrmAM?=
 =?us-ascii?Q?BHIerMGMzMmvtnG3JYld6nhgKfIPnUFos9EztBxGLrFF9XpKoHK34zEvobpk?=
 =?us-ascii?Q?xrZC1JJeCXLnfl5je7PJprINWDQSrkQKygj3pweN/YSNZ1eJCscjl8e7geG4?=
 =?us-ascii?Q?JpX8UltXVkUAa4kmqSCPVfIt8QqiCXfE+QOBsYKXgBCDYsWMydaqMJm7Dyw9?=
 =?us-ascii?Q?kRpNkQZzJLAK3+o8hfSna+aTIA/Uogv9AqSmZFicNsynvpoqdR3r2S7PZtS5?=
 =?us-ascii?Q?NZGXmOV6+E0z32OBcHi88EA18iVcEL+EapQ3O7Tp9YAG7oj+hW7hQoheme84?=
 =?us-ascii?Q?GMdOIzcBK8z18TtysAilufhygFI4Qgi5SJay8GniVpFNmvwOgYfs8sYwP17H?=
 =?us-ascii?Q?kWBjUMvrPSWv/Hyo2SuDqn99CHDWoEWGcQ/BXCbTgmCJeTZgPBiuOw7QcCvd?=
 =?us-ascii?Q?dF+HkaVBZEqvaYi44nIUynxbKjGB8pWDpq1VyNSkfXCmJA0jk7YC59zXEwUC?=
 =?us-ascii?Q?cWHcC+g9s08NSjoRDli6c3JZqm6DrAtivtR8lbI6BZygKG1tD9lm3PwXiSiO?=
 =?us-ascii?Q?Q7KOtfcBCNBwawY1i2+bUNlvs2fz9WW4ZbwCXrdU3h6k9O39MwQI3MhLUmMx?=
 =?us-ascii?Q?BeQIk3ARNZlUmHZsOWcLhIK8U1cxwXVYulcr1vFeWaAJo5wu/v1yIyHUPkOy?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2525d8a4-dc5f-4921-de10-08dc36877e72
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 04:57:55.1083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1C9E0lFkc+3zKKm4vNAzs16hN2ZWC+XZY6h+StYWLcXNg4oaffjf1ri3xxDZmLrfEdhMHEjdYLq66V0a1BiWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/apic/io_apic.c" on:

commit: c3842e43d9d6b013a40adaea274b663936b14e32 ("genirq/irqdomain: Don't call ops->select for DOMAIN_BUS_ANY tokens")
https://github.com/avpatel/linux.git riscv_aia_v15

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------+------------+------------+
|                                              | b2f92d2cd4 | c3842e43d9 |
+----------------------------------------------+------------+------------+
| boot_successes                               | 9          | 0          |
| boot_failures                                | 0          | 9          |
| kernel_BUG_at_arch/x86/kernel/apic/io_apic.c | 0          | 9          |
| invalid_opcode:#[##]                         | 0          | 9          |
| RIP:setup_IO_APIC                            | 0          | 9          |
| Kernel_panic-not_syncing:Fatal_exception     | 0          | 9          |
+----------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402261004.1e2e3e3e-oliver.sang@intel.com


[    1.220067][    T0] ------------[ cut here ]------------
[    1.220987][    T0] kernel BUG at arch/x86/kernel/apic/io_apic.c:2405!
[    1.222098][    T0] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[    1.223160][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc5-00033-gc3842e43d9d6 #1
[    1.224620][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.226289][ T0] RIP: 0010:setup_IO_APIC (arch/x86/kernel/apic/io_apic.c:2405 (discriminator 1)) 
[ 1.227203][ T0] Code: 2d 17 73 36 00 31 db 85 ed 7f 14 e9 ef 01 00 00 83 c3 01 39 1d 03 73 36 00 0f 8e e0 01 00 00 89 df e8 f6 42 1c fb 85 c0 74 e6 <0f> 0b 41 83 c5 01 44 3b 2d e5 72 36 00 0f 82 66 02 00 00 48 c7 c5
All code
========
   0:	2d 17 73 36 00       	sub    $0x367317,%eax
   5:	31 db                	xor    %ebx,%ebx
   7:	85 ed                	test   %ebp,%ebp
   9:	7f 14                	jg     0x1f
   b:	e9 ef 01 00 00       	jmpq   0x1ff
  10:	83 c3 01             	add    $0x1,%ebx
  13:	39 1d 03 73 36 00    	cmp    %ebx,0x367303(%rip)        # 0x36731c
  19:	0f 8e e0 01 00 00    	jle    0x1ff
  1f:	89 df                	mov    %ebx,%edi
  21:	e8 f6 42 1c fb       	callq  0xfffffffffb1c431c
  26:	85 c0                	test   %eax,%eax
  28:	74 e6                	je     0x10
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	41 83 c5 01          	add    $0x1,%r13d
  30:	44 3b 2d e5 72 36 00 	cmp    0x3672e5(%rip),%r13d        # 0x36731c
  37:	0f 82 66 02 00 00    	jb     0x2a3
  3d:	48                   	rex.W
  3e:	c7                   	.byte 0xc7
  3f:	c5                   	.byte 0xc5

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	41 83 c5 01          	add    $0x1,%r13d
   6:	44 3b 2d e5 72 36 00 	cmp    0x3672e5(%rip),%r13d        # 0x3672f2
   d:	0f 82 66 02 00 00    	jb     0x279
  13:	48                   	rex.W
  14:	c7                   	.byte 0xc7
  15:	c5                   	.byte 0xc5
[    1.230283][    T0] RSP: 0000:ffffffffb3e07e98 EFLAGS: 00010286
[    1.231291][    T0] RAX: 00000000ffffffed RBX: 0000000000000000 RCX: ffff88810c8500c0
[    1.232610][    T0] RDX: 00000000ffffffed RSI: ffff88810ca0c200 RDI: ffff88810c841780
[    1.233944][    T0] RBP: 0000000000000001 R08: ffff8883ace8de20 R09: ffffffffb0fdd404
[    1.235267][    T0] R10: ffffffffb0fdd3b3 R11: ffffffffb0fdd404 R12: 0000000000000000
[    1.236609][    T0] R13: 0000000000000000 R14: 0000000035646000 R15: 00000000000147b0
[    1.237949][    T0] FS:  0000000000000000(0000) GS:ffff8883af200000(0000) knlGS:0000000000000000
[    1.239398][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.240513][    T0] CR2: ffff88843ffff000 CR3: 00000000a5a5a000 CR4: 00000000000000b0
[    1.241853][    T0] Call Trace:
[    1.242438][    T0]  <TASK>
[ 1.243005][ T0] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 1.243705][ T0] ? do_trap (arch/x86/kernel/traps.c:113 arch/x86/kernel/traps.c:154) 
[ 1.244426][ T0] ? setup_IO_APIC (arch/x86/kernel/apic/io_apic.c:2405 (discriminator 1)) 
[ 1.245268][ T0] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:175) 
[ 1.246079][ T0] ? setup_IO_APIC (arch/x86/kernel/apic/io_apic.c:2405 (discriminator 1)) 
[ 1.246909][ T0] ? handle_invalid_op (arch/x86/kernel/traps.c:213) 
[ 1.247760][ T0] ? setup_IO_APIC (arch/x86/kernel/apic/io_apic.c:2405 (discriminator 1)) 
[ 1.248554][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:266) 
[ 1.249349][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 1.250213][ T0] ? kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 1.251056][ T0] ? kasan_save_stack (mm/kasan/common.c:48) 
[ 1.251893][ T0] ? kasan_save_track (arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 mm/kasan/common.c:70) 
[ 1.252737][ T0] ? setup_IO_APIC (arch/x86/kernel/apic/io_apic.c:2405 (discriminator 1)) 
[ 1.253552][ T0] ? setup_IO_APIC (arch/x86/kernel/apic/io_apic.c:2405) 
[ 1.254346][ T0] ? enable_IO_APIC (arch/x86/kernel/apic/io_apic.c:572 arch/x86/kernel/apic/io_apic.c:1413) 
[ 1.255189][ T0] apic_intr_mode_init (arch/x86/kernel/apic/apic.c:1408) 
[ 1.256061][ T0] x86_late_time_init (arch/x86/kernel/time.c:101) 
[ 1.256906][ T0] start_kernel (init/main.c:1036) 
[ 1.257727][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:543) 
[ 1.258620][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:485 (discriminator 17)) 
[ 1.259475][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 
[    1.260492][    T0]  </TASK>
[    1.261046][    T0] Modules linked in:
[    1.261762][    T0] ---[ end trace 0000000000000000 ]---
[ 1.262672][ T0] RIP: 0010:setup_IO_APIC (arch/x86/kernel/apic/io_apic.c:2405 (discriminator 1)) 
[ 1.263554][ T0] Code: 2d 17 73 36 00 31 db 85 ed 7f 14 e9 ef 01 00 00 83 c3 01 39 1d 03 73 36 00 0f 8e e0 01 00 00 89 df e8 f6 42 1c fb 85 c0 74 e6 <0f> 0b 41 83 c5 01 44 3b 2d e5 72 36 00 0f 82 66 02 00 00 48 c7 c5
All code
========
   0:	2d 17 73 36 00       	sub    $0x367317,%eax
   5:	31 db                	xor    %ebx,%ebx
   7:	85 ed                	test   %ebp,%ebp
   9:	7f 14                	jg     0x1f
   b:	e9 ef 01 00 00       	jmpq   0x1ff
  10:	83 c3 01             	add    $0x1,%ebx
  13:	39 1d 03 73 36 00    	cmp    %ebx,0x367303(%rip)        # 0x36731c
  19:	0f 8e e0 01 00 00    	jle    0x1ff
  1f:	89 df                	mov    %ebx,%edi
  21:	e8 f6 42 1c fb       	callq  0xfffffffffb1c431c
  26:	85 c0                	test   %eax,%eax
  28:	74 e6                	je     0x10
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	41 83 c5 01          	add    $0x1,%r13d
  30:	44 3b 2d e5 72 36 00 	cmp    0x3672e5(%rip),%r13d        # 0x36731c
  37:	0f 82 66 02 00 00    	jb     0x2a3
  3d:	48                   	rex.W
  3e:	c7                   	.byte 0xc7
  3f:	c5                   	.byte 0xc5

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	41 83 c5 01          	add    $0x1,%r13d
   6:	44 3b 2d e5 72 36 00 	cmp    0x3672e5(%rip),%r13d        # 0x3672f2
   d:	0f 82 66 02 00 00    	jb     0x279
  13:	48                   	rex.W
  14:	c7                   	.byte 0xc7
  15:	c5                   	.byte 0xc5


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240226/202402261004.1e2e3e3e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


