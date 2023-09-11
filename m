Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB06B79ACD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbjIKVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbjIKQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:39:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3504D3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:39:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-93-0C-wAUcbNBCmRkvM2PftBQ-1; Mon, 11 Sep 2023 17:38:59 +0100
X-MC-Unique: 0C-wAUcbNBCmRkvM2PftBQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Sep
 2023 17:38:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 11 Sep 2023 17:38:46 +0100
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
Thread-Index: Adnhh8rbtLpHk7QBQE+HpPR0NWDZ5gAMq8SAABymU5AApLGGAAACRmZQ///11gD//+uuIA==
Date:   Mon, 11 Sep 2023 16:38:46 +0000
Message-ID: <e12d3085c8b8414b837bfc737af0c9de@AcuMS.aculab.com>
References: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
 <202309071235.CB4F6B2@keescook>
 <20ca0a567a874052a1161e9be0870463@AcuMS.aculab.com>
 <e17c58a4-2dd8-4a1b-9feb-ab307e3877c2@suse.cz>
 <1bf41b7c8d7c428c8bfb5504ec9f680e@AcuMS.aculab.com>
 <1d634412-c0e5-4c16-92a4-447bde684ad6@suse.cz>
In-Reply-To: <1d634412-c0e5-4c16-92a4-447bde684ad6@suse.cz>
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

RnJvbTogVmxhc3RpbWlsIEJhYmthDQo+IFNlbnQ6IDExIFNlcHRlbWJlciAyMDIzIDE3OjIzDQo+
IA0KPiBPbiA5LzExLzIzIDE4OjEyLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogVmxh
c3RpbWlsIEJhYmthDQo+ID4+IFNlbnQ6IDExIFNlcHRlbWJlciAyMDIzIDE2OjU0DQo+ID4+DQo+
ID4+IE9uIDkvOC8yMyAxMDoyNiwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+PiA+IEZyb206IEtl
ZXMgQ29vaw0KPiA+PiA+PiBTZW50OiAwNyBTZXB0ZW1iZXIgMjAyMyAyMDozOA0KPiA+PiA+Pg0K
PiA+PiA+PiBPbiBUaHUsIFNlcCAwNywgMjAyMyBhdCAxMjo0MjoyMFBNICswMDAwLCBEYXZpZCBM
YWlnaHQgd3JvdGU6DQo+ID4+ID4+ID4gVGhlIHR5cGljYWwgdXNlIG9mIGttYWxsb2Nfc2l6ZV9y
b3VuZHVwKCkgaXM6DQo+ID4+ID4+ID4gCXB0ciA9IGttYWxsb2Moc3ogPSBrbWFsbG9jX3NpemVf
cm91bmR1cChzaXplKSwgLi4uKTsNCj4gPj4gPj4gPiAJaWYgKCFwdHIpIHJldHVybiAtRU5PTUVN
Lg0KLi4uDQo+ID4+ID4+ID4gKwkJYyA9IGttYWxsb2Nfc2xhYihzaXplLCBHRlBfS0VSTkVMLCAw
KTsNCj4gPj4gPj4gPiArCQlyZXR1cm4gbGlrZWx5KGMpID8gYy0+b2JqZWN0X3NpemUgOiBzaXpl
Ow0KPiA+PiA+Pg0KPiA+PiA+PiBJIHdvdWxkIGxpa2UgdG8gaGF2ZSB0aGlzIGZhaWwgInNhZmUi
LiBjIHNob3VsZCBuZXZlciBiZSBOVUxMIGhlcmUsIHNvDQo+ID4+ID4+IGxldCdzIHJldHVybiAi
S01BTExPQ19NQVhfU0laRSArIDEiIHRvIGZvcmNlIGZhaWx1cmVzLg0KPiA+PiA+DQo+ID4+ID4g
V2h5IGV2ZW4gdHJ5IHRvIGZvcmNlIGZhaWx1cmUgaGVyZT8NCj4gPj4gPiBUaGUgd2hvbGUgZnVu
Y3Rpb24gaXMganVzdCBhbiBvcHRpbWlzYXRpb24gc28gdGhhdCB0aGUgY2FsbGVyDQo+ID4+ID4g
Y2FuIHVzZSB0aGUgc3BhcmUgc3BhY2UuDQo+ID4+ID4NCj4gPj4gPiBUaGUgb25seSB0aGluZyBp
dCBtdXN0bid0IGRvIGlzIHJldHVybiBhIHNtYWxsZXIgdmFsdWUuDQo+ID4+DQo+ID4+IElmICJj
IiBpcyBOVUxMIGl0IG1lYW5zIGVpdGhlciB0aGUga2VybmVsIGJ1aWxkIG11c3QgYmUgYnJva2Vu
IGUuZy4gYnkNCj4gPj4gc29tZWJvZHkgYnJlYWtpbmcgdGhlIEtNQUxMT0NfTUFYX0NBQ0hFX1NJ
WkUgdmFsdWUsIGFuZCB3ZSBjb3VsZCBqdXN0IGlnbm9yZQ0KPiA+PiBjIGJlaW5nIE5VTEwgYW5k
IGxldCBpdCBjcmFzaCBiZWNhdXNlIG9mIHRoYXQuDQo+ID4+IEJ1dCBJIHRoaW5rIGl0IGNhbiBh
bHNvIGJlIE5VTEwgZHVlIHRvIHRyeWluZyB0byBjYWxsIGttYWxsb2Nfc2l6ZV9yb3VuZHVwKCkN
Cj4gPj4gdG9vIGVhcmx5LCB3aGVuIGttYWxsb2NfY2FjaGVzIGFycmF5IGlzIG5vdCB5ZXQgcG9w
dWxhdGVkLiBOb3RlIGlmIHdlIGNhbGwNCj4gPj4ga21hbGxvYygpIGl0c2VsZiB0b28gZWFybHks
IHdlIGdldCBhIE5VTEwgYXMgYSByZXN1bHQsIEFGQUlDUy4gSSBjYW4gaW1hZ2luZQ0KPiA+PiB0
d28gc2NlbmFyaW9zOg0KPiA+Pg0KPiA+PiAtIGttYWxsb2Nfc2l6ZV9yb3VuZHVwKCkgaXMgY2Fs
bGVkIHdpdGggcmVzdWx0IGltbWVkaWF0ZWx5IGZlZCB0byBrbWFsbG9jKCkNCj4gPj4gdGhhdCBo
YXBwZW5zIHRvbyBlYXJseSwgaW4gdGhhdCBjYXNlIHdlIGJlc3Qgc2hvdWxkIG5vdCBjcmFzaCBv
biBjIGJlaW5nDQo+ID4+IE5VTEwgYW5kIG1ha2Ugc3VyZSB0aGUga21hbGxvYygpIHJldHVybnMg
TlVMTC4NCj4gPj4gLSBrbWFsbG9jX3NpemVfcm91bmR1cCgpIGlzIGNhbGxlZCBpbiBzb21lIGlu
aXQgY29kZSB0byBnZXQgYSB2YWx1ZSB0aGF0DQo+ID4+IHNvbWUgbGF0ZXIga21hbGxvYygpIGNh
bGwgdXNlcy4gV2UgbWlnaHQgd2FudCBhbHNvIG5vdCBjcmFzaCBpbiB0aGF0IGNhc2UsDQo+ID4+
IGJ1dCBpbmZvcm1pbmcgdGhlIGRldmVsb3BlciB0aGF0IHRoZXkgZGlkIHNvbWV0aGluZyB3cm9u
ZyB3b3VsZCBiZSBhbHNvIHVzZWZ1bD8NCj4gPj4NCj4gPj4gQ2xlYXJseSByZXR1cm5pbmcgMCBp
ZiBjID09IE5VTEwsIGFzIGRvbmUgY3VycmVudGx5LCBpcyB3cm9uZyBmb3IgYm90aA0KPiA+PiBz
Y2VuYXJpb3MuIFJldHVuaW5nICJzaXplIiBpcyBPSyBmb3IgdGhlIGZpcnN0IHNjZW5hcmlvLCBh
bHNvIHZhbGlkIGZvciB0aGUNCj4gPj4gc2Vjb25kIG9uZSwgYnV0IHRoZSBjYWxsZXIgd2lsbCBz
aWxlbnRseSBsb3NlIHRoZSBiZW5lZml0IG9mDQo+ID4+IGttYWxsb2Nfc2l6ZV9yb3VuZHVwKCkg
YW5kIHRoZSBkZXZlbG9wZXIgaW50cm9kdWNpbmcgdGhhdCB3b24ndCByZWFsaXplIGl0J3MNCj4g
Pj4gZG9uZSB0b28gZWFybHkgYW5kIGNvdWxkIGJlIGZpeGVkLg0KPiA+DQo+ID4gSSdtIHN1cmUg
dGhhdCB3b24ndCBtYXR0ZXIuDQo+IA0KPiBGb3IgdGhlIHBlcmZvcm1hbmNlLCBzdXJlLiBJdCBq
dXN0IGZlZWxzIHNpbGx5IHRvIG1lIHRvIGhhdmUgYSBjb2RlIHRoYXQNCj4gbG9va3MgbGlrZSBp
dCBkb2VzIHNvbWV0aGluZywgYnV0IHNpbGVudGx5IGRvZXNuJ3QuIExlYWRzIHRvIGNhcmdvIGN1
bHQNCj4gY29weWluZyBpdCB0byBvdGhlciBwbGFjZXMgZXRjLg0KPiANCj4gPj4gU28gcGVyaGFw
cyB0aGUgYmVzdCB3b3VsZCBiZSB0byByZXR1cm4gc2l6ZSBmb3IgYyA9PSBOVUxMLCBidXQgYWxz
byBkbyBhDQo+ID4+IFdBUk5fT05DRT8NCj4gPg0KPiA+IFRoYXQgd291bGQgYWRkIGEgcmVhbCBm
dW5jdGlvbiBjYWxsIHRvIGFuIG90aGVyd2lzZSBsZWFmIGZ1bmN0aW9uDQo+ID4gYW5kIGFsbW9z
dCBjZXJ0YWlubHkgcmVxdWlyZSB0aGUgY29tcGlsZXIgY3JlYXRlIGEgc3RhY2sgZnJhbWUuDQo+
IA0KPiBIbSBJIHRob3VnaHQgV0FSTiBpcyBkb25lIGJ5IHRyaXBwaW5nIG9uIHVuZGVmaW5lZCBp
bnN0cnVjdGlvbiBsaWtlIEJVRw0KPiB0aGVzZSBkYXlzLiBBbHNvIGFueSBjb2RlIHRoYXQgYWNj
ZXB0cyB0aGUgY2FsbCB0byBrbWFsbG9jX3NpemVfcm91bmR1cA0KPiBwcm9iYWJseSBjb3VsZCBh
Y2NlcHQgdGhhdCB0b28uDQoNCkl0J3MgcHJvYmFibHkganVzdCB3b3J0aCByZW1vdmluZyB0aGUg
YyA9PSBOVUxMIGNoZWNrIGFuZA0KYXNzdW1pbmcgdGhlcmUgd29uJ3QgYmUgYW55IGZhbGxvdXQu
DQpUaGUgTlVMTCBwb2ludGVyIGRlcmVmIGlzIGFuIGVhc3kgdG8gZGVidWcgYXMgYW55dGhpbmcg
ZWxzZS4NCg0KSWYgaXQgZ2V0cyBjYWxsZWQgaW4gYW55IGVhcmx5IGluaXQgY29kZSBpdCdsbCBz
b29uIHNob3cgdXAuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

