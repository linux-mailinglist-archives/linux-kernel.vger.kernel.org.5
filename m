Return-Path: <linux-kernel+bounces-9668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453B81C94A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51A31F27216
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0817751;
	Fri, 22 Dec 2023 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVosRKd1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC146156D3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703245099; x=1734781099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KsrO1+cO3lvwJOJSUN3IvbHK+rcuE7NjoZRmTpOr16w=;
  b=lVosRKd1JT/imNA/6SK3tuc5OHXKAfdFrDrDj4ESZITCLXPYB3WiJozH
   umxcHkqM4iQmOSAEs8TUlcojyNaEH4IkK8GeC/A23/cUINjKSYVINrq3c
   hkhjxfm2E2in2R61RCH+8ReUQ2OsunO7j8OnPtj+9dTHvJMu9xJroIsr4
   ttJiWhU3PkUV3PWy++SG3FwUjiz4DGamTA95r7xOZpCNLevK/YXz8mjX6
   Q25ZX3E1BOds+dcy8LyczG5WmW7bCyqXVaMEzN5P8eTFpJVCSYzlBaKRO
   iz4qAbq9q0w8/0wdQnYEBgawc6y+pG1NjP+3nqBXJZeD33Fbi9E5Tw9P5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="427265715"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="427265715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 03:38:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="867615182"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="867615182"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 03:38:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 03:38:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 03:38:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 03:38:17 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 03:38:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL9m7lsO4f3/3lsvs3YqS9G0i6DA6pAjIBcw0rTMnaRkIiwgTgruKPFl1EA90HMWkX0g4YL3hhUWX+F4+HUpOt1R4bPnqtoKm4iBC0uHqFUgpvw8xwq+TC7ayxp/8cCfeWpoy9PcuOsiKEiUPmHWxx4sGETeK/uBLEUhOYu36BM9gDwvaitPm4PO6srrPastLpw3O6+Uwx/n5NAgAyDU5rqkK9W355Pl14zV4UES9igsUau90okkmaUsTaznhM4ceDLF5yV+nfNAwZd+MudraaiUo7eS7WJSAw/qUy6rXoy6GvG9dz5mSCDnkKcm0PP5es1QJyh5y8MzLSY26Vsw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsrO1+cO3lvwJOJSUN3IvbHK+rcuE7NjoZRmTpOr16w=;
 b=hLAE/lq1YOdS31vCYKLgk3Y/bF1B5TtNkaVKfeUecWEdL814i05F8/HsPFKnj3/NRK/mRfyJ/BmgR5m3fuZcTd1iSFC9PPoAWHYbdQh36V+1QIbZ3nHIX4mIUcJdLrYh5t8PLNXO1UR/gQUhapsPnCE0cP3Z5utJzE5+0I+wTsQ0azmwF/cTLsmZPA2yK+9zL0bcjLA0qN4PNnG401VMmmyJCAvBfepxovltasq7aDgHhf67nsNpjwDpD/dXCSvZsMrJnIiak+vD+Ch0rqJYLboLLJG22c+VHNsN3fP/wSIQODkqofBBiiOrFs4lOalF4bEALDdeh7KlwCory/hdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 11:38:15 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 11:38:15 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Topic: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Thread-Index: AQHaJxRg2LJJnT2of0eK3PTgcDCh0LCbWa0AgBnpsoCAAAUoAA==
Date: Fri, 22 Dec 2023 11:38:14 +0000
Message-ID: <bffb5c5c2468285aabf2ed47ce4c41db5b79f13f.camel@intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
	 <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
	 <3a080962fea97efbb8e102c1de34bc766d7a53b6.camel@intel.com>
	 <20231222111945.mqzacijpqnzbgxbp@box>
In-Reply-To: <20231222111945.mqzacijpqnzbgxbp@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|LV8PR11MB8509:EE_
x-ms-office365-filtering-correlation-id: 41cf3d83-af3c-4b50-3157-08dc02e27c40
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AHjFAXojN3p6rs8EFw5ugdrZimwFpH09Lw8uqwHAAlOodtpyYR27EBogF41p5mWVD2X5Zx8xXfMt7Zwd9boPxvD6+aIFE8Uyfhm3KomSlTmlzQ228A8aHBcME9bqQ4hzt2hSTWSyhBQqJESxnNgqKiYe1eriZvJDUlGucCnXL5rL4V5uPrjmwsp195fdOmfIPYfQiwUkSZSprIHOmk0IsuZ/vjDUILN/d5chUugRHUkyMto34ej3d7833Yf5mnP27aQk+8bAM10RlP1JHH5N5G75PphH2SleaHugqU06CN4cgJ2qFRHggzrrcM/yobTD581kr6cfpC3U3FIygJGvJ8dWxRTENdjT2epS9b0LeamQab6NEhyZXCUZcbgOs+4iykET/BG4w01McvdVSvHNKMsQi9aH1XAQn2M6nEgXkfiZowPEMQ8rzOp7JtFmHb1AljNRMZUZLhiwbM+LuFONFRfsUoe593qBv9hMosFgdrKDA+If9XY3SCL88tHxns+/EaHOncY14lbCmbmTKFOfJbhIP2edDZ4DIPFeOF6lXDOy+e1SI08h1ATfrs71/9PeB9L2uRqo1bhnfbb8RF3lzg2wuoXOFgrxLrs/CDqRPkPfSkQp9Dk8iWBuEWuqhch
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4326008)(8676002)(8936002)(122000001)(66446008)(66556008)(66476007)(91956017)(66946007)(76116006)(64756008)(54906003)(6916009)(316002)(4744005)(82960400001)(7416002)(4001150100001)(2906002)(41300700001)(86362001)(36756003)(38070700009)(38100700002)(5660300002)(2616005)(26005)(83380400001)(6486002)(478600001)(6506007)(6512007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1h6LzRUYlF2SXhZSFo3Q2s4QU5lV0hXRk5DUjRsS3ZPazEvQWNFYnRlRnBR?=
 =?utf-8?B?YW53QWNNVno2MDVYV1pDbUIyd2ZsMVhtRmRkOUVINkxjRURGRnB2NkozMFhG?=
 =?utf-8?B?bkhQRmU2NFYzakRCdFZiSzZGOWdUTm53TU9IYzV1bWlKMVRPK1ZpbzBnaktB?=
 =?utf-8?B?VXA3NDQvUGFIODBXM1h3enh0ejJpTWJPZ2hPUkJQODE2YXl3cCtYS3JkU0h5?=
 =?utf-8?B?ZTQ2bGh0M0d4cVhleW90SXdxaHlVNUZqSFpxcTJqV29yZnFyR0QwWSt1ZkZt?=
 =?utf-8?B?aFpvdVViTHRkKzZIQ3h1SlhlNGJNR25MTjlFaVBjMEl0UHhSYWVJSnhUNW1k?=
 =?utf-8?B?WTdrWFRGdDgrWjI3T3ZCWDFveVlURG9ReHpBMlFhUW5meGFXRkJtQTkzN3Uw?=
 =?utf-8?B?cjZMb2pEczRTQTBNYlI5akpGb0daRmRPMGt4RVY5RndEdm1OSjIrQnBQSVNq?=
 =?utf-8?B?ZjNkZFA3dWNLMU5tSVlkb3o4dFk2STVld2MrUEhqczh6OFF0bW1pYUo1cDE4?=
 =?utf-8?B?RXB0T20xTi8yS1NoK25TRWltdHJtZWI5aVVpUkk2VUJsU1RGQmd5NkRJQU92?=
 =?utf-8?B?bnlXOUZkRTlEc0graHZRZStJZkRDUVNHd3RiWFppdjIrcFlpdXFNWmgyelpS?=
 =?utf-8?B?OHlOYkxYUUpjMTZXb2E1bG50OWhLTDUzNHk3cjU4WHFOY3IySGJ2SjVqNmpP?=
 =?utf-8?B?Q0EySno0bnBUWTh0akVyVWVxYnNqMkV1QzFJNVhYY01Vb0VYTmlmRVlqRm1M?=
 =?utf-8?B?NUpOaVNFdXdtUEI5dExSTEl2S0RWcXIrcjZDSXRHZHBmRnVFa21wT01vQ3JW?=
 =?utf-8?B?WW50UXVjK1VPSFh4d1ZrMmdpcmJnYkZGNTk4MXMveVZzK05tQVJvajJvUkdT?=
 =?utf-8?B?bVlNaktxZ1dneVRFSURsTExHczRSWlZkRXZTRWUyUXlpaVFPL3YwNnkwWm1E?=
 =?utf-8?B?V1FadTFkZW95bUlWVkNOSE1RWXBSNy94NEZSWXdGZmtieCsvZ0hOMVc1d2xK?=
 =?utf-8?B?UHcvUzlJOGZZSlhxWjQ5RmFUa3UvQWpibTBXeFgvRnZXTDFuQ0h0VE1LWHhE?=
 =?utf-8?B?WXZ2SktmUkhGNTJKZGhTaTd1ZXREZUlMQW1RTWR2MmdrRW1EZndHbUYwSlpK?=
 =?utf-8?B?UlFRSk9UdGF0TVV5aGNUcGRJbi81OVpJSWNhMWMxYkJaOGg4c0FZMlJGbjRr?=
 =?utf-8?B?aWorWDZuYVpSeUd3ajhNbk5ncC9xVmgvaThwY2ZQN0JaaUN2MGdXMDFJSlRt?=
 =?utf-8?B?TmIwcm92QVlkSUlZZ2F6VUpQQnlCdzY4L1ZwbUVPZEgzU2xNa0ZiUDF5S2ph?=
 =?utf-8?B?RC9keHQxc2hKU3liUmNFLzh3SmF5SEVGQTlXYStsNjlIQk11RVZsVGU2ZVBM?=
 =?utf-8?B?bmxQMzQvS0lTeDFLT0VYMGZNYmJXOU1WNWpHc3E5ZzNObS9ydW5EaXNQd2Vq?=
 =?utf-8?B?aHZjQUNMRkx3WUdaNTlLWmdUcVBPc3ppVnc5WTdOSTVUT3BvMzZFV3o3STZ1?=
 =?utf-8?B?SXhmcXBrT1NEWkVhcXFIWkptYjlzSUp0WGtUY2VhMnU5MnB2ZWs5NlQxY1d0?=
 =?utf-8?B?M3FoT3loTHpobXhUSGlMRGFGUUZrc21KRTlRMUNNSHpaZ3hEcGtKUUZlazFZ?=
 =?utf-8?B?OW96UFMwTW9wYVZXcG1Zc1VnTlF0Y00wV1JZZ0NyMDRTaDd4Wm5FQWFRbnF4?=
 =?utf-8?B?MWJNUlJoM0UzbWZ1VFBBcUJWcHhvVEtkZWR4Mi9CWmdaL1ZsVnNyTDRDRVhH?=
 =?utf-8?B?TXI0OGR5eUtMWm40L0ZKNFJmeUJ5MFlQWTYvNVNLaDl1Sm1IaVF3OGJFWE56?=
 =?utf-8?B?VzV0UTRxQWpQTlJMaE44czJnTG12c2w4S1E5eHlCQS93c3paNWdWRUdYbGE4?=
 =?utf-8?B?VjZZQm53cFBwQmlWRkR6UzdvZTBVY3FxT0Y0c0djVEIxTm00V1lHOHhxVllH?=
 =?utf-8?B?emZjOVd1SHNNNDFQdVBacUZmYjFGUTQrWjV5bHhrMG9yQW5BSzVvVEdFenVD?=
 =?utf-8?B?V0FTSS9pMktLbkxER04yM2M3VnNkK0lGRXdaZmRmUlc2WmFCRU9lQTJCNHNK?=
 =?utf-8?B?Y0FKT1AvOW1NakIxd0RVdXM5ZG9hS0RDQ1dmNEVvaTVHSGo0MGxBNTUzb0t0?=
 =?utf-8?B?THRtNkhSV3RqbysxMlV0M3FSeUhub1R6bkxHUVdndGpRODIwd0c5UzlIdi9D?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA183A980F4A6F40A3D9E16187C72353@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cf3d83-af3c-4b50-3157-08dc02e27c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 11:38:14.9906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6SQJTdJ/VR5H93iorsMgXLu3cI5qSgxTSyIxz3r62cCHSwIDBBM9hnq53oRb84xL1ARZdq+mqdsikXZfjWg8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDIzLTEyLTIyIGF0IDE0OjE5ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUdWUsIERlYyAwNSwgMjAyMyBhdCAxMTozNjo1NVBNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyB2b2lk
IGFjcGlfbXBfc3RvcF9vdGhlcl9jcHVzKGludCB3YWl0KQ0KPiA+ID4gK3sNCj4gPiA+ICsJc21w
X3NodXRkb3duX25vbmJvb3RfY3B1cyhzbXBfcHJvY2Vzc29yX2lkKCkpOw0KPiA+ID4gK30NCj4g
PiANCj4gPiBJcyB0aGlzIGFuZCAuLi4NCj4gPiANCj4gPiArCXNtcF9vcHMuc3RvcF9vdGhlcl9j
cHVzID0gYWNwaV9tcF9zdG9wX290aGVyX2NwdXM7DQo+ID4gDQo+ID4gLi4uIHRoaXMgYmVsb3cg
c3RpbGwgbmVlZGVkPw0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIGN1cnJlbnQgbmF0aXZlX3N0b3Bf
b3RoZXJfY3B1cygpIHNob3VsZCBqdXN0IHdvcmsgZ2l2ZW4geW91IGhhdmUgc2V0DQo+ID4gdXAg
Li4uDQo+ID4gDQo+ID4gKwlzbXBfb3BzLmNyYXNoX3BsYXlfZGVhZCA9IGNyYXNoX2FjcGlfbXBf
cGxheV9kZWFkOw0KPiA+IA0KPiA+IC4uLiBmb3IgVERYIGd1ZXN0Pw0KPiANCj4gVG8gbWFrZSBp
dCB3b3JrIHN0b3BfdGhpc19jcHUoKSB3b3VsZCBuZWVkIHRvIGJlIG1vZGlmaWVkIHRvIHVzZQ0K
PiBzbXBfb3BzLmNyYXNoX3BsYXlfZGVhZCgpIGluc3RlYWQgb2YgbmF0aXZlX2hhbHQoKS4gQnV0
IG5hbWUgb2YgdGhlDQo+IGNhbGxiYWNrIGRvZXNuJ3QgbWF0Y2ggdGhlIGZ1bmN0aW9uLCBzbyBJ
IHJlbmFtZWQgaXQgdG8NCj4gc21wX29wcy5zdG9wX3RoaXNfY3B1KCkuDQoNClNlZW1zIHJlYXNv
bmFibGUgdG8gbWUuICBUaGFua3MuDQo=

