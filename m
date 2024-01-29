Return-Path: <linux-kernel+bounces-42410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35AF8400FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2E22813DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964E54F93;
	Mon, 29 Jan 2024 09:10:45 +0000 (UTC)
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CC6110;
	Mon, 29 Jan 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.164.42.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519445; cv=none; b=czrmBOJPS9j//8E1WeU24NzYg9m5IT8pe4XXQ5AMD5c4Nrg+hQGiRsWgNkUCFHX4MlBW3arLKjqYQWdaPLix0ahgOZIJWbdljblUhm8w2v9ykFIuTubrYLsneYemNgO6FfVeznjolLT4U9R6JNzmus1rc8Td9EKQ+gk7ybQUN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519445; c=relaxed/simple;
	bh=5Gll6eNB7+3f5/28hX5K6oQLbYOQWak+KEzb8f3P1zM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=uYWrSTSuYz/fsxiwh/M98z3yCo0rEP1UlsKqgMK4CdWuSh/dxodlB3crJUPIQrarnRRYU8vH+kb9pmNe7hB4swXMibP4fk9UmpcnLcRovHX35Pvh5a0iNwXIZqNtR7EGtR99GJnT/8P9GW4Mu6wvCHVfwdVs6y26xb6OBsoOnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=61.164.42.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.77.58] ) by
 ajax-webmail-mail-app4 (Coremail) ; Mon, 29 Jan 2024 17:02:08 +0800
 (GMT+08:00)
Date: Mon, 29 Jan 2024 17:02:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Eric Dumazet" <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	"David Ahern" <dsahern@kernel.org>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: fix a memleak in ip_setup_cork
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <CANn89i+3Maf90HUzaGzFQgw9UQDoZLP-Ob+KrE9Ns6jND=6D9w@mail.gmail.com>
References: <20240126075127.2825068-1-alexious@zju.edu.cn>
 <CANn89iKvoZLHGbptM-9Q_m826Ae4PF9UTjuj6UMFsthZmEUjiw@mail.gmail.com>
 <CANn89i+3Maf90HUzaGzFQgw9UQDoZLP-Ob+KrE9Ns6jND=6D9w@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5a97396e.1e36.18d54745ad4.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3k4KQabdlLAHCAA--.15073W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAg0NAGWz-WMU2QAJsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBPbiBGcmksIEphbiAyNiwgMjAyNCBhdCAxMToxM+KAr0FNIEVyaWMgRHVtYXpldCA8ZWR1bWF6
ZXRAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBKYW4gMjYsIDIwMjQgYXQgODo1
MeKAr0FNIFpoaXBlbmcgTHUgPGFsZXhpb3VzQHpqdS5lZHUuY24+IHdyb3RlOgo+ID4gPgo+ID4g
PiBXaGVuIGluZXRkZXZfdmFsaWRfbXR1IGZhaWxzLCBjb3JrLT5vcHQgc2hvdWxkIGJlIGZyZWVk
IGlmIGl0IGlzCj4gPiA+IGFsbG9jYXRlZCBpbiBpcF9zZXR1cF9jb3JrLiBPdGhlcndpc2UgdGhl
cmUgY291bGQgYmUgYSBtZW1sZWFrLgo+ID4gPgo+ID4gPiBGaXhlczogNTAxYTkwYzk0NTEwICgi
aW5ldDogcHJvdGVjdCBhZ2FpbnN0IHRvbyBzbWFsbCBtdHUgdmFsdWVzLiIpCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFpoaXBlbmcgTHUgPGFsZXhpb3VzQHpqdS5lZHUuY24+Cj4gPiA+IC0tLQo+ID4g
PiAgbmV0L2lwdjQvaXBfb3V0cHV0LmMgfCA5ICsrKysrKysrLQo+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0
IGEvbmV0L2lwdjQvaXBfb3V0cHV0LmMgYi9uZXQvaXB2NC9pcF9vdXRwdXQuYwo+ID4gPiBpbmRl
eCBiMDZmNjc4YjAzYTEuLjMyMTVlYTA3ZDM5OCAxMDA2NDQKPiA+ID4gLS0tIGEvbmV0L2lwdjQv
aXBfb3V0cHV0LmMKPiA+ID4gKysrIGIvbmV0L2lwdjQvaXBfb3V0cHV0LmMKPiA+ID4gQEAgLTEy
ODIsNiArMTI4Miw3IEBAIHN0YXRpYyBpbnQgaXBfc2V0dXBfY29yayhzdHJ1Y3Qgc29jayAqc2ss
IHN0cnVjdCBpbmV0X2NvcmsgKmNvcmssCj4gPiA+ICB7Cj4gPiA+ICAgICAgICAgc3RydWN0IGlw
X29wdGlvbnNfcmN1ICpvcHQ7Cj4gPiA+ICAgICAgICAgc3RydWN0IHJ0YWJsZSAqcnQ7Cj4gPiA+
ICsgICAgICAgaW50IGZyZWVfb3B0ID0gMDsKPiA+ID4KPiA+ID4gICAgICAgICBydCA9ICpydHA7
Cj4gPiA+ICAgICAgICAgaWYgKHVubGlrZWx5KCFydCkpCj4gPiA+IEBAIC0xMjk3LDYgKzEyOTgs
NyBAQCBzdGF0aWMgaW50IGlwX3NldHVwX2Nvcmsoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QgaW5l
dF9jb3JrICpjb3JrLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNrLT5za19hbGxvY2F0aW9uKTsKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKHVubGlrZWx5KCFjb3JrLT5vcHQpKQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PQlVGUzsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZnJl
ZV9vcHQgPSAxOwo+ID4gPiAgICAgICAgICAgICAgICAgfQo+ID4gPiAgICAgICAgICAgICAgICAg
bWVtY3B5KGNvcmstPm9wdCwgJm9wdC0+b3B0LCBzaXplb2Yoc3RydWN0IGlwX29wdGlvbnMpICsg
b3B0LT5vcHQub3B0bGVuKTsKPiA+ID4gICAgICAgICAgICAgICAgIGNvcmstPmZsYWdzIHw9IElQ
Q09SS19PUFQ7Cj4gPiA+IEBAIC0xMzA2LDggKzEzMDgsMTMgQEAgc3RhdGljIGludCBpcF9zZXR1
cF9jb3JrKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IGluZXRfY29yayAqY29yaywKPiA+ID4gICAg
ICAgICBjb3JrLT5mcmFnc2l6ZSA9IGlwX3NrX3VzZV9wbXR1KHNrKSA/Cj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBkc3RfbXR1KCZydC0+ZHN0KSA6IFJFQURfT05DRShydC0+ZHN0LmRl
di0+bXR1KTsKPiA+ID4KPiA+ID4gLSAgICAgICBpZiAoIWluZXRkZXZfdmFsaWRfbXR1KGNvcmst
PmZyYWdzaXplKSkKPiA+ID4gKyAgICAgICBpZiAoIWluZXRkZXZfdmFsaWRfbXR1KGNvcmstPmZy
YWdzaXplKSkgewo+ID4gPiArICAgICAgICAgICAgICAgaWYgKG9wdCAmJiBmcmVlX29wdCkgewo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShjb3JrLT5vcHQpOwo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBjb3JrLT5vcHQgPSBOVUxMOwo+ID4gPiArICAgICAgICAgICAg
ICAgfQo+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTkVUVU5SRUFDSDsKPiA+ID4gKyAg
ICAgICB9Cj4gPiA+Cj4gPiA+ICAgICAgICAgY29yay0+Z3NvX3NpemUgPSBpcGMtPmdzb19zaXpl
Owo+ID4gPgo+ID4gPiAtLQo+ID4gPiAyLjM0LjEKPiA+ID4KPiA+Cj4gPiBXaGF0IGFib3V0IHNv
bWV0aGluZyBzaW1wbGVyIGxpa2UgOgo+ID4KPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC9pcF9v
dXRwdXQuYyBiL25ldC9pcHY0L2lwX291dHB1dC5jCj4gPiBpbmRleCBiMDZmNjc4YjAzYTE5Yjgw
NmZkMTQ3NjRhNGNhYWQ2MGNhZjAyOTE5Li40MTUzN2QxOGVlY2ZkNmUxMTYzYWFjYzM1ZTA0N2My
MjQ2OGUwNGU2Cj4gPiAxMDA2NDQKPiA+IC0tLSBhL25ldC9pcHY0L2lwX291dHB1dC5jCj4gPiAr
KysgYi9uZXQvaXB2NC9pcF9vdXRwdXQuYwo+ID4gQEAgLTEyODcsNiArMTI4NywxMiBAQCBzdGF0
aWMgaW50IGlwX3NldHVwX2Nvcmsoc3RydWN0IHNvY2sgKnNrLAo+ID4gc3RydWN0IGluZXRfY29y
ayAqY29yaywKPiA+ICAgICAgICAgaWYgKHVubGlrZWx5KCFydCkpCj4gPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FRkFVTFQ7Cj4gPgo+ID4gKyAgICAgICBjb3JrLT5mcmFnc2l6ZSA9IGlwX3Nr
X3VzZV9wbXR1KHNrKSA/Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgZHN0X210dSgmcnQt
PmRzdCkgOiBSRUFEX09OQ0UocnQtPmRzdC5kZXYtPm10dSk7Cj4gPiArCj4gPiArICAgICAgIGlm
ICghaW5ldGRldl92YWxpZF9tdHUoY29yay0+ZnJhZ3NpemUpKQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiAtRU5FVFVOUkVBQ0g7Cj4gPiArCj4gPiAgICAgICAgIC8qCj4gPiAgICAgICAgICAq
IHNldHVwIGZvciBjb3JraW5nLgo+ID4gICAgICAgICAgKi8KPiA+IEBAIC0xMzAzLDEyICsxMzA5
LDYgQEAgc3RhdGljIGludCBpcF9zZXR1cF9jb3JrKHN0cnVjdCBzb2NrICpzaywKPiA+IHN0cnVj
dCBpbmV0X2NvcmsgKmNvcmssCj4gPiAgICAgICAgICAgICAgICAgY29yay0+YWRkciA9IGlwYy0+
YWRkcjsKPiA+ICAgICAgICAgfQo+ID4KPiA+IC0gICAgICAgY29yay0+ZnJhZ3NpemUgPSBpcF9z
a191c2VfcG10dShzaykgPwo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIGRzdF9tdHUoJnJ0
LT5kc3QpIDogUkVBRF9PTkNFKHJ0LT5kc3QuZGV2LT5tdHUpOwo+ID4gLQo+ID4gLSAgICAgICBp
ZiAoIWluZXRkZXZfdmFsaWRfbXR1KGNvcmstPmZyYWdzaXplKSkKPiA+IC0gICAgICAgICAgICAg
ICByZXR1cm4gLUVORVRVTlJFQUNIOwo+ID4gLQo+ID4gICAgICAgICBjb3JrLT5nc29fc2l6ZSA9
IGlwYy0+Z3NvX3NpemU7Cj4gPgo+ID4gICAgICAgICBjb3JrLT5kc3QgPSAmcnQtPmRzdDsKPiAK
PiBIaSBaaGlwZW5nIEx1Cj4gCj4gQ291bGQgeW91IHNlbmQgYSBWMiBvZmYgeW91ciBwYXRjaCA/
IEkgd2lsbCB0aGVuIGFkZCBhIFJldmlld2VkLWJ5Ogo+IHRhZywgdGhhbmtzICEKCkhpIEVyaWMK
U3VyZSwgSSdsbCBzb29uIHNlbmQgYSB2MiB2ZXJzaW9uIGZvbGxvd2luZyB5b3VyIHN1Z2dlc3Rp
b24uCgo=

