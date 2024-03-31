Return-Path: <linux-kernel+bounces-126085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60D8931FA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85ECC1C21345
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C51145330;
	Sun, 31 Mar 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAToqb/x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D11144D28
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711895373; cv=fail; b=X3f6179rUF7Yf+uLlni/169wFZwdeDY0m9Q6XoWMK9ZGGau35uRB0oh6ixQ52/Gbe0igJ0LFtlVaXDb1oq8lwFmAQ7bKiOj7uX4wmSPJgphlAdsO4z4rV4uCvqyDobTdjURXyqkcazsAeyYD2H4Qsw8FvoOyBmJBCR3kN8Eq1RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711895373; c=relaxed/simple;
	bh=kX2MlW/zIrXppSouLZf0rpWEPBYMH0/ok1/wcxBKVWI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=rupPOntjhzN5xkUfwY/JzzRT3sCeC8BRQZUPlGaUSRAnxBZmyqEMazIRIVuGyHAkXtuGbNy/pDNbd4s+FXwCj+fBCJRTIDFEVgWr7n7nShgjwuGZUahS5pUViD3tLR3h63tYTi/oBtqKt7aAhiPW8oZBNNM23VyQXnTP/imwHGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAToqb/x; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711895371; x=1743431371;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=kX2MlW/zIrXppSouLZf0rpWEPBYMH0/ok1/wcxBKVWI=;
  b=YAToqb/x/1E17vSY7tc8K8YHEptUmIrhiZC7zssGM2eEMjjLQn3hqbE2
   R+lelp2b8QO87G3m14Zt9d9MhpRvn4BtgUMrVS1xl9Edy1SD4scl4djhw
   RkB7yfk1BH7XMh6xnObY/XH9WMznfUXgR62BhY12QqCvfqgzlfyQA4tEG
   zNLPXkIjAM9rIp2+z49aZFYH7U0bxRYNHLKDCAwFDlG5mCXXxlD7ux2lm
   Xu898OchBpNE2uZtzTufL2lWCHACeoAiv1qyLXiyH4OEm5pQPsOwqmVnE
   aWII64j9hvFo152NF42RLYfQ854eMxmir9CQY9hRZo83fddCBK1nX3h+/
   g==;
X-CSE-ConnectionGUID: n/CddQnoQ9y769RZAa+cTQ==
X-CSE-MsgGUID: qBHfG2wOSUGDs7AffAu+sQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6889280"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="6889280"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 07:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="22153298"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2024 07:29:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 07:29:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 31 Mar 2024 07:29:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 31 Mar 2024 07:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSh1R4l1hydiAa9vWYaMnWBPik7gXQWa6nIq7QsfezPFnlgPtoQpiWAOyVs8eAP6hSQfvuTIouCWrWcuWBv6z8wQctj/+Ou2louGPpDLjwwB/FGLhiJqhVA1/KbpRNWw16+dKoCN3YlXJ80loc0zbfEUsl2yJTSDGiocOoiEI08Cn5QW8wnMGmhaWohh8vsgByW5U6qBjp8+83hwgbrK5mKF8K4337nIpFQjVyekcWI6gXK3TRa71GK3PYUg6XOFZTiJkVUpOd++JCk5o6/iW5uSY/1B1IH0juTrq8Xr8CGoEjyoCuEqPtALpdHrCfi8l/BthzRs+74WbRHaXap2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZTXdfmvfDVsj9Z/oubUmnn5DQpogk8Cv6h2H1poWc0=;
 b=Qzua+dKcHU3shphwyzjPaRO7GHsP6gQAfJqRTYQkGTnbSlAac+YSdlG/sQqhiWISqwKLR2vRtls829a35QKTElQmR1zVzh8h7p0aJ+X9g4ikb277X6CjQ4bVUbqI6P6RsLa6kBV/ry//SHJl6FjWsEUciTZS691YxLK8cuKPRkSJJm+VDEVXvIfEXDp4RE7GF05cE2/MdHzjSUfRXBDOd0IZOrZkm96Kz17ZToOH1eYH3f2iTbf2TNgQ7ho3YBEyXWIkj2SPs3UPiMACQEKq3sLcv7iR1JMobXOwYpFFXBEwwtZ2eJi8eQEAqy3nmlTyGniP2qJvKxzkq7zEIzIFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 31 Mar
 2024 14:29:21 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7452.017; Sun, 31 Mar 2024
 14:29:21 +0000
Date: Sun, 31 Mar 2024 22:22:39 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ryan Roberts
	<ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, Mel Gorman
	<mgorman@suse.de>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: [linus:master] [mm]  f77171d241:  vm-scalability.throughput 34.9%
 improvement
Message-ID: <202403312219.c62301c9-yujie.liu@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ0PR11MB5866:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXq9/9JA0iDtnAMtiEDbU/Hw8XzYHNDJ691XnRU6Ktkur5uIm/uMOKcFapOWMxc9u2m3fy0ggemsle7NIUxDJDALGj2DO3iHb8hA4e6zmBvGFmEe6TLxWJsFO1pt08rXeWmgurQxb1XDWhsCHu3/JrExNsgEDoBsUHtTAcL9pXvK11/iJJpgOtgwX68Y/MNZ5O8F2xLN4RihO1q3xqDuD+1Umr3Cg4e7OG5g3qTCYwmqoq9hMazkpC4qwgQG+YDA1LmZs5Pk0+/IQ1ARK07nxMa0T4nCxM4ky7Qd0sHcX1E1BdA759LD+8qjcqrW+S3hQVPMo2uZ1dlyYYy0fBlBntrN2iqHHQ9uIlRgVVaaTcwu38uLQW47rO7fmPEuoMB9yurIyd5BMdyeFx4Ub72YM9wDWYikOkN5/L3QfI/cj23kRnnzhwE65TPt5XlSWTwq5W7FiwJioQnIyQmHMMiXT9257NbOmHS2dmsNxkwTMG66DdP7nvyYKPVYIm28SQs/MfoEpvogIAt0xjw/v0gwjXQHnL2dNdbjqA2BFMvXqwW1Mab9Z8+ozXhKy2fz8gFPAHQiQPmxbsf0FM5BWoTHOGLah/yuS+BKVhDyWXJULvUQVKyBYNnjoa32oIpLnACd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HprN5AGmLCAjYhyBymCMYn+Tii+TWfE8fIXqMG7uuY+l6ONaGvKp5BI7f8?=
 =?iso-8859-1?Q?08orvBBvMMtAxR4N8Ghx0S5Q69mskkrnTUa7FgEIUnie0XEnW2VU2ODXkI?=
 =?iso-8859-1?Q?jkr9qEXdqKX4BOi+6xbi6iRSqFYFYFQ8TIu38+VoLJ8dj/azQDh3v8KvM5?=
 =?iso-8859-1?Q?CYU8NcKjBBTnaX06ZLP/9XSbxHKPebfn8xu/0c06YfDGmjRH0lmiRljMpc?=
 =?iso-8859-1?Q?F/+qYDuJUchyF7sqGwreAx5u3cURqAo7zi+nTp8y+wCR0sjO2S6vJsHjoa?=
 =?iso-8859-1?Q?TvsV6cE4efpaFhKZqFWzd05NNJtOP62q1W7Bj2iMUukz870aGB71Pf21YP?=
 =?iso-8859-1?Q?XChr/HkMOBoA1CKLEHDvCTwR16MHo8x6YeMrdYRbRTXeowblyErdfEf/FX?=
 =?iso-8859-1?Q?QU0Cb2a/57pBzIftycqnwMuLzu8d41ZnyVu7dKSSBQFQ4EJgQfs57v3Xp2?=
 =?iso-8859-1?Q?NxCaT0OfUNz/cd1yR2YGolVg0Dqo54S2lA0/j7SB37MDgZ+3A2fk3Pin5l?=
 =?iso-8859-1?Q?0EJnoR0G2ehMf6foMiIteaHP4DnWIhogsummKTiZQOIy9+G8ZuDOIt2Qfq?=
 =?iso-8859-1?Q?XXk/8qmqBWSBdFihg5VFu75zrv0G3GYAfhNPFc34QNAvsmwd7np8jPG5Zj?=
 =?iso-8859-1?Q?uf8CmD1e8L7E1lxUKTwFZodrXPWgd1IWSL1SR7l/Pt8VS1PDIXGvSd0py2?=
 =?iso-8859-1?Q?biSYVY6H4c3skiyLMXH0mASOa2wjB9tPyw7It+SBz9NibhnFZO6vwPO93x?=
 =?iso-8859-1?Q?eWFNxrjDo6bJfZoAUUvFt9EInhAWQXgWznEyU8PGM71TYXxN9QuYTbJpV+?=
 =?iso-8859-1?Q?6wInttzoJ8z1mJR02Qir1QQZ9nGcucwhO+4erkM4W0hdaEDsIWfuJh25BH?=
 =?iso-8859-1?Q?CR2eZFA1Kmxm4XvCm7kpNjQ8h5ZfwRQM9bv2coMRog2tFfuZCYuP6QwSla?=
 =?iso-8859-1?Q?fIIpb2BRrcurmR+k0XRwosJ2y93rxea9rC73c0IdeOJ6x3jkbL9LJCRwAL?=
 =?iso-8859-1?Q?ZtyQSJL36BxI1fW0/6/JgrQ4CKw4jnidJ8g+Eawp/MSt73GH6qenUIpitY?=
 =?iso-8859-1?Q?OHmg8XUBOdM8lISp0p+ZeNrvvJfltu7f6IGnRkaRSnjaEeTaG4rHnd7Qag?=
 =?iso-8859-1?Q?mqVzCMwzWT830Ody6lOhUAU8osWptztecIlsCOWBevUqM0BU2itHle28nI?=
 =?iso-8859-1?Q?F2Gzb2UN3DSIp1JedXZqSouYk9BJqOC0UjokyHtF1A7H8Y/d6scGcGBz0V?=
 =?iso-8859-1?Q?f8CjIyq+OPgMv2cmCRTzS26ikr7nV3FHOuWzw5HtwnNcJ2D+XlhFxEqg5Z?=
 =?iso-8859-1?Q?ZG87oGrHBPUMQN1Dim/94hJgwa7yYH+19EcBoFa1Xq6cdKZe6Sm33U9mpq?=
 =?iso-8859-1?Q?tsp+StaAwoD5zN4fa1G3SG2srzWyGEsLyRA/UKoEDdEKJb+IHYjsTWrTNZ?=
 =?iso-8859-1?Q?7G0LzS3MGAXgAJO4NtR5dLyKwK5tkjtW7wtDJwaZdaJNEP6cI6imGabMZq?=
 =?iso-8859-1?Q?vsSnK84oDHUSS1TifuScXUt6vH+vblshM9VzNkNXCgD9isqUpXzieTTtcj?=
 =?iso-8859-1?Q?HN5fHOISfOAkjUxpH1MVRtF92DFrRyVUEelFYX/Wi8M1/VQsgAAbrsfuhk?=
 =?iso-8859-1?Q?fcmuhUcrRKTvVCNzSMXbepZpNhZBgQUiaJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc65da2c-2e9a-43df-8732-08dc518ef4b6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 14:29:21.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DF/tP1t6d98QVabOJLlSSaNrgP7mNmj9V6AwswSLjY7evbdlkd5fqzmmuFuCog5YOUOFx3f2qTwKQwVEGaT5KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com

Hello,

kernel test robot noticed a 34.9% improvement of vm-scalability.throughput on:

commit: f77171d241e379ea93448a53d58104191e02135c ("mm: allow non-hugetlb large folios to be batch processed")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: vm-scalability
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	runtime: 300s
	test: truncate
	cpufreq_governor: performance

Details are as below:

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240331/202403312219.c62301c9-yujie.liu@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/truncate/vm-scalability

commit: 
  31b2ff82ae ("mm: handle large folios in free_unref_folios()")
  f77171d241 ("mm: allow non-hugetlb large folios to be batch processed")

31b2ff82aefb33ce f77171d241e379ea93448a53d58 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 7.397e+08 ±  6%     +34.9%  9.978e+08 ±  3%  vm-scalability.median
 7.397e+08 ±  6%     +34.9%  9.978e+08 ±  3%  vm-scalability.throughput
    193.12 ±  7%     -16.4%     161.38 ±  3%  vm-scalability.time.percent_of_cpu_this_job_got
     84.58 ±  8%     -16.5%      70.62 ±  3%  vm-scalability.time.system_time
    154795 ± 85%    +168.7%     415963 ± 28%  numa-meminfo.node0.Inactive(anon)
  41174935 ± 36%     -81.1%    7801569 ± 30%  proc-vmstat.pgfree
     38644 ± 85%    +169.0%     103935 ± 28%  numa-vmstat.node0.nr_inactive_anon
     38644 ± 85%    +169.0%     103937 ± 28%  numa-vmstat.node0.nr_zone_inactive_anon
     18.05 ± 12%     -18.1        0.00        perf-profile.calltrace.cycles-pp.__folio_put_large.folios_put_refs.truncate_inode_pages_range.evict.do_unlinkat
     18.02 ± 12%     -18.0        0.00        perf-profile.calltrace.cycles-pp.__page_cache_release.__folio_put_large.folios_put_refs.truncate_inode_pages_range.evict
     17.68 ± 12%     -17.7        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.__folio_put_large.folios_put_refs.truncate_inode_pages_range
     17.63 ± 12%     -17.6        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.__folio_put_large.folios_put_refs
     17.57 ± 12%     -17.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.__folio_put_large
     22.14 ± 12%      -5.9       16.22 ±  8%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
     22.15 ± 12%      -5.9       16.23 ±  8%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.16 ± 12%      -5.9       16.24 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
     22.16 ± 12%      -5.9       16.24 ±  8%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
     22.16 ± 12%      -5.9       16.24 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
     22.16 ± 12%      -5.9       16.24 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
     22.16 ± 12%      -5.9       16.24 ±  8%  perf-profile.calltrace.cycles-pp.unlinkat
     21.78 ± 12%      -5.7       16.05 ±  8%  perf-profile.calltrace.cycles-pp.folios_put_refs.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      1.14 ±  9%      +0.1        1.29 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt
      1.98 ±  3%      +0.2        2.17 ±  2%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.24 ±  3%      +0.2        2.44 ±  4%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      2.34 ±  3%      +0.2        2.56 ±  4%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      2.34 ±  3%      +0.2        2.56 ±  4%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      2.41 ±  3%      +0.2        2.64 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.38 ±  3%      +0.2        2.61 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.84 ±  4%      +0.2        3.09 ±  2%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      6.56 ±  2%      +0.6        7.18 ±  3%  perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_to_iter.copy_page_to_iter.filemap_read.xfs_file_buffered_read
      6.90 ±  2%      +0.7        7.55 ±  3%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      6.98 ±  2%      +0.7        7.64 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.vfs_read
     14.15 ±  3%      +1.3       15.48        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.iomap_readpage_iter.iomap_readahead.read_pages
     14.19 ±  3%      +1.3       15.53        perf-profile.calltrace.cycles-pp.zero_user_segments.iomap_readpage_iter.iomap_readahead.read_pages.page_cache_ra_order
     14.30 ±  3%      +1.3       15.64        perf-profile.calltrace.cycles-pp.iomap_readpage_iter.iomap_readahead.read_pages.page_cache_ra_order.filemap_get_pages
     14.36 ±  3%      +1.4       15.72        perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.page_cache_ra_order.filemap_get_pages.filemap_read
     14.37 ±  3%      +1.4       15.73        perf-profile.calltrace.cycles-pp.read_pages.page_cache_ra_order.filemap_get_pages.filemap_read.xfs_file_buffered_read
     14.81 ±  3%      +1.4       16.22        perf-profile.calltrace.cycles-pp.page_cache_ra_order.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
     14.86 ±  3%      +1.4       16.28        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.vfs_read
     21.90 ±  3%      +2.1       23.98        perf-profile.calltrace.cycles-pp.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.vfs_read.ksys_read
     21.92 ±  3%      +2.1       24.01        perf-profile.calltrace.cycles-pp.xfs_file_buffered_read.xfs_file_read_iter.vfs_read.ksys_read.do_syscall_64
     21.94 ±  3%      +2.1       24.02        perf-profile.calltrace.cycles-pp.xfs_file_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.08 ±  3%      +2.1       24.18        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     22.09 ±  3%      +2.1       24.20        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     22.11 ±  3%      +2.1       24.22        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     22.15 ±  3%      +2.1       24.27        perf-profile.calltrace.cycles-pp.read
     22.11 ±  3%      +2.1       24.23        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     45.34 ±  3%      +4.1       49.45 ±  2%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     45.76 ±  3%      +4.1       49.89 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     45.87 ±  3%      +4.1       50.00 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     66.58 ±  3%      +5.8       72.37        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00           +15.2       15.18 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_one_page.free_unref_folios.folios_put_refs
      0.00           +15.3       15.26 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_one_page.free_unref_folios.folios_put_refs.truncate_inode_pages_range
      0.00           +15.4       15.40 ±  8%  perf-profile.calltrace.cycles-pp.free_one_page.free_unref_folios.folios_put_refs.truncate_inode_pages_range.evict
      0.00           +15.8       15.85 ±  8%  perf-profile.calltrace.cycles-pp.free_unref_folios.folios_put_refs.truncate_inode_pages_range.evict.do_unlinkat
     18.06 ± 12%     -18.1        0.00        perf-profile.children.cycles-pp.__folio_put_large
     18.09 ± 12%     -17.9        0.16 ± 25%  perf-profile.children.cycles-pp.__page_cache_release
     17.78 ± 12%     -17.7        0.04 ±151%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     22.15 ± 12%      -5.9       16.23 ±  8%  perf-profile.children.cycles-pp.evict
     22.14 ± 12%      -5.9       16.22 ±  8%  perf-profile.children.cycles-pp.truncate_inode_pages_range
     22.16 ± 12%      -5.9       16.24 ±  8%  perf-profile.children.cycles-pp.__x64_sys_unlinkat
     22.16 ± 12%      -5.9       16.24 ±  8%  perf-profile.children.cycles-pp.do_unlinkat
     22.16 ± 12%      -5.9       16.24 ±  8%  perf-profile.children.cycles-pp.unlinkat
     21.85 ± 12%      -5.8       16.07 ±  8%  perf-profile.children.cycles-pp.folios_put_refs
      0.26 ± 10%      -0.2        0.07 ± 12%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.25 ± 13%      -0.2        0.06 ±  8%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.17 ±  6%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.16 ±  7%      -0.1        0.08 ±  9%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.07 ±  9%      -0.0        0.03 ± 77%  perf-profile.children.cycles-pp.begin_new_exec
      0.14 ±  7%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__mmput
      0.14 ±  6%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.exit_mmap
      0.07 ±  8%      -0.0        0.03 ± 78%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.14 ±  5%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.load_elf_binary
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.exec_binprm
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.search_binary_handler
      0.17 ±  4%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.bprm_execve
      0.09 ±  7%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.13 ±  8%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.filemap_add_folio
      0.32 ±  3%      +0.0        0.35        perf-profile.children.cycles-pp.read_tsc
      0.27 ±  3%      +0.0        0.31 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.52 ±  3%      +0.0        0.56 ±  3%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.35 ±  5%      +0.0        0.39 ±  5%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.free_tail_page_prepare
      1.20 ±  9%      +0.2        1.35 ±  2%  perf-profile.children.cycles-pp._raw_spin_trylock
      2.12 ±  2%      +0.2        2.32 ±  2%  perf-profile.children.cycles-pp.rebalance_domains
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.commit_tail
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.drm_atomic_commit
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.drm_fb_memcpy
      2.27 ±  3%      +0.2        2.48 ±  4%  perf-profile.children.cycles-pp.memcpy_toio
      2.34 ±  3%      +0.2        2.56 ±  4%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      2.34 ±  3%      +0.2        2.56 ±  4%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      2.41 ±  3%      +0.2        2.64 ±  4%  perf-profile.children.cycles-pp.worker_thread
      2.38 ±  3%      +0.2        2.61 ±  4%  perf-profile.children.cycles-pp.process_one_work
      3.12 ±  4%      +0.3        3.39 ±  2%  perf-profile.children.cycles-pp.__do_softirq
      3.50 ±  4%      +0.3        3.83 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.4        0.38 ±  7%  perf-profile.children.cycles-pp.free_unref_page_prepare
      6.59 ±  2%      +0.6        7.21 ±  3%  perf-profile.children.cycles-pp.rep_movs_alternative
      6.94 ±  2%      +0.7        7.60 ±  3%  perf-profile.children.cycles-pp._copy_to_iter
      6.99 ±  2%      +0.7        7.65 ±  3%  perf-profile.children.cycles-pp.copy_page_to_iter
     14.17 ±  3%      +1.3       15.51        perf-profile.children.cycles-pp.memset_orig
     14.19 ±  3%      +1.3       15.53        perf-profile.children.cycles-pp.zero_user_segments
     14.30 ±  3%      +1.3       15.64        perf-profile.children.cycles-pp.iomap_readpage_iter
     14.36 ±  3%      +1.4       15.72        perf-profile.children.cycles-pp.iomap_readahead
     14.37 ±  3%      +1.4       15.73        perf-profile.children.cycles-pp.read_pages
     14.81 ±  3%      +1.4       16.22        perf-profile.children.cycles-pp.page_cache_ra_order
     14.86 ±  3%      +1.4       16.28        perf-profile.children.cycles-pp.filemap_get_pages
     21.90 ±  3%      +2.1       23.99        perf-profile.children.cycles-pp.filemap_read
     21.92 ±  3%      +2.1       24.01        perf-profile.children.cycles-pp.xfs_file_buffered_read
     21.94 ±  3%      +2.1       24.03        perf-profile.children.cycles-pp.xfs_file_read_iter
     22.09 ±  3%      +2.1       24.20        perf-profile.children.cycles-pp.vfs_read
     22.11 ±  3%      +2.1       24.22        perf-profile.children.cycles-pp.ksys_read
     22.18 ±  3%      +2.1       24.30        perf-profile.children.cycles-pp.read
     42.82 ±  3%      +3.8       46.65 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     45.46 ±  3%      +4.1       49.57 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
     45.57 ±  3%      +4.1       49.68 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
     45.99 ±  3%      +4.1       50.12 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     46.09 ±  3%      +4.1       50.22 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      1.12 ± 19%     +14.3       15.41 ±  8%  perf-profile.children.cycles-pp.free_one_page
      0.00           +15.9       15.86 ±  8%  perf-profile.children.cycles-pp.free_unref_folios
      0.16 ±  7%      -0.1        0.08 ±  9%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.46 ±  3%      -0.0        0.42 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.31 ±  4%      +0.0        0.35 ±  2%  perf-profile.self.cycles-pp.read_tsc
      0.40 ±  4%      +0.0        0.44 ±  5%  perf-profile.self.cycles-pp._copy_to_iter
      0.38 ±  2%      +0.0        0.43 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.1        0.05 ±  6%  perf-profile.self.cycles-pp.free_tail_page_prepare
      1.19 ±  9%      +0.2        1.34 ±  2%  perf-profile.self.cycles-pp._raw_spin_trylock
      2.26 ±  3%      +0.2        2.47 ±  4%  perf-profile.self.cycles-pp.memcpy_toio
      0.00            +0.3        0.33 ±  7%  perf-profile.self.cycles-pp.free_unref_page_prepare
      6.50 ±  2%      +0.6        7.11 ±  3%  perf-profile.self.cycles-pp.rep_movs_alternative
     14.09 ±  3%      +1.3       15.42        perf-profile.self.cycles-pp.memset_orig
     26.19 ±  4%      +2.1       28.29 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


