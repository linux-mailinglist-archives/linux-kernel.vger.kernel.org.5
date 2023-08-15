Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF477CAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjHOJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjHOJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:59:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEC71986
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:58:59 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-227-vdxOefj1NCKEtYViSq1POw-1; Tue, 15 Aug 2023 10:58:57 +0100
X-MC-Unique: vdxOefj1NCKEtYViSq1POw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 10:58:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 15 Aug 2023 10:58:54 +0100
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
Thread-Index: AQHZy2pYqz0YrpkIvk2kVFpZOdRD+K/rJqDQ
Date:   Tue, 15 Aug 2023 09:58:54 +0000
Message-ID: <83824aca89a148bd861e8eccef54bf44@AcuMS.aculab.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley> <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com> <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley> <ZNI5f+5Akd0nwssv@smile.fi.intel.com>
 <ZNScla_5FXc28k32@alley>
 <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
In-Reply-To: <67ddbcec-b96f-582c-a38c-259234c3f301@rasmusvillemoes.dk>
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

RnJvbTogUmFzbXVzIFZpbGxlbW9lcw0KPiBTZW50OiAxMCBBdWd1c3QgMjAyMyAxMDowOQ0KLi4u
DQo+IFdlIHJlYWxseSBoYXZlIHRvIHN0b3AgcHJldGVuZGluZyBpdCdzIG9rIHRvIHJlbHkgb24g
aGVhZGVyIGEuaA0KPiBhdXRvbWF0aWNhbGx5IHB1bGxpbmcgaW4gYi5oLCBpZiBhIC5jIGZpbGUg
YWN0dWFsbHkgdXNlcyBzb21ldGhpbmcNCj4gZGVjbGFyZWQgaW4gYi5oLiBbT2YgY291cnNlLCB0
aGUgcmVhbGl0eSBpcyBtb3JlIGNvbXBsaWNhdGVkOyBlLmcuIHdlDQo+IGhhdmUgbWFueSBjYXNl
cyB3aGVyZSBvbmUgbXVzdCBpbmNsdWRlIGxpbnV4L2Zvby5oLCBub3QgYXNtL2Zvby5oLCBidXQN
Cj4gdGhlIGFjdHVhbCBkZWNsYXJhdGlvbnMgYXJlIGluIHRoZSBhcHByb3ByaWF0ZSBhcmNoLXNw
ZWNpZmljIGZpbGUuDQo+IEhvd2V2ZXIsIHdlIHNob3VsZCBub3QgcmVseSBvbiBsaW51eC9iYXIu
aCBwdWxsaW5nIGluIGxpbnV4L2Zvby5oLl0NCg0KSU1ITyAoZm9yIHdoYXQgaXQgbWF0dGVycykg
aXQgd291bGQgYmUgYmV0dGVyIHRvIGZvY3VzIG9uIHdoeQ0KI2luY2x1ZGUgPGNkZXYuaD4gcHVs
bHMgaW4gYXJvdW5kIDM1MCBvdGhlciBoZWFkZXJzIChsb29rIGF0DQphIC5kIGZpbGUpIHRoYXQg
d29ycnkgYWJvdXQgbW92aW5nIGEgZmV3IGZpbGVzIGludG8gYSBuZXcNCidsZWFmJyBoZWFkZXIg
ZnJvbSBzb21ld2hlcmUgdGhhdCBwcmV0dHkgbXVjaCBldmVyeXRoaW5nIGhhcw0KdG8gaW5jbHVk
ZSBhbnl3YXkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

