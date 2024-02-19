Return-Path: <linux-kernel+bounces-71029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AB859FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD79C1C21149
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F72376D;
	Mon, 19 Feb 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="JSXS+H9s"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9C42421E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334872; cv=none; b=Igtc2xxnMynj3FUQ2Xv9fXRJKFMUkdbt/vWQxvs7kYGzfsy+PdUY0rVpCn7oXDSYujZTji9/6QR8ZF8/3Wx9di9zpGZZGOm7inGK4hAoG2rl3+VdtSdR9nknJZ0YAc2Y1On/a/zzXYHXghE5tItfhSv7EiSWDsJRQO8X30iS1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334872; c=relaxed/simple;
	bh=9fjgrCkQJcTG401P9Y7fOzSFtlh4A7QyDmdWBZ31pYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FGRV4SOtgAbdQneAiEYVAsJIOEywIfo7MwIxZi6ArjQkBKEkYMWtleo/4swgABpY0L9uDtoQAQytXNQ+1eUDlq5RuYITrnJvaFmWmfw9hmYbZVLXs7HfF23fN0EO1m/YovtQfk79XMeNLdU5gRkwiDBU6cCxBRyJEfS0NRXARtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=JSXS+H9s reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=LdXQA66iqTewnXLGYwkQx7fMCWVbVDbz/y8KNE5FnZ8=; b=J
	SXS+H9s7HHL/vHOzHbkgpxpTndollX4wJaIePQzXjHrOK/O3ld2roYZnMocy8QXS
	LEAoXT8P5gm0llaNzuVV05uVodz6+uEwdiXkp9v/L4oVsW4Z7G8ec+QlxSsBnH6w
	QiRXMHBkdd2BUMO+pwBFRA8LsWPhHJcmKbbX0wTL9M=
Received: from gaoshanliukou$163.com ( [60.24.209.108] ) by
 ajax-webmail-wmsvr-40-114 (Coremail) ; Mon, 19 Feb 2024 17:26:55 +0800
 (CST)
Date: Mon, 19 Feb 2024 17:26:55 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Baoquan He" <bhe@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "yang.zhang" <yang.zhang@hexintek.com>, 
	akpm@linux-foundation.org
Subject: Re:Re: [PATCH] kexec: should use uchunk for user buffer increasing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZdK/Hsy1TMB8PlJs@MiWiFi-R3L-srv>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
 <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
 <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
 <2a207ca2.1e87.18dbf17ee10.Coremail.gaoshanliukou@163.com>
 <ZdK/Hsy1TMB8PlJs@MiWiFi-R3L-srv>
X-NTES-SC: AL_Qu2bCv+Yu0Aq4yGRY+kXnEYQh+k3XcK4u/0u2YFVP5E0oyTL8z0ARUdJIVL69+GMNS2NiCCzaBpn5cJBXZNDc7oAhva9lGIG43yCV0QCwDB7
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <23cb32ca.9195.18dc0b09810.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3ny_fHtNl5B7kAA--.18548W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbBZQKF8mV4H1oUZwAGs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgpUaGFua3MsIGkgd291bGQgcG9zdCB2MiBwYXRjaC4KQ291bGQgeW91IHBsZWFzZSBwcm92
aWRlIHRoZSBlbWFpbCBhZGRyZXNzIGZvciBhbmRyZXcuCgoKCgoKCgoKCkF0IDIwMjQtMDItMTkg
MTA6Mzg6MjIsICJCYW9xdWFuIEhlIiA8YmhlQHJlZGhhdC5jb20+IHdyb3RlOgo+T24gMDIvMTkv
MjQgYXQgMTA6MDBhbSwgeWFuZy56aGFuZyB3cm90ZToKPj4gCj4+IAo+PiAKPj4gVGhhbmtzIGZv
ciB5b3VyIHJlcGxpZXMuCj4+IERvIHlvdSBoYXZlIHBsYW5zIHRvIG1lcmdlIHRoZSBpbXByb3Zp
bmcgY29kZSBmb3IgY2xhcml0eSwgb3IganVzdCBrZWVwIHRoZW0gdW5jaGFuZ2VkLgo+Cj5Zb3Ug
bmVlZCBwb3N0IHYyIHRvIGNoYW5nZSB0aG9zZSB0d28gcGxhY2VzIGFzIEVyaWMgaGFzIGRlbW9u
c3RyYXRlZC4KPlBsZWFzZSBDQyBBbmRyZXcgd2hlbiB5b3UgcG9zdC4KPgo+PiAKPj4gQXQgMjAy
NC0wMi0wNSAyMDoyNzozMywgIkVyaWMgVy4gQmllZGVybWFuIiA8ZWJpZWRlcm1AeG1pc3Npb24u
Y29tPiB3cm90ZToKPj4gPkJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPiB3cml0ZXM6Cj4+ID4K
Pj4gPj4gT24gMDEvMzAvMjQgYXQgMDY6MThwbSwgeWFuZy56aGFuZyB3cm90ZToKPj4gPj4+IEZy
b206ICJ5YW5nLnpoYW5nIiA8eWFuZy56aGFuZ0BoZXhpbnRlay5jb20+Cj4+ID4+PiAKPj4gPj4+
IEJlY2F1c2Ugb2YgYWxpZ25tZW50IHJlcXVpcmVtZW50IGluIGtleGVjLXRvb2xzLCB0aGVyZSBp
cwo+PiA+Pj4gbm8gcHJvYmxlbSBmb3IgdXNlciBidWZmZXIgaW5jcmVhc2luZyB3aGVuIGxvYWRp
bmcgc2VnbWVudHMuCj4+ID4+PiBCdXQgd2hlbiBjb3BpbmcsIHRoZSBzdGVwIGlzIHVjaHVuaywg
c28gd2Ugc2hvdWxkIHVzZSB1Y2h1bmsKPj4gPj4+IG5vdCBtY2h1bmsuCj4+ID4+Cj4+ID4+IElu
IHRoZW9yeSwgdWJ5dGVzIGlzIDw9IG1ieXRlcy4gU28gdWNodW5rIGlzIGFsd2F5cyA8PSBtY2h1
bmsuIElmIHVieXRlcwo+PiA+PiBpcyBleGhhdXN0ZWQsIHdoaWxlIHRoZXJlJ3Mgc3RpbGwgcmVt
YWluaW5nIG1ieXRlcywgdGhlbiB1Y2h1bmsgaXMgMCwKPj4gPj4gdGhlcmUncyBzdGlsbCBtY2h1
bmsgc3RlcHBpbmcgZm9yd2FyZC4gSWYgSSB1bmRlcnN0YW5kIGl0IGNvcnJlY3RseSwKPj4gPj4g
dGhpcyBpcyBhIGdvb2QgY2F0Y2guIE5vdCBzdXJlIGlmIEVyaWMgaGFzIGNvbW1lbnQgb24gdGhp
cyB0byBjb25maXJtLgo+PiA+Cj4+ID5BcyBmYXIgYXMgSSBjYW4gcmVhZCB0aGUgY29kZSB0aGUg
cHJvcG9zZWQgY2hhbmdlIGlzIGEgbm9vcC4KPj4gPgo+PiA+SSBhZ3JlZSBpdCBpcyBtb3JlIGNv
cnJlY3QgdG8gbm90IGFkdmFuY2UgdGhlIHBvaW50ZXJzIHdlIHJlYWQgZnJvbSwKPj4gPmJ1dCBz
aW5jZSB3ZSBuZXZlciByZWFkIGZyb20gdGhlbSBhZnRlciB0aGF0IHBvaW50IGl0IGRvZXMgbm90
Cj4+ID5tYXR0ZXIuCj4+ID4KPj4gPj4KPj4gPj4gc3RhdGljIGludCBraW1hZ2VfbG9hZF9ub3Jt
YWxfc2VnbWVudChzdHJ1Y3Qga2ltYWdlICppbWFnZSwKPj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2V4ZWNfc2VnbWVudCAqc2VnbWVudCkKPj4g
Pj4gewo+PiA+PiAuLi4uLi4KPj4gPj4KPj4gPj4gICAgICAgICAgICAgICAgIHB0ciArPSBtYWRk
ciAmIH5QQUdFX01BU0s7Cj4+ID4+ICAgICAgICAgICAgICAgICBtY2h1bmsgPSBtaW5fdChzaXpl
X3QsIG1ieXRlcywKPj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQUdFX1NJ
WkUgLSAobWFkZHIgJiB+UEFHRV9NQVNLKSk7Cj4+ID4+ICAgICAgICAgICAgICAgICB1Y2h1bmsg
PSBtaW4odWJ5dGVzLCBtY2h1bmspOwo+PiA+PiAuLi4uLi59Cj4+ID4KPj4gPklmIHdlIGFyZSBn
b2luZyB0byBpbXByb3ZlIHRoZSBjb2RlIGZvciBjbGFyaXR5LiAgV2UgcHJvYmFibHkKPj4gPndh
bnQgdG8gZG8gc29tZXRoaW5nIGxpa2U6Cj4+ID4KPj4gPmRpZmYgLS1naXQgYS9rZXJuZWwva2V4
ZWNfY29yZS5jIGIva2VybmVsL2tleGVjX2NvcmUuYwo+PiA+aW5kZXggZDA4ZmM3YjVkYjk3Li4x
YThiOGNlNmJmMTUgMTAwNjQ0Cj4+ID4tLS0gYS9rZXJuZWwva2V4ZWNfY29yZS5jCj4+ID4rKysg
Yi9rZXJuZWwva2V4ZWNfY29yZS5jCj4+ID5AQCAtODAwLDIyICs4MDAsMjQgQEAgc3RhdGljIGlu
dCBraW1hZ2VfbG9hZF9ub3JtYWxfc2VnbWVudChzdHJ1Y3Qga2ltYWdlICppbWFnZSwKPj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEFHRV9TSVpFIC0gKG1hZGRyICYgflBBR0Vf
TUFTSykpOwo+PiA+ICAgICAgICAgICAgICAgIHVjaHVuayA9IG1pbih1Ynl0ZXMsIG1jaHVuayk7
Cj4+ID4gCj4+ID4tICAgICAgICAgICAgICAgLyogRm9yIGZpbGUgYmFzZWQga2V4ZWMsIHNvdXJj
ZSBwYWdlcyBhcmUgaW4ga2VybmVsIG1lbW9yeSAqLwo+PiA+LSAgICAgICAgICAgICAgIGlmIChp
bWFnZS0+ZmlsZV9tb2RlKQo+PiA+LSAgICAgICAgICAgICAgICAgICAgICAgbWVtY3B5KHB0ciwg
a2J1ZiwgdWNodW5rKTsKPj4gPi0gICAgICAgICAgICAgICBlbHNlCj4+ID4tICAgICAgICAgICAg
ICAgICAgICAgICByZXN1bHQgPSBjb3B5X2Zyb21fdXNlcihwdHIsIGJ1ZiwgdWNodW5rKTsKPj4g
PisgICAgICAgICAgICAgICBpZiAodWNodW5rKSB7Cj4+ID4rICAgICAgICAgICAgICAgICAgICAg
ICAvKiBGb3IgZmlsZSBiYXNlZCBrZXhlYywgc291cmNlIHBhZ2VzIGFyZSBpbiBrZXJuZWwgbWVt
b3J5ICovCj4+ID4rICAgICAgICAgICAgICAgICAgICAgICBpZiAoaW1hZ2UtPmZpbGVfbW9kZSkK
Pj4gPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtY3B5KHB0ciwga2J1ZiwgdWNo
dW5rKTsKPj4gPisgICAgICAgICAgICAgICAgICAgICAgIGVsc2UKPj4gPisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVzdWx0ID0gY29weV9mcm9tX3VzZXIocHRyLCBidWYsIHVjaHVu
ayk7Cj4+ID4rICAgICAgICAgICAgICAgICAgICAgICB1Ynl0ZXMgLT0gdWNodW5rOwo+PiA+KyAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKGltYWdlLT5maWxlX21vZGUpCj4+ID4rICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGtidWYgKz0gdWNodW5rOwo+PiA+KyAgICAgICAgICAgICAg
ICAgICAgICAgZWxzZQo+PiA+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidWYgKz0g
dWNodW5rOwo+PiA+KyAgICAgICAgICAgICAgIH0KPj4gPiAgICAgICAgICAgICAgICBrdW5tYXBf
bG9jYWwocHRyKTsKPj4gPiAgICAgICAgICAgICAgICBpZiAocmVzdWx0KSB7Cj4+ID4gICAgICAg
ICAgICAgICAgICAgICAgICByZXN1bHQgPSAtRUZBVUxUOwo+PiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBvdXQ7Cj4+ID4gICAgICAgICAgICAgICAgfQo+PiA+LSAgICAgICAgICAgICAg
IHVieXRlcyAtPSB1Y2h1bms7Cj4+ID4gICAgICAgICAgICAgICAgbWFkZHIgICs9IG1jaHVuazsK
Pj4gPi0gICAgICAgICAgICAgICBpZiAoaW1hZ2UtPmZpbGVfbW9kZSkKPj4gPi0gICAgICAgICAg
ICAgICAgICAgICAgIGtidWYgKz0gbWNodW5rOwo+PiA+LSAgICAgICAgICAgICAgIGVsc2UKPj4g
Pi0gICAgICAgICAgICAgICAgICAgICAgIGJ1ZiArPSBtY2h1bms7Cj4+ID4gICAgICAgICAgICAg
ICAgbWJ5dGVzIC09IG1jaHVuazsKPj4gPiAKPj4gPiAgICAgICAgICAgICAgICBjb25kX3Jlc2No
ZWQoKTsKPj4gPgo+PiA+QW5kIG1ha2UgaXQgZXhjZWVkaW5nbHkgY2xlYXIgdGhhdCBhbGwgb2Yg
dGhlIGNvcHlpbmcgYW5kIHRoZSByZXN0Cj4+ID5vbmx5IGhhcHBlbnMgYmVmb3JlIHVjaHVuayBn
b2VzIHRvIHplcm8uICBPdGhlcndpc2Ugd2UgYXJlIHJlbHlpbmcKPj4gPm9uIGEgbG90IG9mIG9w
ZXJhdGlvbnMgYmVjb21pbmcgbm9vcHMgd2hlbiB1Y2h1bmsgZ29lcyB0byB6ZXJvLgo+PiA+Cj4+
ID5FcmljCg==

