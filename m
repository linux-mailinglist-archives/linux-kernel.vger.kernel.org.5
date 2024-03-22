Return-Path: <linux-kernel+bounces-110895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38429886552
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB311F22DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB674A3E;
	Fri, 22 Mar 2024 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLfgMu8w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA929A5;
	Fri, 22 Mar 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711076288; cv=fail; b=suMSVOx/5++JNDsydUbZMRm/nTHFcFdh+9sOxbxSjncNmw3wJ9ySGMpQSlbfSF4FDtAuLx1dXSZfnWrEp35w2C4TzZ2P+1T3uS46NkrfngoxpooP7Lcs1zoK7otCHyNAX8XfKhvZ9MPGp+/w8bFztinQ8avCJvI9GkTm/t35omE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711076288; c=relaxed/simple;
	bh=4Jmuxcio6IC1WJI/kjA+xGaxo+awt/f7UgTxTm90Isg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WpOAwGBfWykQJwSxrubCIoXk/DFEkCwSwhCGR9dOlJ+HM2mPGBEkCKRrblsgDDw3nH29+wn3NWI3FifUSxvV+vMGp331vAU45IlevJdeuXloBLW03HqhMqW5c5L+CCOqMr7/9Q8ooEKp8JhT5OFyl0YZwVXClRfj9+I1ugJf9Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLfgMu8w; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711076283; x=1742612283;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=4Jmuxcio6IC1WJI/kjA+xGaxo+awt/f7UgTxTm90Isg=;
  b=JLfgMu8wOCBOY6f+Ch3Ta0jM8akPbg0TqVzeOKD3tlFQFRtFXq0dHsvY
   ie3SREwNE6bB0xtDKf6v5rNxNxc/KVlxfowdEBzl6JG0WfLWTHGeUD3bF
   xW9xcWp/IZpfMAKNHJ+mNWyeTO5loDwL1DpRu1s8sV0rNymxeabCDhkcU
   Dp6kq5a1/IJ3QIKYYFt/1d8PmIkK646CkxUYm9HZB8ev+DcbbTPSrMfoV
   jyzzNadF4jmUoS1CGJRcX92SMpXzrTPupgAXV2vZgDOyKQvJa/g0luh0B
   G2rDp1VqroM5F6+RkCl7I1CimUkGzGvzkP+jxLmXBYMqIEtLKTPQ0u/qH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9912717"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="9912717"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 19:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="14825437"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 19:58:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 19:58:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 19:57:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 19:57:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 19:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZPx6SXlexMd6saRSXGjAJbIfZas8h/JflRPFAgX0ONAaZbPCY02nTNEkPPOSQ6kZHZ3pAI1QTu569u7R01ghH8MyTrx7jsCLul8E5Q0yHlSC2HHq1pcraz039qSdl7hVb5WEYLwlEbILR+gF9hAghIeA3Bb3t3iLfH2LrdVoopLmY9g/+LikUSxsm5GPk0hwYJPD05yLTmmNYFI25bVCjTXnL0W5zMVN0MZdG4LBfWi8mccZi8HRyxR4nXYkVIl1GUKAXi/i6DpPpHKOCpVzbyuwWSPVPpml04xH6Ig152KVN/cg51wnmoom81t4aQz2gQKlIPYwkFj1LHQHdQf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXLSEc+3A/xw8PlAPHfnNZG6wO3sllSb291cyjZNAQE=;
 b=arQ+xh7V0YJZiM9ZgsjcaNJ4Nf9QveaENpE+ZRwZwgFnBxryq/eb4004rv27RBEfs1DrXYBOX3zl4vC46awRXVP5o5ojMyHmVKyHroegLb0JQ8nQlkMqsdv6jLmZxxKtmrOO2yk7OTVjHrwdcKW+Z6uIvob9pSqPtHPT/6r+1WzcOTB2eq/32Q5c2mQPvO8XLXQRgpX6Iz1MpVMNjwpOkE1jM1mpZug1mL5d5g6EFoUCDTpx7XUxKBP2Kj0FnByQs5RSG8P0pLvrc63kqKUd75SGE8IbJy/dqMFLEFrIelc1obEuOpPwP3oQbLe/+BYRoa+6yo45atP/hKt8l0X4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 02:57:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 02:57:56 +0000
Date: Fri, 22 Mar 2024 10:57:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "John
 Garry" <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, Jing
 Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@arm.com>, Andi Kleen <ak@linux.intel.com>, Kajol
 Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, Ravi
 Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>, "Caleb Biggers"
	<caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, Edward Baker
	<edward.baker@intel.com>, Stephane Eranian <eranian@google.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 12/12] perf jevents: Add load event json to verify and
 allow fallbacks
Message-ID: <202403221000.c4617e93-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="TiJHmnqND8oovjPL"
Content-Disposition: inline
In-Reply-To: <20240314055051.1960527-13-irogers@google.com>
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b04556-3c1a-45d9-4397-08dc4a1bdfcd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrPGRWL8XPKGaFjmQY8uUwDvKoxIKXw0nKTbTvfmCR2ICvPzd9mj5b9NrUzrpuksFiqtxn6tcH+IcXO6b2G4MLhk/2SIUtnqlaKYXZGa3GjkG/e79FqOWdku4dKlhnA9hU/cmM5M9fgRrAi3001JCZUprU74zyIhRAt+VULELE5UUohZFOcH8kjLiXIlO1eHUnslwSSltxN3HP2FNANtW6snFpHsiM+Mz5EkYgxTmEYIGEtI5sM/YQ37JcS6Me5HcDblgD+Ec04h3yhAPNi4k5b5z/Hg7fBvd1daISslclUOgLoFFMD+eUcg+ltPd9caSfFWGeacB7in7ABPG0rHGsyVUOgxoRp+rAVQZXbimX0tWJDWJ9qmqwwyqfAnBhxNYZSmOwaZIdP1tB9EE96g7DnxbNnzaKckePqLOypoe1Z0ckvACH9ux47i0HSs7zIu2QcyG06hVkppv5n3lTiO/f78aseTdwLutFbHm89r9kypv7S/Ftk+h1bPaB7NJaIA9O5ohwz+LwqJWHsR2+kiiEqrLsOdqbhdaFJCDb1nVk10+SIkPauy5vZPLU/6xGTXlmLyv341s+k2sLf+0G9WmKzMdoRlvOA58ASE/tjwkwh4YTmFn+ZqX13rfY+wJ379
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DbEmCddXSzTYhhN122ejd5toGLAf+5qdV20Um25gdCGGXwt8nKQM7E5yM4aO?=
 =?us-ascii?Q?rG60px/JV3H0C3ZDPsskReqcHARkmj/f2YVt1Pox+OwibtWJAW2wIaU7UhLk?=
 =?us-ascii?Q?4w+i+Q03qYsJ3W44lrhOEb52o7E2B69CJqjSACVq4dyI8+6LeCSIX1YZqhNG?=
 =?us-ascii?Q?B1OAwiiBssoXURrzvfssADlcGPghNOxgGQ9L6Uiv8hg6R8zxymKQPlwPbD43?=
 =?us-ascii?Q?j2iPZR761ZGX3o8F2yETB0Y0NRGHw+B/c+rt/BxjQjnY2cLqxmmSgcCLDYTY?=
 =?us-ascii?Q?SaSE5S/nog3yrzMZw/qWChIK7hOPEVRRhLTExzpirqqh2orss6D+GnEps/Cu?=
 =?us-ascii?Q?04EPYD6FGeoNvNvcW05Xx4814iRB5w18XWH/ku9fGGUWZT9EDiB7bT/t4pjw?=
 =?us-ascii?Q?isCMJ59fFpBQ4BkTHu7zoUErVTBLrdCS5sVZUiKz7hNRCL55maKuDy1gPbtw?=
 =?us-ascii?Q?GaDxsveN5/PqUWwRlH7Uf+/ktFrluzA0+LDG2LuLC+sVpJRsHKCxu5H5xQ5j?=
 =?us-ascii?Q?OvIQ2G2CXIiCNmCMeZAkXgC74tBVWYTPFnthYG6kN8ouVQ+xEqYmLTkswM8P?=
 =?us-ascii?Q?ljKydQinU31/hLQZCFd02MtimwsCVlagd3khhW2hMV29tzA556+VcWgkkANw?=
 =?us-ascii?Q?ySCam1tBTRoB25Cvo0XkyrjCCRkn/q/qPQxfUWXd0yUVZ2jP+7fk2jPwuA+G?=
 =?us-ascii?Q?DFHr+bCzOXyNECl999hm9mse1ruPeO3bRCmkU5xL6r9EVO7Js3eatzWATml6?=
 =?us-ascii?Q?aTL3cOaP3+t1QVz7Xe3cK+2LkxhT6n4WnGeXnbNfXemD64cko0et9rA0ZiWH?=
 =?us-ascii?Q?D4rgnZsy/wUcpQ6ZRd/disby15WhfEcMtCAu70GMB+CdFKvIMZnxwDh9NckA?=
 =?us-ascii?Q?+4RDoR1pDx8qw+gFa8ZYcIKNgcEa+wjPXxNIKnaT8Vvu7w38Y00e9F4AmOeJ?=
 =?us-ascii?Q?doCsUGdTmnxGjRWbl4rABF36OdpX5AXefZ2+pXOr9NBgT5g8wjJ/Wd9P3KVf?=
 =?us-ascii?Q?cf910GNhP/bf5XAJvZl/xz4OODxNiznkTrBYz5U5UX8QCWncZ3vyc9c451Us?=
 =?us-ascii?Q?yqkV8rTd2kTUvjBILYvVnuOEvjEyYtMQTNPSfTR5dmoo73WsyDfVFYlx75H7?=
 =?us-ascii?Q?1tf/Fw+47pEsXQxZcY6TfxbNaNRK2NVIySNBXU2QxIa8h3H/ZjJdYGcCDaM2?=
 =?us-ascii?Q?7JZHeqpVIu0dTc9xjozrdpYQ0upd+5OOM3II2PL8a4D8pgq8iE7tKGz+vxOd?=
 =?us-ascii?Q?Wbea0SOmNSF5mgdxq/d7i7KoSe34HTquVXssbeu1LZUMYt809o+zrzFNtr6s?=
 =?us-ascii?Q?nO4iqi7Jfu+Y/anngYkOwli8d7yNVQxRx0yAqofZr3Lnu6wO62hYIPJGr6lw?=
 =?us-ascii?Q?9CIWcXi3ab6SMUENpw7v5IyVNB+vzPjWFWvU/xRVrghB4ozCwv01R/eLJRCS?=
 =?us-ascii?Q?7wMYGPb3ypo1lanwYMTjijnvUMjCIwlTDckLHiVVTwpILD8JmSIi9c8VxGgW?=
 =?us-ascii?Q?wDuj1RGev0BQA5Q4dTK18xU8AyVQHMLkqNfIrC5t4BDyQfXOgIPtEWhkEkoP?=
 =?us-ascii?Q?8dUFfgmQrGd85X4fhKI6AkriQ58a4fTkbop7OSZru5rvOrnpFdZx3ADkbmMz?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b04556-3c1a-45d9-4397-08dc4a1bdfcd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 02:57:56.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GV7Sb6yIUJ1XIxUE5JN1Q88x4/kNGKQOJQ2mWEM2vldnS0TSqkUebYN+FXgzqgE2w4+RMa+T5svfMcBIce5j7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com

--TiJHmnqND8oovjPL
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "perf-test.perf.make.fail" on:

commit: d3ed44a7bee70b097709fe06f339c468489f16c9 ("[PATCH v3 12/12] perf jevents: Add load event json to verify and allow fallbacks")
url: https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-jevents-Allow-multiple-metricgroups-json-files/20240314-135507
base: v6.8
patch link: https://lore.kernel.org/all/20240314055051.1960527-13-irogers@google.com/
patch subject: [PATCH v3 12/12] perf jevents: Add load event json to verify and allow fallbacks

in testcase: perf-test
version: perf-test-x86_64-git-1_20240223
with following parameters:

	type: lkp
	group: group-01



compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403221000.c4617e93-oliver.sang@intel.com


please check attached stderr, more materials are in link [1]


Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/amd_metrics.py", line 42, in <module>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:45: pmu-events/arch/x86/amdzen1/extra-metrics.json] Error 1
make[3]: *** Deleting file 'pmu-events/arch/x86/amdzen1/extra-metrics.json'
make[3]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/amd_metrics.py", line 42, in <module>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:45: pmu-events/arch/x86/amdzen2/extra-metrics.json] Error 1
make[3]: *** Deleting file 'pmu-events/arch/x86/amdzen2/extra-metrics.json'
make[2]: *** [Makefile.perf:706: pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:261: sub-make] Error 2
make: *** [Makefile:70: all] Error 2



[1]
The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240322/202403221000.c4617e93-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--TiJHmnqND8oovjPL
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="stderr"

  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Makefile.config:698: Warning: Disabled BPF skeletons as clang (clang) is missing
  PERF_VERSION = 6.8.0
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-io.json <- pmu-events/arch/x86/jaketown/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-power.json <- pmu-events/arch/x86/jaketown/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-cache.json <- pmu-events/arch/x86/jaketown/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/memory.json <- pmu-events/arch/x86/jaketown/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-interconnect.json <- pmu-events/arch/x86/jaketown/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/cache.json <- pmu-events/arch/x86/jaketown/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/floating-point.json <- pmu-events/arch/x86/jaketown/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/frontend.json <- pmu-events/arch/x86/jaketown/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/virtual-memory.json <- pmu-events/arch/x86/jaketown/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-memory.json <- pmu-events/arch/x86/jaketown/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/jkt-metrics.json <- pmu-events/arch/x86/jaketown/jkt-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/metricgroups.json <- pmu-events/arch/x86/jaketown/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/other.json <- pmu-events/arch/x86/jaketown/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/pipeline.json <- pmu-events/arch/x86/jaketown/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/memory.json <- pmu-events/arch/x86/westmereep-sp/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/cache.json <- pmu-events/arch/x86/westmereep-sp/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/floating-point.json <- pmu-events/arch/x86/westmereep-sp/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/frontend.json <- pmu-events/arch/x86/westmereep-sp/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/virtual-memory.json <- pmu-events/arch/x86/westmereep-sp/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/other.json <- pmu-events/arch/x86/westmereep-sp/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/pipeline.json <- pmu-events/arch/x86/westmereep-sp/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/uncore-io.json <- pmu-events/arch/x86/knightslanding/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/uncore-cache.json <- pmu-events/arch/x86/knightslanding/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/memory.json <- pmu-events/arch/x86/knightslanding/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/cache.json <- pmu-events/arch/x86/knightslanding/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/floating-point.json <- pmu-events/arch/x86/knightslanding/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/frontend.json <- pmu-events/arch/x86/knightslanding/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/virtual-memory.json <- pmu-events/arch/x86/knightslanding/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/uncore-memory.json <- pmu-events/arch/x86/knightslanding/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/pipeline.json <- pmu-events/arch/x86/knightslanding/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/uncore-cache.json <- pmu-events/arch/x86/meteorlake/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/memory.json <- pmu-events/arch/x86/meteorlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/uncore-interconnect.json <- pmu-events/arch/x86/meteorlake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/cache.json <- pmu-events/arch/x86/meteorlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/floating-point.json <- pmu-events/arch/x86/meteorlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/frontend.json <- pmu-events/arch/x86/meteorlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/virtual-memory.json <- pmu-events/arch/x86/meteorlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/uncore-memory.json <- pmu-events/arch/x86/meteorlake/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/other.json <- pmu-events/arch/x86/meteorlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/pipeline.json <- pmu-events/arch/x86/meteorlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/uncore-other.json <- pmu-events/arch/x86/meteorlake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/core.json <- pmu-events/arch/x86/amdzen2/core.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/memory.json <- pmu-events/arch/x86/amdzen2/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/cache.json <- pmu-events/arch/x86/amdzen2/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/floating-point.json <- pmu-events/arch/x86/amdzen2/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/data-fabric.json <- pmu-events/arch/x86/amdzen2/data-fabric.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/other.json <- pmu-events/arch/x86/amdzen2/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/branch.json <- pmu-events/arch/x86/amdzen2/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/recommended.json <- pmu-events/arch/x86/amdzen2/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/memory.json <- pmu-events/arch/x86/graniterapids/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/cache.json <- pmu-events/arch/x86/graniterapids/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/frontend.json <- pmu-events/arch/x86/graniterapids/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/virtual-memory.json <- pmu-events/arch/x86/graniterapids/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/other.json <- pmu-events/arch/x86/graniterapids/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/pipeline.json <- pmu-events/arch/x86/graniterapids/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/uncore-cache.json <- pmu-events/arch/x86/sandybridge/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/memory.json <- pmu-events/arch/x86/sandybridge/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/uncore-interconnect.json <- pmu-events/arch/x86/sandybridge/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/cache.json <- pmu-events/arch/x86/sandybridge/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/floating-point.json <- pmu-events/arch/x86/sandybridge/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/frontend.json <- pmu-events/arch/x86/sandybridge/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/virtual-memory.json <- pmu-events/arch/x86/sandybridge/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/metricgroups.json <- pmu-events/arch/x86/sandybridge/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/other.json <- pmu-events/arch/x86/sandybridge/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/snb-metrics.json <- pmu-events/arch/x86/sandybridge/snb-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/pipeline.json <- pmu-events/arch/x86/sandybridge/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/ehl-metrics.json <- pmu-events/arch/x86/elkhartlake/ehl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/memory.json <- pmu-events/arch/x86/elkhartlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/cache.json <- pmu-events/arch/x86/elkhartlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/floating-point.json <- pmu-events/arch/x86/elkhartlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/frontend.json <- pmu-events/arch/x86/elkhartlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/virtual-memory.json <- pmu-events/arch/x86/elkhartlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/other.json <- pmu-events/arch/x86/elkhartlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/pipeline.json <- pmu-events/arch/x86/elkhartlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-io.json <- pmu-events/arch/x86/skylakex/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-power.json <- pmu-events/arch/x86/skylakex/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/skx-metrics.json <- pmu-events/arch/x86/skylakex/skx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-cache.json <- pmu-events/arch/x86/skylakex/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/memory.json <- pmu-events/arch/x86/skylakex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-interconnect.json <- pmu-events/arch/x86/skylakex/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/cache.json <- pmu-events/arch/x86/skylakex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/floating-point.json <- pmu-events/arch/x86/skylakex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/frontend.json <- pmu-events/arch/x86/skylakex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/virtual-memory.json <- pmu-events/arch/x86/skylakex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-memory.json <- pmu-events/arch/x86/skylakex/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/metricgroups.json <- pmu-events/arch/x86/skylakex/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/other.json <- pmu-events/arch/x86/skylakex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/pipeline.json <- pmu-events/arch/x86/skylakex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-io.json <- pmu-events/arch/x86/broadwellde/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-power.json <- pmu-events/arch/x86/broadwellde/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-cache.json <- pmu-events/arch/x86/broadwellde/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/bdwde-metrics.json <- pmu-events/arch/x86/broadwellde/bdwde-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/memory.json <- pmu-events/arch/x86/broadwellde/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-interconnect.json <- pmu-events/arch/x86/broadwellde/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/cache.json <- pmu-events/arch/x86/broadwellde/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/floating-point.json <- pmu-events/arch/x86/broadwellde/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/frontend.json <- pmu-events/arch/x86/broadwellde/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/virtual-memory.json <- pmu-events/arch/x86/broadwellde/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-memory.json <- pmu-events/arch/x86/broadwellde/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/metricgroups.json <- pmu-events/arch/x86/broadwellde/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/other.json <- pmu-events/arch/x86/broadwellde/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/pipeline.json <- pmu-events/arch/x86/broadwellde/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-io.json <- pmu-events/arch/x86/ivytown/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-power.json <- pmu-events/arch/x86/ivytown/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/ivt-metrics.json <- pmu-events/arch/x86/ivytown/ivt-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-cache.json <- pmu-events/arch/x86/ivytown/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/memory.json <- pmu-events/arch/x86/ivytown/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-interconnect.json <- pmu-events/arch/x86/ivytown/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/cache.json <- pmu-events/arch/x86/ivytown/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/floating-point.json <- pmu-events/arch/x86/ivytown/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/frontend.json <- pmu-events/arch/x86/ivytown/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/virtual-memory.json <- pmu-events/arch/x86/ivytown/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-memory.json <- pmu-events/arch/x86/ivytown/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/metricgroups.json <- pmu-events/arch/x86/ivytown/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/other.json <- pmu-events/arch/x86/ivytown/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/pipeline.json <- pmu-events/arch/x86/ivytown/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/memory.json <- pmu-events/arch/x86/westmereex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/cache.json <- pmu-events/arch/x86/westmereex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/floating-point.json <- pmu-events/arch/x86/westmereex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/frontend.json <- pmu-events/arch/x86/westmereex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/virtual-memory.json <- pmu-events/arch/x86/westmereex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/other.json <- pmu-events/arch/x86/westmereex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/pipeline.json <- pmu-events/arch/x86/westmereex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/mapfile.csv <- pmu-events/arch/x86/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/memory.json <- pmu-events/arch/x86/bonnell/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/cache.json <- pmu-events/arch/x86/bonnell/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/floating-point.json <- pmu-events/arch/x86/bonnell/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/frontend.json <- pmu-events/arch/x86/bonnell/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/virtual-memory.json <- pmu-events/arch/x86/bonnell/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/other.json <- pmu-events/arch/x86/bonnell/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/pipeline.json <- pmu-events/arch/x86/bonnell/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-io.json <- pmu-events/arch/x86/snowridgex/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-power.json <- pmu-events/arch/x86/snowridgex/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-cache.json <- pmu-events/arch/x86/snowridgex/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/memory.json <- pmu-events/arch/x86/snowridgex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-interconnect.json <- pmu-events/arch/x86/snowridgex/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/cache.json <- pmu-events/arch/x86/snowridgex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/floating-point.json <- pmu-events/arch/x86/snowridgex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/frontend.json <- pmu-events/arch/x86/snowridgex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/virtual-memory.json <- pmu-events/arch/x86/snowridgex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-memory.json <- pmu-events/arch/x86/snowridgex/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/other.json <- pmu-events/arch/x86/snowridgex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/pipeline.json <- pmu-events/arch/x86/snowridgex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/uncore-cache.json <- pmu-events/arch/x86/skylake/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/memory.json <- pmu-events/arch/x86/skylake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/uncore-interconnect.json <- pmu-events/arch/x86/skylake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/cache.json <- pmu-events/arch/x86/skylake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/floating-point.json <- pmu-events/arch/x86/skylake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/frontend.json <- pmu-events/arch/x86/skylake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/virtual-memory.json <- pmu-events/arch/x86/skylake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/metricgroups.json <- pmu-events/arch/x86/skylake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/other.json <- pmu-events/arch/x86/skylake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/pipeline.json <- pmu-events/arch/x86/skylake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/skl-metrics.json <- pmu-events/arch/x86/skylake/skl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/uncore-other.json <- pmu-events/arch/x86/skylake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/memory.json <- pmu-events/arch/x86/grandridge/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/cache.json <- pmu-events/arch/x86/grandridge/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/frontend.json <- pmu-events/arch/x86/grandridge/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/virtual-memory.json <- pmu-events/arch/x86/grandridge/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/other.json <- pmu-events/arch/x86/grandridge/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/pipeline.json <- pmu-events/arch/x86/grandridge/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-io.json <- pmu-events/arch/x86/emeraldrapids/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-power.json <- pmu-events/arch/x86/emeraldrapids/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-cache.json <- pmu-events/arch/x86/emeraldrapids/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/memory.json <- pmu-events/arch/x86/emeraldrapids/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json <- pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/cache.json <- pmu-events/arch/x86/emeraldrapids/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/floating-point.json <- pmu-events/arch/x86/emeraldrapids/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-cxl.json <- pmu-events/arch/x86/emeraldrapids/uncore-cxl.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/frontend.json <- pmu-events/arch/x86/emeraldrapids/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/virtual-memory.json <- pmu-events/arch/x86/emeraldrapids/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-memory.json <- pmu-events/arch/x86/emeraldrapids/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/other.json <- pmu-events/arch/x86/emeraldrapids/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/pipeline.json <- pmu-events/arch/x86/emeraldrapids/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/hsw-metrics.json <- pmu-events/arch/x86/haswell/hsw-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/uncore-cache.json <- pmu-events/arch/x86/haswell/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/memory.json <- pmu-events/arch/x86/haswell/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/uncore-interconnect.json <- pmu-events/arch/x86/haswell/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/cache.json <- pmu-events/arch/x86/haswell/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/floating-point.json <- pmu-events/arch/x86/haswell/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/frontend.json <- pmu-events/arch/x86/haswell/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/virtual-memory.json <- pmu-events/arch/x86/haswell/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/metricgroups.json <- pmu-events/arch/x86/haswell/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/other.json <- pmu-events/arch/x86/haswell/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/pipeline.json <- pmu-events/arch/x86/haswell/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/uncore-other.json <- pmu-events/arch/x86/haswell/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/core.json <- pmu-events/arch/x86/amdzen3/core.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/memory.json <- pmu-events/arch/x86/amdzen3/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/cache.json <- pmu-events/arch/x86/amdzen3/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/floating-point.json <- pmu-events/arch/x86/amdzen3/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/data-fabric.json <- pmu-events/arch/x86/amdzen3/data-fabric.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/other.json <- pmu-events/arch/x86/amdzen3/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/branch.json <- pmu-events/arch/x86/amdzen3/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/recommended.json <- pmu-events/arch/x86/amdzen3/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/memory.json <- pmu-events/arch/x86/goldmont/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/cache.json <- pmu-events/arch/x86/goldmont/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/floating-point.json <- pmu-events/arch/x86/goldmont/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/frontend.json <- pmu-events/arch/x86/goldmont/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/virtual-memory.json <- pmu-events/arch/x86/goldmont/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/other.json <- pmu-events/arch/x86/goldmont/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/pipeline.json <- pmu-events/arch/x86/goldmont/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-io.json <- pmu-events/arch/x86/broadwellx/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-power.json <- pmu-events/arch/x86/broadwellx/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-cache.json <- pmu-events/arch/x86/broadwellx/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/memory.json <- pmu-events/arch/x86/broadwellx/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-interconnect.json <- pmu-events/arch/x86/broadwellx/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/cache.json <- pmu-events/arch/x86/broadwellx/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/floating-point.json <- pmu-events/arch/x86/broadwellx/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/frontend.json <- pmu-events/arch/x86/broadwellx/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/virtual-memory.json <- pmu-events/arch/x86/broadwellx/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-memory.json <- pmu-events/arch/x86/broadwellx/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/metricgroups.json <- pmu-events/arch/x86/broadwellx/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/other.json <- pmu-events/arch/x86/broadwellx/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/pipeline.json <- pmu-events/arch/x86/broadwellx/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/bdx-metrics.json <- pmu-events/arch/x86/broadwellx/bdx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-io.json <- pmu-events/arch/x86/haswellx/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-power.json <- pmu-events/arch/x86/haswellx/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/hsx-metrics.json <- pmu-events/arch/x86/haswellx/hsx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-cache.json <- pmu-events/arch/x86/haswellx/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/memory.json <- pmu-events/arch/x86/haswellx/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-interconnect.json <- pmu-events/arch/x86/haswellx/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/cache.json <- pmu-events/arch/x86/haswellx/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/floating-point.json <- pmu-events/arch/x86/haswellx/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/frontend.json <- pmu-events/arch/x86/haswellx/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/virtual-memory.json <- pmu-events/arch/x86/haswellx/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-memory.json <- pmu-events/arch/x86/haswellx/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/metricgroups.json <- pmu-events/arch/x86/haswellx/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/other.json <- pmu-events/arch/x86/haswellx/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/pipeline.json <- pmu-events/arch/x86/haswellx/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/memory.json <- pmu-events/arch/x86/nehalemex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/cache.json <- pmu-events/arch/x86/nehalemex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/floating-point.json <- pmu-events/arch/x86/nehalemex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/frontend.json <- pmu-events/arch/x86/nehalemex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/virtual-memory.json <- pmu-events/arch/x86/nehalemex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/other.json <- pmu-events/arch/x86/nehalemex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/pipeline.json <- pmu-events/arch/x86/nehalemex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-io.json <- pmu-events/arch/x86/icelakex/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-power.json <- pmu-events/arch/x86/icelakex/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-cache.json <- pmu-events/arch/x86/icelakex/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/memory.json <- pmu-events/arch/x86/icelakex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-interconnect.json <- pmu-events/arch/x86/icelakex/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/cache.json <- pmu-events/arch/x86/icelakex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/floating-point.json <- pmu-events/arch/x86/icelakex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/frontend.json <- pmu-events/arch/x86/icelakex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/virtual-memory.json <- pmu-events/arch/x86/icelakex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-memory.json <- pmu-events/arch/x86/icelakex/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/icx-metrics.json <- pmu-events/arch/x86/icelakex/icx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/metricgroups.json <- pmu-events/arch/x86/icelakex/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/other.json <- pmu-events/arch/x86/icelakex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/pipeline.json <- pmu-events/arch/x86/icelakex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/memory.json <- pmu-events/arch/x86/lunarlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/cache.json <- pmu-events/arch/x86/lunarlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/frontend.json <- pmu-events/arch/x86/lunarlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/virtual-memory.json <- pmu-events/arch/x86/lunarlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/other.json <- pmu-events/arch/x86/lunarlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/pipeline.json <- pmu-events/arch/x86/lunarlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/core.json <- pmu-events/arch/x86/amdzen1/core.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/memory.json <- pmu-events/arch/x86/amdzen1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/cache.json <- pmu-events/arch/x86/amdzen1/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/floating-point.json <- pmu-events/arch/x86/amdzen1/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/data-fabric.json <- pmu-events/arch/x86/amdzen1/data-fabric.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/other.json <- pmu-events/arch/x86/amdzen1/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/branch.json <- pmu-events/arch/x86/amdzen1/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/recommended.json <- pmu-events/arch/x86/amdzen1/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/memory.json <- pmu-events/arch/x86/alderlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/uncore-interconnect.json <- pmu-events/arch/x86/alderlake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/cache.json <- pmu-events/arch/x86/alderlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/floating-point.json <- pmu-events/arch/x86/alderlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/frontend.json <- pmu-events/arch/x86/alderlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/virtual-memory.json <- pmu-events/arch/x86/alderlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/uncore-memory.json <- pmu-events/arch/x86/alderlake/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/metricgroups.json <- pmu-events/arch/x86/alderlake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/other.json <- pmu-events/arch/x86/alderlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/pipeline.json <- pmu-events/arch/x86/alderlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/adl-metrics.json <- pmu-events/arch/x86/alderlake/adl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/uncore-other.json <- pmu-events/arch/x86/alderlake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/adln-metrics.json <- pmu-events/arch/x86/alderlaken/adln-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/memory.json <- pmu-events/arch/x86/alderlaken/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/uncore-interconnect.json <- pmu-events/arch/x86/alderlaken/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/cache.json <- pmu-events/arch/x86/alderlaken/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/floating-point.json <- pmu-events/arch/x86/alderlaken/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/frontend.json <- pmu-events/arch/x86/alderlaken/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/virtual-memory.json <- pmu-events/arch/x86/alderlaken/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/uncore-memory.json <- pmu-events/arch/x86/alderlaken/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/metricgroups.json <- pmu-events/arch/x86/alderlaken/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/other.json <- pmu-events/arch/x86/alderlaken/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/pipeline.json <- pmu-events/arch/x86/alderlaken/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/uncore-other.json <- pmu-events/arch/x86/alderlaken/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/clx-metrics.json <- pmu-events/arch/x86/cascadelakex/clx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-io.json <- pmu-events/arch/x86/cascadelakex/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-power.json <- pmu-events/arch/x86/cascadelakex/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-cache.json <- pmu-events/arch/x86/cascadelakex/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/memory.json <- pmu-events/arch/x86/cascadelakex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-interconnect.json <- pmu-events/arch/x86/cascadelakex/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/cache.json <- pmu-events/arch/x86/cascadelakex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/floating-point.json <- pmu-events/arch/x86/cascadelakex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/frontend.json <- pmu-events/arch/x86/cascadelakex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/virtual-memory.json <- pmu-events/arch/x86/cascadelakex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-memory.json <- pmu-events/arch/x86/cascadelakex/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/metricgroups.json <- pmu-events/arch/x86/cascadelakex/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/other.json <- pmu-events/arch/x86/cascadelakex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/pipeline.json <- pmu-events/arch/x86/cascadelakex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/memory.json <- pmu-events/arch/x86/silvermont/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/cache.json <- pmu-events/arch/x86/silvermont/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/floating-point.json <- pmu-events/arch/x86/silvermont/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/frontend.json <- pmu-events/arch/x86/silvermont/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/virtual-memory.json <- pmu-events/arch/x86/silvermont/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/other.json <- pmu-events/arch/x86/silvermont/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/pipeline.json <- pmu-events/arch/x86/silvermont/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/memory.json <- pmu-events/arch/x86/tigerlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/tgl-metrics.json <- pmu-events/arch/x86/tigerlake/tgl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/uncore-interconnect.json <- pmu-events/arch/x86/tigerlake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/cache.json <- pmu-events/arch/x86/tigerlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/floating-point.json <- pmu-events/arch/x86/tigerlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/frontend.json <- pmu-events/arch/x86/tigerlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/virtual-memory.json <- pmu-events/arch/x86/tigerlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/uncore-memory.json <- pmu-events/arch/x86/tigerlake/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/metricgroups.json <- pmu-events/arch/x86/tigerlake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/other.json <- pmu-events/arch/x86/tigerlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/pipeline.json <- pmu-events/arch/x86/tigerlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/uncore-other.json <- pmu-events/arch/x86/tigerlake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/memory.json <- pmu-events/arch/x86/sierraforest/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/cache.json <- pmu-events/arch/x86/sierraforest/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/frontend.json <- pmu-events/arch/x86/sierraforest/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/virtual-memory.json <- pmu-events/arch/x86/sierraforest/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/other.json <- pmu-events/arch/x86/sierraforest/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/pipeline.json <- pmu-events/arch/x86/sierraforest/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/memory.json <- pmu-events/arch/x86/goldmontplus/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/cache.json <- pmu-events/arch/x86/goldmontplus/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/floating-point.json <- pmu-events/arch/x86/goldmontplus/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/frontend.json <- pmu-events/arch/x86/goldmontplus/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/virtual-memory.json <- pmu-events/arch/x86/goldmontplus/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/other.json <- pmu-events/arch/x86/goldmontplus/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/pipeline.json <- pmu-events/arch/x86/goldmontplus/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/core.json <- pmu-events/arch/x86/amdzen4/core.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/memory.json <- pmu-events/arch/x86/amdzen4/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/cache.json <- pmu-events/arch/x86/amdzen4/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/floating-point.json <- pmu-events/arch/x86/amdzen4/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/data-fabric.json <- pmu-events/arch/x86/amdzen4/data-fabric.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/other.json <- pmu-events/arch/x86/amdzen4/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/branch.json <- pmu-events/arch/x86/amdzen4/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/recommended.json <- pmu-events/arch/x86/amdzen4/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/pipeline.json <- pmu-events/arch/x86/amdzen4/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/memory-controller.json <- pmu-events/arch/x86/amdzen4/memory-controller.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/uncore-cache.json <- pmu-events/arch/x86/ivybridge/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/memory.json <- pmu-events/arch/x86/ivybridge/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/uncore-interconnect.json <- pmu-events/arch/x86/ivybridge/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/cache.json <- pmu-events/arch/x86/ivybridge/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/floating-point.json <- pmu-events/arch/x86/ivybridge/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/frontend.json <- pmu-events/arch/x86/ivybridge/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/virtual-memory.json <- pmu-events/arch/x86/ivybridge/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/metricgroups.json <- pmu-events/arch/x86/ivybridge/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/other.json <- pmu-events/arch/x86/ivybridge/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/pipeline.json <- pmu-events/arch/x86/ivybridge/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/ivb-metrics.json <- pmu-events/arch/x86/ivybridge/ivb-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/memory.json <- pmu-events/arch/x86/rocketlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/uncore-interconnect.json <- pmu-events/arch/x86/rocketlake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/cache.json <- pmu-events/arch/x86/rocketlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/floating-point.json <- pmu-events/arch/x86/rocketlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/frontend.json <- pmu-events/arch/x86/rocketlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/virtual-memory.json <- pmu-events/arch/x86/rocketlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/rkl-metrics.json <- pmu-events/arch/x86/rocketlake/rkl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/metricgroups.json <- pmu-events/arch/x86/rocketlake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/other.json <- pmu-events/arch/x86/rocketlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/pipeline.json <- pmu-events/arch/x86/rocketlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/uncore-other.json <- pmu-events/arch/x86/rocketlake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/memory.json <- pmu-events/arch/x86/nehalemep/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/cache.json <- pmu-events/arch/x86/nehalemep/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/floating-point.json <- pmu-events/arch/x86/nehalemep/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/frontend.json <- pmu-events/arch/x86/nehalemep/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/virtual-memory.json <- pmu-events/arch/x86/nehalemep/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/other.json <- pmu-events/arch/x86/nehalemep/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/pipeline.json <- pmu-events/arch/x86/nehalemep/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/uncore-cache.json <- pmu-events/arch/x86/broadwell/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/memory.json <- pmu-events/arch/x86/broadwell/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/uncore-interconnect.json <- pmu-events/arch/x86/broadwell/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/cache.json <- pmu-events/arch/x86/broadwell/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/floating-point.json <- pmu-events/arch/x86/broadwell/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/frontend.json <- pmu-events/arch/x86/broadwell/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/bdw-metrics.json <- pmu-events/arch/x86/broadwell/bdw-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/virtual-memory.json <- pmu-events/arch/x86/broadwell/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/metricgroups.json <- pmu-events/arch/x86/broadwell/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/other.json <- pmu-events/arch/x86/broadwell/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/pipeline.json <- pmu-events/arch/x86/broadwell/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/uncore-other.json <- pmu-events/arch/x86/broadwell/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/memory.json <- pmu-events/arch/x86/westmereep-dp/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/cache.json <- pmu-events/arch/x86/westmereep-dp/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/floating-point.json <- pmu-events/arch/x86/westmereep-dp/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/frontend.json <- pmu-events/arch/x86/westmereep-dp/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/virtual-memory.json <- pmu-events/arch/x86/westmereep-dp/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/other.json <- pmu-events/arch/x86/westmereep-dp/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/pipeline.json <- pmu-events/arch/x86/westmereep-dp/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/icl-metrics.json <- pmu-events/arch/x86/icelake/icl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/memory.json <- pmu-events/arch/x86/icelake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/uncore-interconnect.json <- pmu-events/arch/x86/icelake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/cache.json <- pmu-events/arch/x86/icelake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/floating-point.json <- pmu-events/arch/x86/icelake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/frontend.json <- pmu-events/arch/x86/icelake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/virtual-memory.json <- pmu-events/arch/x86/icelake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/metricgroups.json <- pmu-events/arch/x86/icelake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/other.json <- pmu-events/arch/x86/icelake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/pipeline.json <- pmu-events/arch/x86/icelake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/uncore-other.json <- pmu-events/arch/x86/icelake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-io.json <- pmu-events/arch/x86/sapphirerapids/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-power.json <- pmu-events/arch/x86/sapphirerapids/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-cache.json <- pmu-events/arch/x86/sapphirerapids/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/memory.json <- pmu-events/arch/x86/sapphirerapids/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json <- pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/cache.json <- pmu-events/arch/x86/sapphirerapids/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/floating-point.json <- pmu-events/arch/x86/sapphirerapids/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-cxl.json <- pmu-events/arch/x86/sapphirerapids/uncore-cxl.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/frontend.json <- pmu-events/arch/x86/sapphirerapids/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/virtual-memory.json <- pmu-events/arch/x86/sapphirerapids/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-memory.json <- pmu-events/arch/x86/sapphirerapids/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/spr-metrics.json <- pmu-events/arch/x86/sapphirerapids/spr-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/metricgroups.json <- pmu-events/arch/x86/sapphirerapids/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/other.json <- pmu-events/arch/x86/sapphirerapids/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/pipeline.json <- pmu-events/arch/x86/sapphirerapids/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/mapfile.csv <- pmu-events/arch/s390/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_zec12/extended.json <- pmu-events/arch/s390/cf_zec12/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_zec12/basic.json <- pmu-events/arch/s390/cf_zec12/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_zec12/crypto.json <- pmu-events/arch/s390/cf_zec12/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_zec12/transaction.json <- pmu-events/arch/s390/cf_zec12/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z13/extended.json <- pmu-events/arch/s390/cf_z13/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z13/basic.json <- pmu-events/arch/s390/cf_z13/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z13/crypto.json <- pmu-events/arch/s390/cf_z13/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z13/transaction.json <- pmu-events/arch/s390/cf_z13/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z196/extended.json <- pmu-events/arch/s390/cf_z196/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z196/basic.json <- pmu-events/arch/s390/cf_z196/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z196/crypto.json <- pmu-events/arch/s390/cf_z196/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z10/extended.json <- pmu-events/arch/s390/cf_z10/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z10/basic.json <- pmu-events/arch/s390/cf_z10/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z10/crypto.json <- pmu-events/arch/s390/cf_z10/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z14/extended.json <- pmu-events/arch/s390/cf_z14/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z14/basic.json <- pmu-events/arch/s390/cf_z14/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z14/crypto.json <- pmu-events/arch/s390/cf_z14/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z14/transaction.json <- pmu-events/arch/s390/cf_z14/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z15/extended.json <- pmu-events/arch/s390/cf_z15/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z15/basic.json <- pmu-events/arch/s390/cf_z15/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z15/crypto6.json <- pmu-events/arch/s390/cf_z15/crypto6.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z15/transaction.json <- pmu-events/arch/s390/cf_z15/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/extended.json <- pmu-events/arch/s390/cf_z16/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/pai_ext.json <- pmu-events/arch/s390/cf_z16/pai_ext.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/basic.json <- pmu-events/arch/s390/cf_z16/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/crypto6.json <- pmu-events/arch/s390/cf_z16/crypto6.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/transaction.json <- pmu-events/arch/s390/cf_z16/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/pai_crypto.json <- pmu-events/arch/s390/cf_z16/pai_crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/memory.json <- pmu-events/arch/arm64/arm/cortex-a34/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/instruction.json <- pmu-events/arch/arm64/arm/cortex-a34/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/cache.json <- pmu-events/arch/arm64/arm/cortex-a34/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/bus.json <- pmu-events/arch/arm64/arm/cortex-a34/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/exception.json <- pmu-events/arch/arm64/arm/cortex-a34/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/branch.json <- pmu-events/arch/arm64/arm/cortex-a34/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/l2_cache.json <- pmu-events/arch/arm64/arm/neoverse-v1/l2_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/ll_cache.json <- pmu-events/arch/arm64/arm/neoverse-v1/ll_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/spe.json <- pmu-events/arch/arm64/arm/neoverse-v1/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/tlb.json <- pmu-events/arch/arm64/arm/neoverse-v1/tlb.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/memory.json <- pmu-events/arch/arm64/arm/neoverse-v1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/retired.json <- pmu-events/arch/arm64/arm/neoverse-v1/retired.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/metrics.json <- pmu-events/arch/arm64/arm/neoverse-v1/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/stall.json <- pmu-events/arch/arm64/arm/neoverse-v1/stall.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json <- pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json <- pmu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/bus.json <- pmu-events/arch/arm64/arm/neoverse-v1/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/exception.json <- pmu-events/arch/arm64/arm/neoverse-v1/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/sve.json <- pmu-events/arch/arm64/arm/neoverse-v1/sve.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/general.json <- pmu-events/arch/arm64/arm/neoverse-v1/general.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/l3_cache.json <- pmu-events/arch/arm64/arm/neoverse-v1/l3_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json <- pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/l1d_cache.json <- pmu-events/arch/arm64/arm/neoverse-v1/l1d_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/etm.json <- pmu-events/arch/arm64/arm/cortex-a73/etm.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/memory.json <- pmu-events/arch/arm64/arm/cortex-a73/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/instruction.json <- pmu-events/arch/arm64/arm/cortex-a73/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/cache.json <- pmu-events/arch/arm64/arm/cortex-a73/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/bus.json <- pmu-events/arch/arm64/arm/cortex-a73/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/exception.json <- pmu-events/arch/arm64/arm/cortex-a73/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/branch.json <- pmu-events/arch/arm64/arm/cortex-a73/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a73/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/mmu.json <- pmu-events/arch/arm64/arm/cortex-a73/mmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/ifu.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/ifu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/memory.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/instruction.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/cache.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/bus.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/exception.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/dpu.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/dpu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/branch.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a65-e1/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/memory.json <- pmu-events/arch/arm64/arm/cortex-a510/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/instruction.json <- pmu-events/arch/arm64/arm/cortex-a510/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/cache.json <- pmu-events/arch/arm64/arm/cortex-a510/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/pmu.json <- pmu-events/arch/arm64/arm/cortex-a510/pmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/bus.json <- pmu-events/arch/arm64/arm/cortex-a510/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/exception.json <- pmu-events/arch/arm64/arm/cortex-a510/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/trace.json <- pmu-events/arch/arm64/arm/cortex-a510/trace.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/branch.json <- pmu-events/arch/arm64/arm/cortex-a510/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a510/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/memory.json <- pmu-events/arch/arm64/arm/cortex-x2/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/instruction.json <- pmu-events/arch/arm64/arm/cortex-x2/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/cache.json <- pmu-events/arch/arm64/arm/cortex-x2/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/bus.json <- pmu-events/arch/arm64/arm/cortex-x2/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/exception.json <- pmu-events/arch/arm64/arm/cortex-x2/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/trace.json <- pmu-events/arch/arm64/arm/cortex-x2/trace.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/branch.json <- pmu-events/arch/arm64/arm/cortex-x2/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/pipeline.json <- pmu-events/arch/arm64/arm/cortex-x2/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/memory.json <- pmu-events/arch/arm64/arm/cortex-a35/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/instruction.json <- pmu-events/arch/arm64/arm/cortex-a35/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/cache.json <- pmu-events/arch/arm64/arm/cortex-a35/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/bus.json <- pmu-events/arch/arm64/arm/cortex-a35/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/exception.json <- pmu-events/arch/arm64/arm/cortex-a35/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/branch.json <- pmu-events/arch/arm64/arm/cortex-a35/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/etm.json <- pmu-events/arch/arm64/arm/cortex-a75/etm.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/memory.json <- pmu-events/arch/arm64/arm/cortex-a75/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/instruction.json <- pmu-events/arch/arm64/arm/cortex-a75/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/cache.json <- pmu-events/arch/arm64/arm/cortex-a75/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/bus.json <- pmu-events/arch/arm64/arm/cortex-a75/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/exception.json <- pmu-events/arch/arm64/arm/cortex-a75/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/branch.json <- pmu-events/arch/arm64/arm/cortex-a75/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a75/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/mmu.json <- pmu-events/arch/arm64/arm/cortex-a75/mmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cmn/sys/cmn.json <- pmu-events/arch/arm64/arm/cmn/sys/cmn.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cmn/sys/metric.json <- pmu-events/arch/arm64/arm/cmn/sys/metric.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/memory.json <- pmu-events/arch/arm64/arm/cortex-x1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/instruction.json <- pmu-events/arch/arm64/arm/cortex-x1/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/cache.json <- pmu-events/arch/arm64/arm/cortex-x1/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/bus.json <- pmu-events/arch/arm64/arm/cortex-x1/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/exception.json <- pmu-events/arch/arm64/arm/cortex-x1/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/branch.json <- pmu-events/arch/arm64/arm/cortex-x1/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/pipeline.json <- pmu-events/arch/arm64/arm/cortex-x1/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json <- pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json <- pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/spe.json <- pmu-events/arch/arm64/arm/neoverse-n1/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/tlb.json <- pmu-events/arch/arm64/arm/neoverse-n1/tlb.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/memory.json <- pmu-events/arch/arm64/arm/neoverse-n1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/retired.json <- pmu-events/arch/arm64/arm/neoverse-n1/retired.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/metrics.json <- pmu-events/arch/arm64/arm/neoverse-n1/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/stall.json <- pmu-events/arch/arm64/arm/neoverse-n1/stall.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json <- pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json <- pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/bus.json <- pmu-events/arch/arm64/arm/neoverse-n1/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/exception.json <- pmu-events/arch/arm64/arm/neoverse-n1/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/general.json <- pmu-events/arch/arm64/arm/neoverse-n1/general.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json <- pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json <- pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/memory.json <- pmu-events/arch/arm64/arm/cortex-a76/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/instruction.json <- pmu-events/arch/arm64/arm/cortex-a76/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/cache.json <- pmu-events/arch/arm64/arm/cortex-a76/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/bus.json <- pmu-events/arch/arm64/arm/cortex-a76/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/exception.json <- pmu-events/arch/arm64/arm/cortex-a76/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/branch.json <- pmu-events/arch/arm64/arm/cortex-a76/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a76/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/memory.json <- pmu-events/arch/arm64/arm/cortex-a53/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/cache.json <- pmu-events/arch/arm64/arm/cortex-a53/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/bus.json <- pmu-events/arch/arm64/arm/cortex-a53/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/other.json <- pmu-events/arch/arm64/arm/cortex-a53/other.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/branch.json <- pmu-events/arch/arm64/arm/cortex-a53/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a53/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json <- pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json <- pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json <- pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json <- pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json <- pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json <- pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/memory.json <- pmu-events/arch/arm64/arm/cortex-a710/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/instruction.json <- pmu-events/arch/arm64/arm/cortex-a710/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/cache.json <- pmu-events/arch/arm64/arm/cortex-a710/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/bus.json <- pmu-events/arch/arm64/arm/cortex-a710/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/exception.json <- pmu-events/arch/arm64/arm/cortex-a710/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/trace.json <- pmu-events/arch/arm64/arm/cortex-a710/trace.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/branch.json <- pmu-events/arch/arm64/arm/cortex-a710/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a710/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/memory.json <- pmu-events/arch/arm64/arm/cortex-a77/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/instruction.json <- pmu-events/arch/arm64/arm/cortex-a77/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/cache.json <- pmu-events/arch/arm64/arm/cortex-a77/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/bus.json <- pmu-events/arch/arm64/arm/cortex-a77/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/exception.json <- pmu-events/arch/arm64/arm/cortex-a77/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/branch.json <- pmu-events/arch/arm64/arm/cortex-a77/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a77/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/memory.json <- pmu-events/arch/arm64/arm/cortex-a78/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/instruction.json <- pmu-events/arch/arm64/arm/cortex-a78/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/cache.json <- pmu-events/arch/arm64/arm/cortex-a78/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/bus.json <- pmu-events/arch/arm64/arm/cortex-a78/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/exception.json <- pmu-events/arch/arm64/arm/cortex-a78/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/branch.json <- pmu-events/arch/arm64/arm/cortex-a78/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a78/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/l1i_cache.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/l1i_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/bus.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/sve.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/sve.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/fp_operation.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/fp_operation.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json <- pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/memory.json <- pmu-events/arch/arm64/arm/cortex-a55/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/instruction.json <- pmu-events/arch/arm64/arm/cortex-a55/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/cache.json <- pmu-events/arch/arm64/arm/cortex-a55/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/bus.json <- pmu-events/arch/arm64/arm/cortex-a55/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/exception.json <- pmu-events/arch/arm64/arm/cortex-a55/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/branch.json <- pmu-events/arch/arm64/arm/cortex-a55/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/pipeline.json <- pmu-events/arch/arm64/arm/cortex-a55/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json <- pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json <- pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json <- pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json <- pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json <- pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json <- pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json <- pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json <- pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json <- pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json <- pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json <- pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/mapfile.csv <- pmu-events/arch/arm64/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/arm64/sbsa.json <- pmu-events/arch/arm64/sbsa.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json <- pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json <- pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/metrics.json <- pmu-events/arch/arm64/hisilicon/hip08/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json <- pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json <- pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json <- pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/memory.json <- pmu-events/arch/arm64/ampere/emag/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/instruction.json <- pmu-events/arch/arm64/ampere/emag/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/cache.json <- pmu-events/arch/arm64/ampere/emag/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/bus.json <- pmu-events/arch/arm64/ampere/emag/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/exception.json <- pmu-events/arch/arm64/ampere/emag/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/intrinsic.json <- pmu-events/arch/arm64/ampere/emag/intrinsic.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/branch.json <- pmu-events/arch/arm64/ampere/emag/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/clock.json <- pmu-events/arch/arm64/ampere/emag/clock.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/pipeline.json <- pmu-events/arch/arm64/ampere/emag/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/spe.json <- pmu-events/arch/arm64/ampere/ampereone/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json <- pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/memory.json <- pmu-events/arch/arm64/ampere/ampereone/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/metrics.json <- pmu-events/arch/arm64/ampere/ampereone/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/instruction.json <- pmu-events/arch/arm64/ampere/ampereone/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/cache.json <- pmu-events/arch/arm64/ampere/ampereone/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/bus.json <- pmu-events/arch/arm64/ampere/ampereone/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/exception.json <- pmu-events/arch/arm64/ampere/ampereone/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/intrinsic.json <- pmu-events/arch/arm64/ampere/ampereone/intrinsic.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/branch.json <- pmu-events/arch/arm64/ampere/ampereone/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/pipeline.json <- pmu-events/arch/arm64/ampere/ampereone/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/spe.json <- pmu-events/arch/arm64/ampere/ampereonex/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json <- pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/memory.json <- pmu-events/arch/arm64/ampere/ampereonex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/metrics.json <- pmu-events/arch/arm64/ampere/ampereonex/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/instruction.json <- pmu-events/arch/arm64/ampere/ampereonex/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/cache.json <- pmu-events/arch/arm64/ampere/ampereonex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/bus.json <- pmu-events/arch/arm64/ampere/ampereonex/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/exception.json <- pmu-events/arch/arm64/ampere/ampereonex/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json <- pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/branch.json <- pmu-events/arch/arm64/ampere/ampereonex/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/pipeline.json <- pmu-events/arch/arm64/ampere/ampereonex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/mmu.json <- pmu-events/arch/arm64/ampere/ampereonex/mmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/recommended.json <- pmu-events/arch/arm64/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/common-and-microarch.json <- pmu-events/arch/arm64/common-and-microarch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/cycle.json <- pmu-events/arch/arm64/fujitsu/a64fx/cycle.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/memory.json <- pmu-events/arch/arm64/fujitsu/a64fx/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/instruction.json <- pmu-events/arch/arm64/fujitsu/a64fx/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/cache.json <- pmu-events/arch/arm64/fujitsu/a64fx/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/bus.json <- pmu-events/arch/arm64/fujitsu/a64fx/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/exception.json <- pmu-events/arch/arm64/fujitsu/a64fx/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/sve.json <- pmu-events/arch/arm64/fujitsu/a64fx/sve.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/other.json <- pmu-events/arch/arm64/fujitsu/a64fx/other.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/branch.json <- pmu-events/arch/arm64/fujitsu/a64fx/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json <- pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/nds32/n13/atcpmu.json <- pmu-events/arch/nds32/n13/atcpmu.json dependency dropped.
make[3]: Circular pmu-events/arch/nds32/mapfile.csv <- pmu-events/arch/nds32/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/mapfile.csv <- pmu-events/arch/powerpc/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/memory.json <- pmu-events/arch/powerpc/power8/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/metrics.json <- pmu-events/arch/powerpc/power8/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/pmc.json <- pmu-events/arch/powerpc/power8/pmc.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/cache.json <- pmu-events/arch/powerpc/power8/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/floating-point.json <- pmu-events/arch/powerpc/power8/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/frontend.json <- pmu-events/arch/powerpc/power8/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/other.json <- pmu-events/arch/powerpc/power8/other.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/translation.json <- pmu-events/arch/powerpc/power8/translation.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/marked.json <- pmu-events/arch/powerpc/power8/marked.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/pipeline.json <- pmu-events/arch/powerpc/power8/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/memory.json <- pmu-events/arch/powerpc/power10/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/nest_metrics.json <- pmu-events/arch/powerpc/power10/nest_metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/datasource.json <- pmu-events/arch/powerpc/power10/datasource.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/metrics.json <- pmu-events/arch/powerpc/power10/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/pmc.json <- pmu-events/arch/powerpc/power10/pmc.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/floating_point.json <- pmu-events/arch/powerpc/power10/floating_point.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/cache.json <- pmu-events/arch/powerpc/power10/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/frontend.json <- pmu-events/arch/powerpc/power10/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/others.json <- pmu-events/arch/powerpc/power10/others.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/locks.json <- pmu-events/arch/powerpc/power10/locks.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/translation.json <- pmu-events/arch/powerpc/power10/translation.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/marked.json <- pmu-events/arch/powerpc/power10/marked.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/pipeline.json <- pmu-events/arch/powerpc/power10/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/memory.json <- pmu-events/arch/powerpc/power9/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/nest_metrics.json <- pmu-events/arch/powerpc/power9/nest_metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/metrics.json <- pmu-events/arch/powerpc/power9/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/pmc.json <- pmu-events/arch/powerpc/power9/pmc.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/cache.json <- pmu-events/arch/powerpc/power9/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/floating-point.json <- pmu-events/arch/powerpc/power9/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/frontend.json <- pmu-events/arch/powerpc/power9/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/other.json <- pmu-events/arch/powerpc/power9/other.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/translation.json <- pmu-events/arch/powerpc/power9/translation.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/marked.json <- pmu-events/arch/powerpc/power9/marked.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/pipeline.json <- pmu-events/arch/powerpc/power9/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/test/arch-std-events.json <- pmu-events/arch/test/arch-std-events.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/uncore.json <- pmu-events/arch/test/test_soc/cpu/uncore.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/metrics.json <- pmu-events/arch/test/test_soc/cpu/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/cache.json <- pmu-events/arch/test/test_soc/cpu/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/other.json <- pmu-events/arch/test/test_soc/cpu/other.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/branch.json <- pmu-events/arch/test/test_soc/cpu/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/sys/uncore.json <- pmu-events/arch/test/test_soc/sys/uncore.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/sifive/u74/memory.json <- pmu-events/arch/riscv/sifive/u74/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/sifive/u74/instructions.json <- pmu-events/arch/riscv/sifive/u74/instructions.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/sifive/u74/firmware.json <- pmu-events/arch/riscv/sifive/u74/firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/sifive/u74/microarch.json <- pmu-events/arch/riscv/sifive/u74/microarch.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/mapfile.csv <- pmu-events/arch/riscv/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/riscv/riscv-sbi-firmware.json <- pmu-events/arch/riscv/riscv-sbi-firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/thead/c900-legacy/instruction.json <- pmu-events/arch/riscv/thead/c900-legacy/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/thead/c900-legacy/firmware.json <- pmu-events/arch/riscv/thead/c900-legacy/firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/thead/c900-legacy/cache.json <- pmu-events/arch/riscv/thead/c900-legacy/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/thead/c900-legacy/microarch.json <- pmu-events/arch/riscv/thead/c900-legacy/microarch.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/starfive/dubhe-80/firmware.json <- pmu-events/arch/riscv/starfive/dubhe-80/firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/starfive/dubhe-80/common.json <- pmu-events/arch/riscv/starfive/dubhe-80/common.json dependency dropped.
Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/amd_metrics.py", line 42, in <module>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:45: pmu-events/arch/x86/amdzen1/extra-metrics.json] Error 1
make[3]: *** Deleting file 'pmu-events/arch/x86/amdzen1/extra-metrics.json'
make[3]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/amd_metrics.py", line 42, in <module>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-d3ed44a7bee70b097709fe06f339c468489f16c9/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:45: pmu-events/arch/x86/amdzen2/extra-metrics.json] Error 1
make[3]: *** Deleting file 'pmu-events/arch/x86/amdzen2/extra-metrics.json'
make[2]: *** [Makefile.perf:706: pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:261: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

--TiJHmnqND8oovjPL--

