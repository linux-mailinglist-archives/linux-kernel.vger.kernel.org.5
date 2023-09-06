Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA70794537
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjIFVj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243608AbjIFVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:39:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C93719A4;
        Wed,  6 Sep 2023 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694036363; x=1725572363;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0/R4rfSYXaeHggrgb1CxSoO2Erpc+3+WksS/BZxzsms=;
  b=jSuhY0HNSR3m61omoglgBI4kgc91QnHXYoNJDAg7WVw0zAQ30YnWTawv
   v/N0KJxu5DhoWEgKMb7sx8nvdwMslmkfA/TJtbJXaRi5fAGeqbnDSD3ZR
   H4iqELr/Ab3rHazKCa99qVsytLAi27ezyLp6Y+G21/S2sKqleFLYTyZyb
   sZd/3uwv9iXHFxPEcW2MfGfHA8HpzLfr6PqP9dlgmpAT93kq6+LuuNW2I
   oazmhB5TVkm/F4XTuy6FXbKCmT9WsXAB2IwKMgbWC5Tx7/H14gvsvn/r+
   RUdtwvoK8peC7ZiwyVR2wtq1pH9OIPE2R5TTWcmgiT6Nh6yzCLPu9xHMj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362223688"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="362223688"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 14:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="988469779"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="988469779"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 14:39:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 14:39:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 14:39:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 14:39:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 14:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/KydPIL41mI1shQgRn3/2nJ203q9QCBBB93DoyVnMmQaD7zlVkCxkhwURnokNuVLgr7ri8Te/5ZEcF06mgTjjldhv/RHMzDI5nOeONFyE+U+1EZuVIxaAAFPb6rm3RIFd76V84ZKQeQdSlVkYSUo6l9kPJjvBEaHPDxPsKpBnTX9EgWD1LThThIWjSUlyh8LILCn9nI91gGzRjwG8mZLv6L835sxuiXwvqxzR9tWde/tuREm7aCGKfjtJShYyhySLQAqxMtzK8wUmOXyzCyOgm9l8BV8aPnrpt/94oGoJa5hC5D5lbsKz8ecckOAVZmehe76pjnTE4f+OcSsAqCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQYC8AhHQqpk7fJbTr4j2kxTLhWAqZ9nIegg9ZU3oG8=;
 b=EUv1/5Zc07Am1roKpRpsUHDBgU3JiUHsD3ctSlglD6Hsb3o3rIVg7DiB1262tGIGj7wHVZxpCtM7PWJ+/asxVoOx3v8KHP0ePhxTyfgf4T+jxG4vozJwGqQUyYGNLnFveSGr4f3LDsuVfVtX0/XELrEgXRAhqQcxXTJZHxdc9F9Q1B5IHj1/i8ybKqAhE6rkuJYDn86cKc4P7lIMJ2tUK6seH/4fHhDb4/swQZv5CtgE4SU8jt4u910db+8dFJSKbzv+sRZzVTHbIJhPd8ePap7hFsg+gwBLKR6qgFB1nLcmkJwwj9G+6dxGp4tADQhKveJpqvVASz+jWp7lvoUFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 21:39:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 21:39:12 +0000
Date:   Wed, 6 Sep 2023 14:39:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 18/18] tools/testing/cxl: Add Dynamic Capacity
 events
Message-ID: <64f8f17d8dee3_1e8e78294a3@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-18-f740c47e7916@intel.com>
 <20230830132335.0000162e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830132335.0000162e@Huawei.com>
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dd0b19-ae75-4051-9d98-08dbaf21b60b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNcD1xUMOx2GYfrWo087d0oiR6A/O911qCHzYGMVZ5dLZZ141m9hDBuEpk+403PRWPifP1KEYONuH6Fnpo7cfuhoWdfJVrkyZgj8Q5pgBLDYfCd7dfZMqN0A5pN/gjAEmpDNUBEJcWQLYyXdPIV7pvSUYTwiqd06Vbvyoka3OxVmmwhJluogYjTjVpVsRJ8nDgOKM+w4aNM7AYmaOICa/hZlok/T67pOCRrD0V8HddART2Qp9lkC8W9xJDYom1XimTUwM6oHNR1pwvup0/80rdSCNtTHrYIVoGrvU4qlloqA3eNt+bXdxL9vBHKbtH9ImO/vqmf3zNWvD6F7qoVCM9ViS3oCzSTyRQ1dnfxaWl1BNa9QLGKMzIXSED/xHk5f+1kxo6Ae2IXCTxyjhbMYggdQaonBdYAEKX05G+cqgrNI160c0fa+EFL2Sb+3EZob11bGHgUR7111KSEylXy5QnwckZPHrt3Szldi3NqNmwOZkxwsT/TvWixltOmIkPmwYzfcypLBlXmmvyhFUHosXoQWfYV7qpADLOfygoDfGYOXmoOPZR03mQpfklayytIW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(41300700001)(5660300002)(44832011)(86362001)(6666004)(478600001)(2906002)(8676002)(4326008)(8936002)(316002)(66556008)(54906003)(110136005)(66476007)(66946007)(26005)(6486002)(6506007)(82960400001)(38100700002)(6512007)(9686003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+lKtYjbDJw1gEKea8IphM5eK2qphRIj1OoGkYenSuRfukoxuEqdQc2QdxZiE?=
 =?us-ascii?Q?elkTQ9QLIBZbIOuA0kOKG21Q2cS2lcm+OzK46v6rubyMazdxyg+sIk/RJFi3?=
 =?us-ascii?Q?BeRNGHJ9ARZBi1qPkjNl69+Mr+9WD/KxM+UXYvR61HaCMBfBeHeXSkHbxQri?=
 =?us-ascii?Q?Jv9CjR8r6dJQuNfvqcwZFKnK71BMBCSn/XMuH03Y0G6+7ZfLT3acHkdGEV5Y?=
 =?us-ascii?Q?Uy+2wrUk16vmsD9rMd26xqniJnY+UspHA91seOQgkINg01DMVuiorio4/TeF?=
 =?us-ascii?Q?eDPcFR0Afl5StXnyRA8OiqGIvLUdmeJ0kExI29P5LxgnymWB7noWHptuBFWW?=
 =?us-ascii?Q?eWMopUW/g2PjqG7OCj1KTw1tc9dZNOuhMae+pLgXO5FiMiADVvMGz9jGTIVE?=
 =?us-ascii?Q?a6PD9CoZyywktD7WCJPOjMyEBTMmLxB0hntvJuqrUCOQXi9FHsTAf6BBIZRY?=
 =?us-ascii?Q?O7vT/6+zkp2JKedHI3H2spaaN965S0ZLLhoqGO4aH+I0CGCl8uW++mI5hAbn?=
 =?us-ascii?Q?e0lawnpNlV/GLAvw7FYasfMy+JfeapwAIgI0T1BrkPS0mOGEomF1JJS8/nDI?=
 =?us-ascii?Q?eyMyN4BzxfTA/HLsEzMNV1ujQcULaVT0doCi9nmBI/klgkiun0deb8sqVAaa?=
 =?us-ascii?Q?CS/xbf2rjkFC3A7i1mofFrtAvJ8f8lezN3WApcJet8bzFL+in2+2vvCanTWf?=
 =?us-ascii?Q?UXodxoLVqab0oPrRqmjLzwzBUc0OT2JCRbltUQba0JLrwK5OU3azao8FDwi/?=
 =?us-ascii?Q?wGOD3L1jx6TRCmqsb1E8A+STkKETTbr5Pj1b2m/h/5BguKMLRG6lPZSZusqT?=
 =?us-ascii?Q?rOQn+DqgN2QtIiexI1rrjedxLb1ZqX5RT3hQVw6uUkko/i30RBBbfHKTAH1w?=
 =?us-ascii?Q?1EoZCjlAP9I42FoZW4vyOdZbxI8qGomi80N+sPli3bGgW42GlcOqmOhwq6sj?=
 =?us-ascii?Q?6CGIGoypcDaMSe1J3ziRzY2KjycXM+pixN5VJQY2dM39vB/tELv0o3+SYjNg?=
 =?us-ascii?Q?Z6RfcJ3vTw676tUIe9I84EGUT3yr12YXJREk20tgFLtIchQ6LwcqblEWiFUB?=
 =?us-ascii?Q?6eSBkry1udCu3A84ZgsQ8hRIApnD3C4Bq7aDAIP/CImJ4HOvEygFB5pYWvIl?=
 =?us-ascii?Q?ZeV+Mi9Tnf8GoET4rXm33kEq+fx+YEgkIxaoJ+EQ6/Vdoze9CtxDHpEh4ybS?=
 =?us-ascii?Q?b+GtOYuvSutlU2mSGoT868f//ihYzN0HF5lypkw9zof7ys8WsDNMwBEpPVzI?=
 =?us-ascii?Q?NINKpMN4r8OvOmprH0iI9SWcfOUxbZCfygQ9voT6Z0DzxNHWbhT81YH7+R5J?=
 =?us-ascii?Q?+HM0LF8ebDo3JGyWgqjcrwMaLCTnFd0xuH7XKlV9vhja2QlhLz4xN3p6LyVc?=
 =?us-ascii?Q?86k+pBieIyu0tgRmPVJSu7STPr+6AlvlIi4gXyxf4Qg3AVZHfJqHW+PzRRUG?=
 =?us-ascii?Q?3lopzHH9LqFhh8lFz7JWl38qSZw6lOrfvfA6uN6gS0mEJTk23sHB487oaKNB?=
 =?us-ascii?Q?lA3AIbYrf82ls6Y3tbFrL7CzOAJjWg6RFxFM162L2aG3iitE45u1TfvDeSXv?=
 =?us-ascii?Q?xzEBQ1x8gB8eSenYAbuwITUZLrsaJK2hmoBa6py6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dd0b19-ae75-4051-9d98-08dbaf21b60b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 21:39:12.7535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cegVM0MzFw/zf8SoogcifkM2XMtYQC7TD4/JAxbYJUSsdgBD7F2xc+BobUBjtPJlA3bgqZ9IPqZCM0toMdaIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
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

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:21:09 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > OS software needs to be alerted when new extents arrive on a Dynamic
> > Capacity Device (DCD).  On test DCDs extents are added through sysfs.
> > 
> > Add events on DCD extent injection.  Directly call the event irq
> > callback to simulate irqs to process the test extents.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Trivial comments inline.
> 
> Reviewed-by: Jonathan.Cameron@huawei.com>
> 
> > ---
> >  tools/testing/cxl/test/mem.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index d6041a2145c5..20364fee9df9 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -2008,6 +2008,41 @@ static bool new_extent_valid(struct device *dev, size_t new_start,
> >  	return false;
> >  }
> >  
> > +struct dcd_event_dyn_cap dcd_event_rec_template = {
> > +	.hdr = {
> > +		.id = UUID_INIT(0xca95afa7, 0xf183, 0x4018,
> > +				0x8c, 0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> > +		.length = sizeof(struct dcd_event_dyn_cap),
> > +	},
> > +};
> > +
> > +static int send_dc_event(struct mock_event_store *mes, enum dc_event type,
> > +			 u64 start, u64 length, const char *tag_str)
> 
> Arguably it's not sending the event, but rather adding it to the event log and
> flicking the irq. So maybe naming needs some thought?

I spent all my naming energy on what to call extents at each layer...  ;-)

Yea I'll rename to add_dc_event() or something like that.

> 
> > +{
> > +	struct device *dev = mes->mds->cxlds.dev;
> > +	struct dcd_event_dyn_cap *dcd_event_rec;
> > +
> > +	dcd_event_rec = devm_kzalloc(dev, sizeof(*dcd_event_rec), GFP_KERNEL);
> > +	if (!dcd_event_rec)
> > +		return -ENOMEM;
> > +
> > +	memcpy(dcd_event_rec, &dcd_event_rec_template, sizeof(*dcd_event_rec));
> 
> devm_kmemdup?

Yep would work well.

Thanks again for all the review,
Ira
