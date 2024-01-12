Return-Path: <linux-kernel+bounces-24452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2101682BCBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF60284897
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5957307;
	Fri, 12 Jan 2024 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPmUEzFT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334957304
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705050849; x=1736586849;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0lXKXIe2csSRlWbEgK61uMpa1DLxMbH1dB2HUlb6B4o=;
  b=MPmUEzFTtEBH1VIRb5GJwCdfHnmUKhuNY7+96ygxqDG43Gs30o643F/1
   f8hrcQjfJnjUxDuMbLjS2SXOwEP2dxpN0JUpbSvzFWp/2uSp67Z9b861G
   Ifr9+aeAi9zZdbAakgD5pI5sNAG5371cGxgrQF77LZMVbve8tcVufsDbZ
   RfevjU4ZYNzxM2MwUPpG0s7fS4Sqpc366c0dBj06R153PqhUAhc03aAeu
   2ZxCx/uZopXbamhH1PxN6oLWrkP8PipyQLcWq2Zeb6YkoUVXnmXifY4C5
   vnSMgFYGQ6ENeVBZwPPWDcY8zpgmTtu22qaJALZbAeUOzt0rCYvsBa0M+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5856877"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="5856877"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 01:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="817015778"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="817015778"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 01:14:07 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 01:14:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 01:14:06 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 01:14:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdfaMb4tRNiFFsKrpwcPJV0Olkx5aMZD/GmEfqepoDvPu3hZuMB5jtWy3qCf7CW6rgXzNBfg836JJZao1PHEyFR0693UowEi45I0zBNDQJyjhC72mNuXWqrTzxfoIMWXlGDF0uQ52je2oXbIbiQQjPdhKa18qycV+64T3d/PYYPG538cWXy5xNvKvcDAIFIeYXDS0zSMHH7SruPyL2Lhzn8tcCvTPYtA0ADNjF35CqI/AwiFVLOyUuM/QIO8mZXR4KwQfFgx1fLAxmLfvvw0S73m5BrrQYX1wkHkFZB38daZHpfgrDCgLTUlufGeeLMK7sLTqKqsblFXKCwkfGNXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lXKXIe2csSRlWbEgK61uMpa1DLxMbH1dB2HUlb6B4o=;
 b=FvPhi+rtunG4HU6MHUOHogGvXJPaI47fq/Krsxg/gNt2vnJSU7C+Kz6xXIeVEF+zJDbllMQjjXv+lDrnVPd0VXzQL1bkbgqwih2OtO0qYTqzZIl6axfUBjo91SRejF9IEIE3frLUJaSHCepV5WnvLe4VdTm6TV6LvmDqZzcz7PIsGf4wj2rIUr29IVC56KwwkBmiq5KPF1I0blsk0qgwPPnTp1WvzbB9xelGzsKUSOvKHSk0mYcl+gOEnsEDtOnLjpbOlLgfQhpzXGbA6OVqoqNwaF+tOeL/Orlj43HyzS/Hsow752bUBxpGaJB7QJ/0XwFRdTiZBfi8Jllo5UoP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 09:14:04 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 09:14:03 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "Brown, Len"
	<len.brown@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
	"arjan@linux.intel.com" <arjan@linux.intel.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "Tang, Feng" <feng.tang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ray.huang@amd.com"
	<ray.huang@amd.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"Sivanich, Dimitri" <dimitri.sivanich@hpe.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"andy@infradead.org" <andy@infradead.org>
Subject: Re: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
Thread-Topic: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
Thread-Index: AQHaQjyCF3Nt+9p0tkSkWmDSuvApOLDQAJIAgAAWM4CAAKJBgIACYq8AgAAPKoCAAsAEgA==
Date: Fri, 12 Jan 2024 09:14:02 +0000
Message-ID: <dbad0f6f9dee5851aa21ffae9e8877cf23645af5.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
	 <20230807135028.381851690@linutronix.de>
	 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
	 <871qarlvub.ffs@tglx> <87y1czkdlg.ffs@tglx>
	 <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
	 <87frz5jmnl.ffs@tglx> <87a5pdjk54.ffs@tglx>
In-Reply-To: <87a5pdjk54.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB7366:EE_
x-ms-office365-filtering-correlation-id: 6135e221-a02c-4071-5d5f-08dc134ed1f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYbR+NLqD8Pb7OjeQFzTTMrRUlhqrZfct5uGIgYBRPVzBIAoMb5/43usdSA9BMHCTb6unhx2eCZvmReIX+m/4bdMIQKVvkHA3Sjdrax4TzvZcFmLiRa46NB/WqWkVV42M9mL9KO6slfvAm0qsht1ofZe140/lOamUrn9ccDa7MFPX472qSageJYtU4XWKER0Bk4T1XLht9K3oATxIoqEphvL5vqgIXLlgPCjzL1GKV8ui8sgQS+PAbF96w1dlLeWrzZgyyQBYR/sZlJegQwM7VIhPoGfuSurgNFLgSClhbp+xztNJgJCWFd8dEwDj0Iztb3ck9juEyszAn9nYT1IvUEsokIYMtj7Y0ujFpR7y/y9ND6L9iKGZjiNnJIMOArsbLPQOnhh8KhWpTYSLBGgDx7quCZnr8CETy5XsFAz+wZeJv+8DYZOkfMU1MpSuAFLa5u/3RsGIWrZ6nx7nWQOGwJEnr4VCGaPDN//lQuAxPe02zj1uxCoa4uclBghj86QrxulCAvUlPHnBNNjdBNjkeo7zyProh3LtXqvObuVgbfofi/g7HyIQLlW43I6NCzQ+0lgzAsHXP6PbBzSjbWWSmuMq+cFeAmgNpv3EUd4n1ZUracA9p/4r7YK16BNHTRw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(122000001)(7416002)(5660300002)(8676002)(26005)(54906003)(71200400001)(4326008)(66556008)(478600001)(86362001)(2616005)(76116006)(66476007)(6512007)(66946007)(64756008)(83380400001)(6506007)(91956017)(36756003)(66446008)(41300700001)(110136005)(316002)(82960400001)(6486002)(38070700009)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDU4aVhlWXUyWkxCcy91b3hkblI4QXpEdlNuejhlZU94NFJJekN6cGttTmt2?=
 =?utf-8?B?RW1WMW1mcjBKMS9Hd2VpbHF4UVVmc3RxRzUxY2ducEdBbUYydEpVNDQzdktM?=
 =?utf-8?B?ZkpHWktSVEhDRDBoUU1GYzBhQ2M0SFlUcW9pRFZIY1VRUjIzblUzVzQvTVlu?=
 =?utf-8?B?OHRNbTRwd0VpT1J2ZG9kc0NtTVFNRkIyc0R5NUVYWCsyelF1bnN6Rm9kQXpC?=
 =?utf-8?B?R1J2TG9yRWw0QklTMnlqZEc2MlpjTGFYUzZPL3QxZVFPUnFnblBrVkNuNDNX?=
 =?utf-8?B?dzlCemtVSXg1UDU3T2tmYVJqazRMOEhLU1htV01GMmxEZUdTeFNBaEhjZWwz?=
 =?utf-8?B?b29XZFhuOWYwdFkxK0tEWUJPdkY4NGZEMlB1SFNCSFdYV3labVpubGI0WWdK?=
 =?utf-8?B?dDdjK3lURGVjV2drblZkZExBdVR6SmVyc21rRG1YS0hsRi91VGpWTVVDTGd2?=
 =?utf-8?B?b2JNWnBGbHdKTGt6SzZzTUdVNzVaRjAxblpMNkxoT2xFdDJDcklrcTUwWDNV?=
 =?utf-8?B?NkNMYmZRQmNtNUZPSCtWSFQ4SkVSR2YxRERmaTBDd0dwVEZoWFVoSWYwZ0ZG?=
 =?utf-8?B?OUJJUnBiOWxyUTM5Z0NWMFM4anRtTE1HS2F3SS93WmNnNS9YeG9QbzVXZENI?=
 =?utf-8?B?V1lsaEwxSEUwZTNVa3dRTnh3cG45ZUdqMWJmaFp3dEIwYUtQNUN4Z0V5c1g5?=
 =?utf-8?B?SkU4SEpibXE4cktpM01IdnhkQm0yRzAvd2JxOXp1bTN2TkJFWnN6bGJnOCtZ?=
 =?utf-8?B?cW0vN0EvcExFMVArSHg0UE1zamdmVjRNWlV0MFdFS3BxN2VsLzlzTkJkczd2?=
 =?utf-8?B?T1dLSUk3UTVvdFppZkVEWnA5RDBJUWtJZEJtekVWVUUxOUhIV1NLSURIUVQ2?=
 =?utf-8?B?bGhtdE9tUU1MTWQ1RE1iYkZDZHpDdUZkanJSZVJKb2xDSktXT1Z4clNPTGRK?=
 =?utf-8?B?S29HYWdQUmplYURXMi9YY3J4MXk3bXhHMEtiZjllcVZ3dTY5Z3YxcjdmTm1p?=
 =?utf-8?B?QmthT0VONEFkNHh3Zm5HQ3dmbnBQcitWclg2SHROZGQ2Tm14R2ZwcWFPK0xl?=
 =?utf-8?B?NmZwRGtkVzFKbi8vblZnSFdldEw2bGxLWC83SEVQUGxIR1FKeks0ZUlESnVX?=
 =?utf-8?B?V2kzd05rTjc2Zk8rOWw0aGhETGg2a2NCcWMzWUNMdkFLeGM4ZnNDa2dwM3BX?=
 =?utf-8?B?TFJodlQwaFZJUzZJekhLTzRFR3d3dElleFNJbTRjOUNnblRJRVhGY3RsVDJM?=
 =?utf-8?B?NHNpNTlNRnVSN0UwU0Z1WjVvSmxXOFNQUXFmMTVETC8wSTNGR1lOL0hxbHFG?=
 =?utf-8?B?a0tHajBIWjd0TGlQUUdZOVdCalc5YVJCMnRVZ1hKQklhdzBLbHNXcDRxYkNU?=
 =?utf-8?B?ZFE1anUwYnIyRnNoQlI0L1B2SzcvQmxwYkM3SlpKU3hOK3NhOTV6NnRiZ25s?=
 =?utf-8?B?NmpKRlNsaDdhZzhPeWw2QlBtaTVNbTE1Mlh5NXZ2NmhzM1JoWXU1dnFJOG40?=
 =?utf-8?B?VjNrUVVsNk9EbFRhTkg1THBTSUw5cFpqbGNDY1B3TFpBcUk2cWc5WmxUaHMr?=
 =?utf-8?B?Q2tmTy8wOTh6WGdPNGhtK29QSWhrWG5TR3NNNzJhRkFDWFZBNDZybDJHL1Yz?=
 =?utf-8?B?aWVUY1dqc2lOWDFTZVVQK2NRcVlVU0VSZGZOeDZJZHpyM2xsTG1uSTRTL1JF?=
 =?utf-8?B?Z1d5ME5adkE3ZTJ1ZnRiWmNFdzZPTDg4d0wxZWRMaWFJSFpoOVJvdmtON0cy?=
 =?utf-8?B?QjU1NXY2SVRiczN2TzljZGlLaDR4Z08rSWZ0UURyUUFrL2NXKy9zT2N2aXpU?=
 =?utf-8?B?UTNINkRMcmxtWGgvOWtBakFHcG9zMHhSL3JpSkdXNW0wbm1udENXRXZxdjNl?=
 =?utf-8?B?THFQNXVxV0ZuZk0rdUFjSFRQQy85OTNwVjNMSEFjREREL0M5M1lKSUtDeDJ5?=
 =?utf-8?B?RjdCOFQ1M05LUG9KOUpzWWR2VE1oYWtPbVhjdTFmdmRXaVAwTGFycU1qV1Mw?=
 =?utf-8?B?WFhhakhOM2lsL2xmdmNJNjZ2OVlyYWRXVkpUNlM3aUtLaG1RZ3pmQURuUHRR?=
 =?utf-8?B?NERjNHhFMXFBc3p0ekVURzEyUDhtR2lkWE03c2k1QjNWcW1QanVmMVhUdDht?=
 =?utf-8?B?NTBRTGpHcGJRMWFJUlVEbW11SiswRHY3T0RINk1nL3VHc0FwbkRkRW5BK1hC?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <940805733EAB4C4DA0BEF8F5A9F0B67C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6135e221-a02c-4071-5d5f-08dc134ed1f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 09:14:03.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qba47//89uqu3+6KdFPv6MHb5wM2RGB1Oe032fzHn55x5emb/Z/v/NehQI3KZmaUVLlWdeN7ljaEvPQL+Uthkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

QWRkIExlbi4NCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE2OjE0ICswMTAwLCBUaG9tYXMgR2xl
aXhuZXIgd3JvdGU6DQo+IE9uIFdlZCwgSmFuIDEwIDIwMjQgYXQgMTU6MTksIFRob21hcyBHbGVp
eG5lciB3cm90ZToNCj4gPiA+IFRoaXMgaXMgdGhlIG9yZGVyIGluIE1BRFQsDQo+ID4gPiAkIGNh
dCBhcGljLmRzbMKgIHwgZ3JlcCB4MkFwaWMNCj4gPiA+IFswMzBoIDAwNDjCoMKgIDRdwqDCoMKg
wqDCoMKgwqDCoMKgIFByb2Nlc3NvciB4MkFwaWMgSUQgOiAwMDAwMDAxMA0KPiA+ID4gWzA0MGgg
MDA2NMKgwqAgNF3CoMKgwqDCoMKgwqDCoMKgwqAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAw
MDExDQo+IC4uLg0KPiA+ID4gYW5kIHRoaXMgaXMgdGhlIG9yZGVyIGluIExpbnV4IChmcm9tIENQ
VTAgdG8gQ1BVTikNCj4gPiA+IMKgwqDCoMKgwqAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vz
c29yID0gMHgyMCAoMzIpDQo+ID4gPiDCoMKgwqDCoMKgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHBy
b2Nlc3NvciA9IDB4MTAgKDE2KQ0KPiA+IA0KPiA+IFdoYXQgYSBtZXNzLi4uDQo+IA0KPiBBbmQg
Y2xlYXJseSBub3QgYWNjb3JkaW5nIHRvIHRoZSBzcGVjDQo+IA0KPiDCoCAiVGhlIHNlY29uZCBp
cyB0aGF0IHBsYXRmb3JtIGZpcm13YXJlIHNob3VsZCBsaXN0IHRoZSBib290DQo+IHByb2Nlc3Nv
cg0KPiDCoMKgIGFzIHRoZSBmaXJzdCBwcm9jZXNzb3IgZW50cnkgaW4gdGhlIE1BRFQuIg0KPiAN
Cj4gT2ggd2VsbC4gVGhlcmUgYXJlIHJlYXNvbnMgd2h5IHRoaXMgaXMgd3JpdHRlbiB0aGUgd2F5
IGl0IGlzLg0KDQpUaGlzIGlzIGluZGVlZCBhIHZpb2xhdGlvbiBvZiB0aGUgQUNQSSBzcGVjIGFu
ZCB3ZSBzaG91bGQgbW9kaWZ5IHRoZQ0Kb3JkZXIgaW4gTUFEVC4gQnV0IHRoaXMgZG9lc24ndCBi
cmluZyBhbnkgYWN0dWFsIGVmZmVjdCBhcyBMaW51eA0KYWxyZWFkeSBoYW5kbGVzIHRoaXMsIHJp
Z2h0Pw0KDQpGb3IgdGhlIEJTUCBBUElDIElEIDB4MjAsIEkgZGlkbid0IGZpbmQgb3V0IGEgc3Bl
Y2lmaWMgcmVhc29uIHdoeSB3ZQ0KaGF2ZSB0byBkbyBpdCBpbiB0aGF0IHdheSwgYnV0IGl0IGlz
IHN0aWxsIGxlZ2FsLiBXZSBtYXkgbmVlZCB0byBmaWd1cmUNCm91dCBhbm90aGVyIHdheSB0byBk
aXN0aW5ndWlzaCB0aGUga2R1bXAga2VybmVsLg0KDQp0aGFua3MsDQpydWkNCg0K

