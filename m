Return-Path: <linux-kernel+bounces-105636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D487E1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC601C22101
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68DB1E862;
	Mon, 18 Mar 2024 01:38:12 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B121DDF5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725892; cv=none; b=moCAPV8d/tgxafd80MGqABkMNr4gHySnGy8o9alOo2WqvAnhHx6AVXfn4zN+aBqdB/1EFzqFbMgu4r8fy4yPo7oB71gfvRv35XTUwuviyKw+BtNhieQDMjHIx+OgbuGtSEdi6+M2QKo1l7MbnR7B7pW5A7G+HUw4yE9IUkRXWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725892; c=relaxed/simple;
	bh=nujjCl4axnQMnh6XH0r9eSJHHPTuopQzWt/PpwFNOrc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n9zQMjgvbRVMTAsweAx+MwLpJgx4b1PtmQoQ4hQWg7NKEe7zswcbn5asbkSjRunBWTrlfcYrXE/Q+Ra/n9d6DhystsYkfreYIummujEBkRMbG/cnSvMLlE38fewp7FxvcMCGTRDy2zSG3kAxydarZ23o417jOWLvcUCh5NEppzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42I1b7HJ093189;
	Mon, 18 Mar 2024 09:37:07 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Tycqx5QDLz2LSNqc;
	Mon, 18 Mar 2024 09:35:41 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 18 Mar
 2024 09:37:04 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.023; Mon, 18 Mar 2024 09:37:05 +0800
From: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?=
	<zhaoyang.huang@unisoc.com>
To: Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        =?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?=
	<Steve.Kang@unisoc.com>
Subject: reply: [PATCH] mm: fix a race scenario in folio_isolate_lru
Thread-Topic: reply: [PATCH] mm: fix a race scenario in folio_isolate_lru
Thread-Index: Adp40BsOv6uT5Y/pQkKDdtGWd160wg==
Date: Mon, 18 Mar 2024 01:37:04 +0000
Message-ID: <b88ce9ecad0d456d8adbc78e42ec713a@BJMBX01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 42I1b7HJ093189

Pg0KPg0KPk9uIFN1biwgTWFyIDE3LCAyMDI0IGF0IDEyOjA3OjQwUE0gKzA4MDAsIFpoYW95YW5n
IEh1YW5nIHdyb3RlOg0KPj4gQ291bGQgaXQgYmUgdGhpcyBzY2VuYXJpbywgd2hlcmUgZm9saW8g
Y29tZXMgZnJvbSBwdGUodGhyZWFkIDApLCBsb2NhbA0KPj4gZmJhdGNoKHRocmVhZCAxKSBhbmQg
cGFnZSBjYWNoZSh0aHJlYWQgMikgY29uY3VycmVudGx5IGFuZCBwcm9jZWVkDQo+PiBpbnRlcm1p
eGVkIHdpdGhvdXQgbG9jaydzIHByb3RlY3Rpb24/IEFjdHVhbGx5LCBJTU8sIHRocmVhZCAxIGFs
c28NCj4+IGNvdWxkIHNlZSB0aGUgZm9saW8gd2l0aCByZWZjbnQ9PTEgc2luY2UgaXQgZG9lc24n
dCBjYXJlIGlmIHRoZSBwYWdlDQo+PiBpcyBvbiB0aGUgcGFnZSBjYWNoZSBvciBub3QuDQo+Pg0K
Pj4gbWFkaXZpc2VfY29sZF9hbmRfcGFnZW91dCBkb2VzIG5vIGV4cGxpY2l0IGZvbGlvX2dldCB0
aGluZyBzaW5jZSB0aGUNCj4+IGZvbGlvIGNvbWVzIGZyb20gcHRlIHdoaWNoIGltcGxpZXMgaXQg
aGFzIG9uZSByZWZjbnQgZnJvbSBwYWdlY2FjaGUNCj4NCj5NbW0sIG5vLiAgSXQncyBpbXBsaWNp
dCwgYnV0IG1hZHZpc2VfY29sZF9vcl9wYWdlb3V0X3B0ZV9yYW5nZSgpDQo+ZG9lcyBndWFyYW50
ZWUgdGhhdCB0aGUgZm9saW8gaGFzIGF0IGxlYXN0IG9uZSByZWZjb3VudC4NCj4NCj5TaW5jZSB3
ZSBnZXQgdGhlIGZvbGlvIGZyb20gdm1fbm9ybWFsX2ZvbGlvKHZtYSwgYWRkciwgcHRlbnQpOyB3
ZSBrbm93IHRoYXQNCj50aGVyZSBpcyBhdCBsZWFzdCBvbmUgbWFwY291bnQgb24gdGhlIGZvbGlv
LiAgcmVmY291bnQgaXMgYWx3YXlzID49IG1hcGNvdW50Lg0KPlNpbmNlIHdlIGhvbGQgcHRlX29m
ZnNldF9tYXBfbG9jaygpLCB3ZSBrbm93IHRoYXQgbWFwY291bnQgKGFuZCB0aGVyZWZvcmUNCj5y
ZWZjb3VudCkgY2Fubm90IGJlIGRlY3JlbWVudGVkIHVudGlsIHdlIGNhbGwgcHRlX3VubWFwX3Vu
bG9jaygpLCB3aGljaCB3ZQ0KPmRvbid0IGRvIHVudGlsIHdlIGhhdmUgY2FsbGVkIGZvbGlvX2lz
b2xhdGVfbHJ1KCkuDQo+DQo+R29vZCB0cnkgdGhvdWdoLCB0b29rIG1lIGEgZmV3IG1pbnV0ZXMg
b2YgbG9va2luZyBhdCBpdCB0byBjb252aW5jZSBteXNlbGYgdGhhdA0KPml0IHdhcyBzYWZlLg0K
Pg0KPlNvbWV0aGluZyB0byBiZWFyIGluIG1pbmQgaXMgdGhhdCBpZiB0aGUgcmFjZSB5b3Ugb3V0
bGluZSBpcyByZWFsLCBmYWlsaW5nIHRvIGhvbGQgYQ0KPnJlZmNvdW50IG9uIHRoZSBmb2xpbyBs
ZWF2ZXMgdGhlIGNhbGxlciBzdXNjZXB0aWJsZSB0byB0aGUNCj5WTV9CVUdfT05fRk9MSU8oIWZv
bGlvX3JlZl9jb3VudChmb2xpbyksIGZvbGlvKTsgaWYgdGhlIG90aGVyIHRocmVhZCBjYWxscw0K
PmZvbGlvX3B1dCgpLg0KUmVzZW5kIHRoZSBjaGFydCB2aWEgb3V0bG9vay4NCkkgdGhpbmsgdGhl
IHByb2JsZW0gcmVseSBvbiBhbiBzcGVjaWFsIHRpbWluZyB3aGljaCBpcyByYXJlLCBJIHdvdWxk
IGxpa2UgdG8gbGlzdCB0aGVtIGJlbG93IGluIHRpbWluZyBzZXF1ZW5jZS4NCg0KMS4gdGhyZWFk
IDAgY2FsbHMgZm9saW9faXNvbGF0ZV9scnUgd2l0aCByZWZjbnQgPT0gMQ0KMi4gdGhyZWFkIDEg
Y2FsbHMgcmVsZWFzZV9wYWdlcyB3aXRoIHJlZmNudCA9PSAyLihJTU8sIGl0IGNvdWxkIGJlIDEg
YXMgcmVsZWFzZV9wYWdlcyBkb2Vzbid0IGNhcmUgaWYgdGhlIGZvbGlvIGlzIHVzZWQgYnkgcGFn
ZSBjYWNoZSBvciBmcykNCjMuIHRocmVhZCAyIGRlY3JlYXNlIHJlZmNudCB0byAxIGJ5IGNhbGxp
bmcgZmlsZW1hcF9mcmVlX2ZvbGlvLihhcyBJIG1lbnRpb25lZCBpbiAyLCB0aHJlYWQgMiBpcyBu
b3QgbWFuZGF0YXJ5IGhlcmUpDQo0LiB0aHJlYWQgMSBjYWxscyBmb2xpb19wdXRfdGVzdHplcm8g
YW5kIHBhc3MuKGxydXZlYy0+bG9jayBoYXMgbm90IGJlZW4gdGFrZSBoZXJlKQ0KNS4gdGhyZWFk
IDAgY2xlYXIgZm9saW8ncyBQR19scnUgYnkgY2FsbGluZyBmb2xpb190ZXN0X2NsZWFyX2xydS4g
VGhlIGZvbGlvX2dldCBiZWhpbmQgaGFzIG5vIG1lYW5pbmcgdGhlcmUuDQo2LiB0aHJlYWQgMSBm
YWlsZWQgaW4gZm9saW9fdGVzdF9scnUgYW5kIGxlYXZlIHRoZSBmb2xpbyBvbiB0aGUgTFJVLg0K
Ny4gdGhyZWFkIDEgYWRkIGZvbGlvIHRvIHBhZ2VzX3RvX2ZyZWUgd3JvbmdseSB3aGljaCBjb3Vs
ZCBicmVhayB0aGUgTFJVJ3MtPmxpc3QgYW5kIHdpbGwgaGF2ZSBuZXh0IGZvbGlvIGV4cGVyaWVu
Y2UgbGlzdF9kZWxfaW52YWxpZA0KDQojdGhyZWFkIDAobWFkaXZpc2VfY29sZF9hbmRfcGFnZW91
dCkgICAgICAgICMxKGxydV9hZGRfZHJhaW4tPmZiYXRjaF9yZWxlYXNlX3BhZ2VzKSAgICAgICAj
MihyZWFkX3BhZ2VzLT5maWxlbWFwX3JlbW92ZV9mb2xpb3MpDQpyZWZjbnQgPT0gMShyZXByZXNl
bnQgcGFnZSBjYWNoZSkgICAgICAgICAgICAgcmVmY250PT0yKGFub3RoZXIgb25lIHJlcHJlc2Vu
dCBMUlUpICAgICAgICAgIGZvbGlvIGNvbWVzIGZyb20gcGFnZSBjYWNoZQ0KDQpmb2xpb19pc29s
YXRlX2xydSAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlbGVhc2VfcGFnZXMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGZpbGVtYXBfZnJlZV9mb2xpbw0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAkJCQkJCQkJCQkgcmVmY250PT0xKGRlY3JlYXNlIHRoZSBv
bmUgb2YgcGFnZSBjYWNoZSkNCmZvbGlvX3Rlc3RfY2xlYXJfbHJ1DQo8Zm9saW8ncyBQR19scnUg
Z29uZT4NCgkJCQkJCQkJCQlmb2xpb19wdXRfdGVzdHplcm8gPT0gdHJ1ZQ0KZm9saW9fZ2V0DQoJ
CQkJCQkJCQkJZm9saW9fdGVzdF9scnUgPT0gZmFsc2UNCgkJCQkJCQkJCSAgCTxObyBscnV2ZWNf
ZGVsX2ZvbGlvPg0KCQkJCQkJCQkJCWxpc3RfYWRkKGZvbGlvLT5scnUsIHBhZ2VzX3RvX2ZyZWUp
DQoJCQkJCQkJCQkJLy9jdXJyZW50IGZvbGlvIHdpbGwgYnJlYWsgTFJVJ3MgaW50ZWdyaXR5IHNp
bmNlIGl0IGhhcyBub3QgYmVlbiBkZWxldGVkDQo+DQo+SSBjYW4ndCB1bmRlcnN0YW5kIGFueSBv
ZiB0aGUgc2NlbmFyaW9zIHlvdSBvdXRsaW5lIGJlbG93Lg0KPlBsZWFzZSB0cnkgYWdhaW4gd2l0
aG91dCByZWx5aW5nIG9uIGluZGVudGF0aW9uLg0KPg0KPj4gI3RocmVhZCAwKG1hZGl2aXNlX2Nv
bGRfYW5kX3BhZ2VvdXQpICAgICAgICAjMQ0KPj4gKGxydV9hZGRfZHJhaW4tPmZiYXRjaF9yZWxl
YXNlX3BhZ2VzKQ0KPj4gIzIocmVhZF9wYWdlcy0+ZmlsZW1hcF9yZW1vdmVfZm9saW9zKQ0KPj4g
cmVmY250ID09IDEocmVwcmVzZW50IHBhZ2UgY2FjaGUpDQo+Pg0KPj4gcmVmY250PT0yKGFub3Ro
ZXIgb25lIHJlcHJlc2VudCBMUlUpDQo+PiAgICBmb2xpbyBjb21lcyBmcm9tIHBhZ2UgY2FjaGUN
Cj4+IGZvbGlvX2lzb2xhdGVfbHJ1DQo+PiByZWxlYXNlX3BhZ2VzDQo+PiAgICAgICAgICAgICAg
ICAgIGZpbGVtYXBfZnJlZV9mb2xpbw0KPj4NCj4+DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJlZmNudD09MShkZWNyZWFzZSB0aGUgb25lIG9mIHBhZ2UNCj5jYWNoZSkNCj4+DQo+
PiAgZm9saW9fcHV0X3Rlc3R6ZXJvID09IHRydWUNCj4+DQo+PiAgIDxObyBscnV2ZWNfZGVsX2Zv
bGlvPg0KPj4NCj4+ICBsaXN0X2FkZChmb2xpby0+bHJ1LCBwYWdlc190b19mcmVlKSAvL2N1cnJl
bnQgZm9saW8gd2lsbCBicmVhayBMUlUncw0KPj4gaW50ZWdyaXR5IHNpbmNlIGl0IGhhcyBub3Qg
YmVlbiBkZWxldGVkDQo+Pg0KPj4gSW4gY2FzZSBvZiBnbWFpbCdzIHdyYXAsIHNwbGl0IGFib3Zl
IGNoYXJ0IHRvIHR3byBwYXJ0cw0KPj4NCj4+ICN0aHJlYWQgMChtYWRpdmlzZV9jb2xkX2FuZF9w
YWdlb3V0KSAgICAgICAgIzENCj4+IChscnVfYWRkX2RyYWluLT5mYmF0Y2hfcmVsZWFzZV9wYWdl
cykNCj4+IHJlZmNudCA9PSAxKHJlcHJlc2VudCBwYWdlIGNhY2hlKQ0KPj4NCj4+IHJlZmNudD09
Mihhbm90aGVyIG9uZSByZXByZXNlbnQgTFJVKQ0KPj4gZm9saW9faXNvbGF0ZV9scnUNCj5yZWxl
YXNlX3BhZ2VzDQo+Pg0KPj4gIGZvbGlvX3B1dF90ZXN0emVybyA9PSB0cnVlDQo+Pg0KPj4gICA8
Tm8gbHJ1dmVjX2RlbF9mb2xpbz4NCj4+DQo+PiAgbGlzdF9hZGQoZm9saW8tPmxydSwgcGFnZXNf
dG9fZnJlZSkNCj4+DQo+PiAgLy9jdXJyZW50IGZvbGlvIHdpbGwgYnJlYWsgTFJVJ3MgaW50ZWdy
aXR5IHNpbmNlIGl0IGhhcyBub3QgYmVlbg0KPj4gZGVsZXRlZA0KPj4NCj4+ICMxIChscnVfYWRk
X2RyYWluLT5mYmF0Y2hfcmVsZWFzZV9wYWdlcykNCj4+ICMyKHJlYWRfcGFnZXMtPmZpbGVtYXBf
cmVtb3ZlX2ZvbGlvcykNCj4+IHJlZmNudD09Mihhbm90aGVyIG9uZSByZXByZXNlbnQgTFJVKQ0K
Pj4gICAgZm9saW8gY29tZXMgZnJvbSBwYWdlIGNhY2hlDQo+PiByZWxlYXNlX3BhZ2VzDQo+PiAg
ICAgICAgICAgICAgICAgIGZpbGVtYXBfZnJlZV9mb2xpbw0KPj4NCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZWZjbnQ9PTEoZGVjcmVhc2UgdGhlIG9uZSBvZiBwYWdlDQo+Y2FjaGUp
DQo+PiBmb2xpb19wdXRfdGVzdHplcm8gPT0gdHJ1ZSAgPE5vIGxydXZlY19kZWxfZm9saW8+DQo+
PiBsaXN0X2FkZChmb2xpby0+bHJ1LCBwYWdlc190b19mcmVlKSAvL2N1cnJlbnQgZm9saW8gd2ls
bCBicmVhayBMUlUncw0KPj4gaW50ZWdyaXR5IHNpbmNlIGl0IGhhcyBub3QgYmVlbiBkZWxldGVk
DQo+PiA+DQo+PiA+ID4gICAgIzAgZm9saW9faXNvbGF0ZV9scnUgICAgICAgICAgIzEgcmVsZWFz
ZV9wYWdlcw0KPj4gPiA+IEJVR19PTighZm9saW9fcmVmY250KQ0KPj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYNCj4oZm9saW9fcHV0X3Rlc3R6ZXJvKCkp
DQo+PiA+ID4gICAgZm9saW9fZ2V0KGZvbGlvKQ0KPj4gPiA+ICAgIGlmIChmb2xpb190ZXN0X2Ns
ZWFyX2xydSgpKQ0K

