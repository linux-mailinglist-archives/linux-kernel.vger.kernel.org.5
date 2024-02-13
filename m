Return-Path: <linux-kernel+bounces-63448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE57852FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63225285854
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E137706;
	Tue, 13 Feb 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ng7rZB/F"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2079.outbound.protection.outlook.com [40.107.114.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D436B17;
	Tue, 13 Feb 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824381; cv=fail; b=jw9TahqRe8e4qvBGZTLNuK/DglU3W5zNqQIfJ0M8QjnuiTCrCqcDeKfGN8hPHBURMpud8PGeEVT4sHZRfWFOe+0SPWnnSjufdjuhw3ul2SHRCTmJyTFXgmMKs+9rqPL8qcTLQo5EeZo4andn53pDJsEelYR3vanGrLYI8uCAkhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824381; c=relaxed/simple;
	bh=GnUPVPUx/9sz02sZhVidZ1f4pmWsfGeE435niDZk3T8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Za9qGuXZosW4RZhQzqRZH8fgbjeIcFAXbzuWDjA7YAeQ9rbaARmR3b85CmqIdjZdBDbAn7yb6pTnEPN8ffQwwQUhVqhDYQzmeXwfyLYFqUEDPmjNHVDCe/L5VIFeCoCjEs5I+OyLZbNXkJsDUiCjgH2C/+1JkbMotEaLjKtU4Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ng7rZB/F; arc=fail smtp.client-ip=40.107.114.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIH1xcMC9bYr/bauhwOVeYeRQpOE/AqbQg/qi/3r3kWOax6qUdFhzrZ7e6y0McI3+i9FFHnjVCZ+Xak6zSV9JH7gjfhs+XI02BwNVr8lYUTivF0LaQXKO/eFOtfnehyFZapsHAmtxyQbkovJxcwcwthpTAndpHiqVNEDFKDV1wxU2Zea8BD31LJ2zQsbqhcXofg2TSmuUnnJZQ3sR6mDxFSzBjVqEqunWcVxqmeHa9iL9SBW2YtS+B0I/sDEcUq/0+qSYg20jgP0bHODbtONz8lViinYj4XVb20CbkTKxEnViHVwbWqeaZFYmSpoxaV577rBmbS62r6KZJW8/QFu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnUPVPUx/9sz02sZhVidZ1f4pmWsfGeE435niDZk3T8=;
 b=UCcBLmEtzPVi9vnchiz4le+IDeiFw5DORPrI1/H5vXBUBIEHnVmNshBLL2JCH9kyWuH7wywYP1MWEoSz/PC8P3Bp10URP7RGp1uBiHsh7fw810uQ6PDex6aQZZhs45pTQ1+EZYfBur8BMc27Gcd22DpoWhsJI4llSztFelOePClcihJ4KkV6pfVhFf0/xyjOcfKATQ5oqa27UKknch4RcheOINLSU7QSw1dTbsS/b2BhS7rZdxpf7JV4vrrZHpZ9lhDxFmYOJHAenTxzogDq/U1JtmHqKy+SRPYIW6WsU3PK1vbiFxT4s/4SNrf/RMayoC3OYUQCWI0gOlccDlvjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnUPVPUx/9sz02sZhVidZ1f4pmWsfGeE435niDZk3T8=;
 b=ng7rZB/FDXsxkRzeesaBSYdhK71HqGVmQg4hy4PuqB7ceAoPk4kWO/vzVFdkzo5eUAHjv/PQiGJX3WEj3n8yLgWJBHBsk25NlkNAnzRrY1waIN60zY3Ul7BwYuC6C/cHHtnRHo/JXhqZDjh9x7i4vKNarr8gdA0Vcgv+xweJp4E=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB8226.jpnprd01.prod.outlook.com
 (2603:1096:604:174::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 11:39:35 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 11:39:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "s.shtylyov@omp.ru"
	<s.shtylyov@omp.ru>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH net-next v3 5/6] net: ravb: Do not apply features to
 hardware if the interface is down
Thread-Topic: [PATCH net-next v3 5/6] net: ravb: Do not apply features to
 hardware if the interface is down
Thread-Index: AQHaXmDfj3p/d+D+vE6GR/WgPunNWLEICrVggAASHwCAAAhIIA==
Date: Tue, 13 Feb 2024 11:39:34 +0000
Message-ID:
 <TYCPR01MB11269FF7BA40379E09DB21673864F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
 <20240213094110.853155-6-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB112698DE07AAA9C535776805D864F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <368ca0a8-a005-4371-a959-297fd4f58cb1@tuxon.dev>
In-Reply-To: <368ca0a8-a005-4371-a959-297fd4f58cb1@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB8226:EE_
x-ms-office365-filtering-correlation-id: d98e80c2-2c17-4890-f7c5-08dc2c8873cc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0Q22wdY/RXTKTNnSF74SrUKNhKGb+qn6tpSWSVsmXX8yVKP+KX2LzZQmXADPyPRKA4+DQYSpN7UoxOTL3A4JBMafUXtu/S6HdMh5qPyLEzbKx9s3HJzUgqvlIncrCtpnIUrz5vKMtntZoSkS4erqwKeuFV53exWLeaHw939ILTNnqB34LBCoWVmqhayXF7Eo0ezWdCrBxmmC1T3YXSNuKC4N2NjYwrzm8R9gDfgijt7ez1sYK1kY8GkIwSvKN0SwGF3Aj+Dq/biN4yw/hQW9eS2tlh59Rmawnd/q2NPmDNrQVeap06kCPpw9UmOZV0vNvSDSuHb6WzCVqfi0xUdABnKWwV99upIYuWB23ifQEm8gTeHfOwHtnKhvOhqido6r9RQK1DSRbVnVWvtA2WO+x4GSYTE0bQ5DWP6sg80gRQ7OChxQOuIMrPHAn8IbA3cleUOwlQmDaWC3MQzMl8p8HqAt3kXFcEMbDoFmaNefgblTRYVlb73WVQqYmI5CVDathady1+TrwoTRv/gqA+eaST8JVZiu5bKo6GIWZcb67JabzY4wydO6k4RzVdEKPk+8ErBgLlQ6xPX5zzUQ3Q4xY6irtX/0hnF+GOXvHu8fAdem2Uj+kMSS+1DjHSmr/046
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(2906002)(7696005)(53546011)(55236004)(26005)(41300700001)(6506007)(38070700009)(9686003)(86362001)(33656002)(83380400001)(66556008)(478600001)(107886003)(66446008)(38100700002)(71200400001)(5660300002)(316002)(8676002)(8936002)(64756008)(110136005)(54906003)(66946007)(76116006)(52536014)(66476007)(122000001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTZKbTFtV2VzUE9xUi93b0dEaDRKdG02RHRObDF6aUwwWmRxZ2t5cmJTalZ5?=
 =?utf-8?B?cTNJVmg3bEUxMmNidmxvb1pvUVdPL1QzZTdtUUI3R0xUUGdJWCszU2FNNEZm?=
 =?utf-8?B?OXRTNVpaOWtSOGZoSXJLMm5YUW9tMi9TcWpRYUxWK0M2VlY3SXdTakNTNGt5?=
 =?utf-8?B?RTJ6alVTUkdDa2RvaG1pWXU4MEtuMFJGM2thbFRRUFd4RkdoVWhhWFU2K0dM?=
 =?utf-8?B?R0NlUTd6RTFUOHVEaEtlV1dqQ1U1OURPSnJpVkszT0JBUkNHVzByWjc5d0hY?=
 =?utf-8?B?MWdraEN4QmJhK0lyK2dxNWxUYnhIK3VRUkg1L2cyYlZoelcxb1VrNEFkS0Rw?=
 =?utf-8?B?dUR3TUFzaUFOT2h5NzZhTjhrdXlMdEVlcGtWUXIxVlE0cXYrNmoyZklXaFZW?=
 =?utf-8?B?WTU1N3VGSE5HVkMzSTFnVDdRQzRwa0JMeHFMVys3d3A2bnRQS1RIQWl2bm95?=
 =?utf-8?B?b1ZkWXdUK29hRlNYZXl1TndLL2gvQjAzdkx6TnRPKzVuUUVYWmNVT3pvdjJO?=
 =?utf-8?B?dHZQeUd1aS8vQ3puUHRiRWVZVkJnVndIV2VxcmEzTlJkOTJGbGIvMXl4b25V?=
 =?utf-8?B?VWJJU3ZleDZJcDMzZXRWRUhHQW5JWWozSHl0eEdMYmNWTGlxSTdtQkw2UGJn?=
 =?utf-8?B?N25pVWRZOGNyZk1jMjAwRS9RUWc1MjgrN0dld0pDbEtVdjBCekxLY3V2amJh?=
 =?utf-8?B?M05WVGJtd1JmQmNXRkNkb2NoNlFlaTVaWWwrSm5nWHlpa0MyVC92TnA3Nk9a?=
 =?utf-8?B?R0Izc25OcXAzWnd0ZHB0NWF0cFlHVEkvZzBVeWl6T0YrQUVndVJHK2Q5T0pH?=
 =?utf-8?B?TEhxVDVyalcraE52ZklPR1Rxd0EvanJnZXQ1NzdYbjdic212VmV3aWtsZ2Ri?=
 =?utf-8?B?aGJGa3J3OTZ1YWNyZERVS3RyWDlCZUxnZ2J3Z2d4OHkrS3pubmRtZVozbmhn?=
 =?utf-8?B?dHhCWWxMODcyVkNXK1RhQW9iYVh3MTM1ZlMvNDdEQWJRdFNkK3dISkovQXA3?=
 =?utf-8?B?VVlKTS94cXRXek4zRVFiSUI2NmVTWSszTkF0S2gzaEUwOWpKS0s0SFltSFE1?=
 =?utf-8?B?eGZJL1hYR0J0d1NGVDdycW9mTTEwZldnZEdHSkhmTFdacnFPa2RYUk0wdkt0?=
 =?utf-8?B?dTBkQzhtSWx0SHdVUUUvMW5ZTlRRaitNcEdld3BqTFZsdmQxYlp1L1REVlhV?=
 =?utf-8?B?bFN2SmZwUFpub1drUW03VEtDMVBnQkF4cjdMVVUremdxU2N1VlMwWWlySUdL?=
 =?utf-8?B?Z3A2MGVSVklMRFpSNnVoWlRBTGlGeHd0Vi9MbWk1QkI3ZkxIZW1ieC91TUE4?=
 =?utf-8?B?UWU1SDN1bTgvd1l0ajU4VW1hQUxxMHRjNUo1djMrQXliZzhPeHBoOEdQK0Jk?=
 =?utf-8?B?ZHBsRnpKMDJ6TGhEaXFEeFl4MklWSzBVMkFzOXRhQ3BIbkx0OThJZzlXYVk1?=
 =?utf-8?B?SG5Pc0grSjVJTk5Qc1ZITDFyUzhlVzhkM3VrN2dISVJLNlUwcFRQUjJld3cr?=
 =?utf-8?B?eVpYUGZCK1hzWFBTbW5WaFkrbktoVHdYN0ZZWVp4NHJlWTdyYXQyK3kzZGl3?=
 =?utf-8?B?bW1yTmNsZVN1UnBpaUoxTGlRWXhvT2NiTTlnT2pWc21qRE1SUE1nbG9rMms1?=
 =?utf-8?B?R2ZIemVYbVRFUldOZG1RT25pUXlVUy9JSVIrRUlEMlVMWU0zSWxLY3Z2Zis1?=
 =?utf-8?B?RUgwbHBiSUsrMTZVRFkwYXVGODZoeVprTFVUcVJMZFdlOFFGNFF5amlRVElp?=
 =?utf-8?B?VW5vVmlkWVJJK3l0VnhoK3l5QW55YlZjZy81WHZKU1dNd2ovVkRsVlNrVnJ5?=
 =?utf-8?B?bjBuemovRFM3Q21WOUtXdE1GODhzTjJLbzlFSy9UejhuQ2hWSDdoNXZuSWJ1?=
 =?utf-8?B?RGFMMFR0L2VNVGsvSERwSitNUUlVTWRwZmFpWnVaMHFBTU5OZENGVUtpbUV4?=
 =?utf-8?B?OC9IdDF1RWt5N3RmeS9maG9oY0VXNFdmdFdqUVV6RDlocGoxdDNrZEZhUXBw?=
 =?utf-8?B?bWJzZVBVQVFzTXA1bnhEdnZwTHJRVytoczYzQzhVc2RZK0paQnJCYzJZeUc2?=
 =?utf-8?B?QzB3YVZTSEREM3FyZXRZL1l4NW5hQmlRcWZNclJMc2Q0TWdYOWFXR1A4UEZ0?=
 =?utf-8?B?NG03ampzdW9Hc1pXUk5IRE1WT0thY3ZhRk5JenVKS09PdytsNUpVYzQzUytT?=
 =?utf-8?B?bXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d98e80c2-2c17-4890-f7c5-08dc2c8873cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 11:39:34.9200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBPuG+W61YoAbPAT0+ywFgUME56v+iLsif59MvMsw6TegtP9vGt45knBn4Etp+WteuOxMilq5nDIfRsomvo6oGe6Hai6RpesSN81IoHkP/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8226

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBUdWVzZGF5LCBG
ZWJydWFyeSAxMywgMjAyNCAxMTowNyBBTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0
IHYzIDUvNl0gbmV0OiByYXZiOiBEbyBub3QgYXBwbHkgZmVhdHVyZXMgdG8NCj4gaGFyZHdhcmUg
aWYgdGhlIGludGVyZmFjZSBpcyBkb3duDQo+IA0KPiBIaSwgQmlqdSwNCj4gDQo+IE9uIDEzLjAy
LjIwMjQgMTI6MTMsIEJpanUgRGFzIHdyb3RlOg0KPiA+DQo+ID4gSGkgQ2xhdWRpdSwNCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDbGF1ZGl1IDxjbGF1
ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDEzLCAy
MDI0IDk6NDEgQU0NCj4gPj4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0IHYzIDUvNl0gbmV0OiBy
YXZiOiBEbyBub3QgYXBwbHkgZmVhdHVyZXMgdG8NCj4gPj4gaGFyZHdhcmUgaWYgdGhlIGludGVy
ZmFjZSBpcyBkb3duDQo+ID4+DQo+ID4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJl
em5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4NCj4gPj4gRG8gbm90IGFwcGx5IGZlYXR1cmVz
IHRvIGhhcmR3YXJlIGlmIHRoZSBpbnRlcmZhY2UgaXMgZG93bi4gSW4gY2FzZQ0KPiA+PiBydW50
aW1lIFBNIGlzIGVuYWJsZWQsIGFuZCB3aGlsZSB0aGUgaW50ZXJmYWNlIGlzIGRvd24sIHRoZSBJ
UCB3aWxsDQo+ID4+IGJlIGluIHJlc2V0IG1vZGUgKGFzIGZvciBzb21lIHBsYXRmb3JtcyBkaXNh
YmxpbmcgdGhlIGNsb2NrcyB3aWxsDQo+ID4+IHN3aXRjaCB0aGUgSVAgdG8gcmVzZXQgbW9kZSwg
d2hpY2ggd2lsbCBsZWFkIHRvIGxvc2luZyByZWdpc3Rlcg0KPiA+PiBjb250ZW50cykgYW5kIGFw
cGx5aW5nIHNldHRpbmdzIGluIHJlc2V0IG1vZGUgaXMgbm90IGFuIG9wdGlvbi4NCj4gPj4gSW5z
dGVhZCwgY2FjaGUgdGhlIGZlYXR1cmVzIGFuZCBhcHBseSB0aGVtIGluIHJhdmJfb3BlbigpIHRo
cm91Z2gNCj4gcmF2Yl9lbWFjX2luaXQoKS4NCj4gPj4NCj4gPj4gVG8gYXZvaWQgYWNjZXNzaW5n
IHRoZSBoYXJkd2FyZSB3aGlsZSB0aGUgaW50ZXJmYWNlIGlzIGRvd24NCj4gPj4gcG1fcnVudGlt
ZV9hY3RpdmUoKSBjaGVjayB3YXMgaW50cm9kdWNlZC4gQWxvbmcgd2l0aCBpdCB0aGUgZGV2aWNl
DQo+ID4+IHJ1bnRpbWUgUE0gdXNhZ2UgY291bnRlciBoYXMgYmVlbiBpbmNyZW1lbnRlZCB0byBh
dm9pZCBkaXNhYmxpbmcgdGhlDQo+ID4+IGRldmljZSBjbG9ja3Mgd2hpbGUgdGhlIGNoZWNrIGlz
IGluIHByb2dyZXNzIChpZiBhbnkpLg0KPiA+Pg0KPiA+PiBDb21taXQgcHJlcGFyZXMgZm9yIHRo
ZSBhZGRpdGlvbiBvZiBydW50aW1lIFBNLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+IC0tLQ0K
PiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHYzOg0KPiA+PiAtIHVwZGF0ZWQgcGF0Y2ggdGl0bGUgYW5k
IGRlc2NyaXB0aW9uDQo+ID4+IC0gdXBkYXRlZCBwYXRjaCBjb250ZW50IGR1ZSB0byBwYXRjaCA0
LzYNCj4gPj4NCj4gPj4gQ2hhbmdlcyBpbiB2MjoNCj4gPj4gLSBmaXhlZCB0eXBvIGluIHBhdGNo
IGRlc2NyaXB0aW9uDQo+ID4+IC0gYWRqdXN0ZWQgcmF2Yl9zZXRfZmVhdHVyZXNfZ2JldGgoKTsg
ZGlkbid0IGNvbGxlY3QgdGhlIFNlcmdleSdzIFJiDQo+ID4+ICAgdGFnIGR1ZSB0byB0aGlzDQo+
ID4+DQo+ID4+IENoYW5nZXMgc2luY2UgWzJdOg0KPiA+PiAtIHVzZSBwbV9ydW50aW1lX2dldF9u
b3Jlc3VtZSgpIGFuZCBwbV9ydW50aW1lX2FjdGl2ZSgpIGFuZCB1cGRhdGVkIHRoZQ0KPiA+PiAg
IGNvbW1pdCBtZXNzYWdlIHRvIGRlc2NyaWJlIHRoYXQNCj4gPj4gLSBmaXhlZCB0eXBvcw0KPiA+
PiAtIHMvQ1NVTS9jaGVja3N1bSBpbiBwYXRjaCB0aXRsZSBhbmQgZGVzY3JpcHRpb24NCj4gPj4N
Cj4gPj4gQ2hhbmdlcyBpbiB2MyBvZiBbMl06DQo+ID4+IC0gdGhpcyB3YXMgcGF0Y2ggMjAvMjEg
aW4gdjINCj4gPj4gLSBmaXhlZCB0eXBvcyBpbiBwYXRjaCBkZXNjcmlwdGlvbg0KPiA+PiAtIHJl
bW92ZWQgY29kZSBmcm9tIHJhdmJfb3BlbigpDQo+ID4+IC0gdXNlIG5kZXYtPmZsYWdzICYgSUZG
X1VQIGNoZWNrcyBpbnN0ZWFkIG9mIG5ldGlmX3J1bm5pbmcoKQ0KPiA+Pg0KPiA+PiBDaGFuZ2Vz
IGluIHYyIG9mIFsyXToNCj4gPj4gLSBub25lOyB0aGlzIHBhdGNoIGlzIG5ldw0KPiA+Pg0KPiA+
Pg0KPiA+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVuZXNhcy9yYXZiX21haW4uYyB8IDE2ICsr
KysrKysrKysrKy0tLS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvcmVuZXNhcy9yYXZiX21haW4uYw0KPiA+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlbmVz
YXMvcmF2Yl9tYWluLmMNCj4gPj4gaW5kZXggYjNiOTE3ODNiYjdhLi40ZGQwNTIwZGVhOTAgMTAw
NjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlbmVzYXMvcmF2Yl9tYWluLmMN
Cj4gPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVuZXNhcy9yYXZiX21haW4uYw0KPiA+
PiBAQCAtMjU2NiwxNSArMjU2NiwyMyBAQCBzdGF0aWMgaW50IHJhdmJfc2V0X2ZlYXR1cmVzKHN0
cnVjdA0KPiA+PiBuZXRfZGV2aWNlICpuZGV2LCAgew0KPiA+PiAgCXN0cnVjdCByYXZiX3ByaXZh
dGUgKnByaXYgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gPj4gIAljb25zdCBzdHJ1Y3QgcmF2Yl9o
d19pbmZvICppbmZvID0gcHJpdi0+aW5mbzsNCj4gPj4gLQlpbnQgcmV0Ow0KPiA+PiArCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwcml2LT5wZGV2LT5kZXY7DQo+ID4+ICsJaW50IHJldCA9IDA7DQo+
ID4+ICsNCj4gPj4gKwlwbV9ydW50aW1lX2dldF9ub3Jlc3VtZShkZXYpOw0KPiA+PiArDQo+ID4+
ICsJaWYgKCFwbV9ydW50aW1lX2FjdGl2ZShkZXYpKQ0KPiA+PiArCQlnb3RvIG91dF9zZXRfZmVh
dHVyZXM7DQo+ID4NCj4gPiBUaGlzIGNhbiBiZSBzaW1wbGlmaWVkLCB3aGljaCBhdm9pZHMgMSBn
b3RvIHN0YXRlbWVudCBhbmQgVW5uZWNlc3NhcnkNCj4gPiByZXQgaW5pdGlhbGl6YXRpb24uIEkg
YW0gbGVhdmluZyB0byB5b3UgYW5kIFNlcmdleS4NCj4gPg0KPiA+IAlpZiAoIXBtX3J1bnRpbWVf
YWN0aXZlKGRldikpDQo+ID4gCQlyZXQgPSAwOw0KPiA+IAllbHNlDQo+ID4gCQlyZXQgPSBpbmZv
LT5zZXRfZmVhdHVyZShuZGV2LCBmZWF0dXJlcyk7DQo+ID4NCj4gPiAJcG1fcnVudGltZV9wdXRf
bm9pZGxlKGRldik7DQo+ID4gCWlmIChyZXQpDQo+ID4gCQlnb3RvIGVycjsNCj4gPg0KPiA+IAlu
ZGV2LT5mZWF0dXJlcyA9IGZlYXR1cmVzOw0KPiA+DQo+ID4gZXJyOg0KPiA+IAlyZXR1cm4gcmV0
Ow0KPiA+DQo+IA0KPiBJIGZpbmQgaXQgYSBiaXQgZGlmZmljdWx0IHRvIGZvbGxvdyB0aGlzIHdh
eS4NCg0KSSBmaW5kIHRoaXMgcGF0Y2ggY29tcGxpY2F0ZWQgYnkgZG9pbmcgdW5uZWNlc3Nhcnkg
aW50aWFpbHphdGlvbg0KQW5kIGdvdG8gc3RhdGVtZW50cyBmb3Igbm9uLWVyciBjYXNlcy4uIA0K
DQpNYXliZSBvdGhlcnMgY2FuIHN1Z2dlc3QgaG93IHRvIGRvIGl0IGluIGEgYmV0dGVyIHdheS4g
DQoNCkNoZWVycywNCkJpanUNCj4gDQo+IFRoYW5rIHlvdSwNCj4gQ2xhdWRpdSBCZXpuZWENCj4g
DQo+ID4gQ2hlZXJzLA0KPiA+IEJpanUNCj4gPg0KPiA+Pg0KPiA+PiAgCXJldCA9IGluZm8tPnNl
dF9mZWF0dXJlKG5kZXYsIGZlYXR1cmVzKTsNCj4gPj4gIAlpZiAocmV0KQ0KPiA+PiAtCQlyZXR1
cm4gcmV0Ow0KPiA+PiArCQlnb3RvIG91dF9ycG1fcHV0Ow0KPiA+Pg0KPiA+PiArb3V0X3NldF9m
ZWF0dXJlczoNCj4gPj4gIAluZGV2LT5mZWF0dXJlcyA9IGZlYXR1cmVzOw0KPiA+PiAtDQo+ID4+
IC0JcmV0dXJuIDA7DQo+ID4+ICtvdXRfcnBtX3B1dDoNCj4gPj4gKwlwbV9ydW50aW1lX3B1dF9u
b2lkbGUoZGV2KTsNCj4gPj4gKwlyZXR1cm4gcmV0Ow0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlX29wcyByYXZiX25ldGRldl9vcHMgPSB7DQo+ID4+
IC0tDQo+ID4+IDIuMzkuMg0KPiA+DQo=

