Return-Path: <linux-kernel+bounces-64188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E94853B72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD6F1C232F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32060893;
	Tue, 13 Feb 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGRECO0j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC021119A;
	Tue, 13 Feb 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853555; cv=fail; b=J9w5KBtil+G+MfhRG6rC8qFu51/0U3sOIREtDNHEmEJv3Z8h56ckrAUtgaebV35qORK1Dxx88B4R2HnvTEpSNYwucbpozT8oSeNEsYEwoDNgNXuqZJkU2Qb4sbPQb5JieXMZDw+72wEtJzaKX4jQUtheUaqbgxNnBtkUZyHhtvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853555; c=relaxed/simple;
	bh=Zhci8RsMB/zdyQkFFd1JB1JpGQQ9mBnaYQ7DLLFEHtE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K5j987GtA+q5dQj8l3902qQHhd5Mc8OCGR8a2MnIjmtlH09BWdSCcYgjovISgXh/UbPdRwF1gs+ueR4+f9ErvAAzQ39sWCwBObTPrec2JAK/zwYmb1ouwjfXzP7mrR7roybGCjJwJTg3tQtUPq29n2HU5qPq9+BJG/+cA68WQ3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGRECO0j; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707853554; x=1739389554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zhci8RsMB/zdyQkFFd1JB1JpGQQ9mBnaYQ7DLLFEHtE=;
  b=FGRECO0jwyGHpi0xaOxRNhTRuPziLyYtlzyOrh+hA1hGOs5NNlhaMXqi
   y2SHpjOiN2PLDVsgzI8QBRAFyWgTLKWn6564Okoy+hIylmrRK36hC5EF+
   qjUGPOCTb+QK7AUvXumB2883jsiCVsHEJiTnlsb19WFI6IzpTZXrS4aKo
   PSd39dfFOb8MfEKjmfTMI0PnwCKVNtKdiGOpsD+gYJO03t2Z4ZOZv4/16
   e15LyzO7EwzmC4KCBxg+QYUrNbEROFOTW+O+d/IYlDRpJd0rOkoWH4XeT
   EtD2Otgns+N5dLMvAZom/msMkDliSYZ2ckQygqZdP7KIS9yGUGO3XL7cv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13275651"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="13275651"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 11:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="7626841"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 11:45:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 11:45:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 11:45:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 11:45:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 11:45:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoqbWQ4tjDpNZtoYEddFFBO7BuFfLBQuRrwtJCo0LX4AtmI4ufY5iml3WEbVrsvUIk9JmTCZr0QMmn0IQvbvrAy88O1Q9T5yanvcxrnXU0F9mVq2TV03MGT1oN3JXWGoeP7livJsgJZESyu+Qc4UyeHqeH6PZK37yfYwid3fobCzb0T0WmvRQ9nMGLoFp+nD+AGCYHKFCIE1Qbs/5D1VM8MgCzRHlNUPOcAWrbjthXdSSu01MbbqXOw49e4TFv4G0esiAvA0de31s7icx/SCEp+1B0W5LexjMMr5Ttg5o6Aui/+6Caz8wAWxPP0yaifhuIy6LeHkZ2vYsXEpc7Gmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOSvQ7ClJlzqB+jDDRYeEboqlnbPJAJpkVB4zi9xaug=;
 b=j6nsON0G3PTsL2KcgDLbVp2Q7+5ou9Ll3fSNItYt8dtEg9IcCuZP7IdgNQvlio4AVnyjKABlzfFNekciBBQbXYRKC6IHvafHJX/nK5GBXhToAdqObOwMQ15ISAPZjBtVuvab3+C0lGv+EXH9JoqvvxjB9Ut8DHN8jxtubsfsK5SkF9QeBx8UBURg419KgOF9PnDy+YpqXF+b2vOrx5reySJyHeZTjt3J/Ai7IrwZsJ2a0g5e2l8uxsi35dzLQhmZTmaSN5/MlvPao68o0TwIxCYKaSZ/rKK4c3XlSzWofbQ4/qoC7U3wfi/dBTnG9GiBNf8k9aMhGkaElHtatr+iDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Tue, 13 Feb
 2024 19:45:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 19:45:51 +0000
Date: Tue, 13 Feb 2024 11:45:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/pci: Fix disabling CXL memory for zero-based
 addressing
Message-ID: <65cbc6ec7a0f6_29b129456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240209193451.163564-1-rrichter@amd.com>
 <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
 <Zctg4Lx_y_hbChUW@rric.localdomain>
 <65cbb787e73c_29b129432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zcu-cVG9deqfwdiV@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zcu-cVG9deqfwdiV@rric.localdomain>
X-ClientProxiedBy: MW4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:303:16d::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: baaec6d5-3709-476a-c792-08dc2ccc61f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o52UM7Vsn0EM4+yfvzmSJkEruUhLWOPYkU0KtEuOiE627e7oLMKemw/ySvaROVaboyF2t4Kyy6r3JtQSxDE9AbIPhrlzUDbhROAyCcgCKk4eanzstVILl3ZrFeuZZSAjHIfAy5jont4sXuMEnZ6QuX8Il60kJFGDBt9GTlI4bKB61IcjEnFoSqeFhY8ykWX9Is1SA+0fH6uWHiUpslvoUBVIbFnZO3HtZFK6sy4mnH44gFjE2MSXdLg6eLZh3xSy1m+nP8o7iF7i0YJ4l9XhXNK4AcpphYSiwsf1Dmvkrk+0dI3ocTfeXCtRaHN2Cq1e/f+aU7OwXhFIYaGbdFNQ/lCLzD6KZAXUhup5lol4O5Nv7whaGsc7tvVK3XEd+MyNjmxBOD+xz2L9GF5p9q0G2RSKZ16bn/jJQfY5MIyZzVpbjC7s60Vt2cs0pLieisZ5G+ty3yPJ/H+ZhmaDmo+twpSVFX7x8/8DyxlyfzLedZRE1xoTkqDG3Yhpp1IqMqtO282QowlqDO/UgXNXpw5PtCksVX0PZdc1bXw9+zJhWTFyDTFMv9S80ih5xRk1WeQS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82960400001)(86362001)(6486002)(110136005)(66476007)(316002)(6666004)(66556008)(54906003)(6506007)(2906002)(478600001)(4326008)(8676002)(8936002)(5660300002)(26005)(38100700002)(83380400001)(53546011)(9686003)(6512007)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHAtliB6CX0188TJ6qaCy5HfdVl68i8sMv7DfPVNlu2ppX5Kvx29i4JoNmLe?=
 =?us-ascii?Q?m/ANiDWc3fWjGhIsTxl/kJQ5zoqdYGXEB82NtRHpyxWG2AgVJt3yCFBYZonU?=
 =?us-ascii?Q?zhfejerdNiUofIDdnEf3OdimcHlLzMjdkYkLUKJVamqbOc2g74SEpjuMbZ0b?=
 =?us-ascii?Q?V33qkzOLscnyFrZSZn3upPganeguiWPl4vVkW3ydZXmxgbs8Rkr8ZqxJq0xN?=
 =?us-ascii?Q?zZdcPiF3i19P5O4LvvTv5YUAfinHS3OAER4vYlGR3ZsKc9Xsh4EijK17+Tov?=
 =?us-ascii?Q?a7Mr9BY/c9Odyy5V5AJiDKcQ+XjLWyM33I+IuLfcKaFL89taxcGEO07Q8MGH?=
 =?us-ascii?Q?cSzyT3A54fEt5aLnREcdPndUqNLljqR9VFYYPJzL5Gq9soI8fmbMsARz/GEw?=
 =?us-ascii?Q?q90nBCDnqcGgLAMCp9SviVoJ4ga42HAwSnPKwW7+BjeRsW10d7NWXz1+e9yY?=
 =?us-ascii?Q?YB9FlODxnSRGyKj8ssyGdEtBmT/zjX1C9UHjZOWQKHiFGRrIJVi2AB/MpZCl?=
 =?us-ascii?Q?722943O9CyzMdTgBCHhiYOKQ1za06q3S9soIWjqz2suz3XKpy/G48XLd5W+y?=
 =?us-ascii?Q?lQDjIqzE79F+Y94NHyQQfKS4L7pfiC4KgpCrOYgCHa8CewuXSWS6PNw+Hwq9?=
 =?us-ascii?Q?O4D2Z20BXalSBWkk7x1L0DXMEEd6BDawyPqCFiIspgAFhuca0tJUcTjJ1j59?=
 =?us-ascii?Q?hGBC9wD+MyqlyLeJEM9x9g6gQsvKOn1vIGQjtSDtFHVeif5AYfDwqGon+uIw?=
 =?us-ascii?Q?MN/5H94qMydO5o+D2EfhMoZj12e8BpLmmuvmm4bACD7KQp1LuIh5BfHUEAQd?=
 =?us-ascii?Q?0ymuoaOekgFrQzNUACeFJ8Dk9ExFD/vpeKDIiG4cuZnEIpJiNBPlaEcTi+h9?=
 =?us-ascii?Q?CAb486+v7SByisLv7QKDVQRVinih4mH8UBJiuQXb7iteHA+ezn9aGDOV2wUJ?=
 =?us-ascii?Q?nXrOVeX2E/2gxlJSjgUe+pt7O3dTRax14a4RtQ44fbMlHXXIPJ0BGMGv0Jx3?=
 =?us-ascii?Q?hlwAlxWwm+4GnzVS+/xgGuJVc1h8dbjfK8Mh9zB+ryvZK0YnBm1LYltZvEbT?=
 =?us-ascii?Q?doXwGhNWFZYvXPFY4BmIalT76VXMlbwO7YI1zCbtsKhZ5g9x93XHQUGpDJyh?=
 =?us-ascii?Q?H4Ml//RQuo2VkESZ1sEWbGUON36SKuTYCBrovYe3c8aha0MQyov8yZta7hw1?=
 =?us-ascii?Q?Ur3r9B3qyAJ0CqIXpqaDfIxR4QC4/wLMi/vVLfFALAJQQDqE+WbW0vdS6Sa4?=
 =?us-ascii?Q?6uRRg6QZMK/cuCXOHVXXGqYR1YBUtBbcEbfU6nmJcFzsRlbbYwwDeZwDPXbb?=
 =?us-ascii?Q?+fowcVs/xF+S+3CzpP8Yz4m8qxIhEV14ylNVv5lQVvkpoBQphN7HtRKsVFs0?=
 =?us-ascii?Q?yRZGRCmTpXfyaxMlr5YxoWdz2G3wXR2C14FXg95XmHuUCzGCrPmY9CR55qza?=
 =?us-ascii?Q?EWrhCQcVJNRcapioSLRs35ux6qReBGwHF2uQjahlkhqfEjVnQOXD3UszkfQ8?=
 =?us-ascii?Q?uL32etZq17zLHj3gMT7p9ukLcNgBCzJzoxbIamI/IA9plDkDJjVi6Z8tKEy9?=
 =?us-ascii?Q?BTrCm1pN4EZaH54nmMJR4MjuNeNwhTW774ffsPe5YMV1wMqUdpibpnyympRP?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baaec6d5-3709-476a-c792-08dc2ccc61f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 19:45:50.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukspEb/piYTF62dLCuw+dS47+U1Q46e8VS3QeoXwC9xk4lzSNNe1aXbtbougYpfY3uv0uqxLNQtbEmyPwNDJSewGKDTykjEfNXlKYYD+nYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-OriginatorOrg: intel.com

Robert Richter wrote:
> On 13.02.24 10:40:07, Dan Williams wrote:
> > Robert Richter wrote:
> > > Dan,
> > > 
> > > On 09.02.24 12:22:01, Dan Williams wrote:
> > > > Robert Richter wrote:
> > > 
> > > > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > > > index 569354a5536f..3a36a2f0c94f 100644
> > > > > --- a/drivers/cxl/core/pci.c
> > > > > +++ b/drivers/cxl/core/pci.c
> > > > > @@ -466,6 +466,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> > > > >  	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> > > > >  		struct device *cxld_dev;
> > > > >  
> > > > > +		/*
> > > > > +		 * Handle zero-based hardware addresses
> > > > > +		 */
> > > > > +		if (!info->dvsec_range[i].start &&
> > > > > +		    info->dvsec_range[i].end != CXL_RESOURCE_NONE &&
> > > > > +		    info->dvsec_range[i].end) {
> > > > > +			dev_dbg(dev, "Zero-based hardware range found [%#llx - %#llx]\n",
> > > > > +				info->dvsec_range[i].start, info->dvsec_range[i].end);
> > > > > +			allowed++;
> > > > > +			continue;
> > > > > +		}
> > > > > +
> > > > 
> > > > I am not comfortable with this. It should be checking a platform
> > > > specific quirk, or similar for the possibility of HPA != SPA. The
> > > > entirety of the Linux CXL subsystem is built on the assumption that HPA
> > > > == SPA, and if a platform wants to inject an offset between those Linux
> > > > needs some way to enumerate that it is running in that new world. Yes,
> > > > nothing in the CXL specification precludes HPA != SPA, but Linux has
> > > > long since shipped the opposite assumption.
> > > 
> > > this check prevents the memory from disabling an enabled decoder. So it
> > > just keeps everything as it comes out of firmware.
> > > 
> > > Can you explain the motivation why active memory is disabled?
> > 
> > It is a sanity check that Linux is operating in a CXL world that it
> > understands. The fundamental assumption is that the CFMWS correctly
> > conveys the CXL space, and that the HW decoder resources match platform
> > expectations match Linux resource management.
> 
> It would be sane to just not use CXL if assumptions on it are not
> valid and not to break system to boot.

I can get on board with that.

> 
> > 
> > > This may take system memory offline and could lead to a kernel hang.
> > 
> > Yes, that is not an unreasonable result when Linux fundamental
> > assumptions are violated.
> 
> BUG_ON(fw_table_broken)? If at all, it is not mandatory to have a
> CFMWS. Btw, the check is more strict and also checks memory
> attributes. It is very likely something can break.

Sure, I'll take a patch like this:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c9c8d92f8f7..e4e5a917f1f4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -477,10 +477,11 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
                allowed++;
        }
 
-       if (!allowed) {
-               cxl_set_mem_enable(cxlds, 0);
-               info->mem_enabled = 0;
-       }
+       WARN_TAINT(!allowed, TAINT_FIRMWARE_WORKAROUND,
+                  FW_BUG "%s: Range register decodes outside platform defined CXL ranges.",
+                  dev_name(dev));
+       if (!allowed)
+               return -ENXIO;
 
        /*
         * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base

