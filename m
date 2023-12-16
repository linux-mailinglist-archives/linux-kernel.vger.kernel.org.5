Return-Path: <linux-kernel+bounces-2382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F6815C0C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC3A1F22D73
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992CD358AD;
	Sat, 16 Dec 2023 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gWowHxus"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915FD279;
	Sat, 16 Dec 2023 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702764567; x=1734300567;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=E9SukeIuCwi2LM5I94WvlVByJpsCm4UYtu9SKiCRw9g=;
  b=gWowHxuslogOcMMTueKiUIK25pWeta7vaV5DD05yjnkt2opnzy9Im91S
   8wQ92xBn++VhTJglNJ+S3SzFL/zGssfFJve9p+66zqxNJMnQfaKKx0CHW
   PEgC5rRqsFanUwopdQI5EfTIrulKLW5mIOUnG0Aqn6vudtKMitL499WmM
   0=;
X-IronPort-AV: E=Sophos;i="6.04,282,1695686400"; 
   d="scan'208";a="51508333"
Subject: RE: [PATCH net-next 17/24] net: amazon, aquanti, broadcom, cavium,
 engleder: Use nested-BH locking for XDP redirect.
Thread-Topic: [PATCH net-next 17/24] net: amazon, aquanti, broadcom, cavium,
 engleder: Use nested-BH locking for XDP redirect.
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 22:09:24 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id 4281F6952E;
	Sat, 16 Dec 2023 22:09:13 +0000 (UTC)
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:33115]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.15.188:2525] with esmtp (Farcaster)
 id 23abffa8-d535-4bad-b314-f92c80785dd5; Sat, 16 Dec 2023 22:09:12 +0000 (UTC)
X-Farcaster-Flow-ID: 23abffa8-d535-4bad-b314-f92c80785dd5
Received: from EX19D047EUA003.ant.amazon.com (10.252.50.160) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 16 Dec 2023 22:09:12 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D047EUA003.ant.amazon.com (10.252.50.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 16 Dec 2023 22:09:12 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1118.040; Sat, 16 Dec 2023 22:09:12 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Boqun Feng
	<boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
	<edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will Deacon
	<will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Arinzon, David"
	<darinzon@amazon.com>, Igor Russkikh <irusskikh@marvell.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Michael Chan <michael.chan@broadcom.com>, "Dagan,
 Noam" <ndagan@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, Sunil Goutham <sgoutham@marvell.com>
Thread-Index: AQHaL3nHmwTRRV3r7EuTS0zOjdq1crCsc+Ow
Date: Sat, 16 Dec 2023 22:09:07 +0000
Deferred-Delivery: Sat, 16 Dec 2023 22:08:39 +0000
Message-ID: <13a755a898a44a98ac9b8e3240d17550@amazon.com>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-18-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-18-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: Bulk

PiBUaGUgcGVyLUNQVSB2YXJpYWJsZXMgdXNlZCBkdXJpbmcgYnBmX3Byb2dfcnVuX3hkcCgpIGlu
dm9jYXRpb24gYW5kIGxhdGVyDQo+IGR1cmluZyB4ZHBfZG9fcmVkaXJlY3QoKSByZWx5IG9uIGRp
c2FibGVkIEJIIGZvciB0aGVpciBwcm90ZWN0aW9uLg0KPiBXaXRob3V0IGxvY2tpbmcgaW4gbG9j
YWxfYmhfZGlzYWJsZSgpIG9uIFBSRUVNUFRfUlQgdGhlc2UgZGF0YSBzdHJ1Y3R1cmUNCj4gcmVx
dWlyZSBleHBsaWNpdCBsb2NraW5nLg0KPiANCj4gVGhpcyBpcyBhIGZvbGxvdy11cCBvbiB0aGUg
cHJldmlvdXMgY2hhbmdlIHdoaWNoIGludHJvZHVjZWQNCj4gYnBmX3J1bl9sb2NrLnJlZGlyZWN0
X2xvY2sgYW5kIHVzZXMgaXQgbm93IHdpdGhpbiBkcml2ZXJzLg0KPiANCj4gVGhlIHNpbXBsZSB3
YXkgaXMgdG8gYWNxdWlyZSB0aGUgbG9jayBiZWZvcmUgYnBmX3Byb2dfcnVuX3hkcCgpIGlzIGlu
dm9rZWQgYW5kDQo+IGhvbGQgaXQgdW50aWwgdGhlIGVuZCBvZiBmdW5jdGlvbi4NCj4gVGhpcyBk
b2VzIG5vdCBhbHdheXMgd29yayBiZWNhdXNlIHNvbWUgZHJpdmVycyAoY3BzdywgYXRsYW50aWMp
IGludm9rZQ0KPiB4ZHBfZG9fZmx1c2goKSBpbiB0aGUgc2FtZSBjb250ZXh0Lg0KPiBBY3F1aXJp
bmcgdGhlIGxvY2sgaW4gYnBmX3Byb2dfcnVuX3hkcCgpIGFuZCBkcm9wcGluZyBpbg0KPiB4ZHBf
ZG9fcmVkaXJlY3QoKSAod2l0aG91dCB0b3VjaGluZyBkcml2ZXJzKSBkb2VzIG5vdCB3b3JrIGJl
Y2F1c2Ugbm90IGFsbA0KPiBkcml2ZXIsIHdoaWNoIHVzZSBicGZfcHJvZ19ydW5feGRwKCksIGRv
IHN1cHBvcnQgWERQX1JFRElSRUNUIChhbmQgaW52b2tlDQo+IHhkcF9kb19yZWRpcmVjdCgpKS4N
Cj4gDQo+IElkZWFsbHkgdGhlIG1pbmltYWwgbG9ja2luZyBzY29wZSB3b3VsZCBiZSBicGZfcHJv
Z19ydW5feGRwKCkgKw0KPiB4ZHBfZG9fcmVkaXJlY3QoKSBhbmQgZXZlcnl0aGluZyBlbHNlIChl
cnJvciByZWNvdmVyeSwgRE1BIHVubWFwcGluZywgZnJlZS8NCj4gYWxsb2Mgb2YgbWVtb3J5LCDi
gKYpIHdvdWxkIGhhcHBlbiBvdXRzaWRlIG9mIHRoZSBsb2NrZWQgc2VjdGlvbi4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25p
eC5kZT4NCg0KSGkgU2ViYXN0aWFuLA0KDQpJIHdvdWxkIGxpa2UgdG8gbWFrZSBzdXJlIEkgdW5k
ZXJzdGFuZCBjb3JyZWN0bHkgdGhlIGRpZmZlcmVuY2UgaW4gdGhpcyBwYXRjaA0KYmV0d2VlbiBl
bmEgYW5kIGF0bGFudGljIGRyaXZlcnMuDQoNCkluIHRoZSBhdGxhbnRpYyBkcml2ZXIgdGhlIGNo
YW5nZSB5b3UndmUgbWFkZSBzZWVtcyBsaWtlIHRoZSBiZXN0IGNoYW5nZQ0KaW4gdGVybXMgb2Yg
bWFraW5nIHRoZSBjcml0aWNhbCBzZWN0aW9uIGFzIHNtYWxsIGFzIHBvc3NpYmxlLg0KDQpZb3Ug
Y291bGQgaGF2ZSBkb25lIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcgd2l0aCBlbmEsIGJ1dCB5b3Ug
Y2hvc2UgaW5zdGVhZA0KdG8gbGV0IGVuYSByZWxlYXNlIHRoZSBsb2NrIGF0IHRoZSBlbmQgb2Yg
dGhlIGZ1bmN0aW9uLCB3aGljaCBpbiBjYXNlIG9mIGFuIFhEUF9UWA0KbWF5IG1ha2UgdGhlIGNy
aXRpY2FsIHNlY3Rpb24gY29uc2lkZXJhYmx5IGxvbmdlciB0aGFuIGluIHRoZSBhdGxhbnRpYyBz
b2x1dGlvbi4NCg0KSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSAocXVvdGUgZnJvbSB5b3VyIGNv
bW1pdCBtZXNzYWdlICJUaGlzIGRvZXMgbm90DQphbHdheXMgd29yayBiZWNhdXNlIHNvbWUgZHJp
dmVycyAoY3BzdywgYXRsYW50aWMpIGludm9rZSB4ZHBfZG9fZmx1c2goKQ0KaW4gdGhlIHNhbWUg
Y29udGV4dCIpLCBpbiB0aGUgY2FzZSBvZiBhdGxhbnRpYyB5b3UgaGFkIHRvIGdvIGZvciB0aGUg
bW9yZQ0KY29kZS1hbHRlcmluZyBjaGFuZ2UsIGJlY2F1c2UgaWYgeW91IHNpbXBseSB1c2VkIGd1
YXJkKCkgeW91IHdvdWxkIGluY2x1ZGUNCnRoZSB4ZHBfZG9fZmx1c2goKSBpbiB0aGUgY3JpdGlj
YWwgc2VjdGlvbiwgYnV0IGluIHRoZSBjYXNlIG9mIGVuYSB4ZHBfZG9fZmx1c2goKQ0KaXMgY2Fs
bGVkIGFmdGVyIHRoZSBmdW5jdGlvbiBlbmRzIHNvIGd1YXJkIGlzIGdvb2QgZW5vdWdoLg0KDQpR
dWVzdGlvbnM6DQoxLiBEaWQgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGUgZGlmZmVyZW5jZSBp
biBzb2x1dGlvbiBjaG9pY2UgYmV0d2VlbiBhdGxhbnRpYw0KYW5kIGVuYT8NCjIuIEFzIGZhciBh
cyBJIGNhbiBzZWUgdGhlIGd1YXJkKCkgc29sdXRpb24gbG9va3MgZ29vZCBmb3IgZW5hIGV4Y2Vw
dCBmb3IgKG1heWJlPykNClhEUF9UWCwgd2hlcmUgdGhlIGNyaXRpY2FsIHNlY3Rpb24gYmVjb21l
cyBhIGJpdCBsb25nLiBDYW4geW91IHBsZWFzZSBleHBsYWluLA0Kd2h5IHlvdSB0aGluayBpdCBp
cyBzdGlsbCAgZ29vZCBlbm91Z2ggZm9yIGVuYSB0byB1c2UgdGhlIGd1YXJkKCkgc29sdXRpb24g
aW5zdGVhZA0Kb2YgZG9pbmcgdGhlIG1vcmUgIGNvZGUtYWx0ZXJpbmcgYXRsYW50aWMgc29sdXRp
b24/DQoNClRoYW5rcyENCkFydGh1cg0KDQoNCg==

