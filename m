Return-Path: <linux-kernel+bounces-92891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDCA8727A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402611C2537A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDAB5C614;
	Tue,  5 Mar 2024 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lW6Z5HXO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA125C5FB;
	Tue,  5 Mar 2024 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667458; cv=fail; b=hhBFeT1YzkRsIRITg2E3DQ6JZ6ZyEt8yvhN4ih8OgzAEnKVh1KOo0mfUsyW2TiP9b0cR5/YwsyhCJz3w2RHQF/lwJNbGa7a8l8nC6KN/9sCoHcgTgiw3IfVN2hqwUReniRXaoyhWuG5zbh6vwWLfqMzo6kVDo98FZjiIXF/7aJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667458; c=relaxed/simple;
	bh=30SVq7WIBsTtgXg34VNYM2Br56958xir9WZfreN2JOc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZJsE2QotdH4KovmZ1k0dSXIU0+semGJ4y4ZZm2R3jJjBOdQU+z/1ogJOqfBDaNc+OBda5T/4g3pmlIs93RQlhw/vwuNiLFvd1TrekumxdTJKsJFPEMsvETwDQIejyI2N2JotYue++FykIlskpBIGuK/2ItKhooEqXWOA6tvMD5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lW6Z5HXO; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709667456; x=1741203456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=30SVq7WIBsTtgXg34VNYM2Br56958xir9WZfreN2JOc=;
  b=lW6Z5HXOMgZWPlmQciXWLmATwSqbL9HErhugN/O4uCdpXsbg1UGKFBVK
   t/PRMDbJq901i6y9kDX2hyVXngREwzDzVMW4MK6y0rAx9O1tYjdHzN6O3
   4u0DUARywkVKGf1zwLouV1ZQWwGFmaBDTfVKixX+bulqP+J8/CkCM7XPe
   /T/wq1BG6xswZ2EdiDNOXFRNSoFhIygtcQ97y8e+sYpmFNYjboDbkTZ7F
   KpKDBFYTxVCoKI9nUaatlN1DyhVQHCJMhZW+So1WKaWS/7IV80QWgd9oe
   Fw1EDdlMGepKtzWqbHIVa1D1douuDDVTFmv+fWOGPba0jS+XIA2cvyqEP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15388288"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="15388288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="13973048"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 11:37:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 11:37:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 11:37:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 11:37:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 11:37:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbSNAYuy5HCBCk/DrobIe+nJ98EB8EZr+A80Fd2Ephhps+lWCz3rM2TVh/+fM0YT3n6AFDrNAvBvwv8qTEh3Yz7Q1WhDtLTQC0Z17TeCFJzHFDtLgAImUy9+LN+sOLMKeqOvpIFjXinN4m5z63zR5uckVx5KZrRv50Mv6x50j6q8PyMFvS2xO9dRxwtrvl/ekuFH1Ts+NYVsB+tsNAq9W+gugUisfHXE2NKLNXD1wI89KmW5MlFcdBwL6bIqSkmS0/uHf6VH97Hi8O2I+BlLhltohaj7lQ6eaS0Wv8hzv07DPChq5EYB4oT+mbu5OzEVMj0/wSN6lT05dNzcTywB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uUMHMslvBv5xOshFQQIZmmTmxlx0vCxwzXomR8COX8=;
 b=XgyEH1bxBBX5s0HcoxhjtumftisQ1Gk9eFGYW/S1malxpwTHXr35yAw2SgU3mXeHNH3n9kDQryUseG0bH/+s1fFvvrMBK/14RdiqcOQoaCpqYktIgCDvIXr8mGBh21B2V0hzF7HrETqIeLiQH7MKWyFTr8VXVG1qgw7SCj/o/yd6RGF0cRA7ZeCzro81DqOpIArqrvRKlHYs9fLwiGMrQMXePk/6yTdil8b0HysNEEYxIUpHneFXlFznu7i8JskV8/cvvRxG0kozC5BL6Cs0VCNBv6dkLRKGZUFrWSjV1W+tBrKkTLooUfzoCx+XTKjfVujqohdstXP+HQgKZkLc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 19:37:16 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::e8d4:c3a:a247:175e]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::e8d4:c3a:a247:175e%6]) with mapi id 15.20.7362.010; Tue, 5 Mar 2024
 19:37:16 +0000
Date: Sat, 2 Mar 2024 01:50:03 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mateusz Pacuszka
	<mateuszx.pacuszka@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>, Jakub Buchocki
	<jakubx.buchocki@intel.com>, Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Pawel
 Chmielewski" <pawel.chmielewski@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Message-ID: <ZeJ3u2x3Ihs8WQJn@lzaremba-mobl.ger.corp.intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
 <20240228084745.2c0fef0e@kernel.org>
 <ZeBMRXUjVSwUHxU-@nanopsycho>
 <20240229072813.5d7614c3@kernel.org>
 <ZeDb8Dr8mBvov9fc@lzaremba-mobl.ger.corp.intel.com>
 <20240301090836.185e3b79@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240301090836.185e3b79@kernel.org>
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb9cf2f-6e5e-4504-d8c9-08dc3d4ba9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36kpgCXCAxn5t5AVSPur/nkZnCC36njfthPmyV/bXRUwoBIx/DeTBJBJ4CvXFR1J6wF3jOOVlWJ6bw+bznlSScz1LHLaw6UJtIYtlveF4E3PH3WielslyIZTfg6TjQ9mwTl+3G9c2wrnRgCNyJIWDmW9obauxJmuko/7qpEMQTbeEUHBbj6to3Quiz1LPNfKQ03d0Hf42sUxYCXf4s8bvBX4BILevmVCIW3Lrvr47OTPOdi6zyGJUHU1UMtIY1qhwHpXWeuSlppzC49DASvHycc5AljAph1/3zdryL/VMMRJMmw8R2cYeM0RW3OzqiZ+IHOLcCGdyWbqESpT9QBeohreMoIcl7rR7qhkYuj/sk0zS0bzd0IKEdrSam73enQ8Tdw1t/jlvsZQ5+x5IoNm4HfKPMiOpop9SUbUKxEdHq7ppIu6WsIkjnitms55GYQn+6OGC5/ACqCKqi4HBFUrZMP1dHbURzHTlgsQu78LYWLKDNbDbZ1PmJAH5U//XxIqDbE+nz6flQ4PbbY3sgQZAMXvQgTUbQSJfdpk6XhHrf0kX9OCTvJNWGr2tNPgeIU11iGjZ1cBPd5dkPAyWnQJrmJo2t8kckvLGJBi+pf8ZcibqUYwiEUNV5UEOSwNTyq+Vzu5QXOMoHQKusDwbZKR6JiUTrDGj/A5rh81q42fXig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ezg3FM10sT8C5WiAPriQ9CSey9FnIleanwePXJgFJ1a+0nvj9627T4CeVsd9?=
 =?us-ascii?Q?5INxDcWTnEwFyroREwjYvDkbT9C0gqfC2fomIq/HCGxFNuSvLgSiT4S+IHsH?=
 =?us-ascii?Q?phx97UK8af6Cn9IMWXmjxRxrhw1wnEU1Sr8HVvueyfsVsjSJMWBc6ZN1/dvX?=
 =?us-ascii?Q?dBZ9dlNCTx+Eh5U2DWdM29SuOUazwk9gl7twvfXstRhO5Ex1z0XharBHA/VA?=
 =?us-ascii?Q?44C+Q+ZLXj1XwyEqhnhYIig2hyWTF3KKv7nsuAgFGN9aEfcIGa3WXhuETHrw?=
 =?us-ascii?Q?jDrqFD+qOlkEWjNnOPWnp0NjA03bQlFPTRUFai0cebmR3iM+BCAF3pkidEnM?=
 =?us-ascii?Q?bzYnM8K7v6RIoaiOeA16JOLodXTdcigAIpbPQr/xoccRGYvcCw1p/gum9rv2?=
 =?us-ascii?Q?RB8wrJ8OqsD3LtPrHPzloRp85U+qK2FcO2ncY//Cu9mFqm/LFsGct/Mj7UJO?=
 =?us-ascii?Q?aylXQJTLAKVcTvt74kZ49XOttu4M+iXVRz0vZBDS2yRixVXHrcOeMC6Ov4g0?=
 =?us-ascii?Q?as0wN+hYkEaP87YbZU/qTGkwpOv9nSJD49YulbLKDSMR0B9hupL/dYuuxIgO?=
 =?us-ascii?Q?OEfzk5tS/S15YafRy9ZD2T6sVaP8bCP0omHptXLXRhdJPrRhjI/y784PC31x?=
 =?us-ascii?Q?dvsvN5E+AIeB3JV8M1Kh0tcaHZLibeJWTlqbqa7ErMmuVLs2M9Dt8S/LJbLb?=
 =?us-ascii?Q?7rZJ+BoleJJySyjYXfhtlecPU7kbUaPwOfpBI/Hn3VhrimCtZTjntX77Kj5u?=
 =?us-ascii?Q?C4n0Og8rculv/Pa0A00Y1WPDaGKfSDK2uQ2BcSllNCqjUd98jJaDjWI4O+tS?=
 =?us-ascii?Q?HpJlx7+JWqlwaBb915NLCG6BjE8I6zSd3sPEAuMqxtM0XZUO4D0vArF8sPBq?=
 =?us-ascii?Q?06yco8VOY2ejcMIfkO5zoxThhae+TVqozsQkqPoKHo+loPqqdEJ0qWemosV6?=
 =?us-ascii?Q?M8m8gVeqeAp43MRhEwYmQGVBJb8jL6mFywawSaJFPXhSfqGt7EX2MeB7gWgT?=
 =?us-ascii?Q?0Wnym6xcMhTOAWtwT7SsqaSoVKsal47uWsUU2z2kE9I3h2BEsA8QyemqRsE+?=
 =?us-ascii?Q?Ql8705DIhYUhWqGWgZPEegKoZv/d+az39UVL5Lh/2IZI+m0ynZjCJcw8Noou?=
 =?us-ascii?Q?9e78UfENVWPJ+LJTiKGhskrRPGNilQuCyADtHUnJqaNs2RHPg3Z6u0jb7u6v?=
 =?us-ascii?Q?x6IyPRBI2VsaLbuMWhoWDSwXRQUCkH3HCmEQCBB0XkDYRg6WWNBriyyQh6GX?=
 =?us-ascii?Q?6btkHBnHnKvLGrN/8RviLLYRSVGacAWGnk3I/BLVl+psAXFJrRhL8X+Waww0?=
 =?us-ascii?Q?uaN7bkV241ESvTkvEbxjWwq6kbzql3w9X89cwF6VTYzRbM2OR7hQe5wZJAx3?=
 =?us-ascii?Q?SHTRPan9FkII6NN39crnZO42u6XTP9fM9yUCPMzj+V6jsT1QENZT7rA5nKiZ?=
 =?us-ascii?Q?YiY2l3bzTV4EOI1qMrU+Bnt1A2e0ELwiUEuQhyc+mrkEtHVwGSKipdQIK+hq?=
 =?us-ascii?Q?CkJK1oZb2rlzLZCkfpYi9EaHW4dHef4R8YsM0qt6OlSwvheX4OlVsxl8Ucxl?=
 =?us-ascii?Q?2Vc+G4h049rAT1zMSQuNAFrIiLjagUyMkJ0wG31ufr45GwELwwZxpIbAznPr?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb9cf2f-6e5e-4504-d8c9-08dc3d4ba9cc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 19:37:16.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVllFw/6+I2vSpwCYntQqvzaWT+ixKjtG1uFYh3HVpG5qs8Bz+iQxE+kuzlchETSxc2hWOF0e4mgzSDoWcTkbHNqLrFtRrmRgt6+FuDPLzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007
X-OriginatorOrg: intel.com

On Fri, Mar 01, 2024 at 09:08:36AM -0800, Jakub Kicinski wrote:
> On Thu, 29 Feb 2024 20:33:04 +0100 Larysa Zaremba wrote:
> > > This is an LLDP agent which runs as part of the NIC FW, AFAIU, not about
> > > forwarding or filtering.
> > > 
> > > They already have the priv flag, so best to reuse that. If not possible
> > > we can explore options, but as Larysa mentioned herself in the cover
> > > letter sysfs is probably low on the preference list :(
> > 
> > FW agent is disabled NIC-wide, so only PF should be able to set such flag.
> 
> Sorry, then I misread. If it's about which VF gets the LLDP traffic
> from the _wire_, then I'm with Jiri. It's a basic forwarding problem,
> isn't it? Match on EtherType and forward?
>

For RX: match on Ethertype and mirror, every trusted VF should be able to scan 
neighbors.

For TX this is more complicated and is done not through eswitch, but through 
modifying security options, so do not think this would work with tc. So private 
flags are the best option? Our requirements say only a single VSI can transmit 
LLDP.

> > The lazy part of me likes the private flag direction, because just
> > replacing sysfs entries with corresponding private flags would make
> > patch look better while not changing the implementation much.
> > 
> > I guess, treating it like a normal eswitch configuration would be
> > ideal, but it would not be purely generic, as there is an added level
> > of complexity because of FW Agent interactions.
> 

