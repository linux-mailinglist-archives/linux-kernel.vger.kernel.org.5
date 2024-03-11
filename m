Return-Path: <linux-kernel+bounces-98495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BF877ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B261628136D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7782DDB6;
	Mon, 11 Mar 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFzqsgGH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173CCA47
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710137638; cv=fail; b=kB3WAA2a3UO95RrBjE31XeIq0Pxspr7PMeZC1iZH420Hgs6zwV6622gZkjAdQhomKvuyTz8S7WPB/atJ9ogEvoE3D5tk37LkF1dz0D2fbLumjrTTRcVKkp+GMTSyoTRJ50G+gVu6S9Rb/ZL3y6wUSG5MzXFOqZsLWs2lwchjmRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710137638; c=relaxed/simple;
	bh=RcHCgMRJhmkasrxVflEjUCYQCinrSimrqB+bimQYvhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UeAqHhEFMO8jyVLwSCXFZkmWPfce41v7oqybpOLfhZjX5RZGrEvvmMxZEtpgaPrfKT5cQ418kp/3ud0+wJbYwoDvZBuACyVkTe248u40W6JRallup9HVOXaIKSdaJZdmYUflOJmxU/jGEZTMN4tWrb1RcKTW2F2jv8IZM7c84Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFzqsgGH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710137637; x=1741673637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RcHCgMRJhmkasrxVflEjUCYQCinrSimrqB+bimQYvhw=;
  b=KFzqsgGHwLy4XUnJr19WDnrBpk55gnE4Ircdfm1GIWOlEivyoXWYLkN0
   8imS2BQxbUGDSX+7EuA0eFsRvHT+0qmT/zTcYoA3gBPxfDv+7o+nv7bLa
   GJvb0Cy+crySYBxY1XR9rIgUsly208JOFmsJYj0VW34zTUBIxsrucTinI
   qNLt1VwjDmjQvGUOh7fnrbsMbzdwbqVl5WiGPqE720kYbhTvWJI3RnHZJ
   leutlaDf86aGjS7S4P6UYZMQO+SVQDIVctdeuVLTwR3J0T8TXWaIpDTF7
   +oCMVsorc5VH3mGAAPEPnDs3gF6IeOuHxeDxMJdWpGit8WHyhQy2XbHdU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4950001"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="4950001"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="41991015"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2024 23:13:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Mar 2024 23:13:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Mar 2024 23:13:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Mar 2024 23:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYqr4mtusz8mN/0LCPQY/iMvMmXlIzRhCRSDTWDHBNntv8uWaWJ+agtrU+OGnqgRzFStDngZ6rT8tR3pIzv1gw547YLiJ0Dg9IwEWI4QcIvjIrzMCwW3VIEPE0CDGNVbxMdslA4yKgfFskT7uPnlZ+6arbGwf7E/P2/Sw9UREBLOqz2aVeA04UFdYDX6Vre54XnwMKww4I7VA2USo9VLYnvkuTzhbXO84EuXhKA52eZWvz06A6dSUfsGsPZCCN4D76ZkdepjBWhY4mqoXOvMvSKqsoM7gSa5x+mRLcNqnQ01x2GXiDJ2Fj60rmviQsvmSOILXXXEG67K4xBw0jGk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcHCgMRJhmkasrxVflEjUCYQCinrSimrqB+bimQYvhw=;
 b=F3FW/p2HCzTapErteEWrHObQ9ks1bHsjFt8h6CKtkuOM/jTdy5FZuNQuQg2ADmDwAdj3rplU2mipJAQ9NHZ4pOpxDP8IXOvUSpfVHM9UBMZ8fA9qIPfUMd4HKG56s0SIudzgguLJbUQoXC9Si0LNW2CHJeNE5pGCVwNy1mDotN7Cm0mvi8wyVpaNYowGhXVipoZ/TPcrrEwvl3l4ry26iPHzJTu2PQAETH2+dt+mjkX12nugP0lj8vJkaFXprit0eB/6dZbRvbGBT+/OTbiH+xvj/VaNt8IL+16PPu82REgkck7edJxZvL2Zcioi75ARTDNtHaiPhj9Myrbt3ts37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB4814.namprd11.prod.outlook.com (2603:10b6:a03:2d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14; Mon, 11 Mar
 2024 06:13:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7386.014; Mon, 11 Mar 2024
 06:13:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org"
	<x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "sibs@chinatelecom.cn" <sibs@chinatelecom.cn>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Clear TME feature flag if TME is not enabled by
 BIOS
Thread-Topic: [PATCH] x86/cpu: Clear TME feature flag if TME is not enabled by
 BIOS
Thread-Index: AQHacVWL1wo9ad6uNEmhez1ElqJwr7EyE+WA
Date: Mon, 11 Mar 2024 06:13:51 +0000
Message-ID: <b909cb856eb625f00402472d3f3153db2294f259.camel@intel.com>
References: <20240308122752.3342-1-sibs@chinatelecom.cn>
In-Reply-To: <20240308122752.3342-1-sibs@chinatelecom.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB4814:EE_
x-ms-office365-filtering-correlation-id: 0ed71efb-6c7b-42d4-1ea4-08dc41926c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMpHBltS7jb7RXCsfyQ3XXDDPPiYGRteKjbr7z57IrxPGGfOVqwTR/YwtJ8oU7ObihJPKwglT1Sx+N29aBTLWxFAaAsiwTUHENZeaGJXcvhbLAoUWwDzlhrKgYjNSZsNP8FVRX01uHXDM1oCGjicdszfsPuaeHNA0y0hcl23HbTuV6mQaJnkBFB0KR7HWvK6520LD3D8tYjJd4qvPs6uIT5S7AQRKmLwcZRkDuxZVC+Xi3p4NnBW5QYpT5/5xlvDod/nme64OHk1cEhbznGSstKBQ1bqRfAQHyomPITdyH0cUeQESC6tLYupYBqltc1gALWtwVYEW5bC7M30JvcHbzSiJJN+aRXin8ymX/8IxETQQ4LdH40lDZ4tSj5uqhA0HMESpvsY13wd2zo+bQa0EaDDRwUv8WGtTmCjfUbuj662ST9w1nHKK+t8GbznuzjsguXx46VdI6inR5tAgZkf4YG93M6DsqMuXnP5jb6cmxoSwSdeK2/EcnyB0J8LSoS6HDcL2xAIiVjQjcP74C4MP4L3jR/4LdgSo+DyVJnHNAeu42f16rxQ6Jbd/A9IJ760wy0IMRiM8NeW/nayXC4NdmejybbPaQVc47E2n1iu1v8WrfdNFL9cueJXf5U8c+7NKEzLWZa8RH6paAa3xT91cs02s4OoxLfa6HnTynMPZA7jmoMDFGFBPbnXVTTamEB8hRi2OQq1rzVC7v5hAIz7eqtupaTQvsceK6gwQQ4Ia28=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE9MSzNtN2ZLUWN0cUNoaUdzNlJ3MUo0aVl4ZDBhN3hRK3RaZjREVVVaN3FF?=
 =?utf-8?B?dVM3NWcxdmtWdmV4THhVTFV0Z0tqbmczU29GVURhK1Z4RGo0YzBiaXBtanJj?=
 =?utf-8?B?bDFIbllGTlFJOFJEaDhyTU1sRmU0Vi9taGgvY2lsTXhHUkNZeGFyTU9DRjNH?=
 =?utf-8?B?b2tIMU5MYm13ZmdPOUxaVWw4UmlheVEzdW1ZUWcxK0lsaDNaZ0JOekFSWU1L?=
 =?utf-8?B?dXNXSVRtN0RzalRSYkpvb2JwOW9UMVVJUkFXQi9EZlVzY0E2SklIdjlmSEM5?=
 =?utf-8?B?WmhmUE9GSUlqcmJ0R3VXU1I3c1dJZTUwZjRMdm5rU3c3ZTlXN3RvemhnSlRX?=
 =?utf-8?B?WlZhd2U3QXpJQUtwWGRLL1Z2ZlVDekc5SVRIaUdScitWNlhDSEFSYk9MUGJT?=
 =?utf-8?B?dDF3NG9Kb3BUWXU5TEFUdENjeWxrVnZWaVRtME9wbWFsSTkyS1p0U01rT0Jo?=
 =?utf-8?B?Nkw4VmNpeXFFbXdhcTkyR0RhbkhWRmtLS1ZjQmM0R2lvYkdYWjl2bXdJMDdn?=
 =?utf-8?B?d204YTgySDlBT2I4c0h0Q3NOVXd6TUR5TUFEdnBvbVQxeFFPcWdLQWFHNWdU?=
 =?utf-8?B?cDBYaG1lOTNNTW5zK05zQUx6TGUxOU5wNmpDQ1VQMGJIbVI3V1N4bDBuYkRK?=
 =?utf-8?B?SzJERFcvUGI0Rm40c2Qyc1lLQXVJdjBpaHU1VStpbkJweU1XR3NKU1ZmZmhI?=
 =?utf-8?B?VzltcWRMM3UxcWVpbW5yQlpqeVA0RjE2Z3VTemRYOXNkSE9XRS9YU1lMbEtz?=
 =?utf-8?B?VHVrYnBvWkZmQXBoYmpCSjNsbnZBWnN2SG5LcHo2cEM1aWx2cGJNTEQyaFls?=
 =?utf-8?B?YmRVak4wNTlTcnExekRrQ2kxZytGQjByKzY4aWNqQmRBQWVxR09TaCtSdkdT?=
 =?utf-8?B?bUhMa0EzdmxWMUNWTFpaZ21kdHR1UnU0K0lGUWplWWtMN0s2cWsrcGVuMTRp?=
 =?utf-8?B?RUk4Z3J5MkVHdzVTVFUxUkdXNU8zQU5KNC9Dc1FVd3ZlVEY3dk8vTHVyeTRJ?=
 =?utf-8?B?MVZLZmxmQzhoSFRGMXdvTTRVci9TY2RGZ1dFbFEwZ09uTEhVR2c1ZXpYMURO?=
 =?utf-8?B?aS83UElWYm15K3V3NHpqbjduaVFMZFNwVThhN1dSWnkySUtjeGJiUDZ5T3Ix?=
 =?utf-8?B?bW9Bd1VUR3YwMFV5cVZrRDdLdmdkUEt5akorcy9hckpmamdpYWZwVkRUVWRQ?=
 =?utf-8?B?NGxueloyWlVGeDlab1M0alUwdThxNG5FM2VZMWE4VzllWEcyb3A2TXF4NldG?=
 =?utf-8?B?a2Q0aHVYaWhxYW9TS0ljVXRScTJZcHpBQXR5SThTVnRYNktjNVZJdlo2RXpj?=
 =?utf-8?B?bEJoT05KQlR4SG5FZnlvOVlyUlFpakw5dGVhb1BVYWdSTmM2L21rTU5SbDlj?=
 =?utf-8?B?alREaDZUSGpLZ0p6aDJoNS9hTnhVcGVkNnlXV3VZM01pQmxvK3paMk13UnMz?=
 =?utf-8?B?SXp2NkhCQjJlMHhVY2lLcTZHVHRJRzdkMjNRWDVVakVsY2dJUFFtWS9XYUpq?=
 =?utf-8?B?a1N3UGFiM1pxYzFDYXpGSVVpWEdWV3dZNWRPRzhCTnhqNTM4SXR1TUZVQW52?=
 =?utf-8?B?WnhkTTFrU0lwRFFKdVU4ZDAraEJpR0YrbURLVGIxbkpjMGRPVzAyRThBbS9M?=
 =?utf-8?B?RDkxYUNzQ3dGTHlKMTBXOFN3Qnl0dmpxenpvalgvNjNFaEJSYkJER0EvTzFh?=
 =?utf-8?B?REtDeVorcmpCb0xLc05pTEg1WFFEdWE3cVN0NTNTRUxNWU9zbEdlcEZYT0tF?=
 =?utf-8?B?aFFTcU8yUVpUU203YXZwUDhwVk0rdkxaNEsvbmVnUFY2MlJXcmtxRm1QMWVS?=
 =?utf-8?B?YTBrZ25DUStuUG1POW1Zb2lwOHp3dlBqQ0xKcGRaWUE2RUdhNXR6L3NMd0Zy?=
 =?utf-8?B?NGw3S2VaZUhGOHNFd0dOLzVOYlQ1QnZsYzY0aGRQSWxYNHA2R1ZNS0RueDh4?=
 =?utf-8?B?dE03M3FKajVZR3AvbVJxK2hOelpLYTJRNlR1MUN1V01PZDdxUjlmQlhhYTJl?=
 =?utf-8?B?K1BHaG1aVlNJRWpkNTVldCttU3NWQkF3eHFTUXZoZVppWUd4eWpZTFhIQ1ZZ?=
 =?utf-8?B?LzNtakxpRElHWEV4WFpnQzJXTmZyVEtpVGRuV3RtSWQxdlg2SlVHY1RMb2Q3?=
 =?utf-8?B?cmVrS09wUFJ5OVdFTUlUVGNwU3J2L3R3clN3a0tPbXdjT0luVVRzUWZmeFdn?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A6B19EC6ED93D4688ABA3B07D9E7A3E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed71efb-6c7b-42d4-1ea4-08dc41926c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 06:13:51.9335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2GBNHD7RgkBMNLO1zepMW1pt1jdbk9Dm00OgP1zkRoza3WkhJ3u7Qv8W9UaoAFz/Gu3IgJOt+AW3szsKE3S8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4814
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTA4IGF0IDIwOjI3ICswODAwLCBCaW5nc29uZyBTaSB3cm90ZToNCj4g
U2lnbmVkLW9mZi1ieTogQmluZ3NvbmcgU2kgPHNpYnNAY2hpbmF0ZWxlY29tLmNuPg0KDQpQbGVh
c2UgYWRkIGNoYW5nZWxvZyB0byBqdXN0aWZ5IHRoaXMgcGF0Y2guICBUaGFua3MuDQo=

