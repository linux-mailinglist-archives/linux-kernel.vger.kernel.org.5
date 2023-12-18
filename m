Return-Path: <linux-kernel+bounces-3588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B396D816E19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9B328450B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8851DDCA;
	Mon, 18 Dec 2023 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oRcIE3OR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0147E579
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702903307; x=1734439307;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=BrPOQcxAJFPiOpGJROaejVYtg0jjrg401AlounVUuH0=;
  b=oRcIE3ORHdJwxtgSsGxH/RDDLaCKB/cdo4Tkn5ycPf341XA5OAJAN+qF
   6u5DMuwnv8OVlDYjR60vTeo/i7Tp0ZTBIWEx89cYMQmq7hknpouBN08Uj
   bCqW0rQWeU4CFz677p7htxSQnRo1X6pHZAEUWja63ea4TSS/90DEmzEvx
   4=;
X-IronPort-AV: E=Sophos;i="6.04,285,1695686400"; 
   d="scan'208";a="692096045"
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Thread-Topic: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:41:39 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 80E4340D53;
	Mon, 18 Dec 2023 12:41:37 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:30583]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.52:2525] with esmtp (Farcaster)
 id edfe62ad-4c37-438c-ad29-1666f56557c8; Mon, 18 Dec 2023 12:41:35 +0000 (UTC)
X-Farcaster-Flow-ID: edfe62ad-4c37-438c-ad29-1666f56557c8
Received: from EX19D012EUC002.ant.amazon.com (10.252.51.162) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 12:41:35 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC002.ant.amazon.com (10.252.51.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 12:41:35 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Mon, 18 Dec 2023 12:41:34 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "ebiederm@xmission.com" <ebiederm@xmission.com>
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
Thread-Index: AQHaLY9ODTyAGBa/a0igJR34RcFga7Cna2CZgAeYkYA=
Date: Mon, 18 Dec 2023 12:41:34 +0000
Message-ID: <5a0858597867948f271fa5676fb2e3361f35d920.camel@amazon.com>
References: <20231213064004.2419447-1-jgowans@amazon.com>
	 <874jgm9huv.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874jgm9huv.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9C9E0A3ECC80E42B668D1A78E351F16@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgRXJpYywNCg0KT24gV2VkLCAyMDIzLTEyLTEzIGF0IDEwOjM5IC0wNjAwLCBFcmljIFcuIEJp
ZWRlcm1hbiB3cm90ZToNCj4gDQo+IEphbWVzIEdvd2FucyA8amdvd2Fuc0BhbWF6b24uY29tPiB3
cml0ZXM6DQo+IA0KPiA+IHN5c2NvcmVfc2h1dGRvd24oKSBydW5zIGRyaXZlciBhbmQgbW9kdWxl
IGNhbGxiYWNrcyB0byBnZXQgdGhlIHN5c3RlbQ0KPiA+IGludG8gYSBzdGF0ZSB3aGVyZSBpdCBj
YW4gYmUgY29ycmVjdGx5IHNodXQgZG93bi4gSW4gY29tbWl0DQo+ID4gNmYzODlhOGYxZGQyICgi
UE0gLyByZWJvb3Q6IGNhbGwgc3lzY29yZV9zaHV0ZG93bigpIGFmdGVyIGRpc2FibGVfbm9uYm9v
dF9jcHVzKCkiKQ0KPiA+IHN5c2NvcmVfc2h1dGRvd24oKSB3YXMgcmVtb3ZlZCBmcm9tIGtlcm5l
bF9yZXN0YXJ0X3ByZXBhcmUoKSBhbmQgaGVuY2UNCj4gPiBnb3QgKGluY29ycmVjdGx5PykgcmVt
b3ZlZCBmcm9tIHRoZSBrZXhlYyBmbG93LiBUaGlzIHdhcyBpbm5vY3VvdXMgdW50aWwNCj4gPiBj
b21taXQgNjczNTE1MGI2OTk3ICgiS1ZNOiBVc2Ugc3lzY29yZV9vcHMgaW5zdGVhZCBvZiByZWJv
b3Rfbm90aWZpZXIgdG8gaG9vayByZXN0YXJ0L3NodXRkb3duIikNCj4gPiBjaGFuZ2VkIHRoZSB3
YXkgdGhhdCBLVk0gcmVnaXN0ZXJlZCBpdHMgc2h1dGRvd24gY2FsbGJhY2tzLCBzd2l0Y2hpbmcg
ZnJvbQ0KPiA+IHJlYm9vdCBub3RpZmllcnMgdG8gc3lzY29yZV9vcHMuc2h1dGRvd24uIEFzIHN5
c2NvcmVfc2h1dGRvd24oKSBpcw0KPiA+IG1pc3NpbmcgZnJvbSBrZXhlYywgS1ZNJ3Mgc2h1dGRv
d24gaG9vayBpcyBub3QgcnVuIGFuZCB2aXJ0dWFsaXNhdGlvbiBpcw0KPiA+IGxlZnQgZW5hYmxl
ZCBvbiB0aGUgYm9vdCBDUFUgd2hpY2ggcmVzdWx0cyBpbiB0cmlwbGUgZmF1bHRzIHdoZW4NCj4g
PiBzd2l0Y2hpbmcgdG8gdGhlIG5ldyBrZXJuZWwgb24gSW50ZWwgeDg2IFZULXggd2l0aCBWTVhF
IGVuYWJsZWQuDQo+ID4gDQo+ID4gRml4IHRoaXMgYnkgYWRkaW5nIHN5c2NvcmVfc2h1dGRvd24o
KSB0byB0aGUga2V4ZWMgc2VxdWVuY2UuIEluIHRlcm1zIG9mDQo+ID4gd2hlcmUgdG8gYWRkIGl0
LCBpdCBpcyBiZWluZyBhZGRlZCBhZnRlciBtaWdyYXRpbmcgdGhlIGtleGVjIHRhc2sgdG8gdGhl
DQo+ID4gYm9vdCBDUFUsIGJ1dCBiZWZvcmUgQVBzIGFyZSBzaHV0IGRvd24uIEl0IGlzIG5vdCB0
b3RhbGx5IGNsZWFyIGlmIHRoaXMNCj4gPiBpcyB0aGUgYmVzdCBwbGFjZTogaW4gY29tbWl0IDZm
Mzg5YThmMWRkMiAoIlBNIC8gcmVib290OiBjYWxsIHN5c2NvcmVfc2h1dGRvd24oKSBhZnRlciBk
aXNhYmxlX25vbmJvb3RfY3B1cygpIikNCj4gPiBpdCBpcyBzdGF0ZWQgdGhhdCAic3lzY29yZV9v
cHMgb3BlcmF0aW9ucyBzaG91bGQgYmUgY2FycmllZCB3aXRoIG9uZQ0KPiA+IENQVSBvbi1saW5l
IGFuZCBpbnRlcnJ1cHRzIGRpc2FibGVkLiIgQVBzIGFyZSBvbmx5IG9mZmxpbmVkIGxhdGVyIGlu
DQo+ID4gbWFjaGluZV9zaHV0ZG93bigpLCBzbyB0aGlzIHN5c2NvcmVfc2h1dGRvd24oKSBpcyBi
ZWluZyBydW4gd2hpbGUgQVBzDQo+ID4gYXJlIHN0aWxsIG9ubGluZS4gVGhpcyBzZWVtcyB0byBi
ZSB0aGUgY29ycmVjdCBwbGFjZSBhcyBpdCBtYXRjaGVzIHdoZXJlDQo+ID4gc3lzY29yZV9zaHV0
ZG93bigpIGlzIHJ1biBpbiB0aGUgcmVib290IGFuZCBoYWx0IGZsb3dzIC0gdGhleSBhbHNvIHJ1
bg0KPiA+IGl0IGJlZm9yZSBBUHMgYXJlIHNodXQgZG93bi4gVGhlIGFzc3VtcHRpb24gaXMgdGhh
dCB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gPiBpbiBjb21taXQgNmYzODlhOGYxZGQyICgiUE0gLyBy
ZWJvb3Q6IGNhbGwgc3lzY29yZV9zaHV0ZG93bigpIGFmdGVyIGRpc2FibGVfbm9uYm9vdF9jcHVz
KCkiKQ0KPiA+IGlzIG5vIGxvbmdlciB2YWxpZC4NCj4gPiANCj4gPiBLVk0gaGFzIGJlZW4gZGlz
Y3Vzc2VkIGhlcmUgYXMgaXQgaXMgd2hhdCBicm9rZSBsb3VkbHkgYnkgbm90IGhhdmluZw0KPiA+
IHN5c2NvcmVfc2h1dGRvd24oKSBpbiBrZXhlYywgYnV0IHRoaXMgY2hhbmdlIGltcGFjdHMgbW9y
ZSB0aGFuIGp1c3QgS1ZNOw0KPiA+IGFsbCBkcml2ZXJzL21vZHVsZXMgd2hpY2ggcmVnaXN0ZXIg
YSBzeXNjb3JlX29wcy5zaHV0ZG93biBjYWxsYmFjayB3aWxsDQo+ID4gbm93IGJlIGludm9rZWQg
aW4gdGhlIGtleGVjIGZsb3cuIExvb2tpbmcgYXQgc29tZSBvZiB0aGVtIGxpa2UgeDg2IE1DRQ0K
PiA+IGl0IGlzIHByb2JhYmx5IG1vcmUgY29ycmVjdCB0byBhbHNvIHNodXQgdGhlc2UgZG93biBk
dXJpbmcga2V4ZWMuDQo+ID4gTWFpbnRhaW5lcnMgb2YgYWxsIGRyaXZlcnMgd2hpY2ggdXNlIHN5
c2NvcmVfb3BzLnNodXRkb3duIGFyZSBhZGRlZCBvbg0KPiA+IENDIGZvciB2aXNpYmlsaXR5LiBU
aGV5IGFyZToNCj4gPiANCj4gPiBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL2NlbGwvc3B1X2Jhc2Uu
YyAgLnNodXRkb3duID0gc3B1X3NodXRkb3duLA0KPiA+IGFyY2gveDg2L2tlcm5lbC9jcHUvbWNl
L2NvcmUuYyAgICAgICAgICAgICAgICAuc2h1dGRvd24gPSBtY2Vfc3lzY29yZV9zaHV0ZG93biwN
Cj4gPiBhcmNoL3g4Ni9rZXJuZWwvaTgyNTkuYyAgICAgICAgICAgICAgICAgLnNodXRkb3duID0g
aTgyNTlBX3NodXRkb3duLA0KPiA+IGRyaXZlcnMvaXJxY2hpcC9pcnEtaTgyNTkuYyAgICAgICAg
ICAgLnNodXRkb3duID0gaTgyNTlBX3NodXRkb3duLA0KPiA+IGRyaXZlcnMvaXJxY2hpcC9pcnEt
c3VuNmktci5jICAgICAgICAgLnNodXRkb3duID0gc3VuNmlfcl9pbnRjX3NodXRkb3duLA0KPiA+
IGRyaXZlcnMvbGVkcy90cmlnZ2VyL2xlZHRyaWctY3B1LmMgICAgLnNodXRkb3duID0gbGVkdHJp
Z19jcHVfc3lzY29yZV9zaHV0ZG93biwNCj4gPiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L3NjMjd4eC1w
b3dlcm9mZi5jIC5zaHV0ZG93biA9IHNjMjd4eF9wb3dlcm9mZl9zaHV0ZG93biwNCj4gPiBrZXJu
ZWwvaXJxL2dlbmVyaWMtY2hpcC5jICAgICAgICAgICAgIC5zaHV0ZG93biA9IGlycV9nY19zaHV0
ZG93biwNCj4gPiB2aXJ0L2t2bS9rdm1fbWFpbi5jICAgICAgICAgICAgICAgICAgIC5zaHV0ZG93
biA9IGt2bV9zaHV0ZG93biwNCj4gPiANCj4gPiBUaGlzIGhhcyBiZWVuIHRlc3RlZCBieSBkb2lu
ZyBhIGtleGVjIG9uIHg4Nl82NCBhbmQgYWFyY2g2NC4NCj4gDQo+IEZyb20gdGhlIDEwLDAwMCBm
b290IHBlcnNwZWN0aXZlOg0KPiBBY2tlZC1ieTogIkVyaWMgVy4gQmllZGVybWFuIiA8ZWJpZWRl
cm1AeG1pc3Npb24uY29tPg0KDQpUaGFua3MgZm9yIHRoZSBBQ0shDQpXaGF0J3MgdGhlIG5leHQg
c3RlcCB0byBnZXQgdGhpcyBpbnRvIHRoZSBrZXhlYyB0cmVlPw0KDQpKRw0KDQo+IA0KPiANCj4g
RXJpYw0KPiANCj4gPiBGaXhlczogNjczNTE1MGI2OTk3ICgiS1ZNOiBVc2Ugc3lzY29yZV9vcHMg
aW5zdGVhZCBvZiByZWJvb3Rfbm90aWZpZXIgdG8gaG9vayByZXN0YXJ0L3NodXRkb3duIikNCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBHb3dhbnMgPGpnb3dhbnNAYW1hem9uLmNvbT4N
Cj4gPiBDYzogRXJpYyBCaWVkZXJtYW4gPGViaWVkZXJtQHhtaXNzaW9uLmNvbT4NCj4gPiBDYzog
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gPiBDYzogU2VhbiBDaHJpc3Rv
cGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+ID4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtl
cm5lbC5vcmc+DQo+ID4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+ID4gQ2M6
IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gPiBDYzogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4
LmRlPg0KPiA+IENjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCj4gPiBDYzogQ2hl
bi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPg0KPiA+IENjOiBKZXJuZWogU2tyYWJlYyA8amVybmVq
LnNrcmFiZWNAZ21haWwuY29tPg0KPiA+IENjOiBTYW11ZWwgSG9sbGFuZCA8c2FtdWVsQHNob2xs
YW5kLm9yZz4NCj4gPiBDYzogUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+DQo+ID4gQ2M6IFNl
YmFzdGlhbiBSZWljaGVsIDxzcmVAa2VybmVsLm9yZz4NCj4gPiBDYzogT3Jzb24gWmhhaSA8b3Jz
b256aGFpQGdtYWlsLmNvbT4NCj4gPiBDYzogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmRl
Pg0KPiA+IENjOiBKYW4gSC4gU2Nob2VuaGVyciA8anNjaG9lbmhAYW1hem9uLmRlPg0KPiA+IC0t
LQ0KPiA+ICBrZXJuZWwva2V4ZWNfY29yZS5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWNfY29yZS5j
IGIva2VybmVsL2tleGVjX2NvcmUuYw0KPiA+IGluZGV4IGJlNTY0MmE0ZWM0OS4uYjkyNmM0ZGI4
YTkxIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9rZXhlY19jb3JlLmMNCj4gPiArKysgYi9rZXJu
ZWwva2V4ZWNfY29yZS5jDQo+ID4gQEAgLTEyNTQsNiArMTI1NCw3IEBAIGludCBrZXJuZWxfa2V4
ZWModm9pZCkNCj4gPiAgICAgICAgICAgICAgIGtleGVjX2luX3Byb2dyZXNzID0gdHJ1ZTsNCj4g
PiAgICAgICAgICAgICAgIGtlcm5lbF9yZXN0YXJ0X3ByZXBhcmUoImtleGVjIHJlYm9vdCIpOw0K
PiA+ICAgICAgICAgICAgICAgbWlncmF0ZV90b19yZWJvb3RfY3B1KCk7DQo+ID4gKyAgICAgICAg
ICAgICBzeXNjb3JlX3NodXRkb3duKCk7DQo+ID4gDQo+ID4gICAgICAgICAgICAgICAvKg0KPiA+
ICAgICAgICAgICAgICAgICogbWlncmF0ZV90b19yZWJvb3RfY3B1KCkgZGlzYWJsZXMgQ1BVIGhv
dHBsdWcgYXNzdW1pbmcgdGhhdA0KDQo=

