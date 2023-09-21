Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2067A9FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjIUU1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIUU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:27:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5397900F0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:46:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-53-YmAYymjVOfWQG9HEzXufqA-1; Thu, 21 Sep 2023 11:22:23 +0100
X-MC-Unique: YmAYymjVOfWQG9HEzXufqA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Sep
 2023 11:22:21 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Sep 2023 11:22:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Evan Green' <evan@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>
CC:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        "Marc Zyngier" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        "Conor Dooley" <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: RE: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
Thread-Topic: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
Thread-Index: AQHZ7B3VgrzHOgdWvEySUjlSCGAzg7AlERSQ
Date:   Thu, 21 Sep 2023 10:22:21 +0000
Message-ID: <a94490f6b1dd43d5985a8b14aa93bd27@AcuMS.aculab.com>
References: <20230920193801.3035093-1-evan@rivosinc.com>
 <20230920-98a392b40f88c69e852e2c88@fedora>
 <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
 <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
 <CAOnJCU+YNOzw39JMjWmJFHY5QjcRrKEwULo+d9WhPfv7TejpbQ@mail.gmail.com>
 <CALs-HsvvnMFErCtShB-30xO8LR4M03riYomZy3FnvEghRua_3g@mail.gmail.com>
In-Reply-To: <CALs-HsvvnMFErCtShB-30xO8LR4M03riYomZy3FnvEghRua_3g@mail.gmail.com>
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

Li4uDQo+ID4gRm9yIHByb2JpbmcgYWxpZ25tZW50IHNwZWVkLCB5b3UganVzdCBjYXJlIGFib3V0
IHJ1bm5pbmcgaXQgb24gdGhhdA0KPiA+IGNwdS4gQ29ycmVjdCA/DQo+IA0KPiBGb3IgdGhpcyB3
ZSBjYXJlIGJvdGggYWJvdXQgbm90IG1pZ3JhdGluZyB0byBvdGhlciBDUFVzLCBhbmQgYWxzbw0K
PiBzZWNvbmRhcmlseSBtaW5pbWl6aW5nIGRpc3R1cmJhbmNlcyB3aGlsZSB0aGUgdGVzdCBpcyBi
ZWluZyBydW4uDQo+IFVzdWFsbHkgSSBlcXVhdGUgcHJlLWVtcHRpb24gd2l0aCBtaWdyYXRpb24s
IGJ1dCBpbiB0aGlzIGNhc2UgSSB0aGluaw0KPiB0aGUgd29ya2VyIHRocmVhZHMgYXJlIGJvdW5k
IHRvIHRoYXQgQ1BVLiBTbyBJJ2xsIGtlZXAgdGhlDQo+IHByZWVtcHRfZGlzYWJsZS9lbmFibGUg
d2hlcmUgaXQgaXMsIHNpbmNlIGl0J3MgaGFybWxlc3MgZm9yIENQVXMgb3RoZXINCj4gdGhhbiAw
LCBidXQgdXNlZnVsIGZvciAwLiBJIGFsc28gbGlrZSBpdCBmb3IgcmVhZGFiaWxpdHkgYXMgaXQN
Cj4gaGlnaGxpZ2h0cyB0aGUgY3JpdGljYWwgc2VjdGlvbiAoYXMgYSByZWFkZXIsICJpcyBwcmVl
bXB0aW9uIGRpc2FibGVkIg0KPiB3b3VsZCBiZSBvbmUgb2YgbXkgZmlyc3QgcXVlc3Rpb25zIHdo
ZW4gc3R1ZHlpbmcgdGhpcykuDQoNCllvdSBuZWVkIHRvIGRpc2FibGUgcHJlLWVtcHRpb24gdG8g
Z2V0IGFueSBraW5kIG9mIG1lYW5pbmdmdWwgYW5zd2VyLg0KDQpCdXQgd2h5IGRvIHlvdSBuZWVk
IHRvIHJ1biB0aGUgdGVzdCBvbiBtb3JlIHRoYW4gdGhlIGJvb3QgY3B1Pw0KSWYgeW91J3ZlIGEg
aGV0ZXJvZ2Vub3VzIG1peCBvZiBjcHUgYW55IGNvZGUgdGhhdCBsb29rcyBhdCB0aGUgYW5zd2Vy
DQppcyBnb2luZyB0byBiZWhhdmUgaW5jb3JyZWN0bHkgdW5sZXNzIGl0IGhhcyBhbHNvIGRpc2Fi
bGVkIHByZS1lbXB0aW9uDQpvciBpcyBib3VuZCB0byBhIGNwdS4NCg0KT25lIG9idmlvdXMgdXNl
IG9mIHRoZSByZXN1bHQgaXMgdG8gc2V0dXAgc29tZSBzdGF0aWMgYnJhbmNoZXMuDQpCdXQgdGhh
dCBhc3N1bWVzIGFsbCBjcHUgYXJlIHRoZSBzYW1lLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

