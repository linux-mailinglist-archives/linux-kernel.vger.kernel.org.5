Return-Path: <linux-kernel+bounces-42188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8283FDAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF3E1F244A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A24436D;
	Mon, 29 Jan 2024 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ftE30EEe"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764945958;
	Mon, 29 Jan 2024 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505401; cv=fail; b=CTUQpAFm6/aXTJiP9/r+lAePeKc9nvvsrp9NK8YBfuAoRyemhcCJmHdULgbbnXkbORFtENytajVOyg353+jgCBjFpHFzI2v7vU0Uqv8MZEIpYsVrUp+z+qb9Zt7mwjtxJ2xHvxQTZPxd/UVGe3DqfIcFYZ/HOKirUGWq5/Z6j0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505401; c=relaxed/simple;
	bh=u/ag8kteftuu4/9dCUQ0XctsLvQEPHKliI7TD5FLvSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iwnibU7P3kX3v30X72cQrkRDxgILLP9CykTMYAkbvZ8EKofZ78dCJP6/acfQBEZMbHnIEw9tFBcLojlE0QC4/iDEsJVK938ovmCCREzvyPvg5QUKyoxBqwh+z5+nLEZM82Ed/xcjq1qupACHatxa6aex7v+kEKO9OY4PPMVQaHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ftE30EEe; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFxZQOpuwbEdyEH1QDZ02ut3r1TBBF/6h0x9e+/xrsDAPnB9uFmTIBJK3xE9WdeL662O/bzddjQ/1kjFp98cwNc/Ot1yk1WoydQAcUHFvsWIJnuurDkzhCqAjVV2q2H0/QbEEm+dUQ4Z5ALBPDTK1r+aWq54HvgTieS/dbcquZ3QSa2ncjCpw4oIcD01rflPFfo480E74MjOiF+q5sVgb+/xFEirFf/IuOuiSxND6rWNWQX2O8feB83aMYCRq9WoBKMSfWpNBxb0PqEhZND9f0Bl9dv8KUi1V1dBfwX+7Lh231igxVlGS0SdBbxa7MCFHZmZ5Dn2Lv/DHtgNnNa9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/ag8kteftuu4/9dCUQ0XctsLvQEPHKliI7TD5FLvSQ=;
 b=RcUu43ZSUuu9DV1RtYtLpy2YUU/UTFQDQ3ZCjZSSWypIUp/dICKczKUc76hGQxfjmCgFeOo6TC0pkj/cDFPjFmt9UNfhXyEEyAwcE6tf+9P1pUvjuAq/jvDW9PfSjhPUr8nnPZgWTDSJNAbKI7EtP6LBmaTuh39EQ0qPLqZLUMdgcQNHVPgGdaf7U++fSQf2pXyEFP2tvCZQILW6Dpn7PM6QSiIpGiMG1gG5MbDFfD+peYkelPS9Q9mdPBDvRRXnhQJoA/6yEETBsVO/kPTtkBZbt9BeRGzNqT5eyuX3z2YsQMsjBTIHwTZEZKG22m2Pys178U6IhH5thDoC9yYIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/ag8kteftuu4/9dCUQ0XctsLvQEPHKliI7TD5FLvSQ=;
 b=ftE30EEeDPbj3i22UTYa5WIRQ1c9uJu0m1Yrl4Rr14Nv4XVry0j6M4mbnbAusSDOu7eZTipKZCRN9e8TANcXifupX89D5s0smS50HeMMwG8yjqh/GMK7mi+uEUYaR4VluoF0VK38wPDnOr0MHN5Foqo+J29wG3Rv5yvpdA3j5j4=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:16:37 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 05:16:37 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] cpufreq: amd-pstate: fix max_perf calculation for
 amd_get_max_freq()
Thread-Topic: [PATCH 4/7] cpufreq: amd-pstate: fix max_perf calculation for
 amd_get_max_freq()
Thread-Index: AQHaUDex4I+3/f41BEipcHlLZKKUzbDsP3AAgAQEbhA=
Date: Mon, 29 Jan 2024 05:16:37 +0000
Message-ID:
 <CYYPR12MB8655EB0CDA7F893AABE198AD9C7E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
 <675807d1888f77d7d0f3bc335b5bb3bd2c023670.1706255676.git.perry.yuan@amd.com>
 <81830013-a956-4dd1-b3b7-88c419de77b3@amd.com>
In-Reply-To: <81830013-a956-4dd1-b3b7-88c419de77b3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=790d9854-e12b-4823-b27e-92ec5a504b6a;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T05:15:19Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|LV8PR12MB9183:EE_
x-ms-office365-filtering-correlation-id: f8ab58a8-2a1d-4101-3f30-08dc208977e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8Izk8f4vypwhyweOECBV9nTVPOO8KQgBOpJ6986iv9Dq4NlyTkdIs6qSKspHM2q1tekzBwLjsLMQspo8e/l/2S/KjH5vEo8gNS1ICdoH/He0ughv6Rm1y9jCuikWz4UEwQdhsQClLINaZ/48+4krbqlbI8q7eiiD3zW7UsOt0NxB2FxV/4A/hD8KPHCIiMpbTSDXvF8d7ecqVlJojsadwb4rZVRGybEl9dn5P1w4DrxRP1jGaatd14aVgUi1N0fwLKYJC8ssHsL8u4RgNY2BSOsVRfaHoqx6bodaqQcxTYPE9ixBOgZayi0tx2vhq9LxBlnmaU3zWjdWrzBPwqMv+ruxWCoQV8nhcmSJt3/AkJI8eKnT6EwSmkG3YsOspk6sC/9irOsoaZfTTo0GP1BOVg08QcYr7mIJJ1jcUFPwYdG97k0W/vAR8ExAbw/wPKj3YsIr8PmE7v3Jfk3tC4AaREq9UJhZDrhRFNSFdXqjyxwnpch888ALOzyWfowhRpsjYcApPsBgeWLz2Gw6zgYlM+aGUq6k6UjXZUHfvzUKn5XYWQy1Y6mYuYgcTVu5aGMyGCg/Yg02HCSSYscWGMsfJer/PDQIKseC+ohLcpit2ihdhIDaCQU85pQGdD12jtHgFqwCTU8yWBCgtA1jtv+9+w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38070700009)(83380400001)(921011)(54906003)(6636002)(64756008)(316002)(53546011)(66446008)(66556008)(6506007)(7696005)(110136005)(76116006)(66946007)(66476007)(8936002)(8676002)(86362001)(478600001)(4326008)(71200400001)(26005)(2906002)(9686003)(52536014)(33656002)(5660300002)(38100700002)(41300700001)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnBkQzlDT3JUNldWMDV3c1BJbHRVUXVJbWtpakxldmhWTmVPM2VKNmRWTnpi?=
 =?utf-8?B?U0JnVjhrRmRMaUUvSnJ4L1QwMGQvK0lmZDRMRGVJWGRpRFJqNHpjdW1OOFVS?=
 =?utf-8?B?cGc5UWEvaElUOTR6QUswcEt3ZDJUSGZuQXpTR3o1bEZCd1RCYTM3WTlWSXlk?=
 =?utf-8?B?Y3AvVEFGYWVUT2lsSnpyR3c2bkpoeUtHVjJ6THFVRlZaQ2MwNTdVZmF6cWFo?=
 =?utf-8?B?dHR3N2crUkQrSjl4bEpVK25ZaFNGR2tDcStIK2k2MmkrUWgvQmNsQ2FNYnF1?=
 =?utf-8?B?ZnU5NGNiRzBDeW1kZ05Yb0JaZGNQSW9va0xaeFk1eHY2S0lsRk0rU3NyZloy?=
 =?utf-8?B?TUxkNEdoOEdkaVFOakYySXY3VXNrMFVtaktKYk8rTUhXMnUrWTYybFJZQW5v?=
 =?utf-8?B?UXp3cHVBMjNjdlRHcVZCKzR4OHNKNjZraGpMbnBQNzFscnZjbm1jVW5JSSsz?=
 =?utf-8?B?Wkc0Q09DVExIdGVNMHNFYmVpTnJxRFRsNWNnZmI2WHI1U28zTGZ4MmR4NGZQ?=
 =?utf-8?B?Nyt3aG9OeFNlKzZrNGZyWkZBRml1QW56cUlMb0lUVCswTk1mQURselp0N0Yw?=
 =?utf-8?B?ZVhEZEFqVEEvVHl2eDdvaDlMK01oM3dZMzZYUTRtRVYvdnRURGRkcngrbFJH?=
 =?utf-8?B?dWROeStWUWxsSE5rSnBUcnhnNnhLNTdMREl5TW1pNW1wT1N3NzA1dUdZa0lh?=
 =?utf-8?B?SWtZeDQ4TWFLSFNEMGxuUldvUWdRbnhQVkNKV3BFMjVIdTcrN1hZV2RuM1Ax?=
 =?utf-8?B?ZzlqN2JWdTdxQnRlalZ0dEQzeGNzV0lhSG1xN2J1STlFdHRRY2c0MUZNRlZs?=
 =?utf-8?B?MEYreUtqRlgyNVVLSk53cVlhTm84UXliZ0Q3THRrWlNIc2h6TU5GelVxb0Vh?=
 =?utf-8?B?eUtGRWMzcTd3ZjZxOEpCYVI5VmIvdDVUR1BjN3RnbXMweXBZWGtIK3laZXF1?=
 =?utf-8?B?dkg4WGEwYXhXa2VSdVY3ZndpaGw5WXdnNUdkcFJYa00xdWNZRWtDTmc4OGZP?=
 =?utf-8?B?OUExYlFxb2tUL245THIzbGVXaW9QUTZLYzVvYWs5ZHl3ZTBuNFZnUXNORXFt?=
 =?utf-8?B?d2dUcmZ6OUw3anN0RnJSUDYwT2tzU3U5MzlnSGJBYmdlLytialFGSjA5eDlr?=
 =?utf-8?B?WStqdU1nUW1MSVU2V1JuNG9wbUcxSEVad0YwSHJsTkMvY1ExV25INVU5OXFz?=
 =?utf-8?B?SVRLaFlGM1NLMlR3VWpwMFV2K2dJZEtibDRnZWhnUEpuTW4rektkSTFEdTUr?=
 =?utf-8?B?aWFVNzd0cmFTbDJUTVhMV3Fxcko5aGNReWlpK1JLUm91OCtPdnB3MEpJNEJw?=
 =?utf-8?B?K0kwWVN4OHFHQzBFb1VNQ2RvaGJtNmZKb0ZZSjdraHhuT1N1RlJSbHZ1cFg4?=
 =?utf-8?B?ME5HMVFvL3o2ZTZIMUdiTFdPQ2xDQXloYmYycm54QWErclhVS09pYjV0a3Nh?=
 =?utf-8?B?cmU1WVNtblZZV2NSSFM5M2JiaGRBM0VvaFhrYzMvWmdqRkpiaWlYZHlpbWFi?=
 =?utf-8?B?cFpFYUpMeG1JNFNZbGlEcDNmQXc4eDlzZ1RsYk0zZzV5VjR3MzJBa3Q5VEdm?=
 =?utf-8?B?dHlBM211MXlaZmY1c2RmU01KVGRmWXVHVmhDNlhITEF4NW5IODZzUGd3V3lH?=
 =?utf-8?B?TklleE5NVitwWkZjK2JhMGVmWURjOThhWWZyWlNWa2JYTEZTOWNJcG1vZVFT?=
 =?utf-8?B?anhoeVAyODBUZ21qdWxYbHNxZmYzcnBNdnpTVERCTWUvZUdya0I0dGxBTzBt?=
 =?utf-8?B?L0lnYkxxZFgzS1VkcUtzc3VvVGJoM0hNZ09WT0hqVlBLZ0ZBR3kwMXdkWFpJ?=
 =?utf-8?B?Z2lBNE0vNWVOOWVLejhCOG54ZW5IM3IzbzVYM0pKb3BMaXJhNU10NEJXcEdB?=
 =?utf-8?B?VWtoK1pVQjFiSXRKcjFHTmFydnovcnk0S3Jnbk13b0NuVGNRVGtZeHBMTzll?=
 =?utf-8?B?eFpmYTdUNTlnTExjanl0SCt5L3dkeE90Sk9LQ05iS3VDdjJ4RmY4OHRybTc2?=
 =?utf-8?B?WS9zcTNJTld6Z01LS2NHQWdFczBjNDIrbEVLYmR4Q25KZTh3Q2pZN0djOTU2?=
 =?utf-8?B?TGdnWEV0K0RTdFd4WE1tODJUdDkzSEdmTUVPNmdiZGJ5N3lyM3BSNG16RlZi?=
 =?utf-8?Q?QFHs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab58a8-2a1d-4101-3f30-08dc208977e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 05:16:37.3683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36qmWZrSJWPTCc/10S2IiW/p8q7OWgNlU7yXoNRjQ2mUmvUIcqxAucF7hVIej8Gs52RXNGbXMp1aiWaZRzUEng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpICBNYXJpbywNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAyNiwgMjAyNCAx
MTo1NCBQTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJh
eSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksDQo+IEdhdXRoYW0gUmFuamFsIDxnYXV0aGFt
LnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNsYXYuUGV0a292QGFt
ZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9q
aWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVu
Z0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvN10gY3B1ZnJlcTogYW1kLXBz
dGF0ZTogZml4IG1heF9wZXJmIGNhbGN1bGF0aW9uIGZvcg0KPiBhbWRfZ2V0X21heF9mcmVxKCkN
Cj4NCj4gT24gMS8yNi8yMDI0IDAyOjA4LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+IEZyb206IFBl
cnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gPg0KPiA+IFdoZW4gQ1BVIGNvcmUgUHJl
Y2lzaW9uIEJvb3N0IHN0YXRlIGNoYW5nZWQsIHRoZSBtYXggZnJlcXVlbmN5IHdpbGwNCj4gPiBh
bHNvIG5lZWQgdG8gYmUgdXBkYXRlZCBhY2NvcmRpbmcgdG8gdGhlIGN1cnJlbnQgYm9vc3Qgc3Rh
dGUsIGlmIGJvb3N0DQo+ID4gaXMgZGlzYWJsZWQgbm93LCB0aGUgbWF4IHBlcmYgd2lsbCBiZSBs
aW1pdGVkIHRvIG5vbWluYWwgcGVyZiB2YWx1ZXMuDQo+ID4gb3RoZXJ3aXNlIHRoZSBtYXggZnJl
cXVlbmN5IHdpbGwgYmUgc2hvd2VkIHdyb25nbHkuDQo+DQo+IFdoYXQgYWJvdXQgdGhlIHByZXZp
b3VzIGNwcGNfcmVxPyAgU2hvdWxkbid0IGl0IGJlIGV4cGxpY2l0bHkgdXBkYXRlZCBhcyBhDQo+
IHJlc3VsdCBvZiB0aGlzIHRvbz8NCg0KVGhlIENQUEMgUkVRIHZhbHVlIGhhcyBiZWVuIHVwZGF0
ZWQgaW4gdGhpcyBmdW5jdGlvbi4NCldoZW4gYm9vc3Qgc3RhdGUgY2hhbmdlZCwgdGhlIE1TUiB3
aWxsIGJlIHVwZGF0ZWQgZmlyc3RseS4NCg0KK3N0YXRpYyBpbnQgYW1kX2NwdV9ib29zdF91cGRh
dGUoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhLCB1MzIgb24pDQorew0KKyAgICAgICBzdHJ1
Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSA9IGNwdWZyZXFfY3B1X2FjcXVpcmUoY3B1ZGF0YS0+
Y3B1KTsNCisgICAgICAgc3RydWN0IGNwcGNfcGVyZl9jdHJscyBwZXJmX2N0cmxzOw0KKyAgICAg
ICB1MzIgaGlnaGVzdF9wZXJmLCBub21pbmFsX3BlcmY7DQorICAgICAgIGludCByZXQ7DQorDQor
ICAgICAgIGlmICghcG9saWN5KQ0KKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREFUQTsNCisN
CisgICAgICAgaGlnaGVzdF9wZXJmID0gUkVBRF9PTkNFKGNwdWRhdGEtPmhpZ2hlc3RfcGVyZik7
DQorICAgICAgIG5vbWluYWxfcGVyZiA9IFJFQURfT05DRShjcHVkYXRhLT5ub21pbmFsX3BlcmYp
Ow0KKw0KKyAgICAgICBpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0NQUEMpKSB7DQorICAg
ICAgICAgICAgICAgdTY0IHZhbHVlID0gUkVBRF9PTkNFKGNwdWRhdGEtPmNwcGNfcmVxX2NhY2hl
ZCk7DQorDQorICAgICAgICAgICAgICAgdmFsdWUgJj0gfkdFTk1BU0tfVUxMKDcsIDApOw0KKyAg
ICAgICAgICAgICAgIHZhbHVlIHw9IG9uID8gaGlnaGVzdF9wZXJmIDogbm9taW5hbF9wZXJmOw0K
KyAgICAgICAgICAgICAgIFdSSVRFX09OQ0UoY3B1ZGF0YS0+Y3BwY19yZXFfY2FjaGVkLCB2YWx1
ZSk7DQorDQorICAgICAgICAgICAgICAgd3Jtc3JsX29uX2NwdShjcHVkYXRhLT5jcHUsIE1TUl9B
TURfQ1BQQ19SRVEsIHZhbHVlKTsNCg0KDQoNCg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9j
cHVmcmVxL2FtZC1wc3RhdGUuYyB8IDQgKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0
YXRlLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgaW5kZXggYjM3YmVhNzQ0
MGI5Li4zMjg2ZDcyZjM3NWUNCj4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2Ft
ZC1wc3RhdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBA
QCAtNTk5LDYgKzU5OSwxMCBAQCBzdGF0aWMgaW50IGFtZF9nZXRfbWF4X2ZyZXEoc3RydWN0IGFt
ZF9jcHVkYXRhDQo+ICpjcHVkYXRhKQ0KPiA+ICAgICBub21pbmFsX3BlcmYgPSBSRUFEX09OQ0Uo
Y3B1ZGF0YS0+bm9taW5hbF9wZXJmKTsNCj4gPiAgICAgbWF4X3BlcmYgPSBSRUFEX09OQ0UoY3B1
ZGF0YS0+aGlnaGVzdF9wZXJmKTsNCj4gPg0KPiA+ICsgICAvKiB3aGVuIGJvb3N0IGlzIG9mZiwg
dGhlIGhpZ2hlc3QgcGVyZiB3aWxsIGJlIGxpbWl0ZWQgdG8gbm9taW5hbF9wZXJmICovDQo+ID4g
KyAgIGlmICghZ2xvYmFsLmNwYl9ib29zdCkNCj4gPiArICAgICAgICAgICBtYXhfcGVyZiA9IG5v
bWluYWxfcGVyZjsNCj4gPiArDQo+ID4gICAgIGJvb3N0X3JhdGlvID0gZGl2X3U2NChtYXhfcGVy
ZiA8PCBTQ0hFRF9DQVBBQ0lUWV9TSElGVCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
IG5vbWluYWxfcGVyZik7DQo+ID4NCg0K

