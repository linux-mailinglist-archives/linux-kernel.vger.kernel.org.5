Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15B6805DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346196AbjLESdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:33:51 -0500
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B975E194;
        Tue,  5 Dec 2023 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701801239; x=1733337239;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=l5dYmSdgZTcuJYxDAGdS1l6x9ZwcH2iY36cljlVc9vE=;
  b=eEX6M8cAxOcgQx8k3GW+CgxaqeUNd1/4oDH+RzDSiiCZe7hgNsIwMJBv
   94mO0VSXmh24E8P1i/Uj48WU1OM9VA9NUnXfDKrVZ8LPsduRROG1KgQ3U
   QZD8irSDKw/knSwGZdrhFp7k2x1PEKMccKPyQM27QaBuiVXn7Juuo+HAz
   E=;
X-IronPort-AV: E=Sophos;i="6.04,253,1695686400"; 
   d="scan'208";a="366713875"
Subject: Re: armv8pmu: Pending overflow interrupt is discarded when perf event is
 disabled
Thread-Topic: armv8pmu: Pending overflow interrupt is discarded when perf event is disabled
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 18:33:58 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id F13B99CBE7;
        Tue,  5 Dec 2023 18:33:55 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:45440]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.101:2525] with esmtp (Farcaster)
 id 1e3f6716-8593-42a2-bfa4-90021eccbedf; Tue, 5 Dec 2023 18:33:55 +0000 (UTC)
X-Farcaster-Flow-ID: 1e3f6716-8593-42a2-bfa4-90021eccbedf
Received: from EX19D012UWC002.ant.amazon.com (10.13.138.165) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 18:33:55 +0000
Received: from EX19D012UWC002.ant.amazon.com (10.13.138.165) by
 EX19D012UWC002.ant.amazon.com (10.13.138.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 18:33:54 +0000
Received: from EX19D012UWC002.ant.amazon.com ([fe80::afb2:a509:3c85:23c6]) by
 EX19D012UWC002.ant.amazon.com ([fe80::afb2:a509:3c85:23c6%5]) with mapi id
 15.02.1118.040; Tue, 5 Dec 2023 18:33:54 +0000
From:   "Ashley, William" <wash@amazon.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>
Thread-Index: AQHaG+B2preRGLMobEe2ogRfnSWcUrCDZnWAgA4lyYCAAUJkAIAACZaAgAg97oD//6C1gA==
Date:   Tue, 5 Dec 2023 18:33:54 +0000
Message-ID: <891FE9D7-E036-4EA8-8D77-CF90C1CD54D1@amazon.com>
References: <950001BD-490C-4BAC-8EEA-CDB9F7C4ADFC@amazon.com>
 <EBAF38AB-2BE5-425F-8A52-DDCB0B390309@amazon.com>
 <ZWdoNWps4izj5WJy@FVFF77S0Q05N.cambridge.arm.com>
 <ZWh2pnR_Z5-CKuZb@FVFF77S0Q05N> <ZWh-sbrHJu2b-BU6@FVFF77S0Q05N>
 <ZW9ooVL32WB8U4YB@FVFF77S0Q05N>
In-Reply-To: <ZW9ooVL32WB8U4YB@FVFF77S0Q05N>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.178.6]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A46CDC404FCB54F9BBC89AFE58161A7@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFyaywNClRoYW5rcyBmb3IgeW91ciB0aW1lIG9uIHRoaXMuIElzIHRoZXJlIChhbnkgbW9yZSBv
ZikgYSBjaGFuY2Ugb2YgZ2V0dGluZyBhIGZhbHNlIHNlY29uZCBvdmVyZmxvdyBzaWduYWwgd2l0
aCB0aGVzZSBjaGFuZ2VzPyBFc3BlY2lhbGx5IGZvciBleGFtcGxlIHdoZW4gdGhlIGNvdW50ZXIg
aXMgY291bnRpbmcgRUwxLCBvciB3aGVuIHBzZXVkby1ubWkgaXMgZW5hYmxlZD8NCg0KDQrvu79P
biAxMi81LzIzLCAxMjoxNSBQTSwgIk1hcmsgUnV0bGFuZCIgPG1hcmsucnV0bGFuZEBhcm0uY29t
IDxtYWlsdG86bWFyay5ydXRsYW5kQGFybS5jb20+PiB3cm90ZToNCg0KDQpDQVVUSU9OOiBUaGlz
IGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZpcm0g
dGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KDQoNCg0KT24g
VGh1LCBOb3YgMzAsIDIwMjMgYXQgMTI6MjM6MTNQTSArMDAwMCwgTWFyayBSdXRsYW5kIHdyb3Rl
Og0KPiBPbiBUaHUsIE5vdiAzMCwgMjAyMyBhdCAxMTo0ODo1NEFNICswMDAwLCBNYXJrIFJ1dGxh
bmQgd3JvdGU6DQo+ID4gT24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMDQ6MzU6MDFQTSArMDAwMCwg
TWFyayBSdXRsYW5kIHdyb3RlOg0KPiA+ID4gRG9lcyBSUiBzZXQgYW55IG9mIHRoZSBwZXJmX2V2
ZW50X2F0dHI6OmV4Y2x1ZGVfKiBiaXRzPyBJZiBub3QsIGRvZXMgUlINCj4gPiA+IGludGVudGlv
bmFsbHkgY291bnQgZXZlbnRzIHRoYXQgb2NjdXIgd2l0aGluIHRoZSBrZXJuZWw/DQo+ID4NCj4g
PiBMb29raW5nIGF0IHRoZSB0ZXN0LCBJIHNlZSBpdCBzZXRzIHBlcmZfZXZlbnRfYXR0cjo6ZXhj
bHVkZV9rZXJuZWwgdG8gMSwgYnV0DQo+ID4gZG9lc24ndCBzZXQgcGVyZl9ldmVudF9hdHRyOjpl
eGNsdWRlX2hvc3Qgb3IgcGVyZl9ldmVudF9hdHRyOjpleGNsdWRlX2h2LiBJDQo+ID4gdGhpbmsg
dGhlIHBvb3JseS1kZWZpbmVkIGV4Y2x1ZGVfKiBiaXRzIGFyZSBwYXJ0IG9mIHRoZSBwcm9ibGVt
IGhlcmUuDQo+ID4NCj4gPiBVc2luZyB5b3VyIHRlc3QgYXMtaXMgb24gbXkgVGh1bmRlclgyLCBJ
IGNhbiByZXByb2R1Y2UgdGhlIHBlcmlvZCBiZWluZyBsb25nZXINCj4gPiB0aGFuIGV4cGVjdGVk
IGJ5IGNvbmN1cnJlbnRseSBydW5uaW5nIHRoZSBmb2xsb3dpbmcgaW4gYSBzaGVsbDoNCj4gPg0K
PiA+IHdoaWxlIHRydWU7IGRvDQo+ID4gZm9yIEMgaW4gJChzZXEgMCA2Myk7IGRvDQo+ID4gdGFz
a3NldCAtYyAtcCAkQyAke1RFU1RfUElEX0hFUkV9Ow0KPiA+IGRvbmU7DQo+ID4gZG9uZSA+IC9k
ZXYvbnVsbA0KPiA+DQo+ID4gLi4uIHJlc3VsdGluZyBpbjoNCj4gPg0KPiA+IHwgW21hcmtAZ3Jh
dmFkbGFrczp+XSUgLi9jb3VudGVyLW92ZXJmbG93DQo+ID4gfCBQaWQgMjAwNjAgcnVubmluZyB3
aXRoIHBlcmlvZCAxMDAwMCB0b2xlcmFuY2UgMTAwMA0KPiA+IHwgU2lnbmFsICMxOiBsYXN0OiAw
LCBjdXI6IDEwMjkyLCBtYXggZGlmZjogMA0KPiA+IHwgU2lnbmFsICM0MTUzMzA6IGRlbHRhIG9m
IDE5OTk5IGlzIG91dHNpZGUgMTAwMDAgKy8tIDEwMDANCj4gPiB8IFNpZ25hbCAjNDE1MzMwOiBs
YXN0OiA0MTUzMjkwMTg3LCBjdXI6IDQxNTMzMTAxODYsIG1heCBkaWZmOiAxMDI5Mg0KPiA+IHwg
U2lnbmFsICM0ODk4Nzk6IGRlbHRhIG9mIDE5OTk4IGlzIG91dHNpZGUgMTAwMDAgKy8tIDEwMDAN
Cj4gPiB8IFNpZ25hbCAjNTExODQyOiBkZWx0YSBvZiAyMDA1OCBpcyBvdXRzaWRlIDEwMDAwICsv
LSAxMDAwDQo+ID4gfCBTaWduYWwgIzUxMTg0MjogbGFzdDogNTExODQzMDEzMCwgY3VyOiA1MTE4
NDUwMTg4LCBtYXggZGlmZjogMTk5OTkNCj4gPg0KPiA+IEhvd2V2ZXIsIGlmIEkgbW9kaWZ5IHRo
ZSB0ZXN0IHRvIGFsc28gc2V0IHBlcmZfZXZlbnRfYXR0cjo6ZXhjbHVkZV9ob3N0PTEsIEkgZG8N
Cj4gPiBub3Qgc2VlIGFueSBsb3N0IG92ZXJmbG93cyBhZnRlciBtYW55IG1pbnV0ZXMuIE9uIFZI
RSBob3N0cyAobGlrZSB0aGUNCj4gPiBUaHVuZGVyWDIpLCB0aGUgaG9zdCBrZXJuZWwgZ2V0cyBj
b3VudGVkIHdoZW4gcGVyZl9ldmVudF9hdHRyOjpleGNsdWRlX2hvc3Q9MCwNCj4gPiBldmVuIGlm
IHBlcmZfZXZlbnRfYXR0cjo6ZXhjbHVkZV9rZXJuZWw9MSAod2hpY2ggSSBhZ3JlZSBpcyBzdXJw
cmlzaW5nKSwgc28gSQ0KPiA+IHRoaW5rIHdoYXQncyBoYXBwZW5pbmcgaXMgdGhlIGNvdW50ZXJz
IGFyZSBjb3VudGluZyBpbiB0aGUgaG9zdCBrZXJuZWwsIHdoaWNoDQo+ID4gaXNuJ3Qgd2hhdCBS
UiBhY3R1YWxseSB3YW50cyByZWdhcmRsZXNzLg0KPg0KPiA+IEknbGwgY29udGludWUgdG8gbG9v
ayBhdCB3aGF0IHdlIGNhbiBkbyBrZXJuZWwtc2lkZSwgYnV0IEkgcmVja29uIGl0J3Mgd29ydGgN
Cj4gPiBoYXZpbmcgUlIgdHJ5IHRoZSBvdGhlciBleGNsdWRlIGJpdHMgcmVnYXJkbGVzcywgaWYg
dGhhdCdzIHBvc3NpYmxlPyBJdCB3b3VsZA0KPiA+IGJlIGludGVyZXN0aW5nIHRvIGtub3cgd2hl
dGhlciB0aGF0IGhlbHBzIHlvdSB1bmRlciBhIGh5cGVydmlzb3IuDQo+DQo+IFNvcnJ5LCB0aGUg
YWJvdmUgaXMgd3JvbmcsIGFuZCBJIGRvIG5vdCByZWNvbW1lbmQgUlIgZ29lcyBhbmQgY2hhbmdl
cyBpdHMNCj4gZXhjbHVkZV8qIHNldHRpbmdzLg0KPg0KPiBJIGhhZCBtaXNyZWFkIHRoZSBsb2dp
YyBpbiBhcm12OHBtdV9zZXRfZXZlbnRfZmlsdGVyKCksIGJ1dCBsb29raW5nIGFnYWluDQo+IHRo
YXQncyBzYW5lciB0aGFuIEkgdGhvdWdodCBpdCB3YXMsIGFuZCB3aGF0IHdhcyBhY3R1YWxseSBo
YXBwZW5pbmcgaW4gbXkNCj4gdGVzdGluZyBpcyB0aGF0IGV4Y2x1ZGVfaG9zdCBhbHNvIGZpbHRl
cmVkIGhvc3QgRUwwICh1c2Vyc3BhY2UpLCBhbmQgc28gdGhlDQo+IHRlc3QgcmVjZWl2ZWQgKm5v
KiBvdmVyZmxvdyBzaWduYWxzLg0KPg0KPiBJJ2xsIGdldCBiYWNrIHRvIGxvb2tpbmcgYXQgaG93
IHdlIGNhbiBiZXR0ZXIgY2FwdHVyZSB0aGUgb3ZlcmZsb3cgd2hlbg0KPiByZW1vdmluZyBhbiBl
dmVudC4NCg0KDQpJJ3ZlIHNwZW50IGEgY291cGxlIG9mIGRheXMgb24gdGhpcywgYW5kIEkgaGF2
ZSBhIHByb3RvdHlwZSBhdDoNCg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9tYXJrL2xpbnV4LmdpdC9sb2cvP2g9cGVyZi9vdmVyZmxvdyA8aHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbWFyay9saW51eC5naXQv
bG9nLz9oPXBlcmYvb3ZlcmZsb3c+DQoNCg0KVGhlIGdpc3Qgb2YgdGhhdCBpczoNCg0KDQoqIEl0
J3Mgbm90IHZpYWJsZSB0byBzYW1wbGUgYXQgc3RhcnQvc3RvcCB0aW1lIHNpbmNlIHdlIGRvbid0
IGhhdmUgYWxsIHRoZQ0KdXN1YWwgc2FtcGxlIHN0YXRlIChlLmcuIHB0X3JlZ3MpLCB3aGljaCBt
ZWFucyB0aGF0IHdlIGhhdmUgdG8gc2F2ZS9yZXN0b3JlDQp0aGUgb3ZlcmZsb3cgc3RhdHVzIGFu
ZCByZWx5IG9uIHRoZSByZWd1bGFyIGludGVycnVwdCBoYW5kbGVyIHRvIGFjdHVhbGx5DQpzYW1w
bGUgYWZ0ZXIgdGhpcyBpcyByZXN0b3JlZC4NCg0KDQoqIFNhdmluZy9yZXN0b3JpbmcgdGhlIG92
ZXJmbG93IHN0YXR1cyByZXF1aXJlcyByZXdvcmtpbmcgdGhlIHdheSB3ZSBtYW5hZ2UgdGhlDQpz
YW1wbGUgcGVyaW9kLCBzZXBhcmF0aW5nIHRoZSBzYW1wbGUgcGVyaW9kIGZyb20gdGhlIHBlcmlv
ZCB3ZSBwcm9ncmFtIGludG8NCkhXLiBUaGlzIHBhcnQgbG9va3MgZmFpcmx5IHNhbmUsIGJ1dCBy
ZXF1aXJlcyBzb21lIHJld29yayBvZiBhbGwgdGhlIGFybV9wbXUNCmRyaXZlcnMuDQoNCg0KKiBX
ZSBtaWdodCBuZWVkIGEgY291cGxlIG9mIHNtYWxsIGNoYW5nZXMgdG8gdGhlIHBlcmYgY29yZSBj
b2RlIChlLmcuIGZvciB0aGUNCklPQ1RMcyB0aGF0IG1lc3Mgd2l0aCB0aGUgcGVyaW9kKSwgYW5k
IHRoaXMgY2hhbmdlIGlzIGxpYWJsZSB0byBhZmZlY3Qgb3RoZXINCmFyY2hpdGVjdHVyZXMsIHNv
IHdlJ2QgbmVlZCBvdCBnbyBhdWRpdCB0aGF0Lg0KDQoNCkkgcmVja29uIGl0J3MgcG9zc2libGUg
KHdpdGggc29tZSB0ZXN0aW5nIGFuZCByZXZpZXcpIHRvIGdldCBzb21ldGhpbmcgbGlrZQ0KdGhp
cyBzZXJpZXMgbWVyZ2VkLCBidXQgSSBzdXNwZWN0IGl0J3MgdG9vIGJpZyBmb3IgYSBzdGFibGUg
YmFja3BvcnQuDQoNCg0KTWFyay4NCg0KDQoNCg==
