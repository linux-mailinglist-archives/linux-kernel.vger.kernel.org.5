Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55A793EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbjIFO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjIFO0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:26:04 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4610D3;
        Wed,  6 Sep 2023 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1694010359; x=1725546359;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=irEkO35HUqDRNbzI25CE8I+tRnI2zQhklUamtnwbfBE=;
  b=Y6cgQRlv0vm+WaxJI/Wi09bnPebfWJCEy9vEL8PF78pH5IH+f6dFIrVn
   XBi6RBWnbUxJYMQan0o8kzK1aLvoZZJN6g/fbQwGbkJQ0d85P+di7fQai
   8wHhmUg7ip5CXSwgdBr6fBr3hvN6nr9IYSYtTBjDmKLW6qyvrxTXjVfB+
   w=;
X-IronPort-AV: E=Sophos;i="6.02,232,1688428800"; 
   d="scan'208";a="27243062"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 14:25:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix) with ESMTPS id 58EC440D5E;
        Wed,  6 Sep 2023 14:25:56 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 6 Sep 2023 14:25:50 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 6 Sep
 2023 14:25:46 +0000
Message-ID: <746f0268-32b7-46fc-bfe5-37cf5b1bf998@amazon.de>
Date:   Wed, 6 Sep 2023 16:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Alexander Graf <graf@amazon.de>
Subject: Re: [RFC PATCH 0/2] Propagating reseed notifications to user space
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Babis Chalios <bchalios@amazon.es>
CC:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <xmarcalx@amazon.co.uk>, <aams@amazon.de>, <dwmw@amazon.co.uk>,
        <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20230823090107.65749-1-bchalios@amazon.es>
 <32756034-2fd4-4246-830e-c1a0eeab0a55@amazon.es> <ZPXsuhXJhN9Q3hfH@zx2c4.com>
Content-Language: en-GB
In-Reply-To: <ZPXsuhXJhN9Q3hfH@zx2c4.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1Jlc2VuZGluZyBpbiBwbGFpbiB0ZXh0IG9ubHkuIExldCdzIGhvcGUgaXQgcmVhY2hlcyBldmVy
eW9uZSB0aGlzIHRpbWUgOildCgpIZXkgSmFzb24hCgpPbiAwNC4wOS4yMyAxNjo0MiwgSmFzb24g
QS4gRG9uZW5mZWxkIHdyb3RlOgo+IE9uIE1vbiwgU2VwIDA0LCAyMDIzIGF0IDAzOjQ0OjQ4UE0g
KzAyMDAsIEJhYmlzIENoYWxpb3Mgd3JvdGU6Cj4+IEhlbGxvIGFsbCwKPj4KPj4gT24gMjMvOC8y
MyAxMTowMSwgQmFiaXMgQ2hhbGlvcyB3cm90ZToKPj4+IFRoaXMgaXMgYW4gUkZDLCBzbyB0aGF0
IHdlIGNhbiBkaXNjdXNzIHdoZXRoZXIgdGhlIHByb3Bvc2VkIEFCSSB3b3Jrcy4KPj4+IEFsc28s
IEknZCBsaWtlIHRvIGhlYXIgcGVvcGxlJ3Mgb3BpbmlvbiBvbiB0aGUgaW50ZXJuYWwgcmVnaXN0
cmF0aW9uCj4+PiBBUEksIDgvMjQgc3BsaXQgZXRjLiBJZiB3ZSBkZWNpZGUgdGhhdCB0aGlzIGFw
cHJvYWNoIHdvcmtzLCBJICdtIGhhcHB5Cj4+PiB0byBhZGQgZG9jdW1lbnRhdGlvbiBmb3IgaXQs
IHdpdGggZXhhbXBsZXMgb24gaG93IHVzZXIgc3BhY2UgY2FuIG1ha2UKPj4+IHVzZSBvZiBpdC4K
Pj4gU29tZSB0aW1lIGhhcyBwYXNzZWQgc2luY2UgSSBzZW50IHRoaXMgYW5kIEkgaGF2ZW4ndCBy
ZWNlaXZlZCBhbnkKPj4gY29tbWVudHMsIHNvIEkgYXNzdW1lIHBlb3BsZQo+IE5vcGUuIFRoaXMg
c3RpbGwgc3RhbmRzOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUhtTUU5cHhjLW5P
X3hhPTQrMUNudmJudWVmYlJUSkh4TTduODE3Y19UUGVveHp1X2dAbWFpbC5nbWFpbC5jb20vCgoK
VG8gcmVjYXAsIHRoYXQgZW1haWwgc2FpZDoKCj4gSnVzdCBzbyB5b3UgZ3V5cyBrbm93LCByb3Vn
aGx5IHRoZSBvcmRlciBvZiBvcGVyYXRpb25zIGhlcmUgYXJlIGdvaW5nIHRvIGJlOgo+Cj4gLSB2
ZHNvIHZnZXRyYW5kb20gdisxCj4gLSB2aXJ0aW8gZm9yayBkcml2ZXIKPiAtIGV4cG9zaW5nIGZv
cmsgZXZlbnRzIHRvIHVzZXJzcGFjZQo+Cj4gSSdsbCBrZWVwIHlvdSBwb3N0ZWQgb24gdGhvc2Uu
CgpJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgYm90aCB0aGUgcmVsYXRpb25zaGlwIG9mIHZnZXRy
YW5kb20gdG8gdGhpcyBub3IgCmhvdyB3ZSBjb3VsZCBoZWxwLiBJIHVuZGVyc3RhbmQgaG93IGEg
VkRTTyB2Z2V0cmFuZG9tIGNvdWxkIHVzZSAKcHJpbWl0aXZlcyB0aGF0IGFyZSB2ZXJ5IHNpbWls
YXIgKG9yIG1heWJlIGV2ZW4gaWRlbnRpY2FsKSB0byB0aGlzIHBhdGNoIApzZXQuCgpXaGF0IEkn
bSBtaXNzaW5nIGlzIHdoeSB0aGVyZSBpcyBhIGRlcGVuZGVuY3kgYmV0d2VlbiB0aGVtLiBJIGRv
bid0IApleHBlY3QgdXNlciBzcGFjZSBQUk5HcyB0byBkaXNhcHBlYXIgb3ZlciBuaWdodCwgZXNw
ZWNpYWxseSBnaXZlbiBhbGwgCnRoZSBoZWF2eSBsaWZ0aW5nIGFuZCBhcmNoaXRlY3R1cmUgc3Bl
Y2lmaWMgY29kZSB0aGF0IHZEU09zIHJlcXVpcmUuIFNvIAppZiB3ZSB3YW50IHRvIGJ1aWxkIGEg
c29sdXRpb24gdGhhdCBhbGxvd3MgdXNlciBzcGFjZSB0byBnZW5lcmljYWxseSAKc29sdmUgVk0g
c25hcHNob3RzLCB3ZSBzaG91bGQgc3RyaXZlIHRvIGhhdmUgYSBtZWNoYW5pc20gdGhhdCB3b3Jr
cyBpbiAKdG9kYXkncyBlbnZpcm9ubWVudCBpbiBhZGRpdGlvbiB0byBtYWtpbmcgdGhlIHZnZXRy
YW5kb20gY2FsbCBzYWZlIHdoZW4gCml0IGVtZXJnZXMuCgpUaGUgbGFzdCByZXZpc2lvbiBvZiB2
Z2V0cmFuZG9tIHRoYXQgSSBmb3VuZCB3YXMgdjE0IGZyb20gSmFudWFyeS4gSXMgaXQgCnN0aWxs
IGluIGFjdGl2ZSBkZXZlbG9wbWVudD8gQW5kIGlmIHNvLCB3aGF0IGlzIHRoZSBzdGF0dXM/IFRo
ZSBsYXN0IApmdW5kYW1lbnRhbCBjb21tZW50IEkgZm91bmQgaW4gYXJjaGl2ZXMgd2FzIHRoaXMg
Y29tbWVudCBmcm9tIExpbnVzOgoKCj4gVGhpcyBzaG91bGQgYWxsIGJlIGluIGxpYmMuIE5vdCBp
biB0aGUga2VybmVsIHdpdGggc3BlY2lhbCBtYWdpYyB2ZHNvCj4gc3VwcG9ydCBhbmQgc3BlY2lh
bCBidWZmZXIgYWxsb2NhdGlvbnMuIFRoZSBrZXJuZWwgc2hvdWxkIGdpdmUgZ29vZAo+IGVub3Vn
aCBzdXBwb3J0IHRoYXQgbGliYyBjYW4gZG8gYSBnb29kIGpvYiwgYnV0IHRoZSBrZXJuZWwgc2hv
dWxkCj4gc2ltcGx5ICpub3QqIHRha2UgdGhlIGFwcHJvYWNoIG9mICJsaWJjIHdpbGwgZ2V0IHRo
aXMgd3JvbmcsIHNvIGxldCdzCj4ganVzdCBkbyBhbGwgdGhlIHdvcmsgZm9yIGl0Ii4KCnRvIHdo
aWNoIHlvdSByZXBsaWVkCgo+IFRoYXQgYnVmZmVyaW5nIGNhbm5vdCBiZSBkb25lIHNhZmVseSBj
dXJyZW50bHkgLS0gVk0gZm9ya3MsIHJlc2VlZGluZwo+IHNlbWFudGljcywgYW5kIHNvIGZvcnRo
LiBBZ2FpbiwgZGlzY3Vzc2VkIGluIHRoZSBjb3ZlciBsZXR0ZXIgb2YgdGhlCj4gcGF0Y2ggaWYg
eW91J2QgbGlrZSB0byBlbmdhZ2Ugd2l0aCB0aG9zZSBpZGVhcy4KCk15IHVuZGVyc3RhbmRpbmcg
aXMgdGhhdCB0aGlzIHBhdGNoIHNldCBzb2x2ZXMgZXhhY3RseSB0aGF0IHByb2JsZW0gaW4gYSAK
d2F5IHRoYXQgaXMgZnVsbHkgY29tcGF0aWJsZSB3aXRoIGV4aXN0aW5nIHVzZXIgc3BhY2UgUFJO
R3MgYW5kIGVhc3kgdG8gCmNvbnN1bWUgYXMgd2VsbCBhcyBhZGQgc3VwcG9ydCBmb3IgaW4gIkVu
dGVycHJpc2UiIHN5c3RlbXMgZm9yIGFueW9uZSAKd2hvIHdpc2hlcyB0byBkbyBzby4KClNvLCB3
aGVyZSBpcyB2MTUgd2l0aG91dCBWTSBjaGFuZ2VzIHN0YW5kaW5nPyBBbmQgd2h5IGV4YWN0bHkg
c2hvdWxkIHdlIApjb3VwbGUgdmdldHJhbmRvbSB3aXRoIGF0b21pYyB1c2VyIHNwYWNlIHJlc2Vl
ZCBub3RpZmljYXRpb25zPyA6KQoKClRoYW5rcywKCkFsZXgKCgoKCkFtYXpvbiBEZXZlbG9wbWVu
dCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFl
ZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJh
Z2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6
OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

