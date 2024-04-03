Return-Path: <linux-kernel+bounces-129567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD68896CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2408828CF97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D291E145341;
	Wed,  3 Apr 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgbIolCT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487171411EE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140425; cv=fail; b=U9g05lnfrBDVddlt8K6njTQfqPb2Ex8wNQNDl0V06u69zQFqCScOqqHL/MGdFYrCrOEUcJzrE3WFzqXQph4a+q6oslJpsOGgqQQxh2VaOJmhgPg7UM1ey8GoLpD/IhzVEjA9ZdgcGdk3/gpTjJJ15oQrha2ji5Ii2N0bGtwmX1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140425; c=relaxed/simple;
	bh=YIhM12Ln8rdrflbNu/wNl2EjmyRB0el3HQvXoVJ2aWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RMqZmQjnHyyG+D9tVhfaRGjwDOeUW0V9DahlmPw3D+C14ZEgpc/ALHhsIozAof4KMgpWaj20dd/v+B1RabIxhdXIDubN7UQMJJ1ejLMQF2fhl+jFXyrKCDcI1LEiBSHOo492jnW54GlgWw9Qz4PRnIAMg5FGE/NTl6V8rOEukD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgbIolCT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712140424; x=1743676424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YIhM12Ln8rdrflbNu/wNl2EjmyRB0el3HQvXoVJ2aWE=;
  b=CgbIolCTOOi7h6x2er6J63BDFIr33iT9sKou0AcR7n9uJqD2nsm4k0O+
   dj8ChKn+NIyFnyIA97gSe9LWaCyQ8EonGh44+Rnj7htJuxluXsgoxxQXb
   9nTH05MWqXeXu3TpWRxbnts4BIa0qALk12sy9jynpf4DC+DA88ynXtTQv
   8PrY+5WZefpjjH2ZuXBPpw0aPHb5/gMcw4SmT224xXP94J1ngrEbHmwnS
   sDfM855mwt6UuZ2xEWS9wKhRe0qGAFapOXkmldfWcmGCKvwTs/xQvcW3J
   BJ1WkqUIbhRfqFnPdNGyvgCSSi3Wt9BOuIoo65VnOMlcOXXrUri1z9boj
   Q==;
X-CSE-ConnectionGUID: ugVHnh46Rz+fJFpR/xsbCQ==
X-CSE-MsgGUID: g/NfWzpdQkuhpqt6uVcnrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18089994"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18089994"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:33:43 -0700
X-CSE-ConnectionGUID: HZb5PTMESe+CIDV6CrqX/A==
X-CSE-MsgGUID: hZZ7lVOlRMyJzfzGa8vMTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="49371101"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 03:33:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 03:33:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 03:33:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 03:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlsK3c4MakPNJ6VaEMUifVj9s63aujIL0WReIhVHmPGu0w94aucn0fAG8qQkNcu8HmWVkh/V9jJXJrCJO+LPvAprXHAYm33JmvjNsrWrAcO6/Fxj6/zTJ+paHSm+j2Dta/Tk8Vs0I83/7dKtuZ4R7ntnTEb/g7KqZtvsME3Z8urU8VF9X0eGaPpM5pfHSvoLBcB0U7wUqm6mJomUPmNkaFfISrVZtbJK6ppByXp7PLYbY8H4tbhAxZu1NCMXrpFvhbzoZBBPUxvOV/Ktg1KXR6OKl1oHi01Gp8H74XWBoaeRbz89Y/btR3/9KGn3nJLAWKMSQOdqtspg4Z2vAKbA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIhM12Ln8rdrflbNu/wNl2EjmyRB0el3HQvXoVJ2aWE=;
 b=HqE2vAPq7vuK1sK9na/B2vLLBH++sAJV86SjywqA3Qerc8cd41Zw02fTVEE639zNhXHUOOSQEmZt6dcHPMkDQFRkP/szVCAJMtLRsolpSlrpxOhwLUCo6UxGmgsUTzp8uAhZZH9RAyi+s5LgIKiBJJNfpDwkdH7Wve40ViDL8QacuTQZUV+eL0CEWVRzC4/+unMt8C19JUXyex0oG1g/V8rTYRI6D2rA+SUT+RKYZYcMQLL4ga6WlSFVX6lxUlLT/MWAmWxScuHb9DUL5IIkWMv719cAmXwZdXmE2pa7rJ1zqYihuOY/0WWVLIYn79sZb4GjHfowD7A0PSviiG7fuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 10:33:40 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 10:33:39 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "jgross@suse.com"
	<jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
Thread-Topic: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
Thread-Index: AQHafIJWxR9vnkP8AUe/IlRDehu0pLFIZayAgAzje4CAASKagA==
Date: Wed, 3 Apr 2024 10:33:39 +0000
Message-ID: <b4c4e16b11114c9a9ad18bb7d8f04d34b7d52331.camel@intel.com>
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
	 <20240322175630.72CE974F@davehans-spike.ostc.intel.com>
	 <d33b97aecfe09cab31ebf06de3e02b633314ae9d.camel@intel.com>
	 <e462f223-7986-4e91-89cb-6274b97c3246@intel.com>
In-Reply-To: <e462f223-7986-4e91-89cb-6274b97c3246@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5310:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WHfpnh4hALJ5hhYLNYy4yZEf1RbKf7zT2xOEawFGyl1ygU4cc89HkR1ojMm9giUhV08CyDS0EjOBUkkvD9n3OOmn+5Z9L88J7JL2zB/mGO43PYElGZxM6XV+bE79/AjSvexl91vIS6xHCfKJZwJ751BP+Rxu4fmN8XH4vrGNuZ3SsMdfrtXbm/Ljgx9zR9ZQt24f6AZo69eNHb+GJuBfJrcvR0NHlTDw9/T3z2TvOMLKxgvGgsy7izCJD8m9lM4jV8A4mWLrbVeWYN0ylqtuhG6zGahbEvE4Nz6XCmD6AMGVDTURy20S5cNXvASbbO7KRiEU5+fuVa0TCYL2dgwKdFDLSv11nWKP8puHjSPHD3nkMdmPMH8Q16GJnhFjRf16XuLKX18dSyuth7kZXpazKto0WwGv62RZD3jcuF7JC8GtEMr46v9RSXTMsCT//42mzx9ZKeWLDq2xwh+dZczCpAFp0tWff5zxdrcsYtRzZUQaM228bxp7dozt9kbfdm+uQ0luOdbVJq3MV769IIrKnu95DtTinmq7MG47/hBssvDyy8dPOiUwXY6JUKjbdY55rRfyq4OX5+oJpa6KZ/+c6nLPQbqWAtOhZliVlYADpUg3cGVeMbTdWll0kcRN6cpxnbR5gov+atrPyi/7nLjwwmHi9j2AjUAvlYcc2bAuVM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1ZMN1dtTHYwLzl4Q1BpQkFkMzdJRkhOTXZDNXBMU0JWTTlhdTRQL3VQbUxK?=
 =?utf-8?B?MVhRbStuQkFPUHNjbEt6ZkE5ck5zUzJHNlBqYWhhQis1UzB1dUJmU0tnaFVi?=
 =?utf-8?B?YnBDNy9lanpMQTdsYUJ4YVpaTUlnSkkzc1FLZlFramVWdHZmVHhsMVVjdEVw?=
 =?utf-8?B?cElEeWc5VVA1ekVWR3BmeE5RMjV2K1pVNitFZkdVQldCT1BiM21VeXplTGd5?=
 =?utf-8?B?STlDOStkSlJ0bE8xZCtvSHVOcUZ5d3hLTUVsaENPUHFpSDRiT253ZERCaWVY?=
 =?utf-8?B?NW41QVRqUjdKTHZYKzFSdWxRbTBOSDlZN0NaRGZhTDdKdWVWM3RkbUl6a2dI?=
 =?utf-8?B?MkdGNlBmVWZxUDdRQURiM1BVY0phMDQrRHY4SDk5Y1M5OFNmWVgvYzVYejd2?=
 =?utf-8?B?VEhCQWdmUWwxbDBieVZiNXluUUZ5TTd3MWRpb1BzSy9BOVdyRzJkRVprNm1Z?=
 =?utf-8?B?K0labEpMUTErRnd2QlhpQWpRY0htNzI0OEFhcUlybTR4eUdzQXVLTVdsOUw3?=
 =?utf-8?B?d1ZNVzNsUEhlb1RzWFNuVjhjYWNvd3MybGczR3N4UFRodVBCNmc0RlhIN2Jw?=
 =?utf-8?B?RWpwNHVvRWZCcGxKbmtIREE2R2kzUU4xZ0tvZ2tWdUJUNTYvRjB2U2FMb095?=
 =?utf-8?B?d3dLYVNqc2RsN1FrR0pvT2Nab3E1dmh4UCtBekhSVFVPaGNUSmxLSkcyTHI4?=
 =?utf-8?B?RG5lWHYwSllxOVJVWkhjWkJiR0dZNjFDbzdBd1VFanBnQ1laNUErT2xDN0JN?=
 =?utf-8?B?Qld3QlRQeHAvQXlsUU8wcmh2bWgzUFpCRFQveDZjdW91U3hGbExnYW9BRCtM?=
 =?utf-8?B?L09KL0FPeldTbm5POTNpVUVRRW9qTWlLckE3c1R2dURiMXAvRTBkSmZFODk2?=
 =?utf-8?B?RTE0NE5iR0t3MmNDSkQ4NkxxeXk0VEZuVHFOZ1NGb2R0MlhVVUluckJ3S0Ji?=
 =?utf-8?B?YXpLMm9PNEI1RjhiQkFmS1Y1R2R0SkFtc1ZCUGVPSnRsakpoc2Myb0xGWkh4?=
 =?utf-8?B?MjJnYkN3UFZvQm9XZCtqeThKZ1NBUVpZcXBVT1hlSWl5bEdpb2lRd092VHF5?=
 =?utf-8?B?Qm56enUyNTUrWEw4enk2dzg3akJHWlF3a0RIdnViYkc4MDRBSVV1bXdjVlhV?=
 =?utf-8?B?N0FIYkhtVk9qQjJCdzhIVlBnSHNNc3phRWRSUmN3WktDMUtMdmJPaXA5Z2Fx?=
 =?utf-8?B?QnlUQmdiNnVsTUxaVks1NzFZUjdGUU5IS2dqdWt0TlVzQzFVV2RINXZaWUJn?=
 =?utf-8?B?WXJ3UXhpRCtMQmc2ZFliaW5zU004LzJzSzJudGcrbjZPNW9xRVVjNzFjWTFl?=
 =?utf-8?B?MVFzRG9SL2k1RXp1QldSc1BYVmxhS0xiT211MFBrelU3L09GRVVCUVBxeHFY?=
 =?utf-8?B?R2NheHhKNkNjNE9LZlVaTXhRODB1ZG5TS3VGbEwxMUFGWk1yTzkzODhlZmFY?=
 =?utf-8?B?ejBoVkRLWVBveVhZVUlvU051cUdiMUFSRm5wTGg2bG5MQmJqbEhMZW1WU250?=
 =?utf-8?B?MURjY0d1KzRyUFhaZlBreWNYSHVOZy9CUEVuekZaeWgwVGdOaVlhZGloZ3Qz?=
 =?utf-8?B?YUowc3pZSzkxbXJ3STdNOWtnZ29TL2dhbGorSGtMelNnQ3p0WUdrSGtiR3Bs?=
 =?utf-8?B?bE5uSDNBYk5hWThCOWxoZkhWcUdrd3ZqRk9Mb1RKZjdRNitYdjFqY2pzb05y?=
 =?utf-8?B?UlQ2YzB6VU9iVnV4YnZhSjBzb0RqOVdnMVhIWE51MlovRENaZU1MVzJCUVdz?=
 =?utf-8?B?cmIvaFBIbExiM0gzR2ZLV3JTWmJwdVFVcHNWR2Y4NThXMk1mTVg5TDB4Sysz?=
 =?utf-8?B?MVBJMEp4U3g4M3Vob0FhaStjU2hLaHQyekRudmYwWTdaRTdGaXJaQkJxMVZT?=
 =?utf-8?B?ZUpWWUJuUzlJRk81ZzZMNTFiSVNCc3FDQ0dzeXVidEZPN2txdWpZQWVXV3lP?=
 =?utf-8?B?Z2NRdm4vcW9HZUQ1N1lmL2paaUtGcnpBWkNpNTcyREl3b3JIVytzTDZ2MjAz?=
 =?utf-8?B?ZUJJeVhKZWtZQW5jNXhrN1Vic2ZwR0dzdi9NZXNtUVA1cHo0Yy9xWWtCVGlI?=
 =?utf-8?B?b01iSnB1dlllL25CckhkeHZlbGVLKzVQWEc5K0ZKQzJqbnFzaUorWlZuNGEv?=
 =?utf-8?B?djdVRVNySitUbWs3OVdQYjNDWWN6dENqVFJHeUJpUVpkU296d3RLbEt4VHJI?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20AFFBFE37449C4F9F537FF44473D4B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e27f76-1f45-41b7-bad3-08dc53c986ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 10:33:39.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTwvK0LGkgQ1Ip/X7Dxnnrb44HE2rlW9tjBLJIEkOT4xL1eFMUd8SLvGpLFz6y6nP58cM/J0ohnhIeWyZx49yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5310
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDEwOjEzIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMy8yNS8yNCAwNToyNCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiANCj4gPiBOaXQ6DQo+ID4g
DQo+ID4gPiArDQo+ID4gPiArLyogUmV0dXJucyB0cnVlIGlmIHRoZSBsZWFmIGV4aXN0cyBhbmQg
QHZhbHVlIHdhcyBwb3B1bGF0ZWQgKi8NCj4gPiANCj4gPiAJCQkJCQkgXiBpcyA/DQo+IA0KPiBJ
dCdzIGEgc3VidGxlIGRpZmZlcmVuY2UsIGJ1dCBJIHRoaW5rIGl0J3MgYmV0dGVyIGFzIEkgd3Jv
dGUgaXQuDQo+IFJldHVybmluZyB0cnVlIGhhcHBlbnMgKmFmdGVyKiB0aGUgdmFsdWUgX3dhc18g
cG9wdWxhdGVkLg0KPiANCj4gPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgZ2V0X2NwdWlkX3JlZ2lv
bl9sZWFmKHUzMiBsZWFmLCBlbnVtIGNwdWlkX3JlZ3NfaWR4IHJlZywNCj4gPiA+ICsJCQkJCSB1
MzIgKnZhbHVlKQ0KPiA+ID4gK3sNCj4gPiA+ICsJdTE2IHJlZ2lvbiA9IGxlYWYgPj4gMTY7DQo+
ID4gPiArCXUzMiByZWdzWzRdOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoY3B1aWRfcmVnaW9uX21h
eF9sZWFmKHJlZ2lvbikgPCBsZWFmKQ0KPiA+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ID4gKw0K
PiA+ID4gKwljcHVpZChsZWFmLCAmcmVnc1tDUFVJRF9FQVhdLCAmcmVnc1tDUFVJRF9FQlhdLA0K
PiA+ID4gKwkgICAgICAgICAgICAmcmVnc1tDUFVJRF9FQ1hdLCAmcmVnc1tDUFVJRF9FRFhdKTsN
Cj4gPiA+ICsNCj4gPiA+ICsJKnZhbHVlID0gcmVnc1tyZWddOw0KPiA+ID4gKw0KPiA+ID4gKwly
ZXR1cm4gdHJ1ZTsNCj4gPiA+ICt9DQo+ID4gDQo+ID4gSSBmb3VuZCBkZXNwaXRlIHRoZSBnZXRf
Y3B1aWRfcmVnaW9uX2xlYWYoKSByZXR1cm5zIHRydWUvZmFsc2UsIHRoZSByZXR1cm4gdmFsdWUN
Cj4gPiBpcyBuZXZlciB1c2VkIGluIHRoaXMgc2VyaWVzLiAgSW5zdGVhZCwgdGhpcyBzZXJpZXMg
dXNlcyBiZWxvdyBwYXR0ZXJuOg0KPiA+IA0KPiA+IAl1MzIgZGF0YSA9IDA7IAkvKiBleHBsaWNp
dCBpbml0aWFsaXphdGlvbiAqLw0KPiA+IA0KPiA+IAlnZXRfY3B1aWRfcmVnaW9uX2xlYWYobGVh
ZiwgLi4uLCAmZGF0YSk7DQo+ID4gDQo+ID4gV2hpY2gga2luZGEgaW1wbGllcyB0aGUgJ2RhdGEn
IHdvbid0IGJlIHRvdWNoZWQgaWYgdGhlIHJlcXVlc3RlZCBsZWFmIGlzbid0DQo+ID4gc3VwcG9y
dGVkIEkgc3VwcG9zZT8NCj4gPiANCj4gPiBTaW5jZSB0aGUgcmV0dXJuIHZhbHVlIGlzIG5ldmVy
IHVzZWQsIHNob3VsZCB3ZSBjb25zaWRlciBqdXN0IG1ha2luZyB0aGlzDQo+ID4gZnVuY3Rpb24g
dm9pZD8NCj4gDQo+IEkgY2VydGFpbmx5IGNvbnNpZGVyZWQgaXQuDQo+IA0KPiBCdXQgSSBkbyB0
aGluayB0aGF0IGdldF9jcHVpZF9yZWdpb25fbGVhZigpIGxvb2tzIGEgbG90IG1vcmUgb2J2aW91
c2x5DQo+IGNvcnJlY3QgYW5kIHVzZWZ1bCB3aGVuIGl0IGV4cGxpY2l0bHkgcmV0dXJucyB3aGF0
IGl0IGRpZCwgZXZlbiBpZiB0aGUNCj4gZXhpc3RpbmcgY2FsbGVycyBkb24ndCB0YWtlIGFkdmFu
dGFnZSBvZiBpdC4NCj4gDQo+IEkgc3VzcGVjdCBpdCBnZW5lcmF0ZXMgdGhlIHNhbWUgY29kZSBl
aXRoZXIgd2F5Lg0KDQpBZ3JlZWQ6DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFu
Z0BpbnRlbC5jb20+DQo=

