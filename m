Return-Path: <linux-kernel+bounces-151026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2D8AA81B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6E8283F93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF8C121;
	Fri, 19 Apr 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deweYOoo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36710B663
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506172; cv=fail; b=VRxZVrsLaIGARAXUf6Uc0XK8JmThm2/2Kp2zkPplWRhMgCUzjs8xXB2rSWHGPyRuUj6L5psNohw+3YF+MsDnUrqVezgCtbIRppUcpr6f7pnmhpQ6AHgYUp6XGvcAUoqKw3ikcs2oaTYe9mJx8uhGFz3LbEiO25LenSc0H2uTefk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506172; c=relaxed/simple;
	bh=CjUioqfUZMaOtl8H9G2oRaMfId83bt1cQlT+hKAs8NI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MAn+jyjTSJWcc/gOdtgUx/IBAjgfBtYiKF0GsuYR4G5J8q+C4qdf3QILF8MyMdq5QauAAP7IlUJBCiN8vjSq7yw7vRHoCNyfBflze4H45LZ0rGZuPZXPP3LeEJppVTcuxbGcMUd11SHpXvM5AuFp75PEjF6WeUiGEiYFhAdlRQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deweYOoo; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713506168; x=1745042168;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=CjUioqfUZMaOtl8H9G2oRaMfId83bt1cQlT+hKAs8NI=;
  b=deweYOooQWa/3bpd9r3wHEqRgPd+RJNPIkp0+dcq/qLNnXnaCooQlvUP
   WBwUHJiGYQ0Zk+XA+VI6pxZkPqCrMvaWd826v91+iZoOF8onOsyO+g8JG
   OzwbLCQ/2jxxD5Za2ttE9XrOL6Kxi/98Eg3nKttVqpL1Nqjj3gmoyDd+x
   T6Zmqv5xl4EigxXh3eZV5gHX8HxiVzjuqK2NI+uX7/ieiaokpsifeWbeO
   W2V0YQ8Dir0Ybhz4oiZfptBO8VUKCWlNNaILm8ze0VCkGatSMFwko/PbJ
   WtfovIVYexQM19i71xFWFB3ms8PoK1mAdo6tlMeTuhCaStpVrxRZifvbh
   g==;
X-CSE-ConnectionGUID: q+V2PFB6TVa/iuRd0XiF+Q==
X-CSE-MsgGUID: RoSho2roRcqbhXYZwFcOBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20516915"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="20516915"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 22:56:07 -0700
X-CSE-ConnectionGUID: FMkUL0SMRym44Bw/ochyrg==
X-CSE-MsgGUID: LG+CfSOlT0yfLpkC/mmIlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27856849"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 22:56:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 22:56:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 22:56:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 22:56:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 22:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTc3XEK0xtu4kGMGoYAXQyEyaZDNveI7nbqFLO9QUBJWccBfz7D8I4tOb0KWTVvkxEfkWKG7mkVj9L20Mw8Upzw+oHmt6AF1F9+RHSsY5RRPBY/aDgPhOuKB+aCWSu0AjnSsh5FDweSv6Q/wMpuDiKyE0GX4ylycbWr3UryQqmuNT0mw0gOruQZONMqA/iQ78XTYwtjOx1DKZl6zO6mNxNFabhT/nNLFLg+jtdI8jNcY0Ey9QP26+KWjcGcKIZ2zs0gP/g33Dpp56XXB6VAa2KjGhHMrhfgshMteXL/U7vec1Cs2Vea4i72oyoTikQd137tIllHmLtkExdm5MUQqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChAMAoSdl9ZvBa/cFM2FsFFTm2/2G8r6Q/S5ADbSe2c=;
 b=XWcX1jtbL09HFQ9qTdkDxvQkIRxIDYLVCmm+3pXqVa2KMj91z9FVNXuKtSs2UT+1ftxteW5bvZAUsyL9Pvtzcg8cLfRi+bsSMHOHl0wghOazugQvfUj2RVrJEjV7z8pm+xKwFLtLn8Y++yXAjWSiYsYPiES+SKwHNPwiK+78jii25w5h+L+RPEoinEnlPgrWfiWQiBEnymWf1KoEpEv9N8tVyzJRPRhBeFSCjhfpbxoGmoF3C5OJRZiQw8o4J+k27b0ewOs/IEf6tq4NRuQ/TSoD0TYoe6Hn+ZVyJnUUOnkvoeF8BS3ofc9GeSpgGlJUM92llkjpX1bdyErCjCIBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 05:56:03 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 05:56:02 +0000
Date: Fri, 19 Apr 2024 13:49:26 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: [linus:master] [x86/syscall] 1e3ad78334:
 will-it-scale.per_process_ops 1.4% improvement
Message-ID: <202404191333.178a0eed-yujie.liu@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|SJ0PR11MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 87035bfa-3888-4598-3af8-08dc603564ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 4AzfBKyjPshOLEcmbApWknMq0YqomrEUbv2i8inIGavl/sBZ20Q7sZ9fGJYBZqpt87BIyl29ibQ2kZnC34WIAGnIh+a+JlkiJooTnp54wQNNPH8JVx4bFn46Ixg3aw6X2uFXdQgH0V9J75PsiopzVD1tVrlp7gIDxdPp6JNW+kMwNkWaA3XiNuQNXg/wwS847bAjdSeAqW0g53aZku8oawe3wS+ryu1iZmOYuYimrhTCUhl6a+bLqmO/4EGZhJJOWozBkRh+su0KqC08PQQUk7CXBIzQTErS1i7ptm5OBy7NgbH7sZMWOS/gMFa1/SWA+7S5Clrk1r/V0z/fNMpBvlcVg9lK+JU5H5j1Qt/sBQg3uFNlcqR9rPN2+R6SXh5iTDoSBCLPgwPDiHjzcRQ65Z3oU42Vqjg6nVZJst7ZbU0NWV3lFT5A462ETcvAD2AYMzwAgQGAiJZq7Hgz3GdHHhTf9b5Eufih9ThfZI/UdmbIOiWbWkyE2Bw4bA+YdWf4TsRuv64sRY0rMz9E/i/FP2of06VtV7B2vZIOdYDwhVNHkik0Jf0gxfl6pR7xFPZS7fNk8xZ8bANqWCArlfwN5XSATBNlb3+V8vih+sEtI0liOYtvNsUyiIN/ZluLgce8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mm7PSUjdipJGy5GLXpdPFCkXuKKE/w7oLYZB09QXBC0ZJrzC4W+hKAUAlX?=
 =?iso-8859-1?Q?g1YsSbtubvkzAS2qgVWFOd97hW++QuBeShf9OWgb2CVeSojxhwQRbtl9hL?=
 =?iso-8859-1?Q?hbjfYADQAohXO0KvbB7RMEhG79esaQ9hNvt7KItriM+nYY4tID1/a22DCX?=
 =?iso-8859-1?Q?aRu3xu8SJay8xSsIOFQqz9nV/HLxcRTKewyJs3HGerpgJWhmHXF9/KCZL2?=
 =?iso-8859-1?Q?o7OIJociHQw/+8lPLSPsWBhpdFih0R6jNY46zdUtADZZEaAkQRMkiVa4vq?=
 =?iso-8859-1?Q?TB9GR8k9PIT00TSYSEQHuwvusCCT9MG0yF18AUHoP8MpAE4wqZRkwO9oMa?=
 =?iso-8859-1?Q?wsVvZVvlSN1Jy/P09GMTxgaenkZQa1zmTd2gNH+uAyg9yVwfv9IqQBeQCO?=
 =?iso-8859-1?Q?uxp6zx62nNuVXV6AUlYulRzDPrS++v9mUcDSaMJ2F6+bEcomWvVFumqKpI?=
 =?iso-8859-1?Q?B5qALj2MC4HHN+IgMC5UPdDLyf07Cvdh78ToToMDrx03IjttEa/KdoJdBX?=
 =?iso-8859-1?Q?RRa/9O7Ga/bgfkQxApyKSvoY9L2vA3pVUupM7PWLa/1ozw3su+7+Qyl3WQ?=
 =?iso-8859-1?Q?Zod/nkFYGCfY5nCUTZj2JMj14rUlKjZKDzXIqBouPCTsyl4cdCisD/y5PY?=
 =?iso-8859-1?Q?m1j3iarQ7u8Wc7WMr+Vxb2g7H+7V/zwZQjE9V0fxtU2H+3eNKDp7XBAlMg?=
 =?iso-8859-1?Q?Jkv826S++1+tepFb++5/7hG1VIi8fQEpYJdEosI39hF8sWt/RFnfgH9Csy?=
 =?iso-8859-1?Q?M9xSsutycXtOCXX5r2bky+bAAHftxgtWZm7L3SGv8ipeE80JAUNoKXpScm?=
 =?iso-8859-1?Q?gNGL1BQDpA1hMo6EVxPXN8yyeXQAwtjn2Bo11kPUrp0eYcTaW+71kcLJpD?=
 =?iso-8859-1?Q?awqeNYldAHIjFRoSkxgN0Z0i8oPrXdD/pPiSvlpUPShkaLNMGwrSEbHI3I?=
 =?iso-8859-1?Q?ycTM09E31h6md4fPIUCOaSm4hl+j+HOdbPC1YE1gGerBRQqXouZWAtiEVf?=
 =?iso-8859-1?Q?euESyCn4k/DVQAm+IM6hBr2Ys6gU7nxxds4CJL1T/bljsP/bjHLIeyisOq?=
 =?iso-8859-1?Q?e94LoUo5ePQSuXnL6Xd4TMTxgyMpHvARBWj87wrT1JpJ4oqqRdac6to51z?=
 =?iso-8859-1?Q?cu0TUXlQxyJzDjHKYd5FayQ9sdosKYfFRb3DOkvUifNPplYApasjeUlbxv?=
 =?iso-8859-1?Q?ujoIedQFOcaIwcd/Sm1j9MEPNz757av9rGlu1OOUgTDSryO96IVkKC4rRo?=
 =?iso-8859-1?Q?TvdhND9x0smedxgy9yhk+jimYRx7IZUqKdRhfirKpseNUFavf5iLWr+4sO?=
 =?iso-8859-1?Q?7xAjZWoH4xE1syb73jxKbRr4omSSBnytR60UL65gwUclcbSZOuSNlhU5Tf?=
 =?iso-8859-1?Q?broAfVKUjU8ve6Trc3LKJSo70863goYUpMxTTX1TMt023E02ZuHDt5zwrT?=
 =?iso-8859-1?Q?pSovHFzudjKa4PGFpafzK4KaVEeO/Ak8QRIRHi+cp6bg9KZeX/xTHLkCY5?=
 =?iso-8859-1?Q?Hms6xfmBfEckMz/Huy7M/EW20OSBrtj+SaarJUFih+404NfRcRa58fYL31?=
 =?iso-8859-1?Q?hCajIE1irBt2E6G9TD1ndihu+8EbFyFgRX4xFSGe19XsfcZIek9HNHEss+?=
 =?iso-8859-1?Q?0PFcAELbIxvzbMX15YYjkE5vtVcAq2kat2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87035bfa-3888-4598-3af8-08dc603564ff
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 05:56:02.7725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RsUgznh2NzETx1+rjRIk9fgP4hpEawCmxltXz6Ens/oTpx/W6CGJlUZcChNT0lpTVkQZYYTW3tH0S+cC3F8LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

Hi Linus,

We noticed that commit 1e3ad78334a6 caused performance fluctuations in
various micro benchmarks. The perf stat metrics related with branch
instructions do have noticeable changes, which may be an expected
result of this commit. We are sending this report to provide these data
and hope it can be helpful for the awareness of overall impact or any
further investigation. Thanks.

kernel test robot noticed a 1.4% improvement of will-it-scale.per_process_ops on:

commit: 1e3ad78334a69b36e107232e337f9d693dcc9df2 ("x86/syscall: Don't force use of indirect calls for system calls")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 16
	mode: process
	test: futex4
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.null.ops_per_sec -4.0% regression                                    |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=null                                                                                 |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.fpunch.ops_per_sec -1.6% regression                                  |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | disk=1HDD                                                                                 |
|                  | fs=ext4                                                                                   |
|                  | nr_threads=100%                                                                           |
|                  | test=fpunch                                                                               |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput -1.4% regression                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_task=100%                                                                              |
|                  | runtime=300s                                                                              |
|                  | test=fsbuffer                                                                             |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -1.1% regression                             |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | mode=process                                                                              |
|                  | nr_task=100%                                                                              |
|                  | test=pread1                                                                               |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -3.4% regression                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | mode=thread                                                                               |
|                  | nr_task=100%                                                                              |
|                  | test=poll1                                                                                |
+------------------+-------------------------------------------------------------------------------------------+

Details are as below:

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240419/202404191333.178a0eed-yujie.liu@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/16/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/futex4/will-it-scale

commit: 
  0cd01ac5dc ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")
  1e3ad78334 ("x86/syscall: Don't force use of indirect calls for system calls")

0cd01ac5dcb1e18e 1e3ad78334a69b36e107232e337 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    860611            -1.4%     848885        proc-vmstat.numa_hit
    753301            -1.6%     741136        proc-vmstat.numa_local
  21797058            +1.4%   22102512        will-it-scale.16.processes
   1362315            +1.4%    1381406        will-it-scale.per_process_ops
  21797058            +1.4%   22102512        will-it-scale.workload
      0.04 ±  7%      -7.4%       0.04        perf-stat.i.MPKI
  1.98e+09           +19.2%   2.36e+09        perf-stat.i.branch-instructions
      1.47            -1.2        0.30        perf-stat.i.branch-miss-rate%
  30820475           -70.4%    9118612        perf-stat.i.branch-misses
      3.45            -4.4%       3.30        perf-stat.i.cpi
 1.504e+10            +5.1%   1.58e+10        perf-stat.i.instructions
      0.29            +4.5%       0.31        perf-stat.i.ipc
      0.05 ±  2%      -4.2%       0.04        perf-stat.overall.MPKI
      1.56            -1.2        0.39        perf-stat.overall.branch-miss-rate%
      3.43            -4.3%       3.28        perf-stat.overall.cpi
      0.29            +4.5%       0.30        perf-stat.overall.ipc
    208138            +3.4%     215312        perf-stat.overall.path-length
 1.973e+09           +19.2%  2.353e+09        perf-stat.ps.branch-instructions
  30729762           -70.4%    9109071        perf-stat.ps.branch-misses
 1.499e+10            +5.1%  1.575e+10        perf-stat.ps.instructions
 4.537e+12            +4.9%  4.759e+12        perf-stat.total.instructions
     12.23            -0.6       11.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     10.09            -0.6        9.51        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     22.31            -0.4       21.88        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      9.25            +0.2        9.43        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.syscall
      8.79            +0.2        9.02        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      7.13            +0.2        7.36        perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
      8.37            +0.3        8.63        perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.38            -0.6       11.78        perf-profile.children.cycles-pp.do_syscall_64
     10.12            -0.5        9.57        perf-profile.children.cycles-pp.__x64_sys_futex
     22.63            -0.4       22.20        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.48 ±  2%      -0.0        0.46        perf-profile.children.cycles-pp.get_futex_key
      0.00            +0.2        0.18 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      9.11            +0.2        9.29        perf-profile.children.cycles-pp.entry_SYSCALL_64
      8.88            +0.2        9.11        perf-profile.children.cycles-pp.do_futex
      7.13            +0.2        7.36        perf-profile.children.cycles-pp.__futex_wait
      8.43            +0.3        8.70        perf-profile.children.cycles-pp.futex_wait
      1.20            -0.7        0.47        perf-profile.self.cycles-pp.__x64_sys_futex
      1.46            -0.2        1.27        perf-profile.self.cycles-pp.do_syscall_64
      0.51            -0.1        0.44        perf-profile.self.cycles-pp.do_futex
      0.38 ±  5%      -0.1        0.32 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.48 ±  2%      -0.0        0.45        perf-profile.self.cycles-pp.get_futex_key
      0.00            +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      7.97            +0.1        8.12        perf-profile.self.cycles-pp.entry_SYSCALL_64
     10.43            +0.2       10.60        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.72 ±  3%      +0.2        0.94 ±  3%  perf-profile.self.cycles-pp.__futex_wait


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/utime/stress-ng/60s

commit: 
  0cd01ac5dc ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")
  1e3ad78334 ("x86/syscall: Don't force use of indirect calls for system calls")

0cd01ac5dcb1e18e 1e3ad78334a69b36e107232e337 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    136026 ±  3%     +20.6%     164016 ± 11%  meminfo.DirectMap4k
 5.516e+10            +1.5%  5.598e+10        perf-stat.i.branch-instructions
 5.427e+10            +1.5%  5.508e+10        perf-stat.ps.branch-instructions
    137060 ± 23%     +35.5%     185722 ±  7%  numa-numastat.node0.local_node
     50345 ± 26%     -56.2%      22060 ± 77%  numa-numastat.node0.other_node
    289383 ±  9%     -17.6%     238445 ±  6%  numa-numastat.node1.local_node
     15965 ± 85%    +177.3%      44264 ± 38%  numa-numastat.node1.other_node
    136562 ± 23%     +35.6%     185165 ±  7%  numa-vmstat.node0.numa_local
     50345 ± 26%     -56.2%      22060 ± 77%  numa-vmstat.node0.numa_other
    288523 ±  9%     -17.7%     237526 ±  6%  numa-vmstat.node1.numa_local
     15965 ± 85%    +177.3%      44264 ± 38%  numa-vmstat.node1.numa_other
      1.71            -0.5        1.18        perf-profile.calltrace.cycles-pp.mnt_want_write.vfs_utimes.do_utimes.__x64_sys_utimensat.do_syscall_64
     43.01            -0.3       42.68        perf-profile.calltrace.cycles-pp.user_path_at_empty.do_utimes.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.61            -0.3       23.34        perf-profile.calltrace.cycles-pp.do_utimes.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe.utimensat
     26.52            -0.2       26.27        perf-profile.calltrace.cycles-pp.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe.utimensat
     16.22            -0.2       16.00        perf-profile.calltrace.cycles-pp.do_utimes.__x64_sys_utime.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     13.89            -0.2       13.68        perf-profile.calltrace.cycles-pp.user_path_at_empty.do_utimes.__x64_sys_utime.do_syscall_64.entry_SYSCALL_64_after_hwframe
     39.07            -0.2       38.87        perf-profile.calltrace.cycles-pp.do_utimes.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.75            -0.2       16.56        perf-profile.calltrace.cycles-pp.__x64_sys_utime.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     15.77            -0.2       15.58        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.do_utimes.__x64_sys_utimensat.do_syscall_64
     10.55            -0.2       10.37        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.do_utimes.__x64_sys_utime.do_syscall_64
     13.78            -0.2       13.60        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.do_utimes.__x64_sys_utimensat
      9.48            -0.2        9.31        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.do_utimes.__x64_sys_utime
     29.46            -0.1       29.32        perf-profile.calltrace.cycles-pp.utimensat
     25.18            -0.1       25.05        perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.do_utimes.__x64_sys_utimensat.do_syscall_64
     21.74            -0.1       21.62        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.do_utimes.__x64_sys_utimensat
     27.48            -0.1       27.35        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.utimensat
     43.89            -0.1       43.77        perf-profile.calltrace.cycles-pp.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.24            -0.1       17.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     27.21            -0.1       27.11        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.utimensat
     17.10            -0.1       17.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     18.02            -0.1       17.93        perf-profile.calltrace.cycles-pp.syscall
      3.82            -0.1        3.76        perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.user_path_at_empty.do_utimes
      0.57            -0.0        0.54        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.61            -0.0        1.58        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.strncpy_from_user.getname_flags.user_path_at_empty
      2.91            -0.0        2.88        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.do_utimes.__x64_sys_utime.do_syscall_64
      2.43            -0.0        2.40        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.do_utimes.__x64_sys_utime
     45.81            +0.1       45.96        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     45.27            +0.2       45.45        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     79.22            -0.7       78.54        perf-profile.children.cycles-pp.do_utimes
     57.10            -0.5       56.56        perf-profile.children.cycles-pp.user_path_at_empty
     70.66            -0.4       70.29        perf-profile.children.cycles-pp.__x64_sys_utimensat
     36.81            -0.3       36.49        perf-profile.children.cycles-pp.getname_flags
     31.75            -0.3       31.45        perf-profile.children.cycles-pp.strncpy_from_user
     20.12            -0.2       19.91        perf-profile.children.cycles-pp.filename_lookup
     17.70            -0.2       17.50        perf-profile.children.cycles-pp.path_lookupat
     16.79            -0.2       16.60        perf-profile.children.cycles-pp.__x64_sys_utime
     29.54            -0.1       29.40        perf-profile.children.cycles-pp.utimensat
     18.34            -0.1       18.25        perf-profile.children.cycles-pp.syscall
     19.31            -0.1       19.22        perf-profile.children.cycles-pp.vfs_utimes
      4.47            -0.1        4.40        perf-profile.children.cycles-pp.__check_object_size
      1.32            -0.1        1.26        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.38            -0.1        3.34        perf-profile.children.cycles-pp.walk_component
      2.56            -0.0        2.52        perf-profile.children.cycles-pp.lookup_fast
      2.08            -0.0        2.04        perf-profile.children.cycles-pp.__d_lookup_rcu
      2.33            -0.0        2.30        perf-profile.children.cycles-pp.check_heap_object
      2.44            -0.0        2.41        perf-profile.children.cycles-pp.complete_walk
      1.07            -0.0        1.05        perf-profile.children.cycles-pp.make_vfsuid
      1.30            -0.0        1.28        perf-profile.children.cycles-pp.path_put
      0.84            +0.0        0.88        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.6        0.63        perf-profile.children.cycles-pp.x64_sys_call
     27.25            -0.2       27.02        perf-profile.self.cycles-pp.strncpy_from_user
      1.30            -0.1        1.22        perf-profile.self.cycles-pp.do_syscall_64
      0.24            -0.0        0.23        perf-profile.self.cycles-pp.may_setattr
      0.12            +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__x64_sys_utime
      0.84            +0.0        0.88        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.92            +0.1        1.04        perf-profile.self.cycles-pp.__x64_sys_utimensat
      0.00            +0.5        0.55        perf-profile.self.cycles-pp.x64_sys_call



***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/readahead/stress-ng/60s

commit: 
  0cd01ac5dc ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")
  1e3ad78334 ("x86/syscall: Don't force use of indirect calls for system calls")

0cd01ac5dcb1e18e 1e3ad78334a69b36e107232e337 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 5.631e+10            +2.8%  5.787e+10        perf-stat.i.branch-instructions
  5.54e+10            +2.8%  5.695e+10        perf-stat.ps.branch-instructions
     55177 ± 10%     +36.4%      75281 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     55177 ± 10%     +36.4%      75281 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
     46.20            -0.5       45.74        perf-profile.calltrace.cycles-pp.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
     35.83            -0.4       35.38        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.24            -0.3       19.90        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.__x64_sys_pread64
     20.87            -0.3       20.54        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.__x64_sys_pread64.do_syscall_64
      1.66            -0.1        1.58        perf-profile.calltrace.cycles-pp.__fdget.ksys_readahead.do_syscall_64.entry_SYSCALL_64_after_hwframe.readahead
      0.66 ±  3%      -0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.readahead.stress_run
      0.63 ±  4%      -0.0        0.58 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.readahead
      4.29            -0.0        4.25        perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.20            -0.0        2.16        perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.__x64_sys_pread64.do_syscall_64
      1.88            -0.0        1.85        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_read.vfs_read.__x64_sys_pread64
      4.33 ±  3%      +0.3        4.68 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.readahead
      3.66 ±  3%      +0.4        4.05 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.readahead
     46.41            -0.5       45.94        perf-profile.children.cycles-pp.vfs_read
     48.17            -0.5       47.71        perf-profile.children.cycles-pp.__x64_sys_pread64
     36.13            -0.5       35.68        perf-profile.children.cycles-pp.filemap_read
     20.30            -0.3       19.96        perf-profile.children.cycles-pp._copy_to_iter
     20.97            -0.3       20.64        perf-profile.children.cycles-pp.copy_page_to_iter
     55.86            -0.3       55.60        perf-profile.children.cycles-pp.__libc_pread
     24.71            -0.2       24.48        perf-profile.children.cycles-pp.stress_readahead
      2.62            -0.2        2.46        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      4.54            -0.1        4.45        perf-profile.children.cycles-pp.ksys_readahead
      5.33            -0.0        5.28        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.40            -0.0        4.36        perf-profile.children.cycles-pp.__fsnotify_parent
      2.28            -0.0        2.26        perf-profile.children.cycles-pp.touch_atime
      2.06            -0.0        2.04        perf-profile.children.cycles-pp.atime_needs_update
      0.08 ±  8%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.78            +0.0        0.81        perf-profile.children.cycles-pp.posix_fadvise
     59.97            +0.3       60.27        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     58.28            +0.3       58.60        perf-profile.children.cycles-pp.do_syscall_64
     18.84            +0.5       19.32        perf-profile.children.cycles-pp.readahead
      0.00            +1.2        1.22        perf-profile.children.cycles-pp.x64_sys_call
     20.09            -0.3       19.76        perf-profile.self.cycles-pp._copy_to_iter
     24.32            -0.2       24.08        perf-profile.self.cycles-pp.stress_readahead
      2.65            -0.2        2.47        perf-profile.self.cycles-pp.do_syscall_64
      4.84            -0.0        4.80        perf-profile.self.cycles-pp.filemap_read
      5.16            -0.0        5.11        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.27            -0.0        4.22        perf-profile.self.cycles-pp.__fsnotify_parent
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      1.82            -0.0        1.80        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.70            +0.0        0.72        perf-profile.self.cycles-pp.__x64_sys_pread64
      0.00            +1.1        1.06        perf-profile.self.cycles-pp.x64_sys_call



***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/null/stress-ng/60s

commit: 
  0cd01ac5dc ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")
  1e3ad78334 ("x86/syscall: Don't force use of indirect calls for system calls")

0cd01ac5dcb1e18e 1e3ad78334a69b36e107232e337 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     19402 ± 14%     +63.7%      31762 ± 28%  sched_debug.cpu.nr_switches.max
      3272 ± 10%     +40.4%       4595 ± 21%  sched_debug.cpu.nr_switches.stddev
      3241           +10.1%       3569 ±  9%  vmstat.system.cs
    162368            -0.9%     160961        vmstat.system.in
   6303220            -3.7%    6068707        proc-vmstat.numa_hit
   6236896            -3.8%    6002419        proc-vmstat.numa_local
   6341375            -3.7%    6107478        proc-vmstat.pgalloc_normal
   6171078            -3.7%    5941105        proc-vmstat.pgfault
   6144519            -3.8%    5913179        proc-vmstat.pgfree
     19272            -3.3%      18627        stress-ng.null.MB_per_sec_/dev/null_write_rate
 2.902e+09            -4.0%  2.787e+09        stress-ng.null.ops
  48365768            -4.0%   46449880        stress-ng.null.ops_per_sec
   5809136            -3.9%    5580207        stress-ng.time.minor_page_faults
      2394            +1.6%       2431        stress-ng.time.system_time
      1324            -2.7%       1289        stress-ng.time.user_time
 3.529e+10           +18.8%   4.19e+10        perf-stat.i.branch-instructions
      0.24 ±  3%      -0.1        0.19 ±  3%  perf-stat.i.branch-miss-rate%
  85202098 ±  4%      -9.4%   77223454 ±  3%  perf-stat.i.branch-misses
      3168 ±  2%     +11.4%       3529 ± 10%  perf-stat.i.context-switches
      1.03            -2.7%       1.00        perf-stat.i.cpi
 1.897e+11            +2.7%  1.949e+11        perf-stat.i.instructions
      0.97            +2.7%       1.00        perf-stat.i.ipc
      3.14            -3.8%       3.03        perf-stat.i.metric.K/sec
    100663            -3.8%      96871        perf-stat.i.minor-faults
    100663            -3.8%      96871        perf-stat.i.page-faults
      0.24 ±  3%      -0.1        0.18 ±  3%  perf-stat.overall.branch-miss-rate%
      1.03            -2.7%       1.00        perf-stat.overall.cpi
      0.97            +2.7%       1.00        perf-stat.overall.ipc
 3.471e+10           +18.7%  4.121e+10        perf-stat.ps.branch-instructions
  83783190 ±  3%      -9.8%   75603241 ±  3%  perf-stat.ps.branch-misses
      3114 ±  2%     +11.0%       3457 ± 10%  perf-stat.ps.context-switches
 1.866e+11            +2.7%  1.916e+11        perf-stat.ps.instructions
     98965            -3.8%      95242        perf-stat.ps.minor-faults
     98966            -3.8%      95242        perf-stat.ps.page-faults
 1.139e+13            +2.6%  1.169e+13        perf-stat.total.instructions
      4.88 ±  2%      -0.3        4.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.llseek
      4.94 ±  2%      -0.2        4.74        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.29 ±  2%      -0.2        3.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.ioctl
      3.26            -0.1        3.13        perf-profile.calltrace.cycles-pp.setfl.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.30            -0.1        3.17        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.fallocate64
      2.48            -0.1        2.36        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      2.34 ±  2%      -0.1        2.21        perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.12            -0.1        2.01        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      0.84 ±  2%      -0.1        0.75 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86 ±  2%      -0.1        0.76 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.89 ±  3%      -0.1        0.80        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek.stress_run
      1.63 ±  2%      -0.1        1.55        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      0.86 ±  3%      -0.1        0.79 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_run
      2.40 ±  2%      -0.1        2.33        perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_run
      1.26            -0.1        1.20        perf-profile.calltrace.cycles-pp.__put_user_4.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58 ±  3%      -0.1        0.52        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      1.45            -0.1        1.40        perf-profile.calltrace.cycles-pp._raw_spin_lock.setfl.do_fcntl.__x64_sys_fcntl.do_syscall_64
      0.55            +0.0        0.58        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.86 ±  3%      +0.1        0.91 ±  2%  perf-profile.calltrace.cycles-pp.__fdget_raw.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_run
      3.11            +0.1        3.19        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      1.50 ±  2%      +0.1        1.60 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fdatasync
      0.70            +0.1        0.83        perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      1.15 ±  2%      +0.1        1.29 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync
      1.41 ±  2%      +0.1        1.55 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fdatasync.stress_run
      1.18 ±  2%      +0.2        1.35 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync.stress_run
      3.90 ±  2%      +0.2        4.08 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_run
      3.95 ±  2%      +0.2        4.14        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      1.36 ±  2%      +0.2        1.55 ±  2%  perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      4.08 ±  2%      +0.2        4.31        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      4.66 ±  3%      +0.3        4.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
      4.06 ±  3%      +0.3        4.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
      4.58            +0.3        4.91        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      5.07            +0.3        5.40        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
      4.20 ±  3%      +0.3        4.54 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek.stress_run
      6.71 ±  2%      +0.4        7.07        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_run
      0.17 ±141%      +0.4        0.58 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync.stress_run
      0.00            +0.5        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync
      8.22            -0.6        7.61        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     16.53            -0.6       15.94        perf-profile.children.cycles-pp.entry_SYSCALL_64
     16.36            -0.6       15.80        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      5.04            -0.2        4.83        perf-profile.children.cycles-pp.do_fcntl
      5.14 ±  2%      -0.2        4.95        perf-profile.children.cycles-pp.vfs_write
      9.50            -0.2        9.31        perf-profile.children.cycles-pp.__x64_sys_fcntl
      3.54            -0.1        3.40        perf-profile.children.cycles-pp.setfl
      2.62            -0.1        2.48        perf-profile.children.cycles-pp.do_vfs_ioctl
      2.56            -0.1        2.47        perf-profile.children.cycles-pp.stress_null
      1.89            -0.1        1.80        perf-profile.children.cycles-pp.amd_clear_divider
      1.74            -0.1        1.65        perf-profile.children.cycles-pp.__libc_fcntl64
      1.38            -0.1        1.30        perf-profile.children.cycles-pp.__put_user_4
      1.54            -0.1        1.49        perf-profile.children.cycles-pp._raw_spin_lock
      0.44 ±  4%      -0.1        0.39        perf-profile.children.cycles-pp.__munmap
      0.42 ±  4%      -0.1        0.37        perf-profile.children.cycles-pp.__vm_munmap
      0.42 ±  4%      -0.1        0.37        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.40 ±  4%      -0.0        0.36        perf-profile.children.cycles-pp.do_vmi_align_munmap
      2.46            -0.0        2.41        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.42 ±  4%      -0.0        0.38        perf-profile.children.cycles-pp.do_vmi_munmap
      0.32 ±  4%      -0.0        0.28        perf-profile.children.cycles-pp.unmap_region
      0.24 ±  3%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.31 ±  3%      -0.0        0.29        perf-profile.children.cycles-pp.__mmap
      0.22 ±  3%      -0.0        0.19        perf-profile.children.cycles-pp.do_user_addr_fault
      0.55            -0.0        0.52        perf-profile.children.cycles-pp.fcntl64@plt
      0.75            -0.0        0.72        perf-profile.children.cycles-pp.security_file_fcntl
      0.29 ±  3%      -0.0        0.27        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.28 ±  3%      -0.0        0.25        perf-profile.children.cycles-pp.do_mmap
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
      0.20 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.mmap_region
      0.56            -0.0        0.54        perf-profile.children.cycles-pp.null_lseek
      0.53            -0.0        0.51        perf-profile.children.cycles-pp.security_file_ioctl
      0.18 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
      0.15 ±  7%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.16 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.12 ±  6%      -0.0        0.10        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__anon_vma_prepare
      3.28            +0.1        3.35        perf-profile.children.cycles-pp.__x64_sys_fallocate
      7.43            +0.1        7.51        perf-profile.children.cycles-pp.fdatasync
      4.15            +0.1        4.23        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.07            +0.1        1.22        perf-profile.children.cycles-pp.__x64_sys_fdatasync
      2.93            +0.4        3.35 ±  2%  perf-profile.children.cycles-pp.__fdget
     52.11            +1.6       53.71        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     47.02            +1.9       48.87        perf-profile.children.cycles-pp.do_syscall_64
      0.00            +3.4        3.40        perf-profile.children.cycles-pp.x64_sys_call
      8.38            -0.7        7.68        perf-profile.self.cycles-pp.do_syscall_64
     15.83            -0.6       15.27        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      5.47            -0.3        5.20        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.17            -0.2        4.98        perf-profile.self.cycles-pp.entry_SYSCALL_64
      4.64            -0.2        4.49        perf-profile.self.cycles-pp.llseek
      4.24            -0.1        4.10        perf-profile.self.cycles-pp.ioctl
      4.36            -0.1        4.22        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.94            -0.1        1.84        perf-profile.self.cycles-pp.stress_null
      2.02            -0.1        1.93        perf-profile.self.cycles-pp.fdatasync
      2.18            -0.1        2.10        perf-profile.self.cycles-pp.fallocate64
      2.01            -0.1        1.94        perf-profile.self.cycles-pp.setfl
      1.33            -0.1        1.26        perf-profile.self.cycles-pp.__put_user_4
      1.54            -0.1        1.47        perf-profile.self.cycles-pp.do_fcntl
      1.19            -0.1        1.14 ±  2%  perf-profile.self.cycles-pp.do_vfs_ioctl
      1.34            -0.1        1.29        perf-profile.self.cycles-pp._raw_spin_lock
      2.30            -0.0        2.26        perf-profile.self.cycles-pp.__x64_sys_fcntl
      1.97            -0.0        1.93        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.97            -0.0        0.94        perf-profile.self.cycles-pp.amd_clear_divider
      0.56            -0.0        0.54        perf-profile.self.cycles-pp.security_file_fcntl
      0.39            -0.0        0.37        perf-profile.self.cycles-pp.fcntl64@plt
      0.30            -0.0        0.29        perf-profile.self.cycles-pp.rw_verify_area
      0.36            -0.0        0.35        perf-profile.self.cycles-pp.security_file_ioctl
      0.44            +0.0        0.48 ±  2%  perf-profile.self.cycles-pp.__x64_sys_fallocate
      0.34            +0.0        0.37 ±  6%  perf-profile.self.cycles-pp.__x64_sys_fdatasync
      4.14            +0.1        4.23        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.57            +0.1        1.66 ±  2%  perf-profile.self.cycles-pp.__fdget_raw
      2.61            +0.4        3.06 ±  2%  perf-profile.self.cycles-pp.__fdget
      0.00            +2.9        2.89        perf-profile.self.cycles-pp.x64_sys_call



***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/monte-carlo/stress-ng/60s

commit: 
  0cd01ac5dc ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")
  1e3ad78334 ("x86/syscall: Don't force use of indirect calls for system calls")

0cd01ac5dcb1e18e 1e3ad78334a69b36e107232e337 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.74            -0.1        1.62        perf-stat.overall.branch-miss-rate%
 1.411e+13            +1.2%  1.427e+13        perf-stat.total.instructions
   2838242            -1.6%    2793803        stress-ng.monte-carlo.samples/sec,_e_using_arc4
   7122323            -1.2%    7036665        stress-ng.monte-carlo.samples/sec,_exp_using_arc4
   3972723            -1.5%    3911813        stress-ng.monte-carlo.samples/sec,_pi_using_arc4
 1.016e+08            -1.3%  1.004e+08        stress-ng.monte-carlo.samples/sec,_pi_using_lcg
   6407021            -1.4%    6319313        stress-ng.monte-carlo.samples/sec,_sin_using_arc4
   7374513            -1.3%    7277983        stress-ng.monte-carlo.samples/sec,_sqrt_using_arc4
   3962914            -1.5%    3904274        stress-ng.monte-carlo.samples/sec,_squircle_using_arc4
      1108            +1.8%       1128        stress-ng.time.system_time
      3.02            -0.3        2.69        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid.stress_mc_arc4_rand
      3.40 ±  2%      -0.2        3.16 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_getpid.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid.stress_mc_arc4_rand
      2.93 ±  3%      -0.2        2.71 ±  3%  perf-profile.calltrace.cycles-pp.__task_pid_nr_ns.__x64_sys_getpid.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
     17.72            -0.2       17.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__getpid.stress_mc_arc4_rand
      0.94            -0.0        0.91        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      3.13            -0.0        3.10        perf-profile.calltrace.cycles-pp.stress_mc_mwc64_rand
      2.07            -0.0        2.04        perf-profile.calltrace.cycles-pp.stress_mwc64.stress_mc_mwc64_rand
      0.56            -0.0        0.53        perf-profile.calltrace.cycles-pp.stress_monte_carlo_sqrt.stress_mc_arc4_rand
     43.17            +0.5       43.65        perf-profile.calltrace.cycles-pp.stress_mc_arc4_rand
     34.06            +0.5       34.58        perf-profile.calltrace.cycles-pp.__getpid.stress_mc_arc4_rand
     13.54            +0.8       14.33        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__getpid.stress_mc_arc4_rand
     10.40            +1.0       11.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid.stress_mc_arc4_rand
      0.00            +1.4        1.38        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid.stress_mc_arc4_rand
      3.94            -0.4        3.58        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.85 ±  2%      -0.2        3.61 ±  2%  perf-profile.children.cycles-pp.__x64_sys_getpid
      3.15 ±  2%      -0.2        2.93 ±  3%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      7.88            -0.1        7.76        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.44            -0.1        4.37        perf-profile.children.cycles-pp.stress_mc_xorshift_rand
      1.18            -0.1        1.13        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      2.10            -0.0        2.06        perf-profile.children.cycles-pp.stress_monte_carlo_pi
      2.38            -0.0        2.35        perf-profile.children.cycles-pp.stress_monte_carlo_sqrt
      2.32            -0.0        2.29        perf-profile.children.cycles-pp.stress_mwc64
     35.10            +0.6       35.66        perf-profile.children.cycles-pp.__getpid
     27.59            +0.7       28.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     25.10            +0.7       25.84        perf-profile.children.cycles-pp.do_syscall_64
      0.00            +1.6        1.61        perf-profile.children.cycles-pp.x64_sys_call
      3.90            -0.2        3.68        perf-profile.self.cycles-pp.do_syscall_64
      2.90 ±  2%      -0.2        2.69 ±  3%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      7.64            -0.1        7.52        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.08            -0.1        2.00        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.95            -0.0        0.90        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      2.76            -0.0        2.72        perf-profile.self.cycles-pp.stress_mc_xorshift_rand
      1.64            -0.0        1.60        perf-profile.self.cycles-pp.stress_monte_carlo_pi
      2.05            -0.0        2.02        perf-profile.self.cycles-pp.stress_mwc64
      0.00            +1.4        1.37        perf-profile.self.cycles-pp.x64_sys_call



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fpunch/stress-ng/60s

commit: 
  0cd01ac5dc ("x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file")
  1e3ad78334 ("x86/syscall: Don't force use of indirect calls for system calls")

0cd01ac5dcb1e18e 1e3ad78334a69b36e107232e337 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.408e+10            +4.9%  4.623e+10        perf-stat.i.branch-instructions
      0.21            -0.0        0.19 ±  3%  perf-stat.overall.branch-miss-rate%
 4.336e+10            +4.9%  4.547e+10        perf-stat.ps.branch-instructions
 1.054e+08            -1.6%  1.037e+08        stress-ng.fpunch.ops
   1756286            -1.6%    1727644        stress-ng.fpunch.ops_per_sec
    879217            -2.0%     861604        stress-ng.time.voluntary_context_switches
     38.90            -0.6       38.29        perf-profile.calltrace.cycles-pp.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     31.84            -0.5       31.30        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.48            -0.4       40.04        perf-profile.calltrace.cycles-pp.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     19.84            -0.4       19.48        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     22.29            -0.4       21.94        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     16.32            -0.3       16.01        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.13            -0.3       25.87        perf-profile.calltrace.cycles-pp.write
     23.37            -0.3       23.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     47.74            -0.2       47.50        perf-profile.calltrace.cycles-pp.__libc_pwrite
      0.52            -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.__mutex_unlock_slowpath.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.06            -0.1        1.98        perf-profile.calltrace.cycles-pp.up_write.generic_file_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      1.33            -0.1        1.28        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.generic_file_write_iter.vfs_write.__x64_sys_pwrite64
      0.64 ±  2%      -0.1        0.59        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      2.62            -0.0        2.58        perf-profile.calltrace.cycles-pp.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write.__x64_sys_pwrite64
      1.02            -0.0        0.99        perf-profile.calltrace.cycles-pp.up_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.66            -0.0        0.64        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.generic_file_write_iter.vfs_write.ksys_write
      1.48            -0.0        1.46        perf-profile.calltrace.cycles-pp.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.66            -0.0        0.64        perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
      1.06            +0.0        1.08        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.83 ±  3%      +0.1        0.91        perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      1.60            +0.1        1.71        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.71 ±  2%      +0.1        0.82        perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      3.00            +0.2        3.18        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      5.63            +0.2        5.85        perf-profile.calltrace.cycles-pp.syscall
      2.37            +0.2        2.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.65            +0.2        2.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     10.09            +0.3       10.44        perf-profile.calltrace.cycles-pp.fallocate64
      4.37            +0.4        4.74        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      4.84            +0.4        5.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     59.21            -1.0       58.23        perf-profile.children.cycles-pp.vfs_write
     48.48            -0.9       47.62        perf-profile.children.cycles-pp.generic_file_write_iter
     40.60            -0.4       40.17        perf-profile.children.cycles-pp.__x64_sys_pwrite64
     22.42            -0.4       22.06        perf-profile.children.cycles-pp.ksys_write
     26.21            -0.3       25.96        perf-profile.children.cycles-pp.write
     47.88            -0.2       47.65        perf-profile.children.cycles-pp.__libc_pwrite
      3.21            -0.1        3.10        perf-profile.children.cycles-pp.up_write
      2.62            -0.1        2.52        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.07            -0.1        2.00        perf-profile.children.cycles-pp.rwsem_wake
      4.34            -0.1        4.27        perf-profile.children.cycles-pp.simple_write_end
      1.28            -0.0        1.24        perf-profile.children.cycles-pp.wake_up_q
      0.69            -0.0        0.66        perf-profile.children.cycles-pp.wake_q_add
      1.06            -0.0        1.03 ±  2%  perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.84 ±  2%      -0.0        0.81        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.76            -0.0        0.73        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.65            -0.0        0.62        perf-profile.children.cycles-pp.rwsem_mark_wake
      0.81            -0.0        0.79        perf-profile.children.cycles-pp.try_to_wake_up
      5.70            +0.2        5.92        perf-profile.children.cycles-pp.syscall
      2.03 ±  2%      +0.3        2.29        perf-profile.children.cycles-pp.__fdget
      4.83            +0.3        5.10        perf-profile.children.cycles-pp.__x64_sys_fallocate
     10.18            +0.3       10.52        perf-profile.children.cycles-pp.fallocate64
      0.00            +1.1        1.12        perf-profile.children.cycles-pp.x64_sys_call
      2.68            -0.1        2.55        perf-profile.self.cycles-pp.do_syscall_64
      4.24            -0.1        4.13        perf-profile.self.cycles-pp.fault_in_readable
      2.04            -0.0        1.99        perf-profile.self.cycles-pp.simple_write_end
      4.80            -0.0        4.76        perf-profile.self.cycles-pp.vfs_write
      1.67            -0.0        1.64        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.66 ±  2%      -0.0        0.63        perf-profile.self.cycles-pp.wake_q_add
      0.72            -0.0        0.70        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.68 ±  3%      -0.0        0.66 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.50            -0.0        0.48        perf-profile.self.cycles-pp.wake_up_q
      0.59            +0.1        0.66        perf-profile.self.cycles-pp.__x64_sys_fallocate
      0.96            +0.1        1.05        perf-profile.self.cycles-pp.__fdget_pos
      0.57            +0.1        0.68        perf-profile.self.cycles-pp.__x64_sys_pwrite64
      1.87 ±  2%      +0.3        2.14        perf-profile.self.cycles-pp.__fdget
      0.00            +1.0        0.96        perf-profile.self.cycles-pp.x64_sys_call





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


