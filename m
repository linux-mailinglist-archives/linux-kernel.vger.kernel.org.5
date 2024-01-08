Return-Path: <linux-kernel+bounces-19817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E908274A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B55B21E81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5847A524C3;
	Mon,  8 Jan 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSQjj9di"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00915524A0;
	Mon,  8 Jan 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704729999; x=1736265999;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RZQGXST7mseHJQgA1kMyvVoARMAXMUQ3ZbW1SaKf0YY=;
  b=JSQjj9dioW4XZMQLOONY0v6GAXHXa/3GKYw3tF/D7rxtZKAjPauW7y4f
   8UvFmjmFr/EjdrZMEnbzHNOpg6w3WExSH7g61kEHdX6MffUDhajPPdnhd
   A8pFu8TrXAy1nD28nRJBmwOZ9ZNQKCsobtDJYyX7WEL1IjGk3N8stcp7H
   af/xIo9Jd3wOjG8MbAhVRqN2ntgjwq/zZTuCKDeC9CsCxrU7WnZGl//YC
   Vq2/sZ1LUMVaM++kcKX2IUMF9XAonoPrC8dWRKW82Y9NyaIjWBHVQOP/w
   ZqgVuNLNEH0LQicRddf6AbgqRRo2bq0+WnyjtYshoebIfQdxWiaYyIZS7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388371333"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="388371333"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="784896490"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="784896490"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 08:06:37 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 08:06:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 08:06:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 08:06:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 08:06:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcDCj6RIu8wKLGZubUIzafAl+7xNELY1MQLeRnO+z2+9urqw+nkmIp1x7+BbGFzyZLG7uwWxtHkYoI2A9tP/3I0IRoBgwbuCnrNNPd++v/ws2KKHzbjYJF4ZuRvU+9MbuytBJET9yl2n8FuTuQsABAbIX0qB54p/oUt7eEdjSsfngtUoEIEHev9EhwV/3hU92ImPu7HGwxfY3a8NUaDGA+0NQqT6sjpn/oivG89eAgiBFbYsjRhLNrxqGF8L7S/FPx1sP22nLIWnhHF80Jh6VjL7EJ59yTT7UkpfBEZbMH3Z7o3f0Ik6jd9Byw2vfF0xYwt6RUIFtqEvPuh2mpyVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjOX+qSE8GK4xoUy4xEYEZ4kkc13kZcm4ArdJyYr6/8=;
 b=KLdus9k98qjSThn9UHlbV0uqCMhBGqdAr2/gQs4OkgetuKjURSHl7A7o+E7x1SwXKHEqxwJTQCmY14JAxVHJOcgwhQyGJDjCnn2VbU3vcdB6EWtkgkbZjJE2MmQDgw+eojwsI9nPQtLCvjEYwFGRssgOn2+nY0tum+7dVDvXf9h5I8TGkvo8Z5eAeE4GJWYc08kqPErPqPf9E4mB1jZT9c9wZHfj/3ZrIDVJb5OrEhL/rkXvE9FVfIDouPzZV1KEM4Vju/BnoikHfjGsJnNNhdNtH7WawjGPcP3Ayu9xDKaiTCNlfcKgSksZQRjCovrJqTz15ugm3X7gawVSWy94qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 16:06:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:06:35 +0000
Date: Mon, 8 Jan 2024 08:06:32 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: fan <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 1/2] cxl/cdat: Handle cdat table build errors
Message-ID: <659c1d888a5fc_8737f29495@iweiny-mobl.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-1-715399976d4d@intel.com>
 <ZYHWZjsnQwcBEDpd@debian>
 <658346b553a01_34d57294d4@iweiny-mobl.notmuch>
 <20240108150318.00006eba@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108150318.00006eba@Huawei.com>
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcacd78-ec27-4353-c07b-08dc1063c99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxNPhtrmBGX0yABCyO0tTEyuPCoHAV7tsdbOjSCrzJi6A6thxpiZe1VHf7jEj8twZVP64epzE8xMGq0a9e0u3DucyTzCGr+7/4pdGa0VHG2/59FGx0xBPBGQ8fhCg4tugW1tH7elYm2SIOSCvlX/TaHD/ZUX7YXDWvjrabRMQ+wZgzoIhIvGjySi2OfHpZXUm7T9w1zRWszYJC3HpntQEzFZNIXAbqawAzp9ULatq8/H18TuJvEPhc6Q8puepT9kjLY7tWnMZlHOWTnmr3sqLd0AFRflBqFFOZeRjwNhvDhNuKX52GgwDJOcxh0ms2IIILICTOrlNvszyyjEdGOUcAXh4rpVJsN22zywRDmPu97McgVndWESAc5aZGTzhPT64BP5RDoFhFDGWP6KIb5uwdJFoi01Ecs9OtqEsrNY3QIn2QaEKxP3boO4WRiYCTRjUEqxeDp+g8xzblfi9WONTLhn0dtpcIQ5L2fvxWCv18fBJ/Y6Nno1p2nfXoZzD7BUsRcfWmO5bDctoTvt4IyAaWaDFjgHo+GbmQInjxFrOH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(110136005)(54906003)(8936002)(8676002)(6666004)(6506007)(83380400001)(44832011)(4326008)(66946007)(66556008)(6512007)(9686003)(6486002)(966005)(478600001)(26005)(66476007)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UWUbbJm2LctzpnCw9fNhmOafqgySorE7PD1zszdZ+NqlpUBnpKVFgOK6pQDi?=
 =?us-ascii?Q?uWC+s9FW9ZY2dtSi1Rpl4NKj4kOGTqDB3nBcSO1GqX4+l5IBSNzQSUid4thx?=
 =?us-ascii?Q?cAUEghe7thoW1CfrKc9Rx6BN+09V1J7C4ZEw/YA34Oejbrr0hV0xSDk6G8Gz?=
 =?us-ascii?Q?R+ftD7Kmpb61I8OF5ZJnTapBdXdIcWYV+dQF4xWbcfoVqzt1O/J5ereGtrVi?=
 =?us-ascii?Q?Gi6UbWo4kJUMjTLnELXQygBVDTBAI5tKVlp2QoQEclCUIwafBZdFejYxXTTO?=
 =?us-ascii?Q?yeFe2froZezxLpL6YSmfqYW9fhXl3+9/me4I4f3vinBMWgI8Bkw9GQQvu4m4?=
 =?us-ascii?Q?A3Cm0ivzX/dFnFApY/EejC4xwuPhpNe7ypxeFK1SyIvBONiD25Uyr2wtzz68?=
 =?us-ascii?Q?bafZISETijP8wPO0OGNou75/dQBPLHknlYURxjKeWmsApjHZFVVjJjNUiFHK?=
 =?us-ascii?Q?SWoaOptuhgNOc6o9iAreBpXZ3bwwWUA3Qi+KD+08O4byM0jKA6/T0bEpHjOW?=
 =?us-ascii?Q?m+PRiuyyFBLUJFEMZczBMoDdVO3+xvPaV4+mDrAGMH44mAWOhRYEMlFHPGhL?=
 =?us-ascii?Q?8sf+0xYSsy0kMkiUthOczOBy+g6H+n6KNO69B3Yp4LZTXuU0woqVNbFSQqWn?=
 =?us-ascii?Q?xp+OYKNEniSl7abFcFhDPNSdqkPE3tKEUKMm4JBU5jDK4BVZztODDtXwwREX?=
 =?us-ascii?Q?EihhKT/xPAaumRKgEtlARBudO9T49PzIZEVq4HqHDke0qmJz64QdVaQuBdjx?=
 =?us-ascii?Q?jlcw9sRjHCrA+fz1+3eFKn22Kq6WlSspETd/Z0cp6NqafC8iiJXWvbcahJkF?=
 =?us-ascii?Q?f95RZaDtMQ9b3jHunGcYqYfojH30rIP/JRj8Y27Gtv1aHx4fb1F3wS0Mfy2M?=
 =?us-ascii?Q?AnKTvCeYs7jTXxDY5gXfmzBm50GDE63uDDK6pjESFp1RVTNG73bzw0Gwc59M?=
 =?us-ascii?Q?17xUM4f6u3NbCa9zUHTx+atxvQyIjarUVxRJgkMEIChO6t6Db+I2KrKnq+eZ?=
 =?us-ascii?Q?eRLkPS2SrtgT1/Gm7FGLFq7n4fi/kbUEArNiarM+t4S0+G8/TIBfys+bJs2n?=
 =?us-ascii?Q?1swtrr42gq45zbJu3oNhnRKQRaVil3F/Na/0DhsrJV5T4/Nzj9o2zpV3luLn?=
 =?us-ascii?Q?7gkFZ9bWabgdccRFX85c+bSKDILp3RgX0bGTYP+o+y14yduYyMBHMVlxhGuX?=
 =?us-ascii?Q?vacOzPHx4xNyrNp0uraAJ2eMgynbrnlljNKexocA6knKNHqI4mhCBFVRIqMX?=
 =?us-ascii?Q?MgfPz/CeKYEYyha3ZhWwOgpvQK2N1y9Tc0h2zEYNn6+bR0o6ufrdaSmbGgzy?=
 =?us-ascii?Q?ywOWT+DkKOzEhVH8ttmbwBxdtXTDLSzax68rIQEjHQ1SsRr3RsDioU+38aLc?=
 =?us-ascii?Q?LHn9sKA07mkGwqXTywBeVas3me4Qo2H5MgXlrpE4bKeUqwvd8P0p2SoC3Yjh?=
 =?us-ascii?Q?Bx0vcRTFmnlqnOt7/NXSka3Pm8Uxg7tHJ9urIIKK3p/X1nRJUCmDhy5Ff6ob?=
 =?us-ascii?Q?PphZzlJkKPtX7TOL/Zz84oYamQ+hzYswiSzhhMfV0LlzEgOVxM7kFt6BlEZz?=
 =?us-ascii?Q?xRa1FhN6aLFS7t+/hpq4FG7oO+LLKcFwJfUYeEGd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcacd78-ec27-4353-c07b-08dc1063c99e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:06:35.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aFwXFDs/AYsSS4jpTWmFDBWZPmrZL/4sfYb3jnz3HzgNnGJ8JPrc8s1e6CQRB8xTjGwKAQPIA2g3fEQ445dZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 20 Dec 2023 11:55:33 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > fan wrote:
> > > On Wed, Nov 29, 2023 at 05:33:03PM -0800, Ira Weiny wrote:  
> > > > The callback for building CDAT tables may return negative error codes.
> > > > This was previously unhandled and will result in potentially huge
> > > > allocations later on in ct3_build_cdat()
> > > > 
> > > > Detect the negative error code and defer cdat building.
> > > > 
> > > > Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> > > > Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > ---
> > > >  hw/cxl/cxl-cdat.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> > > > index 639a2db3e17b..24829cf2428d 100644
> > > > --- a/hw/cxl/cxl-cdat.c
> > > > +++ b/hw/cxl/cxl-cdat.c
> > > > @@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
> > > >      cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
> > > >                                                   cdat->private);
> > > >  
> > > > -    if (!cdat->built_buf_len) {
> > > > +    if (cdat->built_buf_len <= 0) {
> > > >          /* Build later as not all data available yet */
> > > >          cdat->to_update = true;
> > > >          return;
> > > >   
> > > 
> > > The fix looks good to me. Just curious how to really build cdat table
> > > again when an error occurs, for example, the memory allocation fails.  
> > 
> > I did not go that far as I am unsure as well.
> Memory allocations in qemu don't fail (well if they do it crashes)
> Side effect of using glib which makes for simpler cases.
> https://docs.gtk.org/glib/func.malloc.html
> 
> There shouldn't even be any checks :(  I'll fix that up at somepoint
> across all the CXL emulation.  Sometimes reviewers noticed and
> we dropped it at earlier stages, but clearly didn't catch them all.
> 
> Which come to think of it is why this error condition is in practice
> not actually buggy as the code won't ever manage to return -ENOMEM and
> I don't think there are other error codes.

Ah.  Ok but in that case I would say that build_cdat_table() should never
return < 0 to be clear at this level what can happen.

Would you like a patch for that?  (/me assumes you dropped this patch)

Ira

