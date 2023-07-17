Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A9075692F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGQQb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjGQQby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:31:54 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6D10D1;
        Mon, 17 Jul 2023 09:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or5PqjZDaWppdzCiGPAVS3Rnw/A3RcTgOd4vtkDKOHc5F5+v9ShxbgHeS1nPfc2uc+P9ka82D/lsxOHI8Nffq6WRoLoOkYAOWJ53OQbTokfwdqL4MUU8XelmIe9PrhTMOQl6rHcn+A6LfYgd6ghPdtVQJHPR/OuVxZPmOnmyeH+T+oJ8RHXHcQx/iqQD2Juc9qhvpi5/nkrzy+B7QoicI6DuSWMA5tBSJY5HjiR25LxOIVX/yrJ7NWBA9RKEMgi2/SY6P0u7tBaPp19m2bj9a7QaV8J+q1GQqwWx/ncIqY+r4YgestH953LaVQEDoUA4amCdgPO0QO1MeKJidaxN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2/uEi/WCkzKkP83es5IBu8Yi3nr30H+FlA3+tGh7QI=;
 b=SlY0cA+Vr31xOUGqaIKxBhrGt+kjE0/Ud6iO5TdkebffnCbEFHahrp4NT2sDh46s+onHpD+nDcRL38tLgVDSnKG13lmJfe/7itoRjCoVfc+Z+Lm6EBZzwLkO13oXTdDYMxcdvJNae2FUZacMaH8GRHRDMun3rF+EWGGhzGYad14hmP6RL210NCAYNQh19z1C322+G3m2b8KC1QEw++jJdH1onebxQ1Zy96r8/IucxBl9tJ3flilSDDDYCzkD1GGUv1PLzBBeB/TGjX4K9Sy8jpWOxrP4n5bQGR9ZnCh9fLn+kwyX0I0Zv4k7ZTmbsY7hchSXL2Z0N6bXx31nufkwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2/uEi/WCkzKkP83es5IBu8Yi3nr30H+FlA3+tGh7QI=;
 b=TZC6setvTNvqjwyhXHaT4yyl89f4mxWbwZoT1g0fqpV7spW0Lh4PYxouuxhqZhF0PKxDfE7zu9to71K0lQ8CmY9swUQteLfgVHZhlhUpenVmdqsq6J6ViLKtuj25Q0Yb46aysF2KRjI/M6r2s1xlDG8wF7OvmeUfc5v/9OpUC40=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB9407.jpnprd01.prod.outlook.com (2603:1096:400:1a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 16:31:34 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:31:34 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
Thread-Topic: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
Thread-Index: AQHZtrhW9m6gE+r9C0SdjPac+B4RGq+9ty4AgAAMoZCAAA+LAIAAGufggAAx42A=
Date:   Mon, 17 Jul 2023 16:31:34 +0000
Message-ID: <TYWPR01MB87757F4240EE762D44630519C23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
 <20230715010407.1751715-8-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUzxQfi2w8dyF8gCitkSKkw_fRE074EUuB+tHKn8WM3=w@mail.gmail.com>
 <TYWPR01MB8775869576E4B3F0FEFCF3DCC23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <CAHp75VdNvWS04VN58r5VcSJskeVJF0g0_spSRb8f0_OP1P04QQ@mail.gmail.com>
 <TYWPR01MB8775B01AB7A7FA59E38F77D6C23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB8775B01AB7A7FA59E38F77D6C23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB9407:EE_
x-ms-office365-filtering-correlation-id: 54b04f28-2290-4a0b-33e3-08db86e34947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCgQgSr2+akMcevwZSySAqDtct1J+NtSSpXki5Zl2NTvvN/05J3xcFrdDxRuPpf4qRowdz/FWf93Y3KbfAZ9xFTuDcdohlOQyE21LLxFk++xKZMrpVidrq0dbH5oN7LXFc43VH3N85ilwY/G95NsJtPpwMd52ns2tEldPWtbYuzjzp9EAvv9e02VDNMzwyekUjD+xqmPS6csgMVNbhdqFeiZrS2WYd7ejfWwFJS+D9aBlieV6TjnMz8cuuJ6SUuMgJg21xX2eCtyCZUhy9acsemQ7wdLPtZD0XxyP5ZkOVgC8STe8I2Rt8lou+/n0xwkGZmOWKl3Uhk8MP90VLVp97k6w7RsrEK6/vXvKVHgGpI5IQqROQyPfa6TSNhn8Rp82bFnlbT4wNHF85+AwwvbjjN+Pp5/bGzMIklCgLELZdXL/aEe1+P5vJAzQ/rmITV6F3mK9p3h50mfUkNq/0ggVuUfnzEeZpv6bFLZwTD5hBLksrV7aPO/Rrdxq1HKZCby5LFsQIVWwVOSe/E+szjphgc2Nv9nfHcnvGBUhdG0HBL6lzx776qP3dm5sXBfgzDYNZgblDmNVvmKBrVp8Nl2r4oDvpDQ022w4n+Dh5KoijwDEGTs62JtZYVDZA1wNwGi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(86362001)(2906002)(33656002)(38070700005)(55016003)(2940100002)(186003)(83380400001)(9686003)(6506007)(53546011)(26005)(107886003)(38100700002)(7696005)(54906003)(122000001)(110136005)(71200400001)(316002)(5660300002)(66476007)(76116006)(66446008)(64756008)(66946007)(66556008)(4326008)(478600001)(41300700001)(8936002)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2cwRVdpMXBRVERMRmt5QzA4S0hQTm1PY1A2c2VJV0JicEpMZ3lLU25OVEkv?=
 =?utf-8?B?elF4aW5nMUd2Y05Bc3h6aThpdG9xN1N1bGN1UmhEN1BtN0FLUDh0NExnemhn?=
 =?utf-8?B?TE1DMUdMeWdqc1dYYUQyVDVQS1lNS3Erc0ZHaFJrbFhVN3I5SXJSQzZ6M29V?=
 =?utf-8?B?dlduSTJmR0YwNEJBUzMvK1Nud25xUUI4Yy9LYUtEaWZzekx4S21CMWNXUHNv?=
 =?utf-8?B?VDVzYktuVmFHSUNOUG1EMjIydDNwaWZXQ0ExVkUyTXR6SVhxQ1RhVnRjYk04?=
 =?utf-8?B?eWlmQWw3K0FhOGtiYmkwUVNSdG5ucm5GUUZYKzVkaWJ2blcxYlpIb01Wd1Z2?=
 =?utf-8?B?N1cxeEJ6QVpqOGVURzYxVzdGVHMyUy9aZk5nWkExZFQxcWdjN3l6VlM3WFlD?=
 =?utf-8?B?TERSM1hzT3FVS1ZiUldkWk83TGhhSS80akpTVU96YlVhUm1qelB5OFdCR3Jq?=
 =?utf-8?B?ZUlRaDJCaUk5cXYxMm9abmVWbjJ2MHJuRngyd1ZvTll0dDY3ZG1UWEdkU20z?=
 =?utf-8?B?VGtTNDBNRWJkWjBsd3JnYWVuaDAyOFRXRmh6YTVkaWhyVGlFTUUvdUxOY3lh?=
 =?utf-8?B?aHd6K3VkK0RJemR1QTI4TUd5eXpESWdyUm4yd1RYOXFXZW5ONkVHMGw1cDlP?=
 =?utf-8?B?U1V5aWg4VlFHKy95WUJ1TnM0eWxtWTBuUU9qOEg3RkVlTDlQRVdkVzlROEFG?=
 =?utf-8?B?TXQxZHVEYnZzTk5KNmJvd28xYTBXb3hod0dPeCtacWpBS3h5aXVIM2RETkVC?=
 =?utf-8?B?Qmg3b3JxM0hUb082V0E5MDdzOHhiSnNvVHBLY2NHTmVRald0Q2lReThpcHU5?=
 =?utf-8?B?bkJ6Y1JNbU13YTlCU2N5eGE3cDZUdWtwUEJhc1FGZ2Q0N2sxRUlRUk9NRUg4?=
 =?utf-8?B?WjhZSWpBZlMwYlRGRTZPSmp0ZERxeEdibWhBbm1ueDYvK3lRLzB2UHFjMnVl?=
 =?utf-8?B?ZXdFQmVTaEk1cVdzL0QyU25oanNIQ3IwcEorUzU4VElDY2p4S3Q0OWlFVWJG?=
 =?utf-8?B?eVpodTRiV3ZhRk5kSnFtdFhSWHpEU2JISEhlLzdxWHFQSndyczVmMEZqTmZ6?=
 =?utf-8?B?WWo1bnR4ODNCSkZ6MDRJUTRlZjhPNmh4ZFZoUXRXbWxlc0ZXTTU1ako5L0l6?=
 =?utf-8?B?amltTTBTKzZ0YUxkTzFKU0pDdDBqTXdJYjRJWXl1MWxKczg1cHN2RmlldTJx?=
 =?utf-8?B?REhoNEN3YjBlUFVKN1JmbEZZV2VuZ2dlMVFBRy9Kd2pESkVvNVhHV3p1eGNo?=
 =?utf-8?B?SG5iajZnUGxYdlI4Y0tYOTR4TXlhY2Q5cngyRnRwSy9VMHljbEdsbFZ3a0lB?=
 =?utf-8?B?b3pqeTFSbWprQzdWdjA4UGt5ekZlbjlvdGhJcWJqdkpiVG1JaTlRN3ViTVlO?=
 =?utf-8?B?ZUhPdnI4VGI4ZGMvTGJ0bVlhZjBDS0hMYVp5cWRlLzJnOFQrUEs0cFE0Q29X?=
 =?utf-8?B?QWowYzczNXZYeldicFZOZ05FazFRR3hyd2syM0FJWUpPRnlhbVh4MngrWFE2?=
 =?utf-8?B?YVdnUGF1c0kzbmptY2U4Ny9MZE9UY0FJeWJpcTNmZ1NPbHZ5VHRGM2t6MUhv?=
 =?utf-8?B?TWhUUmxkUENoR1UrZDVHcmtiMHZiY0pzdXdNc0huM0RkVy9DY21ZNldqNmhk?=
 =?utf-8?B?UExnTklhVm15YklhZnhTL1JsdERhbmdSTmlhYWYvOWt0U29BL2FxbjQ1akln?=
 =?utf-8?B?cFdCK1h2bzkydndyTGtydWs4azhjdTJZeVFhMU1FNnQzaWNiaERmTXArcEU3?=
 =?utf-8?B?TGlwRkFUcmI0UTZ2S0hCU0JVcnhobXRLcHRlZXpFeHVseXJpRVlhVFM0TmFM?=
 =?utf-8?B?aldZN1BVcmNzdjZYQUF2SiswTVU2YWhoOUJSQVJ2dGlKYjQ3TExRRHhLSUhm?=
 =?utf-8?B?Y3YzYXQ5WU90cW16V2pLRm8wK0dXUTBRbW9QWTVHdUxCNEoyYUJTZVF6eFdq?=
 =?utf-8?B?MkRxM2J3VEwvTkkyMjIyQ0FwTGJaVUY5QzFIaXJ2ZG1OUE9rbkoyS1k4SXow?=
 =?utf-8?B?dUlLU2tOb3U4aGV6T2ZwVXlWRWxhR29FUy9aV3pxYjlKdjUzQTJtbk43ZTRW?=
 =?utf-8?B?RVd1SythRHVnTmQzOWlSUys5KzZGTmRjci9haXRXWUlaVjNGNUJqeXBwNjMx?=
 =?utf-8?B?UjNZNy8zZisrU01VUlpMZnRLRVRVUEFFa09lNGNuMHdkRUl0bEVWMWRraU03?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b04f28-2290-4a0b-33e3-08db86e34947
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 16:31:34.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOGx/W5oJMEAxgGUqrS0bUNPuukhk2mFnBMstFx6yNB6u9XHET2EhPacgiIQY9ZHo0w+2YQfoeJvANL5amKX6b2XgxZXaWLIyKtUonBAUkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gRnJvbTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5j
b20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMDcvMTBdIHNwaTogcnp2Mm0tY3NpOiBTd2l0Y2gg
dG8gdXNpbmcNCj4ge3JlYWQsd3JpdGV9c3tiLHd9DQo+IA0KPiBIaSBBbmR5LA0KPiANCj4gVGhh
bmtzIGZvciB5b3VyIHJlcGx5Lg0KPiANCj4gPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHku
c2hldmNoZW5rb0BnbWFpbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwNy8xMF0gc3Bp
OiByenYybS1jc2k6IFN3aXRjaCB0byB1c2luZw0KPiA+IHtyZWFkLHdyaXRlfXN7Yix3fQ0KPiA+
DQo+ID4gT24gTW9uLCBKdWwgMTcsIDIwMjMgYXQgMTozNuKAr1BNIEZhYnJpemlvIENhc3Rybw0K
PiA+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gPiBGcm9t
OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+ID4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDA3LzEwXSBzcGk6IHJ6djJtLWNzaTogU3dpdGNoIHRvIHVzaW5nDQo+
ID4gPiA+IHtyZWFkLHdyaXRlfXN7Yix3fQ0KPiA+ID4gPiBPbiBTYXQsIEp1bCAxNSwgMjAyMyBh
dCAzOjA04oCvQU0gRmFicml6aW8gQ2FzdHJvDQo+ID4gPiA+IDxmYWJyaXppby5jYXN0cm8uanpA
cmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gLi4uDQo+ID4NCj4gPiA+ID4gQWNjb3JkaW5n
IHRvIHRoZSBoYXJkd2FyZSBkb2N1bWVudGF0aW9uWzFdLCB0aGUgYWNjZXNzIHNpemUgZm9yDQo+
ID4gYm90aA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gQ1NJX09GSUZPIGFuZCBDU0lfSUZJRk8gcmVn
aXN0ZXJzIGlzIDMyIGJpdHMsIHNvIHlvdSBtdXN0IHVzZQ0KPiA+IHdyaXRlbCgpDQo+ID4gPiA+
IHJlc3AuIHJlYWRsKCkuICBTbyBwbGVhc2UgY2hlY2sgd2l0aCB0aGUgaGFyZHdhcmUgcGVvcGxl
IGZpcnN0Lg0KPiA+ID4gPg0KPiA+ID4gPiBbMV0gUlovVjJNIFVzZXIncyBNYW51YWwgSGFyZHdh
cmUsIFJldi4gMS4zMC4NCj4gPiA+DQo+ID4gPiBZb3UgYXJlIHJpZ2h0LCBhY2Nlc3MgaXMgMzIg
Yml0cyAoYW5kIGFsdGhvdWdoIHRoaXMgcGF0Y2ggd29ya3MNCj4gPiBmaW5lLA0KPiA+ID4gd2Ug
c2hvdWxkIGF2b2lkIGFjY2Vzc2luZyB0aG9zZSByZWdzIGFueSBvdGhlciB3YXkpLiBOb3cgSQ0K
PiByZW1lbWJlcg0KPiA+ID4gd2h5IEkgZGVjaWRlZCB0byBnbyBmb3IgdGhlIGJlc3Bva2UgbG9v
cHMgaW4gdGhlIGZpcnN0IHBsYWNlLA0KPiA+IHdyaXRlc2wNCj4gPiA+IGFuZCByZWFkc2wgcHJv
dmlkZSB0aGUgcmlnaHQgcmVnaXN0ZXIgYWNjZXNzLCBidXQgdGhlIHdyb25nDQo+IHBvaW50ZXIN
Cj4gPiA+IGFyaXRobWV0aWMgZm9yIHRoaXMgdXNlIGNhc2UuDQo+ID4gPiBGb3IgdGhpcyBwYXRj
aCBJIGVuZGVkIHVwIHNlbGVjdGluZyB3cml0ZXN3L3dyaXRlc2IvcmVhZHN3L3JlYWRzYg0KPiB0
bw0KPiA+ID4gZ2V0IHRoZSByaWdodCBwb2ludGVyIGFyaXRobWV0aWMsIGJ1dCB0aGUgcmVnaXN0
ZXIgYWNjZXNzIGlzIG5vdA0KPiBhcw0KPiA+ID4gcGVyIG1hbnVhbC4NCj4gPiA+DQo+ID4gPiBJ
IGNhbiBlaXRoZXIgZmFsbGJhY2sgdG8gdXNpbmcgdGhlIGJlc3Bva2UgbG9vcHMgKEkgY2FuIHN0
aWxsDQo+ID4gPiByZW1vdmUgdGhlIHVubmVjZXNzYXJ5IHU4KiBhbmQgdTE2KiBjYXN0aW5nIDst
KSApLCBvciBJIGNhbiBhZGQNCj4gPiA+IG5ldyBBUElzIGZvciB0aGlzIHNvcnQgb2YgYWNjZXNz
IHRvIGlvLmggKGUuZy4gd3JpdGVzYmwsIHdyaXRlc3dsLA0KPiA+ID4gcmVhZHNibCwgcmVhZHN3
bCwgaW4gb3JkZXIgdG8gZ2V0IHRoZSBwb2ludGVyIGFyaXRobWV0aWMgcmlnaHQgZm9yDQo+ID4g
PiB0aGUgdHlwZSBvZiBhcnJheSBoYW5kbGVkLCB3aGlsZSBrZWVwaW5nIG1lbW9yeSBhY2Nlc3Mg
YXMNCj4gZXhwZWN0ZWQpLg0KPiA+ID4NCj4gPiA+IFdoYXQgYXJlIHlvdXIgdGhvdWdodHMgb24g
dGhhdD8NCj4gPg0KPiA+IEkgdGhpbmsgdGhhdCB5b3UgbmVlZCB0byB1c2UgcmVhZHNsKCkgLyB3
cml0ZXNsKCkgb24gdGhlIGN1c3RvbQ0KPiBidWZmZXINCj4gPiB3aXRoIHNvbWV0aGluZyBsaWtl
DQo+ID4NCj4gPiAqX3NwYXJzZSgpIC8gKl9jb25kZW5jZSgpIEFQSXMgYWRkZWQgKHBlcmhhcHMg
bG9jYWxseSB0byB0aGlzDQo+IGRyaXZlcikNCj4gPiBhcyB0aGV5IG1heSBiZSByZXVzZWQgYnkg
b3RoZXJzIGluIHRoZSBmdXR1cmUuDQo+ID4gSGF2aW5nIGFsbCBmbGF2b3VycyBvZiByZWFkKigp
L3dyaXRlKigpIGRvZXMgbm90IHNjYWxlIGluIG15DQo+IG9waW5pb24uDQo+IA0KPiBNYXliZSBh
ICJnZW5lcmljIiBtYWNybyB0aGVuIChvbmUgZm9yIHJlYWRpbmcgYW5kIG9uZSBmb3Igd3JpdGlu
Zyk/DQo+IFNvIHRoYXQgd2UgY2FuIHBhc3MgdGhlIGRhdGEgdHlwZSAodG8gZ2V0IHRoZSBwb2lu
dGVyIGFyaXRobWV0aWMNCj4gcmlnaHQpIGFuZCB0aGUgZnVuY3Rpb24gbmFtZSB0byB1c2UgZm9y
IHRoZSByZWFkL3dyaXRlIG9wZXJhdGlvbnMNCj4gKHRvIGdldCB0aGUgcmVnaXN0ZXIgb3BlcmF0
aW9ucyByaWdodCk/DQo+IE1heWJlIHRoYXQgd291bGQgc2NhbGUgYW5kIGNhdGVyIGZvciBtb3N0
IG5lZWRzIChpbmNsdWRpbmcgdGhlIG9uZQ0KPiBmcm9tIHRoaXMgcGF0Y2gpPw0KDQpTb21ldGhp
bmcgbGlrZSB0aGUgYmVsb3cgcGVyaGFwczoNCg0KI2lmbmRlZiByZWFkc3gNCiNkZWZpbmUgcmVh
ZHN4KGF0eXBlLCByZWFkYywgYWRkciwgYnVmZmVyLCBjb3VudCkJXA0KCSh7CQkJCQkJCQlcDQoJ
CWlmIChjb3VudCkgewkJCQkJXA0KCQkJdW5zaWduZWQgaW50IGNudCA9IGNvdW50OwkJXA0KCQkJ
YXR5cGUgKmJ1ZiA9IGJ1ZmZlcjsJCQlcDQoJCQkJCQkJCQlcDQoJCQlkbyB7CQkJCQkJXA0KCQkJ
CWF0eXBlIHggPSByZWFkYyhhZGRyKTsJCVwNCgkJCQkqYnVmKysgPSB4OwkJCQlcDQoJCQl9IHdo
aWxlICgtLWNudCk7CQkJCVwNCgkJfQkJCQkJCQlcDQoJfSkNCiNlbmRpZg0KDQojaWZuZGVmIHdy
aXRlc3gNCiNkZWZpbmUgd3JpdGVzeChhdHlwZSwgd3JpdGVjLCBhZGRyLCBidWZmZXIsIGNvdW50
KQlcDQoJKHsJCQkJCQkJCVwNCgkJaWYgKGNvdW50KSB7CQkJCQlcDQoJCQl1bnNpZ25lZCBpbnQg
Y250ID0gY291bnQ7CQlcDQoJCQljb25zdCBhdHlwZSAqYnVmID0gYnVmZmVyOwkJXA0KCQkJCQkJ
CQkJXA0KCQkJZG8gewkJCQkJCVwNCgkJCQl3cml0ZWMoKmJ1ZisrLCBhZGRyKTsJCVwNCgkJCX0g
d2hpbGUgKC0tY250KTsJCQkJXA0KCQl9CQkJCQkJCVwNCg0KCX0pDQoNCiNlbmRpZg0KDQpDaGVl
cnMsDQpGYWINCg0KPiANCj4gQ2hlZXJzLA0KPiBGYWINCj4gDQo+ID4NCj4gPiAtLQ0KPiA+IFdp
dGggQmVzdCBSZWdhcmRzLA0KPiA+IEFuZHkgU2hldmNoZW5rbw0K
