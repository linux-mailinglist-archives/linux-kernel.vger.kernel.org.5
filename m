Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA6785547
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjHWKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjHWKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:20:41 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254B3CDF;
        Wed, 23 Aug 2023 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1692786033; x=1724322033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LvruqNZa27xH1J/uB+hQyGumvyQYGsP31T4ueurP9jM=;
  b=VAhayl5QN/rwI0VscfFiAhV1CHaHJkkhyEU6vQDQtiXz3iih/6wlJ7ax
   sAmPUnevbdEIierrJrlaK+AouKTx0ozYdnfMk6BBvRNtk6fIvgWu0XsNT
   TiPxAkuab1dFOiXsQgo0RkHu/kyoOu2Bt9oF893zfAJgxCLTpOjLC1ZGk
   s=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="234169003"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 10:20:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id F2FCD8060A;
        Wed, 23 Aug 2023 10:20:24 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 23 Aug 2023 10:20:24 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 10:20:20 +0000
Message-ID: <9ea91c30-fda4-4bfa-baf2-82f911994f00@amazon.de>
Date:   Wed, 23 Aug 2023 12:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] random: emit reseed notifications for PRNGs
Content-Language: en-GB
To:     Babis Chalios <bchalios@amazon.es>,
        Greg KH <gregkh@linuxfoundation.org>
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
From:   Alexander Graf <graf@amazon.de>
In-Reply-To: <89ce1064-e4a3-461f-8a78-88e72e5b6419@amazon.es>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEdyZWcsCgpPbiAyMy4wOC4yMyAxMjowOCwgQmFiaXMgQ2hhbGlvcyB3cm90ZToKPgo+Cj4g
T24gMjMvOC8yMyAxMjowNiwgR3JlZyBLSCB3cm90ZToKPj4KPj4gT24gV2VkLCBBdWcgMjMsIDIw
MjMgYXQgMTE6Mjc6MTFBTSArMDIwMCwgQmFiaXMgQ2hhbGlvcyB3cm90ZToKPj4+IEhpIEdyZWcs
Cj4+Pgo+Pj4gT24gMjMvOC8yMyAxMTowOCwgR3JlZyBLSCB3cm90ZToKPj4+Pgo+Pj4+IE9uIFdl
ZCwgQXVnIDIzLCAyMDIzIGF0IDExOjAxOjA1QU0gKzAyMDAsIEJhYmlzIENoYWxpb3Mgd3JvdGU6
Cj4+Pj4+IFNvbWV0aW1lcywgUFJOR3MgbmVlZCB0byByZXNlZWQuIEZvciBleGFtcGxlLCBvbiBh
IHJlZ3VsYXIgdGltZXIKPj4+Pj4gaW50ZXJ2YWwsIHRvIGVuc3VyZSBub3RoaW5nIGNvbnN1bWVz
IGEgcmFuZG9tIHZhbHVlIGZvciBsb25nZXIgdGhhbiBlLmcuCj4+Pj4+IDUgbWludXRlcywgb3Ig
d2hlbiBWTXMgZ2V0IGNsb25lZCwgdG8gZW5zdXJlIHNlZWRzIGRvbid0IGxlYWsgaW4gdG8KPj4+
Pj4gY2xvbmVzLgo+Pj4+Pgo+Pj4+PiBUaGUgbm90aWZpY2F0aW9uIGhhcHBlbnMgdGhyb3VnaCBh
IDMyYml0IGVwb2NoIHZhbHVlIHRoYXQgY2hhbmdlcyBldmVyeQo+Pj4+PiB0aW1lIGNhY2hlZCBl
bnRyb3B5IGlzIG5vIGxvbmdlciB2YWxpZCwgaGVuY2UgUFJOR3MgbmVlZCB0byByZXNlZWQuIFVz
ZXIKPj4+Pj4gc3BhY2UgYXBwbGljYXRpb25zIGNhbiBnZXQgaG9sZCBvZiBhIHBvaW50ZXIgdG8g
dGhpcyB2YWx1ZSB0aHJvdWdoCj4+Pj4+IC9kZXYvKHUpcmFuZG9tLiBXZSBpbnRyb2R1Y2UgYSBu
ZXcgaW9jdGwoKSB0aGF0IHJldHVybnMgYW4gYW5vbnltb3VzCj4+Pj4+IGZpbGUgZGVzY3JpcHRv
ci4gRnJvbSB0aGlzIGZpbGUgZGVzY3JpcHRvciB3ZSBjYW4gbW1hcCgpIGEgc2luZ2xlIHBhZ2UK
Pj4+Pj4gd2hpY2ggaW5jbHVkZXMgdGhlIGVwb2NoIGF0IG9mZnNldCAwLgo+Pj4+Pgo+Pj4+PiBy
YW5kb20uYyBtYWludGFpbnMgdGhlIGVwb2NoIHZhbHVlIGluIGEgZ2xvYmFsIHNoYXJlZCBwYWdl
LiBJdCBleHBvc2VzCj4+Pj4+IGEgcmVnaXN0cmF0aW9uIEFQSSBmb3Iga2VybmVsIHN1YnN5c3Rl
bXMgdGhhdCBhcmUgYWJsZSB0byBub3RpZnkgd2hlbgo+Pj4+PiByZXNlZWRpbmcgaXMgbmVlZGVk
LiBOb3RpZmllcnMgcmVnaXN0ZXIgd2l0aCByYW5kb20uYyBhbmQgcmVjZWl2ZSBhCj4+Pj4+IHVu
aXF1ZSA4Yml0IElEIGFuZCBhIHBvaW50ZXIgdG8gdGhlIGVwb2NoLiBXaGVuIHRoZXkgbmVlZCB0
byByZXBvcnQgYQo+Pj4+PiByZXNlZWRpbmcgZXZlbnQgdGhleSB3cml0ZSBhIG5ldyBlcG9jaCB2
YWx1ZSB3aGljaCBpbmNsdWRlcyB0aGUKPj4+Pj4gbm90aWZpZXIgSUQgaW4gdGhlIGZpcnN0IDgg
Yml0cyBhbmQgYW4gaW5jcmVhc2luZyBjb3VudGVyIHZhbHVlIGluIHRoZQo+Pj4+PiByZW1haW5p
bmcgMjQgYml0czoKPj4+Pj4KPj4+Pj4gICAgICAgICAgICAgICAgIFJORyBlcG9jaAo+Pj4+PiAq
LS0tLS0tLS0tLS0tLSotLS0tLS0tLS0tLS0tLS0tLS0tLS0qCj4+Pj4+IHwgbm90aWZpZXIgaWQg
fCBlcG9jaCBjb3VudGVyIHZhbHVlIHwKPj4+Pj4gKi0tLS0tLS0tLS0tLS0qLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKgo+Pj4+PiAgICAgICAgOCBiaXRzICAgICAgICAgICAyNCBiaXRzCj4+Pj4gV2h5
IG5vdCBqdXN0IHVzZSAzMi8zMiBmb3IgYSBmdWxsIDY0Yml0IHZhbHVlLCBvciBiZXR0ZXIgeWV0
LCAyCj4+Pj4gZGlmZmVyZW50IHZhcmlhYmxlcz8gIFdoeSBpcyAzMmJpdHMgYW5kIHBhY2tpbmcg
dGhpbmdzIHRvZ2V0aGVyIGhlcmUKPj4+PiBzb21laG93IHNpbXBsZXI/Cj4+PiBXZSBtYWRlIGl0
IDMyIGJpdHMgc28gdGhhdCB3ZSBjYW4gcmVhZC93cml0ZSBpdCBhdG9taWNhbGx5IGluIGFsbCAz
MmJpdAo+Pj4gYXJjaGl0ZWN0dXJlcy4KPj4+IERvIHlvdSB0aGluayB0aGF0J3Mgbm90IGEgcHJv
YmxlbT8KPj4gV2hhdCAzMmJpdCBwbGF0Zm9ybXMgY2FyZSBhYm91dCB0aGlzIHR5cGUgb2YgaW50
ZXJmYWNlIGF0IGFsbD8KPgo+IEkgdGhpbmssIGFueSAzMmJpdCBwbGF0Zm9ybSB0aGF0IGdldHMg
cmFuZG9tIGJ5dGVzIGZyb20gdGhlIGtlcm5lbC4KCgpXZSdyZSBidWlsZGluZyBhbiBBQkkgaGVy
ZSB0aGF0IGdlbmVyaWNhbGx5IHByb3BhZ2F0ZXMgYW4gYXRvbWljIHdheSBmb3IgCnVzZXIgc3Bh
Y2UgdG8gbGVhcm4gYWJvdXQgYW4gInJuZyBlcG9jaCIuIFNpbmNlIHRoZXJlIGFyZSAzMmJpdCB1
c2VyIApzcGFjZSBhcHBsaWNhdGlvbnMgb3V0IHRoZXJlIHdob3NlIGV4ZWN1dGluZyBWTXMgY2Fu
IGJlIGNsb25lZCBvciB0aGF0IAp3YW50IHRvIGxlYXJuIGFib3V0IHJlZ3VsYXIgZXBvY2ggY2hh
bmdlcyAoaTM4NiwgYXJtMzIsIDMyYml0IHJpc2N2LCAKZXRjKSwgd2UgbmVlZCB0byBtYWtlIHN1
cmUgd2UgaGF2ZSBhIHZpYWJsZSB3YXkgZm9yIHRoZW0gdG8gY29uc3VtZSB0aGUgCkFCSSBhcyB3
ZWxsLiBUaGlzIGFwcGxpZXMgdG8gMzJiaXQgdXNlciBzcGFjZSAtIHRoZSBrZXJuZWwgbWF5IGFz
IHdlbGwgCnJ1biA2NGJpdCBsaWtlIGEgdHlwaWNhbCBhYXJjaDY0IHNldHVwIHRvZGF5LgoKV2Ug
Y291bGQgb2YgY291cnNlIGJ1aWxkIHRoaXMgQUJJIHdpdGggYSAibG9uZyIgbm90aW9uIGluIG1p
bmQuIEJ1dCB0aGVuIAp5b3Ugd291bGQgZ2V0IGFuIGlvY3RsIHRvIGEga2VybmVsIGRhdGEgc3Ry
dWN0dXJlIHRoYXQgaXMgNjRiaXQsIGV2ZW4gCndpdGggQ09ORklHX0NPTVBBVC4gU28gbm93IHdl
J2QgaGF2ZSB0byBidWlsZCB3cmFwcGVycyBhbmQgbWFpbnRhaW4gMiAKc3RydWN0dXJlcyBmb3Ig
MzJiaXQgYW5kIDY0Yml0IHVzZXIgc3BhY2UgYW5kIGV2ZXJ5dGhpbmcgd291bGQgYmVjb21lIApz
dXBlciBjb21wbGljYXRlZC4KClRoZXNlIGV2ZW50cyB3b24ndCBoYXBwZW4gdmVyeSBvZnRlbi4g
MjRiaXRzIGlzIHZlcnkgbGlrZWx5IGVhc2lseSAKc3VmZmljaWVudCB0byBub3QgZXZlciByYWNl
IGJldHdlZW4gc29tZW9uZSBzZXR0aW5nIGEgbmV3IGVwb2NoIGFuZCAKc29tZW9uZSByZWFkaW5n
IHRoZSBlcG9jaCB2YWx1ZS4gU28gYnkga2VlcGluZyBpdCAzMmJpdCwgd2UgbWFrZSBpdCAKZ3Vh
cmFudGVlZCBhdG9taWMgb24gYWxsIHRhcmdldHMgYW5kIGNvbXBsZXRlbHkgcmVtb3ZlIGFueSBD
T05GSUdfQ09NUEFUIAp3b2VzLgoKCkFsZXgKCgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVy
IEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhy
dW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGlu
ClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=

