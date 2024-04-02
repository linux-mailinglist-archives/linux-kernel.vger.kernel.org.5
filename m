Return-Path: <linux-kernel+bounces-127310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41789497B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323FF286547
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C161119B;
	Tue,  2 Apr 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqI58sUd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1D6FB5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025421; cv=fail; b=kiSA7HESLkSsViS2IjZaSIesqIF85ph8VeAqjCIRqzPwaA7WAWSa+H5/u8p1yxBr4pcUVvdQ9HyG2LBUHWsLONWpJ0E3p+KDis6qVOnOo+OfRXV/Pdl8PCg8Ii1caCOkI0o0w0cMStfdMm1c++dgDmMOxrl/HO2jriGZzaSrbVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025421; c=relaxed/simple;
	bh=U19idUaVpaylVNi2kGQKhxWZf/sTTgY07jzWjlnx9H8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y5WtzkyRUi/kq7PzS9LCApQrYd/ViMN2CzUtqPS5SyR0/ipDc/F8l6FiOyOLMHqvnIw/AwUUPwmdNP0Ug3y9dS4sAqOVkt0RbIF+Xh11m2gvNdkw7yWtGvTas7aGaY+6LM4vZAl7a4Kmqh9zAPoIAlyNqEg/j2osfqMdC0NLK5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqI58sUd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712025419; x=1743561419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U19idUaVpaylVNi2kGQKhxWZf/sTTgY07jzWjlnx9H8=;
  b=UqI58sUdRrzu/vTdY9mWOoQmQ5xssqvMKDcWPWdAkauu3U7hglEkaLMu
   M2dI63Zv+AjSkMFMtzhyEwa6BpX2a0TXhozwwPXEIst+Sesp0kVIJ+inz
   hS2Gt3qrDTHHuHcqglhnMeys1D+lszb0W28AiI35NnaOeN3+vacTVQcNf
   CuotYD9WPJ9GN5rG4qG94ocg1XR1zfcpXA5lKhCky5VsOx/7kSwlEK7PB
   uuSTRNleJ/vGySA5TsDfKG6McbwLtHZy4+PEokb/EaUGOTtdJx8HViHE1
   fXmo3Pz9T8ShbwkOuy+0aTBvF2F+UzK62tNKv7Kmrwi/NBfsbdhA8SrdK
   A==;
X-CSE-ConnectionGUID: 3cqessbYRKecQ1NSdbF1Ng==
X-CSE-MsgGUID: 13yly8KVQ0K3+W0es/Ihvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7362946"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7362946"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="55361951"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 19:36:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 19:36:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 19:36:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 19:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbVn/Q1y7JVlyyaldWZ67q6zAbpn1LHS+jO4GRCST0X3BGRkH9rn8abiXxxt5KEBMzohAzflpo3inEbI1dsNPSkSIyIZJbtwQy/CT6i2pArwpECFFmkJGPsm0rUw6NllY2aIS0Ijl7MPbJ668WPoGAdmDzfWBahIhke54hE7qo2ehNWYQwjg+IBzMSUQOXRZdevtnhx24Vr0s4uG76GWpBjB983fURboQogdqGGGWIYd6kEAdcPYM9Nac5mGWsNEYLPg6FtMk6VIq3Cjs0fT2T+nL4iKzCZj05k4l14gDpdxmWbxWq2QJdYcu9fzQdDXDnv88Re3XbkVClxiBRTVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHemFClIna4hkM6AIGucjcgYyOYHbtleUbkAQX+y3UI=;
 b=G5L5mNzn9OeaB5E6BFOCIPw7LVx1tRg45MLJgAQG9dxBsRqkZb822ugCQwMmFbQ1UPOCh1rDkx+O21MP2AK77q4X+9PJNVIQCwlj1O71NdVcYvCOPEjufAhD3Vb0m3R4AUDMznC8y64HoTLKVArg5v8J9WhgbBPYd8wVWs2RisfFlGez10Ovk6zZ4H+G5GexOeb1lMTF7yLvp/qdhIOCetKwoAVxqd9D8ACT+BYQjoV2yPGSSsop0rGqc2cUY8ku5eEd+BA9J1kmT9RbzVoWJIhD+Hm/HUYiF0hho1SQ+kl+bvBBJVMm4XwxZXobwPBSELwq/GWPHmtBWsIdoVHBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB6876.namprd11.prod.outlook.com (2603:10b6:806:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 2 Apr
 2024 02:36:55 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 02:36:55 +0000
Date: Tue, 2 Apr 2024 10:36:46 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: kernel test robot <oliver.sang@intel.com>
CC: Abel Wu <wuyun.abel@bytedance.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <aubrey.li@linux.intel.com>, Yujie Liu
	<yujie.liu@intel.com>
Subject: Re: [linus:master] [sched/eevdf]  eab03c23c2:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <ZgtvPsfj7AP+A5z1@chenyu5-mobl2>
References: <202404012303.41984b81-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202404012303.41984b81-lkp@intel.com>
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB6876:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzxWvnnJ3OsNWfyMSlNNcrO4hYbsryyIIAsDp/Xfu0TpvtTqM2/hfThQ0uTtmq60W0Nd+mNT535pLZebmiOz7yPhXHYTqFvyTQKTLwWD8ViHu2AuC4XTl/jWG1KBPi9LJkRPamReTCZNyzpIPeAihBFssRQW6CwN1Ns2pVQEbnMt5OEd/mxPTJEnMJmAOtv7D+dqfMHU/WKL6NiuXNswFo7i2JtU5501GAqrRqXQ4i5O2/7sjuUaZdpRrrRxpQ8iUL5xjOai5/EiT/LZvq+BIMnRrIx+yaNeFLBkVByouiUff569VdEfqEWwMZhHSD3VEL0a1PP7abRo8S+isr/DW9lXDF5zFj8tq+AvIRtDxvXRTs9Qgze61OH4dvSG0D9XzLGBaYYpZdQGLtBxst46kB9aeitoPz37M7MstvVeXVVKi9POx8hAGaxiyVoHbIWuiYZKZCqV11iCf3iQMjrbY11aVH4oJ0sSSLfh2+hNzXrU26FGD6P3d3AgZ/MiLAT+lXmhFiPWghWqadVCi4Ds8d9zQtcTGbDVaxSxWW5+Vez+7VMK2D5WMaEsrT7jvEYwke/Lid21c9SYKFmj3aOWfrZpVBpqPAdk7QTXEgtqbBfv2xyUDr5XQAzDqLRTFkKg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yEm7KTgL/9sa5k61OXoA9HLVE0sIsdLhoawg7irFo+gL7cfw1ymQrIzwRTZu?=
 =?us-ascii?Q?Ip51ZhEeTkOwsPchGLwJBSRxou2nhT4PTwCg3vfHj6JUpswKKMtspaq9FC0Q?=
 =?us-ascii?Q?lVFM/ljvdl20iBS/leDF4/uZfQyRjsK2wUyQLjaRonpzNdEsA+PPNMP+VmRF?=
 =?us-ascii?Q?jx6DSZXzCw1mzMFxPR9rWAnXN5ja3LCo/wc8vKM8HBCnJB1RqNwOSKzWZQ0m?=
 =?us-ascii?Q?B8rmr8KdEHlDj1LVPvgQWKkEEidpmwZxh0afcUBgRYUWDKxWGXvuqZmFsQYP?=
 =?us-ascii?Q?As+Akxjao5pGszcG6D24X4zeZFHco4O50pp8db9AnOU9V+nV0OsJsyOog9mh?=
 =?us-ascii?Q?qnrelmQlB2E0vfLs2REFLdgxBCgAaY+fmKCg/3sSgncPD3Z9g3R76y+DtlPt?=
 =?us-ascii?Q?HzE9x1JTCGUxZhn0LxGO1yhvbnaJi72p6iyMbxRbXK8eoDFgYUtG0eO+bOLT?=
 =?us-ascii?Q?1lBizz0PGL2Oi5q20YZqNRx5SgVA47q2iMgdtKuRTX1hjJbBc7XpjVat30mn?=
 =?us-ascii?Q?PcefuNXNDwrxymroynBXuMixn0BthJEFHN/ps8qSQlLJo5aYv1r1VN6d6JPl?=
 =?us-ascii?Q?a5E8GX1s/uE8ON2CSFZ72oJmipnoP9iYceVcdje9jGWkPoocqJMlmXAWo7kR?=
 =?us-ascii?Q?GO9QXHuQ3KtWgflR+yhTODWVnNNAZGNDdXSNrlEldl6wtO5vq7vVey9qkPtG?=
 =?us-ascii?Q?ZKq35vLGIQfqUyhq7+kyWGzxwesx09pk9jZCMegIiCePmq4f9HXslR2TB5mQ?=
 =?us-ascii?Q?H6jN/5XBiZc5qdZw5HV3UnKtBbeHN/BTUEfutxOrKfeGYgE5O4BixlQStWhI?=
 =?us-ascii?Q?C/6ek+K/NBrrFEzw15cEK+oBoFP5ZbMBCpbJG5b7bIVziO+J0dVfVFY/LjK2?=
 =?us-ascii?Q?4fkDcO0123M4mcUxsci2BqVUmpBOhDNfapykGklm4vQkoYfdm2cjWxztys/1?=
 =?us-ascii?Q?nSdcYGJKpY6PaqBQiVyxG8TvfzUj/0P/X3vON3selJIcmNARI9X8PvhS7nTv?=
 =?us-ascii?Q?2wcETIS/qf45DYP8THnA23kJKJLuxqeATj2u5z7tvP6gTXz9fDGlvcOP7t5a?=
 =?us-ascii?Q?3Rtjell6L4+3Mpk4ex465KVPv8rVHUH38o9vihm2PgbTYviIqqxgKQ1dmP2h?=
 =?us-ascii?Q?j3E99e+lujKqNOF3kwuAQYMazPxYW/YoexZ/49IAUj96h4isP7/ZFinyBqgq?=
 =?us-ascii?Q?qFdXa/j90+bgQXKREHUHMGBF/1WvW4gXo+nnY/Upx8qMl7iC4c+ARKiXe1z5?=
 =?us-ascii?Q?tB/w5zbUUMhlqB05WjVMNr97OO5plzBG7BWtJ9R5meIWOobIcDivZ3YORrEW?=
 =?us-ascii?Q?vSN/ja4TuUQZ5tekaYK87Hhn6ZwyyJLDtpkfhSQXA1blZqk/CXT23EufuZfO?=
 =?us-ascii?Q?4k2530MJGjqEaDLTxj26oBWEXXjwjSVS60zykIQhDD3nMWxrXlOsBBZDHl2K?=
 =?us-ascii?Q?O7qdTSfDctuBoxu2BZZt0qh9k/LO0rSx5FnE0kySY7cIYKfs+uxKalvJxzGK?=
 =?us-ascii?Q?EK9RxRUYOkiWNzUdA0m1yqJjYRj2zvYE1tNuaCjDuM8bOf5RYMLbWXhHxGso?=
 =?us-ascii?Q?G2q0SqlvuhyDEkB3zsUy1OgSzgZNz6KwdZIvXdff+y65D7H3SNwCyUvTRaj4?=
 =?us-ascii?Q?6SN0X+DbA2yBX0MopmvUDf6m2s6V/mRzhXQnjK3XqNCk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5505afaf-da33-481a-ded8-08dc52bdc2e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:36:55.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoG0d966l5jP+A7ViI7AGRqL2j8L9+Wy/AwvSvfu6ZTN+5L5+V1T0995Y4bZPYNtoi0twxa3Usx6ss1kwEqN3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6876
X-OriginatorOrg: intel.com

Hi Oliver,

On 2024-04-01 at 23:21:11 +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:
> 
> commit: eab03c23c2a162085b13200d7942fc5a00b5ccc8 ("sched/eevdf: Fix vruntime adjustment on reweight")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 4076fa161217fcd64a578ca04586c4be728cb004]
> 
>

Should be the known issue that when no eligible entity is found, there was
a printk warning which triggered this. In latest kernel this printk was
removed(but yes, it could return a NULL as you reported previously). Yujie
has helped me setup the similar environment as lkp for this trinity test,
I'll do some tests to investigate the NULL pointer issue..

thanks,
Chenyu 

> in testcase: trinity
> version:
> with following parameters:
> 
>         runtime: 300s
>         group: group-01
>         nr_groups: 5
> 
> 
> 
> compiler: clang-17
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> this issue doesn't always happen, 36 times out of 308 runs as below.
> but for parent, we never observed this issue.
> 
> 
>         v6.7-rc1 eab03c23c2a162085b13200d794
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :308         12%          36:308   dmesg.WARNING:possible_circular_locking_dependency_detected
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202404012303.41984b81-lkp@intel.com
> 
> 
> [  195.727401][ T3470] WARNING: possible circular locking dependency detected
> [  195.727403][ T3470] 6.7.0-rc1-00001-geab03c23c2a1 #1 Tainted: G                TN
> [  195.727404][ T3470] ------------------------------------------------------
> [  195.727405][ T3470] trinity-main/3470 is trying to acquire lock:
> [ 195.727407][ T3470] cb267a18 (console_owner){-.-.}-{0:0}, at: console_lock_spinning_enable (kernel/printk/printk.c:1854)
> [  195.727416][ T3470]
> [  195.727416][ T3470] but task is already holding lock:
> [ 195.727417][ T3470] da2d4350 (&rq->__lock){-.-.}-{2:2}, at: __schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:560 kernel/sched/sched.h:1349 kernel/sched/sched.h:1663 kernel/sched/core.c:6604)
> [  195.727423][ T3470]
> [  195.727423][ T3470] which lock already depends on the new lock.
> [  195.727423][ T3470]
> [  195.727424][ T3470]
> [  195.727424][ T3470] the existing dependency chain (in reverse order) is:
> [  195.727424][ T3470]
> [  195.727424][ T3470] -> #4 (&rq->__lock){-.-.}-{2:2}:
> [ 195.727428][ T3470] _raw_spin_lock_nested (kernel/locking/spinlock.c:378)
> [ 195.727431][ T3470] raw_spin_rq_lock_nested (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:560)
> [ 195.727433][ T3470] task_fork_fair (kernel/sched/sched.h:1581)
> [ 195.727436][ T3470] sched_cgroup_fork (kernel/sched/core.c:?)
> [ 195.727438][ T3470] copy_process (include/linux/timekeeping.h:154 kernel/fork.c:2619)
> [ 195.727441][ T3470] kernel_clone (kernel/fork.c:2907)
> [ 195.727443][ T3470] user_mode_thread (kernel/fork.c:2985)
> [ 195.727445][ T3470] rest_init (init/main.c:695)
> [ 195.727447][ T3470] start_kernel (init/main.c:875)
> [ 195.727452][ T3470] start_kernel (init/main.c:1072)
> [ 195.727454][ T3470] i386_start_kernel (arch/x86/kernel/head32.c:79)
> [ 195.727457][ T3470] startup_32_smp (arch/x86/kernel/head_32.S:295)
> [  195.727459][ T3470]
> [  195.727459][ T3470] -> #3 (&p->pi_lock){-.-.}-{2:2}:
> [ 195.727461][ T3470] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162)
> [ 195.727464][ T3470] try_to_wake_up (kernel/sched/core.c:2232)
> [ 195.727466][ T3470] default_wake_function (kernel/sched/core.c:7020)
> [ 195.727469][ T3470] woken_wake_function (kernel/sched/wait.c:444)
> [ 195.727472][ T3470] __wake_up_common_lock (kernel/sched/wait.c:89)
> [ 195.727474][ T3470] __wake_up (kernel/sched/wait.c:127)
> [ 195.727476][ T3470] tty_wakeup (drivers/tty/tty_io.c:527)
> [ 195.727478][ T3470] tty_port_default_wakeup (drivers/tty/tty_port.c:70)
> [ 195.727482][ T3470] tty_port_tty_wakeup (drivers/tty/tty_port.c:434)
> [ 195.727484][ T3470] uart_write_wakeup (drivers/tty/serial/serial_core.c:121)
> [ 195.727486][ T3470] serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1842)
> [ 195.727490][ T3470] serial8250_handle_irq (include/linux/spinlock.h:406 include/linux/serial_core.h:667 include/linux/serial_core.h:1085 drivers/tty/serial/8250/8250_port.c:1947)
> [ 195.727492][ T3470] serial8250_default_handle_irq (drivers/tty/serial/8250/8250_port.c:1962)
> [ 195.727495][ T3470] serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:127)
> [ 195.727498][ T3470] __handle_irq_event_percpu (kernel/irq/handle.c:158)
> [ 195.727500][ T3470] handle_irq_event (kernel/irq/handle.c:193 kernel/irq/handle.c:210)
> [ 195.727503][ T3470] handle_edge_irq (kernel/irq/chip.c:833)
> [ 195.727505][ T3470] __handle_irq (arch/x86/kernel/irq_32.c:97)
> [ 195.727508][ T3470] __common_interrupt (include/asm-generic/irq_regs.h:28 arch/x86/kernel/irq.c:270)
> [ 195.727510][ T3470] common_interrupt (arch/x86/kernel/irq.c:247)
> [ 195.727512][ T3470] asm_common_interrupt (arch/x86/entry/entry_32.S:636)
> [ 195.727515][ T3470] _raw_spin_unlock_irqrestore (kernel/locking/spinlock.c:195)
> [ 195.727517][ T3470] __create_object (mm/kmemleak.c:753)
> [ 195.727521][ T3470] kmemleak_alloc (mm/kmemleak.c:761 mm/kmemleak.c:1033)
> [ 195.727523][ T3470] slab_post_alloc_hook (include/linux/kmemleak.h:42)
> [ 195.727527][ T3470] kmem_cache_alloc_bulk (mm/slub.c:4056)
> [ 195.727529][ T3470] mas_alloc_nodes (lib/maple_tree.c:165 lib/maple_tree.c:1287)
> [ 195.727532][ T3470] mas_expected_entries (lib/maple_tree.c:5633)
> [ 195.727534][ T3470] copy_mm (include/linux/mm.h:994 kernel/fork.c:681 kernel/fork.c:1691 kernel/fork.c:1740)
> [ 195.727536][ T3470] copy_process (kernel/fork.c:?)
> [ 195.727538][ T3470] kernel_clone (kernel/fork.c:2907)
> [ 195.727540][ T3470] __ia32_sys_clone (kernel/fork.c:3018)
> [ 195.727542][ T3470] do_int80_syscall_32 (arch/x86/entry/common.c:164)
> [ 195.727544][ T3470] restore_all_switch_stack (arch/x86/entry/entry_32.S:947)
> [  195.727547][ T3470]
> [  195.727547][ T3470] -> #2 (&tty->write_wait){-.-.}-{2:2}:
> [ 195.727550][ T3470] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162)
> [ 195.727552][ T3470] __wake_up_common_lock (kernel/sched/wait.c:?)
> [ 195.727554][ T3470] __wake_up (kernel/sched/wait.c:127)
> [ 195.727556][ T3470] tty_wakeup (drivers/tty/tty_io.c:527)
> [ 195.727558][ T3470] tty_port_default_wakeup (drivers/tty/tty_port.c:70)
> [ 195.727560][ T3470] tty_port_tty_wakeup (drivers/tty/tty_port.c:434)
> [ 195.727563][ T3470] uart_write_wakeup (drivers/tty/serial/serial_core.c:121)
> [ 195.727564][ T3470] serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1842)
> [ 195.727567][ T3470] serial8250_handle_irq (include/linux/spinlock.h:406 include/linux/serial_core.h:667 include/linux/serial_core.h:1085 drivers/tty/serial/8250/8250_port.c:1947)
> [ 195.727569][ T3470] serial8250_default_handle_irq (drivers/tty/serial/8250/8250_port.c:1962)
> [ 195.727572][ T3470] serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:127)
> [ 195.727574][ T3470] __handle_irq_event_percpu (kernel/irq/handle.c:158)
> [ 195.727577][ T3470] handle_irq_event (kernel/irq/handle.c:193 kernel/irq/handle.c:210)
> [ 195.727579][ T3470] handle_edge_irq (kernel/irq/chip.c:833)
> [ 195.727581][ T3470] __handle_irq (arch/x86/kernel/irq_32.c:97)
> [ 195.727583][ T3470] __common_interrupt (include/asm-generic/irq_regs.h:28 arch/x86/kernel/irq.c:270)
> [ 195.727585][ T3470] common_interrupt (arch/x86/kernel/irq.c:247)
> [ 195.727586][ T3470] asm_common_interrupt (arch/x86/entry/entry_32.S:636)
> [ 195.727588][ T3470] _raw_spin_unlock_irqrestore (kernel/locking/spinlock.c:195)
> [ 195.727590][ T3470] uart_write (drivers/tty/serial/serial_core.c:74 drivers/tty/serial/serial_core.c:617)
> [ 195.727592][ T3470] n_tty_write (drivers/tty/n_tty.c:574 drivers/tty/n_tty.c:2379)
> [ 195.727594][ T3470] file_tty_write (drivers/tty/tty_io.c:1021)
> [ 195.727596][ T3470] redirected_tty_write (drivers/tty/tty_io.c:1113 drivers/tty/tty_io.c:1136)
> [ 195.727598][ T3470] vfs_write (fs/read_write.c:492)
> [ 195.727600][ T3470] ksys_write (fs/read_write.c:637)
> [ 195.727602][ T3470] __ia32_sys_write (fs/read_write.c:646)
> [ 195.727604][ T3470] do_int80_syscall_32 (arch/x86/entry/common.c:164)
> [ 195.727606][ T3470] restore_all_switch_stack (arch/x86/entry/entry_32.S:947)
> [  195.727608][ T3470]
> [  195.727608][ T3470] -> #1 (&port_lock_key){-.-.}-{2:2}:
> [ 195.727611][ T3470] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162)
> [ 195.727613][ T3470] serial8250_console_write (include/linux/serial_core.h:? drivers/tty/serial/8250/8250_port.c:3403)
> [ 195.727615][ T3470] univ8250_console_write (drivers/tty/serial/8250/8250_core.c:601)
> [ 195.727618][ T3470] console_flush_all (kernel/printk/printk.c:2905)
> [ 195.727620][ T3470] console_unlock (kernel/printk/printk.c:3036)
> [ 195.727622][ T3470] vprintk_emit (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:2304)
> [ 195.727623][ T3470] vprintk_default (kernel/printk/printk.c:2318)
> [ 195.727625][ T3470] vprintk (kernel/printk/printk_safe.c:?)
> [ 195.727627][ T3470] _printk (kernel/printk/printk.c:2328)
> [ 195.727630][ T3470] register_console (kernel/printk/printk.c:3542)
> [ 195.727632][ T3470] univ8250_console_init (drivers/tty/serial/8250/8250_core.c:?)
> [ 195.727635][ T3470] console_init (include/linux/jump_label.h:270 include/trace/events/initcall.h:48 kernel/printk/printk.c:3689)
> [ 195.727637][ T3470] start_kernel (init/main.c:1009)
> [ 195.727640][ T3470] i386_start_kernel (arch/x86/kernel/head32.c:79)
> [ 195.727642][ T3470] startup_32_smp (arch/x86/kernel/head_32.S:295)
> [  195.727644][ T3470]
> [  195.727644][ T3470] -> #0 (console_owner){-.-.}-{0:0}:
> [ 195.727646][ T3470] __lock_acquire (kernel/locking/lockdep.c:?)
> [ 195.727649][ T3470] lock_acquire (kernel/locking/lockdep.c:5753)
> [ 195.727651][ T3470] console_lock_spinning_enable (kernel/printk/printk.c:1854)
> [ 195.727653][ T3470] console_flush_all (kernel/printk/printk.c:2901)
> [ 195.727655][ T3470] console_unlock (kernel/printk/printk.c:3036)
> [ 195.727657][ T3470] vprintk_emit (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:2304)
> [ 195.727658][ T3470] vprintk_default (kernel/printk/printk.c:2318)
> [ 195.727660][ T3470] vprintk (kernel/printk/printk_safe.c:?)
> [ 195.727662][ T3470] _printk (kernel/printk/printk.c:2328)
> [ 195.727665][ T3470] pick_eevdf (kernel/sched/fair.c:961)
> [ 195.727667][ T3470] pick_next_task_fair (kernel/sched/sched.h:1417 kernel/sched/fair.c:8377)
> [ 195.727669][ T3470] __schedule (kernel/sched/core.c:5998)
> [ 195.727672][ T3470] schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6764 kernel/sched/core.c:6778)
> [ 195.727674][ T3470] schedule_hrtimeout_range_clock (kernel/time/hrtimer.c:?)
> [ 195.727676][ T3470] schedule_hrtimeout_range (kernel/time/hrtimer.c:2364)
> [ 195.727678][ T3470] do_sigtimedwait (kernel/signal.c:3653)
> [ 195.727680][ T3470] __ia32_sys_rt_sigtimedwait_time32 (kernel/signal.c:3729)
> [ 195.727683][ T3470] __do_fast_syscall_32 (arch/x86/entry/common.c:164)
> [ 195.727685][ T3470] do_fast_syscall_32 (arch/x86/entry/common.c:255)
> [ 195.727686][ T3470] do_SYSENTER_32 (arch/x86/entry/common.c:293)
> [ 195.727688][ T3470] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:840)
> [  195.727690][ T3470]
> [  195.727690][ T3470] other info that might help us debug this:
> [  195.727690][ T3470]
> [  195.727691][ T3470] Chain exists of:
> [  195.727691][ T3470]   console_owner --> &p->pi_lock --> &rq->__lock
> [  195.727691][ T3470]
> [  195.727695][ T3470]  Possible unsafe locking scenario:
> [  195.727695][ T3470]
> [  195.727695][ T3470]        CPU0                    CPU1
> [  195.727696][ T3470]        ----                    ----
> [  195.727696][ T3470]   lock(&rq->__lock);
> [  195.727698][ T3470]                                lock(&p->pi_lock);
> [  195.727699][ T3470]                                lock(&rq->__lock);
> [  195.727701][ T3470]   lock(console_owner);
> [  195.727702][ T3470]
> [  195.727702][ T3470]  *** DEADLOCK ***
> [  195.727702][ T3470]
> [  195.727703][ T3470] 3 locks held by trinity-main/3470:
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240401/202404012303.41984b81-lkp@intel.com
> 
> 
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

