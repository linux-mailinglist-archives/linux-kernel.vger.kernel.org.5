Return-Path: <linux-kernel+bounces-88008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E086DC0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14EBB21C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953169957;
	Fri,  1 Mar 2024 07:24:52 +0000 (UTC)
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B369949;
	Fri,  1 Mar 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.164.42.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277892; cv=none; b=WS3O4n12rfnTBUQeUAI+FACspCrzc80Nzs/JN/ui4GBmKQd77MQRKO5VKelXiqDfvWoMh3axFGpCxhtLzBCoQRPROyElHq0y2Kjr0JowEQskavxzpJ2qKxV+qEUSKSlsT3iMCQ+NFnHUxGZ+kbfSXPQLvxyDiO50ONut9sms+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277892; c=relaxed/simple;
	bh=3tiuWlFSNFX6flPz1zUBIzEmuc0k31mmgh4aSeW1k3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Hu6GrD3Di6yA55vLVb/0eMGeUMKqizU4giRSt/nFvK5GsdKfqCntifurgkhKTRtOXO8jvAxnBBqBjed2ujbbeI69Lb8/EKAQX8kSZYfwF8V5myKDDKzpteNDfC17kupBTUqsyeFNz6K7mjQHV52/zMzPR8LbZZXZfj/ZYJ9Z+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=61.164.42.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from duoming$zju.edu.cn ( [106.117.76.127] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 1 Mar 2024 15:24:35 +0800
 (GMT+08:00)
Date: Fri, 1 Mar 2024 15:24:35 +0800 (GMT+08:00)
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
In-Reply-To: <d9b6d49e-9485-4733-a2d6-615bcc8f6ef3@amd.com>
References: <20240301070336.13700-1-duoming@zju.edu.cn>
 <d9b6d49e-9485-4733-a2d6-615bcc8f6ef3@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <74fd8b9e.6331.18df8e68c36.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgD3NIWzguFl08DBAQ--.36567W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQHAWXg0lMLLwACsj
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

T24gRnJpLCAxIE1hciAyMDI0IDA4OjA1OjE3ICswMTAwIE1pY2hhbCBTaW1layB3cm90ZToKPiA+
IFRoZSBrbWFsbG9jKCkgaW4genlucV9jbGtfc2V0dXAoKSB3aWxsIHJldHVybiBudWxsIGlmIHRo
ZQo+ID4gcGh5c2ljYWwgbWVtb3J5IGhhcyBydW4gb3V0LiBBcyBhIHJlc3VsdCwgaWYgd2UgdXNl
IHNucHJpbnRmKCkKPiA+IHRvIHdyaXRlIGRhdGEgdG8gdGhlIG51bGwgYWRkcmVzcywgdGhlIG51
bGwgcG9pbnRlciBkZXJlZmVyZW5jZQo+ID4gYnVnIHdpbGwgaGFwcGVuLgo+ID4gCj4gPiBUaGlz
IHBhdGNoIHVzZXMgYSBzdGFjayB2YXJpYWJsZSB0byByZXBsYWNlIHRoZSBrbWFsbG9jKCkuCj4g
PiAKPiA+IEZpeGVzOiAwZWU1MmIxNTdiOGUgKCJjbGs6IHp5bnE6IEFkZCBjbG9jayBjb250cm9s
bGVyIGRyaXZlciIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdAemp1
LmVkdS5jbj4KPiA+IC0tLQo+ID4gQ2hhbmdlcyBpbiB2MzoKPiA+ICAgIC0gUHV0IHN0YWNrIHZh
cmlhYmxlIGluIHRoZSBoZWFkIG9mIHRoZSBmdW5jdGlvbiBhbmQgcmVtb3ZlIHZhcmlhYmxlIHRt
cC4KPiA+IAo+ID4gICBkcml2ZXJzL2Nsay96eW5xL2Nsa2MuYyB8IDcgKystLS0tLQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvenlucS9jbGtjLmMgYi9kcml2ZXJzL2Nsay96eW5xL2Ns
a2MuYwo+ID4gaW5kZXggN2JkZWFmZjJiZmQuLjQ1NDc5NjUzYzNiIDEwMDY0NAo+ID4gLS0tIGEv
ZHJpdmVycy9jbGsvenlucS9jbGtjLmMKPiA+ICsrKyBiL2RyaXZlcnMvY2xrL3p5bnEvY2xrYy5j
Cj4gPiBAQCAtMjE1LDcgKzIxNSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB6eW5xX2Nsa19zZXR1
cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQo+ID4gICAJaW50IGk7Cj4gPiAgIAl1MzIgdG1wOwo+
ID4gICAJaW50IHJldDsKPiA+IC0JY2hhciAqY2xrX25hbWU7Cj4gPiArCWNoYXIgY2xrX25hbWVb
MTZdOwo+ID4gICAJdW5zaWduZWQgaW50IGZjbGtfZW5hYmxlID0gMDsKPiA+ICAgCWNvbnN0IGNo
YXIgKmNsa19vdXRwdXRfbmFtZVtjbGtfbWF4XTsKPiA+ICAgCWNvbnN0IGNoYXIgKmNwdV9wYXJl
bnRzWzRdOwo+ID4gQEAgLTQyNiwxMiArNDI2LDEwIEBAIHN0YXRpYyB2b2lkIF9faW5pdCB6eW5x
X2Nsa19zZXR1cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQo+ID4gICAJCQkiZ2VtMV9lbWlvX211
eCIsIENMS19TRVRfUkFURV9QQVJFTlQsCj4gPiAgIAkJCVNMQ1JfR0VNMV9DTEtfQ1RSTCwgMCwg
MCwgJmdlbTFjbGtfbG9jayk7Cj4gPiAgIAo+ID4gLQl0bXAgPSBzdHJsZW4oIm1pb19jbGtfMDB4
Iik7Cj4gPiAtCWNsa19uYW1lID0ga21hbGxvYyh0bXAsIEdGUF9LRVJORUwpOwo+ID4gICAJZm9y
IChpID0gMDsgaSA8IE5VTV9NSU9fUElOUzsgaSsrKSB7Cj4gPiAgIAkJaW50IGlkeDsKPiA+ICAg
Cj4gPiAtCQlzbnByaW50ZihjbGtfbmFtZSwgdG1wLCAibWlvX2Nsa18lMi4yZCIsIGkpOwo+ID4g
KwkJc25wcmludGYoY2xrX25hbWUsIDE2LCAibWlvX2Nsa18lMi4yZCIsIGkpOwo+IAo+IEkgd291
bGQgcHJlZmVyIHRvIHVzZSBtYWNyby9kZWZpbmUgaWYgdGhhdCB2YWx1ZXMgaGFzIHRvIG1hdGNo
IGFuZCBoYXZlIGNvbm5lY3Rpb24uCgpUaGUgb3JpZ2luIGNvZGUgImNsa19uYW1lID0ga21hbGxv
Yyh0bXAsIEdGUF9LRVJORUwpIiBhbGxvY2F0ZXMgMTYgYnl0ZXMsIHNvIEkgc2V0CnRoZSBzaXpl
IG9mIHN0YWNrIHZhcmlhYmxlIGNsa19uYW1lIHRvIDE2IGJ5dGVzLiAKCkRvIHlvdSB0aGluayBp
ZiB3ZSB1c2UgIiNkZWZpbmUgQ0xLX05BTUVfTEVOIDE2IiBpcyBiZXR0ZXI/CgpCZXN0IHJlZ2Fy
ZHMsCkR1b21pbmcgWmhvdQ==

