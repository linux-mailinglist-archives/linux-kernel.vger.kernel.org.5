Return-Path: <linux-kernel+bounces-162407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717308B5AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1D328940B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB17BB01;
	Mon, 29 Apr 2024 14:01:48 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C52757FF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399308; cv=none; b=VvmZ0WA31EM6+IwdSKMG+ROn9UK84iXwhbG4XWoSZOxAbBTQm2P5MJqslbgoXlnIPiLgU6EZ8VfyoUgDhXnDk1eQ/ULAJhGCpABqJ//u+x12bDmfR0tzkJp9Q5vuZPR3W0tXRCECL8XlO561C4mDmOj2dqUdVj3yy15pTnL2ZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399308; c=relaxed/simple;
	bh=e7TvlrPSQc0/eqYkNg6fTM7yLvokY898/4tGaAFSoIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OcPxQdu4BsfO5fPzLP1X1r3tAqQN28aruSdP09/bpxYYtf/5F5o927DDbnT8+JgUwZCYg8Xu6aNRRdh9Z01iGYWIjY8HzwpPlIrc908BfPpT5fISDJo8TGHvfZVBlQCzGOoyIzheoKFURrARmy78RB3AGXjQMRrnRQ34Wwg1ZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-8-sgBWM_xkPBOQpufxJtdRhg-1; Mon, 29 Apr 2024 15:01:38 +0100
X-MC-Unique: sgBWM_xkPBOQpufxJtdRhg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 29 Apr
 2024 15:01:00 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 29 Apr 2024 15:01:00 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Gerd Hoffmann <kraxel@redhat.com>
CC: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
Thread-Topic: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
Thread-Index: AQHaloHtuZ6Ib4ELhkipVPWjjF4HNLF8nf2wgAKopXeAAANcoA==
Date: Mon, 29 Apr 2024 14:01:00 +0000
Message-ID: <2adc91aebb3a433997e13bd479d4b4b3@AcuMS.aculab.com>
References: <20240424195951.3749388-1-linux@roeck-us.net>
 <a1b4bac14c6a4334969cc7d671f3a8eb@AcuMS.aculab.com>
 <d434c88a-6575-4d45-ab3e-e27ac7684b07@roeck-us.net>
 <ef23ykui3axiwfkr4wi24abbuklvejx5r5wqem5cr4lq36x7py@kkxvsi3ibtbi>
 <eafc8fb6-cecc-48c8-a053-cd00f094e781@roeck-us.net>
In-Reply-To: <eafc8fb6-cecc-48c8-a053-cd00f094e781@roeck-us.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogR3VlbnRlciBSb2Vjaw0KPiBTZW50OiAyOSBBcHJpbCAyMDI0IDE0OjM0DQo+IA0KPiBP
biA0LzI4LzI0IDIzOjQ5LCBHZXJkIEhvZmZtYW5uIHdyb3RlOg0KPiA+ICAgIEhpLA0KPiA+DQo+
ID4+Pj4gKwkvKiByZXBlYXQgdW50aWwgYWxsIGVuYWJsZWQgaW50ZXJydXB0cyBhcmUgaGFuZGxl
ZCAqLw0KPiA+Pj4+ICsJaWYgKG9oY2ktPnJoX3N0YXRlICE9IE9IQ0lfUkhfSEFMVEVEKSB7DQo+
ID4+Pj4gKwkJaW50cyA9IG9oY2lfcmVhZGwob2hjaSwgJnJlZ3MtPmludHJzdGF0dXMpOw0KPiA+
Pj4+ICsJCWlmIChpbnRzICYgb2hjaV9yZWFkbChvaGNpLCAmcmVncy0+aW50cmVuYWJsZSkpDQo+
ID4+Pg0KPiA+Pj4gRG9lc24ndCB0aGUgZHJpdmVyIGtub3cgd2hpY2ggaW50ZXJydXB0cyBhcmUg
ZW5hYmxlZD8NCj4gPj4+IFNvIGl0IHNob3VsZCBiZSBhYmxlIHRvIGF2b2lkIGRvaW5nIHR3byAo
bGlrZWx5KSBzbG93IGlvIHJlYWRzPw0KPiA+Pj4gKFBDSWUgcmVhZHMgYXJlIHByZXR0eSBtdWNo
IGd1YXJhbnRlZWQgdG8gYmUgaGlnaCBsYXRlbmN5LikNCj4gPj4NCj4gPj4gTm8sIHRoZSBkcml2
ZXIgZG9lcyBub3QgY2FjaGUgaW50cmVuYWJsZS4NCj4gPg0KPiA+IERvZXMgdGhlIGRyaXZlciBl
dmVyIGNoYW5nZSBpbnRyZW5hYmxlIGFmdGVyIGluaXRpYWxpemF0aW9uPw0KPiA+DQo+IA0KPiAk
IGdpdCBncmVwIC1lIGludHJlbmFibGUgLWUgaW50cmRpc2FibGUgZHJpdmVycy91c2IvaG9zdC8q
b2hjaSpjIHwgZ3JlcCBvaGNpX3dyaXRlbA0KPiBkcml2ZXJzL3VzYi9ob3N0L29oY2ktaGNkLmM6
CW9oY2lfd3JpdGVsKG9oY2ksICh1MzIpIH4wLCAmb2hjaS0+cmVncy0+aW50cmRpc2FibGUpOw0K
PiBkcml2ZXJzL3VzYi9ob3N0L29oY2ktaGNkLmM6CQlvaGNpX3dyaXRlbCAob2hjaSwgT0hDSV9J
TlRSX09DLCAmb2hjaS0+cmVncy0+aW50cmVuYWJsZSk7DQo+IGRyaXZlcnMvdXNiL2hvc3Qvb2hj
aS1oY2QuYzoJb2hjaV93cml0ZWwgKG9oY2ksIE9IQ0lfSU5UUl9NSUUsICZvaGNpLT5yZWdzLT5p
bnRyZGlzYWJsZSk7DQo+IGRyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYzoJb2hjaV93cml0ZWwg
KG9oY2ksIG1hc2ssICZvaGNpLT5yZWdzLT5pbnRyZW5hYmxlKTsNCj4gZHJpdmVycy91c2IvaG9z
dC9vaGNpLWhjZC5jOgkJCW9oY2lfd3JpdGVsIChvaGNpLCBPSENJX0lOVFJfVUUsICZyZWdzLT5p
bnRyZGlzYWJsZSk7DQo+IGRyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYzoJCW9oY2lfd3JpdGVs
KG9oY2ksIE9IQ0lfSU5UUl9SSFNDLCAmcmVncy0+aW50cmRpc2FibGUpOw0KPiBkcml2ZXJzL3Vz
Yi9ob3N0L29oY2ktaGNkLmM6CQlvaGNpX3dyaXRlbCAob2hjaSwgT0hDSV9JTlRSX1NGLCAmcmVn
cy0+aW50cmRpc2FibGUpOw0KPiBkcml2ZXJzL3VzYi9ob3N0L29oY2ktaGNkLmM6CQlvaGNpX3dy
aXRlbCAob2hjaSwgT0hDSV9JTlRSX01JRSwgJnJlZ3MtPmludHJlbmFibGUpOw0KPiBkcml2ZXJz
L3VzYi9ob3N0L29oY2ktaGNkLmM6CW9oY2lfd3JpdGVsIChvaGNpLCBPSENJX0lOVFJfTUlFLCAm
b2hjaS0+cmVncy0+aW50cmRpc2FibGUpOw0KPiBkcml2ZXJzL3VzYi9ob3N0L29oY2ktaGNkLmM6
CW9oY2lfd3JpdGVsKG9oY2ksIE9IQ0lfSU5UUl9NSUUsICZvaGNpLT5yZWdzLT5pbnRyZGlzYWJs
ZSk7DQo+IGRyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYzoJCW9oY2lfd3JpdGVsKG9oY2ksIE9I
Q0lfSU5UUl9NSUUsICZvaGNpLT5yZWdzLT5pbnRyZW5hYmxlKTsNCj4gZHJpdmVycy91c2IvaG9z
dC9vaGNpLWh1Yi5jOglvaGNpX3dyaXRlbChvaGNpLCBPSENJX0lOVFJfU0YsICZvaGNpLT5yZWdz
LT5pbnRyZGlzYWJsZSk7DQo+IGRyaXZlcnMvdXNiL2hvc3Qvb2hjaS1odWIuYzoJb2hjaV93cml0
ZWwgKG9oY2ksIE9IQ0lfSU5UUl9JTklULCAmb2hjaS0+cmVncy0+aW50cmVuYWJsZSk7DQo+IGRy
aXZlcnMvdXNiL2hvc3Qvb2hjaS1odWIuYzoJCW9oY2lfd3JpdGVsIChvaGNpLCBPSENJX0lOVFJf
U0YsICZvaGNpLT5yZWdzLT5pbnRyZW5hYmxlKTsNCj4gZHJpdmVycy91c2IvaG9zdC9vaGNpLWh1
Yi5jOgkJCW9oY2lfd3JpdGVsKG9oY2ksIHJoc2NfZW5hYmxlLCAmb2hjaS0+cmVncy0+aW50cmVu
YWJsZSk7DQo+IGRyaXZlcnMvdXNiL2hvc3Qvb2hjaS1odWIuYzoJb2hjaV93cml0ZWwob2hjaSwg
T0hDSV9JTlRSX1JIU0MsICZvaGNpLT5yZWdzLT5pbnRyZW5hYmxlKTsNCj4gZHJpdmVycy91c2Iv
aG9zdC9vaGNpLXEuYzoJb2hjaV93cml0ZWwgKG9oY2ksIE9IQ0lfSU5UUl9TRiwgJm9oY2ktPnJl
Z3MtPmludHJlbmFibGUpOw0KDQpBdCBsZWFzdCB0aGUgaGFyZHdhcmUgaGFzIHNlcGFyYXRlIGVu
YWJsZS9kaXNhYmxlIHJlZ2lzdGVycw0Kc28gdGhlIGRyaXZlciBpc24ndCBkb2luZyBSTVcgY3lj
bGVzLg0KDQpJJ2QgZ3Vlc3MgdGhhdCB0aGUgbm9ybWFsIGNvbmRpdGlvbiBpcyB0aGF0IG5vIGlu
dGVycnVwdHMgYXJlIHBlbmRpbmcuDQpTbyBpdCBjYW4gYmUgaGVsZCB0byBvbmUgKHNsb3cpIHJl
YWQgYnkgY2hlY2tpbmc6DQoJaWYgKGludHMgJiYgKGludHMgJiBvaGNpX3JlYWRsKG9oY2ksICZy
ZWdzLT5pbnRyZW5hYmxlKSkpDQpBbHRob3VnaCBtYXliZSB0aGVyZSBhcmUgc29tZSAnbmV2ZXIg
ZW5hYmxlZCcgaW50ZXJydXB0cyB0aGF0DQptaWdodCBuZWVkIG1hc2tpbmc/DQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=


