Return-Path: <linux-kernel+bounces-109597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA559881B40
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F4DB21C71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522D2900;
	Thu, 21 Mar 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eA/xb5mx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68017F7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710988827; cv=fail; b=eitjH5fdSHwwUTg4CQPOnFtiOEiqRj/p3knOl/d3FqCugAQ4GWtjVEa+KLHexDNkTHV7oRVdfjpIcLLNm7uAgAZtI3F8J6+KWlYN2yti1HsZpflpn70dJ0cz8AO/61mCEntTeRfsKZ8z1pJ4oKc2SBCQ1N5JLZUlOVuFR7Iszzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710988827; c=relaxed/simple;
	bh=XAJAoU1goAdVQuKqyUs5AanKamXOikrf0+L80K2yzLM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=orr/2QENxc3zgFlahRVVcf+bvyp52aWoFRRYPLxAyGBnCmF/b2k2grsknrU1YVhOK8iHGbvL9VDXNEsrdeaXGjiP6m2QLLRbjKCgTzSm3NsowBQYLpSpNy+KONEbafSTUPzu5sB/hzE7Cce+FeNa8srU+wZ3z7mial2NsLfa10A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eA/xb5mx; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710988825; x=1742524825;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=XAJAoU1goAdVQuKqyUs5AanKamXOikrf0+L80K2yzLM=;
  b=eA/xb5mxOt6cQkHHpxeEbgwzpz269FEsqsO7H5EkwlLjyxTXdOJSUI3D
   7FO4s00TcsQAZdd/GiC1kY7JSGL2txdvDFGdHLrFowMDqv5nnOYY0xg2q
   NzJqD1hGuu5WeCAKxlHq0WN6OwDkoWduOS5iqWqsqiYyMh9X+vbKU0wDG
   +N2DvQk+VrERpkHox9Wj74cSIj5SveOXDZAjs6yHw1H/La9bsbSSK5wKC
   LmuC1+aXsW4ch2yqf83MU41k8NoK3J8KCPfUi7NrXV24T62P+Qdo+qzJK
   kIED3QDz11845lXmeve3LriSzOoHgkTa1AngZRFfZPnG42ecuczmeiHxv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="28427810"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="28427810"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 19:40:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="45345830"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 19:40:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 19:40:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 19:40:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 19:40:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3Omq5KpGfP9PfDdmIIA6BcgceNK3udWqRfbdwby3x6Kd6ohH5A8Yww8z5yMAJPpte01Ydic6efaoPLj4LwwnJqjpYoh4ZOnayURAIecwpUFgE2sk7N1rWS0PDYvXHYgPpchWepTdOdMqgmAy0e+ZmOTdAvPUp4+OPxTQxdZP6ci6rLj/ddyfURX0z6X+MY0jWtdEXdOFIfEzTECqIQupzMAZXJQc7ijbsuPm/l15Ee7NQzOAGMa4BQZ/bt1igFzN4Mir0FgfyT31F99nUUN/2pgHDNjzd4MsF8NIaJJQ/LnOaAVMEpPmNTZT9pq9LyjvAz3LgL2NHfTq7Tmx143jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYm6nJKxiOt8aGtsq7aZiYx3sSZ/CsJRUQa3OVwq3zg=;
 b=Hft24zz5T1fSKzI6G4tRkZVT3Pc4r3qt0GxKI54d8BpPiInPAT94tH//bivdMxtyNx5yEHiYu71n4R3JzpIldZrjrex9rT0PmcL0MW2sAuartNfZF/poozHmQFYK1LxM7xAjy9YfNMuCOuroYNe6B0ga4UK8aht4iqndR4UK+6E/u8As8F+7qIea9u5vcGKGCShv3a5vFsCmQb1JrPacWXFXTQ4yw0nxU7qU/l0G397I9ckOsdr5VsWm5pgUHdKGua/ZoJbdlgZrLPn2KocXkiU/TgfqR6F2fDClXHfJ/XGFetpM6Gyy2f0VZhyIoN/C4co06n0wDnkJczuO/MQqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7689.namprd11.prod.outlook.com (2603:10b6:8:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Thu, 21 Mar
 2024 02:40:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 02:40:21 +0000
Date: Wed, 20 Mar 2024 19:40:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 12/14] fs/configfs: Add a callback to determine
 attribute visibility
Message-ID: <65fb9e128f7f1_aa22294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <b851e5f74398141bda2f5e6e1f0308cd13b39aa1.1709922929.git.thomas.lendacky@amd.com>
 <ZfIcjeIWaB5RzNye@google.com>
 <9ddaa371-2e42-456f-983f-1bd8d42d029e@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ddaa371-2e42-456f-983f-1bd8d42d029e@amd.com>
X-ClientProxiedBy: MW2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:907:1::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fe5ded-290e-4afd-7d72-08dc495040f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oErq4HRn4SnLd0VCEWFZkWLzNVP6YMbPbD4Dsdob7gJY1ZNJf1zIqq9tzsQApLe6V7PIFK2S6LRar6CKpU/DeeH7GqtJ+Xr6dLRY7tQleyklFnY6dqTGUDgb0l9GYxL4oXzGqkCJs/YmFtzrsPgz4I+MtetSHFis+aQGPuXLi8QUv2hpPKV5JolfS/TyMHhxXipFFMBwhh7WzyS7VEH2iHqjBCYYdbdR4Of0e4S1prr8kx2LU6AIYqBtnwXadxiDxxqJ1Y9xL5n/crDUTe06QKTwivJEK2CpoKV5aMN9NLL0CNP38Jkn1FnWTkAUSbbP68+iB3x2oKaEBBKim0nrl5+PJC9IevPDe8QVSxZwQXdyG1+DV4BfofzPMFH4HsQTzQ4uAK1/MiH2kxj7iC8YLMRpSjxpa4l8gcBo9iBD4jF5zLWTJ3cq0YTC/5v1kUtUrXDIthaNPbDQkb76Hdb0PJ3aWuAqD+m8FiS2H6V6PBjjTx1ZzizgpBdk9cpbuHSE4Bxf0zKNeuHLyT8UP7OGorUpkSSVsxc4EkktLysFMXkfssEd0gmPT4xPQty0+H5XMbx58jSdkM/TuFnULGyNFny5bSPDdQxQ3ZNCefvxdHoYhOE3q3Wsa/veEpSVhZmmm9prjn/J8TdaCYg3cG7fcIoofuTNiBZuMlF+GalyexMYW5T33FrTsjsTxVfropmRQZWLbh2ieku2YG9n4hA+rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OvKHj1NAlQ1Avp+De18O3hbjO5pC5dpKBWfE34aTJ62+bfSRRwa8rF5kDSCC?=
 =?us-ascii?Q?CD/TI8dimhHWsOIewV060esYAKrDq7SsZFRYtVvRAIht0X1NiqYFQor+9eqI?=
 =?us-ascii?Q?MbdCTmgMCySzDul0D0akRUFp5Wl5xfofb/ifpukDVVIcc1OyqI7loZNOjhNc?=
 =?us-ascii?Q?l+ktrdo81lFAuA/ucfr/rZDCG+Ih9cHfp2Fkf4xa3TyrJGfOXEQdknFVZDk/?=
 =?us-ascii?Q?1HLhCSj0jjKfup4vMuIJhpE4up3KteR00kDsgwamXmeBH6ztPfkR41JFymlm?=
 =?us-ascii?Q?vmAuh+4o9IVdTcFmy13tALBS7h81eZAFIxnjmnOpbRcIsOP3h2zHdZC63x+W?=
 =?us-ascii?Q?Ge7HvtYCRO6LdciKXiB1UNvR+6aZzA0Q+zR+H/FN9G/GoSVVX7MFbVv/zpWi?=
 =?us-ascii?Q?+fQseqBT+qLt+9hGGd+CFsUOkadpsVEpzdRs3EHBL34aDWoK8OLy1WGewZ7s?=
 =?us-ascii?Q?l3XJlqyoCfdlksqaSSZ24S4GqPM+/TfR0VkVBGeujYh9+UIZoUViO4URNSBf?=
 =?us-ascii?Q?smd3Q8HJCbztQr9XSEJDzG3C/YwPh1NrlnYJKIkgaQySzmeWnzKVTuLk3eTI?=
 =?us-ascii?Q?cqBIeMbHyTeXGBlvhyV4leMLtaxee1ej40MVeMe5bi7UMbP0xmIGndkRUncb?=
 =?us-ascii?Q?2R+V4p8bww1UmI7B2FVT51LTbQOyTRC0p+jLsAkbUaASKdgPotbiXiWJC1T6?=
 =?us-ascii?Q?s8VYMjAxQB2KrEDGL/sHqFXdF60a3YGB/Vsv+RMLQwJvtMMYb3WfmDL4W5iD?=
 =?us-ascii?Q?oXrULb6qtNvbpC54E+M7rwaDy8R8t5wbMJcQAyNvsltqZuW1iSKTTLnRP8tr?=
 =?us-ascii?Q?8vPBk/YCFFLdWpMEfLl3BmBTPQIBCVIuk//vP3LnEQn8P0K0eFT1vFzYrrWz?=
 =?us-ascii?Q?SnyTmQGsl2iFJia/TZ6HExgU4l/95Nq/tMO3yHXKgg5MIq+gUbNBcBcwJGh2?=
 =?us-ascii?Q?p98ZJb781CsBalJ39sHd3+wAc2ad3xcfAF/WY3w/QT9f33aem1o+mIVVNuEK?=
 =?us-ascii?Q?sCQADYTrwF0r4NmMvIeMqVp92ZIfODc2HMEY2yuKhwvlzhviWUXt/5hUU3tG?=
 =?us-ascii?Q?9Why8OtE9Y09htyKMPtb50LYq5jkFaK3OcXd5IgMlPaSxHQOFNtAfhLD3jKw?=
 =?us-ascii?Q?34bW6t1VoLKcE/AVpYcrqVadzfFELWMSWwQcEw7MtdMKWYHfAmxUALc4UbEU?=
 =?us-ascii?Q?BT5/w7cIvfj04Cympq6Jw8l7H63Sr5eoIcd/GQD34nvsZ7X4P3sq81rBh8ti?=
 =?us-ascii?Q?N+fYS0bm3lSFmrjoeszjtuh2ygiwrNwgfR1pqxFhSBLvxpDB1bBSpUxlrcnq?=
 =?us-ascii?Q?Sa84e/Y7Zbhaa7NPSTklMP1sTI70Ty6Jgv4J/f7qZBJ0+o2VR72HKXQX3qLq?=
 =?us-ascii?Q?hWtZvmfTpFV+qasCYNrgZdbEdlR8MZomMBN2rvLuzrNX3uHVb0GoSNYzeq/d?=
 =?us-ascii?Q?Px0mUYm4iuiDfFYiaoDIGwKISwPIM5djI/l5LQt6yzkOX6KMX3YThJ0f4GvU?=
 =?us-ascii?Q?u0p1MHJtkhGElH7xE7RAvw/blvnvCKV7bYn0c5dMO/TXN2ruM5TxdwWEjU+4?=
 =?us-ascii?Q?VEOyhNkS1k39BIH3ADQZTongbCqikqT+yWWl6AtjzG23y3JeSUMh5XvH/8Ll?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fe5ded-290e-4afd-7d72-08dc495040f4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:40:21.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0cv315ZZy1sx/anMqpiqqXiX7NPWAQJ5IDvhvASB0nn4zqEGPaK8PNFJpjL4SCp4S20gTZ0U5TZubVVnfuR/va2SnC1bZG7CBesEboSKVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7689
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 3/13/24 16:37, Joel Becker wrote:
> > On Fri, Mar 08, 2024 at 12:35:27PM -0600, Tom Lendacky wrote:
> >> In order to support dynamic decisions as to whether an attribute should be
> >> created, add a callback that returns a bool to indicate whether the
> >> attribute should be display. If no callback is registered, the attribute
> >> is displayed by default.
> > 
> > I'm curious what the strong value is in this extra callback.  As opposed
> > to not generating the attribute in the absence of a TPM (why create a
> > config_item at all?), merely having an empty response from the attribute,
> > or having `->show()` return -ENODEV or similar.
> 
> The value is to reduce the complexity of registering with the TSM support 
> across multiple vendors. There is a base set of attributes that are common 
> across vendors and some that are specific to vendors. Creating this 
> structure in the TSM support can get unwieldy. This would make it simple 
> to determine if support is provided since the attribute will either be 
> present or not.
> 
> This would also make the support similar to sysfs in the ability to 
> dynamically hide or show attributes.
> 
> > 
> >>
> >> Cc: Joel Becker <jlbec@evilplan.org>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >> ---
> >>   fs/configfs/file.c       |  13 +++++
> >>   include/linux/configfs.h | 114 +++++++++++++++++++++++++++------------
> >>   2 files changed, 93 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> >> index 0ad32150611e..c758bcc11235 100644
> >> --- a/fs/configfs/file.c
> >> +++ b/fs/configfs/file.c
> >> @@ -451,6 +451,12 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
> >>   	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
> >>   	int error = 0;
> >>   
> >> +	if (attr->ca_is_visible) {
> >> +		mode = attr->ca_is_visible(item, attr);
> >> +		if (!mode)
> >> +			return 0;
> > 
> > What value do we get from carrying the mode through here?  The API
> > proposed is "visible or not", which is a boolean.  Overloading that with
> > "also set the mode" is confusing, and it also can lead to the divergent
> > codepath problem you mentioned in your response, where
> > `->ca_is_visible()` fails to return the mode correctly.  If this was simpl
> > a boolean hook, the code could read like so:
> 
> A boolean would work. There was a request to make this similar to the 
> sysfs attribute visibility. I certainly can make this a simple bool 
> function if that is preferable.

The inspiration was sysfs is_visible() and an idea to reproduce the
"static declaration + dynamic visibility" model that sysfs allows.
However, in the near term boolean visibility is sufficient since the
attributes are either on/off by vendor not read-write/read-only by
vendor implementation.

