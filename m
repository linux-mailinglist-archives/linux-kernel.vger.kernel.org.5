Return-Path: <linux-kernel+bounces-38077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266FE83BAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D91F2483F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784A125BC;
	Thu, 25 Jan 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb+H1R21"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6A125B2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168090; cv=fail; b=r8yFifCpLaL0ihFfcsQennum9rOwbEfkahdM89pGX6070Ggc/FEw7HbPNNGD0KVJJ1El3gX/uANykYs5scZcZvvMv5vfy2qMamN7FXhZicIDMNGm1ZvK+0zyt6zMxMg2zvlOQo899fe6dr9qs4YPV0kPqgEw+BEoRvse7cl5cEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168090; c=relaxed/simple;
	bh=sG1IoQUSt1zJf6+rTtEpf0tWNHvJ3KlHVX+L2LhYKVk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sp+TgO5jzqgJ4vDWf1XcGo1vCegbwgFA0WU8nXs5u6IsPNjlu8324QIKjzKCsnrnS4rGtqJQYm14a2sz66JX/z21Zx5BLs7/QfDN0D7LyJXBJqpgilOmMCA/aoRzon4wiStNduOE+1/ggkuWQ2z7mP1MgfHIoiFthAJmE0xHhjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb+H1R21; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706168088; x=1737704088;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sG1IoQUSt1zJf6+rTtEpf0tWNHvJ3KlHVX+L2LhYKVk=;
  b=fb+H1R21bGgETRdEPin0KAnnSbX0MEiHmPuC52iPRJ8NARWxOyqMC3Is
   ST1WReoiC2TwudkGW/CkdjdhV/1X51993ZrzFtQXjVm8CbdsuHJBJ0W9v
   wkGHYtrQuQ/uPiHLZYWzP4hUAVk7818IqkD89LL+7eqlLmQEn08ajv9zU
   ca9C7D6dK2U4PFC5A3s14WZ6CXwTuU+qa5q9AgPhjJea4+xUnfo+fTyUe
   K2OQSvvI6/QduGpV3rIyTwULlw0jCgqa/nxcecbn8Nu9FjO7K28ftMaj2
   /ayHAh8gSJPW5OyyK+FsunFkVCXqlbFPBHGEgGlGLtl6eWzjEkK4Tzpwg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401736232"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401736232"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2312569"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 23:34:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 23:34:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 23:34:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 23:34:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9/khsoVwvLXXmMIG4g1IXGbBwU5mgc6pl5EW2bwUkLJx2vdjpxnPe6Xhu0TTmWw2qDRijOEI4I4rFUUYT/JaE9GACsUb6d6f8V8BUCTLr8WX6YBRp9WmDqR456N7OjHOS3OvA2QblgyYzLhdQD1f7m2s41pUDKhpSW6dno1pRhDXbW086LFqxDeiVLxrxTCPRelQGoU+jSjyvCYMR6YFTgQjs1D5VcyTZOm+P2P+/arUSFSO+QilTU11f1q4HDXApt1JZAt6XXGlFWdByYhiY6x3aRmB4WnPGmOWWrec+q7D5K6n2UgB+Zdzey7rD5tXH2D/jZfGEjIm5QwwmTUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulBGmPyRM4AP9DnxFsFz8hMuVr22P5P4jVwYv4Y+0uE=;
 b=OtK4hyaoznKQO/v8r4LAnmqT/7fz3pC2b9PVvBJ/A52Zw/m6ak3frYmNxuOJgu6g8u1QdcpnqRJdXVOFkMKmGljSSwYDEiNZ8rWngTz6RsGXIOHbuIq1svPGyK1NtSoXOdrMRDLxzvmdJHDVvDXYHrAyX6mtZZJEHcbCaOKsPtlgZ9hNBwKehFgpQzwquWrB2e1L7bXenDvuBzwpIE6yREUc5U02Gv+CV0wxVTlJOqzKcloI6fcwzPCv/os9b71tyXJ3sci5MCKg5QFlREHNNay7qfbU9zmbSWmyzdemsHF9w2iQikv2cHW4Gu52Ruy3Uk9Y46K1gO4swCDYazA1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5660.namprd11.prod.outlook.com (2603:10b6:510:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 07:34:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 07:34:45 +0000
Date: Thu, 25 Jan 2024 15:34:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [kmemleak]  39042079a0:
 kernel-selftests.kvm.memslot_perf_test.fail
Message-ID: <202401251429.d3dea02b-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcfb0ef-8490-409b-667c-08dc1d781a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BR87WfK15e0Y9qQJ89wJw4FF0fi6h8ilLj6EN9bOLr1VLMHFV6gAdLteXuR/iAt6z/j2Iu3rhIwmOOrX8/SauJhQIdoFij6w6lGTDoZ1Pj3z9mpuFBrgXSunSvXj0oaQ5BzOLhSbeyAGnYlOfZ0+TjqztoDgUwrPsmfmPKopa3TjbajvlSWN/IA4EvMG2K7p2zxN27HlPgKs6c8/24OZe50QtSxsqRKuy+3ZBpUtqnLjxXCtFzBY5X1ZD681AE5G8uos3XP47V2lnyT9tIZsixSZAzCqzvgpZW3PbsN/XQMAl0ThkEQCFaAQZHNMRhvRBxUDIZMA8vYQfc9E/bnXfmMP27SWQmf6JOh1AQ3ZJ7W1gvERRAGGvvGZ4SYBlxjXRpDmWj/Owmc2eqL5mLVzhnPJJnAdfs9z9eJvCXt2Cm+NVNWyT3pHpR6wPXVS8u+5PU4N366RSuOT+yYiTdVX8nQ7fJ37eRkoEu9c9kh2PiVDezZ9J0lmFh/jFlESXFEzJBwxb4aKeIZGXb8ccI8/FFhBDQTc/ewYFcMb7fmFJ025Ijpt16nfpF4uKT/PoQRd3U4lL3Uk5aXO+B+p8nDzmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(2906002)(36756003)(41300700001)(86362001)(82960400001)(54906003)(6916009)(316002)(66476007)(66556008)(6506007)(966005)(478600001)(6512007)(66946007)(2616005)(6666004)(83380400001)(5660300002)(8676002)(8936002)(1076003)(107886003)(26005)(4326008)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMrDzFIqxC8GwHMluLC/FBnl9k8PPXy5ubb4bzn8vHilrYZnFSIddHPnyxuM?=
 =?us-ascii?Q?2cNs9aJQtl8m7D2XwDiCEOlnYC26W+1ZUjyBnYDfVc0sYUCG0mTNF+Vi5/mx?=
 =?us-ascii?Q?GCYymYtSdoE8T2Hy7ELtftklum8WnpY1SnbWHSa0pPiMrXlxD69C6gC/ngl8?=
 =?us-ascii?Q?sNs6e3jDZmOWKMvKOsnrXAODzLLQlOwV17xaVGYTVuYR08JbjiFz9xlqgC/i?=
 =?us-ascii?Q?UR1ujuSX8wRh9pIEA8sNh1L4cZeL4CqKjfKFOvtl6aR2RPsNsgyqOGKy6VeC?=
 =?us-ascii?Q?YwLud49AYzB7FhxDAWr/ZJoCTTf3ezjmoUFG2kyeWFlT1YgdSYbCJj7NxvVi?=
 =?us-ascii?Q?i0MlEEX2yPVyQC3WAtQKXYSkJfIaIlxCWW3o70nCxkci36BB+FTp0A0fzrO/?=
 =?us-ascii?Q?vNL9haX0mv2uWTPARoSr5oOLvkeaJf8mmsEzP3KFD37lP/ZXeN9yk5R1AoKF?=
 =?us-ascii?Q?lcTyaSqLZm+WTOrJynedltNSsB6m7vjWH2OUYu//zSICiZsQyKuaXrEGn/XD?=
 =?us-ascii?Q?PYoobw71hY+gXHVQ+pG0Yb17E4TI6Zg5E+2S/qbqVZsbmDqaas4PLUtCteBx?=
 =?us-ascii?Q?5goREEc5KQqvIPMaEwnytI8otbcdLA+Pzar+UT4KpMP958EWY2Kp6NMZXyJF?=
 =?us-ascii?Q?i5lBcbQyaK/hc7ErkXGGjGFuKJE5R6CdOX6w4U9BpmLfE+PU10iTYLEjorvS?=
 =?us-ascii?Q?8do8BzcSHvNr1Wc0eiZzGFXZYelRz1x3CwEs0vtHz61kulT1v94Tj4ZjLjPT?=
 =?us-ascii?Q?3kXMuxGq/H4EIFW3BVJnfk7NxNb4eOmboeRR9XwmAVzWlcuXTu3eeN6HjNPa?=
 =?us-ascii?Q?FW9628kSOQ4WD2bIr5x4WOZsxtav1EIQAqCn55bB+MaPYTBTP0RTbZvfOVrk?=
 =?us-ascii?Q?AabZ9AS1jbbDnoo+vkzoJS3zBEVvVB6Z97znE0NvHV28vixlBLTCubhMCocL?=
 =?us-ascii?Q?CeNYSLp9cjJf/oVEq0H6u/ESPgmIYO3hTblOT4fCCNuPA2a6y/d67uU1N6tV?=
 =?us-ascii?Q?0ABydLjoagAQhjsv33a6y3AIyEWXG9R56J3kwbRx8jxRmdflAQGCPoBoUBdH?=
 =?us-ascii?Q?7CGHWZBElGMcWVSgC48WaLAXcYvA35T6U3vtnilVxt4+He3sBQqKlY15goeF?=
 =?us-ascii?Q?WWlpQLaPTyLj1JDnS2U4n5tJdCEKROI/gTMf41IOhBkM5yabIlHNis5Vhe1J?=
 =?us-ascii?Q?JI2l3REeT3ZZliVotUv0l49dcG3Mx0pRTmJYWWj7K0EZfCHqheAnAMqOVE6p?=
 =?us-ascii?Q?GL6W1KLUIgeeNxEDwFby+eoadQhzUOeTYWBCAhmx3Vbcif06VPHugR9T7gxv?=
 =?us-ascii?Q?vTD4pzKCa0B7FYJDtXogGf1VH5zC+ceawup5UqtAamGC6Seg05R/0XtEpxmd?=
 =?us-ascii?Q?FrAlVzVJvMBYk85CWCLfpYVhIaZpKO9AkG8E5jGhs+CWAwUKaSUXewSkRKt0?=
 =?us-ascii?Q?YVSDSAtQiodVzjP3ahV9GpLzgblZHgwt7KUvWAAhmXc5PigE0iHsvrRJKVm7?=
 =?us-ascii?Q?rC/uGDoBXyyPcM7OWI+iAhZ3cGuQvHeT523zZ6MeK4s9QsJbwUpy1Jr4Mhne?=
 =?us-ascii?Q?7SuhSYP17j3ggmHV10cj3hoHNuHrjhOYpYmmSsV5QCTuH1VLAGidISdvADvl?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcfb0ef-8490-409b-667c-08dc1d781a58
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 07:34:45.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU55dxOpJmz9q44AziMN7UHgxg0U6p3KRnlch8jT009Tey0WC+NEOm2RBxD3fTsgWTIZQfEoIMeDX/bvDyrpdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5660
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.kvm.memslot_perf_test.fail" on:

commit: 39042079a0c241d09fa6fc3bb67c2ddf60011d0f ("kmemleak: avoid RCU stalls when freeing metadata for per-CPU pointers")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 9d64bf433c53cab2f48a3fff7a1f2a696bc5229a]
[test failed on linux-next/master ad5c60d66016e544c51ed98635a74073f761f45d]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: kvm



compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401251429.d3dea02b-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240125/202401251429.d3dea02b-oliver.sang@intel.com


# timeout set to 120
# selftests: kvm: memslot_perf_test
# Testing map performance with 1 runs, 5 seconds each
# Memslot count too high for this test, decrease the cap (max is 8209)
# 
# Testing unmap performance with 1 runs, 5 seconds each
# Test took 9.178259867s for slot setup + 5.035747214s all iterations
# Done 85 iterations, avg 0.059244084s each
# Best runtime result was 0.059244084s per iteration (with 85 iterations)
# 
# Testing unmap chunked performance with 1 runs, 5 seconds each
# Test took 9.460993790s for slot setup + 5.001833746s all iterations
# Done 84 iterations, avg 0.059545639s each
# Best runtime result was 0.059545639s per iteration (with 84 iterations)
# 
# Testing move active area performance with 1 runs, 5 seconds each
# Test took 9.235748282s for slot setup + 5.001305107s all iterations
# Done 4807 iterations, avg 0.001040421s each
# Best runtime result was 0.001040421s per iteration (with 4807 iterations)
# 
# Testing move inactive area performance with 1 runs, 5 seconds each
# Test took 9.113425177s for slot setup + 5.001150112s all iterations
# Done 4534 iterations, avg 0.001103032s each
# Best runtime result was 0.001103032s per iteration (with 4534 iterations)
# 
# Testing RW performance with 1 runs, 5 seconds each
#
not ok 71 selftests: kvm: memslot_perf_test # TIMEOUT 120 seconds


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


