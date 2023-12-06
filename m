Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27361806E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377715AbjLFLi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377628AbjLFLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:38:55 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8228F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:39:01 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-11-VR77vVbMOGemeyUZCeX2uw-1; Wed, 06 Dec 2023 11:38:59 +0000
X-MC-Unique: VR77vVbMOGemeyUZCeX2uw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Dec
 2023 11:38:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Dec 2023 11:38:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jens Axboe' <axboe@kernel.dk>,
        Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: RE: [PATCH v4] tee: Use iov_iter to better support shared buffer
 registration
Thread-Topic: [PATCH v4] tee: Use iov_iter to better support shared buffer
 registration
Thread-Index: AQHaJ6OPtlOyPWs+/0ib6E4SGjqISbCcH7JQ
Date:   Wed, 6 Dec 2023 11:38:45 +0000
Message-ID: <7582460ba52e413eaab26d37fb56beed@AcuMS.aculab.com>
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
 <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com>
 <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
 <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
 <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
 <438a8b44-ea5f-4e13-bd7e-e1c2e2a481c4@kernel.dk>
 <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
 <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
 <dfa547c0-e889-4ac6-94c5-344905a6644f@kernel.dk>
 <c9d5c8b8-ca5e-4593-b7ff-707f21dee91f@foss.st.com>
 <206b634d-1d10-4057-ad8d-93e29fda5d6e@kernel.dk>
In-Reply-To: <206b634d-1d10-4057-ad8d-93e29fda5d6e@kernel.dk>
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

PiA+IEFzIEplbnMgV2lrbGFuZGVyIGhhcyBwcm9wb3NlZCB1c2luZyBpb3ZfaXRlcl91YnVmKCkg
aW5zdGVhZCBvZg0KPiA+IGltcG9ydF91YnVmKCksIHNob3VsZCBJIHByb3Bvc2UgYSBwYXRjaCB1
cGRhdGluZyBpbXBvcnRfdWJ1ZigpIGFuZA0KPiA+IGltcG9ydF9zaW5nbGVfcmFuZ2UoKT8gT3Ig
d291bGQgeW91IHByZWZlciB0aGF0IHdlIGtlZXAgdGhlIGZ1bmN0aW9ucw0KPiA+IHVuY2hhbmdl
ZCBmb3IgdGhlIHRpbWUgYmVpbmc/DQo+IA0KPiBBcmd1YWJseSBpdCBzaG91bGQgYmUgY29uc2lz
dGVudCB3aXRoIGlvdmVjIGltcG9ydHMsIHdoaWNoIHJldHVybiB0aGUNCj4gbGVuZ3RoIChvciBl
cnJvcikuIEJ1dCBpdCBtaWdodCBiZSBzYWZlciB0byBqdXN0IGNoZWNrIGFjY2Vzc19vaygpDQo+
IGZpcnN0IGFuZCB0aGVuIHRydW5jYXRlIGF0IGxlYXN0LCB2cyB3aGF0IGlzIHRoZXJlIG5vdy4N
Cg0KSXMgdGhlIGFjY2Vzc19vaygpIGNoZWNrIGV2ZW4gbmVlZGVkIHdoZW4gc2V0dGluZyB1cCBh
biBpb3ZfaXRlcj8NCkl0IGlzIGFsd2F5cyBjaGVja2VkIGFnYWluIHdoZW4gdGhlIGFjdHVhbCBj
b3B5IGlzIGRvbmUuDQoNCkkgbG9va2VkIGF0IHRoaXMgYSB3aGlsZSBiYWNrIGFuZCBjb3VsZG4n
dCBzZWUgYW55IGNvZGUgcGF0aHMgdGhhdA0KcmVsaWVkIG9uIHRoZSBlYXJseSBhY2Nlc3Nfb2so
KSBjaGVjay4NCk1heWJlIGl0IGlzIGhpc3RvcmljPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

