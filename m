Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFE47F320C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjKUPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjKUPOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:14:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C650BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700579668; x=1732115668;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=NUMexl6COsvbcnawRxL3tOHrehBNqZ8kHiUJK5al9gg=;
  b=GCrXMbz7nfAeUsnlLBqGM87TC42DecUr1PMZMZ1+VhQCs0Z3rEWRW2r9
   D9iy1PLjdCJOLIh0UgQv0rDF/yMtnCmdrsAn79hHSylvz5zoaSHJ+XCoP
   GlbFCI3PVEpogNRzNxIySZJk45FupA/DEKEQDE6Ar5KSGq+fLgjl8JCxE
   0J/CLn3x+rc5/cTLBSptfGaea0YHfgXFWU4zo4UtLm1zP/N6x+OtYe3eY
   G3HDopppzDzb1Pl7f8QnzJa0jiJBno0CbN6AfyOssw6Ke0RrsqO8352j6
   uLcR84etWDfMGoi6//BmRiHmGT+HDPVwC4WWEcLh9T5E12QYykguLfWLJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5054142"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="5054142"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:14:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1098086503"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1098086503"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 07:06:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 07:06:45 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 07:06:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 07:06:45 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 07:06:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDR2Ud3qWQeEIakj1pEAkPp1IxUIAw+pkTsDWUSA9RLL7DeSqN7zr5cLAFYFrU7YRs4hO5BIsDpdhjgt+wsdEmTjGwOZfEgTHDb5s9W6yqXoA9BbX1ATPYFgKSLsHYmgZqJvtNTIUePFQ6imFV8RrjzFlcOEuCKDkwwTxTMjGS/AFO91tu3UsnDdca5+z+ku1JCm1xjcQz7BA9hW5XqKTZ8+GAjru6kXQ2F/uBoolQj32BZN/CVkkKKjYCIQ1ncQAwSBBTHK6/jejjC7qdzt2+c19iCRG4xCI9RYd9ediWZ7ZZ1isRLAginvtP+xDFEe5ODcD69fs1zvtgcw+lp9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeRixZSkMt3efANI/S6yjwl1zgzLfeE0WBQ58pJ1ir4=;
 b=jhxdGDUb1Qtabr1GxpDqh58kKe2AT7mNLIDHBWqNuXX6sIqCzwHlwo+vqUZFgDKIgiT5LQG9Xq+jEjkUJWTNdp2CgQvsZ3uB34h7G/6vf5wM/uAdecutUFojCsAK+XPVJY8vC+wiFNktBxvpG4neV0+oTm/3M9/ko5Wwpd77EeEWA6ETIugXnc7IWaWcgWm7FFyHc8/lukxiwvvXErd9SjVYorFCjidt9q7z8N2JHXCJCyhcD8paAVEHQ1+9ivXjDHsvx7oRmGCPptsO7iLIXYGUxyzgMxPMVHllQZINO+KPEJVPAfALOMSFOnViv55TdRb2XHQ6muOSxpQynnRHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 15:06:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 15:06:42 +0000
Date:   Tue, 21 Nov 2023 23:06:32 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Juntong Deng <juntong.deng@outlook.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <kasan-dev@googlegroups.com>, <ryabinin.a.a@gmail.com>,
        <glider@google.com>, <andreyknvl@gmail.com>,
        <vincenzo.frascino@arm.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH] kasan: Improve free meta storage in Generic KASAN
Message-ID: <202311212204.c9c64d29-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <VI1P193MB0752DE2CCD9046B5FED0AA8E99B5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b623d6-98e5-48ef-58ee-08dbeaa3783a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAgiUK3COVTYSJe36Lf4gjJi7ptv///+IW58b54o6Dzv6zUnwK/mRAFwRBdIuPYXR+/TwJg3h/2z8cSCfGzy0BGY2av2Doxsw1ePLxPaR+siBnDU888MHfjTMIQd3LGUI7EOIQgb95j7vhQKFC9A7gcRDUVFr02kAlpmz/R6tzuZJp0iafMmZiDDdYaP74upbNMQHvuZcNNFKzCy4dCTx9bPyEAWeqO8cEfdii4GjZP8Lm9ZISbHHsNsGVWreYLaQL+XYRsBmmIEQxq7AiDKDhh5kiIOdoc0KN/O/eg8ltgybBFVYLKMXclQ5Fs9cbhEyqub375T4ZyrsdKjj0zsUbRMtrApqUWQYE0Tih0bx10VVzakjWKIyp5dSstXFcKvUgBLyCPQU6VhFsYw5K94SVvWQOuE5K5woxOZLwjrL8dyzpPcGv2TUinugsj0mMz2OS2LgKn/FwcpduuewV7N4vrD9jT63d9WAk4zo5hyQNecgdUBCmAwLb/uhwNQEwFg7OifnzdUQc54XcFGJIBwg7G53lD8IkRUoxs1Pwr89WouZsjTamO376Z8Zng+oiWV37HNBXLROku49W1pMqOoi6MWZcaEyL4QUq8kxAx/q6hWyM9HD0JocKqeJ9y8iRsX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(5660300002)(7416002)(41300700001)(8936002)(4326008)(8676002)(6916009)(316002)(66476007)(66556008)(86362001)(966005)(1076003)(45080400002)(26005)(107886003)(6486002)(478600001)(6512007)(6666004)(36756003)(6506007)(2616005)(83380400001)(66946007)(38100700002)(82960400001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w1NdzdDOxwAmH5reYdNmnHPA92kh9uYv1+whx2Ur75JzydI/ERLLmdLNiJqj?=
 =?us-ascii?Q?Cnl/5RabQqEcMKBJYD5io5FuCln8M+IbM93NZOnE4Q0amx0ikfr/IcoBdukv?=
 =?us-ascii?Q?q4oui8AEG+zHFUBkECP5kBUIz5Xo29IJBYB15R9eGKmR+aNilGmo/A6MsOws?=
 =?us-ascii?Q?1/cU0tUuarcGeXXDffd0xgUxR3JD0QU7mu068LbiGXktHt4veq77QGpt0wZ9?=
 =?us-ascii?Q?59YF5igOdeIm0BAwqWya31M/Y74ykRdtOqLLCSCjaEfTi/vhcirDY5+eoUrK?=
 =?us-ascii?Q?nNzBN9eIf1MvpDjJmY2e9EkUhAGrcW2M6P2T9gC51K0mNfawQ7GU5qSG8hg9?=
 =?us-ascii?Q?eECZiXNXcrowmGaGB8tRpp9dMDnltu7q2FMmXV844atUbXBTB08HcS18KC5/?=
 =?us-ascii?Q?ymHmA62p/Sbp1eMUUzyBSF0HzhB7dA1pix29vZV0aqGOY2LmU/EuzUDiMlJZ?=
 =?us-ascii?Q?6ujuMOK+m8JBpMoDjFcd/YuNtKaU17oQfykD+ztYk6x2kijEA7OwyUG1jxv5?=
 =?us-ascii?Q?KN94x5OltbFdhCYrTSv3BJvlw0TVPCAIL6cJmCgG0HwWRTaQrYiJqERXoe7B?=
 =?us-ascii?Q?wSOHZPKIpUd9GZRuvdpKHP/E484Bv+oiqdoLeg0Jl8ub2jfkPAYDFrBvMMF7?=
 =?us-ascii?Q?baCMvO5LkkGy55LNz7+rVFJsk5Rxttg/Y84wfh1YTRr9yAUJQJbswCb5bMgH?=
 =?us-ascii?Q?0RG13vOyBXzGxtrYMMfYHLj+1VCa5gBKH2NnjisKLbv5npEu1MZXWJQpYCQ5?=
 =?us-ascii?Q?vssxM/J06Pi0sMZq0AmbmV2/YwvTMtiOUuFVdubhVXG6mNSR122/ActnF4c+?=
 =?us-ascii?Q?5SCbLuGosYl9qppiTZDoZ5aoATtDRVZ/BfrzreAXrhx6s1DNdkiCdHnQm5oa?=
 =?us-ascii?Q?lhKvKbSPXBT0rXd/uup+DHze2uJmRrfpL+qHs3LACIONmWN6/qsFMTC+XX9p?=
 =?us-ascii?Q?WU/4l4Q+8EjzE9PK6Mlt+DSOxiHQMt1bsK3/8Aj1cyVOeoIKSBQIAMunpOu6?=
 =?us-ascii?Q?OWwlNNCx3xtY1Nn1+ss2T1g4Qb6EjCQPuExiXiruj77VmwE0KAVYURD5+gZU?=
 =?us-ascii?Q?AkdpvsihJ2OSGygUc5IMU5xPoDt7+nUVfeXvXdGoKG27g/HNDcfhgozQISLm?=
 =?us-ascii?Q?+jpArzjEGpE0yEy0kbfyG4SiwyYQfnsjxg4Bp8voF6P5oNYH20rmquNvwxu8?=
 =?us-ascii?Q?/YIUBGnVIq/0tt9x7oeM5FQdpaHFnic+GcHNgWkAVFTVGdHq2nRg1XRO+Yj6?=
 =?us-ascii?Q?MWEBSeQqInO2ldDahzxYFFjxYvju2NwVab5B7znLJVW4DS/88pV5NnZP4546?=
 =?us-ascii?Q?+VuDsjuyDqGsrVrRrxDA6XDwNAs58ie6XgFsYss9Rsb74xyaIFfE8HmTkCpj?=
 =?us-ascii?Q?buGaRHrWF+/rGDLvWRwi28hMw8Wdi0iMnlLFDeuvUJTD1YlvCLy065vNg9jd?=
 =?us-ascii?Q?/1nZqDNzKCeB75IOJlgP2cp1WOy5shrLQEoV719QWEeJ8OITMGg1hwyzb3CX?=
 =?us-ascii?Q?X92yJdY5PSccl1vIHOKk2s8nlWbxLAj/Ol4k7IdBeWHEFkM8jYDV62C+oILT?=
 =?us-ascii?Q?jBU0LhAW4bRLdUUqWjQkzlvG6kQ+dl1ejoschJF3iDhOPpqTSRhCKQlTyC4/?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b623d6-98e5-48ef-58ee-08dbeaa3783a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:06:42.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRh0haXCL1gPKeura3Oex6shvxlvkZqxDEW03Vfvdk0bax5zXdxUXmYKqs2YkiV1Y7J/zaVoZU5ZedpcIZ7VEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG_kmalloc-rnd-#-#(Not_tainted):Object_padding_overwritten" on:

commit: cb53c2a822df305ec84b291e4c4a348c7d394b89 ("[PATCH] kasan: Improve free meta storage in Generic KASAN")
url: https://github.com/intel-lab-lkp/linux/commits/Juntong-Deng/kasan-Improve-free-meta-storage-in-Generic-KASAN/20231120-044846
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/VI1P193MB0752DE2CCD9046B5FED0AA8E99B5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM/
patch subject: [PATCH] kasan: Improve free meta storage in Generic KASAN

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | a350566908 | cb53c2a822 |
+-------------------------------------------------------------+------------+------------+
| BUG_kmalloc-rnd-#-#(Not_tainted):Object_padding_overwritten | 0          | 17         |
| BUG_kmalloc-rnd-#-#(Tainted:G_B):Object_padding_overwritten | 0          | 21         |
| BUG_kmalloc-#(Tainted:G_B):Object_padding_overwritten       | 0          | 21         |
| BUG_kmalloc-#(Not_tainted):Object_padding_overwritten       | 0          | 4          |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311212204.c9c64d29-oliver.sang@intel.com


[    1.104299][    T0] ** administrator!                                       **
[    1.104884][    T0] **                                                      **
[    1.105469][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    1.106054][    T0] **********************************************************
[    1.109891][    T0] =============================================================================
[    1.110637][    T0] BUG kmalloc-rnd-09-8 (Not tainted): Object padding overwritten
[    1.111258][    T0] -----------------------------------------------------------------------------
[    1.111258][    T0]
[    1.112154][    T0] 0xffff888100078074-0xffff88810007807b @offset=116. First byte 0x0 instead of 0x5a
[    1.112904][    T0] Slab 0xffffea0004001e00 objects=30 used=1 fp=0xffff888100078090 flags=0x8000000000000800(slab|zone=2)
[    1.113798][    T0] Object 0xffff888100078008 @offset=8 fp=0xffff888100078090
[    1.113798][    T0] 
[    1.114555][    T0] Redzone  ffff888100078000: bb bb bb bb bb bb bb bb                          ........
[    1.115329][    T0] Object   ffff888100078008: 6b 6b 6b 6b 6b 6b 6b a5                          kkkkkkk.
[    1.116098][    T0] Redzone  ffff888100078010: bb bb bb bb bb bb bb bb                          ........
[    1.116868][    T0] Padding  ffff888100078074: 00 00 00 00 00 00 00 00 5a 5a 5a 5a 5a 5a 5a 5a  ........ZZZZZZZZ
[    1.117691][    T0] Padding  ffff888100078084: 5a 5a 5a 5a                                      ZZZZ
[    1.118432][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.7.0-rc1-00145-gcb53c2a822df #1
[    1.119122][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.119953][    T0] Call Trace:
[    1.120209][    T0]  <TASK>
[    1.120439][    T0]  dump_stack_lvl+0xa2/0x100
[    1.120808][    T0]  check_bytes_and_report+0x113/0x160
[    1.121240][    T0]  check_object+0x1e1/0x380
[    1.121599][    T0]  alloc_debug_processing+0x10e/0x1f0
[    1.122027][    T0]  ___slab_alloc+0x81b/0xdd0
[    1.122392][    T0]  ? init_freelist_randomization+0x11/0x50
[    1.122854][    T0]  ? cache_random_seq_create+0x49/0x110
[    1.123308][    T0]  ? cache_random_seq_create+0x49/0x110
[    1.123751][    T0]  __kmem_cache_alloc_node+0x161/0x1f0
[    1.124188][    T0]  ? cache_random_seq_create+0x49/0x110
[    1.124637][    T0]  __kmalloc+0xb5/0x1b0
[    1.124968][    T0]  cache_random_seq_create+0x49/0x110
[    1.125395][    T0]  init_cache_random_seq+0x2c/0xc0
[    1.125809][    T0]  init_freelist_randomization+0x2d/0x50
[    1.126259][    T0]  kmem_cache_init+0xac/0x120
[    1.126630][    T0]  mm_core_init+0x2a/0x60
[    1.126972][    T0]  start_kernel+0x156/0x370
[    1.127334][    T0]  x86_64_start_reservations+0x20/0x20
[    1.127770][    T0]  x86_64_start_kernel+0x59/0x60
[    1.128162][    T0]  secondary_startup_64_no_verify+0x167/0x16b
[    1.128652][    T0]  </TASK>
[    1.128887][    T0] Disabling lock debugging due to kernel taint
[    1.129373][    T0] FIX kmalloc-rnd-09-8: Restoring Object padding 0xffff888100078074-0xffff88810007807b=0x5a
[    1.130544][    T0] =============================================================================
[    1.131270][    T0] BUG kmalloc-rnd-09-8 (Tainted: G    B             ): Object padding overwritten
[    1.132002][    T0] -----------------------------------------------------------------------------
[    1.132002][    T0] 
[    1.132893][    T0] 0xffff8881000780fc-0xffff888100078103 @offset=252. First byte 0x0 instead of 0x5a
[    1.133638][    T0] Slab 0xffffea0004001e00 objects=30 used=2 fp=0xffff888100078118 flags=0x8000000000000800(slab|zone=2)
[    1.134524][    T0] Object 0xffff888100078090 @offset=144 fp=0xffff888100078118
[    1.134524][    T0] 
[    1.135292][    T0] Redzone  ffff888100078088: bb bb bb bb bb bb bb bb                          ........
[    1.136060][    T0] Object   ffff888100078090: 6b 6b 6b 6b 6b 6b 6b a5                          kkkkkkk.
[    1.136827][    T0] Redzone  ffff888100078098: bb bb bb bb bb bb bb bb                          ........
[    1.137596][    T0] Padding  ffff8881000780fc: 00 00 00 00 00 00 00 00 5a 5a 5a 5a 5a 5a 5a 5a  ........ZZZZZZZZ
[    1.138418][    T0] Padding  ffff88810007810c: 5a 5a 5a 5a                                      ZZZZ
[    1.139167][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G    B              6.7.0-rc1-00145-gcb53c2a822df #1
[    1.139971][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.140800][    T0] Call Trace:
[    1.141054][    T0]  <TASK>
[    1.141281][    T0]  dump_stack_lvl+0xa2/0x100
[    1.141643][    T0]  check_bytes_and_report+0x113/0x160
[    1.142068][    T0]  check_object+0x1e1/0x380
[    1.142423][    T0]  alloc_debug_processing+0x10e/0x1f0
[    1.142848][    T0]  ___slab_alloc+0x4fe/0xdd0
[    1.143214][    T0]  ? cache_random_seq_create+0x49/0x110
[    1.143654][    T0]  ? cache_random_seq_create+0x49/0x110
[    1.144092][    T0]  __kmem_cache_alloc_node+0x161/0x1f0
[    1.144524][    T0]  ? cache_random_seq_create+0x49/0x110
[    1.144962][    T0]  __kmalloc+0xb5/0x1b0
[    1.145289][    T0]  cache_random_seq_create+0x49/0x110
[    1.145713][    T0]  init_cache_random_seq+0x2c/0xc0
[    1.146115][    T0]  init_freelist_randomization+0x2d/0x50
[    1.146561][    T0]  kmem_cache_init+0xac/0x120
[    1.146928][    T0]  mm_core_init+0x2a/0x60
[    1.147272][    T0]  start_kernel+0x156/0x370
[    1.147625][    T0]  x86_64_start_reservations+0x20/0x20
[    1.148057][    T0]  x86_64_start_kernel+0x59/0x60
[    1.148447][    T0]  secondary_startup_64_no_verify+0x167/0x16b
[    1.148929][    T0]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231121/202311212204.c9c64d29-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

