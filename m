Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467447563B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGQNBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGQNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:01:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2097.outbound.protection.outlook.com [40.107.113.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8EE76;
        Mon, 17 Jul 2023 06:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwGE9QvZryzlP0XgMj14rV9333/yhZk8lma5radGbVz5EBRhT6CvRv0sr1KHE49JF038J4fKmzGcGgyhrEZK2tkwNlN91INbn8De+utQnLp6eEJP+l3Z8+xQo0jWVIKHIdzJ1fOuYKKGCULIzFy1by8wkoMLxi4H2E96qtrIT23BgVlCfPs4XG48VgN+VS4r/CpUOS2FAogdJeYBRNKnbukHppUzdQajaMMaSljRXdmeKpSKVchnlIlLFTa5do55FYaunTCSWuf1R7Yn1pkD2XVG/5OzR7P0cvVC5HiPxkkphlXnKM9cySco3k/vwRd8XqMoJfQ9oSKwLBqi/Dz/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhz5kQHIRzxsstw776cOBSa3k901mt0MP2e7AYntP3k=;
 b=B6kc3mhMrkzV1djMElZXQ2BXboHJkf0dm2TGnjh6kLSw7BRFjtC95dkvrbQHgmEEUjQe+CZYoIf/NxOB5jysYUU1fp7Ti4fZbDvAzK+pdK57GLiF6mTiYwuBkmbMcVGyPIJCXKtSdIYKr2Q1DoIxVhBWmBXlPT2V9kdGG2YMFB6bX+LcoHCAA+quI1Ue9OkD1kSVO3kW05SEousKWPIPcjr3JX2L3AXvSt2yCFAkE0HUlmxr/J4Q9fONnND1xph2Al/e/+14N4zPdmttRqTA3wsvrt3HXjzT+2q2TqrRvtdfBR7QHidmRI3sobvgV74FJ0Xk5ZnWdWpzonHYUSvTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhz5kQHIRzxsstw776cOBSa3k901mt0MP2e7AYntP3k=;
 b=D73To9+X1yyJ8mabCWT4CVincif73JnzSRKi0jIEVUoZFoIBTeUAFMmwe5RTUiN0ewgNEYlp0CoEnkZ9FduKsNSHnk6TFBShSwlG07eCEKHlzoEws67PhqmW37RWdUy1bzH7E7Hk2wiZr7Q8606xXAPii32VmFP3311raP2zrQU=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB5616.jpnprd01.prod.outlook.com (2603:1096:400:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 13:00:21 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:00:21 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
Thread-Topic: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
Thread-Index: AQHZtrhW9m6gE+r9C0SdjPac+B4RGq+9ty4AgAAMoZCAAA+LAIAAGufg
Date:   Mon, 17 Jul 2023 13:00:21 +0000
Message-ID: <TYWPR01MB8775B01AB7A7FA59E38F77D6C23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
 <20230715010407.1751715-8-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUzxQfi2w8dyF8gCitkSKkw_fRE074EUuB+tHKn8WM3=w@mail.gmail.com>
 <TYWPR01MB8775869576E4B3F0FEFCF3DCC23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <CAHp75VdNvWS04VN58r5VcSJskeVJF0g0_spSRb8f0_OP1P04QQ@mail.gmail.com>
In-Reply-To: <CAHp75VdNvWS04VN58r5VcSJskeVJF0g0_spSRb8f0_OP1P04QQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB5616:EE_
x-ms-office365-filtering-correlation-id: ca197947-ad1d-44cd-a8aa-08db86c5c75e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCc/u8DkPrli8yXocETRPZ4IWhVRAhbX8EickNZ3rat4RBJ+ZfqBOJlTmnVjgdQtNK2ZZuJFFOuua3Y3s3AQF1JSRMno19WLGc54vo3RWBijOCZ9Wdc8ZA/k180mBzHuaID01KK2iAOt2AWWQJh3KwG+e5puLaFAcUFWCr/YNfFZYT7i/yn7Jw+jwQNj3ltdkLHvoibpEzFtapM2ue9K6V+uEdYO8tOY2k7xlU2HkZJyb/r4yuCLNzTx2tH9r3Vy1X13Vrx3GfqDgrGIC7/WLnsn7FtK/fY6xZi+OISGV98IhCKVcsIpK3jecofvh0/ASO3uFwIrzhTxkk70pswM1p6OtXNQkEVt05MbFJm9/LfjQ3mKqE4ZBWfIM2R4mQofRnWs5H8J3eMeBFSJ2KtFTznPJjTs1wGRqaB7eB4KJfs0WJvR1iVhRwI+i8OXnhcwKKhmuQzw+LZag2fqzfnlMOv2qtwcdYuS74+Jm0DuNQ052nCrWaVpR5p9tsWaHYA77hCTtODkrF0wF4KeZIUDS/TkwuOEdrlwOqV9RW7UZhW2NbMC0RwiGHTmzDVtkgkzIApvoYXM/R81bvUej1WI20Lrw4S9mBzYnWzVpTqaMuTYiSP7sa8w8IER7+Oj9uoj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(55016003)(122000001)(54906003)(71200400001)(7696005)(478600001)(5660300002)(52536014)(8676002)(8936002)(2906002)(38070700005)(86362001)(33656002)(4326008)(6916009)(76116006)(38100700002)(64756008)(66556008)(66446008)(66476007)(66946007)(41300700001)(316002)(6506007)(26005)(53546011)(83380400001)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXRYWHJ5RVJPQzROL2NEN3pDaXlLeWRaNFNlbGRjZkRsanAvNUhrVGhycE02?=
 =?utf-8?B?SG90UVkwam1qblYyVVd1blFrYXhTQjBPMWZyWEkwZHo2c1Y1QnMvVzgzMUNm?=
 =?utf-8?B?WGJ2aWJoQzM1UldxbElRY0NIdkJCblJ6S1paTkRpYzRRUitoVEgzZUMya25O?=
 =?utf-8?B?alFMTFQxMHJPaE1sS2sveFBGOTA3Q0JrQVl5SVk1N0RXNE96dWFzRzZRSmpU?=
 =?utf-8?B?NkJLYUU4QW1LS3FhRGQ0cXdFNGxpVmdaMm1BdlI3RGNRajE1MjFRSDEyeFpO?=
 =?utf-8?B?UlZaMVY0c1FDbjVZUHJkTFRYVEwxejN2YnhGYzE4OFhSUnFjQnlXSlFxQWZE?=
 =?utf-8?B?bU9yTHY5SHNiUytqQldnSVV6MnhPakU4TUQ3cjZmRjl0VmxSRU1wbWdCOVNX?=
 =?utf-8?B?VnNzK1VtSkt5S09DR1ZLUndCL2wwK2RvR2Q3UTBsT2w0MWJtSDFuTFRHeTFR?=
 =?utf-8?B?anF1MzZ1MjlpM3AxU0tMUUxYQk1ubGJsWWduSVdJdlhINGpRK1FNRkhqaERG?=
 =?utf-8?B?S1Y1T2hKcS9NK09VcSs2MUNBZXZlaXJLQWgvMDhJaW54a3MvUkE3d2t5REZM?=
 =?utf-8?B?a3ZhWFZBeFFVU3Rxd1ZMbVdrL2pFSVh4Y1FJU2NKY2ltNTMyRzhrSGhwU2VT?=
 =?utf-8?B?MDRDVWk3VFU4UjlBU1Z0Qkxyc2VHbmFUeGVKblRxT3lMQjFaUjBhTnFsMUlx?=
 =?utf-8?B?TUk0WHdDZmp0L0xzL0V6aUdRTW5aZFZrNml4ckdaSFcxbTFzRzgxZVhHQnBB?=
 =?utf-8?B?bDUyMnZwY1BTemkzemdqZTNWcDAzV2FNL1dXV2ZLL28vcW9kY0g2VCsvU2oz?=
 =?utf-8?B?UmxzSVhlZTZQWmRhQ1RsMytoUEh3SGpuSTFZY0dpUFN2OHU3ZGxKKzZXa0xQ?=
 =?utf-8?B?WmFLZmN4anNUeG80N2V2SEtyRStCQ1dHbFhSME5yWVpadlBuZDBDZVVqL29m?=
 =?utf-8?B?NGx5eU5hM2h0aStiUnJlengzRk9Fa3N5TUF4ZzkvWWtqMlh6VXBVWFJVQldR?=
 =?utf-8?B?RUVqejR0TTJ1SEVHajdoNEhaSXlTU1d0ZnV6QklTdVhKN2hueTltOWpHTDdj?=
 =?utf-8?B?WE1tWXQ3TWYzMjJUaDRvZ2hBeC9WNVF4ZHRGWXFGcEg1Z1I0dmk5NE02dkVO?=
 =?utf-8?B?VGVBbC9JbTcxKzBxU2VaY1FET1AzUGNTUnAyaHJxYUh3NW9zWGw1LzlOQ1U4?=
 =?utf-8?B?aXZtc1QyVW1ueGl2clphM05iSWdGenJzQ0FjQkRGTGJobjI2SWtuYUtQRUU0?=
 =?utf-8?B?QVJFbHFKUkpSblg2OUFIckp3bEQ1K1lZaE0rOExkd05yN0ZLWjFaT09LUzh4?=
 =?utf-8?B?UkwxRngvcVUwZTJnWUJHRnFOcHlEeXFmYnh2UkFZMktqekdjem5QQ1pqb0tD?=
 =?utf-8?B?ejU5M1ZycFR0a2IxSFlKaEdyZU11SzhLM2FsMWxSUm1xcDRkQnVja29ydWY4?=
 =?utf-8?B?Tlh3TFZKamdRWEY5RVcvV09xNlQ1TEdQaUJUNnlMdXk3Uyt4Tm5vZk1kTGZj?=
 =?utf-8?B?YmhaL1ZTdzZ5a1dCRHlBSXE0ZGZ2MjNJS25SVlhhTnFlcGdnNVRlbXNxVzZN?=
 =?utf-8?B?aUhISDZnMHNBKzdGRkhpOUYzUDBzK001SlBMcG5hU1RnYVFMck93aDVIcHB6?=
 =?utf-8?B?NUtoM3lSckZOOWJ2eGJ5dkFldHUzQU1qRk9NQ2Q5VXN2R200c1JrWG9ZdmRP?=
 =?utf-8?B?M0M0SmRTU1BhbGZEQ2lsUkluNnJVNndFNWNjRGdYK01pdkZ6TC8zUXdMNTlp?=
 =?utf-8?B?YUtKd2U5VThlN1JGSDNaTFFUWmpWOXRsZzNGVXdNL3FWcEszZUVDc1U4ekNR?=
 =?utf-8?B?OVA5ZUNUU29SWUVXQlVYTVlZQmFjT2VmcEYzaUNKTkJPZTc4VldlbThuN1ZL?=
 =?utf-8?B?T2hHanVGeFNhbW8yY2RoWGF3U2t5YnFYRUpRR2hEdDdEdEthMmtOU3lzSlB3?=
 =?utf-8?B?SmhXWDY4aWZ3cjVuQ1UwaE5RdXFxaWRVQTl1dlZWUWprSTZZekVFRmI1UUs4?=
 =?utf-8?B?aUI0NWtHQ3ZPZ3dRa05NSlVvSmhKZmtUeGc2dWY5cXQ2ZEkycDU2V3lWKzlD?=
 =?utf-8?B?WVA4L1R3WHVsWi82QWU3dzhHaEkwQ2dvN25HM0MycDhqQVJpOUhUb0p2WHRt?=
 =?utf-8?B?eDBNV2dsNG5RTHdtTlk4UUdTTmplc3MydzhmQnhjZkE1VEgvYUFiTjlnR0Zp?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca197947-ad1d-44cd-a8aa-08db86c5c75e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 13:00:21.4174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoU02n04d6I+ZZJEgS9vZDhMjeV3ul6j28jwlJp660AdvXQNXVN5L/9lWXveMD60FApY5mREAS6ERD6CG9xE3xFJwXSItMoh1afI7SoG1Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQo+IEZyb206IEFuZHkgU2hldmNo
ZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
Ny8xMF0gc3BpOiByenYybS1jc2k6IFN3aXRjaCB0byB1c2luZw0KPiB7cmVhZCx3cml0ZX1ze2Is
d30NCj4gDQo+IE9uIE1vbiwgSnVsIDE3LCAyMDIzIGF0IDE6MzbigK9QTSBGYWJyaXppbyBDYXN0
cm8NCj4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiBGcm9t
OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCAwNy8xMF0gc3BpOiByenYybS1jc2k6IFN3aXRjaCB0byB1c2luZw0KPiA+
ID4ge3JlYWQsd3JpdGV9c3tiLHd9DQo+ID4gPiBPbiBTYXQsIEp1bCAxNSwgMjAyMyBhdCAzOjA0
4oCvQU0gRmFicml6aW8gQ2FzdHJvDQo+ID4gPiA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMu
Y29tPiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiA+IEFjY29yZGluZyB0byB0aGUgaGFyZHdh
cmUgZG9jdW1lbnRhdGlvblsxXSwgdGhlIGFjY2VzcyBzaXplIGZvcg0KPiBib3RoDQo+ID4gPiB0
aGUNCj4gPiA+IENTSV9PRklGTyBhbmQgQ1NJX0lGSUZPIHJlZ2lzdGVycyBpcyAzMiBiaXRzLCBz
byB5b3UgbXVzdCB1c2UNCj4gd3JpdGVsKCkNCj4gPiA+IHJlc3AuIHJlYWRsKCkuICBTbyBwbGVh
c2UgY2hlY2sgd2l0aCB0aGUgaGFyZHdhcmUgcGVvcGxlIGZpcnN0Lg0KPiA+ID4NCj4gPiA+IFsx
XSBSWi9WMk0gVXNlcidzIE1hbnVhbCBIYXJkd2FyZSwgUmV2LiAxLjMwLg0KPiA+DQo+ID4gWW91
IGFyZSByaWdodCwgYWNjZXNzIGlzIDMyIGJpdHMgKGFuZCBhbHRob3VnaCB0aGlzIHBhdGNoIHdv
cmtzDQo+IGZpbmUsDQo+ID4gd2Ugc2hvdWxkIGF2b2lkIGFjY2Vzc2luZyB0aG9zZSByZWdzIGFu
eSBvdGhlciB3YXkpLiBOb3cgSSByZW1lbWJlcg0KPiA+IHdoeSBJIGRlY2lkZWQgdG8gZ28gZm9y
IHRoZSBiZXNwb2tlIGxvb3BzIGluIHRoZSBmaXJzdCBwbGFjZSwNCj4gd3JpdGVzbA0KPiA+IGFu
ZCByZWFkc2wgcHJvdmlkZSB0aGUgcmlnaHQgcmVnaXN0ZXIgYWNjZXNzLCBidXQgdGhlIHdyb25n
IHBvaW50ZXINCj4gPiBhcml0aG1ldGljIGZvciB0aGlzIHVzZSBjYXNlLg0KPiA+IEZvciB0aGlz
IHBhdGNoIEkgZW5kZWQgdXAgc2VsZWN0aW5nIHdyaXRlc3cvd3JpdGVzYi9yZWFkc3cvcmVhZHNi
IHRvDQo+ID4gZ2V0IHRoZSByaWdodCBwb2ludGVyIGFyaXRobWV0aWMsIGJ1dCB0aGUgcmVnaXN0
ZXIgYWNjZXNzIGlzIG5vdCBhcw0KPiA+IHBlciBtYW51YWwuDQo+ID4NCj4gPiBJIGNhbiBlaXRo
ZXIgZmFsbGJhY2sgdG8gdXNpbmcgdGhlIGJlc3Bva2UgbG9vcHMgKEkgY2FuIHN0aWxsDQo+ID4g
cmVtb3ZlIHRoZSB1bm5lY2Vzc2FyeSB1OCogYW5kIHUxNiogY2FzdGluZyA7LSkgKSwgb3IgSSBj
YW4gYWRkDQo+ID4gbmV3IEFQSXMgZm9yIHRoaXMgc29ydCBvZiBhY2Nlc3MgdG8gaW8uaCAoZS5n
LiB3cml0ZXNibCwgd3JpdGVzd2wsDQo+ID4gcmVhZHNibCwgcmVhZHN3bCwgaW4gb3JkZXIgdG8g
Z2V0IHRoZSBwb2ludGVyIGFyaXRobWV0aWMgcmlnaHQgZm9yDQo+ID4gdGhlIHR5cGUgb2YgYXJy
YXkgaGFuZGxlZCwgd2hpbGUga2VlcGluZyBtZW1vcnkgYWNjZXNzIGFzIGV4cGVjdGVkKS4NCj4g
Pg0KPiA+IFdoYXQgYXJlIHlvdXIgdGhvdWdodHMgb24gdGhhdD8NCj4gDQo+IEkgdGhpbmsgdGhh
dCB5b3UgbmVlZCB0byB1c2UgcmVhZHNsKCkgLyB3cml0ZXNsKCkgb24gdGhlIGN1c3RvbSBidWZm
ZXINCj4gd2l0aCBzb21ldGhpbmcgbGlrZQ0KPiANCj4gKl9zcGFyc2UoKSAvICpfY29uZGVuY2Uo
KSBBUElzIGFkZGVkIChwZXJoYXBzIGxvY2FsbHkgdG8gdGhpcyBkcml2ZXIpDQo+IGFzIHRoZXkg
bWF5IGJlIHJldXNlZCBieSBvdGhlcnMgaW4gdGhlIGZ1dHVyZS4NCj4gSGF2aW5nIGFsbCBmbGF2
b3VycyBvZiByZWFkKigpL3dyaXRlKigpIGRvZXMgbm90IHNjYWxlIGluIG15IG9waW5pb24uDQoN
Ck1heWJlIGEgImdlbmVyaWMiIG1hY3JvIHRoZW4gKG9uZSBmb3IgcmVhZGluZyBhbmQgb25lIGZv
ciB3cml0aW5nKT8NClNvIHRoYXQgd2UgY2FuIHBhc3MgdGhlIGRhdGEgdHlwZSAodG8gZ2V0IHRo
ZSBwb2ludGVyIGFyaXRobWV0aWMNCnJpZ2h0KSBhbmQgdGhlIGZ1bmN0aW9uIG5hbWUgdG8gdXNl
IGZvciB0aGUgcmVhZC93cml0ZSBvcGVyYXRpb25zDQoodG8gZ2V0IHRoZSByZWdpc3RlciBvcGVy
YXRpb25zIHJpZ2h0KT8NCk1heWJlIHRoYXQgd291bGQgc2NhbGUgYW5kIGNhdGVyIGZvciBtb3N0
IG5lZWRzIChpbmNsdWRpbmcgdGhlIG9uZQ0KZnJvbSB0aGlzIHBhdGNoKT8NCg0KQ2hlZXJzLA0K
RmFiDQoNCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28N
Cg==
