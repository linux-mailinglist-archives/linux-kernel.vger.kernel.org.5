Return-Path: <linux-kernel+bounces-43399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F184135E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE6FB23F49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E693476022;
	Mon, 29 Jan 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="gi6+hD9u"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A66F098;
	Mon, 29 Jan 2024 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556374; cv=fail; b=OS0cUdlh+RNmoD0fhBMwUQ4aAxpCIgBPV9+OBoHXE7VlcfEteL7Wlcsk3ZAksIFUGtTRu0DdK/9Roxku05NxdktvLoFjTNa8ooZDOSmbSc2LkBp10y2m6U057ac4gcevhV9WmgkKFXvi4XApYyeVqVbiRfELYFUnsdTJze7/mXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556374; c=relaxed/simple;
	bh=uTX+hJIzP8Xe6tI7AXGFDLrU2MGTJ9LcDrHEcacMqmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ff0/lM6+05J32P08YqCA5VjBlhnzyaVedAxUyRUB894Q5V+nENUvyRwAAb546y4nGg2qSUxeeqpkyzLNa7v+mRk2hS2zT61RABRzN1okd1NcvFU1tIimjpcW04C0ejjIGOPSq5gQ366vCmoC8p8cPjfTTSm9A3e/Kx4XZ61l2mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=gi6+hD9u; arc=fail smtp.client-ip=40.107.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyUhEskcsLwwnnYwP56B679fxMX3YIxapgatNBESBxwWsp2rPZC2yacBGRvAMKK2Durl0ULaNWTbtwzT0lUS33bmqKQ3sckhh2DZyZFysEYenSc2cS88O0C8zyasTmYIxY6umeKxSF01ru6HCtWcpL7ttuLF7wmuxY5HIB8fK3FGaO7aDNd8/QjMrB0FuMbRYAq6ezsmlz9BDyIaHrU5TZADyS7hmphD7beqfPUMyGb3+J2h5BAvxEd9unngdnZq9tZ9XT6xSjjpIQHi7inO5CA0QskEDGEGc87DM9VuT0BqJZB75CpP+Q3LYPWJbTc2eZ2MsAl3oPM+slGqLxfADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTX+hJIzP8Xe6tI7AXGFDLrU2MGTJ9LcDrHEcacMqmA=;
 b=EdSyMQ7Oe+TOPpxmf5flfoQWUoDmMQEAIfxsOI0uDnngwoMRK9V6PQvCV1bKwKiOEHViXS/UTnsmxrZ2MOOs6TBE3L4aAr8WbG19jovz9uz5vaWsRhY2vOflnbBROzZujjcRqmze05hgj4H7EtBUpLnO4Mx58gfRax2XNWg4l/IStmCgw/UZMgGtkE5VA9fZyDVc35EUhbbTuGrMom19LC7POLUz4DDoKameX2uIlBmF3V0JtVJUjqWuhop4lXdrD3TMEt2Tjo4dCpHcidHD93BHoUpC5588ItlH6LYr2EfO56LyShDGz8JpSsmv6kibjmQosFBp1WCNm9aWWzDrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTX+hJIzP8Xe6tI7AXGFDLrU2MGTJ9LcDrHEcacMqmA=;
 b=gi6+hD9u2xeAP7DLz1gAgxqgGMWdLcyDbzPHeLF0xU6xNV3yDGLxL6f0G3l3A9RcU9MB9bY2g2J58dLQJZfS7SSszOKXn8DSg5tDJB8P3s3RPVV+ohkHzcrfaMspl3LGnqxVy4ERDWz51mxarv9IIclUmg5CutJLugKijjXQ7RE=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB9131.eurprd04.prod.outlook.com (2603:10a6:10:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 19:26:09 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:26:08 +0000
From: Josua Mayer <josua@solid-run.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1 aliases
 to fix hctosys
Thread-Topic: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1
 aliases to fix hctosys
Thread-Index: AQHaSh83Bz2MXkS5bUKUDFs8xYpYK7DfvIwAgAFPfoCAABuCAIAADTGAgBAJBYA=
Date: Mon, 29 Jan 2024 19:26:07 +0000
Message-ID: <8d5bfef0-ced5-4f3f-a176-707b0dcbd0ea@solid-run.com>
References: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
 <ZalMsJZKrpwncEDp@shell.armlinux.org.uk>
 <79f9bd25-a05f-43b2-8d93-5d51adae1824@solid-run.com>
 <24c24b0b-da49-4452-b6ad-64c4c2d20e11@solid-run.com>
 <ZaqIQ7X4/iI3jxtU@shell.armlinux.org.uk>
In-Reply-To: <ZaqIQ7X4/iI3jxtU@shell.armlinux.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DU2PR04MB9131:EE_
x-ms-office365-filtering-correlation-id: 70f7986a-d207-4b6d-4d38-08dc210024bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kVsSiP15s2o6+l3XF8Eeg7f/4o5nTAcdHE5/sSrq8+JaSVBl9/alWkFF/1t2I5yE7CfM2BMRLG2/sMj3quq/ytfgdFRFJ90NTY+VfTpXaIVzSHIETRc5XuHs8N78FCcKHPEzYP0fBijopcU1MLgVy62Xjl2nGouex5zjvXxYzC8mpsb3T1bFvKgn+jpV7GNlpXTNTmDpkAyolL1/oNcwrysKDyR/2KLfDeqy2IjVloxtNlbfieTlpV+cyPsYSULJVTvh+vBukQdeqDr/nTz5LhBAuEZ4+pZJsd+kOEme+KVNrlhLbz2o7grRNUOLaY46CNlV8QL/vUj4KZPbIsjG0m64EJhWZi+zoJ5+KOOdywazhsq5puJznjlzl/gvm/llNq95sxPe0IfALrRHmTgkcl422sBQYXhvyXxvxKxxDlgTSpPN9EMQV3BZPp6JUOW/CtOSNc95UIZfRcDyMYYvDlfFl8v6ndH/Q4wkkQycRKcPElp/gzqmzUlxPvaq3tp0Umv/eNfzn0ltNw8CES8NgxZK61LSwVWWF7KcipbuuIkITifdsMFOedo5wAZMhva9Yl87szDpkXg6PyrajfCfNuP/I7d+4jc+SnvJP2akI/k78WP0t2uUozah1rfE2pO0BR8DYwklTUg1zNm5nXg3inrgKyzhCmR0rB3aMqk+mf/CH+qxnnwj6Nt9gzDifkJlK5Xa0UCvqaxrva79RUUp/A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(396003)(136003)(346002)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(36756003)(31696002)(38070700009)(83380400001)(71200400001)(54906003)(6916009)(66946007)(66476007)(66556008)(86362001)(91956017)(8676002)(64756008)(6506007)(66446008)(316002)(6486002)(8936002)(2616005)(478600001)(4326008)(26005)(2906002)(76116006)(66574015)(7416002)(6512007)(5660300002)(38100700002)(122000001)(41300700001)(31686004)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nlp2b2VWMkNyNkxaLzlsTFQ1TnV1L3JkVi9aV3Q2VTBkdEdtM1RkQjNaeTQ3?=
 =?utf-8?B?RnBFTEcxbzZ0TUg2NVlhSE5RTjFmalphSjJKbXJQcFJuNU9ZRE5JOUwrLzNO?=
 =?utf-8?B?R1F0ZjJFTDF0YjJsZ0tudC83TUNOVkIxa01QZGt0N3VUNUg0MldXRlFTYWlW?=
 =?utf-8?B?Mzl6b0JSYUhLOVFNa2RyVVd3dHNsOTAzcDI4a0h3MDBQcEQvRmdxejFGSnlK?=
 =?utf-8?B?MmRadVNaN2VqWkovdmczVElBYmZCS1lxZXNKQlFneGhjTVhMWFdEdzR5VHNB?=
 =?utf-8?B?Q0dKVG9GL3Zxd2w2MDFnOWVSL3p5THB0OS9TYWNOTmRZZTZJZFhiZHRsZHdI?=
 =?utf-8?B?aEFTZmYyTlRiTGlkSjkrVzlhMENRSTR0dXRtSFZucWhiMU9ESSs1YXFyVUpL?=
 =?utf-8?B?d3BxN2diTlZRVDhGVUNFNHkvRXk1MUZmdWd6U1ZXaXVTNzI5bmVaVitYb1Vi?=
 =?utf-8?B?V3drN1pueVhFZnltUDVCUFMxVFk0NmlzN2dUdU1ZcThUS0pEd0tCb2d3enhD?=
 =?utf-8?B?TFQrQVZFbkQ1RnRnL29HRWM0bFhZQWNvSkRYWTk5VVMvWWliUzF2clR0eE1H?=
 =?utf-8?B?NXhaOFdZaFMvRVFFNWVQay9oWVl2WWo3SXlNV3M5QkdRbFBNenh2bXlFaVJo?=
 =?utf-8?B?Qy9DVlY2VE1vSlJiQ29LL2FhQlZhNkd0NUwrWGJTN1ArWFBtL1F0aXpIcDF0?=
 =?utf-8?B?ekZ3U0dvRTRqT2djUWw3Q1NCSmxJKzloZ1RVbjNSdjNWTU43UXh5R1ltc2x5?=
 =?utf-8?B?dk5ZbDJxZWQwdGhGVExWRis2ZWhPdGFsWEFNZStLUjc5VGdxK3MzTVlmc3dH?=
 =?utf-8?B?REJnUERLUnBKUGxaalBpNWl2STl4MkJ4dU8yMVhSdEw4dEFUME9taDZkbWNq?=
 =?utf-8?B?cExmSVczSjh4N29QQ3B3Qlo4eTMwWVN5Zm5vc0E3eTUrRkhoVThubXJZRzRI?=
 =?utf-8?B?dkZ6ZmFSdW16TFI0ZkVSNUN5a2pseFlmNXNDWTRSUEl4cmZPNm9JSDNWMmha?=
 =?utf-8?B?c1hENDRsNkVIdVMzcjlpZ2YwSDZ3bUcrZjIzcXJ6d2FpSlVmUndBRlZNcGtD?=
 =?utf-8?B?aEJNY05Ed1RwK2gySEo0R0FKUkh4Q3preUZ5NG1ObU9jRFZGbkRZR3c1SUNq?=
 =?utf-8?B?K1RHMGw0dVArb0NyMlFxd1N0Mzd0S2JPa0lMMmt2cFVpeU44WUhlcEt3bzRn?=
 =?utf-8?B?TUZnRndYKzJvNEdXQ21USEsyL1diZTRvZTNGL3BkaDRIcGhtN000cFJTMlBv?=
 =?utf-8?B?bmI5dkFJcnJyUHoyN08wMERzVEt1MWw0ZmlJOW5zdWhxajFwN2dQQVltRERl?=
 =?utf-8?B?ZGZ3NDhGK2dteGJKbEV1V0wvWlNJQTdWWm9lRmFXQys2cUdHSXBOaHMya2FY?=
 =?utf-8?B?djdSWHdvSVdBR1RydFpidGNHNXdzc09OSEQrRk9PeGQ1ZGRRN3k2L3dDbS9u?=
 =?utf-8?B?ZlUxeUpVOVBRNm5PS25oeFE3WkFVVmtwSUVLY1pURHNvTlU5cjhzVG83a09j?=
 =?utf-8?B?TXlrZjNRZGRiRkxSK3MwQW1pK2d3NWFpYXZmQ0lkYjFTYzRkbHNDYmhsTXhk?=
 =?utf-8?B?a0d5d212M0ZDWjcyQmE4MVQwbDNEZytqdGtXR3VqditYMEROUm9pTGxMTlRP?=
 =?utf-8?B?enprR2NKWE1NaE1oRFJqeElSNUZRUklaV2JSVDFGRlhVMjd4OWNqaVY3NHE4?=
 =?utf-8?B?MXExanMzek1WWkI0d3R6ZG5RVVVzYVJCc1I5VlpkbHhEZTFadjZCSXExOFRx?=
 =?utf-8?B?eFN0K3hhWW9TMHdORmdxSktXUURJV2pUQ3F0UGt6OTZCdjA1L0xTeHMvTHZU?=
 =?utf-8?B?dkc4ZEY0UnZsMFpjdHJFVFZsQTVyZXlSU0RMV1ZTcDVDUStabzgyakJ3R1JM?=
 =?utf-8?B?dkdVSkhaZ1RoLzBjY1dnZmhqcnlVUWVZbko0dGNHR090RHhHQWp5OGhNL3JG?=
 =?utf-8?B?Y01MeXpNYVYxQk1zYTRFZVBNTXJtbW5lVmFtNzZ2c1I0MWdPMXlUUHUyV3pk?=
 =?utf-8?B?cHFYSC8yWlVsKytTZVNGTW1nQTludGtjak5wbkg0Sk8rL1pEMFlUSmdnOGFZ?=
 =?utf-8?B?V0x6NXIxQld2TUgraHc2RUdsQW44TUR0aUFGMTVtU052RWNkcmp2N0VBckpR?=
 =?utf-8?Q?jriSCblnxiOjBnz/itqo4mFXQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <279093FDC6056840955422CB99486BCF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f7986a-d207-4b6d-4d38-08dc210024bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 19:26:07.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woomf6HDcZtJCdl1VZJdKyh5ZtLg6ijTweCPNUixSSgbS8fsS5FNxppggF4O8Xc6tP+q/w3OVzJc9C82Y0V1VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9131

QW0gMTkuMDEuMjQgdW0gMTU6MzMgc2NocmllYiBSdXNzZWxsIEtpbmcgKE9yYWNsZSk6DQo+IE9u
IEZyaSwgSmFuIDE5LCAyMDI0IGF0IDAxOjQ2OjI2UE0gKzAwMDAsIEpvc3VhIE1heWVyIHdyb3Rl
Og0KPj4gQW0gMTkuMDEuMjQgdW0gMTM6MDcgc2NocmllYiBKb3N1YSBNYXllcjoNCj4+PiBBbSAx
OC4wMS4yNCB1bSAxNzowNyBzY2hyaWViIFJ1c3NlbGwgS2luZyAoT3JhY2xlKToNCj4+Pj4gT24g
VGh1LCBKYW4gMTgsIDIwMjQgYXQgMDQ6MDE6MTBQTSArMDEwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6
DQo+Pj4+PiBIdW1taW5nQm9hcmQgaGFzIHR3byBSVENzLCBmaXJzdCBpbnRlZ3JhdGVkIHdpdGhp
biBTb0MgdGhhdCBjYW4gYmUgdXNlZCB0bw0KPj4+Pj4gd2FrZSB1cCBmcm9tIHNsZWVwIC0gYW5k
IGEgc2Vjb25kIG9uIHRoZSBjYXJyaWVyIGJvYXJkIGluY2x1ZGluZyBiYWNrLXVwDQo+Pj4+PiBi
YXR0ZXJ5IHdoaWNoIGlzIGludGVuZGVkIGZvciBrZWVwaW5nIHRpbWUgZHVyaW5nIHBvd2VyLW9m
Zi4NCj4+Pj4+DQo+Pj4+PiBBZGQgYWxpYXNlcyBmb3IgYm90aCwgZW5zdXJpbmcgdGhhdCB0aGUg
YmF0dGVyeS1iYWNrZWQgY2xvY2sgaXMgcHJpbWFyeQ0KPj4+Pj4gcnRjIGFuZCB1c2VkIGJ5IGRl
ZmF1bHQgZHVyaW5nIGJvb3QgZm9yIHJlc3RvcmluZyBzeXN0ZW0gdGltZS4NCj4+Pj4gR2l2ZW4g
dGhhdCB0aGUgc252cyBSVEMgaXNuJ3QgYmF0dGVyeSBiYWNrZWQsIHNob3VsZCB3ZSBldmVuIGJl
IGVuYWJsaW5nDQo+Pj4+IHRoYXQgaW4gRFQ/DQo+Pj4gSW4gaW14NnFkbC5kdHNpIGl0IGlzIG5v
dCBkaXNhYmxlZC4NCj4+PiBBY2NvcmRpbmcgdG8gSm9uIGl0IGlzIHVzZWZ1bCBiZWNhdXNlIGl0
IGNhbiB3YWtlIHVwIHRoZSBzb2MgZnJvbSBzbGVlcCwNCj4+PiB3aGVyZWFzIHRoZSBleHRlcm5h
bCBydGMgY2FuJ3QuDQo+Pj4+IEFsc28sIGhhdmUgeW91IHNlZW4gYW55IGlzc3VlcyBzdWNoIGFz
Og0KPj4+Pg0KPj4+PiBbICAgIDAuOTMzMjQ5XSBydGMtcGNmODUyMyAwLTAwNjg6IGZhaWxlZCB0
byBzZXQgeHRhbCBsb2FkIGNhcGFjaXRhbmNlOiAtMTENCj4+Pj4gWyAgICAwLjkzMzUwNV0gcnRj
LXBjZjg1MjM6IHByb2JlIG9mIDAtMDA2OCBmYWlsZWQgd2l0aCBlcnJvciAtMTENCj4+Pj4NCj4+
Pj4gd2hpY2ggc2VlbXMgdG8gYmUgZXhoaWJpdGluZyBpdHNlbGYgb24gbXkgU29saWRTZW5zZSBi
b2FyZD8NCj4+PiBOb3Qgb24gbXkgSHVtbWluZ0JvYXJkIEdhdGUgUmV2LiAxLjQuLCBidXQgaW5k
ZWVkIG9uIG15IHNvbGlkc2Vuc2UNCj4+PiB1bml0IHRvbywgd2hpY2ggaXMgcHJvYmFibHkgc2Ft
ZSBhZ2UgYXMgeW91cnMuDQo+Pj4gT25seSB0ZXN0ZWTCoGlteDZkbC1odW1taW5nYm9hcmQyLWVt
bWMtc29tLXYxNS5kdGIsDQo+Pj4gYnV0IHNvbGlkc2Vuc2Ugb25lIHNob3VsZCBtYWtlIG5vIGRp
ZmZlcmVuY2UuDQo+PiBJIHdhcyByZWFkaW5nIGNvbnRyb2wgcmVnaXN0ZXJzIDEtMzoNCj4+IGRl
YmlhbkBzci1pbXg2On4kIHN1ZG8gaTJjZ2V0IC15IC1hIC1mIDAgMHg2OCAweDAwDQo+PiAweDAw
DQo+PiBkZWJpYW5Ac3ItaW14Njp+JCBzdWRvIGkyY2dldCAteSAtYSAtZiAwIDB4NjggMHgwMQ0K
Pj4gMHgwMA0KPj4gZGViaWFuQHNyLWlteDY6fiQgc3VkbyBpMmNnZXQgLXkgLWEgLWYgMCAweDY4
IDB4MDINCj4+IDB4MDQNCj4+DQo+PiBeXiBUaGlzIG1lYW5zIGxvdyB2b2x0YWdlIG9uIGJhY2sg
dXAgYmF0dGVyeQ0KPiBJbnRlcmVzdGluZyAtIGluIG15IGNhc2UsIHRoZSBzb2xpZHNlbnNlIGhh
cyBiZWVuIHBvd2VyZWQgb24gZm9yIG1vbnRocw0KPiAoaXQncyBteSBpbnRlcm5ldCByb3V0ZXIg
b24gdGhlIGJvYXQpLg0KPg0KPiBJJ3ZlIHJlYm9vdGVkIGl0IGFnYWluIHRvZGF5LCBhbmQgdGhp
cyB0aW1lIGl0IHNlZW1zIHRvIGhhdmUgYmVlbg0KPiBzdWNjZXNzZnVsLCBhbmQgaXMgdXNpbmcg
dGhlIHRpbWUgZnJvbSBpdC4NCj4NCj4+IEFmdGVyIGEgZmV3IHBvd2VyLWN5Y2xlcyB0aGF0IGVy
cm9yIHdlbnQgYXdheS4NCj4+IFdoeSBwY2Y4NTIzX2xvYWRfY2FwYWNpdGFuY2Ugd291bGQgZXZl
ciByZXR1cm4gRUFHQUlOIEkgZG9uJ3Qgc2VlLg0KPj4NCj4+IEluIGFueSBjYXNlIG5vdyB0aGF0
IHByb2JlIHN1Y2NlZWRlZCwgSSByZWFkIHRoZXNlIHZhbHVlczoNCj4+IDB4ODANCj4+IDB4MDAN
Cj4+IDB4MDQNCj4gRm9yIG1lLCBhZnRlciB0aGUgbGFzdCByZWJvb3QsIHRoZXkgY29udGFpbjoN
Cj4gMHg4MA0KPiAweDAwDQo+IDB4MDgNCj4NCj4+IExvbmcgc3Rvcnkgc2hvcnQgSSBkb24ndCB0
aGluayB0aGUgRUFHQUlOIGR1cmluZyBwcm9iZSBpcyByZWxhdGVkDQo+PiB0byBhZGRpbmcgYWxp
YXNlcy4NCj4+IEhPV0VWRVIgaW1vIHBjZjg1MjNfcHJvYmUgc2hvdWxkIHJldHVybiBhbiBlcnJv
ciB3aGVuDQo+PiBwY2Y4NTIzX2xvYWRfY2FwYWNpdGFuY2UgZmFpbHMuDQo+IEkgdGhpbmsgdGhl
IHJlYWwgcXVlc3Rpb24gaXMgd2hlcmUgaXMgdGhlIEVBR0FJTiBjb21pbmcgZnJvbSBhbmQNCj4g
d2h5Lg0KSSBoYXZlIHRyaWVkIHJlcHJvZHVjaW5nIHRoaXMgb24gNi43LjAgd2l0aCBpbXhfdjZf
djdfZGVmY29uZmlnOg0KSSB1c2UgZXhwZWN0IFsxXSB0byBjYXB0dXJlIGtlcm5lbCBydGMgbWVz
c2FnZXMgZHVyaW5nIGJvb3QsDQpleHBsaWNpdGx5IG92ZXJ3cml0ZSBsb2FkIGNhcGFjaXRhbmNl
IGJpdCB0byBlbnN1cmUNCnJlZ21hcF91cGRhdGVfYml0cyBpbiBwY2Y4NTIzX2xvYWRfY2FwYWNp
dGFuY2UgaGFzIHdvcmsNCnRvIGRvIGR1cmluZyBuZXh0IHByb2JlLCBhbmQgZmluYWxseSB0cmln
Z2VyIHNvZnR3YXJlIHJlYm9vdC4NCg0KT24gSHVtbWluZ0JvYXJkLTIgScKgIGhhdmUgbm90IHNl
ZW4gdGhlIGlzc3VlIGR1cmluZyA4MA0KcmVib290IGN5Y2xlcywgYW5kIG9uIHNvbGlkc2Vuc2Ug
bm90IHNlZW4gZHVyaW5nIDI1IGN5Y2xlcy4NCg0KTWF5YmUgaXQgbmVlZHMgYW4gYWxtb3N0LWFs
bC1tb2Rjb25maWcga2VybmVsPw0KT3IgbWF5YmUgaXQgb25seSBoYXBwZW5zIHdoZW4gdGhlIHJ0
YyBoYXMgbG9zdCB0aW1lPw0KUGVyaGFwcyBJIGNhbiB0cnkgZGlzYXNzZW1ibGluZyB0aGUgYmFj
a3VwIGJhdHRlcnkgLi4uIC4NCg0KWzFdDQojIS91c3IvYmluL2V4cGVjdCAtZg0KDQpzZXQgdHR5
IFtsaW5kZXggJGFyZ3YgMF0NCnNldCBsb2dmaWxlIFtsaW5kZXggJGFyZ3YgMV0NCnNldCBjb3Vu
dCAwDQoNCiMgbG9nIGZ1bGwgb3V0cHV0IHRvIGZpbGUsIGJ1dCBvbmx5IHN0YXR1cyBtZXNzYWdl
cyB0byBzdGRvdXQNCmlmIHskbG9nZmlsZSAhPSAiIn0gew0KwqDCoCDCoGxvZ19maWxlIC1hICRs
b2dmaWxlDQrCoMKgIMKgbG9nX3VzZXIgMA0KfQ0KDQojZXhlYyBzdHR5IC1GICR0dHkgMTE1MjAw
IHJhdyAtY2xvY2FsIC1lY2hvIC1pc3RyaXAgLWh1cA0KI3NwYXduIC1vcGVuIFtvcGVuICR0dHkg
dytdDQpzcGF3biB0aW8gJHR0eQ0KDQp3aGlsZSB7dHJ1ZX0gew0KwqDCoCDCoGV4cGVjdCB7DQrC
oMKgIMKgwqDCoMKgIC1yZSAiRGViaWFuIEdOVS9MaW51eCAxMSBzci1pbXg2IHR0eW14YzAiIHsN
CsKgwqAgwqDCoMKgwqAgwqDCoMKgIHNldCBjb3VudCBbZXhwciAkY291bnQgKyAxXQ0KwqDCoCDC
oMKgwqDCoCDCoMKgwqAgc2V0IHRpbWUgW2Nsb2NrIHNlY29uZHNdDQrCoMKgIMKgwqDCoMKgIMKg
wqDCoCBzZXQgdGltZXN0ciBbY2xvY2sgZm9ybWF0ICR0aW1lIC1mb3JtYXQgIiVEICVUIl0NCsKg
wqAgwqDCoMKgwqAgwqDCoMKgIHNlbmRfdXNlciAiXFskdGltZXN0clxdIFN1Y2Nlc3NmdWwgYm9v
dHMgdG8gTGludXg6ICRjb3VudFxuIg0KwqDCoCDCoMKgwqDCoCB9DQrCoMKgIMKgwqDCoMKgIC1y
ZSAic3ItaW14NiBsb2dpbjoiIHsNCsKgwqAgwqDCoMKgwqAgwqDCoMKgIHNlbmQgImRlYmlhblxu
Ig0KwqDCoCDCoMKgwqDCoCDCoMKgwqAgZXhwZWN0IC1yZSAiUGFzc3dvcmQ6Ig0KwqDCoCDCoMKg
wqDCoCDCoMKgwqAgc2VuZCAiZGViaWFuXG4iDQrCoMKgIMKgwqDCoMKgIMKgwqDCoCBleHBlY3Qg
LXJlIHtkZWJpYW5Ac3ItaW14Njp+JH0NCsKgwqAgwqDCoMKgwqAgwqDCoMKgIHNlbmQgInN1ZG8g
aTJjc2V0IC1mIC15IDAgMHg2OCAweDAwIDB4MDA7IHN1ZG8gcmVib290XG4iDQrCoMKgIMKgwqDC
oMKgIH0NCsKgwqAgwqDCoMKgwqAgLXJlICJwYXNzd29yZCBmb3IgZGViaWFuOiIgew0KwqDCoCDC
oMKgwqDCoCDCoMKgwqAgc2VuZCAiZGViaWFuXG4iDQrCoMKgIMKgwqDCoMKgIH0NCsKgwqAgwqDC
oMKgwqAgLXJlIHtcXSAocnRjLXBjZjg1MjMuKilcbn0gew0KwqDCoCDCoMKgwqDCoCDCoMKgwqAg
c2V0IG1hdGNoZWQgJGV4cGVjdF9vdXQoMSxzdHJpbmcpDQrCoMKgIMKgwqDCoMKgIMKgwqDCoCBz
ZXQgdGltZSBbY2xvY2sgc2Vjb25kc10NCsKgwqAgwqDCoMKgwqAgwqDCoMKgIHNldCB0aW1lc3Ry
IFtjbG9jayBmb3JtYXQgJHRpbWUgLWZvcm1hdCAiJUQgJVQiXQ0KwqDCoCDCoMKgwqDCoCDCoMKg
wqAgc2VuZF91c2VyICJcWyR0aW1lc3RyXF0gJG1hdGNoZWRcbiINCsKgwqAgwqDCoMKgwqAgfQ0K
wqDCoCDCoH0NCn0NCg==

