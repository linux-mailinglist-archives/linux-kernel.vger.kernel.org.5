Return-Path: <linux-kernel+bounces-71347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC25085A3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C2B2845A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107532E854;
	Mon, 19 Feb 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7Y5z2FC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE392E821
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347011; cv=fail; b=qydQgywLk+zEhj0KOfXBswRVGmq3L0gkhj9XJP8CqQn+Xl3iqT1jeq0sQm3tq9VAb/KTenAdRQNddtdqWy3r5cjwvApZRwHKmuKmvy6+fQyLiAXPWzE8QR7ZSEVOcKT1qICZNQ7CNHZGG2dzcBnc8LQkvWNopOyxtX+xSDDg4f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347011; c=relaxed/simple;
	bh=qTKMEP6Ciq0FIDkOzyrVlL/+G84i5zXzPm3W/gyyQ1k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qVrPxyGYvoyyB0ceOaTgO5CFKXwI2hxeNEsYMfrl0DJbDgOTxIn272FdEcfS5qhGp9tbEvC+hmJPdfEfk4p4ZKg4VHOLerbSNINtH28Ibl2lsLtfxT1M1vi3LFjX48unrjEzW77k948mY9MXPaSKbwIuhEoPuXI03WRLpNG+uMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7Y5z2FC; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347010; x=1739883010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qTKMEP6Ciq0FIDkOzyrVlL/+G84i5zXzPm3W/gyyQ1k=;
  b=K7Y5z2FC1nAcu2ftkjLku/tSICcbrnKpYFAc+wVPc/kGsiv5X+QbLS6g
   saAnrJ6SOAXNI7ymBvQOJHAlyHMNg+S3YHiVAykKss9R2T5Y6swKJ8AkD
   9pHYy2X9Q0PTz3BJ57m9ZwkdlXNUa8zcpaw5vIRIEF/vi4rTo0JuTOhQ8
   sBZq9Usr45Ji/dMje9Pm9U8LksHjSO5Fi1VF+hfX1KfGpWGo7lX6FXnOn
   /gICVWkjVG+6Fjoj6fEAl6YLCmB8jrY25I5QaZS5J9qzGF7cwsKZ6yoCt
   0aeeOR2tiTwYdau0wwPICIuKNOCUbJ01nY02/tlSkZ2mPx5kIPpqfNbql
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2868515"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2868515"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:50:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9153438"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 04:50:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 04:50:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 04:50:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 04:50:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVx9d4/HqvUMEL49ZkY1S8LkI/7VlSBMG01PW7PKhQRsXeeqvfsLVDSMysXSrpHu2GDTKxseYCqqZU0kEmCjDm5kazPsNZfyZMmY7gtPpHajDnEJS4rbCvrzy5hhv5bOChMqWSnXFXRHakiIlnPXmevA7QaEOrsb21pUcVOOxNdFy+CLxQmiFXI5K3J52zINwW0MIgtMx5bnWoqVoQqYkCIjQuRr0sfDGKiPKpbcYdtiKw9Cn0WBmQkUgNm/dBWZqE5/+sPl5c3jmUjh3zx3eFjO4YP2c5iYaJsS7y5X0L72e/aLLvtO1mNdML5JKxKSLc+QG+OADFSXWa0FckpJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W8yjTDgqGkwhvRE0S0SCWNde2y0xY40iClCI7SLNGA=;
 b=Eyhewjkpflwh+dxDVBJ7v9TDNs3JEpCQ6lMIlkgfMT73FCzGTS1FJjPPx5Q5bTI+fqPLJr3CBBq3r+IUf8V333WiuAGCScbiicOpt95pmOjnXZGrH5TxKkJ/jnMuSlIFaHl+BgeMAmLQ6SbV8NwxYOp8M2K4UkgsSt+76/ZaLmFECwt4KOAljVOHMYq2KyDYwS6FygBZ1JFE2hcIxb5SScU89izrL/bYAoUSPlOYuhcigDk+PIM4YbaVXOgN9E5BC8UF8HJ1EjfO4b66CbREUP7+JiWStFfP8xyFhDTcjBNvvOIxuQ9khmnL5Cs6izXBlMW42aKdygM/Xx57XI+2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 12:50:06 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 12:50:05 +0000
Date: Mon, 19 Feb 2024 20:49:51 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <aubrey.li@linux.intel.com>, Tiwei Bie
	<tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, "Aaron
 Lu" <aaron.lu@intel.com>
Subject: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <ZdNOb7fOLIoY5sgW@chenyu5-mobl2>
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dd8d86-ac0e-4020-28db-08dc31494bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1lYE1w7cE/3iFAAFc/z5QcwL+PIj/7So5CFsupwW6ydxfjVBycSLWehAJhZ3noXhf8JeJ2c6MshJnLYzqUol9xC7yIPymhjpS1e5x+r6vT3SpE6NWkAmeoIOMzAgZJM/Lw4WMgQVeeoOxQtg6KeYazev4ZTnSh9erm2zZHuPzDpxMaWleOAPfINNs8wxvr0KOSmdPN4eTmIy1UZhzwppPcjx+Kc8DLAPe4ytl/bxbcr+V5pOqeqyQSEgy3knQYl5APnCV+q8DNsxLhcY1vDPS88v5QxSlsRLfV/lxzt6Ze+xnA3aU7Sk5NQR/DSQ5BGICPzjw9fj5b/kh1TEYe4eo+K+P7aOvHTrOEVLCgzIUCPNj7pmxPRIOWzn4UQuLn6uHYd1IKNBAhTwaWSU0TqxASPJOcE75tVPCeyctFuIkPLkTrVZMV9mRuUIErYb/H6VRyKtvQrtgr4ahW5Da81e/KRs61yVV23Vo1TD2QR7wGSvuDQzuXW4SAtVvef3U9enEUhpFxGn3T72iKlKpiDnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5Scrmq5Vhht+qJJElHCCR6Pp6bFqEMsmYWg5r4gYOByvqbCPzCzmCNiKtTs?=
 =?us-ascii?Q?Y5NSiyF6lTfmp9IpcXDeQgv45GbqRHg0Jfrer/8trTH+4Hp8HdLFVumSSnzD?=
 =?us-ascii?Q?LbEfQLpSBnDHCKOBVsG5j8xOL7+P/Rehxf01PmxAlwknESaK9Dlv4O54kcIy?=
 =?us-ascii?Q?3aGTYXUrdKLMcChT2b+99jxf0VFV8mFUokOSbNQsuH4H++ntXgQJ9fbyrApR?=
 =?us-ascii?Q?9E3CAoyaivX7ixugb9PWRAb46EYW1zdfSEEb/OVwBfqfxztSZU9Q/Z77Knv7?=
 =?us-ascii?Q?XybvBNX90CM0Ix3uFBG9dDbe06MbJJtkeCjFOYL6lYMTo/HSw7UAV/RboQt/?=
 =?us-ascii?Q?APrO5xk30YuclZRTBeWv4W/tyFJ08P7Xuk0C8kSewAx50/24b15jPmL0lvIM?=
 =?us-ascii?Q?44YpyxgSAIY4zvVVbsCDWQR+yrRBTeexo6pYMsLqlKLjDFpvWOWT10OGAr8d?=
 =?us-ascii?Q?fdeqaA51PKwr7O3erGmKIpci8yEE7kwaMGNpxvWZ+EGN9kf6W7ld7E+j3svc?=
 =?us-ascii?Q?b28hV1JFfOYdC048Qqrveiwoup9SE/MemI+oPs3SQybG4r/5cyEabQLJfdAA?=
 =?us-ascii?Q?ZWhQX7RHsaHj2pPkS2s4BwuQRKB/Twdy72IX+XF+tr5nIzqi2mIwU6H2vDDi?=
 =?us-ascii?Q?JWykgxfHs08G3WAbZWe28i0j035sz3grqVgRuK2RQMxWHhQl6S5k8DAV5nfg?=
 =?us-ascii?Q?ljA6b0d4kFVMygCyL6ZhHrle8wM6o/wHmwEZOUv9X17rJ6VkkG2799wVFEl+?=
 =?us-ascii?Q?7WyeCddyXo2CyyOFP6wWiMtzkcTqORID3wCEUfnTq4U7lMHLQfjPyegKAhft?=
 =?us-ascii?Q?5nn7E33KJLxEd7TvyfLd4+vdLV0oOZ2oFYsdXdWJcZNASMy951F/WXLyOPPc?=
 =?us-ascii?Q?UNHyBHaSTCAwed4QaabZ62P5S2BEmsOA1il+e/7JBYIjGDqocobPjlfAze3P?=
 =?us-ascii?Q?yNfKoEmxeKGD3E8nfuDaQTVhiXurmnNIjt1dctKjR6Jr8sygKPhs247kxueI?=
 =?us-ascii?Q?1JNHoFzuGCkVGTxruJqtZgGCEQ53bEKEapraEFU0xXc2f1kBs27ZCqRvspfT?=
 =?us-ascii?Q?Nhy+K8095JmgJvUXjzwP2FagiZQbaQqATsuVsADTfyK2gXxS1WaXQab6933+?=
 =?us-ascii?Q?EBw+TwyRruyQpeV+zjQrYfoOn5IsuUWfcFpqzfFKWlr+3u9/Ij8+CzTJjc/D?=
 =?us-ascii?Q?HashukYPnyZOQGF7NpjcsbrjXQjmogBF9Y0PMIcd9gztdxP4Ec5w23o1T4Vt?=
 =?us-ascii?Q?l9lfnWvMCQlWVNcge/EBBs/mM4A9t7f/CWEb5ZcApIMWCXgK8/5wqM7qQG7u?=
 =?us-ascii?Q?UcqwoOdoLw0YK/Ylsbwe8kfWk4kk4m0HevWbzWEP1pm3iWM5HPDG80oWIfCK?=
 =?us-ascii?Q?4vrpnG4Ar2d7bIPKi7pxnt/KTPFa/Ds0Yr0MXV3yEbrtYZQrocBmp3aAXx1B?=
 =?us-ascii?Q?Z2Htgi60NeN2YpYIimV6UdjJtsCyowUkgzAOnmCoMdfrtbkk3NJg6epVFJv1?=
 =?us-ascii?Q?5rq7d9KJVV3lA9/WPjvX0qXRQb7DfVqOnqXthP37zzR8cuYPaigid5aSZ7ZQ?=
 =?us-ascii?Q?HdyqKsT8/EnENFWo1TzeDfMeFlzbq8USNnjQ6CkI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dd8d86-ac0e-4020-28db-08dc31494bbb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:50:05.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdQFnnkegDSyZ18qepsaRky2gnGSnbwgfAM4n4gUUbqoArgI8JbqVXGhdf4MEWs6TFyauyYGFtjKimUZK4rmOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com

On 2024-01-30 at 18:13:32 +0800, Abel Wu wrote:
> On 1/30/24 3:24 PM, kernel test robot Wrote:
> > 
> > 
> > Hello,
> > 
> > (besides a previous performance report),
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > 
> > commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linus/master 3a5879d495b226d0404098e3564462d5f1daa33b]
> > [test failed on linux-next/master 01af33cc9894b4489fb68fa35c40e9fe85df63dc]
> > 
> > in testcase: trinity
> > version: trinity-i386-abe9de86-1_20230429
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	group: group-03
> > 	nr_groups: 5
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> > 
> > 
> > compiler: clang-17
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > we found this issue happens in very random way (23 out of 999 runs).
> > but keeps clean on parent.
> 
> Thanks for reporting, I will try to reproduce the issue. Does the 'parent'
> mean the same code branch without this commit?
> 
> > 
> > 84db47ca7146d7bd 2227a957e1d5b1941be4e420787
> > ---------------- ---------------------------
> >         fail:runs  %reproduction    fail:runs
> >             |             |             |
> >             :999          2%          23:999   dmesg.BUG:kernel_NULL_pointer_dereference,address
> >             :999          2%          23:999   dmesg.Kernel_panic-not_syncing:Fatal_exception
> >             :999          2%          23:999   dmesg.Oops:#[##]
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202401301012.2ed95df0-oliver.sang@intel.com
> > 
> > 
> > sorry for below parse failure which caused no real line numbers.
> > we will follow further. the orgial dmesg could be fetch from below link.
> > 
> > 
> > [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
> > [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> > [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> > [  512.082337][ T8305] *pde = 00000000
> > [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> > [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
> > [  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> 
> There was actually a NULL-test in pick_eevdf() before this commit,
> but I removed it by intent as I found it impossible to be NULL after
> examining 'all' the cases.
> 
> Also cc Tiwei who once proposed to add this check back.
> https://lore.kernel.org/all/20231208112100.18141-1-tiwei.btw@antgroup.com/
> 
> Thanks,
> 	Abel
>

While looking at pick_eevdf(), I have a thought.
Currently the sched entity is sorted by their deadline. During task
pickup, the pick_eevdf() scans for an candidate sched entity with the
smallest deadline. Meanwhile this candidate sched entity must also be
eligible.

The scan is O(lgn) on average, and O(1) at best case. How about making the
average scan even faster by sorting the sched entity not only by deadline,
but also the eligibility? The idea is that, the eligible sched entity with
smaller deadline is sorted at the front the tree. Otherwise, if the entity
is not eligible, even if it has a smaller deadline, it should be sorted
at the end of the tree.

After the change, pick_eevdf() get the leftmost sched entity at O(1) on
average. Besides, it is guaranteed to return non-NULL sched entity in
pick_eevdf(), which prevents suspicious NULL pointer exception in pick_eevdf().

For example, suppose there are two sched entities to be queued, se_a and se_b.
Consider their eligibility and deadline, there are 6 combination:

1. se_a is eligible, se_b is eligible, se_a.deadline < se_b.deadline
2. se_a is eligible, se_b is eligible, se_a.deadline >= se_b.deadline
3. se_a is eligible, se_b is not eligible
4. se_a is not eligible, se_b is eligible
5. se_a is not eligible, se_b is not eligible, se_a.deadline < se_b.deadline
6. se_a is not eligible, se_b is not eligible, se_a.deadline >= se_b.deadline

In scenario 1, 3, 5, sched_entity se_a should be sorted before se_b,
so pick_eevdf() would pick se_a first.

When enqueuing a new sched entity, it is regarded as eligible if its
vlag is positive. In theory later in pick_eevdf(), the eligibility
of this sched entity should be re-checked via entity_eligible(). But
consider if the sched entity is eliglble when enqueued, it is very
likely the same sched entity remains eligible when pick_eevdf(), because
the V keeps moving forward but the vruntime of this sched entity remain
unchanged - the vlag could get larger.

Something like this untested:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..831043cc1432 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -551,11 +551,19 @@ static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
 static inline bool entity_before(const struct sched_entity *a,
 				 const struct sched_entity *b)
 {
-	/*
-	 * Tiebreak on vruntime seems unnecessary since it can
-	 * hardly happen.
-	 */
-	return (s64)(a->deadline - b->deadline) < 0;
+	bool eli_a, eli_b;
+
+	eli_a = (a->vlag >= 0) ? true : false;
+	eli_b = (b->vlag >= 0) ? true : false;
+
+	if ((eli_a && eli_b) || (!eli_a && !eli_b))
+		/*
+		 * Tiebreak on vruntime seems unnecessary since it can
+		 * hardly happen.
+		 */
+		return (s64)(a->deadline - b->deadline) < 0;
+
+	return eli_a ? 1 : 0;
 }
 
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -877,10 +885,8 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  */
 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
-	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
-	struct sched_entity *best = NULL;
 
 	/*
 	 * We can safely skip eligibility check if there is only one entity
@@ -899,45 +905,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
 		return curr;
 
-	/* Pick the leftmost entity if it's eligible */
-	if (se && entity_eligible(cfs_rq, se)) {
-		best = se;
-		goto found;
-	}
-
-	/* Heap search for the EEVD entity */
-	while (node) {
-		struct rb_node *left = node->rb_left;
-
-		/*
-		 * Eligible entities in left subtree are always better
-		 * choices, since they have earlier deadlines.
-		 */
-		if (left && vruntime_eligible(cfs_rq,
-					__node_2_se(left)->min_vruntime)) {
-			node = left;
-			continue;
-		}
-
-		se = __node_2_se(node);
-
-		/*
-		 * The left subtree either is empty or has no eligible
-		 * entity, so check the current node since it is the one
-		 * with earliest deadline that might be eligible.
-		 */
-		if (entity_eligible(cfs_rq, se)) {
-			best = se;
-			break;
-		}
-
-		node = node->rb_right;
-	}
-found:
-	if (!best || (curr && entity_before(curr, best)))
-		best = curr;
-
-	return best;
+	/* Pick the leftmost entity */
+	return se;
 }
 
 #ifdef CONFIG_SCHED_DEBUG
-- 
2.25.1


