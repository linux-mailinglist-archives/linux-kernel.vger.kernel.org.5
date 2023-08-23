Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99F3785B46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjHWO55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbjHWO5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:57:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36069E6D;
        Wed, 23 Aug 2023 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692802674; x=1724338674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DFb8y/WWBlVm9LrlbNReB3dlzpZCAAmEHRfhBgh8Z3M=;
  b=X0mzgH0YitkOXFs20rTedwFa1KMcTQe5mvSGctCTgm94fCMJ8qmbpiMn
   k+gwnmLo6jrrpvVNPHeH2IsZTXDOhcvK6USY6l/MfDyQqygzkwkE2h2R2
   2U5MXvHksArmXT7OrY6Gb+9mCq7/1XCmygF8PXfmWku+6Nd5f2OZUDJz1
   wyV6pLD4OVoLFzfsH1IZ8RJ5Lf8Ntwn8acceFSt01d5fYKd+M+Dz3ZKm1
   pXIir6TAyjQDl0MKTE6ryZmmghzl6jhyl8oKoMDF49k1OFHkCx4lmD/xW
   aVDwJQCsyCmmYKUZ865t9L8Px+sTDmAWR5xF3LqDE0u0WFUPXnltRZPJ2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="354512780"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354512780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 07:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="766155106"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="766155106"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2023 07:57:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 07:57:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 07:57:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 07:57:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 07:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUcGALYp9RIjOxkbYTwc9O3wPaMmIvfQD53Od/aascdB8e2tHww4i7DHKT9/G+oAYLdywJ8I3coY5FCLH+UiYmR63FJrad6udDwKbXr8Ynxw5l22FdB6glicvKHXuqEzGT5zJ+Ta2Vz8vKIYetukuLNmLUrQWIgNoxGnvmgjnvABbKE0NmEo2lCFetbnBCEzF6NVvnFZe0g3MVRJkhteBKElykcZRoa38KRzW5x8MkyVvM26rOf/CdGtw6ZUve+TVdPogiIj2r/+WJXb8wQk3sdRPZw7yh3cUBYuwt5l6hdF8IoNt1ZQ6KFrGzeVpI8zoZgnOhqq/DYVrGFFtsk3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXbRwpX5E36DKiPxRnbIkefE+CimkkfBzKKGKDyREi0=;
 b=iVdph6GA5rumi69mY3wZ0fyAN1zWL8RmtL5mNSK/XOr0hP+R1IjoCLIzyH3ht/KvSi5i3qoyr73R0Z+Jp84vVR6asAXeS1tWtle0dunqprHHKrRzc2mDArhtxjHKwbTR9S/i76swxZLWOTqriOyUKjOR0C9xi99CxW8EoKwX1QgEvoOnd3KGc6NkpswSPs73LpHWBTntkxM+Izb5ze2rqeX0pndp9PLeYbG+dhAWG2MY2/wBVxCmllfpkow505e3q0/tpFODYt74Fnn9yhcCKGzmBPYGCQgXMZkaLGxXTfirTlGylIWszbkfy6vCOHFo4UfiUFkbr4k/pnahNIlHXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW4PR11MB6957.namprd11.prod.outlook.com (2603:10b6:303:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 14:57:44 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:57:44 +0000
Date:   Wed, 23 Aug 2023 22:57:34 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [perf-tools-next:tmp.perf-tools-next] [perf dlfilter]  f178a76b05:
 perf-sanity-tests.dlfilter_C_API.fail
Message-ID: <202308232146.94d82cb4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW4PR11MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b228ec-daf4-4d12-d9b5-08dba3e94e62
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITHa2TnH8lW2c2w7Y6gcayEzRu2YAivlPcUW15n3SlhjzLLVeurI86E94gSbKXWHYwrMH8UUyEvrp3jhvIuDKODAuld/bY8OOo43fCJ+rPCeheUoSvhwQcsZqlPJAxQrnEQBebkDB6YG7cu1GS/i7v1DSLlvK6DWZlOk1ufTlxJCBJAvAMUUHz1fp+dC7WWxfU/9PvpYDznQ+QeSgQXUcCCljeUdJjJdFZvyC8Ph000rpSHKRV0wTXTsi7obAPFbge55PKC0WLXyi8F6nOPdqO0WPuKg4TA9amkzhJIZBCba33Irp35Pynxn/HO8RoEXn8vH24LINoGwTCMoiLZRfBQ2ozOeYZgbOtgbiJMa4fln+hpvDWZtmHGKpQkIlcmcwP21W8HSW9DMqj1sr1m9BHRYAPLf8mdieglHTr3oXNTVBGs5GOdBfb/4tZpAvHyt6ivsetDu9lrMDmD1BMzQtK34TPuxDGJHYB5svb7KTten5TsUwoqn7gtQ/pELgIAqWhv7Jnbad9m0hgBSMauggNYmdkAi8bwMQGHkjlHbD7EonEcgcIfw3p0KIGTbV9DpN7IKQlA8FjjbyC21VAIAnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(6506007)(38100700002)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(107886003)(8936002)(4326008)(6862004)(966005)(316002)(66556008)(66946007)(6512007)(54906003)(66476007)(37006003)(6636002)(82960400001)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GbVIELenSwrFt9eJGURP3HfYtgEu6yYvb+1kBkyilq2v/tYl3XL0SazFpedS?=
 =?us-ascii?Q?ZHs8vbNH1Hl8AiCW4/184k4OubPZU7tROkxLttigIXk7GEhrlXrLqSy9EPdI?=
 =?us-ascii?Q?fZCKJgrm9VvQExP+ptDE6jW27TasJOh7jO4t8jE8/ieRQ5RiqjdSgC31/4yL?=
 =?us-ascii?Q?THaXGoKkmtSGZxoQ/sTnv01apzBQOM1IQYlBNZcxm7Dx2JSrYE7i6QlSNbb5?=
 =?us-ascii?Q?fv3lYvFIlhLYNC/GKVYSTyUDXnkSkfrm40qADLxu0X/lCKEYXAa/nschSoWC?=
 =?us-ascii?Q?yzykVHKT+oeKBumBQW4LmUuWhL+rXsFnp+g8F0rfaaARyxo3kFlD1QLEy5dq?=
 =?us-ascii?Q?ygT2e6blA7LEWqDGwnj1Dqvi1XxxeEWTpLQVpnbNRjI34tPkpKNAeYwSkZpf?=
 =?us-ascii?Q?i4kuAOnetS6Fmvj0eOVbmC6KlpdPqDyE2GFdLErYVKHoXPlNdRTr0T4SmBKZ?=
 =?us-ascii?Q?wa4v/qUfzcLI21LCNbWo0QgQk2msTG/T0+86U3cmRuVm0oDI2yBwIdno3SVB?=
 =?us-ascii?Q?Z1IeEXy5viQn4Yu01c4j97WjQFUW/LnxzGQiCKqGv5B0SHMcTyoK7n2Y7uhE?=
 =?us-ascii?Q?4cCf9StiLwGCIMJCIYbSk5kdvu0lqeYkEO07yBxCalRU2WyDdBN8a9EhOPK4?=
 =?us-ascii?Q?IyrUPUtfMir1QNGk8/ziU9+bpyVEBjJX6Giwy67ebvmSDQbpNDfwLRyOF3pa?=
 =?us-ascii?Q?78plDXv5Pdfi6MZsImU/rARWz5RfI7ROvx+oQzgExIM1ALY18t6qT/SwbQAR?=
 =?us-ascii?Q?a3GJmG6rADQg/DOFulAIma5iOTFun9EC7yJYDvUUqmlU8LMCI11LaPlhLrFe?=
 =?us-ascii?Q?qDmZ0rGxOgnxFSQHjgTuL+mfkcqdF5D6OX21uUuP2UBVXumLfLEsjpvYVM2f?=
 =?us-ascii?Q?tajjtrBWuRy4nGXWi4lUVK4Fyht9gOk8Kj/hwAVjowSwP2MlEon6IqLs9xc4?=
 =?us-ascii?Q?XU7ldNl2pASbtqk1/ozWXz2IOiNPRYOyL50ODyX09+DJxGDQl9zAE2dEESBV?=
 =?us-ascii?Q?ZnF4d+2ZaNk+j7J2W5jlWDY7+eiS+NgDLqzCE7wHWq3FyJn6b4eyfAkTsvsI?=
 =?us-ascii?Q?rX+PDXPx1RO4IREXJj8Kob0GU8hEWPs5npCDhU/CsocjTNu/gn+gZrfK9Nye?=
 =?us-ascii?Q?uVw9qz075v7orSO/8kKcW+IKvyChYIhn9n1l6U3mhyFpRBxyJEtbU2uqaqKx?=
 =?us-ascii?Q?myNP57NiuawD9Szo6Ayx3d0wBgUZqNELk3BKbZvvQEjrOpwO+/vmM8OztcnO?=
 =?us-ascii?Q?4WGyHOCEWxxNcNFK+TR6r8JH6Twevye4xFMFeo96jNvUWCoj0NF76XnaWSSw?=
 =?us-ascii?Q?nlUUljTMzOr6HDXQoGX+lEnQY4rREZ1ItDAJh8VYJzoubKP68Pdq+3BV/BIL?=
 =?us-ascii?Q?hYlHsSObn7BKQOBzvy8ObaT62EZVT07EmGwppqLLpcqXKpTeMAcswpFPtI3m?=
 =?us-ascii?Q?EtOVPAS+G+V70PnNF7DdJjsNzS9nXVFJLkulbeZ61Th8H/43QhBAbvPHIqxH?=
 =?us-ascii?Q?MIwTfKYPFpfOjCgEQv/AHTv3VNp+0a5/ZbatBtOEPYnkZ2g+vE4Zkpxnjz5n?=
 =?us-ascii?Q?VaPLHJdCJXkaw4NJBAestlTym1cPWppSfGLKjGQSyYCdT2t/FaRP1jOPuEGq?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b228ec-daf4-4d12-d9b5-08dba3e94e62
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:57:44.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NY1eDV/XN9scjXVq4ScB28ibPtb1GgXil7N42hCVTA9x/z4/KkV9nu7LNb8o0S9kww30PJnt7yeKzq0MnDqwUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6957
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "perf-sanity-tests.dlfilter_C_API.fail" on:

commit: f178a76b054fd046d212c3c67745146ff191a443 ("perf dlfilter: Add a test for resolve_address()")
https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

[test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]

in testcase: perf-sanity-tests
version: perf-x86_64-00c7b5f4ddc5-1_20230402
with following parameters:

	perf_compiler: gcc



compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308232146.94d82cb4-oliver.sang@intel.com



 66: Convert perf time to TSC                                        :
 66.1: TSC support                                                   : Ok
 66.2: Perf time to TSC                                              : Ok
 67: dlfilter C API                                                  : FAILED!  <---
 68: Sigtrap                                                         : Ok



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230823/202308232146.94d82cb4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

