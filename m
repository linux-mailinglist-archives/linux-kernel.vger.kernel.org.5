Return-Path: <linux-kernel+bounces-29079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67261830808
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2E7287642
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8E20338;
	Wed, 17 Jan 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRRkYi03"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321120327;
	Wed, 17 Jan 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501723; cv=fail; b=QhpC18eo0ZlXCbcRn8b1SemWPnlQsoiIlBhPQLSlGbBQ6gnBoJ2YbNrPFgj+7bDtdAtHn0HCG9ycw4CakaLgZnAOrXNxmVJiylUEJJMx44ZWBAN7GMijnPzyAix1KO4T6fgurpp8XewkZmgT4fyEcOQ9PO7B1JrdBWmpcEmK3i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501723; c=relaxed/simple;
	bh=pNP15OBPCfhgLAFVXwkEhBhuE6nXSfp0RdbDhrdBkVQ=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=cRFDiPA3WWBqQqjgiTQuDCuaIA6PBJ7BhYOpAcKtJ9Wm1fFGHH7Sy9uf2Ad5BX+NvaZips67viHL6wDJadiL7qEhBg6XfNQhMXn87oQtBKPki3uS3GY5jkP1Kxcp7iNcRlZZwTv7AtXtlj73Qwk3YeAYWexFzxvz2Y6RLMBZzPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRRkYi03; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705501720; x=1737037720;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pNP15OBPCfhgLAFVXwkEhBhuE6nXSfp0RdbDhrdBkVQ=;
  b=VRRkYi03u0hAMOYuen2pKH4oU1cW6fy87V6UzCq/cHG7S+bUpcNP/NsG
   kXodvWQWznp4F+ghJzAFXtlG30gs7b37e225LogUJXjs/qN4q1DuqJ8zQ
   yj+zKbSXshaQ4rwsAD4RQcPv2TcfQIkciVpX0ts3JEiNleeKGIRP8ANrW
   kV4ZBwpw+TINSlNMMHqKFs2UNzE/tRHCjF96ixBHKxP9czA99k0f9S/wK
   gfIUizmzyuDnRAp9W16FyjMx3EzzGnw3VsoSk7Y5OQA/nH+Ck2FOCJdiU
   6P0baoyMGLfh9IW2de8w62Bs6LRW7R/G8AgWzJDGRaC+efX8k29eXVY8Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="21653274"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="21653274"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 06:28:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="48269"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 06:28:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 06:28:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 06:28:37 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 06:28:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw1L/CD+RZIQic5RyArlGpF/C4G8UR7ioQ7TsH1JbCBk0Spj3EW/g0UoxNlTGd/XBgXLNqPXxlm3K4jhajzDzUpqRy2UYhDji68csHiVqfA564IMM0iTUtniT8sXlN4XfemMFekFwjoQXon+dMu81d/JTwp/nkrMYQGyOs730+j1UgQMK+hUevqrPgRTvuB9jc9+RKcenYtYmAfX6pdfTC7WxrSlDHK4kQMlC68JSDL87UIC9i/9Gnro4h8rDwcqM4oQAR33waYgzRnu0Bszw9/8NaAjCB6uZnWTCgDG1Zetj7X2YpFtYTcrAp7QQ6629gkgM5GbFTfe6T/XDb1atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJEq63s3jKaDpODQHMLdJv+nX6RI4/7xBFDSO8h/a3M=;
 b=awhgOOM+6ojjI8vQo3uuAiFetekWCK1Jr1++PK8Vyq6hJpDmbBun+VxAxQl5GVQoYAZ2ouuC/ZAUD/0v+go0qOVCkE4sdPFnEP5ew8IdC9IU114EP2dqiq1Op6Ss2fNjvFfumQkv4q4IU9AZbp3rADiDvUBY9rke4n3uGHypBlyKFjKqwssw3faCS0IsDUBbHZEzd7yprEZ6t4eevC3AYQZbOIicswnOemEmoTvW++euKblIrnv7nvaB5myAuvWAhxfQ8OqK12vHDtp26jV9yDBiaw8+RIRy7YrkSxgtp2WLMXuOKGcLIXzrMV+UQBKTME993w0QPJLQN/PZiDtK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 14:28:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Wed, 17 Jan 2024
 14:28:34 +0000
Date: Wed, 17 Jan 2024 22:28:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [mhiramat:topic/fprobe-on-fgraph] [function_graph] 367c724761:
 BUG:KASAN:slab-out-of-bounds_in_ftrace_push_return_trace
Message-ID: <202401172217.36e37075-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TY2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:404:e2::33) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 654b8ae2-4a8c-4cff-7143-08dc17689604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpMDy9SfAZ3TC4jQ6kP+UMQTGVItz3QoxfgzSl3CJw7czDEI2TTyrRI2O0uPEB+FxmKsE8ke+5ykfvZ+J2yjlRLaOM98RHvEwvqfCZvFLp04ajs02QibKsP2aUD5AMCF/b6X2+BE76/B0r0/uSGXjLnRoPDEjS4MMruzQ5aTSbEMMz7yiq82B/FsVEb+g1A/RvwHfLIwGoBZibD5JPn3gCBcZz1eFawHFen08GRJ+EhaQBkEyHHrerrAeVUEvVjObcyc0UG0rFNOBKx2zft00mWFQis5eiBrUPh3bAJ7gkWsCQeS6m88UOuVFVZ4SYe2rpACAk/tQE2c6A+jpTFSCyrZbdeqrsDs3n4J0u4XXOr1nZyBJus6cNLsxsVfk8EG9GLozGT2MuWUEmeRZ9meM9JOx6/4kvvX57U+fbzPgPSnj8TmMKn5kBVl7wcYunc858XYxwjgUIo0bL4Fcva1Ok/QWtZRWIddgmcIT2oGkOxLvINxSs06oSLlGGItWEN7PPi1h+d7qVR6itSrh9KUrIe3rr/xIu6CLoIzSr71KAe69qHtvSteB8Vel6nTWlLNV2V+D2ukQ7pDH83xSuEnQaA1MmWS47QyoZELiMwNekXcVTJ2QQFxW5NfRjZ+SCMZxSX1UOJPyiuRKklzAftAgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(107886003)(1076003)(83380400001)(38100700002)(66946007)(2616005)(26005)(30864003)(4326008)(8936002)(41300700001)(6666004)(5660300002)(8676002)(6512007)(966005)(478600001)(2906002)(6506007)(66556008)(66476007)(316002)(6916009)(6486002)(36756003)(82960400001)(86362001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iaXnY+4iQitZxmqN2/zCPg/w7glR9nO1Hqbf2yVkgYrC2QmU7FAPydO0SJgP?=
 =?us-ascii?Q?GZzspBXgdKraP0LWqAC3m/r6fd+ja60ddUmGsDTiLGU2bAGynO46GQ3Jddtf?=
 =?us-ascii?Q?MzZq7IOUV+4akFwr2Cn+66mpERTwBBC6UVWyRYc14EQ1K99tTjrlmzQCkmy0?=
 =?us-ascii?Q?+yE0+yY0AhqfuPHJ0CNWJF5JK3H/Q8tdAVPVDvBY383EBUh81pwasKrctTkk?=
 =?us-ascii?Q?gpv190XSUny7Ud0O+uzb4Hq/9YV5qNnWYAuocx7YGGLPo/1h7ch21FBHlvg9?=
 =?us-ascii?Q?dCerVEQsSVg5RUuRlzkyf36lukhGCxLJvA9rKSWdY7/AO/2wogCZybhNBo0h?=
 =?us-ascii?Q?SuG44YIE71OvPPyRo+Lt6PINiK6q/TyNPkz3tlzpVecYr4V1EWZDuB7MQq+d?=
 =?us-ascii?Q?fg0mK1ZTRnahaUe6J+64n6fsHlUkUZMJFYPW29Y9sKqFCG0+rxlVDQZ3aH7v?=
 =?us-ascii?Q?O/Pe7ar2Yl/PgkFbhtpsl3tL40bhXkOAMTG7JJ4+2MYSlhDvugA9lDktd6V0?=
 =?us-ascii?Q?zjXc4BNFfW7APp/0uWPaLoMK1v7qIe4+ACNPsUPgLMThIzSEH89NW2pV0DGF?=
 =?us-ascii?Q?HcfWgqa4xCYdoJDZaM13qPBEfmj+jJqj0O/4lNtfydEM6BtwKyR3Pv4iYyCq?=
 =?us-ascii?Q?cc+Aklgll8vqbV1P2SyQeu1WqHJqcFdoVKB6iiDYvGbAW4SCnFu9Mg7sCS7N?=
 =?us-ascii?Q?dSVD9wcFghPfOyFoBUsvj1NArczR83M0Ar/5FTenDEyZ1WaUvi/ziTFZUped?=
 =?us-ascii?Q?etdht4OAHpLuedrIHQOewQn4VQBiabxtcd8Uny/TDWCuPEERTFvHiTWtv0Xo?=
 =?us-ascii?Q?aI6wUJGUp6ZIhTeXTs6t/+etJngBCfrT6Aamrxsi5CUg0sU8uZngH7Fkxi8I?=
 =?us-ascii?Q?RNje7+gFkhUuydUEC+Vhuv4cEnOmvVEa3z0CfrWSuJnZic3kkmfgEbTwV9ot?=
 =?us-ascii?Q?9JQ3fx5NfJ/cXzKWtJ/H7vwieLhKRSlJnmpv6GSlNieS3h/E8LmqV5deUas2?=
 =?us-ascii?Q?WroCOCFbF7ZUSwKpMMMN6WyBeYBwgOvqzxx+O05KCD7OMKq0Y6j9mlQcoyUl?=
 =?us-ascii?Q?93/LAu1pYVWtkXsb0yWl0xNMbr41SOPZAN1JmKfLlbgqq+tgKGTaSijVEIQB?=
 =?us-ascii?Q?/5ieFsD8CGfQezsZa/iQ0aLS//gwm2OhfJEyVvtJnE08TG/EqKL3yZnIwrPS?=
 =?us-ascii?Q?CKW/2an7aeeyaYGvRBAo4TS4BcD03GYtMUSn/4FEkwyAHJUIdKOdJ2Y/TJOV?=
 =?us-ascii?Q?9mBgb8W5ME2gPA60Q0FX972cygyd+R32N7agn2Ygkb7hljuSuo2sykYYdXBu?=
 =?us-ascii?Q?1TeOLWgeNGnVXzh57qen0Kl2uDlChH9r8aeXOm25t90mhp9QRdVImUPzE5VG?=
 =?us-ascii?Q?uFfrpeB0cmDSU3gf6t754QppDsrXwLx/rCX55tIDcKQ63P/aaikEkM26yN7Y?=
 =?us-ascii?Q?GT3lRdaUaPMwhOuJL7S/kK1tk0PJ0TASOMYQKANcpdSkfZZZmEFpYYoiTGJL?=
 =?us-ascii?Q?jBVPbk0xZFFHVTVgxeRVowlucCfQ8+SLQ5T1H4Dr/4L8Qn2wDM+/Z6Y/jKwS?=
 =?us-ascii?Q?VQ8MefmS1UVAXhRn8e9atNgBGpgxal1TbKFkGGc50JfrNsy01VU1NZssfT8T?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 654b8ae2-4a8c-4cff-7143-08dc17689604
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 14:28:34.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /p6gGqY9XM0EhyHMAUnya2GPvofNxvlLivttmkGR1LEzCzmI/lNgeq/9aX/Ow1XuZasbHejkTmrTN+mBCIMEgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_ftrace_push_return_trace" on:

commit: 367c724761b0a49e115dd3bb27e93b3905cfe05a ("function_graph: Improve push operation for several interrupts")
https://git.kernel.org/cgit/linux/kernel/git/mhiramat/linux.git topic/fprobe-on-fgraph

in testcase: ftrace-onoff
version: 
with following parameters:

	runtime: 5m



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401172217.36e37075-oliver.sang@intel.com


[ 43.381281][ T644] BUG: KASAN: slab-out-of-bounds in ftrace_push_return_trace+0x7e0/0x820 
[   43.390620][  T644] Write of size 8 at addr ffff888116ea1ff8 by task cat/644
[   43.397694][  T644]
[   43.399903][  T644] CPU: 1 PID: 644 Comm: cat Not tainted 6.7.0-rc8-00020-g367c724761b0 #1
[   43.408197][  T644] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[   43.416323][  T644] Call Trace:
[   43.419491][  T644]  <TASK>
[ 43.422316][ T644] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 43.426715][ T644] print_address_description+0x2c/0x3a0 
[ 43.433196][ T644] ? ftrace_push_return_trace+0x7e0/0x820 
[ 43.439857][ T644] print_report (mm/kasan/report.c:476) 
[ 43.444161][ T644] ? fixup_red_left (mm/slub.c:224) 
[ 43.448650][ T644] ? kasan_addr_to_slab (mm/kasan/common.c:35) 
[ 43.453485][ T644] ? ftrace_push_return_trace+0x7e0/0x820 
[ 43.460143][ T644] kasan_report (mm/kasan/report.c:590) 
[ 43.464461][ T644] ? ftrace_push_return_trace+0x7e0/0x820 
[ 43.471130][ T644] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:469) 
[ 43.476040][ T644] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 43.480689][ T644] ftrace_push_return_trace+0x7e0/0x820 
[ 43.487161][ T644] ? trace_graph_entry (arch/x86/include/asm/atomic.h:60 include/linux/atomic/atomic-arch-fallback.h:1210 include/linux/atomic/atomic-instrumented.h:593 kernel/trace/trace_functions_graph.c:188) 
[ 43.492173][ T644] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:469) 
[ 43.497079][ T644] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 43.501724][ T644] function_graph_enter_ops (kernel/trace/fgraph.c:702) 
[ 43.507071][ T644] ? kernel_text_address (kernel/extable.c:95) 
[ 43.512071][ T644] ? function_graph_enter (kernel/trace/fgraph.c:690) 
[ 43.517338][ T644] ? ftrace_graph_func (arch/x86/kernel/ftrace.c:674) 
[ 43.522352][ T644] ? kernel_text_address (kernel/extable.c:95) 
[ 43.527372][ T644] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:469) 
[ 43.532287][ T644] ftrace_graph_func (arch/x86/kernel/ftrace.c:674) 
[ 43.537116][ T644] ? write_profile (kernel/stacktrace.c:83) 
[   43.541769][  T644]  0xffffffffc0478087
[ 43.545670][ T644] ? do_exit (kernel/exit.c:859) 
[ 43.549799][ T644] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:471) 
[ 43.554715][ T644] unwind_next_frame (arch/x86/kernel/unwind_orc.c:471) 
[ 43.559444][ T644] arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[ 43.563944][ T644] ? do_exit (kernel/exit.c:859) 
[ 43.568090][ T644] stack_trace_save (kernel/stacktrace.c:123) 
[ 43.572653][ T644] ? filter_irq_stacks (kernel/stacktrace.c:114) 
[ 43.577492][ T644] ? stack_trace_save (kernel/stacktrace.c:114) 
[ 43.582148][ T644] kasan_save_stack (mm/kasan/common.c:46) 
[ 43.586707][ T644] ? kasan_save_stack (mm/kasan/common.c:46) 
[ 43.591436][ T644] ? kasan_set_track (mm/kasan/common.c:52) 
[ 43.596081][ T644] ? kasan_save_free_info (mm/kasan/generic.c:524) 
[ 43.601159][ T644] ? __kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244) 
[ 43.606150][ T644] ? kmem_cache_free_bulk (mm/slub.c:4037) 
[ 43.612010][ T644] ? mt_destroy_walk+0x56f/0xfd0 
[ 43.617435][ T644] ? __mt_destroy (lib/maple_tree.c:5338) 
[ 43.621906][ T644] ? exit_mmap (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/linux/mmap_lock.h:41 include/linux/mmap_lock.h:131 mm/mmap.c:3341) 
[ 43.626203][ T644] ? __mmput (kernel/fork.c:1350) 
[ 43.630241][ T644] ? exit_mm (kernel/exit.c:568) 
[ 43.634374][ T644] ? do_exit (kernel/exit.c:859) 
[ 43.638643][ T644] ? mt_destroy_walk+0x56f/0xfd0 
[ 43.644071][ T644] kasan_set_track (mm/kasan/common.c:52) 
[ 43.648544][ T644] kasan_save_free_info (mm/kasan/generic.c:524) 
[ 43.653452][ T644] __kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244) 
[ 43.658280][ T644] kmem_cache_free_bulk (mm/slub.c:4037) 
[ 43.663969][ T644] ? mt_destroy_walk+0x56f/0xfd0 
[ 43.669445][ T644] mt_destroy_walk+0x56f/0xfd0 
[ 43.674747][ T644] __mt_destroy (lib/maple_tree.c:5338) 
[ 43.679062][ T644] exit_mmap (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/linux/mmap_lock.h:41 include/linux/mmap_lock.h:131 mm/mmap.c:3341) 
[ 43.683205][ T644] ? do_vma_munmap (mm/mmap.c:3283) 
[ 43.687684][ T644] ? mutex_unlock (kernel/locking/mutex.c:538) 
[ 43.692014][ T644] ? ftrace_graph_func (arch/x86/kernel/ftrace.c:674) 
[ 43.697069][ T644] ? __mmput (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/khugepaged.h:38 kernel/fork.c:1348) 
[ 43.701136][ T644] __mmput (kernel/fork.c:1350) 
[ 43.705015][ T644] exit_mm (kernel/exit.c:568) 
[ 43.708973][ T644] do_exit (kernel/exit.c:859) 
[ 43.712936][ T644] ? exit_mm (kernel/exit.c:810) 
[ 43.717057][ T644] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 43.721969][ T644] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 43.726901][ T644] do_group_exit (kernel/exit.c:999) 
[ 43.731301][ T644] __x64_sys_exit_group (kernel/exit.c:1027) 
[ 43.736215][ T644] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 43.740518][ T644] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   43.746293][  T644] RIP: 0033:0x7fddfe515699
[ 43.750594][ T644] Code: Unable to access opcode bytes at 0x7fddfe51566f.

Code starting with the faulting instruction
===========================================
[   43.757492][  T644] RSP: 002b:00007fff2924edf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   43.765794][  T644] RAX: ffffffffffffffda RBX: 00007fddfe60a610 RCX: 00007fddfe515699
[   43.773649][  T644] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   43.781505][  T644] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 0000000000000001
[   43.789373][  T644] R10: 00007fddfe63a1c0 R11: 0000000000000246 R12: 00007fddfe60a610
[   43.797228][  T644] R13: 0000000000000002 R14: 00007fddfe60aae8 R15: 0000000000000000
[   43.805145][  T644]  </TASK>
[   43.808050][  T644]
[   43.810258][  T644] Allocated by task 478:
[ 43.814377][ T644] kasan_save_stack (mm/kasan/common.c:46) 
[ 43.818934][ T644] kasan_set_track (mm/kasan/common.c:52) 
[ 43.823405][ T644] __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383) 
[ 43.827877][ T644] ftrace_graph_init_task (include/linux/slab.h:600 kernel/trace/fgraph.c:1168) 
[ 43.833130][ T644] copy_process (kernel/fork.c:1947 (discriminator 4) kernel/fork.c:2360 (discriminator 4)) 
[ 43.837599][ T644] kernel_clone (include/linux/random.h:26 kernel/fork.c:2908) 
[ 43.841896][ T644] __do_sys_clone (kernel/fork.c:3039) 
[ 43.846277][ T644] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 43.850574][ T644] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[   43.856360][  T644]
[   43.858566][  T644] Freed by task 0:
[ 43.862167][ T644] kasan_save_stack (mm/kasan/common.c:46) 
[ 43.866723][ T644] kasan_set_track (mm/kasan/common.c:52) 
[ 43.871193][ T644] kasan_save_free_info (mm/kasan/generic.c:524) 
[ 43.876094][ T644] __kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244) 
[ 43.880910][ T644] __kmem_cache_free (mm/slub.c:1826 mm/slub.c:3809 mm/slub.c:3822) 
[ 43.885729][ T644] free_task (kernel/fork.c:623 (discriminator 3)) 
[ 43.889764][ T644] rcu_do_batch (arch/x86/include/asm/preempt.h:27 kernel/rcu/tree.c:2165) 
[ 43.894148][ T644] rcu_core (kernel/rcu/tree.c:2433) 
[ 43.898183][ T644] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554) 
[   43.902567][  T644]
[   43.904776][  T644] The buggy address belongs to the object at ffff888116ea0000
[   43.904776][  T644]  which belongs to the cache kmalloc-4k of size 4096
[   43.918727][  T644] The buggy address is located 4088 bytes to the right of
[   43.918727][  T644]  allocated 4096-byte region [ffff888116ea0000, ffff888116ea1000)
[   43.933471][  T644]
[   43.935684][  T644] The buggy address belongs to the physical page:
[   43.941980][  T644] page:00000000206533fa refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x116ea0
[   43.952099][  T644] head:00000000206533fa order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   43.960911][  T644] flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[   43.969032][  T644] page_type: 0xffffffff()
[   43.973238][  T644] raw: 0017ffffc0000840 ffff88810c843040 ffffea00045ba600 0000000000000002
[   43.981703][  T644] raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
[   43.990167][  T644] page dumped because: kasan: bad access detected
[   43.996456][  T644]
[   43.998663][  T644] Memory state around the buggy address:
[   44.004172][  T644]  ffff888116ea1e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   44.012114][  T644]  ffff888116ea1f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   44.020056][  T644] >ffff888116ea1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   44.027999][  T644]                                                                 ^
[   44.035856][  T644]  ffff888116ea2000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   44.043803][  T644]  ffff888116ea2080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   44.051747][  T644] ==================================================================
[   44.059762][  T644] Disabling lock debugging due to kernel taint
[   44.423837][  T312] 2024-01-15 00:33:41 echo 1 > tracing_on
[   44.425933][  T312]
[   45.159545][  T312] 2024-01-15 00:33:41 echo 0 > tracing_on
[   45.159845][  T312]
[   45.289241][  T312] 2024-01-15 00:33:41 echo wakeup_dl > current_tracer
[   45.289643][  T312]
[   45.735915][  T312] 2024-01-15 00:33:42 echo 1 > tracing_on
[   45.735956][  T312]
[   45.780233][  T312] 2024-01-15 00:33:42 echo 0 > tracing_on
[   45.780288][  T312]
[   45.802820][  T312] 2024-01-15 00:33:42 echo wakeup_rt > current_tracer
[   45.802877][  T312]
[   46.191536][  T312] 2024-01-15 00:33:42 echo 1 > tracing_on
[   46.191576][  T312]
[   46.227375][  T312] 2024-01-15 00:33:42 echo 0 > tracing_on
[   46.227420][  T312]
[   46.248058][  T312] 2024-01-15 00:33:42 echo wakeup > current_tracer
[   46.248099][  T312]
[   46.637161][  T312] 2024-01-15 00:33:43 echo 1 > tracing_on


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240117/202401172217.36e37075-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


