Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE67C6CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378247AbjJLLq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347203AbjJLLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:46:27 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28574E5;
        Thu, 12 Oct 2023 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1697111185; x=1728647185;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=iNVreW6kpBcF2Rw8UTi8MbrBudnoAboYpfTCmJWFxPU=;
  b=v5F8o8WByNguI9249guvdZ6cvkrFS4HQTtBjmZuNcKtR6wGxdPdax365
   f/yG/+X+9w8K/N2La0fRHoylnTNacd/zhuEjJ0CO42lhBQpzCa3Kf5L/L
   fJAu/ftIEBM0iyQK8plY2uFoKy5pc4cCABkrY2cxE2+yUeOvZzg/3vlBZ
   M=;
X-IronPort-AV: E=Sophos;i="6.03,218,1694736000"; 
   d="scan'208";a="308379589"
Subject: Re: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8 pages
Thread-Topic: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8 pages
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:46:18 +0000
Received: from EX19D002EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id B68F8806A0;
        Thu, 12 Oct 2023 11:46:14 +0000 (UTC)
Received: from EX19D002EUA002.ant.amazon.com (10.252.50.7) by
 EX19D002EUA003.ant.amazon.com (10.252.50.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 12 Oct 2023 11:46:13 +0000
Received: from EX19D002EUA002.ant.amazon.com ([fe80::a708:6a5c:975:3346]) by
 EX19D002EUA002.ant.amazon.com ([fe80::a708:6a5c:975:3346%3]) with mapi id
 15.02.1118.037; Thu, 12 Oct 2023 11:46:13 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Thread-Index: AQHZ/GCvQiVi6JZ+hUq19ro6H50korBE2SEAgAFTCgA=
Date:   Thu, 12 Oct 2023 11:46:13 +0000
Message-ID: <EDD08AA3-C404-4DB6-96BA-2B25519B2496@amazon.de>
References: <20231011163320.79732-1-sironi@amazon.de>
 <afaef377-25e0-49f6-a99f-3e5bd4b44f87@intel.com>
In-Reply-To: <afaef377-25e0-49f6-a99f-3e5bd4b44f87@intel.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.14]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F21E4E40A116449A1D13E3AAE9C2D36@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTEvMjMgMTk6MzMsIERhdmUgSGFuc2VuIHdyb3RlOiANCj4gT24gMTAvMTEvMjMgMDk6
MzMsIEZpbGlwcG8gU2lyb25pIHdyb3RlOg0KPiA+IE9uIHNvbWUgb2Ygb3VyIGxhcmdlIHNlcnZl
cnMgYW5kIHNvbWUgb2Ygb3VyIG1vc3Qgc29ycnkgc2VydmVycyAoIPCfmYIgKSwNCj4gPiB3ZSdy
ZSBzZWVpbmcgdGhlIGtlcm5lbCByZXBvcnRpbmcgdGhlIHdhcm5pbmcgaW4gbWNlX2dlbl9wb29s
X2FkZDogIk1DRQ0KPiA+IHJlY29yZHMgcG9vbCBmdWxsISIuIExldCdzIGluY3JlYXNlIHRoZSBh
bW91bnQgb2YgbWVtb3J5IHRoYXQgd2UgdXNlIHRvDQo+ID4gc3RvcmUgdGhlIE1DRSByZWNvcmRz
IGZyb20gMiB0byA4IHBhZ2VzIHRvIHByZXZlbnQgdGhpcyBmcm9tIGhhcHBlbmluZw0KPiA+IGFu
ZCBiZSBhYmxlIHRvIGNvbGxlY3QgdXNlZnVsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IE1DRV9Q
T09MU1ogaXMgdXNlZCB0byBzaXplIGdlbl9wb29sX2J1ZltdIHdoaWNoIHdhcyBhIGxpbmUgb3V0
IG9mIHlvdXINCj4gZGlmZiBjb250ZXh0Og0KPiANCj4gDQo+ID4gI2RlZmluZSBNQ0VfUE9PTFNa
ICgyICogUEFHRV9TSVpFKQ0KPiA+DQo+ID4gc3RhdGljIHN0cnVjdCBnZW5fcG9vbCAqbWNlX2V2
dF9wb29sOw0KPiA+IHN0YXRpYyBMTElTVF9IRUFEKG1jZV9ldmVudF9sbGlzdCk7DQo+ID4gc3Rh
dGljIGNoYXIgZ2VuX3Bvb2xfYnVmW01DRV9QT09MU1pdOw0KPiANCj4gDQo+IFRoYXQncyBpbiAu
YnNzIHdoaWNoIG1lYW5zIGl0IGVhdHMgdXAgbWVtb3J5IGZvciAqZXZlcnlvbmUqLiBJdCBzZWVt
cyBhDQo+IGxpdHRsZSBzaWxseSB0byBlYXQgdXAgYW4gZXh0cmEgNiBwYWdlcyBvZiBtZW1vcnkg
Zm9yICpldmVyeW9uZSogaW4NCj4gb3JkZXIgdG8gZ2V0IHJpZCBvZiBhIG1lc3NhZ2Ugb24gd2hh
dCBJIGFzc3VtZSBpcyBhIHJlbGF0aXZlbHkgc21hbGwgc2V0DQo+IG9mICJzb3JyeSBzZXJ2ZXJz
Ii4NCg0KVGhlcmUncyBjb3JyZWxhdGlvbiBhY3Jvc3MgdGhlIGVycm9ycyB0aGF0IHdlJ3JlIHNl
ZWluZywgaW5kZWVkLCB3ZSdyZQ0KbG9va2luZyBhdCB0aGUgc2FtZSByb3cgYmVpbmcgcmVzcG9u
c2libGUgZm9yIG11bHRpcGxlIENQVXMgdHJpcHBpbmcgYW5kDQpydW5uaW5nIGludG8gI01DLiBJ
IHN0aWxsIGRvbid0IGxpa2UgdGhlIGZ1bGwgbGFjayBvZiB2aXNpYmlsaXR5OyBpdCdzIG5vdA0K
dW5jb21tb24gaW4gYSBsYXJnZSBmbGVldCB0byBzZWUgdG8gdGFrZSBhIHNlcnZlciBvdXQgb2Yg
cHJvZHVjdGlvbiwNCnJlcGxhY2UgYSBESU1NIGFuZCBzaG9ydGx5IGFmdGVyIHRha2luZyBpdCBv
dXQgb2YgcHJvZHVjdGlvbiBhZ2FpbiB0bw0KcmVwbGFjZSBhbm90aGVyIERJTU0ganVzdCBiZWNh
dXNlIHNvbWUgb2YgdGhlIGVycm9ycyB3ZXJlbid0IHByb3Blcmx5DQpsb2dnZWQuDQoNCj4gSXMg
dGhlcmUgYW55IHdheSB0aGF0IHRoZSBzaXplIG9mIHRoZSBwb29sIGNhbiBiZSBtb3JlIGF1dG9t
YXRpY2FsbHkNCj4gZGV0ZXJtaW5lZD8gSXMgdGhlIGxpa2VsaWhvb2Qgb2YgYSBidW5jaCBlcnJv
cnMgcHJvcG9ydGlvbmFsIHRvIHRoZQ0KPiBudW1iZXIgb2YgQ1BVcyBvciBhbW91bnQgb2YgUkFN
IG9yIHNvbWUgb3RoZXIgYXNwZWN0IG9mIHRoZSBoYXJkd2FyZT8NCj4gDQo+IA0KPiBDb3VsZCB0
aGUgcG9vbCBiZSBlbXB0aWVkIG1vcmUgYWdncmVzc2l2ZWx5IHNvIHRoYXQgaXQgZG9lcyBub3Qg
ZmlsbCB1cD8NCj4gDQo+IA0KPiBMYXN0LCB3aGF0IGlzIHRoZSBfYWN0dWFsXyBoYXJtIGNhdXNl
ZCBieSBtaXNzaW5nIHRoaXMgInVzZWZ1bA0KPiBpbmZvcm1hdGlvbiI/IElzIGNvbGxlY3Rpbmcg
dGhhdCBpbmZvcm1hdGlvbiBjb2xsZWN0aXZlbHkgcmVhbGx5IHdvcnRoDQo+IDI0a2IqTlJfWDg2
X1NZU1RFTVNfT05fRUFSVEg/IElzIGl0IHJlYWxseSB0aGF0IHZhbHVhYmxlIHRvIGtub3cgdGhh
dA0KPiB0aGUgc3lzdGVtIGdvdCA0LDAwMCBFQ0MgZXJyb3JzIG9uIGEgRElNTSB2ZXJzdXMgMSww
MDA/DQo+IA0KPiANCj4gSWYgdGhlcmUncyBubyBvdGhlciBjaG9pY2UgYW5kIHRoaXMgZXh0cmEg
aW5mb3JtYXRpb24gaXMgKkNSSVRJQ0FMKiwNCj4gdGhlbiBieSBhbGwgbWVhbnMgbGV0J3MgZW5s
YXJnZSB0aGUgYnVmZmVyLiBCdXQsIGxldCdzIHBsZWFzZSBkbyBpdCBmb3INCj4gYSBrbm93biwg
dGFuZ2libGUgYmVuZWZpdC4NCg0KSSdtIGhhcHB5IHRvIG1ha2UgdGhpcyBhIGNvbXBpbGUgdGlt
ZSBjb25maWd1cmF0aW9uIHdoZXJlIHRoZSBkZWZhdWx0IGlzDQpzdGlsbCAyIHBhZ2VzLCB0byBh
dm9pZCBjaGFuZ2luZyB0aGUgc3RhdHVzIHF1by4NCg0KRmlsaXBwbw0KDQoNCg0KCgoKQW1hem9u
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVy
bGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vp
c3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0
OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

