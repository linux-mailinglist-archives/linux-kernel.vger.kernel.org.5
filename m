Return-Path: <linux-kernel+bounces-120553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24F288D945
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BFE297613
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2733993;
	Wed, 27 Mar 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnvBIlgm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F92E85A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528784; cv=fail; b=dv09dZLSeawEwQJa9wAtxPcZEFqNnCSiDuQDWuuVlPEzcr6FHAkXZO84dfCz3csDhd8FIRkTFYd8IhZk3ICPcvSIZAI7dWgTCsR8JK4UAdxGBoOqikyB5cQ09RPtT434AccIfi5fN9i2gPdkYtbMlrC2siRvZ5XLR7nNgywM1ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528784; c=relaxed/simple;
	bh=4mrZfGXLXDaPLbdkAUf6MYXhE/NOIxGZh2BYGNprDSQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YF95pgLZUn8erY11fRQ5kPOQ66tCcvt/xVKe/7mKFpIYG8ZuWM0bpWm5vFMocWD+99nqj4+P//imM4c9/UqMi1oDJHMP9xVqg22gfYUEC7tSxgK1lxmjB55nRTkseHQYWBTRx1DH7n4QEWvb2fzaoCLB+mzL+VVNIoeIgFUF4Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnvBIlgm; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711528778; x=1743064778;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=4mrZfGXLXDaPLbdkAUf6MYXhE/NOIxGZh2BYGNprDSQ=;
  b=QnvBIlgmkSIa8f3x3jBEPjYtfWWoQZyEDZdLqKtGgKVhid/Vik3K2V/2
   I761I0MF+w+YQ0cVEUqSh5HPFvllEqS9qGqbF2e4Lp/EOwqOnmye/K1t1
   QB+M+Cd9LBQfQRXu1PyaPM8h6Y5Sp99VC2nXQ8vnOUTYD0H8UW/ekVn8M
   DaIY2amzoawYedgJfg2HSoE40mB96BMdgjsJFjApQhpSQjMbmuJ3p0K5z
   Rec3lQPPUQmQxt75IdD8jl5WzkptY6CmEamZWezWfpA3ZxhghUg1hUpvG
   VsKx/WzDuGFDb8m+BPXXEdlXlUnSkQjV+r5O5dm8D1Nblq+tblA68DT+8
   Q==;
X-CSE-ConnectionGUID: Rb4s02meTGiuOm2Tju4KGA==
X-CSE-MsgGUID: bd7+87iETSiEo7iY2IoRIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10395910"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="10395910"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 01:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16321084"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 01:39:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 01:39:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 01:39:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 01:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2P8as3Pq4Tukjw/lCjb9Q3rvkJddppfmCSkcS9lFqk0dcE2UMrcV/E2CpvcAuSVKN599sSiVX5Tc2T51IUUSnANvjTjtZ13HVmVCQekZKzEgdWLOWwBe81uUJ5j2eHbUBEiKcn3Z/1SE6jP1tnVO54NCQwU1u4C1HAGU4eWmPTvd0BrzxvwEJDRFncox6/IRbochbpxhRC0ZDMgPOnlkEmQs1H45NAHb/VxowklWw0ziJE33YkYkAQ4cROvSb/wr/puZPBNKMZbcpz6IzadwsuLCzRcym7TrU0pG5p+fPjkzsLkvowlAhEWURjO1BReVx0MaTFYEN2w350DeNPBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWM7R5PNhM0ngK6oG95A6sKUk3mnpRtedcv6NTJpV0A=;
 b=U9aSHhXc+5FHGlIofnqn4FjLmSvgVNLABH9NTuACw3u+n2siGTZaB9gY1XLbrtQbocRPg7OnEBm9oD1IkZSVGOF2Yn8jI7fyZs5AUXh2Rv+ZwKJRNoP6IgkYftrRhFbycOsHJZj8JfHwnD21dLXGOA7Ssv0/06tOzWuSk3U1GGLwMFRdOk+W+9ORdc0Q0c4kMkW5CDfUJTZK8RV5G3+vNxgscsfbTYAX/CnLCeRoyjbBc348W4Apggph2YYIkHuvftdFKHmHv12TkhJr0yIpeI/DdDlX/70dJ4VS4MEegOJ4knzaAewFuhbGjkzYhYFgXnL9XRHNY4cFWI+ItDmXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 08:39:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 08:39:26 +0000
Date: Wed, 27 Mar 2024 16:39:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [timers]  7ee9887703:  stress-ng.uprobe.ops_per_sec
 -17.1% regression
Message-ID: <202403271623.f0b40181-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 504eee81-0b50-46dc-0052-08dc4e39688e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSbR8lY3iXC6gBq6+rcIiGpYpCHPQkwfGmRILpw6BEDUsSQ9uAwI1gAvCUR7AYVB3iQC/tHV6JwF+H8sgvMnPkriCcv6oPTFlstP7wGSw0iWDAbWMA08sfGprrgBzj+ASIprNn4kdc0tg3MIFAYZ8L/hOfHNSBs2uo6+SDnF9r36Q7lB/flfe5KLxvFefJDTiBDOghk3KbFCW49FsQj3ZsxA3/8bbTs+ALr/EkK+NH9m1f0w13gVgxTAuBtVNDaaWlnPRODQA7PzURRJXrX7riWfLwM9ShcjHiV7FyduEyMjOF+OGIwiSo4d5bEPN+ll5loJnEFFKRQpVVMHE1H6tSljK5JjGy18871Lw7iXHF35Q2CRw+pd3drZOYUfsWmNUnmz6S9nwlSG5oT5Os1azPyUNFHDmS2INfNB1X61g78cUZJ5l2gjJvp5i6nEbNuyxNcyfv/XaRG2S5XW1hqN2yYo5mXdpVyfPkiKfjGU5JmaTXB35eyZ0sZtnUKBN6OL/IuUM+7d1HMrVnOWXbuUaBhS9F5w5z1uJ4KwixSF/rI+PUdpRRMCtIfI63xErfFVAlc2NM95A52gCMzY+d9fLKMAHPImHjGsODAkzvsdckSsV8ZrpSG+27AgV3KcGbn0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Rkmx82rX5ypABpB7b1ipwZu+QRGVio6qXCPqoJnUT6ZtCOYPH9I1Bebvar?=
 =?iso-8859-1?Q?JOwBTlxvrZj3sLHuKOVp+ZozPRpxaT8apEdxwwaG8ID+CyBbQ4yHIpCrEr?=
 =?iso-8859-1?Q?y92JKEOsu/E+ElKOI4rEQkH9PEXzRNCwRpRJo4oSPnmhqbW/HdB46XU7mo?=
 =?iso-8859-1?Q?XlQYywCIzhkMqWW0ILWisARR3LkdN4SBk+lcBzMQjYrAB1GxztQayYvT8t?=
 =?iso-8859-1?Q?e1rY3NqrpTyD3/+2xowqs8d6jc1wUTCYtMZr6SDOCqqCjLszzMgwM/g/IL?=
 =?iso-8859-1?Q?5U69Mjcp3C6/jCuW+EIuPCmIpVRqDLtV/lPEG2aASZMSWjc/1hG88TM6Rl?=
 =?iso-8859-1?Q?V8b6CEq2wHSqw0xtVJm07KitZmw/ZLGcmSi/LcxePRL2+0KbIjwGnnJ3uF?=
 =?iso-8859-1?Q?IBjxWZNb+UwrnewMmtkGavHx72pZAv3LilZTWoxptbNJ24AR6OdIf6ZFfd?=
 =?iso-8859-1?Q?1pJU5KJiXBgSBaKAZhtGaht0jB8eqZ/++LreELfvCL732tvUwq2r5HQAqz?=
 =?iso-8859-1?Q?oyTiAZEhhIk/JrO76DHFMEot1NmjjVF/ZoloTVRUzBFdQUUxv8P0LIK/A4?=
 =?iso-8859-1?Q?2sLJAGauR7wNHseUmIfKhyUPUfNBUDPv/kSoAeJO9p4wRrSIGwBjflYhCr?=
 =?iso-8859-1?Q?Gv1wdzfFSKRoWMUAkm48RWiz8EiQ0oKu0kJNrJkzGGlrDL4LkAR8B+rSsY?=
 =?iso-8859-1?Q?nFbhMBH5yWIXI8R/6eqw5obv4joZNCtbxYMkkzfyHL6bzWfbOZ4FDxEaxr?=
 =?iso-8859-1?Q?m3YewErTZo1UZZw3uVp7woFvaLHjWzAaspzJK+zIR/QghT5S+0KPmtnAt1?=
 =?iso-8859-1?Q?MJD4a5G5+gfdH3CwJtlqjEYp/Zwk/BQhPzb28LZIBRLujNLV0w3qF55K8c?=
 =?iso-8859-1?Q?P1tydukOn1tqWyoeKNlB2WCH4AwIQ4ugNBRMFEHJvY6erGkEUV3o8Bgmf1?=
 =?iso-8859-1?Q?Scmugj5qHC5P/ajFzdJOf2kSelyAY/Q3vHQvrA1zDqoa4myCo5aaxqdQW+?=
 =?iso-8859-1?Q?URuGhbCMQq+a18SUCB3P4QfoiCZnyXzd3mNdUtW9sEW1f/bBDhvx0ryfCT?=
 =?iso-8859-1?Q?TLU+nhPaBCzfTORTDt7m5YbRv1K8LsKCWRbolN54VgxHcG5F2vvd6c+FPF?=
 =?iso-8859-1?Q?p8sTDO+gziylADiIyv+6K7sqhi/pdzznoYeHwDGuEOBx4jeB310EZpTCAS?=
 =?iso-8859-1?Q?s6TEBQtDOM+OIRlVqin2oGMU2MUEUFj1f1MvaPZzCMDmyUzYyZq69rurEA?=
 =?iso-8859-1?Q?8ItpYxT9bxX+K9AMc7xXerXN9P82aL1UWSBD0lpNq+o29gNQ/aQeEdPuvg?=
 =?iso-8859-1?Q?h17kZZtA5TFRenNsdfNIPctBFsl8zBy1FfMKdFF+wjORv3t9cmUHadnotv?=
 =?iso-8859-1?Q?wLrzxf8ydbXJbUHZX7XNv4eu6zo5ri6kyLn81H2KnZySHMrGovHA1nHCbL?=
 =?iso-8859-1?Q?8L+MAzKDKRgxzCWp3NQkrRsq6x2OHsduv2TWJMq4albRPJMD/kvOhCctlM?=
 =?iso-8859-1?Q?EphEqr510DBDh4FlzEfqt1MINUAatJfApVXAHyd1teywZ7NzYUfWYZVDM0?=
 =?iso-8859-1?Q?cXy7mUKtQ4L+p6D88RMQi9fXp+JNvXfVF4mxmto6pY6+PPZWZQGhBengxm?=
 =?iso-8859-1?Q?+j8InwS+xAtPrBEe5oCoDBZJANCkaMnNuz7FsisvlTRGeJj6w6FSPkKg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 504eee81-0b50-46dc-0052-08dc4e39688e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 08:39:26.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +deI9pwYHosSJhVqpDDVZyVis90fBMSGBraQsnpqosl9mT8JlEUj/SdV8sDBBqfD0HS5FyzOIe+sT2v+ITIQjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com



Hello,


we reported
"[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.2% regression"
in
https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/

now we noticed this commit is in mainline and we captured further results.

still include netperf results for complete. below details FYI.


kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops_per_sec on:


commit: 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the hierarchical pull model")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on fix commit f55acb1e44f3d4bf1ca7926d777895a67d4ec606]


testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: uprobe
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput -1.3% regression                                                |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | nr_task=1                                                                                       |
|                  | runtime=300s                                                                                    |
|                  | test=grep                                                                                       |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | sysbench-fileio: sysbench-fileio.write_operations/s 2.9% improvement                            |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory  |
| test parameters  | cpufreq_governor=performance                                                                    |
|                  | disk=1HDD                                                                                       |
|                  | filenum=1024f                                                                                   |
|                  | fs=btrfs                                                                                        |
|                  | iomode=sync                                                                                     |
|                  | nr_threads=100%                                                                                 |
|                  | period=600s                                                                                     |
|                  | rwmode=seqrewr                                                                                  |
|                  | size=64G                                                                                        |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps -2.0% regression                                               |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory      |
| test parameters  | cluster=cs-localhost                                                                            |
|                  | cpufreq_governor=performance                                                                    |
|                  | ip=ipv4                                                                                         |
|                  | nr_threads=50%                                                                                  |
|                  | runtime=300s                                                                                    |
|                  | test=SCTP_STREAM                                                                                |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps -1.2% regression                                               |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory      |
| test parameters  | cluster=cs-localhost                                                                            |
|                  | cpufreq_governor=performance                                                                    |
|                  | ip=ipv4                                                                                         |
|                  | nr_threads=200%                                                                                 |
|                  | runtime=300s                                                                                    |
|                  | test=SCTP_STREAM                                                                                |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403271623.f0b40181-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240327/202403271623.f0b40181-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/uprobe/stress-ng/60s

commit: 
  57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
  7ee9887703 ("timers: Implement the hierarchical pull model")

57e95a5c4117dc6a 7ee988770326fca440472200c3e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   9973416           -14.6%    8512345        cpuidle..usage
    616631 ± 13%     -23.4%     472590 ± 19%  numa-numastat.node1.local_node
    808782 ± 11%     -22.7%     625136 ±  3%  numa-numastat.node1.numa_hit
    807621 ± 11%     -22.7%     623994 ±  3%  numa-vmstat.node1.numa_hit
    615474 ± 13%     -23.4%     471431 ± 19%  numa-vmstat.node1.numa_local
      7794            -1.7%       7663        vmstat.system.cs
    165655           -13.3%     143602        vmstat.system.in
    253230           -12.0%     222807        stress-ng.time.minor_page_faults
    137566            -2.1%     134733        stress-ng.time.voluntary_context_switches
   1207842           -17.1%    1000730        stress-ng.uprobe.ops
     20128           -17.1%      16677        stress-ng.uprobe.ops_per_sec
   1472101            -5.5%    1391388        proc-vmstat.numa_hit
   1134062            -6.1%    1064637        proc-vmstat.numa_local
    338013            -3.4%     326662        proc-vmstat.numa_other
   1546190            -5.3%    1464601        proc-vmstat.pgalloc_normal
    734668            -3.6%     707943        proc-vmstat.pgfault
   1404573            -7.1%    1304931 ±  2%  proc-vmstat.pgfree
 9.486e+08 ±  2%      -4.9%   9.02e+08        perf-stat.i.branch-instructions
     12.74            -0.7       12.03        perf-stat.i.cache-miss-rate%
   4420739            -9.9%    3983251 ±  2%  perf-stat.i.cache-misses
  32400560            -7.1%   30085487        perf-stat.i.cache-references
      7758            -1.5%       7644        perf-stat.i.context-switches
      2.74            -2.4%       2.68        perf-stat.i.cpi
 8.758e+09 ±  4%     -11.0%  7.795e+09 ±  2%  perf-stat.i.cpu-cycles
 4.615e+09 ±  2%      -4.8%  4.394e+09        perf-stat.i.instructions
      0.49 ±  2%      +4.9%       0.51        perf-stat.i.ipc
      1.90 ±  2%      -6.5%       1.77        perf-stat.overall.cpi
      0.53 ±  2%      +6.9%       0.56        perf-stat.overall.ipc
 9.324e+08 ±  2%      -4.9%  8.869e+08        perf-stat.ps.branch-instructions
   4332704           -10.0%    3900449 ±  2%  perf-stat.ps.cache-misses
  31857304            -7.1%   29590770        perf-stat.ps.cache-references
      7624            -1.5%       7512        perf-stat.ps.context-switches
  8.61e+09 ±  4%     -10.9%  7.668e+09 ±  2%  perf-stat.ps.cpu-cycles
 4.536e+09 ±  2%      -4.8%   4.32e+09        perf-stat.ps.instructions
 2.777e+11 ±  2%      -4.5%  2.653e+11        perf-stat.total.instructions
      0.72 ± 14%      +0.2        0.87 ± 13%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.66 ± 16%      +0.2        0.87 ± 16%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.88 ± 15%      +0.2        1.12 ± 15%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.91 ± 15%      +0.3        1.16 ± 15%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.08 ± 11%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.05 ± 46%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.kmem_cache_free
      0.04 ± 45%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.select_task_rq
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.__memset
      0.20 ± 14%      +0.1        0.26 ± 12%  perf-profile.children.cycles-pp.do_nanosleep
      0.16 ± 17%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.21 ± 13%      +0.1        0.27 ± 13%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.10 ± 18%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.22 ± 12%      +0.1        0.28 ± 11%  perf-profile.children.cycles-pp.common_nsleep
      0.23 ± 13%      +0.1        0.30 ± 10%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.23 ± 13%      +0.1        0.31 ±  9%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.get_jiffies_update
      0.14 ± 16%      +0.1        0.24 ± 29%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.00            +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.46 ± 12%      +0.1        0.59 ± 12%  perf-profile.children.cycles-pp.schedule
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.tmigr_cpu_new_timer
      0.44 ±  7%      +0.2        0.60 ± 12%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.74 ± 15%      +0.2        0.90 ± 12%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.93 ± 11%      +0.2        1.10 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.73 ± 10%      +0.2        0.93 ± 12%  perf-profile.children.cycles-pp.__schedule
      1.18 ± 10%      +0.2        1.38 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.21 ± 10%      +0.2        1.42 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.73 ± 11%      +0.2        0.94 ± 12%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.7        0.72 ± 12%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.tmigr_cpu_new_timer
      0.00            +0.1        0.10 ± 11%  perf-profile.self.cycles-pp.get_jiffies_update
      0.00            +0.2        0.18 ± 21%  perf-profile.self.cycles-pp.__get_next_timer_interrupt


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/1/debian-12-x86_64-20240206.cgz/300s/lkp-csl-d02/grep/unixbench

commit: 
  57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
  7ee9887703 ("timers: Implement the hierarchical pull model")

57e95a5c4117dc6a 7ee988770326fca440472200c3e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7628            -1.9%       7482        vmstat.system.cs
     12925            +7.8%      13928        vmstat.system.in
     96.23 ± 17%     +18.3%     113.89 ±  5%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     96.23 ± 17%     +18.3%     113.89 ±  5%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    186.98 ±  5%      +7.3%     200.72 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    662532            -1.3%     653617        unixbench.score
     66253            -1.3%      65361        unixbench.throughput
  43491528            -1.2%   42983554        unixbench.time.minor_page_faults
    651305            -1.0%     644832        unixbench.time.voluntary_context_switches
  21863578            -1.3%   21569366        unixbench.workload
     26870            -1.1%      26563        proc-vmstat.nr_active_anon
      1732            +3.2%       1788        proc-vmstat.nr_page_table_pages
     27819            -1.1%      27502        proc-vmstat.nr_shmem
     26870            -1.1%      26563        proc-vmstat.nr_zone_active_anon
  34053976            -1.6%   33515996        proc-vmstat.numa_hit
  34055330            -1.6%   33515912        proc-vmstat.numa_local
  34957332            -1.5%   34439861        proc-vmstat.pgalloc_normal
  44052695            -1.2%   43542776        proc-vmstat.pgfault
  34903052            -1.5%   34385879        proc-vmstat.pgfree
      0.39            -5.1%       0.37 ±  3%  perf-stat.i.MPKI
      2.98            -0.0        2.93        perf-stat.i.branch-miss-rate%
  30266585            -1.4%   29836743        perf-stat.i.branch-misses
  52765663            -1.9%   51764909        perf-stat.i.cache-references
      7641            -1.7%       7508        perf-stat.i.context-switches
      1.08            +4.6%       1.13        perf-stat.i.cpi
    199.62            +2.6%     204.88        perf-stat.i.cpu-migrations
      7.25            -1.2%       7.16        perf-stat.i.metric.K/sec
    130922            -1.2%     129378        perf-stat.i.minor-faults
    130922            -1.2%     129378        perf-stat.i.page-faults
      2.63            +0.1        2.71        perf-stat.overall.cache-miss-rate%
  30174471            -1.4%   29744829        perf-stat.ps.branch-misses
  52600226            -1.9%   51602507        perf-stat.ps.cache-references
      7616            -1.7%       7484        perf-stat.ps.context-switches
    199.08            +2.6%     204.33        perf-stat.ps.cpu-migrations
    130510            -1.2%     128970        perf-stat.ps.minor-faults
    130510            -1.2%     128970        perf-stat.ps.page-faults
      3.61 ±  3%      -0.2        3.46 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3.59 ±  3%      -0.2        3.43 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      1.30 ±  3%      -0.2        1.14 ±  5%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.rep_movs_alternative._copy_to_iter.copy_page_to_iter
      1.28 ±  3%      -0.2        1.13 ±  5%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.rep_movs_alternative._copy_to_iter
      0.73 ±  7%      +0.1        0.85 ±  5%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exec_mmap
      0.81 ±  6%      +0.1        0.94 ±  4%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
      2.62 ±  3%      +0.2        2.82 ±  3%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      2.15 ±  3%      +0.2        2.38 ±  3%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      2.16 ±  3%      +0.2        2.39 ±  3%  perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      2.41 ±  3%      +0.2        2.64 ±  3%  perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      4.49 ±  2%      -0.2        4.30 ±  3%  perf-profile.children.cycles-pp.do_exit
      4.50 ±  2%      -0.2        4.31 ±  3%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      4.50 ±  2%      -0.2        4.31 ±  3%  perf-profile.children.cycles-pp.do_group_exit
      0.27 ± 12%      -0.1        0.16 ± 21%  perf-profile.children.cycles-pp.mt_find
      0.23 ± 16%      -0.1        0.12 ± 29%  perf-profile.children.cycles-pp.find_vma
      0.25 ± 14%      -0.1        0.16 ± 14%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.96 ±  3%      -0.1        0.88 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.36 ±  7%      -0.1        0.29 ± 12%  perf-profile.children.cycles-pp.setup_arg_pages
      0.99 ±  3%      -0.1        0.93 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap
      0.06 ±  7%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__kmalloc
      0.12 ± 11%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__tunable_get_val@plt
      0.04 ± 45%      +0.0        0.07 ± 13%  perf-profile.children.cycles-pp.kick_pool
      0.02 ±141%      +0.0        0.06 ± 17%  perf-profile.children.cycles-pp.current_obj_cgroup
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.00            +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.get_jiffies_update
      0.00            +0.2        0.16 ± 18%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      2.64 ±  3%      +0.2        2.84 ±  2%  perf-profile.children.cycles-pp.begin_new_exec
      2.42 ±  3%      +0.2        2.65 ±  3%  perf-profile.children.cycles-pp.exec_mmap
      0.27 ± 12%      -0.1        0.16 ± 21%  perf-profile.self.cycles-pp.mt_find
      0.22 ±  9%      -0.0        0.17 ± 14%  perf-profile.self.cycles-pp.__mbrtowc
      0.13 ±  8%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.06 ± 16%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.26 ±  9%      +0.1        0.32 ± 13%  perf-profile.self.cycles-pp.set_pte_range
      0.00            +0.1        0.13 ± 15%  perf-profile.self.cycles-pp.get_jiffies_update



***************************************************************************************************
lkp-icl-2sp5: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/filenum/fs/iomode/kconfig/nr_threads/period/rootfs/rwmode/size/tbox_group/testcase:
  gcc-12/performance/1HDD/1024f/btrfs/sync/x86_64-rhel-8.3/100%/600s/debian-12-x86_64-20240206.cgz/seqrewr/64G/lkp-icl-2sp5/sysbench-fileio

commit: 
  57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
  7ee9887703 ("timers: Implement the hierarchical pull model")

57e95a5c4117dc6a 7ee988770326fca440472200c3e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4038885 ±  2%     +29.5%    5230157        cpuidle..usage
      0.01            +0.0        0.02        mpstat.cpu.all.irq%
    193.31 ±  6%     -12.5%     169.09 ± 10%  sched_debug.cpu.curr->pid.avg
     37281            +2.6%      38264        vmstat.io.bo
      4942           +35.4%       6691        vmstat.system.in
     24784            +2.9%      25495        sysbench-fileio.fsync_operations/s
      4.74            -2.9%       4.61        sysbench-fileio.latency_avg_ms
  47366272            +2.8%   48693994        sysbench-fileio.time.file_system_outputs
     39.31            +2.9%      40.44        sysbench-fileio.write_bytes_MB/s
     37.48            +2.9%      38.57        sysbench-fileio.write_bytes_MiB/s
      2399            +2.9%       2468        sysbench-fileio.write_operations/s
    250388 ±  6%     -69.9%      75443 ± 98%  numa-meminfo.node0.AnonHugePages
    438576 ± 24%     -67.6%     142313 ± 93%  numa-meminfo.node0.AnonPages
    467749 ± 24%     -67.2%     153426 ± 87%  numa-meminfo.node0.AnonPages.max
    441221 ± 24%     -67.1%     145053 ± 92%  numa-meminfo.node0.Inactive(anon)
      2987 ±  9%     -17.4%       2468 ± 10%  numa-meminfo.node0.PageTables
     46230 ± 33%    +516.8%     285168 ± 30%  numa-meminfo.node1.AnonHugePages
    212504 ± 51%    +139.8%     509667 ± 25%  numa-meminfo.node1.AnonPages
    247145 ± 45%    +114.8%     530860 ± 26%  numa-meminfo.node1.AnonPages.max
    214161 ± 51%    +138.8%     511312 ± 25%  numa-meminfo.node1.Inactive(anon)
      2222 ± 13%     +22.8%       2729 ±  8%  numa-meminfo.node1.PageTables
    109644 ± 24%     -67.5%      35580 ± 93%  numa-vmstat.node0.nr_anon_pages
    122.26 ±  6%     -69.9%      36.84 ± 98%  numa-vmstat.node0.nr_anon_transparent_hugepages
    110306 ± 24%     -67.1%      36266 ± 92%  numa-vmstat.node0.nr_inactive_anon
    746.65 ±  9%     -17.2%     618.23 ± 10%  numa-vmstat.node0.nr_page_table_pages
    110306 ± 24%     -67.1%      36266 ± 92%  numa-vmstat.node0.nr_zone_inactive_anon
     53130 ± 51%    +139.8%     127421 ± 25%  numa-vmstat.node1.nr_anon_pages
     22.58 ± 33%    +516.7%     139.23 ± 30%  numa-vmstat.node1.nr_anon_transparent_hugepages
     53544 ± 51%    +138.7%     127833 ± 25%  numa-vmstat.node1.nr_inactive_anon
    555.71 ± 13%     +22.9%     682.72 ±  8%  numa-vmstat.node1.nr_page_table_pages
     53544 ± 51%    +138.7%     127833 ± 25%  numa-vmstat.node1.nr_zone_inactive_anon
   5929968            +2.8%    6095962        proc-vmstat.nr_dirtied
   3526206            +2.0%    3597875        proc-vmstat.nr_file_pages
   2690738            +2.7%    2762733        proc-vmstat.nr_inactive_file
   5929688            +2.8%    6095683        proc-vmstat.nr_written
   2690738            +2.7%    2762733        proc-vmstat.nr_zone_inactive_file
      9664 ± 21%     -52.9%       4550 ± 44%  proc-vmstat.numa_hint_faults
   7587440            +2.1%    7748319        proc-vmstat.numa_hit
   7454898            +2.2%    7615590        proc-vmstat.numa_local
     85409 ±  7%     -46.8%      45477 ± 53%  proc-vmstat.numa_pte_updates
   7777907            +2.4%    7961422        proc-vmstat.pgalloc_normal
  24431574            +2.7%   25088692        proc-vmstat.pgpgout
     97209            -2.0%      95278        proc-vmstat.pgreuse
      4.19            -6.9%       3.90        perf-stat.i.MPKI
 1.423e+08            +7.8%  1.533e+08        perf-stat.i.branch-instructions
      2.37            -0.1        2.28        perf-stat.i.branch-miss-rate%
   4828598            +2.8%    4961993        perf-stat.i.branch-misses
     11.59            -0.6       10.95        perf-stat.i.cache-miss-rate%
  17694047            +6.8%   18905331        perf-stat.i.cache-references
      2.55            +9.7%       2.79        perf-stat.i.cpi
 1.414e+09           +16.9%  1.653e+09        perf-stat.i.cpu-cycles
  7.09e+08            +5.5%  7.483e+08        perf-stat.i.instructions
      0.42            -7.8%       0.39        perf-stat.i.ipc
      2.78            -3.4%       2.69        perf-stat.overall.MPKI
      3.40            -0.2        3.24        perf-stat.overall.branch-miss-rate%
     11.16            -0.5       10.65        perf-stat.overall.cache-miss-rate%
      1.99           +10.7%       2.21        perf-stat.overall.cpi
    716.90           +14.6%     821.60        perf-stat.overall.cycles-between-cache-misses
      0.50            -9.7%       0.45        perf-stat.overall.ipc
 1.423e+08            +7.8%  1.533e+08        perf-stat.ps.branch-instructions
   4831408            +2.8%    4965541        perf-stat.ps.branch-misses
  17674767            +6.9%   18887551        perf-stat.ps.cache-references
 1.414e+09           +16.9%  1.653e+09        perf-stat.ps.cpu-cycles
  7.09e+08            +5.6%  7.484e+08        perf-stat.ps.instructions
      0.01 ± 26%     -33.3%       0.01 ± 23%  perf-stat.ps.major-faults
 4.635e+11            +5.5%  4.891e+11        perf-stat.total.instructions
     63.17 ±  7%     -16.9       46.30 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl
     17.51 ± 14%     -11.3        6.23 ± 55%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state
     17.51 ± 14%     -11.3        6.23 ± 55%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     17.51 ± 14%     -11.3        6.23 ± 55%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq
     17.51 ± 14%     -11.3        6.23 ± 55%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     17.51 ± 14%     -11.3        6.23 ± 55%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
     54.72 ± 11%      -9.2       45.51 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable
     54.72 ± 11%      -8.8       45.88 ± 16%  perf-profile.calltrace.cycles-pp.ioctl.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable.__cmd_record
     54.72 ± 11%      -8.8       45.88 ± 16%  perf-profile.calltrace.cycles-pp.perf_evsel__enable_cpu.__evlist__enable.__cmd_record.cmd_record.run_builtin
     54.72 ± 11%      -8.8       45.88 ± 16%  perf-profile.calltrace.cycles-pp.perf_evsel__run_ioctl.perf_evsel__enable_cpu.__evlist__enable.__cmd_record.cmd_record
      6.93 ± 25%      -6.9        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.93 ± 25%      -6.9        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.45 ± 18%      -6.4        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.45 ± 18%      -6.4        0.00        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.calltrace.cycles-pp.__libc_pwrite
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.calltrace.cycles-pp.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.calltrace.cycles-pp.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      6.16 ± 33%      -4.9        1.21 ± 89%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.rwsem_optimistic_spin
      6.16 ± 33%      -4.9        1.21 ± 89%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write
      6.16 ± 33%      -4.9        1.21 ± 89%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock
      6.16 ± 33%      -4.9        1.21 ± 89%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_inode_lock
      6.16 ± 33%      -4.9        1.21 ± 89%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath
      6.43 ± 30%      -4.8        1.59 ±100%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_inode_lock.btrfs_buffered_write
      6.44 ± 30%      -4.5        1.98 ± 77%  perf-profile.calltrace.cycles-pp.btrfs_inode_lock.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64
      6.44 ± 30%      -4.5        1.98 ± 77%  perf-profile.calltrace.cycles-pp.down_write.btrfs_inode_lock.btrfs_buffered_write.btrfs_do_write_iter.vfs_write
      6.44 ± 30%      -4.5        1.98 ± 77%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.btrfs_inode_lock.btrfs_buffered_write.btrfs_do_write_iter
      4.67 ± 35%      -2.9        1.80 ± 30%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__x64_sys_ioctl.do_syscall_64
      4.67 ± 35%      -2.9        1.80 ± 30%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      4.67 ± 35%      -2.9        1.80 ± 30%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__x64_sys_ioctl
      4.67 ± 35%      -2.9        1.80 ± 30%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     75.03 ±  5%     +16.1       91.11 ±  8%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
     26.65 ± 18%     +20.1       46.75 ±  8%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.65 ± 18%     +20.1       46.75 ±  8%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.65 ± 18%     +20.1       46.75 ±  8%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     26.65 ± 18%     +20.1       46.75 ±  8%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     25.05 ± 21%     +20.3       45.36 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     25.05 ± 21%     +20.3       45.36 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     25.05 ± 21%     +20.3       45.36 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.22 ± 58%     +30.0       36.20 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      6.22 ± 58%     +30.0       36.20 ±  9%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.22 ± 58%     +30.0       36.20 ±  9%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      6.22 ± 58%     +30.0       36.20 ±  9%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     70.92 ±  9%     -20.4       50.52 ± 11%  perf-profile.children.cycles-pp.do_syscall_64
     70.92 ±  9%     -20.4       50.52 ± 11%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     52.43 ± 12%     -13.0       39.41 ± 11%  perf-profile.children.cycles-pp.__x64_sys_ioctl
     17.51 ± 14%     -11.3        6.23 ± 55%  perf-profile.children.cycles-pp.intel_idle_irq
     54.72 ± 11%      -8.8       45.88 ± 16%  perf-profile.children.cycles-pp.ioctl
     54.72 ± 11%      -8.8       45.88 ± 16%  perf-profile.children.cycles-pp.perf_evsel__enable_cpu
     54.72 ± 11%      -8.8       45.88 ± 16%  perf-profile.children.cycles-pp.perf_evsel__run_ioctl
      6.45 ± 18%      -6.3        0.15 ± 90%  perf-profile.children.cycles-pp.__x64_sys_futex
      6.45 ± 18%      -6.3        0.15 ± 90%  perf-profile.children.cycles-pp.do_futex
      5.89 ±  5%      -5.3        0.58 ± 50%  perf-profile.children.cycles-pp._raw_spin_lock
      8.25 ± 19%      -5.2        3.04 ± 38%  perf-profile.children.cycles-pp.vfs_write
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.children.cycles-pp.__libc_pwrite
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.children.cycles-pp.__x64_sys_pwrite64
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.children.cycles-pp.btrfs_buffered_write
      8.24 ± 19%      -5.2        3.04 ± 38%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      5.24 ± 10%      -5.1        0.14 ±111%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      6.16 ± 33%      -4.9        1.30 ± 76%  perf-profile.children.cycles-pp.osq_lock
      6.43 ± 30%      -4.8        1.67 ± 90%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      6.65 ± 28%      -4.6        2.07 ± 69%  perf-profile.children.cycles-pp.btrfs_inode_lock
      6.65 ± 28%      -4.6        2.07 ± 69%  perf-profile.children.cycles-pp.down_write
      6.44 ± 30%      -4.4        2.07 ± 69%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      3.57 ± 11%      -3.5        0.11 ±104%  perf-profile.children.cycles-pp.__futex_wait
      3.57 ± 11%      -3.5        0.11 ±104%  perf-profile.children.cycles-pp.futex_wait
      3.57 ± 11%      -3.5        0.11 ±104%  perf-profile.children.cycles-pp.futex_wait_setup
      8.15 ±  8%      -2.9        5.26 ± 10%  perf-profile.children.cycles-pp.end_repeat_nmi
     18.03 ±  4%      -2.4       15.62 ± 10%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      7.83 ±  4%      -2.2        5.68 ± 13%  perf-profile.children.cycles-pp.nested_nmi_out
      1.82 ± 14%      -0.7        1.09 ± 12%  perf-profile.children.cycles-pp.sched_clock
      1.26 ± 20%      -0.5        0.79 ±  7%  perf-profile.children.cycles-pp.asm_exc_nmi
      0.82 ± 21%      -0.4        0.46 ± 16%  perf-profile.children.cycles-pp.nested_nmi
      1.76 ± 10%      -0.3        1.43 ± 10%  perf-profile.children.cycles-pp.ghes_copy_tofrom_phys
      0.41 ± 18%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.intel_pmu_handle_irq
      0.35 ± 11%      -0.1        0.26 ± 17%  perf-profile.children.cycles-pp.default_do_nmi
      0.26 ±  6%      -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.apei_check_gar
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.ct_nmi_exit
      0.22 ±  5%      +0.1        0.30 ± 11%  perf-profile.children.cycles-pp.ghes_in_nmi_queue_one_entry
      0.29 ± 14%      +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.fill_pud
      0.16 ± 28%      +0.2        0.35 ± 43%  perf-profile.children.cycles-pp.flush_tlb_one_kernel
      0.78 ± 10%      +0.2        0.98 ± 14%  perf-profile.children.cycles-pp.fill_pte
      0.13 ± 13%      +0.2        0.36 ± 18%  perf-profile.children.cycles-pp.repeat_nmi
      0.90 ± 15%      +0.4        1.35 ±  4%  perf-profile.children.cycles-pp.perf_event_nmi_handler
      0.88 ± 12%      +0.5        1.40 ± 10%  perf-profile.children.cycles-pp.set_pte_vaddr_p4d
      0.37 ± 30%      +0.6        0.95 ± 12%  perf-profile.children.cycles-pp.ct_nmi_enter
      5.48 ±  2%      +1.1        6.58 ±  8%  perf-profile.children.cycles-pp.acpi_os_read_memory
      2.98 ± 15%      +1.1        4.08 ± 17%  perf-profile.children.cycles-pp.memcpy_fromio
      0.71 ± 20%      +1.1        1.82 ±  5%  perf-profile.children.cycles-pp.perf_sample_event_took
      4.41 ± 11%      +1.9        6.27 ±  8%  perf-profile.children.cycles-pp.nmi_restore
      3.09 ± 17%      +1.9        4.95 ± 15%  perf-profile.children.cycles-pp.nmi_cpu_backtrace
     26.65 ± 18%     +20.1       46.75 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
     26.65 ± 18%     +20.1       46.75 ±  8%  perf-profile.children.cycles-pp.do_idle
     26.65 ± 18%     +20.1       46.75 ±  8%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     26.65 ± 18%     +20.1       46.75 ±  8%  perf-profile.children.cycles-pp.start_secondary
     25.05 ± 21%     +20.3       45.36 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
     25.05 ± 21%     +20.3       45.36 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
     25.05 ± 21%     +20.3       45.36 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
      8.15 ±  8%      -2.9        5.26 ± 10%  perf-profile.self.cycles-pp.end_repeat_nmi
     18.03 ±  4%      -2.4       15.62 ± 10%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      7.83 ±  4%      -2.2        5.68 ± 13%  perf-profile.self.cycles-pp.nested_nmi_out
      1.82 ± 14%      -0.7        1.09 ± 12%  perf-profile.self.cycles-pp.sched_clock
      1.26 ± 20%      -0.5        0.79 ±  7%  perf-profile.self.cycles-pp.asm_exc_nmi
      0.82 ± 21%      -0.4        0.46 ± 16%  perf-profile.self.cycles-pp.nested_nmi
      1.76 ± 10%      -0.3        1.43 ± 10%  perf-profile.self.cycles-pp.ghes_copy_tofrom_phys
      0.68 ± 30%      -0.3        0.43 ± 33%  perf-profile.self.cycles-pp._raw_spin_lock
      0.41 ± 18%      -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.intel_pmu_handle_irq
      0.35 ± 11%      -0.1        0.26 ± 17%  perf-profile.self.cycles-pp.default_do_nmi
      0.26 ±  6%      -0.0        0.23 ±  4%  perf-profile.self.cycles-pp.apei_check_gar
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ct_nmi_exit
      0.22 ±  5%      +0.1        0.30 ± 11%  perf-profile.self.cycles-pp.ghes_in_nmi_queue_one_entry
      0.29 ± 14%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.fill_pud
      0.16 ± 28%      +0.2        0.35 ± 43%  perf-profile.self.cycles-pp.flush_tlb_one_kernel
      0.78 ± 10%      +0.2        0.98 ± 14%  perf-profile.self.cycles-pp.fill_pte
      0.13 ± 13%      +0.2        0.36 ± 18%  perf-profile.self.cycles-pp.repeat_nmi
      0.02 ±141%      +0.3        0.29 ± 27%  perf-profile.self.cycles-pp.do_syscall_64
      0.90 ± 15%      +0.4        1.35 ±  4%  perf-profile.self.cycles-pp.perf_event_nmi_handler
      0.88 ± 12%      +0.5        1.40 ± 10%  perf-profile.self.cycles-pp.set_pte_vaddr_p4d
      0.37 ± 30%      +0.6        0.95 ± 12%  perf-profile.self.cycles-pp.ct_nmi_enter
      2.07 ±  8%      +0.7        2.79 ± 14%  perf-profile.self.cycles-pp.cc_platform_has
      5.48 ±  2%      +1.1        6.58 ±  8%  perf-profile.self.cycles-pp.acpi_os_read_memory
      2.98 ± 15%      +1.1        4.08 ± 17%  perf-profile.self.cycles-pp.memcpy_fromio
      0.71 ± 20%      +1.1        1.82 ±  5%  perf-profile.self.cycles-pp.perf_sample_event_took
      2.48 ± 18%      +1.3        3.75 ± 12%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      4.41 ± 11%      +1.9        6.27 ±  8%  perf-profile.self.cycles-pp.nmi_restore
      3.09 ± 17%      +1.9        4.95 ± 15%  perf-profile.self.cycles-pp.nmi_cpu_backtrace



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/50%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

commit: 
  57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
  7ee9887703 ("timers: Implement the hierarchical pull model")

57e95a5c4117dc6a 7ee988770326fca440472200c3e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    791627           +34.3%    1063349 ±  3%  cpuidle..usage
   8874695            +7.8%    9566679 ±  4%  meminfo.DirectMap2M
      0.00 ±  2%      +0.0        0.00 ±  4%  mpstat.cpu.all.irq%
      3270           +26.6%       4142 ±  3%  vmstat.system.in
      1.67 ± 28%    +140.0%       4.00 ± 20%  perf-c2c.DRAM.local
     49.00 ±  4%     -29.9%      34.33 ± 12%  perf-c2c.DRAM.remote
     78.67 ±  7%     -25.0%      59.00 ±  6%  perf-c2c.HITM.local
     43783 ± 22%     -43.7%      24659 ± 14%  sched_debug.cpu.nr_switches.max
    660.89 ±  7%     +46.2%     965.97 ± 17%  sched_debug.cpu.nr_switches.min
      5184 ± 14%     -31.5%       3549 ±  6%  sched_debug.cpu.nr_switches.stddev
      5.67 ±  6%     -13.2%       4.92 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
      4.10            -2.0%       4.02        netperf.ThroughputBoth_Mbps
    262.40            -2.0%     257.25        netperf.ThroughputBoth_total_Mbps
      4.10            -2.0%       4.02        netperf.Throughput_Mbps
    262.40            -2.0%     257.25        netperf.Throughput_total_Mbps
     46784            -1.8%      45942        netperf.time.voluntary_context_switches
     46220            -1.6%      45484        netperf.workload
      4958            +5.6%       5237        proc-vmstat.nr_active_anon
      6165            +4.7%       6457        proc-vmstat.nr_shmem
      4958            +5.6%       5237        proc-vmstat.nr_zone_active_anon
     87.33 ± 57%   +7904.2%       6990 ± 71%  proc-vmstat.numa_hint_faults
     44.00 ± 54%  +52477.3%      23134 ±  9%  proc-vmstat.numa_pages_migrated
     13703 ±100%    +524.0%      85506 ± 18%  proc-vmstat.numa_pte_updates
      8135 ±  3%     +14.9%       9348 ±  2%  proc-vmstat.pgactivate
  15464423            -1.6%   15214940        proc-vmstat.pgalloc_normal
    867761            +1.8%     883669        proc-vmstat.pgfault
  15409978            -1.5%   15180783        proc-vmstat.pgfree
     44.00 ± 54%  +52477.3%      23134 ±  9%  proc-vmstat.pgmigrate_success
      2.41 ±  3%     +34.4%       3.24 ±  3%  perf-stat.i.MPKI
 1.481e+08            +2.0%  1.511e+08        perf-stat.i.branch-instructions
      1.89            -0.1        1.83        perf-stat.i.branch-miss-rate%
      6.77            +2.3        9.03 ±  3%  perf-stat.i.cache-miss-rate%
    594864 ±  2%     +30.1%     774042 ±  3%  perf-stat.i.cache-misses
   7497126            +3.7%    7776010        perf-stat.i.cache-references
      1.20           +30.6%       1.57 ±  3%  perf-stat.i.cpi
  6.03e+08           +12.9%  6.807e+08 ±  2%  perf-stat.i.cpu-cycles
    148.88            +5.4%     156.89        perf-stat.i.cpu-migrations
    711.72            -6.3%     666.95 ±  2%  perf-stat.i.cycles-between-cache-misses
 7.287e+08            +1.3%  7.384e+08        perf-stat.i.instructions
      0.88           -16.3%       0.74        perf-stat.i.ipc
      0.02 ± 40%     -36.1%       0.01 ± 47%  perf-stat.i.major-faults
      2672            +1.4%       2710        perf-stat.i.minor-faults
      2672            +1.4%       2710        perf-stat.i.page-faults
      0.82 ±  2%     +28.5%       1.05 ±  4%  perf-stat.overall.MPKI
      4.78            -0.2        4.62        perf-stat.overall.branch-miss-rate%
      7.94 ±  2%      +2.0        9.96 ±  3%  perf-stat.overall.cache-miss-rate%
      0.83           +11.4%       0.92        perf-stat.overall.cpi
      1015 ±  2%     -13.2%     881.52 ±  3%  perf-stat.overall.cycles-between-cache-misses
      1.21           -10.2%       1.08        perf-stat.overall.ipc
   4756675            +3.3%    4914804        perf-stat.overall.path-length
 1.478e+08            +2.1%  1.509e+08        perf-stat.ps.branch-instructions
    593523 ±  2%     +30.1%     772191 ±  3%  perf-stat.ps.cache-misses
   7477006            +3.7%    7755793        perf-stat.ps.cache-references
 6.023e+08           +12.9%    6.8e+08 ±  2%  perf-stat.ps.cpu-cycles
    148.41            +5.4%     156.39        perf-stat.ps.cpu-migrations
 7.275e+08            +1.3%  7.372e+08        perf-stat.ps.instructions
      0.02 ± 40%     -35.9%       0.01 ± 47%  perf-stat.ps.major-faults
      2663            +1.5%       2702        perf-stat.ps.minor-faults
      2663            +1.5%       2702        perf-stat.ps.page-faults
 2.199e+11            +1.7%  2.236e+11        perf-stat.total.instructions
     32.22 ±  2%     -11.2       21.04 ± 17%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     24.32 ±  5%      -9.0       15.33 ± 16%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     26.04 ±  4%      -8.7       17.37 ± 17%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     18.59 ±  5%      -7.6       10.95 ± 15%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
     14.66 ±  7%      -5.9        8.81 ± 13%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
     14.73 ±  7%      -5.8        8.90 ± 13%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
     12.51 ±  3%      -4.9        7.58 ± 21%  perf-profile.calltrace.cycles-pp.main
     10.78 ±  6%      -4.9        5.86 ±  7%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     10.76 ±  6%      -4.9        5.85 ±  7%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
     10.74 ±  6%      -4.9        5.85 ±  7%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu
      4.53 ± 11%      -3.4        1.15 ±  3%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      8.86 ±  6%      -3.3        5.57 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg.main
     12.41 ±  6%      -3.3        9.13 ± 13%  perf-profile.calltrace.cycles-pp.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     12.43 ±  6%      -3.3        9.16 ± 13%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      8.83 ±  6%      -3.3        5.57 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main
      8.86 ±  6%      -3.3        5.60 ± 20%  perf-profile.calltrace.cycles-pp.sendmsg.main
     12.43 ±  6%      -3.3        9.17 ± 13%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      8.74 ±  7%      -3.3        5.49 ± 19%  perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
      8.79 ±  6%      -3.2        5.56 ± 19%  perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main
      8.70 ±  7%      -3.2        5.48 ± 19%  perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.74 ±  6%      -3.2        9.56 ± 15%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
      9.54            -3.2        6.38 ± 16%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      8.58 ±  6%      -3.2        5.43 ± 19%  perf-profile.calltrace.cycles-pp.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
     11.34 ±  5%      -3.2        8.19 ± 16%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     11.68 ±  6%      -3.1        8.60 ± 13%  perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     11.07 ±  5%      -3.1        8.01 ± 16%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
      8.30 ±  5%      -3.0        5.33 ± 18%  perf-profile.calltrace.cycles-pp.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
      7.28 ±  4%      -2.6        4.66 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.25 ±  4%      -2.6        4.66 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.33 ±  8%      -2.4        2.92 ± 14%  perf-profile.calltrace.cycles-pp.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg
      9.48 ±  2%      -2.4        7.10 ± 15%  perf-profile.calltrace.cycles-pp.recvmsg
      9.33 ±  3%      -2.3        6.99 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      9.33 ±  3%      -2.3        6.99 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
      4.27 ± 12%      -2.3        1.98 ± 18%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      9.04 ±  4%      -2.3        6.77 ± 14%  perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      9.08 ±  4%      -2.2        6.84 ± 15%  perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      8.93 ±  4%      -2.2        6.75 ± 14%  perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.82 ±  4%      -2.2        6.65 ± 14%  perf-profile.calltrace.cycles-pp.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
      8.90 ±  3%      -2.2        6.75 ± 14%  perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
      8.82 ±  4%      -2.2        6.66 ± 14%  perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
      3.81 ± 11%      -2.2        1.66 ± 11%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.81 ± 11%      -2.2        1.66 ± 11%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      4.26 ± 13%      -2.1        2.18 ± 14%  perf-profile.calltrace.cycles-pp.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg
      4.17 ± 10%      -2.0        2.15 ± 13%  perf-profile.calltrace.cycles-pp._copy_from_iter.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg
      3.41 ± 11%      -1.9        1.48 ±  8%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.15 ± 14%      -1.8        1.37 ± 12%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.44 ± 12%      -1.8        2.66 ± 24%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      4.44 ± 12%      -1.8        2.67 ± 24%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      4.44 ± 12%      -1.8        2.67 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      4.44 ± 12%      -1.8        2.67 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      4.44 ± 12%      -1.8        2.67 ± 24%  perf-profile.calltrace.cycles-pp.execve
      3.79 ± 17%      -1.8        2.03 ± 17%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.31            -1.7        2.60 ± 25%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      4.31            -1.7        2.60 ± 25%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      4.24            -1.7        2.53 ± 25%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
      3.50 ± 12%      -1.5        1.96 ± 24%  perf-profile.calltrace.cycles-pp.run_builtin.main
      7.21 ±  5%      -1.5        5.74 ± 24%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      7.21 ±  5%      -1.5        5.74 ± 24%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      7.21 ±  5%      -1.5        5.74 ± 24%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      3.03 ±  9%      -1.4        1.62 ± 24%  perf-profile.calltrace.cycles-pp.cmd_stat.run_builtin.main
      3.03 ±  9%      -1.4        1.62 ± 24%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat.run_builtin.main
      3.03 ±  9%      -1.4        1.62 ± 24%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat.run_builtin.main
      1.90 ± 13%      -1.4        0.48 ± 70%  perf-profile.calltrace.cycles-pp.run_timer_softirq.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.85 ± 13%      -1.4        0.47 ± 70%  perf-profile.calltrace.cycles-pp.__run_timers.run_timer_softirq.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      3.46 ± 11%      -1.4        2.09 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.46 ± 11%      -1.4        2.09 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.50 ± 12%      -1.4        2.15 ± 16%  perf-profile.calltrace.cycles-pp.read
      3.39 ± 11%      -1.3        2.04 ± 16%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.72 ± 15%      -1.3        0.40 ± 72%  perf-profile.calltrace.cycles-pp.call_timer_fn.__run_timers.run_timer_softirq.__do_softirq.irq_exit_rcu
      2.77 ±  5%      -1.2        1.53 ± 23%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat.run_builtin
      2.72 ±  6%      -1.2        1.51 ± 23%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      2.35 ± 13%      -1.2        1.15 ± 21%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.39 ± 13%      -1.2        1.21 ± 18%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.52 ± 11%      -1.1        0.39 ± 71%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      4.04 ± 12%      -1.1        2.91 ± 23%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      1.52 ± 11%      -1.1        0.42 ± 71%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.52 ±  9%      -1.1        1.45 ± 22%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.81 ± 13%      -1.0        0.77 ± 12%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      4.38 ±  9%      -1.0        3.38 ±  8%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      2.94 ±  8%      -1.0        1.97 ± 25%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.92 ±  7%      -1.0        0.96 ± 27%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.88 ± 19%      -0.9        0.93 ± 11%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      1.88 ± 19%      -0.9        0.93 ± 11%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.88 ± 19%      -0.9        0.93 ± 11%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      1.90 ±  9%      -0.9        0.96 ± 27%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      2.23 ± 17%      -0.9        1.31 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.23 ± 17%      -0.9        1.31 ± 11%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.23 ± 17%      -0.9        1.31 ± 11%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.81 ±  7%      -0.9        1.90        perf-profile.calltrace.cycles-pp.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      2.70 ±  6%      -0.9        1.83        perf-profile.calltrace.cycles-pp.__memcpy.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      2.05 ±  6%      -0.9        1.19 ± 17%  perf-profile.calltrace.cycles-pp.setlocale
      1.23 ±  3%      -0.8        0.38 ± 71%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.29 ±  5%      -0.8        0.49 ± 75%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      1.38 ±  6%      -0.8        0.59 ± 71%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.balance_fair
      1.74 ± 13%      -0.8        0.96 ± 45%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.75 ±  9%      -0.8        1.97 ± 23%  perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      1.38 ±  6%      -0.8        0.61 ± 70%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.balance_fair.__schedule
      2.03 ± 15%      -0.8        1.28 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.03 ± 15%      -0.8        1.28 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.56 ± 13%      -0.8        0.81 ± 27%  perf-profile.calltrace.cycles-pp.balance_fair.__schedule.schedule.smpboot_thread_fn.kthread
      1.56 ± 13%      -0.8        0.81 ± 27%  perf-profile.calltrace.cycles-pp.newidle_balance.balance_fair.__schedule.schedule.smpboot_thread_fn
      1.34 ± 11%      -0.7        0.59 ± 71%  perf-profile.calltrace.cycles-pp.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      1.90 ± 16%      -0.7        1.16 ± 24%  perf-profile.calltrace.cycles-pp.__memcpy.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data
      1.90 ± 16%      -0.7        1.16 ± 24%  perf-profile.calltrace.cycles-pp.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter
      2.52 ±  8%      -0.7        1.80 ± 25%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      2.57 ±  7%      -0.7        1.86 ± 26%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      2.57 ±  7%      -0.7        1.86 ± 26%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      1.30            -0.7        0.61 ± 72%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      2.37 ± 11%      -0.7        1.68 ± 19%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      2.37 ± 11%      -0.7        1.68 ± 19%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      2.37 ± 11%      -0.7        1.68 ± 19%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.09 ± 11%      -0.7        0.42 ± 73%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.05 ± 12%      -0.7        0.39 ± 71%  perf-profile.calltrace.cycles-pp.__memcpy.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_partial_delivery
      1.05 ± 12%      -0.7        0.39 ± 71%  perf-profile.calltrace.cycles-pp.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_partial_delivery.sctp_cmd_interpreter
      1.43 ± 10%      -0.6        0.79 ± 26%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.balance_fair.__schedule.schedule
      2.43 ±  9%      -0.6        1.84 ± 19%  perf-profile.calltrace.cycles-pp.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      2.19 ±  3%      -0.6        1.59 ± 18%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
      0.99 ± 26%      -0.6        0.39 ± 70%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.27 ± 21%      -0.6        0.68 ± 12%  perf-profile.calltrace.cycles-pp.skb_copy.sctp_make_reassembled_event.sctp_ulpq_partial_delivery.sctp_cmd_interpreter.sctp_do_sm
      2.39 ± 10%      -0.6        1.80 ± 21%  perf-profile.calltrace.cycles-pp.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      1.43 ± 21%      -0.6        0.85 ± 17%  perf-profile.calltrace.cycles-pp.sctp_ulpq_partial_delivery.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      0.94 ± 31%      -0.5        0.39 ± 70%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.27 ± 21%      -0.5        0.73 ± 15%  perf-profile.calltrace.cycles-pp.sctp_make_reassembled_event.sctp_ulpq_partial_delivery.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      0.89 ± 18%      -0.5        0.35 ± 70%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.89 ± 18%      -0.5        0.35 ± 70%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      0.89 ± 18%      -0.5        0.36 ± 70%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      2.01 ±  3%      -0.5        1.48 ± 20%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
      1.45 ±  8%      -0.5        0.93 ± 32%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.36 ± 10%      -0.5        0.86 ± 30%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      2.21 ±  3%      -0.5        1.71 ± 23%  perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg
      2.01 ±  3%      -0.5        1.53 ± 19%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      1.50 ± 11%      -0.5        1.02 ± 11%  perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      2.10 ± 11%      -0.5        1.63 ± 13%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      0.96 ± 11%      -0.5        0.50 ± 73%  perf-profile.calltrace.cycles-pp.__memcpy.sctp_packet_pack.sctp_packet_transmit.sctp_packet_transmit_chunk.sctp_outq_flush_data
      0.96 ± 11%      -0.5        0.50 ± 73%  perf-profile.calltrace.cycles-pp.sctp_packet_pack.sctp_packet_transmit.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush
      0.85 ± 24%      -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.85 ± 24%      -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      0.89 ± 13%      -0.4        0.45 ± 73%  perf-profile.calltrace.cycles-pp._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg
      0.94 ± 10%      -0.4        0.50 ± 73%  perf-profile.calltrace.cycles-pp.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg
      1.01 ± 13%      -0.4        0.57 ± 71%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      1.16 ±  7%      -0.4        0.75 ± 13%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_packet_transmit_chunk.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter
      0.83 ±  2%      -0.4        0.43 ± 71%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.78 ± 10%      -0.4        0.39 ± 70%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.78 ± 19%      -0.4        0.39 ± 70%  perf-profile.calltrace.cycles-pp._Fork
      0.76 ± 15%      -0.4        0.39 ± 73%  perf-profile.calltrace.cycles-pp.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
      0.87 ± 17%      -0.4        0.50 ± 73%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.16 ± 15%      -0.3        0.82 ± 18%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains._nohz_idle_balance.__do_softirq
      1.16 ± 15%      -0.3        0.82 ± 18%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains._nohz_idle_balance
      1.20 ± 15%      -0.3        0.88 ± 21%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.18 ± 14%      -0.3        0.86 ± 25%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      1.27 ± 20%      -0.3        0.96 ± 16%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains._nohz_idle_balance.__do_softirq.irq_exit_rcu
      0.65 ±  4%      -0.3        0.37 ± 71%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.00            +1.1        1.14 ± 17%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.2        1.16 ± 16%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.34 ± 11%      +1.2        2.57 ± 25%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.34 ± 11%      +1.2        2.57 ± 25%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.21 ±  9%      +1.3        2.51 ± 26%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      1.21 ±  9%      +1.3        2.51 ± 26%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      1.21 ±  9%      +1.3        2.51 ± 26%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd
     39.03 ±  3%     +20.1       59.08 ± 10%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.09 ±  3%     +20.1       59.15 ± 10%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.09 ±  3%     +20.1       59.15 ± 10%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     41.77 ±  3%     +20.8       62.59 ± 11%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     32.58 ±  3%     +24.3       56.85 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.99 ±  2%     +24.7       54.73 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     32.56 ±  3%     +25.4       57.97 ± 13%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00           +36.3       36.33 ± 31%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     40.13 ±  3%     -13.9       26.25 ± 17%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.02 ±  3%     -13.8       26.24 ± 17%  perf-profile.children.cycles-pp.do_syscall_64
     32.22 ±  2%     -11.1       21.08 ± 17%  perf-profile.children.cycles-pp.acpi_idle_enter
     32.16 ±  3%     -11.1       21.03 ± 17%  perf-profile.children.cycles-pp.acpi_safe_halt
     22.61 ±  4%      -7.5       15.13 ± 14%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     18.86 ±  6%      -7.2       11.69 ± 13%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     17.21 ±  7%      -6.1       11.10 ± 15%  perf-profile.children.cycles-pp.irq_exit_rcu
     12.62 ±  3%      -5.0        7.61 ± 21%  perf-profile.children.cycles-pp.main
     19.87 ±  7%      -4.8       15.07 ± 17%  perf-profile.children.cycles-pp.__do_softirq
      6.96 ±  9%      -4.1        2.91 ±  9%  perf-profile.children.cycles-pp._nohz_idle_balance
     14.42 ±  4%      -3.9       10.56 ± 15%  perf-profile.children.cycles-pp.sctp_do_sm
     14.11 ±  4%      -3.8       10.29 ± 14%  perf-profile.children.cycles-pp.sctp_cmd_interpreter
     13.37 ±  6%      -3.4       10.02 ± 14%  perf-profile.children.cycles-pp.process_backlog
     13.44 ±  6%      -3.3       10.09 ± 14%  perf-profile.children.cycles-pp.net_rx_action
     13.37 ±  6%      -3.3       10.06 ± 14%  perf-profile.children.cycles-pp.__napi_poll
      8.90 ±  5%      -3.3        5.61 ± 20%  perf-profile.children.cycles-pp.sendmsg
      8.74 ±  7%      -3.3        5.49 ± 19%  perf-profile.children.cycles-pp.___sys_sendmsg
      8.79 ±  6%      -3.2        5.56 ± 19%  perf-profile.children.cycles-pp.__sys_sendmsg
      8.67 ±  6%      -3.2        5.44 ± 19%  perf-profile.children.cycles-pp.sctp_sendmsg
      8.70 ±  7%      -3.2        5.48 ± 19%  perf-profile.children.cycles-pp.____sys_sendmsg
     13.21 ±  6%      -3.2        9.99 ± 14%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     12.86 ±  7%      -3.2        9.70 ± 13%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     12.83 ±  7%      -3.1        9.69 ± 13%  perf-profile.children.cycles-pp.sctp_rcv
     12.86 ±  7%      -3.1        9.73 ± 13%  perf-profile.children.cycles-pp.ip_local_deliver_finish
     12.08 ±  6%      -3.0        9.05 ± 14%  perf-profile.children.cycles-pp.sctp_assoc_bh_rcv
      8.30 ±  5%      -3.0        5.33 ± 18%  perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
      5.87 ± 12%      -2.9        2.99 ± 19%  perf-profile.children.cycles-pp.asm_exc_page_fault
      4.55 ± 14%      -2.7        1.83 ± 23%  perf-profile.children.cycles-pp._raw_spin_lock
      5.11 ± 12%      -2.6        2.52 ± 15%  perf-profile.children.cycles-pp.do_user_addr_fault
      5.11 ± 12%      -2.6        2.53 ± 14%  perf-profile.children.cycles-pp.exc_page_fault
      4.80 ± 12%      -2.5        2.30 ± 13%  perf-profile.children.cycles-pp.handle_mm_fault
      9.53 ±  2%      -2.4        7.10 ± 15%  perf-profile.children.cycles-pp.recvmsg
      5.33 ±  8%      -2.4        2.92 ± 14%  perf-profile.children.cycles-pp.sctp_datamsg_from_user
      4.44 ± 15%      -2.4        2.08 ± 17%  perf-profile.children.cycles-pp.__handle_mm_fault
      9.04 ±  4%      -2.3        6.77 ± 14%  perf-profile.children.cycles-pp.___sys_recvmsg
      9.08 ±  4%      -2.2        6.84 ± 15%  perf-profile.children.cycles-pp.__sys_recvmsg
      8.93 ±  4%      -2.2        6.75 ± 14%  perf-profile.children.cycles-pp.____sys_recvmsg
      6.92 ±  2%      -2.2        4.75 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      8.90 ±  3%      -2.2        6.75 ± 14%  perf-profile.children.cycles-pp.sock_recvmsg
      8.82 ±  4%      -2.1        6.67 ± 14%  perf-profile.children.cycles-pp.inet_recvmsg
      8.84 ±  3%      -2.1        6.72 ± 14%  perf-profile.children.cycles-pp.sctp_recvmsg
      4.26 ± 13%      -2.1        2.18 ± 14%  perf-profile.children.cycles-pp.sctp_user_addto_chunk
      5.13 ± 12%      -2.0        3.08 ± 20%  perf-profile.children.cycles-pp.__schedule
      4.19 ± 11%      -2.0        2.19 ± 14%  perf-profile.children.cycles-pp._copy_from_iter
      8.57 ±  2%      -2.0        6.58 ± 12%  perf-profile.children.cycles-pp.sctp_outq_flush
      7.61 ±  5%      -2.0        5.65 ±  9%  perf-profile.children.cycles-pp.__memcpy
      4.39 ± 14%      -1.9        2.49 ± 11%  perf-profile.children.cycles-pp.read
      4.17 ± 13%      -1.8        2.34 ± 12%  perf-profile.children.cycles-pp.ksys_read
      4.15 ± 12%      -1.8        2.34 ± 12%  perf-profile.children.cycles-pp.vfs_read
      2.48 ±  5%      -1.8        0.67 ± 25%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      4.44 ± 12%      -1.8        2.67 ± 24%  perf-profile.children.cycles-pp.execve
      4.44 ± 12%      -1.8        2.69 ± 23%  perf-profile.children.cycles-pp.__x64_sys_execve
      4.44 ± 12%      -1.8        2.69 ± 23%  perf-profile.children.cycles-pp.do_execveat_common
      4.31            -1.7        2.60 ± 25%  perf-profile.children.cycles-pp.__skb_datagram_iter
      4.31            -1.7        2.60 ± 25%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      4.37 ±  2%      -1.7        2.67 ± 26%  perf-profile.children.cycles-pp._copy_to_iter
      4.04 ±  6%      -1.6        2.48 ± 23%  perf-profile.children.cycles-pp.schedule
      3.50 ± 12%      -1.5        1.96 ± 24%  perf-profile.children.cycles-pp.run_builtin
      7.32 ±  4%      -1.5        5.83 ± 23%  perf-profile.children.cycles-pp.ret_from_fork
      2.72 ± 18%      -1.5        1.25 ± 17%  perf-profile.children.cycles-pp.do_fault
      7.21 ±  5%      -1.5        5.74 ± 24%  perf-profile.children.cycles-pp.kthread
      7.34 ±  4%      -1.5        5.88 ± 23%  perf-profile.children.cycles-pp.ret_from_fork_asm
      3.03 ±  9%      -1.4        1.62 ± 24%  perf-profile.children.cycles-pp.cmd_stat
      3.03 ±  9%      -1.4        1.62 ± 24%  perf-profile.children.cycles-pp.dispatch_events
      3.03 ±  9%      -1.4        1.62 ± 24%  perf-profile.children.cycles-pp.process_interval
      1.90 ± 13%      -1.3        0.55 ± 43%  perf-profile.children.cycles-pp.run_timer_softirq
      2.32 ± 14%      -1.3        1.01 ± 21%  perf-profile.children.cycles-pp.do_read_fault
      4.40 ± 11%      -1.3        3.09 ± 25%  perf-profile.children.cycles-pp.load_balance
      4.02 ± 10%      -1.3        2.73 ± 25%  perf-profile.children.cycles-pp.update_sd_lb_stats
      4.02 ± 10%      -1.3        2.75 ± 25%  perf-profile.children.cycles-pp.find_busiest_group
      2.19 ± 16%      -1.3        0.92 ± 24%  perf-profile.children.cycles-pp.filemap_map_pages
      2.79 ±  6%      -1.3        1.53 ± 23%  perf-profile.children.cycles-pp.read_counters
      3.64 ±  8%      -1.3        2.39 ± 23%  perf-profile.children.cycles-pp.update_sg_lb_stats
      7.19 ±  5%      -1.2        5.98 ± 13%  perf-profile.children.cycles-pp.sctp_packet_transmit
      3.06 ±  6%      -1.2        1.89 ±  8%  perf-profile.children.cycles-pp.do_sys_openat2
      4.13 ± 11%      -1.2        2.98 ± 11%  perf-profile.children.cycles-pp.skb_copy
      3.06 ±  6%      -1.1        1.91 ±  6%  perf-profile.children.cycles-pp.__x64_sys_openat
      4.17 ± 11%      -1.1        3.05 ± 11%  perf-profile.children.cycles-pp.sctp_make_reassembled_event
      4.06 ± 11%      -1.1        2.94 ± 23%  perf-profile.children.cycles-pp.sysvec_call_function_single
      2.66 ±  7%      -1.1        1.58 ±  9%  perf-profile.children.cycles-pp.path_openat
      3.35 ± 13%      -1.1        2.29 ±  6%  perf-profile.children.cycles-pp.skb_copy_bits
      2.70 ±  8%      -1.1        1.64 ±  8%  perf-profile.children.cycles-pp.do_filp_open
      2.23 ± 19%      -1.1        1.18 ± 12%  perf-profile.children.cycles-pp.__mmput
      2.23 ± 19%      -1.1        1.18 ± 12%  perf-profile.children.cycles-pp.exit_mmap
      2.88 ±  3%      -1.0        1.83 ± 11%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.75 ±  5%      -1.0        1.71 ± 31%  perf-profile.children.cycles-pp.newidle_balance
      3.28 ± 11%      -1.0        2.28 ± 14%  perf-profile.children.cycles-pp.sctp_ulpq_tail_data
      2.74 ± 18%      -1.0        1.75 ± 29%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      2.72 ±  4%      -1.0        1.74 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.99 ± 10%      -1.0        2.02 ± 23%  perf-profile.children.cycles-pp.bprm_execve
      4.26 ±  7%      -0.9        3.31 ± 11%  perf-profile.children.cycles-pp.sctp_packet_pack
      2.30 ± 19%      -0.9        1.35 ± 13%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      2.30 ± 19%      -0.9        1.35 ± 13%  perf-profile.children.cycles-pp.do_exit
      2.30 ± 19%      -0.9        1.35 ± 13%  perf-profile.children.cycles-pp.do_group_exit
      1.88 ± 19%      -0.9        0.94 ± 11%  perf-profile.children.cycles-pp.exit_mm
      1.85 ± 13%      -0.9        0.92 ± 25%  perf-profile.children.cycles-pp.__run_timers
      2.32 ± 11%      -0.9        1.38 ± 18%  perf-profile.children.cycles-pp.seq_read_iter
      1.63 ± 14%      -0.9        0.69 ± 23%  perf-profile.children.cycles-pp.update_blocked_averages
      1.72 ± 15%      -0.9        0.80 ± 21%  perf-profile.children.cycles-pp.call_timer_fn
      2.05 ±  6%      -0.9        1.19 ± 17%  perf-profile.children.cycles-pp.setlocale
      2.56 ± 17%      -0.8        1.72 ± 27%  perf-profile.children.cycles-pp.do_mmap
      1.56 ± 13%      -0.8        0.81 ± 27%  perf-profile.children.cycles-pp.balance_fair
      1.90 ±  7%      -0.8        1.14 ± 22%  perf-profile.children.cycles-pp.link_path_walk
      2.45 ±  9%      -0.8        1.70 ± 22%  perf-profile.children.cycles-pp.sctp_outq_flush_data
      2.39 ± 17%      -0.7        1.65 ± 27%  perf-profile.children.cycles-pp.mmap_region
      1.14 ± 19%      -0.7        0.42 ± 24%  perf-profile.children.cycles-pp.irq_enter_rcu
      2.52 ±  8%      -0.7        1.80 ± 25%  perf-profile.children.cycles-pp.load_elf_binary
      1.07 ± 18%      -0.7        0.35 ± 18%  perf-profile.children.cycles-pp.tick_irq_enter
      2.57 ±  7%      -0.7        1.86 ± 26%  perf-profile.children.cycles-pp.exec_binprm
      2.57 ±  7%      -0.7        1.86 ± 26%  perf-profile.children.cycles-pp.search_binary_handler
      1.14 ± 38%      -0.6        0.49 ±  5%  perf-profile.children.cycles-pp.__mod_timer
      2.05 ± 22%      -0.6        1.42 ± 20%  perf-profile.children.cycles-pp.__alloc_pages
      3.33 ±  4%      -0.6        2.71 ± 15%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.87 ± 16%      -0.6        1.25 ± 26%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.92 ± 32%      -0.6        0.32 ± 17%  perf-profile.children.cycles-pp.readn
      1.23 ± 26%      -0.6        0.63 ± 34%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.89 ± 34%      -0.6        0.32 ± 41%  perf-profile.children.cycles-pp.mix_interrupt_randomness
      0.85 ± 45%      -0.6        0.29 ± 37%  perf-profile.children.cycles-pp.sctp_transport_reset_t3_rtx
      0.82 ± 13%      -0.5        0.28 ± 78%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.82 ± 13%      -0.5        0.28 ± 78%  perf-profile.children.cycles-pp.khugepaged
      0.82 ± 13%      -0.5        0.28 ± 78%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.98 ±  8%      -0.5        0.44 ± 47%  perf-profile.children.cycles-pp.next_uptodate_folio
      1.45 ± 11%      -0.5        0.92 ± 28%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.80 ± 13%      -0.5        0.28 ± 78%  perf-profile.children.cycles-pp.collapse_huge_page
      0.74 ± 44%      -0.5        0.23 ± 17%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.71 ± 37%      -0.5        0.20 ± 52%  perf-profile.children.cycles-pp.perf_evsel__read
      0.65 ± 17%      -0.5        0.15 ± 43%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      2.21 ±  3%      -0.5        1.71 ± 23%  perf-profile.children.cycles-pp.sctp_primitive_SEND
      0.80 ± 24%      -0.5        0.31 ± 28%  perf-profile.children.cycles-pp.get_nohz_timer_target
      1.25 ± 10%      -0.5        0.77 ± 29%  perf-profile.children.cycles-pp.walk_component
      1.50 ± 11%      -0.5        1.02 ± 11%  perf-profile.children.cycles-pp.sctp_skb_recv_datagram
      0.71 ± 15%      -0.5        0.24 ± 82%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      1.12 ± 20%      -0.5        0.65 ± 27%  perf-profile.children.cycles-pp.unmap_vmas
      0.92 ± 15%      -0.5        0.46 ± 21%  perf-profile.children.cycles-pp.__mmap
      0.99 ± 26%      -0.5        0.53 ± 16%  perf-profile.children.cycles-pp.schedule_idle
      1.59 ±  4%      -0.4        1.14 ± 13%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.05 ± 22%      -0.4        0.60 ± 38%  perf-profile.children.cycles-pp.zap_pmd_range
      1.05 ± 22%      -0.4        0.60 ± 38%  perf-profile.children.cycles-pp.zap_pte_range
      1.07 ± 23%      -0.4        0.63 ± 31%  perf-profile.children.cycles-pp.unmap_page_range
      0.83 ± 10%      -0.4        0.39 ± 42%  perf-profile.children.cycles-pp.update_rq_clock
      0.89 ±  9%      -0.4        0.49 ± 33%  perf-profile.children.cycles-pp.__lookup_slow
      0.71 ± 32%      -0.4        0.32 ± 19%  perf-profile.children.cycles-pp.sctp_generate_timeout_event
      0.54 ± 18%      -0.4        0.15 ± 30%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.38 ±  4%      -0.4        1.00 ± 20%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      0.98 ± 17%      -0.4        0.61 ± 19%  perf-profile.children.cycles-pp.__open64_nocancel
      0.53 ± 16%      -0.4        0.17 ± 80%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.49 ± 22%      -0.4        0.14 ± 40%  perf-profile.children.cycles-pp.timekeeping_advance
      0.49 ± 22%      -0.4        0.14 ± 40%  perf-profile.children.cycles-pp.update_wall_time
      1.23 ± 12%      -0.3        0.89 ± 24%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.43 ± 19%      -0.3        0.09 ± 78%  perf-profile.children.cycles-pp.wait4
      0.56 ± 20%      -0.3        0.23 ± 31%  perf-profile.children.cycles-pp.perf_read
      0.53 ± 26%      -0.3        0.21 ± 27%  perf-profile.children.cycles-pp.alloc_bprm
      0.85 ± 24%      -0.3        0.52 ± 20%  perf-profile.children.cycles-pp.proc_reg_read_iter
      1.23 ± 12%      -0.3        0.91 ± 21%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.62 ± 12%      -0.3        0.30 ± 52%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.58 ± 14%      -0.3        0.26 ± 22%  perf-profile.children.cycles-pp.acpi_ev_sci_xrupt_handler
      0.58 ± 14%      -0.3        0.26 ± 22%  perf-profile.children.cycles-pp.acpi_irq
      0.58 ± 14%      -0.3        0.26 ± 22%  perf-profile.children.cycles-pp.irq_thread
      0.58 ± 14%      -0.3        0.26 ± 22%  perf-profile.children.cycles-pp.irq_thread_fn
      0.62 ± 28%      -0.3        0.31 ± 12%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.62 ± 28%      -0.3        0.31 ± 33%  perf-profile.children.cycles-pp.do_anonymous_page
      0.51 ± 16%      -0.3        0.20 ± 28%  perf-profile.children.cycles-pp.set_pte_range
      0.47 ± 22%      -0.3        0.16 ± 41%  perf-profile.children.cycles-pp.vsnprintf
      0.38 ± 33%      -0.3        0.06 ± 19%  perf-profile.children.cycles-pp.prep_compound_page
      0.76 ± 14%      -0.3        0.45 ± 35%  perf-profile.children.cycles-pp.__slab_free
      0.56 ± 43%      -0.3        0.25 ± 29%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.56 ± 11%      -0.3        0.25 ± 29%  perf-profile.children.cycles-pp.acpi_ev_detect_gpe
      0.56 ± 11%      -0.3        0.25 ± 29%  perf-profile.children.cycles-pp.acpi_ev_gpe_detect
      0.56 ± 43%      -0.3        0.25 ± 29%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.96 ± 12%      -0.3        0.66 ± 24%  perf-profile.children.cycles-pp.sctp_make_datafrag_empty
      0.76 ±  4%      -0.3        0.46 ± 26%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.54 ± 41%      -0.3        0.24 ± 46%  perf-profile.children.cycles-pp.___perf_sw_event
      0.60 ± 18%      -0.3        0.31 ± 48%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.40 ± 50%      -0.3        0.11 ± 28%  perf-profile.children.cycles-pp.try_charge_memcg
      0.49 ± 22%      -0.3        0.20 ± 34%  perf-profile.children.cycles-pp.release_pages
      1.03 ± 10%      -0.3        0.74 ± 29%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.94 ±  6%      -0.3        0.65 ± 20%  perf-profile.children.cycles-pp.tick_sched_handle
      0.91 ±  7%      -0.3        0.63 ± 21%  perf-profile.children.cycles-pp.update_process_times
      0.80 ± 17%      -0.3        0.52 ± 19%  perf-profile.children.cycles-pp._Fork
      0.69 ± 19%      -0.3        0.41 ± 29%  perf-profile.children.cycles-pp.pipe_read
      0.47 ± 40%      -0.3        0.19 ± 61%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.91 ±  3%      -0.3        0.64 ± 29%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.53 ±  9%      -0.3        0.26 ± 22%  perf-profile.children.cycles-pp.acpi_os_read_port
      0.58 ± 10%      -0.3        0.31 ± 33%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.40 ± 36%      -0.3        0.14 ± 42%  perf-profile.children.cycles-pp.mas_find
      0.51 ± 16%      -0.3        0.25 ± 29%  perf-profile.children.cycles-pp.acpi_hw_gpe_read
      0.45 ± 37%      -0.3        0.19 ± 52%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.38 ± 33%      -0.3        0.12 ± 36%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.53 ± 46%      -0.3        0.28 ± 20%  perf-profile.children.cycles-pp.dequeue_entity
      0.42 ± 18%      -0.3        0.17 ± 29%  perf-profile.children.cycles-pp.dev_attr_show
      0.33 ± 50%      -0.2        0.08 ± 34%  perf-profile.children.cycles-pp.mas_walk
      0.34 ± 15%      -0.2        0.09 ± 76%  perf-profile.children.cycles-pp.perf_cpu_map__idx
      0.58 ± 24%      -0.2        0.34 ± 40%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.67 ± 23%      -0.2        0.42 ± 11%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.31 ± 26%      -0.2        0.07 ± 71%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.31 ± 26%      -0.2        0.07 ± 71%  perf-profile.children.cycles-pp.do_wait
      0.31 ± 26%      -0.2        0.07 ± 71%  perf-profile.children.cycles-pp.kernel_wait4
      0.42 ± 18%      -0.2        0.18 ± 26%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.67 ± 33%      -0.2        0.43 ± 24%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.60 ± 14%      -0.2        0.37 ±  6%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.33 ± 31%      -0.2        0.10 ± 75%  perf-profile.children.cycles-pp.__d_alloc
      0.56 ±  5%      -0.2        0.33 ± 33%  perf-profile.children.cycles-pp.show_stat
      0.45 ± 46%      -0.2        0.23 ± 17%  perf-profile.children.cycles-pp.dput
      0.49 ±  5%      -0.2        0.27 ± 41%  perf-profile.children.cycles-pp.d_alloc
      0.33 ± 28%      -0.2        0.11 ± 72%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.54 ± 26%      -0.2        0.32 ± 27%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.45 ± 37%      -0.2        0.23 ±  6%  perf-profile.children.cycles-pp.vmstat_start
      0.29 ± 28%      -0.2        0.07 ± 71%  perf-profile.children.cycles-pp.sched_exec
      0.67 ±  7%      -0.2        0.45 ± 29%  perf-profile.children.cycles-pp.__wake_up_common
      0.36 ± 38%      -0.2        0.15 ± 30%  perf-profile.children.cycles-pp.__dentry_kill
      0.36 ±  7%      -0.2        0.15 ± 28%  perf-profile.children.cycles-pp.mm_init
      0.83 ± 10%      -0.2        0.61 ± 17%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.51 ± 21%      -0.2        0.30 ±  5%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.51 ± 21%      -0.2        0.30 ±  5%  perf-profile.children.cycles-pp.find_idlest_group
      0.36 ± 21%      -0.2        0.15 ± 46%  perf-profile.children.cycles-pp.__perf_sw_event
      0.31 ± 26%      -0.2        0.10 ± 75%  perf-profile.children.cycles-pp.wakeup_preempt
      0.40 ± 47%      -0.2        0.19 ± 61%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.33 ± 15%      -0.2        0.12 ± 43%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.29 ± 48%      -0.2        0.09 ± 33%  perf-profile.children.cycles-pp.malloc
      0.29 ± 11%      -0.2        0.09 ± 83%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.45 ± 17%      -0.2        0.25 ± 56%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.60 ± 27%      -0.2        0.40 ± 15%  perf-profile.children.cycles-pp.idle_cpu
      0.29 ± 61%      -0.2        0.09 ± 55%  perf-profile.children.cycles-pp.update_curr
      0.24 ± 34%      -0.2        0.04 ± 76%  perf-profile.children.cycles-pp.__get_user_pages
      0.24 ± 34%      -0.2        0.04 ± 76%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.56 ±  5%      -0.2        0.36 ± 33%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.27 ± 21%      -0.2        0.08 ± 79%  perf-profile.children.cycles-pp.pcpu_alloc
      0.53 ± 27%      -0.2        0.34 ± 14%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.29 ± 48%      -0.2        0.10 ± 39%  perf-profile.children.cycles-pp.prepare_task_switch
      0.49 ± 25%      -0.2        0.30 ±  5%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.38 ± 47%      -0.2        0.19 ± 61%  perf-profile.children.cycles-pp.move_queued_task
      0.42 ±  6%      -0.2        0.23 ± 38%  perf-profile.children.cycles-pp.acpi_ps_parse_loop
      0.25 ± 26%      -0.2        0.06 ± 72%  perf-profile.children.cycles-pp.mas_next_slot
      0.53 ± 10%      -0.2        0.35 ± 23%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.24 ± 66%      -0.2        0.06 ± 86%  perf-profile.children.cycles-pp.copy_string_kernel
      0.22 ± 78%      -0.2        0.04 ± 71%  perf-profile.children.cycles-pp._compound_head
      0.38 ± 21%      -0.2        0.20 ± 35%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.25 ± 35%      -0.2        0.06 ± 71%  perf-profile.children.cycles-pp.__do_wait
      0.73 ± 14%      -0.2        0.56 ± 25%  perf-profile.children.cycles-pp.try_to_wake_up
      0.40 ± 12%      -0.2        0.23 ±  8%  perf-profile.children.cycles-pp.mod_objcg_state
      0.42 ± 26%      -0.2        0.25 ± 34%  perf-profile.children.cycles-pp.alloc_empty_file
      0.65 ±  4%      -0.2        0.47 ± 23%  perf-profile.children.cycles-pp.begin_new_exec
      0.74 ± 13%      -0.2        0.57 ± 27%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.33 ± 26%      -0.2        0.17 ± 14%  perf-profile.children.cycles-pp.vma_complete
      0.33 ± 15%      -0.2        0.17 ± 20%  perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      0.33 ± 15%      -0.2        0.17 ± 20%  perf-profile.children.cycles-pp.__sk_mem_schedule
      0.44 ±  6%      -0.2        0.28 ± 33%  perf-profile.children.cycles-pp.acpi_ps_parse_aml
      0.27            -0.2        0.11 ± 26%  perf-profile.children.cycles-pp.seq_printf
      0.22 ± 39%      -0.2        0.06 ± 71%  perf-profile.children.cycles-pp.release_task
      0.22 ± 39%      -0.2        0.06 ± 71%  perf-profile.children.cycles-pp.wait_task_zombie
      0.27 ± 19%      -0.2        0.11 ± 28%  perf-profile.children.cycles-pp.__call_rcu_common
      0.56 ± 14%      -0.2        0.40 ± 16%  perf-profile.children.cycles-pp.exec_mmap
      0.29 ± 60%      -0.2        0.13 ± 34%  perf-profile.children.cycles-pp.vma_modify
      0.22 ± 57%      -0.2        0.06 ± 71%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.40 ± 13%      -0.2        0.25 ± 37%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.44 ±  6%      -0.2        0.29 ± 27%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.44 ±  6%      -0.2        0.29 ± 27%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.44 ±  6%      -0.2        0.29 ± 27%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.44 ±  6%      -0.2        0.29 ± 27%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.31 ± 19%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.20 ± 28%      -0.1        0.05 ± 77%  perf-profile.children.cycles-pp.get_unmapped_area
      0.20 ± 28%      -0.1        0.06 ± 86%  perf-profile.children.cycles-pp.__copy_skb_header
      0.51 ± 26%      -0.1        0.37 ± 23%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.20 ± 46%      -0.1        0.06 ± 81%  perf-profile.children.cycles-pp.copy_p4d_range
      0.20 ± 46%      -0.1        0.06 ± 81%  perf-profile.children.cycles-pp.copy_page_range
      0.20 ± 28%      -0.1        0.06 ± 86%  perf-profile.children.cycles-pp.dyntick_save_progress_counter
      0.24 ± 25%      -0.1        0.10 ± 70%  perf-profile.children.cycles-pp.flush_tlb_func
      0.20 ± 28%      -0.1        0.06 ± 81%  perf-profile.children.cycles-pp.timer_delete
      0.40 ± 13%      -0.1        0.27 ± 24%  perf-profile.children.cycles-pp.finish_task_switch
      0.36 ± 21%      -0.1        0.22 ± 21%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.29 ± 28%      -0.1        0.16 ± 23%  perf-profile.children.cycles-pp.__d_add
      0.29 ± 28%      -0.1        0.16 ± 23%  perf-profile.children.cycles-pp.simple_lookup
      0.20 ± 28%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.node_read_numastat
      0.31 ±  9%      -0.1        0.19 ± 14%  perf-profile.children.cycles-pp.devkmsg_read
      0.22 ± 29%      -0.1        0.10 ± 84%  perf-profile.children.cycles-pp.init_file
      0.24 ± 25%      -0.1        0.12 ± 24%  perf-profile.children.cycles-pp.force_qs_rnp
      0.20 ± 28%      -0.1        0.08 ± 40%  perf-profile.children.cycles-pp.skb_copy_header
      0.22 ± 39%      -0.1        0.10 ± 45%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.32 ± 10%      -0.1        0.20 ± 18%  perf-profile.children.cycles-pp.perf_mmap__push
      0.32 ± 10%      -0.1        0.20 ± 18%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.27 ± 21%      -0.1        0.15 ± 16%  perf-profile.children.cycles-pp.printk_get_next_message
      0.22 ± 14%      -0.1        0.11 ± 39%  perf-profile.children.cycles-pp._copy_from_user
      0.25 ± 26%      -0.1        0.13 ± 34%  perf-profile.children.cycles-pp.__do_fault
      0.24 ± 47%      -0.1        0.13 ± 19%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.20 ± 49%      -0.1        0.09 ± 33%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.22 ± 14%      -0.1        0.11 ± 26%  perf-profile.children.cycles-pp.loopback_xmit
      0.16 ± 39%      -0.1        0.05 ± 78%  perf-profile.children.cycles-pp.generic_permission
      0.22 ± 29%      -0.1        0.12 ± 26%  perf-profile.children.cycles-pp.smp_call_function_single
      0.20 ± 28%      -0.1        0.09 ± 83%  perf-profile.children.cycles-pp.getenv
      0.25 ± 13%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.29 ± 28%      -0.1        0.18 ± 21%  perf-profile.children.cycles-pp.sctp_data_ready
      0.27 ± 19%      -0.1        0.16 ± 31%  perf-profile.children.cycles-pp.acpi_ds_exec_end_op
      0.18 ± 18%      -0.1        0.07 ± 89%  perf-profile.children.cycles-pp.security_file_alloc
      0.22 ± 14%      -0.1        0.12 ± 43%  perf-profile.children.cycles-pp.map_vdso
      0.16 ± 53%      -0.1        0.06 ± 86%  perf-profile.children.cycles-pp.do_brk_flags
      0.54            -0.1        0.44 ± 20%  perf-profile.children.cycles-pp.__do_sys_clone
      0.16 ± 39%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.__close_nocancel
      0.29 ± 21%      -0.1        0.20 ± 27%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.16 ± 39%      -0.1        0.07 ± 88%  perf-profile.children.cycles-pp.task_work_run
      0.25 ± 13%      -0.1        0.16 ± 31%  perf-profile.children.cycles-pp.fstatat64
      0.13 ± 39%      -0.1        0.05 ± 78%  perf-profile.children.cycles-pp.error_entry
      0.18 ± 18%      -0.1        0.09 ± 55%  perf-profile.children.cycles-pp.__fput
      0.22 ± 14%      -0.1        0.14 ± 32%  perf-profile.children.cycles-pp.slab_show
      0.13            -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.clock_gettime
      0.25 ± 13%      -0.1        0.16 ± 18%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.13            -0.1        0.05 ± 78%  perf-profile.children.cycles-pp.irq_get_next_irq
      0.22 ± 14%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.record__pushfn
      0.15 ± 21%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      0.13 ± 39%      -0.1        0.05 ± 77%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.18 ± 18%      -0.1        0.10 ± 45%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.20 ± 28%      -0.1        0.13 ± 19%  perf-profile.children.cycles-pp.open_last_lookups
      0.13 ± 39%      -0.1        0.06 ± 81%  perf-profile.children.cycles-pp.mutex_unlock
      0.20            -0.1        0.13 ± 31%  perf-profile.children.cycles-pp.mas_split
      0.11 ± 25%      -0.1        0.04 ± 76%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.13 ± 39%      -0.1        0.08 ± 40%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ± 25%      -0.1        0.05 ± 77%  perf-profile.children.cycles-pp.__count_memcg_events
      0.18 ± 18%      -0.1        0.12 ± 43%  perf-profile.children.cycles-pp.__install_special_mapping
      0.13            -0.0        0.08 ± 34%  perf-profile.children.cycles-pp.format_decode
      0.11 ± 25%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.d_path
      0.07            -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.copy_page
      0.09 ± 31%      +0.1        0.15 ± 30%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.get_cpu_device
      0.02 ±141%      +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.02 ±141%      +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.__ctype_init
      0.02 ±141%      +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.__sysconf
      0.02 ±141%      +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.02 ±141%      +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.remove_vm_area
      0.02 ±141%      +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.vfree
      0.09 ± 70%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.09 ± 31%      +0.1        0.19 ± 37%  perf-profile.children.cycles-pp.sctp_sf_eat_data_6_2
      0.11 ± 75%      +0.1        0.22 ±  7%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.36 ±  8%      +0.1        0.47 ± 17%  perf-profile.children.cycles-pp.sched_clock
      0.07 ± 79%      +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.13 ± 31%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.05 ± 70%      +0.1        0.19 ± 39%  perf-profile.children.cycles-pp.free_large_kmalloc
      0.13 ± 39%      +0.2        0.29 ± 39%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.2        0.17 ± 10%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      0.00            +0.2        0.19 ± 39%  perf-profile.children.cycles-pp.timerqueue_add
      0.31 ± 36%      +0.2        0.54 ±  8%  perf-profile.children.cycles-pp.free_one_page
      0.18 ± 37%      +0.3        0.46 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.42 ±  7%      +0.3        0.71 ± 12%  perf-profile.children.cycles-pp.native_sched_clock
      0.04 ±141%      +0.3        0.36 ±  8%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.13 ± 39%      +0.3        0.48 ± 13%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.4        0.40 ± 22%  perf-profile.children.cycles-pp.tmigr_update_events
      0.00            +0.4        0.43 ±  4%  perf-profile.children.cycles-pp.timer_expire_remote
      0.00            +1.2        1.16 ± 16%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      0.00            +1.2        1.18 ± 15%  perf-profile.children.cycles-pp.tmigr_handle_remote
      1.34 ± 11%      +1.2        2.57 ± 25%  perf-profile.children.cycles-pp.run_ksoftirqd
     39.09 ±  3%     +20.1       59.15 ± 10%  perf-profile.children.cycles-pp.start_secondary
     41.77 ±  3%     +20.8       62.58 ± 11%  perf-profile.children.cycles-pp.do_idle
     41.77 ±  3%     +20.8       62.59 ± 11%  perf-profile.children.cycles-pp.cpu_startup_entry
     41.77 ±  3%     +20.8       62.59 ± 11%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     35.19 ±  4%     +25.1       60.25 ± 12%  perf-profile.children.cycles-pp.cpuidle_idle_call
     32.56 ±  3%     +25.4       57.97 ± 13%  perf-profile.children.cycles-pp.cpuidle_enter_state
     32.60 ±  3%     +25.5       58.05 ± 13%  perf-profile.children.cycles-pp.cpuidle_enter
      0.00           +36.6       36.62 ± 31%  perf-profile.children.cycles-pp.poll_idle
      8.57 ±  7%      -2.2        6.32 ± 23%  perf-profile.self.cycles-pp.acpi_safe_halt
      4.19 ± 11%      -2.0        2.19 ± 14%  perf-profile.self.cycles-pp._copy_from_iter
      7.61 ±  5%      -2.0        5.65 ±  9%  perf-profile.self.cycles-pp.__memcpy
      4.35            -1.7        2.61 ± 26%  perf-profile.self.cycles-pp._copy_to_iter
      2.99 ± 21%      -1.7        1.31 ± 24%  perf-profile.self.cycles-pp._raw_spin_lock
      2.57 ±  7%      -0.8        1.74 ± 23%  perf-profile.self.cycles-pp.update_sg_lb_stats
      1.16 ± 21%      -0.7        0.50 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      3.33 ±  4%      -0.6        2.71 ± 15%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.03 ± 43%      -0.6        0.44 ± 30%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.65 ± 20%      -0.5        0.19 ± 55%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.80 ±  6%      -0.4        0.38 ± 42%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.72 ± 36%      -0.4        0.31 ± 30%  perf-profile.self.cycles-pp.filemap_map_pages
      0.53 ± 16%      -0.4        0.17 ± 80%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.49 ± 46%      -0.3        0.18 ± 89%  perf-profile.self.cycles-pp.___perf_sw_event
      0.38 ± 33%      -0.3        0.06 ± 19%  perf-profile.self.cycles-pp.prep_compound_page
      0.56 ± 15%      -0.3        0.26 ± 29%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.58 ± 29%      -0.3        0.28 ± 11%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.53 ± 10%      -0.3        0.24 ± 41%  perf-profile.self.cycles-pp.update_rq_clock
      0.74 ± 12%      -0.3        0.45 ± 35%  perf-profile.self.cycles-pp.__slab_free
      0.42 ± 37%      -0.3        0.13 ± 23%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.60 ± 27%      -0.3        0.32 ± 19%  perf-profile.self.cycles-pp.idle_cpu
      0.53 ±  9%      -0.3        0.26 ± 22%  perf-profile.self.cycles-pp.acpi_os_read_port
      0.33 ± 50%      -0.2        0.08 ± 34%  perf-profile.self.cycles-pp.mas_walk
      0.65 ± 20%      -0.2        0.41 ± 18%  perf-profile.self.cycles-pp.cpu_util
      0.29 ± 48%      -0.2        0.06 ± 86%  perf-profile.self.cycles-pp.need_update
      0.36 ±  8%      -0.2        0.13 ± 19%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.83 ± 10%      -0.2        0.61 ± 17%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.27 ± 35%      -0.2        0.05 ± 77%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.49 ± 34%      -0.2        0.28 ± 25%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.31 ± 26%      -0.2        0.12 ± 43%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.25 ± 13%      -0.2        0.07 ± 95%  perf-profile.self.cycles-pp.do_syscall_64
      0.36 ± 17%      -0.2        0.18 ± 26%  perf-profile.self.cycles-pp.mod_objcg_state
      0.36 ± 23%      -0.2        0.19 ±  4%  perf-profile.self.cycles-pp.__free_pages_ok
      0.25 ± 35%      -0.2        0.08 ± 40%  perf-profile.self.cycles-pp.timekeeping_advance
      0.40 ± 35%      -0.2        0.24        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.22 ± 29%      -0.2        0.07 ± 71%  perf-profile.self.cycles-pp.perf_cpu_map__idx
      0.22 ± 57%      -0.1        0.07 ± 23%  perf-profile.self.cycles-pp.evlist_cpu_iterator__next
      0.20 ± 28%      -0.1        0.06 ± 86%  perf-profile.self.cycles-pp.__copy_skb_header
      0.20 ± 28%      -0.1        0.06 ± 86%  perf-profile.self.cycles-pp.dyntick_save_progress_counter
      0.20 ± 49%      -0.1        0.08 ± 40%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.22 ± 39%      -0.1        0.11 ± 28%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.22 ± 14%      -0.1        0.11 ± 39%  perf-profile.self.cycles-pp._copy_from_user
      0.20 ± 49%      -0.1        0.09 ± 33%  perf-profile.self.cycles-pp.malloc
      0.16 ± 53%      -0.1        0.04 ± 76%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.15 ± 21%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.16 ± 53%      -0.1        0.05 ± 77%  perf-profile.self.cycles-pp.vsnprintf
      0.22 ± 14%      -0.1        0.13 ± 34%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.13 ± 39%      -0.1        0.04 ± 76%  perf-profile.self.cycles-pp.__put_user_8
      0.16 ± 39%      -0.1        0.07 ± 88%  perf-profile.self.cycles-pp.set_pte_range
      0.13 ± 39%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.error_entry
      0.15 ± 21%      -0.1        0.07 ± 71%  perf-profile.self.cycles-pp.check_heap_object
      0.18 ± 18%      -0.1        0.10 ± 45%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.11 ± 54%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.tick_do_update_jiffies64
      0.13 ± 39%      -0.1        0.06 ± 81%  perf-profile.self.cycles-pp.mutex_unlock
      0.18 ± 18%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.read_counters
      0.15 ± 21%      -0.1        0.10 ± 34%  perf-profile.self.cycles-pp.sctp_chunk_put
      0.09 ± 31%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.irq_get_next_irq
      0.07            -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.copy_page
      0.07            +0.0        0.12 ± 24%  perf-profile.self.cycles-pp.mas_preallocate
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.11 ± 51%  perf-profile.self.cycles-pp.timerqueue_add
      0.13 ± 39%      +0.2        0.33 ± 15%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.38 ± 21%      +0.3        0.71 ± 12%  perf-profile.self.cycles-pp.native_sched_clock
      0.00           +35.9       35.94 ± 31%  perf-profile.self.cycles-pp.poll_idle



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf

commit: 
  57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
  7ee9887703 ("timers: Implement the hierarchical pull model")

57e95a5c4117dc6a 7ee988770326fca440472200c3e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5232            +6.8%       5589        vmstat.system.in
      0.03            +0.0        0.04        mpstat.cpu.all.soft%
      0.04            +0.0        0.08        mpstat.cpu.all.sys%
    201.33 ±  3%     -34.1%     132.67 ±  7%  perf-c2c.DRAM.remote
    187.83 ±  3%     -28.7%     133.83 ± 12%  perf-c2c.HITM.local
     40.67 ±  7%     -57.4%      17.33 ± 26%  perf-c2c.HITM.remote
      4984            +4.9%       5227        proc-vmstat.nr_shmem
    100999            +3.6%     104640        proc-vmstat.nr_slab_unreclaimable
      8114 ±  2%     +11.0%       9005 ±  2%  proc-vmstat.pgactivate
     20.00         +1907.5%     401.50 ± 79%  proc-vmstat.unevictable_pgs_culled
    965754           -10.3%     866147        sched_debug.cpu.avg_idle.avg
    101797 ± 12%     +41.8%     144376 ±  4%  sched_debug.cpu.avg_idle.stddev
      0.00 ± 22%     -40.7%       0.00 ± 18%  sched_debug.cpu.next_balance.stddev
    886.06 ± 18%    +339.7%       3895 ±  8%  sched_debug.cpu.nr_switches.min
      5474 ± 12%     -23.9%       4164 ± 10%  sched_debug.cpu.nr_switches.stddev
      4.10            -1.2%       4.05        netperf.ThroughputBoth_Mbps
      1049            -1.2%       1037        netperf.ThroughputBoth_total_Mbps
      4.10            -1.2%       4.05        netperf.Throughput_Mbps
      1049            -1.2%       1037        netperf.Throughput_total_Mbps
    102.17 ±  8%    +887.4%       1008 ±  3%  netperf.time.involuntary_context_switches
      2.07 ±  3%    +388.2%      10.11        netperf.time.system_time
     15.14           +18.8%      17.99        perf-stat.i.MPKI
 1.702e+08            +1.6%  1.729e+08        perf-stat.i.branch-instructions
      1.68            +0.0        1.71        perf-stat.i.branch-miss-rate%
     18.46            +3.1       21.57        perf-stat.i.cache-miss-rate%
   4047319           +19.7%    4846291        perf-stat.i.cache-misses
  22007366            +3.2%   22707969        perf-stat.i.cache-references
      1.84           +17.0%       2.15        perf-stat.i.cpi
 9.159e+08           +10.4%  1.011e+09        perf-stat.i.cpu-cycles
    161.08          +183.7%     456.91 ±  2%  perf-stat.i.cpu-migrations
    190.71            -1.6%     187.66        perf-stat.i.cycles-between-cache-misses
 8.434e+08            +1.2%  8.535e+08        perf-stat.i.instructions
      0.61           -10.6%       0.54        perf-stat.i.ipc
      4.79           +18.4%       5.66        perf-stat.overall.MPKI
      4.21            -0.1        4.14        perf-stat.overall.branch-miss-rate%
     18.39            +2.9       21.33        perf-stat.overall.cache-miss-rate%
      1.09            +9.1%       1.19        perf-stat.overall.cpi
    227.07            -7.8%     209.29        perf-stat.overall.cycles-between-cache-misses
      0.92            -8.3%       0.84        perf-stat.overall.ipc
   1379820            +2.3%    1411871        perf-stat.overall.path-length
 1.702e+08            +1.5%  1.728e+08        perf-stat.ps.branch-instructions
   4035389           +19.7%    4830446        perf-stat.ps.cache-misses
  21948285            +3.2%   22642774        perf-stat.ps.cache-references
 9.163e+08           +10.3%  1.011e+09        perf-stat.ps.cpu-cycles
    160.61          +183.5%     455.30 ±  2%  perf-stat.ps.cpu-migrations
 8.433e+08            +1.1%  8.529e+08        perf-stat.ps.instructions
 2.551e+11            +1.5%  2.589e+11        perf-stat.total.instructions
     31.82 ±  3%     -12.9       18.91 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     36.90 ±  2%     -12.1       24.83 ±  7%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     27.61 ±  3%     -11.9       15.68 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
     31.75 ±  2%     -11.5       20.25 ±  8%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     24.39 ±  3%     -10.0       14.38 ±  8%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
     24.33 ±  3%     -10.0       14.36 ±  8%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
     21.00 ±  3%      -9.2       11.84 ±  9%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     20.97 ±  3%      -9.1       11.83 ±  9%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu
     20.97 ±  3%      -9.1       11.84 ±  9%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      4.92 ± 10%      -4.0        0.91 ± 28%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.81 ± 13%      -1.5        0.29 ±100%  perf-profile.calltrace.cycles-pp.run_timer_softirq.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      9.76 ±  7%      -1.5        8.26 ±  8%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      5.08 ±  7%      -1.0        4.12 ± 12%  perf-profile.calltrace.cycles-pp.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      2.99 ±  4%      -0.8        2.22 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.98 ±  4%      -0.8        2.22 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.66 ±  7%      -0.7        0.95 ± 11%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      1.58 ±  5%      -0.7        0.90 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.05 ±  9%      -0.5        0.52 ± 49%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_generate_timeout_event.call_timer_fn.__run_timers
      0.95 ± 14%      -0.5        0.50 ± 46%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.90 ± 14%      -0.4        0.53 ± 47%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.90 ± 14%      -0.4        0.52 ± 47%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.64 ± 17%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ± 17%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.96 ±  8%      -0.3        0.65 ± 45%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96 ±  8%      -0.3        0.64 ± 45%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96 ±  8%      -0.3        0.65 ± 45%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.53 ±  4%      -0.3        1.22 ± 12%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.53 ±  4%      -0.3        1.24 ± 12%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.62 ±  4%      -0.3        1.33 ± 12%  perf-profile.calltrace.cycles-pp.read
      1.57 ±  5%      -0.3        1.28 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.57 ±  5%      -0.3        1.28 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.23 ±  8%      -0.2        1.03 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.50 ± 45%      +0.4        0.92 ± 14%  perf-profile.calltrace.cycles-pp.rebalance_domains._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single
      0.45 ± 72%      +0.5        0.95 ± 17%  perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.75 ± 46%      +0.5        1.26 ± 24%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg
      0.82 ± 45%      +0.5        1.36 ± 22%  perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg
      1.08 ± 12%      +0.6        1.68 ± 14%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.08 ± 12%      +0.6        1.68 ± 14%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      1.08 ± 12%      +0.6        1.68 ± 14%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.18 ±141%      +0.6        0.83 ± 14%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains._nohz_idle_balance.__do_softirq.irq_exit_rcu
      0.00            +0.7        0.66 ± 18%  perf-profile.calltrace.cycles-pp.sctp_generate_timeout_event.call_timer_fn.__run_timers.timer_expire_remote.tmigr_handle_remote_up
      0.30 ±101%      +0.7        0.97 ± 28%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put.sctp_ulpevent_free
      0.00            +0.8        0.77 ± 18%  perf-profile.calltrace.cycles-pp.call_timer_fn.__run_timers.timer_expire_remote.tmigr_handle_remote_up.tmigr_handle_remote
      0.00            +0.8        0.80 ± 17%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put.sctp_datamsg_put
      3.45 ± 14%      +0.8        4.26 ± 11%  perf-profile.calltrace.cycles-pp.__memcpy.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data
      3.46 ± 14%      +0.8        4.28 ± 10%  perf-profile.calltrace.cycles-pp.skb_copy_bits.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter
      0.00            +0.8        0.82 ± 18%  perf-profile.calltrace.cycles-pp.__run_timers.timer_expire_remote.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq
      0.00            +0.8        0.83 ± 17%  perf-profile.calltrace.cycles-pp.timer_expire_remote.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu
      0.00            +0.8        0.84 ± 31%  perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.skb_release_data.consume_skb.sctp_chunk_put
      4.44 ± 14%      +0.9        5.36 ± 10%  perf-profile.calltrace.cycles-pp.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      0.00            +0.9        0.94 ± 16%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.sctp_chunk_put.sctp_datamsg_put.sctp_chunk_free
      4.33 ± 14%      +0.9        5.27 ± 10%  perf-profile.calltrace.cycles-pp.skb_copy.sctp_make_reassembled_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      2.42 ±  9%      +1.1        3.56 ± 17%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
      2.41 ±  9%      +1.1        3.55 ± 17%  perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      2.42 ±  9%      +1.2        3.58 ± 17%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit
      2.34 ± 10%      +1.2        3.50 ± 17%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      2.56 ±  8%      +1.2        3.74 ± 17%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
      1.72 ± 15%      +1.2        2.91 ± 19%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase
      1.76 ± 14%      +1.2        2.97 ± 18%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free
      1.88 ± 13%      +1.2        3.10 ± 18%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg
      2.34 ±  9%      +1.2        3.57 ± 19%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
      2.34 ± 10%      +1.2        3.57 ± 19%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
      1.98 ± 13%      +1.3        3.23 ± 19%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg
      2.23 ± 10%      +1.3        3.50 ± 19%  perf-profile.calltrace.cycles-pp.sctp_assoc_rwnd_increase.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +1.4        1.37 ±  9%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote_up.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.4        1.38 ± 10%  perf-profile.calltrace.cycles-pp.tmigr_handle_remote.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.52 ±  7%      +1.8        5.30 ± 15%  perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      4.94 ±  5%      +5.6       10.58 ± 16%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      4.94 ±  5%      +5.6       10.58 ± 16%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      4.94 ±  5%      +5.6       10.58 ± 16%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.83 ±  9%      +5.9        8.73 ± 18%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.73 ± 12%      +6.2        7.93 ± 18%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.73 ± 12%      +6.2        7.93 ± 18%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.70 ± 13%      +6.2        7.91 ± 18%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd
      1.70 ± 13%      +6.2        7.91 ± 18%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      1.70 ± 12%      +6.2        7.92 ± 18%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      0.00           +10.2       10.24 ± 89%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     36.91 ±  2%     -12.1       24.83 ±  7%  perf-profile.children.cycles-pp.acpi_idle_enter
     36.80 ±  2%     -12.0       24.80 ±  7%  perf-profile.children.cycles-pp.acpi_safe_halt
     29.95 ±  3%     -11.8       18.19 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     27.78 ±  3%     -11.4       16.39 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     25.75 ±  2%      -9.1       16.65 ±  9%  perf-profile.children.cycles-pp.irq_exit_rcu
      5.07 ±  3%      -3.4        1.71 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock
      6.04 ±  8%      -3.3        2.70 ± 17%  perf-profile.children.cycles-pp._nohz_idle_balance
      2.80 ±  6%      -2.3        0.51 ± 31%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.83 ± 13%      -1.3        0.51 ± 30%  perf-profile.children.cycles-pp.run_timer_softirq
      5.62 ±  5%      -1.1        4.52 ± 10%  perf-profile.children.cycles-pp.sctp_outq_flush_data
      1.40 ± 13%      -1.0        0.38 ± 25%  perf-profile.children.cycles-pp.tick_irq_enter
      1.44 ± 13%      -1.0        0.44 ± 18%  perf-profile.children.cycles-pp.irq_enter_rcu
      1.77 ± 11%      -1.0        0.78 ± 20%  perf-profile.children.cycles-pp.__mod_timer
      1.36 ± 15%      -0.9        0.48 ± 24%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.97 ± 15%      -0.9        0.10 ± 38%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      1.46 ± 11%      -0.9        0.60 ± 23%  perf-profile.children.cycles-pp.sctp_transport_reset_t3_rtx
      1.53 ±  7%      -0.6        0.92 ± 21%  perf-profile.children.cycles-pp.update_blocked_averages
      1.00 ± 27%      -0.5        0.45 ± 32%  perf-profile.children.cycles-pp.update_rq_clock_task
      1.73 ±  7%      -0.5        1.21 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.65 ±  5%      -0.5        1.14 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.94 ±  6%      -0.4        1.56 ± 13%  perf-profile.children.cycles-pp.vfs_read
      1.16 ± 10%      -0.3        0.84 ± 19%  perf-profile.children.cycles-pp.sctp_generate_timeout_event
      0.66 ± 12%      -0.3        0.37 ± 17%  perf-profile.children.cycles-pp.update_rq_clock
      0.99 ±  8%      -0.3        0.73 ± 20%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.99 ±  8%      -0.3        0.73 ± 20%  perf-profile.children.cycles-pp.do_group_exit
      0.99 ±  8%      -0.3        0.73 ± 20%  perf-profile.children.cycles-pp.do_exit
      0.34 ± 17%      -0.2        0.12 ± 46%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.28 ± 23%      -0.2        0.07 ± 83%  perf-profile.children.cycles-pp.__release_sock
      1.24 ±  9%      -0.2        1.03 ± 10%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.54 ± 17%      -0.2        0.33 ± 20%  perf-profile.children.cycles-pp.idle_cpu
      0.30 ± 16%      -0.2        0.10 ± 32%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.09 ±  5%      -0.2        0.88 ± 15%  perf-profile.children.cycles-pp.seq_read_iter
      0.26 ± 26%      -0.2        0.07 ± 83%  perf-profile.children.cycles-pp.sctp_backlog_rcv
      0.35 ± 25%      -0.2        0.15 ± 41%  perf-profile.children.cycles-pp.release_sock
      0.39 ± 19%      -0.2        0.20 ± 11%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.72 ± 13%      -0.2        0.54 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.50 ± 14%      -0.2        0.33 ± 18%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.39 ± 18%      -0.2        0.23 ± 14%  perf-profile.children.cycles-pp.sctp_inq_pop
      0.51 ± 15%      -0.2        0.35 ± 20%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.46 ± 14%      -0.1        0.32 ± 18%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.26 ± 20%      -0.1        0.14 ± 29%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.46 ± 10%      -0.1        0.34 ± 20%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.22 ± 17%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.should_we_balance
      0.21 ± 13%      -0.1        0.10 ± 20%  perf-profile.children.cycles-pp.lookup_fast
      0.36 ± 16%      -0.1        0.25 ± 24%  perf-profile.children.cycles-pp.__split_vma
      0.29 ± 10%      -0.1        0.20 ± 27%  perf-profile.children.cycles-pp.wp_page_copy
      0.54 ± 11%      -0.1        0.45 ±  8%  perf-profile.children.cycles-pp.balance_fair
      0.14 ± 34%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.vma_prepare
      0.21 ± 28%      -0.1        0.13 ± 27%  perf-profile.children.cycles-pp.vsnprintf
      0.14 ± 31%      -0.1        0.05 ± 75%  perf-profile.children.cycles-pp.irqentry_exit
      0.15 ± 17%      -0.1        0.07 ± 45%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.19 ± 19%      -0.1        0.12 ± 21%  perf-profile.children.cycles-pp.__vm_munmap
      0.10 ± 22%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.dev_attr_show
      0.10 ± 22%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.22 ±  8%      -0.0        0.17 ± 17%  perf-profile.children.cycles-pp.diskstats_show
      0.05 ± 72%      +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.__fdget_pos
      0.07 ± 52%      +0.1        0.16 ± 44%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.06 ±106%      +0.1        0.18 ± 32%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.2        0.17 ± 24%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.00            +0.2        0.18 ± 23%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      0.06 ± 23%      +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.2        0.19 ± 19%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.00            +0.2        0.20 ± 20%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.00            +0.4        0.38 ± 17%  perf-profile.children.cycles-pp.tmigr_update_events
      0.07 ± 24%      +0.4        0.49 ± 13%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      2.29 ±  4%      +0.7        3.02 ± 12%  perf-profile.children.cycles-pp.__kmalloc_large_node
      2.32 ±  4%      +0.7        3.05 ± 13%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      2.09 ±  8%      +0.7        2.82 ± 13%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.9        0.86 ± 16%  perf-profile.children.cycles-pp.timer_expire_remote
      1.25 ± 10%      +0.9        2.15 ± 14%  perf-profile.children.cycles-pp.rmqueue
      1.48 ± 14%      +1.0        2.51 ± 13%  perf-profile.children.cycles-pp.__free_pages_ok
      0.58 ± 29%      +1.1        1.66 ± 14%  perf-profile.children.cycles-pp.free_one_page
      3.00 ±  6%      +1.1        4.11 ± 17%  perf-profile.children.cycles-pp.ip_finish_output2
      2.88 ±  6%      +1.1        4.00 ± 17%  perf-profile.children.cycles-pp.__dev_queue_xmit
      2.23 ± 10%      +1.3        3.50 ± 19%  perf-profile.children.cycles-pp.sctp_assoc_rwnd_increase
      0.00            +1.4        1.40 ±  8%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      0.00            +1.4        1.43 ±  9%  perf-profile.children.cycles-pp.tmigr_handle_remote
      2.43 ±  9%      +1.5        3.91 ± 18%  perf-profile.children.cycles-pp.do_softirq
      2.46 ±  9%      +1.5        3.95 ± 18%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      2.16 ±  9%      +1.7        3.87 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.53 ±  7%      +1.8        5.30 ± 14%  perf-profile.children.cycles-pp.sctp_ulpevent_free
      5.02 ±  5%      +5.6       10.65 ± 15%  perf-profile.children.cycles-pp.ret_from_fork_asm
      5.00 ±  4%      +5.6       10.64 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
      4.94 ±  5%      +5.6       10.58 ± 16%  perf-profile.children.cycles-pp.kthread
      2.83 ±  9%      +5.9        8.74 ± 18%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.73 ± 12%      +6.2        7.93 ± 18%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.02 ±141%     +10.3       10.31 ± 88%  perf-profile.children.cycles-pp.poll_idle
      2.41 ±  5%      -1.1        1.32 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
      1.11 ± 19%      -0.7        0.37 ± 20%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.84 ± 28%      -0.5        0.34 ± 30%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.65 ± 23%      -0.5        0.16 ± 34%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.29 ± 16%      -0.2        0.07 ± 62%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.52 ± 19%      -0.2        0.31 ± 21%  perf-profile.self.cycles-pp.idle_cpu
      0.43 ±  9%      -0.2        0.23 ± 23%  perf-profile.self.cycles-pp.update_rq_clock
      0.25 ± 28%      -0.1        0.12 ± 50%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.16 ± 34%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.need_update
      0.16 ± 32%      -0.1        0.06 ± 80%  perf-profile.self.cycles-pp.call_cpuidle
      0.12 ± 19%      -0.1        0.04 ±101%  perf-profile.self.cycles-pp.sctp_inq_pop
      0.23 ± 22%      -0.1        0.15 ± 42%  perf-profile.self.cycles-pp.sctp_check_transmitted
      0.13 ± 47%      -0.1        0.06 ± 55%  perf-profile.self.cycles-pp.all_vm_events
      0.19 ± 14%      -0.1        0.12 ± 25%  perf-profile.self.cycles-pp.filemap_map_pages
      0.05 ± 72%      +0.1        0.11 ± 24%  perf-profile.self.cycles-pp.__fdget_pos
      0.08 ± 54%      +0.1        0.16 ± 22%  perf-profile.self.cycles-pp.sctp_skb_recv_datagram
      0.00            +0.1        0.09 ± 31%  perf-profile.self.cycles-pp.tmigr_cpu_activate
      0.00            +0.2        0.18 ± 26%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.02 ±141%     +10.1       10.08 ± 90%  perf-profile.self.cycles-pp.poll_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


