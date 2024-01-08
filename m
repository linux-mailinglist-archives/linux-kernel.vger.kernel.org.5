Return-Path: <linux-kernel+bounces-19145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B403C8268B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E39B1F21D82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C28C06;
	Mon,  8 Jan 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJeQGJQp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AA8BF9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704699746; x=1736235746;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wZbEHX//35rBOZIZOq3a/D1/T1H+Vi6ESYE8q894X9A=;
  b=EJeQGJQpoHLeJhFZ+jEs6Vqd0sdwNpx+Ez4ub69LQLBV9my4hCDFMKTK
   3ZKVewlCDvDEKK9z6fkbXblCxYCRmfQ1U5AtUQ0efkcsoY0UvGxlZSUXS
   ic6HMbck1i4/J3/B7o5hGrGY+hulWt+vqldiO2cYP13hwxdJs44vCMy5l
   dl2o0NZGDSHtf1OAhlztDyfZtuw3/xQc39IEyA3cM2aC/We9OvczZTVBe
   6G+C2N9/tlWeri1FGPgB/3Aei+OxpuOa8PkE8sAl66BRPJEng+3R3hoyo
   XjcjZQNve/O2QhH/va0NpUokRWQuzsp0ERhkJ6ZlhneyR8q0VvqVS9dEu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="483997658"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="483997658"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1112667112"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1112667112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 23:42:25 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 23:42:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 23:42:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 23:42:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSY+hVIGU0p+Ecyk0GvYpQY582ufdqQYNxSlXo47mHMLhA3qIwOJYG8TWlMdFHVP/eivCgT3h/xSdNF6dLvqCTvzGtximDF4fAUPH2DcNcy0kDMJk8qmi+lc8iiDJ55K9GSwTWJgrftIRgaAMBB+LRtVZUzucynIZylsPiarlkUnanSIDKF0thiEDlfhVd34/0Knkh+CXL57o7eeJV7WCnVq/lSTE56PFifZfHO92pq7th+jd/mQlppeXevHaOj8kSysVj4t/5Lw0FOyebI1fQBmKrCybR0cLXtKe3nrb9q65iTiWeFo8R8MsSYojYP1GWkaqgRzo5EQYKlGH/ET+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=322GvMNhw5g2dw4lkBc1XjIqScOZaRT4vFeNsBy2PL0=;
 b=bsKEh8S8ssVl3ajzpJZLfEYBtAF4o2cJjcrE0KNA5pSGqCsKHfKId1MBW3Mn3hDdfZL6j6OyEu5WRMZSeJEtcdPlw6BKm9GdDKxrsEQ2WfiIBV0uxfs7e6F1R8QMolmViiva4mfD7u+57p6Xq1BP4M7EWIebw4Pc/QLRGXw1wBhv5mu4OqwOs6IV38o09z+1Ym43d+F8FkyQihbhZt577KaU48hh2NvE+Y6lkxhz9g+ZXPfDVAExZE07HxJxbYNUtIAkdyGCEVMxmaC4d6eK+FLgeqs0wEnwGS1RH/hEusxe2xXVQIeQ0QYlytXtGjW6Fhx1VHnn1WvVC0ezQEORFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 07:42:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 07:42:22 +0000
Date: Mon, 8 Jan 2024 15:42:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Laight <David.Laight@aculab.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Laight
	<david.laight@aculab.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	"'peterz@infradead.org'" <peterz@infradead.org>, "'longman@redhat.com'"
	<longman@redhat.com>, "'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>, "'boqun.feng@gmail.com'"
	<boqun.feng@gmail.com>, 'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH next v2 2/5] locking/osq_lock: Optimise the
 vcpu_is_preempted() check.
Message-ID: <202401081557.641738f5-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a9d1782cd50436c99ced8c10175bae6@AcuMS.aculab.com>
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c6ef3e-186e-4655-681e-08dc101d592a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcXCEVP0Xp3ZaLpMBsOFDQHkA1cPBejTShNquDIlUnxjOQvmUN9g0I/wdvephWi5Yx9b0xawDmKkOlUgbo6FH6IkNaZ3BRcfdQEsp12Ysfqn3Y9yf2vjCgDHT6EKPcmpICGYHn496po4mUYO1Q2++D0bpANUn+wVPPCWtyFdBp2cwsK9qGO/D1oAp1HI8EvLwY5y2Ivj2Tljzl9/yjzWys4KkokWtqQSxfxq3WHwLGuLj7bcrBYqT8NDmuWrHY/jURlgzG8aUmozxcU29LApwYv2706NLkWqYF+rokXuAVSu8ZrJ9MUXg8zx+aiYjPcTaNB9YH7rFh/apDWQZbQTycj813QfTWfFZpM/xqLvFyPfezz0X6sl4n9PdLtASaUegTTSqNEsWSMq2LxX5Jhf46Egz1iD+D+IYM/RHTO/3h70fXITJAUhUz2D3sCGwguHaLw7guTt+hfkZdlldRhFzuYfIjsoonEaIlGEKcpWbFmUMvMYDohSUXeTPTvHxpsWGCqWv7dSTBPJgSHnBPUVJyg+is6NqEqi/qgWg7gq+Y8olGnInYZVy5M86vImJXoBVuvlBkVT42zO91lR5CwIXRcKedL7yxmVLZfPDkrWB32og0iMalMzkpzi55crKW1Mg5kfWUSo1Yf8ZCD/CkUB+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230373577357003)(230922051799003)(230473577357003)(186009)(1800799012)(64100799003)(451199024)(26005)(1076003)(2616005)(478600001)(966005)(6486002)(6506007)(6512007)(6666004)(83380400001)(107886003)(5660300002)(2906002)(41300700001)(7416002)(66476007)(66556008)(54906003)(316002)(8676002)(8936002)(4326008)(66946007)(6916009)(38100700002)(36756003)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JsLTPt0qKGOQfHpxOdqua2+JMjnCqMqEV+GZSQH3++8tJs+CyLeaJfdFII?=
 =?iso-8859-1?Q?DoSV35whSt6cQlF1A7p/R7Rvbv5QqGvf/VzBFIyWsIXkoe2bLgH4pvQ2yM?=
 =?iso-8859-1?Q?3Qep0Nr3+eZu8n5qnFeBqngT+vFDgByB43b1MgV8vR9lLpz5h0VuRfqp5T?=
 =?iso-8859-1?Q?IvS2Uxdh8I2RhN3fU4BYzGjM3G5d4i9Q0BirJbp7JYf5+lmIjwGS1E9abI?=
 =?iso-8859-1?Q?SlinE4T4mqCux1vpL97d0SDx5YWJbRq+pHI6byuwjI8ehrmtZFTGzVXY47?=
 =?iso-8859-1?Q?/9L7RE3V6LZHprUGlhFu8DFWCX9hL8LbINO5TUjcSmTgDPaTz195wd6mhH?=
 =?iso-8859-1?Q?c7IzWpGQLMFQXc7WRaA08s49f0+oL898holmzoVJMu8JGyYY2dTBGWikD0?=
 =?iso-8859-1?Q?oHmY6aWVM4I1bgucgg+yFwkZuZbdABCYr3Ke9SGGMN6nomq4DS5j8Xc5Px?=
 =?iso-8859-1?Q?EZwBmMp8h0NeYk5+V2C5qHkX2RKHYSLEx6KCWzU7QsFqDaCEf/Ak8+SP6A?=
 =?iso-8859-1?Q?zMq3kBAHrKisLIfSwFUl8w+c5jkq0DcfP6Gu981f6QorSVOvwOig/RXkrd?=
 =?iso-8859-1?Q?ZFKYdA242wz/inwx2o7G6KC034V3AY748sZAdq9H9Q5J2ZNbpGHimFh7Er?=
 =?iso-8859-1?Q?kF8xn8v0qHc8EQU3UOGiMCxwPq1tdYOaiC67n+91tKN9iqnNqFwC9em/sr?=
 =?iso-8859-1?Q?cBnh8r1KQtCUnd3KoJ42OPYhTGjTRDizsJ11WKaELnt7jHZHnj+DB2KJG9?=
 =?iso-8859-1?Q?kWs91f0mxxDq5WSkdLmigyfaWzxf7Jm+LrLjhgh3TAqNht+TArUWU7gLhc?=
 =?iso-8859-1?Q?KdmshZ4bBMu2bYBD8tjttdEyc45YF8CauXF4K4rDGeBaN6jUWCGklqkZzh?=
 =?iso-8859-1?Q?NVFO76gKhNqf3FjAicvueVJ9pCy6qI3Li3TXMHnWaKJG2ysCOndW6YRhfX?=
 =?iso-8859-1?Q?kSynDwuSx2gNj9YYTjjV+Bn4NO+uouFZB56m6gNOxQN7mMFrwNx9vswOk0?=
 =?iso-8859-1?Q?m/n92teXYaU0Rcbs68VZGz2H5KXT1GW5cwivCvhybkdUeXf4qD9gRpBZPv?=
 =?iso-8859-1?Q?M4hFNYlEArt3gMJzZQPZUV5a6XHOcHXV3i8HndtUeFwftj+UVC/MVOXnvi?=
 =?iso-8859-1?Q?rM4CF5EvWxftAIdDoEMn5LpCk/jYZdwZ4aeyPchYu3EqaaehlGTaIhZL1U?=
 =?iso-8859-1?Q?070fJao5whK7EWtn3wtrJb6c+pBBrshkg9nRLxRh0rIPviaA06tBFZ3FLz?=
 =?iso-8859-1?Q?Xn2BB7nxM04i9ZGuen9R0RCmIO11wi0+iGfq1Q18PLND0KVzyGviyafzJA?=
 =?iso-8859-1?Q?MLUlmeOHPav+1R1lGmAnZWbqw/ZfvRHH1rj+ipgYM4k47Br3wKDWyULacg?=
 =?iso-8859-1?Q?nmkdxKgCJmXwCgn+BACQ0j7rkLuZcYP8Sck6vW2pwm1lmEquw+YuJS2kQz?=
 =?iso-8859-1?Q?WLQo9OXTyA0VBrFflveAWM6+pOjTvxASd61LvhedONnkAqB7smx4j3uBkN?=
 =?iso-8859-1?Q?Fi/Q+468jiEyvKUPW9DrlGIrooxlsPvgIGNcHbG7dLeaVocFRlkF+49H7i?=
 =?iso-8859-1?Q?Pn8czCAtSVx/zicZ0TVZLsEPm0G8UV21SPE2kt1Rd4tpSCx5tHAILKxhfR?=
 =?iso-8859-1?Q?An4ZvnQ20AJ7twrPRCHdrulprShahzMNDyJ1dn6EY14SLXBWMkIBDPGQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c6ef3e-186e-4655-681e-08dc101d592a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 07:42:21.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCCmUQ/1PJbftr7pxNdzVak7W/iRW8j8ppnibO1NHETH+k+NWYTn2ddHd6RgGXnBTxMxB92dbM+mZzwyHjZ+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 10.7% improvement of stress-ng.netlink-task.ops_per_sec on:


commit: d93300891f810c9498d09a6ecea2403d7a3546f0 ("[PATCH next v2 2/5] locking/osq_lock: Optimise the vcpu_is_preempted() check.")
url: https://github.com/intel-lab-lkp/linux/commits/David-Laight/locking-osq_lock-Defer-clearing-node-locked-until-the-slow-osq_lock-path/20240101-055853
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 610a9b8f49fbcf1100716370d3b5f6f884a2835a
patch link: https://lore.kernel.org/all/3a9d1782cd50436c99ced8c10175bae6@AcuMS.aculab.com/
patch subject: [PATCH next v2 2/5] locking/osq_lock: Optimise the vcpu_is_preempted() check.

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	sc_pid_max: 4194304
	class: scheduler
	test: netlink-task
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240108/202401081557.641738f5-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/test/testcase/testtime:
  scheduler/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/4194304/lkp-icl-2sp8/netlink-task/stress-ng/60s

commit: 
  ff787c1fd0 ("locking/osq_lock: Defer clearing node->locked until the slow osq_lock() path.")
  d93300891f ("locking/osq_lock: Optimise the vcpu_is_preempted() check.")

ff787c1fd0c13f9b d93300891f810c9498d09a6ecea 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3880 ±  7%     +26.4%       4903 ± 18%  vmstat.system.cs
      0.48 ±126%     -99.8%       0.00 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      0.16 ± 23%     -38.9%       0.10 ± 32%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.genl_rcv_msg
      1.50 ±118%     -99.9%       0.00 ±142%  perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      2.55 ± 97%     -83.7%       0.42 ±145%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.genl_rcv_msg
  32244865           +10.7%   35709040        stress-ng.netlink-task.ops
    537413           +10.7%     595150        stress-ng.netlink-task.ops_per_sec
     38094 ± 12%     +42.2%      54160 ± 27%  stress-ng.time.involuntary_context_switches
     42290 ± 11%     +39.8%      59117 ± 23%  stress-ng.time.voluntary_context_switches
    143.50 ±  7%     -28.8%     102.17 ± 15%  perf-c2c.DRAM.local
      4955 ±  3%     -26.4%       3647 ±  4%  perf-c2c.DRAM.remote
      4038 ±  2%     -18.8%       3277 ±  4%  perf-c2c.HITM.local
      3483 ±  3%     -21.1%       2747 ±  5%  perf-c2c.HITM.remote
      7521 ±  2%     -19.9%       6024 ±  4%  perf-c2c.HITM.total
      0.42 ±  3%     -16.2%       0.35 ±  5%  perf-stat.i.MPKI
 1.066e+10            +9.6%  1.169e+10        perf-stat.i.branch-instructions
     51.90            -2.5       49.42 ±  2%  perf-stat.i.cache-miss-rate%
  22517746 ±  3%     -13.4%   19503564 ±  5%  perf-stat.i.cache-misses
      3730 ±  7%     +29.2%       4819 ± 19%  perf-stat.i.context-switches
      3.99            -3.1%       3.86        perf-stat.i.cpi
      9535 ±  3%     +15.4%      11003 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.00 ±  3%      +0.0        0.00 ±  3%  perf-stat.i.dTLB-load-miss-rate%
 1.419e+10           -14.9%  1.207e+10        perf-stat.i.dTLB-loads
 8.411e+08            +8.4%  9.118e+08        perf-stat.i.dTLB-stores
  5.36e+10            +3.1%  5.524e+10        perf-stat.i.instructions
      0.26            +7.0%       0.28 ±  5%  perf-stat.i.ipc
    837.29 ±  3%      -9.8%     755.30 ±  4%  perf-stat.i.metric.K/sec
    401.41            -4.1%     385.10        perf-stat.i.metric.M/sec
   6404966           -23.2%    4920722        perf-stat.i.node-load-misses
    141818 ±  4%     -22.2%     110404 ±  4%  perf-stat.i.node-loads
     69.54           +13.8       83.36        perf-stat.i.node-store-miss-rate%
   3935319           +10.4%    4345724        perf-stat.i.node-store-misses
   1626033           -52.6%     771187 ±  5%  perf-stat.i.node-stores
      0.42 ±  3%     -16.0%       0.35 ±  5%  perf-stat.overall.MPKI
      0.11            -0.0        0.10 ±  8%  perf-stat.overall.branch-miss-rate%
     51.32            -2.5       48.79 ±  2%  perf-stat.overall.cache-miss-rate%
      4.06            -3.0%       3.94        perf-stat.overall.cpi
      9677 ±  3%     +15.6%      11187 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  3%      +0.0        0.00 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.25            +3.1%       0.25        perf-stat.overall.ipc
     70.78           +14.2       84.94        perf-stat.overall.node-store-miss-rate%
 1.049e+10            +9.5%  1.149e+10        perf-stat.ps.branch-instructions
  22167740 ±  3%     -13.4%   19186498 ±  5%  perf-stat.ps.cache-misses
      3667 ±  7%     +29.1%       4735 ± 19%  perf-stat.ps.context-switches
 1.396e+10           -15.0%  1.187e+10        perf-stat.ps.dTLB-loads
 8.273e+08            +8.3%  8.963e+08        perf-stat.ps.dTLB-stores
 5.274e+10            +3.0%  5.433e+10        perf-stat.ps.instructions
   6303682           -23.2%    4839978        perf-stat.ps.node-load-misses
    140690 ±  4%     -22.5%     109023 ±  4%  perf-stat.ps.node-loads
   3875362           +10.3%    4276026        perf-stat.ps.node-store-misses
   1599985           -52.6%     758184 ±  5%  perf-stat.ps.node-stores
 3.297e+12            +3.0%  3.396e+12        perf-stat.total.instructions
     96.07            -0.2       95.87        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.genl_rcv_msg.netlink_rcv_skb.genl_rcv
     97.52            -0.1       97.37        perf-profile.calltrace.cycles-pp.__mutex_lock.genl_rcv_msg.netlink_rcv_skb.genl_rcv.netlink_unicast
     98.98            -0.1       98.90        perf-profile.calltrace.cycles-pp.netlink_rcv_skb.genl_rcv.netlink_unicast.netlink_sendmsg.__sys_sendto
     98.99            -0.1       98.92        perf-profile.calltrace.cycles-pp.genl_rcv.netlink_unicast.netlink_sendmsg.__sys_sendto.__x64_sys_sendto
     98.97            -0.1       98.89        perf-profile.calltrace.cycles-pp.genl_rcv_msg.netlink_rcv_skb.genl_rcv.netlink_unicast.netlink_sendmsg
     99.09            -0.1       99.04        perf-profile.calltrace.cycles-pp.netlink_unicast.netlink_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     99.47            -0.0       99.43        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_netlink_taskstats_monitor.stress_netlink_task
     99.44            -0.0       99.40        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.stress_netlink_taskstats_monitor
     99.35            -0.0       99.32        perf-profile.calltrace.cycles-pp.netlink_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     99.44            -0.0       99.40        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     96.08            -0.2       95.89        perf-profile.children.cycles-pp.osq_lock
     97.52            -0.1       97.38        perf-profile.children.cycles-pp.__mutex_lock
     98.98            -0.1       98.90        perf-profile.children.cycles-pp.netlink_rcv_skb
     99.00            -0.1       98.92        perf-profile.children.cycles-pp.genl_rcv
     98.97            -0.1       98.89        perf-profile.children.cycles-pp.genl_rcv_msg
     99.20            -0.0       99.15        perf-profile.children.cycles-pp.netlink_unicast
      0.13 ±  3%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.genl_cmd_full_to_split
      0.14 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.genl_get_cmd
     99.36            -0.0       99.32        perf-profile.children.cycles-pp.netlink_sendmsg
     99.44            -0.0       99.41        perf-profile.children.cycles-pp.__x64_sys_sendto
     99.44            -0.0       99.41        perf-profile.children.cycles-pp.__sys_sendto
     99.59            -0.0       99.56        perf-profile.children.cycles-pp.sendto
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.genl_family_rcv_msg_attrs_parse
      0.11            +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.apparmor_capable
      0.18 ±  3%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.netlink_recvmsg
      0.36            +0.0        0.38        perf-profile.children.cycles-pp.fill_stats
      0.13 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.ns_capable
      0.20 ±  3%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.sock_recvmsg
      0.24 ±  3%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.__sys_recvfrom
      0.24 ±  3%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
      0.31 ±  3%      +0.0        0.34 ±  3%  perf-profile.children.cycles-pp.recv
      1.22            +0.0        1.26        perf-profile.children.cycles-pp.genl_family_rcv_msg
      0.85            +0.1        0.90        perf-profile.children.cycles-pp.cmd_attr_pid
      0.94            +0.1        1.01        perf-profile.children.cycles-pp.genl_family_rcv_msg_doit
      1.11            +0.1        1.23        perf-profile.children.cycles-pp.mutex_spin_on_owner
     95.80            -0.2       95.62        perf-profile.self.cycles-pp.osq_lock
      0.13 ±  3%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.genl_cmd_full_to_split
      0.11 ±  3%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.apparmor_capable
      1.11            +0.1        1.23        perf-profile.self.cycles-pp.mutex_spin_on_owner




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


