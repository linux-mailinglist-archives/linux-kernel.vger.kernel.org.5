Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38C8013C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379557AbjLAT5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379538AbjLAT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:57:01 -0500
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB71D67;
        Fri,  1 Dec 2023 11:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1701460627; x=1732996627;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=Uj8bKifa26gnIlQSOVHFN01HeEzHjOhocCDubM0e1cM=;
  b=VDmIZVOvjxeDqghgiAaf5lZRTSXYXgpWKf8MhT7UVFHuD250MrJi3yCb
   KznONtrTUZsANbh96m5HHCTDiW8OZPLAPvm2Lq7hIKZ8/WNXOHj8P4xzR
   PbHXBVeKEZMjkq2Yln5EA8OOkfzDjlPzemAyzVffkst7HdP0vWcuU08hb
   A=;
X-IronPort-AV: E=Sophos;i="6.04,242,1695686400"; 
   d="scan'208";a="688415242"
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of
 boot_cpu_data
Thread-Topic: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of
 boot_cpu_data
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 19:57:02 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 32B1960A29;
        Fri,  1 Dec 2023 19:57:01 +0000 (UTC)
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:1828]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.215:2525] with esmtp (Farcaster)
 id faed7ec1-6af6-4709-84ab-1164c5da6269; Fri, 1 Dec 2023 19:57:00 +0000 (UTC)
X-Farcaster-Flow-ID: faed7ec1-6af6-4709-84ab-1164c5da6269
Received: from EX19D002EUA002.ant.amazon.com (10.252.50.7) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 19:57:00 +0000
Received: from EX19D002EUA002.ant.amazon.com (10.252.50.7) by
 EX19D002EUA002.ant.amazon.com (10.252.50.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 19:57:00 +0000
Received: from EX19D002EUA002.ant.amazon.com ([fe80::a708:6a5c:975:3346]) by
 EX19D002EUA002.ant.amazon.com ([fe80::a708:6a5c:975:3346%3]) with mapi id
 15.02.1118.040; Fri, 1 Dec 2023 19:56:59 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     Tony Luck <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Thread-Index: AQHaJEjWfAgkDgnEVkK4Zlck/+HmLLCUyEuAgAAg/YA=
Date:   Fri, 1 Dec 2023 19:56:59 +0000
Message-ID: <5A9651E8-AB49-4B8E-9B98-65708E8E8E4E@amazon.de>
References: <20231201112327.42319-1-sironi@amazon.de>
 <ZWos70EKhlAl2VPb@agluck-desk3>
In-Reply-To: <ZWos70EKhlAl2VPb@agluck-desk3>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <53BF3BA2D0890E409D311B9908B19ADB@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIERlYyAwMSwgMjAyMyBhdCAxMToyMzoyN0FNICswMDAwLCBGaWxpcHBvIFNpcm9u
aSB3cm90ZToNCj4+IENvbW1pdCBmYTk0ZDBjNmUwZjMgKCJ4ODYvTUNFOiBTYXZlIG1pY3JvY29k
ZSByZXZpc2lvbiBpbiBtYWNoaW5lIGNoZWNrDQo+PiByZWNvcmRzIikgZXh0ZW5kZWQgTUNFIGVu
dHJpZXMgdG8gcmVwb3J0IHRoZSBtaWNyb2NvZGUgcmV2aXNpb24gdGFrZW4NCj4+IGZyb20gYm9v
dF9jcHVfZGF0YS4gVW5mb3J0dW5hdGVseSwgYm9vdF9jcHVfZGF0YSBpc24ndCB1cGRhdGVkIG9u
IGxhdGUNCj4+IG1pY3JvY29kZSBsb2FkaW5nLCB0aHVzIG1ha2luZyBNQ0UgZW50cmllcyBzbGln
aHRseSBpbmNvcnJlY3QuIFVzZQ0KPg0KPiBUaGlzIGNvZGUgaW4gaW50ZWwuYzphcHBseV9taWNy
b2NvZGVfbGF0ZSgpIGxvb2tzIGxpa2UgaXQgdHJpZXMgdG8gdXBkYXRlDQo+IGJvb3RfY3B1X2Rh
dGE6DQo+DQo+DQo+IDQ2NiBjcHVfZGF0YShjcHUpLm1pY3JvY29kZSA9IHVjaS0+Y3B1X3NpZy5y
ZXY7DQo+IDQ2NyBpZiAoIWNwdSkNCj4gNDY4IGJvb3RfY3B1X2RhdGEubWljcm9jb2RlID0gdWNp
LT5jcHVfc2lnLnJldjsNCj4NCj4NCj4gSXMgdGhhdCBub3Qgd29ya2luZyBmb3Igc29tZSByZWFz
b24/DQoNCkl0IGlzLi4uIEkgaGFkIHRoaXMgY2hhbmdlIGluIG91ciB0cmVlIGZvciBhIGxvbmcg
bG9uZyB3aGlsZSBhbmQganVzdA0KcmVhbGl6ZWQgdGhhdCB0aGUgaXNzdWUgb2YgYm9vdF9jcHVf
ZGF0YSBub3QgYmVpbmcgdXBkYXRlZCB3YXMgYWRkcmVzc2VkDQp3aXRoIGNvbW1pdCAzNzBhMTMy
YmIyMjIgKCJ4ODYvbWljcm9jb2RlOiBNYWtlIHN1cmUNCmJvb3RfY3B1X2RhdGEubWljcm9jb2Rl
IGlzIHVwLXRvLWRhdGUiKS4NCg0KPj4gY3B1X2RhdGEgaW5zdGVhZCwgd2hpY2ggaXMgdXBkYXRl
ZCBvbiBsYXRlIG1pY3JvY29kZSBsb2FkaW5nLiBUaGlzIGFsc28NCj4+IGZpeGVzIHRoZSBjb3Ju
ZXIgY2FzZSBpbiB3aGljaCB0aGUgbWljcm9jb2RlIHJldmlzaW9uIGlzbid0IGNvaGVyZW50DQo+
PiBhY3Jvc3MgQ1BVcyAod2hpY2ggbWF5IGhhcHBlbiBvbiBsYXRlIG1pY3JvY29kZSBsb2FkaW5n
IGZhaWx1cmUpLg0KPg0KPg0KPiBCdXQgdGhpcyBkb2VzIHNlZW0gYSB3b3J0aHdoaWxlIGNoYW5n
ZSB0byBoZWxwIGRpYWdub3NlIHRoaW5ncyBpZiBsYXRlDQo+IGxvYWQgaXMgc29tZWhvdyBvbmx5
IGFwcGxpZWQgdG8gc29tZSBzdWJzZXQgb2YgQ1BVcy4NCg0KWWVzLCBidXQsIGFzIEJvcmlzIHBv
aW50cyBvdXQ6DQoNCj4+IEJ1dCB0aGlzIGRvZXMgc2VlbSBhIHdvcnRod2hpbGUgY2hhbmdlIHRv
IGhlbHAgZGlhZ25vc2UgdGhpbmdzIGlmIGxhdGUNCj4+IGxvYWQgaXMgc29tZWhvdyBvbmx5IGFw
cGxpZWQgdG8gc29tZSBzdWJzZXQgb2YgQ1BVcy4NCj4gDQo+IFdlIGFscmVhZHkgZG8gdGhhdCwg
c2VlIGxvYWRfbGF0ZV9zdG9wX2NwdXMoKS4NCg0KQm9yaXMsIEkganVzdCB0b29rIGEgcXVpY2sg
bG9vayBhbmQgSSBtaWdodCBiZSBtaXNzaW5nIHNvbWV0aGluZy4gSWYgY29yZXMNCmZhaWwgdG8g
bG9hZCB0aGUgbWljcm9jb2RlIG9yIHRpbWVvdXQsIHdlIHRhaW50IHRoZSBrZXJuZWwsIHByaW50
IGFuIGVycm9yDQptZXNzYWdlLCBhbmQgdGhlbiBidWJibGUgdXAgYW4gZXJyb3IgdG8gdXNlcnNw
YWNlIHZpYToNCg0KbG9hZF9sYXRlX3N0b3BfY3B1cw0KbG9hZF9sYXRlX2xvY2tlZA0KcmVsb2Fk
X3N0b3JlDQoNClJpZ2h0Pw0KDQpXZSB3b3VsZCB0YWtlIHNlcnZlcnMgdGhhdCBmYWlsIG91dCBv
ZiBwcm9kdWN0aW9uOyBob3dldmVyLCBmb3Igb3RoZXJzIGl0IG1pZ2h0DQpiZSBpbnRlcmVzdGlu
ZyB0byBoYXZlIHRoZSBjb3JyZWN0IGluZm9ybWF0aW9uLiBUaGUgcGF0Y2ggLSB3aXRoIGEgcmV3
b3JrZWQNCmNvbW1pdCBtZXNzYWdlIC0gbWlnaHQgc3RpbGwgYmUgdXNlZnVsIHRvIGEgZmV3LiAN
Cg0KRmlsaXBwbw0KDQoNCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJI
CktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlh
biBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENo
YXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAy
ODkgMjM3IDg3OQoKCg==

