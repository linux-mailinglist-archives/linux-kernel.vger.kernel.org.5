Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A70786A41
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjHXIhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbjHXIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:37:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876E1724
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692866218; x=1724402218;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=le1oGk4RZ3UjiWNQaVF7/djLhuF1FhRrGjz9CWSSYqk=;
  b=F8jR+0CEzTQsDRBgPegPVdFO3/CN0K+rUN5KuW3deK2DWeC3IpBwE7Xk
   8Rwn369BXSL0ZcqaM3hQYSMTnMQPbddy6PWDSP/X1YdezS6XoRXgzkYgO
   Dhg+oSUPD3JhNXV6ZyzWSKId1sEes7+omBVQJREMqouRg/g+hGYR3vW09
   Rh0qMJP12NnWXsRx7R1dy2mTYZZ5IBNrthYzeC5kJRKt3FrW9MoMBsUXa
   5XUXQKZfRn5gCYo67PJTM3CTd/MpFulnhZOgaQHvYuQ8yF+ghx+r+Roqw
   4EteY1uuuVWQBzpeChARSqdpP3elidwHE7esUANchbwPgTktQuTrhaIwV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="359365960"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359365960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 01:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880714402"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 01:36:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 01:36:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 01:36:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 01:36:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 01:36:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8euyEjOC1JMgFAEO5J5zBudFiaE4z3oQTzHCnqcJ2UaH3ClsID5ruYg4zEPabac1bf4dJ/zW1Pqw8EMhxA/2jUtq6kfVabV+1Uc+rxrcfIG4NwXhKHtMfSCA9+oYFg+deYFLp/KPtrdmdQwLANupjSAPYpQXl8P+wauwcXY7aU0MP1J+d51r7pvIxSQebxl36TEA5JMVITqgblBCRRmZ82OL7op1KUQyeriBqWCPe6lCiySiBPf1xt77fU3DhMBoNFhwUhiGfZGxc6CFQEFsU/kXKbOS1KOnhAyZehhKM/yL1a58bw+s8mh0D+m86xpAHftDMl3Hgb5LJPeH/7A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg7B2Z+/DlHEen9G7atK6KfYkQEmYM/OXx9YmiYbWbc=;
 b=a0V/ZPNbdFhllYtPhmQbjj4DdvO5jxW+Ib/r//ZfJPQ7HlNczIA18J8dPw3PAlzgQq8LG+ZZYfFyfE39/hwMJ+wl78X6Ih7Fkvf9jGlt6qZBVbvpjVG/jZYrbz+YL3qXtBY2h8rlKvBsixjyxr9R1jiFLmIOVexzHEaABWh11mrqHCV6l10dbDVu0L+iPajFmduXQKR+E0NLsxd21ytmkArifyc1CPvNooRUdQ5fqGGpYHnM1ea2I1JC9HE9GNGLIl6WkLRyYXmWoPwYvPesKpm3HBdom7hItoXKoNUmUUWoaL+BeCOryR4YPfCLGBuv2igOYPQDc8GnvgJ+bDWZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 08:36:40 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::55ae:a9d8:12e6:d0c7]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::55ae:a9d8:12e6:d0c7%7]) with mapi id 15.20.6699.025; Thu, 24 Aug 2023
 08:36:39 +0000
Date:   Thu, 24 Aug 2023 16:36:27 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tio Zhang <tiozhang@didiglobal.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <jiangshanlai@gmail.com>, <zyhtheonly@gmail.com>,
        <zyhtheonly@yeah.net>, <tiozhang@didiglobal.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v2] workqueue: let WORKER_CPU_INTENSIVE be included in
 watchdog
Message-ID: <202308241637.304413c4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230822110609.GA3702@didi-ThinkCentre-M930t-N000>
X-ClientProxiedBy: KL1PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::34) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|BN9PR11MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: aa323e16-ee1f-4a54-323d-08dba47d3c3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaIkcRuHDSFM26oSXEUNnn5G7zCA9I082ajotzzkPGWHbXVEpDde1uN/kQAitHBmD/Bn2DKFL4bh5y2ZFc3MvRTCzg4s4/i80RBEtmOuqTsFfjCWVjd7D9N0du4L7qyHlXrmWnLxNybVjYdNom1n6udAZt8ANbNcRym1lbLiL5q6hJ4Ah0f+umP6NYyyllJ7pchUWOHVV63gmetIfjiHn0VE9jfXq9L4f6ga908AncF2gQ0ZbMfP30E8m2/kN0zpFqdzRfEtauI+rm1KpibIoZ9Mi+TSKaTW1rkoMsALC1Y7s0XspGiiO7f0euPehaYyV6uxz+jXbwc/XB9LANNEfeeaO0ooSNJAfasqJZZic/qjqZIn0J1aeU7KhgZGF23L7HtiTfiFRdLSL3k3HXCsdUDTa4XGHO2IZIPds3FKpMntscFuMNPxoCOhywbGGM+gvs56fnvzk+kyVFfn5NEJb+HWl/HbJvJudSrxmuW/FnXvdNfS5cC6bHG6tQeSwabSzkEl9Eu8N76CjFiTvArK/lNSrQmOmUX1dua//bJzIF47TjFE8cBda9l3PpzLQV9vm64AjIEuZ0xZ8AOftzEAew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(66946007)(66556008)(66476007)(316002)(6916009)(82960400001)(478600001)(26005)(38100700002)(6666004)(41300700001)(86362001)(6486002)(2906002)(6506007)(6512007)(966005)(4326008)(8676002)(8936002)(1076003)(2616005)(107886003)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rg9qlu5qYYl1O8Ot06EoUr3eSg8Ej3c5MaD3bLiirNE+gLx8A0NNzDnK3gj5?=
 =?us-ascii?Q?8nlyzNECFEh7TohgDrN5e24nj62/jaEQ+toQezLh7DBGkjxg7k77K2Iu0LqG?=
 =?us-ascii?Q?njcPAxbkNOx3Zy621wrOjwT+vcEqxYI7iGMvTad0ZUk3oYKKXkRkBsCD/QSk?=
 =?us-ascii?Q?YARok+GmpRVwLELG6/A+8deAXj+F9pbX9KvlfeBXY7AmwOtC2Yg5aJvLlCt9?=
 =?us-ascii?Q?lHyb+QsKvp4POcmxu5aLkROqroLvLP+crtFkR4kUVaqlZsvgaGX1+9iC88X1?=
 =?us-ascii?Q?wp5n2+DHN0kt198yA/VtwgAsJHna1iTb7sXQOJOOq99uMQJWpv6kK+382sY1?=
 =?us-ascii?Q?2fIMoS267+NHrU/5Wji9+8CNw32DkfST5MB4/ah5ruixbCgRf2aUJsrqtn0j?=
 =?us-ascii?Q?caN/znd8kSBhYS9AyRzwExe7LUsBQz4k2jlVMfyg1WpvVoMFg53UeYrr7NJk?=
 =?us-ascii?Q?/fbkPZjfUH+1LzOCUGmaxw3iB/qiMQhOAe6TkH4q4n7dlUtmXZHQQxtncqpq?=
 =?us-ascii?Q?QeDEy8lI9SvS5i7cICtebP8RIE/4wvmtWmgh14VoHFJPdlD9+SvxINmCXdbi?=
 =?us-ascii?Q?ihQxonlGpOFu6CaVzRn95PPs1YNzSMagC7E8IeqCxPDQr3LE8n+ffX2Jzh5Q?=
 =?us-ascii?Q?vEy6pmFGJl3cWZ80da7AKcbUfKy46anYNJUY13tPfdjbMrLmWf37xfFb+tnE?=
 =?us-ascii?Q?YhME+Revo687f4yzvrYG7clFJj85V+hIQN1BDtB4U13mQLd8IHyH/6+RTFdw?=
 =?us-ascii?Q?LNbH9cfTeblauvaA7lnCAPgMIG0fRYjRcsfmHVdU1VOq+aQRbDStklWNcW5y?=
 =?us-ascii?Q?WPguaupdurrLF9/SUVtV/KWxgXVqcXUB34HNhwNsuHK+30FraRAy9Vslqztj?=
 =?us-ascii?Q?NDs+HoihO7oVfeCY0fSS5Zki3B17wI9paVV88fQc9WF7O1UQjvF7eDrl0ytI?=
 =?us-ascii?Q?Nx+bu7QCYHq/VHwynh8Fqr3USKkzVeDeBWlA0rh1uFM6epqVGiUIG3q9g1HN?=
 =?us-ascii?Q?9MGzQX3Bt3NP5BA8CvZKrwJdUm11FIvGXzDVBqfLtSUwinybvJ2PYkLzJilH?=
 =?us-ascii?Q?Yyo5ya1LhAY4M5Mwjmop0MdFPYS3itNYenkBFt86sSF6aAaormzcNDsvNfTv?=
 =?us-ascii?Q?I1sRlpghY+9Yf9gCoijMQP4sFFLVdQjp5Tuh0TICDZ9wEperRhIJFMYe/BEl?=
 =?us-ascii?Q?4qRMCaq1pG+RrsHXVR9C2vHeHL72qfk6K1C/35P1A3lqdURRkOd8wNmC5wK6?=
 =?us-ascii?Q?2uaQt08nb7fKZx0PDV6yU/xxCnCG9m/AIcPNqZyFo16472TZSddOlwwSdYHf?=
 =?us-ascii?Q?7vUQNNSXte2t/zGXhAoP4p4bBs2hsrcjMOJj1pKuhlHJQQTbgX/6GPyEzFQR?=
 =?us-ascii?Q?/NE+2D1/oxMxolmsl6+ilwyMRHa6O2tydgJOUUj5tqF4ka8l+6LT/xJPl47Y?=
 =?us-ascii?Q?k/pKruq8uTsSFUhk6WKvZI3mUpHQuqsABsufe54iFb2tYpt/re1gwtvWWLkw?=
 =?us-ascii?Q?jhUVfzy3VaexMJZF5pkOiBek77DnGDlAUz2kowBGcaCHJA35/jtHgS2T7wEO?=
 =?us-ascii?Q?eBjOWrXmgU4RU7KTQrcKdjTAhggh3FyDJsSkaOo7IFGj2Q/K60BXVBMLlBOj?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa323e16-ee1f-4a54-323d-08dba47d3c3f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:36:39.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lfb4txZK7B25MJ2Yfg2qpXdgTq2mFpYKDt8e+H6GbtHNoZTn9GGTeeoTi6E+yjvdcb33b2/fGT/axCup00lWZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5420
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c" on:

commit: f87686da5e324dd5fbc44ae39677d5111fdbef0f ("[PATCH v2] workqueue: let WORKER_CPU_INTENSIVE be included in watchdog")
url: https://github.com/intel-lab-lkp/linux/commits/Tio-Zhang/workqueue-let-WORKER_CPU_INTENSIVE-be-included-in-watchdog/20230822-190755
base: https://git.kernel.org/cgit/linux/kernel/git/tj/wq.git for-next
patch link: https://lore.kernel.org/all/20230822110609.GA3702@didi-ThinkCentre-M930t-N000/
patch subject: [PATCH v2] workqueue: let WORKER_CPU_INTENSIVE be included in watchdog

in testcase: boot

compiler: clang-16
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308241637.304413c4-oliver.sang@intel.com


[   34.238546][    C0] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
[   34.240594][    C0] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[   34.242381][    C0] preempt_count: 101, expected: 0
[   34.243435][    C0] 1 lock held by swapper/0/0:
[   34.244371][    C0]  #0: 84fdbf20 ((&wq_watchdog_timer)){+.-.}-{0:0}, at: call_timer_fn+0x52/0x230
[   34.245809][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc1-00045-gf87686da5e32 #1
[   34.247236][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   34.247425][    C0] Call Trace:
[   34.251534][    C0]  <SOFTIRQ>
[   34.251534][    C0]  dump_stack_lvl+0x80/0xd0
[   34.251534][    C0]  dump_stack+0xd/0x14
[   34.251534][    C0]  __might_resched+0x245/0x260
[   34.254546][    C0]  __might_sleep+0x3a/0x60
[   34.254546][    C0]  __mutex_lock_common+0x53/0x1028
[   34.254546][    C0]  ? lock_acquire+0xce/0x260
[   34.254546][    C0]  mutex_lock_nested+0x21/0x30
[   34.254546][    C0]  ? wq_watchdog_timer_fn+0x41/0x4b0
[   34.254546][    C0]  ? pool_mayday_timeout+0x160/0x160
[   34.254546][    C0]  wq_watchdog_timer_fn+0x41/0x4b0
[   34.254546][    C0]  ? pool_mayday_timeout+0x160/0x160
[   34.254546][    C0]  call_timer_fn+0x9c/0x230
[   34.254546][    C0]  run_timer_softirq+0x2d8/0x380
[   34.254546][    C0]  __do_softirq+0x128/0x41f
[   34.254546][    C0]  ? do_softirq_own_stack+0x22/0x30
[   34.254546][    C0]  ? __kprobes_text_end+0xc/0xc
[   34.254546][    C0]  do_softirq_own_stack+0x22/0x30
[   34.254546][    C0]  </SOFTIRQ>
[   34.254546][    C0]  ? sysvec_call_function_single+0x30/0x30
[   34.254546][    C0]  irq_exit_rcu+0x6a/0xa0
[   34.254546][    C0]  sysvec_apic_timer_interrupt+0x1f/0x34
[   34.254546][    C0]  handle_exception+0x133/0x133
[   34.254546][    C0] EIP: intel_idle_hlt+0x10/0x18
[   34.254546][    C0] Code: 64 8b 3d 40 41 ed 83 f0 80 4f 02 20 f7 07 08 00 00 00 75 b1 e9 67 ff ff ff 90 55 89 e5 89 c8 eb 07 0f 00 2d f4 24 d7 82 fb f4 <fa> 5d 31
 c9 c3 90 90 90 55 89 e5 89 c8 fb eb 07 0f 00 2d f4 24 d7
[   34.254546][    C0] EAX: 00000002 EBX: 00000002 ECX: 00000002 EDX: 83b1c114
[   34.254546][    C0] ESI: e96152b4 EDI: 83b1c1d8 EBP: 83709ee4 ESP: 83709ee4
[   34.254546][    C0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00200246
[   34.254546][    C0]  ? sysvec_call_function_single+0x30/0x30
[   34.254546][    C0]  ? intel_idle_hlt+0x10/0x18
[   34.254546][    C0]  cpuidle_enter_state+0xfa/0x48f
[   34.254546][    C0]  ? ktime_get+0x89/0x130
[   34.254546][    C0]  cpuidle_enter+0x2f/0x50
[   34.254546][    C0]  do_idle+0x1ab/0x250
[   34.254546][    C0]  cpu_startup_entry+0x25/0x30
[   34.254546][    C0]  rest_init+0x185/0x190
[   34.254546][    C0]  arch_call_rest_init+0xd/0x10
[   34.254546][    C0]  start_kernel+0x331/0x3a0
[   34.254546][    C0]  i386_start_kernel+0x21e/0x228
[   34.254546][    C0]  startup_32_smp+0x151/0x154
[   34.301725][    C0]
[   34.302134][    C0] =============================
[   34.303085][    C0] [ BUG: Invalid wait context ]
[   34.304063][    C0] 6.5.0-rc1-00045-gf87686da5e32 #1 Tainted: G        W
[   34.305573][    C0] -----------------------------
[   34.305718][    C0] swapper/0/0 is trying to lock:
[   34.305718][    C0] 837409e4 (wq_pool_mutex){+.+.}-{3:3}, at: wq_watchdog_timer_fn+0x41/0x4b0
[   34.305718][    C0] other info that might help us debug this:
[   34.305718][    C0] context-{2:2}
[   34.305718][    C0] 1 lock held by swapper/0/0:
[   34.305718][    C0]  #0: 84fdbf20 ((&wq_watchdog_timer)){+.-.}-{0:0}, at: call_timer_fn+0x52/0x230
[   34.305718][    C0] stack backtrace:
[   34.305718][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.5.0-rc1-00045-gf87686da5e32 #1
[   34.305718][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   34.305718][    C0] Call Trace:
[   34.305718][    C0]  <SOFTIRQ>
[   34.305718][    C0]  dump_stack_lvl+0x80/0xd0
[   34.305718][    C0]  dump_stack+0xd/0x14
[   34.305718][    C0]  __lock_acquire+0xd5e/0x2c80
[   34.305718][    C0]  ? irqtime_account_irq+0x66/0x90
[   34.305718][    C0]  ? irqentry_exit+0x83/0x8c
[   34.305718][    C0]  ? sysvec_call_function_single+0x30/0x30
[   34.305718][    C0]  ? sysvec_apic_timer_interrupt+0x29/0x34
[   34.305718][    C0]  ? handle_exception+0x133/0x133
[   34.305718][    C0]  lock_acquire+0xce/0x260
[   34.305718][    C0]  ? wq_watchdog_timer_fn+0x41/0x4b0
[   34.305718][    C0]  ? dump_stack_lvl+0xaf/0xd0
[   34.305718][    C0]  ? dump_stack+0xd/0x14
[   34.305718][    C0]  ? __might_resched+0x251/0x260
[   34.305718][    C0]  __mutex_lock_common+0xa8/0x1028
[   34.305718][    C0]  ? wq_watchdog_timer_fn+0x41/0x4b0
[   34.305718][    C0]  ? lock_acquire+0xce/0x260
[   34.305718][    C0]  mutex_lock_nested+0x21/0x30
[   34.305718][    C0]  ? wq_watchdog_timer_fn+0x41/0x4b0
[   34.305718][    C0]  ? pool_mayday_timeout+0x160/0x160
[   34.305718][    C0]  wq_watchdog_timer_fn+0x41/0x4b0
[   34.305718][    C0]  ? pool_mayday_timeout+0x160/0x160
[   34.305718][    C0]  call_timer_fn+0x9c/0x230
[   34.305718][    C0]  run_timer_softirq+0x2d8/0x380
[   34.305718][    C0]  __do_softirq+0x128/0x41f
[   34.305718][    C0]  ? do_softirq_own_stack+0x22/0x30
[   34.305718][    C0]  ? __kprobes_text_end+0xc/0xc
[   34.305718][    C0]  do_softirq_own_stack+0x22/0x30
[   34.305718][    C0]  </SOFTIRQ>
[   34.305718][    C0]  ? sysvec_call_function_single+0x30/0x30
[   34.305718][    C0]  irq_exit_rcu+0x6a/0xa0
[   34.305718][    C0]  sysvec_apic_timer_interrupt+0x1f/0x34
[   34.305718][    C0]  handle_exception+0x133/0x133
[   34.305718][    C0] EIP: intel_idle_hlt+0x10/0x18
[   34.305718][    C0] Code: 64 8b 3d 40 41 ed 83 f0 80 4f 02 20 f7 07 08 00 00 00 75 b1 e9 67 ff ff ff 90 55 89 e5 89 c8 eb 07 0f 00 2d f4 24 d7 82 fb f4 <fa> 5d 31
 c9 c3 90 90 90 55 89 e5 89 c8 fb eb 07 0f 00 2d f4 24 d7
[   34.305718][    C0] EAX: 00000002 EBX: 00000002 ECX: 00000002 EDX: 83b1c114
[   34.305718][    C0] ESI: e96152b4 EDI: 83b1c1d8 EBP: 83709ee4 ESP: 83709ee4
[   34.305718][    C0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00200246
[   34.305718][    C0]  ? sysvec_call_function_single+0x30/0x30
[   34.305718][    C0]  ? intel_idle_hlt+0x10/0x18
[   34.305718][    C0]  cpuidle_enter_state+0xfa/0x48f
[   34.305718][    C0]  ? ktime_get+0x89/0x130
[   34.305718][    C0]  cpuidle_enter+0x2f/0x50
[   34.305718][    C0]  do_idle+0x1ab/0x250
[   34.305718][    C0]  cpu_startup_entry+0x25/0x30
[   34.305718][    C0]  rest_init+0x185/0x190
[   34.305718][    C0]  arch_call_rest_init+0xd/0x10
[   34.305718][    C0]  start_kernel+0x331/0x3a0
[   34.305718][    C0]  i386_start_kernel+0x21e/0x228
[   34.305718][    C0]  startup_32_smp+0x151/0x154



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230824/202308241637.304413c4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

