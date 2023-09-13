Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9F979E144
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbjIMH5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbjIMH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:57:42 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2125.outbound.protection.outlook.com [40.107.13.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2960F1729;
        Wed, 13 Sep 2023 00:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTYpFFxiNWTwiMUsMKuwyZCVoCkEJEBI4OWdXmGtZZ1jaK2eyTw5tArI+uoaV90+ifEJH+KvkzD51NzWQ7B4xWiMC6QM1T+1wctDCLE8VbSGNC3iiLuRXVFdIDsE9GKci+lG7OwARz6V7Qw0C76r/FqEkDZoQ/4PJJ8ImBOxKHsEvQ42xfcBo9SSKMu/n3CpimGRfuix4n03TZ2cOuPqX0RihDQcT9VpFE7fmruHoqRmPDxNaiK5IZpjnkHqAN3q5fDGwH4U4NsVSjLQhAvn6L3pC44AMwvrzG69QKcr+1XdBa1Y4hqcPstGuM7HqpDif+KGUZfy+9Z6fwvvLbcfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci7dLCswYu8CKQbPZShp+Yl7AIPuPKL4RocNfVN9OM8=;
 b=TE8oDidHfZf6zDSdX4qGzJwLsaNRgehysiCkTZtaUvQWwh1DoF8f+GMT6l3jBcKztB92rUSTscanaf2NFakMcA8k3KVfHQWzSSqC17Zx2M67Gi2tXvin4LBkx3ITDop01PAPxTUTbainJRuf6zbrtCcQYovXtg9l3ux6yDlKhJcQu/35YgpHvvnkRzDZXGswMO0Ma32j9XsqHy89gj8Hfm4eJwUxhepS8RVGIQrWC5dJwXgttErFE8PaKgocgL7O6qK4ai2IQFrToW3wZ+26atAOJZ7DNYz3UZ7u8GZmrQBV2ojgczDrPmt0eScs0VP34HjCfg39J8gAop0AzNnxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci7dLCswYu8CKQbPZShp+Yl7AIPuPKL4RocNfVN9OM8=;
 b=L5jpEm+NWFV+yCY5PQLN1dSzKB7B6R2IcHFo2ljkginIhAr4WCKmQnrDZuhZ+zkLv1PxCZsdbZsxByentIOUNZwdoVhx8rdUAlfpTf9CbQoLJCKUTKLlPP5GNeE5yjDVfjZ+1GeSRUCZ3R42+ui7jgKjVfm2vZ6WgettKWfBOcU=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS8PR03MB6693.eurprd03.prod.outlook.com (2603:10a6:20b:23d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 07:57:35 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::620a:c21c:f077:8069]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::620a:c21c:f077:8069%4]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 07:57:35 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: rtl8366rb: Implement setting up link
 on CPU port
Thread-Topic: [PATCH net-next] net: dsa: rtl8366rb: Implement setting up link
 on CPU port
Thread-Index: AQHZ5b+B7nfHdh7FE0OIMcAGIY3KmbAYZGkA
Date:   Wed, 13 Sep 2023 07:57:35 +0000
Message-ID: <gbo4gcfhjppnuctqj7tw34bb56g7xilkpvf44x2ufg4qs5gmnt@xwrydg5mo42p>
References: <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
In-Reply-To: <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS8PR03MB6693:EE_
x-ms-office365-filtering-correlation-id: ed827fed-83c6-46ef-fa2f-08dbb42f1771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzKVa5u81ecYpqFki5ouI0z+UKz6FztuQYuZWQ5GmRGKWSocMQDSPruyEg6hL9KX8uvfAUHXo8mE8WV/0jQaMpVmKTH5RK8YpVACztY3iulehpqWe0gYF4P91xJbe/gCtyJwt44alESfQn7CqmUJAPdDRVfdoNy6uae1qOIxr4fAI2H4PnhJmDXI04M+9GDlu05knzysUhLHdQpYuwo2NqrxiMt50wDXZe7fzBL1jXfYEzatD+qAUf85XNYVQTrYbsbT0x4j6CU8PZvahkwSzHvEsEr9SCshKT7vm0lBd1vXCzIb9UEux/CM9k93dI+S7QHIojRSozj0QVsJZHyrloZ2Efg0jYyS+NGHLPtdP9BvCQCWOcmjWX5hTw/+8eKqmxFhgrzBzSW8/d+14x81s2PRwVSRCKM9S4fKLoZa+7MPZzJPwuU6SviVZCo2tnqB4qsOou3xjXrjLeDZA54pU3Z4N2r4RG6S7VUBd0Of3dCSNTsnI8Gzc5E+iZa3N2phw7V1bEDwjOt4etz6aUP+Uor4K2lGfFJn/0vojEDBhWfrvUcIBYRhAXdco4sDucmmDwUU1bbDoAVf/nyzzPuqOEdxnsah7NYw5ovwcSwQCrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(39850400004)(396003)(1800799009)(451199024)(186009)(7416002)(2906002)(4744005)(85202003)(33716001)(86362001)(85182001)(122000001)(38100700002)(38070700005)(26005)(8936002)(8676002)(4326008)(71200400001)(6506007)(6486002)(41300700001)(66946007)(66556008)(66476007)(76116006)(54906003)(64756008)(66446008)(6916009)(91956017)(316002)(6512007)(9686003)(478600001)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk1XLytUNkx0S1ZvazNISGVEMTVsVG9yWFM1SW8wK1RlS0V1VE9ucGpwVmp6?=
 =?utf-8?B?WFJWNEkrUjY0ODJaMmtNNnpvcGFBSE0zK3VsbWJodm1iT1FmblloMWd0bXk3?=
 =?utf-8?B?Si8zR2Nhd2dXaXl4ZlkyNllEUzJxN3VucHZvNDdRbVdhcWdQRURVcmx1amRu?=
 =?utf-8?B?TWsrZnkrdjNlS0c0TW5ZU1Urc2trMklGSFI5SUdQcVpKemE1N0Fqek5ubS91?=
 =?utf-8?B?bTI5ZFlsSDMzNEoySXJyWWtoL3Badm1JaS8xUW83ZFNieDZpTEl3YmJuRVYx?=
 =?utf-8?B?c1J2dmpuOTI1NDZxVCt2T3FUVEhEZlBPS1g0N1FXbjArd1hRS0JVRTQ0dGVE?=
 =?utf-8?B?cVlVOW9iT2VFcjBJRUU4aEc4ZmhzOHZhSnVkV2JSMW5KNUxJOVM5Uml3bm16?=
 =?utf-8?B?NGI2THpTdERZK0t3U2s5V1lSWTZFZkdqVVdqUW5QU05YQ0FuSVU0T1poZXcx?=
 =?utf-8?B?NUpDOEVScDIwQmM4cVNBanBkYkgzaU5MYUg4SG5LQmxEb3IySUFTQmJtNVlq?=
 =?utf-8?B?eFp0Yk1OZ252Nmwxa3R3VFpLWnhCVG4xcUs0aFpscVVGRjRiQy9mQkVpcldy?=
 =?utf-8?B?T2NIMm8xU0lRZlVuZFN6SmtsMnB3NU8zVmlrMVJDZm1hTDNnT0R1dnp6Ykc1?=
 =?utf-8?B?bzZDQWdxOHhicnZiWjE0VkxVejFQRmFXNVFyYTgwUThLaGRIVFNQa3JmK0dx?=
 =?utf-8?B?UzFmU0YwMlRxWEJFQU9Na0VZYncxMnFzMVhGRUQ0TkYvM2xhay9rQkplTU9t?=
 =?utf-8?B?c2thWWZndzhzVVlGV0d3WXU2NU15UG5mbkJ6MDJNYlhsVGNUdmYxL2YwZDVU?=
 =?utf-8?B?SEFCS1V2UU5JcDg4eVcxRVc1N3B4clRZZ3B4bzRaRU5PZ25oRTRia3pYbHFQ?=
 =?utf-8?B?MmJxVThQNmIzQ2pTdXlXSHJHenMyQVZxcmU5YzVZZVZSRlBRZU1wVmpUNU4r?=
 =?utf-8?B?Mmt4VzQwRzEyKzBoSGJrQUR0UlprUlFhS3VhT2l5MGhLaklJRHNLQmVrbnRZ?=
 =?utf-8?B?OUt1UTV3VjlHa0d4ajFzTElWUTJyL3BWSDBaZ1BrOVphQ0hqWTVSeFRJVjhi?=
 =?utf-8?B?TU5SRy8vbGhSYWdmRnlhU3VKcVhUeThIS1Nlbm1jQnVKY1BlNGdMSFY3dTU2?=
 =?utf-8?B?THZDVlQ0WTVPNnJqSGVyektpU3J5eUNSU2w3ejhlZ2ZCRTExZXg5a0o3V2RS?=
 =?utf-8?B?aGRJMU9UR3ZxTFd0ZGlnTEprY2x1VkVhNkVBRjJUY3ZEbW9BREoraWdWU1Jy?=
 =?utf-8?B?UStMb015elYvQURjMG95bWVUQXk5dnhacUU2b3Y3VjBOeGdpVmxvZkgvR3Bj?=
 =?utf-8?B?MkpscGhZc2kxQjhBWG5taXVmNlpBTHl0WW16UXByWDJ6K3dJaXlLSHNTdnZi?=
 =?utf-8?B?L0hVeUUzUSs4N21WcW95MFNSRjh4ZWZHS3lNSDhvK2ZDWXRtL2E2Nlk1bXN4?=
 =?utf-8?B?dGdCV2pLdFQzZXBTbVlob0tnSGR2Rm5sRnRva2FLUlRvTmFlaWNYTmlsWlBp?=
 =?utf-8?B?WHZPbTkyT3FoQXczMURSRTRyanQ4NkFpaFN1RHZyc3hiSWNwOE1HRzJFNVcv?=
 =?utf-8?B?bWQrTkZFUjd3cnYyc08yTTJwLzZtbkhRbTlseDRDQWd6ZGh4UXFIc2l4eHRm?=
 =?utf-8?B?SDFjeXZGZnBZZ0NoVVJZYWhrcXo3bi9HSmhJZ1RrZjVHTzFUd2hYWiswTVNM?=
 =?utf-8?B?Tmw5SFZpZ3pTRUVXbGh4L3FnUWxWb09maDR3bFpXZTluTlJlYmt2d3kyOXFV?=
 =?utf-8?B?alY3VytEd05iY3BMUW13eTZCSlRBblhGZHlYRTk3MXc2QU9ud0wweUlMa1Bv?=
 =?utf-8?B?T3JmR0o3RE5QdGxHcE50NVZZeW1zMFpUZk9WdCt3TWdHMjNibVF2b2ZTWlJa?=
 =?utf-8?B?bnFweFhMNkFydUV0MFNxdm14OHpxOGNJZE15Y1BWczlVdVFQejZyWm5yL2or?=
 =?utf-8?B?WVhTNXRnVmJTNDBuRFNFcnNEWDcvZ3VUTDRQZm9ncTg5Qk5kOGpsNTFuajlh?=
 =?utf-8?B?VVZYblJRMmlCcCs0ZDVJN3Y0SHhobGdvWGc2S3EwNUZhcnBldTRNNFM5YVRV?=
 =?utf-8?B?L0oxSjkwc2pyRk9IWm10SmlPeDJaZWcySTgwWFZCTlY1ZXd0WTh3aEg4UFJB?=
 =?utf-8?B?ZXh0ZHZ0S2hjWVoxaDZPL2ZwM1lGckFybUZpUnAvKyt0dlArQzJCMHJ2Zncr?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6213D2419892248BCFAABED9C0B3125@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed827fed-83c6-46ef-fa2f-08dbb42f1771
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 07:57:35.2582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXPn+ROXawaj0cCu9NlPCLdhl5KorcEV1Jzg7+rI9S3009+/0YRTxU5DhUcvWniRLz+LGFA23/xGhb1wlEU4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6693
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTE6MjQ6MThQTSArMDIwMCwgTGludXMgV2FsbGVpaiB3
cm90ZToNCj4gV2UgYXV0by1uZWdvdGlhdGUgbW9zdCBwb3J0cyBpbiB0aGUgUlRMODM2NlJCIGRy
aXZlciwgYnV0DQo+IHRoZSBDUFUgcG9ydCBpcyBoYXJkLWNvZGVkIHRvIDFHYml0LCBmdWxsIGR1
cGxleCwgdHggYW5kDQo+IHJ4IHBhdXNlLg0KPiANCj4gVGhpcyBpc24ndCB2ZXJ5IG5pY2UuIFBl
b3BsZSBtYXkgY29uZmlndXJlIHNwZWVkIGFuZA0KPiBkdXBsZXggZGlmZmVyZW50bHkgaW4gdGhl
IGRldmljZSB0cmVlLg0KPiANCj4gQWN0dWFsbHkgcmVzcGVjdCB0aGUgYXJndW1lbnRzIHBhc3Nl
ZCB0byB0aGUgZnVuY3Rpb24gZm9yDQo+IHRoZSBDUFUgcG9ydCwgd2hpY2ggZ2V0IHBhc3NlZCBw
cm9wZXJseSBhZnRlciBSdXNzZWxsJ3MNCj4gcGF0Y2ggIm5ldDogZHNhOiByZWFsdGVrOiBhZGQg
cGh5bGlua19nZXRfY2FwcyBpbXBsZW1lbnRhdGlvbiINCj4gDQo+IEFmdGVyIHRoaXMgdGhlIGxp
bmsgaXMgc3RpbGwgc2V0IHVwIHByb3Blcmx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGludXMg
V2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1ieTogQWx2aW4g
xaBpcHJhZ2EgPGFsc2lAYmFuZy1vbHVmc2VuLmRrPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
ZHNhL3JlYWx0ZWsvcnRsODM2NnJiLmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSk=
