Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D018096D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjLGXy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjLGXyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:54:23 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A83F1716;
        Thu,  7 Dec 2023 15:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701993268; x=1733529268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vq2hgQkKc3JWcI8xqah9byh9VPaJ7dPrBzSxulqnUPs=;
  b=ALLXMFc2CHm0kjn0/LYTHjDz5i3JoTi+Uo00X6Gaz+dN1h9Jvele8bmm
   hAm6VjAHRueQZx7Gv1UlUz0wio90fUQfBMN5jSP/6Pmw7aKzZ61AXiuTc
   cOYIlUM28N2a2Kg8jXO6TsY+tjpm8vX7xfcDMJD6o+eZTs3nUGeSvwRgG
   8=;
X-IronPort-AV: E=Sophos;i="6.04,259,1695686400"; 
   d="scan'208";a="257600847"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 23:54:25 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id C25D112026E;
        Thu,  7 Dec 2023 23:54:23 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21454]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.7:2525] with esmtp (Farcaster)
 id a231c139-ad19-4ced-a319-ff4bd4500c9d; Thu, 7 Dec 2023 23:54:23 +0000 (UTC)
X-Farcaster-Flow-ID: a231c139-ad19-4ced-a319-ff4bd4500c9d
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 23:54:22 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 23:54:20 +0000
Message-ID: <2a86a7f2-bbf3-43fb-82b9-40d3397d5578@amazon.com>
Date:   Fri, 8 Dec 2023 00:54:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] initramfs: Expose retained initrd as sysfs file
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Linux Documentation <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        James Gowans <jgowans@amazon.com>
References: <20231206213323.78233-1-graf@amazon.com>
 <ZXG8nEEMqorxeM3E@archie.me>
Content-Language: en-US
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <ZXG8nEEMqorxeM3E@archie.me>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFnYXMsCgpPbiAwNy4xMi4yMyAxMzozNywgQmFnYXMgU2FuamF5YSB3cm90ZToKPiBPbiBX
ZWQsIERlYyAwNiwgMjAyMyBhdCAwOTozMzoyM1BNICswMDAwLCBBbGV4YW5kZXIgR3JhZiB3cm90
ZToKPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZmlybXdh
cmUtaW5pdHJkIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1maXJtd2FyZS1pbml0
cmQKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yMGJmN2Nm
NzdhMTkKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5n
L3N5c2ZzLWZpcm13YXJlLWluaXRyZAo+PiBAQCAtMCwwICsxLDggQEAKPj4gK1doYXQ6CQkvc3lz
L2Zpcm13YXJlL2luaXRyZAo+PiArRGF0ZToJCURlY2VtYmVyIDIwMjMKPj4gK0NvbnRhY3Q6CUFs
ZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+Cj4+ICtEZXNjcmlwdGlvbjoKPj4gKwkJV2hl
biB0aGUga2VybmVsIHdhcyBib290ZWQgd2l0aCBhbiBpbml0cmQgYW5kIHRoZQo+PiArCQkicmV0
YWluX2luaXRyZCIgb3B0aW9uIGlzIHNldCBvbiB0aGUga2VybmVsIGNvbW1hbmQKPj4gKwkJbGlu
ZSwgL3N5cy9maXJtd2FyZS9pbml0cmQgY29udGFpbnMgdGhlIGNvbnRlbnRzIG9mIHRoZQo+PiAr
CQlpbml0cmQgdGhhdCB0aGUga2VybmVsIHdhcyBib290ZWQgd2l0aC4KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0IGIvRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQKPj4gaW5kZXggNjU3MzFi
MDYwZTNmLi41MTU3NWNkMzE3NDEgMTAwNjQ0Cj4+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0Cj4+IEBAIC0yNDM4LDcgKzI0MzgsNyBAQAo+PiAg
IAkJCWJldHdlZW4gdW5yZWdpc3RlcmluZyB0aGUgYm9vdCBjb25zb2xlIGFuZCBpbml0aWFsaXpp
bmcKPj4gICAJCQl0aGUgcmVhbCBjb25zb2xlLgo+PiAgIAo+PiAtCWtlZXBpbml0cmQJW0hXLEFS
TV0KPj4gKwlrZWVwaW5pdHJkCVtIVyxBUk1dIFNlZSByZXRhaW5faW5pdHJkLgo+PiAgIAo+PiAg
IAlrZXJuZWxjb3JlPQlbS05MLFg4NixJQS02NCxQUENdCj4+ICAgCQkJRm9ybWF0OiBubltLTUdU
UEVdIHwgbm4lIHwgIm1pcnJvciIKPj4gQEAgLTU1ODAsNyArNTU4MCw4IEBACj4+ICAgCQkJVXNl
ZnVsIGZvciBkZXZpY2VzIHRoYXQgYXJlIGRldGVjdGVkIGFzeW5jaHJvbm91c2x5Cj4+ICAgCQkJ
KGUuZy4gVVNCIGFuZCBNTUMgZGV2aWNlcykuCj4+ICAgCj4+IC0JcmV0YWluX2luaXRyZAlbUkFN
XSBLZWVwIGluaXRyZCBtZW1vcnkgYWZ0ZXIgZXh0cmFjdGlvbgo+PiArCXJldGFpbl9pbml0cmQJ
W1JBTV0gS2VlcCBpbml0cmQgbWVtb3J5IGFmdGVyIGV4dHJhY3Rpb24uIEFmdGVyIGJvb3QsIGl0
IHdpbGwKPj4gKwkJCWJlIGFjY2Vzc2libGUgdmlhIC9zeXMvZmlybXdhcmUvaW5pdHJkLgo+PiAg
IAo+PiAgIAlyZXRibGVlZD0JW1g4Nl0gQ29udHJvbCBtaXRpZ2F0aW9uIG9mIFJFVEJsZWVkIChB
cmJpdHJhcnkKPj4gICAJCQlTcGVjdWxhdGl2ZSBDb2RlIEV4ZWN1dGlvbiB3aXRoIFJldHVybiBJ
bnN0cnVjdGlvbnMpCj4+IGRpZmYgLS1naXQgYS9pbml0L2luaXRyYW1mcy5jIGIvaW5pdC9pbml0
cmFtZnMuYwo+PiBpbmRleCA4ZDBmZDk0NmNkZDIuLjI1MjQ0ZTJhNTczOSAxMDA2NDQKPj4gLS0t
IGEvaW5pdC9pbml0cmFtZnMuYwo+PiArKysgYi9pbml0L2luaXRyYW1mcy5jCj4+IEBAIC01NzQs
NiArNTc0LDE2IEBAIGV4dGVybiB1bnNpZ25lZCBsb25nIF9faW5pdHJhbWZzX3NpemU7Cj4+ICAg
I2luY2x1ZGUgPGxpbnV4L2luaXRyZC5oPgo+PiAgICNpbmNsdWRlIDxsaW51eC9rZXhlYy5oPgo+
PiAgIAo+PiArc3RhdGljIHNzaXplX3QgcmF3X3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVj
dCBrb2JqZWN0ICprb2JqLAo+PiArCQkJc3RydWN0IGJpbl9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIg
KmJ1ZiwKPj4gKwkJCWxvZmZfdCBwb3MsIHNpemVfdCBjb3VudCkKPj4gK3sKPj4gKwltZW1jcHko
YnVmLCBhdHRyLT5wcml2YXRlICsgcG9zLCBjb3VudCk7Cj4+ICsJcmV0dXJuIGNvdW50Owo+PiAr
fQo+PiArCj4+ICtzdGF0aWMgQklOX0FUVFIoaW5pdHJkLCAwNDQwLCByYXdfcmVhZCwgTlVMTCwg
MCk7Cj4+ICsKPj4gICB2b2lkIF9faW5pdCByZXNlcnZlX2luaXRyZF9tZW0odm9pZCkKPj4gICB7
Cj4+ICAgCXBoeXNfYWRkcl90IHN0YXJ0Owo+PiBAQCAtNzE1LDggKzcyNSwxNCBAQCBzdGF0aWMg
dm9pZCBfX2luaXQgZG9fcG9wdWxhdGVfcm9vdGZzKHZvaWQgKnVudXNlZCwgYXN5bmNfY29va2ll
X3QgY29va2llKQo+PiAgIAkgKiBJZiB0aGUgaW5pdHJkIHJlZ2lvbiBpcyBvdmVybGFwcGVkIHdp
dGggY3Jhc2hrZXJuZWwgcmVzZXJ2ZWQgcmVnaW9uLAo+PiAgIAkgKiBmcmVlIG9ubHkgbWVtb3J5
IHRoYXQgaXMgbm90IHBhcnQgb2YgY3Jhc2hrZXJuZWwgcmVnaW9uLgo+PiAgIAkgKi8KPj4gLQlp
ZiAoIWRvX3JldGFpbl9pbml0cmQgJiYgaW5pdHJkX3N0YXJ0ICYmICFrZXhlY19mcmVlX2luaXRy
ZCgpKQo+PiArCWlmICghZG9fcmV0YWluX2luaXRyZCAmJiBpbml0cmRfc3RhcnQgJiYgIWtleGVj
X2ZyZWVfaW5pdHJkKCkpIHsKPj4gICAJCWZyZWVfaW5pdHJkX21lbShpbml0cmRfc3RhcnQsIGlu
aXRyZF9lbmQpOwo+PiArCX0gZWxzZSBpZiAoZG9fcmV0YWluX2luaXRyZCkgewo+PiArCQliaW5f
YXR0cl9pbml0cmQuc2l6ZSA9IGluaXRyZF9lbmQgLSBpbml0cmRfc3RhcnQ7Cj4+ICsJCWJpbl9h
dHRyX2luaXRyZC5wcml2YXRlID0gKHZvaWQgKilpbml0cmRfc3RhcnQ7Cj4+ICsJCWlmIChzeXNm
c19jcmVhdGVfYmluX2ZpbGUoZmlybXdhcmVfa29iaiwgJmJpbl9hdHRyX2luaXRyZCkpCj4+ICsJ
CQlwcl9lcnIoIkZhaWxlZCB0byBjcmVhdGUgaW5pdHJkIHN5c2ZzIGZpbGUiKTsKPj4gKwl9Cj4+
ICAgCWluaXRyZF9zdGFydCA9IDA7Cj4+ICAgCWluaXRyZF9lbmQgPSAwOwo+PiAgIAo+IE9uIG15
IEFyY2ggTGludXggc3lzdGVtLCAvc3lzL2Zpcm13YXJlL2luaXRyZCBpcyBub3Qgc2FtZSBhcyBp
bml0cmFtZnMgaW1hZ2UKPiBmcm9tIC9ib290IHBhcnRpdGlvbiB0aGF0IGlzIHVuY29tcHJlc3Nl
ZC4gYGxzIC1sYCBsaXN0aW5nIHNob3dzCj4gKHdpdGggL3RtcC9pbml0cmFtZnMtYm9vdCBpcyB1
bnpzdGQnZWQgaW5pdHJhbWZzIG9mIHRoZSBzYW1lIGtlcm5lbCBib290ZWQpOgo+Cj4gYGBgCj4g
LXItLXItLS0tLSAxIHJvb3Qgcm9vdCAyMjk2NzUzNSBEZWMgIDcgMTk6MzIgL3N5cy9maXJtd2Fy
ZS9pbml0cmQKPiAtcnctLS0tLS0tIDEgcm9vdCByb290IDQwOTYwMDAwIERlYyAgNyAxOToyNiAv
dG1wL2luaXRyYW1mcy1ib290Cj4gYGBgCj4KPiBBbmQgdGh1cywgYGNwaW8gLWkgLXZgIGxpc3Rp
bmcgZGlmZmVycy4gV2hpbGUgaW4gdW5jb21wcmVzc2VkIGluaXRyYW1mcywKPiBJIGdvdCBleHBl
Y3RlZCBpbml0cmFtZnMgY29udGVudHMgKGVhcmx5IHVzZXJwYWNlIGZvciBib290aW5nKSwgZG9p
bmcgdGhlIHNhbWUKPiB0byAvc3lzL2Zpcm13YXJlL2luaXRyZCBvbmx5IHNob3dzIEludGVsIG1p
Y3JvY29kZS4KPgo+IFJlZ2FyZGxlc3MsIGV4cG9zaW5nIGluaXRyYW1mcyBhcyBhZHZlcnRpc2Vk
IGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiB3b3JrcyBmb3IKPiBtZS4KCgpUaGFua3MgYSBidW5j
aCBmb3IgdGVzdGluZyB0aGUgcGF0Y2ghCgpUaGUgcmVhc29uIHlvdSdyZSBzZWVpbmcgbWljcm9j
b2RlIGlzIHRoYXQgc29tZXRoaW5nIGluIHlvdXIgYm9vdCBjaGFpbiAKKGdydWIgbWF5YmU/IHNk
LWJvb3Q/KSBzZW5kcyBtdWx0aXBsZSBpbml0cmQgYmxvYnMgdG8gTGludXg6IE9uZSB0aGF0IApj
b250YWlucyBtaWNyb2NvZGUgYW5kIGFub3RoZXIgdGhhdCBjb250YWlucyB0aGUgcmVhbCBpbml0
cmQuIExpbnV4IApjb250aW51ZXMgZXh0cmFjdGluZyBwYXN0IHRoZSBmaXJzdCBjcGlvIGFyY2hp
dmUuCgoKQWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAy
MzcgODc5CgoK

