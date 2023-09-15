Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC317A17DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjIOH5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:57:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABFB619A0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:57:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-ooYdAIyBNp-dk--bK--xgg-1; Fri, 15 Sep 2023 08:57:26 +0100
X-MC-Unique: ooYdAIyBNp-dk--bK--xgg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Sep
 2023 08:57:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 15 Sep 2023 08:57:22 +0100
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
Thread-Index: AQHZ5t2uDoI3R+Ee30ay/cEMVFilT7AaADQQgABZ2YCAABclwIAAA5uAgAEQ8sA=
Date:   Fri, 15 Sep 2023 07:57:22 +0000
Message-ID: <abdde70ac5b947508c8c71d72ec4f294@AcuMS.aculab.com>
References: <20230818194136.4084400-1-evan@rivosinc.com>
 <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
 <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
 <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
 <de95229a14614198894a8ce421c30d94@AcuMS.aculab.com>
 <CALs-Hstcz3OAxUi80nm+U0R56VBUUPQT=+XMOLpVJsn2ZOcM1A@mail.gmail.com>
 <172bc43cc2ac45239ec40477d53d263a@AcuMS.aculab.com>
 <CALs-HsvMfrsPsG2b9imLNOJFH6Xk45G0=UPWGtExePiMKV6+1Q@mail.gmail.com>
In-Reply-To: <CALs-HsvMfrsPsG2b9imLNOJFH6Xk45G0=UPWGtExePiMKV6+1Q@mail.gmail.com>
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

RnJvbTogRXZhbiBHcmVlbg0KPiBTZW50OiAxNCBTZXB0ZW1iZXIgMjAyMyAxNzozNw0KPiANCj4g
T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgODo1NeKAr0FNIERhdmlkIExhaWdodCA8RGF2aWQuTGFp
Z2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogRXZhbiBHcmVlbg0KPiA+ID4g
U2VudDogMTQgU2VwdGVtYmVyIDIwMjMgMTY6MDENCj4gPiA+DQo+ID4gPiBPbiBUaHUsIFNlcCAx
NCwgMjAyMyBhdCAxOjQ34oCvQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNv
bT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbg0KPiA+
ID4gPiA+IFNlbnQ6IDE0IFNlcHRlbWJlciAyMDIzIDA4OjMzDQo+ID4gPiA+IC4uLg0KPiA+ID4g
PiA+ID4gPiAgICAgcnpmaXZlOg0KPiA+ID4gPiA+ID4gPiAgICAgICAgIGNwdTA6IFJhdGlvIG9m
IGJ5dGUgYWNjZXNzIHRpbWUgdG8gdW5hbGlnbmVkIHdvcmQgYWNjZXNzIGlzDQo+ID4gPiA+ID4g
PiA+IDEuMDUsIHVuYWxpZ25lZCBhY2Nlc3NlcyBhcmUgZmFzdA0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IEhybSwgSSdtIGEgbGl0dGxlIHN1cnByaXNlZCB0byBiZSBzZWVpbmcgdGhpcyBudW1i
ZXIgY29tZSBvdXQgc28gY2xvc2UNCj4gPiA+ID4gPiA+IHRvIDEuIElmIHlvdSByZWJvb3QgYSBm
ZXcgdGltZXMsIHdoYXQga2luZCBvZiB2YXJpYW5jZSBkbyB5b3UgZ2V0IG9uDQo+ID4gPiA+ID4g
PiB0aGlzPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUm9jay1zb2xpZCBhdCAxLjA1IChldmVuIHdp
dGggaW5jcmVhc2VkIHJlc29sdXRpb246IDEuMDU4NTMgb24gMyB0cmllcykNCj4gPiA+ID4NCj4g
PiA+ID4gV291bGQgdGhhdCBtYXRjaCB6ZXJvIG92ZXJoZWFkIHVubGVzcyB0aGUgYWNjZXNzIGNy
b3NzZXMgYQ0KPiA+ID4gPiBjYWNoZSBsaW5lIGJvdW5kYXJ5Pw0KPiA+ID4gPiAoSSBjYW4ndCBy
ZW1lbWJlciB3aGV0aGVyIHRoZSB0ZXN0IGlzIHVzaW5nIGluY3JlYXNpbmcgYWRkcmVzc2VzLikN
Cj4gPiA+DQo+ID4gPiBZZXMsIHRoZSB0ZXN0IGRvZXMgdXNlIGluY3JlYXNpbmcgYWRkcmVzc2Vz
LCBpdCBjb3BpZXMgYWNyb3NzIDQgcGFnZXMuDQo+ID4gPiBXZSBzdGFydCB3aXRoIGEgd2FybXVw
LCBzbyBjYWNoaW5nIGVmZmVjdHMgYmV5b25kIEwxIGFyZSBsYXJnZWx5IG5vdA0KPiA+ID4gdGFr
ZW4gaW50byBhY2NvdW50Lg0KPiA+DQo+ID4gVGhhdCBzZWVtcyBlbnRpcmVseSBleGNlc3NpdmUu
DQo+ID4gSWYgeW91IHdhbnQgdG8gYXZvaWQgZGF0YSBjYWNoZSBpc3N1ZXMgKHdoaWNoIHByb2Jh
Ymx5IGRvKQ0KPiA+IHRoZW4ganVzdCByZXBlYXRpbmcgYSBzaW5nbGUgYWNjZXNzIHdvdWxkIGFs
bW9zdCBjZXJ0YWlubHkNCj4gPiBzdWZmaWNlLg0KPiA+IFJlcGVhdGVkbHkgdXNpbmcgYSBzaG9y
dCBidWZmZXIgKHNheSAyNTYgYnl0ZXMpIHdvbid0IGFkZA0KPiA+IG11Y2ggbG9vcCBvdmVyaGVh
ZC4NCj4gPiBBbHRob3VnaCB5b3UgbWF5IHdhbnQgdG8gZG8gYSB0ZXN0IHRoYXQgYXZvaWRzIHRy
YW5zZmVycw0KPiA+IHRoYXQgY3Jvc3MgY2FjaGUgbGluZSBhbmQgZXNwZWNpYWxseSBwYWdlIGJv
dW5kYXJpZXMuDQo+ID4gRWl0aGVyIG9mIHRob3NlIGNvdWxkIGVhc2lseSBiZSBtdWNoIHNsb3dl
ciB0aGFuIGEgcmVhZA0KPiA+IHRoYXQgaXMgZW50aXJlbHkgd2l0aGluIGEgY2FjaGUgbGluZS4N
Cj4gDQo+IFdlIHdvbid0IGJlIGZhdWx0aW5nIG9uIGFueSBvZiB0aGVzZSBwYWdlcywgYW5kIHRo
ZXkgc2hvdWxkIHJlbWFpbiBpbg0KPiB0aGUgVExCLCBzbyBJIGRvbid0IGV4cGVjdCBtYW55IHBh
Z2UgYm91bmRhcnkgc3BlY2lmaWMgZWZmZWN0cy4gSWYNCj4gdGhlcmUgaXMgYSBzdGVlcCBwZW5h
bHR5IGZvciBtaXNhbGlnbmVkIGxvYWRzIGFjcm9zcyBhIGNhY2hlIGxpbmUsDQo+IHN1Y2ggdGhh
dCBpdCdzIHdvcnNlIHRoYW4gZG9pbmcgYnl0ZSBhY2Nlc3NlcywgSSB3YW50IHRoZSB0ZXN0IHJl
c3VsdHMNCj4gdG8gYmUgZGluZ2VkIGZvciB0aGF0Lg0KDQpUaGF0IGlzIGFuIGVudGlyZWx5IGRp
ZmZlcmVudCBpc3N1ZS4NCg0KQXJlIHlvdSBhYnNvbHV0ZWx5IGNlcnRhaW4gdGhhdCB0aGUgcmVh
c29uIDggYnl0ZSBsb2FkcyB0YWtlDQphcyBsb25nIGFzIGEgNjQtYml0IG1pcy1hbGlnbmVkIGxv
YWQgaXNuJ3QgYmVjYXVzZSB0aGUgZW50aXJlDQp0ZXN0IGlzIGxpbWl0ZWQgYnkgTDEgY2FjaGUg
ZmlsbHM/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

