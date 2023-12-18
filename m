Return-Path: <linux-kernel+bounces-3492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C23816D03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8956328339B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9A4BA9E;
	Mon, 18 Dec 2023 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqCxQs2Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A84B5C0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702899696; x=1734435696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iUmXCNAKxmxs5041PBXnWL/joEOOQwsbCHHJA5XhZBo=;
  b=lqCxQs2ZuXi08qodjcv5PAqFPv9kt/QiinMPZkFujpU4NgB06RyYa/WB
   PHDy8e+QUQQedmMyhMsx18HCUzICCm6ECqNYLo0GQz+gi+LglKTbevoBK
   IMlKzYl86yXpW1yHWebU5NGGeBgKITU1we1pobbP43EQo2Hw55CH5ieyr
   a4opHuQpx4AOxZaI9nJXi3clB6bvXK3kqNYFTeQQrm4CQmgJ1xLhWcyiv
   d1QK9QJJZQOz1Nyd9e9U2RaPHe5suPAYS/H0ijm+wZe2X6lmI/0A2UUBF
   oc6sdZlidkKf+m9wM6fznNjWKbji2c7lJKPUtuicCq/fZqT88vICRSNme
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="461944636"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="461944636"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:41:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="725283570"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="725283570"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 03:41:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 03:41:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 03:41:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 03:41:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx98DG796/Bec4aygE1WKaIqvuw6PBfPxcn1LyhZzfT68iv/OMv/GrYimjsalT5Tm3QiXgeUEc3hgZ3i0A72I4Vv4vre6ys7zsU3riiGcklhbosOFcad0uDjePRqGxhXo30Grb3YXct47YAm733XcU37tZ4TAfHq8zy2JdqySxUgwPJ/T0id9H4rGtuBtXNuuJX/kPuxnADg8SKp2aQgStDTdZ3mhAGcKVMmyKNcYf33S7BhnI5EPCFMFCFFsoUvwwM7tzZ1ZVqRWZhF9+chqrp9fCmsypkZqP7g0Abu4XUda/3BHMK7Te+ebCd5NKa+WAhZ/4zx7y9csb6qE91FCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUmXCNAKxmxs5041PBXnWL/joEOOQwsbCHHJA5XhZBo=;
 b=fvLz0k2xPLCqxruLe8KmRUBTqjJ4w12FYavnb+Tv7Eq34MNiQqC7oODzVcNFZcx8WBi3S107gKMgUtKim6GvIDqv8VVTO2Pi3zJpdQSgA8KVwSx9it8s6y2qyv/f6+v5LhetqS8aeeMSr2STsMPFKWEeuseS6J7VkIN9FRKwCQwc81V8NJzNorfL5iEgovCrzoylbGtTr7VEOJO29aYc/X+6quk+FF2XfX1owM9niz0ElxfzKFqrAvgRAH89kVpBAgDaJradYRZh6VtDvuunxpBiJCc5349jo4EQV5qsLbgt7sXVT5cekV7Vr5HRyBTpGdSM4k31R5u86rwugPAEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 by MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 11:41:33 +0000
Received: from MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::ea3a:1981:2d65:b3e6]) by MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::ea3a:1981:2d65:b3e6%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 11:41:33 +0000
From: "Prasad, Aravinda" <aravinda.prasad@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "damon@lists.linux.dev"
	<damon@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"sj@kernel.org" <sj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "s2322819@ed.ac.uk" <s2322819@ed.ac.uk>, "Kumar, Sandeep4"
	<sandeep4.kumar@intel.com>, "Huang, Ying" <ying.huang@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Subramoney, Sreenivas"
	<sreenivas.subramoney@intel.com>, "Kervinen, Antti"
	<antti.kervinen@intel.com>, "Kanevskiy, Alexander"
	<alexander.kanevskiy@intel.com>, Alan Nair <alan.nair@intel.com>
Subject: RE: mm/DAMON: Profiling enhancements for DAMON
Thread-Topic: mm/DAMON: Profiling enhancements for DAMON
Thread-Index: AQHaLypE0BGAPWFioUOkts0KQWZiNLCqpYoAgARH9zA=
Date: Mon, 18 Dec 2023 11:41:33 +0000
Message-ID: <MW5PR11MB59074127DBF2AC23AEFF4EF2F290A@MW5PR11MB5907.namprd11.prod.outlook.com>
References: <20231215074619.173787-1-aravinda.prasad@intel.com>
 <99ce13b6-600d-411e-9dab-97a8ed166deb@intel.com>
In-Reply-To: <99ce13b6-600d-411e-9dab-97a8ed166deb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5907:EE_|MW5PR11MB5764:EE_
x-ms-office365-filtering-correlation-id: c639e4cb-b5b1-4e8c-e4cc-08dbffbe48ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bRsUz4Tp8aCLtw71TKzsaZYENQUIKVZSelH2N10aOMRexJqobXARJwe3RdlORU0F8MSWFQhWownhQGN2x9+y2ZuKWRoN2FTDXv2tbSzTxCqg7vUbP0wbUjwtldZozfZpuICE65uivQwYTiiISs+ObCkPfPtj2WXF2dpwIkA3oIWWzgGGiT3XO+w6e8THkIeT3j2q5twJPA2IUbh2RARCUgdh/voix+TQb7/9kwfbV70jqONGv/+wGCnuQvMT273ZjwTUZyYv2i6M0pE4VsPPusp1uJLi8VZhTM221Raa+y3rWfi6GbQNe6g55nsyPOFUF+4Wcp+uKyx3Uv8Azk4UDF/H6P1CE43o+HoCAOB8s4uZIYZY3zlT2zszxt63vZXLYmGiyHH3/CCUy7+qpYnGyc6ivbAgM0qcGcBoQz8kzAHuCbz6HCX/gEzr6JpGNgSH3oqgfgCNrKd5bbRSL3OSGIlMoWLJEgnhCsM76+F4oK0hTLOL+nZVJH+lfM5/A6jcTspS4kums+RZaH3snkMtjRHSkHZKqQ85EmnbG/cyOyZNtY8Uv/1bp+U9KSJ+/cVTsf9gV6FYkNbLBCAXYEHWCRpj+Q/3A83U7HvNuB13GIeupqeWVSOO5tNcVZmnyMRp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5907.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(5660300002)(38070700009)(41300700001)(86362001)(33656002)(82960400001)(122000001)(38100700002)(26005)(478600001)(55016003)(107886003)(83380400001)(66556008)(66946007)(64756008)(110136005)(66446008)(66476007)(54906003)(76116006)(316002)(53546011)(7696005)(6506007)(9686003)(71200400001)(52536014)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHNXaERBcWdiZ2lWVU5JOE5yaTIxT1ArUGZYeGdzWFN3U0FZOTJ6d3pSMG9x?=
 =?utf-8?B?NUJTK2NKaWkyNVZSR2ZQSEJ4N3BzMkhlM0pRU0FsY21iSng1MElBNFRXRXQv?=
 =?utf-8?B?Q1NrNjRTbjRDT1M5bVFRMkphSDk5cHFyc1pRcWhsZWdXNXlod1RrRWtXZ1pI?=
 =?utf-8?B?cTZlemJLQUJPZnVLRG1HMDFvc3ZvcGlpZmJOMzB2T3VkM1ZxRkR6ZllsbjF1?=
 =?utf-8?B?ZE5rWHJub0orTEJjZHo3c1NMQUtiLzR4SXRESGNxNWRjcUlzNktrTXNoZG9o?=
 =?utf-8?B?d0w5T0owVkt1cGFsVG9jS095R0VNZzNiQnhQWFJJWFlUZTh4YnZDUm5IUEhN?=
 =?utf-8?B?Nm9ya3NFQ0xVMzlWbjhyVUFWNE5sdTVZTmQ2N25ZRkx1OGhYT3FncFU5TEtK?=
 =?utf-8?B?d09qeHNxSkZRTFYvekVCOFRzZ0s1SEhxM3dpcUZxaG5uM1J2TWtoZnlGWEdY?=
 =?utf-8?B?MWx6QllIMHk5ZHN5NWQ2SE9KUzFJMGxHMm1RWDRyMzhRcVlCMmtmK0ZXdFZ4?=
 =?utf-8?B?N3diSFJnY0gzWE9TMmRUb3E0ZlJGeUoxY1Z5TCtPdEEzU3hKN3V0dGNUVkY1?=
 =?utf-8?B?NW44K2xQWC9RaXA5b1AxQ0NJTmFqckgwUmQ0dWZSKzhLQ2dWc2paREZtZDNi?=
 =?utf-8?B?empKR01vWkcrQ0N5alBLdGFjZnB5RmxLWFlNcHFZYytJMFJHWW94VHRsanZP?=
 =?utf-8?B?R1F4UVRTd09HL2RTMmJSaW41TlNwNSsya1MvMWZkUHpRN09JNVRBQ2JZNjNR?=
 =?utf-8?B?L1o2VWg1UHA2ZDNoaUJHMlk3MXpqcXl3ZE9lTk53alZGOW1ua01nWC9NTjly?=
 =?utf-8?B?UTBSQVRuQUtEZWU4OFFRVlU2K3c3OWdMRDg2MW4wUVYwUzdPTHpXNWk4dHRy?=
 =?utf-8?B?SkNjSGZFY3NTbjUvbGtCam1SdDlXMm54NWZTR2liWG5scFpxemxoU0k1TC9n?=
 =?utf-8?B?cWxTT05yWWUvTk1JWGV1ZzNnRjFPZjFQRWtQZGxCbitJWHpaMisrdnZqOENP?=
 =?utf-8?B?M0dxMjNoSjFxNnFsd0pKeDR2ZUNub3FyV2I3M1I1Mm5xK1doMEhqRjF6U2dY?=
 =?utf-8?B?MTY4UGsxN25PWkUwMzBFTDlhZWxTNC9xb1FzUG5YS3I4QkFPMkd6YmhJM1Av?=
 =?utf-8?B?WnNLNVBUaittQXJvdFNxRSs5UUVZWTFFdlVnd2N3QWJQTnFmbG1VbGZKMHU1?=
 =?utf-8?B?UGovT0xPZmdHRERiZTg3K1pFQS9WZys5eGRZVHVaNzFjMERrZ05tNDhQb2pZ?=
 =?utf-8?B?WW83eGVqZ25IRTlPVGs3cm9mMUNKSXZXR09mVjNrdnZpaWRHV3N6ZVJKaDNJ?=
 =?utf-8?B?T1NtTUNnQkJkOTZlcW9pZ3dlMndDSFpDM2xnYjdrancvU1JGYnpwK1E0RmZs?=
 =?utf-8?B?dEo4QmNsZW5wNWlSZmtzTjNSUzZWWlVyaDRaTERVUnpiTTFSeGZlQ1RXaXFs?=
 =?utf-8?B?ZmM1dnREUHo2eDFycUZwWE55b3pjZ2U3TTlXdHZLZ2lrUWxnSCtBOHRYY3lF?=
 =?utf-8?B?MHBRSHZ1VHBFWDY5VnZoMndIZkpqVFlPRXhUTUtUSHFVMkJQOE1hajBCeStL?=
 =?utf-8?B?K0R4M0phK1FnRktWWkdUUW1oQkhGZ0JUZFhuRnNQaDR4dmRGVHF1b25rMkl0?=
 =?utf-8?B?c2JxTzFtWWV0UWJtZmVLQSsyT2dZMGZNOHBWeFl5NjZmZ2syQUdXZlUzVDRX?=
 =?utf-8?B?ZWZEdXdLcWNnR3pSYTM3QUdwZEt4d3Ntekhvc0puaXFHYjhxZXFHNlFKN3Rw?=
 =?utf-8?B?a3MvY2ZvNjYwVGxONzN3MDloZ25nQk1HMDlrNFM0VkxqY2ZNTGxGaXNZa3Q4?=
 =?utf-8?B?Ukl4aXZ5MTBtTkZuSjFXbnkxYWNVRVN2U1dQbUpJOGRUOWw1cStiaGhUY1Fj?=
 =?utf-8?B?TEN2UENudTN0MnF0YzI0VVpBaWhib1JMQlZyQmh3Njg5R3BCREFtWk5lb0FM?=
 =?utf-8?B?RnNyUnNSZmRnZVBiTWxPRHFNcG5SdnVuTmNBYU0rY1hvR1FrMUFMNVUyUDdX?=
 =?utf-8?B?bi8vVElrYkRzMnZGQ2dZaExRb1FiUmpuNUt5c2l1Q0NMWERRUUpENFA1MC9X?=
 =?utf-8?B?QVgybWlPMkI5NTM1bWZLUDJSNmxzZDg4bVRDQ3BxMFJacE9XS3ErSStha3VS?=
 =?utf-8?Q?fnqurCCcnE4KSK9EyrZaNCXtb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5907.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c639e4cb-b5b1-4e8c-e4cc-08dbffbe48ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 11:41:33.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjCEuEcpf9ouz80Z5Y6iHzk+r/mB6h+bvSe+SN6LcFkLjag6gRHkaZupkanbC2wlujI7D8/l2RsCXJ8gS1B0y3dShXdgbSyZ2poNxe9v/3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5764
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFuc2VuLCBEYXZlIDxk
YXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTUsIDIwMjMg
MTE6NDAgUE0NCj4gVG86IFByYXNhZCwgQXJhdmluZGEgPGFyYXZpbmRhLnByYXNhZEBpbnRlbC5j
b20+OyBkYW1vbkBsaXN0cy5saW51eC5kZXY7IGxpbnV4LQ0KPiBtbUBrdmFjay5vcmc7IHNqQGtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHMyMzIyODE5QGVk
LmFjLnVrOyBLdW1hciwgU2FuZGVlcDQgPHNhbmRlZXA0Lmt1bWFyQGludGVsLmNvbT47DQo+IEh1
YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47IFdpbGxpYW1zLCBEYW4gSg0KPiA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPjsgU3VicmFtb25leSwgU3JlZW5pdmFzDQo+IDxzcmVlbml2
YXMuc3VicmFtb25leUBpbnRlbC5jb20+OyBLZXJ2aW5lbiwgQW50dGkgPGFudHRpLmtlcnZpbmVu
QGludGVsLmNvbT47DQo+IEthbmV2c2tpeSwgQWxleGFuZGVyIDxhbGV4YW5kZXIua2FuZXZza2l5
QGludGVsLmNvbT47IEFsYW4gTmFpcg0KPiA8YWxhbi5uYWlyQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IG1tL0RBTU9OOiBQcm9maWxpbmcgZW5oYW5jZW1lbnRzIGZvciBEQU1PTg0KPiANCj4g
T24gMTIvMTQvMjMgMjM6NDYsIEFyYXZpbmRhIFByYXNhZCB3cm90ZToNCj4gPiArc3RhdGljIGlu
dCBkYW1vbl95b3VuZ19wbWQocG1kX3QgKnBtZCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiA+ICsJ
CXVuc2lnbmVkIGxvbmcgbmV4dCwgc3RydWN0IG1tX3dhbGsgKndhbGspIHsNCj4gPiArCXNwaW5s
b2NrX3QgKnB0bDsNCj4gPiArCXN0cnVjdCBkYW1vbl95b3VuZ193YWxrX3ByaXZhdGUgKnByaXYg
PSB3YWxrLT5wcml2YXRlOw0KPiA+ICsNCj4gPiArCWlmICghcG1kX3ByZXNlbnQoKnBtZCkgfHwg
cG1kX25vbmUoKnBtZCkpDQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKw0KPiA+ICsJcHRsID0gcG1k
X2xvY2sod2Fsay0+bW0sIHBtZCk7DQo+ID4gKwlpZiAocG1kX3lvdW5nKCpwbWQpIHx8IG1tdV9u
b3RpZmllcl90ZXN0X3lvdW5nKHdhbGstPm1tLCBhZGRyKSkNCj4gPiArCQlwcml2LT55b3VuZyA9
IHRydWU7DQo+ID4gKw0KPiA+ICsJKnByaXYtPmZvbGlvX3N6ID0gKDFVTCA8PCBQTURfU0hJRlQp
Ow0KPiA+ICsJc3Bpbl91bmxvY2socHRsKTsNCj4gPiArb3V0Og0KPiA+ICsJcmV0dXJuIDA7DQo+
ID4gK30NCj4gDQo+IFRoZXJlIGFyZSBhIG51bWJlciBvZiBwYWlyZWQgcCpfcHJlc2VudCgpIGFu
ZCBwXypub25lKCkgY2hlY2tzIGluIHRoaXMgcGF0Y2guDQo+IFdoYXQgaXMgdGhlaXIgZnVuY3Rp
b24gKGVzcGVjaWFsbHkgcG1kX25vbmUoKSk/ICBGb3IgaW5zdGFuY2UsDQo+IGRhbW9uX3lvdW5n
X3BtZCgpIGdldHMgY2FsbGVkIHZpYSB0aGUgcGFnZXdhbGsgaW5mcmFzdHJ1Y3R1cmU6DQoNCkht
bS4uIEkgdGhpbmssIHRoZXkgY2FuIGJlIHJlbW92ZWQuIExvb2tzIGxpa2UgcGFnZXdhbGsgaW5m
cmFzdHJ1Y3R1cmUgc2hvdWxkIHRha2UgY2FyZS4NCkJ1dCB3aWxsIGRvdWJsZSBjaGVjay4NCg0K
PiANCj4gPiBzdGF0aWMgaW50IHdhbGtfcG1kX3JhbmdlKHB1ZF90ICpwdWQsIHVuc2lnbmVkIGxv
bmcgYWRkciwgdW5zaWduZWQgbG9uZyBlbmQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgbW1fd2FsayAqd2Fsaykgew0KPiAuLi4NCj4gPiAgICAgICAgICAgICAgICAgbmV4
dCA9IHBtZF9hZGRyX2VuZChhZGRyLCBlbmQpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocG1k
X25vbmUoKnBtZCkpIHsNCj4gLi4uDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29udGlu
dWU7DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gLi4uDQo+ID4gICAgICAgICAgICAgICAgIGlm
IChvcHMtPnBtZF9lbnRyeSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBvcHMt
PnBtZF9lbnRyeShwbWQsIGFkZHIsIG5leHQsIHdhbGspOw0KPiANCj4gSSdkIHN1Z2dlc3QgdGFr
aW5nIGEgY2xvc2VyIGxvb2sgYXQgdGhlIGNvZGUgeW91IGFyZSByZXBsYWNpbmcgYW5kIG90aGVy
IG1tX3dhbGsNCj4gdXNlcnMgdG8gbWFrZSBzdXJlIHRoZSBoYW5kbGVycyBhcmUgZG9pbmcgYXBw
cm9wcmlhdGUgY2hlY2tzLg0KDQpTdXJlLg0KDQo=

