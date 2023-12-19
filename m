Return-Path: <linux-kernel+bounces-4818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B1D81826D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462491C23344
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC6C2D3;
	Tue, 19 Dec 2023 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AAY0YqJt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9558BE2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702971719; x=1734507719;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=opgInH91xzBuf6eAk7Qumo1WNIkpgtAJc0dLMfhU/Xo=;
  b=AAY0YqJt2fvLxd4EKcs34hfPKNQgUSw4NaHh0KycMCzGbOhvpoX3zA8Y
   G4iJb0EFxrj7Erq22oRQrw2RSfD3/oRSWXUmDP9JkuDNrRDs4acIBc4vX
   +5qe+3ipJZNecf+dQaLOo4FlVRZD0KapJvJn8bYSMKP4fHantvDiGHWsw
   c=;
X-IronPort-AV: E=Sophos;i="6.04,287,1695686400"; 
   d="scan'208";a="260343204"
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Thread-Topic: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:41:57 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id F0C0D60CA7;
	Tue, 19 Dec 2023 07:41:54 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:58965]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.114:2525] with esmtp (Farcaster)
 id e2b3b60b-ad0e-418a-bac9-9349b4714063; Tue, 19 Dec 2023 07:41:53 +0000 (UTC)
X-Farcaster-Flow-ID: e2b3b60b-ad0e-418a-bac9-9349b4714063
Received: from EX19D012EUC003.ant.amazon.com (10.252.51.208) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 07:41:53 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC003.ant.amazon.com (10.252.51.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 07:41:52 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Tue, 19 Dec 2023 07:41:52 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "bhe@redhat.com" <bhe@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "maz@kernel.org"
	<maz@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"sre@kernel.org" <sre@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"arnd@arndb.de" <arnd@arndb.de>, "wens@csie.org" <wens@csie.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"bp@alien8.de" <bp@alien8.de>, "samuel@sholland.org" <samuel@sholland.org>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>
Thread-Index: AQHaLY9ODTyAGBa/a0igJR34RcFga7CwCs0AgAA3uIA=
Date: Tue, 19 Dec 2023 07:41:52 +0000
Message-ID: <9ffa2c4d3e808feb2afa6f02f4afabf1cd674516.camel@amazon.com>
References: <20231213064004.2419447-1-jgowans@amazon.com>
	 <ZYEafpms++a3a8ch@MiWiFi-R3L-srv>
In-Reply-To: <ZYEafpms++a3a8ch@MiWiFi-R3L-srv>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F407D659EED834391131A368521AA34@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDIzLTEyLTE5IGF0IDEyOjIyICswODAwLCBCYW9xdWFuIEhlIHdyb3RlOg0KPiBB
ZGQgQW5kcmV3IHRvIENDIGFzIEFuZHJldyBoZWxwcyB0byBwaWNrIGtleGVjL2tkdW1wIHBhdGNo
ZXMuDQoNCkFoLCB0aGFua3MsIEkgZGlkbid0IHJlYWxpc2UgdGhhdCBBbmRyZXcgcHVsbHMgaW4g
dGhlIGtleGVjIHBhdGNoZXMuDQo+IA0KPiBPbiAxMi8xMy8yMyBhdCAwODo0MGFtLCBKYW1lcyBH
b3dhbnMgd3JvdGU6DQo+IC4uLi4uLg0KPiA+IFRoaXMgaGFzIGJlZW4gdGVzdGVkIGJ5IGRvaW5n
IGEga2V4ZWMgb24geDg2XzY0IGFuZCBhYXJjaDY0Lg0KPiANCj4gSGkgSmFtZXMsDQo+IA0KPiBU
aGFua3MgZm9yIHRoaXMgZ3JlYXQgcGF0Y2guIE15IGNvbGxlYWd1ZXMgaGF2ZSBvcGVuZWQgYnVn
IGluIHJoZWwgdG8NCj4gdHJhY2sgdGhpcyBhbmQgdHJ5IHRvIHZlcnlmeSB0aGlzIHBhdGNoLiBI
b3dldmVyLCB0aGV5IGNhbid0IHJlcHJvZHVjZQ0KPiB0aGUgaXNzdWUgdGhpcyBwYXRjaCBpcyBm
aXhpbmcuIENvdWxkIHlvdSB0ZWxsIG1vcmUgYWJvdXQgd2hlcmUgYW5kIGhvdw0KPiB0byByZXBy
b2R1Y2Ugc28gdGhhdCB3ZSBjYW4gYmUgYXdhcmUgb2YgaXQgYmV0dGVyPyBUaGFua3MgaW4gYWR2
YW5jZS4NCg0KU3VyZSEgVGhlIFRMO0RSIGlzOiBydW4gYSBWTVggKEludGVsIHg4NikgS1ZNIFZN
IG9uIExpbnV4IHY2LjQrIGFuZCBkbyBhDQprZXhlYyB3aGlsZSB0aGUgIEtWTSBWTSBpcyBzdGls
bCBydW5uaW5nLiBCZWZvcmUgdGhpcyBwYXRjaCB0aGUgc3lzdGVtDQp3aWxsIHRyaXBsZSBmYXVs
dC4NCg0KSW4gbW9yZSBkZXRhaWw6DQpSdW4gYSBiYXJlIG1ldGFsIGhvc3Qgb24gYSBtb2Rlcm4g
SW50ZWwgQ1BVIHdpdGggVk1YIHN1cHBvcnQuIFRoZSBrZXJuZWwNCkkgd2FzIHVzaW5nIHdhcyA2
LjcuMC1yYzUrLg0KWW91IGNhbiB0b3RhbGx5IGRvIHRoaXMgd2l0aCBhIFFFTVUgImhvc3QiIGFz
IHdlbGwsIGJ0dywgdGhhdCdzIGhvdyBJDQpkaWQgdGhlIGRlYnVnZ2luZyBhbmQgYXR0YWNoZWQg
R0RCIHRvIGl0IHRvIGZpZ3VyZSBvdXQgd2hhdCB3YXMgdXAuDQoNCklmIHlvdSB3YW50IGEgdmly
dHVhbCAiaG9zdCIgbGF1bmNoIHdpdGg6DQoNCi1jcHUgaG9zdCAtTSBxMzUsa2VybmVsLWlycWNo
aXA9c3BsaXQsYWNjZWw9a3ZtIC1lbmFibGUta3ZtDQoNCkxhdW5jaCBhIEtWTSBndWVzdCBWTSwg
ZWc6DQoNCnFlbXUtc3lzdGVtLXg4Nl82NCBcDQogIC1lbmFibGUta3ZtIFwNCiAgLWNkcm9tIGFs
cGluZS12aXJ0LTMuMTkuMC14ODZfNjQuaXNvIFwNCiAgLW5vZGVmYXVsdHMgLW5vZ3JhcGhpYyAt
TSBxMzUgXA0KICAtc2VyaWFsIG1vbjpzdGRpbw0KDQpXaGlsZSB0aGUgZ3Vlc3QgVk0gaXMgKnN0
aWxsIHJ1bm5pbmcqIGRvIGEga2V4ZWMgb24gdGhlIGhvc3QsIGVnOg0KDQprZXhlYyAtbCAtLXJl
dXNlLWNtZGxpbmUgLS1pbml0cmQ9Y29uZmlnLTYuNy4wLXJjNSsgdm1saW51ei02LjcuMC1yYzUr
ICYmIFwNCiAga2V4ZWMgLWUNCg0KVGhlIGtleGVjIGNhbiBiZSB0byBhbnl0aGluZywgYnV0IEkg
Z2VuZXJhbGx5IGp1c3Qga2V4ZWMgdG8gdGhlIHNhbWUNCmtlcm5lbC9yYW1kaXNrIGFzIGlzIGN1
cnJlbnRseSBydW5uaW5nLiBJZTogc2FtZS12ZXJzaW9uIGtleGVjLg0KDQpCZWZvcmUgdGhpcyBw
YXRjaCB0aGUga2V4ZWMgd2lsbCBnZXQgc3R1Y2ssIGFmdGVyIHRoaXMgdGhlIGtleGVjIHdpbGwg
Z28NCnNtb290aGx5IGFuZCB0aGUgc3lzdGVtIHdpbGwgZW5kIHVwIGluIHRoZSBuZXcga2VybmVs
IGluIGEgZmV3IHNlY29uZHMuDQoNCkkgaG9wZSB0aG9zZSBzdGVwcyBhcmUgY2xlYXIgYW5kIHlv
dSBjYW4gcmVwcm8gdGhpcz8NCg0KQlRXLCB0aGUgcmVhc29uIHRoYXQgaXQncyBpbXBvcnRhbnQg
Zm9yIHRoZSBLVk0gVk0gdG8gc3RpbGwgYmUgcnVubmluZw0Kd2hlbiB0aGUgaG9zdCBkb2VzIHRo
ZSBrZXhlYyBpcyBiZWNhdXNlIEtWTSBpbnRlcm5hbGx5IG1haW50YWlucyBhIHVzYWdlDQpjb3Vu
dGVyIGFuZCB3aWxsIGRpc2FibGUgdmlydHVhbGlzYXRpb24gb25jZSBhbGwgVk1zIGhhdmUgYmVl
bg0KdGVybWluYXRlZCwgdmlhOg0KDQpfX2ZwdXQoa3ZtX2ZkKQ0KICBrdm1fdm1fcmVsZWFzZQ0K
ICAgIGt2bV9kZXN0cm95X3ZtDQogICAgICBoYXJkd2FyZV9kaXNhYmxlX2FsbA0KICAgICAgICBo
YXJkd2FyZV9kaXNhYmxlX2FsbF9ub2xvY2sNCiAgICAgICAgICBrdm1fdXNhZ2VfY291bnQtLTsN
CiAgICAgICAgICBpZiAoIWt2bV91c2FnZV9jb3VudCkNCiAgICAgICAgICAgIG9uX2VhY2hfY3B1
KGhhcmR3YXJlX2Rpc2FibGVfbm9sb2NrLCBOVUxMLCAxKTsNCg0KU28gaWYgYWxsIEtWTSBmZHMg
YXJlIGNsb3NlZCB0aGVuIGtleGVjIHdpbGwgd29yayBiZWNhdXNlIFZNWEUgaXMNCmNsZWFyZWQg
b24gYWxsIENQVXMgd2hlbiB0aGUgbGFzdCBWTSBpcyBkZXN0cm95ZWQuIElmIHRoZSBLVk0gZmRz
IGFyZQ0Kc3RpbGwgb3BlbiAoaWU6IFFFTVUgcHJvY2VzcyBzdGlsbCBleGlzdHMpIHRoZW4gdGhl
IGlzc3VlIG1hbmlmZXN0cy4gIEl0DQpzb3VuZHMgbmFzdHkgdG8gZG8gYSBrZXhlYyB3aGlsZSBR
RU1VIHByb2Nlc3NlcyBhcmUgc3RpbGwgYXJvdW5kIGJ1dA0KdGhpcyBpcyBhIHBlcmZlY3RseSBu
b3JtYWwgZmxvdyBmb3IgbGl2ZSB1cGRhdGU6DQoxLiBQYXVzZSBhbmQgU2VyaWFsaXNlIFZNIHN0
YXRlDQoyLiBrZXhlYw0KMy4gZGVzZXJpYWxpc2UgYW5kIHJlc3VtZSBWTXMuDQpJbiB0aGF0IGZs
b3cgdGhlcmUncyBubyBuZWVkIHRvIGFjdHVhbGx5IGtpbGwgdGhlIFFFTVUgcHJvY2VzcywgYXMg
bG9uZw0KYXMgdGhlIFZNIGlzICpwYXVzZWQqIGFuZCBoYXMgYmVlbiBzZXJpYWxpc2VkIHdlIGNh
biBoYXBwaWx5IGtleGVjLg0KDQpKRw0KDQo=

