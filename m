Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3064C79FFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjINJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbjINJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:09:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5312107;
        Thu, 14 Sep 2023 02:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+8dXlPhpl4O94rfcNW0DHRzWqTs8vqAczj4y5MDQrD0acXxVk6Qnl7YRKc38wI3SUl7zQp6q3yZxVhYcc/wWnpoojEsZWoKs7vb2tqHJIJho0aEjzwGcb0CU964uaWuCir4q233HAuWock/RJ1rY8kSHMu4wYI1ob416HYRJKUqbUXvARF7B4JcbIlvOfQOSlGPa+NiUNSCT3DzPCGY49JA/QmgDcjuW35ArfS/bievwF5Ct0WHZLehJhUWOodywRpW2y5h6DTbP8a/z5AwFXeJm/imSqyx70rg4+V6jG6nByeInMITA3hBhWK6ktJAU0f372XytE3suZ/Aooa/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcAxAGlCqX7U4kqr75XOEVl7mI1wqywhT5t6o5wtc14=;
 b=QRd2pNotn19cMlRT6EqQUigoCdePa5jdG1Mv+oK0oozAsLSdeZ6hxx7wRyx7XZ0CkI7UiNrSGoAi922tN+vyKI2zmWo7L62Tw1YPh/umH+6BkgkWaItQzy34koj3LsFt642uLwWek1JCplXlAvmSUvDnk5qJkJYUB5J9bVfKiLxsN6Z65YQVMSXLWJ5Nvo7Te4jL+It9ykSQQh6zJ1yRpC+KDSXCazrNHukoUDu0Co2lR11idvlddrUoxqzTVSH4rhPeu1JcPZ/ZVtlpMhw5GnIefSz8TUSgkw5DCS09I/5dAzZvLrMCMB6RvzRsHyqlfsQP4+g+BalYbHgoJFHbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcAxAGlCqX7U4kqr75XOEVl7mI1wqywhT5t6o5wtc14=;
 b=GpmEDTkgK0aJvXa/mBCmXeoBkNHFV+CW0vYiRkEMrJVdIBYyrDl4eimZVrR5fazlLJ2Uc/XqEu3mGrtDn3dxMgE5FfJ+gP5JWeiNuW/omyoNZ2TyLsMA05i1OfhTO0QeEnljTNaxOlVomRGqKIUo9j+LAHak6GMpGXr/KVuVIUc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9520.eurprd04.prod.outlook.com (2603:10a6:102:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 09:08:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 09:08:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
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
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 3/5] gpio: vf610: add i.MX8ULP of_device_id entry
Thread-Topic: [PATCH 3/5] gpio: vf610: add i.MX8ULP of_device_id entry
Thread-Index: AQHZ5rGAjzLkpcp0kkOaeu9OklkaSbAZ0N0AgAAyL4CAAAIigIAAAmVg
Date:   Thu, 14 Sep 2023 09:08:30 +0000
Message-ID: <DU0PR04MB9417CA28C25B68DEF9930DC488F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-3-3ed418182a6a@nxp.com>
 <b97ff9b6-97df-2c62-1946-06cd4ac79c95@linaro.org>
 <CACRpkdYJFp72o=c1OxN9Kcd7-Ee-id8+O2m0ag-rrT-nfq1Srg@mail.gmail.com>
 <48e46de0-0996-b715-9d17-e1e10c0e44be@linaro.org>
In-Reply-To: <48e46de0-0996-b715-9d17-e1e10c0e44be@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB9520:EE_
x-ms-office365-filtering-correlation-id: 92816682-2913-47d3-5005-08dbb5022a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIL0zhE+iUR/vy8qvykVt/y2eSslqZz1+pUftqstMcVvSDPO3XLkjF8xhwxVaWeintiBBoQz/r6/0Zuto2uKSWEVeR8p7+ViP7cHHUg7I4iQHBy7qkcLAOsV23i8FL1FR0Gz207znycgmrcQvRV8e7/tmafsFr7+7Bp+VEix5g4M8ELHl9dNh6zgTDJrTFcdDgoq52o6GDjCynE2BrH96d7pNCwOeKtMH3aHe2IPBSux2PUcTRO37LUrk8FLxwRc+zqx0Jb6AKvZcfelG67q7XHYEnc8g2yRUatElLI7bwjmNeQWYMbH1yMmvecIoCdV4L34Ma1YeRq3F6hBLX8BCf2m6ZWRF9cq51NX9R4ZF47fg81ejdn64DWJkLZu0oZTaumgfevScX2Me1WT+flrUpeDyx7MAPUXhY8tb38LMr7Qp8ahLyvLCWPd5fPvwxBlm5g0UlyaUlbCyCQpo+fFd5sFBRjHqtm7Sj+2fjjY4irck32949u1P6Fj1RLU1ZVzOy7mGjssfK6ZKJfEBUM4f6ZtlanIlouNpuG9FLbwcdWVi7n8Q9BAbxzQFl2pYX6QAqStiy9gThSjqv76YXR7n5ebL8zXmOY7xO//UBpu9RHgZyX9Tl4DwGxhWIhaFD7G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(110136005)(6506007)(86362001)(38100700002)(38070700005)(55016003)(122000001)(316002)(66476007)(2906002)(64756008)(66556008)(76116006)(66946007)(54906003)(478600001)(8936002)(8676002)(44832011)(4326008)(52536014)(66446008)(5660300002)(7416002)(41300700001)(83380400001)(9686003)(71200400001)(53546011)(7696005)(26005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTR2U3JYWmI2NEF4T05BUHVoNTdMSVU5Z1ZHOEZzK2NIT1p2VmhQWHdQbk5M?=
 =?utf-8?B?WVFUa1FmckcweGsrSlBVcUhlbmpzZ3ZiN2cwTG8weWdYaTdQVU5vMCs5M0t1?=
 =?utf-8?B?eCsxZENIQ1g3SnIvQ09UdHJzWW1jUjZPYXF0SUl4TjAyeDU2NE1KN1cxWHlz?=
 =?utf-8?B?Y3pkeW1DZTRodzJSbUFXNWNKREpTUnNKaUxxSVZWb3JDQmZUSmFUaDNHRW1E?=
 =?utf-8?B?OE9LR0E1OUMrNEloRXVncjRhbzJSQW5wWmFOc0NGUUNBaDFJdTJLYmVxTjZP?=
 =?utf-8?B?VEJLTnNDNlpzTjRvRVd0cTRDSWhDR2YweDNZKzZXdFhjeUxOOEtqOUFXNngz?=
 =?utf-8?B?aDAxeXdBVGxZT2dyTjFxMGdNci83QjZCYXZiRFdqbEZtcDViaVluZXNnQ3Nw?=
 =?utf-8?B?eUdBeGJDZ1BRb0p5dHRRTDRybnNRbGlmQjNudk9SVHliZThEdUJrYXp2YkVi?=
 =?utf-8?B?OXR4YWNOMDY1d1JSTnc3QzBzVCtXYTVwQ0ZYZVpqWS9vSGxHUXMxQ2QzTWlr?=
 =?utf-8?B?dDd3LzRvbXpzRm1XKzh5a3dhTWhvVWNLMHNHS2tab3RtMVBpSWp0RXhIWGNk?=
 =?utf-8?B?bEMrTVl6UTltWjlyVHNKNzVwa09Lei9YYjFiSVpCL1Z1MmxmTjRicFh4NTVC?=
 =?utf-8?B?R0VYYjdYY2ZnSU04YmlKMG5zY3V3azNDck45QWNnbzhia21kaWdKYWNyMm5I?=
 =?utf-8?B?VjU2SkttaWlUTjlRU3d3cTdNQzNNbHdzMzNydjZVSWRya2dPZ1AyMyt6VEpo?=
 =?utf-8?B?N2xSbG1BK1dxd0ozNGFYeUJ5RWY3ZHpucHd5UFVVRjFSYS9waHJSTHpqNzhY?=
 =?utf-8?B?SjUrcHJXUWhHd3M5OEhCMlNxcTNJT2ZqdXNNbFRVTTAwcU1MZmNaRFhVYWhs?=
 =?utf-8?B?STRKQUs2dXNRWmNsbjc1YkZELzd3RFRGWVp6TUlSNHlsTW1TcHA1MUd2WE84?=
 =?utf-8?B?UHlRWEpucnlIa1R5eW40WFA0RUkrNTRocjdlZExpcFB5QXh4ejhCT0JNRHdJ?=
 =?utf-8?B?eG1CZ3djenUzcWt0SWEyMHkrSjdBcXVXZ3R6cTlHWWZMeDJwZk5kK2szdCtp?=
 =?utf-8?B?V09KU2RRdkh1QS9LMVM5bWNOWUpjSElMSUJ1ZTkwVjRsVDkrdld4SFo0SXpU?=
 =?utf-8?B?RE0zWFIreSsrRll0VlFIY1NqN3FaUGFNUWVVOGgyNEhYVjFxdFNtYUQrc1pS?=
 =?utf-8?B?cy9pM2pRdkpnY0VJUG1wYnptUGpLa1RIVUxldG5lWUVlbzNBUkRNQTI1WVFj?=
 =?utf-8?B?OW9iMVoycmh2ejExb2FRVXhDem5mYndieEdoZHRvelRpVlBsSCswa1hBZm9m?=
 =?utf-8?B?dStUeC9KMXZWazJ2YStuZWxqUnM0UlRDWVlVQ0JjbGV3Situc0MreXlITG9n?=
 =?utf-8?B?bTd6Z0pCMDNHUWQyK0Z2YTg3cUx5blB0aWEzTWZEbWdoV0pXNXRJNUczbmkz?=
 =?utf-8?B?QURiUkRoc0pvci9kd1RsVlYvNmZXMjJhK2FzYllOTHI3alBVeVVIWVg0bGN1?=
 =?utf-8?B?d0NVTkRzQnJ2K3F3c1AvTnBZaUY5dmJTRC9kK2poWkQ1eHVmMEd6MlJDZlVm?=
 =?utf-8?B?QkhvSnBxQ0RmWXFxZ01HM2lHUGRlUG9IRWhGWW1yem9iQmxaM2FqdmVzOFgy?=
 =?utf-8?B?bEp5RkJVbGxmS2RMZEpBL2FGQnV1L3dBNmJGbWpxRFVLU1hTUWNMTFdKZ3BX?=
 =?utf-8?B?MFRKL1hlbjZVeHN6dUFCSXpXZTk3bmtsc1lMeGVNZnhIZmlWajNLc3NKYmZX?=
 =?utf-8?B?WkU3aFdnUDRKbkVDMlJCWXo3V1BhcTdSdG81UUtZY25ZMkZ3MlJwVXZQV2N1?=
 =?utf-8?B?ZmhUeXYxTnVqUUVZeUJDWXoxdHh4S1IyY00rS2xhRlVuMGlmbzZiNEovSVo2?=
 =?utf-8?B?QUZnNW9kdWgyQmFEUXFVTUJHanIzVWxURTlmdURzckF3TXoraEJrMWI4MXhz?=
 =?utf-8?B?SjdhcTVZckMrakt3d3pnSDNRaG8rUmdMQy9KUmlZSVdJM0k2R1kwUHJPOGc2?=
 =?utf-8?B?ZUpWdzNVNkx4Tk5Cd1AvQzZlSU5CbkU1dXdhNE9KQWlmZ2RQVHl0OFZ1cjNv?=
 =?utf-8?B?eVlwRktFNDRuemlmRGM2dGhISGdDNlVpRHhhRkx5eS9rQXlGbEsyOHdjY3lV?=
 =?utf-8?Q?/VEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92816682-2913-47d3-5005-08dbb5022a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:08:30.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJNOvASnvxyVi0mstTMa+YyL2w4XW5Kcgb8wWoaSQI6vIUGDLSgHBqYsXcke6A2bmckWH5sz3D0rAwTM1PZJxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNV0gZ3BpbzogdmY2MTA6IGFkZCBpLk1YOFVMUCBvZl9k
ZXZpY2VfaWQgZW50cnkNCj4gDQo+IE9uIDE0LzA5LzIwMjMgMTA6NDgsIExpbnVzIFdhbGxlaWog
d3JvdGU6DQo+ID4gT24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgNzo0OOKAr0FNIEtyenlzenRvZiBL
b3psb3dza2kNCj4gPiA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPiB3cm90ZToNCj4g
Pj4gT24gMTQvMDkvMjAyMyAwNDoyMCwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4+PiBGcm9t
OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4+DQo+ID4+PiBpLk1YOFVMUCBzdXBw
b3J0cyB0d28gaW50ZXJydXB0cywgd2hpbGUgaS5NWDdVTFAgc3VwcG9ydHMgb25lDQo+IGludGVy
cnVwdC4NCj4gPj4+IFNvIGZyb20gaGFyZHdhcmUgcGVyc3BlY3RpdmUsIHRoZXkgYXJlIG5vdCBj
b21wYXRpYmxlLg0KPiA+Pj4NCj4gPj4+IFNvIGFkZCBlbnRyeSBmb3IgaS5NWDhVTFAuDQo+ID4+
Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+
PiAtLS0NCj4gPj4+ICBkcml2ZXJzL2dwaW8vZ3Bpby12ZjYxMC5jIHwgMSArDQo+ID4+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMgYi9kcml2ZXJzL2dwaW8vZ3Bpby12ZjYxMC5jDQo+ID4+
PiBpbmRleCBkYmM3YmEwZWU3MmMuLjg4ZjcyMTVjZGY0YiAxMDA2NDQNCj4gPj4+IC0tLSBhL2Ry
aXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3Bpby9ncGlvLXZm
NjEwLmMNCj4gPj4+IEBAIC02Nyw2ICs2Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZnNsX2dw
aW9fc29jX2RhdGEgaW14X2RhdGEgPSB7DQo+ID4+PiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCB2ZjYxMF9ncGlvX2R0X2lkc1tdID0gew0KPiA+Pj4gICAgICAgeyAuY29tcGF0aWJs
ZSA9ICJmc2wsdmY2MTAtZ3BpbyIsICAgICAgIC5kYXRhID0gTlVMTCwgfSwNCj4gPj4+ICAgICAg
IHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtZ3BpbyIsICAgICAuZGF0YSA9ICZpbXhfZGF0
YSwgfSwNCj4gPj4+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDh1bHAtZ3BpbyIsICAg
ICAuZGF0YSA9ICZpbXhfZGF0YSwgfSwNCj4gPj4NCj4gPj4gV2h5PyBJdCBpcyB0aGUgc2FtZSBh
cyBpbXg3LiBObyBuZWVkLg0KPiA+DQo+ID4gQmVjYXVzZSBjb21wYXRpYmxlID0gImZzbCxpbXg3
dWxwLWdwaW8iIGlzIG5vdCB3aGF0IGlzIGdvaW5nIHRvIGJlIGluDQo+ID4gdGhlIGRldmljZSB0
cmVlLCBidXQgY29tcGF0aWJsZSA9ICJmc2wsaW14OHVscC1ncGlvIj8NCj4gPg0KPiA+IFdoYXQg
YW0gSSBtaXNzaW5nIGhlcmU/IE1heWJlIHRoZSBjb21taXQgbWVzc2FnZSBpcyB3ZWlyZC4NCj4g
Pg0KPiANCj4gSWYgdGhlIGRldmljZXMgdXNlZCBiZWZvcmUgYW5kIGFyZSBzdGlsbCBnb2luZyB0
byB1c2Ugc2FtZSBkcml2ZXIgZGF0YSwgdGhleQ0KPiBsb29rIGNvbXBhdGlibGUgZnJvbSBPUyBw
b2ludCBvZiB2aWV3LiBUaGVyZWZvcmUgdXN1YWxseSB3ZSBleHByZXNzIHN1Y2gNCj4gY29tcGF0
aWJpbGl0eSBhbmQgZG8gbm90IGFkZCB1bm5lZWRlZCBkZXZpY2VfaWQgZW50cmllcy4NCj4gDQo+
IE5vdyB3aGV0aGVyIHRoZSBkZXZpY2VzIGFyZSB0cnVseSBjb21wYXRpYmxlIG9yIG5vdCwgSSBk
b24ndCBrbm93IGFuZCB3aXRoDQo+IHNvbWUgcmVjZW50IGVtYWlscyBJIGFtIGJpdCBjb25mdXNl
ZC4NCg0KU29tZSB0cmlja3MgaW4gZHRiIGFyZSBtYWRlIHRvIG1ha2UgdGhlIGRyaXZlciBjb3Vs
ZCB3b3JrIGZvciBib3RoIGkuTVg3VUxQLA0KaS5NWDhVTFAsIGkuTVg5MyB3aXRoIGZzbCxpbXg3
dWxwLWdwaW8uDQoNClN1Y2ggYXMgaS5NWDhVTFA6DQpyZWcgPSA8MHgyZDAwMDA4MCAweDEwMDA+
LCA8MHgyZDAwMDA0MCAweDQwPjsNCkFjdHVhbGx5IHRoZSB0d28gcmVncyBhcmUgYmVsb25nIHRv
IG9uZSBwaHlzaWNhbCBjb250aW51b3VzIHNwYWNlLA0KPDB4MmQwMDAwMDAgMHgxMDAwPg0KSnVz
dCB0byBpLk1YOFVMUCBjb3VsZCByZXVzZSB0aGUgdmY2MTAgZ3BpbyBkcml2ZXIsIHRoZSByZWdz
IGFyZSBwYXJ0aXRpb25lZA0KaW50byB0d28gd2l0aCBzb21lIG9mZnNldCBhZGRlZA0KDQpTbyBm
cm9tIGh3LCBJIHRoaW5rIHRoZXkgYXJlIG5vdCBjb21wYXRpYmxlLCBqdXN0IHNvbWUgc3cgdHJp
Y2tzIHRvDQptYWtlIHRoZSBsaW51eCBkcml2ZXIgY291bGQgd29yayBmb3IgYm90aCBwbGF0Zm9y
bS4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0K
