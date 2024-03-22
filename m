Return-Path: <linux-kernel+bounces-111573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B814C886DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA651C20FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637994644E;
	Fri, 22 Mar 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNh//0OX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2120DD2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116455; cv=fail; b=TXAkM0RslPn6oYamCgeMig4L+GarQgM4/G2IhTsVUfplL7tovGXCsTRu5LVowkhVoZshdNSvC2Cq4/XoNdR7gjVl3lszXRa4MdIBls4nbrMWTl/FfRlG1YtFHVfDv2hdIqj553cJH+cJmDKLd1VdKNFun36Tfnmm358KqSh2eng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116455; c=relaxed/simple;
	bh=LHHx962SKU6WKlUxm/ERLIp/bXzSHTS3xzQQnQIm1AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dQZMe/36ocnGgeyRz1gJ1wapcyZpGv11yI53P+MEtaoQ9zynoGR/WpiKvbMgwgALZUwTjUk7MaetzjuyJoSoVSXPxVACPMa297pYgoJknblf1bCwgA1PdVFj8v+b8LWFyfDNohU1GUbQ2uEDJkt6fSzkRDYJXJpIGmvZ/lUX7fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNh//0OX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711116454; x=1742652454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LHHx962SKU6WKlUxm/ERLIp/bXzSHTS3xzQQnQIm1AA=;
  b=LNh//0OXlUdVVw3K2ZzfhJHL/f9YgP6ynHk1LJ4roWNcEgw9DOZaftzQ
   ssjzH+AGKWuAiU4XJzSQq4XCPJZB9JzUj/9kV3LJYzSQcgnBkVqDom8A7
   Tuodc20yWUmUu1Eb19KDbDO9wjApbayEgdz2k3gGPOwqwXfUaPTaiTH4g
   MsdGJNBTokvfvoAIIM3XmiPTO7B/Khxvyg2p6BKV7RopS+pucQIaQ3leN
   2qtcBwP6UcPHbRiZEbYf6wN8VFyL+9PN81rFnAFsuKFMCdEOCuRGdH2uz
   IZT2i794m/ZnCQ7si//ED3GRKZgbxe7gEay4xg0T6KLsPI5DIHUMW5/bP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6373869"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6373869"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 07:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="14832158"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 07:07:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 07:07:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 07:07:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 07:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSLFaKSRbqv1qVktAhwjzjOjvd3vqqWC/h/ZEo613eacbEhIHq+sBLEh/XFvcY43YbexJJjVFxbBSEzV1S6IO4Tv8oKRwcBx8CeAJ3nSp0mrPn8YEXaSvX6tIEt9oGGwQLiSmy7c2Ixsz36qsZvcOkahPWZJikviN5MBC1mIL9GM+4EK+h/CsSAREN+HD4weQZkG8yEwQvVYbjIYrUdFB/TXHqzI4v6xyH/7UTVOQZoKQDyBmGRJZ5jq0moLzh7/8O5nyiAXFVGEoss23Bn4k8Xsq+yuuCqJC1tY6BT3e07R7P9YKIdCoCrp3yL1h51edR5dOhlnWrYGwStW7R7C3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHHx962SKU6WKlUxm/ERLIp/bXzSHTS3xzQQnQIm1AA=;
 b=BxHPgTK36QgihKMo4pA5cUOKvY07yy4YsGNhPev818OCK4uT9wA49jwn+dXnhrJTl6SWdWgC27PNO5sLBW3rkZcBK74e50HMNChbVN9G1XhZ0Xb27nf56LVD3Fu72wb6dHdYuRYYQd4WWLbMwJbnMjanSt+aghx5ilc/sy4NSwjXFrZjFnoOPkTTM2hJcZSHYm9ZC+zKHqZQHuSor8VX0Ins7jrq3njqUwuu6Du2AYK6Jd/poMAGY3KsEuqgToh43s4dIU0KSzX2E2arqiY54S3uhZf9n4CYMr2oeZMXSeMq73E1wKiwjZ3jrTZZVEbTqEJaCsUgf0rp3JKjiGonmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB8021.namprd11.prod.outlook.com (2603:10b6:806:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:07:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 14:07:27 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Topic: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Index: AQHaduH6Cs7bYZFPJUuH5QAqHlZq5rE42gyAgAAD8gCACvjHAA==
Date: Fri, 22 Mar 2024 14:07:27 +0000
Message-ID: <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
References: <20240315140433.1966543-1-hjl.tools@gmail.com>
	 <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
	 <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com>
In-Reply-To: <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB8021:EE_
x-ms-office365-filtering-correlation-id: 8f8a130f-6095-4df4-a84c-08dc4a7967e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lr0YuTLBfTD5HNt7DOsULOrMuQlLd9j4zaqfmtQkfVyzsqlAqZCUUjOzvGRth8Ssz+/H8sYKJgG4S/Mtgw4KOhoFJy+iHC2HNEyjl7B2Cw+axP+PNB1Goif68q4uuzBNpmjjWwZElMmbu+lpsorv+p50cR3VtyL9E9z5N98yxaKzfBQit6hr+Gmq+SS+LCsTjV96VukvaHEw5l/NSjDocaBA68UmmycVJ3igu4WdqA3pG3l+qNeiltcZSDq59r24JAI4AVf0EMTWuMEkRnAlHJs5fMtCzUGOG2Eo/Ia9Nq21tt4rTp6GQns+nN2OCf9uxS4wP/Hav+Y/YBcHRCsD3d5QTVIOzbVhX2yJe1LD62N/m5WJdSBSZO3RlNTNG2SrhJLMECECFk5qsxMc1ChnAbk9VskR8Lzby2Wkunh3IIDolR/I4yp8cVYGaomOrYOFsuHuO3PsuD/iMO/qt3LAbH7XCErmfjvrs/e6KZhtsEW5vb5tHrcG8rAKNjNUW09w/3k4HR9VKTtNd6gDgY1LhVZBaG0Y5vv4H7Dz/c7kyP2xW5P5lbDwAxO6wl6U5Y4f0EId2Uqz9KKM9f6IAPefxCF0CYXNR7Cn4qRx8ANqIWPn6e8YW3n67BXTz1d2dGOzdfN8s7IHRMZVwOJAAy3ctLMPnLMVWIzsFa0CA3YmEFH5P3BBExvCqD6WVNDRJc64q/bkJI05IRqJ/nC6sbiTmu+wXMrgoPlK9jVXLYEDBzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1M2bVd5d1krTVIvZVlDSnpQTWFRR3dxMDFZNEIrMXdBU3J1ODNOYU5uUTVy?=
 =?utf-8?B?Q1ZOQzFOajJWdXRpNFRodXc1OFBRMXRZeDlMdnAwRkZqKzUxMVdaSUVBMkVz?=
 =?utf-8?B?N3hIdjVKUzlxS2VWMThSdjE2bE5tU21OZTA0QmlpWHY2R2RjbHBTQkV5UXRw?=
 =?utf-8?B?bFhIYmpnN2N1UnNFbE5pNmtRcXp5aHNxRU5GalgzK3oxMTRiWG5PeDc3aXNy?=
 =?utf-8?B?VVlkS0VKK29mejAxdjhSWE42c1Y3UmRFZUJhbER6Ym1TMGdnd2lWbWtGRDRQ?=
 =?utf-8?B?RzRhRlpzVlVGY1cyN3NkcU1Rb3BqWTB4UHRlTkxEM2E5Z0czaExFOXFlMDZl?=
 =?utf-8?B?ZUJDMUIyUFdRaFhiV3AvbWkveWs1NE9oeGlEVlRvdFUrbExFcnVPbU5ZeFAz?=
 =?utf-8?B?R29WakM4c2VmaVV2cjNWVlV1Qk5oc3Fwd0tOVDNXanQrT2pNRmN4ZG9oaHRK?=
 =?utf-8?B?Skh3YmNRME01QXRhVG9hMXdmb3dqWFdzTUtkUW1nZnJGTkVPOHkrQmMyVmFW?=
 =?utf-8?B?UFFZQXFVU1FvcDFDaC9UMnZaMWxWSjBKanF6RHJ4SDcwaFRLSTErVE1zSHly?=
 =?utf-8?B?QmJyT29jS3p5TUxnTVhpU3RXWEg3TC9PR3IxSW94a2VaZlB5cW5jU09Vakd6?=
 =?utf-8?B?YlFBTU9scnRMTzZDL2cvT3ZzMm5QajFTT05pWERlby92UHYycEFEZGlHN1di?=
 =?utf-8?B?QSt0VUlpZEpDQ3RYbVpCeXp3ZmpJY1NkTng4bEZHWGxjeXRMRTNrd2FBOWVl?=
 =?utf-8?B?Q1liYWRHdjkyMnpxalpjWWJmbDJKSW5NRUdESml6bGh3c2ROd0tQQWdjMFZ3?=
 =?utf-8?B?bU00TXVabkF2cGlOM3BrQlBxcWdOQkd4MkV3cGVqVldTMU9HSHl5dGp0Y0lS?=
 =?utf-8?B?RTMxeHNRNnhsbFZWeXBhcTI4aWtULzdpYkEvSGtiL0s0YTllTy9HK2VaNU11?=
 =?utf-8?B?bm9QL2huYVJWYmhuTVB3ZGcxRHNPa0lDY0srN2F5WUQwemcrYXNTZ0ZTRVFC?=
 =?utf-8?B?MUJkUGN4QkxvTXVpOUI0a2tneGpSdThPcFpKVHNEMGNmVWhmS3lEejY4VDAx?=
 =?utf-8?B?VEFKM1M2MVlFQUpFTTR0WjNRdEpJZWtnRmlHMDQ3NTJLZUFIQWVnSyszSXEv?=
 =?utf-8?B?bmRnTmtwQzEybFdLb1ptK2NYaExRNWdrc0ZRbkNjbU1Pb0w5eUk5SkxpTGFW?=
 =?utf-8?B?M2VrWnBFZjE4aS9JYlFXNWdBOUwxRUcxTG1oMlhzaHZuYmdmNExJdGpDRlZo?=
 =?utf-8?B?QkpBaWVkL1NsNVpCcUU1UXE2b0dTdmY0YlllWE1rV0VuNlBsOGoyY2IwSCtj?=
 =?utf-8?B?QXlpSXpId1VxS25saVBLcE1Bb2RCdXBRK1hEQ0RlUm9LSjJuRTNJYVE0cXhz?=
 =?utf-8?B?T00veCtuYWxKQi9OWEtzMW80TG4wLzFscUFjQVRwT1lWVjlLOTB0cmg2dnJN?=
 =?utf-8?B?UTJLVnhjRE9SMGdROWU4ekY2RDFzN3d3dmo4ZlVmd2lNL1RWWm8rV0orZms1?=
 =?utf-8?B?bmp3L3ptQ1JkK0orK3A5OWR0VFpVcU5jaU1wMkdoRkN4c21uZG9UMFozblRs?=
 =?utf-8?B?VTZ0UStFWVJBZmhkUXZQcWxOc0t4THVYdmU4QXgrNXlWajJDV0xGTW9JZkVS?=
 =?utf-8?B?UmxZUVpYZWZ5ZWM2R29ERUpqWHAxK1h5d045LzNRWEl6akUza1VSY25BckZH?=
 =?utf-8?B?NmpoU1FScS9ZUi9qWVp2RjFkZk9MS0RvdlQ0MlZRSDVPbGlaK2VtTHdXTElL?=
 =?utf-8?B?SjN0QzRsRnJDMHFDanZ1b0xHd25GVXlYR2dYMDlpNW9Gdktjek1NeWFaN0NM?=
 =?utf-8?B?QlkveFY0WncvQ1pMeWVtb3huY0RLOUhUYm9aS3Q3UDlKSnBtRUxyVENrYVd3?=
 =?utf-8?B?NC8yL0pOci8yaWV2U2d0blAwQVkrcmRHRWI2VFVoWUJFbUV3Z0o1cHJvYkFD?=
 =?utf-8?B?THB5QlhmNS9qWlRGZGZkTkl2T040RndaMnZ6RTYzTUl1cHowdnp1Vlg2b09h?=
 =?utf-8?B?cjJvWmloMVcyLzZlbG5mR0FoNzFmQXBVOTk3Mkw0QWlaeFgrRGNZaExNb2x2?=
 =?utf-8?B?VUIwNVFjUm9kV0s1VWN4aXkvWFJoMUJsMHhtNzRudnM3OG1CczBUNkI1WW0v?=
 =?utf-8?B?NFZuRThEZFNKbDNJWW5LNG5JUFZMdkd3YUd1RlkzMVYrcWtMQ0FTTnhzVy9n?=
 =?utf-8?Q?egnWPo1aTCLlAtL4qsUwYLk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2FE06B33BF66845851789639E37EEA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8a130f-6095-4df4-a84c-08dc4a7967e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 14:07:27.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlOK+7JRD/Km4X25R86vKjSenGQS7k4fwa0TRSQkLk8ZJ5iEr+/j7SWpVLJKML65KjRCZcUHwTQP3rzXqQXcF4UyvEeaXjXTEDnDA9aTOAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8021
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTE1IGF0IDA3OjM0IC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiA+IEhv
dyBtYW55IHBlb3BsZSBkbyB5b3UgdGhpbmsgd2lsbCB1c2UgdGhpcz8NCg0KSSdtIGNvbmNlcm5l
ZCB0aGF0IHRoZSBvbmx5IHVzZSBvZiB0aGlzIHdpbGwgZXZlciBiZSBleGVyY2lzZSB2aWEgdGhl
DQpnbGliYyB1bml0IHRlc3RzLCBidXQgd2lsbCBzdGlsbCByZXF1aXJlIHdvcmsgdG8gc3VwcG9y
dC4NCg0KPiA+IA0KPiA+IEkgd291bGQgaGF2ZSB0aG91Z2h0IGl0IHdvdWxkIHJlcXVpcmUgbW9y
ZSBjaGFuZ2VzIGZvciBiYXNpYyB4MzINCj4gDQo+IFRoaXMgaXMgYWxsIG5lZWRlZC4NCj4gDQo+
ID4gb3BlcmF0aW9uLiBXaGF0IHdhcyB0aGUgdGVzdGluZyBleGFjdGx5Pw0KPiANCj4gSSBjb25m
aWd1cmVkIHgzMiBnbGliYyB3aXRoIC0tZW5hYmxlLWNldCwgYnVpbGQgZ2xpYmMgYW5kDQo+IHJ1
biBhbGwgZ2xpYmMgdGVzdHMgd2l0aCBzaGFkb3cgc3RhY2sgZW5hYmxlZC7CoCBUaGVyZSBhcmUN
Cj4gbm8gcmVncmVzc2lvbnMuwqAgSSB2ZXJpZmllZCB0aGF0IHNoYWRvdyBzdGFjayBpcyBlbmFi
bGVkDQo+IHZpYSAvcHJvYy9waWQvc3RhdHVzLg0KDQpUaGUgc2hhZG93IHN0YWNrIGlzIHN1cHBv
c2VkIHRvIGJlIG1hcHBlZCBhYm92ZSA0Rywgc28gaG93IGlzIHRoaXMNCnN1cHBvc2VkIHRvIHdv
cmsgZm9yIHgzMj8NCg==

