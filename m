Return-Path: <linux-kernel+bounces-152582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C228AC0C3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82E41C2088D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122663D0BE;
	Sun, 21 Apr 2024 18:27:42 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCF3B299
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713724061; cv=none; b=CybkFNbJ1M50PnZqCQBXAQ2mVFkzxePdedjLny7mBwEGnPzKM7IKNm2Gx9tUi9J3A3Yaw+eKONE++OAdFn8yrAvbLP21Rjf3GIwz2VWa+4wWDi6LXIiDZ7uQnYhfp1W51ahRgP5N8/bZ3MQDYxkZw/OVw55WUkRwV8rdnyOqIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713724061; c=relaxed/simple;
	bh=DrX/aOUpya+wdC6YAPycqP+a/l8gYMBC3Vp9aiMqsMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HY739Ldr9ROa8bSma1JJIjmc5Oh7FusdIuW5cjSCkLrzHN636lPLPXQTvDzAtkWsgw1M/beOsh7ZBQHJwwa8QpKUQ/0ZXN1CQnmqbPLAxrkw4PJYpz7Mwe7alO4wHlfeLNv+QCbE0mm6H9pHj9AkwS3NjOfNfqeFSCpvQsHYcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-kyIR6opLMWGTBd3F6Ox1sg-1; Sun, 21 Apr 2024 19:27:35 +0100
X-MC-Unique: kyIR6opLMWGTBd3F6Ox1sg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 21 Apr
 2024 19:27:01 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 21 Apr 2024 19:27:01 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mahesh Bandewar' <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
	Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Richard
 Cochran" <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "Sagi
 Maimon" <maimon.sagi@gmail.com>
CC: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	"Mahesh Bandewar" <mahesh@bandewar.net>
Subject: RE: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally in
 mono-raw base.
Thread-Topic: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
Thread-Index: AQHakUipE9fygZJ1Ok680rZNup1+trFzDfZA
Date: Sun, 21 Apr 2024 18:27:01 +0000
Message-ID: <163538a0495840eca34f6fbd09533ae1@AcuMS.aculab.com>
References: <20240418042706.1261473-1-maheshb@google.com>
In-Reply-To: <20240418042706.1261473-1-maheshb@google.com>
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

RnJvbTogTWFoZXNoIEJhbmRld2FyDQo+IFNlbnQ6IDE4IEFwcmlsIDIwMjQgMDU6MjcNCj4gDQo+
IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIFBUUF9TWVNfT0ZGU0VUX0VYVEVOREVEIHBy
b3ZpZGVzDQo+IFBIQyByZWFkcyBpbiB0aGUgZm9ybSBvZiBbcHJlLVRTLCBQSEMsIHBvc3QtVFNd
LiBUaGVzZSBwcmUgYW5kDQo+IHBvc3QgdGltZXN0YW1wcyBhcmUgdXNlZnVsIHRvIG1lYXN1cmUg
dGhlIHdpZHRoIG9mIHRoZSBQSEMgcmVhZC4NCj4gSG93ZXZlciwgdGhlIGN1cnJlbnQgaW1wbGVt
ZW50YXRpb24gcHJvdmlkZXMgdGhlc2UgdGltZXN0YW1wcyBpbg0KPiBDTE9DS19SRUFMVElNRSBv
bmx5LiBTaW5jZSBDTE9DS19SRUFMVElNRSBpcyBkaXNjaXBsaW5lZCBieSBOVFANCj4gb3IgTlRQ
LWxpa2Ugc2VydmljZShzKSwgdGhlIHZhbHVlIGlzIHN1YmplY3RlZCB0byBjaGFuZ2UuIFRoaXMN
Cj4gbWFrZXMgc29tZSBhcHBsaWNhdGlvbnMgdGhhdCBhcmUgdmVyeSBzZW5zaXRpdmUgdG8gdGlt
ZSBjaGFuZ2UNCj4gaGF2ZSB0aGVzZSB0aW1lc3RhbXBzIGRlbGl2ZXJlZCBpbiBkaWZmZXJlbnQg
dGltZS1iYXNlLg0KLi4uDQoNCklzbid0IHVzaW5nIENMT0NLX1JFQUxUSU1FIGp1c3QgYSBiaWcg
YnVnPw0KQXMgd2VsbCBhcyBtaW5vciAnY29ycmVjdGlvbnMnIGRvbmUgYnkgTlRQIGl0IHN1ZmZl
cnMgZnJvbQ0KbWFqb3IgdGltZS13YXJwcyB0aGF0IGNhbiBqdW1wIGluIGVpdGhlciBkaXJlY3Rp
b24gYnkgYXJiaXRyYXJ5IGFtb3VudHMuDQoNCklmIEkgdW5kZXJzdGFuZCB0aGUgaW50ZW50IG9m
IHRoZSBVQVBJLCBhIHBvc3NpYmx5IHNvbHV0aW9uIGlzDQp0byBnZXQgdGhlIG9mZnNldCBiZXR3
ZWVuIENMT0NLX1JFQUxUSU1FIGFuZCBDTE9DS19NT05BVE9OSUMgYW5kDQplbnN1cmUgdGhlIHNh
bWUgb2Zmc2V0IGlzIGFkZGVkIENMT0NLX01PTkFUT05JQyBmb3IgdGhlIHByZS0gYW5kDQpwb3N0
LSB0aW1lc3RhbXBzLg0KDQpUaGlzIGRvZXNuJ3Qgc29sdmUgdGhlIHByb2JsZW0gb2YgdGhlIE5U
UCBhZGp1c3RlZCBjbG9jayBhbHdheXMNCnJ1bm5pbmcgc2xpZ2h0bHkgc2xvdyBvciBmYXN0Lg0K
VGhlIGJpZyBOVFAgZXJyb3JzIGhhcHBlbiBpbiB0aGUgZmlyc3QgKElJUkMgdXAgdG8gfjIwIG1p
bnMgYWZ0ZXIgYm9vdCkNCndoZW4gdGhlIHN5c3RlbSBjbG9jayBpcyBiZWluZyBzeW5jaHJvbmlz
ZWQuDQpJdCByZWFsbHkgd291bGQgYmUgbmljZSBpZiB0aG9zZSBiaWcgYWRqdXN0bWVudHMgZGlk
bid0IGFmZmVjdA0KQ0xPQ0tfTU9OQVRPTklDLg0KKGFzIGFuIGV4YW1wbGUgdHJ5IHNlbmRpbmcg
UlRQIGF1ZGlvIGV2ZXJ5IDIwbXMpDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


