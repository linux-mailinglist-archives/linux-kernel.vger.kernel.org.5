Return-Path: <linux-kernel+bounces-19680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5CD8270C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C32B21BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4B45C08;
	Mon,  8 Jan 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+ihxoIH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589045979
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704723094; x=1736259094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RIjHtGihmAJxaHomxtcuDjuNH84PTaopou4w1O2j/5U=;
  b=f+ihxoIHlFodFtdKF5Cie0yfF5yGT6qHQwBAQJEThHJLgC/wl0xVrG+X
   yEOnr5+uzFerh0xxVySbbG7t/JwfJwtD7g3mcEkohE/dZeTEClOdPuFCH
   4AyeXCmbMDhORJyfiOpTvVRdw5uBwhKaDe36cSPPL+vBVTg1K5TYXXLth
   BXsrX5IqX5d9E25y4CCk//P92YhJ/5PNb3MG/S/l0NmBHFz6lIQ6Tjek4
   EB4mHX5wvbLmrmRUpGiTAxu0GRyGD5W7DR8XyFUDBE8rwC8Zp8z5YrXkc
   voBSqegY7yCOnOeGulH6v2MVzWkQxOyQ8HgyK8AV5nsEfheeot1pnx8Oe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388341777"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="388341777"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 06:11:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="774510341"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="774510341"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 06:11:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 06:11:32 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 06:11:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 06:11:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 06:11:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6jgr4p8w3nvXPVFyulFjIHXVH0LCxTYWr/z+VJ4gUVCxxfsyXBWptAuqcKDgYOO5Ugspzeomb9siv1iAmrqTEyG9tbz4WUwqpeffb8a0fLNvMfJWo88kCa16A7jrHL/CVo0dkxaQ5qIZ9KMUx9Id5LovMdv5dK6w71OnaNqhCpflPJ3R85/YlW2v3pSXVeall8XkUfHeaqr8uN6WX1G2RKj0yzniy67WcgFl5WmHrIXoaY04I7vGih9FmGoScLiqoFRJGC5vYxguNBViQAR9/CLY2UtbnAYl78uZdrhN2E/CbyRx2D2E440wmifLk4ZnYUuQWC1l/n3T20lkaQxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIjHtGihmAJxaHomxtcuDjuNH84PTaopou4w1O2j/5U=;
 b=Gfk/xXy1w4wFePx7bMChdEqWfhMMfRD+SLE1wAS/5LGSeLK9OdYKr6ROLJAB+KS8Y9XWpZI4vb0F+ThWJaFctfmKgysYjWCsB7Pub/Te2FbNXtJ81EzfRGSFxqUkuYJD4lpK/oj0vzc69cbIcsdjfn6BSdw+wBhEAdjZq93nL63MZVsY4Fo96yYy54ABfzpofrvwWF47Gg9cTOxBUhUDry2OM5tcFxB0g6b9smXXU1OqvHGnlJEXVaA8GltAKGNDjHzMzscSu+i2gZzLBd2+0VXL0ByC8MHBVFBLlRs1F24gq3iLmTL1dD2R6nJWknQzDJ/n5ynmy5PBqLWnUug8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB5470.namprd11.prod.outlook.com (2603:10b6:5:39c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 14:11:01 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 14:11:01 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "jgross@suse.com" <jgross@suse.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>, "x86@kernel.org"
	<x86@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ray.huang@amd.com"
	<ray.huang@amd.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"Sivanich, Dimitri" <dimitri.sivanich@hpe.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"andy@infradead.org" <andy@infradead.org>, "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
Thread-Topic: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
Thread-Index: AQHaQjyCF3Nt+9p0tkSkWmDSuvApOA==
Date: Mon, 8 Jan 2024 14:11:01 +0000
Message-ID: <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
	 <20230807135028.381851690@linutronix.de>
In-Reply-To: <20230807135028.381851690@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB5470:EE_
x-ms-office365-filtering-correlation-id: e2b5a0a7-f8f2-4eb0-78ad-08dc1053a4c0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jdfsT86s81P5pDeAWjvfzR2zBoSVSxknawJYL/qXzU83ZLZawZdpskd/y6gWKNqUqK9ZdIOtmXVZAB7UrdcE1nX4ILlc7vUnuTuk4KCDpAeTYeB8tjtAFzFe/KQKEG8a9HaUQCEY+sY+nG5vMxYhyU92achMiMlbPp9NgaigcE3flu13DmFDWSaEz9NLaIt20o+5M6/nDxya/qYPyAMBK9YKt26fBWNTptgQpUzcbJvUmho9G3PlCQs2g5NH8VfDfIv+gCq7Hdp6qZLEcUpf6MrMWpyM19cEN6dp03M2FFG+IKEbHYPMqhkeZifumVlZQpnsaPzoloS8Uepa8bhmmqHSPkZn3hOoDU9ZFG6W68FGfizu+d0U41dIftZwF5JPhhpXu3dd71/JtgKn5YKupWeRTDsRSREFOvbmUMO8upzZS6Zveit17eiSMDqs65LQX8o0lfHei6Py8lHAxj82ZBVRjSkZOR0VEA1goPDP2/tv+b7HMATBDdAT3g/tERJZ60pXvxCqn07ZVPE/h+jjIdpSthwdixncL5R2WQvhtvwCHqm3TUGY5F0Yiz00+UcySt74BAH+S+bgEBmOyXU5zhAV+d5PERprZnSbzR2+hEDBrq9vYPXfJnD4jQrBKXa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(7416002)(41300700001)(82960400001)(2906002)(5660300002)(38070700009)(122000001)(54906003)(110136005)(6486002)(36756003)(86362001)(6512007)(6506007)(316002)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(91956017)(76116006)(66446008)(64756008)(83380400001)(71200400001)(26005)(478600001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEhDRUlLdHp6SnVNaTM1YWRVWTdyakN5bDhnL0s0dFdxMENmL21xNElQV2xu?=
 =?utf-8?B?UXBsWW9wZ2phaC9CL0FEN05BcDRsNXVwNjNacTNEYkhDUFlOUDJwU2J0emlY?=
 =?utf-8?B?MlNoaFhqMXROMDhuZUNKejVyZ0kvWld0RnloMkYydTgzSXZKYmg1ZVVzeitU?=
 =?utf-8?B?VVBNSEJuRUtoWVlqYTRKa21iT1JpRDU4MFVHSHNsd3hIQmVvUEdrUStWaXl2?=
 =?utf-8?B?VTlmVDVHSDFVbzR1ck9NYmIrbnNRMy8rSXRaNTJYVzBlZXFTWktraTg1UVl3?=
 =?utf-8?B?UlVsVHl6dWo2V3hIc2toRmg5a3ROdWJRMm9LZFZMSWJaM1ZkNGt4VGhSVExF?=
 =?utf-8?B?TEdkZEx3ZlpRVE5CenZXUVlWWml4UHBjbmRjZ3I0aDR5Qmp5MDBRWGw1blJ4?=
 =?utf-8?B?QjZsOE44SVFLaEFhT2xMR3cxQkpiVHN3ZDNvS3dGbkt4NkRzL1FhSDE5UmVa?=
 =?utf-8?B?ZWxEWlhDMG1TYkx4RVBMN2FoWFg4eHdyM0liV3h1WjlLUHFXMGc3b3h2cFhH?=
 =?utf-8?B?M0dRODFBQVBNZjR6KzFXYXFsdDlZbWJCK21PczJDUlIvM2NKUnBncGprMDY4?=
 =?utf-8?B?cnkzUzhiUllIOXc1a3p0UkZ3TzhGd3BuNHJQUzdPVmNvajZwMXllZ3pDY1Br?=
 =?utf-8?B?NFdwU0lKMVI5eE91TSsrWmJ0RldyQ0pKcVlvT3M1c2NUNHBUU3FnRWZxM05a?=
 =?utf-8?B?TGs4THJmUFpxeTh6Sy9JT085S2J2Q1ZSQVdIWEFKdHZhNm5aaHRwK1l5bkRj?=
 =?utf-8?B?c05tLzYyUjZvOSt0WjBzeGhsU3dRaytHUGczd3NRRkNYdGpuVytIclhlU2pL?=
 =?utf-8?B?NlhydEZZZzNheEtRR1RlV1I0L2VjNitwTGtiRUNjcGFBaTRudGluaHZobWdm?=
 =?utf-8?B?cUY2WU1HcHlwOVNWZTg3bjhwTGU1VGtvRGV2SElWWWlnMmxyTWVValNab2Vv?=
 =?utf-8?B?UjdjQksvbzhaa3ErMksrK3lwLzNPbUo2bVN1S3NFZkcyWUo4SFJObFdqSktK?=
 =?utf-8?B?UEh2QURkbCtYNkhCemdxWWpGdzZ3K0VDMVk2bnB4WjNLWnNWK05zNlhjSWk5?=
 =?utf-8?B?aUFLS3VLeFY3UlFSNE45NitoK1VDeXF6QkpXYzhrWFlRaUVub0lJMG9XWHdw?=
 =?utf-8?B?bXI1bFlIZnhESko5SWdROHRoOWxSM1dvUFBxSFBUQmxUZC9MMld4Lzd3R2lO?=
 =?utf-8?B?aWYwa1NVSnVGTWhmdjRydnY5dlpYbFdKcHNWdTNYVldQaTVlTVJXaG9oMlNE?=
 =?utf-8?B?d0VEbzdobHVtc3hwbWxwUUNsdERsN3dVc2E0emprV0RjZ3pxK1VDSWpvaTRS?=
 =?utf-8?B?R2RodDgzV20yWFF3bm92OHZNVXFQWEN3bzZtbEcyUzdGNlU2ZVl5bkxvMXB5?=
 =?utf-8?B?MU5PUm1ZRVp1Ukt6KzYvd0poVmhVSzBuaklFZHVLLzYzV0FicEd1Slo1dFR3?=
 =?utf-8?B?blRlUE9xRjduZHhxUnFxSlJ1dksyY1hHNXpUcW5DN2dtdzFwOTM4cHY1Z2dZ?=
 =?utf-8?B?NS9WbWE4S0NrSFRuOEN4cnBtVUxub2dIdnlXWWRJTDZiS25IMmU5bFBSTDlp?=
 =?utf-8?B?TjBJUDV3ZFhYUWtuZ0RocnRPYkpZeWdVV1hxMVh5TkVtN3AyYW0weUN1Misv?=
 =?utf-8?B?Y0kwRTBHeHBjMW1TSXVPa3E3UkZmWFZIMWFUazVQSEpMeEE5b3lXUWRkZ2sv?=
 =?utf-8?B?UXgzd2k3V3ErcC9qS3ZwR0lTK0dQTEpFUkxTQXgrV25hREg3RE5pVDFGN25u?=
 =?utf-8?B?NnR0cTAzRkJqVGExNkZ5TDhDUXRYaUNXTWFqRTV5K2grQitIdjF3WlBHMlAx?=
 =?utf-8?B?NC9BWGtzVUU0ZmRWZVJRbmlNQWtXOTFKbnRQN2hrOUFqUDJ0VUFkRmdyNUI4?=
 =?utf-8?B?Z1V5THQraWl0b1d5dWRjS2hlS1B4WHEwcFlUbU5HOG1paldLYTFYT2VqVjBr?=
 =?utf-8?B?WGVwOTZwdFJKbFV1L1BFMUljSHEwaXo3ZUlYYkM1Znl1NW1YOEJKbUpGT09i?=
 =?utf-8?B?MGRvd3E2enNhQ2kzQkJ2UkRZUWpRYnY2SERJRFQ3Nm1BUmllUTJTSVVGZFlS?=
 =?utf-8?B?emtZbmZKK3hEMXBwRjA3WUJETUtBTG92Nk1DeTUyTGRveGY5NERmbTZqSzBP?=
 =?utf-8?Q?fZrnJeRsNBjEruAZo/9PdSyQL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8A71DBAFC5E0B47B8E232FCF487A3BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b5a0a7-f8f2-4eb0-78ad-08dc1053a4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 14:11:01.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfC9UpT+wAc1LpdntPZCHv6J3wbk7I2OYiHP5SvwN7CBzoimrabghKolyirv5abTemxzLnCmcPxLnFr6donZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5470
X-OriginatorOrg: intel.com

PiArc3RhdGljIF9faW5pdCB2b2lkIGNoZWNrX2Zvcl9rZHVtcF9rZXJuZWwodm9pZCkNCj4gK3sN
Cj4gK8KgwqDCoMKgwqDCoMKgdTMyIGJzcF9hcGljaWQ7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKg
LyoNCj4gK8KgwqDCoMKgwqDCoMKgICogVGhlcmUgaXMgbm8gcmVhbCBnb29kIHdheSB0byBkZXRl
Y3Qgd2hldGhlciB0aGlzIGEga2R1bXAoKQ0KPiArwqDCoMKgwqDCoMKgwqAgKiBrZXJuZWwsIGJ1
dCBleGNlcHQgb24gdGhlIFZveWFnZXIgU01QIG1vbnN0cm9zaXR5IHdoaWNoIGlzDQo+IG5vdA0K
PiArwqDCoMKgwqDCoMKgwqAgKiBsb25nZXIgc3VwcG9ydGVkLCB0aGUgcmVhbCBCU1AgaGFzIGFs
d2F5cyB0aGUgbG93ZXN0DQo+IG51bWJlcmVkDQo+ICvCoMKgwqDCoMKgwqDCoCAqIEFQSUMgSUQu
IElmIGEgY3Jhc2ggaGFwcGVuZWQgb24gYW4gQVAsIHdoaWNoIHRoZW4gZW5kcyB1cA0KPiBhcw0K
PiArwqDCoMKgwqDCoMKgwqAgKiBib290IENQVSBpbiB0aGUga2R1bXAoKSBrZXJuZWwsIHRoZW4g
c2VuZGluZyBJTklUIHRvIHRoZQ0KPiByZWFsDQo+ICvCoMKgwqDCoMKgwqDCoCAqIEJTUCB3b3Vs
ZCByZXNldCB0aGUgd2hvbGUgc3lzdGVtLg0KPiArwqDCoMKgwqDCoMKgwqAgKi8NCg0KDQpIaSwg
VGhvbWFzLA0KDQpVbmZvcnR1bmF0ZWx5IHRoaXMgY2F1c2VzIGEgcmVncmVzc2lvbiBvbiBJbnRl
bCBNZXRlb3JsYWtlIHBsYXRmb3JtLA0Kd2hlcmUgdGhlIEJTUCBBUElDIElEIGlzIE5PVCB0aGUg
bG93ZXN0IG51bWJlcmVkIEFQSUMgSUQgKGluc3RlYWQsDQpDUFUxMiwgdGhlIGZpcnN0IEVjb3Jl
IENQVSwgaGFzIEFQSUMgSUQgMCkuDQoNCkFuZCB0aGlzIGNhdXNlcyB0aGUgc3lzdGVtIGZhaWxz
IHRvIGVudW1lcmF0ZSBDUFUxMiAoSSBkaWRuJ3QgZG8NCmJpc2VjdC4gSSBzdXNwZWN0IHRoaXMg
cGF0Y2ggYnJlYWtzIGl0IGJ5IHJlYWRpbmcgdGhlIGNvZGUpLg0KDQpsb2cgd2l0aCA2LjctcmMg
dmFuaWxsYSBrZXJuZWwsDQpbICAgIDAuMzM1MTMzXSBzbXA6IEJyaW5naW5nIHVwIHNlY29uZGFy
eSBDUFVzIC4uLg0KWyAgICAwLjMzNTEzM10gc21wYm9vdDogeDg2OiBCb290aW5nIFNNUCBjb25m
aWd1cmF0aW9uOg0KWyAgICAwLjMzNTEzM10gLi4uLiBub2RlICAjMCwgQ1BVczogICAgICAgICMx
ICAjMyAgIzYgICM4ICMxMCAjMTIgIzEzDQojMTQgIzE1ICMxNiAjMTcgIzE4ICMxOSAjMjAgIzIx
DQpbICAgIDAuMDEwNDM1XSBjb3JlOiBjcHVfYXRvbSBQTVUgZHJpdmVyOiBQRUJTLXZpYS1QVCAN
ClsgICAgMC4wMTA0MzVdIC4uLiB2ZXJzaW9uOiAgICAgICAgICAgICAgICA1DQpbICAgIDAuMDEw
NDM1XSAuLi4gYml0IHdpZHRoOiAgICAgICAgICAgICAgNDgNClsgICAgMC4wMTA0MzVdIC4uLiBn
ZW5lcmljIHJlZ2lzdGVyczogICAgICA4DQpbICAgIDAuMDEwNDM1XSAuLi4gdmFsdWUgbWFzazog
ICAgICAgICAgICAgMDAwMGZmZmZmZmZmZmZmZg0KWyAgICAwLjAxMDQzNV0gLi4uIG1heCBwZXJp
b2Q6ICAgICAgICAgICAgIDAwMDA3ZmZmZmZmZmZmZmYNClsgICAgMC4wMTA0MzVdIC4uLiBmaXhl
ZC1wdXJwb3NlIGV2ZW50czogICAzDQpbICAgIDAuMDEwNDM1XSAuLi4gZXZlbnQgbWFzazogICAg
ICAgICAgICAgMDAwMDAwMDcwMDAwMDBmZg0KWyAgICAwLjMzOTIwM10gICAjMiAgIzQgICM1ICAj
NyAgIzkgIzExDQpbICAgIDAuMzQzMjA4XSBzbXA6IEJyb3VnaHQgdXAgMSBub2RlLCAyMiBDUFVz
DQoNCmxvZyB3aXRoIDYuNS1yYzQga2VybmVsICsgeW91ciBwYXRjaCBzZXJpZXMsDQpbICAgIDIu
MjA4OTYwXSBzbXBib290OiB4ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246DQpbICAgIDIu
MjA5ODY5XSAuLi4uIG5vZGUgICMwLCBDUFVzOiAgICAgICAgIzEgICMzICAjNiAgIzggIzEwICMx
MyAjMTQNCiMxNSAjMTYgIzE3ICMxOCAjMTkgIzIwICMyMQ0KWyAgICAxLjc5NjE2N10gY29yZTog
Y3B1X2F0b20gUE1VIGRyaXZlcjogUEVCUy12aWEtUFQNClsgICAgMS43OTYxNjddIC4uLiB2ZXJz
aW9uOiAgICAgICAgICAgICAgICA1DQpbICAgIDEuNzk2MTY3XSAuLi4gYml0IHdpZHRoOiAgICAg
ICAgICAgICAgNDgNClsgICAgMS43OTYxNjddIC4uLiBnZW5lcmljIHJlZ2lzdGVyczogICAgICA4
DQpbICAgIDEuNzk2MTY3XSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAgMDAwMGZmZmZmZmZm
ZmZmZg0KWyAgICAxLjc5NjE2N10gLi4uIG1heCBwZXJpb2Q6ICAgICAgICAgICAgIDAwMDA3ZmZm
ZmZmZmZmZmYNClsgICAgMS43OTYxNjddIC4uLiBmaXhlZC1wdXJwb3NlIGV2ZW50czogICAzDQpb
ICAgIDEuNzk2MTY3XSAuLi4gZXZlbnQgbWFzazogICAgICAgICAgICAgMDAwMDAwMDcwMDAwMDBm
Zg0KWyAgICAyLjI2MDk1OF0gICAjMiAgIzQgICM1ICAjNyAgIzkgIzExDQpbICAgIDIuMjYzOTA2
XSBzbXA6IEJyb3VnaHQgdXAgMSBub2RlLCAyMSBDUFVzDQoNCg0KdGhhbmtzLA0KcnVpDQoNCiMg
Y3B1aWQgLWwgMHgxZiAtcyAwIHwgZ3JlcCB4MkFQSUMNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dp
Y2FsIHByb2Nlc3NvciA9IDB4MjAgKDMyKQ0KICAgICAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJv
Y2Vzc29yID0gMHgxMCAoMTYpDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3Ig
PSAweDExICgxNykNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4MTgg
KDI0KQ0KICAgICAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0gMHgxOSAoMjUpDQog
ICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDIxICgzMykNCiAgICAgIHgy
QVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4MjggKDQwKQ0KICAgICAgeDJBUElDIElE
IG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0gMHgyOSAoNDEpDQogICAgICB4MkFQSUMgSUQgb2YgbG9n
aWNhbCBwcm9jZXNzb3IgPSAweDMwICg0OCkNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHBy
b2Nlc3NvciA9IDB4MzEgKDQ5KQ0KICAgICAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29y
ID0gMHgzOCAoNTYpDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDM5
ICg1NykNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4MCAoMCkNCiAg
ICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4MiAoMikNCiAgICAgIHgyQVBJ
QyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4NCAoNCkNCiAgICAgIHgyQVBJQyBJRCBvZiBs
b2dpY2FsIHByb2Nlc3NvciA9IDB4NiAoNikNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHBy
b2Nlc3NvciA9IDB4OCAoOCkNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9
IDB4YSAoMTApDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweGMgKDEy
KQ0KICAgICAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0gMHhlICgxNCkNCiAgICAg
IHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4NDAgKDY0KQ0KICAgICAgeDJBUElD
IElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0gMHg0MiAoNjYpDQoNCg==

