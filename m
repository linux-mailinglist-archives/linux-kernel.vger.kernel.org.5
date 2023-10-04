Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39717B81DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbjJDOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbjJDOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:10:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6211FC6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:10:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-28-RLpeZCXkMPmTliQac3Fpww-1; Wed, 04 Oct 2023 15:10:42 +0100
X-MC-Unique: RLpeZCXkMPmTliQac3Fpww-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Oct
 2023 15:10:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Oct 2023 15:10:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J0Nsw6ltZW50IEzDqWdlcic=?= <cleger@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?utf-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: RE: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Thread-Topic: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Thread-Index: AQHZ9QOtGOYrq2j5KUyBiWVh/MP2XrA5TUKAgAAMDACAAFTfgA==
Date:   Wed, 4 Oct 2023 14:10:40 +0000
Message-ID: <caa22904d2d7469595dcc5cb1f11be89@AcuMS.aculab.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
 <eb9dcaaf313642b096d68df4b92e7466@AcuMS.aculab.com>
 <6ac16274-3816-4b46-9068-e97af66c815a@rivosinc.com>
In-Reply-To: <6ac16274-3816-4b46-9068-e97af66c815a@rivosinc.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+IFNheWluZyB0aGF0IHlvdSBzdXBwb3J0IG1pc2FsaWduZWQgYWNjZXNzIGRvZXMgbm90
IG1lYW4gdGhhdCB0aGV5IGFyZQ0KPiBnb2luZyB0byBiZSBlZmZpY2llbnQsIGp1c3QgdGhhdCB0
aGV5IGFyZSBzdXBwb3J0ZWQgKGluIGZhY3QsIHRoZSB1QUJJDQo+IHN0YXRlIHRoYXQgdGhleSBt
YXkgcGVyZm9ybSBwb29ybHkpLiBUaGUgY29tcGlsZXIgaXMgYWN0dWFsbHkgbm90IHNvDQo+IHN0
dXBpZCBhbmQgd2lsbCB0cnkgdG8gZG8gYXMgbXVjaCBhbGlnbmVkIGFjY2VzcyBhcyBwb3NzaWJs
ZSBpbiB3aGF0IGl0DQo+IGdlbmVyYXRlcyAodW5sZXNzIGZvcmNlZCBieSBzb21lIGFzc2VtYmx5
LCBjYXN0IG9yIHdoYXRldmVyIHRoYXQgY2FuDQo+IHNjcmV3IHVwIGFsaWdubWVudCBhY2Nlc3Nl
cykuIFRoaXMgaXMgYWxyZWFkeSB0aGUgY2FzZSBhbmQgaXQgd2lsbCBtb3N0DQo+IHByb2JhYmx5
IG5vdCBjaGFuZ2UuDQoNCkkgZGlkIGEgcXVpY2sgY2hlY2suDQoNCmh0dHBzOi8vZ29kYm9sdC5v
cmcvei9qM2U5ZHJ2NGUNCg0KVGhlIGNvZGUgZ2VuZXJhdGVkIGJ5IGJvdGggY2xhbmcgYW5kIGdj
YyBmb3IgbWlzYWxpZ25lZCByZWFkcyBpcyBob3JyaWQuDQpHY2MgZG9lcyBhIGJldHRlciBqb2Ig
aWYgdGhlIGFsaWdubWVudCBpcyBrbm93biBidXQgZ2VuZXJhdGVzIG11Y2gNCnRoZSBzYW1lIGFz
IHRoZSBjbGFuZyBjb2RlIHdoZW4gaXQgaXNuJ3QuDQoNClRoZSBDIGNvZGUgaXMgbXVjaCBzaG9y
dGVyLg0KRXZlbiB0aG91Z2ggYm90aCBnY2MgYW5kIGNsYW5nIGFkZCBhIChkaWZmZXJlbnQpIGlu
c3RydWN0aW9uIHRvIGl0DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

