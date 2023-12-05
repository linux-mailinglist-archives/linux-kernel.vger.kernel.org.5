Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9C804D08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjLEJBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjLEJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:00:58 -0500
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D6518B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1701766864; x=1733302864;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=rGtbre0uxnL1009fMrOFV6FzpEY5PtO88sGlm1CzL48=;
  b=aymfSLVjb9GCUKTKYg4rlSgcqYucnvwmMNOjtm+XEFpUWEuXKuyBnZ/c
   bf4G6IS4S3W+xkT6Op+2+yf9f1Kw0KaOJagZ6/afWHsT4cgl6546ZFl2F
   tsan27mmhDPLIRkcl0xoQsrok7WjC0slGmvv7gmQpHZfBz+eBbMNEmq9b
   0=;
X-IronPort-AV: E=Sophos;i="6.04,251,1695686400"; 
   d="scan'208";a="48312856"
Subject: RE: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
Thread-Topic: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:01:03 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id 796F1101258;
        Tue,  5 Dec 2023 09:00:59 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:33966]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.108:2525] with esmtp (Farcaster)
 id df018f1f-9207-4cd1-a98e-a6e7309d206a; Tue, 5 Dec 2023 09:00:58 +0000 (UTC)
X-Farcaster-Flow-ID: df018f1f-9207-4cd1-a98e-a6e7309d206a
Received: from EX19D033EUC001.ant.amazon.com (10.252.61.132) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 09:00:58 +0000
Received: from EX19D032EUC002.ant.amazon.com (10.252.61.185) by
 EX19D033EUC001.ant.amazon.com (10.252.61.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 09:00:57 +0000
Received: from EX19D032EUC002.ant.amazon.com ([fe80::e696:121c:a227:174]) by
 EX19D032EUC002.ant.amazon.com ([fe80::e696:121c:a227:174%3]) with mapi id
 15.02.1118.040; Tue, 5 Dec 2023 09:00:57 +0000
From:   "Durrant, Paul" <pdurrant@amazon.co.uk>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Allister, Jack" <jalliste@amazon.co.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>
CC:     "Wang, Jue" <juew@amazon.com>,
        Usama Arif <usama.arif@bytedance.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHaJteEwhr8PMDWckein7xKS+NJkrCZZXiAgAD9u6A=
Date:   Tue, 5 Dec 2023 09:00:57 +0000
Message-ID: <53bce76c5c60463eba1372df426a64b9@amazon.co.uk>
References: <20231204172849.18753-1-jalliste@amazon.com>
 <c1e8e8cb-f792-4dcc-a72f-fbebe4476a1b@intel.com>
In-Reply-To: <c1e8e8cb-f792-4dcc-a72f-fbebe4476a1b@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.83.26]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5o
YW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiAwNCBEZWNlbWJlciAyMDIzIDE3OjQ1DQo+IFRvOiBB
bGxpc3RlciwgSmFjayA8amFsbGlzdGVAYW1hem9uLmNvLnVrPjsgdGdseEBsaW51dHJvbml4LmRl
Ow0KPiBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7IGRhdmUuaGFuc2VuQGxpbnV4Lmlu
dGVsLmNvbTsNCj4gaHBhQHp5dG9yLmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7IGxlbi5icm93bkBp
bnRlbC5jb20NCj4gQ2M6IER1cnJhbnQsIFBhdWwgPHBkdXJyYW50QGFtYXpvbi5jby51az47IFdh
bmcsIEp1ZSA8anVld0BhbWF6b24uY29tPjsNCj4gVXNhbWEgQXJpZiA8dXNhbWEuYXJpZkBieXRl
ZGFuY2UuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEhhbnMgZGUgR29lZGUNCj4gPGhkZWdvZWRlQHJl
ZGhhdC5jb20+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBSYWZhZWwg
Si4NCj4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbRVhURVJOQUxdIFtQQVRDSF0geDg2OiBp
bnRlbF9lcGI6IEFkZCBlYXJseXBhcmFtIG9wdGlvbiB0bw0KPiBrZWVwIGJpYXMgYXQgcGVyZm9y
bWFuY2UNCj4gDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90DQo+IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBj
b250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIDEyLzQvMjMgMDk6MjgsIEphY2sgQWxs
aXN0ZXIgd3JvdGU6DQo+ID4gVGhlcmUgYXJlIGNlcnRhaW4gc2NlbmFyaW9zIHdoZXJlIGl0IG1h
eSBiZSBpbnRlbnRpb25hbCB0aGF0IHRoZSBFUEIgd2FzDQo+ID4gc2V0IGF0IHRvIDAvRU5FUkdZ
X1BFUkZfQklBU19QRVJGT1JNQU5DRSBvbiBrZXJuZWwgYm9vdC4gRm9yIGV4YW1wbGUsIGluDQo+
ID4gZGF0YSBjZW50ZXJzIGEga2V4ZWMvbGl2ZS11cGRhdGUgb2YgdGhlIGtlcm5lbCBtYXkgYmUg
cGVyZm9ybWVkDQo+IHJlZ3VsYXJseS4NCj4gPg0KPiA+IFVzdWFsbHkgdGhpcyBsaXZlLXVwZGF0
ZSBpcyB0aW1lIGNyaXRpY2FsIGFuZCBkZWZhdWx0aW5nIG9mIHRoZSBiaWFzDQo+IGJhY2sNCj4g
PiB0byBFTkVSR1lfUEVSRl9CSUFTX05PUk1BTCBtYXkgYWN0dWFsbHkgYmUgZGV0cmltZW50YWwg
dG8gdGhlIG92ZXJhbGwNCj4gPiB1cGRhdGUgdGltZSBpZiBwcm9jZXNzb3JzJyB0aW1lIHRvIHJh
bXAgdXAvYm9vc3QgYXJlIGFmZmVjdGVkLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpbnRyb2R1Y2Vz
IGEga2VybmVsIGNvbW1hbmQgbGluZSAiaW50ZWxfZXBiX2tlZXBfcGVyZm9ybWFuY2UiDQo+ID4g
d2hpY2ggd2lsbCBsZWF2ZSB0aGUgRVBCIGF0IHBlcmZvcm1hbmNlIGlmIGR1cmluZyB0aGUgcmVz
dG9yYXRpb24gY29kZQ0KPiBwYXRoDQo+ID4gaXQgaXMgZGV0ZWN0ZWQgYXMgc3VjaC4NCj4gDQo+
IEZvbGtzLCB3aGlsZSBJIGFwcHJlY2lhdGUgdGhlIGVmZm9ydCB0byB1cHN0cmVhbSB0aGluZyB0
aGF0IHlvdSBoYXZlDQo+IGtlcHQgb3V0IG9mIHRyZWUgdXAgdW50aWwgbm93LCBJIGRvbid0IHRo
aW5rIHRoaXMgaXMgdGhlIHJpZ2h0IHdheS4NCj4gDQo+IEluIGdlbmVyYWwgbmV3IGtlcm5lbCBj
b21tYW5kLWxpbmUgb3B0aW9ucyBhcmUgYSBsYXN0IHJlc29ydC4NCj4gDQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvaW50ZWxfZXBiLmMNCj4gYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2ludGVsX2VwYi5jDQo+ID4gaW5kZXggZTRjM2JhOTEzMjFjLi4wYzdkZDA5MmY3MjMgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbF9lcGIuYw0KPiA+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvaW50ZWxfZXBiLmMNCj4gPiBAQCAtNTAsNyArNTAsOCBAQA0K
PiA+ICAgKiB0aGUgT1Mgd2lsbCBkbyB0aGF0IGFueXdheS4gIFRoYXQgc29tZXRpbWVzIGlzIHBy
b2JsZW1hdGljLCBhcyBpdA0KPiBtYXkgY2F1c2UNCj4gPiAgICogdGhlIHN5c3RlbSBiYXR0ZXJ5
IHRvIGRyYWluIHRvbyBmYXN0LCBmb3IgZXhhbXBsZSwgc28gaXQgaXMgYmV0dGVyDQo+IHRvIGFk
anVzdA0KPiA+ICAgKiBpdCBvbiBDUFUgYnJpbmctdXAgYW5kIGlmIHRoZSBpbml0aWFsIEVQQiB2
YWx1ZSBmb3IgYSBnaXZlbiBDUFUgaXMNCj4gMCwgdGhlDQo+ID4gLSAqIGtlcm5lbCBjaGFuZ2Vz
IGl0IHRvIDYgKCdub3JtYWwnKS4NCj4gPiArICoga2VybmVsIGNoYW5nZXMgaXQgdG8gNiAoJ25v
cm1hbCcpLiBUaGlzIGhvd2V2ZXIgaXMgb3ZlcnJpZGFibGUgdmlhDQo+ID4gKyAqIGludGVsX2Vw
Yl9rZWVwX3BlcmZvcm1hbmNlIGlmIHJlcXVpcmVkLg0KPiA+ICAgKi8NCj4gPg0KPiA+ICBzdGF0
aWMgREVGSU5FX1BFUl9DUFUodTgsIHNhdmVkX2VwYik7DQo+ID4gQEAgLTc1LDYgKzc2LDggQEAg
c3RhdGljIHU4IGVuZXJnX3BlcmZfdmFsdWVzW10gPSB7DQo+ID4gICAgICAgW0VQQl9JTkRFWF9Q
T1dFUlNBVkVdID0gRU5FUkdZX1BFUkZfQklBU19QT1dFUlNBVkUsDQo+ID4gIH07DQo+ID4NCj4g
PiArc3RhdGljIGJvb2wgaW50ZWxfZXBiX2tlZXBfcGVyZm9ybWFuY2UgX19yZWFkX21vc3RseTsN
Cj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgaW50ZWxfZXBiX3NhdmUodm9pZCkNCj4gPiAgew0KPiA+
ICAgICAgIHU2NCBlcGI7DQo+ID4gQEAgLTEwNyw4ICsxMTAsMTIgQEAgc3RhdGljIHZvaWQgaW50
ZWxfZXBiX3Jlc3RvcmUodm9pZCkNCj4gPiAgICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAg
ICAgICAgdmFsID0gZXBiICYgRVBCX01BU0s7DQo+ID4gICAgICAgICAgICAgICBpZiAodmFsID09
IEVORVJHWV9QRVJGX0JJQVNfUEVSRk9STUFOQ0UpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgdmFsID0gZW5lcmdfcGVyZl92YWx1ZXNbRVBCX0lOREVYX05PUk1BTF07DQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgIHByX3dhcm5fb25jZSgiRU5FUkdZX1BFUkZfQklBUzogU2V0IHRvICdu
b3JtYWwnLA0KPiB3YXMgJ3BlcmZvcm1hbmNlJ1xuIik7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIGlmICghaW50ZWxfZXBiX2tlZXBfcGVyZm9ybWFuY2UpIHsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2YWwgPSBlbmVyZ19wZXJmX3ZhbHVlc1tFUEJfSU5ERVhfTk9STUFM
XTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJuX29uY2UoIkVORVJH
WV9QRVJGX0JJQVM6IFNldCB0bw0KPiAnbm9ybWFsJywgd2FzICdwZXJmb3JtYW5jZSdcbiIpOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHByX3dhcm5fb25jZSgiRU5FUkdZX1BFUkZfQklBUzogS2VwdCBhdA0KPiAn
cGVyZm9ybWFuY2UnLCBubyBjaGFuZ2VcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB9
DQo+ID4gICAgICAgICAgICAgICB9DQo+IA0KPiBUaGlzIGlzIGZ1bmRhbWVudGFsbHkgYSBoYWNr
Lg0KPiANCg0KQWN0dWFsbHksIGl0J3Mgd29ya2luZyByb3VuZCBhIGhhY2suIFRoZSBleGlzdGlu
ZyBjb21lbnQgaW4gdGhlIGNvZGUganVzdCBhYm92ZSB0aGF0IGh1bmsgaXM6DQoNCjEwMSAgICAg
ICAgICAgICAgICAvKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCjEwMiAgICAgICAgICAgICAgICAgKiBCZWNhdXNlIGludGVsX2VwYl9zYXZlKCkg
aGFzIG5vdCBydW4gZm9yIHRoZSBjdXJyZW50IENQVSB5ZXQsICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICANCjEwMyAgICAgICAgICAgICAgICAgKiBpdCBpcyBn
b2luZyBvbmxpbmUgZm9yIHRoZSBmaXJzdCB0aW1lLCBzbyBpZiBpdHMgRVBCIHZhbHVlIGlzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCjEwNCAgICAgICAg
ICAgICAgICAgKiAwICgncGVyZm9ybWFuY2UnKSBhdCB0aGlzIHBvaW50LCBhc3N1bWUgdGhhdCBp
dCBoYXMgbm90IGJlZW4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCjEwNSAgICAgICAgICAgICAgICAgKiBpbml0aWFsaXplZCBieSB0aGUgcGxhdGZvcm0g
ZmlybXdhcmUgYW5kIHNldCBpdCB0byA2ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCjEwNiAgICAgICAgICAgICAgICAgKiAoJ25vcm1hbCcp
LiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCjEwNyAgICAgICAgICAg
ICAgICAgKi8NCg0KPiBJdCBzb3VuZHMgbGlrZSB5b3Ugd2FudCB0aGUgc3lzdGVtIGRlZmF1bHQg
dG8gYmUgYXQNCj4gRU5FUkdZX1BFUkZfQklBU19QRVJGT1JNQU5DRS4gIFlvdSBhbHNvIG1lbnRp
b25lZCB0aGF0IHRoaXMgd2FzIGRvbmUgIm9uDQo+IGtlcm5lbCBib290Ii4gIEhvdyBkaWQgeW91
IGRvIHRoYXQsIGV4YWN0bHk/ICBTaG91bGRuJ3QgdGhhdCAib24ga2VybmVsDQo+IGJvb3QiIGFj
dGlvbiBiZSByZWZsZWN0ZWQgb3ZlciBoZXJlIHJhdGhlciB0aGFuIGludHJvZHVjaW5nIGFub3Ro
ZXINCj4gY29tbWFuZC1saW5lIHBhcmFtZXRlcj8NCj4gDQoNClRoZSBwcm9ibGVtIGlzIHRoYXQg
dGhpcyB3aWxsIHRha2UgZWZmZWN0IGV2ZW4gb24gYSBrZXhlYyBhbmQgaGVuY2UgaXQgaXMgdGhy
b3R0bGluZw0KYSBzeXN0ZW0gdGhhdCBzZXQgRU5FUkdZX1BFUkZfQklBU19QRVJGT1JNQU5DRSBw
cmlvciB0byB0aGUga2V4ZWMuICBXZSB1c2Uga2V4ZWMgdG8NCmxpdmUgdXBkYXRlIHRoZSBob3N0
IGtlcm5lbCBvZiBvdXIgc3lzdGVtcyB3aGlsc3QgbGVhdmluZyB2aXJ0dWFsIG1hY2hpbmVzIHJ1
bm5pbmcuDQpUaGlzIHJlc2V0dGluZyBvZiB0aGUgcGVyZiBiaWFzIGlzIGhhdmluZyBhIHZlcnkg
ZGV0cmltZW50YWwgZWZmZWN0IG9uIHRoZSBkb3dudGltZQ0Kb2Ygb3VyIHN5c3RlbXMgYWNyb3Nz
IHRoZSBsaXZlIHVwZGF0ZSAtIGFib3V0IGEgNyBmb2xkIGluY3JlYXNlLg0KDQogIFBhdWwNCg==
