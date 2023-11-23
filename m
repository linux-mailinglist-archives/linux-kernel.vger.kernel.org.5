Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB0C7F561A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKWByr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjKWByp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:54:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901CB1B9;
        Wed, 22 Nov 2023 17:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700704489; x=1732240489;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=JiIZcIk3om0ytY8sjlpHXpecX9/VksSguhx3aco4W28=;
  b=GwluxT4LrlwqdfOaMzs9zlrRpLpO3KvtvGiGsdJhL/ljXtXzXboSRllj
   pyg0dJTY3C5dp6lsvINeUWPphwu8R0wA9GcDDkJyrt8dsjZhZO0GBVkMm
   7Op3+NXL0k499rPR86bZLZmpgApk0n6uDl/xLvieLNVPEltJM7VgSsag/
   9p6qrqMnOudfEPBGmkfUtc9AIQgAFSKw/BiDMfry0vgjShsPxfmzmW7lv
   qJ6NSxeNigtc52xLr0X06LI7STuyJ3tn0LfUghT0tTvAuEvEpCaFvDkHl
   8OAsmPYL3UblpmqPyrr98UjDgbdJckKNlU5y9OHfCmJ+8xMLgdXOxvlGm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382581075"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="382581075"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="796187904"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="796187904"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 17:54:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 17:54:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 17:54:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 17:54:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 17:54:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS5EY4ZZkXriC8PZsDJxnMxqCXXVo/NdtcNCvgawTI9w2mJDYd1/RZPv66pHk91ZMFJoJygR0AmIGwT1kqUvk+exJQirn0QL0ZYQ8T5hzMBRHsXFUhOCmc8GmHYw5SZpcUf4dKi1wALXz0xsNILu+fPacCSxwK6xY18waXxcNJzNo3Bttdstas6nZz6H7aLFpKcGBihGQyzQKEzafOphGtopyGvKTNpeWTLryI7Qix5W4bt06h2Su1aZbYFU9kKBlCuGHcjudmLvzPq/k73WSzgZSs/gtZM7kXJvHeD+k6xfeeBYzptb8VgweSKhAU29UN9vP3jbrv7S3kKqXv4zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbbBIoGwENa4SJ3MfYuiKz3GYulsX2FEJKD2mBXF5O4=;
 b=GelEoanSoXyNWX+hVKpgsbyiGrmMN//EE8EOqwYXNptoxM0MKsVUWK6Z9N1n1dBgyj9TkGyCe9pcxhyEWgq/gwPxzwnGE5pCMXjFno6pEgXyZV7WER6chK9Dgc6OybsNskMgcvI/vHzDCr9B00SWn6lU/ZE69oADbRswd16wfYqpvj4Rsmck+nHNCE21wsqHFG0WoFklMT6rbwCKSz2FFPJZfkWFSNkBpbpO0neemUIPPtUe3KTyoGO0wjs+glaYSNcmP+2fKUUdYiZvoyAtQMHmtnMNL7xLSOup5UOQJgrqysbEu3s8JQMbRqROoTZvbOwowzVdiLiE6Gj7EDatIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 01:54:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Thu, 23 Nov 2023
 01:54:45 +0000
Date:   Thu, 23 Nov 2023 09:54:36 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Kuen-Han Tsai <khtsai@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-usb@vger.kernel.org>, <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        Kuen-Han Tsai <khtsai@google.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue
Message-ID: <202311222304.1a72c7d4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231117072131.2886406-1-khtsai@google.com>
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: e55cef14-1250-44ef-6745-08dbebc72ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i651m6B3whf6KDvK9dGGy6t6Q20RJaKJ+OtYtgy7wRufFhHtfp6giUKQgsvSXKZH2G53X6CTJVT//uywOOC97nnHJdk9lORw1fJSXRiz0qfcgBz/I2zXJ1086EwMRqOIdtnUkaV6eR1n4LhIqeShB+wpy0HiBuUPjXNAP8vVMn/z7kszys/nZPSmE4XqlV+JDPJ0coy0e3AFVT0/PxqaPllAZIvThxLdP3TSV16e+fLz6EWF30qvNtI4Ccr/d5X5hzGCPM3zftatNQAvQZGNzBh19s/IHop4RvClpkDuFhp58QDpKAWABNZtOSp80cgqyvF62DEjidqjPNPar5Fs/D+wzYk1tn6Luc/LnsoWvJHhbuc6C3w+9z2Lytl4ZfMjjtYCH2yz5BEwOpbv9Bg8s8JVfaINLThvbsiTx02wERrk0PSpKB0xGk/Y4ccQyCCLz2D2LISKBjqLCGchzpVZsDyhjAkX6RfG0bRe4yYs6uFRXAldTM7zi1nP6E6FrVE1zzSLWP2c4jGv50Gl7SpytT0pVkdQu0DnU8LpH5Pytf0EUxjy/Ix6R2VOP1Oa4VKe+lqSu8xUyzHKmGou6F3eppfL0nwiflfIW/be4vj5i/nYGSbDHb0Iyde4WpTtrTwX7MkXnFHMNE6gZBzl6irwMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82960400001)(2616005)(6512007)(6666004)(6916009)(316002)(66476007)(4326008)(8936002)(8676002)(66556008)(26005)(107886003)(1076003)(478600001)(83380400001)(966005)(6506007)(6486002)(66946007)(38100700002)(5660300002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikqhmmgmYhX3lLrORc9ohAHIr+z/GzgMXCQAs6youKFzVLaimBMAhMo33NJP?=
 =?us-ascii?Q?hmKE1GIAeZOIyzjmNwXVdizkKsoCR/zunHy0qcqfEF4vSCVClJM/JEfOxP79?=
 =?us-ascii?Q?ijHCxhTa+vPX4xKGaTAFLiIHNUDZ5bH92KokzH7YUWSqPGubrEjQrRmbhwZb?=
 =?us-ascii?Q?Ro8pRFk6Ewzk0hSSXilL3BHmNqqMo3MC8ZpX+l+DVbDFgGg1jsB33g95ziG+?=
 =?us-ascii?Q?RWwNnYswMOagcl4lNzIMr8Vhrq4LjnTJ4cJfF2A6dYwvXS66UfH5p8GUmCSM?=
 =?us-ascii?Q?tqoA6ar9A/d2DC77CfVXLQwfWlsQimCbLD4C5gS1XpPvBDqE6RJBC3K9HEE1?=
 =?us-ascii?Q?lid/n9TUfT5Z58fBld2uMHLvza7pLR1K3001TmOCjvLSOqkp2/2p7QdEs+Rh?=
 =?us-ascii?Q?L5Y1uZnokNYeqGOuyeTvOit7wPBXnuKF1qQ7Tw3jpezWdtE4k/92VyH9mzFu?=
 =?us-ascii?Q?wy5AXscm8VS2gAo6Lyfw9aIlDuU8tkKHcIPtCsAUpSpl3h7VK9D5siQ/UKnj?=
 =?us-ascii?Q?2hkLJiCB9K9Wj4uCkjBZr1+awUa51mxtEgfzYWbtXp+7Lndz12VYHPU7lypO?=
 =?us-ascii?Q?U1b0NdGZY6G6rbWC4NaD6t/y/n5XKRavEJobXP1wudNzxPtLNqlRSEb26XhY?=
 =?us-ascii?Q?QC8o4UvTc2p1Dm3lY+fXqAG8cxcmdvotz1UApHFcpL59YD+MHBZkl8Dl1j9t?=
 =?us-ascii?Q?tLgHKYZwcctTMbGVrpd9wLPQMshk+dAUOB1acKX1mZgBuR3hLiO36Wsun34P?=
 =?us-ascii?Q?2Zxyzf0IojJMDSqJfwdq67ovWyVjhoW6TW54cgdmee+wkoaaarbdZE8QXp+I?=
 =?us-ascii?Q?qtD8YcD3Hss/eHbpxpTrk5Jp1enJFVgRfcvA6nnzjOQkFDTOupyDbNsoklhf?=
 =?us-ascii?Q?UGS07Hqscf7exviZpr94T2bsiROK7ThxftvpWzSehA/g8MyQ5axnPK3KTRyc?=
 =?us-ascii?Q?M+T3TXMTZqxs5nPGcFDwBR99rIdpY/32Bmle+j5LAaSJ94QdtDafypiFJw99?=
 =?us-ascii?Q?pl0yF9qC4/9ncdVuwYKtM4l6/snTozY8wed2nNcvRvBW2faYGt0xAc6cYIkB?=
 =?us-ascii?Q?TXGPZ5oCoNY2FZYTEi7cwcOMamE787iaX4Ga3kju77GXg3zfSPQS82eMYnL2?=
 =?us-ascii?Q?raLK7Z+MtBRWmw8xMPGaeTt5J9pM9QZbykFT8jnp/sbO6okxKwKUrL/8fbnT?=
 =?us-ascii?Q?XB9SvTUW5i/Cb0y7cIy+ZHJBUo4fPdFp5+ubPNJfNCUGaltvJ3sEKZsT1m1j?=
 =?us-ascii?Q?2Ws1vAfW+HLN/pKynYyyPrtRU+eLErCXiiojDwNDIkA/JyLJ9CvGEKTnFZIr?=
 =?us-ascii?Q?GpTzt/o/k0yGRU19OAzvS6zctuLx+yeKuH4SU/I/GqfPpNFJD5cWzr158uG4?=
 =?us-ascii?Q?34OtjkZA9It2y9DNRq9fqgzCc3xULmlQzmHdJm+6xgm7pSr+UlRHrAgvmHPX?=
 =?us-ascii?Q?ZCMnWjZc4j2befOZ8L22aBQCQfeldlswIncU6ItLfk8TvE1bZ4ARTpudAzGB?=
 =?us-ascii?Q?uYchfh/R1faxKLC0aZzW+AgACWYuM6dEZDQDf1n+cAVsPjh6BI9evaxRJFLU?=
 =?us-ascii?Q?MK0qJ0GTNwFyfQDQSwt5+y6YiFlt9FlKESb8x2m6bV//AZhKSaTmQEOaI4uy?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e55cef14-1250-44ef-6745-08dbebc72ab6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 01:54:45.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOTrEqpfxJ9gq7jilJjlVKbWrG0jaivCRM/XaHuy0Gk3cds00PwJW7egrZkLP4p0voW/6lgZ6DxywdvKb1t4Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:HARDIRQ-safe->HARDIRQ-unsafe_lock_order_detected" on:

commit: 90703e106b4214512828bff96df3df2ecff5c7b7 ("[PATCH] xhci: fix null pointer deref for xhci_urb_enqueue")
url: https://github.com/intel-lab-lkp/linux/commits/Kuen-Han-Tsai/xhci-fix-null-pointer-deref-for-xhci_urb_enqueue/20231117-152346
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git usb-testing
patch link: https://lore.kernel.org/all/20231117072131.2886406-1-khtsai@google.com/
patch subject: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net
	test: fcnal-test.sh
	atomic_test: ipv4_ping



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311222304.1a72c7d4-oliver.sang@intel.com


[   18.016498][    T9] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[   18.016498][    T9] 6.7.0-rc1-00001-g90703e106b42 #1 Not tainted
[   18.016498][    T9] -----------------------------------------------------
[   18.016498][    T9] kworker/0:1/9 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   18.019119][    T1] iTCO_vendor_support: vendor-support=0
[   18.016498][    T9] ffffffff84f96760 (
[   18.019656][    T1] intel_pstate: HWP enabled by BIOS
[   18.016498][    T9] mmu_notifier_invalidate_range_start
[   18.020037][    T1] intel_pstate: Intel P-state driver initializing
[ 18.016498][ T9] ){+.+.}-{0:0}, at: fs_reclaim_acquire (mm/page_alloc.c:3710 mm/page_alloc.c:3701) 
[   18.016498][    T9]
[   18.016498][    T9] and this task is already holding:
[ 18.016498][ T9] ffff8881e0b12428 (&xhci->lock){-.-.}-{2:2}, at: xhci_urb_enqueue (drivers/usb/host/xhci.c:1525) 
[   18.016498][    T9] which would create a new lock dependency:
[   18.016498][    T9]  (&xhci->lock){-.-.}-{2:2} -> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}
[   18.016498][    T9]
[   18.016498][    T9] but this new dependency connects a HARDIRQ-irq-safe lock:
[   18.016498][    T9]  (&xhci->lock){-.-.}-{2:2}
[   18.016498][    T9]
[   18.016498][    T9] ... which became HARDIRQ-irq-safe at:
[ 18.016498][ T9] __lock_acquire (kernel/locking/lockdep.c:5090) 
[ 18.016498][ T9] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
[ 18.016498][ T9] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 18.016498][ T9] xhci_irq (drivers/usb/host/xhci-ring.c:3032) 
[ 18.016498][ T9] __handle_irq_event_percpu (kernel/irq/handle.c:158) 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231122/202311222304.1a72c7d4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

