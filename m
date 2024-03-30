Return-Path: <linux-kernel+bounces-125678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C5892A96
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702481F21EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD432838E;
	Sat, 30 Mar 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5o9EeJb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C233DF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711795865; cv=fail; b=Fhwum/tUp7m6Nz3dALJ1X6sooc0M4+ruTUU2NxWtA/U9cbAbSE9dQSrzzyZIrZtxuoa9tTOBnMujKY1n5nCAqJLeKKpRkwVozSqhkkOcI99i5v+k0+BKVrvLV2H9vyubu6nkX8JSMqV/dWaxxA6IWEGFWMs1AFA/5K/j8MrW3ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711795865; c=relaxed/simple;
	bh=CgORvOiMMdyozwba72+sWfk5z1bUggHXKML9AFuo2R4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJ2YLCE8paz16bSwEM9gGnGMGeRI5rvUnwJDgirM4qFiFITENB0FBDm6vVCAsBwImpyLE09xZ4iJgT18IG1T5PS2H2UH4REDQQ3eAParBu3eqlOF6xegDZhX+hgiIPblgGSaORb8vfh8Y083Ns7P0aMgtY9odw7rw4oVS8IXa/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5o9EeJb; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711795862; x=1743331862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CgORvOiMMdyozwba72+sWfk5z1bUggHXKML9AFuo2R4=;
  b=c5o9EeJbGNqUFe1a+GgMVsoie76Abahr0ETHcCgqoo2qjgT1hmCo8jVz
   +Ml6AV7QWBA59NTKqoRzSEYSRiF5igQneih/9x5fMNNZFxh1pi4s/Hxpt
   wYtwDsgqnoZ2dDh6Ir4id+Ikd2v6qT79nK6VdQLd68trUqQGFDV/fBfDN
   vfR85MUBDDk48WaE85FAk3FOY6pOIH8N7+S1e3IfspjnAmC0527/VSpaX
   whJYzSDGtsvxA7IaOlQ/P8SY9Tx6W88w0RFEvDc4V4F4JaPLksYcaU6yZ
   Wz6ZcCQNSec0qe6gR0+A7XDEWx3C57NjL+T2yx8QpIiDmXpVgdJV/U8+F
   Q==;
X-CSE-ConnectionGUID: K2NYfIhVTgWdDFiR1wJoSg==
X-CSE-MsgGUID: xFvz3kiFTbGepdKn7qw+Kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6807763"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="6807763"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 03:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="40355211"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Mar 2024 03:51:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 30 Mar 2024 03:51:00 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 30 Mar 2024 03:51:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 30 Mar 2024 03:51:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 03:50:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRtCl5klh3ZMhpeseolMy0o9ULAIvCB6xNc/wCEVBIWmvHoSW4w+f5xTeNXM1vstvX+IYea/MNyZNEB/YBnww6fO/7qdl3h5u41wwhDMw8ulvs3MPPjQsUJ+uzE42jZcWmpXCRhd4vBNZGVIhKqoM11v0NYvAfwcIGq3in6hwHjbiGNK1f81iPjqp7kXx6/aHVz+KMvIEeF9WupEu8OIuNU8KXHio3WN4tIY2ycV0aVu6z7pAka+nNs8tVXOa1ASIBfGR6pESw7qNIlnuhYdKmmt3F4hpK17lQfC7fXqrP1idTj9pT99h3513oDVVc09/G++peU6pKM6u/Lyl5/DWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgORvOiMMdyozwba72+sWfk5z1bUggHXKML9AFuo2R4=;
 b=YOAU+q1ulNlP7Wi6P3+NPlNGfJY6lfEYZsyu7m2eocigrttpSJWPWEa2pmbkcGQAnWvIRp5fWx7RQr9bXQOXFgPQPOd4Yv3tWEOb0mnx0GmHfUyLMp7gk0bIz7atLTpZyHp6PZfNLf9OOgjc+9Lr7xlhu6g5AX2Y/0AaCKYKtW/ychijlRrGN9Uq1g3RhPvCfAG54GdpOjuoltZ+VYNxh66azvc5JeikFr6PyDI+g/CA3uVlZAJ8mPvcJEZo7WA3pr5Fqy85Z6mlEIwzCCG6zudbelzrVfcgujvvsejLPdaa6bmWAK4dO9XtOd0MgdMAYPoOuh+/F5aUuHpJHIGO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Sat, 30 Mar
 2024 10:50:58 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf%3]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 10:50:57 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Usyskin, Alexander"
	<alexander.usyskin@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: RE: Linux logs error: `mei_me 0000:00:16.0: cl:host=04 me=00 is not
 connected`
Thread-Topic: Linux logs error: `mei_me 0000:00:16.0: cl:host=04 me=00 is not
 connected`
Thread-Index: AQHagb5xXYUPlfLHd0KdEFyAoBFj27FQGuoA
Date: Sat, 30 Mar 2024 10:50:57 +0000
Message-ID: <PH7PR11MB76058497570D49516C809BE9E5392@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <4c785706-2961-4eac-b5d7-2cf89c195969@molgen.mpg.de>
In-Reply-To: <4c785706-2961-4eac-b5d7-2cf89c195969@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|CH0PR11MB8236:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFhlf4hyqZV6AqpitHhVS7cOX9HjQVorJClcVje88idkYCu5jICT7gO/QDCNTvcRCuzmRzbSpUvhYssm6WE1XJPLX/CNrZfqxAA3lpmjY0hDwDVw/677139cRvWzl+LqxmA7Qx/8up0vJtbCK8uYL3i2C38TaIelEIX212/AsvyyoOS9QiIilFSYLudcQUMzkyMmpOd/ejNkU20+r6In9nUarvpx68LLL1uTFykK+CwtxNJ3bzQ6GOpyNqs4pAhVXYTYaHqwUkltP2U53qJqLAhABjm+XSdTo5xJMXIcigZyqSj8dAAk0Mol/uNGqpYTcOL2dTJue2jy8tx06bB96upZ4K9pKS6wsipIusY3ecQwsUoX9Vd3T60rrXeQaji6bqvi3sBOVrw2OmviKYpZ2bf4axR9T8RZWPaKFMI0T7eM7vqTlNNcXfDoS/RoiBjYChhnxaxMZkONQpwlGXNc5ql07zpaQYzZ6D7KgDj4R7TIaJSKXhqhaUfq1/oHy7ChIAYkwj+F1vbvQvgXFNN+KC+FlA2OC1u8D8ex4AfCcWywBEnDPwSItZ/4vRsB2v1GcXcdqaCheUKpgmwmjkjtfg5CnFlEwHRwWOKVxYEc0pHAhqrnIAw6af8+HQ22WdQL4/mMXqm9xQsniGnt0q6ANQnGL66K0Zeuvos/qmlHDfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0dtcjFGTUJRM3dkdXdOdkFrTlUwM3hGOHJaM0l5MTl4cUdsenpTOTNQVkJy?=
 =?utf-8?B?QlZ3UzZyLzJVekVpR2xncHprc1F0QlZUMzI0UGpYU1NsS255OWJRR3JOU3V5?=
 =?utf-8?B?Ynh3QXpRYWN6UmcyZzNXZDlLQS9admxWRXhVdmkyZlY5dld6bzFBMklhOGhN?=
 =?utf-8?B?N0x1SGI3aE0rK29uSTV5VEg0V2J6VThDTUxldi85OXJnYmcveDFQaER6TTZH?=
 =?utf-8?B?clZMR1RMbHZQbUFNQUo4Qm9hbFRZeTllTTBtdURVMG9uZFd0VExIa3UrK3hR?=
 =?utf-8?B?NjN1UklZbmhIaWxqeWJRTENRanhYM0J3aC92U0JXaWRWQnFWSzJxS2o4bGha?=
 =?utf-8?B?N1Jmb0hNS20zcjVoVkIvMXRPd0Uxbm94bEY2ZHNQQ2tGY0drQjI2bUFRQTJi?=
 =?utf-8?B?cU44VzAzT0ZsUXlyeFVUc1BKZGtOWWRMYlozSzRhZG4wc1RTZG04cDN3VUZ4?=
 =?utf-8?B?c0IzcnZSRStRcXNlbDg1bXBZOGtMeVBTZm1kNWgxSWRVS0VQNGUwcEtxWThI?=
 =?utf-8?B?eU9oVFJXMWQwLy9heDA4eTBoVTdObDQ0ZTUzSE5kOTlOVXFyc29NZnkrQ3ZS?=
 =?utf-8?B?M3J5SXNicEUrWkJJamhETUZEc21xYngyRUpFTTFiMnhWUXFYTEVQZkVLbGJL?=
 =?utf-8?B?aU1nUDFtTGtGSjJ6ejk1K2RsSGhIK1RFSFRSRkpBOUVRaWdQLzgzS0lVTFp3?=
 =?utf-8?B?SW13ZWIzUTV1T25xYXdrMTcwZVRLTm8zTHVoRHRVM3lWTTgzd0ppSTJ0V2h4?=
 =?utf-8?B?a3pOMml2VVNTc0VlaHlXZ0c5UGVZbkpCZnZ6ZGdNWnVTVSsxUExzWm9UUzQr?=
 =?utf-8?B?OU1uVG96R0RwSVVJTzJBY2hGVGQwNUxpcHJxWmQrdGZ2MitBNmpCZS9kQ0NZ?=
 =?utf-8?B?dHhoR1FPdHgwc21TSXM2YnJJSEdrZ2NSM1BTVWhvVUF0aithbkpGWGpnamoz?=
 =?utf-8?B?Z3U0b0Zpb0xZNWtqcUg5MWRpRVl3SCtHSzlNcnluTFlTaW5rSDN1VHc1ekw2?=
 =?utf-8?B?eHJaMTVpVXI2T21vaFF1SHVGRDEvV0J5UzJvV2pWZml1aWY5R3JjeFBDRFkr?=
 =?utf-8?B?MnZ0aGhYQ3RSTlBJa1Z4MnQyVDF4SzlsQmtXRTdBNUJFMjA0YzdvNWE1UHMv?=
 =?utf-8?B?YUY2SzhCQmtiTFUrQ3ltQVpKV3dPZzRnVTlVZVBtVW92TlkxNGs2QzhJblgw?=
 =?utf-8?B?bjE1WUcvOW9ZeDNiM3dRMXNnWEljd1RqMzZ1MVM2N1UvMUVBd2lHeStUaHZ0?=
 =?utf-8?B?MlBJVzF3bnN4MWV1OHJZektVbnJITDlHVWFZcFRZTkNmZTRuS2YzRWRDNkgz?=
 =?utf-8?B?YkFWb3hmMVUzUk1UUVdMOVdLNjZ2d1g0SzJFdi9remRKTEJlWDNwNlN1VGRD?=
 =?utf-8?B?ZkMzWENyc0pXZWpwRU5BRzFPR05QOEZyWXdCU0pMNExtWnVFdkpJN3FzbjhI?=
 =?utf-8?B?a2RQeVZyT0xUT1lVSHhKblZMQTZGSzVsMzA1N3lVVHdDRzhSTUV6Z0RKcmQz?=
 =?utf-8?B?bk1xTUo3aUZiSmlWLzJ3eUVGaUZGdjJGZFh3bEpZQnJDOURST0JZTTNmTjRS?=
 =?utf-8?B?REJYSDRmTWRVZzVBdnUxd0ZkWndJcWVjeG4vbUwweDZZdUg2OXcwbG96cUZx?=
 =?utf-8?B?ay9nNVFuVFRCbFZ0WFJsTk1La213L0dYQjNjUXJzUVR4Q01nNk93M3ZWRzZq?=
 =?utf-8?B?Vi93NURObUx0TklNajhMdmhqN01sVUw2VUtMdzdyWjhTNjE1Q1JtdWdXdHFy?=
 =?utf-8?B?anZGVUNhTi9JOXpQNXdITSt0d2xaQUtuRlVIRWJTNGs3U1ZTelMxWURRRG4z?=
 =?utf-8?B?N0d0eVVjdm9ZSkVVNFoxWHNWUkR4N2RISWVMRmViU3ZCeTVEbERka0NVY3FL?=
 =?utf-8?B?aWIxcnJ6ZEhaK1g0WUs2TGJrWnpKcG90Q1JsWmtNdW10RGdGTVVkMU41YUEv?=
 =?utf-8?B?TmRnTlk2UzRJcUFsbW0zdUd4a2Zib0laWi83Q3piS01KaGQ1N2RVV0VnUHNl?=
 =?utf-8?B?akZUN043VjhPK1lpbVNkbjMyQ3RTUWNicWZ6anBhbGFEMDFaVDRqY3p2YzZ0?=
 =?utf-8?B?N1Q3dXRhWXJPOXlaSHlNQzRjak15Z2VKMU9OSFFZekErUkZLTHBvZmlYM2hm?=
 =?utf-8?Q?fbcOaTrXo2X/I1FmfKBbHKgAx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389d5172-8ee7-435e-499b-08dc50a74806
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2024 10:50:57.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLLzLUl9FpnpR75l4l7FkKocZEXiGhRhFfUpvxxMOEMCTMHYvnynSY/aorPp93OPr99YWIzzsb/buHv5UQZw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVu
emVsQG1vbGdlbi5tcGcuZGU+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjksIDIwMjQgMTI6NDkg
UE0NCj4gVG86IFdpbmtsZXIsIFRvbWFzIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gQ2M6
IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IExpbnV4IGxv
Z3MgZXJyb3I6IGBtZWlfbWUgMDAwMDowMDoxNi4wOiBjbDpob3N0PTA0IG1lPTAwIGlzIG5vdA0K
PiBjb25uZWN0ZWRgDQo+IA0KPiBEZWFyIExpbnV4IGZvbGtzLA0KPiANCj4gDQo+IE9uIGEgRGVs
bCBYUFMgMTMgOTM2MC8wNTk2S0YsIEJJT1MgMi4yMS4wIDA2LzAyLzIwMjIgd2l0aCBEZWJpYW4N
Cj4gc2lkL3Vuc3RhYmxlIGFuZCBzZWxmLWJ1aWx0IExpbnV4IDYuOS1yYzErIHdpdGggb25lIHBh
dGNoIG9uIHRvcCBbMV0gYW5kDQo+IEtBU0FOIGVuYWJsZWQuDQo+IA0KPiAgICAgICQgZ2l0IGxv
ZyAtLW5vLWRlY29yYXRlIC0tb25lbGluZSAtMiBhMmNlMDIyYWZjYmINCj4gICAgICBhMmNlMDIy
YWZjYmIgW1BBVENIXSBrYnVpbGQ6IERpc2FibGUgS0NTQU4gZm9yIGF1dG9nZW5lcmF0ZWQgKi5t
b2QuYw0KPiBpbnRlcm1lZGlhcmllcw0KPiAgICAgIDhkMDI1ZTIwOTJlMiBNZXJnZSB0YWcgJ2Vy
b2ZzLWZvci02LjktcmMyLWZpeGVzJyBvZg0KPiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQveGlhbmcvZXJvZnMNCj4gDQo+IEFmdGVyIHNldmVyYWwgQUNQSSBT
MyAoZGVlcCkgc3VzcGVuZCBhbmQgcmVzdW1lIGN5Y2xlcywgdGhpcyBtb3JuaW5nIEkNCj4gbm90
aWNlZCB0aGUgZXJyb3IgYmVsb3c6DQo+IA0KPiAgICAgIFsyOTM1Ny4xNzc2MzVdIG1laV9tZSAw
MDAwOjAwOjE2LjA6IGNsOmhvc3Q9MDQgbWU9MDAgaXMgbm90IGNvbm5lY3RlZA0KPiANCj4gVGhp
cyBzZWVtcyB0byBiZSBsb2dnZWQgZnJvbSBgbWVpX3dyaXRlKClgIGluIGBkcml2ZXJzL21pc2Mv
bWVpL21haW4uY2AuDQo+IA0KPiAgICAgIGlmICghbWVpX2NsX2lzX2Nvbm5lY3RlZChjbCkpIHsN
Cj4gICAgICAJY2xfZXJyKGRldiwgY2wsICJpcyBub3QgY29ubmVjdGVkIik7DQo+ICAgICAgCXJl
dHMgPSAtRU5PREVWOw0KPiAgICAgIAlnb3RvIG91dDsNCj4gICAgICB9DQo+IA0KPiB3aXRoIGBk
cml2ZXJzL21pc2MvbWVpL2NsaWVudC5oYCBjb250YWluaW5nOg0KPiANCj4gICAgICAvKioNCj4g
ICAgICAgKiBtZWlfY2xfaXNfY29ubmVjdGVkIC0gaG9zdCBjbGllbnQgaXMgY29ubmVjdGVkDQo+
ICAgICAgICoNCj4gICAgICAgKiBAY2w6IGhvc3QgY2xpZW50DQo+ICAgICAgICoNCj4gICAgICAg
KiBSZXR1cm46IHRydWUgaWYgdGhlIGhvc3QgY2xpZW50IGlzIGNvbm5lY3RlZA0KPiAgICAgICAq
Lw0KPiAgICAgIHN0YXRpYyBpbmxpbmUgYm9vbCBtZWlfY2xfaXNfY29ubmVjdGVkKGNvbnN0IHN0
cnVjdCBtZWlfY2wgKmNsKQ0KPiAgICAgIHsNCj4gICAgICAJcmV0dXJuICBjbC0+c3RhdGUgPT0g
TUVJX0ZJTEVfQ09OTkVDVEVEOw0KPiAgICAgIH0NCj4gDQo+IFVuZm9ydHVuYXRlbHksIEkgZG8g
bm90IGtub3cgYXQgYWxsLCB3aHkgdGhlIE1FIG5lZWRzIHRvIGJlIHdyaXR0ZW4gdG8sIGFuZA0K
PiB3aGF0IHdhcyB0cmllZCB0byBiZSB3cml0dGVuLCBhbmQgd2hhdCB0aGUgZWZmZWN0IG9mIHRo
aXMgZmFpbHVyZSBpcy4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgaXQ/
DQoNCkxvb2tzIGxpa2UgYSB0aW1pbmcgaXNzdWUgYmV0d2VlbiBzZXR0aW5nIHVwIEhEQ1AgYnkg
Z3JhcGhpY3MgYW5kIGRldmljZSBwb3dlciBtYW5hZ2VtZW50LiAgSSBkb24ndCB0aGluayB0aGlz
IGlzIGEgcmVhbGx5IGFuIGlzc3VlIGlmIHRoaXMgaXMgaGFwcGVuaW5nIGR1cmluZyBwb3dlciBj
eWNsZXMgc3RyZXNzLiAgQW55d2F5IHdlIHdpbGwgbG9vayBhdCB0aGF0LCB3aWxsIHlvdSBiZSBh
YmxlIHRvIHByb3ZpZGUgbW9yZSBkZWJ1ZyBpbmZvcm1hdGlvbiBpZiB3ZSBhc2sgZm9yIGl0Pw0K
DQpUaGFua3MNClRvbWFzDQoNCg0K

