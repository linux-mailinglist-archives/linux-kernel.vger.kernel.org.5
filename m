Return-Path: <linux-kernel+bounces-30714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8E832373
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A4BB23188
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC417F0;
	Fri, 19 Jan 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxO7Rfmi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F828E8;
	Fri, 19 Jan 2024 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632097; cv=fail; b=NadGRz+Rkdn6e2G+pn+T7/G1XjhVV5K+K+ozs4TXZ6VzgRX7+e5SgvGVyvDiwJAOISuxWGSjNDA9O/uoIVA+vY6cEoZWOfXjmof3tsWZikFLAoqD/sNgf9RmL0V3plQLBeoJMCbkJx7V+aQ6lDG2C4+xWqble3oerfZj/rtZDqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632097; c=relaxed/simple;
	bh=msSkIDXgQ7SBnI1CG7hil+/1Zt5VmBH84QXQqINMLTw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e2itJf4Rgu+yBbHkNfgO5aL4EFi4C/jtCjjN+ICgI4FJcVmjKKS5pT6+5Am+9oVySV7qcguY3mI04hYC+/Hc/iXr9TtQJCiFl5EF2Rh0kvrjpegrh2Ah/xNjMbnTKg1mqEHqNM+rkoNs1D89PoXnratBZVRTFNDGjL4+5jEq9Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxO7Rfmi; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705632094; x=1737168094;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=msSkIDXgQ7SBnI1CG7hil+/1Zt5VmBH84QXQqINMLTw=;
  b=FxO7RfmiRzcHoKLF/i3KKY8U4/zdTVgM7Z2KqhRI6e0sj2iF+c/pJAqY
   1RK9/3d3ZrjOFzrDYlgG+nUdtyC1tkACUqxprG0/Q+TsGpUjj23SidmOu
   efkxrS5n3G3T4znQokrFunBSTPIVVp/NVFfZ6exLyXejDMQTeS3eFU6IG
   EzSxyPRC8b7fbyAQDOL+i0vW7YLvTPov3aw9/r/1X/VjJaM2Kcf0cbgwQ
   bYRzRBJgDDMAa5I46myW5SbVavqk8jV/DKneSTHCSe0jMvXC8YJCNpoYe
   Ch5ZCQdOMhwD0F4abDVBsp49MONwOrLpR7Tu6QMbT1MlexhTYqDjxAXJB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7346101"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="7346101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 18:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="875256032"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="875256032"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 18:41:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 18:41:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 18:41:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 18:41:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc+gfyXoKjKuoMV21iKphWJyRq6U0DH2VnFT2QU9sBObymJkl01Kj1EvEralQcSkcOJ19PV19nuqK5MmgjMo3DOy0USg70Bp/gYqtYp0cCY672J/iaUFhuyue/TJ16GV8yC/caCJn57PTrMPD5uGV6mAhzhCdjQOpzyzZ391ZNDi1YZtrAGNkAaUljyffN1d1/Zq7AwDsspnTXZkNhEj978pQtvmeiuTTPOPvdNm797UJ2sWVXF1CP7D1fb7nPBzYLU/J+OhvuvTd+j0Tsi9WnSkHNHq/LNZSTKjv2+nzpEinTNWXDt6/Dc+aafPQe57faV8GROMZohfNu01nkBCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLaZzlWK5Z4FUm0gmgbw0hSWgDgoPhoX01b2jmBy+Tw=;
 b=de4gA31NR+8pVfkigoudgjtEBRjKfMT4o05mU3rjSkf2RMs3HYToTEiuLYqDWxPuL7Ed+3Qdq3pT7KUz4dhQ3VFfZzThj9gH07sgf23nhiR2B3OVSpotcZ6UUTPUT6bac+8jy3J1hC1dhzR16o0Mljj7kuc5QzJZAz2iSHC1QycXhbWgm60pX8u11c3UmPWvRN4k0LRPhiMfBdgoxB2W+y5xRWxoauY6KtEAZYxBbAgq+48iKoBsHdQJeCzY6OHX3Ahpk5IqGv+6qkd3hwSiJ68+j4YzffhoWJPpTevAqK9OumpfFoUsODyR8eSfHOb0FhCk69Njy7chvanKWQ/tsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 02:41:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Fri, 19 Jan 2024
 02:41:27 +0000
Date: Fri, 19 Jan 2024 10:41:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Ian Rogers
	<irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Mingwei Zhang <mizhang@google.com>, Namhyung Kim
	<namhyung@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] perf/core: Reduce PMU access to adjust sample freq
Message-ID: <202401191023.d52a4ad4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240111204348.669673-2-namhyung@kernel.org>
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4723f4-9499-4236-a198-08dc18982276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: loojfMbMz9dFRit5pwFfX8huhKylRbqfOUWAQNasKsa/L9K8+HfWLW7lb2TySYp+l0WzKWHM0Nchsas7B3kWFgLUAISmJ9L8gFPagzjjejUhST470zNPJEftxQytn5Jlz1vRO9sAULi58Cu6ZItq9O/Brr6v1T0kTlhmg9vo2noyRsNBPy5ZjVxaMEqSkUcicLRUKW563S+bpExq+rLjRQz0Y4k+PUA9znaqFK6O+/aPiPHrlVtvHD9sCP/NTaZL1lU/w3iPctfEQFj8qehdJmBtcrGSnkOpAUsdXLxEK2+BXkjA80LG5/BKWV7QYiyXg5pmQbErDe5e3oQJwmm6HHODPA1CR+ZKrMYNqj1c7UdStKmPLhlIOe1mWumUKNmDgdN7itLTaF/nTojcQ/GnE2C3dBSCecb16LQStC6jEzDL682414oxdl7hNT/2y4KnCBodCfCyaFxgG8nH5SRnndDaxNDwytbfHbyIGugsQlWbQX4BvJwqNrb/3xpIELElZ1NWW4fC4n/Kk+pTaEmKy5h7H7ei2M3bNz1Q3pDe2V+qGEsvvh2G3yVO/zaKcCMm+nc+aPoNodzi0/UzxMPyj01W/H7CYwprgDaiVBvC5EihZUT14uazrlWLXgUv7KiRjg6MVxhG2DLjy6xuSv8sCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(26005)(1076003)(2616005)(478600001)(6486002)(6506007)(6666004)(45080400002)(6512007)(83380400001)(966005)(5660300002)(2906002)(7416002)(41300700001)(66556008)(66946007)(66476007)(6916009)(316002)(54906003)(4326008)(8936002)(8676002)(38100700002)(36756003)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3nSIZkXVy1JxthH2HuKPQV612n6wqbZw7QHK+nNGe9vGtTqzUn21RbXxikA2?=
 =?us-ascii?Q?bnS15DDZm0A325ttJN7GqpMJ7twCpF0dgMoExTFQDtigDzaOEjmMJZuXv6SB?=
 =?us-ascii?Q?SD6FaY4MjFnshhDh10+peErd//CNAPyNXe9L59hAnGyJvDg5g910i1yj9vV5?=
 =?us-ascii?Q?BsiZ/HoLrxvQGjPx2gF4NX6fagPEhu+4bxehSGgpdnrTwd72Y4jACGWXWzoY?=
 =?us-ascii?Q?AenOfb+rbLW0hvB6cUYc2JIHU6zT56XdgKX8oeteBnbtCkrQNJbB1D9LVzkj?=
 =?us-ascii?Q?EkdW+3lnWNTvJpVqoxTwm3th5zjKcA0rOd05yjIcghE4nl5BcLzLWvezeas0?=
 =?us-ascii?Q?h1h4Ca3C7+x2PO7iUxHsF8C8LnPgA56f9Kl/k5wcXXLJcpiJYWkEZlfGrRbc?=
 =?us-ascii?Q?o9iS2O8K5dlQq2jOHBCEw3tjQwY4uQzgOskB4eVyHFaC2SgI7Uv5IgvzpUVf?=
 =?us-ascii?Q?xInXQmAde+egEU6KC76cuDdJLSksl/7r48C3Pu6Ioom9rJcYZqjZn4I9Kvub?=
 =?us-ascii?Q?v5OHxaInOOecqDTYytSaIyh3HHRqYy36R2gtGtjhtJTmFadULIk5J0QTx/VU?=
 =?us-ascii?Q?ASgkjY6MiEQCdTw46G6ibM5Fx5CCz2vhz4YKpsIIlzktG5imawP1cS8eEhv9?=
 =?us-ascii?Q?CbWC3Gb8hmetkDraFFT8jzrcXyVovBGhqiv5G4pm3ILfHgJ6cOODw6eksyMa?=
 =?us-ascii?Q?OwvDA0iv+dki2V47VyuqSVP01JHOY+t/3JOvZ4yv3RtsvStqNxDh+xtYGsk7?=
 =?us-ascii?Q?dhEVcdatbJKEgQDKXgDtqEuaIDRb2j5LXC1PTdKqUbc58s2T27wuDRwok/AF?=
 =?us-ascii?Q?Ar32RrFPGeCaynNpjvgdSF6UMOgnxk9WZS+toaXFBcSVSEhD5k2jUfrgZ6ds?=
 =?us-ascii?Q?SjNEZmFMlHAUyfbN4X60eu1IZNX9svWpcYy9g6c4X8Hlgx3KS1bFLwh9PWsa?=
 =?us-ascii?Q?Sodnoca9f//KErPsPUVajBaMxhy+tkUoKm6q9KSYMQZWLF9fZPJWtzor0kvG?=
 =?us-ascii?Q?Ta/vAp8YUoLQ+yEvzTnpbFW4JOKR6o8sHvqnZ+yjTJPFTy12iLZmU6Cl2T5K?=
 =?us-ascii?Q?EPT1fuoigu+Yrl91QNsZcGDrd5mKa6FjUqUKln6eIztpvNLJYt08SM1ZgnvK?=
 =?us-ascii?Q?Vz+26ZAS5Ntp5NNom90Uq32f39diP+cvgU6aRQTttcjxSXb22sL29PSQ1BaK?=
 =?us-ascii?Q?hYXDfWAxNUyGd1AiQ9JwbLVBvNVSw97q140kTSMN67G+QWpRD/P7qHceDloF?=
 =?us-ascii?Q?a2NN6o9OiKGdC4E/J6CpCWKkt7tgp/BvoNfNIU73RnzpFoC2WICMgpIOFVGg?=
 =?us-ascii?Q?zn/3rKdPFeDDIKyfhOSYM0Y/nxT5ktlA6BSwG6jMqyW2/2D2uHc12RxzPZKj?=
 =?us-ascii?Q?hGKbGFGVHs7eU5Q8zK7Oau4bK53/xzuinZpkq5nbm7GWH2Sapd9giOw00wAD?=
 =?us-ascii?Q?6LMJIA4/MTTZaNrMABj9mZcnL9layw3i2TC3LwiY4vK7osS21ZP2TZoyWljc?=
 =?us-ascii?Q?8iqFhbb55K1JC2KaW48MORwDLT+AHqOqTZBOAhQMrDHV9YgoMmvpYmTQTYWj?=
 =?us-ascii?Q?oziaudedf8O+k2NVoaqjg+X0e7b1FdJFhvp4rtVRv46OL/jkGUtrXMDfSquN?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4723f4-9499-4236-a198-08dc18982276
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 02:41:27.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAJuk6TMgvmXA6SWZtf4in3jI+srpyD1YHd98kQxD5thxp0fwBv6cB9NhiyYa2obvT3NKhIvuU6xG0SsbO7l7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/events/core.c:#x86_pmu_start" on:

commit: d6da92786f901cc4ce3588f101182758da295dbb ("[PATCH v2 2/2] perf/core: Reduce PMU access to adjust sample freq")
url: https://github.com/intel-lab-lkp/linux/commits/namhyung-kernel-org/perf-core-Reduce-PMU-access-to-adjust-sample-freq/20240112-044505
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20240111204348.669673-2-namhyung@kernel.org/
patch subject: [PATCH v2 2/2] perf/core: Reduce PMU access to adjust sample freq

in testcase: will-it-scale
version: will-it-scale-x86_64-75f66e4-1_20240111
with following parameters:

	nr_task: 16
	mode: thread
	test: pipe1
	cpufreq_governor: performance



compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401191023.d52a4ad4-oliver.sang@intel.com


[  102.087071][   C94] ------------[ cut here ]------------
[ 102.092623][ C94] WARNING: CPU: 94 PID: 0 at arch/x86/events/core.c:1507 x86_pmu_start (arch/x86/events/core.c:1507 (discriminator 1)) 
[  102.101826][   C94] Modules linked in: intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp btrfs coretemp blake2b_generic xor kvm_intel kvm raid6_pq libcrc32c irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 sd_mod sg rapl ipmi_ssif nvme nvme_core ahci intel_cstate acpi_ipmi t10_pi libahci ast crc64_rocksoft_generic drm_shmem_helper mei_me ipmi_si crc64_rocksoft i2c_i801 ioatdma libata intel_uncore drm_kms_helper joydev crc64 mei ipmi_devintf lpc_ich i2c_smbus intel_pch_thermal dca wmi ipmi_msghandler acpi_pad acpi_power_meter drm fuse ip_tables
[  102.158393][   C94] CPU: 94 PID: 0 Comm: swapper/94 Not tainted 6.7.0-rc6-00192-gd6da92786f90 #1
[ 102.167472][ C94] RIP: 0010:x86_pmu_start (arch/x86/events/core.c:1507 (discriminator 1)) 
[ 102.172832][ C94] Code: 00 00 4c 0f ab 65 00 48 89 df e8 16 08 01 00 48 89 df 5b 5d 41 5c e9 4a c6 33 00 0f 0b 5b 5d 41 5c c3 cc cc cc cc 0f 0b eb f3 <0f> 0b eb b6 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	4c 0f ab 65 00       	bts    %r12,0x0(%rbp)
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 16 08 01 00       	callq  0x10825
   f:	48 89 df             	mov    %rbx,%rdi
  12:	5b                   	pop    %rbx
  13:	5d                   	pop    %rbp
  14:	41 5c                	pop    %r12
  16:	e9 4a c6 33 00       	jmpq   0x33c665
  1b:	0f 0b                	ud2    
  1d:	5b                   	pop    %rbx
  1e:	5d                   	pop    %rbp
  1f:	41 5c                	pop    %r12
  21:	c3                   	retq   
  22:	cc                   	int3   
  23:	cc                   	int3   
  24:	cc                   	int3   
  25:	cc                   	int3   
  26:	0f 0b                	ud2    
  28:	eb f3                	jmp    0x1d
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb b6                	jmp    0xffffffffffffffe4
  2e:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  35:	00 00 00 00 
  39:	66                   	data16
  3a:	66                   	data16
  3b:	2e                   	cs
  3c:	0f                   	.byte 0xf
  3d:	1f                   	(bad)  
  3e:	84 00                	test   %al,(%rax)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb b6                	jmp    0xffffffffffffffba
   4:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
   b:	00 00 00 00 
   f:	66                   	data16
  10:	66                   	data16
  11:	2e                   	cs
  12:	0f                   	.byte 0xf
  13:	1f                   	(bad)  
  14:	84 00                	test   %al,(%rax)
[  102.192917][   C94] RSP: 0018:ffffc9000ddb0e00 EFLAGS: 00010046
[  102.199175][   C94] RAX: 0000000000000001 RBX: ffff88b01d17a290 RCX: 0000000000000349
[  102.207339][   C94] RDX: 0000000000002ff0 RSI: 0000000000000002 RDI: ffff88b01d17a290
[  102.215509][   C94] RBP: ffff88afa149a220 R08: 0000000000000000 R09: 0000000000000014
[  102.223684][   C94] R10: 000000000000000f R11: 00000000000f4240 R12: 0000000000000003
[  102.231855][   C94] R13: 0000000000000001 R14: ffff88afa14b9680 R15: 000000000000005e
[  102.240038][   C94] FS:  0000000000000000(0000) GS:ffff88afa1480000(0000) knlGS:0000000000000000
[  102.249178][   C94] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  102.255986][   C94] CR2: 00007f9cdf69ec98 CR3: 000000303e01c002 CR4: 00000000007706f0
[  102.264179][   C94] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  102.272365][   C94] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  102.280552][   C94] PKRU: 55555554
[  102.284322][   C94] Call Trace:
[  102.287830][   C94]  <IRQ>
[ 102.290895][ C94] ? x86_pmu_start (arch/x86/events/core.c:1507 (discriminator 1)) 
[ 102.295695][ C94] ? __warn (kernel/panic.c:677) 
[ 102.299980][ C94] ? x86_pmu_start (arch/x86/events/core.c:1507 (discriminator 1)) 
[ 102.304768][ C94] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 102.309473][ C94] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 102.314006][ C94] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 102.318879][ C94] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 102.324101][ C94] ? x86_pmu_start (arch/x86/events/core.c:1507 (discriminator 1)) 
[ 102.328888][ C94] perf_adjust_freq_unthr_events (kernel/events/core.c:4181 (discriminator 4)) 
[ 102.335069][ C94] perf_adjust_freq_unthr_context (kernel/events/core.c:4216) 
[ 102.341244][ C94] perf_event_task_tick (arch/x86/include/asm/current.h:41 kernel/events/core.c:4363) 
[ 102.346458][ C94] scheduler_tick (kernel/sched/core.c:5665) 
[ 102.351240][ C94] update_process_times (kernel/time/timer.c:2079) 
[ 102.356442][ C94] tick_sched_handle (kernel/time/tick-sched.c:256) 
[ 102.361381][ C94] tick_nohz_highres_handler (kernel/time/tick-sched.c:1525) 
[ 102.367021][ C94] ? __pfx_tick_nohz_highres_handler (kernel/time/tick-sched.c:1503) 
[ 102.373345][ C94] __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752) 
[ 102.378720][ C94] hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 102.383748][ C94] __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1065 arch/x86/kernel/apic/apic.c:1082) 
[ 102.389818][ C94] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14)) 
[  102.395636][   C94]  </IRQ>
[  102.398759][   C94]  <TASK>
[ 102.401872][ C94] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:649) 
[ 102.408032][ C94] RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291) 
[ 102.414008][ C94] Code: 00 e8 9e 46 19 ff e8 d9 f1 ff ff 8b 53 04 49 89 c5 0f 1f 44 00 00 31 ff e8 07 2e 18 ff 45 84 ff 0f 85 d2 00 00 00 fb 45 85 f6 <0f> 88 83 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d 0c c4 48
All code
========
   0:	00 e8                	add    %ch,%al
   2:	9e                   	sahf   
   3:	46 19 ff             	rex.RX sbb %r15d,%edi
   6:	e8 d9 f1 ff ff       	callq  0xfffffffffffff1e4
   b:	8b 53 04             	mov    0x4(%rbx),%edx
   e:	49 89 c5             	mov    %rax,%r13
  11:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  16:	31 ff                	xor    %edi,%edi
  18:	e8 07 2e 18 ff       	callq  0xffffffffff182e24
  1d:	45 84 ff             	test   %r15b,%r15b
  20:	0f 85 d2 00 00 00    	jne    0xf8
  26:	fb                   	sti    
  27:	45 85 f6             	test   %r14d,%r14d
  2a:*	0f 88 83 01 00 00    	js     0x1b3		<-- trapping instruction
  30:	49 63 d6             	movslq %r14d,%rdx
  33:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
  37:	48 8d 04 82          	lea    (%rdx,%rax,4),%rax
  3b:	49 8d 0c c4          	lea    (%r12,%rax,8),%rcx
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 88 83 01 00 00    	js     0x189
   6:	49 63 d6             	movslq %r14d,%rdx
   9:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
   d:	48 8d 04 82          	lea    (%rdx,%rax,4),%rax
  11:	49 8d 0c c4          	lea    (%r12,%rax,8),%rcx
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240119/202401191023.d52a4ad4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


