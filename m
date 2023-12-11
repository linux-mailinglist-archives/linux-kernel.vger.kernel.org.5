Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3780C67F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjLKK1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjLKK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:27:19 -0500
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869A1B3;
        Mon, 11 Dec 2023 02:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702290443; x=1733826443;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=uu88w/luOrmMKhh/lVhjbkCtD1EpiHoLlqjWo1AtlNw=;
  b=dAI7VY5jVupXGSCVpvNDNa7lWsgyQD2AQozTJKr735RM7rlkQbNLZz7O
   AEFS0DrObiBJtWxPjLdfNNc4QXHsz/9yY9qAth/JMV9Rg5laZqLBn/Q/d
   BwKOl4KIaTptAPxn9NB8P1VzjkdYBScRopXq8i5eP/Tc/okcZREP0Avry
   g=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="624463210"
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Thread-Topic: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:27:18 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 7582EC0126;
        Mon, 11 Dec 2023 10:27:16 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:22647]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.133:2525] with esmtp (Farcaster)
 id 120ac3af-72bf-44ea-87cd-f3555d0aa2c2; Mon, 11 Dec 2023 10:27:15 +0000 (UTC)
X-Farcaster-Flow-ID: 120ac3af-72bf-44ea-87cd-f3555d0aa2c2
Received: from EX19D012EUC002.ant.amazon.com (10.252.51.162) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 10:27:15 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC002.ant.amazon.com (10.252.51.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 10:27:15 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Mon, 11 Dec 2023 10:27:15 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "Graf (AWS), Alexander" <graf@amazon.de>,
        "seanjc@google.com" <seanjc@google.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        =?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>
CC:     "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>
Thread-Index: AQHaKm9F6TfLvhzSVEeLxKjiUjwNTrCgjTCAgAFn6T+AAcSbgIAAKp8A
Date:   Mon, 11 Dec 2023 10:27:15 +0000
Message-ID: <7e30cfc2359dfef39d038e3734f7e5e3d9e82d68.camel@amazon.com>
References: <20230512233127.804012-1-seanjc@google.com>
         <20230512233127.804012-2-seanjc@google.com>
         <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
         <871qbud5f9.fsf@email.froward.int.ebiederm.org>
         <a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
In-Reply-To: <a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <994E5A9245CB014D9CBFED3CDA08F664@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEyLTExIGF0IDA5OjU0ICswMjAwLCBKYW1lcyBHb3dhbnMgd3JvdGU6DQo+
ID4gDQo+ID4gV2hhdCBwcm9ibGVtIGFyZSB5b3UgcnVubmluZyBpbnRvIHdpdGggeW91ciByZWJh
c2UgdGhhdCB3b3JrZWQgd2l0aA0KPiA+IHJlYm9vdCBub3RpZmllcnMgdGhhdCBpcyBub3Qgd29y
a2luZyB3aXRoIHN5c2NvcmVfc2h1dGRvd24/DQo+IA0KPiBQcmlvciB0byB0aGlzIGNvbW1pdCBb
MV0gd2hpY2ggY2hhbmdlZCBLVk0gZnJvbSByZWJvb3Qgbm90aWZpZXJzIHRvDQo+IHN5c2NvcmVf
b3BzLCBLVk0ncyByZWJvb3Qgbm90aWZpZXIgc2h1dGRvd24gY2FsbGJhY2sgd2FzIGludm9rZWQg
b24NCj4ga2V4ZWMgdmlhIGtlcm5lbF9yZXN0YXJ0X3ByZXBhcmUuDQo+IA0KPiBBZnRlciB0aGlz
IGNvbW1pdCwgS1ZNIGlzIG5vdCBiZWluZyBzaHV0IGRvd24gYmVjYXVzZSBjdXJyZW50bHkgdGhl
DQo+IGtleGVjIGZsb3cgZG9lcyBub3QgY2FsbCBzeXNjb3JlX3NodXRkb3duLg0KDQpJIHRoaW5r
IEkgbWlzc2VkIHdoYXQgeW91J3JlIGFza2luZyBoZXJlOyB5b3UncmUgYXNraW5nIGZvciBhIHJl
cHJvZHVjZXINCmZvciB0aGUgc3BlY2lmaWMgZmFpbHVyZT8gDQoNCjEuIExhdW5jaCBhIFFFTVUg
Vk0gd2l0aCAtZW5hYmxlLWt2bSBmbGFnDQoNCjIuIERvIGFuIGltbWVkaWF0ZSAoLWYgZmxhZykg
a2V4ZWM6DQprZXhlYyAtZiAtLXJldXNlLWNtZGxpbmUgLi9iekltYWdlIA0KDQpTb21ld2hlcmUg
YWZ0ZXIgZG9pbmcgdGhlIFJFVCB0byBuZXcga2VybmVsIGluIHRoZSByZWxvY2F0ZV9rZXJuZWwg
YXNtDQpmdW5jdGlvbiB0aGUgbmV3IGtlcm5lbCBzdGFydHMgdHJpcGxlIGZhdWx0aW5nOyBJIGNh
bid0IGV4YWN0bHkgZmlndXJlDQpvdXQgd2hlcmUgYnV0IEkgdGhpbmsgaXQgaGFzIHRvIGRvIHdp
dGggdGhlIG5ldyBrZXJuZWwgdHJ5aW5nIHRvIG1vZGlmeQ0KQ1IzIHdoaWxlIHRoZSBWTVhFIGJp
dCBpcyBzdGlsbCBzZXQgaW4gQ1I0IGNhdXNpbmcgdGhlIHRyaXBsZSBmYXVsdC4NCg0KSWYgS1ZN
IGhhcyBiZWVuIHNodXQgZG93biB2aWEgdGhlIHNodXRkb3duIGNhbGxiYWNrLCBvciBhbHRlcm5h
dGl2ZWx5IGlmDQp0aGUgUUVNVSBwcm9jZXNzIGhhcyBhY3R1YWxseSBiZWVuIGtpbGxlZCBmaXJz
dCAoYnkgbm90IGRvaW5nIGEgLWYgZXhlYykNCnRoZW4gdGhlIFZNWEUgYml0IGlzIGNsZWFyIGFu
ZCB0aGUga2V4ZWMgZ29lcyBzbW9vdGhseS4NCg0KU28sIFRMO0RSOiBrZXhlYyAtZiB1c2UgdG8g
d29yayB3aXRoIGEgS1ZNIFZNIGFjdGl2ZSwgbm93IGl0IGdvZXMgaW50byBhDQp0cmlwbGUgZmF1
bHQgY3Jhc2guDQoNCkpHDQoNCg==
