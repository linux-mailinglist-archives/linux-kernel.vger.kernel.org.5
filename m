Return-Path: <linux-kernel+bounces-83093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7576B868E54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C77288AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B071386D4;
	Tue, 27 Feb 2024 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQkBG4+X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB279130ADF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031946; cv=fail; b=EMNa81nqmt3fjQjT3i6dp8JZBevZwt6nLZovqfaR8ra6QChzBkvQpbYTGQhMR5RfaRKIYdB+hS9ERVXJNukKhNhW/2jmyNII35pJL1KKYkd0VEVkNM531Yv1G1hm7xMm0PTWOKnW+M9kam7J5+l2buFtvggLmSWbPYegyjErF9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031946; c=relaxed/simple;
	bh=P/tQ7O9FEvFiSAcfs0On6pu/tgxLQc0Kxb/DGPpUgj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQLVS0ald33shG0ZYLWtIG+MIXc8PQDzKDlL1V83L2MO/w/vBdJsuqbsS+EO9Ek1waahV96Ds5hk+YbCO6I1OVz7fDFWiLl12o6Eruni2/OS/tO3xxkHzD2HfbFFfMAgpTZyDxftz6xK7sFeDEgKIQLRpB08P7cZxHQfoI1qucA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQkBG4+X; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709031945; x=1740567945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P/tQ7O9FEvFiSAcfs0On6pu/tgxLQc0Kxb/DGPpUgj0=;
  b=kQkBG4+XcCHwhDHg9GKsb46booVo6ucLhOq2Xy3Bb0DT1cUVMkUnGcoS
   zyfUuJD2BT6mMnjt6FLVX69PthYT8up3uvxVdehlN3G7e0xGHF+BfFR76
   /6uWR2gk8CzP44V+ElbjF+jfrZ2qxCkeoKKp544+30c2m5NtI1o1qEvLg
   BatMUlM7lNmnkAy4vp9X42B/44Kwy7f5VRgfcIHItc43mw42+56qw8MkC
   yf9MsMr0GSXtRArgo6Z184+V3kDCNfarFmGXYKkwuB6kK0pVRIAsCWG4x
   ystHHQFX5nwOVdx/GJ8g1NVr7PpcE4IyuFLJBSVBAob5qlsb7HrLQUOSK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3524734"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3524734"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 03:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11620203"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 03:05:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:05:41 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:05:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 03:05:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 03:05:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNWRrAVQbras+FkjLNM9cSlqIaZ/XtP0FmQfBWSzB4BZ5CNcMIMT7oxaMWgt8L2qL7BKLZBgMDVkwBFkX5zGVi1GAfpi3khoMdb3H80X5dm9UoQq/w0J8NpNQXE/afi5MwMFCFuPyrsRuMC696PMt9j2BonIagnxw2BmEGl/9jTFtQ8xQxZzf6VwuuL7k+xBci2PRAPXHYpiiFm33Hx254VX4PNCG/rHvprEmwW1Oduj7H1vLjInFycicUV1IR+yOk5WK4zpbMUkhAfTYR2CZbxqQ2/Sdk+8ZBDVJ1WXpMLkNvtYnlqjuIBSBAiaBIzAuBtV3+isiDN3yND/jMD8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/tQ7O9FEvFiSAcfs0On6pu/tgxLQc0Kxb/DGPpUgj0=;
 b=jxhzwEoreH909RFWhCBgOW6bzzR4aRV7GwG3rPsTjY3LE2va9808dPwK9eB5iblmmDmj3xnvLPFPXHkgD2Xbbx0sL+GdzfNyBWJMZNdH4RdOQxvDSgu4GVwZnXF6bPOWtgcXS2J35hjD4a3IW4GVzMj9gn6ximKCFeUkJXUeckayC1H+7OxygmFKaaFxKUQsmf+ALN6m2bN53cTVBEPG4HzRIjN9Njjz7Y+U8P6XursD4dhvxhxRYr7tvpZcDQBOPFZtSIGvPoK7v4Tw5Lmddpqxfd2txHlW7KJRD97uikwqasmUnYTqXM0eed30aV5zx9pj5Zzfg71UAM1U0kAfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 11:05:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 11:05:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>
Subject: Re: [RFC][PATCH 04/34] x86/mm: Introduce physical address limit
 helper
Thread-Topic: [RFC][PATCH 04/34] x86/mm: Introduce physical address limit
 helper
Thread-Index: AQHaZb8biFxF0I3BJUaIKHD4w06XbrEeDj0A
Date: Tue, 27 Feb 2024 11:05:29 +0000
Message-ID: <aee9764b0fbe9e37e1e7692194d9ca6f86a9db77.camel@intel.com>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
	 <20240222183932.244390AC@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183932.244390AC@davehans-spike.ostc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5260:EE_
x-ms-office365-filtering-correlation-id: e724e407-b727-4be2-d667-08dc37840286
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92aGGbknt21RZHuJV88NhpotAdy9bn+V9bz4oBQNgN66dfadSGVXQXpWfKCI/Aitd8Q2800iCySEnSO1Y3C2GFb9C4oubqoUapNibECMSNRfk/ODQ3atF0dW50QY8NW6Cq8f0SLne/UngQ07lKcmsyS8Z5jqSq28Y74ZRa2SO4irZil6Pvf3dywb7Xet0LuqzxcNGs9aSNCVNhk9i0vGF0OBERk7/IHc85RqwNDLumuwXybsv3g6hs8HQpaBuecFydkfk4IBxzrQeHahX6boV6/LoPwnfZiNUcqaRp9ItZDeZCXwBvQ3/p4JngIa+5Ra8bjgvVxG/zZKipJA1HwUMXx0ZbSVdA6hXs2w2hgiElxq8nB+AfJdjAgtCz1OzlCcZw0HtSS/311MGt3S3NjbqHPv7206uzooYa42+MTBFGEVCsg8GvfB9MS1285sVvRfoAzU93zrf5iQ3RFeGgAr5EzvDISZcxufTndAB9YyMqJBzj/3Jw5/DlV+7yyFdlrCeiMDVMrO4yo5k/hbyYr5i1NRIjp7woROPsleWuXWEaTrszNbh9nl/0aAAIgduP48OKBACNpQgP9Xw9u2t/EIqM4ixFN6coIHAhlnNJBGVlfchLJHcwPY9VRC6WDsK3GLgeBjvx2s76e8RtGfAq1/xtH4QfMelIkcrn+VCoO1WiUkmj0Zo/KEMXOluLeyDHHsaxUzvgB2M1w7cAB1fY/0oDSHSCokUwNGgxeENEBWn70=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXZwMmtjVWxXWk9aOG9nelpSdG5tV1FndytjeGRxa0lZZW5QSkE3UlVIMW90?=
 =?utf-8?B?N2ZrL2syUDkwVWdyMjJZTmFrd0QzRzVac2xGNzNtb1pNQjVVQnJxQ1pFc2pt?=
 =?utf-8?B?NkxhU2xOTXJISmF4NXV6elJwNDdubzcyUVh2anpJVWxQTVdPcXRJcEZuenFt?=
 =?utf-8?B?VFNDZTNUZFVLSURUd3dDZElVL1loUEtaK09EWEVVYmpvZy9taWIvNkw5cHZE?=
 =?utf-8?B?YmVXM0ZxdklvMGo1ZStGN2FVS0xPWWM0amRqc3BUWW12NmVBRVBUUXhDQzBI?=
 =?utf-8?B?ZkNKSVlMUktnVEQ4THlmY0RYVUNHdFRvd2pvZjB5aGJVQVRPdXFvQVdNd1h6?=
 =?utf-8?B?K3VidmVqdEtHaW1SS2xUNHBPQzdObld5UStLdGdOVXp4WU5CSVJWTU1iV2ZS?=
 =?utf-8?B?ZkNBekV3ZndualhlMzhueFVSVGN2MkNZOXBzaEtkTitZS2F4NmNqUm1oU0RM?=
 =?utf-8?B?eUthaktCR1NxZHJHUzFDbHBuVUJxNHF1ZjZ0RDNYRkkxN01iWHloZDVSZGtj?=
 =?utf-8?B?YnB5YjNNbFNyODZvUjJiL1RqaVRYMGlBMGMvZks4dVJYcGNwYnBYZCtlWDZT?=
 =?utf-8?B?OFNnRkxUcWdJc0xiQTFEbHFvVktkS1JxV01jeUNDZER1MWJSbVpuZGh5b1Uw?=
 =?utf-8?B?V1ZSck5MWE9Gb3dCeGFWakg3eUJpMUNodERZMi9MNm1iQmd5bzhHVHQ0S3F3?=
 =?utf-8?B?NUw1enV0elMrbnArQXRBc0lFSndBaDF0U3UvY3dnd09Zc1ZUakwzWkdZc0VT?=
 =?utf-8?B?UlNZRzI4QlRldVU0d2RWMXJpMGgzbmVKM0JDSjVqV3UyMU1rV2NqWTU5L1lE?=
 =?utf-8?B?WVhkZUpXQWVZcWhCMCtIRTBKb3dGMzNDYzM5Y2YrL3czREg5ZnpnZDlTVmtT?=
 =?utf-8?B?cjRnenpLMmJrNWEzUnEzTk5hOWJVaFJHNHY1elE0VllKY0JMekN3MktFdnBU?=
 =?utf-8?B?cUFBQzM3b2k3Qk5nNkdRRFB6WGlYMlZoR1pPbFpIR2llbG9XbnM1dk9DMkdp?=
 =?utf-8?B?cXJ0TUhwWW5FTTJvN29QWE9xR25kL2k3amtmR0Z4emQ3SGdZYXI0N24zbGh2?=
 =?utf-8?B?YmVPeDNhQ21YYkRtNVZobjhraWx1dzFLc3ExRDZMalVQRk9uSHg3M3UybXZm?=
 =?utf-8?B?QWtuUTdTc1dya2F5NWdUSWJqckczTjBqZ0paMzZyM2JIU25iR0JUQkVNT3Fk?=
 =?utf-8?B?Zmw4MDA4aUtwdUtBcWErbVBpYmI1L0Y0RStBQnN5MGxBeXBTcHRmT1Fmb1M0?=
 =?utf-8?B?NkdtOUorakkrSHNtc1JNREJjTWVRSG55Mjl2aGNhNUhwM0I3U1ZSbmpYaUh6?=
 =?utf-8?B?Zzd1eWdteGFUNkdFYnlCbmRIcDRXMzlIR3c1M0JlNkRtbUxwZkIwYVRUSGdV?=
 =?utf-8?B?aVNnZm9ha0d4Uzl6SUljWTFOandhWGlnT1FEaWN2TEEyYnZESUxBSW0yT1ZZ?=
 =?utf-8?B?QmR0VlN1RTI0SXdRcU81czlVenhQYkRhdTBWMG5rSC8zRmJOSjY3a1laWXlC?=
 =?utf-8?B?TDlTaWhGakx1Ny9oWEwzNzc5ODBxTWNhZks1elE0R2dqa3gxdEhLVnMvcWRV?=
 =?utf-8?B?Z2grcUVISDJ1SWxtd3FBZXJDV1lqREhSS2RtRGVGNkxLTm9lUEtXSWNINnA0?=
 =?utf-8?B?WDJ4dG1NQmtnZCtyZGdreFRJWGpXV2NDTWVDTDlyZ2ZRWmJOZXFXclhiT3Y5?=
 =?utf-8?B?VzhZQWI0Ym9lZnVOaHFmYWhRditIU2tPSjBnUWdDMjREbHFrT0VPYnlmSlVm?=
 =?utf-8?B?YUl3MGJ2cnlHaUREL1RBZzhjdEt1L2VjcnVrS1N1WldnS25tZVpiWXRBMHcx?=
 =?utf-8?B?VE9zL0hnOFMvMVVXeW01QVJEVUJGZzJyTjhrVi9lMG1ZNGg3OU5JTStaSjlk?=
 =?utf-8?B?ZmNENGJjMFZZSU1Md2hra29sMGJQSUJkUGY4QXdFV1ZFTElKUHdSaHd0T0VD?=
 =?utf-8?B?T2YzWlhUUEdBdndKQVhTSVJ1VTJjNUJuYUNNUmpZbEo4Q2xET0Q2dGtPWGho?=
 =?utf-8?B?Y0VqMHU3YXg1aWFteDA1dkJXRCtTemtrT0FDSU1GVTdyREhUcnJWZ1pjM3BJ?=
 =?utf-8?B?UmVOY1lnVXBIVTdDQitIUmtQMFEzYWdZcGpQc0d3MlBCbEE1bktwUE9oMkZq?=
 =?utf-8?B?VUh2eTZReWJzODFKMFNCVWxoVVVaa3l5WVQrK284Sk9sdTZBZ2hHWFNKQVRx?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F8069BCBF00C74F84BD1CD88E521DB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e724e407-b727-4be2-d667-08dc37840286
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 11:05:29.6994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0j624VpCa2zcrNfJsxh9GphMirvryS/Dj2flu0roVlJn/xvfuPLjE+qmhRuJEp+5ZhmkU0SH10yFVmQ4lwxwfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDEwOjM5IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IE1v
ZGVybiBwcm9jZXNzb3JzIGVudW1lcmF0ZSB0aGUgc2l6ZXMgb2YgdGhlIHBoeXNpY2FsIGFuZCB2
aXJ0dWFsIGFkZHJlc3MNCj4gc3BhY2VzIHRoYXQgdGhleSBjYW4gaGFuZGxlLiAgVGhlIGtlcm5l
bCBzdGFzaGVzIHRoaXMgaW5mb3JtYXRpb24gZm9yIGVhY2gNCj4gQ1BVIGluICdjcHVpbmZvX3g4
NicuDQo+IA0KPiBMaWtlIGEgbG90IG9mIHN5c3RlbS13aWRlIGNvbmZpZ3VyYXRpb24sIGluIHBy
YWN0aWNlIHRoZSBrZXJuZWwgb25seSB1c2VzDQo+IHRoaXMgaW5mb3JtYXRpb24gZnJvbSB0aGUg
Ym9vdCBDUFUuICBUaGF0IG1ha2VzIGEgbG90IG9mIHNlbnNlIGJlY2F1c2UNCj4gdGhlIGtlcm5l
bCBjYW4ndCBwcmFjdGljYWxseSBzdXBwb3J0IHR3byBDUFVzIHdpdGggc3VjaCBkaWZmZXJlbnQN
Cj4gZnVuZGFtZW50YWwgc3VwcG9ydCBhcyB0aGUgc2l6ZSBvZiB0aGUgYWRkcmVzcyBzcGFjZXMu
DQo+IA0KPiBIYXZpbmcgYSBwZXItY3B1IGNvcHkgb2YgdGhpcyBkYXRhIGlzIHNpbGx5LiAgSXQg
aXMsIGF0IGJlc3QsIGEgd2FzdGUNCj4gb2Ygc3BhY2UgdG8ga2VlcCBpdCBhcm91bmQgZm9yIHRo
ZSBub24tYm9vdCBDUFVzLiAgQXQgd29yc3QsIGl0IGlzIHlldA0KPiBhbm90aGVyIGJpdCBvZiBk
YXRhIHRoYXQgbXVzdCBiZSBpbml0aWFsaXplZCBpbiBhIHBhcnRpY3VsYXIgb3JkZXIgYW5kDQo+
IGNhbiBiZSBhIHNvdXJjZSBvZiBidWdzLg0KPiANCj4gSW50cm9kdWNlIGEgaGVscGVyIHRvIGxv
b2sgdXAgdGhlIG51bWJlciBvZiBzdXBwb3J0ZWQgcGh5c2ljYWwgYWRkcmVzcyBiaXRzOg0KPiAN
Cj4gCXg4Nl9waHlzX2JpdHMoKQ0KPiANCj4gUmVwbGFjZSBtb3N0IG9wZW4tY29kZWQgcmVmZXJl
bmNlcyB0byBib290X2NwdV9kYXRhLng4Nl9waHlzX2JpdHMuDQo+IA0KPiBUaGlzIGZvcm0gaXMg
bW9yZSBjb21wYWN0IGFuZCBhbHNvIG9wZW5zIHVwIHRoZSBkb29yIHRvIGFkZGluZyBzb21lDQo+
IGNlbnRyYWxpemVkIGNoZWNraW5nIGFuZCBlbmZvcmNpbmcgcnVsZXMgYXJvdW5kIHRoaXMgaW1w
b3J0YW50IHN5c3RlbS0NCj4gd2lkZSB2YWx1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmUg
SGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+IENjOiAiUmFmYWVsIEouIFd5
c29ja2kiIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gQ2M6IExlbiBCcm93biA8bGVuYkBrZXJuZWwu
b3JnPg0KPiAtLS0NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRl
bC5jb20+DQo=

