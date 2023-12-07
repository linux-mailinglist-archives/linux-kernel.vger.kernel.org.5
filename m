Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D65808647
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378718AbjLGJet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378575AbjLGJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:34:47 -0500
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F143D131;
        Thu,  7 Dec 2023 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1701941695; x=1733477695;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=QRx5pk8Ylwtmq8GeK86vt+ejBZO09S9V6TzcZd1CIuU=;
  b=khg3/CotCnjlArn0nEhcoVa9xXscMAmiDeJ5/SD/Fmcao7rDhTHa9qgi
   a7M0553j9Dv8FAxORrFneeOGHlwJeJDayHNUo4f5A65ZyzMY8zGvvGgpG
   O1vOIPqBnir0SAEk6dTWf12DIcbRSGGQDz+mnHMPvuAZKyVBKqBSu6JPc
   s=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="599205647"
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of
 boot_cpu_data
Thread-Topic: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of
 boot_cpu_data
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 09:34:52 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id B2D5C497E3;
        Thu,  7 Dec 2023 09:34:48 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:28748]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.96:2525] with esmtp (Farcaster)
 id 536af5d6-ba43-4e2d-99b3-39a2a122843c; Thu, 7 Dec 2023 09:34:47 +0000 (UTC)
X-Farcaster-Flow-ID: 536af5d6-ba43-4e2d-99b3-39a2a122843c
Received: from EX19D002EUA003.ant.amazon.com (10.252.50.18) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 09:34:42 +0000
Received: from EX19D002EUA002.ant.amazon.com (10.252.50.7) by
 EX19D002EUA003.ant.amazon.com (10.252.50.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 09:34:42 +0000
Received: from EX19D002EUA002.ant.amazon.com ([fe80::a708:6a5c:975:3346]) by
 EX19D002EUA002.ant.amazon.com ([fe80::a708:6a5c:975:3346%3]) with mapi id
 15.02.1118.040; Thu, 7 Dec 2023 09:34:42 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
CC:     Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Thread-Index: AQHaJEjWfAgkDgnEVkK4Zlck/+HmLLCUyEuAgAAg/YCAB923gIAA4mkA
Date:   Thu, 7 Dec 2023 09:34:42 +0000
Message-ID: <0A46F54F-CEF5-42EE-8A95-F442FAD7A05D@amazon.de>
References: <20231201112327.42319-1-sironi@amazon.de>
 <ZWos70EKhlAl2VPb@agluck-desk3>
 <5A9651E8-AB49-4B8E-9B98-65708E8E8E4E@amazon.de>
 <20231206210421.GFZXDh1UQ7L8K/toOM@fat_crate.local>
In-Reply-To: <20231206210421.GFZXDh1UQ7L8K/toOM@fat_crate.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.213.9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B9A07FEE1C9A442B358B8979E89842A@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
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

PiA+IEJvcmlzLCBJIGp1c3QgdG9vayBhIHF1aWNrIGxvb2sgYW5kIEkgbWlnaHQgYmUgbWlzc2lu
ZyBzb21ldGhpbmcuIElmIGNvcmVzDQo+ID4gZmFpbCB0byBsb2FkIHRoZSBtaWNyb2NvZGUgb3Ig
dGltZW91dCwgd2UgdGFpbnQgdGhlIGtlcm5lbCwgcHJpbnQgYW4gZXJyb3INCj4gPiBtZXNzYWdl
LCBhbmQgdGhlbiBidWJibGUgdXAgYW4gZXJyb3IgdG8gdXNlcnNwYWNlIHZpYToNCj4gPg0KPiA+
IGxvYWRfbGF0ZV9zdG9wX2NwdXMNCj4gPiBsb2FkX2xhdGVfbG9ja2VkDQo+ID4gcmVsb2FkX3N0
b3JlDQo+ID4NCj4gPiBSaWdodD8NCj4gDQo+IFlhcC4NCj4gDQo+ID4gV2Ugd291bGQgdGFrZSBz
ZXJ2ZXJzIHRoYXQgZmFpbCBvdXQgb2YgcHJvZHVjdGlvbjsNCj4gDQo+IEFuZCBJJ2QgbGlrZSB0
byBoZWFyIGFib3V0IHN1Y2ggaXNzdWVzLiBXZSBhZGRlZCB0aGlzIGZhaWx1cmUgY2hlY2tpbmcN
Cj4gb25seSByZWNlbnRseSBiZWNhdXNlIHNvbWV0aGluZyBtaWdodCBnbyB3cm9uZyBhbmQgd2Ug
d2FudCB0byB3YXJuLiBCdXQNCj4gaXQgYWxsIHVwZGF0ZXMgZmluZSBoZXJlIHNvIGtpbmRhIGhh
cmQgdG8gdGVzdC4NCg0KSW4gYSB2ZXJ5IGxhcmdlIGZsZWV0LCBsZXQncyBzYXkgdGhhdCB3ZSBo
YXZlIGEgaGFuZGZ1bCBvZiBEUE1zIHdoZW4gY29uc2lkZXJpbmcNCnRoZSBlbnRpcmUgcHJvY2Vz
c29yLCB3aGljaCBtZWFucyB0aGF0IGluIHRlcm1zIG9mIGNvcmVzLCB0aGUgZGVmZWN0IHJhdGUg
aXMNCm11Y2ggbXVjaCBsb3dlci4NCg0KV2hhdCB3ZSd2ZSBzZWVuIGluIHRoZXNlIGNhc2VzIGlz
IHRoYXQgZWFybHkgbG9hZGluZyAtIHRocm91Z2ggdGhlIEJJT1MsIEkNCmFjdHVhbGx5IG5ldmVy
IHRyaWVkIHZpYSB0aGUgaHlwZXJ2aXNvciAtIGlzIHN1Y2Nlc3NmdWwgd2hpbGUgbGF0ZSBsb2Fk
aW5nDQpjb25zaXN0ZW50bHkgZmFpbHMuIFdoZW4gaXQgZmFpbHMsIHdlJ3ZlIHNlZW4gdHdvIGNh
c2VzOiAxLyB0aGUgY29yZSBzdGlsbA0KcmVwb3J0cyB0aGUgb2xkIG1pY3JvY29kZSB2ZXJzaW9u
IG9yIDIvIHRoZSBjb3JlIHJlcG9ydHMgYSBib2d1cyBtaWNyb2NvZGUNCnZlcnNpb24gKDB4ZmZm
ZmZmZmUgaXMgcXVpdGUgY29tbW9uLCBhdCBsZWFzdCBvbiBJbnRlbCkuDQoNCj4gTXkgZXhwZWN0
YXRpb24gaXMgdGhhdCBpZiBtaWNyb2NvZGUgZmFpbHMgbG9hZGluZyBvbiBhIHN1YnNldCBvZg0K
PiBtYWNoaW5lcywgdGhlIG1hY2hpbmUgd291bGQgbW9yZSBvciBsZXNzIGZyZWV6ZS4gRGVwZW5k
aW5nLCBvZmMsIG9uIHdoYXQNCj4gdGhlIG1pY3JvY29kZSBpcyB1cGRhdGluZy4uLg0KDQpJdCdz
IGJpLW1vZGFsLiBXZSd2ZSBzZWVuIHNlcnZlcnMgdGhhdCBtb3ZlIGFsb25nIHRpbGwgd2UgdGFr
ZSB0aGVtIG91dCBvZg0KcHJvZHVjdGlvbiBhcyB3ZWxsIGFzIHNlcnZlcnMgdGhhdCBmYWlsIHdp
dGggYW4gTUNFIG9mIHNvbWUgc29ydCBsaWtlbHkgbGVhZGluZw0KdG8gYSBDQVRFUlIvSUVSUi4N
Cg0KPiA+IGhvd2V2ZXIsIGZvciBvdGhlcnMgaXQgbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8gaGF2
ZSB0aGUgY29ycmVjdA0KPiA+IGluZm9ybWF0aW9uLiBUaGUgcGF0Y2ggLSB3aXRoIGEgcmV3b3Jr
ZWQgY29tbWl0IG1lc3NhZ2UgLSBtaWdodCBzdGlsbA0KPiA+IGJlIHVzZWZ1bCB0byBhIGZldy4N
Cj4gDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMxMTE4MTkzMjQ4LjEyOTY3
OTgtMy15YXplbi5naGFubmFtQGFtZC5jb20gPG1haWx0bzoyMDIzMTExODE5MzI0OC4xMjk2Nzk4
LTMteWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiANCj4gDQo+IDopDQoNCjpsb29raW5nOg0KDQoK
CgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAox
MDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25h
dGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRl
ciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

