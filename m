Return-Path: <linux-kernel+bounces-93427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF8A872F96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157E81F25D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD145C905;
	Wed,  6 Mar 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oC2sdqcX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6B5C60B;
	Wed,  6 Mar 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710136; cv=fail; b=HvWUbvvLPGvWfuqcQ46Qsqkq8glu0zBr7dncfQX0B+HWdzTAoLQAzxsPu3XpgaUTwuysGaLCkVGQYKKZqanAXsPgQyTtQnS01ePhN+F3/cabEceRJoenGu7dUpYAblOMy/tNBcI+msz0p7DhYNlBcvOW2JO8i5zBgV0U9PCWT3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710136; c=relaxed/simple;
	bh=m8HudgNiIub4/MxbtjWwfEhKEJ8JmqXdVZQsc0qTTxs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nmoe6iYEcYuPBFRmaXqFV75TPdHO4xMGkrvwQ6e/My4r226BAt7RzRln/5XW0lSByaAH4gBcbcHSad9weL7WcQqv52hxExjTRMIaLL6ynMMZHzUdLR4AL0yf8R5vk4G0lc9Gu80Hk2Cnul1ljScK49Fv09DWSnC91KmipHp2qHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oC2sdqcX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709710135; x=1741246135;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=m8HudgNiIub4/MxbtjWwfEhKEJ8JmqXdVZQsc0qTTxs=;
  b=oC2sdqcX6B+SQ24oiiYUNI5QwpyL+JaHKjLseTURtvuI8RAobHR2VVF0
   B2Ox7SnCBA7orxOZZSnIdwZNX6gqIhfgaHLJ77d/tfBahzfyjfaje1LLF
   Ulyz40j7AzV+p5F/BjcMxXcwlyvlKyjg3/qZ3n1nnrF7ywY7j7MFYsYXR
   1gS6oPUUqncDm+gMeL/w1VrwCB1C0Ksi/zyvVf/peYAnYxKHwzT/iX7Y8
   9zh05V/r+OWB2j0w1f0WkY4fr2yURAoH6+nSbmuDTNQp9zCzRwYjmkp+h
   /aM0dyi4KhS71H/3al/wJrQFlCFqH/nUaQ8uKozXIHhYbgjybtcxjptmD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4460216"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4460216"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 23:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="40650828"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 23:28:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 23:28:53 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 23:28:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 23:28:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 23:28:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz9D3zPq0pRtge0MRJ99pF6XZ3Od0ZCUur1ZUowmV8Bg4L4tpnxpdtbWudXMVJX5ThjOiu4TfeZGbnxU8kyjw3gngfRKit/3Uk1aQjs8KyyJTQH8bfD6rsJ6DpAljNehs9BdhmErozOrme7cv5L2JmYdWobTwKwZJ+bu5MQ5ZYpjuJ5qjU4PZ4hEpGojVaIH/BnHN9lqtr98OjOr5fejYVzMW3uylLHvJYF9bOFEaefGw8oKYWT4FMewPKY1PGcifrvWsiomw4/2AnZCegf6b6FRlU99zTMLDEhdZlMhOyDhPKkdAFQOz2sa1vfJiPRsQYApng/VqWFoSGsBWnum3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD7Nc3kQVyTyGvyKIjesOw7uM/qZh3sQFZRqyH4W5/0=;
 b=SwMqVdtgSTf+CKbN+2VzrUGfUmbmPxrGYwoenWzjnklfa/sLcKyy5suWHXiT/rJqHAZWwMxRd36cNObrMVBKlcsWfsT9HHnIJU3PcoCD5Za0x/USpvsW2NE0bWZIQnIK8z2/abufbdSgncbfkDZtJ9R1OI4rsPwdbUJxytys63ThdDIfg052eNhbc43HXAQkmBw89wQlKIsjM3razp5VCJ6DnwiNabYAVe3Dt0t6L38+gBfbKSrXfRyNepxrN9bzvG57MjgSyuST5NYS8FfSqT3UdiSP5q3M9M/4kklRCO8zbEP6n3Wu/dy56E/3H3QqCW2jAuFvjB6AvmYyvJrnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY8PR11MB7396.namprd11.prod.outlook.com (2603:10b6:930:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Wed, 6 Mar
 2024 07:28:51 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 07:28:51 +0000
Date: Wed, 6 Mar 2024 08:28:11 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: Cover-cover letter for two resctrl patch sets
Message-ID: <2z2jc3a2fjr7q45ll4zuf2melinkgp6yht46k63tmqvstm5s2o@5omf4akn6st6>
References: <20240228112215.8044-tony.luck@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228112215.8044-tony.luck@intel.com>
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY8PR11MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 6265f20e-60db-4f69-bfb2-08dc3daf11e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z50MbyxA/SiD3vZmOafporGG8ON9RP93svwWoTNr1+e0TJdYpJnXiV/QLVg/FEng/K/9vBoy9ux4VOIrUOcJKYsDOpDhmb7uVUd5iJKl/OzYhaqlZB7ppEOo036Up6/axMpkMTtkcMM7bjHxVwyE+yMiV9YU87Lu9PqtyvrF74+F3O1/KOL7OJAjAqnpYBytzzEU1tT51c9R+IsCILCof6Q6yzEKJ1DEWXzJ9vqkv550ClYFt4ranfX3G7lbT4XTkcu2BQRxP1i4PQkz+56bWsp+7HJOaWBR92mAlcjtIgw1sUY85rLVa1ARU2V+DyvrSVuMmlc3Wx4o+q9+GpZehuLNoqx+vKMIlYUTmHWHHBb66JvDZgW+3t3tQV4pGH9fW2RcpUFTINkfKTYnxWeaPUI5BIOWKW9jTjR2TICLU6miU6wqTFm66rDcmCIul7CQloYHiNiVRx6Ktd40j0NZr+hTYN0qjpoggkyxSF5A0r9vE0kdIiCtq8ZmDcvMD49B1DayIloDNQSsFOBOLr/vNCsuZmTiRL4JZhU7n7uUYYOAzpnQCZNbwfpLk0l3y2xxZ7H/cv16xy7hFRL9BB3xnYn5wVzYGEjHt9bCp8MsE31GdMCgc3kW7B+52Md0J6PemcULMELLjZHDyEwcAWKto2klfRxKBrFSUWLPggDTVcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MyNZ9WNevFZGQXT7dCLDfMpzAMgy2QuPKdqrKNQ7gz+kMPoatgH15I54n5?=
 =?iso-8859-1?Q?uCWl8rz+BTxeOVt/kqr4p8157qi04726Dum4RTyPPLwIuiwBzv9VWeYsIQ?=
 =?iso-8859-1?Q?kc98q4nGysl8/xmYR5bioqXo9XZ+nbQjQPexpPhVWq81ygUIVOP9oZPgSe?=
 =?iso-8859-1?Q?TQQKs0Pok6Ij6iA/GjucElWqVbKMCFR8hRtR4Njimxxih1ZaZdIidVSyAb?=
 =?iso-8859-1?Q?czqk6pHTu5aq348yDs+IOFC/KuqU0Xli9KVjRb1N+6j4hKFHCQi1lLSri5?=
 =?iso-8859-1?Q?+aoyGMbQLkWuL+VBw+X7zFFB/HC8Rt+aTIKQWslRj3N+GVtrISqi8UAPJf?=
 =?iso-8859-1?Q?N2ONP1iQ3W1KuAXbjQpaNWOZYLN3YompPihnDsNd99LWSViq2YLrAX7mRI?=
 =?iso-8859-1?Q?loDomewkCZb6Re6pr/yG5I5FM5Sw3wPbHnwWKn3D2iwlaH7JD3R4nnQfjE?=
 =?iso-8859-1?Q?6Vmw7rkZYaWMjQsBiZTSNKf+w9e4eIXnaAxeJxRZA4k0qYTqedEhdB5wps?=
 =?iso-8859-1?Q?nmqvNHcQDxhE8F21rBD3M1RQOHB1DECb/0nFrOm6LmeQht8w0++EOvRhsH?=
 =?iso-8859-1?Q?M+KuxyWKGoPJTNMRSL7d4zybMl7wHsHki6A6oKZ9OmQmYh4d/bFfuCmqnT?=
 =?iso-8859-1?Q?j+Sc8jj0+e1+cmj9xrBOanu91SfwBcIAFJRDmb3jBTlHZvJBNkU3H9aiGf?=
 =?iso-8859-1?Q?bOSubYpJBbTf/r2R65CeVZ9PWZmFXqoM1eCDh3AvTm96HM9Zd0VyTy614c?=
 =?iso-8859-1?Q?HqfytN71ys4PkVbJJBVPhucCc45xncu3OT6mfOpW3uYd2HHZnW/3hSs48t?=
 =?iso-8859-1?Q?YZH0Hnx4WxHjw6dky3E/5UnAXRsIxVo8XL4v9tEaMRH9nvRBYDfiQSCl2N?=
 =?iso-8859-1?Q?iqflANxc36eyWX4XfIynmAqMzbuQzCqyRfdBWscHW7oEQzIkPqds8ucUqK?=
 =?iso-8859-1?Q?0XXLTVvRJppeHoCOB9W3Cp9DYNE6MxcKhAvYavZdzfp7PLIocs/A1pgs5Y?=
 =?iso-8859-1?Q?e18vhyU/g8/h1FB55No6eJuF8yg3K3trZLp9kVo2p/bxYRt41QyBJq/Qvp?=
 =?iso-8859-1?Q?BF5qD18jA/pwaPnz6+eJ03Xs7evXc84KUo7dy4RPP6nMFE8JTuNFfoerTj?=
 =?iso-8859-1?Q?PpXqBHvNGfCpwUcymNKjgK4sUcTjETLBMktfKqXVF+gSyYgVOrKKG35tRr?=
 =?iso-8859-1?Q?bKbds/uhKNNGKEUa1Q8ViWgvjNZvpcRy1N/ZMorejxARgn2OS2qxFM9RQ7?=
 =?iso-8859-1?Q?+iaDATCh+18sdzDgEkky9bvK1fj0bVkA7dFz6Tz0yWgapQoB/XfbPF5Yqi?=
 =?iso-8859-1?Q?g52RoOlq30SciToX2CW0naYFK/Ab83XET2t/Km0owQsIdDeg5YOVWbbG4D?=
 =?iso-8859-1?Q?dwO3Q0E0SgTkHBKFXP4xCljrUIV+asqAUNt8nWi/PkMNmxIxsFQ1mW5rl3?=
 =?iso-8859-1?Q?aMghubZSTTafnIq+5OaY4WFZ+ml4po5wThDWt2tFXmu4VsOpQTt8eIvi6n?=
 =?iso-8859-1?Q?PxkJuhHHcR3Unu4b8bJ7wxNpNs9SwIMbDLOdoegtgAiFTlQXLaRMEBb01U?=
 =?iso-8859-1?Q?sMZErI5cqZ1uu4f4GBvmhXhG2LTXl/HjaH9xpagToopboRfmOv6qio9RKd?=
 =?iso-8859-1?Q?7SmO3trwk1dm/U//ugFgx+NaTNmmogTAT06cdZDzyw+sCbb40y+UqjliuG?=
 =?iso-8859-1?Q?AEQGnNM+ao5KCjyGTww=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6265f20e-60db-4f69-bfb2-08dc3daf11e7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 07:28:51.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wj+3sV5zCf7rjYTWt2joiFmCwnxXdcfTZcFgG3oCwUdyDbZ1Vqaci8LbXBaXUqo38C9iNyvOiTA+z2uXikoZlsLot8k468uYLuB1L8RR3wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7396
X-OriginatorOrg: intel.com

On 2024-02-28 at 11:36:51 -0800, Tony Luck wrote:
>Hook these two series together in threaded mail clients
>since the SNC series is based on top of the two patch
>cleanup.
>
>-Tony

Tested with resctrl selftests and printks on an Ice Lake server with a SNC-2
configuration.

Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

-- 
Kind regards
Maciej Wieczór-Retman

