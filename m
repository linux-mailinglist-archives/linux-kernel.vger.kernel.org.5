Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4276BEEE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHAVEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHAVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:04:05 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED60129;
        Tue,  1 Aug 2023 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690923844; x=1722459844;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IbqiQWJLkbsHnKzI0eqdCftiQAkL2snlJZXHag5oaHo=;
  b=V/LtcDXp9NeLlHyTuexgMNRGY06yjqyj/Ic9w5XAmd2Liy8pF/ByNSlx
   w2umBng1EH4J+smFqV7CKtQ2tyeLjlZSfdgKTLCEaZSmAHDvON2z/bS1t
   EkSeZ9RpmUfWejVSJidm23qn5nvkfYN4wotBdMLIf1o8Aqk92XJY0MA3g
   ufMwEgJ1dqDPng+FpJE78sfdeIstr0UxP1OU98rqS6ouuhXPvnXXeBrZ/
   mHS3oKq0sbVhd+Ycrrbisyg8LFUcfuGX8/cw8wYZCDdR5axIRxYfur1IG
   aSC2QLVL9Y69HUjQYt6prEnMrCa086wUdscnXa86dEH+QrZyJS+jnpWdt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="372145013"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="372145013"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 14:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="705923424"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="705923424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2023 14:03:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 14:03:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 14:03:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 14:03:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 14:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efGFjXzAzoWcO6AY4V/cNWPBiIsqvoeksFpjEGiuMNb3yecDMkTzfHzWHhxI3g677AmdKPOqZLm23XxBhcLflfJyZ7D9DWA0gI4mtJ3lggd0xBoQYJwstmtL2x/nkQYI3un4KOPyvU5Ch5S3puQOTvFrUT2b2sN/lL/1aqNLPtFxnY8toL2Q/tMP59VasK21zo6RS60zVhYHurMme00tAjBO+N4LJY0zx/HnewXUCiy0uMjEzBiBqGw2p2U16sIqTM47ditZ1+7lo11p6zquYe6qmNHzRdSrM92EaIKCMGIfshH2gfL89bvboqoi/9tjYxocZoW2B7JldXuaFWUApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z6l9dlyWvXiQq+RbRMz2tkV3HI76wlb0DBNpaKrVDo=;
 b=Igltlg8yc2EJaLmneGP+z/HRGEndkeaXDafqRJwb5J4/xWGgp1MZd0/XUq4Ykq6LUjG5if9czCPkUSTSpElkKTv41TEuuRJMIWDh4NRXMXKDsfWMW1tAKMbjX5JeqdVSNzGhER5zxP5NOfWsfyV7aQx/7u5hvl5fR7drqX4coU7wjAAg7uAS8SFl8/nEc1Zch1Rq/hwkB6d6J5laXjakbXyvOOLbsXqPq6c0lOpNWz6vHoU6Gg0zWl4ycMLa5GE+skK6crqJveNYDDNIAycWGYSb8mZj1PtJcSd5kzhqeYMFUSfxsR/byzyWnNQbMgEqndJg7oSuJSHZAjjwItruCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 21:03:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 21:03:39 +0000
Date:   Tue, 1 Aug 2023 14:03:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/memdev: Avoid mailbox functionality on device memory
 CXL devices
Message-ID: <64c973273f20f_26168294f0@iweiny-mobl.notmuch>
References: <20230728-cxl-fix-devmemdev-v1-1-dbd3269b3295@intel.com>
 <64c4562fb7531_a88b29481@dwillia2-xfh.jf.intel.com.notmuch>
 <ogv7evtgf5rcljd4ev7rxx6buqg7y3kwlqing2tfshh2ac5zf6@juclnksnv4ki>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ogv7evtgf5rcljd4ev7rxx6buqg7y3kwlqing2tfshh2ac5zf6@juclnksnv4ki>
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a64d11-d2c3-485d-88cc-08db92d2c76e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8+IxK8zTjL7VlDCepp6wixkOVNLvVKoqtc/atXT8Z4qORY53wuVFCnkGRwCjK4mrvmytlcO2i37wuhjNhTHNEK5rBsW4KBVJXFjwUsBtlKzcV3dun6FN9HYDmwE5IVQDHadjs/FWNzORJoiDmYgLYSiA5Y1cV92F+XJWWMfYMobwH6XzaM/n3mv02EEMwzoW9RT6XHEQqYhe3h8x60yP9L5U6aiw1/x27eenCxKUOFwfNPeDiy6hu8KOYmK3ooshO3Y1Yfbq/D9WZmAy7tqIbp5MqaSDvYEeVbY22Z6Its8VpfgRm7+rpXGjR+ET1EWj6H8/ydp10dEMfbPufUE5NfcnqSy48cbJHHi4u2qjReXWvM1KIxgxQuli64XI8LYd1w0p0t/BqsRuQ1fcmsv3EBpdBByVb6UNnloy+6rgxeb99ki9bMRws69pM56hHXD1iVJjnLaByoN1gWEnPuU3Wt8TvDBhfe5COY3ouCO7bgxGLFSSwP+WdwfrQ6nC+Me3/TcYpfdWG9e7L3DXh5fizGtGIZZXzm8hxgvv44gs4y0p9hzmh+qNm+8o70/t8h8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(186003)(6512007)(9686003)(316002)(86362001)(478600001)(54906003)(110136005)(38100700002)(66946007)(66556008)(66476007)(6666004)(6486002)(4326008)(6636002)(82960400001)(6506007)(41300700001)(26005)(15650500001)(8676002)(5660300002)(8936002)(2906002)(44832011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KI8xfy1ILPrvMWrzmH32flLJciGE540BB7feyO2O10hebiz4C9UuS+HS3Naz?=
 =?us-ascii?Q?l/yL8OZuwVWSl/jhNujSBl5qGSBpZEW+SwcPvKvy/31YyX63kmXz20eyaAoy?=
 =?us-ascii?Q?ga4NRpV/8/kd6Bh9eoqvrkyASOtz7JY1JqQMjplfi1LVB8R/RzFfhQmDxvOT?=
 =?us-ascii?Q?lrBb3MeD0NbScmuN1S4wKXxj2T3Xwe1EC62CKJEke9w5FhEd5Bjp7xuoRJCw?=
 =?us-ascii?Q?E2mz6+vYu6a3Xc9qWi+iqmEODSfo+iKJaD6JSwjjRQviNB7p/2Om9117FrJv?=
 =?us-ascii?Q?l1n08ZCKAypeZ/f2etSz36OeTtOYjlblJCkKyDUTIsorfI1Jhvxl+cvJbppq?=
 =?us-ascii?Q?lJ9R9PEQB3KxhGpIKQixXsX9gtHPux9U+HcOoPpJXPCbxQD5CgC3A6Wdplk/?=
 =?us-ascii?Q?AtT9wH2PK2H8o8DiR+/7U4vJP66UgZ+bSsKQ2p8kTm7KMsKmay4Cknczzyd6?=
 =?us-ascii?Q?lbg8wKzSGFgsyrjSD9BQtNhytD5WvqDzvjTUCeqP0gD5aQOuoSDspfVEzPeD?=
 =?us-ascii?Q?vaIFRIDrjthApOdKBJRFXRGphTz0YvnqzYPLUJoXxKvz5kOgZ4kyQ9J7Uw6f?=
 =?us-ascii?Q?bVM/uZ2ViTPPbXfxRRuNuxaVeIjhErXARg25pb74Uj0K4+VkXQPth1p6D9J1?=
 =?us-ascii?Q?Tjs78+HoFZCElztDMRuFlRBSjkgNWxNBJAQ9EpHSekYLPmLX4mP5CHdVsGaX?=
 =?us-ascii?Q?app/iTIXnxdEj2OgSeyIS1J5qulmupb8QHRVnZvfLxLq6auzSZP2KUN2fxiK?=
 =?us-ascii?Q?ZL0ovlPGFyMlTUI5yvKA4B2xfa8JU2hzbnXIuVSPSwxJPB5Ue1tzhpS/WxmX?=
 =?us-ascii?Q?xOO+fQuybMqGQuZ34SpncL+6X4Hc+pXHOE7/6tOTu8txMzAsX4y/zjv/L2tK?=
 =?us-ascii?Q?CgUcFljREQ5EoromI5xJW9a/NxxxNQ8lKuskErBfyGiKSr8GI4KUqlMqi96U?=
 =?us-ascii?Q?h0Km0LW9kJ6YwkgkgKRB3POIzWzsSzop2/nTZ1FngYjIoOexOwICjDhc+cA0?=
 =?us-ascii?Q?gDhU/IrdOqkIhCrN0vTQgfHzgPctaRcJBVicNKTmo4R1iNDqcnOCEb9p2of1?=
 =?us-ascii?Q?4rE4CUbviEe2I8ftjj6+OL84GvGbeHRHAjxazlk4q3AjPVO6GJ3bRgKlPvLB?=
 =?us-ascii?Q?NaDEZ3LHnug/0XgfaLTDrSHF2lQlt+JmTdqM5ioSBnqnyY9mq9MrOFjl0EAE?=
 =?us-ascii?Q?4CVIm41I7oLzvoQEyY0jA3neS9I0nAVzDuHJB1qbqIuwePJfG0yhGFSyu8tZ?=
 =?us-ascii?Q?nYan0tmyVKal/I0ZwZKglTnD/xHk989PEfbg6DlWkVXu8ygnzyQgnh30vCC4?=
 =?us-ascii?Q?nl5NzUu17DZD5pnK8cd+0epmvHesrtzZp+hKgH/FM0XKsds3SMu8OP+/+Hcb?=
 =?us-ascii?Q?Ua0W6OsoTQkPrTw8VWKiYPJ4nd5qLDNFZOpVZD0KUtipQwB5aijbE4GUi/C1?=
 =?us-ascii?Q?JTbqiXjCD5oU+AC8fDCpIDu2FgecB2EbqrSUJsSIXUw5Y16cX5jPcC8UtvSM?=
 =?us-ascii?Q?9Gx9MQPP/rTkU5AraSBXl9zVvKsS2uEWZAPRaG0ou6X4O3XoxWetTg/trqy2?=
 =?us-ascii?Q?FPVEqb6bT8tkerODs2drlGgT41lAjJFawAv6FNai?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a64d11-d2c3-485d-88cc-08db92d2c76e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 21:03:39.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ht8pP/1DBKJUSgj4u4Xrb/9mtIV0B159CPCr4Yzlomte7wF6KFltFaENleTzw7S/896HPq6V+AOf7VIUt/7xFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> On Fri, 28 Jul 2023, Dan Williams wrote:
> 
> >Ira Weiny wrote:
> >> Using the proposed type-2 cxl-test device[1] the following
> >> splat was observed:
> >>
> >>   BUG: kernel NULL pointer dereference, address: 0000000000000278
> >>   [...]
> >>   RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
> >
> >It would be useful to decode this to a line number, the rest of this
> >call trace is not adding much.
> >
> >>   [...]
> >>   Call Trace:
> >>    <TASK>
> >>    ? __die+0x1f/0x70
> >>    ? page_fault_oops+0x149/0x420
> >>    ? fixup_exception+0x22/0x310
> >>    ? kernelmode_fixup_or_oops+0x84/0x110
> >>    ? exc_page_fault+0x6d/0x150
> >>    ? asm_exc_page_fault+0x22/0x30
> >>    ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
> >>    cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
> >>    platform_probe+0x40/0x90
> >>    really_probe+0x19e/0x3e0
> >>    ? __pfx___driver_attach+0x10/0x10
> >>    __driver_probe_device+0x78/0x160
> >>    driver_probe_device+0x1f/0x90
> >>    __driver_attach+0xce/0x1c0
> >>    bus_for_each_dev+0x63/0xa0
> >>    bus_add_driver+0x112/0x210
> >>    driver_register+0x55/0x100
> >>    ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
> >>    [...]
> >>
> >> Commit f6b8ab32e3ec made the mailbox functionality optional.  However,
> >> some mailbox functionality was merged after that patch.  Therefore some
> >> mailbox functionality can be accessed on a device which did not set up
> >> the mailbox.
> >
> >cxl_memdev_security_init() definitely needs to move out of
> >devm_cxl_add_memdev() and after that I do not think @mds NULL checks
> >need to be sprinkled everywhere. In other words something is wrong at a
> >higher level if we get into some of these helper functions without the
> >memory device state.
> 
> Right, so we can move it directly into cxl_pci_probe() - just as with other
> mbox based functionality. This leaves me wondering, however, what to do about
> the cxl_memdev_security_shutdown() counterpart. As with the below diff, leaving
> it as is and just adding a mds nil check might still be considering a layering
> violation in that it would be asymmetrical wrt to the init; but this is tightly
> coupled with cxl_memdev_unregister().
> 
> Ira does the below fix the crash?

I had to apply it by hand but yea it fixes the immediate crash.

Did you want to submit that as part of other work?

Ira

> 
> Thanks,
> Davidlohr
> 
> ----8<-------
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..4d1bf80c0e54 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -561,7 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   
> -	if (mds->security.poll)
> +	if (mds && mds->security.poll)
>   		cancel_delayed_work_sync(&mds->security.poll_dwork);
>   }
>   
> @@ -1009,11 +1009,11 @@ static void put_sanitize(void *data)
>   	sysfs_put(mds->security.sanitize_node);
>   }
>   
> -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)
>   {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct device *dev = &cxlmd->dev;
> +
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = &cxlds->cxlmd->dev;
>   	struct kernfs_node *sec;
>   
>   	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> @@ -1029,7 +1029,8 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>   	}
>   
>   	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_security_state_init, CXL);
>   
>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   {
> @@ -1059,10 +1060,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   	if (rc)
>   		goto err;
>   
> -	rc = cxl_memdev_security_init(cxlmd);
> -	if (rc)
> -		goto err;
> -
>   	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>   	if (rc)
>   		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f86afef90c91..441270770519 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -884,6 +884,7 @@ static inline void cxl_mem_active_dec(void)
>   #endif
>   
>   int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd);
> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds);
>   
>   struct cxl_hdm {
>   	struct cxl_component_regs regs;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..5242dbf0044d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	rc = cxl_memdev_security_state_init(mds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_memdev_setup_fw_upload(mds);
>   	if (rc)
>   		return rc;


