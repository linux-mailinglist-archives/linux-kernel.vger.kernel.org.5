Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5833C7AFD11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjI0HvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjI0HvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:51:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7F136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:51:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-2-N8jkFFD4PBCGXqs1E3rfLg-1; Wed, 27 Sep 2023 08:51:06 +0100
X-MC-Unique: N8jkFFD4PBCGXqs1E3rfLg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 27 Sep
 2023 08:51:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 27 Sep 2023 08:51:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexander Potapenko' <glider@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "pcc@google.com" <pcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "syednwaris@gmail.com" <syednwaris@gmail.com>,
        "william.gray@linaro.org" <william.gray@linaro.org>
Subject: RE: [PATCH v5 2/5] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Thread-Topic: [PATCH v5 2/5] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Thread-Index: AQHZ78BAIg64eZGtOEOamqyNsX1LerAuTYZg
Date:   Wed, 27 Sep 2023 07:51:05 +0000
Message-ID: <3bc8fda47dc04e3b8cfd0e3f6fc7bbee@AcuMS.aculab.com>
References: <20230922080848.1261487-1-glider@google.com>
 <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com>
 <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
In-Reply-To: <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
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

Li4uDQo+IE92ZXJhbGwsIHVubGVzcyBhbGxvY2F0aW5nIGFuZCBpbml0aWFsaXppbmcgYml0bWFw
cyB3aXRoIHNpemUNCj4gZGl2aXNpYmxlIGJ5IHNpemVvZihsb25nKSwgbW9zdCBvZiBiaXRtYXAu
YyBpcyB1bmRlZmluZWQgYmVoYXZpb3IsIHNvDQo+IEkgZG9uJ3QgdGhpbmsgaXQgbWFrZXMgbXVj
aCBzZW5zZSB0byBzcGVjaWZpY2FsbHkgdGVzdCB0aGlzIGNhc2UgaGVyZQ0KPiAoZ2l2ZW4gdGhh
dCB3ZSBkbyBub3QgZXh0ZW5kIGJpdG1hcF9lcXVhbCgpIGluIHRoZSBwYXRjaCBzZXQpLg0KDQpC
aXRtYXBzIGFyZSBhcnJheXMgb2YgdW5zaWduZWQgbG9uZy4NClVzaW5nIGFueSBvZiB0aGUgQVBJ
cyBvbiBhbnl0aGluZyBlbHNlIGlzIGEgYnVnLg0KU28gaXQgaXMgYWx3YXlzIHdyb25nIHRvIHRy
eSB0byBpbml0aWFsaXNlICdhIG51bWJlciBvZiBieXRlcycuDQpUaGUgc2l6ZSB1c2VkIGluIHRo
ZSBkZWZpbml0aW9uIG5lZWQgbm90IGJlIGEgbXVsdGlwbGUgb2YgOCAob24gNjRiaXQpDQpidXQg
dGhlIGFsbG9jYXRlZCBkYXRhIGlzIGFsd2F5cyBhIG11bHRpcGxlIG9mIDguDQoNCkFueSBjYWxs
cyB0byB0aGUgZnVuY3Rpb25zIHRoYXQgaGF2ZSBhIGNhc3Qgb2YgdGhlIGJpdG1hcA0KcGFyYW1l
dGVyIGFyZSBsaWtlbHkgdG8gYmUgYnVnZ3kuDQpBbmQgeWVzLCB0aGVyZSBhcmUgbG9hZHMgb2Yg
dGhlbSwgYW5kIG1hbnkgYXJlIGJ1Z2d5Lg0KDQpPbiBMRSB5b3UgbW9zdGx5IGdldCBhd2F5IHdp
dGggc2hvcnRlciBtZW1vcnkgYWxsb2NhdGlvbnMuDQpCdXQgc3RpbGwgZ2V0IGVycm9ycyB3aGVu
IHRyeWluZyB0byBkbyBsb2NrZWQgb3BlcmF0aW9ucw0Kb24gbWlzYWxpZ25lZCBhZGRyZXNzZXMu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

