Return-Path: <linux-kernel+bounces-124321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958B8915A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FF5B22B20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E03BBC3;
	Fri, 29 Mar 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LD3fFcOp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557E3FB32
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703985; cv=fail; b=lMq4EYaxW05lUfeMDjJKJFprn7YUoskBRTgmy57lFk1xjNMPkR3VdpQ0kmQr1TIM3C67CqRNhszSyQxEKJTp4j6xXGT9c51gVDR54BgaYiae1VmrY2lYnTMvaYWrrDXlECXjGDZrRgqdhtsqezPEEWw8K6gIqsAbg/2ry2UGIb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703985; c=relaxed/simple;
	bh=yWQDNM94ICHYRyOZ13YNUhWSlZ2gwtVODF+fCxnhcs4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=rx10kUiRa/ZAWMmz4vmYGNBm70/TwZtSg3ukOqzldOJGIdhKs/HDgfEqZAf/NRL0rj7SVgYzub7VmlgHtyZtvP99GV4EHiRTmucjTghjuV3yA+lWC0Zh16Ij8Md1VP/89geCTQCcZAlu/5Rt0xhU0IY6Fbf4C+tjWON5RpSl2HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LD3fFcOp; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711703983; x=1743239983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yWQDNM94ICHYRyOZ13YNUhWSlZ2gwtVODF+fCxnhcs4=;
  b=LD3fFcOpMmwXzuBJ5GgNZs/Jre0GEloH/nT0e680hp7M3I+o0ctWsrpr
   cU7/eDr3nnYEHupE5WJ6GUCgWwGwmVMf2zZSSnSA6Lrm3GPy72B1MZD7S
   kEH39CM0UFnS7P1/UmpB86SJzUle/p70ZcSNTTpxeFnVFEASml778ZQfg
   9QZFke7yeAtKRfOJwCIWpX+FOG8UXVXcjXslDXXylfqPreu4S3oOWg/PX
   IMxuVhSpNCBfAzW23FiF7bRmBkiMtTWQZSMIyuOYT+9HWbIVRvu1oeZvp
   CxLOZpnFcQO/mJ9bUlSRYwhJsIH+jDXjrf5tdhoXL7vGDdeRy6ak6riSN
   g==;
X-CSE-ConnectionGUID: AR68k+y2QSGVka4aKa4+Ww==
X-CSE-MsgGUID: 4m7bS+mJR7KMDYpY/6UUUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="29371585"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="29371585"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 02:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16971134"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 02:19:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 02:19:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 02:19:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 02:19:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 02:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqySStMg7fV+4/yVVO549B09bdO7O+5m+VW8Hq0RvjnBj/PxLK8GURtIdsFMPHvpif2zZ/yheEyMAZgxoKlwzKENUdWWTNlD1rbmDw9n4jNvVsC55A+8x4qZL4hvrE2+926DHX4O2ihAOqkk3xUIKkxEFh5b7svqaTQ4Fc3oX42QdV0iw2w4/GVL99vaXXOyPrrTzFH2Mq27WjDgYRn8gSbYh7cgVe7PPQbOVWD4GWjaV6L/XFcxeCxwmp0eM8plPz15kxmJSuuWS12DP2Agw5Upvq+FfYveYFxuwmL0phXs2o0ADbz3o0RIHfDByPZZrsWuS+GHonTsyFqeEK8N1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzoeSFKvUqh8VMnyIcaBj2kqj7LZN0gyb68dNLqylFE=;
 b=jUJRDk6RLl7ezZHqMDh152+ZatXOG4iASfj2dHLeKk0Ekb/iJmSrlsTnJCdLE9ztoXtBUFzcd0IsZtN49yVibaFjyEECAgLpqgBLzvdIFhFG2PVEVyRcdXn6KyDvYBsrwKw5TlLhKu1OHK8eBYxOG1Z6Z9omu6ISpAasGkk33624ndQqyjFkCNWT9NJDNfFN8lD0rJCmVHrTPqBjatxFDxa40ippGk15QI6IeCqvf+5FNV/1a6KHS/ym0Pxw1M51NRhoUA55QLFgHkeJN7oQnwFdUahdyR/dGqTtu+VhKYZuVEzD69FyYwRk/BI652eghrC1uT2hvUMFFcZqeRxq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 09:19:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 09:19:37 +0000
Date: Fri, 29 Mar 2024 17:19:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oscar Salvador <osalvador@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>, Michal Hocko <mhocko@suse.com>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm,page_owner]  217b2119b9:
 WARNING:at_lib/refcount.c:#refcount_warn_saturate
Message-ID: <202403291711.331cc50a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7520:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qyEmYs4Y9yAWwXzYnrhcCznRyMmU1h2d1CHDyIfPZqjsm3JDhQ7qtAkXAFxQzQ8Bt5p+IMRznYlis2klbuYBvqQFuuJFFjnj9LnuDuGcvp0XUuh/hnOdNK4mK3W3iwAUQtZM9Lvu4EbixMt87SezXezLxmuHFlBnBpFLe1LS68X4T+ZWzbbxbL9rY8Iu1gArGyVaAJGBQ+13t6gbbQdt1Yyh+rcSdhY2ApZVMTr83Z11M6KT65ukyqXxH5EBxmRDeEF9T4We4P7uGHQA+od/ldl6XnvzhwGEwWfpha++2tSJCCMF+mt03qK40PhNkdB0xXC/FAnLXJhlN8P454yIp3wzFzyfxl/C5fCupD1w2YeAZchSbs1OSUgV4C3Yg+2DqhF4NSvX87qAtenUM3YEC25FfRmnE+aTRn1y5vdEkIoIBvqpuCq9W0AYktHgT55MbGDKoMg1pcmlvpRuk/emP3WPIz2iWLjhaS26hHO9VtIIaHcorDG+rGMxudrKDEif8k5GNc6l+bx6/UISjSmaYRsCxaW8R8M3gVJnoDAFeqeyb0hNYMVkMnNVDYJcdMOMf0L5ez5rNxBAnE7ILQHVRNXoydZa8Sxs3pN9gjYman6pF64xkEOwNZpzn/KDxHP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/h1o5S5VK1ip/G9N0IeqoEpob9pZf/csScr98QD+WTP1ry4+Rq4Gbc4yUswk?=
 =?us-ascii?Q?vjOo6XOAjbtIGWnLuRCKGb71yvIGN9jN7S/ZAcU17KA4FX4vi3bZSqmAfDwv?=
 =?us-ascii?Q?nhi3XdCsxHXTuDdx45yl66eA9TFQrP9tbqbCouVbA6zqSzAlfOVgb1Tk71Hg?=
 =?us-ascii?Q?AMXtwCSOM2VCJYQjFu9smOSkgdtJYBUbmZWftMxE1UibdE7ExBr8vs+GJ5Ua?=
 =?us-ascii?Q?yM+jxSgrWfbuSgGzJNb7rOzPtca5FPBYymYaMQ3E3BXL0Tg6nmAlfrvvoDiO?=
 =?us-ascii?Q?l8Zn1yHM3SgNjku8UmRZ8849lokI+s0TIAOHyTRFCAF1SAwN+xoytjHSXLn8?=
 =?us-ascii?Q?Ozn1r5MNgTpe7kBYkcgx9ZLFAo88qaztqbrBHSd14+JpNkmPiTsKYyUJiyQ/?=
 =?us-ascii?Q?/yqIx8EpjT01mumBxlKNURj2BSUAehGbiPxFg2PJe0vGjGGekKXSuljbmnoW?=
 =?us-ascii?Q?gZWytjM44tSCKAReMDluuvuyIKLAbh+k7RMuwQGoj5i5aH8AX5ZbqKBcxxL4?=
 =?us-ascii?Q?4YnDDaZt4BmziMR6nLLvBO/TDTHztI5ZV0C2MjF2AZHSjtGVpwDl+Lpmphi6?=
 =?us-ascii?Q?csrlnRLVROg2v2cQh8XHvazg9muLZJSs5+HsANMuwpMIk84VftQgStnzsXeP?=
 =?us-ascii?Q?jmNh/yuSzCS+OGRki1k1g9zGj0HjgKXcGL5VZOrFAq+A+dlEMSRG5Dg6F0qx?=
 =?us-ascii?Q?ubr4D63qugFfOKMsJVhmU6iVmUMNh0l+/OJV75zSFHu1IZH85PWUGK9HD+S3?=
 =?us-ascii?Q?eK96vH2JowegBZkrqhQmcSndL70zxSNlwkJ8UkEDRFBjvQf9pPs0Qf72paHQ?=
 =?us-ascii?Q?x1RaHY46LKJBq/9203wUQJk7QMx/QVXYoIDArZ4XVmtOuvUklodxVe7g2WoK?=
 =?us-ascii?Q?up6bFPkOQGFr1lbRtegTMsif5ZKwOcAyUXV/x9elzTZGxtVcv0RHrtw9HNan?=
 =?us-ascii?Q?r57aXMOS44/0e9iEXlynJjr/7vt/7Xp0bRLFb+DosZIRQ+4yVpJEOKLwrRCI?=
 =?us-ascii?Q?XsQVve/AnX0RswT5i4s0kKRwXUlvj78KPsosp1WFmk5bz8ANP1Tyy+XdudNn?=
 =?us-ascii?Q?Ct92TMnY6/+uX8gFM/rTiA4PfKgV6j8hEHTRQtuMso8KZzkcFGr+FIr5/3gG?=
 =?us-ascii?Q?cqknAMH/ACGlId01jrkzYq/ONpCdDiD612PJiXtwmV0eaB625eQQNVHTZAt4?=
 =?us-ascii?Q?e0xFgMGK+FEGHFpPJFCmEJuDNDP8REMYDSR7xNJzlNb/x8Sq4x57yaT4+aTi?=
 =?us-ascii?Q?x0P8ryNdQO2BNS8B/S8WbbdXEnz/sKEOKaqquXPY9ufRkSGtaXDfvcEMlZxX?=
 =?us-ascii?Q?9MbFc2uudDLeo0Qko0M3nRy0PVZXb0viNsCE61R8TkOANJB/mueVSjeai6Ij?=
 =?us-ascii?Q?mAXUSHj56tuB7CFi7Jqzv4S138pH/gWlKs0Jnhhf5tA3vJ/zoJTUfToNQyPM?=
 =?us-ascii?Q?h3AHKhfcqxAAfMJaOruatRVrqMFPYSXTkbaY/W2hp743XH6B9ZfE7VVszYUr?=
 =?us-ascii?Q?dQpXoemO0EtfRi32SEj6XSzcSIeXasxzmrSI8DDUgpcmb7a+llWkn3pt4uTD?=
 =?us-ascii?Q?xclU2QN95opWKHi5rONWML9OQfnLPVvFynKHqhC3dcNxYaDbF8Lj0cvfsinQ?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7c3523-799d-4dc8-2873-08dc4fd15af8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 09:19:37.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xk1lF/n2mN2pvPmIeHsXBbx9NYIVjS2khfUfC7Ev58m82RTMpqd9209zUP9c0TzWgDPnoWLWaogF52aDG63bWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_lib/refcount.c:#refcount_warn_saturate" on:

commit: 217b2119b9e260609958db413876f211038f00ee ("mm,page_owner: implement the tracking of the stacks count")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 4cece764965020c22cff7665b18a012006359095]
[test failed on linux-next/master 13ee4a7161b6fd938aef6688ff43b163f6d83e37]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: tasks-rude



compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------+------------+------------+
|                                                                 | 4bedfb314b | 217b2119b9 |
+-----------------------------------------------------------------+------------+------------+
| WARNING:at_lib/refcount.c:#refcount_warn_saturate               | 0          | 114        |
| EIP:refcount_warn_saturate                                      | 0          | 114        |
+-----------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403291711.331cc50a-lkp@intel.com


[    1.321723][    T1] ------------[ cut here ]------------
[    1.322406][    T1] refcount_t: decrement hit 0; leaking memory.
[ 1.323164][ T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate (lib/refcount.c:31) 
[    1.324262][    T1] Modules linked in:
[    1.324770][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.8.0-rc5-00257-g217b2119b9e2 #1
[    1.325884][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.327143][ T1] EIP: refcount_warn_saturate (lib/refcount.c:31) 
[ 1.327824][ T1] Code: 83 c4 04 0f 0b eb 09 80 3d 40 5e 2a c3 00 74 06 5d 31 c0 31 d2 c3 c6 05 40 5e 2a c3 01 68 90 59 a8 c2 e8 db 91 a2 ff 83 c4 04 <0f> 0b eb e2 90 90 90 90 55 89 e5 89 c1 31 d2 b8 01 00 00 00 0f b1
All code
========
   0:	83 c4 04             	add    $0x4,%esp
   3:	0f 0b                	ud2
   5:	eb 09                	jmp    0x10
   7:	80 3d 40 5e 2a c3 00 	cmpb   $0x0,-0x3cd5a1c0(%rip)        # 0xffffffffc32a5e4e
   e:	74 06                	je     0x16
  10:	5d                   	pop    %rbp
  11:	31 c0                	xor    %eax,%eax
  13:	31 d2                	xor    %edx,%edx
  15:	c3                   	ret
  16:	c6 05 40 5e 2a c3 01 	movb   $0x1,-0x3cd5a1c0(%rip)        # 0xffffffffc32a5e5d
  1d:	68 90 59 a8 c2       	push   $0xffffffffc2a85990
  22:	e8 db 91 a2 ff       	call   0xffffffffffa29202
  27:	83 c4 04             	add    $0x4,%esp
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb e2                	jmp    0x10
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	55                   	push   %rbp
  33:	89 e5                	mov    %esp,%ebp
  35:	89 c1                	mov    %eax,%ecx
  37:	31 d2                	xor    %edx,%edx
  39:	b8 01 00 00 00       	mov    $0x1,%eax
  3e:	0f                   	.byte 0xf
  3f:	b1                   	.byte 0xb1

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb e2                	jmp    0xffffffffffffffe6
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	55                   	push   %rbp
   9:	89 e5                	mov    %esp,%ebp
   b:	89 c1                	mov    %eax,%ecx
   d:	31 d2                	xor    %edx,%edx
   f:	b8 01 00 00 00       	mov    $0x1,%eax
  14:	0f                   	.byte 0xf
  15:	b1                   	.byte 0xb1
[    1.330164][    T1] EAX: 00000000 EBX: ffffffff ECX: 00000000 EDX: 00000000
[    1.331017][    T1] ESI: e43cf13c EDI: e43cf140 EBP: c42c7b3c ESP: c42c7b3c
[    1.331861][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
[    1.332806][    T1] CR0: 80050033 CR2: ffdeb000 CR3: 033f8000 CR4: 000406d0
[    1.333731][    T1] Call Trace:
[ 1.334175][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 1.334721][ T1] ? refcount_warn_saturate (lib/refcount.c:31) 
[ 1.335390][ T1] ? __warn (kernel/panic.c:236 kernel/panic.c:677) 
[ 1.335913][ T1] ? refcount_warn_saturate (lib/refcount.c:31) 
[ 1.336577][ T1] ? refcount_warn_saturate (lib/refcount.c:31) 
[ 1.337253][ T1] ? report_bug (lib/bug.c:199) 
[ 1.337890][ T1] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 1.338464][ T1] ? handle_bug (arch/x86/kernel/traps.c:238) 
[ 1.339014][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:259) 
[ 1.339612][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 1.340246][ T1] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 1.340819][ T1] ? refcount_warn_saturate (lib/refcount.c:31) 
[ 1.341496][ T1] ? exc_overflow (arch/x86/kernel/traps.c:251) 
[ 1.342130][ T1] ? refcount_warn_saturate (lib/refcount.c:31) 
[ 1.342796][ T1] __reset_page_owner (include/linux/refcount.h:?) 
[ 1.343423][ T1] __free_pages_ok (include/linux/page_owner.h:?) 
[ 1.344021][ T1] make_alloc_exact (mm/page_alloc.c:4811) 
[ 1.344621][ T1] alloc_pages_exact (mm/page_alloc.c:4840) 
[ 1.345228][ T1] alloc_large_system_hash (mm/mm_init.c:2530) 
[ 1.345973][ T1] inet_hashinfo2_init (net/ipv4/inet_hashtables.c:1171) 
[ 1.346595][ T1] tcp_init (net/ipv4/tcp.c:4707) 
[ 1.347117][ T1] inet_init (net/ipv4/af_inet.c:2031) 
[ 1.347657][ T1] do_one_initcall (init/main.c:1237) 
[ 1.348259][ T1] ? ipv4_offload_init (net/ipv4/af_inet.c:1954) 
[ 1.348879][ T1] ? blake2s_final (lib/crypto/blake2s.c:58) 
[ 1.349467][ T1] ? extract_entropy (include/linux/string.h:276 drivers/char/random.c:697) 
[ 1.350154][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 1.350777][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 1.351397][ T1] ? look_up_lock_class (kernel/locking/lockdep.c:926) 
[ 1.352036][ T1] ? register_lock_class (kernel/locking/lockdep.c:1284) 
[ 1.352682][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 1.353315][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 1.354002][ T1] ? lock_acquire (kernel/locking/lockdep.c:5754) 
[ 1.354583][ T1] ? stack_depot_save_flags (lib/stackdepot.c:?) 
[ 1.355268][ T1] ? stack_depot_save_flags (lib/stackdepot.c:671) 
[ 1.355955][ T1] ? lock_acquire (kernel/locking/lockdep.c:5754) 
[ 1.356534][ T1] ? __create_object (mm/kmemleak.c:?) 
[ 1.357147][ T1] ? kmemleak_alloc (mm/kmemleak.c:764 mm/kmemleak.c:1044) 
[ 1.357789][ T1] ? __create_object (mm/kmemleak.c:756) 
[ 1.358387][ T1] ? next_arg (lib/cmdline.c:273) 
[ 1.358938][ T1] ? parse_args (kernel/params.c:153) 
[ 1.359515][ T1] do_initcall_level (init/main.c:1298) 
[ 1.360114][ T1] ? rest_init (init/main.c:1435) 
[ 1.360655][ T1] do_initcalls (init/main.c:1312) 
[ 1.361218][ T1] ? rest_init (init/main.c:1435) 
[ 1.361842][ T1] do_basic_setup (init/main.c:1335) 
[ 1.362417][ T1] kernel_init_freeable (init/main.c:1555) 
[ 1.363039][ T1] kernel_init (init/main.c:1445) 
[ 1.363590][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 1.364154][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 1.364745][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[    1.365365][    T1] irq event stamp: 392969
[ 1.365990][ T1] hardirqs last enabled at (392981): console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 1.367067][ T1] hardirqs last disabled at (392990): console_unlock (kernel/printk/printk.c:339) 
[ 1.368145][ T1] softirqs last enabled at (392390): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[ 1.369283][ T1] softirqs last disabled at (392381): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[    1.370465][    T1] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240329/202403291711.331cc50a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


