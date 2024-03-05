Return-Path: <linux-kernel+bounces-91698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32E871559
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07999B21A19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BEA5A4C4;
	Tue,  5 Mar 2024 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnBmNiUk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748F4C637
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617488; cv=fail; b=kHswyuXouoIDnFmXAeUndK1C1apE0ks9bLCNOJsRaHQDEuVTWNbAMtFOhXTBeiatFP77JvyOyrJyb1t1QSZE1+gBhzfyhd3XqBfQAXnd8Xl5qhRnK5/QYL6ZANGYUML7uPz0gTS6mUtNW4yH3nF21ugP5MWaTSx5mlNxINfhd9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617488; c=relaxed/simple;
	bh=Fhori9c1qz5xjDIk2EWpFNMq3Q9tW+zJt0kSAmHmtW0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XmdvI8DD9mmtiEs5nh4a3mq1HFgTYPuEx1hSTtwEKyXfbgjA1+OaRVUl4JUWq6YsVJl+9Sb52vih1Rht2/+yNQ+fNXUnFwv+OCmvKhL6+Jj2J5sF0IuDk95lK3dacjMD6sw0D2xvVb2rGeUQVSAqeFy9BVxwrbUma/Qn0DN44cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnBmNiUk; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709617486; x=1741153486;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fhori9c1qz5xjDIk2EWpFNMq3Q9tW+zJt0kSAmHmtW0=;
  b=HnBmNiUkU+gY5sjaBGFTsAsNlVt2cnF06S4pgR3gZVh+EmjMLlO3lZy/
   LVm0OHMjPvhLAUExtHREIWTDr3UhK6KCS12ODZF41B0o4gQnzL5KE2AId
   uY3jrYn0ybbfJTKvX9yvPeW7UeX6eEbjcYuSmPjCaw0vDUJAWjX4DugF4
   rm2ZFm+OO2EF005aufM/yYHUm0q7yefbideaACXLKbs1qa3IpIYEcoEpB
   qEk8B9IqjSca7haZvvJiy+sI58GqgwNqww80fVeNGs7WUH6QGTViSSmtW
   LDaPASxA9MRYnnbir9eowur3/SDR74CJriJRiip40fUbMKo/R0SO3pXX5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4009991"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4009991"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:44:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9671582"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 21:44:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 21:44:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 21:44:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 21:44:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 21:44:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFPAWfxzpm6CLYyeDB0N1hieTjDacbQQqDTTu8ipaosXqM4OVtAwa+U9zL3MhMrb5NePeqhQXC5xn818rkrlF/52mDfR0+hXeAP2a7SViLCj41Y2xAPsRcXE+0la19u2IZGj/o49EZLgbaIBW+8iOKbOCUWllN+ZUY8/0413soMHic44oZez/dc22KIp9eTnX6gOIRsfwCNAj2LO5Qpskr137XIuNxo6t87oRmkzgRXREs+VecRs0JWnZ10Bs8cxCNyJ17dyqwJVmsj9wbz0aOBRZY2g7Xzx9MP8nR+PwD6Inav11nZ5EFzv6oL9kerz2U2P/2MNW8nrwBiIxYhVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGxVAKhOD5Yzrwu87WbWxwEYZEe3MFkhhk/8h2UhTws=;
 b=TEvisRNqq5JWqH2SKBqem5snV/KZh4YZlcSvwYcPAaboRM5Zl/YSLiTQAJJqdXakfGbbly3wNuFzOuGqAq8E49iXJXpLnvd7T3I+IeWToJAzWi71w6zS6xmNBcYkGwpG3S3hxhyyEaY9kefd0yg5x3ZdNsD/0Wnq8HyUzDfn/Sd2itpP0jj8hf9dlvIIpkYvxqDS3zOUVK9+ldHaRehK7/srmjmKcjKt+wVj7SJjm+4/41Tbw9FGOtkfeZpqfvqvsyBL+gdwPCv0T8mR2uOFeDirknlmDfJ64XisTwi4SlPaXHnghVZE6y+QT/YUofMBzd/PyCs8zuh2eA8tSdxWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 05:44:41 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 05:44:41 +0000
Date: Tue, 5 Mar 2024 13:37:52 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: lkp <lkp@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may
 be truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <ZeavsDQNBA/txKyb@yujie-X299>
References: <202402141313.81ltVF5g-lkp@intel.com>
 <20240214055836.c5i3zmkhdllldwon@vireshk-i7>
 <b41c6cdb78c96d5f4a909fc13c253ef0d8576c86.camel@intel.com>
 <20240304065411.w34vbaeg2rlq6z5k@vireshk-i7>
 <ZeWGpyXXZBeYjnGW@yujie-X299>
 <20240304112102.wih3u5ny3iero47n@vireshk-i7>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240304112102.wih3u5ny3iero47n@vireshk-i7>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: c3cbc420-ac40-4acd-d08a-08dc3cd75a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nL6TMMd2oh2ycErBNC80efUb30OBM9vn+4NGkf5Mx0Xm4BEQ5Nxn6nj01MI1MJ24QvsDFz1oBjzxC8UH/11ORX0cKU/iN1ARCKzlEGzTiGlMG6Y+Lvu62A1UZYSPRk82P9TMECmSaKdE3OdaE4Cv8lEis/1lNxM1z8Bx4ACjRKB7RR1qf6QvPFWm24Zdj5an/eI6ZXFq9nyBHFBWs1RC/ThUxZ2udSLyPkx2SMbSvJ9hosfTma2+EGuBJ8BwFjvvMCu8m07F0fYe0iVgqZy3c6civT/13exDU77LZ+1DPM4OAhnsqvavxpKfGxyPhiG09BPzaCwfBPN2SHln1vqo5alreTwd1LtL03Wh/7mJ8m650nMFlRFc9wQlXJDRNH7bOHF/zapGWgMrViBldotDSyU6xlrK3TMl5Rn35PQlkvX8vBFv2c8FdxQzOiJK2ywYavcbc+E3AW+lxb9twk3BvCid5TDH45OjA+QdCN+5XLEfrK7gjYNaE9hpqXFiEWW1GaO6nhlfUINRup5F/YFI6fiJGtZ6I0TcZ7Jp2aZu0s/HD21YZ8MrSuRj+/IonzucSljxV/DFfHrz3tl6LuRHFCqEyhpQnRwaKjq7hpznZwAvV9rGnIFDde6HfoiwvugsHrePBlOOmzxX4j8zDExiPvKCDaMcthNH76P/yNZ72b4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z40cLrDMdLfvGYuYzt0WnkDrZbC91PfQ2W7ZSgxVAUnSkdCdwU0rhjng8e18?=
 =?us-ascii?Q?ey+Z9wALH85/pBrNoeyt8XUAPETXLM61qMUftLdlJ4PshWfJw5GdWjHsXvnJ?=
 =?us-ascii?Q?1zRqMYYY4/5n5bnyuIfpAbb742MkvK8gny8ITrMBkSQHNKyVsRoDovkCWQwH?=
 =?us-ascii?Q?YFWFwI1a0gBs+alpq/R2+UQhlzylid2l+qrNFloq7xQaoOC7eeQbkH9JKr13?=
 =?us-ascii?Q?xrOuA71Hybc6X9fFbKHx0Wy+c4Vx07rFFzFMaiiZVtDQ/fl6azZG+XVoht9O?=
 =?us-ascii?Q?6yh5XmlySBJyQ6lDLLa8QBD5pxiKXMv/V8+acRJ0thLCd3sojG84KR5ir1vc?=
 =?us-ascii?Q?5jKeHpa2rC0Kk7HomVgFlPnY0k3XeUS447vlmtcRAG0cRJsrt02k0uAsmI9v?=
 =?us-ascii?Q?hXp4OVC+akdt0chFP+ULYnZ/2oEX4a5bknNureqr7Mx6nxsWUzSASWAGLpeN?=
 =?us-ascii?Q?bnGSmft51IwtlQzEOjluV9ra5KEyYlQrlg4OFnjMGJ9BBdGGaGE3+YQIGPqF?=
 =?us-ascii?Q?T1KprAppqp/SH+FWfpRGqF9pTtPqxMAj3hl2p2ESCeVq1+SrhV5zJb6JO7YB?=
 =?us-ascii?Q?3B/QqUityrvlG5BDRpr0yQc4y6uvb2XmIddFSmT9kO7zVxYKM4rPa6jMC3KI?=
 =?us-ascii?Q?oiMMT7xLfu/9xZOb8a4vbKfdryjus669KAc7xWrYQpwf5E1mPRS456FY6yKk?=
 =?us-ascii?Q?PX491ZET30M0yWq6u9xBNhi1X2rYrWfYHeJMWUOptgjoA+0Foc48Eiqd5T9E?=
 =?us-ascii?Q?yR+t7GJsPSh7Uyr/FaERKhog6pHugi0nMtPs+qAEt4ZeSA3uQ2YZbF4pEzgC?=
 =?us-ascii?Q?qf31WdaoAGokqGOkqNxOFWuq5dAn3EtDCpzGs2R93O44N0tzgVbFcp6DciK3?=
 =?us-ascii?Q?q0fgg/g84N9LdTgF3shsSm9AY5EI34t+M+EoPnxQbW6v6t1AQy0R54mo0IKi?=
 =?us-ascii?Q?0VRkMIQcKPIhRzQLPiNRba6+sZe7PHv6aXkXcxjkB2T+hESqADTqlcEa9W0b?=
 =?us-ascii?Q?zRwA+Z3qE8XI5b7ZO+0QYSjryj0Mb/2QtUKZCbQadN8c3rQvb0tFvznTyPzO?=
 =?us-ascii?Q?8YCnnZW9mwQfNwPFFB6cN8w2kEbYsA/k9c5d2uP+alrEA5D4tX4cUF57mmxW?=
 =?us-ascii?Q?ccSldeUXrvi58B9ORnWCcNJiqhk6mJu3QI5pniku8qZk32bwXaz2PJWuncnb?=
 =?us-ascii?Q?qRifOklvbaEZmPa9TXAwexfVfqNk3O1Am2Dv37folusLa0QdS0wz8RWxXW/C?=
 =?us-ascii?Q?na3MUsqEFrpwZu7PkN2IoKEdZCnmjX6lbMA7R+XO282U0hFaL+cCYIHkfUXF?=
 =?us-ascii?Q?B7WvIYuaLnfe7rSZbAzBS2+R5rax3Aof8LwEWzakCzqLCVzIQqUtxIWJ2XYC?=
 =?us-ascii?Q?F1+Uk0KHbuXOwijBDIoQxcpuBx3WXUCK9g1xfw86/p+BkO2/ItYAaHKZkprD?=
 =?us-ascii?Q?qzKV8yUO9v1aY6NmWIujfkYAxLqAEDp9kX6s/8IKsNIlN3PmGO40I0UZ05Km?=
 =?us-ascii?Q?TP/Q+VvYQQswSqRAAhN08FAB9wvODA+zUn/M3lyCy3lMgtNdzsUx5Hcxtotf?=
 =?us-ascii?Q?//hEP4Ge8GCJ+FALhB/I4+Tu+fTOwvIfOzQIgxP6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cbc420-ac40-4acd-d08a-08dc3cd75a78
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 05:44:41.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpQQSKiMogXBBx3Y8+mQCOqOjK0eXTQIhTRoB40hAHWrbi7BEfUMjvXgdIC33LmMBLlIMdvwIfUn0L+40UOJOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com

On Mon, Mar 04, 2024 at 04:51:02PM +0530, Viresh Kumar wrote:
> On 04-03-24, 16:30, Yujie Liu wrote:
> > This fixes the warning for "supply-%d". Seems there are other remaining
> > warnings as shown below. Would you like to take a look as well?
> 
> How about this instead to fix all warnings (drop the earlier change
> please) ?

We see the following errors after applying the new diff:

  CC      drivers/opp/debugfs.o
drivers/opp/debugfs.c: In function 'opp_debug_create_one':
drivers/opp/debugfs.c:92:57: error: 'snprintf' output may be truncated before the last format character [-Werror=format-truncation=]
   92 |                 snprintf(name, sizeof(name), "rate_hz_%d", i);
      |                                                         ^
In function 'opp_debug_create_clks',
    inlined from 'opp_debug_create_one' at drivers/opp/debugfs.c:164:2:
drivers/opp/debugfs.c:92:17: note: 'snprintf' output between 10 and 20 bytes into a destination of size 19
   92 |                 snprintf(name, sizeof(name), "rate_hz_%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/opp/debugfs.c: In function 'opp_debug_create_one':
drivers/opp/debugfs.c:107:56: error: 'snprintf' output may be truncated before the last format character [-Werror=format-truncation=]
  107 |                 snprintf(name, sizeof(name), "supply-%d", i);
      |                                                        ^
In function 'opp_debug_create_supplies',
    inlined from 'opp_debug_create_one' at drivers/opp/debugfs.c:165:2:
drivers/opp/debugfs.c:107:17: note: 'snprintf' output between 9 and 19 bytes into a destination of size 18
  107 |                 snprintf(name, sizeof(name), "supply-%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


An integer has positive and negative limits, and the range is from
-2147483648 to 2147483647 in decimal, so it seems that an integer can
have 11 digits at most.

> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index ec030b19164a..a9ebfdf0b6a1 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -37,10 +37,12 @@ static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
>                             size_t count, loff_t *ppos)
>  {
>         struct icc_path *path = fp->private_data;
> +       const char *name = icc_get_name(path);
>         char buf[64];
> -       int i;
> +       int i = 0;
> 
> -       i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
> +       if (name)
> +               i = scnprintf(buf, sizeof(buf), "%.62s\n", name);
> 
>         return simple_read_from_buffer(userbuf, count, ppos, buf, i);
>  }
> @@ -56,11 +58,11 @@ static void opp_debug_create_bw(struct dev_pm_opp *opp,
>                                 struct dentry *pdentry)
>  {
>         struct dentry *d;
> -       char name[20];
> +       char name[] = "icc-path-XXXXXXXXXX"; /* Integers can take 10 chars max */
>         int i;
> 
>         for (i = 0; i < opp_table->path_count; i++) {
> -               snprintf(name, sizeof(name), "icc-path-%.1d", i);
> +               snprintf(name, sizeof(name), "icc-path-%d", i);
> 
>                 /* Create per-path directory */
>                 d = debugfs_create_dir(name, pdentry);
> @@ -78,7 +80,7 @@ static void opp_debug_create_clks(struct dev_pm_opp *opp,
>                                   struct opp_table *opp_table,
>                                   struct dentry *pdentry)
>  {
> -       char name[12];
> +       char name[] = "rate_hz_XXXXXXXXXX"; /* Integers can take 10 chars max */
>         int i;
> 
>         if (opp_table->clk_count == 1) {
> @@ -100,7 +102,7 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
>         int i;
> 
>         for (i = 0; i < opp_table->regulator_count; i++) {
> -               char name[15];
> +               char name[] = "supply-XXXXXXXXXX"; /* Integers can take 10 chars max */
> 
>                 snprintf(name, sizeof(name), "supply-%d", i);
> 
> -- 
> viresh

