Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D8757B93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGRMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjGRMNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:13:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D9BD;
        Tue, 18 Jul 2023 05:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBnWCk4iySlL5XA5hgEZ0a4Z81wHjLwt/ZfQN7WkXYwe6QcWMhoqO2pW1zNn84fXOd0YOgXrH7TxjGpuUStl+9GzOIFw7TvaTEohUAwtm6hoBtd5zUAJpnI3u/7BfqmYD46vQZeHWR+YxSfC27sMX0T1MiLLvpDdrZ0aEnO26JCthEoQff9/vG1/dbGnuhE5SSoiazANrT6aGe9+SMcEXqtnGyyXg1NKv1sxkNvWn44F3dkrZsa1AObh/Ct9+TWU64FNpxJD0wUhsD1p/KwYNFb0ewa00lDJpkWYF5ukzy6vg+J26NaILgNL67TWUrhRrwbsuDTY/pUAPFLjWYAPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMlbKwv7KeW6RaS48LfLSIz+xKmpcATJUYxPL0xb5Pg=;
 b=Go/yIKrz1xxT2JIH1WdsgYp5mYHSXgW7K+ZZHRD8RDFi8NkDlk4YwUWHnY2VWHMP4YCzwi3zecgcI3jCGMyIhVpN3KWg1SrAbn/FAAz8tfB1vVyY/EGN/bkeJ3tIsDKKLyXiEOa5DaMOlK8rKlcXD8DsypCfvfWCyihn8ZKXJLVPCaV2SFWEBh8q25tHkaB2et+p2Guyln6XBSBqikOml/kEj8h0IIL3kqrRokZadLe5Bkve5Pkf0Zdi1xaTjDexsAI/JkH7arIXNrz960JW5xDUAE7R5HUbuM/eQhBeymLSqDp6QjxIdQG+lkW5sDQvDqHYGe9RupJ9mn3BCM8WXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMlbKwv7KeW6RaS48LfLSIz+xKmpcATJUYxPL0xb5Pg=;
 b=X6AX6m5M509PXJrxA1MMVJBpxkEKMUk+n9WSf7Lk7/D1GqoIl4N9rS0XV08noJXSp2RPQGQQqg1zlXd1/geUcMs1zpxFbRZC+4mF0g9xOvl716cenItaNVz8Lbbz9HhiIZdIhJsFjnFCXUxF2nAKcsUBZ6k42z3c7Ir9OZYoYic=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB11335.jpnprd01.prod.outlook.com (2603:1096:400:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 12:13:01 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 12:13:01 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Index: AQHZuULZAAUI+Oq1mUSjty3QZPTfk6+/b6ug
Date:   Tue, 18 Jul 2023 12:13:01 +0000
Message-ID: <TYWPR01MB877550F95CF000B63E9AD022C238A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
In-Reply-To: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB11335:EE_
x-ms-office365-filtering-correlation-id: 57f9e4a1-e29d-4964-455e-08db87885532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Fr0v765G9jl3yV5ERufohy/TFVNl7+hXMrQx0k0aKNJZyVqg+uC3D8rbgAheLdEeaBDiWIIBpc9/3hwMpfu0O/CtXRFY2w2B/R9HaV6XckBAFXMgbScN6GzXI0r4TZo4mj+OUVh824U7ktttzRlax+5YxTAhejuPeJZNTcdbLWqg9fLpf4fJFklZf4WkXSvazw5ouZOC3D3O9JxyqjpcAhp7n4jPKlXFkLB/6EhP+H84wgWyh8X8Vpu7+AkQPdBMVkA/z1hgfnoJU77m7hga/tC1C6J19toHyOQHs31paEqXTu+pM3IYGNL3uiZfGCZc+uohT4CJO/7PRm91KwT7ib/kaRsnQIxLXf5Vn143TUOVaABWPsAWW2XxytqbBjLameVANyIdbO+5QUTXMv1tEnO2/sHSo+6naGjGFpSF2LSo33kz/5SOwoTeLFXnHTMMEhHP803LkB0Aa0nw8HM5IUU+XUs4A6jhxPTh5Y05ZVZFCi71sINBhp0bof+i2QakEZJuE93RdcPC62oncsXbbJY8E4dsppSbDBeyygaktIwoYnrNu5kMRadzjc1096PUpjOXoVcxFVXVYKarryZExGNIYkKOo7i5rmw4qZkNU3y0RJdMJ5ivDRSh1uVXIx/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(38070700005)(38100700002)(8936002)(8676002)(33656002)(83380400001)(2906002)(66574015)(52536014)(6506007)(5660300002)(55016003)(122000001)(186003)(66446008)(64756008)(86362001)(76116006)(66946007)(4326008)(66476007)(66556008)(54906003)(110136005)(7696005)(71200400001)(41300700001)(478600001)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDJrQ1ZRTXN6SlNZWTJKb1kxeWwxMlVLZTNHdGRDY1d6MktPY3hSSzhvOG1Y?=
 =?utf-8?B?aWZoZURjSWVkNFNVcEx3ZDN3TmY0RGNhampRdDhDeUUvbXJCQlhYeENIb24y?=
 =?utf-8?B?Vkk3RWdrVC9qOXozeE1XaTdxeUVYeVR4VHpQWkZ0MXZHUnZLbDRjMlk5TGF5?=
 =?utf-8?B?VndER01DT2RtSnFZbE9yYVkrRzRLUE5MeUZZdkVvWHd4c2ZsTUdNZ0ZzcXFZ?=
 =?utf-8?B?TmNZR3kyY1BXdTNzbmY3SGg4eVRQOUZuUXFzU3RXakpMWHJuT3dWU3BwMDlH?=
 =?utf-8?B?MjRxcUorMlNJcHh0S1lENk4wNWlRQ0h2ZWRLMEJUdTNtYXVrNHNwOW1JaVpz?=
 =?utf-8?B?TSt0WHdqSGk5cjRjOFZhb3VSMTgrcXBhUExxVXc1VnhlUHBRQVhZODVuRVEv?=
 =?utf-8?B?U1RKNDMrQnNmU3Awc0kyNlNiUTlQVDVlMG5BclZUNEU3elJDU0NwQy90M1NJ?=
 =?utf-8?B?MHNIdmFkQ3M2TkN4VkVyRWNNc1NnNVdxcEtzWGFGaU13a1VvRVMxc2huY0Fv?=
 =?utf-8?B?cFhHdEFyN3RMaEdpWC9Sb3pjeTVIL3FJdUlQSlZOeVdoT2lzNkRLbG84SVoy?=
 =?utf-8?B?UFpySUJuZlNadTlsZ2JlUWdYbERYbG9GTVcvYTh5YlQ0K1lzenBZNFhIVHVQ?=
 =?utf-8?B?bk5VdjFzSVJEME92bFF5TVdZcXMxUWxkUjVJT2hkWVp0WWlpRWF4Q3dZbW9R?=
 =?utf-8?B?a1Y2UXZMVlVHeUdYZVVWalJibFEwc1JrZkxjUEpPRUw4UnkyaEhKWkVrNElo?=
 =?utf-8?B?QlpPczFUazEzQlU4ZnE2OFo5SEFlaUdJSm9remNjeVdnYk9NTndFWEQxUXpk?=
 =?utf-8?B?YXlHTURLTkF0SDVPdEF3TkgvNDA0aGR5ZG8zdElhaUFiZHEyR2JJR2VCeVhQ?=
 =?utf-8?B?bUQzdUs4V2p3b21EbG5nODBqM3F1QVVrVFJzRDdnaWlSNnZQT3JDNnlTazd5?=
 =?utf-8?B?eXRLdFJjeHhmTS94c3hVSDBIRVVxZzFPbDBpVWNSNGdveXdXV3Q3ZzJNVVlk?=
 =?utf-8?B?QU9RQUVyT0VJNkRIb3VqSC9jWHhUSm1ibG85STZlVW0zZzJXZk5DYXg4YXFQ?=
 =?utf-8?B?cVI5azdCT3d6eXhVVEUyeDBjT3dBa0tBN1VhWnI5c0Q2WG1HaUZTOThpVnk0?=
 =?utf-8?B?SUVlZUhGNzFkaG9GQUtzNU5HMXZObG11WTMxVGlmcjNFeFdCQ3l6d0t0eWZn?=
 =?utf-8?B?ZzZpcUE1N09LeCsyWDhuaGhTQnN2Wkpod2prRVpCL0hranFETWVWQUtuQ091?=
 =?utf-8?B?Zi8wSi9Rb1hNZVAvTThUcFp3eDFaYUlUZG55TUdZWGE0c1Q4ZnJmaTFPNGtR?=
 =?utf-8?B?bjBMUVNCT2Zna0pMOWI3aXdaQ1N6T0ErT0JyLzMySWdhYkhpWHVVeE9xUVFU?=
 =?utf-8?B?VE1wc0wvNDJjcS82MkhNUGplZFZiWm9IdHlzdzhNYzBVTGtaYVFRQnhpZy9k?=
 =?utf-8?B?cCtZN1lWZ0tEUmlyODJjNXJ0dHpESW4yVVpnOG14a2hTMytxOFlGNCtMZVl5?=
 =?utf-8?B?K1BzU09RZmVKWDduTnEzOWs3eGtkV1h0UE95LzNDeWJhN0hmNHpoUU0vSnhP?=
 =?utf-8?B?cFBRS1JnZkR4Wm1IZHBDdFZjckcyaEFleCtBQ3BDS1RwbTFhWDBvckMyczVl?=
 =?utf-8?B?QkdwczFscVM2ZEpvYmkxMnVRZW4vdlhDSmw2OXZzMjkyWUhGR0M3Q1pML29v?=
 =?utf-8?B?S01FN0NQY0g0QVFPY3pjUGxYcTV5cHhmSXBRaHJxcTlBaWo3cjZjcFpTWFh4?=
 =?utf-8?B?YnlqcUFrZ1FmUHNOeHdIS0NEQmMrY2hoWXQraWdUK0pwcDJsRkVjV0x2NFlr?=
 =?utf-8?B?L0ZYcmY2cUlzajhmWDNFU0l5SVZ4TnkwNWhTb003NW1kQVp3WTBJYmVPMENQ?=
 =?utf-8?B?cklEUkFmVjJ5NE0wVTFFaE9DSnpmSGFuSkNoeHM0VFpEZWRuYXdIek1MN2dP?=
 =?utf-8?B?S3ExZkc0ajVwb1VVRi90TmswWVMyNmVZTWgrc2F6MDc2am5DeExJUEhtZFQ2?=
 =?utf-8?B?b3RPYzFpeW4rZ1FhTmxOWGlIY3JjY3IyZ0dsbjU2TTY3R3VRSENvSzRpUjVD?=
 =?utf-8?B?cmVkUWZ0RmZDU1o1cjg5b3JCdzdKYU04Wk5BZUdPUys3Y2hwNXg5OG5tbSth?=
 =?utf-8?Q?TJ7SY2OEhM/Qp+sc813kyAbbX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f9e4a1-e29d-4964-455e-08db87885532
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 12:13:01.7615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eACtQW4fgqifyreQ+i0snLJngI0wwhV0DZn2QQ87PXglPHCXcJPo02kw0Cr0aBFbQPZ0IRpRpt9smpRv9WKpCibyyUciUxl6nHZbCo7ThY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNCj4gRnJvbTogUmFuZHkgRHVubGFwIDxyZC5kdW5sYWJAZ21haWwuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIHB3bTogZml4IHB3bS1yei1tdHUzLmMgYnVpbGQgZXJyb3Jz
DQo+IA0KPiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkLmR1bmxhYkBnbWFpbC5jb20+DQo+IA0KPiBX
aGVuIChNRkQpIFJaX01UVTM9bSBhbmQgUFdNX1JaX01UVTM9eSwgdGhlcmUgYXJlIG51bWVyb3Vz
IGJ1aWxkDQo+IGVycm9yczoNCj4gDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9t
dHUzX3B3bV9jb25maWcnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjM3NDogdW5kZWZp
bmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M19kaXNhYmxlJw0KPiBsZDogZHJpdmVycy9wd20v
cHdtLXJ6LW10dTMuYzozNzc6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfOGJp
dF9jaF93cml0ZScNCj4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNfcHdtX3dy
aXRlX3Rncl9yZWdpc3RlcnMnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjExMDogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M18xNmJpdF9jaF93cml0ZScNCj4gbGQ6IHZt
bGludXgubzogaW4gZnVuY3Rpb24gYHJ6X210dTNfcHdtX2NvbmZpZyc6DQo+IGRyaXZlcnMvcHdt
L3B3bS1yei1tdHUzLmM6MzgyOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzXzhi
aXRfY2hfd3JpdGUnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV93
cml0ZV90Z3JfcmVnaXN0ZXJzJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoxMTA6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hfd3JpdGUnDQo+IGxkOiBk
cml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjExMTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBg
cnpfbXR1M18xNmJpdF9jaF93cml0ZScNCj4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYHJ6
X210dTNfcHdtX2NvbmZpZyc6DQo+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6Mzk3OiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGByel9tdHUzX2VuYWJsZScNCj4gbGQ6IHZtbGludXgubzogaW4g
ZnVuY3Rpb24gYHJ6X210dTNfcHdtX2Rpc2FibGUnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1
My5jOjI1OTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3dyaXRl
Jw0KPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyNjQ6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8NCj4gYHJ6X210dTNfZGlzYWJsZScNCj4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24g
YHJ6X210dTNfcHdtX2VuYWJsZSc6DQo+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MjMwOiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+IGxkOiBk
cml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjIzNDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBg
cnpfbXR1M184Yml0X2NoX3dyaXRlJw0KPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoy
Mzg6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfZW5hYmxlJw0KPiBsZDogdm1s
aW51eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21faXNfY2hfZW5hYmxlZCc6DQo+IGRyaXZl
cnMvcHdtL3B3bS1yei1tdHUzLmM6MTU1OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9t
dHUzX2lzX2VuYWJsZWQnDQo+IGxkOiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjE2MjogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3JlYWQnDQo+IGxkOiB2bWxp
bnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9yZWFkX3Rncl9yZWdpc3RlcnMnOg0KPiBk
cml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjEwMjogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBg
cnpfbXR1M18xNmJpdF9jaF9yZWFkJw0KPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzox
MDI6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hfcmVhZCcNCj4g
bGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MTAzOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
DQo+IGByel9tdHUzXzE2Yml0X2NoX3JlYWQnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9u
IGByel9tdHUzX3B3bV9nZXRfc3RhdGUnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjI5
NjogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3JlYWQnDQo+IA0K
PiBNb2RpZnkgdGhlIGRlcGVuZGVuY2llcyBvZiBQV01fUlpfTVRVMyBzbyB0aGF0IENPTVBJTEVf
VEVTVCBpcw0KPiBzdGlsbCBhbGxvd2VkIGJ1dCBQV01fUlpfTVRVMyBkZXBlbmRzIG9uIFJaX01U
VTMgaWYgaXQgaXMgYmVpbmcgYnVpbHQNCj4gYnV0IGFsc28gYWxsb3cgdGhlIGxhdHRlciBub3Qg
dG8gYmUgYnVpbHQuDQo+IA0KPiBGaXhlczogMjU0ZDNhNzI3NDIxICgicHdtOiBBZGQgUmVuZXNh
cyBSWi9HMkwgTVRVM2EgUFdNIGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxh
cCA8cmQuZHVubGFiQGdtYWlsLmNvbQ0KPiBDYzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiBDYzogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5n
dXRyb25peC5kZT4NCj4gQ2M6IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5j
b20+DQo+IENjOiBsaW51eC1wd21Admdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiB2MjogZml4IHR5
cG8gaW4gU3ViamVjdDsNCj4gICAgIGNvcnJlY3QgbXkgZW1haWwgYWRkcmVzcyB3aGlsZSBpbmZy
YWRlYWQub3JnIGlzIGRvd247DQo+IA0KPiAgZHJpdmVycy9wd20vS2NvbmZpZyB8ICAgIDMgKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tIGEvZHJpdmVycy9wd20vS2NvbmZpZyBiL2RyaXZlcnMvcHdtL0tjb25maWcNCj4g
LS0tIGEvZHJpdmVycy9wd20vS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL3B3bS9LY29uZmlnDQo+
IEBAIC01MDUsNyArNTA1LDggQEAgY29uZmlnIFBXTV9ST0NLQ0hJUA0KPiANCj4gIGNvbmZpZyBQ
V01fUlpfTVRVMw0KPiAgCXRyaXN0YXRlICJSZW5lc2FzIFJaL0cyTCBNVFUzYSBQV00gVGltZXIg
c3VwcG9ydCINCj4gLQlkZXBlbmRzIG9uIFJaX01UVTMgfHwgQ09NUElMRV9URVNUDQo+ICsJZGVw
ZW5kcyBvbiBDT01QSUxFX1RFU1QNCj4gKwlkZXBlbmRzIG9uIFJaX01UVTMgfHwgUlpfTVRVMz1u
DQoNCklzbid0IHRoaXMgYSB0YXV0b2xvZ3k/DQoNCkNoZWVycywNCkZhYg0KDQo+ICAJZGVwZW5k
cyBvbiBIQVNfSU9NRU0NCj4gIAloZWxwDQo+ICAJICBUaGlzIGRyaXZlciBleHBvc2VzIHRoZSBN
VFUzYSBQV00gVGltZXIgY29udHJvbGxlciBmb3VuZCBpbg0KPiBSZW5lc2FzDQoNCg==
