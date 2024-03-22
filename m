Return-Path: <linux-kernel+bounces-111924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5AC8872C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34EEDB230B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2D63115;
	Fri, 22 Mar 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="jbNW+etb"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2122.outbound.protection.outlook.com [40.107.6.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA705A4EF;
	Fri, 22 Mar 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131283; cv=fail; b=MB3KGg5OYQDqZe2EhN8xmw6+DZIfuNgeAGWMUQML52E3YHQUNwCJuInDEsW+BxuWqEfGxif6UKi4HrUqN7t5LEe8FrgvWIIOu7QMpOdC5GJdCIw73khns50LwcKqlVkJjjSb1c40itjs9yhbJf7NoP0OK5lGhRB0juX0DjVX2bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131283; c=relaxed/simple;
	bh=N07cRZshQNkvC8hIs4JIoa81by/J6eF7yICB5n6Oupw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgCU7ykQ5+e/1jvPUcE+s+K28IC7wxIlFOfUMXzvud1ltWTOPHvtBSJCZ+zVUuyBh8HPKtg8ffrFlo+s+gW4dvahcNcSu24bO0Nnu/GlPeTgg8EhEFdlnUjYp8Jxr+bTiDWrdFBRLcFbmZSV1z47J6qPExyZdrWyMcg7O2o3rUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=jbNW+etb; arc=fail smtp.client-ip=40.107.6.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPT3ssMrJLkwdlD4EqESp/UDuxVfkfBPefijRfVmwKd9PYp+4BTxpcbPCgV/kqOtM0FubGS+mAMmn6o7Ai1qbuPTRtforVaDBUUvaujYMEFgvxKuoRG4HRiE+2JAVQwxeLCtWvMMC2oCu9O7qqfBPKyveGzvPSaybGihJZQTSX5wbrqBnEqbSJHYG9EXv03TM3mYLQmXdkaN/nEqwCzUWTacCN6GnRTv1DfIR6xbkrG7N2mjEIgjuVtd4VLE3dYO8PQTTLQLqcB3i6mb6jb4QKxezod8gEzwtjP2GHLHa2ljCBZSlUlfHKpDuy9gykW0iLaRYogNN8S35/tZSh9qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N07cRZshQNkvC8hIs4JIoa81by/J6eF7yICB5n6Oupw=;
 b=cO9dqulcz/6BwNyvw0FLedysxB1KT2oqj1p0cbGpGM45tyKs0Gkqy8saKXHQnueKzzSp/r/HaCG/9M92tiS7Su6shkwazpobgVHeKSQ78obfdbduCvkmJLd4ayfIRdM8fnxJO3dWfUdgsTTPcIdbtKwU+2a4JLIjFyQj7/feb7gMQ71awkfZT88RovtKrjO7fzz0UBBzMdrmXgzC7q3Us5Uk+DyTzIcMpkmULpUSLJWa1sBZZRbO79gSjp2epHP2jBCiBVfZtPUaCDgdeGx4Cm2US6LeBdXLa6Z4FGHcHr8A2OXJaYYKdBROtC02+JQlfdPxU07C8vjhiGcGGdTUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N07cRZshQNkvC8hIs4JIoa81by/J6eF7yICB5n6Oupw=;
 b=jbNW+etb7stz8pZPX8z90EFjZcI4/E8uElUpBB0LEFLB/0CyMF6uhECuK0YYQDreGxvfkie5iRT9zvXrnQLIcTxDE6EcQ6EPv95YDnaTRbShRDmhYUu6fvPMShEzHouZAWKpJlUNEbqbjXd6msVweFGNYd1Z4SFrpeKwA9TG9r4=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM0PR04MB6978.eurprd04.prod.outlook.com (2603:10a6:208:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 18:14:38 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 18:14:38 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Thread-Topic: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Thread-Index: AQHae9lamF1Na8/mpEGgdJkfFpR9o7FCvoaAgADHmICAADb7AIAAKS8AgAArnoA=
Date: Fri, 22 Mar 2024 18:14:38 +0000
Message-ID: <8ad64d2e-2be9-4d59-907b-669fdedc3695@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
 <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
 <0d1afbcc-948e-4aff-8296-42f7166d318d@solid-run.com>
 <4fff2165-c3cc-41d8-b541-6e69ce4d98ac@lunn.ch>
 <748753a6-9fde-4d4f-8fee-5b93dbb532f0@solid-run.com>
In-Reply-To: <748753a6-9fde-4d4f-8fee-5b93dbb532f0@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM0PR04MB6978:EE_
x-ms-office365-filtering-correlation-id: 0894fef7-866e-421e-427a-08dc4a9befd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R5PH3FrfkQgnNPSBWLSUssZzx1u3QfeXU6esa3+4k7XWylZgYsOQP7rS7jpdyfKe7o4RC40QEB+V2ew8ZBvbBs8f8i7z96VqCOFIIIvKoa/imZTxPmoshCZbZOQJr2PXubfZ00ekx8d7l0vd+bhQmMhOMdHW9Q+Ui97srQVe4Iu0JOUz2EqyEoBQR5yTG6+oKie1jcaByQAbfdtT7jyo4QwkQbS5+4sqtMeJzpnsYwAYElj/9k3fHAXkqZmHq5f+GZlRDVs8dd7aJotqLX66Qxr3AtxjjmdcIbwxOmF3gTUfcs8d0JcPBxl/5qa+Cb0LZPmukDWJ+vh0vwZzlefp+4qDOcx4PpWQ94Z4J+/RGnMum/ZNwCR4o4N79p8NUIODe/rEM3g84E8kzuXv8lTKfVs34erTVyjq8EV8zitb3PX0hqEyF49Ne0tGq/6gFMRcT39nehUdj3oTkmSbRGUEpUjgUpx4J5Ie7JeBgvdOU5A/COScadNQZmZu8pgSJXikgZzWzmA+261v9KTvziHgxhjaUg8KqXZbvE2sBboWNJLIznbCBibPk7eZ+6oHkRJXSwlT25A9dfhkbSCWqCAp6MUJ3fs7rMCOM1Vs/162oQXD1sDyDCtM6mUFBoH0AAJrmPb2EkVYQGjFNo0LkAuy+Q4kDoCL7TymTQU3w22muMso2Q2lB/Mpj8aQ3oJrO3qt3VFhmbWldswFBCNINkSBzw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFRSZHUrVnRPMTZ3V09RRGQ2OGJTSXVhYzdpZDB0SXdBNERxNndQSDBuQ0Zv?=
 =?utf-8?B?OVdaRlo0Z2JaSE1aQlU2S0toVmJRNFMrZGJxNDlkaXcwcE9MMjk4YSsvbE8y?=
 =?utf-8?B?N2dibVhlcExuWmdwTXFvdkVINDlQdTh4UzdKNkprNUxnT1BhamhwSVJPR1dx?=
 =?utf-8?B?YWQzSXJKM3k5SnNrSVFtcko4Tjg1M1VBZm5ITnU3RnZPR0xPRkRWWS85MzJm?=
 =?utf-8?B?am9MdEdvVlpTUkFNaDNhaG9oSGlUR0RrZlA2S2hsUEdyOXExWnRRYjlCbmZv?=
 =?utf-8?B?MWhCaTM3Wlk3OU1EL0E0T1BNOTRZYnhuMGpFK1Niem5ZdHEzZ24vczh4aGdm?=
 =?utf-8?B?V1NiemVLS1FzcXNML3ZqbkVUUEFaU3dwODUxQWc4T1ZnVU1rQmNlUlBpaGJ1?=
 =?utf-8?B?b2lXbEFBL25tdTBScnc0ZXFSUFpIOVhUWTA2bTdFSURpbnIxUkxOdkpWMWZ4?=
 =?utf-8?B?d250cU1zamh6YmFsNkVlZVJOaFhVRW9OUE1MZUhKQkdvTUFWcXdzR0RudHdV?=
 =?utf-8?B?a1Z6K3dvcjk0UnN3MnV1YVA1UktWVzRHTHNMVnd0cjJISzd6WXBLQmoxWGpR?=
 =?utf-8?B?bDZsYzdZU2RyUnpLNGRSVW4yanZVTURhalhqU01YZmZ0akZKSlZscVIydWg2?=
 =?utf-8?B?OWZ2MjRyeGFLbnY5amx4UU44RG1YNEh2aFZZbmRyUEdHRk9PcStNY1ZGRmcr?=
 =?utf-8?B?Mk0zb3BCL1JRK2dhbjNzNS9DcEwxVWlCekZ2TUpDbTR5aDhGa2pORlVWbkR1?=
 =?utf-8?B?TGd4cXNPQnp1Y09JeHNhRXhqTlBucSs2RjVONWVYdncvYklrQUgvdHE3SXlC?=
 =?utf-8?B?TDJUMjhLaThpYWNBeDRQU1hxbEdzQzNQVUREZGp1aDVPWGV2VFlqSTVRc3gx?=
 =?utf-8?B?Zml1eEl6amJkWUhMV1VmbTNJYzJ5QkRvMk5KeWVBYTNwNVR4d3Ixb2FzT2pr?=
 =?utf-8?B?T3hLT05XVnNTbFIzWjk4RElSUG5JbTBxSGd6bFRxa3dNZXYzYi9VbG1Oeml5?=
 =?utf-8?B?U1lablFsTkhKbHJrVGk3VWRzSmNoSmpVbWpxTjI0eGtodWdnQXE2Vit5ZUg0?=
 =?utf-8?B?dHlIWmFQbWpsa01uKzJlSUEzemxXY1FjNGZ5Yk5kWnpVUHZ4cVVqblJxS3gr?=
 =?utf-8?B?R2tlaFNBVkhoTS9jZllsbXlNNkRMUlFSaVJPSXNvVndMZVg2dFh3T1ZwdHU2?=
 =?utf-8?B?UkRTYlhVU04wTW5QcnJsbzIrekZ1b2dQaHhuaDVOQW84UDdSVGRwRTFra2Jq?=
 =?utf-8?B?WDNldk0vdWF2UkdYMGVrS0RFampRcy91UTk2cTRCeW1UM20zbkNBczZnVHVz?=
 =?utf-8?B?cVFhUDBHaE03enhWeDRXT2RFTG5lV2xOemJ4d2o4cS9Tek9GcTlsRys0TmxB?=
 =?utf-8?B?bFVXRG9YaGhPREplSU1uRzN0NlI0SXZDRURlSlVPSEI3aXlNK0FxZDBwZmdT?=
 =?utf-8?B?QWh0M1k1cDVsN21lWHJNeHdCd1dQRDdObWNNM0NZWk4vaStCSUpPaTJjNmxW?=
 =?utf-8?B?NGZPZndtU0NmMGprbG1TbGlGeGRPR0lVbHZCazRMRW96OTFIRW9tN2pvZkZV?=
 =?utf-8?B?TFNGS21KbG42ZDdnT3lZZWVpQVd3dENmdzlBT2VXZnJUN2krR1JrMkpwT2xG?=
 =?utf-8?B?TkZMV3F2RWZYZTBTcHd6Q3hnMVh0TXp4TGVLUHpPeTZjMTBNWHJmUTNMY1kr?=
 =?utf-8?B?UDVhWkc5RWRjZzF5K2k1ZGVRenBOQXFiZ01OWmlRTEQ4M2tsSjdueHdSZkE5?=
 =?utf-8?B?RWZGdmUxZjZ1b01GL2hEWSttNlh5OVZ1c3FhVEQreFVrcyttSk1xbVkrZndx?=
 =?utf-8?B?aGo3ZXNrOVJDRDFDbXA1Yk02YXRYOUZTaTVycVdMeTUwTzJiWnlOZTh3cjRi?=
 =?utf-8?B?WEVRaFh5bGFPTkRBejBRRDJiSEpQM0RBbUx0NnVGMVBXVkhyakx4Y290Ly85?=
 =?utf-8?B?ekRTMzZzbkdQZWFPZWJnejFYbUszTndYNTdwVGFOQy9SeGNoQW82ZVZFbVBy?=
 =?utf-8?B?UENyYUYzOGgwU3ozUlJSZllmckNuc2pyTy93S1RDV2F4WHN2MHBGNExJQlhy?=
 =?utf-8?B?Y0sxQ0Q0K1FEemY0OGR5WlE5a0VLd1NkblFJeWlQNFBhc0R1VkJuWHhpWFNG?=
 =?utf-8?Q?phBA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A31B78CF46D714B8B16514709262A96@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0894fef7-866e-421e-427a-08dc4a9befd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 18:14:38.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBDsk6VdArIu0K0H3aXhfa4eNN4oX8werRrDXGnyVP9db/SdqYLasFry8i/sChHPT54elUKQB1w9RLvy1GCRgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6978

QW0gMjIuMDMuMjQgdW0gMTY6Mzggc2NocmllYiBKb3N1YSBNYXllcjoNCj4gRm9yIHRoZSBkaXNj
cmV0ZSBQSFlzLCB0aGUgZ2VuZXJpYyBMRUQgY29kZSBjYW4gbWFrZSB1c2Ugb2YgdGhlDQo+IGhh
cmR3YXJlIG9mZmxvYWQgc3VwcG9ydCB0byByZWFkIGJhY2sgdGhlIGhhcmR3YXJlIGNvbmZpZ3Vy
YXRpb24gYW5kDQo+IGNvbmZpZ3VyZSBpdHNlbGYgdG8gbWF0Y2guIFRoZSBzd2l0Y2ggY29kZSBp
cyBtaXNzaW5nIGhhcmR3YXJlIG9mZmxvYWQNCj4gYXQgdGhlIG1vbWVudC4gU28gaXQgY2Fubm90
IHJlYWQgYmFjayB0aGUgY3VycmVudA0KPiBjb25maWd1cmF0aW9uLiBIb3dldmVyLCBpdCBpcyBz
aW1wbGUgY29kZSB0byBhZGQsIGFuZCB0aGUgZGlzY3JldGUNCj4gY29kZSBpcyBhIGdvb2QgZXhh
bXBsZSB0byBmb2xsb3cuDQpJIGhhdmUgcHJvdG90eXBlZCB0aGlzIG9uIHRvcCBvZiB5b3VyIHBh
dGNoLXNldCwgc3VwcG9ydGluZyBvZmZsb2FkDQpmb3IgYSBzaW5nbGUgbW9kZS4NCkl0IHdvcmtz
IGFzIGV4cGxhaW5lZCBieSB5b3UgLSBmaXJzdCBhZnRlciBib290LXVwIHRoZSBMRURzDQphcmUg
ZXhlY3V0aW5nIHRoZWlyIGRlZmF1bHQgZnVuY3Rpb24gYXV0b25vbW91c2x5Lg0KDQpXaGVuIEkg
c2V0IHRyaWdnZXIgbmV0ZGV2LCBJIGNhbiBzZWUgb2ZmbG9hZGVkIHByb3BlcnR5IGlzIDEsDQph
bmQgd2hlbiBJIGVuYWJsZSBleHRyYSBiaXRzIG9mZmxvYWQgdHVybnMgb2ZmLg0KDQoNCkZvciBD
bGVhcmZvZyBCYXNlIEkgaGF2ZSBhZGRlZCB0aGUgcmVxdWVzdGVkIExFRCBkZXNjcmlwdGlvbnMs
DQppdCBzaG91bGQgYmUgcmVhZHkgbm93Lg0KDQpUaGUgUHJvIHZlcnNpb24gSSBjb3VsZA0KMSkg
c3VibWl0IG5ldyB2ZXJzaW9uIHdpdGggb25seSBwaHkgbGVkcw0KMikgd2FpdCAobm90IHByZWZl
cnJlZCkNCjMpIHN1Ym1pdCBuZXcgdmVyc2lvbiB3aXRoIGFuIHNlcGFyYXRlIHBhdGNoIGFkZGlu
ZyBzd2l0Y2ggbGVkcw0KKGNhbiBob2xkIG9mIGFjayBvbiBpdCB0aWxsIHRoZSBmYWl0IG9mIHlv
dXIgcGF0Y2gtc2V0IGJlY29tZXMgY2xlYXIpDQoNCg==

