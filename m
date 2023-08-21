Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2878257F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjHUIdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHUIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:33:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE8A6;
        Mon, 21 Aug 2023 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692606788; x=1724142788;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4wG3qJlEn2yDk7wXXu74982SvBniMoQcKyTXmOG3Gs8=;
  b=EFdAKokog+4IoxA2yWCn/0lAgol6jZjK9ctZDvHMz9LMPigFbA6gOgfO
   5AyjtcNY5fKdMIRKlB2SOQGMxpiYB2CvABhi5wOFdYdmW3LTaxfzj/yuz
   AxI/GoKWMlIkphEKXpMQOsu0JCh5QbysOiZQI69YknNCIsU6jMP/8g88c
   pz5C0XecYkbQPm8jPXA4rywzDx1MneTDgzondt7/YpIh/2dq4/ti4FKg/
   CMLHbYQ9cK6VGHKSxQNlayn+9SAFq1OWuh9UkmJXOTjrmrJYeBA+UbWaf
   fI8JYsTp4es4JUrjJi45XlO2vBSYgo7+8AC8pq1uPvWk1m2GVMVoTc9Mc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="353849312"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353849312"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="982392635"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="982392635"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2023 01:33:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 01:33:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 01:33:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 01:33:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 01:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzH3T3RgI781ewJGa6++BlGmY2d3ZUAp30i9ToyL61IG72Xxnl1V5tLGuVkqArYkdCnYMxs8D2WRvQrRi5QKljRstWecJ5IxR/72hzqiHyDY8/XKn6Cw4ubJ7vLM1uMYlfaqCntnlIqWFAHGoG99ZDO0z/LI8x9/cQVSuWczmFPVrYI5/C9yd+GMEZl+R1nTPFFK2BftfN02IIW908yMZUB+Tfq0e76DUor0DZ8vTucv5IP0wd7eXjzrI0FcUQ0plurZqeyfTt+LCjZ+btxyqlNglivtqgpD9ZIA2j9Xx6FfNdgz8rpKKVnUQuH2/fp/tbkbEOA8WphUos2lDIbGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPNf3ztox2yFuWCrLG5jK6b6MWrxmbrh7MhzqLaycgo=;
 b=FgSUUfLZ3sDbqzw3lyWYH6pFfnoxP9eqmMQi9svAXOeKD4NY2IYXq+qYuqhLBvXsrBVkWQqUNhA1fHqC319iHijsfsMwM/Gt+unm9KTMAvQoSyBEO6RgwQaaseHjVFjWdlVGnhzSiJ/mx6gQmNHPhKaPxdDdGN3FArs3eAqHdwhcKAYxlcns7xkNS8cnEn2jJBXqhHIQM2k3g+e9NY6Pgrv+KwBx9ee8eok8RuyJgOXKdicM1Qu57ofKfKpRMfnNOR7wzBeE1UHX+iW1OEau6toOvOxxbhg1zOC5c2r3W1e/zuGznwka8kC2II0fnuihFBPGRLqn93ghS41Q7A1XsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 08:32:56 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 08:32:56 +0000
Date:   Mon, 21 Aug 2023 16:32:39 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <netdev@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <oliver.sang@intel.com>
Subject: Re: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
Message-ID: <202308211627.8b869c6e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814093528.117342-2-bigeasy@linutronix.de>
X-ClientProxiedBy: KU1PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:802:18::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 201e07da-e8c6-421d-69b1-08dba2213752
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RLxG02Z5gFBYojH5xcxRKU+csFWT+yWqjczhnujIc4LOtXor6ZjPaqDyefDYWQOuWoYaVnEmX/Wj6WaIziHpctdOlRHEpeDvFC7IANKboIwnGODZAx1AUJV+3rXH6+7qnSit63bO0+jrxugOcsFGO432IsqMAAMLuM+zVcZ/azlIdn55jbcx4TzzTHLiAOnw8y8PF6ZT5yMl5I+WBBMPZyKcOmsTU9ShKJXmN5/5kg+PN0u92DeA+diDSIqHgGXn1fNwHSxV++s565wLSyv1fygjgbCiLb7sXoR0TuB0wH1eq16GvtHaf8wUqFXk+EsI8Z243cPnExm2eGwQQJWyL7LANIQnmFNDRXso7WHbt8pd4VXDzAELal5TK6zjx8r8NADS25VlMOJudacDyX1EGO4DW5NEAka0mJtQxEYXQSyyPsjmW5dnc/hyJUdg0tUhpY3IG+R3qHvw3NaN1Y0TyhweIO1ZnFelirOC6VDfrT8zYZu8YjldNBZirKrQZixkHCRZGRruVZcBsPVKYeF6ZM+MCy6FZPb85tFTVtIXCmrTZCbsPYalk5BcbSLVODNRxfUif4xyNk7OcqjOTiigw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(30864003)(7416002)(83380400001)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(107886003)(4326008)(316002)(66946007)(6512007)(6916009)(54906003)(66556008)(66476007)(82960400001)(966005)(478600001)(6666004)(19627235002)(41300700001)(36756003)(1076003)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8FrRv/8TEr8wAp+MPy6alo0FByJQA2NQubdxdcp4UkxLCQC7ijsdahVvzk?=
 =?iso-8859-1?Q?2lMICThVon5dqAvUjBcs+Ugqp1OwGI8KvgJWscG/NfTX0C+ENPaJErITzW?=
 =?iso-8859-1?Q?PQAW6yDXiVE5skXTlXTpvrahpow4+eR7eksBn0WebdzAUHuTvmMg7QLqQ9?=
 =?iso-8859-1?Q?H3nkK4zyeWQ9ToggSVAon9fbrr25SydPtnwtpe8WUd1O2l1FjUxqglTADW?=
 =?iso-8859-1?Q?DfC2S1fW0DZ9fqv066SbqOXowj8ACCy3qSmDK7DeDcY3F0NwLoHkPnyjMU?=
 =?iso-8859-1?Q?fIQma1EY9JIGI4bcEcrIbWC/9qgXDTsgfsmYdduBsailjfb7w+kIfJ/wNM?=
 =?iso-8859-1?Q?/mI6sljw5iwPLA1CoJIDoppCPkiSJrL00MahC1zA7PiUR22MB0pcylhpHl?=
 =?iso-8859-1?Q?Bx11a20yD6o8iW0mwgSiphDoVqLwhPqsx7qPXQTFMNc54lX8zF5clagPjQ?=
 =?iso-8859-1?Q?fTZrLEbqqrHKRpZZmQ6sUCFXkk20mLRNa1q2rK9ZTg1GYcf4vCOhW0KPVi?=
 =?iso-8859-1?Q?0ai6pURZYjDAtOuAs98R6QRZXMUFsSyy4h30qaAxzE4LAMQBjVbHa6jPku?=
 =?iso-8859-1?Q?16eIm+QJePWjF5KSJsZW6+99zqVJmy5t6qMCbjz9ZtSA9mhR3+vUUuPO4S?=
 =?iso-8859-1?Q?053CMFjwyOwavid+9Fpx3Rwb0Uzd6o97iwzjZ6sqzJQ7jNrxX4/FCmD2jf?=
 =?iso-8859-1?Q?nr6aGXRM1J0ACNvHe0TeJbYqG79NH0r3KLV9mTAIywNI/mgZt35rLguY5X?=
 =?iso-8859-1?Q?w5Z5Ja2cjD78Ei9K+PJYjdPAm3wMqh5RvCWWYy7FYR6oxyD6FPOQd8U1jx?=
 =?iso-8859-1?Q?hO9RXHvVuAorSoIgT0rHU6Lz1YFz7CLeYiPXNRcXo7/OVh6uRkqp2fO8Ex?=
 =?iso-8859-1?Q?NIuxPy66iRiu7rO8i7KGX0HyGHcH/6DfD8KBgQPWI+GqJnOyFFknYrN4p3?=
 =?iso-8859-1?Q?3947dpxHnKb2ydjaxWpOAIa0XKj5jhXLcg30tktR0nTu0lbnN3tH0LAifY?=
 =?iso-8859-1?Q?F9LMHd8vlzJvmmcFfWMA9YMceHRjhuPDxo4aFG/QrDpBa1V/HGZeelY3rP?=
 =?iso-8859-1?Q?J49bQdj0gdcO/aSGETliexjE5YrD/RSmbnKmPhNoXnxgqvY8j4RdfOuF2q?=
 =?iso-8859-1?Q?j92DUQQNi8ahsw99zNuTRegDpzLul9ZWL2Npp3RoJrPWFvo5hmCsEy9mCb?=
 =?iso-8859-1?Q?RLV8go70ae+qFhek6JL+5EGzhH3l9bPo7EArFai5dV8f+xpN8MjSajJz/l?=
 =?iso-8859-1?Q?orRlKisP3T3VEShGPP3oaPkSAwAyvVVCLlzslZNT3fC2MdYTyaYauKM7Yc?=
 =?iso-8859-1?Q?GmhXBJ5jRx3SbXtYh72A+SBn6V0IMc5nD39CJyv0i8W25pEkSl+qtBM83n?=
 =?iso-8859-1?Q?UHCxgX01MwTfmxZsP/JiXbg/D9/AntK/7a7+LUObQyUOY9zUI4pRVd2A1A?=
 =?iso-8859-1?Q?LWxnoJstTVQdhAer+/j5unMws7UtsMRk7jHmNq1jiNOw3auuQUHWUvbYBj?=
 =?iso-8859-1?Q?NcZweaVXlbCXA4ZM0j1nUeWXpBr6qZ0pDRzhwp3/2yCqKjjrgu1uqsici2?=
 =?iso-8859-1?Q?xqcOZdZvUDBdxPvVw/jG0DCM1eq+3Xu/KAIWckA+tM2cWnwLKqJy5CoGhz?=
 =?iso-8859-1?Q?Ykly5ypjL36mF4znoNQBpMCw8qjt4sD1mjayI34cCwDc3jXe5+o3tW9Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 201e07da-e8c6-421d-69b1-08dba2213752
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 08:32:55.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5veV02uQID/H9j3Vwls7UL9EgY/BB/PMpJjbYuU2ruB3zS0+BRj2WZHh7Os/m1CevfVtQpKgaGEcfjNijLBtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -17.5% regression of phoronix-test-suite.netperf.localhost.UDPRequestResponse.10Seconds.transaction_rate_per_second on:


commit: e9dc861c8b3c291826d6cc1a8674ec0b148cd82d ("[RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.")
url: https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/net-Use-SMP-threads-for-backlog-NAPI/20230814-173835
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 83b5f0253b1ef352f4333c4fb2d24eff23045f6b
patch link: https://lore.kernel.org/all/20230814093528.117342-2-bigeasy@linutronix.de/
patch subject: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.

testcase: phoronix-test-suite
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
parameters:

	test: netperf-1.0.4
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.udp.ops_per_sec -40.3% regression                                          |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=os                                                                                        |
|                  | cpufreq_governor=performance                                                                    |
|                  | disk=1HDD                                                                                       |
|                  | fs=ext4                                                                                         |
|                  | nr_threads=1                                                                                    |
|                  | test=udp                                                                                        |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | qperf: qperf.udp.send_bw -24.2% regression                                                      |
| test machine     | 8 threads 1 sockets Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz (Haswell) with 8G memory           |
| test parameters  | cluster=cs-localhost                                                                            |
|                  | cpufreq_governor=performance                                                                    |
|                  | runtime=600s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | uperf: uperf.Runstat_master_Mbps -16.5% regression                                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory       |
| test parameters  | cluster=cs-localhost                                                                            |
|                  | cpufreq_governor=performance                                                                    |
|                  | datasize=64                                                                                     |
|                  | nr_threads=1                                                                                    |
|                  | protocol=UDP                                                                                    |
|                  | runtime=30s                                                                                     |
|                  | winsize=32k                                                                                     |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.dccp.ops_per_sec -16.0% regression                                         |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=os                                                                                        |
|                  | cpufreq_governor=performance                                                                    |
|                  | disk=1HDD                                                                                       |
|                  | fs=ext4                                                                                         |
|                  | nr_threads=1                                                                                    |
|                  | test=dccp                                                                                       |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308211627.8b869c6e-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230821/202308211627.8b869c6e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-x86_64-phoronix/lkp-csl-2sp7/netperf-1.0.4/phoronix-test-suite

commit: 
  83b5f0253b ("net: phy: Introduce PSGMII PHY interface mode")
  e9dc861c8b ("net: Use SMP threads for backlog NAPI.")

83b5f0253b1ef352 e9dc861c8b3c291826d6cc1a867 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  12507317           -10.7%   11173853        cpuidle..usage
     23.00 ± 14%     +42.0%      32.67 ±  7%  perf-c2c.DRAM.local
      3.91 ±101%      -2.3        1.64 ±149%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
    116234           -17.5%      95851        phoronix-test-suite.netperf.localhost.UDPRequestResponse.10Seconds.transaction_rate_per_second
    237948           +67.3%     398178        vmstat.system.cs
      0.22            -0.1        0.10        mpstat.cpu.all.soft%
      0.53            +0.1        0.63        mpstat.cpu.all.sys%
     20688            +7.4%      22214        proc-vmstat.nr_kernel_stack
     53103            +1.4%      53861        proc-vmstat.nr_slab_unreclaimable
   1991060 ±  8%     +55.7%    3100058        turbostat.C1
      0.14 ±  6%      +0.2        0.31 ±  4%  turbostat.C1%
      0.29 ±  4%      +0.1        0.42 ±  3%  turbostat.C1E%
   5063449 ±  4%     -46.3%    2720011 ±  2%  turbostat.POLL
      0.26 ±  4%      -0.1        0.17 ±  2%  turbostat.POLL%
    114.60            +1.6%     116.47        turbostat.PkgWatt
     48.25 ±  4%      -4.8%      45.93 ±  2%  perf-stat.i.MPKI
 7.498e+08 ±  2%      +8.2%  8.113e+08        perf-stat.i.branch-instructions
  85554181            -4.4%   81810261        perf-stat.i.cache-references
    255667 ±  2%     +66.2%     425026        perf-stat.i.context-switches
      3.23 ±  3%      -4.4%       3.09        perf-stat.i.cpi
    106.09          +172.8%     289.40 ± 22%  perf-stat.i.cpu-migrations
      3590            -7.0%       3340 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.47 ±  5%      -0.1        0.42 ±  2%  perf-stat.i.dTLB-load-miss-rate%
   1930027 ±  2%     -11.0%    1717629 ±  3%  perf-stat.i.dTLB-load-misses
 9.746e+08 ±  2%      +7.7%   1.05e+09        perf-stat.i.dTLB-loads
      0.08 ±  7%      -0.0        0.07 ±  2%  perf-stat.i.dTLB-store-miss-rate%
    172760 ±  4%     -11.6%     152755        perf-stat.i.dTLB-store-misses
 5.334e+08            +7.8%  5.749e+08        perf-stat.i.dTLB-stores
     81.38            -7.8       73.60        perf-stat.i.iTLB-load-miss-rate%
   4442067 ±  2%     -34.2%    2922023        perf-stat.i.iTLB-load-misses
    869196 ±  6%     +32.5%    1151689 ±  2%  perf-stat.i.iTLB-loads
 3.764e+09 ±  2%      +6.7%  4.014e+09        perf-stat.i.instructions
      1237 ±  5%     +26.3%       1563 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.49 ±  2%      +8.8%       0.53        perf-stat.i.ipc
     23.38 ±  2%      +7.9%      25.24        perf-stat.i.metric.M/sec
    120711 ±  5%     +29.5%     156269 ± 14%  perf-stat.i.node-load-misses
     22.77 ±  3%     -10.4%      20.40 ±  2%  perf-stat.overall.MPKI
      3.25 ±  2%      -0.2        3.04        perf-stat.overall.branch-miss-rate%
      2.86 ±  2%      +0.2        3.07 ±  3%  perf-stat.overall.cache-miss-rate%
      1.91 ±  2%      -7.9%       1.75        perf-stat.overall.cpi
      2928 ±  2%      -4.2%       2804 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.20 ±  4%      -0.0        0.16 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.03 ±  4%      -0.0        0.03        perf-stat.overall.dTLB-store-miss-rate%
     83.63           -11.9       71.73        perf-stat.overall.iTLB-load-miss-rate%
    847.76 ±  2%     +62.0%       1373        perf-stat.overall.instructions-per-iTLB-miss
      0.52            +8.6%       0.57        perf-stat.overall.ipc
 7.356e+08 ±  2%      +8.2%  7.957e+08        perf-stat.ps.branch-instructions
  84014375            -4.4%   80324771        perf-stat.ps.cache-references
    250660 ±  2%     +66.3%     416753        perf-stat.ps.context-switches
 7.033e+09            -1.8%  6.906e+09        perf-stat.ps.cpu-cycles
    104.17          +172.6%     283.93 ± 22%  perf-stat.ps.cpu-migrations
   1896175 ±  2%     -11.0%    1687140 ±  3%  perf-stat.ps.dTLB-load-misses
 9.562e+08 ±  2%      +7.7%   1.03e+09        perf-stat.ps.dTLB-loads
    169740 ±  4%     -11.6%     150033        perf-stat.ps.dTLB-store-misses
 5.232e+08            +7.8%  5.639e+08        perf-stat.ps.dTLB-stores
   4356522 ±  2%     -34.2%    2866282        perf-stat.ps.iTLB-load-misses
    852611 ±  6%     +32.5%    1129564 ±  2%  perf-stat.ps.iTLB-loads
 3.693e+09 ±  2%      +6.6%  3.937e+09        perf-stat.ps.instructions
    118546 ±  5%     +29.4%     153343 ± 14%  perf-stat.ps.node-load-misses
 2.069e+11            +5.0%  2.173e+11        perf-stat.total.instructions


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/udp/stress-ng/60s

commit: 
  83b5f0253b ("net: phy: Introduce PSGMII PHY interface mode")
  e9dc861c8b ("net: Use SMP threads for backlog NAPI.")

83b5f0253b1ef352 e9dc861c8b3c291826d6cc1a867 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  12790365 ±  2%     +32.0%   16887592 ±  3%  cpuidle..usage
      4.74            -8.6%       4.33        iostat.cpu.system
     17.33 ± 19%     -45.2%       9.50 ± 28%  perf-c2c.DRAM.local
      1.15 ±  2%      -1.1        0.07        mpstat.cpu.all.soft%
      3.06 ±  2%      +0.6        3.71        mpstat.cpu.all.sys%
      0.47 ±  9%      +0.1        0.55        mpstat.cpu.all.usr%
   3451432           +12.0%    3864232        vmstat.memory.cache
    412424 ±  3%    +198.2%    1230008        vmstat.system.cs
     93962 ±  6%     +21.0%     113707 ±  4%  vmstat.system.in
     19785 ±  5%   +1026.7%     222913 ±  5%  turbostat.C1
      0.06 ±  9%      +0.1        0.12 ±  6%  turbostat.C1%
   6268454 ±  6%     +19.8%    7509215 ±  3%  turbostat.IRQ
   9630603 ±  3%     +40.8%   13558028 ±  4%  turbostat.POLL
      0.25 ±  4%      +0.2        0.46        turbostat.POLL%
      3347 ±  4%  +6.5e+05%   21761039        stress-ng.time.involuntary_context_switches
    121.33           -21.4%      95.33        stress-ng.time.percent_of_cpu_this_job_got
     71.34           -22.6%      55.23        stress-ng.time.system_time
  12757669           +40.4%   17909736 ±  2%  stress-ng.time.voluntary_context_switches
  36420509           -40.3%   21760688        stress-ng.udp.ops
    607006           -40.3%     362677        stress-ng.udp.ops_per_sec
    471964           +81.1%     854856        meminfo.Active
    453420           +85.0%     838688        meminfo.Active(anon)
   3355258           +12.2%    3764944        meminfo.Cached
   1009405           +41.2%    1425669        meminfo.Committed_AS
     57926           +19.5%      69211 ±  2%  meminfo.Mapped
   4156253            +9.9%    4569409        meminfo.Memused
    502429           +82.5%     916869        meminfo.Shmem
    113354           +85.0%     209672        proc-vmstat.nr_active_anon
    842826           +12.2%     945267        proc-vmstat.nr_file_pages
     87951            +8.9%      95743        proc-vmstat.nr_inactive_anon
      8798            +6.2%       9348        proc-vmstat.nr_kernel_stack
     14481           +19.5%      17312 ±  2%  proc-vmstat.nr_mapped
    125608           +82.5%     229221        proc-vmstat.nr_shmem
    113354           +85.0%     209672        proc-vmstat.nr_zone_active_anon
     87951            +8.9%      95743        proc-vmstat.nr_zone_inactive_anon
   1222387           -22.1%     952448        proc-vmstat.numa_hit
   1220389           -22.0%     952356        proc-vmstat.numa_local
    172618           +61.8%     279233 ±  3%  proc-vmstat.pgactivate
   2049577           -32.9%    1375385        proc-vmstat.pgalloc_normal
    228482           +10.4%     252349        proc-vmstat.pgfault
   1847715           -44.3%    1029148        proc-vmstat.pgfree
      0.00 ± 27%     -68.8%       0.00 ± 44%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 41%     -74.5%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00           -58.3%       0.00 ± 44%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.00 ±223%    +900.0%       0.00 ± 33%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.00 ± 48%    +130.4%       0.01 ± 13%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.71 ±  2%     -51.3%       0.35 ±  4%  perf-sched.total_wait_and_delay.average.ms
    648341          +176.4%    1792232        perf-sched.total_wait_and_delay.count.ms
      0.71 ±  2%     -51.5%       0.35 ±  4%  perf-sched.total_wait_time.average.ms
    273.60 ±  7%     -34.3%     179.63 ± 28%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     49.49           -43.6%      27.89 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00          +200.0%       0.01        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
    303.03 ±  4%     -99.8%       0.64 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    474.17 ±  3%     +18.8%     563.18 ±  5%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.50 ± 74%    +322.2%       6.33 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      2.67 ± 63%    +731.2%      22.17 ± 14%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      1.00 ± 81%    +666.7%       7.67 ± 32%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    337.67           +62.6%     549.17 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    734.00 ±  3%  +77846.9%     572130        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1491 ± 32%     -33.0%       1000        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.08 ± 44%     -94.7%       0.00 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      0.07 ± 28%     -87.0%       0.01 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
    273.60 ±  7%     -34.3%     179.63 ± 28%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±223%  +15780.0%       0.13 ± 26%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.09 ± 42%   +2947.0%       2.74 ± 19%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.08 ± 81%  +72717.2%      56.43 ± 69%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.07 ± 30%     -92.0%       0.01 ± 44%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     49.49           -43.6%      27.89 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00          +150.0%       0.01        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      0.32 ±  3%     -34.2%       0.21 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    303.02 ±  4%     -99.8%       0.63 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%   +1300.0%       0.00 ± 20%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    474.16 ±  3%     +18.8%     563.18 ±  5%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.26 ± 25%     -97.0%       0.01 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      0.44 ± 55%     -91.1%       0.04 ± 76%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1491 ± 32%     -33.0%    1000.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±223%  +73360.0%       0.61 ±  6%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.28 ± 35%   +6429.9%      18.23 ± 14%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.24 ±113%  +4.2e+05%       1000        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      3.43 ±180%  +19504.1%     672.98 ± 68%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
 1.548e+09 ±  2%     +18.9%   1.84e+09        perf-stat.i.branch-instructions
  22847886 ±  4%      +6.2%   24254832        perf-stat.i.branch-misses
      2.69 ±  6%      +0.4        3.06 ±  3%  perf-stat.i.cache-miss-rate%
  77034877 ±  3%      -5.8%   72570665        perf-stat.i.cache-references
    431302 ±  3%    +199.0%    1289755        perf-stat.i.context-switches
 8.536e+09            +4.6%   8.93e+09        perf-stat.i.cpu-cycles
     99.38          +247.5%     345.39 ±  4%  perf-stat.i.cpu-migrations
     14408 ± 11%    +133.1%      33584 ± 11%  perf-stat.i.cycles-between-cache-misses
 2.218e+09           +11.8%  2.481e+09        perf-stat.i.dTLB-loads
 1.366e+09 ±  2%      +8.2%  1.477e+09        perf-stat.i.dTLB-stores
     91.20            -1.8       89.40        perf-stat.i.iTLB-load-miss-rate%
  11898638           -33.9%    7865700        perf-stat.i.iTLB-load-misses
    998370 ±  7%     -15.0%     848296 ±  7%  perf-stat.i.iTLB-loads
 8.146e+09 ±  2%     +12.6%  9.171e+09        perf-stat.i.instructions
    848.55 ±  4%     +55.5%       1319        perf-stat.i.instructions-per-iTLB-miss
      0.95            +8.1%       1.02        perf-stat.i.ipc
      0.31 ± 44%     -84.8%       0.05 ± 82%  perf-stat.i.major-faults
      0.24            +4.6%       0.25        perf-stat.i.metric.GHz
    144.65 ±  2%     +12.7%     163.06        perf-stat.i.metric.M/sec
      2104 ±  2%     +19.6%       2516        perf-stat.i.minor-faults
    221343 ±  3%     -18.6%     180275 ±  2%  perf-stat.i.node-stores
      2104 ±  2%     +19.6%       2516        perf-stat.i.page-faults
      9.46 ±  2%     -16.3%       7.91 ±  2%  perf-stat.overall.MPKI
      1.48 ±  3%      -0.2        1.32        perf-stat.overall.branch-miss-rate%
      2.26 ±  4%      +0.2        2.50 ±  3%  perf-stat.overall.cache-miss-rate%
      1.05            -7.1%       0.97        perf-stat.overall.cpi
     92.26            -2.0       90.27        perf-stat.overall.iTLB-load-miss-rate%
    684.71           +70.3%       1166        perf-stat.overall.instructions-per-iTLB-miss
      0.95            +7.6%       1.03        perf-stat.overall.ipc
 1.524e+09 ±  2%     +18.9%  1.811e+09        perf-stat.ps.branch-instructions
  22493006 ±  4%      +6.1%   23874609        perf-stat.ps.branch-misses
  75835384 ±  3%      -5.8%   71429667        perf-stat.ps.cache-references
    424565 ±  3%    +199.0%    1269435        perf-stat.ps.context-switches
 8.403e+09            +4.6%   8.79e+09        perf-stat.ps.cpu-cycles
     97.83          +247.5%     339.96 ±  4%  perf-stat.ps.cpu-migrations
 2.184e+09           +11.8%  2.442e+09        perf-stat.ps.dTLB-loads
 1.345e+09            +8.1%  1.454e+09        perf-stat.ps.dTLB-stores
  11713146           -33.9%    7742064        perf-stat.ps.iTLB-load-misses
    982805 ±  7%     -15.0%     834974 ±  7%  perf-stat.ps.iTLB-loads
 8.019e+09 ±  2%     +12.6%  9.027e+09        perf-stat.ps.instructions
      0.31 ± 44%     -84.8%       0.05 ± 82%  perf-stat.ps.major-faults
      2071 ±  2%     +19.6%       2477        perf-stat.ps.minor-faults
    217934 ±  3%     -18.5%     177518 ±  2%  perf-stat.ps.node-stores
      2072 ±  2%     +19.6%       2477        perf-stat.ps.page-faults
 5.177e+11           +11.4%  5.769e+11        perf-stat.total.instructions
     32.52 ±  6%     -20.3       12.19 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     32.28 ±  6%     -20.2       12.05 ±  2%  perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     30.73 ±  6%     -19.6       11.12 ±  2%  perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.02 ±  6%     -19.2       10.82 ±  2%  perf-profile.calltrace.cycles-pp.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     33.44 ±  6%     -17.6       15.84 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto
     33.10 ±  6%     -17.5       15.60 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     34.40 ±  6%     -16.8       17.62 ±  2%  perf-profile.calltrace.cycles-pp.sendto
     14.33 ±  6%     -14.3        0.00        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
     14.25 ±  6%     -14.2        0.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
     18.23 ±  6%     -14.2        4.02 ±  3%  perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     14.11 ±  6%     -14.1        0.00        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     17.78 ±  6%     -13.9        3.85 ±  4%  perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
     16.84 ±  6%     -13.4        3.39 ±  4%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg
     16.36 ±  6%     -13.2        3.19 ±  4%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
     13.08 ±  7%     -13.1        0.00        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     12.78 ±  7%     -12.8        0.00        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
     12.74 ±  7%     -12.7        0.00        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
     11.96 ±  6%     -12.0        0.00        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
     11.06 ±  6%     -11.1        0.00        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      8.47 ±  6%      -3.4        5.02        perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      5.81 ±  7%      -2.4        3.37 ±  2%  perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
     10.99 ±  6%      -2.4        8.57 ±  5%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     10.64 ±  6%      -2.2        8.41 ±  4%  perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      4.35 ± 10%      -2.0        2.37 ±  6%  perf-profile.calltrace.cycles-pp.ioctl
      9.63 ±  6%      -1.8        7.87 ±  4%  perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      3.48 ± 10%      -1.7        1.82 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl
      3.37 ±  9%      -1.6        1.75 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      9.38 ±  7%      -1.6        7.78 ±  4%  perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      3.19 ± 10%      -1.6        1.63 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      1.83 ± 12%      -1.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.sk_ioctl.inet_ioctl.sock_do_ioctl.sock_ioctl.do_vfs_ioctl
      2.23 ± 12%      -1.4        0.78 ±  9%  perf-profile.calltrace.cycles-pp.sock_do_ioctl.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      2.84 ± 11%      -1.4        1.42 ±  6%  perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      2.10 ± 12%      -1.4        0.71 ± 10%  perf-profile.calltrace.cycles-pp.inet_ioctl.sock_do_ioctl.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl
      2.45 ± 12%      -1.4        1.08 ± 26%  perf-profile.calltrace.cycles-pp.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.02 ±  8%      -1.3        1.76 ±  4%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
      1.58 ± 13%      -1.0        0.62 ± 10%  perf-profile.calltrace.cycles-pp.udp_rmem_release.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg
      2.24 ±  5%      -1.0        1.29 ±  5%  perf-profile.calltrace.cycles-pp.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
      2.89 ±  7%      -0.9        1.96 ±  6%  perf-profile.calltrace.cycles-pp._copy_to_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      2.70 ±  7%      -0.9        1.80 ±  6%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg
      1.97 ±  4%      -0.9        1.08 ±  4%  perf-profile.calltrace.cycles-pp.ip_route_output_flow.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      2.35 ±  7%      -0.9        1.47 ±  3%  perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
      7.34 ±  7%      -0.8        6.49 ±  4%  perf-profile.calltrace.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      2.58 ±  7%      -0.8        1.74 ±  7%  perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyout._copy_to_iter.udp_recvmsg.inet_recvmsg
      1.87 ±  7%      -0.8        1.07 ±  6%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg
      1.67 ±  5%      -0.8        0.92 ±  3%  perf-profile.calltrace.cycles-pp.__mkroute_output.ip_route_output_flow.udp_sendmsg.sock_sendmsg.__sys_sendto
      1.78 ±  7%      -0.8        1.03 ±  5%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb
      3.44 ± 10%      -0.7        2.76 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.76 ±  8%      -0.6        1.10 ±  2%  perf-profile.calltrace.cycles-pp.__ip_select_ident.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_sendmsg
      3.19 ± 10%      -0.6        2.54 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.43 ±  6%      -0.6        0.80 ±  7%  perf-profile.calltrace.cycles-pp.__check_object_size.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
      1.07 ± 11%      -0.6        0.46 ± 71%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.02 ± 11%      -0.6        0.42 ± 72%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.07 ±  7%      -0.6        0.49 ± 45%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.ip_generic_getfrag.__ip_append_data.ip_make_skb
      1.54 ±  7%      -0.6        0.98 ±  9%  perf-profile.calltrace.cycles-pp.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      1.51 ±  7%      -0.5        0.97 ±  9%  perf-profile.calltrace.cycles-pp.skb_release_data.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.sock_recvmsg
      1.02 ± 11%      -0.4        0.61 ±  6%  perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg
      1.10 ±  8%      -0.4        0.70 ±  9%  perf-profile.calltrace.cycles-pp.__slab_free.skb_release_data.__consume_stateless_skb.udp_recvmsg.inet_recvmsg
      0.98 ±  8%      -0.4        0.60 ± 12%  perf-profile.calltrace.cycles-pp.ipv4_pktinfo_prepare.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      0.85 ±  9%      -0.2        0.61 ±  8%  perf-profile.calltrace.cycles-pp.move_addr_to_user.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ± 13%      +0.2        0.92 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      0.73 ± 15%      +0.2        0.98 ± 12%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.48 ± 47%      +0.3        0.75 ± 14%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.poll_idle.cpuidle_enter_state.cpuidle_enter
      0.96 ± 12%      +0.3        1.28 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.06 ± 12%      +0.3        1.39 ±  8%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      0.99 ± 12%      +0.3        1.33 ±  8%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      0.18 ±141%      +0.4        0.56 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb
      0.19 ±142%      +0.5        0.65 ± 14%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.poll_idle.cpuidle_enter_state
      1.43 ±  7%      +0.5        1.90 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.52 ±  8%      +0.5        2.00 ±  6%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.10 ±223%      +0.5        0.64 ± 15%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.poll_idle
      1.00 ±  9%      +0.5        1.54 ±  5%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      1.76 ± 11%      +0.6        2.34 ± 13%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.00            +0.6        0.59 ±  6%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.00            +0.6        0.60 ±  5%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.smpboot_thread_fn
      1.14 ±  9%      +0.6        1.75 ±  5%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      2.36 ± 10%      +0.7        3.02 ±  9%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.7        0.69 ±  7%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.smpboot_thread_fn.kthread
      2.58 ± 10%      +0.7        3.32 ±  9%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.8        0.79 ±  7%  perf-profile.calltrace.cycles-pp.__switch_to_asm
      0.00            +0.8        0.81 ±  7%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop
      0.00            +0.8        0.84 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.enqueue_to_backlog
      0.00            +0.9        0.86 ±  7%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.00            +0.9        0.88 ±  7%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.enqueue_to_backlog.netif_rx_internal
      0.00            +0.9        0.92 ±  6%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.00            +0.9        0.94 ±  6%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.00            +0.9        0.94 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.smpboot_thread_fn.kthread
      0.00            +1.1        1.06 ±  7%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.65 ± 10%      +1.1        1.72 ±  2%  perf-profile.calltrace.cycles-pp.clock_nanosleep
      0.47 ± 45%      +1.2        1.63 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.48 ± 45%      +1.2        1.64 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00            +1.2        1.19 ±  6%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.do_nanosleep
      0.00            +1.2        1.20 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.37 ± 71%      +1.3        1.62 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      2.29 ±  7%      +1.3        3.57 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp
      0.00            +1.3        1.29 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.27 ±100%      +1.3        1.59 ±  2%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.27 ±100%      +1.3        1.59 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.3        1.32 ±  5%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.enqueue_to_backlog.netif_rx_internal.__netif_rx
      2.37 ±  8%      +1.4        3.72 ±  5%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      0.00            +1.4        1.43 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.00            +1.4        1.44 ±  3%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.09 ±223%      +1.5        1.57 ±  3%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      1.19 ±  8%      +1.5        2.68 ±  3%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      1.06 ±  7%      +1.5        2.60 ±  3%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      2.82 ±  6%      +1.6        4.39 ±  5%  perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg
      4.30 ±  7%      +1.9        6.15 ±  4%  perf-profile.calltrace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +2.0        1.95 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit
      0.00            +2.2        2.17 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit
      0.00            +2.2        2.19 ±  3%  perf-profile.calltrace.cycles-pp.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      0.00            +2.2        2.20 ±  3%  perf-profile.calltrace.cycles-pp.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
     32.32 ±  2%      +2.3       34.61 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +2.5        2.45 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +2.6        2.55 ±  3%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3.23 ± 10%      +2.6        5.82 ±  7%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +2.7        2.72 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.0        3.00 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      0.00            +3.0        3.04 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +3.2        3.16 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      0.00            +3.2        3.20 ±  4%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     28.90 ±  6%      +3.4       32.30 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     40.00 ±  2%      +4.9       44.94        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     35.98 ±  5%      +5.3       41.24 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     36.05 ±  5%      +5.3       41.34 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     36.06 ±  5%      +5.3       41.36 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.00            +8.6        8.61 ±  4%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.napi_threaded_poll_loop
      0.00            +9.1        9.13 ±  4%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn
      0.00            +9.6        9.60 ±  4%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn.kthread
      0.00            +9.6        9.63 ±  4%  perf-profile.calltrace.cycles-pp.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +9.8        9.84 ±  4%  perf-profile.calltrace.cycles-pp.napi_threaded_poll_loop.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00           +14.1       14.09 ±  4%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00           +14.2       14.16 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00           +14.2       14.16 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.00           +14.2       14.16 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     32.55 ±  6%     -20.4       12.20 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sendto
     32.31 ±  6%     -20.3       12.06 ±  2%  perf-profile.children.cycles-pp.__sys_sendto
     54.70           -20.2       34.52        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     54.00           -20.0       34.04        perf-profile.children.cycles-pp.do_syscall_64
     30.75 ±  6%     -19.6       11.13 ±  2%  perf-profile.children.cycles-pp.sock_sendmsg
     30.07 ±  6%     -19.2       10.83 ±  2%  perf-profile.children.cycles-pp.udp_sendmsg
     34.63 ±  6%     -16.9       17.77 ±  2%  perf-profile.children.cycles-pp.sendto
     15.74 ±  5%     -14.6        1.10 ± 10%  perf-profile.children.cycles-pp.__do_softirq
     14.47 ±  6%     -14.3        0.17 ± 29%  perf-profile.children.cycles-pp.__local_bh_enable_ip
     14.26 ±  6%     -14.3        0.01 ±223%  perf-profile.children.cycles-pp.do_softirq
     18.24 ±  6%     -14.2        4.03 ±  3%  perf-profile.children.cycles-pp.udp_send_skb
     17.80 ±  6%     -13.9        3.86 ±  4%  perf-profile.children.cycles-pp.ip_send_skb
     16.84 ±  6%     -13.5        3.39 ±  4%  perf-profile.children.cycles-pp.ip_finish_output2
     16.38 ±  6%     -13.2        3.20 ±  4%  perf-profile.children.cycles-pp.__dev_queue_xmit
     13.10 ±  7%     -13.1        0.00        perf-profile.children.cycles-pp.net_rx_action
      8.49 ±  6%      -3.5        5.03        perf-profile.children.cycles-pp.ip_make_skb
     12.78 ±  7%      -3.1        9.64 ±  4%  perf-profile.children.cycles-pp.__napi_poll
     12.74 ±  7%      -3.1        9.61 ±  4%  perf-profile.children.cycles-pp.process_backlog
     11.98 ±  6%      -2.8        9.14 ±  4%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     11.06 ±  6%      -2.5        8.61 ±  4%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      5.82 ±  6%      -2.4        3.37 ±  2%  perf-profile.children.cycles-pp.__ip_append_data
     11.00 ±  6%      -2.4        8.58 ±  5%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     10.66 ±  6%      -2.2        8.42 ±  5%  perf-profile.children.cycles-pp.__udp4_lib_rcv
      4.58 ± 10%      -2.1        2.53 ±  6%  perf-profile.children.cycles-pp.ioctl
      9.64 ±  6%      -1.8        7.88 ±  4%  perf-profile.children.cycles-pp.udp_unicast_rcv_skb
      9.42 ±  7%      -1.6        7.80 ±  4%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      3.19 ± 10%      -1.6        1.63 ±  4%  perf-profile.children.cycles-pp.__x64_sys_ioctl
      2.26 ± 12%      -1.4        0.81 ±  9%  perf-profile.children.cycles-pp.sock_do_ioctl
      2.84 ± 11%      -1.4        1.42 ±  6%  perf-profile.children.cycles-pp.do_vfs_ioctl
      2.13 ± 12%      -1.4        0.72 ± 10%  perf-profile.children.cycles-pp.inet_ioctl
      2.49 ± 11%      -1.4        1.10 ± 25%  perf-profile.children.cycles-pp.sock_ioctl
      1.85 ± 12%      -1.3        0.52 ±  9%  perf-profile.children.cycles-pp.sk_ioctl
      3.03 ±  8%      -1.3        1.76 ±  5%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      1.53 ± 11%      -1.2        0.35 ± 13%  perf-profile.children.cycles-pp.udp_ioctl
      1.48 ± 11%      -1.2        0.31 ± 14%  perf-profile.children.cycles-pp.first_packet_length
      3.86 ±  8%      -1.1        2.73 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.14 ±  8%      -1.1        3.03 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.11 ±  6%      -1.0        2.08 ±  5%  perf-profile.children.cycles-pp.rep_movs_alternative
      1.58 ± 13%      -1.0        0.62 ± 10%  perf-profile.children.cycles-pp.udp_rmem_release
      2.25 ±  6%      -1.0        1.30 ±  5%  perf-profile.children.cycles-pp.ip_generic_getfrag
      2.90 ±  7%      -0.9        1.96 ±  6%  perf-profile.children.cycles-pp._copy_to_iter
      2.78 ±  7%      -0.9        1.85 ±  7%  perf-profile.children.cycles-pp.copyout
      2.38 ±  7%      -0.9        1.50 ±  3%  perf-profile.children.cycles-pp.__ip_make_skb
      1.98 ±  4%      -0.9        1.09 ±  4%  perf-profile.children.cycles-pp.ip_route_output_flow
      2.05 ±  5%      -0.9        1.18 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      1.62 ±  6%      -0.9        0.75 ± 14%  perf-profile.children.cycles-pp.__irq_exit_rcu
      7.35 ±  7%      -0.9        6.49 ±  4%  perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
      2.10 ±  7%      -0.8        1.28 ±  9%  perf-profile.children.cycles-pp.__slab_free
      1.88 ±  7%      -0.8        1.07 ±  6%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      1.56 ±  6%      -0.8        0.77 ±  8%  perf-profile.children.cycles-pp.rcu_do_batch
      1.48 ±  6%      -0.8        0.72 ±  8%  perf-profile.children.cycles-pp.dst_destroy
      1.59 ±  7%      -0.8        0.84 ±  8%  perf-profile.children.cycles-pp.rcu_core
      1.79 ±  8%      -0.8        1.04 ±  5%  perf-profile.children.cycles-pp.__alloc_skb
      1.67 ±  5%      -0.8        0.92 ±  3%  perf-profile.children.cycles-pp.__mkroute_output
      1.76 ±  8%      -0.7        1.11 ±  3%  perf-profile.children.cycles-pp.__ip_select_ident
      1.28 ±  6%      -0.6        0.69 ±  7%  perf-profile.children.cycles-pp.check_heap_object
      1.54 ±  7%      -0.6        0.98 ±  9%  perf-profile.children.cycles-pp.__consume_stateless_skb
      1.51 ±  7%      -0.5        0.97 ±  9%  perf-profile.children.cycles-pp.skb_release_data
      0.62 ±  4%      -0.5        0.14 ± 11%  perf-profile.children.cycles-pp.irqtime_account_irq
      1.40 ±  8%      -0.4        0.97 ± 11%  perf-profile.children.cycles-pp.__entry_text_start
      1.02 ± 11%      -0.4        0.61 ±  6%  perf-profile.children.cycles-pp.skb_set_owner_w
      1.23 ± 11%      -0.4        0.82 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.99 ±  8%      -0.4        0.60 ± 11%  perf-profile.children.cycles-pp.ipv4_pktinfo_prepare
      0.84 ±  7%      -0.4        0.47 ±  7%  perf-profile.children.cycles-pp.rt_dst_alloc
      0.72 ± 10%      -0.4        0.35 ± 15%  perf-profile.children.cycles-pp.__udp4_lib_lookup
      0.82 ± 14%      -0.4        0.47 ± 11%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.76 ±  7%      -0.3        0.43 ±  7%  perf-profile.children.cycles-pp.dst_alloc
      0.74 ± 10%      -0.3        0.45 ±  6%  perf-profile.children.cycles-pp._copy_from_iter
      0.34 ± 20%      -0.3        0.05 ± 51%  perf-profile.children.cycles-pp.__first_packet_length
      0.56 ± 10%      -0.3        0.28 ± 11%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.77 ±  8%      -0.3        0.49 ±  6%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.65 ± 14%      -0.3        0.39 ±  9%  perf-profile.children.cycles-pp.stress_udp_client
      0.67 ±  3%      -0.3        0.40 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.49 ± 11%      -0.2        0.25 ± 18%  perf-profile.children.cycles-pp.udp4_lib_lookup2
      0.63 ±  9%      -0.2        0.39 ±  6%  perf-profile.children.cycles-pp.copyin
      0.86 ±  9%      -0.2        0.62 ±  9%  perf-profile.children.cycles-pp.move_addr_to_user
      0.54 ±  5%      -0.2        0.30 ±  7%  perf-profile.children.cycles-pp.rt_set_nexthop
      0.51 ±  9%      -0.2        0.28 ±  7%  perf-profile.children.cycles-pp.ip_rcv
      0.53 ±  8%      -0.2        0.30 ± 23%  perf-profile.children.cycles-pp.aa_sk_perm
      0.52 ± 18%      -0.2        0.30 ± 14%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.40 ±  7%      -0.2        0.18 ± 10%  perf-profile.children.cycles-pp.ipv4_dst_destroy
      0.51 ± 12%      -0.2        0.30 ±  8%  perf-profile.children.cycles-pp.move_addr_to_kernel
      0.44 ± 13%      -0.2        0.23 ± 14%  perf-profile.children.cycles-pp.dst_release
      0.42 ±  9%      -0.2        0.22 ± 12%  perf-profile.children.cycles-pp.___slab_alloc
      0.45 ± 20%      -0.2        0.26 ± 16%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.46 ± 10%      -0.2        0.26 ± 13%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.33 ±  6%      -0.2        0.15 ± 28%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.55 ±  8%      -0.2        0.37 ± 10%  perf-profile.children.cycles-pp.__call_rcu_common
      0.38 ±  8%      -0.2        0.20 ± 10%  perf-profile.children.cycles-pp.sock_wfree
      0.48 ± 12%      -0.2        0.31 ± 13%  perf-profile.children.cycles-pp.__fget_light
      0.40 ± 12%      -0.2        0.23 ± 11%  perf-profile.children.cycles-pp._copy_from_user
      0.35 ± 13%      -0.2        0.19 ±  9%  perf-profile.children.cycles-pp.kmem_cache_free
      0.43 ±  7%      -0.2        0.27 ± 10%  perf-profile.children.cycles-pp.__check_heap_object
      0.36 ± 16%      -0.2        0.20 ± 22%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.26 ± 20%      -0.2        0.12 ± 54%  perf-profile.children.cycles-pp.compute_score
      0.36 ± 17%      -0.1        0.22 ± 13%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.32 ± 17%      -0.1        0.18 ± 14%  perf-profile.children.cycles-pp.ip_output
      0.40 ± 10%      -0.1        0.27 ±  9%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.38 ± 14%      -0.1        0.26 ± 13%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.26 ± 11%      -0.1        0.14 ± 12%  perf-profile.children.cycles-pp.__ip_local_out
      0.16 ±  9%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.allocate_slab
      0.28 ± 18%      -0.1        0.17 ± 14%  perf-profile.children.cycles-pp.netif_skb_features
      0.23 ± 18%      -0.1        0.12 ± 23%  perf-profile.children.cycles-pp.rcuref_put_slowpath
      0.29 ±  9%      -0.1        0.18 ± 17%  perf-profile.children.cycles-pp.siphash_3u32
      0.24 ± 10%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.ip_rcv_core
      0.32 ± 12%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.21 ± 17%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__put_user_4
      0.18 ± 25%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.22 ± 10%      -0.1        0.13 ± 18%  perf-profile.children.cycles-pp.__cond_resched
      0.28 ±  9%      -0.1        0.19 ± 12%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.19 ± 18%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.18 ± 11%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.23 ± 13%      -0.1        0.16 ± 14%  perf-profile.children.cycles-pp._copy_to_user
      0.18 ± 12%      -0.1        0.10 ± 16%  perf-profile.children.cycles-pp.ip_send_check
      0.20 ±  8%      -0.1        0.13 ± 24%  perf-profile.children.cycles-pp.__get_user_4
      0.10 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.21 ± 15%      -0.1        0.14 ± 19%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.18 ± 15%      -0.1        0.11 ± 26%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.13 ± 20%      -0.1        0.06 ± 46%  perf-profile.children.cycles-pp.xfrm_lookup_route
      0.11 ± 32%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.15 ± 13%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.ipv4_mtu
      0.14 ± 15%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.ip_setup_cork
      0.14 ± 27%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.08 ± 33%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.udp4_hwcsum
      0.08 ± 23%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__build_skb_around
      0.20 ±  8%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.10 ± 26%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.14 ± 15%      -0.1        0.08 ± 25%  perf-profile.children.cycles-pp.rcu_all_qs
      0.12 ± 18%      -0.1        0.07 ± 22%  perf-profile.children.cycles-pp.import_single_range
      0.16 ± 16%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.udp4_csum_init
      0.08 ± 12%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.nf_hook_slow
      0.14 ±  9%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.__ip_finish_output
      0.14 ± 18%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09 ± 17%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.kmalloc_slab
      0.17 ± 17%      +0.0        0.22 ±  6%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.1        0.05 ± 13%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.48 ±  4%      +0.1        0.54 ±  6%  perf-profile.children.cycles-pp.ktime_get
      0.06 ± 51%      +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.18 ± 11%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.perf_exclude_event
      0.02 ±141%      +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.rb_next
      0.09 ± 17%      +0.1        0.16 ± 25%  perf-profile.children.cycles-pp.__list_add_valid
      0.06 ± 48%      +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.update_blocked_averages
      0.07 ± 19%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.rb_insert_color
      0.04 ± 73%      +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.check_spread
      0.00            +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.clear_buddies
      0.13 ± 17%      +0.1        0.22 ± 12%  perf-profile.children.cycles-pp.place_entity
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.intel_idle_irq
      0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp._find_next_and_bit
      0.02 ±141%      +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.rb_erase
      0.24 ± 15%      +0.1        0.36 ± 11%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.22 ± 12%      +0.1        0.34 ± 12%  perf-profile.children.cycles-pp.update_cfs_group
      0.05 ± 47%      +0.1        0.17 ± 22%  perf-profile.children.cycles-pp.update_min_vruntime
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.backlog_napi_should_run
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.idle_cpu
      0.34 ±  9%      +0.1        0.48 ±  6%  perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.resched_curr
      0.12 ±  6%      +0.1        0.26 ± 12%  perf-profile.children.cycles-pp.__calc_delta
      0.17 ± 14%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      0.61 ± 10%      +0.2        0.76 ±  6%  perf-profile.children.cycles-pp.select_task_rq
      0.06 ± 46%      +0.2        0.21 ±  9%  perf-profile.children.cycles-pp.pick_next_entity
      0.09 ± 22%      +0.2        0.26 ±  8%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.10 ± 15%      +0.2        0.28 ± 11%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.00            +0.2        0.18 ± 12%  perf-profile.children.cycles-pp.cpu_util
      0.17 ±  6%      +0.2        0.35 ±  8%  perf-profile.children.cycles-pp.update_rq_clock_task
      1.31 ±  6%      +0.2        1.50 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.2        0.21 ± 22%  perf-profile.children.cycles-pp.cpuacct_charge
      0.21 ± 14%      +0.3        0.46 ±  8%  perf-profile.children.cycles-pp.available_idle_cpu
      0.16 ± 19%      +0.3        0.50 ±  8%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.4        0.35 ± 10%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.35 ±  8%      +0.4        0.72 ± 16%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.06 ± 55%      +0.4        0.43 ± 15%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.19 ± 15%      +0.4        0.57 ±  6%  perf-profile.children.cycles-pp.os_xsave
      1.53 ±  4%      +0.4        1.92        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.62 ± 17%      +0.4        1.05 ± 15%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.20 ± 21%      +0.4        0.64 ± 13%  perf-profile.children.cycles-pp.finish_task_switch
      0.06 ± 47%      +0.4        0.51 ± 13%  perf-profile.children.cycles-pp.check_preempt_curr
      0.00            +0.5        0.47 ± 10%  perf-profile.children.cycles-pp.wake_affine
      0.72 ± 18%      +0.5        1.21 ± 15%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.42 ± 10%      +0.5        0.93 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.30 ± 11%      +0.5        0.85 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
      0.40 ± 11%      +0.6        1.01 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.36 ± 14%      +0.6        0.97 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.97 ± 18%      +0.6        1.62 ± 14%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.58 ±  6%      +0.7        2.25 ±  5%  perf-profile.children.cycles-pp.schedule_idle
      0.42 ±  5%      +0.7        1.16 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.39 ±  8%      +0.8        1.22 ±  7%  perf-profile.children.cycles-pp.update_curr
      0.09 ± 19%      +0.9        0.99 ±  6%  perf-profile.children.cycles-pp.put_prev_entity
      0.62 ± 15%      +0.9        1.56 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.08 ± 80%      +0.9        1.02 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      1.06 ±  6%      +1.0        2.04 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      2.31 ±  9%      +1.0        3.31 ±  5%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.12 ± 44%      +1.0        1.12 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.29 ± 16%      +1.0        1.30 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.13 ± 41%      +1.0        1.14 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      2.70 ± 11%      +1.0        3.71 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.57 ±  9%      +1.0        1.62 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.66 ± 11%      +1.1        1.74 ±  2%  perf-profile.children.cycles-pp.clock_nanosleep
      0.48 ± 12%      +1.1        1.59 ±  2%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.50 ± 12%      +1.1        1.60 ±  2%  perf-profile.children.cycles-pp.common_nsleep
      1.14 ±  9%      +1.1        2.25 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.52 ± 11%      +1.1        1.62 ±  2%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.46 ± 13%      +1.1        1.57 ±  3%  perf-profile.children.cycles-pp.do_nanosleep
      0.17 ± 35%      +1.1        1.31 ±  7%  perf-profile.children.cycles-pp.load_balance
      1.29 ±  9%      +1.3        2.59 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.10 ± 23%      +1.3        1.43 ±  4%  perf-profile.children.cycles-pp.newidle_balance
      3.08 ±  8%      +1.3        4.40 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.35 ±  7%      +1.5        2.82        perf-profile.children.cycles-pp.enqueue_task_fair
      1.20 ±  8%      +1.5        2.68 ±  3%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.09 ±  8%      +1.5        2.61 ±  3%  perf-profile.children.cycles-pp.loopback_xmit
      1.38 ±  7%      +1.5        2.92        perf-profile.children.cycles-pp.activate_task
      2.92 ±  7%      +1.6        4.54 ±  5%  perf-profile.children.cycles-pp.schedule_timeout
      1.02 ± 10%      +1.8        2.81        perf-profile.children.cycles-pp.update_load_avg
      0.38 ±  9%      +1.8        2.20 ±  4%  perf-profile.children.cycles-pp.__netif_rx
      0.37 ± 11%      +1.8        2.19 ±  3%  perf-profile.children.cycles-pp.netif_rx_internal
      0.34 ±  9%      +1.8        2.17 ±  3%  perf-profile.children.cycles-pp.enqueue_to_backlog
      4.30 ±  7%      +1.9        6.16 ±  4%  perf-profile.children.cycles-pp.__skb_wait_for_more_packets
      1.49 ±  8%      +2.0        3.53 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
     32.57 ±  2%      +2.3       34.84 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     32.55 ±  2%      +2.3       34.82 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     34.42 ±  2%      +2.5       36.94 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      3.54 ± 10%      +2.6        6.09 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      3.59 ±  8%      +2.6        6.24 ±  6%  perf-profile.children.cycles-pp.poll_idle
      0.00            +2.7        2.73 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.67 ±  7%      +2.9        3.58        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.32 ±  9%      +3.0        3.32 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.63 ±  7%      +3.7        4.37        perf-profile.children.cycles-pp.pick_next_task_fair
     39.95 ±  2%      +4.9       44.84        perf-profile.children.cycles-pp.do_idle
     40.00 ±  2%      +4.9       44.94        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     40.00 ±  2%      +4.9       44.94        perf-profile.children.cycles-pp.cpu_startup_entry
     36.06 ±  5%      +5.3       41.36 ±  5%  perf-profile.children.cycles-pp.start_secondary
      2.72 ±  8%      +8.3       10.98        perf-profile.children.cycles-pp.schedule
      4.13 ±  7%      +8.6       12.74        perf-profile.children.cycles-pp.__schedule
      0.00            +9.8        9.85 ±  4%  perf-profile.children.cycles-pp.napi_threaded_poll_loop
      0.13 ± 23%     +14.0       14.16 ±  3%  perf-profile.children.cycles-pp.kthread
      0.13 ± 21%     +14.0       14.16 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      0.13 ± 21%     +14.0       14.16 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.07 ± 52%     +14.0       14.10 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
      2.94 ±  6%      -1.0        1.98 ±  5%  perf-profile.self.cycles-pp.rep_movs_alternative
      1.48 ± 12%      -0.9        0.61 ± 10%  perf-profile.self.cycles-pp.udp_rmem_release
      2.10 ±  7%      -0.8        1.27 ±  9%  perf-profile.self.cycles-pp.__slab_free
      1.22 ±  7%      -0.6        0.57 ±  5%  perf-profile.self.cycles-pp.__udp_enqueue_schedule_skb
      1.30 ± 10%      -0.6        0.72 ± 11%  perf-profile.self.cycles-pp.sock_def_readable
      1.17 ±  8%      -0.6        0.58 ±  6%  perf-profile.self.cycles-pp.udp_sendmsg
      1.46 ±  9%      -0.5        0.92 ±  2%  perf-profile.self.cycles-pp.__ip_select_ident
      1.06 ±  7%      -0.5        0.57 ±  5%  perf-profile.self.cycles-pp.check_heap_object
      1.21 ± 11%      -0.4        0.81 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      1.00 ± 12%      -0.4        0.61 ±  6%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.41 ± 19%      -0.3        0.09 ± 30%  perf-profile.self.cycles-pp.first_packet_length
      0.34 ± 20%      -0.3        0.05 ± 49%  perf-profile.self.cycles-pp.__first_packet_length
      0.73 ±  7%      -0.3        0.46 ±  2%  perf-profile.self.cycles-pp.__sys_sendto
      0.70 ± 20%      -0.3        0.42 ± 20%  perf-profile.self.cycles-pp.udp_recvmsg
      0.74 ±  9%      -0.3        0.48 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.61 ± 17%      -0.2        0.37 ±  7%  perf-profile.self.cycles-pp.stress_udp_client
      0.40 ±  8%      -0.2        0.16 ± 18%  perf-profile.self.cycles-pp.ip_finish_output2
      0.35 ±  9%      -0.2        0.13 ± 14%  perf-profile.self.cycles-pp.udp_send_skb
      0.46 ±  9%      -0.2        0.25 ± 25%  perf-profile.self.cycles-pp.aa_sk_perm
      0.70 ±  3%      -0.2        0.49 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.51 ±  6%      -0.2        0.30 ±  8%  perf-profile.self.cycles-pp.__ip_append_data
      0.32 ±  5%      -0.2        0.12 ± 19%  perf-profile.self.cycles-pp.sock_sendmsg
      0.72 ± 15%      -0.2        0.54 ± 14%  perf-profile.self.cycles-pp.__entry_text_start
      0.51 ± 13%      -0.2        0.33 ± 12%  perf-profile.self.cycles-pp.__ip_make_skb
      0.33 ±  6%      -0.2        0.16 ±  9%  perf-profile.self.cycles-pp.process_backlog
      0.37 ±  8%      -0.2        0.20 ± 10%  perf-profile.self.cycles-pp.sock_wfree
      0.47 ± 12%      -0.2        0.31 ± 13%  perf-profile.self.cycles-pp.__fget_light
      0.34 ± 12%      -0.2        0.18 ± 10%  perf-profile.self.cycles-pp.kmem_cache_free
      0.43 ±  7%      -0.2        0.27 ± 10%  perf-profile.self.cycles-pp.__check_heap_object
      0.36 ± 12%      -0.2        0.20 ± 12%  perf-profile.self.cycles-pp._copy_from_user
      0.35 ± 16%      -0.2        0.20 ± 22%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.26 ± 20%      -0.2        0.12 ± 54%  perf-profile.self.cycles-pp.compute_score
      0.39 ±  8%      -0.1        0.25 ± 10%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.31 ± 15%      -0.1        0.16 ± 13%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.31 ± 24%      -0.1        0.17 ± 26%  perf-profile.self.cycles-pp.udp_queue_rcv_one_skb
      0.30 ± 12%      -0.1        0.16 ± 11%  perf-profile.self.cycles-pp.__mkroute_output
      0.34 ± 15%      -0.1        0.20 ±  7%  perf-profile.self.cycles-pp.__alloc_skb
      0.34 ±  5%      -0.1        0.21 ± 13%  perf-profile.self.cycles-pp.__call_rcu_common
      0.22 ± 13%      -0.1        0.09 ± 27%  perf-profile.self.cycles-pp.dst_destroy
      0.30 ± 10%      -0.1        0.18 ± 26%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.22 ± 14%      -0.1        0.10 ± 24%  perf-profile.self.cycles-pp.__udp4_lib_lookup
      0.38 ± 11%      -0.1        0.26 ± 10%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.27 ± 20%      -0.1        0.16 ± 21%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.32 ± 13%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.24 ± 11%      -0.1        0.13 ± 13%  perf-profile.self.cycles-pp.ip_rcv_core
      0.22 ± 20%      -0.1        0.12 ± 21%  perf-profile.self.cycles-pp.rcuref_put_slowpath
      0.65 ±  7%      -0.1        0.55 ±  8%  perf-profile.self.cycles-pp.__skb_recv_udp
      0.29 ± 12%      -0.1        0.20 ± 16%  perf-profile.self.cycles-pp.sendto
      0.23 ± 13%      -0.1        0.13 ± 14%  perf-profile.self.cycles-pp.copyout
      0.27 ±  8%      -0.1        0.18 ± 15%  perf-profile.self.cycles-pp.siphash_3u32
      0.23 ± 14%      -0.1        0.14 ± 13%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.22 ± 15%      -0.1        0.13 ± 25%  perf-profile.self.cycles-pp.__check_object_size
      0.23 ± 23%      -0.1        0.14 ± 15%  perf-profile.self.cycles-pp.ip_output
      0.26 ± 14%      -0.1        0.17 ± 14%  perf-profile.self.cycles-pp.copyin
      0.21 ± 18%      -0.1        0.12 ± 10%  perf-profile.self.cycles-pp.__put_user_4
      0.27 ± 10%      -0.1        0.19 ± 14%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.19 ± 18%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.12 ± 33%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.18 ± 11%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.28 ± 12%      -0.1        0.20 ± 20%  perf-profile.self.cycles-pp.inet_ioctl
      0.16 ± 18%      -0.1        0.09 ± 17%  perf-profile.self.cycles-pp.__udp4_lib_rcv
      0.11 ± 10%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.rt_set_nexthop
      0.19 ± 13%      -0.1        0.11 ± 20%  perf-profile.self.cycles-pp.dst_release
      0.16 ± 12%      -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.netif_skb_features
      0.23 ± 12%      -0.1        0.16 ± 13%  perf-profile.self.cycles-pp.___slab_alloc
      0.23 ± 18%      -0.1        0.15 ±  9%  perf-profile.self.cycles-pp.skb_release_data
      0.22 ± 11%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.loopback_xmit
      0.20 ±  8%      -0.1        0.13 ± 25%  perf-profile.self.cycles-pp.__get_user_4
      0.20 ± 19%      -0.1        0.13 ± 13%  perf-profile.self.cycles-pp.ip_route_output_flow
      0.19 ± 15%      -0.1        0.12 ± 11%  perf-profile.self.cycles-pp.udp4_lib_lookup2
      0.17 ± 17%      -0.1        0.10 ± 24%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.10 ±  9%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.20 ± 16%      -0.1        0.13 ± 17%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.21 ± 12%      -0.1        0.14 ± 18%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.17 ±  8%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp.ip_send_check
      0.16 ± 10%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.15 ± 19%      -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.ip_make_skb
      0.14 ± 11%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.ipv4_mtu
      0.10 ± 12%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.19 ± 10%      -0.1        0.13 ± 21%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.12 ± 24%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.09 ± 36%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.12 ± 19%      -0.1        0.06 ± 49%  perf-profile.self.cycles-pp.rcu_all_qs
      0.09 ± 24%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.ip_setup_cork
      0.08 ± 17%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__build_skb_around
      0.10 ± 26%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.xfrm_lookup_with_ifid
      0.16 ± 16%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.udp4_csum_init
      0.12 ± 18%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.12 ± 16%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.sock_do_ioctl
      0.13 ±  9%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.10 ± 19%      -0.0        0.06 ± 19%  perf-profile.self.cycles-pp.import_single_range
      0.08 ±  8%      -0.0        0.04 ± 73%  perf-profile.self.cycles-pp.ip_generic_getfrag
      0.11 ± 18%      -0.0        0.07 ± 21%  perf-profile.self.cycles-pp.__x64_sys_ioctl
      0.12 ± 14%      -0.0        0.09 ± 18%  perf-profile.self.cycles-pp.skb_consume_udp
      0.06 ± 51%      +0.0        0.11 ± 18%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.tick_nohz_idle_enter
      0.18 ± 13%      +0.1        0.24 ±  7%  perf-profile.self.cycles-pp.reweight_entity
      0.08 ± 26%      +0.1        0.14 ± 16%  perf-profile.self.cycles-pp.newidle_balance
      0.02 ±141%      +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.rb_next
      0.08 ± 24%      +0.1        0.15 ± 24%  perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.13 ± 18%      +0.1        0.20 ± 13%  perf-profile.self.cycles-pp.place_entity
      0.03 ±102%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.check_spread
      0.06 ± 48%      +0.1        0.14 ± 17%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.intel_idle_irq
      0.06 ± 50%      +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.select_task_rq
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.activate_task
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp._find_next_and_bit
      0.02 ±142%      +0.1        0.11 ± 17%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.02 ±141%      +0.1        0.11 ± 17%  perf-profile.self.cycles-pp.check_preempt_curr
      0.36 ±  3%      +0.1        0.46 ± 12%  perf-profile.self.cycles-pp.do_idle
      0.21 ± 10%      +0.1        0.32 ± 12%  perf-profile.self.cycles-pp.update_cfs_group
      0.17 ± 10%      +0.1        0.28 ±  6%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.05 ± 47%      +0.1        0.15 ± 25%  perf-profile.self.cycles-pp.update_min_vruntime
      0.00            +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.rb_erase
      0.23 ± 13%      +0.1        0.34 ±  7%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.11 ± 24%  perf-profile.self.cycles-pp.backlog_napi_should_run
      0.00            +0.1        0.12 ± 21%  perf-profile.self.cycles-pp.idle_cpu
      0.34 ±  9%      +0.1        0.48 ±  6%  perf-profile.self.cycles-pp.llist_reverse_order
      0.12 ±  6%      +0.1        0.26 ± 12%  perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.1        0.14 ± 18%  perf-profile.self.cycles-pp.resched_curr
      0.05 ± 45%      +0.1        0.19 ±  9%  perf-profile.self.cycles-pp.pick_next_entity
      0.03 ±101%      +0.1        0.18 ± 12%  perf-profile.self.cycles-pp.put_prev_entity
      0.00            +0.2        0.15 ±  7%  perf-profile.self.cycles-pp.napi_threaded_poll_loop
      0.61 ±  9%      +0.2        0.78 ±  4%  perf-profile.self.cycles-pp.__skb_wait_for_more_packets
      0.00            +0.2        0.16 ± 14%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.20 ± 12%      +0.2        0.37 ± 17%  perf-profile.self.cycles-pp.update_rq_clock
      0.09 ± 15%      +0.2        0.26 ±  9%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.68 ±  9%      +0.2        0.86 ± 14%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.2        0.18 ± 12%  perf-profile.self.cycles-pp.cpu_util
      0.09 ± 22%      +0.2        0.26 ±  8%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.12 ± 23%      +0.2        0.30 ±  6%  perf-profile.self.cycles-pp.switch_fpu_return
      0.10 ± 15%      +0.2        0.28 ± 11%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.15 ±  7%      +0.2        0.33 ± 10%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.12 ± 14%      +0.2        0.30 ±  8%  perf-profile.self.cycles-pp.prepare_task_switch
      0.43 ±  8%      +0.2        0.62 ±  8%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.2        0.19 ± 13%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.37 ± 21%      +0.2        0.57 ±  6%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.07 ± 17%      +0.2        0.28 ± 17%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.2        0.21 ± 22%  perf-profile.self.cycles-pp.cpuacct_charge
      0.16 ± 18%      +0.2        0.39 ± 13%  perf-profile.self.cycles-pp.dequeue_entity
      0.54 ± 10%      +0.2        0.78 ±  5%  perf-profile.self.cycles-pp.schedule_timeout
      0.30 ±  7%      +0.2        0.54 ± 13%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.21 ± 14%      +0.3        0.46 ±  8%  perf-profile.self.cycles-pp.available_idle_cpu
      0.11 ± 25%      +0.3        0.38 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.09 ± 14%      +0.3        0.38 ±  7%  perf-profile.self.cycles-pp.schedule
      0.22 ± 18%      +0.3        0.52 ±  9%  perf-profile.self.cycles-pp.enqueue_entity
      0.14 ± 15%      +0.3        0.45 ±  9%  perf-profile.self.cycles-pp.finish_task_switch
      0.16 ± 19%      +0.3        0.50 ±  8%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.16 ± 17%      +0.4        0.52 ± 12%  perf-profile.self.cycles-pp.update_curr
      0.18 ± 16%      +0.4        0.56 ±  6%  perf-profile.self.cycles-pp.os_xsave
      0.00            +0.4        0.39 ±  7%  perf-profile.self.cycles-pp.smpboot_thread_fn
      1.35 ±  6%      +0.4        1.76 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.29 ± 15%      +0.5        0.74 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.27 ± 13%      +0.5        0.76 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
      0.27 ±  8%      +0.6        0.83 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.40 ± 11%      +0.6        1.00 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.36 ± 13%      +0.6        0.96 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.04 ±104%      +0.7        0.70 ±  6%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.60 ± 15%      +0.9        1.53 ±  7%  perf-profile.self.cycles-pp.__switch_to
      0.49 ± 12%      +1.0        1.49 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.56 ± 10%      +1.0        1.61 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      2.80 ± 11%      +2.3        5.11 ±  6%  perf-profile.self.cycles-pp.poll_idle



***************************************************************************************************
lkp-hsw-d04: 8 threads 1 sockets Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz (Haswell) with 8G memory
=========================================================================================
cluster/compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/testcase:
  cs-localhost/gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/600s/lkp-hsw-d04/qperf

commit: 
  83b5f0253b ("net: phy: Introduce PSGMII PHY interface mode")
  e9dc861c8b ("net: Use SMP threads for backlog NAPI.")

83b5f0253b1ef352 e9dc861c8b3c291826d6cc1a867 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     38.66 ±  5%      -5.6%      36.47        boot-time.boot
      3575           +14.2%       4083        uptime.idle
    592566           +20.9%     716486        meminfo.Active
    592534           +20.9%     716422        meminfo.Active(anon)
    962633           +13.1%    1088738        meminfo.Committed_AS
    599330           +20.9%     724793        meminfo.Shmem
     70.30           +10.8       81.10        mpstat.cpu.all.idle%
      9.87 ±  3%      -9.9        0.02        mpstat.cpu.all.iowait%
      1.41            +0.2        1.60        mpstat.cpu.all.irq%
      3.21            -3.1        0.06        mpstat.cpu.all.soft%
     13.42            +1.9       15.34        mpstat.cpu.all.sys%
     69.67           +16.3%      81.00        vmstat.cpu.id
      9.33 ±  5%    -100.0%       0.00        vmstat.cpu.wa
      1.00          -100.0%       0.00        vmstat.procs.b
    346923          +101.0%     697484        vmstat.system.cs
     22035 ±  2%      +4.0%      22906 ±  2%  vmstat.system.in
      5757 ±  2%     +11.4%       6412        qperf.sctp.latency
 8.812e+09           -10.7%  7.867e+09        qperf.tcp.bw
      3817           +17.3%       4478        qperf.tcp.latency
      9251        +7.3e+05%   67524707        qperf.time.involuntary_context_switches
     57.00           -16.4%      47.67        qperf.time.percent_of_cpu_this_job_got
    311.63           -18.7%     253.38        qperf.time.system_time
  38933889           -11.7%   34386047        qperf.time.voluntary_context_switches
      2944           +11.7%       3289        qperf.udp.latency
 1.031e+10           -24.2%  7.813e+09        qperf.udp.recv_bw
 1.031e+10           -24.2%  7.813e+09        qperf.udp.send_bw
    148133           +20.9%     179105        proc-vmstat.nr_active_anon
    104164            -2.9%     101127        proc-vmstat.nr_dirty_background_threshold
    208585            -2.9%     202504        proc-vmstat.nr_dirty_threshold
    818642            +3.9%     850179        proc-vmstat.nr_file_pages
   1076298            -2.8%    1045877        proc-vmstat.nr_free_pages
      4474            -3.3%       4325        proc-vmstat.nr_kernel_stack
    149842           +20.9%     181203        proc-vmstat.nr_shmem
      9672            -3.3%       9354        proc-vmstat.nr_slab_unreclaimable
    148133           +20.9%     179105        proc-vmstat.nr_zone_active_anon
  74838089           -12.9%   65171973        proc-vmstat.numa_hit
  74917869           -13.1%   65109537        proc-vmstat.numa_local
    197378           +21.0%     238779        proc-vmstat.pgactivate
 7.196e+08            -9.9%  6.481e+08        proc-vmstat.pgalloc_normal
    688531            +2.2%     703483        proc-vmstat.pgfault
 7.194e+08            -9.9%  6.479e+08        proc-vmstat.pgfree
     35496            +2.6%      36415 ±  2%  proc-vmstat.pgreuse
  11521778 ±  3%     +81.6%   20920988        turbostat.C1
      1.10 ±  7%      +1.4        2.45        turbostat.C1%
    845181 ±  3%     +13.4%     958085        turbostat.C1E
      1.10 ±  3%      +0.1        1.23        turbostat.C1E%
    550023 ±  2%     -64.9%     193246 ±  5%  turbostat.C3
      9.50 ±  3%      -8.7        0.80 ±  4%  turbostat.C3%
     34350 ±  3%    +152.0%      86567 ±  2%  turbostat.C6
      0.33 ±  4%      +0.4        0.77 ±  2%  turbostat.C6%
   3142398           +14.0%    3583310        turbostat.C7s
     63.05            +7.9       70.99        turbostat.C7s%
     11.56 ±  4%     -93.0%       0.81 ±  7%  turbostat.CPU%c3
      0.28 ±  7%     +17.9%       0.33 ±  2%  turbostat.CPU%c6
     36.51           +26.8%      46.27        turbostat.CPU%c7
     21.04            -1.7%      20.69        turbostat.CorWatt
      0.19           +10.5%       0.21        turbostat.IPC
  79969004 ±  2%     -11.9%   70429254 ±  2%  turbostat.POLL
      3.15            -0.4        2.75        turbostat.POLL%
      1015 ± 88%    +526.8%       6363 ±  7%  sched_debug.cfs_rq:/.MIN_vruntime.avg
      8122 ± 88%    +526.8%      50910 ±  7%  sched_debug.cfs_rq:/.MIN_vruntime.max
      2686 ± 88%    +526.8%      16837 ±  7%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      1.30 ±  6%     +30.2%       1.70 ±  6%  sched_debug.cfs_rq:/.h_nr_running.max
      0.54 ±  6%     +20.6%       0.65 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
    141566 ± 11%     +47.6%     208983 ±  4%  sched_debug.cfs_rq:/.load.avg
    419639 ±  5%     +86.8%     783786 ±  2%  sched_debug.cfs_rq:/.load.max
    172078           +63.6%     281551 ±  3%  sched_debug.cfs_rq:/.load.stddev
    157.27 ±  5%     +31.4%     206.72 ±  6%  sched_debug.cfs_rq:/.load_avg.avg
    568.97 ±  4%     +14.3%     650.15 ±  4%  sched_debug.cfs_rq:/.load_avg.max
     10.27 ±  3%     +54.3%      15.85 ± 18%  sched_debug.cfs_rq:/.load_avg.min
    201.87 ±  3%     +10.4%     222.90 ±  5%  sched_debug.cfs_rq:/.load_avg.stddev
      1015 ± 88%    +526.8%       6363 ±  7%  sched_debug.cfs_rq:/.max_vruntime.avg
      8122 ± 88%    +526.8%      50910 ±  7%  sched_debug.cfs_rq:/.max_vruntime.max
      2686 ± 88%    +526.8%      16837 ±  7%  sched_debug.cfs_rq:/.max_vruntime.stddev
    118822           -11.5%     105134        sched_debug.cfs_rq:/.min_vruntime.avg
    157741 ±  2%     -20.0%     126190 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
     22839 ±  9%     -47.6%      11957 ± 19%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.44 ±  8%     +17.4%       0.51        sched_debug.cfs_rq:/.nr_running.avg
      1.00           +36.4%       1.36 ±  5%  sched_debug.cfs_rq:/.nr_running.max
      0.44 ±  4%     +20.4%       0.53 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
    376.66           +11.8%     421.23 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    907.15 ±  3%     +15.7%       1049 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
     52787 ± 35%     -45.1%      28955 ± 46%  sched_debug.cfs_rq:/.spread0.max
     22839 ±  9%     -47.6%      11957 ± 19%  sched_debug.cfs_rq:/.spread0.stddev
    840.12 ±  2%      -9.4%     761.42        sched_debug.cfs_rq:/.util_avg.max
    310.09 ±  3%     -13.4%     268.50        sched_debug.cfs_rq:/.util_avg.stddev
    648.39 ± 10%     -13.0%     564.21 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.max
    621193 ±  3%     -10.2%     557626 ±  3%  sched_debug.cpu.avg_idle.avg
      1384 ± 29%     -54.5%     629.33 ± 15%  sched_debug.cpu.clock_task.stddev
      0.00 ± 19%     +31.3%       0.00 ±  2%  sched_debug.cpu.next_balance.stddev
  12671402 ±  2%    +107.0%   26235293 ±  2%  sched_debug.cpu.nr_switches.avg
  17842961 ±  5%     +64.5%   29353353 ±  4%  sched_debug.cpu.nr_switches.max
   9669269 ±  5%    +138.8%   23086217        sched_debug.cpu.nr_switches.min
      0.31 ±  8%     -79.3%       0.06 ± 22%  sched_debug.cpu.nr_uninterruptible.avg
      1.95            -0.2        1.75        perf-stat.i.branch-miss-rate%
  19679514 ±  2%      -8.8%   17950299        perf-stat.i.branch-misses
      2.17 ± 16%      +2.0        4.20 ±  7%  perf-stat.i.cache-miss-rate%
   2501274 ± 19%    +123.6%    5593037 ±  7%  perf-stat.i.cache-misses
  83314250            -9.1%   75711656        perf-stat.i.cache-references
    348365          +101.1%     700470        perf-stat.i.context-switches
      1.64            -7.5%       1.52        perf-stat.i.cpi
 7.816e+09            -9.4%  7.084e+09        perf-stat.i.cpu-cycles
     56.47          +146.7%     139.33        perf-stat.i.cpu-migrations
     25094 ±  4%     -26.5%      18434 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.17 ±  4%      -0.0        0.14        perf-stat.i.dTLB-load-miss-rate%
   2595591 ±  5%     -21.6%    2035642        perf-stat.i.dTLB-load-misses
 1.677e+09            -2.1%  1.641e+09        perf-stat.i.dTLB-loads
      0.06            -0.0        0.05 ±  2%  perf-stat.i.dTLB-store-miss-rate%
    629940            -8.8%     574319 ±  2%  perf-stat.i.dTLB-store-misses
  1.14e+09            +1.7%   1.16e+09        perf-stat.i.dTLB-stores
     41.52            -2.6       38.90        perf-stat.i.iTLB-load-miss-rate%
   1085663           -11.4%     961971        perf-stat.i.iTLB-load-misses
   1910535 ±  3%     +16.1%    2217887        perf-stat.i.iTLB-loads
      5366 ±  2%      +5.4%       5655        perf-stat.i.instructions-per-iTLB-miss
      0.66           +10.2%       0.73        perf-stat.i.ipc
      0.06 ± 56%    +185.7%       0.17 ± 56%  perf-stat.i.major-faults
      0.98            -9.4%       0.89        perf-stat.i.metric.GHz
    396.87           +20.5%     478.42        perf-stat.i.metric.K/sec
      1077            +1.9%       1097        perf-stat.i.minor-faults
   2086591 ± 22%    +137.6%    4958478 ±  7%  perf-stat.i.node-loads
    105179 ± 13%    +101.1%     211467 ±  5%  perf-stat.i.node-stores
      1077            +1.9%       1097        perf-stat.i.page-faults
     15.69            -8.5%      14.37        perf-stat.overall.MPKI
      1.85            -0.2        1.66        perf-stat.overall.branch-miss-rate%
      3.01 ± 20%      +4.4        7.39 ±  7%  perf-stat.overall.cache-miss-rate%
      1.47            -8.7%       1.34        perf-stat.overall.cpi
      3283 ± 24%     -61.2%       1273 ±  8%  perf-stat.overall.cycles-between-cache-misses
      0.15 ±  4%      -0.0        0.12        perf-stat.overall.dTLB-load-miss-rate%
      0.06            -0.0        0.05        perf-stat.overall.dTLB-store-miss-rate%
     36.26 ±  2%      -6.0       30.25        perf-stat.overall.iTLB-load-miss-rate%
      4891 ±  2%     +12.0%       5479        perf-stat.overall.instructions-per-iTLB-miss
      0.68            +9.5%       0.74        perf-stat.overall.ipc
  19646658 ±  2%      -8.8%   17920681        perf-stat.ps.branch-misses
   2497231 ± 19%    +123.6%    5583672 ±  7%  perf-stat.ps.cache-misses
  83175281            -9.1%   75585970        perf-stat.ps.cache-references
    347785          +101.1%     699305        perf-stat.ps.context-switches
 7.803e+09            -9.4%  7.072e+09        perf-stat.ps.cpu-cycles
     56.37          +146.7%     139.10        perf-stat.ps.cpu-migrations
   2591259 ±  5%     -21.6%    2032256        perf-stat.ps.dTLB-load-misses
 1.674e+09            -2.1%  1.639e+09        perf-stat.ps.dTLB-loads
    628893            -8.8%     573359 ±  2%  perf-stat.ps.dTLB-store-misses
 1.138e+09            +1.7%  1.158e+09        perf-stat.ps.dTLB-stores
   1083855           -11.4%     960366        perf-stat.ps.iTLB-load-misses
   1907339 ±  3%     +16.1%    2214176        perf-stat.ps.iTLB-loads
      0.06 ± 56%    +185.8%       0.17 ± 56%  perf-stat.ps.major-faults
      1075            +1.9%       1095        perf-stat.ps.minor-faults
   2083234 ± 22%    +137.6%    4950171 ±  7%  perf-stat.ps.node-loads
    105007 ± 13%    +101.0%     211114 ±  5%  perf-stat.ps.node-stores
      1075            +1.9%       1095        perf-stat.ps.page-faults
      0.00 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_write_iter
      0.02 ± 24%     -95.7%       0.00 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.01 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id.ata_dev_reread_id
      0.01 ± 29%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_exec_internal.atapi_eh_tur
      0.00 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
      0.01 ± 14%     -70.0%       0.00 ± 98%  perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.01 ±  4%     -29.0%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ±  6%     -72.7%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.00          +133.3%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.ata_wait_register
      0.01 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_debounce
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_hardreset
      0.01 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.00 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id
      0.01 ± 21%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_dev_set_mode
      0.01 ± 15%     -25.0%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.msleep.ata_msleep.sata_link_resume
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.01 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.scsi_error_handler.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 30%     -80.9%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ±  3%     -66.4%       0.04 ±  6%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_write_iter
      0.02 ±  6%     -96.7%       0.00 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.02 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id.ata_dev_reread_id
      0.03 ± 32%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_exec_internal.atapi_eh_tur
      0.01 ± 92%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
      0.02 ±  4%     -78.7%       0.00 ±110%  perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
      0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.04 ± 23%     -41.7%       0.02 ± 36%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.03 ±  3%     +26.3%       0.03 ± 11%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 47%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.04 ±  3%   +1509.3%       0.57 ± 85%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.03 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.03 ± 32%     -53.4%       0.01 ± 17%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 12%     -37.0%       0.01 ± 25%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.04 ±  7%     -45.4%       0.02 ± 38%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.05 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.ata_wait_register
      0.03 ±  3%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_debounce
      0.01 ± 14%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_hardreset
      0.03 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.02 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id
      0.05 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_dev_set_mode
      0.02 ± 10%     -44.3%       0.01 ± 22%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
      0.01 ±  8%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.msleep.ata_msleep.sata_link_resume
      0.89 ± 10%     -99.8%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.02 ± 12%    -100.0%       0.00        perf-sched.sch_delay.max.ms.scsi_error_handler.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 13%     -49.2%       0.02 ± 24%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.35           -49.3%       0.18        perf-sched.total_wait_and_delay.average.ms
    705805           +90.1%    1341585        perf-sched.total_wait_and_delay.count.ms
      0.35           -49.6%       0.18        perf-sched.total_wait_time.average.ms
     17.56 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      5.07          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id.ata_dev_reread_id
     18.73 ± 28%     -73.5%       4.96 ± 70%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
    150.40 ±  3%     -98.7%       1.90 ± 14%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    209.60          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
     23.15 ± 10%     +30.3%      30.16 ±  4%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     41.98 ±  2%     -14.7%      35.81        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    205.40           +82.7%     375.37        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     10.37          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.ata_wait_register
     14.61 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_debounce
      1.06          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_hardreset
    228.86 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      1.06          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.msleep.ata_msleep.sata_link_resume
     24.89 ±  2%     +81.1%      45.08 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01           -42.9%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    154.39           -99.9%       0.20        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    153.91           -98.8%       1.91 ± 13%  perf-sched.wait_and_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
    259.59 ±  3%     +28.0%     332.24 ±  5%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
     14.67 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id.ata_dev_reread_id
     31.67           -93.7%       2.00        perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     22.33 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      2135 ±  9%     -31.5%       1463 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     58.67 ±  5%     -48.9%      30.00 ±  7%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    390.67           +19.7%     467.67        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     45.00           -71.1%      13.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     30.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.ata_wait_register
    293.33 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_debounce
     15.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_hardreset
     15.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
     17.67 ±  2%     -84.9%       2.67 ± 17%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
     15.00          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.msleep.ata_msleep.sata_link_resume
    189.67 ±  2%     -42.7%     108.67 ±  7%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    701375           -36.4%     446163        perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    381.67        +1.2e+05%     446519        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     31.67           -93.7%       2.00        perf-sched.wait_and_delay.count.syslog_print.do_syslog.kmsg_read.vfs_read
    172.00           -34.3%     113.00 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     17.56 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      5.09          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id.ata_dev_reread_id
     25.21 ± 28%     -70.6%       7.41 ± 81%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
    349.75           -98.9%       3.79 ± 14%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    352.11          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
     30.49 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.ata_wait_register
    208.80          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_debounce
      1.07          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_hardreset
    338.85          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      1.07          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.msleep.ata_msleep.sata_link_resume
    322.33           +52.6%     492.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.78 ± 10%     -97.5%       0.04        perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    349.73           -98.9%       3.81 ± 13%  perf-sched.wait_and_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     17.56 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.00 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_write_iter
      0.02 ± 19%     -88.5%       0.00 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      5.06          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id.ata_dev_reread_id
      0.07 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_exec_internal.atapi_eh_tur
      0.01 ± 35%     -84.6%       0.00 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
     18.73 ± 28%     -73.5%       4.96 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.00 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    150.39 ±  3%     -98.7%       1.88 ± 14%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 81%    +233.3%       0.00 ± 14%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     22.48 ±141%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ±  8%     -34.4%       0.01        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    209.59          -100.0%       0.00        perf-sched.wait_time.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
     23.15 ± 10%     +30.3%      30.16 ±  4%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     41.98 ±  2%     -14.7%      35.81        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    205.39           +82.8%     375.36        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     10.37          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.ata_wait_register
     14.60 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_debounce
      1.06          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_hardreset
    228.86 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.03 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id
      0.06 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_dev_set_mode
      0.01 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_exec_internal
      1.06          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.msleep.ata_msleep.sata_link_resume
     24.88 ±  2%     +81.1%      45.08 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.05 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.scsi_error_handler.kthread.ret_from_fork.ret_from_fork_asm
    154.38           -99.9%       0.20        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    153.90           -98.8%       1.89 ± 13%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
    259.48 ±  3%     +28.0%     332.21 ±  5%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     17.56 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.01 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_write_iter
      0.02 ±  3%     -90.9%       0.00 ±141%  perf-sched.wait_time.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      5.07          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id.ata_dev_reread_id
      0.09 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.ata_exec_internal_sg.ata_exec_internal.atapi_eh_tur
      0.03 ± 20%     -95.9%       0.00 ±141%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
     25.21 ± 28%     -70.6%       7.41 ± 81%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.00 ± 12%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    349.72           -98.9%       3.76 ± 14%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 81%    +200.0%       0.01        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    112.33 ±141%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.05 ± 15%   +5840.9%       3.15 ±133%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    352.10          -100.0%       0.00        perf-sched.wait_time.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
     30.48 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.ata_wait_register
    208.79          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_debounce
      1.07          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ata_msleep.sata_link_hardreset
    338.84          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.07 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_dev_read_id
      0.11 ± 36%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_dev_set_mode
      0.01 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.ata_exec_internal_sg.ata_exec_internal
      1.07          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.msleep.ata_msleep.sata_link_resume
    322.32           +52.6%     491.99        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.93 ±  8%     -95.2%       0.04        perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.07 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.scsi_error_handler.kthread.ret_from_fork.ret_from_fork_asm
    349.71           -98.9%       3.79 ± 13%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      8.91 ±  2%      -8.9        0.00        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      8.76 ±  2%      -8.8        0.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      8.61 ±  2%      -8.6        0.00        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      7.90 ±  2%      -7.9        0.00        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      7.52 ±  2%      -7.5        0.00        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
      7.47 ±  2%      -7.5        0.00        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
     10.66 ±  2%      -7.3        3.34 ±  4%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
      6.89            -6.9        0.00        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
      6.09            -6.1        0.00        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      9.74 ±  7%      -4.8        4.95 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      9.66 ±  8%      -4.8        4.89 ±  3%  perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      9.19 ±  8%      -4.7        4.47 ±  3%  perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.33 ±  9%      -4.7        4.64 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      9.14 ±  8%      -4.7        4.48 ±  3%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.94 ±  8%      -4.7        4.28        perf-profile.calltrace.cycles-pp.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      8.73 ±  8%      -4.5        4.18 ±  3%  perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.26 ±  8%      -4.5        3.81 ±  4%  perf-profile.calltrace.cycles-pp.udp_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
      6.18 ±  9%      -4.0        2.17 ±  9%  perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.sock_write_iter.vfs_write.ksys_write
      6.04 ±  9%      -3.9        2.09 ±  9%  perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.sock_write_iter.vfs_write
      6.04 ±  7%      -3.9        2.16 ±  2%  perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      5.62 ±  9%      -3.8        1.77 ±  9%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.sock_write_iter
      5.92 ±  7%      -3.8        2.11 ±  2%  perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
     11.16 ±  7%      -3.7        7.48 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto
      5.47 ±  6%      -3.6        1.84 ±  2%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg
     11.02 ±  7%      -3.6        7.40 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     10.70 ±  8%      -3.6        7.12 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     10.81 ±  9%      -3.6        7.23 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     12.09 ±  9%      -3.4        8.64 ±  2%  perf-profile.calltrace.cycles-pp.write
     12.36 ±  7%      -3.4        8.94 ±  2%  perf-profile.calltrace.cycles-pp.sendto
      6.72 ±  3%      -1.9        4.78 ±  4%  perf-profile.calltrace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg
      8.68 ±  6%      -1.8        6.86        perf-profile.calltrace.cycles-pp.recvfrom
      5.27 ±  5%      -1.8        3.48 ±  6%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      5.63 ±  4%      -1.8        3.85 ±  5%  perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg
      5.12 ±  4%      -1.7        3.38 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp
      9.18 ±  7%      -1.7        7.45        perf-profile.calltrace.cycles-pp.read
      7.07 ±  6%      -1.6        5.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom
      6.05            -1.5        4.54 ±  2%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      6.93 ±  6%      -1.5        5.44        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
      7.50 ±  8%      -1.4        6.05        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      7.37 ±  8%      -1.4        5.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.78 ±  2%      -1.4        4.38        perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      5.79 ±  5%      -1.4        4.40        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
      5.84 ±  6%      -1.4        4.46        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
      6.26 ±  9%      -1.4        4.91        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.06 ±  9%      -1.3        4.74 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.18 ±  2%      -1.3        3.89 ±  2%  perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      5.23 ±  6%      -1.3        3.98        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.08 ±  6%      -1.3        3.83        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      5.07 ±  6%      -1.2        3.82        perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      5.58 ±  9%      -1.2        4.36        perf-profile.calltrace.cycles-pp.sock_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.01 ±  2%      -1.2        3.80 ±  2%  perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      5.38 ±  9%      -1.2        4.18 ±  2%  perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
      5.14 ±  9%      -1.2        3.97 ±  2%  perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
      5.11 ±  9%      -1.2        3.95 ±  2%  perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.sock_read_iter.vfs_read
      4.14 ±  5%      -1.1        3.02        perf-profile.calltrace.cycles-pp.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      4.50            -1.1        3.44 ±  2%  perf-profile.calltrace.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      4.20 ± 10%      -1.1        3.13 ±  2%  perf-profile.calltrace.cycles-pp.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg.sock_read_iter
      4.06            -0.9        3.11        perf-profile.calltrace.cycles-pp.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
      3.63 ±  3%      -0.9        2.77 ± 12%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.50 ±  3%      -0.8        1.70 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      3.65            -0.8        2.86        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
      3.37 ±  4%      -0.8        2.58 ± 11%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      3.20            -0.7        2.51 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb
      2.03 ±  7%      -0.6        1.41 ±  6%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      2.09 ±  3%      -0.6        1.47 ±  8%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.95 ± 20%      -0.6        0.35 ± 70%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg
      2.40 ±  3%      -0.6        1.80 ± 10%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.78 ±  2%      -0.6        2.18 ±  3%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.__udp_enqueue_schedule_skb
      2.82 ±  3%      -0.6        2.24 ±  8%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.91 ±  7%      -0.6        1.33 ±  7%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      2.65 ±  3%      -0.6        2.09 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
      2.21 ±  3%      -0.6        1.65 ±  9%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.83 ±  7%      -0.5        1.29 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.93 ± 11%      -0.5        1.44 ±  3%  perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      2.31 ±  6%      -0.4        1.86 ± 13%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.48 ± 13%      -0.4        1.05 ±  4%  perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
      1.42 ±  4%      -0.3        1.09 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      1.67 ±  7%      -0.3        1.37 ±  2%  perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.sock_write_iter.vfs_write.ksys_write
      0.88 ±  7%      -0.2        0.64 ±  9%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
      1.38 ±  8%      -0.2        1.15        perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.sock_write_iter.vfs_write
      0.84 ±  7%      -0.2        0.63 ±  8%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.22 ±  4%      -0.2        1.05 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.88 ± 11%      -0.1        0.76 ±  3%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.sock_write_iter
      0.36 ± 70%      +0.2        0.59        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.17 ±141%      +0.4        0.56 ±  3%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +0.7        0.66 ±  6%  perf-profile.calltrace.cycles-pp.__switch_to_asm
      0.00            +0.8        0.82 ± 14%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.smpboot_thread_fn.kthread
      0.00            +0.9        0.90 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.smpboot_thread_fn.kthread
     20.95            +1.0       21.98        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.26 ±  4%      +1.1        2.36 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.17 ±  6%      +1.2        2.36 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      0.00            +1.2        1.25        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.00            +1.4        1.36        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +1.4        1.40 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      0.00            +1.4        1.44 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.enqueue_to_backlog.netif_rx_internal.__netif_rx
     54.93            +1.6       56.51        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.99 ± 29%      +1.9        2.93 ±  6%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      0.00            +2.0        1.99 ±  7%  perf-profile.calltrace.cycles-pp.try_to_wake_up.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit
      0.76 ± 36%      +2.1        2.87 ±  5%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      0.00            +2.2        2.22 ±  6%  perf-profile.calltrace.cycles-pp.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit
      0.00            +2.2        2.23        perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +2.3        2.26 ±  6%  perf-profile.calltrace.cycles-pp.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      0.00            +2.3        2.27 ±  5%  perf-profile.calltrace.cycles-pp.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.00            +2.3        2.34        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +2.5        2.50        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.35            +2.7       23.05        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +3.0        3.04 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +3.2        3.20 ±  6%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.71 ± 16%      +3.3        5.98 ± 41%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      2.92 ± 16%      +3.4        6.29 ± 41%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      3.55 ± 15%      +3.6        7.16 ± 42%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      3.56 ± 15%      +3.6        7.17 ± 42%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
     42.83            +3.8       46.63        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +4.6        4.55 ±  2%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.napi_threaded_poll_loop
      0.00            +5.1        5.14        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn
      0.00            +5.6        5.61        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn.kthread
      0.00            +5.6        5.64        perf-profile.calltrace.cycles-pp.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +5.7        5.70        perf-profile.calltrace.cycles-pp.napi_threaded_poll_loop.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.37 ± 27%      +8.2        9.58 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.37 ± 27%      +8.2        9.58 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.37 ± 27%      +8.2        9.58 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +9.6        9.56 ±  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     36.67           -10.2       26.50        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     36.16           -10.0       26.13        perf-profile.children.cycles-pp.do_syscall_64
     17.24 ±  2%      -9.1        8.10 ±  2%  perf-profile.children.cycles-pp.udp_sendmsg
      8.96 ±  2%      -8.9        0.06 ±  7%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      8.77 ±  2%      -8.8        0.00        perf-profile.children.cycles-pp.do_softirq
      8.72 ±  2%      -8.6        0.10 ±  8%  perf-profile.children.cycles-pp.__do_softirq
      7.91 ±  2%      -7.9        0.00        perf-profile.children.cycles-pp.net_rx_action
     12.23 ±  2%      -7.9        4.33 ±  5%  perf-profile.children.cycles-pp.udp_send_skb
     11.97            -7.8        4.21 ±  5%  perf-profile.children.cycles-pp.ip_send_skb
     11.09 ±  2%      -7.5        3.61 ±  5%  perf-profile.children.cycles-pp.ip_finish_output2
     10.67 ±  2%      -7.3        3.34 ±  4%  perf-profile.children.cycles-pp.__dev_queue_xmit
      9.74 ±  7%      -4.8        4.96 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sendto
      9.67 ±  7%      -4.8        4.89 ±  3%  perf-profile.children.cycles-pp.__sys_sendto
      9.19 ±  8%      -4.7        4.48 ±  3%  perf-profile.children.cycles-pp.sock_sendmsg
      9.34 ±  9%      -4.7        4.66 ±  3%  perf-profile.children.cycles-pp.ksys_write
      9.16 ±  8%      -4.7        4.50 ±  3%  perf-profile.children.cycles-pp.vfs_write
      8.73 ±  8%      -4.5        4.18 ±  3%  perf-profile.children.cycles-pp.sock_write_iter
     12.46 ±  7%      -3.4        9.03 ±  2%  perf-profile.children.cycles-pp.sendto
     12.16 ±  9%      -3.4        8.73 ±  2%  perf-profile.children.cycles-pp.write
     10.63            -2.4        8.18        perf-profile.children.cycles-pp.sock_recvmsg
     10.22            -2.4        7.81        perf-profile.children.cycles-pp.inet_recvmsg
     10.18            -2.4        7.77        perf-profile.children.cycles-pp.udp_recvmsg
      8.36 ±  2%      -2.2        6.17 ±  2%  perf-profile.children.cycles-pp.__skb_recv_udp
      6.73 ±  3%      -2.0        4.77 ±  4%  perf-profile.children.cycles-pp.__skb_wait_for_more_packets
      7.52 ±  2%      -1.9        5.64        perf-profile.children.cycles-pp.__napi_poll
      7.48 ±  2%      -1.9        5.62        perf-profile.children.cycles-pp.process_backlog
      8.76 ±  6%      -1.8        6.93        perf-profile.children.cycles-pp.recvfrom
      9.29 ±  7%      -1.8        7.52        perf-profile.children.cycles-pp.read
      6.91            -1.8        5.14        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      5.66 ±  4%      -1.8        3.91 ±  5%  perf-profile.children.cycles-pp.schedule_timeout
      6.09            -1.5        4.55 ±  2%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      6.05            -1.5        4.54 ±  2%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      5.79 ±  2%      -1.4        4.39 ±  2%  perf-profile.children.cycles-pp.__udp4_lib_rcv
      5.80 ±  5%      -1.4        4.41        perf-profile.children.cycles-pp.__sys_recvfrom
      5.85 ±  6%      -1.4        4.47        perf-profile.children.cycles-pp.__x64_sys_recvfrom
      6.26 ±  9%      -1.4        4.91        perf-profile.children.cycles-pp.ksys_read
      1.54 ± 16%      -1.3        0.22 ± 87%  perf-profile.children.cycles-pp._printk
      1.54 ± 16%      -1.3        0.22 ± 87%  perf-profile.children.cycles-pp.vprintk_emit
      1.54 ± 16%      -1.3        0.22 ± 87%  perf-profile.children.cycles-pp.console_unlock
      1.54 ± 16%      -1.3        0.22 ± 87%  perf-profile.children.cycles-pp.console_flush_all
      6.06 ±  9%      -1.3        4.74 ±  2%  perf-profile.children.cycles-pp.vfs_read
      5.19 ±  2%      -1.3        3.89 ±  2%  perf-profile.children.cycles-pp.udp_unicast_rcv_skb
      1.44 ± 16%      -1.2        0.21 ± 85%  perf-profile.children.cycles-pp.serial8250_console_write
      5.58 ±  9%      -1.2        4.36        perf-profile.children.cycles-pp.sock_read_iter
      1.41 ± 16%      -1.2        0.20 ± 86%  perf-profile.children.cycles-pp.wait_for_lsr
      5.03 ±  2%      -1.2        3.83 ±  2%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      4.51            -1.1        3.44        perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
      4.06            -0.9        3.12 ±  2%  perf-profile.children.cycles-pp.sock_def_readable
      3.66            -0.8        2.86        perf-profile.children.cycles-pp.__wake_up_common_lock
      3.62 ±  3%      -0.8        2.82        perf-profile.children.cycles-pp.ip_make_skb
      0.83 ± 17%      -0.7        0.12 ± 92%  perf-profile.children.cycles-pp.io_serial_in
      3.21            -0.7        2.51 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
      3.89 ±  5%      -0.7        3.21 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      2.87 ±  4%      -0.7        2.21 ±  2%  perf-profile.children.cycles-pp.__ip_append_data
      3.02 ±  5%      -0.6        2.38 ±  5%  perf-profile.children.cycles-pp.sched_ttwu_pending
      3.61 ±  6%      -0.6        3.00 ±  5%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      2.79 ±  2%      -0.6        2.19 ±  3%  perf-profile.children.cycles-pp.autoremove_wake_function
      2.66 ±  4%      -0.6        2.06 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      0.57 ± 17%      -0.5        0.08 ± 83%  perf-profile.children.cycles-pp.delay_tsc
      2.49 ±  5%      -0.4        2.10 ±  8%  perf-profile.children.cycles-pp.menu_select
      1.76 ±  2%      -0.4        1.41 ±  5%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.81 ±  5%      -0.2        0.57 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.01 ±  5%      -0.2        0.78 ± 11%  perf-profile.children.cycles-pp.__smp_call_single_queue
      1.10 ±  3%      -0.2        0.87 ±  9%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      1.76 ±  4%      -0.2        1.56 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.78 ± 17%      -0.2        0.59 ± 13%  perf-profile.children.cycles-pp.ip_generic_getfrag
      0.86 ±  5%      -0.2        0.67        perf-profile.children.cycles-pp.select_task_rq
      1.04 ±  5%      -0.2        0.86 ±  8%  perf-profile.children.cycles-pp.__check_object_size
      0.40 ±  5%      -0.2        0.23 ±  7%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.48 ± 20%      -0.2        0.31 ± 13%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.65 ±  7%      -0.2        0.48 ± 10%  perf-profile.children.cycles-pp.llist_add_batch
      0.56 ±  7%      -0.2        0.40 ±  5%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.63 ± 13%      -0.2        0.47 ±  9%  perf-profile.children.cycles-pp.ip_route_output_flow
      0.96            -0.2        0.81 ±  7%  perf-profile.children.cycles-pp.__alloc_skb
      0.41 ± 19%      -0.1        0.27 ± 20%  perf-profile.children.cycles-pp.fib_table_lookup
      0.33 ± 13%      -0.1        0.20 ±  6%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      1.03 ±  3%      -0.1        0.90        perf-profile.children.cycles-pp.native_sched_clock
      1.22 ±  4%      -0.1        1.09 ±  7%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.40 ±  5%      -0.1        0.28 ± 19%  perf-profile.children.cycles-pp.sock_wfree
      0.55 ±  5%      -0.1        0.43 ± 11%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.46 ±  2%      -0.1        0.35 ± 14%  perf-profile.children.cycles-pp.update_cfs_group
      0.61 ±  4%      -0.1        0.51 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.49 ±  6%      -0.1        0.40 ±  8%  perf-profile.children.cycles-pp.__ip_make_skb
      0.31 ±  5%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.61 ±  3%      -0.1        0.52        perf-profile.children.cycles-pp.skb_release_data
      0.32 ±  9%      -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.19 ± 19%      -0.1        0.10 ± 31%  perf-profile.children.cycles-pp.netif_skb_features
      0.71 ±  2%      -0.1        0.62        perf-profile.children.cycles-pp.sched_clock_cpu
      0.67 ±  4%      -0.1        0.58 ±  2%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.62 ±  3%      -0.1        0.53        perf-profile.children.cycles-pp.__consume_stateless_skb
      0.31 ±  9%      -0.1        0.23 ± 14%  perf-profile.children.cycles-pp.ip_output
      0.36 ± 15%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.28 ± 15%      -0.1        0.20 ± 24%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.35            -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.29 ± 15%      -0.1        0.22 ± 18%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.36 ±  4%      -0.1        0.29 ±  7%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.17 ± 14%      -0.1        0.10 ± 16%  perf-profile.children.cycles-pp.__ip_finish_output
      0.41            -0.1        0.34 ±  8%  perf-profile.children.cycles-pp.ip_rcv
      0.16            -0.1        0.10 ± 21%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.46 ±  7%      -0.1        0.39 ±  3%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.17 ± 19%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.62            -0.1        0.56        perf-profile.children.cycles-pp.sched_clock
      0.34 ±  5%      -0.1        0.28        perf-profile.children.cycles-pp.kmalloc_reserve
      0.17 ±  7%      -0.1        0.12 ± 21%  perf-profile.children.cycles-pp.ip_rcv_core
      0.15 ± 26%      -0.1        0.09        perf-profile.children.cycles-pp.pick_next_task_idle
      0.23 ±  7%      -0.1        0.18 ± 25%  perf-profile.children.cycles-pp.menu_reflect
      0.56 ±  6%      -0.1        0.51 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.18 ± 11%      -0.0        0.13 ± 20%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.18 ± 14%      -0.0        0.13 ± 14%  perf-profile.children.cycles-pp.nf_hook_slow
      0.12 ± 33%      -0.0        0.07        perf-profile.children.cycles-pp.__update_idle_core
      0.13 ± 15%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.move_addr_to_user
      0.18 ± 15%      -0.0        0.14 ± 11%  perf-profile.children.cycles-pp.ct_idle_exit
      0.12 ± 23%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.apparmor_ip_postroute
      0.08 ± 10%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp._copy_from_iter
      0.18 ± 12%      -0.0        0.14 ± 20%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.38 ±  5%      -0.0        0.34 ±  4%  perf-profile.children.cycles-pp.__udp4_lib_lookup
      0.14 ± 18%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.35 ±  2%      -0.0        0.31        perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.14 ±  6%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.ip_setup_cork
      0.13 ± 16%      -0.0        0.09 ± 13%  perf-profile.children.cycles-pp.udp4_csum_init
      0.09 ±  5%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.09 ±  9%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ipv4_mtu
      0.09 ±  5%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.__build_skb_around
      0.10 ±  4%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.receiver_wake_function
      0.12 ±  3%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.call_cpuidle
      0.10 ± 12%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.__mkroute_output
      0.24 ±  6%      +0.0        0.28 ±  5%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.rebalance_domains
      0.22 ±  9%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.__calc_delta
      0.18 ±  2%      +0.0        0.22 ± 11%  perf-profile.children.cycles-pp.copyout
      0.08 ± 17%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__list_add_valid
      0.14 ±  8%      +0.1        0.20 ± 12%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.07 ±  7%      +0.1        0.13 ± 21%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.find_busiest_group
      0.14 ± 12%      +0.1        0.21 ± 19%  perf-profile.children.cycles-pp.cpuacct_charge
      0.05 ± 70%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.rb_erase
      0.11            +0.1        0.20 ± 13%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.load_balance
      0.14 ± 19%      +0.1        0.23 ± 12%  perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.run_backlog_napi
      0.09 ± 14%      +0.1        0.18 ± 16%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.08 ± 14%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp.mm_cid_get
      0.13 ±  6%      +0.1        0.25 ± 18%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.16 ± 13%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.pick_next_entity
      0.24 ±  9%      +0.1        0.39 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      0.11 ± 19%      +0.2        0.26 ±  5%  perf-profile.children.cycles-pp.update_min_vruntime
      0.30 ±  8%      +0.2        0.47 ± 10%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.73            +0.2        0.96 ± 13%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.2        0.23 ± 12%  perf-profile.children.cycles-pp.backlog_napi_should_run
      0.43 ±  8%      +0.2        0.66 ±  5%  perf-profile.children.cycles-pp.update_rq_clock
      0.46 ±  3%      +0.3        0.74 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.87            +0.3        1.16 ± 10%  perf-profile.children.cycles-pp.prepare_task_switch
      0.09 ± 32%      +0.3        0.40 ±  6%  perf-profile.children.cycles-pp.wake_affine
      0.58 ±  7%      +0.3        0.92 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.56 ±  7%      +0.4        1.93 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.4        0.40 ± 15%  perf-profile.children.cycles-pp.check_preempt_wakeup
      2.00 ±  8%      +0.4        2.43        perf-profile.children.cycles-pp.enqueue_task_fair
      0.83 ±  3%      +0.4        1.25 ±  2%  perf-profile.children.cycles-pp.__switch_to
      2.07 ±  8%      +0.4        2.51        perf-profile.children.cycles-pp.activate_task
      0.06 ±  7%      +0.4        0.51 ± 12%  perf-profile.children.cycles-pp.check_preempt_curr
      0.87 ±  3%      +0.5        1.38 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.80 ±  8%      +0.5        1.31 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.21 ±  7%      +0.7        0.89 ±  3%  perf-profile.children.cycles-pp.put_prev_entity
      0.59 ±  6%      +0.7        1.31 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      2.19 ±  9%      +0.9        3.09 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.45 ±  4%      +1.0        2.41 ±  4%  perf-profile.children.cycles-pp.update_load_avg
     21.07            +1.0       22.11        perf-profile.children.cycles-pp.poll_idle
      2.67 ±  3%      +1.4        4.10 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
     54.93            +1.6       56.51        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     54.93            +1.6       56.51        perf-profile.children.cycles-pp.cpu_startup_entry
     54.80            +1.6       56.41        perf-profile.children.cycles-pp.do_idle
      1.15 ±  6%      +1.8        2.94 ±  6%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.08 ±  6%      +1.8        2.89 ±  5%  perf-profile.children.cycles-pp.loopback_xmit
      1.25 ±  6%      +1.9        3.15 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.29 ± 20%      +2.0        2.27 ±  5%  perf-profile.children.cycles-pp.__netif_rx
      0.26 ± 15%      +2.0        2.23 ±  6%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.28 ± 17%      +2.0        2.26 ±  6%  perf-profile.children.cycles-pp.netif_rx_internal
      4.48            +2.1        6.61        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +2.5        2.51        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     20.35            +2.7       23.05        perf-profile.children.cycles-pp.intel_idle
      0.20 ± 16%      +2.7        2.90        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      7.64 ±  4%      +3.0       10.64 ±  3%  perf-profile.children.cycles-pp.__schedule
     46.39            +3.2       49.59        perf-profile.children.cycles-pp.cpuidle_idle_call
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.children.cycles-pp.x86_64_start_kernel
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.children.cycles-pp.x86_64_start_reservations
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.children.cycles-pp.start_kernel
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.children.cycles-pp.arch_call_rest_init
      3.56 ± 15%      +3.6        7.18 ± 42%  perf-profile.children.cycles-pp.rest_init
      5.29 ±  5%      +3.8        9.05 ±  4%  perf-profile.children.cycles-pp.schedule
     42.90            +3.8       46.70        perf-profile.children.cycles-pp.cpuidle_enter_state
     42.93            +3.8       46.74        perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +5.7        5.70        perf-profile.children.cycles-pp.napi_threaded_poll_loop
      1.37 ± 27%      +8.2        9.58 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.37 ± 27%      +8.2        9.58 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      1.37 ± 27%      +8.2        9.58 ±  2%  perf-profile.children.cycles-pp.kthread
      0.00            +9.6        9.57 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.83 ± 17%      -0.7        0.12 ± 92%  perf-profile.self.cycles-pp.io_serial_in
      4.20            -0.5        3.66 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.57 ± 17%      -0.5        0.08 ± 83%  perf-profile.self.cycles-pp.delay_tsc
      0.56 ±  5%      -0.2        0.33 ± 11%  perf-profile.self.cycles-pp.udp_sendmsg
      1.75 ±  3%      -0.2        1.56 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.04 ±  8%      -0.2        0.87 ±  3%  perf-profile.self.cycles-pp.menu_select
      0.65 ±  6%      -0.2        0.48 ±  9%  perf-profile.self.cycles-pp.llist_add_batch
      0.26 ± 25%      -0.2        0.11 ± 19%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.53 ± 10%      -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.35 ± 20%      -0.1        0.20 ± 20%  perf-profile.self.cycles-pp.fib_table_lookup
      0.56 ±  9%      -0.1        0.42 ± 21%  perf-profile.self.cycles-pp.do_idle
      1.00 ±  4%      -0.1        0.86        perf-profile.self.cycles-pp.native_sched_clock
      0.37 ± 18%      -0.1        0.24 ± 17%  perf-profile.self.cycles-pp.ip_finish_output2
      0.23 ± 20%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.udp_send_skb
      0.39 ± 28%      -0.1        0.26 ±  6%  perf-profile.self.cycles-pp.sock_def_readable
      0.19 ±  5%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.39 ±  6%      -0.1        0.26 ± 16%  perf-profile.self.cycles-pp.__udp_enqueue_schedule_skb
      0.32 ± 13%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.44 ±  2%      -0.1        0.32 ± 15%  perf-profile.self.cycles-pp.update_cfs_group
      0.24 ±  9%      -0.1        0.12 ± 18%  perf-profile.self.cycles-pp.newidle_balance
      0.39 ±  7%      -0.1        0.28 ± 19%  perf-profile.self.cycles-pp.sock_wfree
      0.14 ± 10%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.udp_unicast_rcv_skb
      0.31 ±  7%      -0.1        0.22 ± 15%  perf-profile.self.cycles-pp.__ip_append_data
      0.25 ± 12%      -0.1        0.16 ± 13%  perf-profile.self.cycles-pp.__skb_recv_udp
      0.27 ±  4%      -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ± 14%      -0.1        0.06 ± 72%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.17 ± 16%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.__check_object_size
      0.35            -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.__check_heap_object
      0.24 ± 12%      -0.1        0.16 ± 11%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.40 ±  5%      -0.1        0.34 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.21 ±  6%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.45 ±  7%      -0.1        0.39 ±  4%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.12 ± 15%      -0.1        0.06 ± 19%  perf-profile.self.cycles-pp.skb_release_data
      0.15 ±  3%      -0.1        0.09 ± 22%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.19 ± 10%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.put_prev_task_fair
      0.17 ± 10%      -0.1        0.11 ± 22%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.16 ± 17%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.__xfrm_policy_check2
      0.32 ±  9%      -0.1        0.27 ± 12%  perf-profile.self.cycles-pp.do_syscall_64
      0.18 ± 17%      -0.1        0.13 ± 12%  perf-profile.self.cycles-pp.prepare_to_wait_exclusive
      0.18 ± 12%      -0.1        0.13 ± 25%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.17 ± 10%      -0.1        0.12 ± 21%  perf-profile.self.cycles-pp.ip_rcv_core
      0.21 ± 12%      -0.0        0.17 ±  7%  perf-profile.self.cycles-pp.vfs_read
      0.09 ±  9%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.12 ± 21%      -0.0        0.07        perf-profile.self.cycles-pp.apparmor_ip_postroute
      0.32 ±  3%      -0.0        0.28 ± 14%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.69 ±  4%      -0.0        0.65 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.08 ± 22%      -0.0        0.04 ± 70%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.20 ±  6%      -0.0        0.16 ± 15%  perf-profile.self.cycles-pp.sock_read_iter
      0.11 ±  4%      -0.0        0.07 ± 25%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.12 ± 13%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.__udp4_lib_lookup
      0.13 ± 13%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.read
      0.13 ± 16%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.udp4_csum_init
      0.09 ±  5%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.10 ±  8%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.ip_setup_cork
      0.31            -0.0        0.28        perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.08 ± 14%      -0.0        0.06 ± 16%  perf-profile.self.cycles-pp.autoremove_wake_function
      0.12 ±  3%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.call_cpuidle
      0.10 ± 17%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.sock_recvmsg
      0.08 ± 11%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.ipv4_mtu
      0.05 ±  8%      +0.0        0.07 ± 17%  perf-profile.self.cycles-pp.select_task_rq
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.put_prev_entity
      0.09 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__mkroute_output
      0.03 ± 70%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.21 ±  7%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.05 ±  8%      +0.1        0.11 ± 15%  perf-profile.self.cycles-pp.check_preempt_curr
      0.07 ± 23%      +0.1        0.13 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.06 ±  7%      +0.1        0.12 ± 18%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.napi_threaded_poll_loop
      0.14 ±  8%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.14 ± 12%      +0.1        0.21 ± 21%  perf-profile.self.cycles-pp.cpuacct_charge
      0.14 ±  6%      +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.prepare_task_switch
      0.04 ± 71%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.run_backlog_napi
      0.35 ±  7%      +0.1        0.44 ± 12%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.13 ± 18%      +0.1        0.22 ± 14%  perf-profile.self.cycles-pp.switch_fpu_return
      0.10 ±  4%      +0.1        0.20 ± 13%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.16 ±  3%      +0.1        0.26 ± 10%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.21 ±  4%      +0.1        0.31 ± 12%  perf-profile.self.cycles-pp.finish_task_switch
      0.08 ± 14%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.mm_cid_get
      0.07 ± 18%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.13 ±  6%      +0.1        0.25 ± 19%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.09 ± 28%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      0.15 ±  8%      +0.1        0.28 ±  8%  perf-profile.self.cycles-pp.pick_next_entity
      0.00            +0.2        0.16 ±  6%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.22 ±  5%      +0.2        0.38 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.30 ±  9%      +0.2        0.46 ± 10%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.14 ±  8%      +0.2        0.31 ±  6%  perf-profile.self.cycles-pp.set_next_entity
      0.15 ± 13%      +0.2        0.33 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.67 ±  3%      +0.2        0.84 ± 12%  perf-profile.self.cycles-pp.___perf_sw_event
      0.14 ± 30%      +0.2        0.33 ±  7%  perf-profile.self.cycles-pp.schedule
      0.00            +0.2        0.22 ± 15%  perf-profile.self.cycles-pp.backlog_napi_should_run
      0.00            +0.2        0.24 ± 19%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.46 ±  4%      +0.3        0.72 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.25 ± 21%      +0.3        0.52 ±  6%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.3        0.27 ± 15%  perf-profile.self.cycles-pp.smpboot_thread_fn
      0.57 ±  6%      +0.3        0.90 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.41 ±  9%      +0.3        0.74 ± 10%  perf-profile.self.cycles-pp.update_load_avg
      0.84 ± 12%      +0.4        1.24 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.82 ±  3%      +0.4        1.25 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.87 ±  4%      +0.5        1.36 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
     20.66            +1.1       21.71        perf-profile.self.cycles-pp.poll_idle
     20.35            +2.7       23.05        perf-profile.self.cycles-pp.intel_idle



***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/datasize/kconfig/nr_threads/protocol/rootfs/runtime/tbox_group/testcase/winsize:
  cs-localhost/gcc-12/performance/64/x86_64-rhel-8.3/1/UDP/debian-11.1-x86_64-20220510.cgz/30s/lkp-icl-2sp9/uperf/32k

commit: 
  83b5f0253b ("net: phy: Introduce PSGMII PHY interface mode")
  e9dc861c8b ("net: Use SMP threads for backlog NAPI.")

83b5f0253b1ef352 e9dc861c8b3c291826d6cc1a867 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   9008437           -11.7%    7958274        cpuidle..usage
    148752 ±  8%     +83.9%     273556 ± 20%  numa-numastat.node0.numa_hit
    377578           +60.9%     607490 ±  4%  vmstat.system.cs
    256190           -14.5%     219130 ±  3%  vmstat.system.in
      0.29            -0.3        0.03 ±  5%  mpstat.cpu.all.soft%
      0.95 ±  3%      +0.2        1.13 ±  6%  mpstat.cpu.all.sys%
      0.66 ±  5%      +0.1        0.79 ±  4%  mpstat.cpu.all.usr%
   8973056           -11.6%    7933641        turbostat.C1
      0.36 ±  4%     +16.6%       0.42 ±  4%  turbostat.IPC
   9276844           -11.5%    8213432        turbostat.IRQ
     14235 ±  5%     -18.1%      11654 ±  2%  turbostat.POLL
    502369           +39.1%     699008 ±  2%  meminfo.Active
    502289           +39.1%     698928 ±  2%  meminfo.Active(anon)
   1143243           +10.8%    1266813        meminfo.Committed_AS
    453349 ±  2%     -15.5%     382956        meminfo.Inactive
    453153 ±  2%     -15.5%     382760        meminfo.Inactive(anon)
    610710           +20.8%     737539 ±  2%  meminfo.Shmem
    154.79           -16.5%     129.28        uperf.Netstat_lo_in_Mbps
    154.79           -16.5%     129.28        uperf.Netstat_lo_out_Mbps
    107.68           -16.5%      89.93        uperf.Runstat_127.0.0.1_Mbps
    107.68           -16.5%      89.93        uperf.Runstat_master_Mbps
    372.17 ±  3%  +7.6e+05%    2838502        uperf.time.involuntary_context_switches
   3399305           -16.5%    2839422        uperf.time.voluntary_context_switches
      1297 ± 49%  +26455.4%     344423 ± 46%  numa-meminfo.node0.Active(anon)
     12288 ± 56%     +83.3%      22524 ± 23%  numa-meminfo.node0.AnonHugePages
      5413 ± 14%   +6557.4%     360421 ± 45%  numa-meminfo.node0.Shmem
    275637 ± 14%     -43.8%     154876 ± 19%  numa-meminfo.node1.Inactive
    275539 ± 14%     -43.9%     154681 ± 19%  numa-meminfo.node1.Inactive(anon)
      6538 ±  5%     +16.5%       7619 ±  5%  numa-meminfo.node1.KernelStack
    107211 ± 71%   +1246.5%    1443603 ± 87%  numa-meminfo.node1.Unevictable
    323.83 ± 49%  +26490.4%      86108 ± 46%  numa-vmstat.node0.nr_active_anon
      1353 ± 14%   +6559.8%      90106 ± 45%  numa-vmstat.node0.nr_shmem
    323.83 ± 49%  +26490.4%      86108 ± 46%  numa-vmstat.node0.nr_zone_active_anon
    148760 ±  8%     +83.9%     273535 ± 20%  numa-vmstat.node0.numa_hit
     68899 ± 14%     -43.9%      38681 ± 19%  numa-vmstat.node1.nr_inactive_anon
      6541 ±  5%     +16.5%       7619 ±  5%  numa-vmstat.node1.nr_kernel_stack
     26802 ± 71%   +1246.5%     360900 ± 87%  numa-vmstat.node1.nr_unevictable
     68899 ± 14%     -43.9%      38681 ± 19%  numa-vmstat.node1.nr_zone_inactive_anon
     26802 ± 71%   +1246.5%     360900 ± 87%  numa-vmstat.node1.nr_zone_unevictable
    125572           +39.2%     174744 ±  2%  proc-vmstat.nr_active_anon
    829950            +3.8%     861684        proc-vmstat.nr_file_pages
    113307 ±  2%     -15.5%      95696        proc-vmstat.nr_inactive_anon
     14124            +7.8%      15225        proc-vmstat.nr_kernel_stack
    152687           +20.8%     184396 ±  2%  proc-vmstat.nr_shmem
    125572           +39.2%     174744 ±  2%  proc-vmstat.nr_zone_active_anon
    113307 ±  2%     -15.5%      95696        proc-vmstat.nr_zone_inactive_anon
     13015 ± 54%    +142.4%      31549 ± 14%  proc-vmstat.numa_hint_faults
    540311            +7.6%     581575        proc-vmstat.numa_hit
    474106            +8.7%     515374        proc-vmstat.numa_local
    213704           -62.0%      81170 ±  7%  proc-vmstat.pgactivate
    570252            +7.0%     609921        proc-vmstat.pgalloc_normal
    293333 ±  4%     +11.2%     326321        proc-vmstat.pgfault
      0.00 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      0.00           -72.2%       0.00 ± 44%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01           -40.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg
      0.00 ± 24%     -40.7%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 74%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      0.00 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ±  5%  +11583.5%       1.54 ± 73%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.54 ± 84%     -99.3%       0.01 ± 22%  perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg
      0.00           -33.3%       0.00        perf-sched.total_sch_delay.average.ms
      0.90 ±  2%     -36.4%       0.58 ±  2%  perf-sched.total_wait_and_delay.average.ms
    790959           +82.6%    1444641        perf-sched.total_wait_and_delay.count.ms
      4022 ±  6%     -13.4%       3481 ± 12%  perf-sched.total_wait_and_delay.max.ms
      0.90 ±  2%     -36.4%       0.57 ±  2%  perf-sched.total_wait_time.average.ms
      4022 ±  6%     -13.4%       3481 ± 12%  perf-sched.total_wait_time.max.ms
    224.93 ±  2%     -49.9%     112.72 ± 14%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     60.49           +96.1%     118.62 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01           -64.8%       0.00 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg
    425.27 ±  8%     -99.8%       0.94 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    406.83           -56.0%     179.00 ±  9%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    784366           -38.8%     480361        perf-sched.wait_and_delay.count.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg
    767.33 ±  5%  +62580.4%     480967        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.56 ± 82%     -93.3%       0.10 ±127%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg
      0.01 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
    224.93 ±  2%     -49.9%     112.71 ± 14%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ±180%  +17278.2%       6.11 ± 42%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ± 24%  +54058.8%       3.07 ± 98%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     60.49           +96.1%     118.62 ±  8%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01           -47.2%       0.00 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg
    425.27 ±  8%     -99.8%       0.94 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 40%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      1497 ± 33%     -33.2%       1000        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.10 ±193%  +12202.9%      12.10 ± 31%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ± 39%  +60486.7%       4.54 ± 78%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.03 ± 41%  +26760.0%       6.94 ± 97%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.33 ±  2%     -18.9%       4.32 ±  2%  perf-stat.i.MPKI
 1.469e+09 ±  4%     +17.6%  1.727e+09        perf-stat.i.branch-instructions
      1.42            -0.2        1.21 ±  4%  perf-stat.i.branch-miss-rate%
      4.40 ±  4%      +2.8        7.16 ±  9%  perf-stat.i.cache-miss-rate%
   1666058           +57.2%    2618874 ± 10%  perf-stat.i.cache-misses
  34535681 ±  2%      -6.6%   32270735 ±  3%  perf-stat.i.cache-references
    415718 ±  2%     +61.8%     672627 ±  4%  perf-stat.i.context-switches
      1.22           -13.4%       1.06 ±  2%  perf-stat.i.cpi
    133.38 ±  2%     +25.9%     167.93 ±  2%  perf-stat.i.cpu-migrations
     18722 ±  7%     -20.6%      14861 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.02 ± 15%      -0.0        0.01 ±  8%  perf-stat.i.dTLB-load-miss-rate%
 1.839e+09 ±  2%     +21.7%  2.237e+09        perf-stat.i.dTLB-loads
 9.513e+08 ±  2%     +25.3%  1.192e+09 ±  2%  perf-stat.i.dTLB-stores
 7.334e+09 ±  3%     +16.6%  8.551e+09        perf-stat.i.instructions
      0.90           +16.3%       1.04 ±  3%  perf-stat.i.ipc
     66.54 ±  3%     +21.0%      80.55        perf-stat.i.metric.M/sec
      5641 ±  7%     +15.0%       6485 ±  3%  perf-stat.i.minor-faults
    153120 ± 10%    +245.2%     528535 ± 19%  perf-stat.i.node-load-misses
    113594 ±  9%     -38.1%      70359 ±  6%  perf-stat.i.node-loads
     44891 ± 19%    +140.5%     107942 ± 20%  perf-stat.i.node-store-misses
    255691 ± 10%     +85.2%     473432 ±  7%  perf-stat.i.node-stores
      5641 ±  7%     +15.0%       6485 ±  3%  perf-stat.i.page-faults
      4.71 ±  3%     -19.9%       3.77 ±  2%  perf-stat.overall.MPKI
      1.52            -0.3        1.25 ±  2%  perf-stat.overall.branch-miss-rate%
      4.82 ±  3%      +3.3        8.11 ±  9%  perf-stat.overall.cache-miss-rate%
      1.08           -14.2%       0.93 ±  2%  perf-stat.overall.cpi
      4777 ±  2%     -35.7%       3070 ± 10%  perf-stat.overall.cycles-between-cache-misses
      0.02 ± 11%      -0.0        0.02 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  2%      -0.0        0.00 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      0.92           +16.6%       1.08 ±  2%  perf-stat.overall.ipc
     57.35 ±  7%     +30.6       87.91 ±  2%  perf-stat.overall.node-load-miss-rate%
 1.425e+09 ±  4%     +17.7%  1.678e+09        perf-stat.ps.branch-instructions
   1615384           +57.5%    2544001 ± 10%  perf-stat.ps.cache-misses
  33513906 ±  2%      -6.5%   31341570 ±  3%  perf-stat.ps.cache-references
    403480 ±  2%     +61.9%     653109 ±  4%  perf-stat.ps.context-switches
    129.49 ±  2%     +25.9%     163.08 ±  2%  perf-stat.ps.cpu-migrations
 1.784e+09 ±  2%     +21.8%  2.173e+09        perf-stat.ps.dTLB-loads
  9.23e+08 ±  2%     +25.4%  1.157e+09 ±  2%  perf-stat.ps.dTLB-stores
 7.116e+09 ±  3%     +16.7%  8.306e+09        perf-stat.ps.instructions
      5470 ±  7%     +15.1%       6298 ±  3%  perf-stat.ps.minor-faults
    148524 ± 10%    +245.7%     513437 ± 19%  perf-stat.ps.node-load-misses
    110108 ±  9%     -37.9%      68336 ±  6%  perf-stat.ps.node-loads
     43541 ± 19%    +140.8%     104863 ± 20%  perf-stat.ps.node-store-misses
    247950 ± 10%     +85.5%     459944 ±  7%  perf-stat.ps.node-stores
      5470 ±  7%     +15.1%       6298 ±  3%  perf-stat.ps.page-faults
 2.415e+11 ±  2%     +20.1%    2.9e+11 ±  4%  perf-stat.total.instructions
     19.24 ±  2%      -8.6       10.69 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_sendto
     19.12 ±  2%      -8.5       10.60 ±  2%  perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_sendto
      8.48 ±  2%      -8.5        0.00        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
     18.01 ±  2%      -8.4        9.57 ±  2%  perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.35 ±  2%      -8.4        0.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
     17.69 ±  2%      -8.3        9.35 ±  2%  perf-profile.calltrace.cycles-pp.udpv6_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      8.24 ±  2%      -8.2        0.00        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     17.20 ±  2%      -8.2        9.00 ±  2%  perf-profile.calltrace.cycles-pp.udp_sendmsg.udpv6_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      7.63 ±  3%      -7.6        0.00        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     11.38 ±  2%      -7.4        3.97 ±  2%  perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.udpv6_sendmsg.sock_sendmsg.__sys_sendto
      7.32 ±  3%      -7.3        0.00        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
     11.10 ±  2%      -7.3        3.84 ±  2%  perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.udpv6_sendmsg.sock_sendmsg
      7.24 ±  3%      -7.2        0.00        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
     10.61 ±  2%      -7.1        3.47 ±  2%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.udpv6_sendmsg
     10.33 ±  2%      -7.0        3.35 ±  2%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
      6.96 ±  3%      -7.0        0.00        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
      6.44 ±  3%      -6.4        0.00        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     19.76 ±  2%      -5.3       14.49 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_sendto
     19.55 ±  2%      -5.3       14.28 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_sendto
     56.13 ±  3%      -4.9       51.27 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     20.38 ±  2%      -4.4       15.93 ±  2%  perf-profile.calltrace.cycles-pp.__libc_sendto
     58.25            -4.0       54.23        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      4.04 ± 73%      -3.6        0.42 ±223%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      4.04 ± 73%      -3.6        0.42 ±223%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      4.04 ± 73%      -3.6        0.42 ±223%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      4.04 ± 73%      -3.6        0.42 ±223%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      4.04 ± 73%      -3.6        0.42 ±223%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      4.04 ± 73%      -3.6        0.42 ±223%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      4.02 ± 73%      -3.6        0.41 ±223%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
     51.35            -3.3       48.06        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     50.36            -3.2       47.12        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     15.60 ±  4%      -2.0       13.63        perf-profile.calltrace.cycles-pp.__libc_recvfrom
     13.92 ±  5%      -1.7       12.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_recvfrom
     13.74 ±  5%      -1.6       12.10        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_recvfrom
     13.35 ±  4%      -1.6       11.74        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_recvfrom
     13.27 ±  5%      -1.6       11.68        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_recvfrom
     12.03 ±  5%      -1.4       10.66 ±  2%  perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.90 ±  5%      -1.4       10.55 ±  2%  perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     11.84 ±  5%      -1.3       10.51 ±  2%  perf-profile.calltrace.cycles-pp.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      1.52 ±  6%      -0.6        0.93 ±  9%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      1.31 ±  6%      -0.5        0.79 ± 10%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      4.01 ±  4%      -0.3        3.66 ±  3%  perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.udpv6_sendmsg.sock_sendmsg.__sys_sendto
      2.72 ±  5%      -0.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.udpv6_sendmsg.sock_sendmsg
      1.70 ±  5%      -0.2        1.52 ±  5%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.udpv6_sendmsg
      1.06 ±  9%      -0.2        0.90 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg.__sys_recvfrom
      1.54 ±  5%      -0.2        1.37 ±  6%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.00 ±  8%      -0.2        0.84 ±  3%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg
      0.94 ±  5%      -0.2        0.78 ±  7%  perf-profile.calltrace.cycles-pp.ip_route_output_flow.udp_sendmsg.udpv6_sendmsg.sock_sendmsg.__sys_sendto
      0.83 ± 11%      -0.1        0.71 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.__skb_recv_udp.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg
      0.70 ±  3%      -0.1        0.59 ±  3%  perf-profile.calltrace.cycles-pp.txn_execute_once
      1.14 ±  8%      -0.1        1.04 ±  4%  perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_make_skb.udp_sendmsg.udpv6_sendmsg.sock_sendmsg
      0.91 ±  3%      -0.1        0.82 ±  8%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb
      0.64 ±  7%      +0.1        0.74 ±  4%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.73 ±  8%      +0.1        0.87 ±  6%  perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      1.30 ±  6%      +0.2        1.46 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.35 ±  6%      +0.2        1.53 ±  5%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      1.00 ±  8%      +0.2        1.22 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      0.49 ± 45%      +0.2        0.71 ± 10%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.update_load_avg.put_prev_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.6        0.58 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.cpuacct_charge.update_curr.put_prev_entity.pick_next_task_fair.__schedule
      0.00            +0.7        0.68 ±  8%  perf-profile.calltrace.cycles-pp.available_idle_cpu.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up
      0.00            +0.7        0.70 ±  6%  perf-profile.calltrace.cycles-pp.update_curr.put_prev_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.7        0.72 ±  9%  perf-profile.calltrace.cycles-pp.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
      0.00            +0.7        0.74 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.enqueue_to_backlog
      0.00            +0.8        0.79 ±  3%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.enqueue_to_backlog.netif_rx_internal
      0.84 ± 42%      +0.8        1.66 ± 13%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_timeout
      0.00            +0.8        0.81 ±  7%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.smpboot_thread_fn.kthread
      0.90 ± 40%      +0.8        1.72 ± 13%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      0.00            +1.1        1.11 ±  3%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.enqueue_to_backlog.netif_rx_internal.__netif_rx
      0.00            +1.4        1.42 ±  4%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop
      1.33 ±  4%      +1.7        3.04 ±  2%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      1.24 ±  4%      +1.7        2.96 ±  2%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      0.00            +1.8        1.76 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit
      0.00            +1.9        1.86 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.00            +2.0        1.95 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit
      0.00            +2.0        1.98 ±  3%  perf-profile.calltrace.cycles-pp.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      0.00            +2.0        2.00 ±  3%  perf-profile.calltrace.cycles-pp.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.00            +2.5        2.45 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +2.6        2.62 ±  6%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +2.8        2.78 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +2.8        2.84 ±  3%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +3.0        3.00 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.2        3.23 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_sendto
      0.00            +3.4        3.37 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_sendto
      0.00            +6.0        6.00 ±  4%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.napi_threaded_poll_loop
      0.00            +6.5        6.50 ±  4%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn
      0.00            +6.8        6.76 ±  4%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn.kthread
      0.00            +6.8        6.82 ±  4%  perf-profile.calltrace.cycles-pp.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +7.0        7.02 ±  4%  perf-profile.calltrace.cycles-pp.napi_threaded_poll_loop.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00           +10.1       10.12 ±  5%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00           +10.4       10.36 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00           +10.4       10.36 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.00           +10.4       10.36 ±  5%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     19.27 ±  2%      -8.6       10.71 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sendto
     19.15 ±  2%      -8.5       10.62 ±  2%  perf-profile.children.cycles-pp.__sys_sendto
     18.04 ±  2%      -8.4        9.59 ±  2%  perf-profile.children.cycles-pp.sock_sendmsg
      8.54 ±  2%      -8.4        0.12 ± 17%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      8.37 ±  2%      -8.4        0.00        perf-profile.children.cycles-pp.do_softirq
     17.72 ±  2%      -8.3        9.38 ±  2%  perf-profile.children.cycles-pp.udpv6_sendmsg
     17.24 ±  2%      -8.2        9.02 ±  2%  perf-profile.children.cycles-pp.udp_sendmsg
      8.99 ±  2%      -8.2        0.78 ± 13%  perf-profile.children.cycles-pp.__do_softirq
      7.64 ±  3%      -7.6        0.00        perf-profile.children.cycles-pp.net_rx_action
     11.40 ±  2%      -7.4        3.98 ±  2%  perf-profile.children.cycles-pp.udp_send_skb
     11.12 ±  2%      -7.3        3.86 ±  2%  perf-profile.children.cycles-pp.ip_send_skb
     10.62 ±  2%      -7.2        3.47 ±  3%  perf-profile.children.cycles-pp.ip_finish_output2
     10.36 ±  2%      -7.0        3.37 ±  2%  perf-profile.children.cycles-pp.__dev_queue_xmit
     34.63 ±  2%      -6.9       27.78        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     34.26 ±  2%      -6.8       27.44        perf-profile.children.cycles-pp.do_syscall_64
     20.56 ±  2%      -4.5       16.10 ±  2%  perf-profile.children.cycles-pp.__libc_sendto
     58.25            -4.0       54.23        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     58.25            -4.0       54.23        perf-profile.children.cycles-pp.cpu_startup_entry
     58.16            -4.0       54.16        perf-profile.children.cycles-pp.do_idle
     54.41            -3.4       50.99        perf-profile.children.cycles-pp.cpuidle_idle_call
     51.50            -3.2       48.30        perf-profile.children.cycles-pp.cpuidle_enter_state
     51.76            -3.2       48.57        perf-profile.children.cycles-pp.cpuidle_enter
     50.47            -3.2       47.32 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
     50.40            -3.1       47.27 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
     32.12 ±  3%      -2.5       29.60 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     15.77 ±  4%      -2.0       13.77        perf-profile.children.cycles-pp.__libc_recvfrom
     13.39 ±  4%      -1.6       11.77        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     13.30 ±  5%      -1.6       11.70        perf-profile.children.cycles-pp.__sys_recvfrom
     12.04 ±  5%      -1.4       10.66 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
     11.91 ±  5%      -1.4       10.55 ±  2%  perf-profile.children.cycles-pp.inet6_recvmsg
     11.86 ±  4%      -1.3       10.52 ±  2%  perf-profile.children.cycles-pp.udpv6_recvmsg
      0.71 ± 11%      -0.7        0.05 ± 47%  perf-profile.children.cycles-pp.select_idle_sibling
      5.66 ±  3%      -0.5        5.18 ±  5%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      0.81 ±  3%      -0.4        0.40 ±  5%  perf-profile.children.cycles-pp.irqtime_account_irq
      2.52 ±  6%      -0.4        2.11 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      4.02 ±  4%      -0.4        3.67 ±  3%  perf-profile.children.cycles-pp.ip_make_skb
      2.74 ±  5%      -0.2        2.49 ±  4%  perf-profile.children.cycles-pp.__ip_append_data
      1.72 ±  6%      -0.2        1.54 ±  5%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      1.08 ±  9%      -0.2        0.90 ±  3%  perf-profile.children.cycles-pp._copy_to_iter
      1.03 ±  9%      -0.2        0.86 ±  3%  perf-profile.children.cycles-pp.copyout
      0.94 ±  5%      -0.2        0.79 ±  8%  perf-profile.children.cycles-pp.ip_route_output_flow
      1.56 ±  5%      -0.1        1.42 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.84 ± 11%      -0.1        0.72 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.63 ±  9%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp.move_addr_to_user
      0.54 ±  4%      -0.1        0.44 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      0.58 ±  7%      -0.1        0.49 ±  6%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.72 ±  3%      -0.1        0.63 ±  3%  perf-profile.children.cycles-pp.txn_execute_once
      0.24 ± 12%      -0.1        0.18 ± 16%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.29 ±  9%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.stats_update
      0.19 ± 12%      -0.1        0.14 ± 13%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.09 ± 26%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.29 ±  3%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp._copy_from_user
      0.12 ± 13%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.dst_release
      0.16 ±  7%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.ip_rcv_core
      0.05 ± 46%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.check_spread
      0.03 ±100%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.09 ± 14%      +0.0        0.14 ± 16%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.04 ± 71%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.trigger_load_balance
      0.10 ± 20%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.rb_erase
      0.08 ± 20%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.__list_add_valid
      0.10 ± 23%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.update_min_vruntime
      0.04 ± 73%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.clear_buddies
      0.12 ± 15%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.10 ± 22%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp.switch_fpu_return
      0.09 ± 11%      +0.1        0.19 ± 14%  perf-profile.children.cycles-pp.pick_next_entity
      0.02 ±141%      +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.18 ±  8%      +0.1        0.30 ± 11%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.13 ±  7%      +0.1        0.26 ± 11%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.27 ±  9%      +0.2        0.43 ± 10%  perf-profile.children.cycles-pp.finish_task_switch
      0.26 ± 10%      +0.2        0.42 ±  7%  perf-profile.children.cycles-pp.os_xsave
      0.32 ±  8%      +0.2        0.55 ±  7%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.65 ±  7%      +0.2        0.89 ±  9%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.2        0.24 ±  7%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.73 ±  6%      +0.3        1.00 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.85 ± 11%      +0.3        1.16 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.33 ±  5%      +0.3        0.68 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
      0.84 ± 13%      +0.4        1.19 ±  7%  perf-profile.children.cycles-pp.check_preempt_curr
      0.52            +0.4        0.89 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.30 ± 23%      +0.4        0.71 ±  8%  perf-profile.children.cycles-pp.available_idle_cpu
      0.73 ±  8%      +0.4        1.18 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.75 ±  8%      +0.5        1.21 ±  5%  perf-profile.children.cycles-pp.prepare_task_switch
      0.84 ±  4%      +0.5        1.36 ±  6%  perf-profile.children.cycles-pp.__switch_to
      0.07 ± 23%      +0.6        0.66 ±  6%  perf-profile.children.cycles-pp.cpuacct_charge
      0.42 ± 11%      +0.7        1.08 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.35 ±  8%      +0.7        1.02 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.06 ± 18%      +0.7        0.72 ±  9%  perf-profile.children.cycles-pp.wake_affine
      1.25 ± 11%      +0.7        1.93 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.59 ±  7%      +0.8        1.36 ±  3%  perf-profile.children.cycles-pp.update_curr
      1.49 ± 10%      +0.8        2.28 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.54 ± 11%      +0.8        2.37 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.89 ± 40%      +0.9        1.76 ± 12%  perf-profile.children.cycles-pp.newidle_balance
      2.42 ± 11%      +1.2        3.64 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.35 ±  7%      +1.4        2.75 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.10 ± 24%      +1.5        1.55 ±  4%  perf-profile.children.cycles-pp.put_prev_entity
      3.50 ±  4%      +1.5        4.99 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      1.34 ±  4%      +1.7        3.05 ±  2%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.27 ±  4%      +1.7        2.99 ±  2%  perf-profile.children.cycles-pp.loopback_xmit
      0.23 ±  5%      +1.7        1.97 ±  3%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.26 ±  6%      +1.7        2.00 ±  3%  perf-profile.children.cycles-pp.__netif_rx
      0.25 ±  8%      +1.7        1.99 ±  3%  perf-profile.children.cycles-pp.netif_rx_internal
      0.00            +3.0        3.03 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.21 ± 14%      +3.2        3.38 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.38 ±  5%      +3.2        3.62 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.58 ± 22%      +3.5        5.04 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      6.38 ±  6%      +4.7       11.09 ±  4%  perf-profile.children.cycles-pp.__schedule
      4.20 ± 11%      +5.2        9.45 ±  5%  perf-profile.children.cycles-pp.schedule
      0.00            +7.0        7.04 ±  4%  perf-profile.children.cycles-pp.napi_threaded_poll_loop
      0.24 ±  7%     +10.1       10.37 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      0.24 ±  7%     +10.1       10.37 ±  5%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.23 ±  7%     +10.1       10.36 ±  5%  perf-profile.children.cycles-pp.kthread
      0.00           +10.2       10.16 ±  5%  perf-profile.children.cycles-pp.smpboot_thread_fn
     34.07 ±  2%      -2.5       31.56 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.69 ±  7%      -0.2        0.50 ±  8%  perf-profile.self.cycles-pp.udp_sendmsg
      0.92 ±  8%      -0.2        0.75 ±  4%  perf-profile.self.cycles-pp.__skb_recv_udp
      1.02 ±  9%      -0.2        0.86 ±  3%  perf-profile.self.cycles-pp.copyout
      0.23 ± 13%      -0.2        0.07 ± 17%  perf-profile.self.cycles-pp.ip_finish_output2
      0.22 ±  7%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.23 ± 13%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.udp_send_skb
      0.83 ± 11%      -0.1        0.70 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.47 ±  9%      -0.1        0.35 ±  8%  perf-profile.self.cycles-pp.udpv6_sendmsg
      0.20 ± 15%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.57 ±  7%      -0.1        0.48 ±  6%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.68 ±  3%      -0.1        0.60 ±  4%  perf-profile.self.cycles-pp.txn_execute_once
      0.28 ± 10%      -0.1        0.20 ± 12%  perf-profile.self.cycles-pp.schedule_timeout
      0.28 ± 10%      -0.1        0.21 ±  4%  perf-profile.self.cycles-pp.stats_update
      0.18 ± 10%      -0.1        0.11 ± 12%  perf-profile.self.cycles-pp.sock_sendmsg
      0.16 ±  9%      -0.1        0.10 ± 21%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.60 ±  6%      -0.1        0.53 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.29 ±  8%      -0.1        0.23 ± 13%  perf-profile.self.cycles-pp.udpv6_recvmsg
      0.30 ±  4%      -0.1        0.24 ±  5%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.42 ±  8%      -0.1        0.36 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.18 ± 13%      -0.1        0.13 ± 11%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.28 ±  3%      -0.0        0.23 ±  4%  perf-profile.self.cycles-pp._copy_from_user
      0.20 ±  5%      -0.0        0.16 ±  7%  perf-profile.self.cycles-pp.__entry_text_start
      0.12 ± 11%      -0.0        0.09 ± 21%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.08 ± 15%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.08 ± 21%      +0.0        0.12 ± 12%  perf-profile.self.cycles-pp.rb_erase
      0.28 ±  6%      +0.0        0.32 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.02 ± 99%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.03 ±100%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.check_spread
      0.05 ± 50%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.09 ± 22%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.update_min_vruntime
      0.02 ±141%      +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.trigger_load_balance
      0.06 ± 49%      +0.1        0.12 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.01 ±223%      +0.1        0.07 ± 21%  perf-profile.self.cycles-pp.find_busiest_group
      0.00            +0.1        0.06 ± 28%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.28 ± 14%      +0.1        0.34 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.10 ± 18%      +0.1        0.17 ± 18%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.11 ± 16%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.__calc_delta
      0.08 ± 19%      +0.1        0.16 ± 18%  perf-profile.self.cycles-pp.load_balance
      0.01 ±223%      +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.activate_task
      0.04 ± 72%      +0.1        0.11 ± 26%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.11 ± 14%      +0.1        0.18 ± 15%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.03 ±100%      +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.update_blocked_averages
      0.08 ± 11%      +0.1        0.17 ± 16%  perf-profile.self.cycles-pp.pick_next_entity
      0.10 ± 24%      +0.1        0.18 ± 13%  perf-profile.self.cycles-pp.switch_fpu_return
      0.22 ± 18%      +0.1        0.31 ±  9%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.08 ± 19%      +0.1        0.17 ± 12%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.18 ±  7%      +0.1        0.28 ± 11%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.04 ± 71%      +0.1        0.16 ± 20%  perf-profile.self.cycles-pp.put_prev_entity
      0.11 ± 15%      +0.1        0.25 ±  7%  perf-profile.self.cycles-pp.set_next_entity
      0.23 ± 10%      +0.1        0.38 ± 13%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.2        0.15 ± 14%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.30 ± 14%      +0.2        0.45 ± 10%  perf-profile.self.cycles-pp.enqueue_entity
      0.26 ± 11%      +0.2        0.42 ±  6%  perf-profile.self.cycles-pp.os_xsave
      0.18 ± 18%      +0.2        0.34 ±  8%  perf-profile.self.cycles-pp.schedule
      0.00            +0.2        0.16 ± 18%  perf-profile.self.cycles-pp.napi_threaded_poll_loop
      0.58 ±  6%      +0.2        0.78 ± 10%  perf-profile.self.cycles-pp.___perf_sw_event
      0.16 ± 12%      +0.2        0.36 ±  8%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.32 ±  6%      +0.2        0.54 ±  6%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.11 ± 20%      +0.2        0.33 ± 11%  perf-profile.self.cycles-pp.prepare_task_switch
      0.68 ±  5%      +0.3        0.94 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.52            +0.4        0.88 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.4        0.36 ± 11%  perf-profile.self.cycles-pp.smpboot_thread_fn
      0.32 ± 12%      +0.4        0.68 ±  6%  perf-profile.self.cycles-pp.update_load_avg
      0.69 ±  5%      +0.4        1.07 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.28 ± 24%      +0.4        0.70 ±  9%  perf-profile.self.cycles-pp.available_idle_cpu
      0.70 ±  8%      +0.4        1.13 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.82 ±  5%      +0.5        1.30 ±  6%  perf-profile.self.cycles-pp.__switch_to
      0.07 ± 23%      +0.6        0.66 ±  6%  perf-profile.self.cycles-pp.cpuacct_charge
      0.31 ±  7%      +0.6        0.92 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se



***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/dccp/stress-ng/60s

commit: 
  83b5f0253b ("net: phy: Introduce PSGMII PHY interface mode")
  e9dc861c8b ("net: Use SMP threads for backlog NAPI.")

83b5f0253b1ef352 e9dc861c8b3c291826d6cc1a867 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   5871892 ±  2%     +18.5%    6957517 ±  2%  cpuidle..usage
      3.59            -7.8%       3.31 ±  2%  iostat.cpu.system
    643.03 ±  5%     -23.5%     492.14 ± 17%  sched_debug.cfs_rq:/.min_vruntime.min
    111973 ±  4%    +143.4%     272574 ±  4%  vmstat.system.cs
      0.33 ±  2%      -0.3        0.04 ±  7%  mpstat.cpu.all.soft%
      0.32            +0.0        0.36 ±  2%  mpstat.cpu.all.usr%
     45636 ±  3%    +517.7%     281909        turbostat.C1
      0.14 ±  5%      +0.2        0.31 ±  4%  turbostat.C1%
      4.78 ±  2%      -0.3        4.49 ±  2%  turbostat.C1E%
   2544029 ±  6%     +35.4%    3445596 ±  4%  turbostat.POLL
      0.10 ±  5%      +0.1        0.22 ±  4%  turbostat.POLL%
    156618 ±  5%    +149.8%     391188        meminfo.Active
    140656 ±  6%    +166.8%     375277        meminfo.Active(anon)
     66148 ± 12%     -17.1%      54847 ± 11%  meminfo.AnonHugePages
    661727           +39.5%     922917        meminfo.Committed_AS
     43445           +24.5%      54073 ±  8%  meminfo.Mapped
    154214 ±  5%    +168.1%     413503        meminfo.Shmem
     77137 ±  2%     -16.0%      64808 ±  4%  stress-ng.dccp.messages_per_sec
     73462 ±  2%     -16.0%      61719 ±  4%  stress-ng.dccp.ops
      1224 ±  2%     -16.0%       1028 ±  4%  stress-ng.dccp.ops_per_sec
    832.67 ±  3%    +5e+05%    4159259 ±  4%  stress-ng.time.involuntary_context_switches
     95.00           -14.9%      80.83 ±  5%  stress-ng.time.percent_of_cpu_this_job_got
     58.88           -15.8%      49.55 ±  5%  stress-ng.time.system_time
   2727584 ±  5%     +41.9%    3870138 ±  4%  stress-ng.time.voluntary_context_switches
     35165 ±  6%    +166.8%      93819        proc-vmstat.nr_active_anon
    754437            +8.6%     819232        proc-vmstat.nr_file_pages
     79513            +7.6%      85594        proc-vmstat.nr_inactive_anon
      8763            +6.8%       9356        proc-vmstat.nr_kernel_stack
     10863           +24.5%      13522 ±  8%  proc-vmstat.nr_mapped
     38558 ±  5%    +168.1%     103378        proc-vmstat.nr_shmem
     23483            +3.3%      24247        proc-vmstat.nr_slab_unreclaimable
     35165 ±  6%    +166.8%      93819        proc-vmstat.nr_zone_active_anon
     79513            +7.6%      85594        proc-vmstat.nr_zone_inactive_anon
    443490           +15.7%     513117        proc-vmstat.numa_hit
    445922 ±  2%     +15.0%     512943        proc-vmstat.numa_local
     52965 ±  5%    +168.2%     142076        proc-vmstat.pgactivate
   1505891            -6.2%    1412250 ±  2%  proc-vmstat.pgalloc_normal
    212490            +8.2%     229851        proc-vmstat.pgfault
   1425607           -13.0%    1239802 ±  3%  proc-vmstat.pgfree
     17.80 ±  7%     -13.7%      15.37 ±  7%  perf-stat.i.MPKI
  11245386            +6.4%   11967086 ±  2%  perf-stat.i.branch-misses
      1.46 ±  6%      +0.7        2.16 ±  7%  perf-stat.i.cache-miss-rate%
    828103 ±  4%     +56.9%    1299520 ±  2%  perf-stat.i.cache-misses
 1.027e+08 ±  2%     -14.3%   88075829 ±  4%  perf-stat.i.cache-references
    117427 ±  4%    +143.8%     286319 ±  4%  perf-stat.i.context-switches
     59.68 ±  2%   +1659.6%       1050 ±  8%  perf-stat.i.cpu-migrations
     39134 ± 22%     -55.6%      17366 ±  5%  perf-stat.i.cycles-between-cache-misses
    106602 ± 16%     +48.6%     158428 ± 17%  perf-stat.i.dTLB-load-misses
     84.77            -4.0       80.77        perf-stat.i.iTLB-load-miss-rate%
   3709152 ±  2%     -14.1%    3186224 ±  5%  perf-stat.i.iTLB-load-misses
    584638 ±  4%     +12.1%     655260 ±  2%  perf-stat.i.iTLB-loads
      1964           +13.0%       2221 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      1864           +15.4%       2152        perf-stat.i.minor-faults
     88295 ±  6%     +70.7%     150709 ±  3%  perf-stat.i.node-loads
    137528 ±  7%     +30.7%     179725 ±  5%  perf-stat.i.node-stores
      1864           +15.4%       2152        perf-stat.i.page-faults
     16.23           -15.6%      13.71        perf-stat.overall.MPKI
      0.81 ±  6%      +0.7        1.48 ±  4%  perf-stat.overall.cache-miss-rate%
      6907 ±  5%     -35.3%       4467 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.01 ± 18%      +0.0        0.01 ± 22%  perf-stat.overall.dTLB-load-miss-rate%
     86.38            -3.5       82.92        perf-stat.overall.iTLB-load-miss-rate%
      1705           +18.3%       2017        perf-stat.overall.instructions-per-iTLB-miss
  11070217            +6.4%   11778477 ±  2%  perf-stat.ps.branch-misses
    815402 ±  4%     +56.9%    1279495 ±  2%  perf-stat.ps.cache-misses
 1.011e+08 ±  2%     -14.3%   86684499 ±  4%  perf-stat.ps.cache-references
    115587 ±  4%    +143.8%     281791 ±  4%  perf-stat.ps.context-switches
     58.75 ±  2%   +1659.1%       1033 ±  8%  perf-stat.ps.cpu-migrations
    104986 ± 16%     +48.6%     156010 ± 17%  perf-stat.ps.dTLB-load-misses
   3651135 ±  2%     -14.1%    3135989 ±  5%  perf-stat.ps.iTLB-load-misses
    575492 ±  4%     +12.1%     644966 ±  2%  perf-stat.ps.iTLB-loads
      1835           +15.4%       2119        perf-stat.ps.minor-faults
     86937 ±  6%     +70.7%     148402 ±  3%  perf-stat.ps.node-loads
    135391 ±  7%     +30.7%     176929 ±  5%  perf-stat.ps.node-stores
      1835           +15.4%       2119        perf-stat.ps.page-faults
      0.00 ± 13%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.dccp_sendmsg.sock_sendmsg
      0.00 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00           -50.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.00          +100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg
      0.00           -25.0%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +19800.0%       0.10 ±109%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.dccp_recvmsg.sock_common_recvmsg
      0.01 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.dccp_sendmsg.sock_sendmsg
      0.00 ± 95%    +450.0%       0.02 ± 26%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.00 ± 11%   +6389.5%       0.21 ±101%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.05 ±129%   +2212.4%       1.18 ± 85%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00          +100.0%       0.00        perf-sched.total_sch_delay.average.ms
      2.39 ±  5%     -69.4%       0.73        perf-sched.total_wait_and_delay.average.ms
    194690 ±  5%    +286.0%     751492        perf-sched.total_wait_and_delay.count.ms
      2.39 ±  5%     -69.5%       0.73        perf-sched.total_wait_time.average.ms
    783.24 ±  4%     -19.2%     633.25 ± 14%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    147.40 ±  5%     -61.4%      56.84 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ± 22%    +170.0%       0.01        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg
    454.52 ±  9%     -99.7%       1.31 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    456.60 ±  4%     +16.0%     529.45 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.33 ±141%   +2200.0%       7.67 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      2.00 ± 50%   +1025.0%      22.50 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.17 ±223%   +6000.0%      10.17 ± 18%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      1.00 ±223%  +2.2e+07%     216471        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    113.67 ±  5%    +143.0%     276.17        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      9952 ±  2%     -32.4%       6730        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
    104457 ±  9%    +106.7%     215888        perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg
    486.17 ±  9%  +46231.5%     225248        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.62 ±223%   +4350.7%     205.65 ±173%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     19.40 ±223%   +4222.6%     838.77 ± 43%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      6.33 ± 47%     -73.0%       1.71 ± 54%  perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg
      0.00 ± 81%    +969.2%       0.02 ± 73%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.dccp_recvmsg.sock_common_recvmsg
    783.24 ±  4%     -19.2%     633.24 ± 14%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    147.40 ±  5%     -61.4%      56.84 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ± 22%    +105.0%       0.01 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg
    454.52 ±  9%     -99.7%       1.31 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    456.59 ±  4%     +16.0%     529.45 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 70%    +168.6%       0.02 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.dccp_feat_entry_new.dccp_feat_signal_nn_change
      0.00 ± 88%    +1e+05%       2.43 ± 85%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.dccp_recvmsg.sock_common_recvmsg
      0.00 ±101%    +443.5%       0.02 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
      4.62 ±223%   +4350.7%     205.64 ±173%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    166.68 ±223%    +400.9%     834.86 ± 44%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     23.59 ±177%   +3455.0%     838.76 ± 43%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      6.32 ± 47%     -73.4%       1.68 ± 55%  perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg
     42.69 ±  7%      -7.7       34.98 ±  3%  perf-profile.calltrace.cycles-pp.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64
     42.69 ±  7%      -7.7       34.98 ±  3%  perf-profile.calltrace.cycles-pp.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     42.70 ±  7%      -7.7       35.00 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
     42.70 ±  7%      -7.7       35.00 ±  3%  perf-profile.calltrace.cycles-pp.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
     42.71 ±  7%      -7.7       35.01 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
     42.71 ±  7%      -7.7       35.01 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.connect
     42.72 ±  7%      -7.7       35.02 ±  3%  perf-profile.calltrace.cycles-pp.connect
     42.12 ±  7%      -7.2       34.92 ±  3%  perf-profile.calltrace.cycles-pp.dccp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
     41.08 ±  7%      -6.9       34.22 ±  3%  perf-profile.calltrace.cycles-pp.__inet_hash_connect.dccp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
     28.16 ±  8%      -4.7       23.48 ±  3%  perf-profile.calltrace.cycles-pp.__inet_check_established.__inet_hash_connect.dccp_v4_connect.__inet_stream_connect.inet_stream_connect
      5.44 ± 19%      -3.8        1.64 ±  2%  perf-profile.calltrace.cycles-pp.dccp_write_xmit.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      5.39 ± 19%      -3.8        1.62 ±  2%  perf-profile.calltrace.cycles-pp.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg.sock_sendmsg.__sys_sendto
      8.41 ± 15%      -3.7        4.69 ± 12%  perf-profile.calltrace.cycles-pp.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      8.55 ± 14%      -3.6        4.90 ± 13%  perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.79 ± 14%      -3.4        5.36 ± 13%  perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      8.83 ± 15%      -3.4        5.41 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      3.54 ± 17%      -2.7        0.86 ±  5%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit
      3.50 ± 17%      -2.7        0.83 ±  6%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.dccp_transmit_skb.dccp_xmit_packet
      3.74 ± 18%      -2.7        1.08 ±  5%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg
      8.95 ± 14%      -2.6        6.32 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      9.04 ± 15%      -2.6        6.43 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send
      3.91 ± 18%      -2.5        1.38 ±  4%  perf-profile.calltrace.cycles-pp.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg.sock_sendmsg
      9.29 ± 14%      -2.1        7.15 ± 12%  perf-profile.calltrace.cycles-pp.__send
      5.09 ±  7%      -1.6        3.51 ±  6%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      5.10 ±  6%      -1.6        3.53 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      4.93 ±  6%      -1.5        3.38 ±  7%  perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.19 ±  6%      -1.5        3.66 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      5.22 ±  6%      -1.5        3.69 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv
      5.56 ±  6%      -1.5        4.04 ±  6%  perf-profile.calltrace.cycles-pp.recv
      4.81 ±  6%      -1.5        3.30 ±  7%  perf-profile.calltrace.cycles-pp.dccp_recvmsg.sock_common_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      4.82 ±  6%      -1.5        3.32 ±  7%  perf-profile.calltrace.cycles-pp.sock_common_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      6.63 ±  8%      -1.2        5.41 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.__inet_hash_connect.dccp_v4_connect.__inet_stream_connect.inet_stream_connect
      3.82 ±  8%      -0.7        3.14 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__inet_check_established.__inet_hash_connect.dccp_v4_connect.__inet_stream_connect
      2.98 ± 10%      -0.4        2.56 ±  6%  perf-profile.calltrace.cycles-pp.inet_ehashfn.__inet_check_established.__inet_hash_connect.dccp_v4_connect.__inet_stream_connect
      1.25 ±  9%      -0.2        1.10 ±  6%  perf-profile.calltrace.cycles-pp.__cond_resched.__inet_hash_connect.dccp_v4_connect.__inet_stream_connect.inet_stream_connect
      0.65 ± 13%      +0.2        0.86 ±  8%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg
      0.69 ± 13%      +0.2        0.92 ±  8%  perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg.sock_common_recvmsg
      0.54 ± 46%      +0.3        0.82 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      1.03 ± 26%      +0.4        1.39 ±  6%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.dccp_transmit_skb.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids.dccp_rcv_established
      0.91 ± 15%      +0.4        1.31 ±  8%  perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.dccp_recvmsg.sock_common_recvmsg.sock_recvmsg
      0.80 ± 26%      +0.4        1.21 ±  7%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.dccp_transmit_skb.ccid2_hc_rx_packet_recv
      0.83 ± 25%      +0.4        1.24 ±  7%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.dccp_transmit_skb.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids
      0.58 ± 51%      +0.4        1.00 ± 10%  perf-profile.calltrace.cycles-pp.dccp_write_space.sock_wfree.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      0.61 ± 51%      +0.4        1.06 ±  9%  perf-profile.calltrace.cycles-pp.sock_wfree.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.45 ± 74%      +0.4        0.90 ± 11%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.dccp_write_space.sock_wfree.loopback_xmit.dev_hard_start_xmit
      0.65 ±  9%      +0.5        1.11 ± 23%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.00            +0.6        0.57 ±  9%  perf-profile.calltrace.cycles-pp.dccp_rcv_state_process.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.22 ±143%      +0.6        0.80 ± 13%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.dccp_write_space.sock_wfree.loopback_xmit
      0.10 ±223%      +0.6        0.68 ± 12%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.dccp_write_space.sock_wfree
      0.00            +0.6        0.58 ±  8%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.6        0.62 ±  9%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.68 ± 12%      +0.6        1.31 ± 11%  perf-profile.calltrace.cycles-pp.clock_nanosleep
      0.00            +0.7        0.65 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.18 ±141%      +0.7        0.90 ± 24%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.dccp_sendmsg.sock_sendmsg.__sys_sendto
      0.00            +0.7        0.74 ±  9%  perf-profile.calltrace.cycles-pp.__dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.00            +0.7        0.74 ± 10%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      0.40 ± 71%      +0.7        1.14 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.38 ± 71%      +0.8        1.13 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.09 ±223%      +0.8        0.86 ± 24%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.dccp_sendmsg.sock_sendmsg
      0.26 ±100%      +0.8        1.03 ± 12%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.27 ±100%      +0.8        1.04 ± 12%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00            +0.8        0.79 ± 11%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.00            +0.8        0.80 ± 12%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00            +0.8        0.80 ±  8%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      0.28 ±100%      +0.8        1.10 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.09 ±223%      +0.9        0.98 ± 12%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      1.66 ± 23%      +0.9        2.59 ±  7%  perf-profile.calltrace.cycles-pp.dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.00            +0.9        0.93 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +1.0        0.97 ±  6%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.64 ± 50%      +1.1        1.72 ±  5%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
      0.65 ± 51%      +1.1        1.76 ±  5%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.dccp_transmit_skb
      2.36 ± 20%      +1.8        4.14 ±  6%  perf-profile.calltrace.cycles-pp.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      2.05 ± 21%      +1.9        3.92 ±  5%  perf-profile.calltrace.cycles-pp.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      1.63 ± 14%      +1.9        3.56 ±  4%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.16 ± 19%      +2.0        5.14 ±  6%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     40.13 ±  6%      +3.6       43.69 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +5.2        5.16 ±  6%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.napi_threaded_poll_loop
      0.00            +5.5        5.46 ±  5%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn
      0.00            +5.6        5.60 ±  5%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn.kthread
      0.00            +5.6        5.62 ±  5%  perf-profile.calltrace.cycles-pp.__napi_poll.napi_threaded_poll_loop.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +5.7        5.66 ±  5%  perf-profile.calltrace.cycles-pp.napi_threaded_poll_loop.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +6.8        6.80 ±  5%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +6.9        6.87 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00            +6.9        6.87 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.00            +6.9        6.87 ±  5%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     58.36 ±  4%     -11.2       47.14 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     58.49 ±  4%     -11.2       47.32 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     42.69 ±  7%      -7.7       34.98 ±  3%  perf-profile.children.cycles-pp.__inet_stream_connect
     42.69 ±  7%      -7.7       34.98 ±  3%  perf-profile.children.cycles-pp.inet_stream_connect
     42.70 ±  7%      -7.7       35.00 ±  3%  perf-profile.children.cycles-pp.__x64_sys_connect
     42.70 ±  7%      -7.7       35.00 ±  3%  perf-profile.children.cycles-pp.__sys_connect
     42.72 ±  7%      -7.7       35.02 ±  3%  perf-profile.children.cycles-pp.connect
     42.12 ±  7%      -7.2       34.92 ±  3%  perf-profile.children.cycles-pp.dccp_v4_connect
     41.64 ±  7%      -6.9       34.70 ±  3%  perf-profile.children.cycles-pp.__inet_hash_connect
      6.16 ± 10%      -5.1        1.04 ± 12%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      5.63 ± 15%      -5.1        0.56 ± 18%  perf-profile.children.cycles-pp.__do_softirq
      5.04 ± 13%      -5.0        0.04 ± 75%  perf-profile.children.cycles-pp.do_softirq
     28.38 ±  8%      -4.7       23.67 ±  3%  perf-profile.children.cycles-pp.__inet_check_established
      5.46 ± 19%      -3.8        1.66 ±  3%  perf-profile.children.cycles-pp.dccp_write_xmit
      5.39 ± 19%      -3.8        1.63 ±  3%  perf-profile.children.cycles-pp.dccp_xmit_packet
      8.42 ± 15%      -3.7        4.71 ± 12%  perf-profile.children.cycles-pp.dccp_sendmsg
      8.55 ± 14%      -3.6        4.90 ± 13%  perf-profile.children.cycles-pp.sock_sendmsg
      6.19 ± 13%      -3.5        2.69 ±  4%  perf-profile.children.cycles-pp.__ip_queue_xmit
      6.80 ± 12%      -3.4        3.36 ±  5%  perf-profile.children.cycles-pp.dccp_transmit_skb
      5.73 ± 12%      -3.4        2.30 ±  3%  perf-profile.children.cycles-pp.ip_finish_output2
      8.80 ± 14%      -3.4        5.37 ± 13%  perf-profile.children.cycles-pp.__sys_sendto
      8.84 ± 14%      -3.4        5.41 ± 13%  perf-profile.children.cycles-pp.__x64_sys_sendto
      5.64 ± 12%      -3.4        2.22 ±  3%  perf-profile.children.cycles-pp.__dev_queue_xmit
      2.92 ±  5%      -2.7        0.26 ± 15%  perf-profile.children.cycles-pp.__release_sock
      3.25 ±  5%      -2.7        0.60 ± 12%  perf-profile.children.cycles-pp.release_sock
      9.37 ± 14%      -2.1        7.31 ± 12%  perf-profile.children.cycles-pp.__send
      5.09 ±  6%      -1.6        3.51 ±  6%  perf-profile.children.cycles-pp.__sys_recvfrom
      5.10 ±  6%      -1.6        3.53 ±  6%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
      4.93 ±  6%      -1.5        3.38 ±  7%  perf-profile.children.cycles-pp.sock_recvmsg
      5.61 ±  6%      -1.5        4.07 ±  6%  perf-profile.children.cycles-pp.recv
      4.81 ±  6%      -1.5        3.30 ±  7%  perf-profile.children.cycles-pp.dccp_recvmsg
      4.82 ±  6%      -1.5        3.32 ±  7%  perf-profile.children.cycles-pp.sock_common_recvmsg
      7.76 ±  7%      -1.5        6.28 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      5.18 ±  8%      -1.1        4.12 ±  6%  perf-profile.children.cycles-pp.dccp_v4_do_rcv
      3.36 ± 10%      -0.6        2.77 ±  7%  perf-profile.children.cycles-pp.dccp_rcv_established
      4.47 ±  7%      -0.6        3.90 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.96 ±  9%      -0.4        0.60 ±  6%  perf-profile.children.cycles-pp.dccp_rcv_state_process
      0.44 ± 15%      -0.3        0.13 ± 14%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.50 ± 13%      -0.3        0.20 ± 14%  perf-profile.children.cycles-pp.dccp_rcv_request_sent_state_process
      0.41 ± 18%      -0.2        0.16 ± 12%  perf-profile.children.cycles-pp.dccp_connect
      1.14 ±  7%      -0.2        0.91 ±  9%  perf-profile.children.cycles-pp.dccp_v4_rcv
      0.60 ± 13%      -0.2        0.44 ± 10%  perf-profile.children.cycles-pp.lock_sock_nested
      0.27 ± 12%      -0.2        0.11 ± 28%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.62 ±  8%      -0.2        0.46 ±  9%  perf-profile.children.cycles-pp.__inet_lookup_skb
      0.58 ± 10%      -0.2        0.42 ± 11%  perf-profile.children.cycles-pp.__inet_lookup_established
      0.46 ± 11%      -0.2        0.31 ± 12%  perf-profile.children.cycles-pp.__slab_free
      0.68 ±  7%      -0.1        0.54 ± 10%  perf-profile.children.cycles-pp.__kfree_skb
      0.56 ± 10%      -0.1        0.42 ± 14%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.56 ± 10%      -0.1        0.43 ± 14%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.26 ± 25%      -0.1        0.14 ± 23%  perf-profile.children.cycles-pp.dccp_ackvec_clear_state
      0.16 ± 17%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.dccp_finish_passive_close
      0.15 ± 22%      -0.1        0.05 ± 73%  perf-profile.children.cycles-pp.dccp_close
      0.16 ± 20%      -0.1        0.05 ± 74%  perf-profile.children.cycles-pp.inet_release
      0.18 ± 23%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.dccp_check_seqno
      0.16 ± 22%      -0.1        0.06 ± 52%  perf-profile.children.cycles-pp.__sock_release
      0.16 ± 22%      -0.1        0.06 ± 52%  perf-profile.children.cycles-pp.sock_close
      0.22 ± 11%      -0.1        0.14 ± 21%  perf-profile.children.cycles-pp.dccp_enqueue_skb
      0.21 ± 15%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.dccp_v4_send_check
      0.25 ± 13%      -0.1        0.20 ±  9%  perf-profile.children.cycles-pp.dccp_feat_activate_values
      0.18 ± 15%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.ccid_new
      0.17 ± 16%      -0.0        0.13 ± 15%  perf-profile.children.cycles-pp.__x64_sys_socket
      0.17 ± 16%      -0.0        0.13 ± 15%  perf-profile.children.cycles-pp.__sys_socket
      0.16 ± 14%      -0.0        0.12 ± 12%  perf-profile.children.cycles-pp.ccid2_hc_tx_init
      0.08 ± 18%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.08 ± 12%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.04 ± 71%      +0.0        0.08 ± 19%  perf-profile.children.cycles-pp.place_entity
      0.02 ±142%      +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.10 ± 17%      +0.1        0.15 ± 24%  perf-profile.children.cycles-pp.__fget_light
      0.02 ±141%      +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.04 ± 71%      +0.1        0.10 ± 17%  perf-profile.children.cycles-pp.idle_cpu
      0.12 ± 14%      +0.1        0.18 ± 26%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.02 ±144%      +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.07 ± 53%      +0.1        0.13 ± 44%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.cpuacct_charge
      0.01 ±223%      +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.pick_next_entity
      0.07 ± 51%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.05 ± 45%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.switch_fpu_return
      0.02 ±142%      +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.13 ± 30%      +0.1        0.21 ± 11%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.08 ± 32%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.08 ± 21%      +0.1        0.18 ± 15%  perf-profile.children.cycles-pp.os_xsave
      0.00            +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.cpu_util
      0.17 ± 21%      +0.1        0.28 ± 12%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.11 ± 19%      +0.1        0.22 ± 14%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.10 ± 37%      +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.available_idle_cpu
      0.09 ± 36%      +0.1        0.22 ± 15%  perf-profile.children.cycles-pp.wake_affine
      0.35 ± 10%      +0.1        0.48 ± 16%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.00            +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.check_preempt_curr
      0.17 ± 28%      +0.1        0.32 ± 18%  perf-profile.children.cycles-pp.update_rq_clock
      0.12 ± 18%      +0.2        0.28 ± 16%  perf-profile.children.cycles-pp.___perf_sw_event
      0.18 ± 26%      +0.2        0.34 ± 13%  perf-profile.children.cycles-pp.select_task_rq
      0.28 ± 20%      +0.2        0.44 ± 16%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.16 ±  9%      +0.2        0.35 ± 12%  perf-profile.children.cycles-pp.prepare_task_switch
      0.12 ± 24%      +0.2        0.32 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.66 ± 11%      +0.2        0.86 ±  5%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.17 ± 38%      +0.2        0.37 ± 14%  perf-profile.children.cycles-pp.accept
      0.14 ± 39%      +0.2        0.35 ± 14%  perf-profile.children.cycles-pp.__x64_sys_accept
      0.14 ± 39%      +0.2        0.35 ± 14%  perf-profile.children.cycles-pp.__sys_accept4
      0.14 ± 43%      +0.2        0.35 ± 15%  perf-profile.children.cycles-pp.do_accept
      0.10 ± 64%      +0.2        0.31 ± 14%  perf-profile.children.cycles-pp.inet_csk_accept
      0.10 ± 61%      +0.2        0.32 ± 14%  perf-profile.children.cycles-pp.inet_accept
      0.17 ±  9%      +0.2        0.39 ± 10%  perf-profile.children.cycles-pp.__switch_to
      0.14 ± 17%      +0.2        0.38 ± 11%  perf-profile.children.cycles-pp.update_curr
      0.22 ± 22%      +0.2        0.46 ±  7%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.2        0.25 ±  5%  perf-profile.children.cycles-pp.put_prev_entity
      0.40 ± 12%      +0.3        0.66 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
      0.11 ± 30%      +0.3        0.38 ± 10%  perf-profile.children.cycles-pp.set_next_entity
      0.18 ± 34%      +0.3        0.44 ± 23%  perf-profile.children.cycles-pp.kfree_skb_reason
      0.88 ±  8%      +0.3        1.16 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.96 ±  9%      +0.3        1.26 ±  4%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.46 ± 13%      +0.3        0.76 ±  5%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.36 ±  5%      +0.3        0.70 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.66 ±  9%      +0.4        1.02 ± 18%  perf-profile.children.cycles-pp.__alloc_skb
      0.01 ±223%      +0.4        0.37 ± 15%  perf-profile.children.cycles-pp.intel_idle_irq
      0.78 ± 21%      +0.4        1.16 ± 10%  perf-profile.children.cycles-pp.__wake_up_common
      0.78 ± 22%      +0.4        1.17 ±  8%  perf-profile.children.cycles-pp.dccp_write_space
      0.94 ± 21%      +0.4        1.34 ±  7%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.49 ± 10%      +0.4        0.90 ± 24%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.91 ± 15%      +0.4        1.35 ±  8%  perf-profile.children.cycles-pp.wait_woken
      0.44 ±  7%      +0.5        0.90 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.65 ±  9%      +0.5        1.12 ± 23%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.31 ±  8%      +0.5        0.78 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.45 ±  7%      +0.5        0.92 ±  4%  perf-profile.children.cycles-pp.activate_task
      0.75 ± 11%      +0.5        1.22 ±  6%  perf-profile.children.cycles-pp.schedule_timeout
      0.97 ± 19%      +0.5        1.44 ±  7%  perf-profile.children.cycles-pp.sock_wfree
      0.12 ± 12%      +0.5        0.64 ±  8%  perf-profile.children.cycles-pp.__netif_rx
      0.11 ± 16%      +0.5        0.64 ±  7%  perf-profile.children.cycles-pp.netif_rx_internal
      0.10 ± 22%      +0.5        0.63 ±  8%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.44 ± 13%      +0.5        0.99 ± 12%  perf-profile.children.cycles-pp.do_nanosleep
      0.13 ± 30%      +0.5        0.68 ±  7%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.48 ± 12%      +0.6        1.03 ± 12%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.48 ± 12%      +0.6        1.05 ± 12%  perf-profile.children.cycles-pp.common_nsleep
      0.19 ± 34%      +0.6        0.77 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.52 ± 10%      +0.6        1.10 ± 12%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.27 ± 24%      +0.6        0.85 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.49 ±  7%      +0.6        1.09 ±  6%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.20 ± 34%      +0.6        0.80 ±  7%  perf-profile.children.cycles-pp.find_busiest_group
      0.69 ± 12%      +0.6        1.33 ± 11%  perf-profile.children.cycles-pp.clock_nanosleep
      0.37 ± 18%      +0.7        1.02 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.28 ± 34%      +0.7        0.94 ±  7%  perf-profile.children.cycles-pp.load_balance
      0.44 ± 19%      +0.7        1.12 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.08 ± 18%      +0.8        1.91 ±  3%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.05 ± 17%      +0.8        1.88 ±  3%  perf-profile.children.cycles-pp.loopback_xmit
      0.03 ±101%      +0.8        0.87 ±  6%  perf-profile.children.cycles-pp.newidle_balance
      0.81 ± 18%      +1.0        1.77 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      4.47 ± 13%      +1.0        5.46 ±  5%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      4.16 ± 12%      +1.0        5.16 ±  6%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      4.13 ± 12%      +1.0        5.14 ±  6%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      2.88 ± 16%      +1.3        4.15 ±  6%  perf-profile.children.cycles-pp.__sk_receive_skb
      0.23 ± 15%      +1.5        1.74 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.69 ± 10%      +2.0        3.69 ±  4%  perf-profile.children.cycles-pp.poll_idle
      1.00 ±  5%      +2.6        3.58 ±  2%  perf-profile.children.cycles-pp.schedule
      1.49 ±  8%      +2.6        4.12        perf-profile.children.cycles-pp.__schedule
     40.12 ±  6%      +3.5       43.66 ±  4%  perf-profile.children.cycles-pp.do_idle
     40.13 ±  6%      +3.6       43.69 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     40.13 ±  6%      +3.6       43.69 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.00            +5.7        5.67 ±  5%  perf-profile.children.cycles-pp.napi_threaded_poll_loop
      0.08 ± 58%      +6.8        6.87 ±  5%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.08 ± 58%      +6.8        6.87 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      0.07 ± 58%      +6.8        6.87 ±  5%  perf-profile.children.cycles-pp.kthread
      0.00            +6.8        6.80 ±  5%  perf-profile.children.cycles-pp.smpboot_thread_fn
     21.29 ±  8%      -3.6       17.73 ±  2%  perf-profile.self.cycles-pp.__inet_check_established
      7.13 ±  7%      -1.1        5.99 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      4.16 ±  7%      -0.7        3.48 ±  3%  perf-profile.self.cycles-pp.__inet_hash_connect
      4.42 ±  7%      -0.6        3.85 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.44 ± 15%      -0.3        0.12 ± 14%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.55 ± 10%      -0.2        0.38 ± 13%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.28 ± 17%      -0.2        0.12 ± 26%  perf-profile.self.cycles-pp.__sk_receive_skb
      0.46 ± 11%      -0.1        0.31 ± 12%  perf-profile.self.cycles-pp.__slab_free
      0.18 ± 23%      -0.1        0.08 ± 22%  perf-profile.self.cycles-pp.dccp_check_seqno
      0.21 ± 12%      -0.1        0.11 ± 19%  perf-profile.self.cycles-pp.dccp_transmit_skb
      0.22 ± 11%      -0.1        0.14 ± 20%  perf-profile.self.cycles-pp.dccp_enqueue_skb
      0.09 ± 31%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.dccp_ackvec_parsed_add
      0.18 ± 15%      -0.1        0.12 ± 21%  perf-profile.self.cycles-pp.ccid2_hc_tx_packet_recv
      0.07 ±  9%      +0.0        0.12 ± 20%  perf-profile.self.cycles-pp.do_syscall_64
      0.04 ± 71%      +0.0        0.08 ± 20%  perf-profile.self.cycles-pp.place_entity
      0.12 ± 10%      +0.0        0.17 ± 16%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.newidle_balance
      0.06 ± 52%      +0.1        0.12 ± 19%  perf-profile.self.cycles-pp.update_rq_clock
      0.09 ± 22%      +0.1        0.15 ± 24%  perf-profile.self.cycles-pp.__fget_light
      0.05 ± 45%      +0.1        0.11 ± 20%  perf-profile.self.cycles-pp.switch_fpu_return
      0.04 ±101%      +0.1        0.10 ± 14%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.02 ±146%      +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.02 ±141%      +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.prepare_task_switch
      0.02 ±142%      +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.02 ±144%      +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.12 ± 22%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.dccp_sendmsg
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.cpuacct_charge
      0.07 ± 51%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.07 ± 21%  perf-profile.self.cycles-pp.pick_next_entity
      0.10 ± 48%      +0.1        0.18 ± 23%  perf-profile.self.cycles-pp.__entry_text_start
      0.27 ± 14%      +0.1        0.35 ± 10%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.12 ± 31%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.03 ±100%      +0.1        0.11 ± 18%  perf-profile.self.cycles-pp.schedule
      0.00            +0.1        0.08 ± 32%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.01 ±223%      +0.1        0.10 ± 14%  perf-profile.self.cycles-pp.idle_cpu
      0.08 ± 23%      +0.1        0.17 ± 14%  perf-profile.self.cycles-pp.os_xsave
      0.01 ±223%      +0.1        0.10 ± 21%  perf-profile.self.cycles-pp.set_next_entity
      0.04 ±101%      +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.09 ± 32%      +0.1        0.19 ± 19%  perf-profile.self.cycles-pp.enqueue_entity
      0.08 ± 28%      +0.1        0.18 ±  9%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.04 ± 45%      +0.1        0.15 ± 15%  perf-profile.self.cycles-pp.update_curr
      0.12 ± 31%      +0.1        0.23 ± 19%  perf-profile.self.cycles-pp.__send
      0.00            +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.cpu_util
      0.12 ± 22%      +0.1        0.22 ± 11%  perf-profile.self.cycles-pp.dccp_write_space
      0.13 ± 19%      +0.1        0.24 ± 23%  perf-profile.self.cycles-pp.__alloc_skb
      0.11 ± 20%      +0.1        0.22 ± 14%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.03 ±100%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.12 ± 10%  perf-profile.self.cycles-pp.smpboot_thread_fn
      0.10 ± 37%      +0.1        0.21 ± 13%  perf-profile.self.cycles-pp.available_idle_cpu
      0.21 ± 22%      +0.1        0.34 ± 20%  perf-profile.self.cycles-pp.wait_woken
      0.10 ± 13%      +0.1        0.24 ± 18%  perf-profile.self.cycles-pp.___perf_sw_event
      0.10 ± 10%      +0.2        0.26 ± 10%  perf-profile.self.cycles-pp.update_load_avg
      0.12 ± 27%      +0.2        0.32 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.17 ± 11%      +0.2        0.38 ± 10%  perf-profile.self.cycles-pp.__switch_to
      0.18 ± 20%      +0.2        0.40 ± 11%  perf-profile.self.cycles-pp.__schedule
      0.22 ± 22%      +0.2        0.46 ±  7%  perf-profile.self.cycles-pp.__switch_to_asm
      0.01 ±223%      +0.3        0.34 ± 15%  perf-profile.self.cycles-pp.intel_idle_irq
      0.08 ± 48%      +0.4        0.45 ± 12%  perf-profile.self.cycles-pp.update_sg_lb_stats
      1.64 ± 11%      +2.0        3.64 ±  4%  perf-profile.self.cycles-pp.poll_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

