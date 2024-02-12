Return-Path: <linux-kernel+bounces-61316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADAD8510EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA231C21762
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0B1B5B7;
	Mon, 12 Feb 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="pNkMoBsG"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2068.outbound.protection.outlook.com [40.107.113.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894018624;
	Mon, 12 Feb 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733946; cv=fail; b=AvTy4vEzkYoiKeZuB6AzwdBf6UmPDS0Ohb2QM92L5slTBUo2CNqV1p/11Wvp89g4GdlkpRFsrk6u7fMOw2JBdNWxdCQAepkQoWBpMDJn3CeEuHQR2FoaCMF0JaGK0dIEgxosql2Kk8Wy0miH5noDB9aNtdVJd30xY8bDV6H7NiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733946; c=relaxed/simple;
	bh=UtoHjpiAFfSttlIVa1aPzlW0gZx9xe5rLybuAPWUDm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BEQ8vxZPG29KyCZ6M1ZPtHkr0aJQFju5+xnUaLeeUipOepyPFAqSECVtqbRcsCHd1cNpV22mtQNyUGD+J+Zt7Tsy6wZOpHUzQljKHwUPRBO58Q/IhaJDuU6Z1liMzIOHV3ahe3kkaLgogs/dSMgA++eTu9TU9KuR+46OUCIerT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=pNkMoBsG; arc=fail smtp.client-ip=40.107.113.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfGxnmxFujBd6xLQhq0Hq8BzrFq7+7Sxh8YCOKNscLs2JKDXEs87lFasMKrn44aIPMV35HJDNxCRrUjKttSiDm5/pT4Ic/vUlPw1ftGTwZBrU5PmXKs1RIDcUI5qwhBWz38c4rEceR0WJHsNfWP9aWln2SaQnh9G6yZXZz9FaLdV2TZ3Vgm2KS+hS6HIABTobAcDuV/a8gd85TgMGXoPsKKaTDz9wQBDxj431TmqpY0jgJ37WuvAE7iTIwoR0mKzQypj2VS3DZ0Y1QhdEwhCUZn2z+cSiwBDYk/eEXkC0lTjbCo/jjoEPnrWWrZQBr6XKvQS5/VXRsD4+aAieJ46/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtoHjpiAFfSttlIVa1aPzlW0gZx9xe5rLybuAPWUDm8=;
 b=OIN9OphZ/Cgu+6fixvxMxHZkcLm/eUEacv9vNe/dqpjjNoTTFOHtfb/fFdjL7xuNXeEvuapmn5LQk/H26o658utTlOjR+XYPZFmY2XyuU7eX0JsDKmWGVQJ5pNACfY+7FKEvyH+sL9/NxfnvFt+Lg0fvT1xSs7tM/tsCuJsA3YXB3C4jNeYl0HvSnXGpORyUQ5bz8qeP12ExK8DtGhDdspAK6Jq++eHC0tj9t5a30xkmoT655lOtYyrjKJZL1T59cy4pxKzKfW5+R1seyvjlfX7C2bsBFiZ/VJ4KYkaXpdX5XxqzsyuDuXoD6gS7tmn+dU/iwLVngi4CCmrQ5XUGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtoHjpiAFfSttlIVa1aPzlW0gZx9xe5rLybuAPWUDm8=;
 b=pNkMoBsG1fP7Nf1HQmliiqMTlqu1vRl58Ta0e/WNklsXVotpjFogVx8Bg/gOiu793HA0o8ewdHWRTe+iaAMdzdO0NkywxRRDikryz52p3QlKYJuBfvdd3480U1R6KCP8ldxWgzWzgzFMYr6X3wj0wgTIAqKDromptf7JUSMzrQY=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB8269.jpnprd01.prod.outlook.com
 (2603:1096:604:1a0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 10:32:18 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 10:32:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power domain
 IDs
Thread-Topic: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power
 domain IDs
Thread-Index:
 AQHaWox93XkHXchpTkaSnTQ6Ok/3vrEAgGfQgAAWUICAAAlS4IAACXEAgAAoXKCABYymgIAADp0ggAAXD4CAAACZYA==
Date: Mon, 12 Feb 2024 10:32:18 +0000
Message-ID:
 <TYCPR01MB112695D036C4738828F16678586482@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269DEA9261CA594EECC949686442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <67ad8052-1406-4dcb-9e35-5c42ada28797@tuxon.dev>
 <TYCPR01MB112698AB206332D13105C064186442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <e170f5f8-f95c-4553-b088-1072345fae53@tuxon.dev>
 <TYCPR01MB11269015C92AA327DC6BFA76586442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <786f90f4-ba47-46cb-b5e0-e3c42b1b741a@tuxon.dev>
 <TYCPR01MB11269A240E2EDD460D0B97B9786482@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <b484c9ef-254e-4cdb-8409-6f0af1171335@tuxon.dev>
In-Reply-To: <b484c9ef-254e-4cdb-8409-6f0af1171335@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB8269:EE_
x-ms-office365-filtering-correlation-id: 4e393f96-a4fe-4f49-9f18-08dc2bb5e37d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5mGlkQaInUDLza+wTqLUyvZGq5RXRjGZ5qoLLr0IywIwUPxafQh4Qyvw1PYtCpEw4CQbU/QNmjnR2WrsL1q6rsWqzTVmBEv+5oL5KzUOkvxDTUGnlRZw4sX+/YBfpXZQS/ioFhW1c1tH5GeK46WaUYmnd8bKTkLf9sPU1EZbOBlNRdWIwZtPQnLhECFUeHx8ooyyhOjSc7pjOLoFYISjaKSpksvE8YzSnt6Kn9YeG86OMNteI5Y1w0prPMFMsJzjEwlvRPng/jOjYkXwcyKH+HnPv8M4wuO3RULsMWKJEh3n1fVNTWldQ/6yokbUoPBPzOEozjGgNfKt6y59aBNrF19gh0Kl4mJVsiyDizOB4YPzN/YEwLpLo4oiJKLWabBjRx6OY0a5mjAZuClvVBeRw2tfFrYh1KNgtSvjIJQGaUtCj3Y9htadh390uA9guk+Rxknq5Zn5kk46pVc2W2kVIlp/WtfRcXfh/yyvbJ1MbOH5cJY+N1u8FCpCb8Gp351Vy8Ox72Os/F68gl8eHxO5RfPXGGQctPvDK03TITXJFSnmkdMLFujiK2jqKmm5eFh0ZckW2z0lC2rRRLgMzRdcLqg3O0lr5FlJ8ttFLnozC3Mh64fYy6EJ8S8kJCKVXHfSx7vboXDWjfm+THJTL2J1OQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(26005)(71200400001)(41300700001)(55016003)(2906002)(66946007)(66476007)(66556008)(66446008)(64756008)(76116006)(7416002)(8936002)(8676002)(52536014)(4326008)(478600001)(83380400001)(38070700009)(53546011)(110136005)(316002)(7696005)(55236004)(6506007)(54906003)(9686003)(107886003)(86362001)(122000001)(921011)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wkp4UTBuZlJSQXU3bjR5dFAwamc2eTFHVnVVMENzTHZaSklJelB4YW5JQ0Ir?=
 =?utf-8?B?V1ptYTNYazYwUUhEK3M1WU50Y0VZMmk0WkhKWWtrMm5TN2hhNVNvVUh2cU8r?=
 =?utf-8?B?Nm9ZUm9DQzBSWUZvOW51SkFqYUM3OUFBZisyVE5mR0lQUUUzRGZOclhsMDl6?=
 =?utf-8?B?aXdPdWt0M3ZtYnpHVnRHd3YrMUVrMEpBUjl1UmtCa0lMcUhXWGZxaXhUSWRC?=
 =?utf-8?B?dHhCMUJkaTNWdG9JNEZTeHR3bDY4RThoY2NrTHNPSWxlUnlTNGoxSFF3enU1?=
 =?utf-8?B?UGt4M2hMOG5Wci9WNzQ2Tkh1ZXBaQ2RNUDR4SjZ0WW5jOUdsRktTTFRqRG9L?=
 =?utf-8?B?Q01JUDdCYW9GL1BGNERDM2hZWGU5STN4bTNJbUdLSWNsQnVHOEtoZGlkbWJn?=
 =?utf-8?B?Z2lrTE5jV1dxWGt2bGozemFmSGdWWVZUeFZkZ1dyREpaWDQ0SDl6bU9LMmdn?=
 =?utf-8?B?RmtFbngrV0l1QXJ3VlB6Q1cxMDAwRWtXZmZXamFtd1UvRHF4d0FkKzlCNUFZ?=
 =?utf-8?B?M1lCUEJZZ3VhcTZ6clp6SVBheE5wSDl2aGovalpBREF6T0ZDOGptVjRLMVRO?=
 =?utf-8?B?NlZNMFJJUk5BaUFRU2wvZGFtTmt6ZkZVNnFmNWpTdk45S1lXRFN1YjU5Y2xz?=
 =?utf-8?B?dk9wVUIydTZTSWJZa2lZSDZmbnVxSjNNcVhRbDhLVXJpSWpHbnh5OXlXVjJ1?=
 =?utf-8?B?WCtFVCt3Z3ZQZ21JUGxYeWNIcjI4RzRKaXBOQnNSem11Tk8xVmxrN1BrUDFM?=
 =?utf-8?B?aXhEcm9oYTlzQnhqUG5NT0NzdDExeElYQWlpT0xHK3JhRDkvK0tjTC9PU2lz?=
 =?utf-8?B?NlpFVzEyZnZBc3VnUEx5dk1za2p2ZW5LR2krZW41MmF0cEVYRDdNU1pVMjBw?=
 =?utf-8?B?WEFjb2tIT2FvOUJzVGgySEttMVBhZWdlUEhHenZxcmRlc2J0ejhEZzRWZ0FF?=
 =?utf-8?B?ODVMakZ0OEphTHRFakZiWTJDb0hTOU1OclU4YTQ1cGkyb0htS05BMzRtTXhR?=
 =?utf-8?B?T044RGxuejhVQlc4S3I4K210NkRqUG9XNE43M2JUbUp6NjhJajR0c0w1cGFO?=
 =?utf-8?B?eDdMaTFFSU1JRnpveC9JWWxDdk1tYVRBcno3YjlZVTlxVWhIRHNBR0xVY3E3?=
 =?utf-8?B?ays0RVY1c2p0dmdTTHJIc0VHeTdWSnA0cVF2bDNNZHBHUExhU1E1RkpGMSs3?=
 =?utf-8?B?bWdaZnFPNE40MHpnbmVWVDJqWTJoc1NtKzYvWEs2VHd6NDhhdHVxOGhzaUlr?=
 =?utf-8?B?c1BLYVB3eUYwSHhxYkl5RGFhTStNbEZQTDBwek9qRlZ3VFMzdCtFbTBvcFp2?=
 =?utf-8?B?cXhhZktkaUVVSVJIY2p0dWgyMWFSK0lRK2plZkFub1lYTWJ1eWNoQzk3MTlY?=
 =?utf-8?B?Uy9qcldIWkVJb0UrSjVyZ09yMGo3cTdlU1crelFmQmI2ay9xN0xETHkrbUZr?=
 =?utf-8?B?aGk5bU1NUjNpM0drQlJ5eWY4ZmNLdDNadE1PWVRZR3pjNWV0UmlBMjJWa01Y?=
 =?utf-8?B?Vy90RXNOMGZqbWVKREJ1b2R0Zk9hSUdQYVJLM2dWYzAvUjBoS29YZ2hSaUdu?=
 =?utf-8?B?UUJsbGUzU2ZYdTNQL2xXSTA4WmMyYTBuZ3B6c2owbnBnRytYMXVmZ0VjcXB3?=
 =?utf-8?B?RU8yWEhZM1JybWxLZlQ4RVBGN1htU2xYMU42SmFlYTVZV2M0T2RYVmcwNTlS?=
 =?utf-8?B?R0VDTmdwSnNxM0RUaEJ6MmlvWDgxd3lWOXY4TERUaWVMSnZsaUVHVEhSQ3g1?=
 =?utf-8?B?SnUrZ1JkQ2tmUEdQUVo3bFE2MkRmU1d3UnJZOWxaV1QxeE5DL0x5ZkQwU1Jq?=
 =?utf-8?B?c1RWYjZscVNLY2puandhYmJlbU8vNDQrTkRZemcvTTMzVkx2NEkwWUEwQllI?=
 =?utf-8?B?VFhWVHdkUkRaRmdxd0xkZkVyL2pEVDE1bkc4eU5sUjNwQWFLWXNEWWNXeVcz?=
 =?utf-8?B?RGpsS0dCQ29yS3pCWUF1blpHSkI1V0NWTVhJeWxtaHRxNWJ6amR0STZQTmVN?=
 =?utf-8?B?Qk1tVWk3elR2djJIemhUb3dKWkJsS1dMQ0o1cS9ndXI5Y0N3UnZDelN5NDRC?=
 =?utf-8?B?N1V1WUNtUzhmd3RETFJnT0YrRTh5TmcwbXZzSFJVUlNUYWdJejJnR0lLSHNJ?=
 =?utf-8?B?ZzhsNUlHYkRZMVZoTVVhcnBqbHpNanFvN2ppcHErL2VuZXNoSzdZWmlKSXZN?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e393f96-a4fe-4f49-9f18-08dc2bb5e37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 10:32:18.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4u9B6PZWkin79DvTgS4xvZK+Bvkf+WH/iSTFExiXPegICXKjvWb0xd8Gvox7V0Oi7oGHBmYP75s0d7jn+s2fCM97PuVyp3BMPu+GvMi28Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8269

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBNb25kYXksIEZl
YnJ1YXJ5IDEyLCAyMDI0IDEwOjE3IEFNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMTddIGR0
LWJpbmRpbmdzOiBjbG9jazogcjlhMDdnMDQzLWNwZzogQWRkIHBvd2VyDQo+IGRvbWFpbiBJRHMN
Cj4gDQo+IA0KPiANCj4gT24gMTIuMDIuMjAyNCAxMDo1OSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4g
SGkgQ2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBjbGF1ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+PiBTZW50
OiBNb25kYXksIEZlYnJ1YXJ5IDEyLCAyMDI0IDg6MDIgQU0NCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAwMS8xN10gZHQtYmluZGluZ3M6IGNsb2NrOiByOWEwN2cwNDMtY3BnOiBBZGQNCj4gPj4g
cG93ZXIgZG9tYWluIElEcw0KPiA+Pg0KPiA+PiBIaSwgQmlqdSwNCj4gPj4NCj4gPj4gT24gMDgu
MDIuMjAyNCAyMToyMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IGNsYXVkaXUgYmV6bmVhIDxjbGF1
ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+Pj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDgs
IDIwMjQgNDo1MyBQTQ0KPiA+Pj4+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+OyBnZWVydCtyZW5lc2FzQGdsaWRlci5iZTsNCj4gPj4+PiBtdHVycXVldHRlQGJheWxp
YnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiA+Pj4+IGtyenlz
enRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gPj4+
PiBtYWdudXMuZGFtbUBnbWFpbC5jb207IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsNCj4gPj4+
PiBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdQ0KPiA+Pj4+IENjOiBs
aW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5v
cmc7DQo+ID4+Pj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+Pj4+IHJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IENs
YXVkaXUgQmV6bmVhDQo+ID4+Pj4gPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0K
PiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMTddIGR0LWJpbmRpbmdzOiBjbG9jazogcjlh
MDdnMDQzLWNwZzogQWRkDQo+ID4+Pj4gcG93ZXIgZG9tYWluIElEcw0KPiA+Pj4+DQo+ID4+Pj4N
Cj4gPj4+Pg0KPiA+Pj4+IE9uIDA4LjAyLjIwMjQgMTg6MjgsIEJpanUgRGFzIHdyb3RlOg0KPiA+
Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+
Pj4+IEZyb206IGNsYXVkaXUgYmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+
Pj4+PiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgOCwgMjAyNCAzOjQ2IFBNDQo+ID4+Pj4+PiBT
dWJqZWN0OiBSZTogW1BBVENIIDAxLzE3XSBkdC1iaW5kaW5nczogY2xvY2s6IHI5YTA3ZzA0My1j
cGc6IEFkZA0KPiA+Pj4+Pj4gcG93ZXIgZG9tYWluIElEcw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEhp
LCBCaWp1LA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIDA4LjAyLjIwMjQgMTY6MzAsIEJpanUgRGFz
IHdyb3RlOg0KPiA+Pj4+Pj4+IEhpIENsYXVkaXUsDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBUaGFu
a3MgZm9yIHRoZSBwYXRjaC4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+Pj4+Pj4+PiBGcm9tOiBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5lYUB0dXhv
bi5kZXY+DQo+ID4+Pj4+Pj4+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA4LCAyMDI0IDEyOjQz
IFBNDQo+ID4+Pj4+Pj4+IFN1YmplY3Q6IFtQQVRDSCAwMS8xN10gZHQtYmluZGluZ3M6IGNsb2Nr
OiByOWEwN2cwNDMtY3BnOiBBZGQNCj4gPj4+Pj4+Pj4gcG93ZXIgZG9tYWluIElEcw0KPiA+Pj4+
Pj4+Pg0KPiA+Pj4+Pj4+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpA
YnAucmVuZXNhcy5jb20+DQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IEFkZCBwb3dlciBkb21haW4g
SURzIGZvciBSWi9HMlVMIChSOUEwN0cwNDMpIFNvQy4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4g
U2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWENCj4gPj4+Pj4+Pj4gPGNsYXVkaXUuYmV6bmVh
LnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4+Pj4+PiAtLS0NCj4gPj4+Pj4+Pj4gIGluY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svcjlhMDdnMDQzLWNwZy5oIHwgNDgNCj4gPj4+Pj4+Pj4gKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPj4+Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRp
b25zKCspDQo+IFsgLi4uIF0NCj4gDQo+ID4+Pj4+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9U
U1UJCTQ2DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBOb3Qgc3VyZSBmcm9tICJUYWJsZSA0Mi4zIFJl
Z2lzdGVycyBmb3IgTW9kdWxlIFN0YW5kYnkgTW9kZSINCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFBv
d2VyIGRvbWFpbiBJRCBoYXMgdG8gYmUgYmFzZWQgb24gQ1BHX0JVU18qKipfTVNUT1Agb3INCj4g
Pj4+Pj4+PiBDUEdfQ0xLT05fKioqIEFzIGZvcm1lciByZWR1Y2VzIG51bWJlciBvZiBJRHM/Pw0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgeW91ciBwb2ludCBo
ZXJlLCB5b3Ugd2FudCBtZSB0bw0KPiA+Pj4+Pj4gZGVzY3JpYmUgUE0gZG9tYWluIGluIERUIHdp
dGggc29tZXRoaW5nIGxpa2U6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gcG93ZXItZG9tYWlucyA9IDwm
Y3BnIENQR19CVVNfWF9NU1RPUD47DQo+ID4+Pj4+DQo+ID4+Pj4+IE1TVE9QIGJpdHMgYXJlIGRp
c3RpbmN0IGZvciBlYWNoIElQLg0KPiA+Pj4+Pg0KPiA+Pj4+PiA8JmNwZyBDUEdfQlVTX01DUFUx
X01TVE9QIHg+OyB4ID0xLi45DQo+ID4+Pj4+DQo+ID4+Pj4+IDI9TVRVIElQDQo+ID4+Pj4+DQo+
ID4+Pj4+IDQ9IEdQVA0KPiA+Pj4+Pg0KPiA+Pj4+PiBldGMuLi4NCj4gPj4+Pj4NCj4gPj4+Pj4g
SXMgaXQgc29tZXRoaW5nIHdvcms/Pw0KPiA+Pj4+DQo+ID4+Pj4gSXQgbWlnaHQgd29yay4gQnV0
Og0KPiA+Pj4+DQo+ID4+Pj4gLSB5b3UgaGF2ZSB0byBjb25zaWRlciB0aGF0IHNvbWUgSVBzIGhh
dmUgbW9yZSB0aGFuIG9uZSBNU1RPUCBiaXQsDQo+ID4+Pj4gdGh1cywgZG8NCj4gPj4+PiAgIHdl
IHdhbnQgdG8gdW5pcXVlbHkgaWRlbnRpZnkgdGhlc2Ugd2l0aCBhbGwgTVNUT1AgYml0cyAodGh1
cyB0aGUNCj4gPj4+PiAybmQgY2VsbA0KPiA+Pj4+ICAgYmVpbmcgYSBiaXRtYXNrKSBvciBvbmx5
IG9uZSBpcyBlbm91Z2g/DQo+ID4+Pg0KPiA+Pj4gV2UgY2FuIGhhdmUgYW4gZW5jb2RpbmcgaW4g
dGhhdCBjYXNlIDg6MTYgMjQgYml0IGVudHJpZXMNCj4gPj4NCj4gPj4gSSBjb25zaWRlciB0aGlz
IGNvbXBsaWNhdGVzIHRoZSBiaW5kaW5ncy4gSSBkb24ndCBjb25zaWRlciB0aGlzIGlzDQo+ID4+
IHRoZSB3YXkgZ29pbmcgZm9yd2FyZC4gQnV0IEkgbWF5IGJlIHdyb25nLiBJJ2xsIGxldCBHZWVy
dCB0byBnaXZlIGhpcw0KPiA+PiBvcGluaW9uIG9uIGl0IGFuZCBjaGFuZ2UgaXQgYWZ0ZXJ3YXJk
cywgaWYgYW55Lg0KPiA+Pg0KPiA+Pj4NCj4gPj4+PiAtIHNvbWUgSFcgYmxvY2tzIChlLmcuIE9U
RkRFX0REUikgaGF2ZSBubyBNU1RPUCBiaXRzIGFzc29jaWF0ZWQgKGFzDQo+ID4+Pj4gb2YNCj4g
Pj4gbXkNCj4gPj4+PiAgIGN1cnJlbnQgcmVzZWFyY2gpLCBzbywgb25seSBQV1JETg0KPiA+Pj4N
Cj4gPj4+IFdoeSBkbyB3ZSB3YW50IHRvIGFkZCBwb3dlciBkb21haW4gc3VwcG9ydCBmb3IgRERS
Pw0KPiA+Pg0KPiA+PiBUbyBwb3dlciBpdCB1cCAoaW4gY2FzZSBib290bG9hZGVyIGRvZXMgYW55
IHNldHRpbmdzIGluIHRoaXMgYXJlYSkNCj4gPj4gc3VjaCB0aGF0IHRoZSBzeXN0ZW0gd2lsbCBu
b3QgYmxvY2sgd2hpbGUgYm9vdGluZy4NCj4gPg0KPiA+IEREUiBpcyBlbmFibGVkIGJ5IFRGX0Eg
YW5kIGlzIG5vdCB0b3VjaGVkIGJ5IGxpbnV4LCBzbyB3aHkgYXJlIHdlDQo+ID4gYWRkaW5nIFBv
d2VyIGRvbWFpbiBhdCBhbGwgaW4gZmlyc3QgcGxhY2UuIFRaQyBERFIgaXMgbm90IGFjY2Vzc2li
bGUgaW4NCj4gbm9ybWFsIHdvcmxkLg0KPiA+DQo+ID4gU28gaWYgeW91IGRvbid0IGFkZCBERFIg
cG93ZXIgZG9tYWlucywgbGludXggZG9lc24ndCBrbm93IGFib3V0IGFueQ0KPiA+IHRoaW5nIGFi
b3V0IGFuZCBpdCBzaG91bGQgd29yayBsaWtlIGN1cnJlbnQgY2FzZS4NCj4gDQo+IEl0IGlzIHJl
bGF0ZWQgdG8gdGhlIHdheSBNU1RPUCBhbmQgUFdSRE4gaGFyZHdhcmUgZmVhdHVyZXMgd29ya3Mg
dG9nZXRoZXIuDQo+IFBXUkROIGFsbG93cyB5b3UgdG8gc2F2ZSBtb3JlIHBvd2VyIGJ5IHNldHRp
bmcgSVAgc3BlY2lmaWMgYml0cyBpbiB0aGlzDQo+IHJlZ2lzdGVycyBhZnRlciB5b3Ugc2V0IHRo
ZSBNU1RPUC4NCj4gDQo+IE9GVERFX0REUiBhbmQgVFpDRERSIGhhdmUgUFdSRE4gYml0cyBkZWRp
Y2F0ZWQgYXMgd2VsbCBhcyBvdGhlciBJUHMgKGUuZy4NCj4gc2VyaWFsLCBldGhlcm5ldCwgZXRj
KSBpbiBDUEdfUFdSRE5fSVAyLiBTZXR0aW5nIENQR19QV1JETl9NU1RPUF9FTkFCTEUgdG8NCj4g
Q1BHX1BXUkROX01TVE9QIGFwcGxpZXMgdGhlIHBvd2VyIGRvd24gZm9yIHRoZSBJUHMgc3BlY2lm
aWVkIGluDQo+IENQR19QV1JETl97SVAxLCBJUDJ9Lg0KPiANCj4gSXQgbWF5IGhhcHBlbiAoYXMg
aW4gbXkgY2FzZSkgdG8gaGF2ZSBhIGJvb3Rsb2FkZXIgdGhhdCBzZXRzIGFsbCB0aGUgYml0cw0K
PiBpbiBDUEdfUFdSRF97SVAxLElQMn0uDQo+IA0KPiBJZiB5b3Ugd2FudCB0byBzYXZlIHBvd2Vy
IGZvciB0aGUgb3RoZXIgSVBzIGxpc3RlZCBpbiBDUEdfUFdSRF97SVAxLElQMn0NCj4geW91IGhh
dmUgdG8gaW5zdGFudGlhdGUgcG93ZXIgZG9tYWlucyBmb3IgdGhlIGJsb2NrcyB0aGF0IHlvdSBk
b24ndCB3YW50DQo+IHRvIGJlIHBvd2VyZWQgZG93biBkdWUgdG8gc2V0dGluZyBDUEdfUFdSRE5f
TVNUT1BfRU5BQkxFIHRvDQo+IENQR19QV1JETl9NU1RPUCwgdG8gcG93ZXIgdGhlbSB1cC4gT3Ro
ZXJ3aXNlIHRoZSBzeXN0ZW0gd2lsbCBibG9jayB3aGVuDQo+IHNldHRpbmcgQ1BHX1BXUkROX01T
VE9QX0VOQUJMRSB0byBDUEdfUFdSRE5fTVNUT1AgKGlmIGJvb3Rsb2FkZXJzDQo+IHByZXZpb3Vz
bHkgZGlkIHNvbWUgc2V0dGluZ3MgaW4gdGhlIGFib3ZlIHNwZWNpZmllZCByZWdpc3RlcnMpLg0K
PiANCj4gSG9wZSBpdCB3YXMgY2xlYXIuDQoNCk9LIGdvdCBpdCwgQmFzaWNhbGx5IHlvdSBhcmUg
c2F5aW5nIGxpbnV4IFBNIG1lc3NlcyB1cCB0aGUgQ1BHX1BXUkROX0lQMiBiaXRzKHswLDF9DQpz
ZXQgYnkgVEZfQSBmb3IgRERSL1RaQyBERFIgYW5kIGxlYWRpbmcgdG8gYm9vdCBmYWlsdXJlLg0K
DQpDaGVlcnMsDQpCaWp1DQo=

