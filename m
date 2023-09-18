Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9997A5135
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjIRRqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjIRRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:46:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB699103;
        Mon, 18 Sep 2023 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695059190; x=1726595190;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=g1bOw09U1xWfJu+HrV1A8bKpnvL17/3F4+AfcXqr3Mw=;
  b=Sb1qaiyuOxtKjxijJZLr1Ur+pVKPHouQKNJ3HxWkrQdze19w15lUNFii
   DWP4A1A9F9SIByTiicRuxlx2YC8Wq001IVl2lHr441rlZD8gIi/uc1mmh
   ZUSXx93PwTEImE+gwg7gje5sAVxULjqkvW3MsHReWEAo4iN36XQT8Q1fQ
   atQFrRonyPhA1WMw7N14YoPgxXFEtKvYTal9+DUlBon9NtZSQhiJ4Zttf
   KvW4YplS3kSt5TGTv0PzwDcBCSLMf5FovP3QOmlbhFWO4tKXXr7u7RxrF
   LyecRFo4TsbhQMmZoyaBBaFI6oSse4SHgDyh1t5zuNoAbTGygrPnWF5EA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="378637148"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="378637148"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076672556"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="1076672556"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 10:46:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:46:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:46:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 10:46:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 10:46:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvkFUHQq9O0FrkihrigXv5CuLhbKW2mCfvAR3Yw+OFIrF7LWoplAb4v/sRuZwbVfhF1lZTeigORDaPbF0EgpYGUtaEhMLCMm3Zzu4nbGMZ0XpCpszKcc6rZTWmWMQWZzycTTzHAy20LzEH15vaFlaTPpY5exa3yZbCjQY5fwGPcUGlXW4GoW4L0sA/LAM+LNa6AEvk27wl1SLWQUW5s4GtMp/jBqYkElXWSn4HbZ7w6Mo9YKM8HuxzkfgknZfU73rDRiSpV5cd16xY3H8V9HhN3wC7tqfLbLuqkLPkevVEaheO5LyBognZYpiRa+6Mo2RWV6pLGMT5gQ1U8kHUzzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zARtddHgh22zgMEIWy5g4AXpOFBmY/ugPr1RHMOYbGM=;
 b=b9DpDp5Qf4yeG221Nfi1qsdQhlpx8QKHVrs6uk/iD3poTRIRF1ZQ357qqyhVg32DEvaz1trdbnFW5kiub9gq+hSvDPRN2yI6e1IKsMmEdACJCbVdpPE2aRZdfOVoilhyT2U5KPlX+MwamXIwj6/X6BZCChUUUxa4fTwVPeNqhYkxMpaxJZ4qbJUHxwTuMsoLZBeFSgCriQIATQgVGEicLuHJCrQOtWRC1eKlJAcm66kNQyYDSdLJ4ZuX9KSqQIU4W1/4NFFz+TtRv1OHfcuEMZtm2e/Mj2FB53dSKq1H2VEG8m69SNYJvCQW1U2WnLLEjwIxtQuSZoBoq8LxBS+CXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 17:45:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:45:59 +0000
Date:   Mon, 18 Sep 2023 10:45:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 12/18] cxl/region: Notify regions of DC changes
Message-ID: <65088cd28d3ab_3921be29453@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-12-f740c47e7916@intel.com>
 <c6d4bd17-46c5-e77b-5dc1-ca5b9c9bf5d0@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6d4bd17-46c5-e77b-5dc1-ca5b9c9bf5d0@wdc.com>
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 35fc9647-49dc-420c-fb8a-08dbb86f1e3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: er21wiqRegUquLpEnXYdk1qcuDkJ+LP7piy6DG4ocW7A5wcxFjdHugPj4MjGI5uEqxeXsta71NxssjgjZ1i8sxeenudDoEAQhESH7Q2/lpUcckSfGZRjVtY12I/yZd3glvQZHZOOFFCxAgR/qN0jmLsK0NfK3rmiVcWueeNHlucbCJKfgk7tMm4BsINmXq99ZwGFzwpdnGN7tcgVaIXpXKO+vCHSDbF4+XBIR/UlT0SWQdktsvGBrgjDRw/N/+nNO0Dx6D28iUWfhT75ha4J4get4xAqlFySVDGHfuABBAY1oBZw9EjXuy+0+CrMpEztIMcXOqu2SicPd5gsuoL9ZT4RpbbQIMODM7bE6RbtXlN6QMWkqenY2aPCEdz82rtuC3B5jYs45cwzz5M8F+3vtRzzTDL3dvjvwtdafiEH5DDwIwdZ+0SPMuXnyZxNt34Ag1wBKuDttMidvI3jcAy5oueIEjH/g9wy6pHoQ4iO5IdEbJt5HzSDsDtBp0c3qQo+T9+kr1vxNXGmB1TC3i4lPVWg8C64srAO68QdxmcN8Ws10zYCzqItWngeqWsnoF/b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(186009)(1800799009)(451199024)(53546011)(6486002)(6506007)(6666004)(478600001)(83380400001)(26005)(9686003)(6512007)(66574015)(2906002)(41300700001)(66556008)(6636002)(316002)(4326008)(66476007)(44832011)(54906003)(66946007)(5660300002)(110136005)(8676002)(8936002)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5+dEsPk2RoJzltW1zV9PW52gX3vkvKPChn7wIM6bqiqni1fKHjkqpXaG2+?=
 =?iso-8859-1?Q?jJNI/Y2IWujidNq6Ku0GkCS9Rq9trYyd+ghFxjReXf8ryoGBQLb3xOnNmz?=
 =?iso-8859-1?Q?xOjN9PCGhxhWeZCA58OpKSXksVYmiOmpXZZxKWg2lfbTOYlQ2iIzWFpBK5?=
 =?iso-8859-1?Q?fsM9WhE7YZs3H+Vl3Y6lMdAOSCFDzEOC79mabrDp2Rc2Tez4JH11ZOAYCK?=
 =?iso-8859-1?Q?AReq+Hljzn63Y1TUv0GVqUUoev53onZJINAvZ5G5wPyLl4+G8BklWnByA+?=
 =?iso-8859-1?Q?LJDRATKT0ikky0ui1n7xDxP5ZZrSg6X0IXpU8p2kp05IQkbxwMF+8Pv/cX?=
 =?iso-8859-1?Q?lbGTD4nPDJanxX7uaUbxyU/V6C1yXHV711i4WXvwcBD+HRJgHLmLyM6dKx?=
 =?iso-8859-1?Q?M2iMP1RYaYIXQxBOuJdqdVstZUlhCPJGuHQmMwV8bpDYkZ5OawjOi0ImYr?=
 =?iso-8859-1?Q?wkdlJQm1mVyUUVb0EYEjf161qztiverJeOp1kUKWPNdV9Py5nbwxdZWQwb?=
 =?iso-8859-1?Q?DMcvI0TndwLVUf2kBueYfHkDU8Jjh8EvV6M/VR5+u2TbAxn3u5Law1TIL/?=
 =?iso-8859-1?Q?Rv60j1c8zIEAJ1j+aF0agaAM0XEGeKteTOpbu78IoGvJbzoyiZB62Ds9K/?=
 =?iso-8859-1?Q?D59xBkS7NNOSqgpBiD048fxTHw0NJLEROrCg60lWoHftnpDDgulAAzN48J?=
 =?iso-8859-1?Q?EFgHbEA184RTMJQQdVTaZ6XMRj8/kEfAZek19WIdpNybBEA7ylo1HS6pQI?=
 =?iso-8859-1?Q?BUjLJex7h9SF2YCHDOhszi4XQ6tc0qaBvebTOr5SaSh0BlyXwonT0xF3eN?=
 =?iso-8859-1?Q?AaLFVZu7Jl0SObi2WvNF5pAe3FoQV6NLN0CZ2qVnxKqIHEvLSsx3WpnSmu?=
 =?iso-8859-1?Q?ZRlog0t1ToK+CjoGTSpgFw+MDi+3SHRkbzkTIXHGa7uOwi7tiATMm1f34e?=
 =?iso-8859-1?Q?AXoxsMdHfWEwPM8CHDFmjNHzc2SuAbKtZJEvRKHaXptH0w333ry9dETQ2V?=
 =?iso-8859-1?Q?xQk4DKsF7CtDTKOkmP/DUii2MBVZluqPMuwU1LVWsPn0+/NUu2Ti/BFUGA?=
 =?iso-8859-1?Q?1KXJauoo6UfNjVRSsJk5E8eMWAs8nBDpL01l9uzULQZZbxed8i/tUnKssZ?=
 =?iso-8859-1?Q?wVgD/q02zyX/VxaHQPgmO7tyYgDdj5uDpAz+/9VEKBAt+G1VLMDzuTNepH?=
 =?iso-8859-1?Q?fEeSiuCXY9V8mN4mSKnS18XFuKGl6KoKpIpbtxE4AMLFHO1BbSG3owIFBI?=
 =?iso-8859-1?Q?OdFnvwUTywLS237udv/Y1bymm/YPzkGzpKy/+hKyU4fp2JyjFZNwBhtXc2?=
 =?iso-8859-1?Q?eMgCH2wI1bJrDYtKNN2kFv9zzqu8IzmadrDa77hkz0cJILwVHemZexTQDl?=
 =?iso-8859-1?Q?IYHWj92mP0qwZUi+YxF5PRg6dfwkvoUTijv6KnVqdPLp1AGCRz/jm8jxtE?=
 =?iso-8859-1?Q?YaEn7p2HP1W9qFgeVZqaD5nKfaignNZ/HJ2pYjZ3p/HWWKGi9RGRxdODKi?=
 =?iso-8859-1?Q?GB96kx1KavxuFL0ok+CF6YwIwCYSG/wi6ryR0k9G+Tfq+2/6fwFxUPv83E?=
 =?iso-8859-1?Q?stqOdJjFSfi9eZVOX31iWnHOYn+YN0XTj0IfU0PvpJ0qrLBe1Om4MmLXFV?=
 =?iso-8859-1?Q?P2L4wXCP7LmSoJtLfKvpqjzQYzvYgM2hNM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fc9647-49dc-420c-fb8a-08dbb86f1e3f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:45:59.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WjNux24j7x7SAeQgL3RFV8UsqGUXhsk+1V/gVfwd66nt7jNePsDGZUw9bPdmt0W6krsIiNX1cF4xK8tJALhUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7589
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

Jørgen Hansen wrote:
> On 8/29/23 07:21, Ira Weiny wrote:
> > 
> > In order for a user to use dynamic capacity effectively they need to
> > know when dynamic capacity is available.  Thus when Dynamic Capacity
> > (DC) extents are added or removed by a DC device the regions affected
> > need to be notified.  Ultimately the DAX region uses the memory
> > associated with DC extents.  However, remember that CXL DAX regions
> > maintain any interleave details between devices.
> > 
> > When a DCD event occurs, iterate all CXL endpoint decoders and notify
> > regions which contain the endpoints affected by the event.  In turn
> > notify the DAX regions of the changes to the DAX region extents.
> > 
> > For now interleave is handled by creating simple 1:1 mappings between
> > the CXL DAX region and DAX region layers.  Future implementations will
> > need to resolve when to actually surface a DAX region extent and pass
> > the notification along.
> > 
> > Remember that adding capacity is safe because there is no chance of the
> > memory being in use.  Also remember at this point releasing capacity is
> > straight forward because DAX devices do not yet have references to the
> > extents.  Future patches will handle that complication.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v1:
> > [iweiny: Rewrite]
> > ---
> >   drivers/cxl/core/mbox.c   |  39 +++++++++++++--
> >   drivers/cxl/core/region.c | 123 +++++++++++++++++++++++++++++++++++++++++-----
> >   drivers/cxl/cxl.h         |  22 +++++++++
> >   drivers/cxl/mem.c         |  50 +++++++++++++++++++
> >   drivers/dax/cxl.c         |  99 ++++++++++++++++++++++++++++++-------
> >   drivers/dax/dax-private.h |   3 ++
> >   drivers/dax/extent.c      |  14 ++++++
> >   7 files changed, 317 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 5472ab1d0370..9d9c13e13ecf 100644
> 
> [snip]
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 0aeea50550f6..a0c1f2793dd7 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1547,8 +1547,8 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
> >          return 0;
> >   }
> > 
> > -static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> > -                               struct cxl_dc_extent_data *extent)
> > +bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> > +                        struct cxl_dc_extent_data *extent)
> >   {
> >          struct range dpa_range = (struct range){
> >                  .start = extent->dpa_start,
> > @@ -1567,14 +1567,66 @@ static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> >          return (cxled->dpa_res->start <= dpa_range.start &&
> >                  dpa_range.end <= cxled->dpa_res->end);
> >   }
> > +EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_in_ed, CXL);
> > +
> > +static int cxl_region_notify_extent(struct cxl_endpoint_decoder *cxled,
> > +                                   enum dc_event event,
> > +                                   struct cxl_dr_extent *cxl_dr_ext)
> > +{
> > +       struct cxl_dax_region *cxlr_dax;
> > +       struct device *dev;
> > +       int rc = 0;
> > +
> > +       cxlr_dax = cxled->cxld.region->cxlr_dax;
> > +       dev = &cxlr_dax->dev;
> > +       dev_dbg(dev, "Trying notify: type %d HPA:%llx LEN:%llx\n",
> > +               event, cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
> > +
> > +       device_lock(dev);
> > +       if (dev->driver) {
> > +               struct cxl_driver *reg_drv = to_cxl_drv(dev->driver);
> > +               struct cxl_drv_nd nd = (struct cxl_drv_nd) {
> > +                       .event = event,
> > +                       .cxl_dr_ext = cxl_dr_ext,
> > +               };
> > +
> > +               if (reg_drv->notify) {
> > +                       dev_dbg(dev, "Notify: type %d HPA:%llx LEN:%llx\n",
> > +                               event, cxl_dr_ext->hpa_offset,
> > +                               cxl_dr_ext->hpa_length);
> > +                       rc = reg_drv->notify(dev, &nd);
> > +               }
> > +       }
> > +       device_unlock(dev);
> > +       return rc;
> > +}
> > +
> > +static resource_size_t
> > +cxl_dc_extent_to_hpa_offset(struct cxl_endpoint_decoder *cxled,
> > +                           struct cxl_dc_extent_data *extent)
> > +{
> > +       struct cxl_dax_region *cxlr_dax;
> > +       resource_size_t dpa_offset, hpa;
> > +       struct range *ed_hpa_range;
> > +
> > +       cxlr_dax = cxled->cxld.region->cxlr_dax;
> > +
> > +       /*
> > +        * Without interleave...
> > +        * HPA offset == DPA offset
> > +        * ... but do the math anyway
> > +        */
> > +       dpa_offset = extent->dpa_start - cxled->dpa_res->start;
> > +       ed_hpa_range = &cxled->cxld.hpa_range;
> > +       hpa = ed_hpa_range->start + dpa_offset;
> > +       return hpa - cxlr_dax->hpa_range.start;
> > +}
> > 
> >   static int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> >                                   struct cxl_dc_extent_data *extent)
> >   {
> >          struct cxl_dr_extent *cxl_dr_ext;
> >          struct cxl_dax_region *cxlr_dax;
> > -       resource_size_t dpa_offset, hpa;
> > -       struct range *ed_hpa_range;
> >          struct device *dev;
> >          int rc;
> > 
> > @@ -1601,15 +1653,7 @@ static int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> >          cxl_dr_ext->extent = extent;
> >          kref_init(&cxl_dr_ext->region_ref);
> > 
> > -       /*
> > -        * Without interleave...
> > -        * HPA offset == DPA offset
> > -        * ... but do the math anyway
> > -        */
> > -       dpa_offset = extent->dpa_start - cxled->dpa_res->start;
> > -       ed_hpa_range = &cxled->cxld.hpa_range;
> > -       hpa = ed_hpa_range->start + dpa_offset;
> > -       cxl_dr_ext->hpa_offset = hpa - cxlr_dax->hpa_range.start;
> > +       cxl_dr_ext->hpa_offset = cxl_dc_extent_to_hpa_offset(cxled, extent);
> > 
> >          /* Without interleave carry length and label through */
> >          cxl_dr_ext->hpa_length = extent->length;
> > @@ -1626,6 +1670,7 @@ static int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> >          }
> >          /* Put in cxl_dr_release() */
> >          cxl_dc_extent_get(cxl_dr_ext->extent);
> > +       cxl_region_notify_extent(cxled, DCD_ADD_CAPACITY, cxl_dr_ext);
> >          return 0;
> >   }
> > 
> > @@ -1663,6 +1708,58 @@ static int cxl_ed_add_extents(struct cxl_endpoint_decoder *cxled)
> >          return 0;
> >   }
> > 
> > +static int cxl_ed_rm_dc_extent(struct cxl_endpoint_decoder *cxled,
> > +                              enum dc_event event,
> > +                              struct cxl_dc_extent_data *extent)
> > +{
> > +       struct cxl_region *cxlr = cxled->cxld.region;
> > +       struct cxl_dax_region *cxlr_dax = cxlr->cxlr_dax;
> > +       struct cxl_dr_extent *cxl_dr_ext;
> > +       resource_size_t hpa_offset;
> > +
> > +       hpa_offset = cxl_dc_extent_to_hpa_offset(cxled, extent);
> > +
> > +       /*
> > +        * NOTE on Interleaving: There is no need to 'break up' the cxl_dr_ext.
> > +        * If one of the extents comprising it is gone it should be removed
> > +        * from the region to prevent future use.  Later code may save other
> > +        * extents for future processing.  But for now the corelation is 1:1:1
> > +        * so just erase the extent.
> > +        */
> > +       cxl_dr_ext = xa_erase(&cxlr_dax->extents, hpa_offset);
> > +
> > +       dev_dbg(&cxlr_dax->dev, "Remove DAX region ext HPA:%llx\n",
> > +               cxl_dr_ext->hpa_offset);
> > +       cxl_region_notify_extent(cxled, event, cxl_dr_ext);
> > +       cxl_dr_extent_put(cxl_dr_ext);
> > +       return 0;
> > +}
> > +
> > +int cxl_ed_notify_extent(struct cxl_endpoint_decoder *cxled,
> > +                        struct cxl_drv_nd *nd)
> > +{
> > +       int rc = 0;
> > +
> > +       switch (nd->event) {
> > +       case DCD_ADD_CAPACITY:
> > +               if (cxl_dc_extent_get_not_zero(nd->extent)) {
> > +                       rc = cxl_ed_add_one_extent(cxled, nd->extent);
> > +                       if (rc)
> > +                               cxl_dc_extent_put(nd->extent);
> 
> Hi,
> when playing around with adding and releasing DCD extents through the 
> qmp interface for the QEMU DCD emulation, I noticed that extents weren't 
> handed back to the device. It looks like there is a refcounting issue, 
> as the kref never drops below 2 for the dc extents. So I was wondering 
> whether we should only put the dc extent here on error or maybe always 
> put it?  cxl_ed_add_one_extent() also grabs a reference to the dc 
> extent, and that one is put in cxl_dr_release(), but I couldn't find a 
> matching put for this get_not_zero.

This is a bug I have fixed in the next version.

Yes the put needs to happen regardless of the return value.

...
        case DCD_ADD_CAPACITY:
                if (cxl_dc_extent_get_not_zero(nd->extent)) {
                        rc = cxl_ed_add_one_extent(cxled, nd->extent);
                        cxl_dc_extent_put(nd->extent);
                }
...

Please let me know if that does not work.  And thanks for the testing,
Ira
