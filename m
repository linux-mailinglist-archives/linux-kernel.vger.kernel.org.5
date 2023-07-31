Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25B76A475
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGaXEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGaXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:04:30 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED586FB;
        Mon, 31 Jul 2023 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690844671; x=1722380671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rGrKpQGasDWemZ/Sx4rD3/1FcjuM+43n+eprG3zbX2A=;
  b=UGmJrU8m5fxYtxskVCOKQs0VENntB/Xpa6/Hu9qZjDtW2zOIAf5tPzE6
   30d5a2hFNvWS7FDuk9TKInCSnba4cjB6s/PGZvyz9WksZrl1CGmzQQDKp
   nsSb8+UruIT/pqmy1yMK4scehd/pnrckJEftns1me5AeTgqoLdRrU3cNW
   E=;
X-IronPort-AV: E=Sophos;i="6.01,245,1684800000"; 
   d="scan'208";a="230096810"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 23:04:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 4574260C3A;
        Mon, 31 Jul 2023 23:04:29 +0000 (UTC)
Received: from EX19D019UWA004.ant.amazon.com (10.13.139.126) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 23:03:54 +0000
Received: from EX19D019UWA004.ant.amazon.com (10.13.139.126) by
 EX19D019UWA004.ant.amazon.com (10.13.139.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 23:03:19 +0000
Received: from EX19D019UWA004.ant.amazon.com ([fe80::445f:a79:89eb:e469]) by
 EX19D019UWA004.ant.amazon.com ([fe80::445f:a79:89eb:e469%5]) with mapi id
 15.02.1118.030; Mon, 31 Jul 2023 23:03:19 +0000
From:   "Erdogan, Tahsin" <trdgn@amazon.com>
To:     "kuba@kernel.org" <kuba@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tun: avoid high-order page allocation for packet header
Thread-Topic: [PATCH] tun: avoid high-order page allocation for packet header
Thread-Index: AQHZxAMytFP7xwwez0yQ1vHUC8mdSQ==
Date:   Mon, 31 Jul 2023 23:03:19 +0000
Message-ID: <eab96d92e08f63de5a2321571781faf2343802eb.camel@amazon.com>
References: <20230726030936.1587269-1-trdgn@amazon.com>
         <20230731135854.3628918b@kernel.org>
In-Reply-To: <20230731135854.3628918b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.187.170.39]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4599F88F7361FC4FA41DCAB10DCD8E98@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEpha3ViIGZvciBjb25zaWRlcmluZyB0aGlzIHBhdGNoLg0KDQpPbiBNb24sIDIwMjMt
MDctMzEgYXQgMTM6NTggLTA3MDAsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBPbiBUdWUsIDI1
IEp1bCAyMDIzIDIwOjA5OjM2IC0wNzAwIFRhaHNpbiBFcmRvZ2FuIHdyb3RlOg0KPiA+IEBAIC0x
ODM4LDYgKzE4MzgsOSBAQCBzdGF0aWMgc3NpemVfdCB0dW5fZ2V0X3VzZXIoc3RydWN0IHR1bl9z
dHJ1Y3QNCj4gPiAqdHVuLCBzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgKi8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgemVyb2NvcHkgPSBmYWxz
ZTsNCj4gPiAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGlmIChsaW5lYXIgPT0gMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaW5l
YXIgPSBtaW5fdChzaXplX3QsIGdvb2RfbGluZWFyLA0KPiA+IGNvcHlsZW4pOw0KPiANCj4gbml0
OiB3b3VsZCB5b3UgbWluZCBjaGFuZ2luZyB0byAhbGluZWFyIGluc3RlYWQgb2YgbGluZWFyID09
IDAgPw0KDQpZZXMsIEkgd2lsbCBmaXggdGhpcyBpbiB2Mi4NCg0KDQo+IEFsc28gLSBJIGRvbid0
IHNlZSBsaW5lYXIgZXhwbGljaXRseSBnZXR0aW5nIHNldCB0byAwLiBXaGF0DQo+IGd1YXJhbnRl
ZXMNCj4gdGhhdD8gV2hhdCdzIHRoZSBzdG9yeSB0aGVyZT8NCmxpbmVhciBpcyBzZXQgdG8gMCBp
biB0aGUgZWFybGllciBpZiBibG9jay4gV2hlbiBnc28uaGRyX2xlbiBpcyAwLA0KbGluZWFyIGFs
c28gYmVjb21lcyAwOg0KICAgICAgICBpZiAoIXplcm9jb3B5KSB7DQogICAgICAgICAgICAgICAg
Y29weWxlbiA9IGxlbjsNCiAgICAgICAgICAgICAgICBpZiAodHVuMTZfdG9fY3B1KHR1biwgZ3Nv
Lmhkcl9sZW4pID4gZ29vZF9saW5lYXIpDQogICAgICAgICAgICAgICAgICAgICAgICBsaW5lYXIg
PSBnb29kX2xpbmVhcjsNCiAgICAgICAgICAgICAgICBlbHNlDQogICAgICAgICAgICAgICAgICAg
ICAgICBsaW5lYXIgPSB0dW4xNl90b19jcHUodHVuLCBnc28uaGRyX2xlbik7DQogICAgICAgIH0N
Cg==
