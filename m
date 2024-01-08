Return-Path: <linux-kernel+bounces-19639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A4E827023
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3EC1C2299A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D344C9C;
	Mon,  8 Jan 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy2B6JYn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6545944
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704721502; x=1736257502;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3mAzjBPGd+b7Z1Fnhg/w8Y5SlvRdFbX+ohxMbS7+RfQ=;
  b=Qy2B6JYnm+p8HK/36vucrREAZLTIb3vX90Rr41K0pJ8T2074+Nh0mymG
   YgUPW+3oXPuRuNSvTviZz1kn5pOLR8u/xO817xzZ2GzyMu+5SEvT3S3tD
   VRyHcf/zGMjKLPzTHESQ5PTyFP+vgNdSaYu5ebXjJ9UOQY1KJjujdr/bZ
   MNwjhKrhmb5m34bkFRxFM14hiPOiue4BALI6pKFXH3KC5pF8ICa8rDULK
   hMabzvTqxRvaDbuoIhUST4kjvBlRWMGw5kTKbJi1XhThu0tZ+dL8USQhZ
   pkpntxYXhbRz3yvPy7Qfj87TUnn+mZUUYmtXaDx29ANstRnvnB+xGlsOU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="464281569"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="464281569"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:44:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="924871895"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="924871895"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 05:44:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 05:44:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 05:44:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 05:44:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 05:44:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwe7smSHs1nQJYiglaaQgHSXfz8PLMuS7TJsZvw/NFpNzB5yo/97igrjM501YOFEDfkqV3dVDrGNnGPupOFfB3gBmvkSzf1yOcBZv2lY55lm8RtYT8to2QFWBY4p0pUnEFXvNMJSWfwlfC3RZMljuJjp55k3hn/ioApKfig3s6oY4WLNnn2Rikd/5vXOj47Q2MNA2cp3QJUM9o1DRI+oEvM5xq8BxJYjdCIepj89s+685Qbd/xz88NzKkzY1SL3GcHki1oaCgXAtUakY8iF0NFT3eANNKREoyXbuqDUrOdWGE720jgVxqypVOI5nZ3AdXhhhm1Qe7VGJGlO1Ul1tFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjSdV1PSUMgyCMUDMIT2h0s6cYHBCZcnHfOHYHQKDzA=;
 b=cgsKaeq/fXisk/ulQT/DCSIWmMXL7fv35yGYrjhO0hy/9WsTffHYFjAM+oiy+v4cjfjiFzTerrPsEH55mvGSaLQHFYPp1ItBdR8JT7kcDatznMsnsOdpoNhEmiXVfx+yxxaL94QQ/6yJ4kaHub7uVrMe/Xh516XxAsuOWYq4fzy7t4PQDRxgEOPe/eVvR/KsPNlvawGORPvjWVo4p16obHKX77ypnXUQT+pxLYSC1op+6gf08TrALFoVEKMPjUkj/jMFYLoF0geSI5xxFzkXuMxyMElPEWL45hsUDI1ki3J60nYLsSu/egZF1EXAEBp+8I8qEt6lYBq9MPJfksjEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:44:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:44:40 +0000
Date: Mon, 8 Jan 2024 21:44:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jiri Wiesner <jwiesner@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Feng Tang
	<feng.tang@intel.com>, <linux-kernel@vger.kernel.org>, John Stultz
	<jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd
	<sboyd@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <202401082125.4ec42f71-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103112113.GA6108@incl>
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 4236dced-e284-4e48-593a-08dc104ff6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66lKhCeUK0l0NTHy5ySopc9cy9reVNihEFFe4kGTLFMPiXqxXg9x0Oc3iK+yGzefVAfa0lNCtVPIUOS7HFQXbjWEfnwjsldRUp6Zw87NkPszvkGwP9Gvcqz23Bq0KcTuJdUE48fPippHUq/6ltF2cgtl6ixprMZIRgwX93fFKFb2qIMNEb0vgVmaE76CPj2v0Y7YtmaVQ1bU9+p3KuRkvx6C9qXTldoXefscJmzHbucnWj6QKspvTWEu2r2FFQIM7hbDQijvUr/5I0C3BtbQkTXb58SaefdrXYVG0CSnYSMFgpTRjqmDgREawDirQ5kr5R/q2/j2Mb++LIEX66dNH0P+YekVHb2rgCR3GnYAEHVvvCIVUqPWTAFNUYZWhU51ou8al4JZCWwmlorui3CXoCsQ07mJQ0xPIf3jfXERjeVXK4rkovDdlZ+pPEmBAF076gaEcbbzJROgqMvvZ9/A1sU34NzBbbYZcFLg13HlWXkFxPwyqWdEqHtT5aJERQt28gJQ2isB/P0YRBHhJ27wl/PBDBXrdfKqEyOUcn/0UqxLRI0OiZ0dbf1QL2VdOppd4RVqP/q32kL/8bVGEJtT8kaEFEKUotibmfl8iOPfaGuQFDh6kC/2HQP4PYjK9/C3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(26005)(1076003)(2616005)(6666004)(6512007)(6506007)(45080400002)(478600001)(6486002)(966005)(38100700002)(36756003)(86362001)(82960400001)(5660300002)(2906002)(41300700001)(107886003)(83380400001)(54906003)(66946007)(66556008)(66476007)(316002)(6916009)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GIPRSvmqiy85W1IGrI0Z0uFXHWjB2qYoMVBYj9DEg3dUvfwa2y/8soj1+IDj?=
 =?us-ascii?Q?SiRNKYVwx1dI2gidYEviASoapvci794Jpw02NYR4XG1DDaaA5UhNItWOUHvG?=
 =?us-ascii?Q?wGv8gYGDPteRx7pfA6glG4W1j96R8RGtYL/htUXJ2ck8E2AL90fZRWb89bGq?=
 =?us-ascii?Q?SwG/Yy7OKGenL2yMfCpoke1Ya4WS5W7xbabrrnkGxAIDUZSKTbO7uoQ3TUhg?=
 =?us-ascii?Q?tuuW2ZAszTg3PPkJGQpDPAH7gxU/CEpoj5VNsyyuKahcAyCOumBmD4W5HfX6?=
 =?us-ascii?Q?wu4VaZ4712FBMmVyBzfczLhoQLQNtpFjfVbAEHog6C1T3q1bSS7hzQfjEM1r?=
 =?us-ascii?Q?wvkwEOahYnmVSlo95UoeUk7ib4+XJ+WvoyNjegibLywiRtgAWtbgFPSV+vqi?=
 =?us-ascii?Q?/2vnIETb3RiOIV1PSCwRi4lH4ioRz7zB1CtZRxV+zBqt7cKoKqbpDQuEHYTv?=
 =?us-ascii?Q?bHs6URfP7vSmcnR9G/9JF9vMvd8106X7MMlJ41Z1Io6PjsHEWYbTxhxf230v?=
 =?us-ascii?Q?EYfjPySKV4QkWhomotOKEDlEFD4WrK1IGb3yK6v/okOcWQt7P5A7MlYKZUEI?=
 =?us-ascii?Q?eRR6Hh4q9iyZm4C7fP1H+UbCDNaj3w/zu5D1GTnDeEZEz8LGOmzUYx1DLQUO?=
 =?us-ascii?Q?4xD+Z1ILdvtDB+g8DK4TFn5dJQcmcr/UCh39LkuIYhdyNmjmXhxCr3mzDmM3?=
 =?us-ascii?Q?Z63ndGH+4OFG+JP2bWOoo9ecXyvZE2JPRGM5mtXhHnHwzmUMWqGwSJOn1+O1?=
 =?us-ascii?Q?0Vbp0RZlZeEnPexsTfC7CYQwZ1QBLiudYamZH5Bezfu/hGerWNv/mDa8s5T+?=
 =?us-ascii?Q?oBPvAL1BsbmMv/waKzq4kBdpqbOP8HVM3rBeb5Pd7+pCLOiDG9GyAjZp8Iqc?=
 =?us-ascii?Q?ptINHHnkheKrYchpEWbl1yzWy+Y1d6Io9ZpYjUeyxmSpCGOcVPZyRXSwPwzw?=
 =?us-ascii?Q?cHJRmTsY3N7Vpq+5bWjzG159Hx1OHNrt8QUdgmi2ke0fDKqGkD3t1VYJv34X?=
 =?us-ascii?Q?uHrqeC8g7E3qLoiZeluJn6li1evGHz+bPKztFVhiGD4YisyogsEP0DU55pbP?=
 =?us-ascii?Q?2mbkS0DNTYRt8TTvpigz8OWx7Zz5K1wZLx8xJassjLdwoxa/pot4L1OBiqAj?=
 =?us-ascii?Q?r7U6Rq0cg7nsfxmJ4vcF8CDGG/2H+uwBO7KnCdgyxzVKPuxYlOvMoXDt+Iq0?=
 =?us-ascii?Q?ozWJQaoWNZ4IB4Hh1CaeL/73P8roYOK/PuHVRiyFepUuFU3KKXXtVabzTNTj?=
 =?us-ascii?Q?f8HxaFxCwYRiPkS5qpLAiZR2TBkIQUYNKBoSvnR69oVQpS93u3BFnUAl1/Mi?=
 =?us-ascii?Q?WNXK7e7hNTaT2LNe85fW4eIFJ+s30ZPGQ8JFf4SM7mPSSydT4aAykAQlsLmg?=
 =?us-ascii?Q?MCzWBstvbuqRv2BpAkwcGz+GqUC0YsrlP16x4QvRKc9YWCboAcsC3OlZDrXT?=
 =?us-ascii?Q?TDZPB97mEmB+E0vVMTIT+sCftfA+cnENyHC1qTH1AW5jhpZqFmxY77uqJGJ4?=
 =?us-ascii?Q?I71VYMFMJo3rT3KkV4q8QLfO6D9M3wQS3NkGlMMvYOQ4nfDpttgbbGBhEVxE?=
 =?us-ascii?Q?m2w0fGOlreNVp7uJGPB4SJD8TG8qXO+4krpY0kG8w/Upl5aat6iqR16zu8Ga?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4236dced-e284-4e48-593a-08dc104ff6af
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:44:40.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUvequoJpPK9pSYDiADUoECpLz6d5wXIiiH0A1u3hi9aU8EFjikm2GbbKVGQwDYd9xoD0tbm0l73NKkq6DtD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/time/clocksource-wdtest.c:#wdtest_func" on:

commit: ceacf0b27b5d9cdc574f8d0a0bcb11d3272e7b9f ("[PATCH] clocksource: Skip watchdog check for large watchdog intervals")
url: https://github.com/intel-lab-lkp/linux/commits/Jiri-Wiesner/clocksource-Skip-watchdog-check-for-large-watchdog-intervals/20240103-192257
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5
patch link: https://lore.kernel.org/all/20240103112113.GA6108@incl/
patch subject: [PATCH] clocksource: Skip watchdog check for large watchdog intervals

in testcase: boot

compiler: gcc-9
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------+------------+------------+
|                                                                    | da65f29dad | ceacf0b27b |
+--------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/time/clocksource-wdtest.c:#wdtest_func           | 0          | 14         |
| EIP:wdtest_func                                                    | 0          | 14         |
+--------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401082125.4ec42f71-oliver.sang@intel.com


[   54.778895][   T41] ------------[ cut here ]------------
[ 54.781279][ T41] WARNING: CPU: 0 PID: 41 at kernel/time/clocksource-wdtest.c:162 wdtest_func (kernel/time/clocksource-wdtest.c:162 (discriminator 1)) 
[   54.785405][   T41] Modules linked in:
[   54.787152][   T41] CPU: 0 PID: 41 Comm: wdtest Tainted: G                 N 6.7.0-rc2-00014-gceacf0b27b5d #1 30e4ebd22e7da702dfdab1313ae74e5a246df970
[   54.791633][   T41] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 54.795124][ T41] EIP: wdtest_func (kernel/time/clocksource-wdtest.c:162 (discriminator 1)) 
[ 54.796800][ T41] Code: ff 8d b4 26 00 00 00 00 66 90 0f 0b e9 ee fd ff ff 8d b4 26 00 00 00 00 66 90 0f 0b e9 08 fe ff ff 8d b4 26 00 00 00 00 66 90 <0f> 0b e9 76 ff ff ff cc cc cc cc cc cc cc cc cc 3e 8d 74 26 00 55
All code
========
   0:	ff 8d b4 26 00 00    	decl   0x26b4(%rbp)
   6:	00 00                	add    %al,(%rax)
   8:	66 90                	xchg   %ax,%ax
   a:	0f 0b                	ud2    
   c:	e9 ee fd ff ff       	jmpq   0xfffffffffffffdff
  11:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  18:	66 90                	xchg   %ax,%ax
  1a:	0f 0b                	ud2    
  1c:	e9 08 fe ff ff       	jmpq   0xfffffffffffffe29
  21:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  28:	66 90                	xchg   %ax,%ax
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 76 ff ff ff       	jmpq   0xffffffffffffffa7
  31:	cc                   	int3   
  32:	cc                   	int3   
  33:	cc                   	int3   
  34:	cc                   	int3   
  35:	cc                   	int3   
  36:	cc                   	int3   
  37:	cc                   	int3   
  38:	cc                   	int3   
  39:	cc                   	int3   
  3a:	3e 8d 74 26 00       	lea    %ds:0x0(%rsi,%riz,1),%esi
  3f:	55                   	push   %rbp

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 76 ff ff ff       	jmpq   0xffffffffffffff7d
   7:	cc                   	int3   
   8:	cc                   	int3   
   9:	cc                   	int3   
   a:	cc                   	int3   
   b:	cc                   	int3   
   c:	cc                   	int3   
   d:	cc                   	int3   
   e:	cc                   	int3   
   f:	cc                   	int3   
  10:	3e 8d 74 26 00       	lea    %ds:0x0(%rsi,%riz,1),%esi
  15:	55                   	push   %rbp
[   54.801794][   T41] EAX: c4a1fe8c EBX: 00000004 ECX: 00000000 EDX: 00000000
[   54.803569][   T41] ESI: c4a1ff2e EDI: 00000000 EBP: c74aff70 ESP: c74aff60
[   54.805314][   T41] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
[   54.807278][   T41] CR0: 80050033 CR2: ffda9000 CR3: 05979000 CR4: 000406d0
[   54.808856][   T41] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   54.810216][   T41] DR6: fffe0ff0 DR7: 00000400
[   54.811218][   T41] Call Trace:
[ 54.811950][ T41] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 54.812840][ T41] ? wdtest_func (kernel/time/clocksource-wdtest.c:162 (discriminator 1)) 
[ 54.813801][ T41] ? __warn (kernel/panic.c:677) 
[ 54.814643][ T41] ? wdtest_func (kernel/time/clocksource-wdtest.c:162 (discriminator 1)) 
[ 54.815628][ T41] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 54.816581][ T41] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 54.817506][ T41] ? handle_bug (arch/x86/kernel/traps.c:216) 
[ 54.818420][ T41] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 54.819425][ T41] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 54.820438][ T41] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 54.821374][ T41] ? wdtest_func (kernel/time/clocksource-wdtest.c:162 (discriminator 1)) 
[ 54.822318][ T41] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 54.823284][ T41] ? wdtest_func (kernel/time/clocksource-wdtest.c:162 (discriminator 1)) 
[ 54.824248][ T41] kthread (kernel/kthread.c:388) 
[ 54.825093][ T41] ? wdtest_ktime_read (kernel/time/clocksource-wdtest.c:105) 
[ 54.826132][ T41] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 54.827307][ T41] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 54.828219][ T41] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 54.829331][ T41] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 54.830310][ T41] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   54.831287][   T41] irq event stamp: 879
[ 54.832154][ T41] hardirqs last enabled at (889): console_unlock (kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 54.833838][ T41] hardirqs last disabled at (898): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 54.835567][ T41] softirqs last enabled at (918): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 54.837246][ T41] softirqs last disabled at (907): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[   54.839049][   T41] ---[ end trace 0000000000000000 ]---
[   54.840178][   T41] clocksource: Not enough CPUs to check clocksource 'wdtest-ktime'.
[   54.841774][   T41] clocksource_wdtest: --- Done with test.



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240108/202401082125.4ec42f71-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


