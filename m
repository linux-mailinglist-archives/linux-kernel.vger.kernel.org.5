Return-Path: <linux-kernel+bounces-17712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D8D82517C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A923F282D0C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A424B36;
	Fri,  5 Jan 2024 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZH7Gu8k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24B24B32
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704449325; x=1735985325;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TYdoaeHqibKedx0WxFkIevqh3P39IBph3lKPNzDOlxY=;
  b=jZH7Gu8kMBXuCdaJXVJqvL2/zLqdiRwrj6p4mwG815GNuK0vQAjyxPuT
   bMxau+lEXndyiKrQKLVIuUhp8zKXKZatyLJz5y6sJNZMUWaolPlsoreKU
   boEr3VoP0NCQJvWomSOnrrkAEhVJMEj2Ehd3/gN8lkSp1XbMfA39K7hxO
   pw87pFOhm6wsXOc/lJRydhRq38wzwkzdEgFnfD3mXe+6R9M0SeVKwIW7B
   iwwMwrMTXGHEHjp12lJTFZt1L9AQBInEhQvhwm6KX3LQbyg0H0GHlddQz
   Zitwy41IiK4QOPFxJqr3clEZH9n10E9Dnxetqe2cd0zYhrXJg6LNYmdgB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="483650489"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="483650489"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 02:08:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="15202449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 02:08:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 02:08:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 02:08:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 02:08:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 02:08:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZvQj5/s3f0w9JrMJKTt1EA8IkHRb4d7Rdh4VSL7GIuObIgwkwo00XrW56kR0J+SFCsz0Xnps+2FNW1vaVpo9GINkQAJJ6QYm3fkCxpkAaRbbYxs3UHRQV47sdkOGFIq0UY1L8FTKRS4EMxm3ppYOOKXEI38nYbXq8AihOh7wgQ4aJ/v3jazI3iQpaH4B8n6NnJXtHo5eYXnrR+yAV4hkwLA9vXA6Nu3TjavDlYeB/YWpqySyHytJa7DYF/0wP1nT9BSVCGl7DYzJ3sngvvliD7ABDx1AVJd6OwTeeWoJ1lC9IIyQBYIQ9eYvGYVDxFZ+AxmI2E+rTbS+DCCfrdxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW3ZPsbmWy34B4XfMEV1o7B4Rk1w31iyZ0Xxgz7PtZk=;
 b=Uq+3jwDKcjwYV5T5fDQUsyqzw2VEE4a0acEkQ8+OxP9JK9aiZpzf5VF+6HKdrQ+YVHdljuaMdE536SyC0zee2nMQ2tY9wj3zA5X0q/RczyOJ3cW+S6CzMCTfCYe38LrxtFNkCEIQu1WANNqRC5OudqN8YnVSvtV0PYccQ4YcuHVmKwx1go5w0VipVifUEN6O0B7q8RUwO8mQ0OWc7nrrahptTbfk8Cn06nOo5a4LdCsQdKYUVtSJrId//xaFS5TW2lvCbKZYD7ZAWzbzsV3l00/UZfeN9sCF8xEdVeTCwngtP5d3P8yhmkiraMfMvjCkDuS+NFmjhsKa9JwlErFLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 10:08:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 10:08:41 +0000
Date: Fri, 5 Jan 2024 18:08:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zeng Heng <zengheng4@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<mingo@redhat.com>, <will@kernel.org>, <peterz@infradead.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>, <xiexiuqi@huawei.com>,
	<liwei391@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2] locking/osq_lock: Avoid false sharing in
 optimistic_spin_node
Message-ID: <202401051804.77722270-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231222121040.2635879-1-zengheng4@huawei.com>
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a85a60-ae14-4ca6-a3cb-08dc0dd64aa7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4nzlkdTGyCGlrg3j0PZNry09EUrhYdgeCgej76CT7mqsu/ApIFUoHiOXC0NLoYiofZnIwH+aTz6IuldiPHQI3WUX2r+GKRmLm5sk8qH8+80sSEloVYQnEWoHZ4QjJkod3KviR5sxIia1gR6THBsYi3no24iaVGTrQmUkLSAR6SJrPU4jtiVNJAwq3kOLrcwGtztxg4MCD6szmOZd+lK2V7DHe7fhdFcGiM0CNCE8RRQWzvEp20hEDAooc+pFOtKFQcoJvDVj2Vo9dimVGgTDC80QqYwric8mYj2bvn5xAAUy3Z7KVjFSKCMDT6c/0wFWt9RtS1f2E1BnGu2LbAMF1d7VcnsFt71NcNY1Lt62PzlGSGo1r+wEwdk1b0ydRfP4hswPkDV67yqDoK+Eqo/vD04+U643Si6siJOIFoi4dj3bv7qljqTMYmVtDWj7e4RAsVsMGLZBBKeFrJHyMeR3w9we1KvBVIsVwL//5ETXtbG05eithURcutLn23ZVxT9jIzHtwbSUhtht7oi+0pwJrRtC0s7wE6EQXJF8SIE6BNho1XDjEcOkRSvcr9fQUHZFshCJanYlAL1b32QsfYk2f33IrVoIgY8ny6F7VOMiYfvdd5J7IpyaUa/KNBBGrz8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(230373577357003)(230473577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(107886003)(2616005)(6666004)(4326008)(6506007)(6486002)(38100700002)(478600001)(966005)(1076003)(26005)(6512007)(82960400001)(66476007)(316002)(8936002)(66556008)(66946007)(8676002)(6916009)(86362001)(41300700001)(2906002)(36756003)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Yg/QjVMi9x9L/EUGqOnS31lDrl7VlGiTxtv+FRgBUMmo79SNPaSBE3lNsI?=
 =?iso-8859-1?Q?V7CKGTFW1IRTZ58K3tqFBTxhNNv6TV9zf6lXEX2mUDTqHisLAJH2jasA+E?=
 =?iso-8859-1?Q?PXD0Cw1tFpZ2oQwxfkStrrBFmR17Tr9N01nWOILahiBvE/e8wICoADVcbu?=
 =?iso-8859-1?Q?dr+kCx/5FRg3jaOxcEV4aAyZNgnMeSL3i0RdxUt4POqLjJCGbZbeCwH2Vm?=
 =?iso-8859-1?Q?W1B7vFrOMng+uEs7EI3MuM8ZLGSBoWJ2/dka9YUU0YiwYC63j064+AkN/L?=
 =?iso-8859-1?Q?dGhMhiZbOgksd0cStkoPwIWVh0hb/E/tuxXk9bnxGrXmKX+MEoeXgjTAx0?=
 =?iso-8859-1?Q?Gy/0Iq3wbuwKa02eImY4e/2A5jU91RMF9/uPq5AwE97ysLjjHWHoBxhi4O?=
 =?iso-8859-1?Q?vZdBeaaAGKzSKXBMoNYllxbF55F4PhxNwhR3luwPr1LC0+nsboBGJaa4B8?=
 =?iso-8859-1?Q?YtJPuw6UKB/TmfD/0kiJ5tSWu4ZZzS2ULKDpXRL1h8ZaHtYTWAX/qH8jEJ?=
 =?iso-8859-1?Q?1kDKhvRuWsci98jcV4EkXwqimiIAJHVwmRwshigDFR6dkUM3H89jOGim/L?=
 =?iso-8859-1?Q?xQt32zy+lYpi6O/kiB4NrBoa2URaQ9VLqbEpQcim8LALshLgejm/Gnvwna?=
 =?iso-8859-1?Q?qPo4/7dLj+kW5K9tvv7acasiHYtVOX6u6h67tr9Gs2NyMMFjGURRtSwlnf?=
 =?iso-8859-1?Q?dAvEnRwlR6RgVpjQcPO8w1PiLjzH8EPA8D8zkwF9bhyDx7JRybkbY+SgpL?=
 =?iso-8859-1?Q?WZ+BOLL04A3X9B1AAx8wqJMZjEUfbSvaO/oKVJW+GPCZdC6hxTbhp03PdB?=
 =?iso-8859-1?Q?MGkTKrqBGm0+7VeKJD1hDuSN3GXKfPgcJrcgSFpN/CrdaGJz7vzbWzOxkG?=
 =?iso-8859-1?Q?d8sEa606e11MMkvP4TZGRTmkO8GnstrrGJQ4P5hNt4DJnBMI4gbopcchr2?=
 =?iso-8859-1?Q?wQmqYqKBMnED2RhmXG37+u1oS4iyrT923R9bWwAL04LxmJe2EccNZkmDQ+?=
 =?iso-8859-1?Q?GbjLgWUqQWoD0MWAAOn/YvZmsb4LxD3W+AXU1AzSEk3J96lA1VoENPrc+h?=
 =?iso-8859-1?Q?hMFuqdSeBj6y9DP/J9IFgxaRNPZNoQnn5dAjQVRVLLtf6UIcsHo/bipV/A?=
 =?iso-8859-1?Q?RLNJ+GgVGrhj1Z170CoqOYZMn/2gm7wrYJ8/tUisVjjSILmBwrXLeYQQbx?=
 =?iso-8859-1?Q?S50sFgqtmCtcpXWN0v8PhoCZP8CFiB7XVevJ8T3VtpadmCuV/srh4B/wx/?=
 =?iso-8859-1?Q?CdXroVQqgTCz0zhzaghS4Q+kaEiNzAJ4YIxh3GKnxpFvsJPtFNTLHlHaTb?=
 =?iso-8859-1?Q?YLz/egpXHV+fquI1vo7h460hrdQU0fV81cl6IrcGFTSPNPQaYRAHthB0LS?=
 =?iso-8859-1?Q?YccWzrbKtaxMXKY3GZHlENfg0wh2ue0dndpH/GPNu+Qg7h1+n96X6xb6NN?=
 =?iso-8859-1?Q?fJJdtTuIV8NhmPRU869xteiM1XKi5BrdPFn+1X/wXsPpSTkxwWl9HduFb6?=
 =?iso-8859-1?Q?VBmVSR5eYszIypPEjxK4EExYoqWVbpFs9q3HqWi7bzbyWYX6DfEc6HV8/p?=
 =?iso-8859-1?Q?CTRCkybatY6gmf/kjj2qlYwx1LPDJySiR6AlZ8o+wquTHdGiPSuSdOob/i?=
 =?iso-8859-1?Q?YeuqZq6gaNCCkG8VGQYK0LDlAt8ckR9fAKYIl/uVjz6DHPrchcLq1sTA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a85a60-ae14-4ca6-a3cb-08dc0dd64aa7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 10:08:40.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7dqwYyxGI5KhptZNrR6WD6uXb39Lqv2t7IK9NDHpPG1nfDwRi/y/beVqJ+MyHWedDzQk64bHzfZQihkcG0I7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 15.3% improvement of fxmark.ssd_xfs_DWOM_72_bufferedio.works/sec on:


commit: 511ac0a137f4211f42aa2ba168e50550b703bb7c ("[PATCH v2] locking/osq_lock: Avoid false sharing in optimistic_spin_node")
url: https://github.com/intel-lab-lkp/linux/commits/Zeng-Heng/locking-osq_lock-Avoid-false-sharing-in-optimistic_spin_node/20231222-200921
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git a51749ab34d9e5dec548fe38ede7e01e8bb26454
patch link: https://lore.kernel.org/all/20231222121040.2635879-1-zengheng4@huawei.com/
patch subject: [PATCH v2] locking/osq_lock: Avoid false sharing in optimistic_spin_node

testcase: fxmark
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1SSD
	media: ssd
	test: DWOM
	fstype: xfs
	directio: bufferedio
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240105/202401051804.77722270-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase:
  gcc-12/performance/bufferedio/1SSD/xfs/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/DWOM/fxmark

commit: 
  a51749ab34 ("locking/mutex: Document that mutex_unlock() is non-atomic")
  511ac0a137 ("locking/osq_lock: Avoid false sharing in optimistic_spin_node")

a51749ab34d9e5de 511ac0a137f4211f42aa2ba168e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     19727 ±  6%     -13.5%      17073 ±  6%  vmstat.system.cs
     19254 ±  7%     -13.4%      16678 ±  7%  perf-stat.i.context-switches
     19499 ±  6%     -13.6%      16851 ±  6%  perf-stat.ps.context-switches
    105.12 ± 13%    +115.9%     227.00 ±  9%  perf-c2c.DRAM.local
      5028 ±  2%      -9.1%       4571 ±  2%  perf-c2c.DRAM.remote
      3526 ±  3%     -13.8%       3040 ±  3%  perf-c2c.HITM.remote
  77565522 ±  2%     +11.2%   86238276 ±  3%  fxmark.ssd_xfs_DWOM_18_bufferedio.works
   1551311 ±  2%     +11.2%    1724766 ±  3%  fxmark.ssd_xfs_DWOM_18_bufferedio.works/sec
  61955316           +12.3%   69564863        fxmark.ssd_xfs_DWOM_36_bufferedio.works
   1239107           +12.3%    1391298        fxmark.ssd_xfs_DWOM_36_bufferedio.works/sec
      2.21 ±  4%      +9.2%       2.41 ±  2%  fxmark.ssd_xfs_DWOM_4_bufferedio.user_sec
      1.10 ±  4%      +9.3%       1.20 ±  2%  fxmark.ssd_xfs_DWOM_4_bufferedio.user_util
  46595523           +16.2%   54146121 ±  2%  fxmark.ssd_xfs_DWOM_54_bufferedio.works
    931911           +16.2%    1082933 ±  2%  fxmark.ssd_xfs_DWOM_54_bufferedio.works/sec
  44518641           +15.3%   51332276        fxmark.ssd_xfs_DWOM_72_bufferedio.works
    890372           +15.3%    1026646        fxmark.ssd_xfs_DWOM_72_bufferedio.works/sec




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


