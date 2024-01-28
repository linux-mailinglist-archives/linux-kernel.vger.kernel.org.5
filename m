Return-Path: <linux-kernel+bounces-41895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C5883F944
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757FC1C214B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0C31758;
	Sun, 28 Jan 2024 19:02:26 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42DE2E851
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706468546; cv=none; b=ZyC1qApSvh0Qt2x17VBw52EAWEZb8wdDl9jNmmdow84GmoVuWZj0LJ8vKriThyrFKF3Zb8MPrL+x6AH/UO/HmfREbiNQToFrdaj0l4yr2u3xTxa4f/Ro5cs4XYFk8xautHNi9gccAloQ7H0V6kbz/E/03iQwoilMfYU4OIEozSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706468546; c=relaxed/simple;
	bh=IFk7ohYCGkaEaZqGweUu5moUQWGrImMh+yZAuCDHdqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LH3Hy8pEhsqpmhU7H82jxwSWnHdBbRX3FA3+JmBmL9Q9grRDycRgx502l1a2NjX47XxcJ6PLaGzkqz1hHGsWFUVZHOjeD7xdCvN5TnYlmaz42aUW6ajXdkBRTeg0AZAqnnFM9+J3NxTag3g9/l/M66l9pcoeVO7yogOL6bJ61M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-204-vG2EihzvPXeJminPNiTDtQ-1; Sun, 28 Jan 2024 19:02:15 +0000
X-MC-Unique: vG2EihzvPXeJminPNiTDtQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 19:01:51 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 19:01:51 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent MAILHOL' <mailhol.vincent@wanadoo.fr>
CC: Finn Thain <fthain@linux-m68k.org>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Douglas Anderson
	<dianders@chromium.org>, Kees Cook <keescook@chromium.org>, Petr Mladek
	<pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Zhaoyang Huang
	<zhaoyang.huang@unisoc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Marco Elver <elver@google.com>, Brian Cain <bcain@quicinc.com>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Matthew Wilcox <willy@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>
Subject: RE: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
Thread-Topic: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
Thread-Index: AQHaUbL1xJNZnFSfqkuoXGWoPFOF8LDvIt6wgAAVO4CAAFsoEA==
Date: Sun, 28 Jan 2024 19:01:51 +0000
Message-ID: <3af455be023949649f4061223600250b@AcuMS.aculab.com>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr>
 <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org>
 <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com>
 <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com>
 <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNQUlMSE9MIA0KPiBTZW50OiAyOCBKYW51YXJ5IDIwMjQgMTM6MjgNCi4u
Lg0KPiBGYWlyLiBNeSBnb2FsIHdhcyBub3QgdG8gcG9pbnQgdG8gdGhlIGFzc2VtYmx5IGNvZGUg
YnV0IHRvIHRoaXMgc2VudGVuY2U6DQo+IA0KPiAgIEhvd2V2ZXIsIGZvciBub24gY29uc3RhbnQg
ZXhwcmVzc2lvbnMsIHRoZSBrZXJuZWwncyBmZnMoKSBhc20NCj4gICB2ZXJzaW9uIHJlbWFpbnMg
YmV0dGVyIGZvciB4ODZfNjQgYmVjYXVzZSwgY29udHJhcnkgdG8gR0NDLCBpdA0KPiAgIGRvZXNu
J3QgZW1pdCB0aGUgQ01PViBhc3NlbWJseSBpbnN0cnVjdGlvbg0KDQpUaGUgY29tbWVudCBpbiB0
aGUgY29kZSBpczoNCgkgKiBBTUQ2NCBzYXlzIEJTRkwgd29uJ3QgY2xvYmJlciB0aGUgZGVzdCBy
ZWcgaWYgeD09MDsgSW50ZWw2NCBzYXlzIHRoZQ0KCSAqIGRlc3QgcmVnIGlzIHVuZGVmaW5lZCBp
ZiB4PT0wLCBidXQgdGhlaXIgQ1BVIGFyY2hpdGVjdCBzYXlzIGl0cw0KCSAqIHZhbHVlIGlzIHdy
aXR0ZW4gdG8gc2V0IGl0IHRvIHRoZSBzYW1lIGFzIGJlZm9yZSwgZXhjZXB0IHRoYXQgdGhlDQoJ
ICogdG9wIDMyIGJpdHMgd2lsbCBiZSBjbGVhcmVkLg0KSSBndWVzcyBnY2MgaXNuJ3Qgd2lsbGlu
ZyB0byBhY3Qgb24gaGVhcnNheSENCg0KPiANCj4gSSBzaG91bGQgaGF2ZSBiZWVuIG1vcmUgY2xl
YXIuIFNvcnJ5IGZvciB0aGF0Lg0KPiANCj4gQnV0IHRoZSBmYWN0IHJlbWFpbnMsIG9uIHg4Niwg
c29tZSBvZiB0aGUgYXNtIHByb2R1Y2VkIG1vcmUgb3B0aW1pemVkDQo+IGNvZGUgdGhhbiB0aGUg
YnVpbHRpbi4NCj4gDQo+ID4gSSBhY3R1YWxseSBzdXNwZWN0IHRoZSBhc20gdmVyc2lvbnMgcHJl
ZGF0ZSB0aGUgYnVpbHRpbnMuDQo+IA0KPiBUaGlzIHNlZW1zIHRydWUuIFRoZSBfX2J1bHRpbnMg
d2VyZSBpbnRyb2R1Y2VkIGluOg0KPiANCj4gICBnZW5lcmljOiBJbXBsZW1lbnQgZ2VuZXJpYyBm
ZnMvZmxzIHVzaW5nIF9fYnVpbHRpbl8qIGZ1bmN0aW9ucw0KPiAgIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvdG9ydmFsZHMvYy8wNDhmYTJkZjkyYzMNCg0KSSB3YXMgdGhpbmtpbmcgb2YgY29tcGls
ZXIgdmVyc2lvbnMgbm90IGtlcm5lbCBzb3VyY2UgY29tbWl0cy4NCllvdSdkIG5lZWQgdG8gYmUg
ZG9pbmcgc29tZSBzZXJpb3VzIHNvZnR3YXJlIGFyY2hhZW9sb2d5Lg0KDQo+IHdoZW4gdGhlIGFz
bSBpbXBsZW1lbnRhdGlvbiBhbHJlYWR5IGV4aXN0ZWQgaW4gbTY4ay4NCj4gDQo+ID4gRG9lcyAo
b3IgY2FuKSB0aGUgb3V0ZXIgY29tbW9uIGhlYWRlciB1c2UgdGhlIF9fYnVpbHRpbiBmdW5jdGlv
bnMNCj4gPiBpZiBubyBhc20gdmVyc2lvbiBleGlzdHM/DQo+IA0KPiBZZXMsIHRoaXMgd291bGQg
YmUgZXh0cmVtZWx5IGVhc3kuIFlvdSBqdXN0IG5lZWQgdG8NCj4gDQo+ICAgI2luY2x1ZGUvYXNt
LWdlbmVyaWMvYml0b3BzL2J1aWx0aW4tX19mZnMuaA0KPiAgICNpbmNsdWRlL2FzbS1nZW5lcmlj
L2JpdG9wcy9idWlsdGluLWZmcy5oDQo+ICAgI2luY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2J1
aWx0aW4tX19mbHMuaA0KPiAgICNpbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9idWlsdGluLWZs
cy5oDQo+IA0KPiBhbmQgcmVtb3ZlIGFsbCB0aGUgYXNtIGltcGxlbWVudGF0aW9ucy4gSWYgeW91
IGdpdmUgbWUgeW91ciBncmVlbg0KPiBsaWdodCwgSSBjYW4gZG8gdGhhdCBjaGFuZ2UuIFRoaXMg
aXMgdHJpdmlhbC4gVGhlIG9ubHkgdGhpbmcgSSBhbSBub3QNCj4gcmVhZHkgdG8gZG8gaXMgdG8g
Y29tcGFyZSB0aGUgcHJvZHVjZWQgYXNzZW1ibHkgY29kZSBhbmQgY29uZmlybQ0KPiB3aGV0aGVy
IG9yIG5vdCBpdCBpcyBiZXR0ZXIgdG8gcmVtb3ZlIGFzbSBjb2RlLg0KPiANCj4gVGhvdWdodHM/
DQoNCk5vdCBmb3IgbWUgdG8gc2F5Lg0KQnV0IHRoZSBidWlsdGlucyBhcmUgbGlrZWx5IHRvIGdl
bmVyYXRlIHJlYXNvbmFibGUgY29kZS4NClNvIHVubGVzcyB0aGUgYXNtIGNhbiBiZSBiZXR0ZXIg
KGxpa2UgdHJ1c3RpbmcgdW5kb2N1bWVudGVkDQp4ODYgY3B1IGJlaGF2aW91cikgdXNpbmcgdGhl
bSBpcyBwcm9iYWJseSBiZXN0Lg0KDQpGb3IgdGhlIG9uZXMgeW91IGFyZSBjaGFuZ2luZyBpdCBt
YXkgYmUgYmVzdCB0byBwcm9wb3NlIHVzaW5nDQp0aGUgYnVpbHRpbnMgYWxsIHRoZSB0aW1lLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K


