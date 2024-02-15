Return-Path: <linux-kernel+bounces-67420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFD6856B41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD5D1C2319F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE22C138495;
	Thu, 15 Feb 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ES5pa9ot"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282413667A;
	Thu, 15 Feb 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018752; cv=fail; b=gsLaJHITjEuIK++RpC+7f7zEPBp6wJaJfgbxySNhwDWh4DjKa+M+BfX4aqCo3xKSsjrt6QZOl4l75CAaaDedLDIfkFt0vP8zJKTAyljbRdPs0Bpk+v8NV29i1oSZFkGB5bTsaWJmX8uR01XYC8C/AeSdpDluO9BGI+hnf9mXeww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018752; c=relaxed/simple;
	bh=XQA3MygPPT4uM8qV5Gbxvxl0Omxbhyn/oSlB/2WDvns=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RXACDlVTkELyn/2JXm5YzyJSBna5FF8ycbK733NvWGMNOKKyKi7IJPfF98a1JLR26lEBjiGAe6/bb7rWkiLxgZOeuvLO7BTBnj/yUiOFKsbwRVeqe3JVCwEP4vnrH/YQDQhLBpMOKk1Ka5CY7WIbs6jav/LCbL4OpaXTRYixlYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ES5pa9ot; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708018751; x=1739554751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XQA3MygPPT4uM8qV5Gbxvxl0Omxbhyn/oSlB/2WDvns=;
  b=ES5pa9oty0ereVwS+05r7/3GYU4fdzNaveHOUVhJ8TbE0HW7gQMiVm3b
   S0quA5lbTT8syZqox36egmNAINiQpUz4OY7pYY/AvW/IhUDq5sb2wzoin
   95+2M6QBCkcKIXcjRGW5KvfnTmMZbzzp5yrtGUkRaIQiS6EI2o4euTa+2
   k3Qaa2UqlAThMa/o0Umq3uU5UXL+gMVm/627oFYKjYDsnx9FXC5CGCDjA
   tZ4ONpwWTlXg/1P9/RhDSa/RoA5a6EVCos9kbkMDCkilNokO0tqbFZTDn
   56hpWU+g+SYIRwy9yjNdHnQ3JQQIPUUwTkfv8YIPdhEEsBpNEHtab4TyY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="19640170"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="19640170"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3579604"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 09:39:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 09:39:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 09:39:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 09:39:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA9cOF9PTgXWoOHjZXsvzJPCWuKCY6DHjFuYMlt9zFdBXyT4TbrWYP0mtucED4nUMmNOn4CMz0UgyNsEuGbCHGA/UH1DpHGENujXeKC3GMc3G1wVBzkAPLvMAuOL/WYFzeer+JveLmYV7GJFYS4R7VlNpAKTF3Dx0kycOKJMS8VQeT73jC1itP+HuLSSKicPkx22n7FexDOvkG/EEZvzENPh2AoJ2aJZXth/CSbTxMjeBj+DQRXI0XJRXfB4H1b2eo4NnxRDLmwYvyd5Kr0kYaJgbcwjByb4OfGtmsWllWNutDe1/PWOScj4V4SkUiBupvbr+mezUtxIvIayBwcDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ1cjV6IHqJiPVpw/GuzWTelfYI7XnjWt/QAjntUDGY=;
 b=F3lMElPe0rlZ0xDhqURFUvDDED4v4amMy9snGIlTe32oy2JTQoxon2oxBFCR9lt6RW9NpCau7Gt801lNvFFdbUFNHqUiE2JZosyQHNbBDl7T0bxqgHbV7IiQNt7dQQqXQdCPpzNgIkkC0zR/uQwl0DFCzDPnU/assrnm44zWR4eqNYBMkAnMPki74N2DvVoVm4xyynJn4YJkAF64HCbT6WAh6643dGuFzzIGsqPZdALZB53meNIDxHVgJif57VlJnzlDa7XoaPLY8VKJn8AlTJXW3lfNw8Gam7OClx/6nkSTo33Ud949c+fPW6fqeLPYMQ0X2LGOD+0uIjCCN7T0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 17:39:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 17:39:05 +0000
Date: Thu, 15 Feb 2024 09:39:00 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Steven Rostedt
	<rostedt@goodmis.org>
CC: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65ce4c3467d1b_eabd929437@iweiny-mobl.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
 <20240214102310.7ba53f3a@gandalf.local.home>
 <20240214181200.0000500b@Huawei.com>
 <65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
 <20240214173318.2be1f3c9@gandalf.local.home>
 <20240215092527.000055b9@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240215092527.000055b9@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b39f191-e7f5-46a6-3db7-08dc2e4d0148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSFwcDZ53RbOyCrBSgJSaNH61S1bRrKVQxPipdq3Y+mAjmCqL3odnH1WkFjM+PYHRyKIcTjOR4Q0bMnc+KV738ibukXbPIgMsjgPyna45BV1zQCkDuHpd9JYb+KH5mfhHYV5HlRcWazf+VSXOUkdqAHtnjrgCZ1tj65+12YRAffUN8SdZWfi3dxgQu0LLBQMLjWqf+HEEO1TMZRtxa6JtIgjFRcowEgCz3fFGeCZaI0BDbtaKD6dWft8hFK3qbjKTTCap0EVyyZPGko9IJ4lful1wuPQ9HMzVlMLJVsD0uTZNOpCvgkpX76wVbCEYQ19Nk6WCSxmIFsfZt4pBl5VVKjOzfqIhrVxdYIRDdnfc/dSvBmBzX811QhIymYHFqW5Es3ZU5yYEsDWV7NsbZO/kdIwPzPcmyJqhjAmG+J4BHndRAJhLHOyMEN/c+3gaV8ZsrkijM0LLv46n3PNNxdLoypL3vYfE9FVYkC8uLgZP8JbkB+q1mv/wJh0aM2mi2YkprWLEVsw8jbxFRX03CWyoRSRj8F61j6LrotovNMuE7Bujr6RX3btIcx4gXUs0xLx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(7416002)(4326008)(66476007)(5660300002)(8936002)(8676002)(66946007)(66556008)(2906002)(83380400001)(6512007)(26005)(82960400001)(86362001)(38100700002)(6486002)(6506007)(316002)(110136005)(54906003)(9686003)(6666004)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N/ZrAOwgw8Qp3nY7rktHATUaOLeemUMhr4bBK++gF/GOKmqZvsY/k5YU+SqN?=
 =?us-ascii?Q?p1kbMfYDR/LAr86CcwlLaAsdba68B66dyV/u23dTg52DOxLDfu6CPOHOexxA?=
 =?us-ascii?Q?pPx0BB6Xl8NbCVrwWoeHj1gsQIyY4Q7IPDzokCGVUOWvsajIWSynlBgBCzOa?=
 =?us-ascii?Q?rLB/KiaNNQiGl73TqXA5g3gnLi5S3sWebaBSJuS66l8phDaxlNvekSctX6Eg?=
 =?us-ascii?Q?gBmpG9MDZ4Vu2drrn4r4dO6jn2cRvVdlxnM7LV66xUnZUg50sx5t/PXUs86C?=
 =?us-ascii?Q?vNp1CqLpxKPoDki/P6p2RmeazjIXWE4PqiRRKY0fv1AOwwmaOK0mA8BHZS20?=
 =?us-ascii?Q?9NvzrxKF++QVikYrsbD0FmQRqlWOqgFT1ZQmzJW6ZdeB0as48n2zS+EIbPOG?=
 =?us-ascii?Q?yFQ4aO8AcEWt2ts2+QmyDvmGt4KuJKyagFxiCUaBsplijXKXCcbVtP7P5t4n?=
 =?us-ascii?Q?Yz2gPjht0KGlKYvvRay7AAgwKIQn46koKMy3Y9cw8Hl509YtvjH+q3lnSHUw?=
 =?us-ascii?Q?JiwIKycplAkzMK059P8lKnaO3FlWBFvd3OVuFztPRmBf66ofRCwaf0x7SpJc?=
 =?us-ascii?Q?8wWtVGDAH9pNJrTYTPDa9hq12sUv2opPrzIC5DLNixBL+friPtHvrs4UClGN?=
 =?us-ascii?Q?X1y2l0I7hpA1QkLK4fAlcaAt5ZpHSNG9a/2/K1InLxf7O5GVd12uaoGqw8MJ?=
 =?us-ascii?Q?NHrd35Xod0iVDl75t06TdR9ZuFi5iPmEgev0AtgmdWVWjE8vFEEJaK9mDgjr?=
 =?us-ascii?Q?HRFtrYYX1UqBBldCmHtb9e12nTHfwhqeNg/Akc48s1aUQdjMqPYqCZ2lUMnX?=
 =?us-ascii?Q?MJERdur2IzkN3OxjtB0qWHxuNnBOOBIGqeJ17vGFMn8TD/Lwd19yQHg5o8jr?=
 =?us-ascii?Q?2kEtPLaZYIEFpq4W7vZ9MIGyKB7BSkNAPX+iWKKWylBZ5juFV2fSrRFdRKyG?=
 =?us-ascii?Q?c7uapbtSmXzRZ+ifNadngU58krjzusbbZLWOC8fm85Pt3jL/78sIzWSGXwR0?=
 =?us-ascii?Q?qAV1aJ3+yICrqqI4wEpwSECxtV591c3QbIyh5qVxd8RA85jzx3KUxq4AFA6D?=
 =?us-ascii?Q?mjF0DvtddlpLKGDv82EjvqABPQ4ebLi6IdrBnIVuA34Ejq3TeiXM+LP579ma?=
 =?us-ascii?Q?Xrl0EE6BgPUX1dODUhh5ORellsjt923wNm0/MSt9UrPokB440k1PO2+kqA2d?=
 =?us-ascii?Q?AAgG/GRz/DDoOY7Ozb67uaO77otZRu32D/0LfCynMioPjMoMAaTUhqVyht9q?=
 =?us-ascii?Q?vDdpFfpFAcrsZm5LNDuuxWRqW/uLsQBvZ+9rFrr7WrQkn7T1+M5R632/dZTh?=
 =?us-ascii?Q?FcezTiH1NpCOnKgQddwGoQHklHeUhiNM1/ugJXKDDon5NGZ+Q7jNw0Ibi0hF?=
 =?us-ascii?Q?Xxtsu2Ebl2FMceESQYcq6FY9fYah7EpaiFrSvD3GL7rTgfFqgxlyiTT40dz4?=
 =?us-ascii?Q?LkK6+sjQpsn+qhKXvtfNvA9UrEmhtFdrAlnsMWQZp+s5D9QDRx5zmpgs3W5u?=
 =?us-ascii?Q?ynyoCrsMDPZCIS6UG+e6rTKXWqrSWNkbXeE4+ohn35Rq8pDVKo0CTEG6LQSk?=
 =?us-ascii?Q?OwCNt3Lz496DbgF7WYu/SlzTyYMc02XeRyy+eZgP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b39f191-e7f5-46a6-3db7-08dc2e4d0148
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:39:05.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3blzN/ow3mfVUcaMLINCEB/Kbiy+JM/cIOGXh6qbi/UlCzu08G1K+sLXJsg90ixsXHIPIG8WqKCwq2a0B00xYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 17:33:18 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 14 Feb 2024 14:19:19 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > > >     
> > > > > > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > > > > > assume this will be resolved as well?      
> > > > > 
> > > > > That pretty much sums up what I was about to say ;-)
> > > > > 
> > > > > tp_printk is more of a hack and not to be used sparingly. With the right
> > > > > trace events it can hang the machine.
> > > > > 
> > > > > So, you can use your internal patch locally, but I would recommend waiting
> > > > > for the new printk changes to land.    
> > > 
> > > Steven, Do you think that will land in 6.9?
> > >   
> > > > >
> > > > > I'm really hoping that will be soon!
> > > > >   
> > 
> > I may be like Jon Corbet predicting RT will land in mainline if I do.
> > 
> > -- Steve
> > 
> 
> 
> Agreed. Don't wait on printk fixes landing. (Well unless you are sure
> it's the year of the Linux desktop.) Reverting is fine for 6.8
> if you and Dan feel it's unwise to take this forwards (all the distros
> will backport it anyway and 6.8 isn't an LTS so no great rush)
> so fine to just queue it up again for 6.9 with this fix.
> 
> As Steve said, tp_printk is a hack (a very useful one) and
> hopefully no one runs it in production.

OMG...  I did not realize what tp_printk() was exactly.  I should have
looked closer.

Do we have evidence of its use in production?

I would love to not have to revert/respin,
Ira

