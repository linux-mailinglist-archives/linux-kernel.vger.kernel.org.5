Return-Path: <linux-kernel+bounces-79807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A1B86270C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE45DB22056
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067E4C634;
	Sat, 24 Feb 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiHAxgFU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9124C60B;
	Sat, 24 Feb 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708803773; cv=fail; b=jQSMadd3asYM+8wtPu0S68L9soe5uy1LlRSKrxc+zdlCCV2GS0z8C70b/r66eebwSK6yJxEFi93yBadYEBmBeW0OiAWGimAxAacUCvoHbFugq4sa8pIPEwFUt2iLXwHZj/SB2oa82WklPXMD+dCwzoYrKJpchb4Hob48PkHkJv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708803773; c=relaxed/simple;
	bh=OMnL3o0zBl+E6Q62oozaJ7lHWaQTaPKm55/TyoFERVU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZWnSEdII7cEh8hcxzoRjDFwRa9PFxFmvEmjvf2yln1UHi8MADGCebS4kljLyqoRY+B2PC2Xs3eNvAuquESls5+DRdKvStP7oyfh6/o5t6cruJVyJoBVHEllqGGgEXNYvOoyBfzB7p0uRXEVxcGIDnMUFeBnP+dPDnL7rv8Fc8mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiHAxgFU; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708803773; x=1740339773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OMnL3o0zBl+E6Q62oozaJ7lHWaQTaPKm55/TyoFERVU=;
  b=MiHAxgFUvl9EF6at7zqJCt/GPWcT/HK1MDhpNSoIZh7k6cujlrWgl4f1
   joY9juchy5GwswxNAB4TieabwCUooInbr4KiPpxAPeMbIpQq1PpxzuPWx
   N9Gs/UAKr3WDmRTJlT+IuNpjAtyCZC664QaRj0YJbTQCXvwMMD81FqTQQ
   29qGcZzXj38+aBnWwJZVqlHTK9YoIdYgcnH3mhymJYLOIl6TS+Mn7T+pa
   qufSNKojoaAkjes6sOHpWSDWg6kTbc2yfi7YOXAuF/AdsWN+CBCvnF/ew
   PnuhxIgXQCvww4xwYK+82FCt5etcLHEVMniFCxr/Q8F01768wg6F7HXWf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="3246293"
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="3246293"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 11:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="6245250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2024 11:42:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 11:42:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 11:42:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 24 Feb 2024 11:42:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 24 Feb 2024 11:42:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq4tgTzJ4uNdt0bfAIC5ZBjUDA2AqOsslgjeuGwQYCq+BpL9PEsV3a70VRrl45WeOiif8hLDc4szfhul05eBU5fUn42uJFyJhvVLg8daaEjtairC7zWnPo7AtyRE/8jjazSTTcgpbsNOKGooniff504G8BxGJgWNDg56SJSbcaRCWng7jW3zO+28XjdynLRZPAVoIEEugug8Qj3Hi6jke5OFqP6hEoL5kOX6GTHqAtqE0iFMjW9yVBwra163wyh41THbnKANr0E2c1hrjVHJB1gpXxLQkCVwmTjLoh44cMNbxSPiOoRun+T8//olG8CYe9GQ3RybHksjun1Y2Vhapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PIf6PzkS68BxYnXU05vCfo0YFUdUjMI8UbQznUwC78=;
 b=fz8go5MOEmoswD7fWxoTfMoRaJxQ94m57kVHO6epd8hIbODt+CwPKGQb8znltq1NjAhyeIbVAwNJdUBZfl9i5xu1Hs0us3s/Zj93kMzkfZgXzEN7JQhjkQFI3gY3uIqMd3O2FMufbGXj4NEm0NaN/YfpCMal93EU42bEcIPHxb00BvhW7fGpnMlAs10iMBs7HKxPvtQVPmf725Fz11K4+CtrQEFODkQSikI4fOnuWsSWxYipPaa8RSim3m9i2zL6dhBX1nUVCb7G5LTqI/KuHklgbmJav8DK8puof8Epf5Q38VATlIUcPqn/4kQ3sYUAhreCGMSTnHGcTOEHdhk8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Sat, 24 Feb
 2024 19:42:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Sat, 24 Feb 2024
 19:42:17 +0000
Date: Sat, 24 Feb 2024 11:42:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
	Ira Weiny <ira.weiny@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>, <rafael@kernel.org>,
	<wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
	<mawupeng1@huawei.com>, <linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <65da46955fe12_2bce92941a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-2-xueshuai@linux.alibaba.com>
 <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
 <bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
 <65d82c9352e78_24f3f294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240223120813.00005d1f@Huawei.com>
 <20240223121701.00004bcf@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240223121701.00004bcf@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9b3920-538f-43fd-d2ad-08dc3570b556
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNhIJS+bMB+huBBPCBe2Ria+18IPK47R5cwfWLIeFk3TueSYDX7GtQdOPX0aiWDmowp4NkL1StGZQnN0XZz91s7D9DhlAWpWVomX/V+gIj7HW3LuMuj5IKOlmP3DSYf3dTIVbYHTSpkKJ4J7zSjrgRbRtKmvM+x0f3/ZIzb1+NqyKtXDyPzVKwFJz7PkPdYSJOOw3Bi3+Qss4ygfCqo4nBzlDvuERSncrfhba+b+sI/VYAMYnEKilPsyb/+vth9Gc5pBTPcuPVqm0Tv2Dx+sZ0QGVTO+0AQbsx1yGHV3aFF6YhlqFdp4fmuIb5t4HDUgxM+zCBZ1xxgY810OMupBaoU/AOCSojmTm5W7EDc/aVgwekAaCTsCYBXzkUCJ38poIbsem8IIF7N+BDTQtwcVEs/okAdv2f6ZgaXTwD7knj7zBw1MjoKuqqg7kQv37zarphRqvM6u64rCcUkqYi55L2dV2T6MYKDBSxTuvfdT31zv+XmfWJc7yRq+sFB6JBOChI8gk9R8Gaf5GAhZ+f2w9D6vKJFHKviH5m6Fr4dFpG7M7+UeUduY8OI120VwXrfo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NaBRvSLQWDGPkO96OT89phffddEKJY5ja3b+a8JMLsTSEx4L0swII6fLschM?=
 =?us-ascii?Q?Khb9Qdo5VTU5nfSjQ0No6uEeHKxcLiFXEGTXqVI4p1cv4qBngSIwh41I3nO0?=
 =?us-ascii?Q?wACGTthVsolVaNmaxBoOL1QYOtWOqZ5QHEKmooShTZpYlxylym/5jGuFMnN9?=
 =?us-ascii?Q?hwNZz6cxJVRo+ZEmkx3qhC3954JqxhzTw17a0fECDNdVOWvzE46XSDX1ww09?=
 =?us-ascii?Q?r2Em7icxPPpc1OURio4K17LJYzt5Zu+IL0eNdkqT/1Lc+3RLIZeX2XS2t2LE?=
 =?us-ascii?Q?o5Vdr/hkJPljgCMGPoUc4hJL2pPT1PPJ97tHnfhsS6mYyh9BHYMpEJtcTGxz?=
 =?us-ascii?Q?Cj0RCtNuL45LWRNl2pD29aXUwMMklyTC1Zx8eaazKj6gipcyjKotDdv1c2gK?=
 =?us-ascii?Q?VGT3W/0hp/5CGGPlPLAEL5YuAfcd2K14wmmMwaCv3vKPyVWa7t0YbBQeTvHY?=
 =?us-ascii?Q?uSMWZsvJi7CEoIqromUNG9mIriCcMHBtlipd1Uxkps6JN2VOqedTVL5iZSDo?=
 =?us-ascii?Q?JVmLvoPlLKxIWSj5RXthCgpaJsP2TvTAFe5L/+xXWl41AH6eEc4RXdYlk/fu?=
 =?us-ascii?Q?/n1uq10ruaqUY1tYiGomkq0SdVYKzmoPXSV07HR+ZdXL+fXCHJnl3KGeXP5t?=
 =?us-ascii?Q?wPBtN+I7Kxq+eKqT3N0MqRvTb5XA0od/eGwYoiOLn10aWGKS0epZ8ECdyZXg?=
 =?us-ascii?Q?CBHuPMzhuZFNChwTkKkgjMtK2NHGd2alWWKeekxM/iRzi6B7g6zy3rK5tPcj?=
 =?us-ascii?Q?P6PhlJGBOLFT8/cgj/prrOV7/okH83MoNkaqkeaCO4onnYtvBRDgHz/x7jAa?=
 =?us-ascii?Q?k/LgGKUJxKwGWNbFVqaAU/tzxilUdx2AMqL+q5Afci/AE2O4IEGt8swy8LMZ?=
 =?us-ascii?Q?3E+n1UXJi5WcpCG355xOO849eVAKRTw8elJ+HPWSz8PEPT3kHCtkt3xP0d1K?=
 =?us-ascii?Q?JeYlU9wfr3CsHTW7NVm5sO9PqH4L3P9yp13eFSxDJg+cgCJzEB5HDKpnRnPx?=
 =?us-ascii?Q?UOQlH1eHKhHr8WnEsYjRlL3M+EXRtFz1/k81cDdSjiY9WbI+ncGzRaEhuPu9?=
 =?us-ascii?Q?T3DoTnXvdXBCbahV3xXjWMOCKp98jhJ4ySMZFLCWm47loL12DxENusjS3vVi?=
 =?us-ascii?Q?Ok4LF5pZ1nNi6rDl1TTcz4FXKgzpMq3gT+Lp+f11Z/Zm+yNXtmtgjFenu5kH?=
 =?us-ascii?Q?PZySRbKFqnXOZrygKjDiAetY9LKrSbbFSXQgpAL5LaMjsfXx+RTFFp8AodcJ?=
 =?us-ascii?Q?bki9KgF+KyKAYmZQQR/90tXMBofVFgXAVgSQI54u+dBjphZ3B+T/zhTZ0mHo?=
 =?us-ascii?Q?0M/c2wqsxxA4W+8raNCg4jKkfFdjjjJjjlkhAHA38zy/cQlOh1Q+QlylY2P5?=
 =?us-ascii?Q?QmWdbc9e2YXqwc6HwhNy8D4z5+0mRYDwEiO5VBO5CcFeqjdWG1vLd6iMzSEs?=
 =?us-ascii?Q?ObJjhW8fcuhMkYU+ExSXj/85v50dRSZSP0GCJh9Y/69BjtW0UhiI4bhswsU2?=
 =?us-ascii?Q?SGS2ag02EeupRO3jM0tcS84vsvlZGknZX0yA6pMYcTqZ8UDmPP0a0elFUJHj?=
 =?us-ascii?Q?VEFbbijND2e4L8lypodkQ/Ne5mODwR7rstyKvK/+yMuPLKi5/zP0RdCjHBqb?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9b3920-538f-43fd-d2ad-08dc3570b556
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 19:42:17.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U233sL6a2JMzQedKxQ/WTjXhSYkhdw4XyL9PyCb2FdbmX0y1AfPNJcLqw0PPKlxbNUaJPv9sseJ+S2tUCDZ3hBv9TvQ/UlUFrNXLEZXkroY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > > None of the CXL component errors should be handled as synchronous
> > > events. They are either asynchronous protocol errors, or effectively
> > > equivalent to CPER_SEC_PLATFORM_MEM notifications.  
> > 
> > Not a good example, CPER_SEC_PLATFORM_MEM is sometimes signaled via SEA.
> > 
> 
> Premature send.:(
> 
> One example I can point at is how we do signaling of memory
> errors detected by the host into a VM on arm64.
> https://elixir.bootlin.com/qemu/latest/source/hw/acpi/ghes.c#L391
> CPER_SEC_PLATFORM_MEM via ARM Synchronous External Abort (SEA).
> 
> Right now we've only used async in QEMU for proposed CXL error
> CPER records signalling but your reference to them being similar
> to CPER_SEC_PLATFORM_MEM is valid so 'maybe' they will be
> synchronous in some physical systems as it's one viable way to
> provide rich information for synchronous reception of poison.
> For the VM case my assumption today is we don't care about providing the
> VM with rich data, so CPER_SEC_PLATFORM_MEM is fine as a path for
> errors whether from CXL CPER records or not.

Makes sense... and I was not precise when I mentioned the equivalency, I
was only considering x86.

