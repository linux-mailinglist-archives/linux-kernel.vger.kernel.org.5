Return-Path: <linux-kernel+bounces-44459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A369842242
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A281F297E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFCF664D3;
	Tue, 30 Jan 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E0RgNuXw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00464CE9;
	Tue, 30 Jan 2024 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612827; cv=fail; b=nv21SkF5mgfgZvPZh7Xu+RyutIaoTXhM6ttp8rWpZd+2cxzFRc5KPmVGQ7GWktnjGjFN6H7WmgdStciTRQSy1XKbnnP5pvCczgGitjjbnmirVo+5wPgaSNTey2CfQ2LNtOvrSpHmRSQ0kjhCHERUg8/3ILlPqJKXuxoP/3Ujpt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612827; c=relaxed/simple;
	bh=u3vX7W+ng9nS1K/nQQ4455X4RlOHg7syM4E9C6p5y0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TT7l4uwaCe+k+idTlcuPwudL6d6Dsoz4CE2NGX3F4adJlhmi9pocKO4rFZphmJ1B6tWxsIeb8mIiwKK/SNfKC1TchTdBnJ+U4BMLu5lI7ERf4OeJWoSMVD8vdq4bl+2Np8eZ88ATmySvk2/OgzTRMH+PiqB3pjxtcF8KbdiwZ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E0RgNuXw; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf4bD3F7yC66uIGZj1u27///vzOUqlp9Nxu1GvPEwVNxXuiZ9WQ8hGoSTzQ3LcROjh2JtsCbAg+lvFWo2v5RWav1GciR7j34OFk9Sikyz1kOVgFTdz9o13O9/diqir5tPn0oDudj0dElKJj+BsQUQPfvhRmnJJgXvy/poSh+GPmUr9aZNAU+fxJzI8BEaw01FjwktoafRmku2q+m5931CriKx06jg3XekFHr67XaQdc7CZ7AJSwRPSsPj/zAuCPnvTCKW0pNtoiFn491btS1VtHYaUSwkD6/CNq2WYbAV7b9uCK20ekC9FBEJfa3Y9z2nf+K595bYQPS9QT9FwSUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3vX7W+ng9nS1K/nQQ4455X4RlOHg7syM4E9C6p5y0M=;
 b=FkeAC+BGkjekXi98bVOiFZlDBL+6ZGP9fWIyj2HrlTDCP5CuS1FlLika1F9sgHFDJEmeCfCqMbR1tUGZpV4bcSJkQ9fgbW0VEEHkTA2TTECSIUPhpnmgL+OYlc7vbBGSLS8fnmfWaHXBU3P/716IxK7kCUEGbXXwXXnXe2Vg8jdwqx/58N/6coShY5lpgUb6u8iBcUBFoSP1WagBKpopn6YL65xtN8Y1ffmS+KurfRnGX3uT0Y8E7bO87j5UVTsucP/SjHctQcTfFJOs1edqw0ft3sTC/xTTjVyFTcLaeruCvCjABOTMTXqCOKq4Lh7TVlFwNTCB5aHjVYuPieWdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3vX7W+ng9nS1K/nQQ4455X4RlOHg7syM4E9C6p5y0M=;
 b=E0RgNuXwNqsd9ahLDZzRDl9qMBOGQ0J5MTeKaJeFAHDrk9abfsw2Am5VXohs9byfFYUN39SbqNVFBkH3YU5TqN+ThleFylH55mRXBLvNkLszt8SAqTFpwb9DCrgl0dGRLkZHB6CXQ8+irEkH/0N4AiOQiZ3zwGBuGrW+xAT3chM=
Received: from BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:07:02 +0000
Received: from BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::4a52:8ccf:4402:e40]) by BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::4a52:8ccf:4402:e40%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:07:02 +0000
From: "Cvetic, Dragan" <dragan.cvetic@amd.com>
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, "Kiernan, Derek" <derek.kiernan@amd.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "Erim,
 Salih" <Salih.Erim@amd.com>, Conor Dooley <conor+dt@kernel.org>
Subject: RE: [PATCH v2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Thread-Topic: [PATCH v2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Thread-Index: AQHaUti+409eWpIaK0q85l0FCBrXwbDxXUKAgADT/7A=
Date: Tue, 30 Jan 2024 11:07:02 +0000
Message-ID:
 <BY5PR12MB424124B020E2B20741993288E27D2@BY5PR12MB4241.namprd12.prod.outlook.com>
References: <20240129171854.3570055-1-dragan.cvetic@amd.com>
 <170656680094.3132.1588315626789249618.robh@kernel.org>
In-Reply-To: <170656680094.3132.1588315626789249618.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4241:EE_|PH7PR12MB9222:EE_
x-ms-office365-filtering-correlation-id: 981bf461-25fe-4ec2-672f-08dc21839627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 d+XTUB06nsnqiABSaRcIXv3ljrUaTNgD3u7ezpbPIlwNB8uLesK6KK2f+/D2osEzIKj4arDbm3PRPpXj8SnHucnb1U6nPtskhdQ1WGSpZG4g2YR76MzBkJiC+kssoNm/umXakLItInQMSZdUFkpqKiRND7x+4vH4QPr6cLCGq/Qn9n1HcumUXtlwFcBgBn3C70uFxlPuEHKnnVJWJmct+yTNVzRFSJ/bBUET8icAqH4b9lzG5Kh2iUbAG7ppG2DomFy0OqbWi56KL21Ic0jwRtXe1UZWh4E0hiETkrW9maeOnnYZWIcMRTJ3FK5FiSg8MCWykN6GdlA1ccbtJAvf5CH19ajtxuQKUXv1moVzLUlSbHT+eh6MF5ReQiJ4sXOji+53Dsap4n/zt9au7BmMM4+ukyJLCzKLgoPzbEsQwIi7wSHe/QmbDbkD751VOvJOBC/a+HaIUZYwzGzJ0JyPVFRafArdMczpsEXBETKo3FtSou2/Vadb+cU2jPS3ZsGjb5/89ByrciVR2bjf7hfA3L5im0L1kPM8utvABtHecH85Nor4ADtdbPYbH0AcquE+HNAicaWIDPW3VQ5MX+T6FnwE61XV3Jm0+YAFV3QTqXZYnJN/ykcuoNForXmengK2Jsgvlh6iRl1a7d8HPDvj5w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4241.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(7696005)(64756008)(966005)(76116006)(38070700009)(83380400001)(316002)(66476007)(6506007)(53546011)(86362001)(66556008)(66946007)(54906003)(8676002)(8936002)(478600001)(2906002)(4326008)(71200400001)(26005)(5660300002)(9686003)(66446008)(52536014)(6916009)(33656002)(41300700001)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2NXemZTaG1oYmRCVXAyU0ZDeTg3RzYrZzdQUTdSNElLNGpFTTNRbHNBdmFT?=
 =?utf-8?B?SnlDTjJFWFpXSUtCdGNZQmo0U2xJazlYdXJHZUdiMWovdEppTWpjN3QvWG1n?=
 =?utf-8?B?SFkyZGhtaVNIbFlzWHdXQXArNGhIbGF2dWl3Y2tOdFF0MU03VXI5dURsS3RV?=
 =?utf-8?B?RHBPSVVOWHllT1d6UDAvMmVXaTdOajNEdm1jYUtPYzFzU0l0d3dLRUlqcita?=
 =?utf-8?B?RGF3eld6anVKcWt0aEpiLy80RkdIeERvT0d0MjR5TzNoR0FNMHl3STJNVGdC?=
 =?utf-8?B?NmpsZ1RjUHZpN2lucnl0UjN4bkVUbXBCeUNtSmZhbzFJODg4Ly8wODN2L1Fn?=
 =?utf-8?B?c2tTSklmTkl6STkwZ2xlNS9FYVFKd3Z2S2tFN1prMEQ2SXhqMUdSakpNaUFJ?=
 =?utf-8?B?dDZTVG9LQTFocmN1dmdtNlBQY3c1Y2E0RDN4T2xiSFBkODJ6NGdiOGs3WnVJ?=
 =?utf-8?B?eExYSGg2eUVwWks1T1FaU29PTHN2UUxFVjRhWHJlRWxzUk9OOVJqdGcwcExX?=
 =?utf-8?B?emN3WmwxYzB2OXEvWlh0cnJuVmNKYWNLdW1Vc2RSVWpYbXRxcVpLU1BwM2pU?=
 =?utf-8?B?QmNSOFdGeE5uZnJ0SVFKWHV2dG5pV25vbGVJV2FlQ3VyTVNTazNPeHFQL25q?=
 =?utf-8?B?cDVPbGhrYWk0b0hjUUsxa3lvSkU5WjNtZFVBcm4vTklUSjJqT1NCa05JK2xh?=
 =?utf-8?B?TUxwamhPalpIdmErV3BmczEwU0dDQ2pqZ2NPa3l3Z0c1QmlBeVZVV0xZbGFY?=
 =?utf-8?B?SURZN1N4TW5pQW1IUDJJZ2lDbHA1M3p3NlI1aFRZbHBXZ0c0OC9UU1hLRWRm?=
 =?utf-8?B?V1h3b1JZTHo1RUptb1ExQnQrQy95dXpzb1JUbmlxQWdzakxuMEJSSVBnNVM0?=
 =?utf-8?B?bTU4MXpQRWNENEpDU1RoOFZhRG5ZdFM0TU93ZnFyRitpYTZ2Y1BVSXRlNUIz?=
 =?utf-8?B?ekl1VW9GRmZaNVBtaVo1MlpFMWZWcTNTd29NNThVbzdwVlU5UjZ6ZUhLd2hU?=
 =?utf-8?B?L0JaamdQTjlKK1dsQ2lTbWRhME9BU2FWZDY4Z3MybDUzNjlkZGp3Mzh4bG1W?=
 =?utf-8?B?bHZBL1kwSGRFOW4rcjdmVVNqTkI1MzM2OUZXY09ta2xSVjN5QjhpY0p6NHpv?=
 =?utf-8?B?VnR6bjNzbzhId1plVWRWcWtldkYvT2ZvYkdZTjdBcW5HMTV2aGVwUXUzODBF?=
 =?utf-8?B?VHRqUEFFNnBDbml4L3YxODVnNXZZZDNLMmtCL1pYYU45VnFHVDdKVGtLRzdJ?=
 =?utf-8?B?K0NuaTFqZitHQUhvcDJaNHlnOVB0UEtlNlFpNUlxZzE0RzB2dDltZEJqTnJJ?=
 =?utf-8?B?NnQ0dGtVQnZXZVd1MGhlejFqK2FMUjlTRkpFeFlTbHA5VFJSVDRrUU5JZ2lh?=
 =?utf-8?B?dWJ1dVlPRkJGWEVrTlJqbzNrS3h4dWtONmwxaDdNcXJsUUFXaEZnRmV1YWNE?=
 =?utf-8?B?N2xFc3ZaUzZFUDFCVkg5VmJEV2EveERSdnhuMHpaRlZoM3dYekJKWEdWdEE5?=
 =?utf-8?B?eVhzTzlTWml5RE9adUR0RnhCUTA3S0pUU3RqQ1hDMjl5NTVzYXM3YWp3SDdt?=
 =?utf-8?B?NXBqa0dFYVpJMHM3bzN2amNUb0czd0R4WkhDRHJDMlFjN1p0TUExanJ4Zjdt?=
 =?utf-8?B?d0Flc3QyWHJGK0NaLytjbFBtQWV5cUlmR0JBblNPbitRc3BOUFNPNTZqNzk0?=
 =?utf-8?B?Y2ZxU0thcUh2K1BSNVZNd0s4Y0I0VGQxN2ZwOHloWXRNZExxc2RmRmRQYVJy?=
 =?utf-8?B?K3VFSm5CY2N4QmloUlhuUndqdHNtOGpWc0xubS9CREpYUnF0elFuV1NYMG41?=
 =?utf-8?B?RHlObW1ZUG9aMnFVcUVzRzZEdnpNWjJETWM1RmN4cEwwSnlDNThyNWlDVGVB?=
 =?utf-8?B?Y1Z6S05ranRJY1VpYkZTTEJEamtUdmdLZlUvNTVBUXBVNG5ISHZyWTZnd2dy?=
 =?utf-8?B?WTJBdGZLblZKeWV2RmpBS3V0WFgvWGxkWGlSdUNLckMwakMyU0hXYlA3REtZ?=
 =?utf-8?B?dVQ1MmFqdzVuZVU4TDFvQzhGejBqVzhxVnh3RDRnOGl3TlRnOEl5bzVUYkxB?=
 =?utf-8?B?WFN0T2ZOcVkxSlFjTVcrRGFEV3doYktJcHJGamxzLzg4N3RxbDV1SnFIVitH?=
 =?utf-8?Q?/J10=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4241.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981bf461-25fe-4ec2-672f-08dc21839627
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 11:07:02.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGzufItpMISTGC0pHrXAeSp6RR6wCL0pw1waj4uLazQnmzNLyayDVZdQL566KyRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

SGkgUm9iLCANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjksIDIwMjQg
MTA6MjEgUE0NCj4gVG86IEN2ZXRpYywgRHJhZ2FuIDxkcmFnYW4uY3ZldGljQGFtZC5jb20+DQo+
IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5v
cmc+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgU2ltZWssIE1pY2hhbCA8
bWljaGFsLnNpbWVrQGFtZC5jb20+OyBvcGVuDQo+IGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxB
VFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTDQo+IDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zz47IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBLaWVybmFuLA0KPiBEZXJlayA8
ZGVyZWsua2llcm5hbkBhbWQuY29tPjsgbW9kZXJhdGVkIGxpc3Q6QVJNL1pZTlEgQVJDSElURUNU
VVJFDQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBvcGVuIGxpc3Q6
RE9DVU1FTlRBVElPTiA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Qg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBFcmltLCBTYWxpaA0KPiA8U2FsaWguRXJp
bUBhbWQuY29tPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyXSBkdC1iaW5kaW5nczogbWlzYzogeGxueCxzZC1mZWM6IGNvbnZlcnQg
YmluZGluZ3MgdG8NCj4geWFtbA0KPiANCj4gDQo+IE9uIE1vbiwgMjkgSmFuIDIwMjQgMTc6MTg6
NTEgKzAwMDAsIERyYWdhbiBDdmV0aWMgd3JvdGU6DQo+ID4gQ29udmVydCBBTUQgKFhpbGlueCkg
c2QtZmVjIGJpbmRpbmdzIHRvIHlhbWwgZm9ybWF0LCBzbyBpdCBjYW4gdmFsaWRhdGUNCj4gPiBk
dC1lbnRyaWVzIGFzIHdlbGwgYXMgYW55IGZ1dHVyZSBhZGRpdGlvbnMgdG8geWFtbC4NCj4gPiBD
aGFuZ2UgaW4gY2xvY2tzIGlzIGR1ZSB0byBJUCBpcyBpdHNlbGYgY29uZmlndXJhYmxlIGFuZA0K
PiA+IG9ubHkgdGhlIGZpcnN0IHR3byBjbG9ja3MgYXJlIGluIGFsbCBjb21iaW5hdGlvbnMuIFRo
ZSBsYXN0DQo+ID4gNiBjbG9ja3MgY2FuIGJlIHByZXNlbnQgaW4gc29tZSBvZiB0aGVtLiBJdCBt
ZWFucyBvcmRlciBpcw0KPiA+IG5vdCByZWFsbHkgZml4ZWQgYW5kIGFueSBjb21iaW5hdGlvbiBp
cyBwb3NzaWJsZS4NCj4gPiBJbnRlcnJ1cHQgbWF5IG9yIG1heSBub3QgYmUgcHJlc2VudC4NCj4g
PiBUaGUgZG9jdW1lbnRhdGlvbiBmb3Igc2QtZmVjIGJpbmRpbmdzIGlzIG5vdyBZQU1MLCBzbyB1
cGRhdGUgdGhlDQo+ID4gTUFJTlRBSU5FUlMgZmlsZS4NCj4gPiBVcGRhdGUgdGhlIGxpbmsgdG8g
dGhlIG5ldyB5YW1sIGZpbGUgaW4geGlsaW54X3NkZmVjLnJzdC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IERyYWdhbiBDdmV0aWMgPGRyYWdhbi5jdmV0aWNAYW1kLmNvbT4NCj4gPiAtLS0NCj4g
PiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0tLQ0KPiA+IERyb3AgY2xvY2tzIGRlc2NyaXB0aW9uLg0K
PiA+IFVzZSAiY29udGFpbnM6IiB3aXRoIGVudW0gZm9yIG9wdGlvbmFsIGNsb2NrLW5hbWVzIGFu
ZCB1cGRhdGUNCj4gPiBjb21tZW50IGV4cGxhaW5pbmcgZGlmZXJlbmNlIGZyb20gdGhlIG9yaWdp
bmFsIERUIGJpbmRpbmcgZmlsZS4NCj4gPiBSZW1vdmUgdHJhaWxpbmcgZnVsbCBzdG9wcy4NCj4g
PiBBZGQgbW9yZSBkZXRhaWxzIGluIHNkZmVjLWNvZGUgZGVzY3JpcHRpb24uDQo+ID4gU2V0IHNk
ZmVjLWNvZGUgdG8gInN0cmluZyIgbm90ICJzdHJpbmctYXJyYXkiDQo+ID4gLS0tDQo+ID4gIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MveGxueCxzZC1mZWMudHh0ICB8ICA1OCAtLS0tLS0t
LQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL3hsbngsc2QtZmVjLnlhbWwgfCAx
MzYgKysrKysrKysrKysrKysrKysrDQo+ID4gIERvY3VtZW50YXRpb24vbWlzYy1kZXZpY2VzL3hp
bGlueF9zZGZlYy5yc3QgICB8ICAgMiArLQ0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMzgg
aW5zZXJ0aW9ucygrKSwgNjAgZGVsZXRpb25zKC0pDQo+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy94bG54LHNkLQ0KPiBmZWMudHh0
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWlzYy94bG54LHNkLQ0KPiBmZWMueWFtbA0KPiA+DQo+IA0KPiBNeSBib3QgZm91bmQgZXJy
b3JzIHJ1bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbQ0KPiBkdF9iaW5kaW5nX2NoZWNr
Jw0KDQoNCkFjY2VwdGVkLCB3aWxsIGRvIGl0Lg0KDQoNCj4gb24geW91ciBwYXRjaCAoRFRfQ0hF
Q0tFUl9GTEFHUyBpcyBuZXcgaW4gdjUuMTMpOg0KPiANCj4geWFtbGxpbnQgd2FybmluZ3MvZXJy
b3JzOg0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gRXJyb3I6IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL3hsbngsc2QtDQo+IGZlYy5leGFtcGxl
LmR0czozMi4yOS0zMCBzeW50YXggZXJyb3INCj4gRkFUQUwgRVJST1I6IFVuYWJsZSB0byBwYXJz
ZSBpbnB1dCB0cmVlDQo+IG1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5saWI6NDE5Og0K
PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy94bG54LHNkLWZlYy5leGFt
cGxlLmR0Yl0gRXJyb3IgMQ0KPiBtYWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLg0KPiBtYWtlWzFdOiAqKiogWy9idWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctY2kv
bGludXgvTWFrZWZpbGU6MTQyODoNCj4gZHRfYmluZGluZ19jaGVja10gRXJyb3IgMg0KPiBtYWtl
OiAqKiogW01ha2VmaWxlOjI0MDogX19zdWItbWFrZV0gRXJyb3IgMg0KPiANCj4gZG9jIHJlZmVy
ZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2NzKToNCj4gDQo+IFNlZSBodHRwczovL3BhdGNo
d29yay5vemxhYnMub3JnL3Byb2plY3QvZGV2aWNldHJlZS0NCj4gYmluZGluZ3MvcGF0Y2gvMjAy
NDAxMjkxNzE4NTQuMzU3MDA1NS0xLWRyYWdhbi5jdmV0aWNAYW1kLmNvbQ0KPiANCj4gVGhlIGJh
c2UgZm9yIHRoZSBzZXJpZXMgaXMgZ2VuZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVu
dCBkZXBlbmRlbmN5DQo+IHNob3VsZCBiZSBub3RlZCBpbiAqdGhpcyogcGF0Y2guDQo+IA0KPiBJ
ZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUg
dGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3Rh
bGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwg
ZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdCBhZnRl
ciBydW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJzZWxmLiBOb3RlDQo+IHRoYXQgRFRfU0NI
RU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVlZCB1cCBjaGVj
a2luZw0KPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQgbXVzdCBiZSB1bnNldCB0byB0ZXN0IGFs
bCBleGFtcGxlcyB3aXRoIHlvdXINCj4gc2NoZW1hLg0KDQpBbGwgY29tbWVudHMgYWNjZXB0ZWQN
Cg0KS2luZCBSZWdhcmRzDQpEcmFnYW4NCg0K

