Return-Path: <linux-kernel+bounces-19069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73082676B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31851F216EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C197C15BF;
	Mon,  8 Jan 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWOe60hM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43810E9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704684625; x=1736220625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l48qRn8HLlnFNXg9ef3Df+z2ZWLQZ3r6kxxpOgoWxts=;
  b=ZWOe60hMh57wNPQ8cR2j8AG0ASPBtroLWl7TQ4kdH9xvRPm1HWzZDgT2
   P8E3juvKgLI3975xP/bkb1eEt6KHrImoLPG8M6RhKq++m5tBFfBrUrZUE
   U2LKocYnt2W87NSwgrB3JTI2vV4eF0MmIzSpsB9WWsgx8RbxmCTNQTjCO
   jm+BhZnuJo9FguRvrbS3DCgi7nIR7XDrwjZgIi4M2kqrQEUzsFQix463f
   TOAhDCjH19qFIXSz5rnP3XBUu4wl3hO4O6kJ/d8ZTEjKPqhZVX1E0ZoeD
   x3dbhUSDVOLPTckgvZLVEHAot4tiAb7NVxysgsx7Nro4rSzGletYYSODE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="396668220"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="396668220"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="23038695"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 19:30:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:30:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 19:30:24 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 19:30:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAcfjh9VdrBU6G3GzglKvlc9lwBvweCb9vdEjFIhN3y/5nGABfQe48zrN98sx+orSbDkth7OkdIhj0mP166jRnKmBH8n/KNUmmJ70n/dfWMe0docgs6HwS95WXtNUbBu4Hsl9kQeMxbONB7vp3abK18Xt4xqubAg78jmfnxtlFngsa3RIFMbtg8eat0HHxIFkCLK1E5or4ldGRmaWkFP/pUEuBrJExwRSmQFhijgfB6lEyW+6qXkIgUVv7IvB+PjeOyx4jrz2IP4kixEAqi7WAIB5zXFGE2eFFhNwpAVMSq7DhL5io5KADYdf3Ri34/HOWPgzo6CrY1GHJZeYXw3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l48qRn8HLlnFNXg9ef3Df+z2ZWLQZ3r6kxxpOgoWxts=;
 b=cGYlKekFInDbEEgp71HeHnJnWrQAz2NEverOl+Hpc8QD6BL+HAIcxuCgp5no9Jm/dgtQ7UbIJxWdrGWhwKobyC/uqkYFZdcFnX83Mk+taOGtKv4GF8f6ewGSz9Ao1d3o+NeIouk5qORuwNmH6b7gjbG9eAWRlRJPfqPX4sYWClw6gwolxf43bNjtxRhbhSHQ7hmjMyXb/N6q0jhvWtmqNIUPw3js4at5NwxThwxH316ODMgO4MA+Qtmfwhi3e+wMdZTSZjAxunD5VhsKYiH4YeXD+D7RdyIO2EqjFYBP8dGJkM2CfpykU2rcC4MHiepzATRc5PuN5fpQQlNr8hCJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7937.namprd11.prod.outlook.com (2603:10b6:610:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:30:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:30:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Edgecombe, Rick
 P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Topic: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Index: AQHaNTH0QWBZ51600E6mdH8oHBHhWbDPVskAgAAE0wA=
Date: Mon, 8 Jan 2024 03:30:21 +0000
Message-ID: <3bddc0a0d69b6b18ce3fd568e6a7e6d7be8a1a11.camel@intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
	 <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
	 <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
In-Reply-To: <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB7937:EE_
x-ms-office365-filtering-correlation-id: bc43043c-4764-4c1b-d079-08dc0ffa24ee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owWU2ao9neSXpJCONX8KgaxxVOcPQie0H/awAA1DlmBtL57dW8k+JKz3toy7Ir8bsVJ9P8nOR8+u4LS8/1pMU/xz+q1mU2hvhljR1qHZIlo6ItYJcakP4wYGYArPHYQXKx4y28GJy0siVhYJN8hsdulj/4VdLpv+HD46h4k4+g8KOixKYxnkH2geb2SWi+R0svSpBnIPS/VAG4HJdUWdtwLiusGCTfgRD1bDWVzT9EvhdA2DCZVTCw0l2cuX+1seyPUk0Uyd31ag5TsFXuOP5JTlVv2Xg3NGASt7ujcWGu1S7M9/crTH1dJgQtNYjX7F2B5L6us4VhTDfNcziTezvjU9KLYZfZ49UWNWpjdEHxiIprMvNxTnM0LJwtKNWfHU4Jo6SKfJjoYxZiWsYC5dHOz8YhFj800HnUW0rleVpQ+fZnVqJwbn1bCygGogy3/wcYapOW9k7XUWsDkPo/cYJmjOe/mBsyZYXFGAg6Zdk40PR6wgBU8fzykxBx1YhxbASNS9RKHvUnmeRMaGmdTLRaF1SKLef4/THdFGT7iLVmjlj8DL7EH1FUwNPu9HbcmPqddFIFqlQk/JywKGDhK7wwnkuutsGcVJo4jIyPqmu7OqSPxUSWWw+rnIlzZtjAcX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(5660300002)(4326008)(6506007)(6512007)(38100700002)(2616005)(122000001)(82960400001)(6486002)(478600001)(71200400001)(110136005)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(76116006)(91956017)(8936002)(8676002)(36756003)(4001150100001)(38070700009)(41300700001)(86362001)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFV1Q0pvK1QvWWIzZGxUenNlTE84YmNGZGo3a1N3ako1MzZuTi9KMDBqQzVY?=
 =?utf-8?B?RUxBVWVUUFYxZFNaUzk2SFhpbHcxU3F6VTJ3NThzZFJtZklkOGRyZ0V6RmYv?=
 =?utf-8?B?REtyalZGdnZ3V2xwWndjMGJPbTBCM2hUR2JIakJMSnJkaWVHdGNpdHY2ei90?=
 =?utf-8?B?WGN2K3hBdzJpUnNSWlhUMHhXT3VFT0dzQ3QyWXMzMjZRUFZEYXV5aW9vN0ls?=
 =?utf-8?B?TVlZZ0hqWVRyaStVMnplSWtjbTZOY3Z3SHJ6MlE2L3BVUURrcXhZZk90VTdQ?=
 =?utf-8?B?WDVWWVo1NVNETjVBUVhxRVpkQjl2NkV2VVZmRkg2YXkxdUZQb2UxR3NRckxH?=
 =?utf-8?B?SWxNZnFHcmx1YkFDK0dXbmdnbzVSR2dZaGVVeFMvMnNKQmFUTjlMRFgrdTI2?=
 =?utf-8?B?Z2RjRFBZRUFHOWpZUlVLQWtQam9IVXY2dVZoVXZXYmxCVHB2T2JYNUk0ZmJ3?=
 =?utf-8?B?bm5BS3BrNHRrRWQvNC8zSWxSajhFOG9VVEpkNDBFTWc4djFVMjVIVHYzdE80?=
 =?utf-8?B?dDhyUjZIYmwrM2ZsVC9sWEZXTXh1b1NRWUo4TWtnaTlLYnhUMGViR21FdjQ2?=
 =?utf-8?B?R0J5VmJyd3U4c2d4aGZpVXhIeWs4UzJ0S0pSQ1d2RThPdldqQzZjTys5VkQ2?=
 =?utf-8?B?ZXFOa1d6L2lCN0R1ODlyVDk2eU5hSitoUjRhRkppZ0g1ZTgzWTNsRThVY2Vw?=
 =?utf-8?B?YVJjVHpSYVpNc29zSHg2cmxERDZGVkl3djMzRk4xazRQaG14MEsyZXI0d1dt?=
 =?utf-8?B?QU93b0t6NnVSZTR5RGw0eUNHNmxjSXBLOXJ0UklmbURVbUMwY09mb0FWRGdl?=
 =?utf-8?B?UGJJQjJ3cTQxRWZrNndlOVJxNGh6RHA4RE9GVGY4bytFdUgxVDZrOUJFNEpD?=
 =?utf-8?B?RnlTVzlwUXhRUmxUaXIyMVJMR0g0ODdUY2NuRTl5NHk2WDVCOU91RjEvenh5?=
 =?utf-8?B?SE1sY2hrZ2lYaTM0MFdRdWpMUUJnTENiZFlrZGhEYWQ2K3h1OGFrdkxiMkpk?=
 =?utf-8?B?L2dVMjQyWXhzL3pBMkxXcnE5NERYcmo0U2JnOWxjVS9RRHdveWlTRUtFdVhO?=
 =?utf-8?B?R2s1QmllQnpmSTVtZUtIbjJDaDVtVHVxQlFoZ3R3Y0oyZU9PV3gzNFhNWnRI?=
 =?utf-8?B?YloySzEyZkh0TmZHZkpnY25LM1FHTDkrcW1mdnJSdUYyMk1XMi8reitySnEr?=
 =?utf-8?B?ZmdPZWVZck9zNlpWbWNmT2J4OVYzNEhPR1NydWNqMkpYOVpjUWxxVzRSZldr?=
 =?utf-8?B?djFhbEdhZmxmZTNkN0NCcFB3ZGV2Y0hKZ01wNzBpRGRKR2lTbkpyMzdKYlN2?=
 =?utf-8?B?SmcrYXlvVVB6a2pIblhmK295YTR6MW9kbFVCczZXUDlXMHUzYTQ4MjBUYVRx?=
 =?utf-8?B?MitBT2hpdExsbndaZGhsdVVQWnM3eGdZbStHc2JFdkNRZ2pUL0tZNlJWaEVD?=
 =?utf-8?B?ZHE2RlJ2amdQaUxSeFdvbHFFMUFTVGY5M0hUV0pqVnE0TmMxNkRDQ0NCemly?=
 =?utf-8?B?QWpDSVZLM2I1Zk5BUTNqVUtKekExbkQzbEI1L3phSzZrR2MzODg3VkIxcTQ1?=
 =?utf-8?B?ZTZ4QW5OVUpPM3FGS2lvRzkrbkprZXhJVm9yeXhxdGY3cE9vUjNwVytBOGdM?=
 =?utf-8?B?bmNaQkZGSFp0bjhIb2hlVWg3STdyL3JCc2VncHd4UlZZN25GUWRkR01lVnNB?=
 =?utf-8?B?NmhCbm8xRlFlZG9ZNzY2dlBzR05rL1hudW10UnVlSkRZdVlqbG5ORUtxY29Q?=
 =?utf-8?B?Z0YwM2h1TEFyTzYwWFpnWm9aVHRUclBvSmZicmRzeUcvSHg4U0xMZ2FCVlRs?=
 =?utf-8?B?QVlmZ2FjS0FaRnM1eU5ERG0wc1A0Z2JKS1U3dDI1S2dtd1hkNVd4NVp0RWhM?=
 =?utf-8?B?Vm9YYzJFdWR4VDBnUnBEYWVFd043V1NkaVhmZHFTdTAvbkNOeU5GOTB4ZmRh?=
 =?utf-8?B?SjBnTXhSQ3pJMkJHM1RvZWh0M3doYS9KQXJQMjlZZ3RlcHhhKzNkbGt6czln?=
 =?utf-8?B?OUt2Y29CWllROVRTdzZYVGRjVjgrNnpNQjVtMld1OEZmb2t5YlcrOEFyUTVZ?=
 =?utf-8?B?bDBZbXNTSGJraVQ1Qkc2T3FvL015TXVkb3VyWTNQOGV5Q1YrL3hESW9NMHhG?=
 =?utf-8?B?Z3d1RndQOFdyNVVtYk16YUUzQzF1RC9rbGZZdnhmQzk1WngwMEJJQ3dydkE1?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CEAC940AF27F142882065C7EB5950B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc43043c-4764-4c1b-d079-08dc0ffa24ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:30:21.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcgpQ+e2b/wQKtZXXQwPImPDCGzNSYqwk9T8WEDtzq7tZgZGoAQMGmaBKcMGH6ZOEjdgn8yn7LfQD0J51AxHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7937
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAxLTA4IGF0IDAzOjEzICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBTYXQsIDIwMjMtMTItMjMgYXQgMDI6NTIgKzAzMDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90
ZToNCj4gPiBUaGUgaGVscGVyIGNvbXBsZW1lbnRzIGtlcm5lbF9pZGVudF9tYXBwaW5nX2luaXQo
KTogaXQgZnJlZXMgdGhlDQo+ID4gaWRlbnRpdHkgbWFwcGluZyB0aGF0IHdhcyBwcmV2aW91c2x5
IGFsbG9jYXRlZC4gSXQgd2lsbCBiZSB1c2VkIGluIHRoZQ0KPiA+IGVycm9yIHBhdGggdG8gZnJl
ZSBhIHBhcnRpYWxseSBhbGxvY2F0ZWQgbWFwcGluZyBvciBpZiB0aGUgbWFwcGluZyBpcyBubw0K
PiA+IGxvbmdlciBuZWVkZWQuDQo+ID4gDQo+ID4gVGhlIGNhbGxlciBwcm92aWRlcyBhIHN0cnVj
dCB4ODZfbWFwcGluZ19pbmZvIHdpdGggdGhlIGZyZWVfcGdkX3BhZ2UoKQ0KPiA+IGNhbGxiYWNr
IGhvb2tlZCB1cCBhbmQgdGhlIHBnZF90IHRvIGZyZWUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0K
PiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pbml0LmggfCAgMyArKw0KPiA+ICBh
cmNoL3g4Ni9tbS9pZGVudF9tYXAuYyAgICAgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pbml0LmggYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9pbml0LmgNCj4gPiBpbmRleCBjYzljY2Y2MWI2YmQuLjE0ZDcyNzI3ZDdl
ZSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pbml0LmgNCj4gPiArKysg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pbml0LmgNCj4gPiBAQCAtNiw2ICs2LDcgQEANCj4gPiAg
DQo+ID4gIHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvIHsNCj4gPiAgCXZvaWQgKigqYWxsb2NfcGd0
X3BhZ2UpKHZvaWQgKik7IC8qIGFsbG9jYXRlIGJ1ZiBmb3IgcGFnZSB0YWJsZSAqLw0KPiA+ICsJ
dm9pZCAoKmZyZWVfcGd0X3BhZ2UpKHZvaWQgKiwgdm9pZCAqKTsgLyogZnJlZSBidWYgZm9yIHBh
Z2UgdGFibGUgKi8NCj4gPiAgCXZvaWQgKmNvbnRleHQ7CQkJIC8qIGNvbnRleHQgZm9yIGFsbG9j
X3BndF9wYWdlICovDQo+ID4gIAl1bnNpZ25lZCBsb25nIHBhZ2VfZmxhZzsJIC8qIHBhZ2UgZmxh
ZyBmb3IgUE1EIG9yIFBVRCBlbnRyeSAqLw0KPiA+ICAJdW5zaWduZWQgbG9uZyBvZmZzZXQ7CQkg
LyogaWRlbnQgbWFwcGluZyBvZmZzZXQgKi8NCj4gPiBAQCAtMTYsNCArMTcsNiBAQCBzdHJ1Y3Qg
eDg2X21hcHBpbmdfaW5mbyB7DQo+ID4gIGludCBrZXJuZWxfaWRlbnRfbWFwcGluZ19pbml0KHN0
cnVjdCB4ODZfbWFwcGluZ19pbmZvICppbmZvLCBwZ2RfdCAqcGdkX3BhZ2UsDQo+ID4gIAkJCQl1
bnNpZ25lZCBsb25nIHBzdGFydCwgdW5zaWduZWQgbG9uZyBwZW5kKTsNCj4gPiAgDQo+ID4gK3Zv
aWQga2VybmVsX2lkZW50X21hcHBpbmdfZnJlZShzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5m
bywgcGdkX3QgKnBnZCk7DQo+IA0KPiBNYXliZSByYW5nZS1iYXNlZCBmcmVlIGZ1bmN0aW9uIGNh
biBwcm92aWRlIG1vcmUgZmxleGliaWxpdHkgKGUuZy4sIHlvdSBjYW4NCj4gZGlyZWN0bHkgY2Fs
bCB0aGUgZnJlZSBmdW5jdGlvbiB0byBjbGVhbnVwIGluIGtlcm5lbF9pZGVudF9tYXBwaW5nX2lu
aXQoKQ0KPiBpbnRlcm5hbGx5IHdoZW4gc29tZXRoaW5nIGdvZXMgd3JvbmcpLCBidXQgSSBndWVz
cyB0aGlzIGlzIHN1ZmZpY2llbnQgZm9yDQo+IGN1cnJlbnQgdXNlIGNhc2UgKGFuZCBwZXJoYXBz
IHRoZSBtYWpvcml0eSB1c2UgY2FzZXMpLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8
a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gDQoNCkFub3RoZXIgYXJndW1lbnQgb2YgcmFuZ2UtYmFz
ZWQgZnJlZSBmdW5jdGlvbiBpcywgdGhlb3JldGljYWxseSB5b3UgY2FuIGJ1aWxkDQp0aGUgaWRl
bnRpY2FsIG1hcHBpbmcgdGFibGUgdXNpbmcgZGlmZmVyZW50IHg4Nl9tYXBwaW5nX2luZm8gb24g
ZGlmZmVyZW50DQpyYW5nZXMsIHRodXMgaXQgbWFrZXMgbGVzcyBzZW5zZSB0byB1c2Ugb25lICdz
dHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5mbycgdG8NCmZyZWUgdGhlIGVudGlyZSBwYWdlIHRh
YmxlLCBhbGJlaXQgaW4gdGhpcyBpbXBsZW1lbnRhdGlvbiBvbmx5IHRoZQ0KJ2ZyZWVfcGd0X3Bh
Z2UoKScgY2FsbGJhY2sgaXMgdXNlZC4gDQo=

