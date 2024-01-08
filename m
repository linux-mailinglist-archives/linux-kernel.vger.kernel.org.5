Return-Path: <linux-kernel+bounces-19598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A7826F69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54BF3B22023
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3841757;
	Mon,  8 Jan 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjsgNjJD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8045E41745
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704719607; x=1736255607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LRY/+RTlVs9q5aDeVvVsbxeGiXv8oALAqjAtxh69h0E=;
  b=gjsgNjJDVdIX3EnBlZhhySESsE8ndOMPiLEul7Yii+MLusWBdr5HGx4e
   WWYqiEjTuuby5Bt5ZOx5hqkYmaz3C2mUUSkfruplY2vfCTLWI8hFQfn3U
   QNgnc+C5oUnUbBxoNdLkW7txP8wKGUIjEGIoZfc1GvDlrfEvR57KF6arr
   9Tj6xah5zhiRAywuElSVkk5LGy2mHS6LQR+nSS4QfRWI8NcrTqPLIQUIr
   90gL7FLn00bPTCHkrAUgw+mRRvSyKbaUee2LC/xRskrTF1KNZXI8yjtgt
   umwwWDkDU8dB33lgK6MpjWhUKPDQJsUS/lQUpKioZu7eFeXKq0gDz6tQF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="4631629"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="4631629"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028396968"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="1028396968"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 05:13:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 05:13:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 05:13:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 05:13:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7MTi9olwB7DKjYSaQB7Q3S0cW95f9AW5QBzYuByREjNt7VA7wZudW1ZBIQJUtmWSeAcrEupiRDSPTH3Y5Lxw1Pa58aQxrtSoPpG5odxe7zCo7mMjPGrxDMORxjNjL8PBn1erN99czk5/llBn6lWEhgLkyYJtjkcnzBzmpVGngAdscUIT3CZdzKNIpcvLODTuwG6amCuRnb+wmNP1fIMfjfv33znx+bxwwc8WeN9PHnG9OUA64O1tFQUhgTJCLIbH5US4XyR7TOIYSQ2E3rjXfEw26FdCFxPCa8fVHOIMocgJ56m36G2SInq8Rve4oEXAZRez4UvJEGgiH1A4gvSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRY/+RTlVs9q5aDeVvVsbxeGiXv8oALAqjAtxh69h0E=;
 b=HjrnTZtLt5QQ+AQWyZT77Px5+tnsph9dWChl/fZTMjiiEP9uZjW+0SSR93ufeazdaLyU6xwq7cRt7HLeowi+mH/g0doedLb7IyZwiH3ZRt4nhdl5IVBRlfiZZDmHEX80iafX6Vr2CJoGrE4er9GNKjT6ctPmocCiQp5UF5f3VOEhUoNY64sYujV7x43ZKXJfb18gYNXnvBFkD5WP2OHa+j6viHkg4JxiFmUv1sNh+9BTBW/zsXz0pZSLKvPcWc86XV/42dc9/UaoF2JpbQm+X/zdnImUB16fLAnl3LB9WaG336D/GCZSg1XrnNnlHn2wg9rELiuv8Gube+zUDE6NPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5458.namprd11.prod.outlook.com (2603:10b6:610:d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 13:13:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:13:18 +0000
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
	"peterz@infradead.org" <peterz@infradead.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Topic: [PATCHv5 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Index: AQHaNTH0QWBZ51600E6mdH8oHBHhWbDPVskAgAAE0wCAAHG0gIAAMS0A
Date: Mon, 8 Jan 2024 13:13:18 +0000
Message-ID: <b0dcc7016e6810791fa0aedbe7728a5deab29f5b.camel@intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
	 <20231222235209.32143-16-kirill.shutemov@linux.intel.com>
	 <ba8265977a4b30f48b6b33fb135b714d5ada2a52.camel@intel.com>
	 <3bddc0a0d69b6b18ce3fd568e6a7e6d7be8a1a11.camel@intel.com>
	 <20240108101715.7hxn3wj6njemsf2x@box.shutemov.name>
In-Reply-To: <20240108101715.7hxn3wj6njemsf2x@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB5458:EE_
x-ms-office365-filtering-correlation-id: bbd00fbf-f1f2-431a-e1df-08dc104b94f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZ2/LC28kaNKNcOtfgEdKTIPtJmgLe4evHRknn8SDLMLVgC5DIkCpnTKLKNPvSbQnb0ZGVfOpd9ZQ4QCjBtsYfSvWe9FkqZLE0G8RIGGYuvfSQqN8k9XP3btFrNamjbqaGvfy3+d3E3rpnhi5cMlLLQXUPncYxHONjPoPVbBtNrfv6QTWxl6XJNIh8S1IdI42l3/6aavopLN8948j92NaNeBi3EUhEQwu0E0ALSnQtKZV0RF/vDhYt3wxd897rShBlFlMUcza+9hCopcFpTv5Asxf2AcMEuXltRIgYSewtFIY11sldAjZa4Z1d4yx4QUIBGMnSCsy3BOPOa8TBWNdYUIwIYyWpgzfNev7EVTPGxNdQtmsKLqWExkYISuLdCnA6WbYElY9AdiRkOfIv7rRexPNuUeK+x7MDoPmZRWfySi1sNimUGXAYU7kL7cyg6anVd3r+qhdfK7r1OzvXS7UDgUuXKm+RocmJI/E0JffZ6mmuv+yjroxjOgwmRNeWFRI/Vja91NSYXSirMr38L9wYeNDWAusn7oM+DLdcfU+QduXygrNTXKNblSZ4s+hv1YfEy+tkk1hAdE6XvMs8rtuOmjERsZVDQK+k0Kwu88mZxT7CHxBfRXbFekvlIKRfV7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(54906003)(8936002)(8676002)(36756003)(71200400001)(6506007)(4326008)(66946007)(66556008)(91956017)(76116006)(6512007)(2616005)(6486002)(478600001)(64756008)(6916009)(66476007)(26005)(66446008)(122000001)(4001150100001)(7416002)(38100700002)(2906002)(38070700009)(5660300002)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cklQejVFd0orMUtMTk5wR3RxMnRYdGQrTG5CTVplNjJTTzZlUEhZcVU0TU8x?=
 =?utf-8?B?dWtVanZ6KzJuT0h6Q0JwblA0dkl3Vm5GdnNaMkk5ekplanBhYnJtekxWTWFL?=
 =?utf-8?B?TXpDZGtFRC90VkJ3ODdoZWUveUtXU1Vpamd5R2taZ2dpa2E5OTdBa0tSa3Rw?=
 =?utf-8?B?Tlk1ZWNiMWl3bk5tK2dVSHN5eGtaVlpNTm95ZDRmME1WelhpN2Yyd0l4RTc3?=
 =?utf-8?B?K0w0dnRZTUMvYlpBcmtScnVXaCtRUnltcGllRm5lcnlUMFBGMkxQc3IrN0Qr?=
 =?utf-8?B?UGtWWndNZkdUa3RVNmRTN2h5TTQ2VU9LWEtSOXBOSDIwelNUUTNxQlZHbXZv?=
 =?utf-8?B?bXo1Q0RuMWFSd1lIaWxBUVIxWVptbzNmZTkrSDlsN2pkRUhxME1oL2RYb3ZL?=
 =?utf-8?B?V1ZjVWl6U0V4N3RwTi84bjMxVitjVnlpSDNrYjlvcjVjTTNNYkNiZDhHdFBL?=
 =?utf-8?B?YmRTTURwaitqOE1LNHRtd1YwLytyQ0lTNmljdytUSGp5OXZ5N2lFSVlwK3Rw?=
 =?utf-8?B?bHVaWDlXOFArVDVFRUVSamlzU0loTjBoR0VkOUgzNjZVKzVsU0hoUjhhMGk0?=
 =?utf-8?B?ejdpUGh3YXNPczBpejVmeklEUExSNEY0SVJHcitrQzFZSnMyVUNoVCtXN0ZN?=
 =?utf-8?B?VHloUHNlUlJ0T1Z1cDJONitqSnpzZ251cW1EdG5kVWZvQkkwcXRnZGtBQUpJ?=
 =?utf-8?B?d0IzOUxKdGhpciswY0ViRVdOYUJVQmlScy9HQkNxdEowbjJBNVZKa1UxOXdW?=
 =?utf-8?B?Z2h2dXFUSElQeGdUOFFxZk0ySHdEMS9talJKZ0hRTjB0Q0JkNWRld24vbzAr?=
 =?utf-8?B?ajdLY3hPUmlwTVV5cHRhUTRnRTZaWWhKL2ZPYUIvdFEwb1dYdS9GUmZBRm9z?=
 =?utf-8?B?c3BPQ3F0ZUpKMjE4S3lkQWJPR1I0NjJhRkUxNklibHpUeDNQdVVMblByM1pD?=
 =?utf-8?B?R0pKZmFtYkFpd0ZyTTh1VGMwZjFPNThGOTZZQW9IVTJUVDVQV216dkJkNEdG?=
 =?utf-8?B?SlpXWmYxSVk5V1FOdkh1VXRDdW9IL2xQeE5TUkVaZVNBaXN6WDRaWWxza2xD?=
 =?utf-8?B?Rm1WOWRyVHd6WGQyQVdNRlIyb2pjWUt0Rkcvb2QrRTI0aGNvYVZobWlqc2pV?=
 =?utf-8?B?TDN5bCtOWmwrQU5qNW5uSDZGUHI3bjIwQm1kVEVpcldYQkhCMUlWODBnTjhL?=
 =?utf-8?B?dEJ1RWZkRy9xWmJBYVVOeHRTZElBUHZacnVPYk9XMWI3dzg0WVJQbUkwemha?=
 =?utf-8?B?NVF4b1Iwbk1LdFErQ1NqeU9YNTVnVGlra2tOU2ZqK2M5bzVpZ01hZ2JRMmxm?=
 =?utf-8?B?VDRpWmJIZVlyT0xzWGNqaFU0NTVTcWVvRWpPTDVScTJqQUxhK2pwUlZyQXg4?=
 =?utf-8?B?c0paeTdHUjBmZ2xYSEVnNk9kcGx5TmNyVGF1bWFGQ2FyV2k3Rk5hQ1NCWWJK?=
 =?utf-8?B?TDhEMEdnK0FsUVY3UEV5NWsxWGZnR2lsNXFjZ29xakE5VVZScmVEdWc3WFRa?=
 =?utf-8?B?eUtubUx4WEhsK01tZ21GYnBiSHYzY2h2K1dUQytyRDY2cWZzTE03YnVmRXV4?=
 =?utf-8?B?R1QyTk9qYXRTMXR4eEdSYjU2Y0NveFJyeTQ3aFNMejNRdS9oVEFKVEI3WDhS?=
 =?utf-8?B?RkVHUjZlS3NMRWtyNGVUcy8zalArTm9ZamNZakpVS3lFZ29CalQzZVUvVXlC?=
 =?utf-8?B?NWlseFZuQlNQaThhWVhSYWp6aTBHcWpDWnlma1lmenhRUFhxSUJGb0dweEhl?=
 =?utf-8?B?b1JxSERnaTZxcjBPdXoyQ1dLWHVneUl3TnFQWk8zb1h0OWluNXlua3dUTDR6?=
 =?utf-8?B?ZUl0bjlHSWdiU0JwblBjTFlTTElsVFllakN2bmlYdEhMKzNGU3RheVFqQUNF?=
 =?utf-8?B?bVFWOTBjSVVPU1dxSHdlRDJGT09wNjljUW54a2ZqbzJTalVUQVh0U2xUYk13?=
 =?utf-8?B?Uk5yNmZSOWl4ZHZ1Z09PM1pxdmtERTNzY09SWlYzc1J6ZjFjWi9NYVN6U2V3?=
 =?utf-8?B?OWhCdmF1RnozejZrNE95V2dCUTFuZ01JMWxXWUt2VUhYZjVONlYxdVBRWGFn?=
 =?utf-8?B?Ny9pbXdFT1VJQUxGOUJsL2hLV0NqcURZLzBPTXhVSDVHTm5VN0ZCSjNwNUVv?=
 =?utf-8?B?T1l0NHIzeFNma2NNSHUvM29FcWNUQ0JTSTJIbjZ4aXJBN3NxcnhkTjNtWWpR?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <938BAC25DCEE564DBD1A12264E39ED06@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd00fbf-f1f2-431a-e1df-08dc104b94f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 13:13:18.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9M0cCQHozmHEf0CuuUhrufeQXmpXfg4pAuurxKIyTJTzIBdKsCYAN8e0IVVFOsYXtHkoMDUrmeL0kHoBMCnNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5458
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAxLTA4IGF0IDEzOjE3ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBNb24sIEphbiAwOCwgMjAyNCBhdCAwMzozMDoyMUFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNC0wMS0wOCBhdCAwMzoxMyAr
MDAwMCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiA+IE9uIFNhdCwgMjAyMy0xMi0yMyBhdCAwMjo1
MiArMDMwMCwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+ID4gPiBUaGUgaGVscGVyIGNv
bXBsZW1lbnRzIGtlcm5lbF9pZGVudF9tYXBwaW5nX2luaXQoKTogaXQgZnJlZXMgdGhlDQo+ID4g
PiA+IGlkZW50aXR5IG1hcHBpbmcgdGhhdCB3YXMgcHJldmlvdXNseSBhbGxvY2F0ZWQuIEl0IHdp
bGwgYmUgdXNlZCBpbiB0aGUNCj4gPiA+ID4gZXJyb3IgcGF0aCB0byBmcmVlIGEgcGFydGlhbGx5
IGFsbG9jYXRlZCBtYXBwaW5nIG9yIGlmIHRoZSBtYXBwaW5nIGlzIG5vDQo+ID4gPiA+IGxvbmdl
ciBuZWVkZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgY2FsbGVyIHByb3ZpZGVzIGEgc3RydWN0
IHg4Nl9tYXBwaW5nX2luZm8gd2l0aCB0aGUgZnJlZV9wZ2RfcGFnZSgpDQo+ID4gPiA+IGNhbGxi
YWNrIGhvb2tlZCB1cCBhbmQgdGhlIHBnZF90IHRvIGZyZWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5p
bnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vaW5p
dC5oIHwgIDMgKysNCj4gPiA+ID4gIGFyY2gveDg2L21tL2lkZW50X21hcC5jICAgICB8IDczICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgNzYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2luaXQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2luaXQuaA0K
PiA+ID4gPiBpbmRleCBjYzljY2Y2MWI2YmQuLjE0ZDcyNzI3ZDdlZSAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vaW5pdC5oDQo+ID4gPiA+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2luaXQuaA0KPiA+ID4gPiBAQCAtNiw2ICs2LDcgQEANCj4gPiA+ID4gIA0K
PiA+ID4gPiAgc3RydWN0IHg4Nl9tYXBwaW5nX2luZm8gew0KPiA+ID4gPiAgCXZvaWQgKigqYWxs
b2NfcGd0X3BhZ2UpKHZvaWQgKik7IC8qIGFsbG9jYXRlIGJ1ZiBmb3IgcGFnZSB0YWJsZSAqLw0K
PiA+ID4gPiArCXZvaWQgKCpmcmVlX3BndF9wYWdlKSh2b2lkICosIHZvaWQgKik7IC8qIGZyZWUg
YnVmIGZvciBwYWdlIHRhYmxlICovDQo+ID4gPiA+ICAJdm9pZCAqY29udGV4dDsJCQkgLyogY29u
dGV4dCBmb3IgYWxsb2NfcGd0X3BhZ2UgKi8NCj4gPiA+ID4gIAl1bnNpZ25lZCBsb25nIHBhZ2Vf
ZmxhZzsJIC8qIHBhZ2UgZmxhZyBmb3IgUE1EIG9yIFBVRCBlbnRyeSAqLw0KPiA+ID4gPiAgCXVu
c2lnbmVkIGxvbmcgb2Zmc2V0OwkJIC8qIGlkZW50IG1hcHBpbmcgb2Zmc2V0ICovDQo+ID4gPiA+
IEBAIC0xNiw0ICsxNyw2IEBAIHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvIHsNCj4gPiA+ID4gIGlu
dCBrZXJuZWxfaWRlbnRfbWFwcGluZ19pbml0KHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvICppbmZv
LCBwZ2RfdCAqcGdkX3BhZ2UsDQo+ID4gPiA+ICAJCQkJdW5zaWduZWQgbG9uZyBwc3RhcnQsIHVu
c2lnbmVkIGxvbmcgcGVuZCk7DQo+ID4gPiA+ICANCj4gPiA+ID4gK3ZvaWQga2VybmVsX2lkZW50
X21hcHBpbmdfZnJlZShzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5mbywgcGdkX3QgKnBnZCk7
DQo+ID4gPiANCj4gPiA+IE1heWJlIHJhbmdlLWJhc2VkIGZyZWUgZnVuY3Rpb24gY2FuIHByb3Zp
ZGUgbW9yZSBmbGV4aWJpbGl0eSAoZS5nLiwgeW91IGNhbg0KPiA+ID4gZGlyZWN0bHkgY2FsbCB0
aGUgZnJlZSBmdW5jdGlvbiB0byBjbGVhbnVwIGluIGtlcm5lbF9pZGVudF9tYXBwaW5nX2luaXQo
KQ0KPiA+ID4gaW50ZXJuYWxseSB3aGVuIHNvbWV0aGluZyBnb2VzIHdyb25nKSwgYnV0IEkgZ3Vl
c3MgdGhpcyBpcyBzdWZmaWNpZW50IGZvcg0KPiA+ID4gY3VycmVudCB1c2UgY2FzZSAoYW5kIHBl
cmhhcHMgdGhlIG1ham9yaXR5IHVzZSBjYXNlcykuDQo+ID4gPiANCj4gPiA+IFJldmlld2VkLWJ5
OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo+ID4gPiANCj4gPiANCj4gPiBBbm90
aGVyIGFyZ3VtZW50IG9mIHJhbmdlLWJhc2VkIGZyZWUgZnVuY3Rpb24gaXMsIHRoZW9yZXRpY2Fs
bHkgeW91IGNhbiBidWlsZA0KPiA+IHRoZSBpZGVudGljYWwgbWFwcGluZyB0YWJsZSB1c2luZyBk
aWZmZXJlbnQgeDg2X21hcHBpbmdfaW5mbyBvbiBkaWZmZXJlbnQNCj4gPiByYW5nZXMsIHRodXMg
aXQgbWFrZXMgbGVzcyBzZW5zZSB0byB1c2Ugb25lICdzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAq
aW5mbycgdG8NCj4gPiBmcmVlIHRoZSBlbnRpcmUgcGFnZSB0YWJsZSwgYWxiZWl0IGluIHRoaXMg
aW1wbGVtZW50YXRpb24gb25seSB0aGUNCj4gPiAnZnJlZV9wZ3RfcGFnZSgpJyBjYWxsYmFjayBp
cyB1c2VkLiANCj4gDQo+IFRoZSBpbnRlcmZhY2UgY2FuIGJlIGNoYW5nZWQgaWYgdGhlcmUgd2ls
bCBiZSBuZWVkIGZvciBzdWNoIGJlaGF2aW91ci4NCj4gVGhpcyBraW5kIG9mIGZ1dHVyZS1wcm9v
ZmluZyByYXJlbHkgaGVscGZ1bC4NCj4gDQoNCkRvIHlvdSB3YW50IHRvIGp1c3QgcGFzcyB0aGUg
J2ZyZWVfcGd0X3BhZ2UnIGZ1bmN0aW9uIHBvaW50ZXIgdG8NCmtlcm5lbF9pZGVudF9tYXBwaW5n
X2ZyZWUoKSwgaW5zdGVhZCBvZiAnc3RydWN0IHg4Nl9tYXBwaW5nX2luZm8gKmluZm8nPyAgQXMN
Cm1lbnRpb25lZCBhYm92ZSBjb25jZXB0dWFsbHkgdGhlIHBhZ2UgdGFibGUgY2FuIGJlIGJ1aWx0
IGZyb20gbXVsdGlwbGUNCng4Nl9tYXBwaW5nX2luZm8gZm9yIG11bHRpcGxlIHJhbmdlcy4NCg==

