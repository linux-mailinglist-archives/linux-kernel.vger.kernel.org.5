Return-Path: <linux-kernel+bounces-80068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AA4862A6C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635A21F21647
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4976D125CC;
	Sun, 25 Feb 2024 13:12:57 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8CB79D3
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866776; cv=none; b=t1CnonBcMDou+BUnFrEJNaFbiCuEENv36N+yQz+oLmjtpS8Ikhh/Y9wxnDg1ZUXFbCgV33vWZwOYrPHOc/f5QbtoMnflmF2p79ZmstxWS5oqkWbaHwQ6k5KkSVJd8ZO+Wv5gakKxTVb4RoA4PDWQjaZ14FP8Mfqe9Dsqtvtx444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866776; c=relaxed/simple;
	bh=pv7W/DbqNjN8kHhj+3BlNysGTjdk4pEKt/ggevfzQ4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=e7kKeR5daPEXogCVYZudieu+er1H53hnxYjxBjvJWLDk0s1CAy4Mv8GrmVtiM46Z+P4MuVuoVdbn/tXxm2Zdnwp7PLWFOwGzlXF8hSBh/SEgQlTEGOpElk1E9kZZQ28BCMjMwu4jeYo/4cF3EX1X/TdUNpQCx8GC2JHU6Kc4fmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from duoming$zju.edu.cn ( [218.12.16.226] ) by
 ajax-webmail-mail-app2 (Coremail) ; Sun, 25 Feb 2024 21:12:29 +0800
 (GMT+08:00)
Date: Sun, 25 Feb 2024 21:12:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] ARM: mvebu: Prevent null pointer dereference caused by
 kzalloc failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZdsksQG/vMS0lWGq@shell.armlinux.org.uk>
References: <20240225060401.52768-1-duoming@zju.edu.cn>
 <ZdsksQG/vMS0lWGq@shell.armlinux.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7b00c2ef.133fb.18de065459c.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgAnaai+PNtlDSI0Ag--.35587W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwICAWXaOtIIuQAAsk
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

T24gU3VuLCAyNSBGZWIgMjAyNCAxMToyOTo1MyArMDAwMCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6Cj4gPiBUaGUga3phbGxvYygpIGluIGkyY19xdWlyaygpIHdpbGwgcmV0dXJuIG51bGwg
aWYgdGhlIHBoeXNpY2FsCj4gPiBtZW1vcnkgaGFzIHJ1biBvdXQuIEFzIGEgcmVzdWx0LCBpZiB3
ZSBkZXJlZmVyZW5jZSB0aGUgbmV3X2NvbXBhdAo+ID4gcG9pbnRlciwgdGhlIG51bGwgcG9pbnRl
ciBkZXJlZmVyZW5jZSBidWcgd2lsbCBoYXBwZW4uCj4gPiAKPiA+IFRoaXMgcGF0Y2ggYWRkcyBh
IGNoZWNrIHRvIGF2b2lkIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZS4KPiAKPiBZZXQgYWdhaW4g
YW5vdGhlciBqYW5pdG9yaWFsIHBhdGNoIHRoYXQgaXMgV2F5IHRvbyBmb2N1c2VkIG9uIGEgc2lu
Z2xlCj4gaXNzdWUsIHJhdGhlciB0aGFuIGFuYWx5c2luZyB0aGUgY29kZSBhbmQgcHJvcG9zaW5n
IHRoZSBiZXN0IGZpeC4gOigKPiAKPiBXaGF0IGlmIHRoZSB0d28ga3N0cmR1cCgpIGZhaWw/CgpU
aGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbnMsIEkgd2lsbCBhbHNvIGFkZCBhIGNoZWNrIHRv
IGp1ZGdlCndoZXRoZXIgdHdvIGtzdHJkdXAoKSBmYWlsLiBUaGUgZGV0YWlsIGlzIHNob3duIGJl
bG93OgoKQEAgLTEyNSwxMiArMTI1LDIwIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpMmNfcXVpcmso
dm9pZCkKICAgICAgICAgICAgICAgIHN0cnVjdCBwcm9wZXJ0eSAqbmV3X2NvbXBhdDsKCiAgICAg
ICAgICAgICAgICBuZXdfY29tcGF0ID0ga3phbGxvYyhzaXplb2YoKm5ld19jb21wYXQpLCBHRlBf
S0VSTkVMKTsKKyAgICAgICAgICAgICAgIGlmKCFuZXdfY29tcGF0KQorICAgICAgICAgICAgICAg
ICAgICAgICBjb250aW51ZTsKCiAgICAgICAgICAgICAgICBuZXdfY29tcGF0LT5uYW1lID0ga3N0
cmR1cCgiY29tcGF0aWJsZSIsIEdGUF9LRVJORUwpOwogICAgICAgICAgICAgICAgbmV3X2NvbXBh
dC0+bGVuZ3RoID0gc2l6ZW9mKCJtYXJ2ZWxsLG12NzgyMzAtYTAtaTJjIik7CiAgICAgICAgICAg
ICAgICBuZXdfY29tcGF0LT52YWx1ZSA9IGtzdHJkdXAoIm1hcnZlbGwsbXY3ODIzMC1hMC1pMmMi
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VS
TkVMKTsKCisgICAgICAgICAgICAgICBpZiAoIW5ld19jb21wYXQtPm5hbWUgfHwgIW5ld19jb21w
YXQtPnZhbHVlKSB7CisgICAgICAgICAgICAgICAgICAgICAgIGtmcmVlKG5ld19jb21wYXQtPm5h
bWUpOworICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShuZXdfY29tcGF0LT52YWx1ZSk7Cisg
ICAgICAgICAgICAgICAgICAgICAgIGtmcmVlKG5ld19jb21wYXQpOworICAgICAgICAgICAgICAg
ICAgICAgICBjb250aW51ZTsKKyAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIG9mX3Vw
ZGF0ZV9wcm9wZXJ0eShucCwgbmV3X2NvbXBhdCk7CiAgICAgICAgfQogfQoKQmVzdCByZWdhcmRz
LApEdW9taW5nIFpob3UK

