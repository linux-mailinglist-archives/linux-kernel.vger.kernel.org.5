Return-Path: <linux-kernel+bounces-73380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8446E85C1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9229E1C23A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458847641C;
	Tue, 20 Feb 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRAX7rb7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9576030
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447752; cv=fail; b=OsyWEspHd2YaRVigQTFxOPHJN/klkDP9jjNCpRZYLiUqQxYb7TKRDO3rQPg9HF3zEerF6v/0epFXWSFAu51Ola/PybLqZ+ntmIZtouFQ56j5KOelzzHg9/juV5YmN2aGnlsH5V02lraxHPq6b0eTCAYhs+LYpjeG3PFF0Dd5FqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447752; c=relaxed/simple;
	bh=YQfM0CpSBibnlAnDEKJlfI7/aABeh/ukQqfxwFnIo4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oru9aNmDPrNCESq8yPkBZVz1JgZs89yn/wn2r5IJL+jUC8JuZQO420Fzmt5V+T7eyZBC4CbT4+9eh1jHv+DEJ5r7KvePVK1HGhN6XkBirGduBzrA9laN3xMOVZxx8/h2Y66OIj/6Qw/P7h/84V/DKjyHx+gYz3FxKOrXxQ69Vfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRAX7rb7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708447751; x=1739983751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YQfM0CpSBibnlAnDEKJlfI7/aABeh/ukQqfxwFnIo4I=;
  b=fRAX7rb7fHtrXuy+fEnhXQM/oHNf3Tfo5VhkdUVLdM3WiOyJh/WtP7cJ
   4n9BRvbvUTPXbmVbwpAfVH7wzNSUWu9/hvv5oJm7pbLQ7fA2tGtUBSz/8
   Dxrnc/3WPTMB3i7Ju/T6Sz10SJdmDlHkpe2vPCLkPnZAYII90RVzF67Di
   Lpp8/k3m6gWkZnEbm2eeT5yBWfFZs1VyURFJ/P0ZGyQwb5HYA7ty0ztHy
   tEwpZ8e9yaU+Ofl0LiX68bHAf2iROfYS0vzBpf6eOCu2j7E+ZlROq7fpb
   Q7mnczCNYHcmAFOX+t92raduNRzn+/g3r6qHCP61ocGcTHlsg/fGjxDH2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13118152"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13118152"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 08:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9477895"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 08:49:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 08:49:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 08:48:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 08:48:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 08:48:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/lxdhq/jGvP8UisoAGeUs9uWtgJKbq7mYmRam/G9ucvM2JWoSw3aA1BzubvW3Sgfa1uAignzTwoq/DSgM9lFm6JHBlC6tcx5lpdcVupOKDrOD/CzSOCPnxHortPZUkaeooFEwrM6tli0hYw5gKz7dJj8p9RLN5ng7YkjXFyk9JC5SoKmM5blU2NOrpiAiX8DOTt3oobN6IJbPuavkcSdJf3FIGIfiUL6D2PGTDjWCkW1HYrv5Hl2RqFqgGjW30/PCG1xqpor4x0DBRfP0465khJ7FsbU+KZ1k+Fuz6BuqubA4JeNDpwJKd/DUYbcq41XpYtSVEruOiYJZgWTNbrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQfM0CpSBibnlAnDEKJlfI7/aABeh/ukQqfxwFnIo4I=;
 b=IUqCEDENIst4edgNUZ8ZqRxCGKdUzLuSlK5l/2o3vGTpI/yz3ZlTKeChJEsENHhr6CNvyM/JLRmO2GmQkwIfIX+E1qrupj20pC+/0SwZT1U6hh3sw/E7SIzgQDOFz26NvT3v2WnH1lqsUOZZOwbPlNz+4I4GfBB3aoquHXfMFkaCoQrqaonrw2WxjROjmJ9JTn7uNfNfHkTkA8SHM+WSaEQ31Jvnp272yNKEjriveO1/vRu9eqYoPWuCVp4a7J1uc5qwNMT1xpDbq0J9Xn18QB5ya4thr/RAmcVrxk2F5wWGFBbQ95i781211zj9COasJSyrXVtiaHmbvOnHh8V9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:48:53 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:48:52 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "luto@kernel.org"
	<luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/8] mm: Take placement mappings gap into account
Thread-Topic: [RFC PATCH 5/8] mm: Take placement mappings gap into account
Thread-Index: AQHaYGTFuMtklJzH10yK+fVk1/ghbbEM8tiAgADI74CABbzMgA==
Date: Tue, 20 Feb 2024 16:48:52 +0000
Message-ID: <b4ecace8453fbff4f6af5799896d75db84afaea4.camel@intel.com>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
	 <20240215231332.1556787-6-rick.p.edgecombe@intel.com>
	 <3ynogxcgokc6i6xojbxzzwqectg472laes24u7jmtktlxcch5e@dfytra3ia3zc>
	 <e951a0e08c2ba9ead0b35714aafa00ebbc75a780.camel@intel.com>
In-Reply-To: <e951a0e08c2ba9ead0b35714aafa00ebbc75a780.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB5861:EE_
x-ms-office365-filtering-correlation-id: 5dbc227b-9012-4d11-baf2-08dc3233d20e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iiGbgqdXNmIDTyFnCEsli+Q8iDGZ/C00O9IVdogbtsDIYA/wabmXw4HbEyz4lbXgEELs3P98bw/EClZlNL9Wdh3JROM+k+5BmzNHMdOmEXGtCWbAiH6Eg33tdE9jvR8ReLdDXzOX6p9fKNPQyG4rMgAYiYjliKK3Mc31T3VsU4Q7wBMcx9neJVhUI+d6UQIZ5DJTDiaZHyLrQ7+kYs9znJ/AZvOImJUuhvzF//QvzgcQOSlnOwFBacztSiXh84DwvOt3fQZpBK26tjIUNZPT7pLzMZ0Mp/RZoa++biKhPqrZx+aXtcLJlbTIjwpk17tNE9ZlFmuEKmH6TEnBBGxp/RfSBg50/i/+iFHRfp7mRcCuV6yGyuOSb3+oJdE30HCMdpbxf8X3YuDMQ4/wx0MF50Jpncqy/Z4/nVfVIBSjXzY9jhbPsvfa9xCCYSXheyovk9NnpPSVIrMl3E+S6iIl811Y/r+qMpMVTFX3QY+OTkgeduFdiake2MIzAXjxQi4BSg0xZz/o/vc5Au5GHmflNLQziQC/zOSTgrv1SmL+UGjNJGeVP8S5i93MmihsTBdJxLP8C2QnFYimr3vthhHFdotCfqQFsQaL08HvuB5/uKkmc1jXw49gbMKcNFkuC0Yg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1RtS2tPbnFkcjVLKzM4dHpuUHl0OW0xZVcrNnE4Z1h4K3dJSnZvb0w1UmQr?=
 =?utf-8?B?Vy9FaVNVbEtTeS9tM3kwU1kzRHNDbkhFUDVQV2VteXlMeEZUWVQ0R0RoekNE?=
 =?utf-8?B?NmpRay9GaEtqb1I0d3UvZlg3QjROMkZ5bEQxVDU2eDkvUDhrUXVrdEVXZkN3?=
 =?utf-8?B?MUZENk9uK20wSUxNYm9OMU5QY3RMNnFpdDlsTk51aERhN3NLZGd5aWRZbEpZ?=
 =?utf-8?B?STlZcFQ0NCtGdk9waE1JUldUa2M0YUZxMjRQd2xnQi9TT2pITEtqaktlSW5K?=
 =?utf-8?B?cHZBeVVYTFp5Z1NtZHNodUlQMCs0MDY5SEIxSndtYktXSTZaekdnT3BWUGkx?=
 =?utf-8?B?YytFMkZ4MTJIZ1dyRlVzZlhpRkdBbUJkRytnR1dhRVpIWEZ5L2VQUGQvR2dK?=
 =?utf-8?B?a2UxaXd3S2E1NjEwZEdaNjdocWtMOVRKNEg3dXRCM1hYaG5icWRydEorVlFK?=
 =?utf-8?B?WUxNamNvTkpmYUJtcUxudmFkc002SWRiSFlzUlIvOU92L2x2WldUNzZ2ZDF0?=
 =?utf-8?B?QnNFNVBDUDRqcFhNK0VlQlk0SlFEU3BvUm9BSHpPZUgxQzRmc2MwNW9EWnE4?=
 =?utf-8?B?aHlWVnNiajlzQ3E3MFRFWCtiVHBrd21lVndOb3JsZnhQSjBKaVNYZ3ZEZUVh?=
 =?utf-8?B?K0hLNWdhR0p1UVY2YkhkWWJvbXFQQTNxL0FVbzlNSXV5NzlLdzZMRnhxQXRp?=
 =?utf-8?B?anNjM1dzbjhOOVhYOFAwdG0wNENqNDVWd3B1bXBXYTdIN0dhZW1UWjZNUXhC?=
 =?utf-8?B?aFd4dDgraGVtWDFDZ3QzZnc0ZjlPZ0M0dUcwL050d0c0VGpjUC9tcmZ1Qmpp?=
 =?utf-8?B?dlo4K3plUVB0L3VSc0R6eUFIVlZndkc1UVZSanRMUGM2NWRyOXhQVzRVM3lm?=
 =?utf-8?B?dEg4RDVRU1dYTVI2dlZoOWN5WTVxT1hlNzRYc01wUlZyVnl3K2xXMVJ1MGFN?=
 =?utf-8?B?U0ZXL3lINlFoN2F6VmoyYlV0MTlTMUplc1Qyd0NUNnlySHZKajhjYXV6eWY0?=
 =?utf-8?B?SjZpL3Via0JTQTk2MnlYUmM2NEtVbVpKQTNKeFMrOEdGNEhJMkpTNGpBM1c5?=
 =?utf-8?B?dnRvN3ROVGhJRmF0QkZBNmxpb0N0Q1VTR3piUFlPUzROTE1wcm12R3Z6enpS?=
 =?utf-8?B?LytQaG5QdndtRkJPZmlrRWJGclNIZG1rS1FDS0NFM0JaQ29pMWYway9XMEl2?=
 =?utf-8?B?TU9ldStINHhzRUdJZER6cm1VRkNhVjM1aFVrbU9YTmhONmpvNkFJbXhWMFpF?=
 =?utf-8?B?RC82VXdNUkhTQXNxL3FaSDloaGNYTzVpWTRNbm1LMlUxUmVrVzVkSmJ1NERW?=
 =?utf-8?B?UjQ3L1dxNmd0ZlVYa0JOeUJQZnhRK1pncFVzcnpaazVTUVFBNUJCUThBOFlJ?=
 =?utf-8?B?cFcyQWQyZmlvWFhSV2FlWHpWYXArbTliVUFrWXlzMmtndDh3WWhCa2ZlRksx?=
 =?utf-8?B?RVQ1Y0pjRnRjQkZkRTFLR090WWhIOWxCVUFsaHA3Nk1nNnRuNSs2b1VLcWl4?=
 =?utf-8?B?T0o4d3dMa2V6cFhCeUlWcmhBdHFKMUxsZDA0N3locFB0MW9ZNmNXZW9lOHRW?=
 =?utf-8?B?QXozeld2N0FTcEFsVTFDVG44RVh3TzZ6dyt2dGRTNFhXL3IwM3ErVXlsMmJW?=
 =?utf-8?B?VnJNLzdXUTBVcFo2VDZ3OUNPOTB1ZTF2OXVBYzB5MTViQkJ0WDlVQTlDYUlL?=
 =?utf-8?B?Y2EzN0ZjRlMxSjdGWWdxTU9vWEdlZnhyVHVuM0hTaStQbnd1TlFTUmFETzdP?=
 =?utf-8?B?b2daRTVNUXF3bkx1ajVEdXpLNWhTSzhjVHdxc2pOWFNnbU14WWdJU3NQQUUv?=
 =?utf-8?B?bytGWnUyY0tTTDFSNlBHUXVFb01GckptQk5yVVVvWUJxV2hiZU1ydGNjNG9z?=
 =?utf-8?B?NUY2VDdvTm9JN2hva0k5RVZUNHVtWitzT2NDZkR3ZmRKbmoxdDdQK0xVR3hi?=
 =?utf-8?B?WDIxd2t2R2crQ2FhUFhBZVVtcDd1eXMzeEQ2NHdkOTZMOUprY1QrV2locHJw?=
 =?utf-8?B?WDFEUDhoTDI5Z3FVcVAyUXZlM3FFUVZ4UXh0bDNCVno2YVFaMFlkMEJaTnRz?=
 =?utf-8?B?dmxhVkFNUGcwTStBV1E3T0dLMTB5dityMDFzcHVqa2k3SjV5MGJ1c3ROTFFS?=
 =?utf-8?B?Tk5aVW9hZEFoYlVSZ1RlWkZrZVBVVEtEZysrTEJsN1Yzczc2Y1RWbkxXS1Jl?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F7AF7273A98A646B50A1A666357CAF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbc227b-9012-4d11-baf2-08dc3233d20e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 16:48:52.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eH1SXkWqGQTKVbE7q/vjtkd+jaZclsqDFafwuEb5FqTiOKMBUkd0b3ynnu/yCYpO/sRW52nutZ0g4YcbAfbkhbaiEjffucvcLNJeBnRIqjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAyLTE2IGF0IDE3OjExIC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gPiBEbyB3ZSBjYXJlIHRvIGNoZWNrIGlmIGFsaWdubWVudCBpdHNlbGYgd291bGQgc2F0aXNm
eSBzdGFydF9nYXANCj4gPiByZXF1aXJlbWVudD8NCj4gDQo+IFVnaCwgSSB0aGluayBhY3R1YWxs
eSB0aGUgYWxpZ25tZW50IHN0dWZmIGNsb2JiZXJzIHRoZSBndWFyZCBnYXAgaW4NCj4gdGhlDQo+
IHNlYXJjaCB1cCBzY2VuYXJpby4gSSdtIGFsc28gc2VlaW5nIHNvbWUgd2VpcmQgcmVzdWx0cyBh
cyBJIHRocm93DQo+IHRlc3QNCj4gdmFsdWVzIGludG8gdGhlIGV4aXN0aW5nIGxvZ2ljLCBidXQg
dmVyeSBsaWtlbHkgSSBqdXN0IG5lZWQgdG8gbG9vaw0KPiBhdA0KPiB0aGlzIG5vdCBsYXRlIG9u
IGEgRnJpZGF5LiBUaGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4NCg0KT2ssIHBsYXlpbmcgYXJv
dW5kIHdpdGggdGhlIGFkZHJlc3MgYWRqdXN0bWVudCBtYXRoIGluIGEgc2VwYXJhdGUgdGVzdA0K
cHJvZ3JhbSwgSSB0aGluayBpdCBpcyBhbGwgb2sgZnVuY3Rpb25hbGx5LiBCdXQgdGhlcmUgYXJl
IHR3byBnb3RjaGFzOg0KDQoxLiBUaGUgZXhpc3RpbmcgbWF0aCBmb3Igc2VhcmNoIHVwIGFzc3Vt
ZXMgdGhhdCB0aGUgcmVxdWVzdGVkIGxlbmd0aCBpcw0KYmlnZ2VyIHRoYW4gdGhlIGFsaWdubWVu
dCBtYXNrLiBJZiB0aGUgbGVuZ3RoIGlzIHNtYWxsZXIsIG5vbi0NCmNhbm5vbmljYWwgYWRkcmVz
c2VzIGNhbiByZXN1bHQgKG1vcmUgdGhhbiAtPmhpZ2hfbGltaXQpLiBJIGRvbid0IHRoaW5rDQph
bnkgY2FsbGVycyBjYW4gY2FsbCB3aXRoIHRoaXMgY29tYmluYXRpb24gc28gaXQncyBmaW5lIGZ1
bmN0aW9uYWxseS4NCg0KMi4gVGhlIG5ld2x5IGFkZGVkIGNvZGUgY2FuIG9ubHkgaGl0IHRoZSBz
Y2VuYXJpbyB5b3UgaGlnaGxpZ2h0IGlmIHRoZQ0Kc3RhcnQgZ2FwIGlzIG1vcmUgdGhhbiB0aGUg
YWxpZ25tZW50IHNpemUuIElmIGFsaWdubWVudCBtYXNrIGlzIG1vcmUNCnRoYW4gdGhlIHN0YXJ0
IGdhcCwgdGhlIGFsaWdubWVudCB3aWxsIG9ubHkgc2hpZnQgdGhlIGFkZHJlc3MgbW9yZSB0aGFu
DQp0aGUgYWRqdXN0bWVudCBtYWRlIGZvciB0aGUgc3RhcnQgZ2FwLg0KDQpTbyBpZiBpdCBza2lw
cyB0aGUgc3RhcnQgZ2FwIGFkanVzdG1lbnQgaW4gdGhlIGNhc2Ugb2YgYWxpZ25tZW50IGFkZGlu
Zw0KdGhlIG5lY2Vzc2FyeSBnYXAgaXQgd29uJ3QgY2hhbmdlIHRoZSByZXN1bHQgYW5kIGp1c3Qg
YWRkIGEgYnJhbmNoLg0KU2ltaWxhcmx5LCBpZiB0aGUgc3RhcnQgZ2FwIGZ1bGZpbGxzIHRoZSBh
bGlnbm1lbnQsIHRoZXJlIGlzIG5vDQphZGp1c3RtZW50IGR1cmluZyB0aGUgYWxpZ25tZW50IHN0
ZXAuDQoNCg0KSSB0aGluayBtYXliZSBJJ2xsIGFkZCBhIGNvbW1lbnQgY292ZXJpbmcgYm90aCBn
b3RjaGFzIGFuZCBsZWF2ZSB0aGUNCmxvZ2ljIGFzIGlzLCB1bmxlc3MgdGhlcmUgYXJlIGFueSBv
YmplY3Rpb25zLiBPciBtYXliZSBhIFZNX1dBUk5fT04sDQpobW0uDQo=

