Return-Path: <linux-kernel+bounces-61226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0392850F37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EA71C2166D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C006101CA;
	Mon, 12 Feb 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="hDQLAufB"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2041.outbound.protection.outlook.com [40.107.114.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33CF9E4;
	Mon, 12 Feb 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728386; cv=fail; b=W33kooPafVvJmk2vaWZ0KGAmU4YivQ4Okvt//hd0+GvGWXZMtzUu+59wt79K4F5DHq5T4aYjOEA7XkSWAW7E0y9bg3pYZYoumM//Sqwev2A8J4QWnkkkaXh1v/RUNuJYxNpMShe9B2AsgKWk6+Phye9T8HCrk2KLEsQ53Y5HfZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728386; c=relaxed/simple;
	bh=BneneExqYj5zRde8QMX20E5RkVo6edeDUWZIHUj9iyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UGb2IqGQm+HTpSf7LToP1fYjtgQu5KBuo0J+xjrNO1INjT0tHunPKHiq2HCXA3Ke73CiZWR2FlvlXJEbjUBzDZ9ZVq0m6HVXSWLJGcIlXoB0nJNH2EjCTOf4oGQNLGa6FWmJCRtLeiJjMBYfKAfS6acguWSoP24dQ9ErcphdFag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=hDQLAufB; arc=fail smtp.client-ip=40.107.114.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMSy0TAItq6k6dkpXO9FFDl8QKCOBSS08MVDjnj11OktSBXZFor2tTdeYRcbtbrlD/OnxaVwXfhvFmzDXZEbOColtdfqxBnKUKeF3T7sk+kusxgsFX8vujCvD8u+d92+Sv2Oj7yXg2ryIGOGwAhZv9k9vuv3NbstX109FYHkycygVxaDZLIRw12PyklCiDDeZYeeJOfYhIDoWt1UQ8kb23eWPfkDQMoFjNvVL0l1YHW4LP0p5t3Jz+ylzBoQ5tpwCE5JSU4qhNsBRxdWJkc74nR0E4y/Hu6sR8yI8SWYhXfLgkRNzpSCcCPbwC45Kkvt+rBcC1gkZytvZ7AcX3JtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BneneExqYj5zRde8QMX20E5RkVo6edeDUWZIHUj9iyY=;
 b=L0ugGN752DfbI7KY9hSvTsB6VnpMfeWDfM2XeUzt9U/jKzon36ffut7Lw2P+syIgSVWuhU/x42ef+G301qmbRjCOiXAVGIjOO6YO6AN/2TmKDdzBI5sbDvZ6kX4H/O/YwgW8yV6Fne+iHZCHwmxDiHVMYOw5ARG2IKq5Zf0nJa2H7KlIRpveN8V06A4ilZ8aW8lI0yzHU6aVhhJqmIN9nVnV5GFr7ywgCj+b94zlLfhchZuuTQ1GmDUMsVBOYSIQJUJGUSrUPj07shoRPGXIRXB2C15dX51mWpjVKT1LQRqLFN7B/QrDqVteh3M10q/IJjyTGjBh6U92CApFRQ5S+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BneneExqYj5zRde8QMX20E5RkVo6edeDUWZIHUj9iyY=;
 b=hDQLAufBbNbO4l9f5kSICYUHGFfG85bIYnpP999SGqHGCG5FA/jWZ4GZt6X9AVTEDaGS0piLnrboslLv78NFY3bFlU6rRBWe0n8DILmgbAalU7ePEpG4AaBzUIr9wErD2KkfmF2wH37oPsBpzHO8LG8mXH0XZuck8dK3JtPAey8=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB9929.jpnprd01.prod.outlook.com
 (2603:1096:604:1ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Mon, 12 Feb
 2024 08:59:38 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 08:59:38 +0000
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
 AQHaWox93XkHXchpTkaSnTQ6Ok/3vrEAgGfQgAAWUICAAAlS4IAACXEAgAAoXKCABYymgIAADp0g
Date: Mon, 12 Feb 2024 08:59:38 +0000
Message-ID:
 <TYCPR01MB11269A240E2EDD460D0B97B9786482@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269DEA9261CA594EECC949686442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <67ad8052-1406-4dcb-9e35-5c42ada28797@tuxon.dev>
 <TYCPR01MB112698AB206332D13105C064186442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <e170f5f8-f95c-4553-b088-1072345fae53@tuxon.dev>
 <TYCPR01MB11269015C92AA327DC6BFA76586442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <786f90f4-ba47-46cb-b5e0-e3c42b1b741a@tuxon.dev>
In-Reply-To: <786f90f4-ba47-46cb-b5e0-e3c42b1b741a@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB9929:EE_
x-ms-office365-filtering-correlation-id: b82cdd68-bbb7-4b16-d806-08dc2ba8f188
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 o8nrYZFi6WZatuoK289cp+uRKK/mNUxDjd4dpyhzxxEK/5hwVbrRpkWVb49Uhf/+SsOeWKlXx2HHN4bM4veHrxTlZUoqRnrh6pZgmYACHwe3kZjCnPv3UHW4uW4YaQdMnilTz9tmkWbTMx7UJR6Wv5Q/wgXLcjlr+a7YUWffTKAO6xIq5TsIQ+eMqqp7mLvM5LVKa6oJ95eR2LNwDvbcYKx7sk8sFpXYp5NaQgu5FCLL02SWMHtH1vAHxuwRr9K24ZGNUiwbmKkw4ibUW6vQGMSs8xCqdRIzUjfZr67J+1z7pQIOruWNQEfbUXfvExGCsvaQAXiDdV55dOWZocFPJyL5jNiWozr2DLpGNdDer8NC/CBbHWyZUl819quDguRf0VM1tcuZgkyaqJmClylQNJeDkSi6IbPTCUcam5SlCx5tuEJrkRmiKtWASF+vUhZ/Dwndb4AVfKJoNdsgJ++k3E1SUtRl5SnJaTUXMOvWFWY43ou2L9TFBkmOszKddRvqYssgD2EHP4eTlf2bosAbEQv1cALJ3Pmc04s1F0naeKS5fhiQwpm+uoeGJ4n5KQvp05AaBlb/NjQphPwNmlE7DpEhwT7szJuuQ4QjctAaUXqVkeHlXw4+ps51H3o3N8ahOFmpy8fZMhEY5AHbEvhI4Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(71200400001)(26005)(41300700001)(55016003)(2906002)(4326008)(5660300002)(66476007)(64756008)(66446008)(76116006)(52536014)(8676002)(7416002)(8936002)(66556008)(66946007)(478600001)(110136005)(38070700009)(83380400001)(53546011)(316002)(9686003)(7696005)(55236004)(6506007)(54906003)(107886003)(86362001)(122000001)(38100700002)(33656002)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjlFQ3ROVXdIUzIxSU5zek5obWlHWHNuc0xHS1RmQmpSWW9rSXZITzVVUGtM?=
 =?utf-8?B?SWxIQ2IvU3hPQXRJS2FoZ2cwL2puMFJ1Q1p2NkYycnRkQ29hek1uR09HTGhN?=
 =?utf-8?B?TUsyKzA2aDVBQUZ0Zmo1a1cxbmtrQUtpaHJhTHlFSS8ydW1nTkg0a1l5cTc2?=
 =?utf-8?B?WmJEVVpSa1hRSlV1bDIxbXRqME93T3lFSDhuckswb1ZrYXJkeEZRdm01aFdp?=
 =?utf-8?B?aHZmUTVlL3o0Z1JJSVJWN2ZaY2hBNXJBSTY0NzN3QmMrWkpSQmlvNkJTT1VD?=
 =?utf-8?B?aHJ0NGsrNkd0VWdtbUJXSjVoWGZVYkxiRTkvMDdpb0hrUGhVcFJjUkxRcThK?=
 =?utf-8?B?NGp5aU1lbklScWp0RWRGZ3ZlMXdyNlpBUEtJeVkrTnFNblFKRS8yVVNWNWlJ?=
 =?utf-8?B?MnV3ZTY0OUZoQWN3Z0c2dGVENWM0eUNiUUNnaFRWSmNMTmxmSDJlMWQ5RGRk?=
 =?utf-8?B?eUV2aVVEbjM5MUtIM1F2NGU5VG1rQTRoYWlSWDhXSVUyb2cvNUNjNTNrcDVq?=
 =?utf-8?B?UTdiRVF3S0JoWmZjMnVnMDM2SFdTTHI1YmJSbkQyL1lKUVBzOGZ5aVRxQzBW?=
 =?utf-8?B?YTE5WlhtMHg3ZHh2VlpYd3oyK3FiYjFnVjROUEptWEJFU0Y2VDNUWnlYRk1l?=
 =?utf-8?B?Nk9rWXRsQWZac1BYMFNHV3FMM2g1SVRTMGJFOFREQ3dRMmJpM3RYbzE0enI1?=
 =?utf-8?B?MnJ3R2toL2xMNTB6Ti95cXVIek9xSWF0L2cxSUtHSFE4TmNramsxOEJleXdI?=
 =?utf-8?B?cXEvZjh4S1ZuSTVXenEwNmRtcWpKdTdCYVNtQ2FmWjFjMWtadDlhOURlUTdD?=
 =?utf-8?B?U3JwcjZuOFo4TFhUSTF2MjZmSGxoczNBNnZrTFlHeTBLWCtLUTVQemlNQkh4?=
 =?utf-8?B?STN5NWhmdDYwcEx4TWRKOGNUdWZhQXN5TktnMWZuT1VKZndrNVV2YTdMWFYr?=
 =?utf-8?B?cG1qSEZiTU5VQXEwVHZJb2s1M1BUNXY3a053Z2NjN0swaEVrL1Y4Q3RrdmRh?=
 =?utf-8?B?NjV4eDZKbXg5V0lzaDV2RTNiQUgzeUIrSXNUS2h3eW1Xd3gwenZSMytCRVJE?=
 =?utf-8?B?N3lCVWxUNG5mc24vdWJvNDlMd1U3dTdydzUydmdUWjJqdFFaWkp3d3lIREpr?=
 =?utf-8?B?RjBFaGFJNmp4ZzJLU1cxR1pkbExkd1UvWFRMdGtUWXlIQmFvNUJTeDZwb09P?=
 =?utf-8?B?aktmY29QejVKcDl6Z3lZb1kvK3hybHB4ZzlxL1BLTGlvRS9VT29Qd2J0L084?=
 =?utf-8?B?SUh3TmFKaGF3dlVYS0pNTVRvdkZzVE5ab0hjWlZhUnc4MW8yZFcwRm52YkE0?=
 =?utf-8?B?Lzd2K3BqUE9QQjNSY2lyL09RWmszSmVUd2o0a2dyNFpLMW5uanUzb0NlOVBi?=
 =?utf-8?B?eEh0cDM0MEZkZW9hOGhsSmxheC9GTnFjK2NPOU1mTWpOQ3lucC9uRzNnTnpz?=
 =?utf-8?B?KzE3UWtQUjBQdnZrdXhWcWl0akcrZGo1dXBxc29INEV2TjZBaWtnTDJ3YzJ3?=
 =?utf-8?B?QjhzbDRjTTVObmxXOXhmNkhMV0orV05qZURFSHhpRjBFdlBYbFdaZ0pHSjRO?=
 =?utf-8?B?elZVTmZ4eEJVM2hHM1Y2ejBhdzFxQmRLRHNoanBYbHV2eENvNzVRdUxPMFkw?=
 =?utf-8?B?U3p0K2Jud1BJbVRzRlljUFc4UnhVcDBUWjJIUmhoMVBzZExMMlFNT1hHTGht?=
 =?utf-8?B?WEwvd05jLzdsdFBiNlpSUHZvMlpOWnNRZmdNWVV0czJySDhtK3YwK0prQWdq?=
 =?utf-8?B?dm5hbDlaa1dwYkRjSFFjRHZTUFZOOHZJbzFmam96SmtjMktta2QzZ0NrUFVm?=
 =?utf-8?B?QU5VT2VWVThVRk0rUGZlcHlibXdFYUJpRVU3SSs2RW0rK2NoSHBXOGZ2QWhx?=
 =?utf-8?B?K1MwR0R0Y2pMT1Uva01IQW1DNjBveThSMFAzZGt5eXlGeDh4bVZtUXBVZW4v?=
 =?utf-8?B?U3JaVk5LbzlkRTNRTUdrRUFZaS9tNnFoS1FVa2dyWllFTEhRckJjUGVEcCtH?=
 =?utf-8?B?ajJDYjVkcmZzeUFiUVB5Y2h3b2tqQVQ4NDhpK3JQYUtaOTIzRkhCUjJvT3RV?=
 =?utf-8?B?MmpIU1FERUJHanVucW5YcWxVdG85NjN0ZnhVcnplSTY4Rm9KeC9TRW1NZkJi?=
 =?utf-8?B?OE10RUp2ejNLSHM2QmhoSE9Ram1uSno4bUNpQUFTeklxRjk3QjhwaERacDdF?=
 =?utf-8?B?Snc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b82cdd68-bbb7-4b16-d806-08dc2ba8f188
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 08:59:38.6164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOzQMo8tjPt8+jJzDc54DpvFj5VU7OokOwSaKr/sPgYOk/Iq+iLu2RZ4R4vKyvTLN4B1uRwY1L1I/ech3ucZiAJihC28cBgHvPLL4spIW2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9929

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBNb25kYXksIEZl
YnJ1YXJ5IDEyLCAyMDI0IDg6MDIgQU0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMS8xN10gZHQt
YmluZGluZ3M6IGNsb2NrOiByOWEwN2cwNDMtY3BnOiBBZGQgcG93ZXINCj4gZG9tYWluIElEcw0K
PiANCj4gSGksIEJpanUsDQo+IA0KPiBPbiAwOC4wMi4yMDI0IDIxOjIwLCBCaWp1IERhcyB3cm90
ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206
IGNsYXVkaXUgYmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IFRo
dXJzZGF5LCBGZWJydWFyeSA4LCAyMDI0IDQ6NTMgUE0NCj4gPj4gVG86IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOw0KPiA+PiBt
dHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3Jn
Ow0KPiA+PiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5l
bC5vcmc7DQo+ID4+IG1hZ251cy5kYW1tQGdtYWlsLmNvbTsgcGF1bC53YWxtc2xleUBzaWZpdmUu
Y29tOyBwYWxtZXJAZGFiYmVsdC5jb207DQo+ID4+IGFvdUBlZWNzLmJlcmtlbGV5LmVkdQ0KPiA+
PiBDYzogbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5r
ZXJuZWwub3JnOw0KPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4+IHJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7
IENsYXVkaXUgQmV6bmVhDQo+ID4+IDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4N
Cj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMS8xN10gZHQtYmluZGluZ3M6IGNsb2NrOiByOWEw
N2cwNDMtY3BnOiBBZGQNCj4gPj4gcG93ZXIgZG9tYWluIElEcw0KPiA+Pg0KPiA+Pg0KPiA+Pg0K
PiA+PiBPbiAwOC4wMi4yMDI0IDE4OjI4LCBCaWp1IERhcyB3cm90ZToNCj4gPj4+DQo+ID4+Pg0K
PiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogY2xhdWRpdSBi
ZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4+PiBTZW50OiBUaHVyc2RheSwg
RmVicnVhcnkgOCwgMjAyNCAzOjQ2IFBNDQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMS8x
N10gZHQtYmluZGluZ3M6IGNsb2NrOiByOWEwN2cwNDMtY3BnOiBBZGQNCj4gPj4+PiBwb3dlciBk
b21haW4gSURzDQo+ID4+Pj4NCj4gPj4+PiBIaSwgQmlqdSwNCj4gPj4+Pg0KPiA+Pj4+IE9uIDA4
LjAyLjIwMjQgMTY6MzAsIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4+PiBIaSBDbGF1ZGl1LA0KPiA+
Pj4+Pg0KPiA+Pj4+PiBUaGFua3MgZm9yIHRoZSBwYXRjaC4NCj4gPj4+Pj4NCj4gPj4+Pj4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+PiBGcm9tOiBDbGF1ZGl1IDxjbGF1ZGl1
LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+Pj4+PiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgOCwg
MjAyNCAxMjo0MyBQTQ0KPiA+Pj4+Pj4gU3ViamVjdDogW1BBVENIIDAxLzE3XSBkdC1iaW5kaW5n
czogY2xvY2s6IHI5YTA3ZzA0My1jcGc6IEFkZA0KPiA+Pj4+Pj4gcG93ZXIgZG9tYWluIElEcw0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51
akBicC5yZW5lc2FzLmNvbT4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBBZGQgcG93ZXIgZG9tYWluIElE
cyBmb3IgUlovRzJVTCAoUjlBMDdHMDQzKSBTb0MuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gU2lnbmVk
LW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29t
Pg0KPiA+Pj4+Pj4gLS0tDQo+ID4+Pj4+PiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9yOWEw
N2cwNDMtY3BnLmggfCA0OA0KPiA+Pj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4+
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3I5YTA3ZzA0My1jcGcuaA0K
PiA+Pj4+Pj4gYi9pbmNsdWRlL2R0LSBiaW5kaW5ncy9jbG9jay9yOWEwN2cwNDMtY3BnLmggaW5k
ZXgNCj4gPj4+Pj4+IDc3Y2RlOGVmZmRjNy4uZWFiZmVlYzdhYzM3DQo+ID4+Pj4+PiAxMDA2NDQN
Cj4gPj4+Pj4+IC0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svcjlhMDdnMDQzLWNwZy5o
DQo+ID4+Pj4+PiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3I5YTA3ZzA0My1jcGcu
aA0KPiA+Pj4+Pj4gQEAgLTIwMCw1ICsyMDAsNTMgQEANCj4gPj4+Pj4+ICAjZGVmaW5lIFI5QTA3
RzA0M19BWDQ1TVBfQ09SRTBfUkVTRVROCTc4CS8qIFJaL0ZpdmUgT25seSAqLw0KPiA+Pj4+Pj4g
ICNkZWZpbmUgUjlBMDdHMDQzX0lBWDQ1X1JFU0VUTgkJNzkJLyogUlovRml2ZSBPbmx5ICovDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gKy8qIFBvd2VyIGRvbWFpbiBJRHMuICovDQo+ID4+Pj4+PiArI2Rl
ZmluZSBSOUEwN0cwNDNfUERfQUxXQVlTX09OCQkwDQo+ID4+Pj4+PiArI2RlZmluZSBSOUEwN0cw
NDNfUERfR0lDCQkxDQo+ID4+Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfSUE1NQkJMg0KPiA+
Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX01IVQkJMw0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlB
MDdHMDQzX1BEX0NPUkVTSUdIVAkJNA0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NZ
QwkJNQ0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0RNQUMJCTYNCj4gPj4+Pj4+ICsj
ZGVmaW5lIFI5QTA3RzA0M19QRF9HVE0wCQk3DQo+ID4+Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNf
UERfR1RNMQkJOA0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0dUTTIJCTkNCj4gPj4+
Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9NVFUJCTEwDQo+ID4+Pj4+PiArI2RlZmluZSBSOUEw
N0cwNDNfUERfUE9FMwkJMTENCj4gPj4+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9XRFQwCQkx
Mg0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NQSQkJMTMNCj4gPj4+Pj4+ICsjZGVm
aW5lIFI5QTA3RzA0M19QRF9TREhJMAkJMTQNCj4gPj4+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19Q
RF9TREhJMQkJMTUNCj4gPj4+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9JU1UJCTE2DQo+ID4+
Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfQ1JVCQkxNw0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlB
MDdHMDQzX1BEX0xDREMJCTE4DQo+ID4+Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU1NJMAkJ
MTkNCj4gPj4+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9TU0kxCQkyMA0KPiA+Pj4+Pj4gKyNk
ZWZpbmUgUjlBMDdHMDQzX1BEX1NTSTIJCTIxDQo+ID4+Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNf
UERfU1NJMwkJMjINCj4gPj4+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9TUkMJCTIzDQo+ID4+
Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfVVNCMAkJMjQNCj4gPj4+Pj4+ICsjZGVmaW5lIFI5
QTA3RzA0M19QRF9VU0IxCQkyNQ0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1VTQl9Q
SFkJCTI2DQo+ID4+Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfRVRIRVIwCQkyNw0KPiA+Pj4+
Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0VUSEVSMQkJMjgNCj4gPj4+Pj4+ICsjZGVmaW5lIFI5
QTA3RzA0M19QRF9JMkMwCQkyOQ0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0kyQzEJ
CTMwDQo+ID4+Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfSTJDMgkJMzENCj4gPj4+Pj4+ICsj
ZGVmaW5lIFI5QTA3RzA0M19QRF9JMkMzCQkzMg0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQz
X1BEX1NDSUYwCQkzMw0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NDSUYxCQkzNA0K
PiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NDSUYyCQkzNQ0KPiA+Pj4+Pj4gKyNkZWZp
bmUgUjlBMDdHMDQzX1BEX1NDSUYzCQkzNg0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BE
X1NDSUY0CQkzNw0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NDSTAJCTM4DQo+ID4+
Pj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU0NJMQkJMzkNCj4gPj4+Pj4+ICsjZGVmaW5lIFI5
QTA3RzA0M19QRF9JUkRBCQk0MA0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1JTUEkw
CQk0MQ0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1JTUEkxCQk0Mg0KPiA+Pj4+Pj4g
KyNkZWZpbmUgUjlBMDdHMDQzX1BEX1JTUEkyCQk0Mw0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdH
MDQzX1BEX0NBTkZECQk0NA0KPiA+Pj4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0FEQwkJNDUN
Cj4gPj4+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9UU1UJCTQ2DQo+ID4+Pj4+DQo+ID4+Pj4+
IE5vdCBzdXJlIGZyb20gIlRhYmxlIDQyLjMgUmVnaXN0ZXJzIGZvciBNb2R1bGUgU3RhbmRieSBN
b2RlIg0KPiA+Pj4+Pg0KPiA+Pj4+PiBQb3dlciBkb21haW4gSUQgaGFzIHRvIGJlIGJhc2VkIG9u
IENQR19CVVNfKioqX01TVE9QIG9yDQo+ID4+Pj4+IENQR19DTEtPTl8qKiogQXMgZm9ybWVyIHJl
ZHVjZXMgbnVtYmVyIG9mIElEcz8/DQo+ID4+Pj4NCj4gPj4+PiBJZiBJIHVuZGVyc3RhbmQgY29y
cmVjdGx5IHlvdXIgcG9pbnQgaGVyZSwgeW91IHdhbnQgbWUgdG8gZGVzY3JpYmUNCj4gPj4+PiBQ
TSBkb21haW4gaW4gRFQgd2l0aCBzb21ldGhpbmcgbGlrZToNCj4gPj4+Pg0KPiA+Pj4+IHBvd2Vy
LWRvbWFpbnMgPSA8JmNwZyBDUEdfQlVTX1hfTVNUT1A+Ow0KPiA+Pj4NCj4gPj4+IE1TVE9QIGJp
dHMgYXJlIGRpc3RpbmN0IGZvciBlYWNoIElQLg0KPiA+Pj4NCj4gPj4+IDwmY3BnIENQR19CVVNf
TUNQVTFfTVNUT1AgeD47IHggPTEuLjkNCj4gPj4+DQo+ID4+PiAyPU1UVSBJUA0KPiA+Pj4NCj4g
Pj4+IDQ9IEdQVA0KPiA+Pj4NCj4gPj4+IGV0Yy4uLg0KPiA+Pj4NCj4gPj4+IElzIGl0IHNvbWV0
aGluZyB3b3JrPz8NCj4gPj4NCj4gPj4gSXQgbWlnaHQgd29yay4gQnV0Og0KPiA+Pg0KPiA+PiAt
IHlvdSBoYXZlIHRvIGNvbnNpZGVyIHRoYXQgc29tZSBJUHMgaGF2ZSBtb3JlIHRoYW4gb25lIE1T
VE9QIGJpdCwNCj4gPj4gdGh1cywgZG8NCj4gPj4gICB3ZSB3YW50IHRvIHVuaXF1ZWx5IGlkZW50
aWZ5IHRoZXNlIHdpdGggYWxsIE1TVE9QIGJpdHMgKHRodXMgdGhlDQo+ID4+IDJuZCBjZWxsDQo+
ID4+ICAgYmVpbmcgYSBiaXRtYXNrKSBvciBvbmx5IG9uZSBpcyBlbm91Z2g/DQo+ID4NCj4gPiBX
ZSBjYW4gaGF2ZSBhbiBlbmNvZGluZyBpbiB0aGF0IGNhc2UgODoxNiAyNCBiaXQgZW50cmllcw0K
PiANCj4gSSBjb25zaWRlciB0aGlzIGNvbXBsaWNhdGVzIHRoZSBiaW5kaW5ncy4gSSBkb24ndCBj
b25zaWRlciB0aGlzIGlzIHRoZSB3YXkNCj4gZ29pbmcgZm9yd2FyZC4gQnV0IEkgbWF5IGJlIHdy
b25nLiBJJ2xsIGxldCBHZWVydCB0byBnaXZlIGhpcyBvcGluaW9uIG9uDQo+IGl0IGFuZCBjaGFu
Z2UgaXQgYWZ0ZXJ3YXJkcywgaWYgYW55Lg0KPiANCj4gPg0KPiA+PiAtIHNvbWUgSFcgYmxvY2tz
IChlLmcuIE9URkRFX0REUikgaGF2ZSBubyBNU1RPUCBiaXRzIGFzc29jaWF0ZWQgKGFzIG9mDQo+
IG15DQo+ID4+ICAgY3VycmVudCByZXNlYXJjaCksIHNvLCBvbmx5IFBXUkRODQo+ID4NCj4gPiBX
aHkgZG8gd2Ugd2FudCB0byBhZGQgcG93ZXIgZG9tYWluIHN1cHBvcnQgZm9yIEREUj8NCj4gDQo+
IFRvIHBvd2VyIGl0IHVwIChpbiBjYXNlIGJvb3Rsb2FkZXIgZG9lcyBhbnkgc2V0dGluZ3MgaW4g
dGhpcyBhcmVhKSBzdWNoDQo+IHRoYXQgdGhlIHN5c3RlbSB3aWxsIG5vdCBibG9jayB3aGlsZSBi
b290aW5nLg0KDQpERFIgaXMgZW5hYmxlZCBieSBURl9BIGFuZCBpcyBub3QgdG91Y2hlZCBieSBs
aW51eCwgc28gd2h5IGFyZSB3ZSBhZGRpbmcNClBvd2VyIGRvbWFpbiBhdCBhbGwgaW4gZmlyc3Qg
cGxhY2UuIFRaQyBERFIgaXMgbm90IGFjY2Vzc2libGUgaW4gbm9ybWFsIHdvcmxkLg0KDQpTbyBp
ZiB5b3UgZG9uJ3QgYWRkIEREUiBwb3dlciBkb21haW5zLCBsaW51eCBkb2Vzbid0IGtub3cgYWJv
dXQgYW55IHRoaW5nIGFib3V0DQphbmQgaXQgc2hvdWxkIHdvcmsgbGlrZSBjdXJyZW50IGNhc2Uu
DQoNCj4gDQo+IEl0IGlzIGV4cGxhaW5lZCBpbiBjb3ZlciBsZXR0ZXI6DQo+IA0KPiBUaGUgY3Vy
cmVudCBEVA0KPiBiaW5kaW5ncyB3ZXJlIHVwZGF0ZWQgd2l0aCBtb2R1bGUgSURzIGZvciB0aGUg
bW9kdWxlcyBsaXN0ZWQgaW4gdGFibGVzDQo+IHdpdGggbmFtZSAiUmVnaXN0ZXJzIGZvciBNb2R1
bGUgU3RhbmRieSBNb2RlIiAoc2VlIEhXIG1hbnVhbCkgZXhjZXB0aW9uDQo+IGJlaW5nIFJaL0cz
UyB3aGVyZSwgKmR1ZSB0byB0aGUgcG93ZXIgZG93biBmdW5jdGlvbmFsaXR5KiwgdGhlIEREUiwN
Cj4gVFpDRERSLCBPVEZERV9ERFIgd2VyZSBhbHNvIGFkZGVkLCB0byBhdm9pZCBzeXN0ZW0gYmVp
bmcgYmxvY2tlZCBkdWUgdG8NCj4gdGhlIGZvbGxvd2luZyBsaW5lcyBvZiBjb2RlIGZyb20gcGF0
Y2ggNy8xNy4NCj4gDQo+ICsgICAgICAgLyogUHJlcGFyZSBmb3IgcG93ZXIgZG93biB0aGUgQlVT
ZXMgaW4gcG93ZXIgZG93biBtb2RlLiAqLw0KPiArICAgICAgIGlmIChpbmZvLT5wbV9kb21haW5f
cHdyZG5fbXN0b3ApDQo+ICsgICAgICAgICAgICAgICB3cml0ZWwoQ1BHX1BXUkROX01TVE9QX0VO
QUJMRSwgcHJpdi0+YmFzZSArDQo+ICsgQ1BHX1BXUkROX01TVE9QKTsNCj4gDQo+ID4NCj4gPj4g
LSBzb21lIEhXIGJsb2NrcyBoYXZlIGJvdGggTVNUT1AgYW5kIFBXUkRODQo+ID4NCj4gPiBUaGF0
IHdpbGwgYmUgYW4gYXJyYXkgcmlnaHQ/DQo+IA0KPiBJJ20gbm90IHN1cmUgd2hhdCB5b3Ugd2Fu
dCB0byBzYXkgaGVyZS4NCg0KVGhpcyBoYXMgdG8gYmUgYW4gYXJyYXkgUE0gZG9tYWlucyhtdWx0
aSBQTSBkb21haW4pIGxpa2UgY2xvY2tzPw0KDQpPciANCg0KSXQgY2FuIGJlICBoYW5kbGVkIGFz
IHNpYmxpbGluZyBwb3dlciBkb21haW4gbGlrZSBzaWJsaW5nIGNsb2NrcyBpbiBSWi9HMkwgR2Jl
dGhlci4NCg0KQ2hlZXJzLA0KQmlqdQ0K

