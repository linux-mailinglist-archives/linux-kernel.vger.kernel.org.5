Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B867C611C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376564AbjJKXcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKXcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:32:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFBFA9;
        Wed, 11 Oct 2023 16:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/hY9b2oVjQka07cw626Hyy5sdsGDvTmDrWUwzbNOS1+4c4SHuvUBzKgQrPy6O84SKTRWmOAmvL0httsmB2ZpVnOSoVRRL+zCxVoYiuqyFPdEgQjRdWKoHMY0Fkt/wvW6j8jsBhU/CmOLUW8j/QN+DK8MiwllWXFoHJ+gBGVQ3ao6v298HPMU05k2lgd1Hu+nlIG3OHcH4TjcyPz4zXcAO1OqSBvjpz6TSazCVlLJYArHEZl2GpX8Nkh9jxl90clrNygTab1/jmGZD2rm8xCy0AP/q6/KgxPgrl6+JtvYo60zH7O3qT0Cy/moxnERQQ7ZWq9PA0fVYiYZW+Jn1chUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O56fEjaFxQvCFMIoTUTKqZ5/zWT4uTQIhACz3AykrE=;
 b=N9TA52GPVuLR5b5tXjyCp2tRtujsSkWwdpor4MDgUAa+iZxfU9v+gxtP1rrGnAJ9JRLCtqKWaKuqYeQb3ZyXFmhckfjRzfvi+kPaQzDHJ6dFj9TUdzsIW2TDVO7kpuhEzypBONCGF30z4qleuenSgfc8OheMGiGQR/h17TMjVWEhBohVVsfDJ82sDrL00Onk07S9N6xQ1nNYGb22EdyXXTfADvhAJsXD/6kUdvc0xAPghLIRRUurLT3bofcX++/1Ubk2fABPvEljArVSrBBf9LNu0ZtWgunDD7YHQfDCJchieqeuhiee31ucIP5Ypno32/1upAkUtiISBVDuYYtgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O56fEjaFxQvCFMIoTUTKqZ5/zWT4uTQIhACz3AykrE=;
 b=tDQFVblVGueQAkpd2anGzAdrHQF8lmBOoawrWy87aDLg9DFsQQi9Yh+MR0sWsGhg8v8CK6wc/6TIyziE4aaG29oulRBkGCUGH/hHyYVxafWbZqvPtgX8mwGwWvLNzeGjv0EVonhZ3qavua3dBWkxrvyHVQ7/xBgZRGrqt0rbL2E=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9588.eurprd04.prod.outlook.com (2603:10a6:10:31d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 23:32:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 23:32:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 0/2] mailbox: imx: support new tx doorbell
Thread-Topic: [PATCH 0/2] mailbox: imx: support new tx doorbell
Thread-Index: AQHZ6WP1nuoyHESAQkuJUjIiPFvpW7BFY0hA
Date:   Wed, 11 Oct 2023 23:32:07 +0000
Message-ID: <DU0PR04MB94173364EA135E0B09176E6A88CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
In-Reply-To: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9588:EE_
x-ms-office365-filtering-correlation-id: 89a367ef-f4b4-4f42-c703-08dbcab24895
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0G5ZGLsnUla3H0wAfQ8tx4NKCNm5Ifj3O8w/nVJSSYaRY+VSgqYZio7oH2f2v4f+M1RbQqy32UXOBqSEAplvAyl2waFKZtx0LROXZs/Gy7UUGejYgOLYcA4XRSCDIUjfR8/gddHPKc2+ha8dsFyHe8zi31cXfhvlwe1jIblmknbn/g97A6EbJbV0HaYcntybM6rYAVaei4o1RABD+7VYkFiTHFlMz5nKI7TPO+NQDPz8kHzrvKiLMsA1FJU2YkQpAYdZLv10h7AeFeC6HTzSjkVoy82e7Kcrbunx56V7VTFyD4JVzr/lZnkiNW5wZJPZY6u3Nwj17AWVKvzOZMCqHFG1xjAIDfF3J8ENGSCZFqMdxFVP0ME8ZUPtaXIDD2OUkO40B1VIyno8SrV7TopuXo7pumk5QfxfpI49wGewwM1q4wDr6Qs+zuVPnjGxObm8rUqRTyg+FBpKfcCIjmUXZvEkrHqApzN8USCjKUGeIPwdiP9HajX5LYxDE4zbIdVvKV4/HsUAEUAGhCfMs+KniunjdthAsyRqmq7JPuxEDp6qiQahD6E8ugM1h3PHJKqhRvBGG25XNPQ+hHAcOqvEwJp73FcgkpA45bI1ks5fgOoVsWc8v+ARDBicnlbWiF1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(186009)(1800799009)(451199024)(71200400001)(6506007)(9686003)(33656002)(55016003)(38070700005)(86362001)(38100700002)(122000001)(2906002)(83380400001)(15650500001)(7416002)(44832011)(921005)(7696005)(508600001)(26005)(8676002)(8936002)(4326008)(6636002)(110136005)(52536014)(316002)(54906003)(66556008)(66946007)(66476007)(5660300002)(76116006)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1IxU2pwd21UU2VaMTRRa0szR3A2czFpS0VYQURRN3I0dnhpL1prRXRpYmtL?=
 =?utf-8?B?d0NmWXEzQjh2dmZ5ZkU2bVI3SERiaTlUaWVRY0RXQ3ZieTJCeXZBbWE3c3Fp?=
 =?utf-8?B?OTJTajVrdUZ3eHc0b1RvZ0tzSVcxZGhKa3ZZWEJTN2gvenJkUm1mNWF3emsz?=
 =?utf-8?B?TjR0cXpPdDFZU0l3QlBWTlIvVmkxUEJZT2p3cWNKc2J4ZHMxZFlKamVoVEpB?=
 =?utf-8?B?ZGZFMlYzM1dRSGs3bXBvU2p5RGNJRlplaWd5eTFVa3NlZ1R3QTJLT1ZxOUlR?=
 =?utf-8?B?T29vOTJWbFVYZlZKQm9DeFFXOWRYcXRzNFZBaUFadlhOZnFNNnpGdFg0aE1q?=
 =?utf-8?B?dVBYbUgwQllqZUJCL0pkVFYxV3MxZHZMRy9uVFBPNFlQeE9PWURZS2FKbjVR?=
 =?utf-8?B?UDZZQ2hQdDRNbWhlZENtelg5ekxxd3NtZGs1dmtlWVUrV3ZVazZIaTR3Qkpw?=
 =?utf-8?B?MXR5azNlYy9aN0djOGtRc21JME5GWmg3NkRlc3FQUFNBSG5FYk9NbWpTTnd1?=
 =?utf-8?B?c09reDR6M0VTMXI0VUgzWHZPY0JlVTljd0EzazJFRlpVMlRCNkI3aXhFalc3?=
 =?utf-8?B?WkZXSHhZVjJQbDdrNHQwRklUN0dnWGZ3alRHdU1SaEs2VHJZTGQwbU14WjZN?=
 =?utf-8?B?dlljVjBjK3l2Wmdhd1BZNG9McXRkWDVrNlhLSHRjQ2NRbEVJMnU1TFh6S1VC?=
 =?utf-8?B?ZzMrelE0eUphdHpuQzltYXdpZ0hEMXdhbFdiRGx1R3FtNDJiRVlnL2ZpNkQy?=
 =?utf-8?B?OHpYRnpMc1M3cm5BZ1VodGcrVVNXRlhycmFCSzUwcEhrdmFiSW40aVlhS3U1?=
 =?utf-8?B?ZmlVemFvOW80T2poRjluUnNOVjlqU0FtYnZTcTc4S0pRMCtjeHExQVJPcGVi?=
 =?utf-8?B?Q25WN3BRa2tTYXJlY3MyTklwWXdHN1dObHM0T1Q1V051cG5aZTZPV1VJSGpJ?=
 =?utf-8?B?UTBZVGhueFMwL1hwUTNsWVhQd3B1L043UUpjMy91Ky9RWnVCa254bGhERlpS?=
 =?utf-8?B?c3RjenNZTGVJSlhwZ3FsbWM3OGM0YjN6bEtucEVaWXNVa0VqTm0zOU9xU1Vj?=
 =?utf-8?B?S3R2UU0wcnBkbE12Njk2Zm9RTzJ3Y004b1VtNHdLL0gxTmtxOExmZjFSRHpu?=
 =?utf-8?B?N2pNZGl0NHhPdHhtd2VJTmFVUE5MMDZHSWk5a29XQmRMMFh6cElzRW0wSU1X?=
 =?utf-8?B?K3dJK1RhR2lraGxPUTVhQTcxRk5yTzlKRzhiaDVzbXdubHU5QTF6S3hUczV3?=
 =?utf-8?B?WDh0MlBsQzhNTlRaVCtPUFV3WDVLR2doOUZ3MXRLVDRsdFJiWWZTRXdkL0d1?=
 =?utf-8?B?ZWtuNk5rYzNqeEU2cHJnWlRURlVPdFBxY01HcjQyRGF0Y3YrSFoxWThnNGlh?=
 =?utf-8?B?ZjU5K1plWkEzNnBwZ094bDR1WG5Gb3JWL2JzQlNENGZtNGRRMWlWRjZZZHpp?=
 =?utf-8?B?N2JDQzNobnJ4cHJFcENqd05GQjNXdHJOWUVTT2RMK3Jmelk4ajJudHJCNXla?=
 =?utf-8?B?UzByQ0k1VlhuY1RFMnVNZkJaZEVYcDRZdEtYSDc4Rk5BMXBKeDB1dHNnNVVN?=
 =?utf-8?B?MnlPLzFHOTREZkdFanJWU0M1L3g4U3hNVGRDc1lRY0tOeWtsOEJBL1RvekNl?=
 =?utf-8?B?WTZtYjlNd1hMb3ZGSFBzZlpteS96ZXBNcGZJUlJZWFo3RHAveEh3M1NYamNO?=
 =?utf-8?B?Tk5QS205L3Nma09QRnFSRStLeWVXVHp1aDFGYmZvMCtTaVJUb2MyQjJidW9r?=
 =?utf-8?B?VGFaY3oyanh4Wk9VWTN4OGJ4TWIza0RXSktmWElUVjlqVm1zWHNXVWpKT3Iy?=
 =?utf-8?B?T1lzUHRXNWNHNXRIWnBBWEl6K0xXaTF0UUg5cTl4TmxQdHY5MmQ0amFiamlw?=
 =?utf-8?B?cVpZSWNWbVBwK0RzVlI5ODd2eUo5bFNzRkMzOUFiZnMrOTYvZ21LZ2pJUjUx?=
 =?utf-8?B?Qi8yZlp1VVhRSC93S3JRN1Y2bndkTDdWRFhZMGZKdGZPYUtDalR0c0hLSlM0?=
 =?utf-8?B?czJ5ZFp4S25uZCs4RVB0OHJnQXoyY0xhMWNJOEw0TkNyeU9Sb0ZvSEFqTWVP?=
 =?utf-8?B?VitYWDNSUGFQcVhqWm5rV04wa1lZOXMrNnluaUZaN3VRUWM5UWU2VXErTmdU?=
 =?utf-8?Q?2hc4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a367ef-f4b4-4f42-c703-08dbcab24895
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 23:32:07.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gV99TWv3hvlWksIW+x4+ewlshM/hJ32s7euFZCiO7m+bTuYClVkXJE82DcgNEMEah1d7xKb3oOWqLOedjHvgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9588
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCj4gU3ViamVjdDogW1BBVENIIDAvMl0gbWFpbGJveDogaW14OiBzdXBwb3J0
IG5ldyB0eCBkb29yYmVsbA0KDQpXb3VsZCB5b3UgcGljayB1cCB0aGlzIHBhdGNoc2V0PyBPciBh
bnkgY29tbWVudHM/DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFRoZSBuZXcgYWRkZWQgY2hh
bm5lbCB0eXBlIGlzIGZvciBpLk1YOTUgU0NNSSBtYWlsYm94IHVzYWdlLg0KPiANCj4gaS5NWDk1
IHVzaW5nIFRYIGRvb3JiZWxsIGFuZCBSWCBkb29yYmVsbCBmb3IgdGhlIFNDTUkgbWFpbGJveCB0
cmFuc3BvcnQuDQo+IEZvciBUWCBkb29yYmVsbCwgd2UgcmVsaWVzIG9uIHNvZnR3YXJlIHJlcGx5
IGZyb20gdGhlIG90aGVyIHNpZGUgaW4gU0NNSSBkcml2ZXINCj4gc2lkZSB1c2luZyBtYm94X2Ns
aWVudF90eGRvbmUgdG8gZHJpdmUgdGhlIHR4IHRpY2suDQo+IA0KPiBCdXQgdGhlIGN1cnJlbnQg
TVUgdHggZG9vcmJlbGwgdXNpbmcgdGFza2xldCB0byBlbXVsYXRlIGhhcmR3YXJlIEFDSyBmcm9t
DQo+IG1haWxib3ggZHJpdmVyIHNpZGUsIHNvIGFkZCBhIG5ldyBkb29yYmVsbCB0eXBlIHRvIHN1
cHBvcnQgaS5NWDk1IFNDTUkNCj4gbWFpbGJveCB0cmFuc3BvcnQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+IFBlbmcgRmFuICgyKToN
Cj4gICAgICAgZHQtYmluZGluZ3M6IG1haWxib3g6IGZzbCxtdTogYWRkIG5ldyB0eCBkb29yYmVs
bCBjaGFubmVsDQo+ICAgICAgIG1haWxib3g6IGlteDogc3VwcG9ydCBjaGFubmVsIHR5cGUgdHgg
ZG9vcmJlbGwgdjINCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2ZzbCxt
dS55YW1sICAgICAgICB8ICA1ICsrLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5j
ICAgICAgICAgICAgICAgICAgICAgIHwgMzIgKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4g
YmFzZS1jb21taXQ6IGUxNDMwMTZiNTZlY2IwZmNkYTViYjYwMjZiMGEyNWZlNTUyNzRmNTYNCj4g
Y2hhbmdlLWlkOiAyMDIzMDkxNi1pbXg5NS1tYm94LTg4NDM3YzUxY2U1NA0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiAtLQ0KPiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0K
