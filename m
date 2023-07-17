Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B162875609A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGQKhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGQKhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:37:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2092.outbound.protection.outlook.com [40.107.113.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE710D3;
        Mon, 17 Jul 2023 03:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z38BzPWquk1qSjyj2dXXp7Fz5VyKeSlzYv3BKATbNcuxnE4FE/8rX6EDMpRqkhmvEStXWfm9/0Vwnpd/HSEQY09gObIWryFzeWO43FvrgVJMqgvyelisejt3iFFvBYfjKdzshZKvMigl88tJ10kAzcOB/wizZimBsR102eoiLUOTxCEqaozR6fyDRItlST8m37G3880xqy/i6QjgqK9bmIo09yMx0lnzT2DFBdRZcdeDxcBJlWXBrYK5hjFa8c6Mb4O7L7dKDeoDwTc3h/FzbU9FBSHYGiSfbV6IWlqILygnkwc9eYCvTVp0lJBShQqkRlylRRKhW56ERuKZ5d/s+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy12SQnrF1pPVvhg8h5iry6uLDu0qCvpcikOoinvHFU=;
 b=eUN/Sho+SU4AIqTnVbKfzi1bKVdA8PBgzNQyTv9AnhrO/jwN3fkliYO1G4hIYVjXhfk6AEvE3Is2tcH5WOYlWAjU0Dmr92qcJR1QxCQZQ3/8ybsT0a+5ir8EnDwMzmwrj2fjcB5en3hfA79nJ9qDI675WRoW4psvmljm5m9VGbxpmocXuzHUDJ2+WjKY1ZGFoys+5QxdFUtExcwpvHds0D2fGBcg5E/ibfE0ZPtxIsotE4Qt2Hw05AsW7/poSjKfYEzSVyIlnNKVcSUYmyLma07WeYc50Mh1r7Nw16HsVCrBmFE9m8KrR9quZ4ByszKVi9zkoOnnwb28PKWNz0PwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy12SQnrF1pPVvhg8h5iry6uLDu0qCvpcikOoinvHFU=;
 b=ZrE15xmsHOA12DIrVz4X5pAaSiZps4zFs58JA4qOaTu7l9t0Hmi3MQbNA5iAG6CPiIbcPe9P++oQ3CbTE4h+dOu3qRnCFnWa+XbCriWXErqTLuzzx1zt9xWSAyba8+YBXioycYx6MA7aQ730rIc7RsF9nPBmhiMNulWNB5NUtFk=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYYPR01MB8216.jpnprd01.prod.outlook.com (2603:1096:400:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 10:36:55 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:36:54 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
Thread-Topic: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
Thread-Index: AQHZtrhW9m6gE+r9C0SdjPac+B4RGq+9ty4AgAAMoZA=
Date:   Mon, 17 Jul 2023 10:36:54 +0000
Message-ID: <TYWPR01MB8775869576E4B3F0FEFCF3DCC23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
 <20230715010407.1751715-8-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUzxQfi2w8dyF8gCitkSKkw_fRE074EUuB+tHKn8WM3=w@mail.gmail.com>
In-Reply-To: <CAMuHMdUzxQfi2w8dyF8gCitkSKkw_fRE074EUuB+tHKn8WM3=w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYYPR01MB8216:EE_
x-ms-office365-filtering-correlation-id: 5759297d-2eac-4d66-0dee-08db86b1bd66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vp31lp/b3J0XP5yQYPl8UVFlBQBKFzUF4LvVuM5SGT1dPI7QyzR4QuuVt+qgiP0YzR2+YXnt1fxr4HsxoGFKzCcGocZBQW5Cusjjdit1cgjJxlKhmDRhUmUjrlugVPYwoNegSL3ptrCWdFcM9kIn4GtrY8Xh2aFtqVZsTLzdmBPzpTDCPeyIfHe5ul40tUYIEixb+K2g+U8j7Og2Sf4i8DoXrkgdHKAZl/ylFtGm3dVoMxc0VMht2u6Xu5f0F4dipvc29M6zaOtVed5luB0XVLzJ0F3qvgY9S7dM/1sHWPrTjCNDEBpkHPuY9uM9CkuvYNB1Ma01kThhJLnxehrdp00HNRSaXEQzAo2c9IcEzh1lxdYpO2hJFrPcynHlQP1euLk/AUPgWPg9SNCFSnvwagYmP6DKAYUJ1/E75RbBo4HvwtTpItMHpH3XvBkPGZANWD+huCerGDbjVzzi1JMhtyi/KblcF3LPacG6CpvQfXe7Qahsf6Tw2CPG5weBJA6FXLi1Tqvhm5n3icZpJ/QLnB4sdduYT+o7XYw+HWs0avlwmqHsmWE05wqK5kQ9enNwKV+KufGjX9FhF7xqsfumQf8S1aGtkmwPkHEfFt0VmiDE3OhqWIpAGTYGr16tX1YN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(86362001)(2906002)(33656002)(38070700005)(66899021)(55016003)(83380400001)(186003)(9686003)(6506007)(26005)(53546011)(38100700002)(7696005)(54906003)(122000001)(76116006)(316002)(4326008)(66946007)(66476007)(66446008)(64756008)(66556008)(6916009)(71200400001)(8936002)(478600001)(52536014)(5660300002)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjZXNzZ6eWE3VWpyMk9xQk1jK2FHVWxRc3M3WVk0V3VIZDZMMVJURWUrM1Z2?=
 =?utf-8?B?eEdJZ01XVTg3eDYreDNJdUlta0pSNlRBYXFpckxEaGMzLzZGOTRRS3BhMFdr?=
 =?utf-8?B?MHlnSVNTQngxTzJlVXJvdzBzYWFiaGxubjVsR0tMOWMxNytzNTRDeFZqbktX?=
 =?utf-8?B?Qkd5Uks1bXlPRUVtWXlnQjFHeVJjVmQ4S3V6YTcxVVptcHZ2bVJXdVVaWnBx?=
 =?utf-8?B?a0pJamZxRGQwQWU2UnFvVThFSXZaYVBnZ3JwdDVBemsvd3BpZk9GaTNMTzl6?=
 =?utf-8?B?NHhvemhtZkR4UUxFbjRMUm5hdDhIRGcyRi9JT2Y2ZXduTnRxMVBnd21LY0hi?=
 =?utf-8?B?RlJxbUg1d0luZUdUZHVaT1pyQjQwbVg5MWR6cEQ2cGIvTytRSjdETDFUZHpU?=
 =?utf-8?B?K1ZheVBPeVZSelpPRVg1Mkp1aklkWHJBWk5wRWxCT1R6Z1VmQkFEWWpwQ2w3?=
 =?utf-8?B?ZmxYaTBJQTB3Wm9sUzMxcVNiV1pjZnNTZUdiUnBqc1NhQnc1S2tCNmpXQzBX?=
 =?utf-8?B?SHlsRzkvaFN4QlhjSWIzMjJlaXNSVEtaVlFESzFWUUhzc25kQm9hN0NKMmtt?=
 =?utf-8?B?QnQ3c1BFNnlzdGU5TnY4bWs4TFprTHZBb2ZjSkpPZXd3c3pyWXR4dTlKM3FP?=
 =?utf-8?B?eHhybmNXbGVSeTlKelZaRTlvWGhmbEsrOXlBL3Qvc0ErdklPdkxyTkJDaG1p?=
 =?utf-8?B?VS92aFVrSGtVWC9Gc2l3d2RRd3BuU0xXTkFSbmlGUGwvVkNZMkxQeXZmSXVV?=
 =?utf-8?B?UDIwK1c4S252Z25tUUg4QkZ0SE1VZkJSZ0lqYkxkUkhnL3JoM1N5NjJFcW5C?=
 =?utf-8?B?K1pEZTJETlNhbklBZzZFcXRjKzBuUytVejlCRVNXejdkcGVUYkQ0d2hYcXIw?=
 =?utf-8?B?RytoTW83dktocHRkOFc1NkhGOVBrajhTV3Nqdm1xeVFrT2VmZnVpTFJqUzhi?=
 =?utf-8?B?N25PUGJCYTdPa3VmZWlwUWVTZHZ0Wm5lUkM1clpaSzlWcjJDMlh5UDE1QzB1?=
 =?utf-8?B?QTg0dUY0Q2libEdGV1lrenR1N1R1S1Y0N2JyUkVmRFZteVBjVXZqWUdkampR?=
 =?utf-8?B?M0dRWUFuWlh0RHV5MFFuOWt0LzBSSm5ZY1NKRXFsZEtsY1QrSzh0blByOUIz?=
 =?utf-8?B?WHQwaVdSS0dRbi8wNDdzd3hzemJ5NU9CdnNEVU1ldnlxamZnUGJ2dUxGMkdQ?=
 =?utf-8?B?OTJWYmovZUhGRHlPN0dscUgxQVA4WDV5V2grUkN2VjJiN1pLRXpiR1RFRjRG?=
 =?utf-8?B?VllLNDRyUlZCUU9YZllaV0N3dXBwZ1BiaU1RWDNOVVFiRjFaUnd1dXB3S3hj?=
 =?utf-8?B?QmlNSWJ1T0FLWXpSVlkvZjVrbWdLcko1b0hWc0J5TjBUaWNSQ1FrUU1PWmVB?=
 =?utf-8?B?bUo1ZmRzVUtsVWdZWkxPSE93MER1RTdISlJteVZ2MUZvM2ZQNEtnR1FWeWM1?=
 =?utf-8?B?KzMwVXBtUCtYbDJLckdvamo1bmZaWGxQQ29uSjB6bk45RUlmV2JCa2loY2la?=
 =?utf-8?B?SUVYbm8zVDVKMmZuZHV6NVZCNEZ0Rm9ZYnRTN3V0c3FZeXBxQ0FrNHZQelp1?=
 =?utf-8?B?dTkwRFR1ZGduWWt3aDBzdUkwVmQ5UEl4eTdDUFUwTVZCL3RtWkNBZXo3Wm9h?=
 =?utf-8?B?MHJURG4vVWdGeWlmdnpNVVNyZFpZZTFMTGpnOUlrU0dVbS9ES0FzTzY2a2k5?=
 =?utf-8?B?anJva3pEcFdhYnJzZGloMmk2SnRQT1lwK3F6Qjhvdndyd3ZxR0t2NXVwR284?=
 =?utf-8?B?VlE1a2NHMDQ1UDFjWGhJOVhRUENJMUNsNFBjdGhsQVpFYnlCbC96RHVOK01T?=
 =?utf-8?B?Y2xPZitoMDdINWp1ekpsRUllSVo2VlNYTjdnTnZiRG1nQVdFMERDTzVHOTQ1?=
 =?utf-8?B?RUNqWS96UXhNdjl5OXNiU2laUTE0M0ZLNlBGZjREd2J2UFVwc2QvTStSNTZY?=
 =?utf-8?B?UjV1MExBZ2NhcEdvTUpIOVVtODRodXVFdFJ3SHJ1NVdVbms1MVQ5SjFtN29J?=
 =?utf-8?B?RXZKSk03VlV0S0pDNVJpQ1V3TTAwelViVDRucitkemtjZldhUE0zNnJDdnNp?=
 =?utf-8?B?MW5keDRDOEpYTkhrak1HZ0tvNkozMmtXSTAyL3dZdXhkVVZjMFZBRmx3eGRL?=
 =?utf-8?B?WDR4M0tYc1NFWk4rblNxZ29RcHZVRUR2ZUdyN2podXRUM3QzM0x4NnBtb00y?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5759297d-2eac-4d66-0dee-08db86b1bd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 10:36:54.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+NWhncnb4S+13JJchEWf6tsN7tuxYCNuMreeFjOpa5leouZejxmYmpa9yds7KJmTJGnpi761q/918mzHNaAPxp1UYJBSKSpLVFo071FVsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSENCg0KPiBGcm9tOiBHZWVydCBVeXR0
ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA3
LzEwXSBzcGk6IHJ6djJtLWNzaTogU3dpdGNoIHRvIHVzaW5nDQo+IHtyZWFkLHdyaXRlfXN7Yix3
fQ0KPiANCj4gSGkgRmFicml6aW8sDQo+IA0KPiBPbiBTYXQsIEp1bCAxNSwgMjAyMyBhdCAzOjA0
4oCvQU0gRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+
IHdyb3RlOg0KPiA+IFRoZSBSWC9UWCBGSUZPcyBpbXBsZW1lbnRlZCBieSB0aGUgQ1NJIElQIGFy
ZSBhY2Nlc3NlZCBieQ0KPiA+IHJlcGVhdGVkbHkgcmVhZGluZy93cml0aW5nIHRoZSBzYW1lIG1l
bW9yeSBhZGRyZXNzLCBhbmQNCj4gPiB0aGVyZWZvcmUgdGhleSBhcmUgdGhlIGlkZWFsIGNhbmRp
ZGF0ZSBmb3Ige3JlYWQsd3JpdGV9c3tiLHd9Lg0KPiA+IFRoZSBSWi9WMk0gQ1NJIGRyaXZlciBj
dXJyZW50bHkgaW1wbGVtZW50cyBsb29wcyB0byBmaWxsIHVwDQo+ID4gdGhlIFRYIEZJRk8gYW5k
IGVtcHR5IHRoZSBSWCBGSUZPLCBkaWZmZXJlbnRpYXRpbmcgYmV0d2Vlbg0KPiA+IDgtYml0IGFu
ZCAxNi1iaXQgd29yZCBzaXplLg0KPiA+IFN3aXRjaCB0byB1c2luZyB7cmVhZCx3cml0ZX1ze2Is
d30gdG8gZ2V0IHJpZCBvZiB0aGUgYmVzcG9rZQ0KPiA+IGxvb3BzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+
DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvc3Bp
L3NwaS1yenYybS1jc2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1yenYybS1jc2kuYw0K
PiANCj4gPiBAQCAtMTU3LDIyICsxNTcsMTUgQEAgc3RhdGljIGludA0KPiByenYybV9jc2lfc3Rh
cnRfc3RvcF9vcGVyYXRpb24oY29uc3Qgc3RydWN0IHJ6djJtX2NzaV9wcml2ICpjc2ksDQo+ID4N
Cj4gPiAgc3RhdGljIGludCByenYybV9jc2lfZmlsbF90eGZpZm8oc3RydWN0IHJ6djJtX2NzaV9w
cml2ICpjc2kpDQo+ID4gIHsNCj4gPiAtICAgICAgIGludCBpOw0KPiA+IC0NCj4gPiAgICAgICAg
IGlmIChyZWFkbChjc2ktPmJhc2UgKyBDU0lfT0ZJRk9MKSkNCj4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FSU87DQo+ID4NCj4gPiAtICAgICAgIGlmIChjc2ktPmJ5dGVzX3Blcl93b3JkID09
IDIpIHsNCj4gPiAtICAgICAgICAgICAgICAgdTE2ICpidWYgPSAodTE2ICopY3NpLT50eGJ1ZjsN
Cj4gPiAtDQo+ID4gLSAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBjc2ktPndvcmRzX3Rv
X3RyYW5zZmVyOyBpKyspDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgd3JpdGVsKGJ1Zltp
XSwgY3NpLT5iYXNlICsgQ1NJX09GSUZPKTsNCj4gPiAtICAgICAgIH0gZWxzZSB7DQo+ID4gLSAg
ICAgICAgICAgICAgIHU4ICpidWYgPSAodTggKiljc2ktPnR4YnVmOw0KPiA+IC0NCj4gPiAtICAg
ICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGNzaS0+d29yZHNfdG9fdHJhbnNmZXI7IGkrKykN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICB3cml0ZWwoYnVmW2ldLCBjc2ktPmJhc2UgKyBD
U0lfT0ZJRk8pOw0KPiA+IC0gICAgICAgfQ0KPiA+ICsgICAgICAgaWYgKGNzaS0+Ynl0ZXNfcGVy
X3dvcmQgPT0gMikNCj4gPiArICAgICAgICAgICAgICAgd3JpdGVzdyhjc2ktPmJhc2UgKyBDU0lf
T0ZJRk8sIGNzaS0+dHhidWYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY3NpLT53b3Jk
c190b190cmFuc2Zlcik7DQo+ID4gKyAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIHdy
aXRlc2IoY3NpLT5iYXNlICsgQ1NJX09GSUZPLCBjc2ktPnR4YnVmLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGNzaS0+d29yZHNfdG9fdHJhbnNmZXIpOw0KPiANCj4gQWNjb3JkaW5nIHRv
IHRoZSBoYXJkd2FyZSBkb2N1bWVudGF0aW9uWzFdLCB0aGUgYWNjZXNzIHNpemUgZm9yIGJvdGgN
Cj4gdGhlDQo+IENTSV9PRklGTyBhbmQgQ1NJX0lGSUZPIHJlZ2lzdGVycyBpcyAzMiBiaXRzLCBz
byB5b3UgbXVzdCB1c2Ugd3JpdGVsKCkNCj4gcmVzcC4gcmVhZGwoKS4gIFNvIHBsZWFzZSBjaGVj
ayB3aXRoIHRoZSBoYXJkd2FyZSBwZW9wbGUgZmlyc3QuDQo+IA0KPiBbMV0gUlovVjJNIFVzZXIn
cyBNYW51YWwgSGFyZHdhcmUsIFJldi4gMS4zMC4NCg0KWW91IGFyZSByaWdodCwgYWNjZXNzIGlz
IDMyIGJpdHMgKGFuZCBhbHRob3VnaCB0aGlzIHBhdGNoIHdvcmtzIGZpbmUsDQp3ZSBzaG91bGQg
YXZvaWQgYWNjZXNzaW5nIHRob3NlIHJlZ3MgYW55IG90aGVyIHdheSkuIE5vdyBJIHJlbWVtYmVy
DQp3aHkgSSBkZWNpZGVkIHRvIGdvIGZvciB0aGUgYmVzcG9rZSBsb29wcyBpbiB0aGUgZmlyc3Qg
cGxhY2UsIHdyaXRlc2wNCmFuZCByZWFkc2wgcHJvdmlkZSB0aGUgcmlnaHQgcmVnaXN0ZXIgYWNj
ZXNzLCBidXQgdGhlIHdyb25nIHBvaW50ZXINCmFyaXRobWV0aWMgZm9yIHRoaXMgdXNlIGNhc2Uu
DQpGb3IgdGhpcyBwYXRjaCBJIGVuZGVkIHVwIHNlbGVjdGluZyB3cml0ZXN3L3dyaXRlc2IvcmVh
ZHN3L3JlYWRzYiB0bw0KZ2V0IHRoZSByaWdodCBwb2ludGVyIGFyaXRobWV0aWMsIGJ1dCB0aGUg
cmVnaXN0ZXIgYWNjZXNzIGlzIG5vdCBhcw0KcGVyIG1hbnVhbC4NCg0KSSBjYW4gZWl0aGVyIGZh
bGxiYWNrIHRvIHVzaW5nIHRoZSBiZXNwb2tlIGxvb3BzIChJIGNhbiBzdGlsbA0KcmVtb3ZlIHRo
ZSB1bm5lY2Vzc2FyeSB1OCogYW5kIHUxNiogY2FzdGluZyA7LSkgKSwgb3IgSSBjYW4gYWRkDQpu
ZXcgQVBJcyBmb3IgdGhpcyBzb3J0IG9mIGFjY2VzcyB0byBpby5oIChlLmcuIHdyaXRlc2JsLCB3
cml0ZXN3bCwNCnJlYWRzYmwsIHJlYWRzd2wsIGluIG9yZGVyIHRvIGdldCB0aGUgcG9pbnRlciBh
cml0aG1ldGljIHJpZ2h0IGZvcg0KdGhlIHR5cGUgb2YgYXJyYXkgaGFuZGxlZCwgd2hpbGUga2Vl
cGluZyBtZW1vcnkgYWNjZXNzIGFzIGV4cGVjdGVkKS4NCg0KV2hhdCBhcmUgeW91ciB0aG91Z2h0
cyBvbiB0aGF0Pw0KDQpUaGFua3MsDQpGYWINCg0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+
IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0
dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLQ0KPiBnZWVy
dEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRl
Y2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYQ0KPiBoYWNrZXIuIEJ1dA0KPiB3aGVuIEkn
bSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0
aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0g
TGludXMgVG9ydmFsZHMNCg==
