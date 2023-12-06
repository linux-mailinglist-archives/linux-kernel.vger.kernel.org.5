Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB94807A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442929AbjLFV3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379643AbjLFV3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:29:32 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305E9A;
        Wed,  6 Dec 2023 13:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701898179; x=1733434179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5HJP+OvAweUdlyGi6FjxSOpC7bXvuAVZyiPxqhEDhgk=;
  b=iFw/PJZXmEm24WyvgENakFBq97km5lUcBbPerx2jJ6OBMkj5Bq0xmZYx
   j5vlky5IdrvqgfylrUf2KGIgQvvdpsIhPkq0F7LDFZ015ZUf64RccSBRi
   a82VfQll22REqukpqO67Ncr5wJOid8pFdzE0bL93/1C0ejACIgDSh2REK
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="257298014"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 21:29:36 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 9C941A1429;
        Wed,  6 Dec 2023 21:29:35 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:14960]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.163:2525] with esmtp (Farcaster)
 id 374507ae-c91b-4abe-b8d4-79d3953b12f9; Wed, 6 Dec 2023 21:29:35 +0000 (UTC)
X-Farcaster-Flow-ID: 374507ae-c91b-4abe-b8d4-79d3953b12f9
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 21:29:34 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 21:29:32 +0000
Message-ID: <1ab3656e-bfed-441a-aa8c-c3bd816303e1@amazon.com>
Date:   Wed, 6 Dec 2023 22:29:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initramfs: Expose retained initrd as sysfs file
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jan_H=2ESch=C3=B6nherr?= <jschoenh@amazon.de>,
        James Gowans <jgowans@amazon.com>
References: <20231206141627.91659-1-graf@amazon.com>
 <20231206120020.215a51251cba5a2c4fa51df2@linux-foundation.org>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <20231206120020.215a51251cba5a2c4fa51df2@linux-foundation.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
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

Ck9uIDA2LjEyLjIzIDIxOjAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOgo+IE9uIFdlZCwgNiBEZWMg
MjAyMyAxNDoxNjoyNyArMDAwMCBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPiB3cm90
ZToKPgo+PiBXaGVuIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIG9wdGlvbiAicmV0YWluX2luaXRy
ZCIgaXMgc2V0LCB3ZSBkbyBub3QKPj4gZnJlZSB0aGUgaW5pdHJkIG1lbW9yeS4gSG93ZXZlciwg
d2UgYWxzbyBkb24ndCBleHBvc2UgaXQgdG8gYW55b25lIGZvcgo+PiBjb25zdW1wdGlvbi4gVGhh
dCBsZWF2ZXMgdXMgaW4gYSB3ZWlyZCBzaXR1YXRpb24gd2hlcmUgdGhlIG9ubHkgdXNlciBvZgo+
PiB0aGlzIGZlYXR1cmUgaXMgcHBjNjQgYW5kIGFybTY0IHNwZWNpZmljIGtleGVjIHRvb2xpbmcu
Cj4+Cj4+IFRvIG1ha2UgaXQgbW9yZSBnZW5lcmFsbHkgdXNlZnVsLCB0aGlzIHBhdGNoIGFkZHMg
YSBrb2JqZWN0IHRvIHRoZQo+PiBmaXJtd2FyZSBvYmplY3QgdGhhdCBjb250YWlucyB0aGUgaW5p
dHJkIGNvbnRleHQgd2hlbiAicmV0YWluX2luaXRyZCIKPj4gaXMgc2V0LiBUaGF0IHdheSwgd2Ug
Y2FuIGFjY2VzcyB0aGUgaW5pdHJkIGFueSB0aW1lIGFmdGVyIGJvb3QgZnJvbQo+PiB1c2VyIHNw
YWNlIGFuZCBmb3IgZXhhbXBsZSBoYW5kIGl0IGludG8ga2V4ZWMgYXMgLS1pbml0cmQgcGFyYW1l
dGVyCj4+IGlmIHdlIHdhbnQgdG8gcmVib290IHRoZSBzYW1lIGluaXRyZC4gT3IgaW5zcGVjdCBp
dCBkaXJlY3RseSBsb2NhbGx5Lgo+IEkgdGhpbmsgaXQgd291bGQgYmUgaGVscGZ1bCBpZiB0aGUg
Y2hhbmdlbG9nIHdlcmUgbWVudGlvbiBhbmQgZGVzY3JpYmUKPiB0aGUgbmV3IC9zeXMvZmlybXdh
cmUvaW5pdHJkLiAgQW5kIEkgYXNzdW1lIHdlIHNob3VsZCBhZGQgYQo+IERvY3VtZW50YXRpb24v
QUJJL3Rlc3Rpbmcvc3lzZnMtZmlybXdhcmUtaW5pdHJkLgoKClRoYW5rcyBhIGJ1bmNoIGZvciB0
aGUgc3VnZ2VzdGlvbnMgLSBsZXQgbWUgc2VuZCB2MiB3aXRoIGJvdGggYWRkcmVzc2VkIDopCgpB
bGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3Ry
LiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2Vy
LCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkK
Cgo=

