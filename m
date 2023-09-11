Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0C79B231
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376786AbjIKWU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbjIKQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:13:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 708F21B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:13:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-mYiHEOWIMmCSSS6iWUQVLQ-1; Mon, 11 Sep 2023 17:12:55 +0100
X-MC-Unique: mYiHEOWIMmCSSS6iWUQVLQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Sep
 2023 17:12:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 11 Sep 2023 17:12:43 +0100
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
Thread-Index: Adnhh8rbtLpHk7QBQE+HpPR0NWDZ5gAMq8SAABymU5AApLGGAAACRmZQ
Date:   Mon, 11 Sep 2023 16:12:43 +0000
Message-ID: <1bf41b7c8d7c428c8bfb5504ec9f680e@AcuMS.aculab.com>
References: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
 <202309071235.CB4F6B2@keescook>
 <20ca0a567a874052a1161e9be0870463@AcuMS.aculab.com>
 <e17c58a4-2dd8-4a1b-9feb-ab307e3877c2@suse.cz>
In-Reply-To: <e17c58a4-2dd8-4a1b-9feb-ab307e3877c2@suse.cz>
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

RnJvbTogVmxhc3RpbWlsIEJhYmthDQo+IFNlbnQ6IDExIFNlcHRlbWJlciAyMDIzIDE2OjU0DQo+
IA0KPiBPbiA5LzgvMjMgMTA6MjYsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBLZWVz
IENvb2sNCj4gPj4gU2VudDogMDcgU2VwdGVtYmVyIDIwMjMgMjA6MzgNCj4gPj4NCj4gPj4gT24g
VGh1LCBTZXAgMDcsIDIwMjMgYXQgMTI6NDI6MjBQTSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3Rl
Og0KPiA+PiA+IFRoZSB0eXBpY2FsIHVzZSBvZiBrbWFsbG9jX3NpemVfcm91bmR1cCgpIGlzOg0K
PiA+PiA+IAlwdHIgPSBrbWFsbG9jKHN6ID0ga21hbGxvY19zaXplX3JvdW5kdXAoc2l6ZSksIC4u
Lik7DQo+ID4+ID4gCWlmICghcHRyKSByZXR1cm4gLUVOT01FTS4NCj4gPj4gPiBUaGlzIG1lYW5z
IGl0IGlzIHZpdGFsbHkgaW1wb3J0YW50IHRoYXQgdGhlIHJldHVybmVkIHZhbHVlIGlzbid0DQo+
ID4+ID4gbGVzcyB0aGFuIHRoZSBhcmd1bWVudCBldmVuIGlmIHRoZSBhcmd1bWVudCBpcyBpbnNh
bmUuDQo+ID4+ID4gSW4gcGFydGljdWxhciBpZiBrbWFsbG9jX3NsYWIoKSBmYWlscyBvciB0aGUg
dmFsdWUgaXMgYWJvdmUNCj4gPj4gPiAoTUFYX1VMT05HIC0gUEFHRV9TSVpFKSB6ZXJvIGlzIHJl
dHVybmVkIGFuZCBrbWFsbG9jKCkgd2lsbCByZXR1cm4NCj4gPj4gPiBpdCdzIHNpbmdsZSB6ZXJv
LWxlbmd0aCBidWZmZXIuDQo+ID4+ID4NCj4gPj4gPiBGaXggYnkgcmV0dXJuaW5nIHRoZSBpbnB1
dCBzaXplIG9uIGVycm9yIG9yIGlmIHRoZSBzaXplIGV4Y2VlZHMNCj4gPj4gPiBhICdzYW5pdHkn
IGxpbWl0Lg0KPiA+PiA+IGttYWxsb2MoKSB3aWxsIHRoZW4gcmV0dXJuIE5VTEwgaXMgdGhlIHNp
emUgcmVhbGx5IGlzIHRvbyBiaWcuDQo+ID4+ID4NCj4gPj4gPg0KPiA+PiA+IFNpZ25lZC1vZmYt
Ynk6IERhdmlkIExhaWdodCA8ZGF2aWQubGFpZ2h0QGFjdWxhYi5jb20+DQo+ID4+ID4gRml4ZXM6
IDA1YTk0MDY1NmUxZWIgKCJzbGFiOiBJbnRyb2R1Y2Uga21hbGxvY19zaXplX3JvdW5kdXAoKSIp
DQo+ID4+ID4gLS0tDQo+ID4+ID4gdjI6DQo+ID4+ID4gICAgIC0gVXNlIEtNQUxMT0NfTUFYX1NJ
WkUgZm9yIHVwcGVyIGxpbWl0Lg0KPiA+PiA+ICAgICAgIChLTUFMTE9DX01BWF9TSVpFICsgMSBt
YXkgZ2l2ZSBiZXR0ZXIgY29kZSBvbiBzb21lIGFyY2hzISkNCj4gPj4gPiAgICAgLSBJbnZlcnQg
dGVzdCBmb3Igb3ZlcmxhcmdlIGZvciBjb25zaXN0ZW5jeS4NCj4gPj4gPiAgICAgLSBQdXQgYSBs
aWtlbHkoKSBvbiByZXN1bHQgb2Yga21hbGxvY19zbGFiKCkuDQo+ID4+ID4NCj4gPj4gPiAgbW0v
c2xhYl9jb21tb24uYyB8IDI2ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPj4gPg0K
PiA+PiA+IGRpZmYgLS1naXQgYS9tbS9zbGFiX2NvbW1vbi5jIGIvbW0vc2xhYl9jb21tb24uYw0K
PiA+PiA+IGluZGV4IGNkNzFmOTU4MWU2Ny4uMGZiN2M3ZTE5YmFkIDEwMDY0NA0KPiA+PiA+IC0t
LSBhL21tL3NsYWJfY29tbW9uLmMNCj4gPj4gPiArKysgYi9tbS9zbGFiX2NvbW1vbi5jDQo+ID4+
ID4gQEAgLTc0NywyMiArNzQ3LDIyIEBAIHNpemVfdCBrbWFsbG9jX3NpemVfcm91bmR1cChzaXpl
X3Qgc2l6ZSkNCj4gPj4gPiAgew0KPiA+PiA+ICAJc3RydWN0IGttZW1fY2FjaGUgKmM7DQo+ID4+
ID4NCj4gPj4gPiAtCS8qIFNob3J0LWNpcmN1aXQgdGhlIDAgc2l6ZSBjYXNlLiAqLw0KPiA+PiA+
IC0JaWYgKHVubGlrZWx5KHNpemUgPT0gMCkpDQo+ID4+ID4gLQkJcmV0dXJuIDA7DQo+ID4+DQo+
ID4+IElmIHdlIHdhbnQgdG8gYWxsb3cgMCwgbGV0J3MganVzdCBsZWF2ZSB0aGlzIGNhc2UgYXMt
aXM6IHRoZSBjb21waWxlcg0KPiA+PiB3aWxsIG9wdGltaXplIGl0IGFnYWluc3QgdGhlIG90aGVy
IHRlc3RzLg0KPiA+DQo+ID4gSSBkb3VidCB0aGUgY29tcGlsZXIgd2lsbCBvcHRpbWlzZSBpdCBh
d2F5IC0gZXNwZWNpYWxseSB3aXRoDQo+ID4gdGhlIHVubGlrZWx5KCkuDQo+IA0KPiBZZWFoIEkg
YWxzbyB0aGluayBjb21waWxlciBjYW4ndCBkbyBtdWNoIG9wdGltaXphdGlvbnMgZXhjZXB0IGZv
ciBidWlsZC10aW1lDQo+IGNvbnN0YW50IDAgaGVyZS4NCg0KT25seSByZWxldmFudCBpZiB0aGUg
Y29kZSB3ZXJlIGlubGluZWQgLSBhbmQgaXQgaXNuJ3QuDQooYW5kIGlzIHByb2JhYmx5IGEgYml0
IGJpZy4pDQpJJ20gbm90IHN1cmUgeW91J2Qgd2FudCB0byBleHBvc2Uga21hbGxvY19zbGFiKCkg
dG8gdGhlIHdpZGVyIGtlcm5lbC4NCg0KT1RPSCwgaXQgY291bGQgaGF2ZSBhbiBpbmxpbmUgdmVy
c2lvbiBmb3IgY29uc3RhbnRzID4gS01BTExPQ19DQUNIRV9TSVpFLg0KQnV0IHRoZXkgbWF5IG5v
dCBoYXBwZW4gb2Z0ZW4gZW5vdWdoIHRvIG1ha2UgYW55IGRpZmZlcmVuY2UuDQoNCj4gDQo+ID4g
T1RPSCB0aGUgZXhwbGljaXQgY2hlY2tzIGZvciAoc2l6ZSAmJiBzaXplIDw9IExJTUlUKSBkbw0K
PiA+IGdldCBvcHRpbWlzZWQgdG8gKChzaXplIC0gMSkgPD0gTElNSVQgLSAxKSBzbyBiZWNvbWUN
Cj4gPiBhIHNpbmdsZSBjb21wYXJlLg0KPiA+DQo+ID4gVGhlbiByZXR1cm5pbmcgJ3NpemUnIGF0
IHRoZSBib3R0b20gbWVhbnMgdGhhdCB6ZXJvIGlzIHJldHVybmVkDQo+ID4gaW4gdGhlIGFyZyBp
cyB6ZXJvIC0gd2hpY2ggaXMgZmluZS4NCj4gPg0KPiA+Pg0KPiA+PiA+IC0JLyogU2hvcnQtY2ly
Y3VpdCBzYXR1cmF0ZWQgInRvby1sYXJnZSIgY2FzZS4gKi8NCj4gPj4gPiAtCWlmICh1bmxpa2Vs
eShzaXplID09IFNJWkVfTUFYKSkNCj4gPj4gPiAtCQlyZXR1cm4gU0laRV9NQVg7DQo+ID4+ID4g
KwlpZiAoc2l6ZSAmJiBzaXplIDw9IEtNQUxMT0NfTUFYX0NBQ0hFX1NJWkUpIHsNCj4gPj4gPiAr
CQkvKg0KPiA+PiA+ICsJCSAqIFRoZSBmbGFncyBkb24ndCBtYXR0ZXIgc2luY2Ugc2l6ZV9pbmRl
eCBpcyBjb21tb24gdG8gYWxsLg0KPiA+PiA+ICsJCSAqIE5laXRoZXIgZG9lcyB0aGUgY2FsbGVy
IGZvciBqdXN0IGdldHRpbmcgLT5vYmplY3Rfc2l6ZS4NCj4gPj4gPiArCQkgKi8NCj4gPj4gPiAr
CQljID0ga21hbGxvY19zbGFiKHNpemUsIEdGUF9LRVJORUwsIDApOw0KPiA+PiA+ICsJCXJldHVy
biBsaWtlbHkoYykgPyBjLT5vYmplY3Rfc2l6ZSA6IHNpemU7DQo+ID4+DQo+ID4+IEkgd291bGQg
bGlrZSB0byBoYXZlIHRoaXMgZmFpbCAic2FmZSIuIGMgc2hvdWxkIG5ldmVyIGJlIE5VTEwgaGVy
ZSwgc28NCj4gPj4gbGV0J3MgcmV0dXJuICJLTUFMTE9DX01BWF9TSVpFICsgMSIgdG8gZm9yY2Ug
ZmFpbHVyZXMuDQo+ID4NCj4gPiBXaHkgZXZlbiB0cnkgdG8gZm9yY2UgZmFpbHVyZSBoZXJlPw0K
PiA+IFRoZSB3aG9sZSBmdW5jdGlvbiBpcyBqdXN0IGFuIG9wdGltaXNhdGlvbiBzbyB0aGF0IHRo
ZSBjYWxsZXINCj4gPiBjYW4gdXNlIHRoZSBzcGFyZSBzcGFjZS4NCj4gPg0KPiA+IFRoZSBvbmx5
IHRoaW5nIGl0IG11c3RuJ3QgZG8gaXMgcmV0dXJuIGEgc21hbGxlciB2YWx1ZS4NCj4gDQo+IElm
ICJjIiBpcyBOVUxMIGl0IG1lYW5zIGVpdGhlciB0aGUga2VybmVsIGJ1aWxkIG11c3QgYmUgYnJv
a2VuIGUuZy4gYnkNCj4gc29tZWJvZHkgYnJlYWtpbmcgdGhlIEtNQUxMT0NfTUFYX0NBQ0hFX1NJ
WkUgdmFsdWUsIGFuZCB3ZSBjb3VsZCBqdXN0IGlnbm9yZQ0KPiBjIGJlaW5nIE5VTEwgYW5kIGxl
dCBpdCBjcmFzaCBiZWNhdXNlIG9mIHRoYXQuDQo+IEJ1dCBJIHRoaW5rIGl0IGNhbiBhbHNvIGJl
IE5VTEwgZHVlIHRvIHRyeWluZyB0byBjYWxsIGttYWxsb2Nfc2l6ZV9yb3VuZHVwKCkNCj4gdG9v
IGVhcmx5LCB3aGVuIGttYWxsb2NfY2FjaGVzIGFycmF5IGlzIG5vdCB5ZXQgcG9wdWxhdGVkLiBO
b3RlIGlmIHdlIGNhbGwNCj4ga21hbGxvYygpIGl0c2VsZiB0b28gZWFybHksIHdlIGdldCBhIE5V
TEwgYXMgYSByZXN1bHQsIEFGQUlDUy4gSSBjYW4gaW1hZ2luZQ0KPiB0d28gc2NlbmFyaW9zOg0K
PiANCj4gLSBrbWFsbG9jX3NpemVfcm91bmR1cCgpIGlzIGNhbGxlZCB3aXRoIHJlc3VsdCBpbW1l
ZGlhdGVseSBmZWQgdG8ga21hbGxvYygpDQo+IHRoYXQgaGFwcGVucyB0b28gZWFybHksIGluIHRo
YXQgY2FzZSB3ZSBiZXN0IHNob3VsZCBub3QgY3Jhc2ggb24gYyBiZWluZw0KPiBOVUxMIGFuZCBt
YWtlIHN1cmUgdGhlIGttYWxsb2MoKSByZXR1cm5zIE5VTEwuDQo+IC0ga21hbGxvY19zaXplX3Jv
dW5kdXAoKSBpcyBjYWxsZWQgaW4gc29tZSBpbml0IGNvZGUgdG8gZ2V0IGEgdmFsdWUgdGhhdA0K
PiBzb21lIGxhdGVyIGttYWxsb2MoKSBjYWxsIHVzZXMuIFdlIG1pZ2h0IHdhbnQgYWxzbyBub3Qg
Y3Jhc2ggaW4gdGhhdCBjYXNlLA0KPiBidXQgaW5mb3JtaW5nIHRoZSBkZXZlbG9wZXIgdGhhdCB0
aGV5IGRpZCBzb21ldGhpbmcgd3Jvbmcgd291bGQgYmUgYWxzbyB1c2VmdWw/DQo+IA0KPiBDbGVh
cmx5IHJldHVybmluZyAwIGlmIGMgPT0gTlVMTCwgYXMgZG9uZSBjdXJyZW50bHksIGlzIHdyb25n
IGZvciBib3RoDQo+IHNjZW5hcmlvcy4gUmV0dW5pbmcgInNpemUiIGlzIE9LIGZvciB0aGUgZmly
c3Qgc2NlbmFyaW8sIGFsc28gdmFsaWQgZm9yIHRoZQ0KPiBzZWNvbmQgb25lLCBidXQgdGhlIGNh
bGxlciB3aWxsIHNpbGVudGx5IGxvc2UgdGhlIGJlbmVmaXQgb2YNCj4ga21hbGxvY19zaXplX3Jv
dW5kdXAoKSBhbmQgdGhlIGRldmVsb3BlciBpbnRyb2R1Y2luZyB0aGF0IHdvbid0IHJlYWxpemUg
aXQncw0KPiBkb25lIHRvbyBlYXJseSBhbmQgY291bGQgYmUgZml4ZWQuDQoNCkknbSBzdXJlIHRo
YXQgd29uJ3QgbWF0dGVyLg0KDQo+IFNvIHBlcmhhcHMgdGhlIGJlc3Qgd291bGQgYmUgdG8gcmV0
dXJuIHNpemUgZm9yIGMgPT0gTlVMTCwgYnV0IGFsc28gZG8gYQ0KPiBXQVJOX09OQ0U/DQoNClRo
YXQgd291bGQgYWRkIGEgcmVhbCBmdW5jdGlvbiBjYWxsIHRvIGFuIG90aGVyd2lzZSBsZWFmIGZ1
bmN0aW9uDQphbmQgYWxtb3N0IGNlcnRhaW5seSByZXF1aXJlIHRoZSBjb21waWxlciBjcmVhdGUg
YSBzdGFjayBmcmFtZS4NCg0KLi4uDQoNCkkgZGlkIGhhdmUgYW4gaW50ZXJlc3RpbmcgJ2xhdGVy
YWwgdGhvdWdodCcgaWRlYS4NCkl0IGlzIGFsbCB2ZXJ5IHNpbGx5IGRvaW5nIGFsbCB0aGUgd29y
ayB0d2ljZSwgd2hhdCB5b3UgcmVhbGx5DQp3YW50IGlzIGttYWxsb2MoKSB0byByZXR1cm4gYm90
aCB0aGUgcG9pbnRlciBhbmQgYWN0dWFsIHNpemUuDQpCdXQgcmV0dXJuaW5nIGEgJ3R3byB3b3Jk
JyBzdHJ1Y3R1cmUgaXMgZG9uZSBieSByZWZlcmVuY2UgYW5kDQp3b3VsZCBraWxsIHBlcmZvcm1h
bmNlLw0KT1RPSCBhIGxvdCBvZiBhcmNocyBjYW4gcmV0dXJuIHR3byB3b3JkIGludGVnZXJzIGlu
IGEgcmVnaXN0ZXIgcGFpcg0KKGR4OmF4IG9uIHg4NikuDQpDb3VsZCB5b3UgaGF2ZSB0aGUgcmVh
bCBmdW5jdGlvbiByZXR1cm4gKCh1bnNpZ25lZCBfX2ludDY0KXNpemUgPDwgNjQgfCAobG9uZylw
dHIpDQphbmQgdGhlbiBleHRyYWN0IHRoZSBzaXplIGluIGEgd3JhcHBlciBtYWNybz8NCihXaXRo
IGRpZmZlcmVudCB0eXBlcyBmb3IgMzJiaXQpDQoNClRoYXQgd2lsbCwgb2YgY291cnNlLCBicmVh
ayB0aGUgJ2l0J3MgbGlrZSBtYWxsb2MnIGNoZWNrcyB0aGUNCmNvbXBpbGVyIGlzIGRvaW5nIC0g
dW5sZXNzIGl0IGlzIHRhdWdodCB3aGF0IGlzIGdvaW5nIG9uLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

