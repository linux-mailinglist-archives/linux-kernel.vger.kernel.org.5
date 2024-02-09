Return-Path: <linux-kernel+bounces-59930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941384FD7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BF71F21CB7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2E4126F3F;
	Fri,  9 Feb 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="my1J7/tX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321A54F86;
	Fri,  9 Feb 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510129; cv=fail; b=iyAV8hPEm5++ghR0KwnovHR81KX5xpHKIWG5/ojukuz6zRHRbmTScE5F3cqH12djFn1nF61EMOZ3K5IF5OSV1abyRbO2nsBL7nwFORWbwWPJmKgnwO8fm55Gb60r5oq1d3LiUcrtB1a4brXgzogK0uJrT3I03uuiBUmYh62yjGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510129; c=relaxed/simple;
	bh=+Ln4pguBBGinrzpyOepn/9lILY09k6IApdCMt1qRs84=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W2mS4FEs4zfJAyXT2WbDY22AORqKLdVAv/T1/ba/suJdCDPwDIdXkMwmXvpnzA3pfR0m+ILQ/i5FNLCtQ1LUBCc7eA4vsxp/+DihNGtEzV1VQ4j2FGpQaMExpQ+ZZLW8xw2F1qQZ8XhXnPYdoC7SdfmMmtU+CyfflC9Afj4IyTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=my1J7/tX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707510128; x=1739046128;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+Ln4pguBBGinrzpyOepn/9lILY09k6IApdCMt1qRs84=;
  b=my1J7/tXE7Y6JxV7hqoPhAAAgbl+/brVEUhTkpyHf3x9owktlf+mr8xX
   KA7R5K4rPqN9FO73W0kIWQiWomn5so79zno4MF0LI9i9+idME7t7sUdSw
   YsdoJZS7/FFbYJUWdIs0btlWdnT5iO+cCBEVhfrMimOF1e+TYmyBJFiwG
   +mIEb3aZdDCEinqZh0yP1zYvTGf+qOomhS4SWrcbL4FODI+Wy494abF1m
   1J8kTJrrm43agewI/8Bz5CKjhkxgnMvD78C60wnMgAwKgPVo/2MiWFCyQ
   qfdIzo39k9hSdLFgARvYotU0tA1Ez/BDgMSMCd9DzSmTgzHhh4DuISkU/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1811561"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1811561"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6678286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:22:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:22:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:22:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:22:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:22:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PynB453Gfybe2Fn3QoCH07Ky046iqYo8lH4cmavCOg0DMlDaZnahsypqx+ahWhoJX+aQDa0kDfyoxsl9osVqbzS7ezQjwfW+iXXhjaEVadphiDKisBNVIXfNSKl50BwoikemgWVIBfheM/lqQs6pyNmXESFHfPlBvAhiQ4ztq2GFuwHfqDm1WsdsHncwKachyXJQwG8prtUX/CTog//AnGHvNcYWkeh2SBYnmRaxxM2QYRbXAFB+t1Lpz9sT2PqI3HV1nkiFYCUjDMbaQ06C3KRpm97707L3X/oTz+AHu17Lka1Pi4lQj27YHEkRvbEfni8WZZS4sIGhNYNZNNR6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIfzzwWEQyQDUDjdoBDJY4zoiI7bGSuOV1eZ4zxJAzc=;
 b=JVwjryF8tANvSIqSJ9ecpnlmG79tHPrI48yecS9cG2BB+y3cQ6SKw0Ait9Cj+nwK4lHDv5T/Q14vF5gxxWLcqZnGERFy7WIbk9pjhxFE2jVwuPsAwamFPX9B3iDRc6PJeTflHExcST5089VP0XZrAJGsqyHQBhTU2xeojiUyX3g+pFZmbbndgYx7Y4bFCBkkGMTfQkRrS61b24DV0bwhQNyIBEGFwrxRT4oKrrPgvz80PQz08dJxvUf2fnRNLbX1YEU3Fly1Zi0L0dFpyTh947L28zLfydE3HXxJZt3cyvlDpCcvGVHn1nykh6loPRQzP9fKEfz6AkeU86PposjQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 20:22:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 20:22:04 +0000
Date: Fri, 9 Feb 2024 12:22:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/pci: Fix disabling CXL memory for zero-based
 addressing
Message-ID: <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209193451.163564-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240209193451.163564-1-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 06270a1e-3162-4c6f-916a-08dc29acc780
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+SBuSpRVNO2ywvzQWxjVWguLnxI2O1W4VY6fauvszsUamNpJLcDAAFg6j3LeMfAQx4PkZHX0qWTJQ8PSRbByTku6BwhE4EO2q1wnUSysym2G44hbyq5EeF6Q8I1u1FFTBDnFoTVdB8HWHpH/OgitAdpEnikrpZ1254SUH5M+OhiEDujXNDS5UCSn7TDGl7MDsjx8MvaNeVfAEAv8ZeewwC3t3m6IFfJnJOlr2xRNdGEQQwWebCpGOgDlj0qBlN6TqOVzYpVZK7B8+l9GUumqfgcEde6jwS1jj7laIiihIlbOQ36frgy+n0Kb3YzK8OvtWPiETYpXfLaHePFBMBmWHztn5GXlZB4UX8NRs78loKJmHMa3qyonNGg1KgCCmgIaDzLkL6ooRYDIJC2TEThkuRTXb9pVn/sy1OrmH1+kUiJTR/Epzct/oz3d9jHCSJhpZPaUy/UD7AQIOSw2kq/o2v3W/uJIq0obOQS6p2muOIf+SXRXRBxkxbxxVKwUZILbT2wLG/Rfd46iYWlT7lSUAskuuFAyj835M+ro0AsRUcwYwy5M8idLaJFsl3lRpIz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(82960400001)(86362001)(6486002)(316002)(110136005)(66476007)(66556008)(26005)(38100700002)(6506007)(54906003)(6666004)(478600001)(9686003)(66946007)(6512007)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCFNDGBnrL0rGHXmKnxzknwZJZB9MpME5Szst9x3ePNYlkyvyBXh66/h8xUn?=
 =?us-ascii?Q?CpPEmzB9qDraMFx5F5HzDcvnSjLm+havGRQ/eDQCfFEl+NtrN+8JYuErezg5?=
 =?us-ascii?Q?eASCSXPtY2NYsKznX1Aa3p6LS2eNWEoEm9Tx72JRQWWvUzM0OG+hnj1i6mj0?=
 =?us-ascii?Q?l9VbkMkmpQSCkXkm0yd3lc602ClW+OCBipdkyx+4/6o06NOUYowxwecayu9C?=
 =?us-ascii?Q?9dpImRpInYLa4GgEy40tTo7Dn5KQe5f9YOtD1I+Bj5iY7crolcvZYhIq+OFo?=
 =?us-ascii?Q?KVL93S9hiD1MPfiA7boIdAnwKfGlS8B1cLPBwF4FxGwS1J7rpHp/VvzRnUOA?=
 =?us-ascii?Q?yWPXewzfuskfs9cOPb4kzYCCFFgaGmld327NUWNqA5PQ+AwJuvHn+gLxRub5?=
 =?us-ascii?Q?Swj8OMBiKQT/UufgO7smzi4tc+UtaZ9gq0XvYcgfHCTrSWkqkH4yNx13FY2I?=
 =?us-ascii?Q?3o0F7WqZFIEd62OcU5nv+BnFqJ19wYmKjU5b23vEAqsSMb5GPn2/DnH9VZib?=
 =?us-ascii?Q?0fpYUEOU9/gNx/zvxYqFaBYr+2AVO252GNinXZkjwR2bamjVga3i1gvE0vkW?=
 =?us-ascii?Q?RUzp7ofZZzx0Z+jdHAs3q+wTRMwKDOm7FaTUhaCrfCxuY0ALbkhDUy+HSZYy?=
 =?us-ascii?Q?0a3a69BXF+n5BNJBqZIVzAuvw385vbMvF/AqI7uecawUn7wkWzfdun6y5kDy?=
 =?us-ascii?Q?hp2LtV/+KZaLIqOr4RZFVPs9fMMJLUUpnun81ApSTySCczPqbmND8hAzY+Ce?=
 =?us-ascii?Q?3/zRM/4epfp+MgTYkN7JNXDU3cTPW+tCUxwxq2/E9ySsgQVhIk0BsmG3q9yZ?=
 =?us-ascii?Q?ei6Hg9+S/4e0GU1M3hp9pN4o6rcYRAGNxG+WWiDEx+KNUCh0hFCODByr58z9?=
 =?us-ascii?Q?ng6Cs5KJh38jF37fMPOQ5zdcBzJqpxVQWDUneRVVa2X436x05EP1ZDXrIAbK?=
 =?us-ascii?Q?hXSEEHu8jt6mTEScZC5GeFTrfLUSNIeGCA2tRCuADZadGWOCx8v0a8yDutxH?=
 =?us-ascii?Q?3LFvP2C8wmNwZBxEotxhDp2HZhrKtmIHFwttmoPRaPwbKqYKeGQ1X6Xe7f3X?=
 =?us-ascii?Q?xuzQlzNK+CIUYXJijeQtmfm/Oc2FfCS6+Lkx/c+SKVbMdC9SO8MiwkT+PzY9?=
 =?us-ascii?Q?DtjGitQ17gTSj+NZef7OD8+D/yTk257gBL69WFpT9v2b7qaAVz/KobUdYpAt?=
 =?us-ascii?Q?mtopD+ca9wBpKwBrXfEdsePrmdsGea/HfMl3Mec9ls/uSjXFsrnIZpH0Ez4z?=
 =?us-ascii?Q?U0KT6RjVSde42bbmVT9DXx7mXyLih/JhhrJfXDrIy8dAs9AETroqVxGwSKa0?=
 =?us-ascii?Q?/T0cj7XnHm/JzaGYxzJE5XwTbzbC74To0o5POTffqree7/SILMtQ5izFEiMn?=
 =?us-ascii?Q?xRrmkG+ycEJURmN5kze3pbjFv9R8dOnGBv3TvoVWEZrJIvElHMOPoy/XZfta?=
 =?us-ascii?Q?ScL+Ef05paRrmorqa3eXiqs2AhzMV/OPIxYt6h5m3UiDNPcsIeE7MyvKraVi?=
 =?us-ascii?Q?uHRIQlTvJzeSd7kvtVt++S7ZqF+psnQQvxaezmKKFoJRgrcddOUJRvshgpRf?=
 =?us-ascii?Q?4ajInFSVLfMw1Ojfn3n4Isdz2CfOgW932uc58jZQGRWf3Ufta6VE6JH0iiD9?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06270a1e-3162-4c6f-916a-08dc29acc780
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 20:22:03.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+3f+7acq8hD/6pKE812SMu2v1ynxgZ1Px3iFNeo7ECeU23QQJBy8i/6DsFswmyWWKNCDQdS08mo3qVVr61+LPdclI85woyC1AwOIPYDE50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5600
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Based on CPU implementation and architecture, the CXL memory address
> decode per memory channel can be implemented as zero based address for
> addressing the CXL attached memory. In such case, the CXL host
> physical address may not match the system address. The CFMWS contains
> CXL ranges that are based on the system address range for the host
> physical address and may not match with the CXL decoders.
> 
> During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> an HPA window that is described in a CFMWS structure of the CXL host
> bridge (cxl-3.1, 9.18.1.3).
> 
> Now, if the range registers are programmed with zero-based addresses,
> the ranges do not match the CFMWS windows and the CXL memory range
> will be disabled. The HDM decoder stops working then which causes
> system memory being disabled and further a kernel hang during HDM
> decoder initialization, typically when a CXL enabled kernel boots.
> 
> If the decoder is programmed with a zero-based hardware address and
> the range is enabled, the CXL memory range is then in use by the
> system.
> 
> Fix a kernel hang due to disabling of CXL memory during HDM decoder
> initialization by adding a check for zero-based address ranges, mark
> such ranges as used which prevents the CXL memory from being disabled.
> 
> Note this patch only fixes HDM initialization for zero-based address
> ranges and a kernel hang this may cause. Decoder setup still does not
> enable the HPA ranges for zero-based address ranges, the HDM decoder
> cannot be added then and the kernel shows a message like the
> following:
> 
>  cxl decoder1.0: failed to add to region: 0x0-0x3ffffffff
> 
> However, support for this can be added in a later series.
> 
> Fix for stable, please add stable tag.
> 
> Fixes: 9de321e93c3b ("cxl/pci: Refactor cxl_hdm_decode_init()")
> Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 569354a5536f..3a36a2f0c94f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -466,6 +466,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
>  		struct device *cxld_dev;
>  
> +		/*
> +		 * Handle zero-based hardware addresses
> +		 */
> +		if (!info->dvsec_range[i].start &&
> +		    info->dvsec_range[i].end != CXL_RESOURCE_NONE &&
> +		    info->dvsec_range[i].end) {
> +			dev_dbg(dev, "Zero-based hardware range found [%#llx - %#llx]\n",
> +				info->dvsec_range[i].start, info->dvsec_range[i].end);
> +			allowed++;
> +			continue;
> +		}
> +

I am not comfortable with this. It should be checking a platform
specific quirk, or similar for the possibility of HPA != SPA. The
entirety of the Linux CXL subsystem is built on the assumption that HPA
== SPA, and if a platform wants to inject an offset between those Linux
needs some way to enumerate that it is running in that new world. Yes,
nothing in the CXL specification precludes HPA != SPA, but Linux has
long since shipped the opposite assumption.

