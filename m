Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D48D790DE6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346410AbjICUfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjICUfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:35:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6930B7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 13:35:19 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-CzOjeswJO8yAAEC46q-vxw-1; Sun, 03 Sep 2023 21:35:15 +0100
X-MC-Unique: CzOjeswJO8yAAEC46q-vxw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Sep
 2023 21:35:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 3 Sep 2023 21:35:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
CC:     Willy Tarreau <w@1wt.eu>,
        =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        "Michael William Jonathan" <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 1/4] tools/nolibc: x86-64: Use `rep movsb` for
 `memcpy()` and `memmove()`
Thread-Topic: [RFC PATCH v2 1/4] tools/nolibc: x86-64: Use `rep movsb` for
 `memcpy()` and `memmove()`
Thread-Index: AQHZ3ZooSNK38KJqFk6RryGRuLBUqLAJj8Bw
Date:   Sun, 3 Sep 2023 20:35:06 +0000
Message-ID: <0f885fa14710453c9512315d6cfeee35@AcuMS.aculab.com>
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
 <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org>
 <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
 <ZPLR+mO/6/V7wjAJ@biznet-home.integral.gnuweeb.org>
 <20230902062237.GA23141@1wt.eu>
 <ZPLYRENvjAub3wq5@biznet-home.integral.gnuweeb.org>
 <CAOG64qOuAfHREhcsC3THmhvH+NjhZRJtxp8gG39NosdhbZQvLA@mail.gmail.com>
 <4459ed19-f603-b4f6-392e-4e1322e06d56@gnuweeb.org>
In-Reply-To: <4459ed19-f603-b4f6-392e-4e1322e06d56@gnuweeb.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW1tYXIgRmFpemkNCj4gU2VudDogMDIgU2VwdGVtYmVyIDIwMjMgMTM6MzcNCj4gT24g
MjAyMy8wOS8wMiDljYjlvow3OjI5LCBBbHZpcm8gSXNrYW5kYXIgU2V0aWF3YW4gd3JvdGU6DQo+
ID4gT24gU2F0LCBTZXAgMiwgMjAyMyBhdCAxOjM44oCvUE0gQW1tYXIgRmFpemkgd3JvdGU6DQo+
ID4+IE9rLCBJJ2xsIGRvIHRoYXQuDQo+ID4NCj4gPiBBbm90aGVyIG1pY3JvLW9wdGltaXphdGlv
bi4gU2luY2UgdGhlIGxpa2VseSBjYXNlIGlzIHRoZSBmb3J3YXJkIGNvcHksDQo+ID4gbWFrZSBp
dCB0aGUgY2FzZSB0aGF0IGRvZXNuJ3QgdGFrZSB0aGUganVtcC4NCj4gPg0KPiA+IFBzZXVkbyBD
Og0KPiA+IGlmICh1bmxpa2VseShkc3QgLSBzcmMgPCBuKSkNCj4gPiAgICAgICAgICBiYWNrd2Fy
ZF9jb3B5KCk7DQo+ID4gZWxzZQ0KPiA+ICAgICAgICAgIGZvcndhcmRfY29weSgpOw0KPiANCj4g
UG9pbnQgdGFrZW4uDQoNCkkgYmVsaWV2ZSBpdCBtYWtlcyBhbG1vc3Qgbm8gZGlmZmVyZW5jZS4N
CkknbSBzdXJlIEkgcmVhZCB0aGF0IG1vZGVybiAoSW50ZWwgYXQgbGVhc3QpIGNwdSBuZXZlciBk
bw0Kc3RhdGljIGJyYW5jaCBwcmVkaWN0aW9uLg0KU28gJ2NvbGQgY2FjaGUnIHRoZXJlIGlzIDUw
JSBjaGFuY2Ugb2YgdGhlIGJyYW5jaCBiZWluZyB0YWtlbi4NCk5vdGhpbmcgdGhlIGNvbXBpbGVy
IGNhbiBkbyB3aWxsIGFmZmVjdCBpdC4NCk9UT0ggaGF2aW5nDQoJaWYgKGxpa2VseShkc3QgLSBz
cmMgPj0gbikpDQoJCWZvcndhcmRzKCk7DQoJZWxzZQ0KCQliYWNrd2FyZHMoKTsNCihhbmQgaW4g
dGhhdCBvcmRlcikgcHJvYmFibHkgbWFrZXMgdGhlIGNvZGUgYSBiaXQgZWFzaWVyIHRvIHJlYWQu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

