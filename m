Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA367A771C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjITJVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjITJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:21:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2095.outbound.protection.outlook.com [40.107.113.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18828DD;
        Wed, 20 Sep 2023 02:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFh3cNCw4SNnw+VIoeOLZdRxoXLUQOlxQuRIhwaCIlMRHp3qgNBkbpUPOXFh7lRWm8P8QPJzeK3cSd0ZcB/lThFS6iv2V2OPIsTWz1lWS8uj07ahl3EMNpmClhOZuksjqjeomd49oHIXcH2IUc3t+qUEa8jqUN0UU3EM8GXWhsaYvAwXs8NLB0jPbLvCXqaile2UqV1YE0RJBpTzcvIUL76QWMXarbbVhh5udWcEXzzyIpYUHy8S/MPcxPiGTAghwgc2b9KRfZZSvVy6wRGyT82mFmiLCKU63v2w6X3Mp2Jn5LeTSArR867ih+6/ziNjSvaRZg5w0EJpZ00xkRJT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAS3KFxRJCFU9q1W/ZN+tP1AVx7DZMl6HWkOH78+As0=;
 b=AHmwaAKYABG19bU3CK3KYhObrsE8z0HiBxOu6WbyaUKLBLk9evEYROk7l3LuxrvpM6jk7liRGT5SwFjpanndDyZEjxDSsnM7KYnOVqiZqAjP4Qc+TnIHD72C/W1y3EZ1zzm5TBu+VMYhLTyGAGFAAqfouRzOdBEHbPoeoSQdBTK2uwZ9QJowTY4c55O1TOYQAYDB8zYieC5knvUpaOvhqxeOQA+JyrpUq4jIAAGR7T/gkCEsnmpYPybA3UgJg43ODfLCSdYPm39+h54dNrvYCh1Qej1M9D5nB/zgb5bWfAev9iAMxWWd65iwfQ97R/il3R2RL/dfAOoQb0eqpnZyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAS3KFxRJCFU9q1W/ZN+tP1AVx7DZMl6HWkOH78+As0=;
 b=RgiwZNvHN9XFxGOcvg4S7hceku6lQ7BJaD6WpJMfOG3AXr9qQjjTaT8up0L/NF7DtHlxGyctO8wqfq0m6h9ygaVpcUEgP2Zm/NfnnX2wbbiaonW9bzdZTlLFYedFAj4rvJfQPJ4zRBgED6B3DChb7LvOlUs/73EA7UJITX41Fb8=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OS7PR01MB12067.jpnprd01.prod.outlook.com (2603:1096:604:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 09:20:56 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::8e13:cc46:2137:9b03]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::8e13:cc46:2137:9b03%7]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 09:20:56 +0000
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
Thread-Index: AQHZ6ixt37i5mirEkU2vvrutS3Og4rAgivWAgAAEY6CAAAObAIAAOCGwgAKmNDA=
Date:   Wed, 20 Sep 2023 09:20:56 +0000
Message-ID: <TYCPR01MB59338802F3FA5F4EBE73A2E486F9A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
 <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdVcy82eQNKtqufk8Nb6PKYTgmZw_b_mC+qgmGMHt1gyiw@mail.gmail.com>
 <OS0PR01MB5922356278D492FC32F0583586FBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWtHawgor2Hs3vZDcTv8WXWhUAzSRYBpM1cD=ozKT4G2w@mail.gmail.com>
 <OS0PR01MB5922F7D95277D08A09A19F0C86FBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922F7D95277D08A09A19F0C86FBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OS7PR01MB12067:EE_
x-ms-office365-filtering-correlation-id: a83124f4-bcb7-4ca9-0506-08dbb9bae531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SWnvTlysl3N4T/jq2ikymXb4GeCMNM/ewxPr03t47EIg6iOtFcHkBx7YB09vnjIdDbzQLfqManuvh3XPYpP/Ssft1I06wd9IJkVFlqBlUoTeuijokcDdDKNPFfiKse7yepiwFbl9OlsXU9ylVtyblRwxGb3XGZVKyoTl6VnVJVWP3pL8TNL3YfKjMtSwt+sPr6O3h/FUF8YBl9itbI0aG/JFLk/huWqRMULuVH1HzDV6nB7SKHQnAmufJTi7+AN2DEUWTFosuiKFqAeAk8lw3Gu6hONwvEFPlWDtXiEtywjfteDPzXPjtQhMI1KRzvRqZ1PovItG8wctIZqbZEXPP4CzY/ibSQe+bDZZzdFKQr7wWF4hmXJLoRRYaDm46AQzhrMUzwFq2Q+HPe6T356vVaN/kLotBiGLQFWJkZW1GLtkUXO/c84hrdOjARndekhvVpHDzgaTsnU/2DYKUb1XnT7ebxHCBkM8e8X3Cbxceym9Kkq95VSSapPCZ+qmtQIIfDSGOo0/kuPPCl2T1ayizGxkDrl99adJ0fsYUfJGzXQXct0ISIOXPIx+PALSMQu6Guu9A+kLpaSuxiR97eo9wk4bP4udYM4rKYKMCYZIRQzsUh2kqMS0ntLSHFrWQBtT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(55016003)(66946007)(66476007)(66446008)(64756008)(76116006)(66556008)(54906003)(6916009)(316002)(478600001)(71200400001)(122000001)(38070700005)(38100700002)(2906002)(33656002)(86362001)(41300700001)(8936002)(5660300002)(52536014)(4326008)(8676002)(26005)(83380400001)(6506007)(7696005)(53546011)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUxyVVNQRUlTWEl3elZHNmV6aVVwL1l6YzZJWWdRbWlwME9PT0h4eFR0cHFp?=
 =?utf-8?B?eTEweHFqWlBQeVdjdGk5SkFXcGlQU2RvRlIva0lHbEVGYmRDQ3VnL05xMzRF?=
 =?utf-8?B?SzZlZ0xzTHQ5V0dnMi9SSWU4NlRMODFPRzBGYTlJZ0hXLzMzTXpHTnozend6?=
 =?utf-8?B?Z2RHRmdick9vcVE0Z3BTUUhaVnRnNTM0VUczSkIyY29kRElwYXlkVUsxZEx5?=
 =?utf-8?B?L3RXMkVMR1FycU80ekttdTFoQ0pid2Rrc2grV3Z3U21sZHY4TTBWQytQTzRK?=
 =?utf-8?B?UlpTRHBJaXpUMXVOUHd6a3dQZEhXTlN3WEwyWDlhZ0tlbUJCNXduTzNKTFI4?=
 =?utf-8?B?YlBFa3JYSElyWU9PYUFUeW00cHRzdjFWYXFsT0NkZkhLMURudW9ibjB6SC9B?=
 =?utf-8?B?MmEyTzg4NGUzY1RzdW9COEpzQmJoVExZZUxxZ3dVZ0dqMzVyRlF1WTdvSGxv?=
 =?utf-8?B?WUZUa29ZYWUzbzVteE5LMVJCb1FScVZkQzVzODJCYTN6anBnWnNudEpzYlph?=
 =?utf-8?B?ZTJlaFJ5eStzd0Uvc1dQcjVGRWRFOVdZajhXb1UzWDlEOU1nbmVSYmlyeWo0?=
 =?utf-8?B?Qmc0dytzV29nTDJsODYraHhXdkhnM241clNxNndaQkNQMnhzREw2NjVuVUdG?=
 =?utf-8?B?WFZlSERxU3FjdmU3bUhnZ213cUtCdFYwNGdKV25jcFk1dkFwRlJWb3FGMHQz?=
 =?utf-8?B?ZjRJa1lRL0poZ3VQUHNTUUxJN3QyeFNnUW0zdDJUMldhaVFvU1owSXZXUHRy?=
 =?utf-8?B?R0l0U3ErVkVSU241ZjluYnNjakkrUkR6aTYzMGowd0ZrQVpVWnl6enpsN2gy?=
 =?utf-8?B?TGRLYm91N1ZIYUZrVWg0V0NldXZoejdCc1YraWI0eHhVczF2M3BpN0J3OVNi?=
 =?utf-8?B?Q05HVWdRNFFnT2s5QTJjSFdJRjIyeUJwVThORVR3eXBvODI5R2JzUzZOYUs1?=
 =?utf-8?B?aXl4S251Vlo1bXRQcmhNTTZ0YkUzUzEzY0J2cXhrSVZZcTQxYXY4Y3V5YnNz?=
 =?utf-8?B?Tm1XMldBd2dIaTBPNmQ5cWRYSURtdzNZVFE0b1NkeXkxbGJteGd3NTFvUjdU?=
 =?utf-8?B?VHJVQmJrY3l3NElZYW1DN2hmRGcyWHlGUnF1M0NXQndWUStGNWgrUG1xZWIz?=
 =?utf-8?B?dUJ3WGxWcUU1QWNpcTQzbzE5TFVRZzNzUGwrbUNzR1JITGRWbVBLTnY2UjNO?=
 =?utf-8?B?VjNVQUxVZ0JKYU5KNVVFdVpNZk0xUXgra3laRXhkMlBxcWs5b0FTYkxUeWZO?=
 =?utf-8?B?cCthMmszSkJxVXRCZjJGdVJxSkZvdzZ1Tm84Nk11elpFNVppR0JVZ0NNdUNm?=
 =?utf-8?B?dmtSVTcrdWpzSlJaZW53SnJzbWU4YlZOUFZxenU2RVRWQTRUT3h4Rnllekcx?=
 =?utf-8?B?SEhlalIvSU9rUlZ1QzNhcUoybTlGQWhZQ1YwbmlsU2pFSnF2R3MwTytBckNR?=
 =?utf-8?B?ZzVjbWhzbDR1QkUrM0xZNk51UXl5T0UrY1cyb2wvMXl3TUlKSnNjMTZjdFZU?=
 =?utf-8?B?RE9JVWJRUlVwL2V0Y3laVlBDOFA2dlBSV0VzUTNEUVIxdUJ3NmtBM0FsM1pD?=
 =?utf-8?B?L01LaHE3dEJOR2NyaFRHYUVLejlEWDFoejlLc1ZaR2RVaTA4SWUxTTZGTkho?=
 =?utf-8?B?czZJM0xGcFRzOVVGWHA2VmFvR0NuRWd6TWxWRXlEUHVHaTgyZ0JQb0IrdThC?=
 =?utf-8?B?K3c4WDBhVllZcVpBTjEvM0YxTXA2YlA0bWJMMmFPQVhwNGVZTEFWS0xWcDdj?=
 =?utf-8?B?NWR3ZG9WTHdaVG1qYlozV1IxNHFxNnRDd1FkK1RNT0pjcEdBS1VtNHBSWjJ5?=
 =?utf-8?B?SEpjbWNudkdKNXVrWmhyVHVIa00yYmNUN0pONmE5Nit2RUZnelBZL0FxSWZs?=
 =?utf-8?B?Zm1Jb0ZYcTAzeUxSYnF4eGg5ZkZMNCtuSWlpbzU0VGRiWGxLbncrenJLU0Ju?=
 =?utf-8?B?STBNZ1lLbzk2cUN0d3p5V1JaUkYyMDZYdWxHSXUrbHZFS2RmbU42L3FzRDVT?=
 =?utf-8?B?TDZJaklIT2kyelRLYUNURWhlM3VmMkx3dy9kVDY4RXczWkE0MC9UZWFoQStQ?=
 =?utf-8?B?MzBOOFFiRmRPSTBJK0ZQVlJPRnRiUDkxN2N6d3ROZTRXUlB0NURQUzlPZVNt?=
 =?utf-8?B?RWwyYUZFdUd0bjJ2SzlTZGExeUg3UUw1WlVGVG1zRHRjZCtNZWdBTWRPMnU3?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83124f4-bcb7-4ca9-0506-08dbb9bae531
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 09:20:56.3262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Lj2eyPJuubG2zTu7Ks+X9t2VRjlvm96fMrqR9+6Wb5VJnQHHQZK9dXAMcMQaa/AfgYz+nJFCvq0mBslS+Y7O4apF+XorEmd5Ao8/kF1Yk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8yXSBwaW5j
dHJsOiByZW5lc2FzOiByemcybDogRW5hYmxlIG5vaXNlIGZpbHRlciBmb3INCj4gR1BJTyBpbnRl
cnJ1cHQgaW5wdXQNCj4gDQo+IEhpIEdlZXJ0LA0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IDIvMl0gcGluY3RybDogcmVuZXNhczogcnpnMmw6IEVuYWJsZSBub2lzZSBmaWx0ZXINCj4gPiBm
b3IgR1BJTyBpbnRlcnJ1cHQgaW5wdXQNCj4gPg0KPiA+IEhpIEJpanUsDQo+ID4NCj4gPiBPbiBN
b24sIFNlcCAxOCwgMjAyMyBhdCAzOjE44oCvUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0g
cGluY3RybDogcmVuZXNhczogcnpnMmw6IEVuYWJsZSBub2lzZQ0KPiA+ID4gPiBmaWx0ZXIgZm9y
IEdQSU8gaW50ZXJydXB0IGlucHV0DQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1vbiwgU2VwIDE4LCAy
MDIzIGF0IDI6MzTigK9QTSBCaWp1IERhcw0KPiA+ID4gPiA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IEFzIHBlciBSWi9HMkwgaGFyZHdhcmUg
bWFudWFsIFJldi4xLjMwIHNlY3Rpb24gOC43LjMgR1BJTw0KPiA+ID4gPiA+IEludGVycnVwdA0K
PiA+ID4gPiA+IChUSU5UKSBhbmQgNDEuNC4xIE9wZXJhdGlvbiBmb3IgR1BJTyBmdW5jdGlvbiwg
d2UgbmVlZCB0byBzZXQNCj4gPiA+ID4gPiBkaWdpdGFsIG5vaXNlIGZpbHRlciBmb3IgR1BJTyBp
bnRlcnJ1cHQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGVuYWJsZXMgbm9pc2Ug
ZmlsdGVyIGZvciBHUElPIGludGVycnVwdCBpbg0KPiA+ID4gPiA+IHJ6ZzJsX2dwaW9faXJxX2Vu
YWJsZSgpIGFuZCBkaXNhYmxlIGl0IGluIHJ6ZzJsX2dwaW9faXJxX2Rpc2FibGUoKS4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEZpeGVzOiBkYjJlNWYyMWE0OGUgKCJwaW5jdHJsOiByZW5lc2FzOiBw
aW5jdHJsLXJ6ZzJsOiBBZGQgSVJRDQo+ID4gPiA+ID4gZG9tYWluIHRvIGhhbmRsZSBHUElPIGlu
dGVycnVwdCIpDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6
QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPiA+IFRlc3RlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNs
YXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3Mg
Zm9yIHlvdXIgcGF0Y2ghDQo+ID4gPiA+DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9waW5jdHJs
L3JlbmVzYXMvcGluY3RybC1yemcybC5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9waW5jdHJs
L3JlbmVzYXMvcGluY3RybC1yemcybC5jDQo+ID4gPiA+ID4gQEAgLTk2LDYgKzk2LDcgQEANCj4g
PiA+ID4gPiAgI2RlZmluZSBQSU4obikgICAgICAgICAgICAgICAgICgweDA4MDAgKyAweDEwICsg
KG4pKQ0KPiA+ID4gPiA+ICAjZGVmaW5lIElPTEgobikgICAgICAgICAgICAgICAgICAgICAgICAo
MHgxMDAwICsgKG4pICogOCkNCj4gPiA+ID4gPiAgI2RlZmluZSBJRU4obikgICAgICAgICAgICAg
ICAgICgweDE4MDAgKyAobikgKiA4KQ0KPiA+ID4gPiA+ICsjZGVmaW5lIEZJTE9OT0ZGKG4pICAg
ICAgICAgICAgKDB4MjA4MCArIChuKSAqIDgpDQo+ID4gPiA+ID4gICNkZWZpbmUgSVNFTChuKSAg
ICAgICAgICAgICAgICAgICAgICAgICgweDJjODAgKyAobikgKiA4KQ0KPiA+ID4gPiA+ICAjZGVm
aW5lIFBXUFIgICAgICAgICAgICAgICAgICAgKDB4MzAxNCkNCj4gPiA+ID4gPiAgI2RlZmluZSBT
RF9DSChuKSAgICAgICAgICAgICAgICgweDMwMDAgKyAobikgKiA0KQ0KPiA+ID4gPg0KPiA+ID4g
PiBMR1RNLCBidXQgc2hvdWxkbid0IHlvdSBjb25maWd1cmUgdGhlIERpZ2l0YWwgTm9pc2UgRmls
dGVyIE51bWJlcg0KPiA+ID4gPiAoRklMTlVNKSBhbmQgQ2xvY2sgU2VsZWN0aW9uIChGSUxDTEtT
RUwpIHJlZ2lzdGVycywgdG9vPw0KPiA+ID4NCj4gPiA+IEN1cnJlbnRseSBpdCB1c2VzIHJlc2V0
IHZhbHVlcy4NCj4gPiA+DQo+ID4gPiAwMGI6IDQtc3RhZ2UgZmlsdGVyICg0MS42NjYgbnMgeCA0
ID0gMTY2LjY2NiBucykgKGluaXRpYWwgdmFsdWUpIGZvcg0KPiA+ID4gRklMTlVNIGFuZA0KPiA+
ID4NCj4gPiA+IDAwYjogTm90IGRpdmlkZWQgKGluaXRpYWwgdmFsdWUpIGZvciBGSUxDTEtTRUwN
Cj4gPiA+DQo+ID4gPiBEbyB5b3UgbWVhbiB3ZSBzaG91bGQgcHJvdmlkZSB0aGVzZSBzZXR0aW5n
cyB0byBEVCwgc28gdGhhdCBpdCBpcw0KPiA+ID4gY3VzdG9taXNlZCBiYXNlZCBvbiB0aGUgUENC
IGRlc2lnbiBhbmQgdGhlIGVudmlyb25tZW50IHRoZSBib2FyZCBpcw0KPiA+ID4gdXNlZCBpbj8g
SSBndWVzcyB0aGlzIHdpbGwgbWFrZSBpdCBlYXNpZXIgZm9yIGN1c3RvbWVycyB0byBtYWtlIHRo
ZQ0KPiA+ID4gcmVxdWlyZWQgY2hhbmdlcyBmb3IgdGhlaXIgYXBwbGljYXRpb24uDQo+ID4NCj4g
PiBJZiB0aGUgb3B0aW1hbCB2YWx1ZXMgYXJlIGJvYXJkLWRlcGVuZGVudCwgeW91IHNob3VsZCBp
bmRlZWQgYWRkIGEgd2F5DQo+ID4gdG8gY29uZmlndXJlIHRoaXMgZnJvbSBEVC4NCj4gDQo+IExv
b2tzIGxpa2UgdGhlIGFib3ZlIHZhbHVlcyBhcmUgc2lnbmFsIGJhc2VkLiBJIGFtIGNoZWNraW5n
IHdpdGggSFcgcGVyc29uDQo+IGFib3V0IHRoaXMuIEkgd2lsbCBjb25maXJtIG9uY2UgSSBoYXZl
IHVwZGF0ZSBvbiB0aGlzLg0KDQpJIHJlY2hlY2tlZCB0aGlzLA0KDQpBcyBwZXIgc2VjdGlvbiA4
LjcuMyBHUElPIEludGVycnVwdCAoVElOVCksIEl0IGlzIG5vdCBhIG11c3QuIEJ1dCB3ZSBzaG91
bGQgaGF2ZSB0aGUgZmxleGliaWxpdHkgdG8gY29uZmlndXJlIHRocm91Z2ggRFQuDQoNCiAiVGhl
IG5vaXNlIGZpbHRlciBmdW5jdGlvbiBvZiBHUElPIHBpbnMgYXNzaWduZWQgdG8gVElOVCBjYW4g
YmUgZW5hYmxlZCBieSBHUElPIHJlZ2lzdGVyIHNldHRpbmcuIg0KDQpUaGUgY29uZnVzaW9uIGNh
bWUgYmVjYXVzZSBvZiB0aGUgc2VjdGlvbiAiNDEuNC4xIE9wZXJhdGlvbiBmb3IgR1BJTyBGdW5j
dGlvbiINCg0K4pePIFNldCB0aGUgRklMT05PRkYgcmVnaXN0ZXIgd2hlbiB1c2luZyBHUElPIHRv
IHNldCBhIGRpZ2l0YWwgbm9pc2UgZmlsdGVyIGZvciBpbnRlcnJ1cHQgaW5wdXQgYW5kIEdQSU8g
aW5wdXQuDQoNClNvIEkgd291bGQgbGlrZSB0byBkcm9wIHRoaXMgcGF0Y2ggYW5kIHdpbGwgc2Vu
ZCBzZXBhcmF0ZSBwYXRjaGVzDQpmb3IgY29uZmlndXJpbmcgaXQgdGhyb3VnaCBEVCwgaWYgYW55
b25lIHBsYW5zIHRvIHVzZSBkaWdpdGFsIG5vaXNlDQpmaWx0ZXJzLg0KDQpDaGVlcnMsDQpCaWp1
DQoNCg0KDQoNCg0K
