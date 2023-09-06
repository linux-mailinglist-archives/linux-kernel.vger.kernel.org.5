Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95C8793471
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjIFEfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIFEfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:35:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76E18D;
        Tue,  5 Sep 2023 21:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693974911; x=1725510911;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mXdvslv0ebxG4zr79bn+LRRaB7d8RRrL/rSaPfFGYcM=;
  b=A5JyQ1lFZxuWmBUthobT47GAjnmMw2n48OxEI5CHmYD5MqYi7D/Ktc+h
   ZSLVc7/U1abhCaNdbJcL000O3wjHbW0KC89GpnZou+pHqp8WElcQOsaC3
   PmySpwYCHjtDujRoyVyzU0OUPxtPDaoFXpMK1yDMS/wpB51eQef5lum5a
   decffeOMstAoQpAUonS2tfr7cJAKJwNLP8p+UHqjB7jMPxT4juNsc7qva
   awLjCWPt4blFQVIcw8y695tL/CXwy3DXDFPch2qi7EflVLOwx4B5ZImYg
   IXA5D7g27HKzF3wUNn0uZqgrMQrH2I0K6AQTtaDKeg20UB6uxT7EIXlx4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374359911"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374359911"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="811508822"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="811508822"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 21:35:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 5 Sep 2023 21:35:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 21:35:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 21:35:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 21:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3eKz+OPKhE+3s6CIvFjH5/sDgkRjkB1DifgYBuOy6vvugiYrHnYfARQWK3INJHPuK896bOQeaTd1oQXTJkJZwvtW1acXk8XbiolShYLzcqEOst6smrimfK1N5CDAH0bad8rD67tjO69XnNemgu3cdIC8eUPxYgFAj0eqGZ30kVQa64bEL+d05+E8l8AEumE4KcXwi8bDpaDLXjDqpl9ypj+i2vhFLoau95q2dtVtAH+PALmWbUS4Qfv5oFUxq1I0AXIu2kKs8XaCfTOmzkYyyqHrNIJxNiufSUMb8aBiL2UEe5ZzR3aoskoPfWsqfLbgnmJmzdjDKf5yV5s3X4qjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cwqdMRqq1pNzdZsWeGMvECg9gImUgtizjex/6IIonY=;
 b=DM5OK6AmhDpG4yHf9VC39MsO35QH+LsTGZn47+Bssc/je1sjQyhlaqNKbCtTbOKywTvRq49v1dDuPFM20TwIoT4qsUPzGAsm/4AEXVsc3k4FwaCwrrAAtOatq1K5TChu0CnM6+dwhMZAND8rEmp5su6efMjjAjy6D7rrbh2NwWasbh8pIcTEo6rt2XCHnEduy35C3V4Wph7UX6DWin9RkHBss9oKBIXYuvQZ3+hLLWNcMSvC6GAiLCl1KQ20rGPupF8exDaJfRb+eT/Auvdmu6GNHeKm52iMY/o2NuqQWoFSTJ6HLdV+kXbsio1SlesfSCeHb74lIFXESUbUCDGPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 04:35:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 04:35:07 +0000
Date:   Tue, 5 Sep 2023 21:35:03 -0700
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
Subject: Re: [PATCH RFC v2 14/18] dax/region: Support DAX device creation on
 dynamic DAX regions
Message-ID: <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
 <20230830125025.00000fea@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830125025.00000fea@Huawei.com>
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 2783d416-4d94-439f-b363-08dbae92a5a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+fhubqm4gQ3Zgo/rtcXteerq2FD9kVV1rFzQuQYt/SEorsaAsSJD7dV/DkTPmky7UNgikTVw1bEYzVtjoqfcG/Sfca1aE9zJm9hx/w2VRNCGo5U1MNqdVBoWIEyzmvD+zNkhT0e2EGqkJbcfXEPKmPwKQi0SD9TSQ1AuHqHRLShvK7Su7s3L4SVF8NCCdpHR3uIeHYDo92B+RjPuf4i615BI7HTFDekCqK0u2QvLgDxmTNXD666YGH6TLVEPOZi2j7yVGvagPP16SWg0+k65VgM/mQNnLgiUMFqoxLU0rcM/2C5uMRqNBYzUBs8iJAyCeDEeAdK1FzcJL8fvuF3ON/DbMQ1V6zXyufLGc7LzzXf1gTfo37+DsC5YgXC2uEeudzoRJrq9majs6dlZV+oww3rqVlZ46SnR2hSoQdHHU89t8CEkmxSki77nixosN9DZ/vxoO28gN91Z1KfWJHBWP9lznEDy3tlkaL7uMX+nk5al/wRpuiIbyp0bEg4d5JVOl9ionhT6mNKKfyklvkdNHeovUJONqD0SLIWjZQ41TVs6k8bQmiR7Btj7JvyqX18
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(8936002)(8676002)(4326008)(83380400001)(478600001)(66946007)(66556008)(66476007)(54906003)(110136005)(26005)(6486002)(6506007)(6666004)(6512007)(9686003)(41300700001)(2906002)(316002)(38100700002)(82960400001)(5660300002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LAki+MDVD+SnKxPCd0rim/P/BnFbTnDotzYZxUmFpXbscZ0+x7XXe6RxCqiO?=
 =?us-ascii?Q?oto8+wtLhEc3O1j65WcuwXj++2cSgWXaT++KSjOAFUeuBqhXv1LPKfT5hNj0?=
 =?us-ascii?Q?8dfxFVWLDzjYbE4mwL72GJ9qmdp5S09XXSqfR9M4kregiGL7XUnjCfyusKmi?=
 =?us-ascii?Q?l0zrcZWQyU/wQyqk+U4FL0n+SbEby4TZVuK6C4FOrtbxyNtbQ+VPF59yhOm+?=
 =?us-ascii?Q?hLtFBaj6hDzH/p7wP5f8xJuyzl/+pszL1d1D40Xe+dCD+uuVlIRJHhASghaJ?=
 =?us-ascii?Q?7lLH7nLEhrIVHG3w92s30uJyHI//QrliNbrLJypOQ+nZ88gQsyRYsRceuOxH?=
 =?us-ascii?Q?xEVYmsIofNhbLRdZGn7UWab3ecmYbA1Nxz9f/+l3pS+yJ0E3Qf0yZX8a8Woh?=
 =?us-ascii?Q?+KmEXsI47h5xv5vKEGbqN4i1+cG3MwrpG+fKFgFZMLO2TRd8O6hyqtIDNgiS?=
 =?us-ascii?Q?AQrRnuoaDgAeHdW6gtJIhO/QZJe1K27QRlHR4M6jUwbqw99u0fcWrYg65nW7?=
 =?us-ascii?Q?DJbImrztbvkV7twEjuFApu2RccotUMUzUjlYppub2nln6TEf1rtwq/8gOpZX?=
 =?us-ascii?Q?LhdSHoZZ4f/1cLLFMJrf6Cmu9SJZl3kS7CEcnxmYtLzGDALVIyaukfjpETk5?=
 =?us-ascii?Q?m16F/WYISTLCuvddk7GPb1HKsjHrb225Ve1O5KoAAEYCn/kRbqNrJZXerpch?=
 =?us-ascii?Q?efMdD1s88L6Fl1/klvDt3ZDOUgnZbIJ5x8yoSmCkXC7FQ2lhy+3Xr1r4TZqi?=
 =?us-ascii?Q?BQvc5wKNsmHwCY6vUwK2Cz40rZnAB2WyJlAPlsc7/THl/Z3k7aoxRp+o/ZXA?=
 =?us-ascii?Q?/fkvRy7hnt/LDQ+6A7WyXu+YU8TnGkKF5aeEtVh+lrgjzir8Y1tQ9GY0KO1C?=
 =?us-ascii?Q?ejp/OZF5TP9r56OZT1JQiLOlmQzFdiMVY/pGatwmF4GgXgszuRegML6d3++j?=
 =?us-ascii?Q?L2q6Wwb3oCZj/vEe03uv8umfOBVGMOjef0w9/PMyC/+Ui8W6weFPYYq9vTXu?=
 =?us-ascii?Q?YIulRmry9Y9xYLTk7c1TbpQ+393Iqu1EOy7/oHJ2+Em9hp5ht6UaN5qu1faC?=
 =?us-ascii?Q?757X4lHS/BaR3Uc0rtXcFTM0mXulIN4R1ojrCwtWKMac30jvMRhp+ZUAMfaf?=
 =?us-ascii?Q?FqBNYd95btgBBP4mBciInj3VysbZzH0qfyoPL8anbR57NZn61Gt3k8vaUfH7?=
 =?us-ascii?Q?p6vZMqfnKgki+TBjAz5pcutz6k8t8nyyII5aM8Hgj5/cfTJBCkjOjojUXPre?=
 =?us-ascii?Q?KOOBCQyr+ahyCSBAOU9IDzrE+zNjwPx2kIpZdzN9jOU4DNfBZL9Bkeyxy/rY?=
 =?us-ascii?Q?aiAkpDbb96HKe9I97aKLAKU+wyjKcy2UW0ykU2tVVivGu8GhhM+DpiOAipq2?=
 =?us-ascii?Q?7U6BKChM7JKu1xsUk/Y1tu1AK0AQ8mi+KoBv1GOFVNBC/sTjOtqFthzSxZvT?=
 =?us-ascii?Q?cF1YX0bWwS3AXyMR6UjPnAU/mDqymddCS0lCKbq0P/rkjGAMZj5LGFQOGPo9?=
 =?us-ascii?Q?kr0Tmw9e2ajTp/QUSEMQyhehC0AjIZb2xT1kF37eK6oLuf+WQyH4ZEKbHVy6?=
 =?us-ascii?Q?wZFPt9mHj4BWk9tBuMINzc3TPWBQLodcL2uQUu5w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2783d416-4d94-439f-b363-08dbae92a5a8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 04:35:07.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiMOnQY8ImQImxSzC38opzEM5h0axZttqh8B1SU4BfT9eCG9idsgm7GWyTkl4LIT4BIKbWrM/0MDKseoNJTEpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
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
> On Mon, 28 Aug 2023 22:21:05 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Dynamic Capacity (DC) DAX regions have a list of extents which define
> > the memory of the region which is available.
> > 
> > Now that DAX region extents are fully realized support DAX device
> > creation on dynamic regions by adjusting the allocation algorithms
> > to account for the extents.  Remember also references must be held on
> > the extents until the DAX devices are done with the memory.
> > 
> > Redefine the region available size to include only extent space.  Reuse
> > the size allocation algorithm by defining sub-resources for each extent
> > and limiting range allocation to those extents which have space.  Do not
> > support direct mapping of DAX devices on dynamic devices.
> > 
> > Enhance DAX device range objects to hold references on the extents until
> > the DAX device is destroyed.
> > 
> > NOTE: At this time all extents within a region are created equally.
> > However, labels are associated with extents which can be used with
> > future DAX device labels to group which extents are used.
> 
> This sound like a bad place to start to me as we are enabling something
> that is probably 'wrong' in the long term as opposed to just not enabling it
> until we have appropriate support.

I disagree.  I don't think the kernel should be trying to process tags at
the lower level.

> I'd argue better to just reject any extents with different labels for now.

Again I disagree.  This is less restrictive.  The idea is that labels can
be changed such that user space can ultimately decided which extents
should be used for which devices.  I have some work on that already.
(Basically it becomes quite easy to assign a label to a dax device and
have the extent search use only dax extents which match that label.)

> 
> As this is an RFC meh ;)

Sure!  ;-)

> 
> Whilst this looks fine to me, I'm rather out of my depth wrt to the DAX
> side of things so take that with a pinch of salt.

NP

> 
> Jonathan
> 
> 
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/dax/bus.c         | 157 +++++++++++++++++++++++++++++++++++++++-------
> >  drivers/dax/cxl.c         |  44 +++++++++++++
> >  drivers/dax/dax-private.h |   5 ++
> >  3 files changed, 182 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index ea7ae82b4687..a9ea6a706702 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> 
> ...
> 
> 
> > @@ -1183,7 +1290,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
> >  	to_alloc = range_len(&r);
> >  	if (alloc_is_aligned(dev_dax, to_alloc))
> >  		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
> > -					 to_alloc);
> > +					 to_alloc, NULL);
> >  	device_unlock(dev);
> >  	device_unlock(dax_region->dev);
> >  
> > @@ -1400,8 +1507,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> >  	device_initialize(dev);
> >  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> >  
> > +	dev_WARN_ONCE(parent, is_dynamic(dax_region) && data->size,
> > +		      "Dynamic DAX devices are created initially with 0 size");
> 
> dev_info() maybe more appropriate?

Unless I'm mistaken this can happen from userspace but only if something
in the code changes later.  Because the dax layer is trying to support
non-dynamic regions (which dynamic may be a bad name), I was worried that
the creation with a size might slip through...

> Is this common enough that we need the
> _ONCE?

once is because it could end up spamming a log later if something got
coded up wrong.

> 
> 
> >  	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
> > -				 data->size);
> > +				 data->size, NULL);
> >  	if (rc)
> >  		goto err_range;
> >  
> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index 44cbd28668f1..6394a3531e25 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> ...
> 
> 
> >  static int cxl_dax_region_create_extent(struct dax_region *dax_region,
> >  					struct cxl_dr_extent *cxl_dr_ext)
> >  {
> > @@ -45,11 +80,20 @@ static int cxl_dax_region_create_extent(struct dax_region *dax_region,
> >  	/* device manages the dr_extent on success */
> >  	kref_init(&dr_extent->ref);
> >  
> > +	rc = dax_region_add_resource(dax_region, dr_extent,
> > +				     cxl_dr_ext->hpa_offset,
> > +				     cxl_dr_ext->hpa_length);
> > +	if (rc) {
> > +		kfree(dr_extent);
> 
> goto for these and single unwinding block?

Yea.  Done.

> 
> > +		return rc;
> > +	}
> > +
> >  	rc = dax_region_ext_create_dev(dax_region, dr_extent,
> >  				       cxl_dr_ext->hpa_offset,
> >  				       cxl_dr_ext->hpa_length,
> >  				       cxl_dr_ext->label);
> >  	if (rc) {
> > +		dax_region_rm_resource(dr_extent);
> >  		kfree(dr_extent);
> as above.

Done.

> 
> >  		return rc;
> >  	}
> > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > index 250babd6e470..ad73b53aa802 100644
> > --- a/drivers/dax/dax-private.h
> > +++ b/drivers/dax/dax-private.h
> > @@ -44,12 +44,16 @@ struct dax_region {
> >  /*
> >   * struct dax_region_extent - extent data defined by the low level region
> >   * driver.
> > + * @region: cache of dax_region
> > + * @res: cache of resource tree for this extent
> >   * @private_data: lower level region driver data
> 
> Not sure 'lower level' is well defined here. Is "region driver data"
> not enough?

For me it was not.  I'll have to sleep on it.  Technically there is no
dax_region 'driver' but only a dax_region device.

> 
> >   * @ref: track number of dax devices which are using this extent
> >   * @get: get reference to low level data
> >   * @put: put reference to low level data
> >   */
> >  struct dax_region_extent {
> > +	struct dax_region *region;
> > +	struct resource *res;
> >  	void *private_data;
> >  	struct kref ref;
> >  	void (*get)(struct dax_region_extent *dr_extent);
> > @@ -131,6 +135,7 @@ struct dev_dax {
> >  		unsigned long pgoff;
> >  		struct range range;
> >  		struct dax_mapping *mapping;
> > +		struct dax_region_extent *dr_extent;
> 
> Huh. Seems that ranges is in the kernel doc but not the
> bits that make that up.  Maybe good to add the docs
> whilst here?

oh.  sure.  took me a couple of reads of this sentence.

I'm going to think on this too.

Ira

> 
> >  	} *ranges;
> >  };
> >  
> > 
> 


