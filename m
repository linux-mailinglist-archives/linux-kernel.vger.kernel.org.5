Return-Path: <linux-kernel+bounces-20438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B0827EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC77B1C2366B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F78F51;
	Tue,  9 Jan 2024 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lgfsDtgO"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621AB79C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704783586; x=1736319586;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=DxWJPW68SX3P25uHEQaZd1lorw0LGyHW2XlkUatCwlk=;
  b=lgfsDtgOfKPzwKhEe9NbEAfjKfYewwKvmqyZM+hDv60C9nFbTwrUv2s+
   Nr6ID8zT9aoy4L1BE225+e2ThcQ+WMXAQs89g1RmBVjKTQonOXT9vJd21
   WbvXatsj2Po2DYx9ahQMwkr8xpGvmFiU4Yj6O74PppKhIULLqvBOBiCM3
   I=;
X-IronPort-AV: E=Sophos;i="6.04,182,1695686400"; 
   d="scan'208";a="388508202"
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Thread-Topic: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 06:59:44 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 05D0449F11;
	Tue,  9 Jan 2024 06:59:37 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:13469]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.235:2525] with esmtp (Farcaster)
 id 4356981e-f386-42d0-87fc-dfdeedb550cd; Tue, 9 Jan 2024 06:59:36 +0000 (UTC)
X-Farcaster-Flow-ID: 4356981e-f386-42d0-87fc-dfdeedb550cd
Received: from EX19D012EUC004.ant.amazon.com (10.252.51.220) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 06:59:35 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC004.ant.amazon.com (10.252.51.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 06:59:35 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Tue, 9 Jan 2024 06:59:35 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "maz@kernel.org"
	<maz@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"sre@kernel.org" <sre@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"arnd@arndb.de" <arnd@arndb.de>, "wens@csie.org" <wens@csie.org>, "Graf
 (AWS), Alexander" <graf@amazon.de>, =?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?=
	<jschoenh@amazon.de>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"bp@alien8.de" <bp@alien8.de>, "samuel@sholland.org" <samuel@sholland.org>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>
Thread-Index: AQHaLY9ODTyAGBa/a0igJR34RcFga7Cna2CZgAeYkYCAIjOQAA==
Date: Tue, 9 Jan 2024 06:59:35 +0000
Message-ID: <33a35d2c54b898ece210ead7d053db5c81e700f9.camel@amazon.com>
References: <20231213064004.2419447-1-jgowans@amazon.com>
	 <874jgm9huv.fsf@email.froward.int.ebiederm.org>
	 <5a0858597867948f271fa5676fb2e3361f35d920.camel@amazon.com>
In-Reply-To: <5a0858597867948f271fa5676fb2e3361f35d920.camel@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <798B73416FE0AC429F2D086B523B02CA@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

KyBha3BtDQoNCkhpIEVyaWMgYW5kIEFuZHJldywNCkp1c3QgY2hlY2tpbmcgaW4gb24gdGhpcyBw
YXRjaC4NCldvdWxkIGJlIGtlZW4gdG8gZ2V0IHRoZSBmaXggbWVyZ2VkIGlmIHlvdSdyZSBva2F5
IHdpdGggaXQsIG9yIHNvbWUNCmZlZWRiYWNrLg0KDQpBbHNvIHN0aWxsIGtlZW4gZm9yIGlucHV0
IGZvciB0aGUgZHJpdmVyIG1haW50YWluZXJzIGluIENDIGlmIHRoZXkNCnN1cHBvcnQgb3IgaGF2
ZSBvYmplY3Rpb25zIHRvIHRoZWlyIHNodXRkb3duIGhvb2tzIGJlaW5nIGludm9rZWQgb24NCmtl
eGVjLg0KDQpKRw0KDQpPbiBNb24sIDIwMjMtMTItMTggYXQgMTQ6NDEgKzAyMDAsIEphbWVzIEdv
d2FucyB3cm90ZToNCj4gSGkgRXJpYywNCj4gDQo+IE9uIFdlZCwgMjAyMy0xMi0xMyBhdCAxMDoz
OSAtMDYwMCwgRXJpYyBXLiBCaWVkZXJtYW4gd3JvdGU6DQo+ID4gDQo+ID4gSmFtZXMgR293YW5z
IDxqZ293YW5zQGFtYXpvbi5jb20+IHdyaXRlczoNCj4gPiANCj4gPiA+IHN5c2NvcmVfc2h1dGRv
d24oKSBydW5zIGRyaXZlciBhbmQgbW9kdWxlIGNhbGxiYWNrcyB0byBnZXQgdGhlIHN5c3RlbQ0K
PiA+ID4gaW50byBhIHN0YXRlIHdoZXJlIGl0IGNhbiBiZSBjb3JyZWN0bHkgc2h1dCBkb3duLiBJ
biBjb21taXQNCj4gPiA+IDZmMzg5YThmMWRkMiAoIlBNIC8gcmVib290OiBjYWxsIHN5c2NvcmVf
c2h1dGRvd24oKSBhZnRlciBkaXNhYmxlX25vbmJvb3RfY3B1cygpIikNCj4gPiA+IHN5c2NvcmVf
c2h1dGRvd24oKSB3YXMgcmVtb3ZlZCBmcm9tIGtlcm5lbF9yZXN0YXJ0X3ByZXBhcmUoKSBhbmQg
aGVuY2UNCj4gPiA+IGdvdCAoaW5jb3JyZWN0bHk/KSByZW1vdmVkIGZyb20gdGhlIGtleGVjIGZs
b3cuIFRoaXMgd2FzIGlubm9jdW91cyB1bnRpbA0KPiA+ID4gY29tbWl0IDY3MzUxNTBiNjk5NyAo
IktWTTogVXNlIHN5c2NvcmVfb3BzIGluc3RlYWQgb2YgcmVib290X25vdGlmaWVyIHRvIGhvb2sg
cmVzdGFydC9zaHV0ZG93biIpDQo+ID4gPiBjaGFuZ2VkIHRoZSB3YXkgdGhhdCBLVk0gcmVnaXN0
ZXJlZCBpdHMgc2h1dGRvd24gY2FsbGJhY2tzLCBzd2l0Y2hpbmcgZnJvbQ0KPiA+ID4gcmVib290
IG5vdGlmaWVycyB0byBzeXNjb3JlX29wcy5zaHV0ZG93bi4gQXMgc3lzY29yZV9zaHV0ZG93bigp
IGlzDQo+ID4gPiBtaXNzaW5nIGZyb20ga2V4ZWMsIEtWTSdzIHNodXRkb3duIGhvb2sgaXMgbm90
IHJ1biBhbmQgdmlydHVhbGlzYXRpb24gaXMNCj4gPiA+IGxlZnQgZW5hYmxlZCBvbiB0aGUgYm9v
dCBDUFUgd2hpY2ggcmVzdWx0cyBpbiB0cmlwbGUgZmF1bHRzIHdoZW4NCj4gPiA+IHN3aXRjaGlu
ZyB0byB0aGUgbmV3IGtlcm5lbCBvbiBJbnRlbCB4ODYgVlQteCB3aXRoIFZNWEUgZW5hYmxlZC4N
Cj4gPiA+IA0KPiA+ID4gRml4IHRoaXMgYnkgYWRkaW5nIHN5c2NvcmVfc2h1dGRvd24oKSB0byB0
aGUga2V4ZWMgc2VxdWVuY2UuIEluIHRlcm1zIG9mDQo+ID4gPiB3aGVyZSB0byBhZGQgaXQsIGl0
IGlzIGJlaW5nIGFkZGVkIGFmdGVyIG1pZ3JhdGluZyB0aGUga2V4ZWMgdGFzayB0byB0aGUNCj4g
PiA+IGJvb3QgQ1BVLCBidXQgYmVmb3JlIEFQcyBhcmUgc2h1dCBkb3duLiBJdCBpcyBub3QgdG90
YWxseSBjbGVhciBpZiB0aGlzDQo+ID4gPiBpcyB0aGUgYmVzdCBwbGFjZTogaW4gY29tbWl0IDZm
Mzg5YThmMWRkMiAoIlBNIC8gcmVib290OiBjYWxsIHN5c2NvcmVfc2h1dGRvd24oKSBhZnRlciBk
aXNhYmxlX25vbmJvb3RfY3B1cygpIikNCj4gPiA+IGl0IGlzIHN0YXRlZCB0aGF0ICJzeXNjb3Jl
X29wcyBvcGVyYXRpb25zIHNob3VsZCBiZSBjYXJyaWVkIHdpdGggb25lDQo+ID4gPiBDUFUgb24t
bGluZSBhbmQgaW50ZXJydXB0cyBkaXNhYmxlZC4iIEFQcyBhcmUgb25seSBvZmZsaW5lZCBsYXRl
ciBpbg0KPiA+ID4gbWFjaGluZV9zaHV0ZG93bigpLCBzbyB0aGlzIHN5c2NvcmVfc2h1dGRvd24o
KSBpcyBiZWluZyBydW4gd2hpbGUgQVBzDQo+ID4gPiBhcmUgc3RpbGwgb25saW5lLiBUaGlzIHNl
ZW1zIHRvIGJlIHRoZSBjb3JyZWN0IHBsYWNlIGFzIGl0IG1hdGNoZXMgd2hlcmUNCj4gPiA+IHN5
c2NvcmVfc2h1dGRvd24oKSBpcyBydW4gaW4gdGhlIHJlYm9vdCBhbmQgaGFsdCBmbG93cyAtIHRo
ZXkgYWxzbyBydW4NCj4gPiA+IGl0IGJlZm9yZSBBUHMgYXJlIHNodXQgZG93bi4gVGhlIGFzc3Vt
cHRpb24gaXMgdGhhdCB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gPiA+IGluIGNvbW1pdCA2ZjM4OWE4
ZjFkZDIgKCJQTSAvIHJlYm9vdDogY2FsbCBzeXNjb3JlX3NodXRkb3duKCkgYWZ0ZXIgZGlzYWJs
ZV9ub25ib290X2NwdXMoKSIpDQo+ID4gPiBpcyBubyBsb25nZXIgdmFsaWQuDQo+ID4gPiANCj4g
PiA+IEtWTSBoYXMgYmVlbiBkaXNjdXNzZWQgaGVyZSBhcyBpdCBpcyB3aGF0IGJyb2tlIGxvdWRs
eSBieSBub3QgaGF2aW5nDQo+ID4gPiBzeXNjb3JlX3NodXRkb3duKCkgaW4ga2V4ZWMsIGJ1dCB0
aGlzIGNoYW5nZSBpbXBhY3RzIG1vcmUgdGhhbiBqdXN0IEtWTTsNCj4gPiA+IGFsbCBkcml2ZXJz
L21vZHVsZXMgd2hpY2ggcmVnaXN0ZXIgYSBzeXNjb3JlX29wcy5zaHV0ZG93biBjYWxsYmFjayB3
aWxsDQo+ID4gPiBub3cgYmUgaW52b2tlZCBpbiB0aGUga2V4ZWMgZmxvdy4gTG9va2luZyBhdCBz
b21lIG9mIHRoZW0gbGlrZSB4ODYgTUNFDQo+ID4gPiBpdCBpcyBwcm9iYWJseSBtb3JlIGNvcnJl
Y3QgdG8gYWxzbyBzaHV0IHRoZXNlIGRvd24gZHVyaW5nIGtleGVjLg0KPiA+ID4gTWFpbnRhaW5l
cnMgb2YgYWxsIGRyaXZlcnMgd2hpY2ggdXNlIHN5c2NvcmVfb3BzLnNodXRkb3duIGFyZSBhZGRl
ZCBvbg0KPiA+ID4gQ0MgZm9yIHZpc2liaWxpdHkuIFRoZXkgYXJlOg0KPiA+ID4gDQo+ID4gPiBh
cmNoL3Bvd2VycGMvcGxhdGZvcm1zL2NlbGwvc3B1X2Jhc2UuYyAgLnNodXRkb3duID0gc3B1X3No
dXRkb3duLA0KPiA+ID4gYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jICAgICAgICAgICAg
ICAgIC5zaHV0ZG93biA9IG1jZV9zeXNjb3JlX3NodXRkb3duLA0KPiA+ID4gYXJjaC94ODYva2Vy
bmVsL2k4MjU5LmMgICAgICAgICAgICAgICAgIC5zaHV0ZG93biA9IGk4MjU5QV9zaHV0ZG93biwN
Cj4gPiA+IGRyaXZlcnMvaXJxY2hpcC9pcnEtaTgyNTkuYyAgICAgICAgICAgLnNodXRkb3duID0g
aTgyNTlBX3NodXRkb3duLA0KPiA+ID4gZHJpdmVycy9pcnFjaGlwL2lycS1zdW42aS1yLmMgICAg
ICAgICAuc2h1dGRvd24gPSBzdW42aV9yX2ludGNfc2h1dGRvd24sDQo+ID4gPiBkcml2ZXJzL2xl
ZHMvdHJpZ2dlci9sZWR0cmlnLWNwdS5jICAgIC5zaHV0ZG93biA9IGxlZHRyaWdfY3B1X3N5c2Nv
cmVfc2h1dGRvd24sDQo+ID4gPiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L3NjMjd4eC1wb3dlcm9mZi5j
IC5zaHV0ZG93biA9IHNjMjd4eF9wb3dlcm9mZl9zaHV0ZG93biwNCj4gPiA+IGtlcm5lbC9pcnEv
Z2VuZXJpYy1jaGlwLmMgICAgICAgICAgICAgLnNodXRkb3duID0gaXJxX2djX3NodXRkb3duLA0K
PiA+ID4gdmlydC9rdm0va3ZtX21haW4uYyAgICAgICAgICAgICAgICAgICAuc2h1dGRvd24gPSBr
dm1fc2h1dGRvd24sDQo+ID4gPiANCj4gPiA+IFRoaXMgaGFzIGJlZW4gdGVzdGVkIGJ5IGRvaW5n
IGEga2V4ZWMgb24geDg2XzY0IGFuZCBhYXJjaDY0Lg0KPiA+IA0KPiA+IEZyb20gdGhlIDEwLDAw
MCBmb290IHBlcnNwZWN0aXZlOg0KPiA+IEFja2VkLWJ5OiAiRXJpYyBXLiBCaWVkZXJtYW4iIDxl
YmllZGVybUB4bWlzc2lvbi5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBBQ0shDQo+IFdoYXQn
cyB0aGUgbmV4dCBzdGVwIHRvIGdldCB0aGlzIGludG8gdGhlIGtleGVjIHRyZWU/DQo+IA0KPiBK
Rw0KPiANCj4gPiANCj4gPiANCj4gPiBFcmljDQo+ID4gDQo+ID4gPiBGaXhlczogNjczNTE1MGI2
OTk3ICgiS1ZNOiBVc2Ugc3lzY29yZV9vcHMgaW5zdGVhZCBvZiByZWJvb3Rfbm90aWZpZXIgdG8g
aG9vayByZXN0YXJ0L3NodXRkb3duIikNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFt
ZXMgR293YW5zIDxqZ293YW5zQGFtYXpvbi5jb20+DQo+ID4gPiBDYzogRXJpYyBCaWVkZXJtYW4g
PGViaWVkZXJtQHhtaXNzaW9uLmNvbT4NCj4gPiA+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemlu
aUByZWRoYXQuY29tPg0KPiA+ID4gQ2M6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29n
bGUuY29tPg0KPiA+ID4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+DQo+ID4gPiBD
YzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gPiA+IENjOiBUb255IEx1Y2sgPHRv
bnkubHVja0BpbnRlbC5jb20+DQo+ID4gPiBDYzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjgu
ZGU+DQo+ID4gPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+ID4g
PiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+ID4gPiBDYzogQ2hlbi1ZdSBU
c2FpIDx3ZW5zQGNzaWUub3JnPg0KPiA+ID4gQ2M6IEplcm5laiBTa3JhYmVjIDxqZXJuZWouc2ty
YWJlY0BnbWFpbC5jb20+DQo+ID4gPiBDYzogU2FtdWVsIEhvbGxhbmQgPHNhbXVlbEBzaG9sbGFu
ZC5vcmc+DQo+ID4gPiBDYzogUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+DQo+ID4gPiBDYzog
U2ViYXN0aWFuIFJlaWNoZWwgPHNyZUBrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IE9yc29uIFpoYWkg
PG9yc29uemhhaUBnbWFpbC5jb20+DQo+ID4gPiBDYzogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1h
em9uLmRlPg0KPiA+ID4gQ2M6IEphbiBILiBTY2hvZW5oZXJyIDxqc2Nob2VuaEBhbWF6b24uZGU+
DQo+ID4gPiAtLS0NCj4gPiA+ICBrZXJuZWwva2V4ZWNfY29yZS5jIHwgMSArDQo+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9r
ZXJuZWwva2V4ZWNfY29yZS5jIGIva2VybmVsL2tleGVjX2NvcmUuYw0KPiA+ID4gaW5kZXggYmU1
NjQyYTRlYzQ5Li5iOTI2YzRkYjhhOTEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9rZXJuZWwva2V4ZWNf
Y29yZS5jDQo+ID4gPiArKysgYi9rZXJuZWwva2V4ZWNfY29yZS5jDQo+ID4gPiBAQCAtMTI1NCw2
ICsxMjU0LDcgQEAgaW50IGtlcm5lbF9rZXhlYyh2b2lkKQ0KPiA+ID4gICAgICAgICAgICAgICBr
ZXhlY19pbl9wcm9ncmVzcyA9IHRydWU7DQo+ID4gPiAgICAgICAgICAgICAgIGtlcm5lbF9yZXN0
YXJ0X3ByZXBhcmUoImtleGVjIHJlYm9vdCIpOw0KPiA+ID4gICAgICAgICAgICAgICBtaWdyYXRl
X3RvX3JlYm9vdF9jcHUoKTsNCj4gPiA+ICsgICAgICAgICAgICAgc3lzY29yZV9zaHV0ZG93bigp
Ow0KPiA+ID4gDQo+ID4gPiAgICAgICAgICAgICAgIC8qDQo+ID4gPiAgICAgICAgICAgICAgICAq
IG1pZ3JhdGVfdG9fcmVib290X2NwdSgpIGRpc2FibGVzIENQVSBob3RwbHVnIGFzc3VtaW5nIHRo
YXQNCj4gDQoNCg==

