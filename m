Return-Path: <linux-kernel+bounces-69672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE7858D25
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32EC283729
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F31BF3F;
	Sat, 17 Feb 2024 04:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0PG0G+t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A7149DE6;
	Sat, 17 Feb 2024 04:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708143787; cv=fail; b=mGd1syh15VtfWYW10lXsWn3p7bUXK9Y3ItyguI4UoYWmj+mdTIIr3/osZE5NIs9JaEf+bLgY6TTp6SDeCN4PYX3t/I2TAo6DlA6t92em7q1XWPtchBrKWGfyPK6lXQwFqfaW/TJsNCsX6Qnqzmly6T+uKuAKnV7Z1EM5+cpK+rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708143787; c=relaxed/simple;
	bh=7uF32yBIuk85Z6sPmVD0TgrIUDLC+cIfX5qt0/Sy5aY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E3Q3pZe4o1vCT/bFfX91zK6BA0EEydjLL5AjsIDiV/NvzZpvFvZuqOjZzlIr9NHXWAFkvjEY5HZGGdeR7ieJeju7nOfCD5gGSXCb36cBwZ7HgnTxBwEXgKrgv/LF0+gJgOe1SU14ROHBVg79UM4SqcuOhdWcFL3NFQ4ITk3fLE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0PG0G+t; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708143786; x=1739679786;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7uF32yBIuk85Z6sPmVD0TgrIUDLC+cIfX5qt0/Sy5aY=;
  b=n0PG0G+tZTdNmuoty/qM8E2+3q/Wd3z1IMtN4jldG1OEGnyJLX/+1F2j
   7u36erWSzHXkh1nTUT+fJvm2nurdcXbc7ohE1NzHLFbGJUbrNKUORhH2O
   ZzsADfWRNmFJEBCmZpk6zybMmcxnLYDKQeyywF0Fsi0y2LXobfsEh3X60
   TZU1nIzJyE5dN+G2Bta6EiUepus+fHbtqOhWB9wH6CXZU3PaIYC2u2Fzp
   OYklUAbtf+gPmBc7KzSE30JcuXQDdb4E4Xcrup5LatpC6/77J0kKiq6Ee
   ctDV2RWqW1C+F/bhI50yx/cOkb/voOmTu8+JJzgTswVSlU2i+YedDuWQt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2429341"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2429341"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 20:23:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8697263"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 20:23:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 20:23:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 20:23:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 20:23:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4j2ATE4TZKPckPhwNNg7aY/hka8LFP3T2YoNssPwFj60P0blJuUI2DXts3oufkrVF22T2U6pwi5T82vW3VPoI2LMdSooQA1O/XBfNXNPJrIGepW6SaA9GC9H1nfVFvcpvb2K4Mx3SX1rdeJ87u7yeVWQBoxaw+AA60WeJWCcwEFW4Hk8C2hMnbWJ3uLrjnPJkMjacArLxtSmThumlvvWdJobqgvq+HKRPzMTIX/xL9drNN+5Rj0QwN521TZG62DXAzyX/ZOFScduMlhXDcgwNZ2g4hmwLa3wNn1fAIguPSOM31FDUu33B3im8AiaUHr97VgcjpVK7TXq0yjdiYDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcLXqLWqyal0uWPw7LGwSA3EdsRIslD5OitVB+/RTwo=;
 b=BpQLtac7w0+hJSFJ+7jtNPhac4LjQYYcUCFxZVSAeNgqDxc8obmxBk9CvGL8ETw2MVP7h822TEkxXvdKMNw+15rwOC41IYIhkb+Zy5dtbtyEVyGPJ5h/9h+GST4Ncbm7l0rX4Ifu84c0RY39etVPUuqKs44eqbNTL4WcwGPXJCXxFHx1U9RWrUNR14EqzNfwvkaRqsRkZjNAGL9DSfP5ccB+upSK4aQP8XKWZCnLM6dIVnjfM3fwLF3PcgK8eBmotjTSLiEPdvsGn8uut65o4Z5408JNUkvgIh5pWgpRtI0fHiViTXGv4VG2pQetckVOLD9lIRV74/lKqlPd9BwEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 04:23:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Sat, 17 Feb 2024
 04:23:01 +0000
Date: Fri, 16 Feb 2024 20:22:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/pci: Fix disabling memory if DVSEC CXL Range does
 not match a CFMWS window
Message-ID: <65d034a22e258_29b129484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240216160113.407141-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240216160113.407141-1-rrichter@amd.com>
X-ClientProxiedBy: MWH0EPF00056D16.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1d) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 440f89b7-9a9c-4425-9592-08dc2f702072
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbsxYb37ZVMUXCyrI/YMqQdy9qAQTk7ixaqfXgkTjqjL0q+uvp946fndRXy3qXz3fOE7tGsVCjnVrs8oCwYg38IAzcT7+WAVqZx6Egjg3ZSLbbVWWzAckrXwPJUxcMfhhm0xlEjf0P3al7j1nBHncxnoV9zmp2hCIRLhlrEgFHSnaIPjxZidvqwCf9SkhT6/v6CwNF+w3x+e5a8QGK3JyhvY2VM6d1tWCTZSgy3kK+y3U57AYAGAqWInyOhpqHkjJ6vT7YSYhl3fmdUdvzwAR85j6gLbexM1MLpNWINqi0TcSEkqEEipT0SFDZq8pR3VoyDkDIk7Cx7BbrTGfS8xNRM8nlSePTcW/sCy8RI2IKEkHGtrpj/yC9o1w+5BgoskQGKWhYCa1nWwMex2HSlx3WxJPwRVkIWapSSTmMUt///VEy0nXoDcCGiU3nwQpRBkZ/wupjKJWI6pdMG7bR705ULiaJqhJzjfyxPkqfzeoaOIKHUKGRkIKdfN2OKvLX5W8ia4tNQCTkRFTD92dZvDN0qnGQ0jIMPAsw4UvMosw6ChLqndAljlfF10w/GAIQ0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2906002)(4326008)(66556008)(8676002)(5660300002)(8936002)(26005)(83380400001)(38100700002)(82960400001)(86362001)(66946007)(66476007)(6506007)(110136005)(316002)(478600001)(6666004)(6512007)(6486002)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nee7fvRadOHY7FEcvB2KRykYJ2a5516C3hG28QiEVR150X9B1jtkdTcYf4lV?=
 =?us-ascii?Q?s5qudwQUwhqCxvMLU/u6bDcu/uvelOFGId/rp916tJmjes8qHecK/vgldPKF?=
 =?us-ascii?Q?/00bkFUFjSki7z68989bWdE/m0U0LmM8UC7AQRYBUXUZ5ddQ3z/paD1k22oW?=
 =?us-ascii?Q?anuVhv2rfrx+8I6aqZy7y+EWLfNvLoyWkKLqgVKRQPxvRLshLfFq9QHdC57o?=
 =?us-ascii?Q?Pg+YY0JrV73vkGz1rVWBm8q88+7IB6W5PuBn8YEN3pUwTVO80ramkccOswQ5?=
 =?us-ascii?Q?N6JOmebcB9LeNJosm/mNxZVlKtoE1VKHulZSGRxpnBFLpQZ3ef9nxRB+UNoB?=
 =?us-ascii?Q?/vuckwhk4VLAuOcvbsYy8yOzZPeC+I4OvrH/NiO734FKUWTAKpvGvrooCZAi?=
 =?us-ascii?Q?2Wcd1W2AoAXbxZc8e4edzQfrf5sxhexbaM5OA67NDMKDDqodeXwEdmiGyntb?=
 =?us-ascii?Q?vi/+GHlNePXapGnya8E8LRyEHhZ/RqhaBnrbU+IlFURYBQ5gCzuKn9ZhE7cJ?=
 =?us-ascii?Q?93op0yGQ/8robPLelSn+JLVt7FqZI5VpbFVCIpSOIAO0H9uuSgAEaEvE9Ceb?=
 =?us-ascii?Q?wkVAozta0c0hWEhk5ZT55fQi4qB+6dxt39twEzI1pEyEtRjJd92Vg/GVFx4V?=
 =?us-ascii?Q?9124OF/isryysNbRhhHVikJ0hE9Gntml/HAZrIJcJ2xCTLIyFftw9xESAGoK?=
 =?us-ascii?Q?R1qxS7qKxNkeWbMeHkN7UCPa14LqBGzPZZGXrHHarkFenwWh5zjidzSyGwS8?=
 =?us-ascii?Q?xMJK+D9Znw8u7t8e3bERPY6/8Onoq9Ko7x6odWBQrhUtz8XtRlQ8y8VlBeKT?=
 =?us-ascii?Q?4oBKOpIqekKl/1zsuUd16fiO60x/W4fVh8yI2VFrHqj70qDX4fKi+BHIzo3W?=
 =?us-ascii?Q?RCXFk346tQvvj5krq2lUB5xm2dp9tQiNntPVYq5Pd9mUzI3Pa1OdjEpZw8Hr?=
 =?us-ascii?Q?4044iC2kQrAggf1uGkjjfeYQ1MMHtfxy+UaEamo4fICcXrlyyoBy7jhFDZxq?=
 =?us-ascii?Q?0EK4/qJeWf7UNwTbSHlz+Kb0eaD83Guvk+OfIb6CYqerAjEcczOZaZcIWZ7j?=
 =?us-ascii?Q?avk+N9wa4bPb5MVUlVxGXCvyks85ACCCMPqqLrBzyKX/Yim49zy4Vy3ON3Uk?=
 =?us-ascii?Q?F9sslxzk3skgQk/r/Or4KwgdwuYMAHZprcAbYLlP72s1LIEt/iJaRvtF0aBU?=
 =?us-ascii?Q?gcUUQzNfZb0E88MppiYG/9/SHEAgyebESuxWJFcDHnyG31wu8xXturF+3bUz?=
 =?us-ascii?Q?4Slyn1tH953UtirfTTTj1u1fMKaBSxowAcnTuhyn3adFbJH2y0ZqbaSje5c2?=
 =?us-ascii?Q?uKBlsj/dORHOx8D3y+WQvbAb50P/rmBq0lEjbPWW+Ss/7rAKOBxwe4w6LZdf?=
 =?us-ascii?Q?nCx68guw5fnNS+rtRk5TPQNUaaQzWaJn5rwHf4UcJ3+x7zt3sqLJmP+f0kUg?=
 =?us-ascii?Q?S9IPsq0ANdiXRvWgIyJnxyeLU+uMf9ta7TxKoQttIRYnUokbxUGw6TShOSPR?=
 =?us-ascii?Q?OOodQygXu/n60Vj/0XdvD7PR8jBrMQrrjjca/cBymyWKzmjETQ5ScC/3BZzF?=
 =?us-ascii?Q?+BzNvrd23HLv7cRLnH14g8RFTiUuRgk+TLAFUq85Yp8a1xTMELZ1PmPnhD65?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 440f89b7-9a9c-4425-9592-08dc2f702072
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 04:23:00.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7AZp9foDtbi+hqKuiUxyG00XBW2xc0CJ//DtQmjTtza3iPNDvWZ0nJdbG06KssduH8G/8FGgLTxfQa1nKizdS5ze+Axm7Ba55ddHqMirh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com

Robert Richter wrote:
> The Linux CXL subsystem is built on the assumption that HPA == SPA.
> That is, the host physical address (HPA) the HDM decoder registers are
> programmed with are system physical addresses (SPA).
> 
> During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> a HPA window that is described in a CFMWS structure of the CXL host
> bridge (cxl-3.1, 9.18.1.3).
> 
> Now, if the HPA is not an SPA, the CXL range does not match a CFMWS
> window and the CXL memory range will be disabled then. The HDM decoder
> stops working which causes system memory being disabled and further a
> system hang during HDM decoder initialization, typically when a CXL
> enabled kernel boots.
> 
> Prevent a system hang and do not disable the HDM decoder if the
> decoder's CXL range is not found in a CFMWS window.
> 
> Note the change only fixes a hardware hang, but does not implement
> HPA/SPA translation. Support for this can be added in a follow on
> patch series.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a0e7ed5ae25f..18616ca873e5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -478,8 +478,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	}
>  
>  	if (!allowed) {
> -		cxl_set_mem_enable(cxlds, 0);
> -		info->mem_enabled = 0;
> +		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> +		return -ENXIO;

While testing I found this needs the following fixup:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e24ffae8135f..e9e6c81ce034 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -477,7 +477,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
                allowed++;
        }
 
-       if (!allowed) {
+       if (!allowed && info->mem_enabled) {
                dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
                return -ENXIO;
        }


..i.e. Linux should only give up if it does not understand an active
decode region.

Now this SPA/HPA mismatch will still cause problems later in region
creation flow, but that's a separate issue.

