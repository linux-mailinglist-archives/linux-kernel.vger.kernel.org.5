Return-Path: <linux-kernel+bounces-23151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7054582A852
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861F11C234C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20589D287;
	Thu, 11 Jan 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCobjy21"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA4DDA8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704958170; x=1736494170;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GeyeZ+tG3uFpn4T6J9lCXHhuo9sgL9uL7TxdfX1Hm6g=;
  b=CCobjy21XCcUB0dM7NsHV5SPzpV8VAJhEzooksjRRtsl8KnYwq1cThHz
   leS69CBFeVJ2GSqPFJPDNqtIOHw3K+xfPxH6EbJhDYAgJOmbtZGB+SvkR
   JWlxI5GrPNzPRpHZdv41jsnZW2NP94SJExKxopjXwC+OiGPe8qARV1ZVP
   Ma+VK/Efb9ySb8JwZJon13UKl3Uu1hl6yfKJadoQ1H/yAqxuAP4JrGp+r
   YLv4vaOcvjFErc5j+4khlXhNR3vsZthfME2ctp8h0Mdt66x7Ep5hsyVeq
   ASl7kvHNPRcgsgiejNqZ1ngJSjle0x1oSqZ8ueqHX8iOfOeC7iMgFPbWL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389203260"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389203260"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="816629171"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="816629171"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 23:29:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 23:29:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 23:29:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 23:29:26 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 23:29:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex1HprTcTotzW/jxMxQToGedH8UrGx7e4QCfFfr0J3LWIa7RqIib7QnW8caQ3W8fIL0yrRBsAyA97jgRqG19MayLjV71NfuPP5HF6mSW+n4zFxvjSGZmoPQWyYCht/nrOqGDEV8UMnxonqyZkr1AgNdldm/uJzqdiR8aXjs/XNAkbq+jaUum9lnGE7jA+7XGTx2T+3AW3C2USuKwZd/W1vAs2Um1cv1kV7+t7GR/VjNB/2JHu3icwRE3F+P/BmaLLVo618R14XZCZ0ESuBAvlv1MM4SjsjpCepmufKoM+yUb7+9iysE9IS4v4rQMW4BiagSImeooTqvA7wzA6I6p6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIWpoz2MDQW7p6hH1sp2omvn66kfNuF8+ilLZ1E4zOM=;
 b=CgDqV84XdgxTk0In2ibq+ZJiB+/HjQ+QDTrt4ylufHA5Blhx9pvYxrhRkKv9gZnEIHJ6uOSbxnePRl+R7OkdIevn2SSUeU3apYHUf3TZSKyEF06GSFJOf8LEtoU3s3+oSw+lENe0LiNo+DJplRnipPMuKxaAy7qLHGDOjzDWbKSlNKFN3XFuSHNvUBLjMs4ZLVkqzVgMJKY6ECe7P4CkTcFpj1cKsSYCjcgWibo9N0Xds0BuYJE7mgIwqAT03z/4VDSdnAx0C5yU/uKLUe6pgW7jowF1TJ4m4vZoowXebQiyWQ6Df/JGA8tZJYI4bSV2G7KOfaXqI9bFR5lcgFJahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 07:29:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 07:29:23 +0000
Date: Thu, 11 Jan 2024 15:29:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Andrey Konovalov <andreyknvl@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Tetsuo Handa
	<penguin-kernel@i-love.sakura.ne.jp>, Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Evgenii Stepanov <eugenis@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	<kasan-dev@googlegroups.com>, <oliver.sang@intel.com>
Subject: [linus:master] [kasan]  a414d4286f:
 INFO:trying_to_register_non-static_key
Message-ID: <202401111558.1374ae6f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e75a2fa-f19e-4098-2d72-08dc127708a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlelKMJsrkqQu6jYE1GtgSivdxVikFN4MhPN+8GSEb+vzYIAKJXlYKECKza371zX5yFaERPsiKopqgKOY0NG7+jSh0WDPHmZj/nEhB34dJK6Ou116ssKkznCQILwS0M/A0TL/xdqQmMzI2q0q1/JaCTmeq+J5yJgi5No9JZJsHPQgYf1rIWKPVlQUOCm70+V/oB3TYs+Ax6oDHg8oZFWRhBJDg0Jng4N7R2cYMaZkBh6T09gqNFmxdl3XIysCWCfWmmM4X+WFp5tf7gft7mj3hi4mYRV3fhxDCwwBlMsyIBo1QKqeaG8KLVRFaZnXxO6woKbnIG20OvEDs1Tx/Q19xms94md4/mT+Q9sEe0TQ/+yT7o43J3Vud/jpp86zyTLUIVCz5zUf1WsfHOHJx2hsgxe7yjpdEtwBGmu/np8u+Smy7/MN0YzViq8pmxqdJrBixuPdg173NI/QjQSaCy+E2FbqPsSPZKhcg30KAG3y5Vrbh4/9WjMrjEqPB5z+nqHAFA2lRmsOidHJxCxVjQYNaoEExzZ6F+FrFrxD6KxV5p/XDmXz+gyUsqeXNmopsQFuJYDf2JZS3zHx/GVAFsMhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(2906002)(7416002)(107886003)(6486002)(6506007)(1076003)(26005)(2616005)(36756003)(86362001)(6512007)(82960400001)(41300700001)(316002)(54906003)(5660300002)(6916009)(4326008)(66946007)(66556008)(66476007)(6666004)(966005)(478600001)(83380400001)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxYCPnoyPPx4EIA9dW3E9a7G7hoj+karaDtfapqkmLc/Zfoz0WZPB4+T14nw?=
 =?us-ascii?Q?TLaE6K4M2oqP3NXweaJMFqsU+WhbSKhnGM6ws1R1c6HQy97w+VVb+MUw/fCp?=
 =?us-ascii?Q?otMmhKEPqbWzXwqVtZK9kP1Ao0+7x9rszJ7qZaTsznjhBOUVvUK2cAWdvcWj?=
 =?us-ascii?Q?9bAMdEnYSRmTKj4sobnqYyQ7tF0W/DrqWPZXbWXcrh82t8jqvYZhIX4yTLNM?=
 =?us-ascii?Q?6PH1FuTnmQNeZ0ng2d55p+5bnCAKFptuyfWUP3sfL/j4lW39EDi3SxQdTzho?=
 =?us-ascii?Q?sDXjrIXtjEt7slboDkKqjsN/ndZdBAsM+FkQxr+2S8TWjQ/eA0gmepxKTcHk?=
 =?us-ascii?Q?ql3dJHoXfrmPfQzilCqsnbd5bX4mtkthREqjGwBAiug2GrLNzaFYSvqpUIfy?=
 =?us-ascii?Q?GaJmv7vHHpHe1za+VThruVjaCebqelUOFKH6vP2M67C3HR0GMastGOSVGZjx?=
 =?us-ascii?Q?I0etkNxrJ1qxsZlE0ODLN8ZsvpkjKtKDlmN4ojBo4bnb1+C3aoriJM0PxLnB?=
 =?us-ascii?Q?pKdRFTmG8ZCNCuvuw6SXyke4VtSZEKETwYuORDT3vmvuLkLAU9F2AEb+Mjih?=
 =?us-ascii?Q?D5wHhf6MVyAnPVMmzHDHTiKpKdtPgI5Qdbyj2BF+n7FUmBmXIFADNZAHST70?=
 =?us-ascii?Q?8XECryjDgX8F+AU3rTb/hdrDxS3VJMgpfTcTmWNhB1MnPkjOj466QC6pgVKA?=
 =?us-ascii?Q?vFzbDxq7cb9k5+yRBAJRDPZ2STiu+EJGj8OOGNDE4uMfvkXlRi2XyPqfCVXA?=
 =?us-ascii?Q?hxX02BftTsyhh4GAkgcwP2xNS1wdNQRZsI++xba2BuJ12ovH9oszrc/JKHfW?=
 =?us-ascii?Q?7jJyO9k4KnmGkMCvCQtgfdb0yIhpLnuBHvFiDmdDTP20mRZ0yrukwyhf88yZ?=
 =?us-ascii?Q?ipbZlcXmdLeHcSb6WN01ssscrxaBGaFA8EnVnd5wlCBfn4ZZ+/0t9rd1KBQ4?=
 =?us-ascii?Q?zv9fnvMR7FhSwBNYBWtDfrpC9J3lIi3wnpy5FPhqLO13wqiVUZKQ30eMczm7?=
 =?us-ascii?Q?vQNPkncElk0IUKLSLiEq172n4Tzsu53NMGnoBJ1baZMhYiJJ2g2UFCkmyJ12?=
 =?us-ascii?Q?fx0+pEGfO/ipTcJPDVESgZd0JjsziejvJldDQvTjZK2W0YcyOT9WfjpK5oiD?=
 =?us-ascii?Q?cSn1SjtF5VBGwX9PdE8vuFdpfM2w9CEf0sTR1drXDBw4c1m9eFbGlFjhPOE9?=
 =?us-ascii?Q?Fx/Ujdx1Vqd96eKOi0rikDkBv2KHAy4V/6AzC2/Tg2b9vJyQxj5yvEAai7gm?=
 =?us-ascii?Q?ZF7cWldb107uA0axdhNAe6I6kd77tN1qKT5LxDUSAdQ111mu9qW5DiX49EQf?=
 =?us-ascii?Q?eV4iNhdWMWXSrMl+0cqIBAbLCDT3JnwarK0w+LP1pZN+z+YTeDulVxEpzb3L?=
 =?us-ascii?Q?u9foy3fp+90b5CZ5/Qvmt4yJOwUKiwch9IRLHaXbSq6SzQsvVlkF+VO1o6Ht?=
 =?us-ascii?Q?IeU7W8t44qa3Puh7XRoT18l9qDCMpGne3su7PJyzYxGpzLfInZbN+G1zYbho?=
 =?us-ascii?Q?lyauRVubCi3rm5z1mjUlK6AkMS/sTM9BKIPTwfG5mOraB1jJH5I2Hkg9raPZ?=
 =?us-ascii?Q?TqfmOMir8204AgQpl2v8x9HYsH9bHSYGBXajHJw9Cy/0x1QA/OrMG54gJV15?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e75a2fa-f19e-4098-2d72-08dc127708a4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 07:29:23.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCqkDB940vX6wMP50I3Lj/9w2vu5W4YOJH4coU1Mj2PvoAQzaFUY5CYnU2QVSgn8aljz1Mjr9XKJKkuhwKSw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5984
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: a414d4286f3400aa05631c4931eb3feba83e29e8 ("kasan: handle concurrent kasan_record_aux_stack calls")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 8cb47d7cd090a690c1785385b2f3d407d4a53ad0]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------+------------+------------+
|                                                    | a914d8d6cf | a414d4286f |
+----------------------------------------------------+------------+------------+
| INFO:trying_to_register_non-static_key             | 0          | 22         |
+----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401111558.1374ae6f-oliver.sang@intel.com


[    1.582812][    T0] INFO: trying to register non-static key.
[    1.583305][    T0] The code is fine but needs lockdep annotation, or maybe
[    1.583887][    T0] you didn't initialize this object before use?
[    1.584409][    T0] turning off the locking correctness validator.
[    1.584930][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc4-00331-ga414d4286f34 #1
[    1.585652][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.586518][    T0] Call Trace:
[    1.586782][    T0]  <TASK>
[ 1.587071][ T0] dump_stack_lvl (lib/dump_stack.c:107) 
[ 1.587449][ T0] register_lock_class (kernel/locking/lockdep.c:977 kernel/locking/lockdep.c:1289) 
[ 1.587885][ T0] ? is_dynamic_key (kernel/locking/lockdep.c:1276) 
[ 1.588290][ T0] __lock_acquire (kernel/locking/lockdep.c:5015) 
[ 1.588671][ T0] ? x86_64_start_reservations (arch/x86/kernel/head64.c:543) 
[ 1.589135][ T0] ? x86_64_start_kernel (arch/x86/kernel/head64.c:485 (discriminator 17)) 
[ 1.589562][ T0] ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:432) 
[ 1.590077][ T0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756) 
[ 1.590449][ T0] ? __kasan_record_aux_stack (mm/kasan/generic.c:539) 
[ 1.590907][ T0] ? lock_sync (kernel/locking/lockdep.c:5722) 
[ 1.591269][ T0] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 1.591698][ T0] ? __kasan_record_aux_stack (mm/kasan/generic.c:539) 
[ 1.592158][ T0] __kasan_record_aux_stack (mm/kasan/generic.c:539) 
[ 1.592598][ T0] ? mem_pool_free (mm/kmemleak.c:508) 
[ 1.592988][ T0] __call_rcu_common+0x6b/0x710 
[ 1.593475][ T0] slab_free_freelist_hook (mm/slub.c:1783 mm/slub.c:1837) 
[ 1.593923][ T0] ? apply_wqattrs_cleanup (kernel/workqueue.c:4329) 
[ 1.594370][ T0] __kmem_cache_free (mm/slub.c:3820 mm/slub.c:3833) 
[ 1.594770][ T0] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140) 
[ 1.595193][ T0] apply_wqattrs_cleanup (kernel/workqueue.c:4329) 
[ 1.595627][ T0] apply_workqueue_attrs_locked (kernel/workqueue.c:4452) 
[ 1.596103][ T0] alloc_and_link_pwqs (kernel/workqueue.c:4481 kernel/workqueue.c:4599) 
[ 1.596523][ T0] alloc_workqueue (kernel/workqueue.c:4724) 
[ 1.596910][ T0] ? workqueue_sysfs_register (kernel/workqueue.c:4675) 
[ 1.597380][ T0] workqueue_init_early (kernel/workqueue.c:6605 (discriminator 2)) 
[ 1.597809][ T0] ? workqueue_init_topology (kernel/workqueue.c:6531) 
[ 1.598273][ T0] ? kmem_cache_create_usercopy (mm/slab_common.c:363) 
[ 1.598752][ T0] start_kernel (init/main.c:965 (discriminator 3)) 
[ 1.599116][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:543) 
[ 1.599564][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:485 (discriminator 17)) 
[ 1.599981][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:432) 
[    1.600482][    T0]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240111/202401111558.1374ae6f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


