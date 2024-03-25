Return-Path: <linux-kernel+bounces-116994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48988B2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC254CC33CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE0130A6B;
	Mon, 25 Mar 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7+5Ja5r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B71304A1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369460; cv=fail; b=WSX5ZUlUlka4WkgMm9C5JJndVbuNcoMnwqQha91TKn0CFbzq9AsfAJUsO0axGczEm02gaolxhkl1rtLgxXiOosuOgaVDvbjc//5V/LiA/y1wB/NvrCg8j05BkD9N3ggT9NtowmArXBxhRw9N0FCBuj4UT83MZIo1cL0LeIAx8Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369460; c=relaxed/simple;
	bh=eCiE+khXO2LG96vV4xNZhkKKjw8oP2tMngZ3waMP7RY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhpqBMzqQOuV3yrS3trkCMUdPdJvjao98sTlpHM3TPhf0pz3laVeofPl0MFqX6ZuGL0IL/emM/4QCZ9KQikKKUln1N9sZrYBMoO9xdcKlfoFcu0OhIALtb8tobutv9+K1jKhPK1kmCSBIbcqbLb5vtYOwmaSNs+2HIwGarcf/JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7+5Ja5r; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711369459; x=1742905459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eCiE+khXO2LG96vV4xNZhkKKjw8oP2tMngZ3waMP7RY=;
  b=Z7+5Ja5ria5zsBDr20GCLs+JqQlnwupe0ZpV8h6w2nLKMD4LjAF3Oz4I
   spDHPkPpqL3JsmuvDCgwhPpkFJ7srbCIjf0CkoUilYD3U3G7lde3keatx
   Vl5TVX8IaUfuZrpBXPYDTP0PBjAEijYoogLjoNRmi8iX3SRevt5xiPyQQ
   O+cRFlmcsYJN5Ai6b/1Hfbwfu5Gj4vSoyWKpA8i1r7NnPpDOxAav4B2Gc
   LTwAla4xAnJ8U4M1K8hbCI4+iYV9alGO+qxFPRNwpgXEQsnG4nyXtjNoZ
   Rn+K8GMLnR7xMgDE6k3l4MJ4Q130cykS3Kiyf80sqHrTnq4lGO15s9vW0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6301471"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6301471"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15681780"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 05:24:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 05:24:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 05:24:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 05:24:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 05:24:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf+PMRUGJ8A9sMpxH1dtwKLCq8pT/oAoMVrlmcESPToGHwO+FSECXkZ3h8gw9KQXTYI/3UiG0YDPTNV0uNRKass9hs+CkDpqdSscKT1Z/Nkr1enZTMXs9sB2IHm5JjC15H6JdIlVGO9GV/uv5iCtQ/GKukyl6keMCpoHiQLmnrLKjRUtfXSV5ukkiCFso/4iynLeH2gB+Op0fLG36sV2EmfI1InOqCDi5hqsVRnrs6nWiY+sRd/q99FW0IvEOlloOcKkoDdxEaiEGsScUvgfvS/da3fvGfFI1jyGz5HvIvEPQObkWRkYEXPoDTYJzltbAkFDbZlOjcIWiKOD6xI9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCiE+khXO2LG96vV4xNZhkKKjw8oP2tMngZ3waMP7RY=;
 b=KDxzieMw6ZNoiFez2RUsdZkkxwHIapZJ+wBL3cPuzfaRO4E+ay4Z1AQO3zmabzb27/R4M704UQ7xfHLcI6fusBNbEKDUKPJ1zUmtxlNoXFHTVnT+aKUa0PJllpjNZslFwE+164bZAv7g6nxSlf2f04KtSLAPK+eogcpD/gADTfNb64MZS+1Gz+5uZxeJH8kPson7T2j3jEOdn4Opn5y2hXUzU2hbVBT0N66BeNvbgYxEsNe2e9c2VlNwSvbWa1NNakr3BwjeefTuQZnUfnP4eG+o2GkC32G0ve7FSUWuFDm/Tq0YnAuUTq5CfIxBlx5F6K0wmkJJXC8oSt48/ERq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5230.namprd11.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 12:24:15 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 12:24:15 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "jgross@suse.com"
	<jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
Thread-Topic: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
Thread-Index: AQHafIJWxR9vnkP8AUe/IlRDehu0pLFIZayA
Date: Mon, 25 Mar 2024 12:24:15 +0000
Message-ID: <d33b97aecfe09cab31ebf06de3e02b633314ae9d.camel@intel.com>
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
	 <20240322175630.72CE974F@davehans-spike.ostc.intel.com>
In-Reply-To: <20240322175630.72CE974F@davehans-spike.ostc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5230:EE_
x-ms-office365-filtering-correlation-id: 10da0539-8fb2-4c02-d8b7-08dc4cc67c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l3lWvmgUHWAAB9b/PIC8dJijtHvyDE6o4pHJ6vBXI/nT+laZSAbjWFQNNimI1yvWBIDyceN5go55IwYvJQ5Vq1+P1EF6BOUpFRb0JDuQDnZrRY9UwSUP/pDt/thQsd91VDtPyQoLyeg5Pqy892wvaJy+OH75NhUPV6yr/ryOkN5sfLFqSqbqJrSLw14Un5qitzDHORv9XH1WmuoyJPatsEYQrdpNTzg1+3vMz0MSl5U3qbNlskMocZ1SUiTFgveWmTal0rt5YUidT8RwoArF+fMyVeUcJeWVsPz9L1Zs5OMskfRvgZ2TnlVrORr/Q7HS8B8wHXuq12pjPfpz9rllt4qrwWdpgGNaaXWl2bs3gKOCifVXKz8R8moMex/lauuV+vaQuclNc27n3CR0mBnbCMUypQ2zuEio/EeDnphMlU3ee0SznP0Y7rhIR60xCZa6+0UbfhWKY5Jjefnxv57GeUZWC4tENRPfZJ5iPV0LOG4L2nt5sOfYGBUz1H5Km5XKzznaSmYzmoBuLoSUFKSP87A3HBm57UeO75HQ+GKkreV21d94+0x3WWXjMWdjQ8UXgHaAeYkEXxGpsC5zUub32BQDpYO7t1Ovxs+a04aJNFr9D75gqOoB93PxU9XqIVDucD1AMwiKqcGmQDsZsEc4DJDflbQKlsjAZx389nanH2u3TVvwgCHwdCogdwad7nAjIE4KAYg7TSv/89w2X1STLSgd/VMUtEqeWlaK/X0QkGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTB5cVpuR1ppbTlza0dJeVdES3diRUNpdWJZaU85a2VaR1ZOK01pTUFMVTVV?=
 =?utf-8?B?WW1LS3orK3hHcGtMSi9jV21BbGRLbHYyaGZHY3ZPSzV4YVVuUFZOYmxsbUND?=
 =?utf-8?B?c3RvTHRZT0FQaDJPTXdCTkk4c09YOWQ3d3doang1a1dZSzdWaTNvaU4ySkt0?=
 =?utf-8?B?UmNONnJLNXZPenpaZ1IybUhVOG9kV0RCZEJtUklaYmRVWnVnTWNqVVNGUVZU?=
 =?utf-8?B?MlU3dHU1bHFkV0ZUOVJWSEVZYjViRGFoWnVMWUtQL215bHE5ZGc3ZlVKWlpi?=
 =?utf-8?B?TEdkdysxa3BLOWVGZVNtZHZyQlU3dG5LOXM2L29QNGRXamo2Ym12NElDUUEw?=
 =?utf-8?B?TXlzT1FNcEJKbTU3L293ZVcyOG1lUFdEYlh6TUsrV3VlZlNWT0RadVZyenRs?=
 =?utf-8?B?U0VqeHM3UFVMZEVnTkJkU3RDcUhmMHMwQ1BhT0VpM3RWYUZLS3llekR5NXhW?=
 =?utf-8?B?b3FvNjNiQkRWQm9SSFZVU3YraWRoNlU0RVVaWjg1QVZ1N0FoZnhxZkpwUVpU?=
 =?utf-8?B?L2FSQlFpSjlSZFhXTmg0WTlLWWVKbnlVakxMcTRZNjMveStsd21JUFo1TEl3?=
 =?utf-8?B?NGgxQTlOaHJUZ0pRMGJhYU5Dc0E1S2JZM1lrZm15dnFMRmM5MjY3cFN6eStV?=
 =?utf-8?B?NTlHYTZ0WWl1ZVdMSXFmYVQ2WHZzQ3dxTFJtVjgySFVtS2g4RjR2cnRzVUEy?=
 =?utf-8?B?SCt5Mmc1SVRPamMvS09RRHZ0d1JTSk1TTHZYYXBYWFFSbjJSYlFnOVE0aUhP?=
 =?utf-8?B?LzUva01VRm05R25JenVRd0M2NVBWTHRJNzlCUCs1MFg5R3ZwY1gvdzU5V1FC?=
 =?utf-8?B?c0NMSUhkQzk4bVF1aFZ6ZE90NmUwWi80eGhWZkluMlJOTUV3UmtIL0Zsb0E2?=
 =?utf-8?B?cFBvWlNDeUF0ZDVNd0VLNWJURnQ5bU52cW00cVZtNDFlVFNzYmJuYndVelVw?=
 =?utf-8?B?NDdSVmxrWFVPVzBnUGRWUUR4aHdXRXhudC9mcUZEUmpyNW1MSUdld1ZPaXVP?=
 =?utf-8?B?L3hyQXNoUWkvNFloNFAyUmF6aG5JYW41ZGZ3RTE3ZThPRjR1cjNTRWpibEFP?=
 =?utf-8?B?ZWlKbUlJTmxLcVFDTk42KzRjeXJrcGRMUDFDcUxlaXhjdVdiWGhGUFJRc0la?=
 =?utf-8?B?cVMrQm84dytLOVk2VDhiNms2MVR6aDMxTGxhN29GWWtYSHJqc1JCdk1Wbk5a?=
 =?utf-8?B?LzUzMW9vQXpPYnhSZUVDbFZLKzZuSXl6dGJWckxvcjFqMkF0b3ltL1RGV1hC?=
 =?utf-8?B?NXo1TTZDZlNGUzRrbjJORjkyRUZxdDZtbzM5VGhRSzE0a3ZmWFNvSWkyR3Uy?=
 =?utf-8?B?RWR6WWdHWU9Ma1FEdldaZCt1ZkwvSkNDak9IWkJDWDA0Nnh6MEN5cEdCNUVX?=
 =?utf-8?B?THp5SU1TMXpCNTJvekQ1M0pMcDArWlhDbWhNcE5QQUdoZm5JMnd6cmhIR1lP?=
 =?utf-8?B?MVVEdzRRVmdsQ2QxNWFHS0JrcWM1UTJEdlh5TUlRM3lvbjlZNnk2MnVTb1gv?=
 =?utf-8?B?YWhOc2g2cEJIeDhrZlpueERzQ01HTHNMUTlyWGY0cnpteFpTNm5GVW9XcXpI?=
 =?utf-8?B?MWVjcnh2UnBsb2I5cWRUNHo1bncwLzgxbW5aT3NDNFhmMldkMW5ra0I0LzVI?=
 =?utf-8?B?eFJIN2xrQmtPSDROSjVuTndZR3JlSDdPYmRkMFMwV2Z0S1ArWi9yTXREOHBw?=
 =?utf-8?B?NU02Uk42STVGS2U3Q29HVDRDWTFOLzkvditLajhsUENTc0R6Tkhqdm1PNHQ2?=
 =?utf-8?B?RSswRURpRkZXMEdhdXNGeEJMODA5Ty9TVUxia3B6TUdnbkhlQy95THh2UTYy?=
 =?utf-8?B?eTE0a1BWUTB3Ymh6dU8vMlRoTEtXNlpBV3JwTEZaZEdMTnl6aURuK20zZ0Nk?=
 =?utf-8?B?RWZFSk1XT2ZuWmtQelhnRnpnOGpqRXA1K0twVWhzc1dYWG5zNFVuelJ4eC9R?=
 =?utf-8?B?RkxjTUJyUi9TWVZLWGJkN1dRM0RIRTVYMXhvekt0SzN5U1d2MFZhSTRaN1NS?=
 =?utf-8?B?TnFvT3RFdjExRUk0VEMxUHBKNUMvSzEwWktBTlp5cjlWdUlQN0JZYTlmSFgz?=
 =?utf-8?B?OHJhUkhQY2I3cTN3dHZXS2NjWmVLNU5qbXY5amZnb3FFbndnNy9mWWhubXFI?=
 =?utf-8?B?WXc0UWRJeUhKR29oZFdsR1ZlQi9heDNPTDJjYUR2RWsxb3NHUms4aEJVMSs0?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <802E75211C89554780A51970DD9E3244@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10da0539-8fb2-4c02-d8b7-08dc4cc67c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 12:24:15.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nn3tIcekrSlT5qyxsLKTBcmqqtg825CklSCZBDmSQo7r+Po2AJ3ZKaBF/NiZlWF/iqNmZYWfQJdvgY7O96PkVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5230
X-OriginatorOrg: intel.com

DQpOaXQ6DQoNCj4gKw0KPiArLyogUmV0dXJucyB0cnVlIGlmIHRoZSBsZWFmIGV4aXN0cyBhbmQg
QHZhbHVlIHdhcyBwb3B1bGF0ZWQgKi8NCg0KCQkJCQkJIF4gaXMgPw0KDQo+ICtzdGF0aWMgaW5s
aW5lIGJvb2wgZ2V0X2NwdWlkX3JlZ2lvbl9sZWFmKHUzMiBsZWFmLCBlbnVtIGNwdWlkX3JlZ3Nf
aWR4IHJlZywNCj4gKwkJCQkJIHUzMiAqdmFsdWUpDQo+ICt7DQo+ICsJdTE2IHJlZ2lvbiA9IGxl
YWYgPj4gMTY7DQo+ICsJdTMyIHJlZ3NbNF07DQo+ICsNCj4gKwlpZiAoY3B1aWRfcmVnaW9uX21h
eF9sZWFmKHJlZ2lvbikgPCBsZWFmKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwljcHVp
ZChsZWFmLCAmcmVnc1tDUFVJRF9FQVhdLCAmcmVnc1tDUFVJRF9FQlhdLA0KPiArCSAgICAgICAg
ICAgICZyZWdzW0NQVUlEX0VDWF0sICZyZWdzW0NQVUlEX0VEWF0pOw0KPiArDQo+ICsJKnZhbHVl
ID0gcmVnc1tyZWddOw0KPiArDQo+ICsJcmV0dXJuIHRydWU7DQo+ICt9DQoNCkkgZm91bmQgZGVz
cGl0ZSB0aGUgZ2V0X2NwdWlkX3JlZ2lvbl9sZWFmKCkgcmV0dXJucyB0cnVlL2ZhbHNlLCB0aGUg
cmV0dXJuIHZhbHVlDQppcyBuZXZlciB1c2VkIGluIHRoaXMgc2VyaWVzLiAgSW5zdGVhZCwgdGhp
cyBzZXJpZXMgdXNlcyBiZWxvdyBwYXR0ZXJuOg0KDQoJdTMyIGRhdGEgPSAwOyAJLyogZXhwbGlj
aXQgaW5pdGlhbGl6YXRpb24gKi8NCg0KCWdldF9jcHVpZF9yZWdpb25fbGVhZihsZWFmLCAuLi4s
ICZkYXRhKTsNCg0KV2hpY2gga2luZGEgaW1wbGllcyB0aGUgJ2RhdGEnIHdvbid0IGJlIHRvdWNo
ZWQgaWYgdGhlIHJlcXVlc3RlZCBsZWFmIGlzbid0DQpzdXBwb3J0ZWQgSSBzdXBwb3NlPw0KDQpT
aW5jZSB0aGUgcmV0dXJuIHZhbHVlIGlzIG5ldmVyIHVzZWQsIHNob3VsZCB3ZSBjb25zaWRlciBq
dXN0IG1ha2luZyB0aGlzDQpmdW5jdGlvbiB2b2lkPw0K

