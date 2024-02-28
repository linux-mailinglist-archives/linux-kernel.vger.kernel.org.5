Return-Path: <linux-kernel+bounces-85675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD486B90B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9E2897B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0DB74431;
	Wed, 28 Feb 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qWlaX29r"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005B79B7A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151796; cv=none; b=WbNUU7fn16qzjoi75spO2+5Ghxxx7UE6MQu/cIjjGYOWlWxbirh9mKRy6pTF64kEqV8H0R4f2DPlePQ5QdLUjj3blTU0rlW1DVbvjRL0NxqO+DnFlY95OaQGBFz6BXReG0ssjI0rfq4vOtr0W6L5sB0qOR1qYIJrW9c4A4e9KaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151796; c=relaxed/simple;
	bh=vB/QdaRW26QrKqvq80OzeVkAdTNRDXW8s0pqpZhXHKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TlQTBoesSi77lQGJD2RObWmHuaWeM0kZNMnOLOgXaAllYr+p7gt8uWVrg/42gAA2A+WbgDnXReX9jpd2wVzZnbo9CVlBr3w43xvimvb2UwIiOH/1sgRWDE6inu80Yc6uVBGHLD3IhRZSm1e8ApFqU030wQy+2WuHthluHl7cMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=qWlaX29r; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 23EC52C0F60;
	Thu, 29 Feb 2024 09:23:11 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709151791;
	bh=vB/QdaRW26QrKqvq80OzeVkAdTNRDXW8s0pqpZhXHKo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=qWlaX29r7okd9YzQezVoaQmKX//Yv/AN/oVLpKCmKpbfpNvVYANvXJ+3gVNykeLgD
	 M3QoDcFlyBlieYqzOqq/ysBS+ppiNcTa1HVQrQ9d71uF4zqmI6YwUQQjTBlvoqMUnD
	 xSr3ivdd3pFc0RKmRd2iD7NJuHrkm0vYS3ibqE8rd3hNy0yaNzpOgk94GtlfsrwE1+
	 Jr3BEQq73LqpDc9kYbNgBS1fj3w6+VCfWYK44LbN3sdjbg7YUe26mfpAEr8pvJLTIw
	 7w1WFUCJNoDZkUPmf1N/ekiiO+9MY5MOCG4j/sdp7YNCulsnC7TbTNdBhdj7NK/SsA
	 nBdBq1NA/9qJw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65df962f0000>; Thu, 29 Feb 2024 09:23:11 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 09:23:10 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Thu, 29 Feb 2024 09:23:10 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Thu, 29 Feb 2024 09:23:10 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/2] gpiolib-of: Make of_gpio_get_count() take firmware
 node as a parameter
Thread-Topic: [PATCH v1 1/2] gpiolib-of: Make of_gpio_get_count() take
 firmware node as a parameter
Thread-Index: AQHaanYmuTVWevmzq06Z7dTM4wzKi7EfWQmA
Date: Wed, 28 Feb 2024 20:23:10 +0000
Message-ID: <8862c6a9-529c-4c52-a84b-176e6d61351a@alliedtelesis.co.nz>
References: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
 <20240228184412.3591847-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228184412.3591847-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4D671159A5C2C43B38EAB2FA709DC43@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65df962f a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=QyXUC8HyAAAA:8 a=CNJck4tkpARU9y_bQmwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyOS8wMi8yNCAwNzo0MCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBNYWtlIG9mX2dw
aW9fZ2V0X2NvdW50KCkgdGFrZSBmaXJtd2FyZSBub2RlIGFzIGEgcGFyYW1ldGVyIGluIG9yZGVy
DQo+IHRvIGJlIGFsaWduZWQgd2l0aCBvdGhlciBmdW5jdGlvbnMgYW5kIGRlY291cGxlIGZvcm0g
dW51c2VkIGRldmljZQ0KdHlwbzogZm9ybSAtPiBmcm9tDQo+IHBvaW50ZXIuIFRoZSBsYXR0ZXIg
aGVscHMgdG8gY3JlYXRlIGEgY29tbW9uIGZ3bm9kZV9ncGlvX2NvdW50KCkNCj4gaW4gdGhlIGZ1
dHVyZS4NCj4NCj4gV2hpbGUgYXQgaXQsIHJlbmFtZSB0byBiZSBvZl9ncGlvX2NvdW50KCkgdG8g
YmUgYWxpZ25lZCB3aXRoIHRoZSBvdGhlcnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwaW8vZ3Bpb2xpYi1vZi5jIHwgMTMgKysrKysrLS0tLS0tLQ0KPiAgIGRyaXZlcnMv
Z3Bpby9ncGlvbGliLW9mLmggfCAgNSArKystLQ0KPiAgIGRyaXZlcnMvZ3Bpby9ncGlvbGliLmMg
ICAgfCAgMiArLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1vZi5jIGIv
ZHJpdmVycy9ncGlvL2dwaW9saWItb2YuYw0KPiBpbmRleCBlMzVhOWM3ZGE0ZWUuLmMwZWFlODky
NDA3NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncGlvL2dwaW9saWItb2YuYw0KPiArKysgYi9k
cml2ZXJzL2dwaW8vZ3Bpb2xpYi1vZi5jDQo+IEBAIC02OCw3ICs2OCw3IEBAIHN0YXRpYyBpbnQg
b2ZfZ3Bpb19uYW1lZF9jb3VudChjb25zdCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiAgIA0K
PiAgIC8qKg0KPiAgICAqIG9mX2dwaW9fc3BpX2NzX2dldF9jb3VudCgpIC0gc3BlY2lhbCBHUElP
IGNvdW50aW5nIGZvciBTUEkNCj4gLSAqIEBkZXY6ICAgIENvbnN1bWluZyBkZXZpY2UNCj4gKyAq
IEBucDogICAgQ29uc3VtaW5nIGRldmljZSBub2RlDQo+ICAgICogQGNvbl9pZDogRnVuY3Rpb24g
d2l0aGluIHRoZSBHUElPIGNvbnN1bWVyDQo+ICAgICoNCj4gICAgKiBTb21lIGVsZGVyIEdQSU8g
Y29udHJvbGxlcnMgbmVlZCBzcGVjaWFsIHF1aXJrcy4gQ3VycmVudGx5IHdlIGhhbmRsZQ0KPiBA
QCAtNzgsMTAgKzc4LDggQEAgc3RhdGljIGludCBvZl9ncGlvX25hbWVkX2NvdW50KGNvbnN0IHN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+ICAgICogdGhlIGNvdW50aW5nIG9mICJjcy1ncGlvcyIg
dG8gY291bnQgImdwaW9zIiB0cmFuc3BhcmVudCB0byB0aGUNCj4gICAgKiBkcml2ZXIuDQo+ICAg
ICovDQo+IC1zdGF0aWMgaW50IG9mX2dwaW9fc3BpX2NzX2dldF9jb3VudChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIGNvbnN0IGNoYXIgKmNvbl9pZCkNCj4gK3N0YXRpYyBpbnQgb2ZfZ3Bpb19zcGlfY3Nf
Z2V0X2NvdW50KGNvbnN0IHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIGNvbnN0IGNoYXIgKmNvbl9p
ZCkNCj4gICB7DQo+IC0Jc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsNCj4g
LQ0KPiAgIAlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1NQSV9NQVNURVIpKQ0KPiAgIAkJcmV0dXJu
IDA7DQo+ICAgCWlmICghY29uX2lkIHx8IHN0cmNtcChjb25faWQsICJjcyIpKQ0KPiBAQCAtOTMs
MTMgKzkxLDE0IEBAIHN0YXRpYyBpbnQgb2ZfZ3Bpb19zcGlfY3NfZ2V0X2NvdW50KHN0cnVjdCBk
ZXZpY2UgKmRldiwgY29uc3QgY2hhciAqY29uX2lkKQ0KPiAgIAlyZXR1cm4gb2ZfZ3Bpb19uYW1l
ZF9jb3VudChucCwgImdwaW9zIik7DQo+ICAgfQ0KPiAgIA0KPiAtaW50IG9mX2dwaW9fZ2V0X2Nv
dW50KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqY29uX2lkKQ0KPiAraW50IG9mX2dw
aW9fY291bnQoY29uc3Qgc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZ3bm9kZSwgY29uc3QgY2hhciAq
Y29uX2lkKQ0KPiAgIHsNCj4gKwljb25zdCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gdG9fb2Zf
bm9kZShmd25vZGUpOw0KPiAgIAlpbnQgcmV0Ow0KPiAgIAljaGFyIHByb3BuYW1lWzMyXTsNCj4g
ICAJdW5zaWduZWQgaW50IGk7DQo+ICAgDQo+IC0JcmV0ID0gb2ZfZ3Bpb19zcGlfY3NfZ2V0X2Nv
dW50KGRldiwgY29uX2lkKTsNCj4gKwlyZXQgPSBvZl9ncGlvX3NwaV9jc19nZXRfY291bnQobnAs
IGNvbl9pZCk7DQo+ICAgCWlmIChyZXQgPiAwKQ0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICANCj4g
QEAgLTExMSw3ICsxMTAsNyBAQCBpbnQgb2ZfZ3Bpb19nZXRfY291bnQoc3RydWN0IGRldmljZSAq
ZGV2LCBjb25zdCBjaGFyICpjb25faWQpDQo+ICAgCQkJc25wcmludGYocHJvcG5hbWUsIHNpemVv
Zihwcm9wbmFtZSksICIlcyIsDQo+ICAgCQkJCSBncGlvX3N1ZmZpeGVzW2ldKTsNCj4gICANCj4g
LQkJcmV0ID0gb2ZfZ3Bpb19uYW1lZF9jb3VudChkZXYtPm9mX25vZGUsIHByb3BuYW1lKTsNCj4g
KwkJcmV0ID0gb2ZfZ3Bpb19uYW1lZF9jb3VudChucCwgcHJvcG5hbWUpOw0KPiAgIAkJaWYgKHJl
dCA+IDApDQo+ICAgCQkJYnJlYWs7DQo+ICAgCX0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bp
by9ncGlvbGliLW9mLmggYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1vZi5oDQo+IGluZGV4IDZiM2E1
MzQ3YzVkOS4uMTk5ODhjMTM1NGZhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwaW8vZ3Bpb2xp
Yi1vZi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3Bpby9ncGlvbGliLW9mLmgNCj4gQEAgLTksNiArOSw3
IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L25vdGlmaWVyLmg+DQo+ICAgDQo+ICAgc3RydWN0IGRl
dmljZTsNCj4gK3N0cnVjdCBmd25vZGVfaGFuZGxlOw0KPiAgIA0KPiAgIHN0cnVjdCBncGlvX2No
aXA7DQo+ICAgc3RydWN0IGdwaW9fZGVzYzsNCj4gQEAgLTIxLDcgKzIyLDcgQEAgc3RydWN0IGdw
aW9fZGVzYyAqb2ZfZmluZF9ncGlvKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+ICAgCQkJICAg
ICAgIHVuc2lnbmVkIGxvbmcgKmxvb2t1cGZsYWdzKTsNCj4gICBpbnQgb2ZfZ3Bpb2NoaXBfYWRk
KHN0cnVjdCBncGlvX2NoaXAgKmdjKTsNCj4gICB2b2lkIG9mX2dwaW9jaGlwX3JlbW92ZShzdHJ1
Y3QgZ3Bpb19jaGlwICpnYyk7DQo+IC1pbnQgb2ZfZ3Bpb19nZXRfY291bnQoc3RydWN0IGRldmlj
ZSAqZGV2LCBjb25zdCBjaGFyICpjb25faWQpOw0KPiAraW50IG9mX2dwaW9fY291bnQoY29uc3Qg
c3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZ3bm9kZSwgY29uc3QgY2hhciAqY29uX2lkKTsNCj4gICAj
ZWxzZQ0KPiAgIHN0YXRpYyBpbmxpbmUgc3RydWN0IGdwaW9fZGVzYyAqb2ZfZmluZF9ncGlvKHN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+ICAgCQkJCQkgICAgIGNvbnN0IGNoYXIgKmNvbl9pZCwN
Cj4gQEAgLTMyLDcgKzMzLDcgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgZ3Bpb19kZXNjICpvZl9m
aW5kX2dwaW8oc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gICB9DQo+ICAgc3RhdGljIGlubGlu
ZSBpbnQgb2ZfZ3Bpb2NoaXBfYWRkKHN0cnVjdCBncGlvX2NoaXAgKmdjKSB7IHJldHVybiAwOyB9
DQo+ICAgc3RhdGljIGlubGluZSB2b2lkIG9mX2dwaW9jaGlwX3JlbW92ZShzdHJ1Y3QgZ3Bpb19j
aGlwICpnYykgeyB9DQo+IC1zdGF0aWMgaW5saW5lIGludCBvZl9ncGlvX2dldF9jb3VudChzdHJ1
Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKmNvbl9pZCkNCj4gK3N0YXRpYyBpbmxpbmUgaW50
IG9mX2dwaW9fY291bnQoY29uc3Qgc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZ3bm9kZSwgY29uc3Qg
Y2hhciAqY29uX2lkKQ0KPiAgIHsNCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncGlvL2dwaW9saWIuYyBiL2RyaXZlcnMvZ3Bpby9ncGlvbGliLmMNCj4gaW5k
ZXggNWZhM2JmN2I1NWJkLi5hOTMyNzFiM2Q1MzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3Bp
by9ncGlvbGliLmMNCj4gKysrIGIvZHJpdmVycy9ncGlvL2dwaW9saWIuYw0KPiBAQCAtNDI4NSw3
ICs0Mjg1LDcgQEAgaW50IGdwaW9kX2NvdW50KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hh
ciAqY29uX2lkKQ0KPiAgIAlpbnQgY291bnQgPSAtRU5PRU5UOw0KPiAgIA0KPiAgIAlpZiAoaXNf
b2Zfbm9kZShmd25vZGUpKQ0KPiAtCQljb3VudCA9IG9mX2dwaW9fZ2V0X2NvdW50KGRldiwgY29u
X2lkKTsNCj4gKwkJY291bnQgPSBvZl9ncGlvX2NvdW50KGZ3bm9kZSwgY29uX2lkKTsNCj4gICAJ
ZWxzZSBpZiAoaXNfYWNwaV9ub2RlKGZ3bm9kZSkpDQo+ICAgCQljb3VudCA9IGFjcGlfZ3Bpb19j
b3VudChkZXYsIGNvbl9pZCk7DQo+ICAgCWVsc2UgaWYgKGlzX3NvZnR3YXJlX25vZGUoZndub2Rl
KSk=

