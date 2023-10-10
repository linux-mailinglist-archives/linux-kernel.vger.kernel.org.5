Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA227BF060
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379361AbjJJBf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379330AbjJJBf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:35:28 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3C9F;
        Mon,  9 Oct 2023 18:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y80kMs4nBx/T4FJUfgsMVday1wT/PwXwuOx9AVlOcrSXLKsAaKNFX3q32Tn5Wvr7hBSxzVviiD/JRuKw2seY6y0OfEX+C7cwQczjC7mXl37IlDVXBr9bbQlChsFy5hA9tvxl7uNqtASTyNvFFePPZ9HgeeWbUKjkHI1cSCcuvkYhRxT3rhz9Y7ogsyl28DyiH04qUrCxPppeiGsVlLVojhp5fqmjc8Daaq1pCnY/jqIozVhEDx+WILLLu4Yp1tgSOm4kw3Dvrm2iUmaWZn+ndwvJqXCAHSJ4GPcZWBKBU072LHCmSWFf01jKqP03Aznkw52bT6V0+rvYnw3wwpYP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3D3NCyqHbv2USEGJ6Thm8rDJ5O1Ph+btQp5Iah/Trs=;
 b=njFHkRMGBL8NBWivADPnF8xm5ObKeUlAHnGZDlVolfXFgF9mhoEi2anYGrni6NEuKfTIDCrOb0apLV/GnEDwrAoysovFd1raRzI4KN1QVdloNBBbA1xbesk5wDE2LkiWC2BX5uMyFW5FMSjL6h02N4L6FSBX43FsaxT/QQDaGn2l0V+cuhJf6EfMnjZJglFvBa2T4U+aRdWYzzowk2BbkObIGdjlj5F1b/R1oue0nW+WPbqB6rCHrKKghdBg9JcEzFW2Aa2j9TNki9q+Ed+kf/IahMs84zNJVU2gIgGsiTnNPWO1g55zyT+2YkG3q5S79vvoolqXeboFRWQ71RwX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3D3NCyqHbv2USEGJ6Thm8rDJ5O1Ph+btQp5Iah/Trs=;
 b=crGN2ilPA8CS4CQ3CzZGNxMi7OfYtto6MiqnkbE6OQMUMRG2OJ1l7m06JrhTuk+tK3pPziM+N+NNSavE2D6sQM+39rRt2Ek/GQkcWFotSbIWH2vL4EbICx+89vTQVVFmpLnvo2mWHlk4j62Px+4z8lE2GLTKsyFDPX387sVjXPY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB8031.eurprd04.prod.outlook.com (2603:10a6:102:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 01:35:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 01:35:22 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v5 0/7] gpio: update i.MX93/8ULP and support i.MX95
Thread-Topic: [PATCH v5 0/7] gpio: update i.MX93/8ULP and support i.MX95
Thread-Index: AQHZ9ECGP6nxneiqykyWbdn3eL71OLBCSz/w
Date:   Tue, 10 Oct 2023 01:35:22 +0000
Message-ID: <DU0PR04MB94176C8175E0473AD181553988CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
In-Reply-To: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB8031:EE_
x-ms-office365-filtering-correlation-id: f767b97f-cc43-4906-f66b-08dbc9312b93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVKt3A4qR5qYpOJSVgPjwA0lDQ8n//7dbHUfOC9tFaqwsO2b5/t+xeZ+V3pdvFRuo7tq3nN7x0otl6oqmwPxfXTsD6aC273P5KqLoYd8Xd+0uIVmq4XX00pgNDo+oUQSvLJE6KyAoCfI/ImCAtBB2zqRzcF/JrtXtKg0CHPKKK84CadrjGdhbm0AAAfTGojAfnWWqIWsczRwKZ3s6Sw3Qaezx2ogtvWXO9++wn/0Mjrrn2O6yR7XhkxJ/4QxDkrI249GqxSNOG+BabPHnrUZuqOCh35LdbZFPaGzrtUfa1SDqi/gRce78PV2nHkIXEkwMax0vwp/c9hyJxAhcxPTdQaavdO1E4zrpZ5WwTScl8hNRviPJlcJnNUvwUCWtl3pJaQkIBYvJ6XBlkSmoa+7T8zWNvMBEDVKj+wnDZz151z0aNeNhur2Cxd+bAEDqoh5aGChS32rBNhRgZNRsN7X+d43GFtEXD0TiAamFbw00ARESlPnMONwdF+EfvtDnSI/FCr+5ZKyh7uIXv3AgJsrPYgWvTibBQUBDpb5pNhtL3V5ZOe9+LGEzdQKdhIdH1PdtW1VhJWsnxt4SOQtHWMbLoPOmec+xYDbIHEIgk5ymh8PJaUwLTOQF/PPMuOUDulh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(52536014)(4326008)(8676002)(5660300002)(8936002)(41300700001)(44832011)(66946007)(66446008)(316002)(54906003)(76116006)(64756008)(66556008)(66476007)(15650500001)(110136005)(2906002)(7416002)(83380400001)(6506007)(7696005)(966005)(26005)(9686003)(122000001)(38100700002)(38070700005)(921005)(33656002)(86362001)(55016003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzU2S2hCaDhaeVpLU2grL2JvdXEwWEsvamp1SFk5OUJ2dzFNMDhJS0I1OXF5?=
 =?utf-8?B?WWM3Sytidi85R01oa0t4UXV1WnFRWXdLYjBnRjlwdlNWdXJHU2ZoVTJic2dv?=
 =?utf-8?B?ZTNGTmQ4cEpHU244aFg5NGMrNllGN25UeE9EY2NqQ2FoOFRsb1cySWg3SkJh?=
 =?utf-8?B?ZGJpWk5KOFg0VjZ2ekxIRDMrT2k4Znc0NUpuOXRwdmwyVTdsOGcrdlN1T1JP?=
 =?utf-8?B?TnVCdTdyb2hBZTV6WG1Ma0R2NlBaODJrVnpXUVN0bE1LZGxLbVJFTllXeDFB?=
 =?utf-8?B?QjV5VWZIVnRNZzZidXBlaTFiVlYxOTFETTF2bXBWRTBSNmoydzkwWEVYcWpG?=
 =?utf-8?B?QXR4cDlGOGl6TkxuZG9QejBDV2xhMEliVk5mbmhTOVNaL1lkQm9qQ1IwVnQ1?=
 =?utf-8?B?amdFVko4TmVEUWgvOGhBNUxidkZSWXE4L2JOenF5V1h2bXNYMENpZzFqeFNr?=
 =?utf-8?B?S3hDczNkZTBGTEJ2L2RvK0Q2R1NCbVN4MGRFNlA0M2xaU1BwNk1mazNsUjNM?=
 =?utf-8?B?TmU0dmc4Q0hGd0NxYUhNNFFVQzExdXVkNGFKZ3FHb0lWODVtc2FncHd4WVlM?=
 =?utf-8?B?V3ByQ0FxQWFLVU0xTUU0bkRyZXZwekVNa2dpSjlYalVSODNLM3hvWTI3dEM0?=
 =?utf-8?B?Yzhvb1FoMUR6UHZ4QkZOZENNSGFqcHMzNTlPOURiOWdGc0wzV1hrZ3F2bjVD?=
 =?utf-8?B?bDY2MzJ2UFVvaXE2V3c3U3hRV3VML2lMRkdvZThHK0pyN1Fyc3ZpOVkvVUt4?=
 =?utf-8?B?QUZOK21rcWEwMzErZTJMbHVDcnNCcEEzUE0ySm9sWityTXVsU1ZxVXdWVEVI?=
 =?utf-8?B?SzRzTkVjbHFVMVQ0dWQxdE8wOEh1bk5HS09qOXV4RWhxaEJCT1I1cVRHZlhU?=
 =?utf-8?B?R3YzNUhKRHpnSDBVaGJ4WEZmVDBLV0tPMjlLVlFLb29DbDRWaTl4ajlZTUNC?=
 =?utf-8?B?NjRpQkNoT2w1MTlwNUVyTEdKRlkzN3FaQ1d4cWkyTFl4cXJRdVdIWlBuTHNY?=
 =?utf-8?B?SVN2VDNtVnZhb2ZFeGpjRWVodmxReE5JNEk3N25LWm40Sy8zaVZSc2p1OUov?=
 =?utf-8?B?N09MN3N2ZWUzZENncm9YbGNvL2tmMFRueFZoN2VKVG4yeG5mMnhyaHdPWVVq?=
 =?utf-8?B?SG9vUDVKVG5oS21rUGk1MzFhU3JZeUZTVXIvWTV4VEpHV2FNZ3dMTVFQVHZM?=
 =?utf-8?B?RkxyR1pVc0JOdUYyakgwTXFsMUhhZzRHY01UdHFnWElUbHJCWWl0RnRXRCtt?=
 =?utf-8?B?R2hiKy90NGZwcFlqd0twTWZSMzV6cXo2aFFKem1NMjVFSit0UlpLVG9QS1JW?=
 =?utf-8?B?V0E3TzRlRERVNDVTdXhpelFHNWE1UkxkeWtuUnZrTXA3RHZNK010TTFxeDFj?=
 =?utf-8?B?YVhOQnVDWWlyTjFITWxLQWQ3TnFLUTJwdlQ3dlJSVGFpTXFEc0JhVExRU3Y2?=
 =?utf-8?B?QTNFOTNMYkFwS2NnNmFETHdhbFNlaXFTMExxYUIzWmMrTU02MElKYjhrQXYz?=
 =?utf-8?B?Q0RtT3JXNHJuRHVrRWVsZi8xTm5kSzhJYTdVMVZ4WkVUaW8rdlFjV2d0WTZD?=
 =?utf-8?B?bnZHTm5RWitsWUpGR3ZtWWJWakJFT1FubkpPeXJTcTE4NUYrUlloaXVkYnFV?=
 =?utf-8?B?UUdVR0dXMFZIK2xSM1F1RitqK3phMjFZMlgzbDM5bUVxMzgwUTkwQkJpNDE0?=
 =?utf-8?B?Y3hGUmROQndvMUFzUHRmODY5RVU0Sy9lazNCaHRWcitQb1VEMmdvYnhUR21u?=
 =?utf-8?B?R0xCUmorWitZQWJQSkdiNEs2anNYVTRSV1pjd3lzaWhVZXZ6WC84eGVvVHV1?=
 =?utf-8?B?VjhVOWhiYVlmREtFZmZLblpXT1N1SHkwOGIrUCthaTZ3NElyaGRrM0FDZXR6?=
 =?utf-8?B?Z2lkVlBCNjB4cjBwaGFCWUVLSUxVRjBUZFFhWU1LRTVCUlNpemhIUDl5UXZs?=
 =?utf-8?B?UW9hMjJLMkwrN2FDd3RKbXRtTVg0RW1yUjh1UkYycDFRN2c1THJZdStUMHQ4?=
 =?utf-8?B?WkdlaUpvWlFVYk92Tm9GT1E0RDhSS09FNkxncWRpTXhPUlZ5cFhnc2krU2du?=
 =?utf-8?B?YjlwbUZRS1A4ZDByUzJoK0FnK3ZpTDcrbGdURmViNUw0ZmRET1BCKzZTZmJQ?=
 =?utf-8?Q?inzs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f767b97f-cc43-4906-f66b-08dbc9312b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 01:35:22.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sl8MCYewTDMyJxaBCg4oCabxIPCgFQmMdO+JysnEbDnxH+a7jfDnhxC0zyTKLq/2CVDu6Czu5w5pUJNdTwk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCj4gU3ViamVjdDogW1BBVENIIHY1IDAvN10gZ3BpbzogdXBkYXRlIGkuTVg5
My84VUxQIGFuZCBzdXBwb3J0IGkuTVg5NQ0KDQoNCkdQSU8gbWFpbnRhaW5lcnMgaGFzIHBpY2tl
ZCB1cCBwYXRjaCAxLTUsIHdvdWxkIHlvdSBwaWNrIHBhdGNoIDYsNz8NCg0KVGhhbmtzLA0KUGVu
Zy4NCj4gDQo+IEZyb20gaGFyZHdhcmUgcGVyc3BlY3RpdmU6DQo+IC0gaS5NWDhVTFAvOTMgR1BJ
TyBzdXBwb3J0cyB0d28gaW50ZXJydXB0cywgMXN0IGZvciBUcnVzdHpvbmUgbm9uLXNlY3VyZSBp
cnEsDQo+ICAgMm5kIGZvciBUcnVzdHpvbmUgc2VjdXJlIGlycS4NCj4gLSBpLk1YOFVMUC85MyBv
bmx5IGhhcyBvbmUgcmVnaXN0ZXIgYmFzZQ0KPiANCj4gVGhlIGN1cnJlbnQgbGludXggZ3Bpby12
ZjYxMC5jIGNvdWxkIHdvcmsgd2l0aCBpLk1YOFVMUC9pLk1YOTMsIGl0IGlzDQo+IGJlY2F1c2Ug
c29tZSB0cmljayBkaWQgaW4gZGV2aWNlIHRyZWUgbm9kZSB3aXRoIG9mZnNldCBhZGRlZCB0byBi
YXNlOg0KPiAgIHJlZyA9IDwweDJkMDEwMDgwIDB4MTAwMD4sIDwweDJkMDEwMDQwIDB4NDA+OyBC
dXQgYWN0dWFsbHkgdGhlIHJlZ2lzdGVyDQo+IGJhc2Ugc2hvdWxkIGJlIDB4MmQwMTAwMDAuDQo+
IA0KPiBTbyBpLk1YOFVMUC85MyBpcyBub3QgSFcgY29tcGF0aWJsZSB3aXRoIGkuTVg3VUxQLg0K
PiANCj4gaS5NWDkzIEdQSU8gaXMgZGlyZWN0bHkgZGVyaXZlZCBmcm9tIGkuTVg4VUxQLCBzbyBt
YWtlIGkuTVg5MyBjb21wYXRpYmxlDQo+IHdpdGggaS5NWDhVTFAuIGkuTVg5NSBHUElPIGlzIHNh
bWUgYXMgaS5NWDkzLCBzbyBhbHNvIGNvbXBhdGlibGUgd2l0aA0KPiBpLk1YOFVMUA0KPiANCj4g
VGhlcmUgbWF5YmUgZHRic19jaGVjayBmYWlsdXJlIGlmIG9ubHkgdGVzdCB0aGUgMXN0IHBhdGNo
LiBBZnRlciB0aGUgcGF0Y2hzZXQNCj4gYXBwbGllZCwgbm8gZmFpbHVyZS4NCj4gDQo+IFRvIG1h
a2UgYXZvaWQgYnJlYWsgb2xkIGJpbmRpbmdzIGZyb20gd29yaywgdXBkYXRlIHRoZSBkcml2ZXIg
dG8gc3VwcG9ydA0KPiBib3RoIG9sZC9uZXcgYmluZGluZ3MuDQo+IA0KPiAtLS0NCj4gQ2hhbmdl
cyBpbiB2NToNCj4gLSBBZGQgUi1iIGZvciBwYXRjaCAxLCAyDQo+IC0gU2ltcGxpZnkgY29kZSBh
IGJpdCBtb3JlIGluIHBhdGNoIDQgcFBlciBNYXJjbydzIGNvbW1lbnRzDQo+IC0gVXBkYXRlIHBh
dGNoIDUgdG8gb25seSBkcm9wIHBvcnQtPnNkYXRhIGNoZWNrLCBzaW5jZSBwYXRjaCA0IGlzIGNo
YW5nZWQuDQo+IC0gTGluayB0byB2NDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDky
Ni12ZjYxMC1ncGlvLXY0LTAtDQo+IGI1N2I3ZjZlODM2OEBueHAuY29tDQo+IA0KPiBDaGFuZ2Vz
IGluIHY0Og0KPiAgQ2hhbmdlIHRvIG1pbkl0ZW1zIGZvciBhbGxPZjogZWxzZTogaW50ZXJydXB0
cyAgVXBkYXRlIGNvbW1pdCBsb2cgZm9yIHBhdGNoDQo+IDQvNiAgRm9sbG93IE1hcmNvJ3MgY29t
bWVudHMgZm9yIHBhdGNoIDQvNiAgQWRkIGEgbmV3IHBhdGNoIDUvNiBQZXINCj4gTWFyY28ncyBj
b21tZW50cy4NCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IFVwZGF0ZSBwYXRjaCB2MiAyLzYNCj4g
VXBkYXRlIGNvbW1pdCBsb2cgaW4gcGF0Y2ggdjIgNS82DQo+IEFkZCBBLWIgZnJvbSBEVCBtYWlu
dGFpbmVyIGZvciBwYXRjaCB2MiAxLzYsIDMvNg0KPiAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyMzA5MTYtdmY2MTAtZ3Bpby12Mi0wLQ0KPiA0MDgyM2RhNzg4ZDdA
bnhwLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBVcGRhdGUgYmluZGluZ3Mgd2l0aCBk
ZXNjcmliZSBpdGVtcywgYWRkIG9uZSByZWcgYmFzZSBmb3IgaS5NWDhVTFAvOTMNCj4gLSBVcGRh
dGUgZHJpdmVyIHRvIHN1cHBvcnQgb25lIHJlZyBiYXNlLCBzdXBwb3J0IGJvdGggbmV3L29sZCBi
aW5kaW5ncw0KPiAtIEFkZCBhIG5ldyBwYXRjaCAxIHRvIHVwZGF0ZSBncGlvLXJhbmdlcyBmb3Vu
ZCBpbiBkdGJzX2NoZWNrDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDIzMDkxNC12ZjYxMC1ncGlvLXYxLTAtDQo+IDNlZDQxODE4MmE2YUBueHAuY29tDQo+IA0K
PiAtLS0NCj4gUGVuZyBGYW4gKDcpOg0KPiAgICAgICBkdC1iaW5kaW5nczogZ3BpbzogdmY2MTA6
IHVwZGF0ZSBncGlvLXJhbmdlcw0KPiAgICAgICBkdC1iaW5kaW5nczogZ3BpbzogdmY2MTA6IGNv
cnJlY3QgaS5NWDhVTFAgYW5kIGkuTVg5Mw0KPiAgICAgICBkdC1iaW5kaW5nczogZ3BpbzogdmY2
MTA6IGFkZCBpLk1YOTUgY29tcGF0aWJsZQ0KPiAgICAgICBncGlvOiB2ZjYxMDogYWRkIGkuTVg4
VUxQIG9mX2RldmljZV9pZCBlbnRyeQ0KPiAgICAgICBncGlvOiB2ZjYxMDogc2ltcGxpZnkgY29k
ZSBieSBkcm9wcGluZyBkYXRhIGNoZWNrDQo+ICAgICAgIGFybTY0OiBkdHM6IGlteDh1bHA6IHVw
ZGF0ZSBncGlvIG5vZGUNCj4gICAgICAgYXJtNjQ6IGR0czogaW14OTM6IHVwZGF0ZSBncGlvIG5v
ZGUNCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2dwaW8tdmY2MTAueWFtbCAg
ICAgICB8IDQwICsrKysrKysrKysrKystLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDh1bHAuZHRzaSAgICAgICAgIHwgMjEgKysrKystLS0tDQo+ICBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpICAgICAgICAgICB8IDI4ICsrKysrKystLS0tLQ0K
PiAgZHJpdmVycy9ncGlvL2dwaW8tdmY2MTAuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCA1
MyArKysrKysrKysrKysrKysrKystLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNlcnRp
b25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBlMTQzMDE2YjU2
ZWNiMGZjZGE1YmI2MDI2YjBhMjVmZTU1Mjc0ZjU2DQo+IGNoYW5nZS1pZDogMjAyMzA5MTQtdmY2
MTAtZ3Bpby00NmVkYWNkMmI1MTMNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQoNCg==
