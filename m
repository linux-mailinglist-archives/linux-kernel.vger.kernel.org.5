Return-Path: <linux-kernel+bounces-43035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC2840A90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548991C21C16
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192C155306;
	Mon, 29 Jan 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cb2TR7rQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23F153BC4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543453; cv=fail; b=DQSMRoLb117zuiYE4skmFYr1aiIG+2fA5icdsf7LZdQVQ3Ph+TO5JDc243Pf9oLfqjOC8BoKTmmjqE2klkwjmd8stC6qZZkPOOWgsn6UmpLDGhwTZNOHt+3BtN+C5A0TN4FxoVnKUj2LWyTnPwgOYsDzVfK3O72r37RbXiXEwgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543453; c=relaxed/simple;
	bh=Z5zDwhe6+1dipvfhUJw0+Fcws+ygtXATpaJPlmYESqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j3ct4zHvrrzX+evbPaMcsXnxDDCw/Y+v2wg4+BXm4lPfDJ/YZlQtgS6qfx8yIh5YrUIa5zNqG170/Te+0upN8CG9d9oa1cJUp8I5NhcPfdH0CBfTM3jgNgYMQjzLczqP8/2HO8RK7hNu1VjfLLMJAqm6+vTRgZrpwFMv/hkPikA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cb2TR7rQ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706543452; x=1738079452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z5zDwhe6+1dipvfhUJw0+Fcws+ygtXATpaJPlmYESqc=;
  b=Cb2TR7rQd3IhymlIPF3Lx4RLooQMuzweTNd3sFH+u2+xqa7Tnacn6ef8
   dmpFGTpAQHw5mDsZ6nWAifHrraOnDO8LenrDMQez7yE73LoB0h/hd746S
   DMGKPbzhpFiDeKg55YKsEm8dRHpqxMWDr059VRVw/3J5sEzUiIezYhsFM
   9lDmtnzgk001u8VQYl377nuKUk4rAidG/0ssy5XbcoABfYZLt00OeW7uD
   BLa+lYDuTMjl6CfAfCR91rchXG+C970IYy9sR1OdJacvCX/HYrTX7JvP8
   b2wT2ClUIr8mhnmqtRA6ReSP0Zy7GPLSuFt9nIMLp/dB43l/cCto2dwqd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10366301"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="10366301"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 07:50:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="1118968904"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="1118968904"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 07:50:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 07:50:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 07:50:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 07:50:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9Qbp+6RnbjouI8K1u0VdySS3a3FpmDQJAXrVs2CntvjcERN/pZb6clTl6C8w6D5INzQigzGujzBCa5iGwBttesfGkJtnpwJScoM6hOoLicGuceO8kf+uox4H+J8peBVRKU5Tio0CCqmwaSkTBONQ917l1uOFDN3uGErX4SDA1YNMYLWy329DBggkCWV/VB+ZOQPk3otP/PH69LLPa9oeuq7yNa0PQyFYvI7d+5QzHnAsreuPF0/utaKxSXXpEmxUsfAGLUCwvhBr3pNkDtEv7LIWTaA5gDNGih///mNJSEfdPf3D5l8mzowDU3VlaPSn8zRhOm/oJLpAPGP673xYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5zDwhe6+1dipvfhUJw0+Fcws+ygtXATpaJPlmYESqc=;
 b=TWCxmEqgVSalsya58Hw/J0aJ6orCMMFwuh5vXkD0RrMx57xhlK76iYLPxFy9SYLDjDbjOff6T58+38FgGxeUodj+x9lLCw7fgpPMVLEbLCP97J+919Bobm9VMyp2D582jm6q6S6ML9HeWtyW6kBcgwLg0KuiCT0UUruySDCoyjqaceZ/OZDrj83hWdHyXWecGp28XiIgM407VBBrAFIbZMTGGBrvhMCY6onw3klaKA34HBZKXIsaL+9sotbiZv1pED28AIRlgjJAnbaxk1HTWTBDvb76XN1Irv8C0CN8LMUVsFVE/8rsj28XyZ+ZK1nlDyJv1SlY0HnrI4sVmIYAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by DM4PR11MB7350.namprd11.prod.outlook.com (2603:10b6:8:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:50:46 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::98c3:e090:252e:7967]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::98c3:e090:252e:7967%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:50:46 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, "rafael@kernel.org"
	<rafael@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
Thread-Topic: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
Thread-Index: AQHaUGnvD6KpJFNbfEC+CMX3S25457Dw9QIA
Date: Mon, 29 Jan 2024 15:50:46 +0000
Message-ID: <37eb0ef396054d3e74b390c6d2a29f08c8c5fd32.camel@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
In-Reply-To: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|DM4PR11MB7350:EE_
x-ms-office365-filtering-correlation-id: af4a2b10-a888-4194-ad2a-08dc20e20f11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/n5L14dATEwrE8ONQIH3IOjMnoNGzLwxcZTDavY99Yfgm/diXyPYO6ejqP95Vu/+L6tQ/TDL++5Aakd8Mxdb8y5RWJCUGFq0mQ/IMCvTnGYbek+30neFRHKDtKrMvkjMUuJ6JBuueeDQxE5LtRUFqb0F95cIiOhQH9ySbqrS4sKT6OKZlX/3N+niTFGM6nNYR3GDDlWW2AabFGcFP/FW+Qj5ruMovLBN+3qiQoOtWiiDzsaBYyXM82cGdjZq1pIdwlsN7UeWiZhjU11sBhlKf/FMZQ9osfIcXJizWtDIfz3HKOzUcS75TJZ7vDFYt7avLL5WuBSgW5FDVp8Jr2lIwDMcq2b2TDs9+B+Phf9BCr7DWzFk+pHWk9XWwZiEOBRghncYY2slIuap/s2pHeHnbDEtihX+PYwZqDe1zGnzLIrm23Bg1x1Akt3/wg4osuhQCswAkoL7rMkwoLAgB/YtRSmUnPLdBlh8c2M+yPWzgWyzk6iQ3R5wVlJInt2fZVRxtElutQLhnUymv7FCbQS909xQoL+wz4B1DQmVBY7MNTr6Du2l/FD+psNRQClpL2xu/5gaWWc20BGjS46Ljw/lfKKE3w2Kq60xwVxgc0SHX5C9gtidYoZRxRYQpto42JXCZ8zyPipGgJktBR5JGJSFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(86362001)(82960400001)(36756003)(38070700009)(122000001)(38100700002)(26005)(6512007)(2616005)(66446008)(66556008)(6506007)(6486002)(2906002)(8676002)(478600001)(110136005)(76116006)(316002)(71200400001)(54906003)(64756008)(66946007)(66476007)(41300700001)(8936002)(4326008)(5660300002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlRnbnVKZGt5Mkdod28rSGs1enA3VmpDWk1lRDJXL3Q4b0N0NnU0TjVvTGJw?=
 =?utf-8?B?TGV3a2lFM3UvZkpUb1RVeTl2bHIwWVp5YXQyMFdSdUgybThVeXozKzhYRWNn?=
 =?utf-8?B?N3Azc25HejhvUmFRRUM1bmlQeFd4WWI2L0xndmRjVjhRZzZLbW5WR3VyYkhN?=
 =?utf-8?B?bXpOS09LSDE1U0xYSW9DMk55VWhHS3F5d2JzcElaVVBDSVhwMGVhTFRsQnds?=
 =?utf-8?B?eGhXQy8zNGt6UlordUMydENkallwMUM4dWJYby9BdVJNdmRsWTBOaUFTOXA3?=
 =?utf-8?B?cmVYZUR2KzlOWE1WdVFxUHpjUVNDRkZMOHU1L1daZGtZNWp3UXJwTUQrYUgy?=
 =?utf-8?B?L1AxV3dKdjhBcHVQd1JRVEdXWkFqblFXVTZwSU9MeU1PMi9EZjlBTXFlbkZQ?=
 =?utf-8?B?akh2enB2NGNpYzhETGJ3WVAxTkJkanhER1ZZbG5TbWRTZnZibmM5dDV2bG1D?=
 =?utf-8?B?ckpZSHFldmRzOGFhaTBxZzgwSXhSWS8rM3l6Q2JSMDNJalBNSE1xcUJheFpD?=
 =?utf-8?B?OFpiam9PMmhZZForeGFVVjY5R0ZwTjdqYzRLUlhXTS83VEFEbXpyRkM5NDNy?=
 =?utf-8?B?Z0Zra3o0QlM3RVJaZEJmQ0dtNlIrZVh2SzVzWEVmTVR3ZVNXbjQ5MHlyTjZa?=
 =?utf-8?B?cTBuTWdtdzE1TVgySEtWMlpQbTR4NzhJNytyNGNLQXl5Q3R6ejRkN2JnWHp0?=
 =?utf-8?B?L3RhQ3BOM1J5VklKSTd2RWh3TFNUT0puY3J0d0RGRzE4L1FtRXhwRTJRNGJD?=
 =?utf-8?B?bTN5N0tSTnBPNW5lMTdzeVdOd1FQVlFacnA3VWtWZEJuZWY5RWY1SVg3aFIy?=
 =?utf-8?B?VUo2NjFzZWI1M3ZycGdvWStpbEZFblFYQUZaOVAyRWIxM205a0JNWXV2VXQ2?=
 =?utf-8?B?QXVXclB2RVN4Y05WdDB5K3FTejZ1YmZSYzdzN1NKS1ZuZnNkbXJPTE5TU0lV?=
 =?utf-8?B?L1NhemREL2owODJvNVlLZU5HMU1lR0Q0SnFNSVE4YWxUaEFoOUpkZkNScmt5?=
 =?utf-8?B?MHppelJpYmNJbXpuZHJpRXQyVVpidEpJMzcvMms2UUYrejVBTzZORDczUUZ1?=
 =?utf-8?B?ZUlHVEtvUXYzZXZhZmhYY1pBZWU2VTU0Vmp5aWR2NnZnVUpWS2pZd2JldUVk?=
 =?utf-8?B?WUxZaWhsN1lNbGlyOUJKa0pWNlhYaURmVDl5NXloMUhWNHBEWVY4VWJTMFA3?=
 =?utf-8?B?TWdLRjZXV2tXYVFQZTdaZVl1clFPbHIxbUFVdU9hOEpXVnNJTEhleE94UFg3?=
 =?utf-8?B?azl6Nm1wWVlENG5SZkNDeUxXT29CWHBUcjVLVEl6SksrZ3R6MDhDNXFoZHFx?=
 =?utf-8?B?cTBnbjBkd2NmSEtCRlp6MG1lVDVqQ0Jja2wvNkZvRlM1UUdLQVB3MUFiWkNl?=
 =?utf-8?B?aVh5bnNXd2NRa2huYW5ONTEyNjJrdkZTblozWkhva0VWUnB3aTVDb1JwcGVz?=
 =?utf-8?B?Rnpna3laZXBFOXRpektINk5kbzJPaGF3YW5LSzFoaStmMDNvenlrU0dtaGZO?=
 =?utf-8?B?N25WbS8reDVnaVFzVy8rWWQ1T3lWRm5reXNrUVp5Y0xNRjVaUi95ekNXcFFt?=
 =?utf-8?B?QTV6ZjM4aGpuWTd1bzF1VnpoMGdFaVlHQlRORkhkeGRyZGVpK3JhM1YvYUE2?=
 =?utf-8?B?TEg1Q1RpaTdIYUdmVjZ4SDZUOGlXZHd4VUlwNTBLY20zek02eGZtT3kxUHgw?=
 =?utf-8?B?MWMvR0VXTFF4V0YwdndlOUhnckc3QUpDOXFRNnIwR1RNMlNaVzNobTQ3Q3Zu?=
 =?utf-8?B?aE1Ub09GWStLOW0vQkZqZGJ3ajJmYXhRb21KK0ZsajNQODRNaEpVY1pXU0ds?=
 =?utf-8?B?aDVoTkdBazhaSzhIYjFraERvZkM3ZEVyR21WcGJXT3Z1aHk2eTZ4Z21UOE15?=
 =?utf-8?B?ejF4cjNTV21CY0s2NGlSS1JHUGF5ZFJ5WUFlQ2ZsbHBCWUNBZXhSejZjOWlO?=
 =?utf-8?B?Slc4bFFwZUhGdUpVTEFRTklJNzFqVDNudFdyS3MwNXlIWU9JLzZvT2g4dnFM?=
 =?utf-8?B?aEpBSG96dWR3aGVuc0IzVDBhZ28zUjFHOENxaE5Cdi9oREpwWWtzZzBJZElV?=
 =?utf-8?B?alh1TjVSOXYrdlpxdHFITjVGMXNGejVkcnRkSmtTK0pKdFVwWlQ1MDVrbHFo?=
 =?utf-8?B?VW1Gc2xmU1Y5aGVMYjFsNXpTS1l6WkRZUXZTTVNmRlY3NUdyR3hKZmNNUVBV?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <599F758814F8ED40A6D40F100DBAE7B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4a2b10-a888-4194-ad2a-08dc20e20f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 15:50:46.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 952NYnbrTCGdadJFyIzLJLm0hEyIUd10CKIU38K/gFiznxMwXrpR9IqEmVKLFWYpyP8a2voCPA3GHmDYBPeKSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAxLTI2IGF0IDEwOjExIC0wNTAwLCBSb2RyaWdvIFZpdmkgd3JvdGU6DQo+
IE1ha2UgZGV2X2NvcmVkdW1wbSBhIHJlYWwgZGV2aWNlIG1hbmFnZWQgaGVscGVyLCB0aGF0IG5v
dCBvbmx5DQo+IGZyZWVzIHRoZSBkZXZpY2UgYWZ0ZXIgYSBzY2hlZHVsZWQgZGVsYXkgKERFVkNE
X1RJTUVPVVQpLCBidXQNCj4gYWxzbyB3aGVuIHRoZSBmYWlsaW5nL2NyYXNoZWQgZGV2aWNlIGlz
IGdvbmUuDQo+IA0KPiBUaGUgbW9kdWxlIHJlbW92ZSBmb3IgdGhlIGRyaXZlcnMgdXNpbmcgZGV2
Y29yZWR1bXAgYXJlIGN1cnJlbnRseQ0KPiBicm9rZW4gaWYgYXR0ZW1wdGVkIGJldHdlZW4gdGhl
IGNyYXNoIGFuZCB0aGUgREVWQ0RfVElNRU9VVCwgc2luY2UNCj4gdGhlIHN5bWJvbGljIHN5c2Zz
IGxpbmsgd29uJ3QgYmUgZGVsZXRlZC4NCj4gDQo+IE9uIHRvcCBvZiB0aGF0LCBmb3IgUENJIGRl
dmljZXMsIHRoZSB1bmJpbmQgb2YgdGhlIGRldmljZSB3aWxsDQo+IGNhbGwgdGhlIHBjaSAucmVt
b3ZlIHZvaWQgZnVuY3Rpb24sIHRoYXQgY2Fubm90IGZhaWwuIEF0IHRoYXQNCj4gdGltZSwgb3Vy
IGRldmljZSBpcyBwcmV0dHkgbXVjaCBnb25lLCBidXQgdGhlIHJlYWQgYW5kIGZyZWUNCj4gZnVu
Y3Rpb25zIGFyZSBhbGl2ZSB0cm91Z2ggdGhlIGRldmNvcmVkdW1wIGRldmljZSBhbmQgdGhleQ0K
PiBjYW4gZ2V0IHNvbWUgTlVMTCBkZXJlZmVyZW5jZXMgb3IgdXNlIGFmdGVyIGZyZWUuDQo+IA0K
PiBTbywgaWYgdGhlIGZhaWxpbmctZGV2aWNlIGlzIGdvbmUgbGV0J3MgYWxzbyByZXF1ZXN0IGZv
ciB0aGUNCj4gZGV2Y29yZWR1bXAtZGV2aWNlIHJlbW92YWwgdXNpbmcgdGhlIHNhbWUgbW9kX2Rl
bGF5ZWRfd29yaw0KPiBhcyB3aGVuIHdyaXRpbmcgYW55dGhpbmcgdGhyb3VnaCBkYXRhLiBUaGUg
Zmx1c2ggY2Fubm90IGJlDQo+IHVzZWQgc2luY2UgaXQgaXMgc3luY2hyb25vdXMgYW5kIHRoZSBk
ZXZjZCB3b3VsZCBiZSBzdXJlbHkNCj4gZ29uZSByaWdodCBiZWZvcmUgdGhlIG11dGV4X3VubG9j
ayBvbiB0aGUgbmV4dCBsaW5lLg0KPiANCj4gDQo+IA0KDQpSZXZpZXdlZC1ieTogSm9zw6kgUm9i
ZXJ0byBkZSBTb3V6YSA8am9zZS5zb3V6YUBpbnRlbC5jb20+DQoNCj4gQ2M6IEpvc2UgU291emEg
PGpvc2Uuc291emFAaW50ZWwuY29tPg0KPiBDYzogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4u
bGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVz
QHNpcHNvbHV0aW9ucy5uZXQ+DQo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPg0KPiBDYzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwu
b3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2RyaWdvIFZpdmkgPHJvZHJpZ28udml2aUBpbnRlbC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMgfCAxNSArKysrKysrKysr
KysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMgYi9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1
bXAuYw0KPiBpbmRleCA3ZTJkMWYwZDkwM2EuLjY3OGVjYzJmYTI0MiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMNCj4gKysrIGIvZHJpdmVycy9iYXNlL2RldmNvcmVk
dW1wLmMNCj4gQEAgLTMwNCw2ICszMDQsMTkgQEAgc3RhdGljIHNzaXplX3QgZGV2Y2RfcmVhZF9m
cm9tX3NndGFibGUoY2hhciAqYnVmZmVyLCBsb2ZmX3Qgb2Zmc2V0LA0KPiAgCQkJCSAgb2Zmc2V0
KTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZGV2Y2RfcmVtb3ZlKHZvaWQgKmRhdGEpDQo+
ICt7DQo+ICsJc3RydWN0IGRldmNkX2VudHJ5ICpkZXZjZCA9IGRhdGE7DQo+ICsNCj4gKwltdXRl
eF9sb2NrKCZkZXZjZC0+bXV0ZXgpOw0KPiArCWlmICghZGV2Y2QtPmRlbGV0ZV93b3JrKSB7DQo+
ICsJCWRldmNkLT5kZWxldGVfd29yayA9IHRydWU7DQo+ICsJCS8qIFhYWDogQ2Fubm90IGZsdXNo
IG90aGVyd2lzZSB0aGUgbXV0ZXggYmVsb3cgd2lsbCBoaXQgYSBVQUYgKi8NCj4gKwkJbW9kX2Rl
bGF5ZWRfd29yayhzeXN0ZW1fd3EsICZkZXZjZC0+ZGVsX3drLCAwKTsNCj4gKwl9DQo+ICsJbXV0
ZXhfdW5sb2NrKCZkZXZjZC0+bXV0ZXgpOw0KPiArfQ0KPiArDQo+ICAvKioNCj4gICAqIGRldl9j
b3JlZHVtcG0gLSBjcmVhdGUgZGV2aWNlIGNvcmVkdW1wIHdpdGggcmVhZC9mcmVlIG1ldGhvZHMN
Cj4gICAqIEBkZXY6IHRoZSBzdHJ1Y3QgZGV2aWNlIGZvciB0aGUgY3Jhc2hlZCBkZXZpY2UNCj4g
QEAgLTM4MSw2ICszOTQsOCBAQCB2b2lkIGRldl9jb3JlZHVtcG0oc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgbW9kdWxlICpvd25lciwNCj4gIAlrb2JqZWN0X3VldmVudCgmZGV2Y2QtPmRldmNk
X2Rldi5rb2JqLCBLT0JKX0FERCk7DQo+ICAJSU5JVF9ERUxBWUVEX1dPUksoJmRldmNkLT5kZWxf
d2ssIGRldmNkX2RlbCk7DQo+ICAJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZkZXZjZC0+ZGVsX3dr
LCBERVZDRF9USU1FT1VUKTsNCj4gKwlpZiAoZGV2bV9hZGRfYWN0aW9uKGRldiwgZGV2Y2RfcmVt
b3ZlLCBkZXZjZCkpDQo+ICsJCWRldl93YXJuKGRldiwgImRldmNvcmVkdW1wIG1hbmFnZWQgYXV0
by1yZW1vdmFsIHJlZ2lzdHJhdGlvbiBmYWlsZWRcbiIpOw0KPiAgCW11dGV4X3VubG9jaygmZGV2
Y2QtPm11dGV4KTsNCj4gIAlyZXR1cm47DQo+ICAgcHV0X2RldmljZToNCg0K

