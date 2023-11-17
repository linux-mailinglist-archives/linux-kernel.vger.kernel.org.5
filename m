Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A97EF380
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjKQNJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjKQNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:09:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93DD5F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:09:28 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-42-QJPjbCsvOUafrBgwBjqH7A-1; Fri, 17 Nov 2023 13:09:25 +0000
X-MC-Unique: QJPjbCsvOUafrBgwBjqH7A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 17 Nov
 2023 13:09:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 17 Nov 2023 13:09:36 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>
Subject: RE: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Topic: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Index: AQHaGUtnFfqMOen5JUCwmbDFX2u0nbB+dBTg
Date:   Fri, 17 Nov 2023 13:09:36 +0000
Message-ID: <67acdf70c3fd4adf9bc0dddd4b10d4a1@AcuMS.aculab.com>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
 <20231117114421.GCZVdSFZ7DKtBol821@fat_crate.local>
In-Reply-To: <20231117114421.GCZVdSFZ7DKtBol821@fat_crate.local>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDE3IE5vdmVtYmVyIDIwMjMgMTE6NDQNCi4u
Lg0KPiBZZWFoLCBJIHRoaW5rIHdlIHNob3VsZCBtZWFzdXJlIHRoZSBsaWJjYWxsIHRoaW5nIGFu
ZCB0aGVuIHRyeSB0byBnZXQNCj4gdGhlIGlubGluZWQgInJlcCBtb3ZzYiIgd29ya2luZyBhbmQg
c2VlIHdoaWNoIG9uZSBpcyBiZXR0ZXIuIFlvdSBkbyBoYXZlDQo+IGEgcG9pbnQgYWJvdXQgdGhh
dCBSRVQgb3ZlcmhlYWQgYWZ0ZXIgZWFjaCBDQUxMLg0KDQpZb3UgbWlnaHQgYmUgYWJsZSB0byB1
c2UgdGhlIHJlbG9jYXRpb24gbGlzdCBmb3IgbWVtY3B5KCkNCnRvIGNoYW5nZSB0aGUgNSBieXRl
IGNhbGwgaW5zdHJ1Y3Rpb24gaW50byB0aGUgaW5saW5lDQonbW92ICVyZHgsJXJjeDsgcmVwIG1v
dnNiJyBzZXF1ZW5jZS4NCg0KSSd2ZSBzcGVudCBhbGwgbW9ybmluZyAob24gaG9saWRheSkgdHJ5
aW5nIHRvIHVuZGVyc3RhbmQgdGhlIHN0cmFuZ2UNCnRpbWluZ3MgSSdtIHNlZWluZyBmb3IgJ3Jl
cCBtb3N2Yicgb24gaW4gaTctNzcwMC4NCg0KVGhlIGZpeGVkIG92ZXJoZWFkIGlzIHZlcnkgc3Ry
YW5nZS4NCg0KVGhlIGZpcnN0ICdyZXAgbW92c2InIEkgZG8gaW4gYSBwcm9jZXNzIHRha2VzIGFu
IGV4dHJhIDUwMDAgY2xvY2tzIG9yIHNvLg0KQnV0IGl0IGRvZXNuJ3Qgc2VlbSB0byBtYXR0ZXIg
d2hlbiBJIGRvIGl0IQ0KSSBjYW4gZG8gaXQgb24gZW50cnkgdG8gbWFpbigpIHdpdGggc2V2ZXJh
bCBzeXN0ZW0gY2FsbHMgYmVmb3JlDQp0aGUgdGltaW5nIGxvb3AuDQoNCkFmdGVyIHRoYXQgdGhl
IGZpeGVkIG92ZXJoZWFkIGZvciB0aGUgJ3JlcCBtb3ZzYicgaXMgZmFpcmx5IHNtYWxsLg0KSSd2
ZSBhIGZldyBleHRyYSByZWdpc3RlciBtb3ZlcyBiZXR3ZWVuIHRoZSAncmVwIG1vdnNiJyBidXQN
CkknZCBndWVzcyBhdCBhYm91dCAzMCBjbG9ja3MuDQpBbGwgc2l6ZXMgdXAgdG8gKGF0IGxlYXN0
KSAzMiBieXRlcyBleGVjdXRlIGluIHRoZSBzYW1lIHRpbWUuDQpBZnRlciB0aGF0IGl0IGluY3Jl
YXNlcyBhdCBtdWNoIHRoZSByYXRlIHlvdSdkIGV4cGVjdC4NCg0KWmVybyBsZW5ndGggY29waWVz
IGFyZSBkaWZmZXJlbnQsIHRoZXkgYWx3YXlzIHRha2UgfjYwIGNsb2Nrcy4NCg0KTXkgY3VycmVu
dCBndWVzcyBmb3IgdGhlIDUwMDAgY2xvY2tzIGlzIHRoYXQgdGhlIGxvZ2ljIHRvDQpkZWNvZGUg
J3JlcCBtb3ZzYicgaXMgbG9hZGVkIGludG8gYSBidWZmZXIgdGhhdCBpcyBhbHNvIHVzZWQNCnRv
IGRlY29kZSBzb21lIG90aGVyIGluc3RydWN0aW9ucy4NClNvIGlmIHN0aWxsIGNvbnRhaW5zIHRo
ZSAncmVwIG1vdnNiJyBkZWNvZGVyIGl0IGlzIGZhc3QsIG90aGVyd2lzZQ0KaXQgaXMgc2xvdy4N
Cg0KTm8gaWRlYSB3aGF0IG90aGVyIGluc3RydWN0aW9ucyBtaWdodCBiZSB1c2luZyB0aGUgc2Ft
ZSBsb2dpYw0KKG1pY3JvY29kZT8pIGJ1ZmZlci4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

