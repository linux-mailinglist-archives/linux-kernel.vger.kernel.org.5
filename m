Return-Path: <linux-kernel+bounces-7403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE8781A76D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE6C1F23AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6A487A3;
	Wed, 20 Dec 2023 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2iOiIx3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F848780;
	Wed, 20 Dec 2023 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703102141; x=1734638141;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DHnWweZdzNmkz3zq8r51TRb8G6EhcFwa/IiuYtEcezs=;
  b=W2iOiIx3p5ZBBKBSkwqK43U8qYDdgdqwwH0DfYFk64rCNdqIIXYnIUP5
   vzY4ySAsMUfNzyCbr0PHhiLnDtOIRVZJWkQ8k0Cnp/Xrm8atyvmLEVs5G
   jQuOzMWFhlfGu1QUSE909KAb4cOt+1yoIJWC7ajhh3o92HcvNnET8U4hb
   kMfsQwZMv8ignj/Wdk6OwcoeZsEO/qWcM6FQeO5g3b5ra+uZ5W+nmbbkH
   9Iy8CI85tVVPbsZ6KWsm19FfJzoVTi2i/sZk0wtH6ctqI8kJhv7hBXMGD
   WuhU4qaT8ucSteyjybdZHwr3IzCk2AVuPKMFgtgUr00KDf5lxn8YepWeO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="399700145"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="399700145"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 11:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="867080252"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="867080252"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 11:55:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 11:55:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 11:55:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 11:55:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 11:55:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbGndqBe4QVyG138qQlWMQ5yAm8M57WJcIGNvg3xsswWVG/qPOGjEEwsyde/52lB7KJUca2cVSv7IJ5OCneCaqS1aOZJ8iHQjmYeWylSSwzwXqK5+B7vz0v4r0z2RAMh6DtBNNB659O4wxuj55zoqIJgzCPhfVM49vkXG6XqsXsuggmTD2hWquQ46TE8mCNsSHyz0OCxzI+5yl8M8r6iOkRVy4p3+4AznUFvOIjTqY6pAZUTxh2kgjiQPey7eisg+SWrJo4g+3loz4INhpbRwtsJ5VVTsNTVq64ykcZRPHvr/CA99zFvdKi6lnwznZW/V9Ix+ELFNvrSiJXdbFmckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofnJaxb/GAgj+cs+2Z+EtmdMNvkQ2H3j87QWBXGqqgg=;
 b=lnE56KGIZmOnGqek/c0Y6LbVCfQAZE5LIV8BsFlPqszxeEOsRFRp87OVp1rF2SoK3Ad4czrYCCupfUxcENmbdjmYLGCiNOe610Q49Zli8cKIue3TxPOOmTS7m4WPolAINBSkSTBjMVPToTSt6QH2k75FNIzQGHVwIJZYECyy6cdN58MIYl636i6I/ikYYKGVZIVA0bWzY3VTrf5BIBHtWfvpyrvV+pKzi7gnAWLjjOMBbwksNVq7KUjhKkiVoD+4XcGctseB6Ga/XtH88dycOz6pMv5XiooDe7UdKoG9tY92h71zbjJI52lySlk+G7F663fuhxvMseWEGkS8AqvBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BY1PR11MB8079.namprd11.prod.outlook.com (2603:10b6:a03:52e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 19:55:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 19:55:36 +0000
Date: Wed, 20 Dec 2023 11:55:33 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: fan <nifan.cxl@gmail.com>, Ira Weiny <ira.weiny@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni
	<nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 1/2] cxl/cdat: Handle cdat table build errors
Message-ID: <658346b553a01_34d57294d4@iweiny-mobl.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-1-715399976d4d@intel.com>
 <ZYHWZjsnQwcBEDpd@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYHWZjsnQwcBEDpd@debian>
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BY1PR11MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe3e8bb-294a-4b01-a9dc-08dc0195a254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15BrhTWtRZE+Qk6LDbY2t6zepZA9uvVcROZDNFuhd6Sz71gyYY6M4oENjl94Om+kUIJ4Az9w99YpnU4gcdE7m/orChGgqF7BgTujFnh9Jq3+pD7rWD4tH3n9peg0m3tRMyb5BhQ3q1wATK4jFiwlICj5c93BDfEzBT+N31JF0d01LfYVcHqZmdBvL3CyNPCQORPE/mNPOOxfYFB78+1PDzvLDEcnIvn14ExVLgEGN40WQir5pmMRlkS/rq0wctsNx5gzZ6GUPduhtz6ohuRnTRcx5/z4Al1YR88aquE4v/+XuaGnNdwJ+mMT7Cs4q2+/aMM2I0YwxrRRavvpgHhibQD+tbB61w6SA/37XMPwbX8aIzoGIezuGSHDZdoIfOnW+zrPA7Pl0TGrMLlQS+wfk4DZrYj8p4fgQ/NndZ8kBaqe0x4vyg5AUqo3s1P7YpL7zsLYMKwOICa4qo6WMqIw+vZOQ1kdJdGtOoiPfMz+71Qp/P3sQUqyvTOXXzblZlOnbTuGfDvMrDYHzSXiyGIk5P4ugzqfiqZW5caNXD+8URtz4Yy1RK35fR8mJpFmMvyv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(478600001)(6486002)(41300700001)(6666004)(54906003)(316002)(110136005)(83380400001)(9686003)(6512007)(86362001)(66556008)(66476007)(66946007)(8676002)(82960400001)(8936002)(38100700002)(2906002)(5660300002)(4326008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oTyTrqXBBxZ0qEvqmvYnzIeCfyrL+vscnPErl/bULi3yepqIvvdyn3nlzk07?=
 =?us-ascii?Q?BzRSMJbwEzcmvtvVjkBAjXIVn2BVYIhKX7H1l5NmXt5283bdODhWCTmzfk+q?=
 =?us-ascii?Q?4N4pZ3PwDbnOA4h2/kczb/YUEJ1YbNN+sirVSgXYsUaz29TwpYkustxYSxg+?=
 =?us-ascii?Q?vjVNOGEQJ0ctdn2qjaPahhiHH9DuJZKVWbmls0XuiTI07RfmaXHngeNlET4B?=
 =?us-ascii?Q?nh+FsyTsPln4TN/HeV4T9Cui278a6ZtiSeh3nGiEW7asOBjOt4w5ZUhG8xFS?=
 =?us-ascii?Q?LJBtvqoezzoXW5826aPZYOnHrRc2K9boKOzD3s6M7uhLstp4h7aKh8HVa5Wa?=
 =?us-ascii?Q?huPayvkMjSpkhQ4RKJ8P+yvpkZBtxCHxJiP2bT6hgwz+x9+w/w6sIFtR3+pq?=
 =?us-ascii?Q?UyXe0te93eMTPyfFezDVI5z8JlOU9zeAkoxeTcQux8LBQbOs9dHyB2OaC2KJ?=
 =?us-ascii?Q?GNytcdQoqYCj/f/ahIOe6svUEaj0BtzjveLjU18d6l+XI8nWtYrbBGv7FlBV?=
 =?us-ascii?Q?dlzTF77z9Pyf6CXOeqhhrjh/5XreLyDbftnPu4C82QxdV6bnIAYdnrFS39d0?=
 =?us-ascii?Q?v4VP/vTNbkYwWxkJ7Btu7Xp7cTv++A4gLwa4+6ZgoB2z1i9QLc/IWTK//rOf?=
 =?us-ascii?Q?02liun9+glzpNdP+C05fcvY+4OFI6KKw48hfvD2WT1vemDqI664YUufMTQ+K?=
 =?us-ascii?Q?njsxm+O3q0xjwfawkTC1sya3VGxWnObH9NzebHT8XaiN8t2B+idxYkNRCDij?=
 =?us-ascii?Q?FDpT6AUg/cTcADmiKRx/+IXXTcROEucN5bADY337t8hdgt7GPwiI77tCn+Fa?=
 =?us-ascii?Q?hOkZjRyrLpr6HiNnTkNVsplb12K4Z6RvL+TWU4O+/O8qZX8UNzPB2GduCRek?=
 =?us-ascii?Q?kWNIiBbw61AqZWIFLjg2BMKqskJV+lORrv6QnVCrm6SsbIUNKB5w8v08jfiA?=
 =?us-ascii?Q?ejXWhYJNo7pAqGwAn6ZnVe2frr6kLq1VpWlHrP1DYS4aEIwhM99g/BX/Vxsg?=
 =?us-ascii?Q?IEwVsxvMFUU0prY4c76KkjuW7PH6antJw1tfCVCgYawtlSuzuQjP59K4vhb/?=
 =?us-ascii?Q?3/Pmlk9c4uCSNImru8RDTj7lHlrK8kMcortdSxZh12Dmw1OHta1gM44cj0gw?=
 =?us-ascii?Q?DgeT1Oa9M3Z/3iUXRHFpDUdSeuPjovQD0TV/15443d/dP8RhbdE6oFJHnBeI?=
 =?us-ascii?Q?3wE71DVnYxYhn1Ra/6PhRGIaW8nH28+EDFFBfXrgNWCxplFUxbDe49FkIcCl?=
 =?us-ascii?Q?ThPbwnqMBiKus9z6uKO9bo4b/MQ0wkfLXn2+h2FXw0zIJZJtD5xS72jz4AGs?=
 =?us-ascii?Q?zFKw0HayUQKF0DZQ96sjKl5ukucHpZtHngq1EYCGe01dbPniq4n0nYLh7t19?=
 =?us-ascii?Q?kHCrG0tNfT0QIG0TaH4otF4LCQilSTwPXSuxMxtc751i8Xz63SCCG0dWFnEB?=
 =?us-ascii?Q?Lp3HAVm2qCodDr3UVSOCXfsvScQr82VNo+4A9HbwJKDbLAY3Z3Afk62ibLU+?=
 =?us-ascii?Q?BA2Dc74gKKSEfTKDsDHurIUTELizKCd3kfiSqIt+7PfTNnk6GvB95M0l1XW6?=
 =?us-ascii?Q?V+wn16vcBuznQxFLYTWmbWH6Wg+AJNxZJ4U/ak1fr23s0aebJ4OXFxSJzCLZ?=
 =?us-ascii?Q?m7YDm9YUI18jHrB4lu5eiHCw77T4l40fpGADtwV2OFlz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe3e8bb-294a-4b01-a9dc-08dc0195a254
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 19:55:36.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jw827Ks3XkD5+h16ShUXWlWj4G/f0Bbx0yDb6uflYVvLorG9ITpq4Ah3DVruErMZcA5Tbqb8JqeXwHwnEP8wrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8079
X-OriginatorOrg: intel.com

fan wrote:
> On Wed, Nov 29, 2023 at 05:33:03PM -0800, Ira Weiny wrote:
> > The callback for building CDAT tables may return negative error codes.
> > This was previously unhandled and will result in potentially huge
> > allocations later on in ct3_build_cdat()
> > 
> > Detect the negative error code and defer cdat building.
> > 
> > Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> > Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  hw/cxl/cxl-cdat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> > index 639a2db3e17b..24829cf2428d 100644
> > --- a/hw/cxl/cxl-cdat.c
> > +++ b/hw/cxl/cxl-cdat.c
> > @@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
> >      cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
> >                                                   cdat->private);
> >  
> > -    if (!cdat->built_buf_len) {
> > +    if (cdat->built_buf_len <= 0) {
> >          /* Build later as not all data available yet */
> >          cdat->to_update = true;
> >          return;
> > 
> 
> The fix looks good to me. Just curious how to really build cdat table
> again when an error occurs, for example, the memory allocation fails.

I did not go that far as I am unsure as well.

Ira

