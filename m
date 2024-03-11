Return-Path: <linux-kernel+bounces-98538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1768877BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBCA1F21B91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B912B77;
	Mon, 11 Mar 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kd+mBIqn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4B12B70
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145462; cv=fail; b=icEXDQVm/OLTkxPz1BbXf3ZC09ccodb/BUgMON6HyKOBlrkhFS777fNdBken1Vq6lirF2wxsRPK+fuOTkQCp/754vtcTgtQFKBs3yXHi1WjsoE+3bfQZUoWTCYnF1ETTRbx2Wkz+Ek/cCL526fXfTDxIMTNzrwPUZoplU0pBYSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145462; c=relaxed/simple;
	bh=zQzj+jWv1jDV2zf0ecUaPeI6BKIlOSjy2+9f341+L+c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SfjOYK7ltNyxx3VpiErUJuTIc1AzECH5WqoIEQS43RHy0B8BT5c9sGAnPtFuZ65PZwndv1d6INxq8A5nqvvimCknQNkOZPL75Kciv5VfA0GML+C7viH/rp2KYjWYlRzUzHayQX6G+Gw2RwB96Bb+5BliaJpqWyuGQzB7L8Jpn5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kd+mBIqn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710145460; x=1741681460;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zQzj+jWv1jDV2zf0ecUaPeI6BKIlOSjy2+9f341+L+c=;
  b=kd+mBIqnBjeEsWBKAEgS9gTAmXqox/4KQueG6Cqal/3MYztZj+dC4eQH
   /C13Ghmh782DhjjFRyPenG4UH8G5Neq6Sfgz3iKuTZEq2JBxl35gCRHan
   RMoEP+kUEtPW6bW6hU/OhhmxoornTq1wNmpfsNPQgI4eIauFr5i4LD32G
   d8o9egYsCJTlOp2vhXsfcY5426vW/cFxFp8oLDo0AbpUKdcoHo3wvZHpf
   bbmLdPbrMFKZu6lBpk4yeUnv4Zs4peA8UrpSZ64OMYOClK2ZkeA6M13YL
   tl0I8d8T0Bbi1+Ph5dPpbM8warMr3z+yj0eQefe24hHqwP+8DeU2wrfpk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22252058"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="22252058"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 01:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="42077008"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 01:24:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 01:24:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 01:24:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 01:24:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 01:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb59oC/4l7bhGHj55kEAwuY/okjuK6Vmd2z0uldXeRpY8vTmX1ei/l9TL2/Ujv4muoeGnGuf7zTp7j95qV+opoh5KVD1S70oXUG3VLJThd15NJdO/4yP+TpdCgVzkHyGcF2OE8AZbQqmku5OaznUS2F2QVCnbqfTWiAknU5uGqcDGFmqsoG34MF+0a1DbNZRqxlMAGrmJ8tYPGB1bvpadaA8GedyKy4/MRderE6UJrsG0oSrwUmtqfsLwX2kZBgZEIk5EJJudX/o9QtOP8WoKxhWZdVN5+Y+nV3m24VqilVW5s9UfjaMhnVPtxtXjGYhWk2NlH/Yo6rDvny26bTS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm74aGLALEGVOKIRqbnhlHYpQLo4wsn70hUQMhohdN4=;
 b=i1gzkc0JiUtX/uyun60Ea10TvhsYya6jelyN/FmxLlCRP22gLacJG0dv4X0cMIt59z3cXiAV6Jv9jf/XwJr0PrmqcM4eiEaKBYVgcQ2ch9qkfnU9EjS3dHbGcX/Frz33PY0qafEE6aDmk9wigkoujq6tMlsgDKsTumh50FK3lQeAgbQdxRQFUe5jrClFgTsxZtovu99u3rD9kaTquHBT5GUg1iiAuAP9qq+hxNYNylJI1LL6VqS0gCvx3glrhyt7HPmfLuL0UXpQ+S7uYg1Zs6+BjnhPM4gVIoGsiRQUoVzcQ4anlCA/z0PGrRotyDMpx/mOFIssOqxwMSyMJz73Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB7871.namprd11.prod.outlook.com (2603:10b6:208:3f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Mon, 11 Mar
 2024 08:24:15 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7386.016; Mon, 11 Mar 2024
 08:24:15 +0000
Date: Mon, 11 Mar 2024 09:24:00 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Rex Nie <rex.nie@jaguarmicro.com>
CC: <james.morse@arm.com>, <fenghua.yu@intel.com>,
	<reinette.chatre@intel.com>, <linux-kernel@vger.kernel.org>, Liming Wu
	<liming.wu@jaguar.com>
Subject: Re: [PATCH] fs/resctrl: fix domid loss precision issue
Message-ID: <2u7eg2khp2zrcmbfpnh6ighxqbttv2w7giwdxlkndeywpgq2bq@2lccnqwkbo65>
References: <20240311064822.891-1-rex.nie@jaguarmicro.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311064822.891-1-rex.nie@jaguarmicro.com>
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: b04d279e-bf3b-4ff2-b34d-08dc41a4a2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2oFFoRMHYYwnyarpx17feeptm2b6WT0vEtyae1/WM6UYIFhLJpyCabrhVL3nYc55FOHIHN2VrvLUi/X1rPSSPmMI3/k8MSi7kYI9EOqUfT6ja9F3tLy3w71wOKqw5xuPaWyNu7N8WBDnJMsmcq3GbPTeIkkFRcaPkeELk/KFnJtaA9NQp73kYow+TE7HlsZAuWRs5tn/VkThaPPpr0ONykVyrnebeBgs+QsX2yWfoO61prP6IwNtYsuky54GvADKv+pXhNm4nfi0Q8sFVnfhV+I4l8aNI3diMC9RjVnf24cjhq7uoEDG6GWWNGoPrhymRKedL1/+nMig+/IbGepRvp/ANvwjVi4+xxw5kx7EcfAuj3X8sxP81rctS2OZxInmzj+LUDtbuHJeSoSyEpygv0zyB7yxXJkUOypQ9fgvsNeacQ6GuF/lzfwCTLif5O7kgxpTrvcKGQHw3OcTBiGD6MVAojIxI2nWGnpEPjJ3GbGyJEqYnHWuLuRn4ch9bLeP9eJ/cPhjwZaiXONsPaDSZ54ogc9ene0X3xipIiYBtqA2rzlyX2kZXbBSSb23SED8CJu0LaBZJjpDJET51rt4QzIeWxuvncw7lqZOBl/krlKw4+XuWdDG4os3rNy9Qzx//haCsFAlqGYD2g7Wq/e06Be38jPm7L+36JxfjXLOcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dQWSxhNdBaCuzIUwXyHnDhO/McE1IzvTxElcXsdpW3q6RVKWsnH8RLwA4f?=
 =?iso-8859-1?Q?Bir6HPv2eF6NPGXaIxvtchgu9CkPYebIZt2ctoYmgt1lpY0qHEYtrasvKd?=
 =?iso-8859-1?Q?G0TkWt4wDr2G/BlRantX9/LV4Gh49c+dKiwahr/2mtJDMOMJBwNVqK0XT4?=
 =?iso-8859-1?Q?GUDqjm8ChDa9mQxjPSM0356IRiB+/ZO51TOoVvg302Dhk1Cf5qVetRfqqp?=
 =?iso-8859-1?Q?nUJ2sYdYHVorkv+TKlWuJPVqIolFlB3QV9r6qoVzVq22u2mvIPxb55i3YP?=
 =?iso-8859-1?Q?TQ94NW6zd7ozLcaKOC5wvBzT3lySw5knUU1j2+X6oiITHDq8kr9aJ3ZvUO?=
 =?iso-8859-1?Q?8Z2HWQZoJ9myp8tdaxayvlHKCxmVhWvSEI3Vcne/CXHVOdJZ1KsdxvqB+K?=
 =?iso-8859-1?Q?Bl4D1oE9kyyzYuU7CoDKggi2jZXtH/ZLtVLVXXD3KiSogwdLr/WUlD+Dxj?=
 =?iso-8859-1?Q?V1FA0SiHG3n2PgJzN+bF+sJLG5ZDCVgAWVKP69kOKIIhwy/98SYHQuBYi4?=
 =?iso-8859-1?Q?vCyAU0Mn97TlooE4lwRLxrQJtaxIQVHcRHGN96yn8S4OLdywvb+Q6rFxTt?=
 =?iso-8859-1?Q?LblSsBLSnChwHv9XiOcb5i0a3e+ymsAeU0wKZNEoyIZB7xTdf6vsuhEu6L?=
 =?iso-8859-1?Q?ho48pYRf9wxNIohJEmUjWRSdaULNqdCEkQ5EqzNCWUxCxTXrzU3eT06maV?=
 =?iso-8859-1?Q?UQhtA5V4V0G9HwvApNYOLlB2AhfO+B4LWLkaAz01Z5A5GH6kU4Yc33hZpb?=
 =?iso-8859-1?Q?Qe4yS1XD5RWpGtATmk86CzxyrVMSm+Se8TOGMhSbIjqvGXIOSBRV8CqfSE?=
 =?iso-8859-1?Q?+f0FykT0NdyNG3/oPSo2qB4kAl3qa9JgFXl6PCxSzLNWMjOcENSSI9pZIv?=
 =?iso-8859-1?Q?/Ohk232Ako8fCb/YH96EFQA0IikVx2nu5iDwLBiFrmhmW/QxhJgqqqJDzv?=
 =?iso-8859-1?Q?OHJQM880A3gtinFFvz1gXO2ygwdx9H74BGWS0nh/5OH50QzF6inPqWdMZ6?=
 =?iso-8859-1?Q?bKQxZNL3xW/gN7QkZXman+oDuQYifBWhQx/0jf/TozMnoi4OipXGAvfXrr?=
 =?iso-8859-1?Q?geibkDV/2f6a//CpAfZlI0Hifg66YlfZ6LKJjEkNxjfXaTLHttu6d8lAfe?=
 =?iso-8859-1?Q?eNE5+JP01fUTxVin+uv/AkWE4Akv+VaqqYwVH2NAt+1epIavjCN5nTXyyy?=
 =?iso-8859-1?Q?7W60NH5LRPeyzT68YxxBYXDkEmP3QnuVSTNl6KuBblY0PO1eyhqnyumLpP?=
 =?iso-8859-1?Q?JHttwgNDBUfVjuOO4M4bldqAf2ExIUOZWFI0tU9s/zhmojIcnzuVD85bRp?=
 =?iso-8859-1?Q?gGgLOsT5K75NlaArs0VDwyMCJGtwXRW2hoLaqSBWwLaKMgeGpIUibX+Ixb?=
 =?iso-8859-1?Q?PV3ZUd+89kR3yLT3jWWEqfYsgSVQpCfYy/IDYhseMr0E4wc9vHy5qwNsPk?=
 =?iso-8859-1?Q?fx/7onb4FLeVKBc7RFMaElk80rSdaCgOklUpmu6j+cwFdZv3Q+l8Zot+FU?=
 =?iso-8859-1?Q?swtLMHJTlnccIugNVvZbOVhne3mCiI9ZnEjyoodI/awRgu0CcIJF8ZiqIB?=
 =?iso-8859-1?Q?vj+rMLWbUSWoeGnuse6VNayvXKgdD/SKYzCX6p/W8RedZ9QB9xyS2D8KSy?=
 =?iso-8859-1?Q?RruhhTAScum/IOXyM1b3XjkFktD+bekX8djpXUizD0dJYVTLC8Z4v9FgRC?=
 =?iso-8859-1?Q?hu0oGhYgwim6Heu6Zsc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b04d279e-bf3b-4ff2-b34d-08dc41a4a2da
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:24:15.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p14APYPu7kOskxYNWlVJOdgCtG2OfAHQ2VKhAfcjlf0pxMKZ6fIfBXSOOVp1LptScuZdd1BHqnHsJiUXc75UBdES64zCcKfTDSA3jJKNPyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7871
X-OriginatorOrg: intel.com

Hello,

On 2024-03-11 at 14:48:22 +0800, Rex Nie wrote:
>Below statement from mkdir_mondata_subdir function will loss precision,
>because it assigns int to 14 bits bitfield.
>	priv.u.domid = d->id;
>
>This will cause below issue if cache_id > 0x3fff likes:

Is there some reason for cache_id ever being this high?

I thought the max for cache_id was the amount of L3 caches on a system. And I
only observed it going up to 3 on some server platforms. So not nearly in the
range of 0x3fff or 16k.

>/sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupancy

How did you get this file to appear? Could you maybe show how your mon_data
directory looks like?

>cat: read error: No such file or directory
>
>This is the call trace when cat llc_occupancy:
>rdtgroup_mondata_show()
>	domid = md.u.domid
>	d = resctrl_arch_find_domain(r, domid)
>
>d is null here because of lossing precision
>
>Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
>Signed-off-by: Liming Wu <liming.wu@jaguar.com>
>---
> fs/resctrl/internal.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>index 7a6f46b4edd0..096317610949 100644
>--- a/fs/resctrl/internal.h
>+++ b/fs/resctrl/internal.h
>@@ -94,7 +94,7 @@ union mon_data_bits {
> 	struct {
> 		unsigned int rid		: 10;
> 		enum resctrl_event_id evtid	: 8;
>-		unsigned int domid		: 14;
>+		u32				domid;
> 	} u;
> };
> 
>-- 
>2.34.1
>

-- 
Kind regards
Maciej Wieczór-Retman

