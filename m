Return-Path: <linux-kernel+bounces-86823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFDB86CB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4791C21AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333D4137742;
	Thu, 29 Feb 2024 14:16:51 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FF1369B1;
	Thu, 29 Feb 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216210; cv=none; b=lE+v5Dpmeyf7US7eStKerFq48JhDrRNEKAj5NzccCxeJ5oFNhm0zLB08Ner8tQ5emRleWn+R9+M3KBF3we23Bg1JJDiQd8peQwV6K+PEhP2U6eqVXXs2o3M5fzq7xjXrJ43xgPk8c0KTIxuo5HeZOD0vZX+6tDWrWWLjdyyoyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216210; c=relaxed/simple;
	bh=IiHMd0CdDYG2am8hQDdzVW//agDYXAOBur9FTHPc0Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=i/hjIDpitI2vkGqsDt/DmTNZ6a/+SB4oa4PSW/MPo+IHOIXHwPZOzYq5m0u9V2XhFYQtZzWMIwmb6Imy+go5LasfFqU/N4lj1/Geuwhbg5gNQTXow7U+orMeKlCR6ZRcm7m0b/xYXc/owyehzgKr/ZKymC3yiOuKeDHbfYYR+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from duoming$zju.edu.cn ( [218.12.19.137] ) by
 ajax-webmail-mail-app3 (Coremail) ; Thu, 29 Feb 2024 22:16:28 +0800
 (GMT+08:00)
Date: Thu, 29 Feb 2024 22:16:28 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Michal Simek" <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH v2] clk: zynq: Prevent null pointer dereference caused
 by kmalloc failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <2b274111-e65a-4b99-8f07-220324f1e214@amd.com>
References: <20240229122250.24786-1-duoming@zju.edu.cn>
 <2b274111-e65a-4b99-8f07-220324f1e214@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <365f9a90.55b0.18df5394935.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgC3nzu9keBl2cS2AQ--.42939W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQGAWXfgNMR9AAYsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

T24gVGh1LCAyOSBGZWIgMjAyNCAxMzo0NTo1NCArMDEwMCBNaWNoYWwgU2ltZWsgd3JvdGU6Cj4g
PiBUaGUga21hbGxvYygpIGluIHp5bnFfY2xrX3NldHVwKCkgd2lsbCByZXR1cm4gbnVsbCBpZiB0
aGUKPiA+IHBoeXNpY2FsIG1lbW9yeSBoYXMgcnVuIG91dC4gQXMgYSByZXN1bHQsIGlmIHdlIHVz
ZSBzbnByaW50Zgo+ID4gdG8gd3JpdGUgZGF0YSB0byB0aGUgbnVsbCBhZGRyZXNzLCB0aGUgbnVs
bCBwb2ludGVyIGRlcmVmZXJlbmNlCj4gPiBidWcgd2lsbCBoYXBwZW4uCj4gPiAKPiA+IFRoaXMg
cGF0Y2ggYWRkcyBhIHN0YWNrIHZhcmlhYmxlIHRvIHJlcGxhY2UgdGhlIGttYWxsb2MoKS4KPiA+
IAo+ID4gRml4ZXM6IDBlZTUyYjE1N2I4ZSAoImNsazogenlucTogQWRkIGNsb2NrIGNvbnRyb2xs
ZXIgZHJpdmVyIikKPiA+IFNpZ25lZC1vZmYtYnk6IER1b21pbmcgWmhvdSA8ZHVvbWluZ0B6anUu
ZWR1LmNuPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYyOgo+ID4gICAgLSBVc2Ugc3RhY2sgdmFy
aWFibGUgdG8gcmVwbGFjZSBrbWFsbG9jKCkuCj4gPiAKPiA+ICAgZHJpdmVycy9jbGsvenlucS9j
bGtjLmMgfCAzICstLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVs
ZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay96eW5xL2Nsa2MuYyBi
L2RyaXZlcnMvY2xrL3p5bnEvY2xrYy5jCj4gPiBpbmRleCA3YmRlYWZmMmJmZC4uZTRjNGM5YWRm
NzkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2Nsay96eW5xL2Nsa2MuYwo+ID4gKysrIGIvZHJp
dmVycy9jbGsvenlucS9jbGtjLmMKPiA+IEBAIC00MjcsNyArNDI3LDcgQEAgc3RhdGljIHZvaWQg
X19pbml0IHp5bnFfY2xrX3NldHVwKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCj4gPiAgIAkJCVNM
Q1JfR0VNMV9DTEtfQ1RSTCwgMCwgMCwgJmdlbTFjbGtfbG9jayk7Cj4gPiAgIAo+ID4gICAJdG1w
ID0gc3RybGVuKCJtaW9fY2xrXzAweCIpOwo+ID4gLQljbGtfbmFtZSA9IGttYWxsb2ModG1wLCBH
RlBfS0VSTkVMKTsKPiA+ICsJY2hhciBjbGtfbmFtZVt0bXBdOwo+IAo+IEkga25vdyB0aGF0IFN0
ZXBoZW4gYXNrZWQgZm9yIGl0IGJ1dCB2YXJpYWJsZSB3aXRoIHZhcmlhYmxlIGxlbmd0aCBpbiB0
aGUgbWlkZGxlIAo+IG9mIGNvZGUgZG9lc24ndCBsb29rIGdvb2Qgb3IgdXNlZnVsLgo+IEkgd291
bGQgYWxsb2NhdGUgcmF0aGVyIGJpZ2dlciBhcnJheSBvbiBzdGFjayB3aXRoIHNpemUgYmlnZ2Vy
IHRoYW4gbWF4IGxlbmd0aCAKPiB3aGljaCB3aWxsIHVzZSBpdC4KClRoZSBsZW5ndGggb2YgIm1p
b19jbGtfMDB4IiBpcyAxMSBieXRlcywgYW5kIHRoZSBrZXJuZWwgd2lsbCBhbGxvYyAxNiBieXRl
cyB0byBpdC4KSSB1c2UgYSBsb2NhbCB2YXJpYWJsZSB3aG9zZSBzaXplIGlzIDE2IGJ5dGVzIHRv
IHJlcGxhY2UgaXQuIFRoZSBkZXRhaWwgaXMgc2hvd24KYmVsb3c6CgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jbGsvenlucS9jbGtjLmMgYi9kcml2ZXJzL2Nsay96eW5xL2Nsa2MuYwppbmRleCA3YmRl
YWZmMmJmZC4uODFkNTMwZTMzNTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2xrL3p5bnEvY2xrYy5j
CisrKyBiL2RyaXZlcnMvY2xrL3p5bnEvY2xrYy5jCkBAIC0yMTUsNyArMjE1LDcgQEAgc3RhdGlj
IHZvaWQgX19pbml0IHp5bnFfY2xrX3NldHVwKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCiAgICAg
ICAgaW50IGk7CiAgICAgICAgdTMyIHRtcDsKICAgICAgICBpbnQgcmV0OwotICAgICAgIGNoYXIg
KmNsa19uYW1lOworICAgICAgIGNoYXIgY2xrX25hbWVbMTZdOwogICAgICAgIHVuc2lnbmVkIGlu
dCBmY2xrX2VuYWJsZSA9IDA7CiAgICAgICAgY29uc3QgY2hhciAqY2xrX291dHB1dF9uYW1lW2Ns
a19tYXhdOwogICAgICAgIGNvbnN0IGNoYXIgKmNwdV9wYXJlbnRzWzRdOwpAQCAtNDI3LDcgKzQy
Nyw2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB6eW5xX2Nsa19zZXR1cChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wKQogICAgICAgICAgICAgICAgICAgICAgICBTTENSX0dFTTFfQ0xLX0NUUkwsIDAsIDAs
ICZnZW0xY2xrX2xvY2spOwoKICAgICAgICB0bXAgPSBzdHJsZW4oIm1pb19jbGtfMDB4Iik7Ci0g
ICAgICAgY2xrX25hbWUgPSBrbWFsbG9jKHRtcCwgR0ZQX0tFUk5FTCk7CiAgICAgICAgZm9yIChp
ID0gMDsgaSA8IE5VTV9NSU9fUElOUzsgaSsrKSB7CiAgICAgICAgICAgICAgICBpbnQgaWR4OwoK
QEAgLTQzOSw3ICs0MzgsNiBAQCBzdGF0aWMgdm9pZCBfX2luaXQgenlucV9jbGtfc2V0dXAoc3Ry
dWN0IGRldmljZV9ub2RlICpucCkKICAgICAgICAgICAgICAgIGVsc2UKICAgICAgICAgICAgICAg
ICAgICAgICAgY2FuX21pb19tdXhfcGFyZW50c1tpXSA9IGR1bW15X25tOwogICAgICAgIH0KLSAg
ICAgICBrZnJlZShjbGtfbmFtZSk7CiAgICAgICAgY2xrX3JlZ2lzdGVyX211eChOVUxMLCAiY2Fu
X211eCIsIHBlcmlwaF9wYXJlbnRzLCA0LAogICAgICAgICAgICAgICAgICAgICAgICBDTEtfU0VU
X1JBVEVfTk9fUkVQQVJFTlQsIFNMQ1JfQ0FOX0NMS19DVFJMLCA0LCAyLCAwLAogICAgICAgICAg
ICAgICAgICAgICAgICAmY2FuY2xrX2xvY2spOwoKRG8geW91IHRoaW5rIHRoZSBhYm92ZSBpcyBi
ZXR0ZXI/CgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQ==

