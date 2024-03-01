Return-Path: <linux-kernel+bounces-88037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C386DC7C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784DA1C223B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ACF69976;
	Fri,  1 Mar 2024 07:55:07 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20B969970;
	Fri,  1 Mar 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279707; cv=none; b=Bah/cI7r/Ls3FKZ4l2xg0ENoUtMucGNSxV2j37dAwHjdfgxLe6oejFus7+oNe3M7UFnZaix7wl1T9r4eTfdZ538nhb2hYTB3TrYCME+xHs6C5fXK3iUwHc+zjHuDi49JGlzpRFB9CPz7GC9ey0kG720+jBKDC5Rueh30NKLSdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279707; c=relaxed/simple;
	bh=8NkpBVC+MabeDFH3e6ECmrbv+y6feqbj/r6iS6j6HI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aVljp4H0kxI+wZLFlvGqVvOApZFAQoiBLqJRZcknk6JqOemkm5CxY15m8C72ukchrfrcQUNWWwF52ZXIdS3/zbKsKHNYIhijIPDgi/H35wIT66TQXzOcm9BJnLglxYdrMxp5fryApamebYas+zgWo2Od16z1QGiW/VnU0heZAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from duoming$zju.edu.cn ( [106.117.76.127] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 1 Mar 2024 15:54:49 +0800
 (GMT+08:00)
Date: Fri, 1 Mar 2024 15:54:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Michal Simek" <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Subject: Re: [PATCH v3] clk: zynq: Prevent null pointer dereference caused
 by kmalloc failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <1aa8e326-2bec-4324-a767-29e34b0e103d@amd.com>
References: <20240301070336.13700-1-duoming@zju.edu.cn>
 <d9b6d49e-9485-4733-a2d6-615bcc8f6ef3@amd.com>
 <74fd8b9e.6331.18df8e68c36.Coremail.duoming@zju.edu.cn>
 <1aa8e326-2bec-4324-a767-29e34b0e103d@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3a25ab6d.6440.18df9023c49.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgB3dYXKieFlw+nBAQ--.35672W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMHAWXg0lMLXwAMsa
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

T24gRnJpLCAxIE1hciAyMDI0IDA4OjMwOjA1ICswMTAwIE1pY2hhbCBTaW1layB3cm90ZToKPiA+
Pj4gVGhlIGttYWxsb2MoKSBpbiB6eW5xX2Nsa19zZXR1cCgpIHdpbGwgcmV0dXJuIG51bGwgaWYg
dGhlCj4gPj4+IHBoeXNpY2FsIG1lbW9yeSBoYXMgcnVuIG91dC4gQXMgYSByZXN1bHQsIGlmIHdl
IHVzZSBzbnByaW50ZigpCj4gPj4+IHRvIHdyaXRlIGRhdGEgdG8gdGhlIG51bGwgYWRkcmVzcywg
dGhlIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZQo+ID4+PiBidWcgd2lsbCBoYXBwZW4uCj4gPj4+
Cj4gPj4+IFRoaXMgcGF0Y2ggdXNlcyBhIHN0YWNrIHZhcmlhYmxlIHRvIHJlcGxhY2UgdGhlIGtt
YWxsb2MoKS4KPiA+Pj4KPiA+Pj4gRml4ZXM6IDBlZTUyYjE1N2I4ZSAoImNsazogenlucTogQWRk
IGNsb2NrIGNvbnRyb2xsZXIgZHJpdmVyIikKPiA+Pj4gU2lnbmVkLW9mZi1ieTogRHVvbWluZyBa
aG91IDxkdW9taW5nQHpqdS5lZHUuY24+Cj4gPj4+IC0tLQo+ID4+PiBDaGFuZ2VzIGluIHYzOgo+
ID4+PiAgICAgLSBQdXQgc3RhY2sgdmFyaWFibGUgaW4gdGhlIGhlYWQgb2YgdGhlIGZ1bmN0aW9u
IGFuZCByZW1vdmUgdmFyaWFibGUgdG1wLgo+ID4+Pgo+ID4+PiAgICBkcml2ZXJzL2Nsay96eW5x
L2Nsa2MuYyB8IDcgKystLS0tLQo+ID4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQo+ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsv
enlucS9jbGtjLmMgYi9kcml2ZXJzL2Nsay96eW5xL2Nsa2MuYwo+ID4+PiBpbmRleCA3YmRlYWZm
MmJmZC4uNDU0Nzk2NTNjM2IgMTAwNjQ0Cj4gPj4+IC0tLSBhL2RyaXZlcnMvY2xrL3p5bnEvY2xr
Yy5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvY2xrL3p5bnEvY2xrYy5jCj4gPj4+IEBAIC0yMTUsNyAr
MjE1LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHp5bnFfY2xrX3NldHVwKHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnApCj4gPj4+ICAgIAlpbnQgaTsKPiA+Pj4gICAgCXUzMiB0bXA7Cj4gPj4+ICAgIAlp
bnQgcmV0Owo+ID4+PiAtCWNoYXIgKmNsa19uYW1lOwo+ID4+PiArCWNoYXIgY2xrX25hbWVbMTZd
Owo+ID4+PiAgICAJdW5zaWduZWQgaW50IGZjbGtfZW5hYmxlID0gMDsKPiA+Pj4gICAgCWNvbnN0
IGNoYXIgKmNsa19vdXRwdXRfbmFtZVtjbGtfbWF4XTsKPiA+Pj4gICAgCWNvbnN0IGNoYXIgKmNw
dV9wYXJlbnRzWzRdOwo+ID4+PiBAQCAtNDI2LDEyICs0MjYsMTAgQEAgc3RhdGljIHZvaWQgX19p
bml0IHp5bnFfY2xrX3NldHVwKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCj4gPj4+ICAgIAkJCSJn
ZW0xX2VtaW9fbXV4IiwgQ0xLX1NFVF9SQVRFX1BBUkVOVCwKPiA+Pj4gICAgCQkJU0xDUl9HRU0x
X0NMS19DVFJMLCAwLCAwLCAmZ2VtMWNsa19sb2NrKTsKPiA+Pj4gICAgCj4gPj4+IC0JdG1wID0g
c3RybGVuKCJtaW9fY2xrXzAweCIpOwo+ID4+PiAtCWNsa19uYW1lID0ga21hbGxvYyh0bXAsIEdG
UF9LRVJORUwpOwo+ID4+PiAgICAJZm9yIChpID0gMDsgaSA8IE5VTV9NSU9fUElOUzsgaSsrKSB7
Cj4gPj4+ICAgIAkJaW50IGlkeDsKPiA+Pj4gICAgCj4gPj4+IC0JCXNucHJpbnRmKGNsa19uYW1l
LCB0bXAsICJtaW9fY2xrXyUyLjJkIiwgaSk7Cj4gPj4+ICsJCXNucHJpbnRmKGNsa19uYW1lLCAx
NiwgIm1pb19jbGtfJTIuMmQiLCBpKTsKPiA+Pgo+ID4+IEkgd291bGQgcHJlZmVyIHRvIHVzZSBt
YWNyby9kZWZpbmUgaWYgdGhhdCB2YWx1ZXMgaGFzIHRvIG1hdGNoIGFuZCBoYXZlIGNvbm5lY3Rp
b24uCj4gPiAKPiA+IFRoZSBvcmlnaW4gY29kZSAiY2xrX25hbWUgPSBrbWFsbG9jKHRtcCwgR0ZQ
X0tFUk5FTCkiIGFsbG9jYXRlcyAxNiBieXRlcywgc28gSSBzZXQKPiA+IHRoZSBzaXplIG9mIHN0
YWNrIHZhcmlhYmxlIGNsa19uYW1lIHRvIDE2IGJ5dGVzLgo+ID4gCj4gPiBEbyB5b3UgdGhpbmsg
aWYgd2UgdXNlICIjZGVmaW5lIENMS19OQU1FX0xFTiAxNiIgaXMgYmV0dGVyPwo+IAo+IG5hbWUg
aXMgZmluZSBmb3IgbWUuIFdoYXQgbWFjcm8gZ2l2ZXMgeW91IGlzIHRoYXQgeW91IGtub3cgdGhh
dCBudW1iZXIgMTYgZnJvbSAKPiBhcnJheSBzaXplIGlzIHRoZSBzYW1lIG51bWJlciAxNiB3aGlj
aCB5b3UgYXJlIGNoZWNraW5nLgo+IEl0IGlzIGNsZWFyIGZyb20geW91ciBwYXRjaCBidXQgc29t
ZSB0aW1lIGZyb20gbm93IHNvbWVvbmUgY2FuIGNoYW5nZSBqdXN0IG9uZSAKPiBwYXJ0IG9mIGNv
ZGUgd2l0aG91dCBsb29raW5nIGF0IGNvbm5lY3Rpb24uCgpUaGFuayB5b3UgZm9yIHlvdXIgc3Vn
Z2VzdGlvbnMhIEkgd2lsbCB1c2UgIkNMS19OQU1FX0xFTiIgdG8gcmVwbGFjZSB0aGUgMTYuCgpC
ZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQ==

