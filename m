Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47676BCE8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjHASs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjHASsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:48:17 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCD01708;
        Tue,  1 Aug 2023 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690915696; x=1722451696;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qvaVQ3qlLSD9ujwBmAwk0rAo040EQd0ZXg6/IPI45nQ=;
  b=eKkUHRGT7OX9cQwZSWTiAl3LQ90mQrWRZY6c+YcTX0IqYww8dlXAi1pS
   SfF1P0sq2NPHU4Jkd4Z75wT5gNUz+sil8K5QI/y/D6mkXzoPH4W8uJvS0
   yp9Jv5/AITXjw4p775eydW4pV5HF9ti6JdNI74k9gHl5kjWoyUh5PhqEi
   cLnZe7aQgZl+wRIUiChYqTNWhgb+qHq7rlwTb6+11t8wmeXygVvCICdLs
   m4PcqQVVSclJPdIDubxWblMb5GKPvNtwPad6uQR7RiZ4udg1YaGPkVzK3
   5eMqKCcC5g8sepxBryLallOMxD6lRvaApfCH4vp36exBY4VcZob1EC/2n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368287150"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="368287150"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 11:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="902679168"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="902679168"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 01 Aug 2023 11:48:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 11:48:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 11:48:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 11:48:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 11:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krR5qfA5tlK3JOKjyzkN56rVZh2zCvcJqeLXX+Do5g6EvLoOcelBhXE1ECJQpp3tuJ1i2dkzClYjF+Ne4R3HZ4YB2exHAN3jrj2KEpncFqwX1EcLWNOSCQQiglo6peYjuzJ2aGDghHRdWgOtSTz+SlSdHJ1zcIPkloHj4lbGX56eFcTcEXpVUR48nsFY5wLtJezH0SgFmR4CyJN4AoefVJA8qaquiFSISkh8DTN/0txB9FfrXVgWQCCMg0M4knM8dc5d4OHe0L017b6EbTyx3z118gkl0FB/D5y6fdt2BQ7dgf4eFq8AAcVXTkwHgSLQVpCjyM2CvjRR/BvOm5+fpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvmRQBo1A5pQsz1yLxabLpUKo46/+k33A6stEDrrTTo=;
 b=RLZmuHcc3oBRNhhz+Ln6uHMzSsVsMV8PoRHNxFfxRZL3zI8rJZ48/Fu2tcKm9IGv78DQ0a4RdLRsBEKckOwTLykyMB8C3G+HuAC7iAkKEgXVUrgs3SmstcAV3h0wdGliy5tkShrIcql2RcUh6g5E+WUGakdSlZRN2HVUViRFUwb/LME0puZZ/dDW4igMI3aU84JDR2xAqSQg9jXepQTfpSgdR3DKrn9IVDFDJB6d1AWz6BuDnLhVFtmg1cX+dOa5o44KtxEa77tEKECnQ/XlOTGNT6HmqixurKZLwmt7TA/v55YIM5Hf5IAaU7M/IFGMiUOHbIQEM+u/dwAQVoxSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 18:48:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:48:12 +0000
Date:   Tue, 1 Aug 2023 11:48:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Fix debug message print
Message-ID: <64c953697f857_2616829424@iweiny-mobl.notmuch>
References: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
 <ZMhesrtXf31iST/O@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMhesrtXf31iST/O@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 194df60b-a264-46f6-1abe-08db92bfdbba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +omrnyAY8jpFRciiASgMZ1Nczsp02z/NlLjztMkkA3VdgiLQ6XatyUxPMiA2Wn8HMDDaqDZVl3vPuFWfxOoj7GzDfjbybSSG08r2aW8yocJGJTYUA7EcRvuM1vnvDtXTqXxRCC/1CA2zchHis1ZYtyo2uKGrxLdkgkzNDlPHBcTfCOtV32DlUJMX96q0hiG1uvSN0oNKOInaz3htqH6Ym6h++K3Jjx1s4c7Lj1EZbHYQaLP0003f+XCRr90fWRAjWhTitjIAAH0pGmeSUR6LPBojsaJQEy8dF7xD7WXgu/nBh642kZzGdF3VtKVBOVjaSKzqHUbros4tETp8loBKoieNqmVOPEzCmXvSz7cxfFHI2DHDJ1AtGq/p9b36yzfd+j36FjFQhaTVydnICBTueUKzYMN866HU4SVwWScxCJp9xvyeacSnwJ+A0NR+50tyL2yVOC4SQRG/T69339tb/IObliIJ7UiPHA49VtxrN/OsJgZGTl1sCgQhHwA7/ZihOvK+EuUDp3zRE7a4fT+yfjgPI7wY9PgyOyTLFFxHG5+FiiZDl1rdsYKprt7fdd30
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(2906002)(66556008)(66476007)(66946007)(4326008)(110136005)(44832011)(5660300002)(54906003)(41300700001)(316002)(15650500001)(6486002)(6666004)(26005)(8936002)(6506007)(8676002)(186003)(83380400001)(82960400001)(478600001)(38100700002)(9686003)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j2DIDFp6A4tTEtR9TkdVaxmJZm8c/9+KJh2viZD1xuTcmxgofmwYAZIrUYCa?=
 =?us-ascii?Q?c44HMOFR+NUqDZGSnTl/oRMMYfyryIex15zCTqsMF+zQYJgoaMB0GDcao3DG?=
 =?us-ascii?Q?x0FVxTHfuwRTl3N+PGRGxo2aZIxuLhvMDZT0UyMFu3u3aoR9wIpJdYxaCs8x?=
 =?us-ascii?Q?rO23Xjpddi1HwMd4EYoQCf6Txn2YKlp8riI1qDYmuuJ45Cbe8oNJ4UZClLsd?=
 =?us-ascii?Q?6UIe6neSOiX0xLR/OPzg+tpQrpn2XTGuGoLVfLof/SVxMBSud3frVU9g+lP9?=
 =?us-ascii?Q?5Ny5uH4C8UaHPrIZoZlpsiiC39ZgRsVxAfSwDOzN59iNLykaJJ8TTrUmYuBe?=
 =?us-ascii?Q?3Dj0/mSForIxFtoY6UpHoci9sLuaHJ6J++H8WrZtjCAA0DsMV9YB55Q+eHFe?=
 =?us-ascii?Q?J+J3W2xRZXtHY6ocK7h5KmBrUOGjA4DbnyAFe+UCDKGkogEfDeN7+1ANfWSM?=
 =?us-ascii?Q?rq9ZMSBmedG3TG5RXKiZ0TcuMmrrn+1JQY11IyLch1h1YSbSgl7BSW6mjgrr?=
 =?us-ascii?Q?WefRrMy5LcgO71K6LzSFAqCSEAfNQibbHsGeffwH6APRg9cNreCbm+Rw4VyX?=
 =?us-ascii?Q?K0gVRkzDM0Or2p01HKkfxeDJVgL7FyB0yBCk1w4iEvLhdl+8MbkngER5DY3C?=
 =?us-ascii?Q?1SCxtZHBve94bSGI0LIXGASImqB4sE/z9tH+AzGVKnzc5ARd//YmaArqwYRp?=
 =?us-ascii?Q?D8Ama7GIURZftWTmU1pnxb1t8+sGR1Gppe9BRxfF9wMUDUUEllxtaoPSw2/0?=
 =?us-ascii?Q?g2VU5RGXZzqg+heL/hVN2ewcalYKHOJCk+3h78IyXpv+rbMBgOeA3Aw8BAZk?=
 =?us-ascii?Q?N2AQPR2DQ27/k0SsQAQXuWSRjM4ZypjYhitakIJw9CsjZLNZZ/PN5iDyNGfz?=
 =?us-ascii?Q?WWsWEOIeQmanmzDVRBPcXQyA8fskxhODuFu2trbJwob3JhTzPozVSwftPzrX?=
 =?us-ascii?Q?TB420oiZFALAUFyr5lVn6SyEZkS3egT08++9g8EfGYbhc8LSTLNIEB4LXZ+K?=
 =?us-ascii?Q?v/S4u0AECxb0mrD63rQbWaHIbQvGAt551JvlM0nxjLVRpeInELOMGXUy6Lgz?=
 =?us-ascii?Q?MLoDDaKU07rporIJgj/2tZaM7MBY28fBfQuOmBemOyhPykR+3XDWwXvFxwNZ?=
 =?us-ascii?Q?IJ59/4wLZlUIQ9Omrjqpjr/yp2YdtIpQ5QWFO9/yaDA0VBUdq9sbfmw4UB4J?=
 =?us-ascii?Q?4d9YASHV5RsFnI9nMTI8SnvVI9HpoYuOBqweZmYbtK5KK3Vwy00kBB2mLL4C?=
 =?us-ascii?Q?VqDoXucwP5WrEIen5qhqXu1zoh6Spd1pGA0IUArP8tpyeD9L7Wtb9aHKNrXN?=
 =?us-ascii?Q?Q7hcVRqQqUU9OvGJ118vgaghusgzu2r7rOHKDzBndM5fIzcbrcmMhnf1cuUk?=
 =?us-ascii?Q?xcn0bPkbYm0D/xNnAaSe6uilIL8uT0fbEB8NgN2lrvlPSvZQxWbhU7TAhkii?=
 =?us-ascii?Q?x6ycjguPPYz8GAfQoXU9Jf4AJe7WnlodMHa3pbfUVe3jJjX3pZQWu0RePxzK?=
 =?us-ascii?Q?GuTkVFhwgTp21r3R8cj+sUlcjTckOnbhN3T9QBexnXfQrs1SOlMhpvIuEAoc?=
 =?us-ascii?Q?r3gigBnNyVCVm8Fsa35sxsa3FX9Scsll8yBhoveP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 194df60b-a264-46f6-1abe-08db92bfdbba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:48:12.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPaFes7cd9cw4wJaQMxBmTG7zAN/LgurpYidzVBK4/UmFERJYs5/fDVESVKpCv2T29LcncfZOKSFmNQZPgWc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Mon, Jul 31, 2023 at 01:52:27PM -0700, Ira Weiny wrote:
> 
> Looks like this is rolling for the distro list, so..
> 
> Please be more specific than this:
> [PATCH] cxl/mbox: Fix debug message print
> 
> Something like this is more useful to folks scanning the one-liners:
> [PATCH] cxl/mbox: Use correct handle in events debug message

That is better thanks!

> 
> > The handle value used to report an event being cleared by dev_dbg() is
> > incorrect due to a post increment of the payload handle index.
> > 
> > Delay the increment of the index until after the print.  Also add the
> > debugging for event processing which was useful in finding this bug.
> > 
> 
> "Also" always smells like something that should be a separate patch.

It could be but I did not see this as something which warranted its own
patch as it lead me to fix the bug.  Since Dan feels the fix should be
backported that changes my attitude.

> 
> I guess you could rewrite the commit message and keep it in one patch:
> [PATCH] cxl/mbox: Improve event dev_dbg() messages

Except that misses that this is a bug fix.

Ira
