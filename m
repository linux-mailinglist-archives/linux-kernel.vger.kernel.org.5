Return-Path: <linux-kernel+bounces-3241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57DA8169C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B7BB2141E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE889134B9;
	Mon, 18 Dec 2023 09:22:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385CC134A5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from dinghao.liu$zju.edu.cn ( [10.190.67.94] ) by
 ajax-webmail-mail-app3 (Coremail) ; Mon, 18 Dec 2023 17:21:51 +0800
 (GMT+08:00)
Date: Mon, 18 Dec 2023 17:21:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: dinghao.liu@zju.edu.cn
To: "Ira Weiny" <ira.weiny@intel.com>
Cc: "Dan Williams" <dan.j.williams@intel.com>, 
	"Vishal Verma" <vishal.l.verma@intel.com>, 
	"Dave Jiang" <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvdimm-btt: fix several memleaks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <657c82966e358_2947c22941a@iweiny-mobl.notmuch>
References: <20231210085817.30161-1-dinghao.liu@zju.edu.cn>
 <657b9cb088175_27db80294d2@iweiny-mobl.notmuch>
 <657c82966e358_2947c22941a@iweiny-mobl.notmuch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <13ffb3fd.41cd7.18c7c3b52bf.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgAHD3MvD4BldlAQAQ--.35919W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoNBmV+xhdFpgAAsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBJcmEgV2Vpbnkgd3JvdGU6Cj4gPiBEaW5naGFvIExpdSB3cm90ZToKPiAKPiBbc25pcF0KPiAK
PiAtc3RhdGljIGludCBidHRfZnJlZWxpc3RfaW5pdChzdHJ1Y3QgYXJlbmFfaW5mbyAqYXJlbmEp
Cj4gK3N0YXRpYyBpbnQgYnR0X2ZyZWVsaXN0X2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QgYXJlbmFfaW5mbyAqYXJlbmEpCj4gCj4gQm90aCBzdHJ1Y3QgYXJlbmFfaW5mbyBhbmQgc3Ry
dWN0IGJ0dCBjb250YWluIHJlZmVyZW5jZXMgdG8gc3RydWN0IG5kX2J0dAo+IHdoaWNoIGlzIHRo
ZSBkZXZpY2UgeW91IGFyZSBwYXNzaW5nIGRvd24gdGhpcyBjYWxsIHN0YWNrLgo+IAo+IEp1c3Qg
dXNlIHRoZSBkZXZpY2UgaW4gdGhlIGFyZW5hL2J0dCByYXRoZXIgdGhhbiBwYXNzaW5nIGEgZGV2
aWNlCj4gc3RydWN0dXJlLiAgVGhhdCBtYWtlcyB0aGUgY29kZSBlYXNpZXIgdG8gcmVhZCBhbmQg
ZW5zdXJlcyB0aGF0IHRoZSBkZXZpY2UKPiBhc3NvY2lhdGVkIHdpdGggdGhpcyBhcmVuYSBvciBi
dHQgaXMgdXNlZC4KClRoYW5rcyBmb3IgdGhpcyBzdWdnZXN0aW9uISBJIHdpbGwgZml4IHRoaXMg
aW4gdGhlIHYzIHBhdGNoLgoKPiBbc25pcF0KPiA+ID4gIAo+ID4gPiAtc3RhdGljIGludCBidHRf
bWFwbG9ja3NfaW5pdChzdHJ1Y3QgYXJlbmFfaW5mbyAqYXJlbmEpCj4gPiA+ICtzdGF0aWMgaW50
IGJ0dF9tYXBsb2Nrc19pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGFyZW5hX2luZm8g
KmFyZW5hKQo+ID4gPiAgewo+ID4gPiAgCXUzMiBpOwo+ID4gPiAgCj4gPiA+IC0JYXJlbmEtPm1h
cF9sb2NrcyA9IGtjYWxsb2MoYXJlbmEtPm5mcmVlLCBzaXplb2Yoc3RydWN0IGFsaWduZWRfbG9j
ayksCj4gPiA+ICsJYXJlbmEtPm1hcF9sb2NrcyA9IGRldm1fa2NhbGxvYyhkZXYsIGFyZW5hLT5u
ZnJlZSwgc2l6ZW9mKHN0cnVjdCBhbGlnbmVkX2xvY2spLAo+ID4gPiAgCQkJCUdGUF9LRVJORUwp
Owo+ID4gPiAgCWlmICghYXJlbmEtPm1hcF9sb2NrcykKPiA+ID4gIAkJcmV0dXJuIC1FTk9NRU07
Cj4gPiA+IEBAIC04MDUsOSArODA1LDYgQEAgc3RhdGljIHZvaWQgZnJlZV9hcmVuYXMoc3RydWN0
IGJ0dCAqYnR0KQo+ID4gPiAgCj4gPiA+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGFyZW5h
LCBuZXh0LCAmYnR0LT5hcmVuYV9saXN0LCBsaXN0KSB7Cj4gPiA+ICAJCWxpc3RfZGVsKCZhcmVu
YS0+bGlzdCk7Cj4gPiA+IC0JCWtmcmVlKGFyZW5hLT5ydHQpOwo+ID4gPiAtCQlrZnJlZShhcmVu
YS0+bWFwX2xvY2tzKTsKPiA+ID4gLQkJa2ZyZWUoYXJlbmEtPmZyZWVsaXN0KTsKPiA+IAo+ID4g
VGhpcyBkb2VzIG5vdCBxdWl0ZSB3b3JrLgo+ID4gCj4gPiBmcmVlX2FyZW5hcygpIGlzIHVzZWQg
aW4gdGhlIGVycm9yIHBhdGhzIG9mIGNyZWF0ZV9hcmVuYXMoKSBhbmQKPiA+IGRpc2NvdmVyX2Fy
ZW5hcygpLiAgSW4gdGhvc2UgY2FzZXMgZGV2bV9rZnJlZSgpIGlzIHByb2JhYmx5IGEgYmV0dGVy
IHdheQo+ID4gdG8gY2xlYW4gdXAgdGhpcy4KCkhlcmUgSSdtIGEgbGl0dGxlIGNvbmZ1c2VkIGFi
b3V0IHdoZW4gZGV2bV9rZnJlZSgpIHNob3VsZCBiZSB1c2VkLgpDb2RlIGluIGJ0dF9pbml0KCkg
aW1wbGllcyB0aGF0IHJlc291cmNlcyBhbGxvY2F0ZWQgYnkgZGV2bV8qIGNvdWxkIGJlCmF1dG8g
ZnJlZWQgaW4gYm90aCBlcnJvciBhbmQgc3VjY2VzcyBwYXRocyBvZiBwcm9iZS9hdHRhY2ggKGUu
Zy4sIGJ0dCAKYWxsb2NhdGVkIGJ5IGRldm1fa3phbGxvYyBpcyBuZXZlciBmcmVlZCBieSBkZXZt
X2tmcmVlKS4KVXNpbmcgZGV2bV9rZnJlZSgpIGluIGZyZWVfYXJlbmFzKCkgaXMgb2sgZm9yIG1l
LCBidXQgSSB3YW50IHRvIGtub3cKd2hldGhlciBub3QgdXNpbmcgZGV2bV9rZnJlZSgpIGNvbnN0
aXR1dGVzIGEgYnVnLgoKPiA+IAo+ID4gSG93ZXZlci4uLgo+ID4gCj4gPiA+ICAJCWRlYnVnZnNf
cmVtb3ZlX3JlY3Vyc2l2ZShhcmVuYS0+ZGVidWdmc19kaXIpOwo+ID4gPiAgCQlrZnJlZShhcmVu
YSk7Cj4gPiAKPiA+IFdoeSBjYW4ndCBhcmVuYSBiZSBhbGxvY2F0ZWQgd2l0aCBkZXZtXyo/Cj4g
PiAKPiA+IFdlIG5lZWQgdG8gY2hhbmdlIHRoaXMgdXAgYSBiaXQgbW9yZSB0byBoYW5kbGUgdGhl
IGVycm9yIHBhdGggdnMgcmVndWxhcgo+ID4gZGV2aWNlIHNodXRkb3duIGZyZWUgKGF1dG9tYXRp
YyBkZXZtIGZyZWVzKS4KPiAKCkF0IGZpcnN0LCBJIHRoaW5rIHRoZSB1c2Ugb2YgYXJlbmEgaXMg
Y29ycmVjdC4gVGhlcmVmb3JlLCBhbGxvY2F0aW5nIGFyZW5hCndpdGggZGV2bV8qIHNob3VsZCBi
ZSBhIGNvZGUgc3R5bGUgb3B0aW1pemF0aW9uLiBIb3dldmVyLCBJIHJlY2hlY2tlZCBkaXNjb3Zl
cl9hcmVuYXMgYW5kIGZvdW5kIGFyZW5hIG1pZ2h0IGFsc28gYmUgbGVha2VkIChlLmcuLCBpZiBh
bGxvY19hcmVuYSgpIGZhaWxzIGluIHRoZSBzZWNvbmQgbG9vcCwgdGhlIHByZXZpb3VzbHkgYWxs
b2NhdGVkIHJlc291cmNlcyBpbiB0aGUgbG9vcCBpcyBsZWFrZWQpLiBUaGUgY29ycmVjdCBjb2Rl
IGNvdWxkIGJlIGZvdW5kIGluIGNyZWF0ZV9hcmVuYXMoKSwgd2hlcmUgZnJlZV9hcmVuYXMgaXMg
Y2FsbGVkIG9uIGZhaWx1cmUgb2YgYWxsb2NfYXJlbmEoKS4KClRvIGZpeCB0aGlzIGlzc3VlLCBJ
IHRoaW5rIGl0J3MgYmV0dGVyIHRvIGNoYW5nZSB0aGUgJ2dvdG8gb3V0X3N1cGVyJyB0YWcKdG8g
J2dvdG8gb3V0Jy4gV2UgY291bGQgYWxzbyB1c2UgZGV2bV8qIGZvciBhcmVuYSB0byBzaW1wbGlm
eSB0aGUgZXJyb3IgcGF0aAppbiBkaXNjb3Zlcl9hcmVuYXMoKS4gCgo+IFdlIG1pZ2h0IHdhbnQg
dG8gbG9vayBhdCB1c2luZyBub19mcmVlX3B0cigpIGluIHRoaXMgY29kZS4gIFNlZSB0aGlzCj4g
cGF0Y2hbMV0gZm9yIGFuIGV4YW1wbGUgb2YgaG93IHRvIGluaGliaXQgdGhlIGNsZWFudXAgYW5k
IHBhc3MgdGhlIHBvaW50ZXIKPiBvbiB3aGVuIHRoZSBmdW5jdGlvbiBzdWNjZWVkcy4KPiAKPiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE3MDI2MTc5MTkxNC4xNzE0NjU0LjY0NDc2
ODAyODUzNTc1NDU2Mzguc3RnaXRAZHdpbGxpYTIteGZoLmpmLmludGVsLmNvbS8KPiAKPiBJcmEK
ClRoYW5rcyBmb3IgdGhpcyBleGFtcGxlLiBCdXQgaXQgc2VlbXMgdGhhdCBub19mcmVlX3B0cigp
IGlzIHVzZWQgdG8gaGFuZGxlCnRoZSBzY29wZSBiYXNlZCByZXNvdXJjZSBtYW5hZ2VtZW50LiBD
aGFuZ2VzIGluIHRoaXMgcGF0Y2ggZG9lcyBub3QgaW50cm9kdWNlCnRoaXMgZmVhdHVyZS4gRG8g
SSB1bmRlcnN0YW5kIHRoaXMgY29ycmVjdGx5PwoKUmVnYXJkcywKRGluZ2hhbwo=

