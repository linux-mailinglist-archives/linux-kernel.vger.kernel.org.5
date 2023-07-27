Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7767643AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjG0CIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjG0CIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:08:36 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEBA19A0;
        Wed, 26 Jul 2023 19:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSFnk4qy8E9mvjh9kXinZ0y5ExvbT27XlE2463fn+JI0yr3ItZvKz5Rb8fjpEI4n4aneBKlEhWMJ5YZBvtu6A8woFbQD7Mfr+gSWi5VTO7ctxqT3iX/F3WToANYm956grjFTLXtZvMWDtMVg00L/QTpoRYeMHqxWx6bg/PMvfRusbl5WepUqFeNGsNBZIHICocA2xH9IM0K4T0OGe6tcK2Y7scaOBoTF8zWI8JblOXUYsfDp9xCeabMMTPRh4PtQ9JxoXNdGtGWrWgw7qyvK3NwukCE/O3PilOS1OA8hec4v8+2yEkozzqyNtX3j/ZL0uFkOJd5GekWFF8qI2zps3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQgzPz5bkxkXEw2IwPNltZbK14yMsclL0tTXolqEXBA=;
 b=OZ8jWIefAzN1fG5+olPX12kFjIU93Km3HK8n9Ui1tBLQ33rciHei59v3szcCBqACi9HhVfqjJDz9PqlbOddb77jykgckFt1/uC/MwmI3dQHKXFXuh/uVJCESkevT+gOMzrxXOxFExv+CI7MwlJfeIAUs3isYVFQIjCvg6dynxh7u27vGyz34jk0PAltL9Kzs9TSdF8X1LDH0pC1jCB6ZQu9jkpuhNKJ60/lxUrhGCsxmJ+ap2UM0JsR6UuFN7eWtGvFB6ABoEhU6jVWn9bARAvd0QKZB+UdV/WuQhO0ZSKyPBFNWBCODXCma9PhxZ+jS5s0hrSUBpzbh9s/i9MxXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQgzPz5bkxkXEw2IwPNltZbK14yMsclL0tTXolqEXBA=;
 b=M2nI1wxdU8PkiBpW/7QAjqd7WnLoIIMtzM7XBs8jtP5rbPBDbFwWaXLB8tRRTWztC9jznmyRwDt+pufqYCBrADn3nbe7vgzNSg3UcnA8FhkmjtsWSoN87ydM+DvK7r6zfNRbY8pTOkh+h2fI2tM+P8lLv11cukI4zLZHhH7lYDg=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB8560.eurprd04.prod.outlook.com (2603:10a6:102:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 02:08:32 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:08:32 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
Thread-Topic: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
Thread-Index: AQHZvsxwawoZvXvGy0ONq5DghKmkjq/KsvwAgACtTTCAANTXgIAAoH7g
Date:   Thu, 27 Jul 2023 02:08:32 +0000
Message-ID: <AM5PR04MB3139FC9C3FED1759E1160EAE8801A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230725074148.2936402-1-wei.fang@nxp.com>
 <70b71e7bb8a7dff2dacab99b0746e7bf2bee9344.camel@gmail.com>
 <AM5PR04MB31390FCD7DB9F905FCB599108800A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <CAKgT0Ufo8exTv1783Ud7EUg_1ei90Eb4ZoiHFd49zAbfhLgAsQ@mail.gmail.com>
In-Reply-To: <CAKgT0Ufo8exTv1783Ud7EUg_1ei90Eb4ZoiHFd49zAbfhLgAsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAXPR04MB8560:EE_
x-ms-office365-filtering-correlation-id: 4914970d-13e0-47ea-3bcd-08db8e4660e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQ0e2B11wgyKUMmtOgVHarcyizAp8YQgyJMOLrNuMEEk2So64GMrLoY/CKeeXxj3T0/j36R3gw6N6lSYMI0Il9xODDXdoNxP0GpnEDSJLKsnUJXY9B5jLMbyNmM24awlEGTklDzfUBqlqG6lXFiaCOgpKKJ5+OSZfLCPCl3sbIz+xkyBH/esQmUAhiijO5rVmEMFWKKaTlZjv+2lAF7yrUYdCI5U76g0+484FqIINnGI3DLJtBDGbCpZzNvxuRQ13lESzlZ6/we/9xqaftwCKCDOsL07OZ69cJWiSnhtjSjaOsCaYyWqh6ng2l7KxQKX34nK12EUoL2RsDG/AOWLphQbkCb0muoo8p2NUS8raBDohC5BidoEr6ocOntR3OQ1LDAbMxhmC+HXNmbJH5TFgDpMrH6iNMMMnq4HvKT8m7qttIwqIde+WVl/f8/on9nUisb1zpjt8OJjl4JjZcJ8EvN2cf1k2eYWhhALg9CL3NLP7LLSMOLY+bEWo2L3uMK4bPPEmhhl+VspUXvEIkVDePGX42Cn13Kh2eq6pb0g9nFUKzn1QVngLTILCa5vGz+wg32Op+cNfCmJL4lskxnvDKOYhrUGI+Z7kxQK6M/A3RkmgTb4tXybGd7FVjEIGYpw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(2906002)(66899021)(41300700001)(316002)(5660300002)(44832011)(52536014)(38070700005)(8676002)(8936002)(33656002)(55016003)(86362001)(9686003)(6506007)(26005)(478600001)(7696005)(71200400001)(83380400001)(64756008)(186003)(38100700002)(6916009)(4326008)(66446008)(66476007)(66556008)(66946007)(122000001)(54906003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWNDQ21mZldQS3Irb1gwY09yL2h3Q2dYMENWeHpWSndab2pSOHpyc1l2bW5W?=
 =?utf-8?B?WFZHK1B1YUdGYUNsdnNmVlpTeFVyNEtGTEVKMmVncDliVEI1Z0QxVHhmTGs2?=
 =?utf-8?B?ZjdLZXlxUVlSRlFrMW45OHp6UllnajJSUzdrTmJ4RVB6Y1dKNHUvTC8wWFo2?=
 =?utf-8?B?QktCN0Q5N2prVERCcENYa0MycmxWc1ZuQmdYNUh5RjU4TTFJVy9uL09IOTNP?=
 =?utf-8?B?bm9IcmJ2VjF4VTlLbWtuUVFaTEg2cVNST1VYd2ZDWnl4Z010UDFGVktyMmFT?=
 =?utf-8?B?clM4ZzBaSUlYOW1BU285TU1SUy9iS0JsVjJZTzhDbVZBMjNTOEhNbytyNFIr?=
 =?utf-8?B?QjNxZjloenRLK25nOVZVWE5lakp3S2pSMVg5REtzelFvdmtiRDNEM0FyTk9O?=
 =?utf-8?B?aWFxY1pQNXdRU3lDZVR0Vi9KbTVDaFRzUHdPZlZFdENUMElvRE41M2ZiTGd3?=
 =?utf-8?B?amZyRjBBM1plbHpINlhHbkFLUHJwSVBybTJqM0M4Z1lrd3VFRE1KZjFrN2c3?=
 =?utf-8?B?NGQ1TFpDbGJpVjZUQTZqc21iNWFHeUpNRnp5NlBQN0Jtd2FodGVRZjhtMXlZ?=
 =?utf-8?B?a2dhQitESURIaVlIeWE4NnpSeUZ6VXFiL0VQNC9tRWlDZk5LRVlvTDNPUTlL?=
 =?utf-8?B?WkdJaVdpdi9DUzI1SHVEWG4rRysrS0ducVViZUovUHNRUjhmbXgxaHBSUGZE?=
 =?utf-8?B?Q0FNOTMvSm5NL0tZNk5CZVFaTkQ5Z1UvNkVVVUJBSHo2MTRiUGh2TUg4azQ3?=
 =?utf-8?B?Q3lvWWs1VnpXQUhabEFiMzBKVWcxeFJUNnE3YTRrYkxHdytCSzJEUnBEMm84?=
 =?utf-8?B?Y2pZY3VWL3NrWkpPSE03akFJZGMzZ0JtL1N6SGw3aUpDQngxc1VQVnFZeWMw?=
 =?utf-8?B?QnN0ZTJ3cnJSYnE1V0Z2c0ZVUXRhbnB6U3FxekhjS2Y2VTV1SWtyTUlvNnJq?=
 =?utf-8?B?bVAwcnpZSm9ENE5hQW9qYmNSbWEyazNod3BTTnBSSVhJVWp3MWlTN2pjV3g4?=
 =?utf-8?B?Z25yd05TMTlnL05aZVk0SVV6Y3M5RTd5MkxkeGxhRFlyVll5TkRZSmNiZnR2?=
 =?utf-8?B?b0R4QkVyMlNUZVBETUZqSG54a3JMeGo4ME1wNm1ySlhha2hDWFB3aDZlR0wr?=
 =?utf-8?B?NXZrUjM4NnVtbmNLWjFudkRKMk52MFlnQ1M3UmZScVFaVDhGRUQxSEpwd0Ja?=
 =?utf-8?B?WjdES3kzdklUSGxGY1BCQXp4bFpaK1JqcEFtQnRrTHY0N215VVVKRDBXZGJJ?=
 =?utf-8?B?d0dKbzdQUVJsMVNRV3JtbWpSaEZWNG5LbW4yeEEvMnQ5cXVIem1ZOWtSak1z?=
 =?utf-8?B?YlNEYlBCYWYyVHVKUEhsaytnVi9VL1FkQUhrWGpVUEkwdkVvNXVqRDVoRWJw?=
 =?utf-8?B?dzRreG92M3VnMlczUEpvMWdQaWtDci9kVitmcC9ob1MvVHdhZk9Vcm9mVUhw?=
 =?utf-8?B?RitZUllsdmErbWF4NmpPcVd1aWlKeEtTalRTTSs5YTJPbTZOc2o5b2N4WUUx?=
 =?utf-8?B?Q2xBd0xhRlkxaWV5VWxqcUJhK2hhS2tCK2NEU0YyZUM1NUVMcXpuMm00TkN5?=
 =?utf-8?B?ZUxSNnEvbU96TkxSeXIxSGRXUjV6bnRoWTR5NFk5R1V6NDRGT2VaNmMzYjJj?=
 =?utf-8?B?V1FhMzR2SUd3TWRLUW1vRElUd0l4Ym5oZFYvR1dZaDZpdUNuc1F2K2tPV3Zk?=
 =?utf-8?B?K3Avb29vOXJ6TlFmZG9WT0hMaWxxbGZuQ20zbXRYSGN5L1JOKzdVUHlYSTN2?=
 =?utf-8?B?bkw0Mk5JWXRBblY4ZEpWc2VaT2oxYTZTdGhYZms2TnpJVS9ud3RoMmhxNHBy?=
 =?utf-8?B?R0RuckhYU1QyNUROazRFSXNkbDExT1dBMTlJcHF1SmxkdjBkb3VPTnJVaU4w?=
 =?utf-8?B?aldpZjRkM0wxZm55UFJhVlQ0ZVRtZHZ3R1MxYkZyWGQ0dUVEL0ovcGpZMDFx?=
 =?utf-8?B?czNjSFhFT1ZUL2xZS3FUR0hGblNaMUpMbk15WTVkOGxQSjNqbkd5ODBHRkJv?=
 =?utf-8?B?UVE4cituV2hlS0JseENDb2crcUdHancyb1lKK0pDZWZzOVJ0VGd3TG5ud2NW?=
 =?utf-8?B?d0E1VC93VEJMZm5MV3VOazlHVUJsbDMwNHdVTmdqQkxSbzNkcDNTaHRvNjJy?=
 =?utf-8?Q?H+tI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4914970d-13e0-47ea-3bcd-08db8e4660e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 02:08:32.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuB8mdc9dvxy5CsSO6oUvywRQqRZEm3fVqF6qnajnPnpeImUmUzvSIVdtljkEkGiUM93byug4j3jNIHUTuR0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8560
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gVGhpcyBzdGF0ZW1lbnQgaXNuJ3QgY29ycmVjdC4gVGhlcmUgYXJlIG5hcGkgZW5hYmxl
ZCBhbmQgbm9uLW5hcGkNCj4gPiA+IHZlcnNpb25zIG9mIHRoZXNlIGNhbGxzLiBUaGlzIGlzIHRo
ZSByZWFzb24gZm9yIHRoaW5ncyBsaWtlIHRoZQ0KPiA+ID4gImFsbG93X2RpcmVjdCIgcGFyYW1l
dGVyIGluIHBhZ2VfcG9vbF9wdXRfZnVsbF9wYWdlIGFuZCB0aGUNCj4gPiA+ICJuYXBpX2RpcmVj
dCIgcGFyYW1ldGVyIGluIF9feGRwX3JldHVybi4NCj4gPiA+DQo+ID4gPiBCeSBibG9ja2luZyBv
biB0aGVzZSBjYXNlcyB5b3UgY2FuIGVuZCB1cCBoYW5naW5nIHRoZSBUeCBxdWV1ZSB3aGljaCBp
cw0KPiA+ID4gZ29pbmcgdG8gYnJlYWsgbmV0cG9sbCBhcyB5b3UgYXJlIGdvaW5nIHRvIHN0YWxs
IHRoZSByaW5nIG9uIFhEUA0KPiA+ID4gcGFja2V0cyBpZiB0aGV5IGFyZSBhbHJlYWR5IGluIHRo
ZSBxdWV1ZS4NCj4gPiA+DQo+ID4gPiBGcm9tIHdoYXQgSSBjYW4gdGVsbCB5b3VyIGRyaXZlciBp
cyB1c2luZyB4ZHBfcmV0dXJuX2ZyYW1lIGluIHRoZSBjYXNlDQo+ID4gPiBvZiBhbiBYRFAgZnJh
bWUgd2hpY2ggZG9lc24ndCBtYWtlIHVzZSBvZiB0aGUgTkFQSSBvcHRpbWl6YXRpb25zIGluDQo+
ID4gPiBmcmVlaW5nIGZyb20gd2hhdCBJIGNhbiB0ZWxsLiBUaGUgTkFQSSBvcHRpbWl6ZWQgdmVy
c2lvbiBpcw0KPiA+ID4geGRwX3JldHVybl9mcmFtZV9yeC4NCj4gPiA+DQo+ID4gU28geW91IG1l
YW4gaXQgaXMgc2FmZSB0byB1c2UgeGRwX3JldHVybl9mcmFtZSBubyBtYXR0ZXIgaW4gTkFQSSBj
b250ZXh0DQo+ID4gb3Igbm9uLU5BUEkgY29udGV4dD8gQW5kIHhkcF9yZXR1cm5fZnJhbWVfcnhf
bmFwaSBtdXN0IGJlIHVzZWQgaW4gTkFQSQ0KPiA+IGNvbnRleHQ/IElmIHNvLCBJIHRoaW5rIEkg
bXVzdCBoYXZlIG1pc3VuZGVyc3Rvb2QsIHRoZW4gdGhpcyBwYXRjaCBpcyBub3QNCj4gbmVjZXNz
YXJ5Lg0KPiANCj4gQWN0dWFsbHkgYWZ0ZXIgdGFsa2luZyB3aXRoIEpha3ViIGEgYml0IG1vcmUg
dGhlcmUgaXMgYW4gaXNzdWUgaGVyZSwNCj4gYnV0IG5vdCBmcmVlaW5nIHRoZSBmcmFtZXMgaXNu
J3QgdGhlIHNvbHV0aW9uLiBXZSBsaWtlbHkgbmVlZCB0byBqdXN0DQo+IGZpeCB0aGUgcGFnZSBw
b29sIGNvZGUgc28gdGhhdCBpdCBkb2Vzbid0IGF0dGVtcHQgdG8gcmVjeWNsZSB0aGUNCj4gZnJh
bWVzIGlmIG9wZXJhdGluZyBpbiBJUlEgY29udGV4dC4NCj4gDQo+IFRoZSB3YXkgdGhpcyBpcyBk
ZWFsdCB3aXRoIGZvciBza2JzIGlzIHRoYXQgd2UgcXVldWUgc2ticyBpZiB3ZSBhcmUgaW4NCj4g
SVJRIGNvbnRleHQgc28gdGhhdCBpdCBjYW4gYmUgZGVmZXJyZWQgdG8gYmUgZnJlZWQgYnkgdGhl
DQo+IG5ldF90eF9hY3Rpb24uIFdlIGxpa2VseSBuZWVkIHRvIGxvb2sgYXQgZG9pbmcgc29tZXRo
aW5nIHNpbWlsYXIgZm9yDQo+IHBhZ2VfcG9vbCBwYWdlcyBvciBYRFAgZnJhbWVzLg0KPiANCkFm
dGVyIHJlYWRpbmcgeW91ciBkaXNjdXNzaW9uIHdpdGggSmFrdWIsIEkgdW5kZXJzdGFuZCB0aGlz
IGlzc3VlIGEgYml0IG1vcmUuDQpCdXQgd2UgYXJlIG5vdCBzdXJlIHdoZW4gdGhpcyBpc3N1ZSB3
aWxsIGJlIGZpeGVkIGluIHBhZ2UgcG9vbCwgY3VycmVudGx5IHdlDQpjYW4gb25seSB0b2xlcmF0
ZSBhIGRlbGF5IGluIHNlbmRpbmcgb2YgYSBuZXRwb2xsIG1lc3NhZ2UuIFNvIEkgdGhpbmsgdGhp
cyBwYXRjaA0KaXMgbmVjZXNzYXJ5LCBhbmQgSSB3aWxsIHJlZmluZSBpdCBpbiB0aGUgZnV0dXJl
IHdoZW4gdGhlIHBhZ2UgcG9vbCBoYXMgZml4ZWQgdGhlDQppc3N1ZS4gSW4gYWRkaXRpb24sIGFz
IHlvdSBtZW50aW9uZWQgYmVmb3JlLCBuYXBpX2NvbnN1bWVfc2tiIHNob3VsZCBiZQ0KdXNlZCB0
byBpbnN0ZWFkIG9mIGRldl9rZnJlZV9za2JfYW55LCBzbyBJIHdpbGwgaW1wcm92ZSB0aGlzIHBh
dGNoIGluIHZlcnNpb24gMi4NClRoYW5rcy4NCg==
