Return-Path: <linux-kernel+bounces-127069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25372894665
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C159B21180
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284DC548E4;
	Mon,  1 Apr 2024 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1WZ0RAx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210F1E86A;
	Mon,  1 Apr 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005737; cv=fail; b=UCBSBJ4ZuwwSX5JpmEfybKTb57GfeatVVc4ZT7EEnpx07Xdpjssw3089bpD5p5sfBHPISOVNPq/sSacS8OE4rMnQOJ1Hx2R4zI95eiZY6jWGm+f2iuX9nwaLXhdWjv52jXgFfJ5nnIPPeHaYJDJmWWkQjwPwZYfzYSRdIxvBjnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005737; c=relaxed/simple;
	bh=KgVGuQq/nShJe4HX+zL980TXSCZplFezKC3vo3yjuqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgeOqXi2GrTVh3/Px1Fk4+5tbjnCJ6SL3gS6HVM3dmG8C8WToDmPSqcygF5gvIEsY9A5jyhAx5VGE9BL4/uFAEKbsUoqbSKPL8SFj/HQScAU7O4w1kkFWTuZkYFikB8LwnrZRIBxtnKxcq5LahpjXswFoDbLNcefHeHCgN9UkPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1WZ0RAx; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712005736; x=1743541736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KgVGuQq/nShJe4HX+zL980TXSCZplFezKC3vo3yjuqo=;
  b=Z1WZ0RAxbvoa4fP10zCfGk7bFvIGFCX+oHGnpqQqmGuTzxhXI1q7Pg8w
   qnOW7y567ZTuuVpdXj4//HHSEgerdLbCWRgcrtqdrRPTlsdnd5PQ/fr3a
   Xzq1t8Xw18780ccL98wdpGpB2edU7USwYQp9kWg2OgfpsuhK7cxVN8qwe
   freSYIBXQel0AR0yZYI7KurrLwZ4UWk6e3GPYS2M1Z8Ny2OAXGn2jOo5P
   /0Yg4gKxcj7oHmmm2czVPRr8f9SUk1S6FZtWJVgkrQbbTyiuCBobm8ZTj
   mJ67FNqV7QWKyRIgufuTH4jXn9Ul4MedH3DgbMirwFWHPZEm41QRguCGO
   g==;
X-CSE-ConnectionGUID: N/WOwzXrQu+gwZH1xvQZag==
X-CSE-MsgGUID: sXzo1BAnSiaXeVO1IYJDHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7015878"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7015878"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 14:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22522647"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 14:08:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 14:08:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 14:08:46 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 14:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oM/mrXB/ABwOU7tzGjK3P0aEziP9LewDoLxRC3v1bIcILYW/7qkD6P+RtLkOOWXmNq3SV3MPSgUwPQf3r27Ha7oHwZ8/HAhCqGU/QmPXgcyq+MK9b311B7kETpM+n+OLRmkMiSOoGWXEa0/dVjpvZK/JU7OF9et/GL+EBHXA+Fjw9YqvPipsv4PAa/qLzVUaaIU03ItCV8b5WEq/Rhhgh+rQRuk3Qg85vb8tpMUvPnaIvR7Cwxmp/Z7LQTHsEzI/m8SWilGuK9khZUFbeMnnftADiaxdcvD45/EDpMOTUamKEQL44LyO8jcG8sJdKCrkjs6msCTPfgo0DEhQoeYjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgVGuQq/nShJe4HX+zL980TXSCZplFezKC3vo3yjuqo=;
 b=JfCYe9wqpRvjntc2llcfaQyM/67VBy5z8KfNcJRFV3Ls5qN0+dFxKI5u3LorjwOms2BkijqR770N3AkKG0n1M2HPxMPTja+7fe9E2ebav8ZFFaRwG4WC3FepTVPHwM63F8tE39yqpyjvfPh5OBrT8QznJpqclCgu/GTuIyg71EbcOgsi2xUUUXeaEB8QWHr6Fa1MKiQCi9oDUs7ltIkRaLWS12WNVVN4kCNdnUJFrsfS7pUp/fJV6orgPyPgdCs2C3uEZvexT6UPC1UHNrGCRCGvIH029srVugXnOeswYO8wsD4wSKPdQ3bzO/q0+fqA2OpwiQz0zfIBRCVijS3TSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Mon, 1 Apr
 2024 21:08:43 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 21:08:43 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v6 4/5] perf stat: Add retire latency print functions
 to print out at the very end of print out
Thread-Topic: [RFC PATCH v6 4/5] perf stat: Add retire latency print functions
 to print out at the very end of print out
Thread-Index: AQHagg0ZNLnTKl1HOUmgdHwtTgjvY7FT7CWAgAAAe7A=
Date: Mon, 1 Apr 2024 21:08:43 +0000
Message-ID: <CO6PR11MB56356D30DC2EE8F0EB7ADB30EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-5-weilin.wang@intel.com>
 <CAM9d7ciqiAOV_1A0N3he_Jiw3ur-ZN6djWpzgR2C+AF2m9an5A@mail.gmail.com>
In-Reply-To: <CAM9d7ciqiAOV_1A0N3he_Jiw3ur-ZN6djWpzgR2C+AF2m9an5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SN7PR11MB7509:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7q8yiMQW7V/0f6GOpz3RsVaF2T62/L3ekxYxKXWxhvegAsq7/Q8JDF23s/ywVyLHpN6SJH0Alyu1P5lnOqc4IZZry9Z+zBPE6oaPIrl6K6EsVXQ0iePTBD53iD7bmhfvYzgSl4sAKSjVQKjmH4/1h5B1S8ltwf4tMcEFLtzdAP1mjYO0LlPaZaCvo8DPXKkOFuv2bzpriEEaPduVS/Y9Y5K00QbV49oRtoTEjLSwDWPq+azy9RCwPd4DD9WdVk/ByRX1kHgB55gPhU0gkefWyANchJiZ3SaRslyk393FHCnpcRko5ROMVHDgZ4E9UVgyS7Q0dTVPMGWccc+9aD60wblnjChimgIstcr0Jw1JAn5BsrmReqqscdJM0RG/qMPnF+L8g2Wn1Nc/Xyp57LtnxFq711OBWUqcjkL1rgbkrKEkbOhqb7OUupYKkcsIXzVz8JexsUk/CTB/K9jHv7OwHJe2vFcoigtJWQZpN/k9LUahI8cwBQ+ELgDtrtFxcdjvDGRgkKiDMntVhIZuF8JV5vi6MW1Lxs4FGchInFZh01gfERQXpKqv20w3xbB0tdAWrXmK5KK8XRHgHHSUi5xjQJo81M1avYpNablXAcfYirX450J9i0SATlMG9ltsLcKqxqUqWOkM2SnsCT6CUCzPKkB7xXxGC8MvzybUazeMbM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHp2OWhuaXowQWtYN0RFZ01QcXJoT0NsSklkckJKSzJLTThjNWtUMEpoTC9G?=
 =?utf-8?B?WDNtUkt5UGZrajh2cVIrZnF6M2lCSWMrZTE5M3I4NW0zSU1tTlVpcWlEZUVq?=
 =?utf-8?B?cHE5d2t1Nmh6RXZtMitSeUFBRXMxVHdVTDFKcEhvSDJEdUhTKzQ5bml6dU9q?=
 =?utf-8?B?bW5xQVBRR05rU0M4M2pMUTYwOHR2YzVjWnpXKzU3dkJueFRlU1l5UDYySWVp?=
 =?utf-8?B?eHE4VExrYXovMytobGdLRHhnV1J2TVg3NWQvWlBDL245emRyL2J0Tjg2cFdN?=
 =?utf-8?B?Y0U0T3lEb3dpbklOeHN3K3FxS0JOY0tMditRdkpISzBUc0RqaUNVZzhHY1BO?=
 =?utf-8?B?VURncnhVZDB0cmJzQVptaCtYTkNSLzNJSzZQbmZ1TFhvcTZPZnp4QzBKRUFM?=
 =?utf-8?B?cURsclRJLzI1eGhpMDB6N0V4OWlzR1hVYjJ0M1VhaldVUk1CQnB3S0RGalRB?=
 =?utf-8?B?YUgrTHFmVUVFTDJjcERrQVZBTjZnNXlaK3JOVm95S080aWV1cTQ4UGtwYUY0?=
 =?utf-8?B?WnMzQ2JxaXRrVlhDRmhPZDlYTTF4bTZGSjhSUzFESC8vbFRVbjFRczR3Ymxi?=
 =?utf-8?B?UGFKMUxlck1SWjhKaTQ2VkFKbnNOOVBWWkZvc1FCWC9HYXIxWmhMYnBWU0Vq?=
 =?utf-8?B?cUw4NFk4QVQwaWdFUkRDb0lQdEthbjg4UlZqcDhUSkp4QmVaaFRRNmh2RE5a?=
 =?utf-8?B?b2RuYUdIZFE3N1ZINHk1L0d0TGFKS20rb3pRTUM5emkzbzFlcXRQTytRTWRr?=
 =?utf-8?B?eXJ4dWhlRjN3YmpucnFHTVhZcmhlc1MzNEtMZ1RvTEtiTTFDRjFaTTAxUW1p?=
 =?utf-8?B?MEY2QitjUjQ0UklBSVdxc0xkdnVjUTV4dUduU3h2Ylh3Um5pTUp3U3I2UmpS?=
 =?utf-8?B?QnJtaG5UN3pneFRJUnlqVDdXUWNHeWY4Y21ackRIYVYwZHNxYTVqVEtEb2pH?=
 =?utf-8?B?L25WVHRkTFRnZHJ5eTNSdnNHbitMWU1XRkF5Wm1UYkZlK09rd2x4cWpzbmFM?=
 =?utf-8?B?NURtSmVVckJlVG9yUWJEVXh3bHE0dE9JdDdudnhNdmtvcEdRVlpvUGtGZWlo?=
 =?utf-8?B?c1graUhjMDVlYWpjNEZBWkJDeFdPMWlGZytiTW9qL0lLejE5TnNYRnRIQlZG?=
 =?utf-8?B?QllxQmhwUVNtdFJaUlA3V1FJbGNzWjY5ZlFUY3lRYzB5UTJWdEFkUkUvVVk4?=
 =?utf-8?B?NmpkeWkvdUt0cFZXQzhRa3ZPRGhpSmw0bnROd3BkTXNZTUZ0WVNpME5MU0E5?=
 =?utf-8?B?My94UzYyOWdUazJEWFpTZnRUUGhEZURpa0x4bWdzUGFMSm9XZDdWc2ppM3Fv?=
 =?utf-8?B?WlNUaitxZE5jUkJvQWxpZDVoQ1NHdW1WTlcxNmZZUFpsVGlLVENQYWxuYXBQ?=
 =?utf-8?B?cVZlQ0IvaHpDZERKVlY3WmY5T1pTUHFobnBUa3hFQjZwcGhWVkRxdVk4dEo3?=
 =?utf-8?B?NjVMM2VLZE51aWtZeTQ2eVlUbnF5K1kxMWRkTjdBQTB2c2U5MllPU2ZLWE9L?=
 =?utf-8?B?R2NMT1cwSlJOdXFobjRwYlZpdWFZbDhYN01aRXFPZTdLZzhITzJ5WFpLSUdW?=
 =?utf-8?B?ZFFUQklITHRmVFpyU0RqWlgzdnoxNFA1MHBHTWh2OUh3ZiswVUJTRWh3SnNu?=
 =?utf-8?B?ZEo5VUlReElGQnZxcUM2YVgyQitVSS9ZZGpmN2Q2N0dCQXZ0aUtuc0d1U3RN?=
 =?utf-8?B?b0RKMVU5YUx4ZzRPUWVNakpMOXBPRk9ndWJ4aWpYbTFDTmR6Vks5THl0Uy9Y?=
 =?utf-8?B?aUxZZnpYeGtFcGJ2TVVlYm5tazJlakhtdHZFMnhwemZVSmM0aEY0aGtoSHBi?=
 =?utf-8?B?b0NJbVRBUHFMYzZ3eDN2d09GcTBuWHdJVjVzUUozZzcxd2lMSlg4Unc3NUhR?=
 =?utf-8?B?aXB4aWtydnE2M3FtemRMZU9jKythaXkyUkhTMXhPaExia3doNllLVjNwK0dK?=
 =?utf-8?B?RTZiWFNkbkgxU05vdkx6dmFXZmtncWZZLzlOR3Rad3FPTEtzclNrK1JrNyt6?=
 =?utf-8?B?bWtsallTZGw5RzVFQUVFVVFmYVVZekJZTVd1SENCb1ZnWkhNNFI3enNtc3ow?=
 =?utf-8?B?RDJzN1JScE8wR0M1eVBRVkhTWTd4cmY5V0dPSGUxblh1Ky9paDcwV3laQm1Q?=
 =?utf-8?Q?dNJSIPnx/VLQQlIX9ca8AWG+d?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ff549e-d711-4af9-7523-08dc528fe9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 21:08:43.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VR5EeXwOpE4b67IjoaK4havG5uKJoyuyq/lOpKOBfU8q3DMilW9Y6LR6NKKd6mhWDu/L4oeXTMaJ47U5q0qoSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDEsIDIwMjQgMjowNCBQ
TQ0KPiBUbzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+IENjOiBJYW4g
Um9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4g
PGFjbWVAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgQWxleGFuZGVyIFNoaXNoa2luDQo+
IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBr
ZXJuZWwub3JnPjsgSHVudGVyLA0KPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsg
S2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gbGludXgtcGVyZi11c2Vy
c0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRheWxvciwg
UGVycnkNCj4gPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRo
YS5hbHRAaW50ZWwuY29tPjsgQmlnZ2VycywNCj4gQ2FsZWIgPGNhbGViLmJpZ2dlcnNAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2NiA0LzVdIHBlcmYgc3RhdDogQWRkIHJl
dGlyZSBsYXRlbmN5IHByaW50IGZ1bmN0aW9ucyB0bw0KPiBwcmludCBvdXQgYXQgdGhlIHZlcnkg
ZW5kIG9mIHByaW50IG91dA0KPiANCj4gT24gRnJpLCBNYXIgMjksIDIwMjQgYXQgMTI6MTLigK9Q
TSA8d2VpbGluLndhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFdlaWxpbiBX
YW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4NCj4gPiBBZGQgcHJpbnQgb3V0IGZ1bmN0
aW9ucyBzbyB0aGF0IHVzZXJzIGNvdWxkIHJlYWQgcmV0aXJlIGxhdGVuY3kgdmFsdWVzLg0KPiA+
DQo+ID4gRXhhbXBsZSBvdXRwdXQ6DQo+ID4gSW4gdGhpcyBzaW1wbGUgZXhhbXBsZSwgdGhlcmUg
aXMgbm8gTUVNX0lOU1RfUkVUSVJFRC5TVExCX0hJVF9TVE9SRVMNCj4gc2FtcGxlLg0KPiA+IFRo
ZXJlZm9yZSwgdGhlIE1FTV9JTlNUX1JFVElSRUQuU1RMQl9ISVRfU1RPUkVTOnAgcmV0aXJlX2xh
dGVuY3kNCj4gdmFsdWUsIGNvdW50DQo+ID4gYW5kIHN1bSBhcmUgYWxsIDAuDQo+ID4NCj4gPiAg
UGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoNCj4gPg0KPiA+ICAg
ICAgICAxODEsMDQ3LDE2OCAgICAgIGNwdV9jb3JlL1RPUERPV04uU0xPVFMvICAgICAgICAgICMg
ICAgICAwLjYgJQ0KPiB0bWFfZHRsYl9zdG9yZQ0KPiA+ICAgICAgICAgIDMsMTk1LDYwOCAgICAg
IGNwdV9jb3JlL3RvcGRvd24tcmV0aXJpbmcvDQo+ID4gICAgICAgICA0MCwxNTYsNjQ5ICAgICAg
Y3B1X2NvcmUvdG9wZG93bi1tZW0tYm91bmQvDQo+ID4gICAgICAgICAgMyw1NTAsOTI1ICAgICAg
Y3B1X2NvcmUvdG9wZG93bi1iYWQtc3BlYy8NCj4gPiAgICAgICAgMTE3LDU3MSw4MTggICAgICBj
cHVfY29yZS90b3Bkb3duLWZlLWJvdW5kLw0KPiA+ICAgICAgICAgNTcsMTE4LDA4NyAgICAgIGNw
dV9jb3JlL3RvcGRvd24tYmUtYm91bmQvDQo+ID4gICAgICAgICAgICAgNjksMTc5ICAgICAgY3B1
X2NvcmUvRVhFX0FDVElWSVRZLkJPVU5EX09OX1NUT1JFUy8NCj4gPiAgICAgICAgICAgICAgNCw1
ODIgICAgICBjcHVfY29yZS9NRU1fSU5TVF9SRVRJUkVELlNUTEJfSElUX1NUT1JFUy8NCj4gPiAg
ICAgICAgIDMwLDE4MywxMDQgICAgICBjcHVfY29yZS9DUFVfQ0xLX1VOSEFMVEVELkRJU1RSSUJV
VEVELw0KPiA+ICAgICAgICAgMzAsNTU2LDc5MCAgICAgIGNwdV9jb3JlL0NQVV9DTEtfVU5IQUxU
RUQuVEhSRUFELw0KPiA+ICAgICAgICAgICAgMTY4LDQ4NiAgICAgIGNwdV9jb3JlL0RUTEJfU1RP
UkVfTUlTU0VTLldBTEtfQUNUSVZFLw0KPiA+ICAgICAgICAgICAgICAgMC4wMCBNRU1fSU5TVF9S
RVRJUkVELlNUTEJfSElUX1NUT1JFUzpwICAgICAgIDAgICAgICAgIDANCj4gDQo+IFRoZSBvdXRw
dXQgaXMgbm90IGFsaWduZWQgYW5kIEkgdGhpbmsgaXQncyBoYXJkIHRvIHJlYWQuDQo+IEkgdGhp
bmsgaXQgc2hvdWxkIHByaW50IHRoZSByZXN1bHQgbGlrZSB0aGlzOg0KPiANCj4gICAgIDxzdW0+
ICA8ZXZlbnQtbmFtZT4gICMgPHZhbD4gIGF2ZXJhZ2UgcmV0aXJlZCBsYXRlbmN5DQoNClNpbmNl
IHdlIHdvdWxkIGxpa2UgdG8gdXNlIHRoZSBhdmVyYWdlIHJldGlyZSBsYXRlbmN5LCBJIHdvdWxk
IHRoaW5rIHB1dCBhdmVyYWdlDQphdCB0aGUgYmVnaW5uaW5nIHdvdWxkIGJlIG1vcmUgY29uc2lz
dGVudC4gU28gaW4gZm9ybWF0IGxpa2U6DQo8dmFsPiA8ZXZlbnQtbmFtZT4gPHN1bT4gPGNvdW50
PiBvciA8dmFsPiA8ZXZlbnQtbmFtZT4gPGNvdW50PiA8c3VtPiA/DQoNCkkgd2lsbCB3b3JrIG9u
IHRoZSBhbGlnbm1lbnQuIA0KDQpUaGFua3MsIA0KV2VpbGluDQoNCj4gDQo+IFRoYW5rcywNCj4g
TmFtaHl1bmcNCj4gDQo+IA0KPiA+DQo+ID4gICAgICAgIDEuMDAzMTA1OTI0IHNlY29uZHMgdGlt
ZSBlbGFwc2VkDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWlsaW4gV2FuZyA8d2VpbGluLndh
bmdAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2ds
ZS5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9zdGF0LWRpc3BsYXkuYyB8IDY1
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDY1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0
aWwvc3RhdC1kaXNwbGF5LmMgYi90b29scy9wZXJmL3V0aWwvc3RhdC1kaXNwbGF5LmMNCj4gPiBp
bmRleCBiZmMxZDcwNWY0MzcuLjZjMDQzZDljOWY4MSAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9w
ZXJmL3V0aWwvc3RhdC1kaXNwbGF5LmMNCj4gPiArKysgYi90b29scy9wZXJmL3V0aWwvc3RhdC1k
aXNwbGF5LmMNCj4gPiBAQCAtMjEsNiArMjEsNyBAQA0KPiA+ICAjaW5jbHVkZSAiaW9zdGF0Lmgi
DQo+ID4gICNpbmNsdWRlICJwbXUuaCINCj4gPiAgI2luY2x1ZGUgInBtdXMuaCINCj4gPiArI2lu
Y2x1ZGUgIm1ldHJpY2dyb3VwLmgiDQo+ID4NCj4gPiAgI2RlZmluZSBDTlRSX05PVF9TVVBQT1JU
RUQgICAgICI8bm90IHN1cHBvcnRlZD4iDQo+ID4gICNkZWZpbmUgQ05UUl9OT1RfQ09VTlRFRCAg
ICAgICAiPG5vdCBjb3VudGVkPiINCj4gPiBAQCAtMzQsNiArMzUsNyBAQA0KPiA+ICAjZGVmaW5l
IENPTU1fTEVOICAgICAxNg0KPiA+ICAjZGVmaW5lIFBJRF9MRU4gICAgICAgNw0KPiA+ICAjZGVm
aW5lIENQVVNfTEVOICAgICAgNA0KPiA+ICsjZGVmaW5lIFJFVElSRV9MRU4gICAgOA0KPiA+DQo+
ID4gIHN0YXRpYyBpbnQgYWdncl9oZWFkZXJfbGVuc1tdID0gew0KPiA+ICAgICAgICAgW0FHR1Jf
Q09SRV0gICAgID0gMTgsDQo+ID4gQEAgLTQyNiw2ICs0MjgsNjcgQEAgc3RhdGljIHZvaWQgcHJp
bnRfbWV0cmljX3N0ZChzdHJ1Y3QNCj4gcGVyZl9zdGF0X2NvbmZpZyAqY29uZmlnLA0KPiA+ICAg
ICAgICAgZnByaW50ZihvdXQsICIgJS0qcyIsIE1FVFJJQ19MRU4gLSBuIC0gMSwgdW5pdCk7DQo+
ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBwcmludF9yZXRpcmVfbGF0X3N0ZChzdHJ1Y3Qg
cGVyZl9zdGF0X2NvbmZpZyAqY29uZmlnLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBvdXRzdGF0ZSAqb3MpDQo+ID4gK3sNCj4gPiArICAgICAgIEZJTEUgKm91
dCA9IG9zLT5maDsNCj4gPiArICAgICAgIGJvb2wgbmV3bGluZSA9IG9zLT5uZXdsaW5lOw0KPiA+
ICsgICAgICAgc3RydWN0IHRwZWJzX3JldGlyZV9sYXQgKnQ7DQo+ID4gKyAgICAgICBzdHJ1Y3Qg
bGlzdF9oZWFkICpyZXRpcmVfbGF0cyA9ICZjb25maWctPnRwZWJzX3Jlc3VsdHM7DQo+ID4gKw0K
PiA+ICsgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeSh0LCByZXRpcmVfbGF0cywgZXZlbnQubmQp
IHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKG5ld2xpbmUpDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZG9fbmV3X2xpbmVfc3RkKGNvbmZpZywgb3MpOw0KPiA+ICsgICAgICAgICAgICAg
ICBmcHJpbnRmKG91dCwgIiUnKi4yZiAlLSpzIiwgQ09VTlRTX0xFTiwgdC0+dmFsLCBFVk5BTUVf
TEVOLCB0LQ0KPiA+ZXZlbnQubmFtZSk7DQo+ID4gKyAgICAgICAgICAgICAgIGZwcmludGYob3V0
LCAiJSpsZCAlKmRcbiIsIFJFVElSRV9MRU4sIHQtPmNvdW50LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICBSRVRJUkVfTEVOLCB0LT5zdW0pOw0KPiA+ICsgICAgICAgfQ0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBwcmludF9yZXRpcmVfbGF0X2NzdihzdHJ1Y3QgcGVyZl9z
dGF0X2NvbmZpZyAqY29uZmlnLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBvdXRzdGF0ZSAqb3MpDQo+ID4gK3sNCj4gPiArICAgICAgIEZJTEUgKm91dCA9IG9z
LT5maDsNCj4gPiArICAgICAgIHN0cnVjdCB0cGVic19yZXRpcmVfbGF0ICp0Ow0KPiA+ICsgICAg
ICAgc3RydWN0IGxpc3RfaGVhZCAqcmV0aXJlX2xhdHMgPSAmY29uZmlnLT50cGVic19yZXN1bHRz
Ow0KPiA+ICsgICAgICAgY29uc3QgY2hhciAqc2VwID0gY29uZmlnLT5jc3Zfc2VwOw0KPiA+ICsN
Cj4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodCwgcmV0aXJlX2xhdHMsIGV2ZW50Lm5k
KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGZwcmludGYob3V0LCAiJWYlcyVzJXMlcyVsZCVzJWRc
biIsIHQtPnZhbCwgc2VwLCBzZXAsIHQtDQo+ID5ldmVudC5uYW1lLCBzZXAsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgdC0+Y291bnQsIHNlcCwgdC0+c3VtKTsNCj4gPiArICAgICAgIH0N
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcHJpbnRfcmV0aXJlX2xhdF9qc29uKHN0
cnVjdCBwZXJmX3N0YXRfY29uZmlnICpjb25maWcsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBvdXRzdGF0ZSAqb3MpDQo+ID4gK3sNCj4gPiArICAgICAgIEZJ
TEUgKm91dCA9IG9zLT5maDsNCj4gPiArICAgICAgIHN0cnVjdCB0cGVic19yZXRpcmVfbGF0ICp0
Ow0KPiA+ICsgICAgICAgc3RydWN0IGxpc3RfaGVhZCAqcmV0aXJlX2xhdHMgPSAmY29uZmlnLT50
cGVic19yZXN1bHRzOw0KPiA+ICsNCj4gPiArICAgICAgIGZwcmludGYob3V0LCAieyIpOw0KPiA+
ICsgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeSh0LCByZXRpcmVfbGF0cywgZXZlbnQubmQpIHsN
Cj4gPiArICAgICAgICAgICAgICAgZnByaW50ZihvdXQsICJcInJldGlyZV9sYXRlbmN5LXZhbHVl
XCIgOiBcIiVmXCIsICIsIHQtPnZhbCk7DQo+ID4gKyAgICAgICAgICAgICAgIGZwcmludGYob3V0
LCAiXCJldmVudC1uYW1lXCIgOiBcIiVzXCIiLCB0LT5ldmVudC5uYW1lKTsNCj4gPiArICAgICAg
ICAgICAgICAgZnByaW50ZihvdXQsICJcInNhbXBsZS1jb3VudHNcIiA6IFwiJWxkXCIiLCB0LT5j
b3VudCk7DQo+ID4gKyAgICAgICAgICAgICAgIGZwcmludGYob3V0LCAiXCJyZXRpcmVfbGF0ZW5j
eS1zdW1cIiA6IFwiJWRcIiIsIHQtPnN1bSk7DQo+ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBm
cHJpbnRmKG91dCwgIn0iKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcHJpbnRf
cmV0aXJlX2xhdChzdHJ1Y3QgcGVyZl9zdGF0X2NvbmZpZyAqY29uZmlnLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG91dHN0YXRlICpvcykNCj4gPiArew0KPiA+ICsg
ICAgICAgaWYgKCEmY29uZmlnLT50cGVic19yZXN1bHRzKQ0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm47DQo+ID4gKyAgICAgICBpZiAoY29uZmlnLT5qc29uX291dHB1dCkNCj4gPiArICAgICAg
ICAgICAgICAgcHJpbnRfcmV0aXJlX2xhdF9qc29uKGNvbmZpZywgb3MpOw0KPiA+ICsgICAgICAg
ZWxzZSBpZiAoY29uZmlnLT5jc3Zfb3V0cHV0KQ0KPiA+ICsgICAgICAgICAgICAgICBwcmludF9y
ZXRpcmVfbGF0X2Nzdihjb25maWcsIG9zKTsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAg
ICAgICAgICAgcHJpbnRfcmV0aXJlX2xhdF9zdGQoY29uZmlnLCBvcyk7DQo+ID4gK30NCj4gPiAr
DQo+ID4gIHN0YXRpYyB2b2lkIG5ld19saW5lX2NzdihzdHJ1Y3QgcGVyZl9zdGF0X2NvbmZpZyAq
Y29uZmlnLCB2b2lkICpjdHgpDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCBvdXRzdGF0ZSAq
b3MgPSBjdHg7DQo+ID4gQEAgLTE2MDksNiArMTY3Miw4IEBAIHZvaWQgZXZsaXN0X19wcmludF9j
b3VudGVycyhzdHJ1Y3QgZXZsaXN0ICpldmxpc3QsDQo+IHN0cnVjdCBwZXJmX3N0YXRfY29uZmln
ICpjb25mDQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+
ID4gKyAgICAgICBwcmludF9yZXRpcmVfbGF0KGNvbmZpZywgJm9zKTsNCj4gPiArDQo+ID4gICAg
ICAgICBwcmludF9mb290ZXIoY29uZmlnKTsNCj4gPg0KPiA+ICAgICAgICAgZmZsdXNoKGNvbmZp
Zy0+b3V0cHV0KTsNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=

