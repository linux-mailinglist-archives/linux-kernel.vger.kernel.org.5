Return-Path: <linux-kernel+bounces-54226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7C84AC8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7BC1F23E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4066E2B0;
	Tue,  6 Feb 2024 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jW7FcCcH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52F73163
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188176; cv=fail; b=Bk0ZZzc0KIUezsHJoSmwBlqJWQiZiCJdg6R+rhFyf4Xhc1QNJUPI8zazIUAtutUQtXFZjWWhvUbVyipYlFbcNTpCdsASJ7KxjbsM1MXF2Q0+2Cpike26tHRiqvEPuuyDXoraXTktcoN2rrin4QFNWlABQ9LA0RZaZ1qQR0BaIFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188176; c=relaxed/simple;
	bh=mnPF6/YTvQ2L+ljtgn69MtHDbbxfA5bR7O5EmhVeVlk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=mL69DMZQ/woLBLG4KcgETRX7yHT8tXZMGfNwBCPLt7oBC2bCmuFD5rI/xVXOGwvxAiu1faN8NdC9iGvBPalxDzj2tlYj3tYS/yUijw601A6p2t3/vqSbtGbmsyx9Jc4FV3J1V4MecXxRlzneQvrVGdIUszBn8o88y7PET6z0gEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jW7FcCcH; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707188168; x=1738724168;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=mnPF6/YTvQ2L+ljtgn69MtHDbbxfA5bR7O5EmhVeVlk=;
  b=jW7FcCcHKjbh0Q3dkZzxyTg6YIiVizo+AToLjX+gZN+0aF3XNzPJ3e5n
   9HoPwVC1GuIZ2v3xd5dU0/WE/zKDt4p1cWokbDJWW2j7fw2BM5dddM7uW
   r2PPI39iewBTOlLUtaBkkJ14Nz3AVFsLgrJNWtVk5Eex3xzE4k+P/1uvX
   cdBJifksv/NRbAOx6bstGhnQ4Bmx8Zt9r/q4AVWKzJ6GFgVZzzOtcQhMp
   aguYNV7XDo3MSNpJnvxM3nj4JSYov/pQJo5PxdzD9GGkj/JtO1iKaAZYf
   OYPV1O++mWMkJedVVoowLGHKK4KO+KQtXEwr/tcX1aGnoXESSHzf0oI2R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="26098022"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="26098022"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5494868"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 18:55:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 18:55:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 18:55:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 18:55:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL5fZPSMw5Wixii0P85N8RNajxcPkhA+Etl8S/qLnDu3GVNDaaNesfdwO/x1dTmUEfLi/tqajTgm5bE8531itLE/XPoS1sK6DFlrVH4zoXvI14XhPr6nL51gi/qfJwOswIM4iLlP3BdqaiGw5CqoRgb2ciHCkFc0oJBvoLoQwUMctih0olGnO+8e0Dq2ETKusqknzyjPy2TjGq7Xc8kOo+pDCFksvC2Wd44A/198CDHl9Aaa1ebIWvDEzGrKeloXKW9aLg15ssbpC0ciR7ibpppDmYK8HX35XURmQiu138Mgq/bU7NuEvllut+PfJIr5/T2fxRk/BorW00rgdC/IhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmscwAzxMGGTgjNyIeXIL6b50YgRMnR7NShrl6X4gQ8=;
 b=Y8s69fr930P+fJ17LWGiOrWH6MDqPH4eHrM0PFXD3l9zTvCT9CPeed50miWoXcD/MUZ4ryaLsmitJqzd4wBWEhJgP1f9lCpIBeLOx9RFiV0KvtfxxjSmcS/PAxbSnjHUynsPm7CefdgHfZML+XKBIBo0D5mYb+IP6+tFdzxWWxvejXOa8Rf61lhaobClks4ekTUobbF95Yb38uCETZVLkzNt/B+N9qWbIDEf9QsY/27oN14lgnyi/ccsdYgj7KvnefGNl3hqMvu4YbcuOPXjALKGlIQJKZSvvnIhMW8/0j5zkj/7UX9zeDGNov/3MtpR6/tHkKo3po03tuQNDeJPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7516.namprd11.prod.outlook.com (2603:10b6:510:275::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 02:55:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 02:55:45 +0000
Date: Tue, 6 Feb 2024 10:55:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, kernel test robot
	<oliver.sang@intel.com>, Yin Fengwei <fengwei.yin@intel.com>, Rik van Riel
	<riel@surriel.com>, Matthew Wilcox <willy@infradead.org>, Christopher Lameter
	<cl@linux.com>, "Huang, Ying" <ying.huang@intel.com>, <feng.tang@intel.com>
Subject: [linus:master] [mm]  c4608d1bf7:  stream.triad_bandwidth_MBps 22.1%
 improvement
Message-ID: <202402061011.250e6fc7-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b990b6-7ecf-4424-af87-08dc26bf1cab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5k24b1FR01jQ3lXluyUeiigenU3WbVltqp5EGbEFbfugqjuCotNbok0x0O4AFix/d9VXQMK0SIWaVz6FGzERWgJ+yfUBDMlJSHDEUZ6p25LlynaB5gkNuzcTd6NiDPW7d1PO4LIimmLrfKpgV1lfXRIa5v3x/QnB75qwWovQJtzd0CvY1EWm6BpwTjK4O8VQGRIA9O+C+vi0jbtwun8/mxWlm+e7bHT4NeI1BbF8uaNwvUKjhs//ylq72Z0rij2lX2IJT2CyXEgryxbHeL6xBxE+9oapCcWqTN7tMqNrQHXZLakEvIC9U6xZ/QZAmupGpXHsHwN8bDvhsEz+2dJjXEHjXF+28TDeWyK7ERobPqONjDj4yNQLK6vz1m0RprzuxFIvhGIV9BYFsxGEu6VK+LFUq1QDx/p3TisAcFECW+8YFWCvCS8swzU9RBbyOtB4tzMf6HJMcTI370u4qu7KbfMqEG804VDyhyGRH48xU1OYF8G9fvh1tHO7vMVZ6Zqw9uO3EVrNvvvAFbD+kjtPJ1BQiOFqa0o053NPYHeE5mfyomKGPdbmx/Gdc+ExSp1M3YzsPm4fYJ/F4j2wBtm3KYKUFRp3qNYfqvhRCSGZTEBg8c0qISlbsGKXgHiov47VmptdOUCCwwaJBxTIn8MXEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(230473577357003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(66476007)(54906003)(66556008)(66946007)(19627235002)(36756003)(316002)(6916009)(5660300002)(30864003)(2906002)(4326008)(8676002)(8936002)(83380400001)(82960400001)(38100700002)(6506007)(6666004)(6512007)(478600001)(966005)(6486002)(1076003)(26005)(2616005)(107886003)(86362001)(559001)(579004)(568244002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mGcXUK47kQVuKA0jselQegU3mlu69r+UsR/oDEHp2KpopwieuJqx7NMOe0?=
 =?iso-8859-1?Q?PefZgM/rCpCoDiuOcq4XYyXcdBGMWWUo3cCRcmydoGbtDFiDaVxtKq3sxj?=
 =?iso-8859-1?Q?/kyP3jhjOCaScRVKsL6TcK6bgJVAOoBhCX84iSpGqmQMRBfC7+FzIvlNWB?=
 =?iso-8859-1?Q?Kk6PMtpZobCzt7GKfBVgRhsRUFtnPcl9nj+7qs1jXXqeVhxhmukQD/4E9c?=
 =?iso-8859-1?Q?YbUdO8V4kO+/acuuqUFw4QnJWVpyIQCaS4hUzB2jsWee8ae4DgKdk2xll/?=
 =?iso-8859-1?Q?wspSjrkvC0RKpfLheIecHWf0nBFwOoX8EiQkaD42rZHLqn3FZCF5gkoPdd?=
 =?iso-8859-1?Q?V3wbfPZUDYGBgUrb523kVnVA/igYPGVB535KcALEInseJqqpGgw0bTx15h?=
 =?iso-8859-1?Q?/aX9r4F2kdL99ozULSfjVW/EQ3DGTbTOOb+05aX6ZbPQgwMUxqrS4yRyVp?=
 =?iso-8859-1?Q?ABch3NEoYUjq5fHdIMQXfWyc/cB4nfV6l8fdFCihYulRl0YQ3SL27xSxsj?=
 =?iso-8859-1?Q?/DApU8HiDs34wAfWo8TAV61zl46/uBvCSMOGm+6DVsoUgxcRy5q1nffhpT?=
 =?iso-8859-1?Q?CJuGuTk5X5l1wsk774FY8jE5wGu8MR2nzQVTk7cPatfDGTf7rhychbbJnZ?=
 =?iso-8859-1?Q?ttuK8+7laGlwMJPsFlQVzSVeNz7LqjRQ+s4YEdrLUTxGi6ThwCwPzQCL5p?=
 =?iso-8859-1?Q?EZTS5PQPzWYUg7R4G7KeaobEIHOfahSJzB3rTvaexGBQG6CtoWCq3gK1ER?=
 =?iso-8859-1?Q?ZNnDvvPfdIsTXCCrUivNEdcBMA+6OWFJ75qSzPXNtRpYthbrEXGJ52uQiM?=
 =?iso-8859-1?Q?4lb3tC1YRqWv6ccNSSXjpdvyJEG6f8SEkH+3TvkLMboZEATTxgrFYJy8UM?=
 =?iso-8859-1?Q?4ln3jWoLNkCxaWzqfnh/HMuMxS1jwFwAq+N4OjGH+94FxD6Yl1s/dZCRNo?=
 =?iso-8859-1?Q?XMC+owaLCs+mCiZ36JevPtLU1U+ABt9JTcHt9VJUQrVXT0makiMOmpVija?=
 =?iso-8859-1?Q?QdNjCQSKi7VRrNhIvsvBs1spdUdySbOAkdY9WYNGBnXnw+QvIihbiDmGvQ?=
 =?iso-8859-1?Q?U3QL2LXoGrIlNQu1WDESQiyO5ouXQrzVL2qsDKo8IRORV0n5gFpkYxNvUt?=
 =?iso-8859-1?Q?W1ktuzu5LpilkxEuVSuPdRRgrjaLDVl9E6WSVqC8JTush7aVomQbn2l5nn?=
 =?iso-8859-1?Q?SpfwqpASAW4Jtbd39FzIodjVRrF3aVnzY6qjVcZiAIJAfUHD4P8lEeTPVY?=
 =?iso-8859-1?Q?RX8AqBb76JtZZ1A0pKpOGRIGf69A9G232VF19SyYnHdcykJdY/nNI3Bmbh?=
 =?iso-8859-1?Q?ayZpj0atjoL8q/9icBCFxJsNjoj/3N6houd30u/YsCG1jokkILksw9RuKl?=
 =?iso-8859-1?Q?HuAENx4vGkcIqdFplSSFuAfH7kzU1jcvGEydyYTwKGcTGi3ri1GrBNyLis?=
 =?iso-8859-1?Q?lR0Sxi0nIk6RqKH6GK1aJ8DQKNJviv2eHrfYtiG6ntmTXwJ+Dgx1yOoaAT?=
 =?iso-8859-1?Q?9sF6E2i6CNTfPvT7ag3i6SPfh5fHtf6Q0BHcvZYBdhnYGxowi/70TRFDko?=
 =?iso-8859-1?Q?HuhVwD1O7cTC2YsUcO/ucHV6ihh0qWUeFpoPqhzYsk+vaQVKlR5MK2MomE?=
 =?iso-8859-1?Q?GVIUi3TWS27b9GIUKB1EavuUFTOzMoqaLI2UfCwBpllYyx4GENNyZ+iw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b990b6-7ecf-4424-af87-08dc26bf1cab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 02:55:44.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oChkrQvyj5wTaAz06E4BWuZ0VJY+J6zeH0YwEQahq2aJPbtCK7ru0UooNPRNrg/zuopcHGZjDp0FVReyWp+f/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7516
X-OriginatorOrg: intel.com


hi, Yang Shi,

we noticed this commit is merged into mainline. this report is just FYI about
the performance impact by it we observed so far in various microbenchmark.


Hello,

kernel test robot noticed a 22.1% improvement of stream.triad_bandwidth_MBps on:


commit: c4608d1bf7c6536d1a3d233eb21e50678681564e ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stream
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_threads: 25%
	iterations: 10x
	array_size: 10000000
	omp: true
	loop: 100
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.exit-group.ops_per_sec 161.4% improvement                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory   |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=exit-group                                                                             |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput 3.9% improvement                                  |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | runtime=300s                                                                                |
|                  | size=8T                                                                                     |
|                  | test=anon-w-seq-mt                                                                          |
+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | ftq: ftq.mean 24.7% improvement                                                             |
| test machine     | 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory      |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | freq=10000                                                                                  |
|                  | nr_task=100%                                                                                |
|                  | samples=100000ss                                                                            |
|                  | test=add                                                                                    |
+------------------+---------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240206/202402061011.250e6fc7-oliver.sang@intel.com

=========================================================================================
array_size/compiler/cpufreq_governor/iterations/kconfig/loop/nr_threads/omp/rootfs/tbox_group/testcase:
  10000000/gcc-12/performance/10x/x86_64-rhel-8.3/100/25%/true/debian-11.1-x86_64-20220510.cgz/lkp-spr-2sp4/stream

commit: 
  4dca82d141 ("uprobes: use pagesize-aligned virtual address when replacing pages")
  c4608d1bf7 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")

4dca82d14174fe53 c4608d1bf7c6536d1a3d233eb21 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4932 ± 50%     +55.1%       7649 ± 36%  numa-meminfo.node1.PageTables
      1226 ± 50%     +56.0%       1912 ± 36%  numa-vmstat.node1.nr_page_table_pages
 6.753e+08 ±  5%     -13.8%  5.824e+08        cpuidle..time
    657589 ±  6%     -15.5%     555812 ±  4%  cpuidle..usage
      1.10 ±  3%      -0.1        1.01 ±  2%  mpstat.cpu.all.irq%
     12.15 ±  6%      -1.9       10.23 ±  3%  mpstat.cpu.all.usr%
     17.70 ±  3%     +16.9%      20.70 ±  5%  vmstat.procs.r
     17270 ±  3%      +6.6%      18404        vmstat.system.cs
      2556 ±  3%      -7.6%       2362 ±  4%  meminfo.Active
      2476 ±  3%      -8.1%       2275 ±  5%  meminfo.Active(anon)
    463862            -9.5%     419831        meminfo.Inactive
    463653            -9.5%     419580        meminfo.Inactive(anon)
      0.35 ±218%     -99.6%       0.00 ±142%  perf-sched.sch_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      2.41 ±221%     -99.9%       0.00 ±145%  perf-sched.sch_delay.max.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
    182.85 ± 29%    +123.0%     407.75 ± 48%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    155.43 ± 48%    +145.3%     381.32 ± 54%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.87 ±  4%     -14.0%       0.75 ±  5%  perf-stat.i.cpi
      1.15 ±  4%     +16.2%       1.34 ±  4%  perf-stat.i.ipc
      0.50 ±100%    +400.0%       2.50 ± 85%  perf-stat.i.major-faults
      0.88 ±  5%     -14.5%       0.75 ±  5%  perf-stat.overall.cpi
      1.14 ±  5%     +16.9%       1.34 ±  4%  perf-stat.overall.ipc
     12789            -3.6%      12328        perf-stat.ps.context-switches
    365.00 ±  3%      -8.9%     332.33 ±  2%  turbostat.Avg_MHz
    316656 ±  4%     -14.7%     269972        turbostat.C1E
    355767 ±  4%     -15.9%     299227        turbostat.C6
      3.31 ± 12%     +24.8%       4.14 ±  8%  turbostat.CPU%c6
    745192 ±  5%     -15.6%     628915        turbostat.IRQ
     51.67 ±  2%      +4.8%      54.17        turbostat.PkgTmp
     30.92 ±  3%     -10.7%      27.61 ±  2%  turbostat.RAMWatt
    743432 ±  6%     +20.7%     897687 ±  3%  stream.add_bandwidth_MBps
    705392 ±  9%     +25.4%     884265 ±  5%  stream.add_bandwidth_MBps_harmonicMean
    699213 ±  5%     +25.2%     875368 ±  2%  stream.copy_bandwidth_MBps
    673222 ±  7%     +28.7%     866700 ±  3%  stream.copy_bandwidth_MBps_harmonicMean
    646727 ±  4%     +19.9%     775579 ±  2%  stream.scale_bandwidth_MBps
    630892 ±  5%     +22.0%     769679 ±  2%  stream.scale_bandwidth_MBps_harmonicMean
    348332           -32.3%     235887        stream.time.maximum_resident_set_size
     76.69 ±  7%     -23.4%      58.71 ±  3%  stream.time.user_time
    717218 ±  5%     +22.1%     875736 ±  2%  stream.triad_bandwidth_MBps
    688850 ±  8%     +25.9%     867030 ±  3%  stream.triad_bandwidth_MBps_harmonicMean
    619.21 ±  3%      -8.1%     568.75 ±  5%  proc-vmstat.nr_active_anon
    113926            -8.4%     104360        proc-vmstat.nr_anon_pages
    115989            -9.5%     104946        proc-vmstat.nr_inactive_anon
     33181            -1.7%      32625        proc-vmstat.nr_slab_reclaimable
    105946            -1.2%     104679        proc-vmstat.nr_slab_unreclaimable
    619.21 ±  3%      -8.1%     568.75 ±  5%  proc-vmstat.nr_zone_active_anon
    115989            -9.5%     104946        proc-vmstat.nr_zone_inactive_anon
    735636            -1.3%     725946        proc-vmstat.numa_hit
    502867            -1.7%     494253        proc-vmstat.numa_local
   1956978           -22.5%    1517089 ±  4%  proc-vmstat.pgalloc_normal
    345737            -1.8%     339543        proc-vmstat.pgfault
   1479880           -32.9%     992647 ±  8%  proc-vmstat.pgfree
     18013 ±  2%      -3.1%      17457        proc-vmstat.pgreuse
      1749           -42.5%       1005 ±  8%  proc-vmstat.thp_fault_alloc
     26.60 ± 51%     -25.9        0.69 ±223%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
     26.60 ± 51%     -25.9        0.69 ±223%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.60 ± 51%     -25.9        0.69 ±223%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
     26.45 ± 52%     -25.8        0.69 ±223%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
     26.45 ± 52%     -25.8        0.69 ±223%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
     26.62 ± 51%     -25.2        1.40 ±110%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     26.77 ± 50%     -24.9        1.83 ± 79%  perf-profile.calltrace.cycles-pp.write
     26.62 ± 51%     -24.8        1.83 ± 79%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     26.62 ± 51%     -24.8        1.83 ± 79%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     26.62 ± 51%     -24.8        1.83 ± 79%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.31 ± 57%     -24.8        0.54 ±223%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
     16.48 ± 69%     -16.3        0.15 ±223%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
     15.96 ± 59%     -15.8        0.15 ±223%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
     11.61 ± 81%      -6.3        5.28 ±223%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     11.54 ± 81%      -6.3        5.28 ±223%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
     11.54 ± 81%      -6.3        5.28 ±223%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
     11.54 ± 81%      -6.3        5.28 ±223%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
     12.15 ± 78%      -5.8        6.33 ±214%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     12.15 ± 78%      -5.8        6.33 ±214%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     12.15 ± 78%      -5.8        6.33 ±214%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     10.84 ± 81%      -5.8        5.05 ±223%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
      8.38 ± 24%      -4.7        3.68 ± 74%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.98 ± 24%      -4.3        3.68 ± 74%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      7.79 ± 24%      -4.1        3.68 ± 74%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.88 ± 66%      -3.7        0.15 ±223%  perf-profile.calltrace.cycles-pp.vt_console_print.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      3.76 ± 69%      -3.6        0.15 ±223%  perf-profile.calltrace.cycles-pp.con_scroll.lf.vt_console_print.console_flush_all.console_unlock
      3.76 ± 69%      -3.6        0.15 ±223%  perf-profile.calltrace.cycles-pp.fbcon_scroll.con_scroll.lf.vt_console_print.console_flush_all
      3.76 ± 69%      -3.6        0.15 ±223%  perf-profile.calltrace.cycles-pp.lf.vt_console_print.console_flush_all.console_unlock.vprintk_emit
      3.72 ± 69%      -3.6        0.15 ±223%  perf-profile.calltrace.cycles-pp.fbcon_redraw.fbcon_scroll.con_scroll.lf.vt_console_print
      3.41 ± 68%      -3.3        0.15 ±223%  perf-profile.calltrace.cycles-pp.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll.lf
      3.32 ± 71%      -3.2        0.15 ±223%  perf-profile.calltrace.cycles-pp.bit_putcs.fbcon_putcs.fbcon_redraw.fbcon_scroll.con_scroll
      1.39 ± 43%      +3.4        4.76 ± 66%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.57 ±119%      +3.8        4.33 ± 76%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      0.57 ±119%      +4.1        4.71 ± 67%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.main
      1.06 ± 44%      +5.6        6.63 ± 72%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main.__libc_start_main
      1.06 ± 44%      +5.6        6.63 ± 72%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
     27.64 ± 47%     -27.0        0.69 ±223%  perf-profile.children.cycles-pp.vprintk_emit
     26.86 ± 50%     -26.2        0.69 ±223%  perf-profile.children.cycles-pp.console_flush_all
     26.86 ± 50%     -26.2        0.69 ±223%  perf-profile.children.cycles-pp.console_unlock
     28.16 ± 44%     -26.0        2.21 ± 80%  perf-profile.children.cycles-pp.vfs_write
     26.60 ± 51%     -25.9        0.69 ±223%  perf-profile.children.cycles-pp.devkmsg_emit
     26.60 ± 51%     -25.9        0.69 ±223%  perf-profile.children.cycles-pp.devkmsg_write
     28.16 ± 44%     -25.5        2.64 ± 79%  perf-profile.children.cycles-pp.ksys_write
     26.77 ± 50%     -24.9        1.83 ± 79%  perf-profile.children.cycles-pp.write
     22.84 ± 50%     -22.3        0.54 ±223%  perf-profile.children.cycles-pp.serial8250_console_write
     18.05 ± 58%     -17.7        0.30 ±223%  perf-profile.children.cycles-pp.io_serial_in
     17.79 ± 51%     -17.5        0.30 ±223%  perf-profile.children.cycles-pp.wait_for_lsr
     11.61 ± 81%      -6.3        5.28 ±223%  perf-profile.children.cycles-pp.worker_thread
     11.54 ± 81%      -6.3        5.28 ±223%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
     11.54 ± 81%      -6.3        5.28 ±223%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
     11.54 ± 81%      -6.3        5.28 ±223%  perf-profile.children.cycles-pp.process_one_work
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.commit_tail
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.drm_atomic_commit
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.drm_fb_memcpy
     11.21 ± 81%      -6.1        5.12 ±223%  perf-profile.children.cycles-pp.memcpy_toio
     12.28 ± 76%      -5.9        6.40 ±214%  perf-profile.children.cycles-pp.ret_from_fork
     12.28 ± 76%      -5.9        6.40 ±214%  perf-profile.children.cycles-pp.ret_from_fork_asm
     12.15 ± 78%      -5.8        6.33 ±214%  perf-profile.children.cycles-pp.kthread
      5.18 ± 56%      -5.0        0.23 ±223%  perf-profile.children.cycles-pp.io_serial_out
      8.38 ± 24%      -4.7        3.68 ± 74%  perf-profile.children.cycles-pp.cpuidle_idle_call
      7.98 ± 24%      -4.3        3.68 ± 74%  perf-profile.children.cycles-pp.cpuidle_enter
      7.95 ± 24%      -4.3        3.68 ± 74%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.88 ± 66%      -3.7        0.15 ±223%  perf-profile.children.cycles-pp.vt_console_print
      3.76 ± 69%      -3.6        0.15 ±223%  perf-profile.children.cycles-pp.con_scroll
      3.76 ± 69%      -3.6        0.15 ±223%  perf-profile.children.cycles-pp.fbcon_redraw
      3.76 ± 69%      -3.6        0.15 ±223%  perf-profile.children.cycles-pp.fbcon_scroll
      3.76 ± 69%      -3.6        0.15 ±223%  perf-profile.children.cycles-pp.lf
      3.43 ± 68%      -3.3        0.15 ±223%  perf-profile.children.cycles-pp.fbcon_putcs
      3.35 ± 71%      -3.2        0.15 ±223%  perf-profile.children.cycles-pp.bit_putcs
      1.56 ± 41%      +3.2        4.76 ± 66%  perf-profile.children.cycles-pp.open_last_lookups
      0.59 ±164%      +3.9        4.46 ± 79%  perf-profile.children.cycles-pp.format_decode
     16.97 ± 51%     -16.7        0.30 ±223%  perf-profile.self.cycles-pp.io_serial_in
     11.10 ± 81%      -6.0        5.05 ±223%  perf-profile.self.cycles-pp.memcpy_toio
      5.18 ± 56%      -5.0        0.23 ±223%  perf-profile.self.cycles-pp.io_serial_out
      0.44 ±145%      +3.6        4.04 ± 92%  perf-profile.self.cycles-pp.format_decode


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/exit-group/stress-ng/60s

commit: 
  4dca82d141 ("uprobes: use pagesize-aligned virtual address when replacing pages")
  c4608d1bf7 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")

4dca82d14174fe53 c4608d1bf7c6536d1a3d233eb21 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.581e+08 ±  7%     +16.6%   5.34e+08 ±  7%  cpuidle..time
      9.81 ±  8%      +2.4       12.19 ±  6%  mpstat.cpu.all.idle%
      3.56            -0.7        2.88        mpstat.cpu.all.irq%
      0.32            +0.2        0.47        mpstat.cpu.all.soft%
  16799019          +173.4%   45927515        numa-numastat.node0.local_node
  16825160          +173.1%   45955434        numa-numastat.node0.numa_hit
  17714356          +153.4%   44890235        numa-numastat.node1.local_node
  17753905          +153.0%   44924123        numa-numastat.node1.numa_hit
   6226167           +32.9%    8275178        vmstat.memory.cache
    108.99 ±  2%     +96.3%     213.97 ±  4%  vmstat.procs.r
   1152243           +45.6%    1678096        vmstat.system.cs
    447520 ±  2%      +8.0%     483102 ±  4%  vmstat.system.in
    211334          +161.4%     552334        stress-ng.exit-group.ops
      3522          +161.4%       9205        stress-ng.exit-group.ops_per_sec
   4132463           +21.2%    5007796        stress-ng.time.involuntary_context_switches
  17544358          +161.0%   45793334 ±  2%  stress-ng.time.minor_page_faults
      5129           -28.0%       3690        stress-ng.time.percent_of_cpu_this_job_got
      3023           -28.4%       2165        stress-ng.time.system_time
     58.49           -10.3%      52.45        stress-ng.time.user_time
  51540117           +51.5%   78061749        stress-ng.time.voluntary_context_switches
   1742819           -17.0%    1446463 ±  4%  meminfo.Active
   1742707           -17.0%    1446352 ±  4%  meminfo.Active(anon)
   1221198           -83.5%     201820        meminfo.AnonHugePages
   2145679           -22.7%    1657691        meminfo.AnonPages
   6101931           +33.1%    8120330        meminfo.Cached
  10048954           +29.5%   13008917        meminfo.Committed_AS
   3697454           +48.1%    5475178        meminfo.Inactive
   3697207           +48.1%    5474929        meminfo.Inactive(anon)
   1359211 ±  2%     -22.6%    1052000 ±  5%  meminfo.Mapped
   3248297           +62.1%    5266704        meminfo.Shmem
     11.04 ±  6%      +1.9       12.93 ±  7%  turbostat.C1%
      9.31 ±  7%     +25.4%      11.68 ±  8%  turbostat.CPU%c1
     74.17 ±  4%      -6.7%      69.17 ±  5%  turbostat.CoreTmp
      0.04          +104.2%       0.08 ±  4%  turbostat.IPC
     20.87 ±  4%     -20.8        0.07 ± 44%  turbostat.PKG_%
    183848 ±  3%     -25.5%     137030        turbostat.POLL
      0.04            -0.0        0.03        turbostat.POLL%
     74.17 ±  4%      -7.4%      68.67 ±  5%  turbostat.PkgTmp
    403.79            -5.7%     380.84        turbostat.PkgWatt
    202.66           -55.4%      90.41        turbostat.RAMWatt
    628241 ±  6%     -85.4%      91973 ± 28%  numa-meminfo.node0.AnonHugePages
    838175 ±  9%     -67.2%     274650 ± 18%  numa-meminfo.node0.AnonPages
   1055199 ±  6%     -67.3%     345194 ± 27%  numa-meminfo.node0.AnonPages.max
    278148 ± 24%     +60.3%     445896 ± 20%  numa-meminfo.node0.Mapped
    342194 ± 24%    +193.5%    1004354 ± 22%  numa-meminfo.node0.Shmem
   1537838 ±  2%     -21.0%    1214837 ±  7%  numa-meminfo.node1.Active
   1537782 ±  2%     -21.0%    1214800 ±  7%  numa-meminfo.node1.Active(anon)
    586658 ±  5%     -81.3%     109956 ± 23%  numa-meminfo.node1.AnonHugePages
   2413160 ±  4%     +39.2%    3360047 ±  2%  numa-meminfo.node1.AnonPages.max
   2695295 ±  5%     +64.7%    4439310 ±  3%  numa-meminfo.node1.Inactive
   2695170 ±  5%     +64.7%    4439227 ±  3%  numa-meminfo.node1.Inactive(anon)
   1090759 ±  7%     -44.0%     610616 ± 11%  numa-meminfo.node1.Mapped
   2904867 ±  3%     +46.9%    4267267 ±  5%  numa-meminfo.node1.Shmem
    208727 ±  9%     -67.1%      68699 ± 18%  numa-vmstat.node0.nr_anon_pages
    305.12 ±  6%     -85.3%      44.91 ± 28%  numa-vmstat.node0.nr_anon_transparent_hugepages
     69595 ± 24%     +60.3%     111576 ± 20%  numa-vmstat.node0.nr_mapped
     85575 ± 24%    +193.4%     251118 ± 22%  numa-vmstat.node0.nr_shmem
  16826160          +173.1%   45955983        numa-vmstat.node0.numa_hit
  16800019          +173.4%   45928064        numa-vmstat.node0.numa_local
    384602 ±  2%     -21.0%     303735 ±  7%  numa-vmstat.node1.nr_active_anon
    288.20 ±  6%     -81.4%      53.68 ± 23%  numa-vmstat.node1.nr_anon_transparent_hugepages
    674733 ±  5%     +64.5%    1110120 ±  3%  numa-vmstat.node1.nr_inactive_anon
    273497 ±  7%     -44.1%     152784 ± 11%  numa-vmstat.node1.nr_mapped
    726487 ±  3%     +46.9%    1066981 ±  5%  numa-vmstat.node1.nr_shmem
    384602 ±  2%     -21.0%     303735 ±  7%  numa-vmstat.node1.nr_zone_active_anon
    674608 ±  5%     +64.6%    1110120 ±  3%  numa-vmstat.node1.nr_zone_inactive_anon
  17756798          +153.0%   44924254        numa-vmstat.node1.numa_hit
  17717250          +153.4%   44890366        numa-vmstat.node1.numa_local
    433893           -16.6%     361671 ±  4%  proc-vmstat.nr_active_anon
    535834           -22.6%     414568        proc-vmstat.nr_anon_pages
    594.59           -83.4%      98.56        proc-vmstat.nr_anon_transparent_hugepages
   1524663           +33.2%    2030246        proc-vmstat.nr_file_pages
    924956           +48.0%    1368939        proc-vmstat.nr_inactive_anon
     25171            +8.0%      27178        proc-vmstat.nr_kernel_stack
    341043 ±  2%     -22.8%     263162 ±  5%  proc-vmstat.nr_mapped
      7611 ±  3%      +7.7%       8199        proc-vmstat.nr_page_table_pages
    811254           +62.3%    1316838        proc-vmstat.nr_shmem
     25870            +4.6%      27069        proc-vmstat.nr_slab_reclaimable
     49746            +2.4%      50927        proc-vmstat.nr_slab_unreclaimable
    433893           -16.6%     361671 ±  4%  proc-vmstat.nr_zone_active_anon
    924958           +48.0%    1368939        proc-vmstat.nr_zone_inactive_anon
  34575440          +162.8%   90877583        proc-vmstat.numa_hit
  34509751          +163.2%   90815776        proc-vmstat.numa_local
     11347 ± 40%     -70.4%       3354 ± 55%  proc-vmstat.numa_pages_migrated
    529545 ±  7%     +38.1%     731444 ±  5%  proc-vmstat.numa_pte_updates
 1.768e+09           -94.1%  1.035e+08        proc-vmstat.pgalloc_normal
  18794548          +151.0%   47175940 ±  2%  proc-vmstat.pgfault
 1.766e+09           -94.3%  1.007e+08        proc-vmstat.pgfree
     11347 ± 40%     -70.4%       3354 ± 55%  proc-vmstat.pgmigrate_success
    223983          +142.0%     541996        proc-vmstat.pgreuse
   3382395          -100.0%      80.17        proc-vmstat.thp_fault_alloc
    211455          +161.3%     552435        proc-vmstat.thp_split_pmd
   3298118           -40.6%    1958692        sched_debug.cfs_rq:/.avg_vruntime.avg
   3897078           -42.6%    2238578        sched_debug.cfs_rq:/.avg_vruntime.max
   2651550 ±  9%     -48.1%    1377122 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
    234258 ± 12%     -30.6%     162648 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.17 ±  7%     +62.0%       1.89 ±  8%  sched_debug.cfs_rq:/.h_nr_running.avg
      5.42 ± 14%     +72.3%       9.33 ± 21%  sched_debug.cfs_rq:/.h_nr_running.max
      1.19 ± 13%     +76.6%       2.10 ± 10%  sched_debug.cfs_rq:/.h_nr_running.stddev
    263965 ± 28%    +134.5%     619131 ± 19%  sched_debug.cfs_rq:/.left_deadline.avg
   3511990 ±  6%     -37.6%    2192708        sched_debug.cfs_rq:/.left_deadline.max
    263961 ± 28%    +134.5%     619095 ± 19%  sched_debug.cfs_rq:/.left_vruntime.avg
   3511894 ±  6%     -37.6%    2192642        sched_debug.cfs_rq:/.left_vruntime.max
     65381 ± 16%    +255.5%     232455 ± 22%  sched_debug.cfs_rq:/.load.avg
    236049 ±  4%     +49.9%     353799 ±  6%  sched_debug.cfs_rq:/.load.stddev
     11.92 ± 18%    +184.6%      33.92 ± 10%  sched_debug.cfs_rq:/.load_avg.min
   3298119           -40.6%    1958693        sched_debug.cfs_rq:/.min_vruntime.avg
   3897078           -42.6%    2238578        sched_debug.cfs_rq:/.min_vruntime.max
   2651553 ±  9%     -48.1%    1377130 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
    234258 ± 12%     -30.6%     162647 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.63 ±  2%     +17.0%       0.74 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
      0.41 ±  7%     +36.0%       0.56 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
    263961 ± 28%    +134.5%     619095 ± 19%  sched_debug.cfs_rq:/.right_vruntime.avg
   3511894 ±  6%     -37.6%    2192645        sched_debug.cfs_rq:/.right_vruntime.max
    797.70 ±  3%     +20.6%     961.91 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      2364 ±  9%     +24.8%       2952 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    159.42 ± 30%     +44.9%     230.92 ± 13%  sched_debug.cfs_rq:/.runnable_avg.min
      0.06 ±198%    +445.1%       0.30 ±106%  sched_debug.cfs_rq:/.spread.avg
      3.54 ±198%    +363.2%      16.40 ±110%  sched_debug.cfs_rq:/.spread.max
      0.44 ±198%    +382.4%       2.12 ±108%  sched_debug.cfs_rq:/.spread.stddev
    717.11 ±  3%     +16.9%     838.29 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
     91.18 ± 14%     +83.3%     167.15 ± 10%  sched_debug.cfs_rq:/.util_est.avg
    218.84 ± 16%     +27.8%     279.68 ±  7%  sched_debug.cfs_rq:/.util_est.stddev
    203039 ± 10%     -23.1%     156224 ±  7%  sched_debug.cpu.avg_idle.stddev
   1506577 ±  5%     -78.7%     320787 ± 15%  sched_debug.cpu.curr->pid.avg
   1770276           -76.0%     424425 ±  8%  sched_debug.cpu.curr->pid.max
    618660 ± 11%     -71.5%     176532 ± 11%  sched_debug.cpu.curr->pid.stddev
      1.18 ±  9%     +63.1%       1.92 ±  9%  sched_debug.cpu.nr_running.avg
      5.75 ± 10%     +58.0%       9.08 ± 22%  sched_debug.cpu.nr_running.max
      1.22 ± 14%     +74.0%       2.12 ± 10%  sched_debug.cpu.nr_running.stddev
    567506           +45.8%     827216        sched_debug.cpu.nr_switches.avg
    773792 ± 11%     +28.0%     990816 ±  3%  sched_debug.cpu.nr_switches.max
    445206 ± 12%     +29.4%     575974 ±  6%  sched_debug.cpu.nr_switches.min
     66.33           -93.6%       4.25        perf-stat.i.MPKI
 5.294e+09          +111.9%  1.122e+10        perf-stat.i.branch-instructions
      1.32            -0.2        1.12        perf-stat.i.branch-miss-rate%
  66289300           +83.2%  1.215e+08        perf-stat.i.branch-misses
     64.57           -38.9       25.68        perf-stat.i.cache-miss-rate%
 1.601e+09           -86.3%   2.19e+08        perf-stat.i.cache-misses
 2.479e+09           -65.6%  8.524e+08        perf-stat.i.cache-references
   1224102           +42.9%    1748660        perf-stat.i.context-switches
      8.81           -54.0%       4.05        perf-stat.i.cpi
 2.139e+11            -2.9%  2.078e+11        perf-stat.i.cpu-cycles
    196114 ±  2%     +52.8%     299742        perf-stat.i.cpu-migrations
    133.74          +611.2%     951.12        perf-stat.i.cycles-between-cache-misses
   9125073 ±  2%    +122.7%   20322336 ±  6%  perf-stat.i.dTLB-load-misses
 6.657e+09          +107.0%  1.378e+10        perf-stat.i.dTLB-loads
      0.10            +0.0        0.13        perf-stat.i.dTLB-store-miss-rate%
   3439904 ±  3%    +128.8%    7871449        perf-stat.i.dTLB-store-misses
  3.72e+09           +68.2%  6.256e+09        perf-stat.i.dTLB-stores
 2.601e+10          +105.8%  5.353e+10        perf-stat.i.instructions
      0.12          +111.7%       0.26        perf-stat.i.ipc
      0.16 ± 71%    +445.4%       0.87 ± 52%  perf-stat.i.major-faults
      3.31            -2.1%       3.24        perf-stat.i.metric.GHz
    949.14          +121.9%       2106        perf-stat.i.metric.K/sec
    302.68           +65.6%     501.12        perf-stat.i.metric.M/sec
    307392          +152.3%     775558 ±  2%  perf-stat.i.minor-faults
     56.55           +23.1       79.68        perf-stat.i.node-load-miss-rate%
  24442475           +69.2%   41362113        perf-stat.i.node-load-misses
  19043036 ±  2%     -43.9%   10692592 ±  3%  perf-stat.i.node-loads
      0.87           +22.7       23.56        perf-stat.i.node-store-miss-rate%
  12394302           +52.0%   18834493        perf-stat.i.node-store-misses
 1.413e+09           -95.7%   61197755        perf-stat.i.node-stores
    307394          +152.3%     775561 ±  2%  perf-stat.i.page-faults
     62.61           -93.4%       4.11        perf-stat.overall.MPKI
      1.26            -0.2        1.08        perf-stat.overall.branch-miss-rate%
     64.53           -38.9       25.66        perf-stat.overall.cache-miss-rate%
      8.36           -53.4%       3.90        perf-stat.overall.cpi
    133.60          +609.2%     947.51        perf-stat.overall.cycles-between-cache-misses
      0.09            +0.0        0.13 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
      0.12          +114.7%       0.26        perf-stat.overall.ipc
     55.14           +24.0       79.11        perf-stat.overall.node-load-miss-rate%
      0.86           +22.7       23.53        perf-stat.overall.node-store-miss-rate%
 4.857e+09 ±  3%    +112.6%  1.033e+10 ±  8%  perf-stat.ps.branch-instructions
  61217951 ±  3%     +83.0%   1.12e+08 ±  8%  perf-stat.ps.branch-misses
 1.495e+09 ±  3%     -86.4%  2.026e+08 ±  8%  perf-stat.ps.cache-misses
 2.317e+09 ±  3%     -65.9%  7.896e+08 ±  8%  perf-stat.ps.cache-references
   1144864 ±  3%     +41.6%    1620771 ±  8%  perf-stat.ps.context-switches
    182642 ±  3%     +52.5%     278547 ±  8%  perf-stat.ps.cpu-migrations
   8937610 ±  5%    +120.7%   19721959 ± 12%  perf-stat.ps.dTLB-load-misses
 6.148e+09 ±  3%    +106.6%   1.27e+10 ±  8%  perf-stat.ps.dTLB-loads
   3256811 ±  4%    +125.1%    7330449 ±  8%  perf-stat.ps.dTLB-store-misses
 3.443e+09 ±  3%     +67.5%  5.768e+09 ±  8%  perf-stat.ps.dTLB-stores
 2.388e+10 ±  3%    +106.4%  4.928e+10 ±  8%  perf-stat.ps.instructions
      0.13 ± 73%    +506.7%       0.80 ± 53%  perf-stat.ps.major-faults
    287120 ±  3%    +149.9%     717532 ±  9%  perf-stat.ps.minor-faults
  22627163 ±  4%     +69.0%   38245986 ±  8%  perf-stat.ps.node-load-misses
  18415849 ±  5%     -45.4%   10064072 ±  6%  perf-stat.ps.node-loads
  11436745 ±  3%     +52.2%   17406467 ±  8%  perf-stat.ps.node-store-misses
  1.32e+09 ±  4%     -95.7%   56543004 ±  7%  perf-stat.ps.node-stores
    287122 ±  3%    +149.9%     717534 ±  9%  perf-stat.ps.page-faults
 1.432e+12 ±  4%     +69.5%  2.428e+12 ± 14%  perf-stat.total.instructions
     62.25           -62.2        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__clone
     62.29           -62.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__clone
     62.28           -62.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__clone
     62.32           -61.8        0.53 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__clone
     62.89           -61.7        1.23        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     61.02           -61.0        0.00        perf-profile.calltrace.cycles-pp.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     60.76           -60.8        0.00        perf-profile.calltrace.cycles-pp.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     56.86           -56.9        0.00        perf-profile.calltrace.cycles-pp.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     69.35           -41.0       28.40        perf-profile.calltrace.cycles-pp.__clone
      3.58 ±  2%      -1.2        2.37 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      3.52 ±  2%      -1.2        2.33 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.52 ±  2%      -1.2        2.33 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.51 ±  2%      -1.2        2.32 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.88 ±  2%      -1.0        1.89 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.73 ±  2%      -0.9        1.79 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.72 ±  2%      -0.9        1.78 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.62 ±  2%      -0.9        1.72 ±  2%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.57 ±  2%      -0.6        0.94 ±  2%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.78 ±  3%      -0.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.77 ±  3%      -0.3        0.42 ± 44%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.19 ±  3%      -0.3        0.90 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.85 ±  3%      -0.2        0.60 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      1.04            -0.1        0.90        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.80            -0.1        0.72        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.85            -0.1        0.77        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.85            -0.1        0.77        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      0.86            -0.1        0.78        perf-profile.calltrace.cycles-pp.__mmap
      0.84            -0.1        0.76        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.81            -0.1        0.74        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.64            -0.0        0.62        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55            +0.0        0.58        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.61            +0.0        0.64        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.pthread_create@@GLIBC_2.2.5
      0.66            +0.0        0.70        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.pthread_create@@GLIBC_2.2.5.stress_exit_group
      0.66            +0.0        0.70        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.pthread_create@@GLIBC_2.2.5.stress_exit_group
      0.52            +0.1        0.58        perf-profile.calltrace.cycles-pp.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process
      0.77            +0.1        0.84        perf-profile.calltrace.cycles-pp.pthread_create@@GLIBC_2.2.5.stress_exit_group
      0.70            +0.1        0.78        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.pthread_create@@GLIBC_2.2.5.stress_exit_group
      0.65 ±  6%      +0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.do_nanosleep
      2.34 ±  2%      +0.1        2.44        perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.29 ±  2%      +0.1        2.40        perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
      2.78            +0.1        2.89        perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.79            +0.1        2.90        perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      2.94            +0.1        3.05        perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      2.67            +0.1        2.78        perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      0.43 ± 44%      +0.1        0.56        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.83 ±  5%      +0.1        0.97        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.46 ± 45%      +0.2        0.65 ±  2%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.56 ±  3%      +0.2        0.75 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.56 ±  3%      +0.2        0.76 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.58            +0.2        0.81 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lll_lock_wait
      0.58            +0.2        0.81 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__lll_lock_wait
      0.54            +0.2        0.78        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      0.60 ±  3%      +0.3        0.85 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.52            +0.3        1.78        perf-profile.calltrace.cycles-pp.stress_exit_group
      0.65            +0.3        0.91        perf-profile.calltrace.cycles-pp.__lll_lock_wait
      3.51            +0.3        3.79        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
      0.88            +0.4        1.23        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      0.58            +0.4        0.97        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      0.74            +0.5        1.23        perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.__mprotect.stress_exit_group
      0.64            +0.5        1.17        perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.find_idlest_group.find_idlest_cpu.select_task_rq_fair.wake_up_new_task
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.76            +0.5        1.30 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      0.69            +0.6        1.25        perf-profile.calltrace.cycles-pp.find_idlest_group.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone
      0.09 ±223%      +0.6        0.64 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.65 ±  2%      +0.6        1.21 ±  2%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      0.78            +0.6        1.35        perf-profile.calltrace.cycles-pp.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      0.78            +0.6        1.36        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.78            +0.6        1.35 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.89            +0.6        1.47 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.6        0.59 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.futex_wait_queue.__futex_wait.futex_wait
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.6        0.61 ±  3%  perf-profile.calltrace.cycles-pp.schedule.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.00            +0.6        0.64 ±  3%  perf-profile.calltrace.cycles-pp.futex_wait_queue.__futex_wait.futex_wait.do_futex.__x64_sys_futex
      0.08 ±223%      +0.6        0.73 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lll_lock_wait
      0.00            +0.7        0.66 ±  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.7        0.68 ±  4%  perf-profile.calltrace.cycles-pp.____machine__findnew_thread.machine__process_fork_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.00            +0.7        0.69 ±  2%  perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
      0.00            +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lll_lock_wait
      0.00            +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.find_vm_area.alloc_thread_stack_node.dup_task_struct
      2.16            +0.8        2.96        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      2.01            +0.8        2.82        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.00            +0.8        0.83 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.find_vm_area.alloc_thread_stack_node.dup_task_struct.copy_process
      1.08            +0.9        1.93        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.88        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.wait_task_zombie.__do_wait
      0.00            +0.9        0.89 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.00            +0.9        0.91        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.wait_task_zombie.__do_wait.do_wait
      0.00            +0.9        0.92        perf-profile.calltrace.cycles-pp.find_vm_area.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone
      0.00            +0.9        0.94 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.00            +1.0        0.99        perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.__do_wait.do_wait.kernel_wait4
      0.00            +1.0        1.00        perf-profile.calltrace.cycles-pp.wait_task_zombie.__do_wait.do_wait.kernel_wait4.__do_sys_wait4
      0.00            +1.4        1.40        perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +1.6        1.62        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group
      2.60            +1.9        4.49        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      2.60            +1.9        4.49        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      2.60            +1.9        4.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      2.60            +1.9        4.49        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +1.9        1.90        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.__do_wait.do_wait.kernel_wait4
      0.00            +1.9        1.92        perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.__do_wait.do_wait.kernel_wait4.__do_sys_wait4
      2.80            +2.0        4.79        perf-profile.calltrace.cycles-pp.__libc_fork
      0.00            +2.0        2.02        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.mm_update_next_owner.exit_mm.do_exit
      0.00            +2.1        2.05        perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.mm_update_next_owner.exit_mm.do_exit.do_group_exit
      0.69 ±  3%      +2.2        2.90        perf-profile.calltrace.cycles-pp.mm_update_next_owner.exit_mm.do_exit.do_group_exit.get_signal
      0.76 ±  2%      +2.3        3.08        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.47            +2.3        3.80        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.47            +2.3        3.80        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.47            +2.3        3.80        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.23            +2.5        6.73        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      1.06 ±  5%      +2.6        3.71        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
      1.09 ±  5%      +2.7        3.80        perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.00            +2.9        2.94        perf-profile.calltrace.cycles-pp.__do_wait.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.38 ±  4%      +3.0        4.35        perf-profile.calltrace.cycles-pp.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.00            +3.0        3.02        perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.0        3.03        perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +3.0        3.03        perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +3.0        3.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +3.0        3.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +3.1        3.06        perf-profile.calltrace.cycles-pp.wait4
      1.02            +3.3        4.36 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.find_unlink_vmap_area.remove_vm_area.vfree
      1.03            +3.4        4.40        perf-profile.calltrace.cycles-pp._raw_spin_lock.find_unlink_vmap_area.remove_vm_area.vfree.delayed_vfree_work
      1.11            +3.5        4.57 ±  2%  perf-profile.calltrace.cycles-pp.find_unlink_vmap_area.remove_vm_area.vfree.delayed_vfree_work.process_one_work
      1.31            +3.7        4.97        perf-profile.calltrace.cycles-pp.remove_vm_area.vfree.delayed_vfree_work.process_one_work.worker_thread
      1.43            +3.7        5.18        perf-profile.calltrace.cycles-pp.vfree.delayed_vfree_work.process_one_work.worker_thread.kthread
      1.44            +3.8        5.20        perf-profile.calltrace.cycles-pp.delayed_vfree_work.process_one_work.worker_thread.kthread.ret_from_fork
      1.49            +3.8        5.28        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.54 ±  3%      +3.8        5.33        perf-profile.calltrace.cycles-pp.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process
      1.52            +3.8        5.36        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.07 ±  2%      +3.8        5.91        perf-profile.calltrace.cycles-pp.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone
      1.92            +4.1        6.02        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.92            +4.1        6.02        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.92            +4.1        6.02        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.98 ±  2%      +4.6        7.55        perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      2.45 ±  2%      +4.6        7.03        perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      1.39 ±  3%     +12.5       13.94        perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.do_group_exit.get_signal
      0.92 ±  4%     +13.2       14.07        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.exit_notify.do_exit
      1.08 ±  3%     +13.4       14.52        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.exit_notify.do_exit.do_group_exit
      2.10 ±  3%     +14.6       16.74        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit.get_signal
      1.52 ±  5%     +15.2       16.75        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone
      1.74 ±  4%     +15.5       17.22        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      1.82 ±  3%     +16.0       17.80        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit
      6.72           +20.7       27.42        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      6.72           +20.7       27.42        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      6.75           +20.7       27.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      6.75           +20.7       27.47        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clone
      8.10           +21.6       29.71        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.60 ±  2%     +27.6       31.19        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      9.41           +30.6       40.01        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.14           +30.7       39.81        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      8.60           +30.7       39.28        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.14           +30.7       39.81        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      8.60           +30.7       39.28        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.10           +33.0       43.10        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.10           +33.0       43.10        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     63.78           -61.3        2.44 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
     63.87           -61.3        2.54 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
     64.10           -61.2        2.86 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
     64.09           -61.2        2.85 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
     61.11           -61.1        0.00        perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
     64.28           -61.1        3.22 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
     60.60           -60.6        0.00        perf-profile.children.cycles-pp.clear_huge_page
     58.36           -57.7        0.66        perf-profile.children.cycles-pp.clear_page_erms
     69.38           -40.9       28.45        perf-profile.children.cycles-pp.__clone
      2.33            -2.1        0.24 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      3.58 ±  2%      -1.2        2.36 ±  2%  perf-profile.children.cycles-pp.do_idle
      3.58 ±  2%      -1.2        2.37 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      3.58 ±  2%      -1.2        2.37 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.52 ±  2%      -1.2        2.33 ±  2%  perf-profile.children.cycles-pp.start_secondary
      1.33            -1.0        0.28 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio
      1.59            -1.0        0.56        perf-profile.children.cycles-pp.get_page_from_freelist
      1.86            -1.0        0.84 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      1.87            -1.0        0.84        perf-profile.children.cycles-pp.alloc_pages_mpol
      2.93 ±  2%      -1.0        1.92 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.46            -1.0        0.46 ±  2%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      1.34            -1.0        0.35        perf-profile.children.cycles-pp.release_pages
      1.47            -1.0        0.49        perf-profile.children.cycles-pp.tlb_finish_mmu
      2.77 ±  2%      -1.0        1.81 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      2.78 ±  2%      -1.0        1.82 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      2.68 ±  2%      -0.9        1.75 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      2.66 ±  2%      -0.9        1.75 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      1.14            -0.8        0.30 ±  3%  perf-profile.children.cycles-pp.free_unref_page
      1.09 ±  2%      -0.6        0.49 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      3.27            -0.5        2.76        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.23            -0.4        1.79        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.20            -0.4        1.76        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.50            -0.4        0.07        perf-profile.children.cycles-pp.rcu_all_qs
      2.10            -0.4        1.67        perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.62            -0.3        2.32        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.60 ±  3%      -0.3        0.33 ±  3%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.49            -0.3        0.22 ±  3%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.58 ±  3%      -0.3        0.32 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.57 ±  3%      -0.3        0.32 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.41            -0.2        0.16 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
      0.55 ±  2%      -0.2        0.31 ±  2%  perf-profile.children.cycles-pp.select_task_rq
      0.50 ±  3%      -0.2        0.27 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.42            -0.2        0.19 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.42            -0.2        0.19 ±  2%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.36 ±  2%      -0.2        0.16 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.29 ±  8%      -0.2        0.09 ± 21%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.27 ±  2%      -0.2        0.07 ±  5%  perf-profile.children.cycles-pp.select_idle_cpu
      0.36 ± 16%      -0.2        0.20 ± 18%  perf-profile.children.cycles-pp.process_simple
      0.53 ±  2%      -0.2        0.37 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      1.33            -0.1        1.18        perf-profile.children.cycles-pp.hrtimer_wakeup
      0.32 ± 18%      -0.1        0.19 ± 20%  perf-profile.children.cycles-pp.ordered_events__queue
      0.18 ±  5%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.32 ± 18%      -0.1        0.19 ± 20%  perf-profile.children.cycles-pp.queue_event
      0.28 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.memset_orig
      0.57            -0.1        0.46        perf-profile.children.cycles-pp.syscall
      0.19 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      0.27 ±  4%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.27 ±  5%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.81            -0.1        0.72        perf-profile.children.cycles-pp.do_mmap
      0.15 ±  6%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.84            -0.1        0.76        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.13 ±  2%      -0.1        0.05        perf-profile.children.cycles-pp.__mod_node_page_state
      0.86            -0.1        0.78        perf-profile.children.cycles-pp.__mmap
      0.14 ±  4%      -0.1        0.06        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.37 ±  2%      -0.1        0.30        perf-profile.children.cycles-pp.switch_fpu_return
      0.16 ±  3%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.taskstats_exit
      0.30            -0.1        0.24        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.44            -0.0        0.39 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.15 ±  3%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.get_unmapped_area
      0.11 ±  6%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.13 ±  3%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.13 ±  3%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.thp_get_unmapped_area
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.27            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      0.43 ±  2%      -0.0        0.39 ±  3%  perf-profile.children.cycles-pp.__memcpy
      0.11 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.folio_add_lru_vma
      0.09            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.pcpu_alloc
      0.20            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.65 ±  2%      -0.0        0.62        perf-profile.children.cycles-pp.mmap_region
      0.11 ±  6%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.15 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.mas_preallocate
      0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.20 ±  2%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.acct_collect
      0.37 ±  2%      -0.0        0.34 ±  3%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.menu_select
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.14 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.mm_init
      0.27 ±  2%      -0.0        0.24        perf-profile.children.cycles-pp.___perf_sw_event
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.start_thread
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.08 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.allocate_slab
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.18 ±  2%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.mas_push_data
      0.24 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.gup_pgd_range
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.remove_vma
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.get_user_pages_fast
      0.07            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.clockevents_program_event
      0.11 ±  3%      +0.0        0.12        perf-profile.children.cycles-pp.free_swap_cache
      0.07            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.get_futex_key
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.wake_affine
      0.16 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.06 ±  9%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.place_entity
      0.19 ±  3%      +0.0        0.21        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.16 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.unlink_file_vma
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.pick_eevdf
      0.16 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.exit_task_stack_account
      0.08 ±  4%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.__call_rcu_common
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.task_fork_fair
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.14 ±  3%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.06            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__rb_erase_color
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.07            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.04 ± 45%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__put_user_4
      0.06 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.copy_thread
      0.07 ±  7%      +0.0        0.09        perf-profile.children.cycles-pp.rb_erase
      0.24            +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.vma_modify
      0.12 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.perf_event_task
      0.23 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.perf_event_fork
      0.08 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.sched_cgroup_fork
      0.07            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.update_min_vruntime
      0.28 ±  2%      +0.0        0.31 ±  2%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.memcg_charge_kernel_stack
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.07 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__perf_sw_event
      0.07            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.03 ± 70%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.exit_mm_release
      0.07 ±  6%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__split_huge_pmd
      0.07 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.avg_vruntime
      0.13 ±  6%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.pick_link
      0.10 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.mm_release
      0.08 ±  5%      +0.0        0.12        perf-profile.children.cycles-pp.sched_clock
      0.06 ±  9%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__lookup_slow
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.10            +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.13 ±  4%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__split_huge_pmd_locked
      0.04 ± 44%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.09 ±  7%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.14 ±  7%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.step_into
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.do_huge_pmd_wp_page
      0.06 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rb_insert_color
      0.09 ±  5%      +0.0        0.13        perf-profile.children.cycles-pp.native_sched_clock
      0.11 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.schedule_tail
      0.06            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.cgroup_exit
      0.10            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.14 ±  3%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.05 ±  7%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.31 ±  3%      +0.0        0.35 ±  8%  perf-profile.children.cycles-pp._compound_head
      0.54            +0.0        0.58 ±  2%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.04 ± 45%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.machine__process_exit_event
      0.11 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
      0.16 ±  3%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.11 ±  4%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__dentry_kill
      0.06 ±  8%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__reclaim_stacks
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.copy_creds
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.do_notify_parent
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ptep_clear_flush
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.stress_sigalrm_pending
      0.33 ±  2%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.mprotect_fixup
      0.19 ±  2%      +0.1        0.24        perf-profile.children.cycles-pp.perf_event_task_output
      0.06 ±  7%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__enqueue_entity
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.09 ±  5%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.31 ±  2%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      0.10            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__free_one_page
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.put_prev_entity
      0.10 ±  4%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__dequeue_entity
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.pids_can_fork
      0.08            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__mmdrop
      0.12 ±  4%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.06 ±  7%      +0.1        0.12        perf-profile.children.cycles-pp.put_pid
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.fput
      0.07 ±  7%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__put_anon_vma
      0.02 ±141%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.02 ± 99%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__vunmap_range_noflush
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.idr_get_free
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.mas_store
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.pids_release
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.vm_normal_page
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.free_p4d_range
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.free_pgd_range
      0.39 ±  2%      +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.39            +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.futex_exit_release
      0.08 ±  9%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.walk_component
      0.10 ±  3%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.mas_next_slot
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.insert_vmap_area_augment
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.radix_tree_delete_item
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.idr_alloc_cyclic
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.idr_alloc_u32
      0.20 ±  2%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.__vm_area_free
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.sigemptyset@plt
      0.02 ±141%      +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.vunmap_p4d_range
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__free_pages
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.free_pud_range
      0.06 ±  8%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.cpu_util
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.__put_task_struct
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.refill_obj_stock
      0.36 ±  2%      +0.1        0.43        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__purge_vmap_area_lazy
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.blake2s_update
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.drain_vmap_area_work
      0.44            +0.1        0.51 ±  2%  perf-profile.children.cycles-pp.__pthread_mutex_unlock_usercnt
      0.08            +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.free_pid
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.refcount_dec_not_one
      0.07            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.dput
      0.20 ±  2%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.49            +0.1        0.56 ±  2%  perf-profile.children.cycles-pp.futex_wake
      0.45 ±  2%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.cgroup_free
      0.17 ±  2%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.01 ±223%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.kfree
      0.14 ±  2%      +0.1        0.22        perf-profile.children.cycles-pp.zap_other_threads
      0.11            +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.15 ±  4%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.30            +0.1        0.39        perf-profile.children.cycles-pp.perf_iterate_sb
      0.02 ±141%      +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.cgroup_css_set_fork
      0.73            +0.1        0.82        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.21 ±  2%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.14 ±  2%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.mas_find
      0.06            +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.set_pte_range
      0.28 ±  4%      +0.1        0.37 ±  4%  perf-profile.children.cycles-pp.wp_page_copy
      0.07            +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.cgroup_can_fork
      0.08 ±  6%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.add_device_randomness
      0.43            +0.1        0.52        perf-profile.children.cycles-pp.__mprotect
      0.18 ±  2%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.11 ±  5%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.copy_present_pte
      0.10 ±  9%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.link_path_walk
      0.94            +0.1        1.03        perf-profile.children.cycles-pp.ttwu_do_activate
      0.08            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      0.05            +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.07 ±  5%      +0.1        0.17 ±  3%  perf-profile.children.cycles-pp.__put_partials
      0.22 ±  5%      +0.1        0.32        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.29 ±  3%      +0.1        0.39 ±  5%  perf-profile.children.cycles-pp.copy_pte_range
      0.06            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.cgroup_release
      0.39 ±  2%      +0.1        0.49 ±  4%  perf-profile.children.cycles-pp.copy_p4d_range
      0.80            +0.1        0.90        perf-profile.children.cycles-pp.pthread_create@@GLIBC_2.2.5
      0.06 ±  8%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      2.79            +0.1        2.90        perf-profile.children.cycles-pp.hrtimer_nanosleep
      2.95            +0.1        3.05        perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      2.68            +0.1        2.80        perf-profile.children.cycles-pp.do_nanosleep
      0.48            +0.1        0.59 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.41            +0.1        0.52 ±  4%  perf-profile.children.cycles-pp.copy_page_range
      2.80            +0.1        2.92        perf-profile.children.cycles-pp.common_nsleep
      0.08            +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.insert_vmap_area
      0.24 ±  6%      +0.1        0.36 ±  6%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.01 ±223%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.cgroup_post_fork
      0.24 ±  7%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.path_lookupat
      0.42            +0.1        0.55        perf-profile.children.cycles-pp.update_curr
      0.24 ±  8%      +0.1        0.37 ±  5%  perf-profile.children.cycles-pp.filename_lookup
      0.94            +0.1        1.07        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.45            +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.down_write
      0.09            +0.1        0.23        perf-profile.children.cycles-pp._raw_write_lock_irq
      0.17 ±  4%      +0.1        0.31        perf-profile.children.cycles-pp.sched_move_task
      0.21            +0.2        0.36 ±  2%  perf-profile.children.cycles-pp.__exit_signal
      0.06            +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.__task_rq_lock
      0.27 ±  7%      +0.2        0.42 ±  5%  perf-profile.children.cycles-pp.vfs_statx
      0.53 ±  2%      +0.2        0.69        perf-profile.children.cycles-pp.dequeue_entity
      0.13 ±  6%      +0.2        0.29 ±  2%  perf-profile.children.cycles-pp.detach_tasks
      0.35 ±  4%      +0.2        0.51        perf-profile.children.cycles-pp.irq_exit_rcu
      0.15 ±  7%      +0.2        0.32 ±  2%  perf-profile.children.cycles-pp.free_vmap_area_noflush
      0.21            +0.2        0.38 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.23 ±  3%      +0.2        0.40 ±  3%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.30 ±  8%      +0.2        0.48 ±  5%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.36 ±  2%      +0.2        0.55 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.32 ±  2%      +0.2        0.51 ±  2%  perf-profile.children.cycles-pp.__pte_alloc
      0.32 ±  7%      +0.2        0.51 ±  5%  perf-profile.children.cycles-pp.__xstat64
      0.59            +0.2        0.78        perf-profile.children.cycles-pp.enqueue_entity
      0.15 ±  2%      +0.2        0.34 ±  4%  perf-profile.children.cycles-pp.up_write
      0.17 ±  2%      +0.2        0.38        perf-profile.children.cycles-pp.alloc_pid
      0.32 ±  7%      +0.2        0.52 ±  4%  perf-profile.children.cycles-pp.nsinfo__new
      0.34            +0.2        0.55        perf-profile.children.cycles-pp.__slab_free
      0.33 ±  7%      +0.2        0.53 ±  4%  perf-profile.children.cycles-pp.thread__new
      4.04            +0.2        4.27        perf-profile.children.cycles-pp.exit_mmap
      0.32 ±  2%      +0.2        0.55 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      4.05            +0.2        4.28        perf-profile.children.cycles-pp.__mmput
      0.45 ±  2%      +0.2        0.69 ±  2%  perf-profile.children.cycles-pp.__futex_wait
      0.48 ±  2%      +0.2        0.72 ±  2%  perf-profile.children.cycles-pp.futex_wait
      0.40 ±  2%      +0.2        0.64 ±  3%  perf-profile.children.cycles-pp.futex_wait_queue
      0.50 ±  8%      +0.2        0.74 ±  4%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.36 ±  3%      +0.2        0.61 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.73            +0.3        0.99        perf-profile.children.cycles-pp.update_load_avg
      1.53            +0.3        1.79        perf-profile.children.cycles-pp.stress_exit_group
      0.50 ±  7%      +0.3        0.76 ±  4%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.62            +0.3        0.88        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.67            +0.3        0.94 ±  2%  perf-profile.children.cycles-pp.__lll_lock_wait
      0.39 ±  2%      +0.3        0.66 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.27            +0.3        0.54        perf-profile.children.cycles-pp.do_task_dead
      0.90            +0.3        1.18 ±  2%  perf-profile.children.cycles-pp.__x64_sys_futex
      0.38 ±  4%      +0.3        0.69 ±  7%  perf-profile.children.cycles-pp.filemap_map_pages
      0.97            +0.3        1.29 ±  2%  perf-profile.children.cycles-pp.do_futex
      1.02            +0.3        1.34        perf-profile.children.cycles-pp.activate_task
      0.40 ±  4%      +0.3        0.72 ±  7%  perf-profile.children.cycles-pp.do_fault
      0.40 ±  4%      +0.3        0.72 ±  8%  perf-profile.children.cycles-pp.do_read_fault
      0.77 ±  6%      +0.3        1.11 ±  2%  perf-profile.children.cycles-pp.load_balance
      0.90 ±  5%      +0.3        1.24 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      0.79            +0.3        1.14        perf-profile.children.cycles-pp.dequeue_task_fair
      0.93            +0.4        1.28        perf-profile.children.cycles-pp.enqueue_task_fair
      0.59 ±  3%      +0.4        0.94        perf-profile.children.cycles-pp.rcu_do_batch
      0.60 ±  3%      +0.4        0.97        perf-profile.children.cycles-pp.rcu_core
      1.02            +0.4        1.39        perf-profile.children.cycles-pp.free_pgtables
      0.59            +0.4        0.98        perf-profile.children.cycles-pp.anon_vma_clone
      1.33            +0.4        1.72        perf-profile.children.cycles-pp.select_task_rq_fair
      0.68 ±  3%      +0.4        1.10        perf-profile.children.cycles-pp.__do_softirq
      0.58 ±  2%      +0.5        1.03        perf-profile.children.cycles-pp.do_anonymous_page
      1.27 ±  4%      +0.5        1.73        perf-profile.children.cycles-pp.pick_next_task_fair
      2.86            +0.5        3.32        perf-profile.children.cycles-pp.schedule
      0.74            +0.5        1.23        perf-profile.children.cycles-pp.anon_vma_fork
      3.73            +0.5        4.24        perf-profile.children.cycles-pp.__schedule
      0.91            +0.6        1.47        perf-profile.children.cycles-pp.kmem_cache_free
      0.69            +0.6        1.27        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.74            +0.6        1.34        perf-profile.children.cycles-pp.find_idlest_group
      0.88            +0.6        1.48 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
      0.83            +0.6        1.44        perf-profile.children.cycles-pp.find_idlest_cpu
      0.90 ±  2%      +0.6        1.53 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      1.03            +0.6        1.67 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      0.77 ±  2%      +0.7        1.43 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
      2.16            +0.8        2.96        perf-profile.children.cycles-pp.dup_mm
      0.12 ±  4%      +0.8        0.93        perf-profile.children.cycles-pp.find_vm_area
      2.01            +0.8        2.83        perf-profile.children.cycles-pp.dup_mmap
      0.11            +0.9        1.00        perf-profile.children.cycles-pp.wait_task_zombie
      1.15            +0.9        2.06        perf-profile.children.cycles-pp.wake_up_new_task
      2.81            +2.0        4.82        perf-profile.children.cycles-pp.__libc_fork
      2.04            +2.2        4.25        perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.73 ±  2%      +2.2        2.97        perf-profile.children.cycles-pp.mm_update_next_owner
      4.97            +2.6        7.52        perf-profile.children.cycles-pp.exit_mm
      0.27 ±  3%      +2.7        2.94        perf-profile.children.cycles-pp.__do_wait
      0.32 ±  3%      +2.7        3.03        perf-profile.children.cycles-pp.__do_sys_wait4
      0.31 ±  3%      +2.7        3.02        perf-profile.children.cycles-pp.do_wait
      0.32 ±  3%      +2.7        3.03        perf-profile.children.cycles-pp.kernel_wait4
      0.34 ±  3%      +2.7        3.06        perf-profile.children.cycles-pp.wait4
      1.41 ±  4%      +3.0        4.41        perf-profile.children.cycles-pp.alloc_vmap_area
      1.11            +3.5        4.57 ±  2%  perf-profile.children.cycles-pp.find_unlink_vmap_area
      1.31            +3.7        4.97        perf-profile.children.cycles-pp.remove_vm_area
      0.32 ±  4%      +3.7        4.03        perf-profile.children.cycles-pp.queued_read_lock_slowpath
      1.43            +3.7        5.18        perf-profile.children.cycles-pp.vfree
      1.44            +3.8        5.20        perf-profile.children.cycles-pp.delayed_vfree_work
      1.49            +3.8        5.28        perf-profile.children.cycles-pp.process_one_work
      1.57 ±  3%      +3.8        5.40        perf-profile.children.cycles-pp.__get_vm_area_node
      1.52            +3.8        5.36        perf-profile.children.cycles-pp.worker_thread
      2.11 ±  2%      +3.9        5.99        perf-profile.children.cycles-pp.__vmalloc_node_range
      1.92            +4.1        6.02        perf-profile.children.cycles-pp.kthread
      2.05            +4.2        6.21        perf-profile.children.cycles-pp.ret_from_fork
      2.11            +4.2        6.30        perf-profile.children.cycles-pp.ret_from_fork_asm
      3.11            +4.6        7.71        perf-profile.children.cycles-pp.dup_task_struct
      2.54 ±  2%      +4.6        7.15        perf-profile.children.cycles-pp.alloc_thread_stack_node
      3.16            +8.1       11.22        perf-profile.children.cycles-pp._raw_spin_lock
      1.80 ±  2%     +14.6       16.36        perf-profile.children.cycles-pp.release_task
      8.12           +21.6       29.75        perf-profile.children.cycles-pp.copy_process
      9.33           +22.6       31.92        perf-profile.children.cycles-pp.__do_sys_clone
      9.33           +22.6       31.92        perf-profile.children.cycles-pp.kernel_clone
      4.40 ±  2%     +30.0       34.36        perf-profile.children.cycles-pp.exit_notify
      9.84           +30.6       40.44        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      9.50           +30.6       40.10        perf-profile.children.cycles-pp.arch_do_signal_or_restart
      9.49           +30.6       40.10        perf-profile.children.cycles-pp.get_signal
     11.08           +32.8       43.90        perf-profile.children.cycles-pp.do_exit
     11.25           +32.9       44.14        perf-profile.children.cycles-pp.do_group_exit
      5.77 ±  3%     +45.3       51.07        perf-profile.children.cycles-pp.queued_write_lock_slowpath
      8.68 ±  2%     +56.1       64.76        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     27.03           +58.6       85.63        perf-profile.children.cycles-pp.do_syscall_64
     27.06           +58.6       85.67        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     57.54           -56.9        0.66        perf-profile.self.cycles-pp.clear_page_erms
      1.73            -1.6        0.11        perf-profile.self.cycles-pp.__cond_resched
      1.27 ±  2%      -0.4        0.87 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.31 ± 18%      -0.1        0.19 ± 20%  perf-profile.self.cycles-pp.queue_event
      0.27 ±  2%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.memset_orig
      0.19 ±  3%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.16 ±  5%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.30            -0.1        0.24        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.11 ±  8%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.evlist__parse_sample
      0.11 ±  6%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.41 ±  2%      -0.0        0.38 ±  2%  perf-profile.self.cycles-pp.__memcpy
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.22 ±  2%      -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.09            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.finish_task_switch
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.select_idle_sibling
      0.12 ±  4%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.06 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.lapic_next_deadline
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.find_idlest_cpu
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.os_xsave
      0.07 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp._find_next_bit
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.folio_add_anon_rmap_ptes
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__vmalloc_area_node
      0.06 ±  9%      +0.0        0.07        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.12 ±  3%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.dequeue_entity
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.pick_eevdf
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__rb_erase_color
      0.11 ±  3%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.08            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.07 ±  5%      +0.0        0.09        perf-profile.self.cycles-pp.update_min_vruntime
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.update_rq_clock
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.rb_erase
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      0.16 ±  2%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.21 ±  3%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.04 ± 44%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.06 ±  6%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.avg_vruntime
      0.16 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.06 ±  8%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.perf_event_task_output
      0.10 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.dup_mmap
      0.02 ± 99%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.10 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.06 ±  7%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.rb_insert_color
      0.09 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.06 ±  6%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__dequeue_entity
      0.09 ±  4%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.mas_walk
      0.07 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.05 ±  7%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.16 ±  3%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.copy_thread
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.exit_notify
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.find_idlest_group
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.fput
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.zap_other_threads
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.pids_can_fork
      0.09            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__free_one_page
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.queued_read_lock_slowpath
      0.15 ±  8%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.____machine__findnew_thread
      0.06 ±  6%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__enqueue_entity
      0.13 ±  2%      +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.05 ±  8%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.mas_next_slot
      0.06 ±  9%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.find_unlink_vmap_area
      0.05            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.cpu_util
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.idr_get_free
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.pids_release
      0.09            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.__clone
      0.07 ±  6%      +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.free_vmap_area_noflush
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.perf_event_mmap_output
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.refill_obj_stock
      0.05 ±  7%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.copy_present_pte
      0.17 ±  2%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.10 ±  4%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.copy_process
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__free_pages
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.vunmap_p4d_range
      0.10 ±  3%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.17 ±  2%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.refcount_dec_not_one
      0.07            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.put_pid
      0.01 ±223%      +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.reweight_entity
      0.20 ±  4%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.14 ±  3%      +0.1        0.22        perf-profile.self.cycles-pp.__update_load_avg_se
      0.32 ±  3%      +0.1        0.41        perf-profile.self.cycles-pp.update_load_avg
      0.07            +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.insert_vmap_area
      0.21 ±  5%      +0.1        0.30 ±  7%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.find_vm_area
      0.07 ±  9%      +0.1        0.17 ±  7%  perf-profile.self.cycles-pp.filemap_map_pages
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.29            +0.1        0.39        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.15 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.alloc_vmap_area
      0.22 ±  2%      +0.1        0.35 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.08 ±  5%      +0.1        0.22        perf-profile.self.cycles-pp._raw_write_lock_irq
      0.15 ±  3%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.21 ±  4%      +0.2        0.37 ±  3%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.32            +0.2        0.51        perf-profile.self.cycles-pp.__slab_free
      0.14 ±  4%      +0.2        0.34 ±  4%  perf-profile.self.cycles-pp.up_write
      0.31            +0.2        0.53        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.67            +0.2        0.92        perf-profile.self.cycles-pp._raw_spin_lock
      0.54 ±  2%      +0.3        0.84        perf-profile.self.cycles-pp.mm_update_next_owner
      0.20 ±  4%      +0.4        0.58 ±  2%  perf-profile.self.cycles-pp.zap_pte_range
      0.64            +0.5        1.14        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.78 ±  2%      +0.7        1.49        perf-profile.self.cycles-pp.queued_write_lock_slowpath
      8.65 ±  2%     +55.9       64.59        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.09 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      0.01 ± 90%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.copy_p4d_range
      0.01 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.copy_p4d_range
      0.01 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__do_huge_pmd_anonymous_page
      0.01 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__pte_alloc
      0.05 ±  9%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      0.05 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.05 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.01 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.04 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.09 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds.copy_creds
      0.01 ±  9%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc.security_task_alloc.copy_process.kernel_clone
      0.04 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.03 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab.___slab_alloc
      0.02 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.06 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__split_huge_pmd.do_huge_pmd_wp_page.__handle_mm_fault.handle_mm_fault
      0.03 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.01 ± 32%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.01 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.change_pmd_range.isra.0.change_protection_range
      0.01 ±  7%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.01 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.01 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.07 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.delayed_vfree_work.process_one_work.worker_thread.kthread
      0.47 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      0.12 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      0.47 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.01 ± 41%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.01 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.01 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.01 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.02 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.01 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.01 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.02 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.05 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.01 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_sem.do_exit.do_group_exit.get_signal
      0.06          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      0.02 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.get_signal
      0.03 ± 96%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.15 ± 21%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      0.04 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.04 ±131%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.__khugepaged_enter.dup_mmap.dup_mm
      0.01 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.01 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      0.10 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      0.07 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      0.08 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      0.09 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      0.07 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      0.01 ± 83%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.02 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_dup_build.constprop.0
      0.13 ± 13%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      0.03 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.taskstats_exit.do_exit.do_group_exit
      0.00 ± 32%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.01 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.02 ± 71%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_dup_alloc.isra.0
      0.03 ± 66%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
      0.04 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.19 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      0.24 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.11 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
      0.44 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.uprobe_clear_state.__mmput.exit_mm
      0.03 ±  9%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      0.06 ±102%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.alloc_bprm
      0.05 ±  6%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.13 ±106%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      0.06 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      0.02 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.22 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.03 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      0.10 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.get_signal
      0.07 ±  6%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.06 ± 77%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      0.40 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.02 ± 32%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.05 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      0.05 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.vunmap_p4d_range.__vunmap_range_noflush.remove_vm_area.vfree
      0.03 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.31 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
      0.08 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.03 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched_lock.__purge_vmap_area_lazy.drain_vmap_area_work.process_one_work.worker_thread
      0.46 ± 71%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.27 ±118%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04          -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.37 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.23          -100.0%       0.00        perf-sched.sch_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.12 ± 76%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.02 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.02 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.05 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.05 ±  4%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.08 ± 61%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.04 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.12 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.05 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.14 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.23 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.29 ± 66%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.07 ± 94%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.24 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.04 ± 32%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.08 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.04 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06          -100.0%       0.00        perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown]
      0.15 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown].[unknown]
      0.36 ±120%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.05 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.07 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.75 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      1.85 ± 33%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.copy_p4d_range
      0.91 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.copy_p4d_range
      3.25 ± 24%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__do_huge_pmd_anonymous_page
      7.24 ±113%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__pte_alloc
      1.26 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      0.49 ±174%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_anonymous_page
      4.25 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      1.56 ± 66%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      2.32 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.10 ± 81%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      1.67 ± 48%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds.copy_creds
      3.22 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc.security_task_alloc.copy_process.kernel_clone
      4.31 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      1.77 ± 40%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab.___slab_alloc
      4.47 ± 16%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      2.55 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__split_huge_pmd.do_huge_pmd_wp_page.__handle_mm_fault.handle_mm_fault
      0.16 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__split_huge_pmd.vma_adjust_trans_huge.__split_vma.vma_modify
      5.46 ± 80%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      0.66 ±158%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.50 ±130%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      2.52 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      1.63 ± 58%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.change_pmd_range.isra.0.change_protection_range
     11.85 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      2.04 ± 55%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      8.48 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.13 ± 47%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.delayed_vfree_work.process_one_work.worker_thread.kthread
      3.05 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      4.70 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      3.83 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      1.34 ±121%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      2.77 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      2.62 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      7.03 ±113%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      3.07 ± 15%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      4.12 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      1.72 ± 53%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      3.30 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      3.68 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.22 ±147%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.34 ±127%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.64 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      1.90 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_sem.do_exit.do_group_exit.get_signal
      7.85 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      4.80 ± 81%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.get_signal
      0.06 ± 85%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      2.18 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      5.38 ± 93%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.68 ±176%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.81 ±151%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__khugepaged_enter.dup_mmap.dup_mm
      2.49 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      6.01 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      3.16 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      1.52 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      3.22 ± 52%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      1.45 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      2.42 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      1.14 ±216%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      1.32 ± 96%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.75 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_dup_build.constprop.0
     17.64 ± 63%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      0.06 ± 24%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.taskstats_exit.do_exit.do_group_exit
      2.80 ± 12%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      1.26 ±137%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
      6.31 ± 74%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.01 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.mmap_region
      0.34 ± 85%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_dup_alloc.isra.0
      1.30 ± 77%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
      1.73 ± 14%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      6.97 ± 69%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      5.26 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      2.14 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
      1.87 ± 54%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.uprobe_clear_state.__mmput.exit_mm
      3.48 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      0.12 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.alloc_bprm
      2.43 ± 52%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.34 ±122%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      3.80 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      1.68 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.22 ±  7%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.90 ±110%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      2.62 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.get_signal
      5.31 ± 23%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      2.43 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      3.95 ± 10%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      2.88 ± 50%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.21 ± 32%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      0.50 ± 50%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.vunmap_p4d_range.__vunmap_range_noflush.remove_vm_area.vfree
      9.31 ±142%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.61 ±  3%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
      6.96 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.07 ± 42%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched_lock.__purge_vmap_area_lazy.drain_vmap_area_work.process_one_work.worker_thread
      1.87 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.58 ±129%    -100.0%       0.00        perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     18.64 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      3.73 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     11.36 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     35.21 ± 28%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     12.90 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      1.57 ± 47%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.08 ±101%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      4.50 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     10.00 ± 23%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     11.60 ± 79%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1.59 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.88 ± 56%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      2.41 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.70 ± 48%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      3.61 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.20 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2.73 ± 83%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.01 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      3.25 ±  7%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.25 ± 40%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.67 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     11.59 ± 24%    -100.0%       0.00        perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     20.93 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.65 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown]
      5.89 ± 10%    -100.0%       0.00        perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown].[unknown]
      1.03 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      1.05 ± 55%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      5.79 ±  9%    -100.0%       0.00        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.05          -100.0%       0.00        perf-sched.total_sch_delay.average.ms
     35.48 ± 28%    -100.0%       0.00        perf-sched.total_sch_delay.max.ms
      0.76          -100.0%       0.00        perf-sched.total_wait_and_delay.average.ms
   5206778          -100.0%       0.00        perf-sched.total_wait_and_delay.count.ms
      2050          -100.0%       0.00        perf-sched.total_wait_and_delay.max.ms
      0.71          -100.0%       0.00        perf-sched.total_wait_time.average.ms
      2050          -100.0%       0.00        perf-sched.total_wait_time.max.ms
      7.06 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
    735.86 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      9.77 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds.copy_creds
      2.18 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab.___slab_alloc
      1.04 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
     10.46 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.07 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      7.22 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.delayed_vfree_work.process_one_work.worker_thread.kthread
      3.98 ±154%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      1.12 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      1.72 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      1.41 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      3.09 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.__khugepaged_enter.dup_mmap.dup_mm
      8.81 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      8.14 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      7.55 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      8.72 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      7.44 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      2.10 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_dup_build.constprop.0
     12.13 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      3.88 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_dup_alloc.isra.0
      3.22 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      3.00 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      5.72 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      2.77 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      7.25 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.26 ±150%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      2.08 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      7.21 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      7.49 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.vunmap_p4d_range.__vunmap_range_noflush.remove_vm_area.vfree
     15.80 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
      8.81 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched_lock.__purge_vmap_area_lazy.drain_vmap_area_work.process_one_work.worker_thread
    433.86 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.13 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.50          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.33 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     13.33          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.58          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
    297.44 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.94 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1.27 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      2.22 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1.52 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.65 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    289.37 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    364.54 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    346.45 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.44 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    453.63          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.83          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     21.81 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.11          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.04 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      9.63          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    166.67 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      5.17 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
    118.00 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds.copy_creds
    152.83 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab.___slab_alloc
      1086 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
    376.50 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    214766          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      4.33 ± 54%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.delayed_vfree_work.process_one_work.worker_thread.kthread
     52.83 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
     89.00 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
     16120          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
    817.17 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
     39.50 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.__khugepaged_enter.dup_mmap.dup_mm
    216.17 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
     76.17 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
    128.83 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
     36.83 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
    239.83 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
     73.33 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.mas_dup_build.constprop.0
      1002 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
     28.33 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_bulk.mas_dup_alloc.isra.0
    205.33 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
    863.00 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
    461.83 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      2.67 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      4971 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     68.33 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
    541.50 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
     38.33 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.vfree.part.0.delayed_vfree_work
    209.00 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.vunmap_p4d_range.__vunmap_range_noflush.remove_vm_area.vfree
      1.17 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
      5.33 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched_lock.__purge_vmap_area_lazy.drain_vmap_area_work.process_one_work.worker_thread
      5.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.17 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
   4138799          -100.0%       0.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     57104          -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    225028          -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     17407          -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    259471          -100.0%       0.00        perf-sched.wait_and_delay.count.futex_wait_queue.__futex_wait.futex_wait.do_futex
     14.00 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     11533          -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     10569          -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     41.17 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     91.50 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     79.33 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    201.50 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     31.67 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     13.17 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     90.67          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     20.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1321          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     26065          -100.0%       0.00        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     66289          -100.0%       0.00        perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.50 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.count.syslog_print.do_syslog.kmsg_read.vfs_read
     33317          -100.0%       0.00        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     27.85 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      1001          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
     29.19 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds.copy_creds
     28.70 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab.___slab_alloc
     29.93 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      1001          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     11.90 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     15.02 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.delayed_vfree_work.process_one_work.worker_thread.kthread
    172.02 ±215%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      7.72 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
    183.45 ±199%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
     31.22 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
     22.31 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.__khugepaged_enter.dup_mmap.dup_mm
     32.15 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
     28.70 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
     28.92 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
     25.83 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
     29.03 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
     22.00 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_dup_build.constprop.0
     38.20 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
     24.24 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_dup_alloc.isra.0
     27.18 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
     30.28 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
     31.32 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      4.45 ± 34%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
    124.49 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    173.82 ±212%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
     29.78 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
     38.10 ± 57%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.vfree.part.0.delayed_vfree_work
     55.40 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.vunmap_p4d_range.__vunmap_range_noflush.remove_vm_area.vfree
     16.21 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
     19.92 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched_lock.__purge_vmap_area_lazy.drain_vmap_area_work.process_one_work.worker_thread
      1002          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.49 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    677.79 ± 67%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1006          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     15.03 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
    850.93 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     26.12 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
    932.65 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      1005          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1002          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     14.69 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     14.21 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     22.71 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      1031          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1007          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    515.32 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     19.61 ± 86%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    505.03          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     14.82 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1361 ± 34%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1004          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.75 ± 65%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      2047          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.97 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      0.05 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.__handle_mm_fault
      0.47 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.copy_p4d_range
      0.05 ±126%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.__handle_mm_fault
      0.69 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.copy_p4d_range
      0.31 ±178%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.get_zeroed_page.__p4d_alloc
      0.12 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__do_huge_pmd_anonymous_page
      0.29 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__pte_alloc
      0.04 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.copy_huge_pmd
      0.02 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      0.09 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
      1.29 ±198%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_anonymous_page
      0.03 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      0.67 ±189%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.allocate_slab.___slab_alloc.kmem_cache_alloc
      0.78 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.14 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault
    735.82 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.07 ± 51%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.04 ± 81%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      0.04 ± 72%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary.search_binary_handler
      9.68 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds.copy_creds
      0.55 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc.security_task_alloc.copy_process.kernel_clone
      0.85 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      2.15 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab.___slab_alloc
      0.05 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.03 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__split_huge_pmd.do_huge_pmd_wp_page.__handle_mm_fault.handle_mm_fault
      0.13 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__split_huge_pmd.vma_adjust_trans_huge.__split_vma.vma_modify
      1.00 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
     10.46 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.13 ±114%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.67 ±102%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.14 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.14 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.isra.0.change_protection_range
      0.06 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.50 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.43 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.03 ± 56%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      7.16 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.delayed_vfree_work.process_one_work.worker_thread.kthread
      3.51 ±177%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      0.43 ±103%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      0.65 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.05 ±163%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.09 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.15 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.vma_modify.mprotect_fixup
      0.42 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.43 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.82 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.44 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.03 ± 93%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.exit_mmap.__mmput.exit_mm
      0.16 ± 96%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.14 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.09 ± 65%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.19 ±166%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.78 ± 42%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      0.15 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.51 ± 84%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.dup_mmap.dup_mm.constprop
      0.07 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.04 ± 62%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.13 ± 23%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.03 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
     19.32 ±213%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      7.32 ±221%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
     50.36 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.02 ± 88%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
     11.14 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.02 ±110%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.22 ±106%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.04 ± 57%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_sem.do_exit.do_group_exit.__x64_sys_exit_group
      0.05 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_sem.do_exit.do_group_exit.get_signal
      1.66 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      0.06          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.get_signal
      0.07 ± 73%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      0.08 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.08 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      1.87 ±197%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.37 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.03 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmalloc_trace.copy_semundo.copy_process.kernel_clone
      0.03 ± 70%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmalloc_trace.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.13 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.03 ± 83%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault.__handle_mm_fault
      3.05 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.__khugepaged_enter.dup_mmap.dup_mm
      0.02 ± 96%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.23 ± 23%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
      0.43 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      8.72 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
      8.07 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      7.48 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
      8.63 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
      7.37 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
     16.70 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.13 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      0.12 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.04 ±109%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_link
      2.08 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_dup_build.constprop.0
     11.99 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      0.02 ± 90%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      0.17 ±120%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.taskstats_exit.do_exit.do_group_exit
      0.02 ± 68%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm.do_execveat_common
      0.16 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.01 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.13 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
      0.53 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      0.12 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.mmap_region
      3.85 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_dup_alloc.isra.0
      1.01 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
      3.18 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.05 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.27          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      0.08 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.02 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
      0.58 ± 30%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.03 ± 46%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      0.24 ±164%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      0.19 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
      7.22 ±205%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.56 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.uprobe_clear_state.__mmput.exit_mm
      2.97 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
      5.67 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.05 ± 97%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.05 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.get_signal
      2.64 ± 23%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      0.14 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      1.11 ±207%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.10 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      7.24 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.23 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      0.17 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.get_signal
      0.21 ± 64%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.03 ± 51%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.shift_arg_pages.setup_arg_pages
      0.10 ± 58%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      2.86 ±173%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.03 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.05 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      7.16 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      4.84 ±220%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.44 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vunmap_p4d_range.__vunmap_range_noflush.remove_vm_area.vfree
      0.05 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.33 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      8.78 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched_lock.__purge_vmap_area_lazy.drain_vmap_area_work.process_one_work.worker_thread
    433.40 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.86 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.46          -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.33 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     12.96          -100.0%       0.00        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.35          -100.0%       0.00        perf-sched.wait_time.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      0.52 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    297.42 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.69 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      2.89 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1.22 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      2.14 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.78 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      1.40 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.61 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    289.22 ± 14%    -100.0%       0.00        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    364.30 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    346.16 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3.59 ±221%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc
      1.15 ±128%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.92 ±141%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      1.92 ±137%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      0.09 ± 88%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.17 ±118%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      1.20 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    453.59          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.75          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     21.77 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.06          -100.0%       0.00        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown]
      0.00 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown].[unknown]
      1.68 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     17.41 ±110%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      9.55          -100.0%       0.00        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     27.71 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__get_free_pages.pgd_alloc
      0.21 ±120%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.__handle_mm_fault
     22.91 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pmd_alloc.copy_p4d_range
      0.15 ±160%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.__handle_mm_fault
     21.03 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.__pud_alloc.copy_p4d_range
      3.52 ±191%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.get_zeroed_page.__p4d_alloc
      5.35 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__do_huge_pmd_anonymous_page
     27.91 ± 28%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.__pte_alloc
      0.29 ±111%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.copy_huge_pmd
      0.71 ± 53%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.pte_alloc_one.do_read_fault
      5.09 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
    176.34 ±219%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_anonymous_page
     17.12 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.wp_page_copy
      3.53 ±184%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.allocate_slab.___slab_alloc.kmem_cache_alloc
     19.23 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      5.51 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      1001          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.54 ± 61%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.10 ±132%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      0.10 ± 91%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary.search_binary_handler
     29.16 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds.copy_creds
     29.90 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc.security_task_alloc.copy_process.kernel_clone
     29.42 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
     28.54 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab.___slab_alloc
      4.52 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.55 ± 19%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__split_huge_pmd.do_huge_pmd_wp_page.__handle_mm_fault.handle_mm_fault
      2.12 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__split_huge_pmd.vma_adjust_trans_huge.__split_vma.vma_modify
     29.56 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
      1001          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.99 ±105%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     12.01 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
     21.04 ± 39%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      4.74 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.change_pmd_range.isra.0.change_protection_range
      9.09 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     24.46 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    189.80 ±191%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.30 ± 99%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
     14.90 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.delayed_vfree_work.process_one_work.worker_thread.kthread
    169.46 ±219%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
    172.21 ±215%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      3.89 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.10 ±175%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      1.77 ± 59%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      3.34 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.vma_modify.mprotect_fixup
     25.05 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
     25.77 ± 12%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
     31.32 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     27.60 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      0.22 ±127%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.exit_mmap.__mmput.exit_mm
    336.22 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      6.03 ± 73%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      1.13 ±108%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
    169.43 ±219%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
    833.94 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
      3.06 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
     13.12 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.dup_mmap.dup_mm.constprop
      0.40 ± 62%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.13 ± 72%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      3.15 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.05 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.09 ± 89%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
    172.74 ±214%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
    167.66 ±222%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.exit_fs.do_exit
    500.10 ± 99%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.03 ±106%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
    166.75 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.05 ±167%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
    171.26 ±216%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      1.12 ±103%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_sem.do_exit.do_group_exit.__x64_sys_exit_group
      2.54 ± 43%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_sem.do_exit.do_group_exit.get_signal
    181.75 ±201%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      9.00 ± 55%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.get_signal
      0.39 ± 80%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      5.64 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.12 ± 39%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    168.64 ±220%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     28.02 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmalloc_node_trace.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
      0.22 ± 87%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmalloc_trace.copy_semundo.copy_process.kernel_clone
      0.18 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmalloc_trace.perf_event_mmap_event.perf_event_mmap.mmap_region
      4.11 ± 28%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.05 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault.__handle_mm_fault
     22.12 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.__khugepaged_enter.dup_mmap.dup_mm
      0.10 ±150%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
     21.48 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process.kernel_clone
     30.57 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
     31.03 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process.kernel_clone
     28.67 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
     28.49 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.copy_signal.copy_process.kernel_clone
     24.96 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.dup_fd.copy_process.kernel_clone
     28.38 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
    166.84 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      3.90 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
      3.58 ± 26%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.07 ±116%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_link
     21.70 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_dup_build.constprop.0
     35.39 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds.copy_process
      0.08 ±146%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      1.17 ±194%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.taskstats_exit.do_exit.do_group_exit
      0.04 ± 67%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm.do_execveat_common
      5.86 ± 15%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      0.03 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      4.13 ± 21%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.vma_modify
     28.87 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      1.95 ± 53%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.mmap_region
     24.16 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_dup_alloc.isra.0
     21.19 ± 12%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range
     27.12 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.11 ± 95%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      9.68 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      1.38 ± 81%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.04 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
    505.70 ± 97%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.13 ± 59%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap.dup_mm
      2.10 ±207%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      2.31 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
    170.76 ±217%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      1.92 ± 52%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.uprobe_clear_state.__mmput.exit_mm
     29.82 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
     31.15 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.dup_mm
      0.37 ±118%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.66 ± 62%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.get_signal
      4.11 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.rcu_gp_cleanup.rcu_gp_kthread.kthread.ret_from_fork
      3.85 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
    169.56 ±220%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      6.96 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    124.46 ± 26%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.92 ± 73%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      6.51 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      2.67 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.get_signal
    337.60 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.09 ±116%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.shift_arg_pages.setup_arg_pages
      2.47 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
    171.07 ±216%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.15 ± 82%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     29.30 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
     38.02 ± 57%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfree.part.0.delayed_vfree_work
    167.80 ±222%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     55.21 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vunmap_p4d_range.__vunmap_range_noflush.remove_vm_area.vfree
     20.75 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
    834.88 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     19.88 ± 40%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched_lock.__purge_vmap_area_lazy.drain_vmap_area_work.process_one_work.worker_thread
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.03 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    676.69 ± 67%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1003          -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      9.16 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
    844.38 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     25.74 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      9.07 ± 55%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    932.62 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     17.64 ± 22%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    192.78 ±187%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      1005          -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1002          -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     14.52 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     19.47 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     13.78 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     22.68 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      1031          -100.0%       0.00        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1003          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    514.51 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3.77 ±221%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc
      9.99 ± 99%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      6.14 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      7.60 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      1.05 ± 94%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.50 ±117%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
     17.71 ± 95%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    504.92          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     11.15 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1361 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1003          -100.0%       0.00        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.71 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown]
      1.87 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown].[unknown]
      4.10 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
    500.84 ± 99%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2047          -100.0%       0.00        perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm



***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/8T/lkp-spr-2sp4/anon-w-seq-mt/vm-scalability

commit: 
  4dca82d141 ("uprobes: use pagesize-aligned virtual address when replacing pages")
  c4608d1bf7 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")

4dca82d14174fe53 c4608d1bf7c6536d1a3d233eb21 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    797785            +3.6%     826885        vm-scalability.median
 1.784e+08            +3.9%  1.853e+08        vm-scalability.throughput
      0.26 ± 29%     -64.4%       0.09 ±122%  sched_debug.cpu.nr_uninterruptible.avg
     14532          -100.0%       0.00        proc-vmstat.thp_deferred_split_page
     14532          -100.0%       0.00        proc-vmstat.thp_split_pmd
     12660 ± 22%     +68.9%      21383 ± 15%  turbostat.C1
     28034 ± 20%     +55.6%      43619 ± 13%  turbostat.POLL
      1.06            -1.4%       1.05        perf-stat.i.cpi
    452.24            +4.9%     474.30        perf-stat.i.cpu-migrations
      0.94            +1.2%       0.96        perf-stat.i.ipc
    445.54 ±  2%      +4.5%     465.66        perf-stat.ps.cpu-migrations
      1.54 ± 13%     +27.7%       1.97 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
    105.60 ±  7%     +34.2%     141.75 ± 15%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
    123.19 ±  4%     -18.5%     100.41 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
     27.39 ±  9%     -57.1%      11.76 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      1.50 ± 10%     +29.5%       1.94 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
    105.50 ±  7%     +34.2%     141.56 ± 15%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exit_mm
     18.00 ± 67%     -79.6%       3.67 ± 71%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    123.18 ±  4%     -18.5%     100.40 ± 18%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
     27.19 ±  9%     -57.7%      11.50 ±  9%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
     58.18 ± 35%     +65.2%      96.08 ± 28%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]



***************************************************************************************************
lkp-hsw-d05: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory
=========================================================================================
compiler/cpufreq_governor/freq/kconfig/nr_task/rootfs/samples/tbox_group/test/testcase:
  gcc-12/performance/10000/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/100000ss/lkp-hsw-d05/add/ftq

commit: 
  4dca82d141 ("uprobes: use pagesize-aligned virtual address when replacing pages")
  c4608d1bf7 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")

4dca82d14174fe53 c4608d1bf7c6536d1a3d233eb21 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    477.00           +24.7%     595.00        ftq.mean
     30623           -53.3%      14308        ftq.time.maximum_resident_set_size





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


