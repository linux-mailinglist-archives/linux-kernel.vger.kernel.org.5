Return-Path: <linux-kernel+bounces-57707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390384DC9C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84FF1F259A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75406BFA9;
	Thu,  8 Feb 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="M3UMH9BU"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2088.outbound.protection.outlook.com [40.107.114.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DC6BB20;
	Thu,  8 Feb 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383816; cv=fail; b=RTzZ0Pu/eC3L2jnErZhw26ADRexdgzgw22k7zqVMxDjmb6Oa9QfDC/zfaxjFV5lMtM8UycUxJTa4/iqQvhgZnsmgVLRsEl+DO3D9fsGoSMHIu01DyP/1tZtphg1e0eZyxMfaWDicyLkoZ26I40cJUAr2jax+xu5fAnfwJoCKmcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383816; c=relaxed/simple;
	bh=S5YWQUaTx3BbzfT9Hu1VMwgf9RDki99mdGl9mPxlKcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X+yAeqhAsn3DXUaH7bH7HoZe0YmeutILNIix1shqOiUnZhbPywWgGo/Z9VSJdNS35aptOKX6HrFgnqGj/igDQMpVNzT1LluY780/5Ic6koYVo0tEsSpsEb27yw3JRS+WtnGzbVTlZcJ6YefwjIAef4e4+EIDplFTI8XpUQWBaXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=M3UMH9BU; arc=fail smtp.client-ip=40.107.114.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaC5sOs1wX1eTQ5Pl6jTnxU+8ImL6gt11FczUOhXPeLqVhiEzwu+EK8vXZ21IJWUCX9sCF+b05BeO14zddOLtatsW34C9Jliu65ZkoYCpT9pbTeRL9f601FXfPUT4xBxlfNrxep0SxqZLaYnXjwuN5JSbcfKwiQcv/anPFFWfw5VN6+zJDqaj6ZmeCInj8tGRZzdwdt3ZoyKBDk8vTa3bruontMyJP3CDh3TGmP3QXHOWx91YNt5ZWgPQ2Xb6QenO62J74eiJ2iJrB2XH41G6teZ5giJUJBmJycJBvPnxrjIvWQ6pHb4Psg0KOMUvtskvn+eE1Gg47+5HE1DQvrqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5YWQUaTx3BbzfT9Hu1VMwgf9RDki99mdGl9mPxlKcQ=;
 b=i7SR+fK/mRGd7SeKlzchbbWKNlVqt5ywrsIffHRMrVU3dnaFBXpYJ98DEX6LAOq2dD6TdqEim+dNYWUPtNcvOhsh0oDSKSJ/hqL6SiPbzxh3KqCGn4hz0Sj/8RxpzHrcnhZDgqFqPNc6aOPkolZvYRGi5KS6fnWncMv7kMVjhsznE/oYGYDBu5bDsZHp77WJbV9eklff31OD7DhEWhi0rLhv9ennvlWAOWHJuHjMhz15gwPmJEi5Aed92qg6bVfoVhSeMICyUvPEU5J3aB4GC1lNKcB4CYeahPZZ52uRFk0DiYlqmEaAjhD2sv4gy8BBQLpcUDsh2z8gqu0wPwCaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5YWQUaTx3BbzfT9Hu1VMwgf9RDki99mdGl9mPxlKcQ=;
 b=M3UMH9BUVmK5PfFfcczwUKHLIlMMKn2ZDm5uURsaUtE/iLc/RYe47q6jkODSUx2nAd1b0MQqvpsotjQSVZnvI33zg58bw0MbKdAT0+g1+AfVaC7K7XnBUxw47ug+AVsxU07qu1v1kMapuiUcMfzn6r3SHrY9te9tAZpRSEkOILY=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB9653.jpnprd01.prod.outlook.com
 (2603:1096:400:221::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 09:16:49 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 09:16:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH net-next 4/5] net: ravb: Do not apply RX checksum settings
 to hardware if the interface is down
Thread-Topic: [PATCH net-next 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
Thread-Index: AQHaWb7W3Y46Kl0YW0WfSZ+OQ75oxrD/WwQAgAC8JeCAABOZEA==
Date: Thu, 8 Feb 2024 09:16:49 +0000
Message-ID:
 <TYCPR01MB11269E26FB82028FEA885F46486442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
 <20240207120733.1746920-5-claudiu.beznea.uj@bp.renesas.com>
 <82a95cae-29bc-06c1-0fab-5fa6302b4654@omp.ru>
 <TYCPR01MB11269D8AEFA0E34230195057D86442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB11269D8AEFA0E34230195057D86442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB9653:EE_
x-ms-office365-filtering-correlation-id: 674a4eda-43af-41ff-da23-08dc2886ae77
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rbwamvBfc/qzrkvVva4TkepMEJZ7+4Gt4WvvNFYqWcU8LI5Zj4LFrRpaobEm+9a6skTD8iaz7w53ltDrY85GGUF42sUIx6SHAgYvXnB43PU10drugeR48+9vUIxZkcn4EaJxTPCLrWsKlGGmSBnMY0jn4Fwh65vHXhpa8exhlFJIGuaaRBBw150b2WkUwxwTHrZW9oHX6yg3z97AYYYFpGOwzxZUhLtG+bXYqmjGnds+85bHSr8UL/427TgsfBAB1Lds7F8MJcVPjlKSrrw66OaNTKWt146Z2NFRSfmfYZdx8h3V26tE4jGWy0YUkmeC/yEq9yIHN5svlX3+9vu3JxpO7X6TDdD97CG38MvmNEJX1BeGRMPi+z1ravQpOqDHXagDLWUZdmkRfSjaqHph4Z64Xfr1unSLbCeWgO23iBs6XryV1K4llO/dWUZIwXn41n4EUEVkHlVtat89EltBpjuXqEwh4exQaT79zucA+BkhXC5MI2nM1qra2qxYgHEAFNqElRlpGBV3zcjZKN8jf3R4DbMjcmAbveDPPzKa/w3KtiYZaUg7CkMis2meF/+0AYskl0KIyy37Nt1WLLo/PQFElpc+t0h4UYYMY3XzTdMtk03IK2TDOd7Xy3pYezkS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(52536014)(2906002)(55016003)(41300700001)(107886003)(83380400001)(122000001)(38100700002)(26005)(86362001)(7696005)(76116006)(8936002)(9686003)(71200400001)(8676002)(478600001)(110136005)(54906003)(38070700009)(53546011)(64756008)(66446008)(66556008)(66476007)(66946007)(316002)(2940100002)(6506007)(4326008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTZqZ0l3TDM3V3R1M3RQRWRuZUcrSDMweEdRQXU1a3lwRFJHM3lBMkp1eEc4?=
 =?utf-8?B?OUp0OTJwV3pzY3pBenF4Y3djcjI0UjZCVEFrUmFpSmVLdjljSmpldXpJZUFO?=
 =?utf-8?B?YXhSTWIwTFVLSFp1NUloa1ZoK1ZRZmxKZVE2NGpDOXJLUDFKeENPc284VW14?=
 =?utf-8?B?RXBvb1MvN2xGUnY4bGh2M2lXd09GSnJwVmhJSGx4VVovYUlGbWJaWFlCZnBl?=
 =?utf-8?B?T2RuSEROYTBSaVZLczBNeTJTQlNpaVQvQjRIbVZYL3VtYTNMOGhnYkNTUG1i?=
 =?utf-8?B?RHlkejk5QVZ0N1RSRWRNdnZzakhKZFpXVERISUV4MnZlOTNVRldtdUZETXFQ?=
 =?utf-8?B?VXF2WHM2SVE1YTFmd3RpNUFzTVNIdTRydkM0QlJINTVMRHJZU1hrZUFlWXIr?=
 =?utf-8?B?OWlibjV0SndpVEhnelJwSVI0L3VXRFlvRkVHbzVMTlNTbHJ6NGNHMFYveUZG?=
 =?utf-8?B?Y2lqVXVuQ0hmQ0tiWitoYS9XbFYyOTJTR3lPa0YvWmdlN1c0V1dYSko5VnNn?=
 =?utf-8?B?ZTF4VGc4NVBlM3A3d0loRlhWUER5QnU2eEEwVkdLaFhWT2xnRUhPbk1JdVlK?=
 =?utf-8?B?QndxeW56dlJIK2JsMHNZMDA3VHcwdDkrU1hmUHk5dWtPaTRlL21PanhjcmIx?=
 =?utf-8?B?ZUpqYS9aQlVRRENwUzF3WmRWMi9mZGNFZ2xjV1NmTFhWMWgweEFGRHVjV2RG?=
 =?utf-8?B?U2ZxdUNOaFE2c090bnVPRzFGV0J2N2QzOUhuT1YzOTgrY0R3aG1mcjQ3NWo2?=
 =?utf-8?B?UHN1cDBLcy9scWMrMWYxOXRHNzhyVzczZzBadFZHUGxjMlRrcjYxTjFhZmRI?=
 =?utf-8?B?bCtPZUhnYk91TFVFaWswSXlwKzQxNWZlYmlQR1RybHFXUUtvbVlkZTdRcnFj?=
 =?utf-8?B?Z3Y0MjRoTDY3dHlLbXYrVmFYeHNOTXQ5ZWhSRDhXUFlOYXhSSXdoK0ZVWllU?=
 =?utf-8?B?aHN4VVQ0Si9UMFJnMjl0S0p1UERhUTRhNXQyeWFXWWF0b0svU2ZLZy9tNlJQ?=
 =?utf-8?B?NTJPMjJUSzNqVUlRWk9BOUpEQWRjbU1TeXV3ZHFkVUJrcTd1UDFSS05JUDdl?=
 =?utf-8?B?RkZiMnNWT3llTHhhK244S0MrTXNLaHdYTktNM1lmZUpZaUM2OTRUbFZ0blcr?=
 =?utf-8?B?Q21yN0lxTE9xTU5NQzNKN0twYVV5NmpTQTVtYk5tZTVDWm84RUc1citETWla?=
 =?utf-8?B?YU9rRGwyWmtCUC9ZWE1PVFZtQ2ZtbDBUQnVSQ0FacXppd293Z3BQK0EyTWg0?=
 =?utf-8?B?YUVBN1JQb2FPZUNEVTdzRWI3RFgzVlVkSnpGT2IveC9NVDBJZ1dlczF0U3ND?=
 =?utf-8?B?bFRTSHVKR3BXM3V1ODEzWmVuSTQ5U1ZjQTB0RTV5RU5KT2J6UEM4dG9ZUnpp?=
 =?utf-8?B?cjNKVXRDeWZWZnpmdFBXMStpUWNQckZuYXE1aUJwbEVISm1RSU4rTjAvaTVL?=
 =?utf-8?B?U1ltNFJJZEpDYVhzbUpyNENOa3BQVUlndXhlK3JmS25mTmhBcElIZVB2OU9J?=
 =?utf-8?B?Y3lCT3dNTlUwV0pKMUhLTlJVZjhnenlLY2FiekJhVkZnZzdWRG1xNmRnc2ZR?=
 =?utf-8?B?QUV6Qm80M1Rxb2FuZzdteTlMZW55WjhCUU9FRG54eEk4cHFyNTJJUnp5dzFh?=
 =?utf-8?B?ZmUrbndrT3QvcWU2NFVMc080ZXJ0R0ZMZVFOelBGNFVUWHNVUXNXcmNjWW1F?=
 =?utf-8?B?OThyZlVMVmJ0a2tkUk1NLzBWL0NMeEtIT2dZYWxnem5CdWpzckhLeHJhd1FZ?=
 =?utf-8?B?Wk5aZWtKKzNIWVVuUGRnYUNMLzlndnFZclB0amR2TlpEUVM0YUVSU0hUQTVS?=
 =?utf-8?B?MlJIcmhFNkt2SzFkMkgybk9GUjlkZXJYTHk4aWcwSmFFVFllUi93dm1KSmN1?=
 =?utf-8?B?eC9NOHNNcTZUSjhyemVTVndkeFh1eVkzTEwvS3U4K3hQcVhkRU9QOHlqQkJS?=
 =?utf-8?B?K3BpNkJJSS9BRGdIL1BkN2hGUXFmTzV1WXdtTmVnVUhGUm94UlloWEd0MGw1?=
 =?utf-8?B?bytBdG91WjViQThmdmdUK08wU0JpM0lOb2pNRWxkTVp1RzYxanltSmlCYmg3?=
 =?utf-8?B?c3RxY2Y2ZTQvM0lPYnBpd0s3dFUrSHdhMnp3RGRhMGFEUnRHNHVwcmRIaWZG?=
 =?utf-8?Q?AiVDgVHQf0K9DL3KzQnYFIVTg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 674a4eda-43af-41ff-da23-08dc2886ae77
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 09:16:49.7191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbmG8YuzUeYiRgXZzNPzLQyiYy++V7zAQthT/7xRpV75TBbXs1BDjDOeexcv8M3JtSyQqAucXMjduCi5s2vCDazbLk0Aq5RJrqpSEehYCCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9653

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgOCwgMjAy
NCA4OjA5IEFNDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggbmV0LW5leHQgNC81XSBuZXQ6IHJhdmI6
IERvIG5vdCBhcHBseSBSWCBjaGVja3N1bQ0KPiBzZXR0aW5ncyB0byBoYXJkd2FyZSBpZiB0aGUg
aW50ZXJmYWNlIGlzIGRvd24NCj4gDQo+IEhpIFNlcmdleSwNCj4gDQo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBTZXJnZXkgU2h0eWx5b3YgPHMuc2h0eWx5b3ZAb21w
LnJ1Pg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgNywgMjAyNCA4OjUwIFBNDQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCA0LzVdIG5ldDogcmF2YjogRG8gbm90IGFwcGx5
IFJYIGNoZWNrc3VtDQo+ID4gc2V0dGluZ3MgdG8gaGFyZHdhcmUgaWYgdGhlIGludGVyZmFjZSBp
cyBkb3duDQo+ID4NCj4gPiBPbiAyLzcvMjQgMzowNyBQTSwgQ2xhdWRpdSB3cm90ZToNCj4gPg0K
PiA+ID4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMu
Y29tPg0KPiA+ID4NCj4gPiA+IERvIG5vdCBhcHBseSB0aGUgUlggY2hlY2tzdW0gc2V0dGluZ3Mg
dG8gaGFyZHdhcmUgaWYgdGhlIGludGVyZmFjZQ0KPiA+ID4gaXMNCj4gPiBkb3duLg0KPiA+ID4g
SW4gY2FzZSBydW50aW1lIFBNIGlzIGVuYWJsZWQsIGFuZCB3aGlsZSB0aGUgaW50ZXJmYWNlIGlz
IGRvd24sIHRoZQ0KPiA+ID4gSVAgd2lsbCBiZSBpbiByZXNldCBtb2RlIChhcyBmb3Igc29tZSBw
bGF0Zm9ybXMgZGlzYWJsaW5nIHRoZSBjbG9ja3MNCj4gPiA+IHdpbGwgc3dpdGNoIHRoZSBJUCB0
byByZXNldCBtb2RlLCB3aGljaCB3aWxsIGxlYWQgdG8gbG9zaW5nDQo+ID4gPiByZWdpc3RlcnMN
Cj4gPiA+IGNvbnRlbnQpIGFuZA0KPiA+DQo+ID4gICAgVGhlIHJlZ2lzdGVyIGNvbnRlbnRzPyBJ
IHRob3VnaHQgSSdkIHBvaW50ZWQgb3V0IGFsbCBvZiB0aGVzZS4uLg0KPiA+DQo+ID4gPiBhcHBs
eWluZyBzZXR0aW5ncyBpbiByZXNldCBtb2RlIGlzIG5vdCBhbiBvcHRpb24uIEluc3RlYWQsIGNh
Y2hlIHRoZQ0KPiA+ID4gUlggY2hlY2tzdW0gc2V0dGluZ3MgYW5kIGFwcGx5IHRoZW0gaW4gcmF2
Yl9vcGVuKCkgdGhyb3VnaA0KPiA+IHJhdmJfZW1hY19pbml0KCkuDQo+ID4gPiBUaGlzIGhhcyBi
ZWVuIHNvbHZlZCBieSBpbnRyb2R1Y2luZyBwbV9ydW50aW1lX2FjdGl2ZSgpIGNoZWNrLiBUaGUN
Cj4gPiA+IGRldmljZSBydW50aW1lIFBNIHVzYWdlIGNvdW50ZXIgaGFzIGJlZW4gaW5jcmVtZW50
ZWQgdG8gYXZvaWQNCj4gPiA+IGRpc2FibGluZyB0aGUgZGV2aWNlIGNsb2NrcyB3aGlsZSB0aGUg
Y2hlY2sgaXMgaW4gcHJvZ3Jlc3MgKGlmIGFueSkuDQo+ID4gPg0KPiA+ID4gQ29tbWl0IHByZXBh
cmVzIGZvciB0aGUgYWRkaXRpb24gb2YgcnVudGltZSBQTS4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+
DQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogU2VyZ2V5IFNodHlseW92IDxzLnNodHlseW92QG9tcC5y
dT4NCj4gPg0KPiA+ICAgIEknbSBhZnJhaWQgc3VjaCBjaGVjayBub3cgbmVlZHMgdG8gYmUgYWRk
ZWQgdG8NCj4gPiByYXZiX3NldF9mZWF0dXJlc19nYmV0aCgpIHRoYXQncyBwb3B1bGF0ZWQgYnkg
QmlqdSBEYXMnIGNoZWNrc3VtDQo+ID4gcGF0Y2hlcyAod2hpY2ggSSd2ZSBhbHJlYWR5IEFDS2Vk
KS4uLg0KPiANCj4gWW91IG1lYW4gdGhpcyBjaGVjayB0byBiZSBtb3ZlZCB0byByYXZiX3NldF9m
ZWF0dXJlc19yY2FyKCkgaW5zdGVhZCBvZg0KPiByYXZiX3NldF9yeF9jc3VtKCkgYXMgcmF2Yl9z
ZXRfcnhfY3N1bSgpIGlzIGNhbGxlZCBpbiByZWNlaXZlIHBhdGggYXMgd2VsbA0KPiB3aGljaCBp
cyBpbnRlcmZhY2UgdXAgY2FzZS4NCj4gT04gcmVzZXQgbW9kZSwgYW55d2F5IHdlIGRvbid0IGdl
dCBhbnkgaW50ZXJydXB0cyBzbyB0aGVyZSBpcyBubyByeC4NCj4gVGhlbiBwb3NzaWJpbGl0eSBp
cyB0aHJvdWdoIHNldF9mZWF0dXJlcz8/DQoNCg0KT3IgYXJlIHlvdSBzdWdnZXN0aW5nIHRvIGhh
dmUgYSBjb21tb24gY29kZSB0byBhdm9pZCBjb2RlIGR1cGxpY2F0aW9uPw0KDQpPbiBpbnRlcmZh
Y2UgZG93biBjYXNlLCBqdXN0IGNhY2hlIHRoZSBmZWF0dXJlIGFuZCByZXR1cm4/DQoNCkFjdGl2
ZSBjYXNlcywgY2FsbCB0aGUgZmFtaWx5IHNwZWNpZmljIGNhbGxiYWNrKCk/DQoNCkNoZWVycywN
CkJpanUNCg==

