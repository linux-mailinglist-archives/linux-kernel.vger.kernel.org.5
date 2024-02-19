Return-Path: <linux-kernel+bounces-70647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB97859AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D41F211B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB5320F1;
	Mon, 19 Feb 2024 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="nd+NYiE9"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B0D1852
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308990; cv=none; b=AcUqur8hRvQGt/JgJGxJyq4bbV8WIZ4KwAM8ZBokBB9tqC0JF2BZPkzmbc50WLYyJqK0Y1wrOwqyiuu78EgkjULhiqKMzvxYx4TFRQL7068JBIWF4frY0RR5tD5D2EdkQxpvAFwt+qKF9ifwXbh3m1jb8SSzOu4ij2wpSQ0G2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308990; c=relaxed/simple;
	bh=7tsd5hmIB+kEXjUleS+0h80eRrRYoK5QIaiBEu2xlEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=qEub6kIeG05P87yFIix9bfvRkbyCbwIEdS0JjjFzIJ3F3rb0xAJ4jKOCTMr0VQ46ahAruLbQPeOUXaNb1mowqP1Bu6nwEyp20Jbv/5FlG/5ulGXGK6bsxrgrQlizXjuL8PZ7y0ANxJhPHWu/lQ0hdfj3mJpJOD17O4puxaSKxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=nd+NYiE9 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=/LIr/n4Me0c+pWUjj1O4glgEqVVux4ELuAgUnDnG7WY=; b=n
	d+NYiE9MRWavblELTgECINM4SreUUr12x+sT7ZPwPuefCg9hafPq1lVHdl2aRVWL
	26rvKLFMsk6NDk1NYKmKyl2Ag+JZDJo9AR9R9IIWqKSi3lM6epxUMmqzrJTcUOup
	YEFOf4O8oRKRjq5c9WuZXKtyhXPshfnYPF8qO1tHDU=
Received: from gaoshanliukou$163.com ( [60.24.209.108] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Mon, 19 Feb 2024 10:00:33 +0800
 (CST)
Date: Mon, 19 Feb 2024 10:00:33 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Baoquan He" <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "yang.zhang" <yang.zhang@hexintek.com>
Subject: Re:Re: [PATCH] kexec: should use uchunk for user buffer increasing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
 <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
 <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
X-NTES-SC: AL_Qu2bCv+bt0go5SCbYukXnEYQh+k3XcK4u/0u2YFVP5E0lSTx0wURfH5gB3X34camBz60sRmISxV12Ol9UJl0XYbn5/hBo+Ki1kLwmlHoKHWT
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2a207ca2.1e87.18dbf17ee10.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wB39JNBttJl4+HBAA--.24654W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbBZQKF8mV4H1oUZwADs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKVGhhbmtzIGZvciB5b3VyIHJlcGxpZXMuCkRvIHlvdSBoYXZlIHBsYW5zIHRvIG1lcmdlIHRo
ZSBpbXByb3ZpbmcgY29kZSBmb3IgY2xhcml0eSwgb3IganVzdCBrZWVwIHRoZW0gdW5jaGFuZ2Vk
LgoKCgoKCgoKCgoKCgpBdCAyMDI0LTAyLTA1IDIwOjI3OjMzLCAiRXJpYyBXLiBCaWVkZXJtYW4i
IDxlYmllZGVybUB4bWlzc2lvbi5jb20+IHdyb3RlOgo+QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5j
b20+IHdyaXRlczoKPgo+PiBPbiAwMS8zMC8yNCBhdCAwNjoxOHBtLCB5YW5nLnpoYW5nIHdyb3Rl
Ogo+Pj4gRnJvbTogInlhbmcuemhhbmciIDx5YW5nLnpoYW5nQGhleGludGVrLmNvbT4KPj4+IAo+
Pj4gQmVjYXVzZSBvZiBhbGlnbm1lbnQgcmVxdWlyZW1lbnQgaW4ga2V4ZWMtdG9vbHMsIHRoZXJl
IGlzCj4+PiBubyBwcm9ibGVtIGZvciB1c2VyIGJ1ZmZlciBpbmNyZWFzaW5nIHdoZW4gbG9hZGlu
ZyBzZWdtZW50cy4KPj4+IEJ1dCB3aGVuIGNvcGluZywgdGhlIHN0ZXAgaXMgdWNodW5rLCBzbyB3
ZSBzaG91bGQgdXNlIHVjaHVuawo+Pj4gbm90IG1jaHVuay4KPj4KPj4gSW4gdGhlb3J5LCB1Ynl0
ZXMgaXMgPD0gbWJ5dGVzLiBTbyB1Y2h1bmsgaXMgYWx3YXlzIDw9IG1jaHVuay4gSWYgdWJ5dGVz
Cj4+IGlzIGV4aGF1c3RlZCwgd2hpbGUgdGhlcmUncyBzdGlsbCByZW1haW5pbmcgbWJ5dGVzLCB0
aGVuIHVjaHVuayBpcyAwLAo+PiB0aGVyZSdzIHN0aWxsIG1jaHVuayBzdGVwcGluZyBmb3J3YXJk
LiBJZiBJIHVuZGVyc3RhbmQgaXQgY29ycmVjdGx5LAo+PiB0aGlzIGlzIGEgZ29vZCBjYXRjaC4g
Tm90IHN1cmUgaWYgRXJpYyBoYXMgY29tbWVudCBvbiB0aGlzIHRvIGNvbmZpcm0uCj4KPkFzIGZh
ciBhcyBJIGNhbiByZWFkIHRoZSBjb2RlIHRoZSBwcm9wb3NlZCBjaGFuZ2UgaXMgYSBub29wLgo+
Cj5JIGFncmVlIGl0IGlzIG1vcmUgY29ycmVjdCB0byBub3QgYWR2YW5jZSB0aGUgcG9pbnRlcnMg
d2UgcmVhZCBmcm9tLAo+YnV0IHNpbmNlIHdlIG5ldmVyIHJlYWQgZnJvbSB0aGVtIGFmdGVyIHRo
YXQgcG9pbnQgaXQgZG9lcyBub3QKPm1hdHRlci4KPgo+Pgo+PiBzdGF0aWMgaW50IGtpbWFnZV9s
b2FkX25vcm1hbF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgKmltYWdlLAo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBrZXhlY19zZWdtZW50ICpzZWdtZW50
KQo+PiB7Cj4+IC4uLi4uLgo+Pgo+PiAgICAgICAgICAgICAgICAgcHRyICs9IG1hZGRyICYgflBB
R0VfTUFTSzsKPj4gICAgICAgICAgICAgICAgIG1jaHVuayA9IG1pbl90KHNpemVfdCwgbWJ5dGVz
LAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBR0VfU0laRSAtIChtYWRkciAm
IH5QQUdFX01BU0spKTsKPj4gICAgICAgICAgICAgICAgIHVjaHVuayA9IG1pbih1Ynl0ZXMsIG1j
aHVuayk7Cj4+IC4uLi4uLn0KPgo+SWYgd2UgYXJlIGdvaW5nIHRvIGltcHJvdmUgdGhlIGNvZGUg
Zm9yIGNsYXJpdHkuICBXZSBwcm9iYWJseQo+d2FudCB0byBkbyBzb21ldGhpbmcgbGlrZToKPgo+
ZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhlY19jb3JlLmMgYi9rZXJuZWwva2V4ZWNfY29yZS5jCj5p
bmRleCBkMDhmYzdiNWRiOTcuLjFhOGI4Y2U2YmYxNSAxMDA2NDQKPi0tLSBhL2tlcm5lbC9rZXhl
Y19jb3JlLmMKPisrKyBiL2tlcm5lbC9rZXhlY19jb3JlLmMKPkBAIC04MDAsMjIgKzgwMCwyNCBA
QCBzdGF0aWMgaW50IGtpbWFnZV9sb2FkX25vcm1hbF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgKmlt
YWdlLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQUdFX1NJWkUgLSAobWFkZHIg
JiB+UEFHRV9NQVNLKSk7Cj4gICAgICAgICAgICAgICAgdWNodW5rID0gbWluKHVieXRlcywgbWNo
dW5rKTsKPiAKPi0gICAgICAgICAgICAgICAvKiBGb3IgZmlsZSBiYXNlZCBrZXhlYywgc291cmNl
IHBhZ2VzIGFyZSBpbiBrZXJuZWwgbWVtb3J5ICovCj4tICAgICAgICAgICAgICAgaWYgKGltYWdl
LT5maWxlX21vZGUpCj4tICAgICAgICAgICAgICAgICAgICAgICBtZW1jcHkocHRyLCBrYnVmLCB1
Y2h1bmspOwo+LSAgICAgICAgICAgICAgIGVsc2UKPi0gICAgICAgICAgICAgICAgICAgICAgIHJl
c3VsdCA9IGNvcHlfZnJvbV91c2VyKHB0ciwgYnVmLCB1Y2h1bmspOwo+KyAgICAgICAgICAgICAg
IGlmICh1Y2h1bmspIHsKPisgICAgICAgICAgICAgICAgICAgICAgIC8qIEZvciBmaWxlIGJhc2Vk
IGtleGVjLCBzb3VyY2UgcGFnZXMgYXJlIGluIGtlcm5lbCBtZW1vcnkgKi8KPisgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChpbWFnZS0+ZmlsZV9tb2RlKQo+KyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtZW1jcHkocHRyLCBrYnVmLCB1Y2h1bmspOwo+KyAgICAgICAgICAgICAgICAg
ICAgICAgZWxzZQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXN1bHQgPSBjb3B5
X2Zyb21fdXNlcihwdHIsIGJ1ZiwgdWNodW5rKTsKPisgICAgICAgICAgICAgICAgICAgICAgIHVi
eXRlcyAtPSB1Y2h1bms7Cj4rICAgICAgICAgICAgICAgICAgICAgICBpZiAoaW1hZ2UtPmZpbGVf
bW9kZSkKPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2J1ZiArPSB1Y2h1bms7Cj4r
ICAgICAgICAgICAgICAgICAgICAgICBlbHNlCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJ1ZiArPSB1Y2h1bms7Cj4rICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAgIGt1
bm1hcF9sb2NhbChwdHIpOwo+ICAgICAgICAgICAgICAgIGlmIChyZXN1bHQpIHsKPiAgICAgICAg
ICAgICAgICAgICAgICAgIHJlc3VsdCA9IC1FRkFVTFQ7Cj4gICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIG91dDsKPiAgICAgICAgICAgICAgICB9Cj4tICAgICAgICAgICAgICAgdWJ5dGVzIC09
IHVjaHVuazsKPiAgICAgICAgICAgICAgICBtYWRkciAgKz0gbWNodW5rOwo+LSAgICAgICAgICAg
ICAgIGlmIChpbWFnZS0+ZmlsZV9tb2RlKQo+LSAgICAgICAgICAgICAgICAgICAgICAga2J1ZiAr
PSBtY2h1bms7Cj4tICAgICAgICAgICAgICAgZWxzZQo+LSAgICAgICAgICAgICAgICAgICAgICAg
YnVmICs9IG1jaHVuazsKPiAgICAgICAgICAgICAgICBtYnl0ZXMgLT0gbWNodW5rOwo+IAo+ICAg
ICAgICAgICAgICAgIGNvbmRfcmVzY2hlZCgpOwo+Cj5BbmQgbWFrZSBpdCBleGNlZWRpbmdseSBj
bGVhciB0aGF0IGFsbCBvZiB0aGUgY29weWluZyBhbmQgdGhlIHJlc3QKPm9ubHkgaGFwcGVucyBi
ZWZvcmUgdWNodW5rIGdvZXMgdG8gemVyby4gIE90aGVyd2lzZSB3ZSBhcmUgcmVseWluZwo+b24g
YSBsb3Qgb2Ygb3BlcmF0aW9ucyBiZWNvbWluZyBub29wcyB3aGVuIHVjaHVuayBnb2VzIHRvIHpl
cm8uCj4KPkVyaWMK

