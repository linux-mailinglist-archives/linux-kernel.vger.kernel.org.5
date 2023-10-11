Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A362B7C5D56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjJKTB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjJKTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:01:25 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A0BA;
        Wed, 11 Oct 2023 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697050885; x=1728586885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u48bYjMyqhmWB7KVO6HThc3XzrTpvovThwJ6D2RFLps=;
  b=vzBN2m4IEkKIso3yiacZ/YQWmHTRhBvbZdYaF3LPWi1+WBFaCmJjgaOO
   rmYcgsrkL2SEHb045VvAGbLONKIUmIBd92dk3BS8HjRl96/6lJyQrmw1Q
   By/QKPs0J7LYx46d0aOvRmyUOwzFU5agb9rq/ETLkLiDZmZVfLNWLl0cA
   c=;
X-IronPort-AV: E=Sophos;i="6.03,216,1694736000"; 
   d="scan'208";a="612918955"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:01:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 338D640D4A;
        Wed, 11 Oct 2023 19:01:20 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 19:01:19 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 11 Oct
 2023 19:01:17 +0000
Message-ID: <1bd37676-a1ce-4184-a7f7-ba490b24a6fb@amazon.com>
Date:   Wed, 11 Oct 2023 21:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] Import CBOR library
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-2-graf@amazon.com>
 <2023101010-overwrite-parakeet-91d5@gregkh>
 <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
 <2023101009-accustom-manifesto-8bdb@gregkh>
 <b3a8c722-c0e2-4c8c-aef0-29af0a93572d@amazon.com>
 <2023101001-ocelot-veteran-10db@gregkh>
 <2339287b-8b17-413b-aa86-f618ea7fc3fa@app.fastmail.com>
 <2023101156-helper-waving-09df@gregkh>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <2023101156-helper-waving-09df@gregkh>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDExLjEwLjIzIDE5OjQ2LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4KPiBPbiBXZWQs
IE9jdCAxMSwgMjAyMyBhdCAwMjoyNDo0OFBNICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+
PiBPbiBUdWUsIE9jdCAxMCwgMjAyMywgYXQgMTA6MjcsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90
ZToKPj4+IE9uIFR1ZSwgT2N0IDEwLCAyMDIzIGF0IDEwOjA4OjQzQU0gKzAyMDAsIEFsZXhhbmRl
ciBHcmFmIHdyb3RlOgo+Pj4+IE9uIDEwLjEwLjIzIDEwOjAzLCBHcmVnIEtyb2FoLUhhcnRtYW4g
d3JvdGU6Cj4+Pj4KPj4+Pj4+IE91dCBvZiB0aGVzZSwgdGhlIE5TTSBjb21tdW5pY2F0aW9uIHBy
b3RvY29sIHVzZXMgYWxsIGV4Y2VwdCBTZW1hbnRpYyB0YWdzCj4+Pj4+PiBhbmQgRmxvYXRzLiBU
aGUgQ0JPUiBsaWJyYXJ5IHRoYXQgdGhpcyBwYXRjaCBpbXBvcnRzIGRvZXMgbm90IGhhdmUgc3Bl
Y2lhbAo+Pj4+Pj4gaGFuZGxpbmcgZm9yIFNlbWFudGljIHRhZ3MsIHdoaWNoIGxlYXZlcyBvbmx5
IGZsb2F0cyB3aGljaCBhcmUgYWxyZWFkeQo+Pj4+Pj4gI2lmZGVmJ2VkIG91dC4gVGhhdCBtZWFu
cyB0aGVyZSBpcyBub3QgbXVjaCB0byB0cmltLgo+Pj4+Pj4KPj4+Pj4+IFdoYXQgeW91IHNlZSBo
ZXJlIGlzIHdoYXQncyBuZWVkZWQgdG8gcGFyc2UgQ0JPUiBpbiBrZXJuZWwgLSBpZiB0aGF0J3Mg
d2hhdAo+Pj4+Pj4gd2Ugd2FudCB0byBkby4gSSdtIGhhcHB5IHRvIHJpcCBpdCBvdXQgYWdhaW4g
YW5kIG1ha2UgaXQgYSBwdXJlIHVzZXIgc3BhY2UKPj4+Pj4+IHByb2JsZW0gdG8gZG8gQ0JPUiA6
KS4KPj4+Pj4gWWVzLCB3aHkgYXJlIHdlIHBhcnNpbmcgdGhpcyBpbiB0aGUga2VybmVsPyAgV2hh
dCBjb3VsZCBnbyB3cm9uZyB3aXRoCj4+Pj4+IGFkZGluZyB5ZXQtYW5vdGhlci1wYXJzZXIgaW4g
cHJpdmlsZWdlZCBjb250ZXh0PyAgOikKPj4+Pj4KPj4+Pj4gV2h5IGRvZXMgdGhpcyBoYXZlIHRv
IGJlIGluIHRoZSBrZXJuZWwsIHRoZSBkYXRhIHNlbnQvcmVjaWV2ZWQgaXMgb3Zlcgo+Pj4+PiB2
aXJ0aW8sIHNvIHdoeSBkb2VzIHRoZSBrZXJuZWwgaGF2ZSB0byBwYXJzZSBpdD8gIEkgY291bGRu
J3QgZmlndXJlIHRoYXQKPj4+Pj4gb3V0IGZyb20gdGhlIGRyaXZlciwgeWV0IHRoZSBkcml2ZXIg
c2VlbXMgdG8gaGF2ZSBhIGxvdCBvZiBoYXJkLWNvZGVkCj4+Pj4+IHBhcnNpbmcgbG9naWMgaW4g
aXQgdG8gYXNzdW1lIHNwZWNpZmljIG1lc3NhZ2UgZm9ybWF0cz8KPj4+Pgo+Pj4+IFRoZSBwYXJz
aW5nIGRvZXNuJ3QgaGF2ZSB0byBiZSBpbiBrZXJuZWwgYW5kIGl0IHByb2JhYmx5IHNob3VsZG4n
dCBiZQo+Pj4+IGVpdGhlci4gVjMgb2YgdGhlIHBhdGNoIHdhcyBwdW50aW5nIGFsbCB0aGUgcGFy
c2luZyB0byB1c2VyIHNwYWNlLCBhdCB3aGljaAo+Pj4+IHBvaW50IHlvdSBhbmQgQXJuZCBzYWlk
IEkgc2hvdWxkIGdpdmUgaXQgYSB0cnkgdG8gZG8gdGhlIHByb3RvY29sIHBhcnNpbmcgaW4KPj4+
PiBrZXJuZWwgc3BhY2UgaW5zdGVhZC4gVGhhdCdzIHdoeSB0aGUgcGFyc2VyIGlzIGhlcmUuCj4+
PiBBcm5kIHNhaWQgdGhhdCwgbm90IG1lIDopCj4+Pgo+Pj4+IElmIHdlIGNvbmNsdWRlIHRoYXQg
YWxsIHRoaXMgaW4ta2VybmVsIHBhcnNpbmcgaXMgbm90IHdvcnRoIGl0LCBJJ20gdmVyeQo+Pj4+
IGhhcHB5IHRvIGp1c3QgZ28gYmFjayB0byB0aGUgdGhlIHYzIGlvY3RsIGludGVyZmFjZSBhbmQg
cG9zdCB2NSB3aXRoIGh3cm5nCj4+Pj4gbWVyZ2VkIGludG8gbWlzYywgYnV0IHJlbW92ZSBhbGwg
Q0JPUiBsb2dpYyBhZ2FpbiA6KQo+Pj4gSSB0aGluayB0aGUgbGVzcyBwYXJzZXJzIHdlIGhhdmUg
aW4gdGhlIGtlcm5lbCwgdGhlIHNhZmVyIHdlIGFyZSBmb3IKPj4+IG9idmlvdXMgcmVhc29ucy4g
IFVubGVzcyB5b3UgaGF2ZSBhIHBhcnNlciBmb3IgdGhpcyBpbiBydXN0PyAgOikKPj4+Cj4+PiBJ
IGRvbid0IHJlYWxseSBrbm93LCBoYXZpbmcgYSBnZW5lcmljIGludGVyZmFjZSBpcyBnb29kLCBi
dXQgYXQgdGhlCj4+PiBleHBlbnNlIG9mIHRoaXMgYXBpIGlzIHByb2JhYmx5IG5vdCBnb29kLiAg
aW5kaXZpZHVhbCBpb2N0bHMgbWlnaHQgYmUKPj4+IGJldHRlciBpZiB0aGVyZSBhcmUgbm90IGdv
aW5nIHRvIGJlIGFueSBvdGhlciBkcml2ZXJzIGZvciB0aGlzIHR5cGUgb2YKPj4+IHRoaW5nPwo+
PiBJIHdhcyBkZWZpbml0ZWx5IGV4cGVjdGluZyBzb21ldGhpbmcgc2ltcGxlciB0aGFuIHdoYXQg
d2FzIHBvc3NpYmxlCj4+IGluIHRoZSB2NCBwYXRjaC4gSSBoYWQgYW5vdGhlciBsb29rIG5vdywg
YW5kIGl0J3MgY2xlYXIgdGhhdCB0aGUKPj4gaW9jdGwgaW50ZXJmYWNlIGlzIHN0aWxsIG5vdCBn
cmVhdCBiZWNhdXNlIHRoZSB2YXJpYWJsZSBkYXRhIHN0cnVjdHVyZXMKPj4gc2hpbmUgdGhyb3Vn
aCBmb3Igc29tZSBvZiB0aGUgY2FsbHMsIGFuZCBldmVuIHRvIGdldCB0byB0aGlzIHBvaW50LAo+
PiBhIHdob2xlIGxvdCBvZiBjb21wbGV4aXR5IGlzIHJlcXVpcmVkIHVuZGVybmVhdGguCj4+Cj4+
IFRvIGdldCBhbnl0aGluZyBiZXR0ZXIsIG9uZSB3b3VsZCBwcm9iYWJseSBoYXZlIHRvIHJlZGVz
aWduIHRoZSBlbnRpcmUKPj4gaW50ZXJmYWNlIHN0YWNrIChoeXBlcnZpc29yLCBrZXJuZWwgYW5k
IHVzZXJsYW5kKSB0byB1c2UgcmVndWxhcgo+PiBmaXhlZCBkYXRhIHN0cnVjdHVyZXMsIGFuZCB0
aGlzIHNlZW1zIHVubGlrZWx5IHRvIGhhcHBlbi4KPiBXaHkgbm90IGZpeCB0aGlzIGFuZCBkbyBp
dCBwcm9wZXJseT8gIFdoYXQncyBwcmV2ZW50aW5nIHRoYXQgZnJvbQo+IGhhcHBlbmluZz8gIFdl
IGRvbid0IHdhbnQgdG8gY3JlYXRlIGFuIGludGVyZmFjZSBoZXJlIHRoYXQgaXMgYnJva2VuLCBv
cgo+IGluc2VjdXJlLCBvciBhIHBhaW4gdG8gbWFpbnRhaW4sIHJpZ2h0PwoKClRoZSBpbnRlcmZh
Y2UgaXMgbmVpdGhlciBicm9rZW4sIGluc2VjdXJlIG5vciBhIHBhaW4gdG8gbWFpbnRhaW4uIEl0
J3MgCm1lcmVseSBub3QgYXMgcHJldHR5IGFzIGNvdWxkIGJlLiBCdXQgaXQncyB0aGVyZSB0byBz
dGF5IGJlY2F1c2UgaXQncyAKd2hhdCB0aGUgaHlwZXJ2aXNvciBoYXMgYmVlbiBleHBvc2luZyBm
b3IgdGhlIGxhc3QgMiB5ZWFycy4KCkkgYWxzbyBmcmFua2x5IGRvbid0IHRoaW5rIHRoYXQgZG9p
bmcgc3RhdGljIHN0cnVjdHVyZXMgaXMgYW55IG1vcmUgCiJwcm9wZXIiIHRoYW4gd2hhdCB0aGlz
IGludGVyZmFjZSBpcyBkb2luZyB0b2RheS4gSXQncyBzZXJpYWxpemVkIGRhdGEgCm9mIHZhcmlh
YmxlIGxlbmd0aC4gVGhhdCdzIGp1c3QgdGhlIG5hdHVyZSBvZiB0aGUgYmVhc3QgLSB0aGUgYmFj
a2luZyAKZGF0YSBmb3Igc29tZSBvZiB0aGVzZSBvcGVyYXRpb25zICppcyogZHluYW1pYy4KCgpB
bGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3Ry
LiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2Vy
LCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkK
Cgo=

