Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF487F9D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjK0Kfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjK0Kf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:35:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707B3183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:35:35 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304--iAy6FWzNo6bScLr0riqlw-1; Mon, 27 Nov 2023 10:35:32 +0000
X-MC-Unique: -iAy6FWzNo6bScLr0riqlw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 27 Nov
 2023 10:35:42 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 27 Nov 2023 10:35:42 +0000
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
Thread-Index: AQHaHsrcAiRrTVkzkEi8HCpEAmrYerCLK9CggALOZICAAAHAIA==
Date:   Mon, 27 Nov 2023 10:35:42 +0000
Message-ID: <72fb7d8085a644e4a3e2e540a9ed6847@AcuMS.aculab.com>
References: <20231124113803.165431-1-cleger@rivosinc.com>
 <bf7dfadfc8a94e3f810a8ba238f77543@AcuMS.aculab.com>
 <9cb1fadf-bb83-4e9f-9c29-bff53e30b0c6@rivosinc.com>
In-Reply-To: <9cb1fadf-bb83-4e9f-9c29-bff53e30b0c6@rivosinc.com>
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

RnJvbTogQ2zDqW1lbnQgTMOpZ2VyDQo+IFNlbnQ6IDI3IE5vdmVtYmVyIDIwMjMgMTA6MjQNCj4g
DQo+IE9uIDI1LzExLzIwMjMgMTY6MzcsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiAuLi4NCj4g
Pj4gQEAgLTQ5MSw3ICs0ODYsNyBAQCBpbnQgaGFuZGxlX21pc2FsaWduZWRfbG9hZChzdHJ1Y3Qg
cHRfcmVncyAqcmVncykNCj4gPj4NCj4gPj4gIAl2YWwuZGF0YV91NjQgPSAwOw0KPiA+PiAgCWZv
ciAoaSA9IDA7IGkgPCBsZW47IGkrKykgew0KPiA+PiAtCQlpZiAobG9hZF91OChyZWdzLCAodm9p
ZCAqKShhZGRyICsgaSksICZ2YWwuZGF0YV9ieXRlc1tpXSkpDQo+ID4+ICsJCWlmIChsb2FkX3U4
KHJlZ3MsIGFkZHIgKyBpLCAmdmFsLmRhdGFfYnl0ZXNbaV0pKQ0KPiA+PiAgCQkJcmV0dXJuIC0x
Ow0KPiA+PiAgCX0NCj4gPg0KPiA+IEknZCByZWFsbHkgaGF2ZSB0aG91Z2h0IHRoYXQgeW91J2Qg
d2FudCB0byBwdWxsIHRoZSBrZXJuZWwvdXNlcg0KPiA+IGNoZWNrIHdheSBvdXRzaWRlIHRoZSBs
b29wPw0KPiANCj4gSGkgRGF2aWQsDQo+IA0KPiBJIGhvcGUgdGhlIGNvbXBpbGVyIGlzIGFibGUg
dG8gZXh0cmFjdCB0aGF0ICdpZicgb3V0IG9mIHRoZSBsb29wIHNpbmNlDQo+IHJlZ3MgaXNuJ3Qg
bW9kaWZpZWQgaW4gdGhlIGxvb3AuIE5ldmVydGhlbGVzcywgdGhhdCBjb3VsZCBiZSBtb3JlDQo+
ICJjbGVhciIgaWYgcHV0IG91dHNpZGUgaW5kZWVkLg0KDQpJZiBoYXMgYWNjZXNzIHJlZ3MtPnh4
eCB0aGVuIHRoZSBjb21waWxlciBjYW4ndCBkbyBzbyBiZWNhdXNlIGl0DQp3aWxsIG11c3QgYXNz
dW1lIHRoYXQgdGhlIGFzc2lnbm1lbnQgbWlnaHQgYWxpYXMgaW50byAncmVncycuDQpUaGF0IGlz
IGV2ZW4gdHJ1ZSBmb3IgYnl0ZSB3cml0ZXMgaWYgJ3N0cmljdC1hbGlhc2luZycgaXMgZW5hYmxl
ZA0KLSB3aGljaCBpdCBpc24ndCBmb3IgbGludXgga2VybmVsIGJ1aWxkcy4NCg0KSXQgbWlnaHQg
ZG8gc28gaWYgJ3JlZ3MnIHdlcmUgJ2NvbnN0JzsgaXQgdGVuZHMgdG8gYXNzdW1lIHRoYXQgaWYN
Cml0IGNhbid0IGNoYW5nZSAgc29tZXRoaW5nIG5vdGhpbmcgY2FuIC0gYWx0aG91Z2ggdGhhdCBp
c24ndCB0cnVlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

