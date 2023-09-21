Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766637AA422
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjIUWBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIUWA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:00:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F265FD8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:57:40 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-144-9yHIHy7UMl2pr0pfl-TvIA-1; Thu, 21 Sep 2023 22:57:27 +0100
X-MC-Unique: 9yHIHy7UMl2pr0pfl-TvIA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Sep
 2023 22:57:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Sep 2023 22:57:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: RE: [RFC] Should writes to /dev/urandom immediately affect reads?
Thread-Topic: [RFC] Should writes to /dev/urandom immediately affect reads?
Thread-Index: AQHZ6/MdHsl+KD+hzUOipRl6ZArMFbAkCZmAgAADCACAAArEAIAAAxeAgAACfICAAbU2kA==
Date:   Thu, 21 Sep 2023 21:57:26 +0000
Message-ID: <4c5a6cd876d7499fa382ba74cd23cc08@AcuMS.aculab.com>
References: <20230920060615.GA2739@sol.localdomain>
 <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
 <20230920193203.GA914@sol.localdomain>
 <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
 <20230920202126.GC914@sol.localdomain>
 <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
 <CAHk-=wh+nAmcXV=Xz6fkDpazne+n+iFfGsnS=p9PjVLiEjiSvQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh+nAmcXV=Xz6fkDpazne+n+iFfGsnS=p9PjVLiEjiSvQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjAgU2VwdGVtYmVyIDIwMjMgMjE6NDENCj4g
DQo+IE9uIFdlZCwgMjAgU2VwdCAyMDIzIGF0IDEzOjMyLCBMaW51cyBUb3J2YWxkcw0KPiA8dG9y
dmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSXQgd2FzIHdoeSBJ
IGFsc28gYXNrZWQgYWJvdXQgZW50cm9weS4gQmVjYXVzZSAqaWYqIHlvdSBhcmd1ZSB0aGF0IHRo
ZQ0KPiA+IHVzZXItc3BhY2Ugd3JpdGUgY29udGFpbnMgZW50cm9weSwgdGhlbiB0aGF0IHdvdWxk
IGJlIGEgcmVhc29uLg0KPiANCj4gVG8gY2xhcmlmeSAtIHRoZSBqaXR0ZXIgZW50cm9weSBxdWVz
dGlvbiB3YXMgcmVsYXRlZCB0byB0aGF0IHNhbWUNCj4gYmFzaWMgaXNzdWU6IGlmIHRoaXMgd2Fz
IG1lYW50IHRvIGJlIGEgd2F5IHRvIG1pdGlnYXRlIHRoZSBsYWNrIG9mDQo+IGppdHRlciBlbnRy
b3B5IG9uIHNvbWUgcGxhdGZvcm0geW91IGNhcmUgYWJvdXQsIHRoYXQgd291bGQgYWdhaW4NCj4g
cG9zc2libHkgYmUgYSByZWFzb24gdG8gY2FyZS4NCj4gDQo+IENvbnNpZGVyaW5nIHRoYXQgd2Ug
YXBwYXJlbnRseSBoYXZlbid0IGNhcmVkIGZvciB0aGUgbGFzdCA3IHllYXJzLCBJJ20NCj4gc3Rp
bGwgYSBiaXQgc3VycHJpc2VkLCBidXQgd2hhdGV2ZXIuDQo+IA0KPiBXaGF0IEkgKmRvbid0KiB3
YW50IGlzIGp1c3QgbW9yZSB2b29kb28gZGlzY3Vzc2lvbnMgYWJvdXQgL2Rldi8qcmFuZG9tDQo+
IGJlaGF2aW9yIHRoYXQgZG9lc24ndCBoYXZlIGEgdGVjaG5pY2FsIHJlYXNvbiBmb3IgaXQuDQoN
ClRoaXMgbWlnaHQgYWxsIGJlIHJlbGF0ZWQgdG8gYW4gb25nb2luZyByZXBlYXQgb2YgdGhlICdo
b3cgdG8gaW5pdGlhbGlzZQ0KL2Rldi91cmFuZG9tJyBvbiB0aGUgYnVzeWJveCBsaXN0Lg0KDQpT
dWNoIHN5c3RlbXMgYXJlIG11Y2ggbW9yZSBsaWtlbHkgdG8gYmUgcnVubmluZyBjb21wbGV0ZWx5
IGppdHRlci1mcmVlDQpjcHUgdGhhdCBib290IGZyb20gZW1iZWRkZWQgc2VyaWFsIGZsYXNoIHdp
dGggYWJzb2x1dGVseSBjb25zdGFudA0KYWNjZXNzIHRpbWVzLg0KVGhlIG9ubHkgd2F5IHlvdSBh
cmUgZ29pbmcgdG8gZ2V0IGFueSBlbnRyb3B5IGVhcmx5IG9uIGlzIHRvIGhhdmUNCnNhdmVkIGl0
IGZyb20gdGhlIHByZXZpb3VzIGJvb3QuDQpJIGRvbid0IHRoaW5rIGl0IG1ha2VzIGFueSByZWFs
IHNlbnNlIHNvIHNhdmUgaXQgdG9vIGVhcmx5IC0geW91IGp1c3QNCmVuZCB1cCB3aXRoIGFuIGVu
Y29kZWQgJ2NvdW50IG9mIHRoZSBudW1iZXIgb2YgYm9vdHMnLg0KDQpBdCB0aGUgbW9tZW50IGl0
IGlzIHByZXR0eSBoYXJkIHRvIGFkZCB0aGUgc2F2ZWQgZW50cm9weS4NCkFuZCB5b3UgZG8gd2Fu
dCBpdCB0byBiZSB1c2VkIGltbWVkaWF0ZWx5IC0gYmVjYXVzZSB3aGF0IHRoZQ0Ka2VybmVsIGhh
cyBpdCBsaWtlbHkgdG8gYmUgcHJldHR5IGxpbWl0ZWQuDQoNCk5vdywgb25jZSB0aGUgc3RhcnR1
cCBzY3JpcHRzIGhhdmUgcnVuIHlvdSBtaWdodCBkZWNpZGUgdGhhdCBhbg0KaW1tZWRpYXRlIHJl
aGFzaCBpc24ndCBuZWVkZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

