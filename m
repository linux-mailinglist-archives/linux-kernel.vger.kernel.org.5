Return-Path: <linux-kernel+bounces-86781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C086CAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F982872FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE0586251;
	Thu, 29 Feb 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQYLjU/R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A45A7AE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214649; cv=fail; b=I0uTGUkChP1uic6v3nzYj2zlofh9QxpQbwcClCW8aGarRxJNNg4B3ZGyeXrxnoGTNhW5VjhUA5AE1mPpueoGr6uCR9TTpLYhrZCb4fJjEu0XoIHLHAt3vaAo8+H8pdmP9ZXJOeKHrQn2YZrQHsw8Ox6aep/za8V765Nvej6IGeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214649; c=relaxed/simple;
	bh=NSQGRH7UpH01hlD80sRJUoGHvryTBThlrYWOEdvcK9k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uuSuCOCM1UBlbfkPy0DHMw0tDzR24zXhwqrSG8yA/R/15wVKS+/ijzUuYv+u4lZ/GM0h9wudHMDFL6y9lU40Mecl1lB7py5LRPA3EY/dKgahQ3WcG2PIHoqMbso6+096C5UhnpPMMft23NhA+Iz4VhMVP8uaX5YtVAHsvaTuy9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQYLjU/R; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709214646; x=1740750646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NSQGRH7UpH01hlD80sRJUoGHvryTBThlrYWOEdvcK9k=;
  b=NQYLjU/RFlEYbjo7sujCeSbfnOGsnqL8Wsed5Q6C+mc94hBpKx7FQGx1
   Lr9Nnt1AS3kdpgvkaODZSWOye8aFLkkcCjZV87MSj/BT+bjwyujTL42tx
   jy9lXbO3uZ8zNPONab4SBJoITi3zJz50Nv1nN/bfrlPXxTjTDju2xwBPF
   QmeRF/yqPSEhJXYd+hHEEKMzIHTK29O2vtPVXPu5PUBFTzOPL0aN3oZLR
   SiixvHVjUbi3LTyccBHKbuUrznJ9JoKPDxoTcYAhM4dMci7kGb+HMJvNy
   YkQCc5ZvqGNVCjp+Ed3HK2tbipHdkvCzT02b5hO6wPfeI5uFOv5SAO8jT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3848129"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3848129"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 05:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7939384"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 05:50:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 05:50:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 05:50:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 05:50:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 05:50:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pmylz3dnHC3giUh0UFomD3aTIrKWdiHHGz9C9YKJ02SdeQCkIVaOWCAOrVYY2nGtSxzjHQDYK8HWydVlKUt+bkm/uu9N4qi1+gGJ9R36HX0hgRlAxyld+qhmco2xk87nyjW/NCpEAlnG3q1ZmUuFquGxnnlSTlmy12E6LuH0VY0piC2rzwMXsJ3IcIJ3DeW5ALK0Bx280LJAS2PoummNQ5rkDXziqF3Z4KBQnhwQifUQcMX0eC4d+zo9x9HJ5GDXmsm6ra59u9m9gRI6Ko3m/MUKHfLHa2HLcGbaciXXZbIvdgLZqfmuBy8K0YtMRQoZq/Ni9MPt4Yw25EY0defjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgWPUfg9fDmg73u4+1bp7ZWCm7YTyKJeY+ED//HUoy8=;
 b=K6Wm7mUyZWFzy/Ip+Ai8aL85703tjYRXewDV+2oTS9Nw7HqiX9n/5cWMVFLGweKCE3Wi05f84MXx3+nPgNT/r1FVpxXO6Er4anczH2s5kRhNURSHh/tpV8Upeqiyj5Kpl8I/tfF0LHPsTv0TdNEIIPXAhaiyR4raJud2T0M9BrQSn8yFvo5JtogldoC2o00uaT4/pvC7qx7SerJG/gvelZxJzF5K6koDjNe3zdGZvGyrVU2WUgvlbxGxbutrTkkOXssZAx1tpPGKD8z4ID905ytUkMmTgLvB4TVYh5+1LARt1XHxG2mv036uTY2Ee7DCihH/dzk6jjD7TCMpzALkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 13:50:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 13:50:40 +0000
Date: Thu, 29 Feb 2024 21:50:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Peter Zijlstra
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [bristot:dl_server_v6] [sched/fair]  0e52e2609c:
 WARNING:at_kernel/sched/deadline.c:#task_contending
Message-ID: <202402291627.c8168277-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b11bae5-c8b2-4fc1-4af6-08dc392d6a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDmApG/Rc7EU2/KS0HNOqWag8PvYq+GzyYISv0iKVU72XmRkSXS2KngpnWyqlqIAxJiZyH0pbwH3AluttoCiMCOUIPAaWDPLfzsMP8tNZpq8ow8xR22OmBsEyZWyyualcpna1WDqUx0ziDyIFBmn1gSBOTBAewjRL2SPUJwFEqxUO7qwR69g82HeAaz4Xda9N+M0hOdEudrs9ulqTE9364oZSyA8QS+6xi2cD9NlpNKEy/Rr+W3Y2tx+C0dg5xEQBTlwhemPkqaeFgFAxvmHWg7CWaD5TtR5moe6oIesvZ8n7IKixDwgQ9I/ZRBFfz7yRQ98UiIibRva4xT5ZPQ12M1VSi0FIeJAbQr4aNLuVunBbSK/sVtUlUCkzQMZT5mrFVMiYIx7IYEcSts3NLDV8V6dPoQ9DuEMXe7Lzw05RxAJEexN0TYS0LmGqVqMCC1bji+Rgh+Urz12ldk3YAadnm8pNq1QFgV8duXm18ATNyvWiFG/XV6uXQ6hxOaJIuFa3Mp5KU6zUfG16htG5Fko0C6YGW9yplokr7b4KRAlGCno2msY0yR0xulT6Btghhk7nR8aEGb9cPomFKuxziXVTb4g8eooRHeiCssFzH+xgrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XayVJc07zxBA0rMtTJoTdwtCM1pVSyvN7XsXRuhqHi4RPdb+pne/l8ZopQBF?=
 =?us-ascii?Q?IKWAvG1nl7zPfSqvmGn1H5FT868erVucpB/Lp6cgVmuat7/oBTNJmt1O54RE?=
 =?us-ascii?Q?s4vU5Biw5WCv189On9Pjh4MSNRbWN4rpzF6GFEway3+VKEd+/tesa8WOrCEu?=
 =?us-ascii?Q?EN6TTD9YEfAeesCuqneSup4O3mGBRFCtLHFhU0GfMbSSr1cRgWKa60ZH63MU?=
 =?us-ascii?Q?vtFKl8hSoprBZRvMQ7EtLGGuGwrlSNIg3IhkNJ5Uzos5jFJvWmvIitWGIpV4?=
 =?us-ascii?Q?5UFZ7v4xgVYdrJwaqtFAuEjvq+Z0ZKh6wbf8EinneLj2UblXT9pea5f9RL9M?=
 =?us-ascii?Q?vFO6J1ndhJ4PpiF8b4aWGi4RurG8COW0TFnZcCnM4Ex5qUOlg9Nc/YdiHpoE?=
 =?us-ascii?Q?dLBwnwg8tgG1x1U5fCgE1YVdwV7dBNEGRQr+3SC/iDE9Ple70jZ6P9slNGp5?=
 =?us-ascii?Q?A3w7SM4E+Unjp+JR18lwzyUuyygUrJLEUsV3T/WCwl4bRWd1nd3td0OYkD7A?=
 =?us-ascii?Q?SuErzwPx6sZrBOJGF8FdsNLzMGqTJwOqbfNY38n1zO5y7wf+yfgSh0cM6wUv?=
 =?us-ascii?Q?BOgYT+WecBcQin6M2LEIplpmjFmbhqq24Kvtk5qTVb2fwOKhsaA0iAJIZ3M0?=
 =?us-ascii?Q?+p6Q9YhlFQBW1os6dU6FWLm3IfTh6B9QdK2NBsq1I8asdweqHBrtAwCie3A0?=
 =?us-ascii?Q?Ae0YRyjn7rvlynss9lI94pt35/RqOHoOOPpjvIi7bhNpi7nJUZLBPB9UckZc?=
 =?us-ascii?Q?YH+uapiwGuysi/nibXDhGIebImR11cmAozi2E/cwLJ+LsH/Iaqz5toF3jbGU?=
 =?us-ascii?Q?MNut8CYAwHiMXlREIT1Hhm+ZiGlYYePJU9MBkzdxJEsmRnao5Yiw81+FUlLr?=
 =?us-ascii?Q?6gwfI/ZdUu1jv8NBkrzMue2y/wCyuVBnv1UppttLSiNr3F/I0avPwgq+UmnW?=
 =?us-ascii?Q?sQ8agwpMTQY1Wx9WyQ/3D7gIQJhvjVA9zFOGqre+u6DsN8rMWmpbCj8OUTBo?=
 =?us-ascii?Q?HU9XfUXTmw0Ak/lx2SnYhndtLB5xqege2eVGZ7aBHl+S7Fzov4kaGzGZvkk9?=
 =?us-ascii?Q?6+HzEDb4WaQvBa5FxDaJmOKYb+aoVrvSB5N/riiEm5K6486wUJc/83+RHde/?=
 =?us-ascii?Q?nFwDp9tTczWPXqsu1+acfz+ORMDG1A+mZ9Mz/G8WP4Y8iGEImpT4zRMYU7Pw?=
 =?us-ascii?Q?R8xY1SwcXayGPm8CBmO2MYY7Uvtm8y+cMCRS8GcA/gN4sdoCvuqo8xsttSd9?=
 =?us-ascii?Q?njuG2J2tH/rzMM8yYUGGD7bROPBll5QAZeY756096l0ujcgAOD+pUE4pFRjD?=
 =?us-ascii?Q?7wOUCRZ23u+FQ0yqEdwnYdud1j+HMuxiMzKhyuiDbCM91PVqwMBv8JHIGZnh?=
 =?us-ascii?Q?CrueG5HSob0XHyrDioVT2PrN4TdxX5FmQB92VpkFjZlO9oWZzM0FTqfM1sYJ?=
 =?us-ascii?Q?S3Zk9nOjW1jFKULUN2F+Bx17Ak5nTNkqGsSj6xowJloXmRRSjkhZFlE5gOGY?=
 =?us-ascii?Q?Fb307Whr7Gz914lyDpsB7uW6HQ5Uv5n9JRd/lvlR+TTUPH0TgS987REjl6Co?=
 =?us-ascii?Q?v6F93U6lTaTqBtTL0QhKzWToBgwFuVWlHqSYwhC0mJUb751Cdw67YdBxbb/M?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b11bae5-c8b2-4fc1-4af6-08dc392d6a52
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 13:50:40.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXDKv2S2sY0kIlwoVEAMjL83JL7obZJJvO7fqS1eNM/MHuMJINXrzdOooFGeUg4GbH+JwKjJJ1RwnxrPOZUX3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/deadline.c:#task_contending" on:

commit: 0e52e2609c893e6e423dfcdbeabe05e5ecdbeb8d ("sched/fair: Fair server interface")
git://git.kernel.org/cgit/linux/kernel/git/bristot/linux dl_server_v6

in testcase: kernel-selftests
version: kernel-selftests-x86_64-d2f1c3c9-1_20240223
with following parameters:

	group: cgroup



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


the issue doesn't always happen (6 times out of 30 runs as below), we also
noticed there is another
"dmesg.WARNING:at_kernel/sched/deadline.c:#task_non_contending"
happen on both this commit and its parent. just FYI.


8384c98fed8762cf 0e52e2609c893e6e423dfcdbeab
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30          20%           6:30    dmesg.WARNING:at_kernel/sched/deadline.c:#task_contending
          2:30          13%           6:30    dmesg.WARNING:at_kernel/sched/deadline.c:#task_non_contending



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402291627.c8168277-lkp@intel.com


[  394.923885][    T0] ------------[ cut here ]------------
[  394.923908][    T0]
[  394.923910][    T0] ======================================================
[  394.923911][    T0] WARNING: possible circular locking dependency detected
[  394.923913][    T0] 6.8.0-rc4-00017-g0e52e2609c89 #1 Not tainted
[  394.923916][    T0] ------------------------------------------------------
[  394.923917][    T0] swapper/2/0 is trying to acquire lock:
[ 394.923919][ T0] ffffffff8514af18 ((console_sem).lock){-...}-{2:2}, at: down_trylock (kernel/locking/semaphore.c:140) 
[  394.923949][    T0]
[  394.923949][    T0] but task is already holding lock:
[ 394.923950][ T0] ffff8888073450d8 (&rq->__lock){-.-.}-{2:2}, at: sched_ttwu_pending (kernel/sched/sched.h:1623 kernel/sched/sched.h:1690 kernel/sched/core.c:3887) 
[  394.923957][    T0]
[  394.923957][    T0] which lock already depends on the new lock.
[  394.923957][    T0]
[  394.923958][    T0]
[  394.923958][    T0] the existing dependency chain (in reverse order) is:
[  394.923958][    T0]
[  394.923958][    T0] -> #2 (&rq->__lock){-.-.}-{2:2}:
[ 394.923961][ T0] __lock_acquire (kernel/locking/lockdep.c:5137) 
[ 394.923966][ T0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719) 
[ 394.923969][ T0] _raw_spin_lock_nested (kernel/locking/spinlock.c:379) 
[ 394.923971][ T0] raw_spin_rq_lock_nested (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:561) 
[ 394.923974][ T0] task_fork_fair (kernel/sched/sched.h:1623 kernel/sched/sched.h:1706 kernel/sched/fair.c:12681) 
[ 394.923977][ T0] sched_cgroup_fork (kernel/sched/core.c:4837) 
[ 394.923979][ T0] copy_process (include/linux/timekeeping.h:155 kernel/fork.c:2614) 
[ 394.923982][ T0] kernel_clone (include/linux/random.h:26 kernel/fork.c:2903) 
[ 394.923984][ T0] user_mode_thread (kernel/fork.c:2971) 
[ 394.923985][ T0] rest_init (init/main.c:695) 
[ 394.923990][ T0] arch_call_rest_init+0x13/0x30 
[ 394.923993][ T0] start_kernel (init/main.c:996 (discriminator 1)) 
[ 394.923995][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:543) 
[ 394.923998][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:485 (discriminator 17)) 
[ 394.924001][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 
[  394.924005][    T0]
[  394.924005][    T0] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[ 394.924007][ T0] __lock_acquire (kernel/locking/lockdep.c:5137) 
[ 394.924010][ T0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719) 
[ 394.924012][ T0] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 394.924014][ T0] try_to_wake_up (kernel/sched/core.c:4253) 
[ 394.924017][ T0] up (kernel/locking/semaphore.c:191) 
[ 394.924019][ T0] console_unlock (kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 394.924021][ T0] vprintk_emit (kernel/printk/printk.c:2303) 
[ 394.924023][ T0] _printk (kernel/printk/printk.c:2323) 
[  394.924026][    T0]        0xffffffffc028e0e1
[ 394.924031][ T0] do_one_initcall (init/main.c:1236) 
[ 394.924034][ T0] do_init_module (kernel/module/main.c:2533) 
[ 394.924038][ T0] load_module (kernel/module/main.c:2984) 
[ 394.924040][ T0] init_module_from_file (kernel/module/main.c:3151) 
[ 394.924042][ T0] idempotent_init_module (kernel/module/main.c:3168) 
[ 394.924044][ T0] __x64_sys_finit_module (include/linux/file.h:45 kernel/module/main.c:3190 kernel/module/main.c:3172 kernel/module/main.c:3172) 
[ 394.924046][ T0] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 394.924048][ T0] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  394.924051][    T0]
[  394.924051][    T0] -> #0 ((console_sem).lock){-...}-{2:2}:
[ 394.924054][ T0] check_prev_add (kernel/locking/lockdep.c:3135) 
[ 394.924056][ T0] validate_chain (kernel/locking/lockdep.c:3254 kernel/locking/lockdep.c:3869) 
[ 394.924059][ T0] __lock_acquire (kernel/locking/lockdep.c:5137) 
[ 394.924061][ T0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719) 
[ 394.924063][ T0] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 394.924065][ T0] down_trylock (kernel/locking/semaphore.c:140) 
[ 394.924067][ T0] __down_trylock_console_sem (kernel/printk/printk.c:323) 
[ 394.924070][ T0] console_trylock (kernel/printk/printk.c:2659) 
[ 394.924073][ T0] console_trylock_spinning (kernel/printk/printk.c:1923) 
[ 394.924076][ T0] vprintk_emit (kernel/printk/printk.c:2302) 
[ 394.924077][ T0] _printk (kernel/printk/printk.c:2323) 
[ 394.924079][ T0] __warn_printk (kernel/panic.c:723) 
[ 394.924081][ T0] task_contending (kernel/sched/deadline.c:254 kernel/sched/deadline.c:314 kernel/sched/deadline.c:511) 
[ 394.924085][ T0] enqueue_dl_entity (kernel/sched/deadline.c:75 kernel/sched/deadline.c:1061 kernel/sched/deadline.c:1921) 
[ 394.924087][ T0] enqueue_task_fair (kernel/sched/fair.c:6730) 
[ 394.924089][ T0] activate_task (kernel/sched/core.c:2150) 
[ 394.924091][ T0] ttwu_do_activate (kernel/sched/core.c:3796) 
[ 394.924094][ T0] sched_ttwu_pending (kernel/sched/core.c:3890 (discriminator 2)) 
[ 394.924096][ T0] __flush_smp_call_function_queue (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/csd.h:64 kernel/smp.c:134 kernel/smp.c:558) 
[ 394.924101][ T0] flush_smp_call_function_queue (kernel/smp.c:587 (discriminator 1)) 
[ 394.924104][ T0] do_idle (kernel/sched/idle.c:340) 
[ 394.924106][ T0] cpu_startup_entry (kernel/sched/idle.c:409 (discriminator 1)) 
[ 394.924109][ T0] start_secondary (arch/x86/kernel/smpboot.c:224 arch/x86/kernel/smpboot.c:304) 
[ 394.924111][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 
[  394.924114][    T0]
[  394.924114][    T0] other info that might help us debug this:
[  394.924114][    T0]
[  394.924114][    T0] Chain exists of:
[  394.924114][    T0]   (console_sem).lock --> &p->pi_lock --> &rq->__lock
[  394.924114][    T0]
[  394.924118][    T0]  Possible unsafe locking scenario:
[  394.924118][    T0]
[  394.924118][    T0]        CPU0                    CPU1
[  394.924119][    T0]        ----                    ----
[  394.924119][    T0]   lock(&rq->__lock);
[  394.924120][    T0]                                lock(&p->pi_lock);
[  394.924122][    T0]                                lock(&rq->__lock);
[  394.924123][    T0]   lock((console_sem).lock);
[  394.924124][    T0]
[  394.924124][    T0]  *** DEADLOCK ***
[  394.924124][    T0]
[  394.924125][    T0] 1 lock held by swapper/2/0:
[ 394.924126][ T0] #0: ffff8888073450d8 (&rq->__lock){-.-.}-{2:2}, at: sched_ttwu_pending (kernel/sched/sched.h:1623 kernel/sched/sched.h:1690 kernel/sched/core.c:3887) 
[  394.924131][    T0]
[  394.924131][    T0] stack backtrace:
[  394.924133][    T0] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.8.0-rc4-00017-g0e52e2609c89 #1
[  394.924135][    T0] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
[  394.924137][    T0] Call Trace:
[  394.924138][    T0]  <TASK>
[ 394.924140][ T0] dump_stack_lvl (lib/dump_stack.c:108) 
[ 394.924146][ T0] check_noncircular (kernel/locking/lockdep.c:2187) 
[ 394.924150][ T0] ? print_circular_bug (kernel/locking/lockdep.c:2163) 
[ 394.924153][ T0] ? data_push_tail (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2569 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3161 kernel/printk/printk_ringbuffer.c:661) 
[ 394.924160][ T0] check_prev_add (kernel/locking/lockdep.c:3135) 
[ 394.924163][ T0] ? print_bfs_bug (kernel/locking/lockdep.c:140) 
[ 394.924167][ T0] validate_chain (kernel/locking/lockdep.c:3254 kernel/locking/lockdep.c:3869) 
[ 394.924172][ T0] ? check_prev_add (kernel/locking/lockdep.c:3825) 
[ 394.924175][ T0] ? mark_lock (arch/x86/include/asm/bitops.h:227 (discriminator 3) arch/x86/include/asm/bitops.h:239 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4656 (discriminator 3)) 
[ 394.924179][ T0] __lock_acquire (kernel/locking/lockdep.c:5137) 
[ 394.924183][ T0] ? prb_final_commit (arch/x86/include/asm/atomic64_64.h:20 include/linux/atomic/atomic-arch-fallback.h:2615 include/linux/atomic/atomic-long.h:79 include/linux/atomic/atomic-instrumented.h:3196 kernel/printk/printk_ringbuffer.c:1671) 
[ 394.924187][ T0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719) 
[ 394.924189][ T0] ? down_trylock (kernel/locking/semaphore.c:140) 
[ 394.924193][ T0] ? lock_sync (kernel/locking/lockdep.c:5722) 
[ 394.924196][ T0] ? secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 
[ 394.924200][ T0] ? validate_chain (kernel/locking/lockdep.c:3836) 
[ 394.924204][ T0] _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 394.924206][ T0] ? down_trylock (kernel/locking/semaphore.c:140) 
[ 394.924209][ T0] down_trylock (kernel/locking/semaphore.c:140) 
[ 394.924212][ T0] ? console_trylock_spinning (kernel/printk/printk.c:1923) 
[ 394.924215][ T0] __down_trylock_console_sem (kernel/printk/printk.c:323) 
[ 394.924218][ T0] console_trylock (kernel/printk/printk.c:2659) 
[ 394.924221][ T0] console_trylock_spinning (kernel/printk/printk.c:1923) 
[ 394.924225][ T0] vprintk_emit (kernel/printk/printk.c:2302) 
[ 394.924227][ T0] ? wake_up_klogd_work_func (kernel/printk/printk.c:2265) 
[ 394.924230][ T0] ? validate_chain (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:3781 kernel/locking/lockdep.c:3837) 
[ 394.924233][ T0] _printk (kernel/printk/printk.c:2323) 
[ 394.924236][ T0] ? printk_timed_ratelimit (kernel/printk/printk.c:2323) 
[ 394.924240][ T0] ? validate_chain (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:3781 kernel/locking/lockdep.c:3837) 
[ 394.924245][ T0] __warn_printk (kernel/panic.c:723) 
[ 394.924247][ T0] ? warn_count_show (kernel/panic.c:717) 
[ 394.924253][ T0] task_contending (kernel/sched/deadline.c:254 kernel/sched/deadline.c:314 kernel/sched/deadline.c:511) 
[ 394.924257][ T0] enqueue_dl_entity (kernel/sched/deadline.c:75 kernel/sched/deadline.c:1061 kernel/sched/deadline.c:1921) 
[ 394.924259][ T0] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719) 
[ 394.924263][ T0] enqueue_task_fair (kernel/sched/fair.c:6730) 
[ 394.924266][ T0] activate_task (kernel/sched/core.c:2150) 
[ 394.924271][ T0] ttwu_do_activate (kernel/sched/core.c:3796) 
[ 394.924274][ T0] ? update_rq_clock_task (kernel/sched/sched.h:1382 kernel/sched/pelt.h:66 kernel/sched/pelt.h:80 kernel/sched/pelt.h:98 kernel/sched/core.c:748) 
[ 394.924277][ T0] sched_ttwu_pending (kernel/sched/core.c:3890 (discriminator 2)) 
[ 394.924281][ T0] ? ttwu_do_activate (kernel/sched/core.c:3878) 
[ 394.924284][ T0] ? tick_nohz_restart_sched_tick (include/linux/hrtimer.h:395 kernel/time/tick-sched.c:784 kernel/time/tick-sched.c:995) 
[ 394.924287][ T0] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:101 kernel/locking/spinlock_debug.c:141) 
[ 394.924290][ T0] __flush_smp_call_function_queue (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/csd.h:64 kernel/smp.c:134 kernel/smp.c:558) 
[ 394.924295][ T0] flush_smp_call_function_queue (kernel/smp.c:587 (discriminator 1)) 
[ 394.924298][ T0] do_idle (kernel/sched/idle.c:340) 
[ 394.924302][ T0] cpu_startup_entry (kernel/sched/idle.c:409 (discriminator 1)) 
[ 394.924305][ T0] start_secondary (arch/x86/kernel/smpboot.c:224 arch/x86/kernel/smpboot.c:304) 
[ 394.924307][ T0] ? set_cpu_sibling_map (arch/x86/kernel/smpboot.c:254) 
[ 394.924310][ T0] ? soft_restart_cpu (arch/x86/kernel/head_64.S:498) 
[ 394.924312][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:461) 
[  394.924318][    T0]  </TASK>
[  394.998201][    T0] dl_rq->running_bw > dl_rq->this_bw
[  394.998207][    T0] WARNING: CPU: 2 PID: 0 at kernel/sched/deadline.c:254 task_contending+0x6bf/0x820
[  394.999605][    T0] Modules linked in: netconsole openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp btrfs blake2b_generic xor coretemp kvm_intel raid6_pq kvm zstd_compress libcrc32c irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl intel_cstate nvme nvme_core t10_pi crc64_rocksoft_generic ahci mei_me libahci ipmi_devintf crc64_rocksoft ipmi_msghandler wmi_bmof intel_wmi_thunderbolt mxm_wmi intel_uncore wdat_wdt crc64 libata i2c_i801 mei i2c_smbus ioatdma dca wmi binfmt_misc loop fuse drm dm_mod ip_tables
[  395.004574][    T0] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.8.0-rc4-00017-g0e52e2609c89 #1
[  395.005380][    T0] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
[  395.006325][    T0] RIP: 0010:task_contending+0x6bf/0x820
[  395.006858][    T0] Code: fc ff ff 0f 0b e9 c7 fc ff ff 80 3d 91 c3 84 04 00 0f 85 c2 fb ff ff 48 c7 c7 a0 c2 09 84 c6 05 7d c3 84 04 01 e8 71 7a ec ff <0f> 0b e9 a8 fb ff ff 80 3d 6b c3 84 04 00 0f 85 6c fb ff ff 48 c7
[  395.008559][    T0] RSP: 0000:ffffc900001f7bf8 EFLAGS: 00010086
[  395.009136][    T0] RAX: 0000000000000000 RBX: ffff888807345b10 RCX: 0000000000000027
[  395.009876][    T0] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff888807330c08
[  395.010618][    T0] RBP: ffff8888073450c0 R08: ffffffff816cfe56 R09: ffffed1100e66181
[  395.011357][    T0] R10: ffff888807330c0b R11: 0000000000000001 R12: ffffffff85bf7158
[  395.012097][    T0] R13: 0000000000019998 R14: ffff888807345ae8 R15: 000000000000cccc
[  395.012839][    T0] FS:  0000000000000000(0000) GS:ffff888807300000(0000) knlGS:0000000000000000
[  395.013656][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  395.014270][    T0] CR2: 00007fa2265fff78 CR3: 000000089be7a003 CR4: 00000000003706f0
[  395.015008][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  395.015748][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  395.017413][    T0] Call Trace:
[  395.017764][    T0]  <TASK>
[  395.018083][    T0]  ? __warn+0xcd/0x2b0
[  395.018500][    T0]  ? task_contending+0x6bf/0x820
[  395.018983][    T0]  ? report_bug+0x267/0x2d0
[  395.019431][    T0]  ? handle_bug+0x3c/0x70
[  395.019868][    T0]  ? exc_invalid_op+0x17/0x40
[  395.020331][    T0]  ? asm_exc_invalid_op+0x1a/0x20
[  395.020820][    T0]  ? irq_work_claim+0x16/0x60
[  395.021289][    T0]  ? task_contending+0x6bf/0x820
[  395.021789][    T0]  ? task_contending+0x6bf/0x820
[  395.022272][    T0]  enqueue_dl_entity+0xa57/0x2430
[  395.022764][    T0]  ? lock_acquire+0x193/0x4b0
[  395.023238][    T0]  enqueue_task_fair+0x919/0xe70
[  395.023719][    T0]  activate_task+0xf7/0x2f0
[  395.024182][    T0]  ttwu_do_activate+0x11b/0x8c0
[  395.024657][    T0]  ? update_rq_clock_task+0x699/0x850
[  395.025173][    T0]  sched_ttwu_pending+0x27e/0x500
[  395.025662][    T0]  ? ttwu_do_activate+0x8c0/0x8c0
[  395.026168][    T0]  ? tick_nohz_restart_sched_tick+0x1b1/0x230
[  395.026754][    T0]  ? do_raw_spin_unlock+0x58/0x1f0
[  395.027256][    T0]  __flush_smp_call_function_queue+0x44b/0xb10
[  395.027842][    T0]  flush_smp_call_function_queue+0x68/0xa0
[  395.028397][    T0]  do_idle+0x118/0x1a0
[  395.028806][    T0]  cpu_startup_entry+0x55/0x60
[  395.029271][    T0]  start_secondary+0x209/0x290
[  395.029738][    T0]  ? set_cpu_sibling_map+0x2320/0x2320
[  395.030279][    T0]  ? soft_restart_cpu+0x15/0x15
[  395.030754][    T0]  secondary_startup_64_no_verify+0x184/0x18b
[  395.031339][    T0]  </TASK>
[  395.031665][    T0] irq event stamp: 1494506
[  395.032104][    T0] hardirqs last  enabled at (1494505): [<ffffffff814cd657>] tick_nohz_idle_exit+0xc7/0x190
[  395.033005][    T0] hardirqs last disabled at (1494506): [<ffffffff814e1c6e>] flush_smp_call_function_queue+0x5e/0xa0
[  395.033988][    T0] softirqs last  enabled at (1494464): [<ffffffff83c6c07a>] __do_softirq+0x53a/0x80e
[  395.034851][    T0] softirqs last disabled at (1494447): [<ffffffff8122b4c2>] __irq_exit_rcu+0x132/0x180
[  395.035735][    T0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240229/202402291627.c8168277-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


