Return-Path: <linux-kernel+bounces-103987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032A87C778
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FC11F2176E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7908801;
	Fri, 15 Mar 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXeW48ST"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9E4691;
	Fri, 15 Mar 2024 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469822; cv=fail; b=OzJ+J/01P/enXqLfxMatevkVOGuGiLYt8LrPtv0XH139x2FxYwpjQ+RgNZtLjAeOW6AdiqnpGjgNRW1Y0WJEVLwTUWN1/QUevoNvRHM5IeJ0aBNWiVfWw8VTiGZ9Al5WwY6rTSaWa0oavLsoXQIBX7atXqXdQt0n+GSCjkaBO5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469822; c=relaxed/simple;
	bh=Sz6gkhInDecHD9Gx28asKJ7ktMw4KXuKWU2bnR101rY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BxCdWdW4aQ17d+Ww/G5anGCIiJrEP/0MN/Fi18Q16ngSA50i9RGKSlGH7TN+3FxAC0BgBsZkBjRxNNNSHM2VNJ4A/QE0JuSSeVb97MmN1h7mgmUPGvA8fAW+WtnYV8jEx1QozVfUS0y+UjxbBtj7ttQR9dXxO07jtVcJUirKtOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXeW48ST; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710469817; x=1742005817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Sz6gkhInDecHD9Gx28asKJ7ktMw4KXuKWU2bnR101rY=;
  b=TXeW48STMPtyJ6vSWTDlaNKQGaaxuQHrUEAcQRLodec+GFcNgUA4Pkuk
   5H2s+yu/pwGdvGOzrC735AHBQUxDA7oO1MwlkwINOeWMzXwCkMtV0XDVb
   hmydpqaILpj0DiXkgN3R80xYpJJeC5JX52YPVbv5I/WmdbZThsJ6rHOA3
   0nDkGKma/t18WpqByF7ZRPuvtH4iTxZKOkuGrTp+O0cvzpDIcUJ3k9vrQ
   Ic7XC2wZcm4oPG7pJNlS3r3bz3RL4ogDeTs5VSPG4TBlBhoIIiXlD767E
   6msfFWeONMnhxyeEAZPqfZfqkoLw2YKkpp1z2fXRgCUbBpFblCRUInyU7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5924422"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5924422"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 19:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12548702"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 19:30:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 19:30:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 19:30:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 19:30:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 19:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLQ9DvYrPuU4jLLPFMZtoxkiOZcAA45RDN/9prnlYLOFfNahrtji3Zbl4Lc0KOi0r4Arb7wJLQOVFAO5fWXWl7a9kYFj8r59DWPFfFkzc+cySAWecbHrNmdjhg9suUC2uOO87HbUyNsKarqP2fKq4dt4U5WtAMvfZiMbEdXd/SSoajFF79dbzS/5I7wbVy/HWST8YguHfc39QcE3ouF6Nuo5iCTkepAPHyAfr6ChLrCfUn9vv3bDxXLtiRi/rwR1OW87M9dlHnyRDFekuLziPPKoLGU39Qpq1OjrSPUng9tne/43Mp79qb+JKqmqw5xe1MHaP/+Ztw5xMnpNZhMN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1MOD2kzMTEy1aYRvr9rQ3k5ECr8Mc/k/JuK1ZYtGuk=;
 b=daMeBNFitcA3QCY0d44cJurbcAnHLGFY4nzg5Vow6HUoN4/y8LEa1MCaJL6kxW7bH2bALepXm3E8MmlZBRVhQzkwATZMUIa0tvsSWiR9R50zFnNH78dNPyskfCexjidSEY3/039Yqs5h8eABAxadHwdAKm7YO6gZDiQ7YxL2GZtdg9aGF/TuNp4tmDr5Stxm6K7VAJ9RXI0Ako5Qcrh89mrZ0tVO32j58xbDYtVpU6qk9DwfCSJNbEW/cWtWHspeIJTMfZtfSviVMqA1wXKjzztlqNW6QwA+eTTyqMzl/u7c/QOmduG4Wlst8fylmwG820Y1T76fObWRXZUgNsBe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Fri, 15 Mar
 2024 02:30:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 02:30:13 +0000
Date: Thu, 14 Mar 2024 19:30:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming4.li@intel.com>, <dan.j.williams@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming4.li@intel.com>
Subject: Re: [RFC PATCH 4/6] PCI/AER: Extend RCH RAS error handling to
 support VH topology case
Message-ID: <65f3b2b29cfe9_aa22294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-5-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313083602.239201-5-ming4.li@intel.com>
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c12a8d-33c8-4413-8274-08dc4497d78b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JoCjkkdEOvb4KYT2XSlHVJG1NSSUQM8GRb0REcQ+xashlZ3FrR7XLR666Wk86nwh4USo64xKTS74nGyDQ/dJJX38zHB9BkuXiP+Sd0GGXWyvWEBEOOo85M6fczOCLwidBIGpaeExnRhSxbFYAjGgHzkGX6chPxulUF1t9BJzwtFR9QEm0P4Xe2FTWdlUUIgvWIB1zJsVl/mvwH6l5DR2/5oL2KCcJDHcvfyVfQzCm/lGwN+9wkELB9UcxiB9qTT+Cs4y50Mf0g5mhGHDpOXNQCOISztKR2Z74v7ChyVzq1RVKSocFFdIgjKk382WRSYcvvJwRzgH+UqiBIft4sEuftlfqJQYevYK1dJFkY5SCxhN1qZ1jKWRdpPTXw1DZkeqMQBR8RMX/9DKhzbwU7XYDGTKJ9kwrOiKJPtR03z7Qo0GJktkoAA6ahzzzBAO3jlgZyK7tg+FIs+ubZc6PyMBhax3cYz/oZVSrkgkzNogB8y32OndYkjp9XBwFt94lcPbN0TguZa+MVjX8UkUFyhqAlqO03EaTZY36LocYLMAOUoDySoj4BuVnFEZmUOsoA13GThaBdSnetdRPwI2aySGlzLm1n90QWutPLIkM6PeT5HsH3r/txmjUwo/eAGbkC4YxIQxWpgmQbRTESPyIagEt0ykjn+6ZgPgfSL/2bNwd5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UsLuV9EGH+2xSaEVuryimpa1Avgl5h976Q71+VVVEWMKS58HfQL1pBdHtuXv?=
 =?us-ascii?Q?iyRxyUKqqJ+irxDcs5AyJyrdSMdNl31Q7i8ueyLCnvKANiEiUbL3DnPr8Tww?=
 =?us-ascii?Q?cVa+okR6j4OY7sbVy1H3I8ycYYc9lrSByCjHEHvwk/vCm0IfYi1IoMNPlnjv?=
 =?us-ascii?Q?12Tf6dOX8HNAeZtPyTB20M3W96/esncERWmjUhJR7S7RNoD7k59i4b5PTq8E?=
 =?us-ascii?Q?/U38t2BadB/c3rbH1K/fArdRpl0AgwPQoNTR2SKmEbhXjyRMWsvB0Cr8tb/N?=
 =?us-ascii?Q?DoJbneoQBztDbPLS/T90Bc+PdYx+yQfi6j0eaGDDY+uTy1JuzIffqONQKWUT?=
 =?us-ascii?Q?lSa0619KKwoXZzfQFit8Mdp3fD6/BzE9WtHxED9emOM8EOlfeD7YCAz0JvS5?=
 =?us-ascii?Q?KmxGjPZr+1ilZLLCzu/DN2Fif96PG+Iyw9D7DXisu8d+IpQkzM0VvEdcRg24?=
 =?us-ascii?Q?ruk4BA0WINIW2kpmuQizbR2oSnCAPI0+GX0CDxCX6xQoBs56YpHK9pgPovkF?=
 =?us-ascii?Q?NEli5600FIa7Tt8hE68ZSzU32QSyWENtMRL045OC1Xs1gaYO8VwsiXqoEo7T?=
 =?us-ascii?Q?WASrNv5t9VTdfFYh8rlKqHljyyVD6YqELvVwRCrzwczbGv0upgopZcsyHDnu?=
 =?us-ascii?Q?weEATGYceiyGOaUxNE1qPV1GEtrSbwohkDivGmOSmHwhqdubi3o4ZDNpuGfq?=
 =?us-ascii?Q?LfD2vrKn6M9Av7fs1a/64Ebj0gdqaN3X6PvsiF6+TNbYY6E/nLwtLNUNEkby?=
 =?us-ascii?Q?JhEszOI251ioUFRZWbkySbv71q9GVbZsjUoiwIwDTzQlrBq0Z5GkeduEn9rU?=
 =?us-ascii?Q?y7Tn9wJdxq/nmMr5Fg0gyrKFlN+Wrk3moDwXzUvTNnfuanmrFUqBNUGNj1Fv?=
 =?us-ascii?Q?xIK4eDP3TdeNUMCmAF5siuSKZIiiZs6mQyEurFZdVNzpaVDXdwIoTTK5qr2r?=
 =?us-ascii?Q?CGBRIdPTetq52633kR5gEbOS8orF9IUZiqeUEhhXmk0CJHktLs1vOQPnAgfs?=
 =?us-ascii?Q?UmgG2SD0Fh1XLRY9Uu/axMlAtKHKbr0LT3PFaqcQ+TanHbZCvjUkj1dl2jn6?=
 =?us-ascii?Q?v9XVjMQeu+0UU/5erjT9ABujm6xmpfM/NEzYPRzUI9MT1AZFH6sY6SoLUUEa?=
 =?us-ascii?Q?roLNIQVsWE2Cx6lV1+mkuIxbMmFurRmQiypdokqPbcNBXHasPlQXic7Be7Un?=
 =?us-ascii?Q?ZmDQ74CfIEMPchehckzhMgQ/ROhvUZYzhcoB5uFhyJqcN4rgcHlYPLctgN2u?=
 =?us-ascii?Q?ZLDkyvAoi2XxowQfb1rRViruSV7U1rM8E9N8IeISMlg8tzAETltpgaL2PqIx?=
 =?us-ascii?Q?MVR5bq2QKuv0HIku3Qd3WChd4NeRBh9pEq6liVsRukjv0SXQexpVu18sE+24?=
 =?us-ascii?Q?AS6+cWXiDM3FMWz+Dhk9SjgET8VinhBCkiPgXpIVRycWfzMnHepzwGG4Icjd?=
 =?us-ascii?Q?PFBxv3UJVAupBqWqVsV3fg4Jwhte/plHGJpGoSWz7otLjuoVBh8nxmNcPlnV?=
 =?us-ascii?Q?AChZCva7B9Xa9TOFM9uIdTdsq+eDWpEqsfWhzSjQtQqweJbVOYz9nMQcC7fs?=
 =?us-ascii?Q?0Dg5D+EYaKr6mRTXZeDtAY4zY/BgZZ1FmXygLZEMk4cyMWf3zF03MTYEve2D?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c12a8d-33c8-4413-8274-08dc4497d78b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 02:30:12.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y46U/CR+BKAqu4LowOXnr0SOeM/TalKbRaTfsT8y20y0gDa9VDL7K8ewNo4CdL7m6RIPtLakgBbyBTzkcLfVZ6ubRSAuqjeRM3ktdMjepW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com

Li Ming wrote:
> When RCEC captures CXL.cachemem protocol errors detected by CXL root
> port, the recommendation from CXL r3.1 9.18.1.5 is :
> 
> 	"Probe all CXL Downstream Ports and determine whether they have logged an
> 	error in the CXL.io or CXL.cachemem status registers."
> 
> The flow is similar with RCH RAS error handling, so reuse it to support
> above case.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 364c74e47273..79bfa5fb78f4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -996,11 +996,15 @@ static bool is_internal_error(struct aer_err_info *info)
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
>  
> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +static int cxl_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;
>  	const struct pci_error_handlers *err_handler;
>  
> +	/* Skip the RCiEP devices not associating with RCEC */
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
> +	    !dev->rcec)
> +		return 0;
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;

is_cxl_mem_dev(dev) will always be false in the VH case, so how does
this change help the VH case?

