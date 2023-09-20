Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390AD7A808C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjITMhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjITMhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA2E4;
        Wed, 20 Sep 2023 05:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkEZakYnT2gzBdr38qzI0LpuTcXTK5tuTLMjzpPFiGg0I4YFfo4R354Db4F6cnOUlAuIYUOqLJXmlHdCxBC9sfe2X4HjhDccnE/XyJ7eOvpJnDkuarEJyH2xaWyqkOAW59wiBT6eyH39BT0p5FLbJTG/lOosY1B+HAqiLTaxuMIhApQA4lvrjPgPtfEIZEFF5Q2YAta5WAotkki2y3tczc6zwNdgaBFov81iB5TtlOr8ZeVS6XUKALRtcKVyf6e0R6lk/q3P1hvue9y30eKQsqMzDlXM2dMrxlTrsrde/rwNUnhlyyQRJ+Nzu6T4H0PpmPE2AW0d400MILJxujsbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tjjt1dYpGpP45HQY422prTsdi/ZWOukRpoynE8hNcA=;
 b=n4ENTqdTTLiIX9uvJ6Aepb5bdVsqrN/oVIjoAb2NjxLWRaVNH8imA5/70wvTeVoRrAO/yRkqGpiBbjqBSrTchLjY+xIu3an3CRw+7cUwq0okcNlYKuqaXfQfsGNNRLZeW5K+kwquesKzFLR2NwZnXSD2VBigGMDROOHJxrpGdqsMDQnVjrU0RBPeT0xbck7FsphKwMYPpEHWVs6tflYP5fU61giPJ4YeEs7yerFxUZVJbe4RwvljZssEgJQujSZoxTavaL6I7R+/+3xTp1R4hSbmeL+emb11anX9fmWpBXakRkrAck3zqi2libLp6UU9ej4Xl1K/5p4ZRdwsgYouLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tjjt1dYpGpP45HQY422prTsdi/ZWOukRpoynE8hNcA=;
 b=iJvrSnRErTcIOxGBYSSf6UQAp0rIl2bf4GU26UQis7Tqbs4k0/noxgKtAnwTqggS0VlsAAzUJkex1TRkd/035HmaGqmpHTIWkIzX4qFjpMgkqE5jYe0GWDsslWf2wpSfzeq/zjDexfIXq7fpOx975J0GM2dxhUBLZcgvhk0fjgE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9697.jpnprd01.prod.outlook.com (2603:1096:400:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 12:37:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 12:37:37 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
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
Thread-Index: AQHZ6ixt37i5mirEkU2vvrutS3Og4rAjpVMAgAAA4OA=
Date:   Wed, 20 Sep 2023 12:37:37 +0000
Message-ID: <OS0PR01MB5922A256D2C57963ADEBCEDB86F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
 <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
 <CACRpkdYYKAFLvpKH0ih5qZVbv7L3auny5WWx+qKa_HD1o-vsog@mail.gmail.com>
In-Reply-To: <CACRpkdYYKAFLvpKH0ih5qZVbv7L3auny5WWx+qKa_HD1o-vsog@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9697:EE_
x-ms-office365-filtering-correlation-id: 812015a8-3fa0-4848-f71f-08dbb9d65f49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilg0HFjgOKWI2xv48Kj2r1IXk5vU61Cej7LvPyKtDDp5pOdl8FRmS+XwSEV4SPeM/ipqKyJKfC25+9sfRRjyM+KW354P5T9/kx4uNMzF5EzOYrfefQzsnCf9DiUKh3JUZIDlqfOSJvXgZmkJv3rWGONLiGQg9YIxL8NJH6J4llc5C0TmeDbmy+RtCiBQACyCeKBLsyxDzwjiY5jk2n5QHlocfrhHMkBWkjUMP0P48a1EIYw7JKz4US4elJqmKUfx3WOXvPkDjU+UwNhetSuAHm/0/Qf2hUcmf11VUKG4KnHiacWV96E1n99y62gs93FCzLn6pK5Y9m5tHK12EFOVsSAXzqfN57gUYF72YQWWRjPYoCh5IQG48SgvoPREtxn/k2UK5VpTSTUkhN7VJEhCmPv56oTxLJDwyrTeHYGhDq9bOM6kRMPqAxkh0ZFZXlSOkXWQFbz9sc/u0NQeGN/aQZAFgFF9fUTRC6VLaW9pcrxMzOYedeSZWSmHlkD8aoS1b/BKr6VrnJ1gNHotiNgFwACjdCh1ANTRRMIcSbORAyCtxfZdA6WSzMJoK9LZTsuHqlQSNYMgjeWpYCwDuvLRzP2nqJSihz1NxFhV6hlYidEjLnmnvF7epuLSNCmArNNK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(55016003)(38100700002)(38070700005)(6506007)(7696005)(53546011)(33656002)(122000001)(86362001)(2906002)(9686003)(83380400001)(71200400001)(478600001)(8676002)(8936002)(5660300002)(52536014)(4326008)(66556008)(6916009)(41300700001)(66946007)(54906003)(64756008)(316002)(66476007)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3UyaHhJZDB5QjRPQkhSeXpYb0xzTFdUZEpOandHcGtOR3FwWm00N29wRjdH?=
 =?utf-8?B?QTM0cFhYY2hJQ0xGSmpHTDIvZWVuSG1iUXJOOUsvbmZ0T1VJRUlHR2tJZUpo?=
 =?utf-8?B?K1Z0L1pkay9pak1ua0tpeXNSajRrVE9oUlo3T3BEaVhsak9TWEN2R0hjZnhR?=
 =?utf-8?B?MmlLTUw2RHZxSVFrTzE2T28wcXQvcGhvRVlMWUdRcUhtbUlQbmxrK25nVndE?=
 =?utf-8?B?ZVF3cktSNUdWdFIrTmtyV3NSQUxLSysveHpYdjhQM0FJcG9BMUhIYUJ2NUFj?=
 =?utf-8?B?U1p0RjZmSmtEaEpqb29SUk9wdXoyejRUQW9qOC9pMGxwMUtEdzRIV2NQbUxi?=
 =?utf-8?B?dGJGUS9oSzJ2Q3o1ZXFTcG1ta2REMU42dHhOWHYrNUM3K0RJVlljL3BSekt2?=
 =?utf-8?B?dzcvamlsQkxvZHI5d1p5MjFhTUJZQUJvRWx1a0J1b040MUNRM2NOYVExdHJ2?=
 =?utf-8?B?OUpYdWYvLzNibXBncWhoSzV5UDdXc05nU3hQTzBsbWphMFBxc2Q0bUhKMmV3?=
 =?utf-8?B?Z2JxWnpOWlBLYzVONXdhck5yaW0vRW1sb0NxdS9pWWlEa25lL3dxWjVsS0lm?=
 =?utf-8?B?dlJ0VTYvY3R6S0dxS0JraTJjNWtldnM0Y0FJOHpJV05Wd1NlYVc0RSt6NVgw?=
 =?utf-8?B?blhHSy83Zm5PbTFHaUg0UWRJNzg0eVhsaVR4VXpobW13djZTaGx5VmI5ajgx?=
 =?utf-8?B?cEw0SjdNWWp4OHZ3WTFodm8xaFNJdy9NTitTcFVXempnNjZ1N05NVWNRclJa?=
 =?utf-8?B?NitPK1NSUGo0NjM4YWY3anJHSDV3bmk5RjFPRTBnNkh3QzJWQUxXUENPRERJ?=
 =?utf-8?B?bk5GZUF2WWdPMFpFaDdtRVVrQ3FGY2NUZ01nZy9ZanUxUDdlRkhFbGw0UStY?=
 =?utf-8?B?a09KQnBKdUFJNERrdy9SQVc3b3luYXZxdzg1V055YzJseUt6d0ZhRDUraDdJ?=
 =?utf-8?B?eHcwL1plMXpubmhsTWtZaFEzVkpJb1RIR3VUVnpieXpESGRlZU1Ic2k2eGJZ?=
 =?utf-8?B?cVVJOXV5eHFnc1dhbHlmTmVRbHhPVzJFaHI3RkV4bXQ3Z2pqeUxReVJQR1Jx?=
 =?utf-8?B?MVZyeTljZlFTK09qc3lYT0FPVnJ0dkJaZlhIeERDUDFZR00zcXRDV2t1cjdK?=
 =?utf-8?B?d1ROS3NEcFNlUngvL0xkL0lhZmtMRFNkN0Qyc2kvVVhDMU9PYXpmWi9zR1or?=
 =?utf-8?B?Ykpuc1BBTEVFNndGcENsSlZzR0haQ3M4alpXblBtM2R4dk0vYTNXRHhCcVVt?=
 =?utf-8?B?SUpPRDVYbitjbndVWUxEQnAxQk9ubmtpRnNxMzFOeldCRHdPNHB4NjlWSXhn?=
 =?utf-8?B?blZZV3VvSStsZXMxZ1lIRHo3NFI5WWpQUElhckM0cjhmYWtXT2ppL2JPcXV6?=
 =?utf-8?B?bm01Y2NOdkpSNzg4R2tzMnQ5Z3BVMEU0WXdXT2pUbkIrbkNkd05CWU9DOVEr?=
 =?utf-8?B?VmN3Q0RKYTA4ZCt5bWF5WTlTdzV5WVRLY29OVGJyS2MzYmlTckFneWJ3dmRw?=
 =?utf-8?B?anZiWEdmeHkxL29GT1Y1ZWdILzNSdUd4akd4RWYwQjZiQ3ZiRHVORWZ2dnB6?=
 =?utf-8?B?VFJWa3g0S05id0drSGE5VXRhdmVDWVV3WkxIWEpxRnFkTDVZVmpJRm9hUHhT?=
 =?utf-8?B?K08wQ2lwREVFSlBuYWNRRWQ5Wi9TeGs5STVzYzkxSWV4WW45S3VUVE94Qkl2?=
 =?utf-8?B?T1V6VzlTOVFUdjllK21TQnAzcDFMckRQWnpOSU5LcnljdE1mVjlkRWxnS2Y1?=
 =?utf-8?B?Wk1ObFlOS1NiRHJ4YjVqYUNKSzN1VXBhUitJMGtLYng5clV6QlpJYkVJTW9a?=
 =?utf-8?B?Z1RrRHZjZi9RejlzNysvWVdrbnJ1eHRGUmFBT1dYMVdoV3pqUkE5UjZieFVa?=
 =?utf-8?B?WUJSbVU3azFXUW9VdkFGMys2RnU4b1h4UExwMEl4dmphNlRUTy84VjZlaGs4?=
 =?utf-8?B?UktTN000UTVLd1FxUWkxSEpwYzZ2cWFJV3RFdTAwRnd6M3NRUkVOVWVMaEZK?=
 =?utf-8?B?QTJXTlNpMlBHZHd1Z00zN0JUdjlNOGRRbTY5ZHZ1dC9sVWxKK1VzN3E1NzRH?=
 =?utf-8?B?dEJId1h6WjF1NEc2dFVidG83YzR1ZGg0MjlYY3JSZEVXV1J0eHA3NjNSbTR4?=
 =?utf-8?Q?YdoY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812015a8-3fa0-4848-f71f-08dbb9d65f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 12:37:37.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pm2sGlmZY1M4u4Uz2RA/GEtEvgXOTy4sxc05yM7C/4N0KJgD7PNTz/fQrfGyXGIVc+FmOWBqB1IAM+UcYi6b6NFa1O7LXsTPzYchgdOcRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9697
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMgV2FsbGVpaiwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAyLzJdIHBpbmN0cmw6IHJlbmVzYXM6IHJ6ZzJsOiBFbmFibGUgbm9pc2Ug
ZmlsdGVyIGZvcg0KPiBHUElPIGludGVycnVwdCBpbnB1dA0KPiANCj4gT24gTW9uLCBTZXAgMTgs
IDIwMjMgYXQgMjozNOKAr1BNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4N
Cj4gd3JvdGU6DQo+IA0KPiA+IEFzIHBlciBSWi9HMkwgaGFyZHdhcmUgbWFudWFsIFJldi4xLjMw
IHNlY3Rpb24gOC43LjMgR1BJTyBJbnRlcnJ1cHQNCj4gPiAoVElOVCkgYW5kIDQxLjQuMSBPcGVy
YXRpb24gZm9yIEdQSU8gZnVuY3Rpb24sIHdlIG5lZWQgdG8gc2V0IGRpZ2l0YWwNCj4gPiBub2lz
ZSBmaWx0ZXIgZm9yIEdQSU8gaW50ZXJydXB0Lg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBlbmFibGVz
IG5vaXNlIGZpbHRlciBmb3IgR1BJTyBpbnRlcnJ1cHQgaW4NCj4gPiByemcybF9ncGlvX2lycV9l
bmFibGUoKSBhbmQgZGlzYWJsZSBpdCBpbiByemcybF9ncGlvX2lycV9kaXNhYmxlKCkuDQo+ID4N
Cj4gPiBGaXhlczogZGIyZTVmMjFhNDhlICgicGluY3RybDogcmVuZXNhczogcGluY3RybC1yemcy
bDogQWRkIElSUSBkb21haW4NCj4gPiB0byBoYW5kbGUgR1BJTyBpbnRlcnJ1cHQiKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiBU
ZXN0ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNv
bT4NCj4gDQo+IFdoeSBpcyB0aGlzIGNhbGxlZCAiZGlnaXRhbCBub2lzZSBmaWx0ZXIiIHdoZW4g
dGhlIHJlc3Qgb2YgdGhlIHdvcmxkIGNhbGxzDQo+IGl0ICJkZWJvdW5jZSI/IEl0IGlzIGEgYml0
IGNvbmZ1c2luZyB0byBoYXZlIGRpZmZlcmluZyB0ZXJtaW5vbG9neSBpbiB0aGUNCj4ga2VybmVs
Lg0KPiANCj4gKFRoZXJlIG1pZ2h0IGJlIGEgZ29vZCByZWFzb24sIHN1Y2ggdGhhdCB0aGUgbm9p
c2UgaW4gcXVlc3Rpb24gaXMgdmVyeQ0KPiBkaWZmZXJlbnQgZnJvbSBtZWNoYW5pY2FsIGJ1dHRv
biBib3VuY2Ugbm9pc2UuKQ0KDQpJdCBpcyBhbG1vc3Qgc2FtZS4NCg0KPiANCj4gSXMgdGhpcyBv
bmx5IGFwcGxpY2FibGUgdG8gaW50ZXJydXB0IGxpbmVzIG9yIGFsc28gdG8gR1BJTyBsaW5lcyBp
bg0KPiBnZW5lcmFsPyBCZWNhdXNlIEkganVzdCB3YW50IHRvIGFzY2VydGFpbiB0aGF0IGluIHRo
YXQgY2FzZSB0aGUgZXhpc3RpbmcNCj4gYmluZGluZyBmb3IgQFBJTl9DT05GSUdfSU5QVVRfREVC
T1VOQ0UgYW5kIHRoZSBjb3JyZXNwb25kaW5nIGJhY2tlbmQgY2FsbA0KPiBmcm9tIGdwaW9fY2hp
cCgpIG1hcHMgdG8gdGhlIHNhbWUgZmVhdHVyZSBhcyB3ZWxsLg0KPiANCj4gSXQgc2VlbXMgaGFy
ZC1jb2RlZCBmb3Igc29tZSBwaW5zIGluIHRoZSBSZW5lc2FzIGRyaXZlciByaWdodCBub3cgYnV0
IHRoZQ0KPiBkYXkgeW91IG1ha2UgdGhpcyBjb25maWd1cmFibGUgZnJvbSBEVCBwbGVhc2UgY2Fs
bCBpdCBkZWJvdW5jZSwgaWYgdGhlDQo+IHVzZWNhc2UgaXMgc2ltaWxhci4NCg0KWWVzLCB0aGUg
dXNlY2FzZSBpcyBzaW1pbGFyIGFuZCB3ZSBjYW4gdXNlIFBJTl9DT05GSUdfSU5QVVRfREVCT1VO
Q0UNCmZvciBlbmFibGluZyBkaWdpdGFsIG5vaXNlIGZpbHRlci4NCg0KQnV0IGFwYXJ0IGZyb20g
dGhpcywgSSBuZWVkIHRvIGFkZCAyIG1vcmUgY29uZmlndXJhYmxlIHByb3BlcnRpZXMNCmFzc29j
aWF0ZWQgd2l0aCBEVCBmb3IgUElOX0NPTkZJR19JTlBVVF9ERUJPVU5DRS4NCg0KMSkgRGlnaXRh
bCBOb2lzZSBGaWx0ZXIgTnVtYmVyIFJlZ2lzdGVyIChGSUxOVU0pIA0KDQpUaGlzIHJlZ2lzdGVy
IHNldHMgdGhlIG51bWJlciBvZiBGRiBzdGFnZXMgb2YgZGlnaXRhbCBub2lzZSBmaWx0ZXIgZm9y
IEdQSU8gcGluIGFuZCBOTUkgcGluLg0KDQowMGI6IDQtc3RhZ2UgZmlsdGVyICg0MS42NjYgbnMg
eCA0ID0gMTY2LjY2NiBucykgKGluaXRpYWwgdmFsdWUpDQowMWI6IDgtc3RhZ2UgZmlsdGVyICg0
MS42NjYgbnMgeCA4ID0gMzMzLjMzMyBucykNCjEwYjogMTItc3RhZ2UgZmlsdGVyICg0MS42NjYg
bnMgeCAxMiA9IDUwMCBucykNCjExYjogMTYtc3RhZ2UgZmlsdGVyICg0MS42NjYgbnMgeCAxNiA9
IDY2Ni42NjYgbnMpDQpOb3RlOiBUaGlzIHZhbHVlIGlzIHRoZSB2YWx1ZSB3aGVuIHRoZSBleHRl
cm5hbCBjbG9jayBpcyAyNE1Iei4NCg0KDQoyKSBEaWdpdGFsIE5vaXNlIEZpbHRlciBDbG9jayBT
ZWxlY3Rpb24gUmVnaXN0ZXIgKEZJTENMS1NFTCk6DQoNClRoZSBGSUxDTEtTRUwgcmVnaXN0ZXIg
c2VsZWN0cyB0aGUgZGl2aWRlZCBjbG9jayB0byBiZSBpbnB1dCB0byBkaWdpdGFsIG5vaXNlIGZp
bHRlcnMuDQoNCjAwYjogTm90IGRpdmlkZWQgKGluaXRpYWwgdmFsdWUpDQowMWI6IERpdmlkZWQg
YnkgOTAwMCAoNDEuNjY2IG5zIHggOTAwMCA9IDM3NSwwMDAgbnMpDQoxMGI6IERpdmlkZWQgYnkg
MTgwMDAgKDQxLjY2NiBucyB4IDE4MDAwID0gNzUwLDAwMCBucykNCjExYjogRGl2aWRlZCBieSAz
NjAwMCAoNDEuNjY2IG5zIHggMzYwMDAgPSAxLDUwMCwwMDAgbnMpDQpOb3RlOiBUaGlzIHZhbHVl
IGlzIHRoZSB2YWx1ZSB3aGVuIHRoZSBleHRlcm5hbCBjbG9jayBpcyAyNE1Iei4NCg0KUTEpIFdo
YXQgaXMgdGhlIHJlY29tbWVuZGVkIHdheSB0byBhc3NvY2lhdGUgdGhlIGFib3ZlIHZhbHVlcyB3
aXRoDQogICAgUElOX0NPTkZJR19JTlBVVF9ERUJPVU5DRT8NCg0KRWc6IEkgbmVlZCB0byBjb25m
aWd1cmUgZmlsdGVyIG9uLCA4IHN0YWdlIGZpbHRlciAsIGEgZGl2aXNvciBvZiAxODAwMCBmb3Ig
YSBtZWNoYW5pY2FsIGJ1dHRvbiBib3VuY2Ugbm9pc2UuDQoNCkNoZWVycywNCkJpanUNCg==
