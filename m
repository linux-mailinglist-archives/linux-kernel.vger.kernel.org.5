Return-Path: <linux-kernel+bounces-45773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D070D843618
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466F21F26CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CE3D98A;
	Wed, 31 Jan 2024 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfhNq6Bu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF63D575
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679134; cv=fail; b=IFRL9nniCJZTor0t9ojGH+uCgktmFnl7F/OQeBLWB02XWRBzRiCBf/2GanZ3gqAOdE+UJ+vO+/tJYpaLe0/J4hFBWwH2mwNMAEl0U3/ZtDQ9wdUjxIWbshTVEnt+ov0j/6lQAnkPXb9/cbh622q2hui2MfMiULy6vy3KNKv/WdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679134; c=relaxed/simple;
	bh=HOyFohtz7lWt+QC7PDuq1GZpH8QTPwijoWcYR2A0EW0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N3X0gYfW2vkEUqyBZ2CdyIP+gV8QFDIOCo6OGkLSThgnK70KwT91wN9abSc7knClbTVj3tMUcc11wRChwpor+euQELKKU2UD9k0rVM+yI0if7ItbpZ0zyq+0JmzZQOpIw8qPpZ6/MRMOKMcM92BobYnYARCm8/eAj+SjL/gJib4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfhNq6Bu; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706679133; x=1738215133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HOyFohtz7lWt+QC7PDuq1GZpH8QTPwijoWcYR2A0EW0=;
  b=MfhNq6BuDBDMghxZ+SzJnXJnE6wWiP+hkxg6mmYpxE3sLdGqg5TT09nU
   ASvsVt8cnL7IJJDPBPzVos3tZUbqpFOKKYmnP4hyir8D5ySLsmQEs9AF0
   5oN02b9A5PI81L1zMEK5fSmlOr8bYCHSfblKWbOT3oiLTOxmiOCc231w3
   Paw25EUpNpdCc8ra4CZ48OCSlQAKruG2wpID+MjDFDSXBKVdMgjO4PiOx
   MxEV9Mymr/2gMwGpoDpSTDb9ruJY+OUsnRIF2Td23kkIDS4mxY05unDfd
   5qYIQgmPo5H6k9rNG+CComUsdr4jnYBg6/+4rUFQTZfXkjEldWy1cR1uo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24970217"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="24970217"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 21:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3974390"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 21:32:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 21:32:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 21:32:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 21:32:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 21:32:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMK6XM96DO+Xh7VXVrNKj/mBYyCq8YTz849nOuBIOnyCw/w3TAsAmUYMjedUOvj6/2SSQjCEH/gaNzMCha8sNmB1YLA3jbGTwu4RvxCfttliNIkdRnEnuY8i4JJCkJlNZpQgr4cGxSKj1ssj51EdMuFHyn2ZgLiO3OZZzNvteNliuNCaqxPyUkKUL5JeCVqH6wzQpAzFs+gAHhFxlQj8Zx2TZC1pnh2ksRzQrUSooscXpku7E52PRlq5QkqhaRzjUAvytoTOAUAKxyJ+lgBpp1iZFN5qkZ/tHf6grcnnv5fFuq0zQbAOfev1UO00nGuLnrPqX2w2LsjbOxUf695JHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm1BMHr4pUdWvl4yQSkEFMrcpeR9UjPl7MYcj9oOeuM=;
 b=eZE48jKDzGypsfgmGOPRTpmyO5Lrib/bnAHoCJkiqsRVE4m3ZSbNpc1iNaCdKr38RqcDy4ChhfoFmWdtIxmD/JdOrozSUyGgLsHV8iy1Nuaz7oKnCy0bUUiSfYGpkOtU/0Yuml67vXLqSLDgp8kWWsW1kDHv77dJ+2J0rda/NauGzb+f1gijm5GNPwFycmT5AdvTEdTMLl66xC62norjUa9V1ClAXS2KMCDo8w5KWs/MVDqQWxdCyEVByNH+UeJ01kxYsTbwQnzMg67+ShzNVpde+qGHQ0F3xtkivLd7M3+ercN7O+geoCd94/ca2CTFv8g4CPhcZgR9yqNKD2Z7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4894.namprd11.prod.outlook.com (2603:10b6:a03:2d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 05:32:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:32:06 +0000
Date: Tue, 30 Jan 2024 21:32:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<alsa-devel@alsa-project.org>
CC: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, "Vinod
 Koul" <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>
Subject: Re: [PATCH 3/6] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Message-ID: <65b9db5375de2_5a9dd29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <2024013029-budget-mulled-5b34@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024013029-budget-mulled-5b34@gregkh>
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4894:EE_
X-MS-Office365-Filtering-Correlation-Id: 858ba8b2-9116-46e3-2235-08dc221df611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKmSh0RJ0UDQ0HGlGKPTjbrGg7kMtuWdaB4NgLyDnCaA3lymMO3EcaEVLDqXvCMMQWfcIlkDwoynlkrBzvNssUX0Z+0D7BSf5xPde7yU7xbjEzMVMYxZMop25blSE9iAs/v4RWg/oChmsl+nisayZ42BZ/SSGbRcJY1DoLgda07ruH3RblsCukClyRU0ol7sY0V3FT+RRxXzvpll9pUzo6jYoQuJuITxSeYVDGyi9pO8+Y3c4jUvHoM/MxExQqZwX9MR1NRvnh9+CltLn9z48S/OVOvMszACD4/+DwQTivrLfqvcnxVE6LkzyftaqsRpoJIkBe15BmWJV8aH/yFh+U2jWVa17D4OMyndZ+HsKSK7Ka1cHSNtmXLlYATKC0oRXGRCQxEz1kC6d429tACNxz0TqpQ9naw5yKsbJ53p1K/TejxpnUhkyiJjQo+Jgg7n8dFVJqprs5luFLup7650b9MuE/nN+7aTmGZREVqY+32PrMM2r1oHEblbzEd6+K3CMnNIo7lqYvNosv8IxagPMY3GQ+pf/DFJuu9ue3lOz/fktFgUBU3ngHK6UR+SN4t4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(8676002)(4326008)(8936002)(2906002)(5660300002)(86362001)(66946007)(66556008)(66476007)(54906003)(316002)(38100700002)(82960400001)(6506007)(9686003)(6512007)(478600001)(6486002)(6666004)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kifTlPeoXPgoF3s2ENFyo9/+S/Lk1jCmFpPVWUl4ZRHtHjOs6GeA7fYe6Qp2?=
 =?us-ascii?Q?jlKzvDcxIneHahy/SmCHntzs4aYI3aYm7/PbFqyJt7qSVknmnWToM0J9DQxM?=
 =?us-ascii?Q?OQM2RBIe0DW3qfwJjy1cOCDL8fs+rOgoKDmIe2sUlBgmynTosJDNVCGBcS0Q?=
 =?us-ascii?Q?uM5mvGIn7KZlUoHCnqsAUi2hQ77Sg1eW8aNRS2czkPsmMGC8Tt9NmoCR8PgO?=
 =?us-ascii?Q?jDQ8KhITKH2Nqvt+3LmPeJFBmq9HOYfqrBc7m/JyTFdvuL2UjMDd0dORe2ae?=
 =?us-ascii?Q?VOSB15RbKAeTDihxESfboOExXb+v8D0PYihFIlUeIm4+DgCWDb6mohVKWIqN?=
 =?us-ascii?Q?CCVAf588Ry34uao0eQnQWp4OyQu6+1XfDmTC2n/dfdudAU2tVXI8+kZWQbBG?=
 =?us-ascii?Q?9/tLGcVjjlSN+aErLrW11A9Yuy+bccnBSFqd91whPTSGfUwwaFUo2H9H0y/O?=
 =?us-ascii?Q?5LB9s4k9lKHn0v0EwiscVhupJTmXL7f1i19d/jW3ZhogRJj0/wh+kuJaKdyj?=
 =?us-ascii?Q?uH4z5aodA6i9XIVJN/58l6gVHuMbL9Ck79Gtb7eRK9dZXXcEJTjZvwEl6sm0?=
 =?us-ascii?Q?tkXckj4b5eUaxtVKTanP3pnneZENCAUZ+YptLahG1zDBHHB5isp99fG0BFr6?=
 =?us-ascii?Q?VMKANXDR/m+hiQqxo2kjvkve0SNrNOReExkYwO6yxYl025j3VwEfFnleW7KC?=
 =?us-ascii?Q?GPMje9Mq7AU8r4GrE3gTd1a2UVh3BmC/KmYLZXAeIup1dNkBOVM4s58zLI8A?=
 =?us-ascii?Q?cxS2ZQcwKE5sArFfOLccx4AoAT6qQ3q0ZvgeJ4XxQiknJ7g1VRTRY5LXXjKF?=
 =?us-ascii?Q?slmR6rcp1LsbAeN6qYwnprvFhjoOS+2jvjFDg12KEpTmbJTTiXesP1fJ39Hw?=
 =?us-ascii?Q?UE1zzGdDWqbJ9b8i4i3BAQF49EBD3YGGJYXlnqghHpuVTOo2huPatwqjgGnn?=
 =?us-ascii?Q?tfJKiERRHcvyvuzk3W6I+7nceLre9P8ZC8olgV0p9IJPdldPQ3yaT9KGMoC8?=
 =?us-ascii?Q?d1piO0inDb3vIlqmcpfOVE3pk7VpMLLIUYbHgaIedSuz3tyyeNoFvMY9cou8?=
 =?us-ascii?Q?uKhq/uafFq6t1sbNiXAs2UeMDcMIBBbCfdKe2eowMM2UDEInROyZ2Yvv0hN3?=
 =?us-ascii?Q?VeLVIqp1Vpf8xhcfgMIGzNzKCYcnIev+7hBvSq1kbNXP/8uW/1VIm3ij5UKx?=
 =?us-ascii?Q?W/f9v6naT5QG5Hz2rr6jMoMHJlTRV/hpKt+Q9OLZmt1p8zweR9nsDC726/Ox?=
 =?us-ascii?Q?+UghUbRssbxiVIYR8nBPz1nQfZMeu4Dm01xwOXprYyFruf0sdtNmx/W9x8e+?=
 =?us-ascii?Q?jglzFe2tQgto6PHNqRA7kPNiAn6vP2CH/Btk0EriF2twlK7MnSjA3Is+txqI?=
 =?us-ascii?Q?5JzBEA3FlaGsZ9MMTcRtjuWG4VLB+e9XwiysSfjuMmDmD2LH170GuB29ByNm?=
 =?us-ascii?Q?4zE7Xd0iHLTglsvDz8qZZ+pvkH7W52psVlWsnBVq0Z7pdhPdEpOJKKXCXDnY?=
 =?us-ascii?Q?cWWXEx+uFV/G2QQWKVPHl1+q2SVl9fcBdKDozSWMWo5o3umGMJ0EWx47uIdd?=
 =?us-ascii?Q?Ol/OdSi4MdZwAR9Wdakm4T7BcglAAKvfNhd3sQSByd4z74idso/19SrdIxi6?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 858ba8b2-9116-46e3-2235-08dc221df611
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:32:05.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoDGehje/tORBuzeWNtq9gVYYBX4kOJ7VdzJRaF/T9fEFqpsis9TpdTP7KuC11ymOrVrP917Ubug8y/5YzxB7zNOlj2YPubuG3GQCdT5rGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4894
X-OriginatorOrg: intel.com

Greg Kroah-Hartman wrote:
> There's no need to special-case the dp0 sysfs attributes, the
> is_visible() callback in the attribute group can handle that for us, so
> add that and add it to the attribute group list making the logic simpler
> overall.
> 
> This is a step on the way to moving all of the sysfs attribute handling
> into the default driver core attribute group logic so that the soundwire
> core does not have to do any of it manually.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/soundwire/sysfs_slave.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
> index 83e3f6cc3250..8876c7807048 100644
> --- a/drivers/soundwire/sysfs_slave.c
> +++ b/drivers/soundwire/sysfs_slave.c
> @@ -184,18 +184,40 @@ static struct attribute *dp0_attrs[] = {
>  	NULL,
>  };
>  
> +static umode_t dp0_attr_visible(struct kobject *kobj, struct attribute *attr,
> +			      int n)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
> +
> +	if (slave->prop.dp0_prop)
> +		return attr->mode;
> +	return 0;
> +}
> +
> +static bool dp0_group_visible(struct kobject *kobj)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
> +
> +	if (slave->prop.dp0_prop)
> +		return true;
> +	return false;
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(dp0);

What do you think of the following for cases like these where
attr_visible is trivially derivable from group_visible?

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index a42642b277dd..203d2e7e9a1e 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -117,6 +117,15 @@ struct attribute_group {
                return name##_attr_visible(kobj, attr, n);           \
        }
 
+#define DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(name)                      \
+       static inline umode_t sysfs_group_visible_##name(            \
+               struct kobject *kobj, struct attribute *a, int n) \
+       {                                                            \
+               if (n == 0 && !name##_group_visible(kobj))           \
+                       return SYSFS_GROUP_INVISIBLE;                \
+               return a->mode;                                      \
+       }
+
 /*
  * Same as DEFINE_SYSFS_GROUP_VISIBLE, but for groups with only binary
  * attributes

..i.e. don't require $prefix_attr_visible() to be defined?

With or without that:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

