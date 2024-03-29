Return-Path: <linux-kernel+bounces-123860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA172890EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E211F23815
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A790A35;
	Fri, 29 Mar 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6l9w2Go"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41918E;
	Fri, 29 Mar 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671165; cv=fail; b=sUnGqSI/Y9WEKVLyf7e3SkSkS4qolZiBWTo3pWvuP6y4ouWAh+1GTFr+M9BhadzRq6Mzcax6YPgLWNw/3TrbR/IptUvfRqSH9SvjG/3Dgg4+tWgDtRExWp4GpHnUWHfI7sVYwNUZ1J0GxLlsmeZ4BAgBuZjWTO8AWmi+pZzB0v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671165; c=relaxed/simple;
	bh=k28ZInVS85HCQRQ5rx5GCVIOpVOJPEs1rurPcjU1B1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qiNWS1+kJVJd2fPX6Jeh6OkBJ0Lg2c+AylsVY1bKlYltm2XD2f2dr9W3d08RLx9PaX3b89Cw8P10ro3J0rmfpUW+dXWdu3pISxv7IigZpr/9hd8styBcTMnAJUlvu67YijpNFWvxk8dr8PNmt33LH3cbJB8s+9jBpZmbKIyaWcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6l9w2Go; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711671164; x=1743207164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k28ZInVS85HCQRQ5rx5GCVIOpVOJPEs1rurPcjU1B1Y=;
  b=j6l9w2GoKGygfR6ugksH2KTIRzOfHQb8BOLDXDGTydrjjohz6isR4IqP
   qEEdN1ATjS5esTDeCpiwVgsS2ogk6Be3iG1IDYnhH0yk6BuOUMxub0mM4
   r9ZybknneJdn5JxtSTrHTBaXys1JBffO3MKCWyhXCjCVNrls9FaBkGcqB
   8KhVTTnkRJybZPs04+WUWvT5zjmdhHuhj94fNE0zFqPgxi1x+koeInERa
   9N5+Owr1w53/bUfJ/Qsifw5nNCAIHMD2ZX5UbxL4FeIEykm3xwyP/Up8z
   O9V0IVgudK7zSog9pfuUX2jhDU2yAE6Qrr+n7lVm21lfJoSZzbimvUkx0
   w==;
X-CSE-ConnectionGUID: A27OQCyvRC6/kRT8g+zlhA==
X-CSE-MsgGUID: 07pAZOzLT8eNd10LKX12ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6796480"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6796480"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 17:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16867893"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 17:12:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 17:12:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 17:12:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 17:12:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPM5becdhnW9uVHhwya6wpmYNwAVClDC9yY7wYCxHxsHnHgioSaX2H9A/f53a8HC7NNIlGwtkrqqFeKLkla9ujrSDz6hgidkGo2CwfB0dZvJ2ikVPN3/E6lR0qTjIQWdJZJgLGDlIVkhUsuOP6LFDmCUA1GbxcfhqGSSIX3zJe26DxZcTFxscJLhDsNUd4mBWkmFz0zGdatyVDaS5rTuJXQMKjozJd7tQ89/0niMktqVzlEcbKB0UDnqwI4r/UHUJ3HAJLHVpnPG7yuOh34b4XrRcGTKE2rmBrzTBNXu8Iy9nqvrItqZI4rbKlW7bX3GN46ObKJ+aYuQGaXGqXg1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k28ZInVS85HCQRQ5rx5GCVIOpVOJPEs1rurPcjU1B1Y=;
 b=JdaCyvFniy4dpSiBE0Wwi/L4HX/4OKo6v138hha1meaWyniI56+6Xk43DJxnusPYIyObSkoFT6y4vhrjhPhgY2Uq6bv0n1NGq4CWCinH7f5e7XgHABt9KR0gzKfDFQ8n8VUKFZSr0NrPlh+TClUfc7ZHAUfexwfgnMC18avKv7GVNt+8nHqq6+56KM9goEMKve+6rSu/Zvms1WV/I6cxlkAhU91PAfTFaZW+UlRI9loC/9tN2N1YxK15dCy1zDyw+us0tdgMMHyiTgi3Y4CUbx6Ms961ix0zRHXDkmmKtXQaxWaGkiNBCgOKRw0jAnZIDZGWKy3IK0GkrojILMYtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 00:12:38 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 00:12:38 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor,
 Perry" <perry.taylor@intel.com>, "Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v5 0/6] TPEBS counting mode support
Thread-Topic: [RFC PATCH v5 0/6] TPEBS counting mode support
Thread-Index: AQHaf7xU2Gs8bKW5/kyH7afAmnP717FNXLMAgAA0OACAAEsRkA==
Date: Fri, 29 Mar 2024 00:12:38 +0000
Message-ID: <CO6PR11MB56353F87C19F5D1DD913F94FEE3A2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240326202859.960577-1-weilin.wang@intel.com>
 <CAP-5=fVAKRa7LsvyuNhjQpQuQyY5hvQ7yBnaWjeAJFYtS648Xg@mail.gmail.com>
 <CAM9d7ci+8m1-Hcm9OjkaLk4ZOs6J0ah+pg0phyQGA_HVX9Qb-A@mail.gmail.com>
In-Reply-To: <CAM9d7ci+8m1-Hcm9OjkaLk4ZOs6J0ah+pg0phyQGA_HVX9Qb-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CY8PR11MB7084:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdnQFliFO8KKle/Eklx+xsksQQ8GeNHhWPm0Heseaq13CS910pah6kueihuu94QhL7bXmF/KY9qz7ggdSBeOhTd1T76X3GZarI53EFYq8NHxK30GFf9xyWWBKBr8WTPvkc/AI6jggWLhVciN8uQPGnZY03gaV3vlQ+OfcvfwhUzoROs9ZfJWGM+d6Xl16cjCyVCxVU+5af/uPIV2HQ3oCElIAcpVlkhPDIv8bUig+mrroayU7KOgB+J7eUpdAd/ISSXjhaEfxhAXFBt9v80UJVEbLKg+dABomLi9qE+zdtxQKVBZLBh7gQ3oM+2N82/sVsasT3ROoty2YvvD/rrQ0Aavf9k383Ge0JpmP7kjCp2wmjH/joZwImJBMqWE8y8rP3FaKeudk3fj1ez5weT1+3u1vDQurtJQnKqKv1go09Smy/PvrvEjX7qvfdeWRrVtn7A3BmQxP7PxE+/uLzJFIEortLiAkgW45v2PTms1V288agmUQenjvT6PCACWM+cICOMd9+jvEaLsO8TqyV5wVtPDZhZjgicja23rvJ/2INDppTEpf1egp01/wjU+EOMgmI5lQe5OWLbexCEqpwDDTs/uLd7oq/SFNEcInyoZyzI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk0xTXcxRmdGUVdHbXpaTnIxM1NIci9MT0tESXZYT3ZkY0JQdlJmanpuek4x?=
 =?utf-8?B?TDBNdG9XamlDajNja0h1WU1XTHZWUlpKQjAxUWNHaEdOdFNLRFV2UXMySGlF?=
 =?utf-8?B?RU5aSXBNaGdPcFMxZWlnOGxhKzJwb2dxUzE0Z3RjdlgvWUpObmt1KzRIRFI3?=
 =?utf-8?B?bFhWZXJVNWpqakVwSDFockp0bTZXWndrNFkzK3lpTUxTbkdqVUFnck9qbEcv?=
 =?utf-8?B?ajIxdTBYUjRXb1RKTzdaNXFJUHBCMm5qQlhUOEhSWVBiakJuZU10em9Xc3hK?=
 =?utf-8?B?Tnp3R2ptVFhuSUwrUlhHRjFjcDBxeHZ5a25ZbXFncDVrdWpuVk9rd0ExYTE1?=
 =?utf-8?B?VHFWcG03MHIyaE9qdjNKcmNhL2pleHZFcGx6a3J1MmhJMFdjS3Q5T3VjUVhF?=
 =?utf-8?B?b2NJQWtzcjE0T3RkWVY5RFZDUUpyTWRqWjZoMzBhV0FTd0hoTEphYzNYa0d4?=
 =?utf-8?B?WnNadkZxc3hnK05jNlJwZGp3OVV0c0YvdCtDUnMveElBOUFuRjN6QlBBYVpw?=
 =?utf-8?B?YThmTjdWaHkxWVpDUDhhQ0RZb2Q1elYySCsxMUlRNTRPdkF0SUM3UXdsM01P?=
 =?utf-8?B?NUorNGFDZXJYVVA1Qk9Gby8yU0N4NHV6amRBRkxLRFlYY1luR2FNekF1SEc4?=
 =?utf-8?B?bkcyN2NkbmtBOUUvUkdMb2pYNUFvemk4OG9EVldnSEx3ZGJvMkY5ZGJsaGhD?=
 =?utf-8?B?Q1ArZ2J3T2JPekZ5OXV4UWdCTGdXRGl5ZHhhMjA0ZWkwRXV0cXZKeFZLREZ3?=
 =?utf-8?B?MlZyNklJaUlBMjBqbzFSMnVlMjJvNk00aHJyK2xyVUFXWmlXd2NPRzZXa0Ev?=
 =?utf-8?B?bkFnTmw5eWJWUTE2Qm9zTjlMWHJFTjBTalJtQkxyZmtncHhQREIza3FzNWlF?=
 =?utf-8?B?SjZwVjVCSVROelVMZ3hBRVlQSVNjeGNTeDc5SXNCTVhEb1ovWWUvQmZlSW1I?=
 =?utf-8?B?TExpMnNvK2ZjSnVTN1hKb1p4Z3VMYUZyVEkwb1ExZ3YyL281R0pIREMvU2Fr?=
 =?utf-8?B?L0d4Q1FRQWg2Wnd0bTlVYStseWNsRXhBK3E3dWE5c1RwbnJIOGRtU29Lc1lN?=
 =?utf-8?B?cVVBUGd1R0FpeUo3d0FHbXpmTEI2SC9aZElQUTBVb1BEdnIvbWI5WG5objhl?=
 =?utf-8?B?SXI2cnlpY0Z3VkRjWlJOeVU1dGZUcXAzS1B2Y3pnQ0I4dUJQREpONFd2WmtP?=
 =?utf-8?B?RXp6WTdwS0ovb1g4bGU4T0l2NWFMMEJWdS9QNnRuTEZVajlOdU5XcFgzdVlO?=
 =?utf-8?B?bUZ3NW1FUEwycVcrQWlNbTQ0S1BiUUNWa3BTZ0dNTmhFY1dLZ1hOOHhScWY1?=
 =?utf-8?B?U1ZWa3ZhVTZCRTVIYU9TRU1PUTg3VjVFb3pGUjhFdjdhbHAvTEJlT0k4aWJv?=
 =?utf-8?B?dExtejZzaGM5dUMrU1NSbHFUcjVFM2Q1OHdsaGdObCtTaFFhMnlLSHlpRGJz?=
 =?utf-8?B?MnFkTU5hbkpFb2pRMExRZS9WWVEzTDhUV01GV1JoUy9YaXNCZERTUFR3WWNK?=
 =?utf-8?B?R1V4b3JyVHFXRTg2L3I0NzNRRXBYbDNpN1h2YTRTVFFvVUFZQm5IQ3JNS2pJ?=
 =?utf-8?B?aFY1UkcyQTB3U3NmZ2tTV3FXcmdiTkx0VlErZkhIWHlDdWpXamxaRi9ZUnNw?=
 =?utf-8?B?bjRVcnM2SzZnSmZ5b0szMTVjOSsySkhZcjRqdE1wOHBZRXFGVWlwWTFwUnhj?=
 =?utf-8?B?TGpsM1VuMi9tRWpmUGlJQjR5MHJDNU5mVjFVcGViRkd2R0JjanZSUm43NG9v?=
 =?utf-8?B?OGJiaUpIc1ZGMzhGUnBjeTZZUmxhOE5LM3NJeGpLbHdaYUxDWm1nOUVNTVht?=
 =?utf-8?B?d241RHBBV1VqeEo5dE9OS2tUWkZWU2RiaFNJMFYyTDBZdm0rWVRyRU9ZVkNM?=
 =?utf-8?B?aTc2OHVXcUJETEdxQzNrcTdJQjZ0bFc1dVQxSFdialdZTXQyQitKQlFLTlBu?=
 =?utf-8?B?RzMyaFVrSnY4L1NpWTc4T3NNcHJSUTJRSlVoVm92bjM0Z0hlaFNmVnd0bEFT?=
 =?utf-8?B?a1I1Q1FWeGxzcUhwL1VmcXIvYTR3NWhUdkxlQ2NNbmVWZ0Z6YVRjbEphWlha?=
 =?utf-8?B?RVVWZnlIS0ljMW8yd2lseFhlNWR6cnhzUnl6UnJnQ0pYVktzUHloNTB5VVUz?=
 =?utf-8?Q?8SzPl68B84umc1J/b6IDCYe9o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65907ed7-9320-428c-8b49-08dc4f84f17a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 00:12:38.4823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+kwNtOeWlxXP9mtPPJE7ixAOywDGwLbTmN45kfT1foIrixAGoQUzRXa0Xn3bGEdbnuri2oHPKBJ1S4/RhfKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjgsIDIwMjQgMTI6
NDMgUE0NCj4gVG86IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gQ2M6IFdhbmcs
IFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
DQo+IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5v
cmc+OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtp
bg0KPiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9s
c2FAa2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNv
bT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYt
dXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXls
b3IsIFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2Ft
YW50aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjUgMC82XSBUUEVCUyBjb3VudGlu
ZyBtb2RlIHN1cHBvcnQNCj4gDQo+IEhlbGxvLA0KPiANCj4gT24gVGh1LCBNYXIgMjgsIDIwMjQg
YXQgOTozNuKAr0FNIElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBPbiBUdWUsIE1hciAyNiwgMjAyNCBhdCAxOjI54oCvUE0gPHdlaWxpbi53YW5nQGludGVs
LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogV2VpbGluIFdhbmcgPHdlaWxpbi53YW5n
QGludGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBDaGFuZ2VzIGluIHY1Og0KPiA+ID4gLSBVcGRhdGUg
Y29kZSBhbmQgYWRkIGNvbW1lbnRzIGZvciBiZXR0ZXIgY29kZSBxdWFsaXR5IFtJYW5dDQo+ID4g
Pg0KPiA+ID4gdjQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDMxMjIzNDkyMS44
MTI2ODUtMS0NCj4gd2VpbGluLndhbmdAaW50ZWwuY29tLw0KPiA+ID4NCj4gPiA+IFdlaWxpbiBX
YW5nICg2KToNCj4gPiA+ICAgcGVyZiBzdGF0OiBQYXJzZSBhbmQgZmluZCB0cGVicyBldmVudHMg
d2hlbiBwYXJzaW5nIG1ldHJpY3MgdG8gcHJlcGFyZQ0KPiA+ID4gICAgIGZvciBwZXJmIHJlY29y
ZCBzYW1wbGluZw0KPiA+ID4gICBwZXJmIHN0YXQ6IEZvcmsgYW5kIGxhdW5jaCBwZXJmIHJlY29y
ZCB3aGVuIHBlcmYgc3RhdCBuZWVkcyB0byBnZXQNCj4gPiA+ICAgICByZXRpcmUgbGF0ZW5jeSB2
YWx1ZSBmb3IgYSBtZXRyaWMuDQo+ID4gPiAgIHBlcmYgc3RhdDogQWRkIHJldGlyZSBsYXRlbmN5
IHZhbHVlcyBpbnRvIHRoZSBleHByX3BhcnNlX2N0eCB0bw0KPiA+ID4gICAgIHByZXBhcmUgZm9y
IGZpbmFsIG1ldHJpYyBjYWxjdWxhdGlvbg0KPiA+ID4gICBwZXJmIHN0YXQ6IENyZWF0ZSBhbm90
aGVyIHRocmVhZCBmb3Igc2FtcGxlIGRhdGEgcHJvY2Vzc2luZw0KPiA+ID4gICBwZXJmIHN0YXQ6
IEFkZCByZXRpcmUgbGF0ZW5jeSBwcmludCBmdW5jdGlvbnMgdG8gcHJpbnQgb3V0IGF0IHRoZSB2
ZXJ5DQo+ID4gPiAgICAgZW5kIG9mIHByaW50IG91dA0KPiA+ID4gICBwZXJmIHZlbmRvciBldmVu
dHMgaW50ZWw6IEFkZCBNVEwgbWV0cmljIGpzb24gZmlsZXMNCj4gPiA+DQo+ID4gPiAgdG9vbHMv
cGVyZi9idWlsdGluLXN0YXQuYyAgICAgICAgICAgICAgICAgICAgIHwgIDIxMSArLQ0KPiA+ID4g
IC4uLi9hcmNoL3g4Ni9tZXRlb3JsYWtlL21ldHJpY2dyb3Vwcy5qc29uICAgICB8ICAxMjcgKw0K
PiA+ID4gIC4uLi9hcmNoL3g4Ni9tZXRlb3JsYWtlL210bC1tZXRyaWNzLmpzb24gICAgICB8IDI1
NTENCj4gKysrKysrKysrKysrKysrKysNCj4gPiA+ICB0b29scy9wZXJmL3V0aWwvZGF0YS5jICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICAzICsNCj4gPiA+ICB0b29scy9wZXJmL3V0aWwvZGF0
YS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA1ICsNCj4gPiA+ICB0b29scy9wZXJmL3V0
aWwvbWV0cmljZ3JvdXAuYyAgICAgICAgICAgICAgICAgfCAgIDg4ICstDQo+ID4gPiAgdG9vbHMv
cGVyZi91dGlsL21ldHJpY2dyb3VwLmggICAgICAgICAgICAgICAgIHwgICAyMiArLQ0KPiA+ID4g
IHRvb2xzL3BlcmYvdXRpbC9zdGF0LWRpc3BsYXkuYyAgICAgICAgICAgICAgICB8ICAgNjUgKw0K
PiA+ID4gIHRvb2xzL3BlcmYvdXRpbC9zdGF0LXNoYWRvdy5jICAgICAgICAgICAgICAgICB8ICAg
MTkgKw0KPiA+ID4gIHRvb2xzL3BlcmYvdXRpbC9zdGF0LmggICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgIDQgKw0KPiA+ID4gIDEwIGZpbGVzIGNoYW5nZWQsIDMwNzYgaW5zZXJ0aW9ucygrKSwg
MTkgZGVsZXRpb25zKC0pDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3BlcmYvcG11
LQ0KPiBldmVudHMvYXJjaC94ODYvbWV0ZW9ybGFrZS9tZXRyaWNncm91cHMuanNvbg0KPiA+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvbWV0ZW9y
bGFrZS9tdGwtDQo+IG1ldHJpY3MuanNvbg0KPiA+DQo+ID4gVGhhbmtzIFdlaWxpbiwNCj4gPg0K
PiA+IEknbSBoYXBweSB3aXRoIHRoaXMgc2VyaWVzLCBteSBSZXZpZXdlZC1ieSBpcyBvbiBhbGwg
dGhlIHBhdGNoZXMuDQo+ID4gQXJuYWxkby9OYW1oeXVuZywgY291bGQgd2UgbGFuZCB0aGlzIGZv
ciB0aGUgc2FrZSBvZiBNZXRlb3JsYWtlIG1ldHJpYw0KPiA+IGVuYWJsZW1lbnQ/IEZvciB0aGUg
c2FrZSBvZiB0b29scywgZm9yIHRoZSBzZXJpZXM6DQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogSWFu
IFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KPiANCj4gTGV0IG1lIHJldmlldyB0aGlzIHNl
cmllcyBhZ2Fpbi4NCg0KVGhhbmtzIGEgbG90IElhbiBhbmQgTmFtaHl1bmchDQoNCj4gDQo+IFRo
YW5rcywNCj4gTmFtaHl1bmcNCg==

