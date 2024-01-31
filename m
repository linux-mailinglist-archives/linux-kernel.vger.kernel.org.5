Return-Path: <linux-kernel+bounces-45779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96DE843628
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B22B1F27576
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8F43DB8B;
	Wed, 31 Jan 2024 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQvWHW5K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B33D995
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679765; cv=fail; b=cxQzeEWWZZGbVoQNThZQHN2UwSXEfuRvBs5WdGCjNGkvg/6B2k5V7oHQFefcUOp1n6ap8Ox/Hl7msnm6kj9GE8RgyXDZT4YWieKjvzOwRx/PcVEpSNzsVJedLOaBvVZMfz0RrUhvpRvX1oWWAgqzFToBebD8j1N4ugTYKt8vYuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679765; c=relaxed/simple;
	bh=GfpsAHLXXSCse8OmnmaGZITJUkqR3L++1lhaDztRzMo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nhlssLYbm0ICLKdhU4cMVP8jnkixdj+nMM0Y8bUkDuoW+QFY6n+NKuRvKbPoHSzE/GVuKRGYp219JEtLwtzo/ODmMzl8dZmG1b+sGYKlLWs6BJpJNd1IF1c2CEeXjn3HWXDmLkdDuk8qEGJ4YuH+krxDFXHds0EsTbhrmfPJUMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQvWHW5K; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706679764; x=1738215764;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GfpsAHLXXSCse8OmnmaGZITJUkqR3L++1lhaDztRzMo=;
  b=kQvWHW5KNKvbHZXbINndHXrxz3OdIMzCAFZqMUH54ISX9RQ6h5/qgvrD
   MeChC7P5HPmJ0iTBLKxQmED7P+PEkPCaUd5qdUrZy7falIsYlwfo+Ftoq
   dyD8ofBFc2g1zcFG1cE7/02ppM1UjtwksQQYPKlRal4ciQF6cFl25+c7H
   yc+ExWHTHOg1kvbjVym3CvASiZ11BmA1Z3auicXL26Y+wR0fTz/C2jhS6
   3qUEOqzFt2mQNNbDvbQf4yjbQWK986pjjhz/FU01b8cgmtmQunnJUgbVG
   yk0gyxcJLg34pqJXxC2jfwhQaKBTgeJilxfDo+ABeWNze0ZF03r9x1lid
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17029582"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17029582"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 21:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30125436"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 21:42:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 21:42:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 21:42:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 21:42:41 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 21:41:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdH+vVY77id1aVUXXgER+eAyuue3WXcNvhrQPDPOznWsrcTG7S7cPHcxViAKWUf7XjUilpchxqGIqY96Uu0G/iwqx/23WiFgbqvrqiJ3cQV9PSYfsQXcQwTFrZnHr6VXzL9QhXj/2dpmffNGidkvAKybuLdsKb3a45JYmrvbz155zYhbtE/+Cd0QRGBz782n1i2zLhc7RfdyIGvxWolIQwrCO1h8R09QjcfA4okymvyMNDC0Xg4dtHAwVeNmPvVJ7bRmwe/UGDaG9/sWskfjTLXxs+qMQGOZVK5X9Z/Q4avBYUlHkvXckzxbygt937IaAzNzfpMjjv/NGd5sXpzb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6Y+M6aajPgs0EvzxtdaOqfuS/vJMYXJY5hHbQBuaLA=;
 b=A21oeaQxnJQ1Dzo3WwSul05MHMnDfNPAAo4VBviJ/WiuAL+GNmWjry65lOTJdDgZbUHGH72CRacWXA4K64R9Dxa9UPgLFx+Dtupktgfg94z7Rao3I7RAzM3hZqXA9G5evW5+jTCyZ2yGm97vEZY0kwplzoc4F/rdlKcuRLKYQTGprDgIOKx9Zr8Fpax9sqEgHYrdrsGhzeO9wIxSRXmYTlOjJfdXLblhOWi0Bv3LVqQPxmohKZ2AkndCzFajWevhd/MsHW2a9WCeLm1FOeg+hLGXbFDvFKEiyjdkjM7ufiYNkDC+p82HDkbs4Lif1umcOV5Qw/Oqu7eQTcdvVoI9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 05:41:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:41:51 +0000
Date: Tue, 30 Jan 2024 21:41:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<alsa-devel@alsa-project.org>
CC: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, "Vinod
 Koul" <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>
Subject: Re: [PATCH 6/6] soundwire: sysfs: remove unneeded ATTRIBUTE_GROUPS()
 comments
Message-ID: <65b9dd9d80163_5a9dd2944d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <2024013031-tranquil-matador-a554@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024013031-tranquil-matador-a554@gregkh>
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: a58e77ac-86b0-4f91-11f1-08dc221f5350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtV9iK9TSSvuzfNkI+AWA4HFdY0iPaS0I0gkMzJnGHUDLRhqEmHAQ4HUxNqUhuDXvITbZfrLQneRjKGRgasL/quiqlaLZul8gIVwbbuDxWyxAmlaIblCB7RUMrBMBu7zujGbpor86Dn640XE8pdA34/GUE/CenURfBZLD659kvrJCqnM48+wIWqOZhfOHw7wPhY6B51aCWtXGy5UmTnkgDfZc7JdBARnN4D0VdJQbAacuVjAVC62FqzF4lw2/4B5riA/cHF1oLZM5Jw9px82lgaJHMlT5I0EBaCZtdlxcqKtJ9TnTZ1+2JE3owqaQfEu625IvwKg8Ymxpn7nKXDs2Cg56gvfeIw1najhDQyvwTAGMY1xhBg91mTrXNEGLt49A3HOu9VkWAXWTGuUExicQy5SdxqseheSvYPUtOrsOTLxOgQVbUQ5yVsiIHhUGEo8rNQM9lxKS4camEQjn+SPYQFxZq6V/jUv5Cs6Ge0Gh8dFl+il7MOffq24bpBnL/43SdRNKXJ/tonB+mfQNov0SvVmsBh+T7EbrVZjX5dpTFeIBvgghu9AwtsDXeoFtrET
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(6512007)(9686003)(26005)(38100700002)(4326008)(8676002)(8936002)(5660300002)(2906002)(478600001)(6486002)(6506007)(54906003)(66476007)(66556008)(66946007)(316002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2S1I6piryy7UPNOJtZrcTvpn/fFHBlgQzexKbmejUX96+I7nfx12LeqLI0gf?=
 =?us-ascii?Q?NSiFroVDr+ULg7fuVq6uTwiDfcs0nGj9GeFlVvAHuaIAC7tv17J/k6vfozSK?=
 =?us-ascii?Q?qylfxzRIO4yGF59gciCHaPIptMGLxqUv96lacrxI+TzKl5C+2fHJk5J74doU?=
 =?us-ascii?Q?3Qc52KFHgndkBtPmdeiM2yl/vCeqk0asPAj/OL0SkRXjJnq1gXcYQ6gMhBhm?=
 =?us-ascii?Q?DHy/N2lHi62+llgdLY4o8BAFFMD2eON65odlIjgX4aEk0peJorrgDO08+z/K?=
 =?us-ascii?Q?7GLOJVCGMySSvA5FnlKIULO7DZedaUhXtjp1NjbmG3QMBh8LtP5NSHlI7PJN?=
 =?us-ascii?Q?Z7aEfuGsO5nHpk5NMIuGKkJ3bJf+0iMUp5/gdzva5vI+SE0RKO/TcksxkhhQ?=
 =?us-ascii?Q?hB0BkQakg6kKSh6HB70B17ZLABG5/KcQxHvuBG2lhy0RsHf6vpmn0rn3hgVD?=
 =?us-ascii?Q?G9gEnIRI6dJuY+nNfg2WrvevBXigEqlGfq6SyXJMn37F1QywFAkcPrBHAjuM?=
 =?us-ascii?Q?ix0FJtgkodmB0v0+2euzUVAfCX/NJxMHQ0252+6+Sa1YQS3UBP0ZW+DK0ZAs?=
 =?us-ascii?Q?bDLnYLArcaQrCi+fyzERH6Xy2NFK9rp8eZEmXxks8TC3XAOlu8/sZ1wmF8x2?=
 =?us-ascii?Q?FSyUJVmliq0D46EBL9QqKHu3fa00zF+rWu3PcLZv4Lf6y8DVv1e2ZX+PvOwK?=
 =?us-ascii?Q?vySbtnFQs7hgQNzdQhpk8+yB4xC3SbZUODBP2RvcrnSn9YtuBUtqkjoOCGbO?=
 =?us-ascii?Q?PP0dy+NDy/TRxQrpMh98X/i6GkPIL+6U2Hvx3cM3KXaVzjAICmUgSFCi3pSN?=
 =?us-ascii?Q?yHKBQVK2+BZiaMpiGlqFfflSu2WM8fiQld4nk2dZLluzFqnEvWfDJkjw0tvn?=
 =?us-ascii?Q?iiFrGo+adCR0lwUePhkM+8DdrusJlX/uJK9MfIzjuQ+loHlRlGJsCnCz4cnb?=
 =?us-ascii?Q?Sdq91EmFowjRnhtzs7/IKs4B1JIHyJ2mMZMk7IiFrmByGGy+OOIxEzPKJwCG?=
 =?us-ascii?Q?IlWL/MlVI8ECSU6185yPVOWlkqWrvMSL35gUTjU8koreuZyjtRtmXUyPFnyO?=
 =?us-ascii?Q?YAEwakunI/Cw5sDgXwnljW8mxegqmpRs+O5Ii3Rd6x4xF5IqghQ5Me95OzxX?=
 =?us-ascii?Q?3ATJFvDU7mmVMmwH71f3cp14spj5UZtthMNJ3DSthfMPvS7s5ex2BeEhk+Qk?=
 =?us-ascii?Q?mbrdAv+KK92N122paJDnu4TTv2UjYlmm59G1S0B+R8zin052GHi1ysKrjRrW?=
 =?us-ascii?Q?A6ECUO+0C+Azk52NGHqCgAprBmruW+2B0ite5GGYJSYC1EgH9D3Y95aWrwE9?=
 =?us-ascii?Q?ALV5jDI3tHHrnO1D4znGRbxnYOr2sb7WSOK8hn2zCf8ulmDVPgd0bGwC267S?=
 =?us-ascii?Q?8ePq9tZaGmU+ztr4oP7m/F0tzlYccP5ls9axlh0nFC3X51S22nA0P2RbZ8lV?=
 =?us-ascii?Q?3tuLNlCpv+vW+ZWNG4rwuTFI1jwdgzPpCxVT10hmabNb+FHPSuuT5s9efCzS?=
 =?us-ascii?Q?p7+IDcGou5BiUn0yXw7vcXsGtHsMS3Aja6atklQK0x5LJ/vf3eE/hArVIUfL?=
 =?us-ascii?Q?5xE0CkGsZwLlHxFm2pEsIqPIQe1rYmLj/1GfaHbtglj+OsYtZXMoRLk8DMfm?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a58e77ac-86b0-4f91-11f1-08dc221f5350
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:41:51.7731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5rXqL6EwbZiLwOlfYBjzwlXgFgg72IIhC98usBL4I3zvRzuWcj1c9G1X/sZbfq2f0UwuxTcDpVDN63TpdNimx5IHyyiUjowPUVgtUnBBNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5358
X-OriginatorOrg: intel.com

Greg Kroah-Hartman wrote:
> Now that we manually created our own attribute group list, the outdated
> ATTRIBUTE_GROUPS() comments can be removed as they are not needed at
> all.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/soundwire/sysfs_slave.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
> index 0eefc205f697..f4259710dd0f 100644
> --- a/drivers/soundwire/sysfs_slave.c
> +++ b/drivers/soundwire/sysfs_slave.c
> @@ -129,10 +129,6 @@ static struct attribute *slave_dev_attrs[] = {
>  	NULL,
>  };
>  
> -/*
> - * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
> - * for device-level properties
> - */
>  static const struct attribute_group sdw_slave_dev_attr_group = {
>  	.attrs	= slave_dev_attrs,
>  	.name = "dev-properties",
> @@ -204,10 +200,6 @@ static bool dp0_group_visible(struct kobject *kobj)
>  }
>  DEFINE_SYSFS_GROUP_VISIBLE(dp0);
>  
> -/*
> - * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
> - * for dp0-level properties
> - */
>  static const struct attribute_group dp0_group = {
>  	.attrs = dp0_attrs,
>  	.is_visible = SYSFS_GROUP_VISIBLE(dp0),

Not a great look when there are comments around avoiding common idioms.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

