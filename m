Return-Path: <linux-kernel+bounces-125937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B9892E63
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02061C20BCC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0D515D1;
	Sun, 31 Mar 2024 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KV9ohLWL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BDB651;
	Sun, 31 Mar 2024 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711854476; cv=fail; b=uvvbbR5kJMiI7IZ7XXGI2DC/c8uk0Q3B9bIK4/fPatS0YkL+0T4OKTLPyT0ZlOZ0Gj5I9yxlGT8RuzGX2M8hdAGq8UX4xzMTreF7kJ4vLGulXF+0MaHeSXwerYYHQZ0B8TqY6a/Wv9h39fi6PniW5Ghls+LJ773++kBLn9AI3m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711854476; c=relaxed/simple;
	bh=9kDQ9mXTRnxlsFW+kxkylfdQVSPiPTdTh9cYQO4BNy4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=u7ARrTzNiP0wl7aJLIk9CWefDNLpWzFdoMC5Z6aDHmIWEmYmCK4XrVo3E075ScW6Bk85s9xMRB+VU4rcgXVyEG9vVvgto74U2LdoxhN5+ecO+Fc1k0x4LJd93NE/S2w2+In/LQT4iXmMcKl+uKfycGh4pEJ8PvaKTzZYtrPgVmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KV9ohLWL; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711854473; x=1743390473;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9kDQ9mXTRnxlsFW+kxkylfdQVSPiPTdTh9cYQO4BNy4=;
  b=KV9ohLWLWaXLMTsNAm2V5vpmrs5F894ynWd76r1KIeHfsUaX2xoi1RUK
   q/8IAUjnERKElyzvaCZP0UymhMSuHJ7CK6bS3WS8Qpn6RhHJzijOFZ2bq
   yVNMagmf1w7Q1fPHlaj4yYCsCHwEmW0CWysxFQzf7Na5nJE54e9Zr1EZ6
   0UhfTXQW/YVYSECef+ghpU5i4TkaCFvO0RRIrSKGoZ2ui/hUIQtMh7evj
   qTTn9VLNAqtCRUy+OCWitSXZiDFzTaMTbqCEW/WO92IoYFQ78AWopD7QI
   zNu5nTZRtIwK/0wYxsLiNuByyILYz0idQ/d74Tq4V+YKXSF1f3MTPCWvc
   A==;
X-CSE-ConnectionGUID: 3Pxly5XeQ7ynMRZQiOX7fw==
X-CSE-MsgGUID: 3AkoLr/VSMiinsDZ/cYQYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="24490261"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="24490261"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 20:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="21860200"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Mar 2024 20:07:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 30 Mar 2024 20:07:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 30 Mar 2024 20:07:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 20:07:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6IORCI4BYhnMY9NGeMiLboop5dPVjrjvzmTZSNT0x0tIyzi9J5xXOpTUkLXefoLqp2XXWs05lXD6YaEH7Gf4N39lNAi2NXR3Y6Tqi5pXG50xbdymqA8PJMadEj0PBwqsz5KICwatzNZY7DIrFAgRHSkvyxUCl5Nzoeo2at26SPqRSStuDH0FfSgKIibR72NtNoV6Yi99oNHqxLP1h/1nllxmNemqN1IsXKV/dWEOnr1PW6W6DjN9MNnWr0X+npiCnWSXFSr3Md3hB15qUPSm+o2tamGz5wdObJz15jKWzTE+6kn/PfORc/CrRGaRMFcZZXBt05hWhMFZ2+Ppjx0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9JqmaBtc7PJmeFhAMp3M7JjWJ5M4xpBU5cxDGhmHXA=;
 b=bp/lLr3kH8R8a8NXazpNmyGKe5er9z4rEUAxSNFrUI659v7qjj6JKrkugg1X8IJJD1QJyf1Qm+sLc/3MybWSDzgtrLZRsM11x+o0kxf+muZ4To0gRxprKZvbasGFnpDumcVusMC2DdJanf7JstygI4ANQDrSoV60R0wH+YG0tu2ck1dZVizyDNJKDZx7F91F5kzoWRakRVVHC7JDVWFRsixaoMs1lerD69fWDo6hP8oTBRCK39/iiSJ92//rxaw8QRGO22aMhyYU4jqHZpruRkhCxcrodpnGy/HYEI3RefuouLRVuJjKiqTnnJGhUifM6uzX50OvV1Xf4QrLJDsKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.20; Sun, 31 Mar
 2024 03:07:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Sun, 31 Mar 2024
 03:07:48 +0000
Date: Sun, 31 Mar 2024 11:07:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [fortify]  4ce615e798:
 kunit.fortify.alloc_size_kmalloc_dynamic_test.fail
Message-ID: <202403311042.8c622906-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6467:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ltbzu5b8qJm14VjJ4+kxvr36PT4u12BHF4ZJuoOfSNWLeJ8Gdx8Cq+zF6Z+w07W5DUAhQbigvVeM03EMZMxMwPIGtgWbIC6LyKF+zE/WSc/nJyOMZUrwWkhNPxMJfxNtX57FDwnWaqQpgK3989oRYniEaaRWXu/HWXaO7qRGVnKRZ2fycNAekSTWvYWDmj3R+yaL3M+WZGNYCzH2t7zon+UeQL7oz6uR1miWC3v9pJnj4LMjKRi8BvjxniNVMk8mYMX8noB/+azF7t4aUiUDLWNQ8YkkjGZLi6I9Vls6SFdpP6gFgxv9SVjPRoqd9o5l3usQtGtZe3yD/rmRmeS/bmQ53W6xcjDjX8ZlxW7MQVVp2XvwFpBkZTEp1wsgvf6s3J3wtrcqdAzgVnevo1/Wzd2yllJ51tyNc94b5RAONbMt7OfxrpN7q/7uwtGfNCSEZ3p+RywQWifhZ7A0nJpi8lDtA8iEjoxj9FJzC/Lwb8yaDvYXZWqHlGIm2S8SLKCP3ZQEJHeA7FDvAjyuAXrLiqF6C2emXEhsfK65yOnYXwn6xILsWJWOelq7VnGQ+xCempFbfkjVtwZ+kwH0qpgSElE/wxfBxwipmmeu9s872XAXKBO+N6KgguKD08zW42ni
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxWwbuhEDiMOi7bV7xNj7EfNISWA8M3yhFWBkYCebc4jExiNn1Q/33tiqkPm?=
 =?us-ascii?Q?O3QvxSK2MupUs+UiwMMzQOv87jV6j/v+RMrDZCf3c4v+WwQ6X9XAltcqwyAm?=
 =?us-ascii?Q?cz3MZg6aU2xzhfAcWXtT49WbAiOb2EryPUWhwkbZIy1e+yKKVl4IG1t/zyWw?=
 =?us-ascii?Q?CsoD0kTP4Mx7WTs9/ZCR9CRoxEDmIT399AyxmHY+6ub4SwnrSCde6pN+NPx6?=
 =?us-ascii?Q?EdxTFyiGO6b8Z7gDaqryeI7L6tGrylZ9hwn9NIab4OSW6bA3KY3ADcmivETo?=
 =?us-ascii?Q?3hD4TuVS9OziqUZONl1v6nBxZuyVAUsqmjhq6O4V1pl9IUiK6kGXQf0Ijwhe?=
 =?us-ascii?Q?wAzgOt84B+1YtQNOgA4gjCrdOMsvRMX6QF5A4/WTRja8PDQhLRDl/wQO1tRu?=
 =?us-ascii?Q?eaFvRCRiQXeV0R8QPL5+6yXruP4IA87yXo8iqyNqYj3f2tek/Gy0ebuN/FZp?=
 =?us-ascii?Q?rh9ao8Zo/4gUOpYE1cC/GIwLjE7053IbtxhdLeVUdJc40+H1M7mKAbjmGyJA?=
 =?us-ascii?Q?QPpG475daKaGAPoX4dIMlH+YLiCSnJ8g1CKHyNt6V24PWpSVNUy/qZK3Kcpr?=
 =?us-ascii?Q?8SmU3aCh32zU7MxIuOQjMwrYGNlf45fnEFAp+aStUA/PJRaz/oOMpHOheORX?=
 =?us-ascii?Q?o5xsvFlMr8exbfwCxw9AOkxRChmFTVbQ6ESSorlblcZZbCXHdEh6rXpkvGlf?=
 =?us-ascii?Q?hTSfYyx1LPPcJ1FmUfJbBtJAlACrLzMCcO9PiX+o/NK454zFExcsvKi6KOG5?=
 =?us-ascii?Q?kPNVxrYSzZxYz16dM2pPFxniz0yIC8b+6+wY9MVJmGLR2qtw9VdeKC83IYO7?=
 =?us-ascii?Q?h18bx0Br7hUgVt0Vl0zB3RiilyaNJ4YwpFQAO6/fiu/PnsyyBuSqVFjNuUA6?=
 =?us-ascii?Q?zFJOFJtVTwPHtVleKMbwV+OMGwjAmLluiEqND4rn2srZ+LOjUn/U/x/TlsbY?=
 =?us-ascii?Q?T88oe5dWot0Xxgt9TvD3hllw/KyyXMvJSZUq7QVZ4vRd4dMDoNA0x3GCq8P1?=
 =?us-ascii?Q?IcRx0cUu/UqWoUfQfz8ePZ2OBlWDV32qtY+WN/skKmrEFJs1ysqPTxavVaub?=
 =?us-ascii?Q?HgmH5z1WEdlipomb+O0+E1/+JkpxXK8PqGDcqCM4yj24sJH4cybqCSV3PMlD?=
 =?us-ascii?Q?VkwvK32P3U49mniN4iSdop7iWw/nzuS3nhwCykqQHdj3Y6k5khvRQ1bwgH0t?=
 =?us-ascii?Q?Q6EWF6dTDRtGdgNSO4JYsg2IOC2zeZfYz9Eejj+qgrmqR07BKknC30xXiBBr?=
 =?us-ascii?Q?Ct2u4GY87EpPhRi9tXwYRyEUmdvunz8HA9fgIstPHKJzXiCxIPzcOc62YxOY?=
 =?us-ascii?Q?OM/hQx8PoLSRdIJcFIt3ulspjPlga98k2P32JTCtABz03t4SOXRY0bqUo/SG?=
 =?us-ascii?Q?+jsHXd04Zw5S7hjzPnPZ3qVLQHXcjurS5huVHERmCzoPthWi3w7u8fG9+m/c?=
 =?us-ascii?Q?7tAtvLYRmsMwLjtyukabF2y4boeEPuWIIifXaovwJOi3YKVOGgZ/myOptY9P?=
 =?us-ascii?Q?l5t1/rWBNS00OABxqd4ZsVhpGOFXtIe+/kcNJEVK2WgQgMTg21F/ZKV2i0y9?=
 =?us-ascii?Q?UHwpXLUsgwl6eSQZ33wg56F3KQCDJl3B2a5KtrqaHPCkjO/hBlQv6nhfMZus?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d4ac80-c15d-46b3-ac9c-08dc512fbea5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 03:07:48.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0ziMVl3r2WnKsWvmyttMU2zk+EXA+nyTAuMFW/2pHLdoHSjbJ91OGfAdAf5XK+vVP98aTxVV2GFzjEwfpZFcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6467
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kunit.fortify.alloc_size_kmalloc_dynamic_test.fail" on:

commit: 4ce615e798a752d4431fcc52960478906dec2f0e ("fortify: Provide KUnit counters for failure testing")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 928a87efa42302a23bb9554be081a28058495f22]

in testcase: kunit
version: 
with following parameters:

	group: group-00



compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (Broadwell-DE) with 48G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403311042.8c622906-oliver.sang@intel.com



[  332.725985] KTAP version 1
[  332.730282] 1..1
[  332.733973]     KTAP version 1
[  332.738613]     # Subtest: fortify
[  332.743557]     # module: fortify_kunit
[  332.743609]     1..10
[  332.753298]     ok 1 known_sizes_test
[  332.753591]     ok 2 control_flow_split_test
[  332.760829]     ok 3 alloc_size_kmalloc_const_test
[  332.767135]     # alloc_size_kmalloc_dynamic_test: EXPECTATION FAILED at lib/fortify_kunit.c:248
                   Expected __builtin_dynamic_object_size(p, 1) == expected, but
                       __builtin_dynamic_object_size(p, 1) == -1 (0xffffffffffffffff)
                       expected == 11 (0xb)
               __alloc_size() not working with __bdos on kmemdup("hello there", len, gfp)
[  332.817141]     not ok 4 alloc_size_kmalloc_dynamic_test



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240331/202403311042.8c622906-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


