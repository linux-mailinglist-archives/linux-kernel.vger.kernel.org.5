Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673B37B013D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjI0KF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0KFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:05:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E4EB;
        Wed, 27 Sep 2023 03:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwoM1S9oBu1csxCu5/MKNhVcsUSIeyqh2YScPRl+TcIGKzUSMMNkgwQO/lj2zESr8WBmDj3gnaJMKKqB5JlAARYi+TaymN3iSwAADEF5nzx9Oa92a+7vej7ss3meo3J3cwt3xcgG0cZIXpLB3kFcx7EBs+AADKRZxwN02xDWBu1e/hF1qIu45gA1iQyuBCASHIW+fTUfwq1YJEICuDo7D4tXeZB0lmWb5mx0+h9d4GDrJfdjlOb9DB662C51St6+QyoDA20e0uwKKimK/tMpxC2XOEPHfP9r/Jo0DVCkalTdzV+2Nu+1rprj8i4dSXRCNd89NKnZyktOad2siUkIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf2q7SmLI3kity2NVliTMqR8zzR8wpWzDQNVASf8sx4=;
 b=XwOcrnKWsztia9mqN5srC0hQJAKpxD33fHnpLxADq9qvlIJPyb4m3Haeb8cemf4+4zhmzCLw+Tr5MEQb5/rI6ObjgueDL0jEGDWzyzilUkFpB91Qlr3Jc2vorS5GF45eSiKNsShS6oGMSNrnI+PKmvJmn+NBJOTrxhK54n37P6ouTL+QQdKSiIqIRU3saxS3UCl6WAC7re8HI4mVfstyqob01RwG87i1iL3/L83hYenP95xobfqFJ5Ysr38IoxpdMk3FGtQrIK4axzLY/wEj/Xm24ikn1NMmJAKOUtxXt2OPhTZbhxbkkSm22l3X8cVSPNmxC/kbILIgAiTp4Zut3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf2q7SmLI3kity2NVliTMqR8zzR8wpWzDQNVASf8sx4=;
 b=NoOPUEBpudtjPRxSpsVSVJHltB1lwgGZMKLq5aGQ113BUS5bXHN6XU11w04ycVVLszzDAgNf/IvW430teKVLoRCt9ETSFJH1XTYSPsY+C8/eyB4e2v2tbdJ1FHIrb1f5GNPgxU2O/b34lU9DAEM7gq//mNpUVOGa6IB7cIDJU50=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB8628.jpnprd01.prod.outlook.com (2603:1096:400:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 10:05:18 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 10:05:18 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 2/2] spi: rzv2m-csi: Add Slave mode support
Thread-Topic: [PATCH 2/2] spi: rzv2m-csi: Add Slave mode support
Thread-Index: AQHZ8L2ejUaaZDAgQ0CDGG2+qUjFFbAubvCAgAABB5A=
Date:   Wed, 27 Sep 2023 10:05:18 +0000
Message-ID: <TYWPR01MB877535CB8661AE4B789519B9C2C2A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdWUr5ReouCWV3WsOJE=2faBO-y70aDC8W8qBGVBhaMTAg@mail.gmail.com>
In-Reply-To: <CAMuHMdWUr5ReouCWV3WsOJE=2faBO-y70aDC8W8qBGVBhaMTAg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB8628:EE_
x-ms-office365-filtering-correlation-id: 661c0e23-5c93-4795-8e01-08dbbf4140f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJnWvEV+1My5GoXCbOSrww+Vw2uzxYRJeCX+2QMQabVBvoZVDpQhXNQQrtJQW2/dfbqmnGLL9mPb1D70IRrVkp5OBp92yiuNe+uowOEOMS8DPz/nVivGy1delrZ2cGJG2eKAgjTWDgkt6rUTqOI2suQ4bEEqKs2ILZJfIGD1wBXh55A4uD/Rtf6WDiYD/nQfkJIDbPh4BXacUPbwzdd1k5Y+jaVKsVhiUfcJD7CWDyszDdsIgYPEtzrcUmtq6ZJHAIF1k8smAqp37/eOf2Tv4iPYV3D/wzO3hGuV8zJfHgdPT55Jt1yTbVhpzQDLjymE13Whx+9O/OsNmBlBE5oqkQqoHTKvqe1XZztdQmd+RAORGs+8UE7S2WGUhzgq4UmOmWzFQO5aibAn64bJJPpGSV1onegnAyVlg6qIzpx8bDQ1FofIpBVwDld12HO/ZemehHpx/fGUVBoFJyBa5lPVqV7EsMSZr1YaBwCcAzm6+1dFAqi0M8Cuf0K/ihS6f9cF0UZopyrrRTGRdyET3Wp4wmIU+73dW0yt93EAjWf3dj+DedJjCMMcVWGy2Kd7NPfVD7UflEhltuH1NRLztaBwIBQpqb4ggJbwEpHD84aHNJI+SG73LPQklIk8ybUa4ds7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(33656002)(38100700002)(38070700005)(122000001)(86362001)(76116006)(55016003)(53546011)(9686003)(66446008)(66476007)(5660300002)(2906002)(52536014)(316002)(478600001)(41300700001)(83380400001)(66556008)(6916009)(64756008)(66946007)(54906003)(7696005)(6506007)(7416002)(71200400001)(107886003)(8676002)(4326008)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjM3NGV5M3JHT2lzNmlXd2Y4d1BzTmVmend4a2MwS05MZ0p5RTlhNUxKZ3A2?=
 =?utf-8?B?djJOcG9ieVJ6ZnlmeE5Xdi9nNWtkb00zOXpGR2NXWEpHOFBsUmpaMHg3OXJT?=
 =?utf-8?B?TVFRTlpESHlTbDVFaEZXeXdyeXJTYmdSTkVPMzB5QldaZTk1cUxwUlJuUmha?=
 =?utf-8?B?MHRLZ0tmYWJJYjFQN0wwcUswenFXMnlGWHZmSnR6aURjZGJwenZzeDJJVGVl?=
 =?utf-8?B?TmZDWmMxMmV3aXpmYUd2bmNLWE42R0lqUkV3V0FzcjRDaGRGWm44Mk5EMjlu?=
 =?utf-8?B?ME5SQ21aNGxPVjNpNzBhb0VXaWFlU01PM2N3cXVmckVwRlhqcDRJTU5MS2hS?=
 =?utf-8?B?VmhEM1o4YzgvY1d1Wk1NbGRpS1pEZ0NBcHh5bm1oZGkzVTU0U1o5UFI2LytU?=
 =?utf-8?B?VEYzTmJ6c1BoSW0wMHB6ZHEwY2p0UjJ6SzhYZGRhbEtyTlBuQmdHeUx5K3hK?=
 =?utf-8?B?SXQxWnhRWWN0K1VVbFZDOUEva093WlRhQ1p1ZmhmNmtCT3BOczlUS1RzTmxh?=
 =?utf-8?B?SG9SNzNFeDhFRG5PQzhhY09nOURzc2libW5MMVZJN0IvK1pGTndQTm1XTWQ5?=
 =?utf-8?B?MjQwYko3bFdKRzdhMUV1YmltY1p5RG5lSC9yMDJINVJEWVc0SHRUWjlsUUZD?=
 =?utf-8?B?Nm9VaTJNaHdsSzJVZys1VWh6YzUxVGZsN0VUZkg1UkN5aXZMZUp4RGQ5ajBB?=
 =?utf-8?B?dEplWit6Y2JzZWl0TzVYcVh2WEpVVXZnVFpaRytsdmpDYVpRd0EyalFjN01j?=
 =?utf-8?B?UEFGcVAvUUFoeEJDRFNFeXBha1Y5R3hJblAxaXlzYXBaSUdrVm1TN2phNDlC?=
 =?utf-8?B?NER6ZHhNTGJTTGdsTVVqVUlXd1Y3RkxpNXBRQk1MaEpSV2tFNnFhU2k2RDJ3?=
 =?utf-8?B?SWh3ZFEyQWdqS3lJcmhxdnNmZUsrelFrNFI5bzRNTGcrZjhBdDg1S2NzZTBH?=
 =?utf-8?B?b2NwQVdUVW85L3NuK2Q2ZkkxYkoyeEFHNmhFMFF3NCtVNm1zNUtqTWJ3N0Ri?=
 =?utf-8?B?Y2VsaVZvRXpJalErZEdjaTJCV2xxb1RmaFRmSmlIVklkVFNNMVp2REVuRWtI?=
 =?utf-8?B?ZE5OVDcwUW42aFBFN0VqMGRmZU5FNWRENnl0UzZ1RXpCVUJKLy9DWVhHY2JL?=
 =?utf-8?B?TkFqV1lqeVUxSjBjQ2s2L09LR3NZUTFuKzI4SlF1OTdtaVRUOTJIajNRRGZJ?=
 =?utf-8?B?cjJqTjNmdUFjOWlZTmpzblNiOWVWdnMzTzM5cllydmZTMDZEenFOc0J1Y2ZZ?=
 =?utf-8?B?SklmbEY4R2FYaWJabFZNQkg4L3R0djdjTXlKaENaUkc0REJKS2FzckxVRTZt?=
 =?utf-8?B?b1lNNXdlZGVCakRBdmhkQ041dzFBRWtHdnIrY0Z0WDBvenNKeUFxSjAvTm03?=
 =?utf-8?B?N2F4czhtZ1hHQnluVGRIQ0o5b0lDQlhSNUdvcHd5VVZnWFVYYzBOUG0yekc5?=
 =?utf-8?B?UVoweWNGWkpQeStCTFdDSytGdS9ZM2M0YW1MNzZBdnpqWVhzN2d5ZnNQbTk5?=
 =?utf-8?B?Wkd0K2lDSXJiaENiREZaS0VWWXUxL0ZvUkx0UTJZLzFiNmdEZ2ZPajBONXl6?=
 =?utf-8?B?R2ZOb3RTTmsydnVKcytDcFhBOXpPSmoyQUh4WWoxWFlwdklhUlRtK3IySkJD?=
 =?utf-8?B?UlpFVUl5azNPbnNhWS9ia0gvb3I2QzBTWXhhTVhYbk5jOEVyY2F6d3FHdnBX?=
 =?utf-8?B?Uk54N1ZNYWNWMkNjQ2ovVThmR1g1ZVh2WTM5Wmw3Y0loQXppVDZQVzJGa3c2?=
 =?utf-8?B?QUdncGZCL0ZoMUVTWmZvcGhQZWF2SzVVRkl0bUFlRURITEZLS2tBNUQ5eUpq?=
 =?utf-8?B?dVEyQkcwU1hCZWtsdWtKc2lQK212dzZGcitWcU4wSUdQcWh1VlhpRnROZSsx?=
 =?utf-8?B?Q0haSWxHbWkvZ2FoV3pVMTNINUpXdFVqL3AyWm83cXZBVVVMZUo5azhHSUVC?=
 =?utf-8?B?MUZhMGtaRkVTa29xcU1TTTV5c0V3bWlNcmoxL2tka2l0VDVja3FNWFI4NmhO?=
 =?utf-8?B?UDNiMzJWMW1MVCs4YmJnZ0RKQ3IxVWxsaWhQRUQ2MWtGRXRQOTNtcEZIUzg3?=
 =?utf-8?B?RmJGY3lEWmx0QWptZ3pDejdUMndWVGtadUdHOXhaVy8xTEJvWDVKTGlVbjUz?=
 =?utf-8?B?RnVTZW1oNDczUjdRMXo4Ly9hb1hUdXVzM3RBNWh2K1BPaytBUG00R1N1OEp6?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661c0e23-5c93-4795-8e01-08dbbf4140f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:05:18.5938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0l5pMKik2kvQr5X0XSXqB09EoB+JcWSnnnO3SLdX0W7g219HAibC7uSdqPP+gJMJLi7haCAqKWLj4+TAsiEO0088ElJQBd/iMOmM3nv+ZOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSENCg0KPiBGcm9tOiBHZWVydCBVeXR0
ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIv
Ml0gc3BpOiByenYybS1jc2k6IEFkZCBTbGF2ZSBtb2RlIHN1cHBvcnQNCj4gDQo+IEhpIEZhYnJp
emlvLA0KPiANCj4gT24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMTE6MDjigK9QTSBGYWJyaXppbyBD
YXN0cm8NCj4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhl
IENTSSBJUCBmb3VuZCBpbnNpZGUgdGhlIFJlbmVzYXMgUlovVjJNIFNvQyBzdXBwb3J0cw0KPiA+
IGJvdGggU1BJIE1hc3RlciBhbmQgU1BJIFNsYXZlIHJvbGVzLg0KPiA+DQo+ID4gV2hlbiB3b3Jr
aW5nIGluIHNsYXZlIG1vZGUsIHRoZSBDU0kgSVAgaGFzIHRoZSBvcHRpb24NCj4gPiBvZiB1c2lu
ZyBpdHMgU2xhdmUgU2VsZWN0IChTUykgcGluIHRvIGVuYWJsZSBUWCBhbmQgUlgNCj4gPiBvcGVy
YXRpb25zLiBTaW5jZSB0aGUgU1BJIHNsYXZlIGNhbm5vdCBjb250cm9sIHRoZSBjbG9jaywNCj4g
PiB3aGVuIHdvcmtpbmcgYXMgc2xhdmUgaXQncyBiZXN0IG5vdCB0byBzdG9wIG9wZXJhdGlvbnMN
Cj4gPiBkdXJpbmcgYSB0cmFuc2ZlciwgYXMgYnkgZG9pbmcgc28gdGhlIElQIHdpbGwgbm90IHNl
bmQgb3INCj4gPiByZWNlaXZlIGRhdGEsIHJlZ2FyZGxlc3Mgb2YgY2xvY2sgYW5kIGFjdGl2ZSBs
ZXZlbCBvbiBwaW4gU1MuDQo+ID4gQSBzaWRlIGVmZmVjdCBmcm9tIG5vdCBzdG9wcGluZyBvcGVy
YXRpb25zIGlzIHRoYXQgdGhlIFJYDQo+ID4gRklGTyBuZWVkcyB0byBiZSBmbHVzaGVkLCB3b3Jk
IGJ5IHdvcmQsIHdoZW4gUlggZGF0YSBuZWVkcw0KPiA+IHRvIGJlIGRpc2NhcmRlZC4NCj4gPg0K
PiA+IEZpbmFsbHksIHdoZW4gaW4gc2xhdmUgbW9kZSB0aW1pbmdzIGFyZSB0aWdodGVyLCBhcyBt
aXNzaW5nIGENCj4gPiBkZWFkbGluZSB0cmFuc2xhdGVzIHRvIGVycm9ycyBiZWluZyB0aHJvd24s
IHJlc3VsdGluZyBpbg0KPiA+IGFib3J0aW5nIHRoZSB0cmFuc2Zlci4gSW4gb3JkZXIgdG8gc3Bl
ZWQgdGhpbmdzIHVwLCB3ZSBjYW4NCj4gPiBhdm9pZCB3YWl0aW5nIGZvciB0aGUgVFggRklGTyB0
byBiZSBlbXB0eSwgd2UgY2FuIGp1c3Qgd2FpdA0KPiA+IGZvciB0aGUgUlggRklGTyB0byBjb250
YWluIGF0IGxlYXN0IHRoZSBudW1iZXIgb2Ygd29yZHMgdGhhdA0KPiA+IHdlIGV4cGVjdC4NCj4g
Pg0KPiA+IEFkZCBzbGF2ZSBzdXBwb3J0IHRvIHRoZSBjdXJyZW50bHkgZXhpc3RpbmcgQ1NJIGRy
aXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8u
Y2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiAN
Cj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9zcGkvS2Nv
bmZpZw0KPiA+IEBAIC04NjEsOCArODYxLDEwIEBAIGNvbmZpZyBTUElfUlNQSQ0KPiA+ICBjb25m
aWcgU1BJX1JaVjJNX0NTSQ0KPiA+ICAgICAgICAgdHJpc3RhdGUgIlJlbmVzYXMgUlovVjJNIENT
SSBjb250cm9sbGVyIg0KPiA+ICAgICAgICAgZGVwZW5kcyBvbiBBUkNIX1JFTkVTQVMgfHwgQ09N
UElMRV9URVNUDQo+ID4gKyAgICAgICBkZXBlbmRzIG9uIFNQSV9TTEFWRQ0KPiANCj4gSXNuJ3Qg
dGhhdCBhIGJpdCB0b28gc3RyaWN0Pw0KPiBUaGUgZHJpdmVyIGNhbi9zaG91bGQgYmUgdXNlZC91
c2FibGUgaW4gaG9zdCBtb2RlIHdoZW4gU1BJX1NMQVZFDQo+IGlzIG5vdCBlbmFibGVkLg0KDQpH
b29kIHBvaW50LCBJJ2xsIHRha2UgdGhpcyBkZXBlbmRlbmN5IG91dC4NCg0KPiANCj4gPiAgICAg
ICAgIGhlbHANCj4gPiAtICAgICAgICAgU1BJIGRyaXZlciBmb3IgUmVuZXNhcyBSWi9WMk0gQ2xv
Y2tlZCBTZXJpYWwgSW50ZXJmYWNlDQo+IChDU0kpDQo+ID4gKyAgICAgICAgIFNQSSBkcml2ZXIg
Zm9yIFJlbmVzYXMgUlovVjJNIENsb2NrZWQgU2VyaWFsIEludGVyZmFjZQ0KPiAoQ1NJKS4NCj4g
PiArICAgICAgICAgQ1NJIHN1cHBvcnRzIG1hc3RlciBhbmQgc2xhdmUgcm9sZXMuDQo+ID4NCj4g
PiAgY29uZmlnIFNQSV9RQ09NX1FTUEkNCj4gPiAgICAgICAgIHRyaXN0YXRlICJRVEkgUVNQSSBj
b250cm9sbGVyIg0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktcnp2Mm0tY3NpLmMNCj4g
PiArKysgYi9kcml2ZXJzL3NwaS9zcGktcnp2Mm0tY3NpLmMNCj4gDQo+ID4gQEAgLTk5LDYgKzEx
Miw5IEBAIHN0cnVjdCByenYybV9jc2lfcHJpdiB7DQo+ID4gICAgICAgICB3YWl0X3F1ZXVlX2hl
YWRfdCB3YWl0Ow0KPiA+ICAgICAgICAgdTMyIGVycm9yczsNCj4gPiAgICAgICAgIHUzMiBzdGF0
dXM7DQo+ID4gKyAgICAgICBpbnQgbW9kZTsNCj4gDQo+IERvIHlvdSBuZWVkIHRoaXMgZmxhZz8N
Cg0KTm9wZSwgaXQncyBqdXN0IHRoYXQgdGVzdGluZyBpdCBpcyBnb2luZyB0byBiZSBzbGlnaHRs
eSBmYXN0ZXIuDQoNCj4gWW91IGNhbiB1c2Ugc3BpX2NvbnRyb2xsZXJfaXNfdGFyZ2V0KCkgaW5z
dGVhZC4NCg0KV2lsbCBkby4NCg0KPiANCj4gPiArICAgICAgIGludCBzbGF2ZV9zZWxlY3Q7DQo+
ID4gKyAgICAgICBib29sIHNsYXZlX2Fib3J0ZWQ7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGlj
IHZvaWQgcnp2Mm1fY3NpX3JlZ193cml0ZV9iaXQoY29uc3Qgc3RydWN0IHJ6djJtX2NzaV9wcml2
DQo+ICpjc2ksDQo+IA0KPiA+IEBAIC0yNzksMzIgKzMwMywyMyBAQCBzdGF0aWMgaW50IHJ6djJt
X2NzaV93YWl0X2Zvcl9pbnRlcnJ1cHQoc3RydWN0DQo+IHJ6djJtX2NzaV9wcml2ICpjc2ksDQo+
ID4NCj4gPiAgICAgICAgIHJ6djJtX2NzaV9lbmFibGVfaXJxcyhjc2ksIGVuYWJsZV9iaXRzKTsN
Cj4gPg0KPiA+IC0gICAgICAgcmV0ID0gd2FpdF9ldmVudF90aW1lb3V0KGNzaS0+d2FpdCwNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKGNzaS0+c3RhdHVzICYgd2FpdF9t
YXNrKSA9PQ0KPiB3YWl0X21hc2spIHx8DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY3NpLT5lcnJvcnMsIEhaKTsNCj4gPiArICAgICAgIGlmIChjc2ktPm1vZGUgPT0gUlpW
Mk1fQ1NJX1NQSV9TTEFWRSkgew0KPiANCj4gc3BpX2NvbnRyb2xsZXJfaXNfdGFyZ2V0KCkNCg0K
V2lsbCBjaGFuZ2UuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IHdhaXRfZXZlbnRf
aW50ZXJydXB0aWJsZShjc2ktPndhaXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAoKGNzaS0+c3RhdHVzICYgd2FpdF9tYXNrKSA9PQ0KPiB3YWl0X21hc2spIHx8DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjc2ktPmVycm9ycyB8fCBjc2ktPnNsYXZl
X2Fib3J0ZWQpOw0KPiANCj4gdGFyZ2V0X2Fib3J0ZWQgKGV2ZXJ5d2hlcmUpDQoNCldpbGwgY2hh
bmdlLg0KDQpDaGVlcnMsDQpGYWINCg0KPiANCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCB8
fCBjc2ktPnNsYXZlX2Fib3J0ZWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0g
LUVJTlRSOw0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0g
d2FpdF9ldmVudF90aW1lb3V0KGNzaS0+d2FpdCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICgoY3NpLT5zdGF0dXMgJiB3YWl0X21hc2spID09DQo+IHdhaXRfbWFzaykgfHwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNzaS0+ZXJyb3JzLCBIWikgPT0g
MCA/IC1FVElNRURPVVQgOg0KPiAwOw0KPiA+ICsgICAgICAgfQ0KPiANCj4gR3J7b2V0amUsZWV0
aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4g
R2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAt
LQ0KPiBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9u
cyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYQ0KPiBoYWNrZXIuIEJ1dA0K
PiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIi
IG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
