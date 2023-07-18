Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18F757B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjGRMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjGRMIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:08:38 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4741BFD;
        Tue, 18 Jul 2023 05:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4NZFzPeCTYmGp3mtIFYuayRKH/icf5wpQ911JwKrPOhJEwKYDE2AhIcfUNZY/80rTECbViJJdB6hf6ufrR3T0LHKqByH9pn8js/Giwh3740jBm8dYDr9BxQRVYX7oeSr1d6GKPK2EThjfwBMKZ3d8Ugyfi9+7ZvukJ0NbXE94DFZE2T9OZHhl1ahRykTLJWCYbyi+cpxbLOdNY7n58jRO5dtOl2Boy8zVHdx6h16yxNGKKUV+a+drk0cc3ZlrhyrwzNcOBNx06lUwjsqKFKMid7MC+XkA7/vlrHZfNo86hRvy90cCJIWizcfjCaBncEJprzelexYxeRcA4j3/qEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoHvjrgzM7DcuMK3GgMeb2FkIbNQwvvqXOjGEhqQtSY=;
 b=JOhv5goVS/HNj2lc4rqXUxYFtDyMxITa7KdUYjyvBayNO/uvwGa5raHJL7/K/Wl6fb2aRFiOqDFCF4Q8j6w5TywqaF7shfEDtIwJAZBsudvFgq2ib1f/NFvT3C4ZglLS+dtSCY3V0Tm4oNuM/2RptT7Df7uVgl+9o8eSnZC3qgQc6GE873rUk1PXzVL8fU9lGgbwpf2DlbKmbFctTlZjeItZIE8UhPBi83VSGKmJbt0nmgFZy+F7v+KdU3PeUSZlbF+qWmfuUR5J1m6kLwHVye10T6atv6msUVFhpOI2cofrrv/fZ1OZR9ITBXsS6xEIbM3o0cllfdKc2I/pPjhrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoHvjrgzM7DcuMK3GgMeb2FkIbNQwvvqXOjGEhqQtSY=;
 b=eYumwvFNFh1oo55JkOO+0wt8ukfZ3yZzjKzjR7ceIt3Jh0PRq7uSSCmkfClqYsru9yAsSzWVntopu8urbfjhnNiJ04S2CrXJakk+7o95Mkb223C0Tap0f76ldExwT281qvmvTgRBvgxl6/goQzi7aL8QiHcHL9AxaYZrbhrUZDo=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 12:07:33 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 12:07:33 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Index: AQHZuULWGO/C9BN6KUGGSx2mRQXL7a+/Ym5ggAAFQgCAAAXHAA==
Date:   Tue, 18 Jul 2023 12:07:33 +0000
Message-ID: <TYCPR01MB5933C7B21E47968EF50276C58638A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <OS0PR01MB5922D3163524299B94166B178638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZLZ68OUizlOqoZmn@orome>
In-Reply-To: <ZLZ68OUizlOqoZmn@orome>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OSZPR01MB8798:EE_
x-ms-office365-filtering-correlation-id: d1c83e83-f65a-4a13-dcc3-08db87879168
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFUltKpIDNa9oyY0BNE5FpDGib/U9+GUq/capfrbiJkTt6VVsCuthqTeyLj7yXFfnwRbpre+tfE2/PrbpnyJJeriRzXXjnKo8EY91tHOHsqaKWPDAf3degmd9TmMph3N/HkQH0sd1DomtMHfOVoNPxaE3fUdApety/eDtJd7XrGTkEtkN6wYXV3KhBUF1VmwoyhKWYNZHEwSOMEWmPZNibULkB7C5AJN+HP29s28DKK5c9WJXtvJ8ly35O60gzuE+V6GCO35NZn+MizJtzYQCGhJox/JUjK/JPqfpoQiBIyqsvRlLQ62Yi13YvywwrUwyq1jjCSG1iZoT/cFv1I6UskqRmDerCZDsns1FD9gcJMpQiRj1eJSVIyHEXx7VosKavGzvkxY7bYo7RTbgZIqgZQKzl3K6R4pGUZOkHuZcA7PWExnIeEKHoMtAW8qxdQsgaHISkaz3hiPfg7/WjCW/fyZSKQzpiPTAF0CaDAV0G/TkYWiNshvN3rn5/m1HDShw+cqJ1WhXSkBjMzWoEswQsoR/Q4wPLCTr3TXn284kjwGT6+fHRFZgxC8EnIi0V6v2ZxwQBOIMT826W2N4ROqSvpYrz11YTFQ2CWb5vx+BB0/6jmKHQuozaf/g5ftBAvp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(478600001)(66946007)(66446008)(76116006)(64756008)(66476007)(66556008)(52536014)(5660300002)(4326008)(6916009)(316002)(8936002)(55016003)(2906002)(8676002)(41300700001)(54906003)(71200400001)(9686003)(26005)(6506007)(7696005)(53546011)(122000001)(38100700002)(33656002)(186003)(83380400001)(66574015)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHNDY2xIRWVVWUpuL01HQW1LUVVPK1IwWnBpV1VCaGtzRm1CNXZoYzFKSVZU?=
 =?utf-8?B?MjhRZ0pVTFBsREt2NjRLZklET054Umc0Z04xV2YvdnhJS2kwZGx3S3IvR3FR?=
 =?utf-8?B?S01QbFBmZThOaForZEZlS0RqZEgxRkptV3JJb2RQeUVkL3ZmNWdoSCt0K1Zm?=
 =?utf-8?B?ZmFweGZmckcvRVhCQS9aZFQxZUsvYUJINGxOMHM2MHp5MjdycWx0dFVaK012?=
 =?utf-8?B?cUFXS2FuL211ODUzYmx3Rzd5QThtTTd6OEJZOWtTUWgxdXhSVFo3ZTNwWEY1?=
 =?utf-8?B?Nm9IMWlOQnR6K05DYlRQeW5LM2U4amVZVi9IVndHQ0VPUVVRSDZVZ2t1Q1Va?=
 =?utf-8?B?aUw5OGJzemNKSjRKOWNkc0Q5bEJaRXNkRjN1YUZwSFNZMFdyeWZUWXJCUTVl?=
 =?utf-8?B?M0NkOGJPOGNnV21zNFpDcWV3YmFNL2E4SmgxSDA5b2dQV290RjFiUHRWMm82?=
 =?utf-8?B?ZWY3S2lEQjBvSVhYbVg4eUgydW82cnc0OUk2cDVoQzRuYlhOZkdGNzBORWZr?=
 =?utf-8?B?T0FKYWRvZ2VsbjZCN1F2UWVpd0EwZk85NWdmTUZlczlTUUhwNXJLOGM2bFFl?=
 =?utf-8?B?K0xkaGJGdmdOZGxONFhQcjlhdnRXNnBwRXRMcW93R0xyR0xubVZKYTRGNzFP?=
 =?utf-8?B?VkYvVkp3WFJDR0Q1a0dLczdKT2szWlFBSzI4dVdBalBwazU2dmdlMTRjMS9x?=
 =?utf-8?B?bUpRYlpERkU1QWovOHNuMVY5Q1d3cm4xUkxLeVhEckxpYWhzZUp0WFJRMmkz?=
 =?utf-8?B?dmVqc0ZFWHNHa2JPb0lCcysvMjJtcnRHRFl3cGhJVTdybm5pUVFlZlVMNGhh?=
 =?utf-8?B?Wk0rL2dlcDBnU3V6UnV6QlhPM3dBUnZQZkswR1pCNUltQlRBckdMRDdNb0pt?=
 =?utf-8?B?cXlhOGdWUmp2S2lnVS9Rd2ZhRDN2eEhyb2YzbUEyMElSOUVWYW1jMWpRU0oy?=
 =?utf-8?B?MnZQWE00RFBBS29JWk5SaU45MXcxbGpIdGdhWW4rTFpSTnRMVFpxYk9xclF6?=
 =?utf-8?B?M3k2L0RtRnJvMmZEUkJRanMxZ2ZPNGZveWs0UHVoWHlTcXdiK3hzVEhtYW1z?=
 =?utf-8?B?OEFGL0NyR2FlcUNGNUM1anFJcVcxNTdieENnZ2t1WkdyRTVaNlJ5YWdueStF?=
 =?utf-8?B?amdkZTJ6dnp2WFphRTRUazNteDhaZVRodWtrRGl2UUZmTFJINU1ZTUVWQVNx?=
 =?utf-8?B?SWRGSHRaMG4xcWQ5M1lnL2oyWWY2YktLZ0hobmtnczBtNHhtMmNuUDlvMzFF?=
 =?utf-8?B?UWUvQndBS3NCemFKM1hGTXlCUjhKVmVPL0EwMUlLNXVqcUdTN3Zhc0JhMGZz?=
 =?utf-8?B?ZXBESkU0ZXM5Ti84WGt5Z2FVOFczUk9jYUN4RnBlU09LQkUwLzVIUEZDOHVQ?=
 =?utf-8?B?N25qbjlHN1pTZVpiUjNtSXhaYkl6elJ5WUx0cnpvelhadGFWZzJHZUF3L0ZR?=
 =?utf-8?B?OVNGRU42c0l3dnBJN0hJY0RmdGJ3Znh6Tjk3a0NGeGJTUnhuWHMrRlZ2d1g4?=
 =?utf-8?B?eUJrOUI0SmpHRE1VeVVxeXVBbzRRRjR5SFAyTnhuSHRzMDJwY3Z1MnNtTDRa?=
 =?utf-8?B?bGhWNlk5NDVmZFdqTCtGSGZpMTBaeXkrZncwYmZGcEFJb0tLcXpxNHlIeW4x?=
 =?utf-8?B?TU1GR3psZlFJMkFnWHdkNDZ2ZDdLcThzVHhTeTA3NVdLeC8yazFZT3JJNHRa?=
 =?utf-8?B?aE1DQlgyU3J2bUQ2WGN0NG51UEhJZm1jUFJSWHprU1U0bHZ5S3JGVjhKa1Ux?=
 =?utf-8?B?c3l3bGovejNYaE03VEJFbStGM1BtS2RZeWlkMW1scEp5Uy9yVlRMNENZc0Jm?=
 =?utf-8?B?QmFUTFNKNjBSZ083dGYxbTgrOVdPd0pXNjY2MTRJUE0vY1dsanpoNDJBbjN0?=
 =?utf-8?B?Nk5vcGZ5OWVQT0JGU1BFV1VJbXU5QnZhMGE4QUJONzErbWcwRXdwa3RFaUNa?=
 =?utf-8?B?WitJaU1aOFhtKzlURXRtWUdMNWExbm9uVlB2Q2t1WG5QaVRNeXIvQ01JNERv?=
 =?utf-8?B?djZmV05xUkhQQ3JjdDRsVGVWcC9uQUhxODBqVFU1azBkeHpDNEJvbFZPRkVr?=
 =?utf-8?B?ZmNTNWxjVll2K0lHS0F0dXZ1aS9lQXBjc0RuNzh6MVBCeFVrdXZQYlVjWlAy?=
 =?utf-8?B?T2p4NVpETkFxVHFad0ZsYm9uclRobXJ3NlVKalpmNGptSmEwWU5NTElNY3Rs?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c83e83-f65a-4a13-dcc3-08db87879168
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 12:07:33.2767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1qutxTFdDtq1BKZIyg0LVu/9g/8EI23fcEChoghcSD2CrtJfNgjP32nXxl4fJ5hbk398zkWI4dfutwJXcqGLpeAjzRdgKwCa5AOsnsK8Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8798
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpZXJyeSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdt
YWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxOCwgMjAyMyAxMjo0NCBQTQ0KPiBUbzog
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBDYzogUmFuZHkgRHVubGFw
IDxyZC5kdW5sYWJAZ21haWwuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsgVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLQ0K
PiBrb2VuaWdAcGVuZ3V0cm9uaXguZGU+OyBGYWJyaXppbyBDYXN0cm8NCj4gPGZhYnJpemlvLmNh
c3Ryby5qekByZW5lc2FzLmNvbT47IGxlZS5qb25lc0BsaW5hcm8ub3JnOyBHZWVydA0KPiBVeXR0
ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyXSBwd206IGZpeCBwd20tcnotbXR1My5jIGJ1aWxkIGVycm9ycw0KPiANCj4gT24gVHVlLCBK
dWwgMTgsIDIwMjMgYXQgMTE6MjY6MjhBTSArMDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkg
UmFuZHksDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBSYW5keSBEdW5sYXAgPHJkLmR1bmxhYkBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5
LCBKdWx5IDE4LCAyMDIzIDc6NDEgQU0NCj4gPiA+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsgVGhpZXJyeSBSZWRpbmcNCj4gPiA+IDx0aGllcnJ5
LnJlZGluZ0BnbWFpbC5jb20+OyBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUtDQo+ID4gPiBr
b2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIHB3bTogZml4
IHB3bS1yei1tdHUzLmMgYnVpbGQgZXJyb3JzDQo+ID4gPg0KPiA+ID4gRnJvbTogUmFuZHkgRHVu
bGFwIDxyZC5kdW5sYWJAZ21haWwuY29tPg0KPiA+ID4NCj4gPiA+IFdoZW4gKE1GRCkgUlpfTVRV
Mz1tIGFuZCBQV01fUlpfTVRVMz15LCB0aGVyZSBhcmUgbnVtZXJvdXMgYnVpbGQNCj4gZXJyb3Jz
Og0KPiA+ID4NCj4gPiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9j
b25maWcnOg0KPiA+ID4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzozNzQ6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfZGlzYWJsZScNCj4gPiA+IGxkOiBkcml2ZXJzL3B3bS9w
d20tcnotbXR1My5jOjM3NzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYHJ6X210dTNf
OGJpdF9jaF93cml0ZScNCj4gPiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUz
X3B3bV93cml0ZV90Z3JfcmVnaXN0ZXJzJzoNCj4gPiA+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUz
LmM6MTEwOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+ID4gPiBgcnpfbXR1M18xNmJpdF9jaF93
cml0ZScNCj4gPiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9jb25m
aWcnOg0KPiA+ID4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzozODI6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8NCj4gPiA+IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+ID4gPiBsZDogdm1saW51
eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fd3JpdGVfdGdyX3JlZ2lzdGVycyc6DQo+ID4g
PiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjExMDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0K
PiA+ID4gYHJ6X210dTNfMTZiaXRfY2hfd3JpdGUnDQo+ID4gPiBsZDogZHJpdmVycy9wd20vcHdt
LXJ6LW10dTMuYzoxMTE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gPiA+IGByel9tdHUzXzE2
Yml0X2NoX3dyaXRlJw0KPiA+ID4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNf
cHdtX2NvbmZpZyc6DQo+ID4gPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjM5NzogdW5kZWZp
bmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M19lbmFibGUnDQo+ID4gPiBsZDogdm1saW51eC5v
OiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fZGlzYWJsZSc6DQo+ID4gPiBkcml2ZXJzL3B3bS9w
d20tcnotbXR1My5jOjI1OTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYHJ6X210dTNf
OGJpdF9jaF93cml0ZScNCj4gPiA+IGxkOiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjI2NDog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYHJ6X210dTNfZGlzYWJsZScNCj4gPiA+IGxk
OiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9lbmFibGUnOg0KPiA+ID4gZHJp
dmVycy9wd20vcHdtLXJ6LW10dTMuYzoyMzA6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gPiA+
IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+ID4gPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10
dTMuYzoyMzQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gPiA+IGByel9tdHUzXzhiaXRfY2hf
d3JpdGUnDQo+ID4gPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyMzg6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfZW5hYmxlJw0KPiA+ID4gbGQ6IHZtbGludXgubzog
aW4gZnVuY3Rpb24gYHJ6X210dTNfcHdtX2lzX2NoX2VuYWJsZWQnOg0KPiA+ID4gZHJpdmVycy9w
d20vcHdtLXJ6LW10dTMuYzoxNTU6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNf
aXNfZW5hYmxlZCcNCj4gPiA+IGxkOiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjE2MjogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYHJ6X210dTNfOGJpdF9jaF9yZWFkJw0KPiA+ID4g
bGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNfcHdtX3JlYWRfdGdyX3JlZ2lzdGVy
cyc6DQo+ID4gPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjEwMjogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0bw0KPiA+ID4gYHJ6X210dTNfMTZiaXRfY2hfcmVhZCcNCj4gPiA+IGxkOiBkcml2ZXJz
L3B3bS9wd20tcnotbXR1My5jOjEwMjogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYHJ6
X210dTNfMTZiaXRfY2hfcmVhZCcNCj4gPiA+IGxkOiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5j
OjEwMzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYHJ6X210dTNfMTZiaXRfY2hfcmVh
ZCcNCj4gPiA+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9nZXRfc3Rh
dGUnOg0KPiA+ID4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyOTY6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8NCj4gPiA+IGByel9tdHUzXzhiaXRfY2hfcmVhZCcNCj4gPiA+DQo+ID4gPiBNb2Rp
ZnkgdGhlIGRlcGVuZGVuY2llcyBvZiBQV01fUlpfTVRVMyBzbyB0aGF0IENPTVBJTEVfVEVTVCBp
cyBzdGlsbA0KPiA+ID4gYWxsb3dlZCBidXQgUFdNX1JaX01UVTMgZGVwZW5kcyBvbiBSWl9NVFUz
IGlmIGl0IGlzIGJlaW5nIGJ1aWx0IGJ1dA0KPiA+ID4gYWxzbyBhbGxvdyB0aGUgbGF0dGVyIG5v
dCB0byBiZSBidWlsdC4NCj4gPiA+DQo+ID4gPiBGaXhlczogMjU0ZDNhNzI3NDIxICgicHdtOiBB
ZGQgUmVuZXNhcyBSWi9HMkwgTVRVM2EgUFdNIGRyaXZlciIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBSYW5keSBEdW5sYXAgPHJkLmR1bmxhYkBnbWFpbC5jb20NCj4gPiA+IENjOiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiBDYzogVXdlIEtsZWluZS1Lw7ZuaWcg
PHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gPiA+IENjOiBUaGllcnJ5IFJlZGlu
ZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0KPiA+ID4gQ2M6IGxpbnV4LXB3bUB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiA+IC0tLQ0KPiA+ID4gdjI6IGZpeCB0eXBvIGluIFN1YmplY3Q7DQo+ID4g
PiAgICAgY29ycmVjdCBteSBlbWFpbCBhZGRyZXNzIHdoaWxlIGluZnJhZGVhZC5vcmcgaXMgZG93
bjsNCj4gPiA+DQo+ID4gPiAgZHJpdmVycy9wd20vS2NvbmZpZyB8ICAgIDMgKystDQo+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4g
PiA+IGRpZmYgLS0gYS9kcml2ZXJzL3B3bS9LY29uZmlnIGIvZHJpdmVycy9wd20vS2NvbmZpZw0K
PiA+ID4gLS0tIGEvZHJpdmVycy9wd20vS2NvbmZpZw0KPiA+ID4gKysrIGIvZHJpdmVycy9wd20v
S2NvbmZpZw0KPiA+ID4gQEAgLTUwNSw3ICs1MDUsOCBAQCBjb25maWcgUFdNX1JPQ0tDSElQDQo+
ID4gPg0KPiA+ID4gIGNvbmZpZyBQV01fUlpfTVRVMw0KPiA+ID4gIAl0cmlzdGF0ZSAiUmVuZXNh
cyBSWi9HMkwgTVRVM2EgUFdNIFRpbWVyIHN1cHBvcnQiDQo+ID4gPiAtCWRlcGVuZHMgb24gUlpf
TVRVMyB8fCBDT01QSUxFX1RFU1QNCj4gPiA+ICsJZGVwZW5kcyBvbiBDT01QSUxFX1RFU1QNCj4g
PiA+ICsJZGVwZW5kcyBvbiBSWl9NVFUzIHx8IFJaX01UVTM9bg0KPiA+ID4gIAlkZXBlbmRzIG9u
IEhBU19JT01FTQ0KPiA+ID4gIAloZWxwDQo+ID4gPiAgCSAgVGhpcyBkcml2ZXIgZXhwb3NlcyB0
aGUgTVRVM2EgUFdNIFRpbWVyIGNvbnRyb2xsZXIgZm91bmQgaW4NCj4gPg0KPiA+DQo+ID4gVGhl
IGJlbG93IHBhdGNoIGFsc28gd29ya3MgZmluZSwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3B3bS9LY29uZmlnIGIvZHJpdmVycy9wd20vS2NvbmZpZyBpbmRleA0KPiA+IDFjOGRiYjA2
NGVlNS4uNTZhYjJmNGI5MWZlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcHdtL0tjb25maWcN
Cj4gPiArKysgYi9kcml2ZXJzL3B3bS9LY29uZmlnDQo+ID4gQEAgLTUwNSw3ICs1MDUsNyBAQCBj
b25maWcgUFdNX1JPQ0tDSElQDQo+ID4NCj4gPiAgY29uZmlnIFBXTV9SWl9NVFUzDQo+ID4gICAg
ICAgICB0cmlzdGF0ZSAiUmVuZXNhcyBSWi9HMkwgTVRVM2EgUFdNIFRpbWVyIHN1cHBvcnQiDQo+
ID4gLSAgICAgICBkZXBlbmRzIG9uIFJaX01UVTMgfHwgQ09NUElMRV9URVNUDQo+ID4gKyAgICAg
ICBkZXBlbmRzIG9uIFJaX01UVTMgfHwgKENPTVBJTEVfVEVTVCAmJiBSWl9NVFUzKQ0KPiANCj4g
VGhhdCdzIGEgYml0IHBvaW50bGVzcywgaXNuJ3QgaXQ/IFRoYXQgZWZmZWN0aXZlbHkgcmVkdWNl
cyB0byBqdXN0Og0KPiANCj4gCWRlcGVuZHMgb24gUlpfTVRVMw0KDQpPSywgdGhlbiBVd2UncyBz
b2x1dGlvbiBpcyBiZXR0ZXIuDQoNCmllLCB1c2UgdGhlIGV4aXN0aW5nICJkZXBlbmRzIG9uIFJa
X01UVTMgfHwgQ09NUElMRV9URVNUIg0KDQphbmQgdXNlDQoNCi0jaWYgSVNfRU5BQkxFRChDT05G
SUdfUlpfTVRVMykNCg0KKyNpZiBJU19SRUFDSEFCTEUoQ09ORklHX1JaX01UVTMpIGluIGluY2x1
ZGUvbGludXgvbWZkL3J6LW10dTMuaA0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K
