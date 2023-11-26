Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A857F9577
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjKZVQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:16:45 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFDEE8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:16:50 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E716F2C011D;
        Mon, 27 Nov 2023 10:16:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1701033406;
        bh=IwhR08uy9nRYsdlGPk6drfJ+Bo0wUEBpE+0xNrCmDQ8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PApdiNXbwslJviVEt4XxQXjxZRZcPIwhshJYbpd0Kznze/64xQy+E7s9eMPM0/IVa
         AAdKTaudR1gyBHPJMoVH49iob8LFbHIQ5YfIAs+wv4AItXDd+tx1suOTjkr5rl0L7z
         xIuATsxrhpEcYnowiVoolg5M6hgv5tI5kEes7lX0bEUxotQ6Vv+pUfQgsueXkrnQlb
         YZWgciYCrAsAgTHugvHxdhiowK8BoAf8fmWiwFjvw1UTXJGIzZekjGu7mFwMl5zqXp
         yuVAAZ0mbk5sOH6NpR2UxeLWsY7ZgXH4a/u257hRkbi2X828bhYwCVYk/v1GXYHszG
         8P3rdq+Y6BukQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6563b5be0001>; Mon, 27 Nov 2023 10:16:46 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 10:16:46 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 27 Nov 2023 10:16:46 +1300
From:   Angga <Hermin.Anggawijaya@alliedtelesis.co.nz>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
Thread-Topic: [PATCH] tpm: Start the tpm2 before running a self test.
Thread-Index: AQHaHREnjIixcvoKIE+Z7DUtybpc5rCFEegAgAc1wAA=
Date:   Sun, 26 Nov 2023 21:16:46 +0000
Message-ID: <a31afe97-1abf-4448-8827-e365da26fe34@alliedtelesis.co.nz>
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
 <c9a92192-ee28-4bbf-a02d-1df0d5822027@molgen.mpg.de>
In-Reply-To: <c9a92192-ee28-4bbf-a02d-1df0d5822027@molgen.mpg.de>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAA2B1C73716B24BB92D6DAB8715B2DC@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=AZXP4EfG c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=aaz9gABReCDEcGSWusUA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMTEvMjAyMyA4OjEwIHBtLCBQYXVsIE1lbnplbCB3cm90ZToNCj4NCj4gRGVhciBIZXJt
aW4sDQo+DQo+DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4NCj4NCj4gSXTigJlkIGJlIGdy
ZWF0IGlmIHlvdSByZW1vdmVkIHRoZSBkb3QvcGVyaW9kIGZyb20gdGhlIGVuZCBvZiB0aGUgY29t
bWl0IA0KPiBtZXNzYWdlIHN1bW1hcnkvdGl0bGUuDQo+DQo+IEFtIDIyLjExLjIzIHVtIDA3OjU1
IHNjaHJpZWIgSGVybWluIEFuZ2dhd2lqYXlhOg0KPj4gQmVmb3JlIHNlbmRpbmcgYSBjb21tYW5k
IHRvIGF0dGVtcHQgdGhlIHNlbGYgdGVzdCwgdGhlIFRQTQ0KPj4gbWF5IG5lZWQgdG8gYmUgc3Rh
cnRlZCwgb3RoZXJ3aXNlIHRoZSBzZWxmIHRlc3QgcmV0dXJucw0KPj4gVFBNMl9SQ19JTklUSUFM
SVpFIHZhbHVlIGNhdXNpbmcgYSBsb2cgYXMgZm9sbG93czoNCj4+ICJ0cG0gdHBtMDogQSBUUE0g
ZXJyb3IgKDI1Nikgb2NjdXJyZWQgYXR0ZW1wdGluZyB0aGUgc2VsZiB0ZXN0Ii4NCj4NCj4gUGxl
YXNlIGRvY3VtZW50IG9uIHdoYXQgcGxhdGZvcm0gdGhpcyBoYXBwZW5zLg0KPg0KPj4gU2lnbmVk
LW9mZi1ieTogSGVybWluIEFuZ2dhd2lqYXlhIA0KPj4gPGhlcm1pbi5hbmdnYXdpamF5YUBhbGxp
ZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL2NoYXIvdHBtL3RwbTItY21k
LmMgfCA4ICsrKystLS0tDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbTIt
Y21kLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbTItY21kLmMNCj4+IGluZGV4IDkzNTQ1YmUxOTBh
NS4uMDUzMGYzYjVmODZhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0yLWNt
ZC5jDQo+PiArKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbTItY21kLmMNCj4+IEBAIC03MzcsMTUg
KzczNywxNSBAQCBpbnQgdHBtMl9hdXRvX3N0YXJ0dXAoc3RydWN0IHRwbV9jaGlwICpjaGlwKQ0K
Pj4gwqDCoMKgwqDCoCBpZiAocmMpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+
PiDCoCArwqDCoMKgIHJjID0gdHBtMl9zdGFydHVwKGNoaXApOw0KPj4gK8KgwqDCoCBpZiAocmMg
JiYgcmMgIT0gVFBNMl9SQ19JTklUSUFMSVpFKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gb3V0
Ow0KPj4gKw0KPj4gwqDCoMKgwqDCoCByYyA9IHRwbTJfZG9fc2VsZnRlc3QoY2hpcCk7DQo+PiDC
oMKgwqDCoMKgIGlmIChyYyAmJiByYyAhPSBUUE0yX1JDX0lOSVRJQUxJWkUpDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+PiDCoCDCoMKgwqDCoMKgIGlmIChyYyA9PSBUUE0yX1JD
X0lOSVRJQUxJWkUpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCByYyA9IHRwbTJfc3RhcnR1cChjaGlw
KTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmMpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBnb3RvIG91dDsNCj4+IC0NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByYyA9IHRwbTJfZG9fc2Vs
ZnRlc3QoY2hpcCk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJjKQ0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+DQo+DQo+IEtpbmQgcmVnYXJkcywNCj4NCj4g
UGF1bA0KDQpIZWxsbyBQYXVsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cy4NCg0KID5Q
bGVhc2UgZG9jdW1lbnQgb24gd2hhdCBwbGF0Zm9ybSB0aGlzIGhhcHBlbnMuDQoNClRoZSBlcnJv
ciBsb2cgbWVzc2FnZSBpcyBvYnNlcnZlZCBvbiBhIGN1c3RvbSBoYXJkd2FyZSBkZXNpZ24gKGEg
cm91dGVyKSANCndpdGggYW4gSW5maW5lb24gU0xNIDk2NzAgVFBNMi4wLg0KVGhlIHBhdGNoIGlz
IHVzZWZ1bCBmb3IgdXMsIGFzIHRoZSBmaXJtd2FyZSAoYm9vdCBsb2FkZXIpIG9mIHRoZSByb3V0
ZXIgDQpkb2VzIG5vdCBzdXBwb3J0IFRQTSB5ZXQsIHRodXMgdGhlIGtlcm5lbA0KbmVlZHMgdG8g
c3RhcnQgdGhlIFRQTSBiZWZvcmUgc3RhcnRpbmcgdGhlIHNlbGYgdGVzdC4NCg0KSSB3aWxsIHJl
cGx5IHRvIEphcmtrbydzIGFuZCBTdGVmYW4ncyBjb21tZW50cyBzZXBhcmF0ZWx5LCBhbmQgaWYg
aW4gDQpwcmluY2lwbGUsIHRoZSBwYXRjaCBpcyBhY2NlcHRlZCwgSSB3aWxsIHNlbmQgdGhlDQpz
ZWNvbmQgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggd2l0aCB5b3VyIGNvbW1lbnRzIGFkZHJlc3NlZC4N
Cg0KS2luZCByZWdhcmRzDQoNCkhlcm1pbg0KDQoNCg==
