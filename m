Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB62D7761BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjHINxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHINxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:53:31 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5962C98;
        Wed,  9 Aug 2023 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691589210; x=1723125210;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=OUBat+eOsR3CCEjoEMsTCONQ8oyZyVeHtb78yKR1Wwg=;
  b=cbxTOqZPBWmu2d1phJWlw8ce5ciVDcfOZ9Kizytd4wxevZ+1HNeNXram
   saTZnhSQT01+ag6lR5Qa+vQmiqwbuGWM/Dy6y3FUBRmUUrXIWrtJlsLiR
   Vlds/S9gYmHFp0s34oEdGhaS4gDhTDiqmSqZxhS55q7RvIYHrcqu4t+6I
   8=;
X-IronPort-AV: E=Sophos;i="6.01,159,1684800000"; 
   d="scan'208";a="299245934"
Subject: Re: [PATCH v3] tun: avoid high-order page allocation for packet header
Thread-Topic: [PATCH v3] tun: avoid high-order page allocation for packet header
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 13:53:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 23A0840D84;
        Wed,  9 Aug 2023 13:53:27 +0000 (UTC)
Received: from EX19D019UWA002.ant.amazon.com (10.13.139.58) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 13:53:26 +0000
Received: from EX19D019UWA004.ant.amazon.com (10.13.139.126) by
 EX19D019UWA002.ant.amazon.com (10.13.139.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 13:53:26 +0000
Received: from EX19D019UWA004.ant.amazon.com ([fe80::445f:a79:89eb:e469]) by
 EX19D019UWA004.ant.amazon.com ([fe80::445f:a79:89eb:e469%5]) with mapi id
 15.02.1118.030; Wed, 9 Aug 2023 13:53:26 +0000
From:   "Erdogan, Tahsin" <trdgn@amazon.com>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHZyk1ebw+gr/DvI0KHqeK6A40M0q/h81YAgAAJzAA=
Date:   Wed, 9 Aug 2023 13:53:26 +0000
Message-ID: <fc219fe5f8c8dec66a6fdff08f40acf714b8328b.camel@amazon.com>
References: <20230808230920.1944738-1-trdgn@amazon.com>
         <64d3921ed1f1a_267bde294f2@willemb.c.googlers.com.notmuch>
In-Reply-To: <64d3921ed1f1a_267bde294f2@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.135.199.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8574F8D58843AA4284B37FF4E1D99DAF@amazon.com>
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

T24gV2VkLCAyMDIzLTA4LTA5IGF0IDA5OjE4IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBUdW4gc2VuZG1zZyBpcyBhIHNwZWNpYWwgY2FzZSwgb25seSB1c2VkIGJ5IHZob3N0LW5l
dCBmcm9tIGluc2lkZSB0aGUNCj4ga2VybmVsLiBBcmd1YWJseSBjb25zaXN0ZW5jeSB3aXRoIHBh
Y2tldF9zbmQvcGFja2V0X2FsbG9jX3NrYiB3b3VsZA0KPiBiZQ0KPiBtb3JlIGltcG9ydGFudC4g
VGhhdCBzYWlkLCB0aGlzIG1ha2VzIHNlbnNlIHRvIG1lLiBJIGFzc3VtZSB5b3VyDQo+IGNvbmZp
Z3VyaW5nIGEgZGV2aWNlIHdpdGggdmVyeSBsYXJnZSBNVFU/DQoNClRoYXQncyByaWdodC4gSSBh
bSBzZXR0aW5nIE1UVSB0byA5MTAwIGluIG15IHRlc3QuDQo=
