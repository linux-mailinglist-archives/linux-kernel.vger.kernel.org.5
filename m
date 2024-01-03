Return-Path: <linux-kernel+bounces-15987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3C82369B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0255C1F2481B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7FD1D54C;
	Wed,  3 Jan 2024 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOMAPm6p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78551D522;
	Wed,  3 Jan 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704313939; x=1735849939;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aJ6yuVTh3H3by5p/p+sDcofL+Q+0ZobIhIaT2afdsbw=;
  b=DOMAPm6pSoOw55NfhUPNVmI9Al3kkPjmvfmOO3h2MhfTss39P40nNjOE
   fgbB71P6jAgXnt1pt3086gWDjI7q+fxXaSIbkTGRxGBYh6AztRUnRuyO3
   gr8rIW3c2GxFMvzsaERUkg8xMH+ydelQo49HFVXtl57NFagEXXKy6FBAo
   N+lU0Aq/r5cFTmIVKBd5e7hqjhcv4jT0OSBMfAdM0C9CFgtfQVZz6x052
   H5AyM1byaXBVVsHw+D8R2XkLQ1/ZrZjO9U5WphU0xClyOV2/ZjXaEuZp1
   4OXNjGsd7CEhbN557xmto5vylyug4hfM+8P6E+ooYFknQpYvV1g9lk8qT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="483241767"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="483241767"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 12:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="14600044"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 12:32:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:32:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:32:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 12:32:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 12:32:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inwY0i67aMsJaIvfGNnjK79Qi67fEi+88n9FKewpn3ZVk31GWinbsH+P62uS0qjEVt3sayJ6Q55BNCoxEWaImBUt/L0zv1YV7wnQD6ru8UR371rtMe4pH8Wfs7YyDp6oPDS8wcHA5N4a9EMBPZsYTGV0KLmeobOnPzVcThZeF9QlBeYm7r6cuS+WM+irPZhfAv1y5mD3WrNIHGAkgKDFyic6QHvdQw2+h0njSuOGkmDUsTBJ7glzuy17LgT5mFlzM8l7ReRlqQB9MSebTBRlPj3PB8W5JYY1Fj+wmSDFq/Q8hn6pulxHNO4vyKVUeyWbArBk0SjYDG+hrASXWPeoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkpmrUy6ojMI2vN7RphmLrlPjyLALiug3l00Z+bY4j4=;
 b=jJVmPhkFcJtP1kc2Qp43fI31Lvzl6Lf3H90baGgLYby2r24ivv4KuuS5FirLRQlU9FiYe6WOcJjquQM0qX3r8oPBGetnUDONG4atil9VIgouzid34D+6fvEFsBvIkSI5sPo2lLr1WDwTxemYUBpqQtt0iP54V0HSRvobfnu/h854V6SmWqe2+HwAaCUHcA/QVzAy810KYZCLuGVvIm3UrdtUpoKR3GwX0XS4FVtxFwwLJlot2GWm7R4AOoFksiL6D/3XPXx01MLQZcWKx23lZKyG1XOQu1X1gQYUynukN4i08lQpvzAuYZpG+PELfuWeMh4/HolJrLTDPUhVBSAxfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 20:32:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 20:32:15 +0000
Date: Wed, 3 Jan 2024 12:32:12 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Stephen Rothwell
	<sfr@canb.auug.org.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>, <ira.weiny@intel.com>
Subject: RE: linux-next: duplicate patch in the nvdimm tree
Message-ID: <6595c44c75d7e_230829493@iweiny-mobl.notmuch>
References: <20240103152345.116ce8c7@canb.auug.org.au>
 <6595b5dca6bfc_8dc68294c7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6595b5dca6bfc_8dc68294c7@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e619dee-d9de-4d1d-0db4-08dc0c9b12b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xer0PwGeXsDT/pAD+PKWHyAMKB6lT7QkHX6sToNps47Q/vXALIGUvNuDoxeu3dOMR5S8xO/Ay37TDpteGkbBhX/2tv0oDEGwDIS3NK2oLZn9d6ClJwFtz4IPvRfC7C16OBP1WhZBpuwlaZmHmdLCHUOgcCnpNctemzR3qs9xxvsdtGHeD5XD4CPczO9VsXse65oGaUbzHT1LcrOinRADvyIgW18TBya4ah2NASnqeYy3HmcJctSkrY30UamJWjpiwfuGDwIpBWjP5LEWQ+qekpGAD2jxQoCFq8Av36SvQytCB/Te+oFCWnJR9gFwYmS6QZIKoIcTNlo/GQUi46AwBARhWsV5b0jNJsYHCasZIFWeTjG4uTvW4+aEbVfGLVF1+x0hq8Df4dOQAOaFqDQU1qHSqPliVI/gCA5RgEnTbbkI025LZ/vBWccBegmgqXdtnFabW3QJSOk4DVLt3IUzONBEOHM3gEF0egbx/sf0joT3CGV/TlSr4pLxnVkNW/BJC4HduMpYJAEJinHRlyZhteKdg2jkt7Ysk9lOcRaYy/rJ/8nvvvE0cHZXHSUFU2ND
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(54906003)(66946007)(66556008)(26005)(66476007)(8676002)(8936002)(107886003)(110136005)(316002)(478600001)(4744005)(5660300002)(86362001)(41300700001)(82960400001)(2906002)(44832011)(6666004)(6486002)(38100700002)(4326008)(9686003)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Od8WDLjYR3Qup84NsvgGJHxGskVtk+FaHDKjB7T/+gSA8Zz7yI8fWvla68fI?=
 =?us-ascii?Q?W5vIZQ/lMVve6qRKPxDLUa/Gbwtf6qiJJAeAuldOeSemLJ6jZtl11ZmY9mu8?=
 =?us-ascii?Q?RhqHiXUXuyu/UPuPUu9qhH3XX6OXVZVaE+tGymAbl9icds7YjuKQSBl3bpTJ?=
 =?us-ascii?Q?lMnJtK9r2C1NSEaFQn08qB947e61vLvSNMVuIUX1Sko+Gjcz7I6Lv3xpnFjF?=
 =?us-ascii?Q?anByEBfjZ+mVCntEeGhv7ew+j0fopVOyhoBLojYRNp7OoKQp9uL0jtIxQFXl?=
 =?us-ascii?Q?wiZm7YCfNGtW77eEjN3HXyAU+a/593q+PqoQhEpL9WhINhj6oxv3mIfNNxNw?=
 =?us-ascii?Q?25undyYHoPbBLkBGj0WvEUalOX+DmXYZVkk26vQhGLm1TKIlZCo0V9ZlfAiy?=
 =?us-ascii?Q?Z96UaGxEEfTpkFglzwRIcGRF//ZjX3Kjbb2U5sbQ/9+5S689onyP8DAMcU81?=
 =?us-ascii?Q?mVW7YPuQog9JxsNXa4IkVM3B0liL517dNY0CAJEWajF5zKEcuX5D6WAij8w/?=
 =?us-ascii?Q?9kuTO2oc3nqkGihZSsx10LaN/pxl3P06zvnI63mNtIsWAk4xY1nVX5bB37Kc?=
 =?us-ascii?Q?BmrbhscLEairw6s/JmbmgL3pKnTRhvbp+vz6kJOT9zfe9Fs250pHVSR9+uRc?=
 =?us-ascii?Q?zPOuj8MkIRmJ8tMPkLSk1XRaMHDAhJulhjvK/kISn4+4JZwwt6tB5L8FmVfi?=
 =?us-ascii?Q?GZe2LV26jphb1numaXo40ASgDvj82FkboCua5BhPA5gUS3cwZYnV/Exq9L6i?=
 =?us-ascii?Q?Jbkn2re2x/iccJJaVfJpy1s7gERFYgYJqtwB8UljjLMlWKWiqqPPswTQdwFm?=
 =?us-ascii?Q?+1AUJpULTzk0xcuxFGA2IWnXgEser2hAclgdutxqODFExd6x4qrN/x3oLkk0?=
 =?us-ascii?Q?SS+1uivUX1D4EDW+Mj5+uGuLJPfzHYSS/IUoBsOJQ+xDTeMPdTOS0mhp+Tgu?=
 =?us-ascii?Q?+EJg0X9TfSOhab1PjtHGFvJnQtwlTqPgVZTTt9rBsQozK5oUlvXJMlv2FnGn?=
 =?us-ascii?Q?rIcu2oxSM4E6UIDgO3IAnRTMPLXwqabqUBZMBcuWCYNYGsqxJ8MXsBba6Da8?=
 =?us-ascii?Q?1g28ntYs/H39QV/DQRR1lPocueawXvBVTGvSLpm+GMFwg9TZk1WwlVZVjO1n?=
 =?us-ascii?Q?JHAcB11sjP10hMV660JSDrSxtDptNd4hGljt0Zeo0kdaGwIdMdC12ZpRUxJn?=
 =?us-ascii?Q?7z8trOibkATWX5KEIMZtMJrC+cTmAhnft/rSu1aN2LJ/VfGITdZeheICvuVf?=
 =?us-ascii?Q?nnTx+SVo0uAbQaJfiFA2dok4KQUAjB7b1AFaVKtcSBTeLvYJYdvzJHWjGi/Z?=
 =?us-ascii?Q?FBGSjKyfK625/yWMGHwq0xsZE0frCTFCJUSQx4/0ElZbkAW3aYqoLuKKS8Wa?=
 =?us-ascii?Q?zQtyLmoLY5j5qnSp1xBNp43uO0VtmKobSKK/pinOctxcAm5mjDUmoByYFYI3?=
 =?us-ascii?Q?bcwDGI/yNOIzUObbRkYOmK+9lePmPD5HeS9QJVZwZ0rlABsTB9nwLvrw+3X5?=
 =?us-ascii?Q?FCNv9eKBvjNDxX94jOZWv2NFDsIZuoHGjVAq6H4YUO+pl3MShceKMhxD5QNY?=
 =?us-ascii?Q?S3SB2jSI2VkSuupQDoyVMepEoQRhpO0YpkIZnTIS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e619dee-d9de-4d1d-0db4-08dc0c9b12b6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 20:32:15.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5EDdZ7QDNG7zEwKd7djOugvNcvWKSpF2f3rcpMA5VIwm5iD2I8bzl2c+sgT8SFomJ5LXL82ORtikpCR46VbdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8013
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commit is also in the char-misc tree as a different commit
> > (but the same patch):
> > 
> >   ce2fa3e597dd ("tools/testing/nvdimm: Add compile-test coverage for ndtest")
> > 
> > This is commit
> > 
> >   fddd9e3e4e71 ("tools/testing/nvdimm: Add compile-test coverage for ndtest")
> > 
> > in the char-misc tree.
> 
> Thanks for the heads up, Ira can you drop ce2fa3e597dd since Greg took it already?

Done.  Apologies for that.

Ira

