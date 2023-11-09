Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A837E6462
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjKIHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjKIHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:35:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A202D54
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699515314; x=1731051314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MxxuB+vfpM9bnHy7ZvjQm7XPcyuDo8OzKAAZjtLlE98=;
  b=BRyFHQ6jcZZLmDLNUUtVS5uZmT9Q/+bLnuM97p1FGvsk+aEEkIjgRCW3
   cjURClOcO5OuAvUZMKuvRJEtOqrQBg37WqQKqX734NVQ/MCW+ybaefSwM
   abyboJ9PQ+WURgc6Yj/A0CA0cjKQ4MXayeFOEaIjzLv4Qrlf3PIGdL+hG
   NrfTwv3pmvpPFusuVMLIoovYrNLsznoQdgofAAslTdijtiT4S/4Lnyd6s
   4rlWC1iaUoAdnFkgEmeMDMKLzHfm+sBqBC38bE3OnkoG4aZ0rIubKSdT5
   ZBdDqboE98dDP9ruMe8c/R+RLavPH9yezSvyR9AoTTEotlXX8C3napfkX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="370135054"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="370135054"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="11454368"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 23:34:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 23:34:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 23:34:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 23:34:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 23:34:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuLI0Ztu/XFSmiglj+wDXJcucUTPbLyCitEUWCujrluoGPkB2OMv7DTgQeztBugTD+ott3JOofnUvahJsiuRrLhHXMy3uyQ6ydGiwTZEV43uSdPhI1k9isPVHN1/8R2PN8e46iFefdGa+zlPCgVjncwxKcNfGFuBUMTtOq2cME8HuQ+1Tc8ZkyKUv0H6WS817I6H/j5s1ofOIwx0FVVr/T2bXymQHRm2J2Af30ie1AntWtWJTwF08r51gBbg6hoED8wd5nmw7baIx1gKFIWxqDN5Qi826LovSGc403+mNNb9iLeXsS115keez2252Kq4MlwXRK0rYfIjhkCPeXn2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrerfnYqnKyM0ioBL/xxQ8wuB09w8ej4aSZH1siUleU=;
 b=kfeEbmj3Ebln2ztZUh4nN3rF6WXYh1KFbQX4of/6JjBI/PGJpWH0JZnAW7ZtSDFpZLle1hd80Bf+IGYfTEkcyTISXv6CWEK4HuUDbk3aKCyC9zt20GdOAQd0VPXdnXQzloTWCrQtbfZAbbzzB5GCLMNnb1IF7HbUo9vutDRipsW4qstWyTtSQCOXFjNzONWae3Il0Zjk3Q0xaG8p+7roDIO5zHuAdO42urLG1Kw47Q/e9/1lm36437Gu56kjPktgOCaXxYHta2hXiyjpG8rqubZ4qTIoRbhu4b/Jxq8sgsnqA/zXo1rTvsLWgMnx9BOBXzl1f9Sa48OGhPfE3pJ/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 07:34:31 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Thu, 9 Nov 2023
 07:34:30 +0000
Date:   Thu, 9 Nov 2023 15:29:48 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: drivers/hwtracing/intel_th/msu.c:131: warning: Function parameter or
 member 'msu_base' not described in 'msc'
Message-ID: <202311070100.aVGO5Ve3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY8PR11MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 092d44b8-8851-4121-172e-08dbe0f64f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a22hoV4hozbHeSNohIERe8UeuKxgoLNIVuS8FVLy5zBFDZu704q76jmUzCdjScOqiBF3H1SUycLAszznoPTT6N8MqtOZgqpdXmRmNzgW/hiHVsb7MV+7b3XIZ06miMNP1waih7mc4cCZgpH8Ih5va6n8+QrCNWWoqVuw3pkEJlI9vi5FQ2hx0r9fxXW9zD6TGcE9iP/2TSXBm5g9ayNWb06t2ixyS9TT9K0ZS8k1ZoQoi2RrM4GEeQRl4rbb8C8kDJolL8ruchY3Z8VXautFssUu+gu0N1MmTjpuTeoSVaZQij/mSRFK8wzrmZRpxOhxL4QGUBSCgcpyHxpqFFbM2YLhQ0+WQeOWomGIhtYKQa2bUg6iaNZUiZRjC66b1gdMDqXVrUrMBLTS3sEPJg9zTiKYCbhvdQidQOmr6HYvJDharuOpZc+Lj22d1tYdRMR231dSOkq4A1a1b3jmhq16lYpiqvQ4oNUhmzYNxuMXSGjOqB20vNUO1juhvu0PTUTY7lB05v5HV2uQZbawwT2AtMU+JV20gGk5cdi0gNSOxspGIw7iDe0UKdKU6D8jZ2TWD2EdybnFlK9GmyftSeh381VAEpQpaD3Acy4/mupTpXJeHs7P6bIw6l7htAuqhblTbBLAQXFuEc4SfEUvoGQvRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230273577357003)(230922051799003)(230173577357003)(1800799009)(451199024)(64100799003)(186009)(38100700002)(41300700001)(5660300002)(2906002)(86362001)(36756003)(82960400001)(478600001)(83380400001)(6512007)(66946007)(2616005)(26005)(1076003)(66476007)(6916009)(316002)(66556008)(6666004)(6486002)(4326008)(8676002)(8936002)(966005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hhvnVagO4cSn++5UNl4636qTaZsbHpVNCVEvsHmDC7X5/HEeWdd7uW5eIPvJ?=
 =?us-ascii?Q?TRGN3esf26+Xx7WFkjT7LBtV+AgbVHIQSUQBdEOvNB+foMY/7cc9Sx+bECZH?=
 =?us-ascii?Q?YqvJ7WXnKx5mMkEwlfZlaEopRjeJIHsfIofrs6pw6hNkWMjcd0Nzoo9Mjndf?=
 =?us-ascii?Q?PjXFXr4BVB1fxCCvzj462df629+Cnup/QbXTKmq0q07jbdg3E6Z8EtpQRK6e?=
 =?us-ascii?Q?O8th6Sip03eHKpsSjm2kb+kzj1ccUN7QP78qYn+ektwc9poQp8Gv0nW4pnIn?=
 =?us-ascii?Q?T5HoU7oYoRIhGqwcrkKNX/jX85+TCD4DwQgOOY9D6uQtu3hV7xcT7UVjm5fY?=
 =?us-ascii?Q?u3D7QTV4wbGOxaBaE83tWEivV7YcTWaJqJ67r7ONDi67z0KjDukuKMh2eena?=
 =?us-ascii?Q?5aBtCtNMTbaaSjTsMstyFaFf1TeS+ZVXV6x+rhjUCEYwc5QGqfGlobWHaGsv?=
 =?us-ascii?Q?v/Jv2FdayECZjwLooQ8beNtojFQiKLYHLwycLjf97DXR8uziEHON2FuwuvxE?=
 =?us-ascii?Q?JkfHqUsrAc13rA0gSOwyV63ubE0ANHtbHnZIwJJpdBfW7dTXKCTePAAFFv/E?=
 =?us-ascii?Q?709ZYNFPTIR+I3sQ3YRVX1nn4j/tW7RZ1Kg+gF9gXu4Ko5hXqsJP7kfL+zNh?=
 =?us-ascii?Q?8XiwAfG/zlZVj9lj5T4DrX55ekbkdq1+/Oy4XLZgdFNMeZ2KGBZ25N0f3OhR?=
 =?us-ascii?Q?EoaIVndxnwt3QeD6oLoPpO4VjcGqLVLDIvYAKabJ+xUoKY8V/EqHijtzw0sL?=
 =?us-ascii?Q?7avH4GMGK0BaP9PbWiP35zOzgwb+EzmzQOsGudrz1b1Pz5nZwJRGT6RDyd9q?=
 =?us-ascii?Q?dgGCrHaAEzZfgV9+IlEnYRlov3cHPlCTkqwQEzsrgcN9xhzTZuAs4dYLuz4P?=
 =?us-ascii?Q?xuo/yymTcuH6bdUlJXMg2ygw1108ECEhcALmMspKgx8hprxp8um7b9mcLRQ6?=
 =?us-ascii?Q?jOlpLHNdFrDjp+K2IaZTO4vbyvR0r0pjVT5m+N0wa9xqEyK+rreHeN/ihw2A?=
 =?us-ascii?Q?ftt51M7BkF+Y+dkPq/yPGGewALCioa4XIv2CbHz1t75jM3F4U/YjDUFkZj3z?=
 =?us-ascii?Q?ow+tH1V9R7RQsd7pIg2L9RUitw1H0fygbJWADdgTVeN4wgNBQzqcjqILbTQf?=
 =?us-ascii?Q?86Z2i8tTxputSxDHqs5+jWOI5ct30JTWFLbetdlCXtFu/+pdM59PTAg9JIoj?=
 =?us-ascii?Q?ErkGgONPjgnqA9NGeR35WBgCg4PuTRZsll9xYt6HiQiETC/wh73dY2uOFuMi?=
 =?us-ascii?Q?Wgr1KxdHIb7q8YuhiMmGJPl/z8krP3Xt+NJTvI352323tGPchMXic4rMiJcy?=
 =?us-ascii?Q?sLXS+Ag2pbxbz964X5F118mZ5S6EEjIFU4H+OrURRhcsik0oKDADyw+VpNRa?=
 =?us-ascii?Q?FckB2joQxaAud0zcuVCwq2tbTGu4D6Uz8ahk2WGN0vp5QXy8z/CWOFBxthJc?=
 =?us-ascii?Q?u5K1+mkoL1udJ9dkCN/dXJShOKJyx/ZdrosQZUN3vLFrbc5bWyCroxe0tw9a?=
 =?us-ascii?Q?7EKaUEPdQeNc8bPDWkdh1h6i9WKAwcqR4FaWrdq5o0dwdLtN/pFnyDvRFEtf?=
 =?us-ascii?Q?Ve7OY31SnDfEK08RVgZ+FA47xLF+l9zz07N2ixg8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 092d44b8-8851-4121-172e-08dbe0f64f6f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:34:30.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An4WC1eHZPoZNB7NiLKentsxvBR9iY7FI9jdaExTBbGv8YXux9q+3WLPjDX/KyNjuC+Tu+6RsXp7KBcaHMGkXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7779
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build warnings:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: aac8da65174a35749fcf21dbca4c1be314b562b5 intel_th: msu: Start handling IRQs
config: x86_64-randconfig-r054-20230808 (https://download.01.org/0day-ci/archive/20231107/202311070100.aVGO5Ve3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070100.aVGO5Ve3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202311070100.aVGO5Ve3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwtracing/intel_th/msu.c:54: warning: Function parameter or member 'msc' not described in 'msc_window'
   drivers/hwtracing/intel_th/msu.c:96: warning: bad line: 
>> drivers/hwtracing/intel_th/msu.c:131: warning: Function parameter or member 'msu_base' not described in 'msc'
   drivers/hwtracing/intel_th/msu.c:131: warning: Function parameter or member 'iter_list' not described in 'msc'
>> drivers/hwtracing/intel_th/msu.c:131: warning: Function parameter or member 'do_irq' not described in 'msc'
   drivers/hwtracing/intel_th/msu.c:966: warning: Function parameter or member 'nr_pages' not described in 'msc_buffer_alloc'
   drivers/hwtracing/intel_th/msu.c:966: warning: Function parameter or member 'nr_wins' not described in 'msc_buffer_alloc'
   drivers/hwtracing/intel_th/msu.c:966: warning: Excess function parameter 'size' description in 'msc_buffer_alloc'


vim +131 drivers/hwtracing/intel_th/msu.c

ba82664c134ef7 Alexander Shishkin 2015-09-22   40  
ba82664c134ef7 Alexander Shishkin 2015-09-22   41  /**
ba82664c134ef7 Alexander Shishkin 2015-09-22   42   * struct msc_window - multiblock mode window descriptor
ba82664c134ef7 Alexander Shishkin 2015-09-22   43   * @entry:	window list linkage (msc::win_list)
ba82664c134ef7 Alexander Shishkin 2015-09-22   44   * @pgoff:	page offset into the buffer that this window starts at
ba82664c134ef7 Alexander Shishkin 2015-09-22   45   * @nr_blocks:	number of blocks (pages) in this window
ba82664c134ef7 Alexander Shishkin 2015-09-22   46   * @block:	array of block descriptors
ba82664c134ef7 Alexander Shishkin 2015-09-22   47   */
ba82664c134ef7 Alexander Shishkin 2015-09-22   48  struct msc_window {
ba82664c134ef7 Alexander Shishkin 2015-09-22   49  	struct list_head	entry;
ba82664c134ef7 Alexander Shishkin 2015-09-22   50  	unsigned long		pgoff;
ba82664c134ef7 Alexander Shishkin 2015-09-22   51  	unsigned int		nr_blocks;
ba82664c134ef7 Alexander Shishkin 2015-09-22   52  	struct msc		*msc;
ba82664c134ef7 Alexander Shishkin 2015-09-22   53  	struct msc_block	block[0];
ba82664c134ef7 Alexander Shishkin 2015-09-22  @54  };
ba82664c134ef7 Alexander Shishkin 2015-09-22   55  
ba82664c134ef7 Alexander Shishkin 2015-09-22   56  /**
ba82664c134ef7 Alexander Shishkin 2015-09-22   57   * struct msc_iter - iterator for msc buffer
ba82664c134ef7 Alexander Shishkin 2015-09-22   58   * @entry:		msc::iter_list linkage
ba82664c134ef7 Alexander Shishkin 2015-09-22   59   * @msc:		pointer to the MSC device
ba82664c134ef7 Alexander Shishkin 2015-09-22   60   * @start_win:		oldest window
ba82664c134ef7 Alexander Shishkin 2015-09-22   61   * @win:		current window
ba82664c134ef7 Alexander Shishkin 2015-09-22   62   * @offset:		current logical offset into the buffer
ba82664c134ef7 Alexander Shishkin 2015-09-22   63   * @start_block:	oldest block in the window
ba82664c134ef7 Alexander Shishkin 2015-09-22   64   * @block:		block number in the window
ba82664c134ef7 Alexander Shishkin 2015-09-22   65   * @block_off:		offset into current block
ba82664c134ef7 Alexander Shishkin 2015-09-22   66   * @wrap_count:		block wrapping handling
ba82664c134ef7 Alexander Shishkin 2015-09-22   67   * @eof:		end of buffer reached
ba82664c134ef7 Alexander Shishkin 2015-09-22   68   */
ba82664c134ef7 Alexander Shishkin 2015-09-22   69  struct msc_iter {
ba82664c134ef7 Alexander Shishkin 2015-09-22   70  	struct list_head	entry;
ba82664c134ef7 Alexander Shishkin 2015-09-22   71  	struct msc		*msc;
ba82664c134ef7 Alexander Shishkin 2015-09-22   72  	struct msc_window	*start_win;
ba82664c134ef7 Alexander Shishkin 2015-09-22   73  	struct msc_window	*win;
ba82664c134ef7 Alexander Shishkin 2015-09-22   74  	unsigned long		offset;
ba82664c134ef7 Alexander Shishkin 2015-09-22   75  	int			start_block;
ba82664c134ef7 Alexander Shishkin 2015-09-22   76  	int			block;
ba82664c134ef7 Alexander Shishkin 2015-09-22   77  	unsigned int		block_off;
ba82664c134ef7 Alexander Shishkin 2015-09-22   78  	unsigned int		wrap_count;
ba82664c134ef7 Alexander Shishkin 2015-09-22   79  	unsigned int		eof;
ba82664c134ef7 Alexander Shishkin 2015-09-22   80  };
ba82664c134ef7 Alexander Shishkin 2015-09-22   81  
ba82664c134ef7 Alexander Shishkin 2015-09-22   82  /**
ba82664c134ef7 Alexander Shishkin 2015-09-22   83   * struct msc - MSC device representation
ba82664c134ef7 Alexander Shishkin 2015-09-22   84   * @reg_base:		register window base address
ba82664c134ef7 Alexander Shishkin 2015-09-22   85   * @thdev:		intel_th_device pointer
ba82664c134ef7 Alexander Shishkin 2015-09-22   86   * @win_list:		list of windows in multiblock mode
4e0eaf239fb33e Alexander Shishkin 2019-05-03   87   * @single_sgt:		single mode buffer
ba82664c134ef7 Alexander Shishkin 2015-09-22   88   * @nr_pages:		total number of pages allocated for this buffer
ba82664c134ef7 Alexander Shishkin 2015-09-22   89   * @single_sz:		amount of data in single mode
ba82664c134ef7 Alexander Shishkin 2015-09-22   90   * @single_wrap:	single mode wrap occurred
ba82664c134ef7 Alexander Shishkin 2015-09-22   91   * @base:		buffer's base pointer
ba82664c134ef7 Alexander Shishkin 2015-09-22   92   * @base_addr:		buffer's base address
ba82664c134ef7 Alexander Shishkin 2015-09-22   93   * @user_count:		number of users of the buffer
ba82664c134ef7 Alexander Shishkin 2015-09-22   94   * @mmap_count:		number of mappings
ba82664c134ef7 Alexander Shishkin 2015-09-22   95   * @buf_mutex:		mutex to serialize access to buffer-related bits
ba82664c134ef7 Alexander Shishkin 2015-09-22   96  
ba82664c134ef7 Alexander Shishkin 2015-09-22   97   * @enabled:		MSC is enabled
ba82664c134ef7 Alexander Shishkin 2015-09-22   98   * @wrap:		wrapping is enabled
ba82664c134ef7 Alexander Shishkin 2015-09-22   99   * @mode:		MSC operating mode
ba82664c134ef7 Alexander Shishkin 2015-09-22  100   * @burst_len:		write burst length
ba82664c134ef7 Alexander Shishkin 2015-09-22  101   * @index:		number of this MSC in the MSU
ba82664c134ef7 Alexander Shishkin 2015-09-22  102   */
ba82664c134ef7 Alexander Shishkin 2015-09-22  103  struct msc {
ba82664c134ef7 Alexander Shishkin 2015-09-22  104  	void __iomem		*reg_base;
aac8da65174a35 Alexander Shishkin 2019-05-03  105  	void __iomem		*msu_base;
ba82664c134ef7 Alexander Shishkin 2015-09-22  106  	struct intel_th_device	*thdev;
ba82664c134ef7 Alexander Shishkin 2015-09-22  107  
ba82664c134ef7 Alexander Shishkin 2015-09-22  108  	struct list_head	win_list;
4e0eaf239fb33e Alexander Shishkin 2019-05-03  109  	struct sg_table		single_sgt;
ba82664c134ef7 Alexander Shishkin 2015-09-22  110  	unsigned long		nr_pages;
ba82664c134ef7 Alexander Shishkin 2015-09-22  111  	unsigned long		single_sz;
ba82664c134ef7 Alexander Shishkin 2015-09-22  112  	unsigned int		single_wrap : 1;
ba82664c134ef7 Alexander Shishkin 2015-09-22  113  	void			*base;
ba82664c134ef7 Alexander Shishkin 2015-09-22  114  	dma_addr_t		base_addr;
ba82664c134ef7 Alexander Shishkin 2015-09-22  115  
ba82664c134ef7 Alexander Shishkin 2015-09-22  116  	/* <0: no buffer, 0: no users, >0: active users */
ba82664c134ef7 Alexander Shishkin 2015-09-22  117  	atomic_t		user_count;
ba82664c134ef7 Alexander Shishkin 2015-09-22  118  
ba82664c134ef7 Alexander Shishkin 2015-09-22  119  	atomic_t		mmap_count;
ba82664c134ef7 Alexander Shishkin 2015-09-22  120  	struct mutex		buf_mutex;
ba82664c134ef7 Alexander Shishkin 2015-09-22  121  
ba82664c134ef7 Alexander Shishkin 2015-09-22  122  	struct list_head	iter_list;
ba82664c134ef7 Alexander Shishkin 2015-09-22  123  
ba82664c134ef7 Alexander Shishkin 2015-09-22  124  	/* config */
ba82664c134ef7 Alexander Shishkin 2015-09-22  125  	unsigned int		enabled : 1,
aac8da65174a35 Alexander Shishkin 2019-05-03  126  				wrap	: 1,
aac8da65174a35 Alexander Shishkin 2019-05-03  127  				do_irq	: 1;
ba82664c134ef7 Alexander Shishkin 2015-09-22  128  	unsigned int		mode;
ba82664c134ef7 Alexander Shishkin 2015-09-22  129  	unsigned int		burst_len;
ba82664c134ef7 Alexander Shishkin 2015-09-22  130  	unsigned int		index;
ba82664c134ef7 Alexander Shishkin 2015-09-22 @131  };
ba82664c134ef7 Alexander Shishkin 2015-09-22  132  

:::::: The code at line 131 was first introduced by commit
:::::: ba82664c134ef7ab97808f09a3c5e894b0a4900d intel_th: Add Memory Storage Unit driver

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

