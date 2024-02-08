Return-Path: <linux-kernel+bounces-58611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9868D84E8D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93CF3B2E1D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB3D36B1D;
	Thu,  8 Feb 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ogz3deaz"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2059.outbound.protection.outlook.com [40.107.114.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACB2560F;
	Thu,  8 Feb 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420035; cv=fail; b=uhz3k2UjSyndtbJTg6cP513G2/XmcKKqpx+FIvSE2kw4pNHpxVH3QSJjK1uW6SqL0BzPA7dKp+6xvCTderHUwupKZWjEtkwVGvIAjQ2+sKGrt+0lnKmd5oYbLk70UWtwdFxl5hnBsIGBg7NP7QOydTqnRU3V13CC2nDiyq4goNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420035; c=relaxed/simple;
	bh=2hTeE8MK7T39NEGq3WF72E07Lz5Om6cbZzHKyL0WF40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFVfwkzORx0lkdDumU8zpFSmdeeefEWZrqTCGRGKpHxF6GCBwAxC28ifGZmuQZOt798YsyY6yRLNDPsHRXQLihty8hBXFRRzh10vFSDMLqP3qS6w8nMCpH23LIsYJGj7Q9y6AuaRiaeUyfu9Fjl9GchOuq4/5oQFymWyFXgVays=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ogz3deaz; arc=fail smtp.client-ip=40.107.114.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0kF1MCD9pz3Rlwo2oxesC9mVUAf2nHYCP49hJBC1+f0v+KA1R/RSUdiW+Ci8K9tmFd2rk9OVN9xvTsbGqW636f/4Ys1V1pXTWeLfiRul/TBwzgiPa1soHzPtdki8EClbpZxepi933Idj34msLh6eVT+wiYvmciXrdhWfF+w91ftQ2GJF+1imJUd42GTowXQ0QsB6LHOLGHazilLwG41GfYDdpYs/q5sJzrGhMhjwZIy25YwrIJKcsmuSpyzySO6y+4OIp/GWQN6ghvegJuMBjgZCPt17thKnstg0zwbJgIwXsJJDttlPtuDMGJR5Rf1cw5/k7HKd927hoPMDbbymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hTeE8MK7T39NEGq3WF72E07Lz5Om6cbZzHKyL0WF40=;
 b=ek8ap8gmfGfjEt8PBZxslbSTlbbhqQ/835mpdHiFjx0/wOjwPD7vNQVkYpRHqg2llF2V5MBgQKxyoTa4Ta+HD4Q6XaJ5rv9juSiKNKNKVcb76I7DYoBxhFo3teYNvgpu728Zfj0Oq+RjO+wDXbAqPzgnkMr+hpGRwXJ24unt8xObQLKTSKOZ8gpLU5DkfWLtVXgOIrjVMVrOBqZYHdyQjxN8CY3vsPG/ZGzFVVF8Xp7cryvW7uc7acQzvMZ9itZJsAF6s2oqt4o8BGcV2U5xBkZa3W+76ca2dg5sYaZ8lEc8kQoZycBT1BAbfJ1hsStnKo4c8McUlssMzntjcVvOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hTeE8MK7T39NEGq3WF72E07Lz5Om6cbZzHKyL0WF40=;
 b=ogz3deaz102LVfo9O1hCZ0zFzI6hT4e90CrGvVWkdc2UaYVd1VdRxNl11FRTKhRr6fG7vWTt8pZI6aj6XkhQs04otcq30EFHVZqJPQpRBL742CI5tjrXoEfE2GNyKrFImLJRBr+Ah7NnF/n3bM2jEqbpReUaVmrx5sFwfLX2Hx4=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB11722.jpnprd01.prod.outlook.com
 (2603:1096:400:3dc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 19:20:28 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 19:20:28 +0000
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
Thread-Index: AQHaWox93XkHXchpTkaSnTQ6Ok/3vrEAgGfQgAAWUICAAAlS4IAACXEAgAAoXKA=
Date: Thu, 8 Feb 2024 19:20:28 +0000
Message-ID:
 <TYCPR01MB11269015C92AA327DC6BFA76586442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269DEA9261CA594EECC949686442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <67ad8052-1406-4dcb-9e35-5c42ada28797@tuxon.dev>
 <TYCPR01MB112698AB206332D13105C064186442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <e170f5f8-f95c-4553-b088-1072345fae53@tuxon.dev>
In-Reply-To: <e170f5f8-f95c-4553-b088-1072345fae53@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB11722:EE_
x-ms-office365-filtering-correlation-id: 08629697-b2c1-4c70-56d8-08dc28db02a1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ihMVtHX7/A3k3dya1JDNSt+vYT1wf/+/Qh0awk0EQnAvWwqZH0L+lnRVL0dw7c65QpYjjDRMgN4HeoGP0UUZaKRsgKxWUrB8qOe2V/3vFmDprTo4ba17m010eDpX1a/v/iO6URBg9jQsVsh1fS2It75v/TEO3FzKbeTu/A8l0kYBSOJW5QSZE+sYZ0S6VzgQLjbzcSv4nts2/hndXJFlLngGQZoC//Moif6S63UZ8NCxK4yu1U63INbO/byhSA0W7YUg/E1BnAnKDTMXdt8lVmKbB0Sl3ekX6AV5ztfFFjpLeyX+7BkainZYV5WRUZgHwhHZVshXwoKAfBGH8800gOF7TQwvNVy5aQOSMsnotrqZY3BfQM9OxrTQ+yF8Z8lTKrCrUMgekEdABJxxXF+WGXBWexfd4rmFse41oZ34gtmp6JYClLT09G1DshUzYHM0MjlOpV10dmapChYh+SKNGfLG5FiniMT7hOUGzAwv04nG/Fx9F4PCc4aa6f1W+ZQeNaCsaEd2Y7RiXOizFD4yBlCbOXqPuGtralIvHdnTTh9nq0Zr6/Zqvn01g6QZixdaYMsoTKjNxXQpaaBmRLb5hoInc6Rcj9OOx7foBif2DhXkvW2MHpeyBZVKRuX5HCIw+adTc6RPOHUwxZpSmsP7rQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(316002)(7416002)(5660300002)(2906002)(66556008)(66946007)(8936002)(66476007)(4326008)(52536014)(8676002)(83380400001)(38100700002)(66446008)(33656002)(64756008)(921011)(110136005)(122000001)(71200400001)(54906003)(76116006)(7696005)(6506007)(53546011)(9686003)(38070700009)(107886003)(41300700001)(55236004)(26005)(478600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3BMcnd6QU5ieFNmQzVTL2pucGlYdXFXY0F2WnkvclR4TEVLTmV2dEFkeHds?=
 =?utf-8?B?dzViY2lDcUhkbFB6bTlBM2hBWVhXV1pRZW92V1hyYzhtSGxUQk9oa1pjK3Nl?=
 =?utf-8?B?cVdGcXJJUXVReDE4R3RlR2lPQ1RGcWhiYnh3UklhNEYzb2EwV3M5TnNkbXk0?=
 =?utf-8?B?a0poUmhJbEE2WjhPUElEdXpOK0hxZmcxcmJhcWQ4eTZBTkg1TDdjenlJN2NW?=
 =?utf-8?B?K1VKWnlsemt3RWJDMmNrWUtMRnlROFJEckw5c0NJb3FKWWtsSG43Ny9WRWpo?=
 =?utf-8?B?T3pVRmNtMzFYalZTbVFHeXFNN3pDTFp6dzJLMVNVdURjMzErcVFYSHRKZnc0?=
 =?utf-8?B?RVRrL2U3YmFPSWFnNlIzSk1mRXdBMElmMmVVU3JpZTB5bmpXQTVzb1IvZUVR?=
 =?utf-8?B?TUt6TWtKSThUWEorMTh3RTRzSlFPMENBL2JQK1pQbHQvRlhiQ1M3bnFucjVn?=
 =?utf-8?B?QmpEK3NYWnNMSjh2RXZEcE43WlZUaU1EZTRPTWV1K04xaUlzUmtyUjRiMEVM?=
 =?utf-8?B?SFJBV2hQYXNUYlJpaUJtWEs0cGJhQWE1VGU2d3BVUmo5Smlsem1sZGVVS1dU?=
 =?utf-8?B?dk40dnFnRjdIRERoUG9pVXVWdXI4OEtNVEJhbC9KNHZIMU5uSUYrY2p0VWNN?=
 =?utf-8?B?dDJudUkvQ2dUMkROWG1RS3RETTdsUndkN2lyb2dTT2RndW11M0UyWEZVRWQ2?=
 =?utf-8?B?R2tHRlRTbEZ6dXVHemppaVorRkR2d0JpbG9MYkx2a0VSWmRTSFdOazEwems4?=
 =?utf-8?B?Z3lScVF1bnpYMzNyOXlFNUozZzBCanJrL2Q3dnE3dVN0em5hbHBVcDhGREJQ?=
 =?utf-8?B?OS9GNDNzZEMxRnFlN0RaVFV1UjhJZnN5Q3JIcVcyMlprb0ZOUERMNmQzK3Na?=
 =?utf-8?B?WXpwSEtYcVl4YzgweldTM3hJNDh4VmFmZFRLODY5OS9RdVh4Vi9FZlNvVzZY?=
 =?utf-8?B?M2lMbVhpRk5UOXF6ZnYrbGwyeTVnWW5vTk54MWNHNjU0dXhKZmJUUkMwKzNW?=
 =?utf-8?B?a0ZycUhsQUIxMXhjaHRVOGtYdjc2RGF0ektRdlV4WFlwTytNMllWa3hIR04z?=
 =?utf-8?B?cmw1cnNPQ3Z2VHBHaE9VVUZ0QkZ1Z2grT1hTczhZQVQ4NWlHbk00RGlQMlJC?=
 =?utf-8?B?TmhwR2R5dEh0TWNTUlJpbnhQeis3RUhwWmkzV2Q2VkxCeWMxMjErZnhyM0Ix?=
 =?utf-8?B?VkcvTE9uY2dCekd3T3dHNzVGUXllbnZIaTJoQWkxd2lMV2txVGhCbzc3Rnp2?=
 =?utf-8?B?SUt3bHZYbm9IUS9LUkNQVWxLeGZvcHpIS2k5UFZUcFlhU2JpUzNTazhzSVZN?=
 =?utf-8?B?UmJrOFdOanNoTlJGN1pxbWtjOTFNVWwzcysvem13SlFnYndiaUZyT2trNmFh?=
 =?utf-8?B?TnNUVGlEK0lGWURPNGRuUmUwSWZHTURhQXkva3VEL1JHMlYxdjUwQnFZTmEv?=
 =?utf-8?B?YnRDUXJuVlNtcFQzcStvU3Zsb0RBQlVhQ2ZJazh1Zk0wU1N5aVFxS3lTVFIx?=
 =?utf-8?B?aTJSQ2RoQmlzWVArdHV4cVM0QVlNaVpmbFN1Y3pTMndIMXM4SzdOL3laM0ZB?=
 =?utf-8?B?OHc5eUtSb1JCQldlNEo5Tmk5SHloNTdqNjh4eU9PamRwNU44QWJ3bnhsbHpU?=
 =?utf-8?B?ZVRJQmYxMWVUVnhib0l3bEJ4UVRQeXdkUDJ3TXF1cSttQmE3aVIrM1NGWWth?=
 =?utf-8?B?d0lNUnBWYnJ3RHFJc2ZTaXd2RUlkUUJMVzV2NE1PeXFkVm5QclIrT3g2T1lC?=
 =?utf-8?B?TTNVTXYycVBIQUNBTC9NeEk0TFdxWkZUaDVmMFV5RTc1V2pXaEdWc1l1N2tJ?=
 =?utf-8?B?ME43MVRkN1IzY1UxanRYejlnYXVsODFVOXNrcmhMVlh6VnZSbmRqTXphRlpy?=
 =?utf-8?B?QllXNEJCY29PSnM5Y3JqMEFaK1FReEJEb0ZVeDVQWlcxRjJxYytsMnpHWloz?=
 =?utf-8?B?OWt0MVpJTFZkbGhuZ0MrSHM2RWVJNXNiMk9YTlR0VjZDa0NhWkNhWmdBTm9E?=
 =?utf-8?B?VXMwaWdvR3U1UmJzNFZ2RStrZnl4ZC8rZHRDUG04WnFKSTE4Z0tlWjZtTzN6?=
 =?utf-8?B?RVZYbXQwaVdYZm9QaVlKYU9KZ1lyK0lmdk0zZ1dDME0xL2NPOVBiclo2RzBi?=
 =?utf-8?B?b2ZVdUl5aG1Kd0xSaEZ0dWRSYjU3RUtzK2lpYWEzR0RBcHBBSytRV0ZhajV2?=
 =?utf-8?B?QlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08629697-b2c1-4c70-56d8-08dc28db02a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 19:20:28.6424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4fa70p3qpWRAV1IFvvPeoQjpQE1jz/Zt1/H8VuX0RszzQQE9bT9nmEREUsiMLUPQoH0oApQjdtJU0XK+aNAv3NzxWPYPqmyvyqSNX1M568=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11722

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2xhdWRpdSBiZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDgs
IDIwMjQgNDo1MyBQTQ0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
PjsgZ2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBz
Ym95ZEBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2kr
ZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gbWFnbnVzLmRhbW1AZ21haWwu
Y29tOyBwYXVsLndhbG1zbGV5QHNpZml2ZS5jb207IHBhbG1lckBkYWJiZWx0LmNvbTsNCj4gYW91
QGVlY3MuYmVya2VsZXkuZWR1DQo+IENjOiBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcmlzY3ZAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgQ2xhdWRpdSBCZXpuZWENCj4gPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJl
bmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzE3XSBkdC1iaW5kaW5nczogY2xv
Y2s6IHI5YTA3ZzA0My1jcGc6IEFkZCBwb3dlcg0KPiBkb21haW4gSURzDQo+IA0KPiANCj4gDQo+
IE9uIDA4LjAyLjIwMjQgMTg6MjgsIEJpanUgRGFzIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogY2xhdWRpdSBiZXpuZWEgPGNsYXVk
aXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDgsIDIw
MjQgMzo0NiBQTQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzE3XSBkdC1iaW5kaW5nczog
Y2xvY2s6IHI5YTA3ZzA0My1jcGc6IEFkZA0KPiA+PiBwb3dlciBkb21haW4gSURzDQo+ID4+DQo+
ID4+IEhpLCBCaWp1LA0KPiA+Pg0KPiA+PiBPbiAwOC4wMi4yMDI0IDE2OjMwLCBCaWp1IERhcyB3
cm90ZToNCj4gPj4+IEhpIENsYXVkaXUsDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciB0aGUgcGF0
Y2guDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJv
bTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+Pj4+IFNlbnQ6IFRodXJz
ZGF5LCBGZWJydWFyeSA4LCAyMDI0IDEyOjQzIFBNDQo+ID4+Pj4gU3ViamVjdDogW1BBVENIIDAx
LzE3XSBkdC1iaW5kaW5nczogY2xvY2s6IHI5YTA3ZzA0My1jcGc6IEFkZCBwb3dlcg0KPiA+Pj4+
IGRvbWFpbiBJRHMNCj4gPj4+Pg0KPiA+Pj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1
LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4+Pg0KPiA+Pj4+IEFkZCBwb3dlciBkb21h
aW4gSURzIGZvciBSWi9HMlVMIChSOUEwN0cwNDMpIFNvQy4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25l
ZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNv
bT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9yOWEwN2cw
NDMtY3BnLmggfCA0OA0KPiA+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+Pj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9yOWEwN2cwNDMtY3BnLmgNCj4gPj4+PiBiL2lu
Y2x1ZGUvZHQtIGJpbmRpbmdzL2Nsb2NrL3I5YTA3ZzA0My1jcGcuaCBpbmRleA0KPiA+Pj4+IDc3
Y2RlOGVmZmRjNy4uZWFiZmVlYzdhYzM3DQo+ID4+Pj4gMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvaW5j
bHVkZS9kdC1iaW5kaW5ncy9jbG9jay9yOWEwN2cwNDMtY3BnLmgNCj4gPj4+PiArKysgYi9pbmNs
dWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3I5YTA3ZzA0My1jcGcuaA0KPiA+Pj4+IEBAIC0yMDAsNSAr
MjAwLDUzIEBADQo+ID4+Pj4gICNkZWZpbmUgUjlBMDdHMDQzX0FYNDVNUF9DT1JFMF9SRVNFVE4J
NzgJLyogUlovRml2ZSBPbmx5ICovDQo+ID4+Pj4gICNkZWZpbmUgUjlBMDdHMDQzX0lBWDQ1X1JF
U0VUTgkJNzkJLyogUlovRml2ZSBPbmx5ICovDQo+ID4+Pj4NCj4gPj4+PiArLyogUG93ZXIgZG9t
YWluIElEcy4gKi8NCj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfQUxXQVlTX09OCQkwDQo+
ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0dJQwkJMQ0KPiA+Pj4+ICsjZGVmaW5lIFI5QTA3
RzA0M19QRF9JQTU1CQkyDQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX01IVQkJMw0KPiA+
Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9DT1JFU0lHSFQJCTQNCj4gPj4+PiArI2RlZmluZSBS
OUEwN0cwNDNfUERfU1lDCQk1DQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0RNQUMJCTYN
Cj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfR1RNMAkJNw0KPiA+Pj4+ICsjZGVmaW5lIFI5
QTA3RzA0M19QRF9HVE0xCQk4DQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0dUTTIJCTkN
Cj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfTVRVCQkxMA0KPiA+Pj4+ICsjZGVmaW5lIFI5
QTA3RzA0M19QRF9QT0UzCQkxMQ0KPiA+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9XRFQwCQkx
Mg0KPiA+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9TUEkJCTEzDQo+ID4+Pj4gKyNkZWZpbmUg
UjlBMDdHMDQzX1BEX1NESEkwCQkxNA0KPiA+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9TREhJ
MQkJMTUNCj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfSVNVCQkxNg0KPiA+Pj4+ICsjZGVm
aW5lIFI5QTA3RzA0M19QRF9DUlUJCTE3DQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0xD
REMJCTE4DQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NTSTAJCTE5DQo+ID4+Pj4gKyNk
ZWZpbmUgUjlBMDdHMDQzX1BEX1NTSTEJCTIwDQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BE
X1NTSTIJCTIxDQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NTSTMJCTIyDQo+ID4+Pj4g
KyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NSQwkJMjMNCj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNf
UERfVVNCMAkJMjQNCj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfVVNCMQkJMjUNCj4gPj4+
PiArI2RlZmluZSBSOUEwN0cwNDNfUERfVVNCX1BIWQkJMjYNCj4gPj4+PiArI2RlZmluZSBSOUEw
N0cwNDNfUERfRVRIRVIwCQkyNw0KPiA+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19QRF9FVEhFUjEJ
CTI4DQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0kyQzAJCTI5DQo+ID4+Pj4gKyNkZWZp
bmUgUjlBMDdHMDQzX1BEX0kyQzEJCTMwDQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0ky
QzIJCTMxDQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0kyQzMJCTMyDQo+ID4+Pj4gKyNk
ZWZpbmUgUjlBMDdHMDQzX1BEX1NDSUYwCQkzMw0KPiA+Pj4+ICsjZGVmaW5lIFI5QTA3RzA0M19Q
RF9TQ0lGMQkJMzQNCj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU0NJRjIJCTM1DQo+ID4+
Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1NDSUYzCQkzNg0KPiA+Pj4+ICsjZGVmaW5lIFI5QTA3
RzA0M19QRF9TQ0lGNAkJMzcNCj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU0NJMAkJMzgN
Cj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfU0NJMQkJMzkNCj4gPj4+PiArI2RlZmluZSBS
OUEwN0cwNDNfUERfSVJEQQkJNDANCj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERfUlNQSTAJ
CTQxDQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX1JTUEkxCQk0Mg0KPiA+Pj4+ICsjZGVm
aW5lIFI5QTA3RzA0M19QRF9SU1BJMgkJNDMNCj4gPj4+PiArI2RlZmluZSBSOUEwN0cwNDNfUERf
Q0FORkQJCTQ0DQo+ID4+Pj4gKyNkZWZpbmUgUjlBMDdHMDQzX1BEX0FEQwkJNDUNCj4gPj4+PiAr
I2RlZmluZSBSOUEwN0cwNDNfUERfVFNVCQk0Ng0KPiA+Pj4NCj4gPj4+IE5vdCBzdXJlIGZyb20g
IlRhYmxlIDQyLjMgUmVnaXN0ZXJzIGZvciBNb2R1bGUgU3RhbmRieSBNb2RlIg0KPiA+Pj4NCj4g
Pj4+IFBvd2VyIGRvbWFpbiBJRCBoYXMgdG8gYmUgYmFzZWQgb24gQ1BHX0JVU18qKipfTVNUT1Ag
b3INCj4gPj4+IENQR19DTEtPTl8qKiogQXMgZm9ybWVyIHJlZHVjZXMgbnVtYmVyIG9mIElEcz8/
DQo+ID4+DQo+ID4+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgeW91ciBwb2ludCBoZXJlLCB5
b3Ugd2FudCBtZSB0byBkZXNjcmliZSBQTQ0KPiA+PiBkb21haW4gaW4gRFQgd2l0aCBzb21ldGhp
bmcgbGlrZToNCj4gPj4NCj4gPj4gcG93ZXItZG9tYWlucyA9IDwmY3BnIENQR19CVVNfWF9NU1RP
UD47DQo+ID4NCj4gPiBNU1RPUCBiaXRzIGFyZSBkaXN0aW5jdCBmb3IgZWFjaCBJUC4NCj4gPg0K
PiA+IDwmY3BnIENQR19CVVNfTUNQVTFfTVNUT1AgeD47IHggPTEuLjkNCj4gPg0KPiA+IDI9TVRV
IElQDQo+ID4NCj4gPiA0PSBHUFQNCj4gPg0KPiA+IGV0Yy4uLg0KPiA+DQo+ID4gSXMgaXQgc29t
ZXRoaW5nIHdvcms/Pw0KPiANCj4gSXQgbWlnaHQgd29yay4gQnV0Og0KPiANCj4gLSB5b3UgaGF2
ZSB0byBjb25zaWRlciB0aGF0IHNvbWUgSVBzIGhhdmUgbW9yZSB0aGFuIG9uZSBNU1RPUCBiaXQs
IHRodXMsDQo+IGRvDQo+ICAgd2Ugd2FudCB0byB1bmlxdWVseSBpZGVudGlmeSB0aGVzZSB3aXRo
IGFsbCBNU1RPUCBiaXRzICh0aHVzIHRoZSAybmQNCj4gY2VsbA0KPiAgIGJlaW5nIGEgYml0bWFz
aykgb3Igb25seSBvbmUgaXMgZW5vdWdoPw0KDQpXZSBjYW4gaGF2ZSBhbiBlbmNvZGluZyBpbiB0
aGF0IGNhc2UgODoxNiAyNCBiaXQgZW50cmllcw0KDQo+IC0gc29tZSBIVyBibG9ja3MgKGUuZy4g
T1RGREVfRERSKSBoYXZlIG5vIE1TVE9QIGJpdHMgYXNzb2NpYXRlZCAoYXMgb2YgbXkNCj4gICBj
dXJyZW50IHJlc2VhcmNoKSwgc28sIG9ubHkgUFdSRE4NCg0KV2h5IGRvIHdlIHdhbnQgdG8gYWRk
IHBvd2VyIGRvbWFpbiBzdXBwb3J0IGZvciBERFI/DQoNCj4gLSBzb21lIEhXIGJsb2NrcyBoYXZl
IGJvdGggTVNUT1AgYW5kIFBXUkRODQoNClRoYXQgd2lsbCBiZSBhbiBhcnJheSByaWdodD8NCg0K
PiAtIGlmIGZ1dHVyZSBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbiB3aWxsIHNwcmVhZCB0aGUgTVNU
T1AgYml0cyBmb3Igb25lIElQDQo+ICAgdG8gbW9yZSB0aGFuIG9uZSByZWdpc3RlciB0aGVuIHRo
aXMgcHJvcG9zYWwgd2lsbCBub3Qgd29yaw0KDQpUaGF0IHdpbGwgYmUgYW4gYXJyYXkgcmlnaHQ/
DQoNCkNoZWVycywNCkJpanUNCg==

