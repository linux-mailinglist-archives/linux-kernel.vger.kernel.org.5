Return-Path: <linux-kernel+bounces-95714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA28751A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72E9287163
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275512DD9F;
	Thu,  7 Mar 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="wEHd8KSC"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87712BF12;
	Thu,  7 Mar 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821065; cv=none; b=j83lBXDdY3YN0QyBv7UmYsuQH6xjNMCg0UCH3bZXRpUGg1V94xOshpmpwUkiW+8Tn7+j+RsHr+FoDqw8HR/W89aFxLcKww7zdD7VycQQ2lQrOKx6SpQySgYd8jpleRPV8dJ8AcMAFT9WBwtQHM+J0Vyy+81Cvmjwq++qPqfYpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821065; c=relaxed/simple;
	bh=BO/sS3iNltEei/NOaZXQFdewmgrTpD5zeAJZ1NGWfVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/f6jsskll/3xPHwk9Zw9G1cf/9zYvpjIshGSQIEqBgbC8GppYZzOxBZa9+sPPYeCI/+lQN93W9UBJ84zUPayWpDLs6IBZAal9rznSzY0lIBasw5X2tJt1MPWHr6dQhXDaN3yFsSvatrPueEWalqyw2+htU5ePWyUgRwdKUFxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=wEHd8KSC; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 4AB3314B179B;
	Thu,  7 Mar 2024 17:17:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 4AB3314B179B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709821053; bh=BO/sS3iNltEei/NOaZXQFdewmgrTpD5zeAJZ1NGWfVc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=wEHd8KSCg81ZAv5MvDWDScZw7aqC9N4OVbsha0gOod/Qwt6AcZxCxK4DzilNBE2X/
	 KsanJ5Xp+aU371+MIl20NA1zgbCVOgbe58BXo2IHJYfr66vt0Mrpu0daFfmN+e9t6T
	 OjfCRo9sXcpfOic2MGthCN9XwgCNQefOmLxMTDvc=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 480543128A3E;
	Thu,  7 Mar 2024 17:17:33 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Simon Horman <horms@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
Thread-Topic: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
Thread-Index: AQHacGscDaUt7YW/90u+fNTxajGHYrEsIFYA
Date: Thu, 7 Mar 2024 14:17:32 +0000
Message-ID: <5c65a5be-ba95-4420-b755-aabc5ae7559b@infotecs.ru>
References: <20240306095430.1782163-1-Ilia.Gavrilov@infotecs.ru>
 <095ce1d0f2cd6771b30ab1d73ee6aa8e8460c7c8.camel@redhat.com>
 <e8b2287f-bf25-4a95-aef2-58067c893b4f@infotecs.ru>
 <20240307084014.GH281974@kernel.org>
In-Reply-To: <20240307084014.GH281974@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <928543079EBFE4409BBDA420FC8CB05C@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/07 13:22:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/07 10:14:00 #24028863
X-KLMS-AntiVirus-Status: Clean, skipped

DQoNCg0K0KEg0YPQstCw0LbQtdC90LjQtdC8LA0K0JjQu9GM0Y8g0JPQsNCy0YDQuNC70L7Qsg0K
0JLQtdC00YPRidC40Lkg0L/RgNC+0LPRgNCw0LzQvNC40YHRgg0K0J7RgtC00LXQuyDRgNCw0LfR
gNCw0LHQvtGC0LrQuA0K0JDQniAi0JjQvdGE0L7QotC10JrQoSIg0LIg0LMuINCh0LDQvdC60YIt
0J/QtdGC0LXRgNCx0YPRgNCzDQoxMjcyODcsINCzLiDQnNC+0YHQutCy0LAsINCh0YLQsNGA0YvQ
uSDQn9C10YLRgNC+0LLRgdC60L4t0KDQsNC30YPQvNC+0LLRgdC60LjQuSDQv9GA0L7QtdC30LQs
INC00L7QvCAxLzIzLCDRgdGC0YAuIDENClQ6ICs3IDQ5NSA3MzctNjEtOTIgKCDQtNC+0LEuIDQ5
MjEpDQrQpDogKzcgNDk1IDczNy03Mi03OA0KDQoNCklsaWEuR2F2cmlsb3ZAaW5mb3RlY3MucnUN
Cnd3dy5pbmZvdGVjcy5ydQ0KDQoNCk9uIDMvNy8yNCAxMTo0MCwgU2ltb24gSG9ybWFuIHdyb3Rl
Og0KPiBPbiBXZWQsIE1hciAwNiwgMjAyNCBhdCAxMTo1NDo0MEFNICswMDAwLCBHYXZyaWxvdiBJ
bGlhIHdyb3RlOg0KPj4gT24gMy82LzI0IDE0OjM2LCBQYW9sbyBBYmVuaSB3cm90ZToNCj4+PiBU
aGUgYWJvdmUgaXMgaW5jb3JyZWN0LCBhcyB0aGUgJ2xlbicgdmFyaWFibGUgaXMgYSBzaWduZWQg
aW50ZWdlcg0KPj4NCj4+IEkgbWVhbiwgaWYgJ2xlbicgaXMgbmVnYXRpdmUgdGhlbiBhZnRlciB0
aGlzIGV4cHJlc3Npb24NCj4+IGxlbiA9IG1pbl90KHVuc2lnbmVkIGludCwgbGVuLCBzaXplb2Yo
aW50KSk7DQo+PiB0aGUgJ2xlbicgdmFyaWFibGUgd2lsbCBiZSBlcXVhbCB0byBzaXplb2YoaW50
KSA9PSA0DQo+PiBhbmQgdGhlIHN0YXRlbWVudA0KPj4gaWYgKGxlbiA8IDApIHJldHVybiAtRUlO
VkFMOw0KPj4gbWlnaHQgYmUgdW5yZWFjaGFibGUgZHVyaW5nIHByb2dyYW0gZXhlY3V0aW9uLg0K
Pg0KPiBIaSBHYXZyaWxvdiBhbmQgUGFvbG8sDQo+DQo+IEkgY291bGQgYmUgbWlzc2luZyBzb21l
dGhpbmcgb2J2aW91cyBidXQgaXQgc2VlbXMgdG8gbWUgdGhhdCB0aGlzIGlzIGNvcnJlY3QuDQo+
IEFsdGhvdWdoIHBlcmhhcHMgd2UgY291bGQgdHJ5IHJld29yZGluZyB0aGUgcGF0Y2ggZGVzY3Jp
cHRpb24gdG8NCj4gbWFrZSB0aGluZ3MgYSBiaXQgY2xlYXJlci4gSGVyZSBpcyBteSBhdHRlbXB0
IGF0IHRoYXQ6DQo+DQo+ICAgICBUaGUgJ2xlbicgdmFyaWFibGUgY2FuJ3QgYmUgbmVnYXRpdmUg
d2hlbiBhc3NpZ25lZCB0aGUgcmVzdWx0IG9mDQo+ICAgICAnbWluX3QnIGJlY2F1c2UgYWxsICdt
aW5fdCcgcGFyYW1ldGVycyBhcmUgY2FzdCB0byB1bnNpZ25lZCBpbnQsDQo+ICAgICBhbmQgdGhl
biB0aGUgbWluaW11bSBvbmUgaXMgY2hvc2VuLg0KPg0KPiAgICAgVG8gZml4IHRoZSBsb2dpYywg
Y2hlY2sgJ2xlbicgYXMgcmVhZCBmcm9tICdvcHRsZW4nLA0KPiAgICAgd2hlcmUgdGhlIHR5cGVz
IG9mIHJlbGV2YW50IHZhcmlhYmxlcyBhcmUgKHNpZ25lZCkgaW50Lg0KPg0KPiBGV0lJVywgSSBz
ZWUgZm91ciBzaW1pbGFyIHBhdGNoZXMgb24gbmV0ZGV2IHRoaXMgbW9ybmluZy4NCj4gSXQgZG9l
cyBzZWVtIHRvIG1lIHRoYXQgdGhleSBhcmUgYWxsIHZhbGlkIGZpeGVzLg0KPiBCdXQgaWYgdGhl
eSBuZWVkIHRvIGJlIHJlcG9zdGVkLCBvciB0aGVyZSBhcmUgbW9yZSBjb21pbmcsDQo+IHRoZW4g
SSB0aGluayBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gYnVuZGxlIHRoZW0gdXAsDQo+IHNheSBpbnRv
IGJhdGNoZXMgb2YgMTAsIGFuZCBzZW5kIGFzIHBhdGNoLXNldHMuDQo+DQo+IFRoaXMgbWF5IGhl
bHAgd2l0aCBmcmFnbWVudGF0aW9uIG9mIHJldmlldyBvZiB3aGF0IHNlZW1zDQo+IHRvIGJlIHRo
ZSBzYW1lIGNoYW5nZSBpbiBtdWx0aXBsZSBwbGFjZXMuDQo+DQo+DQoNCkhpIFNpbW9uLCB0aGFu
ayB5b3UgZm9yIHlvdXIgYW5zd2VyLg0KDQpJJ2xsIHJld29yZCB0aGUgcGF0Y2ggZGVzY3JpcHRp
b24gYW5kIHJlcG9zdCBhIHNlcmllcyBvZiBwYXRjaGVzIGluIFYyLg0KSSBhbHNvIGZvdW5kIGEg
Y291cGxlIG9mIHBsYWNlcyB3aXRoIHRoZSBzYW1lIHByb2JsZW0uDQo=

