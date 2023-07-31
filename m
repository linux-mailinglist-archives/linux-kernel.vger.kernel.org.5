Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B87695B4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjGaMKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjGaMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:10:47 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5E172A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690805439; x=1722341439;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ToN/RvIHLH/6zNQA8Pa+34jXXN/Qe1r0x+yHt5ztkrE=;
  b=S5Ary4Jen1/wJcyIc1kw5MAR2fEtgbO53laREcddqYWsrrAbP+Z62VEG
   MVlfzNiStm5LEr0uvY3f7jtAUrqfoA8ECBSNZejXGJj9yDtP8LjSE1zaT
   W43fOzBivsjRYVjB59RNEGZlvKwV4VmEHZeYPg68hJqCw5bMtYHlImBgk
   C3demRL8dFvswriUu7i3Wx9ZbCbaqX2R3k5jDKmJUpTeV4TPYkGh1zImR
   UW8OWNIyuINhufteFIePZfxmtqAgvwakZxY1/KnG/aocTMxHqeJj3WWCn
   z4AoOKArsL3aZ8DQt895ClEDMVXLa53RkvYUd/pLMFBi9ScX0Lofu2H6L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="353915704"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="353915704"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 05:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="974839884"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="974839884"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2023 05:10:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 05:10:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 05:10:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 05:10:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 05:10:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOV45ScBHCc2YrSU26+e8Mij9Ih0CrQ6IyHdcef9iPAlqT9+P3Vn/qKhzmbSvVV6OqrqOLu/9gSlFSTsPqzllvmsOGnjp7yrvOMCdG75b/TLh/GB8LHFpAo5a1ADbesqi2tnOvSRnNsJ/VIo1QzcXcIyatADlOk+KYCQ1Asl5UjQdBCwVfi1PTGB+eiFD70Xgtb3vGtpi6WRkFhjmwZWezGOJUQf38veFMHpLIXGwXeePC0635v8irSp4TOFsS71QcAKtHkLdDBt4qJOe9DHTLFnkCWm/IXVTHkVQ8W44XIkIQsSOQKeeBbdPNEyKpwLDJvtp/b3U9HOh1yj0uf9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTEiWMshkBflSr2WH5BIQYu50UJz6UTrxJe7zoKUcrs=;
 b=BIGwkFEi0wISC21op/WXeeqb6+bHBlO9seoi9pC9wO9QQNKCPPfMNYCdLzw/m5xX/F0qBa5IGUoHDxx65ED6iiCQA1nEMpraPffSeJrUwK0HsutO3MhhHRZYg74aKgefZ2rKjiG2+dZggSYdx1Hd0WrfRGqgBEjoSUusV4YpnfvvDEWdxxUmrNwtfn9aZVAT2zXzeo7MX9tz03o1tABZ0Kc0L6JsQSl/8k8hTBT7XuQ4i9soPsTkcV7arAkCzextmCmTl64loYHy6576cAgIP0xg6EhBe3fnerVg15yUSaooko2xJXM57n8acl7UIWZcq9T/AWlJDWfm7aU48HHg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 12:10:35 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 12:10:35 +0000
Date:   Mon, 31 Jul 2023 20:02:46 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [linus:master] [x86/fpu]  b81fac906a:
 stress-ng.af-alg.ops_per_sec -34.6% regression
Message-ID: <ZMei5uMRwOJo2r6Z@feng-clx>
References: <202307192135.203ac24e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202307192135.203ac24e-oliver.sang@intel.com>
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH3PR11MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f76da03-0de3-4ab2-799a-08db91bf250f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1RMqbZ54fCw2lsH4jacQRsISMcOMZSXxLmoNiIxylCbH57hSO1/RcMxINDgOoKZ7PVmKidlOTt6kEhXTe54WuxeoJG3gWbY4I7qvVMjcbmIZTs0il4CgOmqMk1h0xGDxcUCwI5q9ZmCNdkgx0g4zFRhnzg774hBu0BbxlhOE0ikWJxW6aVxvjM0XyFTEmDdAF4YZA7C70voBA32+fa9Qu3L5bpt8RS8Iw+ZXhDQaY2MROqzuFRL2pjC0Y8zvZ4bq98y+7Xh8BMeGlp25deISXpI41JqHdfvAtZqjLpfO1uQ1PovLMjQNCdZgrD414Pr3UnoNqGCSpljAQBR6CHxRjTKZNXaZikrB/ffBrtJtib28fQQUuzCw25+SDyNFQuDerXfS04OMi77d81kTGmkQgui9LvDQ37r8er2hBJq8wmTtkQjWKAXbsc07EcVz4CQ+896jXuo4dlhXZGQGWlX2JNKkAf0UowUfvYeHyjJyjqTvHqGIQ3p5uTPKQJ59av5/VguwHaMxezBJYBcd8PvTBPHgyOMAaunaPPexL7QvVPVGA3aWdSsE/esGsdPpXnhezBh4f36MSU5zRpsehXVDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(33716001)(38100700002)(82960400001)(86362001)(6512007)(966005)(9686003)(6666004)(478600001)(6486002)(107886003)(186003)(53546011)(26005)(8936002)(6506007)(8676002)(44832011)(5660300002)(66556008)(66476007)(66946007)(110136005)(2906002)(41300700001)(4326008)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HYK/r5E2sRL2z5wVnxQ/yAhXxv5JqaaVR4MxKvit1joMvSFFRHxK/18Vx5vJ?=
 =?us-ascii?Q?JsxX7VExNV02IO3F614K2KYOj3OOJjM27dotxSPFuvXZ48jpJKzzSiUu0JzG?=
 =?us-ascii?Q?vI+wGQbbv6n5EuSVha1DPZ0kKeBVw5pGQ4jC9k7LJ5dgufUThK0Ldy9rSTGo?=
 =?us-ascii?Q?OkP0Vkik9B9062llSMUDoubeh+UX19pg4dcNAZ0Wp/p+c1bq5DU5gBzy1SQg?=
 =?us-ascii?Q?/unK4zv9Mqb2Bq4EB1mqfciKuHCut4sfQYLLtYJTAWRf4CGLseyxNdb5z8Dl?=
 =?us-ascii?Q?9hc4mpD0y8le93yPO8mjbYiZ2Bygd0640llRlMzhka/3Vtcs3JbLPDdbqUVO?=
 =?us-ascii?Q?6KbM/ZypS20rPA/cY8Eo3uTJ+Cz5VdCeDWpxn6EDhO6lybAOfv7gxmk4nVaO?=
 =?us-ascii?Q?iCdhUEV5Ai2Zy68ZheIGcULPyxyt4P2RH4e7XOcLXZKDROyBrMKdWsTaiauV?=
 =?us-ascii?Q?3CjNF1xClSA8Cbw98WTueZcBDz9jyOuMiXaCnNm2TIYUhe6nIhl2pMmBo5Tk?=
 =?us-ascii?Q?+VZHnD5aDbak9mMyj93o/NMZNxjd8oJ0wA7dxM7MtaPv5QiWStWqQlWh57Ly?=
 =?us-ascii?Q?sBoucFUlrBkqFCv72bPwzlWUqgRa6faKTQ9Lhn3nPyfrgeqpay7iZizoR/JP?=
 =?us-ascii?Q?fkrlphQtwZuQniQSdIRwLdgJSyYLsUCTuGTrunQlcR+xMKCf2Dx5E//4bOr2?=
 =?us-ascii?Q?0J0oxVqjZX/MgVnXRtd97EYOYaZjg61Ezjn9IUHI/+4wbenrwyApDseEpCdl?=
 =?us-ascii?Q?GJmGHOAdMN6G/dOk19zqHbqKShTM0MtIig4MX769tvNqqe7YCJYFFbIiFNDw?=
 =?us-ascii?Q?YfGFut+ps7/GqdSKrUaRy/sU38m0heFhbjMKqA8iDOPi2Omb1mINuODoq4Ov?=
 =?us-ascii?Q?SdbVmj6N9EB4YoP/1Cqdlx262hwzVdgurLS0UJKaRj1FL403bEEXEy06EOZS?=
 =?us-ascii?Q?SNKdPhFLYAmxU88XGsnjNzR7xoerLLYsQgfdRMnrJePTEdpoDy0dX4/pE4wc?=
 =?us-ascii?Q?J6kfp23oOOkYDtL7O9568+4OzDIGscUhAEhxUvYwU3gYh85tnbD7XFGTRmGE?=
 =?us-ascii?Q?vjK/6PNSrzMUhlbHdSxQ3jXuKoCSf2KRwS0NaX+y6yXP2OsJiYGJXRDI/XQa?=
 =?us-ascii?Q?RiWlJCFyhx/CsntWfG5F5luSgPclU6qisqerwvyaxC/6IvpKUeXwlUeFcH1l?=
 =?us-ascii?Q?A/I8BKxP5f8HTJHnqHjjF8jT7SJE8sYfuMc23tBd9GW+cgb80/3L9nN+vDAD?=
 =?us-ascii?Q?a6zlIPWD3a7zoxPhsa3HGfw6+k1WXavNhpzRSpROyoKoE/vU6nqDnjEFk7Pt?=
 =?us-ascii?Q?rrTr2UWegKhPnzn/2utmVgJD5kgNfc1FV8RvipL6AwVAnef/HQuLfYeztTtE?=
 =?us-ascii?Q?CvgjR5GGTZh/M0fLpRx4ptRN1ncJZtWbRpGaQEZRJp+VY9wNzb3vSyOKv33/?=
 =?us-ascii?Q?QXZOgfztxGzxhfAAOLfGrDORjr3EwYqoNyZePrCTjF4Ax2NUf6xWbK98BdAq?=
 =?us-ascii?Q?CKbJmu+Ql+T+WpTRUXwZxw68u3gpPhsgXJoJ+N4Jb85ME/GIDOeQQG+sv0Yb?=
 =?us-ascii?Q?rWRrGNQv4Kp6JzgQTBYLKrFEMujFKNxAs8l31yI+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f76da03-0de3-4ab2-799a-08db91bf250f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:10:35.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc0gI8soHj8T1Qn/VYbaHL0s1OFyEY6kBON8gsTxtq5TMifwCCKuKD7xdIk5/cc1rxo56AY5CP7nQ2yhIpzB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:07:52PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -34.6% regression of stress-ng.af-alg.ops_per_sec on:
> 
> 
> commit: b81fac906a8f9e682e513ddd95697ec7a20878d4 ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> still regression on:
> fix commit: fe3e0a13e597c1c8617814bf9b42ab732db5c26e
> linus/master: ccff6d117d8dc8d8d86e8695a75e5f8b01e573bf
> 
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: ext4
> 	class: os
> 	test: af-alg
> 	cpufreq_governor: performance
> 
> 
> besides, we noticed there are below information in dmesg (attached kmsg.xz),
> which we didn't see in dmesg for parent:
> 
> kern  :info  : [   65.660392] AVX or AES-NI instructions are not detected.
> user  :notice: [   65.661743] stress-ng: info:  [4738] af-alg: 9 cryptographic algorithms are internal and may be unused
> 
> kern  :info  : [   65.720205] AVX or AES-NI instructions are not detected.
> kern  :info  : [   65.820334] AVX2 instructions are not detected.
> kern  :info  : [   66.130644] AVX or AES-NI instructions are not detected.
> kern  :info  : [   66.167749] AVX or AES-NI instructions are not detected.
> kern  :info  : [   66.213178] AVX2 instructions are not detected.
> kern  :info  : [   66.318235] AVX or AES-NI instructions are not detected.
> kern  :info  : [   66.360766] AVX or AES-NI instructions are not detected.
> kern  :info  : [   66.437318] AVX2 instructions are not detected.
> kern  :info  : [   66.683666] AVX or AES-NI instructions are not detected.
> user  :notice: [   66.713976] BMC ARP Control         : ARP Responses Enabled, Gratuitous ARP Disabled
> 
> kern  :info  : [   66.738790] AVX or AES-NI instructions are not detected.
> kern  :info  : [   66.822332] AVX2 instructions are not detected.
> kern  :info  : [   67.083360] AVX or AES-NI instructions are not detected.
> kern  :info  : [   67.122804] AVX or AES-NI instructions are not detected.

I think the regression is related with the commit, that commit
b81fac906a8f changes the FPU init order, and cause the 'X86_FEATURE_OSXSAVE'
missed the cpu capability setup, thus all later check of
boot_cpu_has(X86_FEATURE_OSXSAVE) will return false.

   arch_cpu_finalize_init
       identify_boot_cpu
	   identify_cpu
	       generic_identify
                   get_cpu_cap --> setup cpu capability
       ...
       fpu__init_cpu
           fpu__init_cpu_xstate
               cr4_set_bits(X86_CR4_OSXSAVE);

Many security moduels in arch/x86 have dependency on X86_FEATURE_OSXSAVE,
and will fail to load later. While this 'af-alg' case involves secuirty
operation and tries to load those modules but fail, which cause the
regression.

Setting the 'OSXSVAE' feature bit after OSXSAVE enabling can restore
the regression, like the below RFC patch. pls help to review, thanks!

- Feng

---

From 62d05a24cae9198b0ed45a8857edbe4c9c4184f9 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Mon, 31 Jul 2023 16:45:34 +0800
Subject: [PATCH RFC] x86/fpu: set X86_FEATURE_OSXSAVE feature after enabling
 OSXSAVE in CR4

Commit b81fac906a8f ("x86/fpu: Move FPU initialization into
arch_cpu_finalize_init()" optimized the FPU init order, and moves the
CR4_OSXSAVE enabling into a later flace.

   arch_cpu_finalize_init
       identify_boot_cpu
	   identify_cpu
	       generic_identify
                   get_cpu_cap --> setup cpu capability
       ...
       fpu__init_cpu
           fpu__init_cpu_xstate
               cr4_set_bits(X86_CR4_OSXSAVE);

This makes 'X86_FEATURE_OSXSAVE' missed in cpu capability setup. Many
security module like 'camellia_aesni_avx_x86_64' depends on this feature
and will fail to load after the commit. 0Day caught a 34% regression
in stress-ng's 'af-alg' test case [1].

So set X86_FEATURE_OSXSAVE feature after OSXSAVE enabling to fix it.

[1]. https://lore.kernel.org/lkml/202307192135.203ac24e-oliver.sang@intel.com/

Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..8ebea0d522d2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -173,6 +173,9 @@ void fpu__init_cpu_xstate(void)
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 
+	if (!boot_cpu_has(X86_FEATURE_OSXSAVE))
+		setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	/*
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
-- 
2.27.0

