Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641457AA4E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjIUWXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjIUWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:23:14 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE818D;
        Thu, 21 Sep 2023 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695334988; x=1726870988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g7EFafS6t1foqgqAqNV0pkx1nSCq9B41+AoW2S9TWQg=;
  b=o73nLZdi/MWrecxV8pNqzo7Bh/eY728g5Os7fpMYbBETcnCSt533X8Jb
   oEtRIDoLO/NtnCUFE3MKZqP/2KwN83TRKYLIcBV1c5pTeicFhTwrQmJLE
   rrdqc9UAWbnSayHVqJqOh3/+i9lWAnDvTRwIjknxQj6Dt2Qu8UnU5xjin
   4=;
X-IronPort-AV: E=Sophos;i="6.03,166,1694736000"; 
   d="scan'208";a="365147049"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 22:23:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 4099248173;
        Thu, 21 Sep 2023 22:23:02 +0000 (UTC)
Received: from EX19D030UWB004.ant.amazon.com (10.13.139.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 21 Sep 2023 22:22:55 +0000
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19D030UWB004.ant.amazon.com (10.13.139.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 21 Sep 2023 22:22:54 +0000
Received: from EX19D030UWB002.ant.amazon.com ([fe80::8cbd:fcae:56ad:4dfa]) by
 EX19D030UWB002.ant.amazon.com ([fe80::8cbd:fcae:56ad:4dfa%6]) with mapi id
 15.02.1118.037; Thu, 21 Sep 2023 22:22:54 +0000
From:   "Jitindar Singh, Suraj" <surajjs@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "vdonnefort@google.com" <vdonnefort@google.com>,
        "philmd@linaro.org" <philmd@linaro.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "qperret@google.com" <qperret@google.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>
Subject: Re: [PATCH stable 6.1.y 1/2] KVM: arm64: Prevent the donation of
 no-map pages
Thread-Topic: [PATCH stable 6.1.y 1/2] KVM: arm64: Prevent the donation of
 no-map pages
Thread-Index: AQHZ7NoqQQBf46ilGUajYblrTraBLA==
Date:   Thu, 21 Sep 2023 22:22:54 +0000
Message-ID: <a64c30b027951c4c533dea858150e2e807a912b7.camel@amazon.com>
References: <20230920192729.694309-1-surajjs@amazon.com>
         <878r903snv.wl-maz@kernel.org>
In-Reply-To: <878r903snv.wl-maz@kernel.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.187.171.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6192A419174F448B28D39C53A1949A3@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTIxIGF0IDA4OjEzICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIFdlZCwgMjAgU2VwIDIwMjMgMjA6Mjc6MjggKzAxMDAsDQo+IFN1cmFqIEppdGluZGFyIFNp
bmdoIDxzdXJhampzQGFtYXpvbi5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFF1ZW50aW4g
UGVycmV0IDxxcGVycmV0QGdvb2dsZS5jb20+DQo+ID4gDQo+ID4gY29tbWl0IDQzYzFmZjhiNzUw
MTFiYzNlM2U5MjNhZGYzMWJhODE1ODY0YTI0OTQgdXBzdHJlYW0uDQo+ID4gDQo+ID4gTWVtb3J5
IHJlZ2lvbnMgbWFya2VkIGFzICJuby1tYXAiIGluIHRoZSBob3N0IGRldmljZS10cmVlIHJvdXRp
bmVseQ0KPiA+IGluY2x1ZGUgVHJ1c3Rab25lIGNhcmV2LW91dHMgYW5kIERNQSBwb29scy4gQWx0
aG91Z2ggZG9uYXRpbmcgc3VjaA0KPiA+IHBhZ2VzDQo+ID4gdG8gdGhlIGh5cGVydmlzb3IgbWF5
IG5vdCBicmVhY2ggY29uZmlkZW50aWFsaXR5LCBpdCBjb3VsZCBiZSB1c2VkDQo+ID4gdG8NCj4g
PiBjb3JydXB0IGl0cyBzdGF0ZSBpbiB1bmNvbnRyb2xsYWJsZSB3YXlzLiBUbyBwcmV2ZW50IHRo
aXMsIGxldCdzDQo+ID4gYmxvY2sNCj4gPiBob3N0LWluaXRpYXRlZCBtZW1vcnkgdHJhbnNpdGlv
bnMgdGFyZ2V0aW5nICJuby1tYXAiIHBhZ2VzDQo+ID4gYWx0b2dldGhlciBpbg0KPiA+IG5WSEUg
cHJvdGVjdGVkIG1vZGUgYXMgdGhlcmUgc2hvdWxkIGJlIG5vIHZhbGlkIHJlYXNvbiB0byBkbyB0
aGlzDQo+ID4gaW4NCj4gPiBjdXJyZW50IG9wZXJhdGlvbi4NCj4gPiANCj4gPiBUaGFua2Z1bGx5
LCB0aGUgcEtWTSBFTDIgaHlwZXJ2aXNvciBoYXMgYSBmdWxsIGNvcHkgb2YgdGhlIGhvc3Qncw0K
PiA+IGxpc3QNCj4gPiBvZiBtZW1ibG9jayByZWdpb25zLCBzbyB3ZSBjYW4gZWFzaWx5IGNoZWNr
IGZvciB0aGUgcHJlc2VuY2Ugb2YgdGhlDQo+ID4gTUVNQkxPQ0tfTk9NQVAgZmxhZyBvbiBhIHJl
Z2lvbiBjb250YWluaW5nIHBhZ2VzIGJlaW5nIGRvbmF0ZWQgZnJvbQ0KPiA+IHRoZQ0KPiA+IGhv
c3QuDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCj4gPiBUZXN0ZWQtYnk6IFZpbmNlbnQgRG9ubmVmb3J0IDx2ZG9ubmVm
b3J0QGdvb2dsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUXVlbnRpbiBQZXJyZXQgPHFwZXJy
ZXRAZ29vZ2xlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXaWxsIERlYWNvbiA8d2lsbEBrZXJu
ZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+
DQo+ID4gTGluazoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjIxMTEwMTkwMjU5
LjI2ODYxLTgtd2lsbEBrZXJuZWwub3JnDQo+ID4gWyBicDogY2xlYW4gXQ0KPiANCj4gV2hhdCBp
cyB0aGlzPw0KDQpOb3RpbmcgYW55IGRldGFpbHMgYWJvdXQgdGhlIGJhY2twb3J0LiBJbiB0aGlz
IGNhc2UgaXQgd2FzIGEgY2xlYW4NCmJhY2twb3J0Lg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFN1cmFqIEppdGluZGFyIFNpbmdoIDxzdXJhampzQGFtYXpvbi5jb20+DQo+IA0KPiBXaGF0IGlz
IHRoZSByYXRpb25hbGUgZm9yIGJhY2twb3J0aW5nIHRoaXM/IEl0IHdhc24ndCB0YWdnZWQgYXMg
Q2M6DQo+IHRvDQo+IHN0YWJsZSBmb3IgYSByZWFzb246IHBLVk0gaXNuJ3QgZnVuY3Rpb25hbCB1
cHN0cmVhbSwgYW5kIHdvbid0IGJlIGZvcg0KPiB0aGUgbmV4dCBjb3VwbGUgb2YgY3ljbGVzICph
dCBsZWFzdCouDQo+IA0KPiBTbyBhdCBpdCBzdGFuZHMsIEknbSBhZ2FpbnN0IHN1Y2ggYSBiYWNr
cG9ydC4NCj4gDQoNClRoZSAyIHBhdGNoZXMgd2VyZSBiYWNrcG9ydGVkIHRvIGFkZHJlc3MgQ1ZF
LTIwMjMtMjEyNjQuDQpUaGlzIG9uZSBwcm92aWRlcyBjb250ZXh0IGZvciB0aGUgcHJvY2VlZGlu
ZyBwYXRjaC4NCg0KSSB3YXNuJ3QgYXdhcmUgdGhhdCBpdCdzIG5vbiBmdW5jdGlvbmFsLiBEb2Vz
IHRoaXMgbWVhbiB0aGF0IHRoZSBjb2RlDQp3b24ndCBiZSBjb21waWxlZCBvciBqdXN0IHRoYXQg
aXQgY2FuJ3QgYWN0dWFsbHkgYmUgcnVuIGN1cnJlbnRseSBmcm9tDQp0aGUgdXBzdHJlYW0gY29k
ZWJhc2U/DQoNCkkgZ3Vlc3MgSSdtIHRyeWluZyB0byB1bmRlcnN0YW5kIGlmIHRoZSBjb25kaXRp
b25zIG9mIHRoZSBDVkUgYXJlIGENCnJlYWwgY29uY2VybiBldmVuIGlmIGl0IGlzbid0IHRlY2hu
aWNhbGx5IGZ1bmN0aW9uYWwuDQoNClRoYW5rcw0KDQo+IFRoYW5rcywNCj4gDQo+IMKgwqDCoMKg
wqDCoMKgwqBNLg0KPiANCg0K
