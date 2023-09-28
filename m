Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709637B1F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjI1Odj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjI1Odg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:33:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA201F5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:33:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-MoqvuF5zPpKe7bov9E_iPA-1; Thu, 28 Sep 2023 15:33:21 +0100
X-MC-Unique: MoqvuF5zPpKe7bov9E_iPA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 28 Sep
 2023 15:33:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 28 Sep 2023 15:33:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        'Peter Zijlstra' <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, "Paul Turner" <pjt@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "Florian Weimer" <fw@deneb.enyo.de>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Peter Oskolkov" <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Darren Hart" <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?B?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        "longman@redhat.com" <longman@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: RE: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Thread-Topic: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Thread-Index: AQHZ8fgZ0Ykvpvbq8USYUjzds++7brAwFQDggAATbgCAACAnMA==
Date:   Thu, 28 Sep 2023 14:33:19 +0000
Message-ID: <e2957e5bc071480889f4e1aa32b9cdea@AcuMS.aculab.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
 <20230928103926.GI9829@noisy.programming.kicks-ass.net>
 <ef39143ad24743008a896d2a09da1066@AcuMS.aculab.com>
 <34ddb730-8893-19a8-00fe-84c4e281eef1@efficios.com>
In-Reply-To: <34ddb730-8893-19a8-00fe-84c4e281eef1@efficios.com>
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

RnJvbTogTWF0aGlldSBEZXNub3llcnMNCj4gU2VudDogMjggU2VwdGVtYmVyIDIwMjMgMTQ6MjEN
Cj4gDQo+IE9uIDkvMjgvMjMgMDc6MjIsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBQ
ZXRlciBaaWpsc3RyYQ0KPiA+PiBTZW50OiAyOCBTZXB0ZW1iZXIgMjAyMyAxMTozOQ0KPiA+Pg0K
PiA+PiBPbiBNb24sIE1heSAyOSwgMjAyMyBhdCAwMzoxNDoxM1BNIC0wNDAwLCBNYXRoaWV1IERl
c25veWVycyB3cm90ZToNCj4gPj4+IEV4cG9zZSB0aGUgIm9uLWNwdSIgc3RhdGUgZm9yIGVhY2gg
dGhyZWFkIHRocm91Z2ggc3RydWN0IHJzZXEgdG8gYWxsb3cNCj4gPj4+IGFkYXB0YXRpdmUgbXV0
ZXhlcyB0byBkZWNpZGUgbW9yZSBhY2N1cmF0ZWx5IGJldHdlZW4gYnVzeS13YWl0aW5nIGFuZA0K
PiA+Pj4gY2FsbGluZyBzeXNfZnV0ZXgoKSB0byByZWxlYXNlIHRoZSBDUFUsIGJhc2VkIG9uIHRo
ZSBvbi1jcHUgc3RhdGUgb2YgdGhlDQo+ID4+PiBtdXRleCBvd25lci4NCj4gPg0KPiA+IEFyZSB5
b3UgdHJ5aW5nIHRvIGF2b2lkIHNwaW5uaW5nIHdoZW4gdGhlIG93bmluZyBwcm9jZXNzIGlzIHNs
ZWVwaW5nPw0KPiANCj4gWWVzLCB0aGlzIGlzIG15IG1haW4gaW50ZW50Lg0KPiANCj4gPiBPciB0
cnlpbmcgdG8gYXZvaWQgdGhlIHN5c3RlbSBjYWxsIHdoZW4gaXQgd2lsbCBmaW5kIHRoYXQgdGhl
IGZ1dGV4DQo+ID4gaXMgbm8gbG9uZ2VyIGhlbGQ/DQo+ID4NCj4gPiBUaGUgbGF0dGVyIGlzIHJl
YWxseSBob3JyaWJseSBkZXRyZW1lbnRhbC4NCj4gDQo+IFRoYXQncyBhIGdvb2QgcXVlc3Rpb25z
LiBXaGF0IHNob3VsZCB3ZSBkbyBpbiB0aG9zZSB0aHJlZSBzaXR1YXRpb25zDQo+IHdoZW4gdHJ5
aW5nIHRvIGdyYWIgdGhlIGxvY2s6DQo+IA0KPiAxKSBMb2NrIGhhcyBubyBvd25lcg0KPiANCj4g
V2UgcHJvYmFibHkgd2FudCB0byBzaW1wbHkgZ3JhYiB0aGUgbG9jayB3aXRoIGFuIGF0b21pYyBp
bnN0cnVjdGlvbi4gQnV0DQo+IHRoZW4gaWYgb3RoZXIgdGhyZWFkcyBhcmUgcXVldWVkIG9uIHN5
c19mdXRleCBhbmQgZGlkIG5vdCBtYW5hZ2UgdG8gZ3JhYg0KPiB0aGUgbG9jayB5ZXQsIHRoaXMg
d291bGQgYmUgZGV0cmltZW50YWwgdG8gZmFpcm5lc3MuDQo+IA0KPiAyKSBMb2NrIG93bmVyIGlz
IHJ1bm5pbmc6DQo+IA0KPiBUaGUgbG9jayBvd25lciBpcyBjZXJ0YWlubHkgcnVubmluZyBvbiBh
bm90aGVyIGNwdSAoSSdtIHVzaW5nIHRoZSB0ZXJtDQo+ICJjcHUiIGhlcmUgYXMgbG9naWNhbCBj
cHUpLg0KPiANCj4gSSBndWVzcyB3ZSBjb3VsZCBlaXRoZXIgZGVjaWRlIHRvIGJ5cGFzcyBzeXNf
ZnV0ZXggZW50aXJlbHkgYW5kIHRyeSB0bw0KPiBncmFiIHRoZSBsb2NrIHdpdGggYW4gYXRvbWlj
LCBvciB3ZSBnbyB0aHJvdWdoIHN5c19mdXRleCBuZXZlcnRoZWxlc3MgdG8NCj4gYWxsb3cgZnV0
ZXggdG8gZ3VhcmFudGVlIHNvbWUgZmFpcm5lc3MgYWNyb3NzIHRocmVhZHMuDQoNCkknZCBub3Qg
d29ycnkgYWJvdXQgJ2ZhaXJuZXNzJy4NCklmIHRoZSBtdXRleCBpcyB0aGF0IGNvbnRlbmRlZCB5
b3UndmUgYWxyZWFkeSBsb3N0IQ0KDQpJIGhhZCBhIGJpZyBwcm9ibGVtIHRyeWluZyB0byBhdm9p
ZCB0aGUgZXhpc3RpbmcgJ2ZhaXJuZXNzJyBjb2RlLg0KQ29uc2lkZXIgMzAgUlQgdGhyZWFkcyBi
bG9ja2VkIGluIGN2X3dhaXQoKSBvbiB0aGUgc2FtZSBjb25kdmFyLg0KU29tZXRoaW5nIGRvZXMg
Y3ZfYnJvYWRjYXN0KCkgYW5kIHlvdSB3YW50IHRoZW0gYWxsIHRvIHdha2V1cC4NClRoZXknbGwg
YWxsIHJlbGVhc2UgdGhlIG11dGV4IHByZXR0eSBxdWlja2x5IC0gaXQgZG9lc24ndCBtYXR0ZXIg
aXMgdGhleSBzcGluLg0KQnV0IHdoYXQgYWN0dWFsbHkgaGFwcGVucyBpcyBvbmUgdGhyZWFkIGlz
IHdva2VuIHVwLg0KT25jZSBpdCBoYXMgYmVlbiBzY2hlZHVsZWQgKGFmdGVyIHRoZSBjcHUgaGFz
IGNvbWUgb3V0IG9mIGEgc2xlZXAgc3RhdGUNCmFuZC9vciBhbnkgaGFyZHdhcmUgaW50ZXJydXB0
cyBjb21wbGV0ZWQgKGV0YykgdGhlbiBuZXh0IHRocmVhZCBpcyB3b2tlbi4NCklmIHlvdSBhcmUg
bHVja3kgaXQnbGwgJ29ubHknIHRha2UgYSBmZXcgbXMgdG8gZ2V0IHRoZW0gYWxsIHJ1bm5pbmcu
DQpOb3QgZ29vZCB3aGVuIHlvdSBhcmUgdHJ5aW5nIHRvIHByb2Nlc3MgYXVkaW8gZXZlcnkgMTBt
cy4NCkkgaGFkIHRvIHVzZSBhIHNlcGFyYXRlIGN2IGZvciBlYWNoIHRocmVhZCBhbmQgZ2V0IHRo
ZSB3b2tlbiB0aHJlYWRzDQp0byBoZWxwIHdpdGggdGhlIHdha2V1cHMuIEdvZyBrbm93cyB3aGF0
IGhhcHBlbnMgd2l0aCAyNTYgdGhyZWFkcyENCg0KPiAzKSBMb2NrIG93bmVyIGlzIHNsZWVwaW5n
Og0KPiANCj4gVGhlIGxvY2sgb3duZXIgbWF5IGJlIGVpdGhlciB0aWVkIHRvIHRoZSBzYW1lIGNw
dSBhcyB0aGUgcmVxdWVzdGVyLCBvciBhDQo+IGRpZmZlcmVudCBjcHUuIEhlcmUgY2FsbGluZyBG
VVRFWF9XQUlUIGFuZCBmcmllbmRzIGlzIHByZXR0eSBtdWNoIHJlcXVpcmVkLg0KDQpZb3UnZCBu
ZWVkIHRoZSAnaG9sZGluZyBwcm9jZXNzIGlzIHNsZWVwaW5nJyB0ZXN0IHRvIGJlIHNpZ25pZmlj
YW50bHkNCmZhc3RlciB0aGVuIHRoZSAnb3B0aW1pc3RpYyBzcGluIGhvcGluZyB0aGUgbXV0ZXgg
d2lsbCBiZSByZWxlYXNlZCcuDQpBbmQgZm9yIHRoZSAnc3BpbicgdG8gYmUgbG9uZ2VyIHRoYW4g
dGhlIHN5c2NhbGwgdGltZSBmb3IgZnV0ZXguDQpPdGhlcndpc2UgeW91IGFyZSBvcHRpbWlzaW5n
IGFuIGFscmVhZHkgc2xvdyBwYXRoLg0KSWYgdGhlIHRocmVhZCBpcyBnb2luZyB0byBoYXZlIHRv
IHNsZWVwIHVudGlsIHRoZSB0aHJlYWQgdGhhdCBvd25zDQphIG11dGV4IHdha2VzIHVwIHRoZW4g
SSBjYW4ndCBpbWFnaW5lIHBlcmZvcm1hbmNlIG1hdHRlcmluZy4NCg0KT1RPSCBpdCBpcyBtdWNo
IG1vcmUgdXN1YWwgZm9yIHRoZSBvd25pbmcgdGhyZWFkIHRvIGJlIHJ1bm5pbmcgYW5kDQpyZWxl
YXNlIHRoZSBtdXRleCBxdWlja2x5Lg0KDQpJIHdvdWxkbid0IGhhdmUgdGhvdWdodCBpdCB3YXMg
cmVhbGx5IHdvcnRoIG9wdGltaXNpbmcgZm9yIHRoZQ0KJ2xvY2sgb3duZXIgaXMgc2xlZXBpbmcn
IGNhc2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

