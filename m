Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89CF759651
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjGSNNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGSNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:13:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B181E42
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:13:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-63-YbMMcMCmO-OilHXUgOA2GA-1; Wed, 19 Jul 2023 14:13:35 +0100
X-MC-Unique: YbMMcMCmO-OilHXUgOA2GA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 14:13:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jul 2023 14:13:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guo Ren' <guoren@kernel.org>,
        Celeste Liu <coelacanthushex@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felix Yan <felixonmars@archlinux.org>,
        "Ruizhe Pan" <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: RE: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall != -1
Thread-Topic: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall !=
 -1
Thread-Index: AQHZudFVNmB6tR6EIkqOlOGDQpN9Z6/BEVRQ
Date:   Wed, 19 Jul 2023 13:13:33 +0000
Message-ID: <0aab577b941e4c3483ad4a7af3b42c1f@AcuMS.aculab.com>
References: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
 <CAJF2gTRf0UOYhqwUm6=1YMvZt8q_72WRUHqN=L+nOWaipL+H1Q@mail.gmail.com>
In-Reply-To: <CAJF2gTRf0UOYhqwUm6=1YMvZt8q_72WRUHqN=L+nOWaipL+H1Q@mail.gmail.com>
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

Li4uDQo+ID4gKyAgICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAqIENvbnZl
cnQgbmVnYXRpdmUgbnVtYmVycyB0byB2ZXJ5IGhpZ2ggYW5kIHRodXMgb3V0IG9mIHJhbmdlDQo+
ID4gKyAgICAgICAgICAgICAgICAqIG51bWJlcnMgZm9yIGNvbXBhcmlzb25zLg0KPiA+ICsgICAg
ICAgICAgICAgICAgKi8NCj4gPiAgICAgICAgICAgICAgICAgdWxvbmcgc3lzY2FsbCA9IHJlZ3Mt
PmE3Ow0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIHJlZ3MtPmVwYyArPSA0Ow0KPiA+IEBAIC0z
MDgsNyArMzEyLDcgQEAgYXNtbGlua2FnZSBfX3Zpc2libGUgX190cmFwX3NlY3Rpb24gdm9pZCBk
b190cmFwX2VjYWxsX3Uoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ID4NCj4gPiAgICAgICAgICAg
ICAgICAgaWYgKHN5c2NhbGwgPCBOUl9zeXNjYWxscykNCg0KSWYgeW91IGxlYXZlICdzeXNjYWxs
JyBzaWduZWQgYW5kIHdyaXRlOg0KCWlmIChzeXNjYWxsID49IDAgJiYgc3lzY2FsbCA8IE5SX3N5
c2NhbGxzKQ0KdGhlIGNvbXBpbGVyIHdpbGwgdXNlIGEgc2luZ2xlIHVuc2lnbmVkIGNvbXBhcmUu
DQpUaGVyZSBpcyBubyBuZWVkIHRvICdvcHRpbWlzZScgaXQgeW91cnNlbGYuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

