Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B840977633A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjHIPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjHIPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:01:35 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919511FF5;
        Wed,  9 Aug 2023 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691593294; x=1723129294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DiprBMaw8ZeBX/+k+AGZEjaYfi/yNQo5mvz8MWBt2/E=;
  b=rNNfJR+KqrOWYlZ5OyHNkiwLwflIp/2nM/cX62HT2bo2/wMVBYZIj8Wh
   nsnF+bpTNcYUwzYJQVIx0Y6qX9BmtwIutVwSdTCfiCSzTRI1Ii4u4nnLd
   66vDhwMbYWrdTO4Z7lu1tUmRV48bpG0SAAXetzMPLJH7cuM5M1K1WT7oN
   U=;
X-IronPort-AV: E=Sophos;i="6.01,159,1684800000"; 
   d="scan'208";a="597746206"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:01:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 388AD60B08;
        Wed,  9 Aug 2023 15:01:32 +0000 (UTC)
Received: from EX19D019UWA003.ant.amazon.com (10.13.139.116) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 15:01:31 +0000
Received: from EX19D019UWA004.ant.amazon.com (10.13.139.126) by
 EX19D019UWA003.ant.amazon.com (10.13.139.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 15:01:31 +0000
Received: from EX19D019UWA004.ant.amazon.com ([fe80::445f:a79:89eb:e469]) by
 EX19D019UWA004.ant.amazon.com ([fe80::445f:a79:89eb:e469%5]) with mapi id
 15.02.1118.030; Wed, 9 Aug 2023 15:01:31 +0000
From:   "Erdogan, Tahsin" <trdgn@amazon.com>
To:     "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tun: avoid high-order page allocation for packet
 header
Thread-Topic: [PATCH v3] tun: avoid high-order page allocation for packet
 header
Thread-Index: AQHZytJhxeluFQL13EmDwC1q708mvA==
Date:   Wed, 9 Aug 2023 15:01:31 +0000
Message-ID: <a257dfa6333fea0d220d51b17b0512327e115060.camel@amazon.com>
References: <20230808230920.1944738-1-trdgn@amazon.com>
         <64d3921ed1f1a_267bde294f2@willemb.c.googlers.com.notmuch>
         <fc219fe5f8c8dec66a6fdff08f40acf714b8328b.camel@amazon.com>
         <64d39c34bbd92_26add629414@willemb.c.googlers.com.notmuch>
In-Reply-To: <64d39c34bbd92_26add629414@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.135.199.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1E832B2176F4A4C989E28E2D288B45E@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTA5IGF0IDEwOjAxIC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBFcmRvZ2FuLCBUYWhzaW4gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIzLTA4LTA5IGF0IDA5
OjE4IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPiA+ID4gVHVuIHNlbmRtc2cgaXMg
YSBzcGVjaWFsIGNhc2UsIG9ubHkgdXNlZCBieSB2aG9zdC1uZXQgZnJvbSBpbnNpZGUNCj4gPiA+
IHRoZQ0KPiA+ID4ga2VybmVsLiBBcmd1YWJseSBjb25zaXN0ZW5jeSB3aXRoIHBhY2tldF9zbmQv
cGFja2V0X2FsbG9jX3NrYg0KPiA+ID4gd291bGQNCj4gPiA+IGJlDQo+ID4gPiBtb3JlIGltcG9y
dGFudC4gVGhhdCBzYWlkLCB0aGlzIG1ha2VzIHNlbnNlIHRvIG1lLiBJIGFzc3VtZSB5b3VyDQo+
ID4gPiBjb25maWd1cmluZyBhIGRldmljZSB3aXRoIHZlcnkgbGFyZ2UgTVRVPw0KPiA+IA0KPiA+
IFRoYXQncyByaWdodC4gSSBhbSBzZXR0aW5nIE1UVSB0byA5MTAwIGluIG15IHRlc3QuDQo+IA0K
PiBNYWtlcyBzZW5zZS4gVGhhdCdzIG5vdCBldmVuIHRoYXQgbGFyZ2UuDQo+IA0KPiBQbGVhc2Ug
YWRkcmVzcyB0aGUgY29tbWl0IG1lc3NhZ2UgcG9pbnRzIGFib3V0IHZpcnRpb19uZXRfaGRyLmhk
cl9sZW4NCj4gYW5kIHdyaXRlKCkgdnMgd3JpdGV2KCkuDQoNClllcywgSSB3aWxsIHVwZGF0ZSBj
b21taXQgbWVzc2FnZSBpbiB2NC4gdGhhbmsgeW91Lg0K
