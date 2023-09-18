Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1817A4FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjIRQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjIRQti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:49:38 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B7F1A1;
        Mon, 18 Sep 2023 09:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRi3qzSpZequFiNqb+Zw3xxljCHej8f74tNA7dA+2CdTPqm722ygTZPifKdeCI5sM1TIysv5XmifGUs0tsMyH8VuGwxvCEeo1Ht+Cc7oWMOn0m+MJnuPT1Vb6X99a9iw9saxfv28aX4Vp0mYXaHcYO+ShPBLuqxWEJCNGIg//X3lN+D5hIbEKSH0L/Ih2VtEG5rNesrBMFPEX7RG3tYFzZyzC1MG55oeUdV7BOTtl14ZlMNgZIIuWDJPEacRvJqLdZ3z3pEUxm0+XGzYQx2i8p7vo15D4ZvLEDz+0/kjv8KgXam/mQ6IRBhbKbC+y+E06DnKLksrGhoUrVHpiPreww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16nNcA93xI1Ipv/9AVSzUUQXyGquG4r1e2/p2xNDDxc=;
 b=kXpPIMH6XaHFcXGwUaxhIQDSduTufW1ruCeKABP2CauG6YqLecicFADQ6+vlqxn41Kb9t8LNb7/DUtlh1QGbVXkjH4NU2S4qJUwkBXUteYVI0HfsJcX9S7gSNF8n69s9VUor3vtMpO4iO6/ep9BN+4BIOtOGd2xmzFy6OxLW4a9gGoM7VT/X6T3BqhjBdgNcI4epZg8zwLIh+Mnw9jrAzuEZWztDbHC1rW+sLumq43FTLw5ajeoApgThqY2ziwyKIuuELBVMybkTDmoqlgv8gKMbBvj14J+J4yIEMXP0QX9YNuVdtoaKEzuqN8EwD2rb6+L8HMzsyt/rW2cTV0cgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16nNcA93xI1Ipv/9AVSzUUQXyGquG4r1e2/p2xNDDxc=;
 b=relA4NNLjEgGnE52/gfLmKIolyJiXjKjE2ctlfbDrAf7ns4k7HJEjH934plTN7CO1AmHTKIjIXOujDDNrACPzyMKbGlUXE71n16Az4frYJDTKHy8Vgsxv5ZS/YVxDKBeYu7lrrex3EZyrW4wVkd/ojMW1L3Bj/ixG8Ray8TBjJ8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB6009.jpnprd01.prod.outlook.com (2603:1096:402:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:49:09 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:49:09 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: RE: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for GPIO
 interrupt input
Thread-Topic: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for
 GPIO interrupt input
Thread-Index: AQHZ6ixt37i5mirEkU2vvrutS3Og4rAgivWAgAAEY6CAAAObAIAAOCGw
Date:   Mon, 18 Sep 2023 16:49:08 +0000
Message-ID: <OS0PR01MB5922F7D95277D08A09A19F0C86FBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
 <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdVcy82eQNKtqufk8Nb6PKYTgmZw_b_mC+qgmGMHt1gyiw@mail.gmail.com>
 <OS0PR01MB5922356278D492FC32F0583586FBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWtHawgor2Hs3vZDcTv8WXWhUAzSRYBpM1cD=ozKT4G2w@mail.gmail.com>
In-Reply-To: <CAMuHMdWtHawgor2Hs3vZDcTv8WXWhUAzSRYBpM1cD=ozKT4G2w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB6009:EE_
x-ms-office365-filtering-correlation-id: bba3ff02-5f49-432e-92c9-08dbb8672da9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oPiApmZyggyiht3dmDfJGdmf6LxEKNHLjRSJymH+eHIZIZhZ6PrJpsVYHr/mtQnX/JtUceisBxX3Ioej4qYlPaenc9eFEnumyiwwLLqrQwBTeM8FQg7EO5t/ITHX4HV9AI/mbmHKrZVaeqiTSCXCk88UDIog6k+km0FFv4ZZMCkEupMO7qzWEiGQhS6aDcXB+9NVdEH+68DYbkBjDKFLVIXheB7MvNaQG+MlSwf7LDTHlFgtokajv/Tr9FIWEuqdTdxSqeEt0YuW61hRTdLiXMzqSwuo2Vt4GCX0btbD5rcgaLABJOIAxRFQuqRhHj4D0Z+8sCGmweYFT3f6Eruz/39owTxLeDtgbMobv/8DLMRWvJZwQEUTs6NcskreWDeh+Rzt/HSG+3F/qmIw4ktyFBhNF28YE3a7sWrut1KWWqRhAIgHhbYnuxg4iSFm0XU+Wp6/IJbCTw/ega6y6BRmtlxeJsjtcuOVofQYOSaILjeqT6SfZQ6Wq5i5Tgjeui9WZnSQbi2e1RH7X7LwIqU6ElGyst1KOIHiq/4s/klMAM8v+33z74Pgmumh83swlEfSNLNmhbXCHVl7HRauoZb5EZjk9iDyXSaWCkCIKDg7nY3elYO2vqUVevNs8y5z4WRD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199024)(186009)(1800799009)(6506007)(478600001)(55016003)(71200400001)(26005)(86362001)(2906002)(83380400001)(5660300002)(52536014)(7696005)(122000001)(76116006)(9686003)(53546011)(6916009)(54906003)(316002)(66556008)(66476007)(66446008)(64756008)(41300700001)(8936002)(8676002)(38100700002)(4326008)(38070700005)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2pFMlRER0pnRERPOVljUmZEUDloQjgrTDZkN3Q1R05DcjA4TVNJY2NleVdw?=
 =?utf-8?B?R1N5RllHakxNalVqMkt4N0lwVEltVTgzajJHU0FpZkpBQTlSZHRMcW1NTmZ5?=
 =?utf-8?B?blZsc3RXNXFTbzNpaE5jSUJGQjRqcnV2SlVYWUd1OG5QYnY3V0toZzBhYkkv?=
 =?utf-8?B?MVN4cUtOdGx4WlpJS0J6dUZZQ1Z2SmdFeCsrMG8vb0ltSkdwQ3NSZmRUZmRB?=
 =?utf-8?B?THBCL0t3aDVKNlp3Qy9nbVRNWHVQWDFDclI5K3BFZ2xQVzR3RExhaGF2YVox?=
 =?utf-8?B?b0hJSUw5ZnJqL0ZsSVV5TTBKR2VBT3hjVDVqcVR6dmVwWEVTTUx2VGRrNTZW?=
 =?utf-8?B?SmR5M1lGUkxOemt6aElDTG9RMHhudUlTRHpzMXpPSVRFUnhzODZCeExkdmlv?=
 =?utf-8?B?SEVZMG8vVzlBdFhRbXVtOGVHajhGeGFCZ2Z2QU1QdjdWN1JUUUk1emMzUmhi?=
 =?utf-8?B?YzBFNGtnTEhCL3F3TS9QMkppQzcrcndZd3o0bFhPV0lkRy8xQ3FtV09nbVlI?=
 =?utf-8?B?VjlXVUlTdTJSdXh5OXZvUjNuaHhtNURCS2x3OFlIckd1UmxnMXdyZGRHcFhT?=
 =?utf-8?B?UURoWWhoMGE3YzU2Q3dRaFBFbUxhMldSREN5bzNwZUMvNDdSbDhkbHNjN0JH?=
 =?utf-8?B?YkhqUkhZRGZ0eWhadmVBVThQMllncGMzZXNJa1VKZm9YT3JJbTBERGFtbmhW?=
 =?utf-8?B?bXVBMlc3TGx6WUJFQTgrNW5TaGRCQWNTd3R1VGtpYVpsYmRlYmgzcUVOSUs0?=
 =?utf-8?B?d3hmeWhQVUk3RkxNRUdlTnp1N09CeFNJVWtVd1RoNk10cVJMK0ErRXdMZ0Vz?=
 =?utf-8?B?dVE1cjNFN0haVnlhZndSY2NTbkYwdmU0eTV1UWl4WDV5MTFnT1ZaQXNwNkNs?=
 =?utf-8?B?aXhyamJMWlBUY2xvTkxsTUQzNDU2dnZCVjFPb3Y1VC9qY3JacWgrWmpjTHJD?=
 =?utf-8?B?dGJGZjFKYUFWT01xejVyNmdvRlBBSTVWR3hhRjJheWcvelhNaVMxMGR4N3lS?=
 =?utf-8?B?c1p6MHFNNFgxNmRQVkttelVSVmNIczhJRXNNcEFpRk4vMDloVlJQclVvNVJi?=
 =?utf-8?B?US9USjdGdlZHYk16T0w3aU9LSW5WVmxiYW93SUU5Z3pZWXBnOGFNVFNCTmd2?=
 =?utf-8?B?c1NsVXFQTFhDR0lEbFo1eEdHRSs2REttaElLM3FINmZwdGsyUy83d1JKbVli?=
 =?utf-8?B?dkNiQkZFc0dkcUhPUWFjc2dvb1RFejh1cWtWYWlxTDE1d3IxLytGNUdjWVZR?=
 =?utf-8?B?a0toaTY0MnNncUw1cWVHZHpiWDdZdWJ3bEswQ2FFcFJFYTRVQXkvQitTM0Jq?=
 =?utf-8?B?UC85cmpuZTdMRHN3RjhPSlhsY0llTVdvY1IyWTduNENIQTFUVHNBWEsyKzZr?=
 =?utf-8?B?RVpNMndMak5XUXdLcjUrbEl5YjZpOGJGWVVnbFZzOXBkaGw2ZEREWWlJVWg3?=
 =?utf-8?B?dzB2c0dqRXd2VWVzeVRyOXVLVjBiQkVkdCtxd2JCOVpBeUVXNGlETkZnRHMx?=
 =?utf-8?B?MVlpNmxQcUxoUEJGR25uOE12Vi9oa0VIZVc4SXVvc1lXK1NVbVhZWk5DWUZv?=
 =?utf-8?B?TTJjNjNMVXVpNWYyeEVEaFJYdzZxeUxKbzJjYzkzdXRscW0xbGJ3RUl0Y200?=
 =?utf-8?B?eDRqeDE5MWxvcEZJckNwUEJMNDI3WkJhelMrR0lpa0U2TlA1Nk5rTzVjTGcz?=
 =?utf-8?B?TWV1cVlReVoyRWxvREZEMURPbzVncGtpMFFRM1pPTENSbjJDejB1aW5ScHVa?=
 =?utf-8?B?eW5HZTR2RzdtbVlpL2x4b1F6TFFzbzZEWUJucW5DVjlRMG9RZnhtQ0R6VWRx?=
 =?utf-8?B?Z0hZN1E2Um1pOHVmUHFSSXBTc0U0amdyV1dPOHRpYTVnU0J4UVJZbjRxT3VY?=
 =?utf-8?B?SkpKUmpQQTdHSmsxaUd5d3ZuVW9kck9FVGd5Ly92ZGwydUZsZ0ZBT3d0TnFP?=
 =?utf-8?B?Um10NUJ1cHpQR0VzS0s4WDRBNUNGalNkNVlqR3ZCdUgyOFdvdTk3UkRXWjcz?=
 =?utf-8?B?aldmdmYwVDFoUkpQeXFXL2dWb0s0OGtJR3YvTmtuUVNPakJ2SnBKeWtqalVz?=
 =?utf-8?B?aTJZZ010TkhsaUt4WGlLSlFoUU9xRmNFRUpHMjlESStWeWQ2WEI5TXdSRG5Q?=
 =?utf-8?B?eWkwQXc5NFVXZEdSSTRmNXVyVEVvZ1dNanJkcDJuYkVzaG84N0duSzFPamxN?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba3ff02-5f49-432e-92c9-08dbb8672da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 16:49:09.0030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AOpGodfv1RHZIyzDonycRxK+cerIkPOAK6rjb+Ger6qKmGRGvmrvX4O9BFhRcLFs0PN1R9RhUP++oT+HFYk3gtVEJ08PM8Q0PBPhXOqrs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6009
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIHBpbmN0cmw6IHJlbmVzYXM6
IHJ6ZzJsOiBFbmFibGUgbm9pc2UgZmlsdGVyIGZvcg0KPiBHUElPIGludGVycnVwdCBpbnB1dA0K
PiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIE1vbiwgU2VwIDE4LCAyMDIzIGF0IDM6MTjigK9QTSBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIHBpbmN0cmw6IHJlbmVzYXM6IHJ6ZzJsOiBFbmFibGUgbm9p
c2UNCj4gPiA+IGZpbHRlciBmb3IgR1BJTyBpbnRlcnJ1cHQgaW5wdXQNCj4gPiA+DQo+ID4gPiBP
biBNb24sIFNlcCAxOCwgMjAyMyBhdCAyOjM04oCvUE0gQmlqdSBEYXMNCj4gPiA+IDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBBcyBwZXIgUlovRzJM
IGhhcmR3YXJlIG1hbnVhbCBSZXYuMS4zMCBzZWN0aW9uIDguNy4zIEdQSU8NCj4gPiA+ID4gSW50
ZXJydXB0DQo+ID4gPiA+IChUSU5UKSBhbmQgNDEuNC4xIE9wZXJhdGlvbiBmb3IgR1BJTyBmdW5j
dGlvbiwgd2UgbmVlZCB0byBzZXQNCj4gPiA+ID4gZGlnaXRhbCBub2lzZSBmaWx0ZXIgZm9yIEdQ
SU8gaW50ZXJydXB0Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIGVuYWJsZXMgbm9pc2Ug
ZmlsdGVyIGZvciBHUElPIGludGVycnVwdCBpbg0KPiA+ID4gPiByemcybF9ncGlvX2lycV9lbmFi
bGUoKSBhbmQgZGlzYWJsZSBpdCBpbiByemcybF9ncGlvX2lycV9kaXNhYmxlKCkuDQo+ID4gPiA+
DQo+ID4gPiA+IEZpeGVzOiBkYjJlNWYyMWE0OGUgKCJwaW5jdHJsOiByZW5lc2FzOiBwaW5jdHJs
LXJ6ZzJsOiBBZGQgSVJRDQo+ID4gPiA+IGRvbWFpbiB0byBoYW5kbGUgR1BJTyBpbnRlcnJ1cHQi
KQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+DQo+ID4gPiA+IFRlc3RlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
LnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCEN
Cj4gPiA+DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9yZW5lc2FzL3BpbmN0cmwtcnpn
MmwuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5jdHJsLXJ6ZzJs
LmMNCj4gPiA+ID4gQEAgLTk2LDYgKzk2LDcgQEANCj4gPiA+ID4gICNkZWZpbmUgUElOKG4pICAg
ICAgICAgICAgICAgICAoMHgwODAwICsgMHgxMCArIChuKSkNCj4gPiA+ID4gICNkZWZpbmUgSU9M
SChuKSAgICAgICAgICAgICAgICAgICAgICAgICgweDEwMDAgKyAobikgKiA4KQ0KPiA+ID4gPiAg
I2RlZmluZSBJRU4obikgICAgICAgICAgICAgICAgICgweDE4MDAgKyAobikgKiA4KQ0KPiA+ID4g
PiArI2RlZmluZSBGSUxPTk9GRihuKSAgICAgICAgICAgICgweDIwODAgKyAobikgKiA4KQ0KPiA+
ID4gPiAgI2RlZmluZSBJU0VMKG4pICAgICAgICAgICAgICAgICAgICAgICAgKDB4MmM4MCArIChu
KSAqIDgpDQo+ID4gPiA+ICAjZGVmaW5lIFBXUFIgICAgICAgICAgICAgICAgICAgKDB4MzAxNCkN
Cj4gPiA+ID4gICNkZWZpbmUgU0RfQ0gobikgICAgICAgICAgICAgICAoMHgzMDAwICsgKG4pICog
NCkNCj4gPiA+DQo+ID4gPiBMR1RNLCBidXQgc2hvdWxkbid0IHlvdSBjb25maWd1cmUgdGhlIERp
Z2l0YWwgTm9pc2UgRmlsdGVyIE51bWJlcg0KPiA+ID4gKEZJTE5VTSkgYW5kIENsb2NrIFNlbGVj
dGlvbiAoRklMQ0xLU0VMKSByZWdpc3RlcnMsIHRvbz8NCj4gPg0KPiA+IEN1cnJlbnRseSBpdCB1
c2VzIHJlc2V0IHZhbHVlcy4NCj4gPg0KPiA+IDAwYjogNC1zdGFnZSBmaWx0ZXIgKDQxLjY2NiBu
cyB4IDQgPSAxNjYuNjY2IG5zKSAoaW5pdGlhbCB2YWx1ZSkgZm9yDQo+ID4gRklMTlVNIGFuZA0K
PiA+DQo+ID4gMDBiOiBOb3QgZGl2aWRlZCAoaW5pdGlhbCB2YWx1ZSkgZm9yIEZJTENMS1NFTA0K
PiA+DQo+ID4gRG8geW91IG1lYW4gd2Ugc2hvdWxkIHByb3ZpZGUgdGhlc2Ugc2V0dGluZ3MgdG8g
RFQsIHNvIHRoYXQgaXQgaXMNCj4gPiBjdXN0b21pc2VkIGJhc2VkIG9uIHRoZSBQQ0IgZGVzaWdu
IGFuZCB0aGUgZW52aXJvbm1lbnQgdGhlIGJvYXJkIGlzDQo+ID4gdXNlZCBpbj8gSSBndWVzcyB0
aGlzIHdpbGwgbWFrZSBpdCBlYXNpZXIgZm9yIGN1c3RvbWVycyB0byBtYWtlIHRoZQ0KPiA+IHJl
cXVpcmVkIGNoYW5nZXMgZm9yIHRoZWlyIGFwcGxpY2F0aW9uLg0KPiANCj4gSWYgdGhlIG9wdGlt
YWwgdmFsdWVzIGFyZSBib2FyZC1kZXBlbmRlbnQsIHlvdSBzaG91bGQgaW5kZWVkIGFkZCBhIHdh
eSB0bw0KPiBjb25maWd1cmUgdGhpcyBmcm9tIERULg0KDQpMb29rcyBsaWtlIHRoZSBhYm92ZSB2
YWx1ZXMgYXJlIHNpZ25hbCBiYXNlZC4gSSBhbSBjaGVja2luZyB3aXRoIEhXIHBlcnNvbiBhYm91
dCB0aGlzLiBJIHdpbGwgY29uZmlybSBvbmNlIEkgaGF2ZSB1cGRhdGUgb24gdGhpcy4NCg0KQ2hl
ZXJzLA0KQmlqdQ0K
