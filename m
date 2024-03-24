Return-Path: <linux-kernel+bounces-112830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F3F887EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12D1B20C85
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D321078B;
	Sun, 24 Mar 2024 20:05:27 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CBEDF58
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711310727; cv=none; b=FY5REkPVJSjYjb4jrVY+D6aixba0d16mV4uT3HxN8460cZkiNPsyWMZ9j4Ilao/o3e+ZXe7qpABzozFqQqi/ClXQblUyW0CCCQJBp+pMnqzOMQTuKzY916CyC81QyjqFtmrhEve+AO48BlxZ2SX0hEi1x/B0OPTlz8hGdM6pRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711310727; c=relaxed/simple;
	bh=IvfySWcVa3xtvUCqNnf2m8MSm9ibBjQP1xVDPkMxZhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=jTHhsmww12A3Acdfl57mHCqjXDhSX0WvFH10G862o/gB+W3ScGg7J61RpBh0qlZsjGhF3mYYxQIw+RVudlyk/ZGYOriB3wZxcvoZfSFjWOvs2zP3lOXWLs82iS29JM3iq0hp7MsT5s1ZWtsckCVVXPZKcb167KUx1ZxpCpn3Rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-31-9M3ZnYw6P76jOK7te1drUg-1; Sun, 24 Mar 2024 20:05:19 +0000
X-MC-Unique: 9M3ZnYw6P76jOK7te1drUg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Mar
 2024 20:04:48 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Mar 2024 20:04:48 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>, Puranjay Mohan
	<puranjay12@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Network Development <netdev@vger.kernel.org>, bpf
	<bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH bpf] bpf: verifier: prevent userspace memory access
Thread-Topic: [PATCH bpf] bpf: verifier: prevent userspace memory access
Thread-Index: AQHae1YhECDY/uuUVEW0JBnf8hxKG7FHVPhw
Date: Sun, 24 Mar 2024 20:04:48 +0000
Message-ID: <1686adb401b34adaa3b703ec1a8ffe49@AcuMS.aculab.com>
References: <20240320105436.4781-1-puranjay12@gmail.com>
 <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
In-Reply-To: <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
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

RnJvbTogQWxleGVpIFN0YXJvdm9pdG92DQo+IFNlbnQ6IDIxIE1hcmNoIDIwMjQgMDY6MDgNCj4g
DQo+IE9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDM6NTXigK9BTSBQdXJhbmpheSBNb2hhbiA8cHVy
YW5qYXkxMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIEpJVHMgbmVlZCB0byBpbXBs
ZW1lbnQgYnBmX2FyY2hfdWFkZHJlc3NfbGltaXQoKSB0byBkZWZpbmUgd2hlcmUNCj4gPiB0aGUg
dXNlcnNwYWNlIGFkZHJlc3NlcyBlbmQgZm9yIHRoYXQgYXJjaGl0ZWN0dXJlIG9yIFRBU0tfU0la
RSBpcyB0YWtlbg0KPiA+IGFzIGRlZmF1bHQuDQo+ID4NCj4gPiBUaGUgaW1wbGVtZW50YXRpb24g
aXMgYXMgZm9sbG93czoNCj4gPg0KPiA+IFJFR19BWCA9ICBTUkNfUkVHDQo+ID4gaWYob2Zmc2V0
KQ0KPiA+ICAgICAgICAgUkVHX0FYICs9IG9mZnNldDsNCj4gPiBSRUdfQVggPj49IDMyOw0KPiA+
IGlmIChSRUdfQVggPD0gKHVhZGRyZXNzX2xpbWl0ID4+IDMyKSkNCj4gPiAgICAgICAgIERTVF9S
RUcgPSAwOw0KPiA+IGVsc2UNCj4gPiAgICAgICAgIERTVF9SRUcgPSAqKHNpemUgKikoU1JDX1JF
RyArIG9mZnNldCk7DQo+IA0KPiBUaGUgcGF0Y2ggbG9va3MgZ29vZCwgYnV0IGl0IHNlZW1zIHRv
IGJlIGNhdXNpbmcgczM5MCBDSSBmYWlsdXJlcy4NCg0KSSdtIGNvbmZ1c2VkIGJ5IHRoZSBuZWVk
IGZvciB0aGlzIGNoZWNrIChhbmQsIElJUkMsIHNvbWUgb3RoZXIgYnBmDQpjb2RlIHRoYXQgZG9l
cyBrZXJuZWwgY29waWVzIHRoYXQgY2FuIGZhdWx0IC0gYW5kIHJldHVybiBhbiBlcnJvcikuDQoN
CkkgdGhvdWdoIHRoYXQgdGhlIGVudGlyZSBwb2ludCBvZiBicGYgd2FzIHRoYXQgaXMgc2FuaXRp
c2VkIGFuZA0KdmVyaWZpZWQgZXZlcnl0aGluZyB0byBsaW1pdCB3aGF0IHRoZSAncHJvZ3JhbScg
Y291bGQgZG8gaW4gb3JkZXINCnRvIHN0b3AgaXQgb3ZlcndyaXRpbmcgKG9yIGV2ZW4gcmVhZGlu
Zykga2VybmVsIHN0cnVjdHVyZXMgdGhhdA0KaXMgd2Fzbid0IHN1cHBvc2VkIHRvIGFjY2Vzcy4N
Cg0KU28gaXQganVzdCBzaG91bGRuJ3QgaGF2ZSBhIGFkZHJlc3MgdGhhdCBtaWdodCBiZSAoaW4g
YW55IHdheSkNCmludmFsaWQuDQoNClRoZSBvbmx5IHBvc3NpYmxlIGFkZHJlc3MgdmVyaWZ5IGlz
IGFjY2Vzc19vaygpIHRvIGVuc3VyZSB0aGF0DQphIHVzZXMgYWRkcmVzcyByZWFsbHkgaXMgYSB1
c2VyIGFkZHJlc3MuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


