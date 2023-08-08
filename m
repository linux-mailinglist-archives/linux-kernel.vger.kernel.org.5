Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDD9774451
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjHHSQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjHHSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:16:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2BB7C70A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:23:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-188-r8ab3m5YOcmwDLBl3hsptA-1; Tue, 08 Aug 2023 12:17:52 +0100
X-MC-Unique: r8ab3m5YOcmwDLBl3hsptA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 8 Aug
 2023 12:17:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 8 Aug 2023 12:17:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Thread-Topic: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Thread-Index: AQHZyWXSqz0YrpkIvk2kVFpZOdRD+K/gPfNw
Date:   Tue, 8 Aug 2023 11:17:49 +0000
Message-ID: <96476d194c324092807a1c49f42d44bb@AcuMS.aculab.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <fdd7eb5d-2b76-d326-f059-5cdf652b5848@rasmusvillemoes.dk>
In-Reply-To: <fdd7eb5d-2b76-d326-f059-5cdf652b5848@rasmusvillemoes.dk>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFzbXVzIFZpbGxlbW9lcw0KPiBTZW50OiAwNyBBdWd1c3QgMjAyMyAyMDozMg0KLi4u
DQo+IE5vLCBwbGVhc2UuIExldCdzIGhhdmUgYSBzZXBhcmF0ZSBoZWFkZXIgZm9yIHRoZSBmdW5j
dGlvbnMgZGVmaW5lZCBpbg0KPiB2c3ByaW50Zi5jLiBXZSByZWFsbHkgbmVlZCB0byB0cmltIG91
ciBoZWFkZXJzIGRvd24gdG8gc29tZXRoaW5nIG1vcmUNCj4gbWFuYWdlYWJsZSwgYW5kIHN0b3Ag
aW5jbHVkaW5nIGV2ZXJ5dGhpbmcgZnJvbSBldmVyeXdoZXJlIGp1c3QgYmVjYXVzZQ0KPiAkdGhp
cyBsaXR0bGUgbWFjcm8gbmVlZHMgJHRoYXQgbGl0dGxlIGlubGluZSBmdW5jdGlvbi4NCg0KVGhl
IHByb2JsZW0gSSBzZWUgaXNuJ3QgdGhpbmdzIGxpa2Uga2VybmVsLmggZGVmaW5pbmcgYSBmZXcg
J2xpYnJhcnknDQpmdW5jdGlvbnMsIGJ1dCBkZWVwIG5lc3RlZCBpbmNsdWRlcyB0aGF0IG1lYW5z
IHRoYXQgcHJldHR5IG11Y2ggYWxsDQpvZiB0aGUgaGVhZGVycyBnZXQgcHVsbGVkIGludG8gYWxs
IHRoZSBjb21waWxlcy4NCg0KU29tZSBuZXN0ZWQgaW5jbHVkZXMgc2VxdWVuY2VzIGNhbiBnbyB0
aHJvdWdoIGFuICJhc20iIGhlYWRlcg0KdGhhdCB5b3UgbWlnaHQgZXhwZWN0IHRvIGJlIGFyY2hp
dGVjdHVyZSBzcGVjaWZpYyBzdHVmZiBhbmQgdGhlbg0KaW5jbHVkZSBzb21ldGhpbmcgbGlrZSBp
b2N0bC5oLg0KDQpBZGQgc29tZXRoaW5nIGxpa2UgI2RlZmluZSBJT19XUiBAQEAgdG8gdGhlIHRv
cCBhIEMgZmlsZQ0KYW5kIHRoZW4gc2VlIHdoZXJlIHRoZSBjb21waWxlciBmaW5kcyB0aGUgZHVw
bGljYXRlIGRlZmluaXRpb24uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

