Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C357A1771
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjIOH37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIOH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:29:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3927719A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:29:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-4Gk51lTPOEe7Li4u2XVmiA-1; Fri, 15 Sep 2023 08:29:26 +0100
X-MC-Unique: 4Gk51lTPOEe7Li4u2XVmiA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Sep
 2023 08:29:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 15 Sep 2023 08:29:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Charlie Jenkins' <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [PATCH v5 1/4] asm-generic: Improve csum_fold
Thread-Topic: [PATCH v5 1/4] asm-generic: Improve csum_fold
Thread-Index: AQHZ54ewpMv53rwyPk26+JqeBsO74rAbfALw
Date:   Fri, 15 Sep 2023 07:29:23 +0000
Message-ID: <b6bd38541255470b97bbaf3e6cdb4265@AcuMS.aculab.com>
References: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com>
 <20230914-optimize_checksum-v5-1-c95b82a2757e@rivosinc.com>
In-Reply-To: <20230914-optimize_checksum-v5-1-c95b82a2757e@rivosinc.com>
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

RnJvbTogQ2hhcmxpZSBKZW5raW5zDQo+IFNlbnQ6IDE1IFNlcHRlbWJlciAyMDIzIDA0OjUwDQo+
IA0KPiBUaGlzIGNzdW1fZm9sZCBpbXBsZW1lbnRhdGlvbiBpbnRyb2R1Y2VkIGludG8gYXJjaC9h
cmMgYnkgVmluZWV0IEd1cHRhDQo+IGlzIGJldHRlciB0aGFuIHRoZSBkZWZhdWx0IGltcGxlbWVu
dGF0aW9uIG9uIGF0IGxlYXN0IGFyYywgeDg2LCBhcm0sIGFuZA0KPiByaXNjdi4gVXNpbmcgR0ND
IHRydW5rIGFuZCBjb21waWxpbmcgbm9uLWlubGluZWQgdmVyc2lvbiwgdGhpcw0KPiBpbXBsZW1l
bnRhdGlvbiBoYXMgNDEuNjY2NyUsIDI1JSwgMTYuNjY2NyUgZmV3ZXIgaW5zdHJ1Y3Rpb25zIG9u
DQo+IHJpc2N2NjQsIHg4Ni02NCwgYW5kIGFybTY0IHJlc3BlY3RpdmVseSB3aXRoIC1PMyBvcHRp
bWl6YXRpb24uDQoNCk5pdC1waWNraW5nIHRoZSBjb21taXQgbWVzc2FnZS4uLg0KU29tZSBvZiB0
aG9zZSBhcmNoaXRlY3R1cmVzIGhhdmUgdGhlaXIgb3duIGFzbSBpbXBsZW1lbnRhdGlvbi4NClRo
ZSBhcm0gb25lIGlzIGJldHRlciB0aGFuIHRoZSBDIGNvZGUgYmVsb3csIHRoZSB4ODYgb25lcyBh
cmVuJ3QuDQoNCkkgdGhpbmsgdGhhdCBvbmx5IHNwYXJjMzIgKGNhcnJ5IGZsYWcgYnV0IG5vIHJv
dGF0ZSkgYW5kDQphcm0vYXJtNjQgKGJhcnJlbCBzaGlmdGVyIG9uIGV2ZXJ5IGluc3RydWN0aW9u
KSBoYXZlIHZlcnNpb25zDQp0aGF0IGFyZSBiZXR0ZXIgdGhhbiB0aGUgb25lIGhlcmUuDQoNClNp
bmNlIEkgc3VnZ2VzdGVkIGl0IHRvIENoYXJsaWU6DQoNClJldmlld2VkLWJ5OiBEYXZpZCBMYWln
aHQgPGRhdmlkLmxhaWdodEBhY3VsYWIuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFy
bGllIEplbmtpbnMgPGNoYXJsaWVAcml2b3NpbmMuY29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvYXNt
LWdlbmVyaWMvY2hlY2tzdW0uaCB8IDUgKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1n
ZW5lcmljL2NoZWNrc3VtLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL2NoZWNrc3VtLmgNCj4gaW5k
ZXggNDNlMThkYjg5YzE0Li5hZGFiOWFjNDMxMmMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvYXNt
LWdlbmVyaWMvY2hlY2tzdW0uaA0KPiArKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL2NoZWNrc3Vt
LmgNCj4gQEAgLTMwLDEwICszMCw3IEBAIGV4dGVybiBfX3N1bTE2IGlwX2Zhc3RfY3N1bShjb25z
dCB2b2lkICppcGgsIHVuc2lnbmVkIGludCBpaGwpOw0KPiAgICovDQo+ICBzdGF0aWMgaW5saW5l
IF9fc3VtMTYgY3N1bV9mb2xkKF9fd3N1bSBjc3VtKQ0KPiAgew0KPiAtCXUzMiBzdW0gPSAoX19m
b3JjZSB1MzIpY3N1bTsNCg0KWW91J2xsIG5lZWQgdG8gcmUtaW5zdGF0ZSB0aGF0IGxpbmUgdG8g
c3RvcCBzcGFyc2UgY29tcGxhaW5pbmcuDQoNCj4gLQlzdW0gPSAoc3VtICYgMHhmZmZmKSArIChz
dW0gPj4gMTYpOw0KPiAtCXN1bSA9IChzdW0gJiAweGZmZmYpICsgKHN1bSA+PiAxNik7DQo+IC0J
cmV0dXJuIChfX2ZvcmNlIF9fc3VtMTYpfnN1bTsNCj4gKwlyZXR1cm4gKF9fZm9yY2UgX19zdW0x
NikoKH5jc3VtIC0gcm9yMzIoY3N1bSwgMTYpKSA+PiAxNik7DQo+ICB9DQo+ICAjZW5kaWYNCj4g
DQo+IA0KPiAtLQ0KPiAyLjQyLjANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

