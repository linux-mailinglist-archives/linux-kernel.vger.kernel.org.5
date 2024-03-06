Return-Path: <linux-kernel+bounces-94026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C732387389A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836C428360C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D561132468;
	Wed,  6 Mar 2024 14:11:49 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CBB131744;
	Wed,  6 Mar 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734308; cv=none; b=fbPl142g+ClxqC/2P0QqPQ7O9X9MCd/q99PFlJr/FfKpDwqRjtU6mC64t9cb1nz7jfYIfmC299YBnBPWs+KXB1qKgMAZr2asvnjbxlz/7cOiahN1QjiaDureA30YjjAU9xfBE9h4plzx8d9/IXFK7uRTAci9J/03oQbx4myJSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734308; c=relaxed/simple;
	bh=fZVgHUnYdsFxM3B1qJGTGRghmDpQj6Xe/Q2Ec5t6OfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=VeNKN5HArV8VsUweYgp7szpadp3P8GG/ZmkuK3IhMlBY2n1Bn+gDzNLBdtcUpoiHKL3N6rufSJjZ43fRLxo2ucIUboNacVbP22q72MquPlGMWRKpvPz5OivI92ct6G3EMVkmin08rbD8OXnALuiGV/FiCD5h2HK4W6GDaX3+TSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from duoming$zju.edu.cn ( [106.117.76.127] ) by
 ajax-webmail-mail-app2 (Coremail) ; Wed, 6 Mar 2024 22:11:21 +0800
 (GMT+08:00)
Date: Wed, 6 Mar 2024 22:11:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Arend van Spriel" <arend.vanspriel@broadcom.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Kalle Valo" <kvalo@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Konrad Dybcio" <konrad.dybcio@linaro.org>,
	"Hans de Goede" <hdegoede@redhat.com>, minipli@grsecurity.net,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] wifi: brcmfmac: pcie: handle randbuf allocation failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <29de0b03-f65b-4918-ab5b-28dfd1c16a5d@broadcom.com>
References: <20240301135134.29577-1-duoming@zju.edu.cn>
 <fdaefac9-1d02-4424-b893-4306b97028ca@broadcom.com>
 <87h6hjhbqy.fsf@kernel.org>
 <3d433b58-384f-452e-904d-62e23b3b5a0b@app.fastmail.com>
 <29de0b03-f65b-4918-ab5b-28dfd1c16a5d@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <224867b0.cdd3.18e141ac13c.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgBnja2JeehlSFzNAg--.50707W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQMAWXnadMaowAAsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

T24gV2VkLCA2IE1hciAyMDI0IDEzOjUzOjE5ICswMTAwIEFyZW5kIHZhbiBTcHJpZWwgd3JvdGU6
Cj4gPj4+PiBUaGUga3phbGxvYygpIGluIGJyY21mX3BjaWVfZG93bmxvYWRfZndfbnZyYW0oKSB3
aWxsIHJldHVybgo+ID4+Pj4gbnVsbCBpZiB0aGUgcGh5c2ljYWwgbWVtb3J5IGhhcyBydW4gb3V0
LiBBcyBhIHJlc3VsdCwgaWYgd2UKPiA+Pj4+IHVzZSBnZXRfcmFuZG9tX2J5dGVzKCkgdG8gZ2Vu
ZXJhdGUgcmFuZG9tIGJ5dGVzIGluIHRoZSByYW5kYnVmLAo+ID4+Pj4gdGhlIG51bGwgcG9pbnRl
ciBkZXJlZmVyZW5jZSBidWcgd2lsbCBoYXBwZW4uCj4gPj4+PiBSZXR1cm4gLUVOT01FTSBmcm9t
IGJyY21mX3BjaWVfZG93bmxvYWRfZndfbnZyYW0oKSBpZiBremFsbG9jKCkKPiA+Pj4+IGZhaWxz
IGZvciByYW5kYnVmLgo+ID4+Pj4gRml4ZXM6IDkxOTE4Y2U4OGQ5ZiAoIndpZmk6IGJyY21mbWFj
OiBwY2llOiBQcm92aWRlIGEgYnVmZmVyIG9mCj4gPj4+PiByYW5kb20gYnl0ZXMgdG8gdGhlIGRl
dmljZSIpCj4gPj4+Cj4gPj4+IExvb2tzIGdvb2QgdG8gbWUuIExvb2tpbmcgZm9yIGtlcm5lbCBn
dWlkZWxpbmUgYWJvdXQgc3RhY2sgdXNhZ2UgdG8KPiA+Pj4gZGV0ZXJtaW5lIHdoZXRoZXIgaXQg
d291bGQgYmUgb2sgdG8ganVzdCB1c2UgYnVmZmVyIG9uIHN0YWNrLiBEb2VzCj4gPj4+IGFueW9u
ZSBrbm93LiBUaGlzIG9uZSBpcyAyNTYgYnl0ZXMgc28gSSBndWVzcyB0aGUgYWxsb2NhdGlvbiBp
cwo+ID4+PiB3YXJyYW50ZWQgaGVyZS4KPiA+Pgo+ID4+IEFybmQsIHdoYXQgZG8geW91IHN1Z2dl
c3Q/IERvIHdlIGhhdmUgYW55IGRvY3VtZW50YXRpb24gb3IgZ3VpZGVsaW5lcwo+ID4+IGFueXdo
ZXJlPwo+ID4gCj4gPiBJIGRvbid0IHRoaW5rIHdlIGhhdmUgYW55dGhpbmcgZG9jdW1lbnQgYWJv
dXQgdGhpcy4gSSB1c3VhbGx5Cj4gPiBjb25zaWRlciBhbnl0aGluZyBtb3JlIHRoYW4gaGFsZiBh
IGtpbG9ieXRlIGFzIGV4Y2Vzc2l2ZSwKPiA+IGV2ZW4gdGhvdWdoIHRoZSB3YXJuaW5nIGxpbWl0
IGlzIGhpZ2hlci4KPiA+IAo+ID4gMjU2IGJ5dGVzIGlzIHVzdWFsbHkgZmluZSwgYnV0IGluIHRo
aXMgY2FzZSBJIHdvdWxkIHNwbGl0IG91dAo+ID4gdGhlIGJhc2ljIGJsb2NrIHRoYXQgZG9lcyB0
aGlzIGludG8gYSBzZXBhcmF0ZSBmdW5jdGlvbgo+ID4gc28gaXQgZG9lcyBub3Qgc2hhcmUgdGhl
IHN0YWNrIGZyYW1lIHdpdGggb3RoZXIgbGVhZiBmdW5jdGlvbnMKPiA+IGJlbG93IGJyY21mX3Bj
aWVfZG93bmxvYWRfZndfbnZyYW0oKS4gSXQgbWlnaHQgYWxzbyBiZSBqdXN0aWZpZWQKPiA+IHRv
IHRoZW4gbWFyayBpdCBhcyBub2lubGluZV9mb3Jfc3RhY2suCj4gCj4gVGhhbmtzLCBBcm5kCj4g
Cj4gTWFrZXMgc2Vuc2UuCj4gCj4gQER1b21pbmcgWmhvdSwKPiAKPiBDYW4geW91IHByb3ZpZGUg
YSB2MiB3aXRoIHNlcGFyYXRlIGZ1bmN0aW9uIHVzaW5nIGJ1ZmZlciBvbiBzdGFjaz8KPiAKPiBz
dGF0aWMgbm9pbmxpbmVfZm9yX3N0YWNrCj4gdm9pZCBicmNtZl9wY2llX3Byb3ZpZGVfcmFuZG9t
X2J5dGVzKHN0cnVjdCBicmNtZl9wY2llZGV2X2luZm8gKmRldmluZm8sIAo+IHUzMiBhZGRyZXNz
KQo+IHsKPiAJdTggcmFuZGJ1ZltCUkNNRl9SQU5ET01fU0VFRF9MRU5HVEhdOwo+IAk6Cj4gCToK
PiB9CgpUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbnMsIEkgaGF2ZSBhbHJlYWR5IHByb3Zp
ZGVkIGEgdjIuCgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQo=

