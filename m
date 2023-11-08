Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004A87E5C09
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjKHRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjKHRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:11:56 -0500
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8E51FFB;
        Wed,  8 Nov 2023 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699463514; x=1730999514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6cb/isVwYpy7SG+g9mvglOgKJl2fHKbFOFR6QXMe2MM=;
  b=eA7azvDO7xqJ3yYVMfc/7IjPcxPXBnIICWCyRqpGY84L+5eHd9NxP4Yd
   llp+lwQrTOJkLTnR4xtOSZY/qxhchsU4G/K8CkJSBlL/8uhz3Y3lRKLEY
   Yijb6lLklgdMy2fNvt+IzCQQP9Qk676VGAVjYR4Xgl8ewxyzik578mPJs
   E=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="42072586"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 17:11:46 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id BEBB248DB1;
        Wed,  8 Nov 2023 17:11:42 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:15788]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.121:2525] with esmtp (Farcaster)
 id e2b71a98-94b7-4b71-82ed-2cb1b7312c2f; Wed, 8 Nov 2023 17:11:41 +0000 (UTC)
X-Farcaster-Flow-ID: e2b71a98-94b7-4b71-82ed-2cb1b7312c2f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 17:11:40 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 17:11:36 +0000
Message-ID: <4eb50ee5-fd5e-4dc1-bee1-629da687bdb5@amazon.com>
Date:   Wed, 8 Nov 2023 18:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 29/33] KVM: VMX: Save instruction length on EPT violation
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
CC:     Nicolas Saenz Julienne <nsaenz@amazon.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <pbonzini@redhat.com>, <vkuznets@redhat.com>, <anelkz@amazon.com>,
        <dwmw@amazon.co.uk>, <jgowans@amazon.com>, <corbert@lwn.net>,
        <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <decui@microsoft.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20231108111806.92604-1-nsaenz@amazon.com>
 <20231108111806.92604-30-nsaenz@amazon.com>
 <2573d04d-feff-4119-a79c-dbf9b85e62fd@amazon.com>
 <ZUu0FzbW5tr2Werz@google.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <ZUu0FzbW5tr2Werz@google.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDA4LjExLjIzIDE3OjE1LCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOgo+Cj4gT24gV2Vk
LCBOb3YgMDgsIDIwMjMsIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+PiBPbiAwOC4xMS4yMyAxMjox
OCwgTmljb2xhcyBTYWVueiBKdWxpZW5uZSB3cm90ZToKPj4+IFNhdmUgdGhlIGxlbmd0aCBvZiB0
aGUgaW5zdHJ1Y3Rpb24gdGhhdCB0cmlnZ2VyZWQgYW4gRVBUIHZpb2xhdGlvbiBpbgo+Pj4gc3Ry
dWN0IGt2bV92Y3B1X2FyY2guIFRoaXMgd2lsbCBiZSB1c2VkIHRvIHBvcHVsYXRlIEh5cGVyLVYg
VlNNIG1lbW9yeQo+Pj4gaW50ZXJjZXB0IG1lc3NhZ2VzLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6
IE5pY29sYXMgU2FlbnogSnVsaWVubmUgPG5zYWVuekBhbWF6b24uY29tPgo+Pgo+PiBJbiB2MSwg
cGxlYXNlIGRvIHRoaXMgZm9yIFNWTSBhcyB3ZWxsIDopCj4gV2h5PyAgS1ZNIGNhY2hlcyB2YWx1
ZXMgb24gVk1YIGJlY2F1c2UgVk1SRUFEIGlzIG1lYXN1cmFibGUgc2xvd2VyIHRoYW4gbWVtb3J5
Cj4gYWNjZXNzZXMsIGVzcGVjaWFsbHkgd2hlbiBydW5uaW5nIG5lc3RlZC4gIFNWTSBoYXMgbm8g
c3VjaCBwcm9ibGVtcy4gIEkgd291bGRuJ3QKPiBiZSBzdXJwcmlzZWQgaWYgYWRkaW5nIGEgImNh
Y2hlIiBpcyBhY3R1YWxseSBsZXNzIHBlcmZvcm1hbnQgZHVlIHRvIGluY3JlYXNlZAo+IHByZXNz
dXJlIGFuZCBtaXNzZXMgb24gdGhlIGhhcmR3YXJlIGNhY2hlLgoKCk15IHVuZGVyc3RhbmRpbmcg
d2FzIHRoYXQgdGhpcyBwYXRjaCB3YXNuJ3QgYWJvdXQgY2FjaGluZyBpdCwgaXQgd2FzIAphYm91
dCBzdG9yaW5nIGl0IHNvbWV3aGVyZSBnZW5lcmljYWxseSBzbyB3ZSBjYW4gdXNlIGl0IGZvciB0
aGUgZmF1bHQgCmluamVjdGlvbiBjb2RlIHBhdGggaW4gdGhlIGZvbGxvd2luZyBwYXRjaC4gQW5k
IGlmIHdlIGRvbid0IHNldCB0aGlzIAp2YXJpYWJsZSBmb3IgU1ZNLCBpdCBqdXN0IG1lYW5zIENy
ZWRlbnRpYWwgR3VhcmQgZmF1bHQgaW5qZWN0aW9uIHdvdWxkIApiZSBicm9rZW4gdGhlcmUuCgoK
QWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0
ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdl
ciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1
cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5
CgoK

