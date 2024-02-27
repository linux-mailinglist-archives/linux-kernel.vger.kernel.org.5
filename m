Return-Path: <linux-kernel+bounces-84222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B3686A3BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015911C244EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18515788B;
	Tue, 27 Feb 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ailtPqkM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2C56762
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076669; cv=fail; b=kp31pS8ExsV9hxdE3yjzd22uiocs4Q2DMP8Lj5FxoFpfiJxLg1wB4FhOu3g4ZOwgakbqSPvUuXGIfPuxjp5FpEMKoSb6fIjDGw2wBZD51CdObPPkH0jnNpCbFbn4iIAYuRwb9xezVuLlLEzKPu7TGB5ueqnj3tzuQWhhMJP/OrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076669; c=relaxed/simple;
	bh=oDN7spe/LJzvYMK48GX/le7knsB2RP4H5XHAeSYVUGg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hv35yfW64I5hg6psWtw81ty7k+R3ihmPYOtMdx/EWGpcxDfzdf7I1bjUixMOw+V8wexTnWeKsH5ShEYY8cLjAstmkVe0HcfUs10Nws70Xf9ytnIQG41Al5uOAkCfY1qsVGRWG9y3XW1xJ0vQxm5giH7K/s53BL4hn+ocGxLDQfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ailtPqkM; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709076667; x=1740612667;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oDN7spe/LJzvYMK48GX/le7knsB2RP4H5XHAeSYVUGg=;
  b=ailtPqkMnD7YiIBlPTupxUhA/emOOeZdN16lwNU5Hopiq7UkGElMicZy
   Y8VbhezDE+KLFgNskSAQGdrGPdqUTcClWg0UIdpp/a6DIoLJygIKC5tSe
   3XU16q9yIh/iqM9my+zywnZIuYO8+FuCFFP0nDJ54brBL992icoZQLfGe
   0MbZWRYDxMVdXvmkmh1u8y4hrPus39WvhMyjmgixOc20x4FZQWMHPOKa1
   fgGTbN8HlWxVLd4t1WKw6lCeMTO3BlCr/rRG1kiV1dOu8qlDAL6ySPr9r
   YbXMZASYZn0cDpOxY0GMnHRTwG/V2qGxJ4S3QF9L3DD6AVhcC01S02UmD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20999204"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="20999204"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7571257"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 15:31:06 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:31:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:31:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 15:31:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:31:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu8STtKXIDc/wr1vWPD4cdPZXuC8ryPA76IVIZ8MmakeVGBAJHwowIElc0e4gCP50p2+AzAIlft3DhNOPelcpugyrzu7DDcjK66v+c9JXSRbjgz+rreXmTVJEzJrZS3QIjIeWTNw+VjXPB6lFN5INt9+xr3UpUo1qCvTsq+im42MqFYW1fDNmta3CmOiC1QoiNJrF9mMFULSugIGV0nBnQhL8ko95sA9nCpsGQcQrh+FAjd/KBwcUuFpOWBZlotFwd0OUpd5Q6B8Kgd3hOX5TonGdDya2ADeuYykJ9t85rYm2OZ19aunU5e6FWADrG07JUZMSTDlzetVSNNzvLbUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9CJjDRhk/UIeZ+nbjJF+Pdz47xJdCUQ2eRVOwJW+cw=;
 b=mmcnpWQZUyaUk2mO+feJ2rVuU2z2Z645R1D/Yotc2m/SB5OUDSgoCBGaFj5FqeHf0s/EoQTFUjQWGqukf1v7EEpl5qsv3V4d3ARd3Z02EL7y1d2V5CliPrYofGbmUfxT+air3X4KZUvMnh8V4oe56RRShMmTQRru3/zrnrnen/U8venZ+thDP1Be7vfB1T4RkEcvuQJKYdEH+Ql00BXMxYpgAvW/DOVqOoy55qyNg8/5N02tQQ0w+pChsa569Af8wG8pbgpTuG2d1wRbOyAQWOUwb6AF2Pn5x18joS3PiBz1fh+m/eofiMB4UMR1kTUysOoMQD+T2HAlabbXEcORZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 23:30:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 23:30:55 +0000
Message-ID: <13ff89af-cee5-4102-be23-1c8ebd51f86d@intel.com>
Date: Wed, 28 Feb 2024 12:30:42 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 10/17] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Jun Nakajima
	<jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	"Sean Christopherson" <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <20240227212452.3228893-11-kirill.shutemov@linux.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240227212452.3228893-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0072.namprd16.prod.outlook.com
 (2603:10b6:907:1::49) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA3PR11MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e6afa6-551b-466e-eb35-08dc37ec24e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gU0sQ3fuao4hjC4uuOF0j3cg7WzKeuqfn8NRDTS260omVR3UpNeyv0Xslq1bkwZzbEzNqTgIWAUnticqUif5vIqRNGv1zDC5KiB75YzZ5lfJksAubeGVUuc9HKAEfDqtu5Kq3rJPqDfo+Pe/fb0C7DhVIWtxrA9ASaXBnu2fxO9SZ/lX+G4H81IzRaONCfQ2gNZULh/gMVnzwtzMLQlk/MClWl3+2m8/BVIsaMfZFQYIHd8BKrEUR7DKee0MJ5NNX9DwH/c7ZyxGEpjczrsZe3sSFlm6x3e5C/Um4s87vUHd54+hCzKcunKe8qRfJKb/y5FyHiKmjUownboR9e776n5l31Ydlm0Qn5PwCfBkQTSpY4ctLdCPX0nL2MoEVOOppqotmcPVOJHXGJ/lIioGtN/7bXpRqpTaVR0QYxGB+M5waSoPNSMos/iSYzj8vaUj+kf5nqUu2X0f8gc2Y/q0BYihxsuKs+OBXEr1zWr8Ijxg4hACgHH0ZQtepI1oAL7lhSAoh3ttx+CPtULiP7lBYHksejiJgK6DuKqij8O5mvSaIbnyT+pYrX7/ou1qobvKf1P8sYXdCJn02W0hKEdHIGb/uoiEmUQwoaprBrRggvM2D5RLF18m8k99/u0YijyDmQ+4YVF6lelAXpoyrouPJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJZMUJpN1dtb3lmRjJOeUFKcVFyK3Vmam04QWJSeFlqWDJWcWhmNjMrT2lG?=
 =?utf-8?B?RGo5cjJXVnhqb3FlOVZHWjNGREV6SytkM1NyVlhCd2ZFUVVuc3F4ZFNORmMy?=
 =?utf-8?B?T2FMVTB5dUpIWldUUUtXMm95RkVpNmJPOGhubW0xd0lRdkExWmpaYmRRVXA1?=
 =?utf-8?B?RDY2WFl4RzB5TXNmRlJWdXlTWGIxMWJJOGZSdEN2N1ZBSlNVM2Y3S0Q3Ylht?=
 =?utf-8?B?R2ttRjhpNEc1VzZ3YmVHTk1qay9zVFZDUmF2L0Jad0gyT3NwSU80clVnV1Js?=
 =?utf-8?B?TXBpeUZkUkYyc3hJUnpLeStRR3VGYWpmazh3L0R1NWtxa3hxUE1KaVNHTE8z?=
 =?utf-8?B?Tkdic29ldGY4K01jdVQxcXF0d2RoeGRjZW9xSUlDQkFveWlQeGp4VEVUS290?=
 =?utf-8?B?TE5QaEhKU2J5NlNvc1RRbHZRRUJNTVU0SEJMZXphSkdtR01tM2c2TXNUeFRO?=
 =?utf-8?B?cUo0S0ZlU2lqZUF2K1Q3c1V0YWs2WWRlZzBDTHM4cnArbURUazBQSzdaSm1N?=
 =?utf-8?B?eGZkWnFCSnE4RWxMVGZqU1o0a0FPYjQrNTMvdThPSzJETXNIWVlIajhFRVFs?=
 =?utf-8?B?VU5tcFhjbTBQMmI2OENzbHJ1N2RUOXhVMXZ5akZKRmtYTno2S2tuVnd6K2V5?=
 =?utf-8?B?SzR1K3RjK0FGdW1hVWVpUEM5RnRlK3pScDA0R1FaeDR2RmR1NHprUW81c2RG?=
 =?utf-8?B?cm5iUTlIZ0xNWGpNaXlNQi9pcFp5MFJqVnRxK3RyekNuRnJvL2pFWVhhQzdC?=
 =?utf-8?B?bkJxNnI5Z0NSbDVQTUVGeFRKVWN0Z2cxdFRXUExMVFVra09tc29KUkhLOTFz?=
 =?utf-8?B?Zi9kdlpqcEhyMjR6Q0UzOTUrTTNxUzFQaTdRRXk5dk1semJjNUswdFZldVJt?=
 =?utf-8?B?azRLKzRiTXFnbnl3azhLSklqd2tnZXFGOG9odi80YjRlc0pELzJveU9zTUUz?=
 =?utf-8?B?c09adFk1TTF4d3gxSUtHa054eGs3QmNjWkdjRGFxd0hXZ0R6Z1dSMFNJSWdn?=
 =?utf-8?B?d2ZrWkNlVkhMVmVpd0YzRldiVFh1ejArQkhieHBlMlNIUzkwS0NkT1VVWm5B?=
 =?utf-8?B?bUFpdFdJdmpQVXY1T1VuWkJqYUNhQk4wOS9xbmh3ODNBK0FQQW9YQmhKNzJK?=
 =?utf-8?B?NnNTd2xqc0QrUEt5cDdqclZEWWtzUU5JS0o0U0dTelZDM1RjY1VwRWlEQklO?=
 =?utf-8?B?VkRYcFgyVlczWlhJMlNua0lBV2FUOTlyWFZ0NU1NVmM4WHVHSHdneEVxVWRx?=
 =?utf-8?B?ankxMTAzcW1xMkp6MnhJN20zSkVFeXZWTnFXVUcyV0JTcDczcjhQNFZNSXJV?=
 =?utf-8?B?d2RqcXA0cU80eUpWNWZpcjc0dTI0cGZtcVQ0bjh5am85WmpDVE9uK0xVZ045?=
 =?utf-8?B?TVU0bzFYMTVyMG9maG1FZTlLRjdyc2d1WVVqdlRYMGx4S3U0cmY2dTlBbU9v?=
 =?utf-8?B?dXV2dmttWWdJeXBPeXJCUERoMnhZSmZFUWZKVHNQejNKWlBuNTd6MERneE1N?=
 =?utf-8?B?ZUg4S1pocEJCRVBQaVhHOGFMV0FlSEJLSVdQOGdnbFpKV21ZZk16eXFJSFVo?=
 =?utf-8?B?QjdOOGQ2QnJNVCs5NHdrVHZXb2YxU3llNWN4TUN3RWRYY21BZFdrTjczS1o5?=
 =?utf-8?B?WHdnQXRoYWUzOUowellRdXhWQzFpWmQzU09vN1lJK2tpbWJzSWZIdEc1SmdU?=
 =?utf-8?B?eEhaczB0cXowdUloUHZEN2dxaktzVHg0ayt6WUlKdUJidnR4UUsxREVMU0Y0?=
 =?utf-8?B?VFExQjh1QThHTWNjYkxyd3Vvd2RmcFJqbEVsZEorbDFORFFNeHh3Z1llUmtK?=
 =?utf-8?B?M2pWTEJxemVhT0FGRTd2ZXZXeGY0T0pKUFdsQ2dLTXRxNHlKZDl3RFJVcGEv?=
 =?utf-8?B?azVVditTbm8vSFpBY0RXaHdJRldOM1VsZ3BvNHloLzM3R2RibDNDSUtjMVFD?=
 =?utf-8?B?L1NWUW9kU1hVaGpCVm5QdTMwb05vS2p6eENzdDFuS1VxbzdMdmw0TURTczQ0?=
 =?utf-8?B?NlRZa1VEWTJrZXQ5U2MxNFBQaDF2WEVIQzdiTWN2azFXMUZFNlgxQmNQWDBS?=
 =?utf-8?B?bExFWHlnRS9TdUVuS25nNVpYVU1LK3hhaC9GamlOQWRjb0Rtb2pDc1hqSk94?=
 =?utf-8?Q?91Un6i5xzcMQMg0LadiZI1IuG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e6afa6-551b-466e-eb35-08dc37ec24e2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 23:30:55.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW/mO1t/mYwr0JvF/B11z+ABeJy+VzqEuH9soRcnhGjRmUJhEl5xLHmSv106XZbq8NlX3PEjqQWhR4MLFILl8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-OriginatorOrg: intel.com


>   
> +/* Stop new private<->shared conversions */
> +static void tdx_kexec_stop_conversion(bool crash)
> +{
> +	/*
> +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> +	 * conversions to finish.
> +	 *
> +	 * If race happened, just report and proceed.
> +	 */
> +	bool wait_for_lock = !crash;
> +
> +	if (!stop_memory_enc_conversion(wait_for_lock))
> +		pr_warn("Failed to finish shared<->private conversions\n");

"Failed to finish" -> "Failed to stop"?  stop_memory_enc_conversion() 
doesn't actually finish any conversion.

Other than that:

Reviewed-by: Kai Huang <kai.huang@intel.com>


