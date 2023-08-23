Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DDE78558B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjHWKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjHWKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:37:32 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27CFCC;
        Wed, 23 Aug 2023 03:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1692787050; x=1724323050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1BjWk6aPFW9cjXQ6xLsK4tXIqF59AxpDLa+02uehtGk=;
  b=SHx+pS+bUJqV9cwimE/K8nbk5ftW8a4RloGzHaC6Mq5S4SdXmbbqqBAM
   C/TxVW2nTOXWELy1qBkieb7d7mdfRzBto8YrzuOGC3pGJoDVeTuPBJj9J
   08QvE+KtU6SdI7ySn0hCTzD/M5vTa4didLhJHdxA4J5XRDAC3wbRP3hW8
   8=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="603626997"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 10:37:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id F1CB0120641;
        Wed, 23 Aug 2023 10:37:24 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 23 Aug 2023 10:37:24 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 10:37:21 +0000
Message-ID: <b8744eea-c9bb-4d46-9b1a-1437cf1f098c@amazon.de>
Date:   Wed, 23 Aug 2023 12:37:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] random: emit reseed notifications for PRNGs
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>,
        Babis Chalios <bchalios@amazon.es>
CC:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <xmarcalx@amazon.co.uk>, <aams@amazon.de>, <dwmw@amazon.co.uk>
References: <20230823090107.65749-1-bchalios@amazon.es>
 <20230823090107.65749-2-bchalios@amazon.es>
 <2023082322-semester-heave-e5bc@gregkh>
 <ff6aa77e-4e5c-488e-bd45-319fc09720c3@amazon.es>
 <2023082340-daybreak-lagged-f157@gregkh>
 <89ce1064-e4a3-461f-8a78-88e72e5b6419@amazon.es>
 <2023082317-bauble-appeasing-90c0@gregkh>
From:   Alexander Graf <graf@amazon.de>
In-Reply-To: <2023082317-bauble-appeasing-90c0@gregkh>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDIzLjA4LjIzIDEyOjI1LCBHcmVnIEtIIHdyb3RlOgo+IE9uIFdlZCwgQXVnIDIzLCAyMDIz
IGF0IDEyOjA4OjM1UE0gKzAyMDAsIEJhYmlzIENoYWxpb3Mgd3JvdGU6Cj4+Cj4+IE9uIDIzLzgv
MjMgMTI6MDYsIEdyZWcgS0ggd3JvdGU6Cj4+PiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQg
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLgo+Pj4KPj4+Cj4+Pgo+Pj4gT24gV2VkLCBBdWcgMjMs
IDIwMjMgYXQgMTE6Mjc6MTFBTSArMDIwMCwgQmFiaXMgQ2hhbGlvcyB3cm90ZToKPj4+PiBIaSBH
cmVnLAo+Pj4+Cj4+Pj4gT24gMjMvOC8yMyAxMTowOCwgR3JlZyBLSCB3cm90ZToKPj4+Pj4gQ0FV
VElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0
aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNh
biBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4KPj4+Pj4K
Pj4+Pj4KPj4+Pj4KPj4+Pj4gT24gV2VkLCBBdWcgMjMsIDIwMjMgYXQgMTE6MDE6MDVBTSArMDIw
MCwgQmFiaXMgQ2hhbGlvcyB3cm90ZToKPj4+Pj4+IFNvbWV0aW1lcywgUFJOR3MgbmVlZCB0byBy
ZXNlZWQuIEZvciBleGFtcGxlLCBvbiBhIHJlZ3VsYXIgdGltZXIKPj4+Pj4+IGludGVydmFsLCB0
byBlbnN1cmUgbm90aGluZyBjb25zdW1lcyBhIHJhbmRvbSB2YWx1ZSBmb3IgbG9uZ2VyIHRoYW4g
ZS5nLgo+Pj4+Pj4gNSBtaW51dGVzLCBvciB3aGVuIFZNcyBnZXQgY2xvbmVkLCB0byBlbnN1cmUg
c2VlZHMgZG9uJ3QgbGVhayBpbiB0bwo+Pj4+Pj4gY2xvbmVzLgo+Pj4+Pj4KPj4+Pj4+IFRoZSBu
b3RpZmljYXRpb24gaGFwcGVucyB0aHJvdWdoIGEgMzJiaXQgZXBvY2ggdmFsdWUgdGhhdCBjaGFu
Z2VzIGV2ZXJ5Cj4+Pj4+PiB0aW1lIGNhY2hlZCBlbnRyb3B5IGlzIG5vIGxvbmdlciB2YWxpZCwg
aGVuY2UgUFJOR3MgbmVlZCB0byByZXNlZWQuIFVzZXIKPj4+Pj4+IHNwYWNlIGFwcGxpY2F0aW9u
cyBjYW4gZ2V0IGhvbGQgb2YgYSBwb2ludGVyIHRvIHRoaXMgdmFsdWUgdGhyb3VnaAo+Pj4+Pj4g
L2Rldi8odSlyYW5kb20uIFdlIGludHJvZHVjZSBhIG5ldyBpb2N0bCgpIHRoYXQgcmV0dXJucyBh
biBhbm9ueW1vdXMKPj4+Pj4+IGZpbGUgZGVzY3JpcHRvci4gRnJvbSB0aGlzIGZpbGUgZGVzY3Jp
cHRvciB3ZSBjYW4gbW1hcCgpIGEgc2luZ2xlIHBhZ2UKPj4+Pj4+IHdoaWNoIGluY2x1ZGVzIHRo
ZSBlcG9jaCBhdCBvZmZzZXQgMC4KPj4+Pj4+Cj4+Pj4+PiByYW5kb20uYyBtYWludGFpbnMgdGhl
IGVwb2NoIHZhbHVlIGluIGEgZ2xvYmFsIHNoYXJlZCBwYWdlLiBJdCBleHBvc2VzCj4+Pj4+PiBh
IHJlZ2lzdHJhdGlvbiBBUEkgZm9yIGtlcm5lbCBzdWJzeXN0ZW1zIHRoYXQgYXJlIGFibGUgdG8g
bm90aWZ5IHdoZW4KPj4+Pj4+IHJlc2VlZGluZyBpcyBuZWVkZWQuIE5vdGlmaWVycyByZWdpc3Rl
ciB3aXRoIHJhbmRvbS5jIGFuZCByZWNlaXZlIGEKPj4+Pj4+IHVuaXF1ZSA4Yml0IElEIGFuZCBh
IHBvaW50ZXIgdG8gdGhlIGVwb2NoLiBXaGVuIHRoZXkgbmVlZCB0byByZXBvcnQgYQo+Pj4+Pj4g
cmVzZWVkaW5nIGV2ZW50IHRoZXkgd3JpdGUgYSBuZXcgZXBvY2ggdmFsdWUgd2hpY2ggaW5jbHVk
ZXMgdGhlCj4+Pj4+PiBub3RpZmllciBJRCBpbiB0aGUgZmlyc3QgOCBiaXRzIGFuZCBhbiBpbmNy
ZWFzaW5nIGNvdW50ZXIgdmFsdWUgaW4gdGhlCj4+Pj4+PiByZW1haW5pbmcgMjQgYml0czoKPj4+
Pj4+Cj4+Pj4+PiAgICAgICAgICAgICAgICAgIFJORyBlcG9jaAo+Pj4+Pj4gKi0tLS0tLS0tLS0t
LS0qLS0tLS0tLS0tLS0tLS0tLS0tLS0tKgo+Pj4+Pj4gfCBub3RpZmllciBpZCB8IGVwb2NoIGNv
dW50ZXIgdmFsdWUgfAo+Pj4+Pj4gKi0tLS0tLS0tLS0tLS0qLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Kgo+Pj4+Pj4gICAgICAgICA4IGJpdHMgICAgICAgICAgIDI0IGJpdHMKPj4+Pj4gV2h5IG5vdCBq
dXN0IHVzZSAzMi8zMiBmb3IgYSBmdWxsIDY0Yml0IHZhbHVlLCBvciBiZXR0ZXIgeWV0LCAyCj4+
Pj4+IGRpZmZlcmVudCB2YXJpYWJsZXM/ICBXaHkgaXMgMzJiaXRzIGFuZCBwYWNraW5nIHRoaW5n
cyB0b2dldGhlciBoZXJlCj4+Pj4+IHNvbWVob3cgc2ltcGxlcj8KPj4+PiBXZSBtYWRlIGl0IDMy
IGJpdHMgc28gdGhhdCB3ZSBjYW4gcmVhZC93cml0ZSBpdCBhdG9taWNhbGx5IGluIGFsbCAzMmJp
dAo+Pj4+IGFyY2hpdGVjdHVyZXMuCj4+Pj4gRG8geW91IHRoaW5rIHRoYXQncyBub3QgYSBwcm9i
bGVtPwo+Pj4gV2hhdCAzMmJpdCBwbGF0Zm9ybXMgY2FyZSBhYm91dCB0aGlzIHR5cGUgb2YgaW50
ZXJmYWNlIGF0IGFsbD8KPj4gSSB0aGluaywgYW55IDMyYml0IHBsYXRmb3JtIHRoYXQgZ2V0cyBy
YW5kb20gYnl0ZXMgZnJvbSB0aGUga2VybmVsLgo+IFlvdSBhcmUgbWFraW5nIGEgbmV3IGFwaSwg
Zm9yIHNvbWUgbmV3IGZ1bmN0aW9uYWxpdHksIGZvciB3aGF0IEkgdGhvdWdodAo+IHdhcyB2aXJ0
dWFsIG1hY2hpbmVzIChoZW5jZSB0aGUgdmlydGlvIGRyaXZlciksIG5vbmUgb2Ygd2hpY2ggd29y
ayBpbiBhCj4gMzJiaXQgc3lzdGVtLgoKClRoZXJlIHNob3VsZCBiZSAyIHVzZSBjYXNlcyBvZiB0
aGlzIHRoYXQgSSdtIGF3YXJlIG9mOgoKIMKgICogVmlydHVhbCBtYWNoaW5lIGNsb25lcy4gTW9z
dCA2NGJpdCBWTXMgY2FuIGV4ZWN1dGUgMzJiaXQgdXNlciBzcGFjZS4KIMKgICogQmFyZSBtZXRh
bCBybmcgdGltZS10by1saXZlLiBBbiBlYXN5IG1lY2hhbmlzbSB0byB0ZWxsIGV2ZXJ5IFBSTkcg
CmluIHRoZSBzeXN0ZW0gdG8gcmVzZWVkIGV2ZXJ5IDUgbWludXRlcy4gVGhpcyBhcHBsaWVzIHRv
IGFsbCAKYXJjaGl0ZWN0dXJlcyBMaW51eCBzdXBwb3J0cy4KCgo+IEkgdGhvdWdodCB0aGlzIHdh
cyBhbiBpb2N0bCBmb3IgdXNlcnNwYWNlLCB3aGljaCBjYW4gaGFuZGxlIDY0Yml0cyBhdAo+IG9u
Y2UgKG9yIDIgMzJiaXQgbnVtYmVycykuCgoKVGhlIGlvY3RsIGlzIG9ubHkgdG8gY3JlYXRlIGEg
ZmlsZSBkZXNjcmlwdG9yIHRoYXQgeW91IGNhbiB1c2UgdG8gbW1hcCgpIAphIHNoYXJlZCBwYWdl
IGJldHdlZW4ga2VybmVsIGFuZCB1c2VyIHNwYWNlIHdoaWNoIHlvdSBjYW4gdGhlbiAKYXRvbWlj
YWxseSBhY2Nlc3MgdG8gdW5kZXJzdGFuZCBpZiB5b3UncmUgaW4gdGhlIG9sZCBlcG9jaCAoa2Vl
cCB1c2luZyAKcHJldmlvdXMgUk5HIHZhbHVlcykgb3IgaW4gdGhlIG5ldyBlcG9jaCAoZGlzY2Fy
ZCBhbnkgb2xkIGNhY2hlZCBSTkcgCnZhbHVlcykuCgoKPiBGb3IgaW50ZXJuYWwga2VybmVsIHN0
dWZmLCBhIGxvY2sgc2hvdWxkIGJlIGZpbmUsIG9yIGJldHRlciB5ZXQsIGEgNjRiaXQKPiBhdG9t
aWMgdmFsdWUgcmVhZCAoaG9ycmlibGUgb24gMzJiaXQgcGxhdGZvcm1zLCBJIGtub3cuLi4pCj4K
PiBKdXN0IGFza2luZywgaXQgZmVlbHMgb2RkIHRvIHBhY2sgYml0cyBpbiB0aGVzZSBkYXlzIGZv
ciB3aGVuIDkwJSBvZiB0aGUKPiBjcHVzIHJlYWxseSBkb24ndCBuZWVkIGl0LgoKCkkgYWdyZWUs
IGJ1dCB3ZSdyZSByZWFsbHkgbm90IHJlYWxseSBiaXQgY29uc3RyYWluZWQgZm9yIHRoaXMgdmFs
dWUgYW5kIApieSBtYWtpbmcgaXQgMzJiaXQgYWx3YXlzLCB3ZSBjYW4gZ3VhcmFudGVlIHRoYXQg
dGhlcmUgd2lsbCBuZXZlciBiZSAKbXVja2VyeSBmb3IgMzItb24tNjQgY29tcGF0aWJpbGl0eS4K
CgpBbGV4CgoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNl
bnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxh
ZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRl
bmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcg
ODc5CgoK

