Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB667D7EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbjJZItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344612AbjJZIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:49:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C77128;
        Thu, 26 Oct 2023 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698310182; x=1729846182;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=oszUzAAFR9OuzdPZDMUs2bII/i6SxGDCw4dv32plYKc=;
  b=Lx1e1Ae43Yww3ohr1rJ3gTCIdBgOncXvK25w+pilbtlGLo1h41kHvFJL
   9slvWDjIvvT8PtWgy48NleqSiA5lLrC9lti7ZhTHQqka41FvAdLzoCyI5
   CqdQN/S79EkRAG4EgxGcmXtI3t+c9vxjQtTKauJ2EUuhsq4j4MjHjUC5N
   ZtZrVj61yLdaZv0/9aHEE/bHuaOFOn2YGQbzsfpQzmByFv3VkkTRFmUw6
   Q4eSx7BeDxsCR+g+QJoBcnznWeS4E/pGriQdp6gtxh+MjrWa9EtprBv11
   Mcm+Q6PV/ZKIwpgDcojsYqIOOEjMPiKntcEcI5hi45pwso9FT8QMMGgEA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9048516"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9048516"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090529676"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="1090529676"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 01:49:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 01:49:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 01:49:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 01:49:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 01:49:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyx3zWTEpJH0PYgvfy+rG5bnovP1DP2A3EZTwMNR9+5KrtN+O1VKLz3JPqSQHkV3nE0yzyh5VoaSDgy6VkgoNvxpNf/hISU/qf+8dGZDUjaH5QWOjWZKTrJAWvdD1Wy34KTZfGSx4hZY1KF8luj6Jt9Lgi9zDdlmjsWJCZ0WL2jTGI4nOxlRHPpxHmJNkOqJNrBamcPxrtd70ta0G+TpktGq6irj/5/fCcEGD4neB6bvBCgjxziE/PDR5QXN0Jccc3abtYROpiULXjEW1NZ3QYrhF4ilFbX6tvdt2fC8YchB6Rcf30ILBz7GquGFWha2t7lu1xYfiMQDgZwVsfn7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl1OONGIxA1kkTt0qPOImIaCrEOcBoBrva//MXTBwsM=;
 b=lKMCnu8TNQ8w70CHSdCZ1oKgqYXn++9cZ+roN9AN4DphRX/QV1euYF++NOgvhDDBKZSQneA50aiNJb45l5c65pXKGU3sMgYAdyQ740Rka0v9c4P0VF9jET/0ENqzfKsIrxbOX+fQnXjFKWnsqwDkpvMIgy8CThsq2QY2Qr7NVmpoi3uOJ3dOIuHepAGFlx8IlKcTQfF5BIPwv00n5M0uhksZ73sYws6rsVvmQtUDqekn3UY4wxxUu8T8Nr5AETA6sKf/lhnKVuNSzCDr/VB4vf4XLePDLL8eE3hKM1bkHrSidG4+pZWeiPAgS9/mpuwHZncqE7Ng5zFsEBDDNKkI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 08:49:32 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:49:32 +0000
Date:   Thu, 26 Oct 2023 16:44:44 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Muralidhara M K <muralimk@amd.com>, <linux-edac@vger.kernel.org>,
        <x86@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <bp@alien8.de>, <mchehab@kernel.org>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 1/7] RAS: Add Address Translation support for MI200
Message-ID: <202310261444.Z20oGCyr-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231025073339.630093-2-muralimk@amd.com>
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY8PR11MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9dbd75-6051-4c11-7f21-08dbd6007927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roHQ2YHp1UN1pf851pVYG7fOw8VLpmuVQRtmTXHyPEvcfur7XEUiAeA9S8lkUdmSNgo6uC3QAILKQ6+m4aDY8JqQ+pP+ddlwZFolLSWyMPwj3cpGvhzQr2AbDT/lNUiYJTQCtNs0cAQlPhF5MdMZE+Q/oFZE8lnW1fmebfzSro/Pqu41SMyso1aiJ5TlE7rkS8f//gYVdEQOf+FaiSr6GO5I3jAn5GsbebMeahih6t+LOA+/BkqZ1js/JWYIj/YLJG9dguAmi1PVTmviIt7UkZQl759imV/REyTNedXB0rjx0CnM+VNN4U8eImmXKf4DOM55zaQ0/H90pXWmI3LkHexk3oazb3BoHEZiHthjw0Si/lLQyym7OLm2W8mUxsCWsZ49TEwrjoRp56JnnRD7hREF7YVvA17eg591Mh4xoxAAin5qGM52Q/DQ6DEGw7Lgyg+/wSYiGMDP8r5HMUAZEm0zE+dh2V6mFzA8Sp6HpyHfuJZyBZlqt1HIx50GqKfRSd/p3MTjUjZGmgG6YsuwZgI01TQAmL/kxLk4TztlHzxAvZMlqtutPsInYWG3yoVJ/M1CNBqA9K/o0gFGyftItw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(966005)(6486002)(6512007)(82960400001)(1076003)(2616005)(38100700002)(478600001)(26005)(83380400001)(6666004)(66946007)(66476007)(6506007)(316002)(66556008)(54906003)(8676002)(8936002)(4326008)(5660300002)(41300700001)(2906002)(86362001)(4001150100001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCEER6KSA58SY+vCRP711H6tLaWzqAWShzLF4A9hQFgPEhpdupMYMaejOeYn?=
 =?us-ascii?Q?KCqPNpeZJdMqEJVVfxYLAHRC24AxR1Swiu1MEUNKSJy3zIDo2ZXHGJ7tCkMd?=
 =?us-ascii?Q?+lH9+Ym63nykhvjH9LYb7J8CDayfHo5cW6cLyFE88nMQ2zwIZ3AxiRzqoYOH?=
 =?us-ascii?Q?g64eIrjcnnsrVic0BQBtYEfQgFTussEL4/4l8XbHgVwO2kyz09UAHvoLBxU9?=
 =?us-ascii?Q?JLAS4I7KHtFvA2sMoPBtlER7BLqXzDrHw/UKXI1ELCcNqaVlJj1eJ2GbyDyX?=
 =?us-ascii?Q?VXEzsEJXA9kt1lO0BML/Ry2qA4I50j1TJYd1mBmbIcTkCakU8ZaniG9Lyu4+?=
 =?us-ascii?Q?Yag7whfiH8bTOMDeBTSDNiYAqqdXGbDOlcb25WxSPAy/O537xkgIIclnTWnf?=
 =?us-ascii?Q?Rd+o1KZAH3qJ+OxlLj6PpShBl6byJUk0Tgn6Ii2A4MXpbJlyMv9ha7zz4O81?=
 =?us-ascii?Q?e4U/yHnalVMhfYjrkiZKrbtarLaOthya9PSwkN3mgaXJ0OithlxH8dSTu04m?=
 =?us-ascii?Q?2EFx023drR6Fm29p58KOlhgWGE4llDTt5tTaUFrWLpy5o/IL0FsPf3F0DDie?=
 =?us-ascii?Q?KqLL1Lcks0BCQhiZPMfef5hRreOOEzgoyf33oeEvMywMWcRgrA/ANTM2y7Vm?=
 =?us-ascii?Q?6usOcSAqdltbzwIRcCGsd5Rb2S+1CQq5Z1IU4ep+ihyA2jjTvnyQjEhGuGwA?=
 =?us-ascii?Q?j3AZSkctfTdwqAoiUknEKZpfhD8YxJVe9WCyXEF4cpuT0p6NNEVWpJ57OtAT?=
 =?us-ascii?Q?vda/ITh7+X5e4siiqBiZTPNPc7N+SKE2rUs0bKzNXl+kXjqSQF9v46E7DPnQ?=
 =?us-ascii?Q?Ff6LaDl5MFA3MjR+q+TY6ENAhd+fW096tVKq8NJGREskVE6fu1goGyvbVD+F?=
 =?us-ascii?Q?oTHUbW2mcPiG0fMa6k9eVxWYZpYS2JPkxtdKWC+EyS5jCyrhd42eFp69Ad1r?=
 =?us-ascii?Q?aJHUglUWgo/R4au/UMUviUk3JyHEWW+x+JzjrryYyHF6ZlptIQZHV0DZAUSl?=
 =?us-ascii?Q?YuKGznJLzlDo3u/IjkIWLcx52eJAgFUPcHr0DdNC5S+8m6mqOU/8vfXqgDpr?=
 =?us-ascii?Q?MujT0qp8otlDw7rqhxAbNLWWgQIHAURvoayPjViI55PwvK06/+71STb81H3n?=
 =?us-ascii?Q?+4FSeJLc4/8eB1PSqEBp3gmN/4xatcqLzK3SUlo4WfrcmAcQa6qPMhKT4poU?=
 =?us-ascii?Q?bbTev1kNg39loBoNBPx0Gp9LahDlbofN7EGfCrt6V8F5Z5LKGOvTBgJyPnw6?=
 =?us-ascii?Q?BUzHHWN/q6yXa9nR6y7bLHzyV0QHeJQ2SfUm2CXIdzq3vUIYJaWFX1FceJxk?=
 =?us-ascii?Q?SBSFmCgFr5TZaOWNx0aTN4Sh7IajsqOn46fkNzYROFmEx6+d/rWkGzHVpHD/?=
 =?us-ascii?Q?spfDG2UMD7gTVfGiPL9Ve6YvzsOKVy6yHeBnnpja4maWGtsR5Sz7QW2sfVE7?=
 =?us-ascii?Q?nvnEnmf6jGyOhuGZipt86Xxnbw7sLSw6sG64MCSgN+t6KOkd/eDUMNK2Wtyv?=
 =?us-ascii?Q?M04A1GaKLS6a2ZY5gQNQxnpOS70DgSPJ1T11/Ch3C6EREzRlWDfI4sVEFVvC?=
 =?us-ascii?Q?G5CCqZx0IcbeQBMOwmzTtFD4X+1o1OlcDwi/7ldM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9dbd75-6051-4c11-7f21-08dbd6007927
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:49:32.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTCXRY6hWOKOPTzGNJFo3PP3Rt6UgotF/aF0c1L0MFN1iLoPa83lYt2woPWtbMfhSlspymcZUf5t49YWegAYSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
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

Hi Muralidhara,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on tip/master linus/master tip/auto-latest v6.6-rc7 next-20231025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muralidhara-M-K/RAS-Add-Address-Translation-support-for-MI200/20231025-154756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20231025073339.630093-2-muralimk%40amd.com
patch subject: [PATCH 1/7] RAS: Add Address Translation support for MI200
config: x86_64-randconfig-071-20231026 (https://download.01.org/0day-ci/archive/20231026/202310261444.Z20oGCyr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310261444.Z20oGCyr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310261444.Z20oGCyr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ras/amd/atl/map.c:416:5: warning: no previous prototype for 'get_umc_to_cs_mapping' [-Wmissing-prototypes]
     416 | int get_umc_to_cs_mapping(struct addr_ctx *ctx)
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/get_umc_to_cs_mapping +416 drivers/ras/amd/atl/map.c

ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  403  
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  404  /* UMC to CS mapping for MI200 die[0]s */
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  405  u8 umc_to_cs_mapping_mi200_die0[] = { 28, 20, 24, 16, 12, 4, 8, 0,
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  406  					6, 30, 2, 26, 22, 14, 18, 10,
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  407  					19, 11, 15, 7, 3, 27, 31, 23,
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  408  					9, 1, 5, 29, 25, 17, 21, 13};
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  409  
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  410  /* UMC to CS mapping for MI200 die[1]s */
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  411  u8 umc_to_cs_mapping_mi200_die1[] = { 19, 11, 15, 7, 3, 27, 31, 23,
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  412  					9, 1, 5, 29, 25, 17, 21, 13,
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  413  					28, 20, 24, 16, 12, 4, 8, 0,
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  414  					6, 30, 2, 26, 22, 14, 18, 10};
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  415  
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25 @416  int get_umc_to_cs_mapping(struct addr_ctx *ctx)
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  417  {
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  418  	if (ctx->inst_id >= sizeof(umc_to_cs_mapping_mi200_die0))
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  419  		return -EINVAL;
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  420  
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  421  	/*
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  422  	 * MI200 has 2 dies and are enumerated alternatively
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  423  	 * die0's are enumerated as node 2, 4, 6 and 8
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  424  	 * die1's are enumerated as node 1, 3, 5 and 7
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  425  	 */
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  426  	if (ctx->node_id % 2)
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  427  		ctx->inst_id = umc_to_cs_mapping_mi200_die1[ctx->inst_id];
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  428  	else
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  429  		ctx->inst_id = umc_to_cs_mapping_mi200_die0[ctx->inst_id];
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  430  
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  431  	return 0;
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  432  }
ea0e1d9c3eaf5d Muralidhara M K 2023-10-25  433  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

