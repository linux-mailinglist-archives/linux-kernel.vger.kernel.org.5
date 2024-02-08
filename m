Return-Path: <linux-kernel+bounces-58348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472584E504
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AD11C21D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278B7D416;
	Thu,  8 Feb 2024 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BjWdpW5X"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2056.outbound.protection.outlook.com [40.107.113.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344BC7D3F3;
	Thu,  8 Feb 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409703; cv=fail; b=QFDUI2y1/7gjwC21zHpyCVAbpGkQ5WdPg3aMvwGkQ32IWME+9pyCyzWrIvQrU2WPjcqJRbuH6ZGJxA1blHq5DKELn/YEwoFQUof8UqyRPmh+pqRHtbw4WGwJzBQvVI7Wo1rzT/HJQKqtR73anDvo9a+332lCMRPhBFEgrPn/SxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409703; c=relaxed/simple;
	bh=mvEA0VsxZAsKoVWV/S5wqklRu4q8G7rlWgnAp4dtUy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlF6K0bnuDhW9JIlZypWKUi6N4V9NwxBSEtTB32OEbrIw+6NbwTBk7WT7Wb6aYd5/sZ8upIdzxcVxWGEoWnu2aa9plsgjYlfHPkaN4zosZ/eQ6KZOhURR7/WBF0Sl9C6gSaihRbXq2r7AOSNHZoSqjmauao1lS7i4s4MZIPcIbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BjWdpW5X; arc=fail smtp.client-ip=40.107.113.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOXpIWk2kjovGzHJ/2iny+RrvhMlvmftpp0SJ5BKliLyPGESZyyykm6wso4lkRiRmbo/+03IIbvMa+SJKNvKe6ScuXBEmhNYZzwK2HPRvW8wbCmcbj9cnLZvN8yPcbwqwmErmQOOrWQLLHJCFbRWXH2peZeFG6QQVXKv7tkzyzj8RNvR5tIr3wgolYysnxh2mLbcci2pSG/M0BzcPWkECYHVkwAKJfqFZAg7XtVUdw70Fch7ncbDZps96fV8oaED8AY+gQ8KCvTa6mhWNZGeup4ZkYwL3uK1t0tepZZdR9m7hl3JYQxZHzyML/HC2Gc6LVpQMzh2oAbmmbtLs5cChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvEA0VsxZAsKoVWV/S5wqklRu4q8G7rlWgnAp4dtUy0=;
 b=GcFEnnpJvfnVIrqpipesYq9S65ZSLXkKJnhY8Ter81G9TAyFR6aC6uAv04DQjSOy42XWhEEgK4wJHjrwAFwJHk5NioR/jh+UfGpKb7hamk2bhMDVOTOUZx8xOX5TA0pxK9siTzC5GD+pfabHhGtxS4n3j+NORMHnsNE8I+zIUYYyFu93pnX8+8+5521q48MMFgPyiM35Qodd1mXUDQv9XQcGQxAf/DZM6oiPYTnypiFOCpZ9CYkbtVCDfJMy+Yb3JInUvtgLYZNUzEJEUY0OdEHNJqHjaB7Prpnn/SlmMEol4r+MPn6bGdnQ4TsvBuQdalOSEKH/AqnNiUliEXRvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvEA0VsxZAsKoVWV/S5wqklRu4q8G7rlWgnAp4dtUy0=;
 b=BjWdpW5Xb8q0jsf9GMEDpcpPSDyY+0EG5md2+L0gEZlsirypRvR6VDvPtQwBnz0m/B78o2SSIfqrHDpJ1VeBMC9ocaBfNrMO7pejW/MuCLscX8WnhrvoG0pX+WCVeTor1PArCDauknPddA7kR6RrXJviotQxlJPXp+k+YYPHa2U=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 16:28:15 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 16:28:15 +0000
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
Thread-Index: AQHaWox93XkHXchpTkaSnTQ6Ok/3vrEAgGfQgAAWUICAAAlS4A==
Date: Thu, 8 Feb 2024 16:28:15 +0000
Message-ID:
 <TYCPR01MB112698AB206332D13105C064186442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269DEA9261CA594EECC949686442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <67ad8052-1406-4dcb-9e35-5c42ada28797@tuxon.dev>
In-Reply-To: <67ad8052-1406-4dcb-9e35-5c42ada28797@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYAPR01MB6220:EE_
x-ms-office365-filtering-correlation-id: b3adf273-e04c-4725-7cbc-08dc28c2f387
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0KpWX2Gp32TCG2F8h5gqKRPBDvhlSlsQxF8im+6rwCXpSZrez/Y3w0zN54aEzqWGeVcR2jnKrEOuoptMnTOhLl81FTwTsAXrcYGRM8bTzGw/xs+nNuURTyUIUW4Bc8NbUyIZjFklJjU1cvVdoUt1x8us0U6s/Z0JwuA/UypR3CXwaCgsVhZmdofy4KRKRt3qg+81FDH81PTOPtIkLtHEUsw0GIWhGpyL5pCkGrQcl272lYTohD6SYRogPWYLUbDfJOgahsBg4sJ6wbhlBhiKeGiZSf2D3TifhA/scYpqokuHw3lMGCb11HwYhm+wINSZa1dYZVBjD+ccYmbiVq3TV4YPH03/ahGDoKyyBVZsIQMMdSXCGH2BrH2PgEnV0TcjENHHLRtB10Urpc4zdC1UI+C3f/nBz12DeTHj/2LrnexbuBf/MuU+pr/CBI4tL7yfGAwC+g80pUnOKpLcqJULBfBe7Dv6f+4h9JXi1exmtctW7Rtn0zMQ9aOfbz3qr4M1YTV8d9XqNYRkBXwjdVQFh1orc8zaotRDtseGeWEAqDuXs2IQigVuxj7zFMokwCs44p1VPWO6Zo3LB8XZuqwcMmt5TLLkM30Jk3weuzDXn6gBzjfN4Z++xEaDBQOQfAxBIrY2n9pdUlYdaQtpKz0mug==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(38100700002)(66556008)(66476007)(66446008)(64756008)(54906003)(7696005)(110136005)(76116006)(55236004)(53546011)(6506007)(9686003)(66946007)(478600001)(71200400001)(38070700009)(8936002)(8676002)(316002)(33656002)(122000001)(83380400001)(107886003)(26005)(86362001)(921011)(4326008)(2906002)(52536014)(7416002)(5660300002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RThPcDgxbXdmTUY3UlR4R3RIdDV1c2txMURyY0Y2TTV5cjdyYWdhcWcwckxN?=
 =?utf-8?B?dnZKcWhiKytWY1d6TkV6T1FZQ1NYMnluWmpVMnAvM3oxZGx1S1hjeEJ2bjZM?=
 =?utf-8?B?TkJaOE5XZnZVRWtPZ2F4eXo4WDVpWXVYUForZW9ZVm5DN3lrWEdlclVIQmNH?=
 =?utf-8?B?N2JKYkVzK0hncURNLzZTbDB2VzJSZk1zbXd0UC9ibFRKeTAwRjl2M1JCQTRq?=
 =?utf-8?B?emNKaWdlclRDamxWOHozT1FxS0ZZL0xhL01Sb3ZMS2dvQWJpOUdDL1NmeCtq?=
 =?utf-8?B?YTdQK25KbmowRVNuSVJCY2dPbUNjMjlVSXJnT2k1VzNCeHFVWnpuSE1lVm5z?=
 =?utf-8?B?RklLa3B0aTJQenE2UE13VUwwNFQ4ZWxBTEtEL29wR2FIVjFiSkVBTi91VEJU?=
 =?utf-8?B?L2s3TXR5RzN6TVJ3dWUzZVp4dTNSejZlbDlPaEtXei9BL1NoTk0vYlpHTDh1?=
 =?utf-8?B?eHRaSHE0UEUxZWhTNG9Vb2wvQm04dGE4aC9DSG9YR250YUNvcWpFZUsxcERF?=
 =?utf-8?B?NnU0R2hLRFN1OHMvREt2SmdNZGxEVXBWK0NhWVQ3QUdLZjErMm1xR2NBaFZ3?=
 =?utf-8?B?cWFUNjlqdkpjOW9RLy9iSXV4MTVDM2hFRzVjdE54WWlzSUtrQUtxVXZFNXJn?=
 =?utf-8?B?elp5NVdMeXEzdW40UmJNTGs2RDVmMkFpbSt3TGwwQU5yQjVwS3orazc0Zk9z?=
 =?utf-8?B?U2N2U3NRR2VoZWRFOWQ1QUYyVkRWRkdydSt5eW9IZy9GUjdyeE1yTUxLdFY0?=
 =?utf-8?B?MmQzMjV0SXhQRXk4MExiSStmVmtTSFJQazhIR3UyMWRUV0Z5eEtDQmZWQWNo?=
 =?utf-8?B?T2dMVnlVOGR1ZlpqOERTNmFhakJ4d2hyVjM2bEsxWkJGbFJDNzhkVGtrOWJH?=
 =?utf-8?B?cjRZZzRmcVFuVHJ0N0ZVZ0VUL2p6NEMzREVUK20rV2RQZnMxVkJabTVia29s?=
 =?utf-8?B?VWRscFo0cWNJcEFyVi8zaU9uQVZrMUFnSHg1L2s4WjlyMFZqSExiZWJUMFRI?=
 =?utf-8?B?ZHVFS0pGdERBZVAvc1lpT00rcUdWV0FKS2RTaml2cXBZemwvakhOSk8xNkE1?=
 =?utf-8?B?c1JSd2VZZTV2Nkh2N2xCZHgwYzdURXB2MHdvZTZkVXZQNHNCNklXMlMrdjJ3?=
 =?utf-8?B?S3BCT0RoOWs5TTMvZ3BXWDgxZmE2ZG5uVG5QdEIrbEpUdU0wejhJdUNZeVg5?=
 =?utf-8?B?em91MnNPT05UNitZTjAwdjZTNHNnNU9naXE0MGREQ3c0NXo2Vk1NOE15eHUy?=
 =?utf-8?B?a2hRdjN3aURYREdCVmhtK09LR1hCNlFQWXg0Q0tUOWNGaWtHYTRMbHBBR1Vo?=
 =?utf-8?B?alk4THk3VnhTSTVtYU9Db0NqQVVBazhIRnI4RkhJM1FvdXY3Ky9aV0FPTEtX?=
 =?utf-8?B?dWJ2czZlQjI5WEtVY0FHMm04MXJjZmJEZERTMTZ0cmtFTDJISHpvNW93cFg1?=
 =?utf-8?B?ekpqSFk4WkN3N2FxT1VNcGV0elIxUGNHMW5aU1d2WWt0eW5uYkl5UmRhOHBm?=
 =?utf-8?B?TXl6aVdwdU1mUlV6QkxCeEtIbzRBZEw2eWNHdjZlV1ptb2NRbS9ub0kreUxr?=
 =?utf-8?B?cjE1dDdoUzUwSUllVVBUeis0VUJNTHRUYU9hS1JwdlRrQWZRSEtzTG0wcWhy?=
 =?utf-8?B?bUFCSDlrRDM5NlZvYTlsSndOb2orcTBUUXk0SkpKOHYzWDhFSFh3SXZIaHB2?=
 =?utf-8?B?NkFxQXp2OEd6SXAveURMaUpZTXQxazY0ZHNEUDdLSUZDeFpQQ3lldkI2cEFa?=
 =?utf-8?B?ZkhoZUFkOTFubDVPZi85WldoT25SWFQ3ZEhqZVlibk5qUWROTmYrRlhBVXdK?=
 =?utf-8?B?N1cxRjFldTFySVBYa0Jocy9BZ25YbGRRSUdqaEM2TVBEZWhNK2hDMXdjdEtX?=
 =?utf-8?B?dHZYZWI3b2NTeWE0SnY3K3NHby9FQUlDZktSRm05MzZXMC9vN2pacmJvZjQy?=
 =?utf-8?B?d1FVckJKNEx0WWJoamJWK2lJR0N0TG9kTS9PT2J3cko2NTZrdTNMQVlpQ2x5?=
 =?utf-8?B?ZkJBTzNDaWdwYTg5ZlpxK3IyaFNhanRONHhicWsrdGkvRDljWG1Nek5reC9q?=
 =?utf-8?B?QzhhSEp1UzRXRXdISUhKNk80R290d1p0OE1KU1BNRElrczZiY2ZCZ2dDVjFp?=
 =?utf-8?B?RG9UcWtIZWRvQVFBaXM3Q09QK2xvRDF6M3RwTkpzNW95UnBQOVdHVWdYaXpO?=
 =?utf-8?B?MlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3adf273-e04c-4725-7cbc-08dc28c2f387
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 16:28:15.3654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4EW43IZL6DjSnd4B7DGzGjIMSsFXbl9j/4EDTjCapj+x8K/8lZAbMmMqmKhiBb/NqPKvsTsaihOhozDrCz7KTQtaWfAMk0Sdd+4xUhSIdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2xhdWRpdSBiZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDgs
IDIwMjQgMzo0NiBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzE3XSBkdC1iaW5kaW5nczog
Y2xvY2s6IHI5YTA3ZzA0My1jcGc6IEFkZCBwb3dlcg0KPiBkb21haW4gSURzDQo+IA0KPiBIaSwg
QmlqdSwNCj4gDQo+IE9uIDA4LjAyLjIwMjQgMTY6MzAsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhp
IENsYXVkaXUsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaC4NCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5l
YUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA4LCAyMDI0IDEyOjQz
IFBNDQo+ID4+IFN1YmplY3Q6IFtQQVRDSCAwMS8xN10gZHQtYmluZGluZ3M6IGNsb2NrOiByOWEw
N2cwNDMtY3BnOiBBZGQgcG93ZXINCj4gPj4gZG9tYWluIElEcw0KPiA+Pg0KPiA+PiBGcm9tOiBD
bGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+DQo+
ID4+IEFkZCBwb3dlciBkb21haW4gSURzIGZvciBSWi9HMlVMIChSOUEwN0cwNDMpIFNvQy4NCj4g
Pj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVq
QGJwLnJlbmVzYXMuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xv
Y2svcjlhMDdnMDQzLWNwZy5oIHwgNDgNCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysNCj4g
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3I5YTA3ZzA0My1jcGcuaCBiL2luY2x1ZGUv
ZHQtDQo+ID4+IGJpbmRpbmdzL2Nsb2NrL3I5YTA3ZzA0My1jcGcuaCBpbmRleCA3N2NkZThlZmZk
YzcuLmVhYmZlZWM3YWMzNw0KPiA+PiAxMDA2NDQNCj4gPj4gLS0tIGEvaW5jbHVkZS9kdC1iaW5k
aW5ncy9jbG9jay9yOWEwN2cwNDMtY3BnLmgNCj4gPj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9yOWEwN2cwNDMtY3BnLmgNCj4gPj4gQEAgLTIwMCw1ICsyMDAsNTMgQEANCj4gPj4g
ICNkZWZpbmUgUjlBMDdHMDQzX0FYNDVNUF9DT1JFMF9SRVNFVE4JNzgJLyogUlovRml2ZSBPbmx5
ICovDQo+ID4+ICAjZGVmaW5lIFI5QTA3RzA0M19JQVg0NV9SRVNFVE4JCTc5CS8qIFJaL0ZpdmUg
T25seSAqLw0KPiA+Pg0KPiA+PiArLyogUG93ZXIgZG9tYWluIElEcy4gKi8NCj4gPj4gKyNkZWZp
bmUgUjlBMDdHMDQzX1BEX0FMV0FZU19PTgkJMA0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNfUERf
R0lDCQkxDQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9JQTU1CQkyDQo+ID4+ICsjZGVmaW5l
IFI5QTA3RzA0M19QRF9NSFUJCTMNCj4gPj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0NPUkVTSUdI
VAkJNA0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU1lDCQk1DQo+ID4+ICsjZGVmaW5lIFI5
QTA3RzA0M19QRF9ETUFDCQk2DQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9HVE0wCQk3DQo+
ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9HVE0xCQk4DQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0
M19QRF9HVE0yCQk5DQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9NVFUJCTEwDQo+ID4+ICsj
ZGVmaW5lIFI5QTA3RzA0M19QRF9QT0UzCQkxMQ0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNfUERf
V0RUMAkJMTINCj4gPj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NQSQkJMTMNCj4gPj4gKyNkZWZp
bmUgUjlBMDdHMDQzX1BEX1NESEkwCQkxNA0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU0RI
STEJCTE1DQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9JU1UJCTE2DQo+ID4+ICsjZGVmaW5l
IFI5QTA3RzA0M19QRF9DUlUJCTE3DQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9MQ0RDCQkx
OA0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU1NJMAkJMTkNCj4gPj4gKyNkZWZpbmUgUjlB
MDdHMDQzX1BEX1NTSTEJCTIwDQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9TU0kyCQkyMQ0K
PiA+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU1NJMwkJMjINCj4gPj4gKyNkZWZpbmUgUjlBMDdH
MDQzX1BEX1NSQwkJMjMNCj4gPj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1VTQjAJCTI0DQo+ID4+
ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9VU0IxCQkyNQ0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNf
UERfVVNCX1BIWQkJMjYNCj4gPj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0VUSEVSMAkJMjcNCj4g
Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0VUSEVSMQkJMjgNCj4gPj4gKyNkZWZpbmUgUjlBMDdH
MDQzX1BEX0kyQzAJCTI5DQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9JMkMxCQkzMA0KPiA+
PiArI2RlZmluZSBSOUEwN0cwNDNfUERfSTJDMgkJMzENCj4gPj4gKyNkZWZpbmUgUjlBMDdHMDQz
X1BEX0kyQzMJCTMyDQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9TQ0lGMAkJMzMNCj4gPj4g
KyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NDSUYxCQkzNA0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNf
UERfU0NJRjIJCTM1DQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9TQ0lGMwkJMzYNCj4gPj4g
KyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NDSUY0CQkzNw0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNf
UERfU0NJMAkJMzgNCj4gPj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NDSTEJCTM5DQo+ID4+ICsj
ZGVmaW5lIFI5QTA3RzA0M19QRF9JUkRBCQk0MA0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNfUERf
UlNQSTAJCTQxDQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9SU1BJMQkJNDINCj4gPj4gKyNk
ZWZpbmUgUjlBMDdHMDQzX1BEX1JTUEkyCQk0Mw0KPiA+PiArI2RlZmluZSBSOUEwN0cwNDNfUERf
Q0FORkQJCTQ0DQo+ID4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9BREMJCTQ1DQo+ID4+ICsjZGVm
aW5lIFI5QTA3RzA0M19QRF9UU1UJCTQ2DQo+ID4NCj4gPiBOb3Qgc3VyZSBmcm9tICJUYWJsZSA0
Mi4zIFJlZ2lzdGVycyBmb3IgTW9kdWxlIFN0YW5kYnkgTW9kZSINCj4gPg0KPiA+IFBvd2VyIGRv
bWFpbiBJRCBoYXMgdG8gYmUgYmFzZWQgb24gQ1BHX0JVU18qKipfTVNUT1Agb3IgQ1BHX0NMS09O
XyoqKg0KPiA+IEFzIGZvcm1lciByZWR1Y2VzIG51bWJlciBvZiBJRHM/Pw0KPiANCj4gSWYgSSB1
bmRlcnN0YW5kIGNvcnJlY3RseSB5b3VyIHBvaW50IGhlcmUsIHlvdSB3YW50IG1lIHRvIGRlc2Ny
aWJlIFBNDQo+IGRvbWFpbiBpbiBEVCB3aXRoIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gcG93ZXIt
ZG9tYWlucyA9IDwmY3BnIENQR19CVVNfWF9NU1RPUD47DQoNCk1TVE9QIGJpdHMgYXJlIGRpc3Rp
bmN0IGZvciBlYWNoIElQLg0KDQo8JmNwZyBDUEdfQlVTX01DUFUxX01TVE9QIHg+OyB4ID0xLi45
DQoNCjI9TVRVIElQDQoNCjQ9IEdQVA0KDQpldGMuLi4NCg0KSXMgaXQgc29tZXRoaW5nIHdvcms/
Pw0KDQo+IA0KPiB3aGVyZSBYPXtBQ1BVLCBQRVJJX0NQVSwgUEVSSV9DUFUyLCBSRUcwLCBSRUcx
fSA/DQo+IA0KPiBXaXRoIHRoaXMsIEkgc3RpbGwgc2VlIHRoZSBuZWNlc3NpdHkgb2YgYSAzcmQg
aWRlbnRpZmllciB0aGF0IHdpbGwgYmUgSVANCj4gc3BlY2lmaWMgdG8gYmUgYWJsZSB0byB1bmlx
dWVseSBtYXRjaCBiL3cgRFQgZGVzY3JpcHRpb24gYW5kIHJlZ2lzdGVyZWQNCj4gcG93ZXIgZG9t
YWluLiBGTVBPViwgdGhpcyB3aWxsIGxlYWQgdG8gYSBtb3JlIGNvbXBsaWNhdGVkIGltcGxlbWVu
dGF0aW9uLg0KPiANCj4gV2UgbmVlZCBhIHVuaXF1ZSBJRCB0aGF0IHRoZSBwbSBkb21haW4geGxh
dGUgd2lsbCB1c2UgdG8geGxhdGUgdGhlIERUDQo+IGJpbmRpbmcgdG8gZHJpdmVyIGRhdGEgc3Ry
dWN0dXJlcy4NCg0KT2suDQoNCkNoZWVycywNCkJpanUNCg0K

