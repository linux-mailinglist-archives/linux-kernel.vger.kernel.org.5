Return-Path: <linux-kernel+bounces-44040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31096841C86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCE11F2639B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4A4F1F3;
	Tue, 30 Jan 2024 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2Q4kHxH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946F5465B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599466; cv=fail; b=fADzfTlPJgLnIwskVLog3zelBQ+RNQQvttMY5ujoYOWYKAka3LVFTESyiUCKxGKSjX0I4iw96u950mGTcmtohXD5aFkk3cfX2QFb9GTj184iOKbMEhVAJNCp800KqhUoH2BjGm4TBko3ZNzhbT3kRLC+uirdk6EpDCc3X8U3zak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599466; c=relaxed/simple;
	bh=Iv0ChJCOwq9WNB27dzMnVqPthrGnFOZOjaYDbifPTZg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LzkQ0yBEokLm+Frt0Y9xOl245/5ZEuXsCVghNXxppzo2bJe0Lh8k759sMaQLJFZQawa4OKbGwa/KvcAynyw3rnZsoVbSTsKSOv8/hxmscrTikz5k9iO48B85iFrhAxRMlyreuCO01W3J3rrHBvCE6CTJUU8PSTCSrdT9TkMKj1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2Q4kHxH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706599464; x=1738135464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Iv0ChJCOwq9WNB27dzMnVqPthrGnFOZOjaYDbifPTZg=;
  b=T2Q4kHxHwqE1m6Lm2EEuYxN51SxLxu/GfFqLtrsjwWD0vSnhIr78Tjz9
   pJ+/QHx39qF6BcSewiiVQqv91JKlPJt2v//Xzh9sJ/7tjFDaZs8L6+0db
   02DWrxON1CYR98fjVM67+TR0uEBc2tZbVZSFKDB4VrS68Zq8qEdF94WOH
   R0rgiVMIYkxCRWFK7GdWhsbh7VSp+NMeNoIr0nRNJwcH7DVVIoRXm+OCp
   4DQCpPN0IfgELhtHk3JFtGjDqWlgDxmTyMobmTm/tL6JREpwmhzOjngXw
   arSSebk5/QeCVf++udmWL5Ou/eE5+zkSD8yS4C7f9d11lzLO0+03+d8Wf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3067567"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3067567"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="878340484"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="878340484"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 23:24:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 23:24:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 23:24:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 23:24:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxvOCjJQ52syiyWtzrCmi+dgPb+LXou6u2X0rActScHuGGNKrmZbETZ/43XQ3DnksVKS6i9QrASb5ZlcArOKqchTWLLi08UnQgdPevjkE2FP1N/gUVZIWxGzIoTabddvi/v5VVKP7ILlF8WGt5upMEBJj49IH9BN7NuEFHtOGyEa/A8h5XQCW8d2E8OkiJ9mML6Yxnto38zaPIi5/b+jwidBPojk8cymwLgF+uoBMNmx0JpseHpjMXb3ho3THQYf0BvALAEZVd4PwtzXOkzztVKv370KiwiovbiMTDiWHD6ZEwFa0mtc3aynjbC2W2+g9AfHT8aUTRQTUG+ImPUbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8euj84YyTMYYv7NCPsUyHzX/b0vIAnFhN79qF7f6WlM=;
 b=cBgiX/p1TWEsnC1qgVk2Pgj5j75oen5VvGzlGng6jrsZJrTJycAzVRXoKXfykN7IMwsRML5bgEmSPtWKxK/OmYxr6tlI291JusLOOfgoXAdWLBKGpYRqNeU8QttpfFWQNtkcp4MHSYDYU19KJiE7QDxKLQgennriYkUnELCu7iI5mn3MO69oFj6mcLGonNKl3+BXxf/5HSW8ntQbA+VX/xcs3m+jMls39oEPRFiyGxlWfh+t0nydl+Pc7llXI1hm827U9g5YLovutxf7coXrd4oVDv+GpgHa/1RAIn74xiNDSuBzdh7xM1Y+n3/fKi6qyLWV3DQ2rgQ2+zx+CT7hmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8599.namprd11.prod.outlook.com (2603:10b6:510:2ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 07:24:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 07:24:19 +0000
Date: Tue, 30 Jan 2024 15:24:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/eevdf]  2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202401301012.2ed95df0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5dea94-5fd3-4790-7a4b-08dc21647912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzoiZwLjOJ5x4KfrsBeR8q94s6lDCarhMM84N3a/6Yzn3T9MxNDDzGo7npYk4cqGeOPJigQnCLC0i5VS+EWnL9O/ia/1Fe1SmbJT0V31KiJkwHh36E/YLrqD66uM7fA+tkb7y+Z1kQTSoyZyjj9tFzkxggtvyvFUlLGzBlSHyQC7e4w+j5rDf3BwzmOCtxtNSFh2X1763zMQJjdUKJaa6diAa/oY50XR/MXz8Rqt0Nhl9FgWedVjE2iOfHQrd8iZMBM9sTBvuSYC/NUxwieXH7zO1mTX5DZ+sMLGIrIsW+2HgSz1+SrS9rK92OsY8hv+k7LGQaeUiar18O3+2FCAFRhH2chHqFi7ksl914lqzvFBwPEyh7KHF2MFiJA15s5S3apsiGSLkxVRGmOA62Vw2Wx36MLVmQOFhrmUE/5icaH4nJx1kuH0StFGtLrTbbSTjWJKTNQ7MJ1Dv6KfZ4E107ZyK3oginNhwvFrbIfFXqUp618HwQrFWAPASnck1dQznmjaSOrl8tMVDC+A1F6FYr1IbjLrHgX5q6tVuV3IkosdRqC7aWHdP7qWrOJ4iApwsX0VgwqL9sERE6Km4absn4q1/Y8mwBAbIzcyN/62B3+b22zz94mNhlZV2sroz4Ea7kCBqi2jTgIv8GnhzvMHYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2616005)(5660300002)(4326008)(8676002)(8936002)(82960400001)(83380400001)(86362001)(1076003)(2906002)(6512007)(478600001)(26005)(36756003)(6916009)(66476007)(66556008)(66946007)(316002)(6666004)(966005)(6486002)(6506007)(38100700002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AE3vMzKE8HfQ0G3cKDK7Z1yD8IEq0N7oD7uZRaw1N1osfDgcbLimh6SdY6U2?=
 =?us-ascii?Q?f4GnMrrqgx5Ha6z9/v0yiI0Vndl4FpjH9YDNoO+yfhs8Zpzg/rt2TFUmak9Y?=
 =?us-ascii?Q?AlqjKgxeAe2OOLgwNxFWXsh0wmSnIH0lFe7FRjILKu3SCQ8r6dU0dmX3usx3?=
 =?us-ascii?Q?KWHOo+VvwGP4YbNyxJwYGWGSM+wQ3KZEVn5iWF6TM29B8scTfaS+bkR/XoxS?=
 =?us-ascii?Q?4cCqkiNCtfE7Te8fgA3zLhBFnNMf3QOxBNtwjSulPpD85JNZl9u62Al3m/pQ?=
 =?us-ascii?Q?FtU+lrVzQ2Teb+YzP7HMCJDBRSQK07TOFjA/WAmSAUjgCjP5FGL9mZB866am?=
 =?us-ascii?Q?Nee/AUiNaHoPRmTaTPTe0rNTO+ZyCd5foxhRucIluuwkALNWAXzO/ocIiulS?=
 =?us-ascii?Q?npuTjpknSTn3KVx0DqgGjnsBzO0NlRZvck9Z6Qep7kGxPMPMOGHW8rYbdNUC?=
 =?us-ascii?Q?M27SSqg8tS8yMXItEwCZBK+0cYJLDr9Slfi4gR3WaMvj/FwZAbyj56NCjNn9?=
 =?us-ascii?Q?eKWJL4sVRW+8RpTsbFZh8LBIcxsE/7eC2Ap3vqje53UL6JYtJ+TNU62acdcw?=
 =?us-ascii?Q?8uCFQhfJlzSDDjfOo5nJ/srFOeLFHMHYjAY3StwrWuXX/A55o9glYKF8ytA7?=
 =?us-ascii?Q?nyRam4KVduQJsUErnT1dmGfjAxYT/Mjb2GIVzIZLY8J6gAVebAOaOysUOcG9?=
 =?us-ascii?Q?zdjVAqlntLrwtj1sr+g6jIyswMVBKrjXefmOeY0vv3opfTMBjLvlXcYXMckh?=
 =?us-ascii?Q?TY9fjU8b+JRq/yyyPZDJp3wmwavfHfula1Qqlc4IsS9g2ZMiIPuGP7DIjckX?=
 =?us-ascii?Q?eUl1LcRr08wm9HVTNeNYCCJY3Z0twSgDlnWB/jzQlKEfCAy2ShTji1V81nbp?=
 =?us-ascii?Q?8auB/ZIAXJJoECuCLlTkPuzKQD2xOW6zIpBCp07j1EJwKZyTbL7CqkvBSBhL?=
 =?us-ascii?Q?P6ujiYuDL6ksVuQLQO7ZE/iSIeiGbdx6cMKQoW8KS4xao0p+gRbuMvpZtm57?=
 =?us-ascii?Q?kV+W7Az0tgVf5g/enNkXagvNYDcbiFEyT1AsNImg8U8K0xeZGi55zH9Bk1PV?=
 =?us-ascii?Q?3SVGkkHdndg3bDpCbniaA1678t4tyjrtiUivHRD7mNHS2YH881ptaV1cmgQM?=
 =?us-ascii?Q?9uL2KJE+3SgI+fSXdF0Qlwd3celbkp9mSREDo84JdTCR/EwN9sO9IrCeZo5P?=
 =?us-ascii?Q?2qGoYtpc5VjoNK23x+/RaPNcOCdrH9sO4+uAmJTeXoIgAFLthMRtrGoPfJif?=
 =?us-ascii?Q?5AVTa4ewl3ueGSGvSHKGtW1U7jHM4WA5TlNuRbOuLNaccQz0zELl/9+ydN7f?=
 =?us-ascii?Q?fxfvkyAGeNhKbjOx6y5CxqKfjubdxFRvGia3I++xz74HieQZdXK4J0yRIXC5?=
 =?us-ascii?Q?UdnvcM3KNA4VHeK/N1vOPf9PIsdFwWKt3IpbtGk8LaDSjT1pIF8MLCkHWTQq?=
 =?us-ascii?Q?rLz7HIz+U0HX5hIszFt32KQJvUS0j9Di0K5jx3wRV7TFZNDSGIiJ+ZFhnOo6?=
 =?us-ascii?Q?OXQQf4lla3p8bITEiiFyd9sFKCJwsWgw9r91pYDtdXS73xr+mZAHjelZFydY?=
 =?us-ascii?Q?jBU7suJ3BRJvVtTx8AxIQEYmSNBsPPnwi4xvCfKuQgU1AKX8tCuCeWlrbW+g?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5dea94-5fd3-4790-7a4b-08dc21647912
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 07:24:19.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bacYW56/D1OQGZ0vjs19bIqXWPTT6RPqOHjKIdgoZWJ8lcxqisZ/kNyRJqUOxhdsvGCliNvGcLVwlL8LTDzG9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8599
X-OriginatorOrg: intel.com



Hello,

(besides a previous performance report),
kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 3a5879d495b226d0404098e3564462d5f1daa33b]
[test failed on linux-next/master 01af33cc9894b4489fb68fa35c40e9fe85df63dc]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



we found this issue happens in very random way (23 out of 999 runs).
but keeps clean on parent.

84db47ca7146d7bd 2227a957e1d5b1941be4e420787
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :999          2%          23:999   dmesg.BUG:kernel_NULL_pointer_dereference,address
           :999          2%          23:999   dmesg.Kernel_panic-not_syncing:Fatal_exception
           :999          2%          23:999   dmesg.Oops:#[##]




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401301012.2ed95df0-oliver.sang@intel.com


sorry for below parse failure which caused no real line numbers.
we will follow further. the orgial dmesg could be fetch from below link.


[  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
[  512.080897][ T8305] #PF: supervisor read access in kernel mode
[  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
[  512.082337][ T8305] *pde = 00000000
[  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
[  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
[  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 512.086203][ T8305] EIP: set_next_entity (fair.c:?) 
[ 512.086881][ T8305] Code: 89 d6 89 cf 85 d2 74 22 39 77 58 75 1d 89 f0 90 90 90 90 90 8b 48 70 39 41 58 75 0e c7 41 58 00 00 00 00 8b 40 6c 85 c0 75 ea <83> 7e 2c 00 74 28 3e 8d 74 26 00 89 f9 89 f2 e8 36 59 00 00 89 f9
All code
========
   0:	89 d6                	mov    %edx,%esi
   2:	89 cf                	mov    %ecx,%edi
   4:	85 d2                	test   %edx,%edx
   6:	74 22                	je     0x2a
   8:	39 77 58             	cmp    %esi,0x58(%rdi)
   b:	75 1d                	jne    0x2a
   d:	89 f0                	mov    %esi,%eax
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	8b 48 70             	mov    0x70(%rax),%ecx
  17:	39 41 58             	cmp    %eax,0x58(%rcx)
  1a:	75 0e                	jne    0x2a
  1c:	c7 41 58 00 00 00 00 	movl   $0x0,0x58(%rcx)
  23:	8b 40 6c             	mov    0x6c(%rax),%eax
  26:	85 c0                	test   %eax,%eax
  28:	75 ea                	jne    0x14
  2a:*	83 7e 2c 00          	cmpl   $0x0,0x2c(%rsi)		<-- trapping instruction
  2e:	74 28                	je     0x58
  30:	3e 8d 74 26 00       	lea    %ds:0x0(%rsi,%riz,1),%esi
  35:	89 f9                	mov    %edi,%ecx
  37:	89 f2                	mov    %esi,%edx
  39:	e8 36 59 00 00       	callq  0x5974
  3e:	89 f9                	mov    %edi,%ecx

Code starting with the faulting instruction
===========================================
   0:	83 7e 2c 00          	cmpl   $0x0,0x2c(%rsi)
   4:	74 28                	je     0x2e
   6:	3e 8d 74 26 00       	lea    %ds:0x0(%rsi,%riz,1),%esi
   b:	89 f9                	mov    %edi,%ecx
   d:	89 f2                	mov    %esi,%edx
   f:	e8 36 59 00 00       	callq  0x594a
  14:	89 f9                	mov    %edi,%ecx
[  512.089261][ T8305] EAX: 00000000 EBX: e75ff100 ECX: e75ff100 EDX: 00000000
[  512.090180][ T8305] ESI: 00000000 EDI: e75ff100 EBP: ed229dd0 ESP: ed229dc0
[  512.091097][ T8305] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
[  512.092138][ T8305] CR0: 80050033 CR2: 0000002c CR3: 0a508000 CR4: 000406d0
[  512.093076][ T8305] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  512.094004][ T8305] DR6: fffe0ff0 DR7: 00000400
[  512.094643][ T8305] Call Trace:
[ 512.095145][ T8305] ? __die_body (dumpstack.c:?) 
[ 512.095755][ T8305] ? __die (??:?) 
[ 512.096309][ T8305] ? page_fault_oops (fault.c:?) 
[ 512.096994][ T8305] ? __lock_acquire (lockdep.c:?) 
[ 512.097677][ T8305] ? kmemleak_alloc (??:?) 
[ 512.098343][ T8305] ? kernelmode_fixup_or_oops (fault.c:?) 
[ 512.099085][ T8305] ? __bad_area_nosemaphore (fault.c:?) 
[ 512.099839][ T8305] ? bad_area_nosemaphore (fault.c:?) 
[ 512.100579][ T8305] ? do_user_addr_fault (fault.c:?) 
[ 512.101325][ T8305] ? exc_page_fault (??:?) 
[ 512.101992][ T8305] ? pvclock_clocksource_read_nowd (??:?) 
[ 512.102799][ T8305] ? handle_exception (init_task.c:?) 
[ 512.103492][ T8305] ? yield_to_task_fair (fair.c:?) 
[ 512.104166][ T8305] ? pvclock_clocksource_read_nowd (??:?) 
[ 512.104975][ T8305] ? set_next_entity (fair.c:?) 
[ 512.105655][ T8305] ? pvclock_clocksource_read_nowd (??:?) 
[ 512.106447][ T8305] ? set_next_entity (fair.c:?) 
[ 512.107106][ T8305] pick_next_task_fair (??:?) 
[ 512.107788][ T8305] ? put_prev_task_rt (build_policy.c:?) 
[ 512.108460][ T8305] __pick_next_task_fair (fair.c:?) 
[ 512.109162][ T8305] __schedule (core.c:?) 
[ 512.109753][ T8305] schedule (??:?) 
[ 512.110284][ T8305] do_nanosleep (hrtimer.c:?) 
[ 512.110900][ T8305] hrtimer_nanosleep (??:?) 
[ 512.111581][ T8305] ? __remove_hrtimer (hrtimer.c:?) 
[ 512.112264][ T8305] common_nsleep (posix-timers.c:?) 
[ 512.112891][ T8305] __ia32_sys_clock_nanosleep (??:?) 
[ 512.113657][ T8305] ? syscall_enter_from_user_mode_work (??:?) 
[ 512.114486][ T8305] __do_fast_syscall_32 (common.c:?) 
[ 512.115180][ T8305] ? irqentry_exit_to_user_mode (??:?) 
[ 512.115936][ T8305] ? irqentry_exit_to_user_mode (??:?) 
[ 512.116690][ T8305] do_fast_syscall_32 (??:?) 
[ 512.117386][ T8305] do_SYSENTER_32 (??:?) 
[ 512.118022][ T8305] entry_SYSENTER_32 (??:?) 
[  512.118645][ T8305] EIP: 0xb7edf539
[ 512.119172][ T8305] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 0f 1f 00 58 b8 77 00 00 00 cd 80 90 0f 1f
All code
========
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter 
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq   
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	0f 1f 00             	nopl   (%rax)
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	0f                   	.byte 0xf
  3f:	1f                   	(bad)  

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	0f 1f 00             	nopl   (%rax)
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	0f                   	.byte 0xf
  15:	1f                   	(bad)  


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240130/202401301012.2ed95df0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


