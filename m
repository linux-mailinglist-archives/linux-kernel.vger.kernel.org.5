Return-Path: <linux-kernel+bounces-124059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C338911A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B261C2A0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE22AF13;
	Fri, 29 Mar 2024 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwIyDdyG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1F7490;
	Fri, 29 Mar 2024 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711679099; cv=fail; b=aUargHx/O22AEno02OP3An2nXQvKp/5Wux0LA7pVONJCbQzVcX0m7ZCuKvnEKRyyjOaHZE3GPpfKzYYsMlaC+G6FBAdwFa1RfmPgBMGLtjkQj2YPW8vccolxMKVsz7ww61v+x4Ltkud/NdpOmDqsbOziPj+FGGfjcvZDBM3qT40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711679099; c=relaxed/simple;
	bh=FUCTxdMglq/EfDLNShiBREHOGXOUb44wg4C/C8X7vDw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=A4XP+Rf4oYh3HKLsweNTO7TVZ6rca/OzxuxqTipNCpKm91mk/TYgWsWIwkd10NGlPi8rv7+jSyQN0HHjYp6Yqz1qjf5XmSZ3wiqyAwJQonFm75XLSpxgJe1V7XLpPWzdxdnh0ZwMpl8RBne1hRgwcUPV1u/VL/P1qhlG5102f6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwIyDdyG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711679097; x=1743215097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FUCTxdMglq/EfDLNShiBREHOGXOUb44wg4C/C8X7vDw=;
  b=PwIyDdyGvOGHhPbg989N9wFpAFHRfAGxzCnRcoNQCCStkkibQCG3oS5L
   F6ykCrtDmElp7ur4FS4DwT0AoCuCLIknDOA6JRqzCZsCQkE64gFH8doXI
   6rC5TVawahn8HJOZ0GCZXwHX5GpFwvmTtXdkX9OB6jAdJJE9/apVMU8Fh
   zzC0pB/vsaPd93VNyWCHl7EN8e8bDlQ57dhzHNMhliTGRgNcJ7H6BgtlF
   oUSEjJDA76Ld5RhJzPtDGSOgNfVE6DgjTj0w1PDgpyJpvD8mNp8mHYSX2
   Q2jowF5fquwGIrguLwTLx88/rsDexFRIqvTSd2gOxVMpr/vY/Mz5U7Znx
   w==;
X-CSE-ConnectionGUID: zviu3T5ET06qekXZm+f0BA==
X-CSE-MsgGUID: vn+kokW7SBuZb5xKL+gHvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17419270"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17419270"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:24:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17483550"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 19:24:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:24:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:24:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 19:24:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 19:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTjqgQ7Brs/gehzrlglZSrPEGBV+i91M+xaCpro2pf4tIQ4thZjSAf4zO+0RJ0zzXDAlcHTzWjjmTLFGU5HSqiY1fETNSaFq0z7ljeOvKwwkzqKk5VbRt++lB6M5f/N9fnAQa9Dn89K3oaZlcUFcq17Xix4jnhp1xxB/e3xngjRNgRtAnzCp1m1EhAOGlZ6cSO2UZbL99HQQgbJkgEDepfeoTfk0q7VgV4GA1nO8/MVQ7yJgEklG+wKLVcWNoojriHvNZ7O3DGCaH0UJp0IRg/jjD368lzuX/7nRsgPgH1duNGG/6fXdBgayZI8zz40L+AlLkcy9ev4ILQcBbmAI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3xpJv/1/K8Qss0ohFCUe18p1tmior5RH4EDGcrd0M4=;
 b=PCYb9OqVwq3XRt/oV7eUpWeLsh+k1ZmAKUHGteM7y0dQKiK5MOC5I/UD0JA2Hy3wEzAAOtvXeNezW2oAMGgYRjzprjAVIrJnr2S6GnQU2SCwSIA/t2tycypWSSbHLfHP6fySGGOe0bBXcBUIGX02CYXlOgQUhji/BALVOXCjdygf8hCEoxWvDwD+4Jz9//Ej3NnHhYB1oQvz84PnOMJOfM4V+a5uyKI/h/XJdHYTtDqnfUbW1PlBK9dmbOoV6Ldrhc7SmvfO1H/GpG37MNe1YJRTuDAmRs+1oFYu0fjCvIyhbhyiq1fOku4BlyHZI3B/w3AVKZryM8UAdb8Z8ViTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB6575.namprd11.prod.outlook.com (2603:10b6:a03:477::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 29 Mar
 2024 02:24:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 02:24:52 +0000
Date: Fri, 29 Mar 2024 10:24:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ilan Peer <ilan.peer@intel.com>, Miriam Rachel Korenblit
	<miriam.rachel.korenblit@intel.com>, <linux-wireless@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [wifi]  310c8387c6: hwsim.autogo_chan_switch.fail
Message-ID: <202403291042.d9211733-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB6575:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+XXp22ZBZe/EuSN7es90uOTvemRruUpxARmSMIOpD3gZL8wSla139iSqy1uKB8T+r7Tm/Xxj4uPG4sIWEUt9Z++N3fdZ6a8i/FdTVeb65E5uSLlDGxPnCwsE6yqntCatlnnW5iTb/WCxy6DC036pcK09vTLjufkm8UGEfsMVF/Vd8Dgtbz+hL+OL1F4+f27II9q7U7b7OrbuH8JSAK+B7671uqGJnr5YpPVpSDCbX9boGVfAjqCFJwiPi7pEYx/dNeVcOWL67SL+pIn9ZE57ULScAZwvkbhidPXFhwCl0HrM0b8B+kJHzPRNDmQsfqPQtQXTgSbpc2BmnMmg+wRskHSbGGswkJ3xsGYTT4NsEf7CNurQEzxu3fXCSiU+Ph56QikXces52N0WneI1oGSHTCADL+0Julxh/VXFECaZrsIRNRKGIRYIMC/rwlOYNjbKNQsqfnuZhss67JUwyC+bl/sbtvuAm1ST09iCIOsGPuQh6rg4wHvi6WzOB4jkPiaWcJAR4CUSXdGdiCuW+XNIcMBAopi5COIYQnv5QrgyX1aLdDfqBAiyTmQW4knW6y4PXjdVvwVOLkyqFEGNZiEc+xOZ5mF9Z+Q7Jajiz49ngVPo/U9nUpXzLIw05jK/UCI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?stfjbQj2d78jRaVpzGF41Ws+s7IUSwCHNUVfEAmcfVQvE5YP6nnHwz7RfQeS?=
 =?us-ascii?Q?j1DWZWNNbvtYJsjV0rmH981PmPOHsdgiwwjnYexfOuHDVQlc/UnnI65jQpvo?=
 =?us-ascii?Q?XnUZpC799qpXEQ/ATdPfGpev0iXXMginHB1Hg1c0OMyopW4tyfbitpJ0cVtG?=
 =?us-ascii?Q?QBeYTL7HVYX2bx9qa2IGqUn/8J+fIxlB1+jU9U3txE/FyF/syrGtpNFGHqPX?=
 =?us-ascii?Q?0+btzg8b6zvWb5yZ7g4A8Rwwsti2shR78JVAZ+6UCY+rBT09z08hPwadftNO?=
 =?us-ascii?Q?Y/z0sAfpDqjsje2zMyDcSzG1uiwF3ZPuJYcgpR/PutzG1okuLdFcpnEZN1Kx?=
 =?us-ascii?Q?gkFZM19o2hzIKZI4jAtLCIodN5BuG8RcIGuiHSnAEUhyBL9WO5iOPK8/AYbV?=
 =?us-ascii?Q?SR6kfHw3/CrT/1apV2tCp2VxZ2xuaYHaMaKFVZGEFRJQohVrfXciZLQOe86+?=
 =?us-ascii?Q?Zd6g5PEJFPvZNpagmSKl58QqGnWcy/guimhaWMtvG3x+axdE1Sq0uyydk2pq?=
 =?us-ascii?Q?39EQPxCoQFKUn3SbBuMgi4xDVNs1pNUl/DabytHd/XNa0w+t56F4v0TI7JyL?=
 =?us-ascii?Q?Tn4iZaBFTLLdGc1Ex0BT6j1LUXHLIX2mB5LAU8H2tin21O7UAOSx1f+qycH4?=
 =?us-ascii?Q?0kdXJm87SXcjlO96/szMrpqzt04klmu7hje6XbfBXvMkT7U3ens+4JVhzCK5?=
 =?us-ascii?Q?jE6rw9bj1J+8HY4F9+K1+ij/4x7xmXtX8lzxWYu87mLPKJXgV2dpW9jpFaxa?=
 =?us-ascii?Q?oJpdkuVa3Xxe/hu0+nCAujcJxH7VEmWTO1UIU6SdI8JOjD+c4FpHwGZLh4Dz?=
 =?us-ascii?Q?XNlEtZToB6Vbo9ZRavc85bp20GU/1D7J/TJ8EcwWAWKJ+wTLTHhc6ELDvfLw?=
 =?us-ascii?Q?De7Nxkoq+7exS8lwlRKWv0gD9ktiUl6xdseu5pNC3/Y5Nga4qwuqM+qr2APH?=
 =?us-ascii?Q?d1Z3SehVZr3K3gVU6us09tAhpuFOZQWRR8MlYsTd3DsELC6rImDoq8ysl0eD?=
 =?us-ascii?Q?NUOdGV5jVpf3KgpamdJNw21VzNrwCjV4Q3N/gXV9m+TF8+Tmuz7TvQPa7uTB?=
 =?us-ascii?Q?PxfkecVIP5UV1fuaZoR6PQCl6TPCsYTOy6Xd3JB0CExhA+vk+Vl6JfKnp2xS?=
 =?us-ascii?Q?AaQ+YpE4vm4F6ph3oW4LioZwDKz09YISyTCVxedrHvllfZk8qDAhSMZOgLYT?=
 =?us-ascii?Q?Vkur2ag/tHh6q4BNvdZDkQNGJDJa1LhpTvMaa7qbv71qesrSIJGxLX5P0F5N?=
 =?us-ascii?Q?OAN/mdT6kYMWpOZQhVhgMFwVlnokU4KeW9jv/PflHqmoDInvbbJh7QyQ0Nm6?=
 =?us-ascii?Q?DD5scXETBicN0JlD4jyW9E4XMoemlJisvbUuYWPwX7m6FWju2Onnuy0qTUyW?=
 =?us-ascii?Q?Rsk9WJ6XorsJFrfzSaRC8RuVrv7HVQLUv4JVbPf9u4NNr/BvLG+xWHxlJXsx?=
 =?us-ascii?Q?SsG7k9MN9/QlOdOMJvE37xiY3w9IwV5ThiaiJRsLlJgh+4KMLDBT5pTddUh6?=
 =?us-ascii?Q?NHD13mgZrzS6R0RILIMD6xGFTNgf+XEN/htcYh6Q0vl5pLEUV682AkeinkOy?=
 =?us-ascii?Q?8+WPpmG/xSPWkUyZyzPhTJPooVG1IxuY+T0dIGsbbG+5pqJoO0dVp5LyYWi6?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd313d2-d796-4415-296d-08dc4f976a04
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 02:24:52.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oflyZxvJMiV+O00fKTpun065jULhLCTh4a10DpmNToLBN2DsgeTOG+uSMLUqdHPEhyWsZ4FSlGs+0zTqdnmiDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6575
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.autogo_chan_switch.fail" on:

commit: 310c8387c63830bc375827242e0f9fa689f82e21 ("wifi: mac80211: clean up connection process")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 7033999ecd7b8cf9ea59265035a0150961e023ee]
[test failed on linux-next/master 26074e1be23143b2388cacb36166766c235feb7c]

in testcase: hwsim
version: hwsim-x86_64-717e5d7-1_20240320
with following parameters:

	test: autogo_chan_switch



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403291042.d9211733-oliver.sang@intel.com

group: group-20, test: autogo_chan_switch
2024-03-22 18:48:55 export USER=root
2024-03-22 18:48:55 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2024-03-22 18:49:57 ./start.sh
2024-03-22 18:49:59 ./run-tests.py autogo_chan_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_chan_switch 1/1
Test: P2P autonomous GO switching channels
Start autonomous GO wlan0
Try to connect the client to the GO
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
sending data without carrier won't work
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 593, in main
    t(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 357, in test_autogo_chan_switch
    run_autogo_chan_switch(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 375, in run_autogo_chan_switch
    hwsim_utils.test_connectivity_p2p(dev[0], dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 227, in test_connectivity_p2p
    test_connectivity(dev1, dev2, dscp, tos, dev1group=True, dev2group=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 217, in test_connectivity
    raise Exception(last_err)
Exception: sending data without carrier won't work
FAIL autogo_chan_switch 15.072969 2024-03-22 18:50:26.967705
passed 0 test case(s)
skipped 0 test case(s)
failed tests: autogo_chan_switch
2024-03-22 18:50:27 ./run-tests.py autogo_chan_switch_group_iface
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_chan_switch_group_iface 1/1
Test: P2P autonomous GO switching channels (separate group interface)
Start autonomous GO wlan0
Try to connect the client to the GO
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
sending data without carrier won't work
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 593, in main
    t(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 383, in test_autogo_chan_switch_group_iface
    run_autogo_chan_switch(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_p2p_autogo.py", line 375, in run_autogo_chan_switch
    hwsim_utils.test_connectivity_p2p(dev[0], dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 227, in test_connectivity_p2p
    test_connectivity(dev1, dev2, dscp, tos, dev1group=True, dev2group=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 217, in test_connectivity
    raise Exception(last_err)
Exception: sending data without carrier won't work
FAIL autogo_chan_switch_group_iface 18.357236 2024-03-22 18:50:57.293385
passed 0 test case(s)
skipped 0 test case(s)
failed tests: autogo_chan_switch_group_iface
2024-03-22 18:50:57 ./run-tests.py p2p_device_autogo_chan_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_device_autogo_chan_switch 1/1
Test: P2P autonomous GO switching channels with cfg80211 P2P Device
Start autonomous GO wlan7
Try to connect the client to the GO
wlan1: Trying to discover peer 42:00:00:00:07:00
Client connected
PASS p2p_device_autogo_chan_switch 25.252863 2024-03-22 18:51:34.497093
passed all 1 test case(s)
2024-03-22 18:51:34 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240329/202403291042.d9211733-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


