Return-Path: <linux-kernel+bounces-126413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975A8936FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CD21C20B02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C049137E;
	Mon,  1 Apr 2024 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zto4dbSm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD187F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938795; cv=fail; b=aRa27CdxpobV6UstEuK/fULFuwQW5Fhrs1qENUk4lGHHCoclIQzlmFTaXVvQIbJXZQzvTD5MGP9I7OyDydOLJozPGblLCuQYByxIEUUR2c7qmvhNkVF7Ed7N8ivB/te2i7Je3mWe+jZ68k78OkUTMrY80aXWaZdzR05RkL9N0mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938795; c=relaxed/simple;
	bh=KtId0EKw+dx4CDVyAsGCtPQFYiT1uxcbs4rxYPKD0d4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pAPfbiXM/pz1wRZ4AOCHaHHKDYrd9YklJGuoIHBPkDeueUxIw19v1WKV9Cf/DtmJDfSJPCJsFvuDQasBvGVxOuLgU8dwzetm8JAYHmLVHJzmX4c88MaE0Z2kisr4q1iDrjZaRsQYij7XRkWaSeqVkszL5luoKvVsYLAFxT2gPO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zto4dbSm; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711938794; x=1743474794;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KtId0EKw+dx4CDVyAsGCtPQFYiT1uxcbs4rxYPKD0d4=;
  b=Zto4dbSmIztsdIRJZ/ppKfIAI9NYP1FiCWGfhbBICKdnyLr8/Nn+bV8j
   nU6+2XTlWu/6czv8nLKtaG/vmp2wuASd+IgVc4l9qYg3QFL2rRgvWJkbS
   vte34pwSHZzdTH6O6jmq3ghbkoB5TWMZtD6GaB/t1XReBqXoA23Y8gTeq
   THhL+wV/WDv4pIVUKNUA5WVg/g3H14N6EPaiRexEvs97+826bdClEDrj9
   S3doFahLTR7gPm6gj9reTyUIUhZ+3nQPt630x5TBT0J4hNGQKytYBHoZ5
   Ip0+UJCrFaaz5GRQ4oWI8j3KfFWbx14nzcPto/FN720JnQmtDcqezDFB8
   A==;
X-CSE-ConnectionGUID: UyqMHT/HTZi0k1isxKMlKA==
X-CSE-MsgGUID: 75LMHiX/QbC2Xj0cq6WvoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="7170163"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="7170163"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 19:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="48556936"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2024 19:33:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 19:33:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 31 Mar 2024 19:33:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 31 Mar 2024 19:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwaJfjXNqZzGuNCUamET/3nfOo9Q2cVJ6bXaY88/6DVqMPurZFIi2FeOcsfOJsdgxPrVkDm9kilhaensBdOiCBAWUBVjPVA/QzP52LHWC/fpQ653xB4AKqoQ1OQsBEUY324WTUwXkQ7358IbkRaXMhPDUzEQLYBXgdCX3kL7i8r9GTdnIFA065RF1hhwq997jpTcLDoGen28OGf8Ui3BzxqeOO+LAAKrEtmmy8qR/W93K1hYFx9Bjd8FGiNyqcQl7tWgvPjhval87YrjE+FyoKhBYQcP7j70jgPNQ5SLnK4alQx6Ikjs/995bUwkFFpp5iq2ojcc3HrzQ5L1Yid53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYx9yn9RZ4Lp7qBgIehUjB7enc0dJ/OUFbpf2fP7A9U=;
 b=SrDbsAp5h96IAPzcyoEF2duiM6l23ZOtuzhRgQWhfvRKo38DbKx3ykdzkfe9z9IMhe3yuCW/6KZnp84hFwpRe72kuxxg/tYWm/B+Vceuu0aDea5Q2sV6YFigrzSo0uXJJbW+qCtrrEgAewu/lsCeeC4LEreEZMyFwp6nHl/m8KqwvSXFhIucps7rEzuYzJo9+c3PdnnLwmbyManl8JilcM+oE084UWAgH1kAdB4tMNcE0qw5t4PIfIZPJ3P8aNaGZbVN3CpHmiqCriQu077OAD790w1Xk3RhUM9WemH7XxzL+56w9o+ThrzLf34Kv5Yt3EQlLYHQEh3/EeSbur1P+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS7PR11MB7887.namprd11.prod.outlook.com (2603:10b6:8:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 1 Apr
 2024 02:33:08 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7452.017; Mon, 1 Apr 2024
 02:33:07 +0000
Date: Mon, 1 Apr 2024 10:26:27 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Linux Memory Management List
	<linux-mm@kvack.org>, Alexey Dobriyan <adobriyan@gmail.com>
Subject: proc-empty-vm.c:342:17: warning: ignoring return value of 'write'
 declared with attribute 'warn_unused_result'
Message-ID: <202404010211.ygidvMwa-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS7PR11MB7887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhHmYH5ef+0TV5i1Yth6HyReDJB7MoYFheyTAqq+ddwp5GgrK1v69tklFlnoQJZ0025p/x1HkLlTKgjg8nVSANaEeGMDK5S4OF/MjR0F+Zk1LUQ4vjn+dxPZKu+wn7UbbRFEvjd5ubtrmMuDOSDTsy5I1WCJUUd8xr06Tzif6sAt5qAa4RDGauPC1eUCo0uM5nm+Zi4Q36y7kkJK6zH+ULedkTVW4dWmHCH/liLUinXMVneyenRxLG5cTzNyMRKpxKMHgq38geOGNQt7OVZejaZgIuHOQa6CqiJDG8GZJgxzkHobPZnYvxj2BBncXhjHIHLY6WSLdNISRjLZUQuKuenFOFCW6Z7B6flEsVH88dkmI1dNWwEFF2v/Gt2E7ZP1x+/lgETr4sRdAieGW/Ul5kRyhxiaMdWCOAbDT+bouHmbqRNnd+pNZNZIGifpHAGshUiTBkMhRHNwPWJWK9s6n+aFONpTpV6OVCTumC+7SXUEAInA0SQ2ULknQhKD5fwuvMEod7cC5Srv3S9up1JcoHKiwXzcD4XRTgmTrcmKwcSFnOvEYxsvvIvi2ujiCXjtHu1/EbKM/26ENnL2RSaVpELgbXu/FMR7eSNgWqFwRxXvfVm7BPYdh8c5iB+l59Wh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1lqHnGVE1MuU/YTk0/WLxFQLd1Cw8Kd+MQttlfplIwG+D69lhinQSyrNvwzA?=
 =?us-ascii?Q?PD2UQTYJD9yPA6crb+/amJH1GFCmt/W6BS/nVbQA0lD+JOOdSfrE+0KvqeJm?=
 =?us-ascii?Q?iaefPC4/yEFWcHwNAvvVzwZ1x2sz+5lrJ5mnXs7KyZS1xUquoA/nCdU5g5Vp?=
 =?us-ascii?Q?xbf3M6dX5QP5MT3umE8ov91Jlx1OnRg/Ylm0klNez2YXjpyVrhvyxE96WmAT?=
 =?us-ascii?Q?LdrU0nT2bMO4pn2GSvh6L+b15VrcSmPhcl6Yvc/Th7sa/7Bxo8Z558r8eNjr?=
 =?us-ascii?Q?qqlG/v+OijodH1mVXM9STlFRbKEyS4IlMQq77hWm9nSzGxxpEnvuIx/YPBw6?=
 =?us-ascii?Q?iCOtRFY4T0OKjVV96/wkYAt2RNuAUVQhnTMac+MSOHLbsPGA9QyQsu5Y8Wfy?=
 =?us-ascii?Q?mgyJG+PWbQZFpUyU3kzJBmZfD3cnEcZKZD2JWkR+EK++50YxdLCH1Lm8dqOX?=
 =?us-ascii?Q?da8phCpbfxT3uBKWCP422M/XsckuvmtUMvG2t00thoteZSTGFy2v9k5uM33b?=
 =?us-ascii?Q?jNpEAlIsYahBp7+MB5z0UyIgaZaM2kwG0w/2zQT/F47gIidTdvBgFvzvDiMT?=
 =?us-ascii?Q?4Km9wEmDH3dm37IHRfgzj+NVPqbBKKzCSKffgsnGyZq2EIVTtyQZOFQDYJal?=
 =?us-ascii?Q?rI4o6YOF6nObZ9Y1wF/76RfPpxIyKZCEU2tD7+4g9HHl9FJQHefNajknD39y?=
 =?us-ascii?Q?GtfDIgq2lJ7gNVZtkz3v3a1NE8lz9k120PV+4mV0okdGVit2ZxXkmWnFHLHy?=
 =?us-ascii?Q?xPF5ducu4qJERn5bcY490CdJyhq1O9BYi8DM5eaTHJEltDtEhFIs0VulMa2X?=
 =?us-ascii?Q?Z0pknp+X20LrNKRgrq0YEqryDXLFDmXPUeUkphfKQo5nkx8FR3y8ogli29Ge?=
 =?us-ascii?Q?0AIXAcXrmtncy07CVBFXT19A5qikC2EfcyzVg7bLepxEcoWv+kh8QdY9rvyt?=
 =?us-ascii?Q?SQqHOHMdbmIWPnEKLN11tbfmx2qZFljCwz3nK0K+AeLj2y2ruBodIGq6Jix/?=
 =?us-ascii?Q?6HWi/J+0RW/yO0WlKxhKE3fLX085ZWm/xDuOhhYW68f7L9sBGXRl5G9mnvqF?=
 =?us-ascii?Q?TG5ysgx+RXiN+VsdyMxSyQlyOR7xiDHBmbXlZgvaq6Z0sIox6V93bH5QaaK8?=
 =?us-ascii?Q?UVftgQ+zxAA7Ak2OMe5fAkWZ25wBvNmVXWnELEH3ZEKM5V1hBpFxFYg+3zcj?=
 =?us-ascii?Q?RSCnZkEt/7E1NOMRmjULKm3Upa7nacmXDzmHUE1dg3jhTRI2RSx240HTwPlj?=
 =?us-ascii?Q?2yN/e4Ji8LmfEntj7JG7Z4kyMLWVFEcC+Y6R5S9sP64qbNrYn99vPQffd3SH?=
 =?us-ascii?Q?Ld9lBJf5zxh3BEYxQD9/IyInuNDAdt5gEG80vIpqGsDcqTctjXSIBOgbNLw+?=
 =?us-ascii?Q?KvcUBLb9BpIymCT8HCZvXcZGmeN5l3EmWJc1V58VI2s9vQZgdNHxoWoM3nlk?=
 =?us-ascii?Q?ajRZB6iRrAOex5tO3zKX29V8cdNBP0Yu8CZEvuWEQxx3IRc3oowM0TJIQrS6?=
 =?us-ascii?Q?LO/3OX07K4J74Guwx9VBLK0FC7Z/3Wb3LqyhylwlThxgNqMLetxIREoZXsbp?=
 =?us-ascii?Q?P96mk3gKQODRyxYKXvqmXjzhsUx+GJTX4+mnbZS/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdb0be8-3d8e-418e-1c2b-08dc51f410ee
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 02:33:07.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITxKjVjtjdx0voZoKGcj9BGzyAzlEI7iAAiDjvykSqfwZy4w+nrWdRzMSigH83JIaxcLGEA7aKynAgoAvyF8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7887
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   712e14250dd2907346617eba275c46f53db8fae7
commit: 6e79b375adb38219099d7e3ccc973a7808108a3e proc: test /proc/${pid}/statm
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202404010211.ygidvMwa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   proc-empty-vm.c: In function 'test_proc_pid_statm':
>> proc-empty-vm.c:342:17: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
     342 |                 write(1, buf, rv);
         |                 ^~~~~~~~~~~~~~~~~


vim +342 tools/testing/selftests/proc/proc-empty-vm.c

6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  320  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  321  /*
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  322   * There seems to be 2 types of valid output:
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  323   * "0 A A B 0 0 0\n" for dynamic exeuctables,
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  324   * "0 0 0 B 0 0 0\n" for static executables.
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  325   */
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  326  static int test_proc_pid_statm(pid_t pid)
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  327  {
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  328  	char buf[4096];
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  329  	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  330  	int fd = open(buf, O_RDONLY);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  331  	if (fd == -1) {
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  332  		perror("open /proc/${pid}/statm");
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  333  		return EXIT_FAILURE;
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  334  	}
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  335  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  336  	ssize_t rv = read(fd, buf, sizeof(buf));
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  337  	close(fd);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  338  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  339  	assert(rv >= 0);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  340  	assert(rv <= sizeof(buf));
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  341  	if (0) {
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09 @342  		write(1, buf, rv);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  343  	}
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  344  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  345  	const char *p = buf;
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  346  	const char *const end = p + rv;
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  347  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  348  	/* size */
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  349  	assert(p != end && *p++ == '0');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  350  	assert(p != end && *p++ == ' ');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  351  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  352  	uint64_t resident;
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  353  	p = parse_u64(p, end, &resident);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  354  	assert(p != end && *p++ == ' ');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  355  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  356  	uint64_t shared;
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  357  	p = parse_u64(p, end, &shared);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  358  	assert(p != end && *p++ == ' ');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  359  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  360  	uint64_t text;
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  361  	p = parse_u64(p, end, &text);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  362  	assert(p != end && *p++ == ' ');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  363  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  364  	assert(p != end && *p++ == '0');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  365  	assert(p != end && *p++ == ' ');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  366  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  367  	/* data */
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  368  	assert(p != end && *p++ == '0');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  369  	assert(p != end && *p++ == ' ');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  370  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  371  	assert(p != end && *p++ == '0');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  372  	assert(p != end && *p++ == '\n');
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  373  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  374  	assert(p == end);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  375  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  376  	/*
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  377  	 * "text" is "mm->end_code - mm->start_code" at execve(2) time.
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  378  	 * munmap() doesn't change it. It can be anything (just link
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  379  	 * statically). It can't be 0 because executing to this point
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  380  	 * implies at least 1 page of code.
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  381  	 */
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  382  	assert(text > 0);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  383  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  384  	/*
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  385  	 * These two are always equal. Always 0 for statically linked
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  386  	 * executables and sometimes 0 for dynamically linked executables.
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  387  	 * There is no way to tell one from another without parsing ELF
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  388  	 * which is too much for this test.
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  389  	 */
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  390  	assert(resident == shared);
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  391  
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  392  	return EXIT_SUCCESS;
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  393  }
6e79b375adb382 Swarup Laxman Kotiaklapudi 2023-10-09  394  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


