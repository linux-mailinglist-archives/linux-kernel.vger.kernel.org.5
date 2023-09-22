Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F17AA9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjIVHPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:15:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48DC2;
        Fri, 22 Sep 2023 00:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+sf2mYIMJs/Zac278AunWvLjs+pzrOOY6NS8xuOG7Wb7xzaqpJ+o+u7FwdIt0g6vcvPc5WsYK5WqtXhnf+Vx7MQlwbjQnJaeXqtD84NU5ecWXpvQymAxa5e+VlyVb2Ph76nO2xmpv0JOz5YUe6TY9WoPK2w7LPmdITt7BRIndYphwUnhs91UyNTDprtJphPovpJxFQ5Y3UKaPRwg/mjiRB8Qc2dM0LFI38pHEViSPftUzDRu/I8JxeGCMTRWPjI39p3QXEyqpBjrv2CsRgEjJ2O2NBqvpuWRpaEO8I3mNjGmQEUYcjYlsgwFZntOI30nslggFe6VPz7Mfq37GEzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drCeuk5/vrxWruk58Bdq4GwFBlaBzwk6SnMsHPp0g5I=;
 b=WW2OCKRihae88pz89QNBpir6F/JqNfB7Y6r2moP1XAKSuHG7wfaMP0aCyMNWRdCQJVIIu6Ya3U8KQ6feMliU+lnIr/Z5zBe8Gxaq3z9nfE0++WqNWkLXg+/2YBeDVLaetrjsX2V6/DjoE1/HYTGkHdR403Wr4x7/VtI94QeZGr+6SJpxL9T7PKGrb70stiOBb7zcTW/bOPB1J0+7DMc7xeAmUTSUvZ8HkHPp8BuzVcFz5qiIoCZRTLOoxop1xz7d01MkpJVq0lilkp09zmloEPkYEv2lxYBdUwRJeqVxsUL/TZYRb26HePpVNyVfKpuiLvQaP/KSpDxUExOBFYiI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drCeuk5/vrxWruk58Bdq4GwFBlaBzwk6SnMsHPp0g5I=;
 b=OgWyVsH5Nt63KCCY0T+w5j+GbfrrDOIn8+2FzL4vkvpzE+zsZuIp06rElQ6vvcuKwxmgBgIrE2qKZCcOaMyOyK9TNWPqe0l5HIvehj6A3sp3D+O+DLjPPvp+FFs2NBD2n2J8X9PqgHSFY58lJZkaDRCNFYzKUSMnMTueF5jCz4s=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8573.jpnprd01.prod.outlook.com (2603:1096:400:171::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 07:14:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 07:14:53 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] alarmtimer: Fix rebind failure
Thread-Topic: [PATCH] alarmtimer: Fix rebind failure
Thread-Index: AQHZ67nxDPIpzSJRaUGrxRMZix2AJrAjo1KAgAADuiCAAsoCkA==
Date:   Fri, 22 Sep 2023 07:14:53 +0000
Message-ID: <OS0PR01MB592211963202423E46CC2B4D86FFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWp_U_k5nSgmNV6whdK=pNr14h2dS=NetJXRgVEDSSK_g@mail.gmail.com>
 <OS0PR01MB59221716AD7E6A10CDB295D986F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59221716AD7E6A10CDB295D986F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8573:EE_
x-ms-office365-filtering-correlation-id: 46dd31b1-8375-4265-202e-08dbbb3b9e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1v2i7HYrhv7u/9IhuSL8Ya1r/C02rLqxJuaRfqhwioImvzCQbAp2935dQVHJfHavd/+iun65EpfruRsTyxX0VzhxsLfzJ6VHrD1NnUgiX6C4eyKy/oq8llI7w1DOrqw5ow0l4jRqwgujBKtAwvvEao53KCwvuCZSuypWTgan1RXQ3DLtTE0F1JfLdewHIHb6FdEq2/zZSwKpHrIOuZfD5zdRdXCAdyKq75hfK/Ru23sIUCDDb05ZaFoBw6XVF65wBmdOJ8lrMZKUQfBxQ/qapdc9zYebBdAlRxFjQTIUBlsyZxNkB40WSILWvTszQLJbdW12KcCdg1CehBaaVeiLfiyPlm18Kr/S3dmB3TPlmEruaoSlLBY/i7cDfNBzts12RYvnYRNilYcrFwaJ+P+Ad58ZRfttfyIQV9P/tO1aT95t1sLzJLPV/LA5QM93ZFIRhQY01pnF43mT0PgRc0n0PJhW1jF95lTK6PwhDUZhZq0qPhivC7/6Loq+kt6PQkbEmHEGjIVDyBKbLixm3iq8xfNUCin6X45I5FeIj3dZMdczlJEsC4UjZEZzE38836wusV2zWpBj9e8q2Z0Ao8DppaV65LWfMDXh0QxR12M205Wbte0zDtQXCp7prUTUBsYG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199024)(186009)(1800799009)(8936002)(2906002)(5660300002)(4326008)(52536014)(66446008)(55016003)(26005)(66556008)(7416002)(6916009)(41300700001)(316002)(66946007)(54906003)(66476007)(76116006)(64756008)(8676002)(478600001)(71200400001)(7696005)(6506007)(53546011)(9686003)(38100700002)(122000001)(38070700005)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajZKSUc4aElkc0dpQlFXMk1VS1JueFd0Nk4zdkEvN3FvbGFGNTlLWEloN1dE?=
 =?utf-8?B?ZmNyQ2h1QXNhcjBPQUxWR2NBOU5ndnBxRndBbzVaZWtta2EwWGVORlg4Rkxi?=
 =?utf-8?B?RFh4c3ZJNm9TdVUyUnJsVVl6SVo1TjVjV2Vua2hka05XbjJjZFdYOGdkNXdw?=
 =?utf-8?B?Wi9XbFo0a1ZPU0RjWXlmMm9Jc0MydldGMFg2dGp5YTZxUnorVzk3RG5ReXB2?=
 =?utf-8?B?MXRlUHo2REkzQmZYbFVIMVZnZTJhWDREZ21UbXJFRjhYT0Q1ZVlIbVppNHFF?=
 =?utf-8?B?TGFmTGtPdE9CdVJlZVZvVXdpSit0dHpFNFdsWUxLNElRYjRqTkp6bmxRUVNU?=
 =?utf-8?B?ZHBtTmI1VGJ0Z2N0RmVrTXhxbFVOVWNuQkZzNmVHdm05KzhjQXliaVRTUUtS?=
 =?utf-8?B?aG1FcG1zMWFqRFQrT1ZlUU9UaVpoNElnTWxHMjljUndzS3FlOTVycm9BdlM2?=
 =?utf-8?B?dmVDcFIrazlra2YxNjVlSGMwZ1p5WjRoTHU5a3FNMndKSWJ6VkZBNi9ockxa?=
 =?utf-8?B?b01iTk9TcFdMMzZqamEyZC9HaXlUbVBOVDVWLzJ5K2JFOEJDM1c1WTdQbW9Z?=
 =?utf-8?B?Y24zNTZpVDZtR0ZlWG03N0h3Y2NEb2NOUDdaS2xhY3ovZlhTUFkzbVVVdTJ6?=
 =?utf-8?B?c1dHYlVUOGIvK3llQ2xMb3V5S055RTc5by9sRmxLdmdBdFhhUXRGVjdVaVI4?=
 =?utf-8?B?cnlzN0Q3T3RXbDhQc2sxangxcUpTY1NLbWVlc0ttcTF0WTlNZzkxTUVFTHdQ?=
 =?utf-8?B?b3JEY1Vkb0luQ01kUnU4TGRhRGpFMDB4aDhQRm1hSDFrUURlVEhzQnkybkhn?=
 =?utf-8?B?U09wZ0Nza0dzMHpLSHpmN1FWb2ZYV0U4WnVKTlN3QmI4RllpUmhKclFoU0Qy?=
 =?utf-8?B?Ni85NEdMby9vRlN0REREMmNoN1A1SmdSRFhNMUdVVi9XNWIzZ2tNWFpaUElu?=
 =?utf-8?B?Rmg0cHBXbkN1Q2o0eWRBRi8yN2ZwRjhFbURmeW5MV0RYZytNTFcxL0REWTVD?=
 =?utf-8?B?TnYyWm1sMTRWY3M1MWVXY2xZYTdhdFovaU80U0IyMTNHTEF6UEg1Vk0rNkhx?=
 =?utf-8?B?dGxsVCtudERITWd0NnBmaDhtR2JSeDhPT3EzdXBNendaRnFxeXBneUl5TGU2?=
 =?utf-8?B?UFJOLzdFOWxnOVZlbllLZnYxdFdZbms5RlFXVW9CU1V1aExjdFl3RGFpNWhL?=
 =?utf-8?B?cmlheG15eVdTZTVwdmlSLy9Fb211U2RzNDdQcnJqaFdvYmNPeURNMUpCRy9s?=
 =?utf-8?B?blJCVGFaYjAyanFINzlRR090cHFKOU5YTWc5MGJrUFhxb29WQ216RCtyeWFw?=
 =?utf-8?B?eXRELzBoQTdLaWRnMEFFZkEzbmx5c3VQUEZwRWdDeXUram44L3lhUFBBUU9x?=
 =?utf-8?B?VnJDZGhSR1RGM1V4aUZKakVTNXE4SU5YWlU2cGFWR1lDWjBFQmFaM2FjUVdS?=
 =?utf-8?B?bng3N2tydmpVeVFBVEVNYy9sOGJUaVlPbHpKRGNVcmJ5NVgreW5hSE5JYVpF?=
 =?utf-8?B?ZmdpSzZEdkttNU94cjVyOXN2d2krbDNxMXNWT1V5QlFvNkg4a1JMSFFOVFBy?=
 =?utf-8?B?bHBLMEl0U0s1c3ZFQWU1aGQ5QzQ0cHZsMTU3ZmFBT2VPL0lMclpHK0RTL1Ft?=
 =?utf-8?B?OEJ4R2tVbWozWGdSUUMwYXJ5NTkvM3JDU20xNGkzcXg2VWxCQkpuWmdkT3E0?=
 =?utf-8?B?aGdMWnNUL2tBd0JjNmp5WlFUQkxWcERuUHlJdWd5c2hLbENtRVo4TXpQOFVy?=
 =?utf-8?B?LzRYSk1Td2l0ZUdKSGJwTjhPUC9DdnA4VmkrRTRJNVQ2RDlWTDAyOFNpUmNw?=
 =?utf-8?B?anhaZTk4UW1XdjNEdmMxWnZGL2h1bFk5ZGN4ak13WGlLVzBjWitIa05Ia1VG?=
 =?utf-8?B?b0xmZ0xxTjliN3QrNWhGZTRUeEtzWVRKbXRmZ1NweHNobktDNzdhdXF1ZmJn?=
 =?utf-8?B?R0F0NHV2RnlEVXZ2TTZrdVY4Z3NVaCtrcElJKzQ5YlRqTmQzN3Y5c0p5ZDJZ?=
 =?utf-8?B?Wms5WnJGbjl0TndGdWtZSlFaR2VjWGx2OXhkS1l0VFZqdHdxcXZraEhibXpa?=
 =?utf-8?B?Tk9adWQrQ0xxUG83U2NnaUJGbjFrVEVsdUZJa1lvTlpqbmtrS1BDNitXZmU1?=
 =?utf-8?B?OEhpcWFPUGZlNzhYQTYxVEhkQkdrT2drVWRkQTVYRGg1UkZyMXRyd1o4Mkxs?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dd31b1-8375-4265-202e-08dbbb3b9e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:14:53.4850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ora2AvH/38/5USHR9Uddn+JIArzwFHi4kdcSxWWhWOgZqkbhRye7DhCFSKft8dgcJKN/qFdbIpyvhOVaJjk8m8aRrVPP6vOVQzV9evWHN24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8573
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGFsYXJtdGlt
ZXI6IEZpeCByZWJpbmQgZmFpbHVyZQ0KPiANCj4gSGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KPiAN
Cj4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+IA0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGFsYXJtdGltZXI6IEZpeCByZWJpbmQgZmFpbHVyZQ0KPiA+DQo+ID4gSGkgQmlqdSwNCj4gPg0K
PiA+IE9uIFdlZCwgU2VwIDIwLCAyMDIzIGF0IDE6NTnigK9QTSBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPiBUaGUgcmVzb3VyY2VzIGFsbG9j
YXRlZCBpbiBhbGFybXRpbWVyX3J0Y19hZGRfZGV2aWNlKCkgYXJlIG5vdCBmcmVlZA0KPiA+ID4g
bGVhZGluZyB0byByZS1iaW5kIGZhaWx1cmUgZm9yIHRoZSBlbmRwb2ludCBkcml2ZXIuIEZpeCB0
aGlzIGlzc3VlDQo+ID4gPiBieSBhZGRpbmcgYWxhcm10aW1lcl9ydGNfcmVtb3ZlX2RldmljZSgp
Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gPg0KPiA+IERv
ZXMgdGhpcyBuZWVkIGEgRml4ZXMgdGFnPw0KPiANCj4gSSB0aGluayBzbywgYXMgaXQgYnJlYWtz
IHVuYmluZC9iaW5kIG9uIGxvdCBvZiBSVEMgZHJpdmVycy4NCj4gDQo+IFRoZXJlIGFyZSAyIGNv
bW1pdHMsIEkgd2lsbCBhZGQgYm90aCBhcyBmaXhlcyB0YWcuDQo+IA0KPiBjNzkxMDhiZDE5YTgg
KCJhbGFybXRpbWVyOiBNYWtlIGFsYXJtdGltZXIgcGxhdGZvcm0gZGV2aWNlIGNoaWxkIG9mIFJU
Qw0KPiBkZXZpY2UiKQ0KPiANCj4gN2M5NGNhY2E4NzdiICgiYWxhcm10aW1lcjogVXNlIHdha2V1
cCBzb3VyY2UgZnJvbSBhbGFybXRpbWVyIHBsYXRmb3JtDQo+IGRldmljZSINCj4gDQo+ID4NCj4g
PiA+IC0tLSBhL2tlcm5lbC90aW1lL2FsYXJtdGltZXIuYw0KPiA+ID4gKysrIGIva2VybmVsL3Rp
bWUvYWxhcm10aW1lci5jDQo+ID4gPiBAQCAtNjEsNiArNjEsNyBAQCBzdGF0aWMgREVGSU5FX1NQ
SU5MT0NLKGZyZWV6ZXJfZGVsdGFfbG9jayk7DQo+ID4gPiAgLyogcnRjIHRpbWVyIGFuZCBkZXZp
Y2UgZm9yIHNldHRpbmcgYWxhcm0gd2FrZXVwcyBhdCBzdXNwZW5kICovDQo+ID4gPiAgc3RhdGlj
IHN0cnVjdCBydGNfdGltZXIgICAgICAgICAgICAgICAgcnRjdGltZXI7DQo+ID4gPiAgc3RhdGlj
IHN0cnVjdCBydGNfZGV2aWNlICAgICAgICpydGNkZXY7DQo+ID4gPiArc3RhdGljIHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgICpydGNfcGRldjsNCj4gPiA+ICBzdGF0aWMgREVGSU5FX1NQSU5MT0NL
KHJ0Y2Rldl9sb2NrKTsNCj4gPiA+DQo+ID4gPiAgLyoqDQo+ID4gPiBAQCAtMTA5LDYgKzExMCw3
IEBAIHN0YXRpYyBpbnQgYWxhcm10aW1lcl9ydGNfYWRkX2RldmljZShzdHJ1Y3QNCj4gPiA+IGRl
dmljZQ0KPiA+ICpkZXYpDQo+ID4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICAg
ICAgICAgICAgICAgICBydGNkZXYgPSBydGM7DQo+ID4gPiArICAgICAgICAgICAgICAgcnRjX3Bk
ZXYgPSBwZGV2Ow0KPiA+ID4gICAgICAgICAgICAgICAgIC8qIGhvbGQgYSByZWZlcmVuY2Ugc28g
aXQgZG9lc24ndCBnbyBhd2F5ICovDQo+ID4gPiAgICAgICAgICAgICAgICAgZ2V0X2RldmljZShk
ZXYpOw0KPiA+ID4gICAgICAgICAgICAgICAgIHBkZXYgPSBOVUxMOw0KPiA+ID4gQEAgLTEyMyw2
ICsxMjUsMjMgQEAgc3RhdGljIGludCBhbGFybXRpbWVyX3J0Y19hZGRfZGV2aWNlKHN0cnVjdA0K
PiA+ID4gZGV2aWNlDQo+ID4gKmRldikNCj4gPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+
ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyB2b2lkIGFsYXJtdGltZXJfcnRjX3JlbW92ZV9kZXZp
Y2Uoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4gPiArICAgICAgIHN0cnVjdCBydGNfZGV2aWNl
ICpydGMgPSB0b19ydGNfZGV2aWNlKGRldik7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGlmIChy
dGNfcGRldikgew0KPiA+DQo+ID4gQXMgdGhlIHJldHVybiB2YWx1ZSBvZiBjbGFzc19pbnRlcmZh
Y2UuYWRkX2RldigpIGlzIG5ldmVyIGNoZWNrZWQNCj4gPiAoYWxhcm10aW1lcl9ydGNfYWRkX2Rl
dmljZSgpIHJldHVybnMgLUVCVVNZIG9uIGFkZGluZyBhIHNlY29uZA0KPiA+IGFsYXJtdGltZXIp
LCBtdWx0aXBsZSB0aW1lcnMgbWF5IGhhdmUgYmVlbiBhZGRlZCwgYnV0IG9ubHkgb25lIG9mIHRo
ZW0NCj4gPiB3aWxsIGJlIHRoZSByZWFsIGFsYXJtdGltZXIuDQo+ID4gSGVuY2UgdGhpcyBmdW5j
dGlvbiBzaG91bGQgY2hlY2sgaWYgcnRjZGV2ID09IHJ0YyBiZWZvcmUgdW5yZWdpc3RlcmluZw0K
PiA+IHRoZSByZWFsIGFsYXJtdGltZXIuICBPZiBjb3Vyc2UgYWxsIG9mIHRoaXMgc2hvdWxkIGJl
IHByb3RlY3RlZCBieQ0KPiBydGNkZXZfbG9jay4NCj4gDQo+IE9rIHdpbGwgYWRkIGxvY2sgaGVy
ZSBhbmQgdGhlIGNoZWNrLg0KDQpJIHdvbid0IGJlIGFibGUgdG8gYWRkIGxvY2sgaGVyZSBhcyBp
dCBpcyBnaXZpbmcNCg0KMSkgQlVHIGludmFsaWQgY29udGV4dA0KMikgU2NoZWR1bGluZyB3aGls
ZSBhdG9taWMoKSBhcyBsb2NrIGlzIGhlbGQgYnkgZGVsZXRlIGZ1bmN0aW9uLg0KDQpDaGVlcnMs
DQpCaWp1DQo=
