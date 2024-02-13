Return-Path: <linux-kernel+bounces-63219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7EC852C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEE01C23253
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C2524C9;
	Tue, 13 Feb 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="I8mZAieM"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF66524AC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816842; cv=none; b=ZTdbZ6ogi7ROptb5200g+NEtoik+ElE0uNN5FdI2950CvqaOMuC/LhsgcFdHsGeE8L6L7ZIoQVYUjhNqRN902vzfAjoD2w4olX3Xt60HDu7J6sKxjYrwtovCDbydNl0JjPvahgONsGsW0lcAovToC+HQ76CJ87BZVvr57qHvf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816842; c=relaxed/simple;
	bh=B+c8KVXvNvRuWZmvPipE8IoHwkyQbC+AExwlSKHBmjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMCVZh7q1JXQZopbzVvq84487AUK69fs2LZOW8HLAHcj/WZuoDImX1QaV6eWeQTHl1xaWXQZ4/epqbu+RqObiuY6Nz/JWe+YCm4b9JxD/Y9bQx35utgmJuHJU1U7eniGgn6uInANqd9FdiPFOzxXc0iNtwqbhva7m8+cBytHrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=I8mZAieM; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 5635A5EEFD;
	Tue, 13 Feb 2024 12:33:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hXjareDRha60-V0PYmfUK;
	Tue, 13 Feb 2024 12:33:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1707816826; bh=B+c8KVXvNvRuWZmvPipE8IoHwkyQbC+AExwlSKHBmjM=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=I8mZAieMvchcH6xGOwzxI2nRWjy2ewahNmEGqPhnXAX6geaReX3g2fYehad1UJ1NN
	 6annbtVU6lpOxmDF/HpiS70zX23eIZqngCoAWMHysrL2tC7eRqztXUnQmQldpA5SvM
	 MAOvP0hY8FzZdPAZ18wOi5w4SBXTYOkZDoQtzKjs=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <99042a0e72b3d29bc4b582a42a70d667033e6331.camel@maquefel.me>
Subject: Re: [PATCH v7 08/39] soc: Add SoC driver for Cirrus ep93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: andy.shevchenko@gmail.com
Cc: Conor Dooley <conor.dooley@microchip.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Joel Stanley <joel@jms.id.au>, Linus Walleij
 <linus.walleij@linaro.org>, Wei Xu <xuwei5@hisilicon.com>, Huisong Li
 <lihuisong@huawei.com>, Walker Chen <walker.chen@starfivetech.com>,
 Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>, Arnd
 Bergmann <arnd@arndb.de>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2024 12:33:44 +0300
In-Reply-To: <Zb_A5H5kkxw1oiQv@surfacebook.localdomain>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
	 <20240118-ep93xx-v7-8-d953846ae771@maquefel.me>
	 <Zb_A5H5kkxw1oiQv@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gQW5keSEKCk9uIFN1biwgMjAyNC0wMi0wNCBhdCAxODo1MiArMDIwMCwgYW5keS5zaGV2
Y2hlbmtvQGdtYWlsLmNvbSB3cm90ZToKPiBUaHUsIEphbiAxOCwgMjAyNCBhdCAxMToyMDo1MUFN
ICswMzAwLCBOaWtpdGEgU2h1YmluIGtpcmpvaXR0aToKPiA+IEFkZCBhbiBTb0MgZHJpdmVyIGZv
ciB0aGUgZXA5M3h4LiBDdXJyZW50bHkgdGhlcmUgaXMgb25seSBvbmUgdGhpbmcKPiA+IG5vdCBm
aXR0aW5nIGludG8gYW55IG90aGVyIGZyYW1ld29yaywgYW5kIHRoYXQgaXMgdGhlIHN3bG9jawo+
ID4gc2V0dGluZy4KPiA+IAo+ID4gVXNlZCBmb3IgY2xvY2sgc2V0dGluZ3MsIHBpbmN0cmwgYW5k
IHJlc3RhcnQuCj4gCj4gLi4uCj4gCj4gPiArc3RhdGljIHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNl
ICplcDkzeHhfYWRldl9hbGxvYyhzdHJ1Y3QgZGV2aWNlCj4gPiAqcGFyZW50LCBjb25zdCBjaGFy
ICpuYW1lLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QKPiA+IGVwOTN4eF9tYXBfaW5mbyAqaW5mbykKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgZXA5M3h4X3JlZ21hcF9hZGV2ICpyZGV2Owo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXY7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgcmRldiA9IGt6YWxsb2Moc2l6ZW9mKCpyZGV2KSwgR0ZQX0tF
Uk5FTCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIXJkZXYpCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gCj4gVXNlIF9fZnJlZSgp
ID8KPiAoWW91IGFscmVhZHkgaW5jbHVkZWQgY2xlYW51cC5oIGZvciBvdGhlciBjYXNlcywgd2h5
IG5vdCB1c2luZyBpdAo+IGhlcmU/KQoKV2h5IHNob3VsZCBpIHdhbnQgdGhpcyA/IEkgZG9uJ3Qg
d2FudCByZGV2IGJlZWluZyBmcmVlZCBvbiBvdXQgb2Ygc2NvcGUKLSByZGV2IGlzIGZyZWVkIGlu
IGVwOTN4eF9hZGV2X3JlbGVhc2UoKS4KCkJ1dCB0aGFuayB5b3UsIGkndmUgbm90aWNlZCBhIGJ1
ZyAtIGkgc2hvdWxkIGZyZWUgcmRldiBhbmQgbm90IGFkZXYKYm90aCBpbiBlcDkzeHhfYWRldl9h
bGxvYygpIGFuZCBlcDkzeHhfYWRldl9yZWxlYXNlKCkuCgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
cmRldi0+bWFwID0gaW5mby0+bWFwOwo+ID4gK8KgwqDCoMKgwqDCoMKgcmRldi0+YmFzZSA9IGlu
Zm8tPmJhc2U7Cj4gPiArwqDCoMKgwqDCoMKgwqByZGV2LT5sb2NrID0gJmluZm8tPmxvY2s7Cj4g
PiArwqDCoMKgwqDCoMKgwqByZGV2LT53cml0ZSA9IGVwOTN4eF9yZWdtYXBfd3JpdGU7Cj4gPiAr
wqDCoMKgwqDCoMKgwqByZGV2LT51cGRhdGVfYml0cyA9IGVwOTN4eF9yZWdtYXBfdXBkYXRlX2Jp
dHM7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBhZGV2ID0gJnJkZXYtPmFkZXY7Cj4gPiArwqDC
oMKgwqDCoMKgwqBhZGV2LT5uYW1lID0gbmFtZTsKPiA+ICvCoMKgwqDCoMKgwqDCoGFkZXYtPmRl
di5wYXJlbnQgPSBwYXJlbnQ7Cj4gPiArwqDCoMKgwqDCoMKgwqBhZGV2LT5kZXYucmVsZWFzZSA9
IGVwOTN4eF9hZGV2X3JlbGVhc2U7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBhdXhp
bGlhcnlfZGV2aWNlX2luaXQoYWRldik7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga2ZyZWUoYWRldik7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIocmV0KTsKPiA+ICvCoMKgwqDC
oMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBhZGV2Owo+ID4gK30KPiAK
PiAuLi4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoG1vZGVsID0gKGVudW0KPiA+IGVwOTN4eF9zb2Nf
bW9kZWwpKHVpbnRwdHJfdClvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsKPiAKPiBJIGJl
bGlldmUgUm9iIHdhbnRzIHRvIGdldCByaWQgb2Ygb2ZfZGV2aWNlLmggb3IgYXQgbGVhc3Qgb2Yg
dGhpcwo+IGNhbGwgKHNlZSBoaXMKPiBwYXRjaGVzIHRvIGNvbnZlcnQgdGhpcyBBUEkgdG8gdXNl
IGRldmljZV9nZXRfbWF0Y2hfZGF0YSgpIGluc3RlYWQpLgo+IAoKTm90ZWQgLSB0aGFua3MgIQoK



