Return-Path: <linux-kernel+bounces-79045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3B861CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552231F256C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23081448F9;
	Fri, 23 Feb 2024 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nie3Hzy1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6574143C70;
	Fri, 23 Feb 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717355; cv=fail; b=gdP9GwEoi0i/GPOmuC5bLMp3lzrCpSyx5ZedwcZ2O/sq46J+t0lcpe/iZOiwKAc7z77b8btSvztEBHyT6GAc80QYyzXovJxdKXZlSnrVzDLlnFEIi2ZyLZLAOrPJE/9nLb9nuC0+S4dLf8Y3k89Pe3zbYp4PpDyXjGT0iyMjrk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717355; c=relaxed/simple;
	bh=QRulwIAvmUPONm6wm64CF8mqXDDtEfuEFY96ixXc44M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dvdAwX0fcjSUxgETV9ElGOKQ0YO4XIFp6XSkmhwkVbabf6GrRg74g/tZBtkwNGznx/5WFemKuvJ/VH1nGLjdbl1q2rcwa4WtIe7GWXB84g6hMS2+108v3y1lLE8z+uR3fgSSHVKr7jOQLv3joKYfJoQJ3E04wZE4lBpZX5UE2QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nie3Hzy1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717354; x=1740253354;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QRulwIAvmUPONm6wm64CF8mqXDDtEfuEFY96ixXc44M=;
  b=nie3Hzy15lbErA+Dli/hQ1jzJ92BoniRptvXUl9LMpC9V4cmSUDbbu83
   CjtFsxzrNSU296DXSG5Cr6PK9l0XHO0GjoZ4q0Y95tgtG6zL0FnEF3iMU
   ZrlO9KW+w/4rw5a6a/5rL2tPGH8XNdXz6yDIoE8zcDth+nnpVVVcyPprg
   u+aM4e9SpRYIp4SRHFH1vAqlHUyprnE8YinSNfn12oKmb4s4Pa5BOudX9
   jMXBEF+z2h35DBlIM2OzDXzfiYa/rCGGi7iVF251LdFfvyi5Hg4lWeu4+
   qCi0gMH4Azy6++nj1iGtXB7aJSUTkAi9gJC7Nc6uifC4S8Tj86x2Zk8aR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2937881"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2937881"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10566334"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 11:42:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 11:42:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 11:42:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 11:42:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 11:42:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsm8wPZzpoJgI/vUz71RNBy3RsbGIS6cw9aI6tfSwROTcde76I3N3B4MG0mmw6X+VPk/Zl236/XC369NSEq0xYpsN2auFRVFNfhxosNkCv6QK++mxZNa5JTJAF5pzdZPJn+VguByw5MwK4SnbzXo0eEwiWkcJUn+pGxraKbQGzMrpkW0hPqygWkSIz6p39RfRv0KQoY56UE9VmOYZZOLjPrZrxzei0UaEojuecehm1DRhyNT6UBM48s3Mu8lRuyf0DL/tkA0WmYR55GswpNKhsEJti1Q/Mgx+8pSzlqZVMxbY/LuJi8KnpD7EQP8onYdh8WClWzBPdXqow4sPX3X9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7viTrzeOB4ZN45te2oQYTibFACLRecqBOGP1VYsbM4=;
 b=G0yC6b2fquE0xdXO9yEnUDw9CtTunXTb1Kmg7CqfpQ1F09p2tiuixoCXZRa84m9PssBnagw4zwEOjdXhL/jXKVl5iNr4UyGGRgVKenjgtsaLHAdgNbP8BJfHFCfnlUYbJHindlaGAC+z+dodgVfdjp4g4/kZCkbl/tahfsw1yMynxuM6nr3m3ZY+7cQLpmqulmqPgLXDAAPLNHs+k7wONev1wL4cr+E8lC+dqeNc2PwXo2VLDGqalVaSwdhREle7lvLd7bcD2z9XX66Q75JstvLTLbwFF3yYF7sPPKwvMYuWihuEOCmvMLFEieTc036b9+6aZwpf5tBDPla+phQl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 19:42:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 19:42:28 +0000
Date: Fri, 23 Feb 2024 11:42:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiju Jose <shiju.jose@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Message-ID: <65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
 <65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
 <54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
X-ClientProxiedBy: MW4PR04CA0339.namprd04.prod.outlook.com
 (2603:10b6:303:8a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ab1acd-820a-4988-cd7b-08dc34a79159
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2BR8x2OdDFoCOOgDpGU+Z36F/U1V9AlEXy4YW6kQCwplCjtGK2MW/YwLS8KWNIXAhUaQtAIbHpzZgtmqyxX4Bz3jF0JiiciaJoX9k2kgB0jHO2W5xFWnzwv0wW//AMZnoK2mIY0CC75iWwysl+oABLMPsOwHcqguqSMyGuP7+k4dz4QUIpFkO3wdMiF+ujnrLw8N/XgKdrZw3tmYPNfI1JNfMCFKN6GpYNodk3McVIaQUY5yQsmmVjF7suxn+PyjZ8iM3MBRsmdLXUO06On8XzM1MTLXkBNP+Y9NWI2ARec5hbuQ98bHd+Lgigbh0oIe3otNNM/xDZjLLqfqrUEuJ5CormtVKVhvF6MEc2j/Al7O1/1XkYZweqSNq/3IegF4wqQ+DEEx819rz3+HYvcszHg6X6lb7IYsKpk8sjlx88N2ydQVqllM7WmCnr1UrS+iEqGlG7WwwL0xSLn4R37LZ/j3vr8HBXYvSDxrE06EYjNUyITyZQXjIlPbg9bkcwUPj5uQzfpEj1GVMgnw+dW9scYpVeCbI0JwgKSTdUT09cSJU/SN2T/xEVzwLdgbuQoXLi06WGPA0YB+Wi3Yblw9AYcdGjsCC+Grhqj4UtlaQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMMnd1X5IOSHEIzYOnMorHOes3Gn7gWlQult6L+gMGdBGXjZvdaCaavC6U6E?=
 =?us-ascii?Q?xiPyQk7b/hdfDuacfOc7RCrS7oMXyqSqdG+s6Bm++mhoClprNigMNgg51LqV?=
 =?us-ascii?Q?Qc3oGbegf104AQrenAI0hwaXXNNwFIwxHqmv9JHayHXs7X9ZB8u/PWlwovQW?=
 =?us-ascii?Q?IAn9fQJDrr5tBrzv14e3Mcwd84OZlZKbxCPiE2hoP5KRbBfJu2VMtaaIQXl1?=
 =?us-ascii?Q?dS6OFR5u+Kjt1ieKGx5XJdFq+KMeVPqttGoL8TzXfDPbsErI9xjG62AUthQb?=
 =?us-ascii?Q?/Mm0pVSekfnqMwte7lfLkt3gP70Y9A6TbJlCCD3tRrrlhfddltUQROOqG4HJ?=
 =?us-ascii?Q?4yWZyQwheKZ4+4bi2ZLpJaBC4TNCToeBzjJrqnl/+1hYbfqj3nv7+DVKST8i?=
 =?us-ascii?Q?PoFLYHG0ajkUfPbJjkEWtXPIP9GctE3SUFhPkEiA2StVU2DYQgK4eqG+SaWh?=
 =?us-ascii?Q?Kg38SjNpK6bXP1eQ2/qGX/hgK0nnlxCEOuyxQBKSmy9s/t3Vj2wcqedXwhuM?=
 =?us-ascii?Q?Uif1J4VA3HYbb0xEadioY8262BnULCdQHvqwQthtBHk7WGrmbWsrddyo/hw3?=
 =?us-ascii?Q?A5mKSGlOUjDmaH6W2Qs53beoZjlTpLBjGGXtoJEE6saDb/KxiTrXe/YCBpvN?=
 =?us-ascii?Q?XvZPheVZcdqYX7OFaib3J61iCwDtmOq0mfuGdQb6oE3XaMzuREuNQGm13TXs?=
 =?us-ascii?Q?oq8t4Qwbk1EoiCI/pltnC16pNkfGYpYR+6fsqMzoSdbBFGLvqrqgqE9SE/9y?=
 =?us-ascii?Q?S9Ehx/AqV+z5JPrlg/xDDu9jrGga82A+Dp38IAwYYyhtyjzC3xhGtpskefK5?=
 =?us-ascii?Q?l58TcgkNX39gZDlmgKwgklA9xB5DvMPX3SwulQVgmxgNhzl8m0vNOAGyLoeG?=
 =?us-ascii?Q?4/BcBK/sjdBq+ZXIFlKsYJdFOys4wHkash5jwN1l/EEDygpS+o5v1WN/7y/s?=
 =?us-ascii?Q?usDyWHnZ5+wfd8rnZOrYuieoPegTuS14B5BIwYT+1jL9gxdf+zRT7fsdYzKp?=
 =?us-ascii?Q?hEqahgKsoI+aySknIm/sju7sjIm5cxjQPL/mPWJATpSkO/NzCg2zh8IcjTKj?=
 =?us-ascii?Q?FcAIEu2SSsyGfxhGFqakH0492kdcer+bG9O0/p9F1SdIN8TrKhGJN6n6BCjk?=
 =?us-ascii?Q?2Gr1RSdf82imu0Kehoi1ZKgrkww2zZ0rLTr2dNddrQJHCqtSt4rgh83wF/QF?=
 =?us-ascii?Q?GlgvTwy+cV5hKltFYJMYLKMKAEF3wu4cA4XIH3MmdOT9CIehnNBgzm0CTVdZ?=
 =?us-ascii?Q?DCfOJbIBhLnnOyRVyxo4+Adq+vDPiv7SdueOvjVjczrHLpoCcRlxrG7NUXiA?=
 =?us-ascii?Q?de1ko2UW33eT7XugGTmLSOd09F4PrKFse7WdiHHBmt0P38uolu0BNChRP53L?=
 =?us-ascii?Q?+zVnkG6PW4DbWCKgy4zOW/e+tQ+aaXS8H3elt6jSdDzzb4Iof1z6mDLOaUOw?=
 =?us-ascii?Q?+RRduqoboamwhMolUv5EmDSqg5g04xS4w2EfeNlf5bcGxV4KAEPYs0S6LJ7F?=
 =?us-ascii?Q?Svpoe8LL0twhR4VvciordvcSQuadtaVeqQNv4Z71UfNbC1amJYoBhf176G8K?=
 =?us-ascii?Q?ZY8+CmtGogXuhHwunXFTknoQuyWcDdAhSmDNSLG2GOxfLP/qv1c0biZIUDx5?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ab1acd-820a-4988-cd7b-08dc34a79159
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:42:28.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWmXLWbf6CtazMZTZqg+Jvyt7EJDZfQUq0aBtRUubmKlnJzB1gPX6bIpZTd3mX4UfbmMtMILPnPSMChhAd1R8Ll6RMlFjT072N3mfK0EMNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
X-OriginatorOrg: intel.com

Shiju Jose wrote:
> Hi Dan,
> 
> Thanks for the feedback.
> 
> Please find reply inline.
> 
> >-----Original Message-----
> >From: Dan Williams <dan.j.williams@intel.com>
> >Sent: 22 February 2024 00:21
> >To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; linux-
> >acpi@vger.kernel.org; linux-mm@kvack.org; dan.j.williams@intel.com;
> >dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
> >dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com;
> >ira.weiny@intel.com
> >Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> >david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
> >Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
> >tony.luck@intel.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> >rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
> >james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
> >erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
> >mike.malvestuto@intel.com; gthelen@google.com;
> >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> >tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> >kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
> >Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
> >Subject: RE: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
> >CXL device patrol scrub control and DDR5 ECS control features
> >
> >shiju.jose@ wrote:
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> 1. Add support for CXL feature mailbox commands.
> >> 2. Add CXL device scrub driver supporting patrol scrub control and ECS
> >> control features.
> >> 3. Add scrub subsystem driver supports configuring memory scrubs in the
> >system.
> >> 4. Register CXL device patrol scrub and ECS with scrub subsystem.
> >> 5. Add common library for RASF and RAS2 PCC interfaces.
> >> 6. Add driver for ACPI RAS2 feature table (RAS2).
> >> 7. Add memory RAS2 driver and register with scrub subsystem.
> >
> >I stepped away from this patch set to focus on the changes that landed for v6.8
> >and the follow-on regression fixups. Now that v6.8 CXL work has quieted down
> >and I circle back to this set for v6.9 I find the lack of story in this cover letter to
> >be unsettling. As a reviewer I should not have to put together the story on why
> >Linux should care about this feature and independently build up the
> >maintainence-burden vs benefit tradeoff analysis.
> I will add more details to the cover letter.
>  
> >
> >Maybe it is self evident to others, but for me there is little in these changelogs
> >besides "mechanism exists, enable it". There are plenty of platform or device
> >mechanisms that get specified that Linux does not enable for one reason or
> >another.
> >
> >The cover letter needs to answer why it matters, and what are the tradeoffs.
> >Mind you, in my submissions I do not always get this right in the cover letter [1],
> >but hopefully at least one of the patches tells the story [2].
> >
> >In other words, imagine you are writing the pull request to Linus or someone
> >else with limited time who needs to make a risk decision on a pull request with a
> >diffstat of:
> >
> >    23 files changed, 3083 insertions(+)
> >
> >...where the easiest decision is to just decline. As is, these changelogs are not
> >close to tipping the scale to "accept".
> >
> >[sidebar: how did this manage to implement a new subsystem with 2 consumers
> >(CXL + ACPI), without modifying a single existing line? Zero deletions? That is
> >either an indication that Linux perfectly anticipated this future use case
> >(unlikely), or more work needs to be done to digest an integrate these concepts
> >into existing code paths]
> >
> >One of the first questions for me is why CXL and RAS2 as the first consumers and
> >not NVDIMM-ARS and/or RASF Patrol Scrub? Part of the maintenance burden
> We don't personally care about NVDIMMS but would welcome drivers from others.

Upstream would also welcome consideration of maintenance burden
reduction before piling on, at least include *some* consideration of the
implications vs this response that comes off as "that's somebody else's
problem".

> Regarding RASF patrol scrub no one cared about it as it's useless and
> any new implementation should be RAS2.

The assertion that "RASF patrol scrub no one cared about it as it's
useless and any new implementation should be RAS2" needs evidence.

For example, what platforms are going to ship with RAS2 support, what
are the implications of Linux not having RAS2 scrub support in a month,
or in year? There are parts of the ACPI spec that have never been
implemented what is the evidence that RAS2 is not going to suffer the
same fate as RASF? There are parts of the CXL specification that have
never been implemented in mass market products.

> Previous discussions in the community about RASF and scrub could be find here.
> https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r
> and some old ones,
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB0038718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/
> 

Do not make people hunt for old discussions, if there are useful points
in that discussion that make the case for the patch set include those in
the next submission, don't make people hunt for the latest state of the
story.

> https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/

Yes, now that is a useful changelog, thank you for highlighting it,
please follow its example.

