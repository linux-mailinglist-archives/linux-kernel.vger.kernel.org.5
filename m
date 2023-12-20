Return-Path: <linux-kernel+bounces-6575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19AB819A88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573711F26869
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C651C6B8;
	Wed, 20 Dec 2023 08:32:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A121C686
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from dinghao.liu$zju.edu.cn ( [10.190.71.26] ) by
 ajax-webmail-mail-app3 (Coremail) ; Wed, 20 Dec 2023 15:52:43 +0800
 (GMT+08:00)
Date: Wed, 20 Dec 2023 15:52:43 +0800 (GMT+08:00)
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
In-Reply-To: <65822a6542ca1_277bd294f3@iweiny-mobl.notmuch>
References: <20231210085817.30161-1-dinghao.liu@zju.edu.cn>
 <657b9cb088175_27db80294d2@iweiny-mobl.notmuch>
 <657c82966e358_2947c22941a@iweiny-mobl.notmuch>
 <13ffb3fd.41cd7.18c7c3b52bf.Coremail.dinghao.liu@zju.edu.cn>
 <65822a6542ca1_277bd294f3@iweiny-mobl.notmuch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <62f848c1.48243.18c86366e76.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgBnb3NMnYJl5scwAQ--.36390W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0PBmWBaRd7cgABsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBkaW5naGFvLmxpdUAgd3JvdGU6Cj4gPiA+IElyYSBXZWlueSB3cm90ZToKPiA+ID4gPiBEaW5n
aGFvIExpdSB3cm90ZToKCltzbmlwXQoKPiA+ID4gPiAKPiA+ID4gPiBUaGlzIGRvZXMgbm90IHF1
aXRlIHdvcmsuCj4gPiA+ID4gCj4gPiA+ID4gZnJlZV9hcmVuYXMoKSBpcyB1c2VkIGluIHRoZSBl
cnJvciBwYXRocyBvZiBjcmVhdGVfYXJlbmFzKCkgYW5kCj4gPiA+ID4gZGlzY292ZXJfYXJlbmFz
KCkuICBJbiB0aG9zZSBjYXNlcyBkZXZtX2tmcmVlKCkgaXMgcHJvYmFibHkgYSBiZXR0ZXIgd2F5
Cj4gPiA+ID4gdG8gY2xlYW4gdXAgdGhpcy4KPiA+IAo+ID4gSGVyZSBJJ20gYSBsaXR0bGUgY29u
ZnVzZWQgYWJvdXQgd2hlbiBkZXZtX2tmcmVlKCkgc2hvdWxkIGJlIHVzZWQuCj4gCj4gT3ZlciBh
bGwgaXQgc2hvdWxkIGJlIHVzZWQgd2hlbmV2ZXIgbWVtb3J5IGlzIGFsbG9jYXRlZCBmb3IgdGhl
IGxpZmV0aW1lCj4gb2YgdGhlIGRldmljZS4KPiAKPiA+IENvZGUgaW4gYnR0X2luaXQoKSBpbXBs
aWVzIHRoYXQgcmVzb3VyY2VzIGFsbG9jYXRlZCBieSBkZXZtXyogY291bGQgYmUKPiA+IGF1dG8g
ZnJlZWQgaW4gYm90aCBlcnJvciBhbmQgc3VjY2VzcyBwYXRocyBvZiBwcm9iZS9hdHRhY2ggKGUu
Zy4sIGJ0dCAKPiA+IGFsbG9jYXRlZCBieSBkZXZtX2t6YWxsb2MgaXMgbmV2ZXIgZnJlZWQgYnkg
ZGV2bV9rZnJlZSkuCj4gPiBVc2luZyBkZXZtX2tmcmVlKCkgaW4gZnJlZV9hcmVuYXMoKSBpcyBv
ayBmb3IgbWUsIGJ1dCBJIHdhbnQgdG8ga25vdwo+ID4gd2hldGhlciBub3QgdXNpbmcgZGV2bV9r
ZnJlZSgpIGNvbnN0aXR1dGVzIGEgYnVnLgo+IAo+IFVuZm9ydHVuYXRlbHkgSSdtIG5vdCBmYW1p
bGlhciBlbm91Z2ggd2l0aCB0aGlzIGNvZGUgdG8ga25vdyBmb3Igc3VyZS4KPiAKPiBBZnRlciBt
eSBxdWljayBjaGVja3MgYmVmb3JlIEkgdGhvdWdodCBpdCB3YXMuICBCdXQgZWFjaCB0aW1lIEkg
bG9vayBhdCBpdAo+IEkgZ2V0IGNvbmZ1c2VkLiAgVGhpcyBpcyB3aHkgSSB3YXMgdGhpbmtpbmcg
bWF5YmUgbm90IHVzaW5nIGRldm1fKigpIGFuZAo+IHVzaW5nIG5vX2ZyZWVfcHRyKCkgbWF5IGJl
IGEgYmV0dGVyIHNvbHV0aW9uIHRvIG1ha2Ugc3VyZSB0aGluZ3MgZG9uJ3QKPiBsZWFrIHdpdGhv
dXQgY2hhbmdpbmcgdGhlIHN1Y2Nlc3MgcGF0aCAod2hpY2ggaXMgbGlrZWx5IHdvcmtpbmcgZmlu
ZQo+IGJlY2F1c2Ugbm8gYnVncyBoYXZlIGJlZW4gZm91bmQuKQoKV2UgaGF2ZSB0aGUgc2FtZSBj
b25mdXNpb24gaGVyZS4uLiBJIGZpbmQgYSBkaXNjdXNzaW9uIGFib3V0IHRoaXMgcHJvYmxlbSwK
d2hpY2ggaW1wbGllcyB0aGF0IG5vdCB1c2luZyBkZXZtX2tmcmVlKCkgbWF5IGRlbGF5IHRoZSBy
ZWxlYXNlLCBidXQgdGhlIG1lbW9yeSB3aWxsIGJlIGZyZWVkIGxhdGVyIGFuZCBubyBtZW1vcnkg
aXMgbGVha2VkOgoKaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9saW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnL21zZzIwMDk1NjEuaHRtbAoKPiA+IAo+ID4gPiBXZSBtaWdodCB3YW50IHRv
IGxvb2sgYXQgdXNpbmcgbm9fZnJlZV9wdHIoKSBpbiB0aGlzIGNvZGUuICBTZWUgdGhpcwo+ID4g
PiBwYXRjaFsxXSBmb3IgYW4gZXhhbXBsZSBvZiBob3cgdG8gaW5oaWJpdCB0aGUgY2xlYW51cCBh
bmQgcGFzcyB0aGUKPiA+ID4gcG9pbnRlciBvbiB3aGVuIHRoZSBmdW5jdGlvbiBzdWNjZWVkcy4K
PiA+ID4gCj4gPiA+IFsxXQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTcwMjYx
NzkxOTE0LjE3MTQ2NTQuNjQ0NzY4MDI4NTM1NzU0NTYzOC5zdGdpdEBkd2lsbGlhMi14ZmguamYu
aW50ZWwuY29tLwo+ID4gPiAKPiA+ID4gSXJhCj4gPiAKPiA+IFRoYW5rcyBmb3IgdGhpcyBleGFt
cGxlLiBCdXQgaXQgc2VlbXMgdGhhdCBub19mcmVlX3B0cigpIGlzIHVzZWQgdG8KPiA+IGhhbmRs
ZSB0aGUgc2NvcGUgYmFzZWQgcmVzb3VyY2UgbWFuYWdlbWVudC4gQ2hhbmdlcyBpbiB0aGlzIHBh
dGNoIGRvZXMKPiA+IG5vdCBpbnRyb2R1Y2UgdGhpcyBmZWF0dXJlLiBEbyBJIHVuZGVyc3RhbmQg
dGhpcyBjb3JyZWN0bHk/Cj4gCj4gWW91IGRvIHVuZGVyc3RhbmQgYnV0IEkgd2FzIHRoaW5raW5n
IHRoYXQgcGVyaGFwcyB1c2luZyBub19mcmVlX3B0cigpCj4gcmF0aGVyIHRoYW4gZGV2bV8qKCkg
bWlnaHQgYmUgYW4gZWFzaWVyIHdheSB0byBmaXggdGhpcyBidWcgd2l0aG91dCB0cnlpbmcKPiB0
byBkZWNvZGUgdGhlIGxpZmV0aW1lIG9mIGV2ZXJ5dGhpbmcuCj4gCgpNeSBjb25jZXJuIGlzIHRo
YXQgbm9fZnJlZV9wdHIoKSBtYXkgbm90IGJlIGFibGUgdG8gY29tcGxldGVseSBmaXggYWxsCm1l
bWxlYWtzIGJlY2F1c2Ugc29tZSBvZiB0aGVtIGFyZSB0cmlnZ2VyZWQgaW4gKHBhcnQgb2YpIHN1
Y2Nlc3MgcGF0aHMgKGUuZy4sCndoZW4gYnR0X2ZyZWVsaXN0X2luaXQgc3VjY2VlZHMgYnV0IGJ0
dF9ydHRfaW5pdCBmYWlscywgZGlzY292ZXJfYXJlbmFzIHN0aWxsIG5lZWRzIHRvIGNsZWFuIHVw
IHRoZSBtZW1vcnkgYWxsb2NhdGVkIGluIGJ0dF9mcmVlbGlzdF9pbml0KS4KCkkgY2hlY2tlZCB0
aGUgZGVzaWduIG9mIG5vX2ZyZWVfcHRyKCksIGFuZCBpdCBzZWVtcyB0aGF0IGl0IHdpbGwgZ2Vu
ZXJhdGUKYSBuZXcgcG9pbnRlciBvbiBzdWNjZXNzIGFuZCB0aGUgbWVtb3J5IHN0aWxsIGxlYWtz
IGluIHRoZSBhYm92ZSBjYXNlLiAKVGhlcmVmb3JlLCBJIHRoaW5rIHVzaW5nIGRldm1fKigpIGlz
IHN0aWxsIHRoZSBiZXN0IHNvbHV0aW9uIGZvciB0aGlzIGJ1Zy4gCgpSZWdhcmRzLApEaW5naGFv


