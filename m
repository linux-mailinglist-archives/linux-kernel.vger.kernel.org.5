Return-Path: <linux-kernel+bounces-84460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1B86A708
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E950B29A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230AA1D54C;
	Wed, 28 Feb 2024 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNTRQQ1E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB251CD38
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089698; cv=fail; b=t8yB80U4foNESQ5nKXvKN141XYsqFEfQl01RgyYTXR/5BjOkiPJ5zSUQQnltem0/W+24MhIB2MmMcBNQ4wFlx0tdpKDTH1IY6ri1kdoeuofuVKeU4BZHFinMOvSuTUHDPbljeVAs8WsjhkRf38jOSbvYvHlDc5k6fmSQw5Q02xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089698; c=relaxed/simple;
	bh=96RsPHRvMMnr9TYWdSpjMkCsRqybnAir0fupEDKkeM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uARBEnjvbOs5xU7MUv6LZhiSpoHS4/n9qMceGkBi1ZqCxkFtRZ5NIkVxpZ2WoNW1vN2iIhJTfJznm3sd2r1TELJ8KveZdyccT4+Gy+hMXNcvCYk2EYIDOz6wV40ixrKHkFuYcFHhji4sSQxxbGKOKDR+QCQMXk+6tjPHW2YmFXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNTRQQ1E; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709089696; x=1740625696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=96RsPHRvMMnr9TYWdSpjMkCsRqybnAir0fupEDKkeM4=;
  b=VNTRQQ1EVyY0jAIHJVpbS70sNDd4Hpp5gpW/DHasb3pI+eggRK2nZcZC
   CJQJsx1ivmawpuR/IrOQbJSgz8W7nP33ZTFoNRwj07hHdj7Y1zJMlgsfU
   12Z9Ktf9pM6S6XehGKmPBevVbtAeYvGtRDOuhnW1/GYUX4L40SnILYC1G
   OK9Fi/buZQ3ITCVWG9+sdhrMnhkRXKQFCAjc5LEUMCOzeDbRxunrr+1zr
   JPqYY4CnEM42AwTgOsnQkc19c6VfK76Rzrp+xgwhORpENd9H6Ef2/PiR9
   NSXybEWMlSidG0RPEP2HPCK3CZ1jbWZj1mrTIZXkgETSi3OlynZISGq9H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3395040"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3395040"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 19:08:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7229457"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 19:08:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 19:08:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 19:08:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 19:08:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SL8H7nCCRKsDJWQ3ipJbvJIK+26QFW1Ned9MB3xNrm7JA6869MlRhaPk9qN2bcFEZ9gLIcVX1NR5+qZhwgpgGzs0IDQyweyq96y/n+apoWCV3njATrVsofUZp5Uk/AULGNuav0uRI7GWeSA8Q++2bsOiyn81eytk9ESkdcxWzBQbggpNTswuTG5jt2S/4ite5ism2i48r2kxdugn55POtnIdO3XiHLS1KolgzrQSCOpJ+TS1VY2Ne6HY+SU5LRv78lJDTRthD3ON9eqDzD4CObOJtjGNHhMZAnbqOGwY3wD2mqK7lL79j1dArxrN9/GE/2muMin1rnueboO2l4eF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96RsPHRvMMnr9TYWdSpjMkCsRqybnAir0fupEDKkeM4=;
 b=XkNHbZrUZBMSjw3TD5qa59VBSovqp7CcG4Z7fvqcQwe2On0lq29OEvmnQ3q+wZ/RiQvD4oyXapYolQxtKNhF/DH2H33wHsCBtyCRrD2xBL3uZjsHEYsRIcduA8IXWTdp6eCfGPZXgJGEOoo7uYZJKHLEJIEVsKnSXTkhwQxHzT/9FLWFWAWfnHo9tTQ3hHCv9GC48HRgoXc+EW5VPgTWz2eHk05M1Si6DsEsV5wD2m89To8hLCgItlXOl8JcnpAYu0bEt70C8XSBpM1uuq+tbk1NTCv5qHPameDproTg7mNrxzWxCcDR54NggzEdxAt5kzT6wiLFPduDcqAE77vavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5454.namprd11.prod.outlook.com (2603:10b6:5:399::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.26; Wed, 28 Feb
 2024 03:08:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%7]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 03:08:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH 1/2] iommu: Add static iommu_ops->release_domain
Thread-Topic: [PATCH 1/2] iommu: Add static iommu_ops->release_domain
Thread-Index: AQHaZhfWSts/o3gWZUiBf2rMTcLEo7Ed0cuAgAEoxYCAAB1AEA==
Date: Wed, 28 Feb 2024 03:08:11 +0000
Message-ID: <BN9PR11MB52766698FA25EA5D397188878C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
 <20240223051302.177596-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52766C0E58E2CB6989E0EB608C592@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8bfc031-27a2-464e-b98e-47a7e6a05286@linux.intel.com>
In-Reply-To: <c8bfc031-27a2-464e-b98e-47a7e6a05286@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5454:EE_
x-ms-office365-filtering-correlation-id: a6ccd54a-f037-495b-bcaf-08dc380a7f1d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: us0buXPRv5juGBI3C9M11CzNLN/tEX4Y27f/RBByo/5ltboCtn8sdTuFvaffC/7dAZCN8lpK8aKClaA9LBKJ5rUx1GoUe054rchYO65go/rydHL/7VeTIZa6fiW0of3wy7XFJmw+BhFO8y4y65CsSAJtWBs/wt9GnvhEMOphXM9p1xl/ELKEFqWmtuEzQ6UZiEHpbGEpHqt2WypSNPQnxw5mLeK0puC99AMC0AhQ46zX/I4NP0WQs1Dt+fH5c95UHEX8jXmab8FK/G8LOeNX8iAqy8Jo/Dhxb7PSWExMPVHysmRLWlrIinn2w8YzpIng7i3jcDqAT6rbCtg4+mw41rfQ8b/ZLYCbrGxwSt5C2OTZy/haOv8Sninl5MSbDAyYyIQZtnIW8kP5X/LCXw6S1BZ624mbZqlktSrSrr3AVRMdX7UUUFZjO/L+LUu50VdHeTOtygSeWGzitEvqdRvNTdfDeqVcMcSra4yPIUldO5jN4qMe+eKHIdAJz+cQ+As0TP7mK9UrPVjtaQtOIS4WXbvhrAg9Odt+mFIAV1qSSU9HwDFp+QKJZYrlOw8W3XQJizSiIVmmBCzZNv91Viqh0XXdFNTCgFb/Ih7qhIUshE9PgoI8lsvCkDRRj6RLiZeeG7CXWq7VVT/iySzH3UrlImFHJJgN2lLE+chwC6M9LAfiD3f7EFPVIueoZbBvcI/AKo3HRsHV0n2DCYIyTdsrM5/3ESaz6qG3oJPyG9atxe8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnoxaGJRelZTY3BCMmh5U3ROR3JYZm1YWkNjL2pKcGpaY1hGQU15eVRoNm5h?=
 =?utf-8?B?cUx2dEhjWFBIMjk2UkZNZE5ScFU4N3lWN1BGYmljWFliNURsWXhucDFuTFdQ?=
 =?utf-8?B?OEl4SGt5NjhXQ3JRZU5IRXdPclMyWjF3MGMvdDNja1VBZXovTmZSUG1rcEx1?=
 =?utf-8?B?T3lOUUpXNVhsTWgvQnJ5M2t6ekR3VzFTazVoZklGdzc1L0VuK2dMcGF3OU1k?=
 =?utf-8?B?c01SVWJqNTQ0SmlFQnJyejRKZGwvK0dmL1VudmtxcndkNkJGaGg1akxOMldI?=
 =?utf-8?B?eG5JY0Y4NHhlS21yZncrbUszbjQvV2RRdWtyazZRWWtPck5yMjJwb3ZLT2xD?=
 =?utf-8?B?cUhtUGhzZEI0REp4a09TV1oxekhia3FuOTd6cHdBbWwrTERGRlRZcGJuY1pp?=
 =?utf-8?B?Q2kyQ2NIWSsxQlRiYnVseFZsVkZKK0RyLzN0Q296em04cUdWNTZnT1NmTjJ0?=
 =?utf-8?B?b01WME11TFdPelkyWkkzVnFicDVic3pkRWVCVlZlcUIzWE9RUWZ0dTRVM1pK?=
 =?utf-8?B?Zjl4RFREY0dpZnRsTTk1eVJaa0pybjQzZEVIREYxNzJnSmE3MWF6aWhmYUQr?=
 =?utf-8?B?MHQ2REU2NGNmV2FrbVdzbWpQNG9TaTJSK2N2bHpqS21WMnlpdm00bEJzYzNX?=
 =?utf-8?B?KzlhTDZOU29HSlcxRXJPOWM4ekIrWnNKOWhVK2tncXVhVWlOaGNWaks2SUNz?=
 =?utf-8?B?a3ZnOFFZd3hrRkZ2S1FEaXc0Qkh0RVRwek5RMEtSNEQwSlpMSDIxbEl4QU1q?=
 =?utf-8?B?a2xldHljdFUxZi8wMEtBZ2pqRW83dFJGcnJZRlpSRFhBQ25ueER4WUpSaHVI?=
 =?utf-8?B?MVBKQ3lVeWJhdnNIb3FwN3c1THFtM0hxd3FaMnArVmJRem5yOWsvVVBWaUtl?=
 =?utf-8?B?VlE4L0tiS0owc1JtaHE2aDRIMFJRV0J6TmQvZUpUVlFSV0hzWWgyQWM0SmZu?=
 =?utf-8?B?aVZCVzc1d2luMjFDZmk2ODd3bEhmdnk1dW90S3F4TTllMzVYSU5DZHlYRE03?=
 =?utf-8?B?c29MVm03ZjNMd0h0N3RIZVd1QXVLTUtwaFpKSUd5R3RpNVFVUmZpQUpSYVdn?=
 =?utf-8?B?QXRKcUpiRjFFUlZYUmRBMktWaVJjR0NEUktCaVFXU3lwVjM0ZFB2L2R2Vm9E?=
 =?utf-8?B?L2I1MHZpSkl2SDh2blNFR2xQT0pjUmdFak5SZ2J4Nnl3VFJYc3R1TmZnekk3?=
 =?utf-8?B?Ui9KMkkyTjViaWRPYTlsTUxiYnpTZ1hrZjVJbVIrVCtHTFQ2alJaOFovZk9s?=
 =?utf-8?B?R3RXYnVTcER4WW95UnJDNE80QzJnWW9tTy8vbkU4Rk1sVWdXME4rSE14VG00?=
 =?utf-8?B?bHAyS2IzYUE0U1Q3L3FPekZGZjdOSWh3TjlSUThGTEZQODhlYzZlMnlWc3pN?=
 =?utf-8?B?cHpqQWsxOUtvOU1lUUJseVNIU2x5Y3k0SDVZOHBycW5vM2xuNGZIbDAxd0cx?=
 =?utf-8?B?SnFWakZEWUF0Y1FzZWVHU1BBQ3ZqNnA3c2g3NFBBcGFZYnNwQk9wU1RsM3hl?=
 =?utf-8?B?U2RlZWF5SU1hdEVSb2ZQNDJIMFczR0VzRTBVdmJyN2V6U01GYzV3b0lleThn?=
 =?utf-8?B?UjJIaFM5MDdhWTFnWVFRZkp6MXJxa2tUR0tZVnFrNVhLb3R0N1NCQ2tMek1G?=
 =?utf-8?B?eFhSOGZ4OCtqeFBqaEdJWG9zQ0ZCSHVhM3pFbFRaT2h5QXFqazdKanJ0c2lD?=
 =?utf-8?B?dHY4K095KytUT0ZWMzVEVU1JaUZINmU5NEhhRWY4ajRIKy90RUVZN21XelN3?=
 =?utf-8?B?SEliNVVpd25paThsNm96a1k3d3VaeWU0UGVRUlRXZEQveGY3a0lXUWFScGQ1?=
 =?utf-8?B?VGZwd3NFVkJ0WFF4SThwcW5vRXR3WXVoUVNqcGNIK3ZlYW1BMTZZMDNhdEd0?=
 =?utf-8?B?ZWRwc3BWajRYUUhwUGk1S253N2l1bTJoWGsvNmdYTzVNekZOTE5qYjBNTnlk?=
 =?utf-8?B?dEIreVlzdUE5bndMQ1FhLzRWSTNHZjJtaHNhTkNtRldXby9JU0hlNEdOVzlY?=
 =?utf-8?B?ZVEyOWxYVnJCdXo1YzRPRkx1aWw3QVVvMmZlaDJTYzFvYkdnOHdwbFlhSHVp?=
 =?utf-8?B?SC91bDhRaUR6VmpWOGM4eEdKcmllZERwS2ljelpLeEdiOVVpQStaRk1YRVpS?=
 =?utf-8?Q?a/Mz9pOp6GgQm84l5cq4ORnKW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ccd54a-f037-495b-bcaf-08dc380a7f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 03:08:11.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+VboDJfKFU3K7Pqe8U7QwNyvUZSBy4jN3C/B5diMSp+Xxx0cg3blESjZkiT7NgGrh3Q7g15h/g+iC9+Z+r7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5454
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDI4LCAyMDI0IDk6MTQgQU0NCj4gDQo+IE9uIDIvMjcvMjQgMzozMiBQ
TSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAyMywgMjAyNCAxOjEzIFBN
DQo+ID4+DQo+ID4+DQo+ID4+ICsJLyoNCj4gPj4gKwkgKiBJZiB0aGUgaW9tbXUgZHJpdmVyIHBy
b3ZpZGVzIHJlbGVhc2VfZG9tYWluIHRoZW4gdGhlIGNvcmUgY29kZQ0KPiA+PiArCSAqIGVuc3Vy
ZXMgdGhhdCBkb21haW4gaXMgYXR0YWNoZWQgcHJpb3IgdG8gY2FsbGluZyByZWxlYXNlX2Rldmlj
ZS4NCj4gPj4gKwkgKiBEcml2ZXJzIGNhbiB1c2UgdGhpcyB0byBlbmZvcmNlIGEgdHJhbnNsYXRp
b24gb24gdGhlIGlkbGUgaW9tbXUuDQo+ID4gJ2VuZm9yY2UgYSB0cmFuc2xhdGlvbicgaXMgY29u
ZnVzaW5nIGluIHRoZSBjb250ZXh0IG9mIGJsb2NraW5nL2lkZW50aXR5DQo+ID4gZG9tYWluLg0K
PiANCj4gQmxvY2tpbmcgb3IgaWRlbnRpdHkgZG9tYWluIGlzIGFsc28ga2luZCBvZiBhIHRyYW5z
bGF0aW9uIGZyb20gdGhlDQo+IGNvcmUncyBwZXJzcGVjdGl2ZS4gVGhlIGNvcmUgZG9lcyBub3Qg
Y2FyZSB3aGF0IHR5cGUgb2YgdHJhbnNsYXRpb24gdGhlDQo+IHJlbGVhc2VfZG9tYWluIGlzOyBp
dCBqdXN0IGVuZm9yY2VzIHRoaXMgdHlwZSBvZiB0cmFuc2xhdGlvbiBiZWZvcmUNCj4gZGV2aWNl
IHJlbGVhc2UgaWYgdGhlIGRyaXZlciBoYXMgc3BlY2lmaWVkIG9uZS4NCj4gDQoNCk9LLg0KDQpi
dHcgeW91IG1heSBhbHNvIHdhbnQgdG8gdXBkYXRlIHRoZSBmb2xsb3dpbmcgY29tbWVudCB0b2dl
dGhlcjoNCg0KCS8qDQoJICogcmVsZWFzZV9kZXZpY2UoKSBtdXN0IHN0b3AgdXNpbmcgYW55IGF0
dGFjaGVkIGRvbWFpbiBvbiB0aGUgZGV2aWNlLg0KCSAqIElmIHRoZXJlIGFyZSBzdGlsbCBvdGhl
ciBkZXZpY2VzIGluIHRoZSBncm91cCB0aGV5IGFyZSBub3QgZWZmZWN0ZWQNCgkgKiBieSB0aGlz
IGNhbGxiYWNrLg0KCSAqDQoJICogVGhlIElPTU1VIGRyaXZlciBtdXN0IHNldCB0aGUgZGV2aWNl
IHRvIGVpdGhlciBhbiBpZGVudGl0eSBvcg0KCSAqIGJsb2NraW5nIHRyYW5zbGF0aW9uIGFuZCBz
dG9wIHVzaW5nIGFueSBkb21haW4gcG9pbnRlciwgYXMgaXQgaXMNCgkgKiBnb2luZyB0byBiZSBm
cmVlZC4NCgkgKi8NCg0KYWxsIHRoZSBwdXJwb3NlIGlzIHRvIHNldCB0aGUgZGV2aWNlIHRvIGlk
ZW50aXR5IG9yIGJsb2NraW5nLCBlaXRoZXIgdmlhIGF0dGFjaGluZw0KdG8gYW4gZXhwbGljaXQg
cmVsZWFzZV9kb21haW4gb3IgaW1wbGljaXRseSBieSByZWxlYXNlX2RldmljZSgpLg0K

