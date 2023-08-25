Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E8E7888BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbjHYNde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245079AbjHYNdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:02 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F51FDE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692970378; x=1724506378;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=xm4mp11fH56Iknbn52LO7LPbxnqh0a8m/Mw9YaYqz3I=;
  b=NX9VhBhD2xp71kHjdiWejK+vffwK/vO6/Am6lVO0ixfIuz6O2CXIpVuZ
   X67v9URJ2yeEOabFtLa/EP04uL+ZBocO3YxflgI3dnwNDeFbmIDzMbN1C
   NWLuwDyASWYclIJBuMtmpTiCfrXPmqHCevjv4XoNo3Osr8fkq9f/B7YiX
   Y=;
X-IronPort-AV: E=Sophos;i="6.02,195,1688428800"; 
   d="scan'208";a="25082614"
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Thread-Topic: [RFC PATCH] Introduce persistent memory pool
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 13:32:54 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 7276D474F1;
        Fri, 25 Aug 2023 13:32:49 +0000 (UTC)
Received: from EX19D020UWA001.ant.amazon.com (10.13.138.249) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 25 Aug 2023 13:32:42 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D020UWA001.ant.amazon.com (10.13.138.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 25 Aug 2023 13:32:41 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.037; Fri, 25 Aug 2023 13:32:40 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC:     "rppt@kernel.org" <rppt@kernel.org>,
        "madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
        "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "stanislav.kinsburskii@gmail.com" <stanislav.kinsburskii@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>
Thread-Index: AQHZ1yrcJsxE6GCz7Ema1+/dGlQlg6/7AuaA
Date:   Fri, 25 Aug 2023 13:32:40 +0000
Message-ID: <c26ad989dcc6737dd295e980c78ef53740098810.camel@amazon.com>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
         <2023082506-enchanted-tripping-d1d5@gregkh>
In-Reply-To: <2023082506-enchanted-tripping-d1d5@gregkh>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F17C09168C048D47A849ABA93FEF2971@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDEwOjA1ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQoNClRoYW5rcyBmb3IgYWRkaW5nIG1lIHRvIHRoaXMgdGhyZWFkIEdyZWchDQoNCj4gT24g
VHVlLCBBdWcgMjIsIDIwMjMgYXQgMTE6MzQ6MzRBTSAtMDcwMCwgU3RhbmlzbGF2IEtpbnNidXJz
a2lpIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcmVzc2VzIHRoZSBuZWVkIGZvciBhIG1lbW9y
eSBhbGxvY2F0b3IgZGVkaWNhdGVkIHRvDQo+ID4gcGVyc2lzdGVudCBtZW1vcnkgd2l0aGluIHRo
ZSBrZXJuZWwuIFRoaXMgYWxsb2NhdG9yIHdpbGwgcHJlc2VydmUNCj4gPiBrZXJuZWwtc3BlY2lm
aWMgc3RhdGVzIGxpa2UgRE1BIHBhc3N0aHJvdWdoIGRldmljZSBzdGF0ZXMsIElPTU1VIHN0YXRl
LCBhbmQNCj4gPiBtb3JlIGFjcm9zcyBrZXhlYy4NCj4gPiBUaGUgcHJvcG9zZWQgc29sdXRpb24g
b2ZmZXJzIGEgZm91bmRhdGlvbmFsIGltcGxlbWVudGF0aW9uIGZvciBwb3RlbnRpYWwNCj4gPiBj
dXN0b20gc29sdXRpb25zIHRoYXQgbWlnaHQgZm9sbG93LiBUaG91Z2ggdGhlIGltcGxlbWVudGF0
aW9uIGlzDQo+ID4gaW50ZW50aW9uYWxseSBrZXB0IGNvbmNpc2UgYW5kIHN0cmFpZ2h0Zm9yd2Fy
ZCB0byBmb3N0ZXIgZGlzY3Vzc2lvbiBhbmQNCj4gPiBmZWVkYmFjaywgaXQncyBmdWxseSBmdW5j
dGlvbmFsIGluIGl0cyBjdXJyZW50IHN0YXRlLg0KDQpIaSBTdGFuaXNsYXYsIGl0IGxvb2tzIGxp
a2Ugd2UncmUgd29ya2luZyBvbiBzaW1pbGFyIHRoaW5ncy4gSSdtIGxvb2tpbmcNCnRvIGRldmVs
b3AgYSBtZWNoYW5pc20gdG8gc3VwcG9ydCBoeXBlcnZpc29yIGxpdmUgdXBkYXRlIGZvciB3aGVu
IEtWTSBpcw0KcnVubmluZyBWTXMgd2l0aCBQQ0kgZGV2aWNlIHBhc3N0aHJvdWdoLiBWTXMgd2l0
aCBkZXZpY2UgcGFzc3Rocm91Z2gNCmFsc28gbmVjZXNzaXRhdGVzIHBhc3NpbmcgYW5kIHJlLWh5
ZHJhdGluZyBJT01NVSBzdGF0ZSBzbyB0aGF0IERNQSBjYW4NCmNvbnRpbnVlIGR1cmluZyBsaXZl
IHVwZGF0ZS4NCg0KUGxhbm5pbmcgb24gaGF2aW5nIGFuIExQQyBzZXNzaW9uIG9uIHRoaXMgdG9w
aWM6DQpodHRwczovL2xwYy5ldmVudHMvZXZlbnQvMTcvYWJzdHJhY3RzLzE2MjkvIChjdXJyZW50
bHkgaXQncyBvbmx5IGENCnN1Ym1pdHRlZCBhYnN0cmFjdCBzbyBub3Qgc3VyZSBpZiB2aXNpYmxl
LCBob3BlZnVsbHkgaXQgd2lsbCBiZSBzb29uKS4NCg0KV2UgYXJlIGxvb2tpbmcgYXQgaW1wbGVt
ZW50aW5nIHBlcnNpc3RlbmNlIGFjcm9zcyBrZXhlYyB2aWEgYW4gaW4tbWVtb3J5DQpmaWxlc3lz
dGVtIG9uIHRvcCBvZiByZXNlcnZlZCBtZW1vcnkuIFRoaXMgd291bGQgaGF2ZSBmaWxlcyBmb3Ig
YW55dGhpbmcNCnRoYXQgbmVlZHMgdG8gYmUgcGVyc2lzdGVkLiBUaGF0IGluY2x1ZGVzIGZpbGVz
IGZvciBJT01NVSBwZ3RhYmxlcywgZm9yDQpndWVzdCBtZW1vcnkgb3IgdXNlcnNwYWNlLWFjY2Vz
c2libGUgbWVtb3J5LiANCg0KSXQgbWF5IGJlIG5pY2UgdG8gc29sdmUgYWxsIGtleGVjIHBlcnNp
c3RlbmNlIHJlcXVpcmVtZW50cyB3aXRoIG9uZQ0Kc29sdXRpb24sIGJ1dCB3ZSBjYW4gY29uc2lk
ZXIgSU9NTVUgc2VwYXJhdGVseS4gVGhlcmUgYXJlIGF0IGxlYXN0IHRocmVlDQp3YXlzIHRoYXQg
dGhpcyBjYW4gYmUgZG9uZToNCmEpIGNhcnZpbmcgb3V0IHJlc2VydmVkIG1lbW9yeSBmb3IgcGd0
YWJsZXMuIFRoaXMgaXMgZG9uZSBieSB5b3VyDQpwcm9wb3NhbCBoZXJlLCBhcyB3ZWxsIGFzIG15
IHN1Z2dlc3Rpb24gb2YgYSBmaWxlc3lzdGVtLg0KYikgcHJlL3Bvc3Qga2V4ZWMgaG9va3MgZm9y
IGRyaXZlcnMgdG8gc2VyaWFsaXNlIHN0YXRlIGFuZCBwYXNzIGl0DQphY3Jvc3MgaW4gYSBzdHJ1
Y3R1cmVkIGZvcm1hdCBmcm9tIG9sZCB0byBuZXcga2VybmVsLg0KYykgUmVjb25zdHJ1Y3Rpbmcg
SU9NTVUgc3RhdGUgaW4gdGhlIG5ldyBrZXJuZWwgYnkgc3RhcnRpbmcgYXQgdGhlDQpoYXJkd2Fy
ZSByZWdpc3RlcnMgYW5kIHdhbGtpbmcgdGhlIHBhZ2UgdGFibGVzLiBObyBzdGF0ZSBwYXNzaW5n
IG5lZWRlZC4NCg0KSGF2ZSB5b3UgY29uc2lkZXJlZCBvcHRpb24gKGIpIGFuZCAoYykgaGVyZT8g
T25lIG9mIHRoZSBpbXBsaWNhdGlvbnMgb2YNCihiKSBhbmQgKGMpIGFyZSB0aGF0IHRoZXkgd291
bGQgbmVlZCB0byBob29rIGludG8gdGhlIGJ1ZGR5IGFsbG9jYXRvcg0KcmVhbGx5IGVhcmx5IHRv
IGJlIGFibGUgdG8gY2FydmUgb3V0IHRoZSByZWNvbnN0cnVjdGVkIHBhZ2UgdGFibGVzDQpiZWZv
cmUgdGhlIGFsbG9jYXRvciBpcyB1c2VkLiBTaW1pbGFyIHRvIGhvdyBwa3JhbSBbMF0gaG9va3Mg
aW4gZWFybHkgdG8NCmNhcnZlIG91dCBwYWdlcyB1c2VkIGZvciBpdHMgZmlsZXN5c3RlbS4NCg0K
PiANCj4gPiANCj4gPiBQb3RlbnRpYWwgYXBwbGljYXRpb25zIGluY2x1ZGU6DQo+ID4gDQo+ID4g
ICAxLiBBbGxvd2luZyB2YXJpb3VzIGluLWtlcm5lbCBlbnRpdGllcyB0byBhbGxvY2F0ZSBwZXJz
aXN0ZW50IHBhZ2VzIGZyb20NCj4gPiAgICAgIGEgc2luZ3VsYXIgbWVtb3J5IHBvb2wsIGVsaW1p
bmF0aW5nIHRoZSBuZWVkIGZvciBtdWx0aXBsZSByZWdpb24NCj4gPiAgICAgIHJlc2VydmF0aW9u
cy4NCj4gPiANCj4gPiAgIDIuIEZvciBpbi1rZXJuZWwgY29tcG9uZW50cyB0aGF0IHJlcXVpcmUg
dGhlIGFsbG9jYXRpb24gYWRkcmVzcyB0byBiZQ0KPiA+ICAgICAgYXZhaWxhYmxlIG9uIGtlcm5l
bCBrZXhlYywgdGhpcyBhZGRyZXNzIGNhbiBiZSBleHBvc2VkIHRvIHVzZXIgc3BhY2UgYW5kDQo+
ID4gICAgICB0aGVuIHBhc3NlZCB2aWEgdGhlIGNvbW1hbmQgbGluZS4NCg0KRG8geW91IGhhdmUg
c3BlY2lmaWMgZXhhbXBsZXMgb2Ygb3RoZXIgc3RhdGUgdGhhdCBuZWVkcyB0byBiZSBwYXNzZWQN
CmFjcm9zcz8gVHJ5aW5nIHRvIHNlZSB3aGV0aGVyIHRhaWxvcmluZyBzcGVjaWZpY2FsbHkgdG8g
dGhlIElPTU1VIGNhc2UNCmlzIG9rYXkuIENvbmNlcHR1YWxseSBJT01NVSBzdGF0ZSBjYW4gYmUg
cmVjb25zdHJ1Y3RlZCBzdGFydGluZyB3aXRoDQpoYXJkd2FyZSByZWdpc3RlcnMsIG5vdCBuZWVk
aW5nIHJlc2VydmVkIG1lbW9yeS4gT3RoZXIgdXNlLWNhc2VzIG1heSBub3QNCmhhdmUgdGhpcyBv
cHRpb24uDQoNCj4gDQo+IEFzIHlvdSBoYXZlIG5vIGluLWtlcm5lbCB1c2VycyBvZiB0aGlzLCBp
dCdzIG5vdCBzb21ldGhpbmcgd2UgY2FuIGV2ZW4NCj4gY29uc2lkZXIgYXQgdGhlIG1vbWVudCBm
b3Igb2J2aW91cyByZWFzb25zIChuZWl0aGVyIHdvdWxkIHlvdSB3YW50IHVzDQo+IHRvLikNCj4g
DQo+IENhbiB5b3UgbWFrZSB0aGlzIHBhcnQgb2YgYSBwYXRjaCBzZXJpZXMgdGhhdCBhY3R1YWxs
eSBhZGRzIGEgdXNlciwNCj4gcHJvYmFibHkgbW9yZSB0aGFuIG9uZSwgc28gdGhhdCB3ZSBjYW4g
c2VlIGlmIGFueSBvZiB0aGlzIGV2ZW4gbWFrZXMNCj4gc2Vuc2U/DQoNCkknbSB2ZXJ5IGtlZW4g
dG8gc2VlIHRoaXMgYXMgd2VsbC4gVGhlIHdheSB0aGF0IHRoZSBJT01NVSBkcml2ZXJzIGFyZQ0K
ZW5saWdodGVuZWQgdG8gaG9vayBpbnRvIHlvdXIgbWVtb3J5IHBvb2wgd2lsbCBsaWtlbHkgYmUg
c2ltaWxhciB0byBob3cNCnRoZXkgd291bGQgaG9vayBpbnRvIG15IHByb3Bvc2FsIG9mIGFuIGlu
LW1lbW9yeSBmaWxlc3lzdGVtLg0KRG8geW91IGhhdmUgY29kZSBhdmFpbGFibGUgc2hvd2luZyB0
aGUgSU9NTVUgaW50ZWdyYXRpb24/IA0KDQo+IA0KPiA+ICBkcml2ZXJzL21pc2MvS2NvbmZpZyAg
IHwgICAgNyArDQo+ID4gIGRyaXZlcnMvbWlzYy9NYWtlZmlsZSAgfCAgICAxDQo+ID4gIGRyaXZl
cnMvbWlzYy9wbXBvb2wuYyAgfCAgMjcwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3BtcG9vbC5oIHwgICAyMCArKysr
DQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjk4IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy9wbXBvb2wuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9saW51eC9wbXBvb2wuaA0KPiANCj4gbWlzYyBpcyBub3QgZm9yIG1lbW9yeSBwb29s
cywgYXMgdGhpcyBpcyBub3QgYSBkcml2ZXIuICBwbGVhc2UgcHV0IHRoaXMNCj4gaW4gdGhlIHBy
b3Blcmx5IGxvY2F0aW9uIGluc3RlYWQgb2YgdHJ5aW5nIHRvIGhpZGUgaXQgZnJvbSB0aGUgbW0N
Cj4gbWFpbnRhaW5lcnMgYW5kIHN1YnN5c3RlbSA6KQ0KDQpPbmUgb2YgdGhlIHJlYXNvbnMgSSB0
aG91Z2h0IGEgcHJvcGVyIGZpbGVzeXN0ZW0gd291bGQgYmUgYSBiZXR0ZXIgd2F5DQpvZiBleHBv
c2luZyB0aGlzIGZ1bmN0aW9uYWxpdHkuDQoNCkpHDQoNCg0KWzBdDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzE2MTcxNDAxNzgtODc3My0xLWdpdC1zZW5kLWVtYWlsLWFudGhvbnkueXpu
YWdhQG9yYWNsZS5jb20vVC8NCg==
