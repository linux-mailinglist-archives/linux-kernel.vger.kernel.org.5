Return-Path: <linux-kernel+bounces-103971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B93F87C74D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60845B20ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602B1613D;
	Fri, 15 Mar 2024 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvR8DzNG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7154C8F;
	Fri, 15 Mar 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467146; cv=fail; b=nnbZcb7McKMdbSREDkddPXf41UUpdWIvT67Uv3upla0NtXTbaiowyQJAqovbRQLhkGTCMeWfIO77DTQd3utvGwZH6a4hWP5AIZu6KgVDEXUyhECNZ0qaW72MnhO2LG7JtO5H5hNjRX5zGmEApwZrFcZIbTWcrtpHsqGgyfSlHI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467146; c=relaxed/simple;
	bh=uNOsli3tnyistrfcmgUUWX6VFz6wQF0Y6Z6eU7cV0Ho=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F2HpacydW95PrHFBI2ONn3iTUMkl9qDZM4ZhigQkJACgeSSqLeiPMKY2oQi0j+dP+bXXpejMCeNrshBV5IyaQlJkunJkmgi08+SouYQbnDdrzrxvub+p3h4zbd4C8AdzJT4bFfDzSV1nVVciIUKutnttcwDmyhOWssWnmKxvWQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvR8DzNG; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710467145; x=1742003145;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uNOsli3tnyistrfcmgUUWX6VFz6wQF0Y6Z6eU7cV0Ho=;
  b=AvR8DzNGsRKxN6SCFSBEmUhQdftN5nWw23X88AdXBVGlWuQb0UaVjzsz
   /Rnvmw7A+nzwCmmayV9lIuxZqnKtHw5UpUk9AMU4O20MG33ldR9NIhQio
   rrpgRLQs7erI7d2JkpzIWB3iF6MbTOn37MQJsdkibBUtDKtry/RmuBXwI
   T8Xl842JHPL2LVcEIbFHzvpt7b2uH04Xt0uvi0+bK1VEDZrH1/Vufv2DV
   A4sQPnmQcUaE5WrfnV9n/SIoa6pL9wPzt5bK2hzA/lgzlFnzhxU2KuwYI
   WdOogbib8GTESURSR89D0g995O8nS09pLjTNSGoG/FueZyKHxasTGVnuF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16773332"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="16773332"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="17206059"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 18:45:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 18:45:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 18:45:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 18:45:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 18:45:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx2Z6npd0pEgImcH3fqRsBpKtJqESk1qe1ANCP4a4rqNS7plSCjxbGmlqbB5OCHiG0jciYwwtGcd4O8hLmh6X3SgwYgX23mu/z9QTS1bJmspzjThzy6VhUskqt3z8GhG/b7YjbhgnIcfz+PA9y7gLqancJ27MegsLk0vL021U0h6xpB+8J/SjIy6D4DNeBFIMQao9HbzuGQqczlqUVP66VmHP44PozbamthPO3XTfEi7U/u8ebQk5+mOdXlzSR8vfBYNFkzTSzjVSViumxKWr4KbR+v8wAC+Jsqpiw/j6Q+p6z2DZPtbyEdKwg5GXNGdCp1EFhGT2zMLVAvPhwOiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cnr70SRNYJTCVv7DQOoi11K4bRMyBTPFzY7jiEohtHI=;
 b=e/zBplh4+hsGHkJRaJmZ/RgYnfnt9TuHFRJUsMwKrQT8XMLBnf1ibBYGROwDndPxwLwgiS68bDb1zgRFnJ6L8sgW+GlbjeSxZy22D0WOQtBt7GnXoDmfq76JFB/3VXtrNXiy/yOb7n/zptZVNuoThXR6stMurjD5ZX1IPRW9Dw1QvXKjFwhVbD8XhUK5xosOJJhIOEHZSrLyrbFSG0PfAmR7VzpQWMd5yu7ZY1mXdbF8gdsEeMmY0IwTie7e3C5K+iVLf/0cAJ2bph7cJ9+x2Ng0YRubLQ8WcjrQivXpzfWq7IlxNnytaD/cUadY8y1YegRt3U+jbFhVOWoPa6GIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4579.namprd11.prod.outlook.com (2603:10b6:5:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 01:45:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 01:45:41 +0000
Date: Thu, 14 Mar 2024 18:45:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming4.li@intel.com>, <dan.j.williams@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming4.li@intel.com>
Subject: Re: [RFC PATCH 0/6] Add support for root port RAS error handling
Message-ID: <65f3a842988d6_a9b4294f7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313083602.239201-1-ming4.li@intel.com>
X-ClientProxiedBy: MW3PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:303:2a::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d580d9-c36f-47ae-c3fd-08dc44919ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qfb9FYui7CjzqsywLggr2irtYX8XyE9hz+y0rNNAnEbNpDgbRjTnSKEGLq+E306PC29Txs5D3uPySNF6TiXmis51ytUuPpdGtFdAoEFMMTqslfop5ZS1QnYEFxczoxtJYXvn1jfUCVyHxX53R+n7ImBL+Xd+IWF0KApTtlX53Shzo0xv6J0OFZtulaKrWlAZQomuxAKXMVvCBDQoJ4GjCPWxGXaW4gjnPVl0V+mlHzHniVESupi7glgn25tFwSAs2MeXlNiXIo1koPm23aHP4q0ETahEaNULnf/A8g2PBXUz2sq0mUZARxIsHneTUBX8FeJ4rsjXWbRovirnO6elLukm0+07vHDVLh4y+y1lDdRaDvZHni4vCIQYRE3RlyvcG7tuZKSXYEu7EKt+oIAEQHAfZui3RAK0HBjfCtDFB27cVsIYY86fQga2Ka4tQ5RqTjqBga7xBoMaH29p+ZPc8RGJegfuI9NiE/pz/SXk3nrHcS1Gn/45fsvyY2jZ7sL2B6reO+Ka5UONDXZ6n7w2pOBGGAoJ0TL1/QR/a1pH4dWCYEn+8sxpiUAoH20OR/eMjw1/myZB3IqffQ/YsrFymOTb51I7CIiocirHo5+0LAiDKuoB3+wGlU6CTMDixXz/WEmRTYXDyoIktX07nKOZ3CdoSO3Q8URfgzU5HiGhDgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n+BEDVCs/+wXvlr3SRQ1vlSrQPpywd8juvBJizhhsMCoy/IXyqXMjua+7F/o?=
 =?us-ascii?Q?Z1D8a6XVO8OIXRW/eLJvG7Kf3o7wWcFns6uH4JlyQCkLepMaCBbkd0bFZtZy?=
 =?us-ascii?Q?0TbX+WcjUqCGZ05ffdDHazeX4EhwfMa8U6ESKYg+5uXC0HH9GeJr+N7P8v5s?=
 =?us-ascii?Q?2hL7QKPGHJ7ryMgiNKmdsx1bBUsFoFDQ5MXRhibkTNFF/9it8qK51r/G3N10?=
 =?us-ascii?Q?mwcDvXmMKmscjLAeqgdelyZyXP2kSRuL8apc5KbKalC/OZY0eEGRz6QqHCHy?=
 =?us-ascii?Q?/B+zgXjxlEE/+uDAimLUnqAsr9ThI/lLYQFQk0roJQFDSAx0kbXOcp/qjivD?=
 =?us-ascii?Q?BFsUhqU3EmTDyFdba19d6JcCpsVN/3JNhqtT6Y7KdJZbXtW6WJmSyJFLYTr+?=
 =?us-ascii?Q?a5esHO1VwICgYvrEygJ8Yd4S7Rp1C1QiVPtHvG4ddh7KZERlSViJC4sq0OvE?=
 =?us-ascii?Q?OGI/g4HjnbfynlF0Ij5hVq7/FR+oPmcTqhUzfGSiiz3JDnDLKtMVPSSCP83m?=
 =?us-ascii?Q?IDF1wtmHOb2iz7m9bK8gDXpRFHNZGaVeMBBdVxI41YFydT2mPcAs5hE+3zMw?=
 =?us-ascii?Q?FDR5gpMp7yfxcwwHQI0Cpya6DHB4nZ9Jn+z4Ka6iVkFCenzBKJ7wkR3vKUj+?=
 =?us-ascii?Q?PHuicyf+U/lwbqi1pq1nIfmAuDfDlJ9Jn7DHJoVtYvwchR3L4coVGo+mUAfI?=
 =?us-ascii?Q?o8fPKW09fzr/CkoakDUJJ4OZd7IWGAnVOI9q2qEq7ILE+80afHtbvAkaCzkC?=
 =?us-ascii?Q?wECDyKZINS7cFuOCzZkS8Gn42OIK/MS1E2RAeSr/PghwQQNERjZiv9avGwMp?=
 =?us-ascii?Q?GlCBoNNekwyLJ0D2IUvQUeIgsdEvWYop7SBpFz3SzOHgTEkb0s48dxcm8DXW?=
 =?us-ascii?Q?tWmIR9dDjHba7QgZygsTkpSYGWqjj4IMoVkuHrDt683d3ZuQ+87ne7JWNZjF?=
 =?us-ascii?Q?kKgqJ8/BcsPl8/0zi+nku8gKM1RUMpAttZX+q04sUO8nYzXDbbhJJ3zOsvzx?=
 =?us-ascii?Q?EGE88pP0jHF/7EbXPXm0U//0+ZghVeoKvoy+pUpaKLDTYske3+GJ/5RjU64Z?=
 =?us-ascii?Q?UajvwXxCh0pCviwabr1Jpj4aBtJYdHj+vLk3ROaascTlmXepqUnyHZlGB/B8?=
 =?us-ascii?Q?XAtzhqawmqfGodxn256DcO6fOxHCwgDvbE9ewTtsoygwChC2moiaZj8h0KXs?=
 =?us-ascii?Q?ldBMIon5UaOIg8rArRHM1LKzEKEZWBy2lVA9EpVYFqq7zIMVqx61o4wNYwZB?=
 =?us-ascii?Q?saD7ZbXXZ9LmOJI+jd8IwPPWnOY17VygGbkQVfVU3pi/MjxRxcX6mVRPdLk8?=
 =?us-ascii?Q?Nu5VP/OFAcx5GQXaEeHlfK3oJWyd9zdpRY9O35Jlp34w6aW3/ayGsm8qH3Gh?=
 =?us-ascii?Q?ECtndWa8mx9F0MXOY/JSS0zRUjQG/kkLkSzeEvK1w3EkM2wWzlISf7k3a4pf?=
 =?us-ascii?Q?GMB+3Ul0wuR3RY8WOor71qdxZczg0GtsOA98JCMh3mcKSj6is3kUEnFkKiW+?=
 =?us-ascii?Q?HvCQtrOakoRYOL4I/mU8pBe9K5m+ZSMobLyywdJ/j4LsHK372pAbC2CmEtlR?=
 =?us-ascii?Q?vv3CEhMpbI920hXm3knLr0D1bw0EpQUC2naPmKRZvM6nqUYyn2BRPsBT9Fe4?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d580d9-c36f-47ae-c3fd-08dc44919ee8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 01:45:40.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06Cl3Sxs3uTBdqM0DWrFFl7VJ/d2PAePpXIxrFwKDGgl3cmE0Ks9AtJ7z75WjDrv0BR3oz3AvNUhEOyST9T2TpAYShxvNsDVWnAPXaybsNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4579
X-OriginatorOrg: intel.com

Li Ming wrote:
> Protocol errors signaled to a CXL root port may be captured by a Root
> Complex Event Collector(RCEC). If those errors are not cleared and
> reported the system owner loses forensic information for system failure
> analysis.
> 
> Per CXL r3.1 section 9.18.1.5, the recommendation for this case from CXL
> specification is the 'Else' statement in 'IMPLEMENTATION NODE' under
> 'Table 9-24 RDPAS Structure':
> 
> 	"Probe all CXL Downstream Ports and determine whether they have logged an
> 	error in the CXL.io or CXL.cachemem status registers."
> 
> The CXL subsystem already supports RCH RAS Error handling that has a
> dependency on the RCEC. Reuse and extend that RCH topoogy support to
> handle reported errors in the VH topology case. The implementation is
> composed of:
> * Provide a new interface from RCEC side to support walk all devices
>   under RCEC and RCEC associated bus range. PCIe AER core uses this
>   interface to walk all CXL endpoints and all CXL root ports under the
>   bus ranges.
> * Update the PCIe AER core to enable Uncorrectable Internal Errors and
>   Correctable Internal Errors report for root ports.

Thanks for the above background.

> * Invoke the cxl_pci error handler for RCEC reported errors.

So what do you expect happens when a switch is involved? In the RCH case
it knows that the only thing that can fire RCEC is a root complex
integrated endpoint implementation driven by cxl_pci. In the VH case it
could be a switch.

> * Handle root-port errors in the cxl_pci handler when the device is
>   direct attached.

I do expect direct-attach to be a predominant use case, but I want to
make sure that the implementation at least does not make the switch port
error handling case more difficult to implement.

