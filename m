Return-Path: <linux-kernel+bounces-110999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32CF8866D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09551C236E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DE79DC;
	Fri, 22 Mar 2024 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvRRnAou"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F62900
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089524; cv=fail; b=dwNLpFkqxPMFPw5JW8vM6N1IlgshEKm7uiwO5RZTedwVLX3Z5yeZ+sat1Ma2sO8M31grE3i3w+y0Vox0iT3MU0FSFzmqHN4Cpna/rhXVjsSrH7UrKcnzTtV1mtAG4dNjNbx7zMabFmBu5uDkkmxsHSNlMT4RHxMsVB+sdjlRCdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089524; c=relaxed/simple;
	bh=CXU0egcYXvvXst9YQF6GMIDVvAI3+0p3Kjw+9INXCYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fxj3rz1QHy7efyTUaKEEslqagwpia9EwGTzazBabIWglEfXL3bC0iQzBPA5L+hVsGzBAfiVxOa6K/1ZhThQZeta/ejUYwnJ7EDW7kLLKtsEzobjnVtRm9DOaNsnPByE0T4Dtdsv/W/cvKVAliSOvnerY2M3n1XXvNeauKOIKAhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvRRnAou; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711089520; x=1742625520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CXU0egcYXvvXst9YQF6GMIDVvAI3+0p3Kjw+9INXCYk=;
  b=RvRRnAouGh8WNt447yfIqqsUHeY6Gptw7vc+6xzu5nEOuO3Ku0z3wFrr
   A7CMBKZNiFNu/2YsGN5hp0TookcFK/O739ObbcMSdHA3/C72unifIUozP
   M9VqiW5rLsR/6TIDQEB9BaZpY8nZnvksLjzxt/WCiWM2SnvZxcBWkDBqI
   ALsFKWYVAtTyN0FGRIbL2c5OCdQV0VC0qcs6Xt1QvcRS+3cLzfFxwfZu6
   OhzQoHY12w5iK9reuWTNWUCG9B9gdWrRgfOs0MYIXtFNKY8Po1GhEtswy
   yvM9mI+OcuUn6gU573dw6qr+GDVwoGYmunABjmbIORhjLY8NJFTleenY8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9925804"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="9925804"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 23:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19250802"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 23:38:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 23:38:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 23:38:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 23:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co7dEmROJfdd7QnmVXhwYS+6obS3TMcVoeAYWQnsq4TUq5L158jfwmcIIQgpz1uc6nVfQoxwKpXTHPLlyMk9MU9KClYkngrsH8YBTb2Orxj1P3ZcYiPS5XCJ6f/BUG6f48VWWREjzlwhu/YdID5I/9UAHAuclTFpVH/Qmzgrn1okDv7wF8blZH+F4Tl5O5EMqFkprmCmwd0/fK3EeSUtqT70+QN1N+HQxV63AbdEBmSTExVxHNRHy+RwkGD1Iw1twiz1231S0GQTdQRUgK2DCfVyQ8R4nm+SatW2TzF71mzGFKZ/iOuxkW4Kws/sU6qdCA5MT2ChID4kau28iA9bMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXU0egcYXvvXst9YQF6GMIDVvAI3+0p3Kjw+9INXCYk=;
 b=bWK72In4UzwR7Fjce9rpQLdpwH2CLFKaoKI2Cr1dl1kVx81aJd94vVMesm0uHXgZFEhwEyTt2VAR8+f7cMTh4Dp7jJKJX7RPPAsYrbJ2EYuRcX5ed4W+5Nk6h7zP3JkpQVRCWgjmyVgZnPlAGU/f8idaHk8X86tqJF4KkIU/ThzQVBo+OV2HoRg3LDAnWvsDQRCqKS6vTuJ4+nFdI+qukHhuW6fgoDJtVrj3OQZevcClYsmL4hICauPZD7MLfZhYmyw0fUWaNTwR9YXQIv1ODBqigCOX48Dbb8wVzYTl7OjQBsw1/Ke9UpGhH+9+ZSjvSIPbkCOGnYGfQdospIM1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 06:38:36 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 06:38:35 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "jiapeng.chong@linux.alibaba.com" <jiapeng.chong@linux.alibaba.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "abaci@linux.alibaba.com"
	<abaci@linux.alibaba.com>
Subject: Re: [PATCH] x86/virt/tdx: Remove duplicate include
Thread-Topic: [PATCH] x86/virt/tdx: Remove duplicate include
Thread-Index: AQHafCC4k6rzMfKtuUq1mS8vYBNM47FDTt2A
Date: Fri, 22 Mar 2024 06:38:35 +0000
Message-ID: <363e70a764b252250dd5f2b91c68c0818b3068f3.camel@intel.com>
References: <20240322061741.9869-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240322061741.9869-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB5923:EE_
x-ms-office365-filtering-correlation-id: a8b11ad8-d7c0-4ca2-0f6f-08dc4a3ab37c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NiQCsubd0P8jbqaWZ/7Hp83LTj8NmHhGxbGB98VKNV9xtOFfJ4eAK/nfF07QxRoUA1FyP/BvyNoBUQ0aMT10B9SNex2o211GtA85sy/AqE95lDXBjxIpzETb0kz2R9qmoXuHQWWq8v8+TI2pr5K3LseV4uTqSyqnxkkVDAuAoFOSuaJwwNFGbG1GIJ7BQf6HhG6K8Fq1d3M4uLEJkj2uwqiuYsFjRGQ+PHk8nnHgtIl4TWpVH1PZaWKlzlX6aex9etIBNtuOKFL0WWWiKKgDjON5c64807gujOqzxuVnQGkc8p639xaKb9IvclpwMXLY8SgweDx0bW9Lli/Wzl5vRnbnYoy/5oHgdjjH3dmMneVXlO3RZ4B5ax+mduumD9d7XckqVt75AlegLLtm8ywLkTvh6w0DmrvlQRvOJvmbwhK0I54HtKuQi7iEJzQsyKBAom5odPVQzHo46FU1urNAm0kB7NFUiNv2D0U0XPpv739i+MSeB0PdF00jYp/w33soZyzaJNxkQSTA94yjCJvceKgCh/4QM5nsQkr+GSj1h1bNyLiu8Q1+z3vMIrApvTiGyiLLPv1dMtaf6CYgc5cN2E0hRY8MtwtAJ4AODYsTiYZ04f3IgW+XACsM5firrTnIRC/88Whn446ALPrF+HtElQyf14Le4ojP/uWTPI8thrY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFlma3laYjNlb0ZuZnNzNFczU0trdVhOa0FNOGxkWVVXNzZwcTRaUnJpbHpV?=
 =?utf-8?B?Rm9TSUFVT0IzTDRGcUphRWtTRVlkeWxjSWErOEI4STFlWnI0cWU0bUxjbTlZ?=
 =?utf-8?B?cHlORVkwMS8xUDVGa2VRaFZvVHhGS0UxdEs5TUZPVGVGeS9GTXdDVHpRdVVH?=
 =?utf-8?B?Y2RCRzExMExlYmZMd2UvNVpXWlo1aFY1SFpEQVdBVGxKVzVVL2RUaDBoQ3o3?=
 =?utf-8?B?bU54NFJDeVVGQXcyQVE0SkNXZWFCZzNmK2hGYzQ2MXNCaWVhdk5NZHRHbllN?=
 =?utf-8?B?SkJqR1U4YmorM1hjRWVMSlZnTDgyZXFlVFBOeUtKZlFHbUhvdDVUUXByajBL?=
 =?utf-8?B?eUhqYW5IamJuQmpmUk11UTAvNVpBUUgrUG1UMHN6MkFVTllyc0I3MUNzRFB1?=
 =?utf-8?B?TnQvWEl1cHRZV09KR2I1NDd4a0tEMVl3K2l6Y1hqMHNzK2hNeUdEb014T2Jo?=
 =?utf-8?B?VXE4Nkc3NDZwZEYybXkzaXZJQUVwUTJiNG43Y1QyczJDU3UvVnNldm9IQWh0?=
 =?utf-8?B?N2J5THZmeWlHNnFRUW5uSW43eU1yU05FREJYOVQ4cm9jRDJBT2ZRam1vVHZU?=
 =?utf-8?B?dGtIVjVySVUzcGgrdnpzZnZVaUFOM09sWVlUK0FCNXIwem5QYU13d3cyZ1R1?=
 =?utf-8?B?VHpmREdiY3dPR2V4a3dZMTk2eEJ3Y0krZEl2a2cwakF0U1NGcmhxTTM0ejJn?=
 =?utf-8?B?U2ZFYzlERks3cGtIRXY5V1VLaW83c0xJREpRYUt5ZC9vaDlaVFh3N2w1UG5T?=
 =?utf-8?B?R1Y5cmpUVDNSZ1JsTzJkWGI2dUx6bDA1UytNWUEvL2NOaG8zcHdsWjBITzRs?=
 =?utf-8?B?U2h0V2RMSHJIc2I3aTFRdlN4MlhBNXlmRkY4SzhLNzFMRXlGaFlrUExuQ1Ir?=
 =?utf-8?B?dC91M2pKMENVSHJ5UjhNbkxjNHhzUUhqaWl3Q2NQWjhFOGorK2s1NlpoYlUw?=
 =?utf-8?B?bmJOMGJMQ2I5TEVGNFhTazNCVTNKQ21EaWpJOVZiSjN2T3A3dWJJYWdpeVds?=
 =?utf-8?B?ekNnWWRKNVdMaFdWY0NzMlBHQzNIaFFvUVV4YzNrZ29YdWFyRGsrcko1OE9C?=
 =?utf-8?B?OHhSblJuOTlhWElpZlIzRkpkUURoaDhYTmxTcGVtQWVmb2NJaFc1RjdmeGRv?=
 =?utf-8?B?QzdLYjFqQjY3NXdNZ2tEWW5MdTh5U2tYdGY3QkVoSzl0ZTh1aFB2MnJVOWpY?=
 =?utf-8?B?YW5OUnJYT0VtNDc5YTVvS0FUN2l5c09VcU44QysvS1pqbnlHYzc4MjhiUXdR?=
 =?utf-8?B?b2dYN0trYnNkVjlBbzhKd0VWK2pHeUNwSmx4MElybWd3NWUwY21tZUtlQkcx?=
 =?utf-8?B?UUJmdHZ5Q1YwRmlWZitUMllVNDJ2TFdRUnkvdXlic09HSHBwTUJSbFUrTXFY?=
 =?utf-8?B?NTNtRThoWm93YWZCeEE5OEhZYkl6c1ZLTU5EOTY4VUVzWEJFUis4TGswbFdJ?=
 =?utf-8?B?SVBaMFFuTDQybnFKNy9rMnp6ZkJCTUJFOWRlVEdnaFNRZFBIOUVnaDZNNEJB?=
 =?utf-8?B?THM2Wm42YnJPYWg5alVUOVByWFNaazIzY1JpWnJIa0NVcm5YV3NZT0V3dGhW?=
 =?utf-8?B?ZTFCazEwVVlMS3RkWGYxT3BXdXBMcXpOMmx2L0JlMlNQTW53RDlJZ1RINVAz?=
 =?utf-8?B?UVJGYWo5cmZvRkF2ZVVKM3dmdE4yVlh3dHN6dGYwNmgyS0dHcDI2bCtIb1FV?=
 =?utf-8?B?Yk42RGxRNWtSTWx5NFBEYlE0bjVxd0NkditXSVV1bG5ERXduNTVRYkVsNmNy?=
 =?utf-8?B?WkV4THB2TG9EdmNWVUpwU25ocnArbFlRaXFkZTVhaU53TExLMGpqS3gyei9Z?=
 =?utf-8?B?WlM2cHBtNmZvS3ZxZDRtTlpvci9KUzBaU2JvQzVlaDVYQ240Z0NiZklqTmc3?=
 =?utf-8?B?cHBLQlBtNjRQdDIwVi95dXg0ZnVweTBoWmR4TFhncHhkOFZ3V01BREUwQ1NH?=
 =?utf-8?B?TVRPTTc1NkpmQ3ZjYlVtQXovMjhVc2w1VjQrdlA5UGlIWVFGUEZNYzdwTmRK?=
 =?utf-8?B?TElhRnNLdyt5YzU0c3hta2lrMXFuZVU0bXJJQ3hOSXp3dWpLdm93elJDNUwy?=
 =?utf-8?B?ZE5lMTg2RDJTb3duM3J5SHlidUNoZTAxMlIyVFZmRTVQWUgyOStOS0ZXcE5X?=
 =?utf-8?B?UytRMkpGbkUrMS9ZZUE5MmcvVFdZakVSUW9YSkhUbXlwZ0FTMEdod3ZoWDFT?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <628A9BC20F7C0E4CA151CB3704F00C2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b11ad8-d7c0-4ca2-0f6f-08dc4a3ab37c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 06:38:35.9499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouIYZcQ6Fp53dSou4vEQNem5K7Gp1iXG+xKYRDcBiY8RMwCSrZah5K4aBiGlr5bJnNOPordU18r6RB6VaOvZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDE0OjE3ICswODAwLCBKaWFwZW5nIENob25nIHdyb3RlOg0K
PiAuL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYzogbGludXgvYWNwaS5oIGlzIGluY2x1ZGVk
IG1vcmUgdGhhbiBvbmNlLg0KPiANCj4gUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBs
aW51eC5hbGliYWJhLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLm9wZW5hbm9saXMu
Y24vc2hvd19idWcuY2dpP2lkPTg2MDkNCj4gU2lnbmVkLW9mZi1ieTogSmlhcGVuZyBDaG9uZyA8
amlhcGVuZy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni92aXJ0
L3ZteC90ZHgvdGR4LmMgfCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIGIvYXJjaC94ODYv
dmlydC92bXgvdGR4L3RkeC5jDQo+IGluZGV4IDRkNjgyNmE3NmY3OC4uNDlhMWM2ODkwYjU1IDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94
ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IEBAIC0yNyw3ICsyNyw2IEBADQo+ICAjaW5jbHVkZSA8
bGludXgvbG9nMi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9zdXNwZW5kLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KPiAgI2luY2x1ZGUg
PGFzbS9wYWdlLmg+DQo+ICAjaW5jbHVkZSA8YXNtL3NwZWNpYWxfaW5zbnMuaD4NCj4gICNpbmNs
dWRlIDxhc20vbXNyLWluZGV4Lmg+DQoNClRoYW5rczoNCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFu
ZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==

