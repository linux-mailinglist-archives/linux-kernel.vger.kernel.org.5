Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D185B7F8C18
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjKYPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:37:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC89AA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:37:26 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-323-ACZXAgEhNOSnwO7T2ON0-A-1; Sat, 25 Nov 2023 15:37:22 +0000
X-MC-Unique: ACZXAgEhNOSnwO7T2ON0-A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 25 Nov
 2023 15:37:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 25 Nov 2023 15:37:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J0Nsw6ltZW50IEzDqWdlcic=?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2] riscv: fix incorrect use of __user pointer
Thread-Topic: [PATCH v2] riscv: fix incorrect use of __user pointer
Thread-Index: AQHaHsrcAiRrTVkzkEi8HCpEAmrYerCLK9Cg
Date:   Sat, 25 Nov 2023 15:37:39 +0000
Message-ID: <bf7dfadfc8a94e3f810a8ba238f77543@AcuMS.aculab.com>
References: <20231124113803.165431-1-cleger@rivosinc.com>
In-Reply-To: <20231124113803.165431-1-cleger@rivosinc.com>
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

Li4uDQo+IEBAIC00OTEsNyArNDg2LDcgQEAgaW50IGhhbmRsZV9taXNhbGlnbmVkX2xvYWQoc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MpDQo+IA0KPiAgCXZhbC5kYXRhX3U2NCA9IDA7DQo+ICAJZm9yIChp
ID0gMDsgaSA8IGxlbjsgaSsrKSB7DQo+IC0JCWlmIChsb2FkX3U4KHJlZ3MsICh2b2lkICopKGFk
ZHIgKyBpKSwgJnZhbC5kYXRhX2J5dGVzW2ldKSkNCj4gKwkJaWYgKGxvYWRfdTgocmVncywgYWRk
ciArIGksICZ2YWwuZGF0YV9ieXRlc1tpXSkpDQo+ICAJCQlyZXR1cm4gLTE7DQo+ICAJfQ0KDQpJ
J2QgcmVhbGx5IGhhdmUgdGhvdWdodCB0aGF0IHlvdSdkIHdhbnQgdG8gcHVsbCB0aGUga2VybmVs
L3VzZXINCmNoZWNrIHdheSBvdXRzaWRlIHRoZSBsb29wPw0KSW4gYW55IGNhc2UsIGZvciBhIG1p
c2FsaWduZWQgcmVhZCB3aHkgbm90IGp1c3QgcmVhZCAoYWRkciAmIH43KVswXQ0KYW5kIChpZiBu
ZWVkZWQpIChhZGRyICYgfjcpWzFdIGFuZCB0aGVuIGFoaWZ0IGFuZCBvciB0b2dldGhlcj8NCg0K
Y2xhbmcgd2lsbCBkbyBpdCBmb3IgbWlzYWxpZ25lZCBzdHJ1Y3R1cmUgbWVtYmVycyB3aXRoIGtu
b3duDQptaXNhbGlnbm1lbnQsIGJ1dCBpdCBpcyBhbG1vc3QgY2VydGFpbmx5IGFsc28gYmV0dGVy
IGZvciByZWFkcw0Kd2l0aCB1bmtub3duIG1pc2FsaWdubWVudC4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

