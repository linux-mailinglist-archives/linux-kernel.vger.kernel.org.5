Return-Path: <linux-kernel+bounces-110874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CE886516
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F06285D89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E624A2C;
	Fri, 22 Mar 2024 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWPEaVIu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B750138E;
	Fri, 22 Mar 2024 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073550; cv=fail; b=pwP1iSHcpYxkIjViAAx0TRN7f4rOPQjvGl861TDoA04IifBy5xn3O6w72tYsPQeDo+Hk4pnOLAJsqCLpwGQKq3TYdvqC6yvByX8F0R14upswIdbjfK9EEGS1FG5OWlbpKCrDixkPnSb4jrPRXxf9ztzejmzsA28D/thFevZL92c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073550; c=relaxed/simple;
	bh=9f8Fpm7WDyYQQPtzfcgTcT72/AyC7/x/cIO8zdGBDw0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JJHZyuSNmNxQ9eP+kQcvpY3S3GSPtKWSMJ7AZI+z1Z2YIbEWMtLUI7DgW+Uv4BiBYxfd/NLGpirf+dsmHp1i5lJaWpvLAYNC0lXxgVHWej1AJOvhqJaPBJ80dcLyklx74Re6sSfnV32H7dIs+21oFU4nYaxA9HZeUHZQm45u2n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWPEaVIu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711073542; x=1742609542;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9f8Fpm7WDyYQQPtzfcgTcT72/AyC7/x/cIO8zdGBDw0=;
  b=GWPEaVIunysqRUGuySQ/VtQE8KEVa/D0C7WiDEY/NXbCXILMJOqGXms/
   Ndy5b5NMlH8PcbPQjBs31x//zx5zNbqjPkOohXjY+bOJlNvokjxHX5vvX
   ne9/Or5arsYPnd/wsr8Q8b/XuNFOB4lloZtLE6TabwKeBdcPR96E8+iJa
   80pTClaUBf8MwtEIdldUSnnAS3ftzdKcd3EuQiQE6Z+PieafiDX6jHoZd
   P8xDMvr3eoE4yu9Pm6cWfOMz6d8QAFYPOmvWk8VSjKSQx3ftsTFox9Aas
   sC15ct3nO0As/NUym9ljsJLuMiEnsnxDQQ4ShWgQT9gftirofdM+OkHD6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6220674"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="6220674"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 19:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="14696154"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 19:12:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 19:12:19 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 19:12:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 19:12:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 19:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se0TLpoJxTQTFQDQXvw5mpx9zW+nKB3X+SuUKzjdbz2BXl+PvhcrgzpJ0PpOKQbIewQ0bcr9jciYQjOJ2j7P/AxBdrQidTW0JN88+nLbqZ3t3EzPZf5bBvD1Zb4U6PoVFWawq46mtUcBqZZvTZzcI0AeSxUS/1Bz1xxyiED3+m957LiPVWF4HPKi7YjKHaNdYEwhkfzIglx+u4qZDVfcFN+kKPmBkCGgaIhDXqcRB+vqAEf/lbT580bUgyOv/smzzUKAPuEMecVqcxUGqtpmi2PwtVgqxwSoP0TJEfFjrpx+e9psEIaLtLXUQyH4/dzIq2FNlzI/mxtbnj3Jc194Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HzI4M1GFdn1NUa+guc/oN9NAWAgctjuYKiVbSHxX0Q=;
 b=bhK0bllFKAsgpiEE1OaG4GkdPsBOw94OoEpJz8SDmcYd8eriWedhwNX3t0BBi4Ew41XRt+VEahs8pd7N0dAeN9K4IctXfamNKoE8UQ5bzQ3nKc1VQiJuCpoouLl7TLZ4SShFJV2KGDBU98GMa57/PAkwLDwZau4vtwKLYzLf0XAFhuSo3GruQ7AHR9+/B1INS2qIHaeRMP1uY+T5afRNJ7DDqXNgqHbIeMG04n7DMWs2iG5y2HVE6ozLQA/56qiF8JpZJUTmu+PpyZQ1pr6uQVP/LJRUvXnOmCr29DUGnKrJcPHISQi+PAefpo9k1UBpygo4QmOVDEku1VrPubSGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Fri, 22 Mar
 2024 02:12:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 02:12:15 +0000
Date: Fri, 22 Mar 2024 10:12:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-acpi@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Robert Richter
	<rrichter@amd.com>, Len Brown <lenb@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/3] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <202403220943.96dde419-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319120026.2246389-4-rrichter@amd.com>
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dc2a39-3d76-4c24-f072-08dc4a157da0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSbT/y6r4Xbt9UVXTSaCSbnZdTOX2L1Cs/zxYUILg5jQIvga5U35TiF2jE1yO1LZaMciCGH9xRZ627jB8OHGvn76EmAp/eh6mq85SbCVBDnjOo7Cb179zpzFhKOYh/PaLhfSJ8ilVX2+QZBLEq/UMkfXAlZyuJB6h/k7cIvrkuSgoo/agKBcem9/apsYnBcldDIau0Sew0wKUpqZzvFsLHc7vZzoaLid6IfQwPUCAL/TFGaSm76p5hjrbPetJViTl3NwTjp4f4CmcucO8EA46bW1LVUHU2mWnSagiDh22tie7Wj64Ldy5Y4XtkMibl2aPVbGn0jsk0spBU9hwaBftp00rsPjhipjmipXMHbBgv9FYsE08y1osRvNDmAU8cVLYqdQ5eIYAcwGn8Z0Vv9MpprDGAiYXq0ZsWeEMlndRAN4OhGnJHD0H8O+VJrIer/7emVVIPIdU4vNdmW6O4UsZgNWPpLtMZqlmtfBKxp0ls6T0UX/owe1od19YCHUO3JDHRuj8bydcYrJQo6p86XdN695EGMOEcdlvRGNtVy1AK4hbfNSQM1YGHyhJRGAeHYmUXCOrRFC35QNMuVb4ba4B1LQ5whCVvncpbv/i1yn3RBKm9P4opuwxzUc5X5WWMeu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dzu7mOmCQwrvkvj1DXnc6gFa8f/SVcOIzZ+B7tGde48J7gGf9xsnoER1oN?=
 =?iso-8859-1?Q?N4jkGYz4bx6KrX9Jlq73ZkIgRWZ8j2w8OuN5spr0NiXzlWc7PrDROJddxm?=
 =?iso-8859-1?Q?v0+Ui5tOvUFzjLj2mS6zPv2yndE3bnzHMDbRTFMnRtQXdDgj6Vts6okB/Q?=
 =?iso-8859-1?Q?J/5XO7RGLG70QHGa9LGsQXFq0710vgye/95FzhSzWWPrNrrTakr03iJKOy?=
 =?iso-8859-1?Q?fDjz02Wf53nXN1j1qO9RrAAmgPIK/02FFObdoR+PdGlvRvE6jDoO05JNYn?=
 =?iso-8859-1?Q?2kztl4XjvvV4xH1FTjtAaK+2mXfXzdfHKGpexXUGaS1uJLofRLcllZ+4Cz?=
 =?iso-8859-1?Q?MnbCWttXwsgQxPRoJpFupG3BjXNGu5PZM0vSvSDdDiyB0GEEBowJ7aVABx?=
 =?iso-8859-1?Q?0eH6DWp61Y8yccY5dTZC9RpZZ15qx8CQJ6pg2m5ULhNeO5gAa0XkryqXxe?=
 =?iso-8859-1?Q?3xbMZMFjmXdojN4X2ZjePnhbjRpBjLOy9vxKQPlx+DvCCg5sarTAeEdSSw?=
 =?iso-8859-1?Q?lx7XdJVOd5r/AmGdO/PCuVQGLBkzdW3V89Q8GrrEN+rFIclHcPb2G+hErU?=
 =?iso-8859-1?Q?Urms1UWzyTMAZ4dB7oHEVDJa1hQ+KadTTEDmgxaxJC7EkTUVsyyUM9i3rK?=
 =?iso-8859-1?Q?SsRzIIuaIA1DsJmuyWZP1rD0Hqy1fVVFBKrAuXcyKNw8TbwtqF34GELzMg?=
 =?iso-8859-1?Q?XxgsDKo9HueAPpOzMD2owqutlH70ydyg2ivlLaysv42dCF2PDDbs5iiLK7?=
 =?iso-8859-1?Q?TG2b+3QPorpPBQh/YBuyVUL/61fmRFcDJuiNCCiMkVa12nQJpnkg4g5CQP?=
 =?iso-8859-1?Q?K3omnHuLv9eRNu/nrVPBPCDG+Dlvu9CKJofSL3dprNMS6kn285iMqDsPSu?=
 =?iso-8859-1?Q?6JpsQT8YcQO9WArxRJ8I5D5gEsZWhhGeqwOH2+OGXtO/oysNfXb50zioUk?=
 =?iso-8859-1?Q?fnwRZBcdXzq6HAGnReqPOgmZLFvqEejwCZJwjtGL1r0XE/nuFwvKPkFavC?=
 =?iso-8859-1?Q?Tt84LFvHuXvFkbRVILitdxrKp6n78h/x0Jaw/FRfgLAtac0v0pGUFfTKe/?=
 =?iso-8859-1?Q?Yf2jc0m0mMbdWljOEEap2zctB2MphDHAkrUz14a3JExgcdMU+jKSzru5Vf?=
 =?iso-8859-1?Q?PdZY8U01y6aZXdmJb0GnJGZHhS/e0Ic1JvSNrpAS7Q14WrGTUtyHbSEWiS?=
 =?iso-8859-1?Q?wL+f6u4SqCEL7x3hrkITyPY3EwLSfflzTHM25xBvLKukrmXGPcgmDfLc3s?=
 =?iso-8859-1?Q?F/fXD+qG2MCB8ghjKBKxb/wXDu6cCJznlSvaB6GhzZtAFHge4F9QSicgqU?=
 =?iso-8859-1?Q?0c/kwy7HVkdsWeg/+cy3Hi4X6FXJMV10zyQlu0h6QtzuYxAXI1GQC6gRCB?=
 =?iso-8859-1?Q?pItRnOK1qhoC/bfhXFiLuhbU2wdWGt3hGBTY0UxgVqmc+6TZhjA3J0bM7j?=
 =?iso-8859-1?Q?Cje2GS2GowuvKgPja6ToKbxed4w94KiEF4q8B9ntltOzwiMfZQAoZVTQP8?=
 =?iso-8859-1?Q?1uyWXNY/9MaXcVmTL5jEsF7BBHMy57gTNd303nHAlFjwQdDgdvAw1SJIFi?=
 =?iso-8859-1?Q?JYAEDIB+xTDl/CGMSPe0UHtm/z3qprt2iXyQ+zSrkolntPohOoUDGFWLo2?=
 =?iso-8859-1?Q?seD32CBhr6XjNzFgJju5OTaATypROQIWg1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dc2a39-3d76-4c24-f072-08dc4a157da0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 02:12:15.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcCAQ/NtVqrgsV0IRuwaeoyciG/9YKg+cqdWAiF3lhbx44s4vc8mD295XNsPlkzTbkxlRrZYoTGURKuRzbL+4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -43.6% regression of vm-scalability.throughput on:


commit: 09f84589a8ed1162c0274a1b5b3dadb98ee3155e ("[PATCH v2 3/3] ACPI/NUMA: Remove architecture dependent remainings")
url: https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/x86-numa-Fix-SRAT-lookup-of-CFMWS-ranges-with-numa_fill_memblks/20240319-200345
base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
patch link: https://lore.kernel.org/all/20240319120026.2246389-4-rrichter@amd.com/
patch subject: [PATCH v2 3/3] ACPI/NUMA: Remove architecture dependent remainings

testcase: vm-scalability
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	size: 512G
	test: anon-cow-rand-hugetlb
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.npb.SP.B.total_mop_s -58.1% regression               |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                  |
|                  | option_a=SP.B [Scalar Penta-diagonal solver]                                                  |
|                  | test=npb-1.4.5                                                                                |
+------------------+-----------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -38.1% regression                                |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                              |
| test parameters  | cpufreq_governor=performance                                                                  |
|                  | mode=process                                                                                  |
|                  | nr_task=100%                                                                                  |
|                  | test=mmap1                                                                                    |
+------------------+-----------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.asmfish.0.nodes_second -23.9% regression             |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                  |
|                  | test=asmfish-1.1.2                                                                            |
+------------------+-----------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240322/202403220943.96dde419-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/512G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability

commit: 
  9ef3ad0f03 ("ACPI/NUMA: Print CXL Early Discovery Table (CEDT)")
  09f84589a8 ("ACPI/NUMA: Remove architecture dependent remainings")

9ef3ad0f032818c5 09f84589a8ed1162c0274a1b5b3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.277e+09 ±  6%     -70.5%  1.261e+09 ±  6%  cpuidle..time
    735569 ±  2%     -34.8%     479905 ±  3%  cpuidle..usage
    243.64 ±  2%     -24.9%     182.92        uptime.boot
      9961 ±  4%     -29.0%       7073 ±  4%  uptime.idle
     16.94 ±  3%      -9.9        7.06 ±  8%  mpstat.cpu.all.idle%
      0.35            -0.1        0.29        mpstat.cpu.all.irq%
      0.03 ±  3%      -0.0        0.02        mpstat.cpu.all.soft%
     12.05            -2.1       10.00        mpstat.cpu.all.sys%
     70.63           +12.0       82.63        mpstat.cpu.all.usr%
     17.78 ±  3%     -52.2%       8.49 ±  6%  vmstat.cpu.id
     70.01           +16.5%      81.54        vmstat.cpu.us
    107.54           +10.6%     118.93        vmstat.procs.r
      2652 ±  2%      -8.9%       2417 ±  5%  vmstat.system.cs
    141617 ±  3%     -13.4%     122650        vmstat.system.in
    573464 ±  8%    -100.0%       0.00        numa-numastat.node0.local_node
    632802 ±  4%    -100.0%       0.00        numa-numastat.node0.numa_hit
     59338 ± 51%    -100.0%       0.00        numa-numastat.node0.other_node
    677948 ±  7%    -100.0%       0.00        numa-numastat.node1.local_node
    751205 ±  4%    -100.0%       0.00        numa-numastat.node1.numa_hit
     73258 ± 41%    -100.0%       0.00        numa-numastat.node1.other_node
     95544 ± 27%     -59.6%      38591 ±  5%  meminfo.Active
     95399 ± 27%     -59.7%      38433 ±  5%  meminfo.Active(anon)
  10487673 ±  7%     -28.6%    7487857 ±  6%  meminfo.DirectMap2M
     43001           +14.2%      49088        meminfo.HugePages_Surp
     43001           +14.2%      49088        meminfo.HugePages_Total
  88066074           +14.2%  1.005e+08        meminfo.Hugetlb
 1.356e+08            -9.5%  1.228e+08        meminfo.MemAvailable
 1.366e+08            -9.1%  1.241e+08        meminfo.MemFree
  94133967           +13.0%  1.064e+08        meminfo.Memused
    241580 ±  8%     -26.3%     178118        meminfo.Shmem
    267728           -81.4%      49921        meminfo.VmallocUsed
     51764 ±  2%     -37.7%      32258        vm-scalability.median
      6.46 ± 19%      -5.3        1.21 ± 20%  vm-scalability.median_stddev%
      2.86 ± 18%      -2.7        0.11 ± 31%  vm-scalability.stddev%
   7315147           -43.6%    4122657        vm-scalability.throughput
    193.69 ±  2%     -32.1%     131.50        vm-scalability.time.elapsed_time
    193.69 ±  2%     -32.1%     131.50        vm-scalability.time.elapsed_time.max
    138604 ±  4%     -21.6%     108601 ±  7%  vm-scalability.time.involuntary_context_switches
    578101           -55.9%     254781        vm-scalability.time.minor_page_faults
     10610           +12.8%      11965        vm-scalability.time.percent_of_cpu_this_job_got
      2981 ±  3%     -43.3%       1691        vm-scalability.time.system_time
     17565           -20.0%      14044        vm-scalability.time.user_time
     15370 ±  4%     -51.6%       7439 ±  5%  vm-scalability.time.voluntary_context_switches
 1.159e+09           -55.6%  5.146e+08        vm-scalability.workload
    495078 ± 11%     -71.4%     141719 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.28 ± 21%     -33.3%       0.19 ± 21%  sched_debug.cfs_rq:/.h_nr_running.stddev
      2570 ± 80%    +109.3%       5381        sched_debug.cfs_rq:/.load.min
      2.76 ± 52%     +68.8%       4.67        sched_debug.cfs_rq:/.load_avg.min
    495078 ± 11%     -71.4%     141719 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.23 ± 31%     -53.6%       0.11 ± 15%  sched_debug.cfs_rq:/.nr_running.stddev
    242.06 ± 32%     -50.0%     121.10 ±  9%  sched_debug.cfs_rq:/.runnable_avg.stddev
    235.93 ± 81%    +137.9%     561.33 ± 19%  sched_debug.cfs_rq:/.util_avg.min
    226.75 ± 31%     -52.3%     108.21 ± 13%  sched_debug.cfs_rq:/.util_avg.stddev
    192.74 ± 41%     -73.6%      50.87 ± 50%  sched_debug.cfs_rq:/.util_est.stddev
    370662 ± 45%     +53.6%     569380 ±  2%  sched_debug.cpu.avg_idle.min
      4569 ± 11%     -23.5%       3494        sched_debug.cpu.curr->pid.avg
      6312 ±  6%     -26.8%       4619        sched_debug.cpu.curr->pid.max
     37956 ± 30%     -50.9%      18650 ± 70%  sched_debug.cpu.max_idle_balance_cost.stddev
      2949 ±  7%     -22.4%       2287 ±  3%  sched_debug.cpu.nr_switches.avg
    821.53 ± 12%     -31.9%     559.11 ±  6%  sched_debug.cpu.nr_switches.min
      0.25 ±101%     -99.8%       0.00 ± 92%  sched_debug.rt_rq:.rt_time.avg
     32.43 ±101%     -99.8%       0.06 ± 92%  sched_debug.rt_rq:.rt_time.max
      2.85 ±101%     -99.8%       0.01 ± 92%  sched_debug.rt_rq:.rt_time.stddev
    507357           -55.6%     225492        proc-vmstat.htlb_buddy_alloc_success
     23772 ± 27%     -59.2%       9703 ±  5%  proc-vmstat.nr_active_anon
   3376161            -9.1%    3070574        proc-vmstat.nr_dirty_background_threshold
   6760578            -9.1%    6148657        proc-vmstat.nr_dirty_threshold
    823112            -1.9%     807289        proc-vmstat.nr_file_pages
  34080722            -8.7%   31109176        proc-vmstat.nr_free_pages
     25608            +3.2%      26432        proc-vmstat.nr_kernel_stack
      2710            +3.5%       2804        proc-vmstat.nr_page_table_pages
     60299 ±  8%     -26.2%      44490        proc-vmstat.nr_shmem
     28254            -1.1%      27945        proc-vmstat.nr_slab_reclaimable
     66139            -1.8%      64958        proc-vmstat.nr_slab_unreclaimable
     23772 ± 27%     -59.2%       9703 ±  5%  proc-vmstat.nr_zone_active_anon
     33857 ± 16%    -100.0%       0.00        proc-vmstat.numa_hint_faults
     12661 ± 72%    -100.0%       0.00        proc-vmstat.numa_hint_faults_local
   1386858           -43.2%     787481        proc-vmstat.numa_hit
   1254263           -37.2%     787477        proc-vmstat.numa_local
    132597          -100.0%       0.00        proc-vmstat.numa_other
     41301 ± 42%    -100.0%       0.00        proc-vmstat.numa_pages_migrated
    183630 ± 19%    -100.0%       0.00        proc-vmstat.numa_pte_updates
 2.608e+08           -55.5%  1.161e+08        proc-vmstat.pgalloc_normal
   1247964           -55.1%     559863        proc-vmstat.pgfault
 2.597e+08           -55.4%  1.159e+08        proc-vmstat.pgfree
     41301 ± 42%    -100.0%       0.00        proc-vmstat.pgmigrate_success
     35726 ±  6%     -55.9%      15762 ±  3%  proc-vmstat.pgreuse
     15.99           -14.2%      13.72        perf-stat.i.MPKI
 1.556e+10 ±  3%     -34.0%  1.027e+10        perf-stat.i.branch-instructions
      0.10 ±  4%      +0.1        0.18 ±  4%  perf-stat.i.branch-miss-rate%
  11581986 ±  3%     +29.1%   14946939        perf-stat.i.branch-misses
 8.579e+08 ±  2%     -36.0%  5.495e+08        perf-stat.i.cache-misses
 8.808e+08 ±  2%     -35.7%  5.662e+08        perf-stat.i.cache-references
      2591 ±  2%     -12.0%       2281 ±  4%  perf-stat.i.context-switches
      4.97           +47.0%       7.31        perf-stat.i.cpi
 2.814e+11           +11.0%  3.122e+11        perf-stat.i.cpu-cycles
    218.48           -11.0%     194.53        perf-stat.i.cpu-migrations
    337.74           +73.1%     584.61        perf-stat.i.cycles-between-cache-misses
 6.664e+10 ±  3%     -33.9%  4.408e+10        perf-stat.i.instructions
      0.25           -36.7%       0.16        perf-stat.i.ipc
      2.00 ± 12%     -47.4%       1.05 ± 16%  perf-stat.i.major-faults
      6085           -37.6%       3798        perf-stat.i.minor-faults
      6087           -37.6%       3799        perf-stat.i.page-faults
     12.96            -3.2%      12.55        perf-stat.overall.MPKI
      0.07            +0.1        0.15        perf-stat.overall.branch-miss-rate%
      4.25           +67.1%       7.10        perf-stat.overall.cpi
    327.67           +72.6%     565.42        perf-stat.overall.cycles-between-cache-misses
      0.24           -40.2%       0.14        perf-stat.overall.ipc
     10931            +3.1%      11273        perf-stat.overall.path-length
 1.518e+10 ±  2%     -33.1%  1.015e+10        perf-stat.ps.branch-instructions
  10985194 ±  2%     +35.0%   14830464        perf-stat.ps.branch-misses
 8.425e+08 ±  2%     -35.1%  5.466e+08        perf-stat.ps.cache-misses
 8.655e+08 ±  2%     -34.9%  5.635e+08        perf-stat.ps.cache-references
      2574           -11.3%       2282 ±  4%  perf-stat.ps.context-switches
 2.759e+11           +12.0%   3.09e+11        perf-stat.ps.cpu-cycles
    215.11 ±  2%      -9.9%     193.81        perf-stat.ps.cpu-migrations
 6.501e+10 ±  2%     -33.0%  4.355e+10        perf-stat.ps.instructions
      2.04 ± 11%     -47.9%       1.06 ± 16%  perf-stat.ps.major-faults
      6066           -36.8%       3832        perf-stat.ps.minor-faults
      6068           -36.8%       3833        perf-stat.ps.page-faults
 1.267e+13           -54.2%  5.802e+12        perf-stat.total.instructions
    792.04 ± 23%    -100.0%       0.00        numa-vmstat.node0.nr_active_anon
     48328 ± 63%    -100.0%       0.00        numa-vmstat.node0.nr_anon_pages
    229536 ± 90%    -100.0%       0.00        numa-vmstat.node0.nr_file_pages
  23714921 ±  2%    -100.0%       0.00        numa-vmstat.node0.nr_free_pages
     53088 ± 73%    -100.0%       0.00        numa-vmstat.node0.nr_inactive_anon
     12744 ±  7%    -100.0%       0.00        numa-vmstat.node0.nr_kernel_stack
      5388 ± 45%    -100.0%       0.00        numa-vmstat.node0.nr_mapped
    890.81 ± 13%    -100.0%       0.00        numa-vmstat.node0.nr_page_table_pages
      6425 ±158%    -100.0%       0.00        numa-vmstat.node0.nr_shmem
     10347 ± 33%    -100.0%       0.00        numa-vmstat.node0.nr_slab_reclaimable
     32990 ± 10%    -100.0%       0.00        numa-vmstat.node0.nr_slab_unreclaimable
    223791 ± 90%    -100.0%       0.00        numa-vmstat.node0.nr_unevictable
    792.05 ± 23%    -100.0%       0.00        numa-vmstat.node0.nr_zone_active_anon
     53088 ± 73%    -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_anon
    223791 ± 90%    -100.0%       0.00        numa-vmstat.node0.nr_zone_unevictable
    633548 ±  4%    -100.0%       0.00        numa-vmstat.node0.numa_hit
    574210 ±  8%    -100.0%       0.00        numa-vmstat.node0.numa_local
     59338 ± 51%    -100.0%       0.00        numa-vmstat.node0.numa_other
     23125 ± 27%    -100.0%       0.00        numa-vmstat.node1.nr_active_anon
    115486 ± 26%    -100.0%       0.00        numa-vmstat.node1.nr_anon_pages
    593673 ± 34%    -100.0%       0.00        numa-vmstat.node1.nr_file_pages
  10376888 ±  3%    -100.0%       0.00        numa-vmstat.node1.nr_free_pages
    146240 ± 26%    -100.0%       0.00        numa-vmstat.node1.nr_inactive_anon
     12863 ±  6%    -100.0%       0.00        numa-vmstat.node1.nr_kernel_stack
     13956 ±  5%    -100.0%       0.00        numa-vmstat.node1.nr_mapped
      1818 ±  6%    -100.0%       0.00        numa-vmstat.node1.nr_page_table_pages
     53973 ± 15%    -100.0%       0.00        numa-vmstat.node1.nr_shmem
     17907 ± 19%    -100.0%       0.00        numa-vmstat.node1.nr_slab_reclaimable
     33150 ± 10%    -100.0%       0.00        numa-vmstat.node1.nr_slab_unreclaimable
    539462 ± 37%    -100.0%       0.00        numa-vmstat.node1.nr_unevictable
     23125 ± 27%    -100.0%       0.00        numa-vmstat.node1.nr_zone_active_anon
    146241 ± 26%    -100.0%       0.00        numa-vmstat.node1.nr_zone_inactive_anon
    539462 ± 37%    -100.0%       0.00        numa-vmstat.node1.nr_zone_unevictable
    750435 ±  4%    -100.0%       0.00        numa-vmstat.node1.numa_hit
    677178 ±  7%    -100.0%       0.00        numa-vmstat.node1.numa_local
     73258 ± 41%    -100.0%       0.00        numa-vmstat.node1.numa_other
      3216 ± 24%    -100.0%       0.00        numa-meminfo.node0.Active
      3165 ± 23%    -100.0%       0.00        numa-meminfo.node0.Active(anon)
    193141 ± 63%    -100.0%       0.00        numa-meminfo.node0.AnonPages
    245306 ± 55%    -100.0%       0.00        numa-meminfo.node0.AnonPages.max
    918145 ± 90%    -100.0%       0.00        numa-meminfo.node0.FilePages
     16988 ±  6%    -100.0%       0.00        numa-meminfo.node0.HugePages_Surp
     16988 ±  6%    -100.0%       0.00        numa-meminfo.node0.HugePages_Total
    212488 ± 73%    -100.0%       0.00        numa-meminfo.node0.Inactive
    212188 ± 73%    -100.0%       0.00        numa-meminfo.node0.Inactive(anon)
     41389 ± 33%    -100.0%       0.00        numa-meminfo.node0.KReclaimable
     12743 ±  7%    -100.0%       0.00        numa-meminfo.node0.KernelStack
     21242 ± 45%    -100.0%       0.00        numa-meminfo.node0.Mapped
  94746960 ±  2%    -100.0%       0.00        numa-meminfo.node0.MemFree
 1.317e+08          -100.0%       0.00        numa-meminfo.node0.MemTotal
  36938247 ±  5%    -100.0%       0.00        numa-meminfo.node0.MemUsed
      3559 ± 13%    -100.0%       0.00        numa-meminfo.node0.PageTables
     41389 ± 33%    -100.0%       0.00        numa-meminfo.node0.SReclaimable
    131966 ± 10%    -100.0%       0.00        numa-meminfo.node0.SUnreclaim
     25702 ±158%    -100.0%       0.00        numa-meminfo.node0.Shmem
    173356 ± 15%    -100.0%       0.00        numa-meminfo.node0.Slab
    895165 ± 90%    -100.0%       0.00        numa-meminfo.node0.Unevictable
     92044 ± 27%    -100.0%       0.00        numa-meminfo.node1.Active
     91950 ± 27%    -100.0%       0.00        numa-meminfo.node1.Active(anon)
     94963 ± 57%    -100.0%       0.00        numa-meminfo.node1.AnonHugePages
    462070 ± 26%    -100.0%       0.00        numa-meminfo.node1.AnonPages
    521211 ± 21%    -100.0%       0.00        numa-meminfo.node1.AnonPages.max
   2374512 ± 34%    -100.0%       0.00        numa-meminfo.node1.FilePages
     26160 ±  3%    -100.0%       0.00        numa-meminfo.node1.HugePages_Surp
     26160 ±  3%    -100.0%       0.00        numa-meminfo.node1.HugePages_Total
    586305 ± 26%    -100.0%       0.00        numa-meminfo.node1.Inactive
    585444 ± 26%    -100.0%       0.00        numa-meminfo.node1.Inactive(anon)
     71636 ± 19%    -100.0%       0.00        numa-meminfo.node1.KReclaimable
     12870 ±  6%    -100.0%       0.00        numa-meminfo.node1.KernelStack
     55637 ±  5%    -100.0%       0.00        numa-meminfo.node1.Mapped
  41532114 ±  3%    -100.0%       0.00        numa-meminfo.node1.MemFree
  99030534          -100.0%       0.00        numa-meminfo.node1.MemTotal
  57498419 ±  2%    -100.0%       0.00        numa-meminfo.node1.MemUsed
      7297 ±  6%    -100.0%       0.00        numa-meminfo.node1.PageTables
     71636 ± 19%    -100.0%       0.00        numa-meminfo.node1.SReclaimable
    132602 ± 10%    -100.0%       0.00        numa-meminfo.node1.SUnreclaim
    215707 ± 15%    -100.0%       0.00        numa-meminfo.node1.Shmem
    204238 ± 12%    -100.0%       0.00        numa-meminfo.node1.Slab
   2157849 ± 37%    -100.0%       0.00        numa-meminfo.node1.Unevictable
     56.43 ± 18%     -56.4        0.00        perf-profile.calltrace.cycles-pp.do_rw_once
     40.90 ± 15%     -40.9        0.00        perf-profile.calltrace.cycles-pp.lrand48_r@plt
     19.35 ± 72%     -19.4        0.00        perf-profile.calltrace.cycles-pp.do_access
     17.15 ± 84%     -17.2        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     17.12 ± 84%     -17.1        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     17.12 ± 84%     -17.1        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     17.10 ± 84%     -17.1        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     17.09 ± 84%     -17.1        0.00        perf-profile.calltrace.cycles-pp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     13.57 ± 84%     -13.6        0.00        perf-profile.calltrace.cycles-pp.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     13.30 ± 84%     -13.3        0.00        perf-profile.calltrace.cycles-pp.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault
     13.28 ± 84%     -13.3        0.00        perf-profile.calltrace.cycles-pp.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
     13.16 ± 84%     -13.2        0.00        perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault
      0.00            +2.1        2.06 ±  9%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
      0.00            +2.1        2.06 ±  9%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00            +2.1        2.06 ±  9%  perf-profile.calltrace.cycles-pp.put_files_struct.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00            +3.3        3.35 ± 39%  perf-profile.calltrace.cycles-pp.common_startup_64
      0.00            +3.8        3.83 ± 43%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.8        3.83 ± 43%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.3        4.32 ± 43%  perf-profile.calltrace.cycles-pp.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release.__fput
      0.00            +4.4        4.37 ± 49%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.4        4.37 ± 49%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.4        4.37 ± 49%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.6        4.63 ± 41%  perf-profile.calltrace.cycles-pp._free_event.perf_event_release_kernel.perf_release.__fput.task_work_run
      0.00            +5.2        5.19 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn
      0.00            +5.2        5.19 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.writen.record__pushfn.perf_mmap__push
      0.00            +5.2        5.19 ± 25%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.00            +5.2        5.19 ± 25%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.writen
      0.00            +5.2        5.19 ± 25%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.00            +5.2        5.19 ± 25%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +5.2        5.19 ± 25%  perf-profile.calltrace.cycles-pp.write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      0.00            +5.2        5.19 ± 25%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.00            +5.4        5.38 ± 34%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.00            +5.5        5.50 ± 28%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +6.2        6.18 ±  9%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      0.00            +6.2        6.18 ±  9%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.main
      0.00            +6.3        6.34 ± 50%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +6.3        6.34 ± 50%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.00            +6.8        6.82 ± 41%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +6.9        6.94 ± 23%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main
      0.00            +6.9        6.94 ± 23%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main
      0.00            +8.6        8.58 ± 19%  perf-profile.calltrace.cycles-pp.main
      0.00            +8.6        8.58 ± 19%  perf-profile.calltrace.cycles-pp.run_builtin.main
      0.00           +11.4       11.42 ± 30%  perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.show_interrupts.seq_read_iter.proc_reg_read_iter
      0.00           +12.2       12.18 ± 26%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
      0.00           +12.5       12.53 ± 26%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
      0.00           +12.7       12.71 ± 17%  perf-profile.calltrace.cycles-pp.seq_printf.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read
      0.00           +17.2       17.20 ± 17%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +17.2       17.20 ± 17%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00           +17.2       17.20 ± 17%  perf-profile.calltrace.cycles-pp.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      0.00           +17.8       17.82 ±  9%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      0.00           +17.8       17.82 ±  9%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
      0.00           +21.6       21.56 ±  7%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
      0.00           +22.6       22.64 ±  9%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00           +24.2       24.16 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00           +24.2       24.16 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.00           +24.2       24.16 ± 13%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00           +24.2       24.16 ± 13%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00           +25.2       25.18 ± 17%  perf-profile.calltrace.cycles-pp.read
      0.00           +26.8       26.76 ±  9%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +26.8       26.76 ±  9%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      0.00           +26.8       26.76 ±  9%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      0.00           +26.8       26.76 ±  9%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +27.4       27.39 ±  8%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +41.1       41.08 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +41.1       41.08 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     77.16 ± 17%     -77.2        0.00        perf-profile.children.cycles-pp.do_rw_once
     21.07 ± 14%     -21.1        0.00        perf-profile.children.cycles-pp.lrand48_r@plt
     19.67 ± 71%     -19.7        0.00        perf-profile.children.cycles-pp.do_access
     17.09 ± 84%     -17.1        0.00        perf-profile.children.cycles-pp.hugetlb_fault
     13.57 ± 84%     -13.6        0.00        perf-profile.children.cycles-pp.hugetlb_wp
     13.30 ± 84%     -13.3        0.00        perf-profile.children.cycles-pp.copy_user_large_folio
     13.28 ± 84%     -13.3        0.00        perf-profile.children.cycles-pp.copy_subpage
     13.27 ± 84%     -12.9        0.38 ±223%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.00            +2.1        2.06 ±  9%  perf-profile.children.cycles-pp.put_files_struct
      0.02 ±142%      +3.3        3.35 ± 39%  perf-profile.children.cycles-pp.common_startup_64
      0.02 ±142%      +3.3        3.35 ± 39%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.02 ±142%      +3.3        3.35 ± 39%  perf-profile.children.cycles-pp.do_idle
      0.00            +3.8        3.77 ± 51%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +4.3        4.32 ± 43%  perf-profile.children.cycles-pp.sw_perf_event_destroy
      0.01 ±223%      +4.4        4.37 ± 49%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +4.4        4.41 ± 39%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +4.6        4.63 ± 41%  perf-profile.children.cycles-pp._free_event
      0.06 ± 85%      +5.1        5.19 ± 25%  perf-profile.children.cycles-pp.record__pushfn
      0.06 ± 85%      +5.1        5.19 ± 25%  perf-profile.children.cycles-pp.writen
      0.04 ±108%      +5.2        5.19 ± 25%  perf-profile.children.cycles-pp.generic_perform_write
      0.04 ±108%      +5.2        5.19 ± 25%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.01 ±223%      +5.4        5.38 ± 34%  perf-profile.children.cycles-pp.__mmput
      0.01 ±223%      +5.4        5.38 ± 34%  perf-profile.children.cycles-pp.exit_mm
      0.01 ±223%      +5.4        5.38 ± 34%  perf-profile.children.cycles-pp.exit_mmap
      0.08 ± 98%      +5.4        5.50 ± 28%  perf-profile.children.cycles-pp.write
      0.08 ±100%      +5.4        5.50 ± 28%  perf-profile.children.cycles-pp.ksys_write
      0.08 ± 99%      +5.4        5.50 ± 28%  perf-profile.children.cycles-pp.vfs_write
      0.07 ± 86%      +6.1        6.18 ±  9%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.06 ± 85%      +6.1        6.18 ±  9%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +6.3        6.34 ± 50%  perf-profile.children.cycles-pp.do_filp_open
      0.00            +6.3        6.34 ± 50%  perf-profile.children.cycles-pp.path_openat
      0.00            +6.5        6.50 ± 40%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +7.0        7.04 ± 54%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +7.0        7.04 ± 54%  perf-profile.children.cycles-pp.do_sys_openat2
      0.08 ± 82%      +8.5        8.58 ± 19%  perf-profile.children.cycles-pp.main
      0.08 ± 82%      +8.5        8.58 ± 19%  perf-profile.children.cycles-pp.run_builtin
      0.08 ± 85%      +8.5        8.58 ± 19%  perf-profile.children.cycles-pp.__cmd_record
      0.08 ± 85%      +8.5        8.58 ± 19%  perf-profile.children.cycles-pp.cmd_record
      0.00           +11.7       11.74 ± 30%  perf-profile.children.cycles-pp.vsnprintf
      0.00           +12.7       12.71 ± 17%  perf-profile.children.cycles-pp.seq_printf
      0.00           +13.8       13.81 ± 19%  perf-profile.children.cycles-pp.smp_call_function_single
      0.00           +14.2       14.17 ± 18%  perf-profile.children.cycles-pp.event_function_call
      0.00           +17.2       17.20 ± 17%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.00           +17.2       17.20 ± 17%  perf-profile.children.cycles-pp.show_interrupts
      0.00           +17.8       17.82 ±  9%  perf-profile.children.cycles-pp.perf_event_release_kernel
      0.00           +17.8       17.82 ±  9%  perf-profile.children.cycles-pp.perf_release
      0.00           +22.3       22.30 ± 11%  perf-profile.children.cycles-pp.__fput
      0.02 ±142%     +22.9       22.96 ±  8%  perf-profile.children.cycles-pp.task_work_run
      0.00           +23.2       23.22 ± 10%  perf-profile.children.cycles-pp.seq_read_iter
      0.00           +24.5       24.47 ± 13%  perf-profile.children.cycles-pp.ksys_read
      0.00           +24.5       24.47 ± 13%  perf-profile.children.cycles-pp.vfs_read
      0.00           +25.2       25.18 ± 13%  perf-profile.children.cycles-pp.read
      0.00           +26.8       26.76 ±  9%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.00           +26.8       26.76 ±  9%  perf-profile.children.cycles-pp.get_signal
      0.00           +27.1       27.08 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.01 ±223%     +31.1       31.13 ±  8%  perf-profile.children.cycles-pp.do_exit
      0.01 ±223%     +31.1       31.13 ±  8%  perf-profile.children.cycles-pp.do_group_exit
      0.18 ± 66%     +85.5       85.67        perf-profile.children.cycles-pp.do_syscall_64
      0.18 ± 66%     +85.8       86.02        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     76.28 ± 17%     -76.3        0.00        perf-profile.self.cycles-pp.do_rw_once
     13.17 ± 84%     -12.8        0.38 ±223%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.00            +3.7        3.73 ± 53%  perf-profile.self.cycles-pp.show_interrupts
      0.00           +10.8       10.84 ± 40%  perf-profile.self.cycles-pp.smp_call_function_single


***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/SP.B [Scalar Penta-diagonal solver]/debian-12-x86_64-phoronix/lkp-csl-2sp7/npb-1.4.5/phoronix-test-suite

commit: 
  9ef3ad0f03 ("ACPI/NUMA: Print CXL Early Discovery Table (CEDT)")
  09f84589a8 ("ACPI/NUMA: Remove architecture dependent remainings")

9ef3ad0f032818c5 09f84589a8ed1162c0274a1b5b3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     14.98            +1.9%      15.26        boot-time.dhcp
 6.328e+09           +62.7%   1.03e+10        cpuidle..time
   6773424           +61.9%   10963809        cpuidle..usage
    136.23           +50.7%     205.27        uptime.boot
     10617           +38.0%      14647        uptime.idle
    231376           +16.8%     270293        meminfo.Active
     74278           +37.5%     102161        meminfo.Active(anon)
    276857 ±  6%     +31.8%     364759 ±  3%  meminfo.AnonHugePages
  11829930 ±  3%     -38.6%    7260501 ± 11%  meminfo.DirectMap2M
    261359           -83.6%      42734        meminfo.VmallocUsed
      0.15            -0.1        0.08 ±  2%  mpstat.cpu.all.iowait%
      1.82            +0.8        2.62        mpstat.cpu.all.irq%
      0.09            +0.1        0.14        mpstat.cpu.all.soft%
      0.89            +0.3        1.14        mpstat.cpu.all.sys%
     20.41            +5.9       26.33        mpstat.cpu.all.usr%
    523084 ± 23%    -100.0%       0.00        numa-numastat.node0.local_node
    577073 ± 19%    -100.0%       0.00        numa-numastat.node0.numa_hit
     53991 ± 50%    -100.0%       0.00        numa-numastat.node0.other_node
    560471 ± 22%    -100.0%       0.00        numa-numastat.node1.local_node
    606158 ± 18%    -100.0%       0.00        numa-numastat.node1.numa_hit
     45685 ± 60%    -100.0%       0.00        numa-numastat.node1.other_node
     76.91            -8.8%      70.16        vmstat.cpu.id
     19.78           +31.9%      26.08        vmstat.cpu.us
      3610           -43.7%       2032        vmstat.io.bi
      0.29 ± 48%     -65.8%       0.10 ±  6%  vmstat.procs.b
     21.91           +29.1%      28.29        vmstat.procs.r
      6078 ±  4%     -27.6%       4398 ±  3%  vmstat.system.cs
     22219           -58.1%       9301        phoronix-test-suite.npb.SP.B.total_mop_s
     84.27           +79.7%     151.42        phoronix-test-suite.time.elapsed_time
     84.27           +79.7%     151.42        phoronix-test-suite.time.elapsed_time.max
      9092           +61.6%      14688        phoronix-test-suite.time.involuntary_context_switches
   1556010           -61.5%     598472        phoronix-test-suite.time.minor_page_faults
      2019           +30.6%       2637        phoronix-test-suite.time.percent_of_cpu_this_job_got
     64.18          +140.5%     154.34        phoronix-test-suite.time.system_time
      1637          +134.4%       3839        phoronix-test-suite.time.user_time
     18650           +37.3%      25601        proc-vmstat.nr_active_anon
     39298            +6.9%      42026        proc-vmstat.nr_active_file
    296059            +7.8%     319032        proc-vmstat.nr_anon_pages
    644447            +1.9%     657001        proc-vmstat.nr_file_pages
   7113787           +17.7%    8370599        proc-vmstat.nr_foll_pin_acquired
   7113780           +17.7%    8370587        proc-vmstat.nr_foll_pin_released
    468080            +4.9%     490832        proc-vmstat.nr_inactive_anon
     21467            +1.3%      21743        proc-vmstat.nr_kernel_stack
     40569            +3.0%      41805        proc-vmstat.nr_mapped
      3552            +6.1%       3767        proc-vmstat.nr_page_table_pages
    190633            +3.4%     197135        proc-vmstat.nr_shmem
     21713            +2.3%      22201        proc-vmstat.nr_slab_reclaimable
     18650           +37.3%      25601        proc-vmstat.nr_zone_active_anon
     39298            +6.9%      42026        proc-vmstat.nr_zone_active_file
    468080            +4.9%     490832        proc-vmstat.nr_zone_inactive_anon
    978315          -100.0%       0.00        proc-vmstat.numa_hint_faults
    976417          -100.0%       0.00        proc-vmstat.numa_hint_faults_local
   1184528            -1.1%    1171481        proc-vmstat.numa_hit
      1319          -100.0%       0.00        proc-vmstat.numa_huge_pte_updates
   1084853            +8.0%    1171481        proc-vmstat.numa_local
     99677          -100.0%       0.00        proc-vmstat.numa_other
      3465 ± 63%    -100.0%       0.00        proc-vmstat.numa_pages_migrated
   1700329          -100.0%       0.00        proc-vmstat.numa_pte_updates
     71755            +5.5%      75670        proc-vmstat.pgactivate
   1444406            +0.9%    1458081        proc-vmstat.pgalloc_normal
   2020069           -49.4%    1022408        proc-vmstat.pgfault
   1268206            +3.8%    1316886        proc-vmstat.pgfree
      3465 ± 63%    -100.0%       0.00        proc-vmstat.pgmigrate_success
    100000 ± 47%    -100.0%       0.00        numa-meminfo.node0.Active
     13486 ± 48%    -100.0%       0.00        numa-meminfo.node0.Active(anon)
     86514 ± 49%    -100.0%       0.00        numa-meminfo.node0.Active(file)
    143140 ± 29%    -100.0%       0.00        numa-meminfo.node0.AnonHugePages
    554668 ± 43%    -100.0%       0.00        numa-meminfo.node0.AnonPages
    720916 ± 33%    -100.0%       0.00        numa-meminfo.node0.AnonPages.max
   1320009 ± 59%    -100.0%       0.00        numa-meminfo.node0.FilePages
   1773835 ± 32%    -100.0%       0.00        numa-meminfo.node0.Inactive
    678653 ± 49%    -100.0%       0.00        numa-meminfo.node0.Inactive(anon)
   1095181 ± 64%    -100.0%       0.00        numa-meminfo.node0.Inactive(file)
     46789 ± 28%    -100.0%       0.00        numa-meminfo.node0.KReclaimable
     11095 ±  4%    -100.0%       0.00        numa-meminfo.node0.KernelStack
    101067 ± 28%    -100.0%       0.00        numa-meminfo.node0.Mapped
 2.611e+08          -100.0%       0.00        numa-meminfo.node0.MemFree
 2.638e+08          -100.0%       0.00        numa-meminfo.node0.MemTotal
   2732014 ± 23%    -100.0%       0.00        numa-meminfo.node0.MemUsed
      7763 ±  6%    -100.0%       0.00        numa-meminfo.node0.PageTables
     46789 ± 28%    -100.0%       0.00        numa-meminfo.node0.SReclaimable
    125988 ±  9%    -100.0%       0.00        numa-meminfo.node0.SUnreclaim
    138154 ±125%    -100.0%       0.00        numa-meminfo.node0.Shmem
    172777 ± 12%    -100.0%       0.00        numa-meminfo.node0.Slab
      3231 ±  5%    -100.0%       0.00        numa-meminfo.node0.Unevictable
    131809 ± 35%    -100.0%       0.00        numa-meminfo.node1.Active
     61136 ± 10%    -100.0%       0.00        numa-meminfo.node1.Active(anon)
     70672 ± 59%    -100.0%       0.00        numa-meminfo.node1.Active(file)
    133009 ± 33%    -100.0%       0.00        numa-meminfo.node1.AnonHugePages
    629614 ± 38%    -100.0%       0.00        numa-meminfo.node1.AnonPages
    819699 ± 29%    -100.0%       0.00        numa-meminfo.node1.AnonPages.max
   1257793 ± 62%    -100.0%       0.00        numa-meminfo.node1.FilePages
   1756533 ± 32%    -100.0%       0.00        numa-meminfo.node1.Inactive
   1193976 ± 28%    -100.0%       0.00        numa-meminfo.node1.Inactive(anon)
    562556 ±126%    -100.0%       0.00        numa-meminfo.node1.Inactive(file)
     40060 ± 33%    -100.0%       0.00        numa-meminfo.node1.KReclaimable
     10374 ±  4%    -100.0%       0.00        numa-meminfo.node1.KernelStack
     60225 ± 48%    -100.0%       0.00        numa-meminfo.node1.Mapped
 2.614e+08          -100.0%       0.00        numa-meminfo.node1.MemFree
 2.642e+08          -100.0%       0.00        numa-meminfo.node1.MemTotal
   2770706 ± 22%    -100.0%       0.00        numa-meminfo.node1.MemUsed
      6462 ±  8%    -100.0%       0.00        numa-meminfo.node1.PageTables
     40060 ± 33%    -100.0%       0.00        numa-meminfo.node1.SReclaimable
    116360 ± 10%    -100.0%       0.00        numa-meminfo.node1.SUnreclaim
    624395 ± 27%    -100.0%       0.00        numa-meminfo.node1.Shmem
    156420 ± 13%    -100.0%       0.00        numa-meminfo.node1.Slab
      0.01 ± 17%     +56.1%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.03 ± 51%    +147.3%       0.08 ± 39%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 24%    +132.8%       0.05 ± 52%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±  5%    +110.7%       0.02 ± 13%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ±  7%    +207.9%       0.05 ± 87%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 71%    +159.7%       0.06 ± 37%  perf-sched.sch_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.00         +4144.4%       0.13 ±213%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 16%    +135.3%       0.03 ± 33%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.do_pselect.constprop
      0.03 ± 37%     +81.9%       0.05 ± 14%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  5%    +117.5%       0.02 ± 40%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ±  2%     +74.2%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 18%     +70.5%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.05 ± 56%    +186.6%       0.14 ± 43%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.09 ± 52%   +1385.3%       1.38 ±198%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.06 ± 27%  +2.6e+05%     167.11 ±223%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.04 ± 37%    +277.6%       0.13 ± 44%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.do_pselect.constprop
      0.05 ± 22%    +190.8%       0.14 ± 24%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.05 ± 10%   +3160.1%       1.61 ±197%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.do_epoll_pwait.part
      0.04 ± 21%    +222.5%       0.14 ± 78%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.04 ± 33%    +193.0%       0.12 ± 68%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      8369 ±  7%     -10.6%       7478 ±  4%  perf-sched.total_wait_and_delay.count.ms
    253.51 ±  3%     +22.4%     310.30 ±  2%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.03 ±  5%    +106.4%       2.13 ±  5%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.10 ±  5%     +73.2%       0.18 ±  8%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1.51 ±  4%     +62.7%       2.46 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    124.00           -48.8%      63.50        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    123.00           -49.3%      62.33        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2125           -34.1%       1400 ± 27%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     86.00           -52.3%      41.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     19.83           -49.6%      10.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    550.00 ±  2%     -12.2%     482.67 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     21.99 ±  3%     +26.6%      27.84 ±  7%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5.86 ±  6%     +78.7%      10.47 ±  8%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    253.50 ±  3%     +22.4%     310.28 ±  2%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.02 ±  5%    +104.8%       2.08 ±  7%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.10 ± 17%     +66.2%       0.17 ± 11%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.10 ±  5%     +73.2%       0.18 ±  8%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.04 ±110%    +332.7%       0.16 ± 57%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      1.50 ±  4%     +62.3%       2.43 ±  8%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ± 40%    +750.0%       0.02 ±122%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     21.97 ±  3%     +26.6%      27.82 ±  7%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.35 ± 16%     +48.7%       0.52 ±  7%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.06 ±108%    +379.9%       0.29 ± 50%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      5.84 ±  6%     +78.8%      10.44 ±  8%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03 ± 16%    +851.5%       0.31 ±157%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      3375 ± 48%    -100.0%       0.00        numa-vmstat.node0.nr_active_anon
     21639 ± 49%    -100.0%       0.00        numa-vmstat.node0.nr_active_file
    138732 ± 43%    -100.0%       0.00        numa-vmstat.node0.nr_anon_pages
     69.78 ± 29%    -100.0%       0.00        numa-vmstat.node0.nr_anon_transparent_hugepages
    330019 ± 59%    -100.0%       0.00        numa-vmstat.node0.nr_file_pages
   3551956          -100.0%       0.00        numa-vmstat.node0.nr_foll_pin_acquired
   3551953          -100.0%       0.00        numa-vmstat.node0.nr_foll_pin_released
  65277218          -100.0%       0.00        numa-vmstat.node0.nr_free_pages
    169733 ± 49%    -100.0%       0.00        numa-vmstat.node0.nr_inactive_anon
    273801 ± 64%    -100.0%       0.00        numa-vmstat.node0.nr_inactive_file
     11096 ±  4%    -100.0%       0.00        numa-vmstat.node0.nr_kernel_stack
     25457 ± 28%    -100.0%       0.00        numa-vmstat.node0.nr_mapped
      1937 ±  6%    -100.0%       0.00        numa-vmstat.node0.nr_page_table_pages
     34539 ±125%    -100.0%       0.00        numa-vmstat.node0.nr_shmem
     11695 ± 28%    -100.0%       0.00        numa-vmstat.node0.nr_slab_reclaimable
     31493 ±  9%    -100.0%       0.00        numa-vmstat.node0.nr_slab_unreclaimable
    807.98 ±  5%    -100.0%       0.00        numa-vmstat.node0.nr_unevictable
      3375 ± 48%    -100.0%       0.00        numa-vmstat.node0.nr_zone_active_anon
     21639 ± 49%    -100.0%       0.00        numa-vmstat.node0.nr_zone_active_file
    169735 ± 49%    -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_anon
    273801 ± 64%    -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_file
    807.98 ±  5%    -100.0%       0.00        numa-vmstat.node0.nr_zone_unevictable
    576852 ± 19%    -100.0%       0.00        numa-vmstat.node0.numa_hit
    522864 ± 24%    -100.0%       0.00        numa-vmstat.node0.numa_local
     53991 ± 50%    -100.0%       0.00        numa-vmstat.node0.numa_other
     15300 ± 10%    -100.0%       0.00        numa-vmstat.node1.nr_active_anon
     17669 ± 59%    -100.0%       0.00        numa-vmstat.node1.nr_active_file
    157621 ± 38%    -100.0%       0.00        numa-vmstat.node1.nr_anon_pages
    314384 ± 62%    -100.0%       0.00        numa-vmstat.node1.nr_file_pages
   3552396          -100.0%       0.00        numa-vmstat.node1.nr_foll_pin_acquired
   3552390          -100.0%       0.00        numa-vmstat.node1.nr_foll_pin_released
  65353661          -100.0%       0.00        numa-vmstat.node1.nr_free_pages
    298619 ± 28%    -100.0%       0.00        numa-vmstat.node1.nr_inactive_anon
    140594 ±126%    -100.0%       0.00        numa-vmstat.node1.nr_inactive_file
     10373 ±  4%    -100.0%       0.00        numa-vmstat.node1.nr_kernel_stack
     15147 ± 48%    -100.0%       0.00        numa-vmstat.node1.nr_mapped
      1615 ±  8%    -100.0%       0.00        numa-vmstat.node1.nr_page_table_pages
    156079 ± 27%    -100.0%       0.00        numa-vmstat.node1.nr_shmem
     10015 ± 33%    -100.0%       0.00        numa-vmstat.node1.nr_slab_reclaimable
     29089 ± 10%    -100.0%       0.00        numa-vmstat.node1.nr_slab_unreclaimable
     15300 ± 10%    -100.0%       0.00        numa-vmstat.node1.nr_zone_active_anon
     17669 ± 59%    -100.0%       0.00        numa-vmstat.node1.nr_zone_active_file
    298620 ± 28%    -100.0%       0.00        numa-vmstat.node1.nr_zone_inactive_anon
    140594 ±126%    -100.0%       0.00        numa-vmstat.node1.nr_zone_inactive_file
    605836 ± 18%    -100.0%       0.00        numa-vmstat.node1.numa_hit
    560149 ± 22%    -100.0%       0.00        numa-vmstat.node1.numa_local
     45685 ± 60%    -100.0%       0.00        numa-vmstat.node1.numa_other
      9.24           -26.9%       6.75        perf-stat.i.MPKI
 3.006e+09 ±  3%     +30.6%  3.924e+09        perf-stat.i.branch-instructions
      2.88            -0.7        2.19 ±  2%  perf-stat.i.branch-miss-rate%
  34648844           -23.3%   26559921        perf-stat.i.branch-misses
     44.09            +8.1       52.19        perf-stat.i.cache-miss-rate%
 4.032e+08           -44.5%  2.239e+08        perf-stat.i.cache-misses
 6.104e+08           -42.7%  3.496e+08        perf-stat.i.cache-references
      6150 ±  4%     -27.2%       4479 ±  3%  perf-stat.i.context-switches
      1.98 ±  2%     +40.0%       2.78        perf-stat.i.cpi
 5.387e+10           +33.5%  7.189e+10        perf-stat.i.cpu-cycles
    156.13            -9.6%     141.17        perf-stat.i.cpu-migrations
    666.32 ±  3%     -13.9%     574.01        perf-stat.i.cycles-between-cache-misses
   1379778           -36.7%     873874 ±  2%  perf-stat.i.dTLB-load-misses
 1.241e+10 ±  2%      -5.1%  1.178e+10        perf-stat.i.dTLB-loads
      0.04 ±  4%      -0.0        0.03 ±  3%  perf-stat.i.dTLB-store-miss-rate%
    976671           -45.5%     532272        perf-stat.i.dTLB-store-misses
 4.839e+09           -12.5%  4.236e+09        perf-stat.i.dTLB-stores
     41.13 ±  4%      -3.8       37.28        perf-stat.i.iTLB-load-miss-rate%
   1105884           -24.3%     837557        perf-stat.i.iTLB-load-misses
   1971195 ± 11%     -18.1%    1613463        perf-stat.i.iTLB-loads
     26637 ±  2%     +45.0%      38621        perf-stat.i.instructions-per-iTLB-miss
      0.61           -26.0%       0.45        perf-stat.i.ipc
     12.95 ±  3%     -33.3%       8.64 ±  3%  perf-stat.i.major-faults
      0.56           +33.4%       0.75        perf-stat.i.metric.GHz
      1256           -37.8%     781.77        perf-stat.i.metric.K/sec
    217.05 ±  2%      -2.8%     210.92        perf-stat.i.metric.M/sec
     22076           -73.0%       5958        perf-stat.i.minor-faults
     30.69 ±  2%     +26.8       57.44        perf-stat.i.node-load-miss-rate%
   5638356          +188.6%   16272394        perf-stat.i.node-load-misses
  51095437           -68.4%   16149472        perf-stat.i.node-loads
     24.17 ±  5%     +33.5       57.66        perf-stat.i.node-store-miss-rate%
   3634105          +207.6%   11177771        perf-stat.i.node-store-misses
  33521254           -68.1%   10709700        perf-stat.i.node-stores
     22089           -73.0%       5966        perf-stat.i.page-faults
     13.73           -44.7%       7.60        perf-stat.overall.MPKI
      1.12 ±  2%      -0.5        0.65        perf-stat.overall.branch-miss-rate%
     66.19            -1.9       64.29        perf-stat.overall.cache-miss-rate%
      1.83           +33.2%       2.44        perf-stat.overall.cpi
    133.26          +140.7%     320.76        perf-stat.overall.cycles-between-cache-misses
      0.01            -0.0        0.01 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.02            -0.0        0.01        perf-stat.overall.dTLB-store-miss-rate%
     27181 ±  2%     +33.5%      36284        perf-stat.overall.instructions-per-iTLB-miss
      0.55           -25.0%       0.41        perf-stat.overall.ipc
      9.93           +40.3       50.21        perf-stat.overall.node-load-miss-rate%
      9.78           +41.3       51.05        perf-stat.overall.node-store-miss-rate%
 3.017e+09 ±  3%     +31.3%  3.961e+09        perf-stat.ps.branch-instructions
  33863841           -23.7%   25852545        perf-stat.ps.branch-misses
  4.08e+08           -44.2%  2.279e+08        perf-stat.ps.cache-misses
 6.164e+08           -42.5%  3.544e+08        perf-stat.ps.cache-references
      5959 ±  4%     -27.9%       4295 ±  4%  perf-stat.ps.context-switches
 5.437e+10           +34.4%  7.309e+10        perf-stat.ps.cpu-cycles
    153.77           -10.2%     138.05        perf-stat.ps.cpu-migrations
   1362804           -37.6%     851037 ±  2%  perf-stat.ps.dTLB-load-misses
 1.253e+10 ±  2%      -4.7%  1.194e+10        perf-stat.ps.dTLB-loads
    982670           -45.5%     535635        perf-stat.ps.dTLB-store-misses
 4.886e+09           -12.1%  4.294e+09        perf-stat.ps.dTLB-stores
   1093709           -24.4%     826521        perf-stat.ps.iTLB-load-misses
   1967627 ± 10%     -17.5%    1623220        perf-stat.ps.iTLB-loads
     12.44 ±  3%     -35.3%       8.05 ±  3%  perf-stat.ps.major-faults
     21849           -74.4%       5599        perf-stat.ps.minor-faults
   5700455          +191.0%   16587479        perf-stat.ps.node-load-misses
  51713905           -68.2%   16452569        perf-stat.ps.node-loads
   3675605          +209.5%   11374853        perf-stat.ps.node-store-misses
  33923436           -67.8%   10906955        perf-stat.ps.node-stores
     21862           -74.3%       5607        perf-stat.ps.page-faults
 2.516e+12           +82.7%  4.596e+12        perf-stat.total.instructions
      7647 ± 15%   +7433.9%     576144 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
     30894 ± 29%   +3982.0%    1261110 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.max
      2728 ± 33%   +1541.3%      44777 ± 91%  sched_debug.cfs_rq:/.avg_vruntime.min
      4017 ± 12%   +7295.9%     297155 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.07 ± 33%    +400.4%       0.37 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.26 ± 14%     +62.7%       0.42 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
      1477 ± 93%    +658.6%      11208 ± 24%  sched_debug.cfs_rq:/.load.avg
      7647 ± 15%   +7433.9%     576145 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
     30894 ± 29%   +3982.0%    1261110 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
      2728 ± 33%   +1541.3%      44777 ± 91%  sched_debug.cfs_rq:/.min_vruntime.min
      4017 ± 12%   +7295.9%     297155 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.07 ± 33%    +400.4%       0.37 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
      0.26 ± 14%     +62.7%       0.42 ±  2%  sched_debug.cfs_rq:/.nr_running.stddev
    250.19 ±  8%     +65.6%     414.25 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
    276.31 ±  5%     +48.5%     410.18        sched_debug.cfs_rq:/.runnable_avg.stddev
    249.62 ±  8%     +65.5%     413.18 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
    276.00 ±  5%     +48.6%     410.18        sched_debug.cfs_rq:/.util_avg.stddev
     23.11 ± 19%    +497.9%     138.20 ±  5%  sched_debug.cfs_rq:/.util_est.avg
    845.17 ±  8%     -16.7%     704.06 ±  9%  sched_debug.cfs_rq:/.util_est.max
    109.08 ±  8%     +65.1%     180.12 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
      6.61 ±128%    +214.3%      20.79 ± 70%  sched_debug.cfs_rq:/init.scope.avg_vruntime.min
      6.61 ±128%    +214.3%      20.79 ± 70%  sched_debug.cfs_rq:/init.scope.min_vruntime.min
     50610           +61.8%      81883 ± 34%  sched_debug.cfs_rq:/init.scope.se->exec_start.avg
     50661           +61.9%      82013 ± 34%  sched_debug.cfs_rq:/init.scope.se->exec_start.max
     50549           +61.5%      81627 ± 35%  sched_debug.cfs_rq:/init.scope.se->exec_start.min
    153.50 ±153%    +494.9%     913.22 ± 62%  sched_debug.cfs_rq:/init.scope.se->load.weight.min
      6.80 ±133%    +216.4%      21.51 ± 69%  sched_debug.cfs_rq:/init.scope.se->sum_exec_runtime.min
      6475 ± 32%   +1515.3%     104591 ± 91%  sched_debug.cfs_rq:/init.scope.se->vruntime.min
     13999 ± 20%     -66.0%       4760 ± 33%  sched_debug.cfs_rq:/init.scope.tg_load_avg.avg
     13999 ± 20%     -66.0%       4760 ± 33%  sched_debug.cfs_rq:/init.scope.tg_load_avg.max
     13999 ± 20%     -66.0%       4760 ± 33%  sched_debug.cfs_rq:/init.scope.tg_load_avg.min
      3518 ± 15%  +18809.0%     665385 ±  2%  sched_debug.cfs_rq:/system.slice.avg_vruntime.avg
     23752 ± 49%   +5906.4%    1426667 ±  7%  sched_debug.cfs_rq:/system.slice.avg_vruntime.max
      1472 ± 31%   +3291.4%      49946 ± 90%  sched_debug.cfs_rq:/system.slice.avg_vruntime.min
      2920 ± 39%  +11804.1%     347701 ±  7%  sched_debug.cfs_rq:/system.slice.avg_vruntime.stddev
      0.09 ± 34%    +424.6%       0.46 ±  4%  sched_debug.cfs_rq:/system.slice.h_nr_running.avg
      0.28 ± 14%     +46.3%       0.41 ±  2%  sched_debug.cfs_rq:/system.slice.h_nr_running.stddev
      2067 ± 52%    +412.4%      10591 ±  6%  sched_debug.cfs_rq:/system.slice.load.avg
     10.36 ±  6%     +16.9%      12.12 ±  4%  sched_debug.cfs_rq:/system.slice.load_avg.avg
     68.67 ± 21%     -47.2%      36.28 ± 17%  sched_debug.cfs_rq:/system.slice.load_avg.max
     13.24 ± 10%     -20.1%      10.58 ±  6%  sched_debug.cfs_rq:/system.slice.load_avg.stddev
      3518 ± 15%  +18809.0%     665385 ±  2%  sched_debug.cfs_rq:/system.slice.min_vruntime.avg
     23752 ± 49%   +5906.4%    1426667 ±  7%  sched_debug.cfs_rq:/system.slice.min_vruntime.max
      1472 ± 31%   +3291.4%      49946 ± 90%  sched_debug.cfs_rq:/system.slice.min_vruntime.min
      2920 ± 39%  +11804.1%     347701 ±  7%  sched_debug.cfs_rq:/system.slice.min_vruntime.stddev
      0.09 ± 34%    +424.6%       0.46 ±  4%  sched_debug.cfs_rq:/system.slice.nr_running.avg
      0.28 ± 14%     +46.3%       0.41 ±  2%  sched_debug.cfs_rq:/system.slice.nr_running.stddev
    287.37 ±  7%     +75.3%     503.83 ±  5%  sched_debug.cfs_rq:/system.slice.runnable_avg.avg
    277.25 ±  5%     +43.0%     396.44        sched_debug.cfs_rq:/system.slice.runnable_avg.stddev
      6.50 ± 55%     +91.9%      12.48 ±  8%  sched_debug.cfs_rq:/system.slice.se->avg.load_avg.avg
    287.37 ±  7%     +75.3%     503.88 ±  5%  sched_debug.cfs_rq:/system.slice.se->avg.runnable_avg.avg
    277.25 ±  5%     +43.0%     396.37        sched_debug.cfs_rq:/system.slice.se->avg.runnable_avg.stddev
    287.35 ±  7%     +75.3%     503.74 ±  5%  sched_debug.cfs_rq:/system.slice.se->avg.util_avg.avg
    277.24 ±  5%     +43.0%     396.49        sched_debug.cfs_rq:/system.slice.se->avg.util_avg.stddev
     50573          +116.7%     109592        sched_debug.cfs_rq:/system.slice.se->exec_start.avg
     50741          +117.9%     110587        sched_debug.cfs_rq:/system.slice.se->exec_start.max
     43876          +137.1%     104039        sched_debug.cfs_rq:/system.slice.se->exec_start.min
    745.42           +42.9%       1065 ±  9%  sched_debug.cfs_rq:/system.slice.se->exec_start.stddev
    327582 ± 23%     -63.1%     120920 ± 31%  sched_debug.cfs_rq:/system.slice.se->load.weight.max
     48399 ± 22%     -58.8%      19928 ± 25%  sched_debug.cfs_rq:/system.slice.se->load.weight.stddev
    330.49 ± 22%   +4461.4%      15074        sched_debug.cfs_rq:/system.slice.se->sum_exec_runtime.avg
     10758 ± 44%    +226.9%      35171 ±  7%  sched_debug.cfs_rq:/system.slice.se->sum_exec_runtime.max
     29.77 ± 30%   +4193.1%       1277 ± 84%  sched_debug.cfs_rq:/system.slice.se->sum_exec_runtime.min
      1382 ± 35%    +484.7%       8085 ±  7%  sched_debug.cfs_rq:/system.slice.se->sum_exec_runtime.stddev
      7861 ± 13%   +7258.1%     578439        sched_debug.cfs_rq:/system.slice.se->vruntime.avg
     29255 ± 32%   +4127.3%    1236710 ±  6%  sched_debug.cfs_rq:/system.slice.se->vruntime.max
      2957 ± 30%   +1554.1%      48917 ± 83%  sched_debug.cfs_rq:/system.slice.se->vruntime.min
      4044 ± 16%   +7281.5%     298577 ±  6%  sched_debug.cfs_rq:/system.slice.se->vruntime.stddev
    302.45 ± 62%     -77.0%      69.42 ± 88%  sched_debug.cfs_rq:/system.slice.tg_load_avg.stddev
    287.35 ±  7%     +75.3%     503.74 ±  5%  sched_debug.cfs_rq:/system.slice.util_avg.avg
    277.24 ±  5%     +43.0%     396.48        sched_debug.cfs_rq:/system.slice.util_avg.stddev
      1.57 ±193%   +1094.7%      18.73 ± 51%  sched_debug.cfs_rq:/system.slice/containerd.service.avg_vruntime.min
      0.86 ± 26%    +364.2%       3.97 ± 16%  sched_debug.cfs_rq:/system.slice/containerd.service.load_avg.avg
      3.83 ± 55%    +140.6%       9.22 ± 19%  sched_debug.cfs_rq:/system.slice/containerd.service.load_avg.max
      1.41 ± 48%    +148.1%       3.51 ± 22%  sched_debug.cfs_rq:/system.slice/containerd.service.load_avg.stddev
      1.57 ±193%   +1094.7%      18.73 ± 51%  sched_debug.cfs_rq:/system.slice/containerd.service.min_vruntime.min
      0.88 ± 28%    +355.8%       4.01 ± 16%  sched_debug.cfs_rq:/system.slice/containerd.service.runnable_avg.avg
      4.00 ± 55%    +130.6%       9.22 ± 19%  sched_debug.cfs_rq:/system.slice/containerd.service.runnable_avg.max
      1.47 ± 49%    +138.4%       3.50 ± 22%  sched_debug.cfs_rq:/system.slice/containerd.service.runnable_avg.stddev
      0.26 ± 92%    +390.2%       1.29 ± 20%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.load_avg.avg
      0.85 ± 32%    +368.2%       3.99 ± 16%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.runnable_avg.avg
      3.83 ± 61%    +137.7%       9.11 ± 18%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.runnable_avg.max
      1.41 ± 53%    +145.3%       3.46 ± 21%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.runnable_avg.stddev
      0.85 ± 32%    +365.3%       3.96 ± 17%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.util_avg.avg
      3.83 ± 61%    +136.2%       9.06 ± 19%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.util_avg.max
      1.41 ± 53%    +143.9%       3.44 ± 22%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.util_avg.stddev
     50173          +118.7%     109726        sched_debug.cfs_rq:/system.slice/containerd.service.se->exec_start.avg
     50702          +117.3%     110151        sched_debug.cfs_rq:/system.slice/containerd.service.se->exec_start.max
     48149 ±  6%    +125.9%     108746        sched_debug.cfs_rq:/system.slice/containerd.service.se->exec_start.min
    738718 ± 15%     -20.1%     590310 ±  6%  sched_debug.cfs_rq:/system.slice/containerd.service.se->load.weight.max
      2.11 ±154%    +825.1%      19.48 ± 48%  sched_debug.cfs_rq:/system.slice/containerd.service.se->sum_exec_runtime.min
      3846 ± 24%  +12555.9%     486815 ± 20%  sched_debug.cfs_rq:/system.slice/containerd.service.se->vruntime.avg
      8152 ± 52%   +8857.9%     730249 ± 21%  sched_debug.cfs_rq:/system.slice/containerd.service.se->vruntime.max
      2008 ± 22%  +14293.3%     289128 ± 44%  sched_debug.cfs_rq:/system.slice/containerd.service.se->vruntime.min
      2041 ± 71%   +8227.2%     170022 ± 38%  sched_debug.cfs_rq:/system.slice/containerd.service.se->vruntime.stddev
      5.20 ± 39%    +266.8%      19.08 ± 22%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.avg
      5.33 ± 38%    +293.8%      21.00 ± 25%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.max
      5.00 ± 38%    +255.6%      17.78 ± 22%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.min
      0.16 ±141%    +651.8%       1.19 ± 70%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.stddev
      0.86 ± 26%    +361.1%       3.95 ± 17%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg_contrib.avg
      3.83 ± 55%    +140.6%       9.22 ± 19%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg_contrib.max
      1.41 ± 48%    +146.1%       3.48 ± 22%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg_contrib.stddev
      0.88 ± 28%    +353.0%       3.99 ± 17%  sched_debug.cfs_rq:/system.slice/containerd.service.util_avg.avg
      4.00 ± 55%    +129.2%       9.17 ± 20%  sched_debug.cfs_rq:/system.slice/containerd.service.util_avg.max
      1.47 ± 49%    +137.0%       3.48 ± 22%  sched_debug.cfs_rq:/system.slice/containerd.service.util_avg.stddev
     50765          +119.4%     111370        sched_debug.cpu.clock.avg
     50771          +119.4%     111382        sched_debug.cpu.clock.max
     50759          +119.4%     111356        sched_debug.cpu.clock.min
      3.27 ± 10%    +126.1%       7.40 ± 21%  sched_debug.cpu.clock.stddev
     50601          +116.6%     109610        sched_debug.cpu.clock_task.avg
     50745          +118.0%     110614        sched_debug.cpu.clock_task.max
     43880          +134.7%     102986        sched_debug.cpu.clock_task.min
    696.32           +51.9%       1057 ±  6%  sched_debug.cpu.clock_task.stddev
    165.30 ± 33%    +792.2%       1474 ±  2%  sched_debug.cpu.curr->pid.avg
      2493           +85.2%       4618        sched_debug.cpu.curr->pid.max
    587.01 ± 16%    +230.2%       1938        sched_debug.cpu.curr->pid.stddev
      0.00 ± 22%     +76.0%       0.00 ±  7%  sched_debug.cpu.next_balance.stddev
      0.07 ± 28%    +293.0%       0.29 ±  3%  sched_debug.cpu.nr_running.avg
      0.26 ± 12%     +60.0%       0.42 ±  2%  sched_debug.cpu.nr_running.stddev
      1606 ±  3%    +188.0%       4627 ±  3%  sched_debug.cpu.nr_switches.avg
     11893 ± 21%    +400.8%      59557 ±  2%  sched_debug.cpu.nr_switches.max
    254.67 ± 13%    +299.7%       1017 ± 17%  sched_debug.cpu.nr_switches.min
      2062 ± 11%    +220.6%       6611 ±  3%  sched_debug.cpu.nr_switches.stddev
      0.14 ± 17%     -76.4%       0.03 ± 14%  sched_debug.cpu.nr_uninterruptible.avg
     50761          +119.4%     111355        sched_debug.cpu_clk
     50082          +121.0%     110688        sched_debug.ktime
     51315          +118.1%     111904        sched_debug.sched_clk
     19.88 ± 35%     -19.9        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.88 ± 35%     -19.9        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     19.20 ± 16%     -19.2        0.00        perf-profile.calltrace.cycles-pp.write
     17.84 ± 19%     -17.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     17.84 ± 19%     -17.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     17.84 ± 19%     -17.8        0.00        perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
     17.84 ± 19%     -17.8        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     17.84 ± 19%     -17.8        0.00        perf-profile.calltrace.cycles-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.84 ± 19%     -17.8        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     12.83 ± 44%     -12.8        0.00        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.83 ± 44%     -12.8        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
     12.83 ± 44%     -12.8        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     12.83 ± 44%     -12.8        0.00        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.83 ± 44%     -12.8        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.79 ± 52%     -11.8        0.00        perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     10.96 ± 48%     -11.0        0.00        perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
      9.79 ± 55%      -9.8        0.00        perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      9.79 ± 55%      -9.8        0.00        perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
      9.42 ± 39%      -9.4        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter
      6.64 ± 37%      -6.6        0.00        perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
      6.55 ± 65%      -6.5        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      6.41 ± 20%      -6.4        0.00        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.35 ± 42%      -6.4        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
      6.07 ± 62%      -6.1        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      6.07 ± 62%      -6.1        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      5.99 ± 73%      -6.0        0.00        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.54 ± 55%      -5.5        0.00        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      5.54 ± 55%      -5.5        0.00        perf-profile.calltrace.cycles-pp.rep_movs_alternative.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.vfs_write
      5.03 ± 78%      -5.0        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +1.0        0.96 ± 13%  perf-profile.calltrace.cycles-pp.opal_progress
      0.00            +1.8        1.83        perf-profile.calltrace.cycles-pp.tzetar_.z_solve_.adi_
      0.00            +2.2        2.16 ±  4%  perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_to_iter.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core
      0.00            +2.2        2.20 ±  4%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
      0.00            +2.2        2.20 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv
      0.00            +2.5        2.50 ±  4%  perf-profile.calltrace.cycles-pp.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv.do_syscall_64
      0.00            +2.7        2.70 ±  4%  perf-profile.calltrace.cycles-pp.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.7        2.73 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_process_vm_readv.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_readv
      0.00            +2.7        2.73 ±  4%  perf-profile.calltrace.cycles-pp.process_vm_rw.__x64_sys_process_vm_readv.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_readv
      0.00            +2.7        2.74 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_readv
      0.00            +2.7        2.75 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.process_vm_readv
      0.00            +2.8        2.82 ±  4%  perf-profile.calltrace.cycles-pp.process_vm_readv
      0.00            +3.1        3.09 ±  2%  perf-profile.calltrace.cycles-pp.txinvr_.adi_
      0.00            +3.2        3.16        perf-profile.calltrace.cycles-pp.copy_faces_
      0.00            +3.4        3.40 ±  3%  perf-profile.calltrace.cycles-pp.add_.MAIN__
      0.00            +3.9        3.91 ±  3%  perf-profile.calltrace.cycles-pp.MAIN__
      0.00            +5.5        5.52        perf-profile.calltrace.cycles-pp.lhsx_.x_solve_.adi_
      0.00            +6.2        6.25 ±  3%  perf-profile.calltrace.cycles-pp.lhsy_.y_solve_.adi_
      0.00            +7.4        7.38        perf-profile.calltrace.cycles-pp.lhsz_.z_solve_.adi_
      0.00            +9.1        9.14        perf-profile.calltrace.cycles-pp.compute_rhs_.adi_
      0.00           +12.1       12.09 ±  2%  perf-profile.calltrace.cycles-pp.y_solve_.adi_
      0.00           +12.4       12.42        perf-profile.calltrace.cycles-pp.x_solve_.adi_
      0.00           +14.5       14.55        perf-profile.calltrace.cycles-pp.z_solve_.adi_
      0.00           +51.6       51.58        perf-profile.calltrace.cycles-pp.adi_
     51.56 ± 15%     -48.2        3.36 ±  4%  perf-profile.children.cycles-pp.do_syscall_64
     51.56 ± 15%     -48.2        3.36 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     19.20 ± 16%     -19.2        0.00        perf-profile.children.cycles-pp.write
     17.84 ± 19%     -17.8        0.00        perf-profile.children.cycles-pp.generic_perform_write
     17.84 ± 19%     -17.8        0.00        perf-profile.children.cycles-pp.ksys_write
     17.84 ± 19%     -17.8        0.00        perf-profile.children.cycles-pp.shmem_file_write_iter
     17.84 ± 19%     -17.8        0.00        perf-profile.children.cycles-pp.vfs_write
     16.00 ± 34%     -15.9        0.12 ± 15%  perf-profile.children.cycles-pp.do_exit
     16.00 ± 34%     -15.9        0.12 ± 15%  perf-profile.children.cycles-pp.do_group_exit
     13.39 ± 40%     -13.4        0.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     12.83 ± 44%     -12.8        0.00        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     12.83 ± 44%     -12.8        0.00        perf-profile.children.cycles-pp.get_signal
     12.81 ± 36%     -12.8        0.00        perf-profile.children.cycles-pp.__fput
     12.54 ± 46%     -12.5        0.02 ± 99%  perf-profile.children.cycles-pp.task_work_run
     12.82 ± 42%     -12.4        0.38 ± 35%  perf-profile.children.cycles-pp.asm_exc_page_fault
     10.45 ± 34%     -10.4        0.00        perf-profile.children.cycles-pp.event_function_call
     10.16 ± 37%     -10.2        0.00        perf-profile.children.cycles-pp.smp_call_function_single
      9.79 ± 55%      -9.8        0.00        perf-profile.children.cycles-pp.perf_event_release_kernel
      9.79 ± 55%      -9.8        0.00        perf-profile.children.cycles-pp.perf_release
      6.41 ± 20%      -6.4        0.00        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      6.41 ± 20%      -6.4        0.00        perf-profile.children.cycles-pp.fault_in_readable
      5.54 ± 55%      -5.5        0.00        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      4.88 ± 38%      -4.8        0.13 ± 14%  perf-profile.children.cycles-pp.__mmput
      4.61 ± 31%      -4.5        0.13 ± 14%  perf-profile.children.cycles-pp.exit_mmap
      4.38 ± 37%      -4.3        0.13 ±  5%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      5.54 ± 55%      -3.3        2.19 ±  4%  perf-profile.children.cycles-pp.rep_movs_alternative
      3.18 ± 26%      -3.1        0.11 ± 15%  perf-profile.children.cycles-pp.exit_mm
      3.18 ± 26%      -3.1        0.12 ± 15%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.malloc
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.find_get_task_by_vpid
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.runtime.selectgo
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.runtime.mcall
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.runtime.park_m
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.runtime.schedule
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.try_grab_page
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.github.com/containerd/containerd/gc/scheduler.(*gcScheduler).run
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.github.com/containerd/containerd/gc/scheduler.init.0.func1.1
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.yama_ptrace_access_check
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.do_poll
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.account_user_time
      0.00            +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.pinvr_
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.do_sys_poll
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.ninvr_
      0.00            +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.__poll
      0.00            +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.security_ptrace_access_check
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.runtime.goexit.abi0
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.ptrace_may_access
      0.00            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.mca_btl_vader_poll_handle_frag
      0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.follow_page_pte
      0.00            +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.mm_access
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.memcpy@plt
      0.00            +0.2        0.16 ± 11%  perf-profile.children.cycles-pp.opal_progress@plt
      0.00            +0.2        0.16 ±  7%  perf-profile.children.cycles-pp.ompi_request_default_wait_all
      0.00            +0.2        0.19 ±  7%  perf-profile.children.cycles-pp.__do_softirq
      0.00            +0.2        0.20 ± 12%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.00            +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.2        0.21 ±  7%  perf-profile.children.cycles-pp.verify_
      0.00            +0.2        0.22 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.2        0.22 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.2        0.22 ±  7%  perf-profile.children.cycles-pp.__get_user_pages
      0.00            +0.2        0.23 ±  7%  perf-profile.children.cycles-pp.__gup_longterm_locked
      0.00            +0.2        0.24 ±  5%  perf-profile.children.cycles-pp.pin_user_pages_remote
      0.00            +0.5        0.46 ± 80%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.00            +0.5        0.46 ± 80%  perf-profile.children.cycles-pp.rest_init
      0.00            +0.5        0.46 ± 80%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.5        0.46 ± 80%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +0.5        0.46 ± 80%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +0.5        0.46 ± 11%  perf-profile.children.cycles-pp.ompi_coll_libnbc_progress
      0.00            +1.1        1.06 ± 13%  perf-profile.children.cycles-pp.opal_progress
      0.00            +1.8        1.83 ±  2%  perf-profile.children.cycles-pp.tzetar_
      0.00            +2.2        2.20 ±  4%  perf-profile.children.cycles-pp._copy_to_iter
      0.00            +2.2        2.20 ±  4%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +2.5        2.50 ±  4%  perf-profile.children.cycles-pp.process_vm_rw_single_vec
      0.00            +2.7        2.70 ±  4%  perf-profile.children.cycles-pp.process_vm_rw_core
      0.00            +2.7        2.73 ±  4%  perf-profile.children.cycles-pp.__x64_sys_process_vm_readv
      0.00            +2.7        2.73 ±  4%  perf-profile.children.cycles-pp.process_vm_rw
      0.00            +2.8        2.82 ±  4%  perf-profile.children.cycles-pp.process_vm_readv
      0.00            +3.1        3.10 ±  2%  perf-profile.children.cycles-pp.txinvr_
      0.00            +3.2        3.20        perf-profile.children.cycles-pp.copy_faces_
      0.00            +3.4        3.41 ±  3%  perf-profile.children.cycles-pp.add_
      0.00            +3.9        3.91 ±  3%  perf-profile.children.cycles-pp.MAIN__
      0.00            +5.5        5.54        perf-profile.children.cycles-pp.lhsx_
      0.00            +6.3        6.27 ±  3%  perf-profile.children.cycles-pp.lhsy_
      0.00            +7.4        7.40        perf-profile.children.cycles-pp.lhsz_
      0.00            +9.4        9.38        perf-profile.children.cycles-pp.compute_rhs_
      0.00           +12.1       12.10 ±  2%  perf-profile.children.cycles-pp.y_solve_
      0.00           +12.4       12.44        perf-profile.children.cycles-pp.x_solve_
      0.00           +14.6       14.56        perf-profile.children.cycles-pp.z_solve_
      0.00           +51.6       51.58        perf-profile.children.cycles-pp.adi_
      6.35 ± 42%      -6.4        0.00        perf-profile.self.cycles-pp.smp_call_function_single
      4.38 ± 37%      -4.3        0.13 ±  5%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      5.14 ± 44%      -3.0        2.14 ±  4%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.try_grab_page
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.menu_select
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.task_tick_fair
      0.00            +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.pinvr_
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.ninvr_
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.memcpy@plt
      0.00            +0.1        0.08 ± 18%  perf-profile.self.cycles-pp.opal_progress@plt
      0.00            +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.mca_btl_vader_poll_handle_frag
      0.00            +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.2        0.16 ±  7%  perf-profile.self.cycles-pp.ompi_request_default_wait_all
      0.00            +0.2        0.20 ± 12%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.00            +0.4        0.44 ± 11%  perf-profile.self.cycles-pp.ompi_coll_libnbc_progress
      0.00            +0.9        0.92 ± 12%  perf-profile.self.cycles-pp.opal_progress
      0.00            +1.8        1.79 ±  2%  perf-profile.self.cycles-pp.tzetar_
      0.00            +3.0        3.04 ±  2%  perf-profile.self.cycles-pp.txinvr_
      0.00            +3.1        3.15        perf-profile.self.cycles-pp.copy_faces_
      0.00            +3.4        3.36 ±  3%  perf-profile.self.cycles-pp.add_
      0.00            +5.2        5.21        perf-profile.self.cycles-pp.z_solve_
      0.00            +5.4        5.39        perf-profile.self.cycles-pp.lhsx_
      0.00            +5.6        5.62        perf-profile.self.cycles-pp.y_solve_
      0.00            +6.1        6.09 ±  3%  perf-profile.self.cycles-pp.lhsy_
      0.00            +6.7        6.66        perf-profile.self.cycles-pp.x_solve_
      0.00            +7.2        7.22        perf-profile.self.cycles-pp.lhsz_
      0.00            +9.1        9.11        perf-profile.self.cycles-pp.compute_rhs_



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/mmap1/will-it-scale

commit: 
  9ef3ad0f03 ("ACPI/NUMA: Print CXL Early Discovery Table (CEDT)")
  09f84589a8 ("ACPI/NUMA: Remove architecture dependent remainings")

9ef3ad0f032818c5 09f84589a8ed1162c0274a1b5b3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.967e+08 ± 12%    +104.1%  4.015e+08 ± 36%  cpuidle..time
      3475           +13.2%       3933 ±  9%  uptime.idle
    117.40           +15.4%     135.50 ±  5%  vmstat.procs.r
      7130           -31.4%       4890        vmstat.system.cs
   7005637           -38.1%    4334264        will-it-scale.104.processes
     67361           -38.1%      41675        will-it-scale.per_process_ops
   7005637           -38.1%    4334264        will-it-scale.workload
      0.45            -0.1        0.34        mpstat.cpu.all.irq%
     21.80           +24.1       45.86        mpstat.cpu.all.soft%
     67.95           -21.2       46.74        mpstat.cpu.all.sys%
      9.30            -3.4        5.94        mpstat.cpu.all.usr%
     10720 ±  6%     -50.5%       5308 ±  7%  perf-c2c.DRAM.local
    669.83 ±  4%    +478.1%       3872 ±  6%  perf-c2c.DRAM.remote
      6822 ±  5%     -40.8%       4037 ±  7%  perf-c2c.HITM.local
    421.00 ±  5%    +577.2%       2850 ±  6%  perf-c2c.HITM.remote
  1.49e+08          -100.0%       0.00        numa-numastat.node0.local_node
 1.491e+08          -100.0%       0.00        numa-numastat.node0.numa_hit
     59368 ± 59%    -100.0%       0.00        numa-numastat.node0.other_node
 1.567e+08          -100.0%       0.00        numa-numastat.node1.local_node
 1.567e+08          -100.0%       0.00        numa-numastat.node1.numa_hit
     48388 ± 72%    -100.0%       0.00        numa-numastat.node1.other_node
  10352298 ±  7%     -55.6%    4591957 ± 15%  meminfo.DirectMap2M
   2206149 ±  3%     -21.4%    1733730 ±  5%  meminfo.Inactive
   2203855 ±  3%     -21.4%    1731430 ±  5%  meminfo.Inactive(anon)
   6859527           -10.6%    6129805        meminfo.Memused
     49043           -12.2%      43044        meminfo.Percpu
    495530           -22.7%     382930 ±  2%  meminfo.SUnreclaim
   1816899 ±  4%     -22.8%    1403126 ±  5%  meminfo.Shmem
    599136           -18.9%     485960        meminfo.Slab
    257232           -84.9%      38717        meminfo.VmallocUsed
   1219270            -8.5%    1115918        proc-vmstat.nr_file_pages
    550889 ±  3%     -21.4%     432828 ±  5%  proc-vmstat.nr_inactive_anon
     21408            +1.5%      21731        proc-vmstat.nr_kernel_stack
      3324            -4.1%       3187        proc-vmstat.nr_page_table_pages
    454144 ±  4%     -22.8%     350800 ±  5%  proc-vmstat.nr_shmem
    125759           -21.9%      98264        proc-vmstat.nr_slab_unreclaimable
    550889 ±  3%     -21.4%     432828 ±  5%  proc-vmstat.nr_zone_inactive_anon
     55488 ± 18%    -100.0%       0.00        proc-vmstat.numa_hint_faults
     40437 ± 29%    -100.0%       0.00        proc-vmstat.numa_hint_faults_local
 3.058e+08           -28.2%  2.195e+08        proc-vmstat.numa_hit
 3.057e+08           -28.2%  2.195e+08        proc-vmstat.numa_local
    107756          -100.0%       0.00        proc-vmstat.numa_other
     18231 ± 96%    -100.0%       0.00        proc-vmstat.numa_pages_migrated
    182874 ± 22%    -100.0%       0.00        proc-vmstat.numa_pte_updates
     90886          +122.4%     202099 ± 73%  proc-vmstat.pgactivate
 5.952e+08           -28.2%  4.271e+08        proc-vmstat.pgalloc_normal
   1042723           -39.2%     634241        proc-vmstat.pgfault
 5.943e+08           -28.2%  4.265e+08        proc-vmstat.pgfree
     18231 ± 96%    -100.0%       0.00        proc-vmstat.pgmigrate_success
     44763 ±  6%     -27.1%      32626        proc-vmstat.pgreuse
      2.02           +12.4%       2.27        perf-stat.i.MPKI
 2.933e+10           -36.2%  1.871e+10        perf-stat.i.branch-instructions
      0.82            -0.0        0.80        perf-stat.i.branch-miss-rate%
 2.382e+08           -37.7%  1.485e+08        perf-stat.i.branch-misses
     62.01           +12.4       74.38        perf-stat.i.cache-miss-rate%
 3.092e+08           -28.9%  2.199e+08        perf-stat.i.cache-misses
 4.978e+08           -40.9%  2.943e+08        perf-stat.i.cache-references
      7111           -32.2%       4822        perf-stat.i.context-switches
      1.83           +59.0%       2.91        perf-stat.i.cpi
    217.02           +39.3%     302.23        perf-stat.i.cpu-migrations
    905.82           +41.5%       1281        perf-stat.i.cycles-between-cache-misses
 1.528e+11           -36.7%   9.67e+10        perf-stat.i.instructions
      0.55           -36.9%       0.35        perf-stat.i.ipc
      0.11 ± 29%     -51.5%       0.05 ± 37%  perf-stat.i.major-faults
      3266           -40.8%       1932        perf-stat.i.minor-faults
      3266           -40.8%       1932        perf-stat.i.page-faults
      2.02           +12.4%       2.27        perf-stat.overall.MPKI
      0.81            -0.0        0.79        perf-stat.overall.branch-miss-rate%
     62.11           +12.6       74.69        perf-stat.overall.cache-miss-rate%
      1.83           +58.9%       2.91        perf-stat.overall.cpi
    905.85           +41.4%       1280        perf-stat.overall.cycles-between-cache-misses
      0.55           -37.1%       0.34        perf-stat.overall.ipc
   6581748            +3.8%    6830787        perf-stat.overall.path-length
 2.923e+10           -36.2%  1.865e+10        perf-stat.ps.branch-instructions
 2.373e+08           -37.7%  1.479e+08        perf-stat.ps.branch-misses
 3.082e+08           -28.9%  2.192e+08        perf-stat.ps.cache-misses
 4.962e+08           -40.9%  2.934e+08        perf-stat.ps.cache-references
      7083           -32.2%       4802        perf-stat.ps.context-switches
    215.95           +39.3%     300.81        perf-stat.ps.cpu-migrations
 1.523e+11           -36.7%  9.636e+10        perf-stat.ps.instructions
      0.11 ± 29%     -51.1%       0.05 ± 37%  perf-stat.ps.major-faults
      3244           -41.2%       1908        perf-stat.ps.minor-faults
      3245           -41.2%       1908        perf-stat.ps.page-faults
 4.611e+13           -35.8%  2.961e+13        perf-stat.total.instructions
     13971 ± 89%    -100.0%       0.00        numa-vmstat.node0.nr_active_anon
     97064 ± 52%    -100.0%       0.00        numa-vmstat.node0.nr_anon_pages
    551160 ± 47%    -100.0%       0.00        numa-vmstat.node0.nr_file_pages
  23600699          -100.0%       0.00        numa-vmstat.node0.nr_free_pages
     97975 ± 52%    -100.0%       0.00        numa-vmstat.node0.nr_inactive_anon
     11699 ±  4%    -100.0%       0.00        numa-vmstat.node0.nr_kernel_stack
     14296 ± 11%    -100.0%       0.00        numa-vmstat.node0.nr_mapped
      1544 ±  6%    -100.0%       0.00        numa-vmstat.node0.nr_page_table_pages
     15651 ± 83%    -100.0%       0.00        numa-vmstat.node0.nr_shmem
     15308 ± 24%    -100.0%       0.00        numa-vmstat.node0.nr_slab_reclaimable
     67651 ±  3%    -100.0%       0.00        numa-vmstat.node0.nr_slab_unreclaimable
    536155 ± 47%    -100.0%       0.00        numa-vmstat.node0.nr_unevictable
     13971 ± 89%    -100.0%       0.00        numa-vmstat.node0.nr_zone_active_anon
     97974 ± 52%    -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_anon
    536155 ± 47%    -100.0%       0.00        numa-vmstat.node0.nr_zone_unevictable
 1.491e+08          -100.0%       0.00        numa-vmstat.node0.numa_hit
  1.49e+08          -100.0%       0.00        numa-vmstat.node0.numa_local
     59368 ± 59%    -100.0%       0.00        numa-vmstat.node0.numa_other
     67762 ± 21%    -100.0%       0.00        numa-vmstat.node1.nr_active_anon
     82222 ± 62%    -100.0%       0.00        numa-vmstat.node1.nr_anon_pages
    668044 ± 37%    -100.0%       0.00        numa-vmstat.node1.nr_file_pages
  23857326          -100.0%       0.00        numa-vmstat.node1.nr_free_pages
    452882 ±  9%    -100.0%       0.00        numa-vmstat.node1.nr_inactive_anon
      9709 ±  5%    -100.0%       0.00        numa-vmstat.node1.nr_kernel_stack
    148558 ±  4%    -100.0%       0.00        numa-vmstat.node1.nr_mapped
      1779 ±  5%    -100.0%       0.00        numa-vmstat.node1.nr_page_table_pages
    438426 ±  5%    -100.0%       0.00        numa-vmstat.node1.nr_shmem
     10592 ± 35%    -100.0%       0.00        numa-vmstat.node1.nr_slab_reclaimable
     61563 ±  4%    -100.0%       0.00        numa-vmstat.node1.nr_slab_unreclaimable
    229017 ±111%    -100.0%       0.00        numa-vmstat.node1.nr_unevictable
     67762 ± 21%    -100.0%       0.00        numa-vmstat.node1.nr_zone_active_anon
    452882 ±  9%    -100.0%       0.00        numa-vmstat.node1.nr_zone_inactive_anon
    229017 ±111%    -100.0%       0.00        numa-vmstat.node1.nr_zone_unevictable
 1.567e+08          -100.0%       0.00        numa-vmstat.node1.numa_hit
 1.566e+08          -100.0%       0.00        numa-vmstat.node1.numa_local
     48388 ± 72%    -100.0%       0.00        numa-vmstat.node1.numa_other
     55900 ± 89%    -100.0%       0.00        numa-meminfo.node0.Active
     55801 ± 89%    -100.0%       0.00        numa-meminfo.node0.Active(anon)
    388254 ± 52%    -100.0%       0.00        numa-meminfo.node0.AnonPages
    440142 ± 48%    -100.0%       0.00        numa-meminfo.node0.AnonPages.max
   2204609 ± 47%    -100.0%       0.00        numa-meminfo.node0.FilePages
    392333 ± 52%    -100.0%       0.00        numa-meminfo.node0.Inactive
    391951 ± 52%    -100.0%       0.00        numa-meminfo.node0.Inactive(anon)
     61236 ± 24%    -100.0%       0.00        numa-meminfo.node0.KReclaimable
     11699 ±  4%    -100.0%       0.00        numa-meminfo.node0.KernelStack
     56750 ± 12%    -100.0%       0.00        numa-meminfo.node0.Mapped
  94405300          -100.0%       0.00        numa-meminfo.node0.MemFree
  97679448          -100.0%       0.00        numa-meminfo.node0.MemTotal
   3274147 ± 37%    -100.0%       0.00        numa-meminfo.node0.MemUsed
      6174 ±  6%    -100.0%       0.00        numa-meminfo.node0.PageTables
     61236 ± 24%    -100.0%       0.00        numa-meminfo.node0.SReclaimable
    268262 ±  4%    -100.0%       0.00        numa-meminfo.node0.SUnreclaim
     62576 ± 83%    -100.0%       0.00        numa-meminfo.node0.Shmem
    329498 ±  7%    -100.0%       0.00        numa-meminfo.node0.Slab
   2144623 ± 47%    -100.0%       0.00        numa-meminfo.node0.Unevictable
    271268 ± 21%    -100.0%       0.00        numa-meminfo.node1.Active
    270777 ± 21%    -100.0%       0.00        numa-meminfo.node1.Active(anon)
    328899 ± 62%    -100.0%       0.00        numa-meminfo.node1.AnonPages
    368362 ± 54%    -100.0%       0.00        numa-meminfo.node1.AnonPages.max
   2672717 ± 37%    -100.0%       0.00        numa-meminfo.node1.FilePages
   1814269 ±  9%    -100.0%       0.00        numa-meminfo.node1.Inactive
   1812357 ±  9%    -100.0%       0.00        numa-meminfo.node1.Inactive(anon)
     42376 ± 35%    -100.0%       0.00        numa-meminfo.node1.KReclaimable
      9709 ±  5%    -100.0%       0.00        numa-meminfo.node1.KernelStack
    594500 ±  4%    -100.0%       0.00        numa-meminfo.node1.Mapped
  95440412          -100.0%       0.00        numa-meminfo.node1.MemFree
  99034620          -100.0%       0.00        numa-meminfo.node1.MemTotal
   3594207 ± 32%    -100.0%       0.00        numa-meminfo.node1.MemUsed
      7121 ±  5%    -100.0%       0.00        numa-meminfo.node1.PageTables
     42376 ± 35%    -100.0%       0.00        numa-meminfo.node1.SReclaimable
    234056 ±  3%    -100.0%       0.00        numa-meminfo.node1.SUnreclaim
   1754246 ±  5%    -100.0%       0.00        numa-meminfo.node1.Shmem
    276432 ±  7%    -100.0%       0.00        numa-meminfo.node1.Slab
    916068 ±111%    -100.0%       0.00        numa-meminfo.node1.Unevictable
  12846621           -31.1%    8851378        sched_debug.cfs_rq:/.avg_vruntime.avg
  13026668           -29.8%    9146405        sched_debug.cfs_rq:/.avg_vruntime.max
  12010831           -34.2%    7905615        sched_debug.cfs_rq:/.avg_vruntime.min
    172319 ±  4%     +46.4%     252250 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.98           +15.9%       1.14 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.38 ±  4%     +25.9%       0.48 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
   1482184 ± 18%     +81.3%    2687007 ± 18%  sched_debug.cfs_rq:/.left_deadline.avg
  12984350           -29.9%    9098475        sched_debug.cfs_rq:/.left_deadline.max
   1482165 ± 18%     +81.3%    2686955 ± 18%  sched_debug.cfs_rq:/.left_vruntime.avg
  12984176           -29.9%    9098312        sched_debug.cfs_rq:/.left_vruntime.max
    110018 ± 15%    +151.7%     276928 ± 20%  sched_debug.cfs_rq:/.load.avg
    279353 ±  7%     +39.9%     390900 ±  5%  sched_debug.cfs_rq:/.load.stddev
    153.45 ±  7%    +165.5%     407.41 ±  5%  sched_debug.cfs_rq:/.load_avg.avg
    465.14 ± 19%     +59.0%     739.61 ±  3%  sched_debug.cfs_rq:/.load_avg.max
     67.81 ±  5%    +162.1%     177.72 ± 15%  sched_debug.cfs_rq:/.load_avg.min
     75.29 ± 10%     +48.6%     111.88 ±  7%  sched_debug.cfs_rq:/.load_avg.stddev
  12846638           -31.1%    8851412        sched_debug.cfs_rq:/.min_vruntime.avg
  13026687           -29.8%    9146424        sched_debug.cfs_rq:/.min_vruntime.max
  12010851           -34.2%    7905665        sched_debug.cfs_rq:/.min_vruntime.min
    172320 ±  4%     +46.4%     252248 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.95           +15.5%       1.10 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
      0.32 ±  5%     +31.7%       0.42 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
   1482165 ± 18%     +81.3%    2686956 ± 18%  sched_debug.cfs_rq:/.right_vruntime.avg
  12984176           -29.9%    9098312        sched_debug.cfs_rq:/.right_vruntime.max
      1047           +24.4%       1303        sched_debug.cfs_rq:/.runnable_avg.avg
      2000           +20.3%       2405 ±  2%  sched_debug.cfs_rq:/.runnable_avg.max
    159.06 ±  4%     +39.3%     221.64 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1151 ±  3%     +15.3%       1328 ±  3%  sched_debug.cfs_rq:/.util_avg.max
     78.12 ± 15%     +34.9%     105.36 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
    734.30 ±  4%     -10.1%     659.87 ±  3%  sched_debug.cfs_rq:/.util_est.avg
    159.60 ±  9%     +79.3%     286.17 ±  5%  sched_debug.cfs_rq:/.util_est.stddev
     18.37 ±  4%     +22.8%      22.56 ±  4%  sched_debug.cpu.clock.stddev
      3171 ±  2%     -18.0%       2599 ±  7%  sched_debug.cpu.curr->pid.avg
      7419 ±  2%     -24.5%       5599 ±  3%  sched_debug.cpu.curr->pid.max
      1202 ±  6%     +24.3%       1494 ±  4%  sched_debug.cpu.curr->pid.stddev
      0.00 ±  2%     +12.6%       0.00        sched_debug.cpu.next_balance.stddev
      0.98           +15.9%       1.14 ±  4%  sched_debug.cpu.nr_running.avg
      0.38 ±  4%     +25.4%       0.47 ±  5%  sched_debug.cpu.nr_running.stddev
     11316           -28.4%       8107        sched_debug.cpu.nr_switches.avg
      8294           -35.9%       5317        sched_debug.cpu.nr_switches.min
      2590 ±  6%     +20.3%       3115 ±  7%  sched_debug.cpu.nr_switches.stddev
     48.09           -14.2       33.91        perf-profile.calltrace.cycles-pp.__munmap
     36.16           -13.8       22.35        perf-profile.calltrace.cycles-pp.__mmap
     42.68           -12.0       30.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     30.76           -11.6       19.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     41.53           -11.6       29.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     40.88           -11.3       29.57        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     40.76           -11.3       29.50        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     29.62           -11.2       18.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     40.13           -11.0       29.13        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.85           -10.9       17.98        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     39.44           -10.7       28.72        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     27.54           -10.3       17.21        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     23.80            -8.8       14.98        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.41            -5.1        7.34        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     11.64            -4.5        7.10        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
     23.99            -4.4       19.62        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     10.31            -4.1        6.25        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      9.12            -3.7        5.39        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      8.76            -3.6        5.17        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      8.65            -3.4        5.29        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap
     18.03            -3.3       14.74        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      7.98            -3.3        4.71        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      6.44            -2.4        4.00        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      3.32            -1.4        1.95        perf-profile.calltrace.cycles-pp.__cond_resched.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      3.35            -1.4        2.00        perf-profile.calltrace.cycles-pp.get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.98            -1.2        1.78        perf-profile.calltrace.cycles-pp.thp_get_unmapped_area.get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64
      2.75            -1.1        1.64        perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.thp_get_unmapped_area.get_unmapped_area.do_mmap.vm_mmap_pgoff
      2.60            -1.0        1.55        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      3.00            -1.0        1.96        perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      2.35            -1.0        1.37        perf-profile.calltrace.cycles-pp.mas_topiary_replace.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap
      2.31            -0.9        1.37        perf-profile.calltrace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown.thp_get_unmapped_area.get_unmapped_area.do_mmap
      2.29            -0.9        1.37        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      2.16            -0.9        1.24        perf-profile.calltrace.cycles-pp.mas_topiary_replace.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      2.54            -0.9        1.66        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      2.01            -0.8        1.19        perf-profile.calltrace.cycles-pp.free_pgd_range.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      2.04            -0.8        1.25        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__mmap
      2.05            -0.8        1.25        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__munmap
      5.22            -0.8        4.43 ±  3%  perf-profile.calltrace.cycles-pp.mas_nomem.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.83            -0.7        1.09        perf-profile.calltrace.cycles-pp.free_p4d_range.free_pgd_range.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.99            -0.7        2.25        perf-profile.calltrace.cycles-pp.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      5.12            -0.7        4.38 ±  3%  perf-profile.calltrace.cycles-pp.mas_destroy.mas_nomem.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      0.99 ± 19%      -0.7        0.26 ±100%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__put_partials
      1.60            -0.7        0.94        perf-profile.calltrace.cycles-pp.mast_fill_bnode.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      1.58            -0.6        0.94        perf-profile.calltrace.cycles-pp.free_pud_range.free_p4d_range.free_pgd_range.unmap_region.do_vmi_align_munmap
      1.65            -0.6        1.02        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__mmap
      1.65            -0.6        1.03        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__munmap
      1.53            -0.6        0.92        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      1.38            -0.6        0.82        perf-profile.calltrace.cycles-pp.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.thp_get_unmapped_area.get_unmapped_area
      2.42            -0.5        1.91 ±  2%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff
      1.11            -0.5        0.64        perf-profile.calltrace.cycles-pp.mast_split_data.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.88            -0.5        0.42 ± 44%  perf-profile.calltrace.cycles-pp.mab_mas_cp.mast_split_data.mas_split.mas_wr_bnode.mas_store_prealloc
      2.64 ±  2%      -0.4        2.21 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free_bulk.mas_destroy.mas_nomem.mas_store_gfp.do_vmi_align_munmap
      1.04            -0.4        0.61        perf-profile.calltrace.cycles-pp.mas_rev_awalk.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.thp_get_unmapped_area
      1.07            -0.4        0.66        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.94            -0.4        0.54        perf-profile.calltrace.cycles-pp.mas_store_b_node.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap
      0.86            -0.4        0.51        perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.29            -0.3        0.97        perf-profile.calltrace.cycles-pp.mab_mas_cp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap
      0.97            -0.3        0.66 ±  2%  perf-profile.calltrace.cycles-pp.mas_split_final_node.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.55            -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free.mas_destroy.mas_nomem
      0.55            -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free.mas_destroy
      0.55            -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free
      0.85            -0.3        0.56        perf-profile.calltrace.cycles-pp.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.82            -0.3        0.56 ±  2%  perf-profile.calltrace.cycles-pp.mas_destroy.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.69            -0.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.mas_pop_node.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      1.82            -0.3        1.56 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap
      1.77 ±  2%      -0.2        1.58 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_free.mas_destroy.mas_nomem.mas_store_gfp.do_vmi_align_munmap
      1.52 ±  2%      -0.1        1.39 ±  3%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.mmap_region
      0.62            -0.0        0.59 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.__do_softirq
      0.92            +0.0        0.96 ±  2%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes
      0.85 ±  4%      +0.2        1.01 ±  2%  perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      1.44 ±  2%      +0.2        1.68 ±  2%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_partial_node
      1.44 ±  2%      +0.2        1.69 ±  3%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_partial_node.___slab_alloc
      1.44 ±  2%      +0.3        1.70 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk
      1.44 ±  2%      +0.3        1.70 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk
      1.24 ±  2%      +0.3        1.59 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq.irq_exit_rcu
      8.54            +0.4        8.89 ±  2%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      8.10            +0.5        8.64 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap
      7.92            +0.6        8.53 ±  2%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp
      7.30            +0.9        8.16 ±  2%  perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_wr_spanning_store
      1.85            +1.1        2.93 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.rcu_do_batch
      1.88            +1.1        2.96 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core
      3.44 ±  2%      +2.1        5.51 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk
      3.40 ±  2%      +2.1        5.49 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk
      5.40 ±  2%      +2.3        7.66 ±  3%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes
      6.49            +3.1        9.58 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch
      9.25            +3.1       12.33 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq
      6.61            +3.1        9.72 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core
      0.65 ±  8%     +10.4       11.04 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.kmem_cache_free
      0.70 ±  8%     +10.4       11.12 ±  3%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.kmem_cache_free.rcu_do_batch
      0.73 ±  7%     +10.5       11.18 ±  3%  perf-profile.calltrace.cycles-pp.free_unref_page.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq
      0.71 ±  8%     +10.5       11.16 ±  3%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.kmem_cache_free.rcu_do_batch.rcu_core
      0.84 ±  7%     +13.3       14.15 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__put_partials
      0.91 ±  6%     +13.4       14.26 ±  3%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__put_partials.kmem_cache_free
      0.92 ±  6%     +13.4       14.32 ±  3%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.__put_partials.kmem_cache_free.rcu_do_batch
      0.94 ±  6%     +13.4       14.34 ±  3%  perf-profile.calltrace.cycles-pp.free_unref_page.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core
      2.95           +15.1       18.08        perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq
      1.45 ±  7%     +23.6       25.09 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page
     13.04           +28.0       40.99        perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
     15.02           +28.1       43.09        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     15.02           +28.1       43.09        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     15.02           +28.1       43.09        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     14.98           +28.1       43.06        perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
     14.96           +28.1       43.04        perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
     14.98           +28.1       43.06        perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     14.98           +28.1       43.06        perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     15.00           +28.1       43.08        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     73.58           -23.7       49.89        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     71.25           -22.8       48.46        perf-profile.children.cycles-pp.do_syscall_64
     48.23           -14.2       34.00        perf-profile.children.cycles-pp.__munmap
     36.32           -13.9       22.44        perf-profile.children.cycles-pp.__mmap
     41.03           -11.4       29.66        perf-profile.children.cycles-pp.do_vmi_munmap
     40.90           -11.3       29.58        perf-profile.children.cycles-pp.__x64_sys_munmap
     40.79           -11.3       29.52        perf-profile.children.cycles-pp.__vm_munmap
     28.87           -10.9       18.00        perf-profile.children.cycles-pp.vm_mmap_pgoff
     39.53           -10.8       28.78        perf-profile.children.cycles-pp.do_vmi_align_munmap
     27.55           -10.3       17.22        perf-profile.children.cycles-pp.do_mmap
     23.89            -8.9       15.04        perf-profile.children.cycles-pp.mmap_region
     12.45            -5.1        7.37        perf-profile.children.cycles-pp.unmap_region
     11.65            -4.5        7.11        perf-profile.children.cycles-pp.mas_store_prealloc
     24.04            -4.4       19.64        perf-profile.children.cycles-pp.mas_store_gfp
     10.32            -4.1        6.26        perf-profile.children.cycles-pp.mas_wr_bnode
     10.22            -4.0        6.24 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     10.25            -4.0        6.28        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      9.84            -3.9        5.93 ±  2%  perf-profile.children.cycles-pp.irq_exit_rcu
      9.14            -3.7        5.39        perf-profile.children.cycles-pp.unmap_vmas
      8.78            -3.6        5.18        perf-profile.children.cycles-pp.unmap_page_range
      8.73            -3.4        5.34        perf-profile.children.cycles-pp.mas_split
      8.20            -3.4        4.84        perf-profile.children.cycles-pp.zap_pmd_range
     18.05            -3.3       14.75        perf-profile.children.cycles-pp.mas_wr_spanning_store
      6.49            -2.4        4.04        perf-profile.children.cycles-pp.mas_spanning_rebalance
      4.54            -1.9        2.62        perf-profile.children.cycles-pp.mas_topiary_replace
      4.66            -1.9        2.75        perf-profile.children.cycles-pp.__cond_resched
      4.13            -1.6        2.52        perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.37            -1.4        2.01        perf-profile.children.cycles-pp.get_unmapped_area
      3.54            -1.4        2.19        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.34 ±  3%      -1.3        0.07 ±  5%  perf-profile.children.cycles-pp.get_any_partial
      2.98            -1.2        1.78        perf-profile.children.cycles-pp.thp_get_unmapped_area
      3.35            -1.2        2.16        perf-profile.children.cycles-pp.kmem_cache_alloc
      2.77            -1.1        1.65        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      2.60            -1.0        1.56        perf-profile.children.cycles-pp.perf_event_mmap
      3.01            -1.0        1.96        perf-profile.children.cycles-pp.vm_area_alloc
      5.97            -1.0        4.94 ±  3%  perf-profile.children.cycles-pp.mas_destroy
      2.32            -0.9        1.38        perf-profile.children.cycles-pp.vm_unmapped_area
      2.33            -0.9        1.39        perf-profile.children.cycles-pp.perf_event_mmap_event
      2.13            -0.9        1.26        perf-profile.children.cycles-pp.mas_find
      2.71            -0.8        1.88        perf-profile.children.cycles-pp.mab_mas_cp
      2.02            -0.8        1.20        perf-profile.children.cycles-pp.free_pgd_range
      1.94            -0.8        1.14        perf-profile.children.cycles-pp.mas_mab_cp
      5.24            -0.8        4.44 ±  3%  perf-profile.children.cycles-pp.mas_nomem
      1.66            -0.8        0.90        perf-profile.children.cycles-pp.__call_rcu_common
      3.02            -0.8        2.26        perf-profile.children.cycles-pp.mas_preallocate
      1.84            -0.7        1.10        perf-profile.children.cycles-pp.free_p4d_range
      1.87            -0.7        1.13        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.61            -0.7        0.95        perf-profile.children.cycles-pp.mast_fill_bnode
      1.59            -0.6        0.94        perf-profile.children.cycles-pp.free_pud_range
      1.54            -0.6        0.92        perf-profile.children.cycles-pp.perf_iterate_sb
      1.41            -0.6        0.82        perf-profile.children.cycles-pp.mas_store_b_node
      1.42            -0.6        0.84        perf-profile.children.cycles-pp.mas_empty_area_rev
      1.24            -0.5        0.74        perf-profile.children.cycles-pp.rcu_all_qs
      1.46            -0.5        0.98        perf-profile.children.cycles-pp.mas_pop_node
      1.12            -0.5        0.65        perf-profile.children.cycles-pp.mast_split_data
      1.46            -0.5        1.00        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      2.66 ±  2%      -0.4        2.22 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      1.08            -0.4        0.64        perf-profile.children.cycles-pp.mas_walk
      1.04            -0.4        0.62        perf-profile.children.cycles-pp.mas_rev_awalk
      1.08            -0.4        0.66        perf-profile.children.cycles-pp.perf_event_mmap_output
      0.95            -0.4        0.58 ±  2%  perf-profile.children.cycles-pp.memcpy_orig
      0.75            -0.3        0.43        perf-profile.children.cycles-pp.mtree_range_walk
      0.98            -0.3        0.66        perf-profile.children.cycles-pp.mas_split_final_node
      0.75            -0.3        0.44        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.86            -0.3        0.57        perf-profile.children.cycles-pp.mas_push_data
      0.70            -0.3        0.41        perf-profile.children.cycles-pp.security_mmap_file
      1.48 ±  3%      -0.3        1.18 ±  2%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.66            -0.3        0.39        perf-profile.children.cycles-pp.mas_next_slot
      0.70            -0.3        0.42        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.66            -0.3        0.38        perf-profile.children.cycles-pp.mas_prev_slot
      0.64            -0.3        0.37        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.59            -0.2        0.34        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.57            -0.2        0.34 ±  2%  perf-profile.children.cycles-pp.mas_wr_walk_index
      0.53            -0.2        0.30        perf-profile.children.cycles-pp.build_detached_freelist
      0.50            -0.2        0.31        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.44            -0.2        0.26        perf-profile.children.cycles-pp.mas_wr_walk
      0.39            -0.2        0.22 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.43            -0.2        0.26        perf-profile.children.cycles-pp.free_pgtables
      0.44            -0.2        0.27        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.36            -0.2        0.22 ±  2%  perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.36 ±  2%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.down_write_killable
      0.36            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.mas_next_sibling
      0.31            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.mas_ascend
      0.30            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.32 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.down_write
      0.29 ±  3%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.up_write
      0.31 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.36            -0.1        0.25        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.26 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.security_mmap_addr
      0.24 ±  3%      -0.1        0.15 ±  2%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.23 ±  2%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.vma_set_page_prot
      0.22 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.mt_free_rcu
      0.21 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.vm_get_page_prot
      0.22 ±  2%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.mas_prev_range
      0.85            -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.shuffle_freelist
      0.19 ±  3%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.mas_prev
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.remove_vma
      0.39 ±  2%      -0.1        0.32        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.39 ±  2%      -0.1        0.32        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.16 ±  3%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.testcase
      0.16 ±  3%      -0.1        0.09        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.16 ±  2%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.sized_strscpy
      0.16 ±  3%      -0.1        0.09        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.16 ±  3%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.strnlen
      0.34 ±  3%      -0.1        0.28        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.14 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.lru_add_drain
      0.28 ±  3%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.13 ±  3%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.ima_file_mmap
      0.16 ±  3%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.should_failslab
      0.13 ±  3%      -0.1        0.07        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.17 ±  2%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.current_obj_cgroup
      0.13 ±  3%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.mab_calc_split
      0.11 ±  5%      -0.1        0.06        perf-profile.children.cycles-pp.put_cpu_partial
      0.12            -0.0        0.07        perf-profile.children.cycles-pp.mas_wr_store_setup
      0.07 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.unmap_single_vma
      0.25 ±  3%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.11            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.downgrade_write
      0.12 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.mas_data_end
      0.12 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.mas_next
      0.11 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.apparmor_mmap_file
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.cap_mmap_addr
      0.11 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.10            -0.0        0.06        perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.10 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.10 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.may_expand_vm
      0.08            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.09 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.mas_next_range
      0.10 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.cap_mmap_file
      0.09 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__memcpy
      0.09 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__x64_sys_mmap
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.mas_prev_setup
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.refill_obj_stock
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__vm_enough_memory
      0.10 ±  3%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.kfree
      0.08 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.up_read
      0.12            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.discard_slab
      0.16 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__free_one_page
      1.26            +0.1        1.32 ±  2%  perf-profile.children.cycles-pp.allocate_slab
      0.17 ±  2%      +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.rmqueue
      0.13 ±  2%      +0.1        0.26 ±  7%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.10 ±  4%      +0.1        0.25 ±  6%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.31 ±  2%      +0.2        0.46 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      0.27 ±  2%      +0.2        0.42 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.5        0.46 ±  3%  perf-profile.children.cycles-pp.perf_c2c__record
      0.04 ± 44%      +0.5        0.50 ±  2%  perf-profile.children.cycles-pp.main
      0.04 ± 44%      +0.5        0.50 ±  2%  perf-profile.children.cycles-pp.run_builtin
      9.45            +0.5        9.92 ±  2%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.02 ±141%      +0.5        0.50 ±  2%  perf-profile.children.cycles-pp.cmd_record
      9.06            +0.8        9.81 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      6.60 ±  2%      +1.1        7.69 ±  3%  perf-profile.children.cycles-pp.get_partial_node
      8.58           +14.3       22.89        perf-profile.children.cycles-pp.__put_partials
     24.83           +24.2       49.03        perf-profile.children.cycles-pp.__do_softirq
     24.81           +24.2       49.02        perf-profile.children.cycles-pp.rcu_core
     24.80           +24.2       49.01        perf-profile.children.cycles-pp.rcu_do_batch
     24.97           +24.3       49.31        perf-profile.children.cycles-pp.kmem_cache_free
      2.44 ±  5%     +24.8       27.19 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
      2.55 ±  5%     +24.8       27.36 ±  3%  perf-profile.children.cycles-pp.free_unref_page
      2.49 ±  5%     +24.8       27.32 ±  3%  perf-profile.children.cycles-pp.free_unref_page_commit
     15.02           +28.1       43.09        perf-profile.children.cycles-pp.kthread
     15.02           +28.1       43.09        perf-profile.children.cycles-pp.ret_from_fork
     15.02           +28.1       43.09        perf-profile.children.cycles-pp.ret_from_fork_asm
     14.98           +28.1       43.06        perf-profile.children.cycles-pp.run_ksoftirqd
     15.00           +28.1       43.08        perf-profile.children.cycles-pp.smpboot_thread_fn
     22.12           +28.3       50.41        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     21.74           +28.3       50.06        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.12            -1.6        2.52        perf-profile.self.cycles-pp.syscall_return_via_sysret
      4.04            -1.6        2.47        perf-profile.self.cycles-pp.zap_pmd_range
      4.82            -1.4        3.41        perf-profile.self.cycles-pp.__slab_free
      3.50            -1.3        2.17        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.13            -1.2        1.88        perf-profile.self.cycles-pp.__cond_resched
      2.93            -1.2        1.77        perf-profile.self.cycles-pp.mas_topiary_replace
      2.38            -0.9        1.45        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.94            -0.8        1.16        perf-profile.self.cycles-pp.kmem_cache_free
      1.64            -0.6        0.99        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.51            -0.6        0.93        perf-profile.self.cycles-pp.mas_wr_spanning_store
      2.01            -0.6        1.45        perf-profile.self.cycles-pp.mab_mas_cp
      1.41            -0.6        0.85        perf-profile.self.cycles-pp.mas_mab_cp
      1.45            -0.6        0.89        perf-profile.self.cycles-pp.free_pud_range
      1.25            -0.5        0.79 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      1.01            -0.4        0.56        perf-profile.self.cycles-pp.__call_rcu_common
      1.14            -0.4        0.71        perf-profile.self.cycles-pp.mas_spanning_rebalance
      1.30            -0.4        0.90        perf-profile.self.cycles-pp.mas_pop_node
      0.94            -0.4        0.57        perf-profile.self.cycles-pp.mas_walk
      0.97            -0.4        0.61        perf-profile.self.cycles-pp.perf_event_mmap_output
      0.86            -0.3        0.52        perf-profile.self.cycles-pp.mas_rev_awalk
      0.87            -0.3        0.54        perf-profile.self.cycles-pp.rcu_all_qs
      0.85            -0.3        0.52        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.84            -0.3        0.51        perf-profile.self.cycles-pp.mast_fill_bnode
      0.83            -0.3        0.51        perf-profile.self.cycles-pp.mmap_region
      0.78            -0.3        0.47        perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.84            -0.3        0.53 ±  2%  perf-profile.self.cycles-pp.memcpy_orig
      0.73            -0.3        0.44        perf-profile.self.cycles-pp.mas_split
      1.45 ±  3%      -0.3        1.17 ±  2%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.66            -0.3        0.40        perf-profile.self.cycles-pp.mtree_range_walk
      0.60            -0.2        0.36        perf-profile.self.cycles-pp.mas_find
      0.92            -0.2        0.69        perf-profile.self.cycles-pp.___slab_alloc
      0.60            -0.2        0.36        perf-profile.self.cycles-pp.mas_prev_slot
      0.59            -0.2        0.35        perf-profile.self.cycles-pp.mas_wr_bnode
      0.59            -0.2        0.36 ±  2%  perf-profile.self.cycles-pp.mas_next_slot
      0.53            -0.2        0.32        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.52            -0.2        0.32        perf-profile.self.cycles-pp.mas_wr_walk_index
      0.48            -0.2        0.28 ±  2%  perf-profile.self.cycles-pp.build_detached_freelist
      0.50            -0.2        0.31 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.46            -0.2        0.28 ±  2%  perf-profile.self.cycles-pp.unmap_page_range
      0.42 ±  2%      -0.2        0.25 ±  2%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.43            -0.2        0.27 ±  2%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.40            -0.2        0.24        perf-profile.self.cycles-pp.mas_wr_walk
      0.40            -0.2        0.25 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.38            -0.2        0.23        perf-profile.self.cycles-pp.kmem_cache_alloc_bulk
      0.34            -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.36            -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.vm_unmapped_area
      0.38            -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.36            -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.mas_store_gfp
      0.36            -0.1        0.22        perf-profile.self.cycles-pp.perf_event_mmap_event
      0.36            -0.1        0.23        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
      0.33 ±  2%      -0.1        0.20        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.33            -0.1        0.20        perf-profile.self.cycles-pp.security_mmap_file
      0.33            -0.1        0.20        perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.44            -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.mas_push_data
      0.34            -0.1        0.21        perf-profile.self.cycles-pp.mas_empty_area_rev
      0.32            -0.1        0.19        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.30            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.mas_store_b_node
      0.27            -0.1        0.15        perf-profile.self.cycles-pp.__mmap
      0.30 ±  2%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.27 ±  2%      -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.__munmap
      0.22 ±  3%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.get_partial_node
      0.27            -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.mas_ascend
      0.27 ±  2%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.mas_preallocate
      0.28 ±  2%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.do_vmi_munmap
      0.24 ±  2%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__vm_munmap
      0.26 ±  2%      -0.1        0.16        perf-profile.self.cycles-pp.do_mmap
      0.26 ±  2%      -0.1        0.16        perf-profile.self.cycles-pp.up_write
      0.25            -0.1        0.15        perf-profile.self.cycles-pp.vm_area_alloc
      0.24            -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.unmap_region
      0.14            -0.1        0.05        perf-profile.self.cycles-pp.get_any_partial
      0.23            -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap
      0.21 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.mt_free_rcu
      0.22            -0.1        0.13 ±  2%  perf-profile.self.cycles-pp.mas_destroy
      0.22 ±  2%      -0.1        0.14        perf-profile.self.cycles-pp.free_p4d_range
      0.22 ±  2%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.mas_next_sibling
      0.19 ±  3%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.vm_get_page_prot
      0.20 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.down_write_killable
      0.21 ±  2%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.20 ±  2%      -0.1        0.12        perf-profile.self.cycles-pp.mast_split_data
      0.38 ±  2%      -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.18 ±  3%      -0.1        0.11        perf-profile.self.cycles-pp.free_pgtables
      0.19            -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.thp_get_unmapped_area
      0.19            -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.vm_mmap_pgoff
      0.19 ±  2%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.17 ±  2%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.mas_split_final_node
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.16 ±  2%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.mas_store_prealloc
      0.17 ±  2%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.unmap_vmas
      0.16            -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.free_pgd_range
      0.20 ±  2%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.down_write
      0.17 ±  4%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__put_partials
      0.15 ±  3%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.rcu_do_batch
      0.14            -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.security_mmap_addr
      0.14 ±  3%      -0.1        0.08        perf-profile.self.cycles-pp.tlb_gather_mmu
      0.14 ±  3%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.strnlen
      0.13 ±  3%      -0.1        0.08        perf-profile.self.cycles-pp.mas_prev_range
      0.13 ±  5%      -0.1        0.08        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.11 ±  4%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.put_cpu_partial
      0.13 ±  2%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.current_obj_cgroup
      0.13            -0.1        0.08        perf-profile.self.cycles-pp.sized_strscpy
      0.13 ±  2%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.get_unmapped_area
      0.12 ±  3%      -0.0        0.07        perf-profile.self.cycles-pp.ima_file_mmap
      0.12            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mas_prev
      0.11            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.10 ±  3%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.downgrade_write
      0.10            -0.0        0.06        perf-profile.self.cycles-pp.__x64_sys_munmap
      0.10            -0.0        0.06        perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.apparmor_mmap_file
      0.11 ±  3%      -0.0        0.07        perf-profile.self.cycles-pp.mab_calc_split
      0.10 ±  3%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.vma_set_page_prot
      0.07            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.tlb_batch_pages_flush
      0.09 ±  4%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.may_expand_vm
      0.08 ±  6%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.kfree
      0.09 ±  5%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.cap_mmap_file
      0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mas_data_end
      0.38            -0.0        0.35        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.09            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.cap_mmap_addr
      0.09            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.mas_wr_store_setup
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.remove_vma
      0.08 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.refill_obj_stock
      0.08 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.mas_nomem
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.__x64_sys_mmap
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.mas_next
      0.13            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.setup_object
      0.63            -0.0        0.61        perf-profile.self.cycles-pp.shuffle_freelist
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.discard_slab
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.16 ±  3%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__free_one_page
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.free_unref_page_commit
     21.74           +28.3       50.06        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-phoronix/lkp-csl-2sp7/asmfish-1.1.2/phoronix-test-suite

commit: 
  9ef3ad0f03 ("ACPI/NUMA: Print CXL Early Discovery Table (CEDT)")
  09f84589a8 ("ACPI/NUMA: Remove architecture dependent remainings")

9ef3ad0f032818c5 09f84589a8ed1162c0274a1b5b3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     14.98            +1.9%      15.27        boot-time.dhcp
  93848406           -23.9%   71464814        phoronix-test-suite.asmfish.0.nodes_second
      0.06 ± 61%     -64.0%       0.02 ±  8%  vmstat.procs.b
      1183 ± 26%    +689.3%       9337 ±  9%  perf-c2c.DRAM.remote
    112.50 ± 36%   +2692.2%       3141 ± 10%  perf-c2c.HITM.remote
  11131904 ± 13%     -33.9%    7360921 ±  7%  meminfo.DirectMap2M
      1251 ± 31%     +56.6%       1959 ± 19%  meminfo.Mlocked
      4391 ±  8%     +16.1%       5099 ±  7%  meminfo.Unevictable
    260856           -84.1%      41446        meminfo.VmallocUsed
      0.05 ± 11%      -0.0        0.01 ±  4%  mpstat.cpu.all.iowait%
      0.02 ±  3%      -0.0        0.02 ±  6%  mpstat.cpu.all.soft%
      0.06 ±  6%      -0.0        0.04        mpstat.cpu.all.sys%
     31.83 ±  2%     -17.1%      26.40        mpstat.max_utilization.seconds
    986818 ± 45%    -100.0%       0.00        numa-numastat.node0.local_node
   1027333 ± 45%    -100.0%       0.00        numa-numastat.node0.numa_hit
     40474 ± 74%    -100.0%       0.00        numa-numastat.node0.other_node
    968499 ± 58%    -100.0%       0.00        numa-numastat.node1.local_node
   1032398 ± 53%    -100.0%       0.00        numa-numastat.node1.numa_hit
     63895 ± 44%    -100.0%       0.00        numa-numastat.node1.other_node
    313.19 ± 31%     +56.4%     489.72 ± 19%  proc-vmstat.nr_mlock
      2722            -3.0%       2641        proc-vmstat.nr_page_table_pages
     58851            -0.7%      58431        proc-vmstat.nr_slab_unreclaimable
      1098 ±  8%     +16.1%       1274 ±  7%  proc-vmstat.nr_unevictable
      1098 ±  8%     +16.1%       1274 ±  7%  proc-vmstat.nr_zone_unevictable
     49674 ± 59%    -100.0%       0.00        proc-vmstat.numa_hint_faults
     36892 ± 57%    -100.0%       0.00        proc-vmstat.numa_hint_faults_local
   2061577 ± 48%     -34.9%    1342268        proc-vmstat.numa_hit
     14970 ± 76%    -100.0%       0.00        proc-vmstat.numa_huge_pte_updates
   1957163 ± 50%     -31.4%    1342877        proc-vmstat.numa_local
    104370 ±  3%    -100.0%       0.00        proc-vmstat.numa_other
   1784768 ± 75%    -100.0%       0.00        proc-vmstat.numa_pages_migrated
   7772796 ± 75%    -100.0%       0.00        proc-vmstat.numa_pte_updates
   5403170 ± 62%     -54.3%    2470734        proc-vmstat.pgalloc_normal
   2641844 ± 60%     -45.6%    1438131        proc-vmstat.pgfault
   5223988 ± 64%     -56.2%    2290502        proc-vmstat.pgfree
   1784768 ± 75%    -100.0%       0.00        proc-vmstat.pgmigrate_success
     98843 ± 61%     -39.3%      60039 ±  3%  proc-vmstat.pgreuse
      3478 ± 75%    -100.0%       0.00        proc-vmstat.thp_migration_success
    137922 ± 38%    -100.0%       0.00        numa-meminfo.node0.Active
     39195 ± 31%    -100.0%       0.00        numa-meminfo.node0.Active(anon)
     98727 ± 43%    -100.0%       0.00        numa-meminfo.node0.Active(file)
    867525 ± 22%    -100.0%       0.00        numa-meminfo.node0.AnonHugePages
   1116586 ± 19%    -100.0%       0.00        numa-meminfo.node0.AnonPages
   1448118 ± 15%    -100.0%       0.00        numa-meminfo.node0.AnonPages.max
   1414495 ± 62%    -100.0%       0.00        numa-meminfo.node0.FilePages
   2393152 ± 28%    -100.0%       0.00        numa-meminfo.node0.Inactive
   1467103 ± 16%    -100.0%       0.00        numa-meminfo.node0.Inactive(anon)
    926048 ± 78%    -100.0%       0.00        numa-meminfo.node0.Inactive(file)
     42206 ± 33%    -100.0%       0.00        numa-meminfo.node0.KReclaimable
     10393 ±  8%    -100.0%       0.00        numa-meminfo.node0.KernelStack
     84153 ± 30%    -100.0%       0.00        numa-meminfo.node0.Mapped
 2.606e+08          -100.0%       0.00        numa-meminfo.node0.MemFree
 2.638e+08          -100.0%       0.00        numa-meminfo.node0.MemTotal
   3202155 ± 24%    -100.0%       0.00        numa-meminfo.node0.MemUsed
      5609 ± 19%    -100.0%       0.00        numa-meminfo.node0.PageTables
     42206 ± 33%    -100.0%       0.00        numa-meminfo.node0.SReclaimable
    110987 ± 21%    -100.0%       0.00        numa-meminfo.node0.SUnreclaim
    389372 ± 45%    -100.0%       0.00        numa-meminfo.node0.Shmem
    153193 ± 23%    -100.0%       0.00        numa-meminfo.node0.Slab
      3500 ± 14%    -100.0%       0.00        numa-meminfo.node0.Unevictable
    278067 ± 19%    -100.0%       0.00        numa-meminfo.node1.Active
    214635 ±  8%    -100.0%       0.00        numa-meminfo.node1.Active(anon)
     63432 ± 67%    -100.0%       0.00        numa-meminfo.node1.Active(file)
    680824 ± 23%    -100.0%       0.00        numa-meminfo.node1.AnonHugePages
    829328 ± 25%    -100.0%       0.00        numa-meminfo.node1.AnonPages
   1414486 ± 14%    -100.0%       0.00        numa-meminfo.node1.AnonPages.max
   1390641 ± 64%    -100.0%       0.00        numa-meminfo.node1.FilePages
   1942799 ± 35%    -100.0%       0.00        numa-meminfo.node1.Inactive
   1173590 ± 19%    -100.0%       0.00        numa-meminfo.node1.Inactive(anon)
    769209 ± 94%    -100.0%       0.00        numa-meminfo.node1.Inactive(file)
     42052 ± 34%    -100.0%       0.00        numa-meminfo.node1.KReclaimable
     10353 ±  7%    -100.0%       0.00        numa-meminfo.node1.KernelStack
     56786 ± 44%    -100.0%       0.00        numa-meminfo.node1.Mapped
 2.612e+08          -100.0%       0.00        numa-meminfo.node1.MemFree
 2.642e+08          -100.0%       0.00        numa-meminfo.node1.MemTotal
   3009654 ± 26%    -100.0%       0.00        numa-meminfo.node1.MemUsed
      5280 ± 19%    -100.0%       0.00        numa-meminfo.node1.PageTables
     42052 ± 34%    -100.0%       0.00        numa-meminfo.node1.SReclaimable
    124421 ± 19%    -100.0%       0.00        numa-meminfo.node1.SUnreclaim
    557220 ± 32%    -100.0%       0.00        numa-meminfo.node1.Shmem
    166473 ± 22%    -100.0%       0.00        numa-meminfo.node1.Slab
      9797 ± 31%    -100.0%       0.00        numa-vmstat.node0.nr_active_anon
     24680 ± 43%    -100.0%       0.00        numa-vmstat.node0.nr_active_file
    279210 ± 19%    -100.0%       0.00        numa-vmstat.node0.nr_anon_pages
    423.69 ± 22%    -100.0%       0.00        numa-vmstat.node0.nr_anon_transparent_hugepages
    353618 ± 62%    -100.0%       0.00        numa-vmstat.node0.nr_file_pages
  65159849          -100.0%       0.00        numa-vmstat.node0.nr_free_pages
    366837 ± 16%    -100.0%       0.00        numa-vmstat.node0.nr_inactive_anon
    231510 ± 78%    -100.0%       0.00        numa-vmstat.node0.nr_inactive_file
     10394 ±  8%    -100.0%       0.00        numa-vmstat.node0.nr_kernel_stack
     21187 ± 29%    -100.0%       0.00        numa-vmstat.node0.nr_mapped
      1402 ± 19%    -100.0%       0.00        numa-vmstat.node0.nr_page_table_pages
     97341 ± 45%    -100.0%       0.00        numa-vmstat.node0.nr_shmem
     10551 ± 33%    -100.0%       0.00        numa-vmstat.node0.nr_slab_reclaimable
     27747 ± 21%    -100.0%       0.00        numa-vmstat.node0.nr_slab_unreclaimable
    875.15 ± 14%    -100.0%       0.00        numa-vmstat.node0.nr_unevictable
      9797 ± 31%    -100.0%       0.00        numa-vmstat.node0.nr_zone_active_anon
     24680 ± 43%    -100.0%       0.00        numa-vmstat.node0.nr_zone_active_file
    366837 ± 16%    -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_anon
    231510 ± 78%    -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_file
    875.15 ± 14%    -100.0%       0.00        numa-vmstat.node0.nr_zone_unevictable
   1027333 ± 45%    -100.0%       0.00        numa-vmstat.node0.numa_hit
    986816 ± 45%    -100.0%       0.00        numa-vmstat.node0.numa_local
     40474 ± 74%    -100.0%       0.00        numa-vmstat.node0.numa_other
     53643 ±  8%    -100.0%       0.00        numa-vmstat.node1.nr_active_anon
     15857 ± 67%    -100.0%       0.00        numa-vmstat.node1.nr_active_file
    207230 ± 25%    -100.0%       0.00        numa-vmstat.node1.nr_anon_pages
    332.22 ± 23%    -100.0%       0.00        numa-vmstat.node1.nr_anon_transparent_hugepages
    347657 ± 64%    -100.0%       0.00        numa-vmstat.node1.nr_file_pages
  65294238          -100.0%       0.00        numa-vmstat.node1.nr_free_pages
    293307 ± 19%    -100.0%       0.00        numa-vmstat.node1.nr_inactive_anon
    192302 ± 94%    -100.0%       0.00        numa-vmstat.node1.nr_inactive_file
     10354 ±  7%    -100.0%       0.00        numa-vmstat.node1.nr_kernel_stack
     14315 ± 43%    -100.0%       0.00        numa-vmstat.node1.nr_mapped
      1320 ± 19%    -100.0%       0.00        numa-vmstat.node1.nr_page_table_pages
    139303 ± 32%    -100.0%       0.00        numa-vmstat.node1.nr_shmem
     10512 ± 34%    -100.0%       0.00        numa-vmstat.node1.nr_slab_reclaimable
     31105 ± 19%    -100.0%       0.00        numa-vmstat.node1.nr_slab_unreclaimable
     53643 ±  8%    -100.0%       0.00        numa-vmstat.node1.nr_zone_active_anon
     15857 ± 67%    -100.0%       0.00        numa-vmstat.node1.nr_zone_active_file
    293306 ± 19%    -100.0%       0.00        numa-vmstat.node1.nr_zone_inactive_anon
    192302 ± 94%    -100.0%       0.00        numa-vmstat.node1.nr_zone_inactive_file
   1032447 ± 53%    -100.0%       0.00        numa-vmstat.node1.numa_hit
    968548 ± 57%    -100.0%       0.00        numa-vmstat.node1.numa_local
     63895 ± 44%    -100.0%       0.00        numa-vmstat.node1.numa_other
      2.01 ±  5%     -10.8%       1.80 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ± 25%     -31.8%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.24 ± 20%     -28.4%       0.17 ± 20%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      0.00 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.migration_entry_wait_on_locked.migration_entry_wait.do_swap_page
      0.02 ±  4%     +12.1%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  2%     +21.2%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 50%     -35.5%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.do_epoll_pwait.part
      0.02 ±  4%     +21.3%       0.02 ±  4%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ± 19%     -28.6%       0.02 ± 17%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.91           -21.9%       3.05 ± 23%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      0.02 ± 33%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.migration_entry_wait_on_locked.migration_entry_wait.do_swap_page
      0.32 ±208%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.01 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.03 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      2.31 ± 31%     -55.0%       1.04 ± 98%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     65.46 ±  6%     -15.5%      55.34 ±  2%  perf-sched.total_wait_and_delay.average.ms
     65.43 ±  6%     -15.5%      55.31 ±  2%  perf-sched.total_wait_time.average.ms
      2.01 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      3.39 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.62 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      0.15 ± 11%     -18.2%       0.13 ±  3%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     51.61 ±  7%     -12.3%      45.26 ±  6%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.59 ± 16%     -28.0%       2.58 ± 21%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.do_epoll_pwait.part
      2.44 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     18.95 ±  4%     +50.7%      28.56 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    494.08           +11.4%     550.61        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     37.67 ± 18%     -50.1%      18.80 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    104.50 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    124.83           -48.7%      64.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    114.67 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    749.83 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      1323 ±  6%     -26.3%     975.20 ±  8%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      1427 ± 14%     +50.1%       2143 ± 10%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.do_epoll_pwait.part
     86.17          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     19.83           -51.6%       9.60 ±  5%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    254.33 ±  5%     -33.6%     168.80 ±  5%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    854.17           -10.1%     768.00        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    574.00 ±  7%     -41.3%     336.80 ±  9%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.93          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     47.29 ± 55%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2.88 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
     31.00 ± 94%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    288.79 ±116%     -98.7%       3.87 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.61 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      0.07 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.migration_entry_wait_on_locked.migration_entry_wait.do_swap_page
      0.15 ± 11%     -18.1%       0.13 ±  3%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     51.58 ±  7%     -12.7%      45.03 ±  7%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.57 ± 16%     -28.0%       2.57 ± 21%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.do_epoll_pwait.part
      2.17 ± 18%     +49.0%       3.23 ± 18%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     18.94 ±  4%     +50.7%      28.54 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    494.06           +11.4%     550.60        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.87 ± 19%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      0.74 ± 86%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.migration_entry_wait_on_locked.migration_entry_wait.do_swap_page
      4.83 ± 14%     -33.7%       3.21 ± 49%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.86          +113.9%       1.84        perf-stat.i.MPKI
 2.197e+10           -22.8%  1.697e+10        perf-stat.i.branch-instructions
      8.68            -0.2        8.52        perf-stat.i.branch-miss-rate%
   1.9e+09           -23.3%  1.458e+09        perf-stat.i.branch-misses
     27.65           +23.9       51.52        perf-stat.i.cache-miss-rate%
 1.621e+08           +77.1%  2.871e+08        perf-stat.i.cache-misses
  5.87e+08            -7.6%  5.422e+08        perf-stat.i.cache-references
      1.16           +38.1%       1.60        perf-stat.i.cpi
 2.225e+11            +7.5%  2.393e+11        perf-stat.i.cpu-cycles
    154.02           -16.1%     129.22        perf-stat.i.cpu-migrations
      1391           -38.3%     857.88        perf-stat.i.cycles-between-cache-misses
      0.06 ±  4%      -0.0        0.05 ±  8%  perf-stat.i.dTLB-load-miss-rate%
  16519218 ±  3%     -27.0%   12056970 ± 11%  perf-stat.i.dTLB-load-misses
 6.726e+10           -22.7%  5.201e+10        perf-stat.i.dTLB-loads
    325201           -12.1%     285915 ±  3%  perf-stat.i.dTLB-store-misses
 2.069e+10           -22.8%  1.597e+10        perf-stat.i.dTLB-stores
   1471789            -7.6%    1360644 ±  2%  perf-stat.i.iTLB-load-misses
 2.235e+11           -22.7%  1.728e+11        perf-stat.i.instructions
    161257           -16.2%     135135        perf-stat.i.instructions-per-iTLB-miss
      0.98           -26.7%       0.72        perf-stat.i.ipc
      2.32            +7.5%       2.49        perf-stat.i.metric.GHz
    316.36          +194.6%     931.87        perf-stat.i.metric.K/sec
      1151           -22.6%     890.51        perf-stat.i.metric.M/sec
      3133 ±  4%     -46.7%       1669        perf-stat.i.minor-faults
     27.70           +52.6       80.31        perf-stat.i.node-load-miss-rate%
   5227534 ±  2%    +993.2%   57147855        perf-stat.i.node-load-misses
  15752155           -13.8%   13581362        perf-stat.i.node-loads
     51.43           +41.3       92.70        perf-stat.i.node-store-miss-rate%
   2278574          +614.2%   16272457 ±  2%  perf-stat.i.node-store-misses
   2080120           -48.2%    1078354        perf-stat.i.node-stores
      3133 ±  4%     -46.7%       1669        perf-stat.i.page-faults
      0.73          +129.0%       1.66        perf-stat.overall.MPKI
     27.63           +25.3       52.96        perf-stat.overall.cache-miss-rate%
      1.00           +39.1%       1.38        perf-stat.overall.cpi
      1372           -39.3%     833.36        perf-stat.overall.cycles-between-cache-misses
      0.00            +0.0        0.00 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
    151892           -16.2%     127248 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      1.00           -28.1%       0.72        perf-stat.overall.ipc
     24.91           +55.9       80.79        perf-stat.overall.node-load-miss-rate%
     52.27           +41.5       93.78        perf-stat.overall.node-store-miss-rate%
 2.194e+10           -22.7%  1.696e+10        perf-stat.ps.branch-instructions
 1.898e+09           -23.2%  1.457e+09        perf-stat.ps.branch-misses
 1.619e+08           +77.2%  2.869e+08        perf-stat.ps.cache-misses
  5.86e+08            -7.6%  5.417e+08        perf-stat.ps.cache-references
 2.222e+11            +7.6%  2.391e+11        perf-stat.ps.cpu-cycles
    153.79           -16.1%     128.97        perf-stat.ps.cpu-migrations
  16497488 ±  3%     -26.9%   12054157 ± 11%  perf-stat.ps.dTLB-load-misses
 6.717e+10           -22.6%  5.198e+10        perf-stat.ps.dTLB-loads
    324755           -12.1%     285616 ±  3%  perf-stat.ps.dTLB-store-misses
 2.066e+10           -22.8%  1.596e+10        perf-stat.ps.dTLB-stores
   1469530            -7.6%    1358463 ±  2%  perf-stat.ps.iTLB-load-misses
 2.232e+11           -22.6%  1.727e+11        perf-stat.ps.instructions
      3129 ±  4%     -46.8%       1664        perf-stat.ps.minor-faults
   5220451 ±  2%    +993.6%   57090593        perf-stat.ps.node-load-misses
  15736071           -13.8%   13570457        perf-stat.ps.node-loads
   2275264          +614.3%   16251080 ±  2%  perf-stat.ps.node-store-misses
   2077508           -48.1%    1077622        perf-stat.ps.node-stores
      3129 ±  4%     -46.8%       1664        perf-stat.ps.page-faults
      2.84 ± 72%      -2.5        0.34 ± 82%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.78 ± 74%      -2.4        0.33 ± 81%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      9.33 ±  6%      -1.9        7.45 ±  8%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.96 ± 12%      -0.4        0.55 ± 54%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.38 ± 11%      -0.3        1.12 ±  8%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.50 ± 46%      +0.4        0.87 ±  8%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.50 ± 46%      +0.4        0.87 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.50 ± 46%      +0.4        0.87 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.71 ±  5%      +0.4        3.09 ±  3%  perf-profile.calltrace.cycles-pp.__update_load_avg_se.update_load_avg.task_tick_fair.scheduler_tick.update_process_times
      0.52 ± 46%      +0.5        1.03 ± 28%  perf-profile.calltrace.cycles-pp.hrtimer_forward.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      7.24 ±  6%      +0.7        7.92 ±  5%  perf-profile.calltrace.cycles-pp.update_load_avg.task_tick_fair.scheduler_tick.update_process_times.tick_nohz_handler
      3.41 ± 12%      +1.5        4.91 ± 13%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
     18.04 ±  4%      +1.8       19.80 ±  5%  perf-profile.calltrace.cycles-pp.task_tick_fair.scheduler_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      3.34 ± 61%      -2.5        0.87 ±  9%  perf-profile.children.cycles-pp.asm_exc_page_fault
      3.19 ± 65%      -2.4        0.75 ±  7%  perf-profile.children.cycles-pp.exc_page_fault
      3.18 ± 65%      -2.4        0.74 ±  6%  perf-profile.children.cycles-pp.do_user_addr_fault
      3.09 ± 68%      -2.4        0.68 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
      3.02 ± 69%      -2.4        0.63 ±  8%  perf-profile.children.cycles-pp.__handle_mm_fault
      9.34 ±  6%      -1.9        7.45 ±  8%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.99 ± 12%      -0.3        0.69 ± 24%  perf-profile.children.cycles-pp.rcu_core
      1.40 ± 13%      -0.3        1.15 ±  7%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.46 ± 29%      -0.2        0.24 ± 23%  perf-profile.children.cycles-pp.check_cpu_stall
      0.49 ± 16%      -0.2        0.32 ± 28%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.26 ± 33%      -0.2        0.09 ± 57%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.48 ± 16%      -0.2        0.32 ± 27%  perf-profile.children.cycles-pp.do_mmap
      0.44 ± 20%      -0.2        0.28 ± 20%  perf-profile.children.cycles-pp.setlocale
      0.36 ± 21%      -0.1        0.21 ± 33%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.36 ± 19%      -0.1        0.22 ± 22%  perf-profile.children.cycles-pp.do_read_fault
      0.19 ± 11%      -0.1        0.09 ± 64%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.42 ± 17%      -0.1        0.32 ± 24%  perf-profile.children.cycles-pp.do_fault
      0.28 ± 26%      -0.1        0.18 ± 18%  perf-profile.children.cycles-pp.avg_vruntime
      0.36 ± 16%      -0.1        0.27 ±  7%  perf-profile.children.cycles-pp.exit_mm
      0.28 ± 16%      -0.1        0.19 ± 36%  perf-profile.children.cycles-pp.__open64_nocancel
      0.14 ± 18%      -0.1        0.06 ± 30%  perf-profile.children.cycles-pp.__mmap
      0.12 ± 25%      -0.1        0.04 ± 86%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.15 ± 48%      -0.1        0.08 ± 25%  perf-profile.children.cycles-pp.__cond_resched
      0.03 ±102%      +0.1        0.12 ± 33%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.26 ± 33%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.worker_thread
      0.05 ± 71%      +0.1        0.15 ± 20%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.05 ± 75%      +0.1        0.16 ± 20%  perf-profile.children.cycles-pp.security_file_permission
      0.06 ± 74%      +0.1        0.16 ± 20%  perf-profile.children.cycles-pp.rw_verify_area
      0.08 ± 14%      +0.2        0.24 ± 30%  perf-profile.children.cycles-pp.copy_mc_fragile
      0.06 ± 87%      +0.2        0.22 ± 32%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.06 ± 87%      +0.2        0.22 ± 32%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.06 ± 92%      +0.2        0.22 ± 32%  perf-profile.children.cycles-pp.khugepaged
      0.05 ± 91%      +0.2        0.22 ± 32%  perf-profile.children.cycles-pp.collapse_huge_page
      0.25 ± 26%      +0.2        0.45 ± 26%  perf-profile.children.cycles-pp.update_rq_clock
      0.28 ± 37%      +0.2        0.50 ± 24%  perf-profile.children.cycles-pp.runtime.epollwait.abi0
      0.58 ± 15%      +0.3        0.87 ±  8%  perf-profile.children.cycles-pp.kthread
      0.61 ± 15%      +0.3        0.91 ±  6%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.60 ± 15%      +0.3        0.90 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      1.22 ± 14%      +0.3        1.52 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.20 ± 50%      +0.4        0.55 ± 43%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.71 ±  9%      +0.4        1.11 ± 28%  perf-profile.children.cycles-pp.hrtimer_forward
      2.81 ±  6%      +0.4        3.24 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
     18.15 ±  4%      +1.7       19.88 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      4.84 ±  9%      +4.5        9.33 ± 56%  perf-profile.children.cycles-pp.ktime_get
      8.97 ±  7%      -1.9        7.10 ±  8%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      2.47 ± 12%      -0.8        1.67 ± 41%  perf-profile.self.cycles-pp.update_process_times
      0.46 ± 29%      -0.2        0.24 ± 23%  perf-profile.self.cycles-pp.check_cpu_stall
      0.26 ± 33%      -0.2        0.09 ± 57%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.02 ±142%      +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.perf_poll
      0.13 ± 28%      +0.1        0.22 ± 19%  perf-profile.self.cycles-pp.rebalance_domains
      0.02 ±141%      +0.1        0.12 ± 33%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.08 ± 14%      +0.2        0.24 ± 30%  perf-profile.self.cycles-pp.copy_mc_fragile
      0.70 ± 10%      +0.4        1.09 ± 28%  perf-profile.self.cycles-pp.hrtimer_forward
      2.52 ±  9%      +0.5        2.98 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      3.83 ± 12%      +4.5        8.29 ± 62%  perf-profile.self.cycles-pp.ktime_get
      0.81 ±  9%     +12.2%       0.91 ±  2%  sched_debug.cfs_rq:/.h_nr_running.min
      8252 ±  8%     +15.1%       9494 ±  3%  sched_debug.cfs_rq:/.load.min
      7.77 ±  7%     +14.8%       8.92 ±  3%  sched_debug.cfs_rq:/.load_avg.min
      0.81 ±  9%     +12.2%       0.91 ±  2%  sched_debug.cfs_rq:/.nr_running.min
    825.73 ±  8%     +12.7%     930.23 ±  3%  sched_debug.cfs_rq:/.runnable_avg.min
    798.93 ±  8%     +12.3%     897.30 ±  4%  sched_debug.cfs_rq:/.util_avg.min
      0.81 ±  9%     +12.2%       0.91 ±  2%  sched_debug.cfs_rq:/system.slice.h_nr_running.min
      8609 ±  9%     +13.0%       9727 ±  3%  sched_debug.cfs_rq:/system.slice.load.min
     11.30 ±  7%      -9.6%      10.22        sched_debug.cfs_rq:/system.slice.load_avg.avg
     65.78 ± 30%     -59.6%      26.56 ±  8%  sched_debug.cfs_rq:/system.slice.load_avg.max
      8.05 ±  8%     +12.5%       9.05 ±  3%  sched_debug.cfs_rq:/system.slice.load_avg.min
      9.36 ± 37%     -70.7%       2.75 ±  9%  sched_debug.cfs_rq:/system.slice.load_avg.stddev
      0.81 ±  9%     +12.2%       0.91 ±  2%  sched_debug.cfs_rq:/system.slice.nr_running.min
    825.67 ±  8%     +12.7%     930.23 ±  3%  sched_debug.cfs_rq:/system.slice.runnable_avg.min
     10.94 ± 42%     -58.2%       4.58 ± 61%  sched_debug.cfs_rq:/system.slice.se->avg.load_avg.stddev
    825.67 ±  8%     +12.7%     930.23 ±  3%  sched_debug.cfs_rq:/system.slice.se->avg.runnable_avg.min
    797.77 ±  8%     +12.4%     896.95 ±  4%  sched_debug.cfs_rq:/system.slice.se->avg.util_avg.min
    122819 ± 40%     -51.2%      59903 ± 44%  sched_debug.cfs_rq:/system.slice.se->load.weight.max
     25488 ± 50%     -75.6%       6211 ± 42%  sched_debug.cfs_rq:/system.slice.se->load.weight.stddev
      8.06 ±  9%     +12.4%       9.05 ±  3%  sched_debug.cfs_rq:/system.slice.tg_load_avg_contrib.min
    797.77 ±  8%     +12.4%     896.95 ±  4%  sched_debug.cfs_rq:/system.slice.util_avg.min
    128.18 ± 22%     +91.7%     245.75 ± 11%  sched_debug.cfs_rq:/system.slice/containerd.service.avg_vruntime.avg
    234.17 ± 25%     +79.1%     419.30 ± 12%  sched_debug.cfs_rq:/system.slice/containerd.service.avg_vruntime.max
     43.50 ± 22%    +120.5%      95.92 ± 28%  sched_debug.cfs_rq:/system.slice/containerd.service.avg_vruntime.min
     81.66 ± 29%     +74.6%     142.59 ± 24%  sched_debug.cfs_rq:/system.slice/containerd.service.avg_vruntime.stddev
      2.80 ± 33%     +81.1%       5.06 ± 33%  sched_debug.cfs_rq:/system.slice/containerd.service.load_avg.avg
      5.64 ± 29%     +82.3%      10.28 ± 31%  sched_debug.cfs_rq:/system.slice/containerd.service.load_avg.max
      2.27 ± 34%     +93.6%       4.40 ± 37%  sched_debug.cfs_rq:/system.slice/containerd.service.load_avg.stddev
    128.18 ± 22%     +91.7%     245.75 ± 11%  sched_debug.cfs_rq:/system.slice/containerd.service.min_vruntime.avg
    234.17 ± 25%     +79.1%     419.30 ± 12%  sched_debug.cfs_rq:/system.slice/containerd.service.min_vruntime.max
     43.50 ± 22%    +120.5%      95.92 ± 28%  sched_debug.cfs_rq:/system.slice/containerd.service.min_vruntime.min
     81.66 ± 29%     +74.6%     142.59 ± 24%  sched_debug.cfs_rq:/system.slice/containerd.service.min_vruntime.stddev
      2.79 ± 33%     +81.1%       5.06 ± 33%  sched_debug.cfs_rq:/system.slice/containerd.service.runnable_avg.avg
      5.62 ± 29%     +82.6%      10.27 ± 31%  sched_debug.cfs_rq:/system.slice/containerd.service.runnable_avg.max
      2.26 ± 33%     +94.0%       4.39 ± 38%  sched_debug.cfs_rq:/system.slice/containerd.service.runnable_avg.stddev
      2.78 ± 33%     +81.5%       5.05 ± 33%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.runnable_avg.avg
      5.61 ± 29%     +83.1%      10.27 ± 31%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.runnable_avg.max
      2.26 ± 33%     +94.6%       4.40 ± 37%  sched_debug.cfs_rq:/system.slice/containerd.service.se->avg.runnable_avg.stddev
    136.98 ± 21%     +94.7%     266.75 ± 14%  sched_debug.cfs_rq:/system.slice/containerd.service.se->sum_exec_runtime.avg
    252.42 ± 24%     +82.7%     461.23 ± 16%  sched_debug.cfs_rq:/system.slice/containerd.service.se->sum_exec_runtime.max
     45.53 ± 21%    +119.8%     100.06 ± 28%  sched_debug.cfs_rq:/system.slice/containerd.service.se->sum_exec_runtime.min
     89.12 ± 27%     +79.0%     159.55 ± 28%  sched_debug.cfs_rq:/system.slice/containerd.service.se->sum_exec_runtime.stddev
      8.81 ± 37%   +4295.1%     387.34 ±118%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.avg
      9.12 ± 36%   +4150.1%     387.69 ±118%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.max
      8.51 ± 37%   +4444.4%     386.92 ±118%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.min
      2.80 ± 33%     +81.1%       5.06 ± 33%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg_contrib.avg
      5.64 ± 29%     +82.3%      10.28 ± 31%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg_contrib.max
      2.27 ± 34%     +93.6%       4.40 ± 37%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg_contrib.stddev
      0.17 ±  8%     -60.1%       0.07 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.h_nr_running.stddev
    180165 ±  8%     -60.0%      72004 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.load.stddev
    187.40 ± 15%     -67.8%      60.33 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.load_avg.stddev
      0.17 ±  8%     -60.1%       0.07 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.nr_running.stddev
      6.76 ± 69%     -76.3%       1.60 ±129%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.load_avg.avg
    147.10 ± 62%     -79.3%      30.38 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.load_avg.max
     28.32 ± 61%     -76.8%       6.58 ±124%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.load_avg.stddev
      2.89 ± 77%     -75.8%       0.70 ±124%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.runnable_avg.avg
     57.35 ± 50%     -73.5%      15.17 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.runnable_avg.max
     11.43 ± 64%     -73.8%       2.99 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.runnable_avg.stddev
      2.87 ± 77%     -75.7%       0.70 ±124%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.util_avg.avg
     55.94 ± 49%     -72.9%      15.17 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.util_avg.max
     11.28 ± 64%     -73.5%       2.99 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.removed.util_avg.stddev
     69.45 ± 22%     -63.6%      25.26 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.runnable_avg.stddev
     11.31 ±  7%     -64.9%       3.97 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.se->avg.load_avg.avg
     60.48 ± 40%     -83.8%       9.82 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.se->avg.load_avg.max
      9.81 ± 46%     -89.7%       1.01 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.se->avg.load_avg.stddev
     69.41 ± 22%     -63.6%      25.24 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.se->avg.runnable_avg.stddev
     43.67 ± 37%     -73.2%      11.72 ±126%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.se->avg.util_avg.stddev
     25759 ± 39%     -80.9%       4908 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.se->load.weight.avg
    102176 ± 47%     -84.0%      16350 ±125%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.se->load.weight.max
     23115 ± 57%     -92.6%       1718 ±126%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.se->load.weight.stddev
    850.39 ± 47%     -74.6%     216.04 ±123%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.tg_load_avg.stddev
    188.15 ± 15%     -68.1%      60.09 ±122%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.tg_load_avg_contrib.stddev
     43.66 ± 37%     -73.2%      11.72 ±126%  sched_debug.cfs_rq:/system.slice/lkp-bootstrap.service.util_avg.stddev
    835849           +17.1%     979195        sched_debug.cpu.avg_idle.avg
    390705 ±  8%     +27.5%     498342 ±  8%  sched_debug.cpu.avg_idle.min
    112505 ±  5%     -37.1%      70769 ±  6%  sched_debug.cpu.avg_idle.stddev
     13678 ± 52%     -34.9%       8908        sched_debug.cpu.curr->pid.max
    839.26 ± 43%     -46.1%     452.62 ± 21%  sched_debug.cpu.curr->pid.stddev
      0.81 ±  9%     +12.2%       0.91 ±  2%  sched_debug.cpu.nr_running.min
     15.22 ± 26%     +51.7%      23.09 ± 11%  sched_debug.cpu.nr_uninterruptible.max
    -17.17           +58.4%     -27.19        sched_debug.cpu.nr_uninterruptible.min
      5.71 ± 16%     +31.9%       7.54 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


