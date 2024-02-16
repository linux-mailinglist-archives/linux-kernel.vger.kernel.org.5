Return-Path: <linux-kernel+bounces-69065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC4858406
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141A21F29EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA4131E43;
	Fri, 16 Feb 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nj9WE4MF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF612FB31;
	Fri, 16 Feb 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104187; cv=fail; b=HaUk5BmLKrtldC78NO8tYodWJqnL6iNSQhgmPwb2f7VCYYPh2ouxyEMhoo8auyUM/tzvV0IyunQDN8yksVscGuJkK/663rNuUPDrKQtwpqGM+sAQ4bbIthRxjYC4lBb5QqgCl6jOJoZR5msrkA6XglRRQNypHFCXrXqJu25LxMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104187; c=relaxed/simple;
	bh=D886W6IdA5kJg0cNC1rEpaEF+4TbjIqC/htEfeJrk+E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NGooSxu905sxyIjQQdGE481iZ8Ul/ci50Sn/GiIvBqJt3ouWAJvkUmz78wJyIdYRO/npVyJGH5dw41/APL15akLVQik6EhmQLAcq0S9dLNZD8SFMiHDyNCiGQRY7+rZvPZJpRKYiD5g6JtHPC/y2TDSe1XO87l9Jx5S4Hmzn+RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nj9WE4MF; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708104186; x=1739640186;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D886W6IdA5kJg0cNC1rEpaEF+4TbjIqC/htEfeJrk+E=;
  b=Nj9WE4MFqu/GYTMPgidR36T9goHze2E/sA2FOSuj/SQjqv/cz5yXuWpn
   uXNhrBYrFAG8gJW0vx/JXffOmDFzB5bv+j6NJ9Rifud6PVkTLtdLt0Saj
   biJU3EcBbv0oIylU2S7fipJtBuA0VFApXjOyYTIyj53x+8TwzSCU1XFew
   FEm9HGfSN31BwddiwlP845VFnUaRG97hPWtAjCijtPea3Ykw1GhD/pf8f
   G93C8bcd1sqFIJsgWJMLTAs5aQnE5jsbmbpnDsAOHTUfYoeJNnl7otK5K
   kdGTSf2mkiUZwRJupjBZwX0+gu2qLdCHhNZyUw2sgaF0yWjyqlf3FUBax
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6067101"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6067101"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:23:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8501557"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 09:23:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:23:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 09:23:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 09:23:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKaoM1T65vJimnFoOkioMYuVmKjxxrEL7v/5h9NUJAW9a/gPpX6bVyQSHNS0qoj0ccPYGDFNJky8+Ml3b3yxsSK8cD+edF/9RlfMinBae0zZqFSK4rGcWbY5EagkTJFxJp9PHCB0p/bC0CbcJEfstwfaHamO3Om5RKJZMTdg7Hob49x7UBO9oHukXP5B/XXpisMAjytc4yPyuWtm0dLwFfAYEcxHCNBc2MeGw979g+twN64H625CYgffizsg1otGwHi2OXsLPXqST8TnxAqig77iHmstgl2Q0yz89lyPgGEnx9zPpT8zTC7JcwQ2CxOZFyRTnmSynd73yWZ5moC1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkrbreXnBkOU2EOotjsmWLSkA951YTawa9xW8kKzTDY=;
 b=XQHMvWQags1HYSWhed0jba6pmrVuYLV2QIx/Cv8RhaR4UvdyTRX4HSuGtY5Q4BJ5YbgIFtjPPdhVdr6QbsLKarkE7rFKW1o75b8FBiAFoH12XbUIa+53f2YgqETBCzLC1w5mY9u16nvnZV1TWeHTZcOAkRpE2oD/Ru4RqVgKMoQRidlwbInULv3lfa/hFnnPl8UvOPit9OuStZuPXwMtq3rO2PwyRpKPWvz9/OpLB+l/cVC6hdfKh/fEoZgpsN7ecLUUca75YtKwBeuxNK7mm7kHWLx8qkZ1x8q1SVw4k1fx427GlY4V3RTaGyBHMCDaODqHBuuLoyYt/b0rOkg+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 17:23:02 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1819:577e:aefc:d65d]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1819:577e:aefc:d65d%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 17:23:02 +0000
Date: Fri, 16 Feb 2024 17:22:53 +0000
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Damian Muszynski <damian.muszynski@intel.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	"Lucas Segarra Fernandez" <lucas.segarra.fernandez@intel.com>, Tero Kristo
	<tero.kristo@linux.intel.com>, Markas Rapoportas
	<markas.rapoportas@intel.com>, <qat-linux@intel.com>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] crypto: qat - uninitialized variable in
 adf_hb_error_inject_write()
Message-ID: <Zc+Z7RBFNLcnzNOL@gcabiddu-mobl.ger.corp.intel.com>
References: <193d36b0-961a-4b66-b945-37988f157ebe@moroto.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <193d36b0-961a-4b66-b945-37988f157ebe@moroto.mountain>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU2PR04CA0184.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::9) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SA2PR11MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fdf1b0-52c5-463f-d7ea-08dc2f13edde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UrxjAynqZPhZja7As2bCZRUz/ClfR+ApoXxAvX3Os1sxLIS/Vo1CdIAcceMteuE8rHd02b9A038iLI/FSi1PYLxGS3/+gSU9/xXED5rne+kcy5h4fhZUtU7/8gzyenHgHRZrNDjbu9VKp5XpzLj7+2aMT+98GPd5GVV4MSysQefbkcm7mEbmgyQOtoPUqyweMjqZDAJKGXv8cN4+LBfRqxlyvu0ebDDnzWKeQ4Eplcxo1ozTrt7YyQ7jK9vdUV2OLDNK6pgdcTkSY3bniWEbX6UBB6wqIKuP3QcMrAbY7xC7g2ddr1uG/KixYzYI87vLNFJoPC5WwaNJmXlw0wpOdSitiw2b0uIbJymk0OoZ99LcEW5lHriNDLkw35UHI8YXB1Lm6rhoLATxZ1PgXs7crntoOOM5+RoePpDHZ7LAsmMgAerKR52iDCdmGy6XwkTUvXaNj95GjtG1uA1aza+tMGQ21LV2b6QhD0h6H9Y2Msd9fn1mN/ncN0iKfwBwRTNoobA5sthgR7QFlqvOqpvkEhXqfg2zg63UtJJzyZ0+SzNUcq/cr9z9ISC/rXzylUT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(316002)(54906003)(6666004)(6916009)(2906002)(5660300002)(8676002)(4326008)(86362001)(8936002)(6506007)(66946007)(6512007)(36916002)(6486002)(66556008)(66476007)(478600001)(41300700001)(26005)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9gTWU24g7MmRP8ItqMWA4eKk1tbhxlKUNV+X/tuvLBNkQg/sUM6LA7C6vUam?=
 =?us-ascii?Q?H6h89qgeToOtNtzpKuntyJBscQJCjItzwiq4ie44f74jp0wl17EvA6gqTdPP?=
 =?us-ascii?Q?c/w8ClQprghSW86jgxm07WEcwpiAUcm+RcGWMt/hKGhHQJwHVqE/ofNeKhGt?=
 =?us-ascii?Q?1EtGnYPv/JuBB4jya3oyvzd4Ok0LAQP0rEoVz71+6tOZrM3tmcxtZCCbIF3m?=
 =?us-ascii?Q?kU/FcGPvLSZmpxaDF3wRJ7Pa/Ulb37mLlpb4zEGLmqMGxWzr0w9PXJ+J+KSl?=
 =?us-ascii?Q?uUfr3p4SYOx96KBhWxdDksEbJ+FeulZAIwV41Gm9ALNCtws5uVNiIuxNo+aQ?=
 =?us-ascii?Q?2oYaKI4T+lEZ5tlsapbKYnIjrirr1pSbAX6OgfVD5L4b8GCCqm8h5HJ3erN9?=
 =?us-ascii?Q?cl7cSXsH86y1e+603lNw2cYqDdrsb0qweoquLE/8FzshO6geSjdixkVADpl+?=
 =?us-ascii?Q?vrRZ2jO/c55SV4JBRQFkM+cjCD9USKu6/57zbKWvhtaeQNr9KvPf38chJWse?=
 =?us-ascii?Q?jNK8P1QzRPJ7gle3Idx1UoCEdf2uWXU/iRfwvxBeVc4620JBiBfbz4ukkXFv?=
 =?us-ascii?Q?zotnYJSpIgKIZGfC5rz2ji/PAf8qs+WUAmhJHVBpz/3JRF3RBssjjr9g0Bsh?=
 =?us-ascii?Q?caiwaMQ1Em1HZgO6iZE6PvgTlyABsZMVQnOrqyWEiahreT7mFRpnyUKeFYK2?=
 =?us-ascii?Q?Iu4LpcT59T83uJ5mtUYsPVzkPZLikTAaw1Leip9DNOrVfGm2T4u+emi1eAPc?=
 =?us-ascii?Q?Gh6BderZ5LTHMzcx5MFY8yq76HhlEntKwSRv4TZ08wKunGFmGM2bmTOXbsy+?=
 =?us-ascii?Q?+oFmJDjdOqnqf0rcXpLj0KkhwXt3Tcbwc3HXu/EJjxKI65qkq386/bsnQh2V?=
 =?us-ascii?Q?P7xSiPgdq8jUkrdcIqQ3nWrDR/J1OUkTQLI7kscu7LjGOe5Xkjsn+Q9myEQI?=
 =?us-ascii?Q?t2NUUqDnIpUF7D7FN2JniDjBD5QTi6usNIfxW+RoxnNHhiLBSXsuwLbttI7Z?=
 =?us-ascii?Q?zMbSZx/kqVaCA/hDcY4S3EepE3AscfowE2urHzgvMstOZcmtOlyXTpaB437h?=
 =?us-ascii?Q?4eWIq4ZPFsPHQNxyVORxrx74L0XJsmHmdLTps0hLTuHtlpXwLhkyoXPzsDob?=
 =?us-ascii?Q?TB1Fivjkvle+DohAmBT9fC9FtbWzS1E5LBX9KVTdXDdCK4MCVpXhnI+ysBlj?=
 =?us-ascii?Q?7U2kY04CfV2uGf663MFTSHQPnvXXZiMnRYggauuT8pWau/yihFlLYxz+TSqi?=
 =?us-ascii?Q?lFwjUs/c2Q7mZ0roZ/0jP6x3vsFZqsxCjKa70C/3uSq2gwEUxaOhz1OwPt0b?=
 =?us-ascii?Q?dUWjwIhNY9DaeqOIsgqTCQFEfc8Co2pxcUDAp0A9IX0iFZo8apouJsiVe8Gb?=
 =?us-ascii?Q?xnxvHoQu1lm4+8nKLNXhPmch3LknPLMPW16aKWzg1nI3n7lGS+Ez0Q2NwJZD?=
 =?us-ascii?Q?eEIN6PM7hKZbrbUgrm3VZloc/DUTiIFu3EFcXOEJPVjbB36lRkGaXX8/aeop?=
 =?us-ascii?Q?lQ9rpFbLPE78S7UmUlf7AE6iHF97g1a3gUIQRG+KPoIkdpt45ydz4eP6L5Rk?=
 =?us-ascii?Q?ODZnRV/Kre6Dugz3ibnZEu2GTvpOYfzVocWk+zkrKl+xjSmA39jDn5Yj9Hju?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fdf1b0-52c5-463f-d7ea-08dc2f13edde
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 17:23:02.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr4A4PUSJwvI7jwstVXBR4BhpZIGppqp9weXFZjYAQ6EMTDUWdlJFhceAKcCfit7DBxuSdAU9idRG2IBv9Wy7BPFFjmYc1m1hBxLxYp5PKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
X-OriginatorOrg: intel.com

On Tue, Feb 13, 2024 at 09:09:41PM +0300, Dan Carpenter wrote:
> There are a few issues in this code.  If *ppos is non-zero then the
> first part of the buffer is not initialized.  We never initialize the
> last character of the buffer.  The return is not checked so it's
> possible that none of the buffer is initialized.
Thanks Dan.
> 
> This is debugfs code which is root only and the impact of these bugs is
> very small.  However, it's still worth fixing.  To fix this:
> 1) Check that *ppos is zero.
> 2) Use copy_from_user() instead of simple_write_to_buffer().
> 3) Explicitly add a NUL terminator.
> 
> Fixes: e2b67859ab6e ("crypto: qat - add heartbeat error simulator")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  .../crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
> index 5cd6c2d6f90a..cccdff24b48d 100644
> --- a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
> +++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
> @@ -160,16 +160,17 @@ static ssize_t adf_hb_error_inject_write(struct file *file,
>  					 size_t count, loff_t *ppos)
>  {
>  	struct adf_accel_dev *accel_dev = file->private_data;
> -	size_t written_chars;
>  	char buf[3];
>  	int ret;
>  
>  	/* last byte left as string termination */
> -	if (count != 2)
> +	if (*ppos != 0 || count != 2)
Is this alone not sufficient to fix the problem? Probably I'm missing
something.
The function just checks the first character in buf.

Anyway, looks correct to me.
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Regards,

-- 
Giovanni

