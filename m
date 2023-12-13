Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0C812317
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442801AbjLMXg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442678AbjLMXgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:36:49 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD81DB;
        Wed, 13 Dec 2023 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702510616; x=1734046616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uhcOfQRbinzPEwd7PFn+5HZ7ZrYv/GL0E6TNEd2zF1E=;
  b=ZEbblJwaGxqLUn09tej+FOS0JpRaYNKsLJhkMVp5ABlllF3Xo0P9mayw
   OEMPMPOoYbEDzdT+ao77aSAkBOjBArMCmrdm2TxZFK6MG1R+WdnBWBeOv
   nU05nInXPcbZ7cBGMLkby279QDgFSIcKIjwpiM+1GOYyUS1shKGWPzrrQ
   4=;
X-IronPort-AV: E=Sophos;i="6.04,274,1695686400"; 
   d="scan'208";a="317067437"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:36:46 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id BC6F1A0F68;
        Wed, 13 Dec 2023 23:36:41 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:7953]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id f9b5748f-49e6-459d-89c3-cedde6930958; Wed, 13 Dec 2023 23:36:41 +0000 (UTC)
X-Farcaster-Flow-ID: f9b5748f-49e6-459d-89c3-cedde6930958
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 23:36:40 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 23:36:34 +0000
Message-ID: <6748dc7e-534e-4b45-8fa9-052fae591534@amazon.com>
Date:   Thu, 14 Dec 2023 00:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] kexec: Add Kexec HandOver (KHO) generation helpers
Content-Language: en-US
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        James Gowans <jgowans@amazon.com>, <arnd@arndb.de>,
        <pbonzini@redhat.com>, <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-4-graf@amazon.com>
 <20231213183614.GA14669@skinsburskii.>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <20231213183614.GA14669@skinsburskii.>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
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

Ck9uIDEzLjEyLjIzIDE5OjM2LCBTdGFuaXNsYXYgS2luc2J1cnNraWkgd3JvdGU6Cj4gT24gV2Vk
LCBEZWMgMTMsIDIwMjMgYXQgMTI6MDQ6NDBBTSArMDAwMCwgQWxleGFuZGVyIEdyYWYgd3JvdGU6
Cj4+ICtpbnQgcmVnaXN0ZXJfa2hvX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIp
Cj4+ICt7Cj4+ICsgICAgIHJldHVybiBibG9ja2luZ19ub3RpZmllcl9jaGFpbl9yZWdpc3Rlcigm
a2hvLmNoYWluX2hlYWQsIG5iKTsKPj4gK30KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKHJlZ2lzdGVy
X2tob19ub3RpZmllcik7Cj4+ICsKPj4gK2ludCB1bnJlZ2lzdGVyX2tob19ub3RpZmllcihzdHJ1
Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKQo+PiArewo+PiArICAgICByZXR1cm4gYmxvY2tpbmdfbm90
aWZpZXJfY2hhaW5fdW5yZWdpc3Rlcigma2hvLmNoYWluX2hlYWQsIG5iKTsKPj4gK30KPj4gK0VY
UE9SVF9TWU1CT0xfR1BMKHVucmVnaXN0ZXJfa2hvX25vdGlmaWVyKTsKPj4gKwo+PiArYm9vbCBr
aG9faXNfYWN0aXZlKHZvaWQpCj4+ICt7Cj4+ICsgICAgIHJldHVybiBraG8uYWN0aXZlOwo+PiAr
fQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoa2hvX2lzX2FjdGl2ZSk7Cj4+ICsKPiBXaHkgc2hvdWxk
IHRoZXNlIGhlbHBlcnMgYmUgcmVzdHJpY3RlZCB0byBHUEwgY29kZT8KCgpUaGF0J3MgYSBzaW1w
bGUgb25lOiBFdmVyeXRoaW5nIHNob3VsZCBiZSBFWFBPUlRfU1lNQk9MX0dQTCBieSBkZWZhdWx0
LiAKWW91IG5lZWQgdG8gaGF2ZSByZWFsbHkgZ29vZCByZWFzb25zIHRvIGV4cG9ydCBhbnl0aGlu
ZyBmb3Igbm9uLUdQTCAKbW9kdWxlcy4gSSBkb24ndCBoYXZlIGEgZ29vZCByZWFzb24gZm9yIHRo
ZW0sIHNvIGl0J3MgR1BMIG9ubHkgOikKCgpBbGV4CgoKCgoKQW1hem9uIERldmVsb3BtZW50IENl
bnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNm
dWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4g
YW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJl
cmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

