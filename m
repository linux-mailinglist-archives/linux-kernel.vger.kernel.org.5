Return-Path: <linux-kernel+bounces-37940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974483B89C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3351F2487B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55A479D9;
	Thu, 25 Jan 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YjmlsaEi"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973D79C1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706156490; cv=fail; b=BzLQewGBBFD2VZJEvujUsmYPVtw04oUk3AgT1oss1d1WL+c+zfj6fZjbjmp7FelRpGHaRhOXa8SXlpKlH/U7h6SmzxGZzU9P/7PTpECGjf0owGyuIU5lJHepr2ZoJYRUXH481luzvNM4sb6yFOdUn4FFA/edD8w9U1gM94xIBgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706156490; c=relaxed/simple;
	bh=NetMEujPHDGoiQU8GIcxU0FhVc2/L74wIIiw6di2Ng8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HhB5kr767x704zXx1TIuP2mOlD9HmyhqB11iboVe3QKyGO2kajFFqxs7LXrX6K5RiOmQxsqiVwY4vk4fSs1o7SYDmo/aQtDfqZK08Fgnr50JsDfzS/q1hfWvahEBIfrXXuoarvlZDo2KTnspQWAAGNQ2pw0PGkyaVKIMpJN/15s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YjmlsaEi; arc=fail smtp.client-ip=40.107.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jowRCZVKu10Tb124jTaMKiKimcYzSnUMf9EIHmRWNDTt3gnVr9BHOqQ/rVnD791ywwnt8yeu2p97l+FOV+4TTx+H6Kb+zqZ/npFTqAldW7HOSPh5/ls04Wsjqeet3HmcL+4V69IHxrESjFSvCzUqJb4RaLk34IQJsWhwPgBgyxV7enIb91BMnzwR0uDRnggt5wJ9TeYeuh0EWU17PDOju0H8wjUstAXHbObdk2jCt0k0B8erXUZn7S43YAqY+PPKErg91LOY2ekmXefYKaECBlbAcAAfiuPb30ldcnP/sdM3bvQFfTJsL7w656SdtWWKZVdh0KG+DebBmH+QudyqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NetMEujPHDGoiQU8GIcxU0FhVc2/L74wIIiw6di2Ng8=;
 b=X+r2x5vTGU4tRM7MzHjTowkUxTF6ktnZItS8FutGf+x/8Wu/xAcle3qp4fuLQL6oDkfDyboJEgJkLCgz4hf8FF6NRKqOUeAOZVvY3tMc+0qaOobHpypJC+S44XyfMtl7rJ4ZAQyEt4xXHeZp90J5nLIHb7U/382diq4UhDTqJVVfmBcIJtBseh3EINbuQANZZlf6jzk6OCYaF/ARdOqPoHzgFXnYskomZk/zdHYS1yJTavmGXfj5jvCtzzftQALOcbNI0RyVSnCZpiF3oUungRINLCwmsVadFnrz1+4/x95xMdWCdqajODipralRDPsx6mJURSZmfCMs/TcdiDwg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NetMEujPHDGoiQU8GIcxU0FhVc2/L74wIIiw6di2Ng8=;
 b=YjmlsaEib5A4XMjkr4nJYOE6QLzaxNrJ7Y8kIWAoOSf/gRfNfZLiigX9KwBKN8NbIYWSxje2lQQZIUUpUJnllZ6AQm7zZCGLEBr26ZUTpTvOTfT4IK49sNQgWLiXD1eUK74ayRlH+k8y+RZUWozjIxqUM+dQcVLbXOkXg1AH/+w=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8133.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 04:21:25 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 04:21:25 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Saravana Kannan <saravanak@google.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>
Subject: RE: [EXT] Re: [PATCH] driver core: improve cycle detection on fwnode
 graph
Thread-Topic: [EXT] Re: [PATCH] driver core: improve cycle detection on fwnode
 graph
Thread-Index: AQHaTqDvNrxLtETMdkWiNcCVNGg5zbDp1rEAgAAIJ3A=
Date: Thu, 25 Jan 2024 04:21:24 +0000
Message-ID:
 <DU2PR04MB8822047A07680596415A61358C7A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240124084636.1415652-1-xu.yang_2@nxp.com>
 <CAGETcx9h8gA8EenyR0B0OPa23uw_8dk-Kft8c8+F3StfpyMtaw@mail.gmail.com>
In-Reply-To:
 <CAGETcx9h8gA8EenyR0B0OPa23uw_8dk-Kft8c8+F3StfpyMtaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AS8PR04MB8133:EE_
x-ms-office365-filtering-correlation-id: 4eb8f5be-aad9-4263-b9f3-08dc1d5d17f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5/knV/PqCvGjEENo68lnB15p96eg3/HeuOpcln//x1tnlo9DcJMKJ5443B0MCpM6duQAfxjVyIasbHxWydP2TTGrJfJsyUQ9JRk9VjvWyGhp0ihq0CY9ECv1HnN+dBxtv0WRjh1fy87jClG10eLDjflzZ/VZ3oOOc0qRMkwTtln+XuleXgQW0CeTdBrW32Zjz5D6Phv3XhAisElibyhfbrb/Skwp789BwfjvLjZV89sVz+oeU5JBtaBd9XU3TGYVQrOoNoOVa694zxdUH5dXrA3LgO/gxUdqSAvGKRnrbOe2NMkUgDzLuXl6dp3YO/m7CjSnzS/toDWLd6Zg4LTZimO+i2+ZwCJFwM+TNCqjwmoogWeDgczpdijIRCKey1GrxXHXN1rd0IWmR7SFHO3nxum/qhEgujU2q2sF6yyX0gUDp1fA9U+BVGQ2hmrCSrGn6O6tMEipyTbi626OjXEw/x0Xttj2phYoFL39AHWHzuOSIeqAsZdN6Fn8RswuOHQNFCcjrCg5V+v5/8sV1p9L+hrTrn/HdMB/LUYM/GAUfROMRdp+UfGCKEKcyLvLj2JDCxSnfjxJSN8upev2wJSswUXyTcf5TcTNnqzS5+Y1J34r1fcnpw1oBW0Ietz/jFWd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(52536014)(8676002)(55016003)(122000001)(9686003)(66446008)(86362001)(76116006)(41300700001)(6916009)(83380400001)(38070700009)(2906002)(26005)(478600001)(4326008)(8936002)(53546011)(316002)(66946007)(66556008)(71200400001)(66476007)(33656002)(54906003)(64756008)(6506007)(7696005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDFDK0NtU0hFeEdTS1JWUEZNWnJoZ3RJOVZMYmZMS1ZQbUFOODk0NlZJOWky?=
 =?utf-8?B?UkNFNnlJMzI5cWdMWC90bWhYanNwVFhldkNHdkJmd3dnb1J6RFllL2ZkTmhT?=
 =?utf-8?B?c2ljaGxLU2d1TlA1TUdkMUl0R2FKaTBKOUtFbWZGOWhlSis2cHVLOTlldy8v?=
 =?utf-8?B?TjdsTWRaVThSMmVUajVoQ2FFMFMzMUJaRFp1Z2RsTEwyTHFDZFB5b1RHK2xS?=
 =?utf-8?B?aWt1WlhjbzRoUjRIdHB5VWJZWkQ4NXpGRy9helQ0UXhmRVJSL3dKaGJ5R2Z2?=
 =?utf-8?B?MHl1VjBUSFQ4SXkyUVF3N1ZBbHZPTGZSOVMrd3A3eHQ4YktTNTU5M3NXLzJV?=
 =?utf-8?B?UzRsQ094bXIwMW03cnZDMkNYQmV6M3hYUXlqMThxOWdmVGV4UUFiTU5Zc0lm?=
 =?utf-8?B?ckZTQ09xZGlYU05mLzBXT2svS0pMendXTzBWQ1hnbCtKL3c3OUp3aVBoZHdG?=
 =?utf-8?B?aGpCZ05CV1QvazNxbWgxY2pRYmdkYlpoMTQvYVpwRnh5cDltVnFGSmVUZWFz?=
 =?utf-8?B?TjNjS3BqSUlWOWlPdHNIK2VlMnZzbVdlZHpRc0l4eFZJRURxLzdZLzlmZVRy?=
 =?utf-8?B?QkI5cElQb0FIUkgvR1U2OXpScDJWU3VmbFlMNjNHRVpTbnBPbU9RM1dMa2pO?=
 =?utf-8?B?TTA2d294U2NMc1FlTGhHQU1DVW1mWmRDSnhHb0c5QzNyVTZiQ0laRlBJVjZu?=
 =?utf-8?B?dEFsL3RnTnh5YzgydXh5bGJIbDdVWlNLWXBQL3FUek9rV2lmV0oyZ2tGa2VK?=
 =?utf-8?B?bk9MQitFQVJUYkR3TElBY3d6VExlc09DS1N5dGhxLzR0WlBaK3Q1cTdiRlMr?=
 =?utf-8?B?d1lDemJFclRCanBUNWpTUk5IMU1mOTIrbU9aSzBraVh3VDh2OC9mN3pFbzIr?=
 =?utf-8?B?djNWaXJyTFNWL25obG92UGV2b082bGhDUlRZMElYek5HQ0Y5UmczSld4MTN1?=
 =?utf-8?B?LzZiMDBIL01Rbkd1WHZ6dWV5MXVJelhLN2hCVE94cWo0TzhGNWpMSTZCeUVM?=
 =?utf-8?B?d0w5eDB3VDNaeWRnRGJjek44SDIvcHZQaThseVlHc1pYVFZSMkhCdkQzSFVY?=
 =?utf-8?B?LzhkNTA0S2YvM3ZWc1oybElnMCtmNWhrMVJaL0xENzV1M2NJYlp4NDRWbzJs?=
 =?utf-8?B?bUprTUdwSkN2U3JXbTBWb0dHcXV2QlloUzd2Z2RpdXZORjNKOVV1L3lyY2JB?=
 =?utf-8?B?bDdqN2VWenJ6bXhSTjFxdDlzTHR6Z29ib3A2ZWprL3ZZN2gwcXRxaU5hZW1R?=
 =?utf-8?B?cmE4VTJkZWVpZ2MyRkNiSkI4NERsS1hiOTY4NkNSQVEwWFpJc1R6dnFQaklN?=
 =?utf-8?B?ckdLU2hPVENjSmFwSEtiVlUyaC9IZVlwY05Ddkg0emorWUF2STVOU2pNM3h3?=
 =?utf-8?B?QUFFa0U1aVg4ZHFqVGJjRytCdkpsM3Z6MzN0YmhwMDZNVThqSnozTVc2a1Fn?=
 =?utf-8?B?RXFlVzdmN1VHbkdsUlNnWDZjSG50M0VXeExqd3I3dHJPTi82Ri9obVRsS0t3?=
 =?utf-8?B?STdsaVh4b1AwYVFOd0pVT1ZHNlFRS2Q2MjVheFcvMW5waGpiOTA2bkNwenZQ?=
 =?utf-8?B?a2tUSEFycDQrL3Y4aDZlWE02ZjdtSTQvWUVRYkppcEVDcFNzOVhDS3NWd3B6?=
 =?utf-8?B?cFFqZERRbldOWlBtUTZRYnZ5eVdrcmJoSHBwWWJIN1gxV2ppWEhlVlNEM0Vq?=
 =?utf-8?B?ZTI2bFpydXlsd2JuZ0NHYldTN3ZLaUxaNkc4Rk83d3ZxYzVNd3I3UFNzMUlR?=
 =?utf-8?B?RkRiVEtUN3R4bmxBNDVTcGQ5TG9kNUlYd2FoQ3B2SHhaaDRuanY0ZE9NOVpm?=
 =?utf-8?B?eVp6c2JhWjZ2czAyT01YMzcxUVo2V3A2aUh4UTQzd3VvMlJKMTFJRDBkVTI4?=
 =?utf-8?B?Z0NKK1AxbkZpRllHeTR0eHZoQTAzN1FxZWo3TmxWNEwrbXdPbFVDUFlWTjFD?=
 =?utf-8?B?NGhrclJuRE5wTFlaSjlCOWFUbGczSFJ5OTl4dlM3VnpCZnlocHFMbWFuQzlZ?=
 =?utf-8?B?V0EyNkwvMnlVWFdKTXZoTTc5OHhXcXpjdWVSaTFuNjhNdDdZcUFKNWZBVTFM?=
 =?utf-8?B?a05nM09kQi9aa1NGYWE0ZnI3VGh4Q3IrdVc3Tlhqd0hBcWI4YkZDSW85N0dP?=
 =?utf-8?Q?exF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb8f5be-aad9-4263-b9f3-08dc1d5d17f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 04:21:24.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2/12uR8lSRzyCZ4c+5Sczcx5RJZmCglWmnLhu81sUbKyjnayt8qZ9BDpjd/v193ohO8oIEW21zuPwqBm+qV+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8133

SGkgU2FyYXZhbmEsDQoNCj4gDQo+IE9uIFdlZCwgSmFuIDI0LCAyMDI0IGF0IDEyOjQw4oCvQU0g
WHUgWWFuZyA8eHUueWFuZ18yQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQ3VycmVudGx5LCBj
eWNsZSBkZXRlY3Rpb24gb24gZndub2RlIGdyYXBoIGlzIHN0aWxsIGRlZmVjdGl2ZS4NCj4gPiBT
dWNoIGFzIGZ3bm9kZSBsaW5rIEEuRVAtPkIgaXMgbm90IG1hcmtlZCBhcyBjeWNsZSBpbiBiZWxv
dyBjYXNlOg0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICArLS0tLS0rDQo+ID4gICAgICAgICAg
ICAgICAgICB8ICAgICB8DQo+ID4gICstLS0tLSsgICAgICAgICB8ICArLS18DQo+ID4gIHwgICAg
IHw8LS0tLS0tLS0tLS18RVB8DQo+ID4gIHwtLSsgIHwgICAgICAgICB8ICArLS18DQo+ID4gIHxF
UHwtLS0tLS0tLS0tLT58ICAgICB8DQo+ID4gIHwtLSsgIHwgICAgICAgICB8ICBCICB8DQo+ID4g
IHwgICAgIHwgICAgICAgICArLS0tLS0rDQo+ID4gIHwgIEEgIHwgICAgICAgICAgICBeDQo+ID4g
ICstLS0tLSsgICArLS0tLS0rICB8DQo+ID4gICAgIHwgICAgICB8ICAgICB8ICB8DQo+ID4gICAg
ICstLS0tLT58ICBDICB8LS0rDQo+ID4gICAgICAgICAgICB8ICAgICB8DQo+ID4gICAgICAgICAg
ICArLS0tLS0rDQo+ID4NCj4gPiAxLiBOb2RlIEMgaXMgcG9wdWxhdGVkIGFzIGRldmljZSBDLiBC
dXQgbm9kZXMgQSBhbmQgQiBhcmUgc3RpbGwgbm90DQo+ID4gICAgcG9wdWxhdGVkLiBXaGVuIGRv
IGN5Y2xlIGRldGVjdGlvbiB3aXRoIGRldmljZSBDLCBubyBjeWNsZSBpcyBmb3VuZC4NCj4gPiAy
LiBOb2RlIEIgaXMgcG9wdWxhdGVkIGFzIGRldmljZSBCLiBXaGVuIGRvIGN5Y2xlIGRldGVjdGlv
biB3aXRoIGRldmljZQ0KPiA+ICAgIEIsIGl0IGZvdW5kIGEgbGluayBjeWNsZSBCLkVQLT5BLT5D
LT5CLiBUaGVuLCBmd25vZGUgbGluayBCLkVQLT5BLA0KPiA+ICAgIEEtPkMgYW5kIEMtPkIgYXJl
IG1hcmtlZCBhcyBjeWNsZS4gVGhlIGZ3bm9kZSBsaW5rIEMtPkIgaXMgY29udmVydGVkDQo+ID4g
ICAgdG8gZGV2aWNlIGxpbmsgdG9vLg0KPiA+IDMuIE5vZGUgQSBpcyBwb3B1bGF0ZWQgYXMgZGV2
aWNlIEEuIFdoZW4gZG8gY3ljbGUgZGV0ZWN0aW9uIHdpdGggZGV2aWNlDQo+ID4gICAgQSwgaXQg
ZmluZCBBLT5DIGlzIG1hcmtlZCBhcyBjeWNsZSBhbmQgY29udmVydCBpdCB0byBkZXZpY2UgbGlu
ay4gSXQNCj4gPiAgICBhbHNvIGZpbmQgQi5FUC0+QSBpcyBtYXJrZWQgYXMgY3ljbGUgYnV0IHdp
bGwgbm90IGNvbnZlcnQgaXQgdG8gZGV2aWNlDQo+ID4gICAgbGluayBzaW5jZSBub2RlIEIuRVAg
aXMgbm90IGEgZGV2aWNlLg0KPiANCj4gWW91ciBleGFtcGxlIGRvZXNuJ3Qgc291bmQgY29ycmVj
dCAoSSdsIGV4cGxhaW4gZnVydGhlciBkb3duKSBhbmQgaXQNCj4gaXMgdmFndWUuIE5lZWQgYSBj
b3VwbGUgb2YgY2xhcmlmaWNhdGlvbnMgZmlyc3QuDQo+IA0KPiAxLiBXaGF0IGlzIHRoZSAtLS0+
IHJlcHJlc2VudGluZz8gSXMgaXQgcmVmZXJlbmNlcyBpbiBEVCBvciBmd25vZGUNCj4gbGlua3M/
IFdoaWNoIGVuZCBvZiB0aGUgYXJyb3cgaXMgdGhlIGNvbnN1bWVyPyBUaGUgdGFpbCBvciB0aGUg
cG9pbnR5DQo+IGVuZD8gSSB0eXBpY2FsbHkgdXNlIHRoZSBmb3JtYXQgY29uc3VtZXIgLS0+IHN1
cHBsaWVyLg0KDQpTb3JyeSwgSSByZXByZXNlbnQgIi0tPiIgYXMgInN1cHBsaWVyIC0tPiBjb25z
dW1lciIgYW5kIGl0J3MgYSBmd25vZGUgbGluay4NCg0KPiANCj4gMi4gWW91IHNheSAibGluayIg
c29tZXRpbWVzIGJ1dCBpdCdzIG5vdCBjbGVhciBpZiB5b3UgbWVhbiBmd25vZGUNCj4gbGlua3Mg
b3IgZGV2aWNlIGxpbmtzLiBTbyBwbGVhc2UgYmUgZXhwbGljaXQgYWJvdXQgaXQuDQoNCkl04oCZ
cyBmd25vZGUgbGluayBieSBkZWZhdWx0Lg0KDQo+IA0KPiAzLiBZb3VyIHN0YXRlbWVudCAiU3Vj
aCBhcyBmd25vZGUgbGluayBBLkVQLT5CIGlzIG5vdCBtYXJrZWQgYXMgY3ljbGUiDQo+IGRvZXNu
J3Qgc291bmQgY29ycmVjdC4gV2hlbiByZW1vdGUtZW5kcG9pbnQgcHJvcGVydGllcyBhcmUgcGFy
c2VkLCB0aGUNCj4gZndub2RlIGlzIGNyZWF0ZWQgZnJvbSB0aGUgZGV2aWNlIG5vZGUgd2l0aCBj
b21wYXRpYmxlIHByb3BlcnR5IHRvIHRoZQ0KPiBkZXN0aW5hdGlvbi4gU28gQS5FUCAtLS0tPiBC
IGNhbid0IGV4aXN0IGlmIEkgYXNzdW1lIHRoZSBjb25zdW1lciAtLT4NCj4gc3VwcGxpZXIgZm9y
bWF0Lg0KDQpUaGUgZndub2RlIGlzIG5vdCBjcmVhdGVkIGZyb20gdGhlIGRldmljZSBub2RlIHdp
dGggY29tcGF0aWJsZSBwcm9wZXJ0eQ0Kc2luY2UgYmVsb3cgY29tbWl0LiBUaGUgZW5kcG9pbnQg
bm9kZSBpcyB0aGUgc3VwcGxpZXIuIE5vLCB5b3UgY2FuIHNlZSBteQ0KY2FzZSBsYXRlci4NCg0K
NGEwMzI4MjdkYWE4IChvZjogcHJvcGVydHk6IFNpbXBsaWZ5IG9mX2xpbmtfdG9fcGhhbmRsZSgp
LCAyMDIzLTAyLTA2KQ0KDQo+IA0KPiA0LiBIYXMgdGhpcyBhY3R1YWxseSBjYXVzZWQgYW4gaXNz
dWU/IElmIHNvLCB3aGF0IGlzIGl0PyBBbmQgZ2l2ZSBtZQ0KPiBhbiBleGFtcGxlIGluIGFuIHVw
c3RyZWFtIERULg0KDQpZZXMsIHRoZXJlIGFyZSB0d28gY3ljbGVzIChCLkVQLT5BLT5DLT5CIGFu
ZCBCLkVQLT5BL0EuRVAtPkIpIGluIGFib3ZlDQpleGFtcGxlLiBCdXQgb25seSBvbmUgY3ljbGUg
KEIuRVAtPkEtPkMtPkIpIGlzIHJlY29nbml6ZWQuDQoNCk15IHJlYWwgY2FzZSBhcyBiZWxvdzoN
Ci0tLQ0KdGNwY0A1MCB7DQogICAgY29tcGF0aWJsZSA9ICJueHAscHRuNTExMCI7DQogICAgLi4u
DQoNCiAgICBwb3J0IHsNCiAgICAgICAgdHlwZWNfZHJfc3c6IGVuZHBvaW50IHsNCiAgICAgICAg
ICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmdXNiM19kcmRfc3c+Ow0KICAgICAgICB9Ow0KICAgIH07
ICAgIA0KfTsNCg0KdXNiQDM4MTAwMDAwIHsNCiAgICBjb21wYXRpYmxlID0gInNucHMsZHdjMyI7
DQogICAgcGh5cyA9IDwmdXNiM19waHkwPiwgPCZ1c2IzX3BoeTA+Ow0KICAgIC4uLg0KDQogICAg
cG9ydCB7DQogICAgICAgIHVzYjNfZHJkX3N3OiBlbmRwb2ludCB7DQogICAgICAgICAgICByZW1v
dGUtZW5kcG9pbnQgPSA8JnR5cGVjX2RyX3N3PjsNCiAgICAgICAgfTsNCiAgICB9Ow0KfTsNCg0K
dXNiM19waHkwOiB1c2ItcGh5QDM4MWYwMDQwIHsNCiAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4
bXAtdXNiLXBoeSI7DQoNCiAgICAuLi4NCn07DQoNCkFuZCBmd25vZGUgbGlua3MgYXJlIGNyZWF0
ZWQgYXMgYmVsb3c6DQotLS0NClsgICAgMC4wNTk1NTNdIC9zb2NAMC9idXNAMzA4MDAwMDAvaTJj
QDMwYTMwMDAwL3RjcGNANTAgTGlua2VkIGFzIGEgZndub2RlIGNvbnN1bWVyIHRvIC9zb2NAMC91
c2JAMzJmMTAxMDAvdXNiQDM4MTAwMDAwL3BvcnQvZW5kcG9pbnQNClsgICAgMC4wNjYzNjVdIC9z
b2NAMC91c2ItcGh5QDM4MWYwMDQwIExpbmtlZCBhcyBhIGZ3bm9kZSBjb25zdW1lciB0byAvc29j
QDAvYnVzQDMwODAwMDAwL2kyY0AzMGEzMDAwMC90Y3BjQDUwDQpbICAgIDAuMDY2NjI0XSAvc29j
QDAvdXNiQDMyZjEwMTAwL3VzYkAzODEwMDAwMCBMaW5rZWQgYXMgYSBmd25vZGUgY29uc3VtZXIg
dG8gL3NvY0AwL3VzYi1waHlAMzgxZjAwNDANClsgICAgMC4wNjY3MDJdIC9zb2NAMC91c2JAMzJm
MTAxMDAvdXNiQDM4MTAwMDAwIExpbmtlZCBhcyBhIGZ3bm9kZSBjb25zdW1lciB0byAvc29jQDAv
YnVzQDMwODAwMDAwL2kyY0AzMGEzMDAwMC90Y3BjQDUwL3BvcnQvZW5kcG9pbnQNCg0KPiANCj4g
QnR3LCBJIGRlZmluaXRlbHkgZG9uJ3QgYW50aWNpcGF0ZSBBQ0tpbmcgdGhpcyBwYXRjaCBiZWNh
dXNlIHRoZSBjeWNsZQ0KPiBkZXRlY3Rpb24gY29kZSBzaG91bGRuJ3QgYmUgaGF2aW5nIHByb3Bl
cnR5IHNwZWNpZmljIGxvZ2ljLiBJdCdzIG5vdA0KPiBldmVuIERUIHNwZWNpZmljIGluIHRoaXMg
cGxhY2UuIElmIHRoZXJlIGlzIGFuIGlzc3VlIGFuZCBpdCBuZWVkcw0KPiBmaXhpbmcsIGl0IHNo
b3VsZCBiZSB3aGVyZSB0aGUgZndub2RlIGxpbmtzIGFyZSBjcmVhdGVkLiBCdXQgdGhlbg0KPiBh
Z2FpbiBJJ20gbm90IHN1cmUgd2hhdCB0aGUgYWN0dWFsIHN5bXB0b20gd2UgYXJlIHRyeWluZyB0
byBzb2x2ZSBpcy4NCg0KU29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLiBJIHNhdyB0aGF0IHlv
dSBwdXNoIHNvbWUgcGF0Y2hlcyBhYm91dCBmd25vZGUNCmxpbmsgYW5kIGRldmljZSBsaW5rIGhh
bmRsaW5nLCBzbyBJIHRoaW5rIHlvdSBtYXkgdW5kZXJzdGFuZCB0aGlzIGlzc3VlDQp3ZWxsIGFu
ZCBnaXZlIHNvbWUgc3VnZ2VzdGlvbnMuDQoNClRoYW5rcywNClh1IFlhbmcNCg0KIA0KDQo=

