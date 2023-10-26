Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB077D7DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbjJZHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:38:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5F184;
        Thu, 26 Oct 2023 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698305933; x=1729841933;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jcIF8hTieIxX0HnXPHF4xImq6jCa0TEAIWvfuQZEnpc=;
  b=n2q9cXfhuSNCO8YCjku54a5P9sKPoi1JpNSh3wMpyjw77y5PsJQe52RW
   YPFKnxwx/USb5nFalaGG1HSzgpkIvPH1fF95ldQFI6Yz5234tldpKxIqB
   YxNFuJ0F5uJXiwhhxedIjCsrl+rwaELzyVDpwU3W/rv3db5XepVxfjU9a
   8VwIbhmJXUf2zT0MqKYiQ409YVaYC87cg3KAxmSgRXPou/ZgSx3NfDYwH
   SqguixkKvu3nKVIqCpOmaT7EmE2azFFkFIIuznA8oSZ9HH1V0qJJuA7y6
   F5PWAybhsddf6l9fb37xP/ERALuXVH7JM89T27FmRTzAGiXaB1QYFdjE7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="273390"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="273390"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 00:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="824890512"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="824890512"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 00:38:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 00:38:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 00:38:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 00:38:51 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 00:38:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUDOL4sj5gsuR4sAqrU7E/ouae84P4cBRIQnk1JnBSS4ycKkzqqcj3pgZ0TI20mj0SKrELNe/0C993pBvTnBJTX88dJw1ioNGd2D+gJhrIW5LGhZ6tQ1p/uTrDfRixG3WXdGfy8mKgiMPZqKUjcCP3pWqslYF2EKWJj/bfTvYmzeeIqE3V8K/3nhX1I+zjcPAu9yXYwJo5SODLmLc32zh3+s1IPEl/0O1ki1yQRHl3++D+GIq0aC1zSQ9qPWHKYBW3oopeESy7bFxzgBfV1VdIVn9SpeIcf9Xvogu5+T75NsNoRbif/7qCVJ5h3ZLy5wQUC9ijIPCFXV1Z1zjDXm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Os/Jy1Jlm+l/4ueSjSsXbow1/udDgRqQQlM1ApmKt0=;
 b=FpJAYmTQUjOFutAgcV53pAm/uWbflZlWlM6nPYMf28Jy2/OtPQgD3Vx+PmjvaJcJUtBVSIZMLeQHNYKrYdCRLVzwYrZQc/+OUy/3wHWKVHy3+LuTZl1Vepwe4MJJGE4XFAzwR2O8ddVkrnlnQBEM3D2Wgcf6vxTfG+iYcXZCayD70zQBtpsDgavxfOGQkVAF6ntSemvxDTNsZW4LaqDVTb3tRSUcqfIzRaFwf3WJ/2clBk+kJJTr2IQG6c/ANlh94LblCD9INRC6572pgxJeKzH/tXinDZKOLLepKxNJD13erAE1DXKt6bDWncdeuJTzJkTZOHwxD5lmHusbUyVMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 07:38:44 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:38:44 +0000
Date:   Thu, 26 Oct 2023 15:38:37 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Max Schulze <max.schulze@online.de>,
        <linux-wireless@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [wifi]  37c20b2eff:
 hwsim.wpas_ctrl_signal_monitor.fail
Message-ID: <202310261527.66167d98-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b67cab8-0f9d-4738-ea94-08dbd5f694e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5exRfVAky0Rp02nsOimWBoQe2yxBKdW/DERYDHaDpCykRONfUwl422qqybnjFpFxrDPBLa6fC5AKZgj+T0RYRh8NB3QC1/PnDaCDlyiAorK7MGTV/XluU6MSc5QQ96lo+kAyF9Sc9hY+x52qA93VaSdJQz6+XJydaHkPE2I73z0Zsakt8FCXT7rbNytmu7iaVQ2p2v++VdR8BhyhvaythhOgEP3y3gxnC47CrtyPb3cHO7YVk1Xse8SsWWa92/SEgO3FqX+SbUvZE1xmHQAauzVj4fmlzE3ciUY2Tx0HIAR/B+wXcN+lOIepmGGyfWjME1UVZftNU9uPHJtqn1LzFO6x6nKUWcAXA8Sz00u0RbFiZIm+Z/MZoFiTSH77fZ6qx7aE3MjLaJCTNrHsOxInk/k1dYbw8jyI/YnzU8djjOJLDR2vzPRuUacgYsOoMvKr03tiZOYKvNhw25reT5uiqrcz1zUpTsfQe3hFU7teQVqBiNgltbE0CyKrMxQBAoVRaYZ7jbt3ndy5L88UaglO/XShM1fsfMGYmfp0G/NyI4FLrRRI/oJH9W1qyNXv6VRUx6ogzMSW5irc4puhN8adgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(2906002)(83380400001)(8676002)(6862004)(8936002)(966005)(6486002)(4326008)(107886003)(4001150100001)(82960400001)(5660300002)(41300700001)(6512007)(86362001)(6506007)(37006003)(6636002)(316002)(6666004)(1076003)(26005)(478600001)(2616005)(38100700002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lTUEdcWVQ/BTifFKYNOIgLCCEt3YhOlYLsAh+UYH/Bk9aFRiF3W/p+RLICR1?=
 =?us-ascii?Q?u0Q9ly+A6csV/MLk1LvZwPCGGXPcJkg7CUdbf0wZMvFL93nXLnabHe3YM6aY?=
 =?us-ascii?Q?Z17YX056D4OcRYELcjg32z1pvfXe6JysLhFjet2+OPkGemEpbID6knSdXsqf?=
 =?us-ascii?Q?nexbyvCN3EaUfkIi10Kdd3iRUkWPQ9rDvM37Pfz1zyi7L17NMn8PAXrmPFi+?=
 =?us-ascii?Q?MVsIv9iz0q5yzzkLP3WTCq2kqURIdebMH41KmDR/ADqiMy+urh0B7JmQ/iTb?=
 =?us-ascii?Q?r33iNqVIMAWfHzWm3f6oEJl/WjhgM23wswVhZQP6EGM/VgKLaw4urSV/hzKm?=
 =?us-ascii?Q?M7DMbAtz+FZX9/FlaZhXE+Xicaxjy+9hrom5e7336R8Rq8yT47WbH1XxevYR?=
 =?us-ascii?Q?Q+p5ubp3BPvRohACT1/1J6FNJefuSErcclnVPu5VghLQ72Y5ziPpSr13pNgG?=
 =?us-ascii?Q?izlDXdaPg4TqrSjmdgVbfqOQM6GpS+uZ/JK3dJofzY7Y6pN848giO3OMevbl?=
 =?us-ascii?Q?5hiuizJ9xicn+b8zRY2wyaTvJaHSAaX/U4i6x8Qy4X2h7wsNk2DbE+WSYmZv?=
 =?us-ascii?Q?+71hhY5ufVH23hLjhozI7G5nB8wnhI4JGwAOEOOsf4bkBCQhV/+XX7NMfzbr?=
 =?us-ascii?Q?5hVpXpwXZSWTe/kKU4m5i57Tohznyv/jS82ofpuJUQuNfILOMSij8iChL7HQ?=
 =?us-ascii?Q?fYe09PYQxUKMyBLnmEPS+u6ho1FPkuv6BQWVHaPs2r/uTTaLBW9MjPBdsBtF?=
 =?us-ascii?Q?YGXlmzvVMU0PgBE9uETWc5lZHWKfZbzcoMCapWHoM+eTVCgONTMfZ7kiw0zS?=
 =?us-ascii?Q?CXCHlMt1af/r1Rt2blsWNV26mlIY5TUaMJ1wPn5L3b/itMpp9WPO3V1fLa1P?=
 =?us-ascii?Q?8+b3hkREgNJhh/JiTDemJGpS9Nw0XiKxxNTptclbvxY/+nXlSRx9XUBaWRrR?=
 =?us-ascii?Q?SQ0wtcnktEM6ZoBBCxoJ8nvR8Rs8W8yIzvzz+oNC2N4E7CssaRVMENiwEs1A?=
 =?us-ascii?Q?tftfhjUYbkIk8pKaukiX6vkj3jG6GC6ahL2weVCMfUw4DK6509tQrMp+rzOt?=
 =?us-ascii?Q?oTPHqh1RbjK56rRcaUqiLefScqTnEieZ70SPBnRXLELuCxnkLEY8Z+KxTl3N?=
 =?us-ascii?Q?piFfQxmwRU5/wwmjJi6XN9C8oAWplmsKhQkXtwqYXXulRk9qh1TZHv9ZyWHB?=
 =?us-ascii?Q?YMV9EvB4Lv6VUA9QtsYazkgzyeCRGM5klCuxbG/C70mnJjwwJ1Mndt8R8Qpj?=
 =?us-ascii?Q?+AzJ5QA2jaxClBfObUWrvFDVTokvY5hCYdH9I6+SIScidG2qNizZJOs9WhqX?=
 =?us-ascii?Q?zjPMUTwGbYXDo91+d/0XQfWfRtQOvpK6uXce0bRt/0Zr/26HJ5DID2SXq9xh?=
 =?us-ascii?Q?rLyQ+bBy2j1s6o8qA6o7g0LNO1td0K1B+hbXm+OhuLIskELVSkP000zrU9EX?=
 =?us-ascii?Q?ONyG9/0k7+ifDKWfZdm8jnFgd90Ti+9e75g+DGssJV3mXWdWMY8nxncCyue+?=
 =?us-ascii?Q?wUpY8540XMzgrQxgEQA1aDASIrDKFk6GVXc9g+zXfnypWZczXW2MuJcRFb5F?=
 =?us-ascii?Q?MUzRFcARXH6mq84WOFHQ/wEV0uUQuqN3i2xkowFbQZu1pBSKtNCV5ly4ozc/?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b67cab8-0f9d-4738-ea94-08dbd5f694e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:38:44.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwnE5bViw2oso5I9xwMNzefScQuS0gLwe8l+C0sbzQK8CC20dX4XeByVrnBoUNCqjULZZN5Mf+DBiyQSmISEBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "hwsim.wpas_ctrl_signal_monitor.fail" on:

commit: 37c20b2effe987b806c8de6d12978e4ffeff026f ("wifi: cfg80211: fix cqm_config access race")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 9a3dad63edbe9a2ab2be1e7361a2133f519f855b]
[test failed on linux-next/master e3b18f7200f45d66f7141136c25554ac1e82009b]

in testcase: hwsim
version: hwsim-x86_64-717e5d7-1_20230720
with following parameters:

	test: wpas_ctrl_signal_monitor



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310261527.66167d98-oliver.sang@intel.com

group: group-07, test: wpas_ctrl_signal_monitor
2023-10-20 08:52:44 export USER=root
2023-10-20 08:52:44 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2023-10-20 08:53:42 ./start.sh
2023-10-20 08:53:44 ./run-tests.py wpas_ctrl_signal_monitor
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_signal_monitor 1/1
Test: wpa_supplicant SIGNAL_MONITOR command
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
No signal change event seen
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 531, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_wpas_ctrl.py", line 2021, in test_wpas_ctrl_signal_monitor
    raise Exception("No signal change event seen")
Exception: No signal change event seen
FAIL wpas_ctrl_signal_monitor 12.266827 2023-10-20 08:53:58.780133
passed 0 test case(s)
skipped 0 test case(s)
failed tests: wpas_ctrl_signal_monitor
2023-10-20 08:53:58 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231026/202310261527.66167d98-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

