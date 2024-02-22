Return-Path: <linux-kernel+bounces-76214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B116B85F444
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C1A1F25995
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BA374E0;
	Thu, 22 Feb 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="W8ptBf2n"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C7C2BB09
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593882; cv=none; b=XQyEIAYKzZdPqIaOAoYQoCoIHt6qM+iNkohoW117hM0EJbyFQPTeUaCeP6TFKsSWc/+pZya8XS5OpfBF008dJkUKLyIMSF9zFlAUYxK7ciUF0nWDY5knl0I3V5L9CTcM5/1GeI7tgd/csSRZE7RiPGRGuIdZvt6ltpwRYi4ND8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593882; c=relaxed/simple;
	bh=3ng7fIjnIC6sT51IC4/UuqCxbMN1e2+I+j9djmO3qlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=OFT6Kww9enG7BvnpFYg9kOe8K7PAQW8cw8iLzMZEnSUAsk6Id3lp/NI9YI9gWEzwfVWLDDljTYDHgKvhvmNS5w+ujpbFTAQvNmTAGAUgNAXjT85shJZ+lbd9GqX+cnGAMhu9bNTt/QhppvrZ9eWIk3MU01+IvCZzCfznEbmUlns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=W8ptBf2n reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Vv+6eYhYqxT5hunqvGaonr/mo3RX0vy18gjG7AgJ+Uc=; b=W
	8ptBf2nSSlH0jnCte9xw5t+dh8fhrjUtTFGKma8ymqqBhe8Yig+jq+0VnW0CLE0T
	NpvMDgsLXuwjrN3drAjm0rxyNc+hJE83M1EWIdoraO+y1Z6D0mJiM8qzYb1rif8S
	vQp/gn7hBtz23bEsAgno2TsARlORalf3wx0lU9ZCPw=
Received: from gaoshanliukou$163.com ( [60.27.226.204] ) by
 ajax-webmail-wmsvr-40-110 (Coremail) ; Thu, 22 Feb 2024 17:24:20 +0800
 (CST)
Date: Thu, 22 Feb 2024 17:24:20 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Baoquan He" <bhe@redhat.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: Re:Re: [PATCH v2] kexec: copy only happens before uchunk goes to
 zero
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <Zdb7ogmu/7IOBN3U@MiWiFi-R3L-srv>
References: <20240220021106.694-1-gaoshanliukou@163.com>
 <Zdb7ogmu/7IOBN3U@MiWiFi-R3L-srv>
X-NTES-SC: AL_Qu2bCvmSvEAt5iaYZ+kXnEYQh+k3XcK4u/0u2YFVP5E0vyTz9gklc3FYEGD13tqONS+OvhamXzFUycRfWoJfRpPvWbfIbQ9dsutaYlvl2nql
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <187a4850.c0d8.18dd0214ffe.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_zrEEtdlEif9AA--.33381W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbB0BmM8mWXwByflwABsQ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDItMjIgMTU6NDU6MzgsICJCYW9xdWFuIEhlIiA8YmhlQHJlZGhhdC5jb20+IHdy
b3RlOgo+T24gMDIvMjAvMjQgYXQgMTA6MTFhbSwgeWFuZy56aGFuZyB3cm90ZToKPj4gRnJvbTog
InlhbmcuemhhbmciIDx5YW5nLnpoYW5nQGhleGludGVrLmNvbT4KPj4gCj4+IFdoZW4gbG9hZCBz
ZWdtZW50cywgYWxsIG9mIHRoZSBjb3B5aW5nIGFuZCB0aGUgcmVzdAo+PiBvbmx5IGhhcHBlbnMg
YmVmb3JlIHVjaHVuayBnb2VzIHRvIHplcm8uCj4KPlRoZSBjb2RlIGNoYW5nZSBsb29rcyBnb29k
LCB3aGlsZSB0aGUgbG9nIGNhbiBiZSBpbXByb3ZlZCB3aXRoIG1vcmUKPmRldGFpbHMgc28gdGhh
dCBwZW9wbGUgY2FuIG1vcmUgZWFzaWx5IGdldCB3aGF0J3Mgd3JvbmcgYW5kIGZpeGVkLgo+Cj49
PT0KPldoZW4gbG9hZGluZyBzZWdtZW50cywgdWJ5dGVzIGlzIDw9IG1ieXRlcy4gV2hlbiB1Ynl0
ZXMgaXMgZXhoYXVzdGVkLAo+dGhlcmUgY291bGQgYmUgcmVtYWluaW5nIG1ieXRlcy4gVGhlbiBp
biB0aGUgd2hpbGUgbG9vcCwgdGhlIGJ1ZiBwb2ludGVyCj5hZHZhbmNpbmcgd2l0aCBtY2h1bmsg
d2lsbCBjYXVzaW5nIG1lYW5pbmdsZXNzIHJlYWRpbmcgZXZlbiB0aG91Z2ggaXQKPmRvZXNuJ3Qg
aGFybS4gCj4KPlNvIGxldCdzIGNoYW5nZSB0byBtYWtlIHN1cmUgdGhhdCBhbGwgb2YgdGhlIGNv
cHlpbmcgYW5kIHRoZSByZXN0IG9ubHkKPmhhcHBlbnMgYmVmb3JlIHVjaHVuayBnb2VzIHRvIHpl
cm8uCj49PT0KPgo+UGxlYXNlIHRha2UgYWJvdmUgd29yZHMgYXMgcmVmZXJlbmNlIHRvIHVkcGF0
ZSBwYXRjaCBsb2cgYW5kIHBvc3QgdjMsCj5hbmQgeW91IGNhbiBhZGQ6Cj4KCj5BY2tlZC1ieTog
QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+ClRoYW5rcywgaSB1cGRhdGUgdGhlIGNvbW1pdHMg
YW5kIHBvc3QgdjMuPgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogeWFuZy56aGFuZyA8eWFuZy56aGFu
Z0BoZXhpbnRlay5jb20+Cj4+IAo+PiAtLS0KPj4gdjEgLT4gdjI6Cj4+IC0gT25seSBjb3B5IGJl
Zm9yZSB1Y2h1bmsgZ29lcyB0byB6ZXJvCj4+IAo+PiBWMTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDI0MDEzMDEwMTgwMi4yMzg1MC0xLWdhb3NoYW5saXVrb3VAMTYzLmNvbS8KPj4g
LS0tCj4+ICBrZXJuZWwva2V4ZWNfY29yZS5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCAyMCBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWNfY29yZS5j
IGIva2VybmVsL2tleGVjX2NvcmUuYwo+PiBpbmRleCBkMDhmYzdiNWRiOTcuLjJmYzNkMGUzNzE1
YSAxMDA2NDQKPj4gLS0tIGEva2VybmVsL2tleGVjX2NvcmUuYwo+PiArKysgYi9rZXJuZWwva2V4
ZWNfY29yZS5jCj4+IEBAIC04MDAsMjIgKzgwMCwyNCBAQCBzdGF0aWMgaW50IGtpbWFnZV9sb2Fk
X25vcm1hbF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgKmltYWdlLAo+PiAgCQkJCVBBR0VfU0laRSAt
IChtYWRkciAmIH5QQUdFX01BU0spKTsKPj4gIAkJdWNodW5rID0gbWluKHVieXRlcywgbWNodW5r
KTsKPj4gIAo+PiAtCQkvKiBGb3IgZmlsZSBiYXNlZCBrZXhlYywgc291cmNlIHBhZ2VzIGFyZSBp
biBrZXJuZWwgbWVtb3J5ICovCj4+IC0JCWlmIChpbWFnZS0+ZmlsZV9tb2RlKQo+PiAtCQkJbWVt
Y3B5KHB0ciwga2J1ZiwgdWNodW5rKTsKPj4gLQkJZWxzZQo+PiAtCQkJcmVzdWx0ID0gY29weV9m
cm9tX3VzZXIocHRyLCBidWYsIHVjaHVuayk7Cj4+ICsJCWlmICh1Y2h1bmspIHsKPj4gKwkJCS8q
IEZvciBmaWxlIGJhc2VkIGtleGVjLCBzb3VyY2UgcGFnZXMgYXJlIGluIGtlcm5lbCBtZW1vcnkg
Ki8KPj4gKwkJCWlmIChpbWFnZS0+ZmlsZV9tb2RlKQo+PiArCQkJCW1lbWNweShwdHIsIGtidWYs
IHVjaHVuayk7Cj4+ICsJCQllbHNlCj4+ICsJCQkJcmVzdWx0ID0gY29weV9mcm9tX3VzZXIocHRy
LCBidWYsIHVjaHVuayk7Cj4+ICsJCQl1Ynl0ZXMgLT0gdWNodW5rOwo+PiArCQkJaWYgKGltYWdl
LT5maWxlX21vZGUpCj4+ICsJCQkJa2J1ZiArPSB1Y2h1bms7Cj4+ICsJCQllbHNlCj4+ICsJCQkJ
YnVmICs9IHVjaHVuazsKPj4gKwkJfQo+PiAgCQlrdW5tYXBfbG9jYWwocHRyKTsKPj4gIAkJaWYg
KHJlc3VsdCkgewo+PiAgCQkJcmVzdWx0ID0gLUVGQVVMVDsKPj4gIAkJCWdvdG8gb3V0Owo+PiAg
CQl9Cj4+IC0JCXVieXRlcyAtPSB1Y2h1bms7Cj4+ICAJCW1hZGRyICArPSBtY2h1bms7Cj4+IC0J
CWlmIChpbWFnZS0+ZmlsZV9tb2RlKQo+PiAtCQkJa2J1ZiArPSBtY2h1bms7Cj4+IC0JCWVsc2UK
Pj4gLQkJCWJ1ZiArPSBtY2h1bms7Cj4+ICAJCW1ieXRlcyAtPSBtY2h1bms7Cj4+ICAKPj4gIAkJ
Y29uZF9yZXNjaGVkKCk7Cj4+IEBAIC04NjYsMTEgKzg2OCwxOCBAQCBzdGF0aWMgaW50IGtpbWFn
ZV9sb2FkX2NyYXNoX3NlZ21lbnQoc3RydWN0IGtpbWFnZSAqaW1hZ2UsCj4+ICAJCQltZW1zZXQo
cHRyICsgdWNodW5rLCAwLCBtY2h1bmsgLSB1Y2h1bmspOwo+PiAgCQl9Cj4+ICAKPj4gLQkJLyog
Rm9yIGZpbGUgYmFzZWQga2V4ZWMsIHNvdXJjZSBwYWdlcyBhcmUgaW4ga2VybmVsIG1lbW9yeSAq
Lwo+PiAtCQlpZiAoaW1hZ2UtPmZpbGVfbW9kZSkKPj4gLQkJCW1lbWNweShwdHIsIGtidWYsIHVj
aHVuayk7Cj4+IC0JCWVsc2UKPj4gLQkJCXJlc3VsdCA9IGNvcHlfZnJvbV91c2VyKHB0ciwgYnVm
LCB1Y2h1bmspOwo+PiArCQlpZiAodWNodW5rKSB7Cj4+ICsJCQkvKiBGb3IgZmlsZSBiYXNlZCBr
ZXhlYywgc291cmNlIHBhZ2VzIGFyZSBpbiBrZXJuZWwgbWVtb3J5ICovCj4+ICsJCQlpZiAoaW1h
Z2UtPmZpbGVfbW9kZSkKPj4gKwkJCQltZW1jcHkocHRyLCBrYnVmLCB1Y2h1bmspOwo+PiArCQkJ
ZWxzZQo+PiArCQkJCXJlc3VsdCA9IGNvcHlfZnJvbV91c2VyKHB0ciwgYnVmLCB1Y2h1bmspOwo+
PiArCQkJdWJ5dGVzIC09IHVjaHVuazsKPj4gKwkJCWlmIChpbWFnZS0+ZmlsZV9tb2RlKQo+PiAr
CQkJCWtidWYgKz0gdWNodW5rOwo+PiArCQkJZWxzZQo+PiArCQkJCWJ1ZiArPSB1Y2h1bms7Cj4+
ICsJCX0KPj4gIAkJa2V4ZWNfZmx1c2hfaWNhY2hlX3BhZ2UocGFnZSk7Cj4+ICAJCWt1bm1hcF9s
b2NhbChwdHIpOwo+PiAgCQlhcmNoX2tleGVjX3ByZV9mcmVlX3BhZ2VzKHBhZ2VfYWRkcmVzcyhw
YWdlKSwgMSk7Cj4+IEBAIC04NzgsMTIgKzg4Nyw3IEBAIHN0YXRpYyBpbnQga2ltYWdlX2xvYWRf
Y3Jhc2hfc2VnbWVudChzdHJ1Y3Qga2ltYWdlICppbWFnZSwKPj4gIAkJCXJlc3VsdCA9IC1FRkFV
TFQ7Cj4+ICAJCQlnb3RvIG91dDsKPj4gIAkJfQo+PiAtCQl1Ynl0ZXMgLT0gdWNodW5rOwo+PiAg
CQltYWRkciAgKz0gbWNodW5rOwo+PiAtCQlpZiAoaW1hZ2UtPmZpbGVfbW9kZSkKPj4gLQkJCWti
dWYgKz0gbWNodW5rOwo+PiAtCQllbHNlCj4+IC0JCQlidWYgKz0gbWNodW5rOwo+PiAgCQltYnl0
ZXMgLT0gbWNodW5rOwo+PiAgCj4+ICAJCWNvbmRfcmVzY2hlZCgpOwo+PiAtLSAKPj4gMi4yNS4x
Cj4+IAo=

