Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD77A788B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjITKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjITKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:06:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CFEAC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:06:33 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-rzX29dJ6Oz-jMKGfcRcBhg-1; Wed, 20 Sep 2023 11:06:20 +0100
X-MC-Unique: rzX29dJ6Oz-jMKGfcRcBhg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 20 Sep
 2023 11:06:16 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 20 Sep 2023 11:06:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        'Kees Cook' <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        'Eric Dumazet' <edumazet@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: RE: Subject: [PATCH v2] slab: kmalloc_size_roundup() must not return
 0 for non-zero size
Thread-Topic: Subject: [PATCH v2] slab: kmalloc_size_roundup() must not return
 0 for non-zero size
Thread-Index: Adnhh8rbtLpHk7QBQE+HpPR0NWDZ5gAMq8SAABymU5AApLGGAAACRmZQ///11gD//+uuIIANzcKA///uM/A=
Date:   Wed, 20 Sep 2023 10:06:16 +0000
Message-ID: <a7186ea957ae47feb8c79ad92057f481@AcuMS.aculab.com>
References: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
 <202309071235.CB4F6B2@keescook>
 <20ca0a567a874052a1161e9be0870463@AcuMS.aculab.com>
 <e17c58a4-2dd8-4a1b-9feb-ab307e3877c2@suse.cz>
 <1bf41b7c8d7c428c8bfb5504ec9f680e@AcuMS.aculab.com>
 <1d634412-c0e5-4c16-92a4-447bde684ad6@suse.cz>
 <e12d3085c8b8414b837bfc737af0c9de@AcuMS.aculab.com>
 <5569ec99-b441-f7f0-060b-168abc089b23@suse.cz>
In-Reply-To: <5569ec99-b441-f7f0-060b-168abc089b23@suse.cz>
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

RnJvbTogVmxhc3RpbWlsIEJhYmthDQo+IFNlbnQ6IDIwIFNlcHRlbWJlciAyMDIzIDEwOjU4DQo+
IA0KPiBPbiA5LzExLzIzIDE4OjM4LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4+ID4+IFNvIHBl
cmhhcHMgdGhlIGJlc3Qgd291bGQgYmUgdG8gcmV0dXJuIHNpemUgZm9yIGMgPT0gTlVMTCwgYnV0
IGFsc28gZG8gYQ0KPiA+PiA+PiBXQVJOX09OQ0U/DQo+ID4+ID4NCj4gPj4gPiBUaGF0IHdvdWxk
IGFkZCBhIHJlYWwgZnVuY3Rpb24gY2FsbCB0byBhbiBvdGhlcndpc2UgbGVhZiBmdW5jdGlvbg0K
PiA+PiA+IGFuZCBhbG1vc3QgY2VydGFpbmx5IHJlcXVpcmUgdGhlIGNvbXBpbGVyIGNyZWF0ZSBh
IHN0YWNrIGZyYW1lLg0KPiA+Pg0KPiA+PiBIbSBJIHRob3VnaHQgV0FSTiBpcyBkb25lIGJ5IHRy
aXBwaW5nIG9uIHVuZGVmaW5lZCBpbnN0cnVjdGlvbiBsaWtlIEJVRw0KPiA+PiB0aGVzZSBkYXlz
LiBBbHNvIGFueSBjb2RlIHRoYXQgYWNjZXB0cyB0aGUgY2FsbCB0byBrbWFsbG9jX3NpemVfcm91
bmR1cA0KPiA+PiBwcm9iYWJseSBjb3VsZCBhY2NlcHQgdGhhdCB0b28uDQo+ID4NCj4gPiBJdCdz
IHByb2JhYmx5IGp1c3Qgd29ydGggcmVtb3ZpbmcgdGhlIGMgPT0gTlVMTCBjaGVjayBhbmQNCj4g
PiBhc3N1bWluZyB0aGVyZSB3b24ndCBiZSBhbnkgZmFsbG91dC4NCj4gPiBUaGUgTlVMTCBwb2lu
dGVyIGRlcmVmIGlzIGFuIGVhc3kgdG8gZGVidWcgYXMgYW55dGhpbmcgZWxzZS4NCj4gPg0KPiA+
IElmIGl0IGdldHMgY2FsbGVkIGluIGFueSBlYXJseSBpbml0IGNvZGUgaXQnbGwgc29vbiBzaG93
IHVwLg0KPiANCj4gR29vZCBwb2ludCwgZWFybHkgY3Jhc2ggc2hvdWxkIGJlIG9rLg0KPiBTbyBo
b3cgYWJvdXQgdGhpcyB3aXRoIG15IHR3ZWFrcywgbG9va3Mgb2s/DQoNCklzIHRoYXQganVzdC9t
YWlubHkgdGhlIGNoYW5nZSB0byBhc3N1bWUgdGhhdCBrbWFsbG9jX3NsYWIoKSBkb2Vzbid0IGZh
aWw/DQpZb3UgY2FuIGFsc28gcmVtb3ZlICdjJy4NCglyZXR1cm4ga21hbGxvY19zbGFiKHNpemUs
IEdGUF9LRVJORUwsIDApLT5vYmplY3Rfc2l6ZTsNCmlzbid0IHRvbyBsb25nLg0KDQpJIGFsc28g
ZGlkIGEgZ3JlcCBmb3IgY2FsbGVycy4NCk5vdGhpbmcgaW4gZWFybHkgY29kZSwgSUlSQyBtYWlu
bHkgJ25ldCcuDQoNCglEYXZpZA0KDQo+IEknbGwgcHV0IGl0IGluIC1uZXh0IGFuZA0KPiBzZW5k
IHdpdGggYW5vdGhlciBob3RmaXggdG8gNi42IG5leHQgd2Vlay4NCj4gLS0tLTg8LS0tLQ0KPiBG
cm9tIGY1ZGUxZWU3YjM1ZDdhYjM1YzIxYzc5ZGQxM2NlYTQ5ZmJlMjM5YjcgTW9uIFNlcCAxNyAw
MDowMDowMCAyMDAxDQo+IEZyb206IERhdmlkIExhaWdodCA8ZGF2aWQubGFpZ2h0QGFjdWxhYi5j
b20+DQo+IERhdGU6IFRodSwgNyBTZXAgMjAyMyAxMjo0MjoyMCArMDAwMA0KPiBTdWJqZWN0OiBb
UEFUQ0hdIFN1YmplY3Q6IFtQQVRDSCB2Ml0gc2xhYjoga21hbGxvY19zaXplX3JvdW5kdXAoKSBt
dXN0IG5vdA0KPiAgcmV0dXJuIDAgZm9yIG5vbi16ZXJvIHNpemUNCj4gDQo+IFRoZSB0eXBpY2Fs
IHVzZSBvZiBrbWFsbG9jX3NpemVfcm91bmR1cCgpIGlzOg0KPiANCj4gCXB0ciA9IGttYWxsb2Mo
c3ogPSBrbWFsbG9jX3NpemVfcm91bmR1cChzaXplKSwgLi4uKTsNCj4gCWlmICghcHRyKSByZXR1
cm4gLUVOT01FTS4NCj4gDQo+IFRoaXMgbWVhbnMgaXQgaXMgdml0YWxseSBpbXBvcnRhbnQgdGhh
dCB0aGUgcmV0dXJuZWQgdmFsdWUgaXNuJ3QgbGVzcw0KPiB0aGFuIHRoZSBhcmd1bWVudCBldmVu
IGlmIHRoZSBhcmd1bWVudCBpcyBpbnNhbmUuDQo+IEluIHBhcnRpY3VsYXIgaWYga21hbGxvY19z
bGFiKCkgZmFpbHMgb3IgdGhlIHZhbHVlIGlzIGFib3ZlDQo+IChNQVhfVUxPTkcgLSBQQUdFX1NJ
WkUpIHplcm8gaXMgcmV0dXJuZWQgYW5kIGttYWxsb2MoKSB3aWxsIHJldHVybg0KPiBpdHMgc2lu
Z2xlIHplcm8tbGVuZ3RoIGJ1ZmZlciBaRVJPX1NJWkVfUFRSLg0KPiANCj4gRml4IHRoaXMgYnkg
cmV0dXJuaW5nIHRoZSBpbnB1dCBzaXplIGlmIHRoZSBzaXplIGV4Y2VlZHMNCj4gS01BTExPQ19N
QVhfU0laRS4ga21hbGxvYygpIHdpbGwgdGhlbiByZXR1cm4gTlVMTCBhcyB0aGUgc2l6ZSByZWFs
bHkgaXMNCj4gdG9vIGJpZy4NCj4gDQo+IGttYWxsb2Nfc2xhYigpIHNob3VsZCBub3Qgbm9ybWFs
bHkgcmV0dXJuIE5VTEwsIHVubGVzcyBjYWxsZWQgdG9vIGVhcmx5Lg0KPiBBZ2FpbiwgcmV0dXJu
aW5nIHplcm8gaXMgbm90IHRoZSBjb3JyZWN0IGFjdGlvbiBhcyBpdCBjYW4gYmUgaW4gc29tZQ0K
PiB1c2FnZSBzY2VuYXJpb3Mgc3RvcmVkIHRvIGEgdmFyaWFibGUgYW5kIG9ubHkgbGF0ZXIgY2F1
c2Uga21hbGxvYygpDQo+IHJldHVybiBaRVJPX1NJWkVfUFRSIGFuZCBzdWJzZXF1ZW50IGNyYXNo
ZXMgb24gYWNjZXNzLiBJbnN0ZWFkIHdlIGNhbg0KPiBzaW1wbHkgc3RvcCBjaGVja2luZyB0aGUg
a21hbGxvY19zbGFiKCkgcmVzdWx0IGNvbXBsZXRlbHksIGFzIGNhbGxpbmcNCj4ga21hbGxvY19z
aXplX3JvdW5kdXAoKSB0b28gZWFybHkgd291bGQgdGhlbiByZXN1bHQgaW4gYW4gaW1tZWRpYXRl
IGNyYXNoDQo+IGR1cmluZyBib290IGFuZCB0aGUgZGV2ZWxvcGVyIG5vdGljaW5nIGFuIGlzc3Vl
IGluIHRoZWlyIGNvZGUuDQo+IA0KPiBbdmJhYmthQHN1c2UuY3o6IHJlbW92ZSBrbWFsbG9jX3Ns
YWIoKSByZXN1bHQgY2hlY2ssIHR3ZWFrIGNvbW1lbnRzIGFuZA0KPiAgY29tbWl0IGxvZ10NCj4g
U2lnbmVkLW9mZi1ieTogRGF2aWQgTGFpZ2h0IDxkYXZpZC5sYWlnaHRAYWN1bGFiLmNvbT4NCj4g
Rml4ZXM6IDA1YTk0MDY1NmUxZSAoInNsYWI6IEludHJvZHVjZSBrbWFsbG9jX3NpemVfcm91bmR1
cCgpIikNCj4gU2lnbmVkLW9mZi1ieTogVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej4N
Cj4gLS0tDQo+ICBtbS9zbGFiX2NvbW1vbi5jIHwgMjUgKysrKysrKysrKysrKystLS0tLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL21tL3NsYWJfY29tbW9uLmMgYi9tbS9zbGFiX2NvbW1vbi5jDQo+
IGluZGV4IGU5OWU4MjEwNjVjMy4uMWRjMTA4MjI0YmQxIDEwMDY0NA0KPiAtLS0gYS9tbS9zbGFi
X2NvbW1vbi5jDQo+ICsrKyBiL21tL3NsYWJfY29tbW9uLmMNCj4gQEAgLTc0NywyMiArNzQ3LDI1
IEBAIHNpemVfdCBrbWFsbG9jX3NpemVfcm91bmR1cChzaXplX3Qgc2l6ZSkNCj4gIHsNCj4gIAlz
dHJ1Y3Qga21lbV9jYWNoZSAqYzsNCj4gDQo+IC0JLyogU2hvcnQtY2lyY3VpdCB0aGUgMCBzaXpl
IGNhc2UuICovDQo+IC0JaWYgKHVubGlrZWx5KHNpemUgPT0gMCkpDQo+IC0JCXJldHVybiAwOw0K
PiAtCS8qIFNob3J0LWNpcmN1aXQgc2F0dXJhdGVkICJ0b28tbGFyZ2UiIGNhc2UuICovDQo+IC0J
aWYgKHVubGlrZWx5KHNpemUgPT0gU0laRV9NQVgpKQ0KPiAtCQlyZXR1cm4gU0laRV9NQVg7DQo+
ICsJaWYgKHNpemUgJiYgc2l6ZSA8PSBLTUFMTE9DX01BWF9DQUNIRV9TSVpFKSB7DQo+ICsJCS8q
DQo+ICsJCSAqIFRoZSBmbGFncyBkb24ndCBtYXR0ZXIgc2luY2Ugc2l6ZV9pbmRleCBpcyBjb21t
b24gdG8gYWxsLg0KPiArCQkgKiBOZWl0aGVyIGRvZXMgdGhlIGNhbGxlciBmb3IganVzdCBnZXR0
aW5nIC0+b2JqZWN0X3NpemUuDQo+ICsJCSAqLw0KPiArCQljID0ga21hbGxvY19zbGFiKHNpemUs
IEdGUF9LRVJORUwsIDApOw0KPiArCQlyZXR1cm4gYy0+b2JqZWN0X3NpemU7DQo+ICsJfQ0KPiAr
DQo+ICAJLyogQWJvdmUgdGhlIHNtYWxsZXIgYnVja2V0cywgc2l6ZSBpcyBhIG11bHRpcGxlIG9m
IHBhZ2Ugc2l6ZS4gKi8NCj4gLQlpZiAoc2l6ZSA+IEtNQUxMT0NfTUFYX0NBQ0hFX1NJWkUpDQo+
ICsJaWYgKHNpemUgJiYgc2l6ZSA8PSBLTUFMTE9DX01BWF9TSVpFKQ0KPiAgCQlyZXR1cm4gUEFH
RV9TSVpFIDw8IGdldF9vcmRlcihzaXplKTsNCj4gDQo+ICAJLyoNCj4gLQkgKiBUaGUgZmxhZ3Mg
ZG9uJ3QgbWF0dGVyIHNpbmNlIHNpemVfaW5kZXggaXMgY29tbW9uIHRvIGFsbC4NCj4gLQkgKiBO
ZWl0aGVyIGRvZXMgdGhlIGNhbGxlciBmb3IganVzdCBnZXR0aW5nIC0+b2JqZWN0X3NpemUuDQo+
ICsJICogUmV0dXJuICdzaXplJyBmb3IgMCAtIGttYWxsb2MoKSByZXR1cm5zIFpFUk9fU0laRV9Q
VFINCj4gKwkgKiBhbmQgdmVyeSBsYXJnZSBzaXplIC0ga21hbGxvYygpIG1heSBmYWlsLg0KPiAg
CSAqLw0KPiAtCWMgPSBrbWFsbG9jX3NsYWIoc2l6ZSwgR0ZQX0tFUk5FTCwgMCk7DQo+IC0JcmV0
dXJuIGMgPyBjLT5vYmplY3Rfc2l6ZSA6IDA7DQo+ICsJcmV0dXJuIHNpemU7DQo+ICsNCj4gIH0N
Cj4gIEVYUE9SVF9TWU1CT0woa21hbGxvY19zaXplX3JvdW5kdXApOw0KPiANCj4gLS0NCj4gMi40
Mi4wDQo+IA0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

