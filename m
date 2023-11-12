Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFF7E8ED8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjKLGj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLGjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:39:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3669F2D46
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699771160; x=1731307160;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/PmTgoT+ns7uyTWeGK1s9ELqykRNRD7rDmgHZswOvOc=;
  b=Oj8qjoizdFG3/CnYUJhq/K8B4CibnhNapcsddUictgCf1W5PKqDDcmUF
   nx+AXmDA4icO9+d3pRnUO9R2TY/DwszcY9x49L9tutyo5CjGCFEK0ehNB
   /XnhiZIaGyDOhviSQ/kdlLnpEn8eILpof86dzwU0mJAWx1N3TDCK8Tfql
   YV+QI+TM1PHKRySAuE7PNYvriENN9HjMePzlHd/+CmTIv+nOUZeZhLMO8
   +XoROVC4J1tyDoiN7QDK3F7+0+y3lZIi9B49TE8v4j5yNRHzleaasESyS
   9hOP9YxHjPma9L2pEXc+agcMsUMGgmLm8r0Cz0x4qZSTij/7Ha1JzRM2d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="421411257"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="421411257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 22:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="11793160"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2023 22:39:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 22:39:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 22:39:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 11 Nov 2023 22:39:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 11 Nov 2023 22:39:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rvg6d/k2UcTxJLB+JtpvAok695kdZcXib15ymP87Xs+bnvGvfRQGpyoKm/Bf6izlu7frQ0+8g91wzvbjbj6Ar0DLymTrouwM5LfvOyXFiUVv+iXWjIbFfdxBlZrD2SABLB1qzu16+55ovZJ3ILMb3Bkup/Szs0XQILYOocmFV12QGXhf0iUcIAAM8SWLTSyZdGiuMYPv6wdEN3LQ4DzJ38Whe5Aas0a8XZ0SOzpYEsbK4D9aBPzXUUmDvPG3pcpzEl43mtunJlawkxEZv4/wADT/1CRGTOuJdIyLLpktQrK7uhNDxVTTyzoySSePjoCwszEzeD88qZgJB95k8zc69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBmiixIecbfCXwiTiAvzjJRkK8+e3qcFt1uv3JJ+rs8=;
 b=mmjQ7RQqgdG44L6u5ZkO5KN26yMtnEhWINKEPxnXh4homyfH6Gy8h9YkmoSJaDJ4VZt6NDT0a7G38Zbx3MTrtwQGgfBNKPc8xFhkCmUETKVZngXEAGbKIVpbbvrmWp8WE0teuwIs2ZSWmhah4sfA52OKgwCrUvcUCC38S2x4DS7HZwgdrTg7W8HnfBRngAVuNt1/X5MlEO6PX/gtsvPd8RbtzUUuRxpUlw2ZYfmVYVnsIbJZNRdkXLqjJMEcynisLPmcFbK5C1E1k4Eann4hRK1S4SClx81woZC2IMRkO7ZuXxFlyG/RVERid1oAlzZJVzfU0m0MlSdbJHyX3hTkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 06:39:16 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 06:39:16 +0000
Date:   Sun, 12 Nov 2023 14:39:03 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: drivers/mtd/ubi/fastmap.c:1028:17: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <ZVBzB8egXofbupod@rli9-mobl>
References: <202311120122.miUV2XBw-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311120122.miUV2XBw-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CY8PR11MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e8e8af-3cd7-4373-3cf7-08dbe34a1722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLQcyqhwDDJHzJnVrJa/aHPb7nmkjGiA7PJUqywFsOh/w1STxvcAETn0TuAkJlt/sgK4FUp/qvCBcUeCAkf39DkCNc/K47+WFO0OsqIavY3jRy1Z/yo6bUFFPGFT6xTCDl0TCUiCygJRkd17TSe0SBgvJiftmVJHeR2xV7t1St0zdxwhkZFnXfag0FSufRCwJxaDx/FMowSy4978ksVERKUCUNDJk5oVyNX7hXnlLTcDGCZ+l0Ho4OG5qgEsvhmL7xWlDxk/Pyhcfl3YWnHslVaxpWM3dhBVo1A6HMnxxvzZO9vIGCmpzsqmBYDHZCGeCkh1HfnyTamyci1L8wFS61smEiz2EZuyEElHpqjPEuwBqHT0VfJoA+KOjTiNEtGnRSx6Px1fb7nSCENX9WG+cenYJMpdE50bx6RBZR+EzwXvVsmg0G3FI3YT+dDlMCgFBTiSL9cJsghp6iPgN2sOU2FTaF9qQr9M2BStyZj0iDIF2B4sicoW0ltccGRqPW6K8Ru/FOTB0ASOGKOv1KpXJ/UtH8VZBbWHkcsoDkdIUVpEO2HcftNycD/1VLp1rz8zxRS5LKx+Q/yEEyN+tJ3Y1Sh6HFs6UXkGbOfoELXbyorQke94Jjy0UjF9pWHDSCVW1XjPzLoNNPaGibET68a7TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(26005)(6506007)(33716001)(6666004)(6512007)(9686003)(83380400001)(44832011)(5660300002)(4326008)(6862004)(8936002)(8676002)(41300700001)(30864003)(2906002)(4001150100001)(966005)(6486002)(478600001)(316002)(6636002)(54906003)(66476007)(66556008)(66946007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsJwv1Hkvti870R4AdOlckvwXxXvgszOLyQC+8R28xHYiwPlMa0TxMB/Fjei?=
 =?us-ascii?Q?bjHhaNRzxHprdkpO4bWfnWzbp3hx5cOnZfC8kvTeTw3p5ThKChVRA/7YIIjO?=
 =?us-ascii?Q?6bFfevyiz0+6sCaf2+Y3r0hafiVYqx6WUzJYEQW/s3g+1VV1Fh1eYc611iCi?=
 =?us-ascii?Q?ZuxHiuy/YLtZrmbEu8f5iCo2NpIifNRCxV9CEDugWaB0ZwtY0c+wU4ti+gjo?=
 =?us-ascii?Q?yDbhQCF8UJyBE6TszBemA+6hsj7VzlhLHPrj0IvDcI3A+NZxbr/U8lIjkp4d?=
 =?us-ascii?Q?O0gJwhSM1H5xHygHqH1YtoO+ZJK96T54m2UWi/V39D+pfOINk1yY8adIuOkb?=
 =?us-ascii?Q?dr93CwrNTjUoybfEqOl0jTfpUCLC2wpv3AUHIJSsmLz49qhKCT7fOQYXyBRw?=
 =?us-ascii?Q?76S5o9O6ExmBZtXkBcokgHrbvq/uiejDhtbS/9QxcvGMcK63XEYXcBBOOG1d?=
 =?us-ascii?Q?1wSOWhSYTb5MnPDD/ZOZe7xfI3OhgQ6O2t4E4ax/3EG2M/EED5F7xRtxCwA+?=
 =?us-ascii?Q?IMbaATwUpxUUTTIUCkCESo8/htFFOK+iDI2SxhUSHUqANZqJ2fKFyLVPaLxM?=
 =?us-ascii?Q?zZgBmESKyTOKFYkEz8OQUGhCumQ2wIKAG5tx7rpo2kRrtj/ewoPIk7TW0p9x?=
 =?us-ascii?Q?zV8G/YjiJjnG1ghhUoNPqdOn1yoWeLLwtQHOUFTQHqVxKNyhN1HPKElBLey3?=
 =?us-ascii?Q?oGjfB2hxaDn52tOdGyJXwoOBdlGfH3XCdAhRj0PHV8WrqV9D5tp6a70FyPGi?=
 =?us-ascii?Q?u2vdZrYj2VtgxlhT+C9aqzKUg0Bw/BmWrrgHhCGnymq3LON7QdSDCFhhcj3O?=
 =?us-ascii?Q?Udi6P7R47bMOey/0gZGD1C77/zmkxR2cQ7T7xU2gXbpBb8AhiD6ITG/X4wkf?=
 =?us-ascii?Q?+Rj+6USo/9+XZvRBdMkH2MqsJz1J0AgyEQbN1wqhzfhxatk66Sbw3s6FST9r?=
 =?us-ascii?Q?zJ/cuiE7V55IcS6/ivg/tzgkdJgiu7BXbFe29t2MLIcVPZcZIiob1k5OkUhz?=
 =?us-ascii?Q?+f3dbH38ptPJ+3E2AoTaUztwlbD44AqmBuEqjbOYh36RzHvBVRkC2Z17reOL?=
 =?us-ascii?Q?GJN5O/r5AT9Od/KyZ8K+9dm849wyGpKx2d5dvYmmA8Oyp20aG4PVwrVngfJZ?=
 =?us-ascii?Q?mY8cIne6Rj45u4D/6/OclanGEXadyplXceLuJrrc/32vnC76j7KiX7jwPKFx?=
 =?us-ascii?Q?PNpvCJp/L5PIknCVr/PQ4CN5tpKhkm97wnceXbS+fr8WTHreqobPbP0M6r2P?=
 =?us-ascii?Q?fQl6Ia5B3uOXTV2O2JXnHLi9E2kTnkYIioQ7AyAWqv50TrUaT1jYvRC1i5kG?=
 =?us-ascii?Q?szbgOr5fq3vjSQI6DOQi1KQhUlBprLxx2A1YepVfoLlT7e7XUr/L8vwkI/oD?=
 =?us-ascii?Q?WC/I7K1cdKsJkta2ATEu83QAEzAP0XH7zYhwXbAzsM1evzjSp9/H9tk8wFJT?=
 =?us-ascii?Q?FdbyBsxcvUUhwIWVSBDWQekMa5sz0eLnSPgu/9KnH9C81T5u4oFZv0RGKcfS?=
 =?us-ascii?Q?ldmKRBJokF06jKmCEL9o+BL+bUuwhx0UKDWju2jLXvUtAOg0HfgWpGIjwYmq?=
 =?us-ascii?Q?0fWONWevT9IDISa+8OiR0R8pOxGX0F/0U8z/uyEW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e8e8af-3cd7-4373-3cf7-08dbe34a1722
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 06:39:16.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wX1T/tw+p3/KVMPM5Pe7XbdG/8K6Zg612VPF0LC1ec0B4eK0u7kWQA2+vhWFiR0bay26VLwRzlrcrgug/BxSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 01:17:53AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
> commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
> date:   2 years, 6 months ago
> config: i386-randconfig-062-20230912 (https://download.01.org/0day-ci/archive/20231112/202311120122.miUV2XBw-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120122.miUV2XBw-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311120122.miUV2XBw-lkp@intel.com/

Kindly ignore this report, the commit here is not the cause of the warning.
Sorry for the false positive.

> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/mtd/ubi/fastmap.c:569:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long max_sqnum @@     got restricted __be64 [usertype] sqnum @@
>    drivers/mtd/ubi/fastmap.c:569:23: sparse:     expected unsigned long long max_sqnum
>    drivers/mtd/ubi/fastmap.c:569:23: sparse:     got restricted __be64 [usertype] sqnum
> >> drivers/mtd/ubi/fastmap.c:1028:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] tmp_crc @@     got unsigned int [usertype] @@
>    drivers/mtd/ubi/fastmap.c:1028:17: sparse:     expected restricted __be32 [usertype] tmp_crc
>    drivers/mtd/ubi/fastmap.c:1028:17: sparse:     got unsigned int [usertype]
>    drivers/mtd/ubi/fastmap.c:1030:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] crc @@     got unsigned int @@
>    drivers/mtd/ubi/fastmap.c:1030:13: sparse:     expected restricted __be32 [usertype] crc
>    drivers/mtd/ubi/fastmap.c:1030:13: sparse:     got unsigned int
>    drivers/mtd/ubi/fastmap.c:1039:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] sqnum @@     got unsigned long long [assigned] sqnum @@
>    drivers/mtd/ubi/fastmap.c:1039:22: sparse:     expected restricted __be64 [usertype] sqnum
>    drivers/mtd/ubi/fastmap.c:1039:22: sparse:     got unsigned long long [assigned] sqnum
> 
> vim +1028 drivers/mtd/ubi/fastmap.c
> 
> 8a1435880f4524 Rabin Vincent      2017-04-03   838  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   839  /**
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   840   * ubi_scan_fastmap - scan the fastmap.
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   841   * @ubi: UBI device object
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   842   * @ai: UBI attach info to be filled
> fdf10ed710c0aa Richard Weinberger 2016-06-14   843   * @scan_ai: UBI attach info from the first 64 PEBs,
> fdf10ed710c0aa Richard Weinberger 2016-06-14   844   *           used to find the most recent Fastmap data structure
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   845   *
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   846   * Returns 0 on success, UBI_NO_FASTMAP if no fastmap was found,
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   847   * UBI_BAD_FASTMAP if one was found but is not usable.
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   848   * < 0 indicates an internal error.
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   849   */
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   850  int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
> fdf10ed710c0aa Richard Weinberger 2016-06-14   851  		     struct ubi_attach_info *scan_ai)
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   852  {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   853  	struct ubi_fm_sb *fmsb, *fmsb2;
> 3291b52f9ff0ac Boris Brezillon    2016-09-16   854  	struct ubi_vid_io_buf *vb;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   855  	struct ubi_vid_hdr *vh;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   856  	struct ubi_ec_hdr *ech;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   857  	struct ubi_fastmap_layout *fm;
> 8a1435880f4524 Rabin Vincent      2017-04-03   858  	struct ubi_ainf_peb *aeb;
> fdf10ed710c0aa Richard Weinberger 2016-06-14   859  	int i, used_blocks, pnum, fm_anchor, ret = 0;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   860  	size_t fm_size;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   861  	__be32 crc, tmp_crc;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   862  	unsigned long long sqnum = 0;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   863  
> fdf10ed710c0aa Richard Weinberger 2016-06-14   864  	fm_anchor = find_fm_anchor(scan_ai);
> fdf10ed710c0aa Richard Weinberger 2016-06-14   865  	if (fm_anchor < 0)
> fdf10ed710c0aa Richard Weinberger 2016-06-14   866  		return UBI_NO_FASTMAP;
> fdf10ed710c0aa Richard Weinberger 2016-06-14   867  
> 8a1435880f4524 Rabin Vincent      2017-04-03   868  	/* Copy all (possible) fastmap blocks into our new attach structure. */
> 8a1435880f4524 Rabin Vincent      2017-04-03   869  	list_for_each_entry(aeb, &scan_ai->fastmap, u.list) {
> 8a1435880f4524 Rabin Vincent      2017-04-03   870  		struct ubi_ainf_peb *new;
> 8a1435880f4524 Rabin Vincent      2017-04-03   871  
> 8a1435880f4524 Rabin Vincent      2017-04-03   872  		new = clone_aeb(ai, aeb);
> 8a1435880f4524 Rabin Vincent      2017-04-03   873  		if (!new)
> 8a1435880f4524 Rabin Vincent      2017-04-03   874  			return -ENOMEM;
> 8a1435880f4524 Rabin Vincent      2017-04-03   875  
> 8a1435880f4524 Rabin Vincent      2017-04-03   876  		list_add(&new->u.list, &ai->fastmap);
> 8a1435880f4524 Rabin Vincent      2017-04-03   877  	}
> fdf10ed710c0aa Richard Weinberger 2016-06-14   878  
> 111ab0b26fc1bf Richard Weinberger 2014-11-10   879  	down_write(&ubi->fm_protect);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   880  	memset(ubi->fm_buf, 0, ubi->fm_size);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   881  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   882  	fmsb = kmalloc(sizeof(*fmsb), GFP_KERNEL);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   883  	if (!fmsb) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   884  		ret = -ENOMEM;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   885  		goto out;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   886  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   887  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   888  	fm = kzalloc(sizeof(*fm), GFP_KERNEL);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   889  	if (!fm) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   890  		ret = -ENOMEM;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   891  		kfree(fmsb);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   892  		goto out;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   893  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   894  
> fcbb6af17bda4b Boris Brezillon    2016-09-16   895  	ret = ubi_io_read_data(ubi, fmsb, fm_anchor, 0, sizeof(*fmsb));
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   896  	if (ret && ret != UBI_IO_BITFLIPS)
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   897  		goto free_fm_sb;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   898  	else if (ret == UBI_IO_BITFLIPS)
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   899  		fm->to_be_tortured[0] = 1;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   900  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   901  	if (be32_to_cpu(fmsb->magic) != UBI_FM_SB_MAGIC) {
> 326087033108e7 Tanya Brokhman     2014-10-20   902  		ubi_err(ubi, "bad super block magic: 0x%x, expected: 0x%x",
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   903  			be32_to_cpu(fmsb->magic), UBI_FM_SB_MAGIC);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   904  		ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   905  		goto free_fm_sb;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   906  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   907  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   908  	if (fmsb->version != UBI_FM_FMT_VERSION) {
> 326087033108e7 Tanya Brokhman     2014-10-20   909  		ubi_err(ubi, "bad fastmap version: %i, expected: %i",
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   910  			fmsb->version, UBI_FM_FMT_VERSION);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   911  		ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   912  		goto free_fm_sb;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   913  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   914  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   915  	used_blocks = be32_to_cpu(fmsb->used_blocks);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   916  	if (used_blocks > UBI_FM_MAX_BLOCKS || used_blocks < 1) {
> 326087033108e7 Tanya Brokhman     2014-10-20   917  		ubi_err(ubi, "number of fastmap blocks is invalid: %i",
> 326087033108e7 Tanya Brokhman     2014-10-20   918  			used_blocks);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   919  		ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   920  		goto free_fm_sb;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   921  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   922  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   923  	fm_size = ubi->leb_size * used_blocks;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   924  	if (fm_size != ubi->fm_size) {
> 326087033108e7 Tanya Brokhman     2014-10-20   925  		ubi_err(ubi, "bad fastmap size: %zi, expected: %zi",
> 326087033108e7 Tanya Brokhman     2014-10-20   926  			fm_size, ubi->fm_size);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   927  		ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   928  		goto free_fm_sb;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   929  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   930  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   931  	ech = kzalloc(ubi->ec_hdr_alsize, GFP_KERNEL);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   932  	if (!ech) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   933  		ret = -ENOMEM;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   934  		goto free_fm_sb;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   935  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   936  
> 3291b52f9ff0ac Boris Brezillon    2016-09-16   937  	vb = ubi_alloc_vid_buf(ubi, GFP_KERNEL);
> 3291b52f9ff0ac Boris Brezillon    2016-09-16   938  	if (!vb) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   939  		ret = -ENOMEM;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   940  		goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   941  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   942  
> 3291b52f9ff0ac Boris Brezillon    2016-09-16   943  	vh = ubi_get_vid_hdr(vb);
> 3291b52f9ff0ac Boris Brezillon    2016-09-16   944  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   945  	for (i = 0; i < used_blocks; i++) {
> c22301ad4fa0f4 Richard Genoud     2013-09-28   946  		int image_seq;
> c22301ad4fa0f4 Richard Genoud     2013-09-28   947  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   948  		pnum = be32_to_cpu(fmsb->block_loc[i]);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   949  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   950  		if (ubi_io_is_bad(ubi, pnum)) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   951  			ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   952  			goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   953  		}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   954  
> 5283ec72b0cca4 Richard Weinberger 2016-06-14   955  		if (i == 0 && pnum != fm_anchor) {
> 5283ec72b0cca4 Richard Weinberger 2016-06-14   956  			ubi_err(ubi, "Fastmap anchor PEB mismatch: PEB: %i vs. %i",
> 5283ec72b0cca4 Richard Weinberger 2016-06-14   957  				pnum, fm_anchor);
> 5283ec72b0cca4 Richard Weinberger 2016-06-14   958  			ret = UBI_BAD_FASTMAP;
> 5283ec72b0cca4 Richard Weinberger 2016-06-14   959  			goto free_hdr;
> 5283ec72b0cca4 Richard Weinberger 2016-06-14   960  		}
> 5283ec72b0cca4 Richard Weinberger 2016-06-14   961  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   962  		ret = ubi_io_read_ec_hdr(ubi, pnum, ech, 0);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   963  		if (ret && ret != UBI_IO_BITFLIPS) {
> 326087033108e7 Tanya Brokhman     2014-10-20   964  			ubi_err(ubi, "unable to read fastmap block# %i EC (PEB: %i)",
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   965  				i, pnum);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   966  			if (ret > 0)
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   967  				ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   968  			goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   969  		} else if (ret == UBI_IO_BITFLIPS)
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   970  			fm->to_be_tortured[i] = 1;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   971  
> c22301ad4fa0f4 Richard Genoud     2013-09-28   972  		image_seq = be32_to_cpu(ech->image_seq);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   973  		if (!ubi->image_seq)
> c22301ad4fa0f4 Richard Genoud     2013-09-28   974  			ubi->image_seq = image_seq;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   975  
> c22301ad4fa0f4 Richard Genoud     2013-09-28   976  		/*
> c22301ad4fa0f4 Richard Genoud     2013-09-28   977  		 * Older UBI implementations have image_seq set to zero, so
> c22301ad4fa0f4 Richard Genoud     2013-09-28   978  		 * we shouldn't fail if image_seq == 0.
> c22301ad4fa0f4 Richard Genoud     2013-09-28   979  		 */
> c22301ad4fa0f4 Richard Genoud     2013-09-28   980  		if (image_seq && (image_seq != ubi->image_seq)) {
> 326087033108e7 Tanya Brokhman     2014-10-20   981  			ubi_err(ubi, "wrong image seq:%d instead of %d",
> c22301ad4fa0f4 Richard Genoud     2013-09-28   982  				be32_to_cpu(ech->image_seq), ubi->image_seq);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   983  			ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   984  			goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   985  		}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   986  
> 3291b52f9ff0ac Boris Brezillon    2016-09-16   987  		ret = ubi_io_read_vid_hdr(ubi, pnum, vb, 0);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   988  		if (ret && ret != UBI_IO_BITFLIPS) {
> 326087033108e7 Tanya Brokhman     2014-10-20   989  			ubi_err(ubi, "unable to read fastmap block# %i (PEB: %i)",
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   990  				i, pnum);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   991  			goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   992  		}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   993  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   994  		if (i == 0) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   995  			if (be32_to_cpu(vh->vol_id) != UBI_FM_SB_VOLUME_ID) {
> 326087033108e7 Tanya Brokhman     2014-10-20   996  				ubi_err(ubi, "bad fastmap anchor vol_id: 0x%x, expected: 0x%x",
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   997  					be32_to_cpu(vh->vol_id),
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   998  					UBI_FM_SB_VOLUME_ID);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26   999  				ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1000  				goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1001  			}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1002  		} else {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1003  			if (be32_to_cpu(vh->vol_id) != UBI_FM_DATA_VOLUME_ID) {
> 326087033108e7 Tanya Brokhman     2014-10-20  1004  				ubi_err(ubi, "bad fastmap data vol_id: 0x%x, expected: 0x%x",
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1005  					be32_to_cpu(vh->vol_id),
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1006  					UBI_FM_DATA_VOLUME_ID);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1007  				ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1008  				goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1009  			}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1010  		}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1011  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1012  		if (sqnum < be64_to_cpu(vh->sqnum))
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1013  			sqnum = be64_to_cpu(vh->sqnum);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1014  
> fcbb6af17bda4b Boris Brezillon    2016-09-16  1015  		ret = ubi_io_read_data(ubi, ubi->fm_buf + (ubi->leb_size * i),
> fcbb6af17bda4b Boris Brezillon    2016-09-16  1016  				       pnum, 0, ubi->leb_size);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1017  		if (ret && ret != UBI_IO_BITFLIPS) {
> 326087033108e7 Tanya Brokhman     2014-10-20  1018  			ubi_err(ubi, "unable to read fastmap block# %i (PEB: %i, "
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1019  				"err: %i)", i, pnum, ret);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1020  			goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1021  		}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1022  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1023  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1024  	kfree(fmsb);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1025  	fmsb = NULL;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1026  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1027  	fmsb2 = (struct ubi_fm_sb *)(ubi->fm_buf);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26 @1028  	tmp_crc = be32_to_cpu(fmsb2->data_crc);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1029  	fmsb2->data_crc = 0;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1030  	crc = crc32(UBI_CRC32_INIT, ubi->fm_buf, fm_size);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1031  	if (crc != tmp_crc) {
> 326087033108e7 Tanya Brokhman     2014-10-20  1032  		ubi_err(ubi, "fastmap data CRC is invalid");
> 326087033108e7 Tanya Brokhman     2014-10-20  1033  		ubi_err(ubi, "CRC should be: 0x%x, calc: 0x%x",
> 326087033108e7 Tanya Brokhman     2014-10-20  1034  			tmp_crc, crc);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1035  		ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1036  		goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1037  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1038  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1039  	fmsb2->sqnum = sqnum;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1040  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1041  	fm->used_blocks = used_blocks;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1042  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1043  	ret = ubi_attach_fastmap(ubi, ai, fm);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1044  	if (ret) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1045  		if (ret > 0)
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1046  			ret = UBI_BAD_FASTMAP;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1047  		goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1048  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1049  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1050  	for (i = 0; i < used_blocks; i++) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1051  		struct ubi_wl_entry *e;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1052  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1053  		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1054  		if (!e) {
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1055  			while (i--)
> af7bcee27652bb Pan Bian           2017-10-29  1056  				kmem_cache_free(ubi_wl_entry_slab, fm->e[i]);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1057  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1058  			ret = -ENOMEM;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1059  			goto free_hdr;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1060  		}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1061  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1062  		e->pnum = be32_to_cpu(fmsb2->block_loc[i]);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1063  		e->ec = be32_to_cpu(fmsb2->block_ec[i]);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1064  		fm->e[i] = e;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1065  	}
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1066  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1067  	ubi->fm = fm;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1068  	ubi->fm_pool.max_size = ubi->fm->max_pool_size;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1069  	ubi->fm_wl_pool.max_size = ubi->fm->max_wl_pool_size;
> 326087033108e7 Tanya Brokhman     2014-10-20  1070  	ubi_msg(ubi, "attached by fastmap");
> 326087033108e7 Tanya Brokhman     2014-10-20  1071  	ubi_msg(ubi, "fastmap pool size: %d", ubi->fm_pool.max_size);
> 326087033108e7 Tanya Brokhman     2014-10-20  1072  	ubi_msg(ubi, "fastmap WL pool size: %d",
> 326087033108e7 Tanya Brokhman     2014-10-20  1073  		ubi->fm_wl_pool.max_size);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1074  	ubi->fm_disabled = 0;
> 1900149c835ab5 Richard Weinberger 2016-04-26  1075  	ubi->fast_attach = 1;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1076  
> 3291b52f9ff0ac Boris Brezillon    2016-09-16  1077  	ubi_free_vid_buf(vb);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1078  	kfree(ech);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1079  out:
> 111ab0b26fc1bf Richard Weinberger 2014-11-10  1080  	up_write(&ubi->fm_protect);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1081  	if (ret == UBI_BAD_FASTMAP)
> 326087033108e7 Tanya Brokhman     2014-10-20  1082  		ubi_err(ubi, "Attach by fastmap failed, doing a full scan!");
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1083  	return ret;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1084  
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1085  free_hdr:
> 3291b52f9ff0ac Boris Brezillon    2016-09-16  1086  	ubi_free_vid_buf(vb);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1087  	kfree(ech);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1088  free_fm_sb:
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1089  	kfree(fmsb);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1090  	kfree(fm);
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1091  	goto out;
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1092  }
> dbb7d2a88d2a7b Richard Weinberger 2012-09-26  1093  
> 
> :::::: The code at line 1028 was first introduced by commit
> :::::: dbb7d2a88d2a7bd3624e090bee42cdee048d9290 UBI: Add fastmap core
> 
> :::::: TO: Richard Weinberger <richard@nod.at>
> :::::: CC: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
