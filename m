Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F387A3595
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjIQMqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjIQMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 08:46:37 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31621D9;
        Sun, 17 Sep 2023 05:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqNsA2T9wBTjAKVvDqS8Cd7N81WBLbaKObFMzcvtDDcA3t5uDg+Xj6tBXmhc2FM1Iu8wa4YX3L+wrOKmTY5ifdn8crLWcyjR45xe6djXdDVYyBuUguu22ItX6u3qBGUZC5Nst3R9eRhNuM4ncvfOFKNQQjdbxDQeMe3nZ8Fn6UgSIw2Nqsd1tfXBPtdpbND0B0gzbDCtCsHD2YQC/xk8pS8aOwbNghP+qgspmDBQrl4jLNdWrtP8cMb+sJ2URsEcNMg2k+U1Lco52gfKJagUzlWDmR+9l5p3oz1Smk9RxlZT3N+XrZGUqEEpmDUvAVuALp9cBje6XB6GnwzBrBvEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL1xzSsR54D1xmUdmvRa5mHRmuaiW+INh2OmUqreBPg=;
 b=kU59101weA8HL/o4l3lY4S1hm+vETMmKUvKFrUK0RbfIa99JX/v+nNytOnOW7uHn4FzB04kcrw35EwiM4OnRHekXKdPQtEKY6hLJX6WGooz1I6+0y4AZ7Hf6sqpeC1ukGxrfbXtYTC3zoFk/CFay7bI08pZP4ejjzHtR8sj0jiIoNEWWrRJiOxNDVN0jlUEP8Rpr6VXZ8QSyPM07t1We2ADOnumWm4+jcs/2uWfK1XGOFQesCmr3+5+6cgZ8Qre8ubi9UR0SA1Jq0LGiiNgoKZj/XeGhMGY7hbRD4mouPaiz1D4ir/RCqDdGkBFpdVkfHUINTjcwckAHyP8v/Zo2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL1xzSsR54D1xmUdmvRa5mHRmuaiW+INh2OmUqreBPg=;
 b=BLZq2qjRkyJsSRB+HrBbsdmyXOrXN7JE+mbWKnbkqjvJ9llVUlzD/p7dDuU8dpoDo6OMsT7aygm73fflkG+Tws3+M8E/DEeJ+qbUSZ9b7wkYfBD44rUTJe9VPxjrbQ5k2zlUmEE4FJZhUjMj/DFtwW91CoBS/+e8VAV7WY5vg+A=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 12:46:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 12:46:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
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
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 2/6] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Thread-Topic: [PATCH v2 2/6] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Thread-Index: AQHZ6EF0Wvxq2HuOZEq1IWZp93Ib57Aep0+AgABQtHA=
Date:   Sun, 17 Sep 2023 12:46:24 +0000
Message-ID: <DU0PR04MB9417E05B241CFD361EFFC74088F4A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
 <20230916-vf610-gpio-v2-2-40823da788d7@nxp.com>
 <7ec16938-53fa-24dc-8443-ed6428697558@linaro.org>
In-Reply-To: <7ec16938-53fa-24dc-8443-ed6428697558@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8928:EE_
x-ms-office365-filtering-correlation-id: f298a119-d115-4901-55dd-08dbb77c1a56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5kUoUbazUJk7u6TYBjAWKIBrRrxtOSE45iU4kP/xs8awWD2FNS/aYYsL/YVpF8DZteIcvsqQq/HVSpj153XcOF2UCWZeRd6KdSw/EqVp3gj7I7CJnQXSC2LLPy0yqRKU85U0R1WpyiQU3LFQeR6ISgmapgP2/z+woOa+MdDhhWaycbNnkVk5jdkG0JG60DFOms3MlEImEdwvjNmrDJWhrT53XWHIXn8AvTJmfi9FeURmztExo/U/MQFk3X137Q86R8VKeMcGsJJsSQRVW0hT+QrMKEsY47H1Ro3qBMB+fuwfg/n7fvtVxEgqctZnk+uMo68WHtciMfYnBIgvPGraEK/kTVSdqg62W8wz/H6TSSBvw+rZnTIhU6mBE4Vw9691owweO9Iv2Lk6bZP1X1GwAvRfKIOAK/YEB7WKA/+Yltr/9HIRxZX6Hcih84htvLuenbiculDYcRw9jaO5gIBmTSypCASisO6gcCCR+c0+EDHexmEOr1WXH1pfuBJdCeE1WIGe7EQDMKkia7ePF60lVhvJxusITjXiiyY+0AefGLtrmt89XeV+k819EiD0wsPKh2vKhwx9BFbnIVSj9iemzdCV34ifSeBNqmoIKgHcjesqPIJN+2EGirUe8iH6Y/hDXF8A4510K/GaZhOXlUzGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(186009)(1800799009)(451199024)(921005)(122000001)(55016003)(38070700005)(86362001)(33656002)(38100700002)(6506007)(7696005)(53546011)(478600001)(66946007)(66476007)(54906003)(5660300002)(64756008)(66556008)(66446008)(76116006)(2906002)(8676002)(4326008)(8936002)(44832011)(52536014)(9686003)(83380400001)(41300700001)(7416002)(110136005)(6636002)(316002)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjI0aXBxSGZTbzFGYzhZV1NDZGlLL09STlFFMXVwa1BlSk1HMERYL2ZaVlRz?=
 =?utf-8?B?MXVKeExMUXkvNEVYN3F1TnlZTnlKVW1tcnhXTlN0THRWSTVlNDgxbGxkR0dl?=
 =?utf-8?B?OWJOOVllMGFvcTE1Q2l2RDJQOEFrc0Uvb2JBbjYwK04rdnloQmZrMjNUTDM0?=
 =?utf-8?B?VU9jckt5Q2ErdjFuZGwxdHBqZTVCZld6RmllTHFWQTdNeDdFTDJUTVh6eFV2?=
 =?utf-8?B?dnZBVE9oQzRjZ29WMXdubmlLYnNyR3hCTEJzOG1BR3RhNmloYXU5ekRjNzd0?=
 =?utf-8?B?YXM2N2h0T2pFcXR1WmFBMU8rSWNTb040R3Ribmt6RVlMdmIrK3BBQUZESjVl?=
 =?utf-8?B?WnVVRVI4R3ZPcXgzenp5WU9VT3Bmd08rNExSa1ltbWYyRTR2dmlHYVAyRnRW?=
 =?utf-8?B?Ti9oQVlwRnY5RjRKVkI1VFFmSlZOeXQyeDNHbVpuVkd2OXpicTNtQkhlbDRI?=
 =?utf-8?B?L0E3TjUybWF0SXNmODRJZitjL21HQTRmZTRWRXZQWjZXMjUyVnZPb0haOW9V?=
 =?utf-8?B?dE94azhIMlJCbjhkYytEMkw2TDNNNjVrOU5vamRSNFhNTmtHb3JGc2g0NGI4?=
 =?utf-8?B?TTZXbWJlN0liWlJuanY0RG1nRzFRMEdBNnBVT0FvV0ZCNlUzc3JjQkdDWlR2?=
 =?utf-8?B?Y0JxVGFuRDdhMWxGdmZnSExESnZaRW1xN3F6ZCtBVlNMQlhOU010b202SFk5?=
 =?utf-8?B?dWp5VEpMZms5eWw4UHpKaThpYkdTV2FCN1hVd0VvWTFtT3JvQlNGSjRmejBn?=
 =?utf-8?B?RUpGdmRMZHZzcGhlMVF5SFNDYzRCdnR4N1cxaFltVnAzQ1JHMTBic0MxRDVs?=
 =?utf-8?B?MldZSGk0TGxZYmF1ZDcxNkQ2V0ViZ1lZeXhLZy9EV0FXS0dvZ2FVS1NHU3Fl?=
 =?utf-8?B?MnE4L1dEeUVWbW1sY2RLaE5nQ0cvcFAvOWpvd0pvelp1OGpTaGNwcXhHemE2?=
 =?utf-8?B?cDM3dVdYZlFoS2xyek9LMVJwc0taV0F2MFZHc1M0aEFUNnMyQU5ZdFhITkFH?=
 =?utf-8?B?QnBFOGJ0VWQ5eHNzcFZMUDVzOUhjM21oUThqK1NlT054R3dTYjlzOXhSTXRQ?=
 =?utf-8?B?bS95ZE1Yd0cwS1Q5a01DR3VHdDYyOXVpZFl4dEQxeGZPMU1uYVJRRlltVzdN?=
 =?utf-8?B?elBMZktyL0RqMWJ4WW9nY1poelRlaHBaRXY4WkhGbkxxMGpBOFpYbGd6a3F0?=
 =?utf-8?B?UWJTSXBEbnBHQVo3QnJ5eUNjU3krWWFUOWVzazFpK1FFaldta0xZaFRBNmZw?=
 =?utf-8?B?alRvN0kzNDYvSW1PZi9UNzg2Sm1FbTB6ZTdBamtJM3BPZlQrQm45VjZ4YkNE?=
 =?utf-8?B?OE9nSytXTlBmZlp3ZEdYZWxKS3hXeE9qYUtQMDVyREExL09rcmVEaVhMMU44?=
 =?utf-8?B?OGlyaDMzR2FlL1ZEZC9Ub3pkUHd5bzB6NUxGN20wN3BTc0lobmdrYmlta1Rm?=
 =?utf-8?B?N3ZlQjNhWFg4TWZERXpXbDhPTkVqSlMrSmtNTHZabU1mS21vazkwWFhidW03?=
 =?utf-8?B?cVhoeEp1SnN1QkJRZ0p4UlRzanB3VXdWc1NsbzlRd1BCUnBXUEdDMHgzclRW?=
 =?utf-8?B?dkF0b21wMTZjNlhQMEF4dVBiTGxKYS91U0xRMWxadFd1SmZrbk1CUjc0MEJy?=
 =?utf-8?B?UWNHdEx3bHFCR2xKMitpUjZYTUpKQlZ5eW9EYnRyN1FKQ05hQmtBamtPK0ZG?=
 =?utf-8?B?WkVlUHplOFMwZzh2eXF4YVBraE5qRDVRc1lNemt2dXhwSVQ2UTdId0E5cEhR?=
 =?utf-8?B?Ritia1hKaDBSSlRWMC9yU041bnk4bjRLNkt6NWNVb3VFRFM4cy9IakI5U1c3?=
 =?utf-8?B?VVk2ME9welBQMDBmajJWQ3kzdkJQWGZzeFBOb2lUcVdsSnJzaUtucmU5cGNQ?=
 =?utf-8?B?NzA5Zm5mdHRmSVpsKzF6SUR3SlBmSUdTK0p4UEhXQkhmZ3pDWDFvM1NQdjY2?=
 =?utf-8?B?STBUekZpcTliUFl3QmY2cDU3OFd4bnJiNHcyUS9mYXA3TUJ0S09MeSthcXpN?=
 =?utf-8?B?V0d1UlVIc2lOcnVTL1VBU3FlUjJTR1I4anJwRUtzZ2xkVzlwMjdIWFJhYXYz?=
 =?utf-8?B?VUZqQlhmWEZMVUNCT1Jrd204c25XdDlGTHFST0N2VWZrQW1YNkNaZnhPbnFr?=
 =?utf-8?Q?byf8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f298a119-d115-4901-55dd-08dbb77c1a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 12:46:24.8197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFC3Hr3ecYCcQ6mCRFBEm+rKTtDiEtUFQ5lFFkeclSUN1BJpwu5LIu2dQYHAoFoLUoxYCmO1YRIb0OOySpEjoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvNl0gZHQtYmluZGluZ3M6IGdwaW86IHZmNjEwOiBj
b3JyZWN0IGkuTVg4VUxQIGFuZA0KPiBpLk1YOTMNCj4gDQo+IE9uIDE2LzA5LzIwMjMgMDQ6MDMs
IFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiA+DQo+ID4gaS5NWDhVTFAgYW5kIGkuTVg5MyBhY3R1YWxseSBoYXMgdHdvIGludGVy
cnVwdHMgZm9yIGVhY2ggZ3Bpbw0KPiA+IGNvbnRyb2xsZXIsIG9uZSBmb3IgVHJ1c3R6b25lIG5v
bi1zZWN1cmUgd29ybGQsIG9uZSBmb3Igc2VjdXJlIHdvcmxkLg0KPiA+DQo+ID4gQW5kIHRoZXkg
aGFzIG9uZSByZWdpc3RlciBiYXNlZCwgbm90IHR3byBhcyBpLk1YN1VMUCBvciBWRjYxMC4NCj4g
Pg0KPiA+IEFsdGhvdWdoIHRoZSBMaW51eCBLZXJuZWwgZHJpdmVyIGdwaW8tdmY2MTAuYyBjb3Vs
ZCB3b3JrIHdpdGgNCj4gPiBmc2wsaW14N3VscC1ncGlvIGNvbXBhdGlibGUsIGl0IGlzIGJhc2Vk
IG9uIHNvbWUgdHJpY2tzIGRpZCBpbiBkZXZpY2UNCj4gPiB0cmVlIHdpdGggc29tZSBvZmZzZXQg
YWRkZWQgdG8gYmFzZSBhZGRyZXNzLg0KPiA+DQo+ID4gU28gYWN0dWFsbHkgaS5NWDhVTFAvaS5N
WDkzIGlzIG5vdCBjb21wYXRpYmxlIHdpdGggaS5NWDdVTFAuDQo+ID4NCj4gPiBMYXN0LCBpLk1Y
OTMgaXMgZGlyZWN0bHkgZGVyaXZlZCBmcm9tIGkuTVg4VUxQLCBzbyBtYWtlIGkuTVg5MyBHUElP
DQo+ID4gY29tcGF0aWJsZSB3aXRoIGkuTVg4VUxQDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvZ3Bpby9ncGlvLXZmNjEwLnlhbWwgICAgICAgfCA0MQ0KPiArKysrKysrKysrKysr
KysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9ncGlvL2dwaW8tdmY2MTAueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2dwaW8vZ3Bpby12ZjYxMC55YW1sDQo+ID4gaW5kZXggNTk0MjdkOTdhZGY1
Li44YzFmODdhMWEzOTMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2dwaW8vZ3Bpby12ZjYxMC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vZ3Bpby12ZjYxMC55YW1sDQo+ID4gQEAgLTIwLDYgKzIw
LDcgQEAgZGVzY3JpcHRpb246IHwNCj4gPiAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxl
Og0KPiA+ICAgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gY29uc3Q6IGZzbCxpbXg4dWxwLWdwaW8N
Cj4gPiAgICAgICAgLSBjb25zdDogZnNsLHZmNjEwLWdwaW8NCj4gPiAgICAgICAgLSBpdGVtczoN
Cj4gPiAgICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXg3dWxwLWdwaW8NCj4gPiBAQCAtMjcsMTYg
KzI4LDIxIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIC0gaXRlbXM6DQo+ID4gICAgICAgICAg
ICAtIGVudW06DQo+ID4gICAgICAgICAgICAgICAgLSBmc2wsaW14OTMtZ3Bpbw0KPiA+IC0gICAg
ICAgICAgICAgIC0gZnNsLGlteDh1bHAtZ3Bpbw0KPiA+IC0gICAgICAgICAgLSBjb25zdDogZnNs
LGlteDd1bHAtZ3Bpbw0KPiA+ICsgICAgICAgICAgLSBjb25zdDogZnNsLGlteDh1bHAtZ3Bpbw0K
PiA+DQo+ID4gICAgcmVnOg0KPiA+ICAgICAgZGVzY3JpcHRpb246IFRoZSBmaXJzdCByZWcgdHVw
bGUgcmVwcmVzZW50cyB0aGUgUE9SVCBtb2R1bGUsIHRoZSBzZWNvbmQNCj4gdHVwbGUNCj4gPiAg
ICAgICAgcmVwcmVzZW50cyB0aGUgR1BJTyBtb2R1bGUuDQo+ID4gLSAgICBtYXhJdGVtczogMg0K
PiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBPUlQgcmVnaXN0ZXIg
YmFzZSBhZGRyZXNzDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IEdQSU8gcmVnaXN0ZXIgYmFz
ZSBhZGRyZXNzDQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+DQo+ID4gICAgaW50ZXJydXB0czoN
Cj4gPiAtICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNj
cmlwdGlvbjogR1BJTyBUcnVzdHpvbmUgbm9uLXNlY3VyZSBpbnRlcnJ1cHQgbnVtYmVyDQo+ID4g
KyAgICAgIC0gZGVzY3JpcHRpb246IEdQSU8gVHJ1c3R6b25lIHNlY3VyZSBpbnRlcnJ1cHQgbnVt
YmVyDQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+DQo+ID4gICAgaW50ZXJydXB0LWNvbnRyb2xs
ZXI6IHRydWUNCj4gPg0KPiA+IEBAIC03OCw2ICs4NCwzMyBAQCByZXF1aXJlZDoNCj4gPiAgICAt
ICIjZ3Bpby1jZWxscyINCj4gPiAgICAtIGdwaW8tY29udHJvbGxlcg0KPiA+DQo+ID4gK2FsbE9m
Og0KPiA+ICsgIC0gaWY6DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY29t
cGF0aWJsZToNCj4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBlbnVt
Og0KPiA+ICsgICAgICAgICAgICAgIC0gZnNsLHZmNjEwLWdwaW8NCj4gPiArICAgICAgICAgICAg
ICAtIGZzbCxpbXg3dWxwLWdwaW8NCj4gPiArICAgIHRoZW46DQo+ID4gKyAgICAgIHByb3BlcnRp
ZXM6DQo+ID4gKyAgICAgICAgaW50ZXJydXB0czoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+
ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBHUElPIGludGVycnVwdCBudW1iZXINCj4gDQo+
IFNvIHRoaXMgaXMgZGlmZmVyZW50IHRoYW4gZmlyc3QgaW50ZXJydXB0IG1lbnRpb25lZCBpbiB0
b3AtbGV2ZWw/DQoNClNob3VsZCBiZSBzYW1lLCBJIHdpbGwgdXNlIG1heEl0ZW1zOiAxIGhlcmUu
DQo+IA0KPiANCj4gPiArICAgICAgICByZWc6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiAr
ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogUE9SVCByZWdpc3RlciBiYXNlIGFkZHJlc3MNCj4g
PiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogR1BJTyByZWdpc3RlciBiYXNlIGFkZHJlc3MN
Cj4gDQo+IFlvdSBoYXZlIHRoZSBkZXNjcmlwdGlvbiBpbiB0b3AtbGV2ZWwsIG5vIG5lZWQgdG8g
cmVwZWF0IGl0LiBKdXN0DQo+IG1pbkl0ZW1zOiAyLi4uIGFsdGhvdWdoIGl0IGRlcGVuZHMgd2hl
dGhlciB0b3AtbGV2ZWwgcHJvcGVydHkgd2lsbCBzdGF5Lg0KDQpPaywgZ290IGl0Lg0KPiANCj4g
DQo+ID4gKyAgICBlbHNlOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGlu
dGVycnVwdHM6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBkZXNj
cmlwdGlvbjogR1BJTyBUcnVzdHpvbmUgbm9uLXNlY3VyZSBpbnRlcnJ1cHQgbnVtYmVyDQo+ID4g
KyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IEdQSU8gVHJ1c3R6b25lIHNlY3VyZSBpbnRlcnJ1
cHQgbnVtYmVyDQo+ID4gKyAgICAgICAgcmVnOg0KPiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4g
KyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IEdQSU8gcmVnaXN0ZXIgYmFzZSBhZGRyZXNzDQo+
IA0KPiBTbyB0aGUgZmlyc3QgZW50cnkgaXMgZGlmZmVyZW50IGJldHdlZW4gdmFyaWFudHM/IFRo
ZW4gdG9wLWxldmVsIHNob3VsZCBiZSBqdXN0DQo+IG1pbi9tYXhJdGVtcy4NCg0KWWVzLCBJIHRo
aW5rIHNvLiBSb2IgY29tbWVudGVkIHRvIGxpc3QgaXRlbXMgaW4gdG9wIGxldmVsLCBzbyAuLg0K
DQpUaGFua3MsDQpQZW5nLg0KDQoNCj4gDQo+ID4gKw0KPiA+ICBhZGRpdGlvbmFsUHJvcGVydGll
czogZmFsc2UNCj4gPg0KPiA+ICBleGFtcGxlczoNCj4gPg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0K
