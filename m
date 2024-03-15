Return-Path: <linux-kernel+bounces-104156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF187C9D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A757D1F2329E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02AB168DE;
	Fri, 15 Mar 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Im70ZKi+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F8168DD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490889; cv=fail; b=rk+pmrxeuRjVPytUL731vaAP6Z+LLJQJiyvDH4KJkSgPlxhYPMosc/xbFGHMbsXoyh3yphdGDyc5M69nwkL2hyF079RqbfVQ2wdNMNvkQLBL+dxl+IwTc7Hgh8NbAq3GkHnmxYjW0TdgDNMUJVda87PFaV7HGxCfsxbG36RkIDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490889; c=relaxed/simple;
	bh=J2iA8uLOmQJlFJiOqTO+y3ZUKbbJFit7u3yoDLQEjeY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VxX94lO+55KVSnxG9A/+fwOv27NJPxYRzUw5XB4AiXCkbOJL9GQCfPa4JcLUMVXgl612FtpKweq/4Ck+E2vHR2mVtpFKuhYvwhj3ubbx7RLcG8NJAlT+S950XzS13+21IIg6blZkQBWpi2jNflzki/JLAOpXybhG9yl+gXn6XRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Im70ZKi+; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710490886; x=1742026886;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=J2iA8uLOmQJlFJiOqTO+y3ZUKbbJFit7u3yoDLQEjeY=;
  b=Im70ZKi+8T4HWUIQcmnvYeI1Y09oZD1b08xitiPOkiSSlsm8ArRDSWFO
   ijHEYBB5BmhH9riwGY6FRak8zBQBZgCPEsut1NF0tCJugRNEMjRmWaC62
   BQYGo5aRqp9V4R81dcijtmFUJCa2hVGi2aBHFoTwwqoQkfPQbinRuAnWd
   96wo8afw9/FuxCFWTLGCrNrzp9TW6KinvonS76LBzi4DkU8cI1PtRlg77
   1Ui9L++DlKTp+GG+yiLz6C050EiZIdn5di5Ri/q4cmUuWRecl00Wzc83Y
   LXbKeryZDXhcf8+1PFkF+8UVWa+L5OduLn/B3ouKX0Y/Pc8pOx0oWY4lQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15992418"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="15992418"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 01:21:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12632799"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 01:21:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 01:21:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 01:21:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 01:21:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 01:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFnYWKa46GdyI/uw2pg+BceXQQP7gicU+4ruZE4WJsZv1r+OtsPOvjUaTh/C1HQb5cQV+LsiPK+lrMEyoXYWKH2nAjEDxR5NHqpNFh5RW6U4+w6MCu8F3QwHJjT8U+6isLIxXAdeq6D2Bln44xIOo5P0ocZgYVd+QXI1F/62MG4OY08LNixKIznyWo+reuhSrb6RX4JBfUC3Ua+8uKp0mNakqyLZZOXs9kJOeKDgyWD2IfNvvstq7g4brnwRW3q1w0J5ZP0PEtS2KEpGnYWoRgqHrXr5/ulPFlafxFEQ5FePkzyvgtEuNA1CDYFfAyb77GJRwjzvmHM/yzvGM3jsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4+l9iWMQYIQXsEikV94HHdUs0wBPnTP18+rSbpO5w4=;
 b=VKFEt5Je1DOebCE358WHFaA7ig0sbX46vcKMDU/tFzcA+MZMBpe0/SKpvoJ58gjjydKQXwcniOfGeL3AY4Nx+AFYOHuYJXx0340fQZRa3UkfxJE3ajOBykG/pYXLf+vFmfwKu8bpZ7Mm+ySzoZENO7VFc62y008AnyJwGHvgZjAcIcx0PZBN7GoSz1AJr9CHyLaN3dIBoDJEoQ96dKg8rvC6kvKCWF3Fay0BsjwqUUE9EkbQCVSf9PRwVdv7I/P1sxML+yvsowECzazNkhsIDJrT8xrOXwkvdidQ4tx7+7CnIluVvUy3GxqptlfxPxbZV1FqPsCF4RNUsts8Dds9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 08:21:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 08:21:22 +0000
Date: Fri, 15 Mar 2024 16:21:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [nvme]  63dfa10043:  fsmark.files_per_sec 6.4%
 improvement
Message-ID: <202403151552.e3809b61-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 42764ad6-b8a4-4b5b-92ab-08dc44c8e5ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2KRSxd1i1L58jzYVI6+MjejP6xWUwQcP/4V3wgRaCBu57YTIN8yxv7FORd+Y/2dfsvNhwKPeRn5MoiIZv/n4U7UwvHMQo6m+WizDomAMq5tSBnbRjP92HhQ+IRjUCqXmOKDDu5m0kq+eC669Bs1/PGt2a1APOa7brH3kVB6IMRUcgjM8bUj85Y4g9ngPRVqOWj6n4d5aHkw1m0On/krCw8RPBmk3ikAnfUn3QreWCe22eJoTZYuIRttxVE3q4P8Iv+mK+ri9IS96uZjp/NRFJTieu2pWaOaN+/+oGCNrLjre/L0fPvlUkYaXEM0Gn/uzbNY0OxrLf18Rl9h1vp3RFZR4jXZso3XCC9WGMpDBA/nf8V0qMmh0sf3rsXIQqOFm3F2Q0JHWwtqiVbRPk3tik6CCr99U1BsSP1+9yF9OwqTJWOEyzWMz9LkTW2z8yyVlsICzhQAL9GdFiz3QtA0LC4ApG141ZuSffmH3YIZxct7e81ZrqpyBkY9xuZTQLmCgJ2psqpADHTZu50NFs/pp3J6uottxFa1gvfLhLmPvQbYwh5DrA2mOuZzY7qHEbJDzQ/bPo0ZLbRp3zty008DBC6u95a9Hd8OG4hmghoyIHPUDCV6qs3XSveC6++wtMpz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?29VOB02kYUZwAU4Ap0vPsZkYiV/RoOn+7DToyAbxYOU7LqTtpgm53H6coX?=
 =?iso-8859-1?Q?p2fV1sxKowCnm2+nJDNIfMxbOiVQMaWDt+/rlQQqJo+JXOYs45qcW2bcdC?=
 =?iso-8859-1?Q?j1WFtt89s4aSsP3CptLZ5XhmBSDq3j16aj+okeA9QYyVKo9PMBjH/tDOGl?=
 =?iso-8859-1?Q?Cma5PrFg7FpdRQC6b8ZusZv5vde86Zsdub3m8h4FpczCGHESmWcEvf55+8?=
 =?iso-8859-1?Q?PAqNn7gIFmDvwes843RTd1HoC+6x1dT9pXCoEpHQ8h81IIAZnGYsYJs+jL?=
 =?iso-8859-1?Q?O6ZbakCjMAoIHgUHSJM3S1WdZYNe5ZdKHkuiAAnFA5ucSGkoe0acUxSbPn?=
 =?iso-8859-1?Q?c6VWAyBVlHgfnxC+0KZEdlL8xa4maIsakj82Sb0uOcr8Xwg8rV5rnx3zH0?=
 =?iso-8859-1?Q?nF0/o7R5I3VhbQ+F3fuya8dpcKKvuIWdovcgclpDfGVb1G/K8vkF6UWkbX?=
 =?iso-8859-1?Q?RmrGazxwKE9K7lxJUIazNqKFBcKGd6a9yQxztZGeXmVdK9YnIM8V70zE+O?=
 =?iso-8859-1?Q?xeO+40ZdksnJE8ec/riT48HyEbYeNeqwBDpFMYnA+jzEAwmiPREj8xKx1Y?=
 =?iso-8859-1?Q?dRwboYNdi4q1wYUx63y1MfAqYVbCI3kOmlmbmGOdUwOtzWJ86a57L2kaaf?=
 =?iso-8859-1?Q?IJOSMKdefjpTI1F/zTEKGE2ZfXcZazjte5BuBCoi3pcRShq/xagpzMfHu0?=
 =?iso-8859-1?Q?TdLuevSW0zdFywmjIZUpCbNkN67qyFqMvpvWq1ELhpJW01YdjeU4UK3mDS?=
 =?iso-8859-1?Q?vPIRJGX/+i2RaTff+SsDMfbMKpAugO40Azd7Uxj90UjBek+c/wm1BB4KGs?=
 =?iso-8859-1?Q?Ep4mv5+DMV/kTTnuGY3kK38BaiaaxKaeEiTVVlAVWQR/rWEeJFL4FrEmpY?=
 =?iso-8859-1?Q?32G2B1yPA1w0XzUcWymJ8fXEbNNT/eTVs/NgHcXdrCP7pLgDMthjDYIIhE?=
 =?iso-8859-1?Q?+mMZsmsURryTW9luy6dXk45BS+t/VXSkffLRPrffb9KH/7T/+GApJ+iWUH?=
 =?iso-8859-1?Q?vTf1l9vMYex6yO/ta68IDG5z7IXDkTWFxrCF4RWKfWkXvGK+RoO/MG08UL?=
 =?iso-8859-1?Q?IEZ1P8EVYD565A6ZZxaBWAZ5jv5LpA0jvH2opQVm+urv1np7ifqf5qBrQ3?=
 =?iso-8859-1?Q?/3HnCi2KL+QWCWZnqOibsXl0iYJHOgZZ549cA11eRMt1MpSJSviqt3guS6?=
 =?iso-8859-1?Q?aP/AFQB/5jUEzL3uueA73wUejBNUxymuqeqXDXMsxt7F4NP7CiPlBU1DPK?=
 =?iso-8859-1?Q?F7TZplyPJ6zaRfBgTSBRA4vKwOOiwSa61B9+BRle1bhHS8EAZUl8g/J/DA?=
 =?iso-8859-1?Q?zOu0joGKaSbw5Uz/hSCI3An/rio5dTdk4XgfUQKEKKLY4+xq81o29zKg/D?=
 =?iso-8859-1?Q?Ns7cB93jdYuPbiqi5lkUmYD22Q0iev7e/XfAgP13nJbxKkRJowTDF7fybu?=
 =?iso-8859-1?Q?dlgVgMKR3MxbBszqwvlrRWNqvRK/pm5m2vLrorXi6aKWO1Avqi+5T18lQX?=
 =?iso-8859-1?Q?VFDhznwhxHeh35ZStYdVgs3n8wR2FGxnzCPxrDUljk/W38TZinVL36N735?=
 =?iso-8859-1?Q?Mi0fqv7l+aXT0fmpCEQjIId3yWw5KB60EkLg2xt0euaqJYKoku414NP3IL?=
 =?iso-8859-1?Q?Hmvt30JYxWtE8iYhGf8dbTU1JLd0XtQFBF1d5AAMypYyAAaWVmNB2e4A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42764ad6-b8a4-4b5b-92ab-08dc44c8e5ea
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 08:21:22.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmkLB8BanRG80jX2DvLPMcRVcN5mQ8VIBu7FeUQ+DkzwU/ng99xvlLgG7QunKKIGM06rZUWxMHfu1zj02f9v8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.4% improvement of fsmark.files_per_sec on:


commit: 63dfa1004322d596417f23da43cdc43cf6298c71 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: fsmark
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
parameters:

	iterations: 8
	disk: 1SSD
	nr_threads: 16
	fs: ext4
	filesize: 8K
	test_size: 75G
	sync_method: fsyncBeforeClose
	nr_directories: 16d
	nr_files_per_directory: 256fpd
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240315/202403151552.e3809b61-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/8K/ext4/8/x86_64-rhel-8.3/16d/256fpd/16/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-csl-2sp3/75G/fsmark

commit: 
  152694c829 ("nvme: set max_hw_sectors unconditionally")
  63dfa10043 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard")

152694c82950a093 63dfa1004322d596417f23da43c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    492322 ±  8%     +15.1%     566574 ±  2%  meminfo.Active(anon)
    501325 ±  8%     +15.0%     576573 ±  2%  meminfo.Shmem
    458144 ± 18%     +22.6%     561659 ±  2%  numa-meminfo.node1.Active(anon)
    462634 ± 18%     +22.6%     567357 ±  2%  numa-meminfo.node1.Shmem
    114517 ± 18%     +22.6%     140395 ±  2%  numa-vmstat.node1.nr_active_anon
    115654 ± 18%     +22.6%     141838 ±  2%  numa-vmstat.node1.nr_shmem
    114517 ± 18%     +22.6%     140395 ±  2%  numa-vmstat.node1.nr_zone_active_anon
    396.50          +745.6%       3353 ±181%  vmstat.memory.buff
    201414            +6.0%     213473        vmstat.system.cs
     57760            +5.4%      60879        vmstat.system.in
     22022 ±  2%      +6.4%      23432        fsmark.files_per_sec
    502.56            -5.9%     472.94        fsmark.time.elapsed_time
    502.56            -5.9%     472.94        fsmark.time.elapsed_time.max
    243.62 ±  2%      +5.0%     255.75        fsmark.time.percent_of_cpu_this_job_got
    123079 ±  8%     +15.1%     141624 ±  2%  proc-vmstat.nr_active_anon
      8462            +2.1%       8637        proc-vmstat.nr_mapped
    125342 ±  8%     +15.0%     144138 ±  2%  proc-vmstat.nr_shmem
    123079 ±  8%     +15.1%     141624 ±  2%  proc-vmstat.nr_zone_active_anon
    140970 ±  7%     +14.1%     160889 ±  2%  proc-vmstat.pgactivate
 3.617e+08            -3.7%  3.483e+08        proc-vmstat.pgpgout
      2.10 ±  9%      -0.2        1.85 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.08 ±  9%      -0.2        1.84 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.99 ± 20%      +0.4        1.37 ± 11%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_do_writepages.ext4_writepages.do_writepages.filemap_fdatawrite_wbc
      0.50 ± 60%      +0.4        0.89 ± 14%  perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.ext4_do_writepages.ext4_writepages
      2.50 ± 10%      -0.3        2.20 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.48 ± 10%      -0.3        2.19 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.24 ±  6%      +0.0        0.27 ±  6%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.19 ± 11%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.ext4_block_bitmap_csum_set
 1.107e+09            +6.6%   1.18e+09        perf-stat.i.branch-instructions
    202521            +6.1%     214902        perf-stat.i.context-switches
 1.322e+10 ±  2%      +6.7%   1.41e+10        perf-stat.i.cpu-cycles
  5.46e+09            +6.6%  5.818e+09        perf-stat.i.instructions
      2.11            +6.2%       2.24        perf-stat.i.metric.K/sec
 1.105e+09            +6.6%  1.178e+09        perf-stat.ps.branch-instructions
    202013            +6.1%     214333        perf-stat.ps.context-switches
 1.319e+10 ±  2%      +6.7%  1.407e+10        perf-stat.ps.cpu-cycles
 5.448e+09            +6.5%  5.805e+09        perf-stat.ps.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


