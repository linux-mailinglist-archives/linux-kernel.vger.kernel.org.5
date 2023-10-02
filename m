Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9B7B4F47
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjJBJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjJBJnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:43:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA588E8;
        Mon,  2 Oct 2023 02:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAc/ZHN7BjYXNekZW23lRWERooVesPhyzqd6uCQIpuy/a3Iy65x1//2TkXP7BwWqPLIHjV6A2MEnymromDzOk/hoDJtIigrA3lvQ92Izz8EttzoGStz89x7SNx0964zUAQAfOLtjCvfFCJ1K8RbF7afO8RWH54I8iZSxuhmUT9oay3lqzmCgMBL26UPUR8Xm6PIFNbGCtaVBX4T59JNyLGhDf6Qlk7AM6SXZCNcmdSIRp/XqxpYLgD0rxzPx5GRHuU3GGl5Mr6bfAI+x1AdKg51hf2vU/sFLnziJ9qhLCcLeHhyDLrFG0qkQfBw7RN3UM/v/EUDYctfZNBu1yqJPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j85KZp1PJFzdLPDeyfP+evy2fsFtVhiQNb/PrFfOlU=;
 b=cRPcWyt5i/F+sHOwmby0pQo1XI7WAjgbXayltxleVB/6R0BgWsSJ4j/PVTSTw7tkPHxriJNddOj/lWAgCQFncT4+ObjqtRBuBzRDPWmLVUDVyYOtPg6EhRfsIyFsKYkXxQOGlJNC/D1Wkf84lizrX1mVReuTrGU7ohZdO+9azRnkvzM7eE+0r8mZkGCL1X68/Jzpta4IdEr9Icjg3pJJm2F6Nb9OgMRt/f3jkCBEowIqFmq7OMFgwYABnBy4OmWnMtiBTAuBRtseQ8S7B/JWxMGREJm37tyeEBqLd60rx9wBE/VC4nCZ6lJISGzXmtN4NzTj8peb8pw4i1H7rhfg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j85KZp1PJFzdLPDeyfP+evy2fsFtVhiQNb/PrFfOlU=;
 b=FLYi0qAUwXg5kSDrSxM+FMQtSc5xyxvw3zpfvyZqJzWnU+s+zqNLpeK2WRKgxBtQl74GDlxdqWG9jy1YPUefnEi+BcAHXKRDmsbB95SaJaZk4UakNsoilFvw8LpZyFGFwM7RzMvSQVpDmWMLkY5znrloYnPr2Q1nAGZ0+A/eaas=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8104.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 09:43:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 09:43:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
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
        Marco Felsch <m.felsch@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
Thread-Topic: [PATCH v5 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
Thread-Index: AQHZ9ECUzqWl2Wrf9EGrw+7UWIA7m7A2NmKAgAAKHBA=
Date:   Mon, 2 Oct 2023 09:43:06 +0000
Message-ID: <DU0PR04MB9417594B2DFDA6056AEC4CB988C5A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
 <20231001-vf610-gpio-v5-4-8d873a8f224a@nxp.com>
 <CAMRc=MdXkFBWMuyr8sbetyP2sJX2QG6Ce=Tsb7RVMguvGdC3TA@mail.gmail.com>
In-Reply-To: <CAMRc=MdXkFBWMuyr8sbetyP2sJX2QG6Ce=Tsb7RVMguvGdC3TA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8104:EE_
x-ms-office365-filtering-correlation-id: 7c4b2d07-d5ab-41ef-5016-08dbc32bfb46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNR87Aom9Q6VsXLlRHojHkghmj1IYBsWQLp9p7pTkQVsGEan1Z0Hfqtc8z2On4tXTOkr4VX9wkSxhmDCkk610WXvGqhr3fv5JmqaH2z7dMg0b9z+TaPLeKlDLGaBKkKkSwi5NiEnHlJnYcA3JblJqhg3rqj9/6TAC0r5ECeRR08olnLqWroALYmaPLVJjN0UBjD+nRDC8G1KxMXxIC/P2O+4CdOReuM/8hPrHpcJlXHIf4rP5krEgtlR9aKR3MVmSFiVJgLl+MMiPUQC+A6s1WLomg/RK6rXz7kMqCBw3RM+i5gkI+tDNjJTjvak1+2lXXchoh1mmSHDUId73XVYZQPT0I6+y5A2vml1gQmLkTD3rXtsRp/WBfsdspUlE1H+Wh2/VcXNYKntpo1Klb/X/WyXbmOg1j7k14xxyUCrBY9SvyhD7kck6iFUUPK7yCx7iewOy7SG/txCqp2JT3qj+dd6pScw8pxQlw392YWlzfLcO3O+y8Wnoog/K+rfw7YjbQcgJygWGb1/MJPpYaY5KjygMQmq0qU0f+XCUwQYFSZQhd9RUgDsSyxHHmrI6bDBYVMW/UYU589APWYiTE8Udg77Y5iVliN39M3M/Jyx3zgO6eEG3UwGugfQ/hjGkPyV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(41300700001)(2906002)(83380400001)(44832011)(5660300002)(316002)(52536014)(4326008)(8936002)(8676002)(66946007)(7416002)(54906003)(110136005)(33656002)(86362001)(71200400001)(7696005)(9686003)(6506007)(53546011)(26005)(64756008)(122000001)(38100700002)(66556008)(66476007)(38070700005)(76116006)(478600001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVVsSlQ5ajZBSksrN1Rub3lKWWRUbHBEUnc0eUNacExYaURvRFRxeDl1azhw?=
 =?utf-8?B?NW5rQ1V2RDVxcStBUUg5dEtQMi9mUDROcEF6QXUremNUcUtkS1FsckR0N3kw?=
 =?utf-8?B?cWhBVmlvMi9iMERhMXJXdS9hdEkzc1BRMi8vT1l3b1Q3WklheGU1Z29jb3dR?=
 =?utf-8?B?cjRtZnozbm9hRGdLYW1udG5Kdkt4YmtVU1cxYTlQa0dZRDZxRzRKRk9QZTg3?=
 =?utf-8?B?SldQWlZ6enZkVU1icG0vUVI1dUNVQ0VHWWN3RHMrTy9rdHB1cUhCNU1OL2pi?=
 =?utf-8?B?N0NzK1VjNHNBTG55TlE3MDlYMHFWVTJ3Zmd0eDV4dll0OU9HTEVkZTU1a212?=
 =?utf-8?B?Skk3U2o1eTQyaHlyd3owWXFsaU8xQjlwT0xTdHJXUnBpRGhFNEEwejBtMll2?=
 =?utf-8?B?T1VhWEN3L1QxYTB3K1Qvckk0TkpKbklWNmhrMjc2ZTZ4WkQrTEpXbEdDNjh2?=
 =?utf-8?B?ek0xSkJ5TElsNFYrYTl1ZVB5czk5RGZaK1ZPT2pzTFI3ZzREMExGb3R6Y1Y2?=
 =?utf-8?B?ci9iWTZ5dUo4ZkRmNWF6eTcxakQ5QjRsRlovMUZkN29kQjBiN3pvREc5NG9i?=
 =?utf-8?B?cWxtUGNGYnFJRE9rOUJmci9yZzhteFlvK2N1bmNvU0ZTNUZCUFRuZVVrbU5M?=
 =?utf-8?B?eHhPOTIwSVlaOXZYeDBOeFJsbC92b2dHYlhLRmZOTWZXYVlpQkNKMzhEVyt6?=
 =?utf-8?B?WHc3VTBrdEkydXdOV3dSa3hPc1J5c0xrcHdPU0Qxd2IyMjk5RE1LL1RseFUx?=
 =?utf-8?B?bThBSVA2a2JQYU9iN09rNkFRRXR5Qjlla1U1K3ROTkVZN2NjNDgvUHhMbVh0?=
 =?utf-8?B?b1d4VEE1YmwvZ3V3Y0ZvYUwyTHRVS0Vmc3ZTVnhiZ0MrTXlEYmphZU4zNXR3?=
 =?utf-8?B?anlKdTJEVG9IYmQvY3FxK1BKaVpDM0ZMVWhSSUFGenk4aWpqTjEvOHEvVTZs?=
 =?utf-8?B?ZjNYeS8ydkR1RmRROEw4Q0F6QThXRXNabS9GMGJWeDNIazYxUmtaNUxjQmJL?=
 =?utf-8?B?YTZlZHNwU0VnVVZYUnhGbTM0aGcvUHJPa0gzNWpwWEhWWmw4VWV6M0I1bzZu?=
 =?utf-8?B?Q29KL0t1K2RsMExDNjNVbjFodW1HenpYeCtzVE03NXI1VzZmUytSKzh0UjFR?=
 =?utf-8?B?WnJMWitvWDVLS0xtSHZLZGxIK3R3MVlRYmVma210V0ZEb0R2WVp0bGFzek91?=
 =?utf-8?B?cHJKNlBidm1XY0tiaEloMVJTUVZXOThxZExoUFVZQ0RhaEp5Yng4Tm5vR2lF?=
 =?utf-8?B?VmtWWncrbmRYQTVScEZnYUVTdUpYRWpicnFZM3VsT0hrT1ROTnQwVW1Ub3Bq?=
 =?utf-8?B?cVpkMWt3NGJyV29SU2tPQm5LZlZqa0FPa3J2TjRVaStsTXBpL3M4c3RMTWt2?=
 =?utf-8?B?eWNIVnEwMWJkRGREeFVVVG1pQWlPb05RZFNqWW1WZCt2NzFrR1AwQTdFYUN4?=
 =?utf-8?B?VWwwTmdPSEZyempiRjRpOFFINnhNbERTVlR1WXl3MmF2WEp0ZlVyQ2FMZlRx?=
 =?utf-8?B?bkxTNVZKUDdQUFE0N29KUGZib2JsWXE1Mmo4QzdvdVd5V0dGUlpJak53aGwx?=
 =?utf-8?B?WkdmUms3bTEyb3hGQU1wTTVxQ0sxRHYrN3NLbHBOWldqS2gvVXdVUERtMUg1?=
 =?utf-8?B?b2tyQkxYcm50NFU1QWdDR1lMWGFacGNLbERueEZtYVVNdWpZZyt1d3ZqUzZS?=
 =?utf-8?B?WUh4WUFNWEd1TmJXZzlpVzRxdVl3cjYvRWZWeUJTU0JuS2dNT2tsVTJieG9q?=
 =?utf-8?B?NUdzM0plMEk5Z0xaVnloY2hvVyt0OXc3eXkxUGRXNUhWcDhIVXltQnRrV2k4?=
 =?utf-8?B?NmVWeU1MdDJwelFldEExdGVublljU0JUL2tPeHlpS09yVFJqU0ZvdjRLdVB6?=
 =?utf-8?B?REZYTGtlTmwvaUp2aGlSZTVXNzVsUjUvdzFuOFJaTU5RV0d1bnBpYkNZZ1g4?=
 =?utf-8?B?VUdjVENzTEtWN2tUS0p4YTk5NUJlNmNSeTBNYTQvL1E5ejQ2b2ZGNVNybXcz?=
 =?utf-8?B?R0hBeVIwSVNhbGk4TEY4RFVCKzN2UzM4Y21vYjVVMitydldNM2NTQzkvWWZm?=
 =?utf-8?B?aURYN0FiM21mc09PSmZYWkRKMUVtVXk0MVduRU1ZLzRQc2ZYV0RnT1BTVlFm?=
 =?utf-8?Q?/Xf4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4b2d07-d5ab-41ef-5016-08dbc32bfb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 09:43:06.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+vMG55fSpq/ckyxGHO/6gS3Uvom+TYh44eivg4+YGgYdIgg7veD6FTdu4uIxWHGEFzvUQS+fQlFRsVEs2mw8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8104
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDQvN10gZ3BpbzogdmY2MTA6IGFkZCBpLk1YOFVMUCBv
Zl9kZXZpY2VfaWQgZW50cnkNCj4gDQo+IE9uIFN1biwgT2N0IDEsIDIwMjMgYXQgMTA6MjPigK9B
TSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+
ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOFVMUC85
MyBHUElPIHN1cHBvcnRzIHNpbWlsYXIgZmVhdHVyZSBhcyBpLk1YN1VMUCBHUElPLCBidXQNCj4g
PiBpLk1YOFVMUCBpcyBhY3R1YWxseSBub3QgaGFyZHdhcmUgY29tcGF0aWJsZSB3aXRoIGkuTVg3
VUxQLiBpLk1YOFVMUA0KPiA+IG9ubHkgaGFzIG9uZSByZWdpc3RlciBiYXNlLCBub3QgdHdvIGJh
c2VzLiBpLk1YOFVMUCBhbmQgaS5NWDkzDQo+ID4gYWN0dWFsbHkgaGFzIHR3byBpbnRlcnJ1cHRz
IGZvciBlYWNoIGdwaW8gY29udHJvbGxlciwgb25lIGZvcg0KPiA+IFRydXN0em9uZSBub24tc2Vj
dXJlIHdvcmxkLCBvbmUgZm9yIHNlY3VyZSB3b3JsZC4NCj4gPg0KPiA+IEFsdGhvdWdoIHRoZSBM
aW51eCBLZXJuZWwgZHJpdmVyIGdwaW8tdmY2MTAuYyBjb3VsZCB3b3JrIHdpdGgNCj4gPiBmc2ws
aW14N3VscC1ncGlvIGNvbXBhdGlibGUsIGl0IGlzIGJhc2VkIG9uIHNvbWUgdHJpY2tzIGRpZCBp
biBkZXZpY2UNCj4gPiB0cmVlIHdpdGggc29tZSBvZmZzZXQgYWRkZWQgdG8gYmFzZSBhZGRyZXNz
Lg0KPiA+DQo+ID4gQWRkIGEgbmV3IG9mX2RldmljZV9pZCBlbnRyeSBmb3IgaS5NWDhVTFAuIEJ1
dCB0byBtYWtlIHRoZSBkcml2ZXINCj4gPiBjb3VsZCBhbHNvIHN1cHBvcnQgb2xkIGJpbmRpbmdz
LCBjaGVjayB0aGUgY29tcGF0aWJsZSBzdHJpbmcgZmlyc3QsDQo+ID4gYmVmb3JlIGNoZWNrIHRo
ZSBkZXZpY2UgZGF0YS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwaW8vZ3Bpby12ZjYxMC5jIHwgNDcN
Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwaW8vZ3Bpby12ZjYxMC5jIGIvZHJpdmVycy9ncGlv
L2dwaW8tdmY2MTAuYw0KPiA+IGluZGV4IGRiYzdiYTBlZTcyYy4uOGUxMjcwNmMwYjIyIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwaW8vZ3Bpby12ZjYxMC5jDQo+ID4gQEAgLTI1LDYgKzI1LDcgQEANCj4gPiAgc3RydWN0IGZz
bF9ncGlvX3NvY19kYXRhIHsNCj4gPiAgICAgICAgIC8qIFNvQ3MgaGFzIGEgUG9ydCBEYXRhIERp
cmVjdGlvbiBSZWdpc3RlciAoUEREUikgKi8NCj4gPiAgICAgICAgIGJvb2wgaGF2ZV9wYWRkcjsN
Cj4gPiArICAgICAgIGJvb2wgaGF2ZV9kdWFsX2Jhc2U7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3Ry
dWN0IHZmNjEwX2dwaW9fcG9ydCB7DQo+ID4gQEAgLTYwLDEzICs2MSwyNiBAQCBzdHJ1Y3QgdmY2
MTBfZ3Bpb19wb3J0IHsNCj4gPiAgI2RlZmluZSBQT1JUX0lOVF9FSVRIRVJfRURHRSAgIDB4Yg0K
PiA+ICAjZGVmaW5lIFBPUlRfSU5UX0xPR0lDX09ORSAgICAgMHhjDQo+ID4NCj4gPiArI2RlZmlu
ZSBJTVg4VUxQX0dQSU9fQkFTRV9PRkYgIDB4NDANCj4gPiArI2RlZmluZSBJTVg4VUxQX0JBU0Vf
T0ZGICAgICAgIDB4ODANCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZnNsX2dwaW9f
c29jX2RhdGEgdmY2MTBfZGF0YSA9IHsNCj4gPiArICAgICAgIC5oYXZlX2R1YWxfYmFzZSA9IHRy
dWUsDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGZzbF9ncGlvX3Nv
Y19kYXRhIGlteF9kYXRhID0gew0KPiA+ICAgICAgICAgLmhhdmVfcGFkZHIgPSB0cnVlLA0KPiA+
ICsgICAgICAgLmhhdmVfZHVhbF9iYXNlID0gdHJ1ZSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgZnNsX2dwaW9fc29jX2RhdGEgaW14OHVscF9kYXRhID0gew0KPiA+
ICsgICAgICAgLmhhdmVfcGFkZHIgPSB0cnVlLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHZmNjEwX2dwaW9fZHRfaWRzW10gPSB7DQo+ID4gLSAg
ICAgICB7IC5jb21wYXRpYmxlID0gImZzbCx2ZjYxMC1ncGlvIiwgICAgICAgLmRhdGEgPSBOVUxM
LCB9LA0KPiA+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsdmY2MTAtZ3BpbyIsICAgICAg
IC5kYXRhID0gJnZmNjEwX2RhdGEgfSwNCj4gPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNs
LGlteDd1bHAtZ3BpbyIsICAgICAuZGF0YSA9ICZpbXhfZGF0YSwgfSwNCj4gPiArICAgICAgIHsg
LmNvbXBhdGlibGUgPSAiZnNsLGlteDh1bHAtZ3BpbyIsICAgICAuZGF0YSA9ICZpbXg4dWxwX2Rh
dGEsIH0sDQo+ID4gICAgICAgICB7IC8qIHNlbnRpbmVsICovIH0NCj4gPiAgfTsNCj4gPg0KPiA+
IEBAIC0yNjMsMTkgKzI3NywzOCBAQCBzdGF0aWMgaW50IHZmNjEwX2dwaW9fcHJvYmUoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgICAgICAgIHN0cnVjdCBncGlvX2lycV9j
aGlwICpnaXJxOw0KPiA+ICAgICAgICAgaW50IGk7DQo+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+
ICsgICAgICAgYm9vbCBkdWFsX2Jhc2U7DQo+ID4NCj4gPiAgICAgICAgIHBvcnQgPSBkZXZtX2t6
YWxsb2MoZGV2LCBzaXplb2YoKnBvcnQpLCBHRlBfS0VSTkVMKTsNCj4gPiAgICAgICAgIGlmICgh
cG9ydCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4NCj4gPiAgICAg
ICAgIHBvcnQtPnNkYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+ID4gLSAg
ICAgICBwb3J0LT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAp
Ow0KPiA+IC0gICAgICAgaWYgKElTX0VSUihwb3J0LT5iYXNlKSkNCj4gPiAtICAgICAgICAgICAg
ICAgcmV0dXJuIFBUUl9FUlIocG9ydC0+YmFzZSk7DQo+ID4NCj4gPiAtICAgICAgIHBvcnQtPmdw
aW9fYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxKTsNCj4gPiAt
ICAgICAgIGlmIChJU19FUlIocG9ydC0+Z3Bpb19iYXNlKSkNCj4gPiAtICAgICAgICAgICAgICAg
cmV0dXJuIFBUUl9FUlIocG9ydC0+Z3Bpb19iYXNlKTsNCj4gPiArICAgICAgIGR1YWxfYmFzZSA9
IHBvcnQtPnNkYXRhLT5oYXZlX2R1YWxfYmFzZTsNCj4gPiArDQo+ID4gKyAgICAgICAvKiBzdXBw
b3J0IG9sZCBjb21wYXRpYmxlIHN0cmluZ3MgKi8NCj4gPiArICAgICAgIGlmIChkZXZpY2VfaXNf
Y29tcGF0aWJsZShkZXYsICJmc2wsaW14N3VscC1ncGlvIikgJiYNCj4gPiArICAgICAgICAgICAo
ZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LCAiZnNsLGlteDkzLWdwaW8iKSB8fA0KPiANCj4gV2h5
IG5vdCBqdXN0IGFkZCB0aGlzIGNvbXBhdGlibGUgdG8gdmY2MTBfZ3Bpb19kdF9pZHM/DQoNCiJm
c2wsaW14OTMtZ3BpbyIsICJmc2wsaW14N3VscC1ncGlvIiBpcyBub3QgYSBjb3JyZWN0IGVudHJ5
DQpjb21iaW5hdGlvbi4gVGhpcyBpcyB0byBzdXBwb3J0IGxlZ2FjeSBvbGQgY29tcGF0aWJsZQ0K
c3RyaW5ncy4NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+IEJhcnQNCj4gDQo+ID4gKyAgICAgICAg
ICAgKGRldmljZV9pc19jb21wYXRpYmxlKGRldiwgImZzbCxpbXg4dWxwLWdwaW8iKSkpKQ0KPiA+
ICsgICAgICAgICAgICAgICBkdWFsX2Jhc2UgPSB0cnVlOw0KPiA+ICsNCj4gPiArICAgICAgIGlm
IChkdWFsX2Jhc2UpIHsNCj4gPiArICAgICAgICAgICAgICAgcG9ydC0+YmFzZSA9IGRldm1fcGxh
dGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiArICAgICAgICAgICAgICAgaWYg
KElTX0VSUihwb3J0LT5iYXNlKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
UFRSX0VSUihwb3J0LT5iYXNlKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHBvcnQtPmdw
aW9fYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxKTsNCj4gPiAr
ICAgICAgICAgICAgICAgaWYgKElTX0VSUihwb3J0LT5ncGlvX2Jhc2UpKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHBvcnQtPmdwaW9fYmFzZSk7DQo+ID4gKyAg
ICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICBwb3J0LT5iYXNlID0gZGV2bV9wbGF0
Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAo
SVNfRVJSKHBvcnQtPmJhc2UpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBQ
VFJfRVJSKHBvcnQtPmJhc2UpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgcG9ydC0+Z3Bp
b19iYXNlID0gcG9ydC0+YmFzZSArIElNWDhVTFBfR1BJT19CQVNFX09GRjsNCj4gPiArICAgICAg
ICAgICAgICAgcG9ydC0+YmFzZSA9IHBvcnQtPmJhc2UgKyBJTVg4VUxQX0JBU0VfT0ZGOw0KPiA+
ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBwb3J0LT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJx
KHBkZXYsIDApOw0KPiA+ICAgICAgICAgaWYgKHBvcnQtPmlycSA8IDApDQo+ID4NCj4gPiAtLQ0K
PiA+IDIuMzcuMQ0KPiA+DQo=
