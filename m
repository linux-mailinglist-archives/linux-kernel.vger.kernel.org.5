Return-Path: <linux-kernel+bounces-3158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F9981680C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8D61C22404
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCF8101F1;
	Mon, 18 Dec 2023 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esiiaJvh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF9101D3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702888316; x=1734424316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d7M9VKe4rOoJPGBCKYLzeVoU4/zbpNfejwKaOilvk+Q=;
  b=esiiaJvhSj37GmoNfQVL99OH8kZqBTT8POdT8RegIKEsoF2qE39PFT1U
   sEARy6IEM5NX0zQwuGSTaDNvvedpnoSKDwA0Rx4PGdbiHFFp43l40BYeQ
   +8lDBW6OwHheA0Tm3oswhG8Z5Co8P9Yb9dke4LzTJbqjIE/Wi9pjRshqj
   ai0VePdyJdbqLsSEvRlI2raerbH/xAPaixXakgs1WIB/1Cot3GsVRdBGq
   J5GFkLFJCa34leyl2beoGeHQym+ColeoV1LOxg0e66VlwvSEqQrCAbMmD
   IVfw/q4F3uj3KK1du1Y2ZY8dEhDf/EpO8JBt6Hsjy4h6otn9orngvjQ7y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8834677"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="8834677"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 00:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804449257"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="804449257"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 00:31:55 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 00:31:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 00:31:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 00:31:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCl4LlZgWVN36VXvEM4tRkN4wiPhaLjiOqxNTcurHHBozfGxb1FqKFDrPnGFcSSKrwPyyJFyUgDsvbhmol9kqzfBEdT2heaHveAxLiXAKNF1bE3W2utmlH3jhI+4zIqLWXOj8Nzc/Ffc029evwK4ZK/rbWvSUogpkZhNEhgooTevIiWDWnLRm2OwCBUbldMusbxAJ3vPCM0M2C9XUfeeBtYeSE4PymhP2As7KVyIA74tCpaOBqTFAl2+4p+CfIbcTVreTDdAzsIfGoH7OSa1H3BHr8KnDfJ/yfrDG0gTB13rVbSFSywq5ddN9I8j+Ha8OzO9e0UQ5DxONXPkaanQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7M9VKe4rOoJPGBCKYLzeVoU4/zbpNfejwKaOilvk+Q=;
 b=W5+hVxxRdq4dEScyr7GJc6dVRRjlJqLowbxzjEiPryOnba4Hso87Clt8niUWvMXptjwrXqdl+8BllEP/2nYmMfm4dW96r5C/emwh3Yqi+wUeHdl59fOw/YbnE1gPdrdgSM2DrzdkI6h4JgQ+YJl7ih3JlppnnvC13orPHwBwtlOMbqa96MdJGI7ndJJ/ev8rtmaCXd5EsFRCAvNioMUu1h4eP1C2k0X4ZbdHaRphmtYd2sFfO0UELffz9EcenCsEf72qDx4ANAKygo4lhyLpMwQfTi9Ep3KQT8qoq9QdfOtUmXG7zDCtogL00pp7BKtwkbkfHewPr2jrJA6rPcWJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by LV3PR11MB8741.namprd11.prod.outlook.com (2603:10b6:408:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 08:31:51 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 08:31:51 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds
	<torvalds@linuxfoundation.org>
CC: Brian Gerst <brgerst@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Ingo
 Molnar" <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Borislav
 Petkov" <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Michal Luczaj
	<mhal@rbox.co>
Subject: RE: [PATCH 3/3] x86/sigreturn: Reject system segements
Thread-Topic: [PATCH 3/3] x86/sigreturn: Reject system segements
Thread-Index: AQHaLeJ1dgiNd00VRkeM+J3sUEZ2GbCnj7IAgAZugwCAAAlxgIAAAWIAgACs6aA=
Date: Mon, 18 Dec 2023 08:31:50 +0000
Message-ID: <SA1PR11MB6734EA01DE0AED77E1A49623A890A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231213163443.70490-1-brgerst@gmail.com>
 <20231213163443.70490-4-brgerst@gmail.com>
 <CAHk-=whXt7QZV+HDA8=PN1pTBSNTL0ZJrcqtc4af=FtJpjPQeQ@mail.gmail.com>
 <C7EB5080-639B-41EE-B494-869D5D6F60A7@zytor.com>
 <CAHk-=wgOxf3u-4qp9z+50y93dw2aj_nnx3Y8zLo_GGBA4U92BQ@mail.gmail.com>
 <2D83F195-CFE8-41D2-87AB-60B148CC5672@zytor.com>
In-Reply-To: <2D83F195-CFE8-41D2-87AB-60B148CC5672@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|LV3PR11MB8741:EE_
x-ms-office365-filtering-correlation-id: bbc28688-89a8-4e17-84ab-08dbffa3c86a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CulLX1CSaK9E/KU6o/oFVZEn4UR4+JZVykyW+0m9Fnn3HkF7kz3BC1xPg44vPjMB++hBCCEnQDrDcvp9u8pptxVWOqEn6+O7YfmAyRAPrFLgLxdu3+2iI7kchcp6f8AAo5oaAa8kEpws4eClYW8+vRGlgMGUROGCBlXQymqN6yFwpwJwzMuEqEWMglSwoMiC7mqMD1bIjoVO3wwvw5Uc7EYgy/DMmMBZxGFMtL5Zo4VvbuGvKhmFLm0Gi69DdthDRHvwgtK29whNrpT3WUybVWE4H14zZOU8UCSBI9t9iVliQe7rJVtqISeCpzk3meqhSCitI9i622yVbXfUOb4CFLGs8/mmA+kH5TyCQ5bAUqJf+CLOFFS2bO0rHTROIP8zwYxULO8D+gnXWh0IonjIEsUiU0ieU75fO/s2Q7m7Kdi/4wzEfQgLoI7e7YF6iJj9ET7nKG2napj1/0ON+ooCbRtmjzKqBXnEl3urP2LpxpniOJBraoXihh2a3k30nrOEuVlnvF8SkHgt351OU5txYAadlq7vHPJ0zRDqLreXwpAYBOa34fevpWC0kfKU9UkjmVliesVP/I8EPhbFqdjq6B0H7bXl5D5ir1iDLyP0+4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(7696005)(9686003)(6506007)(53546011)(83380400001)(5660300002)(52536014)(7416002)(966005)(2906002)(41300700001)(478600001)(316002)(8936002)(4326008)(8676002)(66556008)(66946007)(76116006)(66476007)(64756008)(110136005)(66446008)(54906003)(71200400001)(82960400001)(33656002)(86362001)(38100700002)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdDTzVpbHBSOTdVckJaemxZZlZzNERiOVJscXpUbXVIa0dVcEJzcFlvMHRz?=
 =?utf-8?B?Z1UvTmYzQ1VoMFIwWGNtdWRYS3NyTUhLSzB2YWdad3hJdmt6N2x6bklsY0w1?=
 =?utf-8?B?MlpGZEU3YWhnUTdtRUZnYVBXMnJ5YUJzY1hjVDlFb1NSRHNyc1VGeWhhSmFu?=
 =?utf-8?B?cWNON3NLMEd2d3N3bERlRnViSnd1eWJpLzZpNVA1R1B4WkR0cmZiSnFTUlNq?=
 =?utf-8?B?OXVidUVXSEJPSWNZVG5BaWx0djVCOFR2T3dONVRkVEpmK3V6bjlrak5sWTM4?=
 =?utf-8?B?a0kyZGF1dVE3MGFYelREd1dibTdpckVUeXprSHE5NjFxeEdZbjFKVTVXWklv?=
 =?utf-8?B?a1orTTU3R2RHWDBPamRPRWtHdjlwakhEWUhDdzVSRVhBT0xyMmMyZE14aHFj?=
 =?utf-8?B?WldOUE1qaERPR0FFbHp3WmM0ZlZ2RUo2WnAxOHhUV25jeDV2M09tNHRiRS80?=
 =?utf-8?B?OTNNK2szbTdyVDFTeDdpcmZuLyttZWdlRkg0QnVvUTJXajM5QnpHd1lycnhB?=
 =?utf-8?B?V2xLbHhHVThiT2NrcDhMUm5oN0tjMnI2UGRrSDlia0hrTHpIYnNyRVR4a2ZW?=
 =?utf-8?B?Vm8vS2o1VUhKYm9yNGNXc04yRHN5OXl5Q011Y0YwSVFIdlRaN1Y4U1FkOXhl?=
 =?utf-8?B?dXhWU0dzL2xWK3BFaWVNNUZsdlNqMzhQNk42bTVSblVnWkNUL1hqc1VEWUI0?=
 =?utf-8?B?OTBmb2xsMmF5d2VReFQ4VnZDRkVuYkpyV0NUUEJCUE1uc3Q5N1dlNENUUmw0?=
 =?utf-8?B?M2FyVi9ndlJZMTl5SUVUeVVLa0JraE9iTDhmR2NVUEFFU0J4M1ZjVDJHT3JV?=
 =?utf-8?B?RjRBOEs3em55QVhGQmxEWFkycnlrTTAwRi92OHA2OGdRQXVzZnlhZ3lrbVpW?=
 =?utf-8?B?MkYvdWtVcWIxZUVxMlZtMnhPaHFJaHovYTRnSnpjT1BJcmoreCsvdlhVZ3FQ?=
 =?utf-8?B?d2c3STlCTE5nZ0lzbVRXRFF6VnlCUkFPcjVtQ1dEZWRIVkZnQi9tN1ExelMy?=
 =?utf-8?B?Q1JoNm1zYTU3ZUpvSGIwUDkrQVQvMnQzOGdWRldoT2l6bVZYTmw5RDhKalZ1?=
 =?utf-8?B?akFLWGRHMVBiWHpiRTRBYjR3RUg1Z2NRRVFmTUpZYktIeFNTTkVXZnpENFEv?=
 =?utf-8?B?TFh6Z0o4MjJOcm9KbUF4bnh1SE1xeGNuUjNVSm9FdTNpeHc3VjIwdFdkSEpo?=
 =?utf-8?B?djA1L0ZvampXMk9ZdEt2czdvWUZNSVJDLzA1dXVmTEpjTHk0REYxSTc4bDFI?=
 =?utf-8?B?WmNVY3JVWC9VQnlzMEc5ZmpJSno4SE9NK3hOT1RLUVZlenRiVDV6bGNFbEtp?=
 =?utf-8?B?bGlWTWcvOVJtZUxhbWZzbXlWQ2U2MDYvQmVVT3czQ3ozMnMraC9ld2EzeHRv?=
 =?utf-8?B?UjlPckNGMTdYR1lXNC9uSVhIRkpidlhzRlhCeUI0Tk8xRXcyMnBJR0ljbjQ4?=
 =?utf-8?B?WllGRnhYNWFFUEd4eGZrQkgyRisxeHFoUlY4cWdoYTYwU0wreE9WWlNBRjRG?=
 =?utf-8?B?aVkwVGlWbjV1ZFB1WnlNRkdhR3RidFd0QmNDUlJYNlBhWlUxS21OSklNaHVG?=
 =?utf-8?B?bjZ5RC82SldpSXlMNTQ3alRaMUVibnhsZ3RXUjFpK0U0SFhYYisxYWJ1anNN?=
 =?utf-8?B?K2t2QlZpSlRoRjI2QThSaU1YYjhLRE1WQ3FmWlVIQ1FzZ1FpYndLb0hzOHh5?=
 =?utf-8?B?UjNOS2dBU2JPejB6ajcyNlZObXNaWFZib2tyRFhzVDhzQVNnZmU0U0s2MmlD?=
 =?utf-8?B?bGVMOGUvbkMxaEdCNjdOU1UyamM1UUhxclhaUzJORjJ5TEM4UG9uTU1mQUdQ?=
 =?utf-8?B?RElCK3RyTDBxcEdrQ29CNnRNREdDN3lNcXBQa2t2MTQybnVuQkY3TlRBYW44?=
 =?utf-8?B?Uy9TdlNzOTBvMFBzdEtzTFJwNzBraEhmQzVaejN0NkY1QXRxekdndzNxL2Fm?=
 =?utf-8?B?L09vd0dqZ0pkZ2toaVl0bEZJTnF2a3Z2NW4xbHQ0SUFUakJSaUtsK3pCKzZX?=
 =?utf-8?B?NXRYNUFmYUZEVGQwVTB3SFNZOEVHdmhVN0ozbWd5aVI1S2FQbjJ3aU9kenNP?=
 =?utf-8?B?NW9TZEpCZWlEM2hBeGFmYVFwVzZIdU96aWdYRWlPVmtmUWk4UlFYTTBENDhF?=
 =?utf-8?Q?SHhk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc28688-89a8-4e17-84ab-08dbffa3c86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 08:31:51.0056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLrXfW87cRfCFnaOZEipgiF6zTMBeT0mJxJDovM8pvZ/GF10EHiY1N2ElLM2HGPSpYLr4UpvGV8GxlLMlKqATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSC4gUGV0ZXIgQW52aW4g
PGhwYUB6eXRvci5jb20+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgMTcsIDIwMjMgMTo0NiBQ
TQ0KPiBUbzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+
IENjOiBCcmlhbiBHZXJzdCA8YnJnZXJzdEBnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiB4ODZAa2VybmVsLm9yZzsgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5v
cmc+OyBUaG9tYXMgR2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBl
dGtvdiA8YnBAYWxpZW44LmRlPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRlYWQu
b3JnPjsgTWljaGFsIEx1Y3phaiA8bWhhbEByYm94LmNvPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDMvM10geDg2L3NpZ3JldHVybjogUmVqZWN0IHN5c3RlbSBzZWdlbWVudHMNCj4gDQo+IE9uIERl
Y2VtYmVyIDE3LCAyMDIzIDE6NDA6NTMgUE0gUFNULCBMaW51cyBUb3J2YWxkcw0KPiA8dG9ydmFs
ZHNAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID5PbiBTdW4sIDE3IERlYyAyMDIzIGF0
IDEzOjA4LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4gd3JvdGU6DQo+ID4+DQo+ID4+
IE9uIERlY2VtYmVyIDEzLCAyMDIzIDEwOjU0OjAwIEFNIFBTVCwgTGludXMgVG9ydmFsZHMNCj4g
PHRvcnZhbGRzQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+XT4gPlNpZGUgbm90ZTog
dGhlIFNTL0NTIGNoZWNrcyBjb3VsZCBiZSBzdHJpY3RlciB0aGFuIHRoZSB1c3VhbCBzZWxlY3Rv
ciB0ZXN0cy4NCj4gPj4gPg0KPiA+PiA+SW4gcGFydGljdWxhciwgbm9ybWFsIHNlZ21lbnRzIGNh
biBiZSBOdWxsIHNlZ21lbnRzLiBCdXQgQ1MvU1MgbXVzdCBub3QgYmUuDQo+ID4+ID4NCj4gPj4g
PkFsc28sIHNpbmNlIHlvdSdyZSBub3cgY2hlY2tpbmcgdGhlIHZhbGlkaXR5LCBtYXliZSB3ZSBz
aG91bGRuJ3QgZG8NCj4gPj4gPnRoZSAiZm9yY2UgY3BsMyIgYW55IG1vcmUsIGFuZCBqdXN0IG1h
a2UgaXQgYW4gZXJyb3IgdG8gdHJ5IHRvIGxvYWQNCj4gPj4gPmENCj4gPj4gPm5vbi1jcGwzIHNl
Z21lbnQgYXQgc2lncmV0dXJuLi4NCj4gPj4gPg0KPiA+PiA+VGhhdCBmb3JjaW5nIHdhcyBsaXRl
cmFsbHkganVzdCBiZWNhdXNlIHdlIHdlcmVuJ3QgY2hlY2tpbmcgaXQgZm9yIHNhbml0eS4uLg0K
PiA+PiA+DQo+ID4+ID4gICAgICAgICAgIExpbnVzDQo+ID4+DQo+ID4+IE5vdCB0byBtZW50aW9u
IHRoYXQgY2hhbmdpbmcgYSBudWxsIGRlc2NyaXB0b3IgdG8gMyBpcyB3cm9uZy4NCj4gPg0KPiA+
SSBkb24ndCB0aGluayBpdCBpcy4gQWxsIG9mIDAtMyBhcmUgIk51bGwgc2VsZWN0b3JzIi4gVGhl
IFJQTCBvZiB0aGUNCj4gPnNlbGVjdG9yIHNpbXBseSBkb2Vzbid0IG1hdHRlciB3aGVuIHRoZSBp
bmRleCBpcyB6ZXJvLCBhZmFpay4NCj4gPg0KPiA+QnV0IHdlIG9idmlvdXNseSBvbmx5IGRvIHRo
aXMgZm9yIENTL1NTLCB3aGljaCBjYW4ndCBiZSAoYW55IGtpbmQgb2YpDQo+ID5OdWxsIHNlbGVj
dG9yIGFuZCBpcmV0IHdpbGwgR1Agb24gdGhlbSByZWdhcmRsZXNzIG9mIHRoZSBSUEwgaW4gdGhl
DQo+ID5zZWxlY3Rvci4NCj4gPg0KPiA+ICAgICAgICAgICAgICBMaW51cw0KPiANCj4gT2YgY291
cnNlIG5vdCBmb3IgQ1MvU1MsIGJ1dCBJIHdvdWxkIGFncmVlIHRoYXQgaWYgdGhlIHNlbGVjdG9y
IGlzIDAgYmVmb3JlIHRoZQ0KPiBzaWduYWwgaXQgc2hvdWxkbid0IG15c3RlcmlvdXNseSBhbmQg
YXN5bmNocm9ub3VzbHkgYmVjb21lIDMuDQoNClVuZm9ydHVuYXRlbHkgcmVsb2FkX3NlZ21lbnRz
KCkgX2Fsd2F5c18gc2V0cyBEUEwgYml0cyBvZiBHUy9GUy9EUy9FUw0KdG8gMywgZXZlbiBmb3Ig
MC4gQW5kIElSRVQgY2xlYXJzIERQTCBiaXRzIHdoZW4gbG9hZGluZyBhIE5VTEwgc2VsZWN0b3IN
CmludG8gR1MvRlMvRFMvRVM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNzA2
MDUyMjMxLjIxODMtMS14aW4zLmxpQGludGVsLmNvbS8NCg0KVGhhbmtzIQ0KICAgIFhpbg0K

