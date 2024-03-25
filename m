Return-Path: <linux-kernel+bounces-116515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70388A048
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4444E2A5BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8416A17C6B;
	Mon, 25 Mar 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlUnwc22"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391B1C09C6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341087; cv=fail; b=gh6WkGfbZlQKLafh6vS+s53rIyjEHtSG14pTrWt8fL6zoE+jqC3WdT57LS02NIAIDsiXYwltbwW/PDummSo0NtMb/41QK+CPQ1LUuN1MpLXdoQftAc59XNKGPXvIaCLxSINHOSitXDBFtebJZvwEnDS/DzjVTnGlp03oVuCmc/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341087; c=relaxed/simple;
	bh=sR7fSGILa+BQrHpjOXoM80koYNy9wa0B3U3bcnT1WdM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QC6/+r23nqh8Kz0DJmVBjB5vGtII62eXkDcDn9eXdIfE1ZFGBvSfQC4yFzBoMPFcnhFSGTyl3+y1M4kskHOP62YckwqmmJPbwpkJBHtXbdb2wCzmQeINxGumsV/wFtiYGK+N+lriOLqO2zGGb3EsXIX94n0aWSBqfRPdu1v27S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlUnwc22; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711341086; x=1742877086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sR7fSGILa+BQrHpjOXoM80koYNy9wa0B3U3bcnT1WdM=;
  b=IlUnwc229yUpJvVLh3/V4Mlem0HXBts137W6fCD8hNSXE8USJhBgKevV
   G5sipbhJTXSO34WcUwQGUMMxrE9Bwd7Sh4z6ygIyz2uAQCKdqROGp3fch
   /m30gjL2VDEUeW8eaKvRRxdYarpIyz3ayQcRT7lLCEbdULplqrkzvd+l3
   cynkzRaAmqNvg9pE2ApPOz9Fbto66fDDycNsqm/ROVx7PedBrH5EW1dbC
   F4y7QF5Bbxlv+oqYfNOMflcfbgumExGIj1tr/9LHVdTbkuWv42mLGUOXr
   OcetBfs96xKSF68A3NcCj+hOPKgyVwPGT4V8m7UvMtO4+QqrtwQCjhqa8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10119822"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10119822"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 21:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="16152285"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2024 21:31:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 21:31:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 24 Mar 2024 21:31:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Mar 2024 21:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9r9p3q4c5CIieoTi64DcOmi9Ni+BCCwUTDBVal/dbATPSHNpNJZTeFi+Ae2HwoYDIhZ3Q7uc1f4pKWzlEZ1X91pAFpTP521pcM237OSYlOCKD3KUFpN0OiyyUdVfXPK4C5X+jvqw4OiRAS6riUkjmtzBTnZE8hoPCbBjjJ3/ZcsicrkPSjVJ1sppvp6Y2gl5DjVt8+6JU0X/DdC/7GNrif1lZh8y9VI4GogvkEM0UZurOQyN3rx44jUz5joQVuQbZ88I7hzY45fRwNMQxabEEhpabrvjaSBWYcEt19ofqEnAzoT2AKqJagfSzCdC7LcleZqKCZP3Cc1hMUgP2dZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO4RYVsdCydfnxkuY65fvmvNWbtsrDLiGQsa5fXb6d8=;
 b=SwJyAsVCVJnv8RzcENyNGiqknZ8V1xU6BizgVhV6/tobpDjRhOfng8chbWNS/jTy6n2UA2S4K3O9BPEvOs9OOu+MC/rfKxOwqarPuJicoZwfEKIB/NDY4Hsor9x1dnXiGCC1oYRDVc/3MkH4wXTtYYUAgzzofO9vVdYCdPp5jYTroAvDw1+nRRBTeZBt2IOFhyREMjbUXwV2XnUK68l3sakBktlnXGm3zgAbaMLZZI9hTfWZsjanfx99rCj77HtrOZeSIibIHNd3kQ9AAjK/jvi48CM8mV4V+09okYX04eDhwCvXX1Yjyi63cavOu3yxqNKERf4lGuHmElakexOS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7649.namprd11.prod.outlook.com (2603:10b6:8:146::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 04:31:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 04:31:20 +0000
Date: Mon, 25 Mar 2024 12:31:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vishal Moola <vishal.moola@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, Muchun Song <muchun.song@linux.dev>,
	<linux-mm@kvack.org>, <ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linus:master] [hugetlb]  7c43a55379: ltp.hugemmap10.fail
Message-ID: <202403251148.ecf856b-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 96048115-68ec-4da1-fe93-08dc4c846bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEe3k97pwpmDjELSBcrhFDod8RAIxFGIftsvYMdrUorkJICzBmivLyEP/WvfQ/sghHclRluRX84ldWydtaORTPD2sg7AewpqJ4vzRjFgjKzzMTNr5KnEIF9Ff3mrmArNXeknE+pVk653bbq0qzhc96/nu1hh0+M38yX1rhPUb5fEzCY/Ns0+nZMp3jgbFxdOx9JxI80P+oaogiA8ghJxa9nsqkbNMouArEpcg1wzmArJk5hsMEzasqp0hpl0+LAVt9s1zawJEr2uW7XmZj4xpjrNeJuQT72qHtxlI05phg3eyZITNdLWBVkaAm8uDHxzNdPGRr0bXNJE1bmLwJT4HP3nwFTu5LcI0gecf1xfMJIym/pCa4mEhn6PHqmvkpSCEfi/uwDEfHmvq2oeII6iiT+WhArc8gORka+HBM59qcD6+scXm5MSHDIQ4xopEHFVZ8v+uIHLhDPyT1WeVVN6e6ULc6jsTnUl08dsD3+zXvZXPuN5IT24bCC8/6Dp7WmbxAsMR61IQYfGo/+We3gjEI5V8+1nYV9uR3wcTJEH3x9CMtwRX+vhDzkEwL1N/IpS9loNXZpILJLeDuCQJ6RVPYyDZmicx3mfdaeVfgHL807g8zQ/sdxd5Xq7WnkZnxnJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yBGzJXIOlmUg31AL40/gimrAFTStxfMN6h8HffEuVBhB7meerObYwX6a26gD?=
 =?us-ascii?Q?NISMZ3whI45YiM5lc+Az4DQqYfQh/BSfF7pLRHpJ4xPZ/ScC8W5GMVwtiT78?=
 =?us-ascii?Q?HRE6xrBZiSTVx8g5UY4bFWGWLpbJtRH9XeQRJu/Zr350CvT+1BPfRTnA/6Fk?=
 =?us-ascii?Q?q0QhwQKHaIxPXp2oHcU4B/DLzrYg1rPg0r+vm7qX+2tbhzFX3RkhGmQoFets?=
 =?us-ascii?Q?s4Gdbqu8zsRxlkl6STl/Q7kwGYxlIJtgn4jxmvKrrjYPKu2d8gKcu2atSJg+?=
 =?us-ascii?Q?fPCKB+rC6i8zVK1/PtGIxSkafF0ubluO1eFh8FSUP4Be0E3tjNX1TOfTfufj?=
 =?us-ascii?Q?PrjsoaQu0iy/KdYMf4gH/zmuLAT1Lgtkfp1h0pRVaBIrlUTsvwZQW8kuUniC?=
 =?us-ascii?Q?I3m4urbL9kY+0EaNfGn+K/8KHr/sb+22wMN040DybEQ/qVb9CjCtn0+i58mM?=
 =?us-ascii?Q?KA2Epn1dBbKusmNOqsJVGxEMskr5JvzLW8RUQPY4dhrytmsU3Ac3Dd25nF6g?=
 =?us-ascii?Q?8ZH1XBYGU3czNMO88kODGG/SXjhw6Po10WLZaQ7CywNGtJAQiarMeyKT7LtV?=
 =?us-ascii?Q?4tuZLseysa4yVN+QMu6FXTcOsRFsk6QJnC9wxRUFLwljNXiPHl7kVuAyXFmi?=
 =?us-ascii?Q?rw7srFklAMyn5uHDQfY1f9Nqmn4/7rRYPUYL6ZeP6bEwQE5hrku24Erb6J6N?=
 =?us-ascii?Q?sTFs3rk9TkiVSD1D2KCUNSMD0VhrV1gTTe+v1JS61DxcHQoTjkcdQ4thMZR6?=
 =?us-ascii?Q?DCsIBSDNX1Eh1NNeDACRspA78CP9G34rlInu71MWSghL9bUVd4bzeNRhn/EC?=
 =?us-ascii?Q?R0xHcHA49WWUDulTr7FcZuhJD0rPs4MXOzU9bnfHCFNd4smiNhZ32oUr4KyO?=
 =?us-ascii?Q?RB0xjPg1AhIECqre8Ra0THdyOcjliaS/yuidtGyX5WnPMYkLsN2DPE+3Bmz8?=
 =?us-ascii?Q?A5qRfjb5HKbH6aZgOMbUP/UphAn3a1yOFSx2MaM6cfOH3EHMnX32IcyLJk9I?=
 =?us-ascii?Q?YaDJLTmGLyX1Uh+UqSTFyUVhToSzWKxypDeqeSJfLFZmHTWpatW4qfjHna9u?=
 =?us-ascii?Q?rHSwyeQfK2BHdZ5tn3XqBKjmmpJm5ydZf20IFFeAJrEOKmdb7A0L+wBmy9CD?=
 =?us-ascii?Q?rzm0pZc6COkggqdSkZiRSQIcLUL7CuA5Wuwa7GBzw7e4YKQCS8fSSkLucQDa?=
 =?us-ascii?Q?+EpJYi8ljsfhuxGVTdLc4I4Utru4XV92X8fqZbB3CSPb5VyevYgPvjuCfGFE?=
 =?us-ascii?Q?zGHqw65ixaZehWVXumVv74zeqXaraBCRutCzqOf0y0mwjJ6vlNC4KBF1FHwo?=
 =?us-ascii?Q?+2kszCu5MiTP9qlhzPzjxG1lOH0LwdlTilFmVTqhnxBMWvpyNNfnubGXQy7d?=
 =?us-ascii?Q?r1QyOeCwg9QvK9P3WUHdJJCZ7wrydaYJVKHSjQE6k34VeQadYSE2SLlNx5d8?=
 =?us-ascii?Q?cnhDRXb9yT2zyGrKMd0dTRPdVC9trVsdQrGIiI6a6KjTor3W3nlDY7v3Qj6b?=
 =?us-ascii?Q?KOmyKvX8XvC5jurLeA21OjVxyvu5eHHIIbQA177IFqNfStOo+h5kBrTikYx/?=
 =?us-ascii?Q?ngzamoI8I4UXJwls2rC+fLHczNPkbefkxvFpgNzBS48UvDysMnArBLFHLiQH?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96048115-68ec-4da1-fe93-08dc4c846bc2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 04:31:20.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQMoqLlNP/1+PA6hkA2DWe41UrNoO/CR1j9vu4J1Ec1dfH03LuuZrsvScv1bYGsLdxicXrgDybBI+hVsPeaHow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7649
X-OriginatorOrg: intel.com


hi, Vishal Moola,

we noticed you mentioned in commit message:
    This patch may cause ltp hugemmap10 to "fail".

this report is just FYI what we observed in our tests confirmed it. and the
failure is persistent:

9acad7ba3e25d11f 7c43a553792a1701affeef20959
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     ltp.hugemmap10.fail


below full report is just FYI.



Hello,

kernel test robot noticed "ltp.hugemmap10.fail" on:

commit: 7c43a553792a1701affeef20959dfb2ccb26dcee ("hugetlb: allow faults to be handled under the VMA lock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240316
with following parameters:

	test: hugetlb/hugemmap10



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403251148.ecf856b-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=hugemmap10 stime=1710711668
cmdline="hugemmap10"
contacts=""
analysis=exit
<<<test_output>>>
tst_hugepage.c:84: TINFO: 3 hugepage(s) reserved
tst_test.c:1049: TINFO: Mounting none to /tmp/ltp-IEy6i3InfS/LTP_hughDiU47/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:1741: TINFO: LTP version: 20240129-104-g14c710cae
tst_test.c:1625: TINFO: Timeout per run is 0h 00m 30s
hugemmap10.c:388: TINFO: Base pool size: 0
hugemmap10.c:315: TINFO: Clean...
hugemmap10.c:366: TINFO: OK
hugemmap10.c:315: TINFO: Untouched, shared...
hugemmap10.c:338: TFAIL: While touching the addr after mmap private: Bad HugePages_Total: expected 2, actual 1
hugemmap10.c:338: TFAIL: While touching the addr after mmap private: Bad HugePages_Free: expected 1, actual 0
hugemmap10.c:338: TFAIL: While touching the addr after mmap private: Bad HugePages_Surp: expected 2, actual 1

Summary:
passed   0
failed   3
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=277
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240129-104-g14c710cae

       ###############################################################

            Done executing testcases.
            LTP Version:  20240129-104-g14c710cae
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240325/202403251148.ecf856b-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


