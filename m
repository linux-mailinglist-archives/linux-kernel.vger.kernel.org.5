Return-Path: <linux-kernel+bounces-106867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188C87F4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C82C282814
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90EF816;
	Tue, 19 Mar 2024 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUNuSgpm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF3363;
	Tue, 19 Mar 2024 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808725; cv=fail; b=pI17RIbBOr3r5LzC4IKcdPzqK9PHfsWuU6Es48VyQg49MRMBFA5ZLhmqBxt9lLTxi4U15FDAAp+GPT7JyQqVDE6sTcW5elppb8YDT0c7XMpysqlDEz2kcHnJVv87zF5rQzWobKvSGImWSPtN7D6Jg9lmZ7rhoCkfNZNI54Imhys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808725; c=relaxed/simple;
	bh=9vCMWBsq8oofUSwa32Mv2WtqX28zbe66zhytd7MXQKM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TFIf8iUg5w0lP7f18y8EI1q8v1p14fRpFn7+6gRUc4aW8NWu3uUncqQGlx8fo2aKcVnHofWmJw2zgH9yTNn6vz4UqpQxAVY92YvDU7ecms/tSoc2CrIuASJ5DgY9IbokZBsuchIzT908rhYEEuhyNT0HtI6ALm2Mw58i5nxeVkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUNuSgpm; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710808722; x=1742344722;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9vCMWBsq8oofUSwa32Mv2WtqX28zbe66zhytd7MXQKM=;
  b=ZUNuSgpmeGyDIhwEtyHjddNWYykH4WJm1CvcRPI0Zv2V3w3CRALmMN7o
   fTR9/KJcK8fWNLzh5SZlOEAsNzilqcuwPyf7UrltdKGFNsPlPtEBjPRG8
   YSOAerVQxcMrO3rsjO/2ByWiRfrXEi+8+8S8hBwy+nsV/u0AhJ9YwDpAB
   im0WD8rlwZsrnvsg32K32QPipcNhO2+lvsFpNs37hWOSXZF+9ux97awiZ
   WIpMVZVID3St/9rRQGa2CCKYpw/nh4r9vsHqzkPqjCx+2hRT2J7Gjj0xt
   8pfyaY/3Rz3OXgVhJqey9ngRT04NmNvFkALobJrFuEw05gymL+l8sKpEf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="23107998"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="23107998"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 17:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13528071"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 17:38:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 17:38:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 17:38:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 17:38:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 17:38:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9eSCTbB10Ur0u2k4vjGn97aM/QBbzZ99A3aQA3JijimPSvTpFbjiXcYOpeYCNMawN/GLdVxj2Phaa573nFkzAHInD5g3gxdM1JD6NPCdkXeurWzFjiKKCGA428Jin/F9MMemOleKfRzEZfRVZyACjpTjdUMFLAMSAOYJa8dOsUZA35gi2kY/2V0+CyuOu9N5yfU440ecvu1O1EAsq1xCPO5atQo4Ttuh2iFXDJ3wjQdxVRS1ljZilGrcRuxT0MCmHtJhX5hwZeBQ4+xlV0NUSO39dlEL29t+hTwo7iFrjOEDJJ/ppvgs3nGeijj4RGuBcgQMqRoy99FVryV1gmKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxjzJVYWHVGpiT2dMSV7se0OdUK/vqX3p1o722BlJKw=;
 b=f5DDtyTlLj+ORMPrORtiIpsCQr+gyxNYJamdFFTVsxxCQMNIsUBOupG+Jl9C+wacjeaeHySUOWVLII+iopHmIKCn6pXuB9BTY+Yb8Z9xtATtjL81pxjf++/VAU9Odcq6Ec8pp/GhWieecBJpY9cHuvoX/2+z8MgNuSS8CkX63pCHzT20AdHzi7dO+n3vf1WFHOJlniy3ZusQX+JTYL5daisJo21AsCHIxQLcS4Pl4rjy83/ZRwAYnNN03IO7u0PWx2zDFeVtunupVqOpv62tWfxmT3p5KdvZx+N/Wk/CBmg0VKmqNjRFX9EmfJR/OIrVeyV+oUNR4jhYVcmkq7SqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 00:38:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 00:38:33 +0000
Date: Mon, 18 Mar 2024 17:38:31 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>
CC: <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <chenbaozi@phytium.com.cn>
Subject: Re: [PATCH v2 1/1] cxl/mem: Fix for the index of Clear Event Record
 Handle
Message-ID: <65f8de878e8e1_7702a294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
 <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
 <20240318105748.000072c5@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240318105748.000072c5@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0309.namprd04.prod.outlook.com
 (2603:10b6:303:82::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6249:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2OcaL1W/S7pMJSPs1Jh8pF3nkct/Ub1fOlsYccyuqz4V7Q7A4iDyAXbFANAIrf98eIQ3H8yUmJNavAc7PbR1XReThpUiDmKL2O5QYd42uxQhSLSxo9Dm6sizv3LggMgsRWOy/DzugUY+0vMfUyHQtSxAMPfdDcmHH6RtTOTcVFpgb0/akrlGsTA6X4TZVhyaWGwwBpFyw7NVUwtYAmboM2bWaFdA3Ub9C2WggSO/yLfvFV19qgR85kpFU11e/EpuY38u6dSHLQ7TzFLRzEN56yl677oYLQsuUuqp5gQ5hCjuTobJINR+c2zztOwXiPkX7nCt5TUBtnba/FD94+vCROpxSFxhdVuhBBdolXuTmzbqSwFjyK9RNPbkpWwvHKPDofTL19gaJ3wAW+FOoCpA6pUprhLCe9Ad5XkaW+invT3LP06ACRRU5WubUghkcfBurHkXpyJeQV4/jYiUNlU8Jpuv47waWQTmfCBH7auhQLM4X5uLQr4X+yRUyodYnimA3ptqUqITd4IZy+0dQRoYcJtuqe0vs3Oc2qwV/z3grdKyjIBXB4I14P5ooOwo41yTYj13cXg+fUaW6ddOOAS/mjmqrRAXkQ93IH92nKhtRcENCct0A5jUf+8DkoIn6RflLTIx6wch1XaZqSPevBFOXzAfKgQ6gq+gB5zRultC6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9vr5/AH+aPXDOGng6t4/mWH/QiIqnPPbo/d6pgZNULE+evO47JjdOP5eDT4K?=
 =?us-ascii?Q?VIN4H2OtbsPMKXMqPPtr1pn78dj65tZ8zFE1KcOnURYD0vUgbFb6QfOC8FZj?=
 =?us-ascii?Q?ebloSMU8DlwdZi7vz4HQF+4vffhvuxnklA+t8PdkrcHEcDGQcYmyQtoosYWw?=
 =?us-ascii?Q?CVf5JQMGPtFPFZy2rz9hFX6rLdB+dK1npiqmgjJzSRv63r34FaC2ZLnBJjn0?=
 =?us-ascii?Q?+N4FBvj1hzeKe7d8MM0/FtIXIQXfFwvTKv5CZF6EBqdZG602IqTeKQnoLsb4?=
 =?us-ascii?Q?ZVG5uCKfvS2T8SlSwR1O3onFEhjOSm2s/jbgInwA28bL87sHQ9buYt60iAMt?=
 =?us-ascii?Q?oW+HjiwMcia8ctGnoX09bLyrsBbpT2TxcrMXbTyyB+vQ90Huyt3lAbsm+YSg?=
 =?us-ascii?Q?I7HdjHr1oOUwf31z4mOTzzWkBO8NmlPP7YEF+IQEe+Fr7HQx84Dn9gthT8Li?=
 =?us-ascii?Q?UQmObbIwp/ghWLKz6u2K9E1RUhSIGyKGZ6KJ6s5uH/A6C9owWm2vraAzH0TK?=
 =?us-ascii?Q?Cu2HkWFUgSFF6U2dxezkmU6rqtDDQUecxVp+KTv8WrIbUwXIjACvUPlDWnyk?=
 =?us-ascii?Q?cdvtk8A4Xtz7CXZ1fH86LfhcxZhWO2MmbImoH9SqH2hQz750FKbYbk3bHvpQ?=
 =?us-ascii?Q?xxz3VB26dxw9FEoCFhvGmFfLEDa95KjZuVhMyLNwBDOv6+qP6Yq3Nl3mazAX?=
 =?us-ascii?Q?wvmvXdYcYyhmx0lRc1G92zlMHOWciPmFedact1vmMVFDNk3SwRBbEUHUeD7h?=
 =?us-ascii?Q?KfpdxFMWypMLn7wauX4fHbLx2WN1EhwKx1ueWF0gRcQj2ZUc2d7Ch+WIrqPm?=
 =?us-ascii?Q?G/VuLwkbAGsZMhKJufu3qaFYT2Z4xFw4g2i79odmzBefR2F0N4zKWVBfHCjO?=
 =?us-ascii?Q?nqIdmniIqoDqKGZVNpOw3l6xZ4ezX8X3TGXdpV1vmSqw6ZtwQB1ZHt0ykBgG?=
 =?us-ascii?Q?WAttycO6dlgmOjy2i9/e2NUZaBm5nnjqjHddH5GSG7+qv0vpKvNI10RBJG+l?=
 =?us-ascii?Q?WZGabtDAndPM4JPg27M7SAFAVwhL2V8HD3ounnUDHQLMe+EY1IHO073YAVlZ?=
 =?us-ascii?Q?27DBRJujt1pXraZERf71JpAiLt4KA5gz28gBkEHsBGgusf3dxrVzqWOehCaw?=
 =?us-ascii?Q?TBZVJrvXfkQn/aZvjSzKj7PHA/dNnlgAaefnd6yjjOb80FnQIf3vGCP8wnQb?=
 =?us-ascii?Q?WXPQzoQjHQph5vuzQCOiVx0jwzgKME75OCLBtxlgZUplKHSDgprUm93cB55M?=
 =?us-ascii?Q?5PlcEjNoNpuhmhQ+JZA69/yagryhGbT2O9u+bS5lu7I+KWPyW8z1mzTcw4ii?=
 =?us-ascii?Q?RGHq/ArTQvDjYEqZdU7SOk9W5+6Tx+003c7zCulF73n5Mirf6BMWDzO1JfzE?=
 =?us-ascii?Q?ofQLP/mVfcCnufHS1l9PW2YqDRbRhQs+Vs76XzK6Ny68he/M2YxpKlIfQ/3k?=
 =?us-ascii?Q?atEF1xAtMAyV8wHBRPMktaYTNnS+Zov3jLUqKv9VyxiES+OKUUjfRE612jLN?=
 =?us-ascii?Q?NJfRnBhC2JhW81YFsZT6JfZEHQgTRSVqMmuZWPzJfxkEZBIj6pgTNiGejKe4?=
 =?us-ascii?Q?1JBFXkzTIfeV83xhUsZ2SOVPNLSo0IhPaeV/rddEx3Sxm17ueFryZa3/Q7Nq?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 657dedb3-694a-43ad-b836-08dc47ace818
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 00:38:33.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQyGKR7eYcXKtFnqIz+sHQfzUAGeM6vy6e3hVTyv209u+Fo+Sj9U+pz6MCcjPTeMklONuUdcLLnzzxSs6LyqL53nWME/MUmbtRQiHcn2ICk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 18 Mar 2024 10:29:28 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > The dev_dbg info for Clear Event Records mailbox command would report
> > the handle of the next record to clear not the current one.
> > 
> > This was because the index 'i' had incremented before printing the
> > current handle value.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > ---
> >  drivers/cxl/core/mbox.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 9adda4795eb7..b810a6aa3010 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -915,7 +915,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >  
> >  		payload->handles[i++] = gen->hdr.handle;
> >  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> > -			le16_to_cpu(payload->handles[i]));
> > +			le16_to_cpu(payload->handles[i-1]));
> Trivial but needs spaces around the -. e.g.  [i - 1] 
> 
> Maybe Dan can fix up whilst applying.
> 
> Otherwise
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I have enlisted Dave to start wrangling CXL kernel patches upstream, and
I will fall back to just reviewing.

Dave, you can add my:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

..with the same caveat as above.

