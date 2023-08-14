Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88F577BA54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjHNNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHNNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:41:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69090E54;
        Mon, 14 Aug 2023 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692020473; x=1723556473;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=e1V3ET+9VdMGoIfZLn9G9UmVq//3gbbAMl/pR+Bf+mU=;
  b=EYfLCuHwhcXiFNDz+74NkjO7eG14QddVhwZYoP5lcYHLyZ4hTXdc4eXe
   H0AfPlDDqhuD9CU1E3aQs3v1mzVSo2iPm0M4IkVVv3B9R8l2aFzIZ/YKs
   7Cv5/u10bzDo/B5IsL+jo86s9ex7pL47bpQuql7uIrS0O0CJ2p+3BcM6I
   10KoX4f0d1KoKiB/CxRaZ0nFs8wSUnBccu/RKVA5o1bDQ00MfmRBOyuhD
   CLAW0R36Bx6pqk3rJAFbqp+qxS7Pwl56Nx3jNkKvi/rD1jwFqEY+ai5oT
   gaN9ygunjBCGiTrvNGCZicXgZWhr2rIaA7JJQcg4OStosjSLsHVEGENNr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="370938914"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="370938914"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 06:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="1064058001"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="1064058001"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2023 06:40:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 06:40:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 06:40:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 06:40:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 06:40:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO8h/smi28esA0xvX/8579HPyakMwaQMqQP0Acn8IYEqV5Qb04aNc6d6j14VAeKCh8OP7oUqi5DaHYluAwx5eernvVaAdvRJTWJ4R0m6Pcec2u6GbDgQXD4G8U+wWxMLdtFdKnHSPi0JaT2CGKkgPTtbBgGALqKM41+UZug2SDecOKBZO+TXA4ZHiRKldKp9Zwg+DaCPlTrszkd2553D0ybyzWfB+Bp/3A4Mm0BI1uXLOdFaqD3l8UKnahRivBxS1ZCRfmIjtdpVAufiBE1rOsc4kXoe/VLU3ELqCDA59AQSt03kE4gh8SfkH6yhdHJoktoVSGRRxwYcWCFHVU35Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CazL8RHsqV85f8MJ0K5S0NsbpCs9TZbwsQHUyC7oxlI=;
 b=j454TBQ01WnpTzUDrJY4q3FjRPqt1n0Fq5Gq74x9g3ad2sGzZqL5uiRs7lwq5MJbGwntg1BqQ+giFVKY9ChPUUoLYzYbEfWyBiKnHNLUV+0p41U/ClWhGPVJoJyvJNfMv3F8z2+p/u7Z3Dskvi2Wd/r9Oz2WTbcgoRSQ3CIfexUoaFeY0dsp9P6V7sIXT4e5nvlfIgiKzRVCeTrCxoYbuoOj8p1jnDvtg9MY+e2E/Ne2ysB8Vy2eRoGzUA9lyWYj2shxu512oe6P4Qh95ia49oMqgBT4iZolqc1UtN4442r/Fk8JRQJXsfRIiXmvOyzlrK0i3FuyyijDzlDx4iwz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB6873.namprd11.prod.outlook.com (2603:10b6:806:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Mon, 14 Aug
 2023 13:40:53 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 13:40:53 +0000
Date:   Mon, 14 Aug 2023 21:40:42 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Helge Deller <deller@gmx.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-parisc@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
Message-ID: <202308141646.d3160c77-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNep5EcYskP9HtGD@p100>
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 1982a8a5-7983-4dd1-9fbc-08db9ccc1467
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAoSlw3mwKCBR2ZnMzTUgw566eXZk+w2ZnYO/PQkQt9Ds35t+fPY4HhFfDX/9S1GiGPjfOERqQNM0gpJzkNHza4HBLTEUQkM/mnN0c5AOjP0kYwQPNl1T0C4YpzJn0u/w9IjqOXCyaczkuODx9ff6nVuIkEHQUcoY+MfkPADML4QlXl9yS8trXpOqJyIHGlVvlsQ5tFXI9/YkPLBsHk3k0e3ARkX06oWF+v2Asx3UCpdlKlbGw4/o/NwJBecAxl5aaqQWniDot5Tt6XpaZJbPg5/BOcRJWuOXfBcWXi/dp7MeNGNJqJz8jAUvd6pSX4aZAyrd6GiyDN/ze/p5DgqySPpUPjpx94dELkAYipG62TlYMzN7WO7H9HmZO/SbhpFMHeLthhz/CCjPRFvwh8XFzzrMVG5ajAZ3kxJZs5pcsNdP6H+c3ZhSheb54wqbEugqZf7nd7iVToUMZaH+/ljzG2zkRWvDL2VznehUQSiZC6Qvqp4nF+0KGMYI/zwkepxEgU8vzy20TpAfw17EJbOIpipm4rLFLcsFRRC8YxLQGYXdLKjhYAnmTpIvrE2wn/bHsXMP7DeMNjFfhY1ZtLKqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(346002)(39860400002)(186006)(451199021)(1800799006)(36756003)(107886003)(6916009)(4326008)(2616005)(54906003)(2906002)(38100700002)(316002)(26005)(6506007)(1076003)(66946007)(66476007)(66556008)(5660300002)(6486002)(8676002)(8936002)(6666004)(7416002)(41300700001)(86362001)(478600001)(82960400001)(83380400001)(45080400002)(966005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yGQNFUqHPUn5HmU5kRfL/9rNU5mdbkveOTN3HjMsVaQF882q7Vm2rBwel29e?=
 =?us-ascii?Q?fd/GHA4YbrdjVl57S229rew8up+27MJzwRl7pJIdAX0AThkfrBfUjmLnhNyU?=
 =?us-ascii?Q?hZzI4OkjyK7LvQNwkCswMJ+9qz62awqg7M+rg1Ja4nwBmBznyQv8dnQOAh+J?=
 =?us-ascii?Q?xGO0q5eb2jr2Z8I6xnQceKv1EvcSiiLbJAIwVpdqC1BhlOTyxxrYY0fCvefd?=
 =?us-ascii?Q?2oo+vkfYydzHDC8d+4wSVfzqrhwwnGBTY3OV9tK3GPYH3cuYFIH97IPCUdFV?=
 =?us-ascii?Q?ehuKOuEFCF5Wf4VOT9OBsgaXfKGqMnYVSFk1zVzLU7JqG5kT85j5v3AkAx7L?=
 =?us-ascii?Q?5szXH3CzGhybI+VK9pDpqWWRLellTg4FyDGmpTmwN/Mlnx6tAETZ2hJNHPv1?=
 =?us-ascii?Q?R3RBxTfWEwNPONP+ZUHHYiPnFxF+kHIBY2kFufvHdb/w28stX7UIsuBBTV9X?=
 =?us-ascii?Q?0BNtWyu2wRSFSsghNMEbSp/bNnXesfDB8z3bCaFcnvuycQjXP9kqr6ma5Oc6?=
 =?us-ascii?Q?96aK+4IxNQK7ohJwLpKAaK638TcN3Y8f55zFbPKCcJWjl2zANNRXt4sabNDA?=
 =?us-ascii?Q?KYcp6l8Nk0exUjpjOMlb3RzEtLQ/buqDMRVRCJoJlgzQgp0mKTTSSp1eFkAA?=
 =?us-ascii?Q?87OkiT3ElC/doCsHKBHzzmH8UuJFTYM6C2TIwJFBUxyNM3wUDxeeELUxUi90?=
 =?us-ascii?Q?KjyUg1wlKuU4jShQJAqrzEGVR6MzgqMu4wk+bWLwqJtVCMD91R5k+gE3//a4?=
 =?us-ascii?Q?Zty2GaNeSwteoBnC5VCSiN1xyIQuS3E3QA1YMYzqoK6EtAO8LxPytSs1d5/2?=
 =?us-ascii?Q?teA2MAfD4RZLIVlwOxqki16/BnzaCTwTEJ3MPbbsW7RLLpTPpX5znHpSXJpJ?=
 =?us-ascii?Q?zcZpgAOXiEoHu570A7T4ujL/4HKdG24lIxW/iqThaaZQtEGb/rA2N0pwG8Ex?=
 =?us-ascii?Q?0k7+zr6RU8fUFzGh5nkCNcLvYE57AdN5VJPDDxGB9jE2JkMd5hp6y1dVx8vJ?=
 =?us-ascii?Q?0CcYacT9B4DuW/E3Xzk57gTFTM378s4keAODWN7Ijiqrgc9JEICckrNk2vrH?=
 =?us-ascii?Q?jy8vmEdIWO7grgj2XuTN0vIzfXzK32cfKBnhPj+Q0JXEVFhHlL+e1PGfhdMg?=
 =?us-ascii?Q?uSB2b4hnMTbHNH5C6rmXaOksBR/iYC90BjROEAuKagdbyXhX5Bt3xbxrT8Im?=
 =?us-ascii?Q?FdCaN1i0IqdV4d8VhTXIG7pH3hcslblW/JqqE6B8xpeKpGLB0SOnARSV9Xj5?=
 =?us-ascii?Q?nprn9mnBizz1IqG5gcmrCMUKyX7JeM9Q2loy1vFjWUlLWEmYyc3tOKhPuezO?=
 =?us-ascii?Q?jby9pMxPPr5lor/uGaVQmoN0n5seAHwPjP4WKB7Hj3FfT8llDRIyamssbUWO?=
 =?us-ascii?Q?PHvrwQ2C51LCxmes/RF1yZw0ivlh3TOOX7bjIYyxcC8MHpZMMnl4gfD2DeFA?=
 =?us-ascii?Q?cybxKv0JTatAM84Rkh6W+ieDdycHJ35J4J5KrLy8CBP9gva9evH22uQRtk2o?=
 =?us-ascii?Q?ceGmu4uLgf25Jp3vZiQD1r9AFGmR4aWbKeJTaW+/Cn76O2DfPfwMOEFT3M9P?=
 =?us-ascii?Q?LVs/MVBbFSMFdAE/XkKnQIYxlzjHqtf8TsZ2zyyOIfnTC7MEXEC5CZo5VaXL?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1982a8a5-7983-4dd1-9fbc-08db9ccc1467
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 13:40:53.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0dam4kMy/sHD9tBQHsgNb2pWZ/y65FeSs3CJuosEL8FLrv5MQq5y1Dn8WhGbExK0TjN8nRsiLXJRv2LpQM3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6873
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

kernel test robot noticed "BUG:key#has_not_been_registered" on:

commit: 94d4413e506da48ea18f1cc982202874d35c76b1 ("[PATCH] lockdep: Fix static memory detection even more")
url: https://github.com/intel-lab-lkp/linux/commits/Helge-Deller/lockdep-Fix-static-memory-detection-even-more/20230812-235022
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/ZNep5EcYskP9HtGD@p100/
patch subject: [PATCH] lockdep: Fix static memory detection even more

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308141646.d3160c77-oliver.sang@intel.com



[    0.575811][    T1] BUG: key b35c282c has not been registered!
[    0.576580][    T1] ------------[ cut here ]------------
[    0.577216][    T1] DEBUG_LOCKS_WARN_ON(1)
[    0.577236][    T1] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:4888 lockdep_init_map_type+0x155/0x250
[    0.578389][    T1] Modules linked in:
[    0.578856][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc4-00587-g94d4413e506d #2
[    0.579899][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.581143][    T1] EIP: lockdep_init_map_type+0x155/0x250
[    0.581677][    T1] Code: 70 a2 51 b4 85 db 75 ab e8 78 79 80 00 85 c0 74 a2 8b 0d 98 0a d4 b3 85 c9 75 98 68 59 2a 3b b3 68 8a ce 36 b3 e8 2b 7a f8 ff <0f> 0b 58
 5a eb 83 8d 74 26 00 90 e8 4b 79 80 00 85 c0 0f 84 71 ff
[    0.584028][    T1] EAX: 00000016 EBX: 00000000 ECX: 00000000 EDX: 00000000
[    0.584881][    T1] ESI: b3384ac4 EDI: b35c282c EBP: b67fbe58 ESP: b67fbe44
[    0.585009][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[    0.585927][    T1] CR0: 80050033 CR2: ff999000 CR3: 03f25000 CR4: 000406d0
[    0.586773][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.587629][    T1] DR6: fffe0ff0 DR7: 00000400
[    0.588198][    T1] Call Trace:
[    0.588344][    T1]  ? show_regs+0x74/0x80
[    0.588860][    T1]  ? lockdep_init_map_type+0x155/0x250
[    0.589521][    T1]  ? __warn+0x71/0x160
[    0.590011][    T1]  ? lockdep_init_map_type+0x155/0x250
[    0.590684][    T1]  ? report_bug+0x158/0x180
[    0.591242][    T1]  ? exc_overflow+0x40/0x40
[    0.591677][    T1]  ? handle_bug+0x2a/0x50
[    0.592202][    T1]  ? exc_invalid_op+0x25/0x70
[    0.592749][    T1]  ? handle_exception+0x14d/0x14d
[    0.593337][    T1]  ? exc_overflow+0x40/0x40
[    0.593881][    T1]  ? lockdep_init_map_type+0x155/0x250
[    0.594502][    T1]  ? exc_overflow+0x40/0x40
[    0.595011][    T1]  ? lockdep_init_map_type+0x155/0x250
[    0.595653][    T1]  __kernfs_create_file+0x6a/0xe0
[    0.596244][    T1]  sysfs_add_bin_file_mode_ns+0x4e/0xc0
[    0.596891][    T1]  sysfs_create_bin_file+0x5c/0x90
[    0.597496][    T1]  ? nsproxy_cache_init+0x30/0x30
[    0.598090][    T1]  ksysfs_init+0x5c/0x90
[    0.598350][    T1]  ? nsproxy_cache_init+0x30/0x30
[    0.598935][    T1]  do_one_initcall+0x5b/0x2f0
[    0.599480][    T1]  ? parse_args+0x1f3/0x350
[    0.600028][    T1]  do_initcalls+0xe4/0x1e0
[    0.600558][    T1]  kernel_init_freeable+0x171/0x2a0
[    0.601187][    T1]  ? rest_init+0x1b0/0x1b0
[    0.601677][    T1]  kernel_init+0x17/0x1b0
[    0.602193][    T1]  ret_from_fork+0x35/0x50
[    0.602714][    T1]  ? rest_init+0x1b0/0x1b0
[    0.603235][    T1]  ret_from_fork_asm+0x12/0x20
[    0.603812][    T1]  entry_INT80_32+0x10d/0x10d
[    0.604359][    T1] irq event stamp: 7609
[    0.604842][    T1] hardirqs last  enabled at (7609): [<b1114e0e>] __up_console_sem+0x5e/0x80
[    0.605011][    T1] hardirqs last disabled at (7608): [<b1114df5>] __up_console_sem+0x45/0x80
[    0.606012][    T1] softirqs last  enabled at (7260): [<b27a3d23>] __do_softirq+0x2a3/0x3a8
[    0.607008][    T1] softirqs last disabled at (7229): [<b102f2e6>] do_softirq_own_stack+0x26/0x30
[    0.608086][    T1] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230814/202308141646.d3160c77-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

