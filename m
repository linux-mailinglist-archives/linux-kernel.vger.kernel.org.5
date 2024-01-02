Return-Path: <linux-kernel+bounces-14128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79758821822
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EC7B2173C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638E2101;
	Tue,  2 Jan 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQTlirGx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76DC20F9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704181906; x=1735717906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tHG+I9HbbJhdftCW++MH8mJZV9efBuC9Qw4GJPASU24=;
  b=EQTlirGxQ0Ym5wATl9ewhe/LCwejMtCm2fues5HNZPeb6MnZXjX9/jLh
   7Pnq2zoQKFhPQiZdaoPfY6KNyB6CRoHM1kPOpWvqHAvcQsCOxpdWY8LO3
   znblvZv6ZvV/VKzDBqLnOrrawFGlGXmbRRk0jpAI6opxDOgpPjEh52wKX
   6i/Luh/+rQ4+WQZiI2oeu0zNL3TkXCJqe6U84gzZ1b3G1Q315hSJbJXOg
   mKt15ZX/UxiEPRrf/P4xJH0qOvhoMNbULHyUY5XYWhc0cInYobIKXt/sE
   bR3X+KhMsqtFDzUI9ZOLfoHlx77Fg+YsqmbNQ4S4HMqrM7qUUKkv+Vbdh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="15491159"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="15491159"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 23:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="1026708853"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="1026708853"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jan 2024 23:51:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 23:51:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jan 2024 23:51:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jan 2024 23:51:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcESrQMEuv831B6oOmm7Fz5WMkLNKrNyCVI+HxboSo1ghPNJ7eoIDQjC6rDTH4wj3c3hV1ncNG2atfJAwuQxCBLGxNPYPQYVtvB5mVQgmH0GzrCw/S8LCEeSmQcXfQMHvukJMDiIRwUXGquCHG94qz2qcQNDskaxLjcHqvV5tDua38ZmdRBu0/NMbiSrUpSKdf5y4A/tBd0XlBQYtoYfO1E4vPoDUfRZRXmF8SKs3BD+JGuhEFSy6P73upLw8dJhrA3AQ/y2YsaXMTeU+P0CAPida1bCbsRQuVD0Jp3SufW1EEtZQW9KreVFjxl3zlxjM/0Kp4DR4fnfBwnt7pp1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+B0R0cDrhgDKScLd3I5/bTmacuUxpUYjn2NqdAGxcI=;
 b=doYoqMnBW0ZFU3+GAF0B+Xj8y6B+nLJfZ0pigjGMR5BdFFng1IC8K6aeFEVluYxqHf4tZntfn0Hf5JcEPEPwtfMVYDcXICW7+1W7GNk9Fe62mmzdrLuMJcWAm6QiDzRN2PiKIQA+etCWymMFRrl4GuhEiUlpy2ruyCOxoJqwqhuobCyeCPXMAxkuzH6Psop9/LkxT7pCs1qtwDFXznlT5DJ+Z9aNm+q6ZDTlFszHgKsqxtAb4cgmtagZlrZyiyvqJJgkcjIWBnBT9WHxPaa7Ec9eN5xXpYxQ+dX6A6lTaoana+3QIaUkAt2hw2PgBh1zJLK73CKBJvIRXjzGM9eUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 07:51:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 07:51:21 +0000
Date: Tue, 2 Jan 2024 15:51:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [tj-wq:unbound-system-wide-max_active] [workqueue]  3f2f2668e0:
 ltp.fs_fill.fail
Message-ID: <202401021539.5f688bb4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df1ce0d-9204-4504-8676-08dc0b679b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlWLUE2NSouVFKO1DMOyWZFB5+NV1qJ+0E2DSqaDbRj/YBL9QLA81KN3Sqj3hhZc43oX0IANVMHgVZNrDs+c0WF/kbskF9h1sON8+jcVKqRo4/3lT1fo3UYUjgIQmTiEN3Jla4SlGurA/mGXOJXaNZq3NlwhNE3oRcNUrurjkBipT/VvMd+YI9BhtVOoXWTcXWERMKU9MfSHynuG7jLfefHpRHpHOWOTCfjBH+xIoLSwKlbPolNAQ0DlAxswUZwC5AeJh2EA8WriN/JKlX9yM2IZCWbFcqIPDwxT1WylcDoNaah+zmiYZVmSvQYmOmv8L8GmRdwrTqKpaUbIX6fsEjUKFNEE3pdzzrMc4LAFgLiREo5yEpD8rap9Nm1DaGk6xqPDC1UFxB/2ZecxTebmufMz3vUb0zO6i1E1nlCbERH9DzecsVSPd59k7JhUWcePpdVkAF988hITopJlwS+MMcli5edmjPOFe3ud5lOSVXQHsBDXZySez88E2QAGCFRkOyMltMQoH44+kGv7PCIPATR4Lwz/A+w8qbTbTMwPkPHuT369XyVmbazQWdACBgNvMEnGe0iO7XzvV4egXAsvSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(30864003)(5660300002)(41300700001)(83380400001)(2616005)(26005)(1076003)(107886003)(966005)(6666004)(478600001)(6486002)(6506007)(6512007)(86362001)(38100700002)(82960400001)(4326008)(66476007)(66556008)(66946007)(6916009)(316002)(8936002)(8676002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m5bJTD4BnwomyrqxHXC1AFHtGmdubeBRJfih7ZJlkRXI65E7lGGGVpwketsb?=
 =?us-ascii?Q?1k2/Xu9b+ycb2b4ZruwnVeE4jFhAAXsdrSaCigiOPuou35z5RqXOinGcHOvY?=
 =?us-ascii?Q?uCA9z3gAFafPFTOu2mkfDSEMCx4thBcgGxwquwi3WHuG0/eJTABIY9qzciHv?=
 =?us-ascii?Q?kxO8pUCCy3egSZ8DSC6aFYy8rgeN3w2zNNaY27aROsUIytcjRryFHQzgVzsu?=
 =?us-ascii?Q?cwV1JYmKyoaK2RG1UvqepmhNvDtaOATPrlE1/jcdHKF4sbvMtamdvcUeJzY6?=
 =?us-ascii?Q?RDxkoPWcztfpmajKYhVZuyw4ovAAhYrBQbViUfJPWfAV3T+6ChnRvcXCTLYr?=
 =?us-ascii?Q?eGw/lcySYzXRokh7dV2H55ZwFCu8QggvrjuRPwcOeRI3gE1bQRT30uv0kdIw?=
 =?us-ascii?Q?KuaE2r8eSyd62myQ9eUgtI9qVs5gkoDVeJflHxvP0Y6u93FZINCilqXqu/Sn?=
 =?us-ascii?Q?Y41MEGpkNfiVNoDLOdMOuTVATlqrtL8wsReXeZmj3p7S8VkeSa1SkAaxjDDT?=
 =?us-ascii?Q?aewtky14YY463TXLmzt9jTjnjJqMKPLEASBJxp3i1Lxgg3jKiVTZ9Jd10CtS?=
 =?us-ascii?Q?QAIEAVQfV74hV/mB8QTA+sQ1CuHUVFXoH1fD9IJeC8f77Tr1Zzc2czOPljLX?=
 =?us-ascii?Q?PeNAS03uHJ5bUd860V+YeJX+CUqvy0hNhaWVe0Pc8drMiBElz0JGL1QL/Utv?=
 =?us-ascii?Q?xHzEK9+duw3OaHySC5UCqIh3yA9biRUNIEo768F+ra3am+DcPHcQqtCPN85r?=
 =?us-ascii?Q?+/0/R4m8myun5YkvqsF5bVpdzmrZw1sLpLY/LTv1fHxiIcQQprxuNbh4GPCo?=
 =?us-ascii?Q?UIla0BZMg1moZJbAovyxVqK4NrQ86bqkElJfEbi4fJwDUQ0CGKuPUx4GEu9r?=
 =?us-ascii?Q?4q4P7OBx7byZyReKuGBDmorFG1vNewQ4qS6gv1OtpBZhFBb252fVyKJYBmq4?=
 =?us-ascii?Q?R40vZ0qe4vw9IDyLXtSuzttgSHHXCUVFwO1UsBGpp7EMIFpPta+v276Ubnzs?=
 =?us-ascii?Q?15jQmSAxb6tONmeDvFKXKshg43GnRvDgwnd1ItornY25EIA719ZBcO16ANpy?=
 =?us-ascii?Q?Je2vtGsFm2cVw0CD89Ll6/XIWiqzULsDlZb8Wox1E7BdRQNzBYv9A6JhwWJ3?=
 =?us-ascii?Q?o6OJzWTo+vWanrLV/GhdL9PArdcgpSuPVF6iY33vUA8v9GzFGcodBU/JWPCa?=
 =?us-ascii?Q?sk2lv6Ma0vO0oI1O//rHMnL/7gvGq7NpduCsFOESXdONR/H3ZWE76sOSF8/Q?=
 =?us-ascii?Q?EW+oE2T8RWINc0F3zygfDn39jylBgYfEDj4snlifRVTXa/pdVaDEr5uMxrx7?=
 =?us-ascii?Q?jk1Nz0dB3ClWt2JGjo/TwwG0oaxizWJG4oLTNgTAPOj3k3WuEMT4N4sKSmIH?=
 =?us-ascii?Q?QFB4XXWQf6O7TTFKPn3oG8bm1MHt3D70Lvieg5B5DH+U9pJlIZNO9TbNP5KU?=
 =?us-ascii?Q?+hYzlGzb0a0p4pAm4k2f3vCnfnm0bh/yYDYBlaa50BWenRMy/v05HlCtM8iV?=
 =?us-ascii?Q?6MxjzO8Kf3mY3hi4kVirTPTEVrudEC1gCuvSCS4aJxELUL1ucO9yQk6pIqAZ?=
 =?us-ascii?Q?U7Z8GAPT1xRTmHkTk5xr+8ClWJ3I+9QSeA99B0Xcs2B/in/AXCCGgnx6QSmG?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df1ce0d-9204-4504-8676-08dc0b679b54
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 07:51:19.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydraOOfCugsjYnkLgL21K16hiSxhmNkNYEX/0Coq/6VsqugkPpSHAGSsLw3fx5GpiZZhXr/t3GKUi3BVtW3ZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.fs_fill.fail" on:

commit: 3f2f2668e0fb7df4fb57ea01d608c6dac1e56819 ("workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling")
https://git.kernel.org/cgit/linux/kernel/git/tj/wq.git unbound-system-wide-max_active

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: fs-03



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401021539.5f688bb4-oliver.sang@intel.com



<<<test_start>>>
tag=fs_fill stime=1703665553
cmdline="fs_fill"
contacts=""
analysis=exit
<<<test_output>>>
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
tst_supported_fs_types.c:90: TINFO: Kernel supports ext2
tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext3
tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports xfs
tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports vfat
tst_supported_fs_types.c:55: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:116: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:120: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:55: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:42: TINFO: mkfs is not needed for tmpfs
tst_test.c:1634: TINFO: === Testing on ext2 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.46.6-rc1 (12-Sep-2022)
tst_test.c:1107: TINFO: Mounting /dev/loop0 to /tmp/ltp-KHCULWskFx/LTP_fs_rzAQrG/mntpoint fstyp=ext2 flags=0
fs_fill.c:115: TINFO: Running 6 writer threads
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread3/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread4/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread6/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread1/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread5/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread2/AOF
fs_fill.c:93: TPASS: Got 6 ENOSPC runtime 1496ms
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread1/file0 size 21710183
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread2/file0 size 8070086
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread3/file0 size 3971177
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread4/file0 size 36915315
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread6/file0 size 70310993
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread5/file0 size 4807935
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread3/file1 size 90739786
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread5/file1 size 76896492
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread2/file1 size 72228649
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread1/file1 size 36207821
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread4/file1 size 81483962
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread4/file2 size 92198827
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread6/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread1/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread4/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread2/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread3/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread5/file0
fs_fill.c:93: TPASS: Got 6 ENOSPC runtime 1669ms
tst_test.c:1634: TINFO: === Testing on ext3 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.46.6-rc1 (12-Sep-2022)
tst_test.c:1107: TINFO: Mounting /dev/loop0 to /tmp/ltp-KHCULWskFx/LTP_fs_rzAQrG/mntpoint fstyp=ext3 flags=0
fs_fill.c:115: TINFO: Running 6 writer threads
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread3/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread4/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread6/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread5/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread1/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread2/AOF
fs_fill.c:93: TPASS: Got 6 ENOSPC runtime 5444ms
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread1/file0 size 21710183
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread2/file0 size 8070086
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread3/file0 size 3971177
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread4/file0 size 36915315
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread5/file0 size 70310993
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread6/file0 size 4807935
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread3/file1 size 90739786
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread6/file1 size 76896492
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread2/file1 size 72228649
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread1/file1 size 36207821
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread4/file1 size 81483962
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread1/file2 size 92198827
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread2/file2 size 49365490
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread3/file2 size 53944059
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread5/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread6/file1
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread4/file1
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread1/file2
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread3/file2
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread2/file2
fs_fill.c:93: TPASS: Got 6 ENOSPC runtime 6131ms
tst_test.c:1634: TINFO: === Testing on ext4 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.46.6-rc1 (12-Sep-2022)
tst_test.c:1107: TINFO: Mounting /dev/loop0 to /tmp/ltp-KHCULWskFx/LTP_fs_rzAQrG/mntpoint fstyp=ext4 flags=0
fs_fill.c:115: TINFO: Running 6 writer threads
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread1/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread3/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread6/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread5/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread4/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread2/AOF
fs_fill.c:93: TPASS: Got 6 ENOSPC runtime 1368ms
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread1/file0 size 21710183
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread2/file0 size 8070086
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread3/file0 size 3971177
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread6/file0 size 36915315
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread4/file0 size 70310993
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread5/file0 size 4807935
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread3/file1 size 90739786
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread2/file1 size 76896492
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread5/file1 size 72228649
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread1/file1 size 36207821
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread6/file1 size 81483962
tst_fill_fs.c:36: TINFO: Creating file mntpoint/subdir/thread2/file2 size 92198827
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread4/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread5/file0
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread1/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread3/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread6/file0
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread2/file2
fs_fill.c:93: TPASS: Got 6 ENOSPC runtime 1228ms
tst_test.c:1634: TINFO: === Testing on xfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
tst_test.c:1107: TINFO: Mounting /dev/loop0 to /tmp/ltp-KHCULWskFx/LTP_fs_rzAQrG/mntpoint fstyp=xfs flags=0
fs_fill.c:115: TINFO: Running 6 writer threads
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread1/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread6/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread3/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread4/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread5/AOF
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread4/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread1/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread3/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread6/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread2/AOF", iov, 512): ENOSPC
tst_fill_fs.c:126: TINFO: writev("mntpoint/subdir/thread5/AOF", iov, 512): ENOSPC
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread6/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread5/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread2/AOF
fs_fill.c:55: TINFO: Unlinking mntpoint/subdir/thread3/AOF
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Cannot kill test processes!
Congratulation, likely test hit a kernel bug.
Exiting uncleanly...
<<<execution_status>>>
initiation_status="ok"
duration=233 termination_type=exited termination_id=1 corefile=no
cutime=15 cstime=8014
<<<test_end>>>

...

LTP Version: 20230516-75-g2e582e743

       ###############################################################

            Done executing testcases.
            LTP Version:  20230516-75-g2e582e743
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240102/202401021539.5f688bb4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


