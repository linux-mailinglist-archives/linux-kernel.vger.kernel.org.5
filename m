Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF9D8012B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379081AbjLASaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLASaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:30:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D8E106
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:30:22 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-64-l9Pbyyc5NbCVu4Mqkqv9Yg-1; Fri, 01 Dec 2023 18:30:13 +0000
X-MC-Unique: l9Pbyyc5NbCVu4Mqkqv9Yg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Dec
 2023 18:30:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Dec 2023 18:30:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov" <asml.silence@gmail.com>,
        io-uring <io-uring@vger.kernel.org>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: RE: io_uring: incorrect assumption about mutex behavior on unlock?
Thread-Topic: io_uring: incorrect assumption about mutex behavior on unlock?
Thread-Index: AQHaJHVMNn8At2QRcESH/qhfYed73LCUvC/Q
Date:   Fri, 1 Dec 2023 18:30:05 +0000
Message-ID: <811a97651e144b83a35fd7eb713aeeae@AcuMS.aculab.com>
References: <CAG48ez3xSoYb+45f1RLtktROJrpiDQ1otNvdR+YLQf7m+Krj5Q@mail.gmail.com>
In-Reply-To: <CAG48ez3xSoYb+45f1RLtktROJrpiDQ1otNvdR+YLQf7m+Krj5Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFubiBIb3JuDQo+IFNlbnQ6IDAxIERlY2VtYmVyIDIwMjMgMTY6NDENCj4gDQo+IG11
dGV4X3VubG9jaygpIGhhcyBhIGRpZmZlcmVudCBBUEkgY29udHJhY3QgY29tcGFyZWQgdG8gc3Bp
bl91bmxvY2soKS4NCj4gc3Bpbl91bmxvY2soKSBjYW4gYmUgdXNlZCB0byByZWxlYXNlIG93bmVy
c2hpcCBvZiBhbiBvYmplY3QsIHNvIHRoYXQNCj4gYXMgc29vbiBhcyB0aGUgc3BpbmxvY2sgaXMg
dW5sb2NrZWQsIGFub3RoZXIgdGFzayBpcyBhbGxvd2VkIHRvIGZyZWUNCj4gdGhlIG9iamVjdCBj
b250YWluaW5nIHRoZSBzcGlubG9jay4NCj4gbXV0ZXhfdW5sb2NrKCkgZG9lcyBub3Qgc3VwcG9y
dCB0aGlzIGtpbmQgb2YgdXNhZ2U6IFRoZSBjYWxsZXIgb2YNCj4gbXV0ZXhfdW5sb2NrKCkgbXVz
dCBlbnN1cmUgdGhhdCB0aGUgbXV0ZXggc3RheXMgYWxpdmUgdW50aWwNCj4gbXV0ZXhfdW5sb2Nr
KCkgaGFzIHJldHVybmVkLg0KDQpUaGUgcHJvYmxlbSBzZXF1ZW5jZSBtaWdodCBiZToNCglUaHJl
YWQgQQkJVGhyZWFkIEINCgltdXRleF9sb2NrKCkNCgkJCQljb2RlIHRvIHN0b3AgbXV0ZXggYmVp
bmcgcmVxdWVzdGVkDQoJCQkJLi4uDQoJCQkJbXV0ZXhfbG9jaygpIC0gc2xlZXBzDQoJbXV0ZXhf
dW5sb2NrKCkuLi4NCgkJV2FpdGVycyB3b2tlbi4uLg0KCQlpc3IgYW5kL29yIHByZS1lbXB0ZWQN
CgkJCQktIHdha2VzIHVwDQoJCQkJbXV0ZXhfdW5sb2NrKCkNCgkJCQlmcmVlKCkNCgkJLi4uIG1v
cmUga2VybmVsIGNvZGUgYWNjZXNzIHRoZSBtdXRleA0KCQlCT09PTQ0KDQpXaGF0IGhhcHBlbnMg
aW4gYSBQUkVFTVBUX1JUIGtlcm5lbCB3aGVyZSBtb3N0IG9mIHRoZSBzcGluX3VubG9jaygpDQpn
ZXQgcmVwbGFjZWQgYnkgbXV0ZXhfdW5sb2NrKCkuDQpTZWVtcyBsaWtlIHRoZXkgY2FuIHBvdGVu
dGlhbGx5IGFjY2VzcyBhIGZyZWVkIG11dGV4Pw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

