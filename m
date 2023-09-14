Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2E7A09DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbjINP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241366AbjINP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:56:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8860E1FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:55:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-162-aexGLwkiOnauP1AYfmqQIw-1; Thu, 14 Sep 2023 16:55:45 +0100
X-MC-Unique: aexGLwkiOnauP1AYfmqQIw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Sep
 2023 16:55:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 14 Sep 2023 16:55:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Evan Green' <evan@rivosinc.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Sia Jee Heng" <jeeheng.sia@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Simon Hosie" <shosie@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        "Ley Foon Tan" <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Andy Chiu" <andy.chiu@sifive.com>
Subject: RE: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
Thread-Topic: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
Thread-Index: AQHZ5t2uDoI3R+Ee30ay/cEMVFilT7AaADQQgABZ2YCAABclwA==
Date:   Thu, 14 Sep 2023 15:55:41 +0000
Message-ID: <172bc43cc2ac45239ec40477d53d263a@AcuMS.aculab.com>
References: <20230818194136.4084400-1-evan@rivosinc.com>
 <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
 <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
 <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
 <de95229a14614198894a8ce421c30d94@AcuMS.aculab.com>
 <CALs-Hstcz3OAxUi80nm+U0R56VBUUPQT=+XMOLpVJsn2ZOcM1A@mail.gmail.com>
In-Reply-To: <CALs-Hstcz3OAxUi80nm+U0R56VBUUPQT=+XMOLpVJsn2ZOcM1A@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXZhbiBHcmVlbg0KPiBTZW50OiAxNCBTZXB0ZW1iZXIgMjAyMyAxNjowMQ0KPiANCj4g
T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMTo0N+KAr0FNIERhdmlkIExhaWdodCA8RGF2aWQuTGFp
Z2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVu
DQo+ID4gPiBTZW50OiAxNCBTZXB0ZW1iZXIgMjAyMyAwODozMw0KPiA+IC4uLg0KPiA+ID4gPiA+
ICAgICByemZpdmU6DQo+ID4gPiA+ID4gICAgICAgICBjcHUwOiBSYXRpbyBvZiBieXRlIGFjY2Vz
cyB0aW1lIHRvIHVuYWxpZ25lZCB3b3JkIGFjY2VzcyBpcw0KPiA+ID4gPiA+IDEuMDUsIHVuYWxp
Z25lZCBhY2Nlc3NlcyBhcmUgZmFzdA0KPiA+ID4gPg0KPiA+ID4gPiBIcm0sIEknbSBhIGxpdHRs
ZSBzdXJwcmlzZWQgdG8gYmUgc2VlaW5nIHRoaXMgbnVtYmVyIGNvbWUgb3V0IHNvIGNsb3NlDQo+
ID4gPiA+IHRvIDEuIElmIHlvdSByZWJvb3QgYSBmZXcgdGltZXMsIHdoYXQga2luZCBvZiB2YXJp
YW5jZSBkbyB5b3UgZ2V0IG9uDQo+ID4gPiA+IHRoaXM/DQo+ID4gPg0KPiA+ID4gUm9jay1zb2xp
ZCBhdCAxLjA1IChldmVuIHdpdGggaW5jcmVhc2VkIHJlc29sdXRpb246IDEuMDU4NTMgb24gMyB0
cmllcykNCj4gPg0KPiA+IFdvdWxkIHRoYXQgbWF0Y2ggemVybyBvdmVyaGVhZCB1bmxlc3MgdGhl
IGFjY2VzcyBjcm9zc2VzIGENCj4gPiBjYWNoZSBsaW5lIGJvdW5kYXJ5Pw0KPiA+IChJIGNhbid0
IHJlbWVtYmVyIHdoZXRoZXIgdGhlIHRlc3QgaXMgdXNpbmcgaW5jcmVhc2luZyBhZGRyZXNzZXMu
KQ0KPiANCj4gWWVzLCB0aGUgdGVzdCBkb2VzIHVzZSBpbmNyZWFzaW5nIGFkZHJlc3NlcywgaXQg
Y29waWVzIGFjcm9zcyA0IHBhZ2VzLg0KPiBXZSBzdGFydCB3aXRoIGEgd2FybXVwLCBzbyBjYWNo
aW5nIGVmZmVjdHMgYmV5b25kIEwxIGFyZSBsYXJnZWx5IG5vdA0KPiB0YWtlbiBpbnRvIGFjY291
bnQuDQoNClRoYXQgc2VlbXMgZW50aXJlbHkgZXhjZXNzaXZlLg0KSWYgeW91IHdhbnQgdG8gYXZv
aWQgZGF0YSBjYWNoZSBpc3N1ZXMgKHdoaWNoIHByb2JhYmx5IGRvKQ0KdGhlbiBqdXN0IHJlcGVh
dGluZyBhIHNpbmdsZSBhY2Nlc3Mgd291bGQgYWxtb3N0IGNlcnRhaW5seQ0Kc3VmZmljZS4NClJl
cGVhdGVkbHkgdXNpbmcgYSBzaG9ydCBidWZmZXIgKHNheSAyNTYgYnl0ZXMpIHdvbid0IGFkZA0K
bXVjaCBsb29wIG92ZXJoZWFkLg0KQWx0aG91Z2ggeW91IG1heSB3YW50IHRvIGRvIGEgdGVzdCB0
aGF0IGF2b2lkcyB0cmFuc2ZlcnMNCnRoYXQgY3Jvc3MgY2FjaGUgbGluZSBhbmQgZXNwZWNpYWxs
eSBwYWdlIGJvdW5kYXJpZXMuDQpFaXRoZXIgb2YgdGhvc2UgY291bGQgZWFzaWx5IGJlIG11Y2gg
c2xvd2VyIHRoYW4gYSByZWFkDQp0aGF0IGlzIGVudGlyZWx5IHdpdGhpbiBhIGNhY2hlIGxpbmUu
DQoNCi4uLg0KPiA+ID4gPiA+ICAgICB2ZXhyaXNjdi9vcmFuZ2VjcmFiOg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gICAgICAgICBjcHUwOiBSYXRpbyBvZiBieXRlIGFjY2VzcyB0aW1lIHRvIHVuYWxp
Z25lZCB3b3JkIGFjY2VzcyBpcw0KPiA+ID4gPiA+IDAuMDAsIHVuYWxpZ25lZCBhY2Nlc3NlcyBh
cmUgc2xvdw0KPiA+ID4NCj4gPiA+IGNwdTA6IFJhdGlvIG9mIGJ5dGUgYWNjZXNzIHRpbWUgdG8g
dW5hbGlnbmVkIHdvcmQgYWNjZXNzIGlzIDAuMDA0MTcsDQo+ID4gPiB1bmFsaWduZWQgYWNjZXNz
ZXMgYXJlIHNsb3cNCj4gPiA+DQo+ID4gPiA+ID4gSSBhbSBhIGJpdCBzdXJwcmlzZWQgYnkgdGhl
IG5lYXItemVybyB2YWx1ZXMuICBBcmUgdGhlc2UgZXhwZWN0ZWQ/DQo+ID4gPiA+DQo+ID4gPiA+
IFRoaXMgY291bGQgYmUgZXhwZWN0ZWQsIGlmIGZpcm13YXJlIGlzIHRyYXBwaW5nIHRoZSB1bmFs
aWduZWQgYWNjZXNzZXMNCj4gPiA+ID4gYW5kIGNvbWluZyBvdXQgPjEwMHggc2xvd2VyIHRoYW4g
YSBuYXRpdmUgYWNjZXNzLiBJZiB5b3UncmUgaW50ZXJlc3RlZA0KPiA+ID4gPiBpbiBnZXR0aW5n
IGEgbGl0dGxlIG1vcmUgcmVzb2x1dGlvbiwgeW91IGNvdWxkIHRyeSB0byBwcmludCBhIGZldyBt
b3JlDQo+ID4gPiA+IGRlY2ltYWwgcGxhY2VzIHdpdGggc29tZXRoaW5nIGxpa2UgKHNvcnJ5IGdt
YWlsIG1hbmdsZXMgdGhlIHdoaXRlc3BhY2UNCj4gPiA+ID4gb24gdGhpcyk6DQo+ID4NCj4gPiBJ
J2QgZXhwZWN0IG9uZSBvZiB0aHJlZSBwb3NzaWJsZSB2YWx1ZXM6DQo+ID4gLSAxLjB4OiBCYXNp
Y2FsbHkgemVybyBjb3N0IGV4Y2VwdCBmb3IgY2FjaGUgbGluZS9wYWdlIGJvdW5kYXJpZXMuDQo+
ID4gLSB+MjogSGFyZHdhcmUgZG9lcyB0d28gcmVhZHMgYW5kIG1lcmdlcyB0aGUgdmFsdWVzLg0K
PiA+IC0gPjEwMDogVHJhcCBmaXhlZCB1cCBpbiBzb2Z0d2FyZS4NCj4gPg0KPiA+IEknZCB0aGlu
ayB0aGUgJzInIGNhc2UgY291bGQgYmUgY29uc2lkZXJlZCBmYXN0Lg0KPiA+IFlvdSBvbmx5IG5l
ZWQgdG8gdGltZSBvbmUgYWNjZXNzIHRvIHNlZSBpZiBpdCB3YXMgYSBmYXVsdC4NCj4gDQo+IFdl
J3JlIGNvbXBhcmluZyBtaXNhbGlnbmVkIHdvcmQgYWNjZXNzZXMgd2l0aCBieXRlIGFjY2Vzc2Vz
IG9mIHRoZQ0KPiBzYW1lIHRvdGFsIHNpemUuIFNvIDEuMCBtZWFucyBhIG1pc2FsaWduZWQgbG9h
ZCBpcyBiYXNpY2FsbHkgbm8NCj4gZGlmZmVyZW50IGZyb20gOCBieXRlIGxvYWRzLiBUaGUgZ29h
bCB3YXMgdG8gaGVscCBwZW9wbGUgdGhhdCBhcmUNCj4gZm9yY2VkIHRvIGRvIG9kZCBsb2FkcyBh
bmQgc3RvcmVzIGRlY2lkZSB3aGV0aGVyIHRoZXkgYXJlIGJldHRlciBvZmYNCj4gbW92aW5nIGJ5
IGJ5dGVzIG9yIGJ5IG1pc2FsaWduZWQgd29yZHMuIChJbiBjb250cmFzdCwgdGhlIGFuc3dlciB0
bw0KPiAic2hvdWxkIEkgZG8gYSBtaXNhbGlnbmVkIHdvcmQgbG9hZCBvciBhbiBhbGlnbmVkIHdv
cmQgbG9hZCIgaXMNCj4gZ2VuZXJhbGx5IGFsd2F5cyAiZG8gdGhlIGFsaWduZWQgb25lIGlmIHlv
dSBjYW4iLCBzbyBjb21wYXJpbmcgdGhvc2UNCj4gdHdvIHRoaW5ncyBkaWRuJ3Qgc2VlbSBhcyB1
c2VmdWwpLg0KDQpBaCwgSSdkIGhhdmUgY29tcGFyZWQgdGhlIGNvc3Qgb2YgYWxpZ25lZCBhY2Nl
c3NlcyB3aXRoIG1pc2FsaWduZWQgb25lcy4NClRoYXQgd291bGQgdGVsbCB5b3Ugd2hldGhlciB5
b3UgcmVhbGx5IG5lZWQgdG8gYXZvaWQgdGhlbS4NClRoZSBjb3N0IG9mIGJ5dGUgYW5kIGFsaWdu
ZWQgd29yZCBhY2Nlc3NlcyBzaG91bGQgYmUgbXVjaCB0aGUgc2FtZQ0KKGZvciBlYWNoIGFjY2Vz
cyB0aGF0IGlzKSAtIGlmIG5vdCB5b3UndmUgZ290IGEgcmVhbCBib3R0bGVuZWNrLg0KDQpJZiBh
IG1pc2FsaWduZWQgYWNjZXNzIGlzIDggdGltZXMgc2xvd2VyIHRoYW4gYW4gYWxpZ25lZCBvbmUN
Cml0IGlzIHN0aWxsICdxdWl0ZSBzbG93Jy4NCkknZCBkZWZpbml0ZWx5IGNhbGwgdGhhdCA4IG5v
dCAxIC0gZXZlbiBpZiB5b3UgdHJlYXQgaXQgYXMgJ2Zhc3QnLg0KDQpGb3IgY29tcGFyaXNvbiB5
b3UgKHdlbGwgSSkgY2FuIHdyaXRlIHg2NC02NCBhc20gZm9yIHRoZSBpcC1jaGVja3N1bQ0KbG9v
cCB0aGF0IHdpbGwgZXhlY3V0ZSAxIG1lbW9yeSByZWFkIGV2ZXJ5IGNsb2NrICg4IGJ5dGVzL2Ns
b2NrKS4NCkl0IGlzIHZlcnkgc2xpZ2h0bHkgc2xvd2VyIGZvciBtaXNhbGlnbmVkIGJ1ZmZlcnMs
IGJ1dCBieSBsZXNzDQp0aGFuIDEgY2xvY2sgcGVyIGNhY2hlIGxpbmUuDQpUaGF0J3Mgd2hhdCBJ
J2QgY2FsbCAxLjAgOi0pDQoNCkknZCBleHBlY3QgZXZlbiBzaW1wbGUgaGFyZHdhcmUgdG8gZG8g
bWlzYWxpZ25lZCByZWFkcyBhcyB0d28NCnJlYWRzIGFuZCB0aGVuIG1lcmdlIHRoZSBkYXRhIC0g
c28gc2hvdWxkIHJlYWxseSBiZSBubyBzbG93ZXINCnRoYW4gdHdvIHNlcGFyYXRlIGFsaWduZWQg
cmVhZHMuDQpTaW5jZSB5b3UnZCBleHBlY3QgYSBjcHUgdG8gZG8gYW4gTDEgZGF0YSBjYWNoZSBy
ZWFkIGV2ZXJ5IGNsb2NrDQoocHJvYmFibHkgcGlwZWxpbmVkKSB0aGUgbWlzYWxpZ25lZCByZWFk
IHNob3VsZCBqdXN0IGFkZCAxIGNsb2NrLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

