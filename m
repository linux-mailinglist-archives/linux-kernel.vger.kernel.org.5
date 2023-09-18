Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADC7A44C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbjIRIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbjIRIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:32:57 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650E94;
        Mon, 18 Sep 2023 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1695025971; x=1726561971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dWiSo48jn67GxZS59DakY6rA31dDReNb+8DkkZb9bEM=;
  b=SSlUOiSXgKHb3lxqf3GT0wyD8CPpw083oExu6HW8pxw9t0Rjo8REa2ke
   eUcean+6SZQ2LfWpp1bVkuQ0/6TVjopF0kwqobEMj8mc0gTWAgMD+Ajz3
   8piRfFB1kgZ74rZ2xCAoriuX6DWYDkXoUoYnXMLtpA0TWP6vdy3KSL6iu
   4=;
X-IronPort-AV: E=Sophos;i="6.02,156,1688428800"; 
   d="scan'208";a="359060949"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:32:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com (Postfix) with ESMTPS id C108FA061E;
        Mon, 18 Sep 2023 08:32:45 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 18 Sep 2023 08:32:40 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 08:32:37 +0000
Message-ID: <52e5c5c4-46ba-4d4b-97b2-519e22e0eb91@amazon.de>
Date:   Mon, 18 Sep 2023 10:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Propagating reseed notifications to user space
To:     Yann Droneaud <yann@droneaud.fr>,
        Babis Chalios <bchalios@amazon.es>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <xmarcalx@amazon.co.uk>, <aams@amazon.de>, <dwmw@amazon.co.uk>,
        <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20230823090107.65749-1-bchalios@amazon.es>
 <564c9bb6-1e7d-43c3-8dfc-5282ea82305a@droneaud.fr>
Content-Language: en-GB
From:   Alexander Graf <graf@amazon.de>
In-Reply-To: <564c9bb6-1e7d-43c3-8dfc-5282ea82305a@droneaud.fr>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
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

SGV5IFlhbm4hCgpPbiAxNy4wOS4yMyAxNTozNCwgWWFubiBEcm9uZWF1ZCB3cm90ZToKPgo+IEhp
LAo+Cj4gTGUgMjMvMDgvMjAyMyDDoCAxMTowMSwgQmFiaXMgQ2hhbGlvcyBhIMOpY3JpdCA6Cj4+
IFVzZXIgc3BhY2Ugb2Z0ZW4gaW1wbGVtZW50cyBQUk5HcyB0aGF0IHVzZSAvZGV2L3JhbmRvbSBh
cyBlbnRyb3B5Cj4+IHNvdXJjZS4gV2UgY2FuIG5vdCBleHBlY3QgdGhhdCB0aGlzIHJhbmRvbW5l
c3Mgc291cmNlcyBzdGF5IGNvbXBsZXRlbHkKPj4gdW5rbm93biBmb3JldmVyLiBGb3IgdmFyaW91
cyByZWFzb25zLCB0aGUgb3JpZ2luYXRpbmcgUFJORyBzZWVkIG1heQo+PiBiZWNvbWUga25vd24g
YXQgd2hpY2ggcG9pbnQgdGhlIFBSTkcgYmVjb21lcyBpbnNlY3VyZSBmb3IgZnVydGhlciByYW5k
b20KPj4gbnVtYmVyIGdlbmVyYXRpb24uIEV2ZW50cyB0aGF0IGNhbiBsZWFkIHRvIHRoYXQgYXJl
IGZvciBleGFtcGxlIGZhc3QKPj4gY29tcHV0ZXJzIHJldmVyc2luZyB0aGUgUFJORyBmdW5jdGlv
biB1c2luZyBhIG51bWJlciBvZiBpbnB1dHMgb3IKPj4gVmlydHVhbCBNYWNoaW5lIGNsb25lcyB3
aGljaCBjYXJyeSBzZWVkIHZhbHVlcyBpbnRvIHRoZWlyIGNsb25lcy4KPj4KPj4gRHVyaW5nIExQ
QyAyMDIyIEphc29uLCBBbGV4LCBNaWNoYWVsIGFuZCBtZSBicmFpbnN0b3JtZWQgb24gaG93IHRv
Cj4+IGF0b21pY2FsbHkgZXhwb3NlIGEgbm90aWZpY2F0aW9uIHRvIHVzZXIgc3BhY2UgdGhhdCBp
dCBzaG91bGQgcmVzZWVkLgo+PiBBdG9taWNpdHkgaXMga2V5IGZvciB0aGUgVk0gY2xvbmUgY2Fz
ZS4gVGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIGEKPj4gcG90ZW50aWFsIHBhdGggdG8gZG8gc28u
Cj4+Cj4+IFRoaXMgcGF0Y2hzZXQgaW50cm9kdWNlcyBhbiBlcG9jaCB2YWx1ZSBhcyB0aGUgbWVh
bnMgb2YgY29tbXVuaWNhdGluZyB0bwo+PiB0aGUgZ3Vlc3QgdGhlIG5lZWQgdG8gcmVzZWVkLiBU
aGUgZXBvY2ggaXMgYSAzMmJpdCB2YWx1ZSB3aXRoIHRoZQo+PiBmb2xsb3dpbmcgZm9ybToKPj4K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSTkcgZXBvY2gKPj4gKi0tLS0tLS0tLS0t
LS0qLS0tLS0tLS0tLS0tLS0tLS0tLS0tKgo+PiB8IG5vdGlmaWVyIGlkIHwgZXBvY2ggY291bnRl
ciB2YWx1ZSB8Cj4+ICotLS0tLS0tLS0tLS0tKi0tLS0tLS0tLS0tLS0tLS0tLS0tLSoKPj4gwqDC
oMKgwqDCoCA4IGJpdHPCoMKgwqDCoMKgwqDCoMKgwqDCoCAyNCBiaXRzCj4+Cj4+IENoYW5nZXMg
aW4gdGhpcyB2YWx1ZSBzaWduYWwgbW9tZW50cyBpbiB0aW1lIHRoYXQgUFJOR3MgbmVlZCB0byBi
ZQo+PiByZS1zZWVkZWQuIEFzIGEgcmVzdWx0LCB0aGUgaW50ZW5kZWQgdXNlIG9mIHRoZSBlcG9j
aCBmcm9tIHVzZXIgc3BhY2UKPj4gUFJOR3MgaXMgdG8gY2FjaGUgdGhlIGVwb2NoIHZhbHVlIGV2
ZXJ5IHRpbWUgdGhleSByZXNlZWQgdXNpbmcga2VybmVsCj4+IGVudHJvcHksIHRoZW4gY29udHJv
bCB0aGF0IGl0cyB2YWx1ZSBoYXNuJ3QgY2hhbmdlZCBiZWZvcmUgZ2l2aW5nIG91dAo+PiByYW5k
b20gbnVtYmVycy4gSWYgdGhlIHZhbHVlIGhhcyBjaGFuZ2VkIHRoZSBQUk5HIG5lZWRzIHRvIHJl
c2VlZCBiZWZvcmUKPj4gcHJvZHVjaW5nIGFueSBtb3JlIHJhbmRvbSBiaXRzLgo+Pgo+PiBUaGUg
QVBJIGZvciBnZXR0aW5nIGhvbGQgb2YgdGhpcyB2YWx1ZSBpcyBvZmZlcmVkIHRocm91Z2gKPj4g
L2Rldi8odSlyYW5kb20uIFdlIGludHJvZHVjZSBhIG5ldyBpb2N0bCBmb3IgdGhlc2UgZGV2aWNl
cywgd2hpY2gKPj4gY3JlYXRlcyBhbiBhbm9ueW1vdXMgZmlsZSBkZXNjcmlwdG9yLiBVc2VyIHBy
b2Nlc3NlcyBjYW4gY2FsbCB0aGUKPj4gaW9jdGwoKSB0byBnZXQgdGhlIGFub24gZmQgYW5kIHRo
ZW4gbW1hcCBpdCB0byBhIHNpbmdsZSBwYWdlLiBUaGF0IHBhZ2UKPj4gY29udGFpbnMgdGhlIHZh
bHVlIG9mIHRoZSBlcG9jaCBhdCBvZmZzZXQgMC4KPj4KPj4gTmF0dXJhbGx5LCByYW5kb20uYyBp
cyB0aGUgY29tcG9uZW50IHRoYXQgbWFpbnRhaW5zIHRoZSBSTkcgZXBvY2guCj4+IER1cmluZyBp
bml0aWFsaXphdGlvbiBpdCBhbGxvY2F0ZXMgYSBzaW5nbGUgZ2xvYmFsIHBhZ2Ugd2hpY2ggaG9s
ZHMgdGhlCj4+IGVwb2NoIHZhbHVlLiBNb3Jlb3ZlciwgaXQgZXhwb3NlcyBhbiBBUEkgdG8ga2Vy
bmVsIHN1YnN5c3RlbXMKPj4gKG5vdGlmaWVycykgd2hpY2ggY2FuIHJlcG9ydCBldmVudHMgdGhh
dCByZXF1aXJlIFBSTkcgcmVzZWVkaW5nLgo+PiBOb3RpZmllcnMgcmVnaXN0ZXIgd2l0aCByYW5k
b20uYyBhbmQgcmVjZWl2ZSBhbiA4LWJpdCBub3RpZmllciBpZCAodXAgdG8KPj4gMjU2IHN1YnNj
cmliZXJzIHNob3VsZCBiZSBlbm91Z2gpIGFuZCBhIHBvaW50ZXIgdG8gdGhlIGVwb2NoLiBOb3Rp
ZnlpbmcsCj4+IHRoZW4sIGlzIGVxdWl2YWxlbnQgdG8gd3JpdGluZyBpbiB0aGUgZXBvY2ggYWRk
cmVzcyBhIG5ldyBlcG9jaCB2YWx1ZS4KPj4KPj4gTm90aWZpZXJzIHdyaXRlIGVwb2NoIHZhbHVl
cyB0aGF0IGluY2x1ZGUgdGhlIG5vdGlmaWVyIElEIG9uIHRoZSBoaWdoZXIKPj4gOCBiaXRzIGFu
ZCBpbmNyZWFzaW5nIGNvdW50ZXIgdmFsdWVzIG9uIHRoZSAyNCByZW1haW5pbmcgYml0cy4gVGhp
cwo+PiBndWFyYW50ZWVzIHRoYXQgdHdvIG5vdGlmaWVycyBjYW5ub3QgZXZlciB3cml0ZSB0aGUg
c2FtZSBlcG9jaCB2YWx1ZSwKPj4gc2luY2Ugbm90aWZpY2F0b3IgSURzIGFyZSB1bmlxdWUuCj4+
Cj4+IFRoZSBmaXJzdCBwYXRjaCBvZiB0aGlzIHNlcmllcyBpbXBsZW1lbnRzIHRoZSBlcG9jaCBt
ZWNoYW5pc20uIEl0IGFkZHMKPj4gdGhlIGxvZ2ljIGluIHRoZSByYW5kb20uYyB0byBtYWludGFp
biB0aGUgZXBvY2ggcGFnZSBhbmQgZXhwb3NlIHRoZQo+PiB1c2VyIHNwYWNlIGZhY2luZyBBUEku
IEl0IGFsc28gYWRkcyB0aGUgaW50ZXJuYWwgQVBJIHRoYXQgYWxsb3dzIGtlcm5lbAo+PiBzeXN0
ZW1zIHRvIHJlZ2lzdGVyIGFzIG5vdGlmaWVycy4KPgo+IEZyb20gdXNlcnNwYWNlIHBvaW50IG9m
IHZpZXcsIGhhdmluZyB0byBvcGVuIC9kZXYvcmFuZG9tLCBpb2N0bCwgYW5kIAo+IG1tYXAoKQo+
IGlzIGEgbm8tZ28gZm9yIGEgKENTKVBSTkcgZW1iZWRkZWQgaW4gbGliYyBmb3IgYXJjNHJhbmRv
bSgpLgoKCkNvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIG9uIHdoeSBpdCdzIGEgbm8tZ28/IFdp
dGggYW55IGFwcHJvYWNoIHdlIAp0YWtlLCBzb21lb25lIHNvbWV3aGVyZSBuZWVkcyB0byBtYXAg
YW5kIGV4cG9zZSBkYXRhIHRvIHVzZXIgc3BhY2UgdGhhdCAKd2UgYXJlIGluIGEgbmV3ICJlcG9j
aCIuIFdpdGggdGhpcyBwYXRjaCBzZXQsIHlvdSBkbyB0aGF0IGV4cGxpY2l0bHkgCmZyb20gdXNl
ciBzcGFjZSB0aHJvdWdoIGFuIGZkIHRoYXQgeW91IGtlZXAgb3BlbiBwbHVzIGFuIG1tYXAgdGhh
dCB5b3UgCmtlZXAgYWN0aXZlLiBXaXRoIHZnZXRyYW5kb20sIHRoZSBrZXJuZWwgZG9lcyBpdCBp
bXBsaWNpdGx5IGZvciB5b3UuCgpTbyB3aXRoIHRoaXMgcGF0Y2ggc2V0J3MgYXBwcm9hY2gsIHRo
ZSBmaXJzdCBjYWxsIHRvIGFyYzRyYW5kb20oKSB3b3VsZCAKbmVlZCB0byBlc3RhYmxpc2ggdGhl
IGVwb2NoIG1tYXAgYW5kIGxlYXZlIGl0IG9wZW4uIEFmdGVyIHRoYXQgZXBvY2ggCmhhbmRsaW5n
IGlzIChhbG1vc3QpIGZyZWUgLSBpdCdzIGp1c3QgYSAzMmJpdCB2YWx1ZSBjb21wYXJlLgoKQXJl
IHlvdSBzYXlpbmcgdGhhdCB0aGVyZSBpcyBhIHByb2JsZW0gd2l0aCBrZWVwaW5nIHRyYWNrIG9m
IHRoYXQgCmFkZGl0aW9uYWwgc3RhdGU/IEFzIG1lbnRpb25lZCBhYm92ZSwgd2UgbmVlZCB0byBr
ZWVwIHRyYWNrIG9mIHNvbWUgCnN0YXRlIHNvbWV3aGVyZTogRWl0aGVyIGluIHRoZSB2ZHNvIHBs
dXMga2VybmVsIHBhZ2UgbWFwIGxvZ2ljIG9yIGluIHRoZSAKbGlicmFyeSB0aGF0IGNvbnN1bWVz
IGVwb2Nocy4KCklmIHRoaXMgaXMgdGhlIHByb2JsZW0sIG1heWJlIHRoZSBmdW5kYW1lbnRhbCBp
c3N1ZSBpcyB0aGF0IGFyYzRyYW5kb20oKSAKYXNzdW1lcyB5b3UgYWx3YXlzIGhhdmUgZXZlcnl0
aGluZyBpbiBwbGFjZSB0byByZWNlaXZlIHJhbmRvbW5lc3MgCndpdGhvdXQgYSBoYW5kbGUgdGhh
dCBjb3VsZCBnbyB0aHJvdWdoIGFuIG9wZW4vY2xvc2UgKGluaXQvZGVzdHJveSkgCmN5Y2xlPyBJ
IHN1cHBvc2UgeW91IGNvdWxkIGNoYW5nZSB0aGF0PwoKPiBJJ20gYmlhc2VkLCBhcyBJIHByb3Bv
c2VkIHRvIGV4cG9zZSBzdWNoIHNlZWQgZXBvY2ggdmFsdWUgdG8gdXNlcnNwYWNlIAo+IHRocm91
Z2gKPiBnZXRyYW5kb20oKSBkaXJlY3RseSwgcmVseWluZyBvbiB2RFNPIGZvciByZWFzb25hYmxl
IHBlcmZvcm1hbmNlcywgCj4gYmVjYXVzZQo+IGN1cnJlbnQncyBnbGliYyBhcmM0cmFuZG9tKCkg
aXMgc29tZXdoYXQgdG8gc2xvdyB0byBiZSBhIGdlbmVyYWwgCj4gcmVwbGFjZW1lbnQKPiByYW5k
KCkuCj4KPiBTZWUKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvY292ZXIuMTY3MzUzOTcx
OS5naXQueWRyb25lYXVkQG9wdGV5YS5jb20vCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
L2FlMzVhZmE1YjgyNGRjNzZjNWRlZDk4ZWZjYWJjMTE3ZTZkZDNkNzBAb3B0ZXlhLmNvbS8gCj4K
CgpUaGVyZSBhcmUgbW9yZSBwcm9ibGVtcyB3aXRoIGNvdXBsaW5nIGVwb2NocyB0byB0aGUgdmdl
dHJhbmRvbSBhcHByb2FjaDogCk5vdCBldmVyeW9uZSB3aWxsIHdhbnQgdG8gb3IgY2FuIHVzZSBM
aW51eCdzIHJuZyBhcyB0aGUgc29sZSBzb3VyY2Ugb2YgCmVudHJvcHkgZm9yIHZhcmlvdXMgcmVh
c29ucyAoTklTVCwgRklQUywgVExTIHJlY29tbWVuZGF0aW9ucyB0byBub3QgcmVseSAKb24gYSBz
aW5nbGUgc291cmNlLCByZWFsIHRpbWUgcmVxdWlyZW1lbnRzLCBldGMpIGJ1dCBzdGlsbCByZXF1
aXJlIAprbm93bGVkZ2Ugb2YgZXBvY2ggY2hhbmdlcy4KClRoYXQgbWVhbnMgd2UgbmVlZCBhbiBh
bHRlcm5hdGl2ZSBwYXRoIGZvciB0aGVzZSBhcHBsaWNhdGlvbnMgCnJlZ2FyZGxlc3MuIE1heSBh
cyB3ZWxsIHN0YXJ0IHdpdGggdGhhdCA6KS4gSWYgd2UgdGhlbiBzdGlsbCBjb25jbHVkZSAKdGhh
dCB2Z2V0cmFuZG9tIGlzIHRoZSBiZXN0IHBhdGggZm9yd2FyZCB0byBhY2NlbGVyYXRlIGFjY2Vz
cyB0byAKL2Rldi91cmFuZG9tIGluIHVzZXIgc3BhY2UsIHdlIGNhbiBqdXN0IGFsd2F5cyBtYXAg
dGhpcyBwYXRjaCBzZXQncyAKZXBvY2ggcGFnZSBpbnRvIHRoZSB2RFNPIHJhbmdlIGFuZCB0aGVu
IG1ha2UgdmdldHJhbmRvbSBjb25zdW1lIGl0LCAKc2ltaWxhciB0byBob3cgYSB1c2VyIHNwYWNl
IGxpYnJhcnkgd291bGQuCgpJIGdlbnVpbmVseSBkb24ndCB1bmRlcnN0YW5kIGhvdyB2Z2V0cmFu
ZG9tIGFuZCB0aGlzIHBhdGNoIHNldCAKY29udHJhZGljdCBlYWNoIG90aGVyLgoKCkFsZXgKCgoK
CkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEw
MTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0
aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVy
IEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

