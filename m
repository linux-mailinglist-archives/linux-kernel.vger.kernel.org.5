Return-Path: <linux-kernel+bounces-84538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE086A803
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4315288A92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C404A2110B;
	Wed, 28 Feb 2024 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUSQPQpQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9620DE5;
	Wed, 28 Feb 2024 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709098371; cv=fail; b=dXgj+yCyeHDeouKnvcjdgeod+xOrpBeedIYS4xqJzSpToqBlQrUlHo8gR2/HQxeahtIcu1W9S0kDx9Oh+hGbtMyE7qLNJeca9HSD1xiFBUXxAiEdFdA9ieyD0eFvYFXryJVM55eLMtcsGig/wReyS6/lHqj5mQr/S69IKNXy3S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709098371; c=relaxed/simple;
	bh=OBh1f2n1lo0xtjBQCGF2KOkfz2sxBN1/xnEOhR+XNOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYxA689p8b4hgxY7SN5L3CK+5rG4URDTlPXQlqrk97bm4q9italrqbXqbaBH4Et6IuwIdV1KTdZAgUkk8TvkexlX/yIDguhfR4pE2+yZcHnL3ftGko4dAfxsrES0suTx2eJmlM+CWF7sLG5B5Qj+nJ/7zaTuzrbLbFi/1NaB614=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUSQPQpQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709098369; x=1740634369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OBh1f2n1lo0xtjBQCGF2KOkfz2sxBN1/xnEOhR+XNOk=;
  b=bUSQPQpQtdh0WEJZ+ZFRFUzCL/BBn0Qd3HBnBfDsfZTvx0GbpZJ4PHxy
   cpqrwwKLvBQixR7kIm69Y/ao5QBqjQ5aaw7Fq0bQa+Rr+w8gvMU5IwR0q
   xktxVDpqFWYb0tNx2NgJmuKB6qbJTsx7zadUn6XcfHRekolBh1IBqwCG6
   3HFsBFoNDdair3Duu2ic7GWNfXnI9VNuIXvzYqUsfeVEutbLZa54Z58Nk
   ggnCz5t7rQrxtbjGBOeaksbw8LthHT6sPIjDuy2uRZk/FI684fJ8rXssI
   LMm5ljXZuJStp4PcWFVwlv+VKFdng22vQJVVvSdXuKuwOW2auHkwqVrIO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14630353"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14630353"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 21:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7440017"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 21:32:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 21:32:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 21:32:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 21:32:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khPxXsBOtiF1XxsQmoFsFQmo388CMu+l8s7DKIce+Uc/rIBHNtfG9LMsDjjDRdTcpqAvXUUeox3JncwluQjlA7JYFWyNMT/JLDpZvkLhkqcP5r+bAJSHNdyiuWm8X8s4x4/yB5Xp1K2IpUeEUmSLXeHnPP/e4cBbuStoQj2mo4WYUaE/sxNCsXHaA3ce6viI20vm9tz1vSwi1ZWQOv0JQuBFOwe7fuA/cQp94psh7aSVgXFztgwPTtcVQ7azPxFlPwq8/cGLmNMe9XBz6AiVUXnvzD9QuRNPNA+7Z598YF+gYsj2kL7nBylFDRmJ03G+2b1x4DTpWLKN+frGQtg/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBh1f2n1lo0xtjBQCGF2KOkfz2sxBN1/xnEOhR+XNOk=;
 b=ghFNZhmV6kJ/mIfPricG7sVTb0w6cneY8oeIKRn8V73uPvZIQ8ltdZftT3/622BmMT7p+4AI/kGbzEIjep+i38sjENodUKue3lALaan5uZG1aPJRXpNMJVvIN7Amfg+1WZ0a1zd2PKuoO5/CH0JcFB+Hd36a8wONAAx/FyPuHx0gcl3SW4/vz88CWqT90zLjrJGytU6nYbIn5gW1p195WBRvKBRGGGtMjrDT8o1vQ6WzVQDVPxBQGuqJrlyfwHNvxF9IOFWiTPdB+Q3FbGEU6ryRzs3j6HWlAxcFmNvT2nOcXw1iEAY/P44sc2n2TngUiERPx7IYtyf8wbhmvcInnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SN7PR11MB6827.namprd11.prod.outlook.com (2603:10b6:806:2a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Wed, 28 Feb
 2024 05:32:45 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::408e:7d88:17d0:d768]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::408e:7d88:17d0:d768%7]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 05:32:45 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: remove SLAB_MEM_SPREAD flag usage
Thread-Topic: [PATCH] dax: remove SLAB_MEM_SPREAD flag usage
Thread-Index: AQHaZygP3Zag7wDbfkSDMqKL4bf4TbEeZeoAgAC044CAACX8AA==
Date: Wed, 28 Feb 2024 05:32:45 +0000
Message-ID: <11abf2aca138b389d7ab5c2d6b75d82fb6b1bddc.camel@intel.com>
References: <20240224134728.829289-1-chengming.zhou@linux.dev>
	 <b9966efa-8efe-4de7-b962-a6edcf2f6904@intel.com>
	 <e30fa7b9-e04b-48f8-9068-0a7afed2107e@linux.dev>
In-Reply-To: <e30fa7b9-e04b-48f8-9068-0a7afed2107e@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SN7PR11MB6827:EE_
x-ms-office365-filtering-correlation-id: 6de76a8e-78db-4d0e-6189-08dc381eb114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hoDg8NrQ/S9anIkQgpSPn0L+m3lzlETl5vY3pUbVvic+kqcScuoRxtIPZBt/XSugkdT6RMDkRo9OIlVa9oTDpv7W1yDYNGG0mcMG/0mWMDraFs7v3JvMPbLxK5w68HByTs/2xYdgtmsy1mbd4MqjClBgSNB9esbgUBxRDZrursVCK4v1u76xyY7N+zX6nUI7BAaz+2Vnuf3FV+A2VM+DklcQzppXB3K7gZ5FJWBa6TPeA1IoOrVHK0EOpB0lG/rnWyLW1JSxIT4EKdqh1pjTbfCd+Vk9tGwpDjLAHGFCSheJ6gDL2H4P63eNaQHffodw5AkHun04MCQ43Bd1w23ZIX2K4C1GrzOqnfF0pUx67Yak6IZe2Cxe9p7hbcIolYIpJU+aKUbv5oPhP4+D/s+d+thSm/Y8GXDyyiX2iKxK//tsrfdEq/MRdgCu5QQvF1GdLo6wZMKtDPanx1/gYDhTaCV2HHYQwC77tdWt4ndyETLXN1upepzkf9RbNiLS4RrWPofpQQHy25wINHJUYuXmOtVNm5rfDsH9tP0FC5B+rm37ieHQX+GIKg/OxlEdQFEKkO4hmXysbzAVCChwy2+E6/D3Vp+Dsbf/r/KHs6H/23/Q5+5AgTNy5FZOTU8kPSOdN7ihGnPROHi5ITQHp2PKz2DzOiaGzGp+nQhNnPrDTy4e8eFAQEtw9DN1DE0/wKKHAcZsp50bPcVTerXyQ8Jg/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXgwVDcvRkE3ZUJlVGl3SjA0dS9pemE5MGdoQlRWMk5xUkVwMU9HeGhiMHVh?=
 =?utf-8?B?aHk3TFBHRXhwVjMvd3A5NVk5TnpodEFSbGtNN0w2N3lTTjFYSXo1UWtWd0c2?=
 =?utf-8?B?c1RIRkd6aloxR1l2QnBuVkx2K2ZmZ1RET2ZPb0dxY2NjdnBhRWUxLzZWNlBP?=
 =?utf-8?B?eCs0TnlOTHJiajVLT0JTaEs5S1I2a3o1SUtUNm95VU5Db2I4Yi9TRE5zdDdt?=
 =?utf-8?B?bzVPQ0FXbHp3NFJIb1VINkdEbTc0VWFYQ1ZRR3ZiVytTa2gwRzVaMnVZdnlI?=
 =?utf-8?B?bVFyS0J0REptUnRoNW5ldE42clU0TERDWTNVSGhuSTN0cURMWXlhMDJGODVw?=
 =?utf-8?B?VUFMY3JBVGEyVEVaT0s2azlxK0M4UG95K3Q0cW5sMmlYeldrdFI4WlFLeXh6?=
 =?utf-8?B?M3hoY1lqQS9Ib2hGUW94a1o5cTNhK0lXZ3A2TkM1ZENORnF1UGc1WnVPTGRS?=
 =?utf-8?B?Y0k3L293T3hBTDZoazAyRlNtckZNRnRGN3U4VXA1eVE1ODBRalFYUGRlcEV6?=
 =?utf-8?B?RDNhREdCb1dJZ1ptS1A4R3dSU0MwT3ArQmdGUmdINk9uQXA0NEh5NzlWcE5m?=
 =?utf-8?B?VExQdEgrVjAzN2swSk1WdU1MeGppZWIwRFIvVmlZejE4cGpDdnZjNzFreXhT?=
 =?utf-8?B?K29CSWJneWVHVXdzQnRYclA5R0hoQUJVbzFuc21ySzdPdHo0aTQyUzBRbWYw?=
 =?utf-8?B?QWYrTFN4YkJLMW1qTW1xOURiODV0emNDZk9QcXdpMjFXd3EwSnlCQzdCZXRF?=
 =?utf-8?B?V05WdzM0ZUtrMkNmUGFtWjJKdFNHOTljMVZQVGxTNDFTZmFyL0NaTlNyV3lH?=
 =?utf-8?B?M3d5c2Z2d3J4NlF5d283YVBianNHNWhWVm1PN1p1R2lQdFdRM0ZpZDRCV3h0?=
 =?utf-8?B?bVpzWnJaVGkvZ3Bpb1daY2ZuekV0d0Nia3lBbmdQRVZFR2NDUDRTRE5Yejcx?=
 =?utf-8?B?TjVEMWFtWFJGV1dLN3ZBaHdTbUlnYll5N25Cc2FjZGJuMDBPOXIxT2Q4ZXpI?=
 =?utf-8?B?NGphRy9mQm16cDBQOFNmV1NBYW9JT2Z1Wk9qT1NUbEJwVndSQXRsOVdTSlVL?=
 =?utf-8?B?eDVCY1FwajFOclhIQ3k4ZXJDTFNNZm5lclBxNFEvTmJIc2lKYlhFb2R6OFlH?=
 =?utf-8?B?TnAwd2RXd2VRQXdIZmlyYjVEOEtBSkxjWk05blhCamlrZXM4dXJ6S2dHeWd0?=
 =?utf-8?B?Tk5EalVJOW1NUkQ2dGhYV1RYTTVSRUZWWXN4bmFJVFIwbXRRbDhaVUh3VTU5?=
 =?utf-8?B?M2lFNlBtWm1OT25LLytoZHZZZmpZTFpTMW4xT2hoWlF4RjV3aEhjOXdYeURh?=
 =?utf-8?B?M2xQZDhsZzNoVU5WMXlBa0p5WnZ6MVFqclo4aVYxbHJWcHZTbHk3THI2SmVm?=
 =?utf-8?B?Sk5jNHZCSXQ0cFdIVnZ6SXpYblZlOWxSeE5mMkFvK2xnOG94Q2ZtckppOXdG?=
 =?utf-8?B?bmV1bWFuenN4QkovQnVyVzY2Qmdrb0ZiMHpCVTdVazFPNlpJQzB0WjB6N2xU?=
 =?utf-8?B?SzVMZHJpRFFNOU90WHlVeFMzaEdoK21TTjVsRXg0VW5ScDlENmQrbEVZbXRy?=
 =?utf-8?B?cnZocHQyVXhGWWNVQXpBYk1PN3FERUVLWHJOK0c1QlJsdk80VldKZlZxVVlk?=
 =?utf-8?B?dW1ibGxJdlVkUm9QaTdjSFU5L3RXQWk0Z1BPT3ErYkN5TFpuZ3pMNXdQNWFa?=
 =?utf-8?B?SkxoRTF4YlJ0VTFuc1F4N2t6L0xHbERXZmhZdXpSUTZlbG5WSVQ5OE12QnBJ?=
 =?utf-8?B?cUppOE5ncDhUeXlxSTlJOGFZU2RZTDBTbElGb0I0OGdxdmowaXlRbVJkQ2tD?=
 =?utf-8?B?VjFoSnFhY1c4TFNOVHQvZEpyNHV2bFJzbEdRUysrQW01bDN4VHdpa01YZE1W?=
 =?utf-8?B?dnNzNXp0aUhkQ2wyOUl1MDQ4d0h3Y1lSQzVEV1ZxY084bG1scDZzbkExaHJ6?=
 =?utf-8?B?ZW5LUzhJMENxYlJxclVyOWVIa1ptT25NT1hyelJrUVBhMUNWR3U3dGQwd1c1?=
 =?utf-8?B?RzlodmlYc2dvejdZRHZTaW1tSGYwVkZ1N2NBcjRZSG5VT1R6YmZRb0tIZjBE?=
 =?utf-8?B?WDd3K0sxelBBaXRqSmk0TVI2YjFOd25BZkJueE9iSDJkRXJ1c2MxNWN6WllI?=
 =?utf-8?B?bGVaWXdSeFQ5MUNpeTRKTEV3Y1JLeFh6eTVXZHdQNllIQWxGMXl6R3lZUVF2?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4F118C238E75E49A133FE2167D155D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de76a8e-78db-4d0e-6189-08dc381eb114
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 05:32:45.0440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62MeMYcVLDHQcuaC67Gp+BoLEChAyCp+DQUyUEvlGcUCTJw7fWD8C3xOgx4sCNcYSYPGqiMH65z9s34vvFHWioEPbGgFyVSJJkcfKPQklDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6827
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTI4IGF0IDExOjE2ICswODAwLCBDaGVuZ21pbmcgWmhvdSB3cm90ZToN
Cj4gT24gMjAyNC8yLzI4IDAwOjI5LCBEYXZlIEppYW5nIHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+
IE9uIDIvMjQvMjQgNjo0NyBBTSwgY2hlbmdtaW5nLnpob3VAbGludXguZGV2wqB3cm90ZToNCj4g
PiA+IEZyb206IENoZW5nbWluZyBaaG91IDx6aG91Y2hlbmdtaW5nQGJ5dGVkYW5jZS5jb20+DQo+
ID4gPiANCj4gPiA+IFRoZSBTTEFCX01FTV9TUFJFQUQgZmxhZyBpcyBhbHJlYWR5IGEgbm8tb3Ag
YXMgb2YgNi44LXJjMSwgcmVtb3ZlDQo+ID4gPiBpdHMgdXNhZ2Ugc28gd2UgY2FuIGRlbGV0ZSBp
dCBmcm9tIHNsYWIuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiA+IA0KPiA+IENhbiB5b3UgcGxl
YXNlIHByb3ZpZGUgYSBMaW5rIHRhZyB0byB0aGUgbG9yZSBwb3N0IHRoYXQgaW5kaWNhdGVzIFNM
QUJfTUVNX1NQUkVBRCBmbGFnIGlzIG5vdyBhIG5vLW9wPw0KPiANCj4gVXBkYXRlIGNoYW5nZWxv
ZyB0byBtYWtlIGl0IGNsZWFyZXI6DQo+IA0KPiBUaGUgU0xBQl9NRU1fU1BSRUFEIGZsYWcgdXNl
ZCB0byBiZSBpbXBsZW1lbnRlZCBpbiBTTEFCLCB3aGljaCB3YXMNCj4gcmVtb3ZlZCBhcyBvZiB2
Ni44LXJjMSwgc28gaXQgYmVjYW1lIGEgZGVhZCBmbGFnIHNpbmNlIHRoZSBjb21taXQNCj4gMTZh
MWQ5NjgzNThhICgibW0vc2xhYjogcmVtb3ZlIG1tL3NsYWIuYyBhbmQgc2xhYl9kZWYuaCIpLiBB
bmQgdGhlDQo+IHNlcmllc1sxXSB3ZW50IG9uIHRvIG1hcmsgaXQgb2Jzb2xldGUgZXhwbGljaXRs
eSB0byBhdm9pZCBjb25mdXNpb24NCj4gZm9yIHVzZXJzLiBIZXJlIHdlIGNhbiBqdXN0IHJlbW92
ZSBhbGwgaXRzIHVzZXJzLCB3aGljaCBoYXMgbm8gYW55DQo+IGZ1bmN0aW9uYWwgY2hhbmdlLg0K
PiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDIyMy1zbGFiLWNsZWFu
dXAtZmxhZ3MtdjItMS0wMmYxNzUzZTgzMDNAc3VzZS5jei8NCj4gDQo+IFRoYW5rcyENCg0KV2l0
aCB0aGUgdXBkYXRlZCBjaGFuZ2Vsb2csIHlvdSBjYW4gYWRkDQoNClJldmlld2VkLWJ5OiBWaXNo
YWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KPiANCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogQ2hlbmdtaW5nIFpob3UgPHpob3VjaGVuZ21pbmdAYnl0ZWRhbmNlLmNv
bT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBkcml2ZXJzL2RheC9zdXBlci5jIHwgMiArLQ0KPiA+ID4g
wqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L3N1cGVyLmMgYi9kcml2ZXJzL2RheC9zdXBl
ci5jDQo+ID4gPiBpbmRleCA1NGU1Mjg3Nzk4NzcuLmNmZjBhMTViNzIzNiAxMDA2NDQNCj4gPiA+
IC0tLSBhL2RyaXZlcnMvZGF4L3N1cGVyLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZGF4L3N1cGVy
LmMNCj4gPiA+IEBAIC01NDcsNyArNTQ3LDcgQEAgc3RhdGljIGludCBkYXhfZnNfaW5pdCh2b2lk
KQ0KPiA+ID4gwqANCj4gPiA+IMKgCWRheF9jYWNoZSA9IGttZW1fY2FjaGVfY3JlYXRlKCJkYXhf
Y2FjaGUiLCBzaXplb2Yoc3RydWN0IGRheF9kZXZpY2UpLCAwLA0KPiA+ID4gwqAJCQkoU0xBQl9I
V0NBQ0hFX0FMSUdOfFNMQUJfUkVDTEFJTV9BQ0NPVU5UfA0KPiA+ID4gLQkJCSBTTEFCX01FTV9T
UFJFQUR8U0xBQl9BQ0NPVU5UKSwNCj4gPiA+ICsJCQkgU0xBQl9BQ0NPVU5UKSwNCj4gPiA+IMKg
CQkJaW5pdF9vbmNlKTsNCj4gPiA+IMKgCWlmICghZGF4X2NhY2hlKQ0KPiA+ID4gwqAJCXJldHVy
biAtRU5PTUVNOw0KDQo=

