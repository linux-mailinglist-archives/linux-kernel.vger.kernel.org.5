Return-Path: <linux-kernel+bounces-64088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8A853A08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB0B1C2524F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930410A19;
	Tue, 13 Feb 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDzoV/i/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242610A3D;
	Tue, 13 Feb 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849615; cv=fail; b=U8U8djmL0biKgPFY60Y6+4RIAjMNheIWBQJDd9hT5G+6TQ69F7ASTROSTHtnsrG93Wad0I1Yhf/wqr4eVr0Z7vGZcGdbWdc7lgdMBcSXKadFiV093y3VgTYSYXkIz2nLo1w50d+4cuxS0aJHkE5WLdPtNXEkD6ne4PMk7l7RKYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849615; c=relaxed/simple;
	bh=71HeGVCFTzxc1epbyiJp+ohp4YasHwHHL4FnW1mohbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i55Uz6sZxuS6pXavBBwDWmGRbM1HswrMvL2/4q2cFpeg7k4BojsLETvFr4Jaubo/Y/lmEXzaWr+fA72FDYAfSBIcWP38RVJPUMTDnmoDLpYZ+WfVKIIQN4e2/YnGXWACt0o5w4oQYDUPKrEmxO3NrBCwavRtJwQULBSECf9eMao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDzoV/i/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707849613; x=1739385613;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=71HeGVCFTzxc1epbyiJp+ohp4YasHwHHL4FnW1mohbM=;
  b=jDzoV/i/5ikIF/WknQjhmwsDtvEIjC0iPaJAuTouJ4tp8C9pU+Jhbza4
   ppIHmcKvwlcAQyehHF3brp+yYenJ978hIofrXHIQPL3D2KV4CBs9qmJ7V
   LhPiU5k48ErVykTQU7qYBWLftYuXISA3UrHmQxMG60fvSXSf2bHYyw1nS
   t9+N/XOccu8odu1/82LrZwvMvkkQXalJ2romEezjpUaE3rWySWUhOfP7a
   aE4t1oBlL/DARK6KxwD9iv/0ej5zxVcCgXYTXVtiVhsabXu4rZveWkr6R
   G0mdev5mXCaVnB0o7VAxi6OED9RFPirB1mHuvTf+18BYLXytgRaCp2HLp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1725556"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1725556"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="7606827"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 10:40:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 10:40:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 10:40:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 10:40:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzijWMTtngH6r/7pPlCywvkdF1ImgsxgWBZj5I87WnsCS+YBWxVgCpNr8Z8fZX6vjrldmwkBIhG9d/OLaIdL/ps0fYshxAd9ZJdRsRBE8qdJr2qSVf4sP/PeaYWG60G5gJzakZr2qhr+Bbs9S6esxtyxn7Lr9d47kTWr+cn27iI/uioj5CijgWulw7D5JcehFFc9MkvviDnelxta8M2ZlI4KmfFQHELAqECraAspRFKFgx6Kq/Qh0UMAZWT2/3/fIZLQrJ3grTcDvDjro4DbZZQltPFSObQtZshuUPPfBTTKIbR4uMx5i74tMGnqhiVDp9mq/88HxD9ozOqBM3iR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKTZT79HlLdiU7hCmk7lelgh2UpyLpBULUx+5j6IoC0=;
 b=O5icoTHpmncQqkuFig6Ag1Y3B8tH0X55W6577Bxel3e2JBmM1Y+h20H0WfAn2E+QCxv6XunXaSCVrU6wyG9cugGnp/MhxYAUDVAoZa3lyz0LKE9C+0KJJrox2uoqjEDhXWhTlWAkKTA6QVRsxz3g0U8sD766LAy23rqgPeYgLkyY7LE6HZyV45Js0pXcCu7X8StAHShSvCi5N0P74KnBbgLK6gbcAWXdtkr05E2n/igpBadK2/y+mGT4xiCP7rRFhB0Onfig10yRCblTVzNRUSoEiDR7sQKPCc9DllxxThCoQW/Yornc5zYa1MUBMv87W/dMs2xBcojaBLVAolmkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8588.namprd11.prod.outlook.com (2603:10b6:a03:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 18:40:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 18:40:09 +0000
Date: Tue, 13 Feb 2024 10:40:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/pci: Fix disabling CXL memory for zero-based
 addressing
Message-ID: <65cbb787e73c_29b129432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240209193451.163564-1-rrichter@amd.com>
 <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
 <Zctg4Lx_y_hbChUW@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zctg4Lx_y_hbChUW@rric.localdomain>
X-ClientProxiedBy: MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: a7875f43-e77b-4ec3-a32f-08dc2cc3349e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+169xOJj9ngsi/ob+3dVzL09U1OuiJ/iOnlK+hE/obytHqSa7Gzbgu/dbbaFlNZfquhtLv2EFHDolCIx2XTxGTH1u9mqZZfLAZcoW4U9oWJojEoYEWvoF1bFEH66tDDNY2II8OEsO+dwA9zXoUhp+jtw+RN1E6852jp9HlfHCAsz4UegXxLMPmMSqc42a4mK/bmSk+6j5V2b8iIGgl54Z13Oi+qsIsZHnh35UflgGZO6p20It+hjtil5YtzkgQ2O8I0eenf3KocD9mmyZFmqOgpeF4RnZOFxoDczjRseJGTUv7CmcdAWvvs9PgyDwdMs0JhU+e/5GeWzwD81YCDZnmdI2YV5HP4vrZsZMUzlT0+hcYs6BUnb//3ukmoc6NaNZq+Sxpl412N4F+iAA9Uowlza15CQt/dqvPdAPlIkMZ0aH/Bu0o6RbTDwUYzWJeG9iSDRImzmk+cUqnnJUP5GXrg1WsnJBWuKLA7kNYj6AWY5puJ5vzzGeX19DTsRXfyzQCgN/JLIx9z7jLvjEWZeyFq2t3NVhTezksj8OjMNJaA4ZYGfK4hrX4ClKlLScq/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(41300700001)(6486002)(83380400001)(8676002)(8936002)(66946007)(66476007)(4326008)(6506007)(6512007)(478600001)(53546011)(110136005)(316002)(54906003)(9686003)(66556008)(86362001)(38100700002)(82960400001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/RXA7vIpKVKaJlHsLcKMQnwYlRf+v9UxAjoq7c5JHKgyi/oHmNtlDxnmtQNo?=
 =?us-ascii?Q?kYK8XXzJFPrsQEztDKu/HAPDrZJIGOox8utRj9AW9EdT5WfiiOzRiciPU441?=
 =?us-ascii?Q?C7u/pHFxLjFu0M41Suk2i9h+mBC1bBixHImp05aj9AtQXhuDmssfUQ/6dZ3/?=
 =?us-ascii?Q?qPF3KTLuwv1WMdaxZCVIzzZ1rpm8RmbRw/xVM1folbh4eKzVXLQSfxFiZpAi?=
 =?us-ascii?Q?+BuJTwZ/I9aRZSDFkwZZVrT92Feu5rG9hR2xz7sRUkfLWih004wdSQtpJ/Hi?=
 =?us-ascii?Q?Sq7JesSxl1KvfB2sGkaLSOIKU+CnCNZ7VA5sJLVVu1yXmLy/W00nJyjvqWQe?=
 =?us-ascii?Q?XBx5kxdh6WUVdUMNeCzFqKQvnOlGiGxg2o76/7Y+RVrZ0FAhZDrnMhFyC+xp?=
 =?us-ascii?Q?BICYTxRTae0659z3/6mZ7+UrbvZgqORwrySujMLuajKqLmfKVuaRcZmFdiOZ?=
 =?us-ascii?Q?2koDd2oJ/wy62lpE6N9guEerEvX6mhIKeN38vyNoOZzH9OxX+5R4xUZXOuhH?=
 =?us-ascii?Q?ViFBAG8EzpqZkBUf4vJgpZ3cRWKsTNFy6MZfD8BatHDrqOp2OjYVNO7rkpMB?=
 =?us-ascii?Q?0BHKq/Appdh2efRGtnxkwUMMBkzE8xIP+ICuqzMHdDu0dWhRQc6OpPkkjGXD?=
 =?us-ascii?Q?/5gGQ9xohf2DXaOAO2y4UG9VwJpaMQ5RBI738g+2CaDe/91hcxniCllOAju+?=
 =?us-ascii?Q?3LHQUvOILStLvVttKInPbfjqu6QjMwbpE/tbH2bpyvePhfLtqRJ3XgqbsALn?=
 =?us-ascii?Q?K3JIyPpym806e9560W2C7NXSuzirF3t3zdAKPlyk/xxdtoI5ITQXCunhQAnz?=
 =?us-ascii?Q?FVhV0kz7SGgnX/41MjHmQQ9KBDbPnAatA9gHw3KptLv21qg2dzvR9n9GWyQ3?=
 =?us-ascii?Q?Dct/NVo+dSUmgOZWnkm+COt5C6m+bsq3IQJAWKP+5iEVS3kJM5liZXzP8x0l?=
 =?us-ascii?Q?KDY97ANh9pt0AUYeE5HCvne9+HiUF4k1X/eT/m5SCfCAMR+KnT8ESLLvGw+F?=
 =?us-ascii?Q?EuZx6WJ/RR0KxHMS9ANbM5qRViS4qyAIrqosLG1DJng2Sj1IIY9a1jqAVUkk?=
 =?us-ascii?Q?lMoaLp6zvVhMITBXkNYh2cpZ291CxkBzael0kd0Suv/Qro91Utq/hh1d0f/Z?=
 =?us-ascii?Q?l1MOoHwTfE9LYdtOGxYr2m1t04r801+NNmxndg99J6/hhehyHdeEXn9hV2cw?=
 =?us-ascii?Q?UDlDTwHSYD5yUSbWws4dwwdzXXjdyPrZx3MWCyn41PH4qdKmwCNzS073tnnl?=
 =?us-ascii?Q?SNVWL6Xl6SfMwln2OTXo2SJvmQl6HEj3NSezgvTAMq0d7xiEznbTWsPcSGfK?=
 =?us-ascii?Q?oITfYY5RoVse19Szy5yoJS52kUs0hvVLi29hXdT/ywNfTaHRyWEYP0c/zfeK?=
 =?us-ascii?Q?jnp0Aksp0FK0TJlEXv852RATlItULlWbz9WRrHDmRIIlmCgb3EsAfw/VGwVY?=
 =?us-ascii?Q?HOc8O2703LNPxembTQNCslrRJEyVkz/9Wr8t6pX97zAPO2BDmiFJYUHUKmWP?=
 =?us-ascii?Q?5QNR77vOISoFg8pkfKRzIwVn/xEcVe4Kf/q33jDsDKEBrHAsRtIr1AeBWbqa?=
 =?us-ascii?Q?tUXA2EA36VCsY1T9oAmBomHRehafNdxuwTWeAKECQ2TbLG9TtUUZG7tBA/hB?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7875f43-e77b-4ec3-a32f-08dc2cc3349e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 18:40:09.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBA52wf0hB5Djpch9Ms5MlPkNITPDA2NEwmcIRbJMkfyWhJq1vVRrvnZTTJoRTQbuYa4WW4C8CEHA8VVpeNRxWwa/w447u/B3azsJ14Bqlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Dan,
> 
> On 09.02.24 12:22:01, Dan Williams wrote:
> > Robert Richter wrote:
> 
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index 569354a5536f..3a36a2f0c94f 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -466,6 +466,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> > >  	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> > >  		struct device *cxld_dev;
> > >  
> > > +		/*
> > > +		 * Handle zero-based hardware addresses
> > > +		 */
> > > +		if (!info->dvsec_range[i].start &&
> > > +		    info->dvsec_range[i].end != CXL_RESOURCE_NONE &&
> > > +		    info->dvsec_range[i].end) {
> > > +			dev_dbg(dev, "Zero-based hardware range found [%#llx - %#llx]\n",
> > > +				info->dvsec_range[i].start, info->dvsec_range[i].end);
> > > +			allowed++;
> > > +			continue;
> > > +		}
> > > +
> > 
> > I am not comfortable with this. It should be checking a platform
> > specific quirk, or similar for the possibility of HPA != SPA. The
> > entirety of the Linux CXL subsystem is built on the assumption that HPA
> > == SPA, and if a platform wants to inject an offset between those Linux
> > needs some way to enumerate that it is running in that new world. Yes,
> > nothing in the CXL specification precludes HPA != SPA, but Linux has
> > long since shipped the opposite assumption.
> 
> this check prevents the memory from disabling an enabled decoder. So it
> just keeps everything as it comes out of firmware.
> 
> Can you explain the motivation why active memory is disabled?

It is a sanity check that Linux is operating in a CXL world that it
understands. The fundamental assumption is that the CFMWS correctly
conveys the CXL space, and that the HW decoder resources match platform
expectations match Linux resource management.

> This may take system memory offline and could lead to a kernel hang.

Yes, that is not an unreasonable result when Linux fundamental
assumptions are violated.

> The same could happen if the CEDT is broken or just missing (it is not
> mandatory for 1.1). Such systems just die when booting. So the check
> to take memory offline should be changed in a way that it will be safe
> to disable it.
> 
> A platform check would fix that only for certain systems.

I am not worried about platforms that accidentally break the CEDT, those
mistakes are typically caught pre-production. Otherwise, if the platform
is designed to break assumptions then Linux needs explicit enabling for
the address translation sitting between the endpoint and the platform
address map.

