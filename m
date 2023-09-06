Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71727937D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbjIFJPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjIFJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:15:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D441AB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:14:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-UBDVCh_xPgCbZN0HkERkbQ-1; Wed, 06 Sep 2023 10:14:55 +0100
X-MC-Unique: UBDVCh_xPgCbZN0HkERkbQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Sep
 2023 10:14:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Sep 2023 10:14:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>
CC:     'Kees Cook' <keescook@chromium.org>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Eric Dumazet' <edumazet@google.com>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: RE: [PATCH] slab: kmalloc_size_roundup() must not return 0 for
 non-zero size
Thread-Topic: [PATCH] slab: kmalloc_size_roundup() must not return 0 for
 non-zero size
Thread-Index: AdngmrOo1jL765q1RK2Ib5JvSvHtF///934A///uHaA=
Date:   Wed, 6 Sep 2023 09:14:52 +0000
Message-ID: <8e75708ef630418283ef208488064b79@AcuMS.aculab.com>
References: <fcfee37ead054de19871139167aca787@AcuMS.aculab.com>
 <2cb3f35b-a18c-75fa-d73e-95a4fb8cf079@suse.cz>
In-Reply-To: <2cb3f35b-a18c-75fa-d73e-95a4fb8cf079@suse.cz>
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

RnJvbTogVmxhc3RpbWlsIEJhYmthDQo+IFNlbnQ6IDA2IFNlcHRlbWJlciAyMDIzIDA5OjQ4DQo+
IA0KPiBQbGVhc2UgQ2M6IGFsc28gUjogZm9sa3MgaW4gTUFJTlRBSU5FUlMsIGFkZGluZyB0aGVt
IG5vdy4NCj4gDQo+IE9uIDkvNi8yMyAxMDoxOCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IFRo
ZSB0eXBpY2FsIHVzZSBvZiBrbWFsbG9jX3NpemVfcm91bmR1cCgpIGlzOg0KPiA+IAlwdHIgPSBr
bWFsbG9jKHN6ID0ga21hbGxvY19zaXplX3JvdW5kdXAoc2l6ZSksIC4uLik7DQo+ID4gCWlmICgh
cHRyKSByZXR1cm4gLUVOT01FTS4NCj4gPiBUaGlzIG1lYW5zIGl0IGlzIHZpdGFsbHkgaW1wb3J0
YW50IHRoYXQgdGhlIHJldHVybmVkIHZhbHVlIGlzbid0DQo+ID4gbGVzcyB0aGFuIHRoZSBhcmd1
bWVudCBldmVuIGlmIHRoZSBhcmd1bWVudCBpcyBpbnNhbmUuDQo+ID4gSW4gcGFydGljdWxhciBp
ZiBrbWFsbG9jX3NsYWIoKSBmYWlscyBvciB0aGUgdmFsdWUgaXMgYWJvdmUNCj4gPiAoTUFYX1VM
T05HIC0gUEFHRV9TSVpFKSB6ZXJvIGlzIHJldHVybmVkIGFuZCBrbWFsbG9jKCkgd2lsbCByZXR1
cm4NCj4gPiBpdCdzIHNpbmdsZSB6ZXJvLWxlbmd0aCBidWZmZXIuDQo+ID4NCj4gPiBGaXggYnkg
cmV0dXJuaW5nIHRoZSBpbnB1dCBzaXplIG9uIGVycm9yIG9yIGlmIHRoZSBzaXplIGV4Y2VlZHMN
Cj4gPiBhICdzYW5pdHknIGxpbWl0Lg0KPiA+IGttYWxsb2MoKSB3aWxsIHRoZW4gcmV0dXJuIE5V
TEwgaXMgdGhlIHNpemUgcmVhbGx5IGlzIHRvbyBiaWcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEYXZpZCBMYWlnaHQgPGRhdmlkLmxhaWdodEBhY3VsYWIuY29tPg0KPiA+IEZpeGVzOiAwNWE5
NDA2NTZlMWViICgic2xhYjogSW50cm9kdWNlIGttYWxsb2Nfc2l6ZV9yb3VuZHVwKCkiKQ0KPiA+
IC0tLQ0KPiA+IFRoZSAnc2FuaXR5IGxpbWl0JyB2YWx1ZSBkb2Vzbid0IHJlYWxseSBtYXR0ZXIg
KGV2ZW4gaWYgdG9vIHNtYWxsKQ0KPiA+IEl0IGNvdWxkIGJlICdNQVhfT1JERVIgKyBQQUdFX1NI
SUZUJyBidXQgb25lIHBwYzY0IGhhcyBNQVhfT1JERVIgMTYNCj4gPiBhbmQgSSBkb24ndCBrbm93
IGlmIHRoYXQgYWxzbyBoYXMgbGFyZ2UgcGFnZXMuDQo+IA0KPiBXZWxsIHdlIGRvIGhhdmUgS01B
TExPQ19NQVhfU0laRSwgd2hpY2ggaXMgYmFzZWQgb24gTUFYX09SREVSICsgUEFHRV9TSElGVA0K
PiAoYW5kIG5vIGlzc3VlcyBvbiBwcGM2NCBzbyBJJ2QgZXhwZWN0IHRoZSBjb21iaW5hdGlvbiBv
ZiBNQVhfT1JERVIgYW5kDQo+IFBBR0VfU0hJRlQgc2hvdWxkIGFsd2F5cyBiZSBzdWNoIHRoYXQg
aXQgZG9lc24ndCBvdmVyZmxvdyBvbiB0aGUgcGFydGljdWxhcg0KPiBhcmNoKSBzbyBJIHRoaW5r
IGl0IHdvdWxkIGJlIHRoZSBtb3N0IHN0cmFpZ2h0Zm9yd2FyZCB0byBzaW1wbHkgdXNlIHRoYXQu
DQoNClNlYXJjaGluZyBhbGwgdGhlIGNvbnN0YQ0KbnRzIGdldHMgaGFyZCA6LSkNCj4gDQo+ID4g
TWF5YmUgaXQgY291bGQgYmUgMXVsIDw8IDMwIG9uIDY0Yml0LCBidXQgaXQgcmVhbGx5IGRvZXNu
J3QgbWF0dGVyDQo+ID4gaWYgaXQgaXMgdG9vIGJpZy4NCj4gPg0KPiA+IFRoZSBvcmlnaW5hbCBw
YXRjaCBhbHNvIGFkZGVkIGttYWxsb2Nfc2l6ZV9yb3VuZHVwKCkgdG8gbW0vc2xvYi5jDQo+ID4g
dGhhdCBjYW4gYWxzbyByb3VuZCB1cCBhIHZhbHVlIHRvIHplcm8gLSBidXQgaGFzIHNpbmNlIGJl
ZW4gcmVtb3ZlZC4NCj4gPg0KPiA+ICBtbS9zbGFiX2NvbW1vbi5jIHwgMjkgKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDE1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL3NsYWJfY29tbW9uLmMg
Yi9tbS9zbGFiX2NvbW1vbi5jDQo+ID4gaW5kZXggY2Q3MWY5NTgxZTY3Li44NDE4ZWNjZGE4Y2Yg
MTAwNjQ0DQo+ID4gLS0tIGEvbW0vc2xhYl9jb21tb24uYw0KPiA+ICsrKyBiL21tL3NsYWJfY29t
bW9uLmMNCj4gPiBAQCAtNzQ3LDIyICs3NDcsMjEgQEAgc2l6ZV90IGttYWxsb2Nfc2l6ZV9yb3Vu
ZHVwKHNpemVfdCBzaXplKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3Qga21lbV9jYWNoZSAqYzsNCj4g
Pg0KPiA+IC0JLyogU2hvcnQtY2lyY3VpdCB0aGUgMCBzaXplIGNhc2UuICovDQo+ID4gLQlpZiAo
dW5saWtlbHkoc2l6ZSA9PSAwKSkNCj4gPiAtCQlyZXR1cm4gMDsNCj4gPiAtCS8qIFNob3J0LWNp
cmN1aXQgc2F0dXJhdGVkICJ0b28tbGFyZ2UiIGNhc2UuICovDQo+ID4gLQlpZiAodW5saWtlbHko
c2l6ZSA9PSBTSVpFX01BWCkpDQo+ID4gLQkJcmV0dXJuIFNJWkVfTUFYOw0KPiA+IC0JLyogQWJv
dmUgdGhlIHNtYWxsZXIgYnVja2V0cywgc2l6ZSBpcyBhIG11bHRpcGxlIG9mIHBhZ2Ugc2l6ZS4g
Ki8NCj4gPiAtCWlmIChzaXplID4gS01BTExPQ19NQVhfQ0FDSEVfU0laRSkNCj4gPiAtCQlyZXR1
cm4gUEFHRV9TSVpFIDw8IGdldF9vcmRlcihzaXplKTsNCj4gPiArCWlmIChzaXplICYmIHNpemUg
PD0gS01BTExPQ19NQVhfQ0FDSEVfU0laRSkgew0KPiANCj4gSSBndWVzcyB0aGUgd2hvbGUgdGVz
dCBjb3VsZCBhbGwgYmUgbGlrZWx5KCkuDQo+IA0KPiBBbHNvIHRoaXMgcGF0Y2ggY291bGQgcHJv
YmFibHkgYmUganVzdCByZXBsYWNpbmcgdGhlIFNJWkVfTUFYIHRlc3Qgd2l0aCA+PQ0KPiBLTUFM
TE9DX01BWF9TSVpFLCBidXQgc2luY2UgdGhlIG1ham9yaXR5IGlzIGV4cGVjdGVkIHRvIGJlIDAg
PCBzaXplIDw9DQo+IEtNQUxMT0NfTUFYX0NBQ0hFX1NJWkUsIHlvdXIgcmVvcmRlcmluZyBtYWtl
cyBzZW5zZSB0byBtZS4NCg0KSSByZS1vcmRlcmVkIGl0IGJlY2F1c2UgdGhlcmUgYXJlIHRocmVl
IGNhc2VzIGFuZCBpdCBkaWRuJ3QgbWFrZSBhbnkgc2Vuc2UNCnRvIGhhdmUgdHdvIG9mIHRoZW0g
aW5zaWRlIHRoZSBmaXJzdCBjb25kaXRpb25hbC4NCkluIHBhcnRpY3VsYXIgaXQgbWFkZSB0aGUg
Y29tbWVudHMgZWFzaWVyIHRvIHdyaXRlIQ0KDQpPcHRpbWlzaW5nIGZvciAnc2l6ZSA9PSAwJyAo
dGhlIHVubGlrZWx5KCkgbWFrZXMgbGl0dGxlIGRpZmZlcmVuY2UpDQppcyBjb21wbGV0ZWx5IGlu
c2FuZS4NClRoZSBjb21waWxlciBvcHRpbWlzZXMgJ2lmIChzaXplICYmIHNpemUgPD0gY29uc3Rh
bnQpJyB0bw0KJ2lmICgoc2l6ZSAtIDEpIDwgY29uc3RhbnQpJyBzbyB5b3UgbG9zZSBhIGNvbmRp
dGlvbmFsIGJyYW5jaA0KaW4gdGhlIGhvdCBwYXRocw0KDQo+ID4gKwkJLyoNCj4gPiArCQkgKiBU
aGUgZmxhZ3MgZG9uJ3QgbWF0dGVyIHNpbmNlIHNpemVfaW5kZXggaXMgY29tbW9uIHRvIGFsbC4N
Cj4gPiArCQkgKiBOZWl0aGVyIGRvZXMgdGhlIGNhbGxlciBmb3IganVzdCBnZXR0aW5nIC0+b2Jq
ZWN0X3NpemUuDQo+ID4gKwkJICovDQo+ID4gKwkJYyA9IGttYWxsb2Nfc2xhYihzaXplLCBHRlBf
S0VSTkVMLCAwKTsNCj4gPiArCQlyZXR1cm4gbGlrZWx5KGMpID8gYy0+b2JqZWN0X3NpemUgOiBz
aXplOw0KPiA+ICsJfQ0KPiA+DQo+ID4gLQkvKg0KPiA+IC0JICogVGhlIGZsYWdzIGRvbid0IG1h
dHRlciBzaW5jZSBzaXplX2luZGV4IGlzIGNvbW1vbiB0byBhbGwuDQo+ID4gLQkgKiBOZWl0aGVy
IGRvZXMgdGhlIGNhbGxlciBmb3IganVzdCBnZXR0aW5nIC0+b2JqZWN0X3NpemUuDQo+ID4gLQkg
Ki8NCj4gPiAtCWMgPSBrbWFsbG9jX3NsYWIoc2l6ZSwgR0ZQX0tFUk5FTCwgMCk7DQo+ID4gLQly
ZXR1cm4gYyA/IGMtPm9iamVjdF9zaXplIDogMDsNCj4gPiArCS8qIFJldHVybiAnc2l6ZScgZm9y
IDAgYW5kIHZlcnkgbGFyZ2UgLSBrbWFsbG9jKCkgbWF5IGZhaWwuICovDQo+ID4gKwlpZiAodW5s
aWtlbHkoKHNpemUgLSAxKSA+PiAoc2l6ZW9mIChsb25nKSA9PSA4ID8gMzQgOiAzMCkpKQ0KPiAN
Cj4gU28gSSdkIGp1c3QgdGVzdCBmb3Igc2l6ZSA9PSAwIHx8IHNpemUgPiBLTUFMTE9DX01BWF9T
SVpFPw0KDQpUaGF0IGRvZXMgZ2VuZXJhdGUgYmV0dGVyIGNvZGUsIGJ1dCBvbiBzb21lIGFyY2gg
YWRkaW5nIDENCm1pZ2h0IG1ha2UgdGhlIGNvbnN0YW50IChlZykgMHg0MDAwMDAgbm90IDB4M2Zm
ZmZmIGFuZCBlYXNpZXINCnRvIGdlbmVyYXRlLg0KDQpBY3R1YWxseSwgZm9yIGNvbnNpc3RlbmN5
LCBpdCBtaWdodCBiZSBiZXN0IHRvIGludmVydCB0aGUNCnNlY29uZCBjb21wYXJlIGFzIHdlbGwu
DQoNCkknbGwgZWRpdCB0aGUgcGF0Y2ggdG8gZ2VuZXJhdGUgYSB2MiBsYXRlci4NCg0KCURhdmlk
DQoNCj4gDQo+ID4gKwkJcmV0dXJuIHNpemU7DQo+ID4gKw0KPiA+ICsJLyogQWJvdmUgdGhlIHNt
YWxsZXIgYnVja2V0cywgc2l6ZSBpcyBhIG11bHRpcGxlIG9mIHBhZ2Ugc2l6ZS4gKi8NCj4gPiAr
CXJldHVybiBQQUdFX1NJWkUgPDwgZ2V0X29yZGVyKHNpemUpOw0KPiA+ICB9DQo+ID4gIEVYUE9S
VF9TWU1CT0woa21hbGxvY19zaXplX3JvdW5kdXApOw0KPiA+DQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

